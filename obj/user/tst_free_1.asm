
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
  800031:	e8 34 17 00 00       	call   80176a <libmain>
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
  800056:	68 20 35 80 00       	push   $0x803520
  80005b:	e8 f1 1a 00 00       	call   801b51 <cprintf>
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
  80007f:	68 2f 35 80 00       	push   $0x80352f
  800084:	6a 20                	push   $0x20
  800086:	68 4b 35 80 00       	push   $0x80354b
  80008b:	e8 1f 18 00 00       	call   8018af <_panic>
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
  8000c0:	e8 fd 2c 00 00       	call   802dc2 <sys_calculate_free_frames>
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
  8000f3:	e8 4d 2d 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  8000f8:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000fe:	01 c0                	add    %eax,%eax
  800100:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800103:	83 ec 0c             	sub    $0xc,%esp
  800106:	50                   	push   %eax
  800107:	e8 cf 27 00 00       	call   8028db <malloc>
  80010c:	83 c4 10             	add    $0x10,%esp
  80010f:	89 85 c8 fe ff ff    	mov    %eax,-0x138(%ebp)
		cprintf("1-I am here\n");
  800115:	83 ec 0c             	sub    $0xc,%esp
  800118:	68 5d 35 80 00       	push   $0x80355d
  80011d:	e8 2f 1a 00 00       	call   801b51 <cprintf>
  800122:	83 c4 10             	add    $0x10,%esp
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800125:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  80012b:	85 c0                	test   %eax,%eax
  80012d:	79 0d                	jns    80013c <_main+0x104>
  80012f:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  800135:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  80013a:	76 14                	jbe    800150 <_main+0x118>
  80013c:	83 ec 04             	sub    $0x4,%esp
  80013f:	68 6c 35 80 00       	push   $0x80356c
  800144:	6a 3c                	push   $0x3c
  800146:	68 4b 35 80 00       	push   $0x80354b
  80014b:	e8 5f 17 00 00       	call   8018af <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  800150:	e8 f0 2c 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  800155:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800158:	3d 00 02 00 00       	cmp    $0x200,%eax
  80015d:	74 14                	je     800173 <_main+0x13b>
  80015f:	83 ec 04             	sub    $0x4,%esp
  800162:	68 d4 35 80 00       	push   $0x8035d4
  800167:	6a 3d                	push   $0x3d
  800169:	68 4b 35 80 00       	push   $0x80354b
  80016e:	e8 3c 17 00 00       	call   8018af <_panic>
		int freeFrames = sys_calculate_free_frames() ;
  800173:	e8 4a 2c 00 00       	call   802dc2 <sys_calculate_free_frames>
  800178:	89 45 bc             	mov    %eax,-0x44(%ebp)
		cprintf("Hadi Ehab\n");
  80017b:	83 ec 0c             	sub    $0xc,%esp
  80017e:	68 02 36 80 00       	push   $0x803602
  800183:	e8 c9 19 00 00       	call   801b51 <cprintf>
  800188:	83 c4 10             	add    $0x10,%esp
		lastIndexOfByte = (2*Mega-kilo)/sizeof(char) - 1;
  80018b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80018e:	01 c0                	add    %eax,%eax
  800190:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800193:	48                   	dec    %eax
  800194:	89 45 b8             	mov    %eax,-0x48(%ebp)
		byteArr = (char *) ptr_allocations[0];
  800197:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  80019d:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		byteArr[0] = minByte ;
  8001a0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8001a3:	8a 55 db             	mov    -0x25(%ebp),%dl
  8001a6:	88 10                	mov    %dl,(%eax)
		byteArr[lastIndexOfByte] = maxByte ;
  8001a8:	8b 55 b8             	mov    -0x48(%ebp),%edx
  8001ab:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8001ae:	01 c2                	add    %eax,%edx
  8001b0:	8a 45 da             	mov    -0x26(%ebp),%al
  8001b3:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8001b5:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  8001b8:	e8 05 2c 00 00       	call   802dc2 <sys_calculate_free_frames>
  8001bd:	29 c3                	sub    %eax,%ebx
  8001bf:	89 d8                	mov    %ebx,%eax
  8001c1:	83 f8 03             	cmp    $0x3,%eax
  8001c4:	74 14                	je     8001da <_main+0x1a2>
  8001c6:	83 ec 04             	sub    $0x4,%esp
  8001c9:	68 10 36 80 00       	push   $0x803610
  8001ce:	6a 44                	push   $0x44
  8001d0:	68 4b 35 80 00       	push   $0x80354b
  8001d5:	e8 d5 16 00 00       	call   8018af <_panic>
		int var;
		cprintf("Hadi Atef\n");
  8001da:	83 ec 0c             	sub    $0xc,%esp
  8001dd:	68 53 36 80 00       	push   $0x803653
  8001e2:	e8 6a 19 00 00       	call   801b51 <cprintf>
  8001e7:	83 c4 10             	add    $0x10,%esp
		int found = 0;
  8001ea:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)

		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8001f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8001f8:	eb 76                	jmp    800270 <_main+0x238>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
  8001fa:	a1 20 40 80 00       	mov    0x804020,%eax
  8001ff:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800205:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800208:	c1 e2 04             	shl    $0x4,%edx
  80020b:	01 d0                	add    %edx,%eax
  80020d:	8b 00                	mov    (%eax),%eax
  80020f:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800212:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800215:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80021a:	89 c2                	mov    %eax,%edx
  80021c:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80021f:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800222:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800225:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80022a:	39 c2                	cmp    %eax,%edx
  80022c:	75 03                	jne    800231 <_main+0x1f9>
				found++;
  80022e:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
  800231:	a1 20 40 80 00       	mov    0x804020,%eax
  800236:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80023c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80023f:	c1 e2 04             	shl    $0x4,%edx
  800242:	01 d0                	add    %edx,%eax
  800244:	8b 00                	mov    (%eax),%eax
  800246:	89 45 a8             	mov    %eax,-0x58(%ebp)
  800249:	8b 45 a8             	mov    -0x58(%ebp),%eax
  80024c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800251:	89 c1                	mov    %eax,%ecx
  800253:	8b 55 b8             	mov    -0x48(%ebp),%edx
  800256:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800259:	01 d0                	add    %edx,%eax
  80025b:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  80025e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800261:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800266:	39 c1                	cmp    %eax,%ecx
  800268:	75 03                	jne    80026d <_main+0x235>
				found++;
  80026a:	ff 45 e8             	incl   -0x18(%ebp)
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		int var;
		cprintf("Hadi Atef\n");
		int found = 0;

		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80026d:	ff 45 ec             	incl   -0x14(%ebp)
  800270:	a1 20 40 80 00       	mov    0x804020,%eax
  800275:	8b 50 74             	mov    0x74(%eax),%edx
  800278:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80027b:	39 c2                	cmp    %eax,%edx
  80027d:	0f 87 77 ff ff ff    	ja     8001fa <_main+0x1c2>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800283:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800287:	74 14                	je     80029d <_main+0x265>
  800289:	83 ec 04             	sub    $0x4,%esp
  80028c:	68 60 36 80 00       	push   $0x803660
  800291:	6a 50                	push   $0x50
  800293:	68 4b 35 80 00       	push   $0x80354b
  800298:	e8 12 16 00 00       	call   8018af <_panic>
		cprintf("Fares Ahmed\n");
  80029d:	83 ec 0c             	sub    $0xc,%esp
  8002a0:	68 80 36 80 00       	push   $0x803680
  8002a5:	e8 a7 18 00 00       	call   801b51 <cprintf>
  8002aa:	83 c4 10             	add    $0x10,%esp

		//2 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002ad:	e8 93 2b 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  8002b2:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  8002b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002b8:	01 c0                	add    %eax,%eax
  8002ba:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8002bd:	83 ec 0c             	sub    $0xc,%esp
  8002c0:	50                   	push   %eax
  8002c1:	e8 15 26 00 00       	call   8028db <malloc>
  8002c6:	83 c4 10             	add    $0x10,%esp
  8002c9:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START+ 2*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8002cf:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  8002d5:	89 c2                	mov    %eax,%edx
  8002d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002da:	01 c0                	add    %eax,%eax
  8002dc:	05 00 00 00 80       	add    $0x80000000,%eax
  8002e1:	39 c2                	cmp    %eax,%edx
  8002e3:	72 16                	jb     8002fb <_main+0x2c3>
  8002e5:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  8002eb:	89 c2                	mov    %eax,%edx
  8002ed:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002f0:	01 c0                	add    %eax,%eax
  8002f2:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8002f7:	39 c2                	cmp    %eax,%edx
  8002f9:	76 14                	jbe    80030f <_main+0x2d7>
  8002fb:	83 ec 04             	sub    $0x4,%esp
  8002fe:	68 6c 35 80 00       	push   $0x80356c
  800303:	6a 56                	push   $0x56
  800305:	68 4b 35 80 00       	push   $0x80354b
  80030a:	e8 a0 15 00 00       	call   8018af <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  80030f:	e8 31 2b 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  800314:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800317:	3d 00 02 00 00       	cmp    $0x200,%eax
  80031c:	74 14                	je     800332 <_main+0x2fa>
  80031e:	83 ec 04             	sub    $0x4,%esp
  800321:	68 d4 35 80 00       	push   $0x8035d4
  800326:	6a 57                	push   $0x57
  800328:	68 4b 35 80 00       	push   $0x80354b
  80032d:	e8 7d 15 00 00       	call   8018af <_panic>
		freeFrames = sys_calculate_free_frames() ;
  800332:	e8 8b 2a 00 00       	call   802dc2 <sys_calculate_free_frames>
  800337:	89 45 bc             	mov    %eax,-0x44(%ebp)
		shortArr = (short *) ptr_allocations[1];
  80033a:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  800340:	89 45 a0             	mov    %eax,-0x60(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  800343:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800346:	01 c0                	add    %eax,%eax
  800348:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80034b:	d1 e8                	shr    %eax
  80034d:	48                   	dec    %eax
  80034e:	89 45 9c             	mov    %eax,-0x64(%ebp)
		shortArr[0] = minShort;
  800351:	8b 55 a0             	mov    -0x60(%ebp),%edx
  800354:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800357:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  80035a:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80035d:	01 c0                	add    %eax,%eax
  80035f:	89 c2                	mov    %eax,%edx
  800361:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800364:	01 c2                	add    %eax,%edx
  800366:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  80036a:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  80036d:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  800370:	e8 4d 2a 00 00       	call   802dc2 <sys_calculate_free_frames>
  800375:	29 c3                	sub    %eax,%ebx
  800377:	89 d8                	mov    %ebx,%eax
  800379:	83 f8 02             	cmp    $0x2,%eax
  80037c:	74 14                	je     800392 <_main+0x35a>
  80037e:	83 ec 04             	sub    $0x4,%esp
  800381:	68 10 36 80 00       	push   $0x803610
  800386:	6a 5d                	push   $0x5d
  800388:	68 4b 35 80 00       	push   $0x80354b
  80038d:	e8 1d 15 00 00       	call   8018af <_panic>
		found = 0;
  800392:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800399:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8003a0:	eb 7a                	jmp    80041c <_main+0x3e4>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  8003a2:	a1 20 40 80 00       	mov    0x804020,%eax
  8003a7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003ad:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003b0:	c1 e2 04             	shl    $0x4,%edx
  8003b3:	01 d0                	add    %edx,%eax
  8003b5:	8b 00                	mov    (%eax),%eax
  8003b7:	89 45 98             	mov    %eax,-0x68(%ebp)
  8003ba:	8b 45 98             	mov    -0x68(%ebp),%eax
  8003bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003c2:	89 c2                	mov    %eax,%edx
  8003c4:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8003c7:	89 45 94             	mov    %eax,-0x6c(%ebp)
  8003ca:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8003cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003d2:	39 c2                	cmp    %eax,%edx
  8003d4:	75 03                	jne    8003d9 <_main+0x3a1>
				found++;
  8003d6:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  8003d9:	a1 20 40 80 00       	mov    0x804020,%eax
  8003de:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003e4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003e7:	c1 e2 04             	shl    $0x4,%edx
  8003ea:	01 d0                	add    %edx,%eax
  8003ec:	8b 00                	mov    (%eax),%eax
  8003ee:	89 45 90             	mov    %eax,-0x70(%ebp)
  8003f1:	8b 45 90             	mov    -0x70(%ebp),%eax
  8003f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003f9:	89 c2                	mov    %eax,%edx
  8003fb:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8003fe:	01 c0                	add    %eax,%eax
  800400:	89 c1                	mov    %eax,%ecx
  800402:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800405:	01 c8                	add    %ecx,%eax
  800407:	89 45 8c             	mov    %eax,-0x74(%ebp)
  80040a:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80040d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800412:	39 c2                	cmp    %eax,%edx
  800414:	75 03                	jne    800419 <_main+0x3e1>
				found++;
  800416:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
		shortArr[0] = minShort;
		shortArr[lastIndexOfShort] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800419:	ff 45 ec             	incl   -0x14(%ebp)
  80041c:	a1 20 40 80 00       	mov    0x804020,%eax
  800421:	8b 50 74             	mov    0x74(%eax),%edx
  800424:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800427:	39 c2                	cmp    %eax,%edx
  800429:	0f 87 73 ff ff ff    	ja     8003a2 <_main+0x36a>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  80042f:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800433:	74 14                	je     800449 <_main+0x411>
  800435:	83 ec 04             	sub    $0x4,%esp
  800438:	68 60 36 80 00       	push   $0x803660
  80043d:	6a 66                	push   $0x66
  80043f:	68 4b 35 80 00       	push   $0x80354b
  800444:	e8 66 14 00 00       	call   8018af <_panic>
		cprintf("Finished 2nd allocation\n");
  800449:	83 ec 0c             	sub    $0xc,%esp
  80044c:	68 8d 36 80 00       	push   $0x80368d
  800451:	e8 fb 16 00 00       	call   801b51 <cprintf>
  800456:	83 c4 10             	add    $0x10,%esp
		//3 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800459:	e8 e7 29 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  80045e:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[2] = malloc(3*kilo);
  800461:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800464:	89 c2                	mov    %eax,%edx
  800466:	01 d2                	add    %edx,%edx
  800468:	01 d0                	add    %edx,%eax
  80046a:	83 ec 0c             	sub    $0xc,%esp
  80046d:	50                   	push   %eax
  80046e:	e8 68 24 00 00       	call   8028db <malloc>
  800473:	83 c4 10             	add    $0x10,%esp
  800476:	89 85 d0 fe ff ff    	mov    %eax,-0x130(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START+ 4*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80047c:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  800482:	89 c2                	mov    %eax,%edx
  800484:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800487:	c1 e0 02             	shl    $0x2,%eax
  80048a:	05 00 00 00 80       	add    $0x80000000,%eax
  80048f:	39 c2                	cmp    %eax,%edx
  800491:	72 17                	jb     8004aa <_main+0x472>
  800493:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  800499:	89 c2                	mov    %eax,%edx
  80049b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80049e:	c1 e0 02             	shl    $0x2,%eax
  8004a1:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8004a6:	39 c2                	cmp    %eax,%edx
  8004a8:	76 14                	jbe    8004be <_main+0x486>
  8004aa:	83 ec 04             	sub    $0x4,%esp
  8004ad:	68 6c 35 80 00       	push   $0x80356c
  8004b2:	6a 6b                	push   $0x6b
  8004b4:	68 4b 35 80 00       	push   $0x80354b
  8004b9:	e8 f1 13 00 00       	call   8018af <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  8004be:	e8 82 29 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  8004c3:	2b 45 c0             	sub    -0x40(%ebp),%eax
  8004c6:	83 f8 01             	cmp    $0x1,%eax
  8004c9:	74 14                	je     8004df <_main+0x4a7>
  8004cb:	83 ec 04             	sub    $0x4,%esp
  8004ce:	68 d4 35 80 00       	push   $0x8035d4
  8004d3:	6a 6c                	push   $0x6c
  8004d5:	68 4b 35 80 00       	push   $0x80354b
  8004da:	e8 d0 13 00 00       	call   8018af <_panic>
		freeFrames = sys_calculate_free_frames() ;
  8004df:	e8 de 28 00 00       	call   802dc2 <sys_calculate_free_frames>
  8004e4:	89 45 bc             	mov    %eax,-0x44(%ebp)
		intArr = (int *) ptr_allocations[2];
  8004e7:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  8004ed:	89 45 88             	mov    %eax,-0x78(%ebp)
		lastIndexOfInt = (3*kilo)/sizeof(int) - 1;
  8004f0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004f3:	89 c2                	mov    %eax,%edx
  8004f5:	01 d2                	add    %edx,%edx
  8004f7:	01 d0                	add    %edx,%eax
  8004f9:	c1 e8 02             	shr    $0x2,%eax
  8004fc:	48                   	dec    %eax
  8004fd:	89 45 84             	mov    %eax,-0x7c(%ebp)
		intArr[0] = minInt;
  800500:	8b 45 88             	mov    -0x78(%ebp),%eax
  800503:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800506:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  800508:	8b 45 84             	mov    -0x7c(%ebp),%eax
  80050b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800512:	8b 45 88             	mov    -0x78(%ebp),%eax
  800515:	01 c2                	add    %eax,%edx
  800517:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80051a:	89 02                	mov    %eax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  80051c:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  80051f:	e8 9e 28 00 00       	call   802dc2 <sys_calculate_free_frames>
  800524:	29 c3                	sub    %eax,%ebx
  800526:	89 d8                	mov    %ebx,%eax
  800528:	83 f8 02             	cmp    $0x2,%eax
  80052b:	74 14                	je     800541 <_main+0x509>
  80052d:	83 ec 04             	sub    $0x4,%esp
  800530:	68 10 36 80 00       	push   $0x803610
  800535:	6a 72                	push   $0x72
  800537:	68 4b 35 80 00       	push   $0x80354b
  80053c:	e8 6e 13 00 00       	call   8018af <_panic>
		found = 0;
  800541:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800548:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  80054f:	e9 8f 00 00 00       	jmp    8005e3 <_main+0x5ab>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
  800554:	a1 20 40 80 00       	mov    0x804020,%eax
  800559:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80055f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800562:	c1 e2 04             	shl    $0x4,%edx
  800565:	01 d0                	add    %edx,%eax
  800567:	8b 00                	mov    (%eax),%eax
  800569:	89 45 80             	mov    %eax,-0x80(%ebp)
  80056c:	8b 45 80             	mov    -0x80(%ebp),%eax
  80056f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800574:	89 c2                	mov    %eax,%edx
  800576:	8b 45 88             	mov    -0x78(%ebp),%eax
  800579:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
  80057f:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800585:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80058a:	39 c2                	cmp    %eax,%edx
  80058c:	75 03                	jne    800591 <_main+0x559>
				found++;
  80058e:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
  800591:	a1 20 40 80 00       	mov    0x804020,%eax
  800596:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80059c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80059f:	c1 e2 04             	shl    $0x4,%edx
  8005a2:	01 d0                	add    %edx,%eax
  8005a4:	8b 00                	mov    (%eax),%eax
  8005a6:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  8005ac:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  8005b2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005b7:	89 c2                	mov    %eax,%edx
  8005b9:	8b 45 84             	mov    -0x7c(%ebp),%eax
  8005bc:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005c3:	8b 45 88             	mov    -0x78(%ebp),%eax
  8005c6:	01 c8                	add    %ecx,%eax
  8005c8:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
  8005ce:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  8005d4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005d9:	39 c2                	cmp    %eax,%edx
  8005db:	75 03                	jne    8005e0 <_main+0x5a8>
				found++;
  8005dd:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfInt = (3*kilo)/sizeof(int) - 1;
		intArr[0] = minInt;
		intArr[lastIndexOfInt] = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8005e0:	ff 45 ec             	incl   -0x14(%ebp)
  8005e3:	a1 20 40 80 00       	mov    0x804020,%eax
  8005e8:	8b 50 74             	mov    0x74(%eax),%edx
  8005eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005ee:	39 c2                	cmp    %eax,%edx
  8005f0:	0f 87 5e ff ff ff    	ja     800554 <_main+0x51c>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  8005f6:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  8005fa:	74 14                	je     800610 <_main+0x5d8>
  8005fc:	83 ec 04             	sub    $0x4,%esp
  8005ff:	68 60 36 80 00       	push   $0x803660
  800604:	6a 7b                	push   $0x7b
  800606:	68 4b 35 80 00       	push   $0x80354b
  80060b:	e8 9f 12 00 00       	call   8018af <_panic>
		cprintf("malloc 3\n");
  800610:	83 ec 0c             	sub    $0xc,%esp
  800613:	68 a6 36 80 00       	push   $0x8036a6
  800618:	e8 34 15 00 00       	call   801b51 <cprintf>
  80061d:	83 c4 10             	add    $0x10,%esp
		//3 KB
		freeFrames = sys_calculate_free_frames() ;
  800620:	e8 9d 27 00 00       	call   802dc2 <sys_calculate_free_frames>
  800625:	89 45 bc             	mov    %eax,-0x44(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800628:	e8 18 28 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  80062d:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[3] = malloc(3*kilo);
  800630:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800633:	89 c2                	mov    %eax,%edx
  800635:	01 d2                	add    %edx,%edx
  800637:	01 d0                	add    %edx,%eax
  800639:	83 ec 0c             	sub    $0xc,%esp
  80063c:	50                   	push   %eax
  80063d:	e8 99 22 00 00       	call   8028db <malloc>
  800642:	83 c4 10             	add    $0x10,%esp
  800645:	89 85 d4 fe ff ff    	mov    %eax,-0x12c(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START+ 4*Mega + 4*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80064b:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  800651:	89 c2                	mov    %eax,%edx
  800653:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800656:	c1 e0 02             	shl    $0x2,%eax
  800659:	89 c1                	mov    %eax,%ecx
  80065b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80065e:	c1 e0 02             	shl    $0x2,%eax
  800661:	01 c8                	add    %ecx,%eax
  800663:	05 00 00 00 80       	add    $0x80000000,%eax
  800668:	39 c2                	cmp    %eax,%edx
  80066a:	72 21                	jb     80068d <_main+0x655>
  80066c:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  800672:	89 c2                	mov    %eax,%edx
  800674:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800677:	c1 e0 02             	shl    $0x2,%eax
  80067a:	89 c1                	mov    %eax,%ecx
  80067c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80067f:	c1 e0 02             	shl    $0x2,%eax
  800682:	01 c8                	add    %ecx,%eax
  800684:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800689:	39 c2                	cmp    %eax,%edx
  80068b:	76 17                	jbe    8006a4 <_main+0x66c>
  80068d:	83 ec 04             	sub    $0x4,%esp
  800690:	68 6c 35 80 00       	push   $0x80356c
  800695:	68 81 00 00 00       	push   $0x81
  80069a:	68 4b 35 80 00       	push   $0x80354b
  80069f:	e8 0b 12 00 00       	call   8018af <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  8006a4:	e8 9c 27 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  8006a9:	2b 45 c0             	sub    -0x40(%ebp),%eax
  8006ac:	83 f8 01             	cmp    $0x1,%eax
  8006af:	74 17                	je     8006c8 <_main+0x690>
  8006b1:	83 ec 04             	sub    $0x4,%esp
  8006b4:	68 d4 35 80 00       	push   $0x8035d4
  8006b9:	68 82 00 00 00       	push   $0x82
  8006be:	68 4b 35 80 00       	push   $0x80354b
  8006c3:	e8 e7 11 00 00       	call   8018af <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
		cprintf("malloc 4\n");
  8006c8:	83 ec 0c             	sub    $0xc,%esp
  8006cb:	68 b0 36 80 00       	push   $0x8036b0
  8006d0:	e8 7c 14 00 00       	call   801b51 <cprintf>
  8006d5:	83 c4 10             	add    $0x10,%esp
		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8006d8:	e8 68 27 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  8006dd:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  8006e0:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8006e3:	89 d0                	mov    %edx,%eax
  8006e5:	01 c0                	add    %eax,%eax
  8006e7:	01 d0                	add    %edx,%eax
  8006e9:	01 c0                	add    %eax,%eax
  8006eb:	01 d0                	add    %edx,%eax
  8006ed:	83 ec 0c             	sub    $0xc,%esp
  8006f0:	50                   	push   %eax
  8006f1:	e8 e5 21 00 00       	call   8028db <malloc>
  8006f6:	83 c4 10             	add    $0x10,%esp
  8006f9:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo)|| (uint32) ptr_allocations[4] > (USER_HEAP_START+ 4*Mega + 8*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8006ff:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  800705:	89 c2                	mov    %eax,%edx
  800707:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80070a:	c1 e0 02             	shl    $0x2,%eax
  80070d:	89 c1                	mov    %eax,%ecx
  80070f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800712:	c1 e0 03             	shl    $0x3,%eax
  800715:	01 c8                	add    %ecx,%eax
  800717:	05 00 00 00 80       	add    $0x80000000,%eax
  80071c:	39 c2                	cmp    %eax,%edx
  80071e:	72 21                	jb     800741 <_main+0x709>
  800720:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  800726:	89 c2                	mov    %eax,%edx
  800728:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80072b:	c1 e0 02             	shl    $0x2,%eax
  80072e:	89 c1                	mov    %eax,%ecx
  800730:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800733:	c1 e0 03             	shl    $0x3,%eax
  800736:	01 c8                	add    %ecx,%eax
  800738:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80073d:	39 c2                	cmp    %eax,%edx
  80073f:	76 17                	jbe    800758 <_main+0x720>
  800741:	83 ec 04             	sub    $0x4,%esp
  800744:	68 6c 35 80 00       	push   $0x80356c
  800749:	68 88 00 00 00       	push   $0x88
  80074e:	68 4b 35 80 00       	push   $0x80354b
  800753:	e8 57 11 00 00       	call   8018af <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  800758:	e8 e8 26 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  80075d:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800760:	83 f8 02             	cmp    $0x2,%eax
  800763:	74 17                	je     80077c <_main+0x744>
  800765:	83 ec 04             	sub    $0x4,%esp
  800768:	68 d4 35 80 00       	push   $0x8035d4
  80076d:	68 89 00 00 00       	push   $0x89
  800772:	68 4b 35 80 00       	push   $0x80354b
  800777:	e8 33 11 00 00       	call   8018af <_panic>
		freeFrames = sys_calculate_free_frames() ;
  80077c:	e8 41 26 00 00       	call   802dc2 <sys_calculate_free_frames>
  800781:	89 45 bc             	mov    %eax,-0x44(%ebp)
		structArr = (struct MyStruct *) ptr_allocations[4];
  800784:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  80078a:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
  800790:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800793:	89 d0                	mov    %edx,%eax
  800795:	01 c0                	add    %eax,%eax
  800797:	01 d0                	add    %edx,%eax
  800799:	01 c0                	add    %eax,%eax
  80079b:	01 d0                	add    %edx,%eax
  80079d:	c1 e8 03             	shr    $0x3,%eax
  8007a0:	48                   	dec    %eax
  8007a1:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
  8007a7:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8007ad:	8a 55 db             	mov    -0x25(%ebp),%dl
  8007b0:	88 10                	mov    %dl,(%eax)
  8007b2:	8b 95 70 ff ff ff    	mov    -0x90(%ebp),%edx
  8007b8:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8007bb:	66 89 42 02          	mov    %ax,0x2(%edx)
  8007bf:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8007c5:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8007c8:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
  8007cb:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  8007d1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8007d8:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8007de:	01 c2                	add    %eax,%edx
  8007e0:	8a 45 da             	mov    -0x26(%ebp),%al
  8007e3:	88 02                	mov    %al,(%edx)
  8007e5:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  8007eb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8007f2:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8007f8:	01 c2                	add    %eax,%edx
  8007fa:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  8007fe:	66 89 42 02          	mov    %ax,0x2(%edx)
  800802:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800808:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80080f:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800815:	01 c2                	add    %eax,%edx
  800817:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80081a:	89 42 04             	mov    %eax,0x4(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  80081d:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  800820:	e8 9d 25 00 00       	call   802dc2 <sys_calculate_free_frames>
  800825:	29 c3                	sub    %eax,%ebx
  800827:	89 d8                	mov    %ebx,%eax
  800829:	83 f8 02             	cmp    $0x2,%eax
  80082c:	74 17                	je     800845 <_main+0x80d>
  80082e:	83 ec 04             	sub    $0x4,%esp
  800831:	68 10 36 80 00       	push   $0x803610
  800836:	68 8f 00 00 00       	push   $0x8f
  80083b:	68 4b 35 80 00       	push   $0x80354b
  800840:	e8 6a 10 00 00       	call   8018af <_panic>
		found = 0;
  800845:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  80084c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800853:	e9 9e 00 00 00       	jmp    8008f6 <_main+0x8be>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
  800858:	a1 20 40 80 00       	mov    0x804020,%eax
  80085d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800863:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800866:	c1 e2 04             	shl    $0x4,%edx
  800869:	01 d0                	add    %edx,%eax
  80086b:	8b 00                	mov    (%eax),%eax
  80086d:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  800873:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800879:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80087e:	89 c2                	mov    %eax,%edx
  800880:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800886:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  80088c:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  800892:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800897:	39 c2                	cmp    %eax,%edx
  800899:	75 03                	jne    80089e <_main+0x866>
				found++;
  80089b:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
  80089e:	a1 20 40 80 00       	mov    0x804020,%eax
  8008a3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8008a9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8008ac:	c1 e2 04             	shl    $0x4,%edx
  8008af:	01 d0                	add    %edx,%eax
  8008b1:	8b 00                	mov    (%eax),%eax
  8008b3:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  8008b9:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  8008bf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8008c4:	89 c2                	mov    %eax,%edx
  8008c6:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  8008cc:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8008d3:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8008d9:	01 c8                	add    %ecx,%eax
  8008db:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  8008e1:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  8008e7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8008ec:	39 c2                	cmp    %eax,%edx
  8008ee:	75 03                	jne    8008f3 <_main+0x8bb>
				found++;
  8008f0:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8008f3:	ff 45 ec             	incl   -0x14(%ebp)
  8008f6:	a1 20 40 80 00       	mov    0x804020,%eax
  8008fb:	8b 50 74             	mov    0x74(%eax),%edx
  8008fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800901:	39 c2                	cmp    %eax,%edx
  800903:	0f 87 4f ff ff ff    	ja     800858 <_main+0x820>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800909:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  80090d:	74 17                	je     800926 <_main+0x8ee>
  80090f:	83 ec 04             	sub    $0x4,%esp
  800912:	68 60 36 80 00       	push   $0x803660
  800917:	68 98 00 00 00       	push   $0x98
  80091c:	68 4b 35 80 00       	push   $0x80354b
  800921:	e8 89 0f 00 00       	call   8018af <_panic>
		cprintf("malloc 5\n");
  800926:	83 ec 0c             	sub    $0xc,%esp
  800929:	68 ba 36 80 00       	push   $0x8036ba
  80092e:	e8 1e 12 00 00       	call   801b51 <cprintf>
  800933:	83 c4 10             	add    $0x10,%esp
		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  800936:	e8 87 24 00 00       	call   802dc2 <sys_calculate_free_frames>
  80093b:	89 45 bc             	mov    %eax,-0x44(%ebp)
		cprintf("1\n");
  80093e:	83 ec 0c             	sub    $0xc,%esp
  800941:	68 c4 36 80 00       	push   $0x8036c4
  800946:	e8 06 12 00 00       	call   801b51 <cprintf>
  80094b:	83 c4 10             	add    $0x10,%esp
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80094e:	e8 f2 24 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  800953:	89 45 c0             	mov    %eax,-0x40(%ebp)
		cprintf("2\n");
  800956:	83 ec 0c             	sub    $0xc,%esp
  800959:	68 c7 36 80 00       	push   $0x8036c7
  80095e:	e8 ee 11 00 00       	call   801b51 <cprintf>
  800963:	83 c4 10             	add    $0x10,%esp
		ptr_allocations[5] = malloc(3*Mega-kilo);
  800966:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800969:	89 c2                	mov    %eax,%edx
  80096b:	01 d2                	add    %edx,%edx
  80096d:	01 d0                	add    %edx,%eax
  80096f:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800972:	83 ec 0c             	sub    $0xc,%esp
  800975:	50                   	push   %eax
  800976:	e8 60 1f 00 00       	call   8028db <malloc>
  80097b:	83 c4 10             	add    $0x10,%esp
  80097e:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)
		cprintf("3\n");
  800984:	83 ec 0c             	sub    $0xc,%esp
  800987:	68 ca 36 80 00       	push   $0x8036ca
  80098c:	e8 c0 11 00 00       	call   801b51 <cprintf>
  800991:	83 c4 10             	add    $0x10,%esp
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START+ 4*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800994:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  80099a:	89 c2                	mov    %eax,%edx
  80099c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80099f:	c1 e0 02             	shl    $0x2,%eax
  8009a2:	89 c1                	mov    %eax,%ecx
  8009a4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009a7:	c1 e0 04             	shl    $0x4,%eax
  8009aa:	01 c8                	add    %ecx,%eax
  8009ac:	05 00 00 00 80       	add    $0x80000000,%eax
  8009b1:	39 c2                	cmp    %eax,%edx
  8009b3:	72 21                	jb     8009d6 <_main+0x99e>
  8009b5:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  8009bb:	89 c2                	mov    %eax,%edx
  8009bd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009c0:	c1 e0 02             	shl    $0x2,%eax
  8009c3:	89 c1                	mov    %eax,%ecx
  8009c5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009c8:	c1 e0 04             	shl    $0x4,%eax
  8009cb:	01 c8                	add    %ecx,%eax
  8009cd:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8009d2:	39 c2                	cmp    %eax,%edx
  8009d4:	76 17                	jbe    8009ed <_main+0x9b5>
  8009d6:	83 ec 04             	sub    $0x4,%esp
  8009d9:	68 6c 35 80 00       	push   $0x80356c
  8009de:	68 a1 00 00 00       	push   $0xa1
  8009e3:	68 4b 35 80 00       	push   $0x80354b
  8009e8:	e8 c2 0e 00 00       	call   8018af <_panic>
		cprintf("4\n");
  8009ed:	83 ec 0c             	sub    $0xc,%esp
  8009f0:	68 cd 36 80 00       	push   $0x8036cd
  8009f5:	e8 57 11 00 00       	call   801b51 <cprintf>
  8009fa:	83 c4 10             	add    $0x10,%esp
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  8009fd:	e8 43 24 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  800a02:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800a05:	89 c2                	mov    %eax,%edx
  800a07:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a0a:	89 c1                	mov    %eax,%ecx
  800a0c:	01 c9                	add    %ecx,%ecx
  800a0e:	01 c8                	add    %ecx,%eax
  800a10:	85 c0                	test   %eax,%eax
  800a12:	79 05                	jns    800a19 <_main+0x9e1>
  800a14:	05 ff 0f 00 00       	add    $0xfff,%eax
  800a19:	c1 f8 0c             	sar    $0xc,%eax
  800a1c:	39 c2                	cmp    %eax,%edx
  800a1e:	74 17                	je     800a37 <_main+0x9ff>
  800a20:	83 ec 04             	sub    $0x4,%esp
  800a23:	68 d4 35 80 00       	push   $0x8035d4
  800a28:	68 a3 00 00 00       	push   $0xa3
  800a2d:	68 4b 35 80 00       	push   $0x80354b
  800a32:	e8 78 0e 00 00       	call   8018af <_panic>
		cprintf("5\n");
  800a37:	83 ec 0c             	sub    $0xc,%esp
  800a3a:	68 d0 36 80 00       	push   $0x8036d0
  800a3f:	e8 0d 11 00 00       	call   801b51 <cprintf>
  800a44:	83 c4 10             	add    $0x10,%esp
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
		byteArr3 = (char*)ptr_allocations[5];
  800a47:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  800a4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		cprintf("shashbs %d\n",toAccess);
  800a50:	83 ec 08             	sub    $0x8,%esp
  800a53:	ff 75 c4             	pushl  -0x3c(%ebp)
  800a56:	68 d3 36 80 00       	push   $0x8036d3
  800a5b:	e8 f1 10 00 00       	call   801b51 <cprintf>
  800a60:	83 c4 10             	add    $0x10,%esp
		for(int i = 0; i < toAccess; i++)
  800a63:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800a6a:	eb 23                	jmp    800a8f <_main+0xa57>
		{
			*byteArr3 = '@';
  800a6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a6f:	c6 00 40             	movb   $0x40,(%eax)
			byteArr3 += PAGE_SIZE;
  800a72:	81 45 f0 00 10 00 00 	addl   $0x1000,-0x10(%ebp)
			cprintf("%d\n",i);
  800a79:	83 ec 08             	sub    $0x8,%esp
  800a7c:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a7f:	68 df 36 80 00       	push   $0x8036df
  800a84:	e8 c8 10 00 00       	call   801b51 <cprintf>
  800a89:	83 c4 10             	add    $0x10,%esp
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
		cprintf("5\n");
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
		byteArr3 = (char*)ptr_allocations[5];
		cprintf("shashbs %d\n",toAccess);
		for(int i = 0; i < toAccess; i++)
  800a8c:	ff 45 e4             	incl   -0x1c(%ebp)
  800a8f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800a92:	3b 45 c4             	cmp    -0x3c(%ebp),%eax
  800a95:	7c d5                	jl     800a6c <_main+0xa34>
		{
			*byteArr3 = '@';
			byteArr3 += PAGE_SIZE;
			cprintf("%d\n",i);
		}
		cprintf("malloc 6\n");
  800a97:	83 ec 0c             	sub    $0xc,%esp
  800a9a:	68 e3 36 80 00       	push   $0x8036e3
  800a9f:	e8 ad 10 00 00       	call   801b51 <cprintf>
  800aa4:	83 c4 10             	add    $0x10,%esp
		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800aa7:	e8 99 23 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  800aac:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[6] = malloc(6*Mega-kilo);
  800aaf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ab2:	89 d0                	mov    %edx,%eax
  800ab4:	01 c0                	add    %eax,%eax
  800ab6:	01 d0                	add    %edx,%eax
  800ab8:	01 c0                	add    %eax,%eax
  800aba:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800abd:	83 ec 0c             	sub    $0xc,%esp
  800ac0:	50                   	push   %eax
  800ac1:	e8 15 1e 00 00       	call   8028db <malloc>
  800ac6:	83 c4 10             	add    $0x10,%esp
  800ac9:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START+ 7*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800acf:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  800ad5:	89 c1                	mov    %eax,%ecx
  800ad7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ada:	89 d0                	mov    %edx,%eax
  800adc:	01 c0                	add    %eax,%eax
  800ade:	01 d0                	add    %edx,%eax
  800ae0:	01 c0                	add    %eax,%eax
  800ae2:	01 d0                	add    %edx,%eax
  800ae4:	89 c2                	mov    %eax,%edx
  800ae6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800ae9:	c1 e0 04             	shl    $0x4,%eax
  800aec:	01 d0                	add    %edx,%eax
  800aee:	05 00 00 00 80       	add    $0x80000000,%eax
  800af3:	39 c1                	cmp    %eax,%ecx
  800af5:	72 28                	jb     800b1f <_main+0xae7>
  800af7:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  800afd:	89 c1                	mov    %eax,%ecx
  800aff:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b02:	89 d0                	mov    %edx,%eax
  800b04:	01 c0                	add    %eax,%eax
  800b06:	01 d0                	add    %edx,%eax
  800b08:	01 c0                	add    %eax,%eax
  800b0a:	01 d0                	add    %edx,%eax
  800b0c:	89 c2                	mov    %eax,%edx
  800b0e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800b11:	c1 e0 04             	shl    $0x4,%eax
  800b14:	01 d0                	add    %edx,%eax
  800b16:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800b1b:	39 c1                	cmp    %eax,%ecx
  800b1d:	76 17                	jbe    800b36 <_main+0xafe>
  800b1f:	83 ec 04             	sub    $0x4,%esp
  800b22:	68 6c 35 80 00       	push   $0x80356c
  800b27:	68 b2 00 00 00       	push   $0xb2
  800b2c:	68 4b 35 80 00       	push   $0x80354b
  800b31:	e8 79 0d 00 00       	call   8018af <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800b36:	e8 0a 23 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  800b3b:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800b3e:	89 c1                	mov    %eax,%ecx
  800b40:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b43:	89 d0                	mov    %edx,%eax
  800b45:	01 c0                	add    %eax,%eax
  800b47:	01 d0                	add    %edx,%eax
  800b49:	01 c0                	add    %eax,%eax
  800b4b:	85 c0                	test   %eax,%eax
  800b4d:	79 05                	jns    800b54 <_main+0xb1c>
  800b4f:	05 ff 0f 00 00       	add    $0xfff,%eax
  800b54:	c1 f8 0c             	sar    $0xc,%eax
  800b57:	39 c1                	cmp    %eax,%ecx
  800b59:	74 17                	je     800b72 <_main+0xb3a>
  800b5b:	83 ec 04             	sub    $0x4,%esp
  800b5e:	68 d4 35 80 00       	push   $0x8035d4
  800b63:	68 b3 00 00 00       	push   $0xb3
  800b68:	68 4b 35 80 00       	push   $0x80354b
  800b6d:	e8 3d 0d 00 00       	call   8018af <_panic>
		freeFrames = sys_calculate_free_frames() ;
  800b72:	e8 4b 22 00 00       	call   802dc2 <sys_calculate_free_frames>
  800b77:	89 45 bc             	mov    %eax,-0x44(%ebp)
		lastIndexOfByte2 = (6*Mega-kilo)/sizeof(char) - 1;
  800b7a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b7d:	89 d0                	mov    %edx,%eax
  800b7f:	01 c0                	add    %eax,%eax
  800b81:	01 d0                	add    %edx,%eax
  800b83:	01 c0                	add    %eax,%eax
  800b85:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800b88:	48                   	dec    %eax
  800b89:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
		byteArr2 = (char *) ptr_allocations[6];
  800b8f:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  800b95:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
		byteArr2[0] = minByte ;
  800b9b:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800ba1:	8a 55 db             	mov    -0x25(%ebp),%dl
  800ba4:	88 10                	mov    %dl,(%eax)
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
  800ba6:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800bac:	89 c2                	mov    %eax,%edx
  800bae:	c1 ea 1f             	shr    $0x1f,%edx
  800bb1:	01 d0                	add    %edx,%eax
  800bb3:	d1 f8                	sar    %eax
  800bb5:	89 c2                	mov    %eax,%edx
  800bb7:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800bbd:	01 c2                	add    %eax,%edx
  800bbf:	8a 45 da             	mov    -0x26(%ebp),%al
  800bc2:	88 c1                	mov    %al,%cl
  800bc4:	c0 e9 07             	shr    $0x7,%cl
  800bc7:	01 c8                	add    %ecx,%eax
  800bc9:	d0 f8                	sar    %al
  800bcb:	88 02                	mov    %al,(%edx)
		byteArr2[lastIndexOfByte2] = maxByte ;
  800bcd:	8b 95 58 ff ff ff    	mov    -0xa8(%ebp),%edx
  800bd3:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800bd9:	01 c2                	add    %eax,%edx
  800bdb:	8a 45 da             	mov    -0x26(%ebp),%al
  800bde:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800be0:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  800be3:	e8 da 21 00 00       	call   802dc2 <sys_calculate_free_frames>
  800be8:	29 c3                	sub    %eax,%ebx
  800bea:	89 d8                	mov    %ebx,%eax
  800bec:	83 f8 05             	cmp    $0x5,%eax
  800bef:	74 17                	je     800c08 <_main+0xbd0>
  800bf1:	83 ec 04             	sub    $0x4,%esp
  800bf4:	68 10 36 80 00       	push   $0x803610
  800bf9:	68 ba 00 00 00       	push   $0xba
  800bfe:	68 4b 35 80 00       	push   $0x80354b
  800c03:	e8 a7 0c 00 00       	call   8018af <_panic>
		found = 0;
  800c08:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800c0f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800c16:	e9 f0 00 00 00       	jmp    800d0b <_main+0xcd3>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  800c1b:	a1 20 40 80 00       	mov    0x804020,%eax
  800c20:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800c26:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800c29:	c1 e2 04             	shl    $0x4,%edx
  800c2c:	01 d0                	add    %edx,%eax
  800c2e:	8b 00                	mov    (%eax),%eax
  800c30:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  800c36:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800c3c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800c41:	89 c2                	mov    %eax,%edx
  800c43:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800c49:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  800c4f:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800c55:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800c5a:	39 c2                	cmp    %eax,%edx
  800c5c:	75 03                	jne    800c61 <_main+0xc29>
				found++;
  800c5e:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  800c61:	a1 20 40 80 00       	mov    0x804020,%eax
  800c66:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800c6c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800c6f:	c1 e2 04             	shl    $0x4,%edx
  800c72:	01 d0                	add    %edx,%eax
  800c74:	8b 00                	mov    (%eax),%eax
  800c76:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
  800c7c:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800c82:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800c87:	89 c2                	mov    %eax,%edx
  800c89:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800c8f:	89 c1                	mov    %eax,%ecx
  800c91:	c1 e9 1f             	shr    $0x1f,%ecx
  800c94:	01 c8                	add    %ecx,%eax
  800c96:	d1 f8                	sar    %eax
  800c98:	89 c1                	mov    %eax,%ecx
  800c9a:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800ca0:	01 c8                	add    %ecx,%eax
  800ca2:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  800ca8:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800cae:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800cb3:	39 c2                	cmp    %eax,%edx
  800cb5:	75 03                	jne    800cba <_main+0xc82>
				found++;
  800cb7:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  800cba:	a1 20 40 80 00       	mov    0x804020,%eax
  800cbf:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800cc5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800cc8:	c1 e2 04             	shl    $0x4,%edx
  800ccb:	01 d0                	add    %edx,%eax
  800ccd:	8b 00                	mov    (%eax),%eax
  800ccf:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
  800cd5:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800cdb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ce0:	89 c1                	mov    %eax,%ecx
  800ce2:	8b 95 58 ff ff ff    	mov    -0xa8(%ebp),%edx
  800ce8:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800cee:	01 d0                	add    %edx,%eax
  800cf0:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)
  800cf6:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800cfc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d01:	39 c1                	cmp    %eax,%ecx
  800d03:	75 03                	jne    800d08 <_main+0xcd0>
				found++;
  800d05:	ff 45 e8             	incl   -0x18(%ebp)
		byteArr2[0] = minByte ;
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
		byteArr2[lastIndexOfByte2] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800d08:	ff 45 ec             	incl   -0x14(%ebp)
  800d0b:	a1 20 40 80 00       	mov    0x804020,%eax
  800d10:	8b 50 74             	mov    0x74(%eax),%edx
  800d13:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d16:	39 c2                	cmp    %eax,%edx
  800d18:	0f 87 fd fe ff ff    	ja     800c1b <_main+0xbe3>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				found++;
		}
		if (found != 3) panic("malloc: page is not added to WS");
  800d1e:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  800d22:	74 17                	je     800d3b <_main+0xd03>
  800d24:	83 ec 04             	sub    $0x4,%esp
  800d27:	68 60 36 80 00       	push   $0x803660
  800d2c:	68 c5 00 00 00       	push   $0xc5
  800d31:	68 4b 35 80 00       	push   $0x80354b
  800d36:	e8 74 0b 00 00       	call   8018af <_panic>
		cprintf("malloc 7\n");
  800d3b:	83 ec 0c             	sub    $0xc,%esp
  800d3e:	68 ed 36 80 00       	push   $0x8036ed
  800d43:	e8 09 0e 00 00       	call   801b51 <cprintf>
  800d48:	83 c4 10             	add    $0x10,%esp
		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800d4b:	e8 f5 20 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  800d50:	89 45 c0             	mov    %eax,-0x40(%ebp)
		ptr_allocations[7] = malloc(14*kilo);
  800d53:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800d56:	89 d0                	mov    %edx,%eax
  800d58:	01 c0                	add    %eax,%eax
  800d5a:	01 d0                	add    %edx,%eax
  800d5c:	01 c0                	add    %eax,%eax
  800d5e:	01 d0                	add    %edx,%eax
  800d60:	01 c0                	add    %eax,%eax
  800d62:	83 ec 0c             	sub    $0xc,%esp
  800d65:	50                   	push   %eax
  800d66:	e8 70 1b 00 00       	call   8028db <malloc>
  800d6b:	83 c4 10             	add    $0x10,%esp
  800d6e:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
		if ((uint32) ptr_allocations[7] < (USER_HEAP_START + 13*Mega + 16*kilo)|| (uint32) ptr_allocations[7] > (USER_HEAP_START+ 13*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800d74:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800d7a:	89 c1                	mov    %eax,%ecx
  800d7c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d7f:	89 d0                	mov    %edx,%eax
  800d81:	01 c0                	add    %eax,%eax
  800d83:	01 d0                	add    %edx,%eax
  800d85:	c1 e0 02             	shl    $0x2,%eax
  800d88:	01 d0                	add    %edx,%eax
  800d8a:	89 c2                	mov    %eax,%edx
  800d8c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800d8f:	c1 e0 04             	shl    $0x4,%eax
  800d92:	01 d0                	add    %edx,%eax
  800d94:	05 00 00 00 80       	add    $0x80000000,%eax
  800d99:	39 c1                	cmp    %eax,%ecx
  800d9b:	72 29                	jb     800dc6 <_main+0xd8e>
  800d9d:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800da3:	89 c1                	mov    %eax,%ecx
  800da5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800da8:	89 d0                	mov    %edx,%eax
  800daa:	01 c0                	add    %eax,%eax
  800dac:	01 d0                	add    %edx,%eax
  800dae:	c1 e0 02             	shl    $0x2,%eax
  800db1:	01 d0                	add    %edx,%eax
  800db3:	89 c2                	mov    %eax,%edx
  800db5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800db8:	c1 e0 04             	shl    $0x4,%eax
  800dbb:	01 d0                	add    %edx,%eax
  800dbd:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800dc2:	39 c1                	cmp    %eax,%ecx
  800dc4:	76 17                	jbe    800ddd <_main+0xda5>
  800dc6:	83 ec 04             	sub    $0x4,%esp
  800dc9:	68 6c 35 80 00       	push   $0x80356c
  800dce:	68 ca 00 00 00       	push   $0xca
  800dd3:	68 4b 35 80 00       	push   $0x80354b
  800dd8:	e8 d2 0a 00 00       	call   8018af <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4) panic("Extra or less pages are allocated in PageFile");
  800ddd:	e8 63 20 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  800de2:	2b 45 c0             	sub    -0x40(%ebp),%eax
  800de5:	83 f8 04             	cmp    $0x4,%eax
  800de8:	74 17                	je     800e01 <_main+0xdc9>
  800dea:	83 ec 04             	sub    $0x4,%esp
  800ded:	68 d4 35 80 00       	push   $0x8035d4
  800df2:	68 cb 00 00 00       	push   $0xcb
  800df7:	68 4b 35 80 00       	push   $0x80354b
  800dfc:	e8 ae 0a 00 00       	call   8018af <_panic>
		freeFrames = sys_calculate_free_frames() ;
  800e01:	e8 bc 1f 00 00       	call   802dc2 <sys_calculate_free_frames>
  800e06:	89 45 bc             	mov    %eax,-0x44(%ebp)
		shortArr2 = (short *) ptr_allocations[7];
  800e09:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800e0f:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
  800e15:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800e18:	89 d0                	mov    %edx,%eax
  800e1a:	01 c0                	add    %eax,%eax
  800e1c:	01 d0                	add    %edx,%eax
  800e1e:	01 c0                	add    %eax,%eax
  800e20:	01 d0                	add    %edx,%eax
  800e22:	01 c0                	add    %eax,%eax
  800e24:	d1 e8                	shr    %eax
  800e26:	48                   	dec    %eax
  800e27:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
		shortArr2[0] = minShort;
  800e2d:	8b 95 38 ff ff ff    	mov    -0xc8(%ebp),%edx
  800e33:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800e36:	66 89 02             	mov    %ax,(%edx)
		shortArr2[lastIndexOfShort2] = maxShort;
  800e39:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800e3f:	01 c0                	add    %eax,%eax
  800e41:	89 c2                	mov    %eax,%edx
  800e43:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800e49:	01 c2                	add    %eax,%edx
  800e4b:	66 8b 45 d6          	mov    -0x2a(%ebp),%ax
  800e4f:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800e52:	8b 5d bc             	mov    -0x44(%ebp),%ebx
  800e55:	e8 68 1f 00 00       	call   802dc2 <sys_calculate_free_frames>
  800e5a:	29 c3                	sub    %eax,%ebx
  800e5c:	89 d8                	mov    %ebx,%eax
  800e5e:	83 f8 02             	cmp    $0x2,%eax
  800e61:	74 17                	je     800e7a <_main+0xe42>
  800e63:	83 ec 04             	sub    $0x4,%esp
  800e66:	68 10 36 80 00       	push   $0x803610
  800e6b:	68 d1 00 00 00       	push   $0xd1
  800e70:	68 4b 35 80 00       	push   $0x80354b
  800e75:	e8 35 0a 00 00       	call   8018af <_panic>
		found = 0;
  800e7a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800e81:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800e88:	e9 9b 00 00 00       	jmp    800f28 <_main+0xef0>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
  800e8d:	a1 20 40 80 00       	mov    0x804020,%eax
  800e92:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800e98:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e9b:	c1 e2 04             	shl    $0x4,%edx
  800e9e:	01 d0                	add    %edx,%eax
  800ea0:	8b 00                	mov    (%eax),%eax
  800ea2:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
  800ea8:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  800eae:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800eb3:	89 c2                	mov    %eax,%edx
  800eb5:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800ebb:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
  800ec1:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  800ec7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ecc:	39 c2                	cmp    %eax,%edx
  800ece:	75 03                	jne    800ed3 <_main+0xe9b>
				found++;
  800ed0:	ff 45 e8             	incl   -0x18(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
  800ed3:	a1 20 40 80 00       	mov    0x804020,%eax
  800ed8:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800ede:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ee1:	c1 e2 04             	shl    $0x4,%edx
  800ee4:	01 d0                	add    %edx,%eax
  800ee6:	8b 00                	mov    (%eax),%eax
  800ee8:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
  800eee:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
  800ef4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ef9:	89 c2                	mov    %eax,%edx
  800efb:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800f01:	01 c0                	add    %eax,%eax
  800f03:	89 c1                	mov    %eax,%ecx
  800f05:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800f0b:	01 c8                	add    %ecx,%eax
  800f0d:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
  800f13:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  800f19:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f1e:	39 c2                	cmp    %eax,%edx
  800f20:	75 03                	jne    800f25 <_main+0xeed>
				found++;
  800f22:	ff 45 e8             	incl   -0x18(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
		shortArr2[0] = minShort;
		shortArr2[lastIndexOfShort2] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800f25:	ff 45 ec             	incl   -0x14(%ebp)
  800f28:	a1 20 40 80 00       	mov    0x804020,%eax
  800f2d:	8b 50 74             	mov    0x74(%eax),%edx
  800f30:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f33:	39 c2                	cmp    %eax,%edx
  800f35:	0f 87 52 ff ff ff    	ja     800e8d <_main+0xe55>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800f3b:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
  800f3f:	74 17                	je     800f58 <_main+0xf20>
  800f41:	83 ec 04             	sub    $0x4,%esp
  800f44:	68 60 36 80 00       	push   $0x803660
  800f49:	68 da 00 00 00       	push   $0xda
  800f4e:	68 4b 35 80 00       	push   $0x80354b
  800f53:	e8 57 09 00 00       	call   8018af <_panic>
	}

	{
		uint32 tmp_addresses[3] = {0};
  800f58:	8d 95 bc fe ff ff    	lea    -0x144(%ebp),%edx
  800f5e:	b9 03 00 00 00       	mov    $0x3,%ecx
  800f63:	b8 00 00 00 00       	mov    $0x0,%eax
  800f68:	89 d7                	mov    %edx,%edi
  800f6a:	f3 ab                	rep stos %eax,%es:(%edi)
		cprintf("malloc 8\n");
  800f6c:	83 ec 0c             	sub    $0xc,%esp
  800f6f:	68 f7 36 80 00       	push   $0x8036f7
  800f74:	e8 d8 0b 00 00       	call   801b51 <cprintf>
  800f79:	83 c4 10             	add    $0x10,%esp
		//Free 6 MB
		int freeFrames = sys_calculate_free_frames() ;
  800f7c:	e8 41 1e 00 00       	call   802dc2 <sys_calculate_free_frames>
  800f81:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800f87:	e8 b9 1e 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  800f8c:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[6]);
  800f92:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  800f98:	83 ec 0c             	sub    $0xc,%esp
  800f9b:	50                   	push   %eax
  800f9c:	e8 4a 1b 00 00       	call   802aeb <free>
  800fa1:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 6*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
  800fa4:	e8 9c 1e 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  800fa9:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  800faf:	89 d1                	mov    %edx,%ecx
  800fb1:	29 c1                	sub    %eax,%ecx
  800fb3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800fb6:	89 d0                	mov    %edx,%eax
  800fb8:	01 c0                	add    %eax,%eax
  800fba:	01 d0                	add    %edx,%eax
  800fbc:	01 c0                	add    %eax,%eax
  800fbe:	85 c0                	test   %eax,%eax
  800fc0:	79 05                	jns    800fc7 <_main+0xf8f>
  800fc2:	05 ff 0f 00 00       	add    $0xfff,%eax
  800fc7:	c1 f8 0c             	sar    $0xc,%eax
  800fca:	39 c1                	cmp    %eax,%ecx
  800fcc:	74 17                	je     800fe5 <_main+0xfad>
  800fce:	83 ec 04             	sub    $0x4,%esp
  800fd1:	68 04 37 80 00       	push   $0x803704
  800fd6:	68 e4 00 00 00       	push   $0xe4
  800fdb:	68 4b 35 80 00       	push   $0x80354b
  800fe0:	e8 ca 08 00 00       	call   8018af <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  800fe5:	e8 d8 1d 00 00       	call   802dc2 <sys_calculate_free_frames>
  800fea:	89 c2                	mov    %eax,%edx
  800fec:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  800ff2:	29 c2                	sub    %eax,%edx
  800ff4:	89 d0                	mov    %edx,%eax
  800ff6:	83 f8 04             	cmp    $0x4,%eax
  800ff9:	74 17                	je     801012 <_main+0xfda>
  800ffb:	83 ec 04             	sub    $0x4,%esp
  800ffe:	68 40 37 80 00       	push   $0x803740
  801003:	68 e5 00 00 00       	push   $0xe5
  801008:	68 4b 35 80 00       	push   $0x80354b
  80100d:	e8 9d 08 00 00       	call   8018af <_panic>
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}
		tmp_addresses[0] = (uint32)(&(byteArr2[0]));
  801012:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  801018:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(byteArr2[lastIndexOfByte2/2]));
  80101e:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  801024:	89 c2                	mov    %eax,%edx
  801026:	c1 ea 1f             	shr    $0x1f,%edx
  801029:	01 d0                	add    %edx,%eax
  80102b:	d1 f8                	sar    %eax
  80102d:	89 c2                	mov    %eax,%edx
  80102f:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  801035:	01 d0                	add    %edx,%eax
  801037:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		tmp_addresses[2] = (uint32)(&(byteArr2[lastIndexOfByte2]));
  80103d:	8b 95 58 ff ff ff    	mov    -0xa8(%ebp),%edx
  801043:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  801049:	01 d0                	add    %edx,%eax
  80104b:	89 85 c4 fe ff ff    	mov    %eax,-0x13c(%ebp)
		int check = sys_check_LRU_lists_free(tmp_addresses, 3);
  801051:	83 ec 08             	sub    $0x8,%esp
  801054:	6a 03                	push   $0x3
  801056:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  80105c:	50                   	push   %eax
  80105d:	e8 34 22 00 00       	call   803296 <sys_check_LRU_lists_free>
  801062:	83 c4 10             	add    $0x10,%esp
  801065:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  80106b:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  801072:	74 17                	je     80108b <_main+0x1053>
		{
				panic("free: page is not removed from LRU lists");
  801074:	83 ec 04             	sub    $0x4,%esp
  801077:	68 8c 37 80 00       	push   $0x80378c
  80107c:	68 f5 00 00 00       	push   $0xf5
  801081:	68 4b 35 80 00       	push   $0x80354b
  801086:	e8 24 08 00 00       	call   8018af <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 800 && LIST_SIZE(&myEnv->SecondList) != 1)
  80108b:	a1 20 40 80 00       	mov    0x804020,%eax
  801090:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  801096:	3d 20 03 00 00       	cmp    $0x320,%eax
  80109b:	74 27                	je     8010c4 <_main+0x108c>
  80109d:	a1 20 40 80 00       	mov    0x804020,%eax
  8010a2:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  8010a8:	83 f8 01             	cmp    $0x1,%eax
  8010ab:	74 17                	je     8010c4 <_main+0x108c>
		{
			panic("LRU lists content is not correct");
  8010ad:	83 ec 04             	sub    $0x4,%esp
  8010b0:	68 b8 37 80 00       	push   $0x8037b8
  8010b5:	68 fa 00 00 00       	push   $0xfa
  8010ba:	68 4b 35 80 00       	push   $0x80354b
  8010bf:	e8 eb 07 00 00       	call   8018af <_panic>
		}

		//Free 1st 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8010c4:	e8 f9 1c 00 00       	call   802dc2 <sys_calculate_free_frames>
  8010c9:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8010cf:	e8 71 1d 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  8010d4:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[0]);
  8010da:	8b 85 c8 fe ff ff    	mov    -0x138(%ebp),%eax
  8010e0:	83 ec 0c             	sub    $0xc,%esp
  8010e3:	50                   	push   %eax
  8010e4:	e8 02 1a 00 00       	call   802aeb <free>
  8010e9:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  8010ec:	e8 54 1d 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  8010f1:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  8010f7:	29 c2                	sub    %eax,%edx
  8010f9:	89 d0                	mov    %edx,%eax
  8010fb:	3d 00 02 00 00       	cmp    $0x200,%eax
  801100:	74 17                	je     801119 <_main+0x10e1>
  801102:	83 ec 04             	sub    $0x4,%esp
  801105:	68 04 37 80 00       	push   $0x803704
  80110a:	68 01 01 00 00       	push   $0x101
  80110f:	68 4b 35 80 00       	push   $0x80354b
  801114:	e8 96 07 00 00       	call   8018af <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 ) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801119:	e8 a4 1c 00 00       	call   802dc2 <sys_calculate_free_frames>
  80111e:	89 c2                	mov    %eax,%edx
  801120:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801126:	29 c2                	sub    %eax,%edx
  801128:	89 d0                	mov    %edx,%eax
  80112a:	83 f8 02             	cmp    $0x2,%eax
  80112d:	74 17                	je     801146 <_main+0x110e>
  80112f:	83 ec 04             	sub    $0x4,%esp
  801132:	68 40 37 80 00       	push   $0x803740
  801137:	68 02 01 00 00       	push   $0x102
  80113c:	68 4b 35 80 00       	push   $0x80354b
  801141:	e8 69 07 00 00       	call   8018af <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[lastIndexOfByte])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(byteArr[0]));
  801146:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801149:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(byteArr[lastIndexOfByte]));
  80114f:	8b 55 b8             	mov    -0x48(%ebp),%edx
  801152:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801155:	01 d0                	add    %edx,%eax
  801157:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  80115d:	83 ec 08             	sub    $0x8,%esp
  801160:	6a 02                	push   $0x2
  801162:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  801168:	50                   	push   %eax
  801169:	e8 28 21 00 00       	call   803296 <sys_check_LRU_lists_free>
  80116e:	83 c4 10             	add    $0x10,%esp
  801171:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  801177:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  80117e:	74 17                	je     801197 <_main+0x115f>
		{
				panic("free: page is not removed from LRU lists");
  801180:	83 ec 04             	sub    $0x4,%esp
  801183:	68 8c 37 80 00       	push   $0x80378c
  801188:	68 11 01 00 00       	push   $0x111
  80118d:	68 4b 35 80 00       	push   $0x80354b
  801192:	e8 18 07 00 00       	call   8018af <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 799 && LIST_SIZE(&myEnv->SecondList) != 0)
  801197:	a1 20 40 80 00       	mov    0x804020,%eax
  80119c:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  8011a2:	3d 1f 03 00 00       	cmp    $0x31f,%eax
  8011a7:	74 26                	je     8011cf <_main+0x1197>
  8011a9:	a1 20 40 80 00       	mov    0x804020,%eax
  8011ae:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  8011b4:	85 c0                	test   %eax,%eax
  8011b6:	74 17                	je     8011cf <_main+0x1197>
		{
			panic("LRU lists content is not correct");
  8011b8:	83 ec 04             	sub    $0x4,%esp
  8011bb:	68 b8 37 80 00       	push   $0x8037b8
  8011c0:	68 16 01 00 00       	push   $0x116
  8011c5:	68 4b 35 80 00       	push   $0x80354b
  8011ca:	e8 e0 06 00 00       	call   8018af <_panic>
		}

		//Free 2nd 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8011cf:	e8 ee 1b 00 00       	call   802dc2 <sys_calculate_free_frames>
  8011d4:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8011da:	e8 66 1c 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  8011df:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[1]);
  8011e5:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  8011eb:	83 ec 0c             	sub    $0xc,%esp
  8011ee:	50                   	push   %eax
  8011ef:	e8 f7 18 00 00       	call   802aeb <free>
  8011f4:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 512) panic("Wrong free: Extra or less pages are removed from PageFile");
  8011f7:	e8 49 1c 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  8011fc:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801202:	29 c2                	sub    %eax,%edx
  801204:	89 d0                	mov    %edx,%eax
  801206:	3d 00 02 00 00       	cmp    $0x200,%eax
  80120b:	74 17                	je     801224 <_main+0x11ec>
  80120d:	83 ec 04             	sub    $0x4,%esp
  801210:	68 04 37 80 00       	push   $0x803704
  801215:	68 1d 01 00 00       	push   $0x11d
  80121a:	68 4b 35 80 00       	push   $0x80354b
  80121f:	e8 8b 06 00 00       	call   8018af <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801224:	e8 99 1b 00 00       	call   802dc2 <sys_calculate_free_frames>
  801229:	89 c2                	mov    %eax,%edx
  80122b:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801231:	29 c2                	sub    %eax,%edx
  801233:	89 d0                	mov    %edx,%eax
  801235:	83 f8 03             	cmp    $0x3,%eax
  801238:	74 17                	je     801251 <_main+0x1219>
  80123a:	83 ec 04             	sub    $0x4,%esp
  80123d:	68 40 37 80 00       	push   $0x803740
  801242:	68 1e 01 00 00       	push   $0x11e
  801247:	68 4b 35 80 00       	push   $0x80354b
  80124c:	e8 5e 06 00 00       	call   8018af <_panic>
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}
		tmp_addresses[0] = (uint32)(&(shortArr[0]));
  801251:	8b 45 a0             	mov    -0x60(%ebp),%eax
  801254:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(shortArr[lastIndexOfShort]));
  80125a:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80125d:	01 c0                	add    %eax,%eax
  80125f:	89 c2                	mov    %eax,%edx
  801261:	8b 45 a0             	mov    -0x60(%ebp),%eax
  801264:	01 d0                	add    %edx,%eax
  801266:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  80126c:	83 ec 08             	sub    $0x8,%esp
  80126f:	6a 02                	push   $0x2
  801271:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  801277:	50                   	push   %eax
  801278:	e8 19 20 00 00       	call   803296 <sys_check_LRU_lists_free>
  80127d:	83 c4 10             	add    $0x10,%esp
  801280:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  801286:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  80128d:	74 17                	je     8012a6 <_main+0x126e>
		{
				panic("free: page is not removed from LRU lists");
  80128f:	83 ec 04             	sub    $0x4,%esp
  801292:	68 8c 37 80 00       	push   $0x80378c
  801297:	68 2b 01 00 00       	push   $0x12b
  80129c:	68 4b 35 80 00       	push   $0x80354b
  8012a1:	e8 09 06 00 00       	call   8018af <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 797 && LIST_SIZE(&myEnv->SecondList) != 0)
  8012a6:	a1 20 40 80 00       	mov    0x804020,%eax
  8012ab:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  8012b1:	3d 1d 03 00 00       	cmp    $0x31d,%eax
  8012b6:	74 26                	je     8012de <_main+0x12a6>
  8012b8:	a1 20 40 80 00       	mov    0x804020,%eax
  8012bd:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  8012c3:	85 c0                	test   %eax,%eax
  8012c5:	74 17                	je     8012de <_main+0x12a6>
		{
			panic("LRU lists content is not correct");
  8012c7:	83 ec 04             	sub    $0x4,%esp
  8012ca:	68 b8 37 80 00       	push   $0x8037b8
  8012cf:	68 30 01 00 00       	push   $0x130
  8012d4:	68 4b 35 80 00       	push   $0x80354b
  8012d9:	e8 d1 05 00 00       	call   8018af <_panic>
		}


		//Free 7 KB
		freeFrames = sys_calculate_free_frames() ;
  8012de:	e8 df 1a 00 00       	call   802dc2 <sys_calculate_free_frames>
  8012e3:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8012e9:	e8 57 1b 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  8012ee:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[4]);
  8012f4:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  8012fa:	83 ec 0c             	sub    $0xc,%esp
  8012fd:	50                   	push   %eax
  8012fe:	e8 e8 17 00 00       	call   802aeb <free>
  801303:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2) panic("Wrong free: Extra or less pages are removed from PageFile");
  801306:	e8 3a 1b 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  80130b:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801311:	29 c2                	sub    %eax,%edx
  801313:	89 d0                	mov    %edx,%eax
  801315:	83 f8 02             	cmp    $0x2,%eax
  801318:	74 17                	je     801331 <_main+0x12f9>
  80131a:	83 ec 04             	sub    $0x4,%esp
  80131d:	68 04 37 80 00       	push   $0x803704
  801322:	68 38 01 00 00       	push   $0x138
  801327:	68 4b 35 80 00       	push   $0x80354b
  80132c:	e8 7e 05 00 00       	call   8018af <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801331:	e8 8c 1a 00 00       	call   802dc2 <sys_calculate_free_frames>
  801336:	89 c2                	mov    %eax,%edx
  801338:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  80133e:	29 c2                	sub    %eax,%edx
  801340:	89 d0                	mov    %edx,%eax
  801342:	83 f8 02             	cmp    $0x2,%eax
  801345:	74 17                	je     80135e <_main+0x1326>
  801347:	83 ec 04             	sub    $0x4,%esp
  80134a:	68 40 37 80 00       	push   $0x803740
  80134f:	68 39 01 00 00       	push   $0x139
  801354:	68 4b 35 80 00       	push   $0x80354b
  801359:	e8 51 05 00 00       	call   8018af <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(structArr[lastIndexOfStruct])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(structArr[0]));
  80135e:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  801364:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(structArr[lastIndexOfStruct]));
  80136a:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  801370:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  801377:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  80137d:	01 d0                	add    %edx,%eax
  80137f:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  801385:	83 ec 08             	sub    $0x8,%esp
  801388:	6a 02                	push   $0x2
  80138a:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  801390:	50                   	push   %eax
  801391:	e8 00 1f 00 00       	call   803296 <sys_check_LRU_lists_free>
  801396:	83 c4 10             	add    $0x10,%esp
  801399:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  80139f:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  8013a6:	74 17                	je     8013bf <_main+0x1387>
		{
				panic("free: page is not removed from LRU lists");
  8013a8:	83 ec 04             	sub    $0x4,%esp
  8013ab:	68 8c 37 80 00       	push   $0x80378c
  8013b0:	68 47 01 00 00       	push   $0x147
  8013b5:	68 4b 35 80 00       	push   $0x80354b
  8013ba:	e8 f0 04 00 00       	call   8018af <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 795 && LIST_SIZE(&myEnv->SecondList) != 0)
  8013bf:	a1 20 40 80 00       	mov    0x804020,%eax
  8013c4:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  8013ca:	3d 1b 03 00 00       	cmp    $0x31b,%eax
  8013cf:	74 26                	je     8013f7 <_main+0x13bf>
  8013d1:	a1 20 40 80 00       	mov    0x804020,%eax
  8013d6:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  8013dc:	85 c0                	test   %eax,%eax
  8013de:	74 17                	je     8013f7 <_main+0x13bf>
		{
			panic("LRU lists content is not correct");
  8013e0:	83 ec 04             	sub    $0x4,%esp
  8013e3:	68 b8 37 80 00       	push   $0x8037b8
  8013e8:	68 4c 01 00 00       	push   $0x14c
  8013ed:	68 4b 35 80 00       	push   $0x80354b
  8013f2:	e8 b8 04 00 00       	call   8018af <_panic>
		}

		//Free 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8013f7:	e8 c6 19 00 00       	call   802dc2 <sys_calculate_free_frames>
  8013fc:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801402:	e8 3e 1a 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  801407:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[5]);
  80140d:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  801413:	83 ec 0c             	sub    $0xc,%esp
  801416:	50                   	push   %eax
  801417:	e8 cf 16 00 00       	call   802aeb <free>
  80141c:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/4096) panic("Wrong free: Extra or less pages are removed from PageFile");
  80141f:	e8 21 1a 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  801424:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  80142a:	89 d1                	mov    %edx,%ecx
  80142c:	29 c1                	sub    %eax,%ecx
  80142e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801431:	89 c2                	mov    %eax,%edx
  801433:	01 d2                	add    %edx,%edx
  801435:	01 d0                	add    %edx,%eax
  801437:	85 c0                	test   %eax,%eax
  801439:	79 05                	jns    801440 <_main+0x1408>
  80143b:	05 ff 0f 00 00       	add    $0xfff,%eax
  801440:	c1 f8 0c             	sar    $0xc,%eax
  801443:	39 c1                	cmp    %eax,%ecx
  801445:	74 17                	je     80145e <_main+0x1426>
  801447:	83 ec 04             	sub    $0x4,%esp
  80144a:	68 04 37 80 00       	push   $0x803704
  80144f:	68 53 01 00 00       	push   $0x153
  801454:	68 4b 35 80 00       	push   $0x80354b
  801459:	e8 51 04 00 00       	call   8018af <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != toAccess) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  80145e:	e8 5f 19 00 00       	call   802dc2 <sys_calculate_free_frames>
  801463:	89 c2                	mov    %eax,%edx
  801465:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  80146b:	29 c2                	sub    %eax,%edx
  80146d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  801470:	39 c2                	cmp    %eax,%edx
  801472:	74 17                	je     80148b <_main+0x1453>
  801474:	83 ec 04             	sub    $0x4,%esp
  801477:	68 40 37 80 00       	push   $0x803740
  80147c:	68 54 01 00 00       	push   $0x154
  801481:	68 4b 35 80 00       	push   $0x80354b
  801486:	e8 24 04 00 00       	call   8018af <_panic>

		//Free 1st 3 KB
		freeFrames = sys_calculate_free_frames() ;
  80148b:	e8 32 19 00 00       	call   802dc2 <sys_calculate_free_frames>
  801490:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801496:	e8 aa 19 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  80149b:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[2]);
  8014a1:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  8014a7:	83 ec 0c             	sub    $0xc,%esp
  8014aa:	50                   	push   %eax
  8014ab:	e8 3b 16 00 00       	call   802aeb <free>
  8014b0:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  8014b3:	e8 8d 19 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  8014b8:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  8014be:	29 c2                	sub    %eax,%edx
  8014c0:	89 d0                	mov    %edx,%eax
  8014c2:	83 f8 01             	cmp    $0x1,%eax
  8014c5:	74 17                	je     8014de <_main+0x14a6>
  8014c7:	83 ec 04             	sub    $0x4,%esp
  8014ca:	68 04 37 80 00       	push   $0x803704
  8014cf:	68 5a 01 00 00       	push   $0x15a
  8014d4:	68 4b 35 80 00       	push   $0x80354b
  8014d9:	e8 d1 03 00 00       	call   8018af <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 1 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8014de:	e8 df 18 00 00       	call   802dc2 <sys_calculate_free_frames>
  8014e3:	89 c2                	mov    %eax,%edx
  8014e5:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  8014eb:	29 c2                	sub    %eax,%edx
  8014ed:	89 d0                	mov    %edx,%eax
  8014ef:	83 f8 02             	cmp    $0x2,%eax
  8014f2:	74 17                	je     80150b <_main+0x14d3>
  8014f4:	83 ec 04             	sub    $0x4,%esp
  8014f7:	68 40 37 80 00       	push   $0x803740
  8014fc:	68 5b 01 00 00       	push   $0x15b
  801501:	68 4b 35 80 00       	push   $0x80354b
  801506:	e8 a4 03 00 00       	call   8018af <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(intArr[0]));
  80150b:	8b 45 88             	mov    -0x78(%ebp),%eax
  80150e:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(intArr[lastIndexOfInt]));
  801514:	8b 45 84             	mov    -0x7c(%ebp),%eax
  801517:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80151e:	8b 45 88             	mov    -0x78(%ebp),%eax
  801521:	01 d0                	add    %edx,%eax
  801523:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  801529:	83 ec 08             	sub    $0x8,%esp
  80152c:	6a 02                	push   $0x2
  80152e:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  801534:	50                   	push   %eax
  801535:	e8 5c 1d 00 00       	call   803296 <sys_check_LRU_lists_free>
  80153a:	83 c4 10             	add    $0x10,%esp
  80153d:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  801543:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  80154a:	74 17                	je     801563 <_main+0x152b>
		{
				panic("free: page is not removed from LRU lists");
  80154c:	83 ec 04             	sub    $0x4,%esp
  80154f:	68 8c 37 80 00       	push   $0x80378c
  801554:	68 69 01 00 00       	push   $0x169
  801559:	68 4b 35 80 00       	push   $0x80354b
  80155e:	e8 4c 03 00 00       	call   8018af <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 794 && LIST_SIZE(&myEnv->SecondList) != 0)
  801563:	a1 20 40 80 00       	mov    0x804020,%eax
  801568:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  80156e:	3d 1a 03 00 00       	cmp    $0x31a,%eax
  801573:	74 26                	je     80159b <_main+0x1563>
  801575:	a1 20 40 80 00       	mov    0x804020,%eax
  80157a:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  801580:	85 c0                	test   %eax,%eax
  801582:	74 17                	je     80159b <_main+0x1563>
		{
			panic("LRU lists content is not correct");
  801584:	83 ec 04             	sub    $0x4,%esp
  801587:	68 b8 37 80 00       	push   $0x8037b8
  80158c:	68 6e 01 00 00       	push   $0x16e
  801591:	68 4b 35 80 00       	push   $0x80354b
  801596:	e8 14 03 00 00       	call   8018af <_panic>
		}

		//Free 2nd 3 KB
		freeFrames = sys_calculate_free_frames() ;
  80159b:	e8 22 18 00 00       	call   802dc2 <sys_calculate_free_frames>
  8015a0:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8015a6:	e8 9a 18 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  8015ab:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[3]);
  8015b1:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  8015b7:	83 ec 0c             	sub    $0xc,%esp
  8015ba:	50                   	push   %eax
  8015bb:	e8 2b 15 00 00       	call   802aeb <free>
  8015c0:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 1) panic("Wrong free: Extra or less pages are removed from PageFile");
  8015c3:	e8 7d 18 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  8015c8:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  8015ce:	29 c2                	sub    %eax,%edx
  8015d0:	89 d0                	mov    %edx,%eax
  8015d2:	83 f8 01             	cmp    $0x1,%eax
  8015d5:	74 17                	je     8015ee <_main+0x15b6>
  8015d7:	83 ec 04             	sub    $0x4,%esp
  8015da:	68 04 37 80 00       	push   $0x803704
  8015df:	68 75 01 00 00       	push   $0x175
  8015e4:	68 4b 35 80 00       	push   $0x80354b
  8015e9:	e8 c1 02 00 00       	call   8018af <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  8015ee:	e8 cf 17 00 00       	call   802dc2 <sys_calculate_free_frames>
  8015f3:	89 c2                	mov    %eax,%edx
  8015f5:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  8015fb:	39 c2                	cmp    %eax,%edx
  8015fd:	74 17                	je     801616 <_main+0x15de>
  8015ff:	83 ec 04             	sub    $0x4,%esp
  801602:	68 40 37 80 00       	push   $0x803740
  801607:	68 76 01 00 00       	push   $0x176
  80160c:	68 4b 35 80 00       	push   $0x80354b
  801611:	e8 99 02 00 00       	call   8018af <_panic>

		//Free last 14 KB
		freeFrames = sys_calculate_free_frames() ;
  801616:	e8 a7 17 00 00       	call   802dc2 <sys_calculate_free_frames>
  80161b:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  801621:	e8 1f 18 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  801626:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		free(ptr_allocations[7]);
  80162c:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  801632:	83 ec 0c             	sub    $0xc,%esp
  801635:	50                   	push   %eax
  801636:	e8 b0 14 00 00       	call   802aeb <free>
  80163b:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 4) panic("Wrong free: Extra or less pages are removed from PageFile");
  80163e:	e8 02 18 00 00       	call   802e45 <sys_pf_calculate_allocated_pages>
  801643:	8b 95 1c ff ff ff    	mov    -0xe4(%ebp),%edx
  801649:	29 c2                	sub    %eax,%edx
  80164b:	89 d0                	mov    %edx,%eax
  80164d:	83 f8 04             	cmp    $0x4,%eax
  801650:	74 17                	je     801669 <_main+0x1631>
  801652:	83 ec 04             	sub    $0x4,%esp
  801655:	68 04 37 80 00       	push   $0x803704
  80165a:	68 7c 01 00 00       	push   $0x17c
  80165f:	68 4b 35 80 00       	push   $0x80354b
  801664:	e8 46 02 00 00       	call   8018af <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 2 + 1) panic("Wrong free: WS pages in memory and/or page tables are not freed correctly");
  801669:	e8 54 17 00 00       	call   802dc2 <sys_calculate_free_frames>
  80166e:	89 c2                	mov    %eax,%edx
  801670:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801676:	29 c2                	sub    %eax,%edx
  801678:	89 d0                	mov    %edx,%eax
  80167a:	83 f8 03             	cmp    $0x3,%eax
  80167d:	74 17                	je     801696 <_main+0x165e>
  80167f:	83 ec 04             	sub    $0x4,%esp
  801682:	68 40 37 80 00       	push   $0x803740
  801687:	68 7d 01 00 00       	push   $0x17d
  80168c:	68 4b 35 80 00       	push   $0x80354b
  801691:	e8 19 02 00 00       	call   8018af <_panic>
