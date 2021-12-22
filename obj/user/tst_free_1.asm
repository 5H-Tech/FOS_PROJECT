
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
  800031:	e8 6a 16 00 00       	call   8016a0 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
	short b;
	int c;
};

void _main(void)
{
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

		cprintf("PWS size = %d\n",LIST_SIZE(&(myEnv->PageWorkingSetList)) );
  800047:	a1 20 40 80 00       	mov    0x804020,%eax
  80004c:	8b 80 9c 3c 01 00    	mov    0x13c9c(%eax),%eax
  800052:	83 ec 08             	sub    $0x8,%esp
  800055:	50                   	push   %eax
  800056:	68 60 34 80 00       	push   $0x803460
  80005b:	e8 27 1a 00 00       	call   801a87 <cprintf>
  800060:	83 c4 10             	add    $0x10,%esp
		if (LIST_SIZE(&(myEnv->PageWorkingSetList)) > 0)
  800063:	a1 20 40 80 00       	mov    0x804020,%eax
  800068:	8b 80 9c 3c 01 00    	mov    0x13c9c(%eax),%eax
  80006e:	85 c0                	test   %eax,%eax
  800070:	74 04                	je     800076 <_main+0x3e>
		{
			fullWS = 0;
  800072:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
		}
		if (fullWS) panic("Please increase the WS size");
  800076:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  80007a:	74 14                	je     800090 <_main+0x58>
  80007c:	83 ec 04             	sub    $0x4,%esp
  80007f:	68 6f 34 80 00       	push   $0x80346f
  800084:	6a 20                	push   $0x20
  800086:	68 8b 34 80 00       	push   $0x80348b
  80008b:	e8 55 17 00 00       	call   8017e5 <_panic>
	}



	int Mega = 1024*1024;
  800090:	c7 45 e0 00 00 10 00 	movl   $0x100000,-0x20(%ebp)
	int kilo = 1024;
  800097:	c7 45 dc 00 04 00 00 	movl   $0x400,-0x24(%ebp)
	char minByte = 1<<7;
  80009e:	c6 45 db 80          	movb   $0x80,-0x25(%ebp)
	char maxByte = 0x7F;
  8000a2:	c6 45 da 7f          	movb   $0x7f,-0x26(%ebp)
	short minShort = 1<<15 ;
  8000a6:	66 c7 45 d8 00 80    	movw   $0x8000,-0x28(%ebp)
	short maxShort = 0x7FFF;
  8000ac:	66 c7 45 d6 ff 7f    	movw   $0x7fff,-0x2a(%ebp)
	int minInt = 1<<31 ;
  8000b2:	c7 45 d0 00 00 00 80 	movl   $0x80000000,-0x30(%ebp)
	int maxInt = 0x7FFFFFFF;
  8000b9:	c7 45 cc ff ff ff 7f 	movl   $0x7fffffff,-0x34(%ebp)
	char *byteArr, *byteArr2 , *byteArr3;
	short *shortArr, *shortArr2 ;
	int *intArr;
	struct MyStruct *structArr ;
	int lastIndexOfByte, lastIndexOfByte2, lastIndexOfShort, lastIndexOfShort2, lastIndexOfInt, lastIndexOfStruct;
	int start_freeFrames = sys_calculate_free_frames() ;
  8000c0:	e8 32 2c 00 00       	call   802cf7 <sys_calculate_free_frames>
  8000c5:	89 45 c8             	mov    %eax,-0x38(%ebp)
	int toAccess = 800 - LIST_SIZE(&myEnv->ActiveList) - 8;
  8000c8:	a1 20 40 80 00       	mov    0x804020,%eax
  8000cd:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  8000d3:	ba 18 03 00 00       	mov    $0x318,%edx
  8000d8:	29 c2                	sub    %eax,%edx
  8000da:	89 d0                	mov    %edx,%eax
  8000dc:	89 45 c4             	mov    %eax,-0x3c(%ebp)

	void* ptr_allocations[20] = {0};
  8000df:	8d 95 c8 fe ff ff    	lea    -0x138(%ebp),%edx
  8000e5:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000ea:	b8 00 00 00 00       	mov    $0x0,%eax
  8000ef:	89 d7                	mov    %edx,%edi
  8000f1:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		//2 MB
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8000f3:	e8 82 2c 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  8000f8:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000fe:	01 c0                	add    %eax,%eax
  800100:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800103:	83 ec 0c             	sub    $0xc,%esp
  800106:	50                   	push   %eax
  800107:	e8 05 27 00 00       	call   802811 <malloc>
  80010c:	83 c4 10             	add    $0x10,%esp
  80010f:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)

		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800115:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  80011b:	85 c0                	test   %eax,%eax
  80011d:	79 0d                	jns    80012c <_main+0xf4>
  80011f:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  800125:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  80012a:	76 14                	jbe    800140 <_main+0x108>
  80012c:	83 ec 04             	sub    $0x4,%esp
  80012f:	68 a0 34 80 00       	push   $0x8034a0
  800134:	6a 3c                	push   $0x3c
  800136:	68 8b 34 80 00       	push   $0x80348b
  80013b:	e8 a5 16 00 00       	call   8017e5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800140:	e8 35 2c 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  800145:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800148:	3d 00 02 00 00       	cmp    $0x200,%eax
  80014d:	74 14                	je     800163 <_main+0x12b>
  80014f:	83 ec 04             	sub    $0x4,%esp
  800152:	68 08 35 80 00       	push   $0x803508
  800157:	6a 3d                	push   $0x3d
  800159:	68 8b 34 80 00       	push   $0x80348b
  80015e:	e8 82 16 00 00       	call   8017e5 <_panic>
		int freeFrames = sys_calculate_free_frames() ;
  800163:	e8 8f 2b 00 00       	call   802cf7 <sys_calculate_free_frames>
  800168:	89 45 bc             	mov    %eax,-0x44(%ebp)

		lastIndexOfByte = (2*Mega-kilo)/sizeof(char) - 1;
  80016b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80016e:	01 c0                	add    %eax,%eax
  800170:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800173:	48                   	dec    %eax
  800174:	89 45 b8             	mov    %eax,-0x48(%ebp)
		byteArr = (char *) ptr_allocations[0];
  800177:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  80017d:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		byteArr[0] = minByte ;
  800180:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800183:	8a 55 db             	mov    -0x25(%ebp),%dl
  800186:	88 10                	mov    %dl,(%eax)
		byteArr[lastIndexOfByte] = maxByte ;
  800188:	8b 55 b8             	mov    -0x48(%ebp),%edx
  80018b:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80018e:	01 c2                	add    %eax,%edx
  800190:	8a 45 da             	mov    -0x26(%ebp),%al
  800193:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800195:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  800198:	e8 5a 2b 00 00       	call   802cf7 <sys_calculate_free_frames>
  80019d:	29 c3                	sub    %eax,%ebx
  80019f:	89 d8                	mov    %ebx,%eax
  8001a1:	83 f8 03             	cmp    $0x3,%eax
  8001a4:	74 14                	je     8001ba <_main+0x182>
  8001a6:	83 ec 04             	sub    $0x4,%esp
  8001a9:	68 38 35 80 00       	push   $0x803538
  8001ae:	6a 44                	push   $0x44
  8001b0:	68 8b 34 80 00       	push   $0x80348b
  8001b5:	e8 2b 16 00 00       	call   8017e5 <_panic>
		int var;

		int found = 0;
  8001ba:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)

		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8001c1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8001c8:	eb 76                	jmp    800240 <_main+0x208>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
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
  8001ec:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8001ef:	89 45 ac             	mov    %eax,-0x54(%ebp)
  8001f2:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8001f5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001fa:	39 c2                	cmp    %eax,%edx
  8001fc:	75 03                	jne    800201 <_main+0x1c9>
				found++;
  8001fe:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
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
  800223:	8b 55 b8             	mov    -0x48(%ebp),%edx
  800226:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800229:	01 d0                	add    %edx,%eax
  80022b:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  80022e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800231:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800236:	39 c1                	cmp    %eax,%ecx
  800238:	75 03                	jne    80023d <_main+0x205>
				found++;
  80023a:	ff 45 e8             	incl   -0x18(%ebp)
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		int var;

		int found = 0;

		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80023d:	ff 45 ec             	incl   -0x14(%ebp)
  800240:	a1 20 40 80 00       	mov    0x804020,%eax
  800245:	8b 50 74             	mov    0x74(%eax),%edx
  800248:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80024b:	39 c2                	cmp    %eax,%edx
  80024d:	0f 87 77 ff ff ff    	ja     8001ca <_main+0x192>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800253:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800257:	74 14                	je     80026d <_main+0x235>
  800259:	83 ec 04             	sub    $0x4,%esp
  80025c:	68 7c 35 80 00       	push   $0x80357c
  800261:	6a 50                	push   $0x50
  800263:	68 8b 34 80 00       	push   $0x80348b
  800268:	e8 78 15 00 00       	call   8017e5 <_panic>


		//2 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80026d:	e8 08 2b 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  800272:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  800275:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800278:	01 c0                	add    %eax,%eax
  80027a:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80027d:	83 ec 0c             	sub    $0xc,%esp
  800280:	50                   	push   %eax
  800281:	e8 8b 25 00 00       	call   802811 <malloc>
  800286:	83 c4 10             	add    $0x10,%esp
  800289:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START+ 2*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80028f:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  800295:	89 c2                	mov    %eax,%edx
  800297:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80029a:	01 c0                	add    %eax,%eax
  80029c:	05 00 00 00 80       	add    $0x80000000,%eax
  8002a1:	39 c2                	cmp    %eax,%edx
  8002a3:	72 16                	jb     8002bb <_main+0x283>
  8002a5:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  8002ab:	89 c2                	mov    %eax,%edx
  8002ad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002b0:	01 c0                	add    %eax,%eax
  8002b2:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8002b7:	39 c2                	cmp    %eax,%edx
  8002b9:	76 14                	jbe    8002cf <_main+0x297>
  8002bb:	83 ec 04             	sub    $0x4,%esp
  8002be:	68 a0 34 80 00       	push   $0x8034a0
  8002c3:	6a 56                	push   $0x56
  8002c5:	68 8b 34 80 00       	push   $0x80348b
  8002ca:	e8 16 15 00 00       	call   8017e5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8002cf:	e8 a6 2a 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  8002d4:	2b 45 c0             	sub    -0x40(%ebp),%eax
  8002d7:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002dc:	74 14                	je     8002f2 <_main+0x2ba>
  8002de:	83 ec 04             	sub    $0x4,%esp
  8002e1:	68 08 35 80 00       	push   $0x803508
  8002e6:	6a 57                	push   $0x57
  8002e8:	68 8b 34 80 00       	push   $0x80348b
  8002ed:	e8 f3 14 00 00       	call   8017e5 <_panic>
		freeFrames = sys_calculate_free_frames() ;
  8002f2:	e8 00 2a 00 00       	call   802cf7 <sys_calculate_free_frames>
  8002f7:	89 45 bc             	mov    %eax,-0x44(%ebp)
		shortArr = (short *) ptr_allocations[1];
  8002fa:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  800300:	89 45 a0             	mov    %eax,-0x60(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
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
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  80032d:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  800330:	e8 c2 29 00 00       	call   802cf7 <sys_calculate_free_frames>
  800335:	29 c3                	sub    %eax,%ebx
  800337:	89 d8                	mov    %ebx,%eax
  800339:	83 f8 02             	cmp    $0x2,%eax
  80033c:	74 14                	je     800352 <_main+0x31a>
  80033e:	83 ec 04             	sub    $0x4,%esp
  800341:	68 38 35 80 00       	push   $0x803538
  800346:	6a 5d                	push   $0x5d
  800348:	68 8b 34 80 00       	push   $0x80348b
  80034d:	e8 93 14 00 00       	call   8017e5 <_panic>
		found = 0;
  800352:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800359:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800360:	eb 7a                	jmp    8003dc <_main+0x3a4>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
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
  800384:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800387:	89 45 94             	mov    %eax,-0x6c(%ebp)
  80038a:	8b 45 94             	mov    -0x6c(%ebp),%eax
  80038d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800392:	39 c2                	cmp    %eax,%edx
  800394:	75 03                	jne    800399 <_main+0x361>
				found++;
  800396:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
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
  8003bb:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8003be:	01 c0                	add    %eax,%eax
  8003c0:	89 c1                	mov    %eax,%ecx
  8003c2:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8003c5:	01 c8                	add    %ecx,%eax
  8003c7:	89 45 8c             	mov    %eax,-0x74(%ebp)
  8003ca:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8003cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003d2:	39 c2                	cmp    %eax,%edx
  8003d4:	75 03                	jne    8003d9 <_main+0x3a1>
				found++;
  8003d6:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
		shortArr[0] = minShort;
		shortArr[lastIndexOfShort] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8003d9:	ff 45 ec             	incl   -0x14(%ebp)
  8003dc:	a1 20 40 80 00       	mov    0x804020,%eax
  8003e1:	8b 50 74             	mov    0x74(%eax),%edx
  8003e4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003e7:	39 c2                	cmp    %eax,%edx
  8003e9:	0f 87 73 ff ff ff    	ja     800362 <_main+0x32a>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  8003ef:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8003f3:	74 14                	je     800409 <_main+0x3d1>
  8003f5:	83 ec 04             	sub    $0x4,%esp
  8003f8:	68 7c 35 80 00       	push   $0x80357c
  8003fd:	6a 66                	push   $0x66
  8003ff:	68 8b 34 80 00       	push   $0x80348b
  800404:	e8 dc 13 00 00       	call   8017e5 <_panic>

		//3 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800409:	e8 6c 29 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  80040e:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[2] = malloc(3*kilo);
  800411:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800414:	89 c2                	mov    %eax,%edx
  800416:	01 d2                	add    %edx,%edx
  800418:	01 d0                	add    %edx,%eax
  80041a:	83 ec 0c             	sub    $0xc,%esp
  80041d:	50                   	push   %eax
  80041e:	e8 ee 23 00 00       	call   802811 <malloc>
  800423:	83 c4 10             	add    $0x10,%esp
  800426:	89 85 d0 fe ff ff    	mov    %eax,-0x130(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START+ 4*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80042c:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  800432:	89 c2                	mov    %eax,%edx
  800434:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800437:	c1 e0 02             	shl    $0x2,%eax
  80043a:	05 00 00 00 80       	add    $0x80000000,%eax
  80043f:	39 c2                	cmp    %eax,%edx
  800441:	72 17                	jb     80045a <_main+0x422>
  800443:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  800449:	89 c2                	mov    %eax,%edx
  80044b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80044e:	c1 e0 02             	shl    $0x2,%eax
  800451:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800456:	39 c2                	cmp    %eax,%edx
  800458:	76 14                	jbe    80046e <_main+0x436>
  80045a:	83 ec 04             	sub    $0x4,%esp
  80045d:	68 a0 34 80 00       	push   $0x8034a0
  800462:	6a 6b                	push   $0x6b
  800464:	68 8b 34 80 00       	push   $0x80348b
  800469:	e8 77 13 00 00       	call   8017e5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  80046e:	e8 07 29 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  800473:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800476:	83 f8 01             	cmp    $0x1,%eax
  800479:	74 14                	je     80048f <_main+0x457>
  80047b:	83 ec 04             	sub    $0x4,%esp
  80047e:	68 08 35 80 00       	push   $0x803508
  800483:	6a 6c                	push   $0x6c
  800485:	68 8b 34 80 00       	push   $0x80348b
  80048a:	e8 56 13 00 00       	call   8017e5 <_panic>
		freeFrames = sys_calculate_free_frames() ;
  80048f:	e8 63 28 00 00       	call   802cf7 <sys_calculate_free_frames>
  800494:	89 45 bc             	mov    %eax,-0x44(%ebp)
		intArr = (int *) ptr_allocations[2];
  800497:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  80049d:	89 45 88             	mov    %eax,-0x78(%ebp)
		lastIndexOfInt = (3*kilo)/sizeof(int) - 1;
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
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8004cc:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  8004cf:	e8 23 28 00 00       	call   802cf7 <sys_calculate_free_frames>
  8004d4:	29 c3                	sub    %eax,%ebx
  8004d6:	89 d8                	mov    %ebx,%eax
  8004d8:	83 f8 02             	cmp    $0x2,%eax
  8004db:	74 14                	je     8004f1 <_main+0x4b9>
  8004dd:	83 ec 04             	sub    $0x4,%esp
  8004e0:	68 38 35 80 00       	push   $0x803538
  8004e5:	6a 72                	push   $0x72
  8004e7:	68 8b 34 80 00       	push   $0x80348b
  8004ec:	e8 f4 12 00 00       	call   8017e5 <_panic>
		found = 0;
  8004f1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8004f8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8004ff:	e9 8f 00 00 00       	jmp    800593 <_main+0x55b>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
  800504:	a1 20 40 80 00       	mov    0x804020,%eax
  800509:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80050f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800512:	c1 e2 04             	shl    $0x4,%edx
  800515:	01 d0                	add    %edx,%eax
  800517:	8b 00                	mov    (%eax),%eax
  800519:	89 45 80             	mov    %eax,-0x80(%ebp)
  80051c:	8b 45 80             	mov    -0x80(%ebp),%eax
  80051f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800524:	89 c2                	mov    %eax,%edx
  800526:	8b 45 88             	mov    -0x78(%ebp),%eax
  800529:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  80052f:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800535:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80053a:	39 c2                	cmp    %eax,%edx
  80053c:	75 03                	jne    800541 <_main+0x509>
				found++;
  80053e:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
  800541:	a1 20 40 80 00       	mov    0x804020,%eax
  800546:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80054c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80054f:	c1 e2 04             	shl    $0x4,%edx
  800552:	01 d0                	add    %edx,%eax
  800554:	8b 00                	mov    (%eax),%eax
  800556:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  80055c:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800562:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800567:	89 c2                	mov    %eax,%edx
  800569:	8b 45 84             	mov    -0x7c(%ebp),%eax
  80056c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800573:	8b 45 88             	mov    -0x78(%ebp),%eax
  800576:	01 c8                	add    %ecx,%eax
  800578:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
  80057e:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800584:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800589:	39 c2                	cmp    %eax,%edx
  80058b:	75 03                	jne    800590 <_main+0x558>
				found++;
  80058d:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfInt = (3*kilo)/sizeof(int) - 1;
		intArr[0] = minInt;
		intArr[lastIndexOfInt] = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800590:	ff 45 ec             	incl   -0x14(%ebp)
  800593:	a1 20 40 80 00       	mov    0x804020,%eax
  800598:	8b 50 74             	mov    0x74(%eax),%edx
  80059b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80059e:	39 c2                	cmp    %eax,%edx
  8005a0:	0f 87 5e ff ff ff    	ja     800504 <_main+0x4cc>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  8005a6:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8005aa:	74 14                	je     8005c0 <_main+0x588>
  8005ac:	83 ec 04             	sub    $0x4,%esp
  8005af:	68 7c 35 80 00       	push   $0x80357c
  8005b4:	6a 7b                	push   $0x7b
  8005b6:	68 8b 34 80 00       	push   $0x80348b
  8005bb:	e8 25 12 00 00       	call   8017e5 <_panic>

		//3 KB
		freeFrames = sys_calculate_free_frames() ;
  8005c0:	e8 32 27 00 00       	call   802cf7 <sys_calculate_free_frames>
  8005c5:	89 45 bc             	mov    %eax,-0x44(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8005c8:	e8 ad 27 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  8005cd:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[3] = malloc(3*kilo);
  8005d0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005d3:	89 c2                	mov    %eax,%edx
  8005d5:	01 d2                	add    %edx,%edx
  8005d7:	01 d0                	add    %edx,%eax
  8005d9:	83 ec 0c             	sub    $0xc,%esp
  8005dc:	50                   	push   %eax
  8005dd:	e8 2f 22 00 00       	call   802811 <malloc>
  8005e2:	83 c4 10             	add    $0x10,%esp
  8005e5:	89 85 d4 fe ff ff    	mov    %eax,-0x12c(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START+ 4*Mega + 4*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8005eb:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  8005f1:	89 c2                	mov    %eax,%edx
  8005f3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005f6:	c1 e0 02             	shl    $0x2,%eax
  8005f9:	89 c1                	mov    %eax,%ecx
  8005fb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005fe:	c1 e0 02             	shl    $0x2,%eax
  800601:	01 c8                	add    %ecx,%eax
  800603:	05 00 00 00 80       	add    $0x80000000,%eax
  800608:	39 c2                	cmp    %eax,%edx
  80060a:	72 21                	jb     80062d <_main+0x5f5>
  80060c:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  800612:	89 c2                	mov    %eax,%edx
  800614:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800617:	c1 e0 02             	shl    $0x2,%eax
  80061a:	89 c1                	mov    %eax,%ecx
  80061c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80061f:	c1 e0 02             	shl    $0x2,%eax
  800622:	01 c8                	add    %ecx,%eax
  800624:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800629:	39 c2                	cmp    %eax,%edx
  80062b:	76 17                	jbe    800644 <_main+0x60c>
  80062d:	83 ec 04             	sub    $0x4,%esp
  800630:	68 a0 34 80 00       	push   $0x8034a0
  800635:	68 81 00 00 00       	push   $0x81
  80063a:	68 8b 34 80 00       	push   $0x80348b
  80063f:	e8 a1 11 00 00       	call   8017e5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800644:	e8 31 27 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  800649:	2b 45 c0             	sub    -0x40(%ebp),%eax
  80064c:	83 f8 01             	cmp    $0x1,%eax
  80064f:	74 17                	je     800668 <_main+0x630>
  800651:	83 ec 04             	sub    $0x4,%esp
  800654:	68 08 35 80 00       	push   $0x803508
  800659:	68 82 00 00 00       	push   $0x82
  80065e:	68 8b 34 80 00       	push   $0x80348b
  800663:	e8 7d 11 00 00       	call   8017e5 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800668:	e8 0d 27 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  80066d:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800670:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800673:	89 d0                	mov    %edx,%eax
  800675:	01 c0                	add    %eax,%eax
  800677:	01 d0                	add    %edx,%eax
  800679:	01 c0                	add    %eax,%eax
  80067b:	01 d0                	add    %edx,%eax
  80067d:	83 ec 0c             	sub    $0xc,%esp
  800680:	50                   	push   %eax
  800681:	e8 8b 21 00 00       	call   802811 <malloc>
  800686:	83 c4 10             	add    $0x10,%esp
  800689:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo)|| (uint32) ptr_allocations[4] > (USER_HEAP_START+ 4*Mega + 8*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80068f:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  800695:	89 c2                	mov    %eax,%edx
  800697:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80069a:	c1 e0 02             	shl    $0x2,%eax
  80069d:	89 c1                	mov    %eax,%ecx
  80069f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006a2:	c1 e0 03             	shl    $0x3,%eax
  8006a5:	01 c8                	add    %ecx,%eax
  8006a7:	05 00 00 00 80       	add    $0x80000000,%eax
  8006ac:	39 c2                	cmp    %eax,%edx
  8006ae:	72 21                	jb     8006d1 <_main+0x699>
  8006b0:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  8006b6:	89 c2                	mov    %eax,%edx
  8006b8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006bb:	c1 e0 02             	shl    $0x2,%eax
  8006be:	89 c1                	mov    %eax,%ecx
  8006c0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006c3:	c1 e0 03             	shl    $0x3,%eax
  8006c6:	01 c8                	add    %ecx,%eax
  8006c8:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8006cd:	39 c2                	cmp    %eax,%edx
  8006cf:	76 17                	jbe    8006e8 <_main+0x6b0>
  8006d1:	83 ec 04             	sub    $0x4,%esp
  8006d4:	68 a0 34 80 00       	push   $0x8034a0
  8006d9:	68 88 00 00 00       	push   $0x88
  8006de:	68 8b 34 80 00       	push   $0x80348b
  8006e3:	e8 fd 10 00 00       	call   8017e5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  8006e8:	e8 8d 26 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  8006ed:	2b 45 c0             	sub    -0x40(%ebp),%eax
  8006f0:	83 f8 02             	cmp    $0x2,%eax
  8006f3:	74 17                	je     80070c <_main+0x6d4>
  8006f5:	83 ec 04             	sub    $0x4,%esp
  8006f8:	68 08 35 80 00       	push   $0x803508
  8006fd:	68 89 00 00 00       	push   $0x89
  800702:	68 8b 34 80 00       	push   $0x80348b
  800707:	e8 d9 10 00 00       	call   8017e5 <_panic>
		freeFrames = sys_calculate_free_frames() ;
  80070c:	e8 e6 25 00 00       	call   802cf7 <sys_calculate_free_frames>
  800711:	89 45 bc             	mov    %eax,-0x44(%ebp)
		structArr = (struct MyStruct *) ptr_allocations[4];
  800714:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  80071a:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
  800720:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800723:	89 d0                	mov    %edx,%eax
  800725:	01 c0                	add    %eax,%eax
  800727:	01 d0                	add    %edx,%eax
  800729:	01 c0                	add    %eax,%eax
  80072b:	01 d0                	add    %edx,%eax
  80072d:	c1 e8 03             	shr    $0x3,%eax
  800730:	48                   	dec    %eax
  800731:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
  800737:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80073d:	8a 55 db             	mov    -0x25(%ebp),%dl
  800740:	88 10                	mov    %dl,(%eax)
  800742:	8b 95 70 ff ff ff    	mov    -0x90(%ebp),%edx
  800748:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80074b:	66 89 42 02          	mov    %ax,0x2(%edx)
  80074f:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800755:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800758:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
  80075b:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800761:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800768:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80076e:	01 c2                	add    %eax,%edx
  800770:	8a 45 da             	mov    -0x26(%ebp),%al
  800773:	88 02                	mov    %al,(%edx)
  800775:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80077b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800782:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800788:	01 c2                	add    %eax,%edx
  80078a:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  80078e:	66 89 42 02          	mov    %ax,0x2(%edx)
  800792:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800798:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80079f:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8007a5:	01 c2                	add    %eax,%edx
  8007a7:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8007aa:	89 42 04             	mov    %eax,0x4(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8007ad:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  8007b0:	e8 42 25 00 00       	call   802cf7 <sys_calculate_free_frames>
  8007b5:	29 c3                	sub    %eax,%ebx
  8007b7:	89 d8                	mov    %ebx,%eax
  8007b9:	83 f8 02             	cmp    $0x2,%eax
  8007bc:	74 17                	je     8007d5 <_main+0x79d>
  8007be:	83 ec 04             	sub    $0x4,%esp
  8007c1:	68 38 35 80 00       	push   $0x803538
  8007c6:	68 8f 00 00 00       	push   $0x8f
  8007cb:	68 8b 34 80 00       	push   $0x80348b
  8007d0:	e8 10 10 00 00       	call   8017e5 <_panic>
		found = 0;
  8007d5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8007dc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8007e3:	e9 9e 00 00 00       	jmp    800886 <_main+0x84e>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
  8007e8:	a1 20 40 80 00       	mov    0x804020,%eax
  8007ed:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007f3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8007f6:	c1 e2 04             	shl    $0x4,%edx
  8007f9:	01 d0                	add    %edx,%eax
  8007fb:	8b 00                	mov    (%eax),%eax
  8007fd:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  800803:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800809:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80080e:	89 c2                	mov    %eax,%edx
  800810:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800816:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  80081c:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  800822:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800827:	39 c2                	cmp    %eax,%edx
  800829:	75 03                	jne    80082e <_main+0x7f6>
				found++;
  80082b:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
  80082e:	a1 20 40 80 00       	mov    0x804020,%eax
  800833:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800839:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80083c:	c1 e2 04             	shl    $0x4,%edx
  80083f:	01 d0                	add    %edx,%eax
  800841:	8b 00                	mov    (%eax),%eax
  800843:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  800849:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  80084f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800854:	89 c2                	mov    %eax,%edx
  800856:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80085c:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800863:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800869:	01 c8                	add    %ecx,%eax
  80086b:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  800871:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800877:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80087c:	39 c2                	cmp    %eax,%edx
  80087e:	75 03                	jne    800883 <_main+0x84b>
				found++;
  800880:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800883:	ff 45 ec             	incl   -0x14(%ebp)
  800886:	a1 20 40 80 00       	mov    0x804020,%eax
  80088b:	8b 50 74             	mov    0x74(%eax),%edx
  80088e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800891:	39 c2                	cmp    %eax,%edx
  800893:	0f 87 4f ff ff ff    	ja     8007e8 <_main+0x7b0>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800899:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  80089d:	74 17                	je     8008b6 <_main+0x87e>
  80089f:	83 ec 04             	sub    $0x4,%esp
  8008a2:	68 7c 35 80 00       	push   $0x80357c
  8008a7:	68 98 00 00 00       	push   $0x98
  8008ac:	68 8b 34 80 00       	push   $0x80348b
  8008b1:	e8 2f 0f 00 00       	call   8017e5 <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8008b6:	e8 3c 24 00 00       	call   802cf7 <sys_calculate_free_frames>
  8008bb:	89 45 bc             	mov    %eax,-0x44(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8008be:	e8 b7 24 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  8008c3:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8008c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008c9:	89 c2                	mov    %eax,%edx
  8008cb:	01 d2                	add    %edx,%edx
  8008cd:	01 d0                	add    %edx,%eax
  8008cf:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8008d2:	83 ec 0c             	sub    $0xc,%esp
  8008d5:	50                   	push   %eax
  8008d6:	e8 36 1f 00 00       	call   802811 <malloc>
  8008db:	83 c4 10             	add    $0x10,%esp
  8008de:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START+ 4*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8008e4:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  8008ea:	89 c2                	mov    %eax,%edx
  8008ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008ef:	c1 e0 02             	shl    $0x2,%eax
  8008f2:	89 c1                	mov    %eax,%ecx
  8008f4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008f7:	c1 e0 04             	shl    $0x4,%eax
  8008fa:	01 c8                	add    %ecx,%eax
  8008fc:	05 00 00 00 80       	add    $0x80000000,%eax
  800901:	39 c2                	cmp    %eax,%edx
  800903:	72 21                	jb     800926 <_main+0x8ee>
  800905:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  80090b:	89 c2                	mov    %eax,%edx
  80090d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800910:	c1 e0 02             	shl    $0x2,%eax
  800913:	89 c1                	mov    %eax,%ecx
  800915:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800918:	c1 e0 04             	shl    $0x4,%eax
  80091b:	01 c8                	add    %ecx,%eax
  80091d:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800922:	39 c2                	cmp    %eax,%edx
  800924:	76 17                	jbe    80093d <_main+0x905>
  800926:	83 ec 04             	sub    $0x4,%esp
  800929:	68 a0 34 80 00       	push   $0x8034a0
  80092e:	68 9e 00 00 00       	push   $0x9e
  800933:	68 8b 34 80 00       	push   $0x80348b
  800938:	e8 a8 0e 00 00       	call   8017e5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  80093d:	e8 38 24 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  800942:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800945:	89 c2                	mov    %eax,%edx
  800947:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80094a:	89 c1                	mov    %eax,%ecx
  80094c:	01 c9                	add    %ecx,%ecx
  80094e:	01 c8                	add    %ecx,%eax
  800950:	85 c0                	test   %eax,%eax
  800952:	79 05                	jns    800959 <_main+0x921>
  800954:	05 ff 0f 00 00       	add    $0xfff,%eax
  800959:	c1 f8 0c             	sar    $0xc,%eax
  80095c:	39 c2                	cmp    %eax,%edx
  80095e:	74 17                	je     800977 <_main+0x93f>
  800960:	83 ec 04             	sub    $0x4,%esp
  800963:	68 08 35 80 00       	push   $0x803508
  800968:	68 9f 00 00 00       	push   $0x9f
  80096d:	68 8b 34 80 00       	push   $0x80348b
  800972:	e8 6e 0e 00 00       	call   8017e5 <_panic>

		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
		byteArr3 = (char*)ptr_allocations[5];
  800977:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  80097d:	89 45 f0             	mov    %eax,-0x10(%ebp)

		for(int i = 0; i < toAccess; i++)
  800980:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800987:	eb 10                	jmp    800999 <_main+0x961>
		{
			*byteArr3 = '@';
  800989:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80098c:	c6 00 40             	movb   $0x40,(%eax)
			byteArr3 += PAGE_SIZE;
  80098f:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");

		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
		byteArr3 = (char*)ptr_allocations[5];

		for(int i = 0; i < toAccess; i++)
  800996:	ff 45 e4             	incl   -0x1c(%ebp)
  800999:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80099c:	3b 45 c4             	cmp    -0x3c(%ebp),%eax
  80099f:	7c e8                	jl     800989 <_main+0x951>
			byteArr3 += PAGE_SIZE;

		}

		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8009a1:	e8 d4 23 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  8009a6:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[6] = malloc(6*Mega-kilo);
  8009a9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009ac:	89 d0                	mov    %edx,%eax
  8009ae:	01 c0                	add    %eax,%eax
  8009b0:	01 d0                	add    %edx,%eax
  8009b2:	01 c0                	add    %eax,%eax
  8009b4:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8009b7:	83 ec 0c             	sub    $0xc,%esp
  8009ba:	50                   	push   %eax
  8009bb:	e8 51 1e 00 00       	call   802811 <malloc>
  8009c0:	83 c4 10             	add    $0x10,%esp
  8009c3:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START+ 7*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8009c9:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  8009cf:	89 c1                	mov    %eax,%ecx
  8009d1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009d4:	89 d0                	mov    %edx,%eax
  8009d6:	01 c0                	add    %eax,%eax
  8009d8:	01 d0                	add    %edx,%eax
  8009da:	01 c0                	add    %eax,%eax
  8009dc:	01 d0                	add    %edx,%eax
  8009de:	89 c2                	mov    %eax,%edx
  8009e0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009e3:	c1 e0 04             	shl    $0x4,%eax
  8009e6:	01 d0                	add    %edx,%eax
  8009e8:	05 00 00 00 80       	add    $0x80000000,%eax
  8009ed:	39 c1                	cmp    %eax,%ecx
  8009ef:	72 28                	jb     800a19 <_main+0x9e1>
  8009f1:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  8009f7:	89 c1                	mov    %eax,%ecx
  8009f9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009fc:	89 d0                	mov    %edx,%eax
  8009fe:	01 c0                	add    %eax,%eax
  800a00:	01 d0                	add    %edx,%eax
  800a02:	01 c0                	add    %eax,%eax
  800a04:	01 d0                	add    %edx,%eax
  800a06:	89 c2                	mov    %eax,%edx
  800a08:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a0b:	c1 e0 04             	shl    $0x4,%eax
  800a0e:	01 d0                	add    %edx,%eax
  800a10:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800a15:	39 c1                	cmp    %eax,%ecx
  800a17:	76 17                	jbe    800a30 <_main+0x9f8>
  800a19:	83 ec 04             	sub    $0x4,%esp
  800a1c:	68 a0 34 80 00       	push   $0x8034a0
  800a21:	68 ae 00 00 00       	push   $0xae
  800a26:	68 8b 34 80 00       	push   $0x80348b
  800a2b:	e8 b5 0d 00 00       	call   8017e5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800a30:	e8 45 23 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  800a35:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800a38:	89 c1                	mov    %eax,%ecx
  800a3a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a3d:	89 d0                	mov    %edx,%eax
  800a3f:	01 c0                	add    %eax,%eax
  800a41:	01 d0                	add    %edx,%eax
  800a43:	01 c0                	add    %eax,%eax
  800a45:	85 c0                	test   %eax,%eax
  800a47:	79 05                	jns    800a4e <_main+0xa16>
  800a49:	05 ff 0f 00 00       	add    $0xfff,%eax
  800a4e:	c1 f8 0c             	sar    $0xc,%eax
  800a51:	39 c1                	cmp    %eax,%ecx
  800a53:	74 17                	je     800a6c <_main+0xa34>
  800a55:	83 ec 04             	sub    $0x4,%esp
  800a58:	68 08 35 80 00       	push   $0x803508
  800a5d:	68 af 00 00 00       	push   $0xaf
  800a62:	68 8b 34 80 00       	push   $0x80348b
  800a67:	e8 79 0d 00 00       	call   8017e5 <_panic>
		freeFrames = sys_calculate_free_frames() ;
  800a6c:	e8 86 22 00 00       	call   802cf7 <sys_calculate_free_frames>
  800a71:	89 45 bc             	mov    %eax,-0x44(%ebp)
		lastIndexOfByte2 = (6*Mega-kilo)/sizeof(char) - 1;
  800a74:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a77:	89 d0                	mov    %edx,%eax
  800a79:	01 c0                	add    %eax,%eax
  800a7b:	01 d0                	add    %edx,%eax
  800a7d:	01 c0                	add    %eax,%eax
  800a7f:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800a82:	48                   	dec    %eax
  800a83:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
		byteArr2 = (char *) ptr_allocations[6];
  800a89:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  800a8f:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
		byteArr2[0] = minByte ;
  800a95:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800a9b:	8a 55 db             	mov    -0x25(%ebp),%dl
  800a9e:	88 10                	mov    %dl,(%eax)
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
  800aa0:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800aa6:	89 c2                	mov    %eax,%edx
  800aa8:	c1 ea 1f             	shr    $0x1f,%edx
  800aab:	01 d0                	add    %edx,%eax
  800aad:	d1 f8                	sar    %eax
  800aaf:	89 c2                	mov    %eax,%edx
  800ab1:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800ab7:	01 c2                	add    %eax,%edx
  800ab9:	8a 45 da             	mov    -0x26(%ebp),%al
  800abc:	88 c1                	mov    %al,%cl
  800abe:	c0 e9 07             	shr    $0x7,%cl
  800ac1:	01 c8                	add    %ecx,%eax
  800ac3:	d0 f8                	sar    %al
  800ac5:	88 02                	mov    %al,(%edx)
		byteArr2[lastIndexOfByte2] = maxByte ;
  800ac7:	8b 95 58 ff ff ff    	mov    -0xa8(%ebp),%edx
  800acd:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800ad3:	01 c2                	add    %eax,%edx
  800ad5:	8a 45 da             	mov    -0x26(%ebp),%al
  800ad8:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800ada:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  800add:	e8 15 22 00 00       	call   802cf7 <sys_calculate_free_frames>
  800ae2:	29 c3                	sub    %eax,%ebx
  800ae4:	89 d8                	mov    %ebx,%eax
  800ae6:	83 f8 05             	cmp    $0x5,%eax
  800ae9:	74 17                	je     800b02 <_main+0xaca>
  800aeb:	83 ec 04             	sub    $0x4,%esp
  800aee:	68 38 35 80 00       	push   $0x803538
  800af3:	68 b6 00 00 00       	push   $0xb6
  800af8:	68 8b 34 80 00       	push   $0x80348b
  800afd:	e8 e3 0c 00 00       	call   8017e5 <_panic>
		found = 0;
  800b02:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800b09:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800b10:	e9 f0 00 00 00       	jmp    800c05 <_main+0xbcd>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  800b15:	a1 20 40 80 00       	mov    0x804020,%eax
  800b1a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b20:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b23:	c1 e2 04             	shl    $0x4,%edx
  800b26:	01 d0                	add    %edx,%eax
  800b28:	8b 00                	mov    (%eax),%eax
  800b2a:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  800b30:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800b36:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b3b:	89 c2                	mov    %eax,%edx
  800b3d:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800b43:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  800b49:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800b4f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b54:	39 c2                	cmp    %eax,%edx
  800b56:	75 03                	jne    800b5b <_main+0xb23>
				found++;
  800b58:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  800b5b:	a1 20 40 80 00       	mov    0x804020,%eax
  800b60:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b66:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b69:	c1 e2 04             	shl    $0x4,%edx
  800b6c:	01 d0                	add    %edx,%eax
  800b6e:	8b 00                	mov    (%eax),%eax
  800b70:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
  800b76:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800b7c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b81:	89 c2                	mov    %eax,%edx
  800b83:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800b89:	89 c1                	mov    %eax,%ecx
  800b8b:	c1 e9 1f             	shr    $0x1f,%ecx
  800b8e:	01 c8                	add    %ecx,%eax
  800b90:	d1 f8                	sar    %eax
  800b92:	89 c1                	mov    %eax,%ecx
  800b94:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800b9a:	01 c8                	add    %ecx,%eax
  800b9c:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  800ba2:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800ba8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bad:	39 c2                	cmp    %eax,%edx
  800baf:	75 03                	jne    800bb4 <_main+0xb7c>
				found++;
  800bb1:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  800bb4:	a1 20 40 80 00       	mov    0x804020,%eax
  800bb9:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800bbf:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800bc2:	c1 e2 04             	shl    $0x4,%edx
  800bc5:	01 d0                	add    %edx,%eax
  800bc7:	8b 00                	mov    (%eax),%eax
  800bc9:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
  800bcf:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800bd5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bda:	89 c1                	mov    %eax,%ecx
  800bdc:	8b 95 58 ff ff ff    	mov    -0xa8(%ebp),%edx
  800be2:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800be8:	01 d0                	add    %edx,%eax
  800bea:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)
  800bf0:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800bf6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bfb:	39 c1                	cmp    %eax,%ecx
  800bfd:	75 03                	jne    800c02 <_main+0xbca>
				found++;
  800bff:	ff 45 e8             	incl   -0x18(%ebp)
		byteArr2[0] = minByte ;
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
		byteArr2[lastIndexOfByte2] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800c02:	ff 45 ec             	incl   -0x14(%ebp)
  800c05:	a1 20 40 80 00       	mov    0x804020,%eax
  800c0a:	8b 50 74             	mov    0x74(%eax),%edx
  800c0d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c10:	39 c2                	cmp    %eax,%edx
  800c12:	0f 87 fd fe ff ff    	ja     800b15 <_main+0xadd>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				found++;
		}
		if (found != 3) panic("malloc: page is not added to WS");
  800c18:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  800c1c:	74 17                	je     800c35 <_main+0xbfd>
  800c1e:	83 ec 04             	sub    $0x4,%esp
  800c21:	68 7c 35 80 00       	push   $0x80357c
  800c26:	68 c1 00 00 00       	push   $0xc1
  800c2b:	68 8b 34 80 00       	push   $0x80348b
  800c30:	e8 b0 0b 00 00       	call   8017e5 <_panic>

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800c35:	e8 40 21 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  800c3a:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[7] = malloc(14*kilo);
  800c3d:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800c40:	89 d0                	mov    %edx,%eax
  800c42:	01 c0                	add    %eax,%eax
  800c44:	01 d0                	add    %edx,%eax
  800c46:	01 c0                	add    %eax,%eax
  800c48:	01 d0                	add    %edx,%eax
  800c4a:	01 c0                	add    %eax,%eax
  800c4c:	83 ec 0c             	sub    $0xc,%esp
  800c4f:	50                   	push   %eax
  800c50:	e8 bc 1b 00 00       	call   802811 <malloc>
  800c55:	83 c4 10             	add    $0x10,%esp
  800c58:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
		if ((uint32) ptr_allocations[7] < (USER_HEAP_START + 13*Mega + 16*kilo)|| (uint32) ptr_allocations[7] > (USER_HEAP_START+ 13*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800c5e:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800c64:	89 c1                	mov    %eax,%ecx
  800c66:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c69:	89 d0                	mov    %edx,%eax
  800c6b:	01 c0                	add    %eax,%eax
  800c6d:	01 d0                	add    %edx,%eax
  800c6f:	c1 e0 02             	shl    $0x2,%eax
  800c72:	01 d0                	add    %edx,%eax
  800c74:	89 c2                	mov    %eax,%edx
  800c76:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800c79:	c1 e0 04             	shl    $0x4,%eax
  800c7c:	01 d0                	add    %edx,%eax
  800c7e:	05 00 00 00 80       	add    $0x80000000,%eax
  800c83:	39 c1                	cmp    %eax,%ecx
  800c85:	72 29                	jb     800cb0 <_main+0xc78>
  800c87:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800c8d:	89 c1                	mov    %eax,%ecx
  800c8f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c92:	89 d0                	mov    %edx,%eax
  800c94:	01 c0                	add    %eax,%eax
  800c96:	01 d0                	add    %edx,%eax
  800c98:	c1 e0 02             	shl    $0x2,%eax
  800c9b:	01 d0                	add    %edx,%eax
  800c9d:	89 c2                	mov    %eax,%edx
  800c9f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800ca2:	c1 e0 04             	shl    $0x4,%eax
  800ca5:	01 d0                	add    %edx,%eax
  800ca7:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800cac:	39 c1                	cmp    %eax,%ecx
  800cae:	76 17                	jbe    800cc7 <_main+0xc8f>
  800cb0:	83 ec 04             	sub    $0x4,%esp
  800cb3:	68 a0 34 80 00       	push   $0x8034a0
  800cb8:	68 c6 00 00 00       	push   $0xc6
  800cbd:	68 8b 34 80 00       	push   $0x80348b
  800cc2:	e8 1e 0b 00 00       	call   8017e5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4) panic("Extra or less pages are allocated in PageFile");
  800cc7:	e8 ae 20 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  800ccc:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800ccf:	83 f8 04             	cmp    $0x4,%eax
  800cd2:	74 17                	je     800ceb <_main+0xcb3>
  800cd4:	83 ec 04             	sub    $0x4,%esp
  800cd7:	68 08 35 80 00       	push   $0x803508
  800cdc:	68 c7 00 00 00       	push   $0xc7
  800ce1:	68 8b 34 80 00       	push   $0x80348b
  800ce6:	e8 fa 0a 00 00       	call   8017e5 <_panic>
		freeFrames = sys_calculate_free_frames() ;
  800ceb:	e8 07 20 00 00       	call   802cf7 <sys_calculate_free_frames>
  800cf0:	89 45 bc             	mov    %eax,-0x44(%ebp)
		shortArr2 = (short *) ptr_allocations[7];
  800cf3:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800cf9:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
  800cff:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800d02:	89 d0                	mov    %edx,%eax
  800d04:	01 c0                	add    %eax,%eax
  800d06:	01 d0                	add    %edx,%eax
  800d08:	01 c0                	add    %eax,%eax
  800d0a:	01 d0                	add    %edx,%eax
  800d0c:	01 c0                	add    %eax,%eax
  800d0e:	d1 e8                	shr    %eax
  800d10:	48                   	dec    %eax
  800d11:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
		shortArr2[0] = minShort;
  800d17:	8b 95 38 ff ff ff    	mov    -0xc8(%ebp),%edx
  800d1d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800d20:	66 89 02             	mov    %ax,(%edx)
		shortArr2[lastIndexOfShort2] = maxShort;
  800d23:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800d29:	01 c0                	add    %eax,%eax
  800d2b:	89 c2                	mov    %eax,%edx
  800d2d:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800d33:	01 c2                	add    %eax,%edx
  800d35:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  800d39:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800d3c:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  800d3f:	e8 b3 1f 00 00       	call   802cf7 <sys_calculate_free_frames>
  800d44:	29 c3                	sub    %eax,%ebx
  800d46:	89 d8                	mov    %ebx,%eax
  800d48:	83 f8 02             	cmp    $0x2,%eax
  800d4b:	74 17                	je     800d64 <_main+0xd2c>
  800d4d:	83 ec 04             	sub    $0x4,%esp
  800d50:	68 38 35 80 00       	push   $0x803538
  800d55:	68 cd 00 00 00       	push   $0xcd
  800d5a:	68 8b 34 80 00       	push   $0x80348b
  800d5f:	e8 81 0a 00 00       	call   8017e5 <_panic>
		found = 0;
  800d64:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800d6b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800d72:	e9 9b 00 00 00       	jmp    800e12 <_main+0xdda>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
  800d77:	a1 20 40 80 00       	mov    0x804020,%eax
  800d7c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800d82:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800d85:	c1 e2 04             	shl    $0x4,%edx
  800d88:	01 d0                	add    %edx,%eax
  800d8a:	8b 00                	mov    (%eax),%eax
  800d8c:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
  800d92:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  800d98:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d9d:	89 c2                	mov    %eax,%edx
  800d9f:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800da5:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
  800dab:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  800db1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800db6:	39 c2                	cmp    %eax,%edx
  800db8:	75 03                	jne    800dbd <_main+0xd85>
				found++;
  800dba:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
  800dbd:	a1 20 40 80 00       	mov    0x804020,%eax
  800dc2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800dc8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dcb:	c1 e2 04             	shl    $0x4,%edx
  800dce:	01 d0                	add    %edx,%eax
  800dd0:	8b 00                	mov    (%eax),%eax
  800dd2:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
  800dd8:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
  800dde:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800de3:	89 c2                	mov    %eax,%edx
  800de5:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800deb:	01 c0                	add    %eax,%eax
  800ded:	89 c1                	mov    %eax,%ecx
  800def:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800df5:	01 c8                	add    %ecx,%eax
  800df7:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
  800dfd:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  800e03:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e08:	39 c2                	cmp    %eax,%edx
  800e0a:	75 03                	jne    800e0f <_main+0xdd7>
				found++;
  800e0c:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
		shortArr2[0] = minShort;
		shortArr2[lastIndexOfShort2] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800e0f:	ff 45 ec             	incl   -0x14(%ebp)
  800e12:	a1 20 40 80 00       	mov    0x804020,%eax
  800e17:	8b 50 74             	mov    0x74(%eax),%edx
  800e1a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e1d:	39 c2                	cmp    %eax,%edx
  800e1f:	0f 87 52 ff ff ff    	ja     800d77 <_main+0xd3f>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800e25:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800e29:	74 17                	je     800e42 <_main+0xe0a>
  800e2b:	83 ec 04             	sub    $0x4,%esp
  800e2e:	68 7c 35 80 00       	push   $0x80357c
  800e33:	68 d6 00 00 00       	push   $0xd6
  800e38:	68 8b 34 80 00       	push   $0x80348b
  800e3d:	e8 a3 09 00 00       	call   8017e5 <_panic>
	}

	{
		uint32 tmp_addresses[3] = {0};
  800e42:	8d 95 bc fe ff ff    	lea    -0x144(%ebp),%edx
  800e48:	b9 03 00 00 00       	mov    $0x3,%ecx
  800e4d:	b8 00 00 00 00       	mov    $0x0,%eax
  800e52:	89 d7                	mov    %edx,%edi
  800e54:	f3 ab                	rep stos %eax,%es:(%edi)
		//Free 6 MB
		int freeFrames = sys_calculate_free_frames() ;
  800e56:	e8 9c 1e 00 00       	call   802cf7 <sys_calculate_free_frames>
  800e5b:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800e61:	e8 14 1f 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  800e66:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[6]);
  800e6c:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  800e72:	83 ec 0c             	sub    $0xc,%esp
  800e75:	50                   	push   %eax
  800e76:	e8 a6 1b 00 00       	call   802a21 <free>
  800e7b:	83 c4 10             	add    $0x10,%esp
		cprintf("i Expetct %d and found %d \n ------------\n",6*Mega/4096,(usedDiskPages - sys_pf_calculate_allocated_pages()));
  800e7e:	e8 f7 1e 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  800e83:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  800e89:	89 d1                	mov    %edx,%ecx
  800e8b:	29 c1                	sub    %eax,%ecx
  800e8d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e90:	89 d0                	mov    %edx,%eax
  800e92:	01 c0                	add    %eax,%eax
  800e94:	01 d0                	add    %edx,%eax
  800e96:	01 c0                	add    %eax,%eax
  800e98:	85 c0                	test   %eax,%eax
  800e9a:	79 05                	jns    800ea1 <_main+0xe69>
  800e9c:	05 ff 0f 00 00       	add    $0xfff,%eax
  800ea1:	c1 f8 0c             	sar    $0xc,%eax
  800ea4:	83 ec 04             	sub    $0x4,%esp
  800ea7:	51                   	push   %ecx
  800ea8:	50                   	push   %eax
  800ea9:	68 9c 35 80 00       	push   $0x80359c
  800eae:	e8 d4 0b 00 00       	call   801a87 <cprintf>
  800eb3:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 6*Mega/4096)
  800eb6:	e8 bf 1e 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  800ebb:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  800ec1:	89 d1                	mov    %edx,%ecx
  800ec3:	29 c1                	sub    %eax,%ecx
  800ec5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ec8:	89 d0                	mov    %edx,%eax
  800eca:	01 c0                	add    %eax,%eax
  800ecc:	01 d0                	add    %edx,%eax
  800ece:	01 c0                	add    %eax,%eax
  800ed0:	85 c0                	test   %eax,%eax
  800ed2:	79 05                	jns    800ed9 <_main+0xea1>
  800ed4:	05 ff 0f 00 00       	add    $0xfff,%eax
  800ed9:	c1 f8 0c             	sar    $0xc,%eax
  800edc:	39 c1                	cmp    %eax,%ecx
  800ede:	74 17                	je     800ef7 <_main+0xebf>
			panic("Wrong free: Extra or less pages are removed from PageFile");
  800ee0:	83 ec 04             	sub    $0x4,%esp
  800ee3:	68 c8 35 80 00       	push   $0x8035c8
  800ee8:	68 e1 00 00 00       	push   $0xe1
  800eed:	68 8b 34 80 00       	push   $0x80348b
  800ef2:	e8 ee 08 00 00       	call   8017e5 <_panic>
		cprintf("i Expetct %d and found %d \n ------------\n",3+1,(sys_calculate_free_frames() - freeFrames));
  800ef7:	e8 fb 1d 00 00       	call   802cf7 <sys_calculate_free_frames>
  800efc:	89 c2                	mov    %eax,%edx
  800efe:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  800f04:	29 c2                	sub    %eax,%edx
  800f06:	89 d0                	mov    %edx,%eax
  800f08:	83 ec 04             	sub    $0x4,%esp
  800f0b:	50                   	push   %eax
  800f0c:	6a 04                	push   $0x4
  800f0e:	68 9c 35 80 00       	push   $0x80359c
  800f13:	e8 6f 0b 00 00       	call   801a87 <cprintf>
  800f18:	83 c4 10             	add    $0x10,%esp
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 1)
  800f1b:	e8 d7 1d 00 00       	call   802cf7 <sys_calculate_free_frames>
  800f20:	89 c2                	mov    %eax,%edx
  800f22:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  800f28:	29 c2                	sub    %eax,%edx
  800f2a:	89 d0                	mov    %edx,%eax
  800f2c:	83 f8 04             	cmp    $0x4,%eax
  800f2f:	74 17                	je     800f48 <_main+0xf10>
			panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800f31:	83 ec 04             	sub    $0x4,%esp
  800f34:	68 04 36 80 00       	push   $0x803604
  800f39:	68 e4 00 00 00       	push   $0xe4
  800f3e:	68 8b 34 80 00       	push   $0x80348b
  800f43:	e8 9d 08 00 00       	call   8017e5 <_panic>
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}
		tmp_addresses[0] = (uint32)(&(byteArr2[0]));
  800f48:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800f4e:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(byteArr2[lastIndexOfByte2/2]));
  800f54:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800f5a:	89 c2                	mov    %eax,%edx
  800f5c:	c1 ea 1f             	shr    $0x1f,%edx
  800f5f:	01 d0                	add    %edx,%eax
  800f61:	d1 f8                	sar    %eax
  800f63:	89 c2                	mov    %eax,%edx
  800f65:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800f6b:	01 d0                	add    %edx,%eax
  800f6d:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		tmp_addresses[2] = (uint32)(&(byteArr2[lastIndexOfByte2]));
  800f73:	8b 95 58 ff ff ff    	mov    -0xa8(%ebp),%edx
  800f79:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800f7f:	01 d0                	add    %edx,%eax
  800f81:	89 85 c4 fe ff ff    	mov    %eax,-0x13c(%ebp)
		int check = sys_check_LRU_lists_free(tmp_addresses, 3);
  800f87:	83 ec 08             	sub    $0x8,%esp
  800f8a:	6a 03                	push   $0x3
  800f8c:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  800f92:	50                   	push   %eax
  800f93:	e8 33 22 00 00       	call   8031cb <sys_check_LRU_lists_free>
  800f98:	83 c4 10             	add    $0x10,%esp
  800f9b:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  800fa1:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  800fa8:	74 17                	je     800fc1 <_main+0xf89>
		{
				panic("free: page is not removed from LRU lists");
  800faa:	83 ec 04             	sub    $0x4,%esp
  800fad:	68 50 36 80 00       	push   $0x803650
  800fb2:	68 f4 00 00 00       	push   $0xf4
  800fb7:	68 8b 34 80 00       	push   $0x80348b
  800fbc:	e8 24 08 00 00       	call   8017e5 <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 800 && LIST_SIZE(&myEnv->SecondList) != 1)
  800fc1:	a1 20 40 80 00       	mov    0x804020,%eax
  800fc6:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  800fcc:	3d 20 03 00 00       	cmp    $0x320,%eax
  800fd1:	74 27                	je     800ffa <_main+0xfc2>
  800fd3:	a1 20 40 80 00       	mov    0x804020,%eax
  800fd8:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  800fde:	83 f8 01             	cmp    $0x1,%eax
  800fe1:	74 17                	je     800ffa <_main+0xfc2>
		{
			panic("LRU lists content is not correct");
  800fe3:	83 ec 04             	sub    $0x4,%esp
  800fe6:	68 7c 36 80 00       	push   $0x80367c
  800feb:	68 f9 00 00 00       	push   $0xf9
  800ff0:	68 8b 34 80 00       	push   $0x80348b
  800ff5:	e8 eb 07 00 00       	call   8017e5 <_panic>
		}

		//Free 1st 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800ffa:	e8 f8 1c 00 00       	call   802cf7 <sys_calculate_free_frames>
  800fff:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801005:	e8 70 1d 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  80100a:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[0]);
  801010:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  801016:	83 ec 0c             	sub    $0xc,%esp
  801019:	50                   	push   %eax
  80101a:	e8 02 1a 00 00       	call   802a21 <free>
  80101f:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  801022:	e8 53 1d 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  801027:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  80102d:	29 c2                	sub    %eax,%edx
  80102f:	89 d0                	mov    %edx,%eax
  801031:	3d 00 02 00 00       	cmp    $0x200,%eax
  801036:	74 17                	je     80104f <_main+0x1017>
  801038:	83 ec 04             	sub    $0x4,%esp
  80103b:	68 c8 35 80 00       	push   $0x8035c8
  801040:	68 00 01 00 00       	push   $0x100
  801045:	68 8b 34 80 00       	push   $0x80348b
  80104a:	e8 96 07 00 00       	call   8017e5 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 ) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80104f:	e8 a3 1c 00 00       	call   802cf7 <sys_calculate_free_frames>
  801054:	89 c2                	mov    %eax,%edx
  801056:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  80105c:	29 c2                	sub    %eax,%edx
  80105e:	89 d0                	mov    %edx,%eax
  801060:	83 f8 02             	cmp    $0x2,%eax
  801063:	74 17                	je     80107c <_main+0x1044>
  801065:	83 ec 04             	sub    $0x4,%esp
  801068:	68 04 36 80 00       	push   $0x803604
  80106d:	68 01 01 00 00       	push   $0x101
  801072:	68 8b 34 80 00       	push   $0x80348b
  801077:	e8 69 07 00 00       	call   8017e5 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(byteArr[0]));
  80107c:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80107f:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(byteArr[lastIndexOfByte]));
  801085:	8b 55 b8             	mov    -0x48(%ebp),%edx
  801088:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80108b:	01 d0                	add    %edx,%eax
  80108d:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  801093:	83 ec 08             	sub    $0x8,%esp
  801096:	6a 02                	push   $0x2
  801098:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  80109e:	50                   	push   %eax
  80109f:	e8 27 21 00 00       	call   8031cb <sys_check_LRU_lists_free>
  8010a4:	83 c4 10             	add    $0x10,%esp
  8010a7:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  8010ad:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  8010b4:	74 17                	je     8010cd <_main+0x1095>
		{
				panic("free: page is not removed from LRU lists");
  8010b6:	83 ec 04             	sub    $0x4,%esp
  8010b9:	68 50 36 80 00       	push   $0x803650
  8010be:	68 10 01 00 00       	push   $0x110
  8010c3:	68 8b 34 80 00       	push   $0x80348b
  8010c8:	e8 18 07 00 00       	call   8017e5 <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 799 && LIST_SIZE(&myEnv->SecondList) != 0)
  8010cd:	a1 20 40 80 00       	mov    0x804020,%eax
  8010d2:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  8010d8:	3d 1f 03 00 00       	cmp    $0x31f,%eax
  8010dd:	74 26                	je     801105 <_main+0x10cd>
  8010df:	a1 20 40 80 00       	mov    0x804020,%eax
  8010e4:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  8010ea:	85 c0                	test   %eax,%eax
  8010ec:	74 17                	je     801105 <_main+0x10cd>
		{
			panic("LRU lists content is not correct");
  8010ee:	83 ec 04             	sub    $0x4,%esp
  8010f1:	68 7c 36 80 00       	push   $0x80367c
  8010f6:	68 15 01 00 00       	push   $0x115
  8010fb:	68 8b 34 80 00       	push   $0x80348b
  801100:	e8 e0 06 00 00       	call   8017e5 <_panic>
		}

		//Free 2nd 2 MB
		freeFrames = sys_calculate_free_frames() ;
  801105:	e8 ed 1b 00 00       	call   802cf7 <sys_calculate_free_frames>
  80110a:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801110:	e8 65 1c 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  801115:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[1]);
  80111b:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  801121:	83 ec 0c             	sub    $0xc,%esp
  801124:	50                   	push   %eax
  801125:	e8 f7 18 00 00       	call   802a21 <free>
  80112a:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  80112d:	e8 48 1c 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  801132:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801138:	29 c2                	sub    %eax,%edx
  80113a:	89 d0                	mov    %edx,%eax
  80113c:	3d 00 02 00 00       	cmp    $0x200,%eax
  801141:	74 17                	je     80115a <_main+0x1122>
  801143:	83 ec 04             	sub    $0x4,%esp
  801146:	68 c8 35 80 00       	push   $0x8035c8
  80114b:	68 1c 01 00 00       	push   $0x11c
  801150:	68 8b 34 80 00       	push   $0x80348b
  801155:	e8 8b 06 00 00       	call   8017e5 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80115a:	e8 98 1b 00 00       	call   802cf7 <sys_calculate_free_frames>
  80115f:	89 c2                	mov    %eax,%edx
  801161:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801167:	29 c2                	sub    %eax,%edx
  801169:	89 d0                	mov    %edx,%eax
  80116b:	83 f8 03             	cmp    $0x3,%eax
  80116e:	74 17                	je     801187 <_main+0x114f>
  801170:	83 ec 04             	sub    $0x4,%esp
  801173:	68 04 36 80 00       	push   $0x803604
  801178:	68 1d 01 00 00       	push   $0x11d
  80117d:	68 8b 34 80 00       	push   $0x80348b
  801182:	e8 5e 06 00 00       	call   8017e5 <_panic>
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}
		tmp_addresses[0] = (uint32)(&(shortArr[0]));
  801187:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80118a:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(shortArr[lastIndexOfShort]));
  801190:	8b 45 9c             	mov    -0x64(%ebp),%eax
  801193:	01 c0                	add    %eax,%eax
  801195:	89 c2                	mov    %eax,%edx
  801197:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80119a:	01 d0                	add    %edx,%eax
  80119c:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  8011a2:	83 ec 08             	sub    $0x8,%esp
  8011a5:	6a 02                	push   $0x2
  8011a7:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  8011ad:	50                   	push   %eax
  8011ae:	e8 18 20 00 00       	call   8031cb <sys_check_LRU_lists_free>
  8011b3:	83 c4 10             	add    $0x10,%esp
  8011b6:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  8011bc:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  8011c3:	74 17                	je     8011dc <_main+0x11a4>
		{
				panic("free: page is not removed from LRU lists");
  8011c5:	83 ec 04             	sub    $0x4,%esp
  8011c8:	68 50 36 80 00       	push   $0x803650
  8011cd:	68 2a 01 00 00       	push   $0x12a
  8011d2:	68 8b 34 80 00       	push   $0x80348b
  8011d7:	e8 09 06 00 00       	call   8017e5 <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 797 && LIST_SIZE(&myEnv->SecondList) != 0)
  8011dc:	a1 20 40 80 00       	mov    0x804020,%eax
  8011e1:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  8011e7:	3d 1d 03 00 00       	cmp    $0x31d,%eax
  8011ec:	74 26                	je     801214 <_main+0x11dc>
  8011ee:	a1 20 40 80 00       	mov    0x804020,%eax
  8011f3:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  8011f9:	85 c0                	test   %eax,%eax
  8011fb:	74 17                	je     801214 <_main+0x11dc>
		{
			panic("LRU lists content is not correct");
  8011fd:	83 ec 04             	sub    $0x4,%esp
  801200:	68 7c 36 80 00       	push   $0x80367c
  801205:	68 2f 01 00 00       	push   $0x12f
  80120a:	68 8b 34 80 00       	push   $0x80348b
  80120f:	e8 d1 05 00 00       	call   8017e5 <_panic>
		}


		//Free 7 KB
		freeFrames = sys_calculate_free_frames() ;
  801214:	e8 de 1a 00 00       	call   802cf7 <sys_calculate_free_frames>
  801219:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80121f:	e8 56 1b 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  801224:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[4]);
  80122a:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  801230:	83 ec 0c             	sub    $0xc,%esp
  801233:	50                   	push   %eax
  801234:	e8 e8 17 00 00       	call   802a21 <free>
  801239:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2) panic("Wrong free: Extra or less pages are removed from PageFile");
  80123c:	e8 39 1b 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  801241:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801247:	29 c2                	sub    %eax,%edx
  801249:	89 d0                	mov    %edx,%eax
  80124b:	83 f8 02             	cmp    $0x2,%eax
  80124e:	74 17                	je     801267 <_main+0x122f>
  801250:	83 ec 04             	sub    $0x4,%esp
  801253:	68 c8 35 80 00       	push   $0x8035c8
  801258:	68 37 01 00 00       	push   $0x137
  80125d:	68 8b 34 80 00       	push   $0x80348b
  801262:	e8 7e 05 00 00       	call   8017e5 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801267:	e8 8b 1a 00 00       	call   802cf7 <sys_calculate_free_frames>
  80126c:	89 c2                	mov    %eax,%edx
  80126e:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801274:	29 c2                	sub    %eax,%edx
  801276:	89 d0                	mov    %edx,%eax
  801278:	83 f8 02             	cmp    $0x2,%eax
  80127b:	74 17                	je     801294 <_main+0x125c>
  80127d:	83 ec 04             	sub    $0x4,%esp
  801280:	68 04 36 80 00       	push   $0x803604
  801285:	68 38 01 00 00       	push   $0x138
  80128a:	68 8b 34 80 00       	push   $0x80348b
  80128f:	e8 51 05 00 00       	call   8017e5 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(structArr[0]));
  801294:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80129a:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(structArr[lastIndexOfStruct]));
  8012a0:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  8012a6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8012ad:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8012b3:	01 d0                	add    %edx,%eax
  8012b5:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  8012bb:	83 ec 08             	sub    $0x8,%esp
  8012be:	6a 02                	push   $0x2
  8012c0:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  8012c6:	50                   	push   %eax
  8012c7:	e8 ff 1e 00 00       	call   8031cb <sys_check_LRU_lists_free>
  8012cc:	83 c4 10             	add    $0x10,%esp
  8012cf:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  8012d5:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  8012dc:	74 17                	je     8012f5 <_main+0x12bd>
		{
				panic("free: page is not removed from LRU lists");
  8012de:	83 ec 04             	sub    $0x4,%esp
  8012e1:	68 50 36 80 00       	push   $0x803650
  8012e6:	68 46 01 00 00       	push   $0x146
  8012eb:	68 8b 34 80 00       	push   $0x80348b
  8012f0:	e8 f0 04 00 00       	call   8017e5 <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 795 && LIST_SIZE(&myEnv->SecondList) != 0)
  8012f5:	a1 20 40 80 00       	mov    0x804020,%eax
  8012fa:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  801300:	3d 1b 03 00 00       	cmp    $0x31b,%eax
  801305:	74 26                	je     80132d <_main+0x12f5>
  801307:	a1 20 40 80 00       	mov    0x804020,%eax
  80130c:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  801312:	85 c0                	test   %eax,%eax
  801314:	74 17                	je     80132d <_main+0x12f5>
		{
			panic("LRU lists content is not correct");
  801316:	83 ec 04             	sub    $0x4,%esp
  801319:	68 7c 36 80 00       	push   $0x80367c
  80131e:	68 4b 01 00 00       	push   $0x14b
  801323:	68 8b 34 80 00       	push   $0x80348b
  801328:	e8 b8 04 00 00       	call   8017e5 <_panic>
		}

		//Free 3 MB
		freeFrames = sys_calculate_free_frames() ;
  80132d:	e8 c5 19 00 00       	call   802cf7 <sys_calculate_free_frames>
  801332:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801338:	e8 3d 1a 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  80133d:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[5]);
  801343:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  801349:	83 ec 0c             	sub    $0xc,%esp
  80134c:	50                   	push   %eax
  80134d:	e8 cf 16 00 00       	call   802a21 <free>
  801352:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
  801355:	e8 20 1a 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  80135a:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801360:	89 d1                	mov    %edx,%ecx
  801362:	29 c1                	sub    %eax,%ecx
  801364:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801367:	89 c2                	mov    %eax,%edx
  801369:	01 d2                	add    %edx,%edx
  80136b:	01 d0                	add    %edx,%eax
  80136d:	85 c0                	test   %eax,%eax
  80136f:	79 05                	jns    801376 <_main+0x133e>
  801371:	05 ff 0f 00 00       	add    $0xfff,%eax
  801376:	c1 f8 0c             	sar    $0xc,%eax
  801379:	39 c1                	cmp    %eax,%ecx
  80137b:	74 17                	je     801394 <_main+0x135c>
  80137d:	83 ec 04             	sub    $0x4,%esp
  801380:	68 c8 35 80 00       	push   $0x8035c8
  801385:	68 52 01 00 00       	push   $0x152
  80138a:	68 8b 34 80 00       	push   $0x80348b
  80138f:	e8 51 04 00 00       	call   8017e5 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != toAccess) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801394:	e8 5e 19 00 00       	call   802cf7 <sys_calculate_free_frames>
  801399:	89 c2                	mov    %eax,%edx
  80139b:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  8013a1:	29 c2                	sub    %eax,%edx
  8013a3:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8013a6:	39 c2                	cmp    %eax,%edx
  8013a8:	74 17                	je     8013c1 <_main+0x1389>
  8013aa:	83 ec 04             	sub    $0x4,%esp
  8013ad:	68 04 36 80 00       	push   $0x803604
  8013b2:	68 53 01 00 00       	push   $0x153
  8013b7:	68 8b 34 80 00       	push   $0x80348b
  8013bc:	e8 24 04 00 00       	call   8017e5 <_panic>

		//Free 1st 3 KB
		freeFrames = sys_calculate_free_frames() ;
  8013c1:	e8 31 19 00 00       	call   802cf7 <sys_calculate_free_frames>
  8013c6:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8013cc:	e8 a9 19 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  8013d1:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[2]);
  8013d7:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  8013dd:	83 ec 0c             	sub    $0xc,%esp
  8013e0:	50                   	push   %eax
  8013e1:	e8 3b 16 00 00       	call   802a21 <free>
  8013e6:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  8013e9:	e8 8c 19 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  8013ee:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  8013f4:	29 c2                	sub    %eax,%edx
  8013f6:	89 d0                	mov    %edx,%eax
  8013f8:	83 f8 01             	cmp    $0x1,%eax
  8013fb:	74 17                	je     801414 <_main+0x13dc>
  8013fd:	83 ec 04             	sub    $0x4,%esp
  801400:	68 c8 35 80 00       	push   $0x8035c8
  801405:	68 59 01 00 00       	push   $0x159
  80140a:	68 8b 34 80 00       	push   $0x80348b
  80140f:	e8 d1 03 00 00       	call   8017e5 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 1 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801414:	e8 de 18 00 00       	call   802cf7 <sys_calculate_free_frames>
  801419:	89 c2                	mov    %eax,%edx
  80141b:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801421:	29 c2                	sub    %eax,%edx
  801423:	89 d0                	mov    %edx,%eax
  801425:	83 f8 02             	cmp    $0x2,%eax
  801428:	74 17                	je     801441 <_main+0x1409>
  80142a:	83 ec 04             	sub    $0x4,%esp
  80142d:	68 04 36 80 00       	push   $0x803604
  801432:	68 5a 01 00 00       	push   $0x15a
  801437:	68 8b 34 80 00       	push   $0x80348b
  80143c:	e8 a4 03 00 00       	call   8017e5 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(intArr[0]));
  801441:	8b 45 88             	mov    -0x78(%ebp),%eax
  801444:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(intArr[lastIndexOfInt]));
  80144a:	8b 45 84             	mov    -0x7c(%ebp),%eax
  80144d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801454:	8b 45 88             	mov    -0x78(%ebp),%eax
  801457:	01 d0                	add    %edx,%eax
  801459:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  80145f:	83 ec 08             	sub    $0x8,%esp
  801462:	6a 02                	push   $0x2
  801464:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  80146a:	50                   	push   %eax
  80146b:	e8 5b 1d 00 00       	call   8031cb <sys_check_LRU_lists_free>
  801470:	83 c4 10             	add    $0x10,%esp
  801473:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  801479:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  801480:	74 17                	je     801499 <_main+0x1461>
		{
				panic("free: page is not removed from LRU lists");
  801482:	83 ec 04             	sub    $0x4,%esp
  801485:	68 50 36 80 00       	push   $0x803650
  80148a:	68 68 01 00 00       	push   $0x168
  80148f:	68 8b 34 80 00       	push   $0x80348b
  801494:	e8 4c 03 00 00       	call   8017e5 <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 794 && LIST_SIZE(&myEnv->SecondList) != 0)
  801499:	a1 20 40 80 00       	mov    0x804020,%eax
  80149e:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  8014a4:	3d 1a 03 00 00       	cmp    $0x31a,%eax
  8014a9:	74 26                	je     8014d1 <_main+0x1499>
  8014ab:	a1 20 40 80 00       	mov    0x804020,%eax
  8014b0:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  8014b6:	85 c0                	test   %eax,%eax
  8014b8:	74 17                	je     8014d1 <_main+0x1499>
		{
			panic("LRU lists content is not correct");
  8014ba:	83 ec 04             	sub    $0x4,%esp
  8014bd:	68 7c 36 80 00       	push   $0x80367c
  8014c2:	68 6d 01 00 00       	push   $0x16d
  8014c7:	68 8b 34 80 00       	push   $0x80348b
  8014cc:	e8 14 03 00 00       	call   8017e5 <_panic>
		}

		//Free 2nd 3 KB
		freeFrames = sys_calculate_free_frames() ;
  8014d1:	e8 21 18 00 00       	call   802cf7 <sys_calculate_free_frames>
  8014d6:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8014dc:	e8 99 18 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  8014e1:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[3]);
  8014e7:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  8014ed:	83 ec 0c             	sub    $0xc,%esp
  8014f0:	50                   	push   %eax
  8014f1:	e8 2b 15 00 00       	call   802a21 <free>
  8014f6:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  8014f9:	e8 7c 18 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  8014fe:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801504:	29 c2                	sub    %eax,%edx
  801506:	89 d0                	mov    %edx,%eax
  801508:	83 f8 01             	cmp    $0x1,%eax
  80150b:	74 17                	je     801524 <_main+0x14ec>
  80150d:	83 ec 04             	sub    $0x4,%esp
  801510:	68 c8 35 80 00       	push   $0x8035c8
  801515:	68 74 01 00 00       	push   $0x174
  80151a:	68 8b 34 80 00       	push   $0x80348b
  80151f:	e8 c1 02 00 00       	call   8017e5 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801524:	e8 ce 17 00 00       	call   802cf7 <sys_calculate_free_frames>
  801529:	89 c2                	mov    %eax,%edx
  80152b:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801531:	39 c2                	cmp    %eax,%edx
  801533:	74 17                	je     80154c <_main+0x1514>
  801535:	83 ec 04             	sub    $0x4,%esp
  801538:	68 04 36 80 00       	push   $0x803604
  80153d:	68 75 01 00 00       	push   $0x175
  801542:	68 8b 34 80 00       	push   $0x80348b
  801547:	e8 99 02 00 00       	call   8017e5 <_panic>

		//Free last 14 KB
		freeFrames = sys_calculate_free_frames() ;
  80154c:	e8 a6 17 00 00       	call   802cf7 <sys_calculate_free_frames>
  801551:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801557:	e8 1e 18 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  80155c:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[7]);
  801562:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  801568:	83 ec 0c             	sub    $0xc,%esp
  80156b:	50                   	push   %eax
  80156c:	e8 b0 14 00 00       	call   802a21 <free>
  801571:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 4) panic("Wrong free: Extra or less pages are removed from PageFile");
  801574:	e8 01 18 00 00       	call   802d7a <sys_pf_calculate_allocated_pages>
  801579:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  80157f:	29 c2                	sub    %eax,%edx
  801581:	89 d0                	mov    %edx,%eax
  801583:	83 f8 04             	cmp    $0x4,%eax
  801586:	74 17                	je     80159f <_main+0x1567>
  801588:	83 ec 04             	sub    $0x4,%esp
  80158b:	68 c8 35 80 00       	push   $0x8035c8
  801590:	68 7b 01 00 00       	push   $0x17b
  801595:	68 8b 34 80 00       	push   $0x80348b
  80159a:	e8 46 02 00 00       	call   8017e5 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80159f:	e8 53 17 00 00       	call   802cf7 <sys_calculate_free_frames>
  8015a4:	89 c2                	mov    %eax,%edx
  8015a6:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  8015ac:	29 c2                	sub    %eax,%edx
  8015ae:	89 d0                	mov    %edx,%eax
  8015b0:	83 f8 03             	cmp    $0x3,%eax
  8015b3:	74 17                	je     8015cc <_main+0x1594>
  8015b5:	83 ec 04             	sub    $0x4,%esp
  8015b8:	68 04 36 80 00       	push   $0x803604
  8015bd:	68 7c 01 00 00       	push   $0x17c
  8015c2:	68 8b 34 80 00       	push   $0x80348b
  8015c7:	e8 19 02 00 00       	call   8017e5 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(shortArr2[0]));
  8015cc:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  8015d2:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(shortArr2[lastIndexOfShort2]));
  8015d8:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  8015de:	01 c0                	add    %eax,%eax
  8015e0:	89 c2                	mov    %eax,%edx
  8015e2:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  8015e8:	01 d0                	add    %edx,%eax
  8015ea:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  8015f0:	83 ec 08             	sub    $0x8,%esp
  8015f3:	6a 02                	push   $0x2
  8015f5:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  8015fb:	50                   	push   %eax
  8015fc:	e8 ca 1b 00 00       	call   8031cb <sys_check_LRU_lists_free>
  801601:	83 c4 10             	add    $0x10,%esp
  801604:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  80160a:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  801611:	74 17                	je     80162a <_main+0x15f2>
		{
				panic("free: page is not removed from LRU lists");
  801613:	83 ec 04             	sub    $0x4,%esp
  801616:	68 50 36 80 00       	push   $0x803650
  80161b:	68 8a 01 00 00       	push   $0x18a
  801620:	68 8b 34 80 00       	push   $0x80348b
  801625:	e8 bb 01 00 00       	call   8017e5 <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 792 && LIST_SIZE(&myEnv->SecondList) != 0)
  80162a:	a1 20 40 80 00       	mov    0x804020,%eax
  80162f:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  801635:	3d 18 03 00 00       	cmp    $0x318,%eax
  80163a:	74 26                	je     801662 <_main+0x162a>
  80163c:	a1 20 40 80 00       	mov    0x804020,%eax
  801641:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  801647:	85 c0                	test   %eax,%eax
  801649:	74 17                	je     801662 <_main+0x162a>
		{
			panic("LRU lists content is not correct");
  80164b:	83 ec 04             	sub    $0x4,%esp
  80164e:	68 7c 36 80 00       	push   $0x80367c
  801653:	68 8f 01 00 00       	push   $0x18f
  801658:	68 8b 34 80 00       	push   $0x80348b
  80165d:	e8 83 01 00 00       	call   8017e5 <_panic>
		}

			if(start_freeFrames != (sys_calculate_free_frames() + 4)) {panic("Wrong free: not all pages removed correctly at end");}
  801662:	e8 90 16 00 00       	call   802cf7 <sys_calculate_free_frames>
  801667:	8d 50 04             	lea    0x4(%eax),%edx
  80166a:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80166d:	39 c2                	cmp    %eax,%edx
  80166f:	74 17                	je     801688 <_main+0x1650>
  801671:	83 ec 04             	sub    $0x4,%esp
  801674:	68 a0 36 80 00       	push   $0x8036a0
  801679:	68 92 01 00 00       	push   $0x192
  80167e:	68 8b 34 80 00       	push   $0x80348b
  801683:	e8 5d 01 00 00       	call   8017e5 <_panic>
		}

		cprintf("Congratulations!! test free [1] completed successfully.\n");
  801688:	83 ec 0c             	sub    $0xc,%esp
  80168b:	68 d4 36 80 00       	push   $0x8036d4
  801690:	e8 f2 03 00 00       	call   801a87 <cprintf>
  801695:	83 c4 10             	add    $0x10,%esp

	return;
  801698:	90                   	nop
}
  801699:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80169c:	5b                   	pop    %ebx
  80169d:	5f                   	pop    %edi
  80169e:	5d                   	pop    %ebp
  80169f:	c3                   	ret    

