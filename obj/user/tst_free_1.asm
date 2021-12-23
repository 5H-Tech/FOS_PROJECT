
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
  800031:	e8 95 16 00 00       	call   8016cb <libmain>
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
  80005b:	e8 52 1a 00 00       	call   801ab2 <cprintf>
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
  80008b:	e8 80 17 00 00       	call   801810 <_panic>
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
  8000c0:	e8 5d 2c 00 00       	call   802d22 <sys_calculate_free_frames>
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
  8000f3:	e8 ad 2c 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  8000f8:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[0] = malloc(2 * Mega - kilo);
  8000fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000fe:	01 c0                	add    %eax,%eax
  800100:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800103:	83 ec 0c             	sub    $0xc,%esp
  800106:	50                   	push   %eax
  800107:	e8 30 27 00 00       	call   80283c <malloc>
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
  80013b:	e8 d0 16 00 00       	call   801810 <_panic>
					"Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512)
  800140:	e8 60 2c 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  800145:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800148:	3d 00 02 00 00       	cmp    $0x200,%eax
  80014d:	74 14                	je     800163 <_main+0x12b>
			panic("Extra or less pages are allocated in PageFile");
  80014f:	83 ec 04             	sub    $0x4,%esp
  800152:	68 28 35 80 00       	push   $0x803528
  800157:	6a 3e                	push   $0x3e
  800159:	68 ab 34 80 00       	push   $0x8034ab
  80015e:	e8 ad 16 00 00       	call   801810 <_panic>
		int freeFrames = sys_calculate_free_frames();
  800163:	e8 ba 2b 00 00       	call   802d22 <sys_calculate_free_frames>
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
  800198:	e8 85 2b 00 00       	call   802d22 <sys_calculate_free_frames>
  80019d:	29 c3                	sub    %eax,%ebx
  80019f:	89 d8                	mov    %ebx,%eax
  8001a1:	83 f8 03             	cmp    $0x3,%eax
  8001a4:	74 14                	je     8001ba <_main+0x182>
			panic(
  8001a6:	83 ec 04             	sub    $0x4,%esp
  8001a9:	68 58 35 80 00       	push   $0x803558
  8001ae:	6a 47                	push   $0x47
  8001b0:	68 ab 34 80 00       	push   $0x8034ab
  8001b5:	e8 56 16 00 00       	call   801810 <_panic>
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
  800268:	e8 a3 15 00 00       	call   801810 <_panic>

		//2 MB
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80026d:	e8 33 2b 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  800272:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[1] = malloc(2 * Mega - kilo);
  800275:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800278:	01 c0                	add    %eax,%eax
  80027a:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80027d:	83 ec 0c             	sub    $0xc,%esp
  800280:	50                   	push   %eax
  800281:	e8 b6 25 00 00       	call   80283c <malloc>
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
  8002ca:	e8 41 15 00 00       	call   801810 <_panic>
					"Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512)
  8002cf:	e8 d1 2a 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  8002d4:	2b 45 c0             	sub    -0x40(%ebp),%eax
  8002d7:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002dc:	74 14                	je     8002f2 <_main+0x2ba>
			panic("Extra or less pages are allocated in PageFile");
  8002de:	83 ec 04             	sub    $0x4,%esp
  8002e1:	68 28 35 80 00       	push   $0x803528
  8002e6:	6a 60                	push   $0x60
  8002e8:	68 ab 34 80 00       	push   $0x8034ab
  8002ed:	e8 1e 15 00 00       	call   801810 <_panic>
		freeFrames = sys_calculate_free_frames();
  8002f2:	e8 2b 2a 00 00       	call   802d22 <sys_calculate_free_frames>
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
  800330:	e8 ed 29 00 00       	call   802d22 <sys_calculate_free_frames>
  800335:	29 c3                	sub    %eax,%ebx
  800337:	89 d8                	mov    %ebx,%eax
  800339:	83 f8 02             	cmp    $0x2,%eax
  80033c:	74 14                	je     800352 <_main+0x31a>
			panic(
  80033e:	83 ec 04             	sub    $0x4,%esp
  800341:	68 58 35 80 00       	push   $0x803558
  800346:	6a 68                	push   $0x68
  800348:	68 ab 34 80 00       	push   $0x8034ab
  80034d:	e8 be 14 00 00       	call   801810 <_panic>
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
  800404:	e8 07 14 00 00       	call   801810 <_panic>

		//3 KB
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800409:	e8 97 29 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  80040e:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[2] = malloc(3 * kilo);
  800411:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800414:	89 c2                	mov    %eax,%edx
  800416:	01 d2                	add    %edx,%edx
  800418:	01 d0                	add    %edx,%eax
  80041a:	83 ec 0c             	sub    $0xc,%esp
  80041d:	50                   	push   %eax
  80041e:	e8 19 24 00 00       	call   80283c <malloc>
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
  800469:	e8 a2 13 00 00       	call   801810 <_panic>
					"Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1)
  80046e:	e8 32 29 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  800473:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800476:	83 f8 01             	cmp    $0x1,%eax
  800479:	74 14                	je     80048f <_main+0x457>
			panic("Extra or less pages are allocated in PageFile");
  80047b:	83 ec 04             	sub    $0x4,%esp
  80047e:	68 28 35 80 00       	push   $0x803528
  800483:	6a 7e                	push   $0x7e
  800485:	68 ab 34 80 00       	push   $0x8034ab
  80048a:	e8 81 13 00 00       	call   801810 <_panic>
		freeFrames = sys_calculate_free_frames();
  80048f:	e8 8e 28 00 00       	call   802d22 <sys_calculate_free_frames>
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
  8004cf:	e8 4e 28 00 00       	call   802d22 <sys_calculate_free_frames>
  8004d4:	29 c3                	sub    %eax,%ebx
  8004d6:	89 d8                	mov    %ebx,%eax
  8004d8:	83 f8 02             	cmp    $0x2,%eax
  8004db:	74 17                	je     8004f4 <_main+0x4bc>
			panic(
  8004dd:	83 ec 04             	sub    $0x4,%esp
  8004e0:	68 58 35 80 00       	push   $0x803558
  8004e5:	68 86 00 00 00       	push   $0x86
  8004ea:	68 ab 34 80 00       	push   $0x8034ab
  8004ef:	e8 1c 13 00 00       	call   801810 <_panic>
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
  8005c1:	e8 4a 12 00 00       	call   801810 <_panic>

		//3 KB
		freeFrames = sys_calculate_free_frames();
  8005c6:	e8 57 27 00 00       	call   802d22 <sys_calculate_free_frames>
  8005cb:	89 45 bc             	mov    %eax,-0x44(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8005ce:	e8 d2 27 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  8005d3:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[3] = malloc(3 * kilo);
  8005d6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005d9:	89 c2                	mov    %eax,%edx
  8005db:	01 d2                	add    %edx,%edx
  8005dd:	01 d0                	add    %edx,%eax
  8005df:	83 ec 0c             	sub    $0xc,%esp
  8005e2:	50                   	push   %eax
  8005e3:	e8 54 22 00 00       	call   80283c <malloc>
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
  800645:	e8 c6 11 00 00       	call   801810 <_panic>
					"Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1)
  80064a:	e8 56 27 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  80064f:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800652:	83 f8 01             	cmp    $0x1,%eax
  800655:	74 17                	je     80066e <_main+0x636>
			panic("Extra or less pages are allocated in PageFile");
  800657:	83 ec 04             	sub    $0x4,%esp
  80065a:	68 28 35 80 00       	push   $0x803528
  80065f:	68 9e 00 00 00       	push   $0x9e
  800664:	68 ab 34 80 00       	push   $0x8034ab
  800669:	e8 a2 11 00 00       	call   801810 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80066e:	e8 32 27 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
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
  800687:	e8 b0 21 00 00       	call   80283c <malloc>
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
  8006e9:	e8 22 11 00 00       	call   801810 <_panic>
					"Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2)
  8006ee:	e8 b2 26 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  8006f3:	2b 45 c0             	sub    -0x40(%ebp),%eax
  8006f6:	83 f8 02             	cmp    $0x2,%eax
  8006f9:	74 17                	je     800712 <_main+0x6da>
			panic("Extra or less pages are allocated in PageFile");
  8006fb:	83 ec 04             	sub    $0x4,%esp
  8006fe:	68 28 35 80 00       	push   $0x803528
  800703:	68 ab 00 00 00       	push   $0xab
  800708:	68 ab 34 80 00       	push   $0x8034ab
  80070d:	e8 fe 10 00 00       	call   801810 <_panic>
		freeFrames = sys_calculate_free_frames();
  800712:	e8 0b 26 00 00       	call   802d22 <sys_calculate_free_frames>
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
  8007b6:	e8 67 25 00 00       	call   802d22 <sys_calculate_free_frames>
  8007bb:	29 c3                	sub    %eax,%ebx
  8007bd:	89 d8                	mov    %ebx,%eax
  8007bf:	83 f8 02             	cmp    $0x2,%eax
  8007c2:	74 17                	je     8007db <_main+0x7a3>
			panic(
  8007c4:	83 ec 04             	sub    $0x4,%esp
  8007c7:	68 58 35 80 00       	push   $0x803558
  8007cc:	68 b7 00 00 00       	push   $0xb7
  8007d1:	68 ab 34 80 00       	push   $0x8034ab
  8007d6:	e8 35 10 00 00       	call   801810 <_panic>
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
  8008b7:	e8 54 0f 00 00       	call   801810 <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames();
  8008bc:	e8 61 24 00 00       	call   802d22 <sys_calculate_free_frames>
  8008c1:	89 45 bc             	mov    %eax,-0x44(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8008c4:	e8 dc 24 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  8008c9:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[5] = malloc(3 * Mega - kilo);
  8008cc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008cf:	89 c2                	mov    %eax,%edx
  8008d1:	01 d2                	add    %edx,%edx
  8008d3:	01 d0                	add    %edx,%eax
  8008d5:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8008d8:	83 ec 0c             	sub    $0xc,%esp
  8008db:	50                   	push   %eax
  8008dc:	e8 5b 1f 00 00       	call   80283c <malloc>
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
  80093e:	e8 cd 0e 00 00       	call   801810 <_panic>
					"Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages)
  800943:	e8 5d 24 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
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
  800978:	e8 93 0e 00 00       	call   801810 <_panic>

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
  8009a7:	e8 f9 23 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
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
  8009c1:	e8 76 1e 00 00       	call   80283c <malloc>
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
  800a31:	e8 da 0d 00 00       	call   801810 <_panic>
					"Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages)
  800a36:	e8 6a 23 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
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
  800a6d:	e8 9e 0d 00 00       	call   801810 <_panic>
		freeFrames = sys_calculate_free_frames();
  800a72:	e8 ab 22 00 00       	call   802d22 <sys_calculate_free_frames>
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
  800ae3:	e8 3a 22 00 00       	call   802d22 <sys_calculate_free_frames>
  800ae8:	29 c3                	sub    %eax,%ebx
  800aea:	89 d8                	mov    %ebx,%eax
  800aec:	83 f8 05             	cmp    $0x5,%eax
  800aef:	74 17                	je     800b08 <_main+0xad0>
			panic(
  800af1:	83 ec 04             	sub    $0x4,%esp
  800af4:	68 58 35 80 00       	push   $0x803558
  800af9:	68 ef 00 00 00       	push   $0xef
  800afe:	68 ab 34 80 00       	push   $0x8034ab
  800b03:	e8 08 0d 00 00       	call   801810 <_panic>
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
  800c36:	e8 d5 0b 00 00       	call   801810 <_panic>

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800c3b:	e8 65 21 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
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
  800c56:	e8 e1 1b 00 00       	call   80283c <malloc>
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
  800cc8:	e8 43 0b 00 00       	call   801810 <_panic>
					"Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4)
  800ccd:	e8 d3 20 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  800cd2:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800cd5:	83 f8 04             	cmp    $0x4,%eax
  800cd8:	74 17                	je     800cf1 <_main+0xcb9>
			panic("Extra or less pages are allocated in PageFile");
  800cda:	83 ec 04             	sub    $0x4,%esp
  800cdd:	68 28 35 80 00       	push   $0x803528
  800ce2:	68 09 01 00 00       	push   $0x109
  800ce7:	68 ab 34 80 00       	push   $0x8034ab
  800cec:	e8 1f 0b 00 00       	call   801810 <_panic>
		freeFrames = sys_calculate_free_frames();
  800cf1:	e8 2c 20 00 00       	call   802d22 <sys_calculate_free_frames>
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
  800d45:	e8 d8 1f 00 00       	call   802d22 <sys_calculate_free_frames>
  800d4a:	29 c3                	sub    %eax,%ebx
  800d4c:	89 d8                	mov    %ebx,%eax
  800d4e:	83 f8 02             	cmp    $0x2,%eax
  800d51:	74 17                	je     800d6a <_main+0xd32>
			panic(
  800d53:	83 ec 04             	sub    $0x4,%esp
  800d56:	68 58 35 80 00       	push   $0x803558
  800d5b:	68 11 01 00 00       	push   $0x111
  800d60:	68 ab 34 80 00       	push   $0x8034ab
  800d65:	e8 a6 0a 00 00       	call   801810 <_panic>
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
  800e43:	e8 c8 09 00 00       	call   801810 <_panic>
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
  800e5c:	e8 c1 1e 00 00       	call   802d22 <sys_calculate_free_frames>
  800e61:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages();
  800e67:	e8 39 1f 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  800e6c:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[6]);
  800e72:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  800e78:	83 ec 0c             	sub    $0xc,%esp
  800e7b:	50                   	push   %eax
  800e7c:	e8 cb 1b 00 00       	call   802a4c <free>
  800e81:	83 c4 10             	add    $0x10,%esp
		cprintf("i Expect %d and found %d \n ------------\n", 6 * Mega / 4096,(usedDiskPages - sys_pf_calculate_allocated_pages()));
  800e84:	e8 1c 1f 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
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
  800eb4:	e8 f9 0b 00 00       	call   801ab2 <cprintf>
  800eb9:	83 c4 10             	add    $0x10,%esp

		if ((usedDiskPages - sys_pf_calculate_allocated_pages())!= 6 * Mega / 4096)
  800ebc:	e8 e4 1e 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
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
  800ef8:	e8 13 09 00 00       	call   801810 <_panic>
		cprintf("i Expetct %d and found %d \n ------------\n", 3 + 1,
				(sys_calculate_free_frames() - freeFrames));
  800efd:	e8 20 1e 00 00       	call   802d22 <sys_calculate_free_frames>
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
  800f19:	e8 94 0b 00 00       	call   801ab2 <cprintf>
  800f1e:	83 c4 10             	add    $0x10,%esp
				(sys_calculate_free_frames() - freeFrames));
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 1)
  800f21:	e8 fc 1d 00 00       	call   802d22 <sys_calculate_free_frames>
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
  800f49:	e8 c2 08 00 00       	call   801810 <_panic>
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
  800f99:	e8 58 22 00 00       	call   8031f6 <sys_check_LRU_lists_free>
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
  800fc2:	e8 49 08 00 00       	call   801810 <_panic>
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
  800ffb:	e8 10 08 00 00       	call   801810 <_panic>
		}

		//Free 1st 2 MB
		freeFrames = sys_calculate_free_frames();
  801000:	e8 1d 1d 00 00       	call   802d22 <sys_calculate_free_frames>
  801005:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80100b:	e8 95 1d 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  801010:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[0]);
  801016:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  80101c:	83 ec 0c             	sub    $0xc,%esp
  80101f:	50                   	push   %eax
  801020:	e8 27 1a 00 00       	call   802a4c <free>
  801025:	83 c4 10             	add    $0x10,%esp
		cprintf("expict %d found %d\n",512,(usedDiskPages - sys_pf_calculate_allocated_pages()));
  801028:	e8 78 1d 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  80102d:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801033:	29 c2                	sub    %eax,%edx
  801035:	89 d0                	mov    %edx,%eax
  801037:	83 ec 04             	sub    $0x4,%esp
  80103a:	50                   	push   %eax
  80103b:	68 00 02 00 00       	push   $0x200
  801040:	68 e9 36 80 00       	push   $0x8036e9
  801045:	e8 68 0a 00 00       	call   801ab2 <cprintf>
  80104a:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512)
  80104d:	e8 53 1d 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
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
  801075:	e8 96 07 00 00       	call   801810 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2)
  80107a:	e8 a3 1c 00 00       	call   802d22 <sys_calculate_free_frames>
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
  8010a2:	e8 69 07 00 00       	call   801810 <_panic>
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
  8010ca:	e8 27 21 00 00       	call   8031f6 <sys_check_LRU_lists_free>
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
  8010f3:	e8 18 07 00 00       	call   801810 <_panic>
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
  80112b:	e8 e0 06 00 00       	call   801810 <_panic>
		}

		//Free 2nd 2 MB
		freeFrames = sys_calculate_free_frames();
  801130:	e8 ed 1b 00 00       	call   802d22 <sys_calculate_free_frames>
  801135:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80113b:	e8 65 1c 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  801140:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[1]);
  801146:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  80114c:	83 ec 0c             	sub    $0xc,%esp
  80114f:	50                   	push   %eax
  801150:	e8 f7 18 00 00       	call   802a4c <free>
  801155:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512)
  801158:	e8 48 1c 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
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
  801180:	e8 8b 06 00 00       	call   801810 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1)
  801185:	e8 98 1b 00 00       	call   802d22 <sys_calculate_free_frames>
  80118a:	89 c2                	mov    %eax,%edx
  80118c:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801192:	29 c2                	sub    %eax,%edx
  801194:	89 d0                	mov    %edx,%eax
  801196:	83 f8 03             	cmp    $0x3,%eax
  801199:	74 17                	je     8011b2 <_main+0x117a>
			panic(
  80119b:	83 ec 04             	sub    $0x4,%esp
  80119e:	68 50 36 80 00       	push   $0x803650
  8011a3:	68 6a 01 00 00       	push   $0x16a
  8011a8:	68 ab 34 80 00       	push   $0x8034ab
  8011ad:	e8 5e 06 00 00       	call   801810 <_panic>
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}
		tmp_addresses[0] = (uint32) (&(shortArr[0]));
  8011b2:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8011b5:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32) (&(shortArr[lastIndexOfShort]));
  8011bb:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8011be:	01 c0                	add    %eax,%eax
  8011c0:	89 c2                	mov    %eax,%edx
  8011c2:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8011c5:	01 d0                	add    %edx,%eax
  8011c7:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  8011cd:	83 ec 08             	sub    $0x8,%esp
  8011d0:	6a 02                	push   $0x2
  8011d2:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  8011d8:	50                   	push   %eax
  8011d9:	e8 18 20 00 00       	call   8031f6 <sys_check_LRU_lists_free>
  8011de:	83 c4 10             	add    $0x10,%esp
  8011e1:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if (check != 0) {
  8011e7:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  8011ee:	74 17                	je     801207 <_main+0x11cf>
			panic("free: page is not removed from LRU lists");
  8011f0:	83 ec 04             	sub    $0x4,%esp
  8011f3:	68 9c 36 80 00       	push   $0x80369c
  8011f8:	68 76 01 00 00       	push   $0x176
  8011fd:	68 ab 34 80 00       	push   $0x8034ab
  801202:	e8 09 06 00 00       	call   801810 <_panic>
		}

		if (LIST_SIZE(&myEnv->ActiveList) != 797
  801207:	a1 20 40 80 00       	mov    0x804020,%eax
  80120c:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  801212:	3d 1d 03 00 00       	cmp    $0x31d,%eax
  801217:	74 26                	je     80123f <_main+0x1207>
				&& LIST_SIZE(&myEnv->SecondList) != 0) {
  801219:	a1 20 40 80 00       	mov    0x804020,%eax
  80121e:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  801224:	85 c0                	test   %eax,%eax
  801226:	74 17                	je     80123f <_main+0x1207>
			panic("LRU lists content is not correct");
  801228:	83 ec 04             	sub    $0x4,%esp
  80122b:	68 c8 36 80 00       	push   $0x8036c8
  801230:	68 7b 01 00 00       	push   $0x17b
  801235:	68 ab 34 80 00       	push   $0x8034ab
  80123a:	e8 d1 05 00 00       	call   801810 <_panic>
		}

		//Free 7 KB
		freeFrames = sys_calculate_free_frames();
  80123f:	e8 de 1a 00 00       	call   802d22 <sys_calculate_free_frames>
  801244:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80124a:	e8 56 1b 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  80124f:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[4]);
  801255:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  80125b:	83 ec 0c             	sub    $0xc,%esp
  80125e:	50                   	push   %eax
  80125f:	e8 e8 17 00 00       	call   802a4c <free>
  801264:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2)
  801267:	e8 39 1b 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  80126c:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801272:	29 c2                	sub    %eax,%edx
  801274:	89 d0                	mov    %edx,%eax
  801276:	83 f8 02             	cmp    $0x2,%eax
  801279:	74 17                	je     801292 <_main+0x125a>
			panic("Wrong free: Extra or less pages are removed from PageFile");
  80127b:	83 ec 04             	sub    $0x4,%esp
  80127e:	68 e8 35 80 00       	push   $0x8035e8
  801283:	68 83 01 00 00       	push   $0x183
  801288:	68 ab 34 80 00       	push   $0x8034ab
  80128d:	e8 7e 05 00 00       	call   801810 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2)
  801292:	e8 8b 1a 00 00       	call   802d22 <sys_calculate_free_frames>
  801297:	89 c2                	mov    %eax,%edx
  801299:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  80129f:	29 c2                	sub    %eax,%edx
  8012a1:	89 d0                	mov    %edx,%eax
  8012a3:	83 f8 02             	cmp    $0x2,%eax
  8012a6:	74 17                	je     8012bf <_main+0x1287>
			panic(
  8012a8:	83 ec 04             	sub    $0x4,%esp
  8012ab:	68 50 36 80 00       	push   $0x803650
  8012b0:	68 86 01 00 00       	push   $0x186
  8012b5:	68 ab 34 80 00       	push   $0x8034ab
  8012ba:	e8 51 05 00 00       	call   801810 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32) (&(structArr[0]));
  8012bf:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8012c5:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32) (&(structArr[lastIndexOfStruct]));
  8012cb:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  8012d1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8012d8:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8012de:	01 d0                	add    %edx,%eax
  8012e0:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  8012e6:	83 ec 08             	sub    $0x8,%esp
  8012e9:	6a 02                	push   $0x2
  8012eb:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  8012f1:	50                   	push   %eax
  8012f2:	e8 ff 1e 00 00       	call   8031f6 <sys_check_LRU_lists_free>
  8012f7:	83 c4 10             	add    $0x10,%esp
  8012fa:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if (check != 0) {
  801300:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  801307:	74 17                	je     801320 <_main+0x12e8>
			panic("free: page is not removed from LRU lists");
  801309:	83 ec 04             	sub    $0x4,%esp
  80130c:	68 9c 36 80 00       	push   $0x80369c
  801311:	68 93 01 00 00       	push   $0x193
  801316:	68 ab 34 80 00       	push   $0x8034ab
  80131b:	e8 f0 04 00 00       	call   801810 <_panic>
		}

		if (LIST_SIZE(&myEnv->ActiveList) != 795
  801320:	a1 20 40 80 00       	mov    0x804020,%eax
  801325:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  80132b:	3d 1b 03 00 00       	cmp    $0x31b,%eax
  801330:	74 26                	je     801358 <_main+0x1320>
				&& LIST_SIZE(&myEnv->SecondList) != 0) {
  801332:	a1 20 40 80 00       	mov    0x804020,%eax
  801337:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  80133d:	85 c0                	test   %eax,%eax
  80133f:	74 17                	je     801358 <_main+0x1320>
			panic("LRU lists content is not correct");
  801341:	83 ec 04             	sub    $0x4,%esp
  801344:	68 c8 36 80 00       	push   $0x8036c8
  801349:	68 98 01 00 00       	push   $0x198
  80134e:	68 ab 34 80 00       	push   $0x8034ab
  801353:	e8 b8 04 00 00       	call   801810 <_panic>
		}

		//Free 3 MB
		freeFrames = sys_calculate_free_frames();
  801358:	e8 c5 19 00 00       	call   802d22 <sys_calculate_free_frames>
  80135d:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  801363:	e8 3d 1a 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  801368:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[5]);
  80136e:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  801374:	83 ec 0c             	sub    $0xc,%esp
  801377:	50                   	push   %eax
  801378:	e8 cf 16 00 00       	call   802a4c <free>
  80137d:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages())
  801380:	e8 20 1a 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  801385:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  80138b:	89 d1                	mov    %edx,%ecx
  80138d:	29 c1                	sub    %eax,%ecx
				!= 3 * Mega / 4096)
  80138f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801392:	89 c2                	mov    %eax,%edx
  801394:	01 d2                	add    %edx,%edx
  801396:	01 d0                	add    %edx,%eax
  801398:	85 c0                	test   %eax,%eax
  80139a:	79 05                	jns    8013a1 <_main+0x1369>
  80139c:	05 ff 0f 00 00       	add    $0xfff,%eax
  8013a1:	c1 f8 0c             	sar    $0xc,%eax

		//Free 3 MB
		freeFrames = sys_calculate_free_frames();
		usedDiskPages = sys_pf_calculate_allocated_pages();
		free(ptr_allocations[5]);
		if ((usedDiskPages - sys_pf_calculate_allocated_pages())
  8013a4:	39 c1                	cmp    %eax,%ecx
  8013a6:	74 17                	je     8013bf <_main+0x1387>
				!= 3 * Mega / 4096)
			panic("Wrong free: Extra or less pages are removed from PageFile");
  8013a8:	83 ec 04             	sub    $0x4,%esp
  8013ab:	68 e8 35 80 00       	push   $0x8035e8
  8013b0:	68 a1 01 00 00       	push   $0x1a1
  8013b5:	68 ab 34 80 00       	push   $0x8034ab
  8013ba:	e8 51 04 00 00       	call   801810 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != toAccess)
  8013bf:	e8 5e 19 00 00       	call   802d22 <sys_calculate_free_frames>
  8013c4:	89 c2                	mov    %eax,%edx
  8013c6:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  8013cc:	29 c2                	sub    %eax,%edx
  8013ce:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8013d1:	39 c2                	cmp    %eax,%edx
  8013d3:	74 17                	je     8013ec <_main+0x13b4>
			panic(
  8013d5:	83 ec 04             	sub    $0x4,%esp
  8013d8:	68 50 36 80 00       	push   $0x803650
  8013dd:	68 a4 01 00 00       	push   $0x1a4
  8013e2:	68 ab 34 80 00       	push   $0x8034ab
  8013e7:	e8 24 04 00 00       	call   801810 <_panic>
					"Wrong free: WS pages in memory and/or page tables are not freed correctly");

		//Free 1st 3 KB
		freeFrames = sys_calculate_free_frames();
  8013ec:	e8 31 19 00 00       	call   802d22 <sys_calculate_free_frames>
  8013f1:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8013f7:	e8 a9 19 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  8013fc:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[2]);
  801402:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  801408:	83 ec 0c             	sub    $0xc,%esp
  80140b:	50                   	push   %eax
  80140c:	e8 3b 16 00 00       	call   802a4c <free>
  801411:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1)
  801414:	e8 8c 19 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  801419:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  80141f:	29 c2                	sub    %eax,%edx
  801421:	89 d0                	mov    %edx,%eax
  801423:	83 f8 01             	cmp    $0x1,%eax
  801426:	74 17                	je     80143f <_main+0x1407>
			panic("Wrong free: Extra or less pages are removed from PageFile");
  801428:	83 ec 04             	sub    $0x4,%esp
  80142b:	68 e8 35 80 00       	push   $0x8035e8
  801430:	68 ab 01 00 00       	push   $0x1ab
  801435:	68 ab 34 80 00       	push   $0x8034ab
  80143a:	e8 d1 03 00 00       	call   801810 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 1 + 1)
  80143f:	e8 de 18 00 00       	call   802d22 <sys_calculate_free_frames>
  801444:	89 c2                	mov    %eax,%edx
  801446:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  80144c:	29 c2                	sub    %eax,%edx
  80144e:	89 d0                	mov    %edx,%eax
  801450:	83 f8 02             	cmp    $0x2,%eax
  801453:	74 17                	je     80146c <_main+0x1434>
			panic(
  801455:	83 ec 04             	sub    $0x4,%esp
  801458:	68 50 36 80 00       	push   $0x803650
  80145d:	68 ae 01 00 00       	push   $0x1ae
  801462:	68 ab 34 80 00       	push   $0x8034ab
  801467:	e8 a4 03 00 00       	call   801810 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32) (&(intArr[0]));
  80146c:	8b 45 88             	mov    -0x78(%ebp),%eax
  80146f:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32) (&(intArr[lastIndexOfInt]));
  801475:	8b 45 84             	mov    -0x7c(%ebp),%eax
  801478:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80147f:	8b 45 88             	mov    -0x78(%ebp),%eax
  801482:	01 d0                	add    %edx,%eax
  801484:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  80148a:	83 ec 08             	sub    $0x8,%esp
  80148d:	6a 02                	push   $0x2
  80148f:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  801495:	50                   	push   %eax
  801496:	e8 5b 1d 00 00       	call   8031f6 <sys_check_LRU_lists_free>
  80149b:	83 c4 10             	add    $0x10,%esp
  80149e:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if (check != 0) {
  8014a4:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  8014ab:	74 17                	je     8014c4 <_main+0x148c>
			panic("free: page is not removed from LRU lists");
  8014ad:	83 ec 04             	sub    $0x4,%esp
  8014b0:	68 9c 36 80 00       	push   $0x80369c
  8014b5:	68 bb 01 00 00       	push   $0x1bb
  8014ba:	68 ab 34 80 00       	push   $0x8034ab
  8014bf:	e8 4c 03 00 00       	call   801810 <_panic>
		}

		if (LIST_SIZE(&myEnv->ActiveList) != 794
  8014c4:	a1 20 40 80 00       	mov    0x804020,%eax
  8014c9:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  8014cf:	3d 1a 03 00 00       	cmp    $0x31a,%eax
  8014d4:	74 26                	je     8014fc <_main+0x14c4>
				&& LIST_SIZE(&myEnv->SecondList) != 0) {
  8014d6:	a1 20 40 80 00       	mov    0x804020,%eax
  8014db:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  8014e1:	85 c0                	test   %eax,%eax
  8014e3:	74 17                	je     8014fc <_main+0x14c4>
			panic("LRU lists content is not correct");
  8014e5:	83 ec 04             	sub    $0x4,%esp
  8014e8:	68 c8 36 80 00       	push   $0x8036c8
  8014ed:	68 c0 01 00 00       	push   $0x1c0
  8014f2:	68 ab 34 80 00       	push   $0x8034ab
  8014f7:	e8 14 03 00 00       	call   801810 <_panic>
		}

		//Free 2nd 3 KB
		freeFrames = sys_calculate_free_frames();
  8014fc:	e8 21 18 00 00       	call   802d22 <sys_calculate_free_frames>
  801501:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  801507:	e8 99 18 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  80150c:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[3]);
  801512:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  801518:	83 ec 0c             	sub    $0xc,%esp
  80151b:	50                   	push   %eax
  80151c:	e8 2b 15 00 00       	call   802a4c <free>
  801521:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1)
  801524:	e8 7c 18 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  801529:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  80152f:	29 c2                	sub    %eax,%edx
  801531:	89 d0                	mov    %edx,%eax
  801533:	83 f8 01             	cmp    $0x1,%eax
  801536:	74 17                	je     80154f <_main+0x1517>
			panic("Wrong free: Extra or less pages are removed from PageFile");
  801538:	83 ec 04             	sub    $0x4,%esp
  80153b:	68 e8 35 80 00       	push   $0x8035e8
  801540:	68 c8 01 00 00       	push   $0x1c8
  801545:	68 ab 34 80 00       	push   $0x8034ab
  80154a:	e8 c1 02 00 00       	call   801810 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0)
  80154f:	e8 ce 17 00 00       	call   802d22 <sys_calculate_free_frames>
  801554:	89 c2                	mov    %eax,%edx
  801556:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  80155c:	39 c2                	cmp    %eax,%edx
  80155e:	74 17                	je     801577 <_main+0x153f>
			panic(
  801560:	83 ec 04             	sub    $0x4,%esp
  801563:	68 50 36 80 00       	push   $0x803650
  801568:	68 cb 01 00 00       	push   $0x1cb
  80156d:	68 ab 34 80 00       	push   $0x8034ab
  801572:	e8 99 02 00 00       	call   801810 <_panic>
					"Wrong free: WS pages in memory and/or page tables are not freed correctly");

		//Free last 14 KB
		freeFrames = sys_calculate_free_frames();
  801577:	e8 a6 17 00 00       	call   802d22 <sys_calculate_free_frames>
  80157c:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  801582:	e8 1e 18 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  801587:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[7]);
  80158d:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  801593:	83 ec 0c             	sub    $0xc,%esp
  801596:	50                   	push   %eax
  801597:	e8 b0 14 00 00       	call   802a4c <free>
  80159c:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 4)
  80159f:	e8 01 18 00 00       	call   802da5 <sys_pf_calculate_allocated_pages>
  8015a4:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  8015aa:	29 c2                	sub    %eax,%edx
  8015ac:	89 d0                	mov    %edx,%eax
  8015ae:	83 f8 04             	cmp    $0x4,%eax
  8015b1:	74 17                	je     8015ca <_main+0x1592>
			panic("Wrong free: Extra or less pages are removed from PageFile");
  8015b3:	83 ec 04             	sub    $0x4,%esp
  8015b6:	68 e8 35 80 00       	push   $0x8035e8
  8015bb:	68 d2 01 00 00       	push   $0x1d2
  8015c0:	68 ab 34 80 00       	push   $0x8034ab
  8015c5:	e8 46 02 00 00       	call   801810 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1)
  8015ca:	e8 53 17 00 00       	call   802d22 <sys_calculate_free_frames>
  8015cf:	89 c2                	mov    %eax,%edx
  8015d1:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  8015d7:	29 c2                	sub    %eax,%edx
  8015d9:	89 d0                	mov    %edx,%eax
  8015db:	83 f8 03             	cmp    $0x3,%eax
  8015de:	74 17                	je     8015f7 <_main+0x15bf>
			panic(
  8015e0:	83 ec 04             	sub    $0x4,%esp
  8015e3:	68 50 36 80 00       	push   $0x803650
  8015e8:	68 d5 01 00 00       	push   $0x1d5
  8015ed:	68 ab 34 80 00       	push   $0x8034ab
  8015f2:	e8 19 02 00 00       	call   801810 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32) (&(shortArr2[0]));
  8015f7:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  8015fd:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32) (&(shortArr2[lastIndexOfShort2]));
  801603:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  801609:	01 c0                	add    %eax,%eax
  80160b:	89 c2                	mov    %eax,%edx
  80160d:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  801613:	01 d0                	add    %edx,%eax
  801615:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  80161b:	83 ec 08             	sub    $0x8,%esp
  80161e:	6a 02                	push   $0x2
  801620:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  801626:	50                   	push   %eax
  801627:	e8 ca 1b 00 00       	call   8031f6 <sys_check_LRU_lists_free>
  80162c:	83 c4 10             	add    $0x10,%esp
  80162f:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if (check != 0) {
  801635:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  80163c:	74 17                	je     801655 <_main+0x161d>
			panic("free: page is not removed from LRU lists");
  80163e:	83 ec 04             	sub    $0x4,%esp
  801641:	68 9c 36 80 00       	push   $0x80369c
  801646:	68 e2 01 00 00       	push   $0x1e2
  80164b:	68 ab 34 80 00       	push   $0x8034ab
  801650:	e8 bb 01 00 00       	call   801810 <_panic>
		}

		if (LIST_SIZE(&myEnv->ActiveList) != 792
  801655:	a1 20 40 80 00       	mov    0x804020,%eax
  80165a:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  801660:	3d 18 03 00 00       	cmp    $0x318,%eax
  801665:	74 26                	je     80168d <_main+0x1655>
				&& LIST_SIZE(&myEnv->SecondList) != 0) {
  801667:	a1 20 40 80 00       	mov    0x804020,%eax
  80166c:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  801672:	85 c0                	test   %eax,%eax
  801674:	74 17                	je     80168d <_main+0x1655>
			panic("LRU lists content is not correct");
  801676:	83 ec 04             	sub    $0x4,%esp
  801679:	68 c8 36 80 00       	push   $0x8036c8
  80167e:	68 e7 01 00 00       	push   $0x1e7
  801683:	68 ab 34 80 00       	push   $0x8034ab
  801688:	e8 83 01 00 00       	call   801810 <_panic>
		}

		if (start_freeFrames != (sys_calculate_free_frames() + 4)) {
  80168d:	e8 90 16 00 00       	call   802d22 <sys_calculate_free_frames>
  801692:	8d 50 04             	lea    0x4(%eax),%edx
  801695:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801698:	39 c2                	cmp    %eax,%edx
  80169a:	74 17                	je     8016b3 <_main+0x167b>
			panic("Wrong free: not all pages removed correctly at end");
  80169c:	83 ec 04             	sub    $0x4,%esp
  80169f:	68 00 37 80 00       	push   $0x803700
  8016a4:	68 eb 01 00 00       	push   $0x1eb
  8016a9:	68 ab 34 80 00       	push   $0x8034ab
  8016ae:	e8 5d 01 00 00       	call   801810 <_panic>
		}
	}

	cprintf("Congratulations!! test free [1] completed successfully.\n");
  8016b3:	83 ec 0c             	sub    $0xc,%esp
  8016b6:	68 34 37 80 00       	push   $0x803734
  8016bb:	e8 f2 03 00 00       	call   801ab2 <cprintf>
  8016c0:	83 c4 10             	add    $0x10,%esp

	return;
  8016c3:	90                   	nop
}
  8016c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8016c7:	5b                   	pop    %ebx
  8016c8:	5f                   	pop    %edi
  8016c9:	5d                   	pop    %ebp
  8016ca:	c3                   	ret    

