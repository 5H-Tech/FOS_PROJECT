
obj/user/tst_mod_5:     file format elf32-i386


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
  800031:	e8 20 05 00 00       	call   800556 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
char arr[PAGE_SIZE*12];
uint8* ptr = (uint8* )0x0801000 ;
uint8* ptr2 = (uint8* )0x0804000 ;

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
  80004b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80004e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800051:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800056:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005b:	74 14                	je     800071 <_main+0x39>
  80005d:	83 ec 04             	sub    $0x4,%esp
  800060:	68 a0 1f 80 00       	push   $0x801fa0
  800065:	6a 15                	push   $0x15
  800067:	68 e1 1f 80 00       	push   $0x801fe1
  80006c:	e8 2a 06 00 00       	call   80069b <_panic>
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
  800096:	68 a0 1f 80 00       	push   $0x801fa0
  80009b:	6a 16                	push   $0x16
  80009d:	68 e1 1f 80 00       	push   $0x801fe1
  8000a2:	e8 f4 05 00 00       	call   80069b <_panic>
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
  8000cc:	68 a0 1f 80 00       	push   $0x801fa0
  8000d1:	6a 17                	push   $0x17
  8000d3:	68 e1 1f 80 00       	push   $0x801fe1
  8000d8:	e8 be 05 00 00       	call   80069b <_panic>
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
  800102:	68 a0 1f 80 00       	push   $0x801fa0
  800107:	6a 18                	push   $0x18
  800109:	68 e1 1f 80 00       	push   $0x801fe1
  80010e:	e8 88 05 00 00       	call   80069b <_panic>
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
  800138:	68 a0 1f 80 00       	push   $0x801fa0
  80013d:	6a 19                	push   $0x19
  80013f:	68 e1 1f 80 00       	push   $0x801fe1
  800144:	e8 52 05 00 00       	call   80069b <_panic>
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
  80016e:	68 a0 1f 80 00       	push   $0x801fa0
  800173:	6a 1a                	push   $0x1a
  800175:	68 e1 1f 80 00       	push   $0x801fe1
  80017a:	e8 1c 05 00 00       	call   80069b <_panic>
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
  8001a4:	68 a0 1f 80 00       	push   $0x801fa0
  8001a9:	6a 1b                	push   $0x1b
  8001ab:	68 e1 1f 80 00       	push   $0x801fe1
  8001b0:	e8 e6 04 00 00       	call   80069b <_panic>
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
  8001da:	68 a0 1f 80 00       	push   $0x801fa0
  8001df:	6a 1c                	push   $0x1c
  8001e1:	68 e1 1f 80 00       	push   $0x801fe1
  8001e6:	e8 b0 04 00 00       	call   80069b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001f6:	83 e8 80             	sub    $0xffffff80,%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	89 45 cc             	mov    %eax,-0x34(%ebp)
  8001fe:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800201:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800206:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80020b:	74 14                	je     800221 <_main+0x1e9>
  80020d:	83 ec 04             	sub    $0x4,%esp
  800210:	68 a0 1f 80 00       	push   $0x801fa0
  800215:	6a 1d                	push   $0x1d
  800217:	68 e1 1f 80 00       	push   $0x801fe1
  80021c:	e8 7a 04 00 00       	call   80069b <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  800221:	a1 20 30 80 00       	mov    0x803020,%eax
  800226:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  80022c:	85 c0                	test   %eax,%eax
  80022e:	74 14                	je     800244 <_main+0x20c>
  800230:	83 ec 04             	sub    $0x4,%esp
  800233:	68 f4 1f 80 00       	push   $0x801ff4
  800238:	6a 1e                	push   $0x1e
  80023a:	68 e1 1f 80 00       	push   $0x801fe1
  80023f:	e8 57 04 00 00       	call   80069b <_panic>
	}


	int freePages = sys_calculate_free_frames();
  800244:	e8 ea 15 00 00       	call   801833 <sys_calculate_free_frames>
  800249:	89 45 c8             	mov    %eax,-0x38(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  80024c:	e8 65 16 00 00       	call   8018b6 <sys_pf_calculate_allocated_pages>
  800251:	89 45 c4             	mov    %eax,-0x3c(%ebp)

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1];
  800254:	a0 3f e0 80 00       	mov    0x80e03f,%al
  800259:	88 45 c3             	mov    %al,-0x3d(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1];
  80025c:	a0 3f f0 80 00       	mov    0x80f03f,%al
  800261:	88 45 c2             	mov    %al,-0x3e(%ebp)

	//Writing (Modified)
	int i;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800264:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80026b:	eb 37                	jmp    8002a4 <_main+0x26c>
	{
		arr[i] = -1 ;
  80026d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800270:	05 40 30 80 00       	add    $0x803040,%eax
  800275:	c6 00 ff             	movb   $0xff,(%eax)
		*ptr = *ptr2 ;
  800278:	a1 00 30 80 00       	mov    0x803000,%eax
  80027d:	8b 15 04 30 80 00    	mov    0x803004,%edx
  800283:	8a 12                	mov    (%edx),%dl
  800285:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  800287:	a1 00 30 80 00       	mov    0x803000,%eax
  80028c:	40                   	inc    %eax
  80028d:	a3 00 30 80 00       	mov    %eax,0x803000
  800292:	a1 04 30 80 00       	mov    0x803004,%eax
  800297:	40                   	inc    %eax
  800298:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1];
	char garbage2 = arr[PAGE_SIZE*12-1];

	//Writing (Modified)
	int i;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  80029d:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  8002a4:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  8002ab:	7e c0                	jle    80026d <_main+0x235>
	}

	//===================
	//cprintf("Checking PAGE FIFO algorithm... \n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0x801000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8002ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002b8:	8b 00                	mov    (%eax),%eax
  8002ba:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8002bd:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8002c0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002c5:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8002ca:	74 14                	je     8002e0 <_main+0x2a8>
  8002cc:	83 ec 04             	sub    $0x4,%esp
  8002cf:	68 3c 20 80 00       	push   $0x80203c
  8002d4:	6a 35                	push   $0x35
  8002d6:	68 e1 1f 80 00       	push   $0x801fe1
  8002db:	e8 bb 03 00 00       	call   80069b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8002e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e5:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002eb:	83 c0 10             	add    $0x10,%eax
  8002ee:	8b 00                	mov    (%eax),%eax
  8002f0:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8002f3:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8002f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002fb:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800300:	74 14                	je     800316 <_main+0x2de>
  800302:	83 ec 04             	sub    $0x4,%esp
  800305:	68 3c 20 80 00       	push   $0x80203c
  80030a:	6a 36                	push   $0x36
  80030c:	68 e1 1f 80 00       	push   $0x801fe1
  800311:	e8 85 03 00 00       	call   80069b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x809000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800316:	a1 20 30 80 00       	mov    0x803020,%eax
  80031b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800321:	83 c0 20             	add    $0x20,%eax
  800324:	8b 00                	mov    (%eax),%eax
  800326:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800329:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80032c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800331:	3d 00 90 80 00       	cmp    $0x809000,%eax
  800336:	74 14                	je     80034c <_main+0x314>
  800338:	83 ec 04             	sub    $0x4,%esp
  80033b:	68 3c 20 80 00       	push   $0x80203c
  800340:	6a 37                	push   $0x37
  800342:	68 e1 1f 80 00       	push   $0x801fe1
  800347:	e8 4f 03 00 00       	call   80069b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x803000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80034c:	a1 20 30 80 00       	mov    0x803020,%eax
  800351:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800357:	83 c0 30             	add    $0x30,%eax
  80035a:	8b 00                	mov    (%eax),%eax
  80035c:	89 45 b0             	mov    %eax,-0x50(%ebp)
  80035f:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800362:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800367:	3d 00 30 80 00       	cmp    $0x803000,%eax
  80036c:	74 14                	je     800382 <_main+0x34a>
  80036e:	83 ec 04             	sub    $0x4,%esp
  800371:	68 3c 20 80 00       	push   $0x80203c
  800376:	6a 38                	push   $0x38
  800378:	68 e1 1f 80 00       	push   $0x801fe1
  80037d:	e8 19 03 00 00       	call   80069b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x804000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800382:	a1 20 30 80 00       	mov    0x803020,%eax
  800387:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80038d:	83 c0 40             	add    $0x40,%eax
  800390:	8b 00                	mov    (%eax),%eax
  800392:	89 45 ac             	mov    %eax,-0x54(%ebp)
  800395:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800398:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80039d:	3d 00 40 80 00       	cmp    $0x804000,%eax
  8003a2:	74 14                	je     8003b8 <_main+0x380>
  8003a4:	83 ec 04             	sub    $0x4,%esp
  8003a7:	68 3c 20 80 00       	push   $0x80203c
  8003ac:	6a 39                	push   $0x39
  8003ae:	68 e1 1f 80 00       	push   $0x801fe1
  8003b3:	e8 e3 02 00 00       	call   80069b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x80a000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8003b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8003bd:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003c3:	83 c0 50             	add    $0x50,%eax
  8003c6:	8b 00                	mov    (%eax),%eax
  8003c8:	89 45 a8             	mov    %eax,-0x58(%ebp)
  8003cb:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003ce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003d3:	3d 00 a0 80 00       	cmp    $0x80a000,%eax
  8003d8:	74 14                	je     8003ee <_main+0x3b6>
  8003da:	83 ec 04             	sub    $0x4,%esp
  8003dd:	68 3c 20 80 00       	push   $0x80203c
  8003e2:	6a 3a                	push   $0x3a
  8003e4:	68 e1 1f 80 00       	push   $0x801fe1
  8003e9:	e8 ad 02 00 00       	call   80069b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x80b000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8003ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003f9:	83 c0 60             	add    $0x60,%eax
  8003fc:	8b 00                	mov    (%eax),%eax
  8003fe:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  800401:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800404:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800409:	3d 00 b0 80 00       	cmp    $0x80b000,%eax
  80040e:	74 14                	je     800424 <_main+0x3ec>
  800410:	83 ec 04             	sub    $0x4,%esp
  800413:	68 3c 20 80 00       	push   $0x80203c
  800418:	6a 3b                	push   $0x3b
  80041a:	68 e1 1f 80 00       	push   $0x801fe1
  80041f:	e8 77 02 00 00       	call   80069b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x80c000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800424:	a1 20 30 80 00       	mov    0x803020,%eax
  800429:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80042f:	83 c0 70             	add    $0x70,%eax
  800432:	8b 00                	mov    (%eax),%eax
  800434:	89 45 a0             	mov    %eax,-0x60(%ebp)
  800437:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80043a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80043f:	3d 00 c0 80 00       	cmp    $0x80c000,%eax
  800444:	74 14                	je     80045a <_main+0x422>
  800446:	83 ec 04             	sub    $0x4,%esp
  800449:	68 3c 20 80 00       	push   $0x80203c
  80044e:	6a 3c                	push   $0x3c
  800450:	68 e1 1f 80 00       	push   $0x801fe1
  800455:	e8 41 02 00 00       	call   80069b <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x800000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80045a:	a1 20 30 80 00       	mov    0x803020,%eax
  80045f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800465:	83 e8 80             	sub    $0xffffff80,%eax
  800468:	8b 00                	mov    (%eax),%eax
  80046a:	89 45 9c             	mov    %eax,-0x64(%ebp)
  80046d:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800470:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800475:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80047a:	74 14                	je     800490 <_main+0x458>
  80047c:	83 ec 04             	sub    $0x4,%esp
  80047f:	68 3c 20 80 00       	push   $0x80203c
  800484:	6a 3d                	push   $0x3d
  800486:	68 e1 1f 80 00       	push   $0x801fe1
  80048b:	e8 0b 02 00 00       	call   80069b <_panic>

		if(myEnv->page_last_WS_index != 2) panic("wrong PAGE WS pointer location");
  800490:	a1 20 30 80 00       	mov    0x803020,%eax
  800495:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  80049b:	83 f8 02             	cmp    $0x2,%eax
  80049e:	74 14                	je     8004b4 <_main+0x47c>
  8004a0:	83 ec 04             	sub    $0x4,%esp
  8004a3:	68 88 20 80 00       	push   $0x802088
  8004a8:	6a 3f                	push   $0x3f
  8004aa:	68 e1 1f 80 00       	push   $0x801fe1
  8004af:	e8 e7 01 00 00       	call   80069b <_panic>
	}

	//Checking the written data
	{
		int i;
		ptr = (uint8* )0x0801000 ;
  8004b4:	c7 05 00 30 80 00 00 	movl   $0x801000,0x803000
  8004bb:	10 80 00 
		ptr2 = (uint8* )0x0804000 ;
  8004be:	c7 05 04 30 80 00 00 	movl   $0x804000,0x803004
  8004c5:	40 80 00 

		for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8004c8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8004cf:	eb 69                	jmp    80053a <_main+0x502>
		{
			assert (arr[i] == -1);
  8004d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004d4:	05 40 30 80 00       	add    $0x803040,%eax
  8004d9:	8a 00                	mov    (%eax),%al
  8004db:	3c ff                	cmp    $0xff,%al
  8004dd:	74 16                	je     8004f5 <_main+0x4bd>
  8004df:	68 a7 20 80 00       	push   $0x8020a7
  8004e4:	68 b4 20 80 00       	push   $0x8020b4
  8004e9:	6a 4b                	push   $0x4b
  8004eb:	68 e1 1f 80 00       	push   $0x801fe1
  8004f0:	e8 a6 01 00 00       	call   80069b <_panic>
			assert (*ptr == *ptr2) ;
  8004f5:	a1 00 30 80 00       	mov    0x803000,%eax
  8004fa:	8a 10                	mov    (%eax),%dl
  8004fc:	a1 04 30 80 00       	mov    0x803004,%eax
  800501:	8a 00                	mov    (%eax),%al
  800503:	38 c2                	cmp    %al,%dl
  800505:	74 16                	je     80051d <_main+0x4e5>
  800507:	68 c9 20 80 00       	push   $0x8020c9
  80050c:	68 b4 20 80 00       	push   $0x8020b4
  800511:	6a 4c                	push   $0x4c
  800513:	68 e1 1f 80 00       	push   $0x801fe1
  800518:	e8 7e 01 00 00       	call   80069b <_panic>
			ptr++ ; ptr2++ ;
  80051d:	a1 00 30 80 00       	mov    0x803000,%eax
  800522:	40                   	inc    %eax
  800523:	a3 00 30 80 00       	mov    %eax,0x803000
  800528:	a1 04 30 80 00       	mov    0x803004,%eax
  80052d:	40                   	inc    %eax
  80052e:	a3 04 30 80 00       	mov    %eax,0x803004
	{
		int i;
		ptr = (uint8* )0x0801000 ;
		ptr2 = (uint8* )0x0804000 ;

		for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800533:	81 45 f0 00 08 00 00 	addl   $0x800,-0x10(%ebp)
  80053a:	81 7d f0 ff 9f 00 00 	cmpl   $0x9fff,-0x10(%ebp)
  800541:	7e 8e                	jle    8004d1 <_main+0x499>
			assert (arr[i] == -1);
			assert (*ptr == *ptr2) ;
			ptr++ ; ptr2++ ;
		}
	}
	cprintf("Congratulations!! your modification is run successfully.\n");
  800543:	83 ec 0c             	sub    $0xc,%esp
  800546:	68 d8 20 80 00       	push   $0x8020d8
  80054b:	e8 ed 03 00 00       	call   80093d <cprintf>
  800550:	83 c4 10             	add    $0x10,%esp
	return;
  800553:	90                   	nop
}
  800554:	c9                   	leave  
  800555:	c3                   	ret    

