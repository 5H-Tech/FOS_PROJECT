
obj/user/tst_page_replacement_mod_clock:     file format elf32-i386


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
  800031:	e8 61 05 00 00       	call   800597 <libmain>
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
  80003b:	83 ec 68             	sub    $0x68,%esp



	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80003e:	a1 20 30 80 00       	mov    0x803020,%eax
  800043:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800049:	8b 00                	mov    (%eax),%eax
  80004b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80004e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800051:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800056:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005b:	74 14                	je     800071 <_main+0x39>
  80005d:	83 ec 04             	sub    $0x4,%esp
  800060:	68 e0 1f 80 00       	push   $0x801fe0
  800065:	6a 15                	push   $0x15
  800067:	68 24 20 80 00       	push   $0x802024
  80006c:	e8 6b 06 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800071:	a1 20 30 80 00       	mov    0x803020,%eax
  800076:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80007c:	83 c0 10             	add    $0x10,%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800084:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 e0 1f 80 00       	push   $0x801fe0
  80009b:	6a 16                	push   $0x16
  80009d:	68 24 20 80 00       	push   $0x802024
  8000a2:	e8 35 06 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ac:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000b2:	83 c0 20             	add    $0x20,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8000ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 e0 1f 80 00       	push   $0x801fe0
  8000d1:	6a 17                	push   $0x17
  8000d3:	68 24 20 80 00       	push   $0x802024
  8000d8:	e8 ff 05 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000e8:	83 c0 30             	add    $0x30,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 e0 1f 80 00       	push   $0x801fe0
  800107:	6a 18                	push   $0x18
  800109:	68 24 20 80 00       	push   $0x802024
  80010e:	e8 c9 05 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800113:	a1 20 30 80 00       	mov    0x803020,%eax
  800118:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80011e:	83 c0 40             	add    $0x40,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800126:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 e0 1f 80 00       	push   $0x801fe0
  80013d:	6a 19                	push   $0x19
  80013f:	68 24 20 80 00       	push   $0x802024
  800144:	e8 93 05 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800149:	a1 20 30 80 00       	mov    0x803020,%eax
  80014e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800154:	83 c0 50             	add    $0x50,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80015c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 e0 1f 80 00       	push   $0x801fe0
  800173:	6a 1a                	push   $0x1a
  800175:	68 24 20 80 00       	push   $0x802024
  80017a:	e8 5d 05 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80017f:	a1 20 30 80 00       	mov    0x803020,%eax
  800184:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80018a:	83 c0 60             	add    $0x60,%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800192:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800195:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019a:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 e0 1f 80 00       	push   $0x801fe0
  8001a9:	6a 1b                	push   $0x1b
  8001ab:	68 24 20 80 00       	push   $0x802024
  8001b0:	e8 27 05 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ba:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001c0:	83 c0 70             	add    $0x70,%eax
  8001c3:	8b 00                	mov    (%eax),%eax
  8001c5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8001c8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d0:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d5:	74 14                	je     8001eb <_main+0x1b3>
  8001d7:	83 ec 04             	sub    $0x4,%esp
  8001da:	68 e0 1f 80 00       	push   $0x801fe0
  8001df:	6a 1c                	push   $0x1c
  8001e1:	68 24 20 80 00       	push   $0x802024
  8001e6:	e8 f1 04 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001f6:	83 e8 80             	sub    $0xffffff80,%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8001fe:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800201:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800206:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020b:	74 14                	je     800221 <_main+0x1e9>
  80020d:	83 ec 04             	sub    $0x4,%esp
  800210:	68 e0 1f 80 00       	push   $0x801fe0
  800215:	6a 1d                	push   $0x1d
  800217:	68 24 20 80 00       	push   $0x802024
  80021c:	e8 bb 04 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800221:	a1 20 30 80 00       	mov    0x803020,%eax
  800226:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80022c:	05 90 00 00 00       	add    $0x90,%eax
  800231:	8b 00                	mov    (%eax),%eax
  800233:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800236:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800239:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023e:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800243:	74 14                	je     800259 <_main+0x221>
  800245:	83 ec 04             	sub    $0x4,%esp
  800248:	68 e0 1f 80 00       	push   $0x801fe0
  80024d:	6a 1e                	push   $0x1e
  80024f:	68 24 20 80 00       	push   $0x802024
  800254:	e8 83 04 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800259:	a1 20 30 80 00       	mov    0x803020,%eax
  80025e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800264:	05 a0 00 00 00       	add    $0xa0,%eax
  800269:	8b 00                	mov    (%eax),%eax
  80026b:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80026e:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800271:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800276:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80027b:	74 14                	je     800291 <_main+0x259>
  80027d:	83 ec 04             	sub    $0x4,%esp
  800280:	68 e0 1f 80 00       	push   $0x801fe0
  800285:	6a 1f                	push   $0x1f
  800287:	68 24 20 80 00       	push   $0x802024
  80028c:	e8 4b 04 00 00       	call   8006dc <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  800291:	a1 20 30 80 00       	mov    0x803020,%eax
  800296:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  80029c:	85 c0                	test   %eax,%eax
  80029e:	74 14                	je     8002b4 <_main+0x27c>
  8002a0:	83 ec 04             	sub    $0x4,%esp
  8002a3:	68 4c 20 80 00       	push   $0x80204c
  8002a8:	6a 20                	push   $0x20
  8002aa:	68 24 20 80 00       	push   $0x802024
  8002af:	e8 28 04 00 00       	call   8006dc <_panic>
	}

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  8002b4:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8002b9:	88 45 c7             	mov    %al,-0x39(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  8002bc:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8002c1:	88 45 c6             	mov    %al,-0x3a(%ebp)

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002c4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8002cb:	eb 37                	jmp    800304 <_main+0x2cc>
	{
		arr[i] = -1 ;
  8002cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002d0:	05 40 30 80 00       	add    $0x803040,%eax
  8002d5:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  8002d8:	a1 04 30 80 00       	mov    0x803004,%eax
  8002dd:	8b 15 00 30 80 00    	mov    0x803000,%edx
  8002e3:	8a 12                	mov    (%edx),%dl
  8002e5:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  8002e7:	a1 00 30 80 00       	mov    0x803000,%eax
  8002ec:	40                   	inc    %eax
  8002ed:	a3 00 30 80 00       	mov    %eax,0x803000
  8002f2:	a1 04 30 80 00       	mov    0x803004,%eax
  8002f7:	40                   	inc    %eax
  8002f8:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1] ;
	char garbage2 = arr[PAGE_SIZE*12-1] ;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002fd:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  800304:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  80030b:	7e c0                	jle    8002cd <_main+0x295>
		ptr++ ; ptr2++ ;
	}

	//===================
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0x809000)  panic("modified clock algo failed");
  80030d:	a1 20 30 80 00       	mov    0x803020,%eax
  800312:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800318:	8b 00                	mov    (%eax),%eax
  80031a:	89 45 c0             	mov    %eax,-0x40(%ebp)
  80031d:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800320:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800325:	3d 00 90 80 00       	cmp    $0x809000,%eax
  80032a:	74 14                	je     800340 <_main+0x308>
  80032c:	83 ec 04             	sub    $0x4,%esp
  80032f:	68 92 20 80 00       	push   $0x802092
  800334:	6a 36                	push   $0x36
  800336:	68 24 20 80 00       	push   $0x802024
  80033b:	e8 9c 03 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x80a000)  panic("modified clock algo failed");
  800340:	a1 20 30 80 00       	mov    0x803020,%eax
  800345:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80034b:	83 c0 10             	add    $0x10,%eax
  80034e:	8b 00                	mov    (%eax),%eax
  800350:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800353:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800356:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80035b:	3d 00 a0 80 00       	cmp    $0x80a000,%eax
  800360:	74 14                	je     800376 <_main+0x33e>
  800362:	83 ec 04             	sub    $0x4,%esp
  800365:	68 92 20 80 00       	push   $0x802092
  80036a:	6a 37                	push   $0x37
  80036c:	68 24 20 80 00       	push   $0x802024
  800371:	e8 66 03 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x804000)  panic("modified clock algo failed");
  800376:	a1 20 30 80 00       	mov    0x803020,%eax
  80037b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800381:	83 c0 20             	add    $0x20,%eax
  800384:	8b 00                	mov    (%eax),%eax
  800386:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800389:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80038c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800391:	3d 00 40 80 00       	cmp    $0x804000,%eax
  800396:	74 14                	je     8003ac <_main+0x374>
  800398:	83 ec 04             	sub    $0x4,%esp
  80039b:	68 92 20 80 00       	push   $0x802092
  8003a0:	6a 38                	push   $0x38
  8003a2:	68 24 20 80 00       	push   $0x802024
  8003a7:	e8 30 03 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x80b000)  panic("modified clock algo failed");
  8003ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b1:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003b7:	83 c0 30             	add    $0x30,%eax
  8003ba:	8b 00                	mov    (%eax),%eax
  8003bc:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8003bf:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8003c2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003c7:	3d 00 b0 80 00       	cmp    $0x80b000,%eax
  8003cc:	74 14                	je     8003e2 <_main+0x3aa>
  8003ce:	83 ec 04             	sub    $0x4,%esp
  8003d1:	68 92 20 80 00       	push   $0x802092
  8003d6:	6a 39                	push   $0x39
  8003d8:	68 24 20 80 00       	push   $0x802024
  8003dd:	e8 fa 02 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x80c000)  panic("modified clock algo failed");
  8003e2:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003ed:	83 c0 40             	add    $0x40,%eax
  8003f0:	8b 00                	mov    (%eax),%eax
  8003f2:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8003f5:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8003f8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003fd:	3d 00 c0 80 00       	cmp    $0x80c000,%eax
  800402:	74 14                	je     800418 <_main+0x3e0>
  800404:	83 ec 04             	sub    $0x4,%esp
  800407:	68 92 20 80 00       	push   $0x802092
  80040c:	6a 3a                	push   $0x3a
  80040e:	68 24 20 80 00       	push   $0x802024
  800413:	e8 c4 02 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x807000)  panic("modified clock algo failed");
  800418:	a1 20 30 80 00       	mov    0x803020,%eax
  80041d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800423:	83 c0 50             	add    $0x50,%eax
  800426:	8b 00                	mov    (%eax),%eax
  800428:	89 45 ac             	mov    %eax,-0x54(%ebp)
  80042b:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80042e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800433:	3d 00 70 80 00       	cmp    $0x807000,%eax
  800438:	74 14                	je     80044e <_main+0x416>
  80043a:	83 ec 04             	sub    $0x4,%esp
  80043d:	68 92 20 80 00       	push   $0x802092
  800442:	6a 3b                	push   $0x3b
  800444:	68 24 20 80 00       	push   $0x802024
  800449:	e8 8e 02 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x800000)  panic("modified clock algo failed");
  80044e:	a1 20 30 80 00       	mov    0x803020,%eax
  800453:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800459:	83 c0 60             	add    $0x60,%eax
  80045c:	8b 00                	mov    (%eax),%eax
  80045e:	89 45 a8             	mov    %eax,-0x58(%ebp)
  800461:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800464:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800469:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80046e:	74 14                	je     800484 <_main+0x44c>
  800470:	83 ec 04             	sub    $0x4,%esp
  800473:	68 92 20 80 00       	push   $0x802092
  800478:	6a 3c                	push   $0x3c
  80047a:	68 24 20 80 00       	push   $0x802024
  80047f:	e8 58 02 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x801000)  panic("modified clock algo failed");
  800484:	a1 20 30 80 00       	mov    0x803020,%eax
  800489:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80048f:	83 c0 70             	add    $0x70,%eax
  800492:	8b 00                	mov    (%eax),%eax
  800494:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  800497:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80049a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80049f:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8004a4:	74 14                	je     8004ba <_main+0x482>
  8004a6:	83 ec 04             	sub    $0x4,%esp
  8004a9:	68 92 20 80 00       	push   $0x802092
  8004ae:	6a 3d                	push   $0x3d
  8004b0:	68 24 20 80 00       	push   $0x802024
  8004b5:	e8 22 02 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x808000)  panic("modified clock algo failed");
  8004ba:	a1 20 30 80 00       	mov    0x803020,%eax
  8004bf:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004c5:	83 e8 80             	sub    $0xffffff80,%eax
  8004c8:	8b 00                	mov    (%eax),%eax
  8004ca:	89 45 a0             	mov    %eax,-0x60(%ebp)
  8004cd:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8004d0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004d5:	3d 00 80 80 00       	cmp    $0x808000,%eax
  8004da:	74 14                	je     8004f0 <_main+0x4b8>
  8004dc:	83 ec 04             	sub    $0x4,%esp
  8004df:	68 92 20 80 00       	push   $0x802092
  8004e4:	6a 3e                	push   $0x3e
  8004e6:	68 24 20 80 00       	push   $0x802024
  8004eb:	e8 ec 01 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=  0x803000)  panic("modified clock algo failed");
  8004f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f5:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004fb:	05 90 00 00 00       	add    $0x90,%eax
  800500:	8b 00                	mov    (%eax),%eax
  800502:	89 45 9c             	mov    %eax,-0x64(%ebp)
  800505:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800508:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80050d:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800512:	74 14                	je     800528 <_main+0x4f0>
  800514:	83 ec 04             	sub    $0x4,%esp
  800517:	68 92 20 80 00       	push   $0x802092
  80051c:	6a 3f                	push   $0x3f
  80051e:	68 24 20 80 00       	push   $0x802024
  800523:	e8 b4 01 00 00       	call   8006dc <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("modified clock algo failed");
  800528:	a1 20 30 80 00       	mov    0x803020,%eax
  80052d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800533:	05 a0 00 00 00       	add    $0xa0,%eax
  800538:	8b 00                	mov    (%eax),%eax
  80053a:	89 45 98             	mov    %eax,-0x68(%ebp)
  80053d:	8b 45 98             	mov    -0x68(%ebp),%eax
  800540:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800545:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80054a:	74 14                	je     800560 <_main+0x528>
  80054c:	83 ec 04             	sub    $0x4,%esp
  80054f:	68 92 20 80 00       	push   $0x802092
  800554:	6a 40                	push   $0x40
  800556:	68 24 20 80 00       	push   $0x802024
  80055b:	e8 7c 01 00 00       	call   8006dc <_panic>

		if(myEnv->page_last_WS_index != 5) panic("wrong PAGE WS pointer location");
  800560:	a1 20 30 80 00       	mov    0x803020,%eax
  800565:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  80056b:	83 f8 05             	cmp    $0x5,%eax
  80056e:	74 14                	je     800584 <_main+0x54c>
  800570:	83 ec 04             	sub    $0x4,%esp
  800573:	68 b0 20 80 00       	push   $0x8020b0
  800578:	6a 42                	push   $0x42
  80057a:	68 24 20 80 00       	push   $0x802024
  80057f:	e8 58 01 00 00       	call   8006dc <_panic>

	}

	cprintf("Congratulations!! test PAGE replacement [Modified CLOCK Alg.] is completed successfully.\n");
  800584:	83 ec 0c             	sub    $0xc,%esp
  800587:	68 d0 20 80 00       	push   $0x8020d0
  80058c:	e8 ed 03 00 00       	call   80097e <cprintf>
  800591:	83 c4 10             	add    $0x10,%esp
	return;
  800594:	90                   	nop
}
  800595:	c9                   	leave  
  800596:	c3                   	ret    