008016a0 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8016a0:	55                   	push   %ebp
  8016a1:	89 e5                	mov    %esp,%ebp
  8016a3:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8016a6:	e8 81 15 00 00       	call   802c2c <sys_getenvindex>
  8016ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8016ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8016b1:	89 d0                	mov    %edx,%eax
  8016b3:	c1 e0 03             	shl    $0x3,%eax
  8016b6:	01 d0                	add    %edx,%eax
  8016b8:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8016bf:	01 c8                	add    %ecx,%eax
  8016c1:	01 c0                	add    %eax,%eax
  8016c3:	01 d0                	add    %edx,%eax
  8016c5:	01 c0                	add    %eax,%eax
  8016c7:	01 d0                	add    %edx,%eax
  8016c9:	89 c2                	mov    %eax,%edx
  8016cb:	c1 e2 05             	shl    $0x5,%edx
  8016ce:	29 c2                	sub    %eax,%edx
  8016d0:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8016d7:	89 c2                	mov    %eax,%edx
  8016d9:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8016df:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8016e4:	a1 20 40 80 00       	mov    0x804020,%eax
  8016e9:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8016ef:	84 c0                	test   %al,%al
  8016f1:	74 0f                	je     801702 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8016f3:	a1 20 40 80 00       	mov    0x804020,%eax
  8016f8:	05 40 3c 01 00       	add    $0x13c40,%eax
  8016fd:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  801702:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801706:	7e 0a                	jle    801712 <libmain+0x72>
		binaryname = argv[0];
  801708:	8b 45 0c             	mov    0xc(%ebp),%eax
  80170b:	8b 00                	mov    (%eax),%eax
  80170d:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  801712:	83 ec 08             	sub    $0x8,%esp
  801715:	ff 75 0c             	pushl  0xc(%ebp)
  801718:	ff 75 08             	pushl  0x8(%ebp)
  80171b:	e8 18 e9 ff ff       	call   800038 <_main>
  801720:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  801723:	e8 9f 16 00 00       	call   802dc7 <sys_disable_interrupt>
	cprintf("**************************************\n");
  801728:	83 ec 0c             	sub    $0xc,%esp
  80172b:	68 28 37 80 00       	push   $0x803728
  801730:	e8 52 03 00 00       	call   801a87 <cprintf>
  801735:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  801738:	a1 20 40 80 00       	mov    0x804020,%eax
  80173d:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  801743:	a1 20 40 80 00       	mov    0x804020,%eax
  801748:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80174e:	83 ec 04             	sub    $0x4,%esp
  801751:	52                   	push   %edx
  801752:	50                   	push   %eax
  801753:	68 50 37 80 00       	push   $0x803750
  801758:	e8 2a 03 00 00       	call   801a87 <cprintf>
  80175d:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  801760:	a1 20 40 80 00       	mov    0x804020,%eax
  801765:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80176b:	a1 20 40 80 00       	mov    0x804020,%eax
  801770:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  801776:	83 ec 04             	sub    $0x4,%esp
  801779:	52                   	push   %edx
  80177a:	50                   	push   %eax
  80177b:	68 78 37 80 00       	push   $0x803778
  801780:	e8 02 03 00 00       	call   801a87 <cprintf>
  801785:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  801788:	a1 20 40 80 00       	mov    0x804020,%eax
  80178d:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  801793:	83 ec 08             	sub    $0x8,%esp
  801796:	50                   	push   %eax
  801797:	68 b9 37 80 00       	push   $0x8037b9
  80179c:	e8 e6 02 00 00       	call   801a87 <cprintf>
  8017a1:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8017a4:	83 ec 0c             	sub    $0xc,%esp
  8017a7:	68 28 37 80 00       	push   $0x803728
  8017ac:	e8 d6 02 00 00       	call   801a87 <cprintf>
  8017b1:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8017b4:	e8 28 16 00 00       	call   802de1 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8017b9:	e8 19 00 00 00       	call   8017d7 <exit>
}
  8017be:	90                   	nop
  8017bf:	c9                   	leave  
  8017c0:	c3                   	ret    