//				panic("free: page is not removed from WS");
//			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
//				panic("free: page is not removed from WS");
//		}

		tmp_addresses[0] = (uint32)(&(shortArr2[0]));
  801696:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  80169c:	89 85 bc fe ff ff    	mov    %eax,-0x144(%ebp)
		tmp_addresses[1] = (uint32)(&(shortArr2[lastIndexOfShort2]));
  8016a2:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  8016a8:	01 c0                	add    %eax,%eax
  8016aa:	89 c2                	mov    %eax,%edx
  8016ac:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  8016b2:	01 d0                	add    %edx,%eax
  8016b4:	89 85 c0 fe ff ff    	mov    %eax,-0x140(%ebp)
		check = sys_check_LRU_lists_free(tmp_addresses, 2);
  8016ba:	83 ec 08             	sub    $0x8,%esp
  8016bd:	6a 02                	push   $0x2
  8016bf:	8d 85 bc fe ff ff    	lea    -0x144(%ebp),%eax
  8016c5:	50                   	push   %eax
  8016c6:	e8 cb 1b 00 00       	call   803296 <sys_check_LRU_lists_free>
  8016cb:	83 c4 10             	add    $0x10,%esp
  8016ce:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if(check != 0)
  8016d4:	83 bd 18 ff ff ff 00 	cmpl   $0x0,-0xe8(%ebp)
  8016db:	74 17                	je     8016f4 <_main+0x16bc>
		{
				panic("free: page is not removed from LRU lists");
  8016dd:	83 ec 04             	sub    $0x4,%esp
  8016e0:	68 8c 37 80 00       	push   $0x80378c
  8016e5:	68 8b 01 00 00       	push   $0x18b
  8016ea:	68 4b 35 80 00       	push   $0x80354b
  8016ef:	e8 bb 01 00 00       	call   8018af <_panic>
		}

		if(LIST_SIZE(&myEnv->ActiveList) != 792 && LIST_SIZE(&myEnv->SecondList) != 0)
  8016f4:	a1 20 40 80 00       	mov    0x804020,%eax
  8016f9:	8b 80 ac 3c 01 00    	mov    0x13cac(%eax),%eax
  8016ff:	3d 18 03 00 00       	cmp    $0x318,%eax
  801704:	74 26                	je     80172c <_main+0x16f4>
  801706:	a1 20 40 80 00       	mov    0x804020,%eax
  80170b:	8b 80 bc 3c 01 00    	mov    0x13cbc(%eax),%eax
  801711:	85 c0                	test   %eax,%eax
  801713:	74 17                	je     80172c <_main+0x16f4>
		{
			panic("LRU lists content is not correct");
  801715:	83 ec 04             	sub    $0x4,%esp
  801718:	68 b8 37 80 00       	push   $0x8037b8
  80171d:	68 90 01 00 00       	push   $0x190
  801722:	68 4b 35 80 00       	push   $0x80354b
  801727:	e8 83 01 00 00       	call   8018af <_panic>
		}

			if(start_freeFrames != (sys_calculate_free_frames() + 4)) {panic("Wrong free: not all pages removed correctly at end");}
  80172c:	e8 91 16 00 00       	call   802dc2 <sys_calculate_free_frames>
  801731:	8d 50 04             	lea    0x4(%eax),%edx
  801734:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801737:	39 c2                	cmp    %eax,%edx
  801739:	74 17                	je     801752 <_main+0x171a>
  80173b:	83 ec 04             	sub    $0x4,%esp
  80173e:	68 dc 37 80 00       	push   $0x8037dc
  801743:	68 93 01 00 00       	push   $0x193
  801748:	68 4b 35 80 00       	push   $0x80354b
  80174d:	e8 5d 01 00 00       	call   8018af <_panic>
		}

		cprintf("Congratulations!! test free [1] completed successfully.\n");
  801752:	83 ec 0c             	sub    $0xc,%esp
  801755:	68 10 38 80 00       	push   $0x803810
  80175a:	e8 f2 03 00 00       	call   801b51 <cprintf>
  80175f:	83 c4 10             	add    $0x10,%esp

	return;
  801762:	90                   	nop
}
  801763:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801766:	5b                   	pop    %ebx
  801767:	5f                   	pop    %edi
  801768:	5d                   	pop    %ebp
  801769:	c3                   	ret    

