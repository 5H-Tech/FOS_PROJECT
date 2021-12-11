
obj/user/tst_table_replacement_clock:     file format elf32-i386


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
  800031:	e8 93 02 00 00       	call   8002c9 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:


uint8* ptr = (uint8* )0x0800000 ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 38 00 00 02    	sub    $0x2000038,%esp

	
	

	{
		if ( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0x00000000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800041:	a1 20 30 80 00       	mov    0x803020,%eax
  800046:	8b 80 f8 38 01 00    	mov    0x138f8(%eax),%eax
  80004c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80004f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800052:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800057:	85 c0                	test   %eax,%eax
  800059:	74 14                	je     80006f <_main+0x37>
  80005b:	83 ec 04             	sub    $0x4,%esp
  80005e:	68 00 1d 80 00       	push   $0x801d00
  800063:	6a 16                	push   $0x16
  800065:	68 48 1d 80 00       	push   $0x801d48
  80006a:	e8 9f 03 00 00       	call   80040e <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x00800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  80006f:	a1 20 30 80 00       	mov    0x803020,%eax
  800074:	8b 80 08 39 01 00    	mov    0x13908(%eax),%eax
  80007a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80007d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800080:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800085:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80008a:	74 14                	je     8000a0 <_main+0x68>
  80008c:	83 ec 04             	sub    $0x4,%esp
  80008f:	68 00 1d 80 00       	push   $0x801d00
  800094:	6a 17                	push   $0x17
  800096:	68 48 1d 80 00       	push   $0x801d48
  80009b:	e8 6e 03 00 00       	call   80040e <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xee800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000a0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000a5:	8b 80 18 39 01 00    	mov    0x13918(%eax),%eax
  8000ab:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8000ae:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000b1:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8000b6:	3d 00 00 80 ee       	cmp    $0xee800000,%eax
  8000bb:	74 14                	je     8000d1 <_main+0x99>
  8000bd:	83 ec 04             	sub    $0x4,%esp
  8000c0:	68 00 1d 80 00       	push   $0x801d00
  8000c5:	6a 18                	push   $0x18
  8000c7:	68 48 1d 80 00       	push   $0x801d48
  8000cc:	e8 3d 03 00 00       	call   80040e <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[3].virtual_address,1024*PAGE_SIZE) !=  0xec800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000d1:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d6:	8b 80 28 39 01 00    	mov    0x13928(%eax),%eax
  8000dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000e2:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8000e7:	3d 00 00 80 ec       	cmp    $0xec800000,%eax
  8000ec:	74 14                	je     800102 <_main+0xca>
  8000ee:	83 ec 04             	sub    $0x4,%esp
  8000f1:	68 00 1d 80 00       	push   $0x801d00
  8000f6:	6a 19                	push   $0x19
  8000f8:	68 48 1d 80 00       	push   $0x801d48
  8000fd:	e8 0c 03 00 00       	call   80040e <_panic>
		if( myEnv->table_last_WS_index !=  4)  											panic("INITIAL TABLE last index checking failed! Review sizes of the two WS's..!!");
  800102:	a1 20 30 80 00       	mov    0x803020,%eax
  800107:	8b 80 1c 3c 01 00    	mov    0x13c1c(%eax),%eax
  80010d:	83 f8 04             	cmp    $0x4,%eax
  800110:	74 14                	je     800126 <_main+0xee>
  800112:	83 ec 04             	sub    $0x4,%esp
  800115:	68 6c 1d 80 00       	push   $0x801d6c
  80011a:	6a 1a                	push   $0x1a
  80011c:	68 48 1d 80 00       	push   $0x801d48
  800121:	e8 e8 02 00 00       	call   80040e <_panic>

	}
	int freeFrames = sys_calculate_free_frames() ;
  800126:	e8 7b 14 00 00       	call   8015a6 <sys_calculate_free_frames>
  80012b:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  80012e:	e8 f6 14 00 00       	call   801629 <sys_pf_calculate_allocated_pages>
  800133:	89 45 dc             	mov    %eax,-0x24(%ebp)

	{
		arr[0] = -1;
  800136:	c6 85 c8 ff ff fd ff 	movb   $0xff,-0x2000038(%ebp)
		arr[PAGE_SIZE*1024-1] = -1;
  80013d:	c6 85 c7 ff 3f fe ff 	movb   $0xff,-0x1c00039(%ebp)

		int i ;
		for (i = 0 ; i < PAGE_SIZE * 2; i++)
  800144:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80014b:	eb 33                	jmp    800180 <_main+0x148>
		{
			arr[PAGE_SIZE*1024*2 - i] = -20;
  80014d:	b8 00 00 80 00       	mov    $0x800000,%eax
  800152:	2b 45 f4             	sub    -0xc(%ebp),%eax
  800155:	c6 84 05 c8 ff ff fd 	movb   $0xec,-0x2000038(%ebp,%eax,1)
  80015c:	ec 
			arr[PAGE_SIZE*1024*3 - i] = -30;
  80015d:	b8 00 00 c0 00       	mov    $0xc00000,%eax
  800162:	2b 45 f4             	sub    -0xc(%ebp),%eax
  800165:	c6 84 05 c8 ff ff fd 	movb   $0xe2,-0x2000038(%ebp,%eax,1)
  80016c:	e2 
			arr[PAGE_SIZE*1024*4 - i] = -40;
  80016d:	b8 00 00 00 01       	mov    $0x1000000,%eax
  800172:	2b 45 f4             	sub    -0xc(%ebp),%eax
  800175:	c6 84 05 c8 ff ff fd 	movb   $0xd8,-0x2000038(%ebp,%eax,1)
  80017c:	d8 
	{
		arr[0] = -1;
		arr[PAGE_SIZE*1024-1] = -1;

		int i ;
		for (i = 0 ; i < PAGE_SIZE * 2; i++)
  80017d:	ff 45 f4             	incl   -0xc(%ebp)
  800180:	81 7d f4 ff 1f 00 00 	cmpl   $0x1fff,-0xc(%ebp)
  800187:	7e c4                	jle    80014d <_main+0x115>
		{
			arr[PAGE_SIZE*1024*2 - i] = -20;
			arr[PAGE_SIZE*1024*3 - i] = -30;
			arr[PAGE_SIZE*1024*4 - i] = -40;
		}
		arr[PAGE_SIZE*1024*5-1] = -1;
  800189:	c6 85 c7 ff 3f ff ff 	movb   $0xff,-0xc00039(%ebp)
		arr[PAGE_SIZE*1024*6-1] = -1;
  800190:	c6 85 c7 ff 7f ff ff 	movb   $0xff,-0x800039(%ebp)
		arr[PAGE_SIZE*1024*7-1] = -1;
  800197:	c6 85 c7 ff bf ff ff 	movb   $0xff,-0x400039(%ebp)

	}

	//cprintf("testing ...\n");
	{
		if( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0xedc00000)  panic("clock algo failed.. trace it by printing WS before and after table fault");
  80019e:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a3:	8b 80 f8 38 01 00    	mov    0x138f8(%eax),%eax
  8001a9:	89 45 d8             	mov    %eax,-0x28(%ebp)
  8001ac:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8001af:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8001b4:	3d 00 00 c0 ed       	cmp    $0xedc00000,%eax
  8001b9:	74 14                	je     8001cf <_main+0x197>
  8001bb:	83 ec 04             	sub    $0x4,%esp
  8001be:	68 b8 1d 80 00       	push   $0x801db8
  8001c3:	6a 33                	push   $0x33
  8001c5:	68 48 1d 80 00       	push   $0x801d48
  8001ca:	e8 3f 02 00 00       	call   80040e <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x00800000)  panic("clock algo failed.. trace it by printing WS before and after table fault");
  8001cf:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d4:	8b 80 08 39 01 00    	mov    0x13908(%eax),%eax
  8001da:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8001dd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001e0:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8001e5:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001ea:	74 14                	je     800200 <_main+0x1c8>
  8001ec:	83 ec 04             	sub    $0x4,%esp
  8001ef:	68 b8 1d 80 00       	push   $0x801db8
  8001f4:	6a 34                	push   $0x34
  8001f6:	68 48 1d 80 00       	push   $0x801d48
  8001fb:	e8 0e 02 00 00       	call   80040e <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xee000000)  panic("clock algo failed.. trace it by printing WS before and after table fault");
  800200:	a1 20 30 80 00       	mov    0x803020,%eax
  800205:	8b 80 18 39 01 00    	mov    0x13918(%eax),%eax
  80020b:	89 45 d0             	mov    %eax,-0x30(%ebp)
  80020e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800211:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800216:	3d 00 00 00 ee       	cmp    $0xee000000,%eax
  80021b:	74 14                	je     800231 <_main+0x1f9>
  80021d:	83 ec 04             	sub    $0x4,%esp
  800220:	68 b8 1d 80 00       	push   $0x801db8
  800225:	6a 35                	push   $0x35
  800227:	68 48 1d 80 00       	push   $0x801d48
  80022c:	e8 dd 01 00 00       	call   80040e <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[3].virtual_address,1024*PAGE_SIZE) !=  0xee400000)  panic("clock algo failed.. trace it by printing WS before and after table fault");
  800231:	a1 20 30 80 00       	mov    0x803020,%eax
  800236:	8b 80 28 39 01 00    	mov    0x13928(%eax),%eax
  80023c:	89 45 cc             	mov    %eax,-0x34(%ebp)
  80023f:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800242:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800247:	3d 00 00 40 ee       	cmp    $0xee400000,%eax
  80024c:	74 14                	je     800262 <_main+0x22a>
  80024e:	83 ec 04             	sub    $0x4,%esp
  800251:	68 b8 1d 80 00       	push   $0x801db8
  800256:	6a 36                	push   $0x36
  800258:	68 48 1d 80 00       	push   $0x801d48
  80025d:	e8 ac 01 00 00       	call   80040e <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[4].virtual_address,1024*PAGE_SIZE) !=  0xec800000)  panic("clock algo failed.. trace it by printing WS before and after table fault");
  800262:	a1 20 30 80 00       	mov    0x803020,%eax
  800267:	8b 80 38 39 01 00    	mov    0x13938(%eax),%eax
  80026d:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800270:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800273:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800278:	3d 00 00 80 ec       	cmp    $0xec800000,%eax
  80027d:	74 14                	je     800293 <_main+0x25b>
  80027f:	83 ec 04             	sub    $0x4,%esp
  800282:	68 b8 1d 80 00       	push   $0x801db8
  800287:	6a 37                	push   $0x37
  800289:	68 48 1d 80 00       	push   $0x801d48
  80028e:	e8 7b 01 00 00       	call   80040e <_panic>

		if(myEnv->table_last_WS_index != 0) panic("wrong TABLE WS pointer location");
  800293:	a1 20 30 80 00       	mov    0x803020,%eax
  800298:	8b 80 1c 3c 01 00    	mov    0x13c1c(%eax),%eax
  80029e:	85 c0                	test   %eax,%eax
  8002a0:	74 14                	je     8002b6 <_main+0x27e>
  8002a2:	83 ec 04             	sub    $0x4,%esp
  8002a5:	68 04 1e 80 00       	push   $0x801e04
  8002aa:	6a 39                	push   $0x39
  8002ac:	68 48 1d 80 00       	push   $0x801d48
  8002b1:	e8 58 01 00 00       	call   80040e <_panic>
	}

	cprintf("Congratulations!! test table replacement (CLOCK alg) completed successfully.\n");
  8002b6:	83 ec 0c             	sub    $0xc,%esp
  8002b9:	68 24 1e 80 00       	push   $0x801e24
  8002be:	e8 ed 03 00 00       	call   8006b0 <cprintf>
  8002c3:	83 c4 10             	add    $0x10,%esp
	return;
  8002c6:	90                   	nop
}
  8002c7:	c9                   	leave  
  8002c8:	c3                   	ret    

008002c9 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8002c9:	55                   	push   %ebp
  8002ca:	89 e5                	mov    %esp,%ebp
  8002cc:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8002cf:	e8 07 12 00 00       	call   8014db <sys_getenvindex>
  8002d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8002d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002da:	89 d0                	mov    %edx,%eax
  8002dc:	c1 e0 03             	shl    $0x3,%eax
  8002df:	01 d0                	add    %edx,%eax
  8002e1:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8002e8:	01 c8                	add    %ecx,%eax
  8002ea:	01 c0                	add    %eax,%eax
  8002ec:	01 d0                	add    %edx,%eax
  8002ee:	01 c0                	add    %eax,%eax
  8002f0:	01 d0                	add    %edx,%eax
  8002f2:	89 c2                	mov    %eax,%edx
  8002f4:	c1 e2 05             	shl    $0x5,%edx
  8002f7:	29 c2                	sub    %eax,%edx
  8002f9:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800300:	89 c2                	mov    %eax,%edx
  800302:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800308:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80030d:	a1 20 30 80 00       	mov    0x803020,%eax
  800312:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800318:	84 c0                	test   %al,%al
  80031a:	74 0f                	je     80032b <libmain+0x62>
		binaryname = myEnv->prog_name;
  80031c:	a1 20 30 80 00       	mov    0x803020,%eax
  800321:	05 40 3c 01 00       	add    $0x13c40,%eax
  800326:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80032b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80032f:	7e 0a                	jle    80033b <libmain+0x72>
		binaryname = argv[0];
  800331:	8b 45 0c             	mov    0xc(%ebp),%eax
  800334:	8b 00                	mov    (%eax),%eax
  800336:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  80033b:	83 ec 08             	sub    $0x8,%esp
  80033e:	ff 75 0c             	pushl  0xc(%ebp)
  800341:	ff 75 08             	pushl  0x8(%ebp)
  800344:	e8 ef fc ff ff       	call   800038 <_main>
  800349:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80034c:	e8 25 13 00 00       	call   801676 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800351:	83 ec 0c             	sub    $0xc,%esp
  800354:	68 8c 1e 80 00       	push   $0x801e8c
  800359:	e8 52 03 00 00       	call   8006b0 <cprintf>
  80035e:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800361:	a1 20 30 80 00       	mov    0x803020,%eax
  800366:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80036c:	a1 20 30 80 00       	mov    0x803020,%eax
  800371:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800377:	83 ec 04             	sub    $0x4,%esp
  80037a:	52                   	push   %edx
  80037b:	50                   	push   %eax
  80037c:	68 b4 1e 80 00       	push   $0x801eb4
  800381:	e8 2a 03 00 00       	call   8006b0 <cprintf>
  800386:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800389:	a1 20 30 80 00       	mov    0x803020,%eax
  80038e:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800394:	a1 20 30 80 00       	mov    0x803020,%eax
  800399:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80039f:	83 ec 04             	sub    $0x4,%esp
  8003a2:	52                   	push   %edx
  8003a3:	50                   	push   %eax
  8003a4:	68 dc 1e 80 00       	push   $0x801edc
  8003a9:	e8 02 03 00 00       	call   8006b0 <cprintf>
  8003ae:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8003b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b6:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8003bc:	83 ec 08             	sub    $0x8,%esp
  8003bf:	50                   	push   %eax
  8003c0:	68 1d 1f 80 00       	push   $0x801f1d
  8003c5:	e8 e6 02 00 00       	call   8006b0 <cprintf>
  8003ca:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8003cd:	83 ec 0c             	sub    $0xc,%esp
  8003d0:	68 8c 1e 80 00       	push   $0x801e8c
  8003d5:	e8 d6 02 00 00       	call   8006b0 <cprintf>
  8003da:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8003dd:	e8 ae 12 00 00       	call   801690 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8003e2:	e8 19 00 00 00       	call   800400 <exit>
}
  8003e7:	90                   	nop
  8003e8:	c9                   	leave  
  8003e9:	c3                   	ret    

008003ea <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8003ea:	55                   	push   %ebp
  8003eb:	89 e5                	mov    %esp,%ebp
  8003ed:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8003f0:	83 ec 0c             	sub    $0xc,%esp
  8003f3:	6a 00                	push   $0x0
  8003f5:	e8 ad 10 00 00       	call   8014a7 <sys_env_destroy>
  8003fa:	83 c4 10             	add    $0x10,%esp
}
  8003fd:	90                   	nop
  8003fe:	c9                   	leave  
  8003ff:	c3                   	ret    

