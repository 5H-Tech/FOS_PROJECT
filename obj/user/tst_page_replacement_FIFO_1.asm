
obj/user/tst_page_replacement_FIFO_1:     file format elf32-i386


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
  800031:	e8 a0 05 00 00       	call   8005d6 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
char arr[PAGE_SIZE*12];
char* ptr = (char* )0x0801000 ;
char* ptr2 = (char* )0x0804000 ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 78             	sub    $0x78,%esp



	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80003e:	a1 20 30 80 00       	mov    0x803020,%eax
  800043:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800049:	8b 00                	mov    (%eax),%eax
  80004b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80004e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800051:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800056:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005b:	74 14                	je     800071 <_main+0x39>
  80005d:	83 ec 04             	sub    $0x4,%esp
  800060:	68 20 20 80 00       	push   $0x802020
  800065:	6a 15                	push   $0x15
  800067:	68 64 20 80 00       	push   $0x802064
  80006c:	e8 aa 06 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800071:	a1 20 30 80 00       	mov    0x803020,%eax
  800076:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80007c:	83 c0 10             	add    $0x10,%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800084:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 20 20 80 00       	push   $0x802020
  80009b:	6a 16                	push   $0x16
  80009d:	68 64 20 80 00       	push   $0x802064
  8000a2:	e8 74 06 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ac:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000b2:	83 c0 20             	add    $0x20,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 20 20 80 00       	push   $0x802020
  8000d1:	6a 17                	push   $0x17
  8000d3:	68 64 20 80 00       	push   $0x802064
  8000d8:	e8 3e 06 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000e8:	83 c0 30             	add    $0x30,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
  8000f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 20 20 80 00       	push   $0x802020
  800107:	6a 18                	push   $0x18
  800109:	68 64 20 80 00       	push   $0x802064
  80010e:	e8 08 06 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800113:	a1 20 30 80 00       	mov    0x803020,%eax
  800118:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80011e:	83 c0 40             	add    $0x40,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800126:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 20 20 80 00       	push   $0x802020
  80013d:	6a 19                	push   $0x19
  80013f:	68 64 20 80 00       	push   $0x802064
  800144:	e8 d2 05 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800149:	a1 20 30 80 00       	mov    0x803020,%eax
  80014e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800154:	83 c0 50             	add    $0x50,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80015c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 20 20 80 00       	push   $0x802020
  800173:	6a 1a                	push   $0x1a
  800175:	68 64 20 80 00       	push   $0x802064
  80017a:	e8 9c 05 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80017f:	a1 20 30 80 00       	mov    0x803020,%eax
  800184:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80018a:	83 c0 60             	add    $0x60,%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  800192:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800195:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019a:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 20 20 80 00       	push   $0x802020
  8001a9:	6a 1b                	push   $0x1b
  8001ab:	68 64 20 80 00       	push   $0x802064
  8001b0:	e8 66 05 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ba:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001c0:	83 c0 70             	add    $0x70,%eax
  8001c3:	8b 00                	mov    (%eax),%eax
  8001c5:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8001c8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8001cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d0:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d5:	74 14                	je     8001eb <_main+0x1b3>
  8001d7:	83 ec 04             	sub    $0x4,%esp
  8001da:	68 20 20 80 00       	push   $0x802020
  8001df:	6a 1c                	push   $0x1c
  8001e1:	68 64 20 80 00       	push   $0x802064
  8001e6:	e8 30 05 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001f6:	83 e8 80             	sub    $0xffffff80,%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8001fe:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800201:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800206:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020b:	74 14                	je     800221 <_main+0x1e9>
  80020d:	83 ec 04             	sub    $0x4,%esp
  800210:	68 20 20 80 00       	push   $0x802020
  800215:	6a 1d                	push   $0x1d
  800217:	68 64 20 80 00       	push   $0x802064
  80021c:	e8 fa 04 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800221:	a1 20 30 80 00       	mov    0x803020,%eax
  800226:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80022c:	05 90 00 00 00       	add    $0x90,%eax
  800231:	8b 00                	mov    (%eax),%eax
  800233:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800236:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800239:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023e:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800243:	74 14                	je     800259 <_main+0x221>
  800245:	83 ec 04             	sub    $0x4,%esp
  800248:	68 20 20 80 00       	push   $0x802020
  80024d:	6a 1e                	push   $0x1e
  80024f:	68 64 20 80 00       	push   $0x802064
  800254:	e8 c2 04 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800259:	a1 20 30 80 00       	mov    0x803020,%eax
  80025e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800264:	05 a0 00 00 00       	add    $0xa0,%eax
  800269:	8b 00                	mov    (%eax),%eax
  80026b:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  80026e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800271:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800276:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80027b:	74 14                	je     800291 <_main+0x259>
  80027d:	83 ec 04             	sub    $0x4,%esp
  800280:	68 20 20 80 00       	push   $0x802020
  800285:	6a 1f                	push   $0x1f
  800287:	68 64 20 80 00       	push   $0x802064
  80028c:	e8 8a 04 00 00       	call   80071b <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  800291:	a1 20 30 80 00       	mov    0x803020,%eax
  800296:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  80029c:	85 c0                	test   %eax,%eax
  80029e:	74 14                	je     8002b4 <_main+0x27c>
  8002a0:	83 ec 04             	sub    $0x4,%esp
  8002a3:	68 88 20 80 00       	push   $0x802088
  8002a8:	6a 20                	push   $0x20
  8002aa:	68 64 20 80 00       	push   $0x802064
  8002af:	e8 67 04 00 00       	call   80071b <_panic>
	}


	int freePages = sys_calculate_free_frames();
  8002b4:	e8 fa 15 00 00       	call   8018b3 <sys_calculate_free_frames>
  8002b9:	89 45 c0             	mov    %eax,-0x40(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002bc:	e8 75 16 00 00       	call   801936 <sys_pf_calculate_allocated_pages>
  8002c1:	89 45 bc             	mov    %eax,-0x44(%ebp)

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1];
  8002c4:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8002c9:	88 45 bb             	mov    %al,-0x45(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1];
  8002cc:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8002d1:	88 45 ba             	mov    %al,-0x46(%ebp)
	char garbage4,garbage5;
	//Writing (Modified)
	int i;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002d4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8002db:	eb 26                	jmp    800303 <_main+0x2cb>
	{
		arr[i] = -1 ;
  8002dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002e0:	05 40 30 80 00       	add    $0x803040,%eax
  8002e5:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		//ptr++ ; ptr2++ ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		garbage4 = *ptr ;
  8002e8:	a1 00 30 80 00       	mov    0x803000,%eax
  8002ed:	8a 00                	mov    (%eax),%al
  8002ef:	88 45 f7             	mov    %al,-0x9(%ebp)
		garbage5 = *ptr2 ;
  8002f2:	a1 04 30 80 00       	mov    0x803004,%eax
  8002f7:	8a 00                	mov    (%eax),%al
  8002f9:	88 45 f6             	mov    %al,-0xa(%ebp)
	char garbage1 = arr[PAGE_SIZE*11-1];
	char garbage2 = arr[PAGE_SIZE*12-1];
	char garbage4,garbage5;
	//Writing (Modified)
	int i;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002fc:	81 45 f0 00 08 00 00 	addl   $0x800,-0x10(%ebp)
  800303:	81 7d f0 ff 9f 00 00 	cmpl   $0x9fff,-0x10(%ebp)
  80030a:	7e d1                	jle    8002dd <_main+0x2a5>
	}

	//===================
	//cprintf("Checking PAGE FIFO algorithm... \n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80030c:	a1 20 30 80 00       	mov    0x803020,%eax
  800311:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800317:	8b 00                	mov    (%eax),%eax
  800319:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  80031c:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80031f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800324:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800329:	74 14                	je     80033f <_main+0x307>
  80032b:	83 ec 04             	sub    $0x4,%esp
  80032e:	68 d0 20 80 00       	push   $0x8020d0
  800333:	6a 3c                	push   $0x3c
  800335:	68 64 20 80 00       	push   $0x802064
  80033a:	e8 dc 03 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x80a000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80033f:	a1 20 30 80 00       	mov    0x803020,%eax
  800344:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80034a:	83 c0 10             	add    $0x10,%eax
  80034d:	8b 00                	mov    (%eax),%eax
  80034f:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800352:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800355:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80035a:	3d 00 a0 80 00       	cmp    $0x80a000,%eax
  80035f:	74 14                	je     800375 <_main+0x33d>
  800361:	83 ec 04             	sub    $0x4,%esp
  800364:	68 d0 20 80 00       	push   $0x8020d0
  800369:	6a 3d                	push   $0x3d
  80036b:	68 64 20 80 00       	push   $0x802064
  800370:	e8 a6 03 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x80b000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800375:	a1 20 30 80 00       	mov    0x803020,%eax
  80037a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800380:	83 c0 20             	add    $0x20,%eax
  800383:	8b 00                	mov    (%eax),%eax
  800385:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800388:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80038b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800390:	3d 00 b0 80 00       	cmp    $0x80b000,%eax
  800395:	74 14                	je     8003ab <_main+0x373>
  800397:	83 ec 04             	sub    $0x4,%esp
  80039a:	68 d0 20 80 00       	push   $0x8020d0
  80039f:	6a 3e                	push   $0x3e
  8003a1:	68 64 20 80 00       	push   $0x802064
  8003a6:	e8 70 03 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x804000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8003ab:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003b6:	83 c0 30             	add    $0x30,%eax
  8003b9:	8b 00                	mov    (%eax),%eax
  8003bb:	89 45 a8             	mov    %eax,-0x58(%ebp)
  8003be:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003c1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003c6:	3d 00 40 80 00       	cmp    $0x804000,%eax
  8003cb:	74 14                	je     8003e1 <_main+0x3a9>
  8003cd:	83 ec 04             	sub    $0x4,%esp
  8003d0:	68 d0 20 80 00       	push   $0x8020d0
  8003d5:	6a 3f                	push   $0x3f
  8003d7:	68 64 20 80 00       	push   $0x802064
  8003dc:	e8 3a 03 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x80c000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8003e1:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003ec:	83 c0 40             	add    $0x40,%eax
  8003ef:	8b 00                	mov    (%eax),%eax
  8003f1:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  8003f4:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003f7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003fc:	3d 00 c0 80 00       	cmp    $0x80c000,%eax
  800401:	74 14                	je     800417 <_main+0x3df>
  800403:	83 ec 04             	sub    $0x4,%esp
  800406:	68 d0 20 80 00       	push   $0x8020d0
  80040b:	6a 40                	push   $0x40
  80040d:	68 64 20 80 00       	push   $0x802064
  800412:	e8 04 03 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x807000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800417:	a1 20 30 80 00       	mov    0x803020,%eax
  80041c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800422:	83 c0 50             	add    $0x50,%eax
  800425:	8b 00                	mov    (%eax),%eax
  800427:	89 45 a0             	mov    %eax,-0x60(%ebp)
  80042a:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80042d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800432:	3d 00 70 80 00       	cmp    $0x807000,%eax
  800437:	74 14                	je     80044d <_main+0x415>
  800439:	83 ec 04             	sub    $0x4,%esp
  80043c:	68 d0 20 80 00       	push   $0x8020d0
  800441:	6a 41                	push   $0x41
  800443:	68 64 20 80 00       	push   $0x802064
  800448:	e8 ce 02 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x808000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80044d:	a1 20 30 80 00       	mov    0x803020,%eax
  800452:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800458:	83 c0 60             	add    $0x60,%eax
  80045b:	8b 00                	mov    (%eax),%eax
  80045d:	89 45 9c             	mov    %eax,-0x64(%ebp)
  800460:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800463:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800468:	3d 00 80 80 00       	cmp    $0x808000,%eax
  80046d:	74 14                	je     800483 <_main+0x44b>
  80046f:	83 ec 04             	sub    $0x4,%esp
  800472:	68 d0 20 80 00       	push   $0x8020d0
  800477:	6a 42                	push   $0x42
  800479:	68 64 20 80 00       	push   $0x802064
  80047e:	e8 98 02 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x800000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800483:	a1 20 30 80 00       	mov    0x803020,%eax
  800488:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80048e:	83 c0 70             	add    $0x70,%eax
  800491:	8b 00                	mov    (%eax),%eax
  800493:	89 45 98             	mov    %eax,-0x68(%ebp)
  800496:	8b 45 98             	mov    -0x68(%ebp),%eax
  800499:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80049e:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8004a3:	74 14                	je     8004b9 <_main+0x481>
  8004a5:	83 ec 04             	sub    $0x4,%esp
  8004a8:	68 d0 20 80 00       	push   $0x8020d0
  8004ad:	6a 43                	push   $0x43
  8004af:	68 64 20 80 00       	push   $0x802064
  8004b4:	e8 62 02 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x801000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8004b9:	a1 20 30 80 00       	mov    0x803020,%eax
  8004be:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004c4:	83 e8 80             	sub    $0xffffff80,%eax
  8004c7:	8b 00                	mov    (%eax),%eax
  8004c9:	89 45 94             	mov    %eax,-0x6c(%ebp)
  8004cc:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8004cf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004d4:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8004d9:	74 14                	je     8004ef <_main+0x4b7>
  8004db:	83 ec 04             	sub    $0x4,%esp
  8004de:	68 d0 20 80 00       	push   $0x8020d0
  8004e3:	6a 44                	push   $0x44
  8004e5:	68 64 20 80 00       	push   $0x802064
  8004ea:	e8 2c 02 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=  0x809000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8004ef:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f4:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004fa:	05 90 00 00 00       	add    $0x90,%eax
  8004ff:	8b 00                	mov    (%eax),%eax
  800501:	89 45 90             	mov    %eax,-0x70(%ebp)
  800504:	8b 45 90             	mov    -0x70(%ebp),%eax
  800507:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80050c:	3d 00 90 80 00       	cmp    $0x809000,%eax
  800511:	74 14                	je     800527 <_main+0x4ef>
  800513:	83 ec 04             	sub    $0x4,%esp
  800516:	68 d0 20 80 00       	push   $0x8020d0
  80051b:	6a 45                	push   $0x45
  80051d:	68 64 20 80 00       	push   $0x802064
  800522:	e8 f4 01 00 00       	call   80071b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=  0x803000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800527:	a1 20 30 80 00       	mov    0x803020,%eax
  80052c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800532:	05 a0 00 00 00       	add    $0xa0,%eax
  800537:	8b 00                	mov    (%eax),%eax
  800539:	89 45 8c             	mov    %eax,-0x74(%ebp)
  80053c:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80053f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800544:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800549:	74 14                	je     80055f <_main+0x527>
  80054b:	83 ec 04             	sub    $0x4,%esp
  80054e:	68 d0 20 80 00       	push   $0x8020d0
  800553:	6a 46                	push   $0x46
  800555:	68 64 20 80 00       	push   $0x802064
  80055a:	e8 bc 01 00 00       	call   80071b <_panic>

		if(myEnv->page_last_WS_index != 5) panic("wrong PAGE WS pointer location");
  80055f:	a1 20 30 80 00       	mov    0x803020,%eax
  800564:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  80056a:	83 f8 05             	cmp    $0x5,%eax
  80056d:	74 14                	je     800583 <_main+0x54b>
  80056f:	83 ec 04             	sub    $0x4,%esp
  800572:	68 1c 21 80 00       	push   $0x80211c
  800577:	6a 48                	push   $0x48
  800579:	68 64 20 80 00       	push   $0x802064
  80057e:	e8 98 01 00 00       	call   80071b <_panic>

	}
	{
		if (garbage4 != *ptr) panic("test failed!");
  800583:	a1 00 30 80 00       	mov    0x803000,%eax
  800588:	8a 00                	mov    (%eax),%al
  80058a:	3a 45 f7             	cmp    -0x9(%ebp),%al
  80058d:	74 14                	je     8005a3 <_main+0x56b>
  80058f:	83 ec 04             	sub    $0x4,%esp
  800592:	68 3b 21 80 00       	push   $0x80213b
  800597:	6a 4c                	push   $0x4c
  800599:	68 64 20 80 00       	push   $0x802064
  80059e:	e8 78 01 00 00       	call   80071b <_panic>
		if (garbage5 != *ptr2) panic("test failed!");
  8005a3:	a1 04 30 80 00       	mov    0x803004,%eax
  8005a8:	8a 00                	mov    (%eax),%al
  8005aa:	3a 45 f6             	cmp    -0xa(%ebp),%al
  8005ad:	74 14                	je     8005c3 <_main+0x58b>
  8005af:	83 ec 04             	sub    $0x4,%esp
  8005b2:	68 3b 21 80 00       	push   $0x80213b
  8005b7:	6a 4d                	push   $0x4d
  8005b9:	68 64 20 80 00       	push   $0x802064
  8005be:	e8 58 01 00 00       	call   80071b <_panic>
	}
	cprintf("Congratulations!! test PAGE replacement [FIFO 1] is completed successfully.\n");
  8005c3:	83 ec 0c             	sub    $0xc,%esp
  8005c6:	68 48 21 80 00       	push   $0x802148
  8005cb:	e8 ed 03 00 00       	call   8009bd <cprintf>
  8005d0:	83 c4 10             	add    $0x10,%esp
	return;
  8005d3:	90                   	nop
}
  8005d4:	c9                   	leave  
  8005d5:	c3                   	ret    