00800556 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800556:	55                   	push   %ebp
  800557:	89 e5                	mov    %esp,%ebp
  800559:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80055c:	e8 07 12 00 00       	call   801768 <sys_getenvindex>
  800561:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800564:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800567:	89 d0                	mov    %edx,%eax
  800569:	c1 e0 03             	shl    $0x3,%eax
  80056c:	01 d0                	add    %edx,%eax
  80056e:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800575:	01 c8                	add    %ecx,%eax
  800577:	01 c0                	add    %eax,%eax
  800579:	01 d0                	add    %edx,%eax
  80057b:	01 c0                	add    %eax,%eax
  80057d:	01 d0                	add    %edx,%eax
  80057f:	89 c2                	mov    %eax,%edx
  800581:	c1 e2 05             	shl    $0x5,%edx
  800584:	29 c2                	sub    %eax,%edx
  800586:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80058d:	89 c2                	mov    %eax,%edx
  80058f:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800595:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80059a:	a1 20 30 80 00       	mov    0x803020,%eax
  80059f:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8005a5:	84 c0                	test   %al,%al
  8005a7:	74 0f                	je     8005b8 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8005a9:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ae:	05 40 3c 01 00       	add    $0x13c40,%eax
  8005b3:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8005b8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8005bc:	7e 0a                	jle    8005c8 <libmain+0x72>
		binaryname = argv[0];
  8005be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005c1:	8b 00                	mov    (%eax),%eax
  8005c3:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  8005c8:	83 ec 08             	sub    $0x8,%esp
  8005cb:	ff 75 0c             	pushl  0xc(%ebp)
  8005ce:	ff 75 08             	pushl  0x8(%ebp)
  8005d1:	e8 62 fa ff ff       	call   800038 <_main>
  8005d6:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8005d9:	e8 25 13 00 00       	call   801903 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8005de:	83 ec 0c             	sub    $0xc,%esp
  8005e1:	68 2c 21 80 00       	push   $0x80212c
  8005e6:	e8 52 03 00 00       	call   80093d <cprintf>
  8005eb:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8005ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8005f3:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8005f9:	a1 20 30 80 00       	mov    0x803020,%eax
  8005fe:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800604:	83 ec 04             	sub    $0x4,%esp
  800607:	52                   	push   %edx
  800608:	50                   	push   %eax
  800609:	68 54 21 80 00       	push   $0x802154
  80060e:	e8 2a 03 00 00       	call   80093d <cprintf>
  800613:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800616:	a1 20 30 80 00       	mov    0x803020,%eax
  80061b:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800621:	a1 20 30 80 00       	mov    0x803020,%eax
  800626:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80062c:	83 ec 04             	sub    $0x4,%esp
  80062f:	52                   	push   %edx
  800630:	50                   	push   %eax
  800631:	68 7c 21 80 00       	push   $0x80217c
  800636:	e8 02 03 00 00       	call   80093d <cprintf>
  80063b:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80063e:	a1 20 30 80 00       	mov    0x803020,%eax
  800643:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800649:	83 ec 08             	sub    $0x8,%esp
  80064c:	50                   	push   %eax
  80064d:	68 bd 21 80 00       	push   $0x8021bd
  800652:	e8 e6 02 00 00       	call   80093d <cprintf>
  800657:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80065a:	83 ec 0c             	sub    $0xc,%esp
  80065d:	68 2c 21 80 00       	push   $0x80212c
  800662:	e8 d6 02 00 00       	call   80093d <cprintf>
  800667:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80066a:	e8 ae 12 00 00       	call   80191d <sys_enable_interrupt>

	// exit gracefully
	exit();
  80066f:	e8 19 00 00 00       	call   80068d <exit>
}
  800674:	90                   	nop
  800675:	c9                   	leave  
  800676:	c3                   	ret    

00800677 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800677:	55                   	push   %ebp
  800678:	89 e5                	mov    %esp,%ebp
  80067a:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80067d:	83 ec 0c             	sub    $0xc,%esp
  800680:	6a 00                	push   $0x0
  800682:	e8 ad 10 00 00       	call   801734 <sys_env_destroy>
  800687:	83 c4 10             	add    $0x10,%esp
}
  80068a:	90                   	nop
  80068b:	c9                   	leave  
  80068c:	c3                   	ret    

0080068d <exit>:

void
exit(void)
{
  80068d:	55                   	push   %ebp
  80068e:	89 e5                	mov    %esp,%ebp
  800690:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800693:	e8 02 11 00 00       	call   80179a <sys_env_exit>
}
  800698:	90                   	nop
  800699:	c9                   	leave  
  80069a:	c3                   	ret    

0080069b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80069b:	55                   	push   %ebp
  80069c:	89 e5                	mov    %esp,%ebp
  80069e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006a1:	8d 45 10             	lea    0x10(%ebp),%eax
  8006a4:	83 c0 04             	add    $0x4,%eax
  8006a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006aa:	a1 18 f1 80 00       	mov    0x80f118,%eax
  8006af:	85 c0                	test   %eax,%eax
  8006b1:	74 16                	je     8006c9 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006b3:	a1 18 f1 80 00       	mov    0x80f118,%eax
  8006b8:	83 ec 08             	sub    $0x8,%esp
  8006bb:	50                   	push   %eax
  8006bc:	68 d4 21 80 00       	push   $0x8021d4
  8006c1:	e8 77 02 00 00       	call   80093d <cprintf>
  8006c6:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8006c9:	a1 08 30 80 00       	mov    0x803008,%eax
  8006ce:	ff 75 0c             	pushl  0xc(%ebp)
  8006d1:	ff 75 08             	pushl  0x8(%ebp)
  8006d4:	50                   	push   %eax
  8006d5:	68 d9 21 80 00       	push   $0x8021d9
  8006da:	e8 5e 02 00 00       	call   80093d <cprintf>
  8006df:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8006e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8006e5:	83 ec 08             	sub    $0x8,%esp
  8006e8:	ff 75 f4             	pushl  -0xc(%ebp)
  8006eb:	50                   	push   %eax
  8006ec:	e8 e1 01 00 00       	call   8008d2 <vcprintf>
  8006f1:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8006f4:	83 ec 08             	sub    $0x8,%esp
  8006f7:	6a 00                	push   $0x0
  8006f9:	68 f5 21 80 00       	push   $0x8021f5
  8006fe:	e8 cf 01 00 00       	call   8008d2 <vcprintf>
  800703:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800706:	e8 82 ff ff ff       	call   80068d <exit>

	// should not return here
	while (1) ;
  80070b:	eb fe                	jmp    80070b <_panic+0x70>

0080070d <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80070d:	55                   	push   %ebp
  80070e:	89 e5                	mov    %esp,%ebp
  800710:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800713:	a1 20 30 80 00       	mov    0x803020,%eax
  800718:	8b 50 74             	mov    0x74(%eax),%edx
  80071b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80071e:	39 c2                	cmp    %eax,%edx
  800720:	74 14                	je     800736 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800722:	83 ec 04             	sub    $0x4,%esp
  800725:	68 f8 21 80 00       	push   $0x8021f8
  80072a:	6a 26                	push   $0x26
  80072c:	68 44 22 80 00       	push   $0x802244
  800731:	e8 65 ff ff ff       	call   80069b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800736:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80073d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800744:	e9 b6 00 00 00       	jmp    8007ff <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800749:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80074c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800753:	8b 45 08             	mov    0x8(%ebp),%eax
  800756:	01 d0                	add    %edx,%eax
  800758:	8b 00                	mov    (%eax),%eax
  80075a:	85 c0                	test   %eax,%eax
  80075c:	75 08                	jne    800766 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80075e:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800761:	e9 96 00 00 00       	jmp    8007fc <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800766:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80076d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800774:	eb 5d                	jmp    8007d3 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800776:	a1 20 30 80 00       	mov    0x803020,%eax
  80077b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800781:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800784:	c1 e2 04             	shl    $0x4,%edx
  800787:	01 d0                	add    %edx,%eax
  800789:	8a 40 04             	mov    0x4(%eax),%al
  80078c:	84 c0                	test   %al,%al
  80078e:	75 40                	jne    8007d0 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800790:	a1 20 30 80 00       	mov    0x803020,%eax
  800795:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80079b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80079e:	c1 e2 04             	shl    $0x4,%edx
  8007a1:	01 d0                	add    %edx,%eax
  8007a3:	8b 00                	mov    (%eax),%eax
  8007a5:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007a8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007ab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007b0:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007b5:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8007bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bf:	01 c8                	add    %ecx,%eax
  8007c1:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007c3:	39 c2                	cmp    %eax,%edx
  8007c5:	75 09                	jne    8007d0 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8007c7:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8007ce:	eb 12                	jmp    8007e2 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007d0:	ff 45 e8             	incl   -0x18(%ebp)
  8007d3:	a1 20 30 80 00       	mov    0x803020,%eax
  8007d8:	8b 50 74             	mov    0x74(%eax),%edx
  8007db:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8007de:	39 c2                	cmp    %eax,%edx
  8007e0:	77 94                	ja     800776 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8007e2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8007e6:	75 14                	jne    8007fc <CheckWSWithoutLastIndex+0xef>
			panic(
  8007e8:	83 ec 04             	sub    $0x4,%esp
  8007eb:	68 50 22 80 00       	push   $0x802250
  8007f0:	6a 3a                	push   $0x3a
  8007f2:	68 44 22 80 00       	push   $0x802244
  8007f7:	e8 9f fe ff ff       	call   80069b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8007fc:	ff 45 f0             	incl   -0x10(%ebp)
  8007ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800802:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800805:	0f 8c 3e ff ff ff    	jl     800749 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80080b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800812:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800819:	eb 20                	jmp    80083b <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80081b:	a1 20 30 80 00       	mov    0x803020,%eax
  800820:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800826:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800829:	c1 e2 04             	shl    $0x4,%edx
  80082c:	01 d0                	add    %edx,%eax
  80082e:	8a 40 04             	mov    0x4(%eax),%al
  800831:	3c 01                	cmp    $0x1,%al
  800833:	75 03                	jne    800838 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800835:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800838:	ff 45 e0             	incl   -0x20(%ebp)
  80083b:	a1 20 30 80 00       	mov    0x803020,%eax
  800840:	8b 50 74             	mov    0x74(%eax),%edx
  800843:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800846:	39 c2                	cmp    %eax,%edx
  800848:	77 d1                	ja     80081b <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80084a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80084d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800850:	74 14                	je     800866 <CheckWSWithoutLastIndex+0x159>
		panic(
  800852:	83 ec 04             	sub    $0x4,%esp
  800855:	68 a4 22 80 00       	push   $0x8022a4
  80085a:	6a 44                	push   $0x44
  80085c:	68 44 22 80 00       	push   $0x802244
  800861:	e8 35 fe ff ff       	call   80069b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800866:	90                   	nop
  800867:	c9                   	leave  
  800868:	c3                   	ret    

00800869 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800869:	55                   	push   %ebp
  80086a:	89 e5                	mov    %esp,%ebp
  80086c:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80086f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800872:	8b 00                	mov    (%eax),%eax
  800874:	8d 48 01             	lea    0x1(%eax),%ecx
  800877:	8b 55 0c             	mov    0xc(%ebp),%edx
  80087a:	89 0a                	mov    %ecx,(%edx)
  80087c:	8b 55 08             	mov    0x8(%ebp),%edx
  80087f:	88 d1                	mov    %dl,%cl
  800881:	8b 55 0c             	mov    0xc(%ebp),%edx
  800884:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800888:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088b:	8b 00                	mov    (%eax),%eax
  80088d:	3d ff 00 00 00       	cmp    $0xff,%eax
  800892:	75 2c                	jne    8008c0 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800894:	a0 24 30 80 00       	mov    0x803024,%al
  800899:	0f b6 c0             	movzbl %al,%eax
  80089c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80089f:	8b 12                	mov    (%edx),%edx
  8008a1:	89 d1                	mov    %edx,%ecx
  8008a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008a6:	83 c2 08             	add    $0x8,%edx
  8008a9:	83 ec 04             	sub    $0x4,%esp
  8008ac:	50                   	push   %eax
  8008ad:	51                   	push   %ecx
  8008ae:	52                   	push   %edx
  8008af:	e8 3e 0e 00 00       	call   8016f2 <sys_cputs>
  8008b4:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8008b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ba:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8008c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c3:	8b 40 04             	mov    0x4(%eax),%eax
  8008c6:	8d 50 01             	lea    0x1(%eax),%edx
  8008c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008cc:	89 50 04             	mov    %edx,0x4(%eax)
}
  8008cf:	90                   	nop
  8008d0:	c9                   	leave  
  8008d1:	c3                   	ret    

008008d2 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8008d2:	55                   	push   %ebp
  8008d3:	89 e5                	mov    %esp,%ebp
  8008d5:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8008db:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8008e2:	00 00 00 
	b.cnt = 0;
  8008e5:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8008ec:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8008ef:	ff 75 0c             	pushl  0xc(%ebp)
  8008f2:	ff 75 08             	pushl  0x8(%ebp)
  8008f5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8008fb:	50                   	push   %eax
  8008fc:	68 69 08 80 00       	push   $0x800869
  800901:	e8 11 02 00 00       	call   800b17 <vprintfmt>
  800906:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800909:	a0 24 30 80 00       	mov    0x803024,%al
  80090e:	0f b6 c0             	movzbl %al,%eax
  800911:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800917:	83 ec 04             	sub    $0x4,%esp
  80091a:	50                   	push   %eax
  80091b:	52                   	push   %edx
  80091c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800922:	83 c0 08             	add    $0x8,%eax
  800925:	50                   	push   %eax
  800926:	e8 c7 0d 00 00       	call   8016f2 <sys_cputs>
  80092b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80092e:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800935:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80093b:	c9                   	leave  
  80093c:	c3                   	ret    

0080093d <cprintf>:

int cprintf(const char *fmt, ...) {
  80093d:	55                   	push   %ebp
  80093e:	89 e5                	mov    %esp,%ebp
  800940:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800943:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80094a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80094d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800950:	8b 45 08             	mov    0x8(%ebp),%eax
  800953:	83 ec 08             	sub    $0x8,%esp
  800956:	ff 75 f4             	pushl  -0xc(%ebp)
  800959:	50                   	push   %eax
  80095a:	e8 73 ff ff ff       	call   8008d2 <vcprintf>
  80095f:	83 c4 10             	add    $0x10,%esp
  800962:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800965:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800968:	c9                   	leave  
  800969:	c3                   	ret    

0080096a <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80096a:	55                   	push   %ebp
  80096b:	89 e5                	mov    %esp,%ebp
  80096d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800970:	e8 8e 0f 00 00       	call   801903 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800975:	8d 45 0c             	lea    0xc(%ebp),%eax
  800978:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80097b:	8b 45 08             	mov    0x8(%ebp),%eax
  80097e:	83 ec 08             	sub    $0x8,%esp
  800981:	ff 75 f4             	pushl  -0xc(%ebp)
  800984:	50                   	push   %eax
  800985:	e8 48 ff ff ff       	call   8008d2 <vcprintf>
  80098a:	83 c4 10             	add    $0x10,%esp
  80098d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800990:	e8 88 0f 00 00       	call   80191d <sys_enable_interrupt>
	return cnt;
  800995:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800998:	c9                   	leave  
  800999:	c3                   	ret    

0080099a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80099a:	55                   	push   %ebp
  80099b:	89 e5                	mov    %esp,%ebp
  80099d:	53                   	push   %ebx
  80099e:	83 ec 14             	sub    $0x14,%esp
  8009a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8009a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009a7:	8b 45 14             	mov    0x14(%ebp),%eax
  8009aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009ad:	8b 45 18             	mov    0x18(%ebp),%eax
  8009b0:	ba 00 00 00 00       	mov    $0x0,%edx
  8009b5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009b8:	77 55                	ja     800a0f <printnum+0x75>
  8009ba:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009bd:	72 05                	jb     8009c4 <printnum+0x2a>
  8009bf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8009c2:	77 4b                	ja     800a0f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8009c4:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8009c7:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8009ca:	8b 45 18             	mov    0x18(%ebp),%eax
  8009cd:	ba 00 00 00 00       	mov    $0x0,%edx
  8009d2:	52                   	push   %edx
  8009d3:	50                   	push   %eax
  8009d4:	ff 75 f4             	pushl  -0xc(%ebp)
  8009d7:	ff 75 f0             	pushl  -0x10(%ebp)
  8009da:	e8 45 13 00 00       	call   801d24 <__udivdi3>
  8009df:	83 c4 10             	add    $0x10,%esp
  8009e2:	83 ec 04             	sub    $0x4,%esp
  8009e5:	ff 75 20             	pushl  0x20(%ebp)
  8009e8:	53                   	push   %ebx
  8009e9:	ff 75 18             	pushl  0x18(%ebp)
  8009ec:	52                   	push   %edx
  8009ed:	50                   	push   %eax
  8009ee:	ff 75 0c             	pushl  0xc(%ebp)
  8009f1:	ff 75 08             	pushl  0x8(%ebp)
  8009f4:	e8 a1 ff ff ff       	call   80099a <printnum>
  8009f9:	83 c4 20             	add    $0x20,%esp
  8009fc:	eb 1a                	jmp    800a18 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8009fe:	83 ec 08             	sub    $0x8,%esp
  800a01:	ff 75 0c             	pushl  0xc(%ebp)
  800a04:	ff 75 20             	pushl  0x20(%ebp)
  800a07:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0a:	ff d0                	call   *%eax
  800a0c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a0f:	ff 4d 1c             	decl   0x1c(%ebp)
  800a12:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a16:	7f e6                	jg     8009fe <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a18:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a1b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a20:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a23:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a26:	53                   	push   %ebx
  800a27:	51                   	push   %ecx
  800a28:	52                   	push   %edx
  800a29:	50                   	push   %eax
  800a2a:	e8 05 14 00 00       	call   801e34 <__umoddi3>
  800a2f:	83 c4 10             	add    $0x10,%esp
  800a32:	05 14 25 80 00       	add    $0x802514,%eax
  800a37:	8a 00                	mov    (%eax),%al
  800a39:	0f be c0             	movsbl %al,%eax
  800a3c:	83 ec 08             	sub    $0x8,%esp
  800a3f:	ff 75 0c             	pushl  0xc(%ebp)
  800a42:	50                   	push   %eax
  800a43:	8b 45 08             	mov    0x8(%ebp),%eax
  800a46:	ff d0                	call   *%eax
  800a48:	83 c4 10             	add    $0x10,%esp
}
  800a4b:	90                   	nop
  800a4c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a4f:	c9                   	leave  
  800a50:	c3                   	ret    

00800a51 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a51:	55                   	push   %ebp
  800a52:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a54:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a58:	7e 1c                	jle    800a76 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5d:	8b 00                	mov    (%eax),%eax
  800a5f:	8d 50 08             	lea    0x8(%eax),%edx
  800a62:	8b 45 08             	mov    0x8(%ebp),%eax
  800a65:	89 10                	mov    %edx,(%eax)
  800a67:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6a:	8b 00                	mov    (%eax),%eax
  800a6c:	83 e8 08             	sub    $0x8,%eax
  800a6f:	8b 50 04             	mov    0x4(%eax),%edx
  800a72:	8b 00                	mov    (%eax),%eax
  800a74:	eb 40                	jmp    800ab6 <getuint+0x65>
	else if (lflag)
  800a76:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a7a:	74 1e                	je     800a9a <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800a7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7f:	8b 00                	mov    (%eax),%eax
  800a81:	8d 50 04             	lea    0x4(%eax),%edx
  800a84:	8b 45 08             	mov    0x8(%ebp),%eax
  800a87:	89 10                	mov    %edx,(%eax)
  800a89:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8c:	8b 00                	mov    (%eax),%eax
  800a8e:	83 e8 04             	sub    $0x4,%eax
  800a91:	8b 00                	mov    (%eax),%eax
  800a93:	ba 00 00 00 00       	mov    $0x0,%edx
  800a98:	eb 1c                	jmp    800ab6 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800a9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9d:	8b 00                	mov    (%eax),%eax
  800a9f:	8d 50 04             	lea    0x4(%eax),%edx
  800aa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa5:	89 10                	mov    %edx,(%eax)
  800aa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aaa:	8b 00                	mov    (%eax),%eax
  800aac:	83 e8 04             	sub    $0x4,%eax
  800aaf:	8b 00                	mov    (%eax),%eax
  800ab1:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800ab6:	5d                   	pop    %ebp
  800ab7:	c3                   	ret    

00800ab8 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800ab8:	55                   	push   %ebp
  800ab9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800abb:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800abf:	7e 1c                	jle    800add <getint+0x25>
		return va_arg(*ap, long long);
  800ac1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac4:	8b 00                	mov    (%eax),%eax
  800ac6:	8d 50 08             	lea    0x8(%eax),%edx
  800ac9:	8b 45 08             	mov    0x8(%ebp),%eax
  800acc:	89 10                	mov    %edx,(%eax)
  800ace:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad1:	8b 00                	mov    (%eax),%eax
  800ad3:	83 e8 08             	sub    $0x8,%eax
  800ad6:	8b 50 04             	mov    0x4(%eax),%edx
  800ad9:	8b 00                	mov    (%eax),%eax
  800adb:	eb 38                	jmp    800b15 <getint+0x5d>
	else if (lflag)
  800add:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ae1:	74 1a                	je     800afd <getint+0x45>
		return va_arg(*ap, long);
  800ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae6:	8b 00                	mov    (%eax),%eax
  800ae8:	8d 50 04             	lea    0x4(%eax),%edx
  800aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800aee:	89 10                	mov    %edx,(%eax)
  800af0:	8b 45 08             	mov    0x8(%ebp),%eax
  800af3:	8b 00                	mov    (%eax),%eax
  800af5:	83 e8 04             	sub    $0x4,%eax
  800af8:	8b 00                	mov    (%eax),%eax
  800afa:	99                   	cltd   
  800afb:	eb 18                	jmp    800b15 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800afd:	8b 45 08             	mov    0x8(%ebp),%eax
  800b00:	8b 00                	mov    (%eax),%eax
  800b02:	8d 50 04             	lea    0x4(%eax),%edx
  800b05:	8b 45 08             	mov    0x8(%ebp),%eax
  800b08:	89 10                	mov    %edx,(%eax)
  800b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0d:	8b 00                	mov    (%eax),%eax
  800b0f:	83 e8 04             	sub    $0x4,%eax
  800b12:	8b 00                	mov    (%eax),%eax
  800b14:	99                   	cltd   
}
  800b15:	5d                   	pop    %ebp
  800b16:	c3                   	ret    