00800400 <exit>:

void
exit(void)
{
  800400:	55                   	push   %ebp
  800401:	89 e5                	mov    %esp,%ebp
  800403:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800406:	e8 02 11 00 00       	call   80150d <sys_env_exit>
}
  80040b:	90                   	nop
  80040c:	c9                   	leave  
  80040d:	c3                   	ret    

0080040e <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80040e:	55                   	push   %ebp
  80040f:	89 e5                	mov    %esp,%ebp
  800411:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800414:	8d 45 10             	lea    0x10(%ebp),%eax
  800417:	83 c0 04             	add    $0x4,%eax
  80041a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80041d:	a1 18 31 80 00       	mov    0x803118,%eax
  800422:	85 c0                	test   %eax,%eax
  800424:	74 16                	je     80043c <_panic+0x2e>
		cprintf("%s: ", argv0);
  800426:	a1 18 31 80 00       	mov    0x803118,%eax
  80042b:	83 ec 08             	sub    $0x8,%esp
  80042e:	50                   	push   %eax
  80042f:	68 34 1f 80 00       	push   $0x801f34
  800434:	e8 77 02 00 00       	call   8006b0 <cprintf>
  800439:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80043c:	a1 04 30 80 00       	mov    0x803004,%eax
  800441:	ff 75 0c             	pushl  0xc(%ebp)
  800444:	ff 75 08             	pushl  0x8(%ebp)
  800447:	50                   	push   %eax
  800448:	68 39 1f 80 00       	push   $0x801f39
  80044d:	e8 5e 02 00 00       	call   8006b0 <cprintf>
  800452:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800455:	8b 45 10             	mov    0x10(%ebp),%eax
  800458:	83 ec 08             	sub    $0x8,%esp
  80045b:	ff 75 f4             	pushl  -0xc(%ebp)
  80045e:	50                   	push   %eax
  80045f:	e8 e1 01 00 00       	call   800645 <vcprintf>
  800464:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800467:	83 ec 08             	sub    $0x8,%esp
  80046a:	6a 00                	push   $0x0
  80046c:	68 55 1f 80 00       	push   $0x801f55
  800471:	e8 cf 01 00 00       	call   800645 <vcprintf>
  800476:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800479:	e8 82 ff ff ff       	call   800400 <exit>

	// should not return here
	while (1) ;
  80047e:	eb fe                	jmp    80047e <_panic+0x70>

00800480 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800480:	55                   	push   %ebp
  800481:	89 e5                	mov    %esp,%ebp
  800483:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800486:	a1 20 30 80 00       	mov    0x803020,%eax
  80048b:	8b 50 74             	mov    0x74(%eax),%edx
  80048e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800491:	39 c2                	cmp    %eax,%edx
  800493:	74 14                	je     8004a9 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800495:	83 ec 04             	sub    $0x4,%esp
  800498:	68 58 1f 80 00       	push   $0x801f58
  80049d:	6a 26                	push   $0x26
  80049f:	68 a4 1f 80 00       	push   $0x801fa4
  8004a4:	e8 65 ff ff ff       	call   80040e <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8004a9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8004b0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8004b7:	e9 b6 00 00 00       	jmp    800572 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8004bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004bf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c9:	01 d0                	add    %edx,%eax
  8004cb:	8b 00                	mov    (%eax),%eax
  8004cd:	85 c0                	test   %eax,%eax
  8004cf:	75 08                	jne    8004d9 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8004d1:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8004d4:	e9 96 00 00 00       	jmp    80056f <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8004d9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004e0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8004e7:	eb 5d                	jmp    800546 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8004e9:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ee:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004f4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004f7:	c1 e2 04             	shl    $0x4,%edx
  8004fa:	01 d0                	add    %edx,%eax
  8004fc:	8a 40 04             	mov    0x4(%eax),%al
  8004ff:	84 c0                	test   %al,%al
  800501:	75 40                	jne    800543 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800503:	a1 20 30 80 00       	mov    0x803020,%eax
  800508:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80050e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800511:	c1 e2 04             	shl    $0x4,%edx
  800514:	01 d0                	add    %edx,%eax
  800516:	8b 00                	mov    (%eax),%eax
  800518:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80051b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80051e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800523:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800525:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800528:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80052f:	8b 45 08             	mov    0x8(%ebp),%eax
  800532:	01 c8                	add    %ecx,%eax
  800534:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800536:	39 c2                	cmp    %eax,%edx
  800538:	75 09                	jne    800543 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80053a:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800541:	eb 12                	jmp    800555 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800543:	ff 45 e8             	incl   -0x18(%ebp)
  800546:	a1 20 30 80 00       	mov    0x803020,%eax
  80054b:	8b 50 74             	mov    0x74(%eax),%edx
  80054e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800551:	39 c2                	cmp    %eax,%edx
  800553:	77 94                	ja     8004e9 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800555:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800559:	75 14                	jne    80056f <CheckWSWithoutLastIndex+0xef>
			panic(
  80055b:	83 ec 04             	sub    $0x4,%esp
  80055e:	68 b0 1f 80 00       	push   $0x801fb0
  800563:	6a 3a                	push   $0x3a
  800565:	68 a4 1f 80 00       	push   $0x801fa4
  80056a:	e8 9f fe ff ff       	call   80040e <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80056f:	ff 45 f0             	incl   -0x10(%ebp)
  800572:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800575:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800578:	0f 8c 3e ff ff ff    	jl     8004bc <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80057e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800585:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80058c:	eb 20                	jmp    8005ae <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80058e:	a1 20 30 80 00       	mov    0x803020,%eax
  800593:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800599:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80059c:	c1 e2 04             	shl    $0x4,%edx
  80059f:	01 d0                	add    %edx,%eax
  8005a1:	8a 40 04             	mov    0x4(%eax),%al
  8005a4:	3c 01                	cmp    $0x1,%al
  8005a6:	75 03                	jne    8005ab <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8005a8:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005ab:	ff 45 e0             	incl   -0x20(%ebp)
  8005ae:	a1 20 30 80 00       	mov    0x803020,%eax
  8005b3:	8b 50 74             	mov    0x74(%eax),%edx
  8005b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005b9:	39 c2                	cmp    %eax,%edx
  8005bb:	77 d1                	ja     80058e <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8005bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005c0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8005c3:	74 14                	je     8005d9 <CheckWSWithoutLastIndex+0x159>
		panic(
  8005c5:	83 ec 04             	sub    $0x4,%esp
  8005c8:	68 04 20 80 00       	push   $0x802004
  8005cd:	6a 44                	push   $0x44
  8005cf:	68 a4 1f 80 00       	push   $0x801fa4
  8005d4:	e8 35 fe ff ff       	call   80040e <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8005d9:	90                   	nop
  8005da:	c9                   	leave  
  8005db:	c3                   	ret    

008005dc <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8005dc:	55                   	push   %ebp
  8005dd:	89 e5                	mov    %esp,%ebp
  8005df:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8005e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005e5:	8b 00                	mov    (%eax),%eax
  8005e7:	8d 48 01             	lea    0x1(%eax),%ecx
  8005ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005ed:	89 0a                	mov    %ecx,(%edx)
  8005ef:	8b 55 08             	mov    0x8(%ebp),%edx
  8005f2:	88 d1                	mov    %dl,%cl
  8005f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005f7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005fe:	8b 00                	mov    (%eax),%eax
  800600:	3d ff 00 00 00       	cmp    $0xff,%eax
  800605:	75 2c                	jne    800633 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800607:	a0 24 30 80 00       	mov    0x803024,%al
  80060c:	0f b6 c0             	movzbl %al,%eax
  80060f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800612:	8b 12                	mov    (%edx),%edx
  800614:	89 d1                	mov    %edx,%ecx
  800616:	8b 55 0c             	mov    0xc(%ebp),%edx
  800619:	83 c2 08             	add    $0x8,%edx
  80061c:	83 ec 04             	sub    $0x4,%esp
  80061f:	50                   	push   %eax
  800620:	51                   	push   %ecx
  800621:	52                   	push   %edx
  800622:	e8 3e 0e 00 00       	call   801465 <sys_cputs>
  800627:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80062a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80062d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800633:	8b 45 0c             	mov    0xc(%ebp),%eax
  800636:	8b 40 04             	mov    0x4(%eax),%eax
  800639:	8d 50 01             	lea    0x1(%eax),%edx
  80063c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80063f:	89 50 04             	mov    %edx,0x4(%eax)
}
  800642:	90                   	nop
  800643:	c9                   	leave  
  800644:	c3                   	ret    

00800645 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800645:	55                   	push   %ebp
  800646:	89 e5                	mov    %esp,%ebp
  800648:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80064e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800655:	00 00 00 
	b.cnt = 0;
  800658:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80065f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800662:	ff 75 0c             	pushl  0xc(%ebp)
  800665:	ff 75 08             	pushl  0x8(%ebp)
  800668:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80066e:	50                   	push   %eax
  80066f:	68 dc 05 80 00       	push   $0x8005dc
  800674:	e8 11 02 00 00       	call   80088a <vprintfmt>
  800679:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80067c:	a0 24 30 80 00       	mov    0x803024,%al
  800681:	0f b6 c0             	movzbl %al,%eax
  800684:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80068a:	83 ec 04             	sub    $0x4,%esp
  80068d:	50                   	push   %eax
  80068e:	52                   	push   %edx
  80068f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800695:	83 c0 08             	add    $0x8,%eax
  800698:	50                   	push   %eax
  800699:	e8 c7 0d 00 00       	call   801465 <sys_cputs>
  80069e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8006a1:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8006a8:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8006ae:	c9                   	leave  
  8006af:	c3                   	ret    

008006b0 <cprintf>:

int cprintf(const char *fmt, ...) {
  8006b0:	55                   	push   %ebp
  8006b1:	89 e5                	mov    %esp,%ebp
  8006b3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8006b6:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8006bd:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c6:	83 ec 08             	sub    $0x8,%esp
  8006c9:	ff 75 f4             	pushl  -0xc(%ebp)
  8006cc:	50                   	push   %eax
  8006cd:	e8 73 ff ff ff       	call   800645 <vcprintf>
  8006d2:	83 c4 10             	add    $0x10,%esp
  8006d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8006d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006db:	c9                   	leave  
  8006dc:	c3                   	ret    

008006dd <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8006dd:	55                   	push   %ebp
  8006de:	89 e5                	mov    %esp,%ebp
  8006e0:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8006e3:	e8 8e 0f 00 00       	call   801676 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8006e8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f1:	83 ec 08             	sub    $0x8,%esp
  8006f4:	ff 75 f4             	pushl  -0xc(%ebp)
  8006f7:	50                   	push   %eax
  8006f8:	e8 48 ff ff ff       	call   800645 <vcprintf>
  8006fd:	83 c4 10             	add    $0x10,%esp
  800700:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800703:	e8 88 0f 00 00       	call   801690 <sys_enable_interrupt>
	return cnt;
  800708:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80070b:	c9                   	leave  
  80070c:	c3                   	ret    

0080070d <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80070d:	55                   	push   %ebp
  80070e:	89 e5                	mov    %esp,%ebp
  800710:	53                   	push   %ebx
  800711:	83 ec 14             	sub    $0x14,%esp
  800714:	8b 45 10             	mov    0x10(%ebp),%eax
  800717:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80071a:	8b 45 14             	mov    0x14(%ebp),%eax
  80071d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800720:	8b 45 18             	mov    0x18(%ebp),%eax
  800723:	ba 00 00 00 00       	mov    $0x0,%edx
  800728:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80072b:	77 55                	ja     800782 <printnum+0x75>
  80072d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800730:	72 05                	jb     800737 <printnum+0x2a>
  800732:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800735:	77 4b                	ja     800782 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800737:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80073a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80073d:	8b 45 18             	mov    0x18(%ebp),%eax
  800740:	ba 00 00 00 00       	mov    $0x0,%edx
  800745:	52                   	push   %edx
  800746:	50                   	push   %eax
  800747:	ff 75 f4             	pushl  -0xc(%ebp)
  80074a:	ff 75 f0             	pushl  -0x10(%ebp)
  80074d:	e8 46 13 00 00       	call   801a98 <__udivdi3>
  800752:	83 c4 10             	add    $0x10,%esp
  800755:	83 ec 04             	sub    $0x4,%esp
  800758:	ff 75 20             	pushl  0x20(%ebp)
  80075b:	53                   	push   %ebx
  80075c:	ff 75 18             	pushl  0x18(%ebp)
  80075f:	52                   	push   %edx
  800760:	50                   	push   %eax
  800761:	ff 75 0c             	pushl  0xc(%ebp)
  800764:	ff 75 08             	pushl  0x8(%ebp)
  800767:	e8 a1 ff ff ff       	call   80070d <printnum>
  80076c:	83 c4 20             	add    $0x20,%esp
  80076f:	eb 1a                	jmp    80078b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800771:	83 ec 08             	sub    $0x8,%esp
  800774:	ff 75 0c             	pushl  0xc(%ebp)
  800777:	ff 75 20             	pushl  0x20(%ebp)
  80077a:	8b 45 08             	mov    0x8(%ebp),%eax
  80077d:	ff d0                	call   *%eax
  80077f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800782:	ff 4d 1c             	decl   0x1c(%ebp)
  800785:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800789:	7f e6                	jg     800771 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80078b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80078e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800793:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800796:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800799:	53                   	push   %ebx
  80079a:	51                   	push   %ecx
  80079b:	52                   	push   %edx
  80079c:	50                   	push   %eax
  80079d:	e8 06 14 00 00       	call   801ba8 <__umoddi3>
  8007a2:	83 c4 10             	add    $0x10,%esp
  8007a5:	05 74 22 80 00       	add    $0x802274,%eax
  8007aa:	8a 00                	mov    (%eax),%al
  8007ac:	0f be c0             	movsbl %al,%eax
  8007af:	83 ec 08             	sub    $0x8,%esp
  8007b2:	ff 75 0c             	pushl  0xc(%ebp)
  8007b5:	50                   	push   %eax
  8007b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b9:	ff d0                	call   *%eax
  8007bb:	83 c4 10             	add    $0x10,%esp
}
  8007be:	90                   	nop
  8007bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8007c2:	c9                   	leave  
  8007c3:	c3                   	ret    

008007c4 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8007c4:	55                   	push   %ebp
  8007c5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007c7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007cb:	7e 1c                	jle    8007e9 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8007cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d0:	8b 00                	mov    (%eax),%eax
  8007d2:	8d 50 08             	lea    0x8(%eax),%edx
  8007d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d8:	89 10                	mov    %edx,(%eax)
  8007da:	8b 45 08             	mov    0x8(%ebp),%eax
  8007dd:	8b 00                	mov    (%eax),%eax
  8007df:	83 e8 08             	sub    $0x8,%eax
  8007e2:	8b 50 04             	mov    0x4(%eax),%edx
  8007e5:	8b 00                	mov    (%eax),%eax
  8007e7:	eb 40                	jmp    800829 <getuint+0x65>
	else if (lflag)
  8007e9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007ed:	74 1e                	je     80080d <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8007ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f2:	8b 00                	mov    (%eax),%eax
  8007f4:	8d 50 04             	lea    0x4(%eax),%edx
  8007f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fa:	89 10                	mov    %edx,(%eax)
  8007fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ff:	8b 00                	mov    (%eax),%eax
  800801:	83 e8 04             	sub    $0x4,%eax
  800804:	8b 00                	mov    (%eax),%eax
  800806:	ba 00 00 00 00       	mov    $0x0,%edx
  80080b:	eb 1c                	jmp    800829 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80080d:	8b 45 08             	mov    0x8(%ebp),%eax
  800810:	8b 00                	mov    (%eax),%eax
  800812:	8d 50 04             	lea    0x4(%eax),%edx
  800815:	8b 45 08             	mov    0x8(%ebp),%eax
  800818:	89 10                	mov    %edx,(%eax)
  80081a:	8b 45 08             	mov    0x8(%ebp),%eax
  80081d:	8b 00                	mov    (%eax),%eax
  80081f:	83 e8 04             	sub    $0x4,%eax
  800822:	8b 00                	mov    (%eax),%eax
  800824:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800829:	5d                   	pop    %ebp
  80082a:	c3                   	ret    

0080082b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80082b:	55                   	push   %ebp
  80082c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80082e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800832:	7e 1c                	jle    800850 <getint+0x25>
		return va_arg(*ap, long long);
  800834:	8b 45 08             	mov    0x8(%ebp),%eax
  800837:	8b 00                	mov    (%eax),%eax
  800839:	8d 50 08             	lea    0x8(%eax),%edx
  80083c:	8b 45 08             	mov    0x8(%ebp),%eax
  80083f:	89 10                	mov    %edx,(%eax)
  800841:	8b 45 08             	mov    0x8(%ebp),%eax
  800844:	8b 00                	mov    (%eax),%eax
  800846:	83 e8 08             	sub    $0x8,%eax
  800849:	8b 50 04             	mov    0x4(%eax),%edx
  80084c:	8b 00                	mov    (%eax),%eax
  80084e:	eb 38                	jmp    800888 <getint+0x5d>
	else if (lflag)
  800850:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800854:	74 1a                	je     800870 <getint+0x45>
		return va_arg(*ap, long);
  800856:	8b 45 08             	mov    0x8(%ebp),%eax
  800859:	8b 00                	mov    (%eax),%eax
  80085b:	8d 50 04             	lea    0x4(%eax),%edx
  80085e:	8b 45 08             	mov    0x8(%ebp),%eax
  800861:	89 10                	mov    %edx,(%eax)
  800863:	8b 45 08             	mov    0x8(%ebp),%eax
  800866:	8b 00                	mov    (%eax),%eax
  800868:	83 e8 04             	sub    $0x4,%eax
  80086b:	8b 00                	mov    (%eax),%eax
  80086d:	99                   	cltd   
  80086e:	eb 18                	jmp    800888 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800870:	8b 45 08             	mov    0x8(%ebp),%eax
  800873:	8b 00                	mov    (%eax),%eax
  800875:	8d 50 04             	lea    0x4(%eax),%edx
  800878:	8b 45 08             	mov    0x8(%ebp),%eax
  80087b:	89 10                	mov    %edx,(%eax)
  80087d:	8b 45 08             	mov    0x8(%ebp),%eax
  800880:	8b 00                	mov    (%eax),%eax
  800882:	83 e8 04             	sub    $0x4,%eax
  800885:	8b 00                	mov    (%eax),%eax
  800887:	99                   	cltd   
}
  800888:	5d                   	pop    %ebp
  800889:	c3                   	ret    