008005d6 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005d6:	55                   	push   %ebp
  8005d7:	89 e5                	mov    %esp,%ebp
  8005d9:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005dc:	e8 07 12 00 00       	call   8017e8 <sys_getenvindex>
  8005e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005e7:	89 d0                	mov    %edx,%eax
  8005e9:	c1 e0 03             	shl    $0x3,%eax
  8005ec:	01 d0                	add    %edx,%eax
  8005ee:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8005f5:	01 c8                	add    %ecx,%eax
  8005f7:	01 c0                	add    %eax,%eax
  8005f9:	01 d0                	add    %edx,%eax
  8005fb:	01 c0                	add    %eax,%eax
  8005fd:	01 d0                	add    %edx,%eax
  8005ff:	89 c2                	mov    %eax,%edx
  800601:	c1 e2 05             	shl    $0x5,%edx
  800604:	29 c2                	sub    %eax,%edx
  800606:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80060d:	89 c2                	mov    %eax,%edx
  80060f:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800615:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80061a:	a1 20 30 80 00       	mov    0x803020,%eax
  80061f:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800625:	84 c0                	test   %al,%al
  800627:	74 0f                	je     800638 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800629:	a1 20 30 80 00       	mov    0x803020,%eax
  80062e:	05 40 3c 01 00       	add    $0x13c40,%eax
  800633:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800638:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80063c:	7e 0a                	jle    800648 <libmain+0x72>
		binaryname = argv[0];
  80063e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800641:	8b 00                	mov    (%eax),%eax
  800643:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  800648:	83 ec 08             	sub    $0x8,%esp
  80064b:	ff 75 0c             	pushl  0xc(%ebp)
  80064e:	ff 75 08             	pushl  0x8(%ebp)
  800651:	e8 e2 f9 ff ff       	call   800038 <_main>
  800656:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800659:	e8 25 13 00 00       	call   801983 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80065e:	83 ec 0c             	sub    $0xc,%esp
  800661:	68 b0 21 80 00       	push   $0x8021b0
  800666:	e8 52 03 00 00       	call   8009bd <cprintf>
  80066b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80066e:	a1 20 30 80 00       	mov    0x803020,%eax
  800673:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800679:	a1 20 30 80 00       	mov    0x803020,%eax
  80067e:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800684:	83 ec 04             	sub    $0x4,%esp
  800687:	52                   	push   %edx
  800688:	50                   	push   %eax
  800689:	68 d8 21 80 00       	push   $0x8021d8
  80068e:	e8 2a 03 00 00       	call   8009bd <cprintf>
  800693:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800696:	a1 20 30 80 00       	mov    0x803020,%eax
  80069b:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8006a1:	a1 20 30 80 00       	mov    0x803020,%eax
  8006a6:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8006ac:	83 ec 04             	sub    $0x4,%esp
  8006af:	52                   	push   %edx
  8006b0:	50                   	push   %eax
  8006b1:	68 00 22 80 00       	push   $0x802200
  8006b6:	e8 02 03 00 00       	call   8009bd <cprintf>
  8006bb:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006be:	a1 20 30 80 00       	mov    0x803020,%eax
  8006c3:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8006c9:	83 ec 08             	sub    $0x8,%esp
  8006cc:	50                   	push   %eax
  8006cd:	68 41 22 80 00       	push   $0x802241
  8006d2:	e8 e6 02 00 00       	call   8009bd <cprintf>
  8006d7:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006da:	83 ec 0c             	sub    $0xc,%esp
  8006dd:	68 b0 21 80 00       	push   $0x8021b0
  8006e2:	e8 d6 02 00 00       	call   8009bd <cprintf>
  8006e7:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006ea:	e8 ae 12 00 00       	call   80199d <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006ef:	e8 19 00 00 00       	call   80070d <exit>
}
  8006f4:	90                   	nop
  8006f5:	c9                   	leave  
  8006f6:	c3                   	ret    

008006f7 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006f7:	55                   	push   %ebp
  8006f8:	89 e5                	mov    %esp,%ebp
  8006fa:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006fd:	83 ec 0c             	sub    $0xc,%esp
  800700:	6a 00                	push   $0x0
  800702:	e8 ad 10 00 00       	call   8017b4 <sys_env_destroy>
  800707:	83 c4 10             	add    $0x10,%esp
}
  80070a:	90                   	nop
  80070b:	c9                   	leave  
  80070c:	c3                   	ret    

0080070d <exit>:

void
exit(void)
{
  80070d:	55                   	push   %ebp
  80070e:	89 e5                	mov    %esp,%ebp
  800710:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800713:	e8 02 11 00 00       	call   80181a <sys_env_exit>
}
  800718:	90                   	nop
  800719:	c9                   	leave  
  80071a:	c3                   	ret    

0080071b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80071b:	55                   	push   %ebp
  80071c:	89 e5                	mov    %esp,%ebp
  80071e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800721:	8d 45 10             	lea    0x10(%ebp),%eax
  800724:	83 c0 04             	add    $0x4,%eax
  800727:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80072a:	a1 18 f1 80 00       	mov    0x80f118,%eax
  80072f:	85 c0                	test   %eax,%eax
  800731:	74 16                	je     800749 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800733:	a1 18 f1 80 00       	mov    0x80f118,%eax
  800738:	83 ec 08             	sub    $0x8,%esp
  80073b:	50                   	push   %eax
  80073c:	68 58 22 80 00       	push   $0x802258
  800741:	e8 77 02 00 00       	call   8009bd <cprintf>
  800746:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800749:	a1 08 30 80 00       	mov    0x803008,%eax
  80074e:	ff 75 0c             	pushl  0xc(%ebp)
  800751:	ff 75 08             	pushl  0x8(%ebp)
  800754:	50                   	push   %eax
  800755:	68 5d 22 80 00       	push   $0x80225d
  80075a:	e8 5e 02 00 00       	call   8009bd <cprintf>
  80075f:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800762:	8b 45 10             	mov    0x10(%ebp),%eax
  800765:	83 ec 08             	sub    $0x8,%esp
  800768:	ff 75 f4             	pushl  -0xc(%ebp)
  80076b:	50                   	push   %eax
  80076c:	e8 e1 01 00 00       	call   800952 <vcprintf>
  800771:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800774:	83 ec 08             	sub    $0x8,%esp
  800777:	6a 00                	push   $0x0
  800779:	68 79 22 80 00       	push   $0x802279
  80077e:	e8 cf 01 00 00       	call   800952 <vcprintf>
  800783:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800786:	e8 82 ff ff ff       	call   80070d <exit>

	// should not return here
	while (1) ;
  80078b:	eb fe                	jmp    80078b <_panic+0x70>

0080078d <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80078d:	55                   	push   %ebp
  80078e:	89 e5                	mov    %esp,%ebp
  800790:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800793:	a1 20 30 80 00       	mov    0x803020,%eax
  800798:	8b 50 74             	mov    0x74(%eax),%edx
  80079b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80079e:	39 c2                	cmp    %eax,%edx
  8007a0:	74 14                	je     8007b6 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007a2:	83 ec 04             	sub    $0x4,%esp
  8007a5:	68 7c 22 80 00       	push   $0x80227c
  8007aa:	6a 26                	push   $0x26
  8007ac:	68 c8 22 80 00       	push   $0x8022c8
  8007b1:	e8 65 ff ff ff       	call   80071b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007b6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007bd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007c4:	e9 b6 00 00 00       	jmp    80087f <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8007c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007cc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d6:	01 d0                	add    %edx,%eax
  8007d8:	8b 00                	mov    (%eax),%eax
  8007da:	85 c0                	test   %eax,%eax
  8007dc:	75 08                	jne    8007e6 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007de:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007e1:	e9 96 00 00 00       	jmp    80087c <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8007e6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007ed:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007f4:	eb 5d                	jmp    800853 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007f6:	a1 20 30 80 00       	mov    0x803020,%eax
  8007fb:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800801:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800804:	c1 e2 04             	shl    $0x4,%edx
  800807:	01 d0                	add    %edx,%eax
  800809:	8a 40 04             	mov    0x4(%eax),%al
  80080c:	84 c0                	test   %al,%al
  80080e:	75 40                	jne    800850 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800810:	a1 20 30 80 00       	mov    0x803020,%eax
  800815:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80081b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80081e:	c1 e2 04             	shl    $0x4,%edx
  800821:	01 d0                	add    %edx,%eax
  800823:	8b 00                	mov    (%eax),%eax
  800825:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800828:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80082b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800830:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800832:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800835:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80083c:	8b 45 08             	mov    0x8(%ebp),%eax
  80083f:	01 c8                	add    %ecx,%eax
  800841:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800843:	39 c2                	cmp    %eax,%edx
  800845:	75 09                	jne    800850 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800847:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80084e:	eb 12                	jmp    800862 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800850:	ff 45 e8             	incl   -0x18(%ebp)
  800853:	a1 20 30 80 00       	mov    0x803020,%eax
  800858:	8b 50 74             	mov    0x74(%eax),%edx
  80085b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80085e:	39 c2                	cmp    %eax,%edx
  800860:	77 94                	ja     8007f6 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800862:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800866:	75 14                	jne    80087c <CheckWSWithoutLastIndex+0xef>
			panic(
  800868:	83 ec 04             	sub    $0x4,%esp
  80086b:	68 d4 22 80 00       	push   $0x8022d4
  800870:	6a 3a                	push   $0x3a
  800872:	68 c8 22 80 00       	push   $0x8022c8
  800877:	e8 9f fe ff ff       	call   80071b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80087c:	ff 45 f0             	incl   -0x10(%ebp)
  80087f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800882:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800885:	0f 8c 3e ff ff ff    	jl     8007c9 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80088b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800892:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800899:	eb 20                	jmp    8008bb <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80089b:	a1 20 30 80 00       	mov    0x803020,%eax
  8008a0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8008a6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008a9:	c1 e2 04             	shl    $0x4,%edx
  8008ac:	01 d0                	add    %edx,%eax
  8008ae:	8a 40 04             	mov    0x4(%eax),%al
  8008b1:	3c 01                	cmp    $0x1,%al
  8008b3:	75 03                	jne    8008b8 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8008b5:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008b8:	ff 45 e0             	incl   -0x20(%ebp)
  8008bb:	a1 20 30 80 00       	mov    0x803020,%eax
  8008c0:	8b 50 74             	mov    0x74(%eax),%edx
  8008c3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008c6:	39 c2                	cmp    %eax,%edx
  8008c8:	77 d1                	ja     80089b <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008cd:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008d0:	74 14                	je     8008e6 <CheckWSWithoutLastIndex+0x159>
		panic(
  8008d2:	83 ec 04             	sub    $0x4,%esp
  8008d5:	68 28 23 80 00       	push   $0x802328
  8008da:	6a 44                	push   $0x44
  8008dc:	68 c8 22 80 00       	push   $0x8022c8
  8008e1:	e8 35 fe ff ff       	call   80071b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008e6:	90                   	nop
  8008e7:	c9                   	leave  
  8008e8:	c3                   	ret    

008008e9 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008e9:	55                   	push   %ebp
  8008ea:	89 e5                	mov    %esp,%ebp
  8008ec:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f2:	8b 00                	mov    (%eax),%eax
  8008f4:	8d 48 01             	lea    0x1(%eax),%ecx
  8008f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008fa:	89 0a                	mov    %ecx,(%edx)
  8008fc:	8b 55 08             	mov    0x8(%ebp),%edx
  8008ff:	88 d1                	mov    %dl,%cl
  800901:	8b 55 0c             	mov    0xc(%ebp),%edx
  800904:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800908:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090b:	8b 00                	mov    (%eax),%eax
  80090d:	3d ff 00 00 00       	cmp    $0xff,%eax
  800912:	75 2c                	jne    800940 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800914:	a0 24 30 80 00       	mov    0x803024,%al
  800919:	0f b6 c0             	movzbl %al,%eax
  80091c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80091f:	8b 12                	mov    (%edx),%edx
  800921:	89 d1                	mov    %edx,%ecx
  800923:	8b 55 0c             	mov    0xc(%ebp),%edx
  800926:	83 c2 08             	add    $0x8,%edx
  800929:	83 ec 04             	sub    $0x4,%esp
  80092c:	50                   	push   %eax
  80092d:	51                   	push   %ecx
  80092e:	52                   	push   %edx
  80092f:	e8 3e 0e 00 00       	call   801772 <sys_cputs>
  800934:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800937:	8b 45 0c             	mov    0xc(%ebp),%eax
  80093a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800940:	8b 45 0c             	mov    0xc(%ebp),%eax
  800943:	8b 40 04             	mov    0x4(%eax),%eax
  800946:	8d 50 01             	lea    0x1(%eax),%edx
  800949:	8b 45 0c             	mov    0xc(%ebp),%eax
  80094c:	89 50 04             	mov    %edx,0x4(%eax)
}
  80094f:	90                   	nop
  800950:	c9                   	leave  
  800951:	c3                   	ret    

00800952 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800952:	55                   	push   %ebp
  800953:	89 e5                	mov    %esp,%ebp
  800955:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80095b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800962:	00 00 00 
	b.cnt = 0;
  800965:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80096c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80096f:	ff 75 0c             	pushl  0xc(%ebp)
  800972:	ff 75 08             	pushl  0x8(%ebp)
  800975:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80097b:	50                   	push   %eax
  80097c:	68 e9 08 80 00       	push   $0x8008e9
  800981:	e8 11 02 00 00       	call   800b97 <vprintfmt>
  800986:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800989:	a0 24 30 80 00       	mov    0x803024,%al
  80098e:	0f b6 c0             	movzbl %al,%eax
  800991:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800997:	83 ec 04             	sub    $0x4,%esp
  80099a:	50                   	push   %eax
  80099b:	52                   	push   %edx
  80099c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009a2:	83 c0 08             	add    $0x8,%eax
  8009a5:	50                   	push   %eax
  8009a6:	e8 c7 0d 00 00       	call   801772 <sys_cputs>
  8009ab:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009ae:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8009b5:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009bb:	c9                   	leave  
  8009bc:	c3                   	ret    

008009bd <cprintf>:

int cprintf(const char *fmt, ...) {
  8009bd:	55                   	push   %ebp
  8009be:	89 e5                	mov    %esp,%ebp
  8009c0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009c3:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8009ca:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d3:	83 ec 08             	sub    $0x8,%esp
  8009d6:	ff 75 f4             	pushl  -0xc(%ebp)
  8009d9:	50                   	push   %eax
  8009da:	e8 73 ff ff ff       	call   800952 <vcprintf>
  8009df:	83 c4 10             	add    $0x10,%esp
  8009e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009e8:	c9                   	leave  
  8009e9:	c3                   	ret    

008009ea <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009ea:	55                   	push   %ebp
  8009eb:	89 e5                	mov    %esp,%ebp
  8009ed:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009f0:	e8 8e 0f 00 00       	call   801983 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009f5:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fe:	83 ec 08             	sub    $0x8,%esp
  800a01:	ff 75 f4             	pushl  -0xc(%ebp)
  800a04:	50                   	push   %eax
  800a05:	e8 48 ff ff ff       	call   800952 <vcprintf>
  800a0a:	83 c4 10             	add    $0x10,%esp
  800a0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a10:	e8 88 0f 00 00       	call   80199d <sys_enable_interrupt>
	return cnt;
  800a15:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a18:	c9                   	leave  
  800a19:	c3                   	ret    

00800a1a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a1a:	55                   	push   %ebp
  800a1b:	89 e5                	mov    %esp,%ebp
  800a1d:	53                   	push   %ebx
  800a1e:	83 ec 14             	sub    $0x14,%esp
  800a21:	8b 45 10             	mov    0x10(%ebp),%eax
  800a24:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a27:	8b 45 14             	mov    0x14(%ebp),%eax
  800a2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a2d:	8b 45 18             	mov    0x18(%ebp),%eax
  800a30:	ba 00 00 00 00       	mov    $0x0,%edx
  800a35:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a38:	77 55                	ja     800a8f <printnum+0x75>
  800a3a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a3d:	72 05                	jb     800a44 <printnum+0x2a>
  800a3f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a42:	77 4b                	ja     800a8f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a44:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a47:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a4a:	8b 45 18             	mov    0x18(%ebp),%eax
  800a4d:	ba 00 00 00 00       	mov    $0x0,%edx
  800a52:	52                   	push   %edx
  800a53:	50                   	push   %eax
  800a54:	ff 75 f4             	pushl  -0xc(%ebp)
  800a57:	ff 75 f0             	pushl  -0x10(%ebp)
  800a5a:	e8 45 13 00 00       	call   801da4 <__udivdi3>
  800a5f:	83 c4 10             	add    $0x10,%esp
  800a62:	83 ec 04             	sub    $0x4,%esp
  800a65:	ff 75 20             	pushl  0x20(%ebp)
  800a68:	53                   	push   %ebx
  800a69:	ff 75 18             	pushl  0x18(%ebp)
  800a6c:	52                   	push   %edx
  800a6d:	50                   	push   %eax
  800a6e:	ff 75 0c             	pushl  0xc(%ebp)
  800a71:	ff 75 08             	pushl  0x8(%ebp)
  800a74:	e8 a1 ff ff ff       	call   800a1a <printnum>
  800a79:	83 c4 20             	add    $0x20,%esp
  800a7c:	eb 1a                	jmp    800a98 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a7e:	83 ec 08             	sub    $0x8,%esp
  800a81:	ff 75 0c             	pushl  0xc(%ebp)
  800a84:	ff 75 20             	pushl  0x20(%ebp)
  800a87:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8a:	ff d0                	call   *%eax
  800a8c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a8f:	ff 4d 1c             	decl   0x1c(%ebp)
  800a92:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a96:	7f e6                	jg     800a7e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a98:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a9b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800aa0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aa3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800aa6:	53                   	push   %ebx
  800aa7:	51                   	push   %ecx
  800aa8:	52                   	push   %edx
  800aa9:	50                   	push   %eax
  800aaa:	e8 05 14 00 00       	call   801eb4 <__umoddi3>
  800aaf:	83 c4 10             	add    $0x10,%esp
  800ab2:	05 94 25 80 00       	add    $0x802594,%eax
  800ab7:	8a 00                	mov    (%eax),%al
  800ab9:	0f be c0             	movsbl %al,%eax
  800abc:	83 ec 08             	sub    $0x8,%esp
  800abf:	ff 75 0c             	pushl  0xc(%ebp)
  800ac2:	50                   	push   %eax
  800ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac6:	ff d0                	call   *%eax
  800ac8:	83 c4 10             	add    $0x10,%esp
}
  800acb:	90                   	nop
  800acc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800acf:	c9                   	leave  
  800ad0:	c3                   	ret    

00800ad1 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ad1:	55                   	push   %ebp
  800ad2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ad4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ad8:	7e 1c                	jle    800af6 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ada:	8b 45 08             	mov    0x8(%ebp),%eax
  800add:	8b 00                	mov    (%eax),%eax
  800adf:	8d 50 08             	lea    0x8(%eax),%edx
  800ae2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae5:	89 10                	mov    %edx,(%eax)
  800ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aea:	8b 00                	mov    (%eax),%eax
  800aec:	83 e8 08             	sub    $0x8,%eax
  800aef:	8b 50 04             	mov    0x4(%eax),%edx
  800af2:	8b 00                	mov    (%eax),%eax
  800af4:	eb 40                	jmp    800b36 <getuint+0x65>
	else if (lflag)
  800af6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800afa:	74 1e                	je     800b1a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800afc:	8b 45 08             	mov    0x8(%ebp),%eax
  800aff:	8b 00                	mov    (%eax),%eax
  800b01:	8d 50 04             	lea    0x4(%eax),%edx
  800b04:	8b 45 08             	mov    0x8(%ebp),%eax
  800b07:	89 10                	mov    %edx,(%eax)
  800b09:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0c:	8b 00                	mov    (%eax),%eax
  800b0e:	83 e8 04             	sub    $0x4,%eax
  800b11:	8b 00                	mov    (%eax),%eax
  800b13:	ba 00 00 00 00       	mov    $0x0,%edx
  800b18:	eb 1c                	jmp    800b36 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1d:	8b 00                	mov    (%eax),%eax
  800b1f:	8d 50 04             	lea    0x4(%eax),%edx
  800b22:	8b 45 08             	mov    0x8(%ebp),%eax
  800b25:	89 10                	mov    %edx,(%eax)
  800b27:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2a:	8b 00                	mov    (%eax),%eax
  800b2c:	83 e8 04             	sub    $0x4,%eax
  800b2f:	8b 00                	mov    (%eax),%eax
  800b31:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b36:	5d                   	pop    %ebp
  800b37:	c3                   	ret    

00800b38 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b38:	55                   	push   %ebp
  800b39:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b3b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b3f:	7e 1c                	jle    800b5d <getint+0x25>
		return va_arg(*ap, long long);
  800b41:	8b 45 08             	mov    0x8(%ebp),%eax
  800b44:	8b 00                	mov    (%eax),%eax
  800b46:	8d 50 08             	lea    0x8(%eax),%edx
  800b49:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4c:	89 10                	mov    %edx,(%eax)
  800b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b51:	8b 00                	mov    (%eax),%eax
  800b53:	83 e8 08             	sub    $0x8,%eax
  800b56:	8b 50 04             	mov    0x4(%eax),%edx
  800b59:	8b 00                	mov    (%eax),%eax
  800b5b:	eb 38                	jmp    800b95 <getint+0x5d>
	else if (lflag)
  800b5d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b61:	74 1a                	je     800b7d <getint+0x45>
		return va_arg(*ap, long);
  800b63:	8b 45 08             	mov    0x8(%ebp),%eax
  800b66:	8b 00                	mov    (%eax),%eax
  800b68:	8d 50 04             	lea    0x4(%eax),%edx
  800b6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6e:	89 10                	mov    %edx,(%eax)
  800b70:	8b 45 08             	mov    0x8(%ebp),%eax
  800b73:	8b 00                	mov    (%eax),%eax
  800b75:	83 e8 04             	sub    $0x4,%eax
  800b78:	8b 00                	mov    (%eax),%eax
  800b7a:	99                   	cltd   
  800b7b:	eb 18                	jmp    800b95 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b80:	8b 00                	mov    (%eax),%eax
  800b82:	8d 50 04             	lea    0x4(%eax),%edx
  800b85:	8b 45 08             	mov    0x8(%ebp),%eax
  800b88:	89 10                	mov    %edx,(%eax)
  800b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8d:	8b 00                	mov    (%eax),%eax
  800b8f:	83 e8 04             	sub    $0x4,%eax
  800b92:	8b 00                	mov    (%eax),%eax
  800b94:	99                   	cltd   
}
  800b95:	5d                   	pop    %ebp
  800b96:	c3                   	ret    