00800b17 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b17:	55                   	push   %ebp
  800b18:	89 e5                	mov    %esp,%ebp
  800b1a:	56                   	push   %esi
  800b1b:	53                   	push   %ebx
  800b1c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b1f:	eb 17                	jmp    800b38 <vprintfmt+0x21>
			if (ch == '\0')
  800b21:	85 db                	test   %ebx,%ebx
  800b23:	0f 84 af 03 00 00    	je     800ed8 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b29:	83 ec 08             	sub    $0x8,%esp
  800b2c:	ff 75 0c             	pushl  0xc(%ebp)
  800b2f:	53                   	push   %ebx
  800b30:	8b 45 08             	mov    0x8(%ebp),%eax
  800b33:	ff d0                	call   *%eax
  800b35:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b38:	8b 45 10             	mov    0x10(%ebp),%eax
  800b3b:	8d 50 01             	lea    0x1(%eax),%edx
  800b3e:	89 55 10             	mov    %edx,0x10(%ebp)
  800b41:	8a 00                	mov    (%eax),%al
  800b43:	0f b6 d8             	movzbl %al,%ebx
  800b46:	83 fb 25             	cmp    $0x25,%ebx
  800b49:	75 d6                	jne    800b21 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b4b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b4f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b56:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b5d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800b64:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800b6b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b6e:	8d 50 01             	lea    0x1(%eax),%edx
  800b71:	89 55 10             	mov    %edx,0x10(%ebp)
  800b74:	8a 00                	mov    (%eax),%al
  800b76:	0f b6 d8             	movzbl %al,%ebx
  800b79:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800b7c:	83 f8 55             	cmp    $0x55,%eax
  800b7f:	0f 87 2b 03 00 00    	ja     800eb0 <vprintfmt+0x399>
  800b85:	8b 04 85 38 25 80 00 	mov    0x802538(,%eax,4),%eax
  800b8c:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800b8e:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800b92:	eb d7                	jmp    800b6b <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800b94:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800b98:	eb d1                	jmp    800b6b <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800b9a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800ba1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ba4:	89 d0                	mov    %edx,%eax
  800ba6:	c1 e0 02             	shl    $0x2,%eax
  800ba9:	01 d0                	add    %edx,%eax
  800bab:	01 c0                	add    %eax,%eax
  800bad:	01 d8                	add    %ebx,%eax
  800baf:	83 e8 30             	sub    $0x30,%eax
  800bb2:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800bb5:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb8:	8a 00                	mov    (%eax),%al
  800bba:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800bbd:	83 fb 2f             	cmp    $0x2f,%ebx
  800bc0:	7e 3e                	jle    800c00 <vprintfmt+0xe9>
  800bc2:	83 fb 39             	cmp    $0x39,%ebx
  800bc5:	7f 39                	jg     800c00 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bc7:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800bca:	eb d5                	jmp    800ba1 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800bcc:	8b 45 14             	mov    0x14(%ebp),%eax
  800bcf:	83 c0 04             	add    $0x4,%eax
  800bd2:	89 45 14             	mov    %eax,0x14(%ebp)
  800bd5:	8b 45 14             	mov    0x14(%ebp),%eax
  800bd8:	83 e8 04             	sub    $0x4,%eax
  800bdb:	8b 00                	mov    (%eax),%eax
  800bdd:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800be0:	eb 1f                	jmp    800c01 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800be2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800be6:	79 83                	jns    800b6b <vprintfmt+0x54>
				width = 0;
  800be8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800bef:	e9 77 ff ff ff       	jmp    800b6b <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800bf4:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800bfb:	e9 6b ff ff ff       	jmp    800b6b <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c00:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c01:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c05:	0f 89 60 ff ff ff    	jns    800b6b <vprintfmt+0x54>
				width = precision, precision = -1;
  800c0b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c0e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c11:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c18:	e9 4e ff ff ff       	jmp    800b6b <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c1d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c20:	e9 46 ff ff ff       	jmp    800b6b <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c25:	8b 45 14             	mov    0x14(%ebp),%eax
  800c28:	83 c0 04             	add    $0x4,%eax
  800c2b:	89 45 14             	mov    %eax,0x14(%ebp)
  800c2e:	8b 45 14             	mov    0x14(%ebp),%eax
  800c31:	83 e8 04             	sub    $0x4,%eax
  800c34:	8b 00                	mov    (%eax),%eax
  800c36:	83 ec 08             	sub    $0x8,%esp
  800c39:	ff 75 0c             	pushl  0xc(%ebp)
  800c3c:	50                   	push   %eax
  800c3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c40:	ff d0                	call   *%eax
  800c42:	83 c4 10             	add    $0x10,%esp
			break;
  800c45:	e9 89 02 00 00       	jmp    800ed3 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c4a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c4d:	83 c0 04             	add    $0x4,%eax
  800c50:	89 45 14             	mov    %eax,0x14(%ebp)
  800c53:	8b 45 14             	mov    0x14(%ebp),%eax
  800c56:	83 e8 04             	sub    $0x4,%eax
  800c59:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c5b:	85 db                	test   %ebx,%ebx
  800c5d:	79 02                	jns    800c61 <vprintfmt+0x14a>
				err = -err;
  800c5f:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800c61:	83 fb 64             	cmp    $0x64,%ebx
  800c64:	7f 0b                	jg     800c71 <vprintfmt+0x15a>
  800c66:	8b 34 9d 80 23 80 00 	mov    0x802380(,%ebx,4),%esi
  800c6d:	85 f6                	test   %esi,%esi
  800c6f:	75 19                	jne    800c8a <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800c71:	53                   	push   %ebx
  800c72:	68 25 25 80 00       	push   $0x802525
  800c77:	ff 75 0c             	pushl  0xc(%ebp)
  800c7a:	ff 75 08             	pushl  0x8(%ebp)
  800c7d:	e8 5e 02 00 00       	call   800ee0 <printfmt>
  800c82:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800c85:	e9 49 02 00 00       	jmp    800ed3 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800c8a:	56                   	push   %esi
  800c8b:	68 2e 25 80 00       	push   $0x80252e
  800c90:	ff 75 0c             	pushl  0xc(%ebp)
  800c93:	ff 75 08             	pushl  0x8(%ebp)
  800c96:	e8 45 02 00 00       	call   800ee0 <printfmt>
  800c9b:	83 c4 10             	add    $0x10,%esp
			break;
  800c9e:	e9 30 02 00 00       	jmp    800ed3 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ca3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca6:	83 c0 04             	add    $0x4,%eax
  800ca9:	89 45 14             	mov    %eax,0x14(%ebp)
  800cac:	8b 45 14             	mov    0x14(%ebp),%eax
  800caf:	83 e8 04             	sub    $0x4,%eax
  800cb2:	8b 30                	mov    (%eax),%esi
  800cb4:	85 f6                	test   %esi,%esi
  800cb6:	75 05                	jne    800cbd <vprintfmt+0x1a6>
				p = "(null)";
  800cb8:	be 31 25 80 00       	mov    $0x802531,%esi
			if (width > 0 && padc != '-')
  800cbd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cc1:	7e 6d                	jle    800d30 <vprintfmt+0x219>
  800cc3:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800cc7:	74 67                	je     800d30 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800cc9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ccc:	83 ec 08             	sub    $0x8,%esp
  800ccf:	50                   	push   %eax
  800cd0:	56                   	push   %esi
  800cd1:	e8 0c 03 00 00       	call   800fe2 <strnlen>
  800cd6:	83 c4 10             	add    $0x10,%esp
  800cd9:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800cdc:	eb 16                	jmp    800cf4 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800cde:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800ce2:	83 ec 08             	sub    $0x8,%esp
  800ce5:	ff 75 0c             	pushl  0xc(%ebp)
  800ce8:	50                   	push   %eax
  800ce9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cec:	ff d0                	call   *%eax
  800cee:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800cf1:	ff 4d e4             	decl   -0x1c(%ebp)
  800cf4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cf8:	7f e4                	jg     800cde <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800cfa:	eb 34                	jmp    800d30 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800cfc:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d00:	74 1c                	je     800d1e <vprintfmt+0x207>
  800d02:	83 fb 1f             	cmp    $0x1f,%ebx
  800d05:	7e 05                	jle    800d0c <vprintfmt+0x1f5>
  800d07:	83 fb 7e             	cmp    $0x7e,%ebx
  800d0a:	7e 12                	jle    800d1e <vprintfmt+0x207>
					putch('?', putdat);
  800d0c:	83 ec 08             	sub    $0x8,%esp
  800d0f:	ff 75 0c             	pushl  0xc(%ebp)
  800d12:	6a 3f                	push   $0x3f
  800d14:	8b 45 08             	mov    0x8(%ebp),%eax
  800d17:	ff d0                	call   *%eax
  800d19:	83 c4 10             	add    $0x10,%esp
  800d1c:	eb 0f                	jmp    800d2d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d1e:	83 ec 08             	sub    $0x8,%esp
  800d21:	ff 75 0c             	pushl  0xc(%ebp)
  800d24:	53                   	push   %ebx
  800d25:	8b 45 08             	mov    0x8(%ebp),%eax
  800d28:	ff d0                	call   *%eax
  800d2a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d2d:	ff 4d e4             	decl   -0x1c(%ebp)
  800d30:	89 f0                	mov    %esi,%eax
  800d32:	8d 70 01             	lea    0x1(%eax),%esi
  800d35:	8a 00                	mov    (%eax),%al
  800d37:	0f be d8             	movsbl %al,%ebx
  800d3a:	85 db                	test   %ebx,%ebx
  800d3c:	74 24                	je     800d62 <vprintfmt+0x24b>
  800d3e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d42:	78 b8                	js     800cfc <vprintfmt+0x1e5>
  800d44:	ff 4d e0             	decl   -0x20(%ebp)
  800d47:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d4b:	79 af                	jns    800cfc <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d4d:	eb 13                	jmp    800d62 <vprintfmt+0x24b>
				putch(' ', putdat);
  800d4f:	83 ec 08             	sub    $0x8,%esp
  800d52:	ff 75 0c             	pushl  0xc(%ebp)
  800d55:	6a 20                	push   $0x20
  800d57:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5a:	ff d0                	call   *%eax
  800d5c:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d5f:	ff 4d e4             	decl   -0x1c(%ebp)
  800d62:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d66:	7f e7                	jg     800d4f <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800d68:	e9 66 01 00 00       	jmp    800ed3 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800d6d:	83 ec 08             	sub    $0x8,%esp
  800d70:	ff 75 e8             	pushl  -0x18(%ebp)
  800d73:	8d 45 14             	lea    0x14(%ebp),%eax
  800d76:	50                   	push   %eax
  800d77:	e8 3c fd ff ff       	call   800ab8 <getint>
  800d7c:	83 c4 10             	add    $0x10,%esp
  800d7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d82:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800d85:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d88:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d8b:	85 d2                	test   %edx,%edx
  800d8d:	79 23                	jns    800db2 <vprintfmt+0x29b>
				putch('-', putdat);
  800d8f:	83 ec 08             	sub    $0x8,%esp
  800d92:	ff 75 0c             	pushl  0xc(%ebp)
  800d95:	6a 2d                	push   $0x2d
  800d97:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9a:	ff d0                	call   *%eax
  800d9c:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800d9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800da2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800da5:	f7 d8                	neg    %eax
  800da7:	83 d2 00             	adc    $0x0,%edx
  800daa:	f7 da                	neg    %edx
  800dac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800daf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800db2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800db9:	e9 bc 00 00 00       	jmp    800e7a <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800dbe:	83 ec 08             	sub    $0x8,%esp
  800dc1:	ff 75 e8             	pushl  -0x18(%ebp)
  800dc4:	8d 45 14             	lea    0x14(%ebp),%eax
  800dc7:	50                   	push   %eax
  800dc8:	e8 84 fc ff ff       	call   800a51 <getuint>
  800dcd:	83 c4 10             	add    $0x10,%esp
  800dd0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dd3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800dd6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ddd:	e9 98 00 00 00       	jmp    800e7a <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800de2:	83 ec 08             	sub    $0x8,%esp
  800de5:	ff 75 0c             	pushl  0xc(%ebp)
  800de8:	6a 58                	push   $0x58
  800dea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ded:	ff d0                	call   *%eax
  800def:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800df2:	83 ec 08             	sub    $0x8,%esp
  800df5:	ff 75 0c             	pushl  0xc(%ebp)
  800df8:	6a 58                	push   $0x58
  800dfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfd:	ff d0                	call   *%eax
  800dff:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e02:	83 ec 08             	sub    $0x8,%esp
  800e05:	ff 75 0c             	pushl  0xc(%ebp)
  800e08:	6a 58                	push   $0x58
  800e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0d:	ff d0                	call   *%eax
  800e0f:	83 c4 10             	add    $0x10,%esp
			break;
  800e12:	e9 bc 00 00 00       	jmp    800ed3 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e17:	83 ec 08             	sub    $0x8,%esp
  800e1a:	ff 75 0c             	pushl  0xc(%ebp)
  800e1d:	6a 30                	push   $0x30
  800e1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e22:	ff d0                	call   *%eax
  800e24:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e27:	83 ec 08             	sub    $0x8,%esp
  800e2a:	ff 75 0c             	pushl  0xc(%ebp)
  800e2d:	6a 78                	push   $0x78
  800e2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e32:	ff d0                	call   *%eax
  800e34:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e37:	8b 45 14             	mov    0x14(%ebp),%eax
  800e3a:	83 c0 04             	add    $0x4,%eax
  800e3d:	89 45 14             	mov    %eax,0x14(%ebp)
  800e40:	8b 45 14             	mov    0x14(%ebp),%eax
  800e43:	83 e8 04             	sub    $0x4,%eax
  800e46:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e48:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e4b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e52:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e59:	eb 1f                	jmp    800e7a <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e5b:	83 ec 08             	sub    $0x8,%esp
  800e5e:	ff 75 e8             	pushl  -0x18(%ebp)
  800e61:	8d 45 14             	lea    0x14(%ebp),%eax
  800e64:	50                   	push   %eax
  800e65:	e8 e7 fb ff ff       	call   800a51 <getuint>
  800e6a:	83 c4 10             	add    $0x10,%esp
  800e6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e70:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800e73:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800e7a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800e7e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e81:	83 ec 04             	sub    $0x4,%esp
  800e84:	52                   	push   %edx
  800e85:	ff 75 e4             	pushl  -0x1c(%ebp)
  800e88:	50                   	push   %eax
  800e89:	ff 75 f4             	pushl  -0xc(%ebp)
  800e8c:	ff 75 f0             	pushl  -0x10(%ebp)
  800e8f:	ff 75 0c             	pushl  0xc(%ebp)
  800e92:	ff 75 08             	pushl  0x8(%ebp)
  800e95:	e8 00 fb ff ff       	call   80099a <printnum>
  800e9a:	83 c4 20             	add    $0x20,%esp
			break;
  800e9d:	eb 34                	jmp    800ed3 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800e9f:	83 ec 08             	sub    $0x8,%esp
  800ea2:	ff 75 0c             	pushl  0xc(%ebp)
  800ea5:	53                   	push   %ebx
  800ea6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea9:	ff d0                	call   *%eax
  800eab:	83 c4 10             	add    $0x10,%esp
			break;
  800eae:	eb 23                	jmp    800ed3 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800eb0:	83 ec 08             	sub    $0x8,%esp
  800eb3:	ff 75 0c             	pushl  0xc(%ebp)
  800eb6:	6a 25                	push   $0x25
  800eb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebb:	ff d0                	call   *%eax
  800ebd:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ec0:	ff 4d 10             	decl   0x10(%ebp)
  800ec3:	eb 03                	jmp    800ec8 <vprintfmt+0x3b1>
  800ec5:	ff 4d 10             	decl   0x10(%ebp)
  800ec8:	8b 45 10             	mov    0x10(%ebp),%eax
  800ecb:	48                   	dec    %eax
  800ecc:	8a 00                	mov    (%eax),%al
  800ece:	3c 25                	cmp    $0x25,%al
  800ed0:	75 f3                	jne    800ec5 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ed2:	90                   	nop
		}
	}
  800ed3:	e9 47 fc ff ff       	jmp    800b1f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ed8:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ed9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800edc:	5b                   	pop    %ebx
  800edd:	5e                   	pop    %esi
  800ede:	5d                   	pop    %ebp
  800edf:	c3                   	ret    

