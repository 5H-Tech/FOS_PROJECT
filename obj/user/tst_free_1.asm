
obj/user/tst_free_1:     file format elf32-i386


Disassembly of section .text:

00800020 <_start>:
// starts us running when we are initially loaded into a new environment.
.text
.globl _start
_start:
	// See if we were started with arguments on the stack
	mov $0, %eax
  800020:	b8 00 00 00 00       	mov    $0x0,%eax
	cmpl $USTACKTOP, %esp
  800025:	81 fc 00 e0 bf ee    	cmp    $0xeebfe000,%esp
	jne args_exist
  80002b:	75 04                	jne    800031 <args_exist>

	// If not, push dummy argc/argv arguments.
	// This happens when we are loaded by the kernel,
	// because the kernel does not know about passing arguments.
	pushl $0
  80002d:	6a 00                	push   $0x0
	pushl $0
  80002f:	6a 00                	push   $0x0

00800031 <args_exist>:

args_exist:
	call libmain
  800031:	e8 b9 16 00 00       	call   8016ef <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
	char a;
	short b;
	int c;
};

void _main(void) {
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	81 ec 40 01 00 00    	sub    $0x140,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  800043:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
//				fullWS = 0;
//				break;
//			}
//		}

		cprintf("PWS size = %d\n", LIST_SIZE(&(myEnv->PageWorkingSetList)));
  800047:	a1 20 40 80 00       	mov    0x804020,%eax
  80004c:	8b 80 9c 3c 01 00    	mov    0x13c9c(%eax),%eax
  800052:	83 ec 08             	sub    $0x8,%esp
  800055:	50                   	push   %eax
  800056:	68 80 34 80 00       	push   $0x803480
  80005b:	e8 76 1a 00 00       	call   801ad6 <cprintf>
  800060:	83 c4 10             	add    $0x10,%esp
		if (LIST_SIZE(&(myEnv->PageWorkingSetList)) > 0) {
  800063:	a1 20 40 80 00       	mov    0x804020,%eax
  800068:	8b 80 9c 3c 01 00    	mov    0x13c9c(%eax),%eax
  80006e:	85 c0                	test   %eax,%eax
  800070:	74 04                	je     800076 <_main+0x3e>
			fullWS = 0;
  800072:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
		}
		if (fullWS)
  800076:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  80007a:	74 14                	je     800090 <_main+0x58>
			panic("Please increase the WS size");
  80007c:	83 ec 04             	sub    $0x4,%esp
  80007f:	68 8f 34 80 00       	push   $0x80348f
  800084:	6a 1e                	push   $0x1e
  800086:	68 ab 34 80 00       	push   $0x8034ab
  80008b:	e8 a4 17 00 00       	call   801834 <_panic>
	}

	int Mega = 1024 * 1024;
  800090:	c7 45 e0 00 00 10 00 	movl   $0x100000,-0x20(%ebp)
	int kilo = 1024;
  800097:	c7 45 dc 00 04 00 00 	movl   $0x400,-0x24(%ebp)
	char minByte = 1 << 7;
  80009e:	c6 45 db 80          	movb   $0x80,-0x25(%ebp)
	char maxByte = 0x7F;
  8000a2:	c6 45 da 7f          	movb   $0x7f,-0x26(%ebp)
	short minShort = 1 << 15;
  8000a6:	66 c7 45 d8 00 80    	movw   $0x8000,-0x28(%ebp)
	short maxShort = 0x7FFF;
  8000ac:	66 c7 45 d6 ff 7f    	movw   $0x7fff,-0x2a(%ebp)
	int minInt = 1 << 31;
  8000b2:	c7 45 d0 00 00 00 80 	movl   $0x80000000,-0x30(%ebp)
	int maxInt = 0x7FFFFFFF;
  8000b9:	c7 45 cc ff ff ff 7f 	movl   $0x7fffffff,-0x34(%ebp)
	short *shortArr, *shortArr2;
	int *intArr;
	struct MyStruct *structArr;
	int lastIndexOfByte, lastIndexOfByte2, lastIndexOfShort, lastIndexOfShort2,
			lastIndexOfInt, lastIndexOfStruct;
	int start_freeFrames = sys_calculate_free_frames();
  8000c0:	e8 50 2c 00 00       	call   802d15 <sys_calculate_free_frames>
  8000c5:	89 45 c8             	mov    %eax,-0x38(%ebp)
	int toAccess = 800 - LIST_SIZE(&myEnv->ActiveList) - 8;
  8000c8:	a1 20 40 80 00       	mov    0x804020,%eax
  8000cd:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  8000d3:	ba 18 03 00 00       	mov    $0x318,%edx
  8000d8:	29 c2                	sub    %eax,%edx
  8000da:	89 d0                	mov    %edx,%eax
  8000dc:	89 45 c4             	mov    %eax,-0x3c(%ebp)

	void* ptr_allocations[20] = { 0 };
  8000df:	8d 95 c8 fe ff ff    	lea    -0x138(%ebp),%edx
  8000e5:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000ea:	b8 00 00 00 00       	mov    $0x0,%eax
  8000ef:	89 d7                	mov    %edx,%edi
  8000f1:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		//2 MB
		int usedDiskPages = sys_pf_calculate_allocated_pages();
  8000f3:	e8 a0 2c 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  8000f8:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[0] = malloc(2 * Mega - kilo);
  8000fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000fe:	01 c0                	add    %eax,%eax
  800100:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800103:	83 ec 0c             	sub    $0xc,%esp
  800106:	50                   	push   %eax
  800107:	e8 54 27 00 00       	call   802860 <malloc>
  80010c:	83 c4 10             	add    $0x10,%esp
  80010f:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)

		if ((uint32) ptr_allocations[0] < (USER_HEAP_START)
  800115:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  80011b:	85 c0                	test   %eax,%eax
  80011d:	79 0d                	jns    80012c <_main+0xf4>
				|| (uint32) ptr_allocations[0] > (USER_HEAP_START + PAGE_SIZE))
  80011f:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  800125:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  80012a:	76 14                	jbe    800140 <_main+0x108>
			panic(
  80012c:	83 ec 04             	sub    $0x4,%esp
  80012f:	68 c0 34 80 00       	push   $0x8034c0
  800134:	6a 3c                	push   $0x3c
  800136:	68 ab 34 80 00       	push   $0x8034ab
  80013b:	e8 f4 16 00 00       	call   801834 <_panic>
					"Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512)
  800140:	e8 53 2c 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  800145:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800148:	3d 00 02 00 00       	cmp    $0x200,%eax
  80014d:	74 14                	je     800163 <_main+0x12b>
			panic("Extra or less pages are allocated in PageFile");
  80014f:	83 ec 04             	sub    $0x4,%esp
  800152:	68 28 35 80 00       	push   $0x803528
  800157:	6a 3e                	push   $0x3e
  800159:	68 ab 34 80 00       	push   $0x8034ab
  80015e:	e8 d1 16 00 00       	call   801834 <_panic>
		int freeFrames = sys_calculate_free_frames();
  800163:	e8 ad 2b 00 00       	call   802d15 <sys_calculate_free_frames>
  800168:	89 45 bc             	mov    %eax,-0x44(%ebp)

		lastIndexOfByte = (2 * Mega - kilo) / sizeof(char) - 1;
  80016b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80016e:	01 c0                	add    %eax,%eax
  800170:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800173:	48                   	dec    %eax
  800174:	89 45 b8             	mov    %eax,-0x48(%ebp)
		byteArr = (char *) ptr_allocations[0];
  800177:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  80017d:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		byteArr[0] = minByte;
  800180:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800183:	8a 55 db             	mov    -0x25(%ebp),%dl
  800186:	88 10                	mov    %dl,(%eax)
		byteArr[lastIndexOfByte] = maxByte;
  800188:	8b 55 b8             	mov    -0x48(%ebp),%edx
  80018b:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80018e:	01 c2                	add    %eax,%edx
  800190:	8a 45 da             	mov    -0x26(%ebp),%al
  800193:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 1)
  800195:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  800198:	e8 78 2b 00 00       	call   802d15 <sys_calculate_free_frames>
  80019d:	29 c3                	sub    %eax,%ebx
  80019f:	89 d8                	mov    %ebx,%eax
  8001a1:	83 f8 03             	cmp    $0x3,%eax
  8001a4:	74 14                	je     8001ba <_main+0x182>
			panic(
  8001a6:	83 ec 04             	sub    $0x4,%esp
  8001a9:	68 58 35 80 00       	push   $0x803558
  8001ae:	6a 47                	push   $0x47
  8001b0:	68 ab 34 80 00       	push   $0x8034ab
  8001b5:	e8 7a 16 00 00       	call   801834 <_panic>
					"Wrong allocation: pages are not loaded successfully into memory/WS");
		int var;

		int found = 0;
  8001ba:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)

		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
  8001c1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8001c8:	eb 76                	jmp    800240 <_main+0x208>
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  8001ca:	a1 20 40 80 00       	mov    0x804020,%eax
  8001cf:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001d5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8001d8:	c1 e2 04             	shl    $0x4,%edx
  8001db:	01 d0                	add    %edx,%eax
  8001dd:	8b 00                	mov    (%eax),%eax
  8001df:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8001e2:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8001e5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001ea:	89 c2                	mov    %eax,%edx
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
  8001ec:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8001ef:	89 45 ac             	mov    %eax,-0x54(%ebp)
  8001f2:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8001f5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
		int var;

		int found = 0;

		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  8001fa:	39 c2                	cmp    %eax,%edx
  8001fc:	75 03                	jne    800201 <_main+0x1c9>
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
				found++;
  8001fe:	ff 45 e8             	incl   -0x18(%ebp)
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800201:	a1 20 40 80 00       	mov    0x804020,%eax
  800206:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80020c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80020f:	c1 e2 04             	shl    $0x4,%edx
  800212:	01 d0                	add    %edx,%eax
  800214:	8b 00                	mov    (%eax),%eax
  800216:	89 45 a8             	mov    %eax,-0x58(%ebp)
  800219:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80021c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800221:	89 c1                	mov    %eax,%ecx
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
  800223:	8b 55 b8             	mov    -0x48(%ebp),%edx
  800226:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800229:	01 d0                	add    %edx,%eax
  80022b:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  80022e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800231:	25 00 f0 ff ff       	and    $0xfffff000,%eax

		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
				found++;
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800236:	39 c1                	cmp    %eax,%ecx
  800238:	75 03                	jne    80023d <_main+0x205>
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
				found++;
  80023a:	ff 45 e8             	incl   -0x18(%ebp)
					"Wrong allocation: pages are not loaded successfully into memory/WS");
		int var;

		int found = 0;

		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
  80023d:	ff 45 ec             	incl   -0x14(%ebp)
  800240:	a1 20 40 80 00       	mov    0x804020,%eax
  800245:	8b 50 74             	mov    0x74(%eax),%edx
  800248:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80024b:	39 c2                	cmp    %eax,%edx
  80024d:	0f 87 77 ff ff ff    	ja     8001ca <_main+0x192>
				found++;
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
				found++;
		}
		if (found != 2)
  800253:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800257:	74 14                	je     80026d <_main+0x235>
			panic("malloc: page is not added to WS");
  800259:	83 ec 04             	sub    $0x4,%esp
  80025c:	68 9c 35 80 00       	push   $0x80359c
  800261:	6a 55                	push   $0x55
  800263:	68 ab 34 80 00       	push   $0x8034ab
  800268:	e8 c7 15 00 00       	call   801834 <_panic>

		//2 MB
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80026d:	e8 26 2b 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  800272:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[1] = malloc(2 * Mega - kilo);
  800275:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800278:	01 c0                	add    %eax,%eax
  80027a:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80027d:	83 ec 0c             	sub    $0xc,%esp
  800280:	50                   	push   %eax
  800281:	e8 da 25 00 00       	call   802860 <malloc>
  800286:	83 c4 10             	add    $0x10,%esp
  800289:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2 * Mega)
  80028f:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  800295:	89 c2                	mov    %eax,%edx
  800297:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80029a:	01 c0                	add    %eax,%eax
  80029c:	05 00 00 00 80       	add    $0x80000000,%eax
  8002a1:	39 c2                	cmp    %eax,%edx
  8002a3:	72 16                	jb     8002bb <_main+0x283>
				|| (uint32) ptr_allocations[1]
  8002a5:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  8002ab:	89 c2                	mov    %eax,%edx
						> (USER_HEAP_START + 2 * Mega + PAGE_SIZE))
  8002ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002b0:	01 c0                	add    %eax,%eax
  8002b2:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax

		//2 MB
		usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[1] = malloc(2 * Mega - kilo);
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2 * Mega)
				|| (uint32) ptr_allocations[1]
  8002b7:	39 c2                	cmp    %eax,%edx
  8002b9:	76 14                	jbe    8002cf <_main+0x297>
						> (USER_HEAP_START + 2 * Mega + PAGE_SIZE))
			panic(
  8002bb:	83 ec 04             	sub    $0x4,%esp
  8002be:	68 c0 34 80 00       	push   $0x8034c0
  8002c3:	6a 5e                	push   $0x5e
  8002c5:	68 ab 34 80 00       	push   $0x8034ab
  8002ca:	e8 65 15 00 00       	call   801834 <_panic>
					"Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512)
  8002cf:	e8 c4 2a 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  8002d4:	2b 45 c0             	sub    -0x40(%ebp),%eax
  8002d7:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002dc:	74 14                	je     8002f2 <_main+0x2ba>
			panic("Extra or less pages are allocated in PageFile");
  8002de:	83 ec 04             	sub    $0x4,%esp
  8002e1:	68 28 35 80 00       	push   $0x803528
  8002e6:	6a 60                	push   $0x60
  8002e8:	68 ab 34 80 00       	push   $0x8034ab
  8002ed:	e8 42 15 00 00       	call   801834 <_panic>
		freeFrames = sys_calculate_free_frames();
  8002f2:	e8 1e 2a 00 00       	call   802d15 <sys_calculate_free_frames>
  8002f7:	89 45 bc             	mov    %eax,-0x44(%ebp)
		shortArr = (short *) ptr_allocations[1];
  8002fa:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  800300:	89 45 a0             	mov    %eax,-0x60(%ebp)
		lastIndexOfShort = (2 * Mega - kilo) / sizeof(short) - 1;
  800303:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800306:	01 c0                	add    %eax,%eax
  800308:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80030b:	d1 e8                	shr    %eax
  80030d:	48                   	dec    %eax
  80030e:	89 45 9c             	mov    %eax,-0x64(%ebp)
		shortArr[0] = minShort;
  800311:	8b 55 a0             	mov    -0x60(%ebp),%edx
  800314:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800317:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  80031a:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80031d:	01 c0                	add    %eax,%eax
  80031f:	89 c2                	mov    %eax,%edx
  800321:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800324:	01 c2                	add    %eax,%edx
  800326:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  80032a:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2)
  80032d:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  800330:	e8 e0 29 00 00       	call   802d15 <sys_calculate_free_frames>
  800335:	29 c3                	sub    %eax,%ebx
  800337:	89 d8                	mov    %ebx,%eax
  800339:	83 f8 02             	cmp    $0x2,%eax
  80033c:	74 14                	je     800352 <_main+0x31a>
			panic(
  80033e:	83 ec 04             	sub    $0x4,%esp
  800341:	68 58 35 80 00       	push   $0x803558
  800346:	6a 68                	push   $0x68
  800348:	68 ab 34 80 00       	push   $0x8034ab
  80034d:	e8 e2 14 00 00       	call   801834 <_panic>
					"Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
  800352:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
  800359:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800360:	eb 7a                	jmp    8003dc <_main+0x3a4>
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800362:	a1 20 40 80 00       	mov    0x804020,%eax
  800367:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80036d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800370:	c1 e2 04             	shl    $0x4,%edx
  800373:	01 d0                	add    %edx,%eax
  800375:	8b 00                	mov    (%eax),%eax
  800377:	89 45 98             	mov    %eax,-0x68(%ebp)
  80037a:	8b 45 98             	mov    -0x68(%ebp),%eax
  80037d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800382:	89 c2                	mov    %eax,%edx
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  800384:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800387:	89 45 94             	mov    %eax,-0x6c(%ebp)
  80038a:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80038d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
		if ((freeFrames - sys_calculate_free_frames()) != 2)
			panic(
					"Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800392:	39 c2                	cmp    %eax,%edx
  800394:	75 03                	jne    800399 <_main+0x361>
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
				found++;
  800396:	ff 45 e8             	incl   -0x18(%ebp)
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800399:	a1 20 40 80 00       	mov    0x804020,%eax
  80039e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003a4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003a7:	c1 e2 04             	shl    $0x4,%edx
  8003aa:	01 d0                	add    %edx,%eax
  8003ac:	8b 00                	mov    (%eax),%eax
  8003ae:	89 45 90             	mov    %eax,-0x70(%ebp)
  8003b1:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003b4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003b9:	89 c2                	mov    %eax,%edx
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  8003bb:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8003be:	01 c0                	add    %eax,%eax
  8003c0:	89 c1                	mov    %eax,%ecx
  8003c2:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8003c5:	01 c8                	add    %ecx,%eax
  8003c7:	89 45 8c             	mov    %eax,-0x74(%ebp)
  8003ca:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8003cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
				found++;
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  8003d2:	39 c2                	cmp    %eax,%edx
  8003d4:	75 03                	jne    8003d9 <_main+0x3a1>
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				found++;
  8003d6:	ff 45 e8             	incl   -0x18(%ebp)
		shortArr[lastIndexOfShort] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2)
			panic(
					"Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
  8003d9:	ff 45 ec             	incl   -0x14(%ebp)
  8003dc:	a1 20 40 80 00       	mov    0x804020,%eax
  8003e1:	8b 50 74             	mov    0x74(%eax),%edx
  8003e4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003e7:	39 c2                	cmp    %eax,%edx
  8003e9:	0f 87 73 ff ff ff    	ja     800362 <_main+0x32a>
				found++;
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				found++;
		}
		if (found != 2)
  8003ef:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8003f3:	74 14                	je     800409 <_main+0x3d1>
			panic("malloc: page is not added to WS");
  8003f5:	83 ec 04             	sub    $0x4,%esp
  8003f8:	68 9c 35 80 00       	push   $0x80359c
  8003fd:	6a 73                	push   $0x73
  8003ff:	68 ab 34 80 00       	push   $0x8034ab
  800404:	e8 2b 14 00 00       	call   801834 <_panic>

		//3 KB
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800409:	e8 8a 29 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  80040e:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[2] = malloc(3 * kilo);
  800411:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800414:	89 c2                	mov    %eax,%edx
  800416:	01 d2                	add    %edx,%edx
  800418:	01 d0                	add    %edx,%eax
  80041a:	83 ec 0c             	sub    $0xc,%esp
  80041d:	50                   	push   %eax
  80041e:	e8 3d 24 00 00       	call   802860 <malloc>
  800423:	83 c4 10             	add    $0x10,%esp
  800426:	89 85 d0 fe ff ff    	mov    %eax,-0x130(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4 * Mega)
  80042c:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  800432:	89 c2                	mov    %eax,%edx
  800434:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800437:	c1 e0 02             	shl    $0x2,%eax
  80043a:	05 00 00 00 80       	add    $0x80000000,%eax
  80043f:	39 c2                	cmp    %eax,%edx
  800441:	72 17                	jb     80045a <_main+0x422>
				|| (uint32) ptr_allocations[2]
  800443:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  800449:	89 c2                	mov    %eax,%edx
						> (USER_HEAP_START + 4 * Mega + PAGE_SIZE))
  80044b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80044e:	c1 e0 02             	shl    $0x2,%eax
  800451:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax

		//3 KB
		usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[2] = malloc(3 * kilo);
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4 * Mega)
				|| (uint32) ptr_allocations[2]
  800456:	39 c2                	cmp    %eax,%edx
  800458:	76 14                	jbe    80046e <_main+0x436>
						> (USER_HEAP_START + 4 * Mega + PAGE_SIZE))
			panic(
  80045a:	83 ec 04             	sub    $0x4,%esp
  80045d:	68 c0 34 80 00       	push   $0x8034c0
  800462:	6a 7c                	push   $0x7c
  800464:	68 ab 34 80 00       	push   $0x8034ab
  800469:	e8 c6 13 00 00       	call   801834 <_panic>
					"Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1)
  80046e:	e8 25 29 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  800473:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800476:	83 f8 01             	cmp    $0x1,%eax
  800479:	74 14                	je     80048f <_main+0x457>
			panic("Extra or less pages are allocated in PageFile");
  80047b:	83 ec 04             	sub    $0x4,%esp
  80047e:	68 28 35 80 00       	push   $0x803528
  800483:	6a 7e                	push   $0x7e
  800485:	68 ab 34 80 00       	push   $0x8034ab
  80048a:	e8 a5 13 00 00       	call   801834 <_panic>
		freeFrames = sys_calculate_free_frames();
  80048f:	e8 81 28 00 00       	call   802d15 <sys_calculate_free_frames>
  800494:	89 45 bc             	mov    %eax,-0x44(%ebp)
		intArr = (int *) ptr_allocations[2];
  800497:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  80049d:	89 45 88             	mov    %eax,-0x78(%ebp)
		lastIndexOfInt = (3 * kilo) / sizeof(int) - 1;
  8004a0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004a3:	89 c2                	mov    %eax,%edx
  8004a5:	01 d2                	add    %edx,%edx
  8004a7:	01 d0                	add    %edx,%eax
  8004a9:	c1 e8 02             	shr    $0x2,%eax
  8004ac:	48                   	dec    %eax
  8004ad:	89 45 84             	mov    %eax,-0x7c(%ebp)
		intArr[0] = minInt;
  8004b0:	8b 45 88             	mov    -0x78(%ebp),%eax
  8004b3:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8004b6:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  8004b8:	8b 45 84             	mov    -0x7c(%ebp),%eax
  8004bb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004c2:	8b 45 88             	mov    -0x78(%ebp),%eax
  8004c5:	01 c2                	add    %eax,%edx
  8004c7:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8004ca:	89 02                	mov    %eax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1)
  8004cc:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  8004cf:	e8 41 28 00 00       	call   802d15 <sys_calculate_free_frames>
  8004d4:	29 c3                	sub    %eax,%ebx
  8004d6:	89 d8                	mov    %ebx,%eax
  8004d8:	83 f8 02             	cmp    $0x2,%eax
  8004db:	74 17                	je     8004f4 <_main+0x4bc>
			panic(
  8004dd:	83 ec 04             	sub    $0x4,%esp
  8004e0:	68 58 35 80 00       	push   $0x803558
  8004e5:	68 86 00 00 00       	push   $0x86
  8004ea:	68 ab 34 80 00       	push   $0x8034ab
  8004ef:	e8 40 13 00 00       	call   801834 <_panic>
					"Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
  8004f4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
  8004fb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800502:	e9 8f 00 00 00       	jmp    800596 <_main+0x55e>
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800507:	a1 20 40 80 00       	mov    0x804020,%eax
  80050c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800512:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800515:	c1 e2 04             	shl    $0x4,%edx
  800518:	01 d0                	add    %edx,%eax
  80051a:	8b 00                	mov    (%eax),%eax
  80051c:	89 45 80             	mov    %eax,-0x80(%ebp)
  80051f:	8b 45 80             	mov    -0x80(%ebp),%eax
  800522:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800527:	89 c2                	mov    %eax,%edx
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
  800529:	8b 45 88             	mov    -0x78(%ebp),%eax
  80052c:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  800532:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800538:	25 00 f0 ff ff       	and    $0xfffff000,%eax
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1)
			panic(
					"Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  80053d:	39 c2                	cmp    %eax,%edx
  80053f:	75 03                	jne    800544 <_main+0x50c>
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
				found++;
  800541:	ff 45 e8             	incl   -0x18(%ebp)
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800544:	a1 20 40 80 00       	mov    0x804020,%eax
  800549:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80054f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800552:	c1 e2 04             	shl    $0x4,%edx
  800555:	01 d0                	add    %edx,%eax
  800557:	8b 00                	mov    (%eax),%eax
  800559:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  80055f:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800565:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80056a:	89 c2                	mov    %eax,%edx
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
  80056c:	8b 45 84             	mov    -0x7c(%ebp),%eax
  80056f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800576:	8b 45 88             	mov    -0x78(%ebp),%eax
  800579:	01 c8                	add    %ecx,%eax
  80057b:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
  800581:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800587:	25 00 f0 ff ff       	and    $0xfffff000,%eax
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
				found++;
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  80058c:	39 c2                	cmp    %eax,%edx
  80058e:	75 03                	jne    800593 <_main+0x55b>
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				found++;
  800590:	ff 45 e8             	incl   -0x18(%ebp)
		intArr[lastIndexOfInt] = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1)
			panic(
					"Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
  800593:	ff 45 ec             	incl   -0x14(%ebp)
  800596:	a1 20 40 80 00       	mov    0x804020,%eax
  80059b:	8b 50 74             	mov    0x74(%eax),%edx
  80059e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005a1:	39 c2                	cmp    %eax,%edx
  8005a3:	0f 87 5e ff ff ff    	ja     800507 <_main+0x4cf>
				found++;
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				found++;
		}
		if (found != 2)
  8005a9:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8005ad:	74 17                	je     8005c6 <_main+0x58e>
			panic("malloc: page is not added to WS");
  8005af:	83 ec 04             	sub    $0x4,%esp
  8005b2:	68 9c 35 80 00       	push   $0x80359c
  8005b7:	68 91 00 00 00       	push   $0x91
  8005bc:	68 ab 34 80 00       	push   $0x8034ab
  8005c1:	e8 6e 12 00 00       	call   801834 <_panic>

		//3 KB
		freeFrames = sys_calculate_free_frames();
  8005c6:	e8 4a 27 00 00       	call   802d15 <sys_calculate_free_frames>
  8005cb:	89 45 bc             	mov    %eax,-0x44(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8005ce:	e8 c5 27 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  8005d3:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[3] = malloc(3 * kilo);
  8005d6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005d9:	89 c2                	mov    %eax,%edx
  8005db:	01 d2                	add    %edx,%edx
  8005dd:	01 d0                	add    %edx,%eax
  8005df:	83 ec 0c             	sub    $0xc,%esp
  8005e2:	50                   	push   %eax
  8005e3:	e8 78 22 00 00       	call   802860 <malloc>
  8005e8:	83 c4 10             	add    $0x10,%esp
  8005eb:	89 85 d4 fe ff ff    	mov    %eax,-0x12c(%ebp)
		if ((uint32) ptr_allocations[3]
  8005f1:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  8005f7:	89 c2                	mov    %eax,%edx
				< (USER_HEAP_START + 4 * Mega + 4 * kilo)
  8005f9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005fc:	c1 e0 02             	shl    $0x2,%eax
  8005ff:	89 c1                	mov    %eax,%ecx
  800601:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800604:	c1 e0 02             	shl    $0x2,%eax
  800607:	01 c8                	add    %ecx,%eax
  800609:	05 00 00 00 80       	add    $0x80000000,%eax

		//3 KB
		freeFrames = sys_calculate_free_frames();
		usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[3] = malloc(3 * kilo);
		if ((uint32) ptr_allocations[3]
  80060e:	39 c2                	cmp    %eax,%edx
  800610:	72 21                	jb     800633 <_main+0x5fb>
				< (USER_HEAP_START + 4 * Mega + 4 * kilo)
				|| (uint32) ptr_allocations[3]
  800612:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  800618:	89 c2                	mov    %eax,%edx
						> (USER_HEAP_START + 4 * Mega + 4 * kilo + PAGE_SIZE))
  80061a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80061d:	c1 e0 02             	shl    $0x2,%eax
  800620:	89 c1                	mov    %eax,%ecx
  800622:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800625:	c1 e0 02             	shl    $0x2,%eax
  800628:	01 c8                	add    %ecx,%eax
  80062a:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
		freeFrames = sys_calculate_free_frames();
		usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[3] = malloc(3 * kilo);
		if ((uint32) ptr_allocations[3]
				< (USER_HEAP_START + 4 * Mega + 4 * kilo)
				|| (uint32) ptr_allocations[3]
  80062f:	39 c2                	cmp    %eax,%edx
  800631:	76 17                	jbe    80064a <_main+0x612>
						> (USER_HEAP_START + 4 * Mega + 4 * kilo + PAGE_SIZE))
			panic(
  800633:	83 ec 04             	sub    $0x4,%esp
  800636:	68 c0 34 80 00       	push   $0x8034c0
  80063b:	68 9c 00 00 00       	push   $0x9c
  800640:	68 ab 34 80 00       	push   $0x8034ab
  800645:	e8 ea 11 00 00       	call   801834 <_panic>
					"Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1)
  80064a:	e8 49 27 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  80064f:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800652:	83 f8 01             	cmp    $0x1,%eax
  800655:	74 17                	je     80066e <_main+0x636>
			panic("Extra or less pages are allocated in PageFile");
  800657:	83 ec 04             	sub    $0x4,%esp
  80065a:	68 28 35 80 00       	push   $0x803528
  80065f:	68 9e 00 00 00       	push   $0x9e
  800664:	68 ab 34 80 00       	push   $0x8034ab
  800669:	e8 c6 11 00 00       	call   801834 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80066e:	e8 25 27 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  800673:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[4] = malloc(7 * kilo);
  800676:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800679:	89 d0                	mov    %edx,%eax
  80067b:	01 c0                	add    %eax,%eax
  80067d:	01 d0                	add    %edx,%eax
  80067f:	01 c0                	add    %eax,%eax
  800681:	01 d0                	add    %edx,%eax
  800683:	83 ec 0c             	sub    $0xc,%esp
  800686:	50                   	push   %eax
  800687:	e8 d4 21 00 00       	call   802860 <malloc>
  80068c:	83 c4 10             	add    $0x10,%esp
  80068f:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
		if ((uint32) ptr_allocations[4]
  800695:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  80069b:	89 c2                	mov    %eax,%edx
				< (USER_HEAP_START + 4 * Mega + 8 * kilo)
  80069d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006a0:	c1 e0 02             	shl    $0x2,%eax
  8006a3:	89 c1                	mov    %eax,%ecx
  8006a5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006a8:	c1 e0 03             	shl    $0x3,%eax
  8006ab:	01 c8                	add    %ecx,%eax
  8006ad:	05 00 00 00 80       	add    $0x80000000,%eax
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[4] = malloc(7 * kilo);
		if ((uint32) ptr_allocations[4]
  8006b2:	39 c2                	cmp    %eax,%edx
  8006b4:	72 21                	jb     8006d7 <_main+0x69f>
				< (USER_HEAP_START + 4 * Mega + 8 * kilo)
				|| (uint32) ptr_allocations[4]
  8006b6:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  8006bc:	89 c2                	mov    %eax,%edx
						> (USER_HEAP_START + 4 * Mega + 8 * kilo + PAGE_SIZE))
  8006be:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006c1:	c1 e0 02             	shl    $0x2,%eax
  8006c4:	89 c1                	mov    %eax,%ecx
  8006c6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006c9:	c1 e0 03             	shl    $0x3,%eax
  8006cc:	01 c8                	add    %ecx,%eax
  8006ce:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[4] = malloc(7 * kilo);
		if ((uint32) ptr_allocations[4]
				< (USER_HEAP_START + 4 * Mega + 8 * kilo)
				|| (uint32) ptr_allocations[4]
  8006d3:	39 c2                	cmp    %eax,%edx
  8006d5:	76 17                	jbe    8006ee <_main+0x6b6>
						> (USER_HEAP_START + 4 * Mega + 8 * kilo + PAGE_SIZE))
			panic(
  8006d7:	83 ec 04             	sub    $0x4,%esp
  8006da:	68 c0 34 80 00       	push   $0x8034c0
  8006df:	68 a9 00 00 00       	push   $0xa9
  8006e4:	68 ab 34 80 00       	push   $0x8034ab
  8006e9:	e8 46 11 00 00       	call   801834 <_panic>
					"Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2)
  8006ee:	e8 a5 26 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  8006f3:	2b 45 c0             	sub    -0x40(%ebp),%eax
  8006f6:	83 f8 02             	cmp    $0x2,%eax
  8006f9:	74 17                	je     800712 <_main+0x6da>
			panic("Extra or less pages are allocated in PageFile");
  8006fb:	83 ec 04             	sub    $0x4,%esp
  8006fe:	68 28 35 80 00       	push   $0x803528
  800703:	68 ab 00 00 00       	push   $0xab
  800708:	68 ab 34 80 00       	push   $0x8034ab
  80070d:	e8 22 11 00 00       	call   801834 <_panic>
		freeFrames = sys_calculate_free_frames();
  800712:	e8 fe 25 00 00       	call   802d15 <sys_calculate_free_frames>
  800717:	89 45 bc             	mov    %eax,-0x44(%ebp)
		structArr = (struct MyStruct *) ptr_allocations[4];
  80071a:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  800720:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		lastIndexOfStruct = (7 * kilo) / sizeof(struct MyStruct) - 1;
  800726:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800729:	89 d0                	mov    %edx,%eax
  80072b:	01 c0                	add    %eax,%eax
  80072d:	01 d0                	add    %edx,%eax
  80072f:	01 c0                	add    %eax,%eax
  800731:	01 d0                	add    %edx,%eax
  800733:	c1 e8 03             	shr    $0x3,%eax
  800736:	48                   	dec    %eax
  800737:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
		structArr[0].a = minByte;
  80073d:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800743:	8a 55 db             	mov    -0x25(%ebp),%dl
  800746:	88 10                	mov    %dl,(%eax)
		structArr[0].b = minShort;
  800748:	8b 95 70 ff ff ff    	mov    -0x90(%ebp),%edx
  80074e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800751:	66 89 42 02          	mov    %ax,0x2(%edx)
		structArr[0].c = minInt;
  800755:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80075b:	8b 55 d0             	mov    -0x30(%ebp),%edx
  80075e:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte;
  800761:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800767:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80076e:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800774:	01 c2                	add    %eax,%edx
  800776:	8a 45 da             	mov    -0x26(%ebp),%al
  800779:	88 02                	mov    %al,(%edx)
		structArr[lastIndexOfStruct].b = maxShort;
  80077b:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800781:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800788:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80078e:	01 c2                	add    %eax,%edx
  800790:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  800794:	66 89 42 02          	mov    %ax,0x2(%edx)
		structArr[lastIndexOfStruct].c = maxInt;
  800798:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80079e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8007a5:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8007ab:	01 c2                	add    %eax,%edx
  8007ad:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8007b0:	89 42 04             	mov    %eax,0x4(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2)
  8007b3:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  8007b6:	e8 5a 25 00 00       	call   802d15 <sys_calculate_free_frames>
  8007bb:	29 c3                	sub    %eax,%ebx
  8007bd:	89 d8                	mov    %ebx,%eax
  8007bf:	83 f8 02             	cmp    $0x2,%eax
  8007c2:	74 17                	je     8007db <_main+0x7a3>
			panic(
  8007c4:	83 ec 04             	sub    $0x4,%esp
  8007c7:	68 58 35 80 00       	push   $0x803558
  8007cc:	68 b7 00 00 00       	push   $0xb7
  8007d1:	68 ab 34 80 00       	push   $0x8034ab
  8007d6:	e8 59 10 00 00       	call   801834 <_panic>
					"Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
  8007db:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
  8007e2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8007e9:	e9 9e 00 00 00       	jmp    80088c <_main+0x854>
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  8007ee:	a1 20 40 80 00       	mov    0x804020,%eax
  8007f3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007f9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8007fc:	c1 e2 04             	shl    $0x4,%edx
  8007ff:	01 d0                	add    %edx,%eax
  800801:	8b 00                	mov    (%eax),%eax
  800803:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  800809:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  80080f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800814:	89 c2                	mov    %eax,%edx
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
  800816:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80081c:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  800822:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  800828:	25 00 f0 ff ff       	and    $0xfffff000,%eax
		if ((freeFrames - sys_calculate_free_frames()) != 2)
			panic(
					"Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  80082d:	39 c2                	cmp    %eax,%edx
  80082f:	75 03                	jne    800834 <_main+0x7fc>
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
				found++;
  800831:	ff 45 e8             	incl   -0x18(%ebp)
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800834:	a1 20 40 80 00       	mov    0x804020,%eax
  800839:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80083f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800842:	c1 e2 04             	shl    $0x4,%edx
  800845:	01 d0                	add    %edx,%eax
  800847:	8b 00                	mov    (%eax),%eax
  800849:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  80084f:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800855:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80085a:	89 c2                	mov    %eax,%edx
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
  80085c:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800862:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800869:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80086f:	01 c8                	add    %ecx,%eax
  800871:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  800877:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  80087d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
				found++;
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800882:	39 c2                	cmp    %eax,%edx
  800884:	75 03                	jne    800889 <_main+0x851>
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
				found++;
  800886:	ff 45 e8             	incl   -0x18(%ebp)
		structArr[lastIndexOfStruct].c = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 2)
			panic(
					"Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
  800889:	ff 45 ec             	incl   -0x14(%ebp)
  80088c:	a1 20 40 80 00       	mov    0x804020,%eax
  800891:	8b 50 74             	mov    0x74(%eax),%edx
  800894:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800897:	39 c2                	cmp    %eax,%edx
  800899:	0f 87 4f ff ff ff    	ja     8007ee <_main+0x7b6>
				found++;
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
				found++;
		}
		if (found != 2)
  80089f:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8008a3:	74 17                	je     8008bc <_main+0x884>
			panic("malloc: page is not added to WS");
  8008a5:	83 ec 04             	sub    $0x4,%esp
  8008a8:	68 9c 35 80 00       	push   $0x80359c
  8008ad:	68 c2 00 00 00       	push   $0xc2
  8008b2:	68 ab 34 80 00       	push   $0x8034ab
  8008b7:	e8 78 0f 00 00       	call   801834 <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames();
  8008bc:	e8 54 24 00 00       	call   802d15 <sys_calculate_free_frames>
  8008c1:	89 45 bc             	mov    %eax,-0x44(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8008c4:	e8 cf 24 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  8008c9:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[5] = malloc(3 * Mega - kilo);
  8008cc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008cf:	89 c2                	mov    %eax,%edx
  8008d1:	01 d2                	add    %edx,%edx
  8008d3:	01 d0                	add    %edx,%eax
  8008d5:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8008d8:	83 ec 0c             	sub    $0xc,%esp
  8008db:	50                   	push   %eax
  8008dc:	e8 7f 1f 00 00       	call   802860 <malloc>
  8008e1:	83 c4 10             	add    $0x10,%esp
  8008e4:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)
		if ((uint32) ptr_allocations[5]
  8008ea:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  8008f0:	89 c2                	mov    %eax,%edx
				< (USER_HEAP_START + 4 * Mega + 16 * kilo)
  8008f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008f5:	c1 e0 02             	shl    $0x2,%eax
  8008f8:	89 c1                	mov    %eax,%ecx
  8008fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008fd:	c1 e0 04             	shl    $0x4,%eax
  800900:	01 c8                	add    %ecx,%eax
  800902:	05 00 00 00 80       	add    $0x80000000,%eax

		//3 MB
		freeFrames = sys_calculate_free_frames();
		usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[5] = malloc(3 * Mega - kilo);
		if ((uint32) ptr_allocations[5]
  800907:	39 c2                	cmp    %eax,%edx
  800909:	72 21                	jb     80092c <_main+0x8f4>
				< (USER_HEAP_START + 4 * Mega + 16 * kilo)
				|| (uint32) ptr_allocations[5]
  80090b:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  800911:	89 c2                	mov    %eax,%edx
						> (USER_HEAP_START + 4 * Mega + 16 * kilo + PAGE_SIZE))
  800913:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800916:	c1 e0 02             	shl    $0x2,%eax
  800919:	89 c1                	mov    %eax,%ecx
  80091b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80091e:	c1 e0 04             	shl    $0x4,%eax
  800921:	01 c8                	add    %ecx,%eax
  800923:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
		freeFrames = sys_calculate_free_frames();
		usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[5] = malloc(3 * Mega - kilo);
		if ((uint32) ptr_allocations[5]
				< (USER_HEAP_START + 4 * Mega + 16 * kilo)
				|| (uint32) ptr_allocations[5]
  800928:	39 c2                	cmp    %eax,%edx
  80092a:	76 17                	jbe    800943 <_main+0x90b>
						> (USER_HEAP_START + 4 * Mega + 16 * kilo + PAGE_SIZE))
			panic(
  80092c:	83 ec 04             	sub    $0x4,%esp
  80092f:	68 c0 34 80 00       	push   $0x8034c0
  800934:	68 cd 00 00 00       	push   $0xcd
  800939:	68 ab 34 80 00       	push   $0x8034ab
  80093e:	e8 f1 0e 00 00       	call   801834 <_panic>
					"Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages)
  800943:	e8 50 24 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  800948:	2b 45 c0             	sub    -0x40(%ebp),%eax
  80094b:	89 c2                	mov    %eax,%edx
				!= 3 * Mega / 4096)
  80094d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800950:	89 c1                	mov    %eax,%ecx
  800952:	01 c9                	add    %ecx,%ecx
  800954:	01 c8                	add    %ecx,%eax
  800956:	85 c0                	test   %eax,%eax
  800958:	79 05                	jns    80095f <_main+0x927>
  80095a:	05 ff 0f 00 00       	add    $0xfff,%eax
  80095f:	c1 f8 0c             	sar    $0xc,%eax
				< (USER_HEAP_START + 4 * Mega + 16 * kilo)
				|| (uint32) ptr_allocations[5]
						> (USER_HEAP_START + 4 * Mega + 16 * kilo + PAGE_SIZE))
			panic(
					"Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages)
  800962:	39 c2                	cmp    %eax,%edx
  800964:	74 17                	je     80097d <_main+0x945>
				!= 3 * Mega / 4096)
			panic("Extra or less pages are allocated in PageFile");
  800966:	83 ec 04             	sub    $0x4,%esp
  800969:	68 28 35 80 00       	push   $0x803528
  80096e:	68 d0 00 00 00       	push   $0xd0
  800973:	68 ab 34 80 00       	push   $0x8034ab
  800978:	e8 b7 0e 00 00       	call   801834 <_panic>

		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
		byteArr3 = (char*) ptr_allocations[5];
  80097d:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  800983:	89 45 f0             	mov    %eax,-0x10(%ebp)

		for (int i = 0; i < toAccess; i++) {
  800986:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80098d:	eb 10                	jmp    80099f <_main+0x967>
			*byteArr3 = '@';
  80098f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800992:	c6 00 40             	movb   $0x40,(%eax)
			byteArr3 += PAGE_SIZE;
  800995:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			panic("Extra or less pages are allocated in PageFile");

		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
		byteArr3 = (char*) ptr_allocations[5];

		for (int i = 0; i < toAccess; i++) {
  80099c:	ff 45 e4             	incl   -0x1c(%ebp)
  80099f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8009a2:	3b 45 c4             	cmp    -0x3c(%ebp),%eax
  8009a5:	7c e8                	jl     80098f <_main+0x957>
			byteArr3 += PAGE_SIZE;

		}

		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8009a7:	e8 ec 23 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  8009ac:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[6] = malloc(6 * Mega - kilo);
  8009af:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009b2:	89 d0                	mov    %edx,%eax
  8009b4:	01 c0                	add    %eax,%eax
  8009b6:	01 d0                	add    %edx,%eax
  8009b8:	01 c0                	add    %eax,%eax
  8009ba:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8009bd:	83 ec 0c             	sub    $0xc,%esp
  8009c0:	50                   	push   %eax
  8009c1:	e8 9a 1e 00 00       	call   802860 <malloc>
  8009c6:	83 c4 10             	add    $0x10,%esp
  8009c9:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
		if ((uint32) ptr_allocations[6]
  8009cf:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  8009d5:	89 c1                	mov    %eax,%ecx
				< (USER_HEAP_START + 7 * Mega + 16 * kilo)
  8009d7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009da:	89 d0                	mov    %edx,%eax
  8009dc:	01 c0                	add    %eax,%eax
  8009de:	01 d0                	add    %edx,%eax
  8009e0:	01 c0                	add    %eax,%eax
  8009e2:	01 d0                	add    %edx,%eax
  8009e4:	89 c2                	mov    %eax,%edx
  8009e6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009e9:	c1 e0 04             	shl    $0x4,%eax
  8009ec:	01 d0                	add    %edx,%eax
  8009ee:	05 00 00 00 80       	add    $0x80000000,%eax
		}

		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[6] = malloc(6 * Mega - kilo);
		if ((uint32) ptr_allocations[6]
  8009f3:	39 c1                	cmp    %eax,%ecx
  8009f5:	72 28                	jb     800a1f <_main+0x9e7>
				< (USER_HEAP_START + 7 * Mega + 16 * kilo)
				|| (uint32) ptr_allocations[6]
  8009f7:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  8009fd:	89 c1                	mov    %eax,%ecx
						> (USER_HEAP_START + 7 * Mega + 16 * kilo + PAGE_SIZE))
  8009ff:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a02:	89 d0                	mov    %edx,%eax
  800a04:	01 c0                	add    %eax,%eax
  800a06:	01 d0                	add    %edx,%eax
  800a08:	01 c0                	add    %eax,%eax
  800a0a:	01 d0                	add    %edx,%eax
  800a0c:	89 c2                	mov    %eax,%edx
  800a0e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a11:	c1 e0 04             	shl    $0x4,%eax
  800a14:	01 d0                	add    %edx,%eax
  800a16:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[6] = malloc(6 * Mega - kilo);
		if ((uint32) ptr_allocations[6]
				< (USER_HEAP_START + 7 * Mega + 16 * kilo)
				|| (uint32) ptr_allocations[6]
  800a1b:	39 c1                	cmp    %eax,%ecx
  800a1d:	76 17                	jbe    800a36 <_main+0x9fe>
						> (USER_HEAP_START + 7 * Mega + 16 * kilo + PAGE_SIZE))
			panic(
  800a1f:	83 ec 04             	sub    $0x4,%esp
  800a22:	68 c0 34 80 00       	push   $0x8034c0
  800a27:	68 e3 00 00 00       	push   $0xe3
  800a2c:	68 ab 34 80 00       	push   $0x8034ab
  800a31:	e8 fe 0d 00 00       	call   801834 <_panic>
					"Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages)
  800a36:	e8 5d 23 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  800a3b:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800a3e:	89 c1                	mov    %eax,%ecx
				!= 6 * Mega / 4096)
  800a40:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a43:	89 d0                	mov    %edx,%eax
  800a45:	01 c0                	add    %eax,%eax
  800a47:	01 d0                	add    %edx,%eax
  800a49:	01 c0                	add    %eax,%eax
  800a4b:	85 c0                	test   %eax,%eax
  800a4d:	79 05                	jns    800a54 <_main+0xa1c>
  800a4f:	05 ff 0f 00 00       	add    $0xfff,%eax
  800a54:	c1 f8 0c             	sar    $0xc,%eax
				< (USER_HEAP_START + 7 * Mega + 16 * kilo)
				|| (uint32) ptr_allocations[6]
						> (USER_HEAP_START + 7 * Mega + 16 * kilo + PAGE_SIZE))
			panic(
					"Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages)
  800a57:	39 c1                	cmp    %eax,%ecx
  800a59:	74 17                	je     800a72 <_main+0xa3a>
				!= 6 * Mega / 4096)
			panic("Extra or less pages are allocated in PageFile");
  800a5b:	83 ec 04             	sub    $0x4,%esp
  800a5e:	68 28 35 80 00       	push   $0x803528
  800a63:	68 e6 00 00 00       	push   $0xe6
  800a68:	68 ab 34 80 00       	push   $0x8034ab
  800a6d:	e8 c2 0d 00 00       	call   801834 <_panic>
		freeFrames = sys_calculate_free_frames();
  800a72:	e8 9e 22 00 00       	call   802d15 <sys_calculate_free_frames>
  800a77:	89 45 bc             	mov    %eax,-0x44(%ebp)
		lastIndexOfByte2 = (6 * Mega - kilo) / sizeof(char) - 1;
  800a7a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a7d:	89 d0                	mov    %edx,%eax
  800a7f:	01 c0                	add    %eax,%eax
  800a81:	01 d0                	add    %edx,%eax
  800a83:	01 c0                	add    %eax,%eax
  800a85:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800a88:	48                   	dec    %eax
  800a89:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
		byteArr2 = (char *) ptr_allocations[6];
  800a8f:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  800a95:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
		byteArr2[0] = minByte;
  800a9b:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800aa1:	8a 55 db             	mov    -0x25(%ebp),%dl
  800aa4:	88 10                	mov    %dl,(%eax)
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
  800aa6:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800aac:	89 c2                	mov    %eax,%edx
  800aae:	c1 ea 1f             	shr    $0x1f,%edx
  800ab1:	01 d0                	add    %edx,%eax
  800ab3:	d1 f8                	sar    %eax
  800ab5:	89 c2                	mov    %eax,%edx
  800ab7:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800abd:	01 c2                	add    %eax,%edx
  800abf:	8a 45 da             	mov    -0x26(%ebp),%al
  800ac2:	88 c1                	mov    %al,%cl
  800ac4:	c0 e9 07             	shr    $0x7,%cl
  800ac7:	01 c8                	add    %ecx,%eax
  800ac9:	d0 f8                	sar    %al
  800acb:	88 02                	mov    %al,(%edx)
		byteArr2[lastIndexOfByte2] = maxByte;
  800acd:	8b 95 58 ff ff ff    	mov    -0xa8(%ebp),%edx
  800ad3:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800ad9:	01 c2                	add    %eax,%edx
  800adb:	8a 45 da             	mov    -0x26(%ebp),%al
  800ade:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2)
  800ae0:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  800ae3:	e8 2d 22 00 00       	call   802d15 <sys_calculate_free_frames>
  800ae8:	29 c3                	sub    %eax,%ebx
  800aea:	89 d8                	mov    %ebx,%eax
  800aec:	83 f8 05             	cmp    $0x5,%eax
  800aef:	74 17                	je     800b08 <_main+0xad0>
			panic(
  800af1:	83 ec 04             	sub    $0x4,%esp
  800af4:	68 58 35 80 00       	push   $0x803558
  800af9:	68 ef 00 00 00       	push   $0xef
  800afe:	68 ab 34 80 00       	push   $0x8034ab
  800b03:	e8 2c 0d 00 00       	call   801834 <_panic>
					"Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
  800b08:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
  800b0f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800b16:	e9 f0 00 00 00       	jmp    800c0b <_main+0xbd3>
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800b1b:	a1 20 40 80 00       	mov    0x804020,%eax
  800b20:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b26:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b29:	c1 e2 04             	shl    $0x4,%edx
  800b2c:	01 d0                	add    %edx,%eax
  800b2e:	8b 00                	mov    (%eax),%eax
  800b30:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  800b36:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800b3c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b41:	89 c2                	mov    %eax,%edx
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  800b43:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800b49:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  800b4f:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800b55:	25 00 f0 ff ff       	and    $0xfffff000,%eax
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2)
			panic(
					"Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800b5a:	39 c2                	cmp    %eax,%edx
  800b5c:	75 03                	jne    800b61 <_main+0xb29>
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
				found++;
  800b5e:	ff 45 e8             	incl   -0x18(%ebp)
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800b61:	a1 20 40 80 00       	mov    0x804020,%eax
  800b66:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b6c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b6f:	c1 e2 04             	shl    $0x4,%edx
  800b72:	01 d0                	add    %edx,%eax
  800b74:	8b 00                	mov    (%eax),%eax
  800b76:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
  800b7c:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800b82:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b87:	89 c2                	mov    %eax,%edx
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  800b89:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800b8f:	89 c1                	mov    %eax,%ecx
  800b91:	c1 e9 1f             	shr    $0x1f,%ecx
  800b94:	01 c8                	add    %ecx,%eax
  800b96:	d1 f8                	sar    %eax
  800b98:	89 c1                	mov    %eax,%ecx
  800b9a:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800ba0:	01 c8                	add    %ecx,%eax
  800ba2:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  800ba8:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800bae:	25 00 f0 ff ff       	and    $0xfffff000,%eax
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
				found++;
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800bb3:	39 c2                	cmp    %eax,%edx
  800bb5:	75 03                	jne    800bba <_main+0xb82>
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
				found++;
  800bb7:	ff 45 e8             	incl   -0x18(%ebp)
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800bba:	a1 20 40 80 00       	mov    0x804020,%eax
  800bbf:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800bc5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800bc8:	c1 e2 04             	shl    $0x4,%edx
  800bcb:	01 d0                	add    %edx,%eax
  800bcd:	8b 00                	mov    (%eax),%eax
  800bcf:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
  800bd5:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800bdb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800be0:	89 c1                	mov    %eax,%ecx
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  800be2:	8b 95 58 ff ff ff    	mov    -0xa8(%ebp),%edx
  800be8:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800bee:	01 d0                	add    %edx,%eax
  800bf0:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)
  800bf6:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800bfc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
				found++;
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
				found++;
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800c01:	39 c1                	cmp    %eax,%ecx
  800c03:	75 03                	jne    800c08 <_main+0xbd0>
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				found++;
  800c05:	ff 45 e8             	incl   -0x18(%ebp)
		byteArr2[lastIndexOfByte2] = maxByte;
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2)
			panic(
					"Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
  800c08:	ff 45 ec             	incl   -0x14(%ebp)
  800c0b:	a1 20 40 80 00       	mov    0x804020,%eax
  800c10:	8b 50 74             	mov    0x74(%eax),%edx
  800c13:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c16:	39 c2                	cmp    %eax,%edx
  800c18:	0f 87 fd fe ff ff    	ja     800b1b <_main+0xae3>
				found++;
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				found++;
		}
		if (found != 3)
  800c1e:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  800c22:	74 17                	je     800c3b <_main+0xc03>
			panic("malloc: page is not added to WS");
  800c24:	83 ec 04             	sub    $0x4,%esp
  800c27:	68 9c 35 80 00       	push   $0x80359c
  800c2c:	68 fd 00 00 00       	push   $0xfd
  800c31:	68 ab 34 80 00       	push   $0x8034ab
  800c36:	e8 f9 0b 00 00       	call   801834 <_panic>

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800c3b:	e8 58 21 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  800c40:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[7] = malloc(14 * kilo);
  800c43:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800c46:	89 d0                	mov    %edx,%eax
  800c48:	01 c0                	add    %eax,%eax
  800c4a:	01 d0                	add    %edx,%eax
  800c4c:	01 c0                	add    %eax,%eax
  800c4e:	01 d0                	add    %edx,%eax
  800c50:	01 c0                	add    %eax,%eax
  800c52:	83 ec 0c             	sub    $0xc,%esp
  800c55:	50                   	push   %eax
  800c56:	e8 05 1c 00 00       	call   802860 <malloc>
  800c5b:	83 c4 10             	add    $0x10,%esp
  800c5e:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
		if ((uint32) ptr_allocations[7]
  800c64:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800c6a:	89 c1                	mov    %eax,%ecx
				< (USER_HEAP_START + 13 * Mega + 16 * kilo)
  800c6c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c6f:	89 d0                	mov    %edx,%eax
  800c71:	01 c0                	add    %eax,%eax
  800c73:	01 d0                	add    %edx,%eax
  800c75:	c1 e0 02             	shl    $0x2,%eax
  800c78:	01 d0                	add    %edx,%eax
  800c7a:	89 c2                	mov    %eax,%edx
  800c7c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800c7f:	c1 e0 04             	shl    $0x4,%eax
  800c82:	01 d0                	add    %edx,%eax
  800c84:	05 00 00 00 80       	add    $0x80000000,%eax
			panic("malloc: page is not added to WS");

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[7] = malloc(14 * kilo);
		if ((uint32) ptr_allocations[7]
  800c89:	39 c1                	cmp    %eax,%ecx
  800c8b:	72 29                	jb     800cb6 <_main+0xc7e>
				< (USER_HEAP_START + 13 * Mega + 16 * kilo)
				|| (uint32) ptr_allocations[7]
  800c8d:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800c93:	89 c1                	mov    %eax,%ecx
						> (USER_HEAP_START + 13 * Mega + 16 * kilo + PAGE_SIZE))
  800c95:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c98:	89 d0                	mov    %edx,%eax
  800c9a:	01 c0                	add    %eax,%eax
  800c9c:	01 d0                	add    %edx,%eax
  800c9e:	c1 e0 02             	shl    $0x2,%eax
  800ca1:	01 d0                	add    %edx,%eax
  800ca3:	89 c2                	mov    %eax,%edx
  800ca5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800ca8:	c1 e0 04             	shl    $0x4,%eax
  800cab:	01 d0                	add    %edx,%eax
  800cad:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages();
		ptr_allocations[7] = malloc(14 * kilo);
		if ((uint32) ptr_allocations[7]
				< (USER_HEAP_START + 13 * Mega + 16 * kilo)
				|| (uint32) ptr_allocations[7]
  800cb2:	39 c1                	cmp    %eax,%ecx
  800cb4:	76 17                	jbe    800ccd <_main+0xc95>
						> (USER_HEAP_START + 13 * Mega + 16 * kilo + PAGE_SIZE))
			panic(
  800cb6:	83 ec 04             	sub    $0x4,%esp
  800cb9:	68 c0 34 80 00       	push   $0x8034c0
  800cbe:	68 07 01 00 00       	push   $0x107
  800cc3:	68 ab 34 80 00       	push   $0x8034ab
  800cc8:	e8 67 0b 00 00       	call   801834 <_panic>
					"Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4)
  800ccd:	e8 c6 20 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  800cd2:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800cd5:	83 f8 04             	cmp    $0x4,%eax
  800cd8:	74 17                	je     800cf1 <_main+0xcb9>
			panic("Extra or less pages are allocated in PageFile");
  800cda:	83 ec 04             	sub    $0x4,%esp
  800cdd:	68 28 35 80 00       	push   $0x803528
  800ce2:	68 09 01 00 00       	push   $0x109
  800ce7:	68 ab 34 80 00       	push   $0x8034ab
  800cec:	e8 43 0b 00 00       	call   801834 <_panic>
		freeFrames = sys_calculate_free_frames();
  800cf1:	e8 1f 20 00 00       	call   802d15 <sys_calculate_free_frames>
  800cf6:	89 45 bc             	mov    %eax,-0x44(%ebp)
		shortArr2 = (short *) ptr_allocations[7];
  800cf9:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800cff:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
		lastIndexOfShort2 = (14 * kilo) / sizeof(short) - 1;
  800d05:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800d08:	89 d0                	mov    %edx,%eax
  800d0a:	01 c0                	add    %eax,%eax
  800d0c:	01 d0                	add    %edx,%eax
  800d0e:	01 c0                	add    %eax,%eax
  800d10:	01 d0                	add    %edx,%eax
  800d12:	01 c0                	add    %eax,%eax
  800d14:	d1 e8                	shr    %eax
  800d16:	48                   	dec    %eax
  800d17:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
		shortArr2[0] = minShort;
  800d1d:	8b 95 38 ff ff ff    	mov    -0xc8(%ebp),%edx
  800d23:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800d26:	66 89 02             	mov    %ax,(%edx)
		shortArr2[lastIndexOfShort2] = maxShort;
  800d29:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800d2f:	01 c0                	add    %eax,%eax
  800d31:	89 c2                	mov    %eax,%edx
  800d33:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800d39:	01 c2                	add    %eax,%edx
  800d3b:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  800d3f:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2)
  800d42:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  800d45:	e8 cb 1f 00 00       	call   802d15 <sys_calculate_free_frames>
  800d4a:	29 c3                	sub    %eax,%ebx
  800d4c:	89 d8                	mov    %ebx,%eax
  800d4e:	83 f8 02             	cmp    $0x2,%eax
  800d51:	74 17                	je     800d6a <_main+0xd32>
			panic(
  800d53:	83 ec 04             	sub    $0x4,%esp
  800d56:	68 58 35 80 00       	push   $0x803558
  800d5b:	68 11 01 00 00       	push   $0x111
  800d60:	68 ab 34 80 00       	push   $0x8034ab
  800d65:	e8 ca 0a 00 00       	call   801834 <_panic>
					"Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
  800d6a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
  800d71:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800d78:	e9 9b 00 00 00       	jmp    800e18 <_main+0xde0>
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800d7d:	a1 20 40 80 00       	mov    0x804020,%eax
  800d82:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800d88:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800d8b:	c1 e2 04             	shl    $0x4,%edx
  800d8e:	01 d0                	add    %edx,%eax
  800d90:	8b 00                	mov    (%eax),%eax
  800d92:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
  800d98:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  800d9e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800da3:	89 c2                	mov    %eax,%edx
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
  800da5:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800dab:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
  800db1:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  800db7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
		if ((freeFrames - sys_calculate_free_frames()) != 2)
			panic(
					"Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800dbc:	39 c2                	cmp    %eax,%edx
  800dbe:	75 03                	jne    800dc3 <_main+0xd8b>
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
				found++;
  800dc0:	ff 45 e8             	incl   -0x18(%ebp)
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800dc3:	a1 20 40 80 00       	mov    0x804020,%eax
  800dc8:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800dce:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dd1:	c1 e2 04             	shl    $0x4,%edx
  800dd4:	01 d0                	add    %edx,%eax
  800dd6:	8b 00                	mov    (%eax),%eax
  800dd8:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
  800dde:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
  800de4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800de9:	89 c2                	mov    %eax,%edx
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
  800deb:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800df1:	01 c0                	add    %eax,%eax
  800df3:	89 c1                	mov    %eax,%ecx
  800df5:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800dfb:	01 c8                	add    %ecx,%eax
  800dfd:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
  800e03:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  800e09:	25 00 f0 ff ff       	and    $0xfffff000,%eax
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
				found++;
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
  800e0e:	39 c2                	cmp    %eax,%edx
  800e10:	75 03                	jne    800e15 <_main+0xddd>
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
				found++;
  800e12:	ff 45 e8             	incl   -0x18(%ebp)
		shortArr2[lastIndexOfShort2] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2)
			panic(
					"Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var) {
  800e15:	ff 45 ec             	incl   -0x14(%ebp)
  800e18:	a1 20 40 80 00       	mov    0x804020,%eax
  800e1d:	8b 50 74             	mov    0x74(%eax),%edx
  800e20:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e23:	39 c2                	cmp    %eax,%edx
  800e25:	0f 87 52 ff ff ff    	ja     800d7d <_main+0xd45>
				found++;
			if (ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,
					PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
				found++;
		}
		if (found != 2)
  800e2b:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800e2f:	74 17                	je     800e48 <_main+0xe10>
			panic("malloc: page is not added to WS");
  800e31:	83 ec 04             	sub    $0x4,%esp
  800e34:	68 9c 35 80 00       	push   $0x80359c
  800e39:	68 1c 01 00 00       	push   $0x11c
  800e3e:	68 ab 34 80 00       	push   $0x8034ab
  800e43:	e8 ec 09 00 00       	call   801834 <_panic>
	}

	{
		uint32 tmp_addresses[3] = { 0 };
  800e48:	8d 95 bc fe ff ff    	lea    -0x144(%ebp),%edx
  800e4e:	b9 03 00 00 00       	mov    $0x3,%ecx
  800e53:	b8 00 00 00 00       	mov    $0x0,%eax
  800e58:	89 d7                	mov    %edx,%edi
  800e5a:	f3 ab                	rep stos %eax,%es:(%edi)
		//Free 6 MB
		int freeFrames = sys_calculate_free_frames();
  800e5c:	e8 b4 1e 00 00       	call   802d15 <sys_calculate_free_frames>
  800e61:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages();
  800e67:	e8 2c 1f 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  800e6c:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[6]);
  800e72:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  800e78:	83 ec 0c             	sub    $0xc,%esp
  800e7b:	50                   	push   %eax
  800e7c:	e8 70 1b 00 00       	call   8029f1 <free>
  800e81:	83 c4 10             	add    $0x10,%esp
		cprintf("i Expect %d and found %d \n ------------\n", 6 * Mega / 4096,(usedDiskPages - sys_pf_calculate_allocated_pages()));
  800e84:	e8 0f 1f 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  800e89:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  800e8f:	89 d1                	mov    %edx,%ecx
  800e91:	29 c1                	sub    %eax,%ecx
  800e93:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e96:	89 d0                	mov    %edx,%eax
  800e98:	01 c0                	add    %eax,%eax
  800e9a:	01 d0                	add    %edx,%eax
  800e9c:	01 c0                	add    %eax,%eax
  800e9e:	85 c0                	test   %eax,%eax
  800ea0:	79 05                	jns    800ea7 <_main+0xe6f>
  800ea2:	05 ff 0f 00 00       	add    $0xfff,%eax
  800ea7:	c1 f8 0c             	sar    $0xc,%eax
  800eaa:	83 ec 04             	sub    $0x4,%esp
  800ead:	51                   	push   %ecx
  800eae:	50                   	push   %eax
  800eaf:	68 bc 35 80 00       	push   $0x8035bc
  800eb4:	e8 1d 0c 00 00       	call   801ad6 <cprintf>
  800eb9:	83 c4 10             	add    $0x10,%esp

		if ((usedDiskPages - sys_pf_calculate_allocated_pages())!= 6 * Mega / 4096)
  800ebc:	e8 d7 1e 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  800ec1:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  800ec7:	89 d1                	mov    %edx,%ecx
  800ec9:	29 c1                	sub    %eax,%ecx
  800ecb:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ece:	89 d0                	mov    %edx,%eax
  800ed0:	01 c0                	add    %eax,%eax
  800ed2:	01 d0                	add    %edx,%eax
  800ed4:	01 c0                	add    %eax,%eax
  800ed6:	85 c0                	test   %eax,%eax
  800ed8:	79 05                	jns    800edf <_main+0xea7>
  800eda:	05 ff 0f 00 00       	add    $0xfff,%eax
  800edf:	c1 f8 0c             	sar    $0xc,%eax
  800ee2:	39 c1                	cmp    %eax,%ecx
  800ee4:	74 17                	je     800efd <_main+0xec5>
			panic("Wrong free: Extra or less pages are removed from PageFile");
  800ee6:	83 ec 04             	sub    $0x4,%esp
  800ee9:	68 e8 35 80 00       	push   $0x8035e8
  800eee:	68 28 01 00 00       	push   $0x128
  800ef3:	68 ab 34 80 00       	push   $0x8034ab
  800ef8:	e8 37 09 00 00       	call   801834 <_panic>
		cprintf("i Expetct %d and found %d \n ------------\n", 3 + 1,
				(sys_calculate_free_frames() - freeFrames));
  800efd:	e8 13 1e 00 00       	call   802d15 <sys_calculate_free_frames>
  800f02:	89 c2                	mov    %eax,%edx
		free(ptr_allocations[6]);
		cprintf("i Expect %d and found %d \n ------------\n", 6 * Mega / 4096,(usedDiskPages - sys_pf_calculate_allocated_pages()));

		if ((usedDiskPages - sys_pf_calculate_allocated_pages())!= 6 * Mega / 4096)
			panic("Wrong free: Extra or less pages are removed from PageFile");
		cprintf("i Expetct %d and found %d \n ------------\n", 3 + 1,
  800f04:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  800f0a:	29 c2                	sub    %eax,%edx
  800f0c:	89 d0                	mov    %edx,%eax
  800f0e:	83 ec 04             	sub    $0x4,%esp
  800f11:	50                   	push   %eax
  800f12:	6a 04                	push   $0x4
  800f14:	68 24 36 80 00       	push   $0x803624
  800f19:	e8 b8 0b 00 00       	call   801ad6 <cprintf>
  800f1e:	83 c4 10             	add    $0x10,%esp
				(sys_calculate_free_frames() - freeFrames));
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 1)
  800f21:	e8 ef 1d 00 00       	call   802d15 <sys_calculate_free_frames>
  800f26:	89 c2                	mov    %eax,%edx
  800f28:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  800f2e:	29 c2                	sub    %eax,%edx
  800f30:	89 d0                	mov    %edx,%eax
  800f32:	83 f8 04             	cmp    $0x4,%eax
  800f35:	74 17                	je     800f4e <_main+0xf16>
			panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800f37:	83 ec 04             	sub    $0x4,%esp
  800f3a:	68 50 36 80 00       	push   $0x803650
  800f3f:	68 2c 01 00 00       	push   $0x12c
  800f44:	68 ab 34 80 00       	push   $0x8034ab
  800f49:	e8 e6 08 00 00       	call   801834 <_panic>
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}
		tmp_addresses[0] = (uint32) (&(byteArr2[0]));
  800f4e:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800f54:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32) (&(byteArr2[lastIndexOfByte2 / 2]));
  800f5a:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800f60:	89 c2                	mov    %eax,%edx
  800f62:	c1 ea 1f             	shr    $0x1f,%edx
  800f65:	01 d0                	add    %edx,%eax
  800f67:	d1 f8                	sar    %eax
  800f69:	89 c2                	mov    %eax,%edx
  800f6b:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800f71:	01 d0                	add    %edx,%eax
  800f73:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		tmp_addresses[2] = (uint32) (&(byteArr2[lastIndexOfByte2]));
  800f79:	8b 95 58 ff ff ff    	mov    -0xa8(%ebp),%edx
  800f7f:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800f85:	01 d0                	add    %edx,%eax
  800f87:	89 85 c4 fe ff ff    	mov    %eax,-0x13c(%ebp)
		int check = sys_check_LRU_lists_free(tmp_addresses, 3);
  800f8d:	83 ec 08             	sub    $0x8,%esp
  800f90:	6a 03                	push   $0x3
  800f92:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  800f98:	50                   	push   %eax
  800f99:	e8 4b 22 00 00       	call   8031e9 <sys_check_LRU_lists_free>
  800f9e:	83 c4 10             	add    $0x10,%esp
  800fa1:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if (check != 0) {
  800fa7:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  800fae:	74 17                	je     800fc7 <_main+0xf8f>
			panic("free: page is not removed from LRU lists");
  800fb0:	83 ec 04             	sub    $0x4,%esp
  800fb3:	68 9c 36 80 00       	push   $0x80369c
  800fb8:	68 3b 01 00 00       	push   $0x13b
  800fbd:	68 ab 34 80 00       	push   $0x8034ab
  800fc2:	e8 6d 08 00 00       	call   801834 <_panic>
		}

		if (LIST_SIZE(&myEnv->ActiveList) != 800
  800fc7:	a1 20 40 80 00       	mov    0x804020,%eax
  800fcc:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  800fd2:	3d 20 03 00 00       	cmp    $0x320,%eax
  800fd7:	74 27                	je     801000 <_main+0xfc8>
				&& LIST_SIZE(&myEnv->SecondList) != 1) {
  800fd9:	a1 20 40 80 00       	mov    0x804020,%eax
  800fde:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  800fe4:	83 f8 01             	cmp    $0x1,%eax
  800fe7:	74 17                	je     801000 <_main+0xfc8>
			panic("LRU lists content is not correct");
  800fe9:	83 ec 04             	sub    $0x4,%esp
  800fec:	68 c8 36 80 00       	push   $0x8036c8
  800ff1:	68 40 01 00 00       	push   $0x140
  800ff6:	68 ab 34 80 00       	push   $0x8034ab
  800ffb:	e8 34 08 00 00       	call   801834 <_panic>
		}

		//Free 1st 2 MB
		freeFrames = sys_calculate_free_frames();
  801000:	e8 10 1d 00 00       	call   802d15 <sys_calculate_free_frames>
  801005:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80100b:	e8 88 1d 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  801010:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[0]);
  801016:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  80101c:	83 ec 0c             	sub    $0xc,%esp
  80101f:	50                   	push   %eax
  801020:	e8 cc 19 00 00       	call   8029f1 <free>
  801025:	83 c4 10             	add    $0x10,%esp
		cprintf("expict %d found %d\n",512,(usedDiskPages - sys_pf_calculate_allocated_pages()));
  801028:	e8 6b 1d 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  80102d:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801033:	29 c2                	sub    %eax,%edx
  801035:	89 d0                	mov    %edx,%eax
  801037:	83 ec 04             	sub    $0x4,%esp
  80103a:	50                   	push   %eax
  80103b:	68 00 02 00 00       	push   $0x200
  801040:	68 e9 36 80 00       	push   $0x8036e9
  801045:	e8 8c 0a 00 00       	call   801ad6 <cprintf>
  80104a:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512)
  80104d:	e8 46 1d 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  801052:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801058:	29 c2                	sub    %eax,%edx
  80105a:	89 d0                	mov    %edx,%eax
  80105c:	3d 00 02 00 00       	cmp    $0x200,%eax
  801061:	74 17                	je     80107a <_main+0x1042>
			panic("Wrong free: Extra or less pages are removed from PageFile");
  801063:	83 ec 04             	sub    $0x4,%esp
  801066:	68 e8 35 80 00       	push   $0x8035e8
  80106b:	68 49 01 00 00       	push   $0x149
  801070:	68 ab 34 80 00       	push   $0x8034ab
  801075:	e8 ba 07 00 00       	call   801834 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2)
  80107a:	e8 96 1c 00 00       	call   802d15 <sys_calculate_free_frames>
  80107f:	89 c2                	mov    %eax,%edx
  801081:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801087:	29 c2                	sub    %eax,%edx
  801089:	89 d0                	mov    %edx,%eax
  80108b:	83 f8 02             	cmp    $0x2,%eax
  80108e:	74 17                	je     8010a7 <_main+0x106f>
			panic(
  801090:	83 ec 04             	sub    $0x4,%esp
  801093:	68 50 36 80 00       	push   $0x803650
  801098:	68 4c 01 00 00       	push   $0x14c
  80109d:	68 ab 34 80 00       	push   $0x8034ab
  8010a2:	e8 8d 07 00 00       	call   801834 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32) (&(byteArr[0]));
  8010a7:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8010aa:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32) (&(byteArr[lastIndexOfByte]));
  8010b0:	8b 55 b8             	mov    -0x48(%ebp),%edx
  8010b3:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8010b6:	01 d0                	add    %edx,%eax
  8010b8:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  8010be:	83 ec 08             	sub    $0x8,%esp
  8010c1:	6a 02                	push   $0x2
  8010c3:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  8010c9:	50                   	push   %eax
  8010ca:	e8 1a 21 00 00       	call   8031e9 <sys_check_LRU_lists_free>
  8010cf:	83 c4 10             	add    $0x10,%esp
  8010d2:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if (check != 0) {
  8010d8:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  8010df:	74 17                	je     8010f8 <_main+0x10c0>
			panic("free: page is not removed from LRU lists");
  8010e1:	83 ec 04             	sub    $0x4,%esp
  8010e4:	68 9c 36 80 00       	push   $0x80369c
  8010e9:	68 5a 01 00 00       	push   $0x15a
  8010ee:	68 ab 34 80 00       	push   $0x8034ab
  8010f3:	e8 3c 07 00 00       	call   801834 <_panic>
		}

		if (LIST_SIZE(&myEnv->ActiveList) != 799
  8010f8:	a1 20 40 80 00       	mov    0x804020,%eax
  8010fd:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  801103:	3d 1f 03 00 00       	cmp    $0x31f,%eax
  801108:	74 26                	je     801130 <_main+0x10f8>
				&& LIST_SIZE(&myEnv->SecondList) != 0) {
  80110a:	a1 20 40 80 00       	mov    0x804020,%eax
  80110f:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  801115:	85 c0                	test   %eax,%eax
  801117:	74 17                	je     801130 <_main+0x10f8>
			panic("LRU lists content is not correct");
  801119:	83 ec 04             	sub    $0x4,%esp
  80111c:	68 c8 36 80 00       	push   $0x8036c8
  801121:	68 5f 01 00 00       	push   $0x15f
  801126:	68 ab 34 80 00       	push   $0x8034ab
  80112b:	e8 04 07 00 00       	call   801834 <_panic>
		}

		//Free 2nd 2 MB
		freeFrames = sys_calculate_free_frames();
  801130:	e8 e0 1b 00 00       	call   802d15 <sys_calculate_free_frames>
  801135:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80113b:	e8 58 1c 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  801140:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[1]);
  801146:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  80114c:	83 ec 0c             	sub    $0xc,%esp
  80114f:	50                   	push   %eax
  801150:	e8 9c 18 00 00       	call   8029f1 <free>
  801155:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512)
  801158:	e8 3b 1c 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  80115d:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801163:	29 c2                	sub    %eax,%edx
  801165:	89 d0                	mov    %edx,%eax
  801167:	3d 00 02 00 00       	cmp    $0x200,%eax
  80116c:	74 17                	je     801185 <_main+0x114d>
			panic("Wrong free: Extra or less pages are removed from PageFile");
  80116e:	83 ec 04             	sub    $0x4,%esp
  801171:	68 e8 35 80 00       	push   $0x8035e8
  801176:	68 67 01 00 00       	push   $0x167
  80117b:	68 ab 34 80 00       	push   $0x8034ab
  801180:	e8 af 06 00 00       	call   801834 <_panic>
		cprintf("i Expetct %d and found %d \n ------------\n", 2 +1,
						(sys_calculate_free_frames() - freeFrames));
  801185:	e8 8b 1b 00 00       	call   802d15 <sys_calculate_free_frames>
  80118a:	89 c2                	mov    %eax,%edx
		freeFrames = sys_calculate_free_frames();
		usedDiskPages = sys_pf_calculate_allocated_pages();
		free(ptr_allocations[1]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512)
			panic("Wrong free: Extra or less pages are removed from PageFile");
		cprintf("i Expetct %d and found %d \n ------------\n", 2 +1,
  80118c:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801192:	29 c2                	sub    %eax,%edx
  801194:	89 d0                	mov    %edx,%eax
  801196:	83 ec 04             	sub    $0x4,%esp
  801199:	50                   	push   %eax
  80119a:	6a 03                	push   $0x3
  80119c:	68 24 36 80 00       	push   $0x803624
  8011a1:	e8 30 09 00 00       	call   801ad6 <cprintf>
  8011a6:	83 c4 10             	add    $0x10,%esp
						(sys_calculate_free_frames() - freeFrames));
		if ((sys_calculate_free_frames() - freeFrames) != 2 +1)
  8011a9:	e8 67 1b 00 00       	call   802d15 <sys_calculate_free_frames>
  8011ae:	89 c2                	mov    %eax,%edx
  8011b0:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  8011b6:	29 c2                	sub    %eax,%edx
  8011b8:	89 d0                	mov    %edx,%eax
  8011ba:	83 f8 03             	cmp    $0x3,%eax
  8011bd:	74 17                	je     8011d6 <_main+0x119e>
			panic(
  8011bf:	83 ec 04             	sub    $0x4,%esp
  8011c2:	68 50 36 80 00       	push   $0x803650
  8011c7:	68 6c 01 00 00       	push   $0x16c
  8011cc:	68 ab 34 80 00       	push   $0x8034ab
  8011d1:	e8 5e 06 00 00       	call   801834 <_panic>
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}
		tmp_addresses[0] = (uint32) (&(shortArr[0]));
  8011d6:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8011d9:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32) (&(shortArr[lastIndexOfShort]));
  8011df:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8011e2:	01 c0                	add    %eax,%eax
  8011e4:	89 c2                	mov    %eax,%edx
  8011e6:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8011e9:	01 d0                	add    %edx,%eax
  8011eb:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  8011f1:	83 ec 08             	sub    $0x8,%esp
  8011f4:	6a 02                	push   $0x2
  8011f6:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  8011fc:	50                   	push   %eax
  8011fd:	e8 e7 1f 00 00       	call   8031e9 <sys_check_LRU_lists_free>
  801202:	83 c4 10             	add    $0x10,%esp
  801205:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if (check != 0) {
  80120b:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  801212:	74 17                	je     80122b <_main+0x11f3>
			panic("free: page is not removed from LRU lists");
  801214:	83 ec 04             	sub    $0x4,%esp
  801217:	68 9c 36 80 00       	push   $0x80369c
  80121c:	68 78 01 00 00       	push   $0x178
  801221:	68 ab 34 80 00       	push   $0x8034ab
  801226:	e8 09 06 00 00       	call   801834 <_panic>
		}

		if (LIST_SIZE(&myEnv->ActiveList) != 797
  80122b:	a1 20 40 80 00       	mov    0x804020,%eax
  801230:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  801236:	3d 1d 03 00 00       	cmp    $0x31d,%eax
  80123b:	74 26                	je     801263 <_main+0x122b>
				&& LIST_SIZE(&myEnv->SecondList) != 0) {
  80123d:	a1 20 40 80 00       	mov    0x804020,%eax
  801242:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  801248:	85 c0                	test   %eax,%eax
  80124a:	74 17                	je     801263 <_main+0x122b>
			panic("LRU lists content is not correct");
  80124c:	83 ec 04             	sub    $0x4,%esp
  80124f:	68 c8 36 80 00       	push   $0x8036c8
  801254:	68 7d 01 00 00       	push   $0x17d
  801259:	68 ab 34 80 00       	push   $0x8034ab
  80125e:	e8 d1 05 00 00       	call   801834 <_panic>
		}

		//Free 7 KB
		freeFrames = sys_calculate_free_frames();
  801263:	e8 ad 1a 00 00       	call   802d15 <sys_calculate_free_frames>
  801268:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80126e:	e8 25 1b 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  801273:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[4]);
  801279:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  80127f:	83 ec 0c             	sub    $0xc,%esp
  801282:	50                   	push   %eax
  801283:	e8 69 17 00 00       	call   8029f1 <free>
  801288:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2)
  80128b:	e8 08 1b 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  801290:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801296:	29 c2                	sub    %eax,%edx
  801298:	89 d0                	mov    %edx,%eax
  80129a:	83 f8 02             	cmp    $0x2,%eax
  80129d:	74 17                	je     8012b6 <_main+0x127e>
			panic("Wrong free: Extra or less pages are removed from PageFile");
  80129f:	83 ec 04             	sub    $0x4,%esp
  8012a2:	68 e8 35 80 00       	push   $0x8035e8
  8012a7:	68 85 01 00 00       	push   $0x185
  8012ac:	68 ab 34 80 00       	push   $0x8034ab
  8012b1:	e8 7e 05 00 00       	call   801834 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2)
  8012b6:	e8 5a 1a 00 00       	call   802d15 <sys_calculate_free_frames>
  8012bb:	89 c2                	mov    %eax,%edx
  8012bd:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  8012c3:	29 c2                	sub    %eax,%edx
  8012c5:	89 d0                	mov    %edx,%eax
  8012c7:	83 f8 02             	cmp    $0x2,%eax
  8012ca:	74 17                	je     8012e3 <_main+0x12ab>
			panic(
  8012cc:	83 ec 04             	sub    $0x4,%esp
  8012cf:	68 50 36 80 00       	push   $0x803650
  8012d4:	68 88 01 00 00       	push   $0x188
  8012d9:	68 ab 34 80 00       	push   $0x8034ab
  8012de:	e8 51 05 00 00       	call   801834 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32) (&(structArr[0]));
  8012e3:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8012e9:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32) (&(structArr[lastIndexOfStruct]));
  8012ef:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  8012f5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8012fc:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  801302:	01 d0                	add    %edx,%eax
  801304:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  80130a:	83 ec 08             	sub    $0x8,%esp
  80130d:	6a 02                	push   $0x2
  80130f:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  801315:	50                   	push   %eax
  801316:	e8 ce 1e 00 00       	call   8031e9 <sys_check_LRU_lists_free>
  80131b:	83 c4 10             	add    $0x10,%esp
  80131e:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if (check != 0) {
  801324:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  80132b:	74 17                	je     801344 <_main+0x130c>
			panic("free: page is not removed from LRU lists");
  80132d:	83 ec 04             	sub    $0x4,%esp
  801330:	68 9c 36 80 00       	push   $0x80369c
  801335:	68 95 01 00 00       	push   $0x195
  80133a:	68 ab 34 80 00       	push   $0x8034ab
  80133f:	e8 f0 04 00 00       	call   801834 <_panic>
		}

		if (LIST_SIZE(&myEnv->ActiveList) != 795
  801344:	a1 20 40 80 00       	mov    0x804020,%eax
  801349:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  80134f:	3d 1b 03 00 00       	cmp    $0x31b,%eax
  801354:	74 26                	je     80137c <_main+0x1344>
				&& LIST_SIZE(&myEnv->SecondList) != 0) {
  801356:	a1 20 40 80 00       	mov    0x804020,%eax
  80135b:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  801361:	85 c0                	test   %eax,%eax
  801363:	74 17                	je     80137c <_main+0x1344>
			panic("LRU lists content is not correct");
  801365:	83 ec 04             	sub    $0x4,%esp
  801368:	68 c8 36 80 00       	push   $0x8036c8
  80136d:	68 9a 01 00 00       	push   $0x19a
  801372:	68 ab 34 80 00       	push   $0x8034ab
  801377:	e8 b8 04 00 00       	call   801834 <_panic>
		}

		//Free 3 MB
		freeFrames = sys_calculate_free_frames();
  80137c:	e8 94 19 00 00       	call   802d15 <sys_calculate_free_frames>
  801381:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  801387:	e8 0c 1a 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  80138c:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[5]);
  801392:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  801398:	83 ec 0c             	sub    $0xc,%esp
  80139b:	50                   	push   %eax
  80139c:	e8 50 16 00 00       	call   8029f1 <free>
  8013a1:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages())
  8013a4:	e8 ef 19 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  8013a9:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  8013af:	89 d1                	mov    %edx,%ecx
  8013b1:	29 c1                	sub    %eax,%ecx
				!= 3 * Mega / 4096)
  8013b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8013b6:	89 c2                	mov    %eax,%edx
  8013b8:	01 d2                	add    %edx,%edx
  8013ba:	01 d0                	add    %edx,%eax
  8013bc:	85 c0                	test   %eax,%eax
  8013be:	79 05                	jns    8013c5 <_main+0x138d>
  8013c0:	05 ff 0f 00 00       	add    $0xfff,%eax
  8013c5:	c1 f8 0c             	sar    $0xc,%eax

		//Free 3 MB
		freeFrames = sys_calculate_free_frames();
		usedDiskPages = sys_pf_calculate_allocated_pages();
		free(ptr_allocations[5]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages())
  8013c8:	39 c1                	cmp    %eax,%ecx
  8013ca:	74 17                	je     8013e3 <_main+0x13ab>
				!= 3 * Mega / 4096)
			panic("Wrong free: Extra or less pages are removed from PageFile");
  8013cc:	83 ec 04             	sub    $0x4,%esp
  8013cf:	68 e8 35 80 00       	push   $0x8035e8
  8013d4:	68 a3 01 00 00       	push   $0x1a3
  8013d9:	68 ab 34 80 00       	push   $0x8034ab
  8013de:	e8 51 04 00 00       	call   801834 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != toAccess)
  8013e3:	e8 2d 19 00 00       	call   802d15 <sys_calculate_free_frames>
  8013e8:	89 c2                	mov    %eax,%edx
  8013ea:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  8013f0:	29 c2                	sub    %eax,%edx
  8013f2:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8013f5:	39 c2                	cmp    %eax,%edx
  8013f7:	74 17                	je     801410 <_main+0x13d8>
			panic(
  8013f9:	83 ec 04             	sub    $0x4,%esp
  8013fc:	68 50 36 80 00       	push   $0x803650
  801401:	68 a6 01 00 00       	push   $0x1a6
  801406:	68 ab 34 80 00       	push   $0x8034ab
  80140b:	e8 24 04 00 00       	call   801834 <_panic>
					"Wrong free: WS pages in memory and/or page tables are not freed correctly");

		//Free 1st 3 KB
		freeFrames = sys_calculate_free_frames();
  801410:	e8 00 19 00 00       	call   802d15 <sys_calculate_free_frames>
  801415:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80141b:	e8 78 19 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  801420:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[2]);
  801426:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  80142c:	83 ec 0c             	sub    $0xc,%esp
  80142f:	50                   	push   %eax
  801430:	e8 bc 15 00 00       	call   8029f1 <free>
  801435:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1)
  801438:	e8 5b 19 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  80143d:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801443:	29 c2                	sub    %eax,%edx
  801445:	89 d0                	mov    %edx,%eax
  801447:	83 f8 01             	cmp    $0x1,%eax
  80144a:	74 17                	je     801463 <_main+0x142b>
			panic("Wrong free: Extra or less pages are removed from PageFile");
  80144c:	83 ec 04             	sub    $0x4,%esp
  80144f:	68 e8 35 80 00       	push   $0x8035e8
  801454:	68 ad 01 00 00       	push   $0x1ad
  801459:	68 ab 34 80 00       	push   $0x8034ab
  80145e:	e8 d1 03 00 00       	call   801834 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 1 + 1)
  801463:	e8 ad 18 00 00       	call   802d15 <sys_calculate_free_frames>
  801468:	89 c2                	mov    %eax,%edx
  80146a:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801470:	29 c2                	sub    %eax,%edx
  801472:	89 d0                	mov    %edx,%eax
  801474:	83 f8 02             	cmp    $0x2,%eax
  801477:	74 17                	je     801490 <_main+0x1458>
			panic(
  801479:	83 ec 04             	sub    $0x4,%esp
  80147c:	68 50 36 80 00       	push   $0x803650
  801481:	68 b0 01 00 00       	push   $0x1b0
  801486:	68 ab 34 80 00       	push   $0x8034ab
  80148b:	e8 a4 03 00 00       	call   801834 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32) (&(intArr[0]));
  801490:	8b 45 88             	mov    -0x78(%ebp),%eax
  801493:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32) (&(intArr[lastIndexOfInt]));
  801499:	8b 45 84             	mov    -0x7c(%ebp),%eax
  80149c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014a3:	8b 45 88             	mov    -0x78(%ebp),%eax
  8014a6:	01 d0                	add    %edx,%eax
  8014a8:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  8014ae:	83 ec 08             	sub    $0x8,%esp
  8014b1:	6a 02                	push   $0x2
  8014b3:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  8014b9:	50                   	push   %eax
  8014ba:	e8 2a 1d 00 00       	call   8031e9 <sys_check_LRU_lists_free>
  8014bf:	83 c4 10             	add    $0x10,%esp
  8014c2:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if (check != 0) {
  8014c8:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  8014cf:	74 17                	je     8014e8 <_main+0x14b0>
			panic("free: page is not removed from LRU lists");
  8014d1:	83 ec 04             	sub    $0x4,%esp
  8014d4:	68 9c 36 80 00       	push   $0x80369c
  8014d9:	68 bd 01 00 00       	push   $0x1bd
  8014de:	68 ab 34 80 00       	push   $0x8034ab
  8014e3:	e8 4c 03 00 00       	call   801834 <_panic>
		}

		if (LIST_SIZE(&myEnv->ActiveList) != 794
  8014e8:	a1 20 40 80 00       	mov    0x804020,%eax
  8014ed:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  8014f3:	3d 1a 03 00 00       	cmp    $0x31a,%eax
  8014f8:	74 26                	je     801520 <_main+0x14e8>
				&& LIST_SIZE(&myEnv->SecondList) != 0) {
  8014fa:	a1 20 40 80 00       	mov    0x804020,%eax
  8014ff:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  801505:	85 c0                	test   %eax,%eax
  801507:	74 17                	je     801520 <_main+0x14e8>
			panic("LRU lists content is not correct");
  801509:	83 ec 04             	sub    $0x4,%esp
  80150c:	68 c8 36 80 00       	push   $0x8036c8
  801511:	68 c2 01 00 00       	push   $0x1c2
  801516:	68 ab 34 80 00       	push   $0x8034ab
  80151b:	e8 14 03 00 00       	call   801834 <_panic>
		}

		//Free 2nd 3 KB
		freeFrames = sys_calculate_free_frames();
  801520:	e8 f0 17 00 00       	call   802d15 <sys_calculate_free_frames>
  801525:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80152b:	e8 68 18 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  801530:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[3]);
  801536:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  80153c:	83 ec 0c             	sub    $0xc,%esp
  80153f:	50                   	push   %eax
  801540:	e8 ac 14 00 00       	call   8029f1 <free>
  801545:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1)
  801548:	e8 4b 18 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  80154d:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801553:	29 c2                	sub    %eax,%edx
  801555:	89 d0                	mov    %edx,%eax
  801557:	83 f8 01             	cmp    $0x1,%eax
  80155a:	74 17                	je     801573 <_main+0x153b>
			panic("Wrong free: Extra or less pages are removed from PageFile");
  80155c:	83 ec 04             	sub    $0x4,%esp
  80155f:	68 e8 35 80 00       	push   $0x8035e8
  801564:	68 ca 01 00 00       	push   $0x1ca
  801569:	68 ab 34 80 00       	push   $0x8034ab
  80156e:	e8 c1 02 00 00       	call   801834 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0)
  801573:	e8 9d 17 00 00       	call   802d15 <sys_calculate_free_frames>
  801578:	89 c2                	mov    %eax,%edx
  80157a:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801580:	39 c2                	cmp    %eax,%edx
  801582:	74 17                	je     80159b <_main+0x1563>
			panic(
  801584:	83 ec 04             	sub    $0x4,%esp
  801587:	68 50 36 80 00       	push   $0x803650
  80158c:	68 cd 01 00 00       	push   $0x1cd
  801591:	68 ab 34 80 00       	push   $0x8034ab
  801596:	e8 99 02 00 00       	call   801834 <_panic>
					"Wrong free: WS pages in memory and/or page tables are not freed correctly");

		//Free last 14 KB
		freeFrames = sys_calculate_free_frames();
  80159b:	e8 75 17 00 00       	call   802d15 <sys_calculate_free_frames>
  8015a0:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8015a6:	e8 ed 17 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  8015ab:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[7]);
  8015b1:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  8015b7:	83 ec 0c             	sub    $0xc,%esp
  8015ba:	50                   	push   %eax
  8015bb:	e8 31 14 00 00       	call   8029f1 <free>
  8015c0:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 4)
  8015c3:	e8 d0 17 00 00       	call   802d98 <sys_pf_calculate_allocated_pages>
  8015c8:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  8015ce:	29 c2                	sub    %eax,%edx
  8015d0:	89 d0                	mov    %edx,%eax
  8015d2:	83 f8 04             	cmp    $0x4,%eax
  8015d5:	74 17                	je     8015ee <_main+0x15b6>
			panic("Wrong free: Extra or less pages are removed from PageFile");
  8015d7:	83 ec 04             	sub    $0x4,%esp
  8015da:	68 e8 35 80 00       	push   $0x8035e8
  8015df:	68 d4 01 00 00       	push   $0x1d4
  8015e4:	68 ab 34 80 00       	push   $0x8034ab
  8015e9:	e8 46 02 00 00       	call   801834 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1)
  8015ee:	e8 22 17 00 00       	call   802d15 <sys_calculate_free_frames>
  8015f3:	89 c2                	mov    %eax,%edx
  8015f5:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  8015fb:	29 c2                	sub    %eax,%edx
  8015fd:	89 d0                	mov    %edx,%eax
  8015ff:	83 f8 03             	cmp    $0x3,%eax
  801602:	74 17                	je     80161b <_main+0x15e3>
			panic(
  801604:	83 ec 04             	sub    $0x4,%esp
  801607:	68 50 36 80 00       	push   $0x803650
  80160c:	68 d7 01 00 00       	push   $0x1d7
  801611:	68 ab 34 80 00       	push   $0x8034ab
  801616:	e8 19 02 00 00       	call   801834 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32) (&(shortArr2[0]));
  80161b:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  801621:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32) (&(shortArr2[lastIndexOfShort2]));
  801627:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  80162d:	01 c0                	add    %eax,%eax
  80162f:	89 c2                	mov    %eax,%edx
  801631:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  801637:	01 d0                	add    %edx,%eax
  801639:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  80163f:	83 ec 08             	sub    $0x8,%esp
  801642:	6a 02                	push   $0x2
  801644:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  80164a:	50                   	push   %eax
  80164b:	e8 99 1b 00 00       	call   8031e9 <sys_check_LRU_lists_free>
  801650:	83 c4 10             	add    $0x10,%esp
  801653:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if (check != 0) {
  801659:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  801660:	74 17                	je     801679 <_main+0x1641>
			panic("free: page is not removed from LRU lists");
  801662:	83 ec 04             	sub    $0x4,%esp
  801665:	68 9c 36 80 00       	push   $0x80369c
  80166a:	68 e4 01 00 00       	push   $0x1e4
  80166f:	68 ab 34 80 00       	push   $0x8034ab
  801674:	e8 bb 01 00 00       	call   801834 <_panic>
		}

		if (LIST_SIZE(&myEnv->ActiveList) != 792
  801679:	a1 20 40 80 00       	mov    0x804020,%eax
  80167e:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  801684:	3d 18 03 00 00       	cmp    $0x318,%eax
  801689:	74 26                	je     8016b1 <_main+0x1679>
				&& LIST_SIZE(&myEnv->SecondList) != 0) {
  80168b:	a1 20 40 80 00       	mov    0x804020,%eax
  801690:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  801696:	85 c0                	test   %eax,%eax
  801698:	74 17                	je     8016b1 <_main+0x1679>
			panic("LRU lists content is not correct");
  80169a:	83 ec 04             	sub    $0x4,%esp
  80169d:	68 c8 36 80 00       	push   $0x8036c8
  8016a2:	68 e9 01 00 00       	push   $0x1e9
  8016a7:	68 ab 34 80 00       	push   $0x8034ab
  8016ac:	e8 83 01 00 00       	call   801834 <_panic>
		}

		if (start_freeFrames != (sys_calculate_free_frames() + 4)) {
  8016b1:	e8 5f 16 00 00       	call   802d15 <sys_calculate_free_frames>
  8016b6:	8d 50 04             	lea    0x4(%eax),%edx
  8016b9:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8016bc:	39 c2                	cmp    %eax,%edx
  8016be:	74 17                	je     8016d7 <_main+0x169f>
			panic("Wrong free: not all pages removed correctly at end");
  8016c0:	83 ec 04             	sub    $0x4,%esp
  8016c3:	68 00 37 80 00       	push   $0x803700
  8016c8:	68 ed 01 00 00       	push   $0x1ed
  8016cd:	68 ab 34 80 00       	push   $0x8034ab
  8016d2:	e8 5d 01 00 00       	call   801834 <_panic>
		}
	}

	cprintf("Congratulations!! test free [1] completed successfully.\n");
  8016d7:	83 ec 0c             	sub    $0xc,%esp
  8016da:	68 34 37 80 00       	push   $0x803734
  8016df:	e8 f2 03 00 00       	call   801ad6 <cprintf>
  8016e4:	83 c4 10             	add    $0x10,%esp

	return;
  8016e7:	90                   	nop
}
  8016e8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8016eb:	5b                   	pop    %ebx
  8016ec:	5f                   	pop    %edi
  8016ed:	5d                   	pop    %ebp
  8016ee:	c3                   	ret    