008017c1 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8017c1:	55                   	push   %ebp
  8017c2:	89 e5                	mov    %esp,%ebp
  8017c4:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8017c7:	83 ec 0c             	sub    $0xc,%esp
  8017ca:	6a 00                	push   $0x0
  8017cc:	e8 27 14 00 00       	call   802bf8 <sys_env_destroy>
  8017d1:	83 c4 10             	add    $0x10,%esp
}
  8017d4:	90                   	nop
  8017d5:	c9                   	leave  
  8017d6:	c3                   	ret    

008017d7 <exit>:

void
exit(void)
{
  8017d7:	55                   	push   %ebp
  8017d8:	89 e5                	mov    %esp,%ebp
  8017da:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8017dd:	e8 7c 14 00 00       	call   802c5e <sys_env_exit>
}
  8017e2:	90                   	nop
  8017e3:	c9                   	leave  
  8017e4:	c3                   	ret    

008017e5 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8017e5:	55                   	push   %ebp
  8017e6:	89 e5                	mov    %esp,%ebp
  8017e8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8017eb:	8d 45 10             	lea    0x10(%ebp),%eax
  8017ee:	83 c0 04             	add    $0x4,%eax
  8017f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8017f4:	a1 18 41 80 00       	mov    0x804118,%eax
  8017f9:	85 c0                	test   %eax,%eax
  8017fb:	74 16                	je     801813 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8017fd:	a1 18 41 80 00       	mov    0x804118,%eax
  801802:	83 ec 08             	sub    $0x8,%esp
  801805:	50                   	push   %eax
  801806:	68 d0 37 80 00       	push   $0x8037d0
  80180b:	e8 77 02 00 00       	call   801a87 <cprintf>
  801810:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801813:	a1 00 40 80 00       	mov    0x804000,%eax
  801818:	ff 75 0c             	pushl  0xc(%ebp)
  80181b:	ff 75 08             	pushl  0x8(%ebp)
  80181e:	50                   	push   %eax
  80181f:	68 d5 37 80 00       	push   $0x8037d5
  801824:	e8 5e 02 00 00       	call   801a87 <cprintf>
  801829:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80182c:	8b 45 10             	mov    0x10(%ebp),%eax
  80182f:	83 ec 08             	sub    $0x8,%esp
  801832:	ff 75 f4             	pushl  -0xc(%ebp)
  801835:	50                   	push   %eax
  801836:	e8 e1 01 00 00       	call   801a1c <vcprintf>
  80183b:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80183e:	83 ec 08             	sub    $0x8,%esp
  801841:	6a 00                	push   $0x0
  801843:	68 f1 37 80 00       	push   $0x8037f1
  801848:	e8 cf 01 00 00       	call   801a1c <vcprintf>
  80184d:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801850:	e8 82 ff ff ff       	call   8017d7 <exit>

	// should not return here
	while (1) ;
  801855:	eb fe                	jmp    801855 <_panic+0x70>