00800ee0 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ee0:	55                   	push   %ebp
  800ee1:	89 e5                	mov    %esp,%ebp
  800ee3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ee6:	8d 45 10             	lea    0x10(%ebp),%eax
  800ee9:	83 c0 04             	add    $0x4,%eax
  800eec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800eef:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef2:	ff 75 f4             	pushl  -0xc(%ebp)
  800ef5:	50                   	push   %eax
  800ef6:	ff 75 0c             	pushl  0xc(%ebp)
  800ef9:	ff 75 08             	pushl  0x8(%ebp)
  800efc:	e8 16 fc ff ff       	call   800b17 <vprintfmt>
  800f01:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f04:	90                   	nop
  800f05:	c9                   	leave  
  800f06:	c3                   	ret    

00800f07 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f07:	55                   	push   %ebp
  800f08:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0d:	8b 40 08             	mov    0x8(%eax),%eax
  800f10:	8d 50 01             	lea    0x1(%eax),%edx
  800f13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f16:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1c:	8b 10                	mov    (%eax),%edx
  800f1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f21:	8b 40 04             	mov    0x4(%eax),%eax
  800f24:	39 c2                	cmp    %eax,%edx
  800f26:	73 12                	jae    800f3a <sprintputch+0x33>
		*b->buf++ = ch;
  800f28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2b:	8b 00                	mov    (%eax),%eax
  800f2d:	8d 48 01             	lea    0x1(%eax),%ecx
  800f30:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f33:	89 0a                	mov    %ecx,(%edx)
  800f35:	8b 55 08             	mov    0x8(%ebp),%edx
  800f38:	88 10                	mov    %dl,(%eax)
}
  800f3a:	90                   	nop
  800f3b:	5d                   	pop    %ebp
  800f3c:	c3                   	ret    

00800f3d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f3d:	55                   	push   %ebp
  800f3e:	89 e5                	mov    %esp,%ebp
  800f40:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f43:	8b 45 08             	mov    0x8(%ebp),%eax
  800f46:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f52:	01 d0                	add    %edx,%eax
  800f54:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f57:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f5e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f62:	74 06                	je     800f6a <vsnprintf+0x2d>
  800f64:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f68:	7f 07                	jg     800f71 <vsnprintf+0x34>
		return -E_INVAL;
  800f6a:	b8 03 00 00 00       	mov    $0x3,%eax
  800f6f:	eb 20                	jmp    800f91 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800f71:	ff 75 14             	pushl  0x14(%ebp)
  800f74:	ff 75 10             	pushl  0x10(%ebp)
  800f77:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800f7a:	50                   	push   %eax
  800f7b:	68 07 0f 80 00       	push   $0x800f07
  800f80:	e8 92 fb ff ff       	call   800b17 <vprintfmt>
  800f85:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800f88:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f8b:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800f8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800f91:	c9                   	leave  
  800f92:	c3                   	ret    

00800f93 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800f93:	55                   	push   %ebp
  800f94:	89 e5                	mov    %esp,%ebp
  800f96:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800f99:	8d 45 10             	lea    0x10(%ebp),%eax
  800f9c:	83 c0 04             	add    $0x4,%eax
  800f9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800fa2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa5:	ff 75 f4             	pushl  -0xc(%ebp)
  800fa8:	50                   	push   %eax
  800fa9:	ff 75 0c             	pushl  0xc(%ebp)
  800fac:	ff 75 08             	pushl  0x8(%ebp)
  800faf:	e8 89 ff ff ff       	call   800f3d <vsnprintf>
  800fb4:	83 c4 10             	add    $0x10,%esp
  800fb7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800fba:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fbd:	c9                   	leave  
  800fbe:	c3                   	ret    

00800fbf <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800fbf:	55                   	push   %ebp
  800fc0:	89 e5                	mov    %esp,%ebp
  800fc2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800fc5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800fcc:	eb 06                	jmp    800fd4 <strlen+0x15>
		n++;
  800fce:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800fd1:	ff 45 08             	incl   0x8(%ebp)
  800fd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd7:	8a 00                	mov    (%eax),%al
  800fd9:	84 c0                	test   %al,%al
  800fdb:	75 f1                	jne    800fce <strlen+0xf>
		n++;
	return n;
  800fdd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800fe0:	c9                   	leave  
  800fe1:	c3                   	ret    

00800fe2 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800fe2:	55                   	push   %ebp
  800fe3:	89 e5                	mov    %esp,%ebp
  800fe5:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800fe8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800fef:	eb 09                	jmp    800ffa <strnlen+0x18>
		n++;
  800ff1:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ff4:	ff 45 08             	incl   0x8(%ebp)
  800ff7:	ff 4d 0c             	decl   0xc(%ebp)
  800ffa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ffe:	74 09                	je     801009 <strnlen+0x27>
  801000:	8b 45 08             	mov    0x8(%ebp),%eax
  801003:	8a 00                	mov    (%eax),%al
  801005:	84 c0                	test   %al,%al
  801007:	75 e8                	jne    800ff1 <strnlen+0xf>
		n++;
	return n;
  801009:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80100c:	c9                   	leave  
  80100d:	c3                   	ret    

0080100e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80100e:	55                   	push   %ebp
  80100f:	89 e5                	mov    %esp,%ebp
  801011:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801014:	8b 45 08             	mov    0x8(%ebp),%eax
  801017:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80101a:	90                   	nop
  80101b:	8b 45 08             	mov    0x8(%ebp),%eax
  80101e:	8d 50 01             	lea    0x1(%eax),%edx
  801021:	89 55 08             	mov    %edx,0x8(%ebp)
  801024:	8b 55 0c             	mov    0xc(%ebp),%edx
  801027:	8d 4a 01             	lea    0x1(%edx),%ecx
  80102a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80102d:	8a 12                	mov    (%edx),%dl
  80102f:	88 10                	mov    %dl,(%eax)
  801031:	8a 00                	mov    (%eax),%al
  801033:	84 c0                	test   %al,%al
  801035:	75 e4                	jne    80101b <strcpy+0xd>
		/* do nothing */;
	return ret;
  801037:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80103a:	c9                   	leave  
  80103b:	c3                   	ret    

0080103c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80103c:	55                   	push   %ebp
  80103d:	89 e5                	mov    %esp,%ebp
  80103f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801042:	8b 45 08             	mov    0x8(%ebp),%eax
  801045:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801048:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80104f:	eb 1f                	jmp    801070 <strncpy+0x34>
		*dst++ = *src;
  801051:	8b 45 08             	mov    0x8(%ebp),%eax
  801054:	8d 50 01             	lea    0x1(%eax),%edx
  801057:	89 55 08             	mov    %edx,0x8(%ebp)
  80105a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80105d:	8a 12                	mov    (%edx),%dl
  80105f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801061:	8b 45 0c             	mov    0xc(%ebp),%eax
  801064:	8a 00                	mov    (%eax),%al
  801066:	84 c0                	test   %al,%al
  801068:	74 03                	je     80106d <strncpy+0x31>
			src++;
  80106a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80106d:	ff 45 fc             	incl   -0x4(%ebp)
  801070:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801073:	3b 45 10             	cmp    0x10(%ebp),%eax
  801076:	72 d9                	jb     801051 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801078:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80107b:	c9                   	leave  
  80107c:	c3                   	ret    

0080107d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80107d:	55                   	push   %ebp
  80107e:	89 e5                	mov    %esp,%ebp
  801080:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801083:	8b 45 08             	mov    0x8(%ebp),%eax
  801086:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801089:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80108d:	74 30                	je     8010bf <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80108f:	eb 16                	jmp    8010a7 <strlcpy+0x2a>
			*dst++ = *src++;
  801091:	8b 45 08             	mov    0x8(%ebp),%eax
  801094:	8d 50 01             	lea    0x1(%eax),%edx
  801097:	89 55 08             	mov    %edx,0x8(%ebp)
  80109a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80109d:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010a0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010a3:	8a 12                	mov    (%edx),%dl
  8010a5:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010a7:	ff 4d 10             	decl   0x10(%ebp)
  8010aa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010ae:	74 09                	je     8010b9 <strlcpy+0x3c>
  8010b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b3:	8a 00                	mov    (%eax),%al
  8010b5:	84 c0                	test   %al,%al
  8010b7:	75 d8                	jne    801091 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8010b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bc:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8010bf:	8b 55 08             	mov    0x8(%ebp),%edx
  8010c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010c5:	29 c2                	sub    %eax,%edx
  8010c7:	89 d0                	mov    %edx,%eax
}
  8010c9:	c9                   	leave  
  8010ca:	c3                   	ret    

008010cb <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8010cb:	55                   	push   %ebp
  8010cc:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8010ce:	eb 06                	jmp    8010d6 <strcmp+0xb>
		p++, q++;
  8010d0:	ff 45 08             	incl   0x8(%ebp)
  8010d3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8010d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d9:	8a 00                	mov    (%eax),%al
  8010db:	84 c0                	test   %al,%al
  8010dd:	74 0e                	je     8010ed <strcmp+0x22>
  8010df:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e2:	8a 10                	mov    (%eax),%dl
  8010e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e7:	8a 00                	mov    (%eax),%al
  8010e9:	38 c2                	cmp    %al,%dl
  8010eb:	74 e3                	je     8010d0 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8010ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f0:	8a 00                	mov    (%eax),%al
  8010f2:	0f b6 d0             	movzbl %al,%edx
  8010f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f8:	8a 00                	mov    (%eax),%al
  8010fa:	0f b6 c0             	movzbl %al,%eax
  8010fd:	29 c2                	sub    %eax,%edx
  8010ff:	89 d0                	mov    %edx,%eax
}
  801101:	5d                   	pop    %ebp
  801102:	c3                   	ret    

00801103 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801103:	55                   	push   %ebp
  801104:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801106:	eb 09                	jmp    801111 <strncmp+0xe>
		n--, p++, q++;
  801108:	ff 4d 10             	decl   0x10(%ebp)
  80110b:	ff 45 08             	incl   0x8(%ebp)
  80110e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801111:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801115:	74 17                	je     80112e <strncmp+0x2b>
  801117:	8b 45 08             	mov    0x8(%ebp),%eax
  80111a:	8a 00                	mov    (%eax),%al
  80111c:	84 c0                	test   %al,%al
  80111e:	74 0e                	je     80112e <strncmp+0x2b>
  801120:	8b 45 08             	mov    0x8(%ebp),%eax
  801123:	8a 10                	mov    (%eax),%dl
  801125:	8b 45 0c             	mov    0xc(%ebp),%eax
  801128:	8a 00                	mov    (%eax),%al
  80112a:	38 c2                	cmp    %al,%dl
  80112c:	74 da                	je     801108 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80112e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801132:	75 07                	jne    80113b <strncmp+0x38>
		return 0;
  801134:	b8 00 00 00 00       	mov    $0x0,%eax
  801139:	eb 14                	jmp    80114f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80113b:	8b 45 08             	mov    0x8(%ebp),%eax
  80113e:	8a 00                	mov    (%eax),%al
  801140:	0f b6 d0             	movzbl %al,%edx
  801143:	8b 45 0c             	mov    0xc(%ebp),%eax
  801146:	8a 00                	mov    (%eax),%al
  801148:	0f b6 c0             	movzbl %al,%eax
  80114b:	29 c2                	sub    %eax,%edx
  80114d:	89 d0                	mov    %edx,%eax
}
  80114f:	5d                   	pop    %ebp
  801150:	c3                   	ret    

00801151 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801151:	55                   	push   %ebp
  801152:	89 e5                	mov    %esp,%ebp
  801154:	83 ec 04             	sub    $0x4,%esp
  801157:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80115d:	eb 12                	jmp    801171 <strchr+0x20>
		if (*s == c)
  80115f:	8b 45 08             	mov    0x8(%ebp),%eax
  801162:	8a 00                	mov    (%eax),%al
  801164:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801167:	75 05                	jne    80116e <strchr+0x1d>
			return (char *) s;
  801169:	8b 45 08             	mov    0x8(%ebp),%eax
  80116c:	eb 11                	jmp    80117f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80116e:	ff 45 08             	incl   0x8(%ebp)
  801171:	8b 45 08             	mov    0x8(%ebp),%eax
  801174:	8a 00                	mov    (%eax),%al
  801176:	84 c0                	test   %al,%al
  801178:	75 e5                	jne    80115f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80117a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80117f:	c9                   	leave  
  801180:	c3                   	ret    