0080088a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80088a:	55                   	push   %ebp
  80088b:	89 e5                	mov    %esp,%ebp
  80088d:	56                   	push   %esi
  80088e:	53                   	push   %ebx
  80088f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800892:	eb 17                	jmp    8008ab <vprintfmt+0x21>
			if (ch == '\0')
  800894:	85 db                	test   %ebx,%ebx
  800896:	0f 84 af 03 00 00    	je     800c4b <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80089c:	83 ec 08             	sub    $0x8,%esp
  80089f:	ff 75 0c             	pushl  0xc(%ebp)
  8008a2:	53                   	push   %ebx
  8008a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a6:	ff d0                	call   *%eax
  8008a8:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8008ae:	8d 50 01             	lea    0x1(%eax),%edx
  8008b1:	89 55 10             	mov    %edx,0x10(%ebp)
  8008b4:	8a 00                	mov    (%eax),%al
  8008b6:	0f b6 d8             	movzbl %al,%ebx
  8008b9:	83 fb 25             	cmp    $0x25,%ebx
  8008bc:	75 d6                	jne    800894 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8008be:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8008c2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8008c9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8008d0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8008d7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8008de:	8b 45 10             	mov    0x10(%ebp),%eax
  8008e1:	8d 50 01             	lea    0x1(%eax),%edx
  8008e4:	89 55 10             	mov    %edx,0x10(%ebp)
  8008e7:	8a 00                	mov    (%eax),%al
  8008e9:	0f b6 d8             	movzbl %al,%ebx
  8008ec:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8008ef:	83 f8 55             	cmp    $0x55,%eax
  8008f2:	0f 87 2b 03 00 00    	ja     800c23 <vprintfmt+0x399>
  8008f8:	8b 04 85 98 22 80 00 	mov    0x802298(,%eax,4),%eax
  8008ff:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800901:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800905:	eb d7                	jmp    8008de <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800907:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80090b:	eb d1                	jmp    8008de <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80090d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800914:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800917:	89 d0                	mov    %edx,%eax
  800919:	c1 e0 02             	shl    $0x2,%eax
  80091c:	01 d0                	add    %edx,%eax
  80091e:	01 c0                	add    %eax,%eax
  800920:	01 d8                	add    %ebx,%eax
  800922:	83 e8 30             	sub    $0x30,%eax
  800925:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800928:	8b 45 10             	mov    0x10(%ebp),%eax
  80092b:	8a 00                	mov    (%eax),%al
  80092d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800930:	83 fb 2f             	cmp    $0x2f,%ebx
  800933:	7e 3e                	jle    800973 <vprintfmt+0xe9>
  800935:	83 fb 39             	cmp    $0x39,%ebx
  800938:	7f 39                	jg     800973 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80093a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80093d:	eb d5                	jmp    800914 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80093f:	8b 45 14             	mov    0x14(%ebp),%eax
  800942:	83 c0 04             	add    $0x4,%eax
  800945:	89 45 14             	mov    %eax,0x14(%ebp)
  800948:	8b 45 14             	mov    0x14(%ebp),%eax
  80094b:	83 e8 04             	sub    $0x4,%eax
  80094e:	8b 00                	mov    (%eax),%eax
  800950:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800953:	eb 1f                	jmp    800974 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800955:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800959:	79 83                	jns    8008de <vprintfmt+0x54>
				width = 0;
  80095b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800962:	e9 77 ff ff ff       	jmp    8008de <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800967:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80096e:	e9 6b ff ff ff       	jmp    8008de <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800973:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800974:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800978:	0f 89 60 ff ff ff    	jns    8008de <vprintfmt+0x54>
				width = precision, precision = -1;
  80097e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800981:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800984:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80098b:	e9 4e ff ff ff       	jmp    8008de <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800990:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800993:	e9 46 ff ff ff       	jmp    8008de <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800998:	8b 45 14             	mov    0x14(%ebp),%eax
  80099b:	83 c0 04             	add    $0x4,%eax
  80099e:	89 45 14             	mov    %eax,0x14(%ebp)
  8009a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8009a4:	83 e8 04             	sub    $0x4,%eax
  8009a7:	8b 00                	mov    (%eax),%eax
  8009a9:	83 ec 08             	sub    $0x8,%esp
  8009ac:	ff 75 0c             	pushl  0xc(%ebp)
  8009af:	50                   	push   %eax
  8009b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b3:	ff d0                	call   *%eax
  8009b5:	83 c4 10             	add    $0x10,%esp
			break;
  8009b8:	e9 89 02 00 00       	jmp    800c46 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8009bd:	8b 45 14             	mov    0x14(%ebp),%eax
  8009c0:	83 c0 04             	add    $0x4,%eax
  8009c3:	89 45 14             	mov    %eax,0x14(%ebp)
  8009c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8009c9:	83 e8 04             	sub    $0x4,%eax
  8009cc:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8009ce:	85 db                	test   %ebx,%ebx
  8009d0:	79 02                	jns    8009d4 <vprintfmt+0x14a>
				err = -err;
  8009d2:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8009d4:	83 fb 64             	cmp    $0x64,%ebx
  8009d7:	7f 0b                	jg     8009e4 <vprintfmt+0x15a>
  8009d9:	8b 34 9d e0 20 80 00 	mov    0x8020e0(,%ebx,4),%esi
  8009e0:	85 f6                	test   %esi,%esi
  8009e2:	75 19                	jne    8009fd <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8009e4:	53                   	push   %ebx
  8009e5:	68 85 22 80 00       	push   $0x802285
  8009ea:	ff 75 0c             	pushl  0xc(%ebp)
  8009ed:	ff 75 08             	pushl  0x8(%ebp)
  8009f0:	e8 5e 02 00 00       	call   800c53 <printfmt>
  8009f5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8009f8:	e9 49 02 00 00       	jmp    800c46 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8009fd:	56                   	push   %esi
  8009fe:	68 8e 22 80 00       	push   $0x80228e
  800a03:	ff 75 0c             	pushl  0xc(%ebp)
  800a06:	ff 75 08             	pushl  0x8(%ebp)
  800a09:	e8 45 02 00 00       	call   800c53 <printfmt>
  800a0e:	83 c4 10             	add    $0x10,%esp
			break;
  800a11:	e9 30 02 00 00       	jmp    800c46 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a16:	8b 45 14             	mov    0x14(%ebp),%eax
  800a19:	83 c0 04             	add    $0x4,%eax
  800a1c:	89 45 14             	mov    %eax,0x14(%ebp)
  800a1f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a22:	83 e8 04             	sub    $0x4,%eax
  800a25:	8b 30                	mov    (%eax),%esi
  800a27:	85 f6                	test   %esi,%esi
  800a29:	75 05                	jne    800a30 <vprintfmt+0x1a6>
				p = "(null)";
  800a2b:	be 91 22 80 00       	mov    $0x802291,%esi
			if (width > 0 && padc != '-')
  800a30:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a34:	7e 6d                	jle    800aa3 <vprintfmt+0x219>
  800a36:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a3a:	74 67                	je     800aa3 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a3c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a3f:	83 ec 08             	sub    $0x8,%esp
  800a42:	50                   	push   %eax
  800a43:	56                   	push   %esi
  800a44:	e8 0c 03 00 00       	call   800d55 <strnlen>
  800a49:	83 c4 10             	add    $0x10,%esp
  800a4c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a4f:	eb 16                	jmp    800a67 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a51:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a55:	83 ec 08             	sub    $0x8,%esp
  800a58:	ff 75 0c             	pushl  0xc(%ebp)
  800a5b:	50                   	push   %eax
  800a5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5f:	ff d0                	call   *%eax
  800a61:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a64:	ff 4d e4             	decl   -0x1c(%ebp)
  800a67:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a6b:	7f e4                	jg     800a51 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a6d:	eb 34                	jmp    800aa3 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a6f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a73:	74 1c                	je     800a91 <vprintfmt+0x207>
  800a75:	83 fb 1f             	cmp    $0x1f,%ebx
  800a78:	7e 05                	jle    800a7f <vprintfmt+0x1f5>
  800a7a:	83 fb 7e             	cmp    $0x7e,%ebx
  800a7d:	7e 12                	jle    800a91 <vprintfmt+0x207>
					putch('?', putdat);
  800a7f:	83 ec 08             	sub    $0x8,%esp
  800a82:	ff 75 0c             	pushl  0xc(%ebp)
  800a85:	6a 3f                	push   $0x3f
  800a87:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8a:	ff d0                	call   *%eax
  800a8c:	83 c4 10             	add    $0x10,%esp
  800a8f:	eb 0f                	jmp    800aa0 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a91:	83 ec 08             	sub    $0x8,%esp
  800a94:	ff 75 0c             	pushl  0xc(%ebp)
  800a97:	53                   	push   %ebx
  800a98:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9b:	ff d0                	call   *%eax
  800a9d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800aa0:	ff 4d e4             	decl   -0x1c(%ebp)
  800aa3:	89 f0                	mov    %esi,%eax
  800aa5:	8d 70 01             	lea    0x1(%eax),%esi
  800aa8:	8a 00                	mov    (%eax),%al
  800aaa:	0f be d8             	movsbl %al,%ebx
  800aad:	85 db                	test   %ebx,%ebx
  800aaf:	74 24                	je     800ad5 <vprintfmt+0x24b>
  800ab1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ab5:	78 b8                	js     800a6f <vprintfmt+0x1e5>
  800ab7:	ff 4d e0             	decl   -0x20(%ebp)
  800aba:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800abe:	79 af                	jns    800a6f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ac0:	eb 13                	jmp    800ad5 <vprintfmt+0x24b>
				putch(' ', putdat);
  800ac2:	83 ec 08             	sub    $0x8,%esp
  800ac5:	ff 75 0c             	pushl  0xc(%ebp)
  800ac8:	6a 20                	push   $0x20
  800aca:	8b 45 08             	mov    0x8(%ebp),%eax
  800acd:	ff d0                	call   *%eax
  800acf:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ad2:	ff 4d e4             	decl   -0x1c(%ebp)
  800ad5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ad9:	7f e7                	jg     800ac2 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800adb:	e9 66 01 00 00       	jmp    800c46 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ae0:	83 ec 08             	sub    $0x8,%esp
  800ae3:	ff 75 e8             	pushl  -0x18(%ebp)
  800ae6:	8d 45 14             	lea    0x14(%ebp),%eax
  800ae9:	50                   	push   %eax
  800aea:	e8 3c fd ff ff       	call   80082b <getint>
  800aef:	83 c4 10             	add    $0x10,%esp
  800af2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800af5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800af8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800afb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800afe:	85 d2                	test   %edx,%edx
  800b00:	79 23                	jns    800b25 <vprintfmt+0x29b>
				putch('-', putdat);
  800b02:	83 ec 08             	sub    $0x8,%esp
  800b05:	ff 75 0c             	pushl  0xc(%ebp)
  800b08:	6a 2d                	push   $0x2d
  800b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0d:	ff d0                	call   *%eax
  800b0f:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b12:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b15:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b18:	f7 d8                	neg    %eax
  800b1a:	83 d2 00             	adc    $0x0,%edx
  800b1d:	f7 da                	neg    %edx
  800b1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b22:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b25:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b2c:	e9 bc 00 00 00       	jmp    800bed <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b31:	83 ec 08             	sub    $0x8,%esp
  800b34:	ff 75 e8             	pushl  -0x18(%ebp)
  800b37:	8d 45 14             	lea    0x14(%ebp),%eax
  800b3a:	50                   	push   %eax
  800b3b:	e8 84 fc ff ff       	call   8007c4 <getuint>
  800b40:	83 c4 10             	add    $0x10,%esp
  800b43:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b46:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b49:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b50:	e9 98 00 00 00       	jmp    800bed <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b55:	83 ec 08             	sub    $0x8,%esp
  800b58:	ff 75 0c             	pushl  0xc(%ebp)
  800b5b:	6a 58                	push   $0x58
  800b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b60:	ff d0                	call   *%eax
  800b62:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b65:	83 ec 08             	sub    $0x8,%esp
  800b68:	ff 75 0c             	pushl  0xc(%ebp)
  800b6b:	6a 58                	push   $0x58
  800b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b70:	ff d0                	call   *%eax
  800b72:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b75:	83 ec 08             	sub    $0x8,%esp
  800b78:	ff 75 0c             	pushl  0xc(%ebp)
  800b7b:	6a 58                	push   $0x58
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b80:	ff d0                	call   *%eax
  800b82:	83 c4 10             	add    $0x10,%esp
			break;
  800b85:	e9 bc 00 00 00       	jmp    800c46 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b8a:	83 ec 08             	sub    $0x8,%esp
  800b8d:	ff 75 0c             	pushl  0xc(%ebp)
  800b90:	6a 30                	push   $0x30
  800b92:	8b 45 08             	mov    0x8(%ebp),%eax
  800b95:	ff d0                	call   *%eax
  800b97:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b9a:	83 ec 08             	sub    $0x8,%esp
  800b9d:	ff 75 0c             	pushl  0xc(%ebp)
  800ba0:	6a 78                	push   $0x78
  800ba2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba5:	ff d0                	call   *%eax
  800ba7:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800baa:	8b 45 14             	mov    0x14(%ebp),%eax
  800bad:	83 c0 04             	add    $0x4,%eax
  800bb0:	89 45 14             	mov    %eax,0x14(%ebp)
  800bb3:	8b 45 14             	mov    0x14(%ebp),%eax
  800bb6:	83 e8 04             	sub    $0x4,%eax
  800bb9:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800bbb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bbe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800bc5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800bcc:	eb 1f                	jmp    800bed <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800bce:	83 ec 08             	sub    $0x8,%esp
  800bd1:	ff 75 e8             	pushl  -0x18(%ebp)
  800bd4:	8d 45 14             	lea    0x14(%ebp),%eax
  800bd7:	50                   	push   %eax
  800bd8:	e8 e7 fb ff ff       	call   8007c4 <getuint>
  800bdd:	83 c4 10             	add    $0x10,%esp
  800be0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800be3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800be6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800bed:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800bf1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bf4:	83 ec 04             	sub    $0x4,%esp
  800bf7:	52                   	push   %edx
  800bf8:	ff 75 e4             	pushl  -0x1c(%ebp)
  800bfb:	50                   	push   %eax
  800bfc:	ff 75 f4             	pushl  -0xc(%ebp)
  800bff:	ff 75 f0             	pushl  -0x10(%ebp)
  800c02:	ff 75 0c             	pushl  0xc(%ebp)
  800c05:	ff 75 08             	pushl  0x8(%ebp)
  800c08:	e8 00 fb ff ff       	call   80070d <printnum>
  800c0d:	83 c4 20             	add    $0x20,%esp
			break;
  800c10:	eb 34                	jmp    800c46 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c12:	83 ec 08             	sub    $0x8,%esp
  800c15:	ff 75 0c             	pushl  0xc(%ebp)
  800c18:	53                   	push   %ebx
  800c19:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1c:	ff d0                	call   *%eax
  800c1e:	83 c4 10             	add    $0x10,%esp
			break;
  800c21:	eb 23                	jmp    800c46 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c23:	83 ec 08             	sub    $0x8,%esp
  800c26:	ff 75 0c             	pushl  0xc(%ebp)
  800c29:	6a 25                	push   $0x25
  800c2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2e:	ff d0                	call   *%eax
  800c30:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c33:	ff 4d 10             	decl   0x10(%ebp)
  800c36:	eb 03                	jmp    800c3b <vprintfmt+0x3b1>
  800c38:	ff 4d 10             	decl   0x10(%ebp)
  800c3b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3e:	48                   	dec    %eax
  800c3f:	8a 00                	mov    (%eax),%al
  800c41:	3c 25                	cmp    $0x25,%al
  800c43:	75 f3                	jne    800c38 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c45:	90                   	nop
		}
	}
  800c46:	e9 47 fc ff ff       	jmp    800892 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c4b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c4c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c4f:	5b                   	pop    %ebx
  800c50:	5e                   	pop    %esi
  800c51:	5d                   	pop    %ebp
  800c52:	c3                   	ret    