008016ef <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8016ef:	55                   	push   %ebp
  8016f0:	89 e5                	mov    %esp,%ebp
  8016f2:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8016f5:	e8 50 15 00 00       	call   802c4a <sys_getenvindex>
  8016fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8016fd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801700:	89 d0                	mov    %edx,%eax
  801702:	c1 e0 03             	shl    $0x3,%eax
  801705:	01 d0                	add    %edx,%eax
  801707:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80170e:	01 c8                	add    %ecx,%eax
  801710:	01 c0                	add    %eax,%eax
  801712:	01 d0                	add    %edx,%eax
  801714:	01 c0                	add    %eax,%eax
  801716:	01 d0                	add    %edx,%eax
  801718:	89 c2                	mov    %eax,%edx
  80171a:	c1 e2 05             	shl    $0x5,%edx
  80171d:	29 c2                	sub    %eax,%edx
  80171f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  801726:	89 c2                	mov    %eax,%edx
  801728:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80172e:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  801733:	a1 20 40 80 00       	mov    0x804020,%eax
  801738:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80173e:	84 c0                	test   %al,%al
  801740:	74 0f                	je     801751 <libmain+0x62>
		binaryname = myEnv->prog_name;
  801742:	a1 20 40 80 00       	mov    0x804020,%eax
  801747:	05 40 3c 01 00       	add    $0x13c40,%eax
  80174c:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  801751:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801755:	7e 0a                	jle    801761 <libmain+0x72>
		binaryname = argv[0];
  801757:	8b 45 0c             	mov    0xc(%ebp),%eax
  80175a:	8b 00                	mov    (%eax),%eax
  80175c:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  801761:	83 ec 08             	sub    $0x8,%esp
  801764:	ff 75 0c             	pushl  0xc(%ebp)
  801767:	ff 75 08             	pushl  0x8(%ebp)
  80176a:	e8 c9 e8 ff ff       	call   800038 <_main>
  80176f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  801772:	e8 6e 16 00 00       	call   802de5 <sys_disable_interrupt>
	cprintf("**************************************\n");
  801777:	83 ec 0c             	sub    $0xc,%esp
  80177a:	68 88 37 80 00       	push   $0x803788
  80177f:	e8 52 03 00 00       	call   801ad6 <cprintf>
  801784:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  801787:	a1 20 40 80 00       	mov    0x804020,%eax
  80178c:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  801792:	a1 20 40 80 00       	mov    0x804020,%eax
  801797:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80179d:	83 ec 04             	sub    $0x4,%esp
  8017a0:	52                   	push   %edx
  8017a1:	50                   	push   %eax
  8017a2:	68 b0 37 80 00       	push   $0x8037b0
  8017a7:	e8 2a 03 00 00       	call   801ad6 <cprintf>
  8017ac:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8017af:	a1 20 40 80 00       	mov    0x804020,%eax
  8017b4:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8017ba:	a1 20 40 80 00       	mov    0x804020,%eax
  8017bf:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8017c5:	83 ec 04             	sub    $0x4,%esp
  8017c8:	52                   	push   %edx
  8017c9:	50                   	push   %eax
  8017ca:	68 d8 37 80 00       	push   $0x8037d8
  8017cf:	e8 02 03 00 00       	call   801ad6 <cprintf>
  8017d4:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8017d7:	a1 20 40 80 00       	mov    0x804020,%eax
  8017dc:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8017e2:	83 ec 08             	sub    $0x8,%esp
  8017e5:	50                   	push   %eax
  8017e6:	68 19 38 80 00       	push   $0x803819
  8017eb:	e8 e6 02 00 00       	call   801ad6 <cprintf>
  8017f0:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8017f3:	83 ec 0c             	sub    $0xc,%esp
  8017f6:	68 88 37 80 00       	push   $0x803788
  8017fb:	e8 d6 02 00 00       	call   801ad6 <cprintf>
  801800:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  801803:	e8 f7 15 00 00       	call   802dff <sys_enable_interrupt>

	// exit gracefully
	exit();
  801808:	e8 19 00 00 00       	call   801826 <exit>
}
  80180d:	90                   	nop
  80180e:	c9                   	leave  
  80180f:	c3                   	ret    

