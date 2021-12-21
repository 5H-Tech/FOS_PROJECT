
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
  800031:	e8 0e 16 00 00       	call   801644 <libmain>
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
  80005b:	e8 cb 19 00 00       	call   801a2b <cprintf>
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
  80008b:	e8 f9 16 00 00       	call   801789 <_panic>
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
  8000c0:	e8 d6 2b 00 00       	call   802c9b <sys_calculate_free_frames>
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
  8000f3:	e8 26 2c 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  8000f8:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000fe:	01 c0                	add    %eax,%eax
  800100:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800103:	83 ec 0c             	sub    $0xc,%esp
  800106:	50                   	push   %eax
  800107:	e8 a9 26 00 00       	call   8027b5 <malloc>
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
  800134:	6a 3c                	push   $0x3c
  800136:	68 2b 34 80 00       	push   $0x80342b
  80013b:	e8 49 16 00 00       	call   801789 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800140:	e8 d9 2b 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  800145:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800148:	3d 00 02 00 00       	cmp    $0x200,%eax
  80014d:	74 14                	je     800163 <_main+0x12b>
  80014f:	83 ec 04             	sub    $0x4,%esp
  800152:	68 a8 34 80 00       	push   $0x8034a8
  800157:	6a 3d                	push   $0x3d
  800159:	68 2b 34 80 00       	push   $0x80342b
  80015e:	e8 26 16 00 00       	call   801789 <_panic>
		int freeFrames = sys_calculate_free_frames() ;
  800163:	e8 33 2b 00 00       	call   802c9b <sys_calculate_free_frames>
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
  800198:	e8 fe 2a 00 00       	call   802c9b <sys_calculate_free_frames>
  80019d:	29 c3                	sub    %eax,%ebx
  80019f:	89 d8                	mov    %ebx,%eax
  8001a1:	83 f8 03             	cmp    $0x3,%eax
  8001a4:	74 14                	je     8001ba <_main+0x182>
  8001a6:	83 ec 04             	sub    $0x4,%esp
  8001a9:	68 d8 34 80 00       	push   $0x8034d8
  8001ae:	6a 44                	push   $0x44
  8001b0:	68 2b 34 80 00       	push   $0x80342b
  8001b5:	e8 cf 15 00 00       	call   801789 <_panic>
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
  80025c:	68 1c 35 80 00       	push   $0x80351c
  800261:	6a 50                	push   $0x50
  800263:	68 2b 34 80 00       	push   $0x80342b
  800268:	e8 1c 15 00 00       	call   801789 <_panic>


		//2 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80026d:	e8 ac 2a 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  800272:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  800275:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800278:	01 c0                	add    %eax,%eax
  80027a:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80027d:	83 ec 0c             	sub    $0xc,%esp
  800280:	50                   	push   %eax
  800281:	e8 2f 25 00 00       	call   8027b5 <malloc>
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
  8002c3:	6a 56                	push   $0x56
  8002c5:	68 2b 34 80 00       	push   $0x80342b
  8002ca:	e8 ba 14 00 00       	call   801789 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  8002cf:	e8 4a 2a 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  8002d4:	2b 45 c0             	sub    -0x40(%ebp),%eax
  8002d7:	3d 00 02 00 00       	cmp    $0x200,%eax
  8002dc:	74 14                	je     8002f2 <_main+0x2ba>
  8002de:	83 ec 04             	sub    $0x4,%esp
  8002e1:	68 a8 34 80 00       	push   $0x8034a8
  8002e6:	6a 57                	push   $0x57
  8002e8:	68 2b 34 80 00       	push   $0x80342b
  8002ed:	e8 97 14 00 00       	call   801789 <_panic>
		freeFrames = sys_calculate_free_frames() ;
  8002f2:	e8 a4 29 00 00       	call   802c9b <sys_calculate_free_frames>
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
  800330:	e8 66 29 00 00       	call   802c9b <sys_calculate_free_frames>
  800335:	29 c3                	sub    %eax,%ebx
  800337:	89 d8                	mov    %ebx,%eax
  800339:	83 f8 02             	cmp    $0x2,%eax
  80033c:	74 14                	je     800352 <_main+0x31a>
  80033e:	83 ec 04             	sub    $0x4,%esp
  800341:	68 d8 34 80 00       	push   $0x8034d8
  800346:	6a 5d                	push   $0x5d
  800348:	68 2b 34 80 00       	push   $0x80342b
  80034d:	e8 37 14 00 00       	call   801789 <_panic>
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
  8003fd:	6a 66                	push   $0x66
  8003ff:	68 2b 34 80 00       	push   $0x80342b
  800404:	e8 80 13 00 00       	call   801789 <_panic>

		//3 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800409:	e8 10 29 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  80040e:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[2] = malloc(3*kilo);
  800411:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800414:	89 c2                	mov    %eax,%edx
  800416:	01 d2                	add    %edx,%edx
  800418:	01 d0                	add    %edx,%eax
  80041a:	83 ec 0c             	sub    $0xc,%esp
  80041d:	50                   	push   %eax
  80041e:	e8 92 23 00 00       	call   8027b5 <malloc>
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
  800462:	6a 6b                	push   $0x6b
  800464:	68 2b 34 80 00       	push   $0x80342b
  800469:	e8 1b 13 00 00       	call   801789 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  80046e:	e8 ab 28 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  800473:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800476:	83 f8 01             	cmp    $0x1,%eax
  800479:	74 14                	je     80048f <_main+0x457>
  80047b:	83 ec 04             	sub    $0x4,%esp
  80047e:	68 a8 34 80 00       	push   $0x8034a8
  800483:	6a 6c                	push   $0x6c
  800485:	68 2b 34 80 00       	push   $0x80342b
  80048a:	e8 fa 12 00 00       	call   801789 <_panic>
		freeFrames = sys_calculate_free_frames() ;
  80048f:	e8 07 28 00 00       	call   802c9b <sys_calculate_free_frames>
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
  8004cf:	e8 c7 27 00 00       	call   802c9b <sys_calculate_free_frames>
  8004d4:	29 c3                	sub    %eax,%ebx
  8004d6:	89 d8                	mov    %ebx,%eax
  8004d8:	83 f8 02             	cmp    $0x2,%eax
  8004db:	74 14                	je     8004f1 <_main+0x4b9>
  8004dd:	83 ec 04             	sub    $0x4,%esp
  8004e0:	68 d8 34 80 00       	push   $0x8034d8
  8004e5:	6a 72                	push   $0x72
  8004e7:	68 2b 34 80 00       	push   $0x80342b
  8004ec:	e8 98 12 00 00       	call   801789 <_panic>
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
  8005b4:	6a 7b                	push   $0x7b
  8005b6:	68 2b 34 80 00       	push   $0x80342b
  8005bb:	e8 c9 11 00 00       	call   801789 <_panic>

		//3 KB
		freeFrames = sys_calculate_free_frames() ;
  8005c0:	e8 d6 26 00 00       	call   802c9b <sys_calculate_free_frames>
  8005c5:	89 45 bc             	mov    %eax,-0x44(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8005c8:	e8 51 27 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  8005cd:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[3] = malloc(3*kilo);
  8005d0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005d3:	89 c2                	mov    %eax,%edx
  8005d5:	01 d2                	add    %edx,%edx
  8005d7:	01 d0                	add    %edx,%eax
  8005d9:	83 ec 0c             	sub    $0xc,%esp
  8005dc:	50                   	push   %eax
  8005dd:	e8 d3 21 00 00       	call   8027b5 <malloc>
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
  800630:	68 40 34 80 00       	push   $0x803440
  800635:	68 81 00 00 00       	push   $0x81
  80063a:	68 2b 34 80 00       	push   $0x80342b
  80063f:	e8 45 11 00 00       	call   801789 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800644:	e8 d5 26 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  800649:	2b 45 c0             	sub    -0x40(%ebp),%eax
  80064c:	83 f8 01             	cmp    $0x1,%eax
  80064f:	74 17                	je     800668 <_main+0x630>
  800651:	83 ec 04             	sub    $0x4,%esp
  800654:	68 a8 34 80 00       	push   $0x8034a8
  800659:	68 82 00 00 00       	push   $0x82
  80065e:	68 2b 34 80 00       	push   $0x80342b
  800663:	e8 21 11 00 00       	call   801789 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800668:	e8 b1 26 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
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
  800681:	e8 2f 21 00 00       	call   8027b5 <malloc>
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
  8006d4:	68 40 34 80 00       	push   $0x803440
  8006d9:	68 88 00 00 00       	push   $0x88
  8006de:	68 2b 34 80 00       	push   $0x80342b
  8006e3:	e8 a1 10 00 00       	call   801789 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  8006e8:	e8 31 26 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  8006ed:	2b 45 c0             	sub    -0x40(%ebp),%eax
  8006f0:	83 f8 02             	cmp    $0x2,%eax
  8006f3:	74 17                	je     80070c <_main+0x6d4>
  8006f5:	83 ec 04             	sub    $0x4,%esp
  8006f8:	68 a8 34 80 00       	push   $0x8034a8
  8006fd:	68 89 00 00 00       	push   $0x89
  800702:	68 2b 34 80 00       	push   $0x80342b
  800707:	e8 7d 10 00 00       	call   801789 <_panic>
		freeFrames = sys_calculate_free_frames() ;
  80070c:	e8 8a 25 00 00       	call   802c9b <sys_calculate_free_frames>
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
  8007b0:	e8 e6 24 00 00       	call   802c9b <sys_calculate_free_frames>
  8007b5:	29 c3                	sub    %eax,%ebx
  8007b7:	89 d8                	mov    %ebx,%eax
  8007b9:	83 f8 02             	cmp    $0x2,%eax
  8007bc:	74 17                	je     8007d5 <_main+0x79d>
  8007be:	83 ec 04             	sub    $0x4,%esp
  8007c1:	68 d8 34 80 00       	push   $0x8034d8
  8007c6:	68 8f 00 00 00       	push   $0x8f
  8007cb:	68 2b 34 80 00       	push   $0x80342b
  8007d0:	e8 b4 0f 00 00       	call   801789 <_panic>
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
  8008a2:	68 1c 35 80 00       	push   $0x80351c
  8008a7:	68 98 00 00 00       	push   $0x98
  8008ac:	68 2b 34 80 00       	push   $0x80342b
  8008b1:	e8 d3 0e 00 00       	call   801789 <_panic>

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8008b6:	e8 e0 23 00 00       	call   802c9b <sys_calculate_free_frames>
  8008bb:	89 45 bc             	mov    %eax,-0x44(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8008be:	e8 5b 24 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  8008c3:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8008c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008c9:	89 c2                	mov    %eax,%edx
  8008cb:	01 d2                	add    %edx,%edx
  8008cd:	01 d0                	add    %edx,%eax
  8008cf:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8008d2:	83 ec 0c             	sub    $0xc,%esp
  8008d5:	50                   	push   %eax
  8008d6:	e8 da 1e 00 00       	call   8027b5 <malloc>
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
  800929:	68 40 34 80 00       	push   $0x803440
  80092e:	68 9e 00 00 00       	push   $0x9e
  800933:	68 2b 34 80 00       	push   $0x80342b
  800938:	e8 4c 0e 00 00       	call   801789 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  80093d:	e8 dc 23 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
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
  800963:	68 a8 34 80 00       	push   $0x8034a8
  800968:	68 9f 00 00 00       	push   $0x9f
  80096d:	68 2b 34 80 00       	push   $0x80342b
  800972:	e8 12 0e 00 00       	call   801789 <_panic>

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
  8009a1:	e8 78 23 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
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
  8009bb:	e8 f5 1d 00 00       	call   8027b5 <malloc>
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
  800a1c:	68 40 34 80 00       	push   $0x803440
  800a21:	68 ae 00 00 00       	push   $0xae
  800a26:	68 2b 34 80 00       	push   $0x80342b
  800a2b:	e8 59 0d 00 00       	call   801789 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800a30:	e8 e9 22 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
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
  800a58:	68 a8 34 80 00       	push   $0x8034a8
  800a5d:	68 af 00 00 00       	push   $0xaf
  800a62:	68 2b 34 80 00       	push   $0x80342b
  800a67:	e8 1d 0d 00 00       	call   801789 <_panic>
		freeFrames = sys_calculate_free_frames() ;
  800a6c:	e8 2a 22 00 00       	call   802c9b <sys_calculate_free_frames>
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
  800add:	e8 b9 21 00 00       	call   802c9b <sys_calculate_free_frames>
  800ae2:	29 c3                	sub    %eax,%ebx
  800ae4:	89 d8                	mov    %ebx,%eax
  800ae6:	83 f8 05             	cmp    $0x5,%eax
  800ae9:	74 17                	je     800b02 <_main+0xaca>
  800aeb:	83 ec 04             	sub    $0x4,%esp
  800aee:	68 d8 34 80 00       	push   $0x8034d8
  800af3:	68 b6 00 00 00       	push   $0xb6
  800af8:	68 2b 34 80 00       	push   $0x80342b
  800afd:	e8 87 0c 00 00       	call   801789 <_panic>
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
  800c21:	68 1c 35 80 00       	push   $0x80351c
  800c26:	68 c1 00 00 00       	push   $0xc1
  800c2b:	68 2b 34 80 00       	push   $0x80342b
  800c30:	e8 54 0b 00 00       	call   801789 <_panic>

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800c35:	e8 e4 20 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
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
  800c50:	e8 60 1b 00 00       	call   8027b5 <malloc>
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
  800cb3:	68 40 34 80 00       	push   $0x803440
  800cb8:	68 c6 00 00 00       	push   $0xc6
  800cbd:	68 2b 34 80 00       	push   $0x80342b
  800cc2:	e8 c2 0a 00 00       	call   801789 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4) panic("Extra or less pages are allocated in PageFile");
  800cc7:	e8 52 20 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  800ccc:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800ccf:	83 f8 04             	cmp    $0x4,%eax
  800cd2:	74 17                	je     800ceb <_main+0xcb3>
  800cd4:	83 ec 04             	sub    $0x4,%esp
  800cd7:	68 a8 34 80 00       	push   $0x8034a8
  800cdc:	68 c7 00 00 00       	push   $0xc7
  800ce1:	68 2b 34 80 00       	push   $0x80342b
  800ce6:	e8 9e 0a 00 00       	call   801789 <_panic>
		freeFrames = sys_calculate_free_frames() ;
  800ceb:	e8 ab 1f 00 00       	call   802c9b <sys_calculate_free_frames>
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
  800d3f:	e8 57 1f 00 00       	call   802c9b <sys_calculate_free_frames>
  800d44:	29 c3                	sub    %eax,%ebx
  800d46:	89 d8                	mov    %ebx,%eax
  800d48:	83 f8 02             	cmp    $0x2,%eax
  800d4b:	74 17                	je     800d64 <_main+0xd2c>
  800d4d:	83 ec 04             	sub    $0x4,%esp
  800d50:	68 d8 34 80 00       	push   $0x8034d8
  800d55:	68 cd 00 00 00       	push   $0xcd
  800d5a:	68 2b 34 80 00       	push   $0x80342b
  800d5f:	e8 25 0a 00 00       	call   801789 <_panic>
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
  800e2e:	68 1c 35 80 00       	push   $0x80351c
  800e33:	68 d6 00 00 00       	push   $0xd6
  800e38:	68 2b 34 80 00       	push   $0x80342b
  800e3d:	e8 47 09 00 00       	call   801789 <_panic>
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
  800e56:	e8 40 1e 00 00       	call   802c9b <sys_calculate_free_frames>
  800e5b:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800e61:	e8 b8 1e 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  800e66:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[6]);
  800e6c:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  800e72:	83 ec 0c             	sub    $0xc,%esp
  800e75:	50                   	push   %eax
  800e76:	e8 4a 1b 00 00       	call   8029c5 <free>
  800e7b:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 6*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
  800e7e:	e8 9b 1e 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
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
  800ea4:	39 c1                	cmp    %eax,%ecx
  800ea6:	74 17                	je     800ebf <_main+0xe87>
  800ea8:	83 ec 04             	sub    $0x4,%esp
  800eab:	68 3c 35 80 00       	push   $0x80353c
  800eb0:	68 df 00 00 00       	push   $0xdf
  800eb5:	68 2b 34 80 00       	push   $0x80342b
  800eba:	e8 ca 08 00 00       	call   801789 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800ebf:	e8 d7 1d 00 00       	call   802c9b <sys_calculate_free_frames>
  800ec4:	89 c2                	mov    %eax,%edx
  800ec6:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  800ecc:	29 c2                	sub    %eax,%edx
  800ece:	89 d0                	mov    %edx,%eax
  800ed0:	83 f8 04             	cmp    $0x4,%eax
  800ed3:	74 17                	je     800eec <_main+0xeb4>
  800ed5:	83 ec 04             	sub    $0x4,%esp
  800ed8:	68 78 35 80 00       	push   $0x803578
  800edd:	68 e0 00 00 00       	push   $0xe0
  800ee2:	68 2b 34 80 00       	push   $0x80342b
  800ee7:	e8 9d 08 00 00       	call   801789 <_panic>
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}
		tmp_addresses[0] = (uint32)(&(byteArr2[0]));
  800eec:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800ef2:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(byteArr2[lastIndexOfByte2/2]));
  800ef8:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800efe:	89 c2                	mov    %eax,%edx
  800f00:	c1 ea 1f             	shr    $0x1f,%edx
  800f03:	01 d0                	add    %edx,%eax
  800f05:	d1 f8                	sar    %eax
  800f07:	89 c2                	mov    %eax,%edx
  800f09:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800f0f:	01 d0                	add    %edx,%eax
  800f11:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		tmp_addresses[2] = (uint32)(&(byteArr2[lastIndexOfByte2]));
  800f17:	8b 95 58 ff ff ff    	mov    -0xa8(%ebp),%edx
  800f1d:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800f23:	01 d0                	add    %edx,%eax
  800f25:	89 85 c4 fe ff ff    	mov    %eax,-0x13c(%ebp)
		int check = sys_check_LRU_lists_free(tmp_addresses, 3);
  800f2b:	83 ec 08             	sub    $0x8,%esp
  800f2e:	6a 03                	push   $0x3
  800f30:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  800f36:	50                   	push   %eax
  800f37:	e8 33 22 00 00       	call   80316f <sys_check_LRU_lists_free>
  800f3c:	83 c4 10             	add    $0x10,%esp
  800f3f:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  800f45:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  800f4c:	74 17                	je     800f65 <_main+0xf2d>
		{
				panic("free: page is not removed from LRU lists");
  800f4e:	83 ec 04             	sub    $0x4,%esp
  800f51:	68 c4 35 80 00       	push   $0x8035c4
  800f56:	68 f0 00 00 00       	push   $0xf0
  800f5b:	68 2b 34 80 00       	push   $0x80342b
  800f60:	e8 24 08 00 00       	call   801789 <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 800 && LIST_SIZE(&myEnv->SecondList) != 1)
  800f65:	a1 20 40 80 00       	mov    0x804020,%eax
  800f6a:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  800f70:	3d 20 03 00 00       	cmp    $0x320,%eax
  800f75:	74 27                	je     800f9e <_main+0xf66>
  800f77:	a1 20 40 80 00       	mov    0x804020,%eax
  800f7c:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  800f82:	83 f8 01             	cmp    $0x1,%eax
  800f85:	74 17                	je     800f9e <_main+0xf66>
		{
			panic("LRU lists content is not correct");
  800f87:	83 ec 04             	sub    $0x4,%esp
  800f8a:	68 f0 35 80 00       	push   $0x8035f0
  800f8f:	68 f5 00 00 00       	push   $0xf5
  800f94:	68 2b 34 80 00       	push   $0x80342b
  800f99:	e8 eb 07 00 00       	call   801789 <_panic>
		}

		//Free 1st 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800f9e:	e8 f8 1c 00 00       	call   802c9b <sys_calculate_free_frames>
  800fa3:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800fa9:	e8 70 1d 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  800fae:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[0]);
  800fb4:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  800fba:	83 ec 0c             	sub    $0xc,%esp
  800fbd:	50                   	push   %eax
  800fbe:	e8 02 1a 00 00       	call   8029c5 <free>
  800fc3:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  800fc6:	e8 53 1d 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  800fcb:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  800fd1:	29 c2                	sub    %eax,%edx
  800fd3:	89 d0                	mov    %edx,%eax
  800fd5:	3d 00 02 00 00       	cmp    $0x200,%eax
  800fda:	74 17                	je     800ff3 <_main+0xfbb>
  800fdc:	83 ec 04             	sub    $0x4,%esp
  800fdf:	68 3c 35 80 00       	push   $0x80353c
  800fe4:	68 fc 00 00 00       	push   $0xfc
  800fe9:	68 2b 34 80 00       	push   $0x80342b
  800fee:	e8 96 07 00 00       	call   801789 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 ) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800ff3:	e8 a3 1c 00 00       	call   802c9b <sys_calculate_free_frames>
  800ff8:	89 c2                	mov    %eax,%edx
  800ffa:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801000:	29 c2                	sub    %eax,%edx
  801002:	89 d0                	mov    %edx,%eax
  801004:	83 f8 02             	cmp    $0x2,%eax
  801007:	74 17                	je     801020 <_main+0xfe8>
  801009:	83 ec 04             	sub    $0x4,%esp
  80100c:	68 78 35 80 00       	push   $0x803578
  801011:	68 fd 00 00 00       	push   $0xfd
  801016:	68 2b 34 80 00       	push   $0x80342b
  80101b:	e8 69 07 00 00       	call   801789 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(byteArr[0]));
  801020:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801023:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(byteArr[lastIndexOfByte]));
  801029:	8b 55 b8             	mov    -0x48(%ebp),%edx
  80102c:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80102f:	01 d0                	add    %edx,%eax
  801031:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  801037:	83 ec 08             	sub    $0x8,%esp
  80103a:	6a 02                	push   $0x2
  80103c:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  801042:	50                   	push   %eax
  801043:	e8 27 21 00 00       	call   80316f <sys_check_LRU_lists_free>
  801048:	83 c4 10             	add    $0x10,%esp
  80104b:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  801051:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  801058:	74 17                	je     801071 <_main+0x1039>
		{
				panic("free: page is not removed from LRU lists");
  80105a:	83 ec 04             	sub    $0x4,%esp
  80105d:	68 c4 35 80 00       	push   $0x8035c4
  801062:	68 0c 01 00 00       	push   $0x10c
  801067:	68 2b 34 80 00       	push   $0x80342b
  80106c:	e8 18 07 00 00       	call   801789 <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 799 && LIST_SIZE(&myEnv->SecondList) != 0)
  801071:	a1 20 40 80 00       	mov    0x804020,%eax
  801076:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  80107c:	3d 1f 03 00 00       	cmp    $0x31f,%eax
  801081:	74 26                	je     8010a9 <_main+0x1071>
  801083:	a1 20 40 80 00       	mov    0x804020,%eax
  801088:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  80108e:	85 c0                	test   %eax,%eax
  801090:	74 17                	je     8010a9 <_main+0x1071>
		{
			panic("LRU lists content is not correct");
  801092:	83 ec 04             	sub    $0x4,%esp
  801095:	68 f0 35 80 00       	push   $0x8035f0
  80109a:	68 11 01 00 00       	push   $0x111
  80109f:	68 2b 34 80 00       	push   $0x80342b
  8010a4:	e8 e0 06 00 00       	call   801789 <_panic>
		}

		//Free 2nd 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8010a9:	e8 ed 1b 00 00       	call   802c9b <sys_calculate_free_frames>
  8010ae:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8010b4:	e8 65 1c 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  8010b9:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[1]);
  8010bf:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  8010c5:	83 ec 0c             	sub    $0xc,%esp
  8010c8:	50                   	push   %eax
  8010c9:	e8 f7 18 00 00       	call   8029c5 <free>
  8010ce:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  8010d1:	e8 48 1c 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  8010d6:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  8010dc:	29 c2                	sub    %eax,%edx
  8010de:	89 d0                	mov    %edx,%eax
  8010e0:	3d 00 02 00 00       	cmp    $0x200,%eax
  8010e5:	74 17                	je     8010fe <_main+0x10c6>
  8010e7:	83 ec 04             	sub    $0x4,%esp
  8010ea:	68 3c 35 80 00       	push   $0x80353c
  8010ef:	68 18 01 00 00       	push   $0x118
  8010f4:	68 2b 34 80 00       	push   $0x80342b
  8010f9:	e8 8b 06 00 00       	call   801789 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8010fe:	e8 98 1b 00 00       	call   802c9b <sys_calculate_free_frames>
  801103:	89 c2                	mov    %eax,%edx
  801105:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  80110b:	29 c2                	sub    %eax,%edx
  80110d:	89 d0                	mov    %edx,%eax
  80110f:	83 f8 03             	cmp    $0x3,%eax
  801112:	74 17                	je     80112b <_main+0x10f3>
  801114:	83 ec 04             	sub    $0x4,%esp
  801117:	68 78 35 80 00       	push   $0x803578
  80111c:	68 19 01 00 00       	push   $0x119
  801121:	68 2b 34 80 00       	push   $0x80342b
  801126:	e8 5e 06 00 00       	call   801789 <_panic>
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}
		tmp_addresses[0] = (uint32)(&(shortArr[0]));
  80112b:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80112e:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(shortArr[lastIndexOfShort]));
  801134:	8b 45 9c             	mov    -0x64(%ebp),%eax
  801137:	01 c0                	add    %eax,%eax
  801139:	89 c2                	mov    %eax,%edx
  80113b:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80113e:	01 d0                	add    %edx,%eax
  801140:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  801146:	83 ec 08             	sub    $0x8,%esp
  801149:	6a 02                	push   $0x2
  80114b:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  801151:	50                   	push   %eax
  801152:	e8 18 20 00 00       	call   80316f <sys_check_LRU_lists_free>
  801157:	83 c4 10             	add    $0x10,%esp
  80115a:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  801160:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  801167:	74 17                	je     801180 <_main+0x1148>
		{
				panic("free: page is not removed from LRU lists");
  801169:	83 ec 04             	sub    $0x4,%esp
  80116c:	68 c4 35 80 00       	push   $0x8035c4
  801171:	68 26 01 00 00       	push   $0x126
  801176:	68 2b 34 80 00       	push   $0x80342b
  80117b:	e8 09 06 00 00       	call   801789 <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 797 && LIST_SIZE(&myEnv->SecondList) != 0)
  801180:	a1 20 40 80 00       	mov    0x804020,%eax
  801185:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  80118b:	3d 1d 03 00 00       	cmp    $0x31d,%eax
  801190:	74 26                	je     8011b8 <_main+0x1180>
  801192:	a1 20 40 80 00       	mov    0x804020,%eax
  801197:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  80119d:	85 c0                	test   %eax,%eax
  80119f:	74 17                	je     8011b8 <_main+0x1180>
		{
			panic("LRU lists content is not correct");
  8011a1:	83 ec 04             	sub    $0x4,%esp
  8011a4:	68 f0 35 80 00       	push   $0x8035f0
  8011a9:	68 2b 01 00 00       	push   $0x12b
  8011ae:	68 2b 34 80 00       	push   $0x80342b
  8011b3:	e8 d1 05 00 00       	call   801789 <_panic>
		}


		//Free 7 KB
		freeFrames = sys_calculate_free_frames() ;
  8011b8:	e8 de 1a 00 00       	call   802c9b <sys_calculate_free_frames>
  8011bd:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8011c3:	e8 56 1b 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  8011c8:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[4]);
  8011ce:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  8011d4:	83 ec 0c             	sub    $0xc,%esp
  8011d7:	50                   	push   %eax
  8011d8:	e8 e8 17 00 00       	call   8029c5 <free>
  8011dd:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2) panic("Wrong free: Extra or less pages are removed from PageFile");
  8011e0:	e8 39 1b 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  8011e5:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  8011eb:	29 c2                	sub    %eax,%edx
  8011ed:	89 d0                	mov    %edx,%eax
  8011ef:	83 f8 02             	cmp    $0x2,%eax
  8011f2:	74 17                	je     80120b <_main+0x11d3>
  8011f4:	83 ec 04             	sub    $0x4,%esp
  8011f7:	68 3c 35 80 00       	push   $0x80353c
  8011fc:	68 33 01 00 00       	push   $0x133
  801201:	68 2b 34 80 00       	push   $0x80342b
  801206:	e8 7e 05 00 00       	call   801789 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80120b:	e8 8b 1a 00 00       	call   802c9b <sys_calculate_free_frames>
  801210:	89 c2                	mov    %eax,%edx
  801212:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801218:	29 c2                	sub    %eax,%edx
  80121a:	89 d0                	mov    %edx,%eax
  80121c:	83 f8 02             	cmp    $0x2,%eax
  80121f:	74 17                	je     801238 <_main+0x1200>
  801221:	83 ec 04             	sub    $0x4,%esp
  801224:	68 78 35 80 00       	push   $0x803578
  801229:	68 34 01 00 00       	push   $0x134
  80122e:	68 2b 34 80 00       	push   $0x80342b
  801233:	e8 51 05 00 00       	call   801789 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(structArr[0]));
  801238:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80123e:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(structArr[lastIndexOfStruct]));
  801244:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80124a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  801251:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  801257:	01 d0                	add    %edx,%eax
  801259:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  80125f:	83 ec 08             	sub    $0x8,%esp
  801262:	6a 02                	push   $0x2
  801264:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  80126a:	50                   	push   %eax
  80126b:	e8 ff 1e 00 00       	call   80316f <sys_check_LRU_lists_free>
  801270:	83 c4 10             	add    $0x10,%esp
  801273:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  801279:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  801280:	74 17                	je     801299 <_main+0x1261>
		{
				panic("free: page is not removed from LRU lists");
  801282:	83 ec 04             	sub    $0x4,%esp
  801285:	68 c4 35 80 00       	push   $0x8035c4
  80128a:	68 42 01 00 00       	push   $0x142
  80128f:	68 2b 34 80 00       	push   $0x80342b
  801294:	e8 f0 04 00 00       	call   801789 <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 795 && LIST_SIZE(&myEnv->SecondList) != 0)
  801299:	a1 20 40 80 00       	mov    0x804020,%eax
  80129e:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  8012a4:	3d 1b 03 00 00       	cmp    $0x31b,%eax
  8012a9:	74 26                	je     8012d1 <_main+0x1299>
  8012ab:	a1 20 40 80 00       	mov    0x804020,%eax
  8012b0:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  8012b6:	85 c0                	test   %eax,%eax
  8012b8:	74 17                	je     8012d1 <_main+0x1299>
		{
			panic("LRU lists content is not correct");
  8012ba:	83 ec 04             	sub    $0x4,%esp
  8012bd:	68 f0 35 80 00       	push   $0x8035f0
  8012c2:	68 47 01 00 00       	push   $0x147
  8012c7:	68 2b 34 80 00       	push   $0x80342b
  8012cc:	e8 b8 04 00 00       	call   801789 <_panic>
		}

		//Free 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8012d1:	e8 c5 19 00 00       	call   802c9b <sys_calculate_free_frames>
  8012d6:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8012dc:	e8 3d 1a 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  8012e1:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[5]);
  8012e7:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  8012ed:	83 ec 0c             	sub    $0xc,%esp
  8012f0:	50                   	push   %eax
  8012f1:	e8 cf 16 00 00       	call   8029c5 <free>
  8012f6:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
  8012f9:	e8 20 1a 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  8012fe:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801304:	89 d1                	mov    %edx,%ecx
  801306:	29 c1                	sub    %eax,%ecx
  801308:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80130b:	89 c2                	mov    %eax,%edx
  80130d:	01 d2                	add    %edx,%edx
  80130f:	01 d0                	add    %edx,%eax
  801311:	85 c0                	test   %eax,%eax
  801313:	79 05                	jns    80131a <_main+0x12e2>
  801315:	05 ff 0f 00 00       	add    $0xfff,%eax
  80131a:	c1 f8 0c             	sar    $0xc,%eax
  80131d:	39 c1                	cmp    %eax,%ecx
  80131f:	74 17                	je     801338 <_main+0x1300>
  801321:	83 ec 04             	sub    $0x4,%esp
  801324:	68 3c 35 80 00       	push   $0x80353c
  801329:	68 4e 01 00 00       	push   $0x14e
  80132e:	68 2b 34 80 00       	push   $0x80342b
  801333:	e8 51 04 00 00       	call   801789 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != toAccess) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801338:	e8 5e 19 00 00       	call   802c9b <sys_calculate_free_frames>
  80133d:	89 c2                	mov    %eax,%edx
  80133f:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801345:	29 c2                	sub    %eax,%edx
  801347:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80134a:	39 c2                	cmp    %eax,%edx
  80134c:	74 17                	je     801365 <_main+0x132d>
  80134e:	83 ec 04             	sub    $0x4,%esp
  801351:	68 78 35 80 00       	push   $0x803578
  801356:	68 4f 01 00 00       	push   $0x14f
  80135b:	68 2b 34 80 00       	push   $0x80342b
  801360:	e8 24 04 00 00       	call   801789 <_panic>

		//Free 1st 3 KB
		freeFrames = sys_calculate_free_frames() ;
  801365:	e8 31 19 00 00       	call   802c9b <sys_calculate_free_frames>
  80136a:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801370:	e8 a9 19 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  801375:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[2]);
  80137b:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  801381:	83 ec 0c             	sub    $0xc,%esp
  801384:	50                   	push   %eax
  801385:	e8 3b 16 00 00       	call   8029c5 <free>
  80138a:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  80138d:	e8 8c 19 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  801392:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801398:	29 c2                	sub    %eax,%edx
  80139a:	89 d0                	mov    %edx,%eax
  80139c:	83 f8 01             	cmp    $0x1,%eax
  80139f:	74 17                	je     8013b8 <_main+0x1380>
  8013a1:	83 ec 04             	sub    $0x4,%esp
  8013a4:	68 3c 35 80 00       	push   $0x80353c
  8013a9:	68 55 01 00 00       	push   $0x155
  8013ae:	68 2b 34 80 00       	push   $0x80342b
  8013b3:	e8 d1 03 00 00       	call   801789 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 1 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8013b8:	e8 de 18 00 00       	call   802c9b <sys_calculate_free_frames>
  8013bd:	89 c2                	mov    %eax,%edx
  8013bf:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  8013c5:	29 c2                	sub    %eax,%edx
  8013c7:	89 d0                	mov    %edx,%eax
  8013c9:	83 f8 02             	cmp    $0x2,%eax
  8013cc:	74 17                	je     8013e5 <_main+0x13ad>
  8013ce:	83 ec 04             	sub    $0x4,%esp
  8013d1:	68 78 35 80 00       	push   $0x803578
  8013d6:	68 56 01 00 00       	push   $0x156
  8013db:	68 2b 34 80 00       	push   $0x80342b
  8013e0:	e8 a4 03 00 00       	call   801789 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(intArr[0]));
  8013e5:	8b 45 88             	mov    -0x78(%ebp),%eax
  8013e8:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(intArr[lastIndexOfInt]));
  8013ee:	8b 45 84             	mov    -0x7c(%ebp),%eax
  8013f1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013f8:	8b 45 88             	mov    -0x78(%ebp),%eax
  8013fb:	01 d0                	add    %edx,%eax
  8013fd:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  801403:	83 ec 08             	sub    $0x8,%esp
  801406:	6a 02                	push   $0x2
  801408:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  80140e:	50                   	push   %eax
  80140f:	e8 5b 1d 00 00       	call   80316f <sys_check_LRU_lists_free>
  801414:	83 c4 10             	add    $0x10,%esp
  801417:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  80141d:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  801424:	74 17                	je     80143d <_main+0x1405>
		{
				panic("free: page is not removed from LRU lists");
  801426:	83 ec 04             	sub    $0x4,%esp
  801429:	68 c4 35 80 00       	push   $0x8035c4
  80142e:	68 64 01 00 00       	push   $0x164
  801433:	68 2b 34 80 00       	push   $0x80342b
  801438:	e8 4c 03 00 00       	call   801789 <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 794 && LIST_SIZE(&myEnv->SecondList) != 0)
  80143d:	a1 20 40 80 00       	mov    0x804020,%eax
  801442:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  801448:	3d 1a 03 00 00       	cmp    $0x31a,%eax
  80144d:	74 26                	je     801475 <_main+0x143d>
  80144f:	a1 20 40 80 00       	mov    0x804020,%eax
  801454:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  80145a:	85 c0                	test   %eax,%eax
  80145c:	74 17                	je     801475 <_main+0x143d>
		{
			panic("LRU lists content is not correct");
  80145e:	83 ec 04             	sub    $0x4,%esp
  801461:	68 f0 35 80 00       	push   $0x8035f0
  801466:	68 69 01 00 00       	push   $0x169
  80146b:	68 2b 34 80 00       	push   $0x80342b
  801470:	e8 14 03 00 00       	call   801789 <_panic>
		}

		//Free 2nd 3 KB
		freeFrames = sys_calculate_free_frames() ;
  801475:	e8 21 18 00 00       	call   802c9b <sys_calculate_free_frames>
  80147a:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801480:	e8 99 18 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  801485:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[3]);
  80148b:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  801491:	83 ec 0c             	sub    $0xc,%esp
  801494:	50                   	push   %eax
  801495:	e8 2b 15 00 00       	call   8029c5 <free>
  80149a:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  80149d:	e8 7c 18 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  8014a2:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  8014a8:	29 c2                	sub    %eax,%edx
  8014aa:	89 d0                	mov    %edx,%eax
  8014ac:	83 f8 01             	cmp    $0x1,%eax
  8014af:	74 17                	je     8014c8 <_main+0x1490>
  8014b1:	83 ec 04             	sub    $0x4,%esp
  8014b4:	68 3c 35 80 00       	push   $0x80353c
  8014b9:	68 70 01 00 00       	push   $0x170
  8014be:	68 2b 34 80 00       	push   $0x80342b
  8014c3:	e8 c1 02 00 00       	call   801789 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8014c8:	e8 ce 17 00 00       	call   802c9b <sys_calculate_free_frames>
  8014cd:	89 c2                	mov    %eax,%edx
  8014cf:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  8014d5:	39 c2                	cmp    %eax,%edx
  8014d7:	74 17                	je     8014f0 <_main+0x14b8>
  8014d9:	83 ec 04             	sub    $0x4,%esp
  8014dc:	68 78 35 80 00       	push   $0x803578
  8014e1:	68 71 01 00 00       	push   $0x171
  8014e6:	68 2b 34 80 00       	push   $0x80342b
  8014eb:	e8 99 02 00 00       	call   801789 <_panic>

		//Free last 14 KB
		freeFrames = sys_calculate_free_frames() ;
  8014f0:	e8 a6 17 00 00       	call   802c9b <sys_calculate_free_frames>
  8014f5:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8014fb:	e8 1e 18 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  801500:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[7]);
  801506:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  80150c:	83 ec 0c             	sub    $0xc,%esp
  80150f:	50                   	push   %eax
  801510:	e8 b0 14 00 00       	call   8029c5 <free>
  801515:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 4) panic("Wrong free: Extra or less pages are removed from PageFile");
  801518:	e8 01 18 00 00       	call   802d1e <sys_pf_calculate_allocated_pages>
  80151d:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801523:	29 c2                	sub    %eax,%edx
  801525:	89 d0                	mov    %edx,%eax
  801527:	83 f8 04             	cmp    $0x4,%eax
  80152a:	74 17                	je     801543 <_main+0x150b>
  80152c:	83 ec 04             	sub    $0x4,%esp
  80152f:	68 3c 35 80 00       	push   $0x80353c
  801534:	68 77 01 00 00       	push   $0x177
  801539:	68 2b 34 80 00       	push   $0x80342b
  80153e:	e8 46 02 00 00       	call   801789 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801543:	e8 53 17 00 00       	call   802c9b <sys_calculate_free_frames>
  801548:	89 c2                	mov    %eax,%edx
  80154a:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801550:	29 c2                	sub    %eax,%edx
  801552:	89 d0                	mov    %edx,%eax
  801554:	83 f8 03             	cmp    $0x3,%eax
  801557:	74 17                	je     801570 <_main+0x1538>
  801559:	83 ec 04             	sub    $0x4,%esp
  80155c:	68 78 35 80 00       	push   $0x803578
  801561:	68 78 01 00 00       	push   $0x178
  801566:	68 2b 34 80 00       	push   $0x80342b
  80156b:	e8 19 02 00 00       	call   801789 <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(shortArr2[0]));
  801570:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  801576:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(shortArr2[lastIndexOfShort2]));
  80157c:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  801582:	01 c0                	add    %eax,%eax
  801584:	89 c2                	mov    %eax,%edx
  801586:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  80158c:	01 d0                	add    %edx,%eax
  80158e:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  801594:	83 ec 08             	sub    $0x8,%esp
  801597:	6a 02                	push   $0x2
  801599:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  80159f:	50                   	push   %eax
  8015a0:	e8 ca 1b 00 00       	call   80316f <sys_check_LRU_lists_free>
  8015a5:	83 c4 10             	add    $0x10,%esp
  8015a8:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  8015ae:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  8015b5:	74 17                	je     8015ce <_main+0x1596>
		{
				panic("free: page is not removed from LRU lists");
  8015b7:	83 ec 04             	sub    $0x4,%esp
  8015ba:	68 c4 35 80 00       	push   $0x8035c4
  8015bf:	68 86 01 00 00       	push   $0x186
  8015c4:	68 2b 34 80 00       	push   $0x80342b
  8015c9:	e8 bb 01 00 00       	call   801789 <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 792 && LIST_SIZE(&myEnv->SecondList) != 0)
  8015ce:	a1 20 40 80 00       	mov    0x804020,%eax
  8015d3:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  8015d9:	3d 18 03 00 00       	cmp    $0x318,%eax
  8015de:	74 26                	je     801606 <_main+0x15ce>
  8015e0:	a1 20 40 80 00       	mov    0x804020,%eax
  8015e5:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  8015eb:	85 c0                	test   %eax,%eax
  8015ed:	74 17                	je     801606 <_main+0x15ce>
		{
			panic("LRU lists content is not correct");
  8015ef:	83 ec 04             	sub    $0x4,%esp
  8015f2:	68 f0 35 80 00       	push   $0x8035f0
  8015f7:	68 8b 01 00 00       	push   $0x18b
  8015fc:	68 2b 34 80 00       	push   $0x80342b
  801601:	e8 83 01 00 00       	call   801789 <_panic>
		}

			if(start_freeFrames != (sys_calculate_free_frames() + 4)) {panic("Wrong free: not all pages removed correctly at end");}
  801606:	e8 90 16 00 00       	call   802c9b <sys_calculate_free_frames>
  80160b:	8d 50 04             	lea    0x4(%eax),%edx
  80160e:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801611:	39 c2                	cmp    %eax,%edx
  801613:	74 17                	je     80162c <_main+0x15f4>
  801615:	83 ec 04             	sub    $0x4,%esp
  801618:	68 14 36 80 00       	push   $0x803614
  80161d:	68 8e 01 00 00       	push   $0x18e
  801622:	68 2b 34 80 00       	push   $0x80342b
  801627:	e8 5d 01 00 00       	call   801789 <_panic>
		}

		cprintf("Congratulations!! test free [1] completed successfully.\n");
  80162c:	83 ec 0c             	sub    $0xc,%esp
  80162f:	68 48 36 80 00       	push   $0x803648
  801634:	e8 f2 03 00 00       	call   801a2b <cprintf>
  801639:	83 c4 10             	add    $0x10,%esp

	return;
  80163c:	90                   	nop
}
  80163d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801640:	5b                   	pop    %ebx
  801641:	5f                   	pop    %edi
  801642:	5d                   	pop    %ebp
  801643:	c3                   	ret    