0080176a <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80176a:	55                   	push   %ebp
  80176b:	89 e5                	mov    %esp,%ebp
  80176d:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  801770:	e8 82 15 00 00       	call   802cf7 <sys_getenvindex>
  801775:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  801778:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80177b:	89 d0                	mov    %edx,%eax
  80177d:	c1 e0 03             	shl    $0x3,%eax
  801780:	01 d0                	add    %edx,%eax
  801782:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  801789:	01 c8                	add    %ecx,%eax
  80178b:	01 c0                	add    %eax,%eax
  80178d:	01 d0                	add    %edx,%eax
  80178f:	01 c0                	add    %eax,%eax
  801791:	01 d0                	add    %edx,%eax
  801793:	89 c2                	mov    %eax,%edx
  801795:	c1 e2 05             	shl    $0x5,%edx
  801798:	29 c2                	sub    %eax,%edx
  80179a:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8017a1:	89 c2                	mov    %eax,%edx
  8017a3:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8017a9:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8017ae:	a1 20 40 80 00       	mov    0x804020,%eax
  8017b3:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8017b9:	84 c0                	test   %al,%al
  8017bb:	74 0f                	je     8017cc <libmain+0x62>
		binaryname = myEnv->prog_name;
  8017bd:	a1 20 40 80 00       	mov    0x804020,%eax
  8017c2:	05 40 3c 01 00       	add    $0x13c40,%eax
  8017c7:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8017cc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017d0:	7e 0a                	jle    8017dc <libmain+0x72>
		binaryname = argv[0];
  8017d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d5:	8b 00                	mov    (%eax),%eax
  8017d7:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  8017dc:	83 ec 08             	sub    $0x8,%esp
  8017df:	ff 75 0c             	pushl  0xc(%ebp)
  8017e2:	ff 75 08             	pushl  0x8(%ebp)
  8017e5:	e8 4e e8 ff ff       	call   800038 <_main>
  8017ea:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8017ed:	e8 a0 16 00 00       	call   802e92 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8017f2:	83 ec 0c             	sub    $0xc,%esp
  8017f5:	68 64 38 80 00       	push   $0x803864
  8017fa:	e8 52 03 00 00       	call   801b51 <cprintf>
  8017ff:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  801802:	a1 20 40 80 00       	mov    0x804020,%eax
  801807:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80180d:	a1 20 40 80 00       	mov    0x804020,%eax
  801812:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  801818:	83 ec 04             	sub    $0x4,%esp
  80181b:	52                   	push   %edx
  80181c:	50                   	push   %eax
  80181d:	68 8c 38 80 00       	push   $0x80388c
  801822:	e8 2a 03 00 00       	call   801b51 <cprintf>
  801827:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80182a:	a1 20 40 80 00       	mov    0x804020,%eax
  80182f:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  801835:	a1 20 40 80 00       	mov    0x804020,%eax
  80183a:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  801840:	83 ec 04             	sub    $0x4,%esp
  801843:	52                   	push   %edx
  801844:	50                   	push   %eax
  801845:	68 b4 38 80 00       	push   $0x8038b4
  80184a:	e8 02 03 00 00       	call   801b51 <cprintf>
  80184f:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  801852:	a1 20 40 80 00       	mov    0x804020,%eax
  801857:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80185d:	83 ec 08             	sub    $0x8,%esp
  801860:	50                   	push   %eax
  801861:	68 f5 38 80 00       	push   $0x8038f5
  801866:	e8 e6 02 00 00       	call   801b51 <cprintf>
  80186b:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80186e:	83 ec 0c             	sub    $0xc,%esp
  801871:	68 64 38 80 00       	push   $0x803864
  801876:	e8 d6 02 00 00       	call   801b51 <cprintf>
  80187b:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80187e:	e8 29 16 00 00       	call   802eac <sys_enable_interrupt>

	// exit gracefully
	exit();
  801883:	e8 19 00 00 00       	call   8018a1 <exit>
}
  801888:	90                   	nop
  801889:	c9                   	leave  
  80188a:	c3                   	ret    