00801857 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801857:	55                   	push   %ebp
  801858:	89 e5                	mov    %esp,%ebp
  80185a:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80185d:	a1 20 40 80 00       	mov    0x804020,%eax
  801862:	8b 50 74             	mov    0x74(%eax),%edx
  801865:	8b 45 0c             	mov    0xc(%ebp),%eax
  801868:	39 c2                	cmp    %eax,%edx
  80186a:	74 14                	je     801880 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80186c:	83 ec 04             	sub    $0x4,%esp
  80186f:	68 f4 37 80 00       	push   $0x8037f4
  801874:	6a 26                	push   $0x26
  801876:	68 40 38 80 00       	push   $0x803840
  80187b:	e8 65 ff ff ff       	call   8017e5 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801880:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801887:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80188e:	e9 b6 00 00 00       	jmp    801949 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801893:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801896:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80189d:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a0:	01 d0                	add    %edx,%eax
  8018a2:	8b 00                	mov    (%eax),%eax
  8018a4:	85 c0                	test   %eax,%eax
  8018a6:	75 08                	jne    8018b0 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8018a8:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8018ab:	e9 96 00 00 00       	jmp    801946 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8018b0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8018b7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8018be:	eb 5d                	jmp    80191d <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8018c0:	a1 20 40 80 00       	mov    0x804020,%eax
  8018c5:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8018cb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8018ce:	c1 e2 04             	shl    $0x4,%edx
  8018d1:	01 d0                	add    %edx,%eax
  8018d3:	8a 40 04             	mov    0x4(%eax),%al
  8018d6:	84 c0                	test   %al,%al
  8018d8:	75 40                	jne    80191a <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8018da:	a1 20 40 80 00       	mov    0x804020,%eax
  8018df:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8018e5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8018e8:	c1 e2 04             	shl    $0x4,%edx
  8018eb:	01 d0                	add    %edx,%eax
  8018ed:	8b 00                	mov    (%eax),%eax
  8018ef:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8018f2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8018f5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8018fa:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8018fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018ff:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801906:	8b 45 08             	mov    0x8(%ebp),%eax
  801909:	01 c8                	add    %ecx,%eax
  80190b:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80190d:	39 c2                	cmp    %eax,%edx
  80190f:	75 09                	jne    80191a <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  801911:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801918:	eb 12                	jmp    80192c <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80191a:	ff 45 e8             	incl   -0x18(%ebp)
  80191d:	a1 20 40 80 00       	mov    0x804020,%eax
  801922:	8b 50 74             	mov    0x74(%eax),%edx
  801925:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801928:	39 c2                	cmp    %eax,%edx
  80192a:	77 94                	ja     8018c0 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80192c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801930:	75 14                	jne    801946 <CheckWSWithoutLastIndex+0xef>
			panic(
  801932:	83 ec 04             	sub    $0x4,%esp
  801935:	68 4c 38 80 00       	push   $0x80384c
  80193a:	6a 3a                	push   $0x3a
  80193c:	68 40 38 80 00       	push   $0x803840
  801941:	e8 9f fe ff ff       	call   8017e5 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801946:	ff 45 f0             	incl   -0x10(%ebp)
  801949:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80194c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80194f:	0f 8c 3e ff ff ff    	jl     801893 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801955:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80195c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801963:	eb 20                	jmp    801985 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801965:	a1 20 40 80 00       	mov    0x804020,%eax
  80196a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801970:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801973:	c1 e2 04             	shl    $0x4,%edx
  801976:	01 d0                	add    %edx,%eax
  801978:	8a 40 04             	mov    0x4(%eax),%al
  80197b:	3c 01                	cmp    $0x1,%al
  80197d:	75 03                	jne    801982 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80197f:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801982:	ff 45 e0             	incl   -0x20(%ebp)
  801985:	a1 20 40 80 00       	mov    0x804020,%eax
  80198a:	8b 50 74             	mov    0x74(%eax),%edx
  80198d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801990:	39 c2                	cmp    %eax,%edx
  801992:	77 d1                	ja     801965 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801994:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801997:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80199a:	74 14                	je     8019b0 <CheckWSWithoutLastIndex+0x159>
		panic(
  80199c:	83 ec 04             	sub    $0x4,%esp
  80199f:	68 a0 38 80 00       	push   $0x8038a0
  8019a4:	6a 44                	push   $0x44
  8019a6:	68 40 38 80 00       	push   $0x803840
  8019ab:	e8 35 fe ff ff       	call   8017e5 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8019b0:	90                   	nop
  8019b1:	c9                   	leave  
  8019b2:	c3                   	ret    

008019b3 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8019b3:	55                   	push   %ebp
  8019b4:	89 e5                	mov    %esp,%ebp
  8019b6:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8019b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019bc:	8b 00                	mov    (%eax),%eax
  8019be:	8d 48 01             	lea    0x1(%eax),%ecx
  8019c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019c4:	89 0a                	mov    %ecx,(%edx)
  8019c6:	8b 55 08             	mov    0x8(%ebp),%edx
  8019c9:	88 d1                	mov    %dl,%cl
  8019cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019ce:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8019d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019d5:	8b 00                	mov    (%eax),%eax
  8019d7:	3d ff 00 00 00       	cmp    $0xff,%eax
  8019dc:	75 2c                	jne    801a0a <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8019de:	a0 24 40 80 00       	mov    0x804024,%al
  8019e3:	0f b6 c0             	movzbl %al,%eax
  8019e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019e9:	8b 12                	mov    (%edx),%edx
  8019eb:	89 d1                	mov    %edx,%ecx
  8019ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019f0:	83 c2 08             	add    $0x8,%edx
  8019f3:	83 ec 04             	sub    $0x4,%esp
  8019f6:	50                   	push   %eax
  8019f7:	51                   	push   %ecx
  8019f8:	52                   	push   %edx
  8019f9:	e8 b8 11 00 00       	call   802bb6 <sys_cputs>
  8019fe:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  801a01:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a04:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  801a0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a0d:	8b 40 04             	mov    0x4(%eax),%eax
  801a10:	8d 50 01             	lea    0x1(%eax),%edx
  801a13:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a16:	89 50 04             	mov    %edx,0x4(%eax)
}
  801a19:	90                   	nop
  801a1a:	c9                   	leave  
  801a1b:	c3                   	ret    

00801a1c <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  801a1c:	55                   	push   %ebp
  801a1d:	89 e5                	mov    %esp,%ebp
  801a1f:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  801a25:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  801a2c:	00 00 00 
	b.cnt = 0;
  801a2f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  801a36:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  801a39:	ff 75 0c             	pushl  0xc(%ebp)
  801a3c:	ff 75 08             	pushl  0x8(%ebp)
  801a3f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801a45:	50                   	push   %eax
  801a46:	68 b3 19 80 00       	push   $0x8019b3
  801a4b:	e8 11 02 00 00       	call   801c61 <vprintfmt>
  801a50:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  801a53:	a0 24 40 80 00       	mov    0x804024,%al
  801a58:	0f b6 c0             	movzbl %al,%eax
  801a5b:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  801a61:	83 ec 04             	sub    $0x4,%esp
  801a64:	50                   	push   %eax
  801a65:	52                   	push   %edx
  801a66:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801a6c:	83 c0 08             	add    $0x8,%eax
  801a6f:	50                   	push   %eax
  801a70:	e8 41 11 00 00       	call   802bb6 <sys_cputs>
  801a75:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801a78:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  801a7f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801a85:	c9                   	leave  
  801a86:	c3                   	ret    

00801a87 <cprintf>:

int cprintf(const char *fmt, ...) {
  801a87:	55                   	push   %ebp
  801a88:	89 e5                	mov    %esp,%ebp
  801a8a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  801a8d:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  801a94:	8d 45 0c             	lea    0xc(%ebp),%eax
  801a97:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801a9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9d:	83 ec 08             	sub    $0x8,%esp
  801aa0:	ff 75 f4             	pushl  -0xc(%ebp)
  801aa3:	50                   	push   %eax
  801aa4:	e8 73 ff ff ff       	call   801a1c <vcprintf>
  801aa9:	83 c4 10             	add    $0x10,%esp
  801aac:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  801aaf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ab2:	c9                   	leave  
  801ab3:	c3                   	ret    

00801ab4 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801ab4:	55                   	push   %ebp
  801ab5:	89 e5                	mov    %esp,%ebp
  801ab7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801aba:	e8 08 13 00 00       	call   802dc7 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801abf:	8d 45 0c             	lea    0xc(%ebp),%eax
  801ac2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801ac5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac8:	83 ec 08             	sub    $0x8,%esp
  801acb:	ff 75 f4             	pushl  -0xc(%ebp)
  801ace:	50                   	push   %eax
  801acf:	e8 48 ff ff ff       	call   801a1c <vcprintf>
  801ad4:	83 c4 10             	add    $0x10,%esp
  801ad7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801ada:	e8 02 13 00 00       	call   802de1 <sys_enable_interrupt>
	return cnt;
  801adf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ae2:	c9                   	leave  
  801ae3:	c3                   	ret    

00801ae4 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801ae4:	55                   	push   %ebp
  801ae5:	89 e5                	mov    %esp,%ebp
  801ae7:	53                   	push   %ebx
  801ae8:	83 ec 14             	sub    $0x14,%esp
  801aeb:	8b 45 10             	mov    0x10(%ebp),%eax
  801aee:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801af1:	8b 45 14             	mov    0x14(%ebp),%eax
  801af4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801af7:	8b 45 18             	mov    0x18(%ebp),%eax
  801afa:	ba 00 00 00 00       	mov    $0x0,%edx
  801aff:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801b02:	77 55                	ja     801b59 <printnum+0x75>
  801b04:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801b07:	72 05                	jb     801b0e <printnum+0x2a>
  801b09:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b0c:	77 4b                	ja     801b59 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801b0e:	8b 45 1c             	mov    0x1c(%ebp),%eax
  801b11:	8d 58 ff             	lea    -0x1(%eax),%ebx
  801b14:	8b 45 18             	mov    0x18(%ebp),%eax
  801b17:	ba 00 00 00 00       	mov    $0x0,%edx
  801b1c:	52                   	push   %edx
  801b1d:	50                   	push   %eax
  801b1e:	ff 75 f4             	pushl  -0xc(%ebp)
  801b21:	ff 75 f0             	pushl  -0x10(%ebp)
  801b24:	e8 bf 16 00 00       	call   8031e8 <__udivdi3>
  801b29:	83 c4 10             	add    $0x10,%esp
  801b2c:	83 ec 04             	sub    $0x4,%esp
  801b2f:	ff 75 20             	pushl  0x20(%ebp)
  801b32:	53                   	push   %ebx
  801b33:	ff 75 18             	pushl  0x18(%ebp)
  801b36:	52                   	push   %edx
  801b37:	50                   	push   %eax
  801b38:	ff 75 0c             	pushl  0xc(%ebp)
  801b3b:	ff 75 08             	pushl  0x8(%ebp)
  801b3e:	e8 a1 ff ff ff       	call   801ae4 <printnum>
  801b43:	83 c4 20             	add    $0x20,%esp
  801b46:	eb 1a                	jmp    801b62 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801b48:	83 ec 08             	sub    $0x8,%esp
  801b4b:	ff 75 0c             	pushl  0xc(%ebp)
  801b4e:	ff 75 20             	pushl  0x20(%ebp)
  801b51:	8b 45 08             	mov    0x8(%ebp),%eax
  801b54:	ff d0                	call   *%eax
  801b56:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801b59:	ff 4d 1c             	decl   0x1c(%ebp)
  801b5c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801b60:	7f e6                	jg     801b48 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801b62:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801b65:	bb 00 00 00 00       	mov    $0x0,%ebx
  801b6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b6d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b70:	53                   	push   %ebx
  801b71:	51                   	push   %ecx
  801b72:	52                   	push   %edx
  801b73:	50                   	push   %eax
  801b74:	e8 7f 17 00 00       	call   8032f8 <__umoddi3>
  801b79:	83 c4 10             	add    $0x10,%esp
  801b7c:	05 14 3b 80 00       	add    $0x803b14,%eax
  801b81:	8a 00                	mov    (%eax),%al
  801b83:	0f be c0             	movsbl %al,%eax
  801b86:	83 ec 08             	sub    $0x8,%esp
  801b89:	ff 75 0c             	pushl  0xc(%ebp)
  801b8c:	50                   	push   %eax
  801b8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b90:	ff d0                	call   *%eax
  801b92:	83 c4 10             	add    $0x10,%esp
}
  801b95:	90                   	nop
  801b96:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b99:	c9                   	leave  
  801b9a:	c3                   	ret    

00801b9b <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801b9b:	55                   	push   %ebp
  801b9c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801b9e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801ba2:	7e 1c                	jle    801bc0 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba7:	8b 00                	mov    (%eax),%eax
  801ba9:	8d 50 08             	lea    0x8(%eax),%edx
  801bac:	8b 45 08             	mov    0x8(%ebp),%eax
  801baf:	89 10                	mov    %edx,(%eax)
  801bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb4:	8b 00                	mov    (%eax),%eax
  801bb6:	83 e8 08             	sub    $0x8,%eax
  801bb9:	8b 50 04             	mov    0x4(%eax),%edx
  801bbc:	8b 00                	mov    (%eax),%eax
  801bbe:	eb 40                	jmp    801c00 <getuint+0x65>
	else if (lflag)
  801bc0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801bc4:	74 1e                	je     801be4 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801bc6:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc9:	8b 00                	mov    (%eax),%eax
  801bcb:	8d 50 04             	lea    0x4(%eax),%edx
  801bce:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd1:	89 10                	mov    %edx,(%eax)
  801bd3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd6:	8b 00                	mov    (%eax),%eax
  801bd8:	83 e8 04             	sub    $0x4,%eax
  801bdb:	8b 00                	mov    (%eax),%eax
  801bdd:	ba 00 00 00 00       	mov    $0x0,%edx
  801be2:	eb 1c                	jmp    801c00 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801be4:	8b 45 08             	mov    0x8(%ebp),%eax
  801be7:	8b 00                	mov    (%eax),%eax
  801be9:	8d 50 04             	lea    0x4(%eax),%edx
  801bec:	8b 45 08             	mov    0x8(%ebp),%eax
  801bef:	89 10                	mov    %edx,(%eax)
  801bf1:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf4:	8b 00                	mov    (%eax),%eax
  801bf6:	83 e8 04             	sub    $0x4,%eax
  801bf9:	8b 00                	mov    (%eax),%eax
  801bfb:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801c00:	5d                   	pop    %ebp
  801c01:	c3                   	ret    

00801c02 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801c02:	55                   	push   %ebp
  801c03:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801c05:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801c09:	7e 1c                	jle    801c27 <getint+0x25>
		return va_arg(*ap, long long);
  801c0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0e:	8b 00                	mov    (%eax),%eax
  801c10:	8d 50 08             	lea    0x8(%eax),%edx
  801c13:	8b 45 08             	mov    0x8(%ebp),%eax
  801c16:	89 10                	mov    %edx,(%eax)
  801c18:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1b:	8b 00                	mov    (%eax),%eax
  801c1d:	83 e8 08             	sub    $0x8,%eax
  801c20:	8b 50 04             	mov    0x4(%eax),%edx
  801c23:	8b 00                	mov    (%eax),%eax
  801c25:	eb 38                	jmp    801c5f <getint+0x5d>
	else if (lflag)
  801c27:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801c2b:	74 1a                	je     801c47 <getint+0x45>
		return va_arg(*ap, long);
  801c2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c30:	8b 00                	mov    (%eax),%eax
  801c32:	8d 50 04             	lea    0x4(%eax),%edx
  801c35:	8b 45 08             	mov    0x8(%ebp),%eax
  801c38:	89 10                	mov    %edx,(%eax)
  801c3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3d:	8b 00                	mov    (%eax),%eax
  801c3f:	83 e8 04             	sub    $0x4,%eax
  801c42:	8b 00                	mov    (%eax),%eax
  801c44:	99                   	cltd   
  801c45:	eb 18                	jmp    801c5f <getint+0x5d>
	else
		return va_arg(*ap, int);
  801c47:	8b 45 08             	mov    0x8(%ebp),%eax
  801c4a:	8b 00                	mov    (%eax),%eax
  801c4c:	8d 50 04             	lea    0x4(%eax),%edx
  801c4f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c52:	89 10                	mov    %edx,(%eax)
  801c54:	8b 45 08             	mov    0x8(%ebp),%eax
  801c57:	8b 00                	mov    (%eax),%eax
  801c59:	83 e8 04             	sub    $0x4,%eax
  801c5c:	8b 00                	mov    (%eax),%eax
  801c5e:	99                   	cltd   
}
  801c5f:	5d                   	pop    %ebp
  801c60:	c3                   	ret    