00801810 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  801810:	55                   	push   %ebp
  801811:	89 e5                	mov    %esp,%ebp
  801813:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  801816:	83 ec 0c             	sub    $0xc,%esp
  801819:	6a 00                	push   $0x0
  80181b:	e8 f6 13 00 00       	call   802c16 <sys_env_destroy>
  801820:	83 c4 10             	add    $0x10,%esp
}
  801823:	90                   	nop
  801824:	c9                   	leave  
  801825:	c3                   	ret    

00801826 <exit>:

void
exit(void)
{
  801826:	55                   	push   %ebp
  801827:	89 e5                	mov    %esp,%ebp
  801829:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80182c:	e8 4b 14 00 00       	call   802c7c <sys_env_exit>
}
  801831:	90                   	nop
  801832:	c9                   	leave  
  801833:	c3                   	ret    

00801834 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801834:	55                   	push   %ebp
  801835:	89 e5                	mov    %esp,%ebp
  801837:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80183a:	8d 45 10             	lea    0x10(%ebp),%eax
  80183d:	83 c0 04             	add    $0x4,%eax
  801840:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801843:	a1 18 41 80 00       	mov    0x804118,%eax
  801848:	85 c0                	test   %eax,%eax
  80184a:	74 16                	je     801862 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80184c:	a1 18 41 80 00       	mov    0x804118,%eax
  801851:	83 ec 08             	sub    $0x8,%esp
  801854:	50                   	push   %eax
  801855:	68 30 38 80 00       	push   $0x803830
  80185a:	e8 77 02 00 00       	call   801ad6 <cprintf>
  80185f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801862:	a1 00 40 80 00       	mov    0x804000,%eax
  801867:	ff 75 0c             	pushl  0xc(%ebp)
  80186a:	ff 75 08             	pushl  0x8(%ebp)
  80186d:	50                   	push   %eax
  80186e:	68 35 38 80 00       	push   $0x803835
  801873:	e8 5e 02 00 00       	call   801ad6 <cprintf>
  801878:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80187b:	8b 45 10             	mov    0x10(%ebp),%eax
  80187e:	83 ec 08             	sub    $0x8,%esp
  801881:	ff 75 f4             	pushl  -0xc(%ebp)
  801884:	50                   	push   %eax
  801885:	e8 e1 01 00 00       	call   801a6b <vcprintf>
  80188a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80188d:	83 ec 08             	sub    $0x8,%esp
  801890:	6a 00                	push   $0x0
  801892:	68 51 38 80 00       	push   $0x803851
  801897:	e8 cf 01 00 00       	call   801a6b <vcprintf>
  80189c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80189f:	e8 82 ff ff ff       	call   801826 <exit>

	// should not return here
	while (1) ;
  8018a4:	eb fe                	jmp    8018a4 <_panic+0x70>

