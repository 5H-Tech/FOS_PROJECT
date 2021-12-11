
obj/user/tst_page_replacement_clock:     file format elf32-i386


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
  800031:	e8 91 04 00 00       	call   8004c7 <libmain>
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
  800060:	68 00 1f 80 00       	push   $0x801f00
  800065:	6a 15                	push   $0x15
  800067:	68 44 1f 80 00       	push   $0x801f44
  80006c:	e8 9b 05 00 00       	call   80060c <_panic>
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
  800096:	68 00 1f 80 00       	push   $0x801f00
  80009b:	6a 16                	push   $0x16
  80009d:	68 44 1f 80 00       	push   $0x801f44
  8000a2:	e8 65 05 00 00       	call   80060c <_panic>
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
  8000cc:	68 00 1f 80 00       	push   $0x801f00
  8000d1:	6a 17                	push   $0x17
  8000d3:	68 44 1f 80 00       	push   $0x801f44
  8000d8:	e8 2f 05 00 00       	call   80060c <_panic>
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
  800102:	68 00 1f 80 00       	push   $0x801f00
  800107:	6a 18                	push   $0x18
  800109:	68 44 1f 80 00       	push   $0x801f44
  80010e:	e8 f9 04 00 00       	call   80060c <_panic>
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
  800138:	68 00 1f 80 00       	push   $0x801f00
  80013d:	6a 19                	push   $0x19
  80013f:	68 44 1f 80 00       	push   $0x801f44
  800144:	e8 c3 04 00 00       	call   80060c <_panic>
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
  80016e:	68 00 1f 80 00       	push   $0x801f00
  800173:	6a 1a                	push   $0x1a
  800175:	68 44 1f 80 00       	push   $0x801f44
  80017a:	e8 8d 04 00 00       	call   80060c <_panic>
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
  8001a4:	68 00 1f 80 00       	push   $0x801f00
  8001a9:	6a 1b                	push   $0x1b
  8001ab:	68 44 1f 80 00       	push   $0x801f44
  8001b0:	e8 57 04 00 00       	call   80060c <_panic>
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
  8001da:	68 00 1f 80 00       	push   $0x801f00
  8001df:	6a 1c                	push   $0x1c
  8001e1:	68 44 1f 80 00       	push   $0x801f44
  8001e6:	e8 21 04 00 00       	call   80060c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001eb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001f6:	83 e8 80             	sub    $0xffffff80,%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8001fe:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800201:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800206:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80020b:	74 14                	je     800221 <_main+0x1e9>
  80020d:	83 ec 04             	sub    $0x4,%esp
  800210:	68 00 1f 80 00       	push   $0x801f00
  800215:	6a 1d                	push   $0x1d
  800217:	68 44 1f 80 00       	push   $0x801f44
  80021c:	e8 eb 03 00 00       	call   80060c <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  800221:	a1 20 30 80 00       	mov    0x803020,%eax
  800226:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  80022c:	85 c0                	test   %eax,%eax
  80022e:	74 14                	je     800244 <_main+0x20c>
  800230:	83 ec 04             	sub    $0x4,%esp
  800233:	68 68 1f 80 00       	push   $0x801f68
  800238:	6a 1e                	push   $0x1e
  80023a:	68 44 1f 80 00       	push   $0x801f44
  80023f:	e8 c8 03 00 00       	call   80060c <_panic>
	}

	int freePages = sys_calculate_free_frames();
  800244:	e8 5b 15 00 00       	call   8017a4 <sys_calculate_free_frames>
  800249:	89 45 cc             	mov    %eax,-0x34(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  80024c:	e8 d6 15 00 00       	call   801827 <sys_pf_calculate_allocated_pages>
  800251:	89 45 c8             	mov    %eax,-0x38(%ebp)

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  800254:	a0 3f e0 80 00       	mov    0x80e03f,%al
  800259:	88 45 c7             	mov    %al,-0x39(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  80025c:	a0 3f f0 80 00       	mov    0x80f03f,%al
  800261:	88 45 c6             	mov    %al,-0x3a(%ebp)

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800264:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80026b:	eb 37                	jmp    8002a4 <_main+0x26c>
	{
		arr[i] = -1 ;
  80026d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800270:	05 40 30 80 00       	add    $0x803040,%eax
  800275:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  800278:	a1 04 30 80 00       	mov    0x803004,%eax
  80027d:	8b 15 00 30 80 00    	mov    0x803000,%edx
  800283:	8a 12                	mov    (%edx),%dl
  800285:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  800287:	a1 00 30 80 00       	mov    0x803000,%eax
  80028c:	40                   	inc    %eax
  80028d:	a3 00 30 80 00       	mov    %eax,0x803000
  800292:	a1 04 30 80 00       	mov    0x803004,%eax
  800297:	40                   	inc    %eax
  800298:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1] ;
	char garbage2 = arr[PAGE_SIZE*12-1] ;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  80029d:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  8002a4:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  8002ab:	7e c0                	jle    80026d <_main+0x235>

	//===================

	//cprintf("Checking PAGE CLOCK algorithm... \n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("Page clock algo failed.. trace it by printing WS before and after page fault");
  8002ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002b8:	8b 00                	mov    (%eax),%eax
  8002ba:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8002bd:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8002c0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002c5:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  8002ca:	74 14                	je     8002e0 <_main+0x2a8>
  8002cc:	83 ec 04             	sub    $0x4,%esp
  8002cf:	68 b0 1f 80 00       	push   $0x801fb0
  8002d4:	6a 3a                	push   $0x3a
  8002d6:	68 44 1f 80 00       	push   $0x801f44
  8002db:	e8 2c 03 00 00       	call   80060c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x80c000)  panic("Page clock algo failed.. trace it by printing WS before and after page fault");
  8002e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e5:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002eb:	83 c0 10             	add    $0x10,%eax
  8002ee:	8b 00                	mov    (%eax),%eax
  8002f0:	89 45 bc             	mov    %eax,-0x44(%ebp)
  8002f3:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8002f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002fb:	3d 00 c0 80 00       	cmp    $0x80c000,%eax
  800300:	74 14                	je     800316 <_main+0x2de>
  800302:	83 ec 04             	sub    $0x4,%esp
  800305:	68 b0 1f 80 00       	push   $0x801fb0
  80030a:	6a 3b                	push   $0x3b
  80030c:	68 44 1f 80 00       	push   $0x801f44
  800311:	e8 f6 02 00 00       	call   80060c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x803000)  panic("Page clock algo failed.. trace it by printing WS before and after page fault");
  800316:	a1 20 30 80 00       	mov    0x803020,%eax
  80031b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800321:	83 c0 20             	add    $0x20,%eax
  800324:	8b 00                	mov    (%eax),%eax
  800326:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800329:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80032c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800331:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800336:	74 14                	je     80034c <_main+0x314>
  800338:	83 ec 04             	sub    $0x4,%esp
  80033b:	68 b0 1f 80 00       	push   $0x801fb0
  800340:	6a 3c                	push   $0x3c
  800342:	68 44 1f 80 00       	push   $0x801f44
  800347:	e8 c0 02 00 00       	call   80060c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x804000)  panic("Page clock algo failed.. trace it by printing WS before and after page fault");
  80034c:	a1 20 30 80 00       	mov    0x803020,%eax
  800351:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800357:	83 c0 30             	add    $0x30,%eax
  80035a:	8b 00                	mov    (%eax),%eax
  80035c:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  80035f:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800362:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800367:	3d 00 40 80 00       	cmp    $0x804000,%eax
  80036c:	74 14                	je     800382 <_main+0x34a>
  80036e:	83 ec 04             	sub    $0x4,%esp
  800371:	68 b0 1f 80 00       	push   $0x801fb0
  800376:	6a 3d                	push   $0x3d
  800378:	68 44 1f 80 00       	push   $0x801f44
  80037d:	e8 8a 02 00 00       	call   80060c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x809000)  panic("Page clock algo failed.. trace it by printing WS before and after page fault");
  800382:	a1 20 30 80 00       	mov    0x803020,%eax
  800387:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80038d:	83 c0 40             	add    $0x40,%eax
  800390:	8b 00                	mov    (%eax),%eax
  800392:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800395:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800398:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80039d:	3d 00 90 80 00       	cmp    $0x809000,%eax
  8003a2:	74 14                	je     8003b8 <_main+0x380>
  8003a4:	83 ec 04             	sub    $0x4,%esp
  8003a7:	68 b0 1f 80 00       	push   $0x801fb0
  8003ac:	6a 3e                	push   $0x3e
  8003ae:	68 44 1f 80 00       	push   $0x801f44
  8003b3:	e8 54 02 00 00       	call   80060c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x80a000)  panic("Page clock algo failed.. trace it by printing WS before and after page fault");
  8003b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8003bd:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003c3:	83 c0 50             	add    $0x50,%eax
  8003c6:	8b 00                	mov    (%eax),%eax
  8003c8:	89 45 ac             	mov    %eax,-0x54(%ebp)
  8003cb:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8003ce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003d3:	3d 00 a0 80 00       	cmp    $0x80a000,%eax
  8003d8:	74 14                	je     8003ee <_main+0x3b6>
  8003da:	83 ec 04             	sub    $0x4,%esp
  8003dd:	68 b0 1f 80 00       	push   $0x801fb0
  8003e2:	6a 3f                	push   $0x3f
  8003e4:	68 44 1f 80 00       	push   $0x801f44
  8003e9:	e8 1e 02 00 00       	call   80060c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x80b000)  panic("Page clock algo failed.. trace it by printing WS before and after page fault");
  8003ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003f9:	83 c0 60             	add    $0x60,%eax
  8003fc:	8b 00                	mov    (%eax),%eax
  8003fe:	89 45 a8             	mov    %eax,-0x58(%ebp)
  800401:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800404:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800409:	3d 00 b0 80 00       	cmp    $0x80b000,%eax
  80040e:	74 14                	je     800424 <_main+0x3ec>
  800410:	83 ec 04             	sub    $0x4,%esp
  800413:	68 b0 1f 80 00       	push   $0x801fb0
  800418:	6a 40                	push   $0x40
  80041a:	68 44 1f 80 00       	push   $0x801f44
  80041f:	e8 e8 01 00 00       	call   80060c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x800000)  panic("Page clock algo failed.. trace it by printing WS before and after page fault");
  800424:	a1 20 30 80 00       	mov    0x803020,%eax
  800429:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80042f:	83 c0 70             	add    $0x70,%eax
  800432:	8b 00                	mov    (%eax),%eax
  800434:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  800437:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80043a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80043f:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800444:	74 14                	je     80045a <_main+0x422>
  800446:	83 ec 04             	sub    $0x4,%esp
  800449:	68 b0 1f 80 00       	push   $0x801fb0
  80044e:	6a 41                	push   $0x41
  800450:	68 44 1f 80 00       	push   $0x801f44
  800455:	e8 b2 01 00 00       	call   80060c <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x801000)  panic("Page clock algo failed.. trace it by printing WS before and after page fault");
  80045a:	a1 20 30 80 00       	mov    0x803020,%eax
  80045f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800465:	83 e8 80             	sub    $0xffffff80,%eax
  800468:	8b 00                	mov    (%eax),%eax
  80046a:	89 45 a0             	mov    %eax,-0x60(%ebp)
  80046d:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800470:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800475:	3d 00 10 80 00       	cmp    $0x801000,%eax
  80047a:	74 14                	je     800490 <_main+0x458>
  80047c:	83 ec 04             	sub    $0x4,%esp
  80047f:	68 b0 1f 80 00       	push   $0x801fb0
  800484:	6a 42                	push   $0x42
  800486:	68 44 1f 80 00       	push   $0x801f44
  80048b:	e8 7c 01 00 00       	call   80060c <_panic>

		if(myEnv->page_last_WS_index != 2) panic("wrong PAGE WS pointer location");
  800490:	a1 20 30 80 00       	mov    0x803020,%eax
  800495:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  80049b:	83 f8 02             	cmp    $0x2,%eax
  80049e:	74 14                	je     8004b4 <_main+0x47c>
  8004a0:	83 ec 04             	sub    $0x4,%esp
  8004a3:	68 00 20 80 00       	push   $0x802000
  8004a8:	6a 44                	push   $0x44
  8004aa:	68 44 1f 80 00       	push   $0x801f44
  8004af:	e8 58 01 00 00       	call   80060c <_panic>

	}

	cprintf("Congratulations!! test PAGE replacement [CLOCK Alg.] is completed successfully.\n");
  8004b4:	83 ec 0c             	sub    $0xc,%esp
  8004b7:	68 20 20 80 00       	push   $0x802020
  8004bc:	e8 ed 03 00 00       	call   8008ae <cprintf>
  8004c1:	83 c4 10             	add    $0x10,%esp
	return;
  8004c4:	90                   	nop
}
  8004c5:	c9                   	leave  
  8004c6:	c3                   	ret    

008004c7 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8004c7:	55                   	push   %ebp
  8004c8:	89 e5                	mov    %esp,%ebp
  8004ca:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8004cd:	e8 07 12 00 00       	call   8016d9 <sys_getenvindex>
  8004d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8004d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8004d8:	89 d0                	mov    %edx,%eax
  8004da:	c1 e0 03             	shl    $0x3,%eax
  8004dd:	01 d0                	add    %edx,%eax
  8004df:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8004e6:	01 c8                	add    %ecx,%eax
  8004e8:	01 c0                	add    %eax,%eax
  8004ea:	01 d0                	add    %edx,%eax
  8004ec:	01 c0                	add    %eax,%eax
  8004ee:	01 d0                	add    %edx,%eax
  8004f0:	89 c2                	mov    %eax,%edx
  8004f2:	c1 e2 05             	shl    $0x5,%edx
  8004f5:	29 c2                	sub    %eax,%edx
  8004f7:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8004fe:	89 c2                	mov    %eax,%edx
  800500:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800506:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80050b:	a1 20 30 80 00       	mov    0x803020,%eax
  800510:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800516:	84 c0                	test   %al,%al
  800518:	74 0f                	je     800529 <libmain+0x62>
		binaryname = myEnv->prog_name;
  80051a:	a1 20 30 80 00       	mov    0x803020,%eax
  80051f:	05 40 3c 01 00       	add    $0x13c40,%eax
  800524:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800529:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80052d:	7e 0a                	jle    800539 <libmain+0x72>
		binaryname = argv[0];
  80052f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800532:	8b 00                	mov    (%eax),%eax
  800534:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  800539:	83 ec 08             	sub    $0x8,%esp
  80053c:	ff 75 0c             	pushl  0xc(%ebp)
  80053f:	ff 75 08             	pushl  0x8(%ebp)
  800542:	e8 f1 fa ff ff       	call   800038 <_main>
  800547:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80054a:	e8 25 13 00 00       	call   801874 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80054f:	83 ec 0c             	sub    $0xc,%esp
  800552:	68 8c 20 80 00       	push   $0x80208c
  800557:	e8 52 03 00 00       	call   8008ae <cprintf>
  80055c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80055f:	a1 20 30 80 00       	mov    0x803020,%eax
  800564:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80056a:	a1 20 30 80 00       	mov    0x803020,%eax
  80056f:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800575:	83 ec 04             	sub    $0x4,%esp
  800578:	52                   	push   %edx
  800579:	50                   	push   %eax
  80057a:	68 b4 20 80 00       	push   $0x8020b4
  80057f:	e8 2a 03 00 00       	call   8008ae <cprintf>
  800584:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800587:	a1 20 30 80 00       	mov    0x803020,%eax
  80058c:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800592:	a1 20 30 80 00       	mov    0x803020,%eax
  800597:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80059d:	83 ec 04             	sub    $0x4,%esp
  8005a0:	52                   	push   %edx
  8005a1:	50                   	push   %eax
  8005a2:	68 dc 20 80 00       	push   $0x8020dc
  8005a7:	e8 02 03 00 00       	call   8008ae <cprintf>
  8005ac:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8005af:	a1 20 30 80 00       	mov    0x803020,%eax
  8005b4:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8005ba:	83 ec 08             	sub    $0x8,%esp
  8005bd:	50                   	push   %eax
  8005be:	68 1d 21 80 00       	push   $0x80211d
  8005c3:	e8 e6 02 00 00       	call   8008ae <cprintf>
  8005c8:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8005cb:	83 ec 0c             	sub    $0xc,%esp
  8005ce:	68 8c 20 80 00       	push   $0x80208c
  8005d3:	e8 d6 02 00 00       	call   8008ae <cprintf>
  8005d8:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8005db:	e8 ae 12 00 00       	call   80188e <sys_enable_interrupt>

	// exit gracefully
	exit();
  8005e0:	e8 19 00 00 00       	call   8005fe <exit>
}
  8005e5:	90                   	nop
  8005e6:	c9                   	leave  
  8005e7:	c3                   	ret    