008016cb <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8016cb:	55                   	push   %ebp
  8016cc:	89 e5                	mov    %esp,%ebp
  8016ce:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8016d1:	e8 81 15 00 00       	call   802c57 <sys_getenvindex>
  8016d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8016d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016dc:	89 d0                	mov    %edx,%eax
  8016de:	c1 e0 03             	shl    $0x3,%eax
  8016e1:	01 d0                	add    %edx,%eax
  8016e3:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8016ea:	01 c8                	add    %ecx,%eax
  8016ec:	01 c0                	add    %eax,%eax
  8016ee:	01 d0                	add    %edx,%eax
  8016f0:	01 c0                	add    %eax,%eax
  8016f2:	01 d0                	add    %edx,%eax
  8016f4:	89 c2                	mov    %eax,%edx
  8016f6:	c1 e2 05             	shl    $0x5,%edx
  8016f9:	29 c2                	sub    %eax,%edx
  8016fb:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  801702:	89 c2                	mov    %eax,%edx
  801704:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80170a:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80170f:	a1 20 40 80 00       	mov    0x804020,%eax
  801714:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80171a:	84 c0                	test   %al,%al
  80171c:	74 0f                	je     80172d <libmain+0x62>
		binaryname = myEnv->prog_name;
  80171e:	a1 20 40 80 00       	mov    0x804020,%eax
  801723:	05 40 3c 01 00       	add    $0x13c40,%eax
  801728:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80172d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801731:	7e 0a                	jle    80173d <libmain+0x72>
		binaryname = argv[0];
  801733:	8b 45 0c             	mov    0xc(%ebp),%eax
  801736:	8b 00                	mov    (%eax),%eax
  801738:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  80173d:	83 ec 08             	sub    $0x8,%esp
  801740:	ff 75 0c             	pushl  0xc(%ebp)
  801743:	ff 75 08             	pushl  0x8(%ebp)
  801746:	e8 ed e8 ff ff       	call   800038 <_main>
  80174b:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80174e:	e8 9f 16 00 00       	call   802df2 <sys_disable_interrupt>
	cprintf("**************************************\n");
  801753:	83 ec 0c             	sub    $0xc,%esp
  801756:	68 88 37 80 00       	push   $0x803788
  80175b:	e8 52 03 00 00       	call   801ab2 <cprintf>
  801760:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  801763:	a1 20 40 80 00       	mov    0x804020,%eax
  801768:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80176e:	a1 20 40 80 00       	mov    0x804020,%eax
  801773:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  801779:	83 ec 04             	sub    $0x4,%esp
  80177c:	52                   	push   %edx
  80177d:	50                   	push   %eax
  80177e:	68 b0 37 80 00       	push   $0x8037b0
  801783:	e8 2a 03 00 00       	call   801ab2 <cprintf>
  801788:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80178b:	a1 20 40 80 00       	mov    0x804020,%eax
  801790:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  801796:	a1 20 40 80 00       	mov    0x804020,%eax
  80179b:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8017a1:	83 ec 04             	sub    $0x4,%esp
  8017a4:	52                   	push   %edx
  8017a5:	50                   	push   %eax
  8017a6:	68 d8 37 80 00       	push   $0x8037d8
  8017ab:	e8 02 03 00 00       	call   801ab2 <cprintf>
  8017b0:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8017b3:	a1 20 40 80 00       	mov    0x804020,%eax
  8017b8:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8017be:	83 ec 08             	sub    $0x8,%esp
  8017c1:	50                   	push   %eax
  8017c2:	68 19 38 80 00       	push   $0x803819
  8017c7:	e8 e6 02 00 00       	call   801ab2 <cprintf>
  8017cc:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8017cf:	83 ec 0c             	sub    $0xc,%esp
  8017d2:	68 88 37 80 00       	push   $0x803788
  8017d7:	e8 d6 02 00 00       	call   801ab2 <cprintf>
  8017dc:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8017df:	e8 28 16 00 00       	call   802e0c <sys_enable_interrupt>

	// exit gracefully
	exit();
  8017e4:	e8 19 00 00 00       	call   801802 <exit>
}
  8017e9:	90                   	nop
  8017ea:	c9                   	leave  
  8017eb:	c3                   	ret    

008017ec <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8017ec:	55                   	push   %ebp
  8017ed:	89 e5                	mov    %esp,%ebp
  8017ef:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8017f2:	83 ec 0c             	sub    $0xc,%esp
  8017f5:	6a 00                	push   $0x0
  8017f7:	e8 27 14 00 00       	call   802c23 <sys_env_destroy>
  8017fc:	83 c4 10             	add    $0x10,%esp
}
  8017ff:	90                   	nop
  801800:	c9                   	leave  
  801801:	c3                   	ret    

00801802 <exit>:

void
exit(void)
{
  801802:	55                   	push   %ebp
  801803:	89 e5                	mov    %esp,%ebp
  801805:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  801808:	e8 7c 14 00 00       	call   802c89 <sys_env_exit>
}
  80180d:	90                   	nop
  80180e:	c9                   	leave  
  80180f:	c3                   	ret    