0080188b <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80188b:	55                   	push   %ebp
  80188c:	89 e5                	mov    %esp,%ebp
  80188e:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  801891:	83 ec 0c             	sub    $0xc,%esp
  801894:	6a 00                	push   $0x0
  801896:	e8 28 14 00 00       	call   802cc3 <sys_env_destroy>
  80189b:	83 c4 10             	add    $0x10,%esp
}
  80189e:	90                   	nop
  80189f:	c9                   	leave  
  8018a0:	c3                   	ret    

008018a1 <exit>:

void
exit(void)
{
  8018a1:	55                   	push   %ebp
  8018a2:	89 e5                	mov    %esp,%ebp
  8018a4:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8018a7:	e8 7d 14 00 00       	call   802d29 <sys_env_exit>
}
  8018ac:	90                   	nop
  8018ad:	c9                   	leave  
  8018ae:	c3                   	ret    

008018af <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8018af:	55                   	push   %ebp
  8018b0:	89 e5                	mov    %esp,%ebp
  8018b2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8018b5:	8d 45 10             	lea    0x10(%ebp),%eax
  8018b8:	83 c0 04             	add    $0x4,%eax
  8018bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8018be:	a1 18 41 80 00       	mov    0x804118,%eax
  8018c3:	85 c0                	test   %eax,%eax
  8018c5:	74 16                	je     8018dd <_panic+0x2e>
		cprintf("%s: ", argv0);
  8018c7:	a1 18 41 80 00       	mov    0x804118,%eax
  8018cc:	83 ec 08             	sub    $0x8,%esp
  8018cf:	50                   	push   %eax
  8018d0:	68 0c 39 80 00       	push   $0x80390c
  8018d5:	e8 77 02 00 00       	call   801b51 <cprintf>
  8018da:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8018dd:	a1 00 40 80 00       	mov    0x804000,%eax
  8018e2:	ff 75 0c             	pushl  0xc(%ebp)
  8018e5:	ff 75 08             	pushl  0x8(%ebp)
  8018e8:	50                   	push   %eax
  8018e9:	68 11 39 80 00       	push   $0x803911
  8018ee:	e8 5e 02 00 00       	call   801b51 <cprintf>
  8018f3:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8018f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8018f9:	83 ec 08             	sub    $0x8,%esp
  8018fc:	ff 75 f4             	pushl  -0xc(%ebp)
  8018ff:	50                   	push   %eax
  801900:	e8 e1 01 00 00       	call   801ae6 <vcprintf>
  801905:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801908:	83 ec 08             	sub    $0x8,%esp
  80190b:	6a 00                	push   $0x0
  80190d:	68 2d 39 80 00       	push   $0x80392d
  801912:	e8 cf 01 00 00       	call   801ae6 <vcprintf>
  801917:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80191a:	e8 82 ff ff ff       	call   8018a1 <exit>

	// should not return here
	while (1) ;
  80191f:	eb fe                	jmp    80191f <_panic+0x70>

00801921 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801921:	55                   	push   %ebp
  801922:	89 e5                	mov    %esp,%ebp
  801924:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801927:	a1 20 40 80 00       	mov    0x804020,%eax
  80192c:	8b 50 74             	mov    0x74(%eax),%edx
  80192f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801932:	39 c2                	cmp    %eax,%edx
  801934:	74 14                	je     80194a <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801936:	83 ec 04             	sub    $0x4,%esp
  801939:	68 30 39 80 00       	push   $0x803930
  80193e:	6a 26                	push   $0x26
  801940:	68 7c 39 80 00       	push   $0x80397c
  801945:	e8 65 ff ff ff       	call   8018af <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80194a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801951:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801958:	e9 b6 00 00 00       	jmp    801a13 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80195d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801960:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801967:	8b 45 08             	mov    0x8(%ebp),%eax
  80196a:	01 d0                	add    %edx,%eax
  80196c:	8b 00                	mov    (%eax),%eax
  80196e:	85 c0                	test   %eax,%eax
  801970:	75 08                	jne    80197a <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801972:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801975:	e9 96 00 00 00       	jmp    801a10 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80197a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801981:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801988:	eb 5d                	jmp    8019e7 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80198a:	a1 20 40 80 00       	mov    0x804020,%eax
  80198f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801995:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801998:	c1 e2 04             	shl    $0x4,%edx
  80199b:	01 d0                	add    %edx,%eax
  80199d:	8a 40 04             	mov    0x4(%eax),%al
  8019a0:	84 c0                	test   %al,%al
  8019a2:	75 40                	jne    8019e4 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8019a4:	a1 20 40 80 00       	mov    0x804020,%eax
  8019a9:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8019af:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8019b2:	c1 e2 04             	shl    $0x4,%edx
  8019b5:	01 d0                	add    %edx,%eax
  8019b7:	8b 00                	mov    (%eax),%eax
  8019b9:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8019bc:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8019bf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8019c4:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8019c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8019c9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8019d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d3:	01 c8                	add    %ecx,%eax
  8019d5:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8019d7:	39 c2                	cmp    %eax,%edx
  8019d9:	75 09                	jne    8019e4 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8019db:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8019e2:	eb 12                	jmp    8019f6 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019e4:	ff 45 e8             	incl   -0x18(%ebp)
  8019e7:	a1 20 40 80 00       	mov    0x804020,%eax
  8019ec:	8b 50 74             	mov    0x74(%eax),%edx
  8019ef:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019f2:	39 c2                	cmp    %eax,%edx
  8019f4:	77 94                	ja     80198a <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8019f6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8019fa:	75 14                	jne    801a10 <CheckWSWithoutLastIndex+0xef>
			panic(
  8019fc:	83 ec 04             	sub    $0x4,%esp
  8019ff:	68 88 39 80 00       	push   $0x803988
  801a04:	6a 3a                	push   $0x3a
  801a06:	68 7c 39 80 00       	push   $0x80397c
  801a0b:	e8 9f fe ff ff       	call   8018af <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801a10:	ff 45 f0             	incl   -0x10(%ebp)
  801a13:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a16:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801a19:	0f 8c 3e ff ff ff    	jl     80195d <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801a1f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a26:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801a2d:	eb 20                	jmp    801a4f <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801a2f:	a1 20 40 80 00       	mov    0x804020,%eax
  801a34:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801a3a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801a3d:	c1 e2 04             	shl    $0x4,%edx
  801a40:	01 d0                	add    %edx,%eax
  801a42:	8a 40 04             	mov    0x4(%eax),%al
  801a45:	3c 01                	cmp    $0x1,%al
  801a47:	75 03                	jne    801a4c <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  801a49:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a4c:	ff 45 e0             	incl   -0x20(%ebp)
  801a4f:	a1 20 40 80 00       	mov    0x804020,%eax
  801a54:	8b 50 74             	mov    0x74(%eax),%edx
  801a57:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801a5a:	39 c2                	cmp    %eax,%edx
  801a5c:	77 d1                	ja     801a2f <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801a5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a61:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801a64:	74 14                	je     801a7a <CheckWSWithoutLastIndex+0x159>
		panic(
  801a66:	83 ec 04             	sub    $0x4,%esp
  801a69:	68 dc 39 80 00       	push   $0x8039dc
  801a6e:	6a 44                	push   $0x44
  801a70:	68 7c 39 80 00       	push   $0x80397c
  801a75:	e8 35 fe ff ff       	call   8018af <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801a7a:	90                   	nop
  801a7b:	c9                   	leave  
  801a7c:	c3                   	ret    

00801a7d <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  801a7d:	55                   	push   %ebp
  801a7e:	89 e5                	mov    %esp,%ebp
  801a80:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801a83:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a86:	8b 00                	mov    (%eax),%eax
  801a88:	8d 48 01             	lea    0x1(%eax),%ecx
  801a8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a8e:	89 0a                	mov    %ecx,(%edx)
  801a90:	8b 55 08             	mov    0x8(%ebp),%edx
  801a93:	88 d1                	mov    %dl,%cl
  801a95:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a98:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  801a9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a9f:	8b 00                	mov    (%eax),%eax
  801aa1:	3d ff 00 00 00       	cmp    $0xff,%eax
  801aa6:	75 2c                	jne    801ad4 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  801aa8:	a0 24 40 80 00       	mov    0x804024,%al
  801aad:	0f b6 c0             	movzbl %al,%eax
  801ab0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ab3:	8b 12                	mov    (%edx),%edx
  801ab5:	89 d1                	mov    %edx,%ecx
  801ab7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aba:	83 c2 08             	add    $0x8,%edx
  801abd:	83 ec 04             	sub    $0x4,%esp
  801ac0:	50                   	push   %eax
  801ac1:	51                   	push   %ecx
  801ac2:	52                   	push   %edx
  801ac3:	e8 b9 11 00 00       	call   802c81 <sys_cputs>
  801ac8:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  801acb:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ace:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  801ad4:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ad7:	8b 40 04             	mov    0x4(%eax),%eax
  801ada:	8d 50 01             	lea    0x1(%eax),%edx
  801add:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ae0:	89 50 04             	mov    %edx,0x4(%eax)
}
  801ae3:	90                   	nop
  801ae4:	c9                   	leave  
  801ae5:	c3                   	ret    

00801ae6 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  801ae6:	55                   	push   %ebp
  801ae7:	89 e5                	mov    %esp,%ebp
  801ae9:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  801aef:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  801af6:	00 00 00 
	b.cnt = 0;
  801af9:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  801b00:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  801b03:	ff 75 0c             	pushl  0xc(%ebp)
  801b06:	ff 75 08             	pushl  0x8(%ebp)
  801b09:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801b0f:	50                   	push   %eax
  801b10:	68 7d 1a 80 00       	push   $0x801a7d
  801b15:	e8 11 02 00 00       	call   801d2b <vprintfmt>
  801b1a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  801b1d:	a0 24 40 80 00       	mov    0x804024,%al
  801b22:	0f b6 c0             	movzbl %al,%eax
  801b25:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  801b2b:	83 ec 04             	sub    $0x4,%esp
  801b2e:	50                   	push   %eax
  801b2f:	52                   	push   %edx
  801b30:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801b36:	83 c0 08             	add    $0x8,%eax
  801b39:	50                   	push   %eax
  801b3a:	e8 42 11 00 00       	call   802c81 <sys_cputs>
  801b3f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801b42:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  801b49:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801b4f:	c9                   	leave  
  801b50:	c3                   	ret    

00801b51 <cprintf>:

int cprintf(const char *fmt, ...) {
  801b51:	55                   	push   %ebp
  801b52:	89 e5                	mov    %esp,%ebp
  801b54:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  801b57:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  801b5e:	8d 45 0c             	lea    0xc(%ebp),%eax
  801b61:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801b64:	8b 45 08             	mov    0x8(%ebp),%eax
  801b67:	83 ec 08             	sub    $0x8,%esp
  801b6a:	ff 75 f4             	pushl  -0xc(%ebp)
  801b6d:	50                   	push   %eax
  801b6e:	e8 73 ff ff ff       	call   801ae6 <vcprintf>
  801b73:	83 c4 10             	add    $0x10,%esp
  801b76:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  801b79:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801b7c:	c9                   	leave  
  801b7d:	c3                   	ret    

00801b7e <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801b7e:	55                   	push   %ebp
  801b7f:	89 e5                	mov    %esp,%ebp
  801b81:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801b84:	e8 09 13 00 00       	call   802e92 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801b89:	8d 45 0c             	lea    0xc(%ebp),%eax
  801b8c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801b8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b92:	83 ec 08             	sub    $0x8,%esp
  801b95:	ff 75 f4             	pushl  -0xc(%ebp)
  801b98:	50                   	push   %eax
  801b99:	e8 48 ff ff ff       	call   801ae6 <vcprintf>
  801b9e:	83 c4 10             	add    $0x10,%esp
  801ba1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801ba4:	e8 03 13 00 00       	call   802eac <sys_enable_interrupt>
	return cnt;
  801ba9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801bac:	c9                   	leave  
  801bad:	c3                   	ret    

00801bae <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801bae:	55                   	push   %ebp
  801baf:	89 e5                	mov    %esp,%ebp
  801bb1:	53                   	push   %ebx
  801bb2:	83 ec 14             	sub    $0x14,%esp
  801bb5:	8b 45 10             	mov    0x10(%ebp),%eax
  801bb8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801bbb:	8b 45 14             	mov    0x14(%ebp),%eax
  801bbe:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801bc1:	8b 45 18             	mov    0x18(%ebp),%eax
  801bc4:	ba 00 00 00 00       	mov    $0x0,%edx
  801bc9:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801bcc:	77 55                	ja     801c23 <printnum+0x75>
  801bce:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801bd1:	72 05                	jb     801bd8 <printnum+0x2a>
  801bd3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801bd6:	77 4b                	ja     801c23 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801bd8:	8b 45 1c             	mov    0x1c(%ebp),%eax
  801bdb:	8d 58 ff             	lea    -0x1(%eax),%ebx
  801bde:	8b 45 18             	mov    0x18(%ebp),%eax
  801be1:	ba 00 00 00 00       	mov    $0x0,%edx
  801be6:	52                   	push   %edx
  801be7:	50                   	push   %eax
  801be8:	ff 75 f4             	pushl  -0xc(%ebp)
  801beb:	ff 75 f0             	pushl  -0x10(%ebp)
  801bee:	e8 c1 16 00 00       	call   8032b4 <__udivdi3>
  801bf3:	83 c4 10             	add    $0x10,%esp
  801bf6:	83 ec 04             	sub    $0x4,%esp
  801bf9:	ff 75 20             	pushl  0x20(%ebp)
  801bfc:	53                   	push   %ebx
  801bfd:	ff 75 18             	pushl  0x18(%ebp)
  801c00:	52                   	push   %edx
  801c01:	50                   	push   %eax
  801c02:	ff 75 0c             	pushl  0xc(%ebp)
  801c05:	ff 75 08             	pushl  0x8(%ebp)
  801c08:	e8 a1 ff ff ff       	call   801bae <printnum>
  801c0d:	83 c4 20             	add    $0x20,%esp
  801c10:	eb 1a                	jmp    801c2c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801c12:	83 ec 08             	sub    $0x8,%esp
  801c15:	ff 75 0c             	pushl  0xc(%ebp)
  801c18:	ff 75 20             	pushl  0x20(%ebp)
  801c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1e:	ff d0                	call   *%eax
  801c20:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801c23:	ff 4d 1c             	decl   0x1c(%ebp)
  801c26:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801c2a:	7f e6                	jg     801c12 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801c2c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801c2f:	bb 00 00 00 00       	mov    $0x0,%ebx
  801c34:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c37:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c3a:	53                   	push   %ebx
  801c3b:	51                   	push   %ecx
  801c3c:	52                   	push   %edx
  801c3d:	50                   	push   %eax
  801c3e:	e8 81 17 00 00       	call   8033c4 <__umoddi3>
  801c43:	83 c4 10             	add    $0x10,%esp
  801c46:	05 54 3c 80 00       	add    $0x803c54,%eax
  801c4b:	8a 00                	mov    (%eax),%al
  801c4d:	0f be c0             	movsbl %al,%eax
  801c50:	83 ec 08             	sub    $0x8,%esp
  801c53:	ff 75 0c             	pushl  0xc(%ebp)
  801c56:	50                   	push   %eax
  801c57:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5a:	ff d0                	call   *%eax
  801c5c:	83 c4 10             	add    $0x10,%esp
}
  801c5f:	90                   	nop
  801c60:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801c63:	c9                   	leave  
  801c64:	c3                   	ret    

00801c65 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  801c65:	55                   	push   %ebp
  801c66:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801c68:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801c6c:	7e 1c                	jle    801c8a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801c6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c71:	8b 00                	mov    (%eax),%eax
  801c73:	8d 50 08             	lea    0x8(%eax),%edx
  801c76:	8b 45 08             	mov    0x8(%ebp),%eax
  801c79:	89 10                	mov    %edx,(%eax)
  801c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7e:	8b 00                	mov    (%eax),%eax
  801c80:	83 e8 08             	sub    $0x8,%eax
  801c83:	8b 50 04             	mov    0x4(%eax),%edx
  801c86:	8b 00                	mov    (%eax),%eax
  801c88:	eb 40                	jmp    801cca <getuint+0x65>
	else if (lflag)
  801c8a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801c8e:	74 1e                	je     801cae <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801c90:	8b 45 08             	mov    0x8(%ebp),%eax
  801c93:	8b 00                	mov    (%eax),%eax
  801c95:	8d 50 04             	lea    0x4(%eax),%edx
  801c98:	8b 45 08             	mov    0x8(%ebp),%eax
  801c9b:	89 10                	mov    %edx,(%eax)
  801c9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca0:	8b 00                	mov    (%eax),%eax
  801ca2:	83 e8 04             	sub    $0x4,%eax
  801ca5:	8b 00                	mov    (%eax),%eax
  801ca7:	ba 00 00 00 00       	mov    $0x0,%edx
  801cac:	eb 1c                	jmp    801cca <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801cae:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb1:	8b 00                	mov    (%eax),%eax
  801cb3:	8d 50 04             	lea    0x4(%eax),%edx
  801cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb9:	89 10                	mov    %edx,(%eax)
  801cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cbe:	8b 00                	mov    (%eax),%eax
  801cc0:	83 e8 04             	sub    $0x4,%eax
  801cc3:	8b 00                	mov    (%eax),%eax
  801cc5:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801cca:	5d                   	pop    %ebp
  801ccb:	c3                   	ret    

00801ccc <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801ccc:	55                   	push   %ebp
  801ccd:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801ccf:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801cd3:	7e 1c                	jle    801cf1 <getint+0x25>
		return va_arg(*ap, long long);
  801cd5:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd8:	8b 00                	mov    (%eax),%eax
  801cda:	8d 50 08             	lea    0x8(%eax),%edx
  801cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce0:	89 10                	mov    %edx,(%eax)
  801ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce5:	8b 00                	mov    (%eax),%eax
  801ce7:	83 e8 08             	sub    $0x8,%eax
  801cea:	8b 50 04             	mov    0x4(%eax),%edx
  801ced:	8b 00                	mov    (%eax),%eax
  801cef:	eb 38                	jmp    801d29 <getint+0x5d>
	else if (lflag)
  801cf1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801cf5:	74 1a                	je     801d11 <getint+0x45>
		return va_arg(*ap, long);
  801cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfa:	8b 00                	mov    (%eax),%eax
  801cfc:	8d 50 04             	lea    0x4(%eax),%edx
  801cff:	8b 45 08             	mov    0x8(%ebp),%eax
  801d02:	89 10                	mov    %edx,(%eax)
  801d04:	8b 45 08             	mov    0x8(%ebp),%eax
  801d07:	8b 00                	mov    (%eax),%eax
  801d09:	83 e8 04             	sub    $0x4,%eax
  801d0c:	8b 00                	mov    (%eax),%eax
  801d0e:	99                   	cltd   
  801d0f:	eb 18                	jmp    801d29 <getint+0x5d>
	else
		return va_arg(*ap, int);
  801d11:	8b 45 08             	mov    0x8(%ebp),%eax
  801d14:	8b 00                	mov    (%eax),%eax
  801d16:	8d 50 04             	lea    0x4(%eax),%edx
  801d19:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1c:	89 10                	mov    %edx,(%eax)
  801d1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d21:	8b 00                	mov    (%eax),%eax
  801d23:	83 e8 04             	sub    $0x4,%eax
  801d26:	8b 00                	mov    (%eax),%eax
  801d28:	99                   	cltd   
}
  801d29:	5d                   	pop    %ebp
  801d2a:	c3                   	ret    