00801181 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801181:	55                   	push   %ebp
  801182:	89 e5                	mov    %esp,%ebp
  801184:	83 ec 04             	sub    $0x4,%esp
  801187:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80118d:	eb 0d                	jmp    80119c <strfind+0x1b>
		if (*s == c)
  80118f:	8b 45 08             	mov    0x8(%ebp),%eax
  801192:	8a 00                	mov    (%eax),%al
  801194:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801197:	74 0e                	je     8011a7 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801199:	ff 45 08             	incl   0x8(%ebp)
  80119c:	8b 45 08             	mov    0x8(%ebp),%eax
  80119f:	8a 00                	mov    (%eax),%al
  8011a1:	84 c0                	test   %al,%al
  8011a3:	75 ea                	jne    80118f <strfind+0xe>
  8011a5:	eb 01                	jmp    8011a8 <strfind+0x27>
		if (*s == c)
			break;
  8011a7:	90                   	nop
	return (char *) s;
  8011a8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011ab:	c9                   	leave  
  8011ac:	c3                   	ret    

008011ad <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8011ad:	55                   	push   %ebp
  8011ae:	89 e5                	mov    %esp,%ebp
  8011b0:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8011b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8011b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8011bc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8011bf:	eb 0e                	jmp    8011cf <memset+0x22>
		*p++ = c;
  8011c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011c4:	8d 50 01             	lea    0x1(%eax),%edx
  8011c7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011cd:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8011cf:	ff 4d f8             	decl   -0x8(%ebp)
  8011d2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8011d6:	79 e9                	jns    8011c1 <memset+0x14>
		*p++ = c;

	return v;
  8011d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011db:	c9                   	leave  
  8011dc:	c3                   	ret    

008011dd <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8011dd:	55                   	push   %ebp
  8011de:	89 e5                	mov    %esp,%ebp
  8011e0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8011e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8011e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8011ef:	eb 16                	jmp    801207 <memcpy+0x2a>
		*d++ = *s++;
  8011f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011f4:	8d 50 01             	lea    0x1(%eax),%edx
  8011f7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011fd:	8d 4a 01             	lea    0x1(%edx),%ecx
  801200:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801203:	8a 12                	mov    (%edx),%dl
  801205:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801207:	8b 45 10             	mov    0x10(%ebp),%eax
  80120a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80120d:	89 55 10             	mov    %edx,0x10(%ebp)
  801210:	85 c0                	test   %eax,%eax
  801212:	75 dd                	jne    8011f1 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801214:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801217:	c9                   	leave  
  801218:	c3                   	ret    

00801219 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801219:	55                   	push   %ebp
  80121a:	89 e5                	mov    %esp,%ebp
  80121c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80121f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801222:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801225:	8b 45 08             	mov    0x8(%ebp),%eax
  801228:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80122b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80122e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801231:	73 50                	jae    801283 <memmove+0x6a>
  801233:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801236:	8b 45 10             	mov    0x10(%ebp),%eax
  801239:	01 d0                	add    %edx,%eax
  80123b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80123e:	76 43                	jbe    801283 <memmove+0x6a>
		s += n;
  801240:	8b 45 10             	mov    0x10(%ebp),%eax
  801243:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801246:	8b 45 10             	mov    0x10(%ebp),%eax
  801249:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80124c:	eb 10                	jmp    80125e <memmove+0x45>
			*--d = *--s;
  80124e:	ff 4d f8             	decl   -0x8(%ebp)
  801251:	ff 4d fc             	decl   -0x4(%ebp)
  801254:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801257:	8a 10                	mov    (%eax),%dl
  801259:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80125c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80125e:	8b 45 10             	mov    0x10(%ebp),%eax
  801261:	8d 50 ff             	lea    -0x1(%eax),%edx
  801264:	89 55 10             	mov    %edx,0x10(%ebp)
  801267:	85 c0                	test   %eax,%eax
  801269:	75 e3                	jne    80124e <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80126b:	eb 23                	jmp    801290 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80126d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801270:	8d 50 01             	lea    0x1(%eax),%edx
  801273:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801276:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801279:	8d 4a 01             	lea    0x1(%edx),%ecx
  80127c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80127f:	8a 12                	mov    (%edx),%dl
  801281:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801283:	8b 45 10             	mov    0x10(%ebp),%eax
  801286:	8d 50 ff             	lea    -0x1(%eax),%edx
  801289:	89 55 10             	mov    %edx,0x10(%ebp)
  80128c:	85 c0                	test   %eax,%eax
  80128e:	75 dd                	jne    80126d <memmove+0x54>
			*d++ = *s++;

	return dst;
  801290:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801293:	c9                   	leave  
  801294:	c3                   	ret    

00801295 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801295:	55                   	push   %ebp
  801296:	89 e5                	mov    %esp,%ebp
  801298:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80129b:	8b 45 08             	mov    0x8(%ebp),%eax
  80129e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a4:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012a7:	eb 2a                	jmp    8012d3 <memcmp+0x3e>
		if (*s1 != *s2)
  8012a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ac:	8a 10                	mov    (%eax),%dl
  8012ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012b1:	8a 00                	mov    (%eax),%al
  8012b3:	38 c2                	cmp    %al,%dl
  8012b5:	74 16                	je     8012cd <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8012b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ba:	8a 00                	mov    (%eax),%al
  8012bc:	0f b6 d0             	movzbl %al,%edx
  8012bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012c2:	8a 00                	mov    (%eax),%al
  8012c4:	0f b6 c0             	movzbl %al,%eax
  8012c7:	29 c2                	sub    %eax,%edx
  8012c9:	89 d0                	mov    %edx,%eax
  8012cb:	eb 18                	jmp    8012e5 <memcmp+0x50>
		s1++, s2++;
  8012cd:	ff 45 fc             	incl   -0x4(%ebp)
  8012d0:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8012d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012d9:	89 55 10             	mov    %edx,0x10(%ebp)
  8012dc:	85 c0                	test   %eax,%eax
  8012de:	75 c9                	jne    8012a9 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8012e0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8012e5:	c9                   	leave  
  8012e6:	c3                   	ret    

008012e7 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8012e7:	55                   	push   %ebp
  8012e8:	89 e5                	mov    %esp,%ebp
  8012ea:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8012ed:	8b 55 08             	mov    0x8(%ebp),%edx
  8012f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f3:	01 d0                	add    %edx,%eax
  8012f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8012f8:	eb 15                	jmp    80130f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8012fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fd:	8a 00                	mov    (%eax),%al
  8012ff:	0f b6 d0             	movzbl %al,%edx
  801302:	8b 45 0c             	mov    0xc(%ebp),%eax
  801305:	0f b6 c0             	movzbl %al,%eax
  801308:	39 c2                	cmp    %eax,%edx
  80130a:	74 0d                	je     801319 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80130c:	ff 45 08             	incl   0x8(%ebp)
  80130f:	8b 45 08             	mov    0x8(%ebp),%eax
  801312:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801315:	72 e3                	jb     8012fa <memfind+0x13>
  801317:	eb 01                	jmp    80131a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801319:	90                   	nop
	return (void *) s;
  80131a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80131d:	c9                   	leave  
  80131e:	c3                   	ret    

0080131f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80131f:	55                   	push   %ebp
  801320:	89 e5                	mov    %esp,%ebp
  801322:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801325:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80132c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801333:	eb 03                	jmp    801338 <strtol+0x19>
		s++;
  801335:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801338:	8b 45 08             	mov    0x8(%ebp),%eax
  80133b:	8a 00                	mov    (%eax),%al
  80133d:	3c 20                	cmp    $0x20,%al
  80133f:	74 f4                	je     801335 <strtol+0x16>
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
  801344:	8a 00                	mov    (%eax),%al
  801346:	3c 09                	cmp    $0x9,%al
  801348:	74 eb                	je     801335 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80134a:	8b 45 08             	mov    0x8(%ebp),%eax
  80134d:	8a 00                	mov    (%eax),%al
  80134f:	3c 2b                	cmp    $0x2b,%al
  801351:	75 05                	jne    801358 <strtol+0x39>
		s++;
  801353:	ff 45 08             	incl   0x8(%ebp)
  801356:	eb 13                	jmp    80136b <strtol+0x4c>
	else if (*s == '-')
  801358:	8b 45 08             	mov    0x8(%ebp),%eax
  80135b:	8a 00                	mov    (%eax),%al
  80135d:	3c 2d                	cmp    $0x2d,%al
  80135f:	75 0a                	jne    80136b <strtol+0x4c>
		s++, neg = 1;
  801361:	ff 45 08             	incl   0x8(%ebp)
  801364:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80136b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80136f:	74 06                	je     801377 <strtol+0x58>
  801371:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801375:	75 20                	jne    801397 <strtol+0x78>
  801377:	8b 45 08             	mov    0x8(%ebp),%eax
  80137a:	8a 00                	mov    (%eax),%al
  80137c:	3c 30                	cmp    $0x30,%al
  80137e:	75 17                	jne    801397 <strtol+0x78>
  801380:	8b 45 08             	mov    0x8(%ebp),%eax
  801383:	40                   	inc    %eax
  801384:	8a 00                	mov    (%eax),%al
  801386:	3c 78                	cmp    $0x78,%al
  801388:	75 0d                	jne    801397 <strtol+0x78>
		s += 2, base = 16;
  80138a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80138e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801395:	eb 28                	jmp    8013bf <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801397:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80139b:	75 15                	jne    8013b2 <strtol+0x93>
  80139d:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a0:	8a 00                	mov    (%eax),%al
  8013a2:	3c 30                	cmp    $0x30,%al
  8013a4:	75 0c                	jne    8013b2 <strtol+0x93>
		s++, base = 8;
  8013a6:	ff 45 08             	incl   0x8(%ebp)
  8013a9:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8013b0:	eb 0d                	jmp    8013bf <strtol+0xa0>
	else if (base == 0)
  8013b2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013b6:	75 07                	jne    8013bf <strtol+0xa0>
		base = 10;
  8013b8:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8013bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c2:	8a 00                	mov    (%eax),%al
  8013c4:	3c 2f                	cmp    $0x2f,%al
  8013c6:	7e 19                	jle    8013e1 <strtol+0xc2>
  8013c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cb:	8a 00                	mov    (%eax),%al
  8013cd:	3c 39                	cmp    $0x39,%al
  8013cf:	7f 10                	jg     8013e1 <strtol+0xc2>
			dig = *s - '0';
  8013d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d4:	8a 00                	mov    (%eax),%al
  8013d6:	0f be c0             	movsbl %al,%eax
  8013d9:	83 e8 30             	sub    $0x30,%eax
  8013dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8013df:	eb 42                	jmp    801423 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8013e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e4:	8a 00                	mov    (%eax),%al
  8013e6:	3c 60                	cmp    $0x60,%al
  8013e8:	7e 19                	jle    801403 <strtol+0xe4>
  8013ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ed:	8a 00                	mov    (%eax),%al
  8013ef:	3c 7a                	cmp    $0x7a,%al
  8013f1:	7f 10                	jg     801403 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8013f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f6:	8a 00                	mov    (%eax),%al
  8013f8:	0f be c0             	movsbl %al,%eax
  8013fb:	83 e8 57             	sub    $0x57,%eax
  8013fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801401:	eb 20                	jmp    801423 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801403:	8b 45 08             	mov    0x8(%ebp),%eax
  801406:	8a 00                	mov    (%eax),%al
  801408:	3c 40                	cmp    $0x40,%al
  80140a:	7e 39                	jle    801445 <strtol+0x126>
  80140c:	8b 45 08             	mov    0x8(%ebp),%eax
  80140f:	8a 00                	mov    (%eax),%al
  801411:	3c 5a                	cmp    $0x5a,%al
  801413:	7f 30                	jg     801445 <strtol+0x126>
			dig = *s - 'A' + 10;
  801415:	8b 45 08             	mov    0x8(%ebp),%eax
  801418:	8a 00                	mov    (%eax),%al
  80141a:	0f be c0             	movsbl %al,%eax
  80141d:	83 e8 37             	sub    $0x37,%eax
  801420:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801423:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801426:	3b 45 10             	cmp    0x10(%ebp),%eax
  801429:	7d 19                	jge    801444 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80142b:	ff 45 08             	incl   0x8(%ebp)
  80142e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801431:	0f af 45 10          	imul   0x10(%ebp),%eax
  801435:	89 c2                	mov    %eax,%edx
  801437:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80143a:	01 d0                	add    %edx,%eax
  80143c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80143f:	e9 7b ff ff ff       	jmp    8013bf <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801444:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801445:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801449:	74 08                	je     801453 <strtol+0x134>
		*endptr = (char *) s;
  80144b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80144e:	8b 55 08             	mov    0x8(%ebp),%edx
  801451:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801453:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801457:	74 07                	je     801460 <strtol+0x141>
  801459:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80145c:	f7 d8                	neg    %eax
  80145e:	eb 03                	jmp    801463 <strtol+0x144>
  801460:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801463:	c9                   	leave  
  801464:	c3                   	ret    

00801465 <ltostr>:

void
ltostr(long value, char *str)
{
  801465:	55                   	push   %ebp
  801466:	89 e5                	mov    %esp,%ebp
  801468:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80146b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801472:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801479:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80147d:	79 13                	jns    801492 <ltostr+0x2d>
	{
		neg = 1;
  80147f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801486:	8b 45 0c             	mov    0xc(%ebp),%eax
  801489:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80148c:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80148f:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801492:	8b 45 08             	mov    0x8(%ebp),%eax
  801495:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80149a:	99                   	cltd   
  80149b:	f7 f9                	idiv   %ecx
  80149d:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014a3:	8d 50 01             	lea    0x1(%eax),%edx
  8014a6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014a9:	89 c2                	mov    %eax,%edx
  8014ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ae:	01 d0                	add    %edx,%eax
  8014b0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014b3:	83 c2 30             	add    $0x30,%edx
  8014b6:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8014b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014bb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014c0:	f7 e9                	imul   %ecx
  8014c2:	c1 fa 02             	sar    $0x2,%edx
  8014c5:	89 c8                	mov    %ecx,%eax
  8014c7:	c1 f8 1f             	sar    $0x1f,%eax
  8014ca:	29 c2                	sub    %eax,%edx
  8014cc:	89 d0                	mov    %edx,%eax
  8014ce:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8014d1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014d4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014d9:	f7 e9                	imul   %ecx
  8014db:	c1 fa 02             	sar    $0x2,%edx
  8014de:	89 c8                	mov    %ecx,%eax
  8014e0:	c1 f8 1f             	sar    $0x1f,%eax
  8014e3:	29 c2                	sub    %eax,%edx
  8014e5:	89 d0                	mov    %edx,%eax
  8014e7:	c1 e0 02             	shl    $0x2,%eax
  8014ea:	01 d0                	add    %edx,%eax
  8014ec:	01 c0                	add    %eax,%eax
  8014ee:	29 c1                	sub    %eax,%ecx
  8014f0:	89 ca                	mov    %ecx,%edx
  8014f2:	85 d2                	test   %edx,%edx
  8014f4:	75 9c                	jne    801492 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8014f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8014fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801500:	48                   	dec    %eax
  801501:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801504:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801508:	74 3d                	je     801547 <ltostr+0xe2>
		start = 1 ;
  80150a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801511:	eb 34                	jmp    801547 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801513:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801516:	8b 45 0c             	mov    0xc(%ebp),%eax
  801519:	01 d0                	add    %edx,%eax
  80151b:	8a 00                	mov    (%eax),%al
  80151d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801520:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801523:	8b 45 0c             	mov    0xc(%ebp),%eax
  801526:	01 c2                	add    %eax,%edx
  801528:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80152b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152e:	01 c8                	add    %ecx,%eax
  801530:	8a 00                	mov    (%eax),%al
  801532:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801534:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801537:	8b 45 0c             	mov    0xc(%ebp),%eax
  80153a:	01 c2                	add    %eax,%edx
  80153c:	8a 45 eb             	mov    -0x15(%ebp),%al
  80153f:	88 02                	mov    %al,(%edx)
		start++ ;
  801541:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801544:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801547:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80154a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80154d:	7c c4                	jl     801513 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80154f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801552:	8b 45 0c             	mov    0xc(%ebp),%eax
  801555:	01 d0                	add    %edx,%eax
  801557:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80155a:	90                   	nop
  80155b:	c9                   	leave  
  80155c:	c3                   	ret    

0080155d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80155d:	55                   	push   %ebp
  80155e:	89 e5                	mov    %esp,%ebp
  801560:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801563:	ff 75 08             	pushl  0x8(%ebp)
  801566:	e8 54 fa ff ff       	call   800fbf <strlen>
  80156b:	83 c4 04             	add    $0x4,%esp
  80156e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801571:	ff 75 0c             	pushl  0xc(%ebp)
  801574:	e8 46 fa ff ff       	call   800fbf <strlen>
  801579:	83 c4 04             	add    $0x4,%esp
  80157c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80157f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801586:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80158d:	eb 17                	jmp    8015a6 <strcconcat+0x49>
		final[s] = str1[s] ;
  80158f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801592:	8b 45 10             	mov    0x10(%ebp),%eax
  801595:	01 c2                	add    %eax,%edx
  801597:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80159a:	8b 45 08             	mov    0x8(%ebp),%eax
  80159d:	01 c8                	add    %ecx,%eax
  80159f:	8a 00                	mov    (%eax),%al
  8015a1:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015a3:	ff 45 fc             	incl   -0x4(%ebp)
  8015a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015a9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015ac:	7c e1                	jl     80158f <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8015ae:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8015b5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8015bc:	eb 1f                	jmp    8015dd <strcconcat+0x80>
		final[s++] = str2[i] ;
  8015be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015c1:	8d 50 01             	lea    0x1(%eax),%edx
  8015c4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8015c7:	89 c2                	mov    %eax,%edx
  8015c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8015cc:	01 c2                	add    %eax,%edx
  8015ce:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8015d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d4:	01 c8                	add    %ecx,%eax
  8015d6:	8a 00                	mov    (%eax),%al
  8015d8:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8015da:	ff 45 f8             	incl   -0x8(%ebp)
  8015dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015e0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015e3:	7c d9                	jl     8015be <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8015e5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8015eb:	01 d0                	add    %edx,%eax
  8015ed:	c6 00 00             	movb   $0x0,(%eax)
}
  8015f0:	90                   	nop
  8015f1:	c9                   	leave  
  8015f2:	c3                   	ret    

008015f3 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8015f3:	55                   	push   %ebp
  8015f4:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8015f6:	8b 45 14             	mov    0x14(%ebp),%eax
  8015f9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8015ff:	8b 45 14             	mov    0x14(%ebp),%eax
  801602:	8b 00                	mov    (%eax),%eax
  801604:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80160b:	8b 45 10             	mov    0x10(%ebp),%eax
  80160e:	01 d0                	add    %edx,%eax
  801610:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801616:	eb 0c                	jmp    801624 <strsplit+0x31>
			*string++ = 0;
  801618:	8b 45 08             	mov    0x8(%ebp),%eax
  80161b:	8d 50 01             	lea    0x1(%eax),%edx
  80161e:	89 55 08             	mov    %edx,0x8(%ebp)
  801621:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801624:	8b 45 08             	mov    0x8(%ebp),%eax
  801627:	8a 00                	mov    (%eax),%al
  801629:	84 c0                	test   %al,%al
  80162b:	74 18                	je     801645 <strsplit+0x52>
  80162d:	8b 45 08             	mov    0x8(%ebp),%eax
  801630:	8a 00                	mov    (%eax),%al
  801632:	0f be c0             	movsbl %al,%eax
  801635:	50                   	push   %eax
  801636:	ff 75 0c             	pushl  0xc(%ebp)
  801639:	e8 13 fb ff ff       	call   801151 <strchr>
  80163e:	83 c4 08             	add    $0x8,%esp
  801641:	85 c0                	test   %eax,%eax
  801643:	75 d3                	jne    801618 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801645:	8b 45 08             	mov    0x8(%ebp),%eax
  801648:	8a 00                	mov    (%eax),%al
  80164a:	84 c0                	test   %al,%al
  80164c:	74 5a                	je     8016a8 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80164e:	8b 45 14             	mov    0x14(%ebp),%eax
  801651:	8b 00                	mov    (%eax),%eax
  801653:	83 f8 0f             	cmp    $0xf,%eax
  801656:	75 07                	jne    80165f <strsplit+0x6c>
		{
			return 0;
  801658:	b8 00 00 00 00       	mov    $0x0,%eax
  80165d:	eb 66                	jmp    8016c5 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80165f:	8b 45 14             	mov    0x14(%ebp),%eax
  801662:	8b 00                	mov    (%eax),%eax
  801664:	8d 48 01             	lea    0x1(%eax),%ecx
  801667:	8b 55 14             	mov    0x14(%ebp),%edx
  80166a:	89 0a                	mov    %ecx,(%edx)
  80166c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801673:	8b 45 10             	mov    0x10(%ebp),%eax
  801676:	01 c2                	add    %eax,%edx
  801678:	8b 45 08             	mov    0x8(%ebp),%eax
  80167b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80167d:	eb 03                	jmp    801682 <strsplit+0x8f>
			string++;
  80167f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801682:	8b 45 08             	mov    0x8(%ebp),%eax
  801685:	8a 00                	mov    (%eax),%al
  801687:	84 c0                	test   %al,%al
  801689:	74 8b                	je     801616 <strsplit+0x23>
  80168b:	8b 45 08             	mov    0x8(%ebp),%eax
  80168e:	8a 00                	mov    (%eax),%al
  801690:	0f be c0             	movsbl %al,%eax
  801693:	50                   	push   %eax
  801694:	ff 75 0c             	pushl  0xc(%ebp)
  801697:	e8 b5 fa ff ff       	call   801151 <strchr>
  80169c:	83 c4 08             	add    $0x8,%esp
  80169f:	85 c0                	test   %eax,%eax
  8016a1:	74 dc                	je     80167f <strsplit+0x8c>
			string++;
	}
  8016a3:	e9 6e ff ff ff       	jmp    801616 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016a8:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8016ac:	8b 00                	mov    (%eax),%eax
  8016ae:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b8:	01 d0                	add    %edx,%eax
  8016ba:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8016c0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8016c5:	c9                   	leave  
  8016c6:	c3                   	ret    

008016c7 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016c7:	55                   	push   %ebp
  8016c8:	89 e5                	mov    %esp,%ebp
  8016ca:	57                   	push   %edi
  8016cb:	56                   	push   %esi
  8016cc:	53                   	push   %ebx
  8016cd:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016d9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016dc:	8b 7d 18             	mov    0x18(%ebp),%edi
  8016df:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8016e2:	cd 30                	int    $0x30
  8016e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8016e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8016ea:	83 c4 10             	add    $0x10,%esp
  8016ed:	5b                   	pop    %ebx
  8016ee:	5e                   	pop    %esi
  8016ef:	5f                   	pop    %edi
  8016f0:	5d                   	pop    %ebp
  8016f1:	c3                   	ret    

008016f2 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8016f2:	55                   	push   %ebp
  8016f3:	89 e5                	mov    %esp,%ebp
  8016f5:	83 ec 04             	sub    $0x4,%esp
  8016f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8016fb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8016fe:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801702:	8b 45 08             	mov    0x8(%ebp),%eax
  801705:	6a 00                	push   $0x0
  801707:	6a 00                	push   $0x0
  801709:	52                   	push   %edx
  80170a:	ff 75 0c             	pushl  0xc(%ebp)
  80170d:	50                   	push   %eax
  80170e:	6a 00                	push   $0x0
  801710:	e8 b2 ff ff ff       	call   8016c7 <syscall>
  801715:	83 c4 18             	add    $0x18,%esp
}
  801718:	90                   	nop
  801719:	c9                   	leave  
  80171a:	c3                   	ret    

0080171b <sys_cgetc>:

int
sys_cgetc(void)
{
  80171b:	55                   	push   %ebp
  80171c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80171e:	6a 00                	push   $0x0
  801720:	6a 00                	push   $0x0
  801722:	6a 00                	push   $0x0
  801724:	6a 00                	push   $0x0
  801726:	6a 00                	push   $0x0
  801728:	6a 01                	push   $0x1
  80172a:	e8 98 ff ff ff       	call   8016c7 <syscall>
  80172f:	83 c4 18             	add    $0x18,%esp
}
  801732:	c9                   	leave  
  801733:	c3                   	ret    

00801734 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801734:	55                   	push   %ebp
  801735:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801737:	8b 45 08             	mov    0x8(%ebp),%eax
  80173a:	6a 00                	push   $0x0
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	50                   	push   %eax
  801743:	6a 05                	push   $0x5
  801745:	e8 7d ff ff ff       	call   8016c7 <syscall>
  80174a:	83 c4 18             	add    $0x18,%esp
}
  80174d:	c9                   	leave  
  80174e:	c3                   	ret    

0080174f <sys_getenvid>:

int32 sys_getenvid(void)
{
  80174f:	55                   	push   %ebp
  801750:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801752:	6a 00                	push   $0x0
  801754:	6a 00                	push   $0x0
  801756:	6a 00                	push   $0x0
  801758:	6a 00                	push   $0x0
  80175a:	6a 00                	push   $0x0
  80175c:	6a 02                	push   $0x2
  80175e:	e8 64 ff ff ff       	call   8016c7 <syscall>
  801763:	83 c4 18             	add    $0x18,%esp
}
  801766:	c9                   	leave  
  801767:	c3                   	ret    

00801768 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801768:	55                   	push   %ebp
  801769:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 00                	push   $0x0
  801771:	6a 00                	push   $0x0
  801773:	6a 00                	push   $0x0
  801775:	6a 03                	push   $0x3
  801777:	e8 4b ff ff ff       	call   8016c7 <syscall>
  80177c:	83 c4 18             	add    $0x18,%esp
}
  80177f:	c9                   	leave  
  801780:	c3                   	ret    

00801781 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801781:	55                   	push   %ebp
  801782:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	6a 04                	push   $0x4
  801790:	e8 32 ff ff ff       	call   8016c7 <syscall>
  801795:	83 c4 18             	add    $0x18,%esp
}
  801798:	c9                   	leave  
  801799:	c3                   	ret    

0080179a <sys_env_exit>:


void sys_env_exit(void)
{
  80179a:	55                   	push   %ebp
  80179b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 06                	push   $0x6
  8017a9:	e8 19 ff ff ff       	call   8016c7 <syscall>
  8017ae:	83 c4 18             	add    $0x18,%esp
}
  8017b1:	90                   	nop
  8017b2:	c9                   	leave  
  8017b3:	c3                   	ret    

008017b4 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017b4:	55                   	push   %ebp
  8017b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	52                   	push   %edx
  8017c4:	50                   	push   %eax
  8017c5:	6a 07                	push   $0x7
  8017c7:	e8 fb fe ff ff       	call   8016c7 <syscall>
  8017cc:	83 c4 18             	add    $0x18,%esp
}
  8017cf:	c9                   	leave  
  8017d0:	c3                   	ret    

008017d1 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8017d1:	55                   	push   %ebp
  8017d2:	89 e5                	mov    %esp,%ebp
  8017d4:	56                   	push   %esi
  8017d5:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8017d6:	8b 75 18             	mov    0x18(%ebp),%esi
  8017d9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017dc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017df:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e5:	56                   	push   %esi
  8017e6:	53                   	push   %ebx
  8017e7:	51                   	push   %ecx
  8017e8:	52                   	push   %edx
  8017e9:	50                   	push   %eax
  8017ea:	6a 08                	push   $0x8
  8017ec:	e8 d6 fe ff ff       	call   8016c7 <syscall>
  8017f1:	83 c4 18             	add    $0x18,%esp
}
  8017f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8017f7:	5b                   	pop    %ebx
  8017f8:	5e                   	pop    %esi
  8017f9:	5d                   	pop    %ebp
  8017fa:	c3                   	ret    

008017fb <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8017fb:	55                   	push   %ebp
  8017fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8017fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801801:	8b 45 08             	mov    0x8(%ebp),%eax
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	52                   	push   %edx
  80180b:	50                   	push   %eax
  80180c:	6a 09                	push   $0x9
  80180e:	e8 b4 fe ff ff       	call   8016c7 <syscall>
  801813:	83 c4 18             	add    $0x18,%esp
}
  801816:	c9                   	leave  
  801817:	c3                   	ret    

00801818 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801818:	55                   	push   %ebp
  801819:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80181b:	6a 00                	push   $0x0
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	ff 75 0c             	pushl  0xc(%ebp)
  801824:	ff 75 08             	pushl  0x8(%ebp)
  801827:	6a 0a                	push   $0xa
  801829:	e8 99 fe ff ff       	call   8016c7 <syscall>
  80182e:	83 c4 18             	add    $0x18,%esp
}
  801831:	c9                   	leave  
  801832:	c3                   	ret    

00801833 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801833:	55                   	push   %ebp
  801834:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	6a 0b                	push   $0xb
  801842:	e8 80 fe ff ff       	call   8016c7 <syscall>
  801847:	83 c4 18             	add    $0x18,%esp
}
  80184a:	c9                   	leave  
  80184b:	c3                   	ret    

0080184c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80184c:	55                   	push   %ebp
  80184d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80184f:	6a 00                	push   $0x0
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 0c                	push   $0xc
  80185b:	e8 67 fe ff ff       	call   8016c7 <syscall>
  801860:	83 c4 18             	add    $0x18,%esp
}
  801863:	c9                   	leave  
  801864:	c3                   	ret    

00801865 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801865:	55                   	push   %ebp
  801866:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801868:	6a 00                	push   $0x0
  80186a:	6a 00                	push   $0x0
  80186c:	6a 00                	push   $0x0
  80186e:	6a 00                	push   $0x0
  801870:	6a 00                	push   $0x0
  801872:	6a 0d                	push   $0xd
  801874:	e8 4e fe ff ff       	call   8016c7 <syscall>
  801879:	83 c4 18             	add    $0x18,%esp
}
  80187c:	c9                   	leave  
  80187d:	c3                   	ret    

0080187e <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80187e:	55                   	push   %ebp
  80187f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801881:	6a 00                	push   $0x0
  801883:	6a 00                	push   $0x0
  801885:	6a 00                	push   $0x0
  801887:	ff 75 0c             	pushl  0xc(%ebp)
  80188a:	ff 75 08             	pushl  0x8(%ebp)
  80188d:	6a 11                	push   $0x11
  80188f:	e8 33 fe ff ff       	call   8016c7 <syscall>
  801894:	83 c4 18             	add    $0x18,%esp
	return;
  801897:	90                   	nop
}
  801898:	c9                   	leave  
  801899:	c3                   	ret    

0080189a <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80189a:	55                   	push   %ebp
  80189b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80189d:	6a 00                	push   $0x0
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	ff 75 0c             	pushl  0xc(%ebp)
  8018a6:	ff 75 08             	pushl  0x8(%ebp)
  8018a9:	6a 12                	push   $0x12
  8018ab:	e8 17 fe ff ff       	call   8016c7 <syscall>
  8018b0:	83 c4 18             	add    $0x18,%esp
	return ;
  8018b3:	90                   	nop
}
  8018b4:	c9                   	leave  
  8018b5:	c3                   	ret    

008018b6 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018b6:	55                   	push   %ebp
  8018b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018b9:	6a 00                	push   $0x0
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 0e                	push   $0xe
  8018c5:	e8 fd fd ff ff       	call   8016c7 <syscall>
  8018ca:	83 c4 18             	add    $0x18,%esp
}
  8018cd:	c9                   	leave  
  8018ce:	c3                   	ret    

008018cf <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8018cf:	55                   	push   %ebp
  8018d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 00                	push   $0x0
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 00                	push   $0x0
  8018da:	ff 75 08             	pushl  0x8(%ebp)
  8018dd:	6a 0f                	push   $0xf
  8018df:	e8 e3 fd ff ff       	call   8016c7 <syscall>
  8018e4:	83 c4 18             	add    $0x18,%esp
}
  8018e7:	c9                   	leave  
  8018e8:	c3                   	ret    

008018e9 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8018e9:	55                   	push   %ebp
  8018ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8018ec:	6a 00                	push   $0x0
  8018ee:	6a 00                	push   $0x0
  8018f0:	6a 00                	push   $0x0
  8018f2:	6a 00                	push   $0x0
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 10                	push   $0x10
  8018f8:	e8 ca fd ff ff       	call   8016c7 <syscall>
  8018fd:	83 c4 18             	add    $0x18,%esp
}
  801900:	90                   	nop
  801901:	c9                   	leave  
  801902:	c3                   	ret    

00801903 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801903:	55                   	push   %ebp
  801904:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801906:	6a 00                	push   $0x0
  801908:	6a 00                	push   $0x0
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	6a 00                	push   $0x0
  801910:	6a 14                	push   $0x14
  801912:	e8 b0 fd ff ff       	call   8016c7 <syscall>
  801917:	83 c4 18             	add    $0x18,%esp
}
  80191a:	90                   	nop
  80191b:	c9                   	leave  
  80191c:	c3                   	ret    