008005e8 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8005e8:	55                   	push   %ebp
  8005e9:	89 e5                	mov    %esp,%ebp
  8005eb:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8005ee:	83 ec 0c             	sub    $0xc,%esp
  8005f1:	6a 00                	push   $0x0
  8005f3:	e8 ad 10 00 00       	call   8016a5 <sys_env_destroy>
  8005f8:	83 c4 10             	add    $0x10,%esp
}
  8005fb:	90                   	nop
  8005fc:	c9                   	leave  
  8005fd:	c3                   	ret    

008005fe <exit>:

void
exit(void)
{
  8005fe:	55                   	push   %ebp
  8005ff:	89 e5                	mov    %esp,%ebp
  800601:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800604:	e8 02 11 00 00       	call   80170b <sys_env_exit>
}
  800609:	90                   	nop
  80060a:	c9                   	leave  
  80060b:	c3                   	ret    

0080060c <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80060c:	55                   	push   %ebp
  80060d:	89 e5                	mov    %esp,%ebp
  80060f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800612:	8d 45 10             	lea    0x10(%ebp),%eax
  800615:	83 c0 04             	add    $0x4,%eax
  800618:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80061b:	a1 18 f1 80 00       	mov    0x80f118,%eax
  800620:	85 c0                	test   %eax,%eax
  800622:	74 16                	je     80063a <_panic+0x2e>
		cprintf("%s: ", argv0);
  800624:	a1 18 f1 80 00       	mov    0x80f118,%eax
  800629:	83 ec 08             	sub    $0x8,%esp
  80062c:	50                   	push   %eax
  80062d:	68 34 21 80 00       	push   $0x802134
  800632:	e8 77 02 00 00       	call   8008ae <cprintf>
  800637:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80063a:	a1 08 30 80 00       	mov    0x803008,%eax
  80063f:	ff 75 0c             	pushl  0xc(%ebp)
  800642:	ff 75 08             	pushl  0x8(%ebp)
  800645:	50                   	push   %eax
  800646:	68 39 21 80 00       	push   $0x802139
  80064b:	e8 5e 02 00 00       	call   8008ae <cprintf>
  800650:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800653:	8b 45 10             	mov    0x10(%ebp),%eax
  800656:	83 ec 08             	sub    $0x8,%esp
  800659:	ff 75 f4             	pushl  -0xc(%ebp)
  80065c:	50                   	push   %eax
  80065d:	e8 e1 01 00 00       	call   800843 <vcprintf>
  800662:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800665:	83 ec 08             	sub    $0x8,%esp
  800668:	6a 00                	push   $0x0
  80066a:	68 55 21 80 00       	push   $0x802155
  80066f:	e8 cf 01 00 00       	call   800843 <vcprintf>
  800674:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800677:	e8 82 ff ff ff       	call   8005fe <exit>

	// should not return here
	while (1) ;
  80067c:	eb fe                	jmp    80067c <_panic+0x70>