00801d2b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801d2b:	55                   	push   %ebp
  801d2c:	89 e5                	mov    %esp,%ebp
  801d2e:	56                   	push   %esi
  801d2f:	53                   	push   %ebx
  801d30:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801d33:	eb 17                	jmp    801d4c <vprintfmt+0x21>
			if (ch == '\0')
  801d35:	85 db                	test   %ebx,%ebx
  801d37:	0f 84 af 03 00 00    	je     8020ec <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801d3d:	83 ec 08             	sub    $0x8,%esp
  801d40:	ff 75 0c             	pushl  0xc(%ebp)
  801d43:	53                   	push   %ebx
  801d44:	8b 45 08             	mov    0x8(%ebp),%eax
  801d47:	ff d0                	call   *%eax
  801d49:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801d4c:	8b 45 10             	mov    0x10(%ebp),%eax
  801d4f:	8d 50 01             	lea    0x1(%eax),%edx
  801d52:	89 55 10             	mov    %edx,0x10(%ebp)
  801d55:	8a 00                	mov    (%eax),%al
  801d57:	0f b6 d8             	movzbl %al,%ebx
  801d5a:	83 fb 25             	cmp    $0x25,%ebx
  801d5d:	75 d6                	jne    801d35 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801d5f:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801d63:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801d6a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801d71:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801d78:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801d7f:	8b 45 10             	mov    0x10(%ebp),%eax
  801d82:	8d 50 01             	lea    0x1(%eax),%edx
  801d85:	89 55 10             	mov    %edx,0x10(%ebp)
  801d88:	8a 00                	mov    (%eax),%al
  801d8a:	0f b6 d8             	movzbl %al,%ebx
  801d8d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801d90:	83 f8 55             	cmp    $0x55,%eax
  801d93:	0f 87 2b 03 00 00    	ja     8020c4 <vprintfmt+0x399>
  801d99:	8b 04 85 78 3c 80 00 	mov    0x803c78(,%eax,4),%eax
  801da0:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801da2:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801da6:	eb d7                	jmp    801d7f <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801da8:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801dac:	eb d1                	jmp    801d7f <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801dae:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801db5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801db8:	89 d0                	mov    %edx,%eax
  801dba:	c1 e0 02             	shl    $0x2,%eax
  801dbd:	01 d0                	add    %edx,%eax
  801dbf:	01 c0                	add    %eax,%eax
  801dc1:	01 d8                	add    %ebx,%eax
  801dc3:	83 e8 30             	sub    $0x30,%eax
  801dc6:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801dc9:	8b 45 10             	mov    0x10(%ebp),%eax
  801dcc:	8a 00                	mov    (%eax),%al
  801dce:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801dd1:	83 fb 2f             	cmp    $0x2f,%ebx
  801dd4:	7e 3e                	jle    801e14 <vprintfmt+0xe9>
  801dd6:	83 fb 39             	cmp    $0x39,%ebx
  801dd9:	7f 39                	jg     801e14 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801ddb:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801dde:	eb d5                	jmp    801db5 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801de0:	8b 45 14             	mov    0x14(%ebp),%eax
  801de3:	83 c0 04             	add    $0x4,%eax
  801de6:	89 45 14             	mov    %eax,0x14(%ebp)
  801de9:	8b 45 14             	mov    0x14(%ebp),%eax
  801dec:	83 e8 04             	sub    $0x4,%eax
  801def:	8b 00                	mov    (%eax),%eax
  801df1:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801df4:	eb 1f                	jmp    801e15 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801df6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801dfa:	79 83                	jns    801d7f <vprintfmt+0x54>
				width = 0;
  801dfc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801e03:	e9 77 ff ff ff       	jmp    801d7f <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801e08:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801e0f:	e9 6b ff ff ff       	jmp    801d7f <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801e14:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801e15:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801e19:	0f 89 60 ff ff ff    	jns    801d7f <vprintfmt+0x54>
				width = precision, precision = -1;
  801e1f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801e22:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801e25:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801e2c:	e9 4e ff ff ff       	jmp    801d7f <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801e31:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801e34:	e9 46 ff ff ff       	jmp    801d7f <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801e39:	8b 45 14             	mov    0x14(%ebp),%eax
  801e3c:	83 c0 04             	add    $0x4,%eax
  801e3f:	89 45 14             	mov    %eax,0x14(%ebp)
  801e42:	8b 45 14             	mov    0x14(%ebp),%eax
  801e45:	83 e8 04             	sub    $0x4,%eax
  801e48:	8b 00                	mov    (%eax),%eax
  801e4a:	83 ec 08             	sub    $0x8,%esp
  801e4d:	ff 75 0c             	pushl  0xc(%ebp)
  801e50:	50                   	push   %eax
  801e51:	8b 45 08             	mov    0x8(%ebp),%eax
  801e54:	ff d0                	call   *%eax
  801e56:	83 c4 10             	add    $0x10,%esp
			break;
  801e59:	e9 89 02 00 00       	jmp    8020e7 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801e5e:	8b 45 14             	mov    0x14(%ebp),%eax
  801e61:	83 c0 04             	add    $0x4,%eax
  801e64:	89 45 14             	mov    %eax,0x14(%ebp)
  801e67:	8b 45 14             	mov    0x14(%ebp),%eax
  801e6a:	83 e8 04             	sub    $0x4,%eax
  801e6d:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801e6f:	85 db                	test   %ebx,%ebx
  801e71:	79 02                	jns    801e75 <vprintfmt+0x14a>
				err = -err;
  801e73:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801e75:	83 fb 64             	cmp    $0x64,%ebx
  801e78:	7f 0b                	jg     801e85 <vprintfmt+0x15a>
  801e7a:	8b 34 9d c0 3a 80 00 	mov    0x803ac0(,%ebx,4),%esi
  801e81:	85 f6                	test   %esi,%esi
  801e83:	75 19                	jne    801e9e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801e85:	53                   	push   %ebx
  801e86:	68 65 3c 80 00       	push   $0x803c65
  801e8b:	ff 75 0c             	pushl  0xc(%ebp)
  801e8e:	ff 75 08             	pushl  0x8(%ebp)
  801e91:	e8 5e 02 00 00       	call   8020f4 <printfmt>
  801e96:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801e99:	e9 49 02 00 00       	jmp    8020e7 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801e9e:	56                   	push   %esi
  801e9f:	68 6e 3c 80 00       	push   $0x803c6e
  801ea4:	ff 75 0c             	pushl  0xc(%ebp)
  801ea7:	ff 75 08             	pushl  0x8(%ebp)
  801eaa:	e8 45 02 00 00       	call   8020f4 <printfmt>
  801eaf:	83 c4 10             	add    $0x10,%esp
			break;
  801eb2:	e9 30 02 00 00       	jmp    8020e7 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801eb7:	8b 45 14             	mov    0x14(%ebp),%eax
  801eba:	83 c0 04             	add    $0x4,%eax
  801ebd:	89 45 14             	mov    %eax,0x14(%ebp)
  801ec0:	8b 45 14             	mov    0x14(%ebp),%eax
  801ec3:	83 e8 04             	sub    $0x4,%eax
  801ec6:	8b 30                	mov    (%eax),%esi
  801ec8:	85 f6                	test   %esi,%esi
  801eca:	75 05                	jne    801ed1 <vprintfmt+0x1a6>
				p = "(null)";
  801ecc:	be 71 3c 80 00       	mov    $0x803c71,%esi
			if (width > 0 && padc != '-')
  801ed1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801ed5:	7e 6d                	jle    801f44 <vprintfmt+0x219>
  801ed7:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801edb:	74 67                	je     801f44 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801edd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ee0:	83 ec 08             	sub    $0x8,%esp
  801ee3:	50                   	push   %eax
  801ee4:	56                   	push   %esi
  801ee5:	e8 0c 03 00 00       	call   8021f6 <strnlen>
  801eea:	83 c4 10             	add    $0x10,%esp
  801eed:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801ef0:	eb 16                	jmp    801f08 <vprintfmt+0x1dd>
					putch(padc, putdat);
  801ef2:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801ef6:	83 ec 08             	sub    $0x8,%esp
  801ef9:	ff 75 0c             	pushl  0xc(%ebp)
  801efc:	50                   	push   %eax
  801efd:	8b 45 08             	mov    0x8(%ebp),%eax
  801f00:	ff d0                	call   *%eax
  801f02:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801f05:	ff 4d e4             	decl   -0x1c(%ebp)
  801f08:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801f0c:	7f e4                	jg     801ef2 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801f0e:	eb 34                	jmp    801f44 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801f10:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801f14:	74 1c                	je     801f32 <vprintfmt+0x207>
  801f16:	83 fb 1f             	cmp    $0x1f,%ebx
  801f19:	7e 05                	jle    801f20 <vprintfmt+0x1f5>
  801f1b:	83 fb 7e             	cmp    $0x7e,%ebx
  801f1e:	7e 12                	jle    801f32 <vprintfmt+0x207>
					putch('?', putdat);
  801f20:	83 ec 08             	sub    $0x8,%esp
  801f23:	ff 75 0c             	pushl  0xc(%ebp)
  801f26:	6a 3f                	push   $0x3f
  801f28:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2b:	ff d0                	call   *%eax
  801f2d:	83 c4 10             	add    $0x10,%esp
  801f30:	eb 0f                	jmp    801f41 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801f32:	83 ec 08             	sub    $0x8,%esp
  801f35:	ff 75 0c             	pushl  0xc(%ebp)
  801f38:	53                   	push   %ebx
  801f39:	8b 45 08             	mov    0x8(%ebp),%eax
  801f3c:	ff d0                	call   *%eax
  801f3e:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801f41:	ff 4d e4             	decl   -0x1c(%ebp)
  801f44:	89 f0                	mov    %esi,%eax
  801f46:	8d 70 01             	lea    0x1(%eax),%esi
  801f49:	8a 00                	mov    (%eax),%al
  801f4b:	0f be d8             	movsbl %al,%ebx
  801f4e:	85 db                	test   %ebx,%ebx
  801f50:	74 24                	je     801f76 <vprintfmt+0x24b>
  801f52:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801f56:	78 b8                	js     801f10 <vprintfmt+0x1e5>
  801f58:	ff 4d e0             	decl   -0x20(%ebp)
  801f5b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801f5f:	79 af                	jns    801f10 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801f61:	eb 13                	jmp    801f76 <vprintfmt+0x24b>
				putch(' ', putdat);
  801f63:	83 ec 08             	sub    $0x8,%esp
  801f66:	ff 75 0c             	pushl  0xc(%ebp)
  801f69:	6a 20                	push   $0x20
  801f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6e:	ff d0                	call   *%eax
  801f70:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801f73:	ff 4d e4             	decl   -0x1c(%ebp)
  801f76:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801f7a:	7f e7                	jg     801f63 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801f7c:	e9 66 01 00 00       	jmp    8020e7 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801f81:	83 ec 08             	sub    $0x8,%esp
  801f84:	ff 75 e8             	pushl  -0x18(%ebp)
  801f87:	8d 45 14             	lea    0x14(%ebp),%eax
  801f8a:	50                   	push   %eax
  801f8b:	e8 3c fd ff ff       	call   801ccc <getint>
  801f90:	83 c4 10             	add    $0x10,%esp
  801f93:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801f96:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801f99:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f9c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801f9f:	85 d2                	test   %edx,%edx
  801fa1:	79 23                	jns    801fc6 <vprintfmt+0x29b>
				putch('-', putdat);
  801fa3:	83 ec 08             	sub    $0x8,%esp
  801fa6:	ff 75 0c             	pushl  0xc(%ebp)
  801fa9:	6a 2d                	push   $0x2d
  801fab:	8b 45 08             	mov    0x8(%ebp),%eax
  801fae:	ff d0                	call   *%eax
  801fb0:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801fb3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801fb6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801fb9:	f7 d8                	neg    %eax
  801fbb:	83 d2 00             	adc    $0x0,%edx
  801fbe:	f7 da                	neg    %edx
  801fc0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801fc3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801fc6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801fcd:	e9 bc 00 00 00       	jmp    80208e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801fd2:	83 ec 08             	sub    $0x8,%esp
  801fd5:	ff 75 e8             	pushl  -0x18(%ebp)
  801fd8:	8d 45 14             	lea    0x14(%ebp),%eax
  801fdb:	50                   	push   %eax
  801fdc:	e8 84 fc ff ff       	call   801c65 <getuint>
  801fe1:	83 c4 10             	add    $0x10,%esp
  801fe4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801fe7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801fea:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801ff1:	e9 98 00 00 00       	jmp    80208e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801ff6:	83 ec 08             	sub    $0x8,%esp
  801ff9:	ff 75 0c             	pushl  0xc(%ebp)
  801ffc:	6a 58                	push   $0x58
  801ffe:	8b 45 08             	mov    0x8(%ebp),%eax
  802001:	ff d0                	call   *%eax
  802003:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  802006:	83 ec 08             	sub    $0x8,%esp
  802009:	ff 75 0c             	pushl  0xc(%ebp)
  80200c:	6a 58                	push   $0x58
  80200e:	8b 45 08             	mov    0x8(%ebp),%eax
  802011:	ff d0                	call   *%eax
  802013:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  802016:	83 ec 08             	sub    $0x8,%esp
  802019:	ff 75 0c             	pushl  0xc(%ebp)
  80201c:	6a 58                	push   $0x58
  80201e:	8b 45 08             	mov    0x8(%ebp),%eax
  802021:	ff d0                	call   *%eax
  802023:	83 c4 10             	add    $0x10,%esp
			break;
  802026:	e9 bc 00 00 00       	jmp    8020e7 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80202b:	83 ec 08             	sub    $0x8,%esp
  80202e:	ff 75 0c             	pushl  0xc(%ebp)
  802031:	6a 30                	push   $0x30
  802033:	8b 45 08             	mov    0x8(%ebp),%eax
  802036:	ff d0                	call   *%eax
  802038:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80203b:	83 ec 08             	sub    $0x8,%esp
  80203e:	ff 75 0c             	pushl  0xc(%ebp)
  802041:	6a 78                	push   $0x78
  802043:	8b 45 08             	mov    0x8(%ebp),%eax
  802046:	ff d0                	call   *%eax
  802048:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80204b:	8b 45 14             	mov    0x14(%ebp),%eax
  80204e:	83 c0 04             	add    $0x4,%eax
  802051:	89 45 14             	mov    %eax,0x14(%ebp)
  802054:	8b 45 14             	mov    0x14(%ebp),%eax
  802057:	83 e8 04             	sub    $0x4,%eax
  80205a:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80205c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80205f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  802066:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80206d:	eb 1f                	jmp    80208e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80206f:	83 ec 08             	sub    $0x8,%esp
  802072:	ff 75 e8             	pushl  -0x18(%ebp)
  802075:	8d 45 14             	lea    0x14(%ebp),%eax
  802078:	50                   	push   %eax
  802079:	e8 e7 fb ff ff       	call   801c65 <getuint>
  80207e:	83 c4 10             	add    $0x10,%esp
  802081:	89 45 f0             	mov    %eax,-0x10(%ebp)
  802084:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  802087:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80208e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  802092:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802095:	83 ec 04             	sub    $0x4,%esp
  802098:	52                   	push   %edx
  802099:	ff 75 e4             	pushl  -0x1c(%ebp)
  80209c:	50                   	push   %eax
  80209d:	ff 75 f4             	pushl  -0xc(%ebp)
  8020a0:	ff 75 f0             	pushl  -0x10(%ebp)
  8020a3:	ff 75 0c             	pushl  0xc(%ebp)
  8020a6:	ff 75 08             	pushl  0x8(%ebp)
  8020a9:	e8 00 fb ff ff       	call   801bae <printnum>
  8020ae:	83 c4 20             	add    $0x20,%esp
			break;
  8020b1:	eb 34                	jmp    8020e7 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8020b3:	83 ec 08             	sub    $0x8,%esp
  8020b6:	ff 75 0c             	pushl  0xc(%ebp)
  8020b9:	53                   	push   %ebx
  8020ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8020bd:	ff d0                	call   *%eax
  8020bf:	83 c4 10             	add    $0x10,%esp
			break;
  8020c2:	eb 23                	jmp    8020e7 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8020c4:	83 ec 08             	sub    $0x8,%esp
  8020c7:	ff 75 0c             	pushl  0xc(%ebp)
  8020ca:	6a 25                	push   $0x25
  8020cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8020cf:	ff d0                	call   *%eax
  8020d1:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8020d4:	ff 4d 10             	decl   0x10(%ebp)
  8020d7:	eb 03                	jmp    8020dc <vprintfmt+0x3b1>
  8020d9:	ff 4d 10             	decl   0x10(%ebp)
  8020dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8020df:	48                   	dec    %eax
  8020e0:	8a 00                	mov    (%eax),%al
  8020e2:	3c 25                	cmp    $0x25,%al
  8020e4:	75 f3                	jne    8020d9 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8020e6:	90                   	nop
		}
	}
  8020e7:	e9 47 fc ff ff       	jmp    801d33 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8020ec:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8020ed:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8020f0:	5b                   	pop    %ebx
  8020f1:	5e                   	pop    %esi
  8020f2:	5d                   	pop    %ebp
  8020f3:	c3                   	ret    

008020f4 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8020f4:	55                   	push   %ebp
  8020f5:	89 e5                	mov    %esp,%ebp
  8020f7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8020fa:	8d 45 10             	lea    0x10(%ebp),%eax
  8020fd:	83 c0 04             	add    $0x4,%eax
  802100:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  802103:	8b 45 10             	mov    0x10(%ebp),%eax
  802106:	ff 75 f4             	pushl  -0xc(%ebp)
  802109:	50                   	push   %eax
  80210a:	ff 75 0c             	pushl  0xc(%ebp)
  80210d:	ff 75 08             	pushl  0x8(%ebp)
  802110:	e8 16 fc ff ff       	call   801d2b <vprintfmt>
  802115:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  802118:	90                   	nop
  802119:	c9                   	leave  
  80211a:	c3                   	ret    

0080211b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80211b:	55                   	push   %ebp
  80211c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80211e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802121:	8b 40 08             	mov    0x8(%eax),%eax
  802124:	8d 50 01             	lea    0x1(%eax),%edx
  802127:	8b 45 0c             	mov    0xc(%ebp),%eax
  80212a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80212d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802130:	8b 10                	mov    (%eax),%edx
  802132:	8b 45 0c             	mov    0xc(%ebp),%eax
  802135:	8b 40 04             	mov    0x4(%eax),%eax
  802138:	39 c2                	cmp    %eax,%edx
  80213a:	73 12                	jae    80214e <sprintputch+0x33>
		*b->buf++ = ch;
  80213c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80213f:	8b 00                	mov    (%eax),%eax
  802141:	8d 48 01             	lea    0x1(%eax),%ecx
  802144:	8b 55 0c             	mov    0xc(%ebp),%edx
  802147:	89 0a                	mov    %ecx,(%edx)
  802149:	8b 55 08             	mov    0x8(%ebp),%edx
  80214c:	88 10                	mov    %dl,(%eax)
}
  80214e:	90                   	nop
  80214f:	5d                   	pop    %ebp
  802150:	c3                   	ret    

00802151 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  802151:	55                   	push   %ebp
  802152:	89 e5                	mov    %esp,%ebp
  802154:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  802157:	8b 45 08             	mov    0x8(%ebp),%eax
  80215a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80215d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802160:	8d 50 ff             	lea    -0x1(%eax),%edx
  802163:	8b 45 08             	mov    0x8(%ebp),%eax
  802166:	01 d0                	add    %edx,%eax
  802168:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80216b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  802172:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802176:	74 06                	je     80217e <vsnprintf+0x2d>
  802178:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80217c:	7f 07                	jg     802185 <vsnprintf+0x34>
		return -E_INVAL;
  80217e:	b8 03 00 00 00       	mov    $0x3,%eax
  802183:	eb 20                	jmp    8021a5 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  802185:	ff 75 14             	pushl  0x14(%ebp)
  802188:	ff 75 10             	pushl  0x10(%ebp)
  80218b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80218e:	50                   	push   %eax
  80218f:	68 1b 21 80 00       	push   $0x80211b
  802194:	e8 92 fb ff ff       	call   801d2b <vprintfmt>
  802199:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80219c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80219f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8021a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8021a5:	c9                   	leave  
  8021a6:	c3                   	ret    

008021a7 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8021a7:	55                   	push   %ebp
  8021a8:	89 e5                	mov    %esp,%ebp
  8021aa:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8021ad:	8d 45 10             	lea    0x10(%ebp),%eax
  8021b0:	83 c0 04             	add    $0x4,%eax
  8021b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8021b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8021b9:	ff 75 f4             	pushl  -0xc(%ebp)
  8021bc:	50                   	push   %eax
  8021bd:	ff 75 0c             	pushl  0xc(%ebp)
  8021c0:	ff 75 08             	pushl  0x8(%ebp)
  8021c3:	e8 89 ff ff ff       	call   802151 <vsnprintf>
  8021c8:	83 c4 10             	add    $0x10,%esp
  8021cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8021ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8021d1:	c9                   	leave  
  8021d2:	c3                   	ret    

008021d3 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8021d3:	55                   	push   %ebp
  8021d4:	89 e5                	mov    %esp,%ebp
  8021d6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8021d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8021e0:	eb 06                	jmp    8021e8 <strlen+0x15>
		n++;
  8021e2:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8021e5:	ff 45 08             	incl   0x8(%ebp)
  8021e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8021eb:	8a 00                	mov    (%eax),%al
  8021ed:	84 c0                	test   %al,%al
  8021ef:	75 f1                	jne    8021e2 <strlen+0xf>
		n++;
	return n;
  8021f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8021f4:	c9                   	leave  
  8021f5:	c3                   	ret    

008021f6 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8021f6:	55                   	push   %ebp
  8021f7:	89 e5                	mov    %esp,%ebp
  8021f9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8021fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802203:	eb 09                	jmp    80220e <strnlen+0x18>
		n++;
  802205:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  802208:	ff 45 08             	incl   0x8(%ebp)
  80220b:	ff 4d 0c             	decl   0xc(%ebp)
  80220e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802212:	74 09                	je     80221d <strnlen+0x27>
  802214:	8b 45 08             	mov    0x8(%ebp),%eax
  802217:	8a 00                	mov    (%eax),%al
  802219:	84 c0                	test   %al,%al
  80221b:	75 e8                	jne    802205 <strnlen+0xf>
		n++;
	return n;
  80221d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802220:	c9                   	leave  
  802221:	c3                   	ret    

00802222 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  802222:	55                   	push   %ebp
  802223:	89 e5                	mov    %esp,%ebp
  802225:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  802228:	8b 45 08             	mov    0x8(%ebp),%eax
  80222b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80222e:	90                   	nop
  80222f:	8b 45 08             	mov    0x8(%ebp),%eax
  802232:	8d 50 01             	lea    0x1(%eax),%edx
  802235:	89 55 08             	mov    %edx,0x8(%ebp)
  802238:	8b 55 0c             	mov    0xc(%ebp),%edx
  80223b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80223e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  802241:	8a 12                	mov    (%edx),%dl
  802243:	88 10                	mov    %dl,(%eax)
  802245:	8a 00                	mov    (%eax),%al
  802247:	84 c0                	test   %al,%al
  802249:	75 e4                	jne    80222f <strcpy+0xd>
		/* do nothing */;
	return ret;
  80224b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80224e:	c9                   	leave  
  80224f:	c3                   	ret    

00802250 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  802250:	55                   	push   %ebp
  802251:	89 e5                	mov    %esp,%ebp
  802253:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  802256:	8b 45 08             	mov    0x8(%ebp),%eax
  802259:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80225c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  802263:	eb 1f                	jmp    802284 <strncpy+0x34>
		*dst++ = *src;
  802265:	8b 45 08             	mov    0x8(%ebp),%eax
  802268:	8d 50 01             	lea    0x1(%eax),%edx
  80226b:	89 55 08             	mov    %edx,0x8(%ebp)
  80226e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802271:	8a 12                	mov    (%edx),%dl
  802273:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  802275:	8b 45 0c             	mov    0xc(%ebp),%eax
  802278:	8a 00                	mov    (%eax),%al
  80227a:	84 c0                	test   %al,%al
  80227c:	74 03                	je     802281 <strncpy+0x31>
			src++;
  80227e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  802281:	ff 45 fc             	incl   -0x4(%ebp)
  802284:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802287:	3b 45 10             	cmp    0x10(%ebp),%eax
  80228a:	72 d9                	jb     802265 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80228c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80228f:	c9                   	leave  
  802290:	c3                   	ret    

00802291 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  802291:	55                   	push   %ebp
  802292:	89 e5                	mov    %esp,%ebp
  802294:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  802297:	8b 45 08             	mov    0x8(%ebp),%eax
  80229a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80229d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8022a1:	74 30                	je     8022d3 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8022a3:	eb 16                	jmp    8022bb <strlcpy+0x2a>
			*dst++ = *src++;
  8022a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8022a8:	8d 50 01             	lea    0x1(%eax),%edx
  8022ab:	89 55 08             	mov    %edx,0x8(%ebp)
  8022ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022b1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8022b4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8022b7:	8a 12                	mov    (%edx),%dl
  8022b9:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8022bb:	ff 4d 10             	decl   0x10(%ebp)
  8022be:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8022c2:	74 09                	je     8022cd <strlcpy+0x3c>
  8022c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8022c7:	8a 00                	mov    (%eax),%al
  8022c9:	84 c0                	test   %al,%al
  8022cb:	75 d8                	jne    8022a5 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8022cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8022d0:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8022d3:	8b 55 08             	mov    0x8(%ebp),%edx
  8022d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8022d9:	29 c2                	sub    %eax,%edx
  8022db:	89 d0                	mov    %edx,%eax
}
  8022dd:	c9                   	leave  
  8022de:	c3                   	ret    

008022df <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8022df:	55                   	push   %ebp
  8022e0:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8022e2:	eb 06                	jmp    8022ea <strcmp+0xb>
		p++, q++;
  8022e4:	ff 45 08             	incl   0x8(%ebp)
  8022e7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8022ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ed:	8a 00                	mov    (%eax),%al
  8022ef:	84 c0                	test   %al,%al
  8022f1:	74 0e                	je     802301 <strcmp+0x22>
  8022f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8022f6:	8a 10                	mov    (%eax),%dl
  8022f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8022fb:	8a 00                	mov    (%eax),%al
  8022fd:	38 c2                	cmp    %al,%dl
  8022ff:	74 e3                	je     8022e4 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  802301:	8b 45 08             	mov    0x8(%ebp),%eax
  802304:	8a 00                	mov    (%eax),%al
  802306:	0f b6 d0             	movzbl %al,%edx
  802309:	8b 45 0c             	mov    0xc(%ebp),%eax
  80230c:	8a 00                	mov    (%eax),%al
  80230e:	0f b6 c0             	movzbl %al,%eax
  802311:	29 c2                	sub    %eax,%edx
  802313:	89 d0                	mov    %edx,%eax
}
  802315:	5d                   	pop    %ebp
  802316:	c3                   	ret    

00802317 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  802317:	55                   	push   %ebp
  802318:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80231a:	eb 09                	jmp    802325 <strncmp+0xe>
		n--, p++, q++;
  80231c:	ff 4d 10             	decl   0x10(%ebp)
  80231f:	ff 45 08             	incl   0x8(%ebp)
  802322:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  802325:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802329:	74 17                	je     802342 <strncmp+0x2b>
  80232b:	8b 45 08             	mov    0x8(%ebp),%eax
  80232e:	8a 00                	mov    (%eax),%al
  802330:	84 c0                	test   %al,%al
  802332:	74 0e                	je     802342 <strncmp+0x2b>
  802334:	8b 45 08             	mov    0x8(%ebp),%eax
  802337:	8a 10                	mov    (%eax),%dl
  802339:	8b 45 0c             	mov    0xc(%ebp),%eax
  80233c:	8a 00                	mov    (%eax),%al
  80233e:	38 c2                	cmp    %al,%dl
  802340:	74 da                	je     80231c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  802342:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802346:	75 07                	jne    80234f <strncmp+0x38>
		return 0;
  802348:	b8 00 00 00 00       	mov    $0x0,%eax
  80234d:	eb 14                	jmp    802363 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80234f:	8b 45 08             	mov    0x8(%ebp),%eax
  802352:	8a 00                	mov    (%eax),%al
  802354:	0f b6 d0             	movzbl %al,%edx
  802357:	8b 45 0c             	mov    0xc(%ebp),%eax
  80235a:	8a 00                	mov    (%eax),%al
  80235c:	0f b6 c0             	movzbl %al,%eax
  80235f:	29 c2                	sub    %eax,%edx
  802361:	89 d0                	mov    %edx,%eax
}
  802363:	5d                   	pop    %ebp
  802364:	c3                   	ret    

00802365 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  802365:	55                   	push   %ebp
  802366:	89 e5                	mov    %esp,%ebp
  802368:	83 ec 04             	sub    $0x4,%esp
  80236b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80236e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802371:	eb 12                	jmp    802385 <strchr+0x20>
		if (*s == c)
  802373:	8b 45 08             	mov    0x8(%ebp),%eax
  802376:	8a 00                	mov    (%eax),%al
  802378:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80237b:	75 05                	jne    802382 <strchr+0x1d>
			return (char *) s;
  80237d:	8b 45 08             	mov    0x8(%ebp),%eax
  802380:	eb 11                	jmp    802393 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  802382:	ff 45 08             	incl   0x8(%ebp)
  802385:	8b 45 08             	mov    0x8(%ebp),%eax
  802388:	8a 00                	mov    (%eax),%al
  80238a:	84 c0                	test   %al,%al
  80238c:	75 e5                	jne    802373 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80238e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802393:	c9                   	leave  
  802394:	c3                   	ret    