00800b97 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b97:	55                   	push   %ebp
  800b98:	89 e5                	mov    %esp,%ebp
  800b9a:	56                   	push   %esi
  800b9b:	53                   	push   %ebx
  800b9c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b9f:	eb 17                	jmp    800bb8 <vprintfmt+0x21>
			if (ch == '\0')
  800ba1:	85 db                	test   %ebx,%ebx
  800ba3:	0f 84 af 03 00 00    	je     800f58 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800ba9:	83 ec 08             	sub    $0x8,%esp
  800bac:	ff 75 0c             	pushl  0xc(%ebp)
  800baf:	53                   	push   %ebx
  800bb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb3:	ff d0                	call   *%eax
  800bb5:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bb8:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbb:	8d 50 01             	lea    0x1(%eax),%edx
  800bbe:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc1:	8a 00                	mov    (%eax),%al
  800bc3:	0f b6 d8             	movzbl %al,%ebx
  800bc6:	83 fb 25             	cmp    $0x25,%ebx
  800bc9:	75 d6                	jne    800ba1 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bcb:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bcf:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bd6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bdd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800be4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800beb:	8b 45 10             	mov    0x10(%ebp),%eax
  800bee:	8d 50 01             	lea    0x1(%eax),%edx
  800bf1:	89 55 10             	mov    %edx,0x10(%ebp)
  800bf4:	8a 00                	mov    (%eax),%al
  800bf6:	0f b6 d8             	movzbl %al,%ebx
  800bf9:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bfc:	83 f8 55             	cmp    $0x55,%eax
  800bff:	0f 87 2b 03 00 00    	ja     800f30 <vprintfmt+0x399>
  800c05:	8b 04 85 b8 25 80 00 	mov    0x8025b8(,%eax,4),%eax
  800c0c:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c0e:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c12:	eb d7                	jmp    800beb <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c14:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c18:	eb d1                	jmp    800beb <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c1a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c21:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c24:	89 d0                	mov    %edx,%eax
  800c26:	c1 e0 02             	shl    $0x2,%eax
  800c29:	01 d0                	add    %edx,%eax
  800c2b:	01 c0                	add    %eax,%eax
  800c2d:	01 d8                	add    %ebx,%eax
  800c2f:	83 e8 30             	sub    $0x30,%eax
  800c32:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c35:	8b 45 10             	mov    0x10(%ebp),%eax
  800c38:	8a 00                	mov    (%eax),%al
  800c3a:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c3d:	83 fb 2f             	cmp    $0x2f,%ebx
  800c40:	7e 3e                	jle    800c80 <vprintfmt+0xe9>
  800c42:	83 fb 39             	cmp    $0x39,%ebx
  800c45:	7f 39                	jg     800c80 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c47:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c4a:	eb d5                	jmp    800c21 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c4c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c4f:	83 c0 04             	add    $0x4,%eax
  800c52:	89 45 14             	mov    %eax,0x14(%ebp)
  800c55:	8b 45 14             	mov    0x14(%ebp),%eax
  800c58:	83 e8 04             	sub    $0x4,%eax
  800c5b:	8b 00                	mov    (%eax),%eax
  800c5d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c60:	eb 1f                	jmp    800c81 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c62:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c66:	79 83                	jns    800beb <vprintfmt+0x54>
				width = 0;
  800c68:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c6f:	e9 77 ff ff ff       	jmp    800beb <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c74:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c7b:	e9 6b ff ff ff       	jmp    800beb <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c80:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c81:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c85:	0f 89 60 ff ff ff    	jns    800beb <vprintfmt+0x54>
				width = precision, precision = -1;
  800c8b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c8e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c91:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c98:	e9 4e ff ff ff       	jmp    800beb <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c9d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800ca0:	e9 46 ff ff ff       	jmp    800beb <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ca5:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca8:	83 c0 04             	add    $0x4,%eax
  800cab:	89 45 14             	mov    %eax,0x14(%ebp)
  800cae:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb1:	83 e8 04             	sub    $0x4,%eax
  800cb4:	8b 00                	mov    (%eax),%eax
  800cb6:	83 ec 08             	sub    $0x8,%esp
  800cb9:	ff 75 0c             	pushl  0xc(%ebp)
  800cbc:	50                   	push   %eax
  800cbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc0:	ff d0                	call   *%eax
  800cc2:	83 c4 10             	add    $0x10,%esp
			break;
  800cc5:	e9 89 02 00 00       	jmp    800f53 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cca:	8b 45 14             	mov    0x14(%ebp),%eax
  800ccd:	83 c0 04             	add    $0x4,%eax
  800cd0:	89 45 14             	mov    %eax,0x14(%ebp)
  800cd3:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd6:	83 e8 04             	sub    $0x4,%eax
  800cd9:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cdb:	85 db                	test   %ebx,%ebx
  800cdd:	79 02                	jns    800ce1 <vprintfmt+0x14a>
				err = -err;
  800cdf:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ce1:	83 fb 64             	cmp    $0x64,%ebx
  800ce4:	7f 0b                	jg     800cf1 <vprintfmt+0x15a>
  800ce6:	8b 34 9d 00 24 80 00 	mov    0x802400(,%ebx,4),%esi
  800ced:	85 f6                	test   %esi,%esi
  800cef:	75 19                	jne    800d0a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cf1:	53                   	push   %ebx
  800cf2:	68 a5 25 80 00       	push   $0x8025a5
  800cf7:	ff 75 0c             	pushl  0xc(%ebp)
  800cfa:	ff 75 08             	pushl  0x8(%ebp)
  800cfd:	e8 5e 02 00 00       	call   800f60 <printfmt>
  800d02:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d05:	e9 49 02 00 00       	jmp    800f53 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d0a:	56                   	push   %esi
  800d0b:	68 ae 25 80 00       	push   $0x8025ae
  800d10:	ff 75 0c             	pushl  0xc(%ebp)
  800d13:	ff 75 08             	pushl  0x8(%ebp)
  800d16:	e8 45 02 00 00       	call   800f60 <printfmt>
  800d1b:	83 c4 10             	add    $0x10,%esp
			break;
  800d1e:	e9 30 02 00 00       	jmp    800f53 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d23:	8b 45 14             	mov    0x14(%ebp),%eax
  800d26:	83 c0 04             	add    $0x4,%eax
  800d29:	89 45 14             	mov    %eax,0x14(%ebp)
  800d2c:	8b 45 14             	mov    0x14(%ebp),%eax
  800d2f:	83 e8 04             	sub    $0x4,%eax
  800d32:	8b 30                	mov    (%eax),%esi
  800d34:	85 f6                	test   %esi,%esi
  800d36:	75 05                	jne    800d3d <vprintfmt+0x1a6>
				p = "(null)";
  800d38:	be b1 25 80 00       	mov    $0x8025b1,%esi
			if (width > 0 && padc != '-')
  800d3d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d41:	7e 6d                	jle    800db0 <vprintfmt+0x219>
  800d43:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d47:	74 67                	je     800db0 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d49:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d4c:	83 ec 08             	sub    $0x8,%esp
  800d4f:	50                   	push   %eax
  800d50:	56                   	push   %esi
  800d51:	e8 0c 03 00 00       	call   801062 <strnlen>
  800d56:	83 c4 10             	add    $0x10,%esp
  800d59:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d5c:	eb 16                	jmp    800d74 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d5e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d62:	83 ec 08             	sub    $0x8,%esp
  800d65:	ff 75 0c             	pushl  0xc(%ebp)
  800d68:	50                   	push   %eax
  800d69:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6c:	ff d0                	call   *%eax
  800d6e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d71:	ff 4d e4             	decl   -0x1c(%ebp)
  800d74:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d78:	7f e4                	jg     800d5e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d7a:	eb 34                	jmp    800db0 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d7c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d80:	74 1c                	je     800d9e <vprintfmt+0x207>
  800d82:	83 fb 1f             	cmp    $0x1f,%ebx
  800d85:	7e 05                	jle    800d8c <vprintfmt+0x1f5>
  800d87:	83 fb 7e             	cmp    $0x7e,%ebx
  800d8a:	7e 12                	jle    800d9e <vprintfmt+0x207>
					putch('?', putdat);
  800d8c:	83 ec 08             	sub    $0x8,%esp
  800d8f:	ff 75 0c             	pushl  0xc(%ebp)
  800d92:	6a 3f                	push   $0x3f
  800d94:	8b 45 08             	mov    0x8(%ebp),%eax
  800d97:	ff d0                	call   *%eax
  800d99:	83 c4 10             	add    $0x10,%esp
  800d9c:	eb 0f                	jmp    800dad <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d9e:	83 ec 08             	sub    $0x8,%esp
  800da1:	ff 75 0c             	pushl  0xc(%ebp)
  800da4:	53                   	push   %ebx
  800da5:	8b 45 08             	mov    0x8(%ebp),%eax
  800da8:	ff d0                	call   *%eax
  800daa:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dad:	ff 4d e4             	decl   -0x1c(%ebp)
  800db0:	89 f0                	mov    %esi,%eax
  800db2:	8d 70 01             	lea    0x1(%eax),%esi
  800db5:	8a 00                	mov    (%eax),%al
  800db7:	0f be d8             	movsbl %al,%ebx
  800dba:	85 db                	test   %ebx,%ebx
  800dbc:	74 24                	je     800de2 <vprintfmt+0x24b>
  800dbe:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dc2:	78 b8                	js     800d7c <vprintfmt+0x1e5>
  800dc4:	ff 4d e0             	decl   -0x20(%ebp)
  800dc7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dcb:	79 af                	jns    800d7c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dcd:	eb 13                	jmp    800de2 <vprintfmt+0x24b>
				putch(' ', putdat);
  800dcf:	83 ec 08             	sub    $0x8,%esp
  800dd2:	ff 75 0c             	pushl  0xc(%ebp)
  800dd5:	6a 20                	push   $0x20
  800dd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dda:	ff d0                	call   *%eax
  800ddc:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ddf:	ff 4d e4             	decl   -0x1c(%ebp)
  800de2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800de6:	7f e7                	jg     800dcf <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800de8:	e9 66 01 00 00       	jmp    800f53 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ded:	83 ec 08             	sub    $0x8,%esp
  800df0:	ff 75 e8             	pushl  -0x18(%ebp)
  800df3:	8d 45 14             	lea    0x14(%ebp),%eax
  800df6:	50                   	push   %eax
  800df7:	e8 3c fd ff ff       	call   800b38 <getint>
  800dfc:	83 c4 10             	add    $0x10,%esp
  800dff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e02:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e05:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e08:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e0b:	85 d2                	test   %edx,%edx
  800e0d:	79 23                	jns    800e32 <vprintfmt+0x29b>
				putch('-', putdat);
  800e0f:	83 ec 08             	sub    $0x8,%esp
  800e12:	ff 75 0c             	pushl  0xc(%ebp)
  800e15:	6a 2d                	push   $0x2d
  800e17:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1a:	ff d0                	call   *%eax
  800e1c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e1f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e22:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e25:	f7 d8                	neg    %eax
  800e27:	83 d2 00             	adc    $0x0,%edx
  800e2a:	f7 da                	neg    %edx
  800e2c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e2f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e32:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e39:	e9 bc 00 00 00       	jmp    800efa <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e3e:	83 ec 08             	sub    $0x8,%esp
  800e41:	ff 75 e8             	pushl  -0x18(%ebp)
  800e44:	8d 45 14             	lea    0x14(%ebp),%eax
  800e47:	50                   	push   %eax
  800e48:	e8 84 fc ff ff       	call   800ad1 <getuint>
  800e4d:	83 c4 10             	add    $0x10,%esp
  800e50:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e53:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e56:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e5d:	e9 98 00 00 00       	jmp    800efa <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e62:	83 ec 08             	sub    $0x8,%esp
  800e65:	ff 75 0c             	pushl  0xc(%ebp)
  800e68:	6a 58                	push   $0x58
  800e6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6d:	ff d0                	call   *%eax
  800e6f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e72:	83 ec 08             	sub    $0x8,%esp
  800e75:	ff 75 0c             	pushl  0xc(%ebp)
  800e78:	6a 58                	push   $0x58
  800e7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7d:	ff d0                	call   *%eax
  800e7f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e82:	83 ec 08             	sub    $0x8,%esp
  800e85:	ff 75 0c             	pushl  0xc(%ebp)
  800e88:	6a 58                	push   $0x58
  800e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8d:	ff d0                	call   *%eax
  800e8f:	83 c4 10             	add    $0x10,%esp
			break;
  800e92:	e9 bc 00 00 00       	jmp    800f53 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e97:	83 ec 08             	sub    $0x8,%esp
  800e9a:	ff 75 0c             	pushl  0xc(%ebp)
  800e9d:	6a 30                	push   $0x30
  800e9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea2:	ff d0                	call   *%eax
  800ea4:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ea7:	83 ec 08             	sub    $0x8,%esp
  800eaa:	ff 75 0c             	pushl  0xc(%ebp)
  800ead:	6a 78                	push   $0x78
  800eaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb2:	ff d0                	call   *%eax
  800eb4:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800eb7:	8b 45 14             	mov    0x14(%ebp),%eax
  800eba:	83 c0 04             	add    $0x4,%eax
  800ebd:	89 45 14             	mov    %eax,0x14(%ebp)
  800ec0:	8b 45 14             	mov    0x14(%ebp),%eax
  800ec3:	83 e8 04             	sub    $0x4,%eax
  800ec6:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ec8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ecb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ed2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ed9:	eb 1f                	jmp    800efa <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800edb:	83 ec 08             	sub    $0x8,%esp
  800ede:	ff 75 e8             	pushl  -0x18(%ebp)
  800ee1:	8d 45 14             	lea    0x14(%ebp),%eax
  800ee4:	50                   	push   %eax
  800ee5:	e8 e7 fb ff ff       	call   800ad1 <getuint>
  800eea:	83 c4 10             	add    $0x10,%esp
  800eed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ef0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ef3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800efa:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800efe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f01:	83 ec 04             	sub    $0x4,%esp
  800f04:	52                   	push   %edx
  800f05:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f08:	50                   	push   %eax
  800f09:	ff 75 f4             	pushl  -0xc(%ebp)
  800f0c:	ff 75 f0             	pushl  -0x10(%ebp)
  800f0f:	ff 75 0c             	pushl  0xc(%ebp)
  800f12:	ff 75 08             	pushl  0x8(%ebp)
  800f15:	e8 00 fb ff ff       	call   800a1a <printnum>
  800f1a:	83 c4 20             	add    $0x20,%esp
			break;
  800f1d:	eb 34                	jmp    800f53 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f1f:	83 ec 08             	sub    $0x8,%esp
  800f22:	ff 75 0c             	pushl  0xc(%ebp)
  800f25:	53                   	push   %ebx
  800f26:	8b 45 08             	mov    0x8(%ebp),%eax
  800f29:	ff d0                	call   *%eax
  800f2b:	83 c4 10             	add    $0x10,%esp
			break;
  800f2e:	eb 23                	jmp    800f53 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f30:	83 ec 08             	sub    $0x8,%esp
  800f33:	ff 75 0c             	pushl  0xc(%ebp)
  800f36:	6a 25                	push   $0x25
  800f38:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3b:	ff d0                	call   *%eax
  800f3d:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f40:	ff 4d 10             	decl   0x10(%ebp)
  800f43:	eb 03                	jmp    800f48 <vprintfmt+0x3b1>
  800f45:	ff 4d 10             	decl   0x10(%ebp)
  800f48:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4b:	48                   	dec    %eax
  800f4c:	8a 00                	mov    (%eax),%al
  800f4e:	3c 25                	cmp    $0x25,%al
  800f50:	75 f3                	jne    800f45 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f52:	90                   	nop
		}
	}
  800f53:	e9 47 fc ff ff       	jmp    800b9f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f58:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f59:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f5c:	5b                   	pop    %ebx
  800f5d:	5e                   	pop    %esi
  800f5e:	5d                   	pop    %ebp
  800f5f:	c3                   	ret    