00801644 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  801644:	55                   	push   %ebp
  801645:	89 e5                	mov    %esp,%ebp
  801647:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80164a:	e8 81 15 00 00       	call   802bd0 <sys_getenvindex>
  80164f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  801652:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801655:	89 d0                	mov    %edx,%eax
  801657:	c1 e0 03             	shl    $0x3,%eax
  80165a:	01 d0                	add    %edx,%eax
  80165c:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  801663:	01 c8                	add    %ecx,%eax
  801665:	01 c0                	add    %eax,%eax
  801667:	01 d0                	add    %edx,%eax
  801669:	01 c0                	add    %eax,%eax
  80166b:	01 d0                	add    %edx,%eax
  80166d:	89 c2                	mov    %eax,%edx
  80166f:	c1 e2 05             	shl    $0x5,%edx
  801672:	29 c2                	sub    %eax,%edx
  801674:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80167b:	89 c2                	mov    %eax,%edx
  80167d:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  801683:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  801688:	a1 20 40 80 00       	mov    0x804020,%eax
  80168d:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  801693:	84 c0                	test   %al,%al
  801695:	74 0f                	je     8016a6 <libmain+0x62>
		binaryname = myEnv->prog_name;
  801697:	a1 20 40 80 00       	mov    0x804020,%eax
  80169c:	05 40 3c 01 00       	add    $0x13c40,%eax
  8016a1:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8016a6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8016aa:	7e 0a                	jle    8016b6 <libmain+0x72>
		binaryname = argv[0];
  8016ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016af:	8b 00                	mov    (%eax),%eax
  8016b1:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  8016b6:	83 ec 08             	sub    $0x8,%esp
  8016b9:	ff 75 0c             	pushl  0xc(%ebp)
  8016bc:	ff 75 08             	pushl  0x8(%ebp)
  8016bf:	e8 74 e9 ff ff       	call   800038 <_main>
  8016c4:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8016c7:	e8 9f 16 00 00       	call   802d6b <sys_disable_interrupt>
	cprintf("**************************************\n");
  8016cc:	83 ec 0c             	sub    $0xc,%esp
  8016cf:	68 9c 36 80 00       	push   $0x80369c
  8016d4:	e8 52 03 00 00       	call   801a2b <cprintf>
  8016d9:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8016dc:	a1 20 40 80 00       	mov    0x804020,%eax
  8016e1:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8016e7:	a1 20 40 80 00       	mov    0x804020,%eax
  8016ec:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8016f2:	83 ec 04             	sub    $0x4,%esp
  8016f5:	52                   	push   %edx
  8016f6:	50                   	push   %eax
  8016f7:	68 c4 36 80 00       	push   $0x8036c4
  8016fc:	e8 2a 03 00 00       	call   801a2b <cprintf>
  801701:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  801704:	a1 20 40 80 00       	mov    0x804020,%eax
  801709:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80170f:	a1 20 40 80 00       	mov    0x804020,%eax
  801714:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80171a:	83 ec 04             	sub    $0x4,%esp
  80171d:	52                   	push   %edx
  80171e:	50                   	push   %eax
  80171f:	68 ec 36 80 00       	push   $0x8036ec
  801724:	e8 02 03 00 00       	call   801a2b <cprintf>
  801729:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80172c:	a1 20 40 80 00       	mov    0x804020,%eax
  801731:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  801737:	83 ec 08             	sub    $0x8,%esp
  80173a:	50                   	push   %eax
  80173b:	68 2d 37 80 00       	push   $0x80372d
  801740:	e8 e6 02 00 00       	call   801a2b <cprintf>
  801745:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  801748:	83 ec 0c             	sub    $0xc,%esp
  80174b:	68 9c 36 80 00       	push   $0x80369c
  801750:	e8 d6 02 00 00       	call   801a2b <cprintf>
  801755:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  801758:	e8 28 16 00 00       	call   802d85 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80175d:	e8 19 00 00 00       	call   80177b <exit>
}
  801762:	90                   	nop
  801763:	c9                   	leave  
  801764:	c3                   	ret    