00802395 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  802395:	55                   	push   %ebp
  802396:	89 e5                	mov    %esp,%ebp
  802398:	83 ec 04             	sub    $0x4,%esp
  80239b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80239e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8023a1:	eb 0d                	jmp    8023b0 <strfind+0x1b>
		if (*s == c)
  8023a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8023a6:	8a 00                	mov    (%eax),%al
  8023a8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8023ab:	74 0e                	je     8023bb <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8023ad:	ff 45 08             	incl   0x8(%ebp)
  8023b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8023b3:	8a 00                	mov    (%eax),%al
  8023b5:	84 c0                	test   %al,%al
  8023b7:	75 ea                	jne    8023a3 <strfind+0xe>
  8023b9:	eb 01                	jmp    8023bc <strfind+0x27>
		if (*s == c)
			break;
  8023bb:	90                   	nop
	return (char *) s;
  8023bc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8023bf:	c9                   	leave  
  8023c0:	c3                   	ret    

008023c1 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8023c1:	55                   	push   %ebp
  8023c2:	89 e5                	mov    %esp,%ebp
  8023c4:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8023c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ca:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8023cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8023d0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8023d3:	eb 0e                	jmp    8023e3 <memset+0x22>
		*p++ = c;
  8023d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8023d8:	8d 50 01             	lea    0x1(%eax),%edx
  8023db:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8023de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023e1:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8023e3:	ff 4d f8             	decl   -0x8(%ebp)
  8023e6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8023ea:	79 e9                	jns    8023d5 <memset+0x14>
		*p++ = c;

	return v;
  8023ec:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8023ef:	c9                   	leave  
  8023f0:	c3                   	ret    

008023f1 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8023f1:	55                   	push   %ebp
  8023f2:	89 e5                	mov    %esp,%ebp
  8023f4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8023f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8023fd:	8b 45 08             	mov    0x8(%ebp),%eax
  802400:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  802403:	eb 16                	jmp    80241b <memcpy+0x2a>
		*d++ = *s++;
  802405:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802408:	8d 50 01             	lea    0x1(%eax),%edx
  80240b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80240e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802411:	8d 4a 01             	lea    0x1(%edx),%ecx
  802414:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  802417:	8a 12                	mov    (%edx),%dl
  802419:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80241b:	8b 45 10             	mov    0x10(%ebp),%eax
  80241e:	8d 50 ff             	lea    -0x1(%eax),%edx
  802421:	89 55 10             	mov    %edx,0x10(%ebp)
  802424:	85 c0                	test   %eax,%eax
  802426:	75 dd                	jne    802405 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  802428:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80242b:	c9                   	leave  
  80242c:	c3                   	ret    

0080242d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80242d:	55                   	push   %ebp
  80242e:	89 e5                	mov    %esp,%ebp
  802430:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  802433:	8b 45 0c             	mov    0xc(%ebp),%eax
  802436:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  802439:	8b 45 08             	mov    0x8(%ebp),%eax
  80243c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80243f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802442:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  802445:	73 50                	jae    802497 <memmove+0x6a>
  802447:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80244a:	8b 45 10             	mov    0x10(%ebp),%eax
  80244d:	01 d0                	add    %edx,%eax
  80244f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  802452:	76 43                	jbe    802497 <memmove+0x6a>
		s += n;
  802454:	8b 45 10             	mov    0x10(%ebp),%eax
  802457:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80245a:	8b 45 10             	mov    0x10(%ebp),%eax
  80245d:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  802460:	eb 10                	jmp    802472 <memmove+0x45>
			*--d = *--s;
  802462:	ff 4d f8             	decl   -0x8(%ebp)
  802465:	ff 4d fc             	decl   -0x4(%ebp)
  802468:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80246b:	8a 10                	mov    (%eax),%dl
  80246d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802470:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  802472:	8b 45 10             	mov    0x10(%ebp),%eax
  802475:	8d 50 ff             	lea    -0x1(%eax),%edx
  802478:	89 55 10             	mov    %edx,0x10(%ebp)
  80247b:	85 c0                	test   %eax,%eax
  80247d:	75 e3                	jne    802462 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80247f:	eb 23                	jmp    8024a4 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  802481:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802484:	8d 50 01             	lea    0x1(%eax),%edx
  802487:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80248a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80248d:	8d 4a 01             	lea    0x1(%edx),%ecx
  802490:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  802493:	8a 12                	mov    (%edx),%dl
  802495:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  802497:	8b 45 10             	mov    0x10(%ebp),%eax
  80249a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80249d:	89 55 10             	mov    %edx,0x10(%ebp)
  8024a0:	85 c0                	test   %eax,%eax
  8024a2:	75 dd                	jne    802481 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8024a4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8024a7:	c9                   	leave  
  8024a8:	c3                   	ret    

008024a9 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8024a9:	55                   	push   %ebp
  8024aa:	89 e5                	mov    %esp,%ebp
  8024ac:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8024af:	8b 45 08             	mov    0x8(%ebp),%eax
  8024b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8024b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8024b8:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8024bb:	eb 2a                	jmp    8024e7 <memcmp+0x3e>
		if (*s1 != *s2)
  8024bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8024c0:	8a 10                	mov    (%eax),%dl
  8024c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8024c5:	8a 00                	mov    (%eax),%al
  8024c7:	38 c2                	cmp    %al,%dl
  8024c9:	74 16                	je     8024e1 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8024cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8024ce:	8a 00                	mov    (%eax),%al
  8024d0:	0f b6 d0             	movzbl %al,%edx
  8024d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8024d6:	8a 00                	mov    (%eax),%al
  8024d8:	0f b6 c0             	movzbl %al,%eax
  8024db:	29 c2                	sub    %eax,%edx
  8024dd:	89 d0                	mov    %edx,%eax
  8024df:	eb 18                	jmp    8024f9 <memcmp+0x50>
		s1++, s2++;
  8024e1:	ff 45 fc             	incl   -0x4(%ebp)
  8024e4:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8024e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8024ea:	8d 50 ff             	lea    -0x1(%eax),%edx
  8024ed:	89 55 10             	mov    %edx,0x10(%ebp)
  8024f0:	85 c0                	test   %eax,%eax
  8024f2:	75 c9                	jne    8024bd <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8024f4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8024f9:	c9                   	leave  
  8024fa:	c3                   	ret    

008024fb <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8024fb:	55                   	push   %ebp
  8024fc:	89 e5                	mov    %esp,%ebp
  8024fe:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  802501:	8b 55 08             	mov    0x8(%ebp),%edx
  802504:	8b 45 10             	mov    0x10(%ebp),%eax
  802507:	01 d0                	add    %edx,%eax
  802509:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80250c:	eb 15                	jmp    802523 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80250e:	8b 45 08             	mov    0x8(%ebp),%eax
  802511:	8a 00                	mov    (%eax),%al
  802513:	0f b6 d0             	movzbl %al,%edx
  802516:	8b 45 0c             	mov    0xc(%ebp),%eax
  802519:	0f b6 c0             	movzbl %al,%eax
  80251c:	39 c2                	cmp    %eax,%edx
  80251e:	74 0d                	je     80252d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  802520:	ff 45 08             	incl   0x8(%ebp)
  802523:	8b 45 08             	mov    0x8(%ebp),%eax
  802526:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  802529:	72 e3                	jb     80250e <memfind+0x13>
  80252b:	eb 01                	jmp    80252e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80252d:	90                   	nop
	return (void *) s;
  80252e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802531:	c9                   	leave  
  802532:	c3                   	ret    

00802533 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  802533:	55                   	push   %ebp
  802534:	89 e5                	mov    %esp,%ebp
  802536:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  802539:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  802540:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  802547:	eb 03                	jmp    80254c <strtol+0x19>
		s++;
  802549:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80254c:	8b 45 08             	mov    0x8(%ebp),%eax
  80254f:	8a 00                	mov    (%eax),%al
  802551:	3c 20                	cmp    $0x20,%al
  802553:	74 f4                	je     802549 <strtol+0x16>
  802555:	8b 45 08             	mov    0x8(%ebp),%eax
  802558:	8a 00                	mov    (%eax),%al
  80255a:	3c 09                	cmp    $0x9,%al
  80255c:	74 eb                	je     802549 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80255e:	8b 45 08             	mov    0x8(%ebp),%eax
  802561:	8a 00                	mov    (%eax),%al
  802563:	3c 2b                	cmp    $0x2b,%al
  802565:	75 05                	jne    80256c <strtol+0x39>
		s++;
  802567:	ff 45 08             	incl   0x8(%ebp)
  80256a:	eb 13                	jmp    80257f <strtol+0x4c>
	else if (*s == '-')
  80256c:	8b 45 08             	mov    0x8(%ebp),%eax
  80256f:	8a 00                	mov    (%eax),%al
  802571:	3c 2d                	cmp    $0x2d,%al
  802573:	75 0a                	jne    80257f <strtol+0x4c>
		s++, neg = 1;
  802575:	ff 45 08             	incl   0x8(%ebp)
  802578:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80257f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802583:	74 06                	je     80258b <strtol+0x58>
  802585:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  802589:	75 20                	jne    8025ab <strtol+0x78>
  80258b:	8b 45 08             	mov    0x8(%ebp),%eax
  80258e:	8a 00                	mov    (%eax),%al
  802590:	3c 30                	cmp    $0x30,%al
  802592:	75 17                	jne    8025ab <strtol+0x78>
  802594:	8b 45 08             	mov    0x8(%ebp),%eax
  802597:	40                   	inc    %eax
  802598:	8a 00                	mov    (%eax),%al
  80259a:	3c 78                	cmp    $0x78,%al
  80259c:	75 0d                	jne    8025ab <strtol+0x78>
		s += 2, base = 16;
  80259e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8025a2:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8025a9:	eb 28                	jmp    8025d3 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8025ab:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8025af:	75 15                	jne    8025c6 <strtol+0x93>
  8025b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8025b4:	8a 00                	mov    (%eax),%al
  8025b6:	3c 30                	cmp    $0x30,%al
  8025b8:	75 0c                	jne    8025c6 <strtol+0x93>
		s++, base = 8;
  8025ba:	ff 45 08             	incl   0x8(%ebp)
  8025bd:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8025c4:	eb 0d                	jmp    8025d3 <strtol+0xa0>
	else if (base == 0)
  8025c6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8025ca:	75 07                	jne    8025d3 <strtol+0xa0>
		base = 10;
  8025cc:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8025d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8025d6:	8a 00                	mov    (%eax),%al
  8025d8:	3c 2f                	cmp    $0x2f,%al
  8025da:	7e 19                	jle    8025f5 <strtol+0xc2>
  8025dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8025df:	8a 00                	mov    (%eax),%al
  8025e1:	3c 39                	cmp    $0x39,%al
  8025e3:	7f 10                	jg     8025f5 <strtol+0xc2>
			dig = *s - '0';
  8025e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8025e8:	8a 00                	mov    (%eax),%al
  8025ea:	0f be c0             	movsbl %al,%eax
  8025ed:	83 e8 30             	sub    $0x30,%eax
  8025f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8025f3:	eb 42                	jmp    802637 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8025f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8025f8:	8a 00                	mov    (%eax),%al
  8025fa:	3c 60                	cmp    $0x60,%al
  8025fc:	7e 19                	jle    802617 <strtol+0xe4>
  8025fe:	8b 45 08             	mov    0x8(%ebp),%eax
  802601:	8a 00                	mov    (%eax),%al
  802603:	3c 7a                	cmp    $0x7a,%al
  802605:	7f 10                	jg     802617 <strtol+0xe4>
			dig = *s - 'a' + 10;
  802607:	8b 45 08             	mov    0x8(%ebp),%eax
  80260a:	8a 00                	mov    (%eax),%al
  80260c:	0f be c0             	movsbl %al,%eax
  80260f:	83 e8 57             	sub    $0x57,%eax
  802612:	89 45 f4             	mov    %eax,-0xc(%ebp)
  802615:	eb 20                	jmp    802637 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  802617:	8b 45 08             	mov    0x8(%ebp),%eax
  80261a:	8a 00                	mov    (%eax),%al
  80261c:	3c 40                	cmp    $0x40,%al
  80261e:	7e 39                	jle    802659 <strtol+0x126>
  802620:	8b 45 08             	mov    0x8(%ebp),%eax
  802623:	8a 00                	mov    (%eax),%al
  802625:	3c 5a                	cmp    $0x5a,%al
  802627:	7f 30                	jg     802659 <strtol+0x126>
			dig = *s - 'A' + 10;
  802629:	8b 45 08             	mov    0x8(%ebp),%eax
  80262c:	8a 00                	mov    (%eax),%al
  80262e:	0f be c0             	movsbl %al,%eax
  802631:	83 e8 37             	sub    $0x37,%eax
  802634:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  802637:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80263a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80263d:	7d 19                	jge    802658 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80263f:	ff 45 08             	incl   0x8(%ebp)
  802642:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802645:	0f af 45 10          	imul   0x10(%ebp),%eax
  802649:	89 c2                	mov    %eax,%edx
  80264b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80264e:	01 d0                	add    %edx,%eax
  802650:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  802653:	e9 7b ff ff ff       	jmp    8025d3 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  802658:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  802659:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80265d:	74 08                	je     802667 <strtol+0x134>
		*endptr = (char *) s;
  80265f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802662:	8b 55 08             	mov    0x8(%ebp),%edx
  802665:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  802667:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80266b:	74 07                	je     802674 <strtol+0x141>
  80266d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802670:	f7 d8                	neg    %eax
  802672:	eb 03                	jmp    802677 <strtol+0x144>
  802674:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  802677:	c9                   	leave  
  802678:	c3                   	ret    

00802679 <ltostr>:

void
ltostr(long value, char *str)
{
  802679:	55                   	push   %ebp
  80267a:	89 e5                	mov    %esp,%ebp
  80267c:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80267f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  802686:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80268d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  802691:	79 13                	jns    8026a6 <ltostr+0x2d>
	{
		neg = 1;
  802693:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80269a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80269d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8026a0:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8026a3:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8026a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8026a9:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8026ae:	99                   	cltd   
  8026af:	f7 f9                	idiv   %ecx
  8026b1:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8026b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8026b7:	8d 50 01             	lea    0x1(%eax),%edx
  8026ba:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8026bd:	89 c2                	mov    %eax,%edx
  8026bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8026c2:	01 d0                	add    %edx,%eax
  8026c4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8026c7:	83 c2 30             	add    $0x30,%edx
  8026ca:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8026cc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8026cf:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8026d4:	f7 e9                	imul   %ecx
  8026d6:	c1 fa 02             	sar    $0x2,%edx
  8026d9:	89 c8                	mov    %ecx,%eax
  8026db:	c1 f8 1f             	sar    $0x1f,%eax
  8026de:	29 c2                	sub    %eax,%edx
  8026e0:	89 d0                	mov    %edx,%eax
  8026e2:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8026e5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8026e8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8026ed:	f7 e9                	imul   %ecx
  8026ef:	c1 fa 02             	sar    $0x2,%edx
  8026f2:	89 c8                	mov    %ecx,%eax
  8026f4:	c1 f8 1f             	sar    $0x1f,%eax
  8026f7:	29 c2                	sub    %eax,%edx
  8026f9:	89 d0                	mov    %edx,%eax
  8026fb:	c1 e0 02             	shl    $0x2,%eax
  8026fe:	01 d0                	add    %edx,%eax
  802700:	01 c0                	add    %eax,%eax
  802702:	29 c1                	sub    %eax,%ecx
  802704:	89 ca                	mov    %ecx,%edx
  802706:	85 d2                	test   %edx,%edx
  802708:	75 9c                	jne    8026a6 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80270a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  802711:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802714:	48                   	dec    %eax
  802715:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  802718:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80271c:	74 3d                	je     80275b <ltostr+0xe2>
		start = 1 ;
  80271e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  802725:	eb 34                	jmp    80275b <ltostr+0xe2>
	{
		char tmp = str[start] ;
  802727:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80272a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80272d:	01 d0                	add    %edx,%eax
  80272f:	8a 00                	mov    (%eax),%al
  802731:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  802734:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802737:	8b 45 0c             	mov    0xc(%ebp),%eax
  80273a:	01 c2                	add    %eax,%edx
  80273c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80273f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802742:	01 c8                	add    %ecx,%eax
  802744:	8a 00                	mov    (%eax),%al
  802746:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  802748:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80274b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80274e:	01 c2                	add    %eax,%edx
  802750:	8a 45 eb             	mov    -0x15(%ebp),%al
  802753:	88 02                	mov    %al,(%edx)
		start++ ;
  802755:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  802758:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80275b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80275e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802761:	7c c4                	jl     802727 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  802763:	8b 55 f8             	mov    -0x8(%ebp),%edx
  802766:	8b 45 0c             	mov    0xc(%ebp),%eax
  802769:	01 d0                	add    %edx,%eax
  80276b:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80276e:	90                   	nop
  80276f:	c9                   	leave  
  802770:	c3                   	ret    

00802771 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  802771:	55                   	push   %ebp
  802772:	89 e5                	mov    %esp,%ebp
  802774:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  802777:	ff 75 08             	pushl  0x8(%ebp)
  80277a:	e8 54 fa ff ff       	call   8021d3 <strlen>
  80277f:	83 c4 04             	add    $0x4,%esp
  802782:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  802785:	ff 75 0c             	pushl  0xc(%ebp)
  802788:	e8 46 fa ff ff       	call   8021d3 <strlen>
  80278d:	83 c4 04             	add    $0x4,%esp
  802790:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  802793:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80279a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8027a1:	eb 17                	jmp    8027ba <strcconcat+0x49>
		final[s] = str1[s] ;
  8027a3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8027a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8027a9:	01 c2                	add    %eax,%edx
  8027ab:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8027ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8027b1:	01 c8                	add    %ecx,%eax
  8027b3:	8a 00                	mov    (%eax),%al
  8027b5:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8027b7:	ff 45 fc             	incl   -0x4(%ebp)
  8027ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8027bd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8027c0:	7c e1                	jl     8027a3 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8027c2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8027c9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8027d0:	eb 1f                	jmp    8027f1 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8027d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8027d5:	8d 50 01             	lea    0x1(%eax),%edx
  8027d8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8027db:	89 c2                	mov    %eax,%edx
  8027dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8027e0:	01 c2                	add    %eax,%edx
  8027e2:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8027e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8027e8:	01 c8                	add    %ecx,%eax
  8027ea:	8a 00                	mov    (%eax),%al
  8027ec:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8027ee:	ff 45 f8             	incl   -0x8(%ebp)
  8027f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8027f4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8027f7:	7c d9                	jl     8027d2 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8027f9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8027fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8027ff:	01 d0                	add    %edx,%eax
  802801:	c6 00 00             	movb   $0x0,(%eax)
}
  802804:	90                   	nop
  802805:	c9                   	leave  
  802806:	c3                   	ret    

00802807 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  802807:	55                   	push   %ebp
  802808:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80280a:	8b 45 14             	mov    0x14(%ebp),%eax
  80280d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  802813:	8b 45 14             	mov    0x14(%ebp),%eax
  802816:	8b 00                	mov    (%eax),%eax
  802818:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80281f:	8b 45 10             	mov    0x10(%ebp),%eax
  802822:	01 d0                	add    %edx,%eax
  802824:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80282a:	eb 0c                	jmp    802838 <strsplit+0x31>
			*string++ = 0;
  80282c:	8b 45 08             	mov    0x8(%ebp),%eax
  80282f:	8d 50 01             	lea    0x1(%eax),%edx
  802832:	89 55 08             	mov    %edx,0x8(%ebp)
  802835:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  802838:	8b 45 08             	mov    0x8(%ebp),%eax
  80283b:	8a 00                	mov    (%eax),%al
  80283d:	84 c0                	test   %al,%al
  80283f:	74 18                	je     802859 <strsplit+0x52>
  802841:	8b 45 08             	mov    0x8(%ebp),%eax
  802844:	8a 00                	mov    (%eax),%al
  802846:	0f be c0             	movsbl %al,%eax
  802849:	50                   	push   %eax
  80284a:	ff 75 0c             	pushl  0xc(%ebp)
  80284d:	e8 13 fb ff ff       	call   802365 <strchr>
  802852:	83 c4 08             	add    $0x8,%esp
  802855:	85 c0                	test   %eax,%eax
  802857:	75 d3                	jne    80282c <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  802859:	8b 45 08             	mov    0x8(%ebp),%eax
  80285c:	8a 00                	mov    (%eax),%al
  80285e:	84 c0                	test   %al,%al
  802860:	74 5a                	je     8028bc <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  802862:	8b 45 14             	mov    0x14(%ebp),%eax
  802865:	8b 00                	mov    (%eax),%eax
  802867:	83 f8 0f             	cmp    $0xf,%eax
  80286a:	75 07                	jne    802873 <strsplit+0x6c>
		{
			return 0;
  80286c:	b8 00 00 00 00       	mov    $0x0,%eax
  802871:	eb 66                	jmp    8028d9 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  802873:	8b 45 14             	mov    0x14(%ebp),%eax
  802876:	8b 00                	mov    (%eax),%eax
  802878:	8d 48 01             	lea    0x1(%eax),%ecx
  80287b:	8b 55 14             	mov    0x14(%ebp),%edx
  80287e:	89 0a                	mov    %ecx,(%edx)
  802880:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802887:	8b 45 10             	mov    0x10(%ebp),%eax
  80288a:	01 c2                	add    %eax,%edx
  80288c:	8b 45 08             	mov    0x8(%ebp),%eax
  80288f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  802891:	eb 03                	jmp    802896 <strsplit+0x8f>
			string++;
  802893:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  802896:	8b 45 08             	mov    0x8(%ebp),%eax
  802899:	8a 00                	mov    (%eax),%al
  80289b:	84 c0                	test   %al,%al
  80289d:	74 8b                	je     80282a <strsplit+0x23>
  80289f:	8b 45 08             	mov    0x8(%ebp),%eax
  8028a2:	8a 00                	mov    (%eax),%al
  8028a4:	0f be c0             	movsbl %al,%eax
  8028a7:	50                   	push   %eax
  8028a8:	ff 75 0c             	pushl  0xc(%ebp)
  8028ab:	e8 b5 fa ff ff       	call   802365 <strchr>
  8028b0:	83 c4 08             	add    $0x8,%esp
  8028b3:	85 c0                	test   %eax,%eax
  8028b5:	74 dc                	je     802893 <strsplit+0x8c>
			string++;
	}
  8028b7:	e9 6e ff ff ff       	jmp    80282a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8028bc:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8028bd:	8b 45 14             	mov    0x14(%ebp),%eax
  8028c0:	8b 00                	mov    (%eax),%eax
  8028c2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8028c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8028cc:	01 d0                	add    %edx,%eax
  8028ce:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8028d4:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8028d9:	c9                   	leave  
  8028da:	c3                   	ret    

008028db <malloc>:
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
  8028db:	55                   	push   %ebp
  8028dc:	89 e5                	mov    %esp,%ebp
  8028de:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  8028e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8028e4:	c1 e8 0c             	shr    $0xc,%eax
  8028e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  8028ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8028ed:	25 ff 0f 00 00       	and    $0xfff,%eax
  8028f2:	85 c0                	test   %eax,%eax
  8028f4:	74 03                	je     8028f9 <malloc+0x1e>
			num++;
  8028f6:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  8028f9:	a1 04 40 80 00       	mov    0x804004,%eax
  8028fe:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  802903:	75 73                	jne    802978 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  802905:	83 ec 08             	sub    $0x8,%esp
  802908:	ff 75 08             	pushl  0x8(%ebp)
  80290b:	68 00 00 00 80       	push   $0x80000000
  802910:	e8 14 05 00 00       	call   802e29 <sys_allocateMem>
  802915:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  802918:	a1 04 40 80 00       	mov    0x804004,%eax
  80291d:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  802920:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802923:	c1 e0 0c             	shl    $0xc,%eax
  802926:	89 c2                	mov    %eax,%edx
  802928:	a1 04 40 80 00       	mov    0x804004,%eax
  80292d:	01 d0                	add    %edx,%eax
  80292f:	a3 04 40 80 00       	mov    %eax,0x804004
			numOfPages[sizeofarray]=num;
  802934:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802939:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80293c:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
			addresses[sizeofarray]=last_addres;
  802943:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802948:	8b 15 04 40 80 00    	mov    0x804004,%edx
  80294e:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
			changed[sizeofarray]=1;
  802955:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80295a:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  802961:	01 00 00 00 
			sizeofarray++;
  802965:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80296a:	40                   	inc    %eax
  80296b:	a3 2c 40 80 00       	mov    %eax,0x80402c
			return (void*)return_addres;
  802970:	8b 45 d8             	mov    -0x28(%ebp),%eax
  802973:	e9 71 01 00 00       	jmp    802ae9 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  802978:	a1 28 40 80 00       	mov    0x804028,%eax
  80297d:	85 c0                	test   %eax,%eax
  80297f:	75 71                	jne    8029f2 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  802981:	a1 04 40 80 00       	mov    0x804004,%eax
  802986:	83 ec 08             	sub    $0x8,%esp
  802989:	ff 75 08             	pushl  0x8(%ebp)
  80298c:	50                   	push   %eax
  80298d:	e8 97 04 00 00       	call   802e29 <sys_allocateMem>
  802992:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  802995:	a1 04 40 80 00       	mov    0x804004,%eax
  80299a:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  80299d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8029a0:	c1 e0 0c             	shl    $0xc,%eax
  8029a3:	89 c2                	mov    %eax,%edx
  8029a5:	a1 04 40 80 00       	mov    0x804004,%eax
  8029aa:	01 d0                	add    %edx,%eax
  8029ac:	a3 04 40 80 00       	mov    %eax,0x804004
				numOfPages[sizeofarray]=num;
  8029b1:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8029b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8029b9:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
				addresses[sizeofarray]=return_addres;
  8029c0:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8029c5:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8029c8:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				changed[sizeofarray]=1;
  8029cf:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8029d4:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  8029db:	01 00 00 00 
				sizeofarray++;
  8029df:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8029e4:	40                   	inc    %eax
  8029e5:	a3 2c 40 80 00       	mov    %eax,0x80402c
				return (void*)return_addres;
  8029ea:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8029ed:	e9 f7 00 00 00       	jmp    802ae9 <malloc+0x20e>
			}
			else{
				int count=0;
  8029f2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  8029f9:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  802a00:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  802a07:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  802a0e:	eb 7c                	jmp    802a8c <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  802a10:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  802a17:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  802a1e:	eb 1a                	jmp    802a3a <malloc+0x15f>
					{
						if(addresses[j]==i)
  802a20:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802a23:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802a2a:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  802a2d:	75 08                	jne    802a37 <malloc+0x15c>
						{
							index=j;
  802a2f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802a32:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  802a35:	eb 0d                	jmp    802a44 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  802a37:	ff 45 dc             	incl   -0x24(%ebp)
  802a3a:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802a3f:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  802a42:	7c dc                	jl     802a20 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  802a44:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  802a48:	75 05                	jne    802a4f <malloc+0x174>
					{
						count++;
  802a4a:	ff 45 f0             	incl   -0x10(%ebp)
  802a4d:	eb 36                	jmp    802a85 <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  802a4f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802a52:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  802a59:	85 c0                	test   %eax,%eax
  802a5b:	75 05                	jne    802a62 <malloc+0x187>
						{
							count++;
  802a5d:	ff 45 f0             	incl   -0x10(%ebp)
  802a60:	eb 23                	jmp    802a85 <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  802a62:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802a65:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  802a68:	7d 14                	jge    802a7e <malloc+0x1a3>
  802a6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802a6d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  802a70:	7c 0c                	jl     802a7e <malloc+0x1a3>
							{
								min=count;
  802a72:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802a75:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  802a78:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802a7b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  802a7e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  802a85:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  802a8c:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  802a93:	0f 86 77 ff ff ff    	jbe    802a10 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  802a99:	83 ec 08             	sub    $0x8,%esp
  802a9c:	ff 75 08             	pushl  0x8(%ebp)
  802a9f:	ff 75 e4             	pushl  -0x1c(%ebp)
  802aa2:	e8 82 03 00 00       	call   802e29 <sys_allocateMem>
  802aa7:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  802aaa:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802aaf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802ab2:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
				addresses[sizeofarray]=last_addres;
  802ab9:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802abe:	8b 15 04 40 80 00    	mov    0x804004,%edx
  802ac4:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				changed[sizeofarray]=1;
  802acb:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802ad0:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  802ad7:	01 00 00 00 
				sizeofarray++;
  802adb:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802ae0:	40                   	inc    %eax
  802ae1:	a3 2c 40 80 00       	mov    %eax,0x80402c
				return(void*) min_addresss;
  802ae6:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  802ae9:	c9                   	leave  
  802aea:	c3                   	ret    

00802aeb <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  802aeb:	55                   	push   %ebp
  802aec:	89 e5                	mov    %esp,%ebp
  802aee:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  802af1:	8b 45 08             	mov    0x8(%ebp),%eax
  802af4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    int size;
    int is_found=0;
  802af7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  802afe:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  802b05:	eb 30                	jmp    802b37 <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  802b07:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802b0a:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  802b11:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  802b14:	75 1e                	jne    802b34 <free+0x49>
  802b16:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802b19:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  802b20:	83 f8 01             	cmp    $0x1,%eax
  802b23:	75 0f                	jne    802b34 <free+0x49>
    		is_found=1;
  802b25:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  802b2c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802b2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  802b32:	eb 0d                	jmp    802b41 <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    int size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  802b34:	ff 45 ec             	incl   -0x14(%ebp)
  802b37:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802b3c:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  802b3f:	7c c6                	jl     802b07 <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  802b41:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  802b45:	75 3b                	jne    802b82 <free+0x97>
    	size=numOfPages[index]*PAGE_SIZE;
  802b47:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802b4a:	8b 04 85 20 76 8c 00 	mov    0x8c7620(,%eax,4),%eax
  802b51:	c1 e0 0c             	shl    $0xc,%eax
  802b54:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  802b57:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  802b5a:	83 ec 08             	sub    $0x8,%esp
  802b5d:	50                   	push   %eax
  802b5e:	ff 75 e8             	pushl  -0x18(%ebp)
  802b61:	e8 a7 02 00 00       	call   802e0d <sys_freeMem>
  802b66:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  802b69:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802b6c:	c7 04 85 a0 5b 86 00 	movl   $0x0,0x865ba0(,%eax,4)
  802b73:	00 00 00 00 
    	changes++;
  802b77:	a1 28 40 80 00       	mov    0x804028,%eax
  802b7c:	40                   	inc    %eax
  802b7d:	a3 28 40 80 00       	mov    %eax,0x804028
    }


	//refer to the project presentation and documentation for details
}
  802b82:	90                   	nop
  802b83:	c9                   	leave  
  802b84:	c3                   	ret    

00802b85 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  802b85:	55                   	push   %ebp
  802b86:	89 e5                	mov    %esp,%ebp
  802b88:	83 ec 18             	sub    $0x18,%esp
  802b8b:	8b 45 10             	mov    0x10(%ebp),%eax
  802b8e:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  802b91:	83 ec 04             	sub    $0x4,%esp
  802b94:	68 d0 3d 80 00       	push   $0x803dd0
  802b99:	68 9f 00 00 00       	push   $0x9f
  802b9e:	68 f3 3d 80 00       	push   $0x803df3
  802ba3:	e8 07 ed ff ff       	call   8018af <_panic>

00802ba8 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  802ba8:	55                   	push   %ebp
  802ba9:	89 e5                	mov    %esp,%ebp
  802bab:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802bae:	83 ec 04             	sub    $0x4,%esp
  802bb1:	68 d0 3d 80 00       	push   $0x803dd0
  802bb6:	68 a5 00 00 00       	push   $0xa5
  802bbb:	68 f3 3d 80 00       	push   $0x803df3
  802bc0:	e8 ea ec ff ff       	call   8018af <_panic>

00802bc5 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  802bc5:	55                   	push   %ebp
  802bc6:	89 e5                	mov    %esp,%ebp
  802bc8:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802bcb:	83 ec 04             	sub    $0x4,%esp
  802bce:	68 d0 3d 80 00       	push   $0x803dd0
  802bd3:	68 ab 00 00 00       	push   $0xab
  802bd8:	68 f3 3d 80 00       	push   $0x803df3
  802bdd:	e8 cd ec ff ff       	call   8018af <_panic>

00802be2 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  802be2:	55                   	push   %ebp
  802be3:	89 e5                	mov    %esp,%ebp
  802be5:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802be8:	83 ec 04             	sub    $0x4,%esp
  802beb:	68 d0 3d 80 00       	push   $0x803dd0
  802bf0:	68 b0 00 00 00       	push   $0xb0
  802bf5:	68 f3 3d 80 00       	push   $0x803df3
  802bfa:	e8 b0 ec ff ff       	call   8018af <_panic>

00802bff <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  802bff:	55                   	push   %ebp
  802c00:	89 e5                	mov    %esp,%ebp
  802c02:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802c05:	83 ec 04             	sub    $0x4,%esp
  802c08:	68 d0 3d 80 00       	push   $0x803dd0
  802c0d:	68 b6 00 00 00       	push   $0xb6
  802c12:	68 f3 3d 80 00       	push   $0x803df3
  802c17:	e8 93 ec ff ff       	call   8018af <_panic>

00802c1c <shrink>:
}
void shrink(uint32 newSize)
{
  802c1c:	55                   	push   %ebp
  802c1d:	89 e5                	mov    %esp,%ebp
  802c1f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802c22:	83 ec 04             	sub    $0x4,%esp
  802c25:	68 d0 3d 80 00       	push   $0x803dd0
  802c2a:	68 ba 00 00 00       	push   $0xba
  802c2f:	68 f3 3d 80 00       	push   $0x803df3
  802c34:	e8 76 ec ff ff       	call   8018af <_panic>

00802c39 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  802c39:	55                   	push   %ebp
  802c3a:	89 e5                	mov    %esp,%ebp
  802c3c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802c3f:	83 ec 04             	sub    $0x4,%esp
  802c42:	68 d0 3d 80 00       	push   $0x803dd0
  802c47:	68 bf 00 00 00       	push   $0xbf
  802c4c:	68 f3 3d 80 00       	push   $0x803df3
  802c51:	e8 59 ec ff ff       	call   8018af <_panic>

00802c56 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  802c56:	55                   	push   %ebp
  802c57:	89 e5                	mov    %esp,%ebp
  802c59:	57                   	push   %edi
  802c5a:	56                   	push   %esi
  802c5b:	53                   	push   %ebx
  802c5c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802c5f:	8b 45 08             	mov    0x8(%ebp),%eax
  802c62:	8b 55 0c             	mov    0xc(%ebp),%edx
  802c65:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802c68:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802c6b:	8b 7d 18             	mov    0x18(%ebp),%edi
  802c6e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802c71:	cd 30                	int    $0x30
  802c73:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802c76:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802c79:	83 c4 10             	add    $0x10,%esp
  802c7c:	5b                   	pop    %ebx
  802c7d:	5e                   	pop    %esi
  802c7e:	5f                   	pop    %edi
  802c7f:	5d                   	pop    %ebp
  802c80:	c3                   	ret    

00802c81 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802c81:	55                   	push   %ebp
  802c82:	89 e5                	mov    %esp,%ebp
  802c84:	83 ec 04             	sub    $0x4,%esp
  802c87:	8b 45 10             	mov    0x10(%ebp),%eax
  802c8a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802c8d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802c91:	8b 45 08             	mov    0x8(%ebp),%eax
  802c94:	6a 00                	push   $0x0
  802c96:	6a 00                	push   $0x0
  802c98:	52                   	push   %edx
  802c99:	ff 75 0c             	pushl  0xc(%ebp)
  802c9c:	50                   	push   %eax
  802c9d:	6a 00                	push   $0x0
  802c9f:	e8 b2 ff ff ff       	call   802c56 <syscall>
  802ca4:	83 c4 18             	add    $0x18,%esp
}
  802ca7:	90                   	nop
  802ca8:	c9                   	leave  
  802ca9:	c3                   	ret    

00802caa <sys_cgetc>:

int
sys_cgetc(void)
{
  802caa:	55                   	push   %ebp
  802cab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802cad:	6a 00                	push   $0x0
  802caf:	6a 00                	push   $0x0
  802cb1:	6a 00                	push   $0x0
  802cb3:	6a 00                	push   $0x0
  802cb5:	6a 00                	push   $0x0
  802cb7:	6a 01                	push   $0x1
  802cb9:	e8 98 ff ff ff       	call   802c56 <syscall>
  802cbe:	83 c4 18             	add    $0x18,%esp
}
  802cc1:	c9                   	leave  
  802cc2:	c3                   	ret    

00802cc3 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802cc3:	55                   	push   %ebp
  802cc4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  802cc9:	6a 00                	push   $0x0
  802ccb:	6a 00                	push   $0x0
  802ccd:	6a 00                	push   $0x0
  802ccf:	6a 00                	push   $0x0
  802cd1:	50                   	push   %eax
  802cd2:	6a 05                	push   $0x5
  802cd4:	e8 7d ff ff ff       	call   802c56 <syscall>
  802cd9:	83 c4 18             	add    $0x18,%esp
}
  802cdc:	c9                   	leave  
  802cdd:	c3                   	ret    

00802cde <sys_getenvid>:

int32 sys_getenvid(void)
{
  802cde:	55                   	push   %ebp
  802cdf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802ce1:	6a 00                	push   $0x0
  802ce3:	6a 00                	push   $0x0
  802ce5:	6a 00                	push   $0x0
  802ce7:	6a 00                	push   $0x0
  802ce9:	6a 00                	push   $0x0
  802ceb:	6a 02                	push   $0x2
  802ced:	e8 64 ff ff ff       	call   802c56 <syscall>
  802cf2:	83 c4 18             	add    $0x18,%esp
}
  802cf5:	c9                   	leave  
  802cf6:	c3                   	ret    

00802cf7 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802cf7:	55                   	push   %ebp
  802cf8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802cfa:	6a 00                	push   $0x0
  802cfc:	6a 00                	push   $0x0
  802cfe:	6a 00                	push   $0x0
  802d00:	6a 00                	push   $0x0
  802d02:	6a 00                	push   $0x0
  802d04:	6a 03                	push   $0x3
  802d06:	e8 4b ff ff ff       	call   802c56 <syscall>
  802d0b:	83 c4 18             	add    $0x18,%esp
}
  802d0e:	c9                   	leave  
  802d0f:	c3                   	ret    

00802d10 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802d10:	55                   	push   %ebp
  802d11:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  802d13:	6a 00                	push   $0x0
  802d15:	6a 00                	push   $0x0
  802d17:	6a 00                	push   $0x0
  802d19:	6a 00                	push   $0x0
  802d1b:	6a 00                	push   $0x0
  802d1d:	6a 04                	push   $0x4
  802d1f:	e8 32 ff ff ff       	call   802c56 <syscall>
  802d24:	83 c4 18             	add    $0x18,%esp
}
  802d27:	c9                   	leave  
  802d28:	c3                   	ret    

00802d29 <sys_env_exit>:


void sys_env_exit(void)
{
  802d29:	55                   	push   %ebp
  802d2a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802d2c:	6a 00                	push   $0x0
  802d2e:	6a 00                	push   $0x0
  802d30:	6a 00                	push   $0x0
  802d32:	6a 00                	push   $0x0
  802d34:	6a 00                	push   $0x0
  802d36:	6a 06                	push   $0x6
  802d38:	e8 19 ff ff ff       	call   802c56 <syscall>
  802d3d:	83 c4 18             	add    $0x18,%esp
}
  802d40:	90                   	nop
  802d41:	c9                   	leave  
  802d42:	c3                   	ret    

00802d43 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802d43:	55                   	push   %ebp
  802d44:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802d46:	8b 55 0c             	mov    0xc(%ebp),%edx
  802d49:	8b 45 08             	mov    0x8(%ebp),%eax
  802d4c:	6a 00                	push   $0x0
  802d4e:	6a 00                	push   $0x0
  802d50:	6a 00                	push   $0x0
  802d52:	52                   	push   %edx
  802d53:	50                   	push   %eax
  802d54:	6a 07                	push   $0x7
  802d56:	e8 fb fe ff ff       	call   802c56 <syscall>
  802d5b:	83 c4 18             	add    $0x18,%esp
}
  802d5e:	c9                   	leave  
  802d5f:	c3                   	ret    