00800c53 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c53:	55                   	push   %ebp
  800c54:	89 e5                	mov    %esp,%ebp
  800c56:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c59:	8d 45 10             	lea    0x10(%ebp),%eax
  800c5c:	83 c0 04             	add    $0x4,%eax
  800c5f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c62:	8b 45 10             	mov    0x10(%ebp),%eax
  800c65:	ff 75 f4             	pushl  -0xc(%ebp)
  800c68:	50                   	push   %eax
  800c69:	ff 75 0c             	pushl  0xc(%ebp)
  800c6c:	ff 75 08             	pushl  0x8(%ebp)
  800c6f:	e8 16 fc ff ff       	call   80088a <vprintfmt>
  800c74:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c77:	90                   	nop
  800c78:	c9                   	leave  
  800c79:	c3                   	ret    

00800c7a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c7a:	55                   	push   %ebp
  800c7b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c80:	8b 40 08             	mov    0x8(%eax),%eax
  800c83:	8d 50 01             	lea    0x1(%eax),%edx
  800c86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c89:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8f:	8b 10                	mov    (%eax),%edx
  800c91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c94:	8b 40 04             	mov    0x4(%eax),%eax
  800c97:	39 c2                	cmp    %eax,%edx
  800c99:	73 12                	jae    800cad <sprintputch+0x33>
		*b->buf++ = ch;
  800c9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c9e:	8b 00                	mov    (%eax),%eax
  800ca0:	8d 48 01             	lea    0x1(%eax),%ecx
  800ca3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ca6:	89 0a                	mov    %ecx,(%edx)
  800ca8:	8b 55 08             	mov    0x8(%ebp),%edx
  800cab:	88 10                	mov    %dl,(%eax)
}
  800cad:	90                   	nop
  800cae:	5d                   	pop    %ebp
  800caf:	c3                   	ret    

00800cb0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800cb0:	55                   	push   %ebp
  800cb1:	89 e5                	mov    %esp,%ebp
  800cb3:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800cbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cbf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc5:	01 d0                	add    %edx,%eax
  800cc7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800cd1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800cd5:	74 06                	je     800cdd <vsnprintf+0x2d>
  800cd7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cdb:	7f 07                	jg     800ce4 <vsnprintf+0x34>
		return -E_INVAL;
  800cdd:	b8 03 00 00 00       	mov    $0x3,%eax
  800ce2:	eb 20                	jmp    800d04 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ce4:	ff 75 14             	pushl  0x14(%ebp)
  800ce7:	ff 75 10             	pushl  0x10(%ebp)
  800cea:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ced:	50                   	push   %eax
  800cee:	68 7a 0c 80 00       	push   $0x800c7a
  800cf3:	e8 92 fb ff ff       	call   80088a <vprintfmt>
  800cf8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800cfb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cfe:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d01:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d04:	c9                   	leave  
  800d05:	c3                   	ret    

00800d06 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d06:	55                   	push   %ebp
  800d07:	89 e5                	mov    %esp,%ebp
  800d09:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d0c:	8d 45 10             	lea    0x10(%ebp),%eax
  800d0f:	83 c0 04             	add    $0x4,%eax
  800d12:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d15:	8b 45 10             	mov    0x10(%ebp),%eax
  800d18:	ff 75 f4             	pushl  -0xc(%ebp)
  800d1b:	50                   	push   %eax
  800d1c:	ff 75 0c             	pushl  0xc(%ebp)
  800d1f:	ff 75 08             	pushl  0x8(%ebp)
  800d22:	e8 89 ff ff ff       	call   800cb0 <vsnprintf>
  800d27:	83 c4 10             	add    $0x10,%esp
  800d2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d30:	c9                   	leave  
  800d31:	c3                   	ret    

00800d32 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d32:	55                   	push   %ebp
  800d33:	89 e5                	mov    %esp,%ebp
  800d35:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d38:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d3f:	eb 06                	jmp    800d47 <strlen+0x15>
		n++;
  800d41:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d44:	ff 45 08             	incl   0x8(%ebp)
  800d47:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4a:	8a 00                	mov    (%eax),%al
  800d4c:	84 c0                	test   %al,%al
  800d4e:	75 f1                	jne    800d41 <strlen+0xf>
		n++;
	return n;
  800d50:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d53:	c9                   	leave  
  800d54:	c3                   	ret    

00800d55 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d55:	55                   	push   %ebp
  800d56:	89 e5                	mov    %esp,%ebp
  800d58:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d5b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d62:	eb 09                	jmp    800d6d <strnlen+0x18>
		n++;
  800d64:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d67:	ff 45 08             	incl   0x8(%ebp)
  800d6a:	ff 4d 0c             	decl   0xc(%ebp)
  800d6d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d71:	74 09                	je     800d7c <strnlen+0x27>
  800d73:	8b 45 08             	mov    0x8(%ebp),%eax
  800d76:	8a 00                	mov    (%eax),%al
  800d78:	84 c0                	test   %al,%al
  800d7a:	75 e8                	jne    800d64 <strnlen+0xf>
		n++;
	return n;
  800d7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d7f:	c9                   	leave  
  800d80:	c3                   	ret    

00800d81 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d81:	55                   	push   %ebp
  800d82:	89 e5                	mov    %esp,%ebp
  800d84:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d87:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d8d:	90                   	nop
  800d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d91:	8d 50 01             	lea    0x1(%eax),%edx
  800d94:	89 55 08             	mov    %edx,0x8(%ebp)
  800d97:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d9a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d9d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800da0:	8a 12                	mov    (%edx),%dl
  800da2:	88 10                	mov    %dl,(%eax)
  800da4:	8a 00                	mov    (%eax),%al
  800da6:	84 c0                	test   %al,%al
  800da8:	75 e4                	jne    800d8e <strcpy+0xd>
		/* do nothing */;
	return ret;
  800daa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dad:	c9                   	leave  
  800dae:	c3                   	ret    

00800daf <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800daf:	55                   	push   %ebp
  800db0:	89 e5                	mov    %esp,%ebp
  800db2:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800db5:	8b 45 08             	mov    0x8(%ebp),%eax
  800db8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800dbb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800dc2:	eb 1f                	jmp    800de3 <strncpy+0x34>
		*dst++ = *src;
  800dc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc7:	8d 50 01             	lea    0x1(%eax),%edx
  800dca:	89 55 08             	mov    %edx,0x8(%ebp)
  800dcd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dd0:	8a 12                	mov    (%edx),%dl
  800dd2:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800dd4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd7:	8a 00                	mov    (%eax),%al
  800dd9:	84 c0                	test   %al,%al
  800ddb:	74 03                	je     800de0 <strncpy+0x31>
			src++;
  800ddd:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800de0:	ff 45 fc             	incl   -0x4(%ebp)
  800de3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800de6:	3b 45 10             	cmp    0x10(%ebp),%eax
  800de9:	72 d9                	jb     800dc4 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800deb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dee:	c9                   	leave  
  800def:	c3                   	ret    

00800df0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800df0:	55                   	push   %ebp
  800df1:	89 e5                	mov    %esp,%ebp
  800df3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800df6:	8b 45 08             	mov    0x8(%ebp),%eax
  800df9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800dfc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e00:	74 30                	je     800e32 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e02:	eb 16                	jmp    800e1a <strlcpy+0x2a>
			*dst++ = *src++;
  800e04:	8b 45 08             	mov    0x8(%ebp),%eax
  800e07:	8d 50 01             	lea    0x1(%eax),%edx
  800e0a:	89 55 08             	mov    %edx,0x8(%ebp)
  800e0d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e10:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e13:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e16:	8a 12                	mov    (%edx),%dl
  800e18:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e1a:	ff 4d 10             	decl   0x10(%ebp)
  800e1d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e21:	74 09                	je     800e2c <strlcpy+0x3c>
  800e23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e26:	8a 00                	mov    (%eax),%al
  800e28:	84 c0                	test   %al,%al
  800e2a:	75 d8                	jne    800e04 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e32:	8b 55 08             	mov    0x8(%ebp),%edx
  800e35:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e38:	29 c2                	sub    %eax,%edx
  800e3a:	89 d0                	mov    %edx,%eax
}
  800e3c:	c9                   	leave  
  800e3d:	c3                   	ret    

00800e3e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e3e:	55                   	push   %ebp
  800e3f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e41:	eb 06                	jmp    800e49 <strcmp+0xb>
		p++, q++;
  800e43:	ff 45 08             	incl   0x8(%ebp)
  800e46:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e49:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4c:	8a 00                	mov    (%eax),%al
  800e4e:	84 c0                	test   %al,%al
  800e50:	74 0e                	je     800e60 <strcmp+0x22>
  800e52:	8b 45 08             	mov    0x8(%ebp),%eax
  800e55:	8a 10                	mov    (%eax),%dl
  800e57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5a:	8a 00                	mov    (%eax),%al
  800e5c:	38 c2                	cmp    %al,%dl
  800e5e:	74 e3                	je     800e43 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e60:	8b 45 08             	mov    0x8(%ebp),%eax
  800e63:	8a 00                	mov    (%eax),%al
  800e65:	0f b6 d0             	movzbl %al,%edx
  800e68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6b:	8a 00                	mov    (%eax),%al
  800e6d:	0f b6 c0             	movzbl %al,%eax
  800e70:	29 c2                	sub    %eax,%edx
  800e72:	89 d0                	mov    %edx,%eax
}
  800e74:	5d                   	pop    %ebp
  800e75:	c3                   	ret    

00800e76 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e76:	55                   	push   %ebp
  800e77:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e79:	eb 09                	jmp    800e84 <strncmp+0xe>
		n--, p++, q++;
  800e7b:	ff 4d 10             	decl   0x10(%ebp)
  800e7e:	ff 45 08             	incl   0x8(%ebp)
  800e81:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e84:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e88:	74 17                	je     800ea1 <strncmp+0x2b>
  800e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8d:	8a 00                	mov    (%eax),%al
  800e8f:	84 c0                	test   %al,%al
  800e91:	74 0e                	je     800ea1 <strncmp+0x2b>
  800e93:	8b 45 08             	mov    0x8(%ebp),%eax
  800e96:	8a 10                	mov    (%eax),%dl
  800e98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9b:	8a 00                	mov    (%eax),%al
  800e9d:	38 c2                	cmp    %al,%dl
  800e9f:	74 da                	je     800e7b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ea1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ea5:	75 07                	jne    800eae <strncmp+0x38>
		return 0;
  800ea7:	b8 00 00 00 00       	mov    $0x0,%eax
  800eac:	eb 14                	jmp    800ec2 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb1:	8a 00                	mov    (%eax),%al
  800eb3:	0f b6 d0             	movzbl %al,%edx
  800eb6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb9:	8a 00                	mov    (%eax),%al
  800ebb:	0f b6 c0             	movzbl %al,%eax
  800ebe:	29 c2                	sub    %eax,%edx
  800ec0:	89 d0                	mov    %edx,%eax
}
  800ec2:	5d                   	pop    %ebp
  800ec3:	c3                   	ret    

00800ec4 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ec4:	55                   	push   %ebp
  800ec5:	89 e5                	mov    %esp,%ebp
  800ec7:	83 ec 04             	sub    $0x4,%esp
  800eca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ecd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ed0:	eb 12                	jmp    800ee4 <strchr+0x20>
		if (*s == c)
  800ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed5:	8a 00                	mov    (%eax),%al
  800ed7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800eda:	75 05                	jne    800ee1 <strchr+0x1d>
			return (char *) s;
  800edc:	8b 45 08             	mov    0x8(%ebp),%eax
  800edf:	eb 11                	jmp    800ef2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ee1:	ff 45 08             	incl   0x8(%ebp)
  800ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee7:	8a 00                	mov    (%eax),%al
  800ee9:	84 c0                	test   %al,%al
  800eeb:	75 e5                	jne    800ed2 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800eed:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ef2:	c9                   	leave  
  800ef3:	c3                   	ret    

00800ef4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ef4:	55                   	push   %ebp
  800ef5:	89 e5                	mov    %esp,%ebp
  800ef7:	83 ec 04             	sub    $0x4,%esp
  800efa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f00:	eb 0d                	jmp    800f0f <strfind+0x1b>
		if (*s == c)
  800f02:	8b 45 08             	mov    0x8(%ebp),%eax
  800f05:	8a 00                	mov    (%eax),%al
  800f07:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f0a:	74 0e                	je     800f1a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f0c:	ff 45 08             	incl   0x8(%ebp)
  800f0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f12:	8a 00                	mov    (%eax),%al
  800f14:	84 c0                	test   %al,%al
  800f16:	75 ea                	jne    800f02 <strfind+0xe>
  800f18:	eb 01                	jmp    800f1b <strfind+0x27>
		if (*s == c)
			break;
  800f1a:	90                   	nop
	return (char *) s;
  800f1b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f1e:	c9                   	leave  
  800f1f:	c3                   	ret    

00800f20 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800f20:	55                   	push   %ebp
  800f21:	89 e5                	mov    %esp,%ebp
  800f23:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f26:	8b 45 08             	mov    0x8(%ebp),%eax
  800f29:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f2c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f32:	eb 0e                	jmp    800f42 <memset+0x22>
		*p++ = c;
  800f34:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f37:	8d 50 01             	lea    0x1(%eax),%edx
  800f3a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f3d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f40:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f42:	ff 4d f8             	decl   -0x8(%ebp)
  800f45:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f49:	79 e9                	jns    800f34 <memset+0x14>
		*p++ = c;

	return v;
  800f4b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f4e:	c9                   	leave  
  800f4f:	c3                   	ret    

