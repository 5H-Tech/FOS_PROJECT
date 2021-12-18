
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
  800031:	e8 08 16 00 00       	call   80163e <libmain>
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
  800056:	68 00 34 80 00       	push   $0x803400
  80005b:	e8 c5 19 00 00       	call   801a25 <cprintf>
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
  80007f:	68 0f 34 80 00       	push   $0x80340f
  800084:	6a 20                	push   $0x20
  800086:	68 2b 34 80 00       	push   $0x80342b
  80008b:	e8 f3 16 00 00       	call   801783 <_panic>
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
  8000c0:	e8 d1 2b 00 00       	call   802c96 <sys_calculate_free_frames>
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
  8000f3:	e8 21 2c 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  8000f8:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000fe:	01 c0                	add    %eax,%eax
  800100:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800103:	83 ec 0c             	sub    $0xc,%esp
  800106:	50                   	push   %eax
  800107:	e8 a3 26 00 00       	call   8027af <malloc>
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
  80012f:	68 40 34 80 00       	push   $0x803440
  800134:	6a 3b                	push   $0x3b
  800136:	68 2b 34 80 00       	push   $0x80342b
  80013b:	e8 43 16 00 00       	call   801783 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800140:	e8 d4 2b 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  800145:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800148:	3d 00 02 00 00       	cmp    $0x200,%eax
  80014d:	74 14                	je     800163 <_main+0x12b>
  80014f:	83 ec 04             	sub    $0x4,%esp
  800152:	68 a8 34 80 00       	push   $0x8034a8
  800157:	6a 3c                	push   $0x3c
  800159:	68 2b 34 80 00       	push   $0x80342b
  80015e:	e8 20 16 00 00       	call   801783 <_panic>
		int freeFrames = sys_calculate_free_frames() ;
  800163:	e8 2e 2b 00 00       	call   802c96 <sys_calculate_free_frames>
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
  800198:	e8 f9 2a 00 00       	call   802c96 <sys_calculate_free_frames>
  80019d:	29 c3                	sub    %eax,%ebx
  80019f:	89 d8                	mov    %ebx,%eax
  8001a1:	83 f8 03             	cmp    $0x3,%eax
  8001a4:	74 14                	je     8001ba <_main+0x182>
  8001a6:	83 ec 04             	sub    $0x4,%esp
  8001a9:	68 d8 34 80 00       	push   $0x8034d8
  8001ae:	6a 42                	push   $0x42
  8001b0:	68 2b 34 80 00       	push   $0x80342b
  8001b5:	e8 c9 15 00 00       	call   801783 <_panic>
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
		byteArr[lastIndexOfByte] = maxByte ;
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
  80025c:	68 1c 35 80 00       	push   $0x80351c
  800261:	6a 4d                	push   $0x4d
  800263:	68 2b 34 80 00       	push   $0x80342b
  800268:	e8 16 15 00 00       	call   801783 <_panic>

		//2 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80026d:	e8 a7 2a 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  800272:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  800275:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800278:	01 c0                	add    %eax,%eax
  80027a:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80027d:	83 ec 0c             	sub    $0xc,%esp
  800280:	50                   	push   %eax
  800281:	e8 29 25 00 00       	call   8027af <malloc>
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
  8002be:	68 40 34 80 00       	push   $0x803440
  8002c3:	6a 52                	push   $0x52
  8002c5:	68 2b 34 80 00       	push   $0x80342b
  8002ca:	e8 b4 14 00 00       	call   801783 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8002cf:	e8 45 2a 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  8002d4:	2b 45 c0             	sub    -0x40(%ebp),%eax
  8002d7:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002dc:	74 14                	je     8002f2 <_main+0x2ba>
  8002de:	83 ec 04             	sub    $0x4,%esp
  8002e1:	68 a8 34 80 00       	push   $0x8034a8
  8002e6:	6a 53                	push   $0x53
  8002e8:	68 2b 34 80 00       	push   $0x80342b
  8002ed:	e8 91 14 00 00       	call   801783 <_panic>
		freeFrames = sys_calculate_free_frames() ;
  8002f2:	e8 9f 29 00 00       	call   802c96 <sys_calculate_free_frames>
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
  800330:	e8 61 29 00 00       	call   802c96 <sys_calculate_free_frames>
  800335:	29 c3                	sub    %eax,%ebx
  800337:	89 d8                	mov    %ebx,%eax
  800339:	83 f8 02             	cmp    $0x2,%eax
  80033c:	74 14                	je     800352 <_main+0x31a>
  80033e:	83 ec 04             	sub    $0x4,%esp
  800341:	68 d8 34 80 00       	push   $0x8034d8
  800346:	6a 59                	push   $0x59
  800348:	68 2b 34 80 00       	push   $0x80342b
  80034d:	e8 31 14 00 00       	call   801783 <_panic>
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
  8003f8:	68 1c 35 80 00       	push   $0x80351c
  8003fd:	6a 62                	push   $0x62
  8003ff:	68 2b 34 80 00       	push   $0x80342b
  800404:	e8 7a 13 00 00       	call   801783 <_panic>

		//3 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800409:	e8 0b 29 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  80040e:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[2] = malloc(3*kilo);
  800411:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800414:	89 c2                	mov    %eax,%edx
  800416:	01 d2                	add    %edx,%edx
  800418:	01 d0                	add    %edx,%eax
  80041a:	83 ec 0c             	sub    $0xc,%esp
  80041d:	50                   	push   %eax
  80041e:	e8 8c 23 00 00       	call   8027af <malloc>
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
  80045d:	68 40 34 80 00       	push   $0x803440
  800462:	6a 67                	push   $0x67
  800464:	68 2b 34 80 00       	push   $0x80342b
  800469:	e8 15 13 00 00       	call   801783 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  80046e:	e8 a6 28 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  800473:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800476:	83 f8 01             	cmp    $0x1,%eax
  800479:	74 14                	je     80048f <_main+0x457>
  80047b:	83 ec 04             	sub    $0x4,%esp
  80047e:	68 a8 34 80 00       	push   $0x8034a8
  800483:	6a 68                	push   $0x68
  800485:	68 2b 34 80 00       	push   $0x80342b
  80048a:	e8 f4 12 00 00       	call   801783 <_panic>
		freeFrames = sys_calculate_free_frames() ;
  80048f:	e8 02 28 00 00       	call   802c96 <sys_calculate_free_frames>
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
  8004cf:	e8 c2 27 00 00       	call   802c96 <sys_calculate_free_frames>
  8004d4:	29 c3                	sub    %eax,%ebx
  8004d6:	89 d8                	mov    %ebx,%eax
  8004d8:	83 f8 02             	cmp    $0x2,%eax
  8004db:	74 14                	je     8004f1 <_main+0x4b9>
  8004dd:	83 ec 04             	sub    $0x4,%esp
  8004e0:	68 d8 34 80 00       	push   $0x8034d8
  8004e5:	6a 6e                	push   $0x6e
  8004e7:	68 2b 34 80 00       	push   $0x80342b
  8004ec:	e8 92 12 00 00       	call   801783 <_panic>
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
  8005af:	68 1c 35 80 00       	push   $0x80351c
  8005b4:	6a 77                	push   $0x77
  8005b6:	68 2b 34 80 00       	push   $0x80342b
  8005bb:	e8 c3 11 00 00       	call   801783 <_panic>

		//3 KB
		freeFrames = sys_calculate_free_frames() ;
  8005c0:	e8 d1 26 00 00       	call   802c96 <sys_calculate_free_frames>
  8005c5:	89 45 bc             	mov    %eax,-0x44(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8005c8:	e8 4c 27 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  8005cd:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[3] = malloc(3*kilo);
  8005d0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005d3:	89 c2                	mov    %eax,%edx
  8005d5:	01 d2                	add    %edx,%edx
  8005d7:	01 d0                	add    %edx,%eax
  8005d9:	83 ec 0c             	sub    $0xc,%esp
  8005dc:	50                   	push   %eax
  8005dd:	e8 cd 21 00 00       	call   8027af <malloc>
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
  80062b:	76 14                	jbe    800641 <_main+0x609>
  80062d:	83 ec 04             	sub    $0x4,%esp
  800630:	68 40 34 80 00       	push   $0x803440
  800635:	6a 7d                	push   $0x7d
  800637:	68 2b 34 80 00       	push   $0x80342b
  80063c:	e8 42 11 00 00       	call   801783 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800641:	e8 d3 26 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  800646:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800649:	83 f8 01             	cmp    $0x1,%eax
  80064c:	74 14                	je     800662 <_main+0x62a>
  80064e:	83 ec 04             	sub    $0x4,%esp
  800651:	68 a8 34 80 00       	push   $0x8034a8
  800656:	6a 7e                	push   $0x7e
  800658:	68 2b 34 80 00       	push   $0x80342b
  80065d:	e8 21 11 00 00       	call   801783 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800662:	e8 b2 26 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  800667:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  80066a:	8b 55 dc             	mov    -0x24(%ebp),%edx
  80066d:	89 d0                	mov    %edx,%eax
  80066f:	01 c0                	add    %eax,%eax
  800671:	01 d0                	add    %edx,%eax
  800673:	01 c0                	add    %eax,%eax
  800675:	01 d0                	add    %edx,%eax
  800677:	83 ec 0c             	sub    $0xc,%esp
  80067a:	50                   	push   %eax
  80067b:	e8 2f 21 00 00       	call   8027af <malloc>
  800680:	83 c4 10             	add    $0x10,%esp
  800683:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo)|| (uint32) ptr_allocations[4] > (USER_HEAP_START+ 4*Mega + 8*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800689:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  80068f:	89 c2                	mov    %eax,%edx
  800691:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800694:	c1 e0 02             	shl    $0x2,%eax
  800697:	89 c1                	mov    %eax,%ecx
  800699:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80069c:	c1 e0 03             	shl    $0x3,%eax
  80069f:	01 c8                	add    %ecx,%eax
  8006a1:	05 00 00 00 80       	add    $0x80000000,%eax
  8006a6:	39 c2                	cmp    %eax,%edx
  8006a8:	72 21                	jb     8006cb <_main+0x693>
  8006aa:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  8006b0:	89 c2                	mov    %eax,%edx
  8006b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006b5:	c1 e0 02             	shl    $0x2,%eax
  8006b8:	89 c1                	mov    %eax,%ecx
  8006ba:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006bd:	c1 e0 03             	shl    $0x3,%eax
  8006c0:	01 c8                	add    %ecx,%eax
  8006c2:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8006c7:	39 c2                	cmp    %eax,%edx
  8006c9:	76 17                	jbe    8006e2 <_main+0x6aa>
  8006cb:	83 ec 04             	sub    $0x4,%esp
  8006ce:	68 40 34 80 00       	push   $0x803440
  8006d3:	68 84 00 00 00       	push   $0x84
  8006d8:	68 2b 34 80 00       	push   $0x80342b
  8006dd:	e8 a1 10 00 00       	call   801783 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  8006e2:	e8 32 26 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  8006e7:	2b 45 c0             	sub    -0x40(%ebp),%eax
  8006ea:	83 f8 02             	cmp    $0x2,%eax
  8006ed:	74 17                	je     800706 <_main+0x6ce>
  8006ef:	83 ec 04             	sub    $0x4,%esp
  8006f2:	68 a8 34 80 00       	push   $0x8034a8
  8006f7:	68 85 00 00 00       	push   $0x85
  8006fc:	68 2b 34 80 00       	push   $0x80342b
  800701:	e8 7d 10 00 00       	call   801783 <_panic>
		freeFrames = sys_calculate_free_frames() ;
  800706:	e8 8b 25 00 00       	call   802c96 <sys_calculate_free_frames>
  80070b:	89 45 bc             	mov    %eax,-0x44(%ebp)
		structArr = (struct MyStruct *) ptr_allocations[4];
  80070e:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  800714:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
  80071a:	8b 55 dc             	mov    -0x24(%ebp),%edx
  80071d:	89 d0                	mov    %edx,%eax
  80071f:	01 c0                	add    %eax,%eax
  800721:	01 d0                	add    %edx,%eax
  800723:	01 c0                	add    %eax,%eax
  800725:	01 d0                	add    %edx,%eax
  800727:	c1 e8 03             	shr    $0x3,%eax
  80072a:	48                   	dec    %eax
  80072b:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
  800731:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800737:	8a 55 db             	mov    -0x25(%ebp),%dl
  80073a:	88 10                	mov    %dl,(%eax)
  80073c:	8b 95 70 ff ff ff    	mov    -0x90(%ebp),%edx
  800742:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800745:	66 89 42 02          	mov    %ax,0x2(%edx)
  800749:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80074f:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800752:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
  800755:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80075b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800762:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800768:	01 c2                	add    %eax,%edx
  80076a:	8a 45 da             	mov    -0x26(%ebp),%al
  80076d:	88 02                	mov    %al,(%edx)
  80076f:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800775:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80077c:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800782:	01 c2                	add    %eax,%edx
  800784:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  800788:	66 89 42 02          	mov    %ax,0x2(%edx)
  80078c:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800792:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800799:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80079f:	01 c2                	add    %eax,%edx
  8007a1:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8007a4:	89 42 04             	mov    %eax,0x4(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8007a7:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  8007aa:	e8 e7 24 00 00       	call   802c96 <sys_calculate_free_frames>
  8007af:	29 c3                	sub    %eax,%ebx
  8007b1:	89 d8                	mov    %ebx,%eax
  8007b3:	83 f8 02             	cmp    $0x2,%eax
  8007b6:	74 17                	je     8007cf <_main+0x797>
  8007b8:	83 ec 04             	sub    $0x4,%esp
  8007bb:	68 d8 34 80 00       	push   $0x8034d8
  8007c0:	68 8b 00 00 00       	push   $0x8b
  8007c5:	68 2b 34 80 00       	push   $0x80342b
  8007ca:	e8 b4 0f 00 00       	call   801783 <_panic>
		found = 0;
  8007cf:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8007d6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8007dd:	e9 9e 00 00 00       	jmp    800880 <_main+0x848>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
  8007e2:	a1 20 40 80 00       	mov    0x804020,%eax
  8007e7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007ed:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8007f0:	c1 e2 04             	shl    $0x4,%edx
  8007f3:	01 d0                	add    %edx,%eax
  8007f5:	8b 00                	mov    (%eax),%eax
  8007f7:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  8007fd:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800803:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800808:	89 c2                	mov    %eax,%edx
  80080a:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800810:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  800816:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  80081c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800821:	39 c2                	cmp    %eax,%edx
  800823:	75 03                	jne    800828 <_main+0x7f0>
				found++;
  800825:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
  800828:	a1 20 40 80 00       	mov    0x804020,%eax
  80082d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800833:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800836:	c1 e2 04             	shl    $0x4,%edx
  800839:	01 d0                	add    %edx,%eax
  80083b:	8b 00                	mov    (%eax),%eax
  80083d:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  800843:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800849:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80084e:	89 c2                	mov    %eax,%edx
  800850:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800856:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80085d:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800863:	01 c8                	add    %ecx,%eax
  800865:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  80086b:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  800871:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800876:	39 c2                	cmp    %eax,%edx
  800878:	75 03                	jne    80087d <_main+0x845>
				found++;
  80087a:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80087d:	ff 45 ec             	incl   -0x14(%ebp)
  800880:	a1 20 40 80 00       	mov    0x804020,%eax
  800885:	8b 50 74             	mov    0x74(%eax),%edx
  800888:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80088b:	39 c2                	cmp    %eax,%edx
  80088d:	0f 87 4f ff ff ff    	ja     8007e2 <_main+0x7aa>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800893:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800897:	74 17                	je     8008b0 <_main+0x878>
  800899:	83 ec 04             	sub    $0x4,%esp
  80089c:	68 1c 35 80 00       	push   $0x80351c
  8008a1:	68 94 00 00 00       	push   $0x94
  8008a6:	68 2b 34 80 00       	push   $0x80342b
  8008ab:	e8 d3 0e 00 00       	call   801783 <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8008b0:	e8 e1 23 00 00       	call   802c96 <sys_calculate_free_frames>
  8008b5:	89 45 bc             	mov    %eax,-0x44(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8008b8:	e8 5c 24 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  8008bd:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8008c0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008c3:	89 c2                	mov    %eax,%edx
  8008c5:	01 d2                	add    %edx,%edx
  8008c7:	01 d0                	add    %edx,%eax
  8008c9:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8008cc:	83 ec 0c             	sub    $0xc,%esp
  8008cf:	50                   	push   %eax
  8008d0:	e8 da 1e 00 00       	call   8027af <malloc>
  8008d5:	83 c4 10             	add    $0x10,%esp
  8008d8:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START+ 4*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8008de:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  8008e4:	89 c2                	mov    %eax,%edx
  8008e6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008e9:	c1 e0 02             	shl    $0x2,%eax
  8008ec:	89 c1                	mov    %eax,%ecx
  8008ee:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008f1:	c1 e0 04             	shl    $0x4,%eax
  8008f4:	01 c8                	add    %ecx,%eax
  8008f6:	05 00 00 00 80       	add    $0x80000000,%eax
  8008fb:	39 c2                	cmp    %eax,%edx
  8008fd:	72 21                	jb     800920 <_main+0x8e8>
  8008ff:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  800905:	89 c2                	mov    %eax,%edx
  800907:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80090a:	c1 e0 02             	shl    $0x2,%eax
  80090d:	89 c1                	mov    %eax,%ecx
  80090f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800912:	c1 e0 04             	shl    $0x4,%eax
  800915:	01 c8                	add    %ecx,%eax
  800917:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80091c:	39 c2                	cmp    %eax,%edx
  80091e:	76 17                	jbe    800937 <_main+0x8ff>
  800920:	83 ec 04             	sub    $0x4,%esp
  800923:	68 40 34 80 00       	push   $0x803440
  800928:	68 9a 00 00 00       	push   $0x9a
  80092d:	68 2b 34 80 00       	push   $0x80342b
  800932:	e8 4c 0e 00 00       	call   801783 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800937:	e8 dd 23 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  80093c:	2b 45 c0             	sub    -0x40(%ebp),%eax
  80093f:	89 c2                	mov    %eax,%edx
  800941:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800944:	89 c1                	mov    %eax,%ecx
  800946:	01 c9                	add    %ecx,%ecx
  800948:	01 c8                	add    %ecx,%eax
  80094a:	85 c0                	test   %eax,%eax
  80094c:	79 05                	jns    800953 <_main+0x91b>
  80094e:	05 ff 0f 00 00       	add    $0xfff,%eax
  800953:	c1 f8 0c             	sar    $0xc,%eax
  800956:	39 c2                	cmp    %eax,%edx
  800958:	74 17                	je     800971 <_main+0x939>
  80095a:	83 ec 04             	sub    $0x4,%esp
  80095d:	68 a8 34 80 00       	push   $0x8034a8
  800962:	68 9b 00 00 00       	push   $0x9b
  800967:	68 2b 34 80 00       	push   $0x80342b
  80096c:	e8 12 0e 00 00       	call   801783 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
		byteArr3 = (char*)ptr_allocations[5];
  800971:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  800977:	89 45 f0             	mov    %eax,-0x10(%ebp)
		for(int i = 0; i < toAccess; i++)
  80097a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800981:	eb 10                	jmp    800993 <_main+0x95b>
		{
			*byteArr3 = '@';
  800983:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800986:	c6 00 40             	movb   $0x40,(%eax)
			byteArr3 += PAGE_SIZE;
  800989:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START+ 4*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
		byteArr3 = (char*)ptr_allocations[5];
		for(int i = 0; i < toAccess; i++)
  800990:	ff 45 e4             	incl   -0x1c(%ebp)
  800993:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800996:	3b 45 c4             	cmp    -0x3c(%ebp),%eax
  800999:	7c e8                	jl     800983 <_main+0x94b>
		{
			*byteArr3 = '@';
			byteArr3 += PAGE_SIZE;
		}
		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80099b:	e8 79 23 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  8009a0:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[6] = malloc(6*Mega-kilo);
  8009a3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009a6:	89 d0                	mov    %edx,%eax
  8009a8:	01 c0                	add    %eax,%eax
  8009aa:	01 d0                	add    %edx,%eax
  8009ac:	01 c0                	add    %eax,%eax
  8009ae:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8009b1:	83 ec 0c             	sub    $0xc,%esp
  8009b4:	50                   	push   %eax
  8009b5:	e8 f5 1d 00 00       	call   8027af <malloc>
  8009ba:	83 c4 10             	add    $0x10,%esp
  8009bd:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START+ 7*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8009c3:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  8009c9:	89 c1                	mov    %eax,%ecx
  8009cb:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009ce:	89 d0                	mov    %edx,%eax
  8009d0:	01 c0                	add    %eax,%eax
  8009d2:	01 d0                	add    %edx,%eax
  8009d4:	01 c0                	add    %eax,%eax
  8009d6:	01 d0                	add    %edx,%eax
  8009d8:	89 c2                	mov    %eax,%edx
  8009da:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009dd:	c1 e0 04             	shl    $0x4,%eax
  8009e0:	01 d0                	add    %edx,%eax
  8009e2:	05 00 00 00 80       	add    $0x80000000,%eax
  8009e7:	39 c1                	cmp    %eax,%ecx
  8009e9:	72 28                	jb     800a13 <_main+0x9db>
  8009eb:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  8009f1:	89 c1                	mov    %eax,%ecx
  8009f3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009f6:	89 d0                	mov    %edx,%eax
  8009f8:	01 c0                	add    %eax,%eax
  8009fa:	01 d0                	add    %edx,%eax
  8009fc:	01 c0                	add    %eax,%eax
  8009fe:	01 d0                	add    %edx,%eax
  800a00:	89 c2                	mov    %eax,%edx
  800a02:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a05:	c1 e0 04             	shl    $0x4,%eax
  800a08:	01 d0                	add    %edx,%eax
  800a0a:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800a0f:	39 c1                	cmp    %eax,%ecx
  800a11:	76 17                	jbe    800a2a <_main+0x9f2>
  800a13:	83 ec 04             	sub    $0x4,%esp
  800a16:	68 40 34 80 00       	push   $0x803440
  800a1b:	68 a6 00 00 00       	push   $0xa6
  800a20:	68 2b 34 80 00       	push   $0x80342b
  800a25:	e8 59 0d 00 00       	call   801783 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800a2a:	e8 ea 22 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  800a2f:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800a32:	89 c1                	mov    %eax,%ecx
  800a34:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a37:	89 d0                	mov    %edx,%eax
  800a39:	01 c0                	add    %eax,%eax
  800a3b:	01 d0                	add    %edx,%eax
  800a3d:	01 c0                	add    %eax,%eax
  800a3f:	85 c0                	test   %eax,%eax
  800a41:	79 05                	jns    800a48 <_main+0xa10>
  800a43:	05 ff 0f 00 00       	add    $0xfff,%eax
  800a48:	c1 f8 0c             	sar    $0xc,%eax
  800a4b:	39 c1                	cmp    %eax,%ecx
  800a4d:	74 17                	je     800a66 <_main+0xa2e>
  800a4f:	83 ec 04             	sub    $0x4,%esp
  800a52:	68 a8 34 80 00       	push   $0x8034a8
  800a57:	68 a7 00 00 00       	push   $0xa7
  800a5c:	68 2b 34 80 00       	push   $0x80342b
  800a61:	e8 1d 0d 00 00       	call   801783 <_panic>
		freeFrames = sys_calculate_free_frames() ;
  800a66:	e8 2b 22 00 00       	call   802c96 <sys_calculate_free_frames>
  800a6b:	89 45 bc             	mov    %eax,-0x44(%ebp)
		lastIndexOfByte2 = (6*Mega-kilo)/sizeof(char) - 1;
  800a6e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a71:	89 d0                	mov    %edx,%eax
  800a73:	01 c0                	add    %eax,%eax
  800a75:	01 d0                	add    %edx,%eax
  800a77:	01 c0                	add    %eax,%eax
  800a79:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800a7c:	48                   	dec    %eax
  800a7d:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
		byteArr2 = (char *) ptr_allocations[6];
  800a83:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  800a89:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
		byteArr2[0] = minByte ;
  800a8f:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800a95:	8a 55 db             	mov    -0x25(%ebp),%dl
  800a98:	88 10                	mov    %dl,(%eax)
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
  800a9a:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800aa0:	89 c2                	mov    %eax,%edx
  800aa2:	c1 ea 1f             	shr    $0x1f,%edx
  800aa5:	01 d0                	add    %edx,%eax
  800aa7:	d1 f8                	sar    %eax
  800aa9:	89 c2                	mov    %eax,%edx
  800aab:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800ab1:	01 c2                	add    %eax,%edx
  800ab3:	8a 45 da             	mov    -0x26(%ebp),%al
  800ab6:	88 c1                	mov    %al,%cl
  800ab8:	c0 e9 07             	shr    $0x7,%cl
  800abb:	01 c8                	add    %ecx,%eax
  800abd:	d0 f8                	sar    %al
  800abf:	88 02                	mov    %al,(%edx)
		byteArr2[lastIndexOfByte2] = maxByte ;
  800ac1:	8b 95 58 ff ff ff    	mov    -0xa8(%ebp),%edx
  800ac7:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800acd:	01 c2                	add    %eax,%edx
  800acf:	8a 45 da             	mov    -0x26(%ebp),%al
  800ad2:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800ad4:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  800ad7:	e8 ba 21 00 00       	call   802c96 <sys_calculate_free_frames>
  800adc:	29 c3                	sub    %eax,%ebx
  800ade:	89 d8                	mov    %ebx,%eax
  800ae0:	83 f8 05             	cmp    $0x5,%eax
  800ae3:	74 17                	je     800afc <_main+0xac4>
  800ae5:	83 ec 04             	sub    $0x4,%esp
  800ae8:	68 d8 34 80 00       	push   $0x8034d8
  800aed:	68 ae 00 00 00       	push   $0xae
  800af2:	68 2b 34 80 00       	push   $0x80342b
  800af7:	e8 87 0c 00 00       	call   801783 <_panic>
		found = 0;
  800afc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800b03:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800b0a:	e9 f0 00 00 00       	jmp    800bff <_main+0xbc7>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  800b0f:	a1 20 40 80 00       	mov    0x804020,%eax
  800b14:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b1a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b1d:	c1 e2 04             	shl    $0x4,%edx
  800b20:	01 d0                	add    %edx,%eax
  800b22:	8b 00                	mov    (%eax),%eax
  800b24:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  800b2a:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800b30:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b35:	89 c2                	mov    %eax,%edx
  800b37:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800b3d:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  800b43:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800b49:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b4e:	39 c2                	cmp    %eax,%edx
  800b50:	75 03                	jne    800b55 <_main+0xb1d>
				found++;
  800b52:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  800b55:	a1 20 40 80 00       	mov    0x804020,%eax
  800b5a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b60:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b63:	c1 e2 04             	shl    $0x4,%edx
  800b66:	01 d0                	add    %edx,%eax
  800b68:	8b 00                	mov    (%eax),%eax
  800b6a:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
  800b70:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800b76:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b7b:	89 c2                	mov    %eax,%edx
  800b7d:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800b83:	89 c1                	mov    %eax,%ecx
  800b85:	c1 e9 1f             	shr    $0x1f,%ecx
  800b88:	01 c8                	add    %ecx,%eax
  800b8a:	d1 f8                	sar    %eax
  800b8c:	89 c1                	mov    %eax,%ecx
  800b8e:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800b94:	01 c8                	add    %ecx,%eax
  800b96:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  800b9c:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800ba2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ba7:	39 c2                	cmp    %eax,%edx
  800ba9:	75 03                	jne    800bae <_main+0xb76>
				found++;
  800bab:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  800bae:	a1 20 40 80 00       	mov    0x804020,%eax
  800bb3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800bb9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800bbc:	c1 e2 04             	shl    $0x4,%edx
  800bbf:	01 d0                	add    %edx,%eax
  800bc1:	8b 00                	mov    (%eax),%eax
  800bc3:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
  800bc9:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800bcf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bd4:	89 c1                	mov    %eax,%ecx
  800bd6:	8b 95 58 ff ff ff    	mov    -0xa8(%ebp),%edx
  800bdc:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800be2:	01 d0                	add    %edx,%eax
  800be4:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)
  800bea:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800bf0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bf5:	39 c1                	cmp    %eax,%ecx
  800bf7:	75 03                	jne    800bfc <_main+0xbc4>
				found++;
  800bf9:	ff 45 e8             	incl   -0x18(%ebp)
		byteArr2[0] = minByte ;
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
		byteArr2[lastIndexOfByte2] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800bfc:	ff 45 ec             	incl   -0x14(%ebp)
  800bff:	a1 20 40 80 00       	mov    0x804020,%eax
  800c04:	8b 50 74             	mov    0x74(%eax),%edx
  800c07:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c0a:	39 c2                	cmp    %eax,%edx
  800c0c:	0f 87 fd fe ff ff    	ja     800b0f <_main+0xad7>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				found++;
		}
		if (found != 3) panic("malloc: page is not added to WS");
  800c12:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  800c16:	74 17                	je     800c2f <_main+0xbf7>
  800c18:	83 ec 04             	sub    $0x4,%esp
  800c1b:	68 1c 35 80 00       	push   $0x80351c
  800c20:	68 b9 00 00 00       	push   $0xb9
  800c25:	68 2b 34 80 00       	push   $0x80342b
  800c2a:	e8 54 0b 00 00       	call   801783 <_panic>

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800c2f:	e8 e5 20 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  800c34:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[7] = malloc(14*kilo);
  800c37:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800c3a:	89 d0                	mov    %edx,%eax
  800c3c:	01 c0                	add    %eax,%eax
  800c3e:	01 d0                	add    %edx,%eax
  800c40:	01 c0                	add    %eax,%eax
  800c42:	01 d0                	add    %edx,%eax
  800c44:	01 c0                	add    %eax,%eax
  800c46:	83 ec 0c             	sub    $0xc,%esp
  800c49:	50                   	push   %eax
  800c4a:	e8 60 1b 00 00       	call   8027af <malloc>
  800c4f:	83 c4 10             	add    $0x10,%esp
  800c52:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
		if ((uint32) ptr_allocations[7] < (USER_HEAP_START + 13*Mega + 16*kilo)|| (uint32) ptr_allocations[7] > (USER_HEAP_START+ 13*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800c58:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800c5e:	89 c1                	mov    %eax,%ecx
  800c60:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c63:	89 d0                	mov    %edx,%eax
  800c65:	01 c0                	add    %eax,%eax
  800c67:	01 d0                	add    %edx,%eax
  800c69:	c1 e0 02             	shl    $0x2,%eax
  800c6c:	01 d0                	add    %edx,%eax
  800c6e:	89 c2                	mov    %eax,%edx
  800c70:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800c73:	c1 e0 04             	shl    $0x4,%eax
  800c76:	01 d0                	add    %edx,%eax
  800c78:	05 00 00 00 80       	add    $0x80000000,%eax
  800c7d:	39 c1                	cmp    %eax,%ecx
  800c7f:	72 29                	jb     800caa <_main+0xc72>
  800c81:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800c87:	89 c1                	mov    %eax,%ecx
  800c89:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c8c:	89 d0                	mov    %edx,%eax
  800c8e:	01 c0                	add    %eax,%eax
  800c90:	01 d0                	add    %edx,%eax
  800c92:	c1 e0 02             	shl    $0x2,%eax
  800c95:	01 d0                	add    %edx,%eax
  800c97:	89 c2                	mov    %eax,%edx
  800c99:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800c9c:	c1 e0 04             	shl    $0x4,%eax
  800c9f:	01 d0                	add    %edx,%eax
  800ca1:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800ca6:	39 c1                	cmp    %eax,%ecx
  800ca8:	76 17                	jbe    800cc1 <_main+0xc89>
  800caa:	83 ec 04             	sub    $0x4,%esp
  800cad:	68 40 34 80 00       	push   $0x803440
  800cb2:	68 be 00 00 00       	push   $0xbe
  800cb7:	68 2b 34 80 00       	push   $0x80342b
  800cbc:	e8 c2 0a 00 00       	call   801783 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4) panic("Extra or less pages are allocated in PageFile");
  800cc1:	e8 53 20 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  800cc6:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800cc9:	83 f8 04             	cmp    $0x4,%eax
  800ccc:	74 17                	je     800ce5 <_main+0xcad>
  800cce:	83 ec 04             	sub    $0x4,%esp
  800cd1:	68 a8 34 80 00       	push   $0x8034a8
  800cd6:	68 bf 00 00 00       	push   $0xbf
  800cdb:	68 2b 34 80 00       	push   $0x80342b
  800ce0:	e8 9e 0a 00 00       	call   801783 <_panic>
		freeFrames = sys_calculate_free_frames() ;
  800ce5:	e8 ac 1f 00 00       	call   802c96 <sys_calculate_free_frames>
  800cea:	89 45 bc             	mov    %eax,-0x44(%ebp)
		shortArr2 = (short *) ptr_allocations[7];
  800ced:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800cf3:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
  800cf9:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800cfc:	89 d0                	mov    %edx,%eax
  800cfe:	01 c0                	add    %eax,%eax
  800d00:	01 d0                	add    %edx,%eax
  800d02:	01 c0                	add    %eax,%eax
  800d04:	01 d0                	add    %edx,%eax
  800d06:	01 c0                	add    %eax,%eax
  800d08:	d1 e8                	shr    %eax
  800d0a:	48                   	dec    %eax
  800d0b:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
		shortArr2[0] = minShort;
  800d11:	8b 95 38 ff ff ff    	mov    -0xc8(%ebp),%edx
  800d17:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800d1a:	66 89 02             	mov    %ax,(%edx)
		shortArr2[lastIndexOfShort2] = maxShort;
  800d1d:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800d23:	01 c0                	add    %eax,%eax
  800d25:	89 c2                	mov    %eax,%edx
  800d27:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800d2d:	01 c2                	add    %eax,%edx
  800d2f:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  800d33:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800d36:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  800d39:	e8 58 1f 00 00       	call   802c96 <sys_calculate_free_frames>
  800d3e:	29 c3                	sub    %eax,%ebx
  800d40:	89 d8                	mov    %ebx,%eax
  800d42:	83 f8 02             	cmp    $0x2,%eax
  800d45:	74 17                	je     800d5e <_main+0xd26>
  800d47:	83 ec 04             	sub    $0x4,%esp
  800d4a:	68 d8 34 80 00       	push   $0x8034d8
  800d4f:	68 c5 00 00 00       	push   $0xc5
  800d54:	68 2b 34 80 00       	push   $0x80342b
  800d59:	e8 25 0a 00 00       	call   801783 <_panic>
		found = 0;
  800d5e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800d65:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800d6c:	e9 9b 00 00 00       	jmp    800e0c <_main+0xdd4>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
  800d71:	a1 20 40 80 00       	mov    0x804020,%eax
  800d76:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800d7c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800d7f:	c1 e2 04             	shl    $0x4,%edx
  800d82:	01 d0                	add    %edx,%eax
  800d84:	8b 00                	mov    (%eax),%eax
  800d86:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
  800d8c:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  800d92:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d97:	89 c2                	mov    %eax,%edx
  800d99:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800d9f:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
  800da5:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  800dab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800db0:	39 c2                	cmp    %eax,%edx
  800db2:	75 03                	jne    800db7 <_main+0xd7f>
				found++;
  800db4:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
  800db7:	a1 20 40 80 00       	mov    0x804020,%eax
  800dbc:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800dc2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dc5:	c1 e2 04             	shl    $0x4,%edx
  800dc8:	01 d0                	add    %edx,%eax
  800dca:	8b 00                	mov    (%eax),%eax
  800dcc:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
  800dd2:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
  800dd8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ddd:	89 c2                	mov    %eax,%edx
  800ddf:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800de5:	01 c0                	add    %eax,%eax
  800de7:	89 c1                	mov    %eax,%ecx
  800de9:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800def:	01 c8                	add    %ecx,%eax
  800df1:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
  800df7:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  800dfd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e02:	39 c2                	cmp    %eax,%edx
  800e04:	75 03                	jne    800e09 <_main+0xdd1>
				found++;
  800e06:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
		shortArr2[0] = minShort;
		shortArr2[lastIndexOfShort2] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800e09:	ff 45 ec             	incl   -0x14(%ebp)
  800e0c:	a1 20 40 80 00       	mov    0x804020,%eax
  800e11:	8b 50 74             	mov    0x74(%eax),%edx
  800e14:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e17:	39 c2                	cmp    %eax,%edx
  800e19:	0f 87 52 ff ff ff    	ja     800d71 <_main+0xd39>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800e1f:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800e23:	74 17                	je     800e3c <_main+0xe04>
  800e25:	83 ec 04             	sub    $0x4,%esp
  800e28:	68 1c 35 80 00       	push   $0x80351c
  800e2d:	68 ce 00 00 00       	push   $0xce
  800e32:	68 2b 34 80 00       	push   $0x80342b
  800e37:	e8 47 09 00 00       	call   801783 <_panic>
	}

	{
		uint32 tmp_addresses[3] = {0};
  800e3c:	8d 95 bc fe ff ff    	lea    -0x144(%ebp),%edx
  800e42:	b9 03 00 00 00       	mov    $0x3,%ecx
  800e47:	b8 00 00 00 00       	mov    $0x0,%eax
  800e4c:	89 d7                	mov    %edx,%edi
  800e4e:	f3 ab                	rep stos %eax,%es:(%edi)

		//Free 6 MB
		int freeFrames = sys_calculate_free_frames() ;
  800e50:	e8 41 1e 00 00       	call   802c96 <sys_calculate_free_frames>
  800e55:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800e5b:	e8 b9 1e 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  800e60:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[6]);
  800e66:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  800e6c:	83 ec 0c             	sub    $0xc,%esp
  800e6f:	50                   	push   %eax
  800e70:	e8 4a 1b 00 00       	call   8029bf <free>
  800e75:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 6*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
  800e78:	e8 9c 1e 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  800e7d:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  800e83:	89 d1                	mov    %edx,%ecx
  800e85:	29 c1                	sub    %eax,%ecx
  800e87:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e8a:	89 d0                	mov    %edx,%eax
  800e8c:	01 c0                	add    %eax,%eax
  800e8e:	01 d0                	add    %edx,%eax
  800e90:	01 c0                	add    %eax,%eax
  800e92:	85 c0                	test   %eax,%eax
  800e94:	79 05                	jns    800e9b <_main+0xe63>
  800e96:	05 ff 0f 00 00       	add    $0xfff,%eax
  800e9b:	c1 f8 0c             	sar    $0xc,%eax
  800e9e:	39 c1                	cmp    %eax,%ecx
  800ea0:	74 17                	je     800eb9 <_main+0xe81>
  800ea2:	83 ec 04             	sub    $0x4,%esp
  800ea5:	68 3c 35 80 00       	push   $0x80353c
  800eaa:	68 d8 00 00 00       	push   $0xd8
  800eaf:	68 2b 34 80 00       	push   $0x80342b
  800eb4:	e8 ca 08 00 00       	call   801783 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800eb9:	e8 d8 1d 00 00       	call   802c96 <sys_calculate_free_frames>
  800ebe:	89 c2                	mov    %eax,%edx
  800ec0:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  800ec6:	29 c2                	sub    %eax,%edx
  800ec8:	89 d0                	mov    %edx,%eax
  800eca:	83 f8 04             	cmp    $0x4,%eax
  800ecd:	74 17                	je     800ee6 <_main+0xeae>
  800ecf:	83 ec 04             	sub    $0x4,%esp
  800ed2:	68 78 35 80 00       	push   $0x803578
  800ed7:	68 d9 00 00 00       	push   $0xd9
  800edc:	68 2b 34 80 00       	push   $0x80342b
  800ee1:	e8 9d 08 00 00       	call   801783 <_panic>
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}
		tmp_addresses[0] = (uint32)(&(byteArr2[0]));
  800ee6:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800eec:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(byteArr2[lastIndexOfByte2/2]));
  800ef2:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800ef8:	89 c2                	mov    %eax,%edx
  800efa:	c1 ea 1f             	shr    $0x1f,%edx
  800efd:	01 d0                	add    %edx,%eax
  800eff:	d1 f8                	sar    %eax
  800f01:	89 c2                	mov    %eax,%edx
  800f03:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800f09:	01 d0                	add    %edx,%eax
  800f0b:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		tmp_addresses[2] = (uint32)(&(byteArr2[lastIndexOfByte2]));
  800f11:	8b 95 58 ff ff ff    	mov    -0xa8(%ebp),%edx
  800f17:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800f1d:	01 d0                	add    %edx,%eax
  800f1f:	89 85 c4 fe ff ff    	mov    %eax,-0x13c(%ebp)
		int check = sys_check_LRU_lists_free(tmp_addresses, 3);
  800f25:	83 ec 08             	sub    $0x8,%esp
  800f28:	6a 03                	push   $0x3
  800f2a:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  800f30:	50                   	push   %eax
  800f31:	e8 34 22 00 00       	call   80316a <sys_check_LRU_lists_free>
  800f36:	83 c4 10             	add    $0x10,%esp
  800f39:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  800f3f:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  800f46:	74 17                	je     800f5f <_main+0xf27>
		{
				panic("free: page is not removed from LRU lists");
  800f48:	83 ec 04             	sub    $0x4,%esp
  800f4b:	68 c4 35 80 00       	push   $0x8035c4
  800f50:	68 e9 00 00 00       	push   $0xe9
  800f55:	68 2b 34 80 00       	push   $0x80342b
  800f5a:	e8 24 08 00 00       	call   801783 <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 800 && LIST_SIZE(&myEnv->SecondList) != 1)
  800f5f:	a1 20 40 80 00       	mov    0x804020,%eax
  800f64:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  800f6a:	3d 20 03 00 00       	cmp    $0x320,%eax
  800f6f:	74 27                	je     800f98 <_main+0xf60>
  800f71:	a1 20 40 80 00       	mov    0x804020,%eax
  800f76:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  800f7c:	83 f8 01             	cmp    $0x1,%eax
  800f7f:	74 17                	je     800f98 <_main+0xf60>
		{
			panic("LRU lists content is not correct");
  800f81:	83 ec 04             	sub    $0x4,%esp
  800f84:	68 f0 35 80 00       	push   $0x8035f0
  800f89:	68 ee 00 00 00       	push   $0xee
  800f8e:	68 2b 34 80 00       	push   $0x80342b
  800f93:	e8 eb 07 00 00       	call   801783 <_panic>
		}

		//Free 1st 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800f98:	e8 f9 1c 00 00       	call   802c96 <sys_calculate_free_frames>
  800f9d:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800fa3:	e8 71 1d 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  800fa8:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[0]);
  800fae:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  800fb4:	83 ec 0c             	sub    $0xc,%esp
  800fb7:	50                   	push   %eax
  800fb8:	e8 02 1a 00 00       	call   8029bf <free>
  800fbd:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  800fc0:	e8 54 1d 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  800fc5:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  800fcb:	29 c2                	sub    %eax,%edx
  800fcd:	89 d0                	mov    %edx,%eax
  800fcf:	3d 00 02 00 00       	cmp    $0x200,%eax
  800fd4:	74 17                	je     800fed <_main+0xfb5>
  800fd6:	83 ec 04             	sub    $0x4,%esp
  800fd9:	68 3c 35 80 00       	push   $0x80353c
  800fde:	68 f5 00 00 00       	push   $0xf5
  800fe3:	68 2b 34 80 00       	push   $0x80342b
  800fe8:	e8 96 07 00 00       	call   801783 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 ) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800fed:	e8 a4 1c 00 00       	call   802c96 <sys_calculate_free_frames>
  800ff2:	89 c2                	mov    %eax,%edx
  800ff4:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  800ffa:	29 c2                	sub    %eax,%edx
  800ffc:	89 d0                	mov    %edx,%eax
  800ffe:	83 f8 02             	cmp    $0x2,%eax
  801001:	74 17                	je     80101a <_main+0xfe2>
  801003:	83 ec 04             	sub    $0x4,%esp
  801006:	68 78 35 80 00       	push   $0x803578
  80100b:	68 f6 00 00 00       	push   $0xf6
  801010:	68 2b 34 80 00       	push   $0x80342b
  801015:	e8 69 07 00 00       	call   801783 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(byteArr[0]));
  80101a:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80101d:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(byteArr[lastIndexOfByte]));
  801023:	8b 55 b8             	mov    -0x48(%ebp),%edx
  801026:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801029:	01 d0                	add    %edx,%eax
  80102b:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  801031:	83 ec 08             	sub    $0x8,%esp
  801034:	6a 02                	push   $0x2
  801036:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  80103c:	50                   	push   %eax
  80103d:	e8 28 21 00 00       	call   80316a <sys_check_LRU_lists_free>
  801042:	83 c4 10             	add    $0x10,%esp
  801045:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  80104b:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  801052:	74 17                	je     80106b <_main+0x1033>
		{
				panic("free: page is not removed from LRU lists");
  801054:	83 ec 04             	sub    $0x4,%esp
  801057:	68 c4 35 80 00       	push   $0x8035c4
  80105c:	68 05 01 00 00       	push   $0x105
  801061:	68 2b 34 80 00       	push   $0x80342b
  801066:	e8 18 07 00 00       	call   801783 <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 799 && LIST_SIZE(&myEnv->SecondList) != 0)
  80106b:	a1 20 40 80 00       	mov    0x804020,%eax
  801070:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  801076:	3d 1f 03 00 00       	cmp    $0x31f,%eax
  80107b:	74 26                	je     8010a3 <_main+0x106b>
  80107d:	a1 20 40 80 00       	mov    0x804020,%eax
  801082:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  801088:	85 c0                	test   %eax,%eax
  80108a:	74 17                	je     8010a3 <_main+0x106b>
		{
			panic("LRU lists content is not correct");
  80108c:	83 ec 04             	sub    $0x4,%esp
  80108f:	68 f0 35 80 00       	push   $0x8035f0
  801094:	68 0a 01 00 00       	push   $0x10a
  801099:	68 2b 34 80 00       	push   $0x80342b
  80109e:	e8 e0 06 00 00       	call   801783 <_panic>
		}

		//Free 2nd 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8010a3:	e8 ee 1b 00 00       	call   802c96 <sys_calculate_free_frames>
  8010a8:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8010ae:	e8 66 1c 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  8010b3:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[1]);
  8010b9:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  8010bf:	83 ec 0c             	sub    $0xc,%esp
  8010c2:	50                   	push   %eax
  8010c3:	e8 f7 18 00 00       	call   8029bf <free>
  8010c8:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  8010cb:	e8 49 1c 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  8010d0:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  8010d6:	29 c2                	sub    %eax,%edx
  8010d8:	89 d0                	mov    %edx,%eax
  8010da:	3d 00 02 00 00       	cmp    $0x200,%eax
  8010df:	74 17                	je     8010f8 <_main+0x10c0>
  8010e1:	83 ec 04             	sub    $0x4,%esp
  8010e4:	68 3c 35 80 00       	push   $0x80353c
  8010e9:	68 11 01 00 00       	push   $0x111
  8010ee:	68 2b 34 80 00       	push   $0x80342b
  8010f3:	e8 8b 06 00 00       	call   801783 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8010f8:	e8 99 1b 00 00       	call   802c96 <sys_calculate_free_frames>
  8010fd:	89 c2                	mov    %eax,%edx
  8010ff:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801105:	29 c2                	sub    %eax,%edx
  801107:	89 d0                	mov    %edx,%eax
  801109:	83 f8 03             	cmp    $0x3,%eax
  80110c:	74 17                	je     801125 <_main+0x10ed>
  80110e:	83 ec 04             	sub    $0x4,%esp
  801111:	68 78 35 80 00       	push   $0x803578
  801116:	68 12 01 00 00       	push   $0x112
  80111b:	68 2b 34 80 00       	push   $0x80342b
  801120:	e8 5e 06 00 00       	call   801783 <_panic>
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}
		tmp_addresses[0] = (uint32)(&(shortArr[0]));
  801125:	8b 45 a0             	mov    -0x60(%ebp),%eax
  801128:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(shortArr[lastIndexOfShort]));
  80112e:	8b 45 9c             	mov    -0x64(%ebp),%eax
  801131:	01 c0                	add    %eax,%eax
  801133:	89 c2                	mov    %eax,%edx
  801135:	8b 45 a0             	mov    -0x60(%ebp),%eax
  801138:	01 d0                	add    %edx,%eax
  80113a:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  801140:	83 ec 08             	sub    $0x8,%esp
  801143:	6a 02                	push   $0x2
  801145:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  80114b:	50                   	push   %eax
  80114c:	e8 19 20 00 00       	call   80316a <sys_check_LRU_lists_free>
  801151:	83 c4 10             	add    $0x10,%esp
  801154:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  80115a:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  801161:	74 17                	je     80117a <_main+0x1142>
		{
				panic("free: page is not removed from LRU lists");
  801163:	83 ec 04             	sub    $0x4,%esp
  801166:	68 c4 35 80 00       	push   $0x8035c4
  80116b:	68 1f 01 00 00       	push   $0x11f
  801170:	68 2b 34 80 00       	push   $0x80342b
  801175:	e8 09 06 00 00       	call   801783 <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 797 && LIST_SIZE(&myEnv->SecondList) != 0)
  80117a:	a1 20 40 80 00       	mov    0x804020,%eax
  80117f:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  801185:	3d 1d 03 00 00       	cmp    $0x31d,%eax
  80118a:	74 26                	je     8011b2 <_main+0x117a>
  80118c:	a1 20 40 80 00       	mov    0x804020,%eax
  801191:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  801197:	85 c0                	test   %eax,%eax
  801199:	74 17                	je     8011b2 <_main+0x117a>
		{
			panic("LRU lists content is not correct");
  80119b:	83 ec 04             	sub    $0x4,%esp
  80119e:	68 f0 35 80 00       	push   $0x8035f0
  8011a3:	68 24 01 00 00       	push   $0x124
  8011a8:	68 2b 34 80 00       	push   $0x80342b
  8011ad:	e8 d1 05 00 00       	call   801783 <_panic>
		}


		//Free 7 KB
		freeFrames = sys_calculate_free_frames() ;
  8011b2:	e8 df 1a 00 00       	call   802c96 <sys_calculate_free_frames>
  8011b7:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8011bd:	e8 57 1b 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  8011c2:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[4]);
  8011c8:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  8011ce:	83 ec 0c             	sub    $0xc,%esp
  8011d1:	50                   	push   %eax
  8011d2:	e8 e8 17 00 00       	call   8029bf <free>
  8011d7:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2) panic("Wrong free: Extra or less pages are removed from PageFile");
  8011da:	e8 3a 1b 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  8011df:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  8011e5:	29 c2                	sub    %eax,%edx
  8011e7:	89 d0                	mov    %edx,%eax
  8011e9:	83 f8 02             	cmp    $0x2,%eax
  8011ec:	74 17                	je     801205 <_main+0x11cd>
  8011ee:	83 ec 04             	sub    $0x4,%esp
  8011f1:	68 3c 35 80 00       	push   $0x80353c
  8011f6:	68 2c 01 00 00       	push   $0x12c
  8011fb:	68 2b 34 80 00       	push   $0x80342b
  801200:	e8 7e 05 00 00       	call   801783 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801205:	e8 8c 1a 00 00       	call   802c96 <sys_calculate_free_frames>
  80120a:	89 c2                	mov    %eax,%edx
  80120c:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801212:	29 c2                	sub    %eax,%edx
  801214:	89 d0                	mov    %edx,%eax
  801216:	83 f8 02             	cmp    $0x2,%eax
  801219:	74 17                	je     801232 <_main+0x11fa>
  80121b:	83 ec 04             	sub    $0x4,%esp
  80121e:	68 78 35 80 00       	push   $0x803578
  801223:	68 2d 01 00 00       	push   $0x12d
  801228:	68 2b 34 80 00       	push   $0x80342b
  80122d:	e8 51 05 00 00       	call   801783 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(structArr[0]));
  801232:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  801238:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(structArr[lastIndexOfStruct]));
  80123e:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  801244:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80124b:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  801251:	01 d0                	add    %edx,%eax
  801253:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  801259:	83 ec 08             	sub    $0x8,%esp
  80125c:	6a 02                	push   $0x2
  80125e:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  801264:	50                   	push   %eax
  801265:	e8 00 1f 00 00       	call   80316a <sys_check_LRU_lists_free>
  80126a:	83 c4 10             	add    $0x10,%esp
  80126d:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  801273:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  80127a:	74 17                	je     801293 <_main+0x125b>
		{
				panic("free: page is not removed from LRU lists");
  80127c:	83 ec 04             	sub    $0x4,%esp
  80127f:	68 c4 35 80 00       	push   $0x8035c4
  801284:	68 3b 01 00 00       	push   $0x13b
  801289:	68 2b 34 80 00       	push   $0x80342b
  80128e:	e8 f0 04 00 00       	call   801783 <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 795 && LIST_SIZE(&myEnv->SecondList) != 0)
  801293:	a1 20 40 80 00       	mov    0x804020,%eax
  801298:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  80129e:	3d 1b 03 00 00       	cmp    $0x31b,%eax
  8012a3:	74 26                	je     8012cb <_main+0x1293>
  8012a5:	a1 20 40 80 00       	mov    0x804020,%eax
  8012aa:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  8012b0:	85 c0                	test   %eax,%eax
  8012b2:	74 17                	je     8012cb <_main+0x1293>
		{
			panic("LRU lists content is not correct");
  8012b4:	83 ec 04             	sub    $0x4,%esp
  8012b7:	68 f0 35 80 00       	push   $0x8035f0
  8012bc:	68 40 01 00 00       	push   $0x140
  8012c1:	68 2b 34 80 00       	push   $0x80342b
  8012c6:	e8 b8 04 00 00       	call   801783 <_panic>
		}

		//Free 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8012cb:	e8 c6 19 00 00       	call   802c96 <sys_calculate_free_frames>
  8012d0:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8012d6:	e8 3e 1a 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  8012db:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[5]);
  8012e1:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  8012e7:	83 ec 0c             	sub    $0xc,%esp
  8012ea:	50                   	push   %eax
  8012eb:	e8 cf 16 00 00       	call   8029bf <free>
  8012f0:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
  8012f3:	e8 21 1a 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  8012f8:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  8012fe:	89 d1                	mov    %edx,%ecx
  801300:	29 c1                	sub    %eax,%ecx
  801302:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801305:	89 c2                	mov    %eax,%edx
  801307:	01 d2                	add    %edx,%edx
  801309:	01 d0                	add    %edx,%eax
  80130b:	85 c0                	test   %eax,%eax
  80130d:	79 05                	jns    801314 <_main+0x12dc>
  80130f:	05 ff 0f 00 00       	add    $0xfff,%eax
  801314:	c1 f8 0c             	sar    $0xc,%eax
  801317:	39 c1                	cmp    %eax,%ecx
  801319:	74 17                	je     801332 <_main+0x12fa>
  80131b:	83 ec 04             	sub    $0x4,%esp
  80131e:	68 3c 35 80 00       	push   $0x80353c
  801323:	68 47 01 00 00       	push   $0x147
  801328:	68 2b 34 80 00       	push   $0x80342b
  80132d:	e8 51 04 00 00       	call   801783 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != toAccess) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801332:	e8 5f 19 00 00       	call   802c96 <sys_calculate_free_frames>
  801337:	89 c2                	mov    %eax,%edx
  801339:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  80133f:	29 c2                	sub    %eax,%edx
  801341:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  801344:	39 c2                	cmp    %eax,%edx
  801346:	74 17                	je     80135f <_main+0x1327>
  801348:	83 ec 04             	sub    $0x4,%esp
  80134b:	68 78 35 80 00       	push   $0x803578
  801350:	68 48 01 00 00       	push   $0x148
  801355:	68 2b 34 80 00       	push   $0x80342b
  80135a:	e8 24 04 00 00       	call   801783 <_panic>

		//Free 1st 3 KB
		freeFrames = sys_calculate_free_frames() ;
  80135f:	e8 32 19 00 00       	call   802c96 <sys_calculate_free_frames>
  801364:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80136a:	e8 aa 19 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  80136f:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[2]);
  801375:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  80137b:	83 ec 0c             	sub    $0xc,%esp
  80137e:	50                   	push   %eax
  80137f:	e8 3b 16 00 00       	call   8029bf <free>
  801384:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  801387:	e8 8d 19 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  80138c:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801392:	29 c2                	sub    %eax,%edx
  801394:	89 d0                	mov    %edx,%eax
  801396:	83 f8 01             	cmp    $0x1,%eax
  801399:	74 17                	je     8013b2 <_main+0x137a>
  80139b:	83 ec 04             	sub    $0x4,%esp
  80139e:	68 3c 35 80 00       	push   $0x80353c
  8013a3:	68 4e 01 00 00       	push   $0x14e
  8013a8:	68 2b 34 80 00       	push   $0x80342b
  8013ad:	e8 d1 03 00 00       	call   801783 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 1 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8013b2:	e8 df 18 00 00       	call   802c96 <sys_calculate_free_frames>
  8013b7:	89 c2                	mov    %eax,%edx
  8013b9:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  8013bf:	29 c2                	sub    %eax,%edx
  8013c1:	89 d0                	mov    %edx,%eax
  8013c3:	83 f8 02             	cmp    $0x2,%eax
  8013c6:	74 17                	je     8013df <_main+0x13a7>
  8013c8:	83 ec 04             	sub    $0x4,%esp
  8013cb:	68 78 35 80 00       	push   $0x803578
  8013d0:	68 4f 01 00 00       	push   $0x14f
  8013d5:	68 2b 34 80 00       	push   $0x80342b
  8013da:	e8 a4 03 00 00       	call   801783 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(intArr[0]));
  8013df:	8b 45 88             	mov    -0x78(%ebp),%eax
  8013e2:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(intArr[lastIndexOfInt]));
  8013e8:	8b 45 84             	mov    -0x7c(%ebp),%eax
  8013eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013f2:	8b 45 88             	mov    -0x78(%ebp),%eax
  8013f5:	01 d0                	add    %edx,%eax
  8013f7:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  8013fd:	83 ec 08             	sub    $0x8,%esp
  801400:	6a 02                	push   $0x2
  801402:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  801408:	50                   	push   %eax
  801409:	e8 5c 1d 00 00       	call   80316a <sys_check_LRU_lists_free>
  80140e:	83 c4 10             	add    $0x10,%esp
  801411:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  801417:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  80141e:	74 17                	je     801437 <_main+0x13ff>
		{
				panic("free: page is not removed from LRU lists");
  801420:	83 ec 04             	sub    $0x4,%esp
  801423:	68 c4 35 80 00       	push   $0x8035c4
  801428:	68 5d 01 00 00       	push   $0x15d
  80142d:	68 2b 34 80 00       	push   $0x80342b
  801432:	e8 4c 03 00 00       	call   801783 <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 794 && LIST_SIZE(&myEnv->SecondList) != 0)
  801437:	a1 20 40 80 00       	mov    0x804020,%eax
  80143c:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  801442:	3d 1a 03 00 00       	cmp    $0x31a,%eax
  801447:	74 26                	je     80146f <_main+0x1437>
  801449:	a1 20 40 80 00       	mov    0x804020,%eax
  80144e:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  801454:	85 c0                	test   %eax,%eax
  801456:	74 17                	je     80146f <_main+0x1437>
		{
			panic("LRU lists content is not correct");
  801458:	83 ec 04             	sub    $0x4,%esp
  80145b:	68 f0 35 80 00       	push   $0x8035f0
  801460:	68 62 01 00 00       	push   $0x162
  801465:	68 2b 34 80 00       	push   $0x80342b
  80146a:	e8 14 03 00 00       	call   801783 <_panic>
		}

		//Free 2nd 3 KB
		freeFrames = sys_calculate_free_frames() ;
  80146f:	e8 22 18 00 00       	call   802c96 <sys_calculate_free_frames>
  801474:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80147a:	e8 9a 18 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  80147f:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[3]);
  801485:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  80148b:	83 ec 0c             	sub    $0xc,%esp
  80148e:	50                   	push   %eax
  80148f:	e8 2b 15 00 00       	call   8029bf <free>
  801494:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  801497:	e8 7d 18 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  80149c:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  8014a2:	29 c2                	sub    %eax,%edx
  8014a4:	89 d0                	mov    %edx,%eax
  8014a6:	83 f8 01             	cmp    $0x1,%eax
  8014a9:	74 17                	je     8014c2 <_main+0x148a>
  8014ab:	83 ec 04             	sub    $0x4,%esp
  8014ae:	68 3c 35 80 00       	push   $0x80353c
  8014b3:	68 69 01 00 00       	push   $0x169
  8014b8:	68 2b 34 80 00       	push   $0x80342b
  8014bd:	e8 c1 02 00 00       	call   801783 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8014c2:	e8 cf 17 00 00       	call   802c96 <sys_calculate_free_frames>
  8014c7:	89 c2                	mov    %eax,%edx
  8014c9:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  8014cf:	39 c2                	cmp    %eax,%edx
  8014d1:	74 17                	je     8014ea <_main+0x14b2>
  8014d3:	83 ec 04             	sub    $0x4,%esp
  8014d6:	68 78 35 80 00       	push   $0x803578
  8014db:	68 6a 01 00 00       	push   $0x16a
  8014e0:	68 2b 34 80 00       	push   $0x80342b
  8014e5:	e8 99 02 00 00       	call   801783 <_panic>

		//Free last 14 KB
		freeFrames = sys_calculate_free_frames() ;
  8014ea:	e8 a7 17 00 00       	call   802c96 <sys_calculate_free_frames>
  8014ef:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8014f5:	e8 1f 18 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  8014fa:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[7]);
  801500:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  801506:	83 ec 0c             	sub    $0xc,%esp
  801509:	50                   	push   %eax
  80150a:	e8 b0 14 00 00       	call   8029bf <free>
  80150f:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 4) panic("Wrong free: Extra or less pages are removed from PageFile");
  801512:	e8 02 18 00 00       	call   802d19 <sys_pf_calculate_allocated_pages>
  801517:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  80151d:	29 c2                	sub    %eax,%edx
  80151f:	89 d0                	mov    %edx,%eax
  801521:	83 f8 04             	cmp    $0x4,%eax
  801524:	74 17                	je     80153d <_main+0x1505>
  801526:	83 ec 04             	sub    $0x4,%esp
  801529:	68 3c 35 80 00       	push   $0x80353c
  80152e:	68 70 01 00 00       	push   $0x170
  801533:	68 2b 34 80 00       	push   $0x80342b
  801538:	e8 46 02 00 00       	call   801783 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80153d:	e8 54 17 00 00       	call   802c96 <sys_calculate_free_frames>
  801542:	89 c2                	mov    %eax,%edx
  801544:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  80154a:	29 c2                	sub    %eax,%edx
  80154c:	89 d0                	mov    %edx,%eax
  80154e:	83 f8 03             	cmp    $0x3,%eax
  801551:	74 17                	je     80156a <_main+0x1532>
  801553:	83 ec 04             	sub    $0x4,%esp
  801556:	68 78 35 80 00       	push   $0x803578
  80155b:	68 71 01 00 00       	push   $0x171
  801560:	68 2b 34 80 00       	push   $0x80342b
  801565:	e8 19 02 00 00       	call   801783 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(shortArr2[0]));
  80156a:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  801570:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(shortArr2[lastIndexOfShort2]));
  801576:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  80157c:	01 c0                	add    %eax,%eax
  80157e:	89 c2                	mov    %eax,%edx
  801580:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  801586:	01 d0                	add    %edx,%eax
  801588:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  80158e:	83 ec 08             	sub    $0x8,%esp
  801591:	6a 02                	push   $0x2
  801593:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  801599:	50                   	push   %eax
  80159a:	e8 cb 1b 00 00       	call   80316a <sys_check_LRU_lists_free>
  80159f:	83 c4 10             	add    $0x10,%esp
  8015a2:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  8015a8:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  8015af:	74 17                	je     8015c8 <_main+0x1590>
		{
				panic("free: page is not removed from LRU lists");
  8015b1:	83 ec 04             	sub    $0x4,%esp
  8015b4:	68 c4 35 80 00       	push   $0x8035c4
  8015b9:	68 7f 01 00 00       	push   $0x17f
  8015be:	68 2b 34 80 00       	push   $0x80342b
  8015c3:	e8 bb 01 00 00       	call   801783 <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 792 && LIST_SIZE(&myEnv->SecondList) != 0)
  8015c8:	a1 20 40 80 00       	mov    0x804020,%eax
  8015cd:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  8015d3:	3d 18 03 00 00       	cmp    $0x318,%eax
  8015d8:	74 26                	je     801600 <_main+0x15c8>
  8015da:	a1 20 40 80 00       	mov    0x804020,%eax
  8015df:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  8015e5:	85 c0                	test   %eax,%eax
  8015e7:	74 17                	je     801600 <_main+0x15c8>
		{
			panic("LRU lists content is not correct");
  8015e9:	83 ec 04             	sub    $0x4,%esp
  8015ec:	68 f0 35 80 00       	push   $0x8035f0
  8015f1:	68 84 01 00 00       	push   $0x184
  8015f6:	68 2b 34 80 00       	push   $0x80342b
  8015fb:	e8 83 01 00 00       	call   801783 <_panic>
		}

			if(start_freeFrames != (sys_calculate_free_frames() + 4)) {panic("Wrong free: not all pages removed correctly at end");}
  801600:	e8 91 16 00 00       	call   802c96 <sys_calculate_free_frames>
  801605:	8d 50 04             	lea    0x4(%eax),%edx
  801608:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80160b:	39 c2                	cmp    %eax,%edx
  80160d:	74 17                	je     801626 <_main+0x15ee>
  80160f:	83 ec 04             	sub    $0x4,%esp
  801612:	68 14 36 80 00       	push   $0x803614
  801617:	68 87 01 00 00       	push   $0x187
  80161c:	68 2b 34 80 00       	push   $0x80342b
  801621:	e8 5d 01 00 00       	call   801783 <_panic>
		}

		cprintf("Congratulations!! test free [1] completed successfully.\n");
  801626:	83 ec 0c             	sub    $0xc,%esp
  801629:	68 48 36 80 00       	push   $0x803648
  80162e:	e8 f2 03 00 00       	call   801a25 <cprintf>
  801633:	83 c4 10             	add    $0x10,%esp

	return;
  801636:	90                   	nop
}
  801637:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80163a:	5b                   	pop    %ebx
  80163b:	5f                   	pop    %edi
  80163c:	5d                   	pop    %ebp
  80163d:	c3                   	ret    