008018a6 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8018a6:	55                   	push   %ebp
  8018a7:	89 e5                	mov    %esp,%ebp
  8018a9:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8018ac:	a1 20 40 80 00       	mov    0x804020,%eax
  8018b1:	8b 50 74             	mov    0x74(%eax),%edx
  8018b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b7:	39 c2                	cmp    %eax,%edx
  8018b9:	74 14                	je     8018cf <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8018bb:	83 ec 04             	sub    $0x4,%esp
  8018be:	68 54 38 80 00       	push   $0x803854
  8018c3:	6a 26                	push   $0x26
  8018c5:	68 a0 38 80 00       	push   $0x8038a0
  8018ca:	e8 65 ff ff ff       	call   801834 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8018cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8018d6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8018dd:	e9 b6 00 00 00       	jmp    801998 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8018e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018e5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ef:	01 d0                	add    %edx,%eax
  8018f1:	8b 00                	mov    (%eax),%eax
  8018f3:	85 c0                	test   %eax,%eax
  8018f5:	75 08                	jne    8018ff <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8018f7:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8018fa:	e9 96 00 00 00       	jmp    801995 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8018ff:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801906:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80190d:	eb 5d                	jmp    80196c <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80190f:	a1 20 40 80 00       	mov    0x804020,%eax
  801914:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80191a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80191d:	c1 e2 04             	shl    $0x4,%edx
  801920:	01 d0                	add    %edx,%eax
  801922:	8a 40 04             	mov    0x4(%eax),%al
  801925:	84 c0                	test   %al,%al
  801927:	75 40                	jne    801969 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801929:	a1 20 40 80 00       	mov    0x804020,%eax
  80192e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801934:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801937:	c1 e2 04             	shl    $0x4,%edx
  80193a:	01 d0                	add    %edx,%eax
  80193c:	8b 00                	mov    (%eax),%eax
  80193e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801941:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801944:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801949:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80194b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80194e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801955:	8b 45 08             	mov    0x8(%ebp),%eax
  801958:	01 c8                	add    %ecx,%eax
  80195a:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80195c:	39 c2                	cmp    %eax,%edx
  80195e:	75 09                	jne    801969 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  801960:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801967:	eb 12                	jmp    80197b <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801969:	ff 45 e8             	incl   -0x18(%ebp)
  80196c:	a1 20 40 80 00       	mov    0x804020,%eax
  801971:	8b 50 74             	mov    0x74(%eax),%edx
  801974:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801977:	39 c2                	cmp    %eax,%edx
  801979:	77 94                	ja     80190f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80197b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80197f:	75 14                	jne    801995 <CheckWSWithoutLastIndex+0xef>
			panic(
  801981:	83 ec 04             	sub    $0x4,%esp
  801984:	68 ac 38 80 00       	push   $0x8038ac
  801989:	6a 3a                	push   $0x3a
  80198b:	68 a0 38 80 00       	push   $0x8038a0
  801990:	e8 9f fe ff ff       	call   801834 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801995:	ff 45 f0             	incl   -0x10(%ebp)
  801998:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80199b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80199e:	0f 8c 3e ff ff ff    	jl     8018e2 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8019a4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019ab:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8019b2:	eb 20                	jmp    8019d4 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8019b4:	a1 20 40 80 00       	mov    0x804020,%eax
  8019b9:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8019bf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8019c2:	c1 e2 04             	shl    $0x4,%edx
  8019c5:	01 d0                	add    %edx,%eax
  8019c7:	8a 40 04             	mov    0x4(%eax),%al
  8019ca:	3c 01                	cmp    $0x1,%al
  8019cc:	75 03                	jne    8019d1 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8019ce:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019d1:	ff 45 e0             	incl   -0x20(%ebp)
  8019d4:	a1 20 40 80 00       	mov    0x804020,%eax
  8019d9:	8b 50 74             	mov    0x74(%eax),%edx
  8019dc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8019df:	39 c2                	cmp    %eax,%edx
  8019e1:	77 d1                	ja     8019b4 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8019e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019e6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019e9:	74 14                	je     8019ff <CheckWSWithoutLastIndex+0x159>
		panic(
  8019eb:	83 ec 04             	sub    $0x4,%esp
  8019ee:	68 00 39 80 00       	push   $0x803900
  8019f3:	6a 44                	push   $0x44
  8019f5:	68 a0 38 80 00       	push   $0x8038a0
  8019fa:	e8 35 fe ff ff       	call   801834 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8019ff:	90                   	nop
  801a00:	c9                   	leave  
  801a01:	c3                   	ret    

00801a02 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  801a02:	55                   	push   %ebp
  801a03:	89 e5                	mov    %esp,%ebp
  801a05:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801a08:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a0b:	8b 00                	mov    (%eax),%eax
  801a0d:	8d 48 01             	lea    0x1(%eax),%ecx
  801a10:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a13:	89 0a                	mov    %ecx,(%edx)
  801a15:	8b 55 08             	mov    0x8(%ebp),%edx
  801a18:	88 d1                	mov    %dl,%cl
  801a1a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a1d:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  801a21:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a24:	8b 00                	mov    (%eax),%eax
  801a26:	3d ff 00 00 00       	cmp    $0xff,%eax
  801a2b:	75 2c                	jne    801a59 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  801a2d:	a0 24 40 80 00       	mov    0x804024,%al
  801a32:	0f b6 c0             	movzbl %al,%eax
  801a35:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a38:	8b 12                	mov    (%edx),%edx
  801a3a:	89 d1                	mov    %edx,%ecx
  801a3c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a3f:	83 c2 08             	add    $0x8,%edx
  801a42:	83 ec 04             	sub    $0x4,%esp
  801a45:	50                   	push   %eax
  801a46:	51                   	push   %ecx
  801a47:	52                   	push   %edx
  801a48:	e8 87 11 00 00       	call   802bd4 <sys_cputs>
  801a4d:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  801a50:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a53:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  801a59:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a5c:	8b 40 04             	mov    0x4(%eax),%eax
  801a5f:	8d 50 01             	lea    0x1(%eax),%edx
  801a62:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a65:	89 50 04             	mov    %edx,0x4(%eax)
}
  801a68:	90                   	nop
  801a69:	c9                   	leave  
  801a6a:	c3                   	ret    

00801a6b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  801a6b:	55                   	push   %ebp
  801a6c:	89 e5                	mov    %esp,%ebp
  801a6e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  801a74:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  801a7b:	00 00 00 
	b.cnt = 0;
  801a7e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  801a85:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  801a88:	ff 75 0c             	pushl  0xc(%ebp)
  801a8b:	ff 75 08             	pushl  0x8(%ebp)
  801a8e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801a94:	50                   	push   %eax
  801a95:	68 02 1a 80 00       	push   $0x801a02
  801a9a:	e8 11 02 00 00       	call   801cb0 <vprintfmt>
  801a9f:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  801aa2:	a0 24 40 80 00       	mov    0x804024,%al
  801aa7:	0f b6 c0             	movzbl %al,%eax
  801aaa:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  801ab0:	83 ec 04             	sub    $0x4,%esp
  801ab3:	50                   	push   %eax
  801ab4:	52                   	push   %edx
  801ab5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801abb:	83 c0 08             	add    $0x8,%eax
  801abe:	50                   	push   %eax
  801abf:	e8 10 11 00 00       	call   802bd4 <sys_cputs>
  801ac4:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801ac7:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  801ace:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801ad4:	c9                   	leave  
  801ad5:	c3                   	ret    

00801ad6 <cprintf>:

int cprintf(const char *fmt, ...) {
  801ad6:	55                   	push   %ebp
  801ad7:	89 e5                	mov    %esp,%ebp
  801ad9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  801adc:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  801ae3:	8d 45 0c             	lea    0xc(%ebp),%eax
  801ae6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801ae9:	8b 45 08             	mov    0x8(%ebp),%eax
  801aec:	83 ec 08             	sub    $0x8,%esp
  801aef:	ff 75 f4             	pushl  -0xc(%ebp)
  801af2:	50                   	push   %eax
  801af3:	e8 73 ff ff ff       	call   801a6b <vcprintf>
  801af8:	83 c4 10             	add    $0x10,%esp
  801afb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  801afe:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801b01:	c9                   	leave  
  801b02:	c3                   	ret    

00801b03 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801b03:	55                   	push   %ebp
  801b04:	89 e5                	mov    %esp,%ebp
  801b06:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801b09:	e8 d7 12 00 00       	call   802de5 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801b0e:	8d 45 0c             	lea    0xc(%ebp),%eax
  801b11:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801b14:	8b 45 08             	mov    0x8(%ebp),%eax
  801b17:	83 ec 08             	sub    $0x8,%esp
  801b1a:	ff 75 f4             	pushl  -0xc(%ebp)
  801b1d:	50                   	push   %eax
  801b1e:	e8 48 ff ff ff       	call   801a6b <vcprintf>
  801b23:	83 c4 10             	add    $0x10,%esp
  801b26:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801b29:	e8 d1 12 00 00       	call   802dff <sys_enable_interrupt>
	return cnt;
  801b2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801b31:	c9                   	leave  
  801b32:	c3                   	ret    

00801b33 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801b33:	55                   	push   %ebp
  801b34:	89 e5                	mov    %esp,%ebp
  801b36:	53                   	push   %ebx
  801b37:	83 ec 14             	sub    $0x14,%esp
  801b3a:	8b 45 10             	mov    0x10(%ebp),%eax
  801b3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801b40:	8b 45 14             	mov    0x14(%ebp),%eax
  801b43:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801b46:	8b 45 18             	mov    0x18(%ebp),%eax
  801b49:	ba 00 00 00 00       	mov    $0x0,%edx
  801b4e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801b51:	77 55                	ja     801ba8 <printnum+0x75>
  801b53:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801b56:	72 05                	jb     801b5d <printnum+0x2a>
  801b58:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b5b:	77 4b                	ja     801ba8 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801b5d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  801b60:	8d 58 ff             	lea    -0x1(%eax),%ebx
  801b63:	8b 45 18             	mov    0x18(%ebp),%eax
  801b66:	ba 00 00 00 00       	mov    $0x0,%edx
  801b6b:	52                   	push   %edx
  801b6c:	50                   	push   %eax
  801b6d:	ff 75 f4             	pushl  -0xc(%ebp)
  801b70:	ff 75 f0             	pushl  -0x10(%ebp)
  801b73:	e8 90 16 00 00       	call   803208 <__udivdi3>
  801b78:	83 c4 10             	add    $0x10,%esp
  801b7b:	83 ec 04             	sub    $0x4,%esp
  801b7e:	ff 75 20             	pushl  0x20(%ebp)
  801b81:	53                   	push   %ebx
  801b82:	ff 75 18             	pushl  0x18(%ebp)
  801b85:	52                   	push   %edx
  801b86:	50                   	push   %eax
  801b87:	ff 75 0c             	pushl  0xc(%ebp)
  801b8a:	ff 75 08             	pushl  0x8(%ebp)
  801b8d:	e8 a1 ff ff ff       	call   801b33 <printnum>
  801b92:	83 c4 20             	add    $0x20,%esp
  801b95:	eb 1a                	jmp    801bb1 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801b97:	83 ec 08             	sub    $0x8,%esp
  801b9a:	ff 75 0c             	pushl  0xc(%ebp)
  801b9d:	ff 75 20             	pushl  0x20(%ebp)
  801ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba3:	ff d0                	call   *%eax
  801ba5:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801ba8:	ff 4d 1c             	decl   0x1c(%ebp)
  801bab:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801baf:	7f e6                	jg     801b97 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801bb1:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801bb4:	bb 00 00 00 00       	mov    $0x0,%ebx
  801bb9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bbc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801bbf:	53                   	push   %ebx
  801bc0:	51                   	push   %ecx
  801bc1:	52                   	push   %edx
  801bc2:	50                   	push   %eax
  801bc3:	e8 50 17 00 00       	call   803318 <__umoddi3>
  801bc8:	83 c4 10             	add    $0x10,%esp
  801bcb:	05 74 3b 80 00       	add    $0x803b74,%eax
  801bd0:	8a 00                	mov    (%eax),%al
  801bd2:	0f be c0             	movsbl %al,%eax
  801bd5:	83 ec 08             	sub    $0x8,%esp
  801bd8:	ff 75 0c             	pushl  0xc(%ebp)
  801bdb:	50                   	push   %eax
  801bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdf:	ff d0                	call   *%eax
  801be1:	83 c4 10             	add    $0x10,%esp
}
  801be4:	90                   	nop
  801be5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801be8:	c9                   	leave  
  801be9:	c3                   	ret    

00801bea <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801bea:	55                   	push   %ebp
  801beb:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801bed:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801bf1:	7e 1c                	jle    801c0f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf6:	8b 00                	mov    (%eax),%eax
  801bf8:	8d 50 08             	lea    0x8(%eax),%edx
  801bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bfe:	89 10                	mov    %edx,(%eax)
  801c00:	8b 45 08             	mov    0x8(%ebp),%eax
  801c03:	8b 00                	mov    (%eax),%eax
  801c05:	83 e8 08             	sub    $0x8,%eax
  801c08:	8b 50 04             	mov    0x4(%eax),%edx
  801c0b:	8b 00                	mov    (%eax),%eax
  801c0d:	eb 40                	jmp    801c4f <getuint+0x65>
	else if (lflag)
  801c0f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801c13:	74 1e                	je     801c33 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801c15:	8b 45 08             	mov    0x8(%ebp),%eax
  801c18:	8b 00                	mov    (%eax),%eax
  801c1a:	8d 50 04             	lea    0x4(%eax),%edx
  801c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c20:	89 10                	mov    %edx,(%eax)
  801c22:	8b 45 08             	mov    0x8(%ebp),%eax
  801c25:	8b 00                	mov    (%eax),%eax
  801c27:	83 e8 04             	sub    $0x4,%eax
  801c2a:	8b 00                	mov    (%eax),%eax
  801c2c:	ba 00 00 00 00       	mov    $0x0,%edx
  801c31:	eb 1c                	jmp    801c4f <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801c33:	8b 45 08             	mov    0x8(%ebp),%eax
  801c36:	8b 00                	mov    (%eax),%eax
  801c38:	8d 50 04             	lea    0x4(%eax),%edx
  801c3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3e:	89 10                	mov    %edx,(%eax)
  801c40:	8b 45 08             	mov    0x8(%ebp),%eax
  801c43:	8b 00                	mov    (%eax),%eax
  801c45:	83 e8 04             	sub    $0x4,%eax
  801c48:	8b 00                	mov    (%eax),%eax
  801c4a:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801c4f:	5d                   	pop    %ebp
  801c50:	c3                   	ret    

00801c51 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801c51:	55                   	push   %ebp
  801c52:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801c54:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801c58:	7e 1c                	jle    801c76 <getint+0x25>
		return va_arg(*ap, long long);
  801c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5d:	8b 00                	mov    (%eax),%eax
  801c5f:	8d 50 08             	lea    0x8(%eax),%edx
  801c62:	8b 45 08             	mov    0x8(%ebp),%eax
  801c65:	89 10                	mov    %edx,(%eax)
  801c67:	8b 45 08             	mov    0x8(%ebp),%eax
  801c6a:	8b 00                	mov    (%eax),%eax
  801c6c:	83 e8 08             	sub    $0x8,%eax
  801c6f:	8b 50 04             	mov    0x4(%eax),%edx
  801c72:	8b 00                	mov    (%eax),%eax
  801c74:	eb 38                	jmp    801cae <getint+0x5d>
	else if (lflag)
  801c76:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801c7a:	74 1a                	je     801c96 <getint+0x45>
		return va_arg(*ap, long);
  801c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7f:	8b 00                	mov    (%eax),%eax
  801c81:	8d 50 04             	lea    0x4(%eax),%edx
  801c84:	8b 45 08             	mov    0x8(%ebp),%eax
  801c87:	89 10                	mov    %edx,(%eax)
  801c89:	8b 45 08             	mov    0x8(%ebp),%eax
  801c8c:	8b 00                	mov    (%eax),%eax
  801c8e:	83 e8 04             	sub    $0x4,%eax
  801c91:	8b 00                	mov    (%eax),%eax
  801c93:	99                   	cltd   
  801c94:	eb 18                	jmp    801cae <getint+0x5d>
	else
		return va_arg(*ap, int);
  801c96:	8b 45 08             	mov    0x8(%ebp),%eax
  801c99:	8b 00                	mov    (%eax),%eax
  801c9b:	8d 50 04             	lea    0x4(%eax),%edx
  801c9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca1:	89 10                	mov    %edx,(%eax)
  801ca3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca6:	8b 00                	mov    (%eax),%eax
  801ca8:	83 e8 04             	sub    $0x4,%eax
  801cab:	8b 00                	mov    (%eax),%eax
  801cad:	99                   	cltd   
}
  801cae:	5d                   	pop    %ebp
  801caf:	c3                   	ret    