00801810 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801810:	55                   	push   %ebp
  801811:	89 e5                	mov    %esp,%ebp
  801813:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801816:	8d 45 10             	lea    0x10(%ebp),%eax
  801819:	83 c0 04             	add    $0x4,%eax
  80181c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80181f:	a1 18 41 80 00       	mov    0x804118,%eax
  801824:	85 c0                	test   %eax,%eax
  801826:	74 16                	je     80183e <_panic+0x2e>
		cprintf("%s: ", argv0);
  801828:	a1 18 41 80 00       	mov    0x804118,%eax
  80182d:	83 ec 08             	sub    $0x8,%esp
  801830:	50                   	push   %eax
  801831:	68 30 38 80 00       	push   $0x803830
  801836:	e8 77 02 00 00       	call   801ab2 <cprintf>
  80183b:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80183e:	a1 00 40 80 00       	mov    0x804000,%eax
  801843:	ff 75 0c             	pushl  0xc(%ebp)
  801846:	ff 75 08             	pushl  0x8(%ebp)
  801849:	50                   	push   %eax
  80184a:	68 35 38 80 00       	push   $0x803835
  80184f:	e8 5e 02 00 00       	call   801ab2 <cprintf>
  801854:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801857:	8b 45 10             	mov    0x10(%ebp),%eax
  80185a:	83 ec 08             	sub    $0x8,%esp
  80185d:	ff 75 f4             	pushl  -0xc(%ebp)
  801860:	50                   	push   %eax
  801861:	e8 e1 01 00 00       	call   801a47 <vcprintf>
  801866:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801869:	83 ec 08             	sub    $0x8,%esp
  80186c:	6a 00                	push   $0x0
  80186e:	68 51 38 80 00       	push   $0x803851
  801873:	e8 cf 01 00 00       	call   801a47 <vcprintf>
  801878:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80187b:	e8 82 ff ff ff       	call   801802 <exit>

	// should not return here
	while (1) ;
  801880:	eb fe                	jmp    801880 <_panic+0x70>

00801882 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801882:	55                   	push   %ebp
  801883:	89 e5                	mov    %esp,%ebp
  801885:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801888:	a1 20 40 80 00       	mov    0x804020,%eax
  80188d:	8b 50 74             	mov    0x74(%eax),%edx
  801890:	8b 45 0c             	mov    0xc(%ebp),%eax
  801893:	39 c2                	cmp    %eax,%edx
  801895:	74 14                	je     8018ab <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801897:	83 ec 04             	sub    $0x4,%esp
  80189a:	68 54 38 80 00       	push   $0x803854
  80189f:	6a 26                	push   $0x26
  8018a1:	68 a0 38 80 00       	push   $0x8038a0
  8018a6:	e8 65 ff ff ff       	call   801810 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8018ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8018b2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8018b9:	e9 b6 00 00 00       	jmp    801974 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8018be:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018c1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cb:	01 d0                	add    %edx,%eax
  8018cd:	8b 00                	mov    (%eax),%eax
  8018cf:	85 c0                	test   %eax,%eax
  8018d1:	75 08                	jne    8018db <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8018d3:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8018d6:	e9 96 00 00 00       	jmp    801971 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8018db:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8018e2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8018e9:	eb 5d                	jmp    801948 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8018eb:	a1 20 40 80 00       	mov    0x804020,%eax
  8018f0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8018f6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8018f9:	c1 e2 04             	shl    $0x4,%edx
  8018fc:	01 d0                	add    %edx,%eax
  8018fe:	8a 40 04             	mov    0x4(%eax),%al
  801901:	84 c0                	test   %al,%al
  801903:	75 40                	jne    801945 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801905:	a1 20 40 80 00       	mov    0x804020,%eax
  80190a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801910:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801913:	c1 e2 04             	shl    $0x4,%edx
  801916:	01 d0                	add    %edx,%eax
  801918:	8b 00                	mov    (%eax),%eax
  80191a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80191d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801920:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801925:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801927:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80192a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801931:	8b 45 08             	mov    0x8(%ebp),%eax
  801934:	01 c8                	add    %ecx,%eax
  801936:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801938:	39 c2                	cmp    %eax,%edx
  80193a:	75 09                	jne    801945 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80193c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801943:	eb 12                	jmp    801957 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801945:	ff 45 e8             	incl   -0x18(%ebp)
  801948:	a1 20 40 80 00       	mov    0x804020,%eax
  80194d:	8b 50 74             	mov    0x74(%eax),%edx
  801950:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801953:	39 c2                	cmp    %eax,%edx
  801955:	77 94                	ja     8018eb <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801957:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80195b:	75 14                	jne    801971 <CheckWSWithoutLastIndex+0xef>
			panic(
  80195d:	83 ec 04             	sub    $0x4,%esp
  801960:	68 ac 38 80 00       	push   $0x8038ac
  801965:	6a 3a                	push   $0x3a
  801967:	68 a0 38 80 00       	push   $0x8038a0
  80196c:	e8 9f fe ff ff       	call   801810 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801971:	ff 45 f0             	incl   -0x10(%ebp)
  801974:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801977:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80197a:	0f 8c 3e ff ff ff    	jl     8018be <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801980:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801987:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80198e:	eb 20                	jmp    8019b0 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801990:	a1 20 40 80 00       	mov    0x804020,%eax
  801995:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80199b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80199e:	c1 e2 04             	shl    $0x4,%edx
  8019a1:	01 d0                	add    %edx,%eax
  8019a3:	8a 40 04             	mov    0x4(%eax),%al
  8019a6:	3c 01                	cmp    $0x1,%al
  8019a8:	75 03                	jne    8019ad <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8019aa:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019ad:	ff 45 e0             	incl   -0x20(%ebp)
  8019b0:	a1 20 40 80 00       	mov    0x804020,%eax
  8019b5:	8b 50 74             	mov    0x74(%eax),%edx
  8019b8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8019bb:	39 c2                	cmp    %eax,%edx
  8019bd:	77 d1                	ja     801990 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8019bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019c2:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019c5:	74 14                	je     8019db <CheckWSWithoutLastIndex+0x159>
		panic(
  8019c7:	83 ec 04             	sub    $0x4,%esp
  8019ca:	68 00 39 80 00       	push   $0x803900
  8019cf:	6a 44                	push   $0x44
  8019d1:	68 a0 38 80 00       	push   $0x8038a0
  8019d6:	e8 35 fe ff ff       	call   801810 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8019db:	90                   	nop
  8019dc:	c9                   	leave  
  8019dd:	c3                   	ret    

008019de <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8019de:	55                   	push   %ebp
  8019df:	89 e5                	mov    %esp,%ebp
  8019e1:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8019e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019e7:	8b 00                	mov    (%eax),%eax
  8019e9:	8d 48 01             	lea    0x1(%eax),%ecx
  8019ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019ef:	89 0a                	mov    %ecx,(%edx)
  8019f1:	8b 55 08             	mov    0x8(%ebp),%edx
  8019f4:	88 d1                	mov    %dl,%cl
  8019f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019f9:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8019fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a00:	8b 00                	mov    (%eax),%eax
  801a02:	3d ff 00 00 00       	cmp    $0xff,%eax
  801a07:	75 2c                	jne    801a35 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  801a09:	a0 24 40 80 00       	mov    0x804024,%al
  801a0e:	0f b6 c0             	movzbl %al,%eax
  801a11:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a14:	8b 12                	mov    (%edx),%edx
  801a16:	89 d1                	mov    %edx,%ecx
  801a18:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a1b:	83 c2 08             	add    $0x8,%edx
  801a1e:	83 ec 04             	sub    $0x4,%esp
  801a21:	50                   	push   %eax
  801a22:	51                   	push   %ecx
  801a23:	52                   	push   %edx
  801a24:	e8 b8 11 00 00       	call   802be1 <sys_cputs>
  801a29:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  801a2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a2f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  801a35:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a38:	8b 40 04             	mov    0x4(%eax),%eax
  801a3b:	8d 50 01             	lea    0x1(%eax),%edx
  801a3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a41:	89 50 04             	mov    %edx,0x4(%eax)
}
  801a44:	90                   	nop
  801a45:	c9                   	leave  
  801a46:	c3                   	ret    

00801a47 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  801a47:	55                   	push   %ebp
  801a48:	89 e5                	mov    %esp,%ebp
  801a4a:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  801a50:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  801a57:	00 00 00 
	b.cnt = 0;
  801a5a:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  801a61:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  801a64:	ff 75 0c             	pushl  0xc(%ebp)
  801a67:	ff 75 08             	pushl  0x8(%ebp)
  801a6a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801a70:	50                   	push   %eax
  801a71:	68 de 19 80 00       	push   $0x8019de
  801a76:	e8 11 02 00 00       	call   801c8c <vprintfmt>
  801a7b:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  801a7e:	a0 24 40 80 00       	mov    0x804024,%al
  801a83:	0f b6 c0             	movzbl %al,%eax
  801a86:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  801a8c:	83 ec 04             	sub    $0x4,%esp
  801a8f:	50                   	push   %eax
  801a90:	52                   	push   %edx
  801a91:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801a97:	83 c0 08             	add    $0x8,%eax
  801a9a:	50                   	push   %eax
  801a9b:	e8 41 11 00 00       	call   802be1 <sys_cputs>
  801aa0:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801aa3:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  801aaa:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801ab0:	c9                   	leave  
  801ab1:	c3                   	ret    

00801ab2 <cprintf>:

int cprintf(const char *fmt, ...) {
  801ab2:	55                   	push   %ebp
  801ab3:	89 e5                	mov    %esp,%ebp
  801ab5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  801ab8:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  801abf:	8d 45 0c             	lea    0xc(%ebp),%eax
  801ac2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801ac5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac8:	83 ec 08             	sub    $0x8,%esp
  801acb:	ff 75 f4             	pushl  -0xc(%ebp)
  801ace:	50                   	push   %eax
  801acf:	e8 73 ff ff ff       	call   801a47 <vcprintf>
  801ad4:	83 c4 10             	add    $0x10,%esp
  801ad7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  801ada:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801add:	c9                   	leave  
  801ade:	c3                   	ret    

00801adf <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801adf:	55                   	push   %ebp
  801ae0:	89 e5                	mov    %esp,%ebp
  801ae2:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801ae5:	e8 08 13 00 00       	call   802df2 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801aea:	8d 45 0c             	lea    0xc(%ebp),%eax
  801aed:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801af0:	8b 45 08             	mov    0x8(%ebp),%eax
  801af3:	83 ec 08             	sub    $0x8,%esp
  801af6:	ff 75 f4             	pushl  -0xc(%ebp)
  801af9:	50                   	push   %eax
  801afa:	e8 48 ff ff ff       	call   801a47 <vcprintf>
  801aff:	83 c4 10             	add    $0x10,%esp
  801b02:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801b05:	e8 02 13 00 00       	call   802e0c <sys_enable_interrupt>
	return cnt;
  801b0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801b0d:	c9                   	leave  
  801b0e:	c3                   	ret    

00801b0f <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801b0f:	55                   	push   %ebp
  801b10:	89 e5                	mov    %esp,%ebp
  801b12:	53                   	push   %ebx
  801b13:	83 ec 14             	sub    $0x14,%esp
  801b16:	8b 45 10             	mov    0x10(%ebp),%eax
  801b19:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801b1c:	8b 45 14             	mov    0x14(%ebp),%eax
  801b1f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801b22:	8b 45 18             	mov    0x18(%ebp),%eax
  801b25:	ba 00 00 00 00       	mov    $0x0,%edx
  801b2a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801b2d:	77 55                	ja     801b84 <printnum+0x75>
  801b2f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801b32:	72 05                	jb     801b39 <printnum+0x2a>
  801b34:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b37:	77 4b                	ja     801b84 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801b39:	8b 45 1c             	mov    0x1c(%ebp),%eax
  801b3c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  801b3f:	8b 45 18             	mov    0x18(%ebp),%eax
  801b42:	ba 00 00 00 00       	mov    $0x0,%edx
  801b47:	52                   	push   %edx
  801b48:	50                   	push   %eax
  801b49:	ff 75 f4             	pushl  -0xc(%ebp)
  801b4c:	ff 75 f0             	pushl  -0x10(%ebp)
  801b4f:	e8 c0 16 00 00       	call   803214 <__udivdi3>
  801b54:	83 c4 10             	add    $0x10,%esp
  801b57:	83 ec 04             	sub    $0x4,%esp
  801b5a:	ff 75 20             	pushl  0x20(%ebp)
  801b5d:	53                   	push   %ebx
  801b5e:	ff 75 18             	pushl  0x18(%ebp)
  801b61:	52                   	push   %edx
  801b62:	50                   	push   %eax
  801b63:	ff 75 0c             	pushl  0xc(%ebp)
  801b66:	ff 75 08             	pushl  0x8(%ebp)
  801b69:	e8 a1 ff ff ff       	call   801b0f <printnum>
  801b6e:	83 c4 20             	add    $0x20,%esp
  801b71:	eb 1a                	jmp    801b8d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801b73:	83 ec 08             	sub    $0x8,%esp
  801b76:	ff 75 0c             	pushl  0xc(%ebp)
  801b79:	ff 75 20             	pushl  0x20(%ebp)
  801b7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7f:	ff d0                	call   *%eax
  801b81:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801b84:	ff 4d 1c             	decl   0x1c(%ebp)
  801b87:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801b8b:	7f e6                	jg     801b73 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801b8d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801b90:	bb 00 00 00 00       	mov    $0x0,%ebx
  801b95:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b98:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b9b:	53                   	push   %ebx
  801b9c:	51                   	push   %ecx
  801b9d:	52                   	push   %edx
  801b9e:	50                   	push   %eax
  801b9f:	e8 80 17 00 00       	call   803324 <__umoddi3>
  801ba4:	83 c4 10             	add    $0x10,%esp
  801ba7:	05 74 3b 80 00       	add    $0x803b74,%eax
  801bac:	8a 00                	mov    (%eax),%al
  801bae:	0f be c0             	movsbl %al,%eax
  801bb1:	83 ec 08             	sub    $0x8,%esp
  801bb4:	ff 75 0c             	pushl  0xc(%ebp)
  801bb7:	50                   	push   %eax
  801bb8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bbb:	ff d0                	call   *%eax
  801bbd:	83 c4 10             	add    $0x10,%esp
}
  801bc0:	90                   	nop
  801bc1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801bc4:	c9                   	leave  
  801bc5:	c3                   	ret    

00801bc6 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801bc6:	55                   	push   %ebp
  801bc7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801bc9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801bcd:	7e 1c                	jle    801beb <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801bcf:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd2:	8b 00                	mov    (%eax),%eax
  801bd4:	8d 50 08             	lea    0x8(%eax),%edx
  801bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  801bda:	89 10                	mov    %edx,(%eax)
  801bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdf:	8b 00                	mov    (%eax),%eax
  801be1:	83 e8 08             	sub    $0x8,%eax
  801be4:	8b 50 04             	mov    0x4(%eax),%edx
  801be7:	8b 00                	mov    (%eax),%eax
  801be9:	eb 40                	jmp    801c2b <getuint+0x65>
	else if (lflag)
  801beb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801bef:	74 1e                	je     801c0f <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801bf1:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf4:	8b 00                	mov    (%eax),%eax
  801bf6:	8d 50 04             	lea    0x4(%eax),%edx
  801bf9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bfc:	89 10                	mov    %edx,(%eax)
  801bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  801c01:	8b 00                	mov    (%eax),%eax
  801c03:	83 e8 04             	sub    $0x4,%eax
  801c06:	8b 00                	mov    (%eax),%eax
  801c08:	ba 00 00 00 00       	mov    $0x0,%edx
  801c0d:	eb 1c                	jmp    801c2b <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801c0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c12:	8b 00                	mov    (%eax),%eax
  801c14:	8d 50 04             	lea    0x4(%eax),%edx
  801c17:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1a:	89 10                	mov    %edx,(%eax)
  801c1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1f:	8b 00                	mov    (%eax),%eax
  801c21:	83 e8 04             	sub    $0x4,%eax
  801c24:	8b 00                	mov    (%eax),%eax
  801c26:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801c2b:	5d                   	pop    %ebp
  801c2c:	c3                   	ret    

00801c2d <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801c2d:	55                   	push   %ebp
  801c2e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801c30:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801c34:	7e 1c                	jle    801c52 <getint+0x25>
		return va_arg(*ap, long long);
  801c36:	8b 45 08             	mov    0x8(%ebp),%eax
  801c39:	8b 00                	mov    (%eax),%eax
  801c3b:	8d 50 08             	lea    0x8(%eax),%edx
  801c3e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c41:	89 10                	mov    %edx,(%eax)
  801c43:	8b 45 08             	mov    0x8(%ebp),%eax
  801c46:	8b 00                	mov    (%eax),%eax
  801c48:	83 e8 08             	sub    $0x8,%eax
  801c4b:	8b 50 04             	mov    0x4(%eax),%edx
  801c4e:	8b 00                	mov    (%eax),%eax
  801c50:	eb 38                	jmp    801c8a <getint+0x5d>
	else if (lflag)
  801c52:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801c56:	74 1a                	je     801c72 <getint+0x45>
		return va_arg(*ap, long);
  801c58:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5b:	8b 00                	mov    (%eax),%eax
  801c5d:	8d 50 04             	lea    0x4(%eax),%edx
  801c60:	8b 45 08             	mov    0x8(%ebp),%eax
  801c63:	89 10                	mov    %edx,(%eax)
  801c65:	8b 45 08             	mov    0x8(%ebp),%eax
  801c68:	8b 00                	mov    (%eax),%eax
  801c6a:	83 e8 04             	sub    $0x4,%eax
  801c6d:	8b 00                	mov    (%eax),%eax
  801c6f:	99                   	cltd   
  801c70:	eb 18                	jmp    801c8a <getint+0x5d>
	else
		return va_arg(*ap, int);
  801c72:	8b 45 08             	mov    0x8(%ebp),%eax
  801c75:	8b 00                	mov    (%eax),%eax
  801c77:	8d 50 04             	lea    0x4(%eax),%edx
  801c7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7d:	89 10                	mov    %edx,(%eax)
  801c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c82:	8b 00                	mov    (%eax),%eax
  801c84:	83 e8 04             	sub    $0x4,%eax
  801c87:	8b 00                	mov    (%eax),%eax
  801c89:	99                   	cltd   
}
  801c8a:	5d                   	pop    %ebp
  801c8b:	c3                   	ret    