0080163e <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80163e:	55                   	push   %ebp
  80163f:	89 e5                	mov    %esp,%ebp
  801641:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  801644:	e8 82 15 00 00       	call   802bcb <sys_getenvindex>
  801649:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80164c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80164f:	89 d0                	mov    %edx,%eax
  801651:	c1 e0 03             	shl    $0x3,%eax
  801654:	01 d0                	add    %edx,%eax
  801656:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80165d:	01 c8                	add    %ecx,%eax
  80165f:	01 c0                	add    %eax,%eax
  801661:	01 d0                	add    %edx,%eax
  801663:	01 c0                	add    %eax,%eax
  801665:	01 d0                	add    %edx,%eax
  801667:	89 c2                	mov    %eax,%edx
  801669:	c1 e2 05             	shl    $0x5,%edx
  80166c:	29 c2                	sub    %eax,%edx
  80166e:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  801675:	89 c2                	mov    %eax,%edx
  801677:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80167d:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  801682:	a1 20 40 80 00       	mov    0x804020,%eax
  801687:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80168d:	84 c0                	test   %al,%al
  80168f:	74 0f                	je     8016a0 <libmain+0x62>
		binaryname = myEnv->prog_name;
  801691:	a1 20 40 80 00       	mov    0x804020,%eax
  801696:	05 40 3c 01 00       	add    $0x13c40,%eax
  80169b:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8016a0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8016a4:	7e 0a                	jle    8016b0 <libmain+0x72>
		binaryname = argv[0];
  8016a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016a9:	8b 00                	mov    (%eax),%eax
  8016ab:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  8016b0:	83 ec 08             	sub    $0x8,%esp
  8016b3:	ff 75 0c             	pushl  0xc(%ebp)
  8016b6:	ff 75 08             	pushl  0x8(%ebp)
  8016b9:	e8 7a e9 ff ff       	call   800038 <_main>
  8016be:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8016c1:	e8 a0 16 00 00       	call   802d66 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8016c6:	83 ec 0c             	sub    $0xc,%esp
  8016c9:	68 9c 36 80 00       	push   $0x80369c
  8016ce:	e8 52 03 00 00       	call   801a25 <cprintf>
  8016d3:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8016d6:	a1 20 40 80 00       	mov    0x804020,%eax
  8016db:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8016e1:	a1 20 40 80 00       	mov    0x804020,%eax
  8016e6:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8016ec:	83 ec 04             	sub    $0x4,%esp
  8016ef:	52                   	push   %edx
  8016f0:	50                   	push   %eax
  8016f1:	68 c4 36 80 00       	push   $0x8036c4
  8016f6:	e8 2a 03 00 00       	call   801a25 <cprintf>
  8016fb:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8016fe:	a1 20 40 80 00       	mov    0x804020,%eax
  801703:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  801709:	a1 20 40 80 00       	mov    0x804020,%eax
  80170e:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  801714:	83 ec 04             	sub    $0x4,%esp
  801717:	52                   	push   %edx
  801718:	50                   	push   %eax
  801719:	68 ec 36 80 00       	push   $0x8036ec
  80171e:	e8 02 03 00 00       	call   801a25 <cprintf>
  801723:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  801726:	a1 20 40 80 00       	mov    0x804020,%eax
  80172b:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  801731:	83 ec 08             	sub    $0x8,%esp
  801734:	50                   	push   %eax
  801735:	68 2d 37 80 00       	push   $0x80372d
  80173a:	e8 e6 02 00 00       	call   801a25 <cprintf>
  80173f:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  801742:	83 ec 0c             	sub    $0xc,%esp
  801745:	68 9c 36 80 00       	push   $0x80369c
  80174a:	e8 d6 02 00 00       	call   801a25 <cprintf>
  80174f:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  801752:	e8 29 16 00 00       	call   802d80 <sys_enable_interrupt>

	// exit gracefully
	exit();
  801757:	e8 19 00 00 00       	call   801775 <exit>
}
  80175c:	90                   	nop
  80175d:	c9                   	leave  
  80175e:	c3                   	ret    