00801cb0 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801cb0:	55                   	push   %ebp
  801cb1:	89 e5                	mov    %esp,%ebp
  801cb3:	56                   	push   %esi
  801cb4:	53                   	push   %ebx
  801cb5:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801cb8:	eb 17                	jmp    801cd1 <vprintfmt+0x21>
			if (ch == '\0')
  801cba:	85 db                	test   %ebx,%ebx
  801cbc:	0f 84 af 03 00 00    	je     802071 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801cc2:	83 ec 08             	sub    $0x8,%esp
  801cc5:	ff 75 0c             	pushl  0xc(%ebp)
  801cc8:	53                   	push   %ebx
  801cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  801ccc:	ff d0                	call   *%eax
  801cce:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801cd1:	8b 45 10             	mov    0x10(%ebp),%eax
  801cd4:	8d 50 01             	lea    0x1(%eax),%edx
  801cd7:	89 55 10             	mov    %edx,0x10(%ebp)
  801cda:	8a 00                	mov    (%eax),%al
  801cdc:	0f b6 d8             	movzbl %al,%ebx
  801cdf:	83 fb 25             	cmp    $0x25,%ebx
  801ce2:	75 d6                	jne    801cba <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801ce4:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801ce8:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801cef:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801cf6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801cfd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801d04:	8b 45 10             	mov    0x10(%ebp),%eax
  801d07:	8d 50 01             	lea    0x1(%eax),%edx
  801d0a:	89 55 10             	mov    %edx,0x10(%ebp)
  801d0d:	8a 00                	mov    (%eax),%al
  801d0f:	0f b6 d8             	movzbl %al,%ebx
  801d12:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801d15:	83 f8 55             	cmp    $0x55,%eax
  801d18:	0f 87 2b 03 00 00    	ja     802049 <vprintfmt+0x399>
  801d1e:	8b 04 85 98 3b 80 00 	mov    0x803b98(,%eax,4),%eax
  801d25:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801d27:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801d2b:	eb d7                	jmp    801d04 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801d2d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801d31:	eb d1                	jmp    801d04 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801d33:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801d3a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801d3d:	89 d0                	mov    %edx,%eax
  801d3f:	c1 e0 02             	shl    $0x2,%eax
  801d42:	01 d0                	add    %edx,%eax
  801d44:	01 c0                	add    %eax,%eax
  801d46:	01 d8                	add    %ebx,%eax
  801d48:	83 e8 30             	sub    $0x30,%eax
  801d4b:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801d4e:	8b 45 10             	mov    0x10(%ebp),%eax
  801d51:	8a 00                	mov    (%eax),%al
  801d53:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801d56:	83 fb 2f             	cmp    $0x2f,%ebx
  801d59:	7e 3e                	jle    801d99 <vprintfmt+0xe9>
  801d5b:	83 fb 39             	cmp    $0x39,%ebx
  801d5e:	7f 39                	jg     801d99 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801d60:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801d63:	eb d5                	jmp    801d3a <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801d65:	8b 45 14             	mov    0x14(%ebp),%eax
  801d68:	83 c0 04             	add    $0x4,%eax
  801d6b:	89 45 14             	mov    %eax,0x14(%ebp)
  801d6e:	8b 45 14             	mov    0x14(%ebp),%eax
  801d71:	83 e8 04             	sub    $0x4,%eax
  801d74:	8b 00                	mov    (%eax),%eax
  801d76:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801d79:	eb 1f                	jmp    801d9a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801d7b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801d7f:	79 83                	jns    801d04 <vprintfmt+0x54>
				width = 0;
  801d81:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801d88:	e9 77 ff ff ff       	jmp    801d04 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801d8d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801d94:	e9 6b ff ff ff       	jmp    801d04 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801d99:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801d9a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801d9e:	0f 89 60 ff ff ff    	jns    801d04 <vprintfmt+0x54>
				width = precision, precision = -1;
  801da4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801da7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801daa:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801db1:	e9 4e ff ff ff       	jmp    801d04 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801db6:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801db9:	e9 46 ff ff ff       	jmp    801d04 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801dbe:	8b 45 14             	mov    0x14(%ebp),%eax
  801dc1:	83 c0 04             	add    $0x4,%eax
  801dc4:	89 45 14             	mov    %eax,0x14(%ebp)
  801dc7:	8b 45 14             	mov    0x14(%ebp),%eax
  801dca:	83 e8 04             	sub    $0x4,%eax
  801dcd:	8b 00                	mov    (%eax),%eax
  801dcf:	83 ec 08             	sub    $0x8,%esp
  801dd2:	ff 75 0c             	pushl  0xc(%ebp)
  801dd5:	50                   	push   %eax
  801dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd9:	ff d0                	call   *%eax
  801ddb:	83 c4 10             	add    $0x10,%esp
			break;
  801dde:	e9 89 02 00 00       	jmp    80206c <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801de3:	8b 45 14             	mov    0x14(%ebp),%eax
  801de6:	83 c0 04             	add    $0x4,%eax
  801de9:	89 45 14             	mov    %eax,0x14(%ebp)
  801dec:	8b 45 14             	mov    0x14(%ebp),%eax
  801def:	83 e8 04             	sub    $0x4,%eax
  801df2:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801df4:	85 db                	test   %ebx,%ebx
  801df6:	79 02                	jns    801dfa <vprintfmt+0x14a>
				err = -err;
  801df8:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801dfa:	83 fb 64             	cmp    $0x64,%ebx
  801dfd:	7f 0b                	jg     801e0a <vprintfmt+0x15a>
  801dff:	8b 34 9d e0 39 80 00 	mov    0x8039e0(,%ebx,4),%esi
  801e06:	85 f6                	test   %esi,%esi
  801e08:	75 19                	jne    801e23 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801e0a:	53                   	push   %ebx
  801e0b:	68 85 3b 80 00       	push   $0x803b85
  801e10:	ff 75 0c             	pushl  0xc(%ebp)
  801e13:	ff 75 08             	pushl  0x8(%ebp)
  801e16:	e8 5e 02 00 00       	call   802079 <printfmt>
  801e1b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801e1e:	e9 49 02 00 00       	jmp    80206c <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801e23:	56                   	push   %esi
  801e24:	68 8e 3b 80 00       	push   $0x803b8e
  801e29:	ff 75 0c             	pushl  0xc(%ebp)
  801e2c:	ff 75 08             	pushl  0x8(%ebp)
  801e2f:	e8 45 02 00 00       	call   802079 <printfmt>
  801e34:	83 c4 10             	add    $0x10,%esp
			break;
  801e37:	e9 30 02 00 00       	jmp    80206c <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801e3c:	8b 45 14             	mov    0x14(%ebp),%eax
  801e3f:	83 c0 04             	add    $0x4,%eax
  801e42:	89 45 14             	mov    %eax,0x14(%ebp)
  801e45:	8b 45 14             	mov    0x14(%ebp),%eax
  801e48:	83 e8 04             	sub    $0x4,%eax
  801e4b:	8b 30                	mov    (%eax),%esi
  801e4d:	85 f6                	test   %esi,%esi
  801e4f:	75 05                	jne    801e56 <vprintfmt+0x1a6>
				p = "(null)";
  801e51:	be 91 3b 80 00       	mov    $0x803b91,%esi
			if (width > 0 && padc != '-')
  801e56:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801e5a:	7e 6d                	jle    801ec9 <vprintfmt+0x219>
  801e5c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801e60:	74 67                	je     801ec9 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801e62:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801e65:	83 ec 08             	sub    $0x8,%esp
  801e68:	50                   	push   %eax
  801e69:	56                   	push   %esi
  801e6a:	e8 0c 03 00 00       	call   80217b <strnlen>
  801e6f:	83 c4 10             	add    $0x10,%esp
  801e72:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801e75:	eb 16                	jmp    801e8d <vprintfmt+0x1dd>
					putch(padc, putdat);
  801e77:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801e7b:	83 ec 08             	sub    $0x8,%esp
  801e7e:	ff 75 0c             	pushl  0xc(%ebp)
  801e81:	50                   	push   %eax
  801e82:	8b 45 08             	mov    0x8(%ebp),%eax
  801e85:	ff d0                	call   *%eax
  801e87:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801e8a:	ff 4d e4             	decl   -0x1c(%ebp)
  801e8d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801e91:	7f e4                	jg     801e77 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801e93:	eb 34                	jmp    801ec9 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801e95:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801e99:	74 1c                	je     801eb7 <vprintfmt+0x207>
  801e9b:	83 fb 1f             	cmp    $0x1f,%ebx
  801e9e:	7e 05                	jle    801ea5 <vprintfmt+0x1f5>
  801ea0:	83 fb 7e             	cmp    $0x7e,%ebx
  801ea3:	7e 12                	jle    801eb7 <vprintfmt+0x207>
					putch('?', putdat);
  801ea5:	83 ec 08             	sub    $0x8,%esp
  801ea8:	ff 75 0c             	pushl  0xc(%ebp)
  801eab:	6a 3f                	push   $0x3f
  801ead:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb0:	ff d0                	call   *%eax
  801eb2:	83 c4 10             	add    $0x10,%esp
  801eb5:	eb 0f                	jmp    801ec6 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801eb7:	83 ec 08             	sub    $0x8,%esp
  801eba:	ff 75 0c             	pushl  0xc(%ebp)
  801ebd:	53                   	push   %ebx
  801ebe:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec1:	ff d0                	call   *%eax
  801ec3:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801ec6:	ff 4d e4             	decl   -0x1c(%ebp)
  801ec9:	89 f0                	mov    %esi,%eax
  801ecb:	8d 70 01             	lea    0x1(%eax),%esi
  801ece:	8a 00                	mov    (%eax),%al
  801ed0:	0f be d8             	movsbl %al,%ebx
  801ed3:	85 db                	test   %ebx,%ebx
  801ed5:	74 24                	je     801efb <vprintfmt+0x24b>
  801ed7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801edb:	78 b8                	js     801e95 <vprintfmt+0x1e5>
  801edd:	ff 4d e0             	decl   -0x20(%ebp)
  801ee0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801ee4:	79 af                	jns    801e95 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801ee6:	eb 13                	jmp    801efb <vprintfmt+0x24b>
				putch(' ', putdat);
  801ee8:	83 ec 08             	sub    $0x8,%esp
  801eeb:	ff 75 0c             	pushl  0xc(%ebp)
  801eee:	6a 20                	push   $0x20
  801ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef3:	ff d0                	call   *%eax
  801ef5:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801ef8:	ff 4d e4             	decl   -0x1c(%ebp)
  801efb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801eff:	7f e7                	jg     801ee8 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801f01:	e9 66 01 00 00       	jmp    80206c <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801f06:	83 ec 08             	sub    $0x8,%esp
  801f09:	ff 75 e8             	pushl  -0x18(%ebp)
  801f0c:	8d 45 14             	lea    0x14(%ebp),%eax
  801f0f:	50                   	push   %eax
  801f10:	e8 3c fd ff ff       	call   801c51 <getint>
  801f15:	83 c4 10             	add    $0x10,%esp
  801f18:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801f1b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801f1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f21:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801f24:	85 d2                	test   %edx,%edx
  801f26:	79 23                	jns    801f4b <vprintfmt+0x29b>
				putch('-', putdat);
  801f28:	83 ec 08             	sub    $0x8,%esp
  801f2b:	ff 75 0c             	pushl  0xc(%ebp)
  801f2e:	6a 2d                	push   $0x2d
  801f30:	8b 45 08             	mov    0x8(%ebp),%eax
  801f33:	ff d0                	call   *%eax
  801f35:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801f38:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f3b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801f3e:	f7 d8                	neg    %eax
  801f40:	83 d2 00             	adc    $0x0,%edx
  801f43:	f7 da                	neg    %edx
  801f45:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801f48:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801f4b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801f52:	e9 bc 00 00 00       	jmp    802013 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801f57:	83 ec 08             	sub    $0x8,%esp
  801f5a:	ff 75 e8             	pushl  -0x18(%ebp)
  801f5d:	8d 45 14             	lea    0x14(%ebp),%eax
  801f60:	50                   	push   %eax
  801f61:	e8 84 fc ff ff       	call   801bea <getuint>
  801f66:	83 c4 10             	add    $0x10,%esp
  801f69:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801f6c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801f6f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801f76:	e9 98 00 00 00       	jmp    802013 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801f7b:	83 ec 08             	sub    $0x8,%esp
  801f7e:	ff 75 0c             	pushl  0xc(%ebp)
  801f81:	6a 58                	push   $0x58
  801f83:	8b 45 08             	mov    0x8(%ebp),%eax
  801f86:	ff d0                	call   *%eax
  801f88:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801f8b:	83 ec 08             	sub    $0x8,%esp
  801f8e:	ff 75 0c             	pushl  0xc(%ebp)
  801f91:	6a 58                	push   $0x58
  801f93:	8b 45 08             	mov    0x8(%ebp),%eax
  801f96:	ff d0                	call   *%eax
  801f98:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801f9b:	83 ec 08             	sub    $0x8,%esp
  801f9e:	ff 75 0c             	pushl  0xc(%ebp)
  801fa1:	6a 58                	push   $0x58
  801fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa6:	ff d0                	call   *%eax
  801fa8:	83 c4 10             	add    $0x10,%esp
			break;
  801fab:	e9 bc 00 00 00       	jmp    80206c <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801fb0:	83 ec 08             	sub    $0x8,%esp
  801fb3:	ff 75 0c             	pushl  0xc(%ebp)
  801fb6:	6a 30                	push   $0x30
  801fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  801fbb:	ff d0                	call   *%eax
  801fbd:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801fc0:	83 ec 08             	sub    $0x8,%esp
  801fc3:	ff 75 0c             	pushl  0xc(%ebp)
  801fc6:	6a 78                	push   $0x78
  801fc8:	8b 45 08             	mov    0x8(%ebp),%eax
  801fcb:	ff d0                	call   *%eax
  801fcd:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801fd0:	8b 45 14             	mov    0x14(%ebp),%eax
  801fd3:	83 c0 04             	add    $0x4,%eax
  801fd6:	89 45 14             	mov    %eax,0x14(%ebp)
  801fd9:	8b 45 14             	mov    0x14(%ebp),%eax
  801fdc:	83 e8 04             	sub    $0x4,%eax
  801fdf:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801fe1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801fe4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801feb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801ff2:	eb 1f                	jmp    802013 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801ff4:	83 ec 08             	sub    $0x8,%esp
  801ff7:	ff 75 e8             	pushl  -0x18(%ebp)
  801ffa:	8d 45 14             	lea    0x14(%ebp),%eax
  801ffd:	50                   	push   %eax
  801ffe:	e8 e7 fb ff ff       	call   801bea <getuint>
  802003:	83 c4 10             	add    $0x10,%esp
  802006:	89 45 f0             	mov    %eax,-0x10(%ebp)
  802009:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80200c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  802013:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  802017:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80201a:	83 ec 04             	sub    $0x4,%esp
  80201d:	52                   	push   %edx
  80201e:	ff 75 e4             	pushl  -0x1c(%ebp)
  802021:	50                   	push   %eax
  802022:	ff 75 f4             	pushl  -0xc(%ebp)
  802025:	ff 75 f0             	pushl  -0x10(%ebp)
  802028:	ff 75 0c             	pushl  0xc(%ebp)
  80202b:	ff 75 08             	pushl  0x8(%ebp)
  80202e:	e8 00 fb ff ff       	call   801b33 <printnum>
  802033:	83 c4 20             	add    $0x20,%esp
			break;
  802036:	eb 34                	jmp    80206c <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  802038:	83 ec 08             	sub    $0x8,%esp
  80203b:	ff 75 0c             	pushl  0xc(%ebp)
  80203e:	53                   	push   %ebx
  80203f:	8b 45 08             	mov    0x8(%ebp),%eax
  802042:	ff d0                	call   *%eax
  802044:	83 c4 10             	add    $0x10,%esp
			break;
  802047:	eb 23                	jmp    80206c <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  802049:	83 ec 08             	sub    $0x8,%esp
  80204c:	ff 75 0c             	pushl  0xc(%ebp)
  80204f:	6a 25                	push   $0x25
  802051:	8b 45 08             	mov    0x8(%ebp),%eax
  802054:	ff d0                	call   *%eax
  802056:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  802059:	ff 4d 10             	decl   0x10(%ebp)
  80205c:	eb 03                	jmp    802061 <vprintfmt+0x3b1>
  80205e:	ff 4d 10             	decl   0x10(%ebp)
  802061:	8b 45 10             	mov    0x10(%ebp),%eax
  802064:	48                   	dec    %eax
  802065:	8a 00                	mov    (%eax),%al
  802067:	3c 25                	cmp    $0x25,%al
  802069:	75 f3                	jne    80205e <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80206b:	90                   	nop
		}
	}
  80206c:	e9 47 fc ff ff       	jmp    801cb8 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  802071:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  802072:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802075:	5b                   	pop    %ebx
  802076:	5e                   	pop    %esi
  802077:	5d                   	pop    %ebp
  802078:	c3                   	ret    

00802079 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  802079:	55                   	push   %ebp
  80207a:	89 e5                	mov    %esp,%ebp
  80207c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80207f:	8d 45 10             	lea    0x10(%ebp),%eax
  802082:	83 c0 04             	add    $0x4,%eax
  802085:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  802088:	8b 45 10             	mov    0x10(%ebp),%eax
  80208b:	ff 75 f4             	pushl  -0xc(%ebp)
  80208e:	50                   	push   %eax
  80208f:	ff 75 0c             	pushl  0xc(%ebp)
  802092:	ff 75 08             	pushl  0x8(%ebp)
  802095:	e8 16 fc ff ff       	call   801cb0 <vprintfmt>
  80209a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80209d:	90                   	nop
  80209e:	c9                   	leave  
  80209f:	c3                   	ret    

008020a0 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8020a0:	55                   	push   %ebp
  8020a1:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8020a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020a6:	8b 40 08             	mov    0x8(%eax),%eax
  8020a9:	8d 50 01             	lea    0x1(%eax),%edx
  8020ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020af:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8020b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020b5:	8b 10                	mov    (%eax),%edx
  8020b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020ba:	8b 40 04             	mov    0x4(%eax),%eax
  8020bd:	39 c2                	cmp    %eax,%edx
  8020bf:	73 12                	jae    8020d3 <sprintputch+0x33>
		*b->buf++ = ch;
  8020c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020c4:	8b 00                	mov    (%eax),%eax
  8020c6:	8d 48 01             	lea    0x1(%eax),%ecx
  8020c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020cc:	89 0a                	mov    %ecx,(%edx)
  8020ce:	8b 55 08             	mov    0x8(%ebp),%edx
  8020d1:	88 10                	mov    %dl,(%eax)
}
  8020d3:	90                   	nop
  8020d4:	5d                   	pop    %ebp
  8020d5:	c3                   	ret    

008020d6 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8020d6:	55                   	push   %ebp
  8020d7:	89 e5                	mov    %esp,%ebp
  8020d9:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8020dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8020df:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8020e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020e5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8020e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8020eb:	01 d0                	add    %edx,%eax
  8020ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8020f0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8020f7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8020fb:	74 06                	je     802103 <vsnprintf+0x2d>
  8020fd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802101:	7f 07                	jg     80210a <vsnprintf+0x34>
		return -E_INVAL;
  802103:	b8 03 00 00 00       	mov    $0x3,%eax
  802108:	eb 20                	jmp    80212a <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80210a:	ff 75 14             	pushl  0x14(%ebp)
  80210d:	ff 75 10             	pushl  0x10(%ebp)
  802110:	8d 45 ec             	lea    -0x14(%ebp),%eax
  802113:	50                   	push   %eax
  802114:	68 a0 20 80 00       	push   $0x8020a0
  802119:	e8 92 fb ff ff       	call   801cb0 <vprintfmt>
  80211e:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  802121:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802124:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  802127:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80212a:	c9                   	leave  
  80212b:	c3                   	ret    

0080212c <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80212c:	55                   	push   %ebp
  80212d:	89 e5                	mov    %esp,%ebp
  80212f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  802132:	8d 45 10             	lea    0x10(%ebp),%eax
  802135:	83 c0 04             	add    $0x4,%eax
  802138:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80213b:	8b 45 10             	mov    0x10(%ebp),%eax
  80213e:	ff 75 f4             	pushl  -0xc(%ebp)
  802141:	50                   	push   %eax
  802142:	ff 75 0c             	pushl  0xc(%ebp)
  802145:	ff 75 08             	pushl  0x8(%ebp)
  802148:	e8 89 ff ff ff       	call   8020d6 <vsnprintf>
  80214d:	83 c4 10             	add    $0x10,%esp
  802150:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  802153:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802156:	c9                   	leave  
  802157:	c3                   	ret    

00802158 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  802158:	55                   	push   %ebp
  802159:	89 e5                	mov    %esp,%ebp
  80215b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80215e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802165:	eb 06                	jmp    80216d <strlen+0x15>
		n++;
  802167:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80216a:	ff 45 08             	incl   0x8(%ebp)
  80216d:	8b 45 08             	mov    0x8(%ebp),%eax
  802170:	8a 00                	mov    (%eax),%al
  802172:	84 c0                	test   %al,%al
  802174:	75 f1                	jne    802167 <strlen+0xf>
		n++;
	return n;
  802176:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802179:	c9                   	leave  
  80217a:	c3                   	ret    

0080217b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80217b:	55                   	push   %ebp
  80217c:	89 e5                	mov    %esp,%ebp
  80217e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  802181:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802188:	eb 09                	jmp    802193 <strnlen+0x18>
		n++;
  80218a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80218d:	ff 45 08             	incl   0x8(%ebp)
  802190:	ff 4d 0c             	decl   0xc(%ebp)
  802193:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802197:	74 09                	je     8021a2 <strnlen+0x27>
  802199:	8b 45 08             	mov    0x8(%ebp),%eax
  80219c:	8a 00                	mov    (%eax),%al
  80219e:	84 c0                	test   %al,%al
  8021a0:	75 e8                	jne    80218a <strnlen+0xf>
		n++;
	return n;
  8021a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8021a5:	c9                   	leave  
  8021a6:	c3                   	ret    

008021a7 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8021a7:	55                   	push   %ebp
  8021a8:	89 e5                	mov    %esp,%ebp
  8021aa:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8021ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8021b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8021b3:	90                   	nop
  8021b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8021b7:	8d 50 01             	lea    0x1(%eax),%edx
  8021ba:	89 55 08             	mov    %edx,0x8(%ebp)
  8021bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021c0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8021c3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8021c6:	8a 12                	mov    (%edx),%dl
  8021c8:	88 10                	mov    %dl,(%eax)
  8021ca:	8a 00                	mov    (%eax),%al
  8021cc:	84 c0                	test   %al,%al
  8021ce:	75 e4                	jne    8021b4 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8021d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8021d3:	c9                   	leave  
  8021d4:	c3                   	ret    

008021d5 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8021d5:	55                   	push   %ebp
  8021d6:	89 e5                	mov    %esp,%ebp
  8021d8:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8021db:	8b 45 08             	mov    0x8(%ebp),%eax
  8021de:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8021e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8021e8:	eb 1f                	jmp    802209 <strncpy+0x34>
		*dst++ = *src;
  8021ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ed:	8d 50 01             	lea    0x1(%eax),%edx
  8021f0:	89 55 08             	mov    %edx,0x8(%ebp)
  8021f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021f6:	8a 12                	mov    (%edx),%dl
  8021f8:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8021fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021fd:	8a 00                	mov    (%eax),%al
  8021ff:	84 c0                	test   %al,%al
  802201:	74 03                	je     802206 <strncpy+0x31>
			src++;
  802203:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  802206:	ff 45 fc             	incl   -0x4(%ebp)
  802209:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80220c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80220f:	72 d9                	jb     8021ea <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  802211:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  802214:	c9                   	leave  
  802215:	c3                   	ret    

00802216 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  802216:	55                   	push   %ebp
  802217:	89 e5                	mov    %esp,%ebp
  802219:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80221c:	8b 45 08             	mov    0x8(%ebp),%eax
  80221f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  802222:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802226:	74 30                	je     802258 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  802228:	eb 16                	jmp    802240 <strlcpy+0x2a>
			*dst++ = *src++;
  80222a:	8b 45 08             	mov    0x8(%ebp),%eax
  80222d:	8d 50 01             	lea    0x1(%eax),%edx
  802230:	89 55 08             	mov    %edx,0x8(%ebp)
  802233:	8b 55 0c             	mov    0xc(%ebp),%edx
  802236:	8d 4a 01             	lea    0x1(%edx),%ecx
  802239:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80223c:	8a 12                	mov    (%edx),%dl
  80223e:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  802240:	ff 4d 10             	decl   0x10(%ebp)
  802243:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802247:	74 09                	je     802252 <strlcpy+0x3c>
  802249:	8b 45 0c             	mov    0xc(%ebp),%eax
  80224c:	8a 00                	mov    (%eax),%al
  80224e:	84 c0                	test   %al,%al
  802250:	75 d8                	jne    80222a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  802252:	8b 45 08             	mov    0x8(%ebp),%eax
  802255:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  802258:	8b 55 08             	mov    0x8(%ebp),%edx
  80225b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80225e:	29 c2                	sub    %eax,%edx
  802260:	89 d0                	mov    %edx,%eax
}
  802262:	c9                   	leave  
  802263:	c3                   	ret    