00801c8c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801c8c:	55                   	push   %ebp
  801c8d:	89 e5                	mov    %esp,%ebp
  801c8f:	56                   	push   %esi
  801c90:	53                   	push   %ebx
  801c91:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801c94:	eb 17                	jmp    801cad <vprintfmt+0x21>
			if (ch == '\0')
  801c96:	85 db                	test   %ebx,%ebx
  801c98:	0f 84 af 03 00 00    	je     80204d <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801c9e:	83 ec 08             	sub    $0x8,%esp
  801ca1:	ff 75 0c             	pushl  0xc(%ebp)
  801ca4:	53                   	push   %ebx
  801ca5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca8:	ff d0                	call   *%eax
  801caa:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801cad:	8b 45 10             	mov    0x10(%ebp),%eax
  801cb0:	8d 50 01             	lea    0x1(%eax),%edx
  801cb3:	89 55 10             	mov    %edx,0x10(%ebp)
  801cb6:	8a 00                	mov    (%eax),%al
  801cb8:	0f b6 d8             	movzbl %al,%ebx
  801cbb:	83 fb 25             	cmp    $0x25,%ebx
  801cbe:	75 d6                	jne    801c96 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801cc0:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801cc4:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801ccb:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801cd2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801cd9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801ce0:	8b 45 10             	mov    0x10(%ebp),%eax
  801ce3:	8d 50 01             	lea    0x1(%eax),%edx
  801ce6:	89 55 10             	mov    %edx,0x10(%ebp)
  801ce9:	8a 00                	mov    (%eax),%al
  801ceb:	0f b6 d8             	movzbl %al,%ebx
  801cee:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801cf1:	83 f8 55             	cmp    $0x55,%eax
  801cf4:	0f 87 2b 03 00 00    	ja     802025 <vprintfmt+0x399>
  801cfa:	8b 04 85 98 3b 80 00 	mov    0x803b98(,%eax,4),%eax
  801d01:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801d03:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801d07:	eb d7                	jmp    801ce0 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801d09:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801d0d:	eb d1                	jmp    801ce0 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801d0f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801d16:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801d19:	89 d0                	mov    %edx,%eax
  801d1b:	c1 e0 02             	shl    $0x2,%eax
  801d1e:	01 d0                	add    %edx,%eax
  801d20:	01 c0                	add    %eax,%eax
  801d22:	01 d8                	add    %ebx,%eax
  801d24:	83 e8 30             	sub    $0x30,%eax
  801d27:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801d2a:	8b 45 10             	mov    0x10(%ebp),%eax
  801d2d:	8a 00                	mov    (%eax),%al
  801d2f:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801d32:	83 fb 2f             	cmp    $0x2f,%ebx
  801d35:	7e 3e                	jle    801d75 <vprintfmt+0xe9>
  801d37:	83 fb 39             	cmp    $0x39,%ebx
  801d3a:	7f 39                	jg     801d75 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801d3c:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801d3f:	eb d5                	jmp    801d16 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801d41:	8b 45 14             	mov    0x14(%ebp),%eax
  801d44:	83 c0 04             	add    $0x4,%eax
  801d47:	89 45 14             	mov    %eax,0x14(%ebp)
  801d4a:	8b 45 14             	mov    0x14(%ebp),%eax
  801d4d:	83 e8 04             	sub    $0x4,%eax
  801d50:	8b 00                	mov    (%eax),%eax
  801d52:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801d55:	eb 1f                	jmp    801d76 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801d57:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801d5b:	79 83                	jns    801ce0 <vprintfmt+0x54>
				width = 0;
  801d5d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801d64:	e9 77 ff ff ff       	jmp    801ce0 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801d69:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801d70:	e9 6b ff ff ff       	jmp    801ce0 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801d75:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801d76:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801d7a:	0f 89 60 ff ff ff    	jns    801ce0 <vprintfmt+0x54>
				width = precision, precision = -1;
  801d80:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d83:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801d86:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801d8d:	e9 4e ff ff ff       	jmp    801ce0 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801d92:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801d95:	e9 46 ff ff ff       	jmp    801ce0 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801d9a:	8b 45 14             	mov    0x14(%ebp),%eax
  801d9d:	83 c0 04             	add    $0x4,%eax
  801da0:	89 45 14             	mov    %eax,0x14(%ebp)
  801da3:	8b 45 14             	mov    0x14(%ebp),%eax
  801da6:	83 e8 04             	sub    $0x4,%eax
  801da9:	8b 00                	mov    (%eax),%eax
  801dab:	83 ec 08             	sub    $0x8,%esp
  801dae:	ff 75 0c             	pushl  0xc(%ebp)
  801db1:	50                   	push   %eax
  801db2:	8b 45 08             	mov    0x8(%ebp),%eax
  801db5:	ff d0                	call   *%eax
  801db7:	83 c4 10             	add    $0x10,%esp
			break;
  801dba:	e9 89 02 00 00       	jmp    802048 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801dbf:	8b 45 14             	mov    0x14(%ebp),%eax
  801dc2:	83 c0 04             	add    $0x4,%eax
  801dc5:	89 45 14             	mov    %eax,0x14(%ebp)
  801dc8:	8b 45 14             	mov    0x14(%ebp),%eax
  801dcb:	83 e8 04             	sub    $0x4,%eax
  801dce:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801dd0:	85 db                	test   %ebx,%ebx
  801dd2:	79 02                	jns    801dd6 <vprintfmt+0x14a>
				err = -err;
  801dd4:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801dd6:	83 fb 64             	cmp    $0x64,%ebx
  801dd9:	7f 0b                	jg     801de6 <vprintfmt+0x15a>
  801ddb:	8b 34 9d e0 39 80 00 	mov    0x8039e0(,%ebx,4),%esi
  801de2:	85 f6                	test   %esi,%esi
  801de4:	75 19                	jne    801dff <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801de6:	53                   	push   %ebx
  801de7:	68 85 3b 80 00       	push   $0x803b85
  801dec:	ff 75 0c             	pushl  0xc(%ebp)
  801def:	ff 75 08             	pushl  0x8(%ebp)
  801df2:	e8 5e 02 00 00       	call   802055 <printfmt>
  801df7:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801dfa:	e9 49 02 00 00       	jmp    802048 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801dff:	56                   	push   %esi
  801e00:	68 8e 3b 80 00       	push   $0x803b8e
  801e05:	ff 75 0c             	pushl  0xc(%ebp)
  801e08:	ff 75 08             	pushl  0x8(%ebp)
  801e0b:	e8 45 02 00 00       	call   802055 <printfmt>
  801e10:	83 c4 10             	add    $0x10,%esp
			break;
  801e13:	e9 30 02 00 00       	jmp    802048 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801e18:	8b 45 14             	mov    0x14(%ebp),%eax
  801e1b:	83 c0 04             	add    $0x4,%eax
  801e1e:	89 45 14             	mov    %eax,0x14(%ebp)
  801e21:	8b 45 14             	mov    0x14(%ebp),%eax
  801e24:	83 e8 04             	sub    $0x4,%eax
  801e27:	8b 30                	mov    (%eax),%esi
  801e29:	85 f6                	test   %esi,%esi
  801e2b:	75 05                	jne    801e32 <vprintfmt+0x1a6>
				p = "(null)";
  801e2d:	be 91 3b 80 00       	mov    $0x803b91,%esi
			if (width > 0 && padc != '-')
  801e32:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801e36:	7e 6d                	jle    801ea5 <vprintfmt+0x219>
  801e38:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801e3c:	74 67                	je     801ea5 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801e3e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801e41:	83 ec 08             	sub    $0x8,%esp
  801e44:	50                   	push   %eax
  801e45:	56                   	push   %esi
  801e46:	e8 0c 03 00 00       	call   802157 <strnlen>
  801e4b:	83 c4 10             	add    $0x10,%esp
  801e4e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801e51:	eb 16                	jmp    801e69 <vprintfmt+0x1dd>
					putch(padc, putdat);
  801e53:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801e57:	83 ec 08             	sub    $0x8,%esp
  801e5a:	ff 75 0c             	pushl  0xc(%ebp)
  801e5d:	50                   	push   %eax
  801e5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e61:	ff d0                	call   *%eax
  801e63:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801e66:	ff 4d e4             	decl   -0x1c(%ebp)
  801e69:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801e6d:	7f e4                	jg     801e53 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801e6f:	eb 34                	jmp    801ea5 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801e71:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801e75:	74 1c                	je     801e93 <vprintfmt+0x207>
  801e77:	83 fb 1f             	cmp    $0x1f,%ebx
  801e7a:	7e 05                	jle    801e81 <vprintfmt+0x1f5>
  801e7c:	83 fb 7e             	cmp    $0x7e,%ebx
  801e7f:	7e 12                	jle    801e93 <vprintfmt+0x207>
					putch('?', putdat);
  801e81:	83 ec 08             	sub    $0x8,%esp
  801e84:	ff 75 0c             	pushl  0xc(%ebp)
  801e87:	6a 3f                	push   $0x3f
  801e89:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8c:	ff d0                	call   *%eax
  801e8e:	83 c4 10             	add    $0x10,%esp
  801e91:	eb 0f                	jmp    801ea2 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801e93:	83 ec 08             	sub    $0x8,%esp
  801e96:	ff 75 0c             	pushl  0xc(%ebp)
  801e99:	53                   	push   %ebx
  801e9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e9d:	ff d0                	call   *%eax
  801e9f:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801ea2:	ff 4d e4             	decl   -0x1c(%ebp)
  801ea5:	89 f0                	mov    %esi,%eax
  801ea7:	8d 70 01             	lea    0x1(%eax),%esi
  801eaa:	8a 00                	mov    (%eax),%al
  801eac:	0f be d8             	movsbl %al,%ebx
  801eaf:	85 db                	test   %ebx,%ebx
  801eb1:	74 24                	je     801ed7 <vprintfmt+0x24b>
  801eb3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801eb7:	78 b8                	js     801e71 <vprintfmt+0x1e5>
  801eb9:	ff 4d e0             	decl   -0x20(%ebp)
  801ebc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801ec0:	79 af                	jns    801e71 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801ec2:	eb 13                	jmp    801ed7 <vprintfmt+0x24b>
				putch(' ', putdat);
  801ec4:	83 ec 08             	sub    $0x8,%esp
  801ec7:	ff 75 0c             	pushl  0xc(%ebp)
  801eca:	6a 20                	push   $0x20
  801ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  801ecf:	ff d0                	call   *%eax
  801ed1:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801ed4:	ff 4d e4             	decl   -0x1c(%ebp)
  801ed7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801edb:	7f e7                	jg     801ec4 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801edd:	e9 66 01 00 00       	jmp    802048 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801ee2:	83 ec 08             	sub    $0x8,%esp
  801ee5:	ff 75 e8             	pushl  -0x18(%ebp)
  801ee8:	8d 45 14             	lea    0x14(%ebp),%eax
  801eeb:	50                   	push   %eax
  801eec:	e8 3c fd ff ff       	call   801c2d <getint>
  801ef1:	83 c4 10             	add    $0x10,%esp
  801ef4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801ef7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801efa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801efd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801f00:	85 d2                	test   %edx,%edx
  801f02:	79 23                	jns    801f27 <vprintfmt+0x29b>
				putch('-', putdat);
  801f04:	83 ec 08             	sub    $0x8,%esp
  801f07:	ff 75 0c             	pushl  0xc(%ebp)
  801f0a:	6a 2d                	push   $0x2d
  801f0c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f0f:	ff d0                	call   *%eax
  801f11:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801f14:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f17:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801f1a:	f7 d8                	neg    %eax
  801f1c:	83 d2 00             	adc    $0x0,%edx
  801f1f:	f7 da                	neg    %edx
  801f21:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801f24:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801f27:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801f2e:	e9 bc 00 00 00       	jmp    801fef <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801f33:	83 ec 08             	sub    $0x8,%esp
  801f36:	ff 75 e8             	pushl  -0x18(%ebp)
  801f39:	8d 45 14             	lea    0x14(%ebp),%eax
  801f3c:	50                   	push   %eax
  801f3d:	e8 84 fc ff ff       	call   801bc6 <getuint>
  801f42:	83 c4 10             	add    $0x10,%esp
  801f45:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801f48:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801f4b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801f52:	e9 98 00 00 00       	jmp    801fef <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801f57:	83 ec 08             	sub    $0x8,%esp
  801f5a:	ff 75 0c             	pushl  0xc(%ebp)
  801f5d:	6a 58                	push   $0x58
  801f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f62:	ff d0                	call   *%eax
  801f64:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801f67:	83 ec 08             	sub    $0x8,%esp
  801f6a:	ff 75 0c             	pushl  0xc(%ebp)
  801f6d:	6a 58                	push   $0x58
  801f6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f72:	ff d0                	call   *%eax
  801f74:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801f77:	83 ec 08             	sub    $0x8,%esp
  801f7a:	ff 75 0c             	pushl  0xc(%ebp)
  801f7d:	6a 58                	push   $0x58
  801f7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f82:	ff d0                	call   *%eax
  801f84:	83 c4 10             	add    $0x10,%esp
			break;
  801f87:	e9 bc 00 00 00       	jmp    802048 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801f8c:	83 ec 08             	sub    $0x8,%esp
  801f8f:	ff 75 0c             	pushl  0xc(%ebp)
  801f92:	6a 30                	push   $0x30
  801f94:	8b 45 08             	mov    0x8(%ebp),%eax
  801f97:	ff d0                	call   *%eax
  801f99:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801f9c:	83 ec 08             	sub    $0x8,%esp
  801f9f:	ff 75 0c             	pushl  0xc(%ebp)
  801fa2:	6a 78                	push   $0x78
  801fa4:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa7:	ff d0                	call   *%eax
  801fa9:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801fac:	8b 45 14             	mov    0x14(%ebp),%eax
  801faf:	83 c0 04             	add    $0x4,%eax
  801fb2:	89 45 14             	mov    %eax,0x14(%ebp)
  801fb5:	8b 45 14             	mov    0x14(%ebp),%eax
  801fb8:	83 e8 04             	sub    $0x4,%eax
  801fbb:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801fbd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801fc0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801fc7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801fce:	eb 1f                	jmp    801fef <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801fd0:	83 ec 08             	sub    $0x8,%esp
  801fd3:	ff 75 e8             	pushl  -0x18(%ebp)
  801fd6:	8d 45 14             	lea    0x14(%ebp),%eax
  801fd9:	50                   	push   %eax
  801fda:	e8 e7 fb ff ff       	call   801bc6 <getuint>
  801fdf:	83 c4 10             	add    $0x10,%esp
  801fe2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801fe5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801fe8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801fef:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801ff3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801ff6:	83 ec 04             	sub    $0x4,%esp
  801ff9:	52                   	push   %edx
  801ffa:	ff 75 e4             	pushl  -0x1c(%ebp)
  801ffd:	50                   	push   %eax
  801ffe:	ff 75 f4             	pushl  -0xc(%ebp)
  802001:	ff 75 f0             	pushl  -0x10(%ebp)
  802004:	ff 75 0c             	pushl  0xc(%ebp)
  802007:	ff 75 08             	pushl  0x8(%ebp)
  80200a:	e8 00 fb ff ff       	call   801b0f <printnum>
  80200f:	83 c4 20             	add    $0x20,%esp
			break;
  802012:	eb 34                	jmp    802048 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  802014:	83 ec 08             	sub    $0x8,%esp
  802017:	ff 75 0c             	pushl  0xc(%ebp)
  80201a:	53                   	push   %ebx
  80201b:	8b 45 08             	mov    0x8(%ebp),%eax
  80201e:	ff d0                	call   *%eax
  802020:	83 c4 10             	add    $0x10,%esp
			break;
  802023:	eb 23                	jmp    802048 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  802025:	83 ec 08             	sub    $0x8,%esp
  802028:	ff 75 0c             	pushl  0xc(%ebp)
  80202b:	6a 25                	push   $0x25
  80202d:	8b 45 08             	mov    0x8(%ebp),%eax
  802030:	ff d0                	call   *%eax
  802032:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  802035:	ff 4d 10             	decl   0x10(%ebp)
  802038:	eb 03                	jmp    80203d <vprintfmt+0x3b1>
  80203a:	ff 4d 10             	decl   0x10(%ebp)
  80203d:	8b 45 10             	mov    0x10(%ebp),%eax
  802040:	48                   	dec    %eax
  802041:	8a 00                	mov    (%eax),%al
  802043:	3c 25                	cmp    $0x25,%al
  802045:	75 f3                	jne    80203a <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  802047:	90                   	nop
		}
	}
  802048:	e9 47 fc ff ff       	jmp    801c94 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80204d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80204e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802051:	5b                   	pop    %ebx
  802052:	5e                   	pop    %esi
  802053:	5d                   	pop    %ebp
  802054:	c3                   	ret    

00802055 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  802055:	55                   	push   %ebp
  802056:	89 e5                	mov    %esp,%ebp
  802058:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80205b:	8d 45 10             	lea    0x10(%ebp),%eax
  80205e:	83 c0 04             	add    $0x4,%eax
  802061:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  802064:	8b 45 10             	mov    0x10(%ebp),%eax
  802067:	ff 75 f4             	pushl  -0xc(%ebp)
  80206a:	50                   	push   %eax
  80206b:	ff 75 0c             	pushl  0xc(%ebp)
  80206e:	ff 75 08             	pushl  0x8(%ebp)
  802071:	e8 16 fc ff ff       	call   801c8c <vprintfmt>
  802076:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  802079:	90                   	nop
  80207a:	c9                   	leave  
  80207b:	c3                   	ret    

0080207c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80207c:	55                   	push   %ebp
  80207d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80207f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802082:	8b 40 08             	mov    0x8(%eax),%eax
  802085:	8d 50 01             	lea    0x1(%eax),%edx
  802088:	8b 45 0c             	mov    0xc(%ebp),%eax
  80208b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80208e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802091:	8b 10                	mov    (%eax),%edx
  802093:	8b 45 0c             	mov    0xc(%ebp),%eax
  802096:	8b 40 04             	mov    0x4(%eax),%eax
  802099:	39 c2                	cmp    %eax,%edx
  80209b:	73 12                	jae    8020af <sprintputch+0x33>
		*b->buf++ = ch;
  80209d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020a0:	8b 00                	mov    (%eax),%eax
  8020a2:	8d 48 01             	lea    0x1(%eax),%ecx
  8020a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020a8:	89 0a                	mov    %ecx,(%edx)
  8020aa:	8b 55 08             	mov    0x8(%ebp),%edx
  8020ad:	88 10                	mov    %dl,(%eax)
}
  8020af:	90                   	nop
  8020b0:	5d                   	pop    %ebp
  8020b1:	c3                   	ret    

008020b2 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8020b2:	55                   	push   %ebp
  8020b3:	89 e5                	mov    %esp,%ebp
  8020b5:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8020b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8020bb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8020be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020c1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8020c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c7:	01 d0                	add    %edx,%eax
  8020c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8020cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8020d3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8020d7:	74 06                	je     8020df <vsnprintf+0x2d>
  8020d9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8020dd:	7f 07                	jg     8020e6 <vsnprintf+0x34>
		return -E_INVAL;
  8020df:	b8 03 00 00 00       	mov    $0x3,%eax
  8020e4:	eb 20                	jmp    802106 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8020e6:	ff 75 14             	pushl  0x14(%ebp)
  8020e9:	ff 75 10             	pushl  0x10(%ebp)
  8020ec:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8020ef:	50                   	push   %eax
  8020f0:	68 7c 20 80 00       	push   $0x80207c
  8020f5:	e8 92 fb ff ff       	call   801c8c <vprintfmt>
  8020fa:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8020fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802100:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  802103:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  802106:	c9                   	leave  
  802107:	c3                   	ret    

00802108 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  802108:	55                   	push   %ebp
  802109:	89 e5                	mov    %esp,%ebp
  80210b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80210e:	8d 45 10             	lea    0x10(%ebp),%eax
  802111:	83 c0 04             	add    $0x4,%eax
  802114:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  802117:	8b 45 10             	mov    0x10(%ebp),%eax
  80211a:	ff 75 f4             	pushl  -0xc(%ebp)
  80211d:	50                   	push   %eax
  80211e:	ff 75 0c             	pushl  0xc(%ebp)
  802121:	ff 75 08             	pushl  0x8(%ebp)
  802124:	e8 89 ff ff ff       	call   8020b2 <vsnprintf>
  802129:	83 c4 10             	add    $0x10,%esp
  80212c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80212f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802132:	c9                   	leave  
  802133:	c3                   	ret    

00802134 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  802134:	55                   	push   %ebp
  802135:	89 e5                	mov    %esp,%ebp
  802137:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80213a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802141:	eb 06                	jmp    802149 <strlen+0x15>
		n++;
  802143:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  802146:	ff 45 08             	incl   0x8(%ebp)
  802149:	8b 45 08             	mov    0x8(%ebp),%eax
  80214c:	8a 00                	mov    (%eax),%al
  80214e:	84 c0                	test   %al,%al
  802150:	75 f1                	jne    802143 <strlen+0xf>
		n++;
	return n;
  802152:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802155:	c9                   	leave  
  802156:	c3                   	ret    

00802157 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  802157:	55                   	push   %ebp
  802158:	89 e5                	mov    %esp,%ebp
  80215a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80215d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802164:	eb 09                	jmp    80216f <strnlen+0x18>
		n++;
  802166:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  802169:	ff 45 08             	incl   0x8(%ebp)
  80216c:	ff 4d 0c             	decl   0xc(%ebp)
  80216f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802173:	74 09                	je     80217e <strnlen+0x27>
  802175:	8b 45 08             	mov    0x8(%ebp),%eax
  802178:	8a 00                	mov    (%eax),%al
  80217a:	84 c0                	test   %al,%al
  80217c:	75 e8                	jne    802166 <strnlen+0xf>
		n++;
	return n;
  80217e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802181:	c9                   	leave  
  802182:	c3                   	ret    

00802183 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  802183:	55                   	push   %ebp
  802184:	89 e5                	mov    %esp,%ebp
  802186:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  802189:	8b 45 08             	mov    0x8(%ebp),%eax
  80218c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80218f:	90                   	nop
  802190:	8b 45 08             	mov    0x8(%ebp),%eax
  802193:	8d 50 01             	lea    0x1(%eax),%edx
  802196:	89 55 08             	mov    %edx,0x8(%ebp)
  802199:	8b 55 0c             	mov    0xc(%ebp),%edx
  80219c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80219f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8021a2:	8a 12                	mov    (%edx),%dl
  8021a4:	88 10                	mov    %dl,(%eax)
  8021a6:	8a 00                	mov    (%eax),%al
  8021a8:	84 c0                	test   %al,%al
  8021aa:	75 e4                	jne    802190 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8021ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8021af:	c9                   	leave  
  8021b0:	c3                   	ret    

008021b1 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8021b1:	55                   	push   %ebp
  8021b2:	89 e5                	mov    %esp,%ebp
  8021b4:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8021b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ba:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8021bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8021c4:	eb 1f                	jmp    8021e5 <strncpy+0x34>
		*dst++ = *src;
  8021c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c9:	8d 50 01             	lea    0x1(%eax),%edx
  8021cc:	89 55 08             	mov    %edx,0x8(%ebp)
  8021cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021d2:	8a 12                	mov    (%edx),%dl
  8021d4:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8021d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021d9:	8a 00                	mov    (%eax),%al
  8021db:	84 c0                	test   %al,%al
  8021dd:	74 03                	je     8021e2 <strncpy+0x31>
			src++;
  8021df:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8021e2:	ff 45 fc             	incl   -0x4(%ebp)
  8021e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8021e8:	3b 45 10             	cmp    0x10(%ebp),%eax
  8021eb:	72 d9                	jb     8021c6 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8021ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8021f0:	c9                   	leave  
  8021f1:	c3                   	ret    

008021f2 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8021f2:	55                   	push   %ebp
  8021f3:	89 e5                	mov    %esp,%ebp
  8021f5:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8021f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8021fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8021fe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802202:	74 30                	je     802234 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  802204:	eb 16                	jmp    80221c <strlcpy+0x2a>
			*dst++ = *src++;
  802206:	8b 45 08             	mov    0x8(%ebp),%eax
  802209:	8d 50 01             	lea    0x1(%eax),%edx
  80220c:	89 55 08             	mov    %edx,0x8(%ebp)
  80220f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802212:	8d 4a 01             	lea    0x1(%edx),%ecx
  802215:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  802218:	8a 12                	mov    (%edx),%dl
  80221a:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80221c:	ff 4d 10             	decl   0x10(%ebp)
  80221f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802223:	74 09                	je     80222e <strlcpy+0x3c>
  802225:	8b 45 0c             	mov    0xc(%ebp),%eax
  802228:	8a 00                	mov    (%eax),%al
  80222a:	84 c0                	test   %al,%al
  80222c:	75 d8                	jne    802206 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80222e:	8b 45 08             	mov    0x8(%ebp),%eax
  802231:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  802234:	8b 55 08             	mov    0x8(%ebp),%edx
  802237:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80223a:	29 c2                	sub    %eax,%edx
  80223c:	89 d0                	mov    %edx,%eax
}
  80223e:	c9                   	leave  
  80223f:	c3                   	ret    

00802240 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  802240:	55                   	push   %ebp
  802241:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  802243:	eb 06                	jmp    80224b <strcmp+0xb>
		p++, q++;
  802245:	ff 45 08             	incl   0x8(%ebp)
  802248:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80224b:	8b 45 08             	mov    0x8(%ebp),%eax
  80224e:	8a 00                	mov    (%eax),%al
  802250:	84 c0                	test   %al,%al
  802252:	74 0e                	je     802262 <strcmp+0x22>
  802254:	8b 45 08             	mov    0x8(%ebp),%eax
  802257:	8a 10                	mov    (%eax),%dl
  802259:	8b 45 0c             	mov    0xc(%ebp),%eax
  80225c:	8a 00                	mov    (%eax),%al
  80225e:	38 c2                	cmp    %al,%dl
  802260:	74 e3                	je     802245 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  802262:	8b 45 08             	mov    0x8(%ebp),%eax
  802265:	8a 00                	mov    (%eax),%al
  802267:	0f b6 d0             	movzbl %al,%edx
  80226a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80226d:	8a 00                	mov    (%eax),%al
  80226f:	0f b6 c0             	movzbl %al,%eax
  802272:	29 c2                	sub    %eax,%edx
  802274:	89 d0                	mov    %edx,%eax
}
  802276:	5d                   	pop    %ebp
  802277:	c3                   	ret    