0080191d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80191d:	55                   	push   %ebp
  80191e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	6a 00                	push   $0x0
  801926:	6a 00                	push   $0x0
  801928:	6a 00                	push   $0x0
  80192a:	6a 15                	push   $0x15
  80192c:	e8 96 fd ff ff       	call   8016c7 <syscall>
  801931:	83 c4 18             	add    $0x18,%esp
}
  801934:	90                   	nop
  801935:	c9                   	leave  
  801936:	c3                   	ret    

00801937 <sys_cputc>:


void
sys_cputc(const char c)
{
  801937:	55                   	push   %ebp
  801938:	89 e5                	mov    %esp,%ebp
  80193a:	83 ec 04             	sub    $0x4,%esp
  80193d:	8b 45 08             	mov    0x8(%ebp),%eax
  801940:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801943:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801947:	6a 00                	push   $0x0
  801949:	6a 00                	push   $0x0
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	50                   	push   %eax
  801950:	6a 16                	push   $0x16
  801952:	e8 70 fd ff ff       	call   8016c7 <syscall>
  801957:	83 c4 18             	add    $0x18,%esp
}
  80195a:	90                   	nop
  80195b:	c9                   	leave  
  80195c:	c3                   	ret    

0080195d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80195d:	55                   	push   %ebp
  80195e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801960:	6a 00                	push   $0x0
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	6a 00                	push   $0x0
  801968:	6a 00                	push   $0x0
  80196a:	6a 17                	push   $0x17
  80196c:	e8 56 fd ff ff       	call   8016c7 <syscall>
  801971:	83 c4 18             	add    $0x18,%esp
}
  801974:	90                   	nop
  801975:	c9                   	leave  
  801976:	c3                   	ret    

00801977 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801977:	55                   	push   %ebp
  801978:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80197a:	8b 45 08             	mov    0x8(%ebp),%eax
  80197d:	6a 00                	push   $0x0
  80197f:	6a 00                	push   $0x0
  801981:	6a 00                	push   $0x0
  801983:	ff 75 0c             	pushl  0xc(%ebp)
  801986:	50                   	push   %eax
  801987:	6a 18                	push   $0x18
  801989:	e8 39 fd ff ff       	call   8016c7 <syscall>
  80198e:	83 c4 18             	add    $0x18,%esp
}
  801991:	c9                   	leave  
  801992:	c3                   	ret    

00801993 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801993:	55                   	push   %ebp
  801994:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801996:	8b 55 0c             	mov    0xc(%ebp),%edx
  801999:	8b 45 08             	mov    0x8(%ebp),%eax
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	52                   	push   %edx
  8019a3:	50                   	push   %eax
  8019a4:	6a 1b                	push   $0x1b
  8019a6:	e8 1c fd ff ff       	call   8016c7 <syscall>
  8019ab:	83 c4 18             	add    $0x18,%esp
}
  8019ae:	c9                   	leave  
  8019af:	c3                   	ret    

008019b0 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019b0:	55                   	push   %ebp
  8019b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b9:	6a 00                	push   $0x0
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	52                   	push   %edx
  8019c0:	50                   	push   %eax
  8019c1:	6a 19                	push   $0x19
  8019c3:	e8 ff fc ff ff       	call   8016c7 <syscall>
  8019c8:	83 c4 18             	add    $0x18,%esp
}
  8019cb:	90                   	nop
  8019cc:	c9                   	leave  
  8019cd:	c3                   	ret    

008019ce <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019ce:	55                   	push   %ebp
  8019cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	52                   	push   %edx
  8019de:	50                   	push   %eax
  8019df:	6a 1a                	push   $0x1a
  8019e1:	e8 e1 fc ff ff       	call   8016c7 <syscall>
  8019e6:	83 c4 18             	add    $0x18,%esp
}
  8019e9:	90                   	nop
  8019ea:	c9                   	leave  
  8019eb:	c3                   	ret    

008019ec <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8019ec:	55                   	push   %ebp
  8019ed:	89 e5                	mov    %esp,%ebp
  8019ef:	83 ec 04             	sub    $0x4,%esp
  8019f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f5:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8019f8:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8019fb:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8019ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801a02:	6a 00                	push   $0x0
  801a04:	51                   	push   %ecx
  801a05:	52                   	push   %edx
  801a06:	ff 75 0c             	pushl  0xc(%ebp)
  801a09:	50                   	push   %eax
  801a0a:	6a 1c                	push   $0x1c
  801a0c:	e8 b6 fc ff ff       	call   8016c7 <syscall>
  801a11:	83 c4 18             	add    $0x18,%esp
}
  801a14:	c9                   	leave  
  801a15:	c3                   	ret    

00801a16 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a16:	55                   	push   %ebp
  801a17:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a19:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1f:	6a 00                	push   $0x0
  801a21:	6a 00                	push   $0x0
  801a23:	6a 00                	push   $0x0
  801a25:	52                   	push   %edx
  801a26:	50                   	push   %eax
  801a27:	6a 1d                	push   $0x1d
  801a29:	e8 99 fc ff ff       	call   8016c7 <syscall>
  801a2e:	83 c4 18             	add    $0x18,%esp
}
  801a31:	c9                   	leave  
  801a32:	c3                   	ret    

00801a33 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a33:	55                   	push   %ebp
  801a34:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a36:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a39:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 00                	push   $0x0
  801a43:	51                   	push   %ecx
  801a44:	52                   	push   %edx
  801a45:	50                   	push   %eax
  801a46:	6a 1e                	push   $0x1e
  801a48:	e8 7a fc ff ff       	call   8016c7 <syscall>
  801a4d:	83 c4 18             	add    $0x18,%esp
}
  801a50:	c9                   	leave  
  801a51:	c3                   	ret    

00801a52 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a52:	55                   	push   %ebp
  801a53:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a55:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a58:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5b:	6a 00                	push   $0x0
  801a5d:	6a 00                	push   $0x0
  801a5f:	6a 00                	push   $0x0
  801a61:	52                   	push   %edx
  801a62:	50                   	push   %eax
  801a63:	6a 1f                	push   $0x1f
  801a65:	e8 5d fc ff ff       	call   8016c7 <syscall>
  801a6a:	83 c4 18             	add    $0x18,%esp
}
  801a6d:	c9                   	leave  
  801a6e:	c3                   	ret    

00801a6f <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801a6f:	55                   	push   %ebp
  801a70:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801a72:	6a 00                	push   $0x0
  801a74:	6a 00                	push   $0x0
  801a76:	6a 00                	push   $0x0
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 20                	push   $0x20
  801a7e:	e8 44 fc ff ff       	call   8016c7 <syscall>
  801a83:	83 c4 18             	add    $0x18,%esp
}
  801a86:	c9                   	leave  
  801a87:	c3                   	ret    

00801a88 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801a88:	55                   	push   %ebp
  801a89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801a8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8e:	6a 00                	push   $0x0
  801a90:	ff 75 14             	pushl  0x14(%ebp)
  801a93:	ff 75 10             	pushl  0x10(%ebp)
  801a96:	ff 75 0c             	pushl  0xc(%ebp)
  801a99:	50                   	push   %eax
  801a9a:	6a 21                	push   $0x21
  801a9c:	e8 26 fc ff ff       	call   8016c7 <syscall>
  801aa1:	83 c4 18             	add    $0x18,%esp
}
  801aa4:	c9                   	leave  
  801aa5:	c3                   	ret    

00801aa6 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801aa6:	55                   	push   %ebp
  801aa7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  801aac:	6a 00                	push   $0x0
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	50                   	push   %eax
  801ab5:	6a 22                	push   $0x22
  801ab7:	e8 0b fc ff ff       	call   8016c7 <syscall>
  801abc:	83 c4 18             	add    $0x18,%esp
}
  801abf:	90                   	nop
  801ac0:	c9                   	leave  
  801ac1:	c3                   	ret    

00801ac2 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801ac2:	55                   	push   %ebp
  801ac3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801ac5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac8:	6a 00                	push   $0x0
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	50                   	push   %eax
  801ad1:	6a 23                	push   $0x23
  801ad3:	e8 ef fb ff ff       	call   8016c7 <syscall>
  801ad8:	83 c4 18             	add    $0x18,%esp
}
  801adb:	90                   	nop
  801adc:	c9                   	leave  
  801add:	c3                   	ret    

00801ade <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801ade:	55                   	push   %ebp
  801adf:	89 e5                	mov    %esp,%ebp
  801ae1:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801ae4:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ae7:	8d 50 04             	lea    0x4(%eax),%edx
  801aea:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801aed:	6a 00                	push   $0x0
  801aef:	6a 00                	push   $0x0
  801af1:	6a 00                	push   $0x0
  801af3:	52                   	push   %edx
  801af4:	50                   	push   %eax
  801af5:	6a 24                	push   $0x24
  801af7:	e8 cb fb ff ff       	call   8016c7 <syscall>
  801afc:	83 c4 18             	add    $0x18,%esp
	return result;
  801aff:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b02:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b05:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b08:	89 01                	mov    %eax,(%ecx)
  801b0a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b10:	c9                   	leave  
  801b11:	c2 04 00             	ret    $0x4

00801b14 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b14:	55                   	push   %ebp
  801b15:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b17:	6a 00                	push   $0x0
  801b19:	6a 00                	push   $0x0
  801b1b:	ff 75 10             	pushl  0x10(%ebp)
  801b1e:	ff 75 0c             	pushl  0xc(%ebp)
  801b21:	ff 75 08             	pushl  0x8(%ebp)
  801b24:	6a 13                	push   $0x13
  801b26:	e8 9c fb ff ff       	call   8016c7 <syscall>
  801b2b:	83 c4 18             	add    $0x18,%esp
	return ;
  801b2e:	90                   	nop
}
  801b2f:	c9                   	leave  
  801b30:	c3                   	ret    

00801b31 <sys_rcr2>:
uint32 sys_rcr2()
{
  801b31:	55                   	push   %ebp
  801b32:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b34:	6a 00                	push   $0x0
  801b36:	6a 00                	push   $0x0
  801b38:	6a 00                	push   $0x0
  801b3a:	6a 00                	push   $0x0
  801b3c:	6a 00                	push   $0x0
  801b3e:	6a 25                	push   $0x25
  801b40:	e8 82 fb ff ff       	call   8016c7 <syscall>
  801b45:	83 c4 18             	add    $0x18,%esp
}
  801b48:	c9                   	leave  
  801b49:	c3                   	ret    

00801b4a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b4a:	55                   	push   %ebp
  801b4b:	89 e5                	mov    %esp,%ebp
  801b4d:	83 ec 04             	sub    $0x4,%esp
  801b50:	8b 45 08             	mov    0x8(%ebp),%eax
  801b53:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b56:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b5a:	6a 00                	push   $0x0
  801b5c:	6a 00                	push   $0x0
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 00                	push   $0x0
  801b62:	50                   	push   %eax
  801b63:	6a 26                	push   $0x26
  801b65:	e8 5d fb ff ff       	call   8016c7 <syscall>
  801b6a:	83 c4 18             	add    $0x18,%esp
	return ;
  801b6d:	90                   	nop
}
  801b6e:	c9                   	leave  
  801b6f:	c3                   	ret    

00801b70 <rsttst>:
void rsttst()
{
  801b70:	55                   	push   %ebp
  801b71:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801b73:	6a 00                	push   $0x0
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	6a 28                	push   $0x28
  801b7f:	e8 43 fb ff ff       	call   8016c7 <syscall>
  801b84:	83 c4 18             	add    $0x18,%esp
	return ;
  801b87:	90                   	nop
}
  801b88:	c9                   	leave  
  801b89:	c3                   	ret    

00801b8a <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801b8a:	55                   	push   %ebp
  801b8b:	89 e5                	mov    %esp,%ebp
  801b8d:	83 ec 04             	sub    $0x4,%esp
  801b90:	8b 45 14             	mov    0x14(%ebp),%eax
  801b93:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801b96:	8b 55 18             	mov    0x18(%ebp),%edx
  801b99:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b9d:	52                   	push   %edx
  801b9e:	50                   	push   %eax
  801b9f:	ff 75 10             	pushl  0x10(%ebp)
  801ba2:	ff 75 0c             	pushl  0xc(%ebp)
  801ba5:	ff 75 08             	pushl  0x8(%ebp)
  801ba8:	6a 27                	push   $0x27
  801baa:	e8 18 fb ff ff       	call   8016c7 <syscall>
  801baf:	83 c4 18             	add    $0x18,%esp
	return ;
  801bb2:	90                   	nop
}
  801bb3:	c9                   	leave  
  801bb4:	c3                   	ret    

00801bb5 <chktst>:
void chktst(uint32 n)
{
  801bb5:	55                   	push   %ebp
  801bb6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801bb8:	6a 00                	push   $0x0
  801bba:	6a 00                	push   $0x0
  801bbc:	6a 00                	push   $0x0
  801bbe:	6a 00                	push   $0x0
  801bc0:	ff 75 08             	pushl  0x8(%ebp)
  801bc3:	6a 29                	push   $0x29
  801bc5:	e8 fd fa ff ff       	call   8016c7 <syscall>
  801bca:	83 c4 18             	add    $0x18,%esp
	return ;
  801bcd:	90                   	nop
}
  801bce:	c9                   	leave  
  801bcf:	c3                   	ret    

00801bd0 <inctst>:

void inctst()
{
  801bd0:	55                   	push   %ebp
  801bd1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801bd3:	6a 00                	push   $0x0
  801bd5:	6a 00                	push   $0x0
  801bd7:	6a 00                	push   $0x0
  801bd9:	6a 00                	push   $0x0
  801bdb:	6a 00                	push   $0x0
  801bdd:	6a 2a                	push   $0x2a
  801bdf:	e8 e3 fa ff ff       	call   8016c7 <syscall>
  801be4:	83 c4 18             	add    $0x18,%esp
	return ;
  801be7:	90                   	nop
}
  801be8:	c9                   	leave  
  801be9:	c3                   	ret    

00801bea <gettst>:
uint32 gettst()
{
  801bea:	55                   	push   %ebp
  801beb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801bed:	6a 00                	push   $0x0
  801bef:	6a 00                	push   $0x0
  801bf1:	6a 00                	push   $0x0
  801bf3:	6a 00                	push   $0x0
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 2b                	push   $0x2b
  801bf9:	e8 c9 fa ff ff       	call   8016c7 <syscall>
  801bfe:	83 c4 18             	add    $0x18,%esp
}
  801c01:	c9                   	leave  
  801c02:	c3                   	ret    

00801c03 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c03:	55                   	push   %ebp
  801c04:	89 e5                	mov    %esp,%ebp
  801c06:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c09:	6a 00                	push   $0x0
  801c0b:	6a 00                	push   $0x0
  801c0d:	6a 00                	push   $0x0
  801c0f:	6a 00                	push   $0x0
  801c11:	6a 00                	push   $0x0
  801c13:	6a 2c                	push   $0x2c
  801c15:	e8 ad fa ff ff       	call   8016c7 <syscall>
  801c1a:	83 c4 18             	add    $0x18,%esp
  801c1d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c20:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c24:	75 07                	jne    801c2d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c26:	b8 01 00 00 00       	mov    $0x1,%eax
  801c2b:	eb 05                	jmp    801c32 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c2d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c32:	c9                   	leave  
  801c33:	c3                   	ret    

00801c34 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c34:	55                   	push   %ebp
  801c35:	89 e5                	mov    %esp,%ebp
  801c37:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c3a:	6a 00                	push   $0x0
  801c3c:	6a 00                	push   $0x0
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 00                	push   $0x0
  801c42:	6a 00                	push   $0x0
  801c44:	6a 2c                	push   $0x2c
  801c46:	e8 7c fa ff ff       	call   8016c7 <syscall>
  801c4b:	83 c4 18             	add    $0x18,%esp
  801c4e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c51:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c55:	75 07                	jne    801c5e <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c57:	b8 01 00 00 00       	mov    $0x1,%eax
  801c5c:	eb 05                	jmp    801c63 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c5e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c63:	c9                   	leave  
  801c64:	c3                   	ret    

00801c65 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c65:	55                   	push   %ebp
  801c66:	89 e5                	mov    %esp,%ebp
  801c68:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c6b:	6a 00                	push   $0x0
  801c6d:	6a 00                	push   $0x0
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 00                	push   $0x0
  801c73:	6a 00                	push   $0x0
  801c75:	6a 2c                	push   $0x2c
  801c77:	e8 4b fa ff ff       	call   8016c7 <syscall>
  801c7c:	83 c4 18             	add    $0x18,%esp
  801c7f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801c82:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801c86:	75 07                	jne    801c8f <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801c88:	b8 01 00 00 00       	mov    $0x1,%eax
  801c8d:	eb 05                	jmp    801c94 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801c8f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c94:	c9                   	leave  
  801c95:	c3                   	ret    