0080067e <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80067e:	55                   	push   %ebp
  80067f:	89 e5                	mov    %esp,%ebp
  800681:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800684:	a1 20 30 80 00       	mov    0x803020,%eax
  800689:	8b 50 74             	mov    0x74(%eax),%edx
  80068c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80068f:	39 c2                	cmp    %eax,%edx
  800691:	74 14                	je     8006a7 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800693:	83 ec 04             	sub    $0x4,%esp
  800696:	68 58 21 80 00       	push   $0x802158
  80069b:	6a 26                	push   $0x26
  80069d:	68 a4 21 80 00       	push   $0x8021a4
  8006a2:	e8 65 ff ff ff       	call   80060c <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8006a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8006ae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8006b5:	e9 b6 00 00 00       	jmp    800770 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8006ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006bd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c7:	01 d0                	add    %edx,%eax
  8006c9:	8b 00                	mov    (%eax),%eax
  8006cb:	85 c0                	test   %eax,%eax
  8006cd:	75 08                	jne    8006d7 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8006cf:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8006d2:	e9 96 00 00 00       	jmp    80076d <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8006d7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006de:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8006e5:	eb 5d                	jmp    800744 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8006e7:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ec:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8006f2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8006f5:	c1 e2 04             	shl    $0x4,%edx
  8006f8:	01 d0                	add    %edx,%eax
  8006fa:	8a 40 04             	mov    0x4(%eax),%al
  8006fd:	84 c0                	test   %al,%al
  8006ff:	75 40                	jne    800741 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800701:	a1 20 30 80 00       	mov    0x803020,%eax
  800706:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80070c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80070f:	c1 e2 04             	shl    $0x4,%edx
  800712:	01 d0                	add    %edx,%eax
  800714:	8b 00                	mov    (%eax),%eax
  800716:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800719:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80071c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800721:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800723:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800726:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80072d:	8b 45 08             	mov    0x8(%ebp),%eax
  800730:	01 c8                	add    %ecx,%eax
  800732:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800734:	39 c2                	cmp    %eax,%edx
  800736:	75 09                	jne    800741 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800738:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80073f:	eb 12                	jmp    800753 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800741:	ff 45 e8             	incl   -0x18(%ebp)
  800744:	a1 20 30 80 00       	mov    0x803020,%eax
  800749:	8b 50 74             	mov    0x74(%eax),%edx
  80074c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80074f:	39 c2                	cmp    %eax,%edx
  800751:	77 94                	ja     8006e7 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800753:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800757:	75 14                	jne    80076d <CheckWSWithoutLastIndex+0xef>
			panic(
  800759:	83 ec 04             	sub    $0x4,%esp
  80075c:	68 b0 21 80 00       	push   $0x8021b0
  800761:	6a 3a                	push   $0x3a
  800763:	68 a4 21 80 00       	push   $0x8021a4
  800768:	e8 9f fe ff ff       	call   80060c <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80076d:	ff 45 f0             	incl   -0x10(%ebp)
  800770:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800773:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800776:	0f 8c 3e ff ff ff    	jl     8006ba <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80077c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800783:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80078a:	eb 20                	jmp    8007ac <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80078c:	a1 20 30 80 00       	mov    0x803020,%eax
  800791:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800797:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80079a:	c1 e2 04             	shl    $0x4,%edx
  80079d:	01 d0                	add    %edx,%eax
  80079f:	8a 40 04             	mov    0x4(%eax),%al
  8007a2:	3c 01                	cmp    $0x1,%al
  8007a4:	75 03                	jne    8007a9 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8007a6:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007a9:	ff 45 e0             	incl   -0x20(%ebp)
  8007ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8007b1:	8b 50 74             	mov    0x74(%eax),%edx
  8007b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007b7:	39 c2                	cmp    %eax,%edx
  8007b9:	77 d1                	ja     80078c <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8007bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8007be:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8007c1:	74 14                	je     8007d7 <CheckWSWithoutLastIndex+0x159>
		panic(
  8007c3:	83 ec 04             	sub    $0x4,%esp
  8007c6:	68 04 22 80 00       	push   $0x802204
  8007cb:	6a 44                	push   $0x44
  8007cd:	68 a4 21 80 00       	push   $0x8021a4
  8007d2:	e8 35 fe ff ff       	call   80060c <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8007d7:	90                   	nop
  8007d8:	c9                   	leave  
  8007d9:	c3                   	ret    

008007da <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8007da:	55                   	push   %ebp
  8007db:	89 e5                	mov    %esp,%ebp
  8007dd:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8007e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007e3:	8b 00                	mov    (%eax),%eax
  8007e5:	8d 48 01             	lea    0x1(%eax),%ecx
  8007e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8007eb:	89 0a                	mov    %ecx,(%edx)
  8007ed:	8b 55 08             	mov    0x8(%ebp),%edx
  8007f0:	88 d1                	mov    %dl,%cl
  8007f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8007f5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8007f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007fc:	8b 00                	mov    (%eax),%eax
  8007fe:	3d ff 00 00 00       	cmp    $0xff,%eax
  800803:	75 2c                	jne    800831 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800805:	a0 24 30 80 00       	mov    0x803024,%al
  80080a:	0f b6 c0             	movzbl %al,%eax
  80080d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800810:	8b 12                	mov    (%edx),%edx
  800812:	89 d1                	mov    %edx,%ecx
  800814:	8b 55 0c             	mov    0xc(%ebp),%edx
  800817:	83 c2 08             	add    $0x8,%edx
  80081a:	83 ec 04             	sub    $0x4,%esp
  80081d:	50                   	push   %eax
  80081e:	51                   	push   %ecx
  80081f:	52                   	push   %edx
  800820:	e8 3e 0e 00 00       	call   801663 <sys_cputs>
  800825:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800828:	8b 45 0c             	mov    0xc(%ebp),%eax
  80082b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800831:	8b 45 0c             	mov    0xc(%ebp),%eax
  800834:	8b 40 04             	mov    0x4(%eax),%eax
  800837:	8d 50 01             	lea    0x1(%eax),%edx
  80083a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80083d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800840:	90                   	nop
  800841:	c9                   	leave  
  800842:	c3                   	ret    

00800843 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800843:	55                   	push   %ebp
  800844:	89 e5                	mov    %esp,%ebp
  800846:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80084c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800853:	00 00 00 
	b.cnt = 0;
  800856:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80085d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800860:	ff 75 0c             	pushl  0xc(%ebp)
  800863:	ff 75 08             	pushl  0x8(%ebp)
  800866:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80086c:	50                   	push   %eax
  80086d:	68 da 07 80 00       	push   $0x8007da
  800872:	e8 11 02 00 00       	call   800a88 <vprintfmt>
  800877:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80087a:	a0 24 30 80 00       	mov    0x803024,%al
  80087f:	0f b6 c0             	movzbl %al,%eax
  800882:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800888:	83 ec 04             	sub    $0x4,%esp
  80088b:	50                   	push   %eax
  80088c:	52                   	push   %edx
  80088d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800893:	83 c0 08             	add    $0x8,%eax
  800896:	50                   	push   %eax
  800897:	e8 c7 0d 00 00       	call   801663 <sys_cputs>
  80089c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80089f:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8008a6:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8008ac:	c9                   	leave  
  8008ad:	c3                   	ret    

008008ae <cprintf>:

int cprintf(const char *fmt, ...) {
  8008ae:	55                   	push   %ebp
  8008af:	89 e5                	mov    %esp,%ebp
  8008b1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8008b4:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8008bb:	8d 45 0c             	lea    0xc(%ebp),%eax
  8008be:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8008c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c4:	83 ec 08             	sub    $0x8,%esp
  8008c7:	ff 75 f4             	pushl  -0xc(%ebp)
  8008ca:	50                   	push   %eax
  8008cb:	e8 73 ff ff ff       	call   800843 <vcprintf>
  8008d0:	83 c4 10             	add    $0x10,%esp
  8008d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8008d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008d9:	c9                   	leave  
  8008da:	c3                   	ret    

008008db <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8008db:	55                   	push   %ebp
  8008dc:	89 e5                	mov    %esp,%ebp
  8008de:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8008e1:	e8 8e 0f 00 00       	call   801874 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8008e6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8008e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8008ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ef:	83 ec 08             	sub    $0x8,%esp
  8008f2:	ff 75 f4             	pushl  -0xc(%ebp)
  8008f5:	50                   	push   %eax
  8008f6:	e8 48 ff ff ff       	call   800843 <vcprintf>
  8008fb:	83 c4 10             	add    $0x10,%esp
  8008fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800901:	e8 88 0f 00 00       	call   80188e <sys_enable_interrupt>
	return cnt;
  800906:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800909:	c9                   	leave  
  80090a:	c3                   	ret    

0080090b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80090b:	55                   	push   %ebp
  80090c:	89 e5                	mov    %esp,%ebp
  80090e:	53                   	push   %ebx
  80090f:	83 ec 14             	sub    $0x14,%esp
  800912:	8b 45 10             	mov    0x10(%ebp),%eax
  800915:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800918:	8b 45 14             	mov    0x14(%ebp),%eax
  80091b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80091e:	8b 45 18             	mov    0x18(%ebp),%eax
  800921:	ba 00 00 00 00       	mov    $0x0,%edx
  800926:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800929:	77 55                	ja     800980 <printnum+0x75>
  80092b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80092e:	72 05                	jb     800935 <printnum+0x2a>
  800930:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800933:	77 4b                	ja     800980 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800935:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800938:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80093b:	8b 45 18             	mov    0x18(%ebp),%eax
  80093e:	ba 00 00 00 00       	mov    $0x0,%edx
  800943:	52                   	push   %edx
  800944:	50                   	push   %eax
  800945:	ff 75 f4             	pushl  -0xc(%ebp)
  800948:	ff 75 f0             	pushl  -0x10(%ebp)
  80094b:	e8 48 13 00 00       	call   801c98 <__udivdi3>
  800950:	83 c4 10             	add    $0x10,%esp
  800953:	83 ec 04             	sub    $0x4,%esp
  800956:	ff 75 20             	pushl  0x20(%ebp)
  800959:	53                   	push   %ebx
  80095a:	ff 75 18             	pushl  0x18(%ebp)
  80095d:	52                   	push   %edx
  80095e:	50                   	push   %eax
  80095f:	ff 75 0c             	pushl  0xc(%ebp)
  800962:	ff 75 08             	pushl  0x8(%ebp)
  800965:	e8 a1 ff ff ff       	call   80090b <printnum>
  80096a:	83 c4 20             	add    $0x20,%esp
  80096d:	eb 1a                	jmp    800989 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80096f:	83 ec 08             	sub    $0x8,%esp
  800972:	ff 75 0c             	pushl  0xc(%ebp)
  800975:	ff 75 20             	pushl  0x20(%ebp)
  800978:	8b 45 08             	mov    0x8(%ebp),%eax
  80097b:	ff d0                	call   *%eax
  80097d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800980:	ff 4d 1c             	decl   0x1c(%ebp)
  800983:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800987:	7f e6                	jg     80096f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800989:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80098c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800991:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800994:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800997:	53                   	push   %ebx
  800998:	51                   	push   %ecx
  800999:	52                   	push   %edx
  80099a:	50                   	push   %eax
  80099b:	e8 08 14 00 00       	call   801da8 <__umoddi3>
  8009a0:	83 c4 10             	add    $0x10,%esp
  8009a3:	05 74 24 80 00       	add    $0x802474,%eax
  8009a8:	8a 00                	mov    (%eax),%al
  8009aa:	0f be c0             	movsbl %al,%eax
  8009ad:	83 ec 08             	sub    $0x8,%esp
  8009b0:	ff 75 0c             	pushl  0xc(%ebp)
  8009b3:	50                   	push   %eax
  8009b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b7:	ff d0                	call   *%eax
  8009b9:	83 c4 10             	add    $0x10,%esp
}
  8009bc:	90                   	nop
  8009bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8009c0:	c9                   	leave  
  8009c1:	c3                   	ret    

008009c2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8009c2:	55                   	push   %ebp
  8009c3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8009c5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8009c9:	7e 1c                	jle    8009e7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8009cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ce:	8b 00                	mov    (%eax),%eax
  8009d0:	8d 50 08             	lea    0x8(%eax),%edx
  8009d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d6:	89 10                	mov    %edx,(%eax)
  8009d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009db:	8b 00                	mov    (%eax),%eax
  8009dd:	83 e8 08             	sub    $0x8,%eax
  8009e0:	8b 50 04             	mov    0x4(%eax),%edx
  8009e3:	8b 00                	mov    (%eax),%eax
  8009e5:	eb 40                	jmp    800a27 <getuint+0x65>
	else if (lflag)
  8009e7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009eb:	74 1e                	je     800a0b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8009ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f0:	8b 00                	mov    (%eax),%eax
  8009f2:	8d 50 04             	lea    0x4(%eax),%edx
  8009f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f8:	89 10                	mov    %edx,(%eax)
  8009fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fd:	8b 00                	mov    (%eax),%eax
  8009ff:	83 e8 04             	sub    $0x4,%eax
  800a02:	8b 00                	mov    (%eax),%eax
  800a04:	ba 00 00 00 00       	mov    $0x0,%edx
  800a09:	eb 1c                	jmp    800a27 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800a0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0e:	8b 00                	mov    (%eax),%eax
  800a10:	8d 50 04             	lea    0x4(%eax),%edx
  800a13:	8b 45 08             	mov    0x8(%ebp),%eax
  800a16:	89 10                	mov    %edx,(%eax)
  800a18:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1b:	8b 00                	mov    (%eax),%eax
  800a1d:	83 e8 04             	sub    $0x4,%eax
  800a20:	8b 00                	mov    (%eax),%eax
  800a22:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800a27:	5d                   	pop    %ebp
  800a28:	c3                   	ret    

00800a29 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800a29:	55                   	push   %ebp
  800a2a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a2c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a30:	7e 1c                	jle    800a4e <getint+0x25>
		return va_arg(*ap, long long);
  800a32:	8b 45 08             	mov    0x8(%ebp),%eax
  800a35:	8b 00                	mov    (%eax),%eax
  800a37:	8d 50 08             	lea    0x8(%eax),%edx
  800a3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3d:	89 10                	mov    %edx,(%eax)
  800a3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a42:	8b 00                	mov    (%eax),%eax
  800a44:	83 e8 08             	sub    $0x8,%eax
  800a47:	8b 50 04             	mov    0x4(%eax),%edx
  800a4a:	8b 00                	mov    (%eax),%eax
  800a4c:	eb 38                	jmp    800a86 <getint+0x5d>
	else if (lflag)
  800a4e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a52:	74 1a                	je     800a6e <getint+0x45>
		return va_arg(*ap, long);
  800a54:	8b 45 08             	mov    0x8(%ebp),%eax
  800a57:	8b 00                	mov    (%eax),%eax
  800a59:	8d 50 04             	lea    0x4(%eax),%edx
  800a5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5f:	89 10                	mov    %edx,(%eax)
  800a61:	8b 45 08             	mov    0x8(%ebp),%eax
  800a64:	8b 00                	mov    (%eax),%eax
  800a66:	83 e8 04             	sub    $0x4,%eax
  800a69:	8b 00                	mov    (%eax),%eax
  800a6b:	99                   	cltd   
  800a6c:	eb 18                	jmp    800a86 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800a6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a71:	8b 00                	mov    (%eax),%eax
  800a73:	8d 50 04             	lea    0x4(%eax),%edx
  800a76:	8b 45 08             	mov    0x8(%ebp),%eax
  800a79:	89 10                	mov    %edx,(%eax)
  800a7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7e:	8b 00                	mov    (%eax),%eax
  800a80:	83 e8 04             	sub    $0x4,%eax
  800a83:	8b 00                	mov    (%eax),%eax
  800a85:	99                   	cltd   
}
  800a86:	5d                   	pop    %ebp
  800a87:	c3                   	ret    

00800a88 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800a88:	55                   	push   %ebp
  800a89:	89 e5                	mov    %esp,%ebp
  800a8b:	56                   	push   %esi
  800a8c:	53                   	push   %ebx
  800a8d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a90:	eb 17                	jmp    800aa9 <vprintfmt+0x21>
			if (ch == '\0')
  800a92:	85 db                	test   %ebx,%ebx
  800a94:	0f 84 af 03 00 00    	je     800e49 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800a9a:	83 ec 08             	sub    $0x8,%esp
  800a9d:	ff 75 0c             	pushl  0xc(%ebp)
  800aa0:	53                   	push   %ebx
  800aa1:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa4:	ff d0                	call   *%eax
  800aa6:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800aa9:	8b 45 10             	mov    0x10(%ebp),%eax
  800aac:	8d 50 01             	lea    0x1(%eax),%edx
  800aaf:	89 55 10             	mov    %edx,0x10(%ebp)
  800ab2:	8a 00                	mov    (%eax),%al
  800ab4:	0f b6 d8             	movzbl %al,%ebx
  800ab7:	83 fb 25             	cmp    $0x25,%ebx
  800aba:	75 d6                	jne    800a92 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800abc:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800ac0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800ac7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800ace:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800ad5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800adc:	8b 45 10             	mov    0x10(%ebp),%eax
  800adf:	8d 50 01             	lea    0x1(%eax),%edx
  800ae2:	89 55 10             	mov    %edx,0x10(%ebp)
  800ae5:	8a 00                	mov    (%eax),%al
  800ae7:	0f b6 d8             	movzbl %al,%ebx
  800aea:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800aed:	83 f8 55             	cmp    $0x55,%eax
  800af0:	0f 87 2b 03 00 00    	ja     800e21 <vprintfmt+0x399>
  800af6:	8b 04 85 98 24 80 00 	mov    0x802498(,%eax,4),%eax
  800afd:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800aff:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800b03:	eb d7                	jmp    800adc <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800b05:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800b09:	eb d1                	jmp    800adc <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800b0b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800b12:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b15:	89 d0                	mov    %edx,%eax
  800b17:	c1 e0 02             	shl    $0x2,%eax
  800b1a:	01 d0                	add    %edx,%eax
  800b1c:	01 c0                	add    %eax,%eax
  800b1e:	01 d8                	add    %ebx,%eax
  800b20:	83 e8 30             	sub    $0x30,%eax
  800b23:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800b26:	8b 45 10             	mov    0x10(%ebp),%eax
  800b29:	8a 00                	mov    (%eax),%al
  800b2b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800b2e:	83 fb 2f             	cmp    $0x2f,%ebx
  800b31:	7e 3e                	jle    800b71 <vprintfmt+0xe9>
  800b33:	83 fb 39             	cmp    $0x39,%ebx
  800b36:	7f 39                	jg     800b71 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800b38:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800b3b:	eb d5                	jmp    800b12 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800b3d:	8b 45 14             	mov    0x14(%ebp),%eax
  800b40:	83 c0 04             	add    $0x4,%eax
  800b43:	89 45 14             	mov    %eax,0x14(%ebp)
  800b46:	8b 45 14             	mov    0x14(%ebp),%eax
  800b49:	83 e8 04             	sub    $0x4,%eax
  800b4c:	8b 00                	mov    (%eax),%eax
  800b4e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800b51:	eb 1f                	jmp    800b72 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800b53:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b57:	79 83                	jns    800adc <vprintfmt+0x54>
				width = 0;
  800b59:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800b60:	e9 77 ff ff ff       	jmp    800adc <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800b65:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800b6c:	e9 6b ff ff ff       	jmp    800adc <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800b71:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800b72:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b76:	0f 89 60 ff ff ff    	jns    800adc <vprintfmt+0x54>
				width = precision, precision = -1;
  800b7c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b7f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800b82:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800b89:	e9 4e ff ff ff       	jmp    800adc <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800b8e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800b91:	e9 46 ff ff ff       	jmp    800adc <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800b96:	8b 45 14             	mov    0x14(%ebp),%eax
  800b99:	83 c0 04             	add    $0x4,%eax
  800b9c:	89 45 14             	mov    %eax,0x14(%ebp)
  800b9f:	8b 45 14             	mov    0x14(%ebp),%eax
  800ba2:	83 e8 04             	sub    $0x4,%eax
  800ba5:	8b 00                	mov    (%eax),%eax
  800ba7:	83 ec 08             	sub    $0x8,%esp
  800baa:	ff 75 0c             	pushl  0xc(%ebp)
  800bad:	50                   	push   %eax
  800bae:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb1:	ff d0                	call   *%eax
  800bb3:	83 c4 10             	add    $0x10,%esp
			break;
  800bb6:	e9 89 02 00 00       	jmp    800e44 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800bbb:	8b 45 14             	mov    0x14(%ebp),%eax
  800bbe:	83 c0 04             	add    $0x4,%eax
  800bc1:	89 45 14             	mov    %eax,0x14(%ebp)
  800bc4:	8b 45 14             	mov    0x14(%ebp),%eax
  800bc7:	83 e8 04             	sub    $0x4,%eax
  800bca:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800bcc:	85 db                	test   %ebx,%ebx
  800bce:	79 02                	jns    800bd2 <vprintfmt+0x14a>
				err = -err;
  800bd0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800bd2:	83 fb 64             	cmp    $0x64,%ebx
  800bd5:	7f 0b                	jg     800be2 <vprintfmt+0x15a>
  800bd7:	8b 34 9d e0 22 80 00 	mov    0x8022e0(,%ebx,4),%esi
  800bde:	85 f6                	test   %esi,%esi
  800be0:	75 19                	jne    800bfb <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800be2:	53                   	push   %ebx
  800be3:	68 85 24 80 00       	push   $0x802485
  800be8:	ff 75 0c             	pushl  0xc(%ebp)
  800beb:	ff 75 08             	pushl  0x8(%ebp)
  800bee:	e8 5e 02 00 00       	call   800e51 <printfmt>
  800bf3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800bf6:	e9 49 02 00 00       	jmp    800e44 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800bfb:	56                   	push   %esi
  800bfc:	68 8e 24 80 00       	push   $0x80248e
  800c01:	ff 75 0c             	pushl  0xc(%ebp)
  800c04:	ff 75 08             	pushl  0x8(%ebp)
  800c07:	e8 45 02 00 00       	call   800e51 <printfmt>
  800c0c:	83 c4 10             	add    $0x10,%esp
			break;
  800c0f:	e9 30 02 00 00       	jmp    800e44 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800c14:	8b 45 14             	mov    0x14(%ebp),%eax
  800c17:	83 c0 04             	add    $0x4,%eax
  800c1a:	89 45 14             	mov    %eax,0x14(%ebp)
  800c1d:	8b 45 14             	mov    0x14(%ebp),%eax
  800c20:	83 e8 04             	sub    $0x4,%eax
  800c23:	8b 30                	mov    (%eax),%esi
  800c25:	85 f6                	test   %esi,%esi
  800c27:	75 05                	jne    800c2e <vprintfmt+0x1a6>
				p = "(null)";
  800c29:	be 91 24 80 00       	mov    $0x802491,%esi
			if (width > 0 && padc != '-')
  800c2e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c32:	7e 6d                	jle    800ca1 <vprintfmt+0x219>
  800c34:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800c38:	74 67                	je     800ca1 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800c3a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c3d:	83 ec 08             	sub    $0x8,%esp
  800c40:	50                   	push   %eax
  800c41:	56                   	push   %esi
  800c42:	e8 0c 03 00 00       	call   800f53 <strnlen>
  800c47:	83 c4 10             	add    $0x10,%esp
  800c4a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800c4d:	eb 16                	jmp    800c65 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800c4f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800c53:	83 ec 08             	sub    $0x8,%esp
  800c56:	ff 75 0c             	pushl  0xc(%ebp)
  800c59:	50                   	push   %eax
  800c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5d:	ff d0                	call   *%eax
  800c5f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800c62:	ff 4d e4             	decl   -0x1c(%ebp)
  800c65:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c69:	7f e4                	jg     800c4f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c6b:	eb 34                	jmp    800ca1 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800c6d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800c71:	74 1c                	je     800c8f <vprintfmt+0x207>
  800c73:	83 fb 1f             	cmp    $0x1f,%ebx
  800c76:	7e 05                	jle    800c7d <vprintfmt+0x1f5>
  800c78:	83 fb 7e             	cmp    $0x7e,%ebx
  800c7b:	7e 12                	jle    800c8f <vprintfmt+0x207>
					putch('?', putdat);
  800c7d:	83 ec 08             	sub    $0x8,%esp
  800c80:	ff 75 0c             	pushl  0xc(%ebp)
  800c83:	6a 3f                	push   $0x3f
  800c85:	8b 45 08             	mov    0x8(%ebp),%eax
  800c88:	ff d0                	call   *%eax
  800c8a:	83 c4 10             	add    $0x10,%esp
  800c8d:	eb 0f                	jmp    800c9e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800c8f:	83 ec 08             	sub    $0x8,%esp
  800c92:	ff 75 0c             	pushl  0xc(%ebp)
  800c95:	53                   	push   %ebx
  800c96:	8b 45 08             	mov    0x8(%ebp),%eax
  800c99:	ff d0                	call   *%eax
  800c9b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c9e:	ff 4d e4             	decl   -0x1c(%ebp)
  800ca1:	89 f0                	mov    %esi,%eax
  800ca3:	8d 70 01             	lea    0x1(%eax),%esi
  800ca6:	8a 00                	mov    (%eax),%al
  800ca8:	0f be d8             	movsbl %al,%ebx
  800cab:	85 db                	test   %ebx,%ebx
  800cad:	74 24                	je     800cd3 <vprintfmt+0x24b>
  800caf:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800cb3:	78 b8                	js     800c6d <vprintfmt+0x1e5>
  800cb5:	ff 4d e0             	decl   -0x20(%ebp)
  800cb8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800cbc:	79 af                	jns    800c6d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800cbe:	eb 13                	jmp    800cd3 <vprintfmt+0x24b>
				putch(' ', putdat);
  800cc0:	83 ec 08             	sub    $0x8,%esp
  800cc3:	ff 75 0c             	pushl  0xc(%ebp)
  800cc6:	6a 20                	push   $0x20
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccb:	ff d0                	call   *%eax
  800ccd:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800cd0:	ff 4d e4             	decl   -0x1c(%ebp)
  800cd3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cd7:	7f e7                	jg     800cc0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800cd9:	e9 66 01 00 00       	jmp    800e44 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800cde:	83 ec 08             	sub    $0x8,%esp
  800ce1:	ff 75 e8             	pushl  -0x18(%ebp)
  800ce4:	8d 45 14             	lea    0x14(%ebp),%eax
  800ce7:	50                   	push   %eax
  800ce8:	e8 3c fd ff ff       	call   800a29 <getint>
  800ced:	83 c4 10             	add    $0x10,%esp
  800cf0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cf3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800cf6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cf9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cfc:	85 d2                	test   %edx,%edx
  800cfe:	79 23                	jns    800d23 <vprintfmt+0x29b>
				putch('-', putdat);
  800d00:	83 ec 08             	sub    $0x8,%esp
  800d03:	ff 75 0c             	pushl  0xc(%ebp)
  800d06:	6a 2d                	push   $0x2d
  800d08:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0b:	ff d0                	call   *%eax
  800d0d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800d10:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d13:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d16:	f7 d8                	neg    %eax
  800d18:	83 d2 00             	adc    $0x0,%edx
  800d1b:	f7 da                	neg    %edx
  800d1d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d20:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800d23:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800d2a:	e9 bc 00 00 00       	jmp    800deb <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800d2f:	83 ec 08             	sub    $0x8,%esp
  800d32:	ff 75 e8             	pushl  -0x18(%ebp)
  800d35:	8d 45 14             	lea    0x14(%ebp),%eax
  800d38:	50                   	push   %eax
  800d39:	e8 84 fc ff ff       	call   8009c2 <getuint>
  800d3e:	83 c4 10             	add    $0x10,%esp
  800d41:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d44:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800d47:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800d4e:	e9 98 00 00 00       	jmp    800deb <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800d53:	83 ec 08             	sub    $0x8,%esp
  800d56:	ff 75 0c             	pushl  0xc(%ebp)
  800d59:	6a 58                	push   $0x58
  800d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5e:	ff d0                	call   *%eax
  800d60:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800d63:	83 ec 08             	sub    $0x8,%esp
  800d66:	ff 75 0c             	pushl  0xc(%ebp)
  800d69:	6a 58                	push   $0x58
  800d6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6e:	ff d0                	call   *%eax
  800d70:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800d73:	83 ec 08             	sub    $0x8,%esp
  800d76:	ff 75 0c             	pushl  0xc(%ebp)
  800d79:	6a 58                	push   $0x58
  800d7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7e:	ff d0                	call   *%eax
  800d80:	83 c4 10             	add    $0x10,%esp
			break;
  800d83:	e9 bc 00 00 00       	jmp    800e44 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800d88:	83 ec 08             	sub    $0x8,%esp
  800d8b:	ff 75 0c             	pushl  0xc(%ebp)
  800d8e:	6a 30                	push   $0x30
  800d90:	8b 45 08             	mov    0x8(%ebp),%eax
  800d93:	ff d0                	call   *%eax
  800d95:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800d98:	83 ec 08             	sub    $0x8,%esp
  800d9b:	ff 75 0c             	pushl  0xc(%ebp)
  800d9e:	6a 78                	push   $0x78
  800da0:	8b 45 08             	mov    0x8(%ebp),%eax
  800da3:	ff d0                	call   *%eax
  800da5:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800da8:	8b 45 14             	mov    0x14(%ebp),%eax
  800dab:	83 c0 04             	add    $0x4,%eax
  800dae:	89 45 14             	mov    %eax,0x14(%ebp)
  800db1:	8b 45 14             	mov    0x14(%ebp),%eax
  800db4:	83 e8 04             	sub    $0x4,%eax
  800db7:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800db9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dbc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800dc3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800dca:	eb 1f                	jmp    800deb <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800dcc:	83 ec 08             	sub    $0x8,%esp
  800dcf:	ff 75 e8             	pushl  -0x18(%ebp)
  800dd2:	8d 45 14             	lea    0x14(%ebp),%eax
  800dd5:	50                   	push   %eax
  800dd6:	e8 e7 fb ff ff       	call   8009c2 <getuint>
  800ddb:	83 c4 10             	add    $0x10,%esp
  800dde:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800de1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800de4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800deb:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800def:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800df2:	83 ec 04             	sub    $0x4,%esp
  800df5:	52                   	push   %edx
  800df6:	ff 75 e4             	pushl  -0x1c(%ebp)
  800df9:	50                   	push   %eax
  800dfa:	ff 75 f4             	pushl  -0xc(%ebp)
  800dfd:	ff 75 f0             	pushl  -0x10(%ebp)
  800e00:	ff 75 0c             	pushl  0xc(%ebp)
  800e03:	ff 75 08             	pushl  0x8(%ebp)
  800e06:	e8 00 fb ff ff       	call   80090b <printnum>
  800e0b:	83 c4 20             	add    $0x20,%esp
			break;
  800e0e:	eb 34                	jmp    800e44 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800e10:	83 ec 08             	sub    $0x8,%esp
  800e13:	ff 75 0c             	pushl  0xc(%ebp)
  800e16:	53                   	push   %ebx
  800e17:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1a:	ff d0                	call   *%eax
  800e1c:	83 c4 10             	add    $0x10,%esp
			break;
  800e1f:	eb 23                	jmp    800e44 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800e21:	83 ec 08             	sub    $0x8,%esp
  800e24:	ff 75 0c             	pushl  0xc(%ebp)
  800e27:	6a 25                	push   $0x25
  800e29:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2c:	ff d0                	call   *%eax
  800e2e:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800e31:	ff 4d 10             	decl   0x10(%ebp)
  800e34:	eb 03                	jmp    800e39 <vprintfmt+0x3b1>
  800e36:	ff 4d 10             	decl   0x10(%ebp)
  800e39:	8b 45 10             	mov    0x10(%ebp),%eax
  800e3c:	48                   	dec    %eax
  800e3d:	8a 00                	mov    (%eax),%al
  800e3f:	3c 25                	cmp    $0x25,%al
  800e41:	75 f3                	jne    800e36 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800e43:	90                   	nop
		}
	}
  800e44:	e9 47 fc ff ff       	jmp    800a90 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800e49:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800e4a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800e4d:	5b                   	pop    %ebx
  800e4e:	5e                   	pop    %esi
  800e4f:	5d                   	pop    %ebp
  800e50:	c3                   	ret    