00800597 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800597:	55                   	push   %ebp
  800598:	89 e5                	mov    %esp,%ebp
  80059a:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80059d:	e8 07 12 00 00       	call   8017a9 <sys_getenvindex>
  8005a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005a8:	89 d0                	mov    %edx,%eax
  8005aa:	c1 e0 03             	shl    $0x3,%eax
  8005ad:	01 d0                	add    %edx,%eax
  8005af:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8005b6:	01 c8                	add    %ecx,%eax
  8005b8:	01 c0                	add    %eax,%eax
  8005ba:	01 d0                	add    %edx,%eax
  8005bc:	01 c0                	add    %eax,%eax
  8005be:	01 d0                	add    %edx,%eax
  8005c0:	89 c2                	mov    %eax,%edx
  8005c2:	c1 e2 05             	shl    $0x5,%edx
  8005c5:	29 c2                	sub    %eax,%edx
  8005c7:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8005ce:	89 c2                	mov    %eax,%edx
  8005d0:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8005d6:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005db:	a1 20 30 80 00       	mov    0x803020,%eax
  8005e0:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8005e6:	84 c0                	test   %al,%al
  8005e8:	74 0f                	je     8005f9 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8005ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ef:	05 40 3c 01 00       	add    $0x13c40,%eax
  8005f4:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8005f9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8005fd:	7e 0a                	jle    800609 <libmain+0x72>
		binaryname = argv[0];
  8005ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800602:	8b 00                	mov    (%eax),%eax
  800604:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  800609:	83 ec 08             	sub    $0x8,%esp
  80060c:	ff 75 0c             	pushl  0xc(%ebp)
  80060f:	ff 75 08             	pushl  0x8(%ebp)
  800612:	e8 21 fa ff ff       	call   800038 <_main>
  800617:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80061a:	e8 25 13 00 00       	call   801944 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80061f:	83 ec 0c             	sub    $0xc,%esp
  800622:	68 44 21 80 00       	push   $0x802144
  800627:	e8 52 03 00 00       	call   80097e <cprintf>
  80062c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80062f:	a1 20 30 80 00       	mov    0x803020,%eax
  800634:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80063a:	a1 20 30 80 00       	mov    0x803020,%eax
  80063f:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800645:	83 ec 04             	sub    $0x4,%esp
  800648:	52                   	push   %edx
  800649:	50                   	push   %eax
  80064a:	68 6c 21 80 00       	push   $0x80216c
  80064f:	e8 2a 03 00 00       	call   80097e <cprintf>
  800654:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800657:	a1 20 30 80 00       	mov    0x803020,%eax
  80065c:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800662:	a1 20 30 80 00       	mov    0x803020,%eax
  800667:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80066d:	83 ec 04             	sub    $0x4,%esp
  800670:	52                   	push   %edx
  800671:	50                   	push   %eax
  800672:	68 94 21 80 00       	push   $0x802194
  800677:	e8 02 03 00 00       	call   80097e <cprintf>
  80067c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80067f:	a1 20 30 80 00       	mov    0x803020,%eax
  800684:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80068a:	83 ec 08             	sub    $0x8,%esp
  80068d:	50                   	push   %eax
  80068e:	68 d5 21 80 00       	push   $0x8021d5
  800693:	e8 e6 02 00 00       	call   80097e <cprintf>
  800698:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80069b:	83 ec 0c             	sub    $0xc,%esp
  80069e:	68 44 21 80 00       	push   $0x802144
  8006a3:	e8 d6 02 00 00       	call   80097e <cprintf>
  8006a8:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006ab:	e8 ae 12 00 00       	call   80195e <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006b0:	e8 19 00 00 00       	call   8006ce <exit>
}
  8006b5:	90                   	nop
  8006b6:	c9                   	leave  
  8006b7:	c3                   	ret    

008006b8 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006b8:	55                   	push   %ebp
  8006b9:	89 e5                	mov    %esp,%ebp
  8006bb:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006be:	83 ec 0c             	sub    $0xc,%esp
  8006c1:	6a 00                	push   $0x0
  8006c3:	e8 ad 10 00 00       	call   801775 <sys_env_destroy>
  8006c8:	83 c4 10             	add    $0x10,%esp
}
  8006cb:	90                   	nop
  8006cc:	c9                   	leave  
  8006cd:	c3                   	ret    

008006ce <exit>:

void
exit(void)
{
  8006ce:	55                   	push   %ebp
  8006cf:	89 e5                	mov    %esp,%ebp
  8006d1:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006d4:	e8 02 11 00 00       	call   8017db <sys_env_exit>
}
  8006d9:	90                   	nop
  8006da:	c9                   	leave  
  8006db:	c3                   	ret    

008006dc <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006dc:	55                   	push   %ebp
  8006dd:	89 e5                	mov    %esp,%ebp
  8006df:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006e2:	8d 45 10             	lea    0x10(%ebp),%eax
  8006e5:	83 c0 04             	add    $0x4,%eax
  8006e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006eb:	a1 18 f1 80 00       	mov    0x80f118,%eax
  8006f0:	85 c0                	test   %eax,%eax
  8006f2:	74 16                	je     80070a <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006f4:	a1 18 f1 80 00       	mov    0x80f118,%eax
  8006f9:	83 ec 08             	sub    $0x8,%esp
  8006fc:	50                   	push   %eax
  8006fd:	68 ec 21 80 00       	push   $0x8021ec
  800702:	e8 77 02 00 00       	call   80097e <cprintf>
  800707:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80070a:	a1 08 30 80 00       	mov    0x803008,%eax
  80070f:	ff 75 0c             	pushl  0xc(%ebp)
  800712:	ff 75 08             	pushl  0x8(%ebp)
  800715:	50                   	push   %eax
  800716:	68 f1 21 80 00       	push   $0x8021f1
  80071b:	e8 5e 02 00 00       	call   80097e <cprintf>
  800720:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800723:	8b 45 10             	mov    0x10(%ebp),%eax
  800726:	83 ec 08             	sub    $0x8,%esp
  800729:	ff 75 f4             	pushl  -0xc(%ebp)
  80072c:	50                   	push   %eax
  80072d:	e8 e1 01 00 00       	call   800913 <vcprintf>
  800732:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800735:	83 ec 08             	sub    $0x8,%esp
  800738:	6a 00                	push   $0x0
  80073a:	68 0d 22 80 00       	push   $0x80220d
  80073f:	e8 cf 01 00 00       	call   800913 <vcprintf>
  800744:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800747:	e8 82 ff ff ff       	call   8006ce <exit>

	// should not return here
	while (1) ;
  80074c:	eb fe                	jmp    80074c <_panic+0x70>