0080175f <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80175f:	55                   	push   %ebp
  801760:	89 e5                	mov    %esp,%ebp
  801762:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  801765:	83 ec 0c             	sub    $0xc,%esp
  801768:	6a 00                	push   $0x0
  80176a:	e8 28 14 00 00       	call   802b97 <sys_env_destroy>
  80176f:	83 c4 10             	add    $0x10,%esp
}
  801772:	90                   	nop
  801773:	c9                   	leave  
  801774:	c3                   	ret    

00801775 <exit>:

void
exit(void)
{
  801775:	55                   	push   %ebp
  801776:	89 e5                	mov    %esp,%ebp
  801778:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80177b:	e8 7d 14 00 00       	call   802bfd <sys_env_exit>
}
  801780:	90                   	nop
  801781:	c9                   	leave  
  801782:	c3                   	ret    

00801783 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801783:	55                   	push   %ebp
  801784:	89 e5                	mov    %esp,%ebp
  801786:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801789:	8d 45 10             	lea    0x10(%ebp),%eax
  80178c:	83 c0 04             	add    $0x4,%eax
  80178f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801792:	a1 18 41 80 00       	mov    0x804118,%eax
  801797:	85 c0                	test   %eax,%eax
  801799:	74 16                	je     8017b1 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80179b:	a1 18 41 80 00       	mov    0x804118,%eax
  8017a0:	83 ec 08             	sub    $0x8,%esp
  8017a3:	50                   	push   %eax
  8017a4:	68 44 37 80 00       	push   $0x803744
  8017a9:	e8 77 02 00 00       	call   801a25 <cprintf>
  8017ae:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8017b1:	a1 00 40 80 00       	mov    0x804000,%eax
  8017b6:	ff 75 0c             	pushl  0xc(%ebp)
  8017b9:	ff 75 08             	pushl  0x8(%ebp)
  8017bc:	50                   	push   %eax
  8017bd:	68 49 37 80 00       	push   $0x803749
  8017c2:	e8 5e 02 00 00       	call   801a25 <cprintf>
  8017c7:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8017ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8017cd:	83 ec 08             	sub    $0x8,%esp
  8017d0:	ff 75 f4             	pushl  -0xc(%ebp)
  8017d3:	50                   	push   %eax
  8017d4:	e8 e1 01 00 00       	call   8019ba <vcprintf>
  8017d9:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8017dc:	83 ec 08             	sub    $0x8,%esp
  8017df:	6a 00                	push   $0x0
  8017e1:	68 65 37 80 00       	push   $0x803765
  8017e6:	e8 cf 01 00 00       	call   8019ba <vcprintf>
  8017eb:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8017ee:	e8 82 ff ff ff       	call   801775 <exit>

	// should not return here
	while (1) ;
  8017f3:	eb fe                	jmp    8017f3 <_panic+0x70>