00801c61 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801c61:	55                   	push   %ebp
  801c62:	89 e5                	mov    %esp,%ebp
  801c64:	56                   	push   %esi
  801c65:	53                   	push   %ebx
  801c66:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801c69:	eb 17                	jmp    801c82 <vprintfmt+0x21>
			if (ch == '\0')
  801c6b:	85 db                	test   %ebx,%ebx
  801c6d:	0f 84 af 03 00 00    	je     802022 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801c73:	83 ec 08             	sub    $0x8,%esp
  801c76:	ff 75 0c             	pushl  0xc(%ebp)
  801c79:	53                   	push   %ebx
  801c7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7d:	ff d0                	call   *%eax
  801c7f:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801c82:	8b 45 10             	mov    0x10(%ebp),%eax
  801c85:	8d 50 01             	lea    0x1(%eax),%edx
  801c88:	89 55 10             	mov    %edx,0x10(%ebp)
  801c8b:	8a 00                	mov    (%eax),%al
  801c8d:	0f b6 d8             	movzbl %al,%ebx
  801c90:	83 fb 25             	cmp    $0x25,%ebx
  801c93:	75 d6                	jne    801c6b <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801c95:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801c99:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801ca0:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801ca7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801cae:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801cb5:	8b 45 10             	mov    0x10(%ebp),%eax
  801cb8:	8d 50 01             	lea    0x1(%eax),%edx
  801cbb:	89 55 10             	mov    %edx,0x10(%ebp)
  801cbe:	8a 00                	mov    (%eax),%al
  801cc0:	0f b6 d8             	movzbl %al,%ebx
  801cc3:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801cc6:	83 f8 55             	cmp    $0x55,%eax
  801cc9:	0f 87 2b 03 00 00    	ja     801ffa <vprintfmt+0x399>
  801ccf:	8b 04 85 38 3b 80 00 	mov    0x803b38(,%eax,4),%eax
  801cd6:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801cd8:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801cdc:	eb d7                	jmp    801cb5 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801cde:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801ce2:	eb d1                	jmp    801cb5 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801ce4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801ceb:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801cee:	89 d0                	mov    %edx,%eax
  801cf0:	c1 e0 02             	shl    $0x2,%eax
  801cf3:	01 d0                	add    %edx,%eax
  801cf5:	01 c0                	add    %eax,%eax
  801cf7:	01 d8                	add    %ebx,%eax
  801cf9:	83 e8 30             	sub    $0x30,%eax
  801cfc:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801cff:	8b 45 10             	mov    0x10(%ebp),%eax
  801d02:	8a 00                	mov    (%eax),%al
  801d04:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801d07:	83 fb 2f             	cmp    $0x2f,%ebx
  801d0a:	7e 3e                	jle    801d4a <vprintfmt+0xe9>
  801d0c:	83 fb 39             	cmp    $0x39,%ebx
  801d0f:	7f 39                	jg     801d4a <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801d11:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801d14:	eb d5                	jmp    801ceb <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801d16:	8b 45 14             	mov    0x14(%ebp),%eax
  801d19:	83 c0 04             	add    $0x4,%eax
  801d1c:	89 45 14             	mov    %eax,0x14(%ebp)
  801d1f:	8b 45 14             	mov    0x14(%ebp),%eax
  801d22:	83 e8 04             	sub    $0x4,%eax
  801d25:	8b 00                	mov    (%eax),%eax
  801d27:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801d2a:	eb 1f                	jmp    801d4b <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801d2c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801d30:	79 83                	jns    801cb5 <vprintfmt+0x54>
				width = 0;
  801d32:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801d39:	e9 77 ff ff ff       	jmp    801cb5 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801d3e:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801d45:	e9 6b ff ff ff       	jmp    801cb5 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801d4a:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801d4b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801d4f:	0f 89 60 ff ff ff    	jns    801cb5 <vprintfmt+0x54>
				width = precision, precision = -1;
  801d55:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801d58:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801d5b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801d62:	e9 4e ff ff ff       	jmp    801cb5 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801d67:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801d6a:	e9 46 ff ff ff       	jmp    801cb5 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801d6f:	8b 45 14             	mov    0x14(%ebp),%eax
  801d72:	83 c0 04             	add    $0x4,%eax
  801d75:	89 45 14             	mov    %eax,0x14(%ebp)
  801d78:	8b 45 14             	mov    0x14(%ebp),%eax
  801d7b:	83 e8 04             	sub    $0x4,%eax
  801d7e:	8b 00                	mov    (%eax),%eax
  801d80:	83 ec 08             	sub    $0x8,%esp
  801d83:	ff 75 0c             	pushl  0xc(%ebp)
  801d86:	50                   	push   %eax
  801d87:	8b 45 08             	mov    0x8(%ebp),%eax
  801d8a:	ff d0                	call   *%eax
  801d8c:	83 c4 10             	add    $0x10,%esp
			break;
  801d8f:	e9 89 02 00 00       	jmp    80201d <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801d94:	8b 45 14             	mov    0x14(%ebp),%eax
  801d97:	83 c0 04             	add    $0x4,%eax
  801d9a:	89 45 14             	mov    %eax,0x14(%ebp)
  801d9d:	8b 45 14             	mov    0x14(%ebp),%eax
  801da0:	83 e8 04             	sub    $0x4,%eax
  801da3:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801da5:	85 db                	test   %ebx,%ebx
  801da7:	79 02                	jns    801dab <vprintfmt+0x14a>
				err = -err;
  801da9:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801dab:	83 fb 64             	cmp    $0x64,%ebx
  801dae:	7f 0b                	jg     801dbb <vprintfmt+0x15a>
  801db0:	8b 34 9d 80 39 80 00 	mov    0x803980(,%ebx,4),%esi
  801db7:	85 f6                	test   %esi,%esi
  801db9:	75 19                	jne    801dd4 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801dbb:	53                   	push   %ebx
  801dbc:	68 25 3b 80 00       	push   $0x803b25
  801dc1:	ff 75 0c             	pushl  0xc(%ebp)
  801dc4:	ff 75 08             	pushl  0x8(%ebp)
  801dc7:	e8 5e 02 00 00       	call   80202a <printfmt>
  801dcc:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801dcf:	e9 49 02 00 00       	jmp    80201d <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801dd4:	56                   	push   %esi
  801dd5:	68 2e 3b 80 00       	push   $0x803b2e
  801dda:	ff 75 0c             	pushl  0xc(%ebp)
  801ddd:	ff 75 08             	pushl  0x8(%ebp)
  801de0:	e8 45 02 00 00       	call   80202a <printfmt>
  801de5:	83 c4 10             	add    $0x10,%esp
			break;
  801de8:	e9 30 02 00 00       	jmp    80201d <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801ded:	8b 45 14             	mov    0x14(%ebp),%eax
  801df0:	83 c0 04             	add    $0x4,%eax
  801df3:	89 45 14             	mov    %eax,0x14(%ebp)
  801df6:	8b 45 14             	mov    0x14(%ebp),%eax
  801df9:	83 e8 04             	sub    $0x4,%eax
  801dfc:	8b 30                	mov    (%eax),%esi
  801dfe:	85 f6                	test   %esi,%esi
  801e00:	75 05                	jne    801e07 <vprintfmt+0x1a6>
				p = "(null)";
  801e02:	be 31 3b 80 00       	mov    $0x803b31,%esi
			if (width > 0 && padc != '-')
  801e07:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801e0b:	7e 6d                	jle    801e7a <vprintfmt+0x219>
  801e0d:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801e11:	74 67                	je     801e7a <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801e13:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801e16:	83 ec 08             	sub    $0x8,%esp
  801e19:	50                   	push   %eax
  801e1a:	56                   	push   %esi
  801e1b:	e8 0c 03 00 00       	call   80212c <strnlen>
  801e20:	83 c4 10             	add    $0x10,%esp
  801e23:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801e26:	eb 16                	jmp    801e3e <vprintfmt+0x1dd>
					putch(padc, putdat);
  801e28:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801e2c:	83 ec 08             	sub    $0x8,%esp
  801e2f:	ff 75 0c             	pushl  0xc(%ebp)
  801e32:	50                   	push   %eax
  801e33:	8b 45 08             	mov    0x8(%ebp),%eax
  801e36:	ff d0                	call   *%eax
  801e38:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801e3b:	ff 4d e4             	decl   -0x1c(%ebp)
  801e3e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801e42:	7f e4                	jg     801e28 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801e44:	eb 34                	jmp    801e7a <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801e46:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801e4a:	74 1c                	je     801e68 <vprintfmt+0x207>
  801e4c:	83 fb 1f             	cmp    $0x1f,%ebx
  801e4f:	7e 05                	jle    801e56 <vprintfmt+0x1f5>
  801e51:	83 fb 7e             	cmp    $0x7e,%ebx
  801e54:	7e 12                	jle    801e68 <vprintfmt+0x207>
					putch('?', putdat);
  801e56:	83 ec 08             	sub    $0x8,%esp
  801e59:	ff 75 0c             	pushl  0xc(%ebp)
  801e5c:	6a 3f                	push   $0x3f
  801e5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e61:	ff d0                	call   *%eax
  801e63:	83 c4 10             	add    $0x10,%esp
  801e66:	eb 0f                	jmp    801e77 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801e68:	83 ec 08             	sub    $0x8,%esp
  801e6b:	ff 75 0c             	pushl  0xc(%ebp)
  801e6e:	53                   	push   %ebx
  801e6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e72:	ff d0                	call   *%eax
  801e74:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801e77:	ff 4d e4             	decl   -0x1c(%ebp)
  801e7a:	89 f0                	mov    %esi,%eax
  801e7c:	8d 70 01             	lea    0x1(%eax),%esi
  801e7f:	8a 00                	mov    (%eax),%al
  801e81:	0f be d8             	movsbl %al,%ebx
  801e84:	85 db                	test   %ebx,%ebx
  801e86:	74 24                	je     801eac <vprintfmt+0x24b>
  801e88:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801e8c:	78 b8                	js     801e46 <vprintfmt+0x1e5>
  801e8e:	ff 4d e0             	decl   -0x20(%ebp)
  801e91:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801e95:	79 af                	jns    801e46 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801e97:	eb 13                	jmp    801eac <vprintfmt+0x24b>
				putch(' ', putdat);
  801e99:	83 ec 08             	sub    $0x8,%esp
  801e9c:	ff 75 0c             	pushl  0xc(%ebp)
  801e9f:	6a 20                	push   $0x20
  801ea1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea4:	ff d0                	call   *%eax
  801ea6:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801ea9:	ff 4d e4             	decl   -0x1c(%ebp)
  801eac:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801eb0:	7f e7                	jg     801e99 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801eb2:	e9 66 01 00 00       	jmp    80201d <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801eb7:	83 ec 08             	sub    $0x8,%esp
  801eba:	ff 75 e8             	pushl  -0x18(%ebp)
  801ebd:	8d 45 14             	lea    0x14(%ebp),%eax
  801ec0:	50                   	push   %eax
  801ec1:	e8 3c fd ff ff       	call   801c02 <getint>
  801ec6:	83 c4 10             	add    $0x10,%esp
  801ec9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801ecc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801ecf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ed2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801ed5:	85 d2                	test   %edx,%edx
  801ed7:	79 23                	jns    801efc <vprintfmt+0x29b>
				putch('-', putdat);
  801ed9:	83 ec 08             	sub    $0x8,%esp
  801edc:	ff 75 0c             	pushl  0xc(%ebp)
  801edf:	6a 2d                	push   $0x2d
  801ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee4:	ff d0                	call   *%eax
  801ee6:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801ee9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801eec:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801eef:	f7 d8                	neg    %eax
  801ef1:	83 d2 00             	adc    $0x0,%edx
  801ef4:	f7 da                	neg    %edx
  801ef6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801ef9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801efc:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801f03:	e9 bc 00 00 00       	jmp    801fc4 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801f08:	83 ec 08             	sub    $0x8,%esp
  801f0b:	ff 75 e8             	pushl  -0x18(%ebp)
  801f0e:	8d 45 14             	lea    0x14(%ebp),%eax
  801f11:	50                   	push   %eax
  801f12:	e8 84 fc ff ff       	call   801b9b <getuint>
  801f17:	83 c4 10             	add    $0x10,%esp
  801f1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801f1d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801f20:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801f27:	e9 98 00 00 00       	jmp    801fc4 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801f2c:	83 ec 08             	sub    $0x8,%esp
  801f2f:	ff 75 0c             	pushl  0xc(%ebp)
  801f32:	6a 58                	push   $0x58
  801f34:	8b 45 08             	mov    0x8(%ebp),%eax
  801f37:	ff d0                	call   *%eax
  801f39:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801f3c:	83 ec 08             	sub    $0x8,%esp
  801f3f:	ff 75 0c             	pushl  0xc(%ebp)
  801f42:	6a 58                	push   $0x58
  801f44:	8b 45 08             	mov    0x8(%ebp),%eax
  801f47:	ff d0                	call   *%eax
  801f49:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801f4c:	83 ec 08             	sub    $0x8,%esp
  801f4f:	ff 75 0c             	pushl  0xc(%ebp)
  801f52:	6a 58                	push   $0x58
  801f54:	8b 45 08             	mov    0x8(%ebp),%eax
  801f57:	ff d0                	call   *%eax
  801f59:	83 c4 10             	add    $0x10,%esp
			break;
  801f5c:	e9 bc 00 00 00       	jmp    80201d <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801f61:	83 ec 08             	sub    $0x8,%esp
  801f64:	ff 75 0c             	pushl  0xc(%ebp)
  801f67:	6a 30                	push   $0x30
  801f69:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6c:	ff d0                	call   *%eax
  801f6e:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801f71:	83 ec 08             	sub    $0x8,%esp
  801f74:	ff 75 0c             	pushl  0xc(%ebp)
  801f77:	6a 78                	push   $0x78
  801f79:	8b 45 08             	mov    0x8(%ebp),%eax
  801f7c:	ff d0                	call   *%eax
  801f7e:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801f81:	8b 45 14             	mov    0x14(%ebp),%eax
  801f84:	83 c0 04             	add    $0x4,%eax
  801f87:	89 45 14             	mov    %eax,0x14(%ebp)
  801f8a:	8b 45 14             	mov    0x14(%ebp),%eax
  801f8d:	83 e8 04             	sub    $0x4,%eax
  801f90:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801f92:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801f95:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801f9c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801fa3:	eb 1f                	jmp    801fc4 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801fa5:	83 ec 08             	sub    $0x8,%esp
  801fa8:	ff 75 e8             	pushl  -0x18(%ebp)
  801fab:	8d 45 14             	lea    0x14(%ebp),%eax
  801fae:	50                   	push   %eax
  801faf:	e8 e7 fb ff ff       	call   801b9b <getuint>
  801fb4:	83 c4 10             	add    $0x10,%esp
  801fb7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801fba:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801fbd:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801fc4:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801fc8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801fcb:	83 ec 04             	sub    $0x4,%esp
  801fce:	52                   	push   %edx
  801fcf:	ff 75 e4             	pushl  -0x1c(%ebp)
  801fd2:	50                   	push   %eax
  801fd3:	ff 75 f4             	pushl  -0xc(%ebp)
  801fd6:	ff 75 f0             	pushl  -0x10(%ebp)
  801fd9:	ff 75 0c             	pushl  0xc(%ebp)
  801fdc:	ff 75 08             	pushl  0x8(%ebp)
  801fdf:	e8 00 fb ff ff       	call   801ae4 <printnum>
  801fe4:	83 c4 20             	add    $0x20,%esp
			break;
  801fe7:	eb 34                	jmp    80201d <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801fe9:	83 ec 08             	sub    $0x8,%esp
  801fec:	ff 75 0c             	pushl  0xc(%ebp)
  801fef:	53                   	push   %ebx
  801ff0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff3:	ff d0                	call   *%eax
  801ff5:	83 c4 10             	add    $0x10,%esp
			break;
  801ff8:	eb 23                	jmp    80201d <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801ffa:	83 ec 08             	sub    $0x8,%esp
  801ffd:	ff 75 0c             	pushl  0xc(%ebp)
  802000:	6a 25                	push   $0x25
  802002:	8b 45 08             	mov    0x8(%ebp),%eax
  802005:	ff d0                	call   *%eax
  802007:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80200a:	ff 4d 10             	decl   0x10(%ebp)
  80200d:	eb 03                	jmp    802012 <vprintfmt+0x3b1>
  80200f:	ff 4d 10             	decl   0x10(%ebp)
  802012:	8b 45 10             	mov    0x10(%ebp),%eax
  802015:	48                   	dec    %eax
  802016:	8a 00                	mov    (%eax),%al
  802018:	3c 25                	cmp    $0x25,%al
  80201a:	75 f3                	jne    80200f <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80201c:	90                   	nop
		}
	}
  80201d:	e9 47 fc ff ff       	jmp    801c69 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  802022:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  802023:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802026:	5b                   	pop    %ebx
  802027:	5e                   	pop    %esi
  802028:	5d                   	pop    %ebp
  802029:	c3                   	ret    

0080202a <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80202a:	55                   	push   %ebp
  80202b:	89 e5                	mov    %esp,%ebp
  80202d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  802030:	8d 45 10             	lea    0x10(%ebp),%eax
  802033:	83 c0 04             	add    $0x4,%eax
  802036:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  802039:	8b 45 10             	mov    0x10(%ebp),%eax
  80203c:	ff 75 f4             	pushl  -0xc(%ebp)
  80203f:	50                   	push   %eax
  802040:	ff 75 0c             	pushl  0xc(%ebp)
  802043:	ff 75 08             	pushl  0x8(%ebp)
  802046:	e8 16 fc ff ff       	call   801c61 <vprintfmt>
  80204b:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80204e:	90                   	nop
  80204f:	c9                   	leave  
  802050:	c3                   	ret    

00802051 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  802051:	55                   	push   %ebp
  802052:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  802054:	8b 45 0c             	mov    0xc(%ebp),%eax
  802057:	8b 40 08             	mov    0x8(%eax),%eax
  80205a:	8d 50 01             	lea    0x1(%eax),%edx
  80205d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802060:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  802063:	8b 45 0c             	mov    0xc(%ebp),%eax
  802066:	8b 10                	mov    (%eax),%edx
  802068:	8b 45 0c             	mov    0xc(%ebp),%eax
  80206b:	8b 40 04             	mov    0x4(%eax),%eax
  80206e:	39 c2                	cmp    %eax,%edx
  802070:	73 12                	jae    802084 <sprintputch+0x33>
		*b->buf++ = ch;
  802072:	8b 45 0c             	mov    0xc(%ebp),%eax
  802075:	8b 00                	mov    (%eax),%eax
  802077:	8d 48 01             	lea    0x1(%eax),%ecx
  80207a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80207d:	89 0a                	mov    %ecx,(%edx)
  80207f:	8b 55 08             	mov    0x8(%ebp),%edx
  802082:	88 10                	mov    %dl,(%eax)
}
  802084:	90                   	nop
  802085:	5d                   	pop    %ebp
  802086:	c3                   	ret    

00802087 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  802087:	55                   	push   %ebp
  802088:	89 e5                	mov    %esp,%ebp
  80208a:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80208d:	8b 45 08             	mov    0x8(%ebp),%eax
  802090:	89 45 ec             	mov    %eax,-0x14(%ebp)
  802093:	8b 45 0c             	mov    0xc(%ebp),%eax
  802096:	8d 50 ff             	lea    -0x1(%eax),%edx
  802099:	8b 45 08             	mov    0x8(%ebp),%eax
  80209c:	01 d0                	add    %edx,%eax
  80209e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8020a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8020a8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8020ac:	74 06                	je     8020b4 <vsnprintf+0x2d>
  8020ae:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8020b2:	7f 07                	jg     8020bb <vsnprintf+0x34>
		return -E_INVAL;
  8020b4:	b8 03 00 00 00       	mov    $0x3,%eax
  8020b9:	eb 20                	jmp    8020db <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8020bb:	ff 75 14             	pushl  0x14(%ebp)
  8020be:	ff 75 10             	pushl  0x10(%ebp)
  8020c1:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8020c4:	50                   	push   %eax
  8020c5:	68 51 20 80 00       	push   $0x802051
  8020ca:	e8 92 fb ff ff       	call   801c61 <vprintfmt>
  8020cf:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8020d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8020d5:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8020d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8020db:	c9                   	leave  
  8020dc:	c3                   	ret    

008020dd <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8020dd:	55                   	push   %ebp
  8020de:	89 e5                	mov    %esp,%ebp
  8020e0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8020e3:	8d 45 10             	lea    0x10(%ebp),%eax
  8020e6:	83 c0 04             	add    $0x4,%eax
  8020e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8020ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8020ef:	ff 75 f4             	pushl  -0xc(%ebp)
  8020f2:	50                   	push   %eax
  8020f3:	ff 75 0c             	pushl  0xc(%ebp)
  8020f6:	ff 75 08             	pushl  0x8(%ebp)
  8020f9:	e8 89 ff ff ff       	call   802087 <vsnprintf>
  8020fe:	83 c4 10             	add    $0x10,%esp
  802101:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  802104:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802107:	c9                   	leave  
  802108:	c3                   	ret    

00802109 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  802109:	55                   	push   %ebp
  80210a:	89 e5                	mov    %esp,%ebp
  80210c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80210f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802116:	eb 06                	jmp    80211e <strlen+0x15>
		n++;
  802118:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80211b:	ff 45 08             	incl   0x8(%ebp)
  80211e:	8b 45 08             	mov    0x8(%ebp),%eax
  802121:	8a 00                	mov    (%eax),%al
  802123:	84 c0                	test   %al,%al
  802125:	75 f1                	jne    802118 <strlen+0xf>
		n++;
	return n;
  802127:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80212a:	c9                   	leave  
  80212b:	c3                   	ret    

0080212c <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80212c:	55                   	push   %ebp
  80212d:	89 e5                	mov    %esp,%ebp
  80212f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  802132:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802139:	eb 09                	jmp    802144 <strnlen+0x18>
		n++;
  80213b:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80213e:	ff 45 08             	incl   0x8(%ebp)
  802141:	ff 4d 0c             	decl   0xc(%ebp)
  802144:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802148:	74 09                	je     802153 <strnlen+0x27>
  80214a:	8b 45 08             	mov    0x8(%ebp),%eax
  80214d:	8a 00                	mov    (%eax),%al
  80214f:	84 c0                	test   %al,%al
  802151:	75 e8                	jne    80213b <strnlen+0xf>
		n++;
	return n;
  802153:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802156:	c9                   	leave  
  802157:	c3                   	ret    

00802158 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  802158:	55                   	push   %ebp
  802159:	89 e5                	mov    %esp,%ebp
  80215b:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80215e:	8b 45 08             	mov    0x8(%ebp),%eax
  802161:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  802164:	90                   	nop
  802165:	8b 45 08             	mov    0x8(%ebp),%eax
  802168:	8d 50 01             	lea    0x1(%eax),%edx
  80216b:	89 55 08             	mov    %edx,0x8(%ebp)
  80216e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802171:	8d 4a 01             	lea    0x1(%edx),%ecx
  802174:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  802177:	8a 12                	mov    (%edx),%dl
  802179:	88 10                	mov    %dl,(%eax)
  80217b:	8a 00                	mov    (%eax),%al
  80217d:	84 c0                	test   %al,%al
  80217f:	75 e4                	jne    802165 <strcpy+0xd>
		/* do nothing */;
	return ret;
  802181:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802184:	c9                   	leave  
  802185:	c3                   	ret    

00802186 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  802186:	55                   	push   %ebp
  802187:	89 e5                	mov    %esp,%ebp
  802189:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80218c:	8b 45 08             	mov    0x8(%ebp),%eax
  80218f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  802192:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802199:	eb 1f                	jmp    8021ba <strncpy+0x34>
		*dst++ = *src;
  80219b:	8b 45 08             	mov    0x8(%ebp),%eax
  80219e:	8d 50 01             	lea    0x1(%eax),%edx
  8021a1:	89 55 08             	mov    %edx,0x8(%ebp)
  8021a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021a7:	8a 12                	mov    (%edx),%dl
  8021a9:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8021ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021ae:	8a 00                	mov    (%eax),%al
  8021b0:	84 c0                	test   %al,%al
  8021b2:	74 03                	je     8021b7 <strncpy+0x31>
			src++;
  8021b4:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8021b7:	ff 45 fc             	incl   -0x4(%ebp)
  8021ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8021bd:	3b 45 10             	cmp    0x10(%ebp),%eax
  8021c0:	72 d9                	jb     80219b <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8021c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8021c5:	c9                   	leave  
  8021c6:	c3                   	ret    

008021c7 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8021c7:	55                   	push   %ebp
  8021c8:	89 e5                	mov    %esp,%ebp
  8021ca:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8021cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8021d0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8021d3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8021d7:	74 30                	je     802209 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8021d9:	eb 16                	jmp    8021f1 <strlcpy+0x2a>
			*dst++ = *src++;
  8021db:	8b 45 08             	mov    0x8(%ebp),%eax
  8021de:	8d 50 01             	lea    0x1(%eax),%edx
  8021e1:	89 55 08             	mov    %edx,0x8(%ebp)
  8021e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021e7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8021ea:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8021ed:	8a 12                	mov    (%edx),%dl
  8021ef:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8021f1:	ff 4d 10             	decl   0x10(%ebp)
  8021f4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8021f8:	74 09                	je     802203 <strlcpy+0x3c>
  8021fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021fd:	8a 00                	mov    (%eax),%al
  8021ff:	84 c0                	test   %al,%al
  802201:	75 d8                	jne    8021db <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  802203:	8b 45 08             	mov    0x8(%ebp),%eax
  802206:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  802209:	8b 55 08             	mov    0x8(%ebp),%edx
  80220c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80220f:	29 c2                	sub    %eax,%edx
  802211:	89 d0                	mov    %edx,%eax
}
  802213:	c9                   	leave  
  802214:	c3                   	ret    

00802215 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  802215:	55                   	push   %ebp
  802216:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  802218:	eb 06                	jmp    802220 <strcmp+0xb>
		p++, q++;
  80221a:	ff 45 08             	incl   0x8(%ebp)
  80221d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  802220:	8b 45 08             	mov    0x8(%ebp),%eax
  802223:	8a 00                	mov    (%eax),%al
  802225:	84 c0                	test   %al,%al
  802227:	74 0e                	je     802237 <strcmp+0x22>
  802229:	8b 45 08             	mov    0x8(%ebp),%eax
  80222c:	8a 10                	mov    (%eax),%dl
  80222e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802231:	8a 00                	mov    (%eax),%al
  802233:	38 c2                	cmp    %al,%dl
  802235:	74 e3                	je     80221a <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  802237:	8b 45 08             	mov    0x8(%ebp),%eax
  80223a:	8a 00                	mov    (%eax),%al
  80223c:	0f b6 d0             	movzbl %al,%edx
  80223f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802242:	8a 00                	mov    (%eax),%al
  802244:	0f b6 c0             	movzbl %al,%eax
  802247:	29 c2                	sub    %eax,%edx
  802249:	89 d0                	mov    %edx,%eax
}
  80224b:	5d                   	pop    %ebp
  80224c:	c3                   	ret    

0080224d <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80224d:	55                   	push   %ebp
  80224e:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  802250:	eb 09                	jmp    80225b <strncmp+0xe>
		n--, p++, q++;
  802252:	ff 4d 10             	decl   0x10(%ebp)
  802255:	ff 45 08             	incl   0x8(%ebp)
  802258:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80225b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80225f:	74 17                	je     802278 <strncmp+0x2b>
  802261:	8b 45 08             	mov    0x8(%ebp),%eax
  802264:	8a 00                	mov    (%eax),%al
  802266:	84 c0                	test   %al,%al
  802268:	74 0e                	je     802278 <strncmp+0x2b>
  80226a:	8b 45 08             	mov    0x8(%ebp),%eax
  80226d:	8a 10                	mov    (%eax),%dl
  80226f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802272:	8a 00                	mov    (%eax),%al
  802274:	38 c2                	cmp    %al,%dl
  802276:	74 da                	je     802252 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  802278:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80227c:	75 07                	jne    802285 <strncmp+0x38>
		return 0;
  80227e:	b8 00 00 00 00       	mov    $0x0,%eax
  802283:	eb 14                	jmp    802299 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  802285:	8b 45 08             	mov    0x8(%ebp),%eax
  802288:	8a 00                	mov    (%eax),%al
  80228a:	0f b6 d0             	movzbl %al,%edx
  80228d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802290:	8a 00                	mov    (%eax),%al
  802292:	0f b6 c0             	movzbl %al,%eax
  802295:	29 c2                	sub    %eax,%edx
  802297:	89 d0                	mov    %edx,%eax
}
  802299:	5d                   	pop    %ebp
  80229a:	c3                   	ret    

0080229b <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80229b:	55                   	push   %ebp
  80229c:	89 e5                	mov    %esp,%ebp
  80229e:	83 ec 04             	sub    $0x4,%esp
  8022a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8022a4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8022a7:	eb 12                	jmp    8022bb <strchr+0x20>
		if (*s == c)
  8022a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ac:	8a 00                	mov    (%eax),%al
  8022ae:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8022b1:	75 05                	jne    8022b8 <strchr+0x1d>
			return (char *) s;
  8022b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8022b6:	eb 11                	jmp    8022c9 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8022b8:	ff 45 08             	incl   0x8(%ebp)
  8022bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8022be:	8a 00                	mov    (%eax),%al
  8022c0:	84 c0                	test   %al,%al
  8022c2:	75 e5                	jne    8022a9 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8022c4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022c9:	c9                   	leave  
  8022ca:	c3                   	ret    

008022cb <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8022cb:	55                   	push   %ebp
  8022cc:	89 e5                	mov    %esp,%ebp
  8022ce:	83 ec 04             	sub    $0x4,%esp
  8022d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8022d4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8022d7:	eb 0d                	jmp    8022e6 <strfind+0x1b>
		if (*s == c)
  8022d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8022dc:	8a 00                	mov    (%eax),%al
  8022de:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8022e1:	74 0e                	je     8022f1 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8022e3:	ff 45 08             	incl   0x8(%ebp)
  8022e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8022e9:	8a 00                	mov    (%eax),%al
  8022eb:	84 c0                	test   %al,%al
  8022ed:	75 ea                	jne    8022d9 <strfind+0xe>
  8022ef:	eb 01                	jmp    8022f2 <strfind+0x27>
		if (*s == c)
			break;
  8022f1:	90                   	nop
	return (char *) s;
  8022f2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8022f5:	c9                   	leave  
  8022f6:	c3                   	ret    

008022f7 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8022f7:	55                   	push   %ebp
  8022f8:	89 e5                	mov    %esp,%ebp
  8022fa:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8022fd:	8b 45 08             	mov    0x8(%ebp),%eax
  802300:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  802303:	8b 45 10             	mov    0x10(%ebp),%eax
  802306:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  802309:	eb 0e                	jmp    802319 <memset+0x22>
		*p++ = c;
  80230b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80230e:	8d 50 01             	lea    0x1(%eax),%edx
  802311:	89 55 fc             	mov    %edx,-0x4(%ebp)
  802314:	8b 55 0c             	mov    0xc(%ebp),%edx
  802317:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  802319:	ff 4d f8             	decl   -0x8(%ebp)
  80231c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  802320:	79 e9                	jns    80230b <memset+0x14>
		*p++ = c;

	return v;
  802322:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802325:	c9                   	leave  
  802326:	c3                   	ret    