00800f50 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f50:	55                   	push   %ebp
  800f51:	89 e5                	mov    %esp,%ebp
  800f53:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f59:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f62:	eb 16                	jmp    800f7a <memcpy+0x2a>
		*d++ = *s++;
  800f64:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f67:	8d 50 01             	lea    0x1(%eax),%edx
  800f6a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f6d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f70:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f73:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f76:	8a 12                	mov    (%edx),%dl
  800f78:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800f7a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f80:	89 55 10             	mov    %edx,0x10(%ebp)
  800f83:	85 c0                	test   %eax,%eax
  800f85:	75 dd                	jne    800f64 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800f87:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f8a:	c9                   	leave  
  800f8b:	c3                   	ret    

00800f8c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f8c:	55                   	push   %ebp
  800f8d:	89 e5                	mov    %esp,%ebp
  800f8f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f95:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f98:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f9e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fa1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fa4:	73 50                	jae    800ff6 <memmove+0x6a>
  800fa6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fa9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fac:	01 d0                	add    %edx,%eax
  800fae:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fb1:	76 43                	jbe    800ff6 <memmove+0x6a>
		s += n;
  800fb3:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb6:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800fb9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbc:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800fbf:	eb 10                	jmp    800fd1 <memmove+0x45>
			*--d = *--s;
  800fc1:	ff 4d f8             	decl   -0x8(%ebp)
  800fc4:	ff 4d fc             	decl   -0x4(%ebp)
  800fc7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fca:	8a 10                	mov    (%eax),%dl
  800fcc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fcf:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800fd1:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fd7:	89 55 10             	mov    %edx,0x10(%ebp)
  800fda:	85 c0                	test   %eax,%eax
  800fdc:	75 e3                	jne    800fc1 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800fde:	eb 23                	jmp    801003 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800fe0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe3:	8d 50 01             	lea    0x1(%eax),%edx
  800fe6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fe9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fec:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fef:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ff2:	8a 12                	mov    (%edx),%dl
  800ff4:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ff6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ffc:	89 55 10             	mov    %edx,0x10(%ebp)
  800fff:	85 c0                	test   %eax,%eax
  801001:	75 dd                	jne    800fe0 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801003:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801006:	c9                   	leave  
  801007:	c3                   	ret    

00801008 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801008:	55                   	push   %ebp
  801009:	89 e5                	mov    %esp,%ebp
  80100b:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80100e:	8b 45 08             	mov    0x8(%ebp),%eax
  801011:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801014:	8b 45 0c             	mov    0xc(%ebp),%eax
  801017:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80101a:	eb 2a                	jmp    801046 <memcmp+0x3e>
		if (*s1 != *s2)
  80101c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80101f:	8a 10                	mov    (%eax),%dl
  801021:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801024:	8a 00                	mov    (%eax),%al
  801026:	38 c2                	cmp    %al,%dl
  801028:	74 16                	je     801040 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80102a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80102d:	8a 00                	mov    (%eax),%al
  80102f:	0f b6 d0             	movzbl %al,%edx
  801032:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801035:	8a 00                	mov    (%eax),%al
  801037:	0f b6 c0             	movzbl %al,%eax
  80103a:	29 c2                	sub    %eax,%edx
  80103c:	89 d0                	mov    %edx,%eax
  80103e:	eb 18                	jmp    801058 <memcmp+0x50>
		s1++, s2++;
  801040:	ff 45 fc             	incl   -0x4(%ebp)
  801043:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801046:	8b 45 10             	mov    0x10(%ebp),%eax
  801049:	8d 50 ff             	lea    -0x1(%eax),%edx
  80104c:	89 55 10             	mov    %edx,0x10(%ebp)
  80104f:	85 c0                	test   %eax,%eax
  801051:	75 c9                	jne    80101c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801053:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801058:	c9                   	leave  
  801059:	c3                   	ret    

0080105a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80105a:	55                   	push   %ebp
  80105b:	89 e5                	mov    %esp,%ebp
  80105d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801060:	8b 55 08             	mov    0x8(%ebp),%edx
  801063:	8b 45 10             	mov    0x10(%ebp),%eax
  801066:	01 d0                	add    %edx,%eax
  801068:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80106b:	eb 15                	jmp    801082 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80106d:	8b 45 08             	mov    0x8(%ebp),%eax
  801070:	8a 00                	mov    (%eax),%al
  801072:	0f b6 d0             	movzbl %al,%edx
  801075:	8b 45 0c             	mov    0xc(%ebp),%eax
  801078:	0f b6 c0             	movzbl %al,%eax
  80107b:	39 c2                	cmp    %eax,%edx
  80107d:	74 0d                	je     80108c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80107f:	ff 45 08             	incl   0x8(%ebp)
  801082:	8b 45 08             	mov    0x8(%ebp),%eax
  801085:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801088:	72 e3                	jb     80106d <memfind+0x13>
  80108a:	eb 01                	jmp    80108d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80108c:	90                   	nop
	return (void *) s;
  80108d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801090:	c9                   	leave  
  801091:	c3                   	ret    

00801092 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801092:	55                   	push   %ebp
  801093:	89 e5                	mov    %esp,%ebp
  801095:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801098:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80109f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010a6:	eb 03                	jmp    8010ab <strtol+0x19>
		s++;
  8010a8:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ae:	8a 00                	mov    (%eax),%al
  8010b0:	3c 20                	cmp    $0x20,%al
  8010b2:	74 f4                	je     8010a8 <strtol+0x16>
  8010b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b7:	8a 00                	mov    (%eax),%al
  8010b9:	3c 09                	cmp    $0x9,%al
  8010bb:	74 eb                	je     8010a8 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8010bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c0:	8a 00                	mov    (%eax),%al
  8010c2:	3c 2b                	cmp    $0x2b,%al
  8010c4:	75 05                	jne    8010cb <strtol+0x39>
		s++;
  8010c6:	ff 45 08             	incl   0x8(%ebp)
  8010c9:	eb 13                	jmp    8010de <strtol+0x4c>
	else if (*s == '-')
  8010cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ce:	8a 00                	mov    (%eax),%al
  8010d0:	3c 2d                	cmp    $0x2d,%al
  8010d2:	75 0a                	jne    8010de <strtol+0x4c>
		s++, neg = 1;
  8010d4:	ff 45 08             	incl   0x8(%ebp)
  8010d7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8010de:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010e2:	74 06                	je     8010ea <strtol+0x58>
  8010e4:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8010e8:	75 20                	jne    80110a <strtol+0x78>
  8010ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ed:	8a 00                	mov    (%eax),%al
  8010ef:	3c 30                	cmp    $0x30,%al
  8010f1:	75 17                	jne    80110a <strtol+0x78>
  8010f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f6:	40                   	inc    %eax
  8010f7:	8a 00                	mov    (%eax),%al
  8010f9:	3c 78                	cmp    $0x78,%al
  8010fb:	75 0d                	jne    80110a <strtol+0x78>
		s += 2, base = 16;
  8010fd:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801101:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801108:	eb 28                	jmp    801132 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80110a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80110e:	75 15                	jne    801125 <strtol+0x93>
  801110:	8b 45 08             	mov    0x8(%ebp),%eax
  801113:	8a 00                	mov    (%eax),%al
  801115:	3c 30                	cmp    $0x30,%al
  801117:	75 0c                	jne    801125 <strtol+0x93>
		s++, base = 8;
  801119:	ff 45 08             	incl   0x8(%ebp)
  80111c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801123:	eb 0d                	jmp    801132 <strtol+0xa0>
	else if (base == 0)
  801125:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801129:	75 07                	jne    801132 <strtol+0xa0>
		base = 10;
  80112b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801132:	8b 45 08             	mov    0x8(%ebp),%eax
  801135:	8a 00                	mov    (%eax),%al
  801137:	3c 2f                	cmp    $0x2f,%al
  801139:	7e 19                	jle    801154 <strtol+0xc2>
  80113b:	8b 45 08             	mov    0x8(%ebp),%eax
  80113e:	8a 00                	mov    (%eax),%al
  801140:	3c 39                	cmp    $0x39,%al
  801142:	7f 10                	jg     801154 <strtol+0xc2>
			dig = *s - '0';
  801144:	8b 45 08             	mov    0x8(%ebp),%eax
  801147:	8a 00                	mov    (%eax),%al
  801149:	0f be c0             	movsbl %al,%eax
  80114c:	83 e8 30             	sub    $0x30,%eax
  80114f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801152:	eb 42                	jmp    801196 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801154:	8b 45 08             	mov    0x8(%ebp),%eax
  801157:	8a 00                	mov    (%eax),%al
  801159:	3c 60                	cmp    $0x60,%al
  80115b:	7e 19                	jle    801176 <strtol+0xe4>
  80115d:	8b 45 08             	mov    0x8(%ebp),%eax
  801160:	8a 00                	mov    (%eax),%al
  801162:	3c 7a                	cmp    $0x7a,%al
  801164:	7f 10                	jg     801176 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801166:	8b 45 08             	mov    0x8(%ebp),%eax
  801169:	8a 00                	mov    (%eax),%al
  80116b:	0f be c0             	movsbl %al,%eax
  80116e:	83 e8 57             	sub    $0x57,%eax
  801171:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801174:	eb 20                	jmp    801196 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801176:	8b 45 08             	mov    0x8(%ebp),%eax
  801179:	8a 00                	mov    (%eax),%al
  80117b:	3c 40                	cmp    $0x40,%al
  80117d:	7e 39                	jle    8011b8 <strtol+0x126>
  80117f:	8b 45 08             	mov    0x8(%ebp),%eax
  801182:	8a 00                	mov    (%eax),%al
  801184:	3c 5a                	cmp    $0x5a,%al
  801186:	7f 30                	jg     8011b8 <strtol+0x126>
			dig = *s - 'A' + 10;
  801188:	8b 45 08             	mov    0x8(%ebp),%eax
  80118b:	8a 00                	mov    (%eax),%al
  80118d:	0f be c0             	movsbl %al,%eax
  801190:	83 e8 37             	sub    $0x37,%eax
  801193:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801196:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801199:	3b 45 10             	cmp    0x10(%ebp),%eax
  80119c:	7d 19                	jge    8011b7 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80119e:	ff 45 08             	incl   0x8(%ebp)
  8011a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011a4:	0f af 45 10          	imul   0x10(%ebp),%eax
  8011a8:	89 c2                	mov    %eax,%edx
  8011aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011ad:	01 d0                	add    %edx,%eax
  8011af:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8011b2:	e9 7b ff ff ff       	jmp    801132 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8011b7:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8011b8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011bc:	74 08                	je     8011c6 <strtol+0x134>
		*endptr = (char *) s;
  8011be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c1:	8b 55 08             	mov    0x8(%ebp),%edx
  8011c4:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8011c6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011ca:	74 07                	je     8011d3 <strtol+0x141>
  8011cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011cf:	f7 d8                	neg    %eax
  8011d1:	eb 03                	jmp    8011d6 <strtol+0x144>
  8011d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011d6:	c9                   	leave  
  8011d7:	c3                   	ret    

008011d8 <ltostr>:

void
ltostr(long value, char *str)
{
  8011d8:	55                   	push   %ebp
  8011d9:	89 e5                	mov    %esp,%ebp
  8011db:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8011de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8011e5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8011ec:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011f0:	79 13                	jns    801205 <ltostr+0x2d>
	{
		neg = 1;
  8011f2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8011f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011fc:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8011ff:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801202:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801205:	8b 45 08             	mov    0x8(%ebp),%eax
  801208:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80120d:	99                   	cltd   
  80120e:	f7 f9                	idiv   %ecx
  801210:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801213:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801216:	8d 50 01             	lea    0x1(%eax),%edx
  801219:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80121c:	89 c2                	mov    %eax,%edx
  80121e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801221:	01 d0                	add    %edx,%eax
  801223:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801226:	83 c2 30             	add    $0x30,%edx
  801229:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80122b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80122e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801233:	f7 e9                	imul   %ecx
  801235:	c1 fa 02             	sar    $0x2,%edx
  801238:	89 c8                	mov    %ecx,%eax
  80123a:	c1 f8 1f             	sar    $0x1f,%eax
  80123d:	29 c2                	sub    %eax,%edx
  80123f:	89 d0                	mov    %edx,%eax
  801241:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801244:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801247:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80124c:	f7 e9                	imul   %ecx
  80124e:	c1 fa 02             	sar    $0x2,%edx
  801251:	89 c8                	mov    %ecx,%eax
  801253:	c1 f8 1f             	sar    $0x1f,%eax
  801256:	29 c2                	sub    %eax,%edx
  801258:	89 d0                	mov    %edx,%eax
  80125a:	c1 e0 02             	shl    $0x2,%eax
  80125d:	01 d0                	add    %edx,%eax
  80125f:	01 c0                	add    %eax,%eax
  801261:	29 c1                	sub    %eax,%ecx
  801263:	89 ca                	mov    %ecx,%edx
  801265:	85 d2                	test   %edx,%edx
  801267:	75 9c                	jne    801205 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801269:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801270:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801273:	48                   	dec    %eax
  801274:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801277:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80127b:	74 3d                	je     8012ba <ltostr+0xe2>
		start = 1 ;
  80127d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801284:	eb 34                	jmp    8012ba <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801286:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801289:	8b 45 0c             	mov    0xc(%ebp),%eax
  80128c:	01 d0                	add    %edx,%eax
  80128e:	8a 00                	mov    (%eax),%al
  801290:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801293:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801296:	8b 45 0c             	mov    0xc(%ebp),%eax
  801299:	01 c2                	add    %eax,%edx
  80129b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80129e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a1:	01 c8                	add    %ecx,%eax
  8012a3:	8a 00                	mov    (%eax),%al
  8012a5:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8012a7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8012aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ad:	01 c2                	add    %eax,%edx
  8012af:	8a 45 eb             	mov    -0x15(%ebp),%al
  8012b2:	88 02                	mov    %al,(%edx)
		start++ ;
  8012b4:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8012b7:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8012ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012bd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012c0:	7c c4                	jl     801286 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8012c2:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8012c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c8:	01 d0                	add    %edx,%eax
  8012ca:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8012cd:	90                   	nop
  8012ce:	c9                   	leave  
  8012cf:	c3                   	ret    

008012d0 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8012d0:	55                   	push   %ebp
  8012d1:	89 e5                	mov    %esp,%ebp
  8012d3:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8012d6:	ff 75 08             	pushl  0x8(%ebp)
  8012d9:	e8 54 fa ff ff       	call   800d32 <strlen>
  8012de:	83 c4 04             	add    $0x4,%esp
  8012e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8012e4:	ff 75 0c             	pushl  0xc(%ebp)
  8012e7:	e8 46 fa ff ff       	call   800d32 <strlen>
  8012ec:	83 c4 04             	add    $0x4,%esp
  8012ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8012f2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8012f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801300:	eb 17                	jmp    801319 <strcconcat+0x49>
		final[s] = str1[s] ;
  801302:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801305:	8b 45 10             	mov    0x10(%ebp),%eax
  801308:	01 c2                	add    %eax,%edx
  80130a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80130d:	8b 45 08             	mov    0x8(%ebp),%eax
  801310:	01 c8                	add    %ecx,%eax
  801312:	8a 00                	mov    (%eax),%al
  801314:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801316:	ff 45 fc             	incl   -0x4(%ebp)
  801319:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80131c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80131f:	7c e1                	jl     801302 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801321:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801328:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80132f:	eb 1f                	jmp    801350 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801331:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801334:	8d 50 01             	lea    0x1(%eax),%edx
  801337:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80133a:	89 c2                	mov    %eax,%edx
  80133c:	8b 45 10             	mov    0x10(%ebp),%eax
  80133f:	01 c2                	add    %eax,%edx
  801341:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801344:	8b 45 0c             	mov    0xc(%ebp),%eax
  801347:	01 c8                	add    %ecx,%eax
  801349:	8a 00                	mov    (%eax),%al
  80134b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80134d:	ff 45 f8             	incl   -0x8(%ebp)
  801350:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801353:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801356:	7c d9                	jl     801331 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801358:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80135b:	8b 45 10             	mov    0x10(%ebp),%eax
  80135e:	01 d0                	add    %edx,%eax
  801360:	c6 00 00             	movb   $0x0,(%eax)
}
  801363:	90                   	nop
  801364:	c9                   	leave  
  801365:	c3                   	ret    

00801366 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801366:	55                   	push   %ebp
  801367:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801369:	8b 45 14             	mov    0x14(%ebp),%eax
  80136c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801372:	8b 45 14             	mov    0x14(%ebp),%eax
  801375:	8b 00                	mov    (%eax),%eax
  801377:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80137e:	8b 45 10             	mov    0x10(%ebp),%eax
  801381:	01 d0                	add    %edx,%eax
  801383:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801389:	eb 0c                	jmp    801397 <strsplit+0x31>
			*string++ = 0;
  80138b:	8b 45 08             	mov    0x8(%ebp),%eax
  80138e:	8d 50 01             	lea    0x1(%eax),%edx
  801391:	89 55 08             	mov    %edx,0x8(%ebp)
  801394:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801397:	8b 45 08             	mov    0x8(%ebp),%eax
  80139a:	8a 00                	mov    (%eax),%al
  80139c:	84 c0                	test   %al,%al
  80139e:	74 18                	je     8013b8 <strsplit+0x52>
  8013a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a3:	8a 00                	mov    (%eax),%al
  8013a5:	0f be c0             	movsbl %al,%eax
  8013a8:	50                   	push   %eax
  8013a9:	ff 75 0c             	pushl  0xc(%ebp)
  8013ac:	e8 13 fb ff ff       	call   800ec4 <strchr>
  8013b1:	83 c4 08             	add    $0x8,%esp
  8013b4:	85 c0                	test   %eax,%eax
  8013b6:	75 d3                	jne    80138b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8013b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bb:	8a 00                	mov    (%eax),%al
  8013bd:	84 c0                	test   %al,%al
  8013bf:	74 5a                	je     80141b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8013c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8013c4:	8b 00                	mov    (%eax),%eax
  8013c6:	83 f8 0f             	cmp    $0xf,%eax
  8013c9:	75 07                	jne    8013d2 <strsplit+0x6c>
		{
			return 0;
  8013cb:	b8 00 00 00 00       	mov    $0x0,%eax
  8013d0:	eb 66                	jmp    801438 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8013d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8013d5:	8b 00                	mov    (%eax),%eax
  8013d7:	8d 48 01             	lea    0x1(%eax),%ecx
  8013da:	8b 55 14             	mov    0x14(%ebp),%edx
  8013dd:	89 0a                	mov    %ecx,(%edx)
  8013df:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8013e9:	01 c2                	add    %eax,%edx
  8013eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ee:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013f0:	eb 03                	jmp    8013f5 <strsplit+0x8f>
			string++;
  8013f2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f8:	8a 00                	mov    (%eax),%al
  8013fa:	84 c0                	test   %al,%al
  8013fc:	74 8b                	je     801389 <strsplit+0x23>
  8013fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801401:	8a 00                	mov    (%eax),%al
  801403:	0f be c0             	movsbl %al,%eax
  801406:	50                   	push   %eax
  801407:	ff 75 0c             	pushl  0xc(%ebp)
  80140a:	e8 b5 fa ff ff       	call   800ec4 <strchr>
  80140f:	83 c4 08             	add    $0x8,%esp
  801412:	85 c0                	test   %eax,%eax
  801414:	74 dc                	je     8013f2 <strsplit+0x8c>
			string++;
	}
  801416:	e9 6e ff ff ff       	jmp    801389 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80141b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80141c:	8b 45 14             	mov    0x14(%ebp),%eax
  80141f:	8b 00                	mov    (%eax),%eax
  801421:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801428:	8b 45 10             	mov    0x10(%ebp),%eax
  80142b:	01 d0                	add    %edx,%eax
  80142d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801433:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801438:	c9                   	leave  
  801439:	c3                   	ret    

0080143a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80143a:	55                   	push   %ebp
  80143b:	89 e5                	mov    %esp,%ebp
  80143d:	57                   	push   %edi
  80143e:	56                   	push   %esi
  80143f:	53                   	push   %ebx
  801440:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801443:	8b 45 08             	mov    0x8(%ebp),%eax
  801446:	8b 55 0c             	mov    0xc(%ebp),%edx
  801449:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80144c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80144f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801452:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801455:	cd 30                	int    $0x30
  801457:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80145a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80145d:	83 c4 10             	add    $0x10,%esp
  801460:	5b                   	pop    %ebx
  801461:	5e                   	pop    %esi
  801462:	5f                   	pop    %edi
  801463:	5d                   	pop    %ebp
  801464:	c3                   	ret    

00801465 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801465:	55                   	push   %ebp
  801466:	89 e5                	mov    %esp,%ebp
  801468:	83 ec 04             	sub    $0x4,%esp
  80146b:	8b 45 10             	mov    0x10(%ebp),%eax
  80146e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801471:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801475:	8b 45 08             	mov    0x8(%ebp),%eax
  801478:	6a 00                	push   $0x0
  80147a:	6a 00                	push   $0x0
  80147c:	52                   	push   %edx
  80147d:	ff 75 0c             	pushl  0xc(%ebp)
  801480:	50                   	push   %eax
  801481:	6a 00                	push   $0x0
  801483:	e8 b2 ff ff ff       	call   80143a <syscall>
  801488:	83 c4 18             	add    $0x18,%esp
}
  80148b:	90                   	nop
  80148c:	c9                   	leave  
  80148d:	c3                   	ret    

0080148e <sys_cgetc>:

int
sys_cgetc(void)
{
  80148e:	55                   	push   %ebp
  80148f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801491:	6a 00                	push   $0x0
  801493:	6a 00                	push   $0x0
  801495:	6a 00                	push   $0x0
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	6a 01                	push   $0x1
  80149d:	e8 98 ff ff ff       	call   80143a <syscall>
  8014a2:	83 c4 18             	add    $0x18,%esp
}
  8014a5:	c9                   	leave  
  8014a6:	c3                   	ret    

008014a7 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8014a7:	55                   	push   %ebp
  8014a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8014aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ad:	6a 00                	push   $0x0
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	50                   	push   %eax
  8014b6:	6a 05                	push   $0x5
  8014b8:	e8 7d ff ff ff       	call   80143a <syscall>
  8014bd:	83 c4 18             	add    $0x18,%esp
}
  8014c0:	c9                   	leave  
  8014c1:	c3                   	ret    

008014c2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8014c2:	55                   	push   %ebp
  8014c3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8014c5:	6a 00                	push   $0x0
  8014c7:	6a 00                	push   $0x0
  8014c9:	6a 00                	push   $0x0
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 02                	push   $0x2
  8014d1:	e8 64 ff ff ff       	call   80143a <syscall>
  8014d6:	83 c4 18             	add    $0x18,%esp
}
  8014d9:	c9                   	leave  
  8014da:	c3                   	ret    

008014db <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8014db:	55                   	push   %ebp
  8014dc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8014de:	6a 00                	push   $0x0
  8014e0:	6a 00                	push   $0x0
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 03                	push   $0x3
  8014ea:	e8 4b ff ff ff       	call   80143a <syscall>
  8014ef:	83 c4 18             	add    $0x18,%esp
}
  8014f2:	c9                   	leave  
  8014f3:	c3                   	ret    

008014f4 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8014f4:	55                   	push   %ebp
  8014f5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	6a 04                	push   $0x4
  801503:	e8 32 ff ff ff       	call   80143a <syscall>
  801508:	83 c4 18             	add    $0x18,%esp
}
  80150b:	c9                   	leave  
  80150c:	c3                   	ret    

0080150d <sys_env_exit>:


void sys_env_exit(void)
{
  80150d:	55                   	push   %ebp
  80150e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801510:	6a 00                	push   $0x0
  801512:	6a 00                	push   $0x0
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	6a 06                	push   $0x6
  80151c:	e8 19 ff ff ff       	call   80143a <syscall>
  801521:	83 c4 18             	add    $0x18,%esp
}
  801524:	90                   	nop
  801525:	c9                   	leave  
  801526:	c3                   	ret    

00801527 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801527:	55                   	push   %ebp
  801528:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80152a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80152d:	8b 45 08             	mov    0x8(%ebp),%eax
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	52                   	push   %edx
  801537:	50                   	push   %eax
  801538:	6a 07                	push   $0x7
  80153a:	e8 fb fe ff ff       	call   80143a <syscall>
  80153f:	83 c4 18             	add    $0x18,%esp
}
  801542:	c9                   	leave  
  801543:	c3                   	ret    

00801544 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801544:	55                   	push   %ebp
  801545:	89 e5                	mov    %esp,%ebp
  801547:	56                   	push   %esi
  801548:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801549:	8b 75 18             	mov    0x18(%ebp),%esi
  80154c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80154f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801552:	8b 55 0c             	mov    0xc(%ebp),%edx
  801555:	8b 45 08             	mov    0x8(%ebp),%eax
  801558:	56                   	push   %esi
  801559:	53                   	push   %ebx
  80155a:	51                   	push   %ecx
  80155b:	52                   	push   %edx
  80155c:	50                   	push   %eax
  80155d:	6a 08                	push   $0x8
  80155f:	e8 d6 fe ff ff       	call   80143a <syscall>
  801564:	83 c4 18             	add    $0x18,%esp
}
  801567:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80156a:	5b                   	pop    %ebx
  80156b:	5e                   	pop    %esi
  80156c:	5d                   	pop    %ebp
  80156d:	c3                   	ret    

0080156e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80156e:	55                   	push   %ebp
  80156f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801571:	8b 55 0c             	mov    0xc(%ebp),%edx
  801574:	8b 45 08             	mov    0x8(%ebp),%eax
  801577:	6a 00                	push   $0x0
  801579:	6a 00                	push   $0x0
  80157b:	6a 00                	push   $0x0
  80157d:	52                   	push   %edx
  80157e:	50                   	push   %eax
  80157f:	6a 09                	push   $0x9
  801581:	e8 b4 fe ff ff       	call   80143a <syscall>
  801586:	83 c4 18             	add    $0x18,%esp
}
  801589:	c9                   	leave  
  80158a:	c3                   	ret    

0080158b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80158b:	55                   	push   %ebp
  80158c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80158e:	6a 00                	push   $0x0
  801590:	6a 00                	push   $0x0
  801592:	6a 00                	push   $0x0
  801594:	ff 75 0c             	pushl  0xc(%ebp)
  801597:	ff 75 08             	pushl  0x8(%ebp)
  80159a:	6a 0a                	push   $0xa
  80159c:	e8 99 fe ff ff       	call   80143a <syscall>
  8015a1:	83 c4 18             	add    $0x18,%esp
}
  8015a4:	c9                   	leave  
  8015a5:	c3                   	ret    

008015a6 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8015a6:	55                   	push   %ebp
  8015a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 0b                	push   $0xb
  8015b5:	e8 80 fe ff ff       	call   80143a <syscall>
  8015ba:	83 c4 18             	add    $0x18,%esp
}
  8015bd:	c9                   	leave  
  8015be:	c3                   	ret    

008015bf <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8015bf:	55                   	push   %ebp
  8015c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	6a 0c                	push   $0xc
  8015ce:	e8 67 fe ff ff       	call   80143a <syscall>
  8015d3:	83 c4 18             	add    $0x18,%esp
}
  8015d6:	c9                   	leave  
  8015d7:	c3                   	ret    

008015d8 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8015d8:	55                   	push   %ebp
  8015d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 0d                	push   $0xd
  8015e7:	e8 4e fe ff ff       	call   80143a <syscall>
  8015ec:	83 c4 18             	add    $0x18,%esp
}
  8015ef:	c9                   	leave  
  8015f0:	c3                   	ret    

008015f1 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8015f1:	55                   	push   %ebp
  8015f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8015f4:	6a 00                	push   $0x0
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	ff 75 0c             	pushl  0xc(%ebp)
  8015fd:	ff 75 08             	pushl  0x8(%ebp)
  801600:	6a 11                	push   $0x11
  801602:	e8 33 fe ff ff       	call   80143a <syscall>
  801607:	83 c4 18             	add    $0x18,%esp
	return;
  80160a:	90                   	nop
}
  80160b:	c9                   	leave  
  80160c:	c3                   	ret    

0080160d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80160d:	55                   	push   %ebp
  80160e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	ff 75 0c             	pushl  0xc(%ebp)
  801619:	ff 75 08             	pushl  0x8(%ebp)
  80161c:	6a 12                	push   $0x12
  80161e:	e8 17 fe ff ff       	call   80143a <syscall>
  801623:	83 c4 18             	add    $0x18,%esp
	return ;
  801626:	90                   	nop
}
  801627:	c9                   	leave  
  801628:	c3                   	ret    

00801629 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801629:	55                   	push   %ebp
  80162a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80162c:	6a 00                	push   $0x0
  80162e:	6a 00                	push   $0x0
  801630:	6a 00                	push   $0x0
  801632:	6a 00                	push   $0x0
  801634:	6a 00                	push   $0x0
  801636:	6a 0e                	push   $0xe
  801638:	e8 fd fd ff ff       	call   80143a <syscall>
  80163d:	83 c4 18             	add    $0x18,%esp
}
  801640:	c9                   	leave  
  801641:	c3                   	ret    

00801642 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801642:	55                   	push   %ebp
  801643:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801645:	6a 00                	push   $0x0
  801647:	6a 00                	push   $0x0
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	ff 75 08             	pushl  0x8(%ebp)
  801650:	6a 0f                	push   $0xf
  801652:	e8 e3 fd ff ff       	call   80143a <syscall>
  801657:	83 c4 18             	add    $0x18,%esp
}
  80165a:	c9                   	leave  
  80165b:	c3                   	ret    

0080165c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80165c:	55                   	push   %ebp
  80165d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80165f:	6a 00                	push   $0x0
  801661:	6a 00                	push   $0x0
  801663:	6a 00                	push   $0x0
  801665:	6a 00                	push   $0x0
  801667:	6a 00                	push   $0x0
  801669:	6a 10                	push   $0x10
  80166b:	e8 ca fd ff ff       	call   80143a <syscall>
  801670:	83 c4 18             	add    $0x18,%esp
}
  801673:	90                   	nop
  801674:	c9                   	leave  
  801675:	c3                   	ret    

00801676 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801676:	55                   	push   %ebp
  801677:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801679:	6a 00                	push   $0x0
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	6a 00                	push   $0x0
  801681:	6a 00                	push   $0x0
  801683:	6a 14                	push   $0x14
  801685:	e8 b0 fd ff ff       	call   80143a <syscall>
  80168a:	83 c4 18             	add    $0x18,%esp
}
  80168d:	90                   	nop
  80168e:	c9                   	leave  
  80168f:	c3                   	ret    

00801690 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801690:	55                   	push   %ebp
  801691:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801693:	6a 00                	push   $0x0
  801695:	6a 00                	push   $0x0
  801697:	6a 00                	push   $0x0
  801699:	6a 00                	push   $0x0
  80169b:	6a 00                	push   $0x0
  80169d:	6a 15                	push   $0x15
  80169f:	e8 96 fd ff ff       	call   80143a <syscall>
  8016a4:	83 c4 18             	add    $0x18,%esp
}
  8016a7:	90                   	nop
  8016a8:	c9                   	leave  
  8016a9:	c3                   	ret    

008016aa <sys_cputc>:


void
sys_cputc(const char c)
{
  8016aa:	55                   	push   %ebp
  8016ab:	89 e5                	mov    %esp,%ebp
  8016ad:	83 ec 04             	sub    $0x4,%esp
  8016b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8016b6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 00                	push   $0x0
  8016c2:	50                   	push   %eax
  8016c3:	6a 16                	push   $0x16
  8016c5:	e8 70 fd ff ff       	call   80143a <syscall>
  8016ca:	83 c4 18             	add    $0x18,%esp
}
  8016cd:	90                   	nop
  8016ce:	c9                   	leave  
  8016cf:	c3                   	ret    