00801765 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  801765:	55                   	push   %ebp
  801766:	89 e5                	mov    %esp,%ebp
  801768:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80176b:	83 ec 0c             	sub    $0xc,%esp
  80176e:	6a 00                	push   $0x0
  801770:	e8 27 14 00 00       	call   802b9c <sys_env_destroy>
  801775:	83 c4 10             	add    $0x10,%esp
}
  801778:	90                   	nop
  801779:	c9                   	leave  
  80177a:	c3                   	ret    

0080177b <exit>:

void
exit(void)
{
  80177b:	55                   	push   %ebp
  80177c:	89 e5                	mov    %esp,%ebp
  80177e:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  801781:	e8 7c 14 00 00       	call   802c02 <sys_env_exit>
}
  801786:	90                   	nop
  801787:	c9                   	leave  
  801788:	c3                   	ret    

00801789 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801789:	55                   	push   %ebp
  80178a:	89 e5                	mov    %esp,%ebp
  80178c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80178f:	8d 45 10             	lea    0x10(%ebp),%eax
  801792:	83 c0 04             	add    $0x4,%eax
  801795:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801798:	a1 18 41 80 00       	mov    0x804118,%eax
  80179d:	85 c0                	test   %eax,%eax
  80179f:	74 16                	je     8017b7 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8017a1:	a1 18 41 80 00       	mov    0x804118,%eax
  8017a6:	83 ec 08             	sub    $0x8,%esp
  8017a9:	50                   	push   %eax
  8017aa:	68 44 37 80 00       	push   $0x803744
  8017af:	e8 77 02 00 00       	call   801a2b <cprintf>
  8017b4:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8017b7:	a1 00 40 80 00       	mov    0x804000,%eax
  8017bc:	ff 75 0c             	pushl  0xc(%ebp)
  8017bf:	ff 75 08             	pushl  0x8(%ebp)
  8017c2:	50                   	push   %eax
  8017c3:	68 49 37 80 00       	push   $0x803749
  8017c8:	e8 5e 02 00 00       	call   801a2b <cprintf>
  8017cd:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8017d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8017d3:	83 ec 08             	sub    $0x8,%esp
  8017d6:	ff 75 f4             	pushl  -0xc(%ebp)
  8017d9:	50                   	push   %eax
  8017da:	e8 e1 01 00 00       	call   8019c0 <vcprintf>
  8017df:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8017e2:	83 ec 08             	sub    $0x8,%esp
  8017e5:	6a 00                	push   $0x0
  8017e7:	68 65 37 80 00       	push   $0x803765
  8017ec:	e8 cf 01 00 00       	call   8019c0 <vcprintf>
  8017f1:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8017f4:	e8 82 ff ff ff       	call   80177b <exit>

	// should not return here
	while (1) ;
  8017f9:	eb fe                	jmp    8017f9 <_panic+0x70>

008017fb <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8017fb:	55                   	push   %ebp
  8017fc:	89 e5                	mov    %esp,%ebp
  8017fe:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801801:	a1 20 40 80 00       	mov    0x804020,%eax
  801806:	8b 50 74             	mov    0x74(%eax),%edx
  801809:	8b 45 0c             	mov    0xc(%ebp),%eax
  80180c:	39 c2                	cmp    %eax,%edx
  80180e:	74 14                	je     801824 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801810:	83 ec 04             	sub    $0x4,%esp
  801813:	68 68 37 80 00       	push   $0x803768
  801818:	6a 26                	push   $0x26
  80181a:	68 b4 37 80 00       	push   $0x8037b4
  80181f:	e8 65 ff ff ff       	call   801789 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801824:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80182b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801832:	e9 b6 00 00 00       	jmp    8018ed <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801837:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80183a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801841:	8b 45 08             	mov    0x8(%ebp),%eax
  801844:	01 d0                	add    %edx,%eax
  801846:	8b 00                	mov    (%eax),%eax
  801848:	85 c0                	test   %eax,%eax
  80184a:	75 08                	jne    801854 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80184c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80184f:	e9 96 00 00 00       	jmp    8018ea <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  801854:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80185b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801862:	eb 5d                	jmp    8018c1 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801864:	a1 20 40 80 00       	mov    0x804020,%eax
  801869:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80186f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801872:	c1 e2 04             	shl    $0x4,%edx
  801875:	01 d0                	add    %edx,%eax
  801877:	8a 40 04             	mov    0x4(%eax),%al
  80187a:	84 c0                	test   %al,%al
  80187c:	75 40                	jne    8018be <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80187e:	a1 20 40 80 00       	mov    0x804020,%eax
  801883:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801889:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80188c:	c1 e2 04             	shl    $0x4,%edx
  80188f:	01 d0                	add    %edx,%eax
  801891:	8b 00                	mov    (%eax),%eax
  801893:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801896:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801899:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80189e:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8018a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018a3:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8018aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ad:	01 c8                	add    %ecx,%eax
  8018af:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8018b1:	39 c2                	cmp    %eax,%edx
  8018b3:	75 09                	jne    8018be <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8018b5:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8018bc:	eb 12                	jmp    8018d0 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8018be:	ff 45 e8             	incl   -0x18(%ebp)
  8018c1:	a1 20 40 80 00       	mov    0x804020,%eax
  8018c6:	8b 50 74             	mov    0x74(%eax),%edx
  8018c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8018cc:	39 c2                	cmp    %eax,%edx
  8018ce:	77 94                	ja     801864 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8018d0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8018d4:	75 14                	jne    8018ea <CheckWSWithoutLastIndex+0xef>
			panic(
  8018d6:	83 ec 04             	sub    $0x4,%esp
  8018d9:	68 c0 37 80 00       	push   $0x8037c0
  8018de:	6a 3a                	push   $0x3a
  8018e0:	68 b4 37 80 00       	push   $0x8037b4
  8018e5:	e8 9f fe ff ff       	call   801789 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8018ea:	ff 45 f0             	incl   -0x10(%ebp)
  8018ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018f0:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8018f3:	0f 8c 3e ff ff ff    	jl     801837 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8018f9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801900:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801907:	eb 20                	jmp    801929 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801909:	a1 20 40 80 00       	mov    0x804020,%eax
  80190e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801914:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801917:	c1 e2 04             	shl    $0x4,%edx
  80191a:	01 d0                	add    %edx,%eax
  80191c:	8a 40 04             	mov    0x4(%eax),%al
  80191f:	3c 01                	cmp    $0x1,%al
  801921:	75 03                	jne    801926 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  801923:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801926:	ff 45 e0             	incl   -0x20(%ebp)
  801929:	a1 20 40 80 00       	mov    0x804020,%eax
  80192e:	8b 50 74             	mov    0x74(%eax),%edx
  801931:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801934:	39 c2                	cmp    %eax,%edx
  801936:	77 d1                	ja     801909 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801938:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80193b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80193e:	74 14                	je     801954 <CheckWSWithoutLastIndex+0x159>
		panic(
  801940:	83 ec 04             	sub    $0x4,%esp
  801943:	68 14 38 80 00       	push   $0x803814
  801948:	6a 44                	push   $0x44
  80194a:	68 b4 37 80 00       	push   $0x8037b4
  80194f:	e8 35 fe ff ff       	call   801789 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801954:	90                   	nop
  801955:	c9                   	leave  
  801956:	c3                   	ret    

00801957 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  801957:	55                   	push   %ebp
  801958:	89 e5                	mov    %esp,%ebp
  80195a:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80195d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801960:	8b 00                	mov    (%eax),%eax
  801962:	8d 48 01             	lea    0x1(%eax),%ecx
  801965:	8b 55 0c             	mov    0xc(%ebp),%edx
  801968:	89 0a                	mov    %ecx,(%edx)
  80196a:	8b 55 08             	mov    0x8(%ebp),%edx
  80196d:	88 d1                	mov    %dl,%cl
  80196f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801972:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  801976:	8b 45 0c             	mov    0xc(%ebp),%eax
  801979:	8b 00                	mov    (%eax),%eax
  80197b:	3d ff 00 00 00       	cmp    $0xff,%eax
  801980:	75 2c                	jne    8019ae <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  801982:	a0 24 40 80 00       	mov    0x804024,%al
  801987:	0f b6 c0             	movzbl %al,%eax
  80198a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80198d:	8b 12                	mov    (%edx),%edx
  80198f:	89 d1                	mov    %edx,%ecx
  801991:	8b 55 0c             	mov    0xc(%ebp),%edx
  801994:	83 c2 08             	add    $0x8,%edx
  801997:	83 ec 04             	sub    $0x4,%esp
  80199a:	50                   	push   %eax
  80199b:	51                   	push   %ecx
  80199c:	52                   	push   %edx
  80199d:	e8 b8 11 00 00       	call   802b5a <sys_cputs>
  8019a2:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8019a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019a8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8019ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019b1:	8b 40 04             	mov    0x4(%eax),%eax
  8019b4:	8d 50 01             	lea    0x1(%eax),%edx
  8019b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019ba:	89 50 04             	mov    %edx,0x4(%eax)
}
  8019bd:	90                   	nop
  8019be:	c9                   	leave  
  8019bf:	c3                   	ret    

008019c0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8019c0:	55                   	push   %ebp
  8019c1:	89 e5                	mov    %esp,%ebp
  8019c3:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8019c9:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8019d0:	00 00 00 
	b.cnt = 0;
  8019d3:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8019da:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8019dd:	ff 75 0c             	pushl  0xc(%ebp)
  8019e0:	ff 75 08             	pushl  0x8(%ebp)
  8019e3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8019e9:	50                   	push   %eax
  8019ea:	68 57 19 80 00       	push   $0x801957
  8019ef:	e8 11 02 00 00       	call   801c05 <vprintfmt>
  8019f4:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8019f7:	a0 24 40 80 00       	mov    0x804024,%al
  8019fc:	0f b6 c0             	movzbl %al,%eax
  8019ff:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  801a05:	83 ec 04             	sub    $0x4,%esp
  801a08:	50                   	push   %eax
  801a09:	52                   	push   %edx
  801a0a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801a10:	83 c0 08             	add    $0x8,%eax
  801a13:	50                   	push   %eax
  801a14:	e8 41 11 00 00       	call   802b5a <sys_cputs>
  801a19:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801a1c:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  801a23:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801a29:	c9                   	leave  
  801a2a:	c3                   	ret    

00801a2b <cprintf>:

int cprintf(const char *fmt, ...) {
  801a2b:	55                   	push   %ebp
  801a2c:	89 e5                	mov    %esp,%ebp
  801a2e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  801a31:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  801a38:	8d 45 0c             	lea    0xc(%ebp),%eax
  801a3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801a3e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a41:	83 ec 08             	sub    $0x8,%esp
  801a44:	ff 75 f4             	pushl  -0xc(%ebp)
  801a47:	50                   	push   %eax
  801a48:	e8 73 ff ff ff       	call   8019c0 <vcprintf>
  801a4d:	83 c4 10             	add    $0x10,%esp
  801a50:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  801a53:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a56:	c9                   	leave  
  801a57:	c3                   	ret    

00801a58 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801a58:	55                   	push   %ebp
  801a59:	89 e5                	mov    %esp,%ebp
  801a5b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801a5e:	e8 08 13 00 00       	call   802d6b <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801a63:	8d 45 0c             	lea    0xc(%ebp),%eax
  801a66:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801a69:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6c:	83 ec 08             	sub    $0x8,%esp
  801a6f:	ff 75 f4             	pushl  -0xc(%ebp)
  801a72:	50                   	push   %eax
  801a73:	e8 48 ff ff ff       	call   8019c0 <vcprintf>
  801a78:	83 c4 10             	add    $0x10,%esp
  801a7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801a7e:	e8 02 13 00 00       	call   802d85 <sys_enable_interrupt>
	return cnt;
  801a83:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a86:	c9                   	leave  
  801a87:	c3                   	ret    

00801a88 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801a88:	55                   	push   %ebp
  801a89:	89 e5                	mov    %esp,%ebp
  801a8b:	53                   	push   %ebx
  801a8c:	83 ec 14             	sub    $0x14,%esp
  801a8f:	8b 45 10             	mov    0x10(%ebp),%eax
  801a92:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801a95:	8b 45 14             	mov    0x14(%ebp),%eax
  801a98:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801a9b:	8b 45 18             	mov    0x18(%ebp),%eax
  801a9e:	ba 00 00 00 00       	mov    $0x0,%edx
  801aa3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801aa6:	77 55                	ja     801afd <printnum+0x75>
  801aa8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801aab:	72 05                	jb     801ab2 <printnum+0x2a>
  801aad:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ab0:	77 4b                	ja     801afd <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801ab2:	8b 45 1c             	mov    0x1c(%ebp),%eax
  801ab5:	8d 58 ff             	lea    -0x1(%eax),%ebx
  801ab8:	8b 45 18             	mov    0x18(%ebp),%eax
  801abb:	ba 00 00 00 00       	mov    $0x0,%edx
  801ac0:	52                   	push   %edx
  801ac1:	50                   	push   %eax
  801ac2:	ff 75 f4             	pushl  -0xc(%ebp)
  801ac5:	ff 75 f0             	pushl  -0x10(%ebp)
  801ac8:	e8 bf 16 00 00       	call   80318c <__udivdi3>
  801acd:	83 c4 10             	add    $0x10,%esp
  801ad0:	83 ec 04             	sub    $0x4,%esp
  801ad3:	ff 75 20             	pushl  0x20(%ebp)
  801ad6:	53                   	push   %ebx
  801ad7:	ff 75 18             	pushl  0x18(%ebp)
  801ada:	52                   	push   %edx
  801adb:	50                   	push   %eax
  801adc:	ff 75 0c             	pushl  0xc(%ebp)
  801adf:	ff 75 08             	pushl  0x8(%ebp)
  801ae2:	e8 a1 ff ff ff       	call   801a88 <printnum>
  801ae7:	83 c4 20             	add    $0x20,%esp
  801aea:	eb 1a                	jmp    801b06 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801aec:	83 ec 08             	sub    $0x8,%esp
  801aef:	ff 75 0c             	pushl  0xc(%ebp)
  801af2:	ff 75 20             	pushl  0x20(%ebp)
  801af5:	8b 45 08             	mov    0x8(%ebp),%eax
  801af8:	ff d0                	call   *%eax
  801afa:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801afd:	ff 4d 1c             	decl   0x1c(%ebp)
  801b00:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801b04:	7f e6                	jg     801aec <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801b06:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801b09:	bb 00 00 00 00       	mov    $0x0,%ebx
  801b0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b11:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b14:	53                   	push   %ebx
  801b15:	51                   	push   %ecx
  801b16:	52                   	push   %edx
  801b17:	50                   	push   %eax
  801b18:	e8 7f 17 00 00       	call   80329c <__umoddi3>
  801b1d:	83 c4 10             	add    $0x10,%esp
  801b20:	05 74 3a 80 00       	add    $0x803a74,%eax
  801b25:	8a 00                	mov    (%eax),%al
  801b27:	0f be c0             	movsbl %al,%eax
  801b2a:	83 ec 08             	sub    $0x8,%esp
  801b2d:	ff 75 0c             	pushl  0xc(%ebp)
  801b30:	50                   	push   %eax
  801b31:	8b 45 08             	mov    0x8(%ebp),%eax
  801b34:	ff d0                	call   *%eax
  801b36:	83 c4 10             	add    $0x10,%esp
}
  801b39:	90                   	nop
  801b3a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b3d:	c9                   	leave  
  801b3e:	c3                   	ret    

00801b3f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801b3f:	55                   	push   %ebp
  801b40:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801b42:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801b46:	7e 1c                	jle    801b64 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801b48:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4b:	8b 00                	mov    (%eax),%eax
  801b4d:	8d 50 08             	lea    0x8(%eax),%edx
  801b50:	8b 45 08             	mov    0x8(%ebp),%eax
  801b53:	89 10                	mov    %edx,(%eax)
  801b55:	8b 45 08             	mov    0x8(%ebp),%eax
  801b58:	8b 00                	mov    (%eax),%eax
  801b5a:	83 e8 08             	sub    $0x8,%eax
  801b5d:	8b 50 04             	mov    0x4(%eax),%edx
  801b60:	8b 00                	mov    (%eax),%eax
  801b62:	eb 40                	jmp    801ba4 <getuint+0x65>
	else if (lflag)
  801b64:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801b68:	74 1e                	je     801b88 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6d:	8b 00                	mov    (%eax),%eax
  801b6f:	8d 50 04             	lea    0x4(%eax),%edx
  801b72:	8b 45 08             	mov    0x8(%ebp),%eax
  801b75:	89 10                	mov    %edx,(%eax)
  801b77:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7a:	8b 00                	mov    (%eax),%eax
  801b7c:	83 e8 04             	sub    $0x4,%eax
  801b7f:	8b 00                	mov    (%eax),%eax
  801b81:	ba 00 00 00 00       	mov    $0x0,%edx
  801b86:	eb 1c                	jmp    801ba4 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801b88:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8b:	8b 00                	mov    (%eax),%eax
  801b8d:	8d 50 04             	lea    0x4(%eax),%edx
  801b90:	8b 45 08             	mov    0x8(%ebp),%eax
  801b93:	89 10                	mov    %edx,(%eax)
  801b95:	8b 45 08             	mov    0x8(%ebp),%eax
  801b98:	8b 00                	mov    (%eax),%eax
  801b9a:	83 e8 04             	sub    $0x4,%eax
  801b9d:	8b 00                	mov    (%eax),%eax
  801b9f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801ba4:	5d                   	pop    %ebp
  801ba5:	c3                   	ret    

00801ba6 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801ba6:	55                   	push   %ebp
  801ba7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801ba9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801bad:	7e 1c                	jle    801bcb <getint+0x25>
		return va_arg(*ap, long long);
  801baf:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb2:	8b 00                	mov    (%eax),%eax
  801bb4:	8d 50 08             	lea    0x8(%eax),%edx
  801bb7:	8b 45 08             	mov    0x8(%ebp),%eax
  801bba:	89 10                	mov    %edx,(%eax)
  801bbc:	8b 45 08             	mov    0x8(%ebp),%eax
  801bbf:	8b 00                	mov    (%eax),%eax
  801bc1:	83 e8 08             	sub    $0x8,%eax
  801bc4:	8b 50 04             	mov    0x4(%eax),%edx
  801bc7:	8b 00                	mov    (%eax),%eax
  801bc9:	eb 38                	jmp    801c03 <getint+0x5d>
	else if (lflag)
  801bcb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801bcf:	74 1a                	je     801beb <getint+0x45>
		return va_arg(*ap, long);
  801bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd4:	8b 00                	mov    (%eax),%eax
  801bd6:	8d 50 04             	lea    0x4(%eax),%edx
  801bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bdc:	89 10                	mov    %edx,(%eax)
  801bde:	8b 45 08             	mov    0x8(%ebp),%eax
  801be1:	8b 00                	mov    (%eax),%eax
  801be3:	83 e8 04             	sub    $0x4,%eax
  801be6:	8b 00                	mov    (%eax),%eax
  801be8:	99                   	cltd   
  801be9:	eb 18                	jmp    801c03 <getint+0x5d>
	else
		return va_arg(*ap, int);
  801beb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bee:	8b 00                	mov    (%eax),%eax
  801bf0:	8d 50 04             	lea    0x4(%eax),%edx
  801bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf6:	89 10                	mov    %edx,(%eax)
  801bf8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bfb:	8b 00                	mov    (%eax),%eax
  801bfd:	83 e8 04             	sub    $0x4,%eax
  801c00:	8b 00                	mov    (%eax),%eax
  801c02:	99                   	cltd   
}
  801c03:	5d                   	pop    %ebp
  801c04:	c3                   	ret    