008017f5 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8017f5:	55                   	push   %ebp
  8017f6:	89 e5                	mov    %esp,%ebp
  8017f8:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8017fb:	a1 20 40 80 00       	mov    0x804020,%eax
  801800:	8b 50 74             	mov    0x74(%eax),%edx
  801803:	8b 45 0c             	mov    0xc(%ebp),%eax
  801806:	39 c2                	cmp    %eax,%edx
  801808:	74 14                	je     80181e <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80180a:	83 ec 04             	sub    $0x4,%esp
  80180d:	68 68 37 80 00       	push   $0x803768
  801812:	6a 26                	push   $0x26
  801814:	68 b4 37 80 00       	push   $0x8037b4
  801819:	e8 65 ff ff ff       	call   801783 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80181e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801825:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80182c:	e9 b6 00 00 00       	jmp    8018e7 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801831:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801834:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80183b:	8b 45 08             	mov    0x8(%ebp),%eax
  80183e:	01 d0                	add    %edx,%eax
  801840:	8b 00                	mov    (%eax),%eax
  801842:	85 c0                	test   %eax,%eax
  801844:	75 08                	jne    80184e <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801846:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801849:	e9 96 00 00 00       	jmp    8018e4 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80184e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801855:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80185c:	eb 5d                	jmp    8018bb <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80185e:	a1 20 40 80 00       	mov    0x804020,%eax
  801863:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801869:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80186c:	c1 e2 04             	shl    $0x4,%edx
  80186f:	01 d0                	add    %edx,%eax
  801871:	8a 40 04             	mov    0x4(%eax),%al
  801874:	84 c0                	test   %al,%al
  801876:	75 40                	jne    8018b8 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801878:	a1 20 40 80 00       	mov    0x804020,%eax
  80187d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801883:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801886:	c1 e2 04             	shl    $0x4,%edx
  801889:	01 d0                	add    %edx,%eax
  80188b:	8b 00                	mov    (%eax),%eax
  80188d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801890:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801893:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801898:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80189a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80189d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8018a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a7:	01 c8                	add    %ecx,%eax
  8018a9:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8018ab:	39 c2                	cmp    %eax,%edx
  8018ad:	75 09                	jne    8018b8 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8018af:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8018b6:	eb 12                	jmp    8018ca <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8018b8:	ff 45 e8             	incl   -0x18(%ebp)
  8018bb:	a1 20 40 80 00       	mov    0x804020,%eax
  8018c0:	8b 50 74             	mov    0x74(%eax),%edx
  8018c3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8018c6:	39 c2                	cmp    %eax,%edx
  8018c8:	77 94                	ja     80185e <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8018ca:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8018ce:	75 14                	jne    8018e4 <CheckWSWithoutLastIndex+0xef>
			panic(
  8018d0:	83 ec 04             	sub    $0x4,%esp
  8018d3:	68 c0 37 80 00       	push   $0x8037c0
  8018d8:	6a 3a                	push   $0x3a
  8018da:	68 b4 37 80 00       	push   $0x8037b4
  8018df:	e8 9f fe ff ff       	call   801783 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8018e4:	ff 45 f0             	incl   -0x10(%ebp)
  8018e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018ea:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8018ed:	0f 8c 3e ff ff ff    	jl     801831 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8018f3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8018fa:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801901:	eb 20                	jmp    801923 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801903:	a1 20 40 80 00       	mov    0x804020,%eax
  801908:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80190e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801911:	c1 e2 04             	shl    $0x4,%edx
  801914:	01 d0                	add    %edx,%eax
  801916:	8a 40 04             	mov    0x4(%eax),%al
  801919:	3c 01                	cmp    $0x1,%al
  80191b:	75 03                	jne    801920 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80191d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801920:	ff 45 e0             	incl   -0x20(%ebp)
  801923:	a1 20 40 80 00       	mov    0x804020,%eax
  801928:	8b 50 74             	mov    0x74(%eax),%edx
  80192b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80192e:	39 c2                	cmp    %eax,%edx
  801930:	77 d1                	ja     801903 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801932:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801935:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801938:	74 14                	je     80194e <CheckWSWithoutLastIndex+0x159>
		panic(
  80193a:	83 ec 04             	sub    $0x4,%esp
  80193d:	68 14 38 80 00       	push   $0x803814
  801942:	6a 44                	push   $0x44
  801944:	68 b4 37 80 00       	push   $0x8037b4
  801949:	e8 35 fe ff ff       	call   801783 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80194e:	90                   	nop
  80194f:	c9                   	leave  
  801950:	c3                   	ret    

00801951 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  801951:	55                   	push   %ebp
  801952:	89 e5                	mov    %esp,%ebp
  801954:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801957:	8b 45 0c             	mov    0xc(%ebp),%eax
  80195a:	8b 00                	mov    (%eax),%eax
  80195c:	8d 48 01             	lea    0x1(%eax),%ecx
  80195f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801962:	89 0a                	mov    %ecx,(%edx)
  801964:	8b 55 08             	mov    0x8(%ebp),%edx
  801967:	88 d1                	mov    %dl,%cl
  801969:	8b 55 0c             	mov    0xc(%ebp),%edx
  80196c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  801970:	8b 45 0c             	mov    0xc(%ebp),%eax
  801973:	8b 00                	mov    (%eax),%eax
  801975:	3d ff 00 00 00       	cmp    $0xff,%eax
  80197a:	75 2c                	jne    8019a8 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80197c:	a0 24 40 80 00       	mov    0x804024,%al
  801981:	0f b6 c0             	movzbl %al,%eax
  801984:	8b 55 0c             	mov    0xc(%ebp),%edx
  801987:	8b 12                	mov    (%edx),%edx
  801989:	89 d1                	mov    %edx,%ecx
  80198b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80198e:	83 c2 08             	add    $0x8,%edx
  801991:	83 ec 04             	sub    $0x4,%esp
  801994:	50                   	push   %eax
  801995:	51                   	push   %ecx
  801996:	52                   	push   %edx
  801997:	e8 b9 11 00 00       	call   802b55 <sys_cputs>
  80199c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80199f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019a2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8019a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019ab:	8b 40 04             	mov    0x4(%eax),%eax
  8019ae:	8d 50 01             	lea    0x1(%eax),%edx
  8019b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019b4:	89 50 04             	mov    %edx,0x4(%eax)
}
  8019b7:	90                   	nop
  8019b8:	c9                   	leave  
  8019b9:	c3                   	ret    

008019ba <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8019ba:	55                   	push   %ebp
  8019bb:	89 e5                	mov    %esp,%ebp
  8019bd:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8019c3:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8019ca:	00 00 00 
	b.cnt = 0;
  8019cd:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8019d4:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8019d7:	ff 75 0c             	pushl  0xc(%ebp)
  8019da:	ff 75 08             	pushl  0x8(%ebp)
  8019dd:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8019e3:	50                   	push   %eax
  8019e4:	68 51 19 80 00       	push   $0x801951
  8019e9:	e8 11 02 00 00       	call   801bff <vprintfmt>
  8019ee:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8019f1:	a0 24 40 80 00       	mov    0x804024,%al
  8019f6:	0f b6 c0             	movzbl %al,%eax
  8019f9:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8019ff:	83 ec 04             	sub    $0x4,%esp
  801a02:	50                   	push   %eax
  801a03:	52                   	push   %edx
  801a04:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801a0a:	83 c0 08             	add    $0x8,%eax
  801a0d:	50                   	push   %eax
  801a0e:	e8 42 11 00 00       	call   802b55 <sys_cputs>
  801a13:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801a16:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  801a1d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801a23:	c9                   	leave  
  801a24:	c3                   	ret    

00801a25 <cprintf>:

int cprintf(const char *fmt, ...) {
  801a25:	55                   	push   %ebp
  801a26:	89 e5                	mov    %esp,%ebp
  801a28:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  801a2b:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  801a32:	8d 45 0c             	lea    0xc(%ebp),%eax
  801a35:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801a38:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3b:	83 ec 08             	sub    $0x8,%esp
  801a3e:	ff 75 f4             	pushl  -0xc(%ebp)
  801a41:	50                   	push   %eax
  801a42:	e8 73 ff ff ff       	call   8019ba <vcprintf>
  801a47:	83 c4 10             	add    $0x10,%esp
  801a4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  801a4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a50:	c9                   	leave  
  801a51:	c3                   	ret    

00801a52 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801a52:	55                   	push   %ebp
  801a53:	89 e5                	mov    %esp,%ebp
  801a55:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801a58:	e8 09 13 00 00       	call   802d66 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801a5d:	8d 45 0c             	lea    0xc(%ebp),%eax
  801a60:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801a63:	8b 45 08             	mov    0x8(%ebp),%eax
  801a66:	83 ec 08             	sub    $0x8,%esp
  801a69:	ff 75 f4             	pushl  -0xc(%ebp)
  801a6c:	50                   	push   %eax
  801a6d:	e8 48 ff ff ff       	call   8019ba <vcprintf>
  801a72:	83 c4 10             	add    $0x10,%esp
  801a75:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801a78:	e8 03 13 00 00       	call   802d80 <sys_enable_interrupt>
	return cnt;
  801a7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a80:	c9                   	leave  
  801a81:	c3                   	ret    

00801a82 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801a82:	55                   	push   %ebp
  801a83:	89 e5                	mov    %esp,%ebp
  801a85:	53                   	push   %ebx
  801a86:	83 ec 14             	sub    $0x14,%esp
  801a89:	8b 45 10             	mov    0x10(%ebp),%eax
  801a8c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801a8f:	8b 45 14             	mov    0x14(%ebp),%eax
  801a92:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801a95:	8b 45 18             	mov    0x18(%ebp),%eax
  801a98:	ba 00 00 00 00       	mov    $0x0,%edx
  801a9d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801aa0:	77 55                	ja     801af7 <printnum+0x75>
  801aa2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801aa5:	72 05                	jb     801aac <printnum+0x2a>
  801aa7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801aaa:	77 4b                	ja     801af7 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801aac:	8b 45 1c             	mov    0x1c(%ebp),%eax
  801aaf:	8d 58 ff             	lea    -0x1(%eax),%ebx
  801ab2:	8b 45 18             	mov    0x18(%ebp),%eax
  801ab5:	ba 00 00 00 00       	mov    $0x0,%edx
  801aba:	52                   	push   %edx
  801abb:	50                   	push   %eax
  801abc:	ff 75 f4             	pushl  -0xc(%ebp)
  801abf:	ff 75 f0             	pushl  -0x10(%ebp)
  801ac2:	e8 c1 16 00 00       	call   803188 <__udivdi3>
  801ac7:	83 c4 10             	add    $0x10,%esp
  801aca:	83 ec 04             	sub    $0x4,%esp
  801acd:	ff 75 20             	pushl  0x20(%ebp)
  801ad0:	53                   	push   %ebx
  801ad1:	ff 75 18             	pushl  0x18(%ebp)
  801ad4:	52                   	push   %edx
  801ad5:	50                   	push   %eax
  801ad6:	ff 75 0c             	pushl  0xc(%ebp)
  801ad9:	ff 75 08             	pushl  0x8(%ebp)
  801adc:	e8 a1 ff ff ff       	call   801a82 <printnum>
  801ae1:	83 c4 20             	add    $0x20,%esp
  801ae4:	eb 1a                	jmp    801b00 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801ae6:	83 ec 08             	sub    $0x8,%esp
  801ae9:	ff 75 0c             	pushl  0xc(%ebp)
  801aec:	ff 75 20             	pushl  0x20(%ebp)
  801aef:	8b 45 08             	mov    0x8(%ebp),%eax
  801af2:	ff d0                	call   *%eax
  801af4:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801af7:	ff 4d 1c             	decl   0x1c(%ebp)
  801afa:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801afe:	7f e6                	jg     801ae6 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801b00:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801b03:	bb 00 00 00 00       	mov    $0x0,%ebx
  801b08:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b0b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b0e:	53                   	push   %ebx
  801b0f:	51                   	push   %ecx
  801b10:	52                   	push   %edx
  801b11:	50                   	push   %eax
  801b12:	e8 81 17 00 00       	call   803298 <__umoddi3>
  801b17:	83 c4 10             	add    $0x10,%esp
  801b1a:	05 74 3a 80 00       	add    $0x803a74,%eax
  801b1f:	8a 00                	mov    (%eax),%al
  801b21:	0f be c0             	movsbl %al,%eax
  801b24:	83 ec 08             	sub    $0x8,%esp
  801b27:	ff 75 0c             	pushl  0xc(%ebp)
  801b2a:	50                   	push   %eax
  801b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2e:	ff d0                	call   *%eax
  801b30:	83 c4 10             	add    $0x10,%esp
}
  801b33:	90                   	nop
  801b34:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b37:	c9                   	leave  
  801b38:	c3                   	ret    

00801b39 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801b39:	55                   	push   %ebp
  801b3a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801b3c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801b40:	7e 1c                	jle    801b5e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801b42:	8b 45 08             	mov    0x8(%ebp),%eax
  801b45:	8b 00                	mov    (%eax),%eax
  801b47:	8d 50 08             	lea    0x8(%eax),%edx
  801b4a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4d:	89 10                	mov    %edx,(%eax)
  801b4f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b52:	8b 00                	mov    (%eax),%eax
  801b54:	83 e8 08             	sub    $0x8,%eax
  801b57:	8b 50 04             	mov    0x4(%eax),%edx
  801b5a:	8b 00                	mov    (%eax),%eax
  801b5c:	eb 40                	jmp    801b9e <getuint+0x65>
	else if (lflag)
  801b5e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801b62:	74 1e                	je     801b82 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801b64:	8b 45 08             	mov    0x8(%ebp),%eax
  801b67:	8b 00                	mov    (%eax),%eax
  801b69:	8d 50 04             	lea    0x4(%eax),%edx
  801b6c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6f:	89 10                	mov    %edx,(%eax)
  801b71:	8b 45 08             	mov    0x8(%ebp),%eax
  801b74:	8b 00                	mov    (%eax),%eax
  801b76:	83 e8 04             	sub    $0x4,%eax
  801b79:	8b 00                	mov    (%eax),%eax
  801b7b:	ba 00 00 00 00       	mov    $0x0,%edx
  801b80:	eb 1c                	jmp    801b9e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801b82:	8b 45 08             	mov    0x8(%ebp),%eax
  801b85:	8b 00                	mov    (%eax),%eax
  801b87:	8d 50 04             	lea    0x4(%eax),%edx
  801b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8d:	89 10                	mov    %edx,(%eax)
  801b8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b92:	8b 00                	mov    (%eax),%eax
  801b94:	83 e8 04             	sub    $0x4,%eax
  801b97:	8b 00                	mov    (%eax),%eax
  801b99:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801b9e:	5d                   	pop    %ebp
  801b9f:	c3                   	ret    

00801ba0 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801ba0:	55                   	push   %ebp
  801ba1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801ba3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801ba7:	7e 1c                	jle    801bc5 <getint+0x25>
		return va_arg(*ap, long long);
  801ba9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bac:	8b 00                	mov    (%eax),%eax
  801bae:	8d 50 08             	lea    0x8(%eax),%edx
  801bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb4:	89 10                	mov    %edx,(%eax)
  801bb6:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb9:	8b 00                	mov    (%eax),%eax
  801bbb:	83 e8 08             	sub    $0x8,%eax
  801bbe:	8b 50 04             	mov    0x4(%eax),%edx
  801bc1:	8b 00                	mov    (%eax),%eax
  801bc3:	eb 38                	jmp    801bfd <getint+0x5d>
	else if (lflag)
  801bc5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801bc9:	74 1a                	je     801be5 <getint+0x45>
		return va_arg(*ap, long);
  801bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bce:	8b 00                	mov    (%eax),%eax
  801bd0:	8d 50 04             	lea    0x4(%eax),%edx
  801bd3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd6:	89 10                	mov    %edx,(%eax)
  801bd8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdb:	8b 00                	mov    (%eax),%eax
  801bdd:	83 e8 04             	sub    $0x4,%eax
  801be0:	8b 00                	mov    (%eax),%eax
  801be2:	99                   	cltd   
  801be3:	eb 18                	jmp    801bfd <getint+0x5d>
	else
		return va_arg(*ap, int);
  801be5:	8b 45 08             	mov    0x8(%ebp),%eax
  801be8:	8b 00                	mov    (%eax),%eax
  801bea:	8d 50 04             	lea    0x4(%eax),%edx
  801bed:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf0:	89 10                	mov    %edx,(%eax)
  801bf2:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf5:	8b 00                	mov    (%eax),%eax
  801bf7:	83 e8 04             	sub    $0x4,%eax
  801bfa:	8b 00                	mov    (%eax),%eax
  801bfc:	99                   	cltd   
}
  801bfd:	5d                   	pop    %ebp
  801bfe:	c3                   	ret    

00801bff <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801bff:	55                   	push   %ebp
  801c00:	89 e5                	mov    %esp,%ebp
  801c02:	56                   	push   %esi
  801c03:	53                   	push   %ebx
  801c04:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801c07:	eb 17                	jmp    801c20 <vprintfmt+0x21>
			if (ch == '\0')
  801c09:	85 db                	test   %ebx,%ebx
  801c0b:	0f 84 af 03 00 00    	je     801fc0 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801c11:	83 ec 08             	sub    $0x8,%esp
  801c14:	ff 75 0c             	pushl  0xc(%ebp)
  801c17:	53                   	push   %ebx
  801c18:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1b:	ff d0                	call   *%eax
  801c1d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801c20:	8b 45 10             	mov    0x10(%ebp),%eax
  801c23:	8d 50 01             	lea    0x1(%eax),%edx
  801c26:	89 55 10             	mov    %edx,0x10(%ebp)
  801c29:	8a 00                	mov    (%eax),%al
  801c2b:	0f b6 d8             	movzbl %al,%ebx
  801c2e:	83 fb 25             	cmp    $0x25,%ebx
  801c31:	75 d6                	jne    801c09 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801c33:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801c37:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801c3e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801c45:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801c4c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801c53:	8b 45 10             	mov    0x10(%ebp),%eax
  801c56:	8d 50 01             	lea    0x1(%eax),%edx
  801c59:	89 55 10             	mov    %edx,0x10(%ebp)
  801c5c:	8a 00                	mov    (%eax),%al
  801c5e:	0f b6 d8             	movzbl %al,%ebx
  801c61:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801c64:	83 f8 55             	cmp    $0x55,%eax
  801c67:	0f 87 2b 03 00 00    	ja     801f98 <vprintfmt+0x399>
  801c6d:	8b 04 85 98 3a 80 00 	mov    0x803a98(,%eax,4),%eax
  801c74:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801c76:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801c7a:	eb d7                	jmp    801c53 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801c7c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801c80:	eb d1                	jmp    801c53 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801c82:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801c89:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801c8c:	89 d0                	mov    %edx,%eax
  801c8e:	c1 e0 02             	shl    $0x2,%eax
  801c91:	01 d0                	add    %edx,%eax
  801c93:	01 c0                	add    %eax,%eax
  801c95:	01 d8                	add    %ebx,%eax
  801c97:	83 e8 30             	sub    $0x30,%eax
  801c9a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801c9d:	8b 45 10             	mov    0x10(%ebp),%eax
  801ca0:	8a 00                	mov    (%eax),%al
  801ca2:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801ca5:	83 fb 2f             	cmp    $0x2f,%ebx
  801ca8:	7e 3e                	jle    801ce8 <vprintfmt+0xe9>
  801caa:	83 fb 39             	cmp    $0x39,%ebx
  801cad:	7f 39                	jg     801ce8 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801caf:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801cb2:	eb d5                	jmp    801c89 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801cb4:	8b 45 14             	mov    0x14(%ebp),%eax
  801cb7:	83 c0 04             	add    $0x4,%eax
  801cba:	89 45 14             	mov    %eax,0x14(%ebp)
  801cbd:	8b 45 14             	mov    0x14(%ebp),%eax
  801cc0:	83 e8 04             	sub    $0x4,%eax
  801cc3:	8b 00                	mov    (%eax),%eax
  801cc5:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801cc8:	eb 1f                	jmp    801ce9 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801cca:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801cce:	79 83                	jns    801c53 <vprintfmt+0x54>
				width = 0;
  801cd0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801cd7:	e9 77 ff ff ff       	jmp    801c53 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801cdc:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801ce3:	e9 6b ff ff ff       	jmp    801c53 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801ce8:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801ce9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801ced:	0f 89 60 ff ff ff    	jns    801c53 <vprintfmt+0x54>
				width = precision, precision = -1;
  801cf3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801cf6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801cf9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801d00:	e9 4e ff ff ff       	jmp    801c53 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801d05:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801d08:	e9 46 ff ff ff       	jmp    801c53 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801d0d:	8b 45 14             	mov    0x14(%ebp),%eax
  801d10:	83 c0 04             	add    $0x4,%eax
  801d13:	89 45 14             	mov    %eax,0x14(%ebp)
  801d16:	8b 45 14             	mov    0x14(%ebp),%eax
  801d19:	83 e8 04             	sub    $0x4,%eax
  801d1c:	8b 00                	mov    (%eax),%eax
  801d1e:	83 ec 08             	sub    $0x8,%esp
  801d21:	ff 75 0c             	pushl  0xc(%ebp)
  801d24:	50                   	push   %eax
  801d25:	8b 45 08             	mov    0x8(%ebp),%eax
  801d28:	ff d0                	call   *%eax
  801d2a:	83 c4 10             	add    $0x10,%esp
			break;
  801d2d:	e9 89 02 00 00       	jmp    801fbb <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801d32:	8b 45 14             	mov    0x14(%ebp),%eax
  801d35:	83 c0 04             	add    $0x4,%eax
  801d38:	89 45 14             	mov    %eax,0x14(%ebp)
  801d3b:	8b 45 14             	mov    0x14(%ebp),%eax
  801d3e:	83 e8 04             	sub    $0x4,%eax
  801d41:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801d43:	85 db                	test   %ebx,%ebx
  801d45:	79 02                	jns    801d49 <vprintfmt+0x14a>
				err = -err;
  801d47:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801d49:	83 fb 64             	cmp    $0x64,%ebx
  801d4c:	7f 0b                	jg     801d59 <vprintfmt+0x15a>
  801d4e:	8b 34 9d e0 38 80 00 	mov    0x8038e0(,%ebx,4),%esi
  801d55:	85 f6                	test   %esi,%esi
  801d57:	75 19                	jne    801d72 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801d59:	53                   	push   %ebx
  801d5a:	68 85 3a 80 00       	push   $0x803a85
  801d5f:	ff 75 0c             	pushl  0xc(%ebp)
  801d62:	ff 75 08             	pushl  0x8(%ebp)
  801d65:	e8 5e 02 00 00       	call   801fc8 <printfmt>
  801d6a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801d6d:	e9 49 02 00 00       	jmp    801fbb <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801d72:	56                   	push   %esi
  801d73:	68 8e 3a 80 00       	push   $0x803a8e
  801d78:	ff 75 0c             	pushl  0xc(%ebp)
  801d7b:	ff 75 08             	pushl  0x8(%ebp)
  801d7e:	e8 45 02 00 00       	call   801fc8 <printfmt>
  801d83:	83 c4 10             	add    $0x10,%esp
			break;
  801d86:	e9 30 02 00 00       	jmp    801fbb <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801d8b:	8b 45 14             	mov    0x14(%ebp),%eax
  801d8e:	83 c0 04             	add    $0x4,%eax
  801d91:	89 45 14             	mov    %eax,0x14(%ebp)
  801d94:	8b 45 14             	mov    0x14(%ebp),%eax
  801d97:	83 e8 04             	sub    $0x4,%eax
  801d9a:	8b 30                	mov    (%eax),%esi
  801d9c:	85 f6                	test   %esi,%esi
  801d9e:	75 05                	jne    801da5 <vprintfmt+0x1a6>
				p = "(null)";
  801da0:	be 91 3a 80 00       	mov    $0x803a91,%esi
			if (width > 0 && padc != '-')
  801da5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801da9:	7e 6d                	jle    801e18 <vprintfmt+0x219>
  801dab:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801daf:	74 67                	je     801e18 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801db1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801db4:	83 ec 08             	sub    $0x8,%esp
  801db7:	50                   	push   %eax
  801db8:	56                   	push   %esi
  801db9:	e8 0c 03 00 00       	call   8020ca <strnlen>
  801dbe:	83 c4 10             	add    $0x10,%esp
  801dc1:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801dc4:	eb 16                	jmp    801ddc <vprintfmt+0x1dd>
					putch(padc, putdat);
  801dc6:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801dca:	83 ec 08             	sub    $0x8,%esp
  801dcd:	ff 75 0c             	pushl  0xc(%ebp)
  801dd0:	50                   	push   %eax
  801dd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd4:	ff d0                	call   *%eax
  801dd6:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801dd9:	ff 4d e4             	decl   -0x1c(%ebp)
  801ddc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801de0:	7f e4                	jg     801dc6 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801de2:	eb 34                	jmp    801e18 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801de4:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801de8:	74 1c                	je     801e06 <vprintfmt+0x207>
  801dea:	83 fb 1f             	cmp    $0x1f,%ebx
  801ded:	7e 05                	jle    801df4 <vprintfmt+0x1f5>
  801def:	83 fb 7e             	cmp    $0x7e,%ebx
  801df2:	7e 12                	jle    801e06 <vprintfmt+0x207>
					putch('?', putdat);
  801df4:	83 ec 08             	sub    $0x8,%esp
  801df7:	ff 75 0c             	pushl  0xc(%ebp)
  801dfa:	6a 3f                	push   $0x3f
  801dfc:	8b 45 08             	mov    0x8(%ebp),%eax
  801dff:	ff d0                	call   *%eax
  801e01:	83 c4 10             	add    $0x10,%esp
  801e04:	eb 0f                	jmp    801e15 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801e06:	83 ec 08             	sub    $0x8,%esp
  801e09:	ff 75 0c             	pushl  0xc(%ebp)
  801e0c:	53                   	push   %ebx
  801e0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e10:	ff d0                	call   *%eax
  801e12:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801e15:	ff 4d e4             	decl   -0x1c(%ebp)
  801e18:	89 f0                	mov    %esi,%eax
  801e1a:	8d 70 01             	lea    0x1(%eax),%esi
  801e1d:	8a 00                	mov    (%eax),%al
  801e1f:	0f be d8             	movsbl %al,%ebx
  801e22:	85 db                	test   %ebx,%ebx
  801e24:	74 24                	je     801e4a <vprintfmt+0x24b>
  801e26:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801e2a:	78 b8                	js     801de4 <vprintfmt+0x1e5>
  801e2c:	ff 4d e0             	decl   -0x20(%ebp)
  801e2f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801e33:	79 af                	jns    801de4 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801e35:	eb 13                	jmp    801e4a <vprintfmt+0x24b>
				putch(' ', putdat);
  801e37:	83 ec 08             	sub    $0x8,%esp
  801e3a:	ff 75 0c             	pushl  0xc(%ebp)
  801e3d:	6a 20                	push   $0x20
  801e3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e42:	ff d0                	call   *%eax
  801e44:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801e47:	ff 4d e4             	decl   -0x1c(%ebp)
  801e4a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801e4e:	7f e7                	jg     801e37 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801e50:	e9 66 01 00 00       	jmp    801fbb <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801e55:	83 ec 08             	sub    $0x8,%esp
  801e58:	ff 75 e8             	pushl  -0x18(%ebp)
  801e5b:	8d 45 14             	lea    0x14(%ebp),%eax
  801e5e:	50                   	push   %eax
  801e5f:	e8 3c fd ff ff       	call   801ba0 <getint>
  801e64:	83 c4 10             	add    $0x10,%esp
  801e67:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801e6a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801e6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e70:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801e73:	85 d2                	test   %edx,%edx
  801e75:	79 23                	jns    801e9a <vprintfmt+0x29b>
				putch('-', putdat);
  801e77:	83 ec 08             	sub    $0x8,%esp
  801e7a:	ff 75 0c             	pushl  0xc(%ebp)
  801e7d:	6a 2d                	push   $0x2d
  801e7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e82:	ff d0                	call   *%eax
  801e84:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801e87:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e8a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801e8d:	f7 d8                	neg    %eax
  801e8f:	83 d2 00             	adc    $0x0,%edx
  801e92:	f7 da                	neg    %edx
  801e94:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801e97:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801e9a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801ea1:	e9 bc 00 00 00       	jmp    801f62 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801ea6:	83 ec 08             	sub    $0x8,%esp
  801ea9:	ff 75 e8             	pushl  -0x18(%ebp)
  801eac:	8d 45 14             	lea    0x14(%ebp),%eax
  801eaf:	50                   	push   %eax
  801eb0:	e8 84 fc ff ff       	call   801b39 <getuint>
  801eb5:	83 c4 10             	add    $0x10,%esp
  801eb8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801ebb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801ebe:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801ec5:	e9 98 00 00 00       	jmp    801f62 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801eca:	83 ec 08             	sub    $0x8,%esp
  801ecd:	ff 75 0c             	pushl  0xc(%ebp)
  801ed0:	6a 58                	push   $0x58
  801ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed5:	ff d0                	call   *%eax
  801ed7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801eda:	83 ec 08             	sub    $0x8,%esp
  801edd:	ff 75 0c             	pushl  0xc(%ebp)
  801ee0:	6a 58                	push   $0x58
  801ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee5:	ff d0                	call   *%eax
  801ee7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801eea:	83 ec 08             	sub    $0x8,%esp
  801eed:	ff 75 0c             	pushl  0xc(%ebp)
  801ef0:	6a 58                	push   $0x58
  801ef2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef5:	ff d0                	call   *%eax
  801ef7:	83 c4 10             	add    $0x10,%esp
			break;
  801efa:	e9 bc 00 00 00       	jmp    801fbb <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801eff:	83 ec 08             	sub    $0x8,%esp
  801f02:	ff 75 0c             	pushl  0xc(%ebp)
  801f05:	6a 30                	push   $0x30
  801f07:	8b 45 08             	mov    0x8(%ebp),%eax
  801f0a:	ff d0                	call   *%eax
  801f0c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801f0f:	83 ec 08             	sub    $0x8,%esp
  801f12:	ff 75 0c             	pushl  0xc(%ebp)
  801f15:	6a 78                	push   $0x78
  801f17:	8b 45 08             	mov    0x8(%ebp),%eax
  801f1a:	ff d0                	call   *%eax
  801f1c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801f1f:	8b 45 14             	mov    0x14(%ebp),%eax
  801f22:	83 c0 04             	add    $0x4,%eax
  801f25:	89 45 14             	mov    %eax,0x14(%ebp)
  801f28:	8b 45 14             	mov    0x14(%ebp),%eax
  801f2b:	83 e8 04             	sub    $0x4,%eax
  801f2e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801f30:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801f33:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801f3a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801f41:	eb 1f                	jmp    801f62 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801f43:	83 ec 08             	sub    $0x8,%esp
  801f46:	ff 75 e8             	pushl  -0x18(%ebp)
  801f49:	8d 45 14             	lea    0x14(%ebp),%eax
  801f4c:	50                   	push   %eax
  801f4d:	e8 e7 fb ff ff       	call   801b39 <getuint>
  801f52:	83 c4 10             	add    $0x10,%esp
  801f55:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801f58:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801f5b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801f62:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801f66:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801f69:	83 ec 04             	sub    $0x4,%esp
  801f6c:	52                   	push   %edx
  801f6d:	ff 75 e4             	pushl  -0x1c(%ebp)
  801f70:	50                   	push   %eax
  801f71:	ff 75 f4             	pushl  -0xc(%ebp)
  801f74:	ff 75 f0             	pushl  -0x10(%ebp)
  801f77:	ff 75 0c             	pushl  0xc(%ebp)
  801f7a:	ff 75 08             	pushl  0x8(%ebp)
  801f7d:	e8 00 fb ff ff       	call   801a82 <printnum>
  801f82:	83 c4 20             	add    $0x20,%esp
			break;
  801f85:	eb 34                	jmp    801fbb <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801f87:	83 ec 08             	sub    $0x8,%esp
  801f8a:	ff 75 0c             	pushl  0xc(%ebp)
  801f8d:	53                   	push   %ebx
  801f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f91:	ff d0                	call   *%eax
  801f93:	83 c4 10             	add    $0x10,%esp
			break;
  801f96:	eb 23                	jmp    801fbb <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801f98:	83 ec 08             	sub    $0x8,%esp
  801f9b:	ff 75 0c             	pushl  0xc(%ebp)
  801f9e:	6a 25                	push   $0x25
  801fa0:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa3:	ff d0                	call   *%eax
  801fa5:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801fa8:	ff 4d 10             	decl   0x10(%ebp)
  801fab:	eb 03                	jmp    801fb0 <vprintfmt+0x3b1>
  801fad:	ff 4d 10             	decl   0x10(%ebp)
  801fb0:	8b 45 10             	mov    0x10(%ebp),%eax
  801fb3:	48                   	dec    %eax
  801fb4:	8a 00                	mov    (%eax),%al
  801fb6:	3c 25                	cmp    $0x25,%al
  801fb8:	75 f3                	jne    801fad <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801fba:	90                   	nop
		}
	}
  801fbb:	e9 47 fc ff ff       	jmp    801c07 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801fc0:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801fc1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801fc4:	5b                   	pop    %ebx
  801fc5:	5e                   	pop    %esi
  801fc6:	5d                   	pop    %ebp
  801fc7:	c3                   	ret    

