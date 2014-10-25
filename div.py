shift = None
addint = None
last = ''
two31 = 0x80000000
two32 = 0x100000000

def compute(divisor):
    divisor = parse_int(divisor)
    if abs(divisor) <= 1:
        print 'Divisor can not be 0, 1 or -1!'
        return
    if not (two32 > divisor >= -two31):
        print 'Divisor must be in range -2**31 to 2**32 -1'
        return
    magic = magic_signed(divisor)
    print magic, hex8(magic), shift
    magic = magic_unsigned(divisor)
    print magic, hex8(magic), shift
    print addint
    if d & 1:
        magic = mulinv(divisor)
        print magic, hex8(magic)
    else:
        print 'Nonexistent'

def magic_signed(divisor):
    ad = abs(divisor)
    t = two31 + (d >> 31)
    anc = t - 1 - t%ad
    p = 31
    q1 = math.floor(two31/anc)
    r1 = two31 - q1*anc
    q2 = math.floor(two31/ad)
    r2 = two31 - q2*ad
    while q1 < delta or (q1 == delta and r1 == 0):