00801c05 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801c05:	55                   	push   %ebp
  801c06:	89 e5                	mov    %esp,%ebp
  801c08:	56                   	push   %esi
  801c09:	53                   	push   %ebx
  801c0a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801c0d:	eb 17                	jmp    801c26 <vprintfmt+0x21>
			if (ch == '\0')
  801c0f:	85 db                	test   %ebx,%ebx
  801c11:	0f 84 af 03 00 00    	je     801fc6 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801c17:	83 ec 08             	sub    $0x8,%esp
  801c1a:	ff 75 0c             	pushl  0xc(%ebp)
  801c1d:	53                   	push   %ebx
  801c1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c21:	ff d0                	call   *%eax
  801c23:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801c26:	8b 45 10             	mov    0x10(%ebp),%eax
  801c29:	8d 50 01             	lea    0x1(%eax),%edx
  801c2c:	89 55 10             	mov    %edx,0x10(%ebp)
  801c2f:	8a 00                	mov    (%eax),%al
  801c31:	0f b6 d8             	movzbl %al,%ebx
  801c34:	83 fb 25             	cmp    $0x25,%ebx
  801c37:	75 d6                	jne    801c0f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801c39:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801c3d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801c44:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801c4b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801c52:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801c59:	8b 45 10             	mov    0x10(%ebp),%eax
  801c5c:	8d 50 01             	lea    0x1(%eax),%edx
  801c5f:	89 55 10             	mov    %edx,0x10(%ebp)
  801c62:	8a 00                	mov    (%eax),%al
  801c64:	0f b6 d8             	movzbl %al,%ebx
  801c67:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801c6a:	83 f8 55             	cmp    $0x55,%eax
  801c6d:	0f 87 2b 03 00 00    	ja     801f9e <vprintfmt+0x399>
  801c73:	8b 04 85 98 3a 80 00 	mov    0x803a98(,%eax,4),%eax
  801c7a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801c7c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801c80:	eb d7                	jmp    801c59 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801c82:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801c86:	eb d1                	jmp    801c59 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801c88:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801c8f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801c92:	89 d0                	mov    %edx,%eax
  801c94:	c1 e0 02             	shl    $0x2,%eax
  801c97:	01 d0                	add    %edx,%eax
  801c99:	01 c0                	add    %eax,%eax
  801c9b:	01 d8                	add    %ebx,%eax
  801c9d:	83 e8 30             	sub    $0x30,%eax
  801ca0:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801ca3:	8b 45 10             	mov    0x10(%ebp),%eax
  801ca6:	8a 00                	mov    (%eax),%al
  801ca8:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801cab:	83 fb 2f             	cmp    $0x2f,%ebx
  801cae:	7e 3e                	jle    801cee <vprintfmt+0xe9>
  801cb0:	83 fb 39             	cmp    $0x39,%ebx
  801cb3:	7f 39                	jg     801cee <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801cb5:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801cb8:	eb d5                	jmp    801c8f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801cba:	8b 45 14             	mov    0x14(%ebp),%eax
  801cbd:	83 c0 04             	add    $0x4,%eax
  801cc0:	89 45 14             	mov    %eax,0x14(%ebp)
  801cc3:	8b 45 14             	mov    0x14(%ebp),%eax
  801cc6:	83 e8 04             	sub    $0x4,%eax
  801cc9:	8b 00                	mov    (%eax),%eax
  801ccb:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801cce:	eb 1f                	jmp    801cef <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801cd0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801cd4:	79 83                	jns    801c59 <vprintfmt+0x54>
				width = 0;
  801cd6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801cdd:	e9 77 ff ff ff       	jmp    801c59 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801ce2:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801ce9:	e9 6b ff ff ff       	jmp    801c59 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801cee:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801cef:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801cf3:	0f 89 60 ff ff ff    	jns    801c59 <vprintfmt+0x54>
				width = precision, precision = -1;
  801cf9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801cfc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801cff:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801d06:	e9 4e ff ff ff       	jmp    801c59 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801d0b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801d0e:	e9 46 ff ff ff       	jmp    801c59 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801d13:	8b 45 14             	mov    0x14(%ebp),%eax
  801d16:	83 c0 04             	add    $0x4,%eax
  801d19:	89 45 14             	mov    %eax,0x14(%ebp)
  801d1c:	8b 45 14             	mov    0x14(%ebp),%eax
  801d1f:	83 e8 04             	sub    $0x4,%eax
  801d22:	8b 00                	mov    (%eax),%eax
  801d24:	83 ec 08             	sub    $0x8,%esp
  801d27:	ff 75 0c             	pushl  0xc(%ebp)
  801d2a:	50                   	push   %eax
  801d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2e:	ff d0                	call   *%eax
  801d30:	83 c4 10             	add    $0x10,%esp
			break;
  801d33:	e9 89 02 00 00       	jmp    801fc1 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801d38:	8b 45 14             	mov    0x14(%ebp),%eax
  801d3b:	83 c0 04             	add    $0x4,%eax
  801d3e:	89 45 14             	mov    %eax,0x14(%ebp)
  801d41:	8b 45 14             	mov    0x14(%ebp),%eax
  801d44:	83 e8 04             	sub    $0x4,%eax
  801d47:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801d49:	85 db                	test   %ebx,%ebx
  801d4b:	79 02                	jns    801d4f <vprintfmt+0x14a>
				err = -err;
  801d4d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801d4f:	83 fb 64             	cmp    $0x64,%ebx
  801d52:	7f 0b                	jg     801d5f <vprintfmt+0x15a>
  801d54:	8b 34 9d e0 38 80 00 	mov    0x8038e0(,%ebx,4),%esi
  801d5b:	85 f6                	test   %esi,%esi
  801d5d:	75 19                	jne    801d78 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801d5f:	53                   	push   %ebx
  801d60:	68 85 3a 80 00       	push   $0x803a85
  801d65:	ff 75 0c             	pushl  0xc(%ebp)
  801d68:	ff 75 08             	pushl  0x8(%ebp)
  801d6b:	e8 5e 02 00 00       	call   801fce <printfmt>
  801d70:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801d73:	e9 49 02 00 00       	jmp    801fc1 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801d78:	56                   	push   %esi
  801d79:	68 8e 3a 80 00       	push   $0x803a8e
  801d7e:	ff 75 0c             	pushl  0xc(%ebp)
  801d81:	ff 75 08             	pushl  0x8(%ebp)
  801d84:	e8 45 02 00 00       	call   801fce <printfmt>
  801d89:	83 c4 10             	add    $0x10,%esp
			break;
  801d8c:	e9 30 02 00 00       	jmp    801fc1 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801d91:	8b 45 14             	mov    0x14(%ebp),%eax
  801d94:	83 c0 04             	add    $0x4,%eax
  801d97:	89 45 14             	mov    %eax,0x14(%ebp)
  801d9a:	8b 45 14             	mov    0x14(%ebp),%eax
  801d9d:	83 e8 04             	sub    $0x4,%eax
  801da0:	8b 30                	mov    (%eax),%esi
  801da2:	85 f6                	test   %esi,%esi
  801da4:	75 05                	jne    801dab <vprintfmt+0x1a6>
				p = "(null)";
  801da6:	be 91 3a 80 00       	mov    $0x803a91,%esi
			if (width > 0 && padc != '-')
  801dab:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801daf:	7e 6d                	jle    801e1e <vprintfmt+0x219>
  801db1:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801db5:	74 67                	je     801e1e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801db7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801dba:	83 ec 08             	sub    $0x8,%esp
  801dbd:	50                   	push   %eax
  801dbe:	56                   	push   %esi
  801dbf:	e8 0c 03 00 00       	call   8020d0 <strnlen>
  801dc4:	83 c4 10             	add    $0x10,%esp
  801dc7:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801dca:	eb 16                	jmp    801de2 <vprintfmt+0x1dd>
					putch(padc, putdat);
  801dcc:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801dd0:	83 ec 08             	sub    $0x8,%esp
  801dd3:	ff 75 0c             	pushl  0xc(%ebp)
  801dd6:	50                   	push   %eax
  801dd7:	8b 45 08             	mov    0x8(%ebp),%eax
  801dda:	ff d0                	call   *%eax
  801ddc:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801ddf:	ff 4d e4             	decl   -0x1c(%ebp)
  801de2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801de6:	7f e4                	jg     801dcc <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801de8:	eb 34                	jmp    801e1e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801dea:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801dee:	74 1c                	je     801e0c <vprintfmt+0x207>
  801df0:	83 fb 1f             	cmp    $0x1f,%ebx
  801df3:	7e 05                	jle    801dfa <vprintfmt+0x1f5>
  801df5:	83 fb 7e             	cmp    $0x7e,%ebx
  801df8:	7e 12                	jle    801e0c <vprintfmt+0x207>
					putch('?', putdat);
  801dfa:	83 ec 08             	sub    $0x8,%esp
  801dfd:	ff 75 0c             	pushl  0xc(%ebp)
  801e00:	6a 3f                	push   $0x3f
  801e02:	8b 45 08             	mov    0x8(%ebp),%eax
  801e05:	ff d0                	call   *%eax
  801e07:	83 c4 10             	add    $0x10,%esp
  801e0a:	eb 0f                	jmp    801e1b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801e0c:	83 ec 08             	sub    $0x8,%esp
  801e0f:	ff 75 0c             	pushl  0xc(%ebp)
  801e12:	53                   	push   %ebx
  801e13:	8b 45 08             	mov    0x8(%ebp),%eax
  801e16:	ff d0                	call   *%eax
  801e18:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801e1b:	ff 4d e4             	decl   -0x1c(%ebp)
  801e1e:	89 f0                	mov    %esi,%eax
  801e20:	8d 70 01             	lea    0x1(%eax),%esi
  801e23:	8a 00                	mov    (%eax),%al
  801e25:	0f be d8             	movsbl %al,%ebx
  801e28:	85 db                	test   %ebx,%ebx
  801e2a:	74 24                	je     801e50 <vprintfmt+0x24b>
  801e2c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801e30:	78 b8                	js     801dea <vprintfmt+0x1e5>
  801e32:	ff 4d e0             	decl   -0x20(%ebp)
  801e35:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801e39:	79 af                	jns    801dea <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801e3b:	eb 13                	jmp    801e50 <vprintfmt+0x24b>
				putch(' ', putdat);
  801e3d:	83 ec 08             	sub    $0x8,%esp
  801e40:	ff 75 0c             	pushl  0xc(%ebp)
  801e43:	6a 20                	push   $0x20
  801e45:	8b 45 08             	mov    0x8(%ebp),%eax
  801e48:	ff d0                	call   *%eax
  801e4a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801e4d:	ff 4d e4             	decl   -0x1c(%ebp)
  801e50:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801e54:	7f e7                	jg     801e3d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801e56:	e9 66 01 00 00       	jmp    801fc1 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801e5b:	83 ec 08             	sub    $0x8,%esp
  801e5e:	ff 75 e8             	pushl  -0x18(%ebp)
  801e61:	8d 45 14             	lea    0x14(%ebp),%eax
  801e64:	50                   	push   %eax
  801e65:	e8 3c fd ff ff       	call   801ba6 <getint>
  801e6a:	83 c4 10             	add    $0x10,%esp
  801e6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801e70:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801e73:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e76:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801e79:	85 d2                	test   %edx,%edx
  801e7b:	79 23                	jns    801ea0 <vprintfmt+0x29b>
				putch('-', putdat);
  801e7d:	83 ec 08             	sub    $0x8,%esp
  801e80:	ff 75 0c             	pushl  0xc(%ebp)
  801e83:	6a 2d                	push   $0x2d
  801e85:	8b 45 08             	mov    0x8(%ebp),%eax
  801e88:	ff d0                	call   *%eax
  801e8a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801e8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e90:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801e93:	f7 d8                	neg    %eax
  801e95:	83 d2 00             	adc    $0x0,%edx
  801e98:	f7 da                	neg    %edx
  801e9a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801e9d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801ea0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801ea7:	e9 bc 00 00 00       	jmp    801f68 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801eac:	83 ec 08             	sub    $0x8,%esp
  801eaf:	ff 75 e8             	pushl  -0x18(%ebp)
  801eb2:	8d 45 14             	lea    0x14(%ebp),%eax
  801eb5:	50                   	push   %eax
  801eb6:	e8 84 fc ff ff       	call   801b3f <getuint>
  801ebb:	83 c4 10             	add    $0x10,%esp
  801ebe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801ec1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801ec4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801ecb:	e9 98 00 00 00       	jmp    801f68 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801ed0:	83 ec 08             	sub    $0x8,%esp
  801ed3:	ff 75 0c             	pushl  0xc(%ebp)
  801ed6:	6a 58                	push   $0x58
  801ed8:	8b 45 08             	mov    0x8(%ebp),%eax
  801edb:	ff d0                	call   *%eax
  801edd:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801ee0:	83 ec 08             	sub    $0x8,%esp
  801ee3:	ff 75 0c             	pushl  0xc(%ebp)
  801ee6:	6a 58                	push   $0x58
  801ee8:	8b 45 08             	mov    0x8(%ebp),%eax
  801eeb:	ff d0                	call   *%eax
  801eed:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801ef0:	83 ec 08             	sub    $0x8,%esp
  801ef3:	ff 75 0c             	pushl  0xc(%ebp)
  801ef6:	6a 58                	push   $0x58
  801ef8:	8b 45 08             	mov    0x8(%ebp),%eax
  801efb:	ff d0                	call   *%eax
  801efd:	83 c4 10             	add    $0x10,%esp
			break;
  801f00:	e9 bc 00 00 00       	jmp    801fc1 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801f05:	83 ec 08             	sub    $0x8,%esp
  801f08:	ff 75 0c             	pushl  0xc(%ebp)
  801f0b:	6a 30                	push   $0x30
  801f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f10:	ff d0                	call   *%eax
  801f12:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801f15:	83 ec 08             	sub    $0x8,%esp
  801f18:	ff 75 0c             	pushl  0xc(%ebp)
  801f1b:	6a 78                	push   $0x78
  801f1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f20:	ff d0                	call   *%eax
  801f22:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801f25:	8b 45 14             	mov    0x14(%ebp),%eax
  801f28:	83 c0 04             	add    $0x4,%eax
  801f2b:	89 45 14             	mov    %eax,0x14(%ebp)
  801f2e:	8b 45 14             	mov    0x14(%ebp),%eax
  801f31:	83 e8 04             	sub    $0x4,%eax
  801f34:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801f36:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801f39:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801f40:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801f47:	eb 1f                	jmp    801f68 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801f49:	83 ec 08             	sub    $0x8,%esp
  801f4c:	ff 75 e8             	pushl  -0x18(%ebp)
  801f4f:	8d 45 14             	lea    0x14(%ebp),%eax
  801f52:	50                   	push   %eax
  801f53:	e8 e7 fb ff ff       	call   801b3f <getuint>
  801f58:	83 c4 10             	add    $0x10,%esp
  801f5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801f5e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801f61:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801f68:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801f6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801f6f:	83 ec 04             	sub    $0x4,%esp
  801f72:	52                   	push   %edx
  801f73:	ff 75 e4             	pushl  -0x1c(%ebp)
  801f76:	50                   	push   %eax
  801f77:	ff 75 f4             	pushl  -0xc(%ebp)
  801f7a:	ff 75 f0             	pushl  -0x10(%ebp)
  801f7d:	ff 75 0c             	pushl  0xc(%ebp)
  801f80:	ff 75 08             	pushl  0x8(%ebp)
  801f83:	e8 00 fb ff ff       	call   801a88 <printnum>
  801f88:	83 c4 20             	add    $0x20,%esp
			break;
  801f8b:	eb 34                	jmp    801fc1 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801f8d:	83 ec 08             	sub    $0x8,%esp
  801f90:	ff 75 0c             	pushl  0xc(%ebp)
  801f93:	53                   	push   %ebx
  801f94:	8b 45 08             	mov    0x8(%ebp),%eax
  801f97:	ff d0                	call   *%eax
  801f99:	83 c4 10             	add    $0x10,%esp
			break;
  801f9c:	eb 23                	jmp    801fc1 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801f9e:	83 ec 08             	sub    $0x8,%esp
  801fa1:	ff 75 0c             	pushl  0xc(%ebp)
  801fa4:	6a 25                	push   $0x25
  801fa6:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa9:	ff d0                	call   *%eax
  801fab:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801fae:	ff 4d 10             	decl   0x10(%ebp)
  801fb1:	eb 03                	jmp    801fb6 <vprintfmt+0x3b1>
  801fb3:	ff 4d 10             	decl   0x10(%ebp)
  801fb6:	8b 45 10             	mov    0x10(%ebp),%eax
  801fb9:	48                   	dec    %eax
  801fba:	8a 00                	mov    (%eax),%al
  801fbc:	3c 25                	cmp    $0x25,%al
  801fbe:	75 f3                	jne    801fb3 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801fc0:	90                   	nop
		}
	}
  801fc1:	e9 47 fc ff ff       	jmp    801c0d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801fc6:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801fc7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801fca:	5b                   	pop    %ebx
  801fcb:	5e                   	pop    %esi
  801fcc:	5d                   	pop    %ebp
  801fcd:	c3                   	ret    

00801fce <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801fce:	55                   	push   %ebp
  801fcf:	89 e5                	mov    %esp,%ebp
  801fd1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801fd4:	8d 45 10             	lea    0x10(%ebp),%eax
  801fd7:	83 c0 04             	add    $0x4,%eax
  801fda:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801fdd:	8b 45 10             	mov    0x10(%ebp),%eax
  801fe0:	ff 75 f4             	pushl  -0xc(%ebp)
  801fe3:	50                   	push   %eax
  801fe4:	ff 75 0c             	pushl  0xc(%ebp)
  801fe7:	ff 75 08             	pushl  0x8(%ebp)
  801fea:	e8 16 fc ff ff       	call   801c05 <vprintfmt>
  801fef:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801ff2:	90                   	nop
  801ff3:	c9                   	leave  
  801ff4:	c3                   	ret    

00801ff5 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801ff5:	55                   	push   %ebp
  801ff6:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801ff8:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ffb:	8b 40 08             	mov    0x8(%eax),%eax
  801ffe:	8d 50 01             	lea    0x1(%eax),%edx
  802001:	8b 45 0c             	mov    0xc(%ebp),%eax
  802004:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  802007:	8b 45 0c             	mov    0xc(%ebp),%eax
  80200a:	8b 10                	mov    (%eax),%edx
  80200c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80200f:	8b 40 04             	mov    0x4(%eax),%eax
  802012:	39 c2                	cmp    %eax,%edx
  802014:	73 12                	jae    802028 <sprintputch+0x33>
		*b->buf++ = ch;
  802016:	8b 45 0c             	mov    0xc(%ebp),%eax
  802019:	8b 00                	mov    (%eax),%eax
  80201b:	8d 48 01             	lea    0x1(%eax),%ecx
  80201e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802021:	89 0a                	mov    %ecx,(%edx)
  802023:	8b 55 08             	mov    0x8(%ebp),%edx
  802026:	88 10                	mov    %dl,(%eax)
}
  802028:	90                   	nop
  802029:	5d                   	pop    %ebp
  80202a:	c3                   	ret    

0080202b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80202b:	55                   	push   %ebp
  80202c:	89 e5                	mov    %esp,%ebp
  80202e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  802031:	8b 45 08             	mov    0x8(%ebp),%eax
  802034:	89 45 ec             	mov    %eax,-0x14(%ebp)
  802037:	8b 45 0c             	mov    0xc(%ebp),%eax
  80203a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80203d:	8b 45 08             	mov    0x8(%ebp),%eax
  802040:	01 d0                	add    %edx,%eax
  802042:	89 45 f0             	mov    %eax,-0x10(%ebp)
  802045:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80204c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802050:	74 06                	je     802058 <vsnprintf+0x2d>
  802052:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802056:	7f 07                	jg     80205f <vsnprintf+0x34>
		return -E_INVAL;
  802058:	b8 03 00 00 00       	mov    $0x3,%eax
  80205d:	eb 20                	jmp    80207f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80205f:	ff 75 14             	pushl  0x14(%ebp)
  802062:	ff 75 10             	pushl  0x10(%ebp)
  802065:	8d 45 ec             	lea    -0x14(%ebp),%eax
  802068:	50                   	push   %eax
  802069:	68 f5 1f 80 00       	push   $0x801ff5
  80206e:	e8 92 fb ff ff       	call   801c05 <vprintfmt>
  802073:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  802076:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802079:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80207c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80207f:	c9                   	leave  
  802080:	c3                   	ret    

00802081 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  802081:	55                   	push   %ebp
  802082:	89 e5                	mov    %esp,%ebp
  802084:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  802087:	8d 45 10             	lea    0x10(%ebp),%eax
  80208a:	83 c0 04             	add    $0x4,%eax
  80208d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  802090:	8b 45 10             	mov    0x10(%ebp),%eax
  802093:	ff 75 f4             	pushl  -0xc(%ebp)
  802096:	50                   	push   %eax
  802097:	ff 75 0c             	pushl  0xc(%ebp)
  80209a:	ff 75 08             	pushl  0x8(%ebp)
  80209d:	e8 89 ff ff ff       	call   80202b <vsnprintf>
  8020a2:	83 c4 10             	add    $0x10,%esp
  8020a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8020a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8020ab:	c9                   	leave  
  8020ac:	c3                   	ret    

008020ad <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8020ad:	55                   	push   %ebp
  8020ae:	89 e5                	mov    %esp,%ebp
  8020b0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8020b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8020ba:	eb 06                	jmp    8020c2 <strlen+0x15>
		n++;
  8020bc:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8020bf:	ff 45 08             	incl   0x8(%ebp)
  8020c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c5:	8a 00                	mov    (%eax),%al
  8020c7:	84 c0                	test   %al,%al
  8020c9:	75 f1                	jne    8020bc <strlen+0xf>
		n++;
	return n;
  8020cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8020ce:	c9                   	leave  
  8020cf:	c3                   	ret    

008020d0 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8020d0:	55                   	push   %ebp
  8020d1:	89 e5                	mov    %esp,%ebp
  8020d3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8020d6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8020dd:	eb 09                	jmp    8020e8 <strnlen+0x18>
		n++;
  8020df:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8020e2:	ff 45 08             	incl   0x8(%ebp)
  8020e5:	ff 4d 0c             	decl   0xc(%ebp)
  8020e8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8020ec:	74 09                	je     8020f7 <strnlen+0x27>
  8020ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f1:	8a 00                	mov    (%eax),%al
  8020f3:	84 c0                	test   %al,%al
  8020f5:	75 e8                	jne    8020df <strnlen+0xf>
		n++;
	return n;
  8020f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8020fa:	c9                   	leave  
  8020fb:	c3                   	ret    

008020fc <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8020fc:	55                   	push   %ebp
  8020fd:	89 e5                	mov    %esp,%ebp
  8020ff:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  802102:	8b 45 08             	mov    0x8(%ebp),%eax
  802105:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  802108:	90                   	nop
  802109:	8b 45 08             	mov    0x8(%ebp),%eax
  80210c:	8d 50 01             	lea    0x1(%eax),%edx
  80210f:	89 55 08             	mov    %edx,0x8(%ebp)
  802112:	8b 55 0c             	mov    0xc(%ebp),%edx
  802115:	8d 4a 01             	lea    0x1(%edx),%ecx
  802118:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80211b:	8a 12                	mov    (%edx),%dl
  80211d:	88 10                	mov    %dl,(%eax)
  80211f:	8a 00                	mov    (%eax),%al
  802121:	84 c0                	test   %al,%al
  802123:	75 e4                	jne    802109 <strcpy+0xd>
		/* do nothing */;
	return ret;
  802125:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802128:	c9                   	leave  
  802129:	c3                   	ret    