00802278 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  802278:	55                   	push   %ebp
  802279:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80227b:	eb 09                	jmp    802286 <strncmp+0xe>
		n--, p++, q++;
  80227d:	ff 4d 10             	decl   0x10(%ebp)
  802280:	ff 45 08             	incl   0x8(%ebp)
  802283:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  802286:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80228a:	74 17                	je     8022a3 <strncmp+0x2b>
  80228c:	8b 45 08             	mov    0x8(%ebp),%eax
  80228f:	8a 00                	mov    (%eax),%al
  802291:	84 c0                	test   %al,%al
  802293:	74 0e                	je     8022a3 <strncmp+0x2b>
  802295:	8b 45 08             	mov    0x8(%ebp),%eax
  802298:	8a 10                	mov    (%eax),%dl
  80229a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80229d:	8a 00                	mov    (%eax),%al
  80229f:	38 c2                	cmp    %al,%dl
  8022a1:	74 da                	je     80227d <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8022a3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8022a7:	75 07                	jne    8022b0 <strncmp+0x38>
		return 0;
  8022a9:	b8 00 00 00 00       	mov    $0x0,%eax
  8022ae:	eb 14                	jmp    8022c4 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8022b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8022b3:	8a 00                	mov    (%eax),%al
  8022b5:	0f b6 d0             	movzbl %al,%edx
  8022b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8022bb:	8a 00                	mov    (%eax),%al
  8022bd:	0f b6 c0             	movzbl %al,%eax
  8022c0:	29 c2                	sub    %eax,%edx
  8022c2:	89 d0                	mov    %edx,%eax
}
  8022c4:	5d                   	pop    %ebp
  8022c5:	c3                   	ret    

008022c6 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8022c6:	55                   	push   %ebp
  8022c7:	89 e5                	mov    %esp,%ebp
  8022c9:	83 ec 04             	sub    $0x4,%esp
  8022cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8022cf:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8022d2:	eb 12                	jmp    8022e6 <strchr+0x20>
		if (*s == c)
  8022d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8022d7:	8a 00                	mov    (%eax),%al
  8022d9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8022dc:	75 05                	jne    8022e3 <strchr+0x1d>
			return (char *) s;
  8022de:	8b 45 08             	mov    0x8(%ebp),%eax
  8022e1:	eb 11                	jmp    8022f4 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8022e3:	ff 45 08             	incl   0x8(%ebp)
  8022e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8022e9:	8a 00                	mov    (%eax),%al
  8022eb:	84 c0                	test   %al,%al
  8022ed:	75 e5                	jne    8022d4 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8022ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022f4:	c9                   	leave  
  8022f5:	c3                   	ret    

008022f6 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8022f6:	55                   	push   %ebp
  8022f7:	89 e5                	mov    %esp,%ebp
  8022f9:	83 ec 04             	sub    $0x4,%esp
  8022fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8022ff:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802302:	eb 0d                	jmp    802311 <strfind+0x1b>
		if (*s == c)
  802304:	8b 45 08             	mov    0x8(%ebp),%eax
  802307:	8a 00                	mov    (%eax),%al
  802309:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80230c:	74 0e                	je     80231c <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80230e:	ff 45 08             	incl   0x8(%ebp)
  802311:	8b 45 08             	mov    0x8(%ebp),%eax
  802314:	8a 00                	mov    (%eax),%al
  802316:	84 c0                	test   %al,%al
  802318:	75 ea                	jne    802304 <strfind+0xe>
  80231a:	eb 01                	jmp    80231d <strfind+0x27>
		if (*s == c)
			break;
  80231c:	90                   	nop
	return (char *) s;
  80231d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802320:	c9                   	leave  
  802321:	c3                   	ret    

00802322 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  802322:	55                   	push   %ebp
  802323:	89 e5                	mov    %esp,%ebp
  802325:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  802328:	8b 45 08             	mov    0x8(%ebp),%eax
  80232b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80232e:	8b 45 10             	mov    0x10(%ebp),%eax
  802331:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  802334:	eb 0e                	jmp    802344 <memset+0x22>
		*p++ = c;
  802336:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802339:	8d 50 01             	lea    0x1(%eax),%edx
  80233c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80233f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802342:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  802344:	ff 4d f8             	decl   -0x8(%ebp)
  802347:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80234b:	79 e9                	jns    802336 <memset+0x14>
		*p++ = c;

	return v;
  80234d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802350:	c9                   	leave  
  802351:	c3                   	ret    

00802352 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  802352:	55                   	push   %ebp
  802353:	89 e5                	mov    %esp,%ebp
  802355:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  802358:	8b 45 0c             	mov    0xc(%ebp),%eax
  80235b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80235e:	8b 45 08             	mov    0x8(%ebp),%eax
  802361:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  802364:	eb 16                	jmp    80237c <memcpy+0x2a>
		*d++ = *s++;
  802366:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802369:	8d 50 01             	lea    0x1(%eax),%edx
  80236c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80236f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802372:	8d 4a 01             	lea    0x1(%edx),%ecx
  802375:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  802378:	8a 12                	mov    (%edx),%dl
  80237a:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80237c:	8b 45 10             	mov    0x10(%ebp),%eax
  80237f:	8d 50 ff             	lea    -0x1(%eax),%edx
  802382:	89 55 10             	mov    %edx,0x10(%ebp)
  802385:	85 c0                	test   %eax,%eax
  802387:	75 dd                	jne    802366 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  802389:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80238c:	c9                   	leave  
  80238d:	c3                   	ret    

0080238e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80238e:	55                   	push   %ebp
  80238f:	89 e5                	mov    %esp,%ebp
  802391:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  802394:	8b 45 0c             	mov    0xc(%ebp),%eax
  802397:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80239a:	8b 45 08             	mov    0x8(%ebp),%eax
  80239d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8023a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8023a3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8023a6:	73 50                	jae    8023f8 <memmove+0x6a>
  8023a8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8023ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8023ae:	01 d0                	add    %edx,%eax
  8023b0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8023b3:	76 43                	jbe    8023f8 <memmove+0x6a>
		s += n;
  8023b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8023b8:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8023bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8023be:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8023c1:	eb 10                	jmp    8023d3 <memmove+0x45>
			*--d = *--s;
  8023c3:	ff 4d f8             	decl   -0x8(%ebp)
  8023c6:	ff 4d fc             	decl   -0x4(%ebp)
  8023c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8023cc:	8a 10                	mov    (%eax),%dl
  8023ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8023d1:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8023d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8023d6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8023d9:	89 55 10             	mov    %edx,0x10(%ebp)
  8023dc:	85 c0                	test   %eax,%eax
  8023de:	75 e3                	jne    8023c3 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8023e0:	eb 23                	jmp    802405 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8023e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8023e5:	8d 50 01             	lea    0x1(%eax),%edx
  8023e8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8023eb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8023ee:	8d 4a 01             	lea    0x1(%edx),%ecx
  8023f1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8023f4:	8a 12                	mov    (%edx),%dl
  8023f6:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8023f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8023fb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8023fe:	89 55 10             	mov    %edx,0x10(%ebp)
  802401:	85 c0                	test   %eax,%eax
  802403:	75 dd                	jne    8023e2 <memmove+0x54>
			*d++ = *s++;

	return dst;
  802405:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802408:	c9                   	leave  
  802409:	c3                   	ret    

0080240a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80240a:	55                   	push   %ebp
  80240b:	89 e5                	mov    %esp,%ebp
  80240d:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  802410:	8b 45 08             	mov    0x8(%ebp),%eax
  802413:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  802416:	8b 45 0c             	mov    0xc(%ebp),%eax
  802419:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80241c:	eb 2a                	jmp    802448 <memcmp+0x3e>
		if (*s1 != *s2)
  80241e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802421:	8a 10                	mov    (%eax),%dl
  802423:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802426:	8a 00                	mov    (%eax),%al
  802428:	38 c2                	cmp    %al,%dl
  80242a:	74 16                	je     802442 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80242c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80242f:	8a 00                	mov    (%eax),%al
  802431:	0f b6 d0             	movzbl %al,%edx
  802434:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802437:	8a 00                	mov    (%eax),%al
  802439:	0f b6 c0             	movzbl %al,%eax
  80243c:	29 c2                	sub    %eax,%edx
  80243e:	89 d0                	mov    %edx,%eax
  802440:	eb 18                	jmp    80245a <memcmp+0x50>
		s1++, s2++;
  802442:	ff 45 fc             	incl   -0x4(%ebp)
  802445:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  802448:	8b 45 10             	mov    0x10(%ebp),%eax
  80244b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80244e:	89 55 10             	mov    %edx,0x10(%ebp)
  802451:	85 c0                	test   %eax,%eax
  802453:	75 c9                	jne    80241e <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  802455:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80245a:	c9                   	leave  
  80245b:	c3                   	ret    

0080245c <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80245c:	55                   	push   %ebp
  80245d:	89 e5                	mov    %esp,%ebp
  80245f:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  802462:	8b 55 08             	mov    0x8(%ebp),%edx
  802465:	8b 45 10             	mov    0x10(%ebp),%eax
  802468:	01 d0                	add    %edx,%eax
  80246a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80246d:	eb 15                	jmp    802484 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80246f:	8b 45 08             	mov    0x8(%ebp),%eax
  802472:	8a 00                	mov    (%eax),%al
  802474:	0f b6 d0             	movzbl %al,%edx
  802477:	8b 45 0c             	mov    0xc(%ebp),%eax
  80247a:	0f b6 c0             	movzbl %al,%eax
  80247d:	39 c2                	cmp    %eax,%edx
  80247f:	74 0d                	je     80248e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  802481:	ff 45 08             	incl   0x8(%ebp)
  802484:	8b 45 08             	mov    0x8(%ebp),%eax
  802487:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80248a:	72 e3                	jb     80246f <memfind+0x13>
  80248c:	eb 01                	jmp    80248f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80248e:	90                   	nop
	return (void *) s;
  80248f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802492:	c9                   	leave  
  802493:	c3                   	ret    

00802494 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  802494:	55                   	push   %ebp
  802495:	89 e5                	mov    %esp,%ebp
  802497:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80249a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8024a1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8024a8:	eb 03                	jmp    8024ad <strtol+0x19>
		s++;
  8024aa:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8024ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8024b0:	8a 00                	mov    (%eax),%al
  8024b2:	3c 20                	cmp    $0x20,%al
  8024b4:	74 f4                	je     8024aa <strtol+0x16>
  8024b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8024b9:	8a 00                	mov    (%eax),%al
  8024bb:	3c 09                	cmp    $0x9,%al
  8024bd:	74 eb                	je     8024aa <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8024bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8024c2:	8a 00                	mov    (%eax),%al
  8024c4:	3c 2b                	cmp    $0x2b,%al
  8024c6:	75 05                	jne    8024cd <strtol+0x39>
		s++;
  8024c8:	ff 45 08             	incl   0x8(%ebp)
  8024cb:	eb 13                	jmp    8024e0 <strtol+0x4c>
	else if (*s == '-')
  8024cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8024d0:	8a 00                	mov    (%eax),%al
  8024d2:	3c 2d                	cmp    $0x2d,%al
  8024d4:	75 0a                	jne    8024e0 <strtol+0x4c>
		s++, neg = 1;
  8024d6:	ff 45 08             	incl   0x8(%ebp)
  8024d9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8024e0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8024e4:	74 06                	je     8024ec <strtol+0x58>
  8024e6:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8024ea:	75 20                	jne    80250c <strtol+0x78>
  8024ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8024ef:	8a 00                	mov    (%eax),%al
  8024f1:	3c 30                	cmp    $0x30,%al
  8024f3:	75 17                	jne    80250c <strtol+0x78>
  8024f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8024f8:	40                   	inc    %eax
  8024f9:	8a 00                	mov    (%eax),%al
  8024fb:	3c 78                	cmp    $0x78,%al
  8024fd:	75 0d                	jne    80250c <strtol+0x78>
		s += 2, base = 16;
  8024ff:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  802503:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80250a:	eb 28                	jmp    802534 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80250c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802510:	75 15                	jne    802527 <strtol+0x93>
  802512:	8b 45 08             	mov    0x8(%ebp),%eax
  802515:	8a 00                	mov    (%eax),%al
  802517:	3c 30                	cmp    $0x30,%al
  802519:	75 0c                	jne    802527 <strtol+0x93>
		s++, base = 8;
  80251b:	ff 45 08             	incl   0x8(%ebp)
  80251e:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  802525:	eb 0d                	jmp    802534 <strtol+0xa0>
	else if (base == 0)
  802527:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80252b:	75 07                	jne    802534 <strtol+0xa0>
		base = 10;
  80252d:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  802534:	8b 45 08             	mov    0x8(%ebp),%eax
  802537:	8a 00                	mov    (%eax),%al
  802539:	3c 2f                	cmp    $0x2f,%al
  80253b:	7e 19                	jle    802556 <strtol+0xc2>
  80253d:	8b 45 08             	mov    0x8(%ebp),%eax
  802540:	8a 00                	mov    (%eax),%al
  802542:	3c 39                	cmp    $0x39,%al
  802544:	7f 10                	jg     802556 <strtol+0xc2>
			dig = *s - '0';
  802546:	8b 45 08             	mov    0x8(%ebp),%eax
  802549:	8a 00                	mov    (%eax),%al
  80254b:	0f be c0             	movsbl %al,%eax
  80254e:	83 e8 30             	sub    $0x30,%eax
  802551:	89 45 f4             	mov    %eax,-0xc(%ebp)
  802554:	eb 42                	jmp    802598 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  802556:	8b 45 08             	mov    0x8(%ebp),%eax
  802559:	8a 00                	mov    (%eax),%al
  80255b:	3c 60                	cmp    $0x60,%al
  80255d:	7e 19                	jle    802578 <strtol+0xe4>
  80255f:	8b 45 08             	mov    0x8(%ebp),%eax
  802562:	8a 00                	mov    (%eax),%al
  802564:	3c 7a                	cmp    $0x7a,%al
  802566:	7f 10                	jg     802578 <strtol+0xe4>
			dig = *s - 'a' + 10;
  802568:	8b 45 08             	mov    0x8(%ebp),%eax
  80256b:	8a 00                	mov    (%eax),%al
  80256d:	0f be c0             	movsbl %al,%eax
  802570:	83 e8 57             	sub    $0x57,%eax
  802573:	89 45 f4             	mov    %eax,-0xc(%ebp)
  802576:	eb 20                	jmp    802598 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  802578:	8b 45 08             	mov    0x8(%ebp),%eax
  80257b:	8a 00                	mov    (%eax),%al
  80257d:	3c 40                	cmp    $0x40,%al
  80257f:	7e 39                	jle    8025ba <strtol+0x126>
  802581:	8b 45 08             	mov    0x8(%ebp),%eax
  802584:	8a 00                	mov    (%eax),%al
  802586:	3c 5a                	cmp    $0x5a,%al
  802588:	7f 30                	jg     8025ba <strtol+0x126>
			dig = *s - 'A' + 10;
  80258a:	8b 45 08             	mov    0x8(%ebp),%eax
  80258d:	8a 00                	mov    (%eax),%al
  80258f:	0f be c0             	movsbl %al,%eax
  802592:	83 e8 37             	sub    $0x37,%eax
  802595:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  802598:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80259b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80259e:	7d 19                	jge    8025b9 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8025a0:	ff 45 08             	incl   0x8(%ebp)
  8025a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8025a6:	0f af 45 10          	imul   0x10(%ebp),%eax
  8025aa:	89 c2                	mov    %eax,%edx
  8025ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8025af:	01 d0                	add    %edx,%eax
  8025b1:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8025b4:	e9 7b ff ff ff       	jmp    802534 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8025b9:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8025ba:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8025be:	74 08                	je     8025c8 <strtol+0x134>
		*endptr = (char *) s;
  8025c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8025c3:	8b 55 08             	mov    0x8(%ebp),%edx
  8025c6:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8025c8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8025cc:	74 07                	je     8025d5 <strtol+0x141>
  8025ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8025d1:	f7 d8                	neg    %eax
  8025d3:	eb 03                	jmp    8025d8 <strtol+0x144>
  8025d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8025d8:	c9                   	leave  
  8025d9:	c3                   	ret    

008025da <ltostr>:

void
ltostr(long value, char *str)
{
  8025da:	55                   	push   %ebp
  8025db:	89 e5                	mov    %esp,%ebp
  8025dd:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8025e0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8025e7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8025ee:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8025f2:	79 13                	jns    802607 <ltostr+0x2d>
	{
		neg = 1;
  8025f4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8025fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8025fe:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  802601:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  802604:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  802607:	8b 45 08             	mov    0x8(%ebp),%eax
  80260a:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80260f:	99                   	cltd   
  802610:	f7 f9                	idiv   %ecx
  802612:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  802615:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802618:	8d 50 01             	lea    0x1(%eax),%edx
  80261b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80261e:	89 c2                	mov    %eax,%edx
  802620:	8b 45 0c             	mov    0xc(%ebp),%eax
  802623:	01 d0                	add    %edx,%eax
  802625:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802628:	83 c2 30             	add    $0x30,%edx
  80262b:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80262d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802630:	b8 67 66 66 66       	mov    $0x66666667,%eax
  802635:	f7 e9                	imul   %ecx
  802637:	c1 fa 02             	sar    $0x2,%edx
  80263a:	89 c8                	mov    %ecx,%eax
  80263c:	c1 f8 1f             	sar    $0x1f,%eax
  80263f:	29 c2                	sub    %eax,%edx
  802641:	89 d0                	mov    %edx,%eax
  802643:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  802646:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802649:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80264e:	f7 e9                	imul   %ecx
  802650:	c1 fa 02             	sar    $0x2,%edx
  802653:	89 c8                	mov    %ecx,%eax
  802655:	c1 f8 1f             	sar    $0x1f,%eax
  802658:	29 c2                	sub    %eax,%edx
  80265a:	89 d0                	mov    %edx,%eax
  80265c:	c1 e0 02             	shl    $0x2,%eax
  80265f:	01 d0                	add    %edx,%eax
  802661:	01 c0                	add    %eax,%eax
  802663:	29 c1                	sub    %eax,%ecx
  802665:	89 ca                	mov    %ecx,%edx
  802667:	85 d2                	test   %edx,%edx
  802669:	75 9c                	jne    802607 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80266b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  802672:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802675:	48                   	dec    %eax
  802676:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  802679:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80267d:	74 3d                	je     8026bc <ltostr+0xe2>
		start = 1 ;
  80267f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  802686:	eb 34                	jmp    8026bc <ltostr+0xe2>
	{
		char tmp = str[start] ;
  802688:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80268b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80268e:	01 d0                	add    %edx,%eax
  802690:	8a 00                	mov    (%eax),%al
  802692:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  802695:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802698:	8b 45 0c             	mov    0xc(%ebp),%eax
  80269b:	01 c2                	add    %eax,%edx
  80269d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8026a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8026a3:	01 c8                	add    %ecx,%eax
  8026a5:	8a 00                	mov    (%eax),%al
  8026a7:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8026a9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8026ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8026af:	01 c2                	add    %eax,%edx
  8026b1:	8a 45 eb             	mov    -0x15(%ebp),%al
  8026b4:	88 02                	mov    %al,(%edx)
		start++ ;
  8026b6:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8026b9:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8026bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8026bf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8026c2:	7c c4                	jl     802688 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8026c4:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8026c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8026ca:	01 d0                	add    %edx,%eax
  8026cc:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8026cf:	90                   	nop
  8026d0:	c9                   	leave  
  8026d1:	c3                   	ret    

008026d2 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8026d2:	55                   	push   %ebp
  8026d3:	89 e5                	mov    %esp,%ebp
  8026d5:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8026d8:	ff 75 08             	pushl  0x8(%ebp)
  8026db:	e8 54 fa ff ff       	call   802134 <strlen>
  8026e0:	83 c4 04             	add    $0x4,%esp
  8026e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8026e6:	ff 75 0c             	pushl  0xc(%ebp)
  8026e9:	e8 46 fa ff ff       	call   802134 <strlen>
  8026ee:	83 c4 04             	add    $0x4,%esp
  8026f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8026f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8026fb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802702:	eb 17                	jmp    80271b <strcconcat+0x49>
		final[s] = str1[s] ;
  802704:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802707:	8b 45 10             	mov    0x10(%ebp),%eax
  80270a:	01 c2                	add    %eax,%edx
  80270c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80270f:	8b 45 08             	mov    0x8(%ebp),%eax
  802712:	01 c8                	add    %ecx,%eax
  802714:	8a 00                	mov    (%eax),%al
  802716:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  802718:	ff 45 fc             	incl   -0x4(%ebp)
  80271b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80271e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  802721:	7c e1                	jl     802704 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  802723:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80272a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  802731:	eb 1f                	jmp    802752 <strcconcat+0x80>
		final[s++] = str2[i] ;
  802733:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802736:	8d 50 01             	lea    0x1(%eax),%edx
  802739:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80273c:	89 c2                	mov    %eax,%edx
  80273e:	8b 45 10             	mov    0x10(%ebp),%eax
  802741:	01 c2                	add    %eax,%edx
  802743:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  802746:	8b 45 0c             	mov    0xc(%ebp),%eax
  802749:	01 c8                	add    %ecx,%eax
  80274b:	8a 00                	mov    (%eax),%al
  80274d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80274f:	ff 45 f8             	incl   -0x8(%ebp)
  802752:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802755:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802758:	7c d9                	jl     802733 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80275a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80275d:	8b 45 10             	mov    0x10(%ebp),%eax
  802760:	01 d0                	add    %edx,%eax
  802762:	c6 00 00             	movb   $0x0,(%eax)
}
  802765:	90                   	nop
  802766:	c9                   	leave  
  802767:	c3                   	ret    

00802768 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  802768:	55                   	push   %ebp
  802769:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80276b:	8b 45 14             	mov    0x14(%ebp),%eax
  80276e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  802774:	8b 45 14             	mov    0x14(%ebp),%eax
  802777:	8b 00                	mov    (%eax),%eax
  802779:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802780:	8b 45 10             	mov    0x10(%ebp),%eax
  802783:	01 d0                	add    %edx,%eax
  802785:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80278b:	eb 0c                	jmp    802799 <strsplit+0x31>
			*string++ = 0;
  80278d:	8b 45 08             	mov    0x8(%ebp),%eax
  802790:	8d 50 01             	lea    0x1(%eax),%edx
  802793:	89 55 08             	mov    %edx,0x8(%ebp)
  802796:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  802799:	8b 45 08             	mov    0x8(%ebp),%eax
  80279c:	8a 00                	mov    (%eax),%al
  80279e:	84 c0                	test   %al,%al
  8027a0:	74 18                	je     8027ba <strsplit+0x52>
  8027a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8027a5:	8a 00                	mov    (%eax),%al
  8027a7:	0f be c0             	movsbl %al,%eax
  8027aa:	50                   	push   %eax
  8027ab:	ff 75 0c             	pushl  0xc(%ebp)
  8027ae:	e8 13 fb ff ff       	call   8022c6 <strchr>
  8027b3:	83 c4 08             	add    $0x8,%esp
  8027b6:	85 c0                	test   %eax,%eax
  8027b8:	75 d3                	jne    80278d <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8027ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8027bd:	8a 00                	mov    (%eax),%al
  8027bf:	84 c0                	test   %al,%al
  8027c1:	74 5a                	je     80281d <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8027c3:	8b 45 14             	mov    0x14(%ebp),%eax
  8027c6:	8b 00                	mov    (%eax),%eax
  8027c8:	83 f8 0f             	cmp    $0xf,%eax
  8027cb:	75 07                	jne    8027d4 <strsplit+0x6c>
		{
			return 0;
  8027cd:	b8 00 00 00 00       	mov    $0x0,%eax
  8027d2:	eb 66                	jmp    80283a <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8027d4:	8b 45 14             	mov    0x14(%ebp),%eax
  8027d7:	8b 00                	mov    (%eax),%eax
  8027d9:	8d 48 01             	lea    0x1(%eax),%ecx
  8027dc:	8b 55 14             	mov    0x14(%ebp),%edx
  8027df:	89 0a                	mov    %ecx,(%edx)
  8027e1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8027e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8027eb:	01 c2                	add    %eax,%edx
  8027ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8027f0:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8027f2:	eb 03                	jmp    8027f7 <strsplit+0x8f>
			string++;
  8027f4:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8027f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8027fa:	8a 00                	mov    (%eax),%al
  8027fc:	84 c0                	test   %al,%al
  8027fe:	74 8b                	je     80278b <strsplit+0x23>
  802800:	8b 45 08             	mov    0x8(%ebp),%eax
  802803:	8a 00                	mov    (%eax),%al
  802805:	0f be c0             	movsbl %al,%eax
  802808:	50                   	push   %eax
  802809:	ff 75 0c             	pushl  0xc(%ebp)
  80280c:	e8 b5 fa ff ff       	call   8022c6 <strchr>
  802811:	83 c4 08             	add    $0x8,%esp
  802814:	85 c0                	test   %eax,%eax
  802816:	74 dc                	je     8027f4 <strsplit+0x8c>
			string++;
	}
  802818:	e9 6e ff ff ff       	jmp    80278b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80281d:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80281e:	8b 45 14             	mov    0x14(%ebp),%eax
  802821:	8b 00                	mov    (%eax),%eax
  802823:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80282a:	8b 45 10             	mov    0x10(%ebp),%eax
  80282d:	01 d0                	add    %edx,%eax
  80282f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  802835:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80283a:	c9                   	leave  
  80283b:	c3                   	ret    

0080283c <malloc>:
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
  80283c:	55                   	push   %ebp
  80283d:	89 e5                	mov    %esp,%ebp
  80283f:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  802842:	8b 45 08             	mov    0x8(%ebp),%eax
  802845:	c1 e8 0c             	shr    $0xc,%eax
  802848:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  80284b:	8b 45 08             	mov    0x8(%ebp),%eax
  80284e:	25 ff 0f 00 00       	and    $0xfff,%eax
  802853:	85 c0                	test   %eax,%eax
  802855:	74 03                	je     80285a <malloc+0x1e>
			num++;
  802857:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  80285a:	a1 04 40 80 00       	mov    0x804004,%eax
  80285f:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  802864:	75 73                	jne    8028d9 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  802866:	83 ec 08             	sub    $0x8,%esp
  802869:	ff 75 08             	pushl  0x8(%ebp)
  80286c:	68 00 00 00 80       	push   $0x80000000
  802871:	e8 13 05 00 00       	call   802d89 <sys_allocateMem>
  802876:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  802879:	a1 04 40 80 00       	mov    0x804004,%eax
  80287e:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  802881:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802884:	c1 e0 0c             	shl    $0xc,%eax
  802887:	89 c2                	mov    %eax,%edx
  802889:	a1 04 40 80 00       	mov    0x804004,%eax
  80288e:	01 d0                	add    %edx,%eax
  802890:	a3 04 40 80 00       	mov    %eax,0x804004
			numOfPages[sizeofarray]=num;
  802895:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80289a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80289d:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
			addresses[sizeofarray]=last_addres;
  8028a4:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8028a9:	8b 15 04 40 80 00    	mov    0x804004,%edx
  8028af:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
			changed[sizeofarray]=1;
  8028b6:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8028bb:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  8028c2:	01 00 00 00 
			sizeofarray++;
  8028c6:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8028cb:	40                   	inc    %eax
  8028cc:	a3 2c 40 80 00       	mov    %eax,0x80402c
			return (void*)return_addres;
  8028d1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8028d4:	e9 71 01 00 00       	jmp    802a4a <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  8028d9:	a1 28 40 80 00       	mov    0x804028,%eax
  8028de:	85 c0                	test   %eax,%eax
  8028e0:	75 71                	jne    802953 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  8028e2:	a1 04 40 80 00       	mov    0x804004,%eax
  8028e7:	83 ec 08             	sub    $0x8,%esp
  8028ea:	ff 75 08             	pushl  0x8(%ebp)
  8028ed:	50                   	push   %eax
  8028ee:	e8 96 04 00 00       	call   802d89 <sys_allocateMem>
  8028f3:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  8028f6:	a1 04 40 80 00       	mov    0x804004,%eax
  8028fb:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  8028fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802901:	c1 e0 0c             	shl    $0xc,%eax
  802904:	89 c2                	mov    %eax,%edx
  802906:	a1 04 40 80 00       	mov    0x804004,%eax
  80290b:	01 d0                	add    %edx,%eax
  80290d:	a3 04 40 80 00       	mov    %eax,0x804004
				numOfPages[sizeofarray]=num;
  802912:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802917:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80291a:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
				addresses[sizeofarray]=return_addres;
  802921:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802926:	8b 55 d8             	mov    -0x28(%ebp),%edx
  802929:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				changed[sizeofarray]=1;
  802930:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802935:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  80293c:	01 00 00 00 
				sizeofarray++;
  802940:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802945:	40                   	inc    %eax
  802946:	a3 2c 40 80 00       	mov    %eax,0x80402c
				return (void*)return_addres;
  80294b:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80294e:	e9 f7 00 00 00       	jmp    802a4a <malloc+0x20e>
			}
			else{
				int count=0;
  802953:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  80295a:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  802961:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  802968:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  80296f:	eb 7c                	jmp    8029ed <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  802971:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  802978:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  80297f:	eb 1a                	jmp    80299b <malloc+0x15f>
					{
						if(addresses[j]==i)
  802981:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802984:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  80298b:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80298e:	75 08                	jne    802998 <malloc+0x15c>
						{
							index=j;
  802990:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802993:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  802996:	eb 0d                	jmp    8029a5 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  802998:	ff 45 dc             	incl   -0x24(%ebp)
  80299b:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8029a0:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  8029a3:	7c dc                	jl     802981 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  8029a5:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  8029a9:	75 05                	jne    8029b0 <malloc+0x174>
					{
						count++;
  8029ab:	ff 45 f0             	incl   -0x10(%ebp)
  8029ae:	eb 36                	jmp    8029e6 <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  8029b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8029b3:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  8029ba:	85 c0                	test   %eax,%eax
  8029bc:	75 05                	jne    8029c3 <malloc+0x187>
						{
							count++;
  8029be:	ff 45 f0             	incl   -0x10(%ebp)
  8029c1:	eb 23                	jmp    8029e6 <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  8029c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8029c6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8029c9:	7d 14                	jge    8029df <malloc+0x1a3>
  8029cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8029ce:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8029d1:	7c 0c                	jl     8029df <malloc+0x1a3>
							{
								min=count;
  8029d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8029d6:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  8029d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8029dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  8029df:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8029e6:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  8029ed:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  8029f4:	0f 86 77 ff ff ff    	jbe    802971 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  8029fa:	83 ec 08             	sub    $0x8,%esp
  8029fd:	ff 75 08             	pushl  0x8(%ebp)
  802a00:	ff 75 e4             	pushl  -0x1c(%ebp)
  802a03:	e8 81 03 00 00       	call   802d89 <sys_allocateMem>
  802a08:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  802a0b:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802a10:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802a13:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
				addresses[sizeofarray]=last_addres;
  802a1a:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802a1f:	8b 15 04 40 80 00    	mov    0x804004,%edx
  802a25:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				changed[sizeofarray]=1;
  802a2c:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802a31:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  802a38:	01 00 00 00 
				sizeofarray++;
  802a3c:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802a41:	40                   	inc    %eax
  802a42:	a3 2c 40 80 00       	mov    %eax,0x80402c
				return(void*) min_addresss;
  802a47:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  802a4a:	c9                   	leave  
  802a4b:	c3                   	ret    

00802a4c <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  802a4c:	55                   	push   %ebp
  802a4d:	89 e5                	mov    %esp,%ebp
  802a4f:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  802a52:	8b 45 08             	mov    0x8(%ebp),%eax
  802a55:	89 45 e8             	mov    %eax,-0x18(%ebp)
    uint32 size;
    int is_found=0;
  802a58:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  802a5f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  802a66:	eb 30                	jmp    802a98 <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  802a68:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802a6b:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802a72:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  802a75:	75 1e                	jne    802a95 <free+0x49>
  802a77:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802a7a:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  802a81:	83 f8 01             	cmp    $0x1,%eax
  802a84:	75 0f                	jne    802a95 <free+0x49>
    		is_found=1;
  802a86:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  802a8d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802a90:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  802a93:	eb 0d                	jmp    802aa2 <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    uint32 size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  802a95:	ff 45 ec             	incl   -0x14(%ebp)
  802a98:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802a9d:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  802aa0:	7c c6                	jl     802a68 <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  802aa2:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  802aa6:	75 3a                	jne    802ae2 <free+0x96>
    	size=numOfPages[index]*PAGE_SIZE;
  802aa8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802aab:	8b 04 85 20 76 8c 00 	mov    0x8c7620(,%eax,4),%eax
  802ab2:	c1 e0 0c             	shl    $0xc,%eax
  802ab5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  802ab8:	83 ec 08             	sub    $0x8,%esp
  802abb:	ff 75 e4             	pushl  -0x1c(%ebp)
  802abe:	ff 75 e8             	pushl  -0x18(%ebp)
  802ac1:	e8 a7 02 00 00       	call   802d6d <sys_freeMem>
  802ac6:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  802ac9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802acc:	c7 04 85 a0 5b 86 00 	movl   $0x0,0x865ba0(,%eax,4)
  802ad3:	00 00 00 00 
    	changes++;
  802ad7:	a1 28 40 80 00       	mov    0x804028,%eax
  802adc:	40                   	inc    %eax
  802add:	a3 28 40 80 00       	mov    %eax,0x804028
    }


	//refer to the project presentation and documentation for details
}
  802ae2:	90                   	nop
  802ae3:	c9                   	leave  
  802ae4:	c3                   	ret    

00802ae5 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  802ae5:	55                   	push   %ebp
  802ae6:	89 e5                	mov    %esp,%ebp
  802ae8:	83 ec 18             	sub    $0x18,%esp
  802aeb:	8b 45 10             	mov    0x10(%ebp),%eax
  802aee:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  802af1:	83 ec 04             	sub    $0x4,%esp
  802af4:	68 f0 3c 80 00       	push   $0x803cf0
  802af9:	68 9f 00 00 00       	push   $0x9f
  802afe:	68 13 3d 80 00       	push   $0x803d13
  802b03:	e8 08 ed ff ff       	call   801810 <_panic>

00802b08 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  802b08:	55                   	push   %ebp
  802b09:	89 e5                	mov    %esp,%ebp
  802b0b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b0e:	83 ec 04             	sub    $0x4,%esp
  802b11:	68 f0 3c 80 00       	push   $0x803cf0
  802b16:	68 a5 00 00 00       	push   $0xa5
  802b1b:	68 13 3d 80 00       	push   $0x803d13
  802b20:	e8 eb ec ff ff       	call   801810 <_panic>

00802b25 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  802b25:	55                   	push   %ebp
  802b26:	89 e5                	mov    %esp,%ebp
  802b28:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b2b:	83 ec 04             	sub    $0x4,%esp
  802b2e:	68 f0 3c 80 00       	push   $0x803cf0
  802b33:	68 ab 00 00 00       	push   $0xab
  802b38:	68 13 3d 80 00       	push   $0x803d13
  802b3d:	e8 ce ec ff ff       	call   801810 <_panic>

00802b42 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  802b42:	55                   	push   %ebp
  802b43:	89 e5                	mov    %esp,%ebp
  802b45:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b48:	83 ec 04             	sub    $0x4,%esp
  802b4b:	68 f0 3c 80 00       	push   $0x803cf0
  802b50:	68 b0 00 00 00       	push   $0xb0
  802b55:	68 13 3d 80 00       	push   $0x803d13
  802b5a:	e8 b1 ec ff ff       	call   801810 <_panic>

00802b5f <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  802b5f:	55                   	push   %ebp
  802b60:	89 e5                	mov    %esp,%ebp
  802b62:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b65:	83 ec 04             	sub    $0x4,%esp
  802b68:	68 f0 3c 80 00       	push   $0x803cf0
  802b6d:	68 b6 00 00 00       	push   $0xb6
  802b72:	68 13 3d 80 00       	push   $0x803d13
  802b77:	e8 94 ec ff ff       	call   801810 <_panic>

00802b7c <shrink>:
}
void shrink(uint32 newSize)
{
  802b7c:	55                   	push   %ebp
  802b7d:	89 e5                	mov    %esp,%ebp
  802b7f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b82:	83 ec 04             	sub    $0x4,%esp
  802b85:	68 f0 3c 80 00       	push   $0x803cf0
  802b8a:	68 ba 00 00 00       	push   $0xba
  802b8f:	68 13 3d 80 00       	push   $0x803d13
  802b94:	e8 77 ec ff ff       	call   801810 <_panic>

00802b99 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  802b99:	55                   	push   %ebp
  802b9a:	89 e5                	mov    %esp,%ebp
  802b9c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b9f:	83 ec 04             	sub    $0x4,%esp
  802ba2:	68 f0 3c 80 00       	push   $0x803cf0
  802ba7:	68 bf 00 00 00       	push   $0xbf
  802bac:	68 13 3d 80 00       	push   $0x803d13
  802bb1:	e8 5a ec ff ff       	call   801810 <_panic>

00802bb6 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  802bb6:	55                   	push   %ebp
  802bb7:	89 e5                	mov    %esp,%ebp
  802bb9:	57                   	push   %edi
  802bba:	56                   	push   %esi
  802bbb:	53                   	push   %ebx
  802bbc:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802bbf:	8b 45 08             	mov    0x8(%ebp),%eax
  802bc2:	8b 55 0c             	mov    0xc(%ebp),%edx
  802bc5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802bc8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802bcb:	8b 7d 18             	mov    0x18(%ebp),%edi
  802bce:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802bd1:	cd 30                	int    $0x30
  802bd3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802bd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802bd9:	83 c4 10             	add    $0x10,%esp
  802bdc:	5b                   	pop    %ebx
  802bdd:	5e                   	pop    %esi
  802bde:	5f                   	pop    %edi
  802bdf:	5d                   	pop    %ebp
  802be0:	c3                   	ret    

00802be1 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802be1:	55                   	push   %ebp
  802be2:	89 e5                	mov    %esp,%ebp
  802be4:	83 ec 04             	sub    $0x4,%esp
  802be7:	8b 45 10             	mov    0x10(%ebp),%eax
  802bea:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802bed:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802bf1:	8b 45 08             	mov    0x8(%ebp),%eax
  802bf4:	6a 00                	push   $0x0
  802bf6:	6a 00                	push   $0x0
  802bf8:	52                   	push   %edx
  802bf9:	ff 75 0c             	pushl  0xc(%ebp)
  802bfc:	50                   	push   %eax
  802bfd:	6a 00                	push   $0x0
  802bff:	e8 b2 ff ff ff       	call   802bb6 <syscall>
  802c04:	83 c4 18             	add    $0x18,%esp
}
  802c07:	90                   	nop
  802c08:	c9                   	leave  
  802c09:	c3                   	ret    

00802c0a <sys_cgetc>:

int
sys_cgetc(void)
{
  802c0a:	55                   	push   %ebp
  802c0b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802c0d:	6a 00                	push   $0x0
  802c0f:	6a 00                	push   $0x0
  802c11:	6a 00                	push   $0x0
  802c13:	6a 00                	push   $0x0
  802c15:	6a 00                	push   $0x0
  802c17:	6a 01                	push   $0x1
  802c19:	e8 98 ff ff ff       	call   802bb6 <syscall>
  802c1e:	83 c4 18             	add    $0x18,%esp
}
  802c21:	c9                   	leave  
  802c22:	c3                   	ret    

00802c23 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802c23:	55                   	push   %ebp
  802c24:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802c26:	8b 45 08             	mov    0x8(%ebp),%eax
  802c29:	6a 00                	push   $0x0
  802c2b:	6a 00                	push   $0x0
  802c2d:	6a 00                	push   $0x0
  802c2f:	6a 00                	push   $0x0
  802c31:	50                   	push   %eax
  802c32:	6a 05                	push   $0x5
  802c34:	e8 7d ff ff ff       	call   802bb6 <syscall>
  802c39:	83 c4 18             	add    $0x18,%esp
}
  802c3c:	c9                   	leave  
  802c3d:	c3                   	ret    

00802c3e <sys_getenvid>:

int32 sys_getenvid(void)
{
  802c3e:	55                   	push   %ebp
  802c3f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802c41:	6a 00                	push   $0x0
  802c43:	6a 00                	push   $0x0
  802c45:	6a 00                	push   $0x0
  802c47:	6a 00                	push   $0x0
  802c49:	6a 00                	push   $0x0
  802c4b:	6a 02                	push   $0x2
  802c4d:	e8 64 ff ff ff       	call   802bb6 <syscall>
  802c52:	83 c4 18             	add    $0x18,%esp
}
  802c55:	c9                   	leave  
  802c56:	c3                   	ret    

00802c57 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802c57:	55                   	push   %ebp
  802c58:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802c5a:	6a 00                	push   $0x0
  802c5c:	6a 00                	push   $0x0
  802c5e:	6a 00                	push   $0x0
  802c60:	6a 00                	push   $0x0
  802c62:	6a 00                	push   $0x0
  802c64:	6a 03                	push   $0x3
  802c66:	e8 4b ff ff ff       	call   802bb6 <syscall>
  802c6b:	83 c4 18             	add    $0x18,%esp
}
  802c6e:	c9                   	leave  
  802c6f:	c3                   	ret    

00802c70 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802c70:	55                   	push   %ebp
  802c71:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802c73:	6a 00                	push   $0x0
  802c75:	6a 00                	push   $0x0
  802c77:	6a 00                	push   $0x0
  802c79:	6a 00                	push   $0x0
  802c7b:	6a 00                	push   $0x0
  802c7d:	6a 04                	push   $0x4
  802c7f:	e8 32 ff ff ff       	call   802bb6 <syscall>
  802c84:	83 c4 18             	add    $0x18,%esp
}
  802c87:	c9                   	leave  
  802c88:	c3                   	ret    

00802c89 <sys_env_exit>:


void sys_env_exit(void)
{
  802c89:	55                   	push   %ebp
  802c8a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802c8c:	6a 00                	push   $0x0
  802c8e:	6a 00                	push   $0x0
  802c90:	6a 00                	push   $0x0
  802c92:	6a 00                	push   $0x0
  802c94:	6a 00                	push   $0x0
  802c96:	6a 06                	push   $0x6
  802c98:	e8 19 ff ff ff       	call   802bb6 <syscall>
  802c9d:	83 c4 18             	add    $0x18,%esp
}
  802ca0:	90                   	nop
  802ca1:	c9                   	leave  
  802ca2:	c3                   	ret    

00802ca3 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802ca3:	55                   	push   %ebp
  802ca4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802ca6:	8b 55 0c             	mov    0xc(%ebp),%edx
  802ca9:	8b 45 08             	mov    0x8(%ebp),%eax
  802cac:	6a 00                	push   $0x0
  802cae:	6a 00                	push   $0x0
  802cb0:	6a 00                	push   $0x0
  802cb2:	52                   	push   %edx
  802cb3:	50                   	push   %eax
  802cb4:	6a 07                	push   $0x7
  802cb6:	e8 fb fe ff ff       	call   802bb6 <syscall>
  802cbb:	83 c4 18             	add    $0x18,%esp
}
  802cbe:	c9                   	leave  
  802cbf:	c3                   	ret    