0080074e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80074e:	55                   	push   %ebp
  80074f:	89 e5                	mov    %esp,%ebp
  800751:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800754:	a1 20 30 80 00       	mov    0x803020,%eax
  800759:	8b 50 74             	mov    0x74(%eax),%edx
  80075c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80075f:	39 c2                	cmp    %eax,%edx
  800761:	74 14                	je     800777 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800763:	83 ec 04             	sub    $0x4,%esp
  800766:	68 10 22 80 00       	push   $0x802210
  80076b:	6a 26                	push   $0x26
  80076d:	68 5c 22 80 00       	push   $0x80225c
  800772:	e8 65 ff ff ff       	call   8006dc <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800777:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80077e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800785:	e9 b6 00 00 00       	jmp    800840 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80078a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80078d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800794:	8b 45 08             	mov    0x8(%ebp),%eax
  800797:	01 d0                	add    %edx,%eax
  800799:	8b 00                	mov    (%eax),%eax
  80079b:	85 c0                	test   %eax,%eax
  80079d:	75 08                	jne    8007a7 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80079f:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007a2:	e9 96 00 00 00       	jmp    80083d <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8007a7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007ae:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007b5:	eb 5d                	jmp    800814 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8007bc:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007c2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007c5:	c1 e2 04             	shl    $0x4,%edx
  8007c8:	01 d0                	add    %edx,%eax
  8007ca:	8a 40 04             	mov    0x4(%eax),%al
  8007cd:	84 c0                	test   %al,%al
  8007cf:	75 40                	jne    800811 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007d1:	a1 20 30 80 00       	mov    0x803020,%eax
  8007d6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007dc:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007df:	c1 e2 04             	shl    $0x4,%edx
  8007e2:	01 d0                	add    %edx,%eax
  8007e4:	8b 00                	mov    (%eax),%eax
  8007e6:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007e9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007ec:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007f1:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007f6:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8007fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800800:	01 c8                	add    %ecx,%eax
  800802:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800804:	39 c2                	cmp    %eax,%edx
  800806:	75 09                	jne    800811 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800808:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80080f:	eb 12                	jmp    800823 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800811:	ff 45 e8             	incl   -0x18(%ebp)
  800814:	a1 20 30 80 00       	mov    0x803020,%eax
  800819:	8b 50 74             	mov    0x74(%eax),%edx
  80081c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80081f:	39 c2                	cmp    %eax,%edx
  800821:	77 94                	ja     8007b7 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800823:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800827:	75 14                	jne    80083d <CheckWSWithoutLastIndex+0xef>
			panic(
  800829:	83 ec 04             	sub    $0x4,%esp
  80082c:	68 68 22 80 00       	push   $0x802268
  800831:	6a 3a                	push   $0x3a
  800833:	68 5c 22 80 00       	push   $0x80225c
  800838:	e8 9f fe ff ff       	call   8006dc <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80083d:	ff 45 f0             	incl   -0x10(%ebp)
  800840:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800843:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800846:	0f 8c 3e ff ff ff    	jl     80078a <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80084c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800853:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80085a:	eb 20                	jmp    80087c <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80085c:	a1 20 30 80 00       	mov    0x803020,%eax
  800861:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800867:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80086a:	c1 e2 04             	shl    $0x4,%edx
  80086d:	01 d0                	add    %edx,%eax
  80086f:	8a 40 04             	mov    0x4(%eax),%al
  800872:	3c 01                	cmp    $0x1,%al
  800874:	75 03                	jne    800879 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800876:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800879:	ff 45 e0             	incl   -0x20(%ebp)
  80087c:	a1 20 30 80 00       	mov    0x803020,%eax
  800881:	8b 50 74             	mov    0x74(%eax),%edx
  800884:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800887:	39 c2                	cmp    %eax,%edx
  800889:	77 d1                	ja     80085c <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80088b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80088e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800891:	74 14                	je     8008a7 <CheckWSWithoutLastIndex+0x159>
		panic(
  800893:	83 ec 04             	sub    $0x4,%esp
  800896:	68 bc 22 80 00       	push   $0x8022bc
  80089b:	6a 44                	push   $0x44
  80089d:	68 5c 22 80 00       	push   $0x80225c
  8008a2:	e8 35 fe ff ff       	call   8006dc <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008a7:	90                   	nop
  8008a8:	c9                   	leave  
  8008a9:	c3                   	ret    

008008aa <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008aa:	55                   	push   %ebp
  8008ab:	89 e5                	mov    %esp,%ebp
  8008ad:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b3:	8b 00                	mov    (%eax),%eax
  8008b5:	8d 48 01             	lea    0x1(%eax),%ecx
  8008b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008bb:	89 0a                	mov    %ecx,(%edx)
  8008bd:	8b 55 08             	mov    0x8(%ebp),%edx
  8008c0:	88 d1                	mov    %dl,%cl
  8008c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008c5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008cc:	8b 00                	mov    (%eax),%eax
  8008ce:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008d3:	75 2c                	jne    800901 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008d5:	a0 24 30 80 00       	mov    0x803024,%al
  8008da:	0f b6 c0             	movzbl %al,%eax
  8008dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008e0:	8b 12                	mov    (%edx),%edx
  8008e2:	89 d1                	mov    %edx,%ecx
  8008e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008e7:	83 c2 08             	add    $0x8,%edx
  8008ea:	83 ec 04             	sub    $0x4,%esp
  8008ed:	50                   	push   %eax
  8008ee:	51                   	push   %ecx
  8008ef:	52                   	push   %edx
  8008f0:	e8 3e 0e 00 00       	call   801733 <sys_cputs>
  8008f5:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8008f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800901:	8b 45 0c             	mov    0xc(%ebp),%eax
  800904:	8b 40 04             	mov    0x4(%eax),%eax
  800907:	8d 50 01             	lea    0x1(%eax),%edx
  80090a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800910:	90                   	nop
  800911:	c9                   	leave  
  800912:	c3                   	ret    

00800913 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800913:	55                   	push   %ebp
  800914:	89 e5                	mov    %esp,%ebp
  800916:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80091c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800923:	00 00 00 
	b.cnt = 0;
  800926:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80092d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800930:	ff 75 0c             	pushl  0xc(%ebp)
  800933:	ff 75 08             	pushl  0x8(%ebp)
  800936:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80093c:	50                   	push   %eax
  80093d:	68 aa 08 80 00       	push   $0x8008aa
  800942:	e8 11 02 00 00       	call   800b58 <vprintfmt>
  800947:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80094a:	a0 24 30 80 00       	mov    0x803024,%al
  80094f:	0f b6 c0             	movzbl %al,%eax
  800952:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800958:	83 ec 04             	sub    $0x4,%esp
  80095b:	50                   	push   %eax
  80095c:	52                   	push   %edx
  80095d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800963:	83 c0 08             	add    $0x8,%eax
  800966:	50                   	push   %eax
  800967:	e8 c7 0d 00 00       	call   801733 <sys_cputs>
  80096c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80096f:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800976:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80097c:	c9                   	leave  
  80097d:	c3                   	ret    

0080097e <cprintf>:

int cprintf(const char *fmt, ...) {
  80097e:	55                   	push   %ebp
  80097f:	89 e5                	mov    %esp,%ebp
  800981:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800984:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80098b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80098e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800991:	8b 45 08             	mov    0x8(%ebp),%eax
  800994:	83 ec 08             	sub    $0x8,%esp
  800997:	ff 75 f4             	pushl  -0xc(%ebp)
  80099a:	50                   	push   %eax
  80099b:	e8 73 ff ff ff       	call   800913 <vcprintf>
  8009a0:	83 c4 10             	add    $0x10,%esp
  8009a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009a9:	c9                   	leave  
  8009aa:	c3                   	ret    

008009ab <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009ab:	55                   	push   %ebp
  8009ac:	89 e5                	mov    %esp,%ebp
  8009ae:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009b1:	e8 8e 0f 00 00       	call   801944 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009b6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bf:	83 ec 08             	sub    $0x8,%esp
  8009c2:	ff 75 f4             	pushl  -0xc(%ebp)
  8009c5:	50                   	push   %eax
  8009c6:	e8 48 ff ff ff       	call   800913 <vcprintf>
  8009cb:	83 c4 10             	add    $0x10,%esp
  8009ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009d1:	e8 88 0f 00 00       	call   80195e <sys_enable_interrupt>
	return cnt;
  8009d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009d9:	c9                   	leave  
  8009da:	c3                   	ret    

008009db <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009db:	55                   	push   %ebp
  8009dc:	89 e5                	mov    %esp,%ebp
  8009de:	53                   	push   %ebx
  8009df:	83 ec 14             	sub    $0x14,%esp
  8009e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8009e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8009eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009ee:	8b 45 18             	mov    0x18(%ebp),%eax
  8009f1:	ba 00 00 00 00       	mov    $0x0,%edx
  8009f6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009f9:	77 55                	ja     800a50 <printnum+0x75>
  8009fb:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009fe:	72 05                	jb     800a05 <printnum+0x2a>
  800a00:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a03:	77 4b                	ja     800a50 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a05:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a08:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a0b:	8b 45 18             	mov    0x18(%ebp),%eax
  800a0e:	ba 00 00 00 00       	mov    $0x0,%edx
  800a13:	52                   	push   %edx
  800a14:	50                   	push   %eax
  800a15:	ff 75 f4             	pushl  -0xc(%ebp)
  800a18:	ff 75 f0             	pushl  -0x10(%ebp)
  800a1b:	e8 48 13 00 00       	call   801d68 <__udivdi3>
  800a20:	83 c4 10             	add    $0x10,%esp
  800a23:	83 ec 04             	sub    $0x4,%esp
  800a26:	ff 75 20             	pushl  0x20(%ebp)
  800a29:	53                   	push   %ebx
  800a2a:	ff 75 18             	pushl  0x18(%ebp)
  800a2d:	52                   	push   %edx
  800a2e:	50                   	push   %eax
  800a2f:	ff 75 0c             	pushl  0xc(%ebp)
  800a32:	ff 75 08             	pushl  0x8(%ebp)
  800a35:	e8 a1 ff ff ff       	call   8009db <printnum>
  800a3a:	83 c4 20             	add    $0x20,%esp
  800a3d:	eb 1a                	jmp    800a59 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a3f:	83 ec 08             	sub    $0x8,%esp
  800a42:	ff 75 0c             	pushl  0xc(%ebp)
  800a45:	ff 75 20             	pushl  0x20(%ebp)
  800a48:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4b:	ff d0                	call   *%eax
  800a4d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a50:	ff 4d 1c             	decl   0x1c(%ebp)
  800a53:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a57:	7f e6                	jg     800a3f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a59:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a5c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a61:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a64:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a67:	53                   	push   %ebx
  800a68:	51                   	push   %ecx
  800a69:	52                   	push   %edx
  800a6a:	50                   	push   %eax
  800a6b:	e8 08 14 00 00       	call   801e78 <__umoddi3>
  800a70:	83 c4 10             	add    $0x10,%esp
  800a73:	05 34 25 80 00       	add    $0x802534,%eax
  800a78:	8a 00                	mov    (%eax),%al
  800a7a:	0f be c0             	movsbl %al,%eax
  800a7d:	83 ec 08             	sub    $0x8,%esp
  800a80:	ff 75 0c             	pushl  0xc(%ebp)
  800a83:	50                   	push   %eax
  800a84:	8b 45 08             	mov    0x8(%ebp),%eax
  800a87:	ff d0                	call   *%eax
  800a89:	83 c4 10             	add    $0x10,%esp
}
  800a8c:	90                   	nop
  800a8d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a90:	c9                   	leave  
  800a91:	c3                   	ret    

00800a92 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a92:	55                   	push   %ebp
  800a93:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a95:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a99:	7e 1c                	jle    800ab7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9e:	8b 00                	mov    (%eax),%eax
  800aa0:	8d 50 08             	lea    0x8(%eax),%edx
  800aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa6:	89 10                	mov    %edx,(%eax)
  800aa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aab:	8b 00                	mov    (%eax),%eax
  800aad:	83 e8 08             	sub    $0x8,%eax
  800ab0:	8b 50 04             	mov    0x4(%eax),%edx
  800ab3:	8b 00                	mov    (%eax),%eax
  800ab5:	eb 40                	jmp    800af7 <getuint+0x65>
	else if (lflag)
  800ab7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800abb:	74 1e                	je     800adb <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800abd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac0:	8b 00                	mov    (%eax),%eax
  800ac2:	8d 50 04             	lea    0x4(%eax),%edx
  800ac5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac8:	89 10                	mov    %edx,(%eax)
  800aca:	8b 45 08             	mov    0x8(%ebp),%eax
  800acd:	8b 00                	mov    (%eax),%eax
  800acf:	83 e8 04             	sub    $0x4,%eax
  800ad2:	8b 00                	mov    (%eax),%eax
  800ad4:	ba 00 00 00 00       	mov    $0x0,%edx
  800ad9:	eb 1c                	jmp    800af7 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800adb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ade:	8b 00                	mov    (%eax),%eax
  800ae0:	8d 50 04             	lea    0x4(%eax),%edx
  800ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae6:	89 10                	mov    %edx,(%eax)
  800ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aeb:	8b 00                	mov    (%eax),%eax
  800aed:	83 e8 04             	sub    $0x4,%eax
  800af0:	8b 00                	mov    (%eax),%eax
  800af2:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800af7:	5d                   	pop    %ebp
  800af8:	c3                   	ret    

00800af9 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800af9:	55                   	push   %ebp
  800afa:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800afc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b00:	7e 1c                	jle    800b1e <getint+0x25>
		return va_arg(*ap, long long);
  800b02:	8b 45 08             	mov    0x8(%ebp),%eax
  800b05:	8b 00                	mov    (%eax),%eax
  800b07:	8d 50 08             	lea    0x8(%eax),%edx
  800b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0d:	89 10                	mov    %edx,(%eax)
  800b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b12:	8b 00                	mov    (%eax),%eax
  800b14:	83 e8 08             	sub    $0x8,%eax
  800b17:	8b 50 04             	mov    0x4(%eax),%edx
  800b1a:	8b 00                	mov    (%eax),%eax
  800b1c:	eb 38                	jmp    800b56 <getint+0x5d>
	else if (lflag)
  800b1e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b22:	74 1a                	je     800b3e <getint+0x45>
		return va_arg(*ap, long);
  800b24:	8b 45 08             	mov    0x8(%ebp),%eax
  800b27:	8b 00                	mov    (%eax),%eax
  800b29:	8d 50 04             	lea    0x4(%eax),%edx
  800b2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2f:	89 10                	mov    %edx,(%eax)
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
  800b34:	8b 00                	mov    (%eax),%eax
  800b36:	83 e8 04             	sub    $0x4,%eax
  800b39:	8b 00                	mov    (%eax),%eax
  800b3b:	99                   	cltd   
  800b3c:	eb 18                	jmp    800b56 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b41:	8b 00                	mov    (%eax),%eax
  800b43:	8d 50 04             	lea    0x4(%eax),%edx
  800b46:	8b 45 08             	mov    0x8(%ebp),%eax
  800b49:	89 10                	mov    %edx,(%eax)
  800b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4e:	8b 00                	mov    (%eax),%eax
  800b50:	83 e8 04             	sub    $0x4,%eax
  800b53:	8b 00                	mov    (%eax),%eax
  800b55:	99                   	cltd   
}
  800b56:	5d                   	pop    %ebp
  800b57:	c3                   	ret    

00800b58 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b58:	55                   	push   %ebp
  800b59:	89 e5                	mov    %esp,%ebp
  800b5b:	56                   	push   %esi
  800b5c:	53                   	push   %ebx
  800b5d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b60:	eb 17                	jmp    800b79 <vprintfmt+0x21>
			if (ch == '\0')
  800b62:	85 db                	test   %ebx,%ebx
  800b64:	0f 84 af 03 00 00    	je     800f19 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b6a:	83 ec 08             	sub    $0x8,%esp
  800b6d:	ff 75 0c             	pushl  0xc(%ebp)
  800b70:	53                   	push   %ebx
  800b71:	8b 45 08             	mov    0x8(%ebp),%eax
  800b74:	ff d0                	call   *%eax
  800b76:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b79:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7c:	8d 50 01             	lea    0x1(%eax),%edx
  800b7f:	89 55 10             	mov    %edx,0x10(%ebp)
  800b82:	8a 00                	mov    (%eax),%al
  800b84:	0f b6 d8             	movzbl %al,%ebx
  800b87:	83 fb 25             	cmp    $0x25,%ebx
  800b8a:	75 d6                	jne    800b62 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b8c:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b90:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b97:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b9e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800ba5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bac:	8b 45 10             	mov    0x10(%ebp),%eax
  800baf:	8d 50 01             	lea    0x1(%eax),%edx
  800bb2:	89 55 10             	mov    %edx,0x10(%ebp)
  800bb5:	8a 00                	mov    (%eax),%al
  800bb7:	0f b6 d8             	movzbl %al,%ebx
  800bba:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bbd:	83 f8 55             	cmp    $0x55,%eax
  800bc0:	0f 87 2b 03 00 00    	ja     800ef1 <vprintfmt+0x399>
  800bc6:	8b 04 85 58 25 80 00 	mov    0x802558(,%eax,4),%eax
  800bcd:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bcf:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800bd3:	eb d7                	jmp    800bac <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800bd5:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800bd9:	eb d1                	jmp    800bac <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bdb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800be2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800be5:	89 d0                	mov    %edx,%eax
  800be7:	c1 e0 02             	shl    $0x2,%eax
  800bea:	01 d0                	add    %edx,%eax
  800bec:	01 c0                	add    %eax,%eax
  800bee:	01 d8                	add    %ebx,%eax
  800bf0:	83 e8 30             	sub    $0x30,%eax
  800bf3:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800bf6:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf9:	8a 00                	mov    (%eax),%al
  800bfb:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800bfe:	83 fb 2f             	cmp    $0x2f,%ebx
  800c01:	7e 3e                	jle    800c41 <vprintfmt+0xe9>
  800c03:	83 fb 39             	cmp    $0x39,%ebx
  800c06:	7f 39                	jg     800c41 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c08:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c0b:	eb d5                	jmp    800be2 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c0d:	8b 45 14             	mov    0x14(%ebp),%eax
  800c10:	83 c0 04             	add    $0x4,%eax
  800c13:	89 45 14             	mov    %eax,0x14(%ebp)
  800c16:	8b 45 14             	mov    0x14(%ebp),%eax
  800c19:	83 e8 04             	sub    $0x4,%eax
  800c1c:	8b 00                	mov    (%eax),%eax
  800c1e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c21:	eb 1f                	jmp    800c42 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c23:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c27:	79 83                	jns    800bac <vprintfmt+0x54>
				width = 0;
  800c29:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c30:	e9 77 ff ff ff       	jmp    800bac <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c35:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c3c:	e9 6b ff ff ff       	jmp    800bac <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c41:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c42:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c46:	0f 89 60 ff ff ff    	jns    800bac <vprintfmt+0x54>
				width = precision, precision = -1;
  800c4c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c4f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c52:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c59:	e9 4e ff ff ff       	jmp    800bac <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c5e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c61:	e9 46 ff ff ff       	jmp    800bac <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c66:	8b 45 14             	mov    0x14(%ebp),%eax
  800c69:	83 c0 04             	add    $0x4,%eax
  800c6c:	89 45 14             	mov    %eax,0x14(%ebp)
  800c6f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c72:	83 e8 04             	sub    $0x4,%eax
  800c75:	8b 00                	mov    (%eax),%eax
  800c77:	83 ec 08             	sub    $0x8,%esp
  800c7a:	ff 75 0c             	pushl  0xc(%ebp)
  800c7d:	50                   	push   %eax
  800c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c81:	ff d0                	call   *%eax
  800c83:	83 c4 10             	add    $0x10,%esp
			break;
  800c86:	e9 89 02 00 00       	jmp    800f14 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c8b:	8b 45 14             	mov    0x14(%ebp),%eax
  800c8e:	83 c0 04             	add    $0x4,%eax
  800c91:	89 45 14             	mov    %eax,0x14(%ebp)
  800c94:	8b 45 14             	mov    0x14(%ebp),%eax
  800c97:	83 e8 04             	sub    $0x4,%eax
  800c9a:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c9c:	85 db                	test   %ebx,%ebx
  800c9e:	79 02                	jns    800ca2 <vprintfmt+0x14a>
				err = -err;
  800ca0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ca2:	83 fb 64             	cmp    $0x64,%ebx
  800ca5:	7f 0b                	jg     800cb2 <vprintfmt+0x15a>
  800ca7:	8b 34 9d a0 23 80 00 	mov    0x8023a0(,%ebx,4),%esi
  800cae:	85 f6                	test   %esi,%esi
  800cb0:	75 19                	jne    800ccb <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cb2:	53                   	push   %ebx
  800cb3:	68 45 25 80 00       	push   $0x802545
  800cb8:	ff 75 0c             	pushl  0xc(%ebp)
  800cbb:	ff 75 08             	pushl  0x8(%ebp)
  800cbe:	e8 5e 02 00 00       	call   800f21 <printfmt>
  800cc3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cc6:	e9 49 02 00 00       	jmp    800f14 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ccb:	56                   	push   %esi
  800ccc:	68 4e 25 80 00       	push   $0x80254e
  800cd1:	ff 75 0c             	pushl  0xc(%ebp)
  800cd4:	ff 75 08             	pushl  0x8(%ebp)
  800cd7:	e8 45 02 00 00       	call   800f21 <printfmt>
  800cdc:	83 c4 10             	add    $0x10,%esp
			break;
  800cdf:	e9 30 02 00 00       	jmp    800f14 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ce4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce7:	83 c0 04             	add    $0x4,%eax
  800cea:	89 45 14             	mov    %eax,0x14(%ebp)
  800ced:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf0:	83 e8 04             	sub    $0x4,%eax
  800cf3:	8b 30                	mov    (%eax),%esi
  800cf5:	85 f6                	test   %esi,%esi
  800cf7:	75 05                	jne    800cfe <vprintfmt+0x1a6>
				p = "(null)";
  800cf9:	be 51 25 80 00       	mov    $0x802551,%esi
			if (width > 0 && padc != '-')
  800cfe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d02:	7e 6d                	jle    800d71 <vprintfmt+0x219>
  800d04:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d08:	74 67                	je     800d71 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d0a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d0d:	83 ec 08             	sub    $0x8,%esp
  800d10:	50                   	push   %eax
  800d11:	56                   	push   %esi
  800d12:	e8 0c 03 00 00       	call   801023 <strnlen>
  800d17:	83 c4 10             	add    $0x10,%esp
  800d1a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d1d:	eb 16                	jmp    800d35 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d1f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d23:	83 ec 08             	sub    $0x8,%esp
  800d26:	ff 75 0c             	pushl  0xc(%ebp)
  800d29:	50                   	push   %eax
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	ff d0                	call   *%eax
  800d2f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d32:	ff 4d e4             	decl   -0x1c(%ebp)
  800d35:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d39:	7f e4                	jg     800d1f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d3b:	eb 34                	jmp    800d71 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d3d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d41:	74 1c                	je     800d5f <vprintfmt+0x207>
  800d43:	83 fb 1f             	cmp    $0x1f,%ebx
  800d46:	7e 05                	jle    800d4d <vprintfmt+0x1f5>
  800d48:	83 fb 7e             	cmp    $0x7e,%ebx
  800d4b:	7e 12                	jle    800d5f <vprintfmt+0x207>
					putch('?', putdat);
  800d4d:	83 ec 08             	sub    $0x8,%esp
  800d50:	ff 75 0c             	pushl  0xc(%ebp)
  800d53:	6a 3f                	push   $0x3f
  800d55:	8b 45 08             	mov    0x8(%ebp),%eax
  800d58:	ff d0                	call   *%eax
  800d5a:	83 c4 10             	add    $0x10,%esp
  800d5d:	eb 0f                	jmp    800d6e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d5f:	83 ec 08             	sub    $0x8,%esp
  800d62:	ff 75 0c             	pushl  0xc(%ebp)
  800d65:	53                   	push   %ebx
  800d66:	8b 45 08             	mov    0x8(%ebp),%eax
  800d69:	ff d0                	call   *%eax
  800d6b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d6e:	ff 4d e4             	decl   -0x1c(%ebp)
  800d71:	89 f0                	mov    %esi,%eax
  800d73:	8d 70 01             	lea    0x1(%eax),%esi
  800d76:	8a 00                	mov    (%eax),%al
  800d78:	0f be d8             	movsbl %al,%ebx
  800d7b:	85 db                	test   %ebx,%ebx
  800d7d:	74 24                	je     800da3 <vprintfmt+0x24b>
  800d7f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d83:	78 b8                	js     800d3d <vprintfmt+0x1e5>
  800d85:	ff 4d e0             	decl   -0x20(%ebp)
  800d88:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d8c:	79 af                	jns    800d3d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d8e:	eb 13                	jmp    800da3 <vprintfmt+0x24b>
				putch(' ', putdat);
  800d90:	83 ec 08             	sub    $0x8,%esp
  800d93:	ff 75 0c             	pushl  0xc(%ebp)
  800d96:	6a 20                	push   $0x20
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9b:	ff d0                	call   *%eax
  800d9d:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800da0:	ff 4d e4             	decl   -0x1c(%ebp)
  800da3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800da7:	7f e7                	jg     800d90 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800da9:	e9 66 01 00 00       	jmp    800f14 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800dae:	83 ec 08             	sub    $0x8,%esp
  800db1:	ff 75 e8             	pushl  -0x18(%ebp)
  800db4:	8d 45 14             	lea    0x14(%ebp),%eax
  800db7:	50                   	push   %eax
  800db8:	e8 3c fd ff ff       	call   800af9 <getint>
  800dbd:	83 c4 10             	add    $0x10,%esp
  800dc0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dc3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dc9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dcc:	85 d2                	test   %edx,%edx
  800dce:	79 23                	jns    800df3 <vprintfmt+0x29b>
				putch('-', putdat);
  800dd0:	83 ec 08             	sub    $0x8,%esp
  800dd3:	ff 75 0c             	pushl  0xc(%ebp)
  800dd6:	6a 2d                	push   $0x2d
  800dd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddb:	ff d0                	call   *%eax
  800ddd:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800de0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800de3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800de6:	f7 d8                	neg    %eax
  800de8:	83 d2 00             	adc    $0x0,%edx
  800deb:	f7 da                	neg    %edx
  800ded:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800df0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800df3:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800dfa:	e9 bc 00 00 00       	jmp    800ebb <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800dff:	83 ec 08             	sub    $0x8,%esp
  800e02:	ff 75 e8             	pushl  -0x18(%ebp)
  800e05:	8d 45 14             	lea    0x14(%ebp),%eax
  800e08:	50                   	push   %eax
  800e09:	e8 84 fc ff ff       	call   800a92 <getuint>
  800e0e:	83 c4 10             	add    $0x10,%esp
  800e11:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e14:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e17:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e1e:	e9 98 00 00 00       	jmp    800ebb <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e23:	83 ec 08             	sub    $0x8,%esp
  800e26:	ff 75 0c             	pushl  0xc(%ebp)
  800e29:	6a 58                	push   $0x58
  800e2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2e:	ff d0                	call   *%eax
  800e30:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e33:	83 ec 08             	sub    $0x8,%esp
  800e36:	ff 75 0c             	pushl  0xc(%ebp)
  800e39:	6a 58                	push   $0x58
  800e3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3e:	ff d0                	call   *%eax
  800e40:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e43:	83 ec 08             	sub    $0x8,%esp
  800e46:	ff 75 0c             	pushl  0xc(%ebp)
  800e49:	6a 58                	push   $0x58
  800e4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4e:	ff d0                	call   *%eax
  800e50:	83 c4 10             	add    $0x10,%esp
			break;
  800e53:	e9 bc 00 00 00       	jmp    800f14 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e58:	83 ec 08             	sub    $0x8,%esp
  800e5b:	ff 75 0c             	pushl  0xc(%ebp)
  800e5e:	6a 30                	push   $0x30
  800e60:	8b 45 08             	mov    0x8(%ebp),%eax
  800e63:	ff d0                	call   *%eax
  800e65:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e68:	83 ec 08             	sub    $0x8,%esp
  800e6b:	ff 75 0c             	pushl  0xc(%ebp)
  800e6e:	6a 78                	push   $0x78
  800e70:	8b 45 08             	mov    0x8(%ebp),%eax
  800e73:	ff d0                	call   *%eax
  800e75:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e78:	8b 45 14             	mov    0x14(%ebp),%eax
  800e7b:	83 c0 04             	add    $0x4,%eax
  800e7e:	89 45 14             	mov    %eax,0x14(%ebp)
  800e81:	8b 45 14             	mov    0x14(%ebp),%eax
  800e84:	83 e8 04             	sub    $0x4,%eax
  800e87:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e89:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e8c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e93:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e9a:	eb 1f                	jmp    800ebb <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e9c:	83 ec 08             	sub    $0x8,%esp
  800e9f:	ff 75 e8             	pushl  -0x18(%ebp)
  800ea2:	8d 45 14             	lea    0x14(%ebp),%eax
  800ea5:	50                   	push   %eax
  800ea6:	e8 e7 fb ff ff       	call   800a92 <getuint>
  800eab:	83 c4 10             	add    $0x10,%esp
  800eae:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eb1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800eb4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ebb:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ebf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ec2:	83 ec 04             	sub    $0x4,%esp
  800ec5:	52                   	push   %edx
  800ec6:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ec9:	50                   	push   %eax
  800eca:	ff 75 f4             	pushl  -0xc(%ebp)
  800ecd:	ff 75 f0             	pushl  -0x10(%ebp)
  800ed0:	ff 75 0c             	pushl  0xc(%ebp)
  800ed3:	ff 75 08             	pushl  0x8(%ebp)
  800ed6:	e8 00 fb ff ff       	call   8009db <printnum>
  800edb:	83 c4 20             	add    $0x20,%esp
			break;
  800ede:	eb 34                	jmp    800f14 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ee0:	83 ec 08             	sub    $0x8,%esp
  800ee3:	ff 75 0c             	pushl  0xc(%ebp)
  800ee6:	53                   	push   %ebx
  800ee7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eea:	ff d0                	call   *%eax
  800eec:	83 c4 10             	add    $0x10,%esp
			break;
  800eef:	eb 23                	jmp    800f14 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ef1:	83 ec 08             	sub    $0x8,%esp
  800ef4:	ff 75 0c             	pushl  0xc(%ebp)
  800ef7:	6a 25                	push   $0x25
  800ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  800efc:	ff d0                	call   *%eax
  800efe:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f01:	ff 4d 10             	decl   0x10(%ebp)
  800f04:	eb 03                	jmp    800f09 <vprintfmt+0x3b1>
  800f06:	ff 4d 10             	decl   0x10(%ebp)
  800f09:	8b 45 10             	mov    0x10(%ebp),%eax
  800f0c:	48                   	dec    %eax
  800f0d:	8a 00                	mov    (%eax),%al
  800f0f:	3c 25                	cmp    $0x25,%al
  800f11:	75 f3                	jne    800f06 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f13:	90                   	nop
		}
	}
  800f14:	e9 47 fc ff ff       	jmp    800b60 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f19:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f1a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f1d:	5b                   	pop    %ebx
  800f1e:	5e                   	pop    %esi
  800f1f:	5d                   	pop    %ebp
  800f20:	c3                   	ret    