00800f60 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f60:	55                   	push   %ebp
  800f61:	89 e5                	mov    %esp,%ebp
  800f63:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f66:	8d 45 10             	lea    0x10(%ebp),%eax
  800f69:	83 c0 04             	add    $0x4,%eax
  800f6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f6f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f72:	ff 75 f4             	pushl  -0xc(%ebp)
  800f75:	50                   	push   %eax
  800f76:	ff 75 0c             	pushl  0xc(%ebp)
  800f79:	ff 75 08             	pushl  0x8(%ebp)
  800f7c:	e8 16 fc ff ff       	call   800b97 <vprintfmt>
  800f81:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f84:	90                   	nop
  800f85:	c9                   	leave  
  800f86:	c3                   	ret    

00800f87 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f87:	55                   	push   %ebp
  800f88:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8d:	8b 40 08             	mov    0x8(%eax),%eax
  800f90:	8d 50 01             	lea    0x1(%eax),%edx
  800f93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f96:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9c:	8b 10                	mov    (%eax),%edx
  800f9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa1:	8b 40 04             	mov    0x4(%eax),%eax
  800fa4:	39 c2                	cmp    %eax,%edx
  800fa6:	73 12                	jae    800fba <sprintputch+0x33>
		*b->buf++ = ch;
  800fa8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fab:	8b 00                	mov    (%eax),%eax
  800fad:	8d 48 01             	lea    0x1(%eax),%ecx
  800fb0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fb3:	89 0a                	mov    %ecx,(%edx)
  800fb5:	8b 55 08             	mov    0x8(%ebp),%edx
  800fb8:	88 10                	mov    %dl,(%eax)
}
  800fba:	90                   	nop
  800fbb:	5d                   	pop    %ebp
  800fbc:	c3                   	ret    

00800fbd <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fbd:	55                   	push   %ebp
  800fbe:	89 e5                	mov    %esp,%ebp
  800fc0:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fc9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fcc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd2:	01 d0                	add    %edx,%eax
  800fd4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fd7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fde:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fe2:	74 06                	je     800fea <vsnprintf+0x2d>
  800fe4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fe8:	7f 07                	jg     800ff1 <vsnprintf+0x34>
		return -E_INVAL;
  800fea:	b8 03 00 00 00       	mov    $0x3,%eax
  800fef:	eb 20                	jmp    801011 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ff1:	ff 75 14             	pushl  0x14(%ebp)
  800ff4:	ff 75 10             	pushl  0x10(%ebp)
  800ff7:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ffa:	50                   	push   %eax
  800ffb:	68 87 0f 80 00       	push   $0x800f87
  801000:	e8 92 fb ff ff       	call   800b97 <vprintfmt>
  801005:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801008:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80100b:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80100e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801011:	c9                   	leave  
  801012:	c3                   	ret    

00801013 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801013:	55                   	push   %ebp
  801014:	89 e5                	mov    %esp,%ebp
  801016:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801019:	8d 45 10             	lea    0x10(%ebp),%eax
  80101c:	83 c0 04             	add    $0x4,%eax
  80101f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801022:	8b 45 10             	mov    0x10(%ebp),%eax
  801025:	ff 75 f4             	pushl  -0xc(%ebp)
  801028:	50                   	push   %eax
  801029:	ff 75 0c             	pushl  0xc(%ebp)
  80102c:	ff 75 08             	pushl  0x8(%ebp)
  80102f:	e8 89 ff ff ff       	call   800fbd <vsnprintf>
  801034:	83 c4 10             	add    $0x10,%esp
  801037:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80103a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80103d:	c9                   	leave  
  80103e:	c3                   	ret    

0080103f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80103f:	55                   	push   %ebp
  801040:	89 e5                	mov    %esp,%ebp
  801042:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801045:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80104c:	eb 06                	jmp    801054 <strlen+0x15>
		n++;
  80104e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801051:	ff 45 08             	incl   0x8(%ebp)
  801054:	8b 45 08             	mov    0x8(%ebp),%eax
  801057:	8a 00                	mov    (%eax),%al
  801059:	84 c0                	test   %al,%al
  80105b:	75 f1                	jne    80104e <strlen+0xf>
		n++;
	return n;
  80105d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801060:	c9                   	leave  
  801061:	c3                   	ret    

00801062 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801062:	55                   	push   %ebp
  801063:	89 e5                	mov    %esp,%ebp
  801065:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801068:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80106f:	eb 09                	jmp    80107a <strnlen+0x18>
		n++;
  801071:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801074:	ff 45 08             	incl   0x8(%ebp)
  801077:	ff 4d 0c             	decl   0xc(%ebp)
  80107a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80107e:	74 09                	je     801089 <strnlen+0x27>
  801080:	8b 45 08             	mov    0x8(%ebp),%eax
  801083:	8a 00                	mov    (%eax),%al
  801085:	84 c0                	test   %al,%al
  801087:	75 e8                	jne    801071 <strnlen+0xf>
		n++;
	return n;
  801089:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80108c:	c9                   	leave  
  80108d:	c3                   	ret    

0080108e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80108e:	55                   	push   %ebp
  80108f:	89 e5                	mov    %esp,%ebp
  801091:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801094:	8b 45 08             	mov    0x8(%ebp),%eax
  801097:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80109a:	90                   	nop
  80109b:	8b 45 08             	mov    0x8(%ebp),%eax
  80109e:	8d 50 01             	lea    0x1(%eax),%edx
  8010a1:	89 55 08             	mov    %edx,0x8(%ebp)
  8010a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010a7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010aa:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010ad:	8a 12                	mov    (%edx),%dl
  8010af:	88 10                	mov    %dl,(%eax)
  8010b1:	8a 00                	mov    (%eax),%al
  8010b3:	84 c0                	test   %al,%al
  8010b5:	75 e4                	jne    80109b <strcpy+0xd>
		/* do nothing */;
	return ret;
  8010b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010ba:	c9                   	leave  
  8010bb:	c3                   	ret    

008010bc <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8010bc:	55                   	push   %ebp
  8010bd:	89 e5                	mov    %esp,%ebp
  8010bf:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8010c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8010c8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010cf:	eb 1f                	jmp    8010f0 <strncpy+0x34>
		*dst++ = *src;
  8010d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d4:	8d 50 01             	lea    0x1(%eax),%edx
  8010d7:	89 55 08             	mov    %edx,0x8(%ebp)
  8010da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010dd:	8a 12                	mov    (%edx),%dl
  8010df:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e4:	8a 00                	mov    (%eax),%al
  8010e6:	84 c0                	test   %al,%al
  8010e8:	74 03                	je     8010ed <strncpy+0x31>
			src++;
  8010ea:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010ed:	ff 45 fc             	incl   -0x4(%ebp)
  8010f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010f3:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010f6:	72 d9                	jb     8010d1 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010fb:	c9                   	leave  
  8010fc:	c3                   	ret    

008010fd <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010fd:	55                   	push   %ebp
  8010fe:	89 e5                	mov    %esp,%ebp
  801100:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801103:	8b 45 08             	mov    0x8(%ebp),%eax
  801106:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801109:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80110d:	74 30                	je     80113f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80110f:	eb 16                	jmp    801127 <strlcpy+0x2a>
			*dst++ = *src++;
  801111:	8b 45 08             	mov    0x8(%ebp),%eax
  801114:	8d 50 01             	lea    0x1(%eax),%edx
  801117:	89 55 08             	mov    %edx,0x8(%ebp)
  80111a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80111d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801120:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801123:	8a 12                	mov    (%edx),%dl
  801125:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801127:	ff 4d 10             	decl   0x10(%ebp)
  80112a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80112e:	74 09                	je     801139 <strlcpy+0x3c>
  801130:	8b 45 0c             	mov    0xc(%ebp),%eax
  801133:	8a 00                	mov    (%eax),%al
  801135:	84 c0                	test   %al,%al
  801137:	75 d8                	jne    801111 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801139:	8b 45 08             	mov    0x8(%ebp),%eax
  80113c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80113f:	8b 55 08             	mov    0x8(%ebp),%edx
  801142:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801145:	29 c2                	sub    %eax,%edx
  801147:	89 d0                	mov    %edx,%eax
}
  801149:	c9                   	leave  
  80114a:	c3                   	ret    

0080114b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80114b:	55                   	push   %ebp
  80114c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80114e:	eb 06                	jmp    801156 <strcmp+0xb>
		p++, q++;
  801150:	ff 45 08             	incl   0x8(%ebp)
  801153:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801156:	8b 45 08             	mov    0x8(%ebp),%eax
  801159:	8a 00                	mov    (%eax),%al
  80115b:	84 c0                	test   %al,%al
  80115d:	74 0e                	je     80116d <strcmp+0x22>
  80115f:	8b 45 08             	mov    0x8(%ebp),%eax
  801162:	8a 10                	mov    (%eax),%dl
  801164:	8b 45 0c             	mov    0xc(%ebp),%eax
  801167:	8a 00                	mov    (%eax),%al
  801169:	38 c2                	cmp    %al,%dl
  80116b:	74 e3                	je     801150 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80116d:	8b 45 08             	mov    0x8(%ebp),%eax
  801170:	8a 00                	mov    (%eax),%al
  801172:	0f b6 d0             	movzbl %al,%edx
  801175:	8b 45 0c             	mov    0xc(%ebp),%eax
  801178:	8a 00                	mov    (%eax),%al
  80117a:	0f b6 c0             	movzbl %al,%eax
  80117d:	29 c2                	sub    %eax,%edx
  80117f:	89 d0                	mov    %edx,%eax
}
  801181:	5d                   	pop    %ebp
  801182:	c3                   	ret    

00801183 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801183:	55                   	push   %ebp
  801184:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801186:	eb 09                	jmp    801191 <strncmp+0xe>
		n--, p++, q++;
  801188:	ff 4d 10             	decl   0x10(%ebp)
  80118b:	ff 45 08             	incl   0x8(%ebp)
  80118e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801191:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801195:	74 17                	je     8011ae <strncmp+0x2b>
  801197:	8b 45 08             	mov    0x8(%ebp),%eax
  80119a:	8a 00                	mov    (%eax),%al
  80119c:	84 c0                	test   %al,%al
  80119e:	74 0e                	je     8011ae <strncmp+0x2b>
  8011a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a3:	8a 10                	mov    (%eax),%dl
  8011a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a8:	8a 00                	mov    (%eax),%al
  8011aa:	38 c2                	cmp    %al,%dl
  8011ac:	74 da                	je     801188 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8011ae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011b2:	75 07                	jne    8011bb <strncmp+0x38>
		return 0;
  8011b4:	b8 00 00 00 00       	mov    $0x0,%eax
  8011b9:	eb 14                	jmp    8011cf <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8011bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011be:	8a 00                	mov    (%eax),%al
  8011c0:	0f b6 d0             	movzbl %al,%edx
  8011c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c6:	8a 00                	mov    (%eax),%al
  8011c8:	0f b6 c0             	movzbl %al,%eax
  8011cb:	29 c2                	sub    %eax,%edx
  8011cd:	89 d0                	mov    %edx,%eax
}
  8011cf:	5d                   	pop    %ebp
  8011d0:	c3                   	ret    