008016d0 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8016d0:	55                   	push   %ebp
  8016d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 00                	push   $0x0
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 17                	push   $0x17
  8016df:	e8 56 fd ff ff       	call   80143a <syscall>
  8016e4:	83 c4 18             	add    $0x18,%esp
}
  8016e7:	90                   	nop
  8016e8:	c9                   	leave  
  8016e9:	c3                   	ret    

008016ea <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8016ea:	55                   	push   %ebp
  8016eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8016ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f0:	6a 00                	push   $0x0
  8016f2:	6a 00                	push   $0x0
  8016f4:	6a 00                	push   $0x0
  8016f6:	ff 75 0c             	pushl  0xc(%ebp)
  8016f9:	50                   	push   %eax
  8016fa:	6a 18                	push   $0x18
  8016fc:	e8 39 fd ff ff       	call   80143a <syscall>
  801701:	83 c4 18             	add    $0x18,%esp
}
  801704:	c9                   	leave  
  801705:	c3                   	ret    

00801706 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801706:	55                   	push   %ebp
  801707:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801709:	8b 55 0c             	mov    0xc(%ebp),%edx
  80170c:	8b 45 08             	mov    0x8(%ebp),%eax
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	6a 00                	push   $0x0
  801715:	52                   	push   %edx
  801716:	50                   	push   %eax
  801717:	6a 1b                	push   $0x1b
  801719:	e8 1c fd ff ff       	call   80143a <syscall>
  80171e:	83 c4 18             	add    $0x18,%esp
}
  801721:	c9                   	leave  
  801722:	c3                   	ret    

00801723 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801723:	55                   	push   %ebp
  801724:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801726:	8b 55 0c             	mov    0xc(%ebp),%edx
  801729:	8b 45 08             	mov    0x8(%ebp),%eax
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	6a 00                	push   $0x0
  801732:	52                   	push   %edx
  801733:	50                   	push   %eax
  801734:	6a 19                	push   $0x19
  801736:	e8 ff fc ff ff       	call   80143a <syscall>
  80173b:	83 c4 18             	add    $0x18,%esp
}
  80173e:	90                   	nop
  80173f:	c9                   	leave  
  801740:	c3                   	ret    

00801741 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801741:	55                   	push   %ebp
  801742:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801744:	8b 55 0c             	mov    0xc(%ebp),%edx
  801747:	8b 45 08             	mov    0x8(%ebp),%eax
  80174a:	6a 00                	push   $0x0
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	52                   	push   %edx
  801751:	50                   	push   %eax
  801752:	6a 1a                	push   $0x1a
  801754:	e8 e1 fc ff ff       	call   80143a <syscall>
  801759:	83 c4 18             	add    $0x18,%esp
}
  80175c:	90                   	nop
  80175d:	c9                   	leave  
  80175e:	c3                   	ret    

0080175f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80175f:	55                   	push   %ebp
  801760:	89 e5                	mov    %esp,%ebp
  801762:	83 ec 04             	sub    $0x4,%esp
  801765:	8b 45 10             	mov    0x10(%ebp),%eax
  801768:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80176b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80176e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801772:	8b 45 08             	mov    0x8(%ebp),%eax
  801775:	6a 00                	push   $0x0
  801777:	51                   	push   %ecx
  801778:	52                   	push   %edx
  801779:	ff 75 0c             	pushl  0xc(%ebp)
  80177c:	50                   	push   %eax
  80177d:	6a 1c                	push   $0x1c
  80177f:	e8 b6 fc ff ff       	call   80143a <syscall>
  801784:	83 c4 18             	add    $0x18,%esp
}
  801787:	c9                   	leave  
  801788:	c3                   	ret    

00801789 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801789:	55                   	push   %ebp
  80178a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80178c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80178f:	8b 45 08             	mov    0x8(%ebp),%eax
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	52                   	push   %edx
  801799:	50                   	push   %eax
  80179a:	6a 1d                	push   $0x1d
  80179c:	e8 99 fc ff ff       	call   80143a <syscall>
  8017a1:	83 c4 18             	add    $0x18,%esp
}
  8017a4:	c9                   	leave  
  8017a5:	c3                   	ret    

008017a6 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8017a6:	55                   	push   %ebp
  8017a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8017a9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017af:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	51                   	push   %ecx
  8017b7:	52                   	push   %edx
  8017b8:	50                   	push   %eax
  8017b9:	6a 1e                	push   $0x1e
  8017bb:	e8 7a fc ff ff       	call   80143a <syscall>
  8017c0:	83 c4 18             	add    $0x18,%esp
}
  8017c3:	c9                   	leave  
  8017c4:	c3                   	ret    

008017c5 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8017c5:	55                   	push   %ebp
  8017c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8017c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	52                   	push   %edx
  8017d5:	50                   	push   %eax
  8017d6:	6a 1f                	push   $0x1f
  8017d8:	e8 5d fc ff ff       	call   80143a <syscall>
  8017dd:	83 c4 18             	add    $0x18,%esp
}
  8017e0:	c9                   	leave  
  8017e1:	c3                   	ret    

008017e2 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8017e2:	55                   	push   %ebp
  8017e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8017e5:	6a 00                	push   $0x0
  8017e7:	6a 00                	push   $0x0
  8017e9:	6a 00                	push   $0x0
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 20                	push   $0x20
  8017f1:	e8 44 fc ff ff       	call   80143a <syscall>
  8017f6:	83 c4 18             	add    $0x18,%esp
}
  8017f9:	c9                   	leave  
  8017fa:	c3                   	ret    

008017fb <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8017fb:	55                   	push   %ebp
  8017fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8017fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801801:	6a 00                	push   $0x0
  801803:	ff 75 14             	pushl  0x14(%ebp)
  801806:	ff 75 10             	pushl  0x10(%ebp)
  801809:	ff 75 0c             	pushl  0xc(%ebp)
  80180c:	50                   	push   %eax
  80180d:	6a 21                	push   $0x21
  80180f:	e8 26 fc ff ff       	call   80143a <syscall>
  801814:	83 c4 18             	add    $0x18,%esp
}
  801817:	c9                   	leave  
  801818:	c3                   	ret    

00801819 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801819:	55                   	push   %ebp
  80181a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80181c:	8b 45 08             	mov    0x8(%ebp),%eax
  80181f:	6a 00                	push   $0x0
  801821:	6a 00                	push   $0x0
  801823:	6a 00                	push   $0x0
  801825:	6a 00                	push   $0x0
  801827:	50                   	push   %eax
  801828:	6a 22                	push   $0x22
  80182a:	e8 0b fc ff ff       	call   80143a <syscall>
  80182f:	83 c4 18             	add    $0x18,%esp
}
  801832:	90                   	nop
  801833:	c9                   	leave  
  801834:	c3                   	ret    

00801835 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801835:	55                   	push   %ebp
  801836:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801838:	8b 45 08             	mov    0x8(%ebp),%eax
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	50                   	push   %eax
  801844:	6a 23                	push   $0x23
  801846:	e8 ef fb ff ff       	call   80143a <syscall>
  80184b:	83 c4 18             	add    $0x18,%esp
}
  80184e:	90                   	nop
  80184f:	c9                   	leave  
  801850:	c3                   	ret    

00801851 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801851:	55                   	push   %ebp
  801852:	89 e5                	mov    %esp,%ebp
  801854:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801857:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80185a:	8d 50 04             	lea    0x4(%eax),%edx
  80185d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	52                   	push   %edx
  801867:	50                   	push   %eax
  801868:	6a 24                	push   $0x24
  80186a:	e8 cb fb ff ff       	call   80143a <syscall>
  80186f:	83 c4 18             	add    $0x18,%esp
	return result;
  801872:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801875:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801878:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80187b:	89 01                	mov    %eax,(%ecx)
  80187d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801880:	8b 45 08             	mov    0x8(%ebp),%eax
  801883:	c9                   	leave  
  801884:	c2 04 00             	ret    $0x4

00801887 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801887:	55                   	push   %ebp
  801888:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	ff 75 10             	pushl  0x10(%ebp)
  801891:	ff 75 0c             	pushl  0xc(%ebp)
  801894:	ff 75 08             	pushl  0x8(%ebp)
  801897:	6a 13                	push   $0x13
  801899:	e8 9c fb ff ff       	call   80143a <syscall>
  80189e:	83 c4 18             	add    $0x18,%esp
	return ;
  8018a1:	90                   	nop
}
  8018a2:	c9                   	leave  
  8018a3:	c3                   	ret    

008018a4 <sys_rcr2>:
uint32 sys_rcr2()
{
  8018a4:	55                   	push   %ebp
  8018a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 00                	push   $0x0
  8018b1:	6a 25                	push   $0x25
  8018b3:	e8 82 fb ff ff       	call   80143a <syscall>
  8018b8:	83 c4 18             	add    $0x18,%esp
}
  8018bb:	c9                   	leave  
  8018bc:	c3                   	ret    

008018bd <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8018bd:	55                   	push   %ebp
  8018be:	89 e5                	mov    %esp,%ebp
  8018c0:	83 ec 04             	sub    $0x4,%esp
  8018c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8018c9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	50                   	push   %eax
  8018d6:	6a 26                	push   $0x26
  8018d8:	e8 5d fb ff ff       	call   80143a <syscall>
  8018dd:	83 c4 18             	add    $0x18,%esp
	return ;
  8018e0:	90                   	nop
}
  8018e1:	c9                   	leave  
  8018e2:	c3                   	ret    

008018e3 <rsttst>:
void rsttst()
{
  8018e3:	55                   	push   %ebp
  8018e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8018e6:	6a 00                	push   $0x0
  8018e8:	6a 00                	push   $0x0
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 00                	push   $0x0
  8018ee:	6a 00                	push   $0x0
  8018f0:	6a 28                	push   $0x28
  8018f2:	e8 43 fb ff ff       	call   80143a <syscall>
  8018f7:	83 c4 18             	add    $0x18,%esp
	return ;
  8018fa:	90                   	nop
}
  8018fb:	c9                   	leave  
  8018fc:	c3                   	ret    

008018fd <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8018fd:	55                   	push   %ebp
  8018fe:	89 e5                	mov    %esp,%ebp
  801900:	83 ec 04             	sub    $0x4,%esp
  801903:	8b 45 14             	mov    0x14(%ebp),%eax
  801906:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801909:	8b 55 18             	mov    0x18(%ebp),%edx
  80190c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801910:	52                   	push   %edx
  801911:	50                   	push   %eax
  801912:	ff 75 10             	pushl  0x10(%ebp)
  801915:	ff 75 0c             	pushl  0xc(%ebp)
  801918:	ff 75 08             	pushl  0x8(%ebp)
  80191b:	6a 27                	push   $0x27
  80191d:	e8 18 fb ff ff       	call   80143a <syscall>
  801922:	83 c4 18             	add    $0x18,%esp
	return ;
  801925:	90                   	nop
}
  801926:	c9                   	leave  
  801927:	c3                   	ret    

00801928 <chktst>:
void chktst(uint32 n)
{
  801928:	55                   	push   %ebp
  801929:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80192b:	6a 00                	push   $0x0
  80192d:	6a 00                	push   $0x0
  80192f:	6a 00                	push   $0x0
  801931:	6a 00                	push   $0x0
  801933:	ff 75 08             	pushl  0x8(%ebp)
  801936:	6a 29                	push   $0x29
  801938:	e8 fd fa ff ff       	call   80143a <syscall>
  80193d:	83 c4 18             	add    $0x18,%esp
	return ;
  801940:	90                   	nop
}
  801941:	c9                   	leave  
  801942:	c3                   	ret    

00801943 <inctst>:

void inctst()
{
  801943:	55                   	push   %ebp
  801944:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801946:	6a 00                	push   $0x0
  801948:	6a 00                	push   $0x0
  80194a:	6a 00                	push   $0x0
  80194c:	6a 00                	push   $0x0
  80194e:	6a 00                	push   $0x0
  801950:	6a 2a                	push   $0x2a
  801952:	e8 e3 fa ff ff       	call   80143a <syscall>
  801957:	83 c4 18             	add    $0x18,%esp
	return ;
  80195a:	90                   	nop
}
  80195b:	c9                   	leave  
  80195c:	c3                   	ret    

0080195d <gettst>:
uint32 gettst()
{
  80195d:	55                   	push   %ebp
  80195e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801960:	6a 00                	push   $0x0
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	6a 00                	push   $0x0
  801968:	6a 00                	push   $0x0
  80196a:	6a 2b                	push   $0x2b
  80196c:	e8 c9 fa ff ff       	call   80143a <syscall>
  801971:	83 c4 18             	add    $0x18,%esp
}
  801974:	c9                   	leave  
  801975:	c3                   	ret    

00801976 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801976:	55                   	push   %ebp
  801977:	89 e5                	mov    %esp,%ebp
  801979:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80197c:	6a 00                	push   $0x0
  80197e:	6a 00                	push   $0x0
  801980:	6a 00                	push   $0x0
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	6a 2c                	push   $0x2c
  801988:	e8 ad fa ff ff       	call   80143a <syscall>
  80198d:	83 c4 18             	add    $0x18,%esp
  801990:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801993:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801997:	75 07                	jne    8019a0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801999:	b8 01 00 00 00       	mov    $0x1,%eax
  80199e:	eb 05                	jmp    8019a5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8019a0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019a5:	c9                   	leave  
  8019a6:	c3                   	ret    

008019a7 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8019a7:	55                   	push   %ebp
  8019a8:	89 e5                	mov    %esp,%ebp
  8019aa:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	6a 00                	push   $0x0
  8019b3:	6a 00                	push   $0x0
  8019b5:	6a 00                	push   $0x0
  8019b7:	6a 2c                	push   $0x2c
  8019b9:	e8 7c fa ff ff       	call   80143a <syscall>
  8019be:	83 c4 18             	add    $0x18,%esp
  8019c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8019c4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8019c8:	75 07                	jne    8019d1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8019ca:	b8 01 00 00 00       	mov    $0x1,%eax
  8019cf:	eb 05                	jmp    8019d6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8019d1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019d6:	c9                   	leave  
  8019d7:	c3                   	ret    

008019d8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8019d8:	55                   	push   %ebp
  8019d9:	89 e5                	mov    %esp,%ebp
  8019db:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019de:	6a 00                	push   $0x0
  8019e0:	6a 00                	push   $0x0
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	6a 00                	push   $0x0
  8019e8:	6a 2c                	push   $0x2c
  8019ea:	e8 4b fa ff ff       	call   80143a <syscall>
  8019ef:	83 c4 18             	add    $0x18,%esp
  8019f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8019f5:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8019f9:	75 07                	jne    801a02 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8019fb:	b8 01 00 00 00       	mov    $0x1,%eax
  801a00:	eb 05                	jmp    801a07 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801a02:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a07:	c9                   	leave  
  801a08:	c3                   	ret    

00801a09 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801a09:	55                   	push   %ebp
  801a0a:	89 e5                	mov    %esp,%ebp
  801a0c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	6a 00                	push   $0x0
  801a17:	6a 00                	push   $0x0
  801a19:	6a 2c                	push   $0x2c
  801a1b:	e8 1a fa ff ff       	call   80143a <syscall>
  801a20:	83 c4 18             	add    $0x18,%esp
  801a23:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801a26:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801a2a:	75 07                	jne    801a33 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801a2c:	b8 01 00 00 00       	mov    $0x1,%eax
  801a31:	eb 05                	jmp    801a38 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801a33:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a38:	c9                   	leave  
  801a39:	c3                   	ret    

00801a3a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a3a:	55                   	push   %ebp
  801a3b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a3d:	6a 00                	push   $0x0
  801a3f:	6a 00                	push   $0x0
  801a41:	6a 00                	push   $0x0
  801a43:	6a 00                	push   $0x0
  801a45:	ff 75 08             	pushl  0x8(%ebp)
  801a48:	6a 2d                	push   $0x2d
  801a4a:	e8 eb f9 ff ff       	call   80143a <syscall>
  801a4f:	83 c4 18             	add    $0x18,%esp
	return ;
  801a52:	90                   	nop
}
  801a53:	c9                   	leave  
  801a54:	c3                   	ret    