00802d60 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802d60:	55                   	push   %ebp
  802d61:	89 e5                	mov    %esp,%ebp
  802d63:	56                   	push   %esi
  802d64:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802d65:	8b 75 18             	mov    0x18(%ebp),%esi
  802d68:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802d6b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802d6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802d71:	8b 45 08             	mov    0x8(%ebp),%eax
  802d74:	56                   	push   %esi
  802d75:	53                   	push   %ebx
  802d76:	51                   	push   %ecx
  802d77:	52                   	push   %edx
  802d78:	50                   	push   %eax
  802d79:	6a 08                	push   $0x8
  802d7b:	e8 d6 fe ff ff       	call   802c56 <syscall>
  802d80:	83 c4 18             	add    $0x18,%esp
}
  802d83:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802d86:	5b                   	pop    %ebx
  802d87:	5e                   	pop    %esi
  802d88:	5d                   	pop    %ebp
  802d89:	c3                   	ret    

00802d8a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802d8a:	55                   	push   %ebp
  802d8b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802d8d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802d90:	8b 45 08             	mov    0x8(%ebp),%eax
  802d93:	6a 00                	push   $0x0
  802d95:	6a 00                	push   $0x0
  802d97:	6a 00                	push   $0x0
  802d99:	52                   	push   %edx
  802d9a:	50                   	push   %eax
  802d9b:	6a 09                	push   $0x9
  802d9d:	e8 b4 fe ff ff       	call   802c56 <syscall>
  802da2:	83 c4 18             	add    $0x18,%esp
}
  802da5:	c9                   	leave  
  802da6:	c3                   	ret    

00802da7 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802da7:	55                   	push   %ebp
  802da8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802daa:	6a 00                	push   $0x0
  802dac:	6a 00                	push   $0x0
  802dae:	6a 00                	push   $0x0
  802db0:	ff 75 0c             	pushl  0xc(%ebp)
  802db3:	ff 75 08             	pushl  0x8(%ebp)
  802db6:	6a 0a                	push   $0xa
  802db8:	e8 99 fe ff ff       	call   802c56 <syscall>
  802dbd:	83 c4 18             	add    $0x18,%esp
}
  802dc0:	c9                   	leave  
  802dc1:	c3                   	ret    

00802dc2 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802dc2:	55                   	push   %ebp
  802dc3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802dc5:	6a 00                	push   $0x0
  802dc7:	6a 00                	push   $0x0
  802dc9:	6a 00                	push   $0x0
  802dcb:	6a 00                	push   $0x0
  802dcd:	6a 00                	push   $0x0
  802dcf:	6a 0b                	push   $0xb
  802dd1:	e8 80 fe ff ff       	call   802c56 <syscall>
  802dd6:	83 c4 18             	add    $0x18,%esp
}
  802dd9:	c9                   	leave  
  802dda:	c3                   	ret    

00802ddb <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802ddb:	55                   	push   %ebp
  802ddc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802dde:	6a 00                	push   $0x0
  802de0:	6a 00                	push   $0x0
  802de2:	6a 00                	push   $0x0
  802de4:	6a 00                	push   $0x0
  802de6:	6a 00                	push   $0x0
  802de8:	6a 0c                	push   $0xc
  802dea:	e8 67 fe ff ff       	call   802c56 <syscall>
  802def:	83 c4 18             	add    $0x18,%esp
}
  802df2:	c9                   	leave  
  802df3:	c3                   	ret    

00802df4 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802df4:	55                   	push   %ebp
  802df5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802df7:	6a 00                	push   $0x0
  802df9:	6a 00                	push   $0x0
  802dfb:	6a 00                	push   $0x0
  802dfd:	6a 00                	push   $0x0
  802dff:	6a 00                	push   $0x0
  802e01:	6a 0d                	push   $0xd
  802e03:	e8 4e fe ff ff       	call   802c56 <syscall>
  802e08:	83 c4 18             	add    $0x18,%esp
}
  802e0b:	c9                   	leave  
  802e0c:	c3                   	ret    

00802e0d <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802e0d:	55                   	push   %ebp
  802e0e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802e10:	6a 00                	push   $0x0
  802e12:	6a 00                	push   $0x0
  802e14:	6a 00                	push   $0x0
  802e16:	ff 75 0c             	pushl  0xc(%ebp)
  802e19:	ff 75 08             	pushl  0x8(%ebp)
  802e1c:	6a 11                	push   $0x11
  802e1e:	e8 33 fe ff ff       	call   802c56 <syscall>
  802e23:	83 c4 18             	add    $0x18,%esp
	return;
  802e26:	90                   	nop
}
  802e27:	c9                   	leave  
  802e28:	c3                   	ret    

00802e29 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  802e29:	55                   	push   %ebp
  802e2a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802e2c:	6a 00                	push   $0x0
  802e2e:	6a 00                	push   $0x0
  802e30:	6a 00                	push   $0x0
  802e32:	ff 75 0c             	pushl  0xc(%ebp)
  802e35:	ff 75 08             	pushl  0x8(%ebp)
  802e38:	6a 12                	push   $0x12
  802e3a:	e8 17 fe ff ff       	call   802c56 <syscall>
  802e3f:	83 c4 18             	add    $0x18,%esp
	return ;
  802e42:	90                   	nop
}
  802e43:	c9                   	leave  
  802e44:	c3                   	ret    

00802e45 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802e45:	55                   	push   %ebp
  802e46:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802e48:	6a 00                	push   $0x0
  802e4a:	6a 00                	push   $0x0
  802e4c:	6a 00                	push   $0x0
  802e4e:	6a 00                	push   $0x0
  802e50:	6a 00                	push   $0x0
  802e52:	6a 0e                	push   $0xe
  802e54:	e8 fd fd ff ff       	call   802c56 <syscall>
  802e59:	83 c4 18             	add    $0x18,%esp
}
  802e5c:	c9                   	leave  
  802e5d:	c3                   	ret    

00802e5e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802e5e:	55                   	push   %ebp
  802e5f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802e61:	6a 00                	push   $0x0
  802e63:	6a 00                	push   $0x0
  802e65:	6a 00                	push   $0x0
  802e67:	6a 00                	push   $0x0
  802e69:	ff 75 08             	pushl  0x8(%ebp)
  802e6c:	6a 0f                	push   $0xf
  802e6e:	e8 e3 fd ff ff       	call   802c56 <syscall>
  802e73:	83 c4 18             	add    $0x18,%esp
}
  802e76:	c9                   	leave  
  802e77:	c3                   	ret    

00802e78 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802e78:	55                   	push   %ebp
  802e79:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802e7b:	6a 00                	push   $0x0
  802e7d:	6a 00                	push   $0x0
  802e7f:	6a 00                	push   $0x0
  802e81:	6a 00                	push   $0x0
  802e83:	6a 00                	push   $0x0
  802e85:	6a 10                	push   $0x10
  802e87:	e8 ca fd ff ff       	call   802c56 <syscall>
  802e8c:	83 c4 18             	add    $0x18,%esp
}
  802e8f:	90                   	nop
  802e90:	c9                   	leave  
  802e91:	c3                   	ret    

00802e92 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802e92:	55                   	push   %ebp
  802e93:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802e95:	6a 00                	push   $0x0
  802e97:	6a 00                	push   $0x0
  802e99:	6a 00                	push   $0x0
  802e9b:	6a 00                	push   $0x0
  802e9d:	6a 00                	push   $0x0
  802e9f:	6a 14                	push   $0x14
  802ea1:	e8 b0 fd ff ff       	call   802c56 <syscall>
  802ea6:	83 c4 18             	add    $0x18,%esp
}
  802ea9:	90                   	nop
  802eaa:	c9                   	leave  
  802eab:	c3                   	ret    

00802eac <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802eac:	55                   	push   %ebp
  802ead:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802eaf:	6a 00                	push   $0x0
  802eb1:	6a 00                	push   $0x0
  802eb3:	6a 00                	push   $0x0
  802eb5:	6a 00                	push   $0x0
  802eb7:	6a 00                	push   $0x0
  802eb9:	6a 15                	push   $0x15
  802ebb:	e8 96 fd ff ff       	call   802c56 <syscall>
  802ec0:	83 c4 18             	add    $0x18,%esp
}
  802ec3:	90                   	nop
  802ec4:	c9                   	leave  
  802ec5:	c3                   	ret    

00802ec6 <sys_cputc>:


void
sys_cputc(const char c)
{
  802ec6:	55                   	push   %ebp
  802ec7:	89 e5                	mov    %esp,%ebp
  802ec9:	83 ec 04             	sub    $0x4,%esp
  802ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  802ecf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802ed2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802ed6:	6a 00                	push   $0x0
  802ed8:	6a 00                	push   $0x0
  802eda:	6a 00                	push   $0x0
  802edc:	6a 00                	push   $0x0
  802ede:	50                   	push   %eax
  802edf:	6a 16                	push   $0x16
  802ee1:	e8 70 fd ff ff       	call   802c56 <syscall>
  802ee6:	83 c4 18             	add    $0x18,%esp
}
  802ee9:	90                   	nop
  802eea:	c9                   	leave  
  802eeb:	c3                   	ret    

00802eec <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802eec:	55                   	push   %ebp
  802eed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802eef:	6a 00                	push   $0x0
  802ef1:	6a 00                	push   $0x0
  802ef3:	6a 00                	push   $0x0
  802ef5:	6a 00                	push   $0x0
  802ef7:	6a 00                	push   $0x0
  802ef9:	6a 17                	push   $0x17
  802efb:	e8 56 fd ff ff       	call   802c56 <syscall>
  802f00:	83 c4 18             	add    $0x18,%esp
}
  802f03:	90                   	nop
  802f04:	c9                   	leave  
  802f05:	c3                   	ret    

00802f06 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802f06:	55                   	push   %ebp
  802f07:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802f09:	8b 45 08             	mov    0x8(%ebp),%eax
  802f0c:	6a 00                	push   $0x0
  802f0e:	6a 00                	push   $0x0
  802f10:	6a 00                	push   $0x0
  802f12:	ff 75 0c             	pushl  0xc(%ebp)
  802f15:	50                   	push   %eax
  802f16:	6a 18                	push   $0x18
  802f18:	e8 39 fd ff ff       	call   802c56 <syscall>
  802f1d:	83 c4 18             	add    $0x18,%esp
}
  802f20:	c9                   	leave  
  802f21:	c3                   	ret    

00802f22 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802f22:	55                   	push   %ebp
  802f23:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802f25:	8b 55 0c             	mov    0xc(%ebp),%edx
  802f28:	8b 45 08             	mov    0x8(%ebp),%eax
  802f2b:	6a 00                	push   $0x0
  802f2d:	6a 00                	push   $0x0
  802f2f:	6a 00                	push   $0x0
  802f31:	52                   	push   %edx
  802f32:	50                   	push   %eax
  802f33:	6a 1b                	push   $0x1b
  802f35:	e8 1c fd ff ff       	call   802c56 <syscall>
  802f3a:	83 c4 18             	add    $0x18,%esp
}
  802f3d:	c9                   	leave  
  802f3e:	c3                   	ret    

00802f3f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802f3f:	55                   	push   %ebp
  802f40:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802f42:	8b 55 0c             	mov    0xc(%ebp),%edx
  802f45:	8b 45 08             	mov    0x8(%ebp),%eax
  802f48:	6a 00                	push   $0x0
  802f4a:	6a 00                	push   $0x0
  802f4c:	6a 00                	push   $0x0
  802f4e:	52                   	push   %edx
  802f4f:	50                   	push   %eax
  802f50:	6a 19                	push   $0x19
  802f52:	e8 ff fc ff ff       	call   802c56 <syscall>
  802f57:	83 c4 18             	add    $0x18,%esp
}
  802f5a:	90                   	nop
  802f5b:	c9                   	leave  
  802f5c:	c3                   	ret    

00802f5d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802f5d:	55                   	push   %ebp
  802f5e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802f60:	8b 55 0c             	mov    0xc(%ebp),%edx
  802f63:	8b 45 08             	mov    0x8(%ebp),%eax
  802f66:	6a 00                	push   $0x0
  802f68:	6a 00                	push   $0x0
  802f6a:	6a 00                	push   $0x0
  802f6c:	52                   	push   %edx
  802f6d:	50                   	push   %eax
  802f6e:	6a 1a                	push   $0x1a
  802f70:	e8 e1 fc ff ff       	call   802c56 <syscall>
  802f75:	83 c4 18             	add    $0x18,%esp
}
  802f78:	90                   	nop
  802f79:	c9                   	leave  
  802f7a:	c3                   	ret    

00802f7b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802f7b:	55                   	push   %ebp
  802f7c:	89 e5                	mov    %esp,%ebp
  802f7e:	83 ec 04             	sub    $0x4,%esp
  802f81:	8b 45 10             	mov    0x10(%ebp),%eax
  802f84:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802f87:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802f8a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  802f91:	6a 00                	push   $0x0
  802f93:	51                   	push   %ecx
  802f94:	52                   	push   %edx
  802f95:	ff 75 0c             	pushl  0xc(%ebp)
  802f98:	50                   	push   %eax
  802f99:	6a 1c                	push   $0x1c
  802f9b:	e8 b6 fc ff ff       	call   802c56 <syscall>
  802fa0:	83 c4 18             	add    $0x18,%esp
}
  802fa3:	c9                   	leave  
  802fa4:	c3                   	ret    

00802fa5 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802fa5:	55                   	push   %ebp
  802fa6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802fa8:	8b 55 0c             	mov    0xc(%ebp),%edx
  802fab:	8b 45 08             	mov    0x8(%ebp),%eax
  802fae:	6a 00                	push   $0x0
  802fb0:	6a 00                	push   $0x0
  802fb2:	6a 00                	push   $0x0
  802fb4:	52                   	push   %edx
  802fb5:	50                   	push   %eax
  802fb6:	6a 1d                	push   $0x1d
  802fb8:	e8 99 fc ff ff       	call   802c56 <syscall>
  802fbd:	83 c4 18             	add    $0x18,%esp
}
  802fc0:	c9                   	leave  
  802fc1:	c3                   	ret    

00802fc2 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802fc2:	55                   	push   %ebp
  802fc3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802fc5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802fc8:	8b 55 0c             	mov    0xc(%ebp),%edx
  802fcb:	8b 45 08             	mov    0x8(%ebp),%eax
  802fce:	6a 00                	push   $0x0
  802fd0:	6a 00                	push   $0x0
  802fd2:	51                   	push   %ecx
  802fd3:	52                   	push   %edx
  802fd4:	50                   	push   %eax
  802fd5:	6a 1e                	push   $0x1e
  802fd7:	e8 7a fc ff ff       	call   802c56 <syscall>
  802fdc:	83 c4 18             	add    $0x18,%esp
}
  802fdf:	c9                   	leave  
  802fe0:	c3                   	ret    

00802fe1 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802fe1:	55                   	push   %ebp
  802fe2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802fe4:	8b 55 0c             	mov    0xc(%ebp),%edx
  802fe7:	8b 45 08             	mov    0x8(%ebp),%eax
  802fea:	6a 00                	push   $0x0
  802fec:	6a 00                	push   $0x0
  802fee:	6a 00                	push   $0x0
  802ff0:	52                   	push   %edx
  802ff1:	50                   	push   %eax
  802ff2:	6a 1f                	push   $0x1f
  802ff4:	e8 5d fc ff ff       	call   802c56 <syscall>
  802ff9:	83 c4 18             	add    $0x18,%esp
}
  802ffc:	c9                   	leave  
  802ffd:	c3                   	ret    

00802ffe <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802ffe:	55                   	push   %ebp
  802fff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  803001:	6a 00                	push   $0x0
  803003:	6a 00                	push   $0x0
  803005:	6a 00                	push   $0x0
  803007:	6a 00                	push   $0x0
  803009:	6a 00                	push   $0x0
  80300b:	6a 20                	push   $0x20
  80300d:	e8 44 fc ff ff       	call   802c56 <syscall>
  803012:	83 c4 18             	add    $0x18,%esp
}
  803015:	c9                   	leave  
  803016:	c3                   	ret    