008011d1 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011d1:	55                   	push   %ebp
  8011d2:	89 e5                	mov    %esp,%ebp
  8011d4:	83 ec 04             	sub    $0x4,%esp
  8011d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011da:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011dd:	eb 12                	jmp    8011f1 <strchr+0x20>
		if (*s == c)
  8011df:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e2:	8a 00                	mov    (%eax),%al
  8011e4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011e7:	75 05                	jne    8011ee <strchr+0x1d>
			return (char *) s;
  8011e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ec:	eb 11                	jmp    8011ff <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011ee:	ff 45 08             	incl   0x8(%ebp)
  8011f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f4:	8a 00                	mov    (%eax),%al
  8011f6:	84 c0                	test   %al,%al
  8011f8:	75 e5                	jne    8011df <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011fa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011ff:	c9                   	leave  
  801200:	c3                   	ret    

00801201 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801201:	55                   	push   %ebp
  801202:	89 e5                	mov    %esp,%ebp
  801204:	83 ec 04             	sub    $0x4,%esp
  801207:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80120d:	eb 0d                	jmp    80121c <strfind+0x1b>
		if (*s == c)
  80120f:	8b 45 08             	mov    0x8(%ebp),%eax
  801212:	8a 00                	mov    (%eax),%al
  801214:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801217:	74 0e                	je     801227 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801219:	ff 45 08             	incl   0x8(%ebp)
  80121c:	8b 45 08             	mov    0x8(%ebp),%eax
  80121f:	8a 00                	mov    (%eax),%al
  801221:	84 c0                	test   %al,%al
  801223:	75 ea                	jne    80120f <strfind+0xe>
  801225:	eb 01                	jmp    801228 <strfind+0x27>
		if (*s == c)
			break;
  801227:	90                   	nop
	return (char *) s;
  801228:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80122b:	c9                   	leave  
  80122c:	c3                   	ret    

0080122d <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80122d:	55                   	push   %ebp
  80122e:	89 e5                	mov    %esp,%ebp
  801230:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801233:	8b 45 08             	mov    0x8(%ebp),%eax
  801236:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801239:	8b 45 10             	mov    0x10(%ebp),%eax
  80123c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80123f:	eb 0e                	jmp    80124f <memset+0x22>
		*p++ = c;
  801241:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801244:	8d 50 01             	lea    0x1(%eax),%edx
  801247:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80124a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80124d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80124f:	ff 4d f8             	decl   -0x8(%ebp)
  801252:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801256:	79 e9                	jns    801241 <memset+0x14>
		*p++ = c;

	return v;
  801258:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80125b:	c9                   	leave  
  80125c:	c3                   	ret    

0080125d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80125d:	55                   	push   %ebp
  80125e:	89 e5                	mov    %esp,%ebp
  801260:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801263:	8b 45 0c             	mov    0xc(%ebp),%eax
  801266:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801269:	8b 45 08             	mov    0x8(%ebp),%eax
  80126c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80126f:	eb 16                	jmp    801287 <memcpy+0x2a>
		*d++ = *s++;
  801271:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801274:	8d 50 01             	lea    0x1(%eax),%edx
  801277:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80127a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80127d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801280:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801283:	8a 12                	mov    (%edx),%dl
  801285:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801287:	8b 45 10             	mov    0x10(%ebp),%eax
  80128a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80128d:	89 55 10             	mov    %edx,0x10(%ebp)
  801290:	85 c0                	test   %eax,%eax
  801292:	75 dd                	jne    801271 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801294:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801297:	c9                   	leave  
  801298:	c3                   	ret    

00801299 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801299:	55                   	push   %ebp
  80129a:	89 e5                	mov    %esp,%ebp
  80129c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80129f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8012a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8012ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ae:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012b1:	73 50                	jae    801303 <memmove+0x6a>
  8012b3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b9:	01 d0                	add    %edx,%eax
  8012bb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012be:	76 43                	jbe    801303 <memmove+0x6a>
		s += n;
  8012c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c3:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8012c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c9:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8012cc:	eb 10                	jmp    8012de <memmove+0x45>
			*--d = *--s;
  8012ce:	ff 4d f8             	decl   -0x8(%ebp)
  8012d1:	ff 4d fc             	decl   -0x4(%ebp)
  8012d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012d7:	8a 10                	mov    (%eax),%dl
  8012d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012dc:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012de:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012e4:	89 55 10             	mov    %edx,0x10(%ebp)
  8012e7:	85 c0                	test   %eax,%eax
  8012e9:	75 e3                	jne    8012ce <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012eb:	eb 23                	jmp    801310 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012f0:	8d 50 01             	lea    0x1(%eax),%edx
  8012f3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012f6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012f9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012fc:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012ff:	8a 12                	mov    (%edx),%dl
  801301:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801303:	8b 45 10             	mov    0x10(%ebp),%eax
  801306:	8d 50 ff             	lea    -0x1(%eax),%edx
  801309:	89 55 10             	mov    %edx,0x10(%ebp)
  80130c:	85 c0                	test   %eax,%eax
  80130e:	75 dd                	jne    8012ed <memmove+0x54>
			*d++ = *s++;

	return dst;
  801310:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801313:	c9                   	leave  
  801314:	c3                   	ret    

00801315 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801315:	55                   	push   %ebp
  801316:	89 e5                	mov    %esp,%ebp
  801318:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80131b:	8b 45 08             	mov    0x8(%ebp),%eax
  80131e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801321:	8b 45 0c             	mov    0xc(%ebp),%eax
  801324:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801327:	eb 2a                	jmp    801353 <memcmp+0x3e>
		if (*s1 != *s2)
  801329:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80132c:	8a 10                	mov    (%eax),%dl
  80132e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801331:	8a 00                	mov    (%eax),%al
  801333:	38 c2                	cmp    %al,%dl
  801335:	74 16                	je     80134d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801337:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80133a:	8a 00                	mov    (%eax),%al
  80133c:	0f b6 d0             	movzbl %al,%edx
  80133f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801342:	8a 00                	mov    (%eax),%al
  801344:	0f b6 c0             	movzbl %al,%eax
  801347:	29 c2                	sub    %eax,%edx
  801349:	89 d0                	mov    %edx,%eax
  80134b:	eb 18                	jmp    801365 <memcmp+0x50>
		s1++, s2++;
  80134d:	ff 45 fc             	incl   -0x4(%ebp)
  801350:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801353:	8b 45 10             	mov    0x10(%ebp),%eax
  801356:	8d 50 ff             	lea    -0x1(%eax),%edx
  801359:	89 55 10             	mov    %edx,0x10(%ebp)
  80135c:	85 c0                	test   %eax,%eax
  80135e:	75 c9                	jne    801329 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801360:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801365:	c9                   	leave  
  801366:	c3                   	ret    

00801367 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801367:	55                   	push   %ebp
  801368:	89 e5                	mov    %esp,%ebp
  80136a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80136d:	8b 55 08             	mov    0x8(%ebp),%edx
  801370:	8b 45 10             	mov    0x10(%ebp),%eax
  801373:	01 d0                	add    %edx,%eax
  801375:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801378:	eb 15                	jmp    80138f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80137a:	8b 45 08             	mov    0x8(%ebp),%eax
  80137d:	8a 00                	mov    (%eax),%al
  80137f:	0f b6 d0             	movzbl %al,%edx
  801382:	8b 45 0c             	mov    0xc(%ebp),%eax
  801385:	0f b6 c0             	movzbl %al,%eax
  801388:	39 c2                	cmp    %eax,%edx
  80138a:	74 0d                	je     801399 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80138c:	ff 45 08             	incl   0x8(%ebp)
  80138f:	8b 45 08             	mov    0x8(%ebp),%eax
  801392:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801395:	72 e3                	jb     80137a <memfind+0x13>
  801397:	eb 01                	jmp    80139a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801399:	90                   	nop
	return (void *) s;
  80139a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80139d:	c9                   	leave  
  80139e:	c3                   	ret    

0080139f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80139f:	55                   	push   %ebp
  8013a0:	89 e5                	mov    %esp,%ebp
  8013a2:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8013a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8013ac:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013b3:	eb 03                	jmp    8013b8 <strtol+0x19>
		s++;
  8013b5:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bb:	8a 00                	mov    (%eax),%al
  8013bd:	3c 20                	cmp    $0x20,%al
  8013bf:	74 f4                	je     8013b5 <strtol+0x16>
  8013c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c4:	8a 00                	mov    (%eax),%al
  8013c6:	3c 09                	cmp    $0x9,%al
  8013c8:	74 eb                	je     8013b5 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	8a 00                	mov    (%eax),%al
  8013cf:	3c 2b                	cmp    $0x2b,%al
  8013d1:	75 05                	jne    8013d8 <strtol+0x39>
		s++;
  8013d3:	ff 45 08             	incl   0x8(%ebp)
  8013d6:	eb 13                	jmp    8013eb <strtol+0x4c>
	else if (*s == '-')
  8013d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013db:	8a 00                	mov    (%eax),%al
  8013dd:	3c 2d                	cmp    $0x2d,%al
  8013df:	75 0a                	jne    8013eb <strtol+0x4c>
		s++, neg = 1;
  8013e1:	ff 45 08             	incl   0x8(%ebp)
  8013e4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013eb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013ef:	74 06                	je     8013f7 <strtol+0x58>
  8013f1:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013f5:	75 20                	jne    801417 <strtol+0x78>
  8013f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fa:	8a 00                	mov    (%eax),%al
  8013fc:	3c 30                	cmp    $0x30,%al
  8013fe:	75 17                	jne    801417 <strtol+0x78>
  801400:	8b 45 08             	mov    0x8(%ebp),%eax
  801403:	40                   	inc    %eax
  801404:	8a 00                	mov    (%eax),%al
  801406:	3c 78                	cmp    $0x78,%al
  801408:	75 0d                	jne    801417 <strtol+0x78>
		s += 2, base = 16;
  80140a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80140e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801415:	eb 28                	jmp    80143f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801417:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80141b:	75 15                	jne    801432 <strtol+0x93>
  80141d:	8b 45 08             	mov    0x8(%ebp),%eax
  801420:	8a 00                	mov    (%eax),%al
  801422:	3c 30                	cmp    $0x30,%al
  801424:	75 0c                	jne    801432 <strtol+0x93>
		s++, base = 8;
  801426:	ff 45 08             	incl   0x8(%ebp)
  801429:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801430:	eb 0d                	jmp    80143f <strtol+0xa0>
	else if (base == 0)
  801432:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801436:	75 07                	jne    80143f <strtol+0xa0>
		base = 10;
  801438:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80143f:	8b 45 08             	mov    0x8(%ebp),%eax
  801442:	8a 00                	mov    (%eax),%al
  801444:	3c 2f                	cmp    $0x2f,%al
  801446:	7e 19                	jle    801461 <strtol+0xc2>
  801448:	8b 45 08             	mov    0x8(%ebp),%eax
  80144b:	8a 00                	mov    (%eax),%al
  80144d:	3c 39                	cmp    $0x39,%al
  80144f:	7f 10                	jg     801461 <strtol+0xc2>
			dig = *s - '0';
  801451:	8b 45 08             	mov    0x8(%ebp),%eax
  801454:	8a 00                	mov    (%eax),%al
  801456:	0f be c0             	movsbl %al,%eax
  801459:	83 e8 30             	sub    $0x30,%eax
  80145c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80145f:	eb 42                	jmp    8014a3 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801461:	8b 45 08             	mov    0x8(%ebp),%eax
  801464:	8a 00                	mov    (%eax),%al
  801466:	3c 60                	cmp    $0x60,%al
  801468:	7e 19                	jle    801483 <strtol+0xe4>
  80146a:	8b 45 08             	mov    0x8(%ebp),%eax
  80146d:	8a 00                	mov    (%eax),%al
  80146f:	3c 7a                	cmp    $0x7a,%al
  801471:	7f 10                	jg     801483 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801473:	8b 45 08             	mov    0x8(%ebp),%eax
  801476:	8a 00                	mov    (%eax),%al
  801478:	0f be c0             	movsbl %al,%eax
  80147b:	83 e8 57             	sub    $0x57,%eax
  80147e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801481:	eb 20                	jmp    8014a3 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801483:	8b 45 08             	mov    0x8(%ebp),%eax
  801486:	8a 00                	mov    (%eax),%al
  801488:	3c 40                	cmp    $0x40,%al
  80148a:	7e 39                	jle    8014c5 <strtol+0x126>
  80148c:	8b 45 08             	mov    0x8(%ebp),%eax
  80148f:	8a 00                	mov    (%eax),%al
  801491:	3c 5a                	cmp    $0x5a,%al
  801493:	7f 30                	jg     8014c5 <strtol+0x126>
			dig = *s - 'A' + 10;
  801495:	8b 45 08             	mov    0x8(%ebp),%eax
  801498:	8a 00                	mov    (%eax),%al
  80149a:	0f be c0             	movsbl %al,%eax
  80149d:	83 e8 37             	sub    $0x37,%eax
  8014a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8014a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014a6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014a9:	7d 19                	jge    8014c4 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8014ab:	ff 45 08             	incl   0x8(%ebp)
  8014ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014b1:	0f af 45 10          	imul   0x10(%ebp),%eax
  8014b5:	89 c2                	mov    %eax,%edx
  8014b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014ba:	01 d0                	add    %edx,%eax
  8014bc:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8014bf:	e9 7b ff ff ff       	jmp    80143f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8014c4:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8014c5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014c9:	74 08                	je     8014d3 <strtol+0x134>
		*endptr = (char *) s;
  8014cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ce:	8b 55 08             	mov    0x8(%ebp),%edx
  8014d1:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014d3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014d7:	74 07                	je     8014e0 <strtol+0x141>
  8014d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014dc:	f7 d8                	neg    %eax
  8014de:	eb 03                	jmp    8014e3 <strtol+0x144>
  8014e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014e3:	c9                   	leave  
  8014e4:	c3                   	ret    

008014e5 <ltostr>:

void
ltostr(long value, char *str)
{
  8014e5:	55                   	push   %ebp
  8014e6:	89 e5                	mov    %esp,%ebp
  8014e8:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014eb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014f2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014f9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014fd:	79 13                	jns    801512 <ltostr+0x2d>
	{
		neg = 1;
  8014ff:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801506:	8b 45 0c             	mov    0xc(%ebp),%eax
  801509:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80150c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80150f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801512:	8b 45 08             	mov    0x8(%ebp),%eax
  801515:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80151a:	99                   	cltd   
  80151b:	f7 f9                	idiv   %ecx
  80151d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801520:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801523:	8d 50 01             	lea    0x1(%eax),%edx
  801526:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801529:	89 c2                	mov    %eax,%edx
  80152b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152e:	01 d0                	add    %edx,%eax
  801530:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801533:	83 c2 30             	add    $0x30,%edx
  801536:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801538:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80153b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801540:	f7 e9                	imul   %ecx
  801542:	c1 fa 02             	sar    $0x2,%edx
  801545:	89 c8                	mov    %ecx,%eax
  801547:	c1 f8 1f             	sar    $0x1f,%eax
  80154a:	29 c2                	sub    %eax,%edx
  80154c:	89 d0                	mov    %edx,%eax
  80154e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801551:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801554:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801559:	f7 e9                	imul   %ecx
  80155b:	c1 fa 02             	sar    $0x2,%edx
  80155e:	89 c8                	mov    %ecx,%eax
  801560:	c1 f8 1f             	sar    $0x1f,%eax
  801563:	29 c2                	sub    %eax,%edx
  801565:	89 d0                	mov    %edx,%eax
  801567:	c1 e0 02             	shl    $0x2,%eax
  80156a:	01 d0                	add    %edx,%eax
  80156c:	01 c0                	add    %eax,%eax
  80156e:	29 c1                	sub    %eax,%ecx
  801570:	89 ca                	mov    %ecx,%edx
  801572:	85 d2                	test   %edx,%edx
  801574:	75 9c                	jne    801512 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801576:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80157d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801580:	48                   	dec    %eax
  801581:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801584:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801588:	74 3d                	je     8015c7 <ltostr+0xe2>
		start = 1 ;
  80158a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801591:	eb 34                	jmp    8015c7 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801593:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801596:	8b 45 0c             	mov    0xc(%ebp),%eax
  801599:	01 d0                	add    %edx,%eax
  80159b:	8a 00                	mov    (%eax),%al
  80159d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8015a0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a6:	01 c2                	add    %eax,%edx
  8015a8:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8015ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ae:	01 c8                	add    %ecx,%eax
  8015b0:	8a 00                	mov    (%eax),%al
  8015b2:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8015b4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ba:	01 c2                	add    %eax,%edx
  8015bc:	8a 45 eb             	mov    -0x15(%ebp),%al
  8015bf:	88 02                	mov    %al,(%edx)
		start++ ;
  8015c1:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8015c4:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8015c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015ca:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015cd:	7c c4                	jl     801593 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015cf:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d5:	01 d0                	add    %edx,%eax
  8015d7:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015da:	90                   	nop
  8015db:	c9                   	leave  
  8015dc:	c3                   	ret    

008015dd <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015dd:	55                   	push   %ebp
  8015de:	89 e5                	mov    %esp,%ebp
  8015e0:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015e3:	ff 75 08             	pushl  0x8(%ebp)
  8015e6:	e8 54 fa ff ff       	call   80103f <strlen>
  8015eb:	83 c4 04             	add    $0x4,%esp
  8015ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015f1:	ff 75 0c             	pushl  0xc(%ebp)
  8015f4:	e8 46 fa ff ff       	call   80103f <strlen>
  8015f9:	83 c4 04             	add    $0x4,%esp
  8015fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801606:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80160d:	eb 17                	jmp    801626 <strcconcat+0x49>
		final[s] = str1[s] ;
  80160f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801612:	8b 45 10             	mov    0x10(%ebp),%eax
  801615:	01 c2                	add    %eax,%edx
  801617:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80161a:	8b 45 08             	mov    0x8(%ebp),%eax
  80161d:	01 c8                	add    %ecx,%eax
  80161f:	8a 00                	mov    (%eax),%al
  801621:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801623:	ff 45 fc             	incl   -0x4(%ebp)
  801626:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801629:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80162c:	7c e1                	jl     80160f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80162e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801635:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80163c:	eb 1f                	jmp    80165d <strcconcat+0x80>
		final[s++] = str2[i] ;
  80163e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801641:	8d 50 01             	lea    0x1(%eax),%edx
  801644:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801647:	89 c2                	mov    %eax,%edx
  801649:	8b 45 10             	mov    0x10(%ebp),%eax
  80164c:	01 c2                	add    %eax,%edx
  80164e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801651:	8b 45 0c             	mov    0xc(%ebp),%eax
  801654:	01 c8                	add    %ecx,%eax
  801656:	8a 00                	mov    (%eax),%al
  801658:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80165a:	ff 45 f8             	incl   -0x8(%ebp)
  80165d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801660:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801663:	7c d9                	jl     80163e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801665:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801668:	8b 45 10             	mov    0x10(%ebp),%eax
  80166b:	01 d0                	add    %edx,%eax
  80166d:	c6 00 00             	movb   $0x0,(%eax)
}
  801670:	90                   	nop
  801671:	c9                   	leave  
  801672:	c3                   	ret    

00801673 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801673:	55                   	push   %ebp
  801674:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801676:	8b 45 14             	mov    0x14(%ebp),%eax
  801679:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80167f:	8b 45 14             	mov    0x14(%ebp),%eax
  801682:	8b 00                	mov    (%eax),%eax
  801684:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80168b:	8b 45 10             	mov    0x10(%ebp),%eax
  80168e:	01 d0                	add    %edx,%eax
  801690:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801696:	eb 0c                	jmp    8016a4 <strsplit+0x31>
			*string++ = 0;
  801698:	8b 45 08             	mov    0x8(%ebp),%eax
  80169b:	8d 50 01             	lea    0x1(%eax),%edx
  80169e:	89 55 08             	mov    %edx,0x8(%ebp)
  8016a1:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a7:	8a 00                	mov    (%eax),%al
  8016a9:	84 c0                	test   %al,%al
  8016ab:	74 18                	je     8016c5 <strsplit+0x52>
  8016ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b0:	8a 00                	mov    (%eax),%al
  8016b2:	0f be c0             	movsbl %al,%eax
  8016b5:	50                   	push   %eax
  8016b6:	ff 75 0c             	pushl  0xc(%ebp)
  8016b9:	e8 13 fb ff ff       	call   8011d1 <strchr>
  8016be:	83 c4 08             	add    $0x8,%esp
  8016c1:	85 c0                	test   %eax,%eax
  8016c3:	75 d3                	jne    801698 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8016c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c8:	8a 00                	mov    (%eax),%al
  8016ca:	84 c0                	test   %al,%al
  8016cc:	74 5a                	je     801728 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8016ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8016d1:	8b 00                	mov    (%eax),%eax
  8016d3:	83 f8 0f             	cmp    $0xf,%eax
  8016d6:	75 07                	jne    8016df <strsplit+0x6c>
		{
			return 0;
  8016d8:	b8 00 00 00 00       	mov    $0x0,%eax
  8016dd:	eb 66                	jmp    801745 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016df:	8b 45 14             	mov    0x14(%ebp),%eax
  8016e2:	8b 00                	mov    (%eax),%eax
  8016e4:	8d 48 01             	lea    0x1(%eax),%ecx
  8016e7:	8b 55 14             	mov    0x14(%ebp),%edx
  8016ea:	89 0a                	mov    %ecx,(%edx)
  8016ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8016f6:	01 c2                	add    %eax,%edx
  8016f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fb:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016fd:	eb 03                	jmp    801702 <strsplit+0x8f>
			string++;
  8016ff:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801702:	8b 45 08             	mov    0x8(%ebp),%eax
  801705:	8a 00                	mov    (%eax),%al
  801707:	84 c0                	test   %al,%al
  801709:	74 8b                	je     801696 <strsplit+0x23>
  80170b:	8b 45 08             	mov    0x8(%ebp),%eax
  80170e:	8a 00                	mov    (%eax),%al
  801710:	0f be c0             	movsbl %al,%eax
  801713:	50                   	push   %eax
  801714:	ff 75 0c             	pushl  0xc(%ebp)
  801717:	e8 b5 fa ff ff       	call   8011d1 <strchr>
  80171c:	83 c4 08             	add    $0x8,%esp
  80171f:	85 c0                	test   %eax,%eax
  801721:	74 dc                	je     8016ff <strsplit+0x8c>
			string++;
	}
  801723:	e9 6e ff ff ff       	jmp    801696 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801728:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801729:	8b 45 14             	mov    0x14(%ebp),%eax
  80172c:	8b 00                	mov    (%eax),%eax
  80172e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801735:	8b 45 10             	mov    0x10(%ebp),%eax
  801738:	01 d0                	add    %edx,%eax
  80173a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801740:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801745:	c9                   	leave  
  801746:	c3                   	ret    

00801747 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801747:	55                   	push   %ebp
  801748:	89 e5                	mov    %esp,%ebp
  80174a:	57                   	push   %edi
  80174b:	56                   	push   %esi
  80174c:	53                   	push   %ebx
  80174d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801750:	8b 45 08             	mov    0x8(%ebp),%eax
  801753:	8b 55 0c             	mov    0xc(%ebp),%edx
  801756:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801759:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80175c:	8b 7d 18             	mov    0x18(%ebp),%edi
  80175f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801762:	cd 30                	int    $0x30
  801764:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801767:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80176a:	83 c4 10             	add    $0x10,%esp
  80176d:	5b                   	pop    %ebx
  80176e:	5e                   	pop    %esi
  80176f:	5f                   	pop    %edi
  801770:	5d                   	pop    %ebp
  801771:	c3                   	ret    

00801772 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801772:	55                   	push   %ebp
  801773:	89 e5                	mov    %esp,%ebp
  801775:	83 ec 04             	sub    $0x4,%esp
  801778:	8b 45 10             	mov    0x10(%ebp),%eax
  80177b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80177e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801782:	8b 45 08             	mov    0x8(%ebp),%eax
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	52                   	push   %edx
  80178a:	ff 75 0c             	pushl  0xc(%ebp)
  80178d:	50                   	push   %eax
  80178e:	6a 00                	push   $0x0
  801790:	e8 b2 ff ff ff       	call   801747 <syscall>
  801795:	83 c4 18             	add    $0x18,%esp
}
  801798:	90                   	nop
  801799:	c9                   	leave  
  80179a:	c3                   	ret    

0080179b <sys_cgetc>:

int
sys_cgetc(void)
{
  80179b:	55                   	push   %ebp
  80179c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 00                	push   $0x0
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 00                	push   $0x0
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 01                	push   $0x1
  8017aa:	e8 98 ff ff ff       	call   801747 <syscall>
  8017af:	83 c4 18             	add    $0x18,%esp
}
  8017b2:	c9                   	leave  
  8017b3:	c3                   	ret    

008017b4 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8017b4:	55                   	push   %ebp
  8017b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8017b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ba:	6a 00                	push   $0x0
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	50                   	push   %eax
  8017c3:	6a 05                	push   $0x5
  8017c5:	e8 7d ff ff ff       	call   801747 <syscall>
  8017ca:	83 c4 18             	add    $0x18,%esp
}
  8017cd:	c9                   	leave  
  8017ce:	c3                   	ret    

008017cf <sys_getenvid>:

int32 sys_getenvid(void)
{
  8017cf:	55                   	push   %ebp
  8017d0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 02                	push   $0x2
  8017de:	e8 64 ff ff ff       	call   801747 <syscall>
  8017e3:	83 c4 18             	add    $0x18,%esp
}
  8017e6:	c9                   	leave  
  8017e7:	c3                   	ret    

008017e8 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017e8:	55                   	push   %ebp
  8017e9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 03                	push   $0x3
  8017f7:	e8 4b ff ff ff       	call   801747 <syscall>
  8017fc:	83 c4 18             	add    $0x18,%esp
}
  8017ff:	c9                   	leave  
  801800:	c3                   	ret    

00801801 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801801:	55                   	push   %ebp
  801802:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	6a 00                	push   $0x0
  80180c:	6a 00                	push   $0x0
  80180e:	6a 04                	push   $0x4
  801810:	e8 32 ff ff ff       	call   801747 <syscall>
  801815:	83 c4 18             	add    $0x18,%esp
}
  801818:	c9                   	leave  
  801819:	c3                   	ret    

0080181a <sys_env_exit>:


void sys_env_exit(void)
{
  80181a:	55                   	push   %ebp
  80181b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	6a 00                	push   $0x0
  801823:	6a 00                	push   $0x0
  801825:	6a 00                	push   $0x0
  801827:	6a 06                	push   $0x6
  801829:	e8 19 ff ff ff       	call   801747 <syscall>
  80182e:	83 c4 18             	add    $0x18,%esp
}
  801831:	90                   	nop
  801832:	c9                   	leave  
  801833:	c3                   	ret    

00801834 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801834:	55                   	push   %ebp
  801835:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801837:	8b 55 0c             	mov    0xc(%ebp),%edx
  80183a:	8b 45 08             	mov    0x8(%ebp),%eax
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	52                   	push   %edx
  801844:	50                   	push   %eax
  801845:	6a 07                	push   $0x7
  801847:	e8 fb fe ff ff       	call   801747 <syscall>
  80184c:	83 c4 18             	add    $0x18,%esp
}
  80184f:	c9                   	leave  
  801850:	c3                   	ret    

00801851 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801851:	55                   	push   %ebp
  801852:	89 e5                	mov    %esp,%ebp
  801854:	56                   	push   %esi
  801855:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801856:	8b 75 18             	mov    0x18(%ebp),%esi
  801859:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80185c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80185f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801862:	8b 45 08             	mov    0x8(%ebp),%eax
  801865:	56                   	push   %esi
  801866:	53                   	push   %ebx
  801867:	51                   	push   %ecx
  801868:	52                   	push   %edx
  801869:	50                   	push   %eax
  80186a:	6a 08                	push   $0x8
  80186c:	e8 d6 fe ff ff       	call   801747 <syscall>
  801871:	83 c4 18             	add    $0x18,%esp
}
  801874:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801877:	5b                   	pop    %ebx
  801878:	5e                   	pop    %esi
  801879:	5d                   	pop    %ebp
  80187a:	c3                   	ret    

0080187b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80187b:	55                   	push   %ebp
  80187c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80187e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801881:	8b 45 08             	mov    0x8(%ebp),%eax
  801884:	6a 00                	push   $0x0
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	52                   	push   %edx
  80188b:	50                   	push   %eax
  80188c:	6a 09                	push   $0x9
  80188e:	e8 b4 fe ff ff       	call   801747 <syscall>
  801893:	83 c4 18             	add    $0x18,%esp
}
  801896:	c9                   	leave  
  801897:	c3                   	ret    

00801898 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801898:	55                   	push   %ebp
  801899:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 00                	push   $0x0
  8018a1:	ff 75 0c             	pushl  0xc(%ebp)
  8018a4:	ff 75 08             	pushl  0x8(%ebp)
  8018a7:	6a 0a                	push   $0xa
  8018a9:	e8 99 fe ff ff       	call   801747 <syscall>
  8018ae:	83 c4 18             	add    $0x18,%esp
}
  8018b1:	c9                   	leave  
  8018b2:	c3                   	ret    

008018b3 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8018b3:	55                   	push   %ebp
  8018b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8018b6:	6a 00                	push   $0x0
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 00                	push   $0x0
  8018c0:	6a 0b                	push   $0xb
  8018c2:	e8 80 fe ff ff       	call   801747 <syscall>
  8018c7:	83 c4 18             	add    $0x18,%esp
}
  8018ca:	c9                   	leave  
  8018cb:	c3                   	ret    

008018cc <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8018cc:	55                   	push   %ebp
  8018cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 0c                	push   $0xc
  8018db:	e8 67 fe ff ff       	call   801747 <syscall>
  8018e0:	83 c4 18             	add    $0x18,%esp
}
  8018e3:	c9                   	leave  
  8018e4:	c3                   	ret    

008018e5 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018e5:	55                   	push   %ebp
  8018e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018e8:	6a 00                	push   $0x0
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 00                	push   $0x0
  8018ee:	6a 00                	push   $0x0
  8018f0:	6a 00                	push   $0x0
  8018f2:	6a 0d                	push   $0xd
  8018f4:	e8 4e fe ff ff       	call   801747 <syscall>
  8018f9:	83 c4 18             	add    $0x18,%esp
}
  8018fc:	c9                   	leave  
  8018fd:	c3                   	ret    

008018fe <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018fe:	55                   	push   %ebp
  8018ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801901:	6a 00                	push   $0x0
  801903:	6a 00                	push   $0x0
  801905:	6a 00                	push   $0x0
  801907:	ff 75 0c             	pushl  0xc(%ebp)
  80190a:	ff 75 08             	pushl  0x8(%ebp)
  80190d:	6a 11                	push   $0x11
  80190f:	e8 33 fe ff ff       	call   801747 <syscall>
  801914:	83 c4 18             	add    $0x18,%esp
	return;
  801917:	90                   	nop
}
  801918:	c9                   	leave  
  801919:	c3                   	ret    

0080191a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80191a:	55                   	push   %ebp
  80191b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80191d:	6a 00                	push   $0x0
  80191f:	6a 00                	push   $0x0
  801921:	6a 00                	push   $0x0
  801923:	ff 75 0c             	pushl  0xc(%ebp)
  801926:	ff 75 08             	pushl  0x8(%ebp)
  801929:	6a 12                	push   $0x12
  80192b:	e8 17 fe ff ff       	call   801747 <syscall>
  801930:	83 c4 18             	add    $0x18,%esp
	return ;
  801933:	90                   	nop
}
  801934:	c9                   	leave  
  801935:	c3                   	ret    

00801936 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801936:	55                   	push   %ebp
  801937:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801939:	6a 00                	push   $0x0
  80193b:	6a 00                	push   $0x0
  80193d:	6a 00                	push   $0x0
  80193f:	6a 00                	push   $0x0
  801941:	6a 00                	push   $0x0
  801943:	6a 0e                	push   $0xe
  801945:	e8 fd fd ff ff       	call   801747 <syscall>
  80194a:	83 c4 18             	add    $0x18,%esp
}
  80194d:	c9                   	leave  
  80194e:	c3                   	ret    

0080194f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80194f:	55                   	push   %ebp
  801950:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	6a 00                	push   $0x0
  80195a:	ff 75 08             	pushl  0x8(%ebp)
  80195d:	6a 0f                	push   $0xf
  80195f:	e8 e3 fd ff ff       	call   801747 <syscall>
  801964:	83 c4 18             	add    $0x18,%esp
}
  801967:	c9                   	leave  
  801968:	c3                   	ret    

00801969 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801969:	55                   	push   %ebp
  80196a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	6a 00                	push   $0x0
  801972:	6a 00                	push   $0x0
  801974:	6a 00                	push   $0x0
  801976:	6a 10                	push   $0x10
  801978:	e8 ca fd ff ff       	call   801747 <syscall>
  80197d:	83 c4 18             	add    $0x18,%esp
}
  801980:	90                   	nop
  801981:	c9                   	leave  
  801982:	c3                   	ret    