00802264 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  802264:	55                   	push   %ebp
  802265:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  802267:	eb 06                	jmp    80226f <strcmp+0xb>
		p++, q++;
  802269:	ff 45 08             	incl   0x8(%ebp)
  80226c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80226f:	8b 45 08             	mov    0x8(%ebp),%eax
  802272:	8a 00                	mov    (%eax),%al
  802274:	84 c0                	test   %al,%al
  802276:	74 0e                	je     802286 <strcmp+0x22>
  802278:	8b 45 08             	mov    0x8(%ebp),%eax
  80227b:	8a 10                	mov    (%eax),%dl
  80227d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802280:	8a 00                	mov    (%eax),%al
  802282:	38 c2                	cmp    %al,%dl
  802284:	74 e3                	je     802269 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  802286:	8b 45 08             	mov    0x8(%ebp),%eax
  802289:	8a 00                	mov    (%eax),%al
  80228b:	0f b6 d0             	movzbl %al,%edx
  80228e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802291:	8a 00                	mov    (%eax),%al
  802293:	0f b6 c0             	movzbl %al,%eax
  802296:	29 c2                	sub    %eax,%edx
  802298:	89 d0                	mov    %edx,%eax
}
  80229a:	5d                   	pop    %ebp
  80229b:	c3                   	ret    

0080229c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80229c:	55                   	push   %ebp
  80229d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80229f:	eb 09                	jmp    8022aa <strncmp+0xe>
		n--, p++, q++;
  8022a1:	ff 4d 10             	decl   0x10(%ebp)
  8022a4:	ff 45 08             	incl   0x8(%ebp)
  8022a7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8022aa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8022ae:	74 17                	je     8022c7 <strncmp+0x2b>
  8022b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8022b3:	8a 00                	mov    (%eax),%al
  8022b5:	84 c0                	test   %al,%al
  8022b7:	74 0e                	je     8022c7 <strncmp+0x2b>
  8022b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8022bc:	8a 10                	mov    (%eax),%dl
  8022be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8022c1:	8a 00                	mov    (%eax),%al
  8022c3:	38 c2                	cmp    %al,%dl
  8022c5:	74 da                	je     8022a1 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8022c7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8022cb:	75 07                	jne    8022d4 <strncmp+0x38>
		return 0;
  8022cd:	b8 00 00 00 00       	mov    $0x0,%eax
  8022d2:	eb 14                	jmp    8022e8 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8022d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8022d7:	8a 00                	mov    (%eax),%al
  8022d9:	0f b6 d0             	movzbl %al,%edx
  8022dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8022df:	8a 00                	mov    (%eax),%al
  8022e1:	0f b6 c0             	movzbl %al,%eax
  8022e4:	29 c2                	sub    %eax,%edx
  8022e6:	89 d0                	mov    %edx,%eax
}
  8022e8:	5d                   	pop    %ebp
  8022e9:	c3                   	ret    

008022ea <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8022ea:	55                   	push   %ebp
  8022eb:	89 e5                	mov    %esp,%ebp
  8022ed:	83 ec 04             	sub    $0x4,%esp
  8022f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8022f3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8022f6:	eb 12                	jmp    80230a <strchr+0x20>
		if (*s == c)
  8022f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8022fb:	8a 00                	mov    (%eax),%al
  8022fd:	3a 45 fc             	cmp    -0x4(%ebp),%al
  802300:	75 05                	jne    802307 <strchr+0x1d>
			return (char *) s;
  802302:	8b 45 08             	mov    0x8(%ebp),%eax
  802305:	eb 11                	jmp    802318 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  802307:	ff 45 08             	incl   0x8(%ebp)
  80230a:	8b 45 08             	mov    0x8(%ebp),%eax
  80230d:	8a 00                	mov    (%eax),%al
  80230f:	84 c0                	test   %al,%al
  802311:	75 e5                	jne    8022f8 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  802313:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802318:	c9                   	leave  
  802319:	c3                   	ret    

0080231a <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80231a:	55                   	push   %ebp
  80231b:	89 e5                	mov    %esp,%ebp
  80231d:	83 ec 04             	sub    $0x4,%esp
  802320:	8b 45 0c             	mov    0xc(%ebp),%eax
  802323:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802326:	eb 0d                	jmp    802335 <strfind+0x1b>
		if (*s == c)
  802328:	8b 45 08             	mov    0x8(%ebp),%eax
  80232b:	8a 00                	mov    (%eax),%al
  80232d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  802330:	74 0e                	je     802340 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  802332:	ff 45 08             	incl   0x8(%ebp)
  802335:	8b 45 08             	mov    0x8(%ebp),%eax
  802338:	8a 00                	mov    (%eax),%al
  80233a:	84 c0                	test   %al,%al
  80233c:	75 ea                	jne    802328 <strfind+0xe>
  80233e:	eb 01                	jmp    802341 <strfind+0x27>
		if (*s == c)
			break;
  802340:	90                   	nop
	return (char *) s;
  802341:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802344:	c9                   	leave  
  802345:	c3                   	ret    

00802346 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  802346:	55                   	push   %ebp
  802347:	89 e5                	mov    %esp,%ebp
  802349:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80234c:	8b 45 08             	mov    0x8(%ebp),%eax
  80234f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  802352:	8b 45 10             	mov    0x10(%ebp),%eax
  802355:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  802358:	eb 0e                	jmp    802368 <memset+0x22>
		*p++ = c;
  80235a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80235d:	8d 50 01             	lea    0x1(%eax),%edx
  802360:	89 55 fc             	mov    %edx,-0x4(%ebp)
  802363:	8b 55 0c             	mov    0xc(%ebp),%edx
  802366:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  802368:	ff 4d f8             	decl   -0x8(%ebp)
  80236b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80236f:	79 e9                	jns    80235a <memset+0x14>
		*p++ = c;

	return v;
  802371:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802374:	c9                   	leave  
  802375:	c3                   	ret    

00802376 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  802376:	55                   	push   %ebp
  802377:	89 e5                	mov    %esp,%ebp
  802379:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80237c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80237f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  802382:	8b 45 08             	mov    0x8(%ebp),%eax
  802385:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  802388:	eb 16                	jmp    8023a0 <memcpy+0x2a>
		*d++ = *s++;
  80238a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80238d:	8d 50 01             	lea    0x1(%eax),%edx
  802390:	89 55 f8             	mov    %edx,-0x8(%ebp)
  802393:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802396:	8d 4a 01             	lea    0x1(%edx),%ecx
  802399:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80239c:	8a 12                	mov    (%edx),%dl
  80239e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8023a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8023a3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8023a6:	89 55 10             	mov    %edx,0x10(%ebp)
  8023a9:	85 c0                	test   %eax,%eax
  8023ab:	75 dd                	jne    80238a <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8023ad:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8023b0:	c9                   	leave  
  8023b1:	c3                   	ret    

008023b2 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8023b2:	55                   	push   %ebp
  8023b3:	89 e5                	mov    %esp,%ebp
  8023b5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8023b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8023be:	8b 45 08             	mov    0x8(%ebp),%eax
  8023c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8023c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8023c7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8023ca:	73 50                	jae    80241c <memmove+0x6a>
  8023cc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8023cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8023d2:	01 d0                	add    %edx,%eax
  8023d4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8023d7:	76 43                	jbe    80241c <memmove+0x6a>
		s += n;
  8023d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8023dc:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8023df:	8b 45 10             	mov    0x10(%ebp),%eax
  8023e2:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8023e5:	eb 10                	jmp    8023f7 <memmove+0x45>
			*--d = *--s;
  8023e7:	ff 4d f8             	decl   -0x8(%ebp)
  8023ea:	ff 4d fc             	decl   -0x4(%ebp)
  8023ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8023f0:	8a 10                	mov    (%eax),%dl
  8023f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8023f5:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8023f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8023fa:	8d 50 ff             	lea    -0x1(%eax),%edx
  8023fd:	89 55 10             	mov    %edx,0x10(%ebp)
  802400:	85 c0                	test   %eax,%eax
  802402:	75 e3                	jne    8023e7 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  802404:	eb 23                	jmp    802429 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  802406:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802409:	8d 50 01             	lea    0x1(%eax),%edx
  80240c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80240f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802412:	8d 4a 01             	lea    0x1(%edx),%ecx
  802415:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  802418:	8a 12                	mov    (%edx),%dl
  80241a:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80241c:	8b 45 10             	mov    0x10(%ebp),%eax
  80241f:	8d 50 ff             	lea    -0x1(%eax),%edx
  802422:	89 55 10             	mov    %edx,0x10(%ebp)
  802425:	85 c0                	test   %eax,%eax
  802427:	75 dd                	jne    802406 <memmove+0x54>
			*d++ = *s++;

	return dst;
  802429:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80242c:	c9                   	leave  
  80242d:	c3                   	ret    

0080242e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80242e:	55                   	push   %ebp
  80242f:	89 e5                	mov    %esp,%ebp
  802431:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  802434:	8b 45 08             	mov    0x8(%ebp),%eax
  802437:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80243a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80243d:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  802440:	eb 2a                	jmp    80246c <memcmp+0x3e>
		if (*s1 != *s2)
  802442:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802445:	8a 10                	mov    (%eax),%dl
  802447:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80244a:	8a 00                	mov    (%eax),%al
  80244c:	38 c2                	cmp    %al,%dl
  80244e:	74 16                	je     802466 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  802450:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802453:	8a 00                	mov    (%eax),%al
  802455:	0f b6 d0             	movzbl %al,%edx
  802458:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80245b:	8a 00                	mov    (%eax),%al
  80245d:	0f b6 c0             	movzbl %al,%eax
  802460:	29 c2                	sub    %eax,%edx
  802462:	89 d0                	mov    %edx,%eax
  802464:	eb 18                	jmp    80247e <memcmp+0x50>
		s1++, s2++;
  802466:	ff 45 fc             	incl   -0x4(%ebp)
  802469:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80246c:	8b 45 10             	mov    0x10(%ebp),%eax
  80246f:	8d 50 ff             	lea    -0x1(%eax),%edx
  802472:	89 55 10             	mov    %edx,0x10(%ebp)
  802475:	85 c0                	test   %eax,%eax
  802477:	75 c9                	jne    802442 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  802479:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80247e:	c9                   	leave  
  80247f:	c3                   	ret    

00802480 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  802480:	55                   	push   %ebp
  802481:	89 e5                	mov    %esp,%ebp
  802483:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  802486:	8b 55 08             	mov    0x8(%ebp),%edx
  802489:	8b 45 10             	mov    0x10(%ebp),%eax
  80248c:	01 d0                	add    %edx,%eax
  80248e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  802491:	eb 15                	jmp    8024a8 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  802493:	8b 45 08             	mov    0x8(%ebp),%eax
  802496:	8a 00                	mov    (%eax),%al
  802498:	0f b6 d0             	movzbl %al,%edx
  80249b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80249e:	0f b6 c0             	movzbl %al,%eax
  8024a1:	39 c2                	cmp    %eax,%edx
  8024a3:	74 0d                	je     8024b2 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8024a5:	ff 45 08             	incl   0x8(%ebp)
  8024a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8024ab:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8024ae:	72 e3                	jb     802493 <memfind+0x13>
  8024b0:	eb 01                	jmp    8024b3 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8024b2:	90                   	nop
	return (void *) s;
  8024b3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8024b6:	c9                   	leave  
  8024b7:	c3                   	ret    

008024b8 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8024b8:	55                   	push   %ebp
  8024b9:	89 e5                	mov    %esp,%ebp
  8024bb:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8024be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8024c5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8024cc:	eb 03                	jmp    8024d1 <strtol+0x19>
		s++;
  8024ce:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8024d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8024d4:	8a 00                	mov    (%eax),%al
  8024d6:	3c 20                	cmp    $0x20,%al
  8024d8:	74 f4                	je     8024ce <strtol+0x16>
  8024da:	8b 45 08             	mov    0x8(%ebp),%eax
  8024dd:	8a 00                	mov    (%eax),%al
  8024df:	3c 09                	cmp    $0x9,%al
  8024e1:	74 eb                	je     8024ce <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8024e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8024e6:	8a 00                	mov    (%eax),%al
  8024e8:	3c 2b                	cmp    $0x2b,%al
  8024ea:	75 05                	jne    8024f1 <strtol+0x39>
		s++;
  8024ec:	ff 45 08             	incl   0x8(%ebp)
  8024ef:	eb 13                	jmp    802504 <strtol+0x4c>
	else if (*s == '-')
  8024f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8024f4:	8a 00                	mov    (%eax),%al
  8024f6:	3c 2d                	cmp    $0x2d,%al
  8024f8:	75 0a                	jne    802504 <strtol+0x4c>
		s++, neg = 1;
  8024fa:	ff 45 08             	incl   0x8(%ebp)
  8024fd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  802504:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802508:	74 06                	je     802510 <strtol+0x58>
  80250a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80250e:	75 20                	jne    802530 <strtol+0x78>
  802510:	8b 45 08             	mov    0x8(%ebp),%eax
  802513:	8a 00                	mov    (%eax),%al
  802515:	3c 30                	cmp    $0x30,%al
  802517:	75 17                	jne    802530 <strtol+0x78>
  802519:	8b 45 08             	mov    0x8(%ebp),%eax
  80251c:	40                   	inc    %eax
  80251d:	8a 00                	mov    (%eax),%al
  80251f:	3c 78                	cmp    $0x78,%al
  802521:	75 0d                	jne    802530 <strtol+0x78>
		s += 2, base = 16;
  802523:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  802527:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80252e:	eb 28                	jmp    802558 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  802530:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802534:	75 15                	jne    80254b <strtol+0x93>
  802536:	8b 45 08             	mov    0x8(%ebp),%eax
  802539:	8a 00                	mov    (%eax),%al
  80253b:	3c 30                	cmp    $0x30,%al
  80253d:	75 0c                	jne    80254b <strtol+0x93>
		s++, base = 8;
  80253f:	ff 45 08             	incl   0x8(%ebp)
  802542:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  802549:	eb 0d                	jmp    802558 <strtol+0xa0>
	else if (base == 0)
  80254b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80254f:	75 07                	jne    802558 <strtol+0xa0>
		base = 10;
  802551:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  802558:	8b 45 08             	mov    0x8(%ebp),%eax
  80255b:	8a 00                	mov    (%eax),%al
  80255d:	3c 2f                	cmp    $0x2f,%al
  80255f:	7e 19                	jle    80257a <strtol+0xc2>
  802561:	8b 45 08             	mov    0x8(%ebp),%eax
  802564:	8a 00                	mov    (%eax),%al
  802566:	3c 39                	cmp    $0x39,%al
  802568:	7f 10                	jg     80257a <strtol+0xc2>
			dig = *s - '0';
  80256a:	8b 45 08             	mov    0x8(%ebp),%eax
  80256d:	8a 00                	mov    (%eax),%al
  80256f:	0f be c0             	movsbl %al,%eax
  802572:	83 e8 30             	sub    $0x30,%eax
  802575:	89 45 f4             	mov    %eax,-0xc(%ebp)
  802578:	eb 42                	jmp    8025bc <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80257a:	8b 45 08             	mov    0x8(%ebp),%eax
  80257d:	8a 00                	mov    (%eax),%al
  80257f:	3c 60                	cmp    $0x60,%al
  802581:	7e 19                	jle    80259c <strtol+0xe4>
  802583:	8b 45 08             	mov    0x8(%ebp),%eax
  802586:	8a 00                	mov    (%eax),%al
  802588:	3c 7a                	cmp    $0x7a,%al
  80258a:	7f 10                	jg     80259c <strtol+0xe4>
			dig = *s - 'a' + 10;
  80258c:	8b 45 08             	mov    0x8(%ebp),%eax
  80258f:	8a 00                	mov    (%eax),%al
  802591:	0f be c0             	movsbl %al,%eax
  802594:	83 e8 57             	sub    $0x57,%eax
  802597:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80259a:	eb 20                	jmp    8025bc <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80259c:	8b 45 08             	mov    0x8(%ebp),%eax
  80259f:	8a 00                	mov    (%eax),%al
  8025a1:	3c 40                	cmp    $0x40,%al
  8025a3:	7e 39                	jle    8025de <strtol+0x126>
  8025a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8025a8:	8a 00                	mov    (%eax),%al
  8025aa:	3c 5a                	cmp    $0x5a,%al
  8025ac:	7f 30                	jg     8025de <strtol+0x126>
			dig = *s - 'A' + 10;
  8025ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8025b1:	8a 00                	mov    (%eax),%al
  8025b3:	0f be c0             	movsbl %al,%eax
  8025b6:	83 e8 37             	sub    $0x37,%eax
  8025b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8025bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8025bf:	3b 45 10             	cmp    0x10(%ebp),%eax
  8025c2:	7d 19                	jge    8025dd <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8025c4:	ff 45 08             	incl   0x8(%ebp)
  8025c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8025ca:	0f af 45 10          	imul   0x10(%ebp),%eax
  8025ce:	89 c2                	mov    %eax,%edx
  8025d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8025d3:	01 d0                	add    %edx,%eax
  8025d5:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8025d8:	e9 7b ff ff ff       	jmp    802558 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8025dd:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8025de:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8025e2:	74 08                	je     8025ec <strtol+0x134>
		*endptr = (char *) s;
  8025e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8025e7:	8b 55 08             	mov    0x8(%ebp),%edx
  8025ea:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8025ec:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8025f0:	74 07                	je     8025f9 <strtol+0x141>
  8025f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8025f5:	f7 d8                	neg    %eax
  8025f7:	eb 03                	jmp    8025fc <strtol+0x144>
  8025f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8025fc:	c9                   	leave  
  8025fd:	c3                   	ret    

008025fe <ltostr>:

void
ltostr(long value, char *str)
{
  8025fe:	55                   	push   %ebp
  8025ff:	89 e5                	mov    %esp,%ebp
  802601:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  802604:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80260b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  802612:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802616:	79 13                	jns    80262b <ltostr+0x2d>
	{
		neg = 1;
  802618:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80261f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802622:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  802625:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  802628:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80262b:	8b 45 08             	mov    0x8(%ebp),%eax
  80262e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  802633:	99                   	cltd   
  802634:	f7 f9                	idiv   %ecx
  802636:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  802639:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80263c:	8d 50 01             	lea    0x1(%eax),%edx
  80263f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  802642:	89 c2                	mov    %eax,%edx
  802644:	8b 45 0c             	mov    0xc(%ebp),%eax
  802647:	01 d0                	add    %edx,%eax
  802649:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80264c:	83 c2 30             	add    $0x30,%edx
  80264f:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  802651:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802654:	b8 67 66 66 66       	mov    $0x66666667,%eax
  802659:	f7 e9                	imul   %ecx
  80265b:	c1 fa 02             	sar    $0x2,%edx
  80265e:	89 c8                	mov    %ecx,%eax
  802660:	c1 f8 1f             	sar    $0x1f,%eax
  802663:	29 c2                	sub    %eax,%edx
  802665:	89 d0                	mov    %edx,%eax
  802667:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80266a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80266d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  802672:	f7 e9                	imul   %ecx
  802674:	c1 fa 02             	sar    $0x2,%edx
  802677:	89 c8                	mov    %ecx,%eax
  802679:	c1 f8 1f             	sar    $0x1f,%eax
  80267c:	29 c2                	sub    %eax,%edx
  80267e:	89 d0                	mov    %edx,%eax
  802680:	c1 e0 02             	shl    $0x2,%eax
  802683:	01 d0                	add    %edx,%eax
  802685:	01 c0                	add    %eax,%eax
  802687:	29 c1                	sub    %eax,%ecx
  802689:	89 ca                	mov    %ecx,%edx
  80268b:	85 d2                	test   %edx,%edx
  80268d:	75 9c                	jne    80262b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80268f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  802696:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802699:	48                   	dec    %eax
  80269a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80269d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8026a1:	74 3d                	je     8026e0 <ltostr+0xe2>
		start = 1 ;
  8026a3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8026aa:	eb 34                	jmp    8026e0 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8026ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8026af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8026b2:	01 d0                	add    %edx,%eax
  8026b4:	8a 00                	mov    (%eax),%al
  8026b6:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8026b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8026bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8026bf:	01 c2                	add    %eax,%edx
  8026c1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8026c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8026c7:	01 c8                	add    %ecx,%eax
  8026c9:	8a 00                	mov    (%eax),%al
  8026cb:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8026cd:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8026d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8026d3:	01 c2                	add    %eax,%edx
  8026d5:	8a 45 eb             	mov    -0x15(%ebp),%al
  8026d8:	88 02                	mov    %al,(%edx)
		start++ ;
  8026da:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8026dd:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8026e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8026e3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8026e6:	7c c4                	jl     8026ac <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8026e8:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8026eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8026ee:	01 d0                	add    %edx,%eax
  8026f0:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8026f3:	90                   	nop
  8026f4:	c9                   	leave  
  8026f5:	c3                   	ret    

008026f6 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8026f6:	55                   	push   %ebp
  8026f7:	89 e5                	mov    %esp,%ebp
  8026f9:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8026fc:	ff 75 08             	pushl  0x8(%ebp)
  8026ff:	e8 54 fa ff ff       	call   802158 <strlen>
  802704:	83 c4 04             	add    $0x4,%esp
  802707:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80270a:	ff 75 0c             	pushl  0xc(%ebp)
  80270d:	e8 46 fa ff ff       	call   802158 <strlen>
  802712:	83 c4 04             	add    $0x4,%esp
  802715:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  802718:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80271f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802726:	eb 17                	jmp    80273f <strcconcat+0x49>
		final[s] = str1[s] ;
  802728:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80272b:	8b 45 10             	mov    0x10(%ebp),%eax
  80272e:	01 c2                	add    %eax,%edx
  802730:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  802733:	8b 45 08             	mov    0x8(%ebp),%eax
  802736:	01 c8                	add    %ecx,%eax
  802738:	8a 00                	mov    (%eax),%al
  80273a:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80273c:	ff 45 fc             	incl   -0x4(%ebp)
  80273f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802742:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  802745:	7c e1                	jl     802728 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  802747:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80274e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  802755:	eb 1f                	jmp    802776 <strcconcat+0x80>
		final[s++] = str2[i] ;
  802757:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80275a:	8d 50 01             	lea    0x1(%eax),%edx
  80275d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  802760:	89 c2                	mov    %eax,%edx
  802762:	8b 45 10             	mov    0x10(%ebp),%eax
  802765:	01 c2                	add    %eax,%edx
  802767:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80276a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80276d:	01 c8                	add    %ecx,%eax
  80276f:	8a 00                	mov    (%eax),%al
  802771:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  802773:	ff 45 f8             	incl   -0x8(%ebp)
  802776:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802779:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80277c:	7c d9                	jl     802757 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80277e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802781:	8b 45 10             	mov    0x10(%ebp),%eax
  802784:	01 d0                	add    %edx,%eax
  802786:	c6 00 00             	movb   $0x0,(%eax)
}
  802789:	90                   	nop
  80278a:	c9                   	leave  
  80278b:	c3                   	ret    

0080278c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80278c:	55                   	push   %ebp
  80278d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80278f:	8b 45 14             	mov    0x14(%ebp),%eax
  802792:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  802798:	8b 45 14             	mov    0x14(%ebp),%eax
  80279b:	8b 00                	mov    (%eax),%eax
  80279d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8027a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8027a7:	01 d0                	add    %edx,%eax
  8027a9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8027af:	eb 0c                	jmp    8027bd <strsplit+0x31>
			*string++ = 0;
  8027b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8027b4:	8d 50 01             	lea    0x1(%eax),%edx
  8027b7:	89 55 08             	mov    %edx,0x8(%ebp)
  8027ba:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8027bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8027c0:	8a 00                	mov    (%eax),%al
  8027c2:	84 c0                	test   %al,%al
  8027c4:	74 18                	je     8027de <strsplit+0x52>
  8027c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8027c9:	8a 00                	mov    (%eax),%al
  8027cb:	0f be c0             	movsbl %al,%eax
  8027ce:	50                   	push   %eax
  8027cf:	ff 75 0c             	pushl  0xc(%ebp)
  8027d2:	e8 13 fb ff ff       	call   8022ea <strchr>
  8027d7:	83 c4 08             	add    $0x8,%esp
  8027da:	85 c0                	test   %eax,%eax
  8027dc:	75 d3                	jne    8027b1 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8027de:	8b 45 08             	mov    0x8(%ebp),%eax
  8027e1:	8a 00                	mov    (%eax),%al
  8027e3:	84 c0                	test   %al,%al
  8027e5:	74 5a                	je     802841 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8027e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8027ea:	8b 00                	mov    (%eax),%eax
  8027ec:	83 f8 0f             	cmp    $0xf,%eax
  8027ef:	75 07                	jne    8027f8 <strsplit+0x6c>
		{
			return 0;
  8027f1:	b8 00 00 00 00       	mov    $0x0,%eax
  8027f6:	eb 66                	jmp    80285e <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8027f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8027fb:	8b 00                	mov    (%eax),%eax
  8027fd:	8d 48 01             	lea    0x1(%eax),%ecx
  802800:	8b 55 14             	mov    0x14(%ebp),%edx
  802803:	89 0a                	mov    %ecx,(%edx)
  802805:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80280c:	8b 45 10             	mov    0x10(%ebp),%eax
  80280f:	01 c2                	add    %eax,%edx
  802811:	8b 45 08             	mov    0x8(%ebp),%eax
  802814:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  802816:	eb 03                	jmp    80281b <strsplit+0x8f>
			string++;
  802818:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80281b:	8b 45 08             	mov    0x8(%ebp),%eax
  80281e:	8a 00                	mov    (%eax),%al
  802820:	84 c0                	test   %al,%al
  802822:	74 8b                	je     8027af <strsplit+0x23>
  802824:	8b 45 08             	mov    0x8(%ebp),%eax
  802827:	8a 00                	mov    (%eax),%al
  802829:	0f be c0             	movsbl %al,%eax
  80282c:	50                   	push   %eax
  80282d:	ff 75 0c             	pushl  0xc(%ebp)
  802830:	e8 b5 fa ff ff       	call   8022ea <strchr>
  802835:	83 c4 08             	add    $0x8,%esp
  802838:	85 c0                	test   %eax,%eax
  80283a:	74 dc                	je     802818 <strsplit+0x8c>
			string++;
	}
  80283c:	e9 6e ff ff ff       	jmp    8027af <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  802841:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  802842:	8b 45 14             	mov    0x14(%ebp),%eax
  802845:	8b 00                	mov    (%eax),%eax
  802847:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80284e:	8b 45 10             	mov    0x10(%ebp),%eax
  802851:	01 d0                	add    %edx,%eax
  802853:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  802859:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80285e:	c9                   	leave  
  80285f:	c3                   	ret    

00802860 <malloc>:
int changes = 0;
int sizeofarray = 0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size) {
  802860:	55                   	push   %ebp
  802861:	89 e5                	mov    %esp,%ebp
  802863:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  802866:	8b 45 08             	mov    0x8(%ebp),%eax
  802869:	c1 e8 0c             	shr    $0xc,%eax
  80286c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	//sizeofarray++;
	if (size % PAGE_SIZE != 0)
  80286f:	8b 45 08             	mov    0x8(%ebp),%eax
  802872:	25 ff 0f 00 00       	and    $0xfff,%eax
  802877:	85 c0                	test   %eax,%eax
  802879:	74 03                	je     80287e <malloc+0x1e>
		num++;
  80287b:	ff 45 f4             	incl   -0xc(%ebp)
//		addresses[sizeofarray] = last_addres;
//		changed[sizeofarray] = 1;
//		sizeofarray++;
//		return (void*) return_addres;
	//} else {
	if (changes == 0) {
  80287e:	a1 28 40 80 00       	mov    0x804028,%eax
  802883:	85 c0                	test   %eax,%eax
  802885:	75 71                	jne    8028f8 <malloc+0x98>
		sys_allocateMem(last_addres, size);
  802887:	a1 04 40 80 00       	mov    0x804004,%eax
  80288c:	83 ec 08             	sub    $0x8,%esp
  80288f:	ff 75 08             	pushl  0x8(%ebp)
  802892:	50                   	push   %eax
  802893:	e8 e4 04 00 00       	call   802d7c <sys_allocateMem>
  802898:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  80289b:	a1 04 40 80 00       	mov    0x804004,%eax
  8028a0:	89 45 d8             	mov    %eax,-0x28(%ebp)
		last_addres += num * PAGE_SIZE;
  8028a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8028a6:	c1 e0 0c             	shl    $0xc,%eax
  8028a9:	89 c2                	mov    %eax,%edx
  8028ab:	a1 04 40 80 00       	mov    0x804004,%eax
  8028b0:	01 d0                	add    %edx,%eax
  8028b2:	a3 04 40 80 00       	mov    %eax,0x804004
		numOfPages[sizeofarray] = num;
  8028b7:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8028bc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8028bf:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
		addresses[sizeofarray] = return_addres;
  8028c6:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8028cb:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8028ce:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
		changed[sizeofarray] = 1;
  8028d5:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8028da:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  8028e1:	01 00 00 00 
		sizeofarray++;
  8028e5:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8028ea:	40                   	inc    %eax
  8028eb:	a3 2c 40 80 00       	mov    %eax,0x80402c
		return (void*) return_addres;
  8028f0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8028f3:	e9 f7 00 00 00       	jmp    8029ef <malloc+0x18f>
	} else {
		int count = 0;
  8028f8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 1000;
  8028ff:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
		int index = -1;
  802906:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  80290d:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  802914:	eb 7c                	jmp    802992 <malloc+0x132>
		{
			uint32 *pg = NULL;
  802916:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
			for (int j = 0; j < sizeofarray; j++) {
  80291d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  802924:	eb 1a                	jmp    802940 <malloc+0xe0>
				if (addresses[j] == i) {
  802926:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802929:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802930:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  802933:	75 08                	jne    80293d <malloc+0xdd>
					index = j;
  802935:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802938:	89 45 e8             	mov    %eax,-0x18(%ebp)
					break;
  80293b:	eb 0d                	jmp    80294a <malloc+0xea>
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
		{
			uint32 *pg = NULL;
			for (int j = 0; j < sizeofarray; j++) {
  80293d:	ff 45 dc             	incl   -0x24(%ebp)
  802940:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802945:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  802948:	7c dc                	jl     802926 <malloc+0xc6>
					index = j;
					break;
				}
			}

			if (index == -1) {
  80294a:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  80294e:	75 05                	jne    802955 <malloc+0xf5>
				count++;
  802950:	ff 45 f0             	incl   -0x10(%ebp)
  802953:	eb 36                	jmp    80298b <malloc+0x12b>
			} else {
				if (changed[index] == 0) {
  802955:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802958:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  80295f:	85 c0                	test   %eax,%eax
  802961:	75 05                	jne    802968 <malloc+0x108>
					count++;
  802963:	ff 45 f0             	incl   -0x10(%ebp)
  802966:	eb 23                	jmp    80298b <malloc+0x12b>
				} else {
					if (count < min && count >= num) {
  802968:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80296b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  80296e:	7d 14                	jge    802984 <malloc+0x124>
  802970:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802973:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  802976:	7c 0c                	jl     802984 <malloc+0x124>
						min = count;
  802978:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80297b:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss = i;
  80297e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802981:	89 45 e4             	mov    %eax,-0x1c(%ebp)
					}
					count = 0;
  802984:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	} else {
		int count = 0;
		int min = 1000;
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  80298b:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  802992:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  802999:	0f 86 77 ff ff ff    	jbe    802916 <malloc+0xb6>

			}

		}

		sys_allocateMem(min_addresss, size);
  80299f:	83 ec 08             	sub    $0x8,%esp
  8029a2:	ff 75 08             	pushl  0x8(%ebp)
  8029a5:	ff 75 e4             	pushl  -0x1c(%ebp)
  8029a8:	e8 cf 03 00 00       	call   802d7c <sys_allocateMem>
  8029ad:	83 c4 10             	add    $0x10,%esp
		numOfPages[sizeofarray] = num;
  8029b0:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8029b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8029b8:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
		addresses[sizeofarray] = last_addres;
  8029bf:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8029c4:	8b 15 04 40 80 00    	mov    0x804004,%edx
  8029ca:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
		changed[sizeofarray] = 1;
  8029d1:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8029d6:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  8029dd:	01 00 00 00 
		sizeofarray++;
  8029e1:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8029e6:	40                   	inc    %eax
  8029e7:	a3 2c 40 80 00       	mov    %eax,0x80402c
		return (void*) min_addresss;
  8029ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  8029ef:	c9                   	leave  
  8029f0:	c3                   	ret    

008029f1 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  8029f1:	55                   	push   %ebp
  8029f2:	89 e5                	mov    %esp,%ebp
  8029f4:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  8029f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8029fa:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  8029fd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  802a04:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  802a0b:	eb 30                	jmp    802a3d <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  802a0d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802a10:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802a17:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  802a1a:	75 1e                	jne    802a3a <free+0x49>
  802a1c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802a1f:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  802a26:	83 f8 01             	cmp    $0x1,%eax
  802a29:	75 0f                	jne    802a3a <free+0x49>
			is_found = 1;
  802a2b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  802a32:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802a35:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  802a38:	eb 0d                	jmp    802a47 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  802a3a:	ff 45 ec             	incl   -0x14(%ebp)
  802a3d:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802a42:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  802a45:	7c c6                	jl     802a0d <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  802a47:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  802a4b:	75 4f                	jne    802a9c <free+0xab>
		size = numOfPages[index] * PAGE_SIZE;
  802a4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802a50:	8b 04 85 20 76 8c 00 	mov    0x8c7620(,%eax,4),%eax
  802a57:	c1 e0 0c             	shl    $0xc,%eax
  802a5a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  802a5d:	83 ec 08             	sub    $0x8,%esp
  802a60:	ff 75 e4             	pushl  -0x1c(%ebp)
  802a63:	68 f0 3c 80 00       	push   $0x803cf0
  802a68:	e8 69 f0 ff ff       	call   801ad6 <cprintf>
  802a6d:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  802a70:	83 ec 08             	sub    $0x8,%esp
  802a73:	ff 75 e4             	pushl  -0x1c(%ebp)
  802a76:	ff 75 e8             	pushl  -0x18(%ebp)
  802a79:	e8 e2 02 00 00       	call   802d60 <sys_freeMem>
  802a7e:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  802a81:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802a84:	c7 04 85 a0 5b 86 00 	movl   $0x0,0x865ba0(,%eax,4)
  802a8b:	00 00 00 00 
		changes++;
  802a8f:	a1 28 40 80 00       	mov    0x804028,%eax
  802a94:	40                   	inc    %eax
  802a95:	a3 28 40 80 00       	mov    %eax,0x804028
		sys_freeMem(va, size);
		changed[index] = 0;
	}

	//refer to the project presentation and documentation for details
}
  802a9a:	eb 39                	jmp    802ad5 <free+0xe4>
		cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
		changed[index] = 0;
		changes++;
	} else {
		size = 513 * PAGE_SIZE;
  802a9c:	c7 45 e4 00 10 20 00 	movl   $0x201000,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  802aa3:	83 ec 08             	sub    $0x8,%esp
  802aa6:	ff 75 e4             	pushl  -0x1c(%ebp)
  802aa9:	68 f0 3c 80 00       	push   $0x803cf0
  802aae:	e8 23 f0 ff ff       	call   801ad6 <cprintf>
  802ab3:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  802ab6:	83 ec 08             	sub    $0x8,%esp
  802ab9:	ff 75 e4             	pushl  -0x1c(%ebp)
  802abc:	ff 75 e8             	pushl  -0x18(%ebp)
  802abf:	e8 9c 02 00 00       	call   802d60 <sys_freeMem>
  802ac4:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  802ac7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802aca:	c7 04 85 a0 5b 86 00 	movl   $0x0,0x865ba0(,%eax,4)
  802ad1:	00 00 00 00 
	}

	//refer to the project presentation and documentation for details
}
  802ad5:	90                   	nop
  802ad6:	c9                   	leave  
  802ad7:	c3                   	ret    

00802ad8 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  802ad8:	55                   	push   %ebp
  802ad9:	89 e5                	mov    %esp,%ebp
  802adb:	83 ec 18             	sub    $0x18,%esp
  802ade:	8b 45 10             	mov    0x10(%ebp),%eax
  802ae1:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  802ae4:	83 ec 04             	sub    $0x4,%esp
  802ae7:	68 10 3d 80 00       	push   $0x803d10
  802aec:	68 9d 00 00 00       	push   $0x9d
  802af1:	68 33 3d 80 00       	push   $0x803d33
  802af6:	e8 39 ed ff ff       	call   801834 <_panic>

00802afb <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  802afb:	55                   	push   %ebp
  802afc:	89 e5                	mov    %esp,%ebp
  802afe:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b01:	83 ec 04             	sub    $0x4,%esp
  802b04:	68 10 3d 80 00       	push   $0x803d10
  802b09:	68 a2 00 00 00       	push   $0xa2
  802b0e:	68 33 3d 80 00       	push   $0x803d33
  802b13:	e8 1c ed ff ff       	call   801834 <_panic>

00802b18 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  802b18:	55                   	push   %ebp
  802b19:	89 e5                	mov    %esp,%ebp
  802b1b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b1e:	83 ec 04             	sub    $0x4,%esp
  802b21:	68 10 3d 80 00       	push   $0x803d10
  802b26:	68 a7 00 00 00       	push   $0xa7
  802b2b:	68 33 3d 80 00       	push   $0x803d33
  802b30:	e8 ff ec ff ff       	call   801834 <_panic>

00802b35 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  802b35:	55                   	push   %ebp
  802b36:	89 e5                	mov    %esp,%ebp
  802b38:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b3b:	83 ec 04             	sub    $0x4,%esp
  802b3e:	68 10 3d 80 00       	push   $0x803d10
  802b43:	68 ab 00 00 00       	push   $0xab
  802b48:	68 33 3d 80 00       	push   $0x803d33
  802b4d:	e8 e2 ec ff ff       	call   801834 <_panic>

00802b52 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  802b52:	55                   	push   %ebp
  802b53:	89 e5                	mov    %esp,%ebp
  802b55:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b58:	83 ec 04             	sub    $0x4,%esp
  802b5b:	68 10 3d 80 00       	push   $0x803d10
  802b60:	68 b0 00 00 00       	push   $0xb0
  802b65:	68 33 3d 80 00       	push   $0x803d33
  802b6a:	e8 c5 ec ff ff       	call   801834 <_panic>

00802b6f <shrink>:
}
void shrink(uint32 newSize) {
  802b6f:	55                   	push   %ebp
  802b70:	89 e5                	mov    %esp,%ebp
  802b72:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b75:	83 ec 04             	sub    $0x4,%esp
  802b78:	68 10 3d 80 00       	push   $0x803d10
  802b7d:	68 b3 00 00 00       	push   $0xb3
  802b82:	68 33 3d 80 00       	push   $0x803d33
  802b87:	e8 a8 ec ff ff       	call   801834 <_panic>

00802b8c <freeHeap>:
}