00802cc0 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802cc0:	55                   	push   %ebp
  802cc1:	89 e5                	mov    %esp,%ebp
  802cc3:	56                   	push   %esi
  802cc4:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802cc5:	8b 75 18             	mov    0x18(%ebp),%esi
  802cc8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802ccb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802cce:	8b 55 0c             	mov    0xc(%ebp),%edx
  802cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  802cd4:	56                   	push   %esi
  802cd5:	53                   	push   %ebx
  802cd6:	51                   	push   %ecx
  802cd7:	52                   	push   %edx
  802cd8:	50                   	push   %eax
  802cd9:	6a 08                	push   $0x8
  802cdb:	e8 d6 fe ff ff       	call   802bb6 <syscall>
  802ce0:	83 c4 18             	add    $0x18,%esp
}
  802ce3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802ce6:	5b                   	pop    %ebx
  802ce7:	5e                   	pop    %esi
  802ce8:	5d                   	pop    %ebp
  802ce9:	c3                   	ret    

00802cea <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802cea:	55                   	push   %ebp
  802ceb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802ced:	8b 55 0c             	mov    0xc(%ebp),%edx
  802cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  802cf3:	6a 00                	push   $0x0
  802cf5:	6a 00                	push   $0x0
  802cf7:	6a 00                	push   $0x0
  802cf9:	52                   	push   %edx
  802cfa:	50                   	push   %eax
  802cfb:	6a 09                	push   $0x9
  802cfd:	e8 b4 fe ff ff       	call   802bb6 <syscall>
  802d02:	83 c4 18             	add    $0x18,%esp
}
  802d05:	c9                   	leave  
  802d06:	c3                   	ret    

00802d07 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802d07:	55                   	push   %ebp
  802d08:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802d0a:	6a 00                	push   $0x0
  802d0c:	6a 00                	push   $0x0
  802d0e:	6a 00                	push   $0x0
  802d10:	ff 75 0c             	pushl  0xc(%ebp)
  802d13:	ff 75 08             	pushl  0x8(%ebp)
  802d16:	6a 0a                	push   $0xa
  802d18:	e8 99 fe ff ff       	call   802bb6 <syscall>
  802d1d:	83 c4 18             	add    $0x18,%esp
}
  802d20:	c9                   	leave  
  802d21:	c3                   	ret    

00802d22 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802d22:	55                   	push   %ebp
  802d23:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802d25:	6a 00                	push   $0x0
  802d27:	6a 00                	push   $0x0
  802d29:	6a 00                	push   $0x0
  802d2b:	6a 00                	push   $0x0
  802d2d:	6a 00                	push   $0x0
  802d2f:	6a 0b                	push   $0xb
  802d31:	e8 80 fe ff ff       	call   802bb6 <syscall>
  802d36:	83 c4 18             	add    $0x18,%esp
}
  802d39:	c9                   	leave  
  802d3a:	c3                   	ret    

00802d3b <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802d3b:	55                   	push   %ebp
  802d3c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802d3e:	6a 00                	push   $0x0
  802d40:	6a 00                	push   $0x0
  802d42:	6a 00                	push   $0x0
  802d44:	6a 00                	push   $0x0
  802d46:	6a 00                	push   $0x0
  802d48:	6a 0c                	push   $0xc
  802d4a:	e8 67 fe ff ff       	call   802bb6 <syscall>
  802d4f:	83 c4 18             	add    $0x18,%esp
}
  802d52:	c9                   	leave  
  802d53:	c3                   	ret    

00802d54 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802d54:	55                   	push   %ebp
  802d55:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802d57:	6a 00                	push   $0x0
  802d59:	6a 00                	push   $0x0
  802d5b:	6a 00                	push   $0x0
  802d5d:	6a 00                	push   $0x0
  802d5f:	6a 00                	push   $0x0
  802d61:	6a 0d                	push   $0xd
  802d63:	e8 4e fe ff ff       	call   802bb6 <syscall>
  802d68:	83 c4 18             	add    $0x18,%esp
}
  802d6b:	c9                   	leave  
  802d6c:	c3                   	ret    

00802d6d <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802d6d:	55                   	push   %ebp
  802d6e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802d70:	6a 00                	push   $0x0
  802d72:	6a 00                	push   $0x0
  802d74:	6a 00                	push   $0x0
  802d76:	ff 75 0c             	pushl  0xc(%ebp)
  802d79:	ff 75 08             	pushl  0x8(%ebp)
  802d7c:	6a 11                	push   $0x11
  802d7e:	e8 33 fe ff ff       	call   802bb6 <syscall>
  802d83:	83 c4 18             	add    $0x18,%esp
	return;
  802d86:	90                   	nop
}
  802d87:	c9                   	leave  
  802d88:	c3                   	ret    

00802d89 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802d89:	55                   	push   %ebp
  802d8a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802d8c:	6a 00                	push   $0x0
  802d8e:	6a 00                	push   $0x0
  802d90:	6a 00                	push   $0x0
  802d92:	ff 75 0c             	pushl  0xc(%ebp)
  802d95:	ff 75 08             	pushl  0x8(%ebp)
  802d98:	6a 12                	push   $0x12
  802d9a:	e8 17 fe ff ff       	call   802bb6 <syscall>
  802d9f:	83 c4 18             	add    $0x18,%esp
	return ;
  802da2:	90                   	nop
}
  802da3:	c9                   	leave  
  802da4:	c3                   	ret    

00802da5 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802da5:	55                   	push   %ebp
  802da6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802da8:	6a 00                	push   $0x0
  802daa:	6a 00                	push   $0x0
  802dac:	6a 00                	push   $0x0
  802dae:	6a 00                	push   $0x0
  802db0:	6a 00                	push   $0x0
  802db2:	6a 0e                	push   $0xe
  802db4:	e8 fd fd ff ff       	call   802bb6 <syscall>
  802db9:	83 c4 18             	add    $0x18,%esp
}
  802dbc:	c9                   	leave  
  802dbd:	c3                   	ret    

00802dbe <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802dbe:	55                   	push   %ebp
  802dbf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802dc1:	6a 00                	push   $0x0
  802dc3:	6a 00                	push   $0x0
  802dc5:	6a 00                	push   $0x0
  802dc7:	6a 00                	push   $0x0
  802dc9:	ff 75 08             	pushl  0x8(%ebp)
  802dcc:	6a 0f                	push   $0xf
  802dce:	e8 e3 fd ff ff       	call   802bb6 <syscall>
  802dd3:	83 c4 18             	add    $0x18,%esp
}
  802dd6:	c9                   	leave  
  802dd7:	c3                   	ret    

00802dd8 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802dd8:	55                   	push   %ebp
  802dd9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802ddb:	6a 00                	push   $0x0
  802ddd:	6a 00                	push   $0x0
  802ddf:	6a 00                	push   $0x0
  802de1:	6a 00                	push   $0x0
  802de3:	6a 00                	push   $0x0
  802de5:	6a 10                	push   $0x10
  802de7:	e8 ca fd ff ff       	call   802bb6 <syscall>
  802dec:	83 c4 18             	add    $0x18,%esp
}
  802def:	90                   	nop
  802df0:	c9                   	leave  
  802df1:	c3                   	ret    

00802df2 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802df2:	55                   	push   %ebp
  802df3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802df5:	6a 00                	push   $0x0
  802df7:	6a 00                	push   $0x0
  802df9:	6a 00                	push   $0x0
  802dfb:	6a 00                	push   $0x0
  802dfd:	6a 00                	push   $0x0
  802dff:	6a 14                	push   $0x14
  802e01:	e8 b0 fd ff ff       	call   802bb6 <syscall>
  802e06:	83 c4 18             	add    $0x18,%esp
}
  802e09:	90                   	nop
  802e0a:	c9                   	leave  
  802e0b:	c3                   	ret    

00802e0c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802e0c:	55                   	push   %ebp
  802e0d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802e0f:	6a 00                	push   $0x0
  802e11:	6a 00                	push   $0x0
  802e13:	6a 00                	push   $0x0
  802e15:	6a 00                	push   $0x0
  802e17:	6a 00                	push   $0x0
  802e19:	6a 15                	push   $0x15
  802e1b:	e8 96 fd ff ff       	call   802bb6 <syscall>
  802e20:	83 c4 18             	add    $0x18,%esp
}
  802e23:	90                   	nop
  802e24:	c9                   	leave  
  802e25:	c3                   	ret    

00802e26 <sys_cputc>:


void
sys_cputc(const char c)
{
  802e26:	55                   	push   %ebp
  802e27:	89 e5                	mov    %esp,%ebp
  802e29:	83 ec 04             	sub    $0x4,%esp
  802e2c:	8b 45 08             	mov    0x8(%ebp),%eax
  802e2f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802e32:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802e36:	6a 00                	push   $0x0
  802e38:	6a 00                	push   $0x0
  802e3a:	6a 00                	push   $0x0
  802e3c:	6a 00                	push   $0x0
  802e3e:	50                   	push   %eax
  802e3f:	6a 16                	push   $0x16
  802e41:	e8 70 fd ff ff       	call   802bb6 <syscall>
  802e46:	83 c4 18             	add    $0x18,%esp
}
  802e49:	90                   	nop
  802e4a:	c9                   	leave  
  802e4b:	c3                   	ret    

00802e4c <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802e4c:	55                   	push   %ebp
  802e4d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802e4f:	6a 00                	push   $0x0
  802e51:	6a 00                	push   $0x0
  802e53:	6a 00                	push   $0x0
  802e55:	6a 00                	push   $0x0
  802e57:	6a 00                	push   $0x0
  802e59:	6a 17                	push   $0x17
  802e5b:	e8 56 fd ff ff       	call   802bb6 <syscall>
  802e60:	83 c4 18             	add    $0x18,%esp
}
  802e63:	90                   	nop
  802e64:	c9                   	leave  
  802e65:	c3                   	ret    

00802e66 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802e66:	55                   	push   %ebp
  802e67:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802e69:	8b 45 08             	mov    0x8(%ebp),%eax
  802e6c:	6a 00                	push   $0x0
  802e6e:	6a 00                	push   $0x0
  802e70:	6a 00                	push   $0x0
  802e72:	ff 75 0c             	pushl  0xc(%ebp)
  802e75:	50                   	push   %eax
  802e76:	6a 18                	push   $0x18
  802e78:	e8 39 fd ff ff       	call   802bb6 <syscall>
  802e7d:	83 c4 18             	add    $0x18,%esp
}
  802e80:	c9                   	leave  
  802e81:	c3                   	ret    

00802e82 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802e82:	55                   	push   %ebp
  802e83:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802e85:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e88:	8b 45 08             	mov    0x8(%ebp),%eax
  802e8b:	6a 00                	push   $0x0
  802e8d:	6a 00                	push   $0x0
  802e8f:	6a 00                	push   $0x0
  802e91:	52                   	push   %edx
  802e92:	50                   	push   %eax
  802e93:	6a 1b                	push   $0x1b
  802e95:	e8 1c fd ff ff       	call   802bb6 <syscall>
  802e9a:	83 c4 18             	add    $0x18,%esp
}
  802e9d:	c9                   	leave  
  802e9e:	c3                   	ret    

00802e9f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802e9f:	55                   	push   %ebp
  802ea0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802ea2:	8b 55 0c             	mov    0xc(%ebp),%edx
  802ea5:	8b 45 08             	mov    0x8(%ebp),%eax
  802ea8:	6a 00                	push   $0x0
  802eaa:	6a 00                	push   $0x0
  802eac:	6a 00                	push   $0x0
  802eae:	52                   	push   %edx
  802eaf:	50                   	push   %eax
  802eb0:	6a 19                	push   $0x19
  802eb2:	e8 ff fc ff ff       	call   802bb6 <syscall>
  802eb7:	83 c4 18             	add    $0x18,%esp
}
  802eba:	90                   	nop
  802ebb:	c9                   	leave  
  802ebc:	c3                   	ret    

00802ebd <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802ebd:	55                   	push   %ebp
  802ebe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802ec0:	8b 55 0c             	mov    0xc(%ebp),%edx
  802ec3:	8b 45 08             	mov    0x8(%ebp),%eax
  802ec6:	6a 00                	push   $0x0
  802ec8:	6a 00                	push   $0x0
  802eca:	6a 00                	push   $0x0
  802ecc:	52                   	push   %edx
  802ecd:	50                   	push   %eax
  802ece:	6a 1a                	push   $0x1a
  802ed0:	e8 e1 fc ff ff       	call   802bb6 <syscall>
  802ed5:	83 c4 18             	add    $0x18,%esp
}
  802ed8:	90                   	nop
  802ed9:	c9                   	leave  
  802eda:	c3                   	ret    

00802edb <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802edb:	55                   	push   %ebp
  802edc:	89 e5                	mov    %esp,%ebp
  802ede:	83 ec 04             	sub    $0x4,%esp
  802ee1:	8b 45 10             	mov    0x10(%ebp),%eax
  802ee4:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802ee7:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802eea:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802eee:	8b 45 08             	mov    0x8(%ebp),%eax
  802ef1:	6a 00                	push   $0x0
  802ef3:	51                   	push   %ecx
  802ef4:	52                   	push   %edx
  802ef5:	ff 75 0c             	pushl  0xc(%ebp)
  802ef8:	50                   	push   %eax
  802ef9:	6a 1c                	push   $0x1c
  802efb:	e8 b6 fc ff ff       	call   802bb6 <syscall>
  802f00:	83 c4 18             	add    $0x18,%esp
}
  802f03:	c9                   	leave  
  802f04:	c3                   	ret    

00802f05 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802f05:	55                   	push   %ebp
  802f06:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802f08:	8b 55 0c             	mov    0xc(%ebp),%edx
  802f0b:	8b 45 08             	mov    0x8(%ebp),%eax
  802f0e:	6a 00                	push   $0x0
  802f10:	6a 00                	push   $0x0
  802f12:	6a 00                	push   $0x0
  802f14:	52                   	push   %edx
  802f15:	50                   	push   %eax
  802f16:	6a 1d                	push   $0x1d
  802f18:	e8 99 fc ff ff       	call   802bb6 <syscall>
  802f1d:	83 c4 18             	add    $0x18,%esp
}
  802f20:	c9                   	leave  
  802f21:	c3                   	ret    

00802f22 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802f22:	55                   	push   %ebp
  802f23:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802f25:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802f28:	8b 55 0c             	mov    0xc(%ebp),%edx
  802f2b:	8b 45 08             	mov    0x8(%ebp),%eax
  802f2e:	6a 00                	push   $0x0
  802f30:	6a 00                	push   $0x0
  802f32:	51                   	push   %ecx
  802f33:	52                   	push   %edx
  802f34:	50                   	push   %eax
  802f35:	6a 1e                	push   $0x1e
  802f37:	e8 7a fc ff ff       	call   802bb6 <syscall>
  802f3c:	83 c4 18             	add    $0x18,%esp
}
  802f3f:	c9                   	leave  
  802f40:	c3                   	ret    

00802f41 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802f41:	55                   	push   %ebp
  802f42:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802f44:	8b 55 0c             	mov    0xc(%ebp),%edx
  802f47:	8b 45 08             	mov    0x8(%ebp),%eax
  802f4a:	6a 00                	push   $0x0
  802f4c:	6a 00                	push   $0x0
  802f4e:	6a 00                	push   $0x0
  802f50:	52                   	push   %edx
  802f51:	50                   	push   %eax
  802f52:	6a 1f                	push   $0x1f
  802f54:	e8 5d fc ff ff       	call   802bb6 <syscall>
  802f59:	83 c4 18             	add    $0x18,%esp
}
  802f5c:	c9                   	leave  
  802f5d:	c3                   	ret    

00802f5e <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802f5e:	55                   	push   %ebp
  802f5f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802f61:	6a 00                	push   $0x0
  802f63:	6a 00                	push   $0x0
  802f65:	6a 00                	push   $0x0
  802f67:	6a 00                	push   $0x0
  802f69:	6a 00                	push   $0x0
  802f6b:	6a 20                	push   $0x20
  802f6d:	e8 44 fc ff ff       	call   802bb6 <syscall>
  802f72:	83 c4 18             	add    $0x18,%esp
}
  802f75:	c9                   	leave  
  802f76:	c3                   	ret    

00802f77 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802f77:	55                   	push   %ebp
  802f78:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802f7a:	8b 45 08             	mov    0x8(%ebp),%eax
  802f7d:	6a 00                	push   $0x0
  802f7f:	ff 75 14             	pushl  0x14(%ebp)
  802f82:	ff 75 10             	pushl  0x10(%ebp)
  802f85:	ff 75 0c             	pushl  0xc(%ebp)
  802f88:	50                   	push   %eax
  802f89:	6a 21                	push   $0x21
  802f8b:	e8 26 fc ff ff       	call   802bb6 <syscall>
  802f90:	83 c4 18             	add    $0x18,%esp
}
  802f93:	c9                   	leave  
  802f94:	c3                   	ret    

00802f95 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802f95:	55                   	push   %ebp
  802f96:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802f98:	8b 45 08             	mov    0x8(%ebp),%eax
  802f9b:	6a 00                	push   $0x0
  802f9d:	6a 00                	push   $0x0
  802f9f:	6a 00                	push   $0x0
  802fa1:	6a 00                	push   $0x0
  802fa3:	50                   	push   %eax
  802fa4:	6a 22                	push   $0x22
  802fa6:	e8 0b fc ff ff       	call   802bb6 <syscall>
  802fab:	83 c4 18             	add    $0x18,%esp
}
  802fae:	90                   	nop
  802faf:	c9                   	leave  
  802fb0:	c3                   	ret    

00802fb1 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802fb1:	55                   	push   %ebp
  802fb2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  802fb7:	6a 00                	push   $0x0
  802fb9:	6a 00                	push   $0x0
  802fbb:	6a 00                	push   $0x0
  802fbd:	6a 00                	push   $0x0
  802fbf:	50                   	push   %eax
  802fc0:	6a 23                	push   $0x23
  802fc2:	e8 ef fb ff ff       	call   802bb6 <syscall>
  802fc7:	83 c4 18             	add    $0x18,%esp
}
  802fca:	90                   	nop
  802fcb:	c9                   	leave  
  802fcc:	c3                   	ret    

00802fcd <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802fcd:	55                   	push   %ebp
  802fce:	89 e5                	mov    %esp,%ebp
  802fd0:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802fd3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802fd6:	8d 50 04             	lea    0x4(%eax),%edx
  802fd9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802fdc:	6a 00                	push   $0x0
  802fde:	6a 00                	push   $0x0
  802fe0:	6a 00                	push   $0x0
  802fe2:	52                   	push   %edx
  802fe3:	50                   	push   %eax
  802fe4:	6a 24                	push   $0x24
  802fe6:	e8 cb fb ff ff       	call   802bb6 <syscall>
  802feb:	83 c4 18             	add    $0x18,%esp
	return result;
  802fee:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802ff1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802ff4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802ff7:	89 01                	mov    %eax,(%ecx)
  802ff9:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802ffc:	8b 45 08             	mov    0x8(%ebp),%eax
  802fff:	c9                   	leave  
  803000:	c2 04 00             	ret    $0x4

00803003 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  803003:	55                   	push   %ebp
  803004:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  803006:	6a 00                	push   $0x0
  803008:	6a 00                	push   $0x0
  80300a:	ff 75 10             	pushl  0x10(%ebp)
  80300d:	ff 75 0c             	pushl  0xc(%ebp)
  803010:	ff 75 08             	pushl  0x8(%ebp)
  803013:	6a 13                	push   $0x13
  803015:	e8 9c fb ff ff       	call   802bb6 <syscall>
  80301a:	83 c4 18             	add    $0x18,%esp
	return ;
  80301d:	90                   	nop
}
  80301e:	c9                   	leave  
  80301f:	c3                   	ret    

00803020 <sys_rcr2>:
uint32 sys_rcr2()
{
  803020:	55                   	push   %ebp
  803021:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  803023:	6a 00                	push   $0x0
  803025:	6a 00                	push   $0x0
  803027:	6a 00                	push   $0x0
  803029:	6a 00                	push   $0x0
  80302b:	6a 00                	push   $0x0
  80302d:	6a 25                	push   $0x25
  80302f:	e8 82 fb ff ff       	call   802bb6 <syscall>
  803034:	83 c4 18             	add    $0x18,%esp
}
  803037:	c9                   	leave  
  803038:	c3                   	ret    

00803039 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  803039:	55                   	push   %ebp
  80303a:	89 e5                	mov    %esp,%ebp
  80303c:	83 ec 04             	sub    $0x4,%esp
  80303f:	8b 45 08             	mov    0x8(%ebp),%eax
  803042:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  803045:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  803049:	6a 00                	push   $0x0
  80304b:	6a 00                	push   $0x0
  80304d:	6a 00                	push   $0x0
  80304f:	6a 00                	push   $0x0
  803051:	50                   	push   %eax
  803052:	6a 26                	push   $0x26
  803054:	e8 5d fb ff ff       	call   802bb6 <syscall>
  803059:	83 c4 18             	add    $0x18,%esp
	return ;
  80305c:	90                   	nop
}
  80305d:	c9                   	leave  
  80305e:	c3                   	ret    

0080305f <rsttst>:
void rsttst()
{
  80305f:	55                   	push   %ebp
  803060:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  803062:	6a 00                	push   $0x0
  803064:	6a 00                	push   $0x0
  803066:	6a 00                	push   $0x0
  803068:	6a 00                	push   $0x0
  80306a:	6a 00                	push   $0x0
  80306c:	6a 28                	push   $0x28
  80306e:	e8 43 fb ff ff       	call   802bb6 <syscall>
  803073:	83 c4 18             	add    $0x18,%esp
	return ;
  803076:	90                   	nop
}
  803077:	c9                   	leave  
  803078:	c3                   	ret    

00803079 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  803079:	55                   	push   %ebp
  80307a:	89 e5                	mov    %esp,%ebp
  80307c:	83 ec 04             	sub    $0x4,%esp
  80307f:	8b 45 14             	mov    0x14(%ebp),%eax
  803082:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  803085:	8b 55 18             	mov    0x18(%ebp),%edx
  803088:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80308c:	52                   	push   %edx
  80308d:	50                   	push   %eax
  80308e:	ff 75 10             	pushl  0x10(%ebp)
  803091:	ff 75 0c             	pushl  0xc(%ebp)
  803094:	ff 75 08             	pushl  0x8(%ebp)
  803097:	6a 27                	push   $0x27
  803099:	e8 18 fb ff ff       	call   802bb6 <syscall>
  80309e:	83 c4 18             	add    $0x18,%esp
	return ;
  8030a1:	90                   	nop
}
  8030a2:	c9                   	leave  
  8030a3:	c3                   	ret    