00801a55 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801a55:	55                   	push   %ebp
  801a56:	89 e5                	mov    %esp,%ebp
  801a58:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801a59:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a5c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a62:	8b 45 08             	mov    0x8(%ebp),%eax
  801a65:	6a 00                	push   $0x0
  801a67:	53                   	push   %ebx
  801a68:	51                   	push   %ecx
  801a69:	52                   	push   %edx
  801a6a:	50                   	push   %eax
  801a6b:	6a 2e                	push   $0x2e
  801a6d:	e8 c8 f9 ff ff       	call   80143a <syscall>
  801a72:	83 c4 18             	add    $0x18,%esp
}
  801a75:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801a78:	c9                   	leave  
  801a79:	c3                   	ret    

00801a7a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801a7a:	55                   	push   %ebp
  801a7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801a7d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a80:	8b 45 08             	mov    0x8(%ebp),%eax
  801a83:	6a 00                	push   $0x0
  801a85:	6a 00                	push   $0x0
  801a87:	6a 00                	push   $0x0
  801a89:	52                   	push   %edx
  801a8a:	50                   	push   %eax
  801a8b:	6a 2f                	push   $0x2f
  801a8d:	e8 a8 f9 ff ff       	call   80143a <syscall>
  801a92:	83 c4 18             	add    $0x18,%esp
}
  801a95:	c9                   	leave  
  801a96:	c3                   	ret    
  801a97:	90                   	nop

00801a98 <__udivdi3>:
  801a98:	55                   	push   %ebp
  801a99:	57                   	push   %edi
  801a9a:	56                   	push   %esi
  801a9b:	53                   	push   %ebx
  801a9c:	83 ec 1c             	sub    $0x1c,%esp
  801a9f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801aa3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801aa7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801aab:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801aaf:	89 ca                	mov    %ecx,%edx
  801ab1:	89 f8                	mov    %edi,%eax
  801ab3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ab7:	85 f6                	test   %esi,%esi
  801ab9:	75 2d                	jne    801ae8 <__udivdi3+0x50>
  801abb:	39 cf                	cmp    %ecx,%edi
  801abd:	77 65                	ja     801b24 <__udivdi3+0x8c>
  801abf:	89 fd                	mov    %edi,%ebp
  801ac1:	85 ff                	test   %edi,%edi
  801ac3:	75 0b                	jne    801ad0 <__udivdi3+0x38>
  801ac5:	b8 01 00 00 00       	mov    $0x1,%eax
  801aca:	31 d2                	xor    %edx,%edx
  801acc:	f7 f7                	div    %edi
  801ace:	89 c5                	mov    %eax,%ebp
  801ad0:	31 d2                	xor    %edx,%edx
  801ad2:	89 c8                	mov    %ecx,%eax
  801ad4:	f7 f5                	div    %ebp
  801ad6:	89 c1                	mov    %eax,%ecx
  801ad8:	89 d8                	mov    %ebx,%eax
  801ada:	f7 f5                	div    %ebp
  801adc:	89 cf                	mov    %ecx,%edi
  801ade:	89 fa                	mov    %edi,%edx
  801ae0:	83 c4 1c             	add    $0x1c,%esp
  801ae3:	5b                   	pop    %ebx
  801ae4:	5e                   	pop    %esi
  801ae5:	5f                   	pop    %edi
  801ae6:	5d                   	pop    %ebp
  801ae7:	c3                   	ret    
  801ae8:	39 ce                	cmp    %ecx,%esi
  801aea:	77 28                	ja     801b14 <__udivdi3+0x7c>
  801aec:	0f bd fe             	bsr    %esi,%edi
  801aef:	83 f7 1f             	xor    $0x1f,%edi
  801af2:	75 40                	jne    801b34 <__udivdi3+0x9c>
  801af4:	39 ce                	cmp    %ecx,%esi
  801af6:	72 0a                	jb     801b02 <__udivdi3+0x6a>
  801af8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801afc:	0f 87 9e 00 00 00    	ja     801ba0 <__udivdi3+0x108>
  801b02:	b8 01 00 00 00       	mov    $0x1,%eax
  801b07:	89 fa                	mov    %edi,%edx
  801b09:	83 c4 1c             	add    $0x1c,%esp
  801b0c:	5b                   	pop    %ebx
  801b0d:	5e                   	pop    %esi
  801b0e:	5f                   	pop    %edi
  801b0f:	5d                   	pop    %ebp
  801b10:	c3                   	ret    
  801b11:	8d 76 00             	lea    0x0(%esi),%esi
  801b14:	31 ff                	xor    %edi,%edi
  801b16:	31 c0                	xor    %eax,%eax
  801b18:	89 fa                	mov    %edi,%edx
  801b1a:	83 c4 1c             	add    $0x1c,%esp
  801b1d:	5b                   	pop    %ebx
  801b1e:	5e                   	pop    %esi
  801b1f:	5f                   	pop    %edi
  801b20:	5d                   	pop    %ebp
  801b21:	c3                   	ret    
  801b22:	66 90                	xchg   %ax,%ax
  801b24:	89 d8                	mov    %ebx,%eax
  801b26:	f7 f7                	div    %edi
  801b28:	31 ff                	xor    %edi,%edi
  801b2a:	89 fa                	mov    %edi,%edx
  801b2c:	83 c4 1c             	add    $0x1c,%esp
  801b2f:	5b                   	pop    %ebx
  801b30:	5e                   	pop    %esi
  801b31:	5f                   	pop    %edi
  801b32:	5d                   	pop    %ebp
  801b33:	c3                   	ret    
  801b34:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b39:	89 eb                	mov    %ebp,%ebx
  801b3b:	29 fb                	sub    %edi,%ebx
  801b3d:	89 f9                	mov    %edi,%ecx
  801b3f:	d3 e6                	shl    %cl,%esi
  801b41:	89 c5                	mov    %eax,%ebp
  801b43:	88 d9                	mov    %bl,%cl
  801b45:	d3 ed                	shr    %cl,%ebp
  801b47:	89 e9                	mov    %ebp,%ecx
  801b49:	09 f1                	or     %esi,%ecx
  801b4b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b4f:	89 f9                	mov    %edi,%ecx
  801b51:	d3 e0                	shl    %cl,%eax
  801b53:	89 c5                	mov    %eax,%ebp
  801b55:	89 d6                	mov    %edx,%esi
  801b57:	88 d9                	mov    %bl,%cl
  801b59:	d3 ee                	shr    %cl,%esi
  801b5b:	89 f9                	mov    %edi,%ecx
  801b5d:	d3 e2                	shl    %cl,%edx
  801b5f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b63:	88 d9                	mov    %bl,%cl
  801b65:	d3 e8                	shr    %cl,%eax
  801b67:	09 c2                	or     %eax,%edx
  801b69:	89 d0                	mov    %edx,%eax
  801b6b:	89 f2                	mov    %esi,%edx
  801b6d:	f7 74 24 0c          	divl   0xc(%esp)
  801b71:	89 d6                	mov    %edx,%esi
  801b73:	89 c3                	mov    %eax,%ebx
  801b75:	f7 e5                	mul    %ebp
  801b77:	39 d6                	cmp    %edx,%esi
  801b79:	72 19                	jb     801b94 <__udivdi3+0xfc>
  801b7b:	74 0b                	je     801b88 <__udivdi3+0xf0>
  801b7d:	89 d8                	mov    %ebx,%eax
  801b7f:	31 ff                	xor    %edi,%edi
  801b81:	e9 58 ff ff ff       	jmp    801ade <__udivdi3+0x46>
  801b86:	66 90                	xchg   %ax,%ax
  801b88:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b8c:	89 f9                	mov    %edi,%ecx
  801b8e:	d3 e2                	shl    %cl,%edx
  801b90:	39 c2                	cmp    %eax,%edx
  801b92:	73 e9                	jae    801b7d <__udivdi3+0xe5>
  801b94:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b97:	31 ff                	xor    %edi,%edi
  801b99:	e9 40 ff ff ff       	jmp    801ade <__udivdi3+0x46>
  801b9e:	66 90                	xchg   %ax,%ax
  801ba0:	31 c0                	xor    %eax,%eax
  801ba2:	e9 37 ff ff ff       	jmp    801ade <__udivdi3+0x46>
  801ba7:	90                   	nop

00801ba8 <__umoddi3>:
  801ba8:	55                   	push   %ebp
  801ba9:	57                   	push   %edi
  801baa:	56                   	push   %esi
  801bab:	53                   	push   %ebx
  801bac:	83 ec 1c             	sub    $0x1c,%esp
  801baf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801bb3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801bb7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801bbb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801bbf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801bc3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801bc7:	89 f3                	mov    %esi,%ebx
  801bc9:	89 fa                	mov    %edi,%edx
  801bcb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bcf:	89 34 24             	mov    %esi,(%esp)
  801bd2:	85 c0                	test   %eax,%eax
  801bd4:	75 1a                	jne    801bf0 <__umoddi3+0x48>
  801bd6:	39 f7                	cmp    %esi,%edi
  801bd8:	0f 86 a2 00 00 00    	jbe    801c80 <__umoddi3+0xd8>
  801bde:	89 c8                	mov    %ecx,%eax
  801be0:	89 f2                	mov    %esi,%edx
  801be2:	f7 f7                	div    %edi
  801be4:	89 d0                	mov    %edx,%eax
  801be6:	31 d2                	xor    %edx,%edx
  801be8:	83 c4 1c             	add    $0x1c,%esp
  801beb:	5b                   	pop    %ebx
  801bec:	5e                   	pop    %esi
  801bed:	5f                   	pop    %edi
  801bee:	5d                   	pop    %ebp
  801bef:	c3                   	ret    
  801bf0:	39 f0                	cmp    %esi,%eax
  801bf2:	0f 87 ac 00 00 00    	ja     801ca4 <__umoddi3+0xfc>
  801bf8:	0f bd e8             	bsr    %eax,%ebp
  801bfb:	83 f5 1f             	xor    $0x1f,%ebp
  801bfe:	0f 84 ac 00 00 00    	je     801cb0 <__umoddi3+0x108>
  801c04:	bf 20 00 00 00       	mov    $0x20,%edi
  801c09:	29 ef                	sub    %ebp,%edi
  801c0b:	89 fe                	mov    %edi,%esi
  801c0d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c11:	89 e9                	mov    %ebp,%ecx
  801c13:	d3 e0                	shl    %cl,%eax
  801c15:	89 d7                	mov    %edx,%edi
  801c17:	89 f1                	mov    %esi,%ecx
  801c19:	d3 ef                	shr    %cl,%edi
  801c1b:	09 c7                	or     %eax,%edi
  801c1d:	89 e9                	mov    %ebp,%ecx
  801c1f:	d3 e2                	shl    %cl,%edx
  801c21:	89 14 24             	mov    %edx,(%esp)
  801c24:	89 d8                	mov    %ebx,%eax
  801c26:	d3 e0                	shl    %cl,%eax
  801c28:	89 c2                	mov    %eax,%edx
  801c2a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c2e:	d3 e0                	shl    %cl,%eax
  801c30:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c34:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c38:	89 f1                	mov    %esi,%ecx
  801c3a:	d3 e8                	shr    %cl,%eax
  801c3c:	09 d0                	or     %edx,%eax
  801c3e:	d3 eb                	shr    %cl,%ebx
  801c40:	89 da                	mov    %ebx,%edx
  801c42:	f7 f7                	div    %edi
  801c44:	89 d3                	mov    %edx,%ebx
  801c46:	f7 24 24             	mull   (%esp)
  801c49:	89 c6                	mov    %eax,%esi
  801c4b:	89 d1                	mov    %edx,%ecx
  801c4d:	39 d3                	cmp    %edx,%ebx
  801c4f:	0f 82 87 00 00 00    	jb     801cdc <__umoddi3+0x134>
  801c55:	0f 84 91 00 00 00    	je     801cec <__umoddi3+0x144>
  801c5b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c5f:	29 f2                	sub    %esi,%edx
  801c61:	19 cb                	sbb    %ecx,%ebx
  801c63:	89 d8                	mov    %ebx,%eax
  801c65:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c69:	d3 e0                	shl    %cl,%eax
  801c6b:	89 e9                	mov    %ebp,%ecx
  801c6d:	d3 ea                	shr    %cl,%edx
  801c6f:	09 d0                	or     %edx,%eax
  801c71:	89 e9                	mov    %ebp,%ecx
  801c73:	d3 eb                	shr    %cl,%ebx
  801c75:	89 da                	mov    %ebx,%edx
  801c77:	83 c4 1c             	add    $0x1c,%esp
  801c7a:	5b                   	pop    %ebx
  801c7b:	5e                   	pop    %esi
  801c7c:	5f                   	pop    %edi
  801c7d:	5d                   	pop    %ebp
  801c7e:	c3                   	ret    
  801c7f:	90                   	nop
  801c80:	89 fd                	mov    %edi,%ebp
  801c82:	85 ff                	test   %edi,%edi
  801c84:	75 0b                	jne    801c91 <__umoddi3+0xe9>
  801c86:	b8 01 00 00 00       	mov    $0x1,%eax
  801c8b:	31 d2                	xor    %edx,%edx
  801c8d:	f7 f7                	div    %edi
  801c8f:	89 c5                	mov    %eax,%ebp
  801c91:	89 f0                	mov    %esi,%eax
  801c93:	31 d2                	xor    %edx,%edx
  801c95:	f7 f5                	div    %ebp
  801c97:	89 c8                	mov    %ecx,%eax
  801c99:	f7 f5                	div    %ebp
  801c9b:	89 d0                	mov    %edx,%eax
  801c9d:	e9 44 ff ff ff       	jmp    801be6 <__umoddi3+0x3e>
  801ca2:	66 90                	xchg   %ax,%ax
  801ca4:	89 c8                	mov    %ecx,%eax
  801ca6:	89 f2                	mov    %esi,%edx
  801ca8:	83 c4 1c             	add    $0x1c,%esp
  801cab:	5b                   	pop    %ebx
  801cac:	5e                   	pop    %esi
  801cad:	5f                   	pop    %edi
  801cae:	5d                   	pop    %ebp
  801caf:	c3                   	ret    
  801cb0:	3b 04 24             	cmp    (%esp),%eax
  801cb3:	72 06                	jb     801cbb <__umoddi3+0x113>
  801cb5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801cb9:	77 0f                	ja     801cca <__umoddi3+0x122>
  801cbb:	89 f2                	mov    %esi,%edx
  801cbd:	29 f9                	sub    %edi,%ecx
  801cbf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801cc3:	89 14 24             	mov    %edx,(%esp)
  801cc6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801cca:	8b 44 24 04          	mov    0x4(%esp),%eax
  801cce:	8b 14 24             	mov    (%esp),%edx
  801cd1:	83 c4 1c             	add    $0x1c,%esp
  801cd4:	5b                   	pop    %ebx
  801cd5:	5e                   	pop    %esi
  801cd6:	5f                   	pop    %edi
  801cd7:	5d                   	pop    %ebp
  801cd8:	c3                   	ret    
  801cd9:	8d 76 00             	lea    0x0(%esi),%esi
  801cdc:	2b 04 24             	sub    (%esp),%eax
  801cdf:	19 fa                	sbb    %edi,%edx
  801ce1:	89 d1                	mov    %edx,%ecx
  801ce3:	89 c6                	mov    %eax,%esi
  801ce5:	e9 71 ff ff ff       	jmp    801c5b <__umoddi3+0xb3>
  801cea:	66 90                	xchg   %ax,%ax
  801cec:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801cf0:	72 ea                	jb     801cdc <__umoddi3+0x134>
  801cf2:	89 d9                	mov    %ebx,%ecx
  801cf4:	e9 62 ff ff ff       	jmp    801c5b <__umoddi3+0xb3>