00800e51 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800e51:	55                   	push   %ebp
  800e52:	89 e5                	mov    %esp,%ebp
  800e54:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800e57:	8d 45 10             	lea    0x10(%ebp),%eax
  800e5a:	83 c0 04             	add    $0x4,%eax
  800e5d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800e60:	8b 45 10             	mov    0x10(%ebp),%eax
  800e63:	ff 75 f4             	pushl  -0xc(%ebp)
  800e66:	50                   	push   %eax
  800e67:	ff 75 0c             	pushl  0xc(%ebp)
  800e6a:	ff 75 08             	pushl  0x8(%ebp)
  800e6d:	e8 16 fc ff ff       	call   800a88 <vprintfmt>
  800e72:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800e75:	90                   	nop
  800e76:	c9                   	leave  
  800e77:	c3                   	ret    

00800e78 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800e78:	55                   	push   %ebp
  800e79:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800e7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7e:	8b 40 08             	mov    0x8(%eax),%eax
  800e81:	8d 50 01             	lea    0x1(%eax),%edx
  800e84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e87:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800e8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8d:	8b 10                	mov    (%eax),%edx
  800e8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e92:	8b 40 04             	mov    0x4(%eax),%eax
  800e95:	39 c2                	cmp    %eax,%edx
  800e97:	73 12                	jae    800eab <sprintputch+0x33>
		*b->buf++ = ch;
  800e99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9c:	8b 00                	mov    (%eax),%eax
  800e9e:	8d 48 01             	lea    0x1(%eax),%ecx
  800ea1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ea4:	89 0a                	mov    %ecx,(%edx)
  800ea6:	8b 55 08             	mov    0x8(%ebp),%edx
  800ea9:	88 10                	mov    %dl,(%eax)
}
  800eab:	90                   	nop
  800eac:	5d                   	pop    %ebp
  800ead:	c3                   	ret    

00800eae <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800eae:	55                   	push   %ebp
  800eaf:	89 e5                	mov    %esp,%ebp
  800eb1:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800eb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800eba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebd:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ec0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec3:	01 d0                	add    %edx,%eax
  800ec5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ec8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800ecf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ed3:	74 06                	je     800edb <vsnprintf+0x2d>
  800ed5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ed9:	7f 07                	jg     800ee2 <vsnprintf+0x34>
		return -E_INVAL;
  800edb:	b8 03 00 00 00       	mov    $0x3,%eax
  800ee0:	eb 20                	jmp    800f02 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ee2:	ff 75 14             	pushl  0x14(%ebp)
  800ee5:	ff 75 10             	pushl  0x10(%ebp)
  800ee8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800eeb:	50                   	push   %eax
  800eec:	68 78 0e 80 00       	push   $0x800e78
  800ef1:	e8 92 fb ff ff       	call   800a88 <vprintfmt>
  800ef6:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ef9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800efc:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800eff:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800f02:	c9                   	leave  
  800f03:	c3                   	ret    

00800f04 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800f04:	55                   	push   %ebp
  800f05:	89 e5                	mov    %esp,%ebp
  800f07:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800f0a:	8d 45 10             	lea    0x10(%ebp),%eax
  800f0d:	83 c0 04             	add    $0x4,%eax
  800f10:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800f13:	8b 45 10             	mov    0x10(%ebp),%eax
  800f16:	ff 75 f4             	pushl  -0xc(%ebp)
  800f19:	50                   	push   %eax
  800f1a:	ff 75 0c             	pushl  0xc(%ebp)
  800f1d:	ff 75 08             	pushl  0x8(%ebp)
  800f20:	e8 89 ff ff ff       	call   800eae <vsnprintf>
  800f25:	83 c4 10             	add    $0x10,%esp
  800f28:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800f2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f2e:	c9                   	leave  
  800f2f:	c3                   	ret    

00800f30 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800f30:	55                   	push   %ebp
  800f31:	89 e5                	mov    %esp,%ebp
  800f33:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800f36:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f3d:	eb 06                	jmp    800f45 <strlen+0x15>
		n++;
  800f3f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800f42:	ff 45 08             	incl   0x8(%ebp)
  800f45:	8b 45 08             	mov    0x8(%ebp),%eax
  800f48:	8a 00                	mov    (%eax),%al
  800f4a:	84 c0                	test   %al,%al
  800f4c:	75 f1                	jne    800f3f <strlen+0xf>
		n++;
	return n;
  800f4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f51:	c9                   	leave  
  800f52:	c3                   	ret    

00800f53 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800f53:	55                   	push   %ebp
  800f54:	89 e5                	mov    %esp,%ebp
  800f56:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800f59:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f60:	eb 09                	jmp    800f6b <strnlen+0x18>
		n++;
  800f62:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800f65:	ff 45 08             	incl   0x8(%ebp)
  800f68:	ff 4d 0c             	decl   0xc(%ebp)
  800f6b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f6f:	74 09                	je     800f7a <strnlen+0x27>
  800f71:	8b 45 08             	mov    0x8(%ebp),%eax
  800f74:	8a 00                	mov    (%eax),%al
  800f76:	84 c0                	test   %al,%al
  800f78:	75 e8                	jne    800f62 <strnlen+0xf>
		n++;
	return n;
  800f7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f7d:	c9                   	leave  
  800f7e:	c3                   	ret    

00800f7f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800f7f:	55                   	push   %ebp
  800f80:	89 e5                	mov    %esp,%ebp
  800f82:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800f85:	8b 45 08             	mov    0x8(%ebp),%eax
  800f88:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800f8b:	90                   	nop
  800f8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8f:	8d 50 01             	lea    0x1(%eax),%edx
  800f92:	89 55 08             	mov    %edx,0x8(%ebp)
  800f95:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f98:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f9b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f9e:	8a 12                	mov    (%edx),%dl
  800fa0:	88 10                	mov    %dl,(%eax)
  800fa2:	8a 00                	mov    (%eax),%al
  800fa4:	84 c0                	test   %al,%al
  800fa6:	75 e4                	jne    800f8c <strcpy+0xd>
		/* do nothing */;
	return ret;
  800fa8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800fab:	c9                   	leave  
  800fac:	c3                   	ret    

00800fad <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800fad:	55                   	push   %ebp
  800fae:	89 e5                	mov    %esp,%ebp
  800fb0:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800fb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800fb9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800fc0:	eb 1f                	jmp    800fe1 <strncpy+0x34>
		*dst++ = *src;
  800fc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc5:	8d 50 01             	lea    0x1(%eax),%edx
  800fc8:	89 55 08             	mov    %edx,0x8(%ebp)
  800fcb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fce:	8a 12                	mov    (%edx),%dl
  800fd0:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800fd2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd5:	8a 00                	mov    (%eax),%al
  800fd7:	84 c0                	test   %al,%al
  800fd9:	74 03                	je     800fde <strncpy+0x31>
			src++;
  800fdb:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800fde:	ff 45 fc             	incl   -0x4(%ebp)
  800fe1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fe4:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fe7:	72 d9                	jb     800fc2 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800fe9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800fec:	c9                   	leave  
  800fed:	c3                   	ret    

00800fee <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800fee:	55                   	push   %ebp
  800fef:	89 e5                	mov    %esp,%ebp
  800ff1:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ff4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ffa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ffe:	74 30                	je     801030 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801000:	eb 16                	jmp    801018 <strlcpy+0x2a>
			*dst++ = *src++;
  801002:	8b 45 08             	mov    0x8(%ebp),%eax
  801005:	8d 50 01             	lea    0x1(%eax),%edx
  801008:	89 55 08             	mov    %edx,0x8(%ebp)
  80100b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80100e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801011:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801014:	8a 12                	mov    (%edx),%dl
  801016:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801018:	ff 4d 10             	decl   0x10(%ebp)
  80101b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80101f:	74 09                	je     80102a <strlcpy+0x3c>
  801021:	8b 45 0c             	mov    0xc(%ebp),%eax
  801024:	8a 00                	mov    (%eax),%al
  801026:	84 c0                	test   %al,%al
  801028:	75 d8                	jne    801002 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80102a:	8b 45 08             	mov    0x8(%ebp),%eax
  80102d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801030:	8b 55 08             	mov    0x8(%ebp),%edx
  801033:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801036:	29 c2                	sub    %eax,%edx
  801038:	89 d0                	mov    %edx,%eax
}
  80103a:	c9                   	leave  
  80103b:	c3                   	ret    

0080103c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80103c:	55                   	push   %ebp
  80103d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80103f:	eb 06                	jmp    801047 <strcmp+0xb>
		p++, q++;
  801041:	ff 45 08             	incl   0x8(%ebp)
  801044:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801047:	8b 45 08             	mov    0x8(%ebp),%eax
  80104a:	8a 00                	mov    (%eax),%al
  80104c:	84 c0                	test   %al,%al
  80104e:	74 0e                	je     80105e <strcmp+0x22>
  801050:	8b 45 08             	mov    0x8(%ebp),%eax
  801053:	8a 10                	mov    (%eax),%dl
  801055:	8b 45 0c             	mov    0xc(%ebp),%eax
  801058:	8a 00                	mov    (%eax),%al
  80105a:	38 c2                	cmp    %al,%dl
  80105c:	74 e3                	je     801041 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80105e:	8b 45 08             	mov    0x8(%ebp),%eax
  801061:	8a 00                	mov    (%eax),%al
  801063:	0f b6 d0             	movzbl %al,%edx
  801066:	8b 45 0c             	mov    0xc(%ebp),%eax
  801069:	8a 00                	mov    (%eax),%al
  80106b:	0f b6 c0             	movzbl %al,%eax
  80106e:	29 c2                	sub    %eax,%edx
  801070:	89 d0                	mov    %edx,%eax
}
  801072:	5d                   	pop    %ebp
  801073:	c3                   	ret    

00801074 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801074:	55                   	push   %ebp
  801075:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801077:	eb 09                	jmp    801082 <strncmp+0xe>
		n--, p++, q++;
  801079:	ff 4d 10             	decl   0x10(%ebp)
  80107c:	ff 45 08             	incl   0x8(%ebp)
  80107f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801082:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801086:	74 17                	je     80109f <strncmp+0x2b>
  801088:	8b 45 08             	mov    0x8(%ebp),%eax
  80108b:	8a 00                	mov    (%eax),%al
  80108d:	84 c0                	test   %al,%al
  80108f:	74 0e                	je     80109f <strncmp+0x2b>
  801091:	8b 45 08             	mov    0x8(%ebp),%eax
  801094:	8a 10                	mov    (%eax),%dl
  801096:	8b 45 0c             	mov    0xc(%ebp),%eax
  801099:	8a 00                	mov    (%eax),%al
  80109b:	38 c2                	cmp    %al,%dl
  80109d:	74 da                	je     801079 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80109f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010a3:	75 07                	jne    8010ac <strncmp+0x38>
		return 0;
  8010a5:	b8 00 00 00 00       	mov    $0x0,%eax
  8010aa:	eb 14                	jmp    8010c0 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8010ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8010af:	8a 00                	mov    (%eax),%al
  8010b1:	0f b6 d0             	movzbl %al,%edx
  8010b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b7:	8a 00                	mov    (%eax),%al
  8010b9:	0f b6 c0             	movzbl %al,%eax
  8010bc:	29 c2                	sub    %eax,%edx
  8010be:	89 d0                	mov    %edx,%eax
}
  8010c0:	5d                   	pop    %ebp
  8010c1:	c3                   	ret    

008010c2 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8010c2:	55                   	push   %ebp
  8010c3:	89 e5                	mov    %esp,%ebp
  8010c5:	83 ec 04             	sub    $0x4,%esp
  8010c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010cb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8010ce:	eb 12                	jmp    8010e2 <strchr+0x20>
		if (*s == c)
  8010d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d3:	8a 00                	mov    (%eax),%al
  8010d5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8010d8:	75 05                	jne    8010df <strchr+0x1d>
			return (char *) s;
  8010da:	8b 45 08             	mov    0x8(%ebp),%eax
  8010dd:	eb 11                	jmp    8010f0 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8010df:	ff 45 08             	incl   0x8(%ebp)
  8010e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e5:	8a 00                	mov    (%eax),%al
  8010e7:	84 c0                	test   %al,%al
  8010e9:	75 e5                	jne    8010d0 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8010eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010f0:	c9                   	leave  
  8010f1:	c3                   	ret    

008010f2 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8010f2:	55                   	push   %ebp
  8010f3:	89 e5                	mov    %esp,%ebp
  8010f5:	83 ec 04             	sub    $0x4,%esp
  8010f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8010fe:	eb 0d                	jmp    80110d <strfind+0x1b>
		if (*s == c)
  801100:	8b 45 08             	mov    0x8(%ebp),%eax
  801103:	8a 00                	mov    (%eax),%al
  801105:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801108:	74 0e                	je     801118 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80110a:	ff 45 08             	incl   0x8(%ebp)
  80110d:	8b 45 08             	mov    0x8(%ebp),%eax
  801110:	8a 00                	mov    (%eax),%al
  801112:	84 c0                	test   %al,%al
  801114:	75 ea                	jne    801100 <strfind+0xe>
  801116:	eb 01                	jmp    801119 <strfind+0x27>
		if (*s == c)
			break;
  801118:	90                   	nop
	return (char *) s;
  801119:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80111c:	c9                   	leave  
  80111d:	c3                   	ret    