00800f21 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f21:	55                   	push   %ebp
  800f22:	89 e5                	mov    %esp,%ebp
  800f24:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f27:	8d 45 10             	lea    0x10(%ebp),%eax
  800f2a:	83 c0 04             	add    $0x4,%eax
  800f2d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f30:	8b 45 10             	mov    0x10(%ebp),%eax
  800f33:	ff 75 f4             	pushl  -0xc(%ebp)
  800f36:	50                   	push   %eax
  800f37:	ff 75 0c             	pushl  0xc(%ebp)
  800f3a:	ff 75 08             	pushl  0x8(%ebp)
  800f3d:	e8 16 fc ff ff       	call   800b58 <vprintfmt>
  800f42:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f45:	90                   	nop
  800f46:	c9                   	leave  
  800f47:	c3                   	ret    

00800f48 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f48:	55                   	push   %ebp
  800f49:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4e:	8b 40 08             	mov    0x8(%eax),%eax
  800f51:	8d 50 01             	lea    0x1(%eax),%edx
  800f54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f57:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5d:	8b 10                	mov    (%eax),%edx
  800f5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f62:	8b 40 04             	mov    0x4(%eax),%eax
  800f65:	39 c2                	cmp    %eax,%edx
  800f67:	73 12                	jae    800f7b <sprintputch+0x33>
		*b->buf++ = ch;
  800f69:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6c:	8b 00                	mov    (%eax),%eax
  800f6e:	8d 48 01             	lea    0x1(%eax),%ecx
  800f71:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f74:	89 0a                	mov    %ecx,(%edx)
  800f76:	8b 55 08             	mov    0x8(%ebp),%edx
  800f79:	88 10                	mov    %dl,(%eax)
}
  800f7b:	90                   	nop
  800f7c:	5d                   	pop    %ebp
  800f7d:	c3                   	ret    

00800f7e <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f7e:	55                   	push   %ebp
  800f7f:	89 e5                	mov    %esp,%ebp
  800f81:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f84:	8b 45 08             	mov    0x8(%ebp),%eax
  800f87:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f90:	8b 45 08             	mov    0x8(%ebp),%eax
  800f93:	01 d0                	add    %edx,%eax
  800f95:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f98:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f9f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fa3:	74 06                	je     800fab <vsnprintf+0x2d>
  800fa5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fa9:	7f 07                	jg     800fb2 <vsnprintf+0x34>
		return -E_INVAL;
  800fab:	b8 03 00 00 00       	mov    $0x3,%eax
  800fb0:	eb 20                	jmp    800fd2 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fb2:	ff 75 14             	pushl  0x14(%ebp)
  800fb5:	ff 75 10             	pushl  0x10(%ebp)
  800fb8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fbb:	50                   	push   %eax
  800fbc:	68 48 0f 80 00       	push   $0x800f48
  800fc1:	e8 92 fb ff ff       	call   800b58 <vprintfmt>
  800fc6:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fc9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fcc:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fd2:	c9                   	leave  
  800fd3:	c3                   	ret    

00800fd4 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fd4:	55                   	push   %ebp
  800fd5:	89 e5                	mov    %esp,%ebp
  800fd7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fda:	8d 45 10             	lea    0x10(%ebp),%eax
  800fdd:	83 c0 04             	add    $0x4,%eax
  800fe0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800fe3:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe6:	ff 75 f4             	pushl  -0xc(%ebp)
  800fe9:	50                   	push   %eax
  800fea:	ff 75 0c             	pushl  0xc(%ebp)
  800fed:	ff 75 08             	pushl  0x8(%ebp)
  800ff0:	e8 89 ff ff ff       	call   800f7e <vsnprintf>
  800ff5:	83 c4 10             	add    $0x10,%esp
  800ff8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ffb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ffe:	c9                   	leave  
  800fff:	c3                   	ret    

00801000 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801000:	55                   	push   %ebp
  801001:	89 e5                	mov    %esp,%ebp
  801003:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801006:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80100d:	eb 06                	jmp    801015 <strlen+0x15>
		n++;
  80100f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801012:	ff 45 08             	incl   0x8(%ebp)
  801015:	8b 45 08             	mov    0x8(%ebp),%eax
  801018:	8a 00                	mov    (%eax),%al
  80101a:	84 c0                	test   %al,%al
  80101c:	75 f1                	jne    80100f <strlen+0xf>
		n++;
	return n;
  80101e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801021:	c9                   	leave  
  801022:	c3                   	ret    

00801023 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801023:	55                   	push   %ebp
  801024:	89 e5                	mov    %esp,%ebp
  801026:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801029:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801030:	eb 09                	jmp    80103b <strnlen+0x18>
		n++;
  801032:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801035:	ff 45 08             	incl   0x8(%ebp)
  801038:	ff 4d 0c             	decl   0xc(%ebp)
  80103b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80103f:	74 09                	je     80104a <strnlen+0x27>
  801041:	8b 45 08             	mov    0x8(%ebp),%eax
  801044:	8a 00                	mov    (%eax),%al
  801046:	84 c0                	test   %al,%al
  801048:	75 e8                	jne    801032 <strnlen+0xf>
		n++;
	return n;
  80104a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80104d:	c9                   	leave  
  80104e:	c3                   	ret    

0080104f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80104f:	55                   	push   %ebp
  801050:	89 e5                	mov    %esp,%ebp
  801052:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801055:	8b 45 08             	mov    0x8(%ebp),%eax
  801058:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80105b:	90                   	nop
  80105c:	8b 45 08             	mov    0x8(%ebp),%eax
  80105f:	8d 50 01             	lea    0x1(%eax),%edx
  801062:	89 55 08             	mov    %edx,0x8(%ebp)
  801065:	8b 55 0c             	mov    0xc(%ebp),%edx
  801068:	8d 4a 01             	lea    0x1(%edx),%ecx
  80106b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80106e:	8a 12                	mov    (%edx),%dl
  801070:	88 10                	mov    %dl,(%eax)
  801072:	8a 00                	mov    (%eax),%al
  801074:	84 c0                	test   %al,%al
  801076:	75 e4                	jne    80105c <strcpy+0xd>
		/* do nothing */;
	return ret;
  801078:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80107b:	c9                   	leave  
  80107c:	c3                   	ret    

0080107d <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80107d:	55                   	push   %ebp
  80107e:	89 e5                	mov    %esp,%ebp
  801080:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801083:	8b 45 08             	mov    0x8(%ebp),%eax
  801086:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801089:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801090:	eb 1f                	jmp    8010b1 <strncpy+0x34>
		*dst++ = *src;
  801092:	8b 45 08             	mov    0x8(%ebp),%eax
  801095:	8d 50 01             	lea    0x1(%eax),%edx
  801098:	89 55 08             	mov    %edx,0x8(%ebp)
  80109b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80109e:	8a 12                	mov    (%edx),%dl
  8010a0:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a5:	8a 00                	mov    (%eax),%al
  8010a7:	84 c0                	test   %al,%al
  8010a9:	74 03                	je     8010ae <strncpy+0x31>
			src++;
  8010ab:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010ae:	ff 45 fc             	incl   -0x4(%ebp)
  8010b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010b4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010b7:	72 d9                	jb     801092 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010bc:	c9                   	leave  
  8010bd:	c3                   	ret    

008010be <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010be:	55                   	push   %ebp
  8010bf:	89 e5                	mov    %esp,%ebp
  8010c1:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010ca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010ce:	74 30                	je     801100 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010d0:	eb 16                	jmp    8010e8 <strlcpy+0x2a>
			*dst++ = *src++;
  8010d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d5:	8d 50 01             	lea    0x1(%eax),%edx
  8010d8:	89 55 08             	mov    %edx,0x8(%ebp)
  8010db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010de:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010e1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010e4:	8a 12                	mov    (%edx),%dl
  8010e6:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010e8:	ff 4d 10             	decl   0x10(%ebp)
  8010eb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010ef:	74 09                	je     8010fa <strlcpy+0x3c>
  8010f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f4:	8a 00                	mov    (%eax),%al
  8010f6:	84 c0                	test   %al,%al
  8010f8:	75 d8                	jne    8010d2 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8010fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fd:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801100:	8b 55 08             	mov    0x8(%ebp),%edx
  801103:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801106:	29 c2                	sub    %eax,%edx
  801108:	89 d0                	mov    %edx,%eax
}
  80110a:	c9                   	leave  
  80110b:	c3                   	ret    

0080110c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80110c:	55                   	push   %ebp
  80110d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80110f:	eb 06                	jmp    801117 <strcmp+0xb>
		p++, q++;
  801111:	ff 45 08             	incl   0x8(%ebp)
  801114:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801117:	8b 45 08             	mov    0x8(%ebp),%eax
  80111a:	8a 00                	mov    (%eax),%al
  80111c:	84 c0                	test   %al,%al
  80111e:	74 0e                	je     80112e <strcmp+0x22>
  801120:	8b 45 08             	mov    0x8(%ebp),%eax
  801123:	8a 10                	mov    (%eax),%dl
  801125:	8b 45 0c             	mov    0xc(%ebp),%eax
  801128:	8a 00                	mov    (%eax),%al
  80112a:	38 c2                	cmp    %al,%dl
  80112c:	74 e3                	je     801111 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80112e:	8b 45 08             	mov    0x8(%ebp),%eax
  801131:	8a 00                	mov    (%eax),%al
  801133:	0f b6 d0             	movzbl %al,%edx
  801136:	8b 45 0c             	mov    0xc(%ebp),%eax
  801139:	8a 00                	mov    (%eax),%al
  80113b:	0f b6 c0             	movzbl %al,%eax
  80113e:	29 c2                	sub    %eax,%edx
  801140:	89 d0                	mov    %edx,%eax
}
  801142:	5d                   	pop    %ebp
  801143:	c3                   	ret    

00801144 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801144:	55                   	push   %ebp
  801145:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801147:	eb 09                	jmp    801152 <strncmp+0xe>
		n--, p++, q++;
  801149:	ff 4d 10             	decl   0x10(%ebp)
  80114c:	ff 45 08             	incl   0x8(%ebp)
  80114f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801152:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801156:	74 17                	je     80116f <strncmp+0x2b>
  801158:	8b 45 08             	mov    0x8(%ebp),%eax
  80115b:	8a 00                	mov    (%eax),%al
  80115d:	84 c0                	test   %al,%al
  80115f:	74 0e                	je     80116f <strncmp+0x2b>
  801161:	8b 45 08             	mov    0x8(%ebp),%eax
  801164:	8a 10                	mov    (%eax),%dl
  801166:	8b 45 0c             	mov    0xc(%ebp),%eax
  801169:	8a 00                	mov    (%eax),%al
  80116b:	38 c2                	cmp    %al,%dl
  80116d:	74 da                	je     801149 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80116f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801173:	75 07                	jne    80117c <strncmp+0x38>
		return 0;
  801175:	b8 00 00 00 00       	mov    $0x0,%eax
  80117a:	eb 14                	jmp    801190 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80117c:	8b 45 08             	mov    0x8(%ebp),%eax
  80117f:	8a 00                	mov    (%eax),%al
  801181:	0f b6 d0             	movzbl %al,%edx
  801184:	8b 45 0c             	mov    0xc(%ebp),%eax
  801187:	8a 00                	mov    (%eax),%al
  801189:	0f b6 c0             	movzbl %al,%eax
  80118c:	29 c2                	sub    %eax,%edx
  80118e:	89 d0                	mov    %edx,%eax
}
  801190:	5d                   	pop    %ebp
  801191:	c3                   	ret    

00801192 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801192:	55                   	push   %ebp
  801193:	89 e5                	mov    %esp,%ebp
  801195:	83 ec 04             	sub    $0x4,%esp
  801198:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80119e:	eb 12                	jmp    8011b2 <strchr+0x20>
		if (*s == c)
  8011a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a3:	8a 00                	mov    (%eax),%al
  8011a5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011a8:	75 05                	jne    8011af <strchr+0x1d>
			return (char *) s;
  8011aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ad:	eb 11                	jmp    8011c0 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011af:	ff 45 08             	incl   0x8(%ebp)
  8011b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b5:	8a 00                	mov    (%eax),%al
  8011b7:	84 c0                	test   %al,%al
  8011b9:	75 e5                	jne    8011a0 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011bb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011c0:	c9                   	leave  
  8011c1:	c3                   	ret    