void freeHeap(void* virtual_address) {
  802b8c:	55                   	push   %ebp
  802b8d:	89 e5                	mov    %esp,%ebp
  802b8f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b92:	83 ec 04             	sub    $0x4,%esp
  802b95:	68 10 3d 80 00       	push   $0x803d10
  802b9a:	68 b7 00 00 00       	push   $0xb7
  802b9f:	68 33 3d 80 00       	push   $0x803d33
  802ba4:	e8 8b ec ff ff       	call   801834 <_panic>

00802ba9 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  802ba9:	55                   	push   %ebp
  802baa:	89 e5                	mov    %esp,%ebp
  802bac:	57                   	push   %edi
  802bad:	56                   	push   %esi
  802bae:	53                   	push   %ebx
  802baf:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802bb2:	8b 45 08             	mov    0x8(%ebp),%eax
  802bb5:	8b 55 0c             	mov    0xc(%ebp),%edx
  802bb8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802bbb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802bbe:	8b 7d 18             	mov    0x18(%ebp),%edi
  802bc1:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802bc4:	cd 30                	int    $0x30
  802bc6:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802bc9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802bcc:	83 c4 10             	add    $0x10,%esp
  802bcf:	5b                   	pop    %ebx
  802bd0:	5e                   	pop    %esi
  802bd1:	5f                   	pop    %edi
  802bd2:	5d                   	pop    %ebp
  802bd3:	c3                   	ret    

00802bd4 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802bd4:	55                   	push   %ebp
  802bd5:	89 e5                	mov    %esp,%ebp
  802bd7:	83 ec 04             	sub    $0x4,%esp
  802bda:	8b 45 10             	mov    0x10(%ebp),%eax
  802bdd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802be0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802be4:	8b 45 08             	mov    0x8(%ebp),%eax
  802be7:	6a 00                	push   $0x0
  802be9:	6a 00                	push   $0x0
  802beb:	52                   	push   %edx
  802bec:	ff 75 0c             	pushl  0xc(%ebp)
  802bef:	50                   	push   %eax
  802bf0:	6a 00                	push   $0x0
  802bf2:	e8 b2 ff ff ff       	call   802ba9 <syscall>
  802bf7:	83 c4 18             	add    $0x18,%esp
}
  802bfa:	90                   	nop
  802bfb:	c9                   	leave  
  802bfc:	c3                   	ret    

00802bfd <sys_cgetc>:

int
sys_cgetc(void)
{
  802bfd:	55                   	push   %ebp
  802bfe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802c00:	6a 00                	push   $0x0
  802c02:	6a 00                	push   $0x0
  802c04:	6a 00                	push   $0x0
  802c06:	6a 00                	push   $0x0
  802c08:	6a 00                	push   $0x0
  802c0a:	6a 01                	push   $0x1
  802c0c:	e8 98 ff ff ff       	call   802ba9 <syscall>
  802c11:	83 c4 18             	add    $0x18,%esp
}
  802c14:	c9                   	leave  
  802c15:	c3                   	ret    

00802c16 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802c16:	55                   	push   %ebp
  802c17:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802c19:	8b 45 08             	mov    0x8(%ebp),%eax
  802c1c:	6a 00                	push   $0x0
  802c1e:	6a 00                	push   $0x0
  802c20:	6a 00                	push   $0x0
  802c22:	6a 00                	push   $0x0
  802c24:	50                   	push   %eax
  802c25:	6a 05                	push   $0x5
  802c27:	e8 7d ff ff ff       	call   802ba9 <syscall>
  802c2c:	83 c4 18             	add    $0x18,%esp
}
  802c2f:	c9                   	leave  
  802c30:	c3                   	ret    

00802c31 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802c31:	55                   	push   %ebp
  802c32:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802c34:	6a 00                	push   $0x0
  802c36:	6a 00                	push   $0x0
  802c38:	6a 00                	push   $0x0
  802c3a:	6a 00                	push   $0x0
  802c3c:	6a 00                	push   $0x0
  802c3e:	6a 02                	push   $0x2
  802c40:	e8 64 ff ff ff       	call   802ba9 <syscall>
  802c45:	83 c4 18             	add    $0x18,%esp
}
  802c48:	c9                   	leave  
  802c49:	c3                   	ret    

00802c4a <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802c4a:	55                   	push   %ebp
  802c4b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802c4d:	6a 00                	push   $0x0
  802c4f:	6a 00                	push   $0x0
  802c51:	6a 00                	push   $0x0
  802c53:	6a 00                	push   $0x0
  802c55:	6a 00                	push   $0x0
  802c57:	6a 03                	push   $0x3
  802c59:	e8 4b ff ff ff       	call   802ba9 <syscall>
  802c5e:	83 c4 18             	add    $0x18,%esp
}
  802c61:	c9                   	leave  
  802c62:	c3                   	ret    

00802c63 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802c63:	55                   	push   %ebp
  802c64:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802c66:	6a 00                	push   $0x0
  802c68:	6a 00                	push   $0x0
  802c6a:	6a 00                	push   $0x0
  802c6c:	6a 00                	push   $0x0
  802c6e:	6a 00                	push   $0x0
  802c70:	6a 04                	push   $0x4
  802c72:	e8 32 ff ff ff       	call   802ba9 <syscall>
  802c77:	83 c4 18             	add    $0x18,%esp
}
  802c7a:	c9                   	leave  
  802c7b:	c3                   	ret    

00802c7c <sys_env_exit>:


void sys_env_exit(void)
{
  802c7c:	55                   	push   %ebp
  802c7d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802c7f:	6a 00                	push   $0x0
  802c81:	6a 00                	push   $0x0
  802c83:	6a 00                	push   $0x0
  802c85:	6a 00                	push   $0x0
  802c87:	6a 00                	push   $0x0
  802c89:	6a 06                	push   $0x6
  802c8b:	e8 19 ff ff ff       	call   802ba9 <syscall>
  802c90:	83 c4 18             	add    $0x18,%esp
}
  802c93:	90                   	nop
  802c94:	c9                   	leave  
  802c95:	c3                   	ret    

00802c96 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802c96:	55                   	push   %ebp
  802c97:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802c99:	8b 55 0c             	mov    0xc(%ebp),%edx
  802c9c:	8b 45 08             	mov    0x8(%ebp),%eax
  802c9f:	6a 00                	push   $0x0
  802ca1:	6a 00                	push   $0x0
  802ca3:	6a 00                	push   $0x0
  802ca5:	52                   	push   %edx
  802ca6:	50                   	push   %eax
  802ca7:	6a 07                	push   $0x7
  802ca9:	e8 fb fe ff ff       	call   802ba9 <syscall>
  802cae:	83 c4 18             	add    $0x18,%esp
}
  802cb1:	c9                   	leave  
  802cb2:	c3                   	ret    

00802cb3 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802cb3:	55                   	push   %ebp
  802cb4:	89 e5                	mov    %esp,%ebp
  802cb6:	56                   	push   %esi
  802cb7:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802cb8:	8b 75 18             	mov    0x18(%ebp),%esi
  802cbb:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802cbe:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802cc1:	8b 55 0c             	mov    0xc(%ebp),%edx
  802cc4:	8b 45 08             	mov    0x8(%ebp),%eax
  802cc7:	56                   	push   %esi
  802cc8:	53                   	push   %ebx
  802cc9:	51                   	push   %ecx
  802cca:	52                   	push   %edx
  802ccb:	50                   	push   %eax
  802ccc:	6a 08                	push   $0x8
  802cce:	e8 d6 fe ff ff       	call   802ba9 <syscall>
  802cd3:	83 c4 18             	add    $0x18,%esp
}
  802cd6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802cd9:	5b                   	pop    %ebx
  802cda:	5e                   	pop    %esi
  802cdb:	5d                   	pop    %ebp
  802cdc:	c3                   	ret    

00802cdd <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802cdd:	55                   	push   %ebp
  802cde:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802ce0:	8b 55 0c             	mov    0xc(%ebp),%edx
  802ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  802ce6:	6a 00                	push   $0x0
  802ce8:	6a 00                	push   $0x0
  802cea:	6a 00                	push   $0x0
  802cec:	52                   	push   %edx
  802ced:	50                   	push   %eax
  802cee:	6a 09                	push   $0x9
  802cf0:	e8 b4 fe ff ff       	call   802ba9 <syscall>
  802cf5:	83 c4 18             	add    $0x18,%esp
}
  802cf8:	c9                   	leave  
  802cf9:	c3                   	ret    

00802cfa <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802cfa:	55                   	push   %ebp
  802cfb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802cfd:	6a 00                	push   $0x0
  802cff:	6a 00                	push   $0x0
  802d01:	6a 00                	push   $0x0
  802d03:	ff 75 0c             	pushl  0xc(%ebp)
  802d06:	ff 75 08             	pushl  0x8(%ebp)
  802d09:	6a 0a                	push   $0xa
  802d0b:	e8 99 fe ff ff       	call   802ba9 <syscall>
  802d10:	83 c4 18             	add    $0x18,%esp
}
  802d13:	c9                   	leave  
  802d14:	c3                   	ret    

00802d15 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802d15:	55                   	push   %ebp
  802d16:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802d18:	6a 00                	push   $0x0
  802d1a:	6a 00                	push   $0x0
  802d1c:	6a 00                	push   $0x0
  802d1e:	6a 00                	push   $0x0
  802d20:	6a 00                	push   $0x0
  802d22:	6a 0b                	push   $0xb
  802d24:	e8 80 fe ff ff       	call   802ba9 <syscall>
  802d29:	83 c4 18             	add    $0x18,%esp
}
  802d2c:	c9                   	leave  
  802d2d:	c3                   	ret    

00802d2e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802d2e:	55                   	push   %ebp
  802d2f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802d31:	6a 00                	push   $0x0
  802d33:	6a 00                	push   $0x0
  802d35:	6a 00                	push   $0x0
  802d37:	6a 00                	push   $0x0
  802d39:	6a 00                	push   $0x0
  802d3b:	6a 0c                	push   $0xc
  802d3d:	e8 67 fe ff ff       	call   802ba9 <syscall>
  802d42:	83 c4 18             	add    $0x18,%esp
}
  802d45:	c9                   	leave  
  802d46:	c3                   	ret    

00802d47 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802d47:	55                   	push   %ebp
  802d48:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802d4a:	6a 00                	push   $0x0
  802d4c:	6a 00                	push   $0x0
  802d4e:	6a 00                	push   $0x0
  802d50:	6a 00                	push   $0x0
  802d52:	6a 00                	push   $0x0
  802d54:	6a 0d                	push   $0xd
  802d56:	e8 4e fe ff ff       	call   802ba9 <syscall>
  802d5b:	83 c4 18             	add    $0x18,%esp
}
  802d5e:	c9                   	leave  
  802d5f:	c3                   	ret    

00802d60 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802d60:	55                   	push   %ebp
  802d61:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802d63:	6a 00                	push   $0x0
  802d65:	6a 00                	push   $0x0
  802d67:	6a 00                	push   $0x0
  802d69:	ff 75 0c             	pushl  0xc(%ebp)
  802d6c:	ff 75 08             	pushl  0x8(%ebp)
  802d6f:	6a 11                	push   $0x11
  802d71:	e8 33 fe ff ff       	call   802ba9 <syscall>
  802d76:	83 c4 18             	add    $0x18,%esp
	return;
  802d79:	90                   	nop
}
  802d7a:	c9                   	leave  
  802d7b:	c3                   	ret    

00802d7c <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802d7c:	55                   	push   %ebp
  802d7d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802d7f:	6a 00                	push   $0x0
  802d81:	6a 00                	push   $0x0
  802d83:	6a 00                	push   $0x0
  802d85:	ff 75 0c             	pushl  0xc(%ebp)
  802d88:	ff 75 08             	pushl  0x8(%ebp)
  802d8b:	6a 12                	push   $0x12
  802d8d:	e8 17 fe ff ff       	call   802ba9 <syscall>
  802d92:	83 c4 18             	add    $0x18,%esp
	return ;
  802d95:	90                   	nop
}
  802d96:	c9                   	leave  
  802d97:	c3                   	ret    

00802d98 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802d98:	55                   	push   %ebp
  802d99:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802d9b:	6a 00                	push   $0x0
  802d9d:	6a 00                	push   $0x0
  802d9f:	6a 00                	push   $0x0
  802da1:	6a 00                	push   $0x0
  802da3:	6a 00                	push   $0x0
  802da5:	6a 0e                	push   $0xe
  802da7:	e8 fd fd ff ff       	call   802ba9 <syscall>
  802dac:	83 c4 18             	add    $0x18,%esp
}
  802daf:	c9                   	leave  
  802db0:	c3                   	ret    

00802db1 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802db1:	55                   	push   %ebp
  802db2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802db4:	6a 00                	push   $0x0
  802db6:	6a 00                	push   $0x0
  802db8:	6a 00                	push   $0x0
  802dba:	6a 00                	push   $0x0
  802dbc:	ff 75 08             	pushl  0x8(%ebp)
  802dbf:	6a 0f                	push   $0xf
  802dc1:	e8 e3 fd ff ff       	call   802ba9 <syscall>
  802dc6:	83 c4 18             	add    $0x18,%esp
}
  802dc9:	c9                   	leave  
  802dca:	c3                   	ret    

00802dcb <sys_scarce_memory>:

void sys_scarce_memory()
{
  802dcb:	55                   	push   %ebp
  802dcc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802dce:	6a 00                	push   $0x0
  802dd0:	6a 00                	push   $0x0
  802dd2:	6a 00                	push   $0x0
  802dd4:	6a 00                	push   $0x0
  802dd6:	6a 00                	push   $0x0
  802dd8:	6a 10                	push   $0x10
  802dda:	e8 ca fd ff ff       	call   802ba9 <syscall>
  802ddf:	83 c4 18             	add    $0x18,%esp
}
  802de2:	90                   	nop
  802de3:	c9                   	leave  
  802de4:	c3                   	ret    

00802de5 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802de5:	55                   	push   %ebp
  802de6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802de8:	6a 00                	push   $0x0
  802dea:	6a 00                	push   $0x0
  802dec:	6a 00                	push   $0x0
  802dee:	6a 00                	push   $0x0
  802df0:	6a 00                	push   $0x0
  802df2:	6a 14                	push   $0x14
  802df4:	e8 b0 fd ff ff       	call   802ba9 <syscall>
  802df9:	83 c4 18             	add    $0x18,%esp
}
  802dfc:	90                   	nop
  802dfd:	c9                   	leave  
  802dfe:	c3                   	ret    

00802dff <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802dff:	55                   	push   %ebp
  802e00:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802e02:	6a 00                	push   $0x0
  802e04:	6a 00                	push   $0x0
  802e06:	6a 00                	push   $0x0
  802e08:	6a 00                	push   $0x0
  802e0a:	6a 00                	push   $0x0
  802e0c:	6a 15                	push   $0x15
  802e0e:	e8 96 fd ff ff       	call   802ba9 <syscall>
  802e13:	83 c4 18             	add    $0x18,%esp
}
  802e16:	90                   	nop
  802e17:	c9                   	leave  
  802e18:	c3                   	ret    

00802e19 <sys_cputc>:


void
sys_cputc(const char c)
{
  802e19:	55                   	push   %ebp
  802e1a:	89 e5                	mov    %esp,%ebp
  802e1c:	83 ec 04             	sub    $0x4,%esp
  802e1f:	8b 45 08             	mov    0x8(%ebp),%eax
  802e22:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802e25:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802e29:	6a 00                	push   $0x0
  802e2b:	6a 00                	push   $0x0
  802e2d:	6a 00                	push   $0x0
  802e2f:	6a 00                	push   $0x0
  802e31:	50                   	push   %eax
  802e32:	6a 16                	push   $0x16
  802e34:	e8 70 fd ff ff       	call   802ba9 <syscall>
  802e39:	83 c4 18             	add    $0x18,%esp
}
  802e3c:	90                   	nop
  802e3d:	c9                   	leave  
  802e3e:	c3                   	ret    

00802e3f <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802e3f:	55                   	push   %ebp
  802e40:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802e42:	6a 00                	push   $0x0
  802e44:	6a 00                	push   $0x0
  802e46:	6a 00                	push   $0x0
  802e48:	6a 00                	push   $0x0
  802e4a:	6a 00                	push   $0x0
  802e4c:	6a 17                	push   $0x17
  802e4e:	e8 56 fd ff ff       	call   802ba9 <syscall>
  802e53:	83 c4 18             	add    $0x18,%esp
}
  802e56:	90                   	nop
  802e57:	c9                   	leave  
  802e58:	c3                   	ret    

00802e59 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802e59:	55                   	push   %ebp
  802e5a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802e5c:	8b 45 08             	mov    0x8(%ebp),%eax
  802e5f:	6a 00                	push   $0x0
  802e61:	6a 00                	push   $0x0
  802e63:	6a 00                	push   $0x0
  802e65:	ff 75 0c             	pushl  0xc(%ebp)
  802e68:	50                   	push   %eax
  802e69:	6a 18                	push   $0x18
  802e6b:	e8 39 fd ff ff       	call   802ba9 <syscall>
  802e70:	83 c4 18             	add    $0x18,%esp
}
  802e73:	c9                   	leave  
  802e74:	c3                   	ret    

00802e75 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802e75:	55                   	push   %ebp
  802e76:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802e78:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e7b:	8b 45 08             	mov    0x8(%ebp),%eax
  802e7e:	6a 00                	push   $0x0
  802e80:	6a 00                	push   $0x0
  802e82:	6a 00                	push   $0x0
  802e84:	52                   	push   %edx
  802e85:	50                   	push   %eax
  802e86:	6a 1b                	push   $0x1b
  802e88:	e8 1c fd ff ff       	call   802ba9 <syscall>
  802e8d:	83 c4 18             	add    $0x18,%esp
}
  802e90:	c9                   	leave  
  802e91:	c3                   	ret    

00802e92 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802e92:	55                   	push   %ebp
  802e93:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802e95:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e98:	8b 45 08             	mov    0x8(%ebp),%eax
  802e9b:	6a 00                	push   $0x0
  802e9d:	6a 00                	push   $0x0
  802e9f:	6a 00                	push   $0x0
  802ea1:	52                   	push   %edx
  802ea2:	50                   	push   %eax
  802ea3:	6a 19                	push   $0x19
  802ea5:	e8 ff fc ff ff       	call   802ba9 <syscall>
  802eaa:	83 c4 18             	add    $0x18,%esp
}
  802ead:	90                   	nop
  802eae:	c9                   	leave  
  802eaf:	c3                   	ret    

00802eb0 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802eb0:	55                   	push   %ebp
  802eb1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802eb3:	8b 55 0c             	mov    0xc(%ebp),%edx
  802eb6:	8b 45 08             	mov    0x8(%ebp),%eax
  802eb9:	6a 00                	push   $0x0
  802ebb:	6a 00                	push   $0x0
  802ebd:	6a 00                	push   $0x0
  802ebf:	52                   	push   %edx
  802ec0:	50                   	push   %eax
  802ec1:	6a 1a                	push   $0x1a
  802ec3:	e8 e1 fc ff ff       	call   802ba9 <syscall>
  802ec8:	83 c4 18             	add    $0x18,%esp
}
  802ecb:	90                   	nop
  802ecc:	c9                   	leave  
  802ecd:	c3                   	ret    

00802ece <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802ece:	55                   	push   %ebp
  802ecf:	89 e5                	mov    %esp,%ebp
  802ed1:	83 ec 04             	sub    $0x4,%esp
  802ed4:	8b 45 10             	mov    0x10(%ebp),%eax
  802ed7:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802eda:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802edd:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  802ee4:	6a 00                	push   $0x0
  802ee6:	51                   	push   %ecx
  802ee7:	52                   	push   %edx
  802ee8:	ff 75 0c             	pushl  0xc(%ebp)
  802eeb:	50                   	push   %eax
  802eec:	6a 1c                	push   $0x1c
  802eee:	e8 b6 fc ff ff       	call   802ba9 <syscall>
  802ef3:	83 c4 18             	add    $0x18,%esp
}
  802ef6:	c9                   	leave  
  802ef7:	c3                   	ret    

00802ef8 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802ef8:	55                   	push   %ebp
  802ef9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802efb:	8b 55 0c             	mov    0xc(%ebp),%edx
  802efe:	8b 45 08             	mov    0x8(%ebp),%eax
  802f01:	6a 00                	push   $0x0
  802f03:	6a 00                	push   $0x0
  802f05:	6a 00                	push   $0x0
  802f07:	52                   	push   %edx
  802f08:	50                   	push   %eax
  802f09:	6a 1d                	push   $0x1d
  802f0b:	e8 99 fc ff ff       	call   802ba9 <syscall>
  802f10:	83 c4 18             	add    $0x18,%esp
}
  802f13:	c9                   	leave  
  802f14:	c3                   	ret    

