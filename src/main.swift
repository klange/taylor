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
}