008011c2 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011c2:	55                   	push   %ebp
  8011c3:	89 e5                	mov    %esp,%ebp
  8011c5:	83 ec 04             	sub    $0x4,%esp
  8011c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011cb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011ce:	eb 0d                	jmp    8011dd <strfind+0x1b>
		if (*s == c)
  8011d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d3:	8a 00                	mov    (%eax),%al
  8011d5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011d8:	74 0e                	je     8011e8 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011da:	ff 45 08             	incl   0x8(%ebp)
  8011dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e0:	8a 00                	mov    (%eax),%al
  8011e2:	84 c0                	test   %al,%al
  8011e4:	75 ea                	jne    8011d0 <strfind+0xe>
  8011e6:	eb 01                	jmp    8011e9 <strfind+0x27>
		if (*s == c)
			break;
  8011e8:	90                   	nop
	return (char *) s;
  8011e9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011ec:	c9                   	leave  
  8011ed:	c3                   	ret    

008011ee <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8011ee:	55                   	push   %ebp
  8011ef:	89 e5                	mov    %esp,%ebp
  8011f1:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8011f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8011fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801200:	eb 0e                	jmp    801210 <memset+0x22>
		*p++ = c;
  801202:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801205:	8d 50 01             	lea    0x1(%eax),%edx
  801208:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80120b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80120e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801210:	ff 4d f8             	decl   -0x8(%ebp)
  801213:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801217:	79 e9                	jns    801202 <memset+0x14>
		*p++ = c;

	return v;
  801219:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80121c:	c9                   	leave  
  80121d:	c3                   	ret    

0080121e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80121e:	55                   	push   %ebp
  80121f:	89 e5                	mov    %esp,%ebp
  801221:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801224:	8b 45 0c             	mov    0xc(%ebp),%eax
  801227:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80122a:	8b 45 08             	mov    0x8(%ebp),%eax
  80122d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801230:	eb 16                	jmp    801248 <memcpy+0x2a>
		*d++ = *s++;
  801232:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801235:	8d 50 01             	lea    0x1(%eax),%edx
  801238:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80123b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80123e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801241:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801244:	8a 12                	mov    (%edx),%dl
  801246:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801248:	8b 45 10             	mov    0x10(%ebp),%eax
  80124b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80124e:	89 55 10             	mov    %edx,0x10(%ebp)
  801251:	85 c0                	test   %eax,%eax
  801253:	75 dd                	jne    801232 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801255:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801258:	c9                   	leave  
  801259:	c3                   	ret    

0080125a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80125a:	55                   	push   %ebp
  80125b:	89 e5                	mov    %esp,%ebp
  80125d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801260:	8b 45 0c             	mov    0xc(%ebp),%eax
  801263:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801266:	8b 45 08             	mov    0x8(%ebp),%eax
  801269:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80126c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80126f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801272:	73 50                	jae    8012c4 <memmove+0x6a>
  801274:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801277:	8b 45 10             	mov    0x10(%ebp),%eax
  80127a:	01 d0                	add    %edx,%eax
  80127c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80127f:	76 43                	jbe    8012c4 <memmove+0x6a>
		s += n;
  801281:	8b 45 10             	mov    0x10(%ebp),%eax
  801284:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801287:	8b 45 10             	mov    0x10(%ebp),%eax
  80128a:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80128d:	eb 10                	jmp    80129f <memmove+0x45>
			*--d = *--s;
  80128f:	ff 4d f8             	decl   -0x8(%ebp)
  801292:	ff 4d fc             	decl   -0x4(%ebp)
  801295:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801298:	8a 10                	mov    (%eax),%dl
  80129a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80129d:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80129f:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012a5:	89 55 10             	mov    %edx,0x10(%ebp)
  8012a8:	85 c0                	test   %eax,%eax
  8012aa:	75 e3                	jne    80128f <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012ac:	eb 23                	jmp    8012d1 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012b1:	8d 50 01             	lea    0x1(%eax),%edx
  8012b4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012b7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012ba:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012bd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012c0:	8a 12                	mov    (%edx),%dl
  8012c2:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012ca:	89 55 10             	mov    %edx,0x10(%ebp)
  8012cd:	85 c0                	test   %eax,%eax
  8012cf:	75 dd                	jne    8012ae <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012d1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012d4:	c9                   	leave  
  8012d5:	c3                   	ret    

008012d6 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012d6:	55                   	push   %ebp
  8012d7:	89 e5                	mov    %esp,%ebp
  8012d9:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012df:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e5:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012e8:	eb 2a                	jmp    801314 <memcmp+0x3e>
		if (*s1 != *s2)
  8012ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ed:	8a 10                	mov    (%eax),%dl
  8012ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012f2:	8a 00                	mov    (%eax),%al
  8012f4:	38 c2                	cmp    %al,%dl
  8012f6:	74 16                	je     80130e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8012f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012fb:	8a 00                	mov    (%eax),%al
  8012fd:	0f b6 d0             	movzbl %al,%edx
  801300:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801303:	8a 00                	mov    (%eax),%al
  801305:	0f b6 c0             	movzbl %al,%eax
  801308:	29 c2                	sub    %eax,%edx
  80130a:	89 d0                	mov    %edx,%eax
  80130c:	eb 18                	jmp    801326 <memcmp+0x50>
		s1++, s2++;
  80130e:	ff 45 fc             	incl   -0x4(%ebp)
  801311:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801314:	8b 45 10             	mov    0x10(%ebp),%eax
  801317:	8d 50 ff             	lea    -0x1(%eax),%edx
  80131a:	89 55 10             	mov    %edx,0x10(%ebp)
  80131d:	85 c0                	test   %eax,%eax
  80131f:	75 c9                	jne    8012ea <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801321:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801326:	c9                   	leave  
  801327:	c3                   	ret    

00801328 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801328:	55                   	push   %ebp
  801329:	89 e5                	mov    %esp,%ebp
  80132b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80132e:	8b 55 08             	mov    0x8(%ebp),%edx
  801331:	8b 45 10             	mov    0x10(%ebp),%eax
  801334:	01 d0                	add    %edx,%eax
  801336:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801339:	eb 15                	jmp    801350 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80133b:	8b 45 08             	mov    0x8(%ebp),%eax
  80133e:	8a 00                	mov    (%eax),%al
  801340:	0f b6 d0             	movzbl %al,%edx
  801343:	8b 45 0c             	mov    0xc(%ebp),%eax
  801346:	0f b6 c0             	movzbl %al,%eax
  801349:	39 c2                	cmp    %eax,%edx
  80134b:	74 0d                	je     80135a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80134d:	ff 45 08             	incl   0x8(%ebp)
  801350:	8b 45 08             	mov    0x8(%ebp),%eax
  801353:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801356:	72 e3                	jb     80133b <memfind+0x13>
  801358:	eb 01                	jmp    80135b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80135a:	90                   	nop
	return (void *) s;
  80135b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80135e:	c9                   	leave  
  80135f:	c3                   	ret    

00801360 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801360:	55                   	push   %ebp
  801361:	89 e5                	mov    %esp,%ebp
  801363:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801366:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80136d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801374:	eb 03                	jmp    801379 <strtol+0x19>
		s++;
  801376:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801379:	8b 45 08             	mov    0x8(%ebp),%eax
  80137c:	8a 00                	mov    (%eax),%al
  80137e:	3c 20                	cmp    $0x20,%al
  801380:	74 f4                	je     801376 <strtol+0x16>
  801382:	8b 45 08             	mov    0x8(%ebp),%eax
  801385:	8a 00                	mov    (%eax),%al
  801387:	3c 09                	cmp    $0x9,%al
  801389:	74 eb                	je     801376 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80138b:	8b 45 08             	mov    0x8(%ebp),%eax
  80138e:	8a 00                	mov    (%eax),%al
  801390:	3c 2b                	cmp    $0x2b,%al
  801392:	75 05                	jne    801399 <strtol+0x39>
		s++;
  801394:	ff 45 08             	incl   0x8(%ebp)
  801397:	eb 13                	jmp    8013ac <strtol+0x4c>
	else if (*s == '-')
  801399:	8b 45 08             	mov    0x8(%ebp),%eax
  80139c:	8a 00                	mov    (%eax),%al
  80139e:	3c 2d                	cmp    $0x2d,%al
  8013a0:	75 0a                	jne    8013ac <strtol+0x4c>
		s++, neg = 1;
  8013a2:	ff 45 08             	incl   0x8(%ebp)
  8013a5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013ac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013b0:	74 06                	je     8013b8 <strtol+0x58>
  8013b2:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013b6:	75 20                	jne    8013d8 <strtol+0x78>
  8013b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bb:	8a 00                	mov    (%eax),%al
  8013bd:	3c 30                	cmp    $0x30,%al
  8013bf:	75 17                	jne    8013d8 <strtol+0x78>
  8013c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c4:	40                   	inc    %eax
  8013c5:	8a 00                	mov    (%eax),%al
  8013c7:	3c 78                	cmp    $0x78,%al
  8013c9:	75 0d                	jne    8013d8 <strtol+0x78>
		s += 2, base = 16;
  8013cb:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013cf:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013d6:	eb 28                	jmp    801400 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013d8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013dc:	75 15                	jne    8013f3 <strtol+0x93>
  8013de:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e1:	8a 00                	mov    (%eax),%al
  8013e3:	3c 30                	cmp    $0x30,%al
  8013e5:	75 0c                	jne    8013f3 <strtol+0x93>
		s++, base = 8;
  8013e7:	ff 45 08             	incl   0x8(%ebp)
  8013ea:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8013f1:	eb 0d                	jmp    801400 <strtol+0xa0>
	else if (base == 0)
  8013f3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013f7:	75 07                	jne    801400 <strtol+0xa0>
		base = 10;
  8013f9:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801400:	8b 45 08             	mov    0x8(%ebp),%eax
  801403:	8a 00                	mov    (%eax),%al
  801405:	3c 2f                	cmp    $0x2f,%al
  801407:	7e 19                	jle    801422 <strtol+0xc2>
  801409:	8b 45 08             	mov    0x8(%ebp),%eax
  80140c:	8a 00                	mov    (%eax),%al
  80140e:	3c 39                	cmp    $0x39,%al
  801410:	7f 10                	jg     801422 <strtol+0xc2>
			dig = *s - '0';
  801412:	8b 45 08             	mov    0x8(%ebp),%eax
  801415:	8a 00                	mov    (%eax),%al
  801417:	0f be c0             	movsbl %al,%eax
  80141a:	83 e8 30             	sub    $0x30,%eax
  80141d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801420:	eb 42                	jmp    801464 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801422:	8b 45 08             	mov    0x8(%ebp),%eax
  801425:	8a 00                	mov    (%eax),%al
  801427:	3c 60                	cmp    $0x60,%al
  801429:	7e 19                	jle    801444 <strtol+0xe4>
  80142b:	8b 45 08             	mov    0x8(%ebp),%eax
  80142e:	8a 00                	mov    (%eax),%al
  801430:	3c 7a                	cmp    $0x7a,%al
  801432:	7f 10                	jg     801444 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801434:	8b 45 08             	mov    0x8(%ebp),%eax
  801437:	8a 00                	mov    (%eax),%al
  801439:	0f be c0             	movsbl %al,%eax
  80143c:	83 e8 57             	sub    $0x57,%eax
  80143f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801442:	eb 20                	jmp    801464 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801444:	8b 45 08             	mov    0x8(%ebp),%eax
  801447:	8a 00                	mov    (%eax),%al
  801449:	3c 40                	cmp    $0x40,%al
  80144b:	7e 39                	jle    801486 <strtol+0x126>
  80144d:	8b 45 08             	mov    0x8(%ebp),%eax
  801450:	8a 00                	mov    (%eax),%al
  801452:	3c 5a                	cmp    $0x5a,%al
  801454:	7f 30                	jg     801486 <strtol+0x126>
			dig = *s - 'A' + 10;
  801456:	8b 45 08             	mov    0x8(%ebp),%eax
  801459:	8a 00                	mov    (%eax),%al
  80145b:	0f be c0             	movsbl %al,%eax
  80145e:	83 e8 37             	sub    $0x37,%eax
  801461:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801464:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801467:	3b 45 10             	cmp    0x10(%ebp),%eax
  80146a:	7d 19                	jge    801485 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80146c:	ff 45 08             	incl   0x8(%ebp)
  80146f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801472:	0f af 45 10          	imul   0x10(%ebp),%eax
  801476:	89 c2                	mov    %eax,%edx
  801478:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80147b:	01 d0                	add    %edx,%eax
  80147d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801480:	e9 7b ff ff ff       	jmp    801400 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801485:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801486:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80148a:	74 08                	je     801494 <strtol+0x134>
		*endptr = (char *) s;
  80148c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148f:	8b 55 08             	mov    0x8(%ebp),%edx
  801492:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801494:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801498:	74 07                	je     8014a1 <strtol+0x141>
  80149a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80149d:	f7 d8                	neg    %eax
  80149f:	eb 03                	jmp    8014a4 <strtol+0x144>
  8014a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014a4:	c9                   	leave  
  8014a5:	c3                   	ret    

008014a6 <ltostr>:

void
ltostr(long value, char *str)
{
  8014a6:	55                   	push   %ebp
  8014a7:	89 e5                	mov    %esp,%ebp
  8014a9:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014b3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014ba:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014be:	79 13                	jns    8014d3 <ltostr+0x2d>
	{
		neg = 1;
  8014c0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ca:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014cd:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014d0:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d6:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014db:	99                   	cltd   
  8014dc:	f7 f9                	idiv   %ecx
  8014de:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014e4:	8d 50 01             	lea    0x1(%eax),%edx
  8014e7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014ea:	89 c2                	mov    %eax,%edx
  8014ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ef:	01 d0                	add    %edx,%eax
  8014f1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014f4:	83 c2 30             	add    $0x30,%edx
  8014f7:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8014f9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014fc:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801501:	f7 e9                	imul   %ecx
  801503:	c1 fa 02             	sar    $0x2,%edx
  801506:	89 c8                	mov    %ecx,%eax
  801508:	c1 f8 1f             	sar    $0x1f,%eax
  80150b:	29 c2                	sub    %eax,%edx
  80150d:	89 d0                	mov    %edx,%eax
  80150f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801512:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801515:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80151a:	f7 e9                	imul   %ecx
  80151c:	c1 fa 02             	sar    $0x2,%edx
  80151f:	89 c8                	mov    %ecx,%eax
  801521:	c1 f8 1f             	sar    $0x1f,%eax
  801524:	29 c2                	sub    %eax,%edx
  801526:	89 d0                	mov    %edx,%eax
  801528:	c1 e0 02             	shl    $0x2,%eax
  80152b:	01 d0                	add    %edx,%eax
  80152d:	01 c0                	add    %eax,%eax
  80152f:	29 c1                	sub    %eax,%ecx
  801531:	89 ca                	mov    %ecx,%edx
  801533:	85 d2                	test   %edx,%edx
  801535:	75 9c                	jne    8014d3 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801537:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80153e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801541:	48                   	dec    %eax
  801542:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801545:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801549:	74 3d                	je     801588 <ltostr+0xe2>
		start = 1 ;
  80154b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801552:	eb 34                	jmp    801588 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801554:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801557:	8b 45 0c             	mov    0xc(%ebp),%eax
  80155a:	01 d0                	add    %edx,%eax
  80155c:	8a 00                	mov    (%eax),%al
  80155e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801561:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801564:	8b 45 0c             	mov    0xc(%ebp),%eax
  801567:	01 c2                	add    %eax,%edx
  801569:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80156c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80156f:	01 c8                	add    %ecx,%eax
  801571:	8a 00                	mov    (%eax),%al
  801573:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801575:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801578:	8b 45 0c             	mov    0xc(%ebp),%eax
  80157b:	01 c2                	add    %eax,%edx
  80157d:	8a 45 eb             	mov    -0x15(%ebp),%al
  801580:	88 02                	mov    %al,(%edx)
		start++ ;
  801582:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801585:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801588:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80158b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80158e:	7c c4                	jl     801554 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801590:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801593:	8b 45 0c             	mov    0xc(%ebp),%eax
  801596:	01 d0                	add    %edx,%eax
  801598:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80159b:	90                   	nop
  80159c:	c9                   	leave  
  80159d:	c3                   	ret    

0080159e <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80159e:	55                   	push   %ebp
  80159f:	89 e5                	mov    %esp,%ebp
  8015a1:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015a4:	ff 75 08             	pushl  0x8(%ebp)
  8015a7:	e8 54 fa ff ff       	call   801000 <strlen>
  8015ac:	83 c4 04             	add    $0x4,%esp
  8015af:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015b2:	ff 75 0c             	pushl  0xc(%ebp)
  8015b5:	e8 46 fa ff ff       	call   801000 <strlen>
  8015ba:	83 c4 04             	add    $0x4,%esp
  8015bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015c0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015ce:	eb 17                	jmp    8015e7 <strcconcat+0x49>
		final[s] = str1[s] ;
  8015d0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d6:	01 c2                	add    %eax,%edx
  8015d8:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015db:	8b 45 08             	mov    0x8(%ebp),%eax
  8015de:	01 c8                	add    %ecx,%eax
  8015e0:	8a 00                	mov    (%eax),%al
  8015e2:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015e4:	ff 45 fc             	incl   -0x4(%ebp)
  8015e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ea:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015ed:	7c e1                	jl     8015d0 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8015ef:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8015f6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8015fd:	eb 1f                	jmp    80161e <strcconcat+0x80>
		final[s++] = str2[i] ;
  8015ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801602:	8d 50 01             	lea    0x1(%eax),%edx
  801605:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801608:	89 c2                	mov    %eax,%edx
  80160a:	8b 45 10             	mov    0x10(%ebp),%eax
  80160d:	01 c2                	add    %eax,%edx
  80160f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801612:	8b 45 0c             	mov    0xc(%ebp),%eax
  801615:	01 c8                	add    %ecx,%eax
  801617:	8a 00                	mov    (%eax),%al
  801619:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80161b:	ff 45 f8             	incl   -0x8(%ebp)
  80161e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801621:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801624:	7c d9                	jl     8015ff <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801626:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801629:	8b 45 10             	mov    0x10(%ebp),%eax
  80162c:	01 d0                	add    %edx,%eax
  80162e:	c6 00 00             	movb   $0x0,(%eax)
}
  801631:	90                   	nop
  801632:	c9                   	leave  
  801633:	c3                   	ret    

00801634 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801634:	55                   	push   %ebp
  801635:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801637:	8b 45 14             	mov    0x14(%ebp),%eax
  80163a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801640:	8b 45 14             	mov    0x14(%ebp),%eax
  801643:	8b 00                	mov    (%eax),%eax
  801645:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80164c:	8b 45 10             	mov    0x10(%ebp),%eax
  80164f:	01 d0                	add    %edx,%eax
  801651:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801657:	eb 0c                	jmp    801665 <strsplit+0x31>
			*string++ = 0;
  801659:	8b 45 08             	mov    0x8(%ebp),%eax
  80165c:	8d 50 01             	lea    0x1(%eax),%edx
  80165f:	89 55 08             	mov    %edx,0x8(%ebp)
  801662:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801665:	8b 45 08             	mov    0x8(%ebp),%eax
  801668:	8a 00                	mov    (%eax),%al
  80166a:	84 c0                	test   %al,%al
  80166c:	74 18                	je     801686 <strsplit+0x52>
  80166e:	8b 45 08             	mov    0x8(%ebp),%eax
  801671:	8a 00                	mov    (%eax),%al
  801673:	0f be c0             	movsbl %al,%eax
  801676:	50                   	push   %eax
  801677:	ff 75 0c             	pushl  0xc(%ebp)
  80167a:	e8 13 fb ff ff       	call   801192 <strchr>
  80167f:	83 c4 08             	add    $0x8,%esp
  801682:	85 c0                	test   %eax,%eax
  801684:	75 d3                	jne    801659 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801686:	8b 45 08             	mov    0x8(%ebp),%eax
  801689:	8a 00                	mov    (%eax),%al
  80168b:	84 c0                	test   %al,%al
  80168d:	74 5a                	je     8016e9 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80168f:	8b 45 14             	mov    0x14(%ebp),%eax
  801692:	8b 00                	mov    (%eax),%eax
  801694:	83 f8 0f             	cmp    $0xf,%eax
  801697:	75 07                	jne    8016a0 <strsplit+0x6c>
		{
			return 0;
  801699:	b8 00 00 00 00       	mov    $0x0,%eax
  80169e:	eb 66                	jmp    801706 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016a0:	8b 45 14             	mov    0x14(%ebp),%eax
  8016a3:	8b 00                	mov    (%eax),%eax
  8016a5:	8d 48 01             	lea    0x1(%eax),%ecx
  8016a8:	8b 55 14             	mov    0x14(%ebp),%edx
  8016ab:	89 0a                	mov    %ecx,(%edx)
  8016ad:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b7:	01 c2                	add    %eax,%edx
  8016b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bc:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016be:	eb 03                	jmp    8016c3 <strsplit+0x8f>
			string++;
  8016c0:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c6:	8a 00                	mov    (%eax),%al
  8016c8:	84 c0                	test   %al,%al
  8016ca:	74 8b                	je     801657 <strsplit+0x23>
  8016cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cf:	8a 00                	mov    (%eax),%al
  8016d1:	0f be c0             	movsbl %al,%eax
  8016d4:	50                   	push   %eax
  8016d5:	ff 75 0c             	pushl  0xc(%ebp)
  8016d8:	e8 b5 fa ff ff       	call   801192 <strchr>
  8016dd:	83 c4 08             	add    $0x8,%esp
  8016e0:	85 c0                	test   %eax,%eax
  8016e2:	74 dc                	je     8016c0 <strsplit+0x8c>
			string++;
	}
  8016e4:	e9 6e ff ff ff       	jmp    801657 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016e9:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016ea:	8b 45 14             	mov    0x14(%ebp),%eax
  8016ed:	8b 00                	mov    (%eax),%eax
  8016ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8016f9:	01 d0                	add    %edx,%eax
  8016fb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801701:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801706:	c9                   	leave  
  801707:	c3                   	ret    

00801708 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801708:	55                   	push   %ebp
  801709:	89 e5                	mov    %esp,%ebp
  80170b:	57                   	push   %edi
  80170c:	56                   	push   %esi
  80170d:	53                   	push   %ebx
  80170e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801711:	8b 45 08             	mov    0x8(%ebp),%eax
  801714:	8b 55 0c             	mov    0xc(%ebp),%edx
  801717:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80171a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80171d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801720:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801723:	cd 30                	int    $0x30
  801725:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801728:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80172b:	83 c4 10             	add    $0x10,%esp
  80172e:	5b                   	pop    %ebx
  80172f:	5e                   	pop    %esi
  801730:	5f                   	pop    %edi
  801731:	5d                   	pop    %ebp
  801732:	c3                   	ret    

00801733 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801733:	55                   	push   %ebp
  801734:	89 e5                	mov    %esp,%ebp
  801736:	83 ec 04             	sub    $0x4,%esp
  801739:	8b 45 10             	mov    0x10(%ebp),%eax
  80173c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80173f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801743:	8b 45 08             	mov    0x8(%ebp),%eax
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	52                   	push   %edx
  80174b:	ff 75 0c             	pushl  0xc(%ebp)
  80174e:	50                   	push   %eax
  80174f:	6a 00                	push   $0x0
  801751:	e8 b2 ff ff ff       	call   801708 <syscall>
  801756:	83 c4 18             	add    $0x18,%esp
}
  801759:	90                   	nop
  80175a:	c9                   	leave  
  80175b:	c3                   	ret    

0080175c <sys_cgetc>:

int
sys_cgetc(void)
{
  80175c:	55                   	push   %ebp
  80175d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 01                	push   $0x1
  80176b:	e8 98 ff ff ff       	call   801708 <syscall>
  801770:	83 c4 18             	add    $0x18,%esp
}
  801773:	c9                   	leave  
  801774:	c3                   	ret    

00801775 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801775:	55                   	push   %ebp
  801776:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801778:	8b 45 08             	mov    0x8(%ebp),%eax
  80177b:	6a 00                	push   $0x0
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	50                   	push   %eax
  801784:	6a 05                	push   $0x5
  801786:	e8 7d ff ff ff       	call   801708 <syscall>
  80178b:	83 c4 18             	add    $0x18,%esp
}
  80178e:	c9                   	leave  
  80178f:	c3                   	ret    

00801790 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801790:	55                   	push   %ebp
  801791:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	6a 02                	push   $0x2
  80179f:	e8 64 ff ff ff       	call   801708 <syscall>
  8017a4:	83 c4 18             	add    $0x18,%esp
}
  8017a7:	c9                   	leave  
  8017a8:	c3                   	ret    

008017a9 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017a9:	55                   	push   %ebp
  8017aa:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 03                	push   $0x3
  8017b8:	e8 4b ff ff ff       	call   801708 <syscall>
  8017bd:	83 c4 18             	add    $0x18,%esp
}
  8017c0:	c9                   	leave  
  8017c1:	c3                   	ret    

008017c2 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017c2:	55                   	push   %ebp
  8017c3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 04                	push   $0x4
  8017d1:	e8 32 ff ff ff       	call   801708 <syscall>
  8017d6:	83 c4 18             	add    $0x18,%esp
}
  8017d9:	c9                   	leave  
  8017da:	c3                   	ret    

008017db <sys_env_exit>:


void sys_env_exit(void)
{
  8017db:	55                   	push   %ebp
  8017dc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 06                	push   $0x6
  8017ea:	e8 19 ff ff ff       	call   801708 <syscall>
  8017ef:	83 c4 18             	add    $0x18,%esp
}
  8017f2:	90                   	nop
  8017f3:	c9                   	leave  
  8017f4:	c3                   	ret    

008017f5 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017f5:	55                   	push   %ebp
  8017f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fe:	6a 00                	push   $0x0
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	52                   	push   %edx
  801805:	50                   	push   %eax
  801806:	6a 07                	push   $0x7
  801808:	e8 fb fe ff ff       	call   801708 <syscall>
  80180d:	83 c4 18             	add    $0x18,%esp
}
  801810:	c9                   	leave  
  801811:	c3                   	ret    

00801812 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801812:	55                   	push   %ebp
  801813:	89 e5                	mov    %esp,%ebp
  801815:	56                   	push   %esi
  801816:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801817:	8b 75 18             	mov    0x18(%ebp),%esi
  80181a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80181d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801820:	8b 55 0c             	mov    0xc(%ebp),%edx
  801823:	8b 45 08             	mov    0x8(%ebp),%eax
  801826:	56                   	push   %esi
  801827:	53                   	push   %ebx
  801828:	51                   	push   %ecx
  801829:	52                   	push   %edx
  80182a:	50                   	push   %eax
  80182b:	6a 08                	push   $0x8
  80182d:	e8 d6 fe ff ff       	call   801708 <syscall>
  801832:	83 c4 18             	add    $0x18,%esp
}
  801835:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801838:	5b                   	pop    %ebx
  801839:	5e                   	pop    %esi
  80183a:	5d                   	pop    %ebp
  80183b:	c3                   	ret    

0080183c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80183c:	55                   	push   %ebp
  80183d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80183f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801842:	8b 45 08             	mov    0x8(%ebp),%eax
  801845:	6a 00                	push   $0x0
  801847:	6a 00                	push   $0x0
  801849:	6a 00                	push   $0x0
  80184b:	52                   	push   %edx
  80184c:	50                   	push   %eax
  80184d:	6a 09                	push   $0x9
  80184f:	e8 b4 fe ff ff       	call   801708 <syscall>
  801854:	83 c4 18             	add    $0x18,%esp
}
  801857:	c9                   	leave  
  801858:	c3                   	ret    

00801859 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801859:	55                   	push   %ebp
  80185a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	ff 75 0c             	pushl  0xc(%ebp)
  801865:	ff 75 08             	pushl  0x8(%ebp)
  801868:	6a 0a                	push   $0xa
  80186a:	e8 99 fe ff ff       	call   801708 <syscall>
  80186f:	83 c4 18             	add    $0x18,%esp
}
  801872:	c9                   	leave  
  801873:	c3                   	ret    

00801874 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801874:	55                   	push   %ebp
  801875:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	6a 0b                	push   $0xb
  801883:	e8 80 fe ff ff       	call   801708 <syscall>
  801888:	83 c4 18             	add    $0x18,%esp
}
  80188b:	c9                   	leave  
  80188c:	c3                   	ret    

0080188d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80188d:	55                   	push   %ebp
  80188e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	6a 00                	push   $0x0
  801896:	6a 00                	push   $0x0
  801898:	6a 00                	push   $0x0
  80189a:	6a 0c                	push   $0xc
  80189c:	e8 67 fe ff ff       	call   801708 <syscall>
  8018a1:	83 c4 18             	add    $0x18,%esp
}
  8018a4:	c9                   	leave  
  8018a5:	c3                   	ret    

008018a6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018a6:	55                   	push   %ebp
  8018a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 00                	push   $0x0
  8018b1:	6a 00                	push   $0x0
  8018b3:	6a 0d                	push   $0xd
  8018b5:	e8 4e fe ff ff       	call   801708 <syscall>
  8018ba:	83 c4 18             	add    $0x18,%esp
}
  8018bd:	c9                   	leave  
  8018be:	c3                   	ret    

008018bf <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018bf:	55                   	push   %ebp
  8018c0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018c2:	6a 00                	push   $0x0
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 00                	push   $0x0
  8018c8:	ff 75 0c             	pushl  0xc(%ebp)
  8018cb:	ff 75 08             	pushl  0x8(%ebp)
  8018ce:	6a 11                	push   $0x11
  8018d0:	e8 33 fe ff ff       	call   801708 <syscall>
  8018d5:	83 c4 18             	add    $0x18,%esp
	return;
  8018d8:	90                   	nop
}
  8018d9:	c9                   	leave  
  8018da:	c3                   	ret    

008018db <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018db:	55                   	push   %ebp
  8018dc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018de:	6a 00                	push   $0x0
  8018e0:	6a 00                	push   $0x0
  8018e2:	6a 00                	push   $0x0
  8018e4:	ff 75 0c             	pushl  0xc(%ebp)
  8018e7:	ff 75 08             	pushl  0x8(%ebp)
  8018ea:	6a 12                	push   $0x12
  8018ec:	e8 17 fe ff ff       	call   801708 <syscall>
  8018f1:	83 c4 18             	add    $0x18,%esp
	return ;
  8018f4:	90                   	nop
}
  8018f5:	c9                   	leave  
  8018f6:	c3                   	ret    

008018f7 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018f7:	55                   	push   %ebp
  8018f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 00                	push   $0x0
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 0e                	push   $0xe
  801906:	e8 fd fd ff ff       	call   801708 <syscall>
  80190b:	83 c4 18             	add    $0x18,%esp
}
  80190e:	c9                   	leave  
  80190f:	c3                   	ret    

00801910 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801910:	55                   	push   %ebp
  801911:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801913:	6a 00                	push   $0x0
  801915:	6a 00                	push   $0x0
  801917:	6a 00                	push   $0x0
  801919:	6a 00                	push   $0x0
  80191b:	ff 75 08             	pushl  0x8(%ebp)
  80191e:	6a 0f                	push   $0xf
  801920:	e8 e3 fd ff ff       	call   801708 <syscall>
  801925:	83 c4 18             	add    $0x18,%esp
}
  801928:	c9                   	leave  
  801929:	c3                   	ret    

0080192a <sys_scarce_memory>:

void sys_scarce_memory()
{
  80192a:	55                   	push   %ebp
  80192b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80192d:	6a 00                	push   $0x0
  80192f:	6a 00                	push   $0x0
  801931:	6a 00                	push   $0x0
  801933:	6a 00                	push   $0x0
  801935:	6a 00                	push   $0x0
  801937:	6a 10                	push   $0x10
  801939:	e8 ca fd ff ff       	call   801708 <syscall>
  80193e:	83 c4 18             	add    $0x18,%esp
}
  801941:	90                   	nop
  801942:	c9                   	leave  
  801943:	c3                   	ret    

00801944 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801944:	55                   	push   %ebp
  801945:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801947:	6a 00                	push   $0x0
  801949:	6a 00                	push   $0x0
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	6a 14                	push   $0x14
  801953:	e8 b0 fd ff ff       	call   801708 <syscall>
  801958:	83 c4 18             	add    $0x18,%esp
}
  80195b:	90                   	nop
  80195c:	c9                   	leave  
  80195d:	c3                   	ret    

0080195e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80195e:	55                   	push   %ebp
  80195f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801961:	6a 00                	push   $0x0
  801963:	6a 00                	push   $0x0
  801965:	6a 00                	push   $0x0
  801967:	6a 00                	push   $0x0
  801969:	6a 00                	push   $0x0
  80196b:	6a 15                	push   $0x15
  80196d:	e8 96 fd ff ff       	call   801708 <syscall>
  801972:	83 c4 18             	add    $0x18,%esp
}
  801975:	90                   	nop
  801976:	c9                   	leave  
  801977:	c3                   	ret    

