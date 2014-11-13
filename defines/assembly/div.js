var shift               // Global variables.
var addind
var last = ''
var two31 = 0x80000000
var two32 = 0x100000000

function checkEnter(f) {
   /* This is a very flaky way to get "compute" called when the user
   presses the Enter key.  Control comes here after every character is
   entered.  If the string doesn't change, he must have just pressed the
   Enter key.  The "d != ''" check ensures that we don't call
   "compute" if he backspaces when the input is null.  */

   var d = f.divisor.value
   if (d == last && d != '') compute(f)
   last = d
}

function compute(f) {
   var d = f.divisor.value
// Allow blanks, optional sign, 1 or more digits, blanks.
   if (!/^\s*[+-]?\d+\s*$/.test(d)) {
      alert("Enter a valid decimal integer, optionally signed.")
      return
   }
   d = parseInt(d)
   if (Math.abs(d) <= 1) {
      alert("Divisor cannot be 0, +1, or -1.")
      return
   }
   if (d >= two32 || d < -two31) {
      alert("Divisor must be in the range -2**31 to 2**32 - 1.")
      return
   }
   var mag = magic_signed(d)
   f.results1.value = mag + ", hex " + hex8(mag)
   f.results2.value = shift
   mag = magic_unsigned(d)
   f.resultu1.value = mag + ", hex " + hex8(mag)
   f.resultu2.value = shift
   f.resultu3.value = addind
   if (d & 1) {
      mag = mulinv(d)
      f.result3.value = mag + ", hex " + hex8(mag)
   } else
      f.result3.value = "Nonexistent"
}

function magic_signed(d) { with(Math) {
   if (d >= two31) d = d - two32// Treat large positive as short for negative.
   var ad = abs(d)
   var t = two31 + (d >>> 31)
   var anc = t - 1 - t%ad       // Absolute value of nc.
   var p = 31                   // Init p.
   var q1 = floor(two31/anc)    // Init q1 = 2**p/|nc|.
   var r1 = two31 - q1*anc      // Init r1 = rem(2**p, |nc|).
   var q2 = floor(two31/ad)     // Init q2 = 2**p/|d|.
   var r2 = two31 - q2*ad       // Init r2 = rem(2**p, |d|).
   do {
      p = p + 1;
      q1 = 2*q1;                // Update q1 = 2**p/|nc|.
      r1 = 2*r1;                // Update r1 = rem(2**p, |nc|.
      if (r1 >= anc) {          // (Must be an unsigned
         q1 = q1 + 1;           // comparison here).
         r1 = r1 - anc;}
      q2 = 2*q2;                // Update q2 = 2**p/|d|.
      r2 = 2*r2;                // Update r2 = rem(2**p, |d|.
      if (r2 >= ad) {           // (Must be an unsigned
         q2 = q2 + 1;           // comparison here).
         r2 = r2 - ad;}
      var delta = ad - r2;
   } while (q1 < delta || (q1 == delta && r1 == 0))

   var mag = q2 + 1
   if (d < 0) mag = two32 - mag // Magic number and
   shift = p - 32               // shift amount to return.
   return mag
}}

function magic_unsigned(d) { with(Math) {
   if (d < 0) d = two32 + d     // Treat negative as short for large pos.
   addind = 0;                  // Initialize "add" indicator.
   nc = two32 - 1 - (two32 - d)%d;
   var p = 31;                  // Init. p.
   var q1 = floor(0x80000000/nc)// Init. q1 = 2**p/nc.
   var r1 = 0x80000000 - q1*nc  // Init. r1 = rem(2**p, nc).
   var q2 = floor(0x7FFFFFFF/d) // Init. q2 = (2**p - 1)/d.
   var r2 = 0x7FFFFFFF - q2*d   // Init. r2 = rem(2**p - 1, d).
   do {
      p = p + 1;
      if (r1 >= nc - r1) {
         q1 = 2*q1 + 1;         // Update q1.
         r1 = 2*r1 - nc;}       // Update r1.
      else {
         q1 = 2*q1;
         r1 = 2*r1;}
      if (r2 + 1 >= d - r2) {
         if (q2 >= 0x7FFFFFFF) addind = 1;
         q2 = 2*q2 + 1;         // Update q2.
         r2 = 2*r2 + 1 - d;}    // Update r2.
      else {
         if (q2 >= 0x80000000) addind = 1;
         q2 = 2*q2;
         r2 = 2*r2 + 1;}
      delta = d - 1 - r2;
   } while (p < 64 &&
           (q1 < delta || (q1 == delta && r1 == 0)));

   var magu = q2 + 1                      // Magic number
   if (magu >= two32) magu = magu - two32 // and shift amount
   shift = p - 32                         // to return
   return magu                            // (addind was set above).
}}

function mulinv(d) { with(Math) {       // Calculates the multiplicative
                                        // inverse mod 2**32 for odd d,
                                        // by Newton's method.
   if (d < 0) d = two32 + d     // Treat negative as short for large pos.
   var xn = d;
   while ((t = mul32u(d, xn)) != 1) {
      xn = mul32u(xn, 2 - t)
   }
   return xn
}}

function mul32u(x, y) {
   /* This function simulates a computer's 32x32 ==> 32 multiplication
   instruction.  It takes the rightmost 32 bits of integers x and y,
   multiplies them as a 32-bit machine would, reduces the product modulo
   2**32, and returns the result interpreting it as an unsigned number.
   Negative inputs are ok, but caution:  (-1)*(1) = 4294967295, although
   (-1)*(-1) = 1.
      You might think this could be computed as simply
   (x*y)%0x100000000.  However, when JavaScript computes x*y, it puts
   the result in the 52-bit field of a double-precision floating-point
   number, and loses LOW ORDER bits in the process. */

   var a = x >>> 16
   var b = x & 0xFFFF
   var c = y >>> 16
   var d = y & 0xFFFF

   var p = b*d + (a*d << 16) + (b*c << 16)
   if (p > 0xFFFFFFFF) p = p - 0x100000000
   else if (p < 0) p = p + 0x100000000
   return p
}

function hex8(n) {
   var translate = "0123456789ABCDEF"
   var s = ""
   for (var i = 0; i < 8; i++) {
      s = translate.substr(n&15, 1) + s
      if (i == 3) s = ' ' + s
      n = n >> 4;
   }
   return s
}