00803017 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  803017:	55                   	push   %ebp
  803018:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80301a:	8b 45 08             	mov    0x8(%ebp),%eax
  80301d:	6a 00                	push   $0x0
  80301f:	ff 75 14             	pushl  0x14(%ebp)
  803022:	ff 75 10             	pushl  0x10(%ebp)
  803025:	ff 75 0c             	pushl  0xc(%ebp)
  803028:	50                   	push   %eax
  803029:	6a 21                	push   $0x21
  80302b:	e8 26 fc ff ff       	call   802c56 <syscall>
  803030:	83 c4 18             	add    $0x18,%esp
}
  803033:	c9                   	leave  
  803034:	c3                   	ret    

00803035 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  803035:	55                   	push   %ebp
  803036:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  803038:	8b 45 08             	mov    0x8(%ebp),%eax
  80303b:	6a 00                	push   $0x0
  80303d:	6a 00                	push   $0x0
  80303f:	6a 00                	push   $0x0
  803041:	6a 00                	push   $0x0
  803043:	50                   	push   %eax
  803044:	6a 22                	push   $0x22
  803046:	e8 0b fc ff ff       	call   802c56 <syscall>
  80304b:	83 c4 18             	add    $0x18,%esp
}
  80304e:	90                   	nop
  80304f:	c9                   	leave  
  803050:	c3                   	ret    

00803051 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  803051:	55                   	push   %ebp
  803052:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  803054:	8b 45 08             	mov    0x8(%ebp),%eax
  803057:	6a 00                	push   $0x0
  803059:	6a 00                	push   $0x0
  80305b:	6a 00                	push   $0x0
  80305d:	6a 00                	push   $0x0
  80305f:	50                   	push   %eax
  803060:	6a 23                	push   $0x23
  803062:	e8 ef fb ff ff       	call   802c56 <syscall>
  803067:	83 c4 18             	add    $0x18,%esp
}
  80306a:	90                   	nop
  80306b:	c9                   	leave  
  80306c:	c3                   	ret    

0080306d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80306d:	55                   	push   %ebp
  80306e:	89 e5                	mov    %esp,%ebp
  803070:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  803073:	8d 45 f8             	lea    -0x8(%ebp),%eax
  803076:	8d 50 04             	lea    0x4(%eax),%edx
  803079:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80307c:	6a 00                	push   $0x0
  80307e:	6a 00                	push   $0x0
  803080:	6a 00                	push   $0x0
  803082:	52                   	push   %edx
  803083:	50                   	push   %eax
  803084:	6a 24                	push   $0x24
  803086:	e8 cb fb ff ff       	call   802c56 <syscall>
  80308b:	83 c4 18             	add    $0x18,%esp
	return result;
  80308e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  803091:	8b 45 f8             	mov    -0x8(%ebp),%eax
  803094:	8b 55 fc             	mov    -0x4(%ebp),%edx
  803097:	89 01                	mov    %eax,(%ecx)
  803099:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80309c:	8b 45 08             	mov    0x8(%ebp),%eax
  80309f:	c9                   	leave  
  8030a0:	c2 04 00             	ret    $0x4

008030a3 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8030a3:	55                   	push   %ebp
  8030a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8030a6:	6a 00                	push   $0x0
  8030a8:	6a 00                	push   $0x0
  8030aa:	ff 75 10             	pushl  0x10(%ebp)
  8030ad:	ff 75 0c             	pushl  0xc(%ebp)
  8030b0:	ff 75 08             	pushl  0x8(%ebp)
  8030b3:	6a 13                	push   $0x13
  8030b5:	e8 9c fb ff ff       	call   802c56 <syscall>
  8030ba:	83 c4 18             	add    $0x18,%esp
	return ;
  8030bd:	90                   	nop
}
  8030be:	c9                   	leave  
  8030bf:	c3                   	ret    

008030c0 <sys_rcr2>:
uint32 sys_rcr2()
{
  8030c0:	55                   	push   %ebp
  8030c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8030c3:	6a 00                	push   $0x0
  8030c5:	6a 00                	push   $0x0
  8030c7:	6a 00                	push   $0x0
  8030c9:	6a 00                	push   $0x0
  8030cb:	6a 00                	push   $0x0
  8030cd:	6a 25                	push   $0x25
  8030cf:	e8 82 fb ff ff       	call   802c56 <syscall>
  8030d4:	83 c4 18             	add    $0x18,%esp
}
  8030d7:	c9                   	leave  
  8030d8:	c3                   	ret    

008030d9 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8030d9:	55                   	push   %ebp
  8030da:	89 e5                	mov    %esp,%ebp
  8030dc:	83 ec 04             	sub    $0x4,%esp
  8030df:	8b 45 08             	mov    0x8(%ebp),%eax
  8030e2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8030e5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8030e9:	6a 00                	push   $0x0
  8030eb:	6a 00                	push   $0x0
  8030ed:	6a 00                	push   $0x0
  8030ef:	6a 00                	push   $0x0
  8030f1:	50                   	push   %eax
  8030f2:	6a 26                	push   $0x26
  8030f4:	e8 5d fb ff ff       	call   802c56 <syscall>
  8030f9:	83 c4 18             	add    $0x18,%esp
	return ;
  8030fc:	90                   	nop
}
  8030fd:	c9                   	leave  
  8030fe:	c3                   	ret    

008030ff <rsttst>:
void rsttst()
{
  8030ff:	55                   	push   %ebp
  803100:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  803102:	6a 00                	push   $0x0
  803104:	6a 00                	push   $0x0
  803106:	6a 00                	push   $0x0
  803108:	6a 00                	push   $0x0
  80310a:	6a 00                	push   $0x0
  80310c:	6a 28                	push   $0x28
  80310e:	e8 43 fb ff ff       	call   802c56 <syscall>
  803113:	83 c4 18             	add    $0x18,%esp
	return ;
  803116:	90                   	nop
}
  803117:	c9                   	leave  
  803118:	c3                   	ret    

00803119 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  803119:	55                   	push   %ebp
  80311a:	89 e5                	mov    %esp,%ebp
  80311c:	83 ec 04             	sub    $0x4,%esp
  80311f:	8b 45 14             	mov    0x14(%ebp),%eax
  803122:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  803125:	8b 55 18             	mov    0x18(%ebp),%edx
  803128:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80312c:	52                   	push   %edx
  80312d:	50                   	push   %eax
  80312e:	ff 75 10             	pushl  0x10(%ebp)
  803131:	ff 75 0c             	pushl  0xc(%ebp)
  803134:	ff 75 08             	pushl  0x8(%ebp)
  803137:	6a 27                	push   $0x27
  803139:	e8 18 fb ff ff       	call   802c56 <syscall>
  80313e:	83 c4 18             	add    $0x18,%esp
	return ;
  803141:	90                   	nop
}
  803142:	c9                   	leave  
  803143:	c3                   	ret    

00803144 <chktst>:
void chktst(uint32 n)
{
  803144:	55                   	push   %ebp
  803145:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  803147:	6a 00                	push   $0x0
  803149:	6a 00                	push   $0x0
  80314b:	6a 00                	push   $0x0
  80314d:	6a 00                	push   $0x0
  80314f:	ff 75 08             	pushl  0x8(%ebp)
  803152:	6a 29                	push   $0x29
  803154:	e8 fd fa ff ff       	call   802c56 <syscall>
  803159:	83 c4 18             	add    $0x18,%esp
	return ;
  80315c:	90                   	nop
}
  80315d:	c9                   	leave  
  80315e:	c3                   	ret    

0080315f <inctst>:

void inctst()
{
  80315f:	55                   	push   %ebp
  803160:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  803162:	6a 00                	push   $0x0
  803164:	6a 00                	push   $0x0
  803166:	6a 00                	push   $0x0
  803168:	6a 00                	push   $0x0
  80316a:	6a 00                	push   $0x0
  80316c:	6a 2a                	push   $0x2a
  80316e:	e8 e3 fa ff ff       	call   802c56 <syscall>
  803173:	83 c4 18             	add    $0x18,%esp
	return ;
  803176:	90                   	nop
}
  803177:	c9                   	leave  
  803178:	c3                   	ret    

00803179 <gettst>:
uint32 gettst()
{
  803179:	55                   	push   %ebp
  80317a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80317c:	6a 00                	push   $0x0
  80317e:	6a 00                	push   $0x0
  803180:	6a 00                	push   $0x0
  803182:	6a 00                	push   $0x0
  803184:	6a 00                	push   $0x0
  803186:	6a 2b                	push   $0x2b
  803188:	e8 c9 fa ff ff       	call   802c56 <syscall>
  80318d:	83 c4 18             	add    $0x18,%esp
}
  803190:	c9                   	leave  
  803191:	c3                   	ret    

00803192 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  803192:	55                   	push   %ebp
  803193:	89 e5                	mov    %esp,%ebp
  803195:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  803198:	6a 00                	push   $0x0
  80319a:	6a 00                	push   $0x0
  80319c:	6a 00                	push   $0x0
  80319e:	6a 00                	push   $0x0
  8031a0:	6a 00                	push   $0x0
  8031a2:	6a 2c                	push   $0x2c
  8031a4:	e8 ad fa ff ff       	call   802c56 <syscall>
  8031a9:	83 c4 18             	add    $0x18,%esp
  8031ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8031af:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8031b3:	75 07                	jne    8031bc <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8031b5:	b8 01 00 00 00       	mov    $0x1,%eax
  8031ba:	eb 05                	jmp    8031c1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8031bc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8031c1:	c9                   	leave  
  8031c2:	c3                   	ret    

008031c3 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8031c3:	55                   	push   %ebp
  8031c4:	89 e5                	mov    %esp,%ebp
  8031c6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8031c9:	6a 00                	push   $0x0
  8031cb:	6a 00                	push   $0x0
  8031cd:	6a 00                	push   $0x0
  8031cf:	6a 00                	push   $0x0
  8031d1:	6a 00                	push   $0x0
  8031d3:	6a 2c                	push   $0x2c
  8031d5:	e8 7c fa ff ff       	call   802c56 <syscall>
  8031da:	83 c4 18             	add    $0x18,%esp
  8031dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8031e0:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8031e4:	75 07                	jne    8031ed <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8031e6:	b8 01 00 00 00       	mov    $0x1,%eax
  8031eb:	eb 05                	jmp    8031f2 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8031ed:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8031f2:	c9                   	leave  
  8031f3:	c3                   	ret    

008031f4 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8031f4:	55                   	push   %ebp
  8031f5:	89 e5                	mov    %esp,%ebp
  8031f7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8031fa:	6a 00                	push   $0x0
  8031fc:	6a 00                	push   $0x0
  8031fe:	6a 00                	push   $0x0
  803200:	6a 00                	push   $0x0
  803202:	6a 00                	push   $0x0
  803204:	6a 2c                	push   $0x2c
  803206:	e8 4b fa ff ff       	call   802c56 <syscall>
  80320b:	83 c4 18             	add    $0x18,%esp
  80320e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  803211:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  803215:	75 07                	jne    80321e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  803217:	b8 01 00 00 00       	mov    $0x1,%eax
  80321c:	eb 05                	jmp    803223 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80321e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  803223:	c9                   	leave  
  803224:	c3                   	ret    

00803225 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  803225:	55                   	push   %ebp
  803226:	89 e5                	mov    %esp,%ebp
  803228:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80322b:	6a 00                	push   $0x0
  80322d:	6a 00                	push   $0x0
  80322f:	6a 00                	push   $0x0
  803231:	6a 00                	push   $0x0
  803233:	6a 00                	push   $0x0
  803235:	6a 2c                	push   $0x2c
  803237:	e8 1a fa ff ff       	call   802c56 <syscall>
  80323c:	83 c4 18             	add    $0x18,%esp
  80323f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  803242:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  803246:	75 07                	jne    80324f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  803248:	b8 01 00 00 00       	mov    $0x1,%eax
  80324d:	eb 05                	jmp    803254 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80324f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  803254:	c9                   	leave  
  803255:	c3                   	ret    

00803256 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  803256:	55                   	push   %ebp
  803257:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  803259:	6a 00                	push   $0x0
  80325b:	6a 00                	push   $0x0
  80325d:	6a 00                	push   $0x0
  80325f:	6a 00                	push   $0x0
  803261:	ff 75 08             	pushl  0x8(%ebp)
  803264:	6a 2d                	push   $0x2d
  803266:	e8 eb f9 ff ff       	call   802c56 <syscall>
  80326b:	83 c4 18             	add    $0x18,%esp
	return ;
  80326e:	90                   	nop
}
  80326f:	c9                   	leave  
  803270:	c3                   	ret    

00803271 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  803271:	55                   	push   %ebp
  803272:	89 e5                	mov    %esp,%ebp
  803274:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  803275:	8b 5d 14             	mov    0x14(%ebp),%ebx
  803278:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80327b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80327e:	8b 45 08             	mov    0x8(%ebp),%eax
  803281:	6a 00                	push   $0x0
  803283:	53                   	push   %ebx
  803284:	51                   	push   %ecx
  803285:	52                   	push   %edx
  803286:	50                   	push   %eax
  803287:	6a 2e                	push   $0x2e
  803289:	e8 c8 f9 ff ff       	call   802c56 <syscall>
  80328e:	83 c4 18             	add    $0x18,%esp
}
  803291:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  803294:	c9                   	leave  
  803295:	c3                   	ret    

00803296 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  803296:	55                   	push   %ebp
  803297:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  803299:	8b 55 0c             	mov    0xc(%ebp),%edx
  80329c:	8b 45 08             	mov    0x8(%ebp),%eax
  80329f:	6a 00                	push   $0x0
  8032a1:	6a 00                	push   $0x0
  8032a3:	6a 00                	push   $0x0
  8032a5:	52                   	push   %edx
  8032a6:	50                   	push   %eax
  8032a7:	6a 2f                	push   $0x2f
  8032a9:	e8 a8 f9 ff ff       	call   802c56 <syscall>
  8032ae:	83 c4 18             	add    $0x18,%esp
}
  8032b1:	c9                   	leave  
  8032b2:	c3                   	ret    
  8032b3:	90                   	nop

008032b4 <__udivdi3>:
  8032b4:	55                   	push   %ebp
  8032b5:	57                   	push   %edi
  8032b6:	56                   	push   %esi
  8032b7:	53                   	push   %ebx
  8032b8:	83 ec 1c             	sub    $0x1c,%esp
  8032bb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8032bf:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8032c3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8032c7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8032cb:	89 ca                	mov    %ecx,%edx
  8032cd:	89 f8                	mov    %edi,%eax
  8032cf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8032d3:	85 f6                	test   %esi,%esi
  8032d5:	75 2d                	jne    803304 <__udivdi3+0x50>
  8032d7:	39 cf                	cmp    %ecx,%edi
  8032d9:	77 65                	ja     803340 <__udivdi3+0x8c>
  8032db:	89 fd                	mov    %edi,%ebp
  8032dd:	85 ff                	test   %edi,%edi
  8032df:	75 0b                	jne    8032ec <__udivdi3+0x38>
  8032e1:	b8 01 00 00 00       	mov    $0x1,%eax
  8032e6:	31 d2                	xor    %edx,%edx
  8032e8:	f7 f7                	div    %edi
  8032ea:	89 c5                	mov    %eax,%ebp
  8032ec:	31 d2                	xor    %edx,%edx
  8032ee:	89 c8                	mov    %ecx,%eax
  8032f0:	f7 f5                	div    %ebp
  8032f2:	89 c1                	mov    %eax,%ecx
  8032f4:	89 d8                	mov    %ebx,%eax
  8032f6:	f7 f5                	div    %ebp
  8032f8:	89 cf                	mov    %ecx,%edi
  8032fa:	89 fa                	mov    %edi,%edx
  8032fc:	83 c4 1c             	add    $0x1c,%esp
  8032ff:	5b                   	pop    %ebx
  803300:	5e                   	pop    %esi
  803301:	5f                   	pop    %edi
  803302:	5d                   	pop    %ebp
  803303:	c3                   	ret    
  803304:	39 ce                	cmp    %ecx,%esi
  803306:	77 28                	ja     803330 <__udivdi3+0x7c>
  803308:	0f bd fe             	bsr    %esi,%edi
  80330b:	83 f7 1f             	xor    $0x1f,%edi
  80330e:	75 40                	jne    803350 <__udivdi3+0x9c>
  803310:	39 ce                	cmp    %ecx,%esi
  803312:	72 0a                	jb     80331e <__udivdi3+0x6a>
  803314:	3b 44 24 08          	cmp    0x8(%esp),%eax
  803318:	0f 87 9e 00 00 00    	ja     8033bc <__udivdi3+0x108>
  80331e:	b8 01 00 00 00       	mov    $0x1,%eax
  803323:	89 fa                	mov    %edi,%edx
  803325:	83 c4 1c             	add    $0x1c,%esp
  803328:	5b                   	pop    %ebx
  803329:	5e                   	pop    %esi
  80332a:	5f                   	pop    %edi
  80332b:	5d                   	pop    %ebp
  80332c:	c3                   	ret    
  80332d:	8d 76 00             	lea    0x0(%esi),%esi
  803330:	31 ff                	xor    %edi,%edi
  803332:	31 c0                	xor    %eax,%eax
  803334:	89 fa                	mov    %edi,%edx
  803336:	83 c4 1c             	add    $0x1c,%esp
  803339:	5b                   	pop    %ebx
  80333a:	5e                   	pop    %esi
  80333b:	5f                   	pop    %edi
  80333c:	5d                   	pop    %ebp
  80333d:	c3                   	ret    
  80333e:	66 90                	xchg   %ax,%ax
  803340:	89 d8                	mov    %ebx,%eax
  803342:	f7 f7                	div    %edi
  803344:	31 ff                	xor    %edi,%edi
  803346:	89 fa                	mov    %edi,%edx
  803348:	83 c4 1c             	add    $0x1c,%esp
  80334b:	5b                   	pop    %ebx
  80334c:	5e                   	pop    %esi
  80334d:	5f                   	pop    %edi
  80334e:	5d                   	pop    %ebp
  80334f:	c3                   	ret    
  803350:	bd 20 00 00 00       	mov    $0x20,%ebp
  803355:	89 eb                	mov    %ebp,%ebx
  803357:	29 fb                	sub    %edi,%ebx
  803359:	89 f9                	mov    %edi,%ecx
  80335b:	d3 e6                	shl    %cl,%esi
  80335d:	89 c5                	mov    %eax,%ebp
  80335f:	88 d9                	mov    %bl,%cl
  803361:	d3 ed                	shr    %cl,%ebp
  803363:	89 e9                	mov    %ebp,%ecx
  803365:	09 f1                	or     %esi,%ecx
  803367:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80336b:	89 f9                	mov    %edi,%ecx
  80336d:	d3 e0                	shl    %cl,%eax
  80336f:	89 c5                	mov    %eax,%ebp
  803371:	89 d6                	mov    %edx,%esi
  803373:	88 d9                	mov    %bl,%cl
  803375:	d3 ee                	shr    %cl,%esi
  803377:	89 f9                	mov    %edi,%ecx
  803379:	d3 e2                	shl    %cl,%edx
  80337b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80337f:	88 d9                	mov    %bl,%cl
  803381:	d3 e8                	shr    %cl,%eax
  803383:	09 c2                	or     %eax,%edx
  803385:	89 d0                	mov    %edx,%eax
  803387:	89 f2                	mov    %esi,%edx
  803389:	f7 74 24 0c          	divl   0xc(%esp)
  80338d:	89 d6                	mov    %edx,%esi
  80338f:	89 c3                	mov    %eax,%ebx
  803391:	f7 e5                	mul    %ebp
  803393:	39 d6                	cmp    %edx,%esi
  803395:	72 19                	jb     8033b0 <__udivdi3+0xfc>
  803397:	74 0b                	je     8033a4 <__udivdi3+0xf0>
  803399:	89 d8                	mov    %ebx,%eax
  80339b:	31 ff                	xor    %edi,%edi
  80339d:	e9 58 ff ff ff       	jmp    8032fa <__udivdi3+0x46>
  8033a2:	66 90                	xchg   %ax,%ax
  8033a4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8033a8:	89 f9                	mov    %edi,%ecx
  8033aa:	d3 e2                	shl    %cl,%edx
  8033ac:	39 c2                	cmp    %eax,%edx
  8033ae:	73 e9                	jae    803399 <__udivdi3+0xe5>
  8033b0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8033b3:	31 ff                	xor    %edi,%edi
  8033b5:	e9 40 ff ff ff       	jmp    8032fa <__udivdi3+0x46>
  8033ba:	66 90                	xchg   %ax,%ax
  8033bc:	31 c0                	xor    %eax,%eax
  8033be:	e9 37 ff ff ff       	jmp    8032fa <__udivdi3+0x46>
  8033c3:	90                   	nop

008033c4 <__umoddi3>:
  8033c4:	55                   	push   %ebp
  8033c5:	57                   	push   %edi
  8033c6:	56                   	push   %esi
  8033c7:	53                   	push   %ebx
  8033c8:	83 ec 1c             	sub    $0x1c,%esp
  8033cb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8033cf:	8b 74 24 34          	mov    0x34(%esp),%esi
  8033d3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8033d7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8033db:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8033df:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8033e3:	89 f3                	mov    %esi,%ebx
  8033e5:	89 fa                	mov    %edi,%edx
  8033e7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8033eb:	89 34 24             	mov    %esi,(%esp)
  8033ee:	85 c0                	test   %eax,%eax
  8033f0:	75 1a                	jne    80340c <__umoddi3+0x48>
  8033f2:	39 f7                	cmp    %esi,%edi
  8033f4:	0f 86 a2 00 00 00    	jbe    80349c <__umoddi3+0xd8>
  8033fa:	89 c8                	mov    %ecx,%eax
  8033fc:	89 f2                	mov    %esi,%edx
  8033fe:	f7 f7                	div    %edi
  803400:	89 d0                	mov    %edx,%eax
  803402:	31 d2                	xor    %edx,%edx
  803404:	83 c4 1c             	add    $0x1c,%esp
  803407:	5b                   	pop    %ebx
  803408:	5e                   	pop    %esi
  803409:	5f                   	pop    %edi
  80340a:	5d                   	pop    %ebp
  80340b:	c3                   	ret    
  80340c:	39 f0                	cmp    %esi,%eax
  80340e:	0f 87 ac 00 00 00    	ja     8034c0 <__umoddi3+0xfc>
  803414:	0f bd e8             	bsr    %eax,%ebp
  803417:	83 f5 1f             	xor    $0x1f,%ebp
  80341a:	0f 84 ac 00 00 00    	je     8034cc <__umoddi3+0x108>
  803420:	bf 20 00 00 00       	mov    $0x20,%edi
  803425:	29 ef                	sub    %ebp,%edi
  803427:	89 fe                	mov    %edi,%esi
  803429:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80342d:	89 e9                	mov    %ebp,%ecx
  80342f:	d3 e0                	shl    %cl,%eax
  803431:	89 d7                	mov    %edx,%edi
  803433:	89 f1                	mov    %esi,%ecx
  803435:	d3 ef                	shr    %cl,%edi
  803437:	09 c7                	or     %eax,%edi
  803439:	89 e9                	mov    %ebp,%ecx
  80343b:	d3 e2                	shl    %cl,%edx
  80343d:	89 14 24             	mov    %edx,(%esp)
  803440:	89 d8                	mov    %ebx,%eax
  803442:	d3 e0                	shl    %cl,%eax
  803444:	89 c2                	mov    %eax,%edx
  803446:	8b 44 24 08          	mov    0x8(%esp),%eax
  80344a:	d3 e0                	shl    %cl,%eax
  80344c:	89 44 24 04          	mov    %eax,0x4(%esp)
  803450:	8b 44 24 08          	mov    0x8(%esp),%eax
  803454:	89 f1                	mov    %esi,%ecx
  803456:	d3 e8                	shr    %cl,%eax
  803458:	09 d0                	or     %edx,%eax
  80345a:	d3 eb                	shr    %cl,%ebx
  80345c:	89 da                	mov    %ebx,%edx
  80345e:	f7 f7                	div    %edi
  803460:	89 d3                	mov    %edx,%ebx
  803462:	f7 24 24             	mull   (%esp)
  803465:	89 c6                	mov    %eax,%esi
  803467:	89 d1                	mov    %edx,%ecx
  803469:	39 d3                	cmp    %edx,%ebx
  80346b:	0f 82 87 00 00 00    	jb     8034f8 <__umoddi3+0x134>
  803471:	0f 84 91 00 00 00    	je     803508 <__umoddi3+0x144>
  803477:	8b 54 24 04          	mov    0x4(%esp),%edx
  80347b:	29 f2                	sub    %esi,%edx
  80347d:	19 cb                	sbb    %ecx,%ebx
  80347f:	89 d8                	mov    %ebx,%eax
  803481:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  803485:	d3 e0                	shl    %cl,%eax
  803487:	89 e9                	mov    %ebp,%ecx
  803489:	d3 ea                	shr    %cl,%edx
  80348b:	09 d0                	or     %edx,%eax
  80348d:	89 e9                	mov    %ebp,%ecx
  80348f:	d3 eb                	shr    %cl,%ebx
  803491:	89 da                	mov    %ebx,%edx
  803493:	83 c4 1c             	add    $0x1c,%esp
  803496:	5b                   	pop    %ebx
  803497:	5e                   	pop    %esi
  803498:	5f                   	pop    %edi
  803499:	5d                   	pop    %ebp
  80349a:	c3                   	ret    
  80349b:	90                   	nop
  80349c:	89 fd                	mov    %edi,%ebp
  80349e:	85 ff                	test   %edi,%edi
  8034a0:	75 0b                	jne    8034ad <__umoddi3+0xe9>
  8034a2:	b8 01 00 00 00       	mov    $0x1,%eax
  8034a7:	31 d2                	xor    %edx,%edx
  8034a9:	f7 f7                	div    %edi
  8034ab:	89 c5                	mov    %eax,%ebp
  8034ad:	89 f0                	mov    %esi,%eax
  8034af:	31 d2                	xor    %edx,%edx
  8034b1:	f7 f5                	div    %ebp
  8034b3:	89 c8                	mov    %ecx,%eax
  8034b5:	f7 f5                	div    %ebp
  8034b7:	89 d0                	mov    %edx,%eax
  8034b9:	e9 44 ff ff ff       	jmp    803402 <__umoddi3+0x3e>
  8034be:	66 90                	xchg   %ax,%ax
  8034c0:	89 c8                	mov    %ecx,%eax
  8034c2:	89 f2                	mov    %esi,%edx
  8034c4:	83 c4 1c             	add    $0x1c,%esp
  8034c7:	5b                   	pop    %ebx
  8034c8:	5e                   	pop    %esi
  8034c9:	5f                   	pop    %edi
  8034ca:	5d                   	pop    %ebp
  8034cb:	c3                   	ret    
  8034cc:	3b 04 24             	cmp    (%esp),%eax
  8034cf:	72 06                	jb     8034d7 <__umoddi3+0x113>
  8034d1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8034d5:	77 0f                	ja     8034e6 <__umoddi3+0x122>
  8034d7:	89 f2                	mov    %esi,%edx
  8034d9:	29 f9                	sub    %edi,%ecx
  8034db:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8034df:	89 14 24             	mov    %edx,(%esp)
  8034e2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8034e6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8034ea:	8b 14 24             	mov    (%esp),%edx
  8034ed:	83 c4 1c             	add    $0x1c,%esp
  8034f0:	5b                   	pop    %ebx
  8034f1:	5e                   	pop    %esi
  8034f2:	5f                   	pop    %edi
  8034f3:	5d                   	pop    %ebp
  8034f4:	c3                   	ret    
  8034f5:	8d 76 00             	lea    0x0(%esi),%esi
  8034f8:	2b 04 24             	sub    (%esp),%eax
  8034fb:	19 fa                	sbb    %edi,%edx
  8034fd:	89 d1                	mov    %edx,%ecx
  8034ff:	89 c6                	mov    %eax,%esi
  803501:	e9 71 ff ff ff       	jmp    803477 <__umoddi3+0xb3>
  803506:	66 90                	xchg   %ax,%ax
  803508:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80350c:	72 ea                	jb     8034f8 <__umoddi3+0x134>
  80350e:	89 d9                	mov    %ebx,%ecx
  803510:	e9 62 ff ff ff       	jmp    803477 <__umoddi3+0xb3>