00801983 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801983:	55                   	push   %ebp
  801984:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801986:	6a 00                	push   $0x0
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	6a 00                	push   $0x0
  80198e:	6a 00                	push   $0x0
  801990:	6a 14                	push   $0x14
  801992:	e8 b0 fd ff ff       	call   801747 <syscall>
  801997:	83 c4 18             	add    $0x18,%esp
}
  80199a:	90                   	nop
  80199b:	c9                   	leave  
  80199c:	c3                   	ret    

0080199d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80199d:	55                   	push   %ebp
  80199e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 00                	push   $0x0
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 00                	push   $0x0
  8019aa:	6a 15                	push   $0x15
  8019ac:	e8 96 fd ff ff       	call   801747 <syscall>
  8019b1:	83 c4 18             	add    $0x18,%esp
}
  8019b4:	90                   	nop
  8019b5:	c9                   	leave  
  8019b6:	c3                   	ret    

008019b7 <sys_cputc>:


void
sys_cputc(const char c)
{
  8019b7:	55                   	push   %ebp
  8019b8:	89 e5                	mov    %esp,%ebp
  8019ba:	83 ec 04             	sub    $0x4,%esp
  8019bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8019c3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 00                	push   $0x0
  8019cd:	6a 00                	push   $0x0
  8019cf:	50                   	push   %eax
  8019d0:	6a 16                	push   $0x16
  8019d2:	e8 70 fd ff ff       	call   801747 <syscall>
  8019d7:	83 c4 18             	add    $0x18,%esp
}
  8019da:	90                   	nop
  8019db:	c9                   	leave  
  8019dc:	c3                   	ret    

008019dd <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8019dd:	55                   	push   %ebp
  8019de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8019e0:	6a 00                	push   $0x0
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	6a 00                	push   $0x0
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 17                	push   $0x17
  8019ec:	e8 56 fd ff ff       	call   801747 <syscall>
  8019f1:	83 c4 18             	add    $0x18,%esp
}
  8019f4:	90                   	nop
  8019f5:	c9                   	leave  
  8019f6:	c3                   	ret    

008019f7 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019f7:	55                   	push   %ebp
  8019f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fd:	6a 00                	push   $0x0
  8019ff:	6a 00                	push   $0x0
  801a01:	6a 00                	push   $0x0
  801a03:	ff 75 0c             	pushl  0xc(%ebp)
  801a06:	50                   	push   %eax
  801a07:	6a 18                	push   $0x18
  801a09:	e8 39 fd ff ff       	call   801747 <syscall>
  801a0e:	83 c4 18             	add    $0x18,%esp
}
  801a11:	c9                   	leave  
  801a12:	c3                   	ret    

00801a13 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801a13:	55                   	push   %ebp
  801a14:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a16:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a19:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 00                	push   $0x0
  801a22:	52                   	push   %edx
  801a23:	50                   	push   %eax
  801a24:	6a 1b                	push   $0x1b
  801a26:	e8 1c fd ff ff       	call   801747 <syscall>
  801a2b:	83 c4 18             	add    $0x18,%esp
}
  801a2e:	c9                   	leave  
  801a2f:	c3                   	ret    

00801a30 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a30:	55                   	push   %ebp
  801a31:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a33:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a36:	8b 45 08             	mov    0x8(%ebp),%eax
  801a39:	6a 00                	push   $0x0
  801a3b:	6a 00                	push   $0x0
  801a3d:	6a 00                	push   $0x0
  801a3f:	52                   	push   %edx
  801a40:	50                   	push   %eax
  801a41:	6a 19                	push   $0x19
  801a43:	e8 ff fc ff ff       	call   801747 <syscall>
  801a48:	83 c4 18             	add    $0x18,%esp
}
  801a4b:	90                   	nop
  801a4c:	c9                   	leave  
  801a4d:	c3                   	ret    

00801a4e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a4e:	55                   	push   %ebp
  801a4f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a51:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a54:	8b 45 08             	mov    0x8(%ebp),%eax
  801a57:	6a 00                	push   $0x0
  801a59:	6a 00                	push   $0x0
  801a5b:	6a 00                	push   $0x0
  801a5d:	52                   	push   %edx
  801a5e:	50                   	push   %eax
  801a5f:	6a 1a                	push   $0x1a
  801a61:	e8 e1 fc ff ff       	call   801747 <syscall>
  801a66:	83 c4 18             	add    $0x18,%esp
}
  801a69:	90                   	nop
  801a6a:	c9                   	leave  
  801a6b:	c3                   	ret    

00801a6c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a6c:	55                   	push   %ebp
  801a6d:	89 e5                	mov    %esp,%ebp
  801a6f:	83 ec 04             	sub    $0x4,%esp
  801a72:	8b 45 10             	mov    0x10(%ebp),%eax
  801a75:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a78:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a7b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a82:	6a 00                	push   $0x0
  801a84:	51                   	push   %ecx
  801a85:	52                   	push   %edx
  801a86:	ff 75 0c             	pushl  0xc(%ebp)
  801a89:	50                   	push   %eax
  801a8a:	6a 1c                	push   $0x1c
  801a8c:	e8 b6 fc ff ff       	call   801747 <syscall>
  801a91:	83 c4 18             	add    $0x18,%esp
}
  801a94:	c9                   	leave  
  801a95:	c3                   	ret    

00801a96 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a96:	55                   	push   %ebp
  801a97:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a99:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a9c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 00                	push   $0x0
  801aa5:	52                   	push   %edx
  801aa6:	50                   	push   %eax
  801aa7:	6a 1d                	push   $0x1d
  801aa9:	e8 99 fc ff ff       	call   801747 <syscall>
  801aae:	83 c4 18             	add    $0x18,%esp
}
  801ab1:	c9                   	leave  
  801ab2:	c3                   	ret    

00801ab3 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801ab3:	55                   	push   %ebp
  801ab4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801ab6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ab9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801abc:	8b 45 08             	mov    0x8(%ebp),%eax
  801abf:	6a 00                	push   $0x0
  801ac1:	6a 00                	push   $0x0
  801ac3:	51                   	push   %ecx
  801ac4:	52                   	push   %edx
  801ac5:	50                   	push   %eax
  801ac6:	6a 1e                	push   $0x1e
  801ac8:	e8 7a fc ff ff       	call   801747 <syscall>
  801acd:	83 c4 18             	add    $0x18,%esp
}
  801ad0:	c9                   	leave  
  801ad1:	c3                   	ret    

00801ad2 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ad2:	55                   	push   %ebp
  801ad3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ad5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  801adb:	6a 00                	push   $0x0
  801add:	6a 00                	push   $0x0
  801adf:	6a 00                	push   $0x0
  801ae1:	52                   	push   %edx
  801ae2:	50                   	push   %eax
  801ae3:	6a 1f                	push   $0x1f
  801ae5:	e8 5d fc ff ff       	call   801747 <syscall>
  801aea:	83 c4 18             	add    $0x18,%esp
}
  801aed:	c9                   	leave  
  801aee:	c3                   	ret    

00801aef <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801aef:	55                   	push   %ebp
  801af0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	6a 00                	push   $0x0
  801af8:	6a 00                	push   $0x0
  801afa:	6a 00                	push   $0x0
  801afc:	6a 20                	push   $0x20
  801afe:	e8 44 fc ff ff       	call   801747 <syscall>
  801b03:	83 c4 18             	add    $0x18,%esp
}
  801b06:	c9                   	leave  
  801b07:	c3                   	ret    

00801b08 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801b08:	55                   	push   %ebp
  801b09:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0e:	6a 00                	push   $0x0
  801b10:	ff 75 14             	pushl  0x14(%ebp)
  801b13:	ff 75 10             	pushl  0x10(%ebp)
  801b16:	ff 75 0c             	pushl  0xc(%ebp)
  801b19:	50                   	push   %eax
  801b1a:	6a 21                	push   $0x21
  801b1c:	e8 26 fc ff ff       	call   801747 <syscall>
  801b21:	83 c4 18             	add    $0x18,%esp
}
  801b24:	c9                   	leave  
  801b25:	c3                   	ret    

00801b26 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801b26:	55                   	push   %ebp
  801b27:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801b29:	8b 45 08             	mov    0x8(%ebp),%eax
  801b2c:	6a 00                	push   $0x0
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	50                   	push   %eax
  801b35:	6a 22                	push   $0x22
  801b37:	e8 0b fc ff ff       	call   801747 <syscall>
  801b3c:	83 c4 18             	add    $0x18,%esp
}
  801b3f:	90                   	nop
  801b40:	c9                   	leave  
  801b41:	c3                   	ret    

00801b42 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b42:	55                   	push   %ebp
  801b43:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b45:	8b 45 08             	mov    0x8(%ebp),%eax
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 00                	push   $0x0
  801b50:	50                   	push   %eax
  801b51:	6a 23                	push   $0x23
  801b53:	e8 ef fb ff ff       	call   801747 <syscall>
  801b58:	83 c4 18             	add    $0x18,%esp
}
  801b5b:	90                   	nop
  801b5c:	c9                   	leave  
  801b5d:	c3                   	ret    

00801b5e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b5e:	55                   	push   %ebp
  801b5f:	89 e5                	mov    %esp,%ebp
  801b61:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b64:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b67:	8d 50 04             	lea    0x4(%eax),%edx
  801b6a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b6d:	6a 00                	push   $0x0
  801b6f:	6a 00                	push   $0x0
  801b71:	6a 00                	push   $0x0
  801b73:	52                   	push   %edx
  801b74:	50                   	push   %eax
  801b75:	6a 24                	push   $0x24
  801b77:	e8 cb fb ff ff       	call   801747 <syscall>
  801b7c:	83 c4 18             	add    $0x18,%esp
	return result;
  801b7f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b82:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b85:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b88:	89 01                	mov    %eax,(%ecx)
  801b8a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b90:	c9                   	leave  
  801b91:	c2 04 00             	ret    $0x4

00801b94 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b94:	55                   	push   %ebp
  801b95:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	ff 75 10             	pushl  0x10(%ebp)
  801b9e:	ff 75 0c             	pushl  0xc(%ebp)
  801ba1:	ff 75 08             	pushl  0x8(%ebp)
  801ba4:	6a 13                	push   $0x13
  801ba6:	e8 9c fb ff ff       	call   801747 <syscall>
  801bab:	83 c4 18             	add    $0x18,%esp
	return ;
  801bae:	90                   	nop
}
  801baf:	c9                   	leave  
  801bb0:	c3                   	ret    

00801bb1 <sys_rcr2>:
uint32 sys_rcr2()
{
  801bb1:	55                   	push   %ebp
  801bb2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 00                	push   $0x0
  801bba:	6a 00                	push   $0x0
  801bbc:	6a 00                	push   $0x0
  801bbe:	6a 25                	push   $0x25
  801bc0:	e8 82 fb ff ff       	call   801747 <syscall>
  801bc5:	83 c4 18             	add    $0x18,%esp
}
  801bc8:	c9                   	leave  
  801bc9:	c3                   	ret    

00801bca <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801bca:	55                   	push   %ebp
  801bcb:	89 e5                	mov    %esp,%ebp
  801bcd:	83 ec 04             	sub    $0x4,%esp
  801bd0:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801bd6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801bda:	6a 00                	push   $0x0
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 00                	push   $0x0
  801be0:	6a 00                	push   $0x0
  801be2:	50                   	push   %eax
  801be3:	6a 26                	push   $0x26
  801be5:	e8 5d fb ff ff       	call   801747 <syscall>
  801bea:	83 c4 18             	add    $0x18,%esp
	return ;
  801bed:	90                   	nop
}
  801bee:	c9                   	leave  
  801bef:	c3                   	ret    

00801bf0 <rsttst>:
void rsttst()
{
  801bf0:	55                   	push   %ebp
  801bf1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801bf3:	6a 00                	push   $0x0
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 00                	push   $0x0
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 28                	push   $0x28
  801bff:	e8 43 fb ff ff       	call   801747 <syscall>
  801c04:	83 c4 18             	add    $0x18,%esp
	return ;
  801c07:	90                   	nop
}
  801c08:	c9                   	leave  
  801c09:	c3                   	ret    

00801c0a <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801c0a:	55                   	push   %ebp
  801c0b:	89 e5                	mov    %esp,%ebp
  801c0d:	83 ec 04             	sub    $0x4,%esp
  801c10:	8b 45 14             	mov    0x14(%ebp),%eax
  801c13:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801c16:	8b 55 18             	mov    0x18(%ebp),%edx
  801c19:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c1d:	52                   	push   %edx
  801c1e:	50                   	push   %eax
  801c1f:	ff 75 10             	pushl  0x10(%ebp)
  801c22:	ff 75 0c             	pushl  0xc(%ebp)
  801c25:	ff 75 08             	pushl  0x8(%ebp)
  801c28:	6a 27                	push   $0x27
  801c2a:	e8 18 fb ff ff       	call   801747 <syscall>
  801c2f:	83 c4 18             	add    $0x18,%esp
	return ;
  801c32:	90                   	nop
}
  801c33:	c9                   	leave  
  801c34:	c3                   	ret    

00801c35 <chktst>:
void chktst(uint32 n)
{
  801c35:	55                   	push   %ebp
  801c36:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c38:	6a 00                	push   $0x0
  801c3a:	6a 00                	push   $0x0
  801c3c:	6a 00                	push   $0x0
  801c3e:	6a 00                	push   $0x0
  801c40:	ff 75 08             	pushl  0x8(%ebp)
  801c43:	6a 29                	push   $0x29
  801c45:	e8 fd fa ff ff       	call   801747 <syscall>
  801c4a:	83 c4 18             	add    $0x18,%esp
	return ;
  801c4d:	90                   	nop
}
  801c4e:	c9                   	leave  
  801c4f:	c3                   	ret    

00801c50 <inctst>:

void inctst()
{
  801c50:	55                   	push   %ebp
  801c51:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c53:	6a 00                	push   $0x0
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	6a 00                	push   $0x0
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 2a                	push   $0x2a
  801c5f:	e8 e3 fa ff ff       	call   801747 <syscall>
  801c64:	83 c4 18             	add    $0x18,%esp
	return ;
  801c67:	90                   	nop
}
  801c68:	c9                   	leave  
  801c69:	c3                   	ret    

00801c6a <gettst>:
uint32 gettst()
{
  801c6a:	55                   	push   %ebp
  801c6b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c6d:	6a 00                	push   $0x0
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 00                	push   $0x0
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	6a 2b                	push   $0x2b
  801c79:	e8 c9 fa ff ff       	call   801747 <syscall>
  801c7e:	83 c4 18             	add    $0x18,%esp
}
  801c81:	c9                   	leave  
  801c82:	c3                   	ret    

00801c83 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c83:	55                   	push   %ebp
  801c84:	89 e5                	mov    %esp,%ebp
  801c86:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 00                	push   $0x0
  801c93:	6a 2c                	push   $0x2c
  801c95:	e8 ad fa ff ff       	call   801747 <syscall>
  801c9a:	83 c4 18             	add    $0x18,%esp
  801c9d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801ca0:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801ca4:	75 07                	jne    801cad <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801ca6:	b8 01 00 00 00       	mov    $0x1,%eax
  801cab:	eb 05                	jmp    801cb2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801cad:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cb2:	c9                   	leave  
  801cb3:	c3                   	ret    

00801cb4 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801cb4:	55                   	push   %ebp
  801cb5:	89 e5                	mov    %esp,%ebp
  801cb7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 00                	push   $0x0
  801cc2:	6a 00                	push   $0x0
  801cc4:	6a 2c                	push   $0x2c
  801cc6:	e8 7c fa ff ff       	call   801747 <syscall>
  801ccb:	83 c4 18             	add    $0x18,%esp
  801cce:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801cd1:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801cd5:	75 07                	jne    801cde <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801cd7:	b8 01 00 00 00       	mov    $0x1,%eax
  801cdc:	eb 05                	jmp    801ce3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801cde:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ce3:	c9                   	leave  
  801ce4:	c3                   	ret    

00801ce5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ce5:	55                   	push   %ebp
  801ce6:	89 e5                	mov    %esp,%ebp
  801ce8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ceb:	6a 00                	push   $0x0
  801ced:	6a 00                	push   $0x0
  801cef:	6a 00                	push   $0x0
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	6a 2c                	push   $0x2c
  801cf7:	e8 4b fa ff ff       	call   801747 <syscall>
  801cfc:	83 c4 18             	add    $0x18,%esp
  801cff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801d02:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801d06:	75 07                	jne    801d0f <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801d08:	b8 01 00 00 00       	mov    $0x1,%eax
  801d0d:	eb 05                	jmp    801d14 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801d0f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d14:	c9                   	leave  
  801d15:	c3                   	ret    