00801fc8 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801fc8:	55                   	push   %ebp
  801fc9:	89 e5                	mov    %esp,%ebp
  801fcb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801fce:	8d 45 10             	lea    0x10(%ebp),%eax
  801fd1:	83 c0 04             	add    $0x4,%eax
  801fd4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801fd7:	8b 45 10             	mov    0x10(%ebp),%eax
  801fda:	ff 75 f4             	pushl  -0xc(%ebp)
  801fdd:	50                   	push   %eax
  801fde:	ff 75 0c             	pushl  0xc(%ebp)
  801fe1:	ff 75 08             	pushl  0x8(%ebp)
  801fe4:	e8 16 fc ff ff       	call   801bff <vprintfmt>
  801fe9:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801fec:	90                   	nop
  801fed:	c9                   	leave  
  801fee:	c3                   	ret    

00801fef <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801fef:	55                   	push   %ebp
  801ff0:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801ff2:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ff5:	8b 40 08             	mov    0x8(%eax),%eax
  801ff8:	8d 50 01             	lea    0x1(%eax),%edx
  801ffb:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ffe:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  802001:	8b 45 0c             	mov    0xc(%ebp),%eax
  802004:	8b 10                	mov    (%eax),%edx
  802006:	8b 45 0c             	mov    0xc(%ebp),%eax
  802009:	8b 40 04             	mov    0x4(%eax),%eax
  80200c:	39 c2                	cmp    %eax,%edx
  80200e:	73 12                	jae    802022 <sprintputch+0x33>
		*b->buf++ = ch;
  802010:	8b 45 0c             	mov    0xc(%ebp),%eax
  802013:	8b 00                	mov    (%eax),%eax
  802015:	8d 48 01             	lea    0x1(%eax),%ecx
  802018:	8b 55 0c             	mov    0xc(%ebp),%edx
  80201b:	89 0a                	mov    %ecx,(%edx)
  80201d:	8b 55 08             	mov    0x8(%ebp),%edx
  802020:	88 10                	mov    %dl,(%eax)
}
  802022:	90                   	nop
  802023:	5d                   	pop    %ebp
  802024:	c3                   	ret    

00802025 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  802025:	55                   	push   %ebp
  802026:	89 e5                	mov    %esp,%ebp
  802028:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80202b:	8b 45 08             	mov    0x8(%ebp),%eax
  80202e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  802031:	8b 45 0c             	mov    0xc(%ebp),%eax
  802034:	8d 50 ff             	lea    -0x1(%eax),%edx
  802037:	8b 45 08             	mov    0x8(%ebp),%eax
  80203a:	01 d0                	add    %edx,%eax
  80203c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80203f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  802046:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80204a:	74 06                	je     802052 <vsnprintf+0x2d>
  80204c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802050:	7f 07                	jg     802059 <vsnprintf+0x34>
		return -E_INVAL;
  802052:	b8 03 00 00 00       	mov    $0x3,%eax
  802057:	eb 20                	jmp    802079 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  802059:	ff 75 14             	pushl  0x14(%ebp)
  80205c:	ff 75 10             	pushl  0x10(%ebp)
  80205f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  802062:	50                   	push   %eax
  802063:	68 ef 1f 80 00       	push   $0x801fef
  802068:	e8 92 fb ff ff       	call   801bff <vprintfmt>
  80206d:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  802070:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802073:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  802076:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  802079:	c9                   	leave  
  80207a:	c3                   	ret    

0080207b <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80207b:	55                   	push   %ebp
  80207c:	89 e5                	mov    %esp,%ebp
  80207e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  802081:	8d 45 10             	lea    0x10(%ebp),%eax
  802084:	83 c0 04             	add    $0x4,%eax
  802087:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80208a:	8b 45 10             	mov    0x10(%ebp),%eax
  80208d:	ff 75 f4             	pushl  -0xc(%ebp)
  802090:	50                   	push   %eax
  802091:	ff 75 0c             	pushl  0xc(%ebp)
  802094:	ff 75 08             	pushl  0x8(%ebp)
  802097:	e8 89 ff ff ff       	call   802025 <vsnprintf>
  80209c:	83 c4 10             	add    $0x10,%esp
  80209f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8020a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8020a5:	c9                   	leave  
  8020a6:	c3                   	ret    

008020a7 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8020a7:	55                   	push   %ebp
  8020a8:	89 e5                	mov    %esp,%ebp
  8020aa:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8020ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8020b4:	eb 06                	jmp    8020bc <strlen+0x15>
		n++;
  8020b6:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8020b9:	ff 45 08             	incl   0x8(%ebp)
  8020bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8020bf:	8a 00                	mov    (%eax),%al
  8020c1:	84 c0                	test   %al,%al
  8020c3:	75 f1                	jne    8020b6 <strlen+0xf>
		n++;
	return n;
  8020c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8020c8:	c9                   	leave  
  8020c9:	c3                   	ret    

008020ca <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8020ca:	55                   	push   %ebp
  8020cb:	89 e5                	mov    %esp,%ebp
  8020cd:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8020d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8020d7:	eb 09                	jmp    8020e2 <strnlen+0x18>
		n++;
  8020d9:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8020dc:	ff 45 08             	incl   0x8(%ebp)
  8020df:	ff 4d 0c             	decl   0xc(%ebp)
  8020e2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8020e6:	74 09                	je     8020f1 <strnlen+0x27>
  8020e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8020eb:	8a 00                	mov    (%eax),%al
  8020ed:	84 c0                	test   %al,%al
  8020ef:	75 e8                	jne    8020d9 <strnlen+0xf>
		n++;
	return n;
  8020f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8020f4:	c9                   	leave  
  8020f5:	c3                   	ret    

008020f6 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8020f6:	55                   	push   %ebp
  8020f7:	89 e5                	mov    %esp,%ebp
  8020f9:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8020fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  802102:	90                   	nop
  802103:	8b 45 08             	mov    0x8(%ebp),%eax
  802106:	8d 50 01             	lea    0x1(%eax),%edx
  802109:	89 55 08             	mov    %edx,0x8(%ebp)
  80210c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80210f:	8d 4a 01             	lea    0x1(%edx),%ecx
  802112:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  802115:	8a 12                	mov    (%edx),%dl
  802117:	88 10                	mov    %dl,(%eax)
  802119:	8a 00                	mov    (%eax),%al
  80211b:	84 c0                	test   %al,%al
  80211d:	75 e4                	jne    802103 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80211f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802122:	c9                   	leave  
  802123:	c3                   	ret    

00802124 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  802124:	55                   	push   %ebp
  802125:	89 e5                	mov    %esp,%ebp
  802127:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80212a:	8b 45 08             	mov    0x8(%ebp),%eax
  80212d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  802130:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802137:	eb 1f                	jmp    802158 <strncpy+0x34>
		*dst++ = *src;
  802139:	8b 45 08             	mov    0x8(%ebp),%eax
  80213c:	8d 50 01             	lea    0x1(%eax),%edx
  80213f:	89 55 08             	mov    %edx,0x8(%ebp)
  802142:	8b 55 0c             	mov    0xc(%ebp),%edx
  802145:	8a 12                	mov    (%edx),%dl
  802147:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  802149:	8b 45 0c             	mov    0xc(%ebp),%eax
  80214c:	8a 00                	mov    (%eax),%al
  80214e:	84 c0                	test   %al,%al
  802150:	74 03                	je     802155 <strncpy+0x31>
			src++;
  802152:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  802155:	ff 45 fc             	incl   -0x4(%ebp)
  802158:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80215b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80215e:	72 d9                	jb     802139 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  802160:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  802163:	c9                   	leave  
  802164:	c3                   	ret    

00802165 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  802165:	55                   	push   %ebp
  802166:	89 e5                	mov    %esp,%ebp
  802168:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80216b:	8b 45 08             	mov    0x8(%ebp),%eax
  80216e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  802171:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802175:	74 30                	je     8021a7 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  802177:	eb 16                	jmp    80218f <strlcpy+0x2a>
			*dst++ = *src++;
  802179:	8b 45 08             	mov    0x8(%ebp),%eax
  80217c:	8d 50 01             	lea    0x1(%eax),%edx
  80217f:	89 55 08             	mov    %edx,0x8(%ebp)
  802182:	8b 55 0c             	mov    0xc(%ebp),%edx
  802185:	8d 4a 01             	lea    0x1(%edx),%ecx
  802188:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80218b:	8a 12                	mov    (%edx),%dl
  80218d:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80218f:	ff 4d 10             	decl   0x10(%ebp)
  802192:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802196:	74 09                	je     8021a1 <strlcpy+0x3c>
  802198:	8b 45 0c             	mov    0xc(%ebp),%eax
  80219b:	8a 00                	mov    (%eax),%al
  80219d:	84 c0                	test   %al,%al
  80219f:	75 d8                	jne    802179 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8021a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8021a4:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8021a7:	8b 55 08             	mov    0x8(%ebp),%edx
  8021aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8021ad:	29 c2                	sub    %eax,%edx
  8021af:	89 d0                	mov    %edx,%eax
}
  8021b1:	c9                   	leave  
  8021b2:	c3                   	ret    

008021b3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8021b3:	55                   	push   %ebp
  8021b4:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8021b6:	eb 06                	jmp    8021be <strcmp+0xb>
		p++, q++;
  8021b8:	ff 45 08             	incl   0x8(%ebp)
  8021bb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8021be:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c1:	8a 00                	mov    (%eax),%al
  8021c3:	84 c0                	test   %al,%al
  8021c5:	74 0e                	je     8021d5 <strcmp+0x22>
  8021c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ca:	8a 10                	mov    (%eax),%dl
  8021cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021cf:	8a 00                	mov    (%eax),%al
  8021d1:	38 c2                	cmp    %al,%dl
  8021d3:	74 e3                	je     8021b8 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8021d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8021d8:	8a 00                	mov    (%eax),%al
  8021da:	0f b6 d0             	movzbl %al,%edx
  8021dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021e0:	8a 00                	mov    (%eax),%al
  8021e2:	0f b6 c0             	movzbl %al,%eax
  8021e5:	29 c2                	sub    %eax,%edx
  8021e7:	89 d0                	mov    %edx,%eax
}
  8021e9:	5d                   	pop    %ebp
  8021ea:	c3                   	ret    

008021eb <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8021eb:	55                   	push   %ebp
  8021ec:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8021ee:	eb 09                	jmp    8021f9 <strncmp+0xe>
		n--, p++, q++;
  8021f0:	ff 4d 10             	decl   0x10(%ebp)
  8021f3:	ff 45 08             	incl   0x8(%ebp)
  8021f6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8021f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8021fd:	74 17                	je     802216 <strncmp+0x2b>
  8021ff:	8b 45 08             	mov    0x8(%ebp),%eax
  802202:	8a 00                	mov    (%eax),%al
  802204:	84 c0                	test   %al,%al
  802206:	74 0e                	je     802216 <strncmp+0x2b>
  802208:	8b 45 08             	mov    0x8(%ebp),%eax
  80220b:	8a 10                	mov    (%eax),%dl
  80220d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802210:	8a 00                	mov    (%eax),%al
  802212:	38 c2                	cmp    %al,%dl
  802214:	74 da                	je     8021f0 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  802216:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80221a:	75 07                	jne    802223 <strncmp+0x38>
		return 0;
  80221c:	b8 00 00 00 00       	mov    $0x0,%eax
  802221:	eb 14                	jmp    802237 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  802223:	8b 45 08             	mov    0x8(%ebp),%eax
  802226:	8a 00                	mov    (%eax),%al
  802228:	0f b6 d0             	movzbl %al,%edx
  80222b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80222e:	8a 00                	mov    (%eax),%al
  802230:	0f b6 c0             	movzbl %al,%eax
  802233:	29 c2                	sub    %eax,%edx
  802235:	89 d0                	mov    %edx,%eax
}
  802237:	5d                   	pop    %ebp
  802238:	c3                   	ret    

00802239 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  802239:	55                   	push   %ebp
  80223a:	89 e5                	mov    %esp,%ebp
  80223c:	83 ec 04             	sub    $0x4,%esp
  80223f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802242:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802245:	eb 12                	jmp    802259 <strchr+0x20>
		if (*s == c)
  802247:	8b 45 08             	mov    0x8(%ebp),%eax
  80224a:	8a 00                	mov    (%eax),%al
  80224c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80224f:	75 05                	jne    802256 <strchr+0x1d>
			return (char *) s;
  802251:	8b 45 08             	mov    0x8(%ebp),%eax
  802254:	eb 11                	jmp    802267 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  802256:	ff 45 08             	incl   0x8(%ebp)
  802259:	8b 45 08             	mov    0x8(%ebp),%eax
  80225c:	8a 00                	mov    (%eax),%al
  80225e:	84 c0                	test   %al,%al
  802260:	75 e5                	jne    802247 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  802262:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802267:	c9                   	leave  
  802268:	c3                   	ret    

00802269 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  802269:	55                   	push   %ebp
  80226a:	89 e5                	mov    %esp,%ebp
  80226c:	83 ec 04             	sub    $0x4,%esp
  80226f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802272:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802275:	eb 0d                	jmp    802284 <strfind+0x1b>
		if (*s == c)
  802277:	8b 45 08             	mov    0x8(%ebp),%eax
  80227a:	8a 00                	mov    (%eax),%al
  80227c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80227f:	74 0e                	je     80228f <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  802281:	ff 45 08             	incl   0x8(%ebp)
  802284:	8b 45 08             	mov    0x8(%ebp),%eax
  802287:	8a 00                	mov    (%eax),%al
  802289:	84 c0                	test   %al,%al
  80228b:	75 ea                	jne    802277 <strfind+0xe>
  80228d:	eb 01                	jmp    802290 <strfind+0x27>
		if (*s == c)
			break;
  80228f:	90                   	nop
	return (char *) s;
  802290:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802293:	c9                   	leave  
  802294:	c3                   	ret    

00802295 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  802295:	55                   	push   %ebp
  802296:	89 e5                	mov    %esp,%ebp
  802298:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80229b:	8b 45 08             	mov    0x8(%ebp),%eax
  80229e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8022a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8022a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8022a7:	eb 0e                	jmp    8022b7 <memset+0x22>
		*p++ = c;
  8022a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8022ac:	8d 50 01             	lea    0x1(%eax),%edx
  8022af:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8022b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022b5:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8022b7:	ff 4d f8             	decl   -0x8(%ebp)
  8022ba:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8022be:	79 e9                	jns    8022a9 <memset+0x14>
		*p++ = c;

	return v;
  8022c0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8022c3:	c9                   	leave  
  8022c4:	c3                   	ret    

008022c5 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8022c5:	55                   	push   %ebp
  8022c6:	89 e5                	mov    %esp,%ebp
  8022c8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8022cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8022ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8022d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8022d4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8022d7:	eb 16                	jmp    8022ef <memcpy+0x2a>
		*d++ = *s++;
  8022d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8022dc:	8d 50 01             	lea    0x1(%eax),%edx
  8022df:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8022e2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8022e5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8022e8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8022eb:	8a 12                	mov    (%edx),%dl
  8022ed:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8022ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8022f2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8022f5:	89 55 10             	mov    %edx,0x10(%ebp)
  8022f8:	85 c0                	test   %eax,%eax
  8022fa:	75 dd                	jne    8022d9 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8022fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8022ff:	c9                   	leave  
  802300:	c3                   	ret    

00802301 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  802301:	55                   	push   %ebp
  802302:	89 e5                	mov    %esp,%ebp
  802304:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  802307:	8b 45 0c             	mov    0xc(%ebp),%eax
  80230a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80230d:	8b 45 08             	mov    0x8(%ebp),%eax
  802310:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  802313:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802316:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  802319:	73 50                	jae    80236b <memmove+0x6a>
  80231b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80231e:	8b 45 10             	mov    0x10(%ebp),%eax
  802321:	01 d0                	add    %edx,%eax
  802323:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  802326:	76 43                	jbe    80236b <memmove+0x6a>
		s += n;
  802328:	8b 45 10             	mov    0x10(%ebp),%eax
  80232b:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80232e:	8b 45 10             	mov    0x10(%ebp),%eax
  802331:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  802334:	eb 10                	jmp    802346 <memmove+0x45>
			*--d = *--s;
  802336:	ff 4d f8             	decl   -0x8(%ebp)
  802339:	ff 4d fc             	decl   -0x4(%ebp)
  80233c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80233f:	8a 10                	mov    (%eax),%dl
  802341:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802344:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  802346:	8b 45 10             	mov    0x10(%ebp),%eax
  802349:	8d 50 ff             	lea    -0x1(%eax),%edx
  80234c:	89 55 10             	mov    %edx,0x10(%ebp)
  80234f:	85 c0                	test   %eax,%eax
  802351:	75 e3                	jne    802336 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  802353:	eb 23                	jmp    802378 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  802355:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802358:	8d 50 01             	lea    0x1(%eax),%edx
  80235b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80235e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802361:	8d 4a 01             	lea    0x1(%edx),%ecx
  802364:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  802367:	8a 12                	mov    (%edx),%dl
  802369:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80236b:	8b 45 10             	mov    0x10(%ebp),%eax
  80236e:	8d 50 ff             	lea    -0x1(%eax),%edx
  802371:	89 55 10             	mov    %edx,0x10(%ebp)
  802374:	85 c0                	test   %eax,%eax
  802376:	75 dd                	jne    802355 <memmove+0x54>
			*d++ = *s++;

	return dst;
  802378:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80237b:	c9                   	leave  
  80237c:	c3                   	ret    

0080237d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80237d:	55                   	push   %ebp
  80237e:	89 e5                	mov    %esp,%ebp
  802380:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  802383:	8b 45 08             	mov    0x8(%ebp),%eax
  802386:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  802389:	8b 45 0c             	mov    0xc(%ebp),%eax
  80238c:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80238f:	eb 2a                	jmp    8023bb <memcmp+0x3e>
		if (*s1 != *s2)
  802391:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802394:	8a 10                	mov    (%eax),%dl
  802396:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802399:	8a 00                	mov    (%eax),%al
  80239b:	38 c2                	cmp    %al,%dl
  80239d:	74 16                	je     8023b5 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80239f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8023a2:	8a 00                	mov    (%eax),%al
  8023a4:	0f b6 d0             	movzbl %al,%edx
  8023a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8023aa:	8a 00                	mov    (%eax),%al
  8023ac:	0f b6 c0             	movzbl %al,%eax
  8023af:	29 c2                	sub    %eax,%edx
  8023b1:	89 d0                	mov    %edx,%eax
  8023b3:	eb 18                	jmp    8023cd <memcmp+0x50>
		s1++, s2++;
  8023b5:	ff 45 fc             	incl   -0x4(%ebp)
  8023b8:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8023bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8023be:	8d 50 ff             	lea    -0x1(%eax),%edx
  8023c1:	89 55 10             	mov    %edx,0x10(%ebp)
  8023c4:	85 c0                	test   %eax,%eax
  8023c6:	75 c9                	jne    802391 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8023c8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023cd:	c9                   	leave  
  8023ce:	c3                   	ret    

008023cf <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8023cf:	55                   	push   %ebp
  8023d0:	89 e5                	mov    %esp,%ebp
  8023d2:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8023d5:	8b 55 08             	mov    0x8(%ebp),%edx
  8023d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8023db:	01 d0                	add    %edx,%eax
  8023dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8023e0:	eb 15                	jmp    8023f7 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8023e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8023e5:	8a 00                	mov    (%eax),%al
  8023e7:	0f b6 d0             	movzbl %al,%edx
  8023ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023ed:	0f b6 c0             	movzbl %al,%eax
  8023f0:	39 c2                	cmp    %eax,%edx
  8023f2:	74 0d                	je     802401 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8023f4:	ff 45 08             	incl   0x8(%ebp)
  8023f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8023fa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8023fd:	72 e3                	jb     8023e2 <memfind+0x13>
  8023ff:	eb 01                	jmp    802402 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  802401:	90                   	nop
	return (void *) s;
  802402:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802405:	c9                   	leave  
  802406:	c3                   	ret    