0080111e <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80111e:	55                   	push   %ebp
  80111f:	89 e5                	mov    %esp,%ebp
  801121:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801124:	8b 45 08             	mov    0x8(%ebp),%eax
  801127:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80112a:	8b 45 10             	mov    0x10(%ebp),%eax
  80112d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801130:	eb 0e                	jmp    801140 <memset+0x22>
		*p++ = c;
  801132:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801135:	8d 50 01             	lea    0x1(%eax),%edx
  801138:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80113b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80113e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801140:	ff 4d f8             	decl   -0x8(%ebp)
  801143:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801147:	79 e9                	jns    801132 <memset+0x14>
		*p++ = c;

	return v;
  801149:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80114c:	c9                   	leave  
  80114d:	c3                   	ret    

0080114e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80114e:	55                   	push   %ebp
  80114f:	89 e5                	mov    %esp,%ebp
  801151:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801154:	8b 45 0c             	mov    0xc(%ebp),%eax
  801157:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80115a:	8b 45 08             	mov    0x8(%ebp),%eax
  80115d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801160:	eb 16                	jmp    801178 <memcpy+0x2a>
		*d++ = *s++;
  801162:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801165:	8d 50 01             	lea    0x1(%eax),%edx
  801168:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80116b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80116e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801171:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801174:	8a 12                	mov    (%edx),%dl
  801176:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801178:	8b 45 10             	mov    0x10(%ebp),%eax
  80117b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80117e:	89 55 10             	mov    %edx,0x10(%ebp)
  801181:	85 c0                	test   %eax,%eax
  801183:	75 dd                	jne    801162 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801185:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801188:	c9                   	leave  
  801189:	c3                   	ret    

0080118a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80118a:	55                   	push   %ebp
  80118b:	89 e5                	mov    %esp,%ebp
  80118d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801190:	8b 45 0c             	mov    0xc(%ebp),%eax
  801193:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801196:	8b 45 08             	mov    0x8(%ebp),%eax
  801199:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80119c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80119f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011a2:	73 50                	jae    8011f4 <memmove+0x6a>
  8011a4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011aa:	01 d0                	add    %edx,%eax
  8011ac:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8011af:	76 43                	jbe    8011f4 <memmove+0x6a>
		s += n;
  8011b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b4:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8011b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ba:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8011bd:	eb 10                	jmp    8011cf <memmove+0x45>
			*--d = *--s;
  8011bf:	ff 4d f8             	decl   -0x8(%ebp)
  8011c2:	ff 4d fc             	decl   -0x4(%ebp)
  8011c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011c8:	8a 10                	mov    (%eax),%dl
  8011ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011cd:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8011cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011d5:	89 55 10             	mov    %edx,0x10(%ebp)
  8011d8:	85 c0                	test   %eax,%eax
  8011da:	75 e3                	jne    8011bf <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8011dc:	eb 23                	jmp    801201 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8011de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011e1:	8d 50 01             	lea    0x1(%eax),%edx
  8011e4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8011e7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011ea:	8d 4a 01             	lea    0x1(%edx),%ecx
  8011ed:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8011f0:	8a 12                	mov    (%edx),%dl
  8011f2:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8011f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011fa:	89 55 10             	mov    %edx,0x10(%ebp)
  8011fd:	85 c0                	test   %eax,%eax
  8011ff:	75 dd                	jne    8011de <memmove+0x54>
			*d++ = *s++;

	return dst;
  801201:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801204:	c9                   	leave  
  801205:	c3                   	ret    

00801206 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801206:	55                   	push   %ebp
  801207:	89 e5                	mov    %esp,%ebp
  801209:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80120c:	8b 45 08             	mov    0x8(%ebp),%eax
  80120f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801212:	8b 45 0c             	mov    0xc(%ebp),%eax
  801215:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801218:	eb 2a                	jmp    801244 <memcmp+0x3e>
		if (*s1 != *s2)
  80121a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80121d:	8a 10                	mov    (%eax),%dl
  80121f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801222:	8a 00                	mov    (%eax),%al
  801224:	38 c2                	cmp    %al,%dl
  801226:	74 16                	je     80123e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801228:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80122b:	8a 00                	mov    (%eax),%al
  80122d:	0f b6 d0             	movzbl %al,%edx
  801230:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801233:	8a 00                	mov    (%eax),%al
  801235:	0f b6 c0             	movzbl %al,%eax
  801238:	29 c2                	sub    %eax,%edx
  80123a:	89 d0                	mov    %edx,%eax
  80123c:	eb 18                	jmp    801256 <memcmp+0x50>
		s1++, s2++;
  80123e:	ff 45 fc             	incl   -0x4(%ebp)
  801241:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801244:	8b 45 10             	mov    0x10(%ebp),%eax
  801247:	8d 50 ff             	lea    -0x1(%eax),%edx
  80124a:	89 55 10             	mov    %edx,0x10(%ebp)
  80124d:	85 c0                	test   %eax,%eax
  80124f:	75 c9                	jne    80121a <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801251:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801256:	c9                   	leave  
  801257:	c3                   	ret    

00801258 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801258:	55                   	push   %ebp
  801259:	89 e5                	mov    %esp,%ebp
  80125b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80125e:	8b 55 08             	mov    0x8(%ebp),%edx
  801261:	8b 45 10             	mov    0x10(%ebp),%eax
  801264:	01 d0                	add    %edx,%eax
  801266:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801269:	eb 15                	jmp    801280 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80126b:	8b 45 08             	mov    0x8(%ebp),%eax
  80126e:	8a 00                	mov    (%eax),%al
  801270:	0f b6 d0             	movzbl %al,%edx
  801273:	8b 45 0c             	mov    0xc(%ebp),%eax
  801276:	0f b6 c0             	movzbl %al,%eax
  801279:	39 c2                	cmp    %eax,%edx
  80127b:	74 0d                	je     80128a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80127d:	ff 45 08             	incl   0x8(%ebp)
  801280:	8b 45 08             	mov    0x8(%ebp),%eax
  801283:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801286:	72 e3                	jb     80126b <memfind+0x13>
  801288:	eb 01                	jmp    80128b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80128a:	90                   	nop
	return (void *) s;
  80128b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80128e:	c9                   	leave  
  80128f:	c3                   	ret    

00801290 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801290:	55                   	push   %ebp
  801291:	89 e5                	mov    %esp,%ebp
  801293:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801296:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80129d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012a4:	eb 03                	jmp    8012a9 <strtol+0x19>
		s++;
  8012a6:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8012a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ac:	8a 00                	mov    (%eax),%al
  8012ae:	3c 20                	cmp    $0x20,%al
  8012b0:	74 f4                	je     8012a6 <strtol+0x16>
  8012b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b5:	8a 00                	mov    (%eax),%al
  8012b7:	3c 09                	cmp    $0x9,%al
  8012b9:	74 eb                	je     8012a6 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8012bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012be:	8a 00                	mov    (%eax),%al
  8012c0:	3c 2b                	cmp    $0x2b,%al
  8012c2:	75 05                	jne    8012c9 <strtol+0x39>
		s++;
  8012c4:	ff 45 08             	incl   0x8(%ebp)
  8012c7:	eb 13                	jmp    8012dc <strtol+0x4c>
	else if (*s == '-')
  8012c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cc:	8a 00                	mov    (%eax),%al
  8012ce:	3c 2d                	cmp    $0x2d,%al
  8012d0:	75 0a                	jne    8012dc <strtol+0x4c>
		s++, neg = 1;
  8012d2:	ff 45 08             	incl   0x8(%ebp)
  8012d5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8012dc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012e0:	74 06                	je     8012e8 <strtol+0x58>
  8012e2:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8012e6:	75 20                	jne    801308 <strtol+0x78>
  8012e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012eb:	8a 00                	mov    (%eax),%al
  8012ed:	3c 30                	cmp    $0x30,%al
  8012ef:	75 17                	jne    801308 <strtol+0x78>
  8012f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f4:	40                   	inc    %eax
  8012f5:	8a 00                	mov    (%eax),%al
  8012f7:	3c 78                	cmp    $0x78,%al
  8012f9:	75 0d                	jne    801308 <strtol+0x78>
		s += 2, base = 16;
  8012fb:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8012ff:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801306:	eb 28                	jmp    801330 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801308:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80130c:	75 15                	jne    801323 <strtol+0x93>
  80130e:	8b 45 08             	mov    0x8(%ebp),%eax
  801311:	8a 00                	mov    (%eax),%al
  801313:	3c 30                	cmp    $0x30,%al
  801315:	75 0c                	jne    801323 <strtol+0x93>
		s++, base = 8;
  801317:	ff 45 08             	incl   0x8(%ebp)
  80131a:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801321:	eb 0d                	jmp    801330 <strtol+0xa0>
	else if (base == 0)
  801323:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801327:	75 07                	jne    801330 <strtol+0xa0>
		base = 10;
  801329:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801330:	8b 45 08             	mov    0x8(%ebp),%eax
  801333:	8a 00                	mov    (%eax),%al
  801335:	3c 2f                	cmp    $0x2f,%al
  801337:	7e 19                	jle    801352 <strtol+0xc2>
  801339:	8b 45 08             	mov    0x8(%ebp),%eax
  80133c:	8a 00                	mov    (%eax),%al
  80133e:	3c 39                	cmp    $0x39,%al
  801340:	7f 10                	jg     801352 <strtol+0xc2>
			dig = *s - '0';
  801342:	8b 45 08             	mov    0x8(%ebp),%eax
  801345:	8a 00                	mov    (%eax),%al
  801347:	0f be c0             	movsbl %al,%eax
  80134a:	83 e8 30             	sub    $0x30,%eax
  80134d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801350:	eb 42                	jmp    801394 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801352:	8b 45 08             	mov    0x8(%ebp),%eax
  801355:	8a 00                	mov    (%eax),%al
  801357:	3c 60                	cmp    $0x60,%al
  801359:	7e 19                	jle    801374 <strtol+0xe4>
  80135b:	8b 45 08             	mov    0x8(%ebp),%eax
  80135e:	8a 00                	mov    (%eax),%al
  801360:	3c 7a                	cmp    $0x7a,%al
  801362:	7f 10                	jg     801374 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801364:	8b 45 08             	mov    0x8(%ebp),%eax
  801367:	8a 00                	mov    (%eax),%al
  801369:	0f be c0             	movsbl %al,%eax
  80136c:	83 e8 57             	sub    $0x57,%eax
  80136f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801372:	eb 20                	jmp    801394 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801374:	8b 45 08             	mov    0x8(%ebp),%eax
  801377:	8a 00                	mov    (%eax),%al
  801379:	3c 40                	cmp    $0x40,%al
  80137b:	7e 39                	jle    8013b6 <strtol+0x126>
  80137d:	8b 45 08             	mov    0x8(%ebp),%eax
  801380:	8a 00                	mov    (%eax),%al
  801382:	3c 5a                	cmp    $0x5a,%al
  801384:	7f 30                	jg     8013b6 <strtol+0x126>
			dig = *s - 'A' + 10;
  801386:	8b 45 08             	mov    0x8(%ebp),%eax
  801389:	8a 00                	mov    (%eax),%al
  80138b:	0f be c0             	movsbl %al,%eax
  80138e:	83 e8 37             	sub    $0x37,%eax
  801391:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801394:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801397:	3b 45 10             	cmp    0x10(%ebp),%eax
  80139a:	7d 19                	jge    8013b5 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80139c:	ff 45 08             	incl   0x8(%ebp)
  80139f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013a2:	0f af 45 10          	imul   0x10(%ebp),%eax
  8013a6:	89 c2                	mov    %eax,%edx
  8013a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013ab:	01 d0                	add    %edx,%eax
  8013ad:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8013b0:	e9 7b ff ff ff       	jmp    801330 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8013b5:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8013b6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8013ba:	74 08                	je     8013c4 <strtol+0x134>
		*endptr = (char *) s;
  8013bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013bf:	8b 55 08             	mov    0x8(%ebp),%edx
  8013c2:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8013c4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8013c8:	74 07                	je     8013d1 <strtol+0x141>
  8013ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013cd:	f7 d8                	neg    %eax
  8013cf:	eb 03                	jmp    8013d4 <strtol+0x144>
  8013d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013d4:	c9                   	leave  
  8013d5:	c3                   	ret    

008013d6 <ltostr>:

void
ltostr(long value, char *str)
{
  8013d6:	55                   	push   %ebp
  8013d7:	89 e5                	mov    %esp,%ebp
  8013d9:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8013dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8013e3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8013ea:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013ee:	79 13                	jns    801403 <ltostr+0x2d>
	{
		neg = 1;
  8013f0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8013f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013fa:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8013fd:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801400:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801403:	8b 45 08             	mov    0x8(%ebp),%eax
  801406:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80140b:	99                   	cltd   
  80140c:	f7 f9                	idiv   %ecx
  80140e:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801411:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801414:	8d 50 01             	lea    0x1(%eax),%edx
  801417:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80141a:	89 c2                	mov    %eax,%edx
  80141c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141f:	01 d0                	add    %edx,%eax
  801421:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801424:	83 c2 30             	add    $0x30,%edx
  801427:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801429:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80142c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801431:	f7 e9                	imul   %ecx
  801433:	c1 fa 02             	sar    $0x2,%edx
  801436:	89 c8                	mov    %ecx,%eax
  801438:	c1 f8 1f             	sar    $0x1f,%eax
  80143b:	29 c2                	sub    %eax,%edx
  80143d:	89 d0                	mov    %edx,%eax
  80143f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801442:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801445:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80144a:	f7 e9                	imul   %ecx
  80144c:	c1 fa 02             	sar    $0x2,%edx
  80144f:	89 c8                	mov    %ecx,%eax
  801451:	c1 f8 1f             	sar    $0x1f,%eax
  801454:	29 c2                	sub    %eax,%edx
  801456:	89 d0                	mov    %edx,%eax
  801458:	c1 e0 02             	shl    $0x2,%eax
  80145b:	01 d0                	add    %edx,%eax
  80145d:	01 c0                	add    %eax,%eax
  80145f:	29 c1                	sub    %eax,%ecx
  801461:	89 ca                	mov    %ecx,%edx
  801463:	85 d2                	test   %edx,%edx
  801465:	75 9c                	jne    801403 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801467:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80146e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801471:	48                   	dec    %eax
  801472:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801475:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801479:	74 3d                	je     8014b8 <ltostr+0xe2>
		start = 1 ;
  80147b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801482:	eb 34                	jmp    8014b8 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801484:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801487:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148a:	01 d0                	add    %edx,%eax
  80148c:	8a 00                	mov    (%eax),%al
  80148e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801491:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801494:	8b 45 0c             	mov    0xc(%ebp),%eax
  801497:	01 c2                	add    %eax,%edx
  801499:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80149c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149f:	01 c8                	add    %ecx,%eax
  8014a1:	8a 00                	mov    (%eax),%al
  8014a3:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8014a5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8014a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ab:	01 c2                	add    %eax,%edx
  8014ad:	8a 45 eb             	mov    -0x15(%ebp),%al
  8014b0:	88 02                	mov    %al,(%edx)
		start++ ;
  8014b2:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8014b5:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8014b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014bb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014be:	7c c4                	jl     801484 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8014c0:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8014c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c6:	01 d0                	add    %edx,%eax
  8014c8:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8014cb:	90                   	nop
  8014cc:	c9                   	leave  
  8014cd:	c3                   	ret    

008014ce <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8014ce:	55                   	push   %ebp
  8014cf:	89 e5                	mov    %esp,%ebp
  8014d1:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8014d4:	ff 75 08             	pushl  0x8(%ebp)
  8014d7:	e8 54 fa ff ff       	call   800f30 <strlen>
  8014dc:	83 c4 04             	add    $0x4,%esp
  8014df:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8014e2:	ff 75 0c             	pushl  0xc(%ebp)
  8014e5:	e8 46 fa ff ff       	call   800f30 <strlen>
  8014ea:	83 c4 04             	add    $0x4,%esp
  8014ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8014f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8014f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014fe:	eb 17                	jmp    801517 <strcconcat+0x49>
		final[s] = str1[s] ;
  801500:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801503:	8b 45 10             	mov    0x10(%ebp),%eax
  801506:	01 c2                	add    %eax,%edx
  801508:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80150b:	8b 45 08             	mov    0x8(%ebp),%eax
  80150e:	01 c8                	add    %ecx,%eax
  801510:	8a 00                	mov    (%eax),%al
  801512:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801514:	ff 45 fc             	incl   -0x4(%ebp)
  801517:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80151a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80151d:	7c e1                	jl     801500 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80151f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801526:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80152d:	eb 1f                	jmp    80154e <strcconcat+0x80>
		final[s++] = str2[i] ;
  80152f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801532:	8d 50 01             	lea    0x1(%eax),%edx
  801535:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801538:	89 c2                	mov    %eax,%edx
  80153a:	8b 45 10             	mov    0x10(%ebp),%eax
  80153d:	01 c2                	add    %eax,%edx
  80153f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801542:	8b 45 0c             	mov    0xc(%ebp),%eax
  801545:	01 c8                	add    %ecx,%eax
  801547:	8a 00                	mov    (%eax),%al
  801549:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80154b:	ff 45 f8             	incl   -0x8(%ebp)
  80154e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801551:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801554:	7c d9                	jl     80152f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801556:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801559:	8b 45 10             	mov    0x10(%ebp),%eax
  80155c:	01 d0                	add    %edx,%eax
  80155e:	c6 00 00             	movb   $0x0,(%eax)
}
  801561:	90                   	nop
  801562:	c9                   	leave  
  801563:	c3                   	ret    

00801564 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801564:	55                   	push   %ebp
  801565:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801567:	8b 45 14             	mov    0x14(%ebp),%eax
  80156a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801570:	8b 45 14             	mov    0x14(%ebp),%eax
  801573:	8b 00                	mov    (%eax),%eax
  801575:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80157c:	8b 45 10             	mov    0x10(%ebp),%eax
  80157f:	01 d0                	add    %edx,%eax
  801581:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801587:	eb 0c                	jmp    801595 <strsplit+0x31>
			*string++ = 0;
  801589:	8b 45 08             	mov    0x8(%ebp),%eax
  80158c:	8d 50 01             	lea    0x1(%eax),%edx
  80158f:	89 55 08             	mov    %edx,0x8(%ebp)
  801592:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801595:	8b 45 08             	mov    0x8(%ebp),%eax
  801598:	8a 00                	mov    (%eax),%al
  80159a:	84 c0                	test   %al,%al
  80159c:	74 18                	je     8015b6 <strsplit+0x52>
  80159e:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a1:	8a 00                	mov    (%eax),%al
  8015a3:	0f be c0             	movsbl %al,%eax
  8015a6:	50                   	push   %eax
  8015a7:	ff 75 0c             	pushl  0xc(%ebp)
  8015aa:	e8 13 fb ff ff       	call   8010c2 <strchr>
  8015af:	83 c4 08             	add    $0x8,%esp
  8015b2:	85 c0                	test   %eax,%eax
  8015b4:	75 d3                	jne    801589 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8015b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b9:	8a 00                	mov    (%eax),%al
  8015bb:	84 c0                	test   %al,%al
  8015bd:	74 5a                	je     801619 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8015bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8015c2:	8b 00                	mov    (%eax),%eax
  8015c4:	83 f8 0f             	cmp    $0xf,%eax
  8015c7:	75 07                	jne    8015d0 <strsplit+0x6c>
		{
			return 0;
  8015c9:	b8 00 00 00 00       	mov    $0x0,%eax
  8015ce:	eb 66                	jmp    801636 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8015d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8015d3:	8b 00                	mov    (%eax),%eax
  8015d5:	8d 48 01             	lea    0x1(%eax),%ecx
  8015d8:	8b 55 14             	mov    0x14(%ebp),%edx
  8015db:	89 0a                	mov    %ecx,(%edx)
  8015dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015e7:	01 c2                	add    %eax,%edx
  8015e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ec:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8015ee:	eb 03                	jmp    8015f3 <strsplit+0x8f>
			string++;
  8015f0:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8015f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f6:	8a 00                	mov    (%eax),%al
  8015f8:	84 c0                	test   %al,%al
  8015fa:	74 8b                	je     801587 <strsplit+0x23>
  8015fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ff:	8a 00                	mov    (%eax),%al
  801601:	0f be c0             	movsbl %al,%eax
  801604:	50                   	push   %eax
  801605:	ff 75 0c             	pushl  0xc(%ebp)
  801608:	e8 b5 fa ff ff       	call   8010c2 <strchr>
  80160d:	83 c4 08             	add    $0x8,%esp
  801610:	85 c0                	test   %eax,%eax
  801612:	74 dc                	je     8015f0 <strsplit+0x8c>
			string++;
	}
  801614:	e9 6e ff ff ff       	jmp    801587 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801619:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80161a:	8b 45 14             	mov    0x14(%ebp),%eax
  80161d:	8b 00                	mov    (%eax),%eax
  80161f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801626:	8b 45 10             	mov    0x10(%ebp),%eax
  801629:	01 d0                	add    %edx,%eax
  80162b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801631:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801636:	c9                   	leave  
  801637:	c3                   	ret    

00801638 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801638:	55                   	push   %ebp
  801639:	89 e5                	mov    %esp,%ebp
  80163b:	57                   	push   %edi
  80163c:	56                   	push   %esi
  80163d:	53                   	push   %ebx
  80163e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801641:	8b 45 08             	mov    0x8(%ebp),%eax
  801644:	8b 55 0c             	mov    0xc(%ebp),%edx
  801647:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80164a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80164d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801650:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801653:	cd 30                	int    $0x30
  801655:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801658:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80165b:	83 c4 10             	add    $0x10,%esp
  80165e:	5b                   	pop    %ebx
  80165f:	5e                   	pop    %esi
  801660:	5f                   	pop    %edi
  801661:	5d                   	pop    %ebp
  801662:	c3                   	ret    

00801663 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801663:	55                   	push   %ebp
  801664:	89 e5                	mov    %esp,%ebp
  801666:	83 ec 04             	sub    $0x4,%esp
  801669:	8b 45 10             	mov    0x10(%ebp),%eax
  80166c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80166f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801673:	8b 45 08             	mov    0x8(%ebp),%eax
  801676:	6a 00                	push   $0x0
  801678:	6a 00                	push   $0x0
  80167a:	52                   	push   %edx
  80167b:	ff 75 0c             	pushl  0xc(%ebp)
  80167e:	50                   	push   %eax
  80167f:	6a 00                	push   $0x0
  801681:	e8 b2 ff ff ff       	call   801638 <syscall>
  801686:	83 c4 18             	add    $0x18,%esp
}
  801689:	90                   	nop
  80168a:	c9                   	leave  
  80168b:	c3                   	ret    

0080168c <sys_cgetc>:

int
sys_cgetc(void)
{
  80168c:	55                   	push   %ebp
  80168d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	6a 00                	push   $0x0
  801695:	6a 00                	push   $0x0
  801697:	6a 00                	push   $0x0
  801699:	6a 01                	push   $0x1
  80169b:	e8 98 ff ff ff       	call   801638 <syscall>
  8016a0:	83 c4 18             	add    $0x18,%esp
}
  8016a3:	c9                   	leave  
  8016a4:	c3                   	ret    

008016a5 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8016a5:	55                   	push   %ebp
  8016a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8016a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 00                	push   $0x0
  8016b1:	6a 00                	push   $0x0
  8016b3:	50                   	push   %eax
  8016b4:	6a 05                	push   $0x5
  8016b6:	e8 7d ff ff ff       	call   801638 <syscall>
  8016bb:	83 c4 18             	add    $0x18,%esp
}
  8016be:	c9                   	leave  
  8016bf:	c3                   	ret    

008016c0 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8016c0:	55                   	push   %ebp
  8016c1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8016c3:	6a 00                	push   $0x0
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	6a 00                	push   $0x0
  8016cd:	6a 02                	push   $0x2
  8016cf:	e8 64 ff ff ff       	call   801638 <syscall>
  8016d4:	83 c4 18             	add    $0x18,%esp
}
  8016d7:	c9                   	leave  
  8016d8:	c3                   	ret    

008016d9 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8016d9:	55                   	push   %ebp
  8016da:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	6a 00                	push   $0x0
  8016e6:	6a 03                	push   $0x3
  8016e8:	e8 4b ff ff ff       	call   801638 <syscall>
  8016ed:	83 c4 18             	add    $0x18,%esp
}
  8016f0:	c9                   	leave  
  8016f1:	c3                   	ret    

008016f2 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8016f2:	55                   	push   %ebp
  8016f3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 00                	push   $0x0
  8016fd:	6a 00                	push   $0x0
  8016ff:	6a 04                	push   $0x4
  801701:	e8 32 ff ff ff       	call   801638 <syscall>
  801706:	83 c4 18             	add    $0x18,%esp
}
  801709:	c9                   	leave  
  80170a:	c3                   	ret    

0080170b <sys_env_exit>:


void sys_env_exit(void)
{
  80170b:	55                   	push   %ebp
  80170c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	6a 00                	push   $0x0
  801716:	6a 00                	push   $0x0
  801718:	6a 06                	push   $0x6
  80171a:	e8 19 ff ff ff       	call   801638 <syscall>
  80171f:	83 c4 18             	add    $0x18,%esp
}
  801722:	90                   	nop
  801723:	c9                   	leave  
  801724:	c3                   	ret    

00801725 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801725:	55                   	push   %ebp
  801726:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801728:	8b 55 0c             	mov    0xc(%ebp),%edx
  80172b:	8b 45 08             	mov    0x8(%ebp),%eax
  80172e:	6a 00                	push   $0x0
  801730:	6a 00                	push   $0x0
  801732:	6a 00                	push   $0x0
  801734:	52                   	push   %edx
  801735:	50                   	push   %eax
  801736:	6a 07                	push   $0x7
  801738:	e8 fb fe ff ff       	call   801638 <syscall>
  80173d:	83 c4 18             	add    $0x18,%esp
}
  801740:	c9                   	leave  
  801741:	c3                   	ret    

00801742 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801742:	55                   	push   %ebp
  801743:	89 e5                	mov    %esp,%ebp
  801745:	56                   	push   %esi
  801746:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801747:	8b 75 18             	mov    0x18(%ebp),%esi
  80174a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80174d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801750:	8b 55 0c             	mov    0xc(%ebp),%edx
  801753:	8b 45 08             	mov    0x8(%ebp),%eax
  801756:	56                   	push   %esi
  801757:	53                   	push   %ebx
  801758:	51                   	push   %ecx
  801759:	52                   	push   %edx
  80175a:	50                   	push   %eax
  80175b:	6a 08                	push   $0x8
  80175d:	e8 d6 fe ff ff       	call   801638 <syscall>
  801762:	83 c4 18             	add    $0x18,%esp
}
  801765:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801768:	5b                   	pop    %ebx
  801769:	5e                   	pop    %esi
  80176a:	5d                   	pop    %ebp
  80176b:	c3                   	ret    

0080176c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80176c:	55                   	push   %ebp
  80176d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80176f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801772:	8b 45 08             	mov    0x8(%ebp),%eax
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	52                   	push   %edx
  80177c:	50                   	push   %eax
  80177d:	6a 09                	push   $0x9
  80177f:	e8 b4 fe ff ff       	call   801638 <syscall>
  801784:	83 c4 18             	add    $0x18,%esp
}
  801787:	c9                   	leave  
  801788:	c3                   	ret    

00801789 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801789:	55                   	push   %ebp
  80178a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80178c:	6a 00                	push   $0x0
  80178e:	6a 00                	push   $0x0
  801790:	6a 00                	push   $0x0
  801792:	ff 75 0c             	pushl  0xc(%ebp)
  801795:	ff 75 08             	pushl  0x8(%ebp)
  801798:	6a 0a                	push   $0xa
  80179a:	e8 99 fe ff ff       	call   801638 <syscall>
  80179f:	83 c4 18             	add    $0x18,%esp
}
  8017a2:	c9                   	leave  
  8017a3:	c3                   	ret    

008017a4 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8017a4:	55                   	push   %ebp
  8017a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 0b                	push   $0xb
  8017b3:	e8 80 fe ff ff       	call   801638 <syscall>
  8017b8:	83 c4 18             	add    $0x18,%esp
}
  8017bb:	c9                   	leave  
  8017bc:	c3                   	ret    

008017bd <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8017bd:	55                   	push   %ebp
  8017be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 0c                	push   $0xc
  8017cc:	e8 67 fe ff ff       	call   801638 <syscall>
  8017d1:	83 c4 18             	add    $0x18,%esp
}
  8017d4:	c9                   	leave  
  8017d5:	c3                   	ret    

008017d6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8017d6:	55                   	push   %ebp
  8017d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 00                	push   $0x0
  8017e1:	6a 00                	push   $0x0
  8017e3:	6a 0d                	push   $0xd
  8017e5:	e8 4e fe ff ff       	call   801638 <syscall>
  8017ea:	83 c4 18             	add    $0x18,%esp
}
  8017ed:	c9                   	leave  
  8017ee:	c3                   	ret    

008017ef <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8017ef:	55                   	push   %ebp
  8017f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8017f2:	6a 00                	push   $0x0
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	ff 75 0c             	pushl  0xc(%ebp)
  8017fb:	ff 75 08             	pushl  0x8(%ebp)
  8017fe:	6a 11                	push   $0x11
  801800:	e8 33 fe ff ff       	call   801638 <syscall>
  801805:	83 c4 18             	add    $0x18,%esp
	return;
  801808:	90                   	nop
}
  801809:	c9                   	leave  
  80180a:	c3                   	ret    

0080180b <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80180b:	55                   	push   %ebp
  80180c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	ff 75 0c             	pushl  0xc(%ebp)
  801817:	ff 75 08             	pushl  0x8(%ebp)
  80181a:	6a 12                	push   $0x12
  80181c:	e8 17 fe ff ff       	call   801638 <syscall>
  801821:	83 c4 18             	add    $0x18,%esp
	return ;
  801824:	90                   	nop
}
  801825:	c9                   	leave  
  801826:	c3                   	ret    

00801827 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801827:	55                   	push   %ebp
  801828:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 0e                	push   $0xe
  801836:	e8 fd fd ff ff       	call   801638 <syscall>
  80183b:	83 c4 18             	add    $0x18,%esp
}
  80183e:	c9                   	leave  
  80183f:	c3                   	ret    

00801840 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801840:	55                   	push   %ebp
  801841:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801843:	6a 00                	push   $0x0
  801845:	6a 00                	push   $0x0
  801847:	6a 00                	push   $0x0
  801849:	6a 00                	push   $0x0
  80184b:	ff 75 08             	pushl  0x8(%ebp)
  80184e:	6a 0f                	push   $0xf
  801850:	e8 e3 fd ff ff       	call   801638 <syscall>
  801855:	83 c4 18             	add    $0x18,%esp
}
  801858:	c9                   	leave  
  801859:	c3                   	ret    

0080185a <sys_scarce_memory>:

void sys_scarce_memory()
{
  80185a:	55                   	push   %ebp
  80185b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	6a 00                	push   $0x0
  801867:	6a 10                	push   $0x10
  801869:	e8 ca fd ff ff       	call   801638 <syscall>
  80186e:	83 c4 18             	add    $0x18,%esp
}
  801871:	90                   	nop
  801872:	c9                   	leave  
  801873:	c3                   	ret    

00801874 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801874:	55                   	push   %ebp
  801875:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	6a 14                	push   $0x14
  801883:	e8 b0 fd ff ff       	call   801638 <syscall>
  801888:	83 c4 18             	add    $0x18,%esp
}
  80188b:	90                   	nop
  80188c:	c9                   	leave  
  80188d:	c3                   	ret    

0080188e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80188e:	55                   	push   %ebp
  80188f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 15                	push   $0x15
  80189d:	e8 96 fd ff ff       	call   801638 <syscall>
  8018a2:	83 c4 18             	add    $0x18,%esp
}
  8018a5:	90                   	nop
  8018a6:	c9                   	leave  
  8018a7:	c3                   	ret    

008018a8 <sys_cputc>:


void
sys_cputc(const char c)
{
  8018a8:	55                   	push   %ebp
  8018a9:	89 e5                	mov    %esp,%ebp
  8018ab:	83 ec 04             	sub    $0x4,%esp
  8018ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8018b4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 00                	push   $0x0
  8018be:	6a 00                	push   $0x0
  8018c0:	50                   	push   %eax
  8018c1:	6a 16                	push   $0x16
  8018c3:	e8 70 fd ff ff       	call   801638 <syscall>
  8018c8:	83 c4 18             	add    $0x18,%esp
}
  8018cb:	90                   	nop
  8018cc:	c9                   	leave  
  8018cd:	c3                   	ret    