00802327 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  802327:	55                   	push   %ebp
  802328:	89 e5                	mov    %esp,%ebp
  80232a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80232d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802330:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  802333:	8b 45 08             	mov    0x8(%ebp),%eax
  802336:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  802339:	eb 16                	jmp    802351 <memcpy+0x2a>
		*d++ = *s++;
  80233b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80233e:	8d 50 01             	lea    0x1(%eax),%edx
  802341:	89 55 f8             	mov    %edx,-0x8(%ebp)
  802344:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802347:	8d 4a 01             	lea    0x1(%edx),%ecx
  80234a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80234d:	8a 12                	mov    (%edx),%dl
  80234f:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  802351:	8b 45 10             	mov    0x10(%ebp),%eax
  802354:	8d 50 ff             	lea    -0x1(%eax),%edx
  802357:	89 55 10             	mov    %edx,0x10(%ebp)
  80235a:	85 c0                	test   %eax,%eax
  80235c:	75 dd                	jne    80233b <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80235e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802361:	c9                   	leave  
  802362:	c3                   	ret    

00802363 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  802363:	55                   	push   %ebp
  802364:	89 e5                	mov    %esp,%ebp
  802366:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  802369:	8b 45 0c             	mov    0xc(%ebp),%eax
  80236c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80236f:	8b 45 08             	mov    0x8(%ebp),%eax
  802372:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  802375:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802378:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80237b:	73 50                	jae    8023cd <memmove+0x6a>
  80237d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802380:	8b 45 10             	mov    0x10(%ebp),%eax
  802383:	01 d0                	add    %edx,%eax
  802385:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  802388:	76 43                	jbe    8023cd <memmove+0x6a>
		s += n;
  80238a:	8b 45 10             	mov    0x10(%ebp),%eax
  80238d:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  802390:	8b 45 10             	mov    0x10(%ebp),%eax
  802393:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  802396:	eb 10                	jmp    8023a8 <memmove+0x45>
			*--d = *--s;
  802398:	ff 4d f8             	decl   -0x8(%ebp)
  80239b:	ff 4d fc             	decl   -0x4(%ebp)
  80239e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8023a1:	8a 10                	mov    (%eax),%dl
  8023a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8023a6:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8023a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8023ab:	8d 50 ff             	lea    -0x1(%eax),%edx
  8023ae:	89 55 10             	mov    %edx,0x10(%ebp)
  8023b1:	85 c0                	test   %eax,%eax
  8023b3:	75 e3                	jne    802398 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8023b5:	eb 23                	jmp    8023da <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8023b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8023ba:	8d 50 01             	lea    0x1(%eax),%edx
  8023bd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8023c0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8023c3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8023c6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8023c9:	8a 12                	mov    (%edx),%dl
  8023cb:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8023cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8023d0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8023d3:	89 55 10             	mov    %edx,0x10(%ebp)
  8023d6:	85 c0                	test   %eax,%eax
  8023d8:	75 dd                	jne    8023b7 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8023da:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8023dd:	c9                   	leave  
  8023de:	c3                   	ret    

008023df <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8023df:	55                   	push   %ebp
  8023e0:	89 e5                	mov    %esp,%ebp
  8023e2:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8023e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8023e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8023eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023ee:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8023f1:	eb 2a                	jmp    80241d <memcmp+0x3e>
		if (*s1 != *s2)
  8023f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8023f6:	8a 10                	mov    (%eax),%dl
  8023f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8023fb:	8a 00                	mov    (%eax),%al
  8023fd:	38 c2                	cmp    %al,%dl
  8023ff:	74 16                	je     802417 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  802401:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802404:	8a 00                	mov    (%eax),%al
  802406:	0f b6 d0             	movzbl %al,%edx
  802409:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80240c:	8a 00                	mov    (%eax),%al
  80240e:	0f b6 c0             	movzbl %al,%eax
  802411:	29 c2                	sub    %eax,%edx
  802413:	89 d0                	mov    %edx,%eax
  802415:	eb 18                	jmp    80242f <memcmp+0x50>
		s1++, s2++;
  802417:	ff 45 fc             	incl   -0x4(%ebp)
  80241a:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80241d:	8b 45 10             	mov    0x10(%ebp),%eax
  802420:	8d 50 ff             	lea    -0x1(%eax),%edx
  802423:	89 55 10             	mov    %edx,0x10(%ebp)
  802426:	85 c0                	test   %eax,%eax
  802428:	75 c9                	jne    8023f3 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80242a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80242f:	c9                   	leave  
  802430:	c3                   	ret    

00802431 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  802431:	55                   	push   %ebp
  802432:	89 e5                	mov    %esp,%ebp
  802434:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  802437:	8b 55 08             	mov    0x8(%ebp),%edx
  80243a:	8b 45 10             	mov    0x10(%ebp),%eax
  80243d:	01 d0                	add    %edx,%eax
  80243f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  802442:	eb 15                	jmp    802459 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  802444:	8b 45 08             	mov    0x8(%ebp),%eax
  802447:	8a 00                	mov    (%eax),%al
  802449:	0f b6 d0             	movzbl %al,%edx
  80244c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80244f:	0f b6 c0             	movzbl %al,%eax
  802452:	39 c2                	cmp    %eax,%edx
  802454:	74 0d                	je     802463 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  802456:	ff 45 08             	incl   0x8(%ebp)
  802459:	8b 45 08             	mov    0x8(%ebp),%eax
  80245c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80245f:	72 e3                	jb     802444 <memfind+0x13>
  802461:	eb 01                	jmp    802464 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  802463:	90                   	nop
	return (void *) s;
  802464:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802467:	c9                   	leave  
  802468:	c3                   	ret    

00802469 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  802469:	55                   	push   %ebp
  80246a:	89 e5                	mov    %esp,%ebp
  80246c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80246f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  802476:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80247d:	eb 03                	jmp    802482 <strtol+0x19>
		s++;
  80247f:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  802482:	8b 45 08             	mov    0x8(%ebp),%eax
  802485:	8a 00                	mov    (%eax),%al
  802487:	3c 20                	cmp    $0x20,%al
  802489:	74 f4                	je     80247f <strtol+0x16>
  80248b:	8b 45 08             	mov    0x8(%ebp),%eax
  80248e:	8a 00                	mov    (%eax),%al
  802490:	3c 09                	cmp    $0x9,%al
  802492:	74 eb                	je     80247f <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  802494:	8b 45 08             	mov    0x8(%ebp),%eax
  802497:	8a 00                	mov    (%eax),%al
  802499:	3c 2b                	cmp    $0x2b,%al
  80249b:	75 05                	jne    8024a2 <strtol+0x39>
		s++;
  80249d:	ff 45 08             	incl   0x8(%ebp)
  8024a0:	eb 13                	jmp    8024b5 <strtol+0x4c>
	else if (*s == '-')
  8024a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8024a5:	8a 00                	mov    (%eax),%al
  8024a7:	3c 2d                	cmp    $0x2d,%al
  8024a9:	75 0a                	jne    8024b5 <strtol+0x4c>
		s++, neg = 1;
  8024ab:	ff 45 08             	incl   0x8(%ebp)
  8024ae:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8024b5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8024b9:	74 06                	je     8024c1 <strtol+0x58>
  8024bb:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8024bf:	75 20                	jne    8024e1 <strtol+0x78>
  8024c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8024c4:	8a 00                	mov    (%eax),%al
  8024c6:	3c 30                	cmp    $0x30,%al
  8024c8:	75 17                	jne    8024e1 <strtol+0x78>
  8024ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8024cd:	40                   	inc    %eax
  8024ce:	8a 00                	mov    (%eax),%al
  8024d0:	3c 78                	cmp    $0x78,%al
  8024d2:	75 0d                	jne    8024e1 <strtol+0x78>
		s += 2, base = 16;
  8024d4:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8024d8:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8024df:	eb 28                	jmp    802509 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8024e1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8024e5:	75 15                	jne    8024fc <strtol+0x93>
  8024e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8024ea:	8a 00                	mov    (%eax),%al
  8024ec:	3c 30                	cmp    $0x30,%al
  8024ee:	75 0c                	jne    8024fc <strtol+0x93>
		s++, base = 8;
  8024f0:	ff 45 08             	incl   0x8(%ebp)
  8024f3:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8024fa:	eb 0d                	jmp    802509 <strtol+0xa0>
	else if (base == 0)
  8024fc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802500:	75 07                	jne    802509 <strtol+0xa0>
		base = 10;
  802502:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  802509:	8b 45 08             	mov    0x8(%ebp),%eax
  80250c:	8a 00                	mov    (%eax),%al
  80250e:	3c 2f                	cmp    $0x2f,%al
  802510:	7e 19                	jle    80252b <strtol+0xc2>
  802512:	8b 45 08             	mov    0x8(%ebp),%eax
  802515:	8a 00                	mov    (%eax),%al
  802517:	3c 39                	cmp    $0x39,%al
  802519:	7f 10                	jg     80252b <strtol+0xc2>
			dig = *s - '0';
  80251b:	8b 45 08             	mov    0x8(%ebp),%eax
  80251e:	8a 00                	mov    (%eax),%al
  802520:	0f be c0             	movsbl %al,%eax
  802523:	83 e8 30             	sub    $0x30,%eax
  802526:	89 45 f4             	mov    %eax,-0xc(%ebp)
  802529:	eb 42                	jmp    80256d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80252b:	8b 45 08             	mov    0x8(%ebp),%eax
  80252e:	8a 00                	mov    (%eax),%al
  802530:	3c 60                	cmp    $0x60,%al
  802532:	7e 19                	jle    80254d <strtol+0xe4>
  802534:	8b 45 08             	mov    0x8(%ebp),%eax
  802537:	8a 00                	mov    (%eax),%al
  802539:	3c 7a                	cmp    $0x7a,%al
  80253b:	7f 10                	jg     80254d <strtol+0xe4>
			dig = *s - 'a' + 10;
  80253d:	8b 45 08             	mov    0x8(%ebp),%eax
  802540:	8a 00                	mov    (%eax),%al
  802542:	0f be c0             	movsbl %al,%eax
  802545:	83 e8 57             	sub    $0x57,%eax
  802548:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80254b:	eb 20                	jmp    80256d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80254d:	8b 45 08             	mov    0x8(%ebp),%eax
  802550:	8a 00                	mov    (%eax),%al
  802552:	3c 40                	cmp    $0x40,%al
  802554:	7e 39                	jle    80258f <strtol+0x126>
  802556:	8b 45 08             	mov    0x8(%ebp),%eax
  802559:	8a 00                	mov    (%eax),%al
  80255b:	3c 5a                	cmp    $0x5a,%al
  80255d:	7f 30                	jg     80258f <strtol+0x126>
			dig = *s - 'A' + 10;
  80255f:	8b 45 08             	mov    0x8(%ebp),%eax
  802562:	8a 00                	mov    (%eax),%al
  802564:	0f be c0             	movsbl %al,%eax
  802567:	83 e8 37             	sub    $0x37,%eax
  80256a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80256d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802570:	3b 45 10             	cmp    0x10(%ebp),%eax
  802573:	7d 19                	jge    80258e <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  802575:	ff 45 08             	incl   0x8(%ebp)
  802578:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80257b:	0f af 45 10          	imul   0x10(%ebp),%eax
  80257f:	89 c2                	mov    %eax,%edx
  802581:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802584:	01 d0                	add    %edx,%eax
  802586:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  802589:	e9 7b ff ff ff       	jmp    802509 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80258e:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80258f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802593:	74 08                	je     80259d <strtol+0x134>
		*endptr = (char *) s;
  802595:	8b 45 0c             	mov    0xc(%ebp),%eax
  802598:	8b 55 08             	mov    0x8(%ebp),%edx
  80259b:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80259d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8025a1:	74 07                	je     8025aa <strtol+0x141>
  8025a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8025a6:	f7 d8                	neg    %eax
  8025a8:	eb 03                	jmp    8025ad <strtol+0x144>
  8025aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8025ad:	c9                   	leave  
  8025ae:	c3                   	ret    

008025af <ltostr>:

void
ltostr(long value, char *str)
{
  8025af:	55                   	push   %ebp
  8025b0:	89 e5                	mov    %esp,%ebp
  8025b2:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8025b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8025bc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8025c3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8025c7:	79 13                	jns    8025dc <ltostr+0x2d>
	{
		neg = 1;
  8025c9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8025d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8025d3:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8025d6:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8025d9:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8025dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8025df:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8025e4:	99                   	cltd   
  8025e5:	f7 f9                	idiv   %ecx
  8025e7:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8025ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8025ed:	8d 50 01             	lea    0x1(%eax),%edx
  8025f0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8025f3:	89 c2                	mov    %eax,%edx
  8025f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8025f8:	01 d0                	add    %edx,%eax
  8025fa:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8025fd:	83 c2 30             	add    $0x30,%edx
  802600:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  802602:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802605:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80260a:	f7 e9                	imul   %ecx
  80260c:	c1 fa 02             	sar    $0x2,%edx
  80260f:	89 c8                	mov    %ecx,%eax
  802611:	c1 f8 1f             	sar    $0x1f,%eax
  802614:	29 c2                	sub    %eax,%edx
  802616:	89 d0                	mov    %edx,%eax
  802618:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80261b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80261e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  802623:	f7 e9                	imul   %ecx
  802625:	c1 fa 02             	sar    $0x2,%edx
  802628:	89 c8                	mov    %ecx,%eax
  80262a:	c1 f8 1f             	sar    $0x1f,%eax
  80262d:	29 c2                	sub    %eax,%edx
  80262f:	89 d0                	mov    %edx,%eax
  802631:	c1 e0 02             	shl    $0x2,%eax
  802634:	01 d0                	add    %edx,%eax
  802636:	01 c0                	add    %eax,%eax
  802638:	29 c1                	sub    %eax,%ecx
  80263a:	89 ca                	mov    %ecx,%edx
  80263c:	85 d2                	test   %edx,%edx
  80263e:	75 9c                	jne    8025dc <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  802640:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  802647:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80264a:	48                   	dec    %eax
  80264b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80264e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  802652:	74 3d                	je     802691 <ltostr+0xe2>
		start = 1 ;
  802654:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80265b:	eb 34                	jmp    802691 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80265d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802660:	8b 45 0c             	mov    0xc(%ebp),%eax
  802663:	01 d0                	add    %edx,%eax
  802665:	8a 00                	mov    (%eax),%al
  802667:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80266a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80266d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802670:	01 c2                	add    %eax,%edx
  802672:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  802675:	8b 45 0c             	mov    0xc(%ebp),%eax
  802678:	01 c8                	add    %ecx,%eax
  80267a:	8a 00                	mov    (%eax),%al
  80267c:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80267e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  802681:	8b 45 0c             	mov    0xc(%ebp),%eax
  802684:	01 c2                	add    %eax,%edx
  802686:	8a 45 eb             	mov    -0x15(%ebp),%al
  802689:	88 02                	mov    %al,(%edx)
		start++ ;
  80268b:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80268e:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  802691:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802694:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802697:	7c c4                	jl     80265d <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  802699:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80269c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80269f:	01 d0                	add    %edx,%eax
  8026a1:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8026a4:	90                   	nop
  8026a5:	c9                   	leave  
  8026a6:	c3                   	ret    

008026a7 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8026a7:	55                   	push   %ebp
  8026a8:	89 e5                	mov    %esp,%ebp
  8026aa:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8026ad:	ff 75 08             	pushl  0x8(%ebp)
  8026b0:	e8 54 fa ff ff       	call   802109 <strlen>
  8026b5:	83 c4 04             	add    $0x4,%esp
  8026b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8026bb:	ff 75 0c             	pushl  0xc(%ebp)
  8026be:	e8 46 fa ff ff       	call   802109 <strlen>
  8026c3:	83 c4 04             	add    $0x4,%esp
  8026c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8026c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8026d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8026d7:	eb 17                	jmp    8026f0 <strcconcat+0x49>
		final[s] = str1[s] ;
  8026d9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8026dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8026df:	01 c2                	add    %eax,%edx
  8026e1:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8026e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8026e7:	01 c8                	add    %ecx,%eax
  8026e9:	8a 00                	mov    (%eax),%al
  8026eb:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8026ed:	ff 45 fc             	incl   -0x4(%ebp)
  8026f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8026f3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8026f6:	7c e1                	jl     8026d9 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8026f8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8026ff:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  802706:	eb 1f                	jmp    802727 <strcconcat+0x80>
		final[s++] = str2[i] ;
  802708:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80270b:	8d 50 01             	lea    0x1(%eax),%edx
  80270e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  802711:	89 c2                	mov    %eax,%edx
  802713:	8b 45 10             	mov    0x10(%ebp),%eax
  802716:	01 c2                	add    %eax,%edx
  802718:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80271b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80271e:	01 c8                	add    %ecx,%eax
  802720:	8a 00                	mov    (%eax),%al
  802722:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  802724:	ff 45 f8             	incl   -0x8(%ebp)
  802727:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80272a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80272d:	7c d9                	jl     802708 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80272f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802732:	8b 45 10             	mov    0x10(%ebp),%eax
  802735:	01 d0                	add    %edx,%eax
  802737:	c6 00 00             	movb   $0x0,(%eax)
}
  80273a:	90                   	nop
  80273b:	c9                   	leave  
  80273c:	c3                   	ret    

0080273d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80273d:	55                   	push   %ebp
  80273e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  802740:	8b 45 14             	mov    0x14(%ebp),%eax
  802743:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  802749:	8b 45 14             	mov    0x14(%ebp),%eax
  80274c:	8b 00                	mov    (%eax),%eax
  80274e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802755:	8b 45 10             	mov    0x10(%ebp),%eax
  802758:	01 d0                	add    %edx,%eax
  80275a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  802760:	eb 0c                	jmp    80276e <strsplit+0x31>
			*string++ = 0;
  802762:	8b 45 08             	mov    0x8(%ebp),%eax
  802765:	8d 50 01             	lea    0x1(%eax),%edx
  802768:	89 55 08             	mov    %edx,0x8(%ebp)
  80276b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80276e:	8b 45 08             	mov    0x8(%ebp),%eax
  802771:	8a 00                	mov    (%eax),%al
  802773:	84 c0                	test   %al,%al
  802775:	74 18                	je     80278f <strsplit+0x52>
  802777:	8b 45 08             	mov    0x8(%ebp),%eax
  80277a:	8a 00                	mov    (%eax),%al
  80277c:	0f be c0             	movsbl %al,%eax
  80277f:	50                   	push   %eax
  802780:	ff 75 0c             	pushl  0xc(%ebp)
  802783:	e8 13 fb ff ff       	call   80229b <strchr>
  802788:	83 c4 08             	add    $0x8,%esp
  80278b:	85 c0                	test   %eax,%eax
  80278d:	75 d3                	jne    802762 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80278f:	8b 45 08             	mov    0x8(%ebp),%eax
  802792:	8a 00                	mov    (%eax),%al
  802794:	84 c0                	test   %al,%al
  802796:	74 5a                	je     8027f2 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  802798:	8b 45 14             	mov    0x14(%ebp),%eax
  80279b:	8b 00                	mov    (%eax),%eax
  80279d:	83 f8 0f             	cmp    $0xf,%eax
  8027a0:	75 07                	jne    8027a9 <strsplit+0x6c>
		{
			return 0;
  8027a2:	b8 00 00 00 00       	mov    $0x0,%eax
  8027a7:	eb 66                	jmp    80280f <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8027a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8027ac:	8b 00                	mov    (%eax),%eax
  8027ae:	8d 48 01             	lea    0x1(%eax),%ecx
  8027b1:	8b 55 14             	mov    0x14(%ebp),%edx
  8027b4:	89 0a                	mov    %ecx,(%edx)
  8027b6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8027bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8027c0:	01 c2                	add    %eax,%edx
  8027c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8027c5:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8027c7:	eb 03                	jmp    8027cc <strsplit+0x8f>
			string++;
  8027c9:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8027cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8027cf:	8a 00                	mov    (%eax),%al
  8027d1:	84 c0                	test   %al,%al
  8027d3:	74 8b                	je     802760 <strsplit+0x23>
  8027d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8027d8:	8a 00                	mov    (%eax),%al
  8027da:	0f be c0             	movsbl %al,%eax
  8027dd:	50                   	push   %eax
  8027de:	ff 75 0c             	pushl  0xc(%ebp)
  8027e1:	e8 b5 fa ff ff       	call   80229b <strchr>
  8027e6:	83 c4 08             	add    $0x8,%esp
  8027e9:	85 c0                	test   %eax,%eax
  8027eb:	74 dc                	je     8027c9 <strsplit+0x8c>
			string++;
	}
  8027ed:	e9 6e ff ff ff       	jmp    802760 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8027f2:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8027f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8027f6:	8b 00                	mov    (%eax),%eax
  8027f8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8027ff:	8b 45 10             	mov    0x10(%ebp),%eax
  802802:	01 d0                	add    %edx,%eax
  802804:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80280a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80280f:	c9                   	leave  
  802810:	c3                   	ret    

00802811 <malloc>:
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
  802811:	55                   	push   %ebp
  802812:	89 e5                	mov    %esp,%ebp
  802814:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  802817:	8b 45 08             	mov    0x8(%ebp),%eax
  80281a:	c1 e8 0c             	shr    $0xc,%eax
  80281d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  802820:	8b 45 08             	mov    0x8(%ebp),%eax
  802823:	25 ff 0f 00 00       	and    $0xfff,%eax
  802828:	85 c0                	test   %eax,%eax
  80282a:	74 03                	je     80282f <malloc+0x1e>
			num++;
  80282c:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  80282f:	a1 04 40 80 00       	mov    0x804004,%eax
  802834:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  802839:	75 73                	jne    8028ae <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  80283b:	83 ec 08             	sub    $0x8,%esp
  80283e:	ff 75 08             	pushl  0x8(%ebp)
  802841:	68 00 00 00 80       	push   $0x80000000
  802846:	e8 13 05 00 00       	call   802d5e <sys_allocateMem>
  80284b:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  80284e:	a1 04 40 80 00       	mov    0x804004,%eax
  802853:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  802856:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802859:	c1 e0 0c             	shl    $0xc,%eax
  80285c:	89 c2                	mov    %eax,%edx
  80285e:	a1 04 40 80 00       	mov    0x804004,%eax
  802863:	01 d0                	add    %edx,%eax
  802865:	a3 04 40 80 00       	mov    %eax,0x804004
			numOfPages[sizeofarray]=num;
  80286a:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80286f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802872:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
			addresses[sizeofarray]=last_addres;
  802879:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80287e:	8b 15 04 40 80 00    	mov    0x804004,%edx
  802884:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
			changed[sizeofarray]=1;
  80288b:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802890:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  802897:	01 00 00 00 
			sizeofarray++;
  80289b:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8028a0:	40                   	inc    %eax
  8028a1:	a3 2c 40 80 00       	mov    %eax,0x80402c
			return (void*)return_addres;
  8028a6:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8028a9:	e9 71 01 00 00       	jmp    802a1f <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  8028ae:	a1 28 40 80 00       	mov    0x804028,%eax
  8028b3:	85 c0                	test   %eax,%eax
  8028b5:	75 71                	jne    802928 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  8028b7:	a1 04 40 80 00       	mov    0x804004,%eax
  8028bc:	83 ec 08             	sub    $0x8,%esp
  8028bf:	ff 75 08             	pushl  0x8(%ebp)
  8028c2:	50                   	push   %eax
  8028c3:	e8 96 04 00 00       	call   802d5e <sys_allocateMem>
  8028c8:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  8028cb:	a1 04 40 80 00       	mov    0x804004,%eax
  8028d0:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  8028d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8028d6:	c1 e0 0c             	shl    $0xc,%eax
  8028d9:	89 c2                	mov    %eax,%edx
  8028db:	a1 04 40 80 00       	mov    0x804004,%eax
  8028e0:	01 d0                	add    %edx,%eax
  8028e2:	a3 04 40 80 00       	mov    %eax,0x804004
				numOfPages[sizeofarray]=num;
  8028e7:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8028ec:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8028ef:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
				addresses[sizeofarray]=return_addres;
  8028f6:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8028fb:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8028fe:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				changed[sizeofarray]=1;
  802905:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80290a:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  802911:	01 00 00 00 
				sizeofarray++;
  802915:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80291a:	40                   	inc    %eax
  80291b:	a3 2c 40 80 00       	mov    %eax,0x80402c
				return (void*)return_addres;
  802920:	8b 45 d8             	mov    -0x28(%ebp),%eax
  802923:	e9 f7 00 00 00       	jmp    802a1f <malloc+0x20e>
			}
			else{
				int count=0;
  802928:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  80292f:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  802936:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  80293d:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  802944:	eb 7c                	jmp    8029c2 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  802946:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  80294d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  802954:	eb 1a                	jmp    802970 <malloc+0x15f>
					{
						if(addresses[j]==i)
  802956:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802959:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802960:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  802963:	75 08                	jne    80296d <malloc+0x15c>
						{
							index=j;
  802965:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802968:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  80296b:	eb 0d                	jmp    80297a <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  80296d:	ff 45 dc             	incl   -0x24(%ebp)
  802970:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802975:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  802978:	7c dc                	jl     802956 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  80297a:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  80297e:	75 05                	jne    802985 <malloc+0x174>
					{
						count++;
  802980:	ff 45 f0             	incl   -0x10(%ebp)
  802983:	eb 36                	jmp    8029bb <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  802985:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802988:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  80298f:	85 c0                	test   %eax,%eax
  802991:	75 05                	jne    802998 <malloc+0x187>
						{
							count++;
  802993:	ff 45 f0             	incl   -0x10(%ebp)
  802996:	eb 23                	jmp    8029bb <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  802998:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80299b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  80299e:	7d 14                	jge    8029b4 <malloc+0x1a3>
  8029a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8029a3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8029a6:	7c 0c                	jl     8029b4 <malloc+0x1a3>
							{
								min=count;
  8029a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8029ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  8029ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8029b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  8029b4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8029bb:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  8029c2:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  8029c9:	0f 86 77 ff ff ff    	jbe    802946 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  8029cf:	83 ec 08             	sub    $0x8,%esp
  8029d2:	ff 75 08             	pushl  0x8(%ebp)
  8029d5:	ff 75 e4             	pushl  -0x1c(%ebp)
  8029d8:	e8 81 03 00 00       	call   802d5e <sys_allocateMem>
  8029dd:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  8029e0:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8029e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8029e8:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
				addresses[sizeofarray]=last_addres;
  8029ef:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8029f4:	8b 15 04 40 80 00    	mov    0x804004,%edx
  8029fa:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				changed[sizeofarray]=1;
  802a01:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802a06:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  802a0d:	01 00 00 00 
				sizeofarray++;
  802a11:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802a16:	40                   	inc    %eax
  802a17:	a3 2c 40 80 00       	mov    %eax,0x80402c
				return(void*) min_addresss;
  802a1c:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  802a1f:	c9                   	leave  
  802a20:	c3                   	ret    

00802a21 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  802a21:	55                   	push   %ebp
  802a22:	89 e5                	mov    %esp,%ebp
  802a24:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  802a27:	8b 45 08             	mov    0x8(%ebp),%eax
  802a2a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    uint32 size;
    int is_found=0;
  802a2d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  802a34:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  802a3b:	eb 30                	jmp    802a6d <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  802a3d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802a40:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802a47:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  802a4a:	75 1e                	jne    802a6a <free+0x49>
  802a4c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802a4f:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  802a56:	83 f8 01             	cmp    $0x1,%eax
  802a59:	75 0f                	jne    802a6a <free+0x49>
    		is_found=1;
  802a5b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  802a62:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802a65:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  802a68:	eb 0d                	jmp    802a77 <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    uint32 size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  802a6a:	ff 45 ec             	incl   -0x14(%ebp)
  802a6d:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802a72:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  802a75:	7c c6                	jl     802a3d <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  802a77:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  802a7b:	75 3a                	jne    802ab7 <free+0x96>
    	size=numOfPages[index]*PAGE_SIZE;
  802a7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802a80:	8b 04 85 20 76 8c 00 	mov    0x8c7620(,%eax,4),%eax
  802a87:	c1 e0 0c             	shl    $0xc,%eax
  802a8a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  802a8d:	83 ec 08             	sub    $0x8,%esp
  802a90:	ff 75 e4             	pushl  -0x1c(%ebp)
  802a93:	ff 75 e8             	pushl  -0x18(%ebp)
  802a96:	e8 a7 02 00 00       	call   802d42 <sys_freeMem>
  802a9b:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  802a9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802aa1:	c7 04 85 a0 5b 86 00 	movl   $0x0,0x865ba0(,%eax,4)
  802aa8:	00 00 00 00 
    	changes++;
  802aac:	a1 28 40 80 00       	mov    0x804028,%eax
  802ab1:	40                   	inc    %eax
  802ab2:	a3 28 40 80 00       	mov    %eax,0x804028
    }


	//refer to the project presentation and documentation for details
}
  802ab7:	90                   	nop
  802ab8:	c9                   	leave  
  802ab9:	c3                   	ret    

00802aba <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  802aba:	55                   	push   %ebp
  802abb:	89 e5                	mov    %esp,%ebp
  802abd:	83 ec 18             	sub    $0x18,%esp
  802ac0:	8b 45 10             	mov    0x10(%ebp),%eax
  802ac3:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  802ac6:	83 ec 04             	sub    $0x4,%esp
  802ac9:	68 90 3c 80 00       	push   $0x803c90
  802ace:	68 9f 00 00 00       	push   $0x9f
  802ad3:	68 b3 3c 80 00       	push   $0x803cb3
  802ad8:	e8 08 ed ff ff       	call   8017e5 <_panic>

00802add <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  802add:	55                   	push   %ebp
  802ade:	89 e5                	mov    %esp,%ebp
  802ae0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802ae3:	83 ec 04             	sub    $0x4,%esp
  802ae6:	68 90 3c 80 00       	push   $0x803c90
  802aeb:	68 a5 00 00 00       	push   $0xa5
  802af0:	68 b3 3c 80 00       	push   $0x803cb3
  802af5:	e8 eb ec ff ff       	call   8017e5 <_panic>

00802afa <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  802afa:	55                   	push   %ebp
  802afb:	89 e5                	mov    %esp,%ebp
  802afd:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b00:	83 ec 04             	sub    $0x4,%esp
  802b03:	68 90 3c 80 00       	push   $0x803c90
  802b08:	68 ab 00 00 00       	push   $0xab
  802b0d:	68 b3 3c 80 00       	push   $0x803cb3
  802b12:	e8 ce ec ff ff       	call   8017e5 <_panic>

00802b17 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  802b17:	55                   	push   %ebp
  802b18:	89 e5                	mov    %esp,%ebp
  802b1a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b1d:	83 ec 04             	sub    $0x4,%esp
  802b20:	68 90 3c 80 00       	push   $0x803c90
  802b25:	68 b0 00 00 00       	push   $0xb0
  802b2a:	68 b3 3c 80 00       	push   $0x803cb3
  802b2f:	e8 b1 ec ff ff       	call   8017e5 <_panic>

00802b34 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  802b34:	55                   	push   %ebp
  802b35:	89 e5                	mov    %esp,%ebp
  802b37:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b3a:	83 ec 04             	sub    $0x4,%esp
  802b3d:	68 90 3c 80 00       	push   $0x803c90
  802b42:	68 b6 00 00 00       	push   $0xb6
  802b47:	68 b3 3c 80 00       	push   $0x803cb3
  802b4c:	e8 94 ec ff ff       	call   8017e5 <_panic>

00802b51 <shrink>:
}
void shrink(uint32 newSize)
{
  802b51:	55                   	push   %ebp
  802b52:	89 e5                	mov    %esp,%ebp
  802b54:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b57:	83 ec 04             	sub    $0x4,%esp
  802b5a:	68 90 3c 80 00       	push   $0x803c90
  802b5f:	68 ba 00 00 00       	push   $0xba
  802b64:	68 b3 3c 80 00       	push   $0x803cb3
  802b69:	e8 77 ec ff ff       	call   8017e5 <_panic>

00802b6e <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  802b6e:	55                   	push   %ebp
  802b6f:	89 e5                	mov    %esp,%ebp
  802b71:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b74:	83 ec 04             	sub    $0x4,%esp
  802b77:	68 90 3c 80 00       	push   $0x803c90
  802b7c:	68 bf 00 00 00       	push   $0xbf
  802b81:	68 b3 3c 80 00       	push   $0x803cb3
  802b86:	e8 5a ec ff ff       	call   8017e5 <_panic>

00802b8b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  802b8b:	55                   	push   %ebp
  802b8c:	89 e5                	mov    %esp,%ebp
  802b8e:	57                   	push   %edi
  802b8f:	56                   	push   %esi
  802b90:	53                   	push   %ebx
  802b91:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802b94:	8b 45 08             	mov    0x8(%ebp),%eax
  802b97:	8b 55 0c             	mov    0xc(%ebp),%edx
  802b9a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802b9d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802ba0:	8b 7d 18             	mov    0x18(%ebp),%edi
  802ba3:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802ba6:	cd 30                	int    $0x30
  802ba8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802bab:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802bae:	83 c4 10             	add    $0x10,%esp
  802bb1:	5b                   	pop    %ebx
  802bb2:	5e                   	pop    %esi
  802bb3:	5f                   	pop    %edi
  802bb4:	5d                   	pop    %ebp
  802bb5:	c3                   	ret    

00802bb6 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802bb6:	55                   	push   %ebp
  802bb7:	89 e5                	mov    %esp,%ebp
  802bb9:	83 ec 04             	sub    $0x4,%esp
  802bbc:	8b 45 10             	mov    0x10(%ebp),%eax
  802bbf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802bc2:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802bc6:	8b 45 08             	mov    0x8(%ebp),%eax
  802bc9:	6a 00                	push   $0x0
  802bcb:	6a 00                	push   $0x0
  802bcd:	52                   	push   %edx
  802bce:	ff 75 0c             	pushl  0xc(%ebp)
  802bd1:	50                   	push   %eax
  802bd2:	6a 00                	push   $0x0
  802bd4:	e8 b2 ff ff ff       	call   802b8b <syscall>
  802bd9:	83 c4 18             	add    $0x18,%esp
}
  802bdc:	90                   	nop
  802bdd:	c9                   	leave  
  802bde:	c3                   	ret    

00802bdf <sys_cgetc>:

int
sys_cgetc(void)
{
  802bdf:	55                   	push   %ebp
  802be0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802be2:	6a 00                	push   $0x0
  802be4:	6a 00                	push   $0x0
  802be6:	6a 00                	push   $0x0
  802be8:	6a 00                	push   $0x0
  802bea:	6a 00                	push   $0x0
  802bec:	6a 01                	push   $0x1
  802bee:	e8 98 ff ff ff       	call   802b8b <syscall>
  802bf3:	83 c4 18             	add    $0x18,%esp
}
  802bf6:	c9                   	leave  
  802bf7:	c3                   	ret    

00802bf8 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802bf8:	55                   	push   %ebp
  802bf9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  802bfe:	6a 00                	push   $0x0
  802c00:	6a 00                	push   $0x0
  802c02:	6a 00                	push   $0x0
  802c04:	6a 00                	push   $0x0
  802c06:	50                   	push   %eax
  802c07:	6a 05                	push   $0x5
  802c09:	e8 7d ff ff ff       	call   802b8b <syscall>
  802c0e:	83 c4 18             	add    $0x18,%esp
}
  802c11:	c9                   	leave  
  802c12:	c3                   	ret    

00802c13 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802c13:	55                   	push   %ebp
  802c14:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802c16:	6a 00                	push   $0x0
  802c18:	6a 00                	push   $0x0
  802c1a:	6a 00                	push   $0x0
  802c1c:	6a 00                	push   $0x0
  802c1e:	6a 00                	push   $0x0
  802c20:	6a 02                	push   $0x2
  802c22:	e8 64 ff ff ff       	call   802b8b <syscall>
  802c27:	83 c4 18             	add    $0x18,%esp
}
  802c2a:	c9                   	leave  
  802c2b:	c3                   	ret    

00802c2c <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802c2c:	55                   	push   %ebp
  802c2d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802c2f:	6a 00                	push   $0x0
  802c31:	6a 00                	push   $0x0
  802c33:	6a 00                	push   $0x0
  802c35:	6a 00                	push   $0x0
  802c37:	6a 00                	push   $0x0
  802c39:	6a 03                	push   $0x3
  802c3b:	e8 4b ff ff ff       	call   802b8b <syscall>
  802c40:	83 c4 18             	add    $0x18,%esp
}
  802c43:	c9                   	leave  
  802c44:	c3                   	ret    