00802407 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  802407:	55                   	push   %ebp
  802408:	89 e5                	mov    %esp,%ebp
  80240a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80240d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  802414:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80241b:	eb 03                	jmp    802420 <strtol+0x19>
		s++;
  80241d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  802420:	8b 45 08             	mov    0x8(%ebp),%eax
  802423:	8a 00                	mov    (%eax),%al
  802425:	3c 20                	cmp    $0x20,%al
  802427:	74 f4                	je     80241d <strtol+0x16>
  802429:	8b 45 08             	mov    0x8(%ebp),%eax
  80242c:	8a 00                	mov    (%eax),%al
  80242e:	3c 09                	cmp    $0x9,%al
  802430:	74 eb                	je     80241d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  802432:	8b 45 08             	mov    0x8(%ebp),%eax
  802435:	8a 00                	mov    (%eax),%al
  802437:	3c 2b                	cmp    $0x2b,%al
  802439:	75 05                	jne    802440 <strtol+0x39>
		s++;
  80243b:	ff 45 08             	incl   0x8(%ebp)
  80243e:	eb 13                	jmp    802453 <strtol+0x4c>
	else if (*s == '-')
  802440:	8b 45 08             	mov    0x8(%ebp),%eax
  802443:	8a 00                	mov    (%eax),%al
  802445:	3c 2d                	cmp    $0x2d,%al
  802447:	75 0a                	jne    802453 <strtol+0x4c>
		s++, neg = 1;
  802449:	ff 45 08             	incl   0x8(%ebp)
  80244c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  802453:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802457:	74 06                	je     80245f <strtol+0x58>
  802459:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80245d:	75 20                	jne    80247f <strtol+0x78>
  80245f:	8b 45 08             	mov    0x8(%ebp),%eax
  802462:	8a 00                	mov    (%eax),%al
  802464:	3c 30                	cmp    $0x30,%al
  802466:	75 17                	jne    80247f <strtol+0x78>
  802468:	8b 45 08             	mov    0x8(%ebp),%eax
  80246b:	40                   	inc    %eax
  80246c:	8a 00                	mov    (%eax),%al
  80246e:	3c 78                	cmp    $0x78,%al
  802470:	75 0d                	jne    80247f <strtol+0x78>
		s += 2, base = 16;
  802472:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  802476:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80247d:	eb 28                	jmp    8024a7 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80247f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802483:	75 15                	jne    80249a <strtol+0x93>
  802485:	8b 45 08             	mov    0x8(%ebp),%eax
  802488:	8a 00                	mov    (%eax),%al
  80248a:	3c 30                	cmp    $0x30,%al
  80248c:	75 0c                	jne    80249a <strtol+0x93>
		s++, base = 8;
  80248e:	ff 45 08             	incl   0x8(%ebp)
  802491:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  802498:	eb 0d                	jmp    8024a7 <strtol+0xa0>
	else if (base == 0)
  80249a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80249e:	75 07                	jne    8024a7 <strtol+0xa0>
		base = 10;
  8024a0:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8024a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8024aa:	8a 00                	mov    (%eax),%al
  8024ac:	3c 2f                	cmp    $0x2f,%al
  8024ae:	7e 19                	jle    8024c9 <strtol+0xc2>
  8024b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8024b3:	8a 00                	mov    (%eax),%al
  8024b5:	3c 39                	cmp    $0x39,%al
  8024b7:	7f 10                	jg     8024c9 <strtol+0xc2>
			dig = *s - '0';
  8024b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8024bc:	8a 00                	mov    (%eax),%al
  8024be:	0f be c0             	movsbl %al,%eax
  8024c1:	83 e8 30             	sub    $0x30,%eax
  8024c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8024c7:	eb 42                	jmp    80250b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8024c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8024cc:	8a 00                	mov    (%eax),%al
  8024ce:	3c 60                	cmp    $0x60,%al
  8024d0:	7e 19                	jle    8024eb <strtol+0xe4>
  8024d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8024d5:	8a 00                	mov    (%eax),%al
  8024d7:	3c 7a                	cmp    $0x7a,%al
  8024d9:	7f 10                	jg     8024eb <strtol+0xe4>
			dig = *s - 'a' + 10;
  8024db:	8b 45 08             	mov    0x8(%ebp),%eax
  8024de:	8a 00                	mov    (%eax),%al
  8024e0:	0f be c0             	movsbl %al,%eax
  8024e3:	83 e8 57             	sub    $0x57,%eax
  8024e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8024e9:	eb 20                	jmp    80250b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8024eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8024ee:	8a 00                	mov    (%eax),%al
  8024f0:	3c 40                	cmp    $0x40,%al
  8024f2:	7e 39                	jle    80252d <strtol+0x126>
  8024f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8024f7:	8a 00                	mov    (%eax),%al
  8024f9:	3c 5a                	cmp    $0x5a,%al
  8024fb:	7f 30                	jg     80252d <strtol+0x126>
			dig = *s - 'A' + 10;
  8024fd:	8b 45 08             	mov    0x8(%ebp),%eax
  802500:	8a 00                	mov    (%eax),%al
  802502:	0f be c0             	movsbl %al,%eax
  802505:	83 e8 37             	sub    $0x37,%eax
  802508:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80250b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80250e:	3b 45 10             	cmp    0x10(%ebp),%eax
  802511:	7d 19                	jge    80252c <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  802513:	ff 45 08             	incl   0x8(%ebp)
  802516:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802519:	0f af 45 10          	imul   0x10(%ebp),%eax
  80251d:	89 c2                	mov    %eax,%edx
  80251f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802522:	01 d0                	add    %edx,%eax
  802524:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  802527:	e9 7b ff ff ff       	jmp    8024a7 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80252c:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80252d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802531:	74 08                	je     80253b <strtol+0x134>
		*endptr = (char *) s;
  802533:	8b 45 0c             	mov    0xc(%ebp),%eax
  802536:	8b 55 08             	mov    0x8(%ebp),%edx
  802539:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80253b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80253f:	74 07                	je     802548 <strtol+0x141>
  802541:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802544:	f7 d8                	neg    %eax
  802546:	eb 03                	jmp    80254b <strtol+0x144>
  802548:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80254b:	c9                   	leave  
  80254c:	c3                   	ret    

0080254d <ltostr>:

void
ltostr(long value, char *str)
{
  80254d:	55                   	push   %ebp
  80254e:	89 e5                	mov    %esp,%ebp
  802550:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  802553:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80255a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  802561:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802565:	79 13                	jns    80257a <ltostr+0x2d>
	{
		neg = 1;
  802567:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80256e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802571:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  802574:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  802577:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80257a:	8b 45 08             	mov    0x8(%ebp),%eax
  80257d:	b9 0a 00 00 00       	mov    $0xa,%ecx
  802582:	99                   	cltd   
  802583:	f7 f9                	idiv   %ecx
  802585:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  802588:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80258b:	8d 50 01             	lea    0x1(%eax),%edx
  80258e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  802591:	89 c2                	mov    %eax,%edx
  802593:	8b 45 0c             	mov    0xc(%ebp),%eax
  802596:	01 d0                	add    %edx,%eax
  802598:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80259b:	83 c2 30             	add    $0x30,%edx
  80259e:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8025a0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8025a3:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8025a8:	f7 e9                	imul   %ecx
  8025aa:	c1 fa 02             	sar    $0x2,%edx
  8025ad:	89 c8                	mov    %ecx,%eax
  8025af:	c1 f8 1f             	sar    $0x1f,%eax
  8025b2:	29 c2                	sub    %eax,%edx
  8025b4:	89 d0                	mov    %edx,%eax
  8025b6:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8025b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8025bc:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8025c1:	f7 e9                	imul   %ecx
  8025c3:	c1 fa 02             	sar    $0x2,%edx
  8025c6:	89 c8                	mov    %ecx,%eax
  8025c8:	c1 f8 1f             	sar    $0x1f,%eax
  8025cb:	29 c2                	sub    %eax,%edx
  8025cd:	89 d0                	mov    %edx,%eax
  8025cf:	c1 e0 02             	shl    $0x2,%eax
  8025d2:	01 d0                	add    %edx,%eax
  8025d4:	01 c0                	add    %eax,%eax
  8025d6:	29 c1                	sub    %eax,%ecx
  8025d8:	89 ca                	mov    %ecx,%edx
  8025da:	85 d2                	test   %edx,%edx
  8025dc:	75 9c                	jne    80257a <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8025de:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8025e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8025e8:	48                   	dec    %eax
  8025e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8025ec:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8025f0:	74 3d                	je     80262f <ltostr+0xe2>
		start = 1 ;
  8025f2:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8025f9:	eb 34                	jmp    80262f <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8025fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8025fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  802601:	01 d0                	add    %edx,%eax
  802603:	8a 00                	mov    (%eax),%al
  802605:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  802608:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80260b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80260e:	01 c2                	add    %eax,%edx
  802610:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  802613:	8b 45 0c             	mov    0xc(%ebp),%eax
  802616:	01 c8                	add    %ecx,%eax
  802618:	8a 00                	mov    (%eax),%al
  80261a:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80261c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80261f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802622:	01 c2                	add    %eax,%edx
  802624:	8a 45 eb             	mov    -0x15(%ebp),%al
  802627:	88 02                	mov    %al,(%edx)
		start++ ;
  802629:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80262c:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80262f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802632:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802635:	7c c4                	jl     8025fb <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  802637:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80263a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80263d:	01 d0                	add    %edx,%eax
  80263f:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  802642:	90                   	nop
  802643:	c9                   	leave  
  802644:	c3                   	ret    

00802645 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  802645:	55                   	push   %ebp
  802646:	89 e5                	mov    %esp,%ebp
  802648:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80264b:	ff 75 08             	pushl  0x8(%ebp)
  80264e:	e8 54 fa ff ff       	call   8020a7 <strlen>
  802653:	83 c4 04             	add    $0x4,%esp
  802656:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  802659:	ff 75 0c             	pushl  0xc(%ebp)
  80265c:	e8 46 fa ff ff       	call   8020a7 <strlen>
  802661:	83 c4 04             	add    $0x4,%esp
  802664:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  802667:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80266e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802675:	eb 17                	jmp    80268e <strcconcat+0x49>
		final[s] = str1[s] ;
  802677:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80267a:	8b 45 10             	mov    0x10(%ebp),%eax
  80267d:	01 c2                	add    %eax,%edx
  80267f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  802682:	8b 45 08             	mov    0x8(%ebp),%eax
  802685:	01 c8                	add    %ecx,%eax
  802687:	8a 00                	mov    (%eax),%al
  802689:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80268b:	ff 45 fc             	incl   -0x4(%ebp)
  80268e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802691:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  802694:	7c e1                	jl     802677 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  802696:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80269d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8026a4:	eb 1f                	jmp    8026c5 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8026a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8026a9:	8d 50 01             	lea    0x1(%eax),%edx
  8026ac:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8026af:	89 c2                	mov    %eax,%edx
  8026b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8026b4:	01 c2                	add    %eax,%edx
  8026b6:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8026b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8026bc:	01 c8                	add    %ecx,%eax
  8026be:	8a 00                	mov    (%eax),%al
  8026c0:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8026c2:	ff 45 f8             	incl   -0x8(%ebp)
  8026c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8026c8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8026cb:	7c d9                	jl     8026a6 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8026cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8026d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8026d3:	01 d0                	add    %edx,%eax
  8026d5:	c6 00 00             	movb   $0x0,(%eax)
}
  8026d8:	90                   	nop
  8026d9:	c9                   	leave  
  8026da:	c3                   	ret    

008026db <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8026db:	55                   	push   %ebp
  8026dc:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8026de:	8b 45 14             	mov    0x14(%ebp),%eax
  8026e1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8026e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8026ea:	8b 00                	mov    (%eax),%eax
  8026ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8026f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8026f6:	01 d0                	add    %edx,%eax
  8026f8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8026fe:	eb 0c                	jmp    80270c <strsplit+0x31>
			*string++ = 0;
  802700:	8b 45 08             	mov    0x8(%ebp),%eax
  802703:	8d 50 01             	lea    0x1(%eax),%edx
  802706:	89 55 08             	mov    %edx,0x8(%ebp)
  802709:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80270c:	8b 45 08             	mov    0x8(%ebp),%eax
  80270f:	8a 00                	mov    (%eax),%al
  802711:	84 c0                	test   %al,%al
  802713:	74 18                	je     80272d <strsplit+0x52>
  802715:	8b 45 08             	mov    0x8(%ebp),%eax
  802718:	8a 00                	mov    (%eax),%al
  80271a:	0f be c0             	movsbl %al,%eax
  80271d:	50                   	push   %eax
  80271e:	ff 75 0c             	pushl  0xc(%ebp)
  802721:	e8 13 fb ff ff       	call   802239 <strchr>
  802726:	83 c4 08             	add    $0x8,%esp
  802729:	85 c0                	test   %eax,%eax
  80272b:	75 d3                	jne    802700 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80272d:	8b 45 08             	mov    0x8(%ebp),%eax
  802730:	8a 00                	mov    (%eax),%al
  802732:	84 c0                	test   %al,%al
  802734:	74 5a                	je     802790 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  802736:	8b 45 14             	mov    0x14(%ebp),%eax
  802739:	8b 00                	mov    (%eax),%eax
  80273b:	83 f8 0f             	cmp    $0xf,%eax
  80273e:	75 07                	jne    802747 <strsplit+0x6c>
		{
			return 0;
  802740:	b8 00 00 00 00       	mov    $0x0,%eax
  802745:	eb 66                	jmp    8027ad <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  802747:	8b 45 14             	mov    0x14(%ebp),%eax
  80274a:	8b 00                	mov    (%eax),%eax
  80274c:	8d 48 01             	lea    0x1(%eax),%ecx
  80274f:	8b 55 14             	mov    0x14(%ebp),%edx
  802752:	89 0a                	mov    %ecx,(%edx)
  802754:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80275b:	8b 45 10             	mov    0x10(%ebp),%eax
  80275e:	01 c2                	add    %eax,%edx
  802760:	8b 45 08             	mov    0x8(%ebp),%eax
  802763:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  802765:	eb 03                	jmp    80276a <strsplit+0x8f>
			string++;
  802767:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80276a:	8b 45 08             	mov    0x8(%ebp),%eax
  80276d:	8a 00                	mov    (%eax),%al
  80276f:	84 c0                	test   %al,%al
  802771:	74 8b                	je     8026fe <strsplit+0x23>
  802773:	8b 45 08             	mov    0x8(%ebp),%eax
  802776:	8a 00                	mov    (%eax),%al
  802778:	0f be c0             	movsbl %al,%eax
  80277b:	50                   	push   %eax
  80277c:	ff 75 0c             	pushl  0xc(%ebp)
  80277f:	e8 b5 fa ff ff       	call   802239 <strchr>
  802784:	83 c4 08             	add    $0x8,%esp
  802787:	85 c0                	test   %eax,%eax
  802789:	74 dc                	je     802767 <strsplit+0x8c>
			string++;
	}
  80278b:	e9 6e ff ff ff       	jmp    8026fe <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  802790:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  802791:	8b 45 14             	mov    0x14(%ebp),%eax
  802794:	8b 00                	mov    (%eax),%eax
  802796:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80279d:	8b 45 10             	mov    0x10(%ebp),%eax
  8027a0:	01 d0                	add    %edx,%eax
  8027a2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8027a8:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8027ad:	c9                   	leave  
  8027ae:	c3                   	ret    

008027af <malloc>:
int sizeofarray=0;
uint32 addresses[1000];
int changed[1000];
int numOfPages[1000];
void* malloc(uint32 size)
{
  8027af:	55                   	push   %ebp
  8027b0:	89 e5                	mov    %esp,%ebp
  8027b2:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  8027b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8027b8:	c1 e8 0c             	shr    $0xc,%eax
  8027bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  8027be:	8b 45 08             	mov    0x8(%ebp),%eax
  8027c1:	25 ff 0f 00 00       	and    $0xfff,%eax
  8027c6:	85 c0                	test   %eax,%eax
  8027c8:	74 03                	je     8027cd <malloc+0x1e>
			num++;
  8027ca:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  8027cd:	a1 04 40 80 00       	mov    0x804004,%eax
  8027d2:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8027d7:	75 73                	jne    80284c <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  8027d9:	83 ec 08             	sub    $0x8,%esp
  8027dc:	ff 75 08             	pushl  0x8(%ebp)
  8027df:	68 00 00 00 80       	push   $0x80000000
  8027e4:	e8 14 05 00 00       	call   802cfd <sys_allocateMem>
  8027e9:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  8027ec:	a1 04 40 80 00       	mov    0x804004,%eax
  8027f1:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  8027f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8027f7:	c1 e0 0c             	shl    $0xc,%eax
  8027fa:	89 c2                	mov    %eax,%edx
  8027fc:	a1 04 40 80 00       	mov    0x804004,%eax
  802801:	01 d0                	add    %edx,%eax
  802803:	a3 04 40 80 00       	mov    %eax,0x804004
			numOfPages[sizeofarray]=num;
  802808:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80280d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802810:	89 14 85 60 60 80 00 	mov    %edx,0x806060(,%eax,4)
			addresses[sizeofarray]=last_addres;
  802817:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80281c:	8b 15 04 40 80 00    	mov    0x804004,%edx
  802822:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
			changed[sizeofarray]=1;
  802829:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80282e:	c7 04 85 c0 50 80 00 	movl   $0x1,0x8050c0(,%eax,4)
  802835:	01 00 00 00 
			sizeofarray++;
  802839:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80283e:	40                   	inc    %eax
  80283f:	a3 2c 40 80 00       	mov    %eax,0x80402c
			return (void*)return_addres;
  802844:	8b 45 d8             	mov    -0x28(%ebp),%eax
  802847:	e9 71 01 00 00       	jmp    8029bd <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  80284c:	a1 28 40 80 00       	mov    0x804028,%eax
  802851:	85 c0                	test   %eax,%eax
  802853:	75 71                	jne    8028c6 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  802855:	a1 04 40 80 00       	mov    0x804004,%eax
  80285a:	83 ec 08             	sub    $0x8,%esp
  80285d:	ff 75 08             	pushl  0x8(%ebp)
  802860:	50                   	push   %eax
  802861:	e8 97 04 00 00       	call   802cfd <sys_allocateMem>
  802866:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  802869:	a1 04 40 80 00       	mov    0x804004,%eax
  80286e:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  802871:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802874:	c1 e0 0c             	shl    $0xc,%eax
  802877:	89 c2                	mov    %eax,%edx
  802879:	a1 04 40 80 00       	mov    0x804004,%eax
  80287e:	01 d0                	add    %edx,%eax
  802880:	a3 04 40 80 00       	mov    %eax,0x804004
				numOfPages[sizeofarray]=num;
  802885:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80288a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80288d:	89 14 85 60 60 80 00 	mov    %edx,0x806060(,%eax,4)
				addresses[sizeofarray]=return_addres;
  802894:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802899:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80289c:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				changed[sizeofarray]=1;
  8028a3:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8028a8:	c7 04 85 c0 50 80 00 	movl   $0x1,0x8050c0(,%eax,4)
  8028af:	01 00 00 00 
				sizeofarray++;
  8028b3:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8028b8:	40                   	inc    %eax
  8028b9:	a3 2c 40 80 00       	mov    %eax,0x80402c
				return (void*)return_addres;
  8028be:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8028c1:	e9 f7 00 00 00       	jmp    8029bd <malloc+0x20e>
			}
			else{
				int count=0;
  8028c6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  8028cd:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  8028d4:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8028db:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  8028e2:	eb 7c                	jmp    802960 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  8028e4:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  8028eb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8028f2:	eb 1a                	jmp    80290e <malloc+0x15f>
					{
						if(addresses[j]==i)
  8028f4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8028f7:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  8028fe:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  802901:	75 08                	jne    80290b <malloc+0x15c>
						{
							index=j;
  802903:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802906:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  802909:	eb 0d                	jmp    802918 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  80290b:	ff 45 dc             	incl   -0x24(%ebp)
  80290e:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802913:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  802916:	7c dc                	jl     8028f4 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  802918:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  80291c:	75 05                	jne    802923 <malloc+0x174>
					{
						count++;
  80291e:	ff 45 f0             	incl   -0x10(%ebp)
  802921:	eb 36                	jmp    802959 <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  802923:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802926:	8b 04 85 c0 50 80 00 	mov    0x8050c0(,%eax,4),%eax
  80292d:	85 c0                	test   %eax,%eax
  80292f:	75 05                	jne    802936 <malloc+0x187>
						{
							count++;
  802931:	ff 45 f0             	incl   -0x10(%ebp)
  802934:	eb 23                	jmp    802959 <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  802936:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802939:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  80293c:	7d 14                	jge    802952 <malloc+0x1a3>
  80293e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802941:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  802944:	7c 0c                	jl     802952 <malloc+0x1a3>
							{
								min=count;
  802946:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802949:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  80294c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80294f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  802952:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  802959:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  802960:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  802967:	0f 86 77 ff ff ff    	jbe    8028e4 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  80296d:	83 ec 08             	sub    $0x8,%esp
  802970:	ff 75 08             	pushl  0x8(%ebp)
  802973:	ff 75 e4             	pushl  -0x1c(%ebp)
  802976:	e8 82 03 00 00       	call   802cfd <sys_allocateMem>
  80297b:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  80297e:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802983:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802986:	89 14 85 60 60 80 00 	mov    %edx,0x806060(,%eax,4)
				addresses[sizeofarray]=last_addres;
  80298d:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802992:	8b 15 04 40 80 00    	mov    0x804004,%edx
  802998:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				changed[sizeofarray]=1;
  80299f:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8029a4:	c7 04 85 c0 50 80 00 	movl   $0x1,0x8050c0(,%eax,4)
  8029ab:	01 00 00 00 
				sizeofarray++;
  8029af:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8029b4:	40                   	inc    %eax
  8029b5:	a3 2c 40 80 00       	mov    %eax,0x80402c
				return(void*) min_addresss;
  8029ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  8029bd:	c9                   	leave  
  8029be:	c3                   	ret    

008029bf <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8029bf:	55                   	push   %ebp
  8029c0:	89 e5                	mov    %esp,%ebp
  8029c2:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  8029c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8029c8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    int size;
    int is_found=0;
  8029cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  8029d2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8029d9:	eb 30                	jmp    802a0b <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  8029db:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8029de:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  8029e5:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8029e8:	75 1e                	jne    802a08 <free+0x49>
  8029ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8029ed:	8b 04 85 c0 50 80 00 	mov    0x8050c0(,%eax,4),%eax
  8029f4:	83 f8 01             	cmp    $0x1,%eax
  8029f7:	75 0f                	jne    802a08 <free+0x49>
    		is_found=1;
  8029f9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  802a00:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802a03:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  802a06:	eb 0d                	jmp    802a15 <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    int size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  802a08:	ff 45 ec             	incl   -0x14(%ebp)
  802a0b:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802a10:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  802a13:	7c c6                	jl     8029db <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  802a15:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  802a19:	75 3b                	jne    802a56 <free+0x97>
    	size=numOfPages[index]*PAGE_SIZE;
  802a1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802a1e:	8b 04 85 60 60 80 00 	mov    0x806060(,%eax,4),%eax
  802a25:	c1 e0 0c             	shl    $0xc,%eax
  802a28:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  802a2b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802a2e:	83 ec 08             	sub    $0x8,%esp
  802a31:	50                   	push   %eax
  802a32:	ff 75 e8             	pushl  -0x18(%ebp)
  802a35:	e8 a7 02 00 00       	call   802ce1 <sys_freeMem>
  802a3a:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  802a3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802a40:	c7 04 85 c0 50 80 00 	movl   $0x0,0x8050c0(,%eax,4)
  802a47:	00 00 00 00 
    	changes++;
  802a4b:	a1 28 40 80 00       	mov    0x804028,%eax
  802a50:	40                   	inc    %eax
  802a51:	a3 28 40 80 00       	mov    %eax,0x804028
    }


	//refer to the project presentation and documentation for details
}
  802a56:	90                   	nop
  802a57:	c9                   	leave  
  802a58:	c3                   	ret    

00802a59 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  802a59:	55                   	push   %ebp
  802a5a:	89 e5                	mov    %esp,%ebp
  802a5c:	83 ec 18             	sub    $0x18,%esp
  802a5f:	8b 45 10             	mov    0x10(%ebp),%eax
  802a62:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  802a65:	83 ec 04             	sub    $0x4,%esp
  802a68:	68 f0 3b 80 00       	push   $0x803bf0
  802a6d:	68 9f 00 00 00       	push   $0x9f
  802a72:	68 13 3c 80 00       	push   $0x803c13
  802a77:	e8 07 ed ff ff       	call   801783 <_panic>

00802a7c <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  802a7c:	55                   	push   %ebp
  802a7d:	89 e5                	mov    %esp,%ebp
  802a7f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802a82:	83 ec 04             	sub    $0x4,%esp
  802a85:	68 f0 3b 80 00       	push   $0x803bf0
  802a8a:	68 a5 00 00 00       	push   $0xa5
  802a8f:	68 13 3c 80 00       	push   $0x803c13
  802a94:	e8 ea ec ff ff       	call   801783 <_panic>

00802a99 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  802a99:	55                   	push   %ebp
  802a9a:	89 e5                	mov    %esp,%ebp
  802a9c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802a9f:	83 ec 04             	sub    $0x4,%esp
  802aa2:	68 f0 3b 80 00       	push   $0x803bf0
  802aa7:	68 ab 00 00 00       	push   $0xab
  802aac:	68 13 3c 80 00       	push   $0x803c13
  802ab1:	e8 cd ec ff ff       	call   801783 <_panic>

00802ab6 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  802ab6:	55                   	push   %ebp
  802ab7:	89 e5                	mov    %esp,%ebp
  802ab9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802abc:	83 ec 04             	sub    $0x4,%esp
  802abf:	68 f0 3b 80 00       	push   $0x803bf0
  802ac4:	68 b0 00 00 00       	push   $0xb0
  802ac9:	68 13 3c 80 00       	push   $0x803c13
  802ace:	e8 b0 ec ff ff       	call   801783 <_panic>

00802ad3 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  802ad3:	55                   	push   %ebp
  802ad4:	89 e5                	mov    %esp,%ebp
  802ad6:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802ad9:	83 ec 04             	sub    $0x4,%esp
  802adc:	68 f0 3b 80 00       	push   $0x803bf0
  802ae1:	68 b6 00 00 00       	push   $0xb6
  802ae6:	68 13 3c 80 00       	push   $0x803c13
  802aeb:	e8 93 ec ff ff       	call   801783 <_panic>

00802af0 <shrink>:
}
void shrink(uint32 newSize)
{
  802af0:	55                   	push   %ebp
  802af1:	89 e5                	mov    %esp,%ebp
  802af3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802af6:	83 ec 04             	sub    $0x4,%esp
  802af9:	68 f0 3b 80 00       	push   $0x803bf0
  802afe:	68 ba 00 00 00       	push   $0xba
  802b03:	68 13 3c 80 00       	push   $0x803c13
  802b08:	e8 76 ec ff ff       	call   801783 <_panic>

00802b0d <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  802b0d:	55                   	push   %ebp
  802b0e:	89 e5                	mov    %esp,%ebp
  802b10:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b13:	83 ec 04             	sub    $0x4,%esp
  802b16:	68 f0 3b 80 00       	push   $0x803bf0
  802b1b:	68 bf 00 00 00       	push   $0xbf
  802b20:	68 13 3c 80 00       	push   $0x803c13
  802b25:	e8 59 ec ff ff       	call   801783 <_panic>

00802b2a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  802b2a:	55                   	push   %ebp
  802b2b:	89 e5                	mov    %esp,%ebp
  802b2d:	57                   	push   %edi
  802b2e:	56                   	push   %esi
  802b2f:	53                   	push   %ebx
  802b30:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802b33:	8b 45 08             	mov    0x8(%ebp),%eax
  802b36:	8b 55 0c             	mov    0xc(%ebp),%edx
  802b39:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802b3c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802b3f:	8b 7d 18             	mov    0x18(%ebp),%edi
  802b42:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802b45:	cd 30                	int    $0x30
  802b47:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802b4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802b4d:	83 c4 10             	add    $0x10,%esp
  802b50:	5b                   	pop    %ebx
  802b51:	5e                   	pop    %esi
  802b52:	5f                   	pop    %edi
  802b53:	5d                   	pop    %ebp
  802b54:	c3                   	ret    

00802b55 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802b55:	55                   	push   %ebp
  802b56:	89 e5                	mov    %esp,%ebp
  802b58:	83 ec 04             	sub    $0x4,%esp
  802b5b:	8b 45 10             	mov    0x10(%ebp),%eax
  802b5e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802b61:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802b65:	8b 45 08             	mov    0x8(%ebp),%eax
  802b68:	6a 00                	push   $0x0
  802b6a:	6a 00                	push   $0x0
  802b6c:	52                   	push   %edx
  802b6d:	ff 75 0c             	pushl  0xc(%ebp)
  802b70:	50                   	push   %eax
  802b71:	6a 00                	push   $0x0
  802b73:	e8 b2 ff ff ff       	call   802b2a <syscall>
  802b78:	83 c4 18             	add    $0x18,%esp
}
  802b7b:	90                   	nop
  802b7c:	c9                   	leave  
  802b7d:	c3                   	ret    

00802b7e <sys_cgetc>:

int
sys_cgetc(void)
{
  802b7e:	55                   	push   %ebp
  802b7f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802b81:	6a 00                	push   $0x0
  802b83:	6a 00                	push   $0x0
  802b85:	6a 00                	push   $0x0
  802b87:	6a 00                	push   $0x0
  802b89:	6a 00                	push   $0x0
  802b8b:	6a 01                	push   $0x1
  802b8d:	e8 98 ff ff ff       	call   802b2a <syscall>
  802b92:	83 c4 18             	add    $0x18,%esp
}
  802b95:	c9                   	leave  
  802b96:	c3                   	ret    

00802b97 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802b97:	55                   	push   %ebp
  802b98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  802b9d:	6a 00                	push   $0x0
  802b9f:	6a 00                	push   $0x0
  802ba1:	6a 00                	push   $0x0
  802ba3:	6a 00                	push   $0x0
  802ba5:	50                   	push   %eax
  802ba6:	6a 05                	push   $0x5
  802ba8:	e8 7d ff ff ff       	call   802b2a <syscall>
  802bad:	83 c4 18             	add    $0x18,%esp
}
  802bb0:	c9                   	leave  
  802bb1:	c3                   	ret    

00802bb2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802bb2:	55                   	push   %ebp
  802bb3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802bb5:	6a 00                	push   $0x0
  802bb7:	6a 00                	push   $0x0
  802bb9:	6a 00                	push   $0x0
  802bbb:	6a 00                	push   $0x0
  802bbd:	6a 00                	push   $0x0
  802bbf:	6a 02                	push   $0x2
  802bc1:	e8 64 ff ff ff       	call   802b2a <syscall>
  802bc6:	83 c4 18             	add    $0x18,%esp
}
  802bc9:	c9                   	leave  
  802bca:	c3                   	ret    

00802bcb <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802bcb:	55                   	push   %ebp
  802bcc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802bce:	6a 00                	push   $0x0
  802bd0:	6a 00                	push   $0x0
  802bd2:	6a 00                	push   $0x0
  802bd4:	6a 00                	push   $0x0
  802bd6:	6a 00                	push   $0x0
  802bd8:	6a 03                	push   $0x3
  802bda:	e8 4b ff ff ff       	call   802b2a <syscall>
  802bdf:	83 c4 18             	add    $0x18,%esp
}
  802be2:	c9                   	leave  
  802be3:	c3                   	ret    

00802be4 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802be4:	55                   	push   %ebp
  802be5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802be7:	6a 00                	push   $0x0
  802be9:	6a 00                	push   $0x0
  802beb:	6a 00                	push   $0x0
  802bed:	6a 00                	push   $0x0
  802bef:	6a 00                	push   $0x0
  802bf1:	6a 04                	push   $0x4
  802bf3:	e8 32 ff ff ff       	call   802b2a <syscall>
  802bf8:	83 c4 18             	add    $0x18,%esp
}
  802bfb:	c9                   	leave  
  802bfc:	c3                   	ret    