00801978 <sys_cputc>:


void
sys_cputc(const char c)
{
  801978:	55                   	push   %ebp
  801979:	89 e5                	mov    %esp,%ebp
  80197b:	83 ec 04             	sub    $0x4,%esp
  80197e:	8b 45 08             	mov    0x8(%ebp),%eax
  801981:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801984:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801988:	6a 00                	push   $0x0
  80198a:	6a 00                	push   $0x0
  80198c:	6a 00                	push   $0x0
  80198e:	6a 00                	push   $0x0
  801990:	50                   	push   %eax
  801991:	6a 16                	push   $0x16
  801993:	e8 70 fd ff ff       	call   801708 <syscall>
  801998:	83 c4 18             	add    $0x18,%esp
}
  80199b:	90                   	nop
  80199c:	c9                   	leave  
  80199d:	c3                   	ret    

0080199e <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80199e:	55                   	push   %ebp
  80199f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	6a 00                	push   $0x0
  8019a9:	6a 00                	push   $0x0
  8019ab:	6a 17                	push   $0x17
  8019ad:	e8 56 fd ff ff       	call   801708 <syscall>
  8019b2:	83 c4 18             	add    $0x18,%esp
}
  8019b5:	90                   	nop
  8019b6:	c9                   	leave  
  8019b7:	c3                   	ret    

008019b8 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019b8:	55                   	push   %ebp
  8019b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	ff 75 0c             	pushl  0xc(%ebp)
  8019c7:	50                   	push   %eax
  8019c8:	6a 18                	push   $0x18
  8019ca:	e8 39 fd ff ff       	call   801708 <syscall>
  8019cf:	83 c4 18             	add    $0x18,%esp
}
  8019d2:	c9                   	leave  
  8019d3:	c3                   	ret    

008019d4 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019d4:	55                   	push   %ebp
  8019d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019da:	8b 45 08             	mov    0x8(%ebp),%eax
  8019dd:	6a 00                	push   $0x0
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 00                	push   $0x0
  8019e3:	52                   	push   %edx
  8019e4:	50                   	push   %eax
  8019e5:	6a 1b                	push   $0x1b
  8019e7:	e8 1c fd ff ff       	call   801708 <syscall>
  8019ec:	83 c4 18             	add    $0x18,%esp
}
  8019ef:	c9                   	leave  
  8019f0:	c3                   	ret    

008019f1 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019f1:	55                   	push   %ebp
  8019f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fa:	6a 00                	push   $0x0
  8019fc:	6a 00                	push   $0x0
  8019fe:	6a 00                	push   $0x0
  801a00:	52                   	push   %edx
  801a01:	50                   	push   %eax
  801a02:	6a 19                	push   $0x19
  801a04:	e8 ff fc ff ff       	call   801708 <syscall>
  801a09:	83 c4 18             	add    $0x18,%esp
}
  801a0c:	90                   	nop
  801a0d:	c9                   	leave  
  801a0e:	c3                   	ret    

00801a0f <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a0f:	55                   	push   %ebp
  801a10:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a12:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a15:	8b 45 08             	mov    0x8(%ebp),%eax
  801a18:	6a 00                	push   $0x0
  801a1a:	6a 00                	push   $0x0
  801a1c:	6a 00                	push   $0x0
  801a1e:	52                   	push   %edx
  801a1f:	50                   	push   %eax
  801a20:	6a 1a                	push   $0x1a
  801a22:	e8 e1 fc ff ff       	call   801708 <syscall>
  801a27:	83 c4 18             	add    $0x18,%esp
}
  801a2a:	90                   	nop
  801a2b:	c9                   	leave  
  801a2c:	c3                   	ret    

00801a2d <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a2d:	55                   	push   %ebp
  801a2e:	89 e5                	mov    %esp,%ebp
  801a30:	83 ec 04             	sub    $0x4,%esp
  801a33:	8b 45 10             	mov    0x10(%ebp),%eax
  801a36:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a39:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a3c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a40:	8b 45 08             	mov    0x8(%ebp),%eax
  801a43:	6a 00                	push   $0x0
  801a45:	51                   	push   %ecx
  801a46:	52                   	push   %edx
  801a47:	ff 75 0c             	pushl  0xc(%ebp)
  801a4a:	50                   	push   %eax
  801a4b:	6a 1c                	push   $0x1c
  801a4d:	e8 b6 fc ff ff       	call   801708 <syscall>
  801a52:	83 c4 18             	add    $0x18,%esp
}
  801a55:	c9                   	leave  
  801a56:	c3                   	ret    

00801a57 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a57:	55                   	push   %ebp
  801a58:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a5a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a5d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a60:	6a 00                	push   $0x0
  801a62:	6a 00                	push   $0x0
  801a64:	6a 00                	push   $0x0
  801a66:	52                   	push   %edx
  801a67:	50                   	push   %eax
  801a68:	6a 1d                	push   $0x1d
  801a6a:	e8 99 fc ff ff       	call   801708 <syscall>
  801a6f:	83 c4 18             	add    $0x18,%esp
}
  801a72:	c9                   	leave  
  801a73:	c3                   	ret    

00801a74 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a74:	55                   	push   %ebp
  801a75:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a77:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a7a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a80:	6a 00                	push   $0x0
  801a82:	6a 00                	push   $0x0
  801a84:	51                   	push   %ecx
  801a85:	52                   	push   %edx
  801a86:	50                   	push   %eax
  801a87:	6a 1e                	push   $0x1e
  801a89:	e8 7a fc ff ff       	call   801708 <syscall>
  801a8e:	83 c4 18             	add    $0x18,%esp
}
  801a91:	c9                   	leave  
  801a92:	c3                   	ret    

00801a93 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a93:	55                   	push   %ebp
  801a94:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a96:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a99:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9c:	6a 00                	push   $0x0
  801a9e:	6a 00                	push   $0x0
  801aa0:	6a 00                	push   $0x0
  801aa2:	52                   	push   %edx
  801aa3:	50                   	push   %eax
  801aa4:	6a 1f                	push   $0x1f
  801aa6:	e8 5d fc ff ff       	call   801708 <syscall>
  801aab:	83 c4 18             	add    $0x18,%esp
}
  801aae:	c9                   	leave  
  801aaf:	c3                   	ret    

00801ab0 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ab0:	55                   	push   %ebp
  801ab1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 00                	push   $0x0
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 00                	push   $0x0
  801abd:	6a 20                	push   $0x20
  801abf:	e8 44 fc ff ff       	call   801708 <syscall>
  801ac4:	83 c4 18             	add    $0x18,%esp
}
  801ac7:	c9                   	leave  
  801ac8:	c3                   	ret    

00801ac9 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801ac9:	55                   	push   %ebp
  801aca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801acc:	8b 45 08             	mov    0x8(%ebp),%eax
  801acf:	6a 00                	push   $0x0
  801ad1:	ff 75 14             	pushl  0x14(%ebp)
  801ad4:	ff 75 10             	pushl  0x10(%ebp)
  801ad7:	ff 75 0c             	pushl  0xc(%ebp)
  801ada:	50                   	push   %eax
  801adb:	6a 21                	push   $0x21
  801add:	e8 26 fc ff ff       	call   801708 <syscall>
  801ae2:	83 c4 18             	add    $0x18,%esp
}
  801ae5:	c9                   	leave  
  801ae6:	c3                   	ret    

00801ae7 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801ae7:	55                   	push   %ebp
  801ae8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801aea:	8b 45 08             	mov    0x8(%ebp),%eax
  801aed:	6a 00                	push   $0x0
  801aef:	6a 00                	push   $0x0
  801af1:	6a 00                	push   $0x0
  801af3:	6a 00                	push   $0x0
  801af5:	50                   	push   %eax
  801af6:	6a 22                	push   $0x22
  801af8:	e8 0b fc ff ff       	call   801708 <syscall>
  801afd:	83 c4 18             	add    $0x18,%esp
}
  801b00:	90                   	nop
  801b01:	c9                   	leave  
  801b02:	c3                   	ret    

00801b03 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b03:	55                   	push   %ebp
  801b04:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b06:	8b 45 08             	mov    0x8(%ebp),%eax
  801b09:	6a 00                	push   $0x0
  801b0b:	6a 00                	push   $0x0
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 00                	push   $0x0
  801b11:	50                   	push   %eax
  801b12:	6a 23                	push   $0x23
  801b14:	e8 ef fb ff ff       	call   801708 <syscall>
  801b19:	83 c4 18             	add    $0x18,%esp
}
  801b1c:	90                   	nop
  801b1d:	c9                   	leave  
  801b1e:	c3                   	ret    

00801b1f <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b1f:	55                   	push   %ebp
  801b20:	89 e5                	mov    %esp,%ebp
  801b22:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b25:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b28:	8d 50 04             	lea    0x4(%eax),%edx
  801b2b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	52                   	push   %edx
  801b35:	50                   	push   %eax
  801b36:	6a 24                	push   $0x24
  801b38:	e8 cb fb ff ff       	call   801708 <syscall>
  801b3d:	83 c4 18             	add    $0x18,%esp
	return result;
  801b40:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b43:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b46:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b49:	89 01                	mov    %eax,(%ecx)
  801b4b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b51:	c9                   	leave  
  801b52:	c2 04 00             	ret    $0x4

00801b55 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b55:	55                   	push   %ebp
  801b56:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b58:	6a 00                	push   $0x0
  801b5a:	6a 00                	push   $0x0
  801b5c:	ff 75 10             	pushl  0x10(%ebp)
  801b5f:	ff 75 0c             	pushl  0xc(%ebp)
  801b62:	ff 75 08             	pushl  0x8(%ebp)
  801b65:	6a 13                	push   $0x13
  801b67:	e8 9c fb ff ff       	call   801708 <syscall>
  801b6c:	83 c4 18             	add    $0x18,%esp
	return ;
  801b6f:	90                   	nop
}
  801b70:	c9                   	leave  
  801b71:	c3                   	ret    

00801b72 <sys_rcr2>:
uint32 sys_rcr2()
{
  801b72:	55                   	push   %ebp
  801b73:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	6a 00                	push   $0x0
  801b7f:	6a 25                	push   $0x25
  801b81:	e8 82 fb ff ff       	call   801708 <syscall>
  801b86:	83 c4 18             	add    $0x18,%esp
}
  801b89:	c9                   	leave  
  801b8a:	c3                   	ret    

00801b8b <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b8b:	55                   	push   %ebp
  801b8c:	89 e5                	mov    %esp,%ebp
  801b8e:	83 ec 04             	sub    $0x4,%esp
  801b91:	8b 45 08             	mov    0x8(%ebp),%eax
  801b94:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b97:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 00                	push   $0x0
  801ba1:	6a 00                	push   $0x0
  801ba3:	50                   	push   %eax
  801ba4:	6a 26                	push   $0x26
  801ba6:	e8 5d fb ff ff       	call   801708 <syscall>
  801bab:	83 c4 18             	add    $0x18,%esp
	return ;
  801bae:	90                   	nop
}
  801baf:	c9                   	leave  
  801bb0:	c3                   	ret    

00801bb1 <rsttst>:
void rsttst()
{
  801bb1:	55                   	push   %ebp
  801bb2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 00                	push   $0x0
  801bba:	6a 00                	push   $0x0
  801bbc:	6a 00                	push   $0x0
  801bbe:	6a 28                	push   $0x28
  801bc0:	e8 43 fb ff ff       	call   801708 <syscall>
  801bc5:	83 c4 18             	add    $0x18,%esp
	return ;
  801bc8:	90                   	nop
}
  801bc9:	c9                   	leave  
  801bca:	c3                   	ret    

00801bcb <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bcb:	55                   	push   %ebp
  801bcc:	89 e5                	mov    %esp,%ebp
  801bce:	83 ec 04             	sub    $0x4,%esp
  801bd1:	8b 45 14             	mov    0x14(%ebp),%eax
  801bd4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bd7:	8b 55 18             	mov    0x18(%ebp),%edx
  801bda:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bde:	52                   	push   %edx
  801bdf:	50                   	push   %eax
  801be0:	ff 75 10             	pushl  0x10(%ebp)
  801be3:	ff 75 0c             	pushl  0xc(%ebp)
  801be6:	ff 75 08             	pushl  0x8(%ebp)
  801be9:	6a 27                	push   $0x27
  801beb:	e8 18 fb ff ff       	call   801708 <syscall>
  801bf0:	83 c4 18             	add    $0x18,%esp
	return ;
  801bf3:	90                   	nop
}
  801bf4:	c9                   	leave  
  801bf5:	c3                   	ret    

00801bf6 <chktst>:
void chktst(uint32 n)
{
  801bf6:	55                   	push   %ebp
  801bf7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 00                	push   $0x0
  801bff:	6a 00                	push   $0x0
  801c01:	ff 75 08             	pushl  0x8(%ebp)
  801c04:	6a 29                	push   $0x29
  801c06:	e8 fd fa ff ff       	call   801708 <syscall>
  801c0b:	83 c4 18             	add    $0x18,%esp
	return ;
  801c0e:	90                   	nop
}
  801c0f:	c9                   	leave  
  801c10:	c3                   	ret    

00801c11 <inctst>:

void inctst()
{
  801c11:	55                   	push   %ebp
  801c12:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 00                	push   $0x0
  801c1e:	6a 2a                	push   $0x2a
  801c20:	e8 e3 fa ff ff       	call   801708 <syscall>
  801c25:	83 c4 18             	add    $0x18,%esp
	return ;
  801c28:	90                   	nop
}
  801c29:	c9                   	leave  
  801c2a:	c3                   	ret    

00801c2b <gettst>:
uint32 gettst()
{
  801c2b:	55                   	push   %ebp
  801c2c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	6a 2b                	push   $0x2b
  801c3a:	e8 c9 fa ff ff       	call   801708 <syscall>
  801c3f:	83 c4 18             	add    $0x18,%esp
}
  801c42:	c9                   	leave  
  801c43:	c3                   	ret    

00801c44 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c44:	55                   	push   %ebp
  801c45:	89 e5                	mov    %esp,%ebp
  801c47:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 00                	push   $0x0
  801c52:	6a 00                	push   $0x0
  801c54:	6a 2c                	push   $0x2c
  801c56:	e8 ad fa ff ff       	call   801708 <syscall>
  801c5b:	83 c4 18             	add    $0x18,%esp
  801c5e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c61:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c65:	75 07                	jne    801c6e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c67:	b8 01 00 00 00       	mov    $0x1,%eax
  801c6c:	eb 05                	jmp    801c73 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c6e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c73:	c9                   	leave  
  801c74:	c3                   	ret    

00801c75 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c75:	55                   	push   %ebp
  801c76:	89 e5                	mov    %esp,%ebp
  801c78:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c7b:	6a 00                	push   $0x0
  801c7d:	6a 00                	push   $0x0
  801c7f:	6a 00                	push   $0x0
  801c81:	6a 00                	push   $0x0
  801c83:	6a 00                	push   $0x0
  801c85:	6a 2c                	push   $0x2c
  801c87:	e8 7c fa ff ff       	call   801708 <syscall>
  801c8c:	83 c4 18             	add    $0x18,%esp
  801c8f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c92:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c96:	75 07                	jne    801c9f <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c98:	b8 01 00 00 00       	mov    $0x1,%eax
  801c9d:	eb 05                	jmp    801ca4 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c9f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ca4:	c9                   	leave  
  801ca5:	c3                   	ret    

00801ca6 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ca6:	55                   	push   %ebp
  801ca7:	89 e5                	mov    %esp,%ebp
  801ca9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cac:	6a 00                	push   $0x0
  801cae:	6a 00                	push   $0x0
  801cb0:	6a 00                	push   $0x0
  801cb2:	6a 00                	push   $0x0
  801cb4:	6a 00                	push   $0x0
  801cb6:	6a 2c                	push   $0x2c
  801cb8:	e8 4b fa ff ff       	call   801708 <syscall>
  801cbd:	83 c4 18             	add    $0x18,%esp
  801cc0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801cc3:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801cc7:	75 07                	jne    801cd0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801cc9:	b8 01 00 00 00       	mov    $0x1,%eax
  801cce:	eb 05                	jmp    801cd5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801cd0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cd5:	c9                   	leave  
  801cd6:	c3                   	ret    