008018ce <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8018ce:	55                   	push   %ebp
  8018cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 17                	push   $0x17
  8018dd:	e8 56 fd ff ff       	call   801638 <syscall>
  8018e2:	83 c4 18             	add    $0x18,%esp
}
  8018e5:	90                   	nop
  8018e6:	c9                   	leave  
  8018e7:	c3                   	ret    

008018e8 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8018e8:	55                   	push   %ebp
  8018e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8018eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ee:	6a 00                	push   $0x0
  8018f0:	6a 00                	push   $0x0
  8018f2:	6a 00                	push   $0x0
  8018f4:	ff 75 0c             	pushl  0xc(%ebp)
  8018f7:	50                   	push   %eax
  8018f8:	6a 18                	push   $0x18
  8018fa:	e8 39 fd ff ff       	call   801638 <syscall>
  8018ff:	83 c4 18             	add    $0x18,%esp
}
  801902:	c9                   	leave  
  801903:	c3                   	ret    

00801904 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801904:	55                   	push   %ebp
  801905:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801907:	8b 55 0c             	mov    0xc(%ebp),%edx
  80190a:	8b 45 08             	mov    0x8(%ebp),%eax
  80190d:	6a 00                	push   $0x0
  80190f:	6a 00                	push   $0x0
  801911:	6a 00                	push   $0x0
  801913:	52                   	push   %edx
  801914:	50                   	push   %eax
  801915:	6a 1b                	push   $0x1b
  801917:	e8 1c fd ff ff       	call   801638 <syscall>
  80191c:	83 c4 18             	add    $0x18,%esp
}
  80191f:	c9                   	leave  
  801920:	c3                   	ret    

00801921 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801921:	55                   	push   %ebp
  801922:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801924:	8b 55 0c             	mov    0xc(%ebp),%edx
  801927:	8b 45 08             	mov    0x8(%ebp),%eax
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	52                   	push   %edx
  801931:	50                   	push   %eax
  801932:	6a 19                	push   $0x19
  801934:	e8 ff fc ff ff       	call   801638 <syscall>
  801939:	83 c4 18             	add    $0x18,%esp
}
  80193c:	90                   	nop
  80193d:	c9                   	leave  
  80193e:	c3                   	ret    

0080193f <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80193f:	55                   	push   %ebp
  801940:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801942:	8b 55 0c             	mov    0xc(%ebp),%edx
  801945:	8b 45 08             	mov    0x8(%ebp),%eax
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 00                	push   $0x0
  80194e:	52                   	push   %edx
  80194f:	50                   	push   %eax
  801950:	6a 1a                	push   $0x1a
  801952:	e8 e1 fc ff ff       	call   801638 <syscall>
  801957:	83 c4 18             	add    $0x18,%esp
}
  80195a:	90                   	nop
  80195b:	c9                   	leave  
  80195c:	c3                   	ret    

0080195d <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80195d:	55                   	push   %ebp
  80195e:	89 e5                	mov    %esp,%ebp
  801960:	83 ec 04             	sub    $0x4,%esp
  801963:	8b 45 10             	mov    0x10(%ebp),%eax
  801966:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801969:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80196c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801970:	8b 45 08             	mov    0x8(%ebp),%eax
  801973:	6a 00                	push   $0x0
  801975:	51                   	push   %ecx
  801976:	52                   	push   %edx
  801977:	ff 75 0c             	pushl  0xc(%ebp)
  80197a:	50                   	push   %eax
  80197b:	6a 1c                	push   $0x1c
  80197d:	e8 b6 fc ff ff       	call   801638 <syscall>
  801982:	83 c4 18             	add    $0x18,%esp
}
  801985:	c9                   	leave  
  801986:	c3                   	ret    

00801987 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801987:	55                   	push   %ebp
  801988:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80198a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80198d:	8b 45 08             	mov    0x8(%ebp),%eax
  801990:	6a 00                	push   $0x0
  801992:	6a 00                	push   $0x0
  801994:	6a 00                	push   $0x0
  801996:	52                   	push   %edx
  801997:	50                   	push   %eax
  801998:	6a 1d                	push   $0x1d
  80199a:	e8 99 fc ff ff       	call   801638 <syscall>
  80199f:	83 c4 18             	add    $0x18,%esp
}
  8019a2:	c9                   	leave  
  8019a3:	c3                   	ret    

008019a4 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8019a4:	55                   	push   %ebp
  8019a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8019a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b0:	6a 00                	push   $0x0
  8019b2:	6a 00                	push   $0x0
  8019b4:	51                   	push   %ecx
  8019b5:	52                   	push   %edx
  8019b6:	50                   	push   %eax
  8019b7:	6a 1e                	push   $0x1e
  8019b9:	e8 7a fc ff ff       	call   801638 <syscall>
  8019be:	83 c4 18             	add    $0x18,%esp
}
  8019c1:	c9                   	leave  
  8019c2:	c3                   	ret    

008019c3 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8019c3:	55                   	push   %ebp
  8019c4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8019c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cc:	6a 00                	push   $0x0
  8019ce:	6a 00                	push   $0x0
  8019d0:	6a 00                	push   $0x0
  8019d2:	52                   	push   %edx
  8019d3:	50                   	push   %eax
  8019d4:	6a 1f                	push   $0x1f
  8019d6:	e8 5d fc ff ff       	call   801638 <syscall>
  8019db:	83 c4 18             	add    $0x18,%esp
}
  8019de:	c9                   	leave  
  8019df:	c3                   	ret    

008019e0 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8019e0:	55                   	push   %ebp
  8019e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 00                	push   $0x0
  8019e9:	6a 00                	push   $0x0
  8019eb:	6a 00                	push   $0x0
  8019ed:	6a 20                	push   $0x20
  8019ef:	e8 44 fc ff ff       	call   801638 <syscall>
  8019f4:	83 c4 18             	add    $0x18,%esp
}
  8019f7:	c9                   	leave  
  8019f8:	c3                   	ret    

008019f9 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8019f9:	55                   	push   %ebp
  8019fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8019fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ff:	6a 00                	push   $0x0
  801a01:	ff 75 14             	pushl  0x14(%ebp)
  801a04:	ff 75 10             	pushl  0x10(%ebp)
  801a07:	ff 75 0c             	pushl  0xc(%ebp)
  801a0a:	50                   	push   %eax
  801a0b:	6a 21                	push   $0x21
  801a0d:	e8 26 fc ff ff       	call   801638 <syscall>
  801a12:	83 c4 18             	add    $0x18,%esp
}
  801a15:	c9                   	leave  
  801a16:	c3                   	ret    

00801a17 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801a17:	55                   	push   %ebp
  801a18:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801a1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1d:	6a 00                	push   $0x0
  801a1f:	6a 00                	push   $0x0
  801a21:	6a 00                	push   $0x0
  801a23:	6a 00                	push   $0x0
  801a25:	50                   	push   %eax
  801a26:	6a 22                	push   $0x22
  801a28:	e8 0b fc ff ff       	call   801638 <syscall>
  801a2d:	83 c4 18             	add    $0x18,%esp
}
  801a30:	90                   	nop
  801a31:	c9                   	leave  
  801a32:	c3                   	ret    

00801a33 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801a33:	55                   	push   %ebp
  801a34:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801a36:	8b 45 08             	mov    0x8(%ebp),%eax
  801a39:	6a 00                	push   $0x0
  801a3b:	6a 00                	push   $0x0
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 00                	push   $0x0
  801a41:	50                   	push   %eax
  801a42:	6a 23                	push   $0x23
  801a44:	e8 ef fb ff ff       	call   801638 <syscall>
  801a49:	83 c4 18             	add    $0x18,%esp
}
  801a4c:	90                   	nop
  801a4d:	c9                   	leave  
  801a4e:	c3                   	ret    

00801a4f <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801a4f:	55                   	push   %ebp
  801a50:	89 e5                	mov    %esp,%ebp
  801a52:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801a55:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a58:	8d 50 04             	lea    0x4(%eax),%edx
  801a5b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a5e:	6a 00                	push   $0x0
  801a60:	6a 00                	push   $0x0
  801a62:	6a 00                	push   $0x0
  801a64:	52                   	push   %edx
  801a65:	50                   	push   %eax
  801a66:	6a 24                	push   $0x24
  801a68:	e8 cb fb ff ff       	call   801638 <syscall>
  801a6d:	83 c4 18             	add    $0x18,%esp
	return result;
  801a70:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a73:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a76:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a79:	89 01                	mov    %eax,(%ecx)
  801a7b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801a7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a81:	c9                   	leave  
  801a82:	c2 04 00             	ret    $0x4

00801a85 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a85:	55                   	push   %ebp
  801a86:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a88:	6a 00                	push   $0x0
  801a8a:	6a 00                	push   $0x0
  801a8c:	ff 75 10             	pushl  0x10(%ebp)
  801a8f:	ff 75 0c             	pushl  0xc(%ebp)
  801a92:	ff 75 08             	pushl  0x8(%ebp)
  801a95:	6a 13                	push   $0x13
  801a97:	e8 9c fb ff ff       	call   801638 <syscall>
  801a9c:	83 c4 18             	add    $0x18,%esp
	return ;
  801a9f:	90                   	nop
}
  801aa0:	c9                   	leave  
  801aa1:	c3                   	ret    

00801aa2 <sys_rcr2>:
uint32 sys_rcr2()
{
  801aa2:	55                   	push   %ebp
  801aa3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801aa5:	6a 00                	push   $0x0
  801aa7:	6a 00                	push   $0x0
  801aa9:	6a 00                	push   $0x0
  801aab:	6a 00                	push   $0x0
  801aad:	6a 00                	push   $0x0
  801aaf:	6a 25                	push   $0x25
  801ab1:	e8 82 fb ff ff       	call   801638 <syscall>
  801ab6:	83 c4 18             	add    $0x18,%esp
}
  801ab9:	c9                   	leave  
  801aba:	c3                   	ret    

00801abb <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801abb:	55                   	push   %ebp
  801abc:	89 e5                	mov    %esp,%ebp
  801abe:	83 ec 04             	sub    $0x4,%esp
  801ac1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801ac7:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	6a 00                	push   $0x0
  801ad1:	6a 00                	push   $0x0
  801ad3:	50                   	push   %eax
  801ad4:	6a 26                	push   $0x26
  801ad6:	e8 5d fb ff ff       	call   801638 <syscall>
  801adb:	83 c4 18             	add    $0x18,%esp
	return ;
  801ade:	90                   	nop
}
  801adf:	c9                   	leave  
  801ae0:	c3                   	ret    

00801ae1 <rsttst>:
void rsttst()
{
  801ae1:	55                   	push   %ebp
  801ae2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	6a 00                	push   $0x0
  801aec:	6a 00                	push   $0x0
  801aee:	6a 28                	push   $0x28
  801af0:	e8 43 fb ff ff       	call   801638 <syscall>
  801af5:	83 c4 18             	add    $0x18,%esp
	return ;
  801af8:	90                   	nop
}
  801af9:	c9                   	leave  
  801afa:	c3                   	ret    

00801afb <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801afb:	55                   	push   %ebp
  801afc:	89 e5                	mov    %esp,%ebp
  801afe:	83 ec 04             	sub    $0x4,%esp
  801b01:	8b 45 14             	mov    0x14(%ebp),%eax
  801b04:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801b07:	8b 55 18             	mov    0x18(%ebp),%edx
  801b0a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801b0e:	52                   	push   %edx
  801b0f:	50                   	push   %eax
  801b10:	ff 75 10             	pushl  0x10(%ebp)
  801b13:	ff 75 0c             	pushl  0xc(%ebp)
  801b16:	ff 75 08             	pushl  0x8(%ebp)
  801b19:	6a 27                	push   $0x27
  801b1b:	e8 18 fb ff ff       	call   801638 <syscall>
  801b20:	83 c4 18             	add    $0x18,%esp
	return ;
  801b23:	90                   	nop
}
  801b24:	c9                   	leave  
  801b25:	c3                   	ret    

00801b26 <chktst>:
void chktst(uint32 n)
{
  801b26:	55                   	push   %ebp
  801b27:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801b29:	6a 00                	push   $0x0
  801b2b:	6a 00                	push   $0x0
  801b2d:	6a 00                	push   $0x0
  801b2f:	6a 00                	push   $0x0
  801b31:	ff 75 08             	pushl  0x8(%ebp)
  801b34:	6a 29                	push   $0x29
  801b36:	e8 fd fa ff ff       	call   801638 <syscall>
  801b3b:	83 c4 18             	add    $0x18,%esp
	return ;
  801b3e:	90                   	nop
}
  801b3f:	c9                   	leave  
  801b40:	c3                   	ret    

00801b41 <inctst>:

void inctst()
{
  801b41:	55                   	push   %ebp
  801b42:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801b44:	6a 00                	push   $0x0
  801b46:	6a 00                	push   $0x0
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	6a 2a                	push   $0x2a
  801b50:	e8 e3 fa ff ff       	call   801638 <syscall>
  801b55:	83 c4 18             	add    $0x18,%esp
	return ;
  801b58:	90                   	nop
}
  801b59:	c9                   	leave  
  801b5a:	c3                   	ret    

00801b5b <gettst>:
uint32 gettst()
{
  801b5b:	55                   	push   %ebp
  801b5c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 00                	push   $0x0
  801b62:	6a 00                	push   $0x0
  801b64:	6a 00                	push   $0x0
  801b66:	6a 00                	push   $0x0
  801b68:	6a 2b                	push   $0x2b
  801b6a:	e8 c9 fa ff ff       	call   801638 <syscall>
  801b6f:	83 c4 18             	add    $0x18,%esp
}
  801b72:	c9                   	leave  
  801b73:	c3                   	ret    

00801b74 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801b74:	55                   	push   %ebp
  801b75:	89 e5                	mov    %esp,%ebp
  801b77:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b7a:	6a 00                	push   $0x0
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	6a 2c                	push   $0x2c
  801b86:	e8 ad fa ff ff       	call   801638 <syscall>
  801b8b:	83 c4 18             	add    $0x18,%esp
  801b8e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801b91:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801b95:	75 07                	jne    801b9e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801b97:	b8 01 00 00 00       	mov    $0x1,%eax
  801b9c:	eb 05                	jmp    801ba3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801b9e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ba3:	c9                   	leave  
  801ba4:	c3                   	ret    

00801ba5 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801ba5:	55                   	push   %ebp
  801ba6:	89 e5                	mov    %esp,%ebp
  801ba8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 00                	push   $0x0
  801bb5:	6a 2c                	push   $0x2c
  801bb7:	e8 7c fa ff ff       	call   801638 <syscall>
  801bbc:	83 c4 18             	add    $0x18,%esp
  801bbf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801bc2:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801bc6:	75 07                	jne    801bcf <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801bc8:	b8 01 00 00 00       	mov    $0x1,%eax
  801bcd:	eb 05                	jmp    801bd4 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801bcf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bd4:	c9                   	leave  
  801bd5:	c3                   	ret    

00801bd6 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801bd6:	55                   	push   %ebp
  801bd7:	89 e5                	mov    %esp,%ebp
  801bd9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bdc:	6a 00                	push   $0x0
  801bde:	6a 00                	push   $0x0
  801be0:	6a 00                	push   $0x0
  801be2:	6a 00                	push   $0x0
  801be4:	6a 00                	push   $0x0
  801be6:	6a 2c                	push   $0x2c
  801be8:	e8 4b fa ff ff       	call   801638 <syscall>
  801bed:	83 c4 18             	add    $0x18,%esp
  801bf0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801bf3:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801bf7:	75 07                	jne    801c00 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801bf9:	b8 01 00 00 00       	mov    $0x1,%eax
  801bfe:	eb 05                	jmp    801c05 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801c00:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c05:	c9                   	leave  
  801c06:	c3                   	ret    

00801c07 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801c07:	55                   	push   %ebp
  801c08:	89 e5                	mov    %esp,%ebp
  801c0a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c0d:	6a 00                	push   $0x0
  801c0f:	6a 00                	push   $0x0
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	6a 2c                	push   $0x2c
  801c19:	e8 1a fa ff ff       	call   801638 <syscall>
  801c1e:	83 c4 18             	add    $0x18,%esp
  801c21:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801c24:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801c28:	75 07                	jne    801c31 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801c2a:	b8 01 00 00 00       	mov    $0x1,%eax
  801c2f:	eb 05                	jmp    801c36 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801c31:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c36:	c9                   	leave  
  801c37:	c3                   	ret    