00802c45 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802c45:	55                   	push   %ebp
  802c46:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802c48:	6a 00                	push   $0x0
  802c4a:	6a 00                	push   $0x0
  802c4c:	6a 00                	push   $0x0
  802c4e:	6a 00                	push   $0x0
  802c50:	6a 00                	push   $0x0
  802c52:	6a 04                	push   $0x4
  802c54:	e8 32 ff ff ff       	call   802b8b <syscall>
  802c59:	83 c4 18             	add    $0x18,%esp
}
  802c5c:	c9                   	leave  
  802c5d:	c3                   	ret    

00802c5e <sys_env_exit>:


void sys_env_exit(void)
{
  802c5e:	55                   	push   %ebp
  802c5f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802c61:	6a 00                	push   $0x0
  802c63:	6a 00                	push   $0x0
  802c65:	6a 00                	push   $0x0
  802c67:	6a 00                	push   $0x0
  802c69:	6a 00                	push   $0x0
  802c6b:	6a 06                	push   $0x6
  802c6d:	e8 19 ff ff ff       	call   802b8b <syscall>
  802c72:	83 c4 18             	add    $0x18,%esp
}
  802c75:	90                   	nop
  802c76:	c9                   	leave  
  802c77:	c3                   	ret    

00802c78 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802c78:	55                   	push   %ebp
  802c79:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802c7b:	8b 55 0c             	mov    0xc(%ebp),%edx
  802c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  802c81:	6a 00                	push   $0x0
  802c83:	6a 00                	push   $0x0
  802c85:	6a 00                	push   $0x0
  802c87:	52                   	push   %edx
  802c88:	50                   	push   %eax
  802c89:	6a 07                	push   $0x7
  802c8b:	e8 fb fe ff ff       	call   802b8b <syscall>
  802c90:	83 c4 18             	add    $0x18,%esp
}
  802c93:	c9                   	leave  
  802c94:	c3                   	ret    

00802c95 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802c95:	55                   	push   %ebp
  802c96:	89 e5                	mov    %esp,%ebp
  802c98:	56                   	push   %esi
  802c99:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802c9a:	8b 75 18             	mov    0x18(%ebp),%esi
  802c9d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802ca0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802ca3:	8b 55 0c             	mov    0xc(%ebp),%edx
  802ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  802ca9:	56                   	push   %esi
  802caa:	53                   	push   %ebx
  802cab:	51                   	push   %ecx
  802cac:	52                   	push   %edx
  802cad:	50                   	push   %eax
  802cae:	6a 08                	push   $0x8
  802cb0:	e8 d6 fe ff ff       	call   802b8b <syscall>
  802cb5:	83 c4 18             	add    $0x18,%esp
}
  802cb8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802cbb:	5b                   	pop    %ebx
  802cbc:	5e                   	pop    %esi
  802cbd:	5d                   	pop    %ebp
  802cbe:	c3                   	ret    

00802cbf <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802cbf:	55                   	push   %ebp
  802cc0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802cc2:	8b 55 0c             	mov    0xc(%ebp),%edx
  802cc5:	8b 45 08             	mov    0x8(%ebp),%eax
  802cc8:	6a 00                	push   $0x0
  802cca:	6a 00                	push   $0x0
  802ccc:	6a 00                	push   $0x0
  802cce:	52                   	push   %edx
  802ccf:	50                   	push   %eax
  802cd0:	6a 09                	push   $0x9
  802cd2:	e8 b4 fe ff ff       	call   802b8b <syscall>
  802cd7:	83 c4 18             	add    $0x18,%esp
}
  802cda:	c9                   	leave  
  802cdb:	c3                   	ret    

00802cdc <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802cdc:	55                   	push   %ebp
  802cdd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802cdf:	6a 00                	push   $0x0
  802ce1:	6a 00                	push   $0x0
  802ce3:	6a 00                	push   $0x0
  802ce5:	ff 75 0c             	pushl  0xc(%ebp)
  802ce8:	ff 75 08             	pushl  0x8(%ebp)
  802ceb:	6a 0a                	push   $0xa
  802ced:	e8 99 fe ff ff       	call   802b8b <syscall>
  802cf2:	83 c4 18             	add    $0x18,%esp
}
  802cf5:	c9                   	leave  
  802cf6:	c3                   	ret    

00802cf7 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802cf7:	55                   	push   %ebp
  802cf8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802cfa:	6a 00                	push   $0x0
  802cfc:	6a 00                	push   $0x0
  802cfe:	6a 00                	push   $0x0
  802d00:	6a 00                	push   $0x0
  802d02:	6a 00                	push   $0x0
  802d04:	6a 0b                	push   $0xb
  802d06:	e8 80 fe ff ff       	call   802b8b <syscall>
  802d0b:	83 c4 18             	add    $0x18,%esp
}
  802d0e:	c9                   	leave  
  802d0f:	c3                   	ret    

00802d10 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802d10:	55                   	push   %ebp
  802d11:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802d13:	6a 00                	push   $0x0
  802d15:	6a 00                	push   $0x0
  802d17:	6a 00                	push   $0x0
  802d19:	6a 00                	push   $0x0
  802d1b:	6a 00                	push   $0x0
  802d1d:	6a 0c                	push   $0xc
  802d1f:	e8 67 fe ff ff       	call   802b8b <syscall>
  802d24:	83 c4 18             	add    $0x18,%esp
}
  802d27:	c9                   	leave  
  802d28:	c3                   	ret    

00802d29 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802d29:	55                   	push   %ebp
  802d2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802d2c:	6a 00                	push   $0x0
  802d2e:	6a 00                	push   $0x0
  802d30:	6a 00                	push   $0x0
  802d32:	6a 00                	push   $0x0
  802d34:	6a 00                	push   $0x0
  802d36:	6a 0d                	push   $0xd
  802d38:	e8 4e fe ff ff       	call   802b8b <syscall>
  802d3d:	83 c4 18             	add    $0x18,%esp
}
  802d40:	c9                   	leave  
  802d41:	c3                   	ret    

00802d42 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802d42:	55                   	push   %ebp
  802d43:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802d45:	6a 00                	push   $0x0
  802d47:	6a 00                	push   $0x0
  802d49:	6a 00                	push   $0x0
  802d4b:	ff 75 0c             	pushl  0xc(%ebp)
  802d4e:	ff 75 08             	pushl  0x8(%ebp)
  802d51:	6a 11                	push   $0x11
  802d53:	e8 33 fe ff ff       	call   802b8b <syscall>
  802d58:	83 c4 18             	add    $0x18,%esp
	return;
  802d5b:	90                   	nop
}
  802d5c:	c9                   	leave  
  802d5d:	c3                   	ret    

00802d5e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802d5e:	55                   	push   %ebp
  802d5f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802d61:	6a 00                	push   $0x0
  802d63:	6a 00                	push   $0x0
  802d65:	6a 00                	push   $0x0
  802d67:	ff 75 0c             	pushl  0xc(%ebp)
  802d6a:	ff 75 08             	pushl  0x8(%ebp)
  802d6d:	6a 12                	push   $0x12
  802d6f:	e8 17 fe ff ff       	call   802b8b <syscall>
  802d74:	83 c4 18             	add    $0x18,%esp
	return ;
  802d77:	90                   	nop
}
  802d78:	c9                   	leave  
  802d79:	c3                   	ret    

00802d7a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802d7a:	55                   	push   %ebp
  802d7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802d7d:	6a 00                	push   $0x0
  802d7f:	6a 00                	push   $0x0
  802d81:	6a 00                	push   $0x0
  802d83:	6a 00                	push   $0x0
  802d85:	6a 00                	push   $0x0
  802d87:	6a 0e                	push   $0xe
  802d89:	e8 fd fd ff ff       	call   802b8b <syscall>
  802d8e:	83 c4 18             	add    $0x18,%esp
}
  802d91:	c9                   	leave  
  802d92:	c3                   	ret    

00802d93 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802d93:	55                   	push   %ebp
  802d94:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802d96:	6a 00                	push   $0x0
  802d98:	6a 00                	push   $0x0
  802d9a:	6a 00                	push   $0x0
  802d9c:	6a 00                	push   $0x0
  802d9e:	ff 75 08             	pushl  0x8(%ebp)
  802da1:	6a 0f                	push   $0xf
  802da3:	e8 e3 fd ff ff       	call   802b8b <syscall>
  802da8:	83 c4 18             	add    $0x18,%esp
}
  802dab:	c9                   	leave  
  802dac:	c3                   	ret    

00802dad <sys_scarce_memory>:

void sys_scarce_memory()
{
  802dad:	55                   	push   %ebp
  802dae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802db0:	6a 00                	push   $0x0
  802db2:	6a 00                	push   $0x0
  802db4:	6a 00                	push   $0x0
  802db6:	6a 00                	push   $0x0
  802db8:	6a 00                	push   $0x0
  802dba:	6a 10                	push   $0x10
  802dbc:	e8 ca fd ff ff       	call   802b8b <syscall>
  802dc1:	83 c4 18             	add    $0x18,%esp
}
  802dc4:	90                   	nop
  802dc5:	c9                   	leave  
  802dc6:	c3                   	ret    

00802dc7 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802dc7:	55                   	push   %ebp
  802dc8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802dca:	6a 00                	push   $0x0
  802dcc:	6a 00                	push   $0x0
  802dce:	6a 00                	push   $0x0
  802dd0:	6a 00                	push   $0x0
  802dd2:	6a 00                	push   $0x0
  802dd4:	6a 14                	push   $0x14
  802dd6:	e8 b0 fd ff ff       	call   802b8b <syscall>
  802ddb:	83 c4 18             	add    $0x18,%esp
}
  802dde:	90                   	nop
  802ddf:	c9                   	leave  
  802de0:	c3                   	ret    

00802de1 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802de1:	55                   	push   %ebp
  802de2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802de4:	6a 00                	push   $0x0
  802de6:	6a 00                	push   $0x0
  802de8:	6a 00                	push   $0x0
  802dea:	6a 00                	push   $0x0
  802dec:	6a 00                	push   $0x0
  802dee:	6a 15                	push   $0x15
  802df0:	e8 96 fd ff ff       	call   802b8b <syscall>
  802df5:	83 c4 18             	add    $0x18,%esp
}
  802df8:	90                   	nop
  802df9:	c9                   	leave  
  802dfa:	c3                   	ret    

00802dfb <sys_cputc>:


void
sys_cputc(const char c)
{
  802dfb:	55                   	push   %ebp
  802dfc:	89 e5                	mov    %esp,%ebp
  802dfe:	83 ec 04             	sub    $0x4,%esp
  802e01:	8b 45 08             	mov    0x8(%ebp),%eax
  802e04:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802e07:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802e0b:	6a 00                	push   $0x0
  802e0d:	6a 00                	push   $0x0
  802e0f:	6a 00                	push   $0x0
  802e11:	6a 00                	push   $0x0
  802e13:	50                   	push   %eax
  802e14:	6a 16                	push   $0x16
  802e16:	e8 70 fd ff ff       	call   802b8b <syscall>
  802e1b:	83 c4 18             	add    $0x18,%esp
}
  802e1e:	90                   	nop
  802e1f:	c9                   	leave  
  802e20:	c3                   	ret    

00802e21 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802e21:	55                   	push   %ebp
  802e22:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802e24:	6a 00                	push   $0x0
  802e26:	6a 00                	push   $0x0
  802e28:	6a 00                	push   $0x0
  802e2a:	6a 00                	push   $0x0
  802e2c:	6a 00                	push   $0x0
  802e2e:	6a 17                	push   $0x17
  802e30:	e8 56 fd ff ff       	call   802b8b <syscall>
  802e35:	83 c4 18             	add    $0x18,%esp
}
  802e38:	90                   	nop
  802e39:	c9                   	leave  
  802e3a:	c3                   	ret    

00802e3b <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802e3b:	55                   	push   %ebp
  802e3c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  802e41:	6a 00                	push   $0x0
  802e43:	6a 00                	push   $0x0
  802e45:	6a 00                	push   $0x0
  802e47:	ff 75 0c             	pushl  0xc(%ebp)
  802e4a:	50                   	push   %eax
  802e4b:	6a 18                	push   $0x18
  802e4d:	e8 39 fd ff ff       	call   802b8b <syscall>
  802e52:	83 c4 18             	add    $0x18,%esp
}
  802e55:	c9                   	leave  
  802e56:	c3                   	ret    

00802e57 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802e57:	55                   	push   %ebp
  802e58:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802e5a:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  802e60:	6a 00                	push   $0x0
  802e62:	6a 00                	push   $0x0
  802e64:	6a 00                	push   $0x0
  802e66:	52                   	push   %edx
  802e67:	50                   	push   %eax
  802e68:	6a 1b                	push   $0x1b
  802e6a:	e8 1c fd ff ff       	call   802b8b <syscall>
  802e6f:	83 c4 18             	add    $0x18,%esp
}
  802e72:	c9                   	leave  
  802e73:	c3                   	ret    

00802e74 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802e74:	55                   	push   %ebp
  802e75:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802e77:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e7a:	8b 45 08             	mov    0x8(%ebp),%eax
  802e7d:	6a 00                	push   $0x0
  802e7f:	6a 00                	push   $0x0
  802e81:	6a 00                	push   $0x0
  802e83:	52                   	push   %edx
  802e84:	50                   	push   %eax
  802e85:	6a 19                	push   $0x19
  802e87:	e8 ff fc ff ff       	call   802b8b <syscall>
  802e8c:	83 c4 18             	add    $0x18,%esp
}
  802e8f:	90                   	nop
  802e90:	c9                   	leave  
  802e91:	c3                   	ret    

00802e92 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802e92:	55                   	push   %ebp
  802e93:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802e95:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e98:	8b 45 08             	mov    0x8(%ebp),%eax
  802e9b:	6a 00                	push   $0x0
  802e9d:	6a 00                	push   $0x0
  802e9f:	6a 00                	push   $0x0
  802ea1:	52                   	push   %edx
  802ea2:	50                   	push   %eax
  802ea3:	6a 1a                	push   $0x1a
  802ea5:	e8 e1 fc ff ff       	call   802b8b <syscall>
  802eaa:	83 c4 18             	add    $0x18,%esp
}
  802ead:	90                   	nop
  802eae:	c9                   	leave  
  802eaf:	c3                   	ret    

00802eb0 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802eb0:	55                   	push   %ebp
  802eb1:	89 e5                	mov    %esp,%ebp
  802eb3:	83 ec 04             	sub    $0x4,%esp
  802eb6:	8b 45 10             	mov    0x10(%ebp),%eax
  802eb9:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802ebc:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802ebf:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802ec3:	8b 45 08             	mov    0x8(%ebp),%eax
  802ec6:	6a 00                	push   $0x0
  802ec8:	51                   	push   %ecx
  802ec9:	52                   	push   %edx
  802eca:	ff 75 0c             	pushl  0xc(%ebp)
  802ecd:	50                   	push   %eax
  802ece:	6a 1c                	push   $0x1c
  802ed0:	e8 b6 fc ff ff       	call   802b8b <syscall>
  802ed5:	83 c4 18             	add    $0x18,%esp
}
  802ed8:	c9                   	leave  
  802ed9:	c3                   	ret    

00802eda <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802eda:	55                   	push   %ebp
  802edb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802edd:	8b 55 0c             	mov    0xc(%ebp),%edx
  802ee0:	8b 45 08             	mov    0x8(%ebp),%eax
  802ee3:	6a 00                	push   $0x0
  802ee5:	6a 00                	push   $0x0
  802ee7:	6a 00                	push   $0x0
  802ee9:	52                   	push   %edx
  802eea:	50                   	push   %eax
  802eeb:	6a 1d                	push   $0x1d
  802eed:	e8 99 fc ff ff       	call   802b8b <syscall>
  802ef2:	83 c4 18             	add    $0x18,%esp
}
  802ef5:	c9                   	leave  
  802ef6:	c3                   	ret    

00802ef7 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802ef7:	55                   	push   %ebp
  802ef8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802efa:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802efd:	8b 55 0c             	mov    0xc(%ebp),%edx
  802f00:	8b 45 08             	mov    0x8(%ebp),%eax
  802f03:	6a 00                	push   $0x0
  802f05:	6a 00                	push   $0x0
  802f07:	51                   	push   %ecx
  802f08:	52                   	push   %edx
  802f09:	50                   	push   %eax
  802f0a:	6a 1e                	push   $0x1e
  802f0c:	e8 7a fc ff ff       	call   802b8b <syscall>
  802f11:	83 c4 18             	add    $0x18,%esp
}
  802f14:	c9                   	leave  
  802f15:	c3                   	ret    

00802f16 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802f16:	55                   	push   %ebp
  802f17:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802f19:	8b 55 0c             	mov    0xc(%ebp),%edx
  802f1c:	8b 45 08             	mov    0x8(%ebp),%eax
  802f1f:	6a 00                	push   $0x0
  802f21:	6a 00                	push   $0x0
  802f23:	6a 00                	push   $0x0
  802f25:	52                   	push   %edx
  802f26:	50                   	push   %eax
  802f27:	6a 1f                	push   $0x1f
  802f29:	e8 5d fc ff ff       	call   802b8b <syscall>
  802f2e:	83 c4 18             	add    $0x18,%esp
}
  802f31:	c9                   	leave  
  802f32:	c3                   	ret    

00802f33 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802f33:	55                   	push   %ebp
  802f34:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802f36:	6a 00                	push   $0x0
  802f38:	6a 00                	push   $0x0
  802f3a:	6a 00                	push   $0x0
  802f3c:	6a 00                	push   $0x0
  802f3e:	6a 00                	push   $0x0
  802f40:	6a 20                	push   $0x20
  802f42:	e8 44 fc ff ff       	call   802b8b <syscall>
  802f47:	83 c4 18             	add    $0x18,%esp
}
  802f4a:	c9                   	leave  
  802f4b:	c3                   	ret    

00802f4c <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802f4c:	55                   	push   %ebp
  802f4d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  802f52:	6a 00                	push   $0x0
  802f54:	ff 75 14             	pushl  0x14(%ebp)
  802f57:	ff 75 10             	pushl  0x10(%ebp)
  802f5a:	ff 75 0c             	pushl  0xc(%ebp)
  802f5d:	50                   	push   %eax
  802f5e:	6a 21                	push   $0x21
  802f60:	e8 26 fc ff ff       	call   802b8b <syscall>
  802f65:	83 c4 18             	add    $0x18,%esp
}
  802f68:	c9                   	leave  
  802f69:	c3                   	ret    