0080212a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80212a:	55                   	push   %ebp
  80212b:	89 e5                	mov    %esp,%ebp
  80212d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  802130:	8b 45 08             	mov    0x8(%ebp),%eax
  802133:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  802136:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80213d:	eb 1f                	jmp    80215e <strncpy+0x34>
		*dst++ = *src;
  80213f:	8b 45 08             	mov    0x8(%ebp),%eax
  802142:	8d 50 01             	lea    0x1(%eax),%edx
  802145:	89 55 08             	mov    %edx,0x8(%ebp)
  802148:	8b 55 0c             	mov    0xc(%ebp),%edx
  80214b:	8a 12                	mov    (%edx),%dl
  80214d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80214f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802152:	8a 00                	mov    (%eax),%al
  802154:	84 c0                	test   %al,%al
  802156:	74 03                	je     80215b <strncpy+0x31>
			src++;
  802158:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80215b:	ff 45 fc             	incl   -0x4(%ebp)
  80215e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802161:	3b 45 10             	cmp    0x10(%ebp),%eax
  802164:	72 d9                	jb     80213f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  802166:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  802169:	c9                   	leave  
  80216a:	c3                   	ret    

0080216b <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80216b:	55                   	push   %ebp
  80216c:	89 e5                	mov    %esp,%ebp
  80216e:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  802171:	8b 45 08             	mov    0x8(%ebp),%eax
  802174:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  802177:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80217b:	74 30                	je     8021ad <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80217d:	eb 16                	jmp    802195 <strlcpy+0x2a>
			*dst++ = *src++;
  80217f:	8b 45 08             	mov    0x8(%ebp),%eax
  802182:	8d 50 01             	lea    0x1(%eax),%edx
  802185:	89 55 08             	mov    %edx,0x8(%ebp)
  802188:	8b 55 0c             	mov    0xc(%ebp),%edx
  80218b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80218e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  802191:	8a 12                	mov    (%edx),%dl
  802193:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  802195:	ff 4d 10             	decl   0x10(%ebp)
  802198:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80219c:	74 09                	je     8021a7 <strlcpy+0x3c>
  80219e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021a1:	8a 00                	mov    (%eax),%al
  8021a3:	84 c0                	test   %al,%al
  8021a5:	75 d8                	jne    80217f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8021a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8021aa:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8021ad:	8b 55 08             	mov    0x8(%ebp),%edx
  8021b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8021b3:	29 c2                	sub    %eax,%edx
  8021b5:	89 d0                	mov    %edx,%eax
}
  8021b7:	c9                   	leave  
  8021b8:	c3                   	ret    

008021b9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8021b9:	55                   	push   %ebp
  8021ba:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8021bc:	eb 06                	jmp    8021c4 <strcmp+0xb>
		p++, q++;
  8021be:	ff 45 08             	incl   0x8(%ebp)
  8021c1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8021c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c7:	8a 00                	mov    (%eax),%al
  8021c9:	84 c0                	test   %al,%al
  8021cb:	74 0e                	je     8021db <strcmp+0x22>
  8021cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8021d0:	8a 10                	mov    (%eax),%dl
  8021d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021d5:	8a 00                	mov    (%eax),%al
  8021d7:	38 c2                	cmp    %al,%dl
  8021d9:	74 e3                	je     8021be <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8021db:	8b 45 08             	mov    0x8(%ebp),%eax
  8021de:	8a 00                	mov    (%eax),%al
  8021e0:	0f b6 d0             	movzbl %al,%edx
  8021e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021e6:	8a 00                	mov    (%eax),%al
  8021e8:	0f b6 c0             	movzbl %al,%eax
  8021eb:	29 c2                	sub    %eax,%edx
  8021ed:	89 d0                	mov    %edx,%eax
}
  8021ef:	5d                   	pop    %ebp
  8021f0:	c3                   	ret    

008021f1 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8021f1:	55                   	push   %ebp
  8021f2:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8021f4:	eb 09                	jmp    8021ff <strncmp+0xe>
		n--, p++, q++;
  8021f6:	ff 4d 10             	decl   0x10(%ebp)
  8021f9:	ff 45 08             	incl   0x8(%ebp)
  8021fc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8021ff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802203:	74 17                	je     80221c <strncmp+0x2b>
  802205:	8b 45 08             	mov    0x8(%ebp),%eax
  802208:	8a 00                	mov    (%eax),%al
  80220a:	84 c0                	test   %al,%al
  80220c:	74 0e                	je     80221c <strncmp+0x2b>
  80220e:	8b 45 08             	mov    0x8(%ebp),%eax
  802211:	8a 10                	mov    (%eax),%dl
  802213:	8b 45 0c             	mov    0xc(%ebp),%eax
  802216:	8a 00                	mov    (%eax),%al
  802218:	38 c2                	cmp    %al,%dl
  80221a:	74 da                	je     8021f6 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80221c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802220:	75 07                	jne    802229 <strncmp+0x38>
		return 0;
  802222:	b8 00 00 00 00       	mov    $0x0,%eax
  802227:	eb 14                	jmp    80223d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  802229:	8b 45 08             	mov    0x8(%ebp),%eax
  80222c:	8a 00                	mov    (%eax),%al
  80222e:	0f b6 d0             	movzbl %al,%edx
  802231:	8b 45 0c             	mov    0xc(%ebp),%eax
  802234:	8a 00                	mov    (%eax),%al
  802236:	0f b6 c0             	movzbl %al,%eax
  802239:	29 c2                	sub    %eax,%edx
  80223b:	89 d0                	mov    %edx,%eax
}
  80223d:	5d                   	pop    %ebp
  80223e:	c3                   	ret    

0080223f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80223f:	55                   	push   %ebp
  802240:	89 e5                	mov    %esp,%ebp
  802242:	83 ec 04             	sub    $0x4,%esp
  802245:	8b 45 0c             	mov    0xc(%ebp),%eax
  802248:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80224b:	eb 12                	jmp    80225f <strchr+0x20>
		if (*s == c)
  80224d:	8b 45 08             	mov    0x8(%ebp),%eax
  802250:	8a 00                	mov    (%eax),%al
  802252:	3a 45 fc             	cmp    -0x4(%ebp),%al
  802255:	75 05                	jne    80225c <strchr+0x1d>
			return (char *) s;
  802257:	8b 45 08             	mov    0x8(%ebp),%eax
  80225a:	eb 11                	jmp    80226d <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80225c:	ff 45 08             	incl   0x8(%ebp)
  80225f:	8b 45 08             	mov    0x8(%ebp),%eax
  802262:	8a 00                	mov    (%eax),%al
  802264:	84 c0                	test   %al,%al
  802266:	75 e5                	jne    80224d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  802268:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80226d:	c9                   	leave  
  80226e:	c3                   	ret    

0080226f <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80226f:	55                   	push   %ebp
  802270:	89 e5                	mov    %esp,%ebp
  802272:	83 ec 04             	sub    $0x4,%esp
  802275:	8b 45 0c             	mov    0xc(%ebp),%eax
  802278:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80227b:	eb 0d                	jmp    80228a <strfind+0x1b>
		if (*s == c)
  80227d:	8b 45 08             	mov    0x8(%ebp),%eax
  802280:	8a 00                	mov    (%eax),%al
  802282:	3a 45 fc             	cmp    -0x4(%ebp),%al
  802285:	74 0e                	je     802295 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  802287:	ff 45 08             	incl   0x8(%ebp)
  80228a:	8b 45 08             	mov    0x8(%ebp),%eax
  80228d:	8a 00                	mov    (%eax),%al
  80228f:	84 c0                	test   %al,%al
  802291:	75 ea                	jne    80227d <strfind+0xe>
  802293:	eb 01                	jmp    802296 <strfind+0x27>
		if (*s == c)
			break;
  802295:	90                   	nop
	return (char *) s;
  802296:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802299:	c9                   	leave  
  80229a:	c3                   	ret    

0080229b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80229b:	55                   	push   %ebp
  80229c:	89 e5                	mov    %esp,%ebp
  80229e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8022a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8022a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8022a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8022aa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8022ad:	eb 0e                	jmp    8022bd <memset+0x22>
		*p++ = c;
  8022af:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8022b2:	8d 50 01             	lea    0x1(%eax),%edx
  8022b5:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8022b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022bb:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8022bd:	ff 4d f8             	decl   -0x8(%ebp)
  8022c0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8022c4:	79 e9                	jns    8022af <memset+0x14>
		*p++ = c;

	return v;
  8022c6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8022c9:	c9                   	leave  
  8022ca:	c3                   	ret    

008022cb <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8022cb:	55                   	push   %ebp
  8022cc:	89 e5                	mov    %esp,%ebp
  8022ce:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8022d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8022d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8022d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8022da:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8022dd:	eb 16                	jmp    8022f5 <memcpy+0x2a>
		*d++ = *s++;
  8022df:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8022e2:	8d 50 01             	lea    0x1(%eax),%edx
  8022e5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8022e8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8022eb:	8d 4a 01             	lea    0x1(%edx),%ecx
  8022ee:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8022f1:	8a 12                	mov    (%edx),%dl
  8022f3:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8022f5:	8b 45 10             	mov    0x10(%ebp),%eax
  8022f8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8022fb:	89 55 10             	mov    %edx,0x10(%ebp)
  8022fe:	85 c0                	test   %eax,%eax
  802300:	75 dd                	jne    8022df <memcpy+0x14>
		*d++ = *s++;

	return dst;
  802302:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802305:	c9                   	leave  
  802306:	c3                   	ret    

00802307 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  802307:	55                   	push   %ebp
  802308:	89 e5                	mov    %esp,%ebp
  80230a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80230d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802310:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  802313:	8b 45 08             	mov    0x8(%ebp),%eax
  802316:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  802319:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80231c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80231f:	73 50                	jae    802371 <memmove+0x6a>
  802321:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802324:	8b 45 10             	mov    0x10(%ebp),%eax
  802327:	01 d0                	add    %edx,%eax
  802329:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80232c:	76 43                	jbe    802371 <memmove+0x6a>
		s += n;
  80232e:	8b 45 10             	mov    0x10(%ebp),%eax
  802331:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  802334:	8b 45 10             	mov    0x10(%ebp),%eax
  802337:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80233a:	eb 10                	jmp    80234c <memmove+0x45>
			*--d = *--s;
  80233c:	ff 4d f8             	decl   -0x8(%ebp)
  80233f:	ff 4d fc             	decl   -0x4(%ebp)
  802342:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802345:	8a 10                	mov    (%eax),%dl
  802347:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80234a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80234c:	8b 45 10             	mov    0x10(%ebp),%eax
  80234f:	8d 50 ff             	lea    -0x1(%eax),%edx
  802352:	89 55 10             	mov    %edx,0x10(%ebp)
  802355:	85 c0                	test   %eax,%eax
  802357:	75 e3                	jne    80233c <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  802359:	eb 23                	jmp    80237e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80235b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80235e:	8d 50 01             	lea    0x1(%eax),%edx
  802361:	89 55 f8             	mov    %edx,-0x8(%ebp)
  802364:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802367:	8d 4a 01             	lea    0x1(%edx),%ecx
  80236a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80236d:	8a 12                	mov    (%edx),%dl
  80236f:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  802371:	8b 45 10             	mov    0x10(%ebp),%eax
  802374:	8d 50 ff             	lea    -0x1(%eax),%edx
  802377:	89 55 10             	mov    %edx,0x10(%ebp)
  80237a:	85 c0                	test   %eax,%eax
  80237c:	75 dd                	jne    80235b <memmove+0x54>
			*d++ = *s++;

	return dst;
  80237e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802381:	c9                   	leave  
  802382:	c3                   	ret    

00802383 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  802383:	55                   	push   %ebp
  802384:	89 e5                	mov    %esp,%ebp
  802386:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  802389:	8b 45 08             	mov    0x8(%ebp),%eax
  80238c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80238f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802392:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  802395:	eb 2a                	jmp    8023c1 <memcmp+0x3e>
		if (*s1 != *s2)
  802397:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80239a:	8a 10                	mov    (%eax),%dl
  80239c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80239f:	8a 00                	mov    (%eax),%al
  8023a1:	38 c2                	cmp    %al,%dl
  8023a3:	74 16                	je     8023bb <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8023a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8023a8:	8a 00                	mov    (%eax),%al
  8023aa:	0f b6 d0             	movzbl %al,%edx
  8023ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8023b0:	8a 00                	mov    (%eax),%al
  8023b2:	0f b6 c0             	movzbl %al,%eax
  8023b5:	29 c2                	sub    %eax,%edx
  8023b7:	89 d0                	mov    %edx,%eax
  8023b9:	eb 18                	jmp    8023d3 <memcmp+0x50>
		s1++, s2++;
  8023bb:	ff 45 fc             	incl   -0x4(%ebp)
  8023be:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8023c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8023c4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8023c7:	89 55 10             	mov    %edx,0x10(%ebp)
  8023ca:	85 c0                	test   %eax,%eax
  8023cc:	75 c9                	jne    802397 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8023ce:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023d3:	c9                   	leave  
  8023d4:	c3                   	ret    

008023d5 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8023d5:	55                   	push   %ebp
  8023d6:	89 e5                	mov    %esp,%ebp
  8023d8:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8023db:	8b 55 08             	mov    0x8(%ebp),%edx
  8023de:	8b 45 10             	mov    0x10(%ebp),%eax
  8023e1:	01 d0                	add    %edx,%eax
  8023e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8023e6:	eb 15                	jmp    8023fd <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8023e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8023eb:	8a 00                	mov    (%eax),%al
  8023ed:	0f b6 d0             	movzbl %al,%edx
  8023f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023f3:	0f b6 c0             	movzbl %al,%eax
  8023f6:	39 c2                	cmp    %eax,%edx
  8023f8:	74 0d                	je     802407 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8023fa:	ff 45 08             	incl   0x8(%ebp)
  8023fd:	8b 45 08             	mov    0x8(%ebp),%eax
  802400:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  802403:	72 e3                	jb     8023e8 <memfind+0x13>
  802405:	eb 01                	jmp    802408 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  802407:	90                   	nop
	return (void *) s;
  802408:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80240b:	c9                   	leave  
  80240c:	c3                   	ret    

0080240d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80240d:	55                   	push   %ebp
  80240e:	89 e5                	mov    %esp,%ebp
  802410:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  802413:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80241a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  802421:	eb 03                	jmp    802426 <strtol+0x19>
		s++;
  802423:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  802426:	8b 45 08             	mov    0x8(%ebp),%eax
  802429:	8a 00                	mov    (%eax),%al
  80242b:	3c 20                	cmp    $0x20,%al
  80242d:	74 f4                	je     802423 <strtol+0x16>
  80242f:	8b 45 08             	mov    0x8(%ebp),%eax
  802432:	8a 00                	mov    (%eax),%al
  802434:	3c 09                	cmp    $0x9,%al
  802436:	74 eb                	je     802423 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  802438:	8b 45 08             	mov    0x8(%ebp),%eax
  80243b:	8a 00                	mov    (%eax),%al
  80243d:	3c 2b                	cmp    $0x2b,%al
  80243f:	75 05                	jne    802446 <strtol+0x39>
		s++;
  802441:	ff 45 08             	incl   0x8(%ebp)
  802444:	eb 13                	jmp    802459 <strtol+0x4c>
	else if (*s == '-')
  802446:	8b 45 08             	mov    0x8(%ebp),%eax
  802449:	8a 00                	mov    (%eax),%al
  80244b:	3c 2d                	cmp    $0x2d,%al
  80244d:	75 0a                	jne    802459 <strtol+0x4c>
		s++, neg = 1;
  80244f:	ff 45 08             	incl   0x8(%ebp)
  802452:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  802459:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80245d:	74 06                	je     802465 <strtol+0x58>
  80245f:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  802463:	75 20                	jne    802485 <strtol+0x78>
  802465:	8b 45 08             	mov    0x8(%ebp),%eax
  802468:	8a 00                	mov    (%eax),%al
  80246a:	3c 30                	cmp    $0x30,%al
  80246c:	75 17                	jne    802485 <strtol+0x78>
  80246e:	8b 45 08             	mov    0x8(%ebp),%eax
  802471:	40                   	inc    %eax
  802472:	8a 00                	mov    (%eax),%al
  802474:	3c 78                	cmp    $0x78,%al
  802476:	75 0d                	jne    802485 <strtol+0x78>
		s += 2, base = 16;
  802478:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80247c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  802483:	eb 28                	jmp    8024ad <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  802485:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802489:	75 15                	jne    8024a0 <strtol+0x93>
  80248b:	8b 45 08             	mov    0x8(%ebp),%eax
  80248e:	8a 00                	mov    (%eax),%al
  802490:	3c 30                	cmp    $0x30,%al
  802492:	75 0c                	jne    8024a0 <strtol+0x93>
		s++, base = 8;
  802494:	ff 45 08             	incl   0x8(%ebp)
  802497:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80249e:	eb 0d                	jmp    8024ad <strtol+0xa0>
	else if (base == 0)
  8024a0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8024a4:	75 07                	jne    8024ad <strtol+0xa0>
		base = 10;
  8024a6:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8024ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8024b0:	8a 00                	mov    (%eax),%al
  8024b2:	3c 2f                	cmp    $0x2f,%al
  8024b4:	7e 19                	jle    8024cf <strtol+0xc2>
  8024b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8024b9:	8a 00                	mov    (%eax),%al
  8024bb:	3c 39                	cmp    $0x39,%al
  8024bd:	7f 10                	jg     8024cf <strtol+0xc2>
			dig = *s - '0';
  8024bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8024c2:	8a 00                	mov    (%eax),%al
  8024c4:	0f be c0             	movsbl %al,%eax
  8024c7:	83 e8 30             	sub    $0x30,%eax
  8024ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8024cd:	eb 42                	jmp    802511 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8024cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8024d2:	8a 00                	mov    (%eax),%al
  8024d4:	3c 60                	cmp    $0x60,%al
  8024d6:	7e 19                	jle    8024f1 <strtol+0xe4>
  8024d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8024db:	8a 00                	mov    (%eax),%al
  8024dd:	3c 7a                	cmp    $0x7a,%al
  8024df:	7f 10                	jg     8024f1 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8024e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8024e4:	8a 00                	mov    (%eax),%al
  8024e6:	0f be c0             	movsbl %al,%eax
  8024e9:	83 e8 57             	sub    $0x57,%eax
  8024ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8024ef:	eb 20                	jmp    802511 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8024f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8024f4:	8a 00                	mov    (%eax),%al
  8024f6:	3c 40                	cmp    $0x40,%al
  8024f8:	7e 39                	jle    802533 <strtol+0x126>
  8024fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8024fd:	8a 00                	mov    (%eax),%al
  8024ff:	3c 5a                	cmp    $0x5a,%al
  802501:	7f 30                	jg     802533 <strtol+0x126>
			dig = *s - 'A' + 10;
  802503:	8b 45 08             	mov    0x8(%ebp),%eax
  802506:	8a 00                	mov    (%eax),%al
  802508:	0f be c0             	movsbl %al,%eax
  80250b:	83 e8 37             	sub    $0x37,%eax
  80250e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  802511:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802514:	3b 45 10             	cmp    0x10(%ebp),%eax
  802517:	7d 19                	jge    802532 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  802519:	ff 45 08             	incl   0x8(%ebp)
  80251c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80251f:	0f af 45 10          	imul   0x10(%ebp),%eax
  802523:	89 c2                	mov    %eax,%edx
  802525:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802528:	01 d0                	add    %edx,%eax
  80252a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80252d:	e9 7b ff ff ff       	jmp    8024ad <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  802532:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  802533:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802537:	74 08                	je     802541 <strtol+0x134>
		*endptr = (char *) s;
  802539:	8b 45 0c             	mov    0xc(%ebp),%eax
  80253c:	8b 55 08             	mov    0x8(%ebp),%edx
  80253f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  802541:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  802545:	74 07                	je     80254e <strtol+0x141>
  802547:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80254a:	f7 d8                	neg    %eax
  80254c:	eb 03                	jmp    802551 <strtol+0x144>
  80254e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  802551:	c9                   	leave  
  802552:	c3                   	ret    

00802553 <ltostr>:

void
ltostr(long value, char *str)
{
  802553:	55                   	push   %ebp
  802554:	89 e5                	mov    %esp,%ebp
  802556:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  802559:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  802560:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  802567:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80256b:	79 13                	jns    802580 <ltostr+0x2d>
	{
		neg = 1;
  80256d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  802574:	8b 45 0c             	mov    0xc(%ebp),%eax
  802577:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80257a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80257d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  802580:	8b 45 08             	mov    0x8(%ebp),%eax
  802583:	b9 0a 00 00 00       	mov    $0xa,%ecx
  802588:	99                   	cltd   
  802589:	f7 f9                	idiv   %ecx
  80258b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80258e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802591:	8d 50 01             	lea    0x1(%eax),%edx
  802594:	89 55 f8             	mov    %edx,-0x8(%ebp)
  802597:	89 c2                	mov    %eax,%edx
  802599:	8b 45 0c             	mov    0xc(%ebp),%eax
  80259c:	01 d0                	add    %edx,%eax
  80259e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8025a1:	83 c2 30             	add    $0x30,%edx
  8025a4:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8025a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8025a9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8025ae:	f7 e9                	imul   %ecx
  8025b0:	c1 fa 02             	sar    $0x2,%edx
  8025b3:	89 c8                	mov    %ecx,%eax
  8025b5:	c1 f8 1f             	sar    $0x1f,%eax
  8025b8:	29 c2                	sub    %eax,%edx
  8025ba:	89 d0                	mov    %edx,%eax
  8025bc:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8025bf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8025c2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8025c7:	f7 e9                	imul   %ecx
  8025c9:	c1 fa 02             	sar    $0x2,%edx
  8025cc:	89 c8                	mov    %ecx,%eax
  8025ce:	c1 f8 1f             	sar    $0x1f,%eax
  8025d1:	29 c2                	sub    %eax,%edx
  8025d3:	89 d0                	mov    %edx,%eax
  8025d5:	c1 e0 02             	shl    $0x2,%eax
  8025d8:	01 d0                	add    %edx,%eax
  8025da:	01 c0                	add    %eax,%eax
  8025dc:	29 c1                	sub    %eax,%ecx
  8025de:	89 ca                	mov    %ecx,%edx
  8025e0:	85 d2                	test   %edx,%edx
  8025e2:	75 9c                	jne    802580 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8025e4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8025eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8025ee:	48                   	dec    %eax
  8025ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8025f2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8025f6:	74 3d                	je     802635 <ltostr+0xe2>
		start = 1 ;
  8025f8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8025ff:	eb 34                	jmp    802635 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  802601:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802604:	8b 45 0c             	mov    0xc(%ebp),%eax
  802607:	01 d0                	add    %edx,%eax
  802609:	8a 00                	mov    (%eax),%al
  80260b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80260e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802611:	8b 45 0c             	mov    0xc(%ebp),%eax
  802614:	01 c2                	add    %eax,%edx
  802616:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  802619:	8b 45 0c             	mov    0xc(%ebp),%eax
  80261c:	01 c8                	add    %ecx,%eax
  80261e:	8a 00                	mov    (%eax),%al
  802620:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  802622:	8b 55 f0             	mov    -0x10(%ebp),%edx
  802625:	8b 45 0c             	mov    0xc(%ebp),%eax
  802628:	01 c2                	add    %eax,%edx
  80262a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80262d:	88 02                	mov    %al,(%edx)
		start++ ;
  80262f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  802632:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  802635:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802638:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80263b:	7c c4                	jl     802601 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80263d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  802640:	8b 45 0c             	mov    0xc(%ebp),%eax
  802643:	01 d0                	add    %edx,%eax
  802645:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  802648:	90                   	nop
  802649:	c9                   	leave  
  80264a:	c3                   	ret    

0080264b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80264b:	55                   	push   %ebp
  80264c:	89 e5                	mov    %esp,%ebp
  80264e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  802651:	ff 75 08             	pushl  0x8(%ebp)
  802654:	e8 54 fa ff ff       	call   8020ad <strlen>
  802659:	83 c4 04             	add    $0x4,%esp
  80265c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80265f:	ff 75 0c             	pushl  0xc(%ebp)
  802662:	e8 46 fa ff ff       	call   8020ad <strlen>
  802667:	83 c4 04             	add    $0x4,%esp
  80266a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80266d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  802674:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80267b:	eb 17                	jmp    802694 <strcconcat+0x49>
		final[s] = str1[s] ;
  80267d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802680:	8b 45 10             	mov    0x10(%ebp),%eax
  802683:	01 c2                	add    %eax,%edx
  802685:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  802688:	8b 45 08             	mov    0x8(%ebp),%eax
  80268b:	01 c8                	add    %ecx,%eax
  80268d:	8a 00                	mov    (%eax),%al
  80268f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  802691:	ff 45 fc             	incl   -0x4(%ebp)
  802694:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802697:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80269a:	7c e1                	jl     80267d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80269c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8026a3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8026aa:	eb 1f                	jmp    8026cb <strcconcat+0x80>
		final[s++] = str2[i] ;
  8026ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8026af:	8d 50 01             	lea    0x1(%eax),%edx
  8026b2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8026b5:	89 c2                	mov    %eax,%edx
  8026b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8026ba:	01 c2                	add    %eax,%edx
  8026bc:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8026bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8026c2:	01 c8                	add    %ecx,%eax
  8026c4:	8a 00                	mov    (%eax),%al
  8026c6:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8026c8:	ff 45 f8             	incl   -0x8(%ebp)
  8026cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8026ce:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8026d1:	7c d9                	jl     8026ac <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8026d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8026d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8026d9:	01 d0                	add    %edx,%eax
  8026db:	c6 00 00             	movb   $0x0,(%eax)
}
  8026de:	90                   	nop
  8026df:	c9                   	leave  
  8026e0:	c3                   	ret    

008026e1 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8026e1:	55                   	push   %ebp
  8026e2:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8026e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8026e7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8026ed:	8b 45 14             	mov    0x14(%ebp),%eax
  8026f0:	8b 00                	mov    (%eax),%eax
  8026f2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8026f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8026fc:	01 d0                	add    %edx,%eax
  8026fe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  802704:	eb 0c                	jmp    802712 <strsplit+0x31>
			*string++ = 0;
  802706:	8b 45 08             	mov    0x8(%ebp),%eax
  802709:	8d 50 01             	lea    0x1(%eax),%edx
  80270c:	89 55 08             	mov    %edx,0x8(%ebp)
  80270f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  802712:	8b 45 08             	mov    0x8(%ebp),%eax
  802715:	8a 00                	mov    (%eax),%al
  802717:	84 c0                	test   %al,%al
  802719:	74 18                	je     802733 <strsplit+0x52>
  80271b:	8b 45 08             	mov    0x8(%ebp),%eax
  80271e:	8a 00                	mov    (%eax),%al
  802720:	0f be c0             	movsbl %al,%eax
  802723:	50                   	push   %eax
  802724:	ff 75 0c             	pushl  0xc(%ebp)
  802727:	e8 13 fb ff ff       	call   80223f <strchr>
  80272c:	83 c4 08             	add    $0x8,%esp
  80272f:	85 c0                	test   %eax,%eax
  802731:	75 d3                	jne    802706 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  802733:	8b 45 08             	mov    0x8(%ebp),%eax
  802736:	8a 00                	mov    (%eax),%al
  802738:	84 c0                	test   %al,%al
  80273a:	74 5a                	je     802796 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80273c:	8b 45 14             	mov    0x14(%ebp),%eax
  80273f:	8b 00                	mov    (%eax),%eax
  802741:	83 f8 0f             	cmp    $0xf,%eax
  802744:	75 07                	jne    80274d <strsplit+0x6c>
		{
			return 0;
  802746:	b8 00 00 00 00       	mov    $0x0,%eax
  80274b:	eb 66                	jmp    8027b3 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80274d:	8b 45 14             	mov    0x14(%ebp),%eax
  802750:	8b 00                	mov    (%eax),%eax
  802752:	8d 48 01             	lea    0x1(%eax),%ecx
  802755:	8b 55 14             	mov    0x14(%ebp),%edx
  802758:	89 0a                	mov    %ecx,(%edx)
  80275a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802761:	8b 45 10             	mov    0x10(%ebp),%eax
  802764:	01 c2                	add    %eax,%edx
  802766:	8b 45 08             	mov    0x8(%ebp),%eax
  802769:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80276b:	eb 03                	jmp    802770 <strsplit+0x8f>
			string++;
  80276d:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  802770:	8b 45 08             	mov    0x8(%ebp),%eax
  802773:	8a 00                	mov    (%eax),%al
  802775:	84 c0                	test   %al,%al
  802777:	74 8b                	je     802704 <strsplit+0x23>
  802779:	8b 45 08             	mov    0x8(%ebp),%eax
  80277c:	8a 00                	mov    (%eax),%al
  80277e:	0f be c0             	movsbl %al,%eax
  802781:	50                   	push   %eax
  802782:	ff 75 0c             	pushl  0xc(%ebp)
  802785:	e8 b5 fa ff ff       	call   80223f <strchr>
  80278a:	83 c4 08             	add    $0x8,%esp
  80278d:	85 c0                	test   %eax,%eax
  80278f:	74 dc                	je     80276d <strsplit+0x8c>
			string++;
	}
  802791:	e9 6e ff ff ff       	jmp    802704 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  802796:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  802797:	8b 45 14             	mov    0x14(%ebp),%eax
  80279a:	8b 00                	mov    (%eax),%eax
  80279c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8027a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8027a6:	01 d0                	add    %edx,%eax
  8027a8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8027ae:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8027b3:	c9                   	leave  
  8027b4:	c3                   	ret    

008027b5 <malloc>:
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
  8027b5:	55                   	push   %ebp
  8027b6:	89 e5                	mov    %esp,%ebp
  8027b8:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  8027bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8027be:	c1 e8 0c             	shr    $0xc,%eax
  8027c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  8027c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8027c7:	25 ff 0f 00 00       	and    $0xfff,%eax
  8027cc:	85 c0                	test   %eax,%eax
  8027ce:	74 03                	je     8027d3 <malloc+0x1e>
			num++;
  8027d0:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  8027d3:	a1 04 40 80 00       	mov    0x804004,%eax
  8027d8:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8027dd:	75 73                	jne    802852 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  8027df:	83 ec 08             	sub    $0x8,%esp
  8027e2:	ff 75 08             	pushl  0x8(%ebp)
  8027e5:	68 00 00 00 80       	push   $0x80000000
  8027ea:	e8 13 05 00 00       	call   802d02 <sys_allocateMem>
  8027ef:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  8027f2:	a1 04 40 80 00       	mov    0x804004,%eax
  8027f7:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  8027fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8027fd:	c1 e0 0c             	shl    $0xc,%eax
  802800:	89 c2                	mov    %eax,%edx
  802802:	a1 04 40 80 00       	mov    0x804004,%eax
  802807:	01 d0                	add    %edx,%eax
  802809:	a3 04 40 80 00       	mov    %eax,0x804004
			numOfPages[sizeofarray]=num;
  80280e:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802813:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802816:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
			addresses[sizeofarray]=last_addres;
  80281d:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802822:	8b 15 04 40 80 00    	mov    0x804004,%edx
  802828:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
			changed[sizeofarray]=1;
  80282f:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802834:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  80283b:	01 00 00 00 
			sizeofarray++;
  80283f:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802844:	40                   	inc    %eax
  802845:	a3 2c 40 80 00       	mov    %eax,0x80402c
			return (void*)return_addres;
  80284a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80284d:	e9 71 01 00 00       	jmp    8029c3 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  802852:	a1 28 40 80 00       	mov    0x804028,%eax
  802857:	85 c0                	test   %eax,%eax
  802859:	75 71                	jne    8028cc <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  80285b:	a1 04 40 80 00       	mov    0x804004,%eax
  802860:	83 ec 08             	sub    $0x8,%esp
  802863:	ff 75 08             	pushl  0x8(%ebp)
  802866:	50                   	push   %eax
  802867:	e8 96 04 00 00       	call   802d02 <sys_allocateMem>
  80286c:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  80286f:	a1 04 40 80 00       	mov    0x804004,%eax
  802874:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  802877:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80287a:	c1 e0 0c             	shl    $0xc,%eax
  80287d:	89 c2                	mov    %eax,%edx
  80287f:	a1 04 40 80 00       	mov    0x804004,%eax
  802884:	01 d0                	add    %edx,%eax
  802886:	a3 04 40 80 00       	mov    %eax,0x804004
				numOfPages[sizeofarray]=num;
  80288b:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802890:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802893:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
				addresses[sizeofarray]=return_addres;
  80289a:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80289f:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8028a2:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				changed[sizeofarray]=1;
  8028a9:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8028ae:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  8028b5:	01 00 00 00 
				sizeofarray++;
  8028b9:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8028be:	40                   	inc    %eax
  8028bf:	a3 2c 40 80 00       	mov    %eax,0x80402c
				return (void*)return_addres;
  8028c4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8028c7:	e9 f7 00 00 00       	jmp    8029c3 <malloc+0x20e>
			}
			else{
				int count=0;
  8028cc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  8028d3:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  8028da:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8028e1:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  8028e8:	eb 7c                	jmp    802966 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  8028ea:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  8028f1:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8028f8:	eb 1a                	jmp    802914 <malloc+0x15f>
					{
						if(addresses[j]==i)
  8028fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8028fd:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802904:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  802907:	75 08                	jne    802911 <malloc+0x15c>
						{
							index=j;
  802909:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80290c:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  80290f:	eb 0d                	jmp    80291e <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  802911:	ff 45 dc             	incl   -0x24(%ebp)
  802914:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802919:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  80291c:	7c dc                	jl     8028fa <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  80291e:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  802922:	75 05                	jne    802929 <malloc+0x174>
					{
						count++;
  802924:	ff 45 f0             	incl   -0x10(%ebp)
  802927:	eb 36                	jmp    80295f <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  802929:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80292c:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  802933:	85 c0                	test   %eax,%eax
  802935:	75 05                	jne    80293c <malloc+0x187>
						{
							count++;
  802937:	ff 45 f0             	incl   -0x10(%ebp)
  80293a:	eb 23                	jmp    80295f <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  80293c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80293f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  802942:	7d 14                	jge    802958 <malloc+0x1a3>
  802944:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802947:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80294a:	7c 0c                	jl     802958 <malloc+0x1a3>
							{
								min=count;
  80294c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80294f:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  802952:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802955:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  802958:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  80295f:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  802966:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  80296d:	0f 86 77 ff ff ff    	jbe    8028ea <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  802973:	83 ec 08             	sub    $0x8,%esp
  802976:	ff 75 08             	pushl  0x8(%ebp)
  802979:	ff 75 e4             	pushl  -0x1c(%ebp)
  80297c:	e8 81 03 00 00       	call   802d02 <sys_allocateMem>
  802981:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  802984:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802989:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80298c:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
				addresses[sizeofarray]=last_addres;
  802993:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802998:	8b 15 04 40 80 00    	mov    0x804004,%edx
  80299e:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				changed[sizeofarray]=1;
  8029a5:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8029aa:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  8029b1:	01 00 00 00 
				sizeofarray++;
  8029b5:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8029ba:	40                   	inc    %eax
  8029bb:	a3 2c 40 80 00       	mov    %eax,0x80402c
				return(void*) min_addresss;
  8029c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  8029c3:	c9                   	leave  
  8029c4:	c3                   	ret    

008029c5 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8029c5:	55                   	push   %ebp
  8029c6:	89 e5                	mov    %esp,%ebp
  8029c8:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  8029cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8029ce:	89 45 e8             	mov    %eax,-0x18(%ebp)
    uint32 size;
    int is_found=0;
  8029d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  8029d8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8029df:	eb 30                	jmp    802a11 <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  8029e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8029e4:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  8029eb:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8029ee:	75 1e                	jne    802a0e <free+0x49>
  8029f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8029f3:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  8029fa:	83 f8 01             	cmp    $0x1,%eax
  8029fd:	75 0f                	jne    802a0e <free+0x49>
    		is_found=1;
  8029ff:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  802a06:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802a09:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  802a0c:	eb 0d                	jmp    802a1b <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    uint32 size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  802a0e:	ff 45 ec             	incl   -0x14(%ebp)
  802a11:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802a16:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  802a19:	7c c6                	jl     8029e1 <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  802a1b:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  802a1f:	75 3a                	jne    802a5b <free+0x96>
    	size=numOfPages[index]*PAGE_SIZE;
  802a21:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802a24:	8b 04 85 20 76 8c 00 	mov    0x8c7620(,%eax,4),%eax
  802a2b:	c1 e0 0c             	shl    $0xc,%eax
  802a2e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  802a31:	83 ec 08             	sub    $0x8,%esp
  802a34:	ff 75 e4             	pushl  -0x1c(%ebp)
  802a37:	ff 75 e8             	pushl  -0x18(%ebp)
  802a3a:	e8 a7 02 00 00       	call   802ce6 <sys_freeMem>
  802a3f:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  802a42:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802a45:	c7 04 85 a0 5b 86 00 	movl   $0x0,0x865ba0(,%eax,4)
  802a4c:	00 00 00 00 
    	changes++;
  802a50:	a1 28 40 80 00       	mov    0x804028,%eax
  802a55:	40                   	inc    %eax
  802a56:	a3 28 40 80 00       	mov    %eax,0x804028
    }


	//refer to the project presentation and documentation for details
}
  802a5b:	90                   	nop
  802a5c:	c9                   	leave  
  802a5d:	c3                   	ret    

00802a5e <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  802a5e:	55                   	push   %ebp
  802a5f:	89 e5                	mov    %esp,%ebp
  802a61:	83 ec 18             	sub    $0x18,%esp
  802a64:	8b 45 10             	mov    0x10(%ebp),%eax
  802a67:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  802a6a:	83 ec 04             	sub    $0x4,%esp
  802a6d:	68 f0 3b 80 00       	push   $0x803bf0
  802a72:	68 9f 00 00 00       	push   $0x9f
  802a77:	68 13 3c 80 00       	push   $0x803c13
  802a7c:	e8 08 ed ff ff       	call   801789 <_panic>

00802a81 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  802a81:	55                   	push   %ebp
  802a82:	89 e5                	mov    %esp,%ebp
  802a84:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802a87:	83 ec 04             	sub    $0x4,%esp
  802a8a:	68 f0 3b 80 00       	push   $0x803bf0
  802a8f:	68 a5 00 00 00       	push   $0xa5
  802a94:	68 13 3c 80 00       	push   $0x803c13
  802a99:	e8 eb ec ff ff       	call   801789 <_panic>

00802a9e <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  802a9e:	55                   	push   %ebp
  802a9f:	89 e5                	mov    %esp,%ebp
  802aa1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802aa4:	83 ec 04             	sub    $0x4,%esp
  802aa7:	68 f0 3b 80 00       	push   $0x803bf0
  802aac:	68 ab 00 00 00       	push   $0xab
  802ab1:	68 13 3c 80 00       	push   $0x803c13
  802ab6:	e8 ce ec ff ff       	call   801789 <_panic>

00802abb <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  802abb:	55                   	push   %ebp
  802abc:	89 e5                	mov    %esp,%ebp
  802abe:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802ac1:	83 ec 04             	sub    $0x4,%esp
  802ac4:	68 f0 3b 80 00       	push   $0x803bf0
  802ac9:	68 b0 00 00 00       	push   $0xb0
  802ace:	68 13 3c 80 00       	push   $0x803c13
  802ad3:	e8 b1 ec ff ff       	call   801789 <_panic>

00802ad8 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  802ad8:	55                   	push   %ebp
  802ad9:	89 e5                	mov    %esp,%ebp
  802adb:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802ade:	83 ec 04             	sub    $0x4,%esp
  802ae1:	68 f0 3b 80 00       	push   $0x803bf0
  802ae6:	68 b6 00 00 00       	push   $0xb6
  802aeb:	68 13 3c 80 00       	push   $0x803c13
  802af0:	e8 94 ec ff ff       	call   801789 <_panic>

00802af5 <shrink>:
}
void shrink(uint32 newSize)
{
  802af5:	55                   	push   %ebp
  802af6:	89 e5                	mov    %esp,%ebp
  802af8:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802afb:	83 ec 04             	sub    $0x4,%esp
  802afe:	68 f0 3b 80 00       	push   $0x803bf0
  802b03:	68 ba 00 00 00       	push   $0xba
  802b08:	68 13 3c 80 00       	push   $0x803c13
  802b0d:	e8 77 ec ff ff       	call   801789 <_panic>

00802b12 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  802b12:	55                   	push   %ebp
  802b13:	89 e5                	mov    %esp,%ebp
  802b15:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802b18:	83 ec 04             	sub    $0x4,%esp
  802b1b:	68 f0 3b 80 00       	push   $0x803bf0
  802b20:	68 bf 00 00 00       	push   $0xbf
  802b25:	68 13 3c 80 00       	push   $0x803c13
  802b2a:	e8 5a ec ff ff       	call   801789 <_panic>

00802b2f <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  802b2f:	55                   	push   %ebp
  802b30:	89 e5                	mov    %esp,%ebp
  802b32:	57                   	push   %edi
  802b33:	56                   	push   %esi
  802b34:	53                   	push   %ebx
  802b35:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802b38:	8b 45 08             	mov    0x8(%ebp),%eax
  802b3b:	8b 55 0c             	mov    0xc(%ebp),%edx
  802b3e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802b41:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802b44:	8b 7d 18             	mov    0x18(%ebp),%edi
  802b47:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802b4a:	cd 30                	int    $0x30
  802b4c:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802b4f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802b52:	83 c4 10             	add    $0x10,%esp
  802b55:	5b                   	pop    %ebx
  802b56:	5e                   	pop    %esi
  802b57:	5f                   	pop    %edi
  802b58:	5d                   	pop    %ebp
  802b59:	c3                   	ret    

00802b5a <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802b5a:	55                   	push   %ebp
  802b5b:	89 e5                	mov    %esp,%ebp
  802b5d:	83 ec 04             	sub    $0x4,%esp
  802b60:	8b 45 10             	mov    0x10(%ebp),%eax
  802b63:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802b66:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  802b6d:	6a 00                	push   $0x0
  802b6f:	6a 00                	push   $0x0
  802b71:	52                   	push   %edx
  802b72:	ff 75 0c             	pushl  0xc(%ebp)
  802b75:	50                   	push   %eax
  802b76:	6a 00                	push   $0x0
  802b78:	e8 b2 ff ff ff       	call   802b2f <syscall>
  802b7d:	83 c4 18             	add    $0x18,%esp
}
  802b80:	90                   	nop
  802b81:	c9                   	leave  
  802b82:	c3                   	ret    

00802b83 <sys_cgetc>:

int
sys_cgetc(void)
{
  802b83:	55                   	push   %ebp
  802b84:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802b86:	6a 00                	push   $0x0
  802b88:	6a 00                	push   $0x0
  802b8a:	6a 00                	push   $0x0
  802b8c:	6a 00                	push   $0x0
  802b8e:	6a 00                	push   $0x0
  802b90:	6a 01                	push   $0x1
  802b92:	e8 98 ff ff ff       	call   802b2f <syscall>
  802b97:	83 c4 18             	add    $0x18,%esp
}
  802b9a:	c9                   	leave  
  802b9b:	c3                   	ret    

00802b9c <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802b9c:	55                   	push   %ebp
  802b9d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802b9f:	8b 45 08             	mov    0x8(%ebp),%eax
  802ba2:	6a 00                	push   $0x0
  802ba4:	6a 00                	push   $0x0
  802ba6:	6a 00                	push   $0x0
  802ba8:	6a 00                	push   $0x0
  802baa:	50                   	push   %eax
  802bab:	6a 05                	push   $0x5
  802bad:	e8 7d ff ff ff       	call   802b2f <syscall>
  802bb2:	83 c4 18             	add    $0x18,%esp
}
  802bb5:	c9                   	leave  
  802bb6:	c3                   	ret    

00802bb7 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802bb7:	55                   	push   %ebp
  802bb8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802bba:	6a 00                	push   $0x0
  802bbc:	6a 00                	push   $0x0
  802bbe:	6a 00                	push   $0x0
  802bc0:	6a 00                	push   $0x0
  802bc2:	6a 00                	push   $0x0
  802bc4:	6a 02                	push   $0x2
  802bc6:	e8 64 ff ff ff       	call   802b2f <syscall>
  802bcb:	83 c4 18             	add    $0x18,%esp
}
  802bce:	c9                   	leave  
  802bcf:	c3                   	ret    

00802bd0 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802bd0:	55                   	push   %ebp
  802bd1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802bd3:	6a 00                	push   $0x0
  802bd5:	6a 00                	push   $0x0
  802bd7:	6a 00                	push   $0x0
  802bd9:	6a 00                	push   $0x0
  802bdb:	6a 00                	push   $0x0
  802bdd:	6a 03                	push   $0x3
  802bdf:	e8 4b ff ff ff       	call   802b2f <syscall>
  802be4:	83 c4 18             	add    $0x18,%esp
}
  802be7:	c9                   	leave  
  802be8:	c3                   	ret    

00802be9 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802be9:	55                   	push   %ebp
  802bea:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802bec:	6a 00                	push   $0x0
  802bee:	6a 00                	push   $0x0
  802bf0:	6a 00                	push   $0x0
  802bf2:	6a 00                	push   $0x0
  802bf4:	6a 00                	push   $0x0
  802bf6:	6a 04                	push   $0x4
  802bf8:	e8 32 ff ff ff       	call   802b2f <syscall>
  802bfd:	83 c4 18             	add    $0x18,%esp
}
  802c00:	c9                   	leave  
  802c01:	c3                   	ret    

00802c02 <sys_env_exit>:


void sys_env_exit(void)
{
  802c02:	55                   	push   %ebp
  802c03:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802c05:	6a 00                	push   $0x0
  802c07:	6a 00                	push   $0x0
  802c09:	6a 00                	push   $0x0
  802c0b:	6a 00                	push   $0x0
  802c0d:	6a 00                	push   $0x0
  802c0f:	6a 06                	push   $0x6
  802c11:	e8 19 ff ff ff       	call   802b2f <syscall>
  802c16:	83 c4 18             	add    $0x18,%esp
}
  802c19:	90                   	nop
  802c1a:	c9                   	leave  
  802c1b:	c3                   	ret    

00802c1c <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802c1c:	55                   	push   %ebp
  802c1d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802c1f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802c22:	8b 45 08             	mov    0x8(%ebp),%eax
  802c25:	6a 00                	push   $0x0
  802c27:	6a 00                	push   $0x0
  802c29:	6a 00                	push   $0x0
  802c2b:	52                   	push   %edx
  802c2c:	50                   	push   %eax
  802c2d:	6a 07                	push   $0x7
  802c2f:	e8 fb fe ff ff       	call   802b2f <syscall>
  802c34:	83 c4 18             	add    $0x18,%esp
}
  802c37:	c9                   	leave  
  802c38:	c3                   	ret    

00802c39 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802c39:	55                   	push   %ebp
  802c3a:	89 e5                	mov    %esp,%ebp
  802c3c:	56                   	push   %esi
  802c3d:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802c3e:	8b 75 18             	mov    0x18(%ebp),%esi
  802c41:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802c44:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802c47:	8b 55 0c             	mov    0xc(%ebp),%edx
  802c4a:	8b 45 08             	mov    0x8(%ebp),%eax
  802c4d:	56                   	push   %esi
  802c4e:	53                   	push   %ebx
  802c4f:	51                   	push   %ecx
  802c50:	52                   	push   %edx
  802c51:	50                   	push   %eax
  802c52:	6a 08                	push   $0x8
  802c54:	e8 d6 fe ff ff       	call   802b2f <syscall>
  802c59:	83 c4 18             	add    $0x18,%esp
}
  802c5c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802c5f:	5b                   	pop    %ebx
  802c60:	5e                   	pop    %esi
  802c61:	5d                   	pop    %ebp
  802c62:	c3                   	ret    

00802c63 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802c63:	55                   	push   %ebp
  802c64:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802c66:	8b 55 0c             	mov    0xc(%ebp),%edx
  802c69:	8b 45 08             	mov    0x8(%ebp),%eax
  802c6c:	6a 00                	push   $0x0
  802c6e:	6a 00                	push   $0x0
  802c70:	6a 00                	push   $0x0
  802c72:	52                   	push   %edx
  802c73:	50                   	push   %eax
  802c74:	6a 09                	push   $0x9
  802c76:	e8 b4 fe ff ff       	call   802b2f <syscall>
  802c7b:	83 c4 18             	add    $0x18,%esp
}
  802c7e:	c9                   	leave  
  802c7f:	c3                   	ret    

00802c80 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802c80:	55                   	push   %ebp
  802c81:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802c83:	6a 00                	push   $0x0
  802c85:	6a 00                	push   $0x0
  802c87:	6a 00                	push   $0x0
  802c89:	ff 75 0c             	pushl  0xc(%ebp)
  802c8c:	ff 75 08             	pushl  0x8(%ebp)
  802c8f:	6a 0a                	push   $0xa
  802c91:	e8 99 fe ff ff       	call   802b2f <syscall>
  802c96:	83 c4 18             	add    $0x18,%esp
}
  802c99:	c9                   	leave  
  802c9a:	c3                   	ret    

00802c9b <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802c9b:	55                   	push   %ebp
  802c9c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802c9e:	6a 00                	push   $0x0
  802ca0:	6a 00                	push   $0x0
  802ca2:	6a 00                	push   $0x0
  802ca4:	6a 00                	push   $0x0
  802ca6:	6a 00                	push   $0x0
  802ca8:	6a 0b                	push   $0xb
  802caa:	e8 80 fe ff ff       	call   802b2f <syscall>
  802caf:	83 c4 18             	add    $0x18,%esp
}
  802cb2:	c9                   	leave  
  802cb3:	c3                   	ret    

00802cb4 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802cb4:	55                   	push   %ebp
  802cb5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802cb7:	6a 00                	push   $0x0
  802cb9:	6a 00                	push   $0x0
  802cbb:	6a 00                	push   $0x0
  802cbd:	6a 00                	push   $0x0
  802cbf:	6a 00                	push   $0x0
  802cc1:	6a 0c                	push   $0xc
  802cc3:	e8 67 fe ff ff       	call   802b2f <syscall>
  802cc8:	83 c4 18             	add    $0x18,%esp
}
  802ccb:	c9                   	leave  
  802ccc:	c3                   	ret    

00802ccd <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802ccd:	55                   	push   %ebp
  802cce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802cd0:	6a 00                	push   $0x0
  802cd2:	6a 00                	push   $0x0
  802cd4:	6a 00                	push   $0x0
  802cd6:	6a 00                	push   $0x0
  802cd8:	6a 00                	push   $0x0
  802cda:	6a 0d                	push   $0xd
  802cdc:	e8 4e fe ff ff       	call   802b2f <syscall>
  802ce1:	83 c4 18             	add    $0x18,%esp
}
  802ce4:	c9                   	leave  
  802ce5:	c3                   	ret    

00802ce6 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802ce6:	55                   	push   %ebp
  802ce7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802ce9:	6a 00                	push   $0x0
  802ceb:	6a 00                	push   $0x0
  802ced:	6a 00                	push   $0x0
  802cef:	ff 75 0c             	pushl  0xc(%ebp)
  802cf2:	ff 75 08             	pushl  0x8(%ebp)
  802cf5:	6a 11                	push   $0x11
  802cf7:	e8 33 fe ff ff       	call   802b2f <syscall>
  802cfc:	83 c4 18             	add    $0x18,%esp
	return;
  802cff:	90                   	nop
}
  802d00:	c9                   	leave  
  802d01:	c3                   	ret    

00802d02 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802d02:	55                   	push   %ebp
  802d03:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802d05:	6a 00                	push   $0x0
  802d07:	6a 00                	push   $0x0
  802d09:	6a 00                	push   $0x0
  802d0b:	ff 75 0c             	pushl  0xc(%ebp)
  802d0e:	ff 75 08             	pushl  0x8(%ebp)
  802d11:	6a 12                	push   $0x12
  802d13:	e8 17 fe ff ff       	call   802b2f <syscall>
  802d18:	83 c4 18             	add    $0x18,%esp
	return ;
  802d1b:	90                   	nop
}
  802d1c:	c9                   	leave  
  802d1d:	c3                   	ret    

00802d1e <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802d1e:	55                   	push   %ebp
  802d1f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802d21:	6a 00                	push   $0x0
  802d23:	6a 00                	push   $0x0
  802d25:	6a 00                	push   $0x0
  802d27:	6a 00                	push   $0x0
  802d29:	6a 00                	push   $0x0
  802d2b:	6a 0e                	push   $0xe
  802d2d:	e8 fd fd ff ff       	call   802b2f <syscall>
  802d32:	83 c4 18             	add    $0x18,%esp
}
  802d35:	c9                   	leave  
  802d36:	c3                   	ret    

00802d37 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802d37:	55                   	push   %ebp
  802d38:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802d3a:	6a 00                	push   $0x0
  802d3c:	6a 00                	push   $0x0
  802d3e:	6a 00                	push   $0x0
  802d40:	6a 00                	push   $0x0
  802d42:	ff 75 08             	pushl  0x8(%ebp)
  802d45:	6a 0f                	push   $0xf
  802d47:	e8 e3 fd ff ff       	call   802b2f <syscall>
  802d4c:	83 c4 18             	add    $0x18,%esp
}
  802d4f:	c9                   	leave  
  802d50:	c3                   	ret    

00802d51 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802d51:	55                   	push   %ebp
  802d52:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802d54:	6a 00                	push   $0x0
  802d56:	6a 00                	push   $0x0
  802d58:	6a 00                	push   $0x0
  802d5a:	6a 00                	push   $0x0
  802d5c:	6a 00                	push   $0x0
  802d5e:	6a 10                	push   $0x10
  802d60:	e8 ca fd ff ff       	call   802b2f <syscall>
  802d65:	83 c4 18             	add    $0x18,%esp
}
  802d68:	90                   	nop
  802d69:	c9                   	leave  
  802d6a:	c3                   	ret    

00802d6b <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802d6b:	55                   	push   %ebp
  802d6c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802d6e:	6a 00                	push   $0x0
  802d70:	6a 00                	push   $0x0
  802d72:	6a 00                	push   $0x0
  802d74:	6a 00                	push   $0x0
  802d76:	6a 00                	push   $0x0
  802d78:	6a 14                	push   $0x14
  802d7a:	e8 b0 fd ff ff       	call   802b2f <syscall>
  802d7f:	83 c4 18             	add    $0x18,%esp
}
  802d82:	90                   	nop
  802d83:	c9                   	leave  
  802d84:	c3                   	ret    

00802d85 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802d85:	55                   	push   %ebp
  802d86:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802d88:	6a 00                	push   $0x0
  802d8a:	6a 00                	push   $0x0
  802d8c:	6a 00                	push   $0x0
  802d8e:	6a 00                	push   $0x0
  802d90:	6a 00                	push   $0x0
  802d92:	6a 15                	push   $0x15
  802d94:	e8 96 fd ff ff       	call   802b2f <syscall>
  802d99:	83 c4 18             	add    $0x18,%esp
}
  802d9c:	90                   	nop
  802d9d:	c9                   	leave  
  802d9e:	c3                   	ret    

00802d9f <sys_cputc>:


void
sys_cputc(const char c)
{
  802d9f:	55                   	push   %ebp
  802da0:	89 e5                	mov    %esp,%ebp
  802da2:	83 ec 04             	sub    $0x4,%esp
  802da5:	8b 45 08             	mov    0x8(%ebp),%eax
  802da8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802dab:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802daf:	6a 00                	push   $0x0
  802db1:	6a 00                	push   $0x0
  802db3:	6a 00                	push   $0x0
  802db5:	6a 00                	push   $0x0
  802db7:	50                   	push   %eax
  802db8:	6a 16                	push   $0x16
  802dba:	e8 70 fd ff ff       	call   802b2f <syscall>
  802dbf:	83 c4 18             	add    $0x18,%esp
}
  802dc2:	90                   	nop
  802dc3:	c9                   	leave  
  802dc4:	c3                   	ret    

00802dc5 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802dc5:	55                   	push   %ebp
  802dc6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802dc8:	6a 00                	push   $0x0
  802dca:	6a 00                	push   $0x0
  802dcc:	6a 00                	push   $0x0
  802dce:	6a 00                	push   $0x0
  802dd0:	6a 00                	push   $0x0
  802dd2:	6a 17                	push   $0x17
  802dd4:	e8 56 fd ff ff       	call   802b2f <syscall>
  802dd9:	83 c4 18             	add    $0x18,%esp
}
  802ddc:	90                   	nop
  802ddd:	c9                   	leave  
  802dde:	c3                   	ret    

00802ddf <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802ddf:	55                   	push   %ebp
  802de0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802de2:	8b 45 08             	mov    0x8(%ebp),%eax
  802de5:	6a 00                	push   $0x0
  802de7:	6a 00                	push   $0x0
  802de9:	6a 00                	push   $0x0
  802deb:	ff 75 0c             	pushl  0xc(%ebp)
  802dee:	50                   	push   %eax
  802def:	6a 18                	push   $0x18
  802df1:	e8 39 fd ff ff       	call   802b2f <syscall>
  802df6:	83 c4 18             	add    $0x18,%esp
}
  802df9:	c9                   	leave  
  802dfa:	c3                   	ret    

00802dfb <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802dfb:	55                   	push   %ebp
  802dfc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802dfe:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e01:	8b 45 08             	mov    0x8(%ebp),%eax
  802e04:	6a 00                	push   $0x0
  802e06:	6a 00                	push   $0x0
  802e08:	6a 00                	push   $0x0
  802e0a:	52                   	push   %edx
  802e0b:	50                   	push   %eax
  802e0c:	6a 1b                	push   $0x1b
  802e0e:	e8 1c fd ff ff       	call   802b2f <syscall>
  802e13:	83 c4 18             	add    $0x18,%esp
}
  802e16:	c9                   	leave  
  802e17:	c3                   	ret    

00802e18 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802e18:	55                   	push   %ebp
  802e19:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802e1b:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e1e:	8b 45 08             	mov    0x8(%ebp),%eax
  802e21:	6a 00                	push   $0x0
  802e23:	6a 00                	push   $0x0
  802e25:	6a 00                	push   $0x0
  802e27:	52                   	push   %edx
  802e28:	50                   	push   %eax
  802e29:	6a 19                	push   $0x19
  802e2b:	e8 ff fc ff ff       	call   802b2f <syscall>
  802e30:	83 c4 18             	add    $0x18,%esp
}
  802e33:	90                   	nop
  802e34:	c9                   	leave  
  802e35:	c3                   	ret    

00802e36 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802e36:	55                   	push   %ebp
  802e37:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802e39:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  802e3f:	6a 00                	push   $0x0
  802e41:	6a 00                	push   $0x0
  802e43:	6a 00                	push   $0x0
  802e45:	52                   	push   %edx
  802e46:	50                   	push   %eax
  802e47:	6a 1a                	push   $0x1a
  802e49:	e8 e1 fc ff ff       	call   802b2f <syscall>
  802e4e:	83 c4 18             	add    $0x18,%esp
}
  802e51:	90                   	nop
  802e52:	c9                   	leave  
  802e53:	c3                   	ret    

00802e54 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802e54:	55                   	push   %ebp
  802e55:	89 e5                	mov    %esp,%ebp
  802e57:	83 ec 04             	sub    $0x4,%esp
  802e5a:	8b 45 10             	mov    0x10(%ebp),%eax
  802e5d:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802e60:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802e63:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802e67:	8b 45 08             	mov    0x8(%ebp),%eax
  802e6a:	6a 00                	push   $0x0
  802e6c:	51                   	push   %ecx
  802e6d:	52                   	push   %edx
  802e6e:	ff 75 0c             	pushl  0xc(%ebp)
  802e71:	50                   	push   %eax
  802e72:	6a 1c                	push   $0x1c
  802e74:	e8 b6 fc ff ff       	call   802b2f <syscall>
  802e79:	83 c4 18             	add    $0x18,%esp
}
  802e7c:	c9                   	leave  
  802e7d:	c3                   	ret    

00802e7e <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802e7e:	55                   	push   %ebp
  802e7f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802e81:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e84:	8b 45 08             	mov    0x8(%ebp),%eax
  802e87:	6a 00                	push   $0x0
  802e89:	6a 00                	push   $0x0
  802e8b:	6a 00                	push   $0x0
  802e8d:	52                   	push   %edx
  802e8e:	50                   	push   %eax
  802e8f:	6a 1d                	push   $0x1d
  802e91:	e8 99 fc ff ff       	call   802b2f <syscall>
  802e96:	83 c4 18             	add    $0x18,%esp
}
  802e99:	c9                   	leave  
  802e9a:	c3                   	ret    

00802e9b <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802e9b:	55                   	push   %ebp
  802e9c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802e9e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802ea1:	8b 55 0c             	mov    0xc(%ebp),%edx
  802ea4:	8b 45 08             	mov    0x8(%ebp),%eax
  802ea7:	6a 00                	push   $0x0
  802ea9:	6a 00                	push   $0x0
  802eab:	51                   	push   %ecx
  802eac:	52                   	push   %edx
  802ead:	50                   	push   %eax
  802eae:	6a 1e                	push   $0x1e
  802eb0:	e8 7a fc ff ff       	call   802b2f <syscall>
  802eb5:	83 c4 18             	add    $0x18,%esp
}
  802eb8:	c9                   	leave  
  802eb9:	c3                   	ret    

00802eba <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802eba:	55                   	push   %ebp
  802ebb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802ebd:	8b 55 0c             	mov    0xc(%ebp),%edx
  802ec0:	8b 45 08             	mov    0x8(%ebp),%eax
  802ec3:	6a 00                	push   $0x0
  802ec5:	6a 00                	push   $0x0
  802ec7:	6a 00                	push   $0x0
  802ec9:	52                   	push   %edx
  802eca:	50                   	push   %eax
  802ecb:	6a 1f                	push   $0x1f
  802ecd:	e8 5d fc ff ff       	call   802b2f <syscall>
  802ed2:	83 c4 18             	add    $0x18,%esp
}
  802ed5:	c9                   	leave  
  802ed6:	c3                   	ret    

00802ed7 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802ed7:	55                   	push   %ebp
  802ed8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802eda:	6a 00                	push   $0x0
  802edc:	6a 00                	push   $0x0
  802ede:	6a 00                	push   $0x0
  802ee0:	6a 00                	push   $0x0
  802ee2:	6a 00                	push   $0x0
  802ee4:	6a 20                	push   $0x20
  802ee6:	e8 44 fc ff ff       	call   802b2f <syscall>
  802eeb:	83 c4 18             	add    $0x18,%esp
}
  802eee:	c9                   	leave  
  802eef:	c3                   	ret    

00802ef0 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802ef0:	55                   	push   %ebp
  802ef1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802ef3:	8b 45 08             	mov    0x8(%ebp),%eax
  802ef6:	6a 00                	push   $0x0
  802ef8:	ff 75 14             	pushl  0x14(%ebp)
  802efb:	ff 75 10             	pushl  0x10(%ebp)
  802efe:	ff 75 0c             	pushl  0xc(%ebp)
  802f01:	50                   	push   %eax
  802f02:	6a 21                	push   $0x21
  802f04:	e8 26 fc ff ff       	call   802b2f <syscall>
  802f09:	83 c4 18             	add    $0x18,%esp
}
  802f0c:	c9                   	leave  
  802f0d:	c3                   	ret    

00802f0e <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802f0e:	55                   	push   %ebp
  802f0f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802f11:	8b 45 08             	mov    0x8(%ebp),%eax
  802f14:	6a 00                	push   $0x0
  802f16:	6a 00                	push   $0x0
  802f18:	6a 00                	push   $0x0
  802f1a:	6a 00                	push   $0x0
  802f1c:	50                   	push   %eax
  802f1d:	6a 22                	push   $0x22
  802f1f:	e8 0b fc ff ff       	call   802b2f <syscall>
  802f24:	83 c4 18             	add    $0x18,%esp
}
  802f27:	90                   	nop
  802f28:	c9                   	leave  
  802f29:	c3                   	ret    

00802f2a <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802f2a:	55                   	push   %ebp
  802f2b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802f2d:	8b 45 08             	mov    0x8(%ebp),%eax
  802f30:	6a 00                	push   $0x0
  802f32:	6a 00                	push   $0x0
  802f34:	6a 00                	push   $0x0
  802f36:	6a 00                	push   $0x0
  802f38:	50                   	push   %eax
  802f39:	6a 23                	push   $0x23
  802f3b:	e8 ef fb ff ff       	call   802b2f <syscall>
  802f40:	83 c4 18             	add    $0x18,%esp
}
  802f43:	90                   	nop
  802f44:	c9                   	leave  
  802f45:	c3                   	ret    

00802f46 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802f46:	55                   	push   %ebp
  802f47:	89 e5                	mov    %esp,%ebp
  802f49:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802f4c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802f4f:	8d 50 04             	lea    0x4(%eax),%edx
  802f52:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802f55:	6a 00                	push   $0x0
  802f57:	6a 00                	push   $0x0
  802f59:	6a 00                	push   $0x0
  802f5b:	52                   	push   %edx
  802f5c:	50                   	push   %eax
  802f5d:	6a 24                	push   $0x24
  802f5f:	e8 cb fb ff ff       	call   802b2f <syscall>
  802f64:	83 c4 18             	add    $0x18,%esp
	return result;
  802f67:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802f6a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802f6d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802f70:	89 01                	mov    %eax,(%ecx)
  802f72:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802f75:	8b 45 08             	mov    0x8(%ebp),%eax
  802f78:	c9                   	leave  
  802f79:	c2 04 00             	ret    $0x4

00802f7c <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802f7c:	55                   	push   %ebp
  802f7d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802f7f:	6a 00                	push   $0x0
  802f81:	6a 00                	push   $0x0
  802f83:	ff 75 10             	pushl  0x10(%ebp)
  802f86:	ff 75 0c             	pushl  0xc(%ebp)
  802f89:	ff 75 08             	pushl  0x8(%ebp)
  802f8c:	6a 13                	push   $0x13
  802f8e:	e8 9c fb ff ff       	call   802b2f <syscall>
  802f93:	83 c4 18             	add    $0x18,%esp
	return ;
  802f96:	90                   	nop
}
  802f97:	c9                   	leave  
  802f98:	c3                   	ret    

00802f99 <sys_rcr2>:
uint32 sys_rcr2()
{
  802f99:	55                   	push   %ebp
  802f9a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802f9c:	6a 00                	push   $0x0
  802f9e:	6a 00                	push   $0x0
  802fa0:	6a 00                	push   $0x0
  802fa2:	6a 00                	push   $0x0
  802fa4:	6a 00                	push   $0x0
  802fa6:	6a 25                	push   $0x25
  802fa8:	e8 82 fb ff ff       	call   802b2f <syscall>
  802fad:	83 c4 18             	add    $0x18,%esp
}
  802fb0:	c9                   	leave  
  802fb1:	c3                   	ret    

00802fb2 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802fb2:	55                   	push   %ebp
  802fb3:	89 e5                	mov    %esp,%ebp
  802fb5:	83 ec 04             	sub    $0x4,%esp
  802fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  802fbb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802fbe:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802fc2:	6a 00                	push   $0x0
  802fc4:	6a 00                	push   $0x0
  802fc6:	6a 00                	push   $0x0
  802fc8:	6a 00                	push   $0x0
  802fca:	50                   	push   %eax
  802fcb:	6a 26                	push   $0x26
  802fcd:	e8 5d fb ff ff       	call   802b2f <syscall>
  802fd2:	83 c4 18             	add    $0x18,%esp
	return ;
  802fd5:	90                   	nop
}
  802fd6:	c9                   	leave  
  802fd7:	c3                   	ret    

00802fd8 <rsttst>:
void rsttst()
{
  802fd8:	55                   	push   %ebp
  802fd9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802fdb:	6a 00                	push   $0x0
  802fdd:	6a 00                	push   $0x0
  802fdf:	6a 00                	push   $0x0
  802fe1:	6a 00                	push   $0x0
  802fe3:	6a 00                	push   $0x0
  802fe5:	6a 28                	push   $0x28
  802fe7:	e8 43 fb ff ff       	call   802b2f <syscall>
  802fec:	83 c4 18             	add    $0x18,%esp
	return ;
  802fef:	90                   	nop
}
  802ff0:	c9                   	leave  
  802ff1:	c3                   	ret    