00801d16 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801d16:	55                   	push   %ebp
  801d17:	89 e5                	mov    %esp,%ebp
  801d19:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d1c:	6a 00                	push   $0x0
  801d1e:	6a 00                	push   $0x0
  801d20:	6a 00                	push   $0x0
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	6a 2c                	push   $0x2c
  801d28:	e8 1a fa ff ff       	call   801747 <syscall>
  801d2d:	83 c4 18             	add    $0x18,%esp
  801d30:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d33:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d37:	75 07                	jne    801d40 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d39:	b8 01 00 00 00       	mov    $0x1,%eax
  801d3e:	eb 05                	jmp    801d45 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d40:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d45:	c9                   	leave  
  801d46:	c3                   	ret    

00801d47 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d47:	55                   	push   %ebp
  801d48:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d4a:	6a 00                	push   $0x0
  801d4c:	6a 00                	push   $0x0
  801d4e:	6a 00                	push   $0x0
  801d50:	6a 00                	push   $0x0
  801d52:	ff 75 08             	pushl  0x8(%ebp)
  801d55:	6a 2d                	push   $0x2d
  801d57:	e8 eb f9 ff ff       	call   801747 <syscall>
  801d5c:	83 c4 18             	add    $0x18,%esp
	return ;
  801d5f:	90                   	nop
}
  801d60:	c9                   	leave  
  801d61:	c3                   	ret    

00801d62 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d62:	55                   	push   %ebp
  801d63:	89 e5                	mov    %esp,%ebp
  801d65:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d66:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d69:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d6c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d72:	6a 00                	push   $0x0
  801d74:	53                   	push   %ebx
  801d75:	51                   	push   %ecx
  801d76:	52                   	push   %edx
  801d77:	50                   	push   %eax
  801d78:	6a 2e                	push   $0x2e
  801d7a:	e8 c8 f9 ff ff       	call   801747 <syscall>
  801d7f:	83 c4 18             	add    $0x18,%esp
}
  801d82:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d85:	c9                   	leave  
  801d86:	c3                   	ret    

00801d87 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d87:	55                   	push   %ebp
  801d88:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d8a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d90:	6a 00                	push   $0x0
  801d92:	6a 00                	push   $0x0
  801d94:	6a 00                	push   $0x0
  801d96:	52                   	push   %edx
  801d97:	50                   	push   %eax
  801d98:	6a 2f                	push   $0x2f
  801d9a:	e8 a8 f9 ff ff       	call   801747 <syscall>
  801d9f:	83 c4 18             	add    $0x18,%esp
}
  801da2:	c9                   	leave  
  801da3:	c3                   	ret    

00801da4 <__udivdi3>:
  801da4:	55                   	push   %ebp
  801da5:	57                   	push   %edi
  801da6:	56                   	push   %esi
  801da7:	53                   	push   %ebx
  801da8:	83 ec 1c             	sub    $0x1c,%esp
  801dab:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801daf:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801db3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801db7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801dbb:	89 ca                	mov    %ecx,%edx
  801dbd:	89 f8                	mov    %edi,%eax
  801dbf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801dc3:	85 f6                	test   %esi,%esi
  801dc5:	75 2d                	jne    801df4 <__udivdi3+0x50>
  801dc7:	39 cf                	cmp    %ecx,%edi
  801dc9:	77 65                	ja     801e30 <__udivdi3+0x8c>
  801dcb:	89 fd                	mov    %edi,%ebp
  801dcd:	85 ff                	test   %edi,%edi
  801dcf:	75 0b                	jne    801ddc <__udivdi3+0x38>
  801dd1:	b8 01 00 00 00       	mov    $0x1,%eax
  801dd6:	31 d2                	xor    %edx,%edx
  801dd8:	f7 f7                	div    %edi
  801dda:	89 c5                	mov    %eax,%ebp
  801ddc:	31 d2                	xor    %edx,%edx
  801dde:	89 c8                	mov    %ecx,%eax
  801de0:	f7 f5                	div    %ebp
  801de2:	89 c1                	mov    %eax,%ecx
  801de4:	89 d8                	mov    %ebx,%eax
  801de6:	f7 f5                	div    %ebp
  801de8:	89 cf                	mov    %ecx,%edi
  801dea:	89 fa                	mov    %edi,%edx
  801dec:	83 c4 1c             	add    $0x1c,%esp
  801def:	5b                   	pop    %ebx
  801df0:	5e                   	pop    %esi
  801df1:	5f                   	pop    %edi
  801df2:	5d                   	pop    %ebp
  801df3:	c3                   	ret    
  801df4:	39 ce                	cmp    %ecx,%esi
  801df6:	77 28                	ja     801e20 <__udivdi3+0x7c>
  801df8:	0f bd fe             	bsr    %esi,%edi
  801dfb:	83 f7 1f             	xor    $0x1f,%edi
  801dfe:	75 40                	jne    801e40 <__udivdi3+0x9c>
  801e00:	39 ce                	cmp    %ecx,%esi
  801e02:	72 0a                	jb     801e0e <__udivdi3+0x6a>
  801e04:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e08:	0f 87 9e 00 00 00    	ja     801eac <__udivdi3+0x108>
  801e0e:	b8 01 00 00 00       	mov    $0x1,%eax
  801e13:	89 fa                	mov    %edi,%edx
  801e15:	83 c4 1c             	add    $0x1c,%esp
  801e18:	5b                   	pop    %ebx
  801e19:	5e                   	pop    %esi
  801e1a:	5f                   	pop    %edi
  801e1b:	5d                   	pop    %ebp
  801e1c:	c3                   	ret    
  801e1d:	8d 76 00             	lea    0x0(%esi),%esi
  801e20:	31 ff                	xor    %edi,%edi
  801e22:	31 c0                	xor    %eax,%eax
  801e24:	89 fa                	mov    %edi,%edx
  801e26:	83 c4 1c             	add    $0x1c,%esp
  801e29:	5b                   	pop    %ebx
  801e2a:	5e                   	pop    %esi
  801e2b:	5f                   	pop    %edi
  801e2c:	5d                   	pop    %ebp
  801e2d:	c3                   	ret    
  801e2e:	66 90                	xchg   %ax,%ax
  801e30:	89 d8                	mov    %ebx,%eax
  801e32:	f7 f7                	div    %edi
  801e34:	31 ff                	xor    %edi,%edi
  801e36:	89 fa                	mov    %edi,%edx
  801e38:	83 c4 1c             	add    $0x1c,%esp
  801e3b:	5b                   	pop    %ebx
  801e3c:	5e                   	pop    %esi
  801e3d:	5f                   	pop    %edi
  801e3e:	5d                   	pop    %ebp
  801e3f:	c3                   	ret    
  801e40:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e45:	89 eb                	mov    %ebp,%ebx
  801e47:	29 fb                	sub    %edi,%ebx
  801e49:	89 f9                	mov    %edi,%ecx
  801e4b:	d3 e6                	shl    %cl,%esi
  801e4d:	89 c5                	mov    %eax,%ebp
  801e4f:	88 d9                	mov    %bl,%cl
  801e51:	d3 ed                	shr    %cl,%ebp
  801e53:	89 e9                	mov    %ebp,%ecx
  801e55:	09 f1                	or     %esi,%ecx
  801e57:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e5b:	89 f9                	mov    %edi,%ecx
  801e5d:	d3 e0                	shl    %cl,%eax
  801e5f:	89 c5                	mov    %eax,%ebp
  801e61:	89 d6                	mov    %edx,%esi
  801e63:	88 d9                	mov    %bl,%cl
  801e65:	d3 ee                	shr    %cl,%esi
  801e67:	89 f9                	mov    %edi,%ecx
  801e69:	d3 e2                	shl    %cl,%edx
  801e6b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e6f:	88 d9                	mov    %bl,%cl
  801e71:	d3 e8                	shr    %cl,%eax
  801e73:	09 c2                	or     %eax,%edx
  801e75:	89 d0                	mov    %edx,%eax
  801e77:	89 f2                	mov    %esi,%edx
  801e79:	f7 74 24 0c          	divl   0xc(%esp)
  801e7d:	89 d6                	mov    %edx,%esi
  801e7f:	89 c3                	mov    %eax,%ebx
  801e81:	f7 e5                	mul    %ebp
  801e83:	39 d6                	cmp    %edx,%esi
  801e85:	72 19                	jb     801ea0 <__udivdi3+0xfc>
  801e87:	74 0b                	je     801e94 <__udivdi3+0xf0>
  801e89:	89 d8                	mov    %ebx,%eax
  801e8b:	31 ff                	xor    %edi,%edi
  801e8d:	e9 58 ff ff ff       	jmp    801dea <__udivdi3+0x46>
  801e92:	66 90                	xchg   %ax,%ax
  801e94:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e98:	89 f9                	mov    %edi,%ecx
  801e9a:	d3 e2                	shl    %cl,%edx
  801e9c:	39 c2                	cmp    %eax,%edx
  801e9e:	73 e9                	jae    801e89 <__udivdi3+0xe5>
  801ea0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801ea3:	31 ff                	xor    %edi,%edi
  801ea5:	e9 40 ff ff ff       	jmp    801dea <__udivdi3+0x46>
  801eaa:	66 90                	xchg   %ax,%ax
  801eac:	31 c0                	xor    %eax,%eax
  801eae:	e9 37 ff ff ff       	jmp    801dea <__udivdi3+0x46>
  801eb3:	90                   	nop

00801eb4 <__umoddi3>:
  801eb4:	55                   	push   %ebp
  801eb5:	57                   	push   %edi
  801eb6:	56                   	push   %esi
  801eb7:	53                   	push   %ebx
  801eb8:	83 ec 1c             	sub    $0x1c,%esp
  801ebb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ebf:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ec3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ec7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801ecb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801ecf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801ed3:	89 f3                	mov    %esi,%ebx
  801ed5:	89 fa                	mov    %edi,%edx
  801ed7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801edb:	89 34 24             	mov    %esi,(%esp)
  801ede:	85 c0                	test   %eax,%eax
  801ee0:	75 1a                	jne    801efc <__umoddi3+0x48>
  801ee2:	39 f7                	cmp    %esi,%edi
  801ee4:	0f 86 a2 00 00 00    	jbe    801f8c <__umoddi3+0xd8>
  801eea:	89 c8                	mov    %ecx,%eax
  801eec:	89 f2                	mov    %esi,%edx
  801eee:	f7 f7                	div    %edi
  801ef0:	89 d0                	mov    %edx,%eax
  801ef2:	31 d2                	xor    %edx,%edx
  801ef4:	83 c4 1c             	add    $0x1c,%esp
  801ef7:	5b                   	pop    %ebx
  801ef8:	5e                   	pop    %esi
  801ef9:	5f                   	pop    %edi
  801efa:	5d                   	pop    %ebp
  801efb:	c3                   	ret    
  801efc:	39 f0                	cmp    %esi,%eax
  801efe:	0f 87 ac 00 00 00    	ja     801fb0 <__umoddi3+0xfc>
  801f04:	0f bd e8             	bsr    %eax,%ebp
  801f07:	83 f5 1f             	xor    $0x1f,%ebp
  801f0a:	0f 84 ac 00 00 00    	je     801fbc <__umoddi3+0x108>
  801f10:	bf 20 00 00 00       	mov    $0x20,%edi
  801f15:	29 ef                	sub    %ebp,%edi
  801f17:	89 fe                	mov    %edi,%esi
  801f19:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f1d:	89 e9                	mov    %ebp,%ecx
  801f1f:	d3 e0                	shl    %cl,%eax
  801f21:	89 d7                	mov    %edx,%edi
  801f23:	89 f1                	mov    %esi,%ecx
  801f25:	d3 ef                	shr    %cl,%edi
  801f27:	09 c7                	or     %eax,%edi
  801f29:	89 e9                	mov    %ebp,%ecx
  801f2b:	d3 e2                	shl    %cl,%edx
  801f2d:	89 14 24             	mov    %edx,(%esp)
  801f30:	89 d8                	mov    %ebx,%eax
  801f32:	d3 e0                	shl    %cl,%eax
  801f34:	89 c2                	mov    %eax,%edx
  801f36:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f3a:	d3 e0                	shl    %cl,%eax
  801f3c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f40:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f44:	89 f1                	mov    %esi,%ecx
  801f46:	d3 e8                	shr    %cl,%eax
  801f48:	09 d0                	or     %edx,%eax
  801f4a:	d3 eb                	shr    %cl,%ebx
  801f4c:	89 da                	mov    %ebx,%edx
  801f4e:	f7 f7                	div    %edi
  801f50:	89 d3                	mov    %edx,%ebx
  801f52:	f7 24 24             	mull   (%esp)
  801f55:	89 c6                	mov    %eax,%esi
  801f57:	89 d1                	mov    %edx,%ecx
  801f59:	39 d3                	cmp    %edx,%ebx
  801f5b:	0f 82 87 00 00 00    	jb     801fe8 <__umoddi3+0x134>
  801f61:	0f 84 91 00 00 00    	je     801ff8 <__umoddi3+0x144>
  801f67:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f6b:	29 f2                	sub    %esi,%edx
  801f6d:	19 cb                	sbb    %ecx,%ebx
  801f6f:	89 d8                	mov    %ebx,%eax
  801f71:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f75:	d3 e0                	shl    %cl,%eax
  801f77:	89 e9                	mov    %ebp,%ecx
  801f79:	d3 ea                	shr    %cl,%edx
  801f7b:	09 d0                	or     %edx,%eax
  801f7d:	89 e9                	mov    %ebp,%ecx
  801f7f:	d3 eb                	shr    %cl,%ebx
  801f81:	89 da                	mov    %ebx,%edx
  801f83:	83 c4 1c             	add    $0x1c,%esp
  801f86:	5b                   	pop    %ebx
  801f87:	5e                   	pop    %esi
  801f88:	5f                   	pop    %edi
  801f89:	5d                   	pop    %ebp
  801f8a:	c3                   	ret    
  801f8b:	90                   	nop
  801f8c:	89 fd                	mov    %edi,%ebp
  801f8e:	85 ff                	test   %edi,%edi
  801f90:	75 0b                	jne    801f9d <__umoddi3+0xe9>
  801f92:	b8 01 00 00 00       	mov    $0x1,%eax
  801f97:	31 d2                	xor    %edx,%edx
  801f99:	f7 f7                	div    %edi
  801f9b:	89 c5                	mov    %eax,%ebp
  801f9d:	89 f0                	mov    %esi,%eax
  801f9f:	31 d2                	xor    %edx,%edx
  801fa1:	f7 f5                	div    %ebp
  801fa3:	89 c8                	mov    %ecx,%eax
  801fa5:	f7 f5                	div    %ebp
  801fa7:	89 d0                	mov    %edx,%eax
  801fa9:	e9 44 ff ff ff       	jmp    801ef2 <__umoddi3+0x3e>
  801fae:	66 90                	xchg   %ax,%ax
  801fb0:	89 c8                	mov    %ecx,%eax
  801fb2:	89 f2                	mov    %esi,%edx
  801fb4:	83 c4 1c             	add    $0x1c,%esp
  801fb7:	5b                   	pop    %ebx
  801fb8:	5e                   	pop    %esi
  801fb9:	5f                   	pop    %edi
  801fba:	5d                   	pop    %ebp
  801fbb:	c3                   	ret    
  801fbc:	3b 04 24             	cmp    (%esp),%eax
  801fbf:	72 06                	jb     801fc7 <__umoddi3+0x113>
  801fc1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801fc5:	77 0f                	ja     801fd6 <__umoddi3+0x122>
  801fc7:	89 f2                	mov    %esi,%edx
  801fc9:	29 f9                	sub    %edi,%ecx
  801fcb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801fcf:	89 14 24             	mov    %edx,(%esp)
  801fd2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801fd6:	8b 44 24 04          	mov    0x4(%esp),%eax
  801fda:	8b 14 24             	mov    (%esp),%edx
  801fdd:	83 c4 1c             	add    $0x1c,%esp
  801fe0:	5b                   	pop    %ebx
  801fe1:	5e                   	pop    %esi
  801fe2:	5f                   	pop    %edi
  801fe3:	5d                   	pop    %ebp
  801fe4:	c3                   	ret    
  801fe5:	8d 76 00             	lea    0x0(%esi),%esi
  801fe8:	2b 04 24             	sub    (%esp),%eax
  801feb:	19 fa                	sbb    %edi,%edx
  801fed:	89 d1                	mov    %edx,%ecx
  801fef:	89 c6                	mov    %eax,%esi
  801ff1:	e9 71 ff ff ff       	jmp    801f67 <__umoddi3+0xb3>
  801ff6:	66 90                	xchg   %ax,%ax
  801ff8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ffc:	72 ea                	jb     801fe8 <__umoddi3+0x134>
  801ffe:	89 d9                	mov    %ebx,%ecx
  802000:	e9 62 ff ff ff       	jmp    801f67 <__umoddi3+0xb3>