00802f6a <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802f6a:	55                   	push   %ebp
  802f6b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  802f70:	6a 00                	push   $0x0
  802f72:	6a 00                	push   $0x0
  802f74:	6a 00                	push   $0x0
  802f76:	6a 00                	push   $0x0
  802f78:	50                   	push   %eax
  802f79:	6a 22                	push   $0x22
  802f7b:	e8 0b fc ff ff       	call   802b8b <syscall>
  802f80:	83 c4 18             	add    $0x18,%esp
}
  802f83:	90                   	nop
  802f84:	c9                   	leave  
  802f85:	c3                   	ret    

00802f86 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802f86:	55                   	push   %ebp
  802f87:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802f89:	8b 45 08             	mov    0x8(%ebp),%eax
  802f8c:	6a 00                	push   $0x0
  802f8e:	6a 00                	push   $0x0
  802f90:	6a 00                	push   $0x0
  802f92:	6a 00                	push   $0x0
  802f94:	50                   	push   %eax
  802f95:	6a 23                	push   $0x23
  802f97:	e8 ef fb ff ff       	call   802b8b <syscall>
  802f9c:	83 c4 18             	add    $0x18,%esp
}
  802f9f:	90                   	nop
  802fa0:	c9                   	leave  
  802fa1:	c3                   	ret    

00802fa2 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802fa2:	55                   	push   %ebp
  802fa3:	89 e5                	mov    %esp,%ebp
  802fa5:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802fa8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802fab:	8d 50 04             	lea    0x4(%eax),%edx
  802fae:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802fb1:	6a 00                	push   $0x0
  802fb3:	6a 00                	push   $0x0
  802fb5:	6a 00                	push   $0x0
  802fb7:	52                   	push   %edx
  802fb8:	50                   	push   %eax
  802fb9:	6a 24                	push   $0x24
  802fbb:	e8 cb fb ff ff       	call   802b8b <syscall>
  802fc0:	83 c4 18             	add    $0x18,%esp
	return result;
  802fc3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802fc6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802fc9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802fcc:	89 01                	mov    %eax,(%ecx)
  802fce:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  802fd4:	c9                   	leave  
  802fd5:	c2 04 00             	ret    $0x4

00802fd8 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802fd8:	55                   	push   %ebp
  802fd9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802fdb:	6a 00                	push   $0x0
  802fdd:	6a 00                	push   $0x0
  802fdf:	ff 75 10             	pushl  0x10(%ebp)
  802fe2:	ff 75 0c             	pushl  0xc(%ebp)
  802fe5:	ff 75 08             	pushl  0x8(%ebp)
  802fe8:	6a 13                	push   $0x13
  802fea:	e8 9c fb ff ff       	call   802b8b <syscall>
  802fef:	83 c4 18             	add    $0x18,%esp
	return ;
  802ff2:	90                   	nop
}
  802ff3:	c9                   	leave  
  802ff4:	c3                   	ret    

00802ff5 <sys_rcr2>:
uint32 sys_rcr2()
{
  802ff5:	55                   	push   %ebp
  802ff6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802ff8:	6a 00                	push   $0x0
  802ffa:	6a 00                	push   $0x0
  802ffc:	6a 00                	push   $0x0
  802ffe:	6a 00                	push   $0x0
  803000:	6a 00                	push   $0x0
  803002:	6a 25                	push   $0x25
  803004:	e8 82 fb ff ff       	call   802b8b <syscall>
  803009:	83 c4 18             	add    $0x18,%esp
}
  80300c:	c9                   	leave  
  80300d:	c3                   	ret    

0080300e <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80300e:	55                   	push   %ebp
  80300f:	89 e5                	mov    %esp,%ebp
  803011:	83 ec 04             	sub    $0x4,%esp
  803014:	8b 45 08             	mov    0x8(%ebp),%eax
  803017:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80301a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80301e:	6a 00                	push   $0x0
  803020:	6a 00                	push   $0x0
  803022:	6a 00                	push   $0x0
  803024:	6a 00                	push   $0x0
  803026:	50                   	push   %eax
  803027:	6a 26                	push   $0x26
  803029:	e8 5d fb ff ff       	call   802b8b <syscall>
  80302e:	83 c4 18             	add    $0x18,%esp
	return ;
  803031:	90                   	nop
}
  803032:	c9                   	leave  
  803033:	c3                   	ret    

00803034 <rsttst>:
void rsttst()
{
  803034:	55                   	push   %ebp
  803035:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  803037:	6a 00                	push   $0x0
  803039:	6a 00                	push   $0x0
  80303b:	6a 00                	push   $0x0
  80303d:	6a 00                	push   $0x0
  80303f:	6a 00                	push   $0x0
  803041:	6a 28                	push   $0x28
  803043:	e8 43 fb ff ff       	call   802b8b <syscall>
  803048:	83 c4 18             	add    $0x18,%esp
	return ;
  80304b:	90                   	nop
}
  80304c:	c9                   	leave  
  80304d:	c3                   	ret    

0080304e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80304e:	55                   	push   %ebp
  80304f:	89 e5                	mov    %esp,%ebp
  803051:	83 ec 04             	sub    $0x4,%esp
  803054:	8b 45 14             	mov    0x14(%ebp),%eax
  803057:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80305a:	8b 55 18             	mov    0x18(%ebp),%edx
  80305d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  803061:	52                   	push   %edx
  803062:	50                   	push   %eax
  803063:	ff 75 10             	pushl  0x10(%ebp)
  803066:	ff 75 0c             	pushl  0xc(%ebp)
  803069:	ff 75 08             	pushl  0x8(%ebp)
  80306c:	6a 27                	push   $0x27
  80306e:	e8 18 fb ff ff       	call   802b8b <syscall>
  803073:	83 c4 18             	add    $0x18,%esp
	return ;
  803076:	90                   	nop
}
  803077:	c9                   	leave  
  803078:	c3                   	ret    

00803079 <chktst>:
void chktst(uint32 n)
{
  803079:	55                   	push   %ebp
  80307a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80307c:	6a 00                	push   $0x0
  80307e:	6a 00                	push   $0x0
  803080:	6a 00                	push   $0x0
  803082:	6a 00                	push   $0x0
  803084:	ff 75 08             	pushl  0x8(%ebp)
  803087:	6a 29                	push   $0x29
  803089:	e8 fd fa ff ff       	call   802b8b <syscall>
  80308e:	83 c4 18             	add    $0x18,%esp
	return ;
  803091:	90                   	nop
}
  803092:	c9                   	leave  
  803093:	c3                   	ret    

00803094 <inctst>:

void inctst()
{
  803094:	55                   	push   %ebp
  803095:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  803097:	6a 00                	push   $0x0
  803099:	6a 00                	push   $0x0
  80309b:	6a 00                	push   $0x0
  80309d:	6a 00                	push   $0x0
  80309f:	6a 00                	push   $0x0
  8030a1:	6a 2a                	push   $0x2a
  8030a3:	e8 e3 fa ff ff       	call   802b8b <syscall>
  8030a8:	83 c4 18             	add    $0x18,%esp
	return ;
  8030ab:	90                   	nop
}
  8030ac:	c9                   	leave  
  8030ad:	c3                   	ret    

008030ae <gettst>:
uint32 gettst()
{
  8030ae:	55                   	push   %ebp
  8030af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8030b1:	6a 00                	push   $0x0
  8030b3:	6a 00                	push   $0x0
  8030b5:	6a 00                	push   $0x0
  8030b7:	6a 00                	push   $0x0
  8030b9:	6a 00                	push   $0x0
  8030bb:	6a 2b                	push   $0x2b
  8030bd:	e8 c9 fa ff ff       	call   802b8b <syscall>
  8030c2:	83 c4 18             	add    $0x18,%esp
}
  8030c5:	c9                   	leave  
  8030c6:	c3                   	ret    

008030c7 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8030c7:	55                   	push   %ebp
  8030c8:	89 e5                	mov    %esp,%ebp
  8030ca:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8030cd:	6a 00                	push   $0x0
  8030cf:	6a 00                	push   $0x0
  8030d1:	6a 00                	push   $0x0
  8030d3:	6a 00                	push   $0x0
  8030d5:	6a 00                	push   $0x0
  8030d7:	6a 2c                	push   $0x2c
  8030d9:	e8 ad fa ff ff       	call   802b8b <syscall>
  8030de:	83 c4 18             	add    $0x18,%esp
  8030e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8030e4:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8030e8:	75 07                	jne    8030f1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8030ea:	b8 01 00 00 00       	mov    $0x1,%eax
  8030ef:	eb 05                	jmp    8030f6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8030f1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8030f6:	c9                   	leave  
  8030f7:	c3                   	ret    

008030f8 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8030f8:	55                   	push   %ebp
  8030f9:	89 e5                	mov    %esp,%ebp
  8030fb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8030fe:	6a 00                	push   $0x0
  803100:	6a 00                	push   $0x0
  803102:	6a 00                	push   $0x0
  803104:	6a 00                	push   $0x0
  803106:	6a 00                	push   $0x0
  803108:	6a 2c                	push   $0x2c
  80310a:	e8 7c fa ff ff       	call   802b8b <syscall>
  80310f:	83 c4 18             	add    $0x18,%esp
  803112:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  803115:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  803119:	75 07                	jne    803122 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80311b:	b8 01 00 00 00       	mov    $0x1,%eax
  803120:	eb 05                	jmp    803127 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  803122:	b8 00 00 00 00       	mov    $0x0,%eax
}
  803127:	c9                   	leave  
  803128:	c3                   	ret    

00803129 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  803129:	55                   	push   %ebp
  80312a:	89 e5                	mov    %esp,%ebp
  80312c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80312f:	6a 00                	push   $0x0
  803131:	6a 00                	push   $0x0
  803133:	6a 00                	push   $0x0
  803135:	6a 00                	push   $0x0
  803137:	6a 00                	push   $0x0
  803139:	6a 2c                	push   $0x2c
  80313b:	e8 4b fa ff ff       	call   802b8b <syscall>
  803140:	83 c4 18             	add    $0x18,%esp
  803143:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  803146:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80314a:	75 07                	jne    803153 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80314c:	b8 01 00 00 00       	mov    $0x1,%eax
  803151:	eb 05                	jmp    803158 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  803153:	b8 00 00 00 00       	mov    $0x0,%eax
}
  803158:	c9                   	leave  
  803159:	c3                   	ret    

0080315a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80315a:	55                   	push   %ebp
  80315b:	89 e5                	mov    %esp,%ebp
  80315d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  803160:	6a 00                	push   $0x0
  803162:	6a 00                	push   $0x0
  803164:	6a 00                	push   $0x0
  803166:	6a 00                	push   $0x0
  803168:	6a 00                	push   $0x0
  80316a:	6a 2c                	push   $0x2c
  80316c:	e8 1a fa ff ff       	call   802b8b <syscall>
  803171:	83 c4 18             	add    $0x18,%esp
  803174:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  803177:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80317b:	75 07                	jne    803184 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80317d:	b8 01 00 00 00       	mov    $0x1,%eax
  803182:	eb 05                	jmp    803189 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  803184:	b8 00 00 00 00       	mov    $0x0,%eax
}
  803189:	c9                   	leave  
  80318a:	c3                   	ret    

0080318b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80318b:	55                   	push   %ebp
  80318c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80318e:	6a 00                	push   $0x0
  803190:	6a 00                	push   $0x0
  803192:	6a 00                	push   $0x0
  803194:	6a 00                	push   $0x0
  803196:	ff 75 08             	pushl  0x8(%ebp)
  803199:	6a 2d                	push   $0x2d
  80319b:	e8 eb f9 ff ff       	call   802b8b <syscall>
  8031a0:	83 c4 18             	add    $0x18,%esp
	return ;
  8031a3:	90                   	nop
}
  8031a4:	c9                   	leave  
  8031a5:	c3                   	ret    

008031a6 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8031a6:	55                   	push   %ebp
  8031a7:	89 e5                	mov    %esp,%ebp
  8031a9:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8031aa:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8031ad:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8031b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8031b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8031b6:	6a 00                	push   $0x0
  8031b8:	53                   	push   %ebx
  8031b9:	51                   	push   %ecx
  8031ba:	52                   	push   %edx
  8031bb:	50                   	push   %eax
  8031bc:	6a 2e                	push   $0x2e
  8031be:	e8 c8 f9 ff ff       	call   802b8b <syscall>
  8031c3:	83 c4 18             	add    $0x18,%esp
}
  8031c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8031c9:	c9                   	leave  
  8031ca:	c3                   	ret    

008031cb <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8031cb:	55                   	push   %ebp
  8031cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8031ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8031d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8031d4:	6a 00                	push   $0x0
  8031d6:	6a 00                	push   $0x0
  8031d8:	6a 00                	push   $0x0
  8031da:	52                   	push   %edx
  8031db:	50                   	push   %eax
  8031dc:	6a 2f                	push   $0x2f
  8031de:	e8 a8 f9 ff ff       	call   802b8b <syscall>
  8031e3:	83 c4 18             	add    $0x18,%esp
}
  8031e6:	c9                   	leave  
  8031e7:	c3                   	ret    

008031e8 <__udivdi3>:
  8031e8:	55                   	push   %ebp
  8031e9:	57                   	push   %edi
  8031ea:	56                   	push   %esi
  8031eb:	53                   	push   %ebx
  8031ec:	83 ec 1c             	sub    $0x1c,%esp
  8031ef:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8031f3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8031f7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8031fb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8031ff:	89 ca                	mov    %ecx,%edx
  803201:	89 f8                	mov    %edi,%eax
  803203:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  803207:	85 f6                	test   %esi,%esi
  803209:	75 2d                	jne    803238 <__udivdi3+0x50>
  80320b:	39 cf                	cmp    %ecx,%edi
  80320d:	77 65                	ja     803274 <__udivdi3+0x8c>
  80320f:	89 fd                	mov    %edi,%ebp
  803211:	85 ff                	test   %edi,%edi
  803213:	75 0b                	jne    803220 <__udivdi3+0x38>
  803215:	b8 01 00 00 00       	mov    $0x1,%eax
  80321a:	31 d2                	xor    %edx,%edx
  80321c:	f7 f7                	div    %edi
  80321e:	89 c5                	mov    %eax,%ebp
  803220:	31 d2                	xor    %edx,%edx
  803222:	89 c8                	mov    %ecx,%eax
  803224:	f7 f5                	div    %ebp
  803226:	89 c1                	mov    %eax,%ecx
  803228:	89 d8                	mov    %ebx,%eax
  80322a:	f7 f5                	div    %ebp
  80322c:	89 cf                	mov    %ecx,%edi
  80322e:	89 fa                	mov    %edi,%edx
  803230:	83 c4 1c             	add    $0x1c,%esp
  803233:	5b                   	pop    %ebx
  803234:	5e                   	pop    %esi
  803235:	5f                   	pop    %edi
  803236:	5d                   	pop    %ebp
  803237:	c3                   	ret    
  803238:	39 ce                	cmp    %ecx,%esi
  80323a:	77 28                	ja     803264 <__udivdi3+0x7c>
  80323c:	0f bd fe             	bsr    %esi,%edi
  80323f:	83 f7 1f             	xor    $0x1f,%edi
  803242:	75 40                	jne    803284 <__udivdi3+0x9c>
  803244:	39 ce                	cmp    %ecx,%esi
  803246:	72 0a                	jb     803252 <__udivdi3+0x6a>
  803248:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80324c:	0f 87 9e 00 00 00    	ja     8032f0 <__udivdi3+0x108>
  803252:	b8 01 00 00 00       	mov    $0x1,%eax
  803257:	89 fa                	mov    %edi,%edx
  803259:	83 c4 1c             	add    $0x1c,%esp
  80325c:	5b                   	pop    %ebx
  80325d:	5e                   	pop    %esi
  80325e:	5f                   	pop    %edi
  80325f:	5d                   	pop    %ebp
  803260:	c3                   	ret    
  803261:	8d 76 00             	lea    0x0(%esi),%esi
  803264:	31 ff                	xor    %edi,%edi
  803266:	31 c0                	xor    %eax,%eax
  803268:	89 fa                	mov    %edi,%edx
  80326a:	83 c4 1c             	add    $0x1c,%esp
  80326d:	5b                   	pop    %ebx
  80326e:	5e                   	pop    %esi
  80326f:	5f                   	pop    %edi
  803270:	5d                   	pop    %ebp
  803271:	c3                   	ret    
  803272:	66 90                	xchg   %ax,%ax
  803274:	89 d8                	mov    %ebx,%eax
  803276:	f7 f7                	div    %edi
  803278:	31 ff                	xor    %edi,%edi
  80327a:	89 fa                	mov    %edi,%edx
  80327c:	83 c4 1c             	add    $0x1c,%esp
  80327f:	5b                   	pop    %ebx
  803280:	5e                   	pop    %esi
  803281:	5f                   	pop    %edi
  803282:	5d                   	pop    %ebp
  803283:	c3                   	ret    
  803284:	bd 20 00 00 00       	mov    $0x20,%ebp
  803289:	89 eb                	mov    %ebp,%ebx
  80328b:	29 fb                	sub    %edi,%ebx
  80328d:	89 f9                	mov    %edi,%ecx
  80328f:	d3 e6                	shl    %cl,%esi
  803291:	89 c5                	mov    %eax,%ebp
  803293:	88 d9                	mov    %bl,%cl
  803295:	d3 ed                	shr    %cl,%ebp
  803297:	89 e9                	mov    %ebp,%ecx
  803299:	09 f1                	or     %esi,%ecx
  80329b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80329f:	89 f9                	mov    %edi,%ecx
  8032a1:	d3 e0                	shl    %cl,%eax
  8032a3:	89 c5                	mov    %eax,%ebp
  8032a5:	89 d6                	mov    %edx,%esi
  8032a7:	88 d9                	mov    %bl,%cl
  8032a9:	d3 ee                	shr    %cl,%esi
  8032ab:	89 f9                	mov    %edi,%ecx
  8032ad:	d3 e2                	shl    %cl,%edx
  8032af:	8b 44 24 08          	mov    0x8(%esp),%eax
  8032b3:	88 d9                	mov    %bl,%cl
  8032b5:	d3 e8                	shr    %cl,%eax
  8032b7:	09 c2                	or     %eax,%edx
  8032b9:	89 d0                	mov    %edx,%eax
  8032bb:	89 f2                	mov    %esi,%edx
  8032bd:	f7 74 24 0c          	divl   0xc(%esp)
  8032c1:	89 d6                	mov    %edx,%esi
  8032c3:	89 c3                	mov    %eax,%ebx
  8032c5:	f7 e5                	mul    %ebp
  8032c7:	39 d6                	cmp    %edx,%esi
  8032c9:	72 19                	jb     8032e4 <__udivdi3+0xfc>
  8032cb:	74 0b                	je     8032d8 <__udivdi3+0xf0>
  8032cd:	89 d8                	mov    %ebx,%eax
  8032cf:	31 ff                	xor    %edi,%edi
  8032d1:	e9 58 ff ff ff       	jmp    80322e <__udivdi3+0x46>
  8032d6:	66 90                	xchg   %ax,%ax
  8032d8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8032dc:	89 f9                	mov    %edi,%ecx
  8032de:	d3 e2                	shl    %cl,%edx
  8032e0:	39 c2                	cmp    %eax,%edx
  8032e2:	73 e9                	jae    8032cd <__udivdi3+0xe5>
  8032e4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8032e7:	31 ff                	xor    %edi,%edi
  8032e9:	e9 40 ff ff ff       	jmp    80322e <__udivdi3+0x46>
  8032ee:	66 90                	xchg   %ax,%ax
  8032f0:	31 c0                	xor    %eax,%eax
  8032f2:	e9 37 ff ff ff       	jmp    80322e <__udivdi3+0x46>
  8032f7:	90                   	nop

008032f8 <__umoddi3>:
  8032f8:	55                   	push   %ebp
  8032f9:	57                   	push   %edi
  8032fa:	56                   	push   %esi
  8032fb:	53                   	push   %ebx
  8032fc:	83 ec 1c             	sub    $0x1c,%esp
  8032ff:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  803303:	8b 74 24 34          	mov    0x34(%esp),%esi
  803307:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80330b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80330f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  803313:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  803317:	89 f3                	mov    %esi,%ebx
  803319:	89 fa                	mov    %edi,%edx
  80331b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80331f:	89 34 24             	mov    %esi,(%esp)
  803322:	85 c0                	test   %eax,%eax
  803324:	75 1a                	jne    803340 <__umoddi3+0x48>
  803326:	39 f7                	cmp    %esi,%edi
  803328:	0f 86 a2 00 00 00    	jbe    8033d0 <__umoddi3+0xd8>
  80332e:	89 c8                	mov    %ecx,%eax
  803330:	89 f2                	mov    %esi,%edx
  803332:	f7 f7                	div    %edi
  803334:	89 d0                	mov    %edx,%eax
  803336:	31 d2                	xor    %edx,%edx
  803338:	83 c4 1c             	add    $0x1c,%esp
  80333b:	5b                   	pop    %ebx
  80333c:	5e                   	pop    %esi
  80333d:	5f                   	pop    %edi
  80333e:	5d                   	pop    %ebp
  80333f:	c3                   	ret    
  803340:	39 f0                	cmp    %esi,%eax
  803342:	0f 87 ac 00 00 00    	ja     8033f4 <__umoddi3+0xfc>
  803348:	0f bd e8             	bsr    %eax,%ebp
  80334b:	83 f5 1f             	xor    $0x1f,%ebp
  80334e:	0f 84 ac 00 00 00    	je     803400 <__umoddi3+0x108>
  803354:	bf 20 00 00 00       	mov    $0x20,%edi
  803359:	29 ef                	sub    %ebp,%edi
  80335b:	89 fe                	mov    %edi,%esi
  80335d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  803361:	89 e9                	mov    %ebp,%ecx
  803363:	d3 e0                	shl    %cl,%eax
  803365:	89 d7                	mov    %edx,%edi
  803367:	89 f1                	mov    %esi,%ecx
  803369:	d3 ef                	shr    %cl,%edi
  80336b:	09 c7                	or     %eax,%edi
  80336d:	89 e9                	mov    %ebp,%ecx
  80336f:	d3 e2                	shl    %cl,%edx
  803371:	89 14 24             	mov    %edx,(%esp)
  803374:	89 d8                	mov    %ebx,%eax
  803376:	d3 e0                	shl    %cl,%eax
  803378:	89 c2                	mov    %eax,%edx
  80337a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80337e:	d3 e0                	shl    %cl,%eax
  803380:	89 44 24 04          	mov    %eax,0x4(%esp)
  803384:	8b 44 24 08          	mov    0x8(%esp),%eax
  803388:	89 f1                	mov    %esi,%ecx
  80338a:	d3 e8                	shr    %cl,%eax
  80338c:	09 d0                	or     %edx,%eax
  80338e:	d3 eb                	shr    %cl,%ebx
  803390:	89 da                	mov    %ebx,%edx
  803392:	f7 f7                	div    %edi
  803394:	89 d3                	mov    %edx,%ebx
  803396:	f7 24 24             	mull   (%esp)
  803399:	89 c6                	mov    %eax,%esi
  80339b:	89 d1                	mov    %edx,%ecx
  80339d:	39 d3                	cmp    %edx,%ebx
  80339f:	0f 82 87 00 00 00    	jb     80342c <__umoddi3+0x134>
  8033a5:	0f 84 91 00 00 00    	je     80343c <__umoddi3+0x144>
  8033ab:	8b 54 24 04          	mov    0x4(%esp),%edx
  8033af:	29 f2                	sub    %esi,%edx
  8033b1:	19 cb                	sbb    %ecx,%ebx
  8033b3:	89 d8                	mov    %ebx,%eax
  8033b5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8033b9:	d3 e0                	shl    %cl,%eax
  8033bb:	89 e9                	mov    %ebp,%ecx
  8033bd:	d3 ea                	shr    %cl,%edx
  8033bf:	09 d0                	or     %edx,%eax
  8033c1:	89 e9                	mov    %ebp,%ecx
  8033c3:	d3 eb                	shr    %cl,%ebx
  8033c5:	89 da                	mov    %ebx,%edx
  8033c7:	83 c4 1c             	add    $0x1c,%esp
  8033ca:	5b                   	pop    %ebx
  8033cb:	5e                   	pop    %esi
  8033cc:	5f                   	pop    %edi
  8033cd:	5d                   	pop    %ebp
  8033ce:	c3                   	ret    
  8033cf:	90                   	nop
  8033d0:	89 fd                	mov    %edi,%ebp
  8033d2:	85 ff                	test   %edi,%edi
  8033d4:	75 0b                	jne    8033e1 <__umoddi3+0xe9>
  8033d6:	b8 01 00 00 00       	mov    $0x1,%eax
  8033db:	31 d2                	xor    %edx,%edx
  8033dd:	f7 f7                	div    %edi
  8033df:	89 c5                	mov    %eax,%ebp
  8033e1:	89 f0                	mov    %esi,%eax
  8033e3:	31 d2                	xor    %edx,%edx
  8033e5:	f7 f5                	div    %ebp
  8033e7:	89 c8                	mov    %ecx,%eax
  8033e9:	f7 f5                	div    %ebp
  8033eb:	89 d0                	mov    %edx,%eax
  8033ed:	e9 44 ff ff ff       	jmp    803336 <__umoddi3+0x3e>
  8033f2:	66 90                	xchg   %ax,%ax
  8033f4:	89 c8                	mov    %ecx,%eax
  8033f6:	89 f2                	mov    %esi,%edx
  8033f8:	83 c4 1c             	add    $0x1c,%esp
  8033fb:	5b                   	pop    %ebx
  8033fc:	5e                   	pop    %esi
  8033fd:	5f                   	pop    %edi
  8033fe:	5d                   	pop    %ebp
  8033ff:	c3                   	ret    
  803400:	3b 04 24             	cmp    (%esp),%eax
  803403:	72 06                	jb     80340b <__umoddi3+0x113>
  803405:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  803409:	77 0f                	ja     80341a <__umoddi3+0x122>
  80340b:	89 f2                	mov    %esi,%edx
  80340d:	29 f9                	sub    %edi,%ecx
  80340f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  803413:	89 14 24             	mov    %edx,(%esp)
  803416:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80341a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80341e:	8b 14 24             	mov    (%esp),%edx
  803421:	83 c4 1c             	add    $0x1c,%esp
  803424:	5b                   	pop    %ebx
  803425:	5e                   	pop    %esi
  803426:	5f                   	pop    %edi
  803427:	5d                   	pop    %ebp
  803428:	c3                   	ret    
  803429:	8d 76 00             	lea    0x0(%esi),%esi
  80342c:	2b 04 24             	sub    (%esp),%eax
  80342f:	19 fa                	sbb    %edi,%edx
  803431:	89 d1                	mov    %edx,%ecx
  803433:	89 c6                	mov    %eax,%esi
  803435:	e9 71 ff ff ff       	jmp    8033ab <__umoddi3+0xb3>
  80343a:	66 90                	xchg   %ax,%ax
  80343c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  803440:	72 ea                	jb     80342c <__umoddi3+0x134>
  803442:	89 d9                	mov    %ebx,%ecx
  803444:	e9 62 ff ff ff       	jmp    8033ab <__umoddi3+0xb3>