00802bfd <sys_env_exit>:


void sys_env_exit(void)
{
  802bfd:	55                   	push   %ebp
  802bfe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802c00:	6a 00                	push   $0x0
  802c02:	6a 00                	push   $0x0
  802c04:	6a 00                	push   $0x0
  802c06:	6a 00                	push   $0x0
  802c08:	6a 00                	push   $0x0
  802c0a:	6a 06                	push   $0x6
  802c0c:	e8 19 ff ff ff       	call   802b2a <syscall>
  802c11:	83 c4 18             	add    $0x18,%esp
}
  802c14:	90                   	nop
  802c15:	c9                   	leave  
  802c16:	c3                   	ret    

00802c17 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802c17:	55                   	push   %ebp
  802c18:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802c1a:	8b 55 0c             	mov    0xc(%ebp),%edx
  802c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  802c20:	6a 00                	push   $0x0
  802c22:	6a 00                	push   $0x0
  802c24:	6a 00                	push   $0x0
  802c26:	52                   	push   %edx
  802c27:	50                   	push   %eax
  802c28:	6a 07                	push   $0x7
  802c2a:	e8 fb fe ff ff       	call   802b2a <syscall>
  802c2f:	83 c4 18             	add    $0x18,%esp
}
  802c32:	c9                   	leave  
  802c33:	c3                   	ret    

00802c34 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802c34:	55                   	push   %ebp
  802c35:	89 e5                	mov    %esp,%ebp
  802c37:	56                   	push   %esi
  802c38:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802c39:	8b 75 18             	mov    0x18(%ebp),%esi
  802c3c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802c3f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802c42:	8b 55 0c             	mov    0xc(%ebp),%edx
  802c45:	8b 45 08             	mov    0x8(%ebp),%eax
  802c48:	56                   	push   %esi
  802c49:	53                   	push   %ebx
  802c4a:	51                   	push   %ecx
  802c4b:	52                   	push   %edx
  802c4c:	50                   	push   %eax
  802c4d:	6a 08                	push   $0x8
  802c4f:	e8 d6 fe ff ff       	call   802b2a <syscall>
  802c54:	83 c4 18             	add    $0x18,%esp
}
  802c57:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802c5a:	5b                   	pop    %ebx
  802c5b:	5e                   	pop    %esi
  802c5c:	5d                   	pop    %ebp
  802c5d:	c3                   	ret    

00802c5e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802c5e:	55                   	push   %ebp
  802c5f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802c61:	8b 55 0c             	mov    0xc(%ebp),%edx
  802c64:	8b 45 08             	mov    0x8(%ebp),%eax
  802c67:	6a 00                	push   $0x0
  802c69:	6a 00                	push   $0x0
  802c6b:	6a 00                	push   $0x0
  802c6d:	52                   	push   %edx
  802c6e:	50                   	push   %eax
  802c6f:	6a 09                	push   $0x9
  802c71:	e8 b4 fe ff ff       	call   802b2a <syscall>
  802c76:	83 c4 18             	add    $0x18,%esp
}
  802c79:	c9                   	leave  
  802c7a:	c3                   	ret    

00802c7b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802c7b:	55                   	push   %ebp
  802c7c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802c7e:	6a 00                	push   $0x0
  802c80:	6a 00                	push   $0x0
  802c82:	6a 00                	push   $0x0
  802c84:	ff 75 0c             	pushl  0xc(%ebp)
  802c87:	ff 75 08             	pushl  0x8(%ebp)
  802c8a:	6a 0a                	push   $0xa
  802c8c:	e8 99 fe ff ff       	call   802b2a <syscall>
  802c91:	83 c4 18             	add    $0x18,%esp
}
  802c94:	c9                   	leave  
  802c95:	c3                   	ret    

00802c96 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802c96:	55                   	push   %ebp
  802c97:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802c99:	6a 00                	push   $0x0
  802c9b:	6a 00                	push   $0x0
  802c9d:	6a 00                	push   $0x0
  802c9f:	6a 00                	push   $0x0
  802ca1:	6a 00                	push   $0x0
  802ca3:	6a 0b                	push   $0xb
  802ca5:	e8 80 fe ff ff       	call   802b2a <syscall>
  802caa:	83 c4 18             	add    $0x18,%esp
}
  802cad:	c9                   	leave  
  802cae:	c3                   	ret    

00802caf <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802caf:	55                   	push   %ebp
  802cb0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802cb2:	6a 00                	push   $0x0
  802cb4:	6a 00                	push   $0x0
  802cb6:	6a 00                	push   $0x0
  802cb8:	6a 00                	push   $0x0
  802cba:	6a 00                	push   $0x0
  802cbc:	6a 0c                	push   $0xc
  802cbe:	e8 67 fe ff ff       	call   802b2a <syscall>
  802cc3:	83 c4 18             	add    $0x18,%esp
}
  802cc6:	c9                   	leave  
  802cc7:	c3                   	ret    

00802cc8 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802cc8:	55                   	push   %ebp
  802cc9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802ccb:	6a 00                	push   $0x0
  802ccd:	6a 00                	push   $0x0
  802ccf:	6a 00                	push   $0x0
  802cd1:	6a 00                	push   $0x0
  802cd3:	6a 00                	push   $0x0
  802cd5:	6a 0d                	push   $0xd
  802cd7:	e8 4e fe ff ff       	call   802b2a <syscall>
  802cdc:	83 c4 18             	add    $0x18,%esp
}
  802cdf:	c9                   	leave  
  802ce0:	c3                   	ret    

00802ce1 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802ce1:	55                   	push   %ebp
  802ce2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802ce4:	6a 00                	push   $0x0
  802ce6:	6a 00                	push   $0x0
  802ce8:	6a 00                	push   $0x0
  802cea:	ff 75 0c             	pushl  0xc(%ebp)
  802ced:	ff 75 08             	pushl  0x8(%ebp)
  802cf0:	6a 11                	push   $0x11
  802cf2:	e8 33 fe ff ff       	call   802b2a <syscall>
  802cf7:	83 c4 18             	add    $0x18,%esp
	return;
  802cfa:	90                   	nop
}
  802cfb:	c9                   	leave  
  802cfc:	c3                   	ret    

00802cfd <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802cfd:	55                   	push   %ebp
  802cfe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802d00:	6a 00                	push   $0x0
  802d02:	6a 00                	push   $0x0
  802d04:	6a 00                	push   $0x0
  802d06:	ff 75 0c             	pushl  0xc(%ebp)
  802d09:	ff 75 08             	pushl  0x8(%ebp)
  802d0c:	6a 12                	push   $0x12
  802d0e:	e8 17 fe ff ff       	call   802b2a <syscall>
  802d13:	83 c4 18             	add    $0x18,%esp
	return ;
  802d16:	90                   	nop
}
  802d17:	c9                   	leave  
  802d18:	c3                   	ret    

00802d19 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802d19:	55                   	push   %ebp
  802d1a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802d1c:	6a 00                	push   $0x0
  802d1e:	6a 00                	push   $0x0
  802d20:	6a 00                	push   $0x0
  802d22:	6a 00                	push   $0x0
  802d24:	6a 00                	push   $0x0
  802d26:	6a 0e                	push   $0xe
  802d28:	e8 fd fd ff ff       	call   802b2a <syscall>
  802d2d:	83 c4 18             	add    $0x18,%esp
}
  802d30:	c9                   	leave  
  802d31:	c3                   	ret    

00802d32 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802d32:	55                   	push   %ebp
  802d33:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802d35:	6a 00                	push   $0x0
  802d37:	6a 00                	push   $0x0
  802d39:	6a 00                	push   $0x0
  802d3b:	6a 00                	push   $0x0
  802d3d:	ff 75 08             	pushl  0x8(%ebp)
  802d40:	6a 0f                	push   $0xf
  802d42:	e8 e3 fd ff ff       	call   802b2a <syscall>
  802d47:	83 c4 18             	add    $0x18,%esp
}
  802d4a:	c9                   	leave  
  802d4b:	c3                   	ret    

00802d4c <sys_scarce_memory>:

void sys_scarce_memory()
{
  802d4c:	55                   	push   %ebp
  802d4d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802d4f:	6a 00                	push   $0x0
  802d51:	6a 00                	push   $0x0
  802d53:	6a 00                	push   $0x0
  802d55:	6a 00                	push   $0x0
  802d57:	6a 00                	push   $0x0
  802d59:	6a 10                	push   $0x10
  802d5b:	e8 ca fd ff ff       	call   802b2a <syscall>
  802d60:	83 c4 18             	add    $0x18,%esp
}
  802d63:	90                   	nop
  802d64:	c9                   	leave  
  802d65:	c3                   	ret    

00802d66 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802d66:	55                   	push   %ebp
  802d67:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802d69:	6a 00                	push   $0x0
  802d6b:	6a 00                	push   $0x0
  802d6d:	6a 00                	push   $0x0
  802d6f:	6a 00                	push   $0x0
  802d71:	6a 00                	push   $0x0
  802d73:	6a 14                	push   $0x14
  802d75:	e8 b0 fd ff ff       	call   802b2a <syscall>
  802d7a:	83 c4 18             	add    $0x18,%esp
}
  802d7d:	90                   	nop
  802d7e:	c9                   	leave  
  802d7f:	c3                   	ret    

00802d80 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802d80:	55                   	push   %ebp
  802d81:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802d83:	6a 00                	push   $0x0
  802d85:	6a 00                	push   $0x0
  802d87:	6a 00                	push   $0x0
  802d89:	6a 00                	push   $0x0
  802d8b:	6a 00                	push   $0x0
  802d8d:	6a 15                	push   $0x15
  802d8f:	e8 96 fd ff ff       	call   802b2a <syscall>
  802d94:	83 c4 18             	add    $0x18,%esp
}
  802d97:	90                   	nop
  802d98:	c9                   	leave  
  802d99:	c3                   	ret    

00802d9a <sys_cputc>:


void
sys_cputc(const char c)
{
  802d9a:	55                   	push   %ebp
  802d9b:	89 e5                	mov    %esp,%ebp
  802d9d:	83 ec 04             	sub    $0x4,%esp
  802da0:	8b 45 08             	mov    0x8(%ebp),%eax
  802da3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802da6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802daa:	6a 00                	push   $0x0
  802dac:	6a 00                	push   $0x0
  802dae:	6a 00                	push   $0x0
  802db0:	6a 00                	push   $0x0
  802db2:	50                   	push   %eax
  802db3:	6a 16                	push   $0x16
  802db5:	e8 70 fd ff ff       	call   802b2a <syscall>
  802dba:	83 c4 18             	add    $0x18,%esp
}
  802dbd:	90                   	nop
  802dbe:	c9                   	leave  
  802dbf:	c3                   	ret    

00802dc0 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802dc0:	55                   	push   %ebp
  802dc1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802dc3:	6a 00                	push   $0x0
  802dc5:	6a 00                	push   $0x0
  802dc7:	6a 00                	push   $0x0
  802dc9:	6a 00                	push   $0x0
  802dcb:	6a 00                	push   $0x0
  802dcd:	6a 17                	push   $0x17
  802dcf:	e8 56 fd ff ff       	call   802b2a <syscall>
  802dd4:	83 c4 18             	add    $0x18,%esp
}
  802dd7:	90                   	nop
  802dd8:	c9                   	leave  
  802dd9:	c3                   	ret    

00802dda <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802dda:	55                   	push   %ebp
  802ddb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802ddd:	8b 45 08             	mov    0x8(%ebp),%eax
  802de0:	6a 00                	push   $0x0
  802de2:	6a 00                	push   $0x0
  802de4:	6a 00                	push   $0x0
  802de6:	ff 75 0c             	pushl  0xc(%ebp)
  802de9:	50                   	push   %eax
  802dea:	6a 18                	push   $0x18
  802dec:	e8 39 fd ff ff       	call   802b2a <syscall>
  802df1:	83 c4 18             	add    $0x18,%esp
}
  802df4:	c9                   	leave  
  802df5:	c3                   	ret    

00802df6 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802df6:	55                   	push   %ebp
  802df7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802df9:	8b 55 0c             	mov    0xc(%ebp),%edx
  802dfc:	8b 45 08             	mov    0x8(%ebp),%eax
  802dff:	6a 00                	push   $0x0
  802e01:	6a 00                	push   $0x0
  802e03:	6a 00                	push   $0x0
  802e05:	52                   	push   %edx
  802e06:	50                   	push   %eax
  802e07:	6a 1b                	push   $0x1b
  802e09:	e8 1c fd ff ff       	call   802b2a <syscall>
  802e0e:	83 c4 18             	add    $0x18,%esp
}
  802e11:	c9                   	leave  
  802e12:	c3                   	ret    

00802e13 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802e13:	55                   	push   %ebp
  802e14:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802e16:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e19:	8b 45 08             	mov    0x8(%ebp),%eax
  802e1c:	6a 00                	push   $0x0
  802e1e:	6a 00                	push   $0x0
  802e20:	6a 00                	push   $0x0
  802e22:	52                   	push   %edx
  802e23:	50                   	push   %eax
  802e24:	6a 19                	push   $0x19
  802e26:	e8 ff fc ff ff       	call   802b2a <syscall>
  802e2b:	83 c4 18             	add    $0x18,%esp
}
  802e2e:	90                   	nop
  802e2f:	c9                   	leave  
  802e30:	c3                   	ret    

00802e31 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802e31:	55                   	push   %ebp
  802e32:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802e34:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e37:	8b 45 08             	mov    0x8(%ebp),%eax
  802e3a:	6a 00                	push   $0x0
  802e3c:	6a 00                	push   $0x0
  802e3e:	6a 00                	push   $0x0
  802e40:	52                   	push   %edx
  802e41:	50                   	push   %eax
  802e42:	6a 1a                	push   $0x1a
  802e44:	e8 e1 fc ff ff       	call   802b2a <syscall>
  802e49:	83 c4 18             	add    $0x18,%esp
}
  802e4c:	90                   	nop
  802e4d:	c9                   	leave  
  802e4e:	c3                   	ret    

00802e4f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802e4f:	55                   	push   %ebp
  802e50:	89 e5                	mov    %esp,%ebp
  802e52:	83 ec 04             	sub    $0x4,%esp
  802e55:	8b 45 10             	mov    0x10(%ebp),%eax
  802e58:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802e5b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802e5e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802e62:	8b 45 08             	mov    0x8(%ebp),%eax
  802e65:	6a 00                	push   $0x0
  802e67:	51                   	push   %ecx
  802e68:	52                   	push   %edx
  802e69:	ff 75 0c             	pushl  0xc(%ebp)
  802e6c:	50                   	push   %eax
  802e6d:	6a 1c                	push   $0x1c
  802e6f:	e8 b6 fc ff ff       	call   802b2a <syscall>
  802e74:	83 c4 18             	add    $0x18,%esp
}
  802e77:	c9                   	leave  
  802e78:	c3                   	ret    

00802e79 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802e79:	55                   	push   %ebp
  802e7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802e7c:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e7f:	8b 45 08             	mov    0x8(%ebp),%eax
  802e82:	6a 00                	push   $0x0
  802e84:	6a 00                	push   $0x0
  802e86:	6a 00                	push   $0x0
  802e88:	52                   	push   %edx
  802e89:	50                   	push   %eax
  802e8a:	6a 1d                	push   $0x1d
  802e8c:	e8 99 fc ff ff       	call   802b2a <syscall>
  802e91:	83 c4 18             	add    $0x18,%esp
}
  802e94:	c9                   	leave  
  802e95:	c3                   	ret    

00802e96 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802e96:	55                   	push   %ebp
  802e97:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802e99:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802e9c:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e9f:	8b 45 08             	mov    0x8(%ebp),%eax
  802ea2:	6a 00                	push   $0x0
  802ea4:	6a 00                	push   $0x0
  802ea6:	51                   	push   %ecx
  802ea7:	52                   	push   %edx
  802ea8:	50                   	push   %eax
  802ea9:	6a 1e                	push   $0x1e
  802eab:	e8 7a fc ff ff       	call   802b2a <syscall>
  802eb0:	83 c4 18             	add    $0x18,%esp
}
  802eb3:	c9                   	leave  
  802eb4:	c3                   	ret    

00802eb5 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802eb5:	55                   	push   %ebp
  802eb6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802eb8:	8b 55 0c             	mov    0xc(%ebp),%edx
  802ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  802ebe:	6a 00                	push   $0x0
  802ec0:	6a 00                	push   $0x0
  802ec2:	6a 00                	push   $0x0
  802ec4:	52                   	push   %edx
  802ec5:	50                   	push   %eax
  802ec6:	6a 1f                	push   $0x1f
  802ec8:	e8 5d fc ff ff       	call   802b2a <syscall>
  802ecd:	83 c4 18             	add    $0x18,%esp
}
  802ed0:	c9                   	leave  
  802ed1:	c3                   	ret    

00802ed2 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802ed2:	55                   	push   %ebp
  802ed3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802ed5:	6a 00                	push   $0x0
  802ed7:	6a 00                	push   $0x0
  802ed9:	6a 00                	push   $0x0
  802edb:	6a 00                	push   $0x0
  802edd:	6a 00                	push   $0x0
  802edf:	6a 20                	push   $0x20
  802ee1:	e8 44 fc ff ff       	call   802b2a <syscall>
  802ee6:	83 c4 18             	add    $0x18,%esp
}
  802ee9:	c9                   	leave  
  802eea:	c3                   	ret    

00802eeb <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802eeb:	55                   	push   %ebp
  802eec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802eee:	8b 45 08             	mov    0x8(%ebp),%eax
  802ef1:	6a 00                	push   $0x0
  802ef3:	ff 75 14             	pushl  0x14(%ebp)
  802ef6:	ff 75 10             	pushl  0x10(%ebp)
  802ef9:	ff 75 0c             	pushl  0xc(%ebp)
  802efc:	50                   	push   %eax
  802efd:	6a 21                	push   $0x21
  802eff:	e8 26 fc ff ff       	call   802b2a <syscall>
  802f04:	83 c4 18             	add    $0x18,%esp
}
  802f07:	c9                   	leave  
  802f08:	c3                   	ret    

00802f09 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802f09:	55                   	push   %ebp
  802f0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802f0c:	8b 45 08             	mov    0x8(%ebp),%eax
  802f0f:	6a 00                	push   $0x0
  802f11:	6a 00                	push   $0x0
  802f13:	6a 00                	push   $0x0
  802f15:	6a 00                	push   $0x0
  802f17:	50                   	push   %eax
  802f18:	6a 22                	push   $0x22
  802f1a:	e8 0b fc ff ff       	call   802b2a <syscall>
  802f1f:	83 c4 18             	add    $0x18,%esp
}
  802f22:	90                   	nop
  802f23:	c9                   	leave  
  802f24:	c3                   	ret    

00802f25 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802f25:	55                   	push   %ebp
  802f26:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802f28:	8b 45 08             	mov    0x8(%ebp),%eax
  802f2b:	6a 00                	push   $0x0
  802f2d:	6a 00                	push   $0x0
  802f2f:	6a 00                	push   $0x0
  802f31:	6a 00                	push   $0x0
  802f33:	50                   	push   %eax
  802f34:	6a 23                	push   $0x23
  802f36:	e8 ef fb ff ff       	call   802b2a <syscall>
  802f3b:	83 c4 18             	add    $0x18,%esp
}
  802f3e:	90                   	nop
  802f3f:	c9                   	leave  
  802f40:	c3                   	ret    

00802f41 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802f41:	55                   	push   %ebp
  802f42:	89 e5                	mov    %esp,%ebp
  802f44:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802f47:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802f4a:	8d 50 04             	lea    0x4(%eax),%edx
  802f4d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802f50:	6a 00                	push   $0x0
  802f52:	6a 00                	push   $0x0
  802f54:	6a 00                	push   $0x0
  802f56:	52                   	push   %edx
  802f57:	50                   	push   %eax
  802f58:	6a 24                	push   $0x24
  802f5a:	e8 cb fb ff ff       	call   802b2a <syscall>
  802f5f:	83 c4 18             	add    $0x18,%esp
	return result;
  802f62:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802f65:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802f68:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802f6b:	89 01                	mov    %eax,(%ecx)
  802f6d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802f70:	8b 45 08             	mov    0x8(%ebp),%eax
  802f73:	c9                   	leave  
  802f74:	c2 04 00             	ret    $0x4