00801c38 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801c38:	55                   	push   %ebp
  801c39:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801c3b:	6a 00                	push   $0x0
  801c3d:	6a 00                	push   $0x0
  801c3f:	6a 00                	push   $0x0
  801c41:	6a 00                	push   $0x0
  801c43:	ff 75 08             	pushl  0x8(%ebp)
  801c46:	6a 2d                	push   $0x2d
  801c48:	e8 eb f9 ff ff       	call   801638 <syscall>
  801c4d:	83 c4 18             	add    $0x18,%esp
	return ;
  801c50:	90                   	nop
}
  801c51:	c9                   	leave  
  801c52:	c3                   	ret    

00801c53 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801c53:	55                   	push   %ebp
  801c54:	89 e5                	mov    %esp,%ebp
  801c56:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801c57:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c5a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c5d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c60:	8b 45 08             	mov    0x8(%ebp),%eax
  801c63:	6a 00                	push   $0x0
  801c65:	53                   	push   %ebx
  801c66:	51                   	push   %ecx
  801c67:	52                   	push   %edx
  801c68:	50                   	push   %eax
  801c69:	6a 2e                	push   $0x2e
  801c6b:	e8 c8 f9 ff ff       	call   801638 <syscall>
  801c70:	83 c4 18             	add    $0x18,%esp
}
  801c73:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801c76:	c9                   	leave  
  801c77:	c3                   	ret    

00801c78 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801c78:	55                   	push   %ebp
  801c79:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801c7b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c81:	6a 00                	push   $0x0
  801c83:	6a 00                	push   $0x0
  801c85:	6a 00                	push   $0x0
  801c87:	52                   	push   %edx
  801c88:	50                   	push   %eax
  801c89:	6a 2f                	push   $0x2f
  801c8b:	e8 a8 f9 ff ff       	call   801638 <syscall>
  801c90:	83 c4 18             	add    $0x18,%esp
}
  801c93:	c9                   	leave  
  801c94:	c3                   	ret    
  801c95:	66 90                	xchg   %ax,%ax
  801c97:	90                   	nop

00801c98 <__udivdi3>:
  801c98:	55                   	push   %ebp
  801c99:	57                   	push   %edi
  801c9a:	56                   	push   %esi
  801c9b:	53                   	push   %ebx
  801c9c:	83 ec 1c             	sub    $0x1c,%esp
  801c9f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ca3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801ca7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801cab:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801caf:	89 ca                	mov    %ecx,%edx
  801cb1:	89 f8                	mov    %edi,%eax
  801cb3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801cb7:	85 f6                	test   %esi,%esi
  801cb9:	75 2d                	jne    801ce8 <__udivdi3+0x50>
  801cbb:	39 cf                	cmp    %ecx,%edi
  801cbd:	77 65                	ja     801d24 <__udivdi3+0x8c>
  801cbf:	89 fd                	mov    %edi,%ebp
  801cc1:	85 ff                	test   %edi,%edi
  801cc3:	75 0b                	jne    801cd0 <__udivdi3+0x38>
  801cc5:	b8 01 00 00 00       	mov    $0x1,%eax
  801cca:	31 d2                	xor    %edx,%edx
  801ccc:	f7 f7                	div    %edi
  801cce:	89 c5                	mov    %eax,%ebp
  801cd0:	31 d2                	xor    %edx,%edx
  801cd2:	89 c8                	mov    %ecx,%eax
  801cd4:	f7 f5                	div    %ebp
  801cd6:	89 c1                	mov    %eax,%ecx
  801cd8:	89 d8                	mov    %ebx,%eax
  801cda:	f7 f5                	div    %ebp
  801cdc:	89 cf                	mov    %ecx,%edi
  801cde:	89 fa                	mov    %edi,%edx
  801ce0:	83 c4 1c             	add    $0x1c,%esp
  801ce3:	5b                   	pop    %ebx
  801ce4:	5e                   	pop    %esi
  801ce5:	5f                   	pop    %edi
  801ce6:	5d                   	pop    %ebp
  801ce7:	c3                   	ret    
  801ce8:	39 ce                	cmp    %ecx,%esi
  801cea:	77 28                	ja     801d14 <__udivdi3+0x7c>
  801cec:	0f bd fe             	bsr    %esi,%edi
  801cef:	83 f7 1f             	xor    $0x1f,%edi
  801cf2:	75 40                	jne    801d34 <__udivdi3+0x9c>
  801cf4:	39 ce                	cmp    %ecx,%esi
  801cf6:	72 0a                	jb     801d02 <__udivdi3+0x6a>
  801cf8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801cfc:	0f 87 9e 00 00 00    	ja     801da0 <__udivdi3+0x108>
  801d02:	b8 01 00 00 00       	mov    $0x1,%eax
  801d07:	89 fa                	mov    %edi,%edx
  801d09:	83 c4 1c             	add    $0x1c,%esp
  801d0c:	5b                   	pop    %ebx
  801d0d:	5e                   	pop    %esi
  801d0e:	5f                   	pop    %edi
  801d0f:	5d                   	pop    %ebp
  801d10:	c3                   	ret    
  801d11:	8d 76 00             	lea    0x0(%esi),%esi
  801d14:	31 ff                	xor    %edi,%edi
  801d16:	31 c0                	xor    %eax,%eax
  801d18:	89 fa                	mov    %edi,%edx
  801d1a:	83 c4 1c             	add    $0x1c,%esp
  801d1d:	5b                   	pop    %ebx
  801d1e:	5e                   	pop    %esi
  801d1f:	5f                   	pop    %edi
  801d20:	5d                   	pop    %ebp
  801d21:	c3                   	ret    
  801d22:	66 90                	xchg   %ax,%ax
  801d24:	89 d8                	mov    %ebx,%eax
  801d26:	f7 f7                	div    %edi
  801d28:	31 ff                	xor    %edi,%edi
  801d2a:	89 fa                	mov    %edi,%edx
  801d2c:	83 c4 1c             	add    $0x1c,%esp
  801d2f:	5b                   	pop    %ebx
  801d30:	5e                   	pop    %esi
  801d31:	5f                   	pop    %edi
  801d32:	5d                   	pop    %ebp
  801d33:	c3                   	ret    
  801d34:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d39:	89 eb                	mov    %ebp,%ebx
  801d3b:	29 fb                	sub    %edi,%ebx
  801d3d:	89 f9                	mov    %edi,%ecx
  801d3f:	d3 e6                	shl    %cl,%esi
  801d41:	89 c5                	mov    %eax,%ebp
  801d43:	88 d9                	mov    %bl,%cl
  801d45:	d3 ed                	shr    %cl,%ebp
  801d47:	89 e9                	mov    %ebp,%ecx
  801d49:	09 f1                	or     %esi,%ecx
  801d4b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801d4f:	89 f9                	mov    %edi,%ecx
  801d51:	d3 e0                	shl    %cl,%eax
  801d53:	89 c5                	mov    %eax,%ebp
  801d55:	89 d6                	mov    %edx,%esi
  801d57:	88 d9                	mov    %bl,%cl
  801d59:	d3 ee                	shr    %cl,%esi
  801d5b:	89 f9                	mov    %edi,%ecx
  801d5d:	d3 e2                	shl    %cl,%edx
  801d5f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d63:	88 d9                	mov    %bl,%cl
  801d65:	d3 e8                	shr    %cl,%eax
  801d67:	09 c2                	or     %eax,%edx
  801d69:	89 d0                	mov    %edx,%eax
  801d6b:	89 f2                	mov    %esi,%edx
  801d6d:	f7 74 24 0c          	divl   0xc(%esp)
  801d71:	89 d6                	mov    %edx,%esi
  801d73:	89 c3                	mov    %eax,%ebx
  801d75:	f7 e5                	mul    %ebp
  801d77:	39 d6                	cmp    %edx,%esi
  801d79:	72 19                	jb     801d94 <__udivdi3+0xfc>
  801d7b:	74 0b                	je     801d88 <__udivdi3+0xf0>
  801d7d:	89 d8                	mov    %ebx,%eax
  801d7f:	31 ff                	xor    %edi,%edi
  801d81:	e9 58 ff ff ff       	jmp    801cde <__udivdi3+0x46>
  801d86:	66 90                	xchg   %ax,%ax
  801d88:	8b 54 24 08          	mov    0x8(%esp),%edx
  801d8c:	89 f9                	mov    %edi,%ecx
  801d8e:	d3 e2                	shl    %cl,%edx
  801d90:	39 c2                	cmp    %eax,%edx
  801d92:	73 e9                	jae    801d7d <__udivdi3+0xe5>
  801d94:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801d97:	31 ff                	xor    %edi,%edi
  801d99:	e9 40 ff ff ff       	jmp    801cde <__udivdi3+0x46>
  801d9e:	66 90                	xchg   %ax,%ax
  801da0:	31 c0                	xor    %eax,%eax
  801da2:	e9 37 ff ff ff       	jmp    801cde <__udivdi3+0x46>
  801da7:	90                   	nop

00801da8 <__umoddi3>:
  801da8:	55                   	push   %ebp
  801da9:	57                   	push   %edi
  801daa:	56                   	push   %esi
  801dab:	53                   	push   %ebx
  801dac:	83 ec 1c             	sub    $0x1c,%esp
  801daf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801db3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801db7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801dbb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801dbf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801dc3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801dc7:	89 f3                	mov    %esi,%ebx
  801dc9:	89 fa                	mov    %edi,%edx
  801dcb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801dcf:	89 34 24             	mov    %esi,(%esp)
  801dd2:	85 c0                	test   %eax,%eax
  801dd4:	75 1a                	jne    801df0 <__umoddi3+0x48>
  801dd6:	39 f7                	cmp    %esi,%edi
  801dd8:	0f 86 a2 00 00 00    	jbe    801e80 <__umoddi3+0xd8>
  801dde:	89 c8                	mov    %ecx,%eax
  801de0:	89 f2                	mov    %esi,%edx
  801de2:	f7 f7                	div    %edi
  801de4:	89 d0                	mov    %edx,%eax
  801de6:	31 d2                	xor    %edx,%edx
  801de8:	83 c4 1c             	add    $0x1c,%esp
  801deb:	5b                   	pop    %ebx
  801dec:	5e                   	pop    %esi
  801ded:	5f                   	pop    %edi
  801dee:	5d                   	pop    %ebp
  801def:	c3                   	ret    
  801df0:	39 f0                	cmp    %esi,%eax
  801df2:	0f 87 ac 00 00 00    	ja     801ea4 <__umoddi3+0xfc>
  801df8:	0f bd e8             	bsr    %eax,%ebp
  801dfb:	83 f5 1f             	xor    $0x1f,%ebp
  801dfe:	0f 84 ac 00 00 00    	je     801eb0 <__umoddi3+0x108>
  801e04:	bf 20 00 00 00       	mov    $0x20,%edi
  801e09:	29 ef                	sub    %ebp,%edi
  801e0b:	89 fe                	mov    %edi,%esi
  801e0d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e11:	89 e9                	mov    %ebp,%ecx
  801e13:	d3 e0                	shl    %cl,%eax
  801e15:	89 d7                	mov    %edx,%edi
  801e17:	89 f1                	mov    %esi,%ecx
  801e19:	d3 ef                	shr    %cl,%edi
  801e1b:	09 c7                	or     %eax,%edi
  801e1d:	89 e9                	mov    %ebp,%ecx
  801e1f:	d3 e2                	shl    %cl,%edx
  801e21:	89 14 24             	mov    %edx,(%esp)
  801e24:	89 d8                	mov    %ebx,%eax
  801e26:	d3 e0                	shl    %cl,%eax
  801e28:	89 c2                	mov    %eax,%edx
  801e2a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e2e:	d3 e0                	shl    %cl,%eax
  801e30:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e34:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e38:	89 f1                	mov    %esi,%ecx
  801e3a:	d3 e8                	shr    %cl,%eax
  801e3c:	09 d0                	or     %edx,%eax
  801e3e:	d3 eb                	shr    %cl,%ebx
  801e40:	89 da                	mov    %ebx,%edx
  801e42:	f7 f7                	div    %edi
  801e44:	89 d3                	mov    %edx,%ebx
  801e46:	f7 24 24             	mull   (%esp)
  801e49:	89 c6                	mov    %eax,%esi
  801e4b:	89 d1                	mov    %edx,%ecx
  801e4d:	39 d3                	cmp    %edx,%ebx
  801e4f:	0f 82 87 00 00 00    	jb     801edc <__umoddi3+0x134>
  801e55:	0f 84 91 00 00 00    	je     801eec <__umoddi3+0x144>
  801e5b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801e5f:	29 f2                	sub    %esi,%edx
  801e61:	19 cb                	sbb    %ecx,%ebx
  801e63:	89 d8                	mov    %ebx,%eax
  801e65:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801e69:	d3 e0                	shl    %cl,%eax
  801e6b:	89 e9                	mov    %ebp,%ecx
  801e6d:	d3 ea                	shr    %cl,%edx
  801e6f:	09 d0                	or     %edx,%eax
  801e71:	89 e9                	mov    %ebp,%ecx
  801e73:	d3 eb                	shr    %cl,%ebx
  801e75:	89 da                	mov    %ebx,%edx
  801e77:	83 c4 1c             	add    $0x1c,%esp
  801e7a:	5b                   	pop    %ebx
  801e7b:	5e                   	pop    %esi
  801e7c:	5f                   	pop    %edi
  801e7d:	5d                   	pop    %ebp
  801e7e:	c3                   	ret    
  801e7f:	90                   	nop
  801e80:	89 fd                	mov    %edi,%ebp
  801e82:	85 ff                	test   %edi,%edi
  801e84:	75 0b                	jne    801e91 <__umoddi3+0xe9>
  801e86:	b8 01 00 00 00       	mov    $0x1,%eax
  801e8b:	31 d2                	xor    %edx,%edx
  801e8d:	f7 f7                	div    %edi
  801e8f:	89 c5                	mov    %eax,%ebp
  801e91:	89 f0                	mov    %esi,%eax
  801e93:	31 d2                	xor    %edx,%edx
  801e95:	f7 f5                	div    %ebp
  801e97:	89 c8                	mov    %ecx,%eax
  801e99:	f7 f5                	div    %ebp
  801e9b:	89 d0                	mov    %edx,%eax
  801e9d:	e9 44 ff ff ff       	jmp    801de6 <__umoddi3+0x3e>
  801ea2:	66 90                	xchg   %ax,%ax
  801ea4:	89 c8                	mov    %ecx,%eax
  801ea6:	89 f2                	mov    %esi,%edx
  801ea8:	83 c4 1c             	add    $0x1c,%esp
  801eab:	5b                   	pop    %ebx
  801eac:	5e                   	pop    %esi
  801ead:	5f                   	pop    %edi
  801eae:	5d                   	pop    %ebp
  801eaf:	c3                   	ret    
  801eb0:	3b 04 24             	cmp    (%esp),%eax
  801eb3:	72 06                	jb     801ebb <__umoddi3+0x113>
  801eb5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801eb9:	77 0f                	ja     801eca <__umoddi3+0x122>
  801ebb:	89 f2                	mov    %esi,%edx
  801ebd:	29 f9                	sub    %edi,%ecx
  801ebf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801ec3:	89 14 24             	mov    %edx,(%esp)
  801ec6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801eca:	8b 44 24 04          	mov    0x4(%esp),%eax
  801ece:	8b 14 24             	mov    (%esp),%edx
  801ed1:	83 c4 1c             	add    $0x1c,%esp
  801ed4:	5b                   	pop    %ebx
  801ed5:	5e                   	pop    %esi
  801ed6:	5f                   	pop    %edi
  801ed7:	5d                   	pop    %ebp
  801ed8:	c3                   	ret    
  801ed9:	8d 76 00             	lea    0x0(%esi),%esi
  801edc:	2b 04 24             	sub    (%esp),%eax
  801edf:	19 fa                	sbb    %edi,%edx
  801ee1:	89 d1                	mov    %edx,%ecx
  801ee3:	89 c6                	mov    %eax,%esi
  801ee5:	e9 71 ff ff ff       	jmp    801e5b <__umoddi3+0xb3>
  801eea:	66 90                	xchg   %ax,%ax
  801eec:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ef0:	72 ea                	jb     801edc <__umoddi3+0x134>
  801ef2:	89 d9                	mov    %ebx,%ecx
  801ef4:	e9 62 ff ff ff       	jmp    801e5b <__umoddi3+0xb3>
