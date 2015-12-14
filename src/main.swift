// void outport(unsigned short, unsigned char)
@_silgen_name("outportb") func outportb(_: UInt16, _: UInt8)

public func setCursor(x: UInt16, y: UInt16) {
	let pos = (y * 80) + x
	outportb(0x3D4, 0x0F)
	outportb(0x3D5, UInt8(pos & 0xFF))
	outportb(0x3D4, 0x0E)
	outportb(0x3D5, UInt8(pos >> 8 & 0xFF))
}

@_silgen_name("kmain") public func kmain() {
	let textptr = UnsafeMutablePointer<UInt16>(bitPattern: 0xB8000)

	for var i = 0; i < 80 * 25; i++ {
		textptr[i] = 0x0F00 | 0x00;
	}

	var x = 0
	textptr[x] = 0x0F48; x++
	textptr[x] = 0x0F65; x++
	textptr[x] = 0x0F6C; x++
	textptr[x] = 0x0F6C; x++
	textptr[x] = 0x0F6F; x++
	textptr[x] = 0x0F00; x++
	textptr[x] = 0x0F53; x++
	textptr[x] = 0x0F77; x++
	textptr[x] = 0x0F69; x++
	textptr[x] = 0x0F66; x++
	textptr[x] = 0x0F74; x++
	textptr[x] = 0x0F21; x++

	setCursor(UInt16(x),y:0)
}