00802f77 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802f77:	55                   	push   %ebp
  802f78:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802f7a:	6a 00                	push   $0x0
  802f7c:	6a 00                	push   $0x0
  802f7e:	ff 75 10             	pushl  0x10(%ebp)
  802f81:	ff 75 0c             	pushl  0xc(%ebp)
  802f84:	ff 75 08             	pushl  0x8(%ebp)
  802f87:	6a 13                	push   $0x13
  802f89:	e8 9c fb ff ff       	call   802b2a <syscall>
  802f8e:	83 c4 18             	add    $0x18,%esp
	return ;
  802f91:	90                   	nop
}
  802f92:	c9                   	leave  
  802f93:	c3                   	ret    

00802f94 <sys_rcr2>:
uint32 sys_rcr2()
{
  802f94:	55                   	push   %ebp
  802f95:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802f97:	6a 00                	push   $0x0
  802f99:	6a 00                	push   $0x0
  802f9b:	6a 00                	push   $0x0
  802f9d:	6a 00                	push   $0x0
  802f9f:	6a 00                	push   $0x0
  802fa1:	6a 25                	push   $0x25
  802fa3:	e8 82 fb ff ff       	call   802b2a <syscall>
  802fa8:	83 c4 18             	add    $0x18,%esp
}
  802fab:	c9                   	leave  
  802fac:	c3                   	ret    

00802fad <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802fad:	55                   	push   %ebp
  802fae:	89 e5                	mov    %esp,%ebp
  802fb0:	83 ec 04             	sub    $0x4,%esp
  802fb3:	8b 45 08             	mov    0x8(%ebp),%eax
  802fb6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802fb9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802fbd:	6a 00                	push   $0x0
  802fbf:	6a 00                	push   $0x0
  802fc1:	6a 00                	push   $0x0
  802fc3:	6a 00                	push   $0x0
  802fc5:	50                   	push   %eax
  802fc6:	6a 26                	push   $0x26
  802fc8:	e8 5d fb ff ff       	call   802b2a <syscall>
  802fcd:	83 c4 18             	add    $0x18,%esp
	return ;
  802fd0:	90                   	nop
}
  802fd1:	c9                   	leave  
  802fd2:	c3                   	ret    

00802fd3 <rsttst>:
void rsttst()
{
  802fd3:	55                   	push   %ebp
  802fd4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802fd6:	6a 00                	push   $0x0
  802fd8:	6a 00                	push   $0x0
  802fda:	6a 00                	push   $0x0
  802fdc:	6a 00                	push   $0x0
  802fde:	6a 00                	push   $0x0
  802fe0:	6a 28                	push   $0x28
  802fe2:	e8 43 fb ff ff       	call   802b2a <syscall>
  802fe7:	83 c4 18             	add    $0x18,%esp
	return ;
  802fea:	90                   	nop
}
  802feb:	c9                   	leave  
  802fec:	c3                   	ret    

00802fed <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802fed:	55                   	push   %ebp
  802fee:	89 e5                	mov    %esp,%ebp
  802ff0:	83 ec 04             	sub    $0x4,%esp
  802ff3:	8b 45 14             	mov    0x14(%ebp),%eax
  802ff6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802ff9:	8b 55 18             	mov    0x18(%ebp),%edx
  802ffc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  803000:	52                   	push   %edx
  803001:	50                   	push   %eax
  803002:	ff 75 10             	pushl  0x10(%ebp)
  803005:	ff 75 0c             	pushl  0xc(%ebp)
  803008:	ff 75 08             	pushl  0x8(%ebp)
  80300b:	6a 27                	push   $0x27
  80300d:	e8 18 fb ff ff       	call   802b2a <syscall>
  803012:	83 c4 18             	add    $0x18,%esp
	return ;
  803015:	90                   	nop
}
  803016:	c9                   	leave  
  803017:	c3                   	ret    

00803018 <chktst>:
void chktst(uint32 n)
{
  803018:	55                   	push   %ebp
  803019:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80301b:	6a 00                	push   $0x0
  80301d:	6a 00                	push   $0x0
  80301f:	6a 00                	push   $0x0
  803021:	6a 00                	push   $0x0
  803023:	ff 75 08             	pushl  0x8(%ebp)
  803026:	6a 29                	push   $0x29
  803028:	e8 fd fa ff ff       	call   802b2a <syscall>
  80302d:	83 c4 18             	add    $0x18,%esp
	return ;
  803030:	90                   	nop
}
  803031:	c9                   	leave  
  803032:	c3                   	ret    

00803033 <inctst>:

void inctst()
{
  803033:	55                   	push   %ebp
  803034:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  803036:	6a 00                	push   $0x0
  803038:	6a 00                	push   $0x0
  80303a:	6a 00                	push   $0x0
  80303c:	6a 00                	push   $0x0
  80303e:	6a 00                	push   $0x0
  803040:	6a 2a                	push   $0x2a
  803042:	e8 e3 fa ff ff       	call   802b2a <syscall>
  803047:	83 c4 18             	add    $0x18,%esp
	return ;
  80304a:	90                   	nop
}
  80304b:	c9                   	leave  
  80304c:	c3                   	ret    

0080304d <gettst>:
uint32 gettst()
{
  80304d:	55                   	push   %ebp
  80304e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  803050:	6a 00                	push   $0x0
  803052:	6a 00                	push   $0x0
  803054:	6a 00                	push   $0x0
  803056:	6a 00                	push   $0x0
  803058:	6a 00                	push   $0x0
  80305a:	6a 2b                	push   $0x2b
  80305c:	e8 c9 fa ff ff       	call   802b2a <syscall>
  803061:	83 c4 18             	add    $0x18,%esp
}
  803064:	c9                   	leave  
  803065:	c3                   	ret    

00803066 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  803066:	55                   	push   %ebp
  803067:	89 e5                	mov    %esp,%ebp
  803069:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80306c:	6a 00                	push   $0x0
  80306e:	6a 00                	push   $0x0
  803070:	6a 00                	push   $0x0
  803072:	6a 00                	push   $0x0
  803074:	6a 00                	push   $0x0
  803076:	6a 2c                	push   $0x2c
  803078:	e8 ad fa ff ff       	call   802b2a <syscall>
  80307d:	83 c4 18             	add    $0x18,%esp
  803080:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  803083:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  803087:	75 07                	jne    803090 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  803089:	b8 01 00 00 00       	mov    $0x1,%eax
  80308e:	eb 05                	jmp    803095 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  803090:	b8 00 00 00 00       	mov    $0x0,%eax
}
  803095:	c9                   	leave  
  803096:	c3                   	ret    

00803097 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  803097:	55                   	push   %ebp
  803098:	89 e5                	mov    %esp,%ebp
  80309a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80309d:	6a 00                	push   $0x0
  80309f:	6a 00                	push   $0x0
  8030a1:	6a 00                	push   $0x0
  8030a3:	6a 00                	push   $0x0
  8030a5:	6a 00                	push   $0x0
  8030a7:	6a 2c                	push   $0x2c
  8030a9:	e8 7c fa ff ff       	call   802b2a <syscall>
  8030ae:	83 c4 18             	add    $0x18,%esp
  8030b1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8030b4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8030b8:	75 07                	jne    8030c1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8030ba:	b8 01 00 00 00       	mov    $0x1,%eax
  8030bf:	eb 05                	jmp    8030c6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8030c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8030c6:	c9                   	leave  
  8030c7:	c3                   	ret    

008030c8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8030c8:	55                   	push   %ebp
  8030c9:	89 e5                	mov    %esp,%ebp
  8030cb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8030ce:	6a 00                	push   $0x0
  8030d0:	6a 00                	push   $0x0
  8030d2:	6a 00                	push   $0x0
  8030d4:	6a 00                	push   $0x0
  8030d6:	6a 00                	push   $0x0
  8030d8:	6a 2c                	push   $0x2c
  8030da:	e8 4b fa ff ff       	call   802b2a <syscall>
  8030df:	83 c4 18             	add    $0x18,%esp
  8030e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8030e5:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8030e9:	75 07                	jne    8030f2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8030eb:	b8 01 00 00 00       	mov    $0x1,%eax
  8030f0:	eb 05                	jmp    8030f7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8030f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8030f7:	c9                   	leave  
  8030f8:	c3                   	ret    

008030f9 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8030f9:	55                   	push   %ebp
  8030fa:	89 e5                	mov    %esp,%ebp
  8030fc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8030ff:	6a 00                	push   $0x0
  803101:	6a 00                	push   $0x0
  803103:	6a 00                	push   $0x0
  803105:	6a 00                	push   $0x0
  803107:	6a 00                	push   $0x0
  803109:	6a 2c                	push   $0x2c
  80310b:	e8 1a fa ff ff       	call   802b2a <syscall>
  803110:	83 c4 18             	add    $0x18,%esp
  803113:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  803116:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80311a:	75 07                	jne    803123 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80311c:	b8 01 00 00 00       	mov    $0x1,%eax
  803121:	eb 05                	jmp    803128 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  803123:	b8 00 00 00 00       	mov    $0x0,%eax
}
  803128:	c9                   	leave  
  803129:	c3                   	ret    

0080312a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80312a:	55                   	push   %ebp
  80312b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80312d:	6a 00                	push   $0x0
  80312f:	6a 00                	push   $0x0
  803131:	6a 00                	push   $0x0
  803133:	6a 00                	push   $0x0
  803135:	ff 75 08             	pushl  0x8(%ebp)
  803138:	6a 2d                	push   $0x2d
  80313a:	e8 eb f9 ff ff       	call   802b2a <syscall>
  80313f:	83 c4 18             	add    $0x18,%esp
	return ;
  803142:	90                   	nop
}
  803143:	c9                   	leave  
  803144:	c3                   	ret    

00803145 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  803145:	55                   	push   %ebp
  803146:	89 e5                	mov    %esp,%ebp
  803148:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  803149:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80314c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80314f:	8b 55 0c             	mov    0xc(%ebp),%edx
  803152:	8b 45 08             	mov    0x8(%ebp),%eax
  803155:	6a 00                	push   $0x0
  803157:	53                   	push   %ebx
  803158:	51                   	push   %ecx
  803159:	52                   	push   %edx
  80315a:	50                   	push   %eax
  80315b:	6a 2e                	push   $0x2e
  80315d:	e8 c8 f9 ff ff       	call   802b2a <syscall>
  803162:	83 c4 18             	add    $0x18,%esp
}
  803165:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  803168:	c9                   	leave  
  803169:	c3                   	ret    

0080316a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80316a:	55                   	push   %ebp
  80316b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80316d:	8b 55 0c             	mov    0xc(%ebp),%edx
  803170:	8b 45 08             	mov    0x8(%ebp),%eax
  803173:	6a 00                	push   $0x0
  803175:	6a 00                	push   $0x0
  803177:	6a 00                	push   $0x0
  803179:	52                   	push   %edx
  80317a:	50                   	push   %eax
  80317b:	6a 2f                	push   $0x2f
  80317d:	e8 a8 f9 ff ff       	call   802b2a <syscall>
  803182:	83 c4 18             	add    $0x18,%esp
}
  803185:	c9                   	leave  
  803186:	c3                   	ret    
  803187:	90                   	nop

00803188 <__udivdi3>:
  803188:	55                   	push   %ebp
  803189:	57                   	push   %edi
  80318a:	56                   	push   %esi
  80318b:	53                   	push   %ebx
  80318c:	83 ec 1c             	sub    $0x1c,%esp
  80318f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  803193:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  803197:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80319b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80319f:	89 ca                	mov    %ecx,%edx
  8031a1:	89 f8                	mov    %edi,%eax
  8031a3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8031a7:	85 f6                	test   %esi,%esi
  8031a9:	75 2d                	jne    8031d8 <__udivdi3+0x50>
  8031ab:	39 cf                	cmp    %ecx,%edi
  8031ad:	77 65                	ja     803214 <__udivdi3+0x8c>
  8031af:	89 fd                	mov    %edi,%ebp
  8031b1:	85 ff                	test   %edi,%edi
  8031b3:	75 0b                	jne    8031c0 <__udivdi3+0x38>
  8031b5:	b8 01 00 00 00       	mov    $0x1,%eax
  8031ba:	31 d2                	xor    %edx,%edx
  8031bc:	f7 f7                	div    %edi
  8031be:	89 c5                	mov    %eax,%ebp
  8031c0:	31 d2                	xor    %edx,%edx
  8031c2:	89 c8                	mov    %ecx,%eax
  8031c4:	f7 f5                	div    %ebp
  8031c6:	89 c1                	mov    %eax,%ecx
  8031c8:	89 d8                	mov    %ebx,%eax
  8031ca:	f7 f5                	div    %ebp
  8031cc:	89 cf                	mov    %ecx,%edi
  8031ce:	89 fa                	mov    %edi,%edx
  8031d0:	83 c4 1c             	add    $0x1c,%esp
  8031d3:	5b                   	pop    %ebx
  8031d4:	5e                   	pop    %esi
  8031d5:	5f                   	pop    %edi
  8031d6:	5d                   	pop    %ebp
  8031d7:	c3                   	ret    
  8031d8:	39 ce                	cmp    %ecx,%esi
  8031da:	77 28                	ja     803204 <__udivdi3+0x7c>
  8031dc:	0f bd fe             	bsr    %esi,%edi
  8031df:	83 f7 1f             	xor    $0x1f,%edi
  8031e2:	75 40                	jne    803224 <__udivdi3+0x9c>
  8031e4:	39 ce                	cmp    %ecx,%esi
  8031e6:	72 0a                	jb     8031f2 <__udivdi3+0x6a>
  8031e8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8031ec:	0f 87 9e 00 00 00    	ja     803290 <__udivdi3+0x108>
  8031f2:	b8 01 00 00 00       	mov    $0x1,%eax
  8031f7:	89 fa                	mov    %edi,%edx
  8031f9:	83 c4 1c             	add    $0x1c,%esp
  8031fc:	5b                   	pop    %ebx
  8031fd:	5e                   	pop    %esi
  8031fe:	5f                   	pop    %edi
  8031ff:	5d                   	pop    %ebp
  803200:	c3                   	ret    
  803201:	8d 76 00             	lea    0x0(%esi),%esi
  803204:	31 ff                	xor    %edi,%edi
  803206:	31 c0                	xor    %eax,%eax
  803208:	89 fa                	mov    %edi,%edx
  80320a:	83 c4 1c             	add    $0x1c,%esp
  80320d:	5b                   	pop    %ebx
  80320e:	5e                   	pop    %esi
  80320f:	5f                   	pop    %edi
  803210:	5d                   	pop    %ebp
  803211:	c3                   	ret    
  803212:	66 90                	xchg   %ax,%ax
  803214:	89 d8                	mov    %ebx,%eax
  803216:	f7 f7                	div    %edi
  803218:	31 ff                	xor    %edi,%edi
  80321a:	89 fa                	mov    %edi,%edx
  80321c:	83 c4 1c             	add    $0x1c,%esp
  80321f:	5b                   	pop    %ebx
  803220:	5e                   	pop    %esi
  803221:	5f                   	pop    %edi
  803222:	5d                   	pop    %ebp
  803223:	c3                   	ret    
  803224:	bd 20 00 00 00       	mov    $0x20,%ebp
  803229:	89 eb                	mov    %ebp,%ebx
  80322b:	29 fb                	sub    %edi,%ebx
  80322d:	89 f9                	mov    %edi,%ecx
  80322f:	d3 e6                	shl    %cl,%esi
  803231:	89 c5                	mov    %eax,%ebp
  803233:	88 d9                	mov    %bl,%cl
  803235:	d3 ed                	shr    %cl,%ebp
  803237:	89 e9                	mov    %ebp,%ecx
  803239:	09 f1                	or     %esi,%ecx
  80323b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80323f:	89 f9                	mov    %edi,%ecx
  803241:	d3 e0                	shl    %cl,%eax
  803243:	89 c5                	mov    %eax,%ebp
  803245:	89 d6                	mov    %edx,%esi
  803247:	88 d9                	mov    %bl,%cl
  803249:	d3 ee                	shr    %cl,%esi
  80324b:	89 f9                	mov    %edi,%ecx
  80324d:	d3 e2                	shl    %cl,%edx
  80324f:	8b 44 24 08          	mov    0x8(%esp),%eax
  803253:	88 d9                	mov    %bl,%cl
  803255:	d3 e8                	shr    %cl,%eax
  803257:	09 c2                	or     %eax,%edx
  803259:	89 d0                	mov    %edx,%eax
  80325b:	89 f2                	mov    %esi,%edx
  80325d:	f7 74 24 0c          	divl   0xc(%esp)
  803261:	89 d6                	mov    %edx,%esi
  803263:	89 c3                	mov    %eax,%ebx
  803265:	f7 e5                	mul    %ebp
  803267:	39 d6                	cmp    %edx,%esi
  803269:	72 19                	jb     803284 <__udivdi3+0xfc>
  80326b:	74 0b                	je     803278 <__udivdi3+0xf0>
  80326d:	89 d8                	mov    %ebx,%eax
  80326f:	31 ff                	xor    %edi,%edi
  803271:	e9 58 ff ff ff       	jmp    8031ce <__udivdi3+0x46>
  803276:	66 90                	xchg   %ax,%ax
  803278:	8b 54 24 08          	mov    0x8(%esp),%edx
  80327c:	89 f9                	mov    %edi,%ecx
  80327e:	d3 e2                	shl    %cl,%edx
  803280:	39 c2                	cmp    %eax,%edx
  803282:	73 e9                	jae    80326d <__udivdi3+0xe5>
  803284:	8d 43 ff             	lea    -0x1(%ebx),%eax
  803287:	31 ff                	xor    %edi,%edi
  803289:	e9 40 ff ff ff       	jmp    8031ce <__udivdi3+0x46>
  80328e:	66 90                	xchg   %ax,%ax
  803290:	31 c0                	xor    %eax,%eax
  803292:	e9 37 ff ff ff       	jmp    8031ce <__udivdi3+0x46>
  803297:	90                   	nop

00803298 <__umoddi3>:
  803298:	55                   	push   %ebp
  803299:	57                   	push   %edi
  80329a:	56                   	push   %esi
  80329b:	53                   	push   %ebx
  80329c:	83 ec 1c             	sub    $0x1c,%esp
  80329f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8032a3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8032a7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8032ab:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8032af:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8032b3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8032b7:	89 f3                	mov    %esi,%ebx
  8032b9:	89 fa                	mov    %edi,%edx
  8032bb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8032bf:	89 34 24             	mov    %esi,(%esp)
  8032c2:	85 c0                	test   %eax,%eax
  8032c4:	75 1a                	jne    8032e0 <__umoddi3+0x48>
  8032c6:	39 f7                	cmp    %esi,%edi
  8032c8:	0f 86 a2 00 00 00    	jbe    803370 <__umoddi3+0xd8>
  8032ce:	89 c8                	mov    %ecx,%eax
  8032d0:	89 f2                	mov    %esi,%edx
  8032d2:	f7 f7                	div    %edi
  8032d4:	89 d0                	mov    %edx,%eax
  8032d6:	31 d2                	xor    %edx,%edx
  8032d8:	83 c4 1c             	add    $0x1c,%esp
  8032db:	5b                   	pop    %ebx
  8032dc:	5e                   	pop    %esi
  8032dd:	5f                   	pop    %edi
  8032de:	5d                   	pop    %ebp
  8032df:	c3                   	ret    
  8032e0:	39 f0                	cmp    %esi,%eax
  8032e2:	0f 87 ac 00 00 00    	ja     803394 <__umoddi3+0xfc>
  8032e8:	0f bd e8             	bsr    %eax,%ebp
  8032eb:	83 f5 1f             	xor    $0x1f,%ebp
  8032ee:	0f 84 ac 00 00 00    	je     8033a0 <__umoddi3+0x108>
  8032f4:	bf 20 00 00 00       	mov    $0x20,%edi
  8032f9:	29 ef                	sub    %ebp,%edi
  8032fb:	89 fe                	mov    %edi,%esi
  8032fd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  803301:	89 e9                	mov    %ebp,%ecx
  803303:	d3 e0                	shl    %cl,%eax
  803305:	89 d7                	mov    %edx,%edi
  803307:	89 f1                	mov    %esi,%ecx
  803309:	d3 ef                	shr    %cl,%edi
  80330b:	09 c7                	or     %eax,%edi
  80330d:	89 e9                	mov    %ebp,%ecx
  80330f:	d3 e2                	shl    %cl,%edx
  803311:	89 14 24             	mov    %edx,(%esp)
  803314:	89 d8                	mov    %ebx,%eax
  803316:	d3 e0                	shl    %cl,%eax
  803318:	89 c2                	mov    %eax,%edx
  80331a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80331e:	d3 e0                	shl    %cl,%eax
  803320:	89 44 24 04          	mov    %eax,0x4(%esp)
  803324:	8b 44 24 08          	mov    0x8(%esp),%eax
  803328:	89 f1                	mov    %esi,%ecx
  80332a:	d3 e8                	shr    %cl,%eax
  80332c:	09 d0                	or     %edx,%eax
  80332e:	d3 eb                	shr    %cl,%ebx
  803330:	89 da                	mov    %ebx,%edx
  803332:	f7 f7                	div    %edi
  803334:	89 d3                	mov    %edx,%ebx
  803336:	f7 24 24             	mull   (%esp)
  803339:	89 c6                	mov    %eax,%esi
  80333b:	89 d1                	mov    %edx,%ecx
  80333d:	39 d3                	cmp    %edx,%ebx
  80333f:	0f 82 87 00 00 00    	jb     8033cc <__umoddi3+0x134>
  803345:	0f 84 91 00 00 00    	je     8033dc <__umoddi3+0x144>
  80334b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80334f:	29 f2                	sub    %esi,%edx
  803351:	19 cb                	sbb    %ecx,%ebx
  803353:	89 d8                	mov    %ebx,%eax
  803355:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  803359:	d3 e0                	shl    %cl,%eax
  80335b:	89 e9                	mov    %ebp,%ecx
  80335d:	d3 ea                	shr    %cl,%edx
  80335f:	09 d0                	or     %edx,%eax
  803361:	89 e9                	mov    %ebp,%ecx
  803363:	d3 eb                	shr    %cl,%ebx
  803365:	89 da                	mov    %ebx,%edx
  803367:	83 c4 1c             	add    $0x1c,%esp
  80336a:	5b                   	pop    %ebx
  80336b:	5e                   	pop    %esi
  80336c:	5f                   	pop    %edi
  80336d:	5d                   	pop    %ebp
  80336e:	c3                   	ret    
  80336f:	90                   	nop
  803370:	89 fd                	mov    %edi,%ebp
  803372:	85 ff                	test   %edi,%edi
  803374:	75 0b                	jne    803381 <__umoddi3+0xe9>
  803376:	b8 01 00 00 00       	mov    $0x1,%eax
  80337b:	31 d2                	xor    %edx,%edx
  80337d:	f7 f7                	div    %edi
  80337f:	89 c5                	mov    %eax,%ebp
  803381:	89 f0                	mov    %esi,%eax
  803383:	31 d2                	xor    %edx,%edx
  803385:	f7 f5                	div    %ebp
  803387:	89 c8                	mov    %ecx,%eax
  803389:	f7 f5                	div    %ebp
  80338b:	89 d0                	mov    %edx,%eax
  80338d:	e9 44 ff ff ff       	jmp    8032d6 <__umoddi3+0x3e>
  803392:	66 90                	xchg   %ax,%ax
  803394:	89 c8                	mov    %ecx,%eax
  803396:	89 f2                	mov    %esi,%edx
  803398:	83 c4 1c             	add    $0x1c,%esp
  80339b:	5b                   	pop    %ebx
  80339c:	5e                   	pop    %esi
  80339d:	5f                   	pop    %edi
  80339e:	5d                   	pop    %ebp
  80339f:	c3                   	ret    
  8033a0:	3b 04 24             	cmp    (%esp),%eax
  8033a3:	72 06                	jb     8033ab <__umoddi3+0x113>
  8033a5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8033a9:	77 0f                	ja     8033ba <__umoddi3+0x122>
  8033ab:	89 f2                	mov    %esi,%edx
  8033ad:	29 f9                	sub    %edi,%ecx
  8033af:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8033b3:	89 14 24             	mov    %edx,(%esp)
  8033b6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8033ba:	8b 44 24 04          	mov    0x4(%esp),%eax
  8033be:	8b 14 24             	mov    (%esp),%edx
  8033c1:	83 c4 1c             	add    $0x1c,%esp
  8033c4:	5b                   	pop    %ebx
  8033c5:	5e                   	pop    %esi
  8033c6:	5f                   	pop    %edi
  8033c7:	5d                   	pop    %ebp
  8033c8:	c3                   	ret    
  8033c9:	8d 76 00             	lea    0x0(%esi),%esi
  8033cc:	2b 04 24             	sub    (%esp),%eax
  8033cf:	19 fa                	sbb    %edi,%edx
  8033d1:	89 d1                	mov    %edx,%ecx
  8033d3:	89 c6                	mov    %eax,%esi
  8033d5:	e9 71 ff ff ff       	jmp    80334b <__umoddi3+0xb3>
  8033da:	66 90                	xchg   %ax,%ax
  8033dc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8033e0:	72 ea                	jb     8033cc <__umoddi3+0x134>
  8033e2:	89 d9                	mov    %ebx,%ecx
  8033e4:	e9 62 ff ff ff       	jmp    80334b <__umoddi3+0xb3>