008030a4 <chktst>:
void chktst(uint32 n)
{
  8030a4:	55                   	push   %ebp
  8030a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8030a7:	6a 00                	push   $0x0
  8030a9:	6a 00                	push   $0x0
  8030ab:	6a 00                	push   $0x0
  8030ad:	6a 00                	push   $0x0
  8030af:	ff 75 08             	pushl  0x8(%ebp)
  8030b2:	6a 29                	push   $0x29
  8030b4:	e8 fd fa ff ff       	call   802bb6 <syscall>
  8030b9:	83 c4 18             	add    $0x18,%esp
	return ;
  8030bc:	90                   	nop
}
  8030bd:	c9                   	leave  
  8030be:	c3                   	ret    

008030bf <inctst>:

void inctst()
{
  8030bf:	55                   	push   %ebp
  8030c0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8030c2:	6a 00                	push   $0x0
  8030c4:	6a 00                	push   $0x0
  8030c6:	6a 00                	push   $0x0
  8030c8:	6a 00                	push   $0x0
  8030ca:	6a 00                	push   $0x0
  8030cc:	6a 2a                	push   $0x2a
  8030ce:	e8 e3 fa ff ff       	call   802bb6 <syscall>
  8030d3:	83 c4 18             	add    $0x18,%esp
	return ;
  8030d6:	90                   	nop
}
  8030d7:	c9                   	leave  
  8030d8:	c3                   	ret    

008030d9 <gettst>:
uint32 gettst()
{
  8030d9:	55                   	push   %ebp
  8030da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8030dc:	6a 00                	push   $0x0
  8030de:	6a 00                	push   $0x0
  8030e0:	6a 00                	push   $0x0
  8030e2:	6a 00                	push   $0x0
  8030e4:	6a 00                	push   $0x0
  8030e6:	6a 2b                	push   $0x2b
  8030e8:	e8 c9 fa ff ff       	call   802bb6 <syscall>
  8030ed:	83 c4 18             	add    $0x18,%esp
}
  8030f0:	c9                   	leave  
  8030f1:	c3                   	ret    

008030f2 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8030f2:	55                   	push   %ebp
  8030f3:	89 e5                	mov    %esp,%ebp
  8030f5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8030f8:	6a 00                	push   $0x0
  8030fa:	6a 00                	push   $0x0
  8030fc:	6a 00                	push   $0x0
  8030fe:	6a 00                	push   $0x0
  803100:	6a 00                	push   $0x0
  803102:	6a 2c                	push   $0x2c
  803104:	e8 ad fa ff ff       	call   802bb6 <syscall>
  803109:	83 c4 18             	add    $0x18,%esp
  80310c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80310f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  803113:	75 07                	jne    80311c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  803115:	b8 01 00 00 00       	mov    $0x1,%eax
  80311a:	eb 05                	jmp    803121 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80311c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  803121:	c9                   	leave  
  803122:	c3                   	ret    

00803123 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  803123:	55                   	push   %ebp
  803124:	89 e5                	mov    %esp,%ebp
  803126:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  803129:	6a 00                	push   $0x0
  80312b:	6a 00                	push   $0x0
  80312d:	6a 00                	push   $0x0
  80312f:	6a 00                	push   $0x0
  803131:	6a 00                	push   $0x0
  803133:	6a 2c                	push   $0x2c
  803135:	e8 7c fa ff ff       	call   802bb6 <syscall>
  80313a:	83 c4 18             	add    $0x18,%esp
  80313d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  803140:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  803144:	75 07                	jne    80314d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  803146:	b8 01 00 00 00       	mov    $0x1,%eax
  80314b:	eb 05                	jmp    803152 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80314d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  803152:	c9                   	leave  
  803153:	c3                   	ret    

00803154 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  803154:	55                   	push   %ebp
  803155:	89 e5                	mov    %esp,%ebp
  803157:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80315a:	6a 00                	push   $0x0
  80315c:	6a 00                	push   $0x0
  80315e:	6a 00                	push   $0x0
  803160:	6a 00                	push   $0x0
  803162:	6a 00                	push   $0x0
  803164:	6a 2c                	push   $0x2c
  803166:	e8 4b fa ff ff       	call   802bb6 <syscall>
  80316b:	83 c4 18             	add    $0x18,%esp
  80316e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  803171:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  803175:	75 07                	jne    80317e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  803177:	b8 01 00 00 00       	mov    $0x1,%eax
  80317c:	eb 05                	jmp    803183 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80317e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  803183:	c9                   	leave  
  803184:	c3                   	ret    

00803185 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  803185:	55                   	push   %ebp
  803186:	89 e5                	mov    %esp,%ebp
  803188:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80318b:	6a 00                	push   $0x0
  80318d:	6a 00                	push   $0x0
  80318f:	6a 00                	push   $0x0
  803191:	6a 00                	push   $0x0
  803193:	6a 00                	push   $0x0
  803195:	6a 2c                	push   $0x2c
  803197:	e8 1a fa ff ff       	call   802bb6 <syscall>
  80319c:	83 c4 18             	add    $0x18,%esp
  80319f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8031a2:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8031a6:	75 07                	jne    8031af <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8031a8:	b8 01 00 00 00       	mov    $0x1,%eax
  8031ad:	eb 05                	jmp    8031b4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8031af:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8031b4:	c9                   	leave  
  8031b5:	c3                   	ret    

008031b6 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8031b6:	55                   	push   %ebp
  8031b7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8031b9:	6a 00                	push   $0x0
  8031bb:	6a 00                	push   $0x0
  8031bd:	6a 00                	push   $0x0
  8031bf:	6a 00                	push   $0x0
  8031c1:	ff 75 08             	pushl  0x8(%ebp)
  8031c4:	6a 2d                	push   $0x2d
  8031c6:	e8 eb f9 ff ff       	call   802bb6 <syscall>
  8031cb:	83 c4 18             	add    $0x18,%esp
	return ;
  8031ce:	90                   	nop
}
  8031cf:	c9                   	leave  
  8031d0:	c3                   	ret    

008031d1 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8031d1:	55                   	push   %ebp
  8031d2:	89 e5                	mov    %esp,%ebp
  8031d4:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8031d5:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8031d8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8031db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8031de:	8b 45 08             	mov    0x8(%ebp),%eax
  8031e1:	6a 00                	push   $0x0
  8031e3:	53                   	push   %ebx
  8031e4:	51                   	push   %ecx
  8031e5:	52                   	push   %edx
  8031e6:	50                   	push   %eax
  8031e7:	6a 2e                	push   $0x2e
  8031e9:	e8 c8 f9 ff ff       	call   802bb6 <syscall>
  8031ee:	83 c4 18             	add    $0x18,%esp
}
  8031f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8031f4:	c9                   	leave  
  8031f5:	c3                   	ret    

008031f6 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8031f6:	55                   	push   %ebp
  8031f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8031f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8031fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8031ff:	6a 00                	push   $0x0
  803201:	6a 00                	push   $0x0
  803203:	6a 00                	push   $0x0
  803205:	52                   	push   %edx
  803206:	50                   	push   %eax
  803207:	6a 2f                	push   $0x2f
  803209:	e8 a8 f9 ff ff       	call   802bb6 <syscall>
  80320e:	83 c4 18             	add    $0x18,%esp
}
  803211:	c9                   	leave  
  803212:	c3                   	ret    
  803213:	90                   	nop

00803214 <__udivdi3>:
  803214:	55                   	push   %ebp
  803215:	57                   	push   %edi
  803216:	56                   	push   %esi
  803217:	53                   	push   %ebx
  803218:	83 ec 1c             	sub    $0x1c,%esp
  80321b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80321f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  803223:	8b 7c 24 38          	mov    0x38(%esp),%edi
  803227:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80322b:	89 ca                	mov    %ecx,%edx
  80322d:	89 f8                	mov    %edi,%eax
  80322f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  803233:	85 f6                	test   %esi,%esi
  803235:	75 2d                	jne    803264 <__udivdi3+0x50>
  803237:	39 cf                	cmp    %ecx,%edi
  803239:	77 65                	ja     8032a0 <__udivdi3+0x8c>
  80323b:	89 fd                	mov    %edi,%ebp
  80323d:	85 ff                	test   %edi,%edi
  80323f:	75 0b                	jne    80324c <__udivdi3+0x38>
  803241:	b8 01 00 00 00       	mov    $0x1,%eax
  803246:	31 d2                	xor    %edx,%edx
  803248:	f7 f7                	div    %edi
  80324a:	89 c5                	mov    %eax,%ebp
  80324c:	31 d2                	xor    %edx,%edx
  80324e:	89 c8                	mov    %ecx,%eax
  803250:	f7 f5                	div    %ebp
  803252:	89 c1                	mov    %eax,%ecx
  803254:	89 d8                	mov    %ebx,%eax
  803256:	f7 f5                	div    %ebp
  803258:	89 cf                	mov    %ecx,%edi
  80325a:	89 fa                	mov    %edi,%edx
  80325c:	83 c4 1c             	add    $0x1c,%esp
  80325f:	5b                   	pop    %ebx
  803260:	5e                   	pop    %esi
  803261:	5f                   	pop    %edi
  803262:	5d                   	pop    %ebp
  803263:	c3                   	ret    
  803264:	39 ce                	cmp    %ecx,%esi
  803266:	77 28                	ja     803290 <__udivdi3+0x7c>
  803268:	0f bd fe             	bsr    %esi,%edi
  80326b:	83 f7 1f             	xor    $0x1f,%edi
  80326e:	75 40                	jne    8032b0 <__udivdi3+0x9c>
  803270:	39 ce                	cmp    %ecx,%esi
  803272:	72 0a                	jb     80327e <__udivdi3+0x6a>
  803274:	3b 44 24 08          	cmp    0x8(%esp),%eax
  803278:	0f 87 9e 00 00 00    	ja     80331c <__udivdi3+0x108>
  80327e:	b8 01 00 00 00       	mov    $0x1,%eax
  803283:	89 fa                	mov    %edi,%edx
  803285:	83 c4 1c             	add    $0x1c,%esp
  803288:	5b                   	pop    %ebx
  803289:	5e                   	pop    %esi
  80328a:	5f                   	pop    %edi
  80328b:	5d                   	pop    %ebp
  80328c:	c3                   	ret    
  80328d:	8d 76 00             	lea    0x0(%esi),%esi
  803290:	31 ff                	xor    %edi,%edi
  803292:	31 c0                	xor    %eax,%eax
  803294:	89 fa                	mov    %edi,%edx
  803296:	83 c4 1c             	add    $0x1c,%esp
  803299:	5b                   	pop    %ebx
  80329a:	5e                   	pop    %esi
  80329b:	5f                   	pop    %edi
  80329c:	5d                   	pop    %ebp
  80329d:	c3                   	ret    
  80329e:	66 90                	xchg   %ax,%ax
  8032a0:	89 d8                	mov    %ebx,%eax
  8032a2:	f7 f7                	div    %edi
  8032a4:	31 ff                	xor    %edi,%edi
  8032a6:	89 fa                	mov    %edi,%edx
  8032a8:	83 c4 1c             	add    $0x1c,%esp
  8032ab:	5b                   	pop    %ebx
  8032ac:	5e                   	pop    %esi
  8032ad:	5f                   	pop    %edi
  8032ae:	5d                   	pop    %ebp
  8032af:	c3                   	ret    
  8032b0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8032b5:	89 eb                	mov    %ebp,%ebx
  8032b7:	29 fb                	sub    %edi,%ebx
  8032b9:	89 f9                	mov    %edi,%ecx
  8032bb:	d3 e6                	shl    %cl,%esi
  8032bd:	89 c5                	mov    %eax,%ebp
  8032bf:	88 d9                	mov    %bl,%cl
  8032c1:	d3 ed                	shr    %cl,%ebp
  8032c3:	89 e9                	mov    %ebp,%ecx
  8032c5:	09 f1                	or     %esi,%ecx
  8032c7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8032cb:	89 f9                	mov    %edi,%ecx
  8032cd:	d3 e0                	shl    %cl,%eax
  8032cf:	89 c5                	mov    %eax,%ebp
  8032d1:	89 d6                	mov    %edx,%esi
  8032d3:	88 d9                	mov    %bl,%cl
  8032d5:	d3 ee                	shr    %cl,%esi
  8032d7:	89 f9                	mov    %edi,%ecx
  8032d9:	d3 e2                	shl    %cl,%edx
  8032db:	8b 44 24 08          	mov    0x8(%esp),%eax
  8032df:	88 d9                	mov    %bl,%cl
  8032e1:	d3 e8                	shr    %cl,%eax
  8032e3:	09 c2                	or     %eax,%edx
  8032e5:	89 d0                	mov    %edx,%eax
  8032e7:	89 f2                	mov    %esi,%edx
  8032e9:	f7 74 24 0c          	divl   0xc(%esp)
  8032ed:	89 d6                	mov    %edx,%esi
  8032ef:	89 c3                	mov    %eax,%ebx
  8032f1:	f7 e5                	mul    %ebp
  8032f3:	39 d6                	cmp    %edx,%esi
  8032f5:	72 19                	jb     803310 <__udivdi3+0xfc>
  8032f7:	74 0b                	je     803304 <__udivdi3+0xf0>
  8032f9:	89 d8                	mov    %ebx,%eax
  8032fb:	31 ff                	xor    %edi,%edi
  8032fd:	e9 58 ff ff ff       	jmp    80325a <__udivdi3+0x46>
  803302:	66 90                	xchg   %ax,%ax
  803304:	8b 54 24 08          	mov    0x8(%esp),%edx
  803308:	89 f9                	mov    %edi,%ecx
  80330a:	d3 e2                	shl    %cl,%edx
  80330c:	39 c2                	cmp    %eax,%edx
  80330e:	73 e9                	jae    8032f9 <__udivdi3+0xe5>
  803310:	8d 43 ff             	lea    -0x1(%ebx),%eax
  803313:	31 ff                	xor    %edi,%edi
  803315:	e9 40 ff ff ff       	jmp    80325a <__udivdi3+0x46>
  80331a:	66 90                	xchg   %ax,%ax
  80331c:	31 c0                	xor    %eax,%eax
  80331e:	e9 37 ff ff ff       	jmp    80325a <__udivdi3+0x46>
  803323:	90                   	nop

00803324 <__umoddi3>:
  803324:	55                   	push   %ebp
  803325:	57                   	push   %edi
  803326:	56                   	push   %esi
  803327:	53                   	push   %ebx
  803328:	83 ec 1c             	sub    $0x1c,%esp
  80332b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80332f:	8b 74 24 34          	mov    0x34(%esp),%esi
  803333:	8b 7c 24 38          	mov    0x38(%esp),%edi
  803337:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80333b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80333f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  803343:	89 f3                	mov    %esi,%ebx
  803345:	89 fa                	mov    %edi,%edx
  803347:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80334b:	89 34 24             	mov    %esi,(%esp)
  80334e:	85 c0                	test   %eax,%eax
  803350:	75 1a                	jne    80336c <__umoddi3+0x48>
  803352:	39 f7                	cmp    %esi,%edi
  803354:	0f 86 a2 00 00 00    	jbe    8033fc <__umoddi3+0xd8>
  80335a:	89 c8                	mov    %ecx,%eax
  80335c:	89 f2                	mov    %esi,%edx
  80335e:	f7 f7                	div    %edi
  803360:	89 d0                	mov    %edx,%eax
  803362:	31 d2                	xor    %edx,%edx
  803364:	83 c4 1c             	add    $0x1c,%esp
  803367:	5b                   	pop    %ebx
  803368:	5e                   	pop    %esi
  803369:	5f                   	pop    %edi
  80336a:	5d                   	pop    %ebp
  80336b:	c3                   	ret    
  80336c:	39 f0                	cmp    %esi,%eax
  80336e:	0f 87 ac 00 00 00    	ja     803420 <__umoddi3+0xfc>
  803374:	0f bd e8             	bsr    %eax,%ebp
  803377:	83 f5 1f             	xor    $0x1f,%ebp
  80337a:	0f 84 ac 00 00 00    	je     80342c <__umoddi3+0x108>
  803380:	bf 20 00 00 00       	mov    $0x20,%edi
  803385:	29 ef                	sub    %ebp,%edi
  803387:	89 fe                	mov    %edi,%esi
  803389:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80338d:	89 e9                	mov    %ebp,%ecx
  80338f:	d3 e0                	shl    %cl,%eax
  803391:	89 d7                	mov    %edx,%edi
  803393:	89 f1                	mov    %esi,%ecx
  803395:	d3 ef                	shr    %cl,%edi
  803397:	09 c7                	or     %eax,%edi
  803399:	89 e9                	mov    %ebp,%ecx
  80339b:	d3 e2                	shl    %cl,%edx
  80339d:	89 14 24             	mov    %edx,(%esp)
  8033a0:	89 d8                	mov    %ebx,%eax
  8033a2:	d3 e0                	shl    %cl,%eax
  8033a4:	89 c2                	mov    %eax,%edx
  8033a6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8033aa:	d3 e0                	shl    %cl,%eax
  8033ac:	89 44 24 04          	mov    %eax,0x4(%esp)
  8033b0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8033b4:	89 f1                	mov    %esi,%ecx
  8033b6:	d3 e8                	shr    %cl,%eax
  8033b8:	09 d0                	or     %edx,%eax
  8033ba:	d3 eb                	shr    %cl,%ebx
  8033bc:	89 da                	mov    %ebx,%edx
  8033be:	f7 f7                	div    %edi
  8033c0:	89 d3                	mov    %edx,%ebx
  8033c2:	f7 24 24             	mull   (%esp)
  8033c5:	89 c6                	mov    %eax,%esi
  8033c7:	89 d1                	mov    %edx,%ecx
  8033c9:	39 d3                	cmp    %edx,%ebx
  8033cb:	0f 82 87 00 00 00    	jb     803458 <__umoddi3+0x134>
  8033d1:	0f 84 91 00 00 00    	je     803468 <__umoddi3+0x144>
  8033d7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8033db:	29 f2                	sub    %esi,%edx
  8033dd:	19 cb                	sbb    %ecx,%ebx
  8033df:	89 d8                	mov    %ebx,%eax
  8033e1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8033e5:	d3 e0                	shl    %cl,%eax
  8033e7:	89 e9                	mov    %ebp,%ecx
  8033e9:	d3 ea                	shr    %cl,%edx
  8033eb:	09 d0                	or     %edx,%eax
  8033ed:	89 e9                	mov    %ebp,%ecx
  8033ef:	d3 eb                	shr    %cl,%ebx
  8033f1:	89 da                	mov    %ebx,%edx
  8033f3:	83 c4 1c             	add    $0x1c,%esp
  8033f6:	5b                   	pop    %ebx
  8033f7:	5e                   	pop    %esi
  8033f8:	5f                   	pop    %edi
  8033f9:	5d                   	pop    %ebp
  8033fa:	c3                   	ret    
  8033fb:	90                   	nop
  8033fc:	89 fd                	mov    %edi,%ebp
  8033fe:	85 ff                	test   %edi,%edi
  803400:	75 0b                	jne    80340d <__umoddi3+0xe9>
  803402:	b8 01 00 00 00       	mov    $0x1,%eax
  803407:	31 d2                	xor    %edx,%edx
  803409:	f7 f7                	div    %edi
  80340b:	89 c5                	mov    %eax,%ebp
  80340d:	89 f0                	mov    %esi,%eax
  80340f:	31 d2                	xor    %edx,%edx
  803411:	f7 f5                	div    %ebp
  803413:	89 c8                	mov    %ecx,%eax
  803415:	f7 f5                	div    %ebp
  803417:	89 d0                	mov    %edx,%eax
  803419:	e9 44 ff ff ff       	jmp    803362 <__umoddi3+0x3e>
  80341e:	66 90                	xchg   %ax,%ax
  803420:	89 c8                	mov    %ecx,%eax
  803422:	89 f2                	mov    %esi,%edx
  803424:	83 c4 1c             	add    $0x1c,%esp
  803427:	5b                   	pop    %ebx
  803428:	5e                   	pop    %esi
  803429:	5f                   	pop    %edi
  80342a:	5d                   	pop    %ebp
  80342b:	c3                   	ret    
  80342c:	3b 04 24             	cmp    (%esp),%eax
  80342f:	72 06                	jb     803437 <__umoddi3+0x113>
  803431:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  803435:	77 0f                	ja     803446 <__umoddi3+0x122>
  803437:	89 f2                	mov    %esi,%edx
  803439:	29 f9                	sub    %edi,%ecx
  80343b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80343f:	89 14 24             	mov    %edx,(%esp)
  803442:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  803446:	8b 44 24 04          	mov    0x4(%esp),%eax
  80344a:	8b 14 24             	mov    (%esp),%edx
  80344d:	83 c4 1c             	add    $0x1c,%esp
  803450:	5b                   	pop    %ebx
  803451:	5e                   	pop    %esi
  803452:	5f                   	pop    %edi
  803453:	5d                   	pop    %ebp
  803454:	c3                   	ret    
  803455:	8d 76 00             	lea    0x0(%esi),%esi
  803458:	2b 04 24             	sub    (%esp),%eax
  80345b:	19 fa                	sbb    %edi,%edx
  80345d:	89 d1                	mov    %edx,%ecx
  80345f:	89 c6                	mov    %eax,%esi
  803461:	e9 71 ff ff ff       	jmp    8033d7 <__umoddi3+0xb3>
  803466:	66 90                	xchg   %ax,%ax
  803468:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80346c:	72 ea                	jb     803458 <__umoddi3+0x134>
  80346e:	89 d9                	mov    %ebx,%ecx
  803470:	e9 62 ff ff ff       	jmp    8033d7 <__umoddi3+0xb3>