00801c96 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801c96:	55                   	push   %ebp
  801c97:	89 e5                	mov    %esp,%ebp
  801c99:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c9c:	6a 00                	push   $0x0
  801c9e:	6a 00                	push   $0x0
  801ca0:	6a 00                	push   $0x0
  801ca2:	6a 00                	push   $0x0
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 2c                	push   $0x2c
  801ca8:	e8 1a fa ff ff       	call   8016c7 <syscall>
  801cad:	83 c4 18             	add    $0x18,%esp
  801cb0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801cb3:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801cb7:	75 07                	jne    801cc0 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801cb9:	b8 01 00 00 00       	mov    $0x1,%eax
  801cbe:	eb 05                	jmp    801cc5 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801cc0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cc5:	c9                   	leave  
  801cc6:	c3                   	ret    

00801cc7 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801cc7:	55                   	push   %ebp
  801cc8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 00                	push   $0x0
  801cd0:	6a 00                	push   $0x0
  801cd2:	ff 75 08             	pushl  0x8(%ebp)
  801cd5:	6a 2d                	push   $0x2d
  801cd7:	e8 eb f9 ff ff       	call   8016c7 <syscall>
  801cdc:	83 c4 18             	add    $0x18,%esp
	return ;
  801cdf:	90                   	nop
}
  801ce0:	c9                   	leave  
  801ce1:	c3                   	ret    

00801ce2 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801ce2:	55                   	push   %ebp
  801ce3:	89 e5                	mov    %esp,%ebp
  801ce5:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801ce6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ce9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801cec:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cef:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf2:	6a 00                	push   $0x0
  801cf4:	53                   	push   %ebx
  801cf5:	51                   	push   %ecx
  801cf6:	52                   	push   %edx
  801cf7:	50                   	push   %eax
  801cf8:	6a 2e                	push   $0x2e
  801cfa:	e8 c8 f9 ff ff       	call   8016c7 <syscall>
  801cff:	83 c4 18             	add    $0x18,%esp
}
  801d02:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d05:	c9                   	leave  
  801d06:	c3                   	ret    

00801d07 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d07:	55                   	push   %ebp
  801d08:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d0a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d0d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d10:	6a 00                	push   $0x0
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	52                   	push   %edx
  801d17:	50                   	push   %eax
  801d18:	6a 2f                	push   $0x2f
  801d1a:	e8 a8 f9 ff ff       	call   8016c7 <syscall>
  801d1f:	83 c4 18             	add    $0x18,%esp
}
  801d22:	c9                   	leave  
  801d23:	c3                   	ret    

00801d24 <__udivdi3>:
  801d24:	55                   	push   %ebp
  801d25:	57                   	push   %edi
  801d26:	56                   	push   %esi
  801d27:	53                   	push   %ebx
  801d28:	83 ec 1c             	sub    $0x1c,%esp
  801d2b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d2f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d33:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d37:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d3b:	89 ca                	mov    %ecx,%edx
  801d3d:	89 f8                	mov    %edi,%eax
  801d3f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d43:	85 f6                	test   %esi,%esi
  801d45:	75 2d                	jne    801d74 <__udivdi3+0x50>
  801d47:	39 cf                	cmp    %ecx,%edi
  801d49:	77 65                	ja     801db0 <__udivdi3+0x8c>
  801d4b:	89 fd                	mov    %edi,%ebp
  801d4d:	85 ff                	test   %edi,%edi
  801d4f:	75 0b                	jne    801d5c <__udivdi3+0x38>
  801d51:	b8 01 00 00 00       	mov    $0x1,%eax
  801d56:	31 d2                	xor    %edx,%edx
  801d58:	f7 f7                	div    %edi
  801d5a:	89 c5                	mov    %eax,%ebp
  801d5c:	31 d2                	xor    %edx,%edx
  801d5e:	89 c8                	mov    %ecx,%eax
  801d60:	f7 f5                	div    %ebp
  801d62:	89 c1                	mov    %eax,%ecx
  801d64:	89 d8                	mov    %ebx,%eax
  801d66:	f7 f5                	div    %ebp
  801d68:	89 cf                	mov    %ecx,%edi
  801d6a:	89 fa                	mov    %edi,%edx
  801d6c:	83 c4 1c             	add    $0x1c,%esp
  801d6f:	5b                   	pop    %ebx
  801d70:	5e                   	pop    %esi
  801d71:	5f                   	pop    %edi
  801d72:	5d                   	pop    %ebp
  801d73:	c3                   	ret    
  801d74:	39 ce                	cmp    %ecx,%esi
  801d76:	77 28                	ja     801da0 <__udivdi3+0x7c>
  801d78:	0f bd fe             	bsr    %esi,%edi
  801d7b:	83 f7 1f             	xor    $0x1f,%edi
  801d7e:	75 40                	jne    801dc0 <__udivdi3+0x9c>
  801d80:	39 ce                	cmp    %ecx,%esi
  801d82:	72 0a                	jb     801d8e <__udivdi3+0x6a>
  801d84:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d88:	0f 87 9e 00 00 00    	ja     801e2c <__udivdi3+0x108>
  801d8e:	b8 01 00 00 00       	mov    $0x1,%eax
  801d93:	89 fa                	mov    %edi,%edx
  801d95:	83 c4 1c             	add    $0x1c,%esp
  801d98:	5b                   	pop    %ebx
  801d99:	5e                   	pop    %esi
  801d9a:	5f                   	pop    %edi
  801d9b:	5d                   	pop    %ebp
  801d9c:	c3                   	ret    
  801d9d:	8d 76 00             	lea    0x0(%esi),%esi
  801da0:	31 ff                	xor    %edi,%edi
  801da2:	31 c0                	xor    %eax,%eax
  801da4:	89 fa                	mov    %edi,%edx
  801da6:	83 c4 1c             	add    $0x1c,%esp
  801da9:	5b                   	pop    %ebx
  801daa:	5e                   	pop    %esi
  801dab:	5f                   	pop    %edi
  801dac:	5d                   	pop    %ebp
  801dad:	c3                   	ret    
  801dae:	66 90                	xchg   %ax,%ax
  801db0:	89 d8                	mov    %ebx,%eax
  801db2:	f7 f7                	div    %edi
  801db4:	31 ff                	xor    %edi,%edi
  801db6:	89 fa                	mov    %edi,%edx
  801db8:	83 c4 1c             	add    $0x1c,%esp
  801dbb:	5b                   	pop    %ebx
  801dbc:	5e                   	pop    %esi
  801dbd:	5f                   	pop    %edi
  801dbe:	5d                   	pop    %ebp
  801dbf:	c3                   	ret    
  801dc0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801dc5:	89 eb                	mov    %ebp,%ebx
  801dc7:	29 fb                	sub    %edi,%ebx
  801dc9:	89 f9                	mov    %edi,%ecx
  801dcb:	d3 e6                	shl    %cl,%esi
  801dcd:	89 c5                	mov    %eax,%ebp
  801dcf:	88 d9                	mov    %bl,%cl
  801dd1:	d3 ed                	shr    %cl,%ebp
  801dd3:	89 e9                	mov    %ebp,%ecx
  801dd5:	09 f1                	or     %esi,%ecx
  801dd7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ddb:	89 f9                	mov    %edi,%ecx
  801ddd:	d3 e0                	shl    %cl,%eax
  801ddf:	89 c5                	mov    %eax,%ebp
  801de1:	89 d6                	mov    %edx,%esi
  801de3:	88 d9                	mov    %bl,%cl
  801de5:	d3 ee                	shr    %cl,%esi
  801de7:	89 f9                	mov    %edi,%ecx
  801de9:	d3 e2                	shl    %cl,%edx
  801deb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801def:	88 d9                	mov    %bl,%cl
  801df1:	d3 e8                	shr    %cl,%eax
  801df3:	09 c2                	or     %eax,%edx
  801df5:	89 d0                	mov    %edx,%eax
  801df7:	89 f2                	mov    %esi,%edx
  801df9:	f7 74 24 0c          	divl   0xc(%esp)
  801dfd:	89 d6                	mov    %edx,%esi
  801dff:	89 c3                	mov    %eax,%ebx
  801e01:	f7 e5                	mul    %ebp
  801e03:	39 d6                	cmp    %edx,%esi
  801e05:	72 19                	jb     801e20 <__udivdi3+0xfc>
  801e07:	74 0b                	je     801e14 <__udivdi3+0xf0>
  801e09:	89 d8                	mov    %ebx,%eax
  801e0b:	31 ff                	xor    %edi,%edi
  801e0d:	e9 58 ff ff ff       	jmp    801d6a <__udivdi3+0x46>
  801e12:	66 90                	xchg   %ax,%ax
  801e14:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e18:	89 f9                	mov    %edi,%ecx
  801e1a:	d3 e2                	shl    %cl,%edx
  801e1c:	39 c2                	cmp    %eax,%edx
  801e1e:	73 e9                	jae    801e09 <__udivdi3+0xe5>
  801e20:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e23:	31 ff                	xor    %edi,%edi
  801e25:	e9 40 ff ff ff       	jmp    801d6a <__udivdi3+0x46>
  801e2a:	66 90                	xchg   %ax,%ax
  801e2c:	31 c0                	xor    %eax,%eax
  801e2e:	e9 37 ff ff ff       	jmp    801d6a <__udivdi3+0x46>
  801e33:	90                   	nop

00801e34 <__umoddi3>:
  801e34:	55                   	push   %ebp
  801e35:	57                   	push   %edi
  801e36:	56                   	push   %esi
  801e37:	53                   	push   %ebx
  801e38:	83 ec 1c             	sub    $0x1c,%esp
  801e3b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e3f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e43:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e47:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e4b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e4f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e53:	89 f3                	mov    %esi,%ebx
  801e55:	89 fa                	mov    %edi,%edx
  801e57:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e5b:	89 34 24             	mov    %esi,(%esp)
  801e5e:	85 c0                	test   %eax,%eax
  801e60:	75 1a                	jne    801e7c <__umoddi3+0x48>
  801e62:	39 f7                	cmp    %esi,%edi
  801e64:	0f 86 a2 00 00 00    	jbe    801f0c <__umoddi3+0xd8>
  801e6a:	89 c8                	mov    %ecx,%eax
  801e6c:	89 f2                	mov    %esi,%edx
  801e6e:	f7 f7                	div    %edi
  801e70:	89 d0                	mov    %edx,%eax
  801e72:	31 d2                	xor    %edx,%edx
  801e74:	83 c4 1c             	add    $0x1c,%esp
  801e77:	5b                   	pop    %ebx
  801e78:	5e                   	pop    %esi
  801e79:	5f                   	pop    %edi
  801e7a:	5d                   	pop    %ebp
  801e7b:	c3                   	ret    
  801e7c:	39 f0                	cmp    %esi,%eax
  801e7e:	0f 87 ac 00 00 00    	ja     801f30 <__umoddi3+0xfc>
  801e84:	0f bd e8             	bsr    %eax,%ebp
  801e87:	83 f5 1f             	xor    $0x1f,%ebp
  801e8a:	0f 84 ac 00 00 00    	je     801f3c <__umoddi3+0x108>
  801e90:	bf 20 00 00 00       	mov    $0x20,%edi
  801e95:	29 ef                	sub    %ebp,%edi
  801e97:	89 fe                	mov    %edi,%esi
  801e99:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e9d:	89 e9                	mov    %ebp,%ecx
  801e9f:	d3 e0                	shl    %cl,%eax
  801ea1:	89 d7                	mov    %edx,%edi
  801ea3:	89 f1                	mov    %esi,%ecx
  801ea5:	d3 ef                	shr    %cl,%edi
  801ea7:	09 c7                	or     %eax,%edi
  801ea9:	89 e9                	mov    %ebp,%ecx
  801eab:	d3 e2                	shl    %cl,%edx
  801ead:	89 14 24             	mov    %edx,(%esp)
  801eb0:	89 d8                	mov    %ebx,%eax
  801eb2:	d3 e0                	shl    %cl,%eax
  801eb4:	89 c2                	mov    %eax,%edx
  801eb6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eba:	d3 e0                	shl    %cl,%eax
  801ebc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ec0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ec4:	89 f1                	mov    %esi,%ecx
  801ec6:	d3 e8                	shr    %cl,%eax
  801ec8:	09 d0                	or     %edx,%eax
  801eca:	d3 eb                	shr    %cl,%ebx
  801ecc:	89 da                	mov    %ebx,%edx
  801ece:	f7 f7                	div    %edi
  801ed0:	89 d3                	mov    %edx,%ebx
  801ed2:	f7 24 24             	mull   (%esp)
  801ed5:	89 c6                	mov    %eax,%esi
  801ed7:	89 d1                	mov    %edx,%ecx
  801ed9:	39 d3                	cmp    %edx,%ebx
  801edb:	0f 82 87 00 00 00    	jb     801f68 <__umoddi3+0x134>
  801ee1:	0f 84 91 00 00 00    	je     801f78 <__umoddi3+0x144>
  801ee7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801eeb:	29 f2                	sub    %esi,%edx
  801eed:	19 cb                	sbb    %ecx,%ebx
  801eef:	89 d8                	mov    %ebx,%eax
  801ef1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ef5:	d3 e0                	shl    %cl,%eax
  801ef7:	89 e9                	mov    %ebp,%ecx
  801ef9:	d3 ea                	shr    %cl,%edx
  801efb:	09 d0                	or     %edx,%eax
  801efd:	89 e9                	mov    %ebp,%ecx
  801eff:	d3 eb                	shr    %cl,%ebx
  801f01:	89 da                	mov    %ebx,%edx
  801f03:	83 c4 1c             	add    $0x1c,%esp
  801f06:	5b                   	pop    %ebx
  801f07:	5e                   	pop    %esi
  801f08:	5f                   	pop    %edi
  801f09:	5d                   	pop    %ebp
  801f0a:	c3                   	ret    
  801f0b:	90                   	nop
  801f0c:	89 fd                	mov    %edi,%ebp
  801f0e:	85 ff                	test   %edi,%edi
  801f10:	75 0b                	jne    801f1d <__umoddi3+0xe9>
  801f12:	b8 01 00 00 00       	mov    $0x1,%eax
  801f17:	31 d2                	xor    %edx,%edx
  801f19:	f7 f7                	div    %edi
  801f1b:	89 c5                	mov    %eax,%ebp
  801f1d:	89 f0                	mov    %esi,%eax
  801f1f:	31 d2                	xor    %edx,%edx
  801f21:	f7 f5                	div    %ebp
  801f23:	89 c8                	mov    %ecx,%eax
  801f25:	f7 f5                	div    %ebp
  801f27:	89 d0                	mov    %edx,%eax
  801f29:	e9 44 ff ff ff       	jmp    801e72 <__umoddi3+0x3e>
  801f2e:	66 90                	xchg   %ax,%ax
  801f30:	89 c8                	mov    %ecx,%eax
  801f32:	89 f2                	mov    %esi,%edx
  801f34:	83 c4 1c             	add    $0x1c,%esp
  801f37:	5b                   	pop    %ebx
  801f38:	5e                   	pop    %esi
  801f39:	5f                   	pop    %edi
  801f3a:	5d                   	pop    %ebp
  801f3b:	c3                   	ret    
  801f3c:	3b 04 24             	cmp    (%esp),%eax
  801f3f:	72 06                	jb     801f47 <__umoddi3+0x113>
  801f41:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f45:	77 0f                	ja     801f56 <__umoddi3+0x122>
  801f47:	89 f2                	mov    %esi,%edx
  801f49:	29 f9                	sub    %edi,%ecx
  801f4b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f4f:	89 14 24             	mov    %edx,(%esp)
  801f52:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f56:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f5a:	8b 14 24             	mov    (%esp),%edx
  801f5d:	83 c4 1c             	add    $0x1c,%esp
  801f60:	5b                   	pop    %ebx
  801f61:	5e                   	pop    %esi
  801f62:	5f                   	pop    %edi
  801f63:	5d                   	pop    %ebp
  801f64:	c3                   	ret    
  801f65:	8d 76 00             	lea    0x0(%esi),%esi
  801f68:	2b 04 24             	sub    (%esp),%eax
  801f6b:	19 fa                	sbb    %edi,%edx
  801f6d:	89 d1                	mov    %edx,%ecx
  801f6f:	89 c6                	mov    %eax,%esi
  801f71:	e9 71 ff ff ff       	jmp    801ee7 <__umoddi3+0xb3>
  801f76:	66 90                	xchg   %ax,%ax
  801f78:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f7c:	72 ea                	jb     801f68 <__umoddi3+0x134>
  801f7e:	89 d9                	mov    %ebx,%ecx
  801f80:	e9 62 ff ff ff       	jmp    801ee7 <__umoddi3+0xb3>