00802f15 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802f15:	55                   	push   %ebp
  802f16:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802f18:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802f1b:	8b 55 0c             	mov    0xc(%ebp),%edx
  802f1e:	8b 45 08             	mov    0x8(%ebp),%eax
  802f21:	6a 00                	push   $0x0
  802f23:	6a 00                	push   $0x0
  802f25:	51                   	push   %ecx
  802f26:	52                   	push   %edx
  802f27:	50                   	push   %eax
  802f28:	6a 1e                	push   $0x1e
  802f2a:	e8 7a fc ff ff       	call   802ba9 <syscall>
  802f2f:	83 c4 18             	add    $0x18,%esp
}
  802f32:	c9                   	leave  
  802f33:	c3                   	ret    

00802f34 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802f34:	55                   	push   %ebp
  802f35:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802f37:	8b 55 0c             	mov    0xc(%ebp),%edx
  802f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  802f3d:	6a 00                	push   $0x0
  802f3f:	6a 00                	push   $0x0
  802f41:	6a 00                	push   $0x0
  802f43:	52                   	push   %edx
  802f44:	50                   	push   %eax
  802f45:	6a 1f                	push   $0x1f
  802f47:	e8 5d fc ff ff       	call   802ba9 <syscall>
  802f4c:	83 c4 18             	add    $0x18,%esp
}
  802f4f:	c9                   	leave  
  802f50:	c3                   	ret    

00802f51 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802f51:	55                   	push   %ebp
  802f52:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802f54:	6a 00                	push   $0x0
  802f56:	6a 00                	push   $0x0
  802f58:	6a 00                	push   $0x0
  802f5a:	6a 00                	push   $0x0
  802f5c:	6a 00                	push   $0x0
  802f5e:	6a 20                	push   $0x20
  802f60:	e8 44 fc ff ff       	call   802ba9 <syscall>
  802f65:	83 c4 18             	add    $0x18,%esp
}
  802f68:	c9                   	leave  
  802f69:	c3                   	ret    

00802f6a <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802f6a:	55                   	push   %ebp
  802f6b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  802f70:	6a 00                	push   $0x0
  802f72:	ff 75 14             	pushl  0x14(%ebp)
  802f75:	ff 75 10             	pushl  0x10(%ebp)
  802f78:	ff 75 0c             	pushl  0xc(%ebp)
  802f7b:	50                   	push   %eax
  802f7c:	6a 21                	push   $0x21
  802f7e:	e8 26 fc ff ff       	call   802ba9 <syscall>
  802f83:	83 c4 18             	add    $0x18,%esp
}
  802f86:	c9                   	leave  
  802f87:	c3                   	ret    

00802f88 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802f88:	55                   	push   %ebp
  802f89:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  802f8e:	6a 00                	push   $0x0
  802f90:	6a 00                	push   $0x0
  802f92:	6a 00                	push   $0x0
  802f94:	6a 00                	push   $0x0
  802f96:	50                   	push   %eax
  802f97:	6a 22                	push   $0x22
  802f99:	e8 0b fc ff ff       	call   802ba9 <syscall>
  802f9e:	83 c4 18             	add    $0x18,%esp
}
  802fa1:	90                   	nop
  802fa2:	c9                   	leave  
  802fa3:	c3                   	ret    

00802fa4 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802fa4:	55                   	push   %ebp
  802fa5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  802faa:	6a 00                	push   $0x0
  802fac:	6a 00                	push   $0x0
  802fae:	6a 00                	push   $0x0
  802fb0:	6a 00                	push   $0x0
  802fb2:	50                   	push   %eax
  802fb3:	6a 23                	push   $0x23
  802fb5:	e8 ef fb ff ff       	call   802ba9 <syscall>
  802fba:	83 c4 18             	add    $0x18,%esp
}
  802fbd:	90                   	nop
  802fbe:	c9                   	leave  
  802fbf:	c3                   	ret    

00802fc0 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802fc0:	55                   	push   %ebp
  802fc1:	89 e5                	mov    %esp,%ebp
  802fc3:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802fc6:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802fc9:	8d 50 04             	lea    0x4(%eax),%edx
  802fcc:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802fcf:	6a 00                	push   $0x0
  802fd1:	6a 00                	push   $0x0
  802fd3:	6a 00                	push   $0x0
  802fd5:	52                   	push   %edx
  802fd6:	50                   	push   %eax
  802fd7:	6a 24                	push   $0x24
  802fd9:	e8 cb fb ff ff       	call   802ba9 <syscall>
  802fde:	83 c4 18             	add    $0x18,%esp
	return result;
  802fe1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802fe4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802fe7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802fea:	89 01                	mov    %eax,(%ecx)
  802fec:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802fef:	8b 45 08             	mov    0x8(%ebp),%eax
  802ff2:	c9                   	leave  
  802ff3:	c2 04 00             	ret    $0x4

00802ff6 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802ff6:	55                   	push   %ebp
  802ff7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802ff9:	6a 00                	push   $0x0
  802ffb:	6a 00                	push   $0x0
  802ffd:	ff 75 10             	pushl  0x10(%ebp)
  803000:	ff 75 0c             	pushl  0xc(%ebp)
  803003:	ff 75 08             	pushl  0x8(%ebp)
  803006:	6a 13                	push   $0x13
  803008:	e8 9c fb ff ff       	call   802ba9 <syscall>
  80300d:	83 c4 18             	add    $0x18,%esp
	return ;
  803010:	90                   	nop
}
  803011:	c9                   	leave  
  803012:	c3                   	ret    

00803013 <sys_rcr2>:
uint32 sys_rcr2()
{
  803013:	55                   	push   %ebp
  803014:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  803016:	6a 00                	push   $0x0
  803018:	6a 00                	push   $0x0
  80301a:	6a 00                	push   $0x0
  80301c:	6a 00                	push   $0x0
  80301e:	6a 00                	push   $0x0
  803020:	6a 25                	push   $0x25
  803022:	e8 82 fb ff ff       	call   802ba9 <syscall>
  803027:	83 c4 18             	add    $0x18,%esp
}
  80302a:	c9                   	leave  
  80302b:	c3                   	ret    

0080302c <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80302c:	55                   	push   %ebp
  80302d:	89 e5                	mov    %esp,%ebp
  80302f:	83 ec 04             	sub    $0x4,%esp
  803032:	8b 45 08             	mov    0x8(%ebp),%eax
  803035:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  803038:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80303c:	6a 00                	push   $0x0
  80303e:	6a 00                	push   $0x0
  803040:	6a 00                	push   $0x0
  803042:	6a 00                	push   $0x0
  803044:	50                   	push   %eax
  803045:	6a 26                	push   $0x26
  803047:	e8 5d fb ff ff       	call   802ba9 <syscall>
  80304c:	83 c4 18             	add    $0x18,%esp
	return ;
  80304f:	90                   	nop
}
  803050:	c9                   	leave  
  803051:	c3                   	ret    

00803052 <rsttst>:
void rsttst()
{
  803052:	55                   	push   %ebp
  803053:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  803055:	6a 00                	push   $0x0
  803057:	6a 00                	push   $0x0
  803059:	6a 00                	push   $0x0
  80305b:	6a 00                	push   $0x0
  80305d:	6a 00                	push   $0x0
  80305f:	6a 28                	push   $0x28
  803061:	e8 43 fb ff ff       	call   802ba9 <syscall>
  803066:	83 c4 18             	add    $0x18,%esp
	return ;
  803069:	90                   	nop
}
  80306a:	c9                   	leave  
  80306b:	c3                   	ret    

0080306c <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80306c:	55                   	push   %ebp
  80306d:	89 e5                	mov    %esp,%ebp
  80306f:	83 ec 04             	sub    $0x4,%esp
  803072:	8b 45 14             	mov    0x14(%ebp),%eax
  803075:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  803078:	8b 55 18             	mov    0x18(%ebp),%edx
  80307b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80307f:	52                   	push   %edx
  803080:	50                   	push   %eax
  803081:	ff 75 10             	pushl  0x10(%ebp)
  803084:	ff 75 0c             	pushl  0xc(%ebp)
  803087:	ff 75 08             	pushl  0x8(%ebp)
  80308a:	6a 27                	push   $0x27
  80308c:	e8 18 fb ff ff       	call   802ba9 <syscall>
  803091:	83 c4 18             	add    $0x18,%esp
	return ;
  803094:	90                   	nop
}
  803095:	c9                   	leave  
  803096:	c3                   	ret    

00803097 <chktst>:
void chktst(uint32 n)
{
  803097:	55                   	push   %ebp
  803098:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80309a:	6a 00                	push   $0x0
  80309c:	6a 00                	push   $0x0
  80309e:	6a 00                	push   $0x0
  8030a0:	6a 00                	push   $0x0
  8030a2:	ff 75 08             	pushl  0x8(%ebp)
  8030a5:	6a 29                	push   $0x29
  8030a7:	e8 fd fa ff ff       	call   802ba9 <syscall>
  8030ac:	83 c4 18             	add    $0x18,%esp
	return ;
  8030af:	90                   	nop
}
  8030b0:	c9                   	leave  
  8030b1:	c3                   	ret    

008030b2 <inctst>:

void inctst()
{
  8030b2:	55                   	push   %ebp
  8030b3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8030b5:	6a 00                	push   $0x0
  8030b7:	6a 00                	push   $0x0
  8030b9:	6a 00                	push   $0x0
  8030bb:	6a 00                	push   $0x0
  8030bd:	6a 00                	push   $0x0
  8030bf:	6a 2a                	push   $0x2a
  8030c1:	e8 e3 fa ff ff       	call   802ba9 <syscall>
  8030c6:	83 c4 18             	add    $0x18,%esp
	return ;
  8030c9:	90                   	nop
}
  8030ca:	c9                   	leave  
  8030cb:	c3                   	ret    

008030cc <gettst>:
uint32 gettst()
{
  8030cc:	55                   	push   %ebp
  8030cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8030cf:	6a 00                	push   $0x0
  8030d1:	6a 00                	push   $0x0
  8030d3:	6a 00                	push   $0x0
  8030d5:	6a 00                	push   $0x0
  8030d7:	6a 00                	push   $0x0
  8030d9:	6a 2b                	push   $0x2b
  8030db:	e8 c9 fa ff ff       	call   802ba9 <syscall>
  8030e0:	83 c4 18             	add    $0x18,%esp
}
  8030e3:	c9                   	leave  
  8030e4:	c3                   	ret    

008030e5 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8030e5:	55                   	push   %ebp
  8030e6:	89 e5                	mov    %esp,%ebp
  8030e8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8030eb:	6a 00                	push   $0x0
  8030ed:	6a 00                	push   $0x0
  8030ef:	6a 00                	push   $0x0
  8030f1:	6a 00                	push   $0x0
  8030f3:	6a 00                	push   $0x0
  8030f5:	6a 2c                	push   $0x2c
  8030f7:	e8 ad fa ff ff       	call   802ba9 <syscall>
  8030fc:	83 c4 18             	add    $0x18,%esp
  8030ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  803102:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  803106:	75 07                	jne    80310f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  803108:	b8 01 00 00 00       	mov    $0x1,%eax
  80310d:	eb 05                	jmp    803114 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80310f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  803114:	c9                   	leave  
  803115:	c3                   	ret    

00803116 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  803116:	55                   	push   %ebp
  803117:	89 e5                	mov    %esp,%ebp
  803119:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80311c:	6a 00                	push   $0x0
  80311e:	6a 00                	push   $0x0
  803120:	6a 00                	push   $0x0
  803122:	6a 00                	push   $0x0
  803124:	6a 00                	push   $0x0
  803126:	6a 2c                	push   $0x2c
  803128:	e8 7c fa ff ff       	call   802ba9 <syscall>
  80312d:	83 c4 18             	add    $0x18,%esp
  803130:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  803133:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  803137:	75 07                	jne    803140 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  803139:	b8 01 00 00 00       	mov    $0x1,%eax
  80313e:	eb 05                	jmp    803145 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  803140:	b8 00 00 00 00       	mov    $0x0,%eax
}
  803145:	c9                   	leave  
  803146:	c3                   	ret    

00803147 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  803147:	55                   	push   %ebp
  803148:	89 e5                	mov    %esp,%ebp
  80314a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80314d:	6a 00                	push   $0x0
  80314f:	6a 00                	push   $0x0
  803151:	6a 00                	push   $0x0
  803153:	6a 00                	push   $0x0
  803155:	6a 00                	push   $0x0
  803157:	6a 2c                	push   $0x2c
  803159:	e8 4b fa ff ff       	call   802ba9 <syscall>
  80315e:	83 c4 18             	add    $0x18,%esp
  803161:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  803164:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  803168:	75 07                	jne    803171 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80316a:	b8 01 00 00 00       	mov    $0x1,%eax
  80316f:	eb 05                	jmp    803176 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  803171:	b8 00 00 00 00       	mov    $0x0,%eax
}
  803176:	c9                   	leave  
  803177:	c3                   	ret    

00803178 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  803178:	55                   	push   %ebp
  803179:	89 e5                	mov    %esp,%ebp
  80317b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80317e:	6a 00                	push   $0x0
  803180:	6a 00                	push   $0x0
  803182:	6a 00                	push   $0x0
  803184:	6a 00                	push   $0x0
  803186:	6a 00                	push   $0x0
  803188:	6a 2c                	push   $0x2c
  80318a:	e8 1a fa ff ff       	call   802ba9 <syscall>
  80318f:	83 c4 18             	add    $0x18,%esp
  803192:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  803195:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  803199:	75 07                	jne    8031a2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80319b:	b8 01 00 00 00       	mov    $0x1,%eax
  8031a0:	eb 05                	jmp    8031a7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8031a2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8031a7:	c9                   	leave  
  8031a8:	c3                   	ret    

008031a9 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8031a9:	55                   	push   %ebp
  8031aa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8031ac:	6a 00                	push   $0x0
  8031ae:	6a 00                	push   $0x0
  8031b0:	6a 00                	push   $0x0
  8031b2:	6a 00                	push   $0x0
  8031b4:	ff 75 08             	pushl  0x8(%ebp)
  8031b7:	6a 2d                	push   $0x2d
  8031b9:	e8 eb f9 ff ff       	call   802ba9 <syscall>
  8031be:	83 c4 18             	add    $0x18,%esp
	return ;
  8031c1:	90                   	nop
}
  8031c2:	c9                   	leave  
  8031c3:	c3                   	ret    

008031c4 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8031c4:	55                   	push   %ebp
  8031c5:	89 e5                	mov    %esp,%ebp
  8031c7:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8031c8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8031cb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8031ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8031d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8031d4:	6a 00                	push   $0x0
  8031d6:	53                   	push   %ebx
  8031d7:	51                   	push   %ecx
  8031d8:	52                   	push   %edx
  8031d9:	50                   	push   %eax
  8031da:	6a 2e                	push   $0x2e
  8031dc:	e8 c8 f9 ff ff       	call   802ba9 <syscall>
  8031e1:	83 c4 18             	add    $0x18,%esp
}
  8031e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8031e7:	c9                   	leave  
  8031e8:	c3                   	ret    

008031e9 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8031e9:	55                   	push   %ebp
  8031ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8031ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8031ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8031f2:	6a 00                	push   $0x0
  8031f4:	6a 00                	push   $0x0
  8031f6:	6a 00                	push   $0x0
  8031f8:	52                   	push   %edx
  8031f9:	50                   	push   %eax
  8031fa:	6a 2f                	push   $0x2f
  8031fc:	e8 a8 f9 ff ff       	call   802ba9 <syscall>
  803201:	83 c4 18             	add    $0x18,%esp
}
  803204:	c9                   	leave  
  803205:	c3                   	ret    
  803206:	66 90                	xchg   %ax,%ax

00803208 <__udivdi3>:
  803208:	55                   	push   %ebp
  803209:	57                   	push   %edi
  80320a:	56                   	push   %esi
  80320b:	53                   	push   %ebx
  80320c:	83 ec 1c             	sub    $0x1c,%esp
  80320f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  803213:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  803217:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80321b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80321f:	89 ca                	mov    %ecx,%edx
  803221:	89 f8                	mov    %edi,%eax
  803223:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  803227:	85 f6                	test   %esi,%esi
  803229:	75 2d                	jne    803258 <__udivdi3+0x50>
  80322b:	39 cf                	cmp    %ecx,%edi
  80322d:	77 65                	ja     803294 <__udivdi3+0x8c>
  80322f:	89 fd                	mov    %edi,%ebp
  803231:	85 ff                	test   %edi,%edi
  803233:	75 0b                	jne    803240 <__udivdi3+0x38>
  803235:	b8 01 00 00 00       	mov    $0x1,%eax
  80323a:	31 d2                	xor    %edx,%edx
  80323c:	f7 f7                	div    %edi
  80323e:	89 c5                	mov    %eax,%ebp
  803240:	31 d2                	xor    %edx,%edx
  803242:	89 c8                	mov    %ecx,%eax
  803244:	f7 f5                	div    %ebp
  803246:	89 c1                	mov    %eax,%ecx
  803248:	89 d8                	mov    %ebx,%eax
  80324a:	f7 f5                	div    %ebp
  80324c:	89 cf                	mov    %ecx,%edi
  80324e:	89 fa                	mov    %edi,%edx
  803250:	83 c4 1c             	add    $0x1c,%esp
  803253:	5b                   	pop    %ebx
  803254:	5e                   	pop    %esi
  803255:	5f                   	pop    %edi
  803256:	5d                   	pop    %ebp
  803257:	c3                   	ret    
  803258:	39 ce                	cmp    %ecx,%esi
  80325a:	77 28                	ja     803284 <__udivdi3+0x7c>
  80325c:	0f bd fe             	bsr    %esi,%edi
  80325f:	83 f7 1f             	xor    $0x1f,%edi
  803262:	75 40                	jne    8032a4 <__udivdi3+0x9c>
  803264:	39 ce                	cmp    %ecx,%esi
  803266:	72 0a                	jb     803272 <__udivdi3+0x6a>
  803268:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80326c:	0f 87 9e 00 00 00    	ja     803310 <__udivdi3+0x108>
  803272:	b8 01 00 00 00       	mov    $0x1,%eax
  803277:	89 fa                	mov    %edi,%edx
  803279:	83 c4 1c             	add    $0x1c,%esp
  80327c:	5b                   	pop    %ebx
  80327d:	5e                   	pop    %esi
  80327e:	5f                   	pop    %edi
  80327f:	5d                   	pop    %ebp
  803280:	c3                   	ret    
  803281:	8d 76 00             	lea    0x0(%esi),%esi
  803284:	31 ff                	xor    %edi,%edi
  803286:	31 c0                	xor    %eax,%eax
  803288:	89 fa                	mov    %edi,%edx
  80328a:	83 c4 1c             	add    $0x1c,%esp
  80328d:	5b                   	pop    %ebx
  80328e:	5e                   	pop    %esi
  80328f:	5f                   	pop    %edi
  803290:	5d                   	pop    %ebp
  803291:	c3                   	ret    
  803292:	66 90                	xchg   %ax,%ax
  803294:	89 d8                	mov    %ebx,%eax
  803296:	f7 f7                	div    %edi
  803298:	31 ff                	xor    %edi,%edi
  80329a:	89 fa                	mov    %edi,%edx
  80329c:	83 c4 1c             	add    $0x1c,%esp
  80329f:	5b                   	pop    %ebx
  8032a0:	5e                   	pop    %esi
  8032a1:	5f                   	pop    %edi
  8032a2:	5d                   	pop    %ebp
  8032a3:	c3                   	ret    
  8032a4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8032a9:	89 eb                	mov    %ebp,%ebx
  8032ab:	29 fb                	sub    %edi,%ebx
  8032ad:	89 f9                	mov    %edi,%ecx
  8032af:	d3 e6                	shl    %cl,%esi
  8032b1:	89 c5                	mov    %eax,%ebp
  8032b3:	88 d9                	mov    %bl,%cl
  8032b5:	d3 ed                	shr    %cl,%ebp
  8032b7:	89 e9                	mov    %ebp,%ecx
  8032b9:	09 f1                	or     %esi,%ecx
  8032bb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8032bf:	89 f9                	mov    %edi,%ecx
  8032c1:	d3 e0                	shl    %cl,%eax
  8032c3:	89 c5                	mov    %eax,%ebp
  8032c5:	89 d6                	mov    %edx,%esi
  8032c7:	88 d9                	mov    %bl,%cl
  8032c9:	d3 ee                	shr    %cl,%esi
  8032cb:	89 f9                	mov    %edi,%ecx
  8032cd:	d3 e2                	shl    %cl,%edx
  8032cf:	8b 44 24 08          	mov    0x8(%esp),%eax
  8032d3:	88 d9                	mov    %bl,%cl
  8032d5:	d3 e8                	shr    %cl,%eax
  8032d7:	09 c2                	or     %eax,%edx
  8032d9:	89 d0                	mov    %edx,%eax
  8032db:	89 f2                	mov    %esi,%edx
  8032dd:	f7 74 24 0c          	divl   0xc(%esp)
  8032e1:	89 d6                	mov    %edx,%esi
  8032e3:	89 c3                	mov    %eax,%ebx
  8032e5:	f7 e5                	mul    %ebp
  8032e7:	39 d6                	cmp    %edx,%esi
  8032e9:	72 19                	jb     803304 <__udivdi3+0xfc>
  8032eb:	74 0b                	je     8032f8 <__udivdi3+0xf0>
  8032ed:	89 d8                	mov    %ebx,%eax
  8032ef:	31 ff                	xor    %edi,%edi
  8032f1:	e9 58 ff ff ff       	jmp    80324e <__udivdi3+0x46>
  8032f6:	66 90                	xchg   %ax,%ax
  8032f8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8032fc:	89 f9                	mov    %edi,%ecx
  8032fe:	d3 e2                	shl    %cl,%edx
  803300:	39 c2                	cmp    %eax,%edx
  803302:	73 e9                	jae    8032ed <__udivdi3+0xe5>
  803304:	8d 43 ff             	lea    -0x1(%ebx),%eax
  803307:	31 ff                	xor    %edi,%edi
  803309:	e9 40 ff ff ff       	jmp    80324e <__udivdi3+0x46>
  80330e:	66 90                	xchg   %ax,%ax
  803310:	31 c0                	xor    %eax,%eax
  803312:	e9 37 ff ff ff       	jmp    80324e <__udivdi3+0x46>
  803317:	90                   	nop

00803318 <__umoddi3>:
  803318:	55                   	push   %ebp
  803319:	57                   	push   %edi
  80331a:	56                   	push   %esi
  80331b:	53                   	push   %ebx
  80331c:	83 ec 1c             	sub    $0x1c,%esp
  80331f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  803323:	8b 74 24 34          	mov    0x34(%esp),%esi
  803327:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80332b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80332f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  803333:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  803337:	89 f3                	mov    %esi,%ebx
  803339:	89 fa                	mov    %edi,%edx
  80333b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80333f:	89 34 24             	mov    %esi,(%esp)
  803342:	85 c0                	test   %eax,%eax
  803344:	75 1a                	jne    803360 <__umoddi3+0x48>
  803346:	39 f7                	cmp    %esi,%edi
  803348:	0f 86 a2 00 00 00    	jbe    8033f0 <__umoddi3+0xd8>
  80334e:	89 c8                	mov    %ecx,%eax
  803350:	89 f2                	mov    %esi,%edx
  803352:	f7 f7                	div    %edi
  803354:	89 d0                	mov    %edx,%eax
  803356:	31 d2                	xor    %edx,%edx
  803358:	83 c4 1c             	add    $0x1c,%esp
  80335b:	5b                   	pop    %ebx
  80335c:	5e                   	pop    %esi
  80335d:	5f                   	pop    %edi
  80335e:	5d                   	pop    %ebp
  80335f:	c3                   	ret    
  803360:	39 f0                	cmp    %esi,%eax
  803362:	0f 87 ac 00 00 00    	ja     803414 <__umoddi3+0xfc>
  803368:	0f bd e8             	bsr    %eax,%ebp
  80336b:	83 f5 1f             	xor    $0x1f,%ebp
  80336e:	0f 84 ac 00 00 00    	je     803420 <__umoddi3+0x108>
  803374:	bf 20 00 00 00       	mov    $0x20,%edi
  803379:	29 ef                	sub    %ebp,%edi
  80337b:	89 fe                	mov    %edi,%esi
  80337d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  803381:	89 e9                	mov    %ebp,%ecx
  803383:	d3 e0                	shl    %cl,%eax
  803385:	89 d7                	mov    %edx,%edi
  803387:	89 f1                	mov    %esi,%ecx
  803389:	d3 ef                	shr    %cl,%edi
  80338b:	09 c7                	or     %eax,%edi
  80338d:	89 e9                	mov    %ebp,%ecx
  80338f:	d3 e2                	shl    %cl,%edx
  803391:	89 14 24             	mov    %edx,(%esp)
  803394:	89 d8                	mov    %ebx,%eax
  803396:	d3 e0                	shl    %cl,%eax
  803398:	89 c2                	mov    %eax,%edx
  80339a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80339e:	d3 e0                	shl    %cl,%eax
  8033a0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8033a4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8033a8:	89 f1                	mov    %esi,%ecx
  8033aa:	d3 e8                	shr    %cl,%eax
  8033ac:	09 d0                	or     %edx,%eax
  8033ae:	d3 eb                	shr    %cl,%ebx
  8033b0:	89 da                	mov    %ebx,%edx
  8033b2:	f7 f7                	div    %edi
  8033b4:	89 d3                	mov    %edx,%ebx
  8033b6:	f7 24 24             	mull   (%esp)
  8033b9:	89 c6                	mov    %eax,%esi
  8033bb:	89 d1                	mov    %edx,%ecx
  8033bd:	39 d3                	cmp    %edx,%ebx
  8033bf:	0f 82 87 00 00 00    	jb     80344c <__umoddi3+0x134>
  8033c5:	0f 84 91 00 00 00    	je     80345c <__umoddi3+0x144>
  8033cb:	8b 54 24 04          	mov    0x4(%esp),%edx
  8033cf:	29 f2                	sub    %esi,%edx
  8033d1:	19 cb                	sbb    %ecx,%ebx
  8033d3:	89 d8                	mov    %ebx,%eax
  8033d5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8033d9:	d3 e0                	shl    %cl,%eax
  8033db:	89 e9                	mov    %ebp,%ecx
  8033dd:	d3 ea                	shr    %cl,%edx
  8033df:	09 d0                	or     %edx,%eax
  8033e1:	89 e9                	mov    %ebp,%ecx
  8033e3:	d3 eb                	shr    %cl,%ebx
  8033e5:	89 da                	mov    %ebx,%edx
  8033e7:	83 c4 1c             	add    $0x1c,%esp
  8033ea:	5b                   	pop    %ebx
  8033eb:	5e                   	pop    %esi
  8033ec:	5f                   	pop    %edi
  8033ed:	5d                   	pop    %ebp
  8033ee:	c3                   	ret    
  8033ef:	90                   	nop
  8033f0:	89 fd                	mov    %edi,%ebp
  8033f2:	85 ff                	test   %edi,%edi
  8033f4:	75 0b                	jne    803401 <__umoddi3+0xe9>
  8033f6:	b8 01 00 00 00       	mov    $0x1,%eax
  8033fb:	31 d2                	xor    %edx,%edx
  8033fd:	f7 f7                	div    %edi
  8033ff:	89 c5                	mov    %eax,%ebp
  803401:	89 f0                	mov    %esi,%eax
  803403:	31 d2                	xor    %edx,%edx
  803405:	f7 f5                	div    %ebp
  803407:	89 c8                	mov    %ecx,%eax
  803409:	f7 f5                	div    %ebp
  80340b:	89 d0                	mov    %edx,%eax
  80340d:	e9 44 ff ff ff       	jmp    803356 <__umoddi3+0x3e>
  803412:	66 90                	xchg   %ax,%ax
  803414:	89 c8                	mov    %ecx,%eax
  803416:	89 f2                	mov    %esi,%edx
  803418:	83 c4 1c             	add    $0x1c,%esp
  80341b:	5b                   	pop    %ebx
  80341c:	5e                   	pop    %esi
  80341d:	5f                   	pop    %edi
  80341e:	5d                   	pop    %ebp
  80341f:	c3                   	ret    
  803420:	3b 04 24             	cmp    (%esp),%eax
  803423:	72 06                	jb     80342b <__umoddi3+0x113>
  803425:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  803429:	77 0f                	ja     80343a <__umoddi3+0x122>
  80342b:	89 f2                	mov    %esi,%edx
  80342d:	29 f9                	sub    %edi,%ecx
  80342f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  803433:	89 14 24             	mov    %edx,(%esp)
  803436:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80343a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80343e:	8b 14 24             	mov    (%esp),%edx
  803441:	83 c4 1c             	add    $0x1c,%esp
  803444:	5b                   	pop    %ebx
  803445:	5e                   	pop    %esi
  803446:	5f                   	pop    %edi
  803447:	5d                   	pop    %ebp
  803448:	c3                   	ret    
  803449:	8d 76 00             	lea    0x0(%esi),%esi
  80344c:	2b 04 24             	sub    (%esp),%eax
  80344f:	19 fa                	sbb    %edi,%edx
  803451:	89 d1                	mov    %edx,%ecx
  803453:	89 c6                	mov    %eax,%esi
  803455:	e9 71 ff ff ff       	jmp    8033cb <__umoddi3+0xb3>
  80345a:	66 90                	xchg   %ax,%ax
  80345c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  803460:	72 ea                	jb     80344c <__umoddi3+0x134>
  803462:	89 d9                	mov    %ebx,%ecx
  803464:	e9 62 ff ff ff       	jmp    8033cb <__umoddi3+0xb3>