00802ff2 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802ff2:	55                   	push   %ebp
  802ff3:	89 e5                	mov    %esp,%ebp
  802ff5:	83 ec 04             	sub    $0x4,%esp
  802ff8:	8b 45 14             	mov    0x14(%ebp),%eax
  802ffb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802ffe:	8b 55 18             	mov    0x18(%ebp),%edx
  803001:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  803005:	52                   	push   %edx
  803006:	50                   	push   %eax
  803007:	ff 75 10             	pushl  0x10(%ebp)
  80300a:	ff 75 0c             	pushl  0xc(%ebp)
  80300d:	ff 75 08             	pushl  0x8(%ebp)
  803010:	6a 27                	push   $0x27
  803012:	e8 18 fb ff ff       	call   802b2f <syscall>
  803017:	83 c4 18             	add    $0x18,%esp
	return ;
  80301a:	90                   	nop
}
  80301b:	c9                   	leave  
  80301c:	c3                   	ret    

0080301d <chktst>:
void chktst(uint32 n)
{
  80301d:	55                   	push   %ebp
  80301e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  803020:	6a 00                	push   $0x0
  803022:	6a 00                	push   $0x0
  803024:	6a 00                	push   $0x0
  803026:	6a 00                	push   $0x0
  803028:	ff 75 08             	pushl  0x8(%ebp)
  80302b:	6a 29                	push   $0x29
  80302d:	e8 fd fa ff ff       	call   802b2f <syscall>
  803032:	83 c4 18             	add    $0x18,%esp
	return ;
  803035:	90                   	nop
}
  803036:	c9                   	leave  
  803037:	c3                   	ret    

00803038 <inctst>:

void inctst()
{
  803038:	55                   	push   %ebp
  803039:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80303b:	6a 00                	push   $0x0
  80303d:	6a 00                	push   $0x0
  80303f:	6a 00                	push   $0x0
  803041:	6a 00                	push   $0x0
  803043:	6a 00                	push   $0x0
  803045:	6a 2a                	push   $0x2a
  803047:	e8 e3 fa ff ff       	call   802b2f <syscall>
  80304c:	83 c4 18             	add    $0x18,%esp
	return ;
  80304f:	90                   	nop
}
  803050:	c9                   	leave  
  803051:	c3                   	ret    

00803052 <gettst>:
uint32 gettst()
{
  803052:	55                   	push   %ebp
  803053:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  803055:	6a 00                	push   $0x0
  803057:	6a 00                	push   $0x0
  803059:	6a 00                	push   $0x0
  80305b:	6a 00                	push   $0x0
  80305d:	6a 00                	push   $0x0
  80305f:	6a 2b                	push   $0x2b
  803061:	e8 c9 fa ff ff       	call   802b2f <syscall>
  803066:	83 c4 18             	add    $0x18,%esp
}
  803069:	c9                   	leave  
  80306a:	c3                   	ret    

0080306b <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80306b:	55                   	push   %ebp
  80306c:	89 e5                	mov    %esp,%ebp
  80306e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  803071:	6a 00                	push   $0x0
  803073:	6a 00                	push   $0x0
  803075:	6a 00                	push   $0x0
  803077:	6a 00                	push   $0x0
  803079:	6a 00                	push   $0x0
  80307b:	6a 2c                	push   $0x2c
  80307d:	e8 ad fa ff ff       	call   802b2f <syscall>
  803082:	83 c4 18             	add    $0x18,%esp
  803085:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  803088:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80308c:	75 07                	jne    803095 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80308e:	b8 01 00 00 00       	mov    $0x1,%eax
  803093:	eb 05                	jmp    80309a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  803095:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80309a:	c9                   	leave  
  80309b:	c3                   	ret    

0080309c <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80309c:	55                   	push   %ebp
  80309d:	89 e5                	mov    %esp,%ebp
  80309f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8030a2:	6a 00                	push   $0x0
  8030a4:	6a 00                	push   $0x0
  8030a6:	6a 00                	push   $0x0
  8030a8:	6a 00                	push   $0x0
  8030aa:	6a 00                	push   $0x0
  8030ac:	6a 2c                	push   $0x2c
  8030ae:	e8 7c fa ff ff       	call   802b2f <syscall>
  8030b3:	83 c4 18             	add    $0x18,%esp
  8030b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8030b9:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8030bd:	75 07                	jne    8030c6 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8030bf:	b8 01 00 00 00       	mov    $0x1,%eax
  8030c4:	eb 05                	jmp    8030cb <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8030c6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8030cb:	c9                   	leave  
  8030cc:	c3                   	ret    

008030cd <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8030cd:	55                   	push   %ebp
  8030ce:	89 e5                	mov    %esp,%ebp
  8030d0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8030d3:	6a 00                	push   $0x0
  8030d5:	6a 00                	push   $0x0
  8030d7:	6a 00                	push   $0x0
  8030d9:	6a 00                	push   $0x0
  8030db:	6a 00                	push   $0x0
  8030dd:	6a 2c                	push   $0x2c
  8030df:	e8 4b fa ff ff       	call   802b2f <syscall>
  8030e4:	83 c4 18             	add    $0x18,%esp
  8030e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8030ea:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8030ee:	75 07                	jne    8030f7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8030f0:	b8 01 00 00 00       	mov    $0x1,%eax
  8030f5:	eb 05                	jmp    8030fc <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8030f7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8030fc:	c9                   	leave  
  8030fd:	c3                   	ret    

008030fe <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8030fe:	55                   	push   %ebp
  8030ff:	89 e5                	mov    %esp,%ebp
  803101:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  803104:	6a 00                	push   $0x0
  803106:	6a 00                	push   $0x0
  803108:	6a 00                	push   $0x0
  80310a:	6a 00                	push   $0x0
  80310c:	6a 00                	push   $0x0
  80310e:	6a 2c                	push   $0x2c
  803110:	e8 1a fa ff ff       	call   802b2f <syscall>
  803115:	83 c4 18             	add    $0x18,%esp
  803118:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80311b:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80311f:	75 07                	jne    803128 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  803121:	b8 01 00 00 00       	mov    $0x1,%eax
  803126:	eb 05                	jmp    80312d <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  803128:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80312d:	c9                   	leave  
  80312e:	c3                   	ret    

0080312f <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80312f:	55                   	push   %ebp
  803130:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  803132:	6a 00                	push   $0x0
  803134:	6a 00                	push   $0x0
  803136:	6a 00                	push   $0x0
  803138:	6a 00                	push   $0x0
  80313a:	ff 75 08             	pushl  0x8(%ebp)
  80313d:	6a 2d                	push   $0x2d
  80313f:	e8 eb f9 ff ff       	call   802b2f <syscall>
  803144:	83 c4 18             	add    $0x18,%esp
	return ;
  803147:	90                   	nop
}
  803148:	c9                   	leave  
  803149:	c3                   	ret    

0080314a <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80314a:	55                   	push   %ebp
  80314b:	89 e5                	mov    %esp,%ebp
  80314d:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80314e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  803151:	8b 4d 10             	mov    0x10(%ebp),%ecx
  803154:	8b 55 0c             	mov    0xc(%ebp),%edx
  803157:	8b 45 08             	mov    0x8(%ebp),%eax
  80315a:	6a 00                	push   $0x0
  80315c:	53                   	push   %ebx
  80315d:	51                   	push   %ecx
  80315e:	52                   	push   %edx
  80315f:	50                   	push   %eax
  803160:	6a 2e                	push   $0x2e
  803162:	e8 c8 f9 ff ff       	call   802b2f <syscall>
  803167:	83 c4 18             	add    $0x18,%esp
}
  80316a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80316d:	c9                   	leave  
  80316e:	c3                   	ret    

0080316f <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80316f:	55                   	push   %ebp
  803170:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  803172:	8b 55 0c             	mov    0xc(%ebp),%edx
  803175:	8b 45 08             	mov    0x8(%ebp),%eax
  803178:	6a 00                	push   $0x0
  80317a:	6a 00                	push   $0x0
  80317c:	6a 00                	push   $0x0
  80317e:	52                   	push   %edx
  80317f:	50                   	push   %eax
  803180:	6a 2f                	push   $0x2f
  803182:	e8 a8 f9 ff ff       	call   802b2f <syscall>
  803187:	83 c4 18             	add    $0x18,%esp
}
  80318a:	c9                   	leave  
  80318b:	c3                   	ret    

0080318c <__udivdi3>:
  80318c:	55                   	push   %ebp
  80318d:	57                   	push   %edi
  80318e:	56                   	push   %esi
  80318f:	53                   	push   %ebx
  803190:	83 ec 1c             	sub    $0x1c,%esp
  803193:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  803197:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80319b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80319f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8031a3:	89 ca                	mov    %ecx,%edx
  8031a5:	89 f8                	mov    %edi,%eax
  8031a7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8031ab:	85 f6                	test   %esi,%esi
  8031ad:	75 2d                	jne    8031dc <__udivdi3+0x50>
  8031af:	39 cf                	cmp    %ecx,%edi
  8031b1:	77 65                	ja     803218 <__udivdi3+0x8c>
  8031b3:	89 fd                	mov    %edi,%ebp
  8031b5:	85 ff                	test   %edi,%edi
  8031b7:	75 0b                	jne    8031c4 <__udivdi3+0x38>
  8031b9:	b8 01 00 00 00       	mov    $0x1,%eax
  8031be:	31 d2                	xor    %edx,%edx
  8031c0:	f7 f7                	div    %edi
  8031c2:	89 c5                	mov    %eax,%ebp
  8031c4:	31 d2                	xor    %edx,%edx
  8031c6:	89 c8                	mov    %ecx,%eax
  8031c8:	f7 f5                	div    %ebp
  8031ca:	89 c1                	mov    %eax,%ecx
  8031cc:	89 d8                	mov    %ebx,%eax
  8031ce:	f7 f5                	div    %ebp
  8031d0:	89 cf                	mov    %ecx,%edi
  8031d2:	89 fa                	mov    %edi,%edx
  8031d4:	83 c4 1c             	add    $0x1c,%esp
  8031d7:	5b                   	pop    %ebx
  8031d8:	5e                   	pop    %esi
  8031d9:	5f                   	pop    %edi
  8031da:	5d                   	pop    %ebp
  8031db:	c3                   	ret    
  8031dc:	39 ce                	cmp    %ecx,%esi
  8031de:	77 28                	ja     803208 <__udivdi3+0x7c>
  8031e0:	0f bd fe             	bsr    %esi,%edi
  8031e3:	83 f7 1f             	xor    $0x1f,%edi
  8031e6:	75 40                	jne    803228 <__udivdi3+0x9c>
  8031e8:	39 ce                	cmp    %ecx,%esi
  8031ea:	72 0a                	jb     8031f6 <__udivdi3+0x6a>
  8031ec:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8031f0:	0f 87 9e 00 00 00    	ja     803294 <__udivdi3+0x108>
  8031f6:	b8 01 00 00 00       	mov    $0x1,%eax
  8031fb:	89 fa                	mov    %edi,%edx
  8031fd:	83 c4 1c             	add    $0x1c,%esp
  803200:	5b                   	pop    %ebx
  803201:	5e                   	pop    %esi
  803202:	5f                   	pop    %edi
  803203:	5d                   	pop    %ebp
  803204:	c3                   	ret    
  803205:	8d 76 00             	lea    0x0(%esi),%esi
  803208:	31 ff                	xor    %edi,%edi
  80320a:	31 c0                	xor    %eax,%eax
  80320c:	89 fa                	mov    %edi,%edx
  80320e:	83 c4 1c             	add    $0x1c,%esp
  803211:	5b                   	pop    %ebx
  803212:	5e                   	pop    %esi
  803213:	5f                   	pop    %edi
  803214:	5d                   	pop    %ebp
  803215:	c3                   	ret    
  803216:	66 90                	xchg   %ax,%ax
  803218:	89 d8                	mov    %ebx,%eax
  80321a:	f7 f7                	div    %edi
  80321c:	31 ff                	xor    %edi,%edi
  80321e:	89 fa                	mov    %edi,%edx
  803220:	83 c4 1c             	add    $0x1c,%esp
  803223:	5b                   	pop    %ebx
  803224:	5e                   	pop    %esi
  803225:	5f                   	pop    %edi
  803226:	5d                   	pop    %ebp
  803227:	c3                   	ret    
  803228:	bd 20 00 00 00       	mov    $0x20,%ebp
  80322d:	89 eb                	mov    %ebp,%ebx
  80322f:	29 fb                	sub    %edi,%ebx
  803231:	89 f9                	mov    %edi,%ecx
  803233:	d3 e6                	shl    %cl,%esi
  803235:	89 c5                	mov    %eax,%ebp
  803237:	88 d9                	mov    %bl,%cl
  803239:	d3 ed                	shr    %cl,%ebp
  80323b:	89 e9                	mov    %ebp,%ecx
  80323d:	09 f1                	or     %esi,%ecx
  80323f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  803243:	89 f9                	mov    %edi,%ecx
  803245:	d3 e0                	shl    %cl,%eax
  803247:	89 c5                	mov    %eax,%ebp
  803249:	89 d6                	mov    %edx,%esi
  80324b:	88 d9                	mov    %bl,%cl
  80324d:	d3 ee                	shr    %cl,%esi
  80324f:	89 f9                	mov    %edi,%ecx
  803251:	d3 e2                	shl    %cl,%edx
  803253:	8b 44 24 08          	mov    0x8(%esp),%eax
  803257:	88 d9                	mov    %bl,%cl
  803259:	d3 e8                	shr    %cl,%eax
  80325b:	09 c2                	or     %eax,%edx
  80325d:	89 d0                	mov    %edx,%eax
  80325f:	89 f2                	mov    %esi,%edx
  803261:	f7 74 24 0c          	divl   0xc(%esp)
  803265:	89 d6                	mov    %edx,%esi
  803267:	89 c3                	mov    %eax,%ebx
  803269:	f7 e5                	mul    %ebp
  80326b:	39 d6                	cmp    %edx,%esi
  80326d:	72 19                	jb     803288 <__udivdi3+0xfc>
  80326f:	74 0b                	je     80327c <__udivdi3+0xf0>
  803271:	89 d8                	mov    %ebx,%eax
  803273:	31 ff                	xor    %edi,%edi
  803275:	e9 58 ff ff ff       	jmp    8031d2 <__udivdi3+0x46>
  80327a:	66 90                	xchg   %ax,%ax
  80327c:	8b 54 24 08          	mov    0x8(%esp),%edx
  803280:	89 f9                	mov    %edi,%ecx
  803282:	d3 e2                	shl    %cl,%edx
  803284:	39 c2                	cmp    %eax,%edx
  803286:	73 e9                	jae    803271 <__udivdi3+0xe5>
  803288:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80328b:	31 ff                	xor    %edi,%edi
  80328d:	e9 40 ff ff ff       	jmp    8031d2 <__udivdi3+0x46>
  803292:	66 90                	xchg   %ax,%ax
  803294:	31 c0                	xor    %eax,%eax
  803296:	e9 37 ff ff ff       	jmp    8031d2 <__udivdi3+0x46>
  80329b:	90                   	nop

0080329c <__umoddi3>:
  80329c:	55                   	push   %ebp
  80329d:	57                   	push   %edi
  80329e:	56                   	push   %esi
  80329f:	53                   	push   %ebx
  8032a0:	83 ec 1c             	sub    $0x1c,%esp
  8032a3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8032a7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8032ab:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8032af:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8032b3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8032b7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8032bb:	89 f3                	mov    %esi,%ebx
  8032bd:	89 fa                	mov    %edi,%edx
  8032bf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8032c3:	89 34 24             	mov    %esi,(%esp)
  8032c6:	85 c0                	test   %eax,%eax
  8032c8:	75 1a                	jne    8032e4 <__umoddi3+0x48>
  8032ca:	39 f7                	cmp    %esi,%edi
  8032cc:	0f 86 a2 00 00 00    	jbe    803374 <__umoddi3+0xd8>
  8032d2:	89 c8                	mov    %ecx,%eax
  8032d4:	89 f2                	mov    %esi,%edx
  8032d6:	f7 f7                	div    %edi
  8032d8:	89 d0                	mov    %edx,%eax
  8032da:	31 d2                	xor    %edx,%edx
  8032dc:	83 c4 1c             	add    $0x1c,%esp
  8032df:	5b                   	pop    %ebx
  8032e0:	5e                   	pop    %esi
  8032e1:	5f                   	pop    %edi
  8032e2:	5d                   	pop    %ebp
  8032e3:	c3                   	ret    
  8032e4:	39 f0                	cmp    %esi,%eax
  8032e6:	0f 87 ac 00 00 00    	ja     803398 <__umoddi3+0xfc>
  8032ec:	0f bd e8             	bsr    %eax,%ebp
  8032ef:	83 f5 1f             	xor    $0x1f,%ebp
  8032f2:	0f 84 ac 00 00 00    	je     8033a4 <__umoddi3+0x108>
  8032f8:	bf 20 00 00 00       	mov    $0x20,%edi
  8032fd:	29 ef                	sub    %ebp,%edi
  8032ff:	89 fe                	mov    %edi,%esi
  803301:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  803305:	89 e9                	mov    %ebp,%ecx
  803307:	d3 e0                	shl    %cl,%eax
  803309:	89 d7                	mov    %edx,%edi
  80330b:	89 f1                	mov    %esi,%ecx
  80330d:	d3 ef                	shr    %cl,%edi
  80330f:	09 c7                	or     %eax,%edi
  803311:	89 e9                	mov    %ebp,%ecx
  803313:	d3 e2                	shl    %cl,%edx
  803315:	89 14 24             	mov    %edx,(%esp)
  803318:	89 d8                	mov    %ebx,%eax
  80331a:	d3 e0                	shl    %cl,%eax
  80331c:	89 c2                	mov    %eax,%edx
  80331e:	8b 44 24 08          	mov    0x8(%esp),%eax
  803322:	d3 e0                	shl    %cl,%eax
  803324:	89 44 24 04          	mov    %eax,0x4(%esp)
  803328:	8b 44 24 08          	mov    0x8(%esp),%eax
  80332c:	89 f1                	mov    %esi,%ecx
  80332e:	d3 e8                	shr    %cl,%eax
  803330:	09 d0                	or     %edx,%eax
  803332:	d3 eb                	shr    %cl,%ebx
  803334:	89 da                	mov    %ebx,%edx
  803336:	f7 f7                	div    %edi
  803338:	89 d3                	mov    %edx,%ebx
  80333a:	f7 24 24             	mull   (%esp)
  80333d:	89 c6                	mov    %eax,%esi
  80333f:	89 d1                	mov    %edx,%ecx
  803341:	39 d3                	cmp    %edx,%ebx
  803343:	0f 82 87 00 00 00    	jb     8033d0 <__umoddi3+0x134>
  803349:	0f 84 91 00 00 00    	je     8033e0 <__umoddi3+0x144>
  80334f:	8b 54 24 04          	mov    0x4(%esp),%edx
  803353:	29 f2                	sub    %esi,%edx
  803355:	19 cb                	sbb    %ecx,%ebx
  803357:	89 d8                	mov    %ebx,%eax
  803359:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80335d:	d3 e0                	shl    %cl,%eax
  80335f:	89 e9                	mov    %ebp,%ecx
  803361:	d3 ea                	shr    %cl,%edx
  803363:	09 d0                	or     %edx,%eax
  803365:	89 e9                	mov    %ebp,%ecx
  803367:	d3 eb                	shr    %cl,%ebx
  803369:	89 da                	mov    %ebx,%edx
  80336b:	83 c4 1c             	add    $0x1c,%esp
  80336e:	5b                   	pop    %ebx
  80336f:	5e                   	pop    %esi
  803370:	5f                   	pop    %edi
  803371:	5d                   	pop    %ebp
  803372:	c3                   	ret    
  803373:	90                   	nop
  803374:	89 fd                	mov    %edi,%ebp
  803376:	85 ff                	test   %edi,%edi
  803378:	75 0b                	jne    803385 <__umoddi3+0xe9>
  80337a:	b8 01 00 00 00       	mov    $0x1,%eax
  80337f:	31 d2                	xor    %edx,%edx
  803381:	f7 f7                	div    %edi
  803383:	89 c5                	mov    %eax,%ebp
  803385:	89 f0                	mov    %esi,%eax
  803387:	31 d2                	xor    %edx,%edx
  803389:	f7 f5                	div    %ebp
  80338b:	89 c8                	mov    %ecx,%eax
  80338d:	f7 f5                	div    %ebp
  80338f:	89 d0                	mov    %edx,%eax
  803391:	e9 44 ff ff ff       	jmp    8032da <__umoddi3+0x3e>
  803396:	66 90                	xchg   %ax,%ax
  803398:	89 c8                	mov    %ecx,%eax
  80339a:	89 f2                	mov    %esi,%edx
  80339c:	83 c4 1c             	add    $0x1c,%esp
  80339f:	5b                   	pop    %ebx
  8033a0:	5e                   	pop    %esi
  8033a1:	5f                   	pop    %edi
  8033a2:	5d                   	pop    %ebp
  8033a3:	c3                   	ret    
  8033a4:	3b 04 24             	cmp    (%esp),%eax
  8033a7:	72 06                	jb     8033af <__umoddi3+0x113>
  8033a9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8033ad:	77 0f                	ja     8033be <__umoddi3+0x122>
  8033af:	89 f2                	mov    %esi,%edx
  8033b1:	29 f9                	sub    %edi,%ecx
  8033b3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8033b7:	89 14 24             	mov    %edx,(%esp)
  8033ba:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8033be:	8b 44 24 04          	mov    0x4(%esp),%eax
  8033c2:	8b 14 24             	mov    (%esp),%edx
  8033c5:	83 c4 1c             	add    $0x1c,%esp
  8033c8:	5b                   	pop    %ebx
  8033c9:	5e                   	pop    %esi
  8033ca:	5f                   	pop    %edi
  8033cb:	5d                   	pop    %ebp
  8033cc:	c3                   	ret    
  8033cd:	8d 76 00             	lea    0x0(%esi),%esi
  8033d0:	2b 04 24             	sub    (%esp),%eax
  8033d3:	19 fa                	sbb    %edi,%edx
  8033d5:	89 d1                	mov    %edx,%ecx
  8033d7:	89 c6                	mov    %eax,%esi
  8033d9:	e9 71 ff ff ff       	jmp    80334f <__umoddi3+0xb3>
  8033de:	66 90                	xchg   %ax,%ax
  8033e0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8033e4:	72 ea                	jb     8033d0 <__umoddi3+0x134>
  8033e6:	89 d9                	mov    %ebx,%ecx
  8033e8:	e9 62 ff ff ff       	jmp    80334f <__umoddi3+0xb3>