00801cd7 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801cd7:	55                   	push   %ebp
  801cd8:	89 e5                	mov    %esp,%ebp
  801cda:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 2c                	push   $0x2c
  801ce9:	e8 1a fa ff ff       	call   801708 <syscall>
  801cee:	83 c4 18             	add    $0x18,%esp
  801cf1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801cf4:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801cf8:	75 07                	jne    801d01 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801cfa:	b8 01 00 00 00       	mov    $0x1,%eax
  801cff:	eb 05                	jmp    801d06 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d01:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d06:	c9                   	leave  
  801d07:	c3                   	ret    

00801d08 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d08:	55                   	push   %ebp
  801d09:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	ff 75 08             	pushl  0x8(%ebp)
  801d16:	6a 2d                	push   $0x2d
  801d18:	e8 eb f9 ff ff       	call   801708 <syscall>
  801d1d:	83 c4 18             	add    $0x18,%esp
	return ;
  801d20:	90                   	nop
}
  801d21:	c9                   	leave  
  801d22:	c3                   	ret    

00801d23 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d23:	55                   	push   %ebp
  801d24:	89 e5                	mov    %esp,%ebp
  801d26:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d27:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d2a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d2d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d30:	8b 45 08             	mov    0x8(%ebp),%eax
  801d33:	6a 00                	push   $0x0
  801d35:	53                   	push   %ebx
  801d36:	51                   	push   %ecx
  801d37:	52                   	push   %edx
  801d38:	50                   	push   %eax
  801d39:	6a 2e                	push   $0x2e
  801d3b:	e8 c8 f9 ff ff       	call   801708 <syscall>
  801d40:	83 c4 18             	add    $0x18,%esp
}
  801d43:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d46:	c9                   	leave  
  801d47:	c3                   	ret    

00801d48 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d48:	55                   	push   %ebp
  801d49:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d4b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d51:	6a 00                	push   $0x0
  801d53:	6a 00                	push   $0x0
  801d55:	6a 00                	push   $0x0
  801d57:	52                   	push   %edx
  801d58:	50                   	push   %eax
  801d59:	6a 2f                	push   $0x2f
  801d5b:	e8 a8 f9 ff ff       	call   801708 <syscall>
  801d60:	83 c4 18             	add    $0x18,%esp
}
  801d63:	c9                   	leave  
  801d64:	c3                   	ret    
  801d65:	66 90                	xchg   %ax,%ax
  801d67:	90                   	nop

00801d68 <__udivdi3>:
  801d68:	55                   	push   %ebp
  801d69:	57                   	push   %edi
  801d6a:	56                   	push   %esi
  801d6b:	53                   	push   %ebx
  801d6c:	83 ec 1c             	sub    $0x1c,%esp
  801d6f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d73:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d77:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d7b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d7f:	89 ca                	mov    %ecx,%edx
  801d81:	89 f8                	mov    %edi,%eax
  801d83:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d87:	85 f6                	test   %esi,%esi
  801d89:	75 2d                	jne    801db8 <__udivdi3+0x50>
  801d8b:	39 cf                	cmp    %ecx,%edi
  801d8d:	77 65                	ja     801df4 <__udivdi3+0x8c>
  801d8f:	89 fd                	mov    %edi,%ebp
  801d91:	85 ff                	test   %edi,%edi
  801d93:	75 0b                	jne    801da0 <__udivdi3+0x38>
  801d95:	b8 01 00 00 00       	mov    $0x1,%eax
  801d9a:	31 d2                	xor    %edx,%edx
  801d9c:	f7 f7                	div    %edi
  801d9e:	89 c5                	mov    %eax,%ebp
  801da0:	31 d2                	xor    %edx,%edx
  801da2:	89 c8                	mov    %ecx,%eax
  801da4:	f7 f5                	div    %ebp
  801da6:	89 c1                	mov    %eax,%ecx
  801da8:	89 d8                	mov    %ebx,%eax
  801daa:	f7 f5                	div    %ebp
  801dac:	89 cf                	mov    %ecx,%edi
  801dae:	89 fa                	mov    %edi,%edx
  801db0:	83 c4 1c             	add    $0x1c,%esp
  801db3:	5b                   	pop    %ebx
  801db4:	5e                   	pop    %esi
  801db5:	5f                   	pop    %edi
  801db6:	5d                   	pop    %ebp
  801db7:	c3                   	ret    
  801db8:	39 ce                	cmp    %ecx,%esi
  801dba:	77 28                	ja     801de4 <__udivdi3+0x7c>
  801dbc:	0f bd fe             	bsr    %esi,%edi
  801dbf:	83 f7 1f             	xor    $0x1f,%edi
  801dc2:	75 40                	jne    801e04 <__udivdi3+0x9c>
  801dc4:	39 ce                	cmp    %ecx,%esi
  801dc6:	72 0a                	jb     801dd2 <__udivdi3+0x6a>
  801dc8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801dcc:	0f 87 9e 00 00 00    	ja     801e70 <__udivdi3+0x108>
  801dd2:	b8 01 00 00 00       	mov    $0x1,%eax
  801dd7:	89 fa                	mov    %edi,%edx
  801dd9:	83 c4 1c             	add    $0x1c,%esp
  801ddc:	5b                   	pop    %ebx
  801ddd:	5e                   	pop    %esi
  801dde:	5f                   	pop    %edi
  801ddf:	5d                   	pop    %ebp
  801de0:	c3                   	ret    
  801de1:	8d 76 00             	lea    0x0(%esi),%esi
  801de4:	31 ff                	xor    %edi,%edi
  801de6:	31 c0                	xor    %eax,%eax
  801de8:	89 fa                	mov    %edi,%edx
  801dea:	83 c4 1c             	add    $0x1c,%esp
  801ded:	5b                   	pop    %ebx
  801dee:	5e                   	pop    %esi
  801def:	5f                   	pop    %edi
  801df0:	5d                   	pop    %ebp
  801df1:	c3                   	ret    
  801df2:	66 90                	xchg   %ax,%ax
  801df4:	89 d8                	mov    %ebx,%eax
  801df6:	f7 f7                	div    %edi
  801df8:	31 ff                	xor    %edi,%edi
  801dfa:	89 fa                	mov    %edi,%edx
  801dfc:	83 c4 1c             	add    $0x1c,%esp
  801dff:	5b                   	pop    %ebx
  801e00:	5e                   	pop    %esi
  801e01:	5f                   	pop    %edi
  801e02:	5d                   	pop    %ebp
  801e03:	c3                   	ret    
  801e04:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e09:	89 eb                	mov    %ebp,%ebx
  801e0b:	29 fb                	sub    %edi,%ebx
  801e0d:	89 f9                	mov    %edi,%ecx
  801e0f:	d3 e6                	shl    %cl,%esi
  801e11:	89 c5                	mov    %eax,%ebp
  801e13:	88 d9                	mov    %bl,%cl
  801e15:	d3 ed                	shr    %cl,%ebp
  801e17:	89 e9                	mov    %ebp,%ecx
  801e19:	09 f1                	or     %esi,%ecx
  801e1b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e1f:	89 f9                	mov    %edi,%ecx
  801e21:	d3 e0                	shl    %cl,%eax
  801e23:	89 c5                	mov    %eax,%ebp
  801e25:	89 d6                	mov    %edx,%esi
  801e27:	88 d9                	mov    %bl,%cl
  801e29:	d3 ee                	shr    %cl,%esi
  801e2b:	89 f9                	mov    %edi,%ecx
  801e2d:	d3 e2                	shl    %cl,%edx
  801e2f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e33:	88 d9                	mov    %bl,%cl
  801e35:	d3 e8                	shr    %cl,%eax
  801e37:	09 c2                	or     %eax,%edx
  801e39:	89 d0                	mov    %edx,%eax
  801e3b:	89 f2                	mov    %esi,%edx
  801e3d:	f7 74 24 0c          	divl   0xc(%esp)
  801e41:	89 d6                	mov    %edx,%esi
  801e43:	89 c3                	mov    %eax,%ebx
  801e45:	f7 e5                	mul    %ebp
  801e47:	39 d6                	cmp    %edx,%esi
  801e49:	72 19                	jb     801e64 <__udivdi3+0xfc>
  801e4b:	74 0b                	je     801e58 <__udivdi3+0xf0>
  801e4d:	89 d8                	mov    %ebx,%eax
  801e4f:	31 ff                	xor    %edi,%edi
  801e51:	e9 58 ff ff ff       	jmp    801dae <__udivdi3+0x46>
  801e56:	66 90                	xchg   %ax,%ax
  801e58:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e5c:	89 f9                	mov    %edi,%ecx
  801e5e:	d3 e2                	shl    %cl,%edx
  801e60:	39 c2                	cmp    %eax,%edx
  801e62:	73 e9                	jae    801e4d <__udivdi3+0xe5>
  801e64:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e67:	31 ff                	xor    %edi,%edi
  801e69:	e9 40 ff ff ff       	jmp    801dae <__udivdi3+0x46>
  801e6e:	66 90                	xchg   %ax,%ax
  801e70:	31 c0                	xor    %eax,%eax
  801e72:	e9 37 ff ff ff       	jmp    801dae <__udivdi3+0x46>
  801e77:	90                   	nop

00801e78 <__umoddi3>:
  801e78:	55                   	push   %ebp
  801e79:	57                   	push   %edi
  801e7a:	56                   	push   %esi
  801e7b:	53                   	push   %ebx
  801e7c:	83 ec 1c             	sub    $0x1c,%esp
  801e7f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e83:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e87:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e8b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e8f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e93:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e97:	89 f3                	mov    %esi,%ebx
  801e99:	89 fa                	mov    %edi,%edx
  801e9b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e9f:	89 34 24             	mov    %esi,(%esp)
  801ea2:	85 c0                	test   %eax,%eax
  801ea4:	75 1a                	jne    801ec0 <__umoddi3+0x48>
  801ea6:	39 f7                	cmp    %esi,%edi
  801ea8:	0f 86 a2 00 00 00    	jbe    801f50 <__umoddi3+0xd8>
  801eae:	89 c8                	mov    %ecx,%eax
  801eb0:	89 f2                	mov    %esi,%edx
  801eb2:	f7 f7                	div    %edi
  801eb4:	89 d0                	mov    %edx,%eax
  801eb6:	31 d2                	xor    %edx,%edx
  801eb8:	83 c4 1c             	add    $0x1c,%esp
  801ebb:	5b                   	pop    %ebx
  801ebc:	5e                   	pop    %esi
  801ebd:	5f                   	pop    %edi
  801ebe:	5d                   	pop    %ebp
  801ebf:	c3                   	ret    
  801ec0:	39 f0                	cmp    %esi,%eax
  801ec2:	0f 87 ac 00 00 00    	ja     801f74 <__umoddi3+0xfc>
  801ec8:	0f bd e8             	bsr    %eax,%ebp
  801ecb:	83 f5 1f             	xor    $0x1f,%ebp
  801ece:	0f 84 ac 00 00 00    	je     801f80 <__umoddi3+0x108>
  801ed4:	bf 20 00 00 00       	mov    $0x20,%edi
  801ed9:	29 ef                	sub    %ebp,%edi
  801edb:	89 fe                	mov    %edi,%esi
  801edd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ee1:	89 e9                	mov    %ebp,%ecx
  801ee3:	d3 e0                	shl    %cl,%eax
  801ee5:	89 d7                	mov    %edx,%edi
  801ee7:	89 f1                	mov    %esi,%ecx
  801ee9:	d3 ef                	shr    %cl,%edi
  801eeb:	09 c7                	or     %eax,%edi
  801eed:	89 e9                	mov    %ebp,%ecx
  801eef:	d3 e2                	shl    %cl,%edx
  801ef1:	89 14 24             	mov    %edx,(%esp)
  801ef4:	89 d8                	mov    %ebx,%eax
  801ef6:	d3 e0                	shl    %cl,%eax
  801ef8:	89 c2                	mov    %eax,%edx
  801efa:	8b 44 24 08          	mov    0x8(%esp),%eax
  801efe:	d3 e0                	shl    %cl,%eax
  801f00:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f04:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f08:	89 f1                	mov    %esi,%ecx
  801f0a:	d3 e8                	shr    %cl,%eax
  801f0c:	09 d0                	or     %edx,%eax
  801f0e:	d3 eb                	shr    %cl,%ebx
  801f10:	89 da                	mov    %ebx,%edx
  801f12:	f7 f7                	div    %edi
  801f14:	89 d3                	mov    %edx,%ebx
  801f16:	f7 24 24             	mull   (%esp)
  801f19:	89 c6                	mov    %eax,%esi
  801f1b:	89 d1                	mov    %edx,%ecx
  801f1d:	39 d3                	cmp    %edx,%ebx
  801f1f:	0f 82 87 00 00 00    	jb     801fac <__umoddi3+0x134>
  801f25:	0f 84 91 00 00 00    	je     801fbc <__umoddi3+0x144>
  801f2b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f2f:	29 f2                	sub    %esi,%edx
  801f31:	19 cb                	sbb    %ecx,%ebx
  801f33:	89 d8                	mov    %ebx,%eax
  801f35:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f39:	d3 e0                	shl    %cl,%eax
  801f3b:	89 e9                	mov    %ebp,%ecx
  801f3d:	d3 ea                	shr    %cl,%edx
  801f3f:	09 d0                	or     %edx,%eax
  801f41:	89 e9                	mov    %ebp,%ecx
  801f43:	d3 eb                	shr    %cl,%ebx
  801f45:	89 da                	mov    %ebx,%edx
  801f47:	83 c4 1c             	add    $0x1c,%esp
  801f4a:	5b                   	pop    %ebx
  801f4b:	5e                   	pop    %esi
  801f4c:	5f                   	pop    %edi
  801f4d:	5d                   	pop    %ebp
  801f4e:	c3                   	ret    
  801f4f:	90                   	nop
  801f50:	89 fd                	mov    %edi,%ebp
  801f52:	85 ff                	test   %edi,%edi
  801f54:	75 0b                	jne    801f61 <__umoddi3+0xe9>
  801f56:	b8 01 00 00 00       	mov    $0x1,%eax
  801f5b:	31 d2                	xor    %edx,%edx
  801f5d:	f7 f7                	div    %edi
  801f5f:	89 c5                	mov    %eax,%ebp
  801f61:	89 f0                	mov    %esi,%eax
  801f63:	31 d2                	xor    %edx,%edx
  801f65:	f7 f5                	div    %ebp
  801f67:	89 c8                	mov    %ecx,%eax
  801f69:	f7 f5                	div    %ebp
  801f6b:	89 d0                	mov    %edx,%eax
  801f6d:	e9 44 ff ff ff       	jmp    801eb6 <__umoddi3+0x3e>
  801f72:	66 90                	xchg   %ax,%ax
  801f74:	89 c8                	mov    %ecx,%eax
  801f76:	89 f2                	mov    %esi,%edx
  801f78:	83 c4 1c             	add    $0x1c,%esp
  801f7b:	5b                   	pop    %ebx
  801f7c:	5e                   	pop    %esi
  801f7d:	5f                   	pop    %edi
  801f7e:	5d                   	pop    %ebp
  801f7f:	c3                   	ret    
  801f80:	3b 04 24             	cmp    (%esp),%eax
  801f83:	72 06                	jb     801f8b <__umoddi3+0x113>
  801f85:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f89:	77 0f                	ja     801f9a <__umoddi3+0x122>
  801f8b:	89 f2                	mov    %esi,%edx
  801f8d:	29 f9                	sub    %edi,%ecx
  801f8f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f93:	89 14 24             	mov    %edx,(%esp)
  801f96:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f9a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f9e:	8b 14 24             	mov    (%esp),%edx
  801fa1:	83 c4 1c             	add    $0x1c,%esp
  801fa4:	5b                   	pop    %ebx
  801fa5:	5e                   	pop    %esi
  801fa6:	5f                   	pop    %edi
  801fa7:	5d                   	pop    %ebp
  801fa8:	c3                   	ret    
  801fa9:	8d 76 00             	lea    0x0(%esi),%esi
  801fac:	2b 04 24             	sub    (%esp),%eax
  801faf:	19 fa                	sbb    %edi,%edx
  801fb1:	89 d1                	mov    %edx,%ecx
  801fb3:	89 c6                	mov    %eax,%esi
  801fb5:	e9 71 ff ff ff       	jmp    801f2b <__umoddi3+0xb3>
  801fba:	66 90                	xchg   %ax,%ax
  801fbc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801fc0:	72 ea                	jb     801fac <__umoddi3+0x134>
  801fc2:	89 d9                	mov    %ebx,%ecx
  801fc4:	e9 62 ff ff ff       	jmp    801f2b <__umoddi3+0xb3>
