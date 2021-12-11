
obj/user/tst_table_replacement_lru:     file format elf32-i386


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
  800031:	e8 c9 02 00 00       	call   8002ff <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:


uint8* ptr = (uint8* )0x0800000 ;
int i ;
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 34 00 00 02    	sub    $0x2000034,%esp

	
	

	{
		if ( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0x00000000)  panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  800042:	a1 20 30 80 00       	mov    0x803020,%eax
  800047:	8b 80 f8 38 01 00    	mov    0x138f8(%eax),%eax
  80004d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800050:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800053:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800058:	85 c0                	test   %eax,%eax
  80005a:	74 14                	je     800070 <_main+0x38>
  80005c:	83 ec 04             	sub    $0x4,%esp
  80005f:	68 40 1d 80 00       	push   $0x801d40
  800064:	6a 16                	push   $0x16
  800066:	68 8c 1d 80 00       	push   $0x801d8c
  80006b:	e8 d4 03 00 00       	call   800444 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x00800000)  panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  800070:	a1 20 30 80 00       	mov    0x803020,%eax
  800075:	8b 80 08 39 01 00    	mov    0x13908(%eax),%eax
  80007b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80007e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800081:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800086:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80008b:	74 14                	je     8000a1 <_main+0x69>
  80008d:	83 ec 04             	sub    $0x4,%esp
  800090:	68 40 1d 80 00       	push   $0x801d40
  800095:	6a 17                	push   $0x17
  800097:	68 8c 1d 80 00       	push   $0x801d8c
  80009c:	e8 a3 03 00 00       	call   800444 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xee800000)  panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  8000a1:	a1 20 30 80 00       	mov    0x803020,%eax
  8000a6:	8b 80 18 39 01 00    	mov    0x13918(%eax),%eax
  8000ac:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8000af:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000b2:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8000b7:	3d 00 00 80 ee       	cmp    $0xee800000,%eax
  8000bc:	74 14                	je     8000d2 <_main+0x9a>
  8000be:	83 ec 04             	sub    $0x4,%esp
  8000c1:	68 40 1d 80 00       	push   $0x801d40
  8000c6:	6a 18                	push   $0x18
  8000c8:	68 8c 1d 80 00       	push   $0x801d8c
  8000cd:	e8 72 03 00 00       	call   800444 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[3].virtual_address,1024*PAGE_SIZE) !=  0xec800000)  panic("INITIAL TABLE WS entry checking failed! Review sizes of the two WS's..!!");
  8000d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d7:	8b 80 28 39 01 00    	mov    0x13928(%eax),%eax
  8000dd:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8000e0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000e3:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8000e8:	3d 00 00 80 ec       	cmp    $0xec800000,%eax
  8000ed:	74 14                	je     800103 <_main+0xcb>
  8000ef:	83 ec 04             	sub    $0x4,%esp
  8000f2:	68 40 1d 80 00       	push   $0x801d40
  8000f7:	6a 19                	push   $0x19
  8000f9:	68 8c 1d 80 00       	push   $0x801d8c
  8000fe:	e8 41 03 00 00       	call   800444 <_panic>
		if( myEnv->table_last_WS_index !=  4)  											panic("INITIAL TABLE last index checking failed! Review sizes of the two WS's..!!");
  800103:	a1 20 30 80 00       	mov    0x803020,%eax
  800108:	8b 80 1c 3c 01 00    	mov    0x13c1c(%eax),%eax
  80010e:	83 f8 04             	cmp    $0x4,%eax
  800111:	74 14                	je     800127 <_main+0xef>
  800113:	83 ec 04             	sub    $0x4,%esp
  800116:	68 b0 1d 80 00       	push   $0x801db0
  80011b:	6a 1a                	push   $0x1a
  80011d:	68 8c 1d 80 00       	push   $0x801d8c
  800122:	e8 1d 03 00 00       	call   800444 <_panic>

	}

	{
		arr[0] = -1;
  800127:	c6 85 d4 ff ff fd ff 	movb   $0xff,-0x200002c(%ebp)
		arr[PAGE_SIZE*1024-1] = -1;
  80012e:	c6 85 d3 ff 3f fe ff 	movb   $0xff,-0x1c0002d(%ebp)


		for (i = 0 ; i < PAGE_SIZE / 2 ; i++)
  800135:	c7 05 14 31 80 00 00 	movl   $0x0,0x803114
  80013c:	00 00 00 
  80013f:	eb 26                	jmp    800167 <_main+0x12f>
		{
			arr[PAGE_SIZE*1024*2 - i] = i;
  800141:	a1 14 31 80 00       	mov    0x803114,%eax
  800146:	ba 00 00 80 00       	mov    $0x800000,%edx
  80014b:	29 c2                	sub    %eax,%edx
  80014d:	89 d0                	mov    %edx,%eax
  80014f:	8b 15 14 31 80 00    	mov    0x803114,%edx
  800155:	88 94 05 d4 ff ff fd 	mov    %dl,-0x200002c(%ebp,%eax,1)
	{
		arr[0] = -1;
		arr[PAGE_SIZE*1024-1] = -1;


		for (i = 0 ; i < PAGE_SIZE / 2 ; i++)
  80015c:	a1 14 31 80 00       	mov    0x803114,%eax
  800161:	40                   	inc    %eax
  800162:	a3 14 31 80 00       	mov    %eax,0x803114
  800167:	a1 14 31 80 00       	mov    0x803114,%eax
  80016c:	3d ff 07 00 00       	cmp    $0x7ff,%eax
  800171:	7e ce                	jle    800141 <_main+0x109>
		{
			arr[PAGE_SIZE*1024*2 - i] = i;
		}
		for (i = 0 ; i < PAGE_SIZE / 2; i++)
  800173:	c7 05 14 31 80 00 00 	movl   $0x0,0x803114
  80017a:	00 00 00 
  80017d:	eb 30                	jmp    8001af <_main+0x177>
		{
			arr[PAGE_SIZE*1024*3 - i] = i * i;
  80017f:	a1 14 31 80 00       	mov    0x803114,%eax
  800184:	ba 00 00 c0 00       	mov    $0xc00000,%edx
  800189:	29 c2                	sub    %eax,%edx
  80018b:	a1 14 31 80 00       	mov    0x803114,%eax
  800190:	88 c3                	mov    %al,%bl
  800192:	a1 14 31 80 00       	mov    0x803114,%eax
  800197:	88 c1                	mov    %al,%cl
  800199:	88 d8                	mov    %bl,%al
  80019b:	f6 e1                	mul    %cl
  80019d:	88 84 15 d4 ff ff fd 	mov    %al,-0x200002c(%ebp,%edx,1)

		for (i = 0 ; i < PAGE_SIZE / 2 ; i++)
		{
			arr[PAGE_SIZE*1024*2 - i] = i;
		}
		for (i = 0 ; i < PAGE_SIZE / 2; i++)
  8001a4:	a1 14 31 80 00       	mov    0x803114,%eax
  8001a9:	40                   	inc    %eax
  8001aa:	a3 14 31 80 00       	mov    %eax,0x803114
  8001af:	a1 14 31 80 00       	mov    0x803114,%eax
  8001b4:	3d ff 07 00 00       	cmp    $0x7ff,%eax
  8001b9:	7e c4                	jle    80017f <_main+0x147>
		{
			arr[PAGE_SIZE*1024*3 - i] = i * i;
		}
		arr[PAGE_SIZE*1024*5-1] = -1;
  8001bb:	c6 85 d3 ff 3f ff ff 	movb   $0xff,-0xc0002d(%ebp)
		arr[PAGE_SIZE*1024*6-1] = -1;
  8001c2:	c6 85 d3 ff 7f ff ff 	movb   $0xff,-0x80002d(%ebp)
		arr[PAGE_SIZE*1024*7-1] = -1;
  8001c9:	c6 85 d3 ff bf ff ff 	movb   $0xff,-0x40002d(%ebp)

	}
	//cprintf("testing ...\n");
	{
		//cprintf("WS[2] = %x\n", ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) );
		if( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0xee400000)  panic("LRU algo failed.. trace it by printing WS before and after table fault");
  8001d0:	a1 20 30 80 00       	mov    0x803020,%eax
  8001d5:	8b 80 f8 38 01 00    	mov    0x138f8(%eax),%eax
  8001db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8001de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001e1:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8001e6:	3d 00 00 40 ee       	cmp    $0xee400000,%eax
  8001eb:	74 14                	je     800201 <_main+0x1c9>
  8001ed:	83 ec 04             	sub    $0x4,%esp
  8001f0:	68 fc 1d 80 00       	push   $0x801dfc
  8001f5:	6a 33                	push   $0x33
  8001f7:	68 8c 1d 80 00       	push   $0x801d8c
  8001fc:	e8 43 02 00 00       	call   800444 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x00800000)  panic("LRU algo failed.. trace it by printing WS before and after table fault");
  800201:	a1 20 30 80 00       	mov    0x803020,%eax
  800206:	8b 80 08 39 01 00    	mov    0x13908(%eax),%eax
  80020c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  80020f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800212:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800217:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80021c:	74 14                	je     800232 <_main+0x1fa>
  80021e:	83 ec 04             	sub    $0x4,%esp
  800221:	68 fc 1d 80 00       	push   $0x801dfc
  800226:	6a 34                	push   $0x34
  800228:	68 8c 1d 80 00       	push   $0x801d8c
  80022d:	e8 12 02 00 00       	call   800444 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xec800000)  panic("LRU algo failed.. trace it by printing WS before and after table fault");
  800232:	a1 20 30 80 00       	mov    0x803020,%eax
  800237:	8b 80 18 39 01 00    	mov    0x13918(%eax),%eax
  80023d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800240:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800243:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800248:	3d 00 00 80 ec       	cmp    $0xec800000,%eax
  80024d:	74 14                	je     800263 <_main+0x22b>
  80024f:	83 ec 04             	sub    $0x4,%esp
  800252:	68 fc 1d 80 00       	push   $0x801dfc
  800257:	6a 35                	push   $0x35
  800259:	68 8c 1d 80 00       	push   $0x801d8c
  80025e:	e8 e1 01 00 00       	call   800444 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[3].virtual_address,1024*PAGE_SIZE) !=  0xedc00000)  panic("LRU algo failed.. trace it by printing WS before and after table fault");
  800263:	a1 20 30 80 00       	mov    0x803020,%eax
  800268:	8b 80 28 39 01 00    	mov    0x13928(%eax),%eax
  80026e:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800271:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800274:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800279:	3d 00 00 c0 ed       	cmp    $0xedc00000,%eax
  80027e:	74 14                	je     800294 <_main+0x25c>
  800280:	83 ec 04             	sub    $0x4,%esp
  800283:	68 fc 1d 80 00       	push   $0x801dfc
  800288:	6a 36                	push   $0x36
  80028a:	68 8c 1d 80 00       	push   $0x801d8c
  80028f:	e8 b0 01 00 00       	call   800444 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[4].virtual_address,1024*PAGE_SIZE) !=  0xee000000)  panic("LRU algo failed.. trace it by printing WS before and after table fault");
  800294:	a1 20 30 80 00       	mov    0x803020,%eax
  800299:	8b 80 38 39 01 00    	mov    0x13938(%eax),%eax
  80029f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8002a2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8002a5:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8002aa:	3d 00 00 00 ee       	cmp    $0xee000000,%eax
  8002af:	74 14                	je     8002c5 <_main+0x28d>
  8002b1:	83 ec 04             	sub    $0x4,%esp
  8002b4:	68 fc 1d 80 00       	push   $0x801dfc
  8002b9:	6a 37                	push   $0x37
  8002bb:	68 8c 1d 80 00       	push   $0x801d8c
  8002c0:	e8 7f 01 00 00       	call   800444 <_panic>

		if(myEnv->table_last_WS_index != 3) panic("wrong TABLE WS pointer location");
  8002c5:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ca:	8b 80 1c 3c 01 00    	mov    0x13c1c(%eax),%eax
  8002d0:	83 f8 03             	cmp    $0x3,%eax
  8002d3:	74 14                	je     8002e9 <_main+0x2b1>
  8002d5:	83 ec 04             	sub    $0x4,%esp
  8002d8:	68 44 1e 80 00       	push   $0x801e44
  8002dd:	6a 39                	push   $0x39
  8002df:	68 8c 1d 80 00       	push   $0x801d8c
  8002e4:	e8 5b 01 00 00       	call   800444 <_panic>
	}

	cprintf("Congratulations!! test table replacement (LRU alg) completed successfully.\n");
  8002e9:	83 ec 0c             	sub    $0xc,%esp
  8002ec:	68 64 1e 80 00       	push   $0x801e64
  8002f1:	e8 f0 03 00 00       	call   8006e6 <cprintf>
  8002f6:	83 c4 10             	add    $0x10,%esp
	return;
  8002f9:	90                   	nop
}
  8002fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8002fd:	c9                   	leave  
  8002fe:	c3                   	ret    

008002ff <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8002ff:	55                   	push   %ebp
  800300:	89 e5                	mov    %esp,%ebp
  800302:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800305:	e8 07 12 00 00       	call   801511 <sys_getenvindex>
  80030a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80030d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800310:	89 d0                	mov    %edx,%eax
  800312:	c1 e0 03             	shl    $0x3,%eax
  800315:	01 d0                	add    %edx,%eax
  800317:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80031e:	01 c8                	add    %ecx,%eax
  800320:	01 c0                	add    %eax,%eax
  800322:	01 d0                	add    %edx,%eax
  800324:	01 c0                	add    %eax,%eax
  800326:	01 d0                	add    %edx,%eax
  800328:	89 c2                	mov    %eax,%edx
  80032a:	c1 e2 05             	shl    $0x5,%edx
  80032d:	29 c2                	sub    %eax,%edx
  80032f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800336:	89 c2                	mov    %eax,%edx
  800338:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80033e:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800343:	a1 20 30 80 00       	mov    0x803020,%eax
  800348:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80034e:	84 c0                	test   %al,%al
  800350:	74 0f                	je     800361 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800352:	a1 20 30 80 00       	mov    0x803020,%eax
  800357:	05 40 3c 01 00       	add    $0x13c40,%eax
  80035c:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800361:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800365:	7e 0a                	jle    800371 <libmain+0x72>
		binaryname = argv[0];
  800367:	8b 45 0c             	mov    0xc(%ebp),%eax
  80036a:	8b 00                	mov    (%eax),%eax
  80036c:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  800371:	83 ec 08             	sub    $0x8,%esp
  800374:	ff 75 0c             	pushl  0xc(%ebp)
  800377:	ff 75 08             	pushl  0x8(%ebp)
  80037a:	e8 b9 fc ff ff       	call   800038 <_main>
  80037f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800382:	e8 25 13 00 00       	call   8016ac <sys_disable_interrupt>
	cprintf("**************************************\n");
  800387:	83 ec 0c             	sub    $0xc,%esp
  80038a:	68 c8 1e 80 00       	push   $0x801ec8
  80038f:	e8 52 03 00 00       	call   8006e6 <cprintf>
  800394:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800397:	a1 20 30 80 00       	mov    0x803020,%eax
  80039c:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8003a2:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a7:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8003ad:	83 ec 04             	sub    $0x4,%esp
  8003b0:	52                   	push   %edx
  8003b1:	50                   	push   %eax
  8003b2:	68 f0 1e 80 00       	push   $0x801ef0
  8003b7:	e8 2a 03 00 00       	call   8006e6 <cprintf>
  8003bc:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8003bf:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c4:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8003ca:	a1 20 30 80 00       	mov    0x803020,%eax
  8003cf:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8003d5:	83 ec 04             	sub    $0x4,%esp
  8003d8:	52                   	push   %edx
  8003d9:	50                   	push   %eax
  8003da:	68 18 1f 80 00       	push   $0x801f18
  8003df:	e8 02 03 00 00       	call   8006e6 <cprintf>
  8003e4:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8003e7:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ec:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8003f2:	83 ec 08             	sub    $0x8,%esp
  8003f5:	50                   	push   %eax
  8003f6:	68 59 1f 80 00       	push   $0x801f59
  8003fb:	e8 e6 02 00 00       	call   8006e6 <cprintf>
  800400:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800403:	83 ec 0c             	sub    $0xc,%esp
  800406:	68 c8 1e 80 00       	push   $0x801ec8
  80040b:	e8 d6 02 00 00       	call   8006e6 <cprintf>
  800410:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800413:	e8 ae 12 00 00       	call   8016c6 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800418:	e8 19 00 00 00       	call   800436 <exit>
}
  80041d:	90                   	nop
  80041e:	c9                   	leave  
  80041f:	c3                   	ret    

00800420 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800420:	55                   	push   %ebp
  800421:	89 e5                	mov    %esp,%ebp
  800423:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800426:	83 ec 0c             	sub    $0xc,%esp
  800429:	6a 00                	push   $0x0
  80042b:	e8 ad 10 00 00       	call   8014dd <sys_env_destroy>
  800430:	83 c4 10             	add    $0x10,%esp
}
  800433:	90                   	nop
  800434:	c9                   	leave  
  800435:	c3                   	ret    

00800436 <exit>:

void
exit(void)
{
  800436:	55                   	push   %ebp
  800437:	89 e5                	mov    %esp,%ebp
  800439:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80043c:	e8 02 11 00 00       	call   801543 <sys_env_exit>
}
  800441:	90                   	nop
  800442:	c9                   	leave  
  800443:	c3                   	ret    

00800444 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800444:	55                   	push   %ebp
  800445:	89 e5                	mov    %esp,%ebp
  800447:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80044a:	8d 45 10             	lea    0x10(%ebp),%eax
  80044d:	83 c0 04             	add    $0x4,%eax
  800450:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800453:	a1 1c 31 80 00       	mov    0x80311c,%eax
  800458:	85 c0                	test   %eax,%eax
  80045a:	74 16                	je     800472 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80045c:	a1 1c 31 80 00       	mov    0x80311c,%eax
  800461:	83 ec 08             	sub    $0x8,%esp
  800464:	50                   	push   %eax
  800465:	68 70 1f 80 00       	push   $0x801f70
  80046a:	e8 77 02 00 00       	call   8006e6 <cprintf>
  80046f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800472:	a1 04 30 80 00       	mov    0x803004,%eax
  800477:	ff 75 0c             	pushl  0xc(%ebp)
  80047a:	ff 75 08             	pushl  0x8(%ebp)
  80047d:	50                   	push   %eax
  80047e:	68 75 1f 80 00       	push   $0x801f75
  800483:	e8 5e 02 00 00       	call   8006e6 <cprintf>
  800488:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80048b:	8b 45 10             	mov    0x10(%ebp),%eax
  80048e:	83 ec 08             	sub    $0x8,%esp
  800491:	ff 75 f4             	pushl  -0xc(%ebp)
  800494:	50                   	push   %eax
  800495:	e8 e1 01 00 00       	call   80067b <vcprintf>
  80049a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80049d:	83 ec 08             	sub    $0x8,%esp
  8004a0:	6a 00                	push   $0x0
  8004a2:	68 91 1f 80 00       	push   $0x801f91
  8004a7:	e8 cf 01 00 00       	call   80067b <vcprintf>
  8004ac:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8004af:	e8 82 ff ff ff       	call   800436 <exit>

	// should not return here
	while (1) ;
  8004b4:	eb fe                	jmp    8004b4 <_panic+0x70>

008004b6 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8004b6:	55                   	push   %ebp
  8004b7:	89 e5                	mov    %esp,%ebp
  8004b9:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8004bc:	a1 20 30 80 00       	mov    0x803020,%eax
  8004c1:	8b 50 74             	mov    0x74(%eax),%edx
  8004c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004c7:	39 c2                	cmp    %eax,%edx
  8004c9:	74 14                	je     8004df <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8004cb:	83 ec 04             	sub    $0x4,%esp
  8004ce:	68 94 1f 80 00       	push   $0x801f94
  8004d3:	6a 26                	push   $0x26
  8004d5:	68 e0 1f 80 00       	push   $0x801fe0
  8004da:	e8 65 ff ff ff       	call   800444 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8004df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8004e6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8004ed:	e9 b6 00 00 00       	jmp    8005a8 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8004f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004f5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ff:	01 d0                	add    %edx,%eax
  800501:	8b 00                	mov    (%eax),%eax
  800503:	85 c0                	test   %eax,%eax
  800505:	75 08                	jne    80050f <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800507:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80050a:	e9 96 00 00 00       	jmp    8005a5 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80050f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800516:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80051d:	eb 5d                	jmp    80057c <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80051f:	a1 20 30 80 00       	mov    0x803020,%eax
  800524:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80052a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80052d:	c1 e2 04             	shl    $0x4,%edx
  800530:	01 d0                	add    %edx,%eax
  800532:	8a 40 04             	mov    0x4(%eax),%al
  800535:	84 c0                	test   %al,%al
  800537:	75 40                	jne    800579 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800539:	a1 20 30 80 00       	mov    0x803020,%eax
  80053e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800544:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800547:	c1 e2 04             	shl    $0x4,%edx
  80054a:	01 d0                	add    %edx,%eax
  80054c:	8b 00                	mov    (%eax),%eax
  80054e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800551:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800554:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800559:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80055b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80055e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800565:	8b 45 08             	mov    0x8(%ebp),%eax
  800568:	01 c8                	add    %ecx,%eax
  80056a:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80056c:	39 c2                	cmp    %eax,%edx
  80056e:	75 09                	jne    800579 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800570:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800577:	eb 12                	jmp    80058b <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800579:	ff 45 e8             	incl   -0x18(%ebp)
  80057c:	a1 20 30 80 00       	mov    0x803020,%eax
  800581:	8b 50 74             	mov    0x74(%eax),%edx
  800584:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800587:	39 c2                	cmp    %eax,%edx
  800589:	77 94                	ja     80051f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80058b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80058f:	75 14                	jne    8005a5 <CheckWSWithoutLastIndex+0xef>
			panic(
  800591:	83 ec 04             	sub    $0x4,%esp
  800594:	68 ec 1f 80 00       	push   $0x801fec
  800599:	6a 3a                	push   $0x3a
  80059b:	68 e0 1f 80 00       	push   $0x801fe0
  8005a0:	e8 9f fe ff ff       	call   800444 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8005a5:	ff 45 f0             	incl   -0x10(%ebp)
  8005a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005ab:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005ae:	0f 8c 3e ff ff ff    	jl     8004f2 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8005b4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005bb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8005c2:	eb 20                	jmp    8005e4 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8005c4:	a1 20 30 80 00       	mov    0x803020,%eax
  8005c9:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8005cf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005d2:	c1 e2 04             	shl    $0x4,%edx
  8005d5:	01 d0                	add    %edx,%eax
  8005d7:	8a 40 04             	mov    0x4(%eax),%al
  8005da:	3c 01                	cmp    $0x1,%al
  8005dc:	75 03                	jne    8005e1 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8005de:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005e1:	ff 45 e0             	incl   -0x20(%ebp)
  8005e4:	a1 20 30 80 00       	mov    0x803020,%eax
  8005e9:	8b 50 74             	mov    0x74(%eax),%edx
  8005ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005ef:	39 c2                	cmp    %eax,%edx
  8005f1:	77 d1                	ja     8005c4 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8005f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005f6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8005f9:	74 14                	je     80060f <CheckWSWithoutLastIndex+0x159>
		panic(
  8005fb:	83 ec 04             	sub    $0x4,%esp
  8005fe:	68 40 20 80 00       	push   $0x802040
  800603:	6a 44                	push   $0x44
  800605:	68 e0 1f 80 00       	push   $0x801fe0
  80060a:	e8 35 fe ff ff       	call   800444 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80060f:	90                   	nop
  800610:	c9                   	leave  
  800611:	c3                   	ret    

00800612 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800612:	55                   	push   %ebp
  800613:	89 e5                	mov    %esp,%ebp
  800615:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800618:	8b 45 0c             	mov    0xc(%ebp),%eax
  80061b:	8b 00                	mov    (%eax),%eax
  80061d:	8d 48 01             	lea    0x1(%eax),%ecx
  800620:	8b 55 0c             	mov    0xc(%ebp),%edx
  800623:	89 0a                	mov    %ecx,(%edx)
  800625:	8b 55 08             	mov    0x8(%ebp),%edx
  800628:	88 d1                	mov    %dl,%cl
  80062a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80062d:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800631:	8b 45 0c             	mov    0xc(%ebp),%eax
  800634:	8b 00                	mov    (%eax),%eax
  800636:	3d ff 00 00 00       	cmp    $0xff,%eax
  80063b:	75 2c                	jne    800669 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80063d:	a0 24 30 80 00       	mov    0x803024,%al
  800642:	0f b6 c0             	movzbl %al,%eax
  800645:	8b 55 0c             	mov    0xc(%ebp),%edx
  800648:	8b 12                	mov    (%edx),%edx
  80064a:	89 d1                	mov    %edx,%ecx
  80064c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80064f:	83 c2 08             	add    $0x8,%edx
  800652:	83 ec 04             	sub    $0x4,%esp
  800655:	50                   	push   %eax
  800656:	51                   	push   %ecx
  800657:	52                   	push   %edx
  800658:	e8 3e 0e 00 00       	call   80149b <sys_cputs>
  80065d:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800660:	8b 45 0c             	mov    0xc(%ebp),%eax
  800663:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800669:	8b 45 0c             	mov    0xc(%ebp),%eax
  80066c:	8b 40 04             	mov    0x4(%eax),%eax
  80066f:	8d 50 01             	lea    0x1(%eax),%edx
  800672:	8b 45 0c             	mov    0xc(%ebp),%eax
  800675:	89 50 04             	mov    %edx,0x4(%eax)
}
  800678:	90                   	nop
  800679:	c9                   	leave  
  80067a:	c3                   	ret    

0080067b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80067b:	55                   	push   %ebp
  80067c:	89 e5                	mov    %esp,%ebp
  80067e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800684:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80068b:	00 00 00 
	b.cnt = 0;
  80068e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800695:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800698:	ff 75 0c             	pushl  0xc(%ebp)
  80069b:	ff 75 08             	pushl  0x8(%ebp)
  80069e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006a4:	50                   	push   %eax
  8006a5:	68 12 06 80 00       	push   $0x800612
  8006aa:	e8 11 02 00 00       	call   8008c0 <vprintfmt>
  8006af:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8006b2:	a0 24 30 80 00       	mov    0x803024,%al
  8006b7:	0f b6 c0             	movzbl %al,%eax
  8006ba:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8006c0:	83 ec 04             	sub    $0x4,%esp
  8006c3:	50                   	push   %eax
  8006c4:	52                   	push   %edx
  8006c5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006cb:	83 c0 08             	add    $0x8,%eax
  8006ce:	50                   	push   %eax
  8006cf:	e8 c7 0d 00 00       	call   80149b <sys_cputs>
  8006d4:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8006d7:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8006de:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8006e4:	c9                   	leave  
  8006e5:	c3                   	ret    

008006e6 <cprintf>:

int cprintf(const char *fmt, ...) {
  8006e6:	55                   	push   %ebp
  8006e7:	89 e5                	mov    %esp,%ebp
  8006e9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8006ec:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8006f3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fc:	83 ec 08             	sub    $0x8,%esp
  8006ff:	ff 75 f4             	pushl  -0xc(%ebp)
  800702:	50                   	push   %eax
  800703:	e8 73 ff ff ff       	call   80067b <vcprintf>
  800708:	83 c4 10             	add    $0x10,%esp
  80070b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80070e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800711:	c9                   	leave  
  800712:	c3                   	ret    

00800713 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800713:	55                   	push   %ebp
  800714:	89 e5                	mov    %esp,%ebp
  800716:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800719:	e8 8e 0f 00 00       	call   8016ac <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80071e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800721:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800724:	8b 45 08             	mov    0x8(%ebp),%eax
  800727:	83 ec 08             	sub    $0x8,%esp
  80072a:	ff 75 f4             	pushl  -0xc(%ebp)
  80072d:	50                   	push   %eax
  80072e:	e8 48 ff ff ff       	call   80067b <vcprintf>
  800733:	83 c4 10             	add    $0x10,%esp
  800736:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800739:	e8 88 0f 00 00       	call   8016c6 <sys_enable_interrupt>
	return cnt;
  80073e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800741:	c9                   	leave  
  800742:	c3                   	ret    

00800743 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800743:	55                   	push   %ebp
  800744:	89 e5                	mov    %esp,%ebp
  800746:	53                   	push   %ebx
  800747:	83 ec 14             	sub    $0x14,%esp
  80074a:	8b 45 10             	mov    0x10(%ebp),%eax
  80074d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800750:	8b 45 14             	mov    0x14(%ebp),%eax
  800753:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800756:	8b 45 18             	mov    0x18(%ebp),%eax
  800759:	ba 00 00 00 00       	mov    $0x0,%edx
  80075e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800761:	77 55                	ja     8007b8 <printnum+0x75>
  800763:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800766:	72 05                	jb     80076d <printnum+0x2a>
  800768:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80076b:	77 4b                	ja     8007b8 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80076d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800770:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800773:	8b 45 18             	mov    0x18(%ebp),%eax
  800776:	ba 00 00 00 00       	mov    $0x0,%edx
  80077b:	52                   	push   %edx
  80077c:	50                   	push   %eax
  80077d:	ff 75 f4             	pushl  -0xc(%ebp)
  800780:	ff 75 f0             	pushl  -0x10(%ebp)
  800783:	e8 48 13 00 00       	call   801ad0 <__udivdi3>
  800788:	83 c4 10             	add    $0x10,%esp
  80078b:	83 ec 04             	sub    $0x4,%esp
  80078e:	ff 75 20             	pushl  0x20(%ebp)
  800791:	53                   	push   %ebx
  800792:	ff 75 18             	pushl  0x18(%ebp)
  800795:	52                   	push   %edx
  800796:	50                   	push   %eax
  800797:	ff 75 0c             	pushl  0xc(%ebp)
  80079a:	ff 75 08             	pushl  0x8(%ebp)
  80079d:	e8 a1 ff ff ff       	call   800743 <printnum>
  8007a2:	83 c4 20             	add    $0x20,%esp
  8007a5:	eb 1a                	jmp    8007c1 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8007a7:	83 ec 08             	sub    $0x8,%esp
  8007aa:	ff 75 0c             	pushl  0xc(%ebp)
  8007ad:	ff 75 20             	pushl  0x20(%ebp)
  8007b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b3:	ff d0                	call   *%eax
  8007b5:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8007b8:	ff 4d 1c             	decl   0x1c(%ebp)
  8007bb:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8007bf:	7f e6                	jg     8007a7 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8007c1:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8007c4:	bb 00 00 00 00       	mov    $0x0,%ebx
  8007c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007cf:	53                   	push   %ebx
  8007d0:	51                   	push   %ecx
  8007d1:	52                   	push   %edx
  8007d2:	50                   	push   %eax
  8007d3:	e8 08 14 00 00       	call   801be0 <__umoddi3>
  8007d8:	83 c4 10             	add    $0x10,%esp
  8007db:	05 b4 22 80 00       	add    $0x8022b4,%eax
  8007e0:	8a 00                	mov    (%eax),%al
  8007e2:	0f be c0             	movsbl %al,%eax
  8007e5:	83 ec 08             	sub    $0x8,%esp
  8007e8:	ff 75 0c             	pushl  0xc(%ebp)
  8007eb:	50                   	push   %eax
  8007ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ef:	ff d0                	call   *%eax
  8007f1:	83 c4 10             	add    $0x10,%esp
}
  8007f4:	90                   	nop
  8007f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8007f8:	c9                   	leave  
  8007f9:	c3                   	ret    

008007fa <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8007fa:	55                   	push   %ebp
  8007fb:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007fd:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800801:	7e 1c                	jle    80081f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800803:	8b 45 08             	mov    0x8(%ebp),%eax
  800806:	8b 00                	mov    (%eax),%eax
  800808:	8d 50 08             	lea    0x8(%eax),%edx
  80080b:	8b 45 08             	mov    0x8(%ebp),%eax
  80080e:	89 10                	mov    %edx,(%eax)
  800810:	8b 45 08             	mov    0x8(%ebp),%eax
  800813:	8b 00                	mov    (%eax),%eax
  800815:	83 e8 08             	sub    $0x8,%eax
  800818:	8b 50 04             	mov    0x4(%eax),%edx
  80081b:	8b 00                	mov    (%eax),%eax
  80081d:	eb 40                	jmp    80085f <getuint+0x65>
	else if (lflag)
  80081f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800823:	74 1e                	je     800843 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800825:	8b 45 08             	mov    0x8(%ebp),%eax
  800828:	8b 00                	mov    (%eax),%eax
  80082a:	8d 50 04             	lea    0x4(%eax),%edx
  80082d:	8b 45 08             	mov    0x8(%ebp),%eax
  800830:	89 10                	mov    %edx,(%eax)
  800832:	8b 45 08             	mov    0x8(%ebp),%eax
  800835:	8b 00                	mov    (%eax),%eax
  800837:	83 e8 04             	sub    $0x4,%eax
  80083a:	8b 00                	mov    (%eax),%eax
  80083c:	ba 00 00 00 00       	mov    $0x0,%edx
  800841:	eb 1c                	jmp    80085f <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800843:	8b 45 08             	mov    0x8(%ebp),%eax
  800846:	8b 00                	mov    (%eax),%eax
  800848:	8d 50 04             	lea    0x4(%eax),%edx
  80084b:	8b 45 08             	mov    0x8(%ebp),%eax
  80084e:	89 10                	mov    %edx,(%eax)
  800850:	8b 45 08             	mov    0x8(%ebp),%eax
  800853:	8b 00                	mov    (%eax),%eax
  800855:	83 e8 04             	sub    $0x4,%eax
  800858:	8b 00                	mov    (%eax),%eax
  80085a:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80085f:	5d                   	pop    %ebp
  800860:	c3                   	ret    

00800861 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800861:	55                   	push   %ebp
  800862:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800864:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800868:	7e 1c                	jle    800886 <getint+0x25>
		return va_arg(*ap, long long);
  80086a:	8b 45 08             	mov    0x8(%ebp),%eax
  80086d:	8b 00                	mov    (%eax),%eax
  80086f:	8d 50 08             	lea    0x8(%eax),%edx
  800872:	8b 45 08             	mov    0x8(%ebp),%eax
  800875:	89 10                	mov    %edx,(%eax)
  800877:	8b 45 08             	mov    0x8(%ebp),%eax
  80087a:	8b 00                	mov    (%eax),%eax
  80087c:	83 e8 08             	sub    $0x8,%eax
  80087f:	8b 50 04             	mov    0x4(%eax),%edx
  800882:	8b 00                	mov    (%eax),%eax
  800884:	eb 38                	jmp    8008be <getint+0x5d>
	else if (lflag)
  800886:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80088a:	74 1a                	je     8008a6 <getint+0x45>
		return va_arg(*ap, long);
  80088c:	8b 45 08             	mov    0x8(%ebp),%eax
  80088f:	8b 00                	mov    (%eax),%eax
  800891:	8d 50 04             	lea    0x4(%eax),%edx
  800894:	8b 45 08             	mov    0x8(%ebp),%eax
  800897:	89 10                	mov    %edx,(%eax)
  800899:	8b 45 08             	mov    0x8(%ebp),%eax
  80089c:	8b 00                	mov    (%eax),%eax
  80089e:	83 e8 04             	sub    $0x4,%eax
  8008a1:	8b 00                	mov    (%eax),%eax
  8008a3:	99                   	cltd   
  8008a4:	eb 18                	jmp    8008be <getint+0x5d>
	else
		return va_arg(*ap, int);
  8008a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a9:	8b 00                	mov    (%eax),%eax
  8008ab:	8d 50 04             	lea    0x4(%eax),%edx
  8008ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b1:	89 10                	mov    %edx,(%eax)
  8008b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b6:	8b 00                	mov    (%eax),%eax
  8008b8:	83 e8 04             	sub    $0x4,%eax
  8008bb:	8b 00                	mov    (%eax),%eax
  8008bd:	99                   	cltd   
}
  8008be:	5d                   	pop    %ebp
  8008bf:	c3                   	ret    

008008c0 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8008c0:	55                   	push   %ebp
  8008c1:	89 e5                	mov    %esp,%ebp
  8008c3:	56                   	push   %esi
  8008c4:	53                   	push   %ebx
  8008c5:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008c8:	eb 17                	jmp    8008e1 <vprintfmt+0x21>
			if (ch == '\0')
  8008ca:	85 db                	test   %ebx,%ebx
  8008cc:	0f 84 af 03 00 00    	je     800c81 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8008d2:	83 ec 08             	sub    $0x8,%esp
  8008d5:	ff 75 0c             	pushl  0xc(%ebp)
  8008d8:	53                   	push   %ebx
  8008d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008dc:	ff d0                	call   *%eax
  8008de:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8008e4:	8d 50 01             	lea    0x1(%eax),%edx
  8008e7:	89 55 10             	mov    %edx,0x10(%ebp)
  8008ea:	8a 00                	mov    (%eax),%al
  8008ec:	0f b6 d8             	movzbl %al,%ebx
  8008ef:	83 fb 25             	cmp    $0x25,%ebx
  8008f2:	75 d6                	jne    8008ca <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8008f4:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8008f8:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8008ff:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800906:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80090d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800914:	8b 45 10             	mov    0x10(%ebp),%eax
  800917:	8d 50 01             	lea    0x1(%eax),%edx
  80091a:	89 55 10             	mov    %edx,0x10(%ebp)
  80091d:	8a 00                	mov    (%eax),%al
  80091f:	0f b6 d8             	movzbl %al,%ebx
  800922:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800925:	83 f8 55             	cmp    $0x55,%eax
  800928:	0f 87 2b 03 00 00    	ja     800c59 <vprintfmt+0x399>
  80092e:	8b 04 85 d8 22 80 00 	mov    0x8022d8(,%eax,4),%eax
  800935:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800937:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80093b:	eb d7                	jmp    800914 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80093d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800941:	eb d1                	jmp    800914 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800943:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80094a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80094d:	89 d0                	mov    %edx,%eax
  80094f:	c1 e0 02             	shl    $0x2,%eax
  800952:	01 d0                	add    %edx,%eax
  800954:	01 c0                	add    %eax,%eax
  800956:	01 d8                	add    %ebx,%eax
  800958:	83 e8 30             	sub    $0x30,%eax
  80095b:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80095e:	8b 45 10             	mov    0x10(%ebp),%eax
  800961:	8a 00                	mov    (%eax),%al
  800963:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800966:	83 fb 2f             	cmp    $0x2f,%ebx
  800969:	7e 3e                	jle    8009a9 <vprintfmt+0xe9>
  80096b:	83 fb 39             	cmp    $0x39,%ebx
  80096e:	7f 39                	jg     8009a9 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800970:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800973:	eb d5                	jmp    80094a <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800975:	8b 45 14             	mov    0x14(%ebp),%eax
  800978:	83 c0 04             	add    $0x4,%eax
  80097b:	89 45 14             	mov    %eax,0x14(%ebp)
  80097e:	8b 45 14             	mov    0x14(%ebp),%eax
  800981:	83 e8 04             	sub    $0x4,%eax
  800984:	8b 00                	mov    (%eax),%eax
  800986:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800989:	eb 1f                	jmp    8009aa <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80098b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80098f:	79 83                	jns    800914 <vprintfmt+0x54>
				width = 0;
  800991:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800998:	e9 77 ff ff ff       	jmp    800914 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80099d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8009a4:	e9 6b ff ff ff       	jmp    800914 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8009a9:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8009aa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009ae:	0f 89 60 ff ff ff    	jns    800914 <vprintfmt+0x54>
				width = precision, precision = -1;
  8009b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009b7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8009ba:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8009c1:	e9 4e ff ff ff       	jmp    800914 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8009c6:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8009c9:	e9 46 ff ff ff       	jmp    800914 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8009ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d1:	83 c0 04             	add    $0x4,%eax
  8009d4:	89 45 14             	mov    %eax,0x14(%ebp)
  8009d7:	8b 45 14             	mov    0x14(%ebp),%eax
  8009da:	83 e8 04             	sub    $0x4,%eax
  8009dd:	8b 00                	mov    (%eax),%eax
  8009df:	83 ec 08             	sub    $0x8,%esp
  8009e2:	ff 75 0c             	pushl  0xc(%ebp)
  8009e5:	50                   	push   %eax
  8009e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e9:	ff d0                	call   *%eax
  8009eb:	83 c4 10             	add    $0x10,%esp
			break;
  8009ee:	e9 89 02 00 00       	jmp    800c7c <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8009f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f6:	83 c0 04             	add    $0x4,%eax
  8009f9:	89 45 14             	mov    %eax,0x14(%ebp)
  8009fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ff:	83 e8 04             	sub    $0x4,%eax
  800a02:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a04:	85 db                	test   %ebx,%ebx
  800a06:	79 02                	jns    800a0a <vprintfmt+0x14a>
				err = -err;
  800a08:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a0a:	83 fb 64             	cmp    $0x64,%ebx
  800a0d:	7f 0b                	jg     800a1a <vprintfmt+0x15a>
  800a0f:	8b 34 9d 20 21 80 00 	mov    0x802120(,%ebx,4),%esi
  800a16:	85 f6                	test   %esi,%esi
  800a18:	75 19                	jne    800a33 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a1a:	53                   	push   %ebx
  800a1b:	68 c5 22 80 00       	push   $0x8022c5
  800a20:	ff 75 0c             	pushl  0xc(%ebp)
  800a23:	ff 75 08             	pushl  0x8(%ebp)
  800a26:	e8 5e 02 00 00       	call   800c89 <printfmt>
  800a2b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a2e:	e9 49 02 00 00       	jmp    800c7c <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a33:	56                   	push   %esi
  800a34:	68 ce 22 80 00       	push   $0x8022ce
  800a39:	ff 75 0c             	pushl  0xc(%ebp)
  800a3c:	ff 75 08             	pushl  0x8(%ebp)
  800a3f:	e8 45 02 00 00       	call   800c89 <printfmt>
  800a44:	83 c4 10             	add    $0x10,%esp
			break;
  800a47:	e9 30 02 00 00       	jmp    800c7c <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a4c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a4f:	83 c0 04             	add    $0x4,%eax
  800a52:	89 45 14             	mov    %eax,0x14(%ebp)
  800a55:	8b 45 14             	mov    0x14(%ebp),%eax
  800a58:	83 e8 04             	sub    $0x4,%eax
  800a5b:	8b 30                	mov    (%eax),%esi
  800a5d:	85 f6                	test   %esi,%esi
  800a5f:	75 05                	jne    800a66 <vprintfmt+0x1a6>
				p = "(null)";
  800a61:	be d1 22 80 00       	mov    $0x8022d1,%esi
			if (width > 0 && padc != '-')
  800a66:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a6a:	7e 6d                	jle    800ad9 <vprintfmt+0x219>
  800a6c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a70:	74 67                	je     800ad9 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a72:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a75:	83 ec 08             	sub    $0x8,%esp
  800a78:	50                   	push   %eax
  800a79:	56                   	push   %esi
  800a7a:	e8 0c 03 00 00       	call   800d8b <strnlen>
  800a7f:	83 c4 10             	add    $0x10,%esp
  800a82:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a85:	eb 16                	jmp    800a9d <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a87:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a8b:	83 ec 08             	sub    $0x8,%esp
  800a8e:	ff 75 0c             	pushl  0xc(%ebp)
  800a91:	50                   	push   %eax
  800a92:	8b 45 08             	mov    0x8(%ebp),%eax
  800a95:	ff d0                	call   *%eax
  800a97:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a9a:	ff 4d e4             	decl   -0x1c(%ebp)
  800a9d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aa1:	7f e4                	jg     800a87 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800aa3:	eb 34                	jmp    800ad9 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800aa5:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800aa9:	74 1c                	je     800ac7 <vprintfmt+0x207>
  800aab:	83 fb 1f             	cmp    $0x1f,%ebx
  800aae:	7e 05                	jle    800ab5 <vprintfmt+0x1f5>
  800ab0:	83 fb 7e             	cmp    $0x7e,%ebx
  800ab3:	7e 12                	jle    800ac7 <vprintfmt+0x207>
					putch('?', putdat);
  800ab5:	83 ec 08             	sub    $0x8,%esp
  800ab8:	ff 75 0c             	pushl  0xc(%ebp)
  800abb:	6a 3f                	push   $0x3f
  800abd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac0:	ff d0                	call   *%eax
  800ac2:	83 c4 10             	add    $0x10,%esp
  800ac5:	eb 0f                	jmp    800ad6 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800ac7:	83 ec 08             	sub    $0x8,%esp
  800aca:	ff 75 0c             	pushl  0xc(%ebp)
  800acd:	53                   	push   %ebx
  800ace:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad1:	ff d0                	call   *%eax
  800ad3:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ad6:	ff 4d e4             	decl   -0x1c(%ebp)
  800ad9:	89 f0                	mov    %esi,%eax
  800adb:	8d 70 01             	lea    0x1(%eax),%esi
  800ade:	8a 00                	mov    (%eax),%al
  800ae0:	0f be d8             	movsbl %al,%ebx
  800ae3:	85 db                	test   %ebx,%ebx
  800ae5:	74 24                	je     800b0b <vprintfmt+0x24b>
  800ae7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800aeb:	78 b8                	js     800aa5 <vprintfmt+0x1e5>
  800aed:	ff 4d e0             	decl   -0x20(%ebp)
  800af0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800af4:	79 af                	jns    800aa5 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800af6:	eb 13                	jmp    800b0b <vprintfmt+0x24b>
				putch(' ', putdat);
  800af8:	83 ec 08             	sub    $0x8,%esp
  800afb:	ff 75 0c             	pushl  0xc(%ebp)
  800afe:	6a 20                	push   $0x20
  800b00:	8b 45 08             	mov    0x8(%ebp),%eax
  800b03:	ff d0                	call   *%eax
  800b05:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b08:	ff 4d e4             	decl   -0x1c(%ebp)
  800b0b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b0f:	7f e7                	jg     800af8 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b11:	e9 66 01 00 00       	jmp    800c7c <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b16:	83 ec 08             	sub    $0x8,%esp
  800b19:	ff 75 e8             	pushl  -0x18(%ebp)
  800b1c:	8d 45 14             	lea    0x14(%ebp),%eax
  800b1f:	50                   	push   %eax
  800b20:	e8 3c fd ff ff       	call   800861 <getint>
  800b25:	83 c4 10             	add    $0x10,%esp
  800b28:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b2b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b31:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b34:	85 d2                	test   %edx,%edx
  800b36:	79 23                	jns    800b5b <vprintfmt+0x29b>
				putch('-', putdat);
  800b38:	83 ec 08             	sub    $0x8,%esp
  800b3b:	ff 75 0c             	pushl  0xc(%ebp)
  800b3e:	6a 2d                	push   $0x2d
  800b40:	8b 45 08             	mov    0x8(%ebp),%eax
  800b43:	ff d0                	call   *%eax
  800b45:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b48:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b4b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b4e:	f7 d8                	neg    %eax
  800b50:	83 d2 00             	adc    $0x0,%edx
  800b53:	f7 da                	neg    %edx
  800b55:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b58:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b5b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b62:	e9 bc 00 00 00       	jmp    800c23 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b67:	83 ec 08             	sub    $0x8,%esp
  800b6a:	ff 75 e8             	pushl  -0x18(%ebp)
  800b6d:	8d 45 14             	lea    0x14(%ebp),%eax
  800b70:	50                   	push   %eax
  800b71:	e8 84 fc ff ff       	call   8007fa <getuint>
  800b76:	83 c4 10             	add    $0x10,%esp
  800b79:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b7c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b7f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b86:	e9 98 00 00 00       	jmp    800c23 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b8b:	83 ec 08             	sub    $0x8,%esp
  800b8e:	ff 75 0c             	pushl  0xc(%ebp)
  800b91:	6a 58                	push   $0x58
  800b93:	8b 45 08             	mov    0x8(%ebp),%eax
  800b96:	ff d0                	call   *%eax
  800b98:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b9b:	83 ec 08             	sub    $0x8,%esp
  800b9e:	ff 75 0c             	pushl  0xc(%ebp)
  800ba1:	6a 58                	push   $0x58
  800ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba6:	ff d0                	call   *%eax
  800ba8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bab:	83 ec 08             	sub    $0x8,%esp
  800bae:	ff 75 0c             	pushl  0xc(%ebp)
  800bb1:	6a 58                	push   $0x58
  800bb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb6:	ff d0                	call   *%eax
  800bb8:	83 c4 10             	add    $0x10,%esp
			break;
  800bbb:	e9 bc 00 00 00       	jmp    800c7c <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800bc0:	83 ec 08             	sub    $0x8,%esp
  800bc3:	ff 75 0c             	pushl  0xc(%ebp)
  800bc6:	6a 30                	push   $0x30
  800bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcb:	ff d0                	call   *%eax
  800bcd:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800bd0:	83 ec 08             	sub    $0x8,%esp
  800bd3:	ff 75 0c             	pushl  0xc(%ebp)
  800bd6:	6a 78                	push   $0x78
  800bd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdb:	ff d0                	call   *%eax
  800bdd:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800be0:	8b 45 14             	mov    0x14(%ebp),%eax
  800be3:	83 c0 04             	add    $0x4,%eax
  800be6:	89 45 14             	mov    %eax,0x14(%ebp)
  800be9:	8b 45 14             	mov    0x14(%ebp),%eax
  800bec:	83 e8 04             	sub    $0x4,%eax
  800bef:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800bf1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bf4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800bfb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c02:	eb 1f                	jmp    800c23 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c04:	83 ec 08             	sub    $0x8,%esp
  800c07:	ff 75 e8             	pushl  -0x18(%ebp)
  800c0a:	8d 45 14             	lea    0x14(%ebp),%eax
  800c0d:	50                   	push   %eax
  800c0e:	e8 e7 fb ff ff       	call   8007fa <getuint>
  800c13:	83 c4 10             	add    $0x10,%esp
  800c16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c19:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c1c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c23:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c27:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c2a:	83 ec 04             	sub    $0x4,%esp
  800c2d:	52                   	push   %edx
  800c2e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c31:	50                   	push   %eax
  800c32:	ff 75 f4             	pushl  -0xc(%ebp)
  800c35:	ff 75 f0             	pushl  -0x10(%ebp)
  800c38:	ff 75 0c             	pushl  0xc(%ebp)
  800c3b:	ff 75 08             	pushl  0x8(%ebp)
  800c3e:	e8 00 fb ff ff       	call   800743 <printnum>
  800c43:	83 c4 20             	add    $0x20,%esp
			break;
  800c46:	eb 34                	jmp    800c7c <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c48:	83 ec 08             	sub    $0x8,%esp
  800c4b:	ff 75 0c             	pushl  0xc(%ebp)
  800c4e:	53                   	push   %ebx
  800c4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c52:	ff d0                	call   *%eax
  800c54:	83 c4 10             	add    $0x10,%esp
			break;
  800c57:	eb 23                	jmp    800c7c <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c59:	83 ec 08             	sub    $0x8,%esp
  800c5c:	ff 75 0c             	pushl  0xc(%ebp)
  800c5f:	6a 25                	push   $0x25
  800c61:	8b 45 08             	mov    0x8(%ebp),%eax
  800c64:	ff d0                	call   *%eax
  800c66:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c69:	ff 4d 10             	decl   0x10(%ebp)
  800c6c:	eb 03                	jmp    800c71 <vprintfmt+0x3b1>
  800c6e:	ff 4d 10             	decl   0x10(%ebp)
  800c71:	8b 45 10             	mov    0x10(%ebp),%eax
  800c74:	48                   	dec    %eax
  800c75:	8a 00                	mov    (%eax),%al
  800c77:	3c 25                	cmp    $0x25,%al
  800c79:	75 f3                	jne    800c6e <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c7b:	90                   	nop
		}
	}
  800c7c:	e9 47 fc ff ff       	jmp    8008c8 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c81:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c82:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c85:	5b                   	pop    %ebx
  800c86:	5e                   	pop    %esi
  800c87:	5d                   	pop    %ebp
  800c88:	c3                   	ret    

00800c89 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c89:	55                   	push   %ebp
  800c8a:	89 e5                	mov    %esp,%ebp
  800c8c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c8f:	8d 45 10             	lea    0x10(%ebp),%eax
  800c92:	83 c0 04             	add    $0x4,%eax
  800c95:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c98:	8b 45 10             	mov    0x10(%ebp),%eax
  800c9b:	ff 75 f4             	pushl  -0xc(%ebp)
  800c9e:	50                   	push   %eax
  800c9f:	ff 75 0c             	pushl  0xc(%ebp)
  800ca2:	ff 75 08             	pushl  0x8(%ebp)
  800ca5:	e8 16 fc ff ff       	call   8008c0 <vprintfmt>
  800caa:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800cad:	90                   	nop
  800cae:	c9                   	leave  
  800caf:	c3                   	ret    

00800cb0 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800cb0:	55                   	push   %ebp
  800cb1:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800cb3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb6:	8b 40 08             	mov    0x8(%eax),%eax
  800cb9:	8d 50 01             	lea    0x1(%eax),%edx
  800cbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cbf:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800cc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc5:	8b 10                	mov    (%eax),%edx
  800cc7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cca:	8b 40 04             	mov    0x4(%eax),%eax
  800ccd:	39 c2                	cmp    %eax,%edx
  800ccf:	73 12                	jae    800ce3 <sprintputch+0x33>
		*b->buf++ = ch;
  800cd1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd4:	8b 00                	mov    (%eax),%eax
  800cd6:	8d 48 01             	lea    0x1(%eax),%ecx
  800cd9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cdc:	89 0a                	mov    %ecx,(%edx)
  800cde:	8b 55 08             	mov    0x8(%ebp),%edx
  800ce1:	88 10                	mov    %dl,(%eax)
}
  800ce3:	90                   	nop
  800ce4:	5d                   	pop    %ebp
  800ce5:	c3                   	ret    

00800ce6 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800ce6:	55                   	push   %ebp
  800ce7:	89 e5                	mov    %esp,%ebp
  800ce9:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800cec:	8b 45 08             	mov    0x8(%ebp),%eax
  800cef:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800cf2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cf8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfb:	01 d0                	add    %edx,%eax
  800cfd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d00:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d07:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d0b:	74 06                	je     800d13 <vsnprintf+0x2d>
  800d0d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d11:	7f 07                	jg     800d1a <vsnprintf+0x34>
		return -E_INVAL;
  800d13:	b8 03 00 00 00       	mov    $0x3,%eax
  800d18:	eb 20                	jmp    800d3a <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d1a:	ff 75 14             	pushl  0x14(%ebp)
  800d1d:	ff 75 10             	pushl  0x10(%ebp)
  800d20:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d23:	50                   	push   %eax
  800d24:	68 b0 0c 80 00       	push   $0x800cb0
  800d29:	e8 92 fb ff ff       	call   8008c0 <vprintfmt>
  800d2e:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d31:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d34:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d37:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d3a:	c9                   	leave  
  800d3b:	c3                   	ret    

00800d3c <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d3c:	55                   	push   %ebp
  800d3d:	89 e5                	mov    %esp,%ebp
  800d3f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d42:	8d 45 10             	lea    0x10(%ebp),%eax
  800d45:	83 c0 04             	add    $0x4,%eax
  800d48:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d4b:	8b 45 10             	mov    0x10(%ebp),%eax
  800d4e:	ff 75 f4             	pushl  -0xc(%ebp)
  800d51:	50                   	push   %eax
  800d52:	ff 75 0c             	pushl  0xc(%ebp)
  800d55:	ff 75 08             	pushl  0x8(%ebp)
  800d58:	e8 89 ff ff ff       	call   800ce6 <vsnprintf>
  800d5d:	83 c4 10             	add    $0x10,%esp
  800d60:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d63:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d66:	c9                   	leave  
  800d67:	c3                   	ret    

00800d68 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d68:	55                   	push   %ebp
  800d69:	89 e5                	mov    %esp,%ebp
  800d6b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d6e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d75:	eb 06                	jmp    800d7d <strlen+0x15>
		n++;
  800d77:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d7a:	ff 45 08             	incl   0x8(%ebp)
  800d7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d80:	8a 00                	mov    (%eax),%al
  800d82:	84 c0                	test   %al,%al
  800d84:	75 f1                	jne    800d77 <strlen+0xf>
		n++;
	return n;
  800d86:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d89:	c9                   	leave  
  800d8a:	c3                   	ret    

00800d8b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d8b:	55                   	push   %ebp
  800d8c:	89 e5                	mov    %esp,%ebp
  800d8e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d91:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d98:	eb 09                	jmp    800da3 <strnlen+0x18>
		n++;
  800d9a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d9d:	ff 45 08             	incl   0x8(%ebp)
  800da0:	ff 4d 0c             	decl   0xc(%ebp)
  800da3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800da7:	74 09                	je     800db2 <strnlen+0x27>
  800da9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dac:	8a 00                	mov    (%eax),%al
  800dae:	84 c0                	test   %al,%al
  800db0:	75 e8                	jne    800d9a <strnlen+0xf>
		n++;
	return n;
  800db2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800db5:	c9                   	leave  
  800db6:	c3                   	ret    

00800db7 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800db7:	55                   	push   %ebp
  800db8:	89 e5                	mov    %esp,%ebp
  800dba:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800dbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800dc3:	90                   	nop
  800dc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc7:	8d 50 01             	lea    0x1(%eax),%edx
  800dca:	89 55 08             	mov    %edx,0x8(%ebp)
  800dcd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dd0:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dd3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800dd6:	8a 12                	mov    (%edx),%dl
  800dd8:	88 10                	mov    %dl,(%eax)
  800dda:	8a 00                	mov    (%eax),%al
  800ddc:	84 c0                	test   %al,%al
  800dde:	75 e4                	jne    800dc4 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800de0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800de3:	c9                   	leave  
  800de4:	c3                   	ret    

00800de5 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800de5:	55                   	push   %ebp
  800de6:	89 e5                	mov    %esp,%ebp
  800de8:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800deb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dee:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800df1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800df8:	eb 1f                	jmp    800e19 <strncpy+0x34>
		*dst++ = *src;
  800dfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfd:	8d 50 01             	lea    0x1(%eax),%edx
  800e00:	89 55 08             	mov    %edx,0x8(%ebp)
  800e03:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e06:	8a 12                	mov    (%edx),%dl
  800e08:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0d:	8a 00                	mov    (%eax),%al
  800e0f:	84 c0                	test   %al,%al
  800e11:	74 03                	je     800e16 <strncpy+0x31>
			src++;
  800e13:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e16:	ff 45 fc             	incl   -0x4(%ebp)
  800e19:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e1c:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e1f:	72 d9                	jb     800dfa <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e21:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e24:	c9                   	leave  
  800e25:	c3                   	ret    

00800e26 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e26:	55                   	push   %ebp
  800e27:	89 e5                	mov    %esp,%ebp
  800e29:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e32:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e36:	74 30                	je     800e68 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e38:	eb 16                	jmp    800e50 <strlcpy+0x2a>
			*dst++ = *src++;
  800e3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3d:	8d 50 01             	lea    0x1(%eax),%edx
  800e40:	89 55 08             	mov    %edx,0x8(%ebp)
  800e43:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e46:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e49:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e4c:	8a 12                	mov    (%edx),%dl
  800e4e:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e50:	ff 4d 10             	decl   0x10(%ebp)
  800e53:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e57:	74 09                	je     800e62 <strlcpy+0x3c>
  800e59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5c:	8a 00                	mov    (%eax),%al
  800e5e:	84 c0                	test   %al,%al
  800e60:	75 d8                	jne    800e3a <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e62:	8b 45 08             	mov    0x8(%ebp),%eax
  800e65:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e68:	8b 55 08             	mov    0x8(%ebp),%edx
  800e6b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e6e:	29 c2                	sub    %eax,%edx
  800e70:	89 d0                	mov    %edx,%eax
}
  800e72:	c9                   	leave  
  800e73:	c3                   	ret    

00800e74 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e74:	55                   	push   %ebp
  800e75:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e77:	eb 06                	jmp    800e7f <strcmp+0xb>
		p++, q++;
  800e79:	ff 45 08             	incl   0x8(%ebp)
  800e7c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e82:	8a 00                	mov    (%eax),%al
  800e84:	84 c0                	test   %al,%al
  800e86:	74 0e                	je     800e96 <strcmp+0x22>
  800e88:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8b:	8a 10                	mov    (%eax),%dl
  800e8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e90:	8a 00                	mov    (%eax),%al
  800e92:	38 c2                	cmp    %al,%dl
  800e94:	74 e3                	je     800e79 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e96:	8b 45 08             	mov    0x8(%ebp),%eax
  800e99:	8a 00                	mov    (%eax),%al
  800e9b:	0f b6 d0             	movzbl %al,%edx
  800e9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea1:	8a 00                	mov    (%eax),%al
  800ea3:	0f b6 c0             	movzbl %al,%eax
  800ea6:	29 c2                	sub    %eax,%edx
  800ea8:	89 d0                	mov    %edx,%eax
}
  800eaa:	5d                   	pop    %ebp
  800eab:	c3                   	ret    

00800eac <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800eac:	55                   	push   %ebp
  800ead:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800eaf:	eb 09                	jmp    800eba <strncmp+0xe>
		n--, p++, q++;
  800eb1:	ff 4d 10             	decl   0x10(%ebp)
  800eb4:	ff 45 08             	incl   0x8(%ebp)
  800eb7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800eba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ebe:	74 17                	je     800ed7 <strncmp+0x2b>
  800ec0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec3:	8a 00                	mov    (%eax),%al
  800ec5:	84 c0                	test   %al,%al
  800ec7:	74 0e                	je     800ed7 <strncmp+0x2b>
  800ec9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecc:	8a 10                	mov    (%eax),%dl
  800ece:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed1:	8a 00                	mov    (%eax),%al
  800ed3:	38 c2                	cmp    %al,%dl
  800ed5:	74 da                	je     800eb1 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ed7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800edb:	75 07                	jne    800ee4 <strncmp+0x38>
		return 0;
  800edd:	b8 00 00 00 00       	mov    $0x0,%eax
  800ee2:	eb 14                	jmp    800ef8 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee7:	8a 00                	mov    (%eax),%al
  800ee9:	0f b6 d0             	movzbl %al,%edx
  800eec:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eef:	8a 00                	mov    (%eax),%al
  800ef1:	0f b6 c0             	movzbl %al,%eax
  800ef4:	29 c2                	sub    %eax,%edx
  800ef6:	89 d0                	mov    %edx,%eax
}
  800ef8:	5d                   	pop    %ebp
  800ef9:	c3                   	ret    

00800efa <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800efa:	55                   	push   %ebp
  800efb:	89 e5                	mov    %esp,%ebp
  800efd:	83 ec 04             	sub    $0x4,%esp
  800f00:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f03:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f06:	eb 12                	jmp    800f1a <strchr+0x20>
		if (*s == c)
  800f08:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0b:	8a 00                	mov    (%eax),%al
  800f0d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f10:	75 05                	jne    800f17 <strchr+0x1d>
			return (char *) s;
  800f12:	8b 45 08             	mov    0x8(%ebp),%eax
  800f15:	eb 11                	jmp    800f28 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f17:	ff 45 08             	incl   0x8(%ebp)
  800f1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1d:	8a 00                	mov    (%eax),%al
  800f1f:	84 c0                	test   %al,%al
  800f21:	75 e5                	jne    800f08 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f23:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f28:	c9                   	leave  
  800f29:	c3                   	ret    

00800f2a <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f2a:	55                   	push   %ebp
  800f2b:	89 e5                	mov    %esp,%ebp
  800f2d:	83 ec 04             	sub    $0x4,%esp
  800f30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f33:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f36:	eb 0d                	jmp    800f45 <strfind+0x1b>
		if (*s == c)
  800f38:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3b:	8a 00                	mov    (%eax),%al
  800f3d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f40:	74 0e                	je     800f50 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f42:	ff 45 08             	incl   0x8(%ebp)
  800f45:	8b 45 08             	mov    0x8(%ebp),%eax
  800f48:	8a 00                	mov    (%eax),%al
  800f4a:	84 c0                	test   %al,%al
  800f4c:	75 ea                	jne    800f38 <strfind+0xe>
  800f4e:	eb 01                	jmp    800f51 <strfind+0x27>
		if (*s == c)
			break;
  800f50:	90                   	nop
	return (char *) s;
  800f51:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f54:	c9                   	leave  
  800f55:	c3                   	ret    

00800f56 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800f56:	55                   	push   %ebp
  800f57:	89 e5                	mov    %esp,%ebp
  800f59:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f62:	8b 45 10             	mov    0x10(%ebp),%eax
  800f65:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f68:	eb 0e                	jmp    800f78 <memset+0x22>
		*p++ = c;
  800f6a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f6d:	8d 50 01             	lea    0x1(%eax),%edx
  800f70:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f73:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f76:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f78:	ff 4d f8             	decl   -0x8(%ebp)
  800f7b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f7f:	79 e9                	jns    800f6a <memset+0x14>
		*p++ = c;

	return v;
  800f81:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f84:	c9                   	leave  
  800f85:	c3                   	ret    

00800f86 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f86:	55                   	push   %ebp
  800f87:	89 e5                	mov    %esp,%ebp
  800f89:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f92:	8b 45 08             	mov    0x8(%ebp),%eax
  800f95:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f98:	eb 16                	jmp    800fb0 <memcpy+0x2a>
		*d++ = *s++;
  800f9a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f9d:	8d 50 01             	lea    0x1(%eax),%edx
  800fa0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fa3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fa6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fa9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fac:	8a 12                	mov    (%edx),%dl
  800fae:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800fb0:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fb6:	89 55 10             	mov    %edx,0x10(%ebp)
  800fb9:	85 c0                	test   %eax,%eax
  800fbb:	75 dd                	jne    800f9a <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800fbd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fc0:	c9                   	leave  
  800fc1:	c3                   	ret    

00800fc2 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800fc2:	55                   	push   %ebp
  800fc3:	89 e5                	mov    %esp,%ebp
  800fc5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fc8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fcb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fce:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800fd4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fd7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fda:	73 50                	jae    80102c <memmove+0x6a>
  800fdc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fdf:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe2:	01 d0                	add    %edx,%eax
  800fe4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fe7:	76 43                	jbe    80102c <memmove+0x6a>
		s += n;
  800fe9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fec:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800fef:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff2:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800ff5:	eb 10                	jmp    801007 <memmove+0x45>
			*--d = *--s;
  800ff7:	ff 4d f8             	decl   -0x8(%ebp)
  800ffa:	ff 4d fc             	decl   -0x4(%ebp)
  800ffd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801000:	8a 10                	mov    (%eax),%dl
  801002:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801005:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801007:	8b 45 10             	mov    0x10(%ebp),%eax
  80100a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80100d:	89 55 10             	mov    %edx,0x10(%ebp)
  801010:	85 c0                	test   %eax,%eax
  801012:	75 e3                	jne    800ff7 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801014:	eb 23                	jmp    801039 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801016:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801019:	8d 50 01             	lea    0x1(%eax),%edx
  80101c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80101f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801022:	8d 4a 01             	lea    0x1(%edx),%ecx
  801025:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801028:	8a 12                	mov    (%edx),%dl
  80102a:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80102c:	8b 45 10             	mov    0x10(%ebp),%eax
  80102f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801032:	89 55 10             	mov    %edx,0x10(%ebp)
  801035:	85 c0                	test   %eax,%eax
  801037:	75 dd                	jne    801016 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801039:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80103c:	c9                   	leave  
  80103d:	c3                   	ret    

0080103e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80103e:	55                   	push   %ebp
  80103f:	89 e5                	mov    %esp,%ebp
  801041:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801044:	8b 45 08             	mov    0x8(%ebp),%eax
  801047:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80104a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104d:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801050:	eb 2a                	jmp    80107c <memcmp+0x3e>
		if (*s1 != *s2)
  801052:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801055:	8a 10                	mov    (%eax),%dl
  801057:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80105a:	8a 00                	mov    (%eax),%al
  80105c:	38 c2                	cmp    %al,%dl
  80105e:	74 16                	je     801076 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801060:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801063:	8a 00                	mov    (%eax),%al
  801065:	0f b6 d0             	movzbl %al,%edx
  801068:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80106b:	8a 00                	mov    (%eax),%al
  80106d:	0f b6 c0             	movzbl %al,%eax
  801070:	29 c2                	sub    %eax,%edx
  801072:	89 d0                	mov    %edx,%eax
  801074:	eb 18                	jmp    80108e <memcmp+0x50>
		s1++, s2++;
  801076:	ff 45 fc             	incl   -0x4(%ebp)
  801079:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80107c:	8b 45 10             	mov    0x10(%ebp),%eax
  80107f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801082:	89 55 10             	mov    %edx,0x10(%ebp)
  801085:	85 c0                	test   %eax,%eax
  801087:	75 c9                	jne    801052 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801089:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80108e:	c9                   	leave  
  80108f:	c3                   	ret    

00801090 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801090:	55                   	push   %ebp
  801091:	89 e5                	mov    %esp,%ebp
  801093:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801096:	8b 55 08             	mov    0x8(%ebp),%edx
  801099:	8b 45 10             	mov    0x10(%ebp),%eax
  80109c:	01 d0                	add    %edx,%eax
  80109e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010a1:	eb 15                	jmp    8010b8 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a6:	8a 00                	mov    (%eax),%al
  8010a8:	0f b6 d0             	movzbl %al,%edx
  8010ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ae:	0f b6 c0             	movzbl %al,%eax
  8010b1:	39 c2                	cmp    %eax,%edx
  8010b3:	74 0d                	je     8010c2 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8010b5:	ff 45 08             	incl   0x8(%ebp)
  8010b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8010be:	72 e3                	jb     8010a3 <memfind+0x13>
  8010c0:	eb 01                	jmp    8010c3 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8010c2:	90                   	nop
	return (void *) s;
  8010c3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010c6:	c9                   	leave  
  8010c7:	c3                   	ret    

008010c8 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8010c8:	55                   	push   %ebp
  8010c9:	89 e5                	mov    %esp,%ebp
  8010cb:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8010ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8010d5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010dc:	eb 03                	jmp    8010e1 <strtol+0x19>
		s++;
  8010de:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e4:	8a 00                	mov    (%eax),%al
  8010e6:	3c 20                	cmp    $0x20,%al
  8010e8:	74 f4                	je     8010de <strtol+0x16>
  8010ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ed:	8a 00                	mov    (%eax),%al
  8010ef:	3c 09                	cmp    $0x9,%al
  8010f1:	74 eb                	je     8010de <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8010f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f6:	8a 00                	mov    (%eax),%al
  8010f8:	3c 2b                	cmp    $0x2b,%al
  8010fa:	75 05                	jne    801101 <strtol+0x39>
		s++;
  8010fc:	ff 45 08             	incl   0x8(%ebp)
  8010ff:	eb 13                	jmp    801114 <strtol+0x4c>
	else if (*s == '-')
  801101:	8b 45 08             	mov    0x8(%ebp),%eax
  801104:	8a 00                	mov    (%eax),%al
  801106:	3c 2d                	cmp    $0x2d,%al
  801108:	75 0a                	jne    801114 <strtol+0x4c>
		s++, neg = 1;
  80110a:	ff 45 08             	incl   0x8(%ebp)
  80110d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801114:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801118:	74 06                	je     801120 <strtol+0x58>
  80111a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80111e:	75 20                	jne    801140 <strtol+0x78>
  801120:	8b 45 08             	mov    0x8(%ebp),%eax
  801123:	8a 00                	mov    (%eax),%al
  801125:	3c 30                	cmp    $0x30,%al
  801127:	75 17                	jne    801140 <strtol+0x78>
  801129:	8b 45 08             	mov    0x8(%ebp),%eax
  80112c:	40                   	inc    %eax
  80112d:	8a 00                	mov    (%eax),%al
  80112f:	3c 78                	cmp    $0x78,%al
  801131:	75 0d                	jne    801140 <strtol+0x78>
		s += 2, base = 16;
  801133:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801137:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80113e:	eb 28                	jmp    801168 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801140:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801144:	75 15                	jne    80115b <strtol+0x93>
  801146:	8b 45 08             	mov    0x8(%ebp),%eax
  801149:	8a 00                	mov    (%eax),%al
  80114b:	3c 30                	cmp    $0x30,%al
  80114d:	75 0c                	jne    80115b <strtol+0x93>
		s++, base = 8;
  80114f:	ff 45 08             	incl   0x8(%ebp)
  801152:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801159:	eb 0d                	jmp    801168 <strtol+0xa0>
	else if (base == 0)
  80115b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80115f:	75 07                	jne    801168 <strtol+0xa0>
		base = 10;
  801161:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801168:	8b 45 08             	mov    0x8(%ebp),%eax
  80116b:	8a 00                	mov    (%eax),%al
  80116d:	3c 2f                	cmp    $0x2f,%al
  80116f:	7e 19                	jle    80118a <strtol+0xc2>
  801171:	8b 45 08             	mov    0x8(%ebp),%eax
  801174:	8a 00                	mov    (%eax),%al
  801176:	3c 39                	cmp    $0x39,%al
  801178:	7f 10                	jg     80118a <strtol+0xc2>
			dig = *s - '0';
  80117a:	8b 45 08             	mov    0x8(%ebp),%eax
  80117d:	8a 00                	mov    (%eax),%al
  80117f:	0f be c0             	movsbl %al,%eax
  801182:	83 e8 30             	sub    $0x30,%eax
  801185:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801188:	eb 42                	jmp    8011cc <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80118a:	8b 45 08             	mov    0x8(%ebp),%eax
  80118d:	8a 00                	mov    (%eax),%al
  80118f:	3c 60                	cmp    $0x60,%al
  801191:	7e 19                	jle    8011ac <strtol+0xe4>
  801193:	8b 45 08             	mov    0x8(%ebp),%eax
  801196:	8a 00                	mov    (%eax),%al
  801198:	3c 7a                	cmp    $0x7a,%al
  80119a:	7f 10                	jg     8011ac <strtol+0xe4>
			dig = *s - 'a' + 10;
  80119c:	8b 45 08             	mov    0x8(%ebp),%eax
  80119f:	8a 00                	mov    (%eax),%al
  8011a1:	0f be c0             	movsbl %al,%eax
  8011a4:	83 e8 57             	sub    $0x57,%eax
  8011a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011aa:	eb 20                	jmp    8011cc <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8011af:	8a 00                	mov    (%eax),%al
  8011b1:	3c 40                	cmp    $0x40,%al
  8011b3:	7e 39                	jle    8011ee <strtol+0x126>
  8011b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b8:	8a 00                	mov    (%eax),%al
  8011ba:	3c 5a                	cmp    $0x5a,%al
  8011bc:	7f 30                	jg     8011ee <strtol+0x126>
			dig = *s - 'A' + 10;
  8011be:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c1:	8a 00                	mov    (%eax),%al
  8011c3:	0f be c0             	movsbl %al,%eax
  8011c6:	83 e8 37             	sub    $0x37,%eax
  8011c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8011cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011cf:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011d2:	7d 19                	jge    8011ed <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8011d4:	ff 45 08             	incl   0x8(%ebp)
  8011d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011da:	0f af 45 10          	imul   0x10(%ebp),%eax
  8011de:	89 c2                	mov    %eax,%edx
  8011e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011e3:	01 d0                	add    %edx,%eax
  8011e5:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8011e8:	e9 7b ff ff ff       	jmp    801168 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8011ed:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8011ee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011f2:	74 08                	je     8011fc <strtol+0x134>
		*endptr = (char *) s;
  8011f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f7:	8b 55 08             	mov    0x8(%ebp),%edx
  8011fa:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8011fc:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801200:	74 07                	je     801209 <strtol+0x141>
  801202:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801205:	f7 d8                	neg    %eax
  801207:	eb 03                	jmp    80120c <strtol+0x144>
  801209:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80120c:	c9                   	leave  
  80120d:	c3                   	ret    

0080120e <ltostr>:

void
ltostr(long value, char *str)
{
  80120e:	55                   	push   %ebp
  80120f:	89 e5                	mov    %esp,%ebp
  801211:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801214:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80121b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801222:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801226:	79 13                	jns    80123b <ltostr+0x2d>
	{
		neg = 1;
  801228:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80122f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801232:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801235:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801238:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80123b:	8b 45 08             	mov    0x8(%ebp),%eax
  80123e:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801243:	99                   	cltd   
  801244:	f7 f9                	idiv   %ecx
  801246:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801249:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80124c:	8d 50 01             	lea    0x1(%eax),%edx
  80124f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801252:	89 c2                	mov    %eax,%edx
  801254:	8b 45 0c             	mov    0xc(%ebp),%eax
  801257:	01 d0                	add    %edx,%eax
  801259:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80125c:	83 c2 30             	add    $0x30,%edx
  80125f:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801261:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801264:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801269:	f7 e9                	imul   %ecx
  80126b:	c1 fa 02             	sar    $0x2,%edx
  80126e:	89 c8                	mov    %ecx,%eax
  801270:	c1 f8 1f             	sar    $0x1f,%eax
  801273:	29 c2                	sub    %eax,%edx
  801275:	89 d0                	mov    %edx,%eax
  801277:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80127a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80127d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801282:	f7 e9                	imul   %ecx
  801284:	c1 fa 02             	sar    $0x2,%edx
  801287:	89 c8                	mov    %ecx,%eax
  801289:	c1 f8 1f             	sar    $0x1f,%eax
  80128c:	29 c2                	sub    %eax,%edx
  80128e:	89 d0                	mov    %edx,%eax
  801290:	c1 e0 02             	shl    $0x2,%eax
  801293:	01 d0                	add    %edx,%eax
  801295:	01 c0                	add    %eax,%eax
  801297:	29 c1                	sub    %eax,%ecx
  801299:	89 ca                	mov    %ecx,%edx
  80129b:	85 d2                	test   %edx,%edx
  80129d:	75 9c                	jne    80123b <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80129f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012a9:	48                   	dec    %eax
  8012aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8012ad:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012b1:	74 3d                	je     8012f0 <ltostr+0xe2>
		start = 1 ;
  8012b3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8012ba:	eb 34                	jmp    8012f0 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8012bc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c2:	01 d0                	add    %edx,%eax
  8012c4:	8a 00                	mov    (%eax),%al
  8012c6:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012cf:	01 c2                	add    %eax,%edx
  8012d1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8012d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d7:	01 c8                	add    %ecx,%eax
  8012d9:	8a 00                	mov    (%eax),%al
  8012db:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8012dd:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8012e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e3:	01 c2                	add    %eax,%edx
  8012e5:	8a 45 eb             	mov    -0x15(%ebp),%al
  8012e8:	88 02                	mov    %al,(%edx)
		start++ ;
  8012ea:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8012ed:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8012f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012f3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012f6:	7c c4                	jl     8012bc <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8012f8:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8012fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012fe:	01 d0                	add    %edx,%eax
  801300:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801303:	90                   	nop
  801304:	c9                   	leave  
  801305:	c3                   	ret    

00801306 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801306:	55                   	push   %ebp
  801307:	89 e5                	mov    %esp,%ebp
  801309:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80130c:	ff 75 08             	pushl  0x8(%ebp)
  80130f:	e8 54 fa ff ff       	call   800d68 <strlen>
  801314:	83 c4 04             	add    $0x4,%esp
  801317:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80131a:	ff 75 0c             	pushl  0xc(%ebp)
  80131d:	e8 46 fa ff ff       	call   800d68 <strlen>
  801322:	83 c4 04             	add    $0x4,%esp
  801325:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801328:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80132f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801336:	eb 17                	jmp    80134f <strcconcat+0x49>
		final[s] = str1[s] ;
  801338:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80133b:	8b 45 10             	mov    0x10(%ebp),%eax
  80133e:	01 c2                	add    %eax,%edx
  801340:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801343:	8b 45 08             	mov    0x8(%ebp),%eax
  801346:	01 c8                	add    %ecx,%eax
  801348:	8a 00                	mov    (%eax),%al
  80134a:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80134c:	ff 45 fc             	incl   -0x4(%ebp)
  80134f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801352:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801355:	7c e1                	jl     801338 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801357:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80135e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801365:	eb 1f                	jmp    801386 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801367:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80136a:	8d 50 01             	lea    0x1(%eax),%edx
  80136d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801370:	89 c2                	mov    %eax,%edx
  801372:	8b 45 10             	mov    0x10(%ebp),%eax
  801375:	01 c2                	add    %eax,%edx
  801377:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80137a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137d:	01 c8                	add    %ecx,%eax
  80137f:	8a 00                	mov    (%eax),%al
  801381:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801383:	ff 45 f8             	incl   -0x8(%ebp)
  801386:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801389:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80138c:	7c d9                	jl     801367 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80138e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801391:	8b 45 10             	mov    0x10(%ebp),%eax
  801394:	01 d0                	add    %edx,%eax
  801396:	c6 00 00             	movb   $0x0,(%eax)
}
  801399:	90                   	nop
  80139a:	c9                   	leave  
  80139b:	c3                   	ret    

0080139c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80139c:	55                   	push   %ebp
  80139d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80139f:	8b 45 14             	mov    0x14(%ebp),%eax
  8013a2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8013a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8013ab:	8b 00                	mov    (%eax),%eax
  8013ad:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b7:	01 d0                	add    %edx,%eax
  8013b9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013bf:	eb 0c                	jmp    8013cd <strsplit+0x31>
			*string++ = 0;
  8013c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c4:	8d 50 01             	lea    0x1(%eax),%edx
  8013c7:	89 55 08             	mov    %edx,0x8(%ebp)
  8013ca:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d0:	8a 00                	mov    (%eax),%al
  8013d2:	84 c0                	test   %al,%al
  8013d4:	74 18                	je     8013ee <strsplit+0x52>
  8013d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d9:	8a 00                	mov    (%eax),%al
  8013db:	0f be c0             	movsbl %al,%eax
  8013de:	50                   	push   %eax
  8013df:	ff 75 0c             	pushl  0xc(%ebp)
  8013e2:	e8 13 fb ff ff       	call   800efa <strchr>
  8013e7:	83 c4 08             	add    $0x8,%esp
  8013ea:	85 c0                	test   %eax,%eax
  8013ec:	75 d3                	jne    8013c1 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8013ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f1:	8a 00                	mov    (%eax),%al
  8013f3:	84 c0                	test   %al,%al
  8013f5:	74 5a                	je     801451 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8013f7:	8b 45 14             	mov    0x14(%ebp),%eax
  8013fa:	8b 00                	mov    (%eax),%eax
  8013fc:	83 f8 0f             	cmp    $0xf,%eax
  8013ff:	75 07                	jne    801408 <strsplit+0x6c>
		{
			return 0;
  801401:	b8 00 00 00 00       	mov    $0x0,%eax
  801406:	eb 66                	jmp    80146e <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801408:	8b 45 14             	mov    0x14(%ebp),%eax
  80140b:	8b 00                	mov    (%eax),%eax
  80140d:	8d 48 01             	lea    0x1(%eax),%ecx
  801410:	8b 55 14             	mov    0x14(%ebp),%edx
  801413:	89 0a                	mov    %ecx,(%edx)
  801415:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80141c:	8b 45 10             	mov    0x10(%ebp),%eax
  80141f:	01 c2                	add    %eax,%edx
  801421:	8b 45 08             	mov    0x8(%ebp),%eax
  801424:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801426:	eb 03                	jmp    80142b <strsplit+0x8f>
			string++;
  801428:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80142b:	8b 45 08             	mov    0x8(%ebp),%eax
  80142e:	8a 00                	mov    (%eax),%al
  801430:	84 c0                	test   %al,%al
  801432:	74 8b                	je     8013bf <strsplit+0x23>
  801434:	8b 45 08             	mov    0x8(%ebp),%eax
  801437:	8a 00                	mov    (%eax),%al
  801439:	0f be c0             	movsbl %al,%eax
  80143c:	50                   	push   %eax
  80143d:	ff 75 0c             	pushl  0xc(%ebp)
  801440:	e8 b5 fa ff ff       	call   800efa <strchr>
  801445:	83 c4 08             	add    $0x8,%esp
  801448:	85 c0                	test   %eax,%eax
  80144a:	74 dc                	je     801428 <strsplit+0x8c>
			string++;
	}
  80144c:	e9 6e ff ff ff       	jmp    8013bf <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801451:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801452:	8b 45 14             	mov    0x14(%ebp),%eax
  801455:	8b 00                	mov    (%eax),%eax
  801457:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80145e:	8b 45 10             	mov    0x10(%ebp),%eax
  801461:	01 d0                	add    %edx,%eax
  801463:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801469:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80146e:	c9                   	leave  
  80146f:	c3                   	ret    

00801470 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801470:	55                   	push   %ebp
  801471:	89 e5                	mov    %esp,%ebp
  801473:	57                   	push   %edi
  801474:	56                   	push   %esi
  801475:	53                   	push   %ebx
  801476:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801479:	8b 45 08             	mov    0x8(%ebp),%eax
  80147c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80147f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801482:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801485:	8b 7d 18             	mov    0x18(%ebp),%edi
  801488:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80148b:	cd 30                	int    $0x30
  80148d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801490:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801493:	83 c4 10             	add    $0x10,%esp
  801496:	5b                   	pop    %ebx
  801497:	5e                   	pop    %esi
  801498:	5f                   	pop    %edi
  801499:	5d                   	pop    %ebp
  80149a:	c3                   	ret    

0080149b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80149b:	55                   	push   %ebp
  80149c:	89 e5                	mov    %esp,%ebp
  80149e:	83 ec 04             	sub    $0x4,%esp
  8014a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8014a4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8014a7:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 00                	push   $0x0
  8014b2:	52                   	push   %edx
  8014b3:	ff 75 0c             	pushl  0xc(%ebp)
  8014b6:	50                   	push   %eax
  8014b7:	6a 00                	push   $0x0
  8014b9:	e8 b2 ff ff ff       	call   801470 <syscall>
  8014be:	83 c4 18             	add    $0x18,%esp
}
  8014c1:	90                   	nop
  8014c2:	c9                   	leave  
  8014c3:	c3                   	ret    

008014c4 <sys_cgetc>:

int
sys_cgetc(void)
{
  8014c4:	55                   	push   %ebp
  8014c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8014c7:	6a 00                	push   $0x0
  8014c9:	6a 00                	push   $0x0
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 00                	push   $0x0
  8014d1:	6a 01                	push   $0x1
  8014d3:	e8 98 ff ff ff       	call   801470 <syscall>
  8014d8:	83 c4 18             	add    $0x18,%esp
}
  8014db:	c9                   	leave  
  8014dc:	c3                   	ret    

008014dd <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8014dd:	55                   	push   %ebp
  8014de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8014e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e3:	6a 00                	push   $0x0
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 00                	push   $0x0
  8014eb:	50                   	push   %eax
  8014ec:	6a 05                	push   $0x5
  8014ee:	e8 7d ff ff ff       	call   801470 <syscall>
  8014f3:	83 c4 18             	add    $0x18,%esp
}
  8014f6:	c9                   	leave  
  8014f7:	c3                   	ret    

008014f8 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8014f8:	55                   	push   %ebp
  8014f9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	6a 00                	push   $0x0
  801503:	6a 00                	push   $0x0
  801505:	6a 02                	push   $0x2
  801507:	e8 64 ff ff ff       	call   801470 <syscall>
  80150c:	83 c4 18             	add    $0x18,%esp
}
  80150f:	c9                   	leave  
  801510:	c3                   	ret    

00801511 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801511:	55                   	push   %ebp
  801512:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	6a 00                	push   $0x0
  80151c:	6a 00                	push   $0x0
  80151e:	6a 03                	push   $0x3
  801520:	e8 4b ff ff ff       	call   801470 <syscall>
  801525:	83 c4 18             	add    $0x18,%esp
}
  801528:	c9                   	leave  
  801529:	c3                   	ret    

0080152a <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80152a:	55                   	push   %ebp
  80152b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80152d:	6a 00                	push   $0x0
  80152f:	6a 00                	push   $0x0
  801531:	6a 00                	push   $0x0
  801533:	6a 00                	push   $0x0
  801535:	6a 00                	push   $0x0
  801537:	6a 04                	push   $0x4
  801539:	e8 32 ff ff ff       	call   801470 <syscall>
  80153e:	83 c4 18             	add    $0x18,%esp
}
  801541:	c9                   	leave  
  801542:	c3                   	ret    

00801543 <sys_env_exit>:


void sys_env_exit(void)
{
  801543:	55                   	push   %ebp
  801544:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801546:	6a 00                	push   $0x0
  801548:	6a 00                	push   $0x0
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 06                	push   $0x6
  801552:	e8 19 ff ff ff       	call   801470 <syscall>
  801557:	83 c4 18             	add    $0x18,%esp
}
  80155a:	90                   	nop
  80155b:	c9                   	leave  
  80155c:	c3                   	ret    

0080155d <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80155d:	55                   	push   %ebp
  80155e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801560:	8b 55 0c             	mov    0xc(%ebp),%edx
  801563:	8b 45 08             	mov    0x8(%ebp),%eax
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	6a 00                	push   $0x0
  80156c:	52                   	push   %edx
  80156d:	50                   	push   %eax
  80156e:	6a 07                	push   $0x7
  801570:	e8 fb fe ff ff       	call   801470 <syscall>
  801575:	83 c4 18             	add    $0x18,%esp
}
  801578:	c9                   	leave  
  801579:	c3                   	ret    

0080157a <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80157a:	55                   	push   %ebp
  80157b:	89 e5                	mov    %esp,%ebp
  80157d:	56                   	push   %esi
  80157e:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80157f:	8b 75 18             	mov    0x18(%ebp),%esi
  801582:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801585:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801588:	8b 55 0c             	mov    0xc(%ebp),%edx
  80158b:	8b 45 08             	mov    0x8(%ebp),%eax
  80158e:	56                   	push   %esi
  80158f:	53                   	push   %ebx
  801590:	51                   	push   %ecx
  801591:	52                   	push   %edx
  801592:	50                   	push   %eax
  801593:	6a 08                	push   $0x8
  801595:	e8 d6 fe ff ff       	call   801470 <syscall>
  80159a:	83 c4 18             	add    $0x18,%esp
}
  80159d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8015a0:	5b                   	pop    %ebx
  8015a1:	5e                   	pop    %esi
  8015a2:	5d                   	pop    %ebp
  8015a3:	c3                   	ret    

008015a4 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8015a4:	55                   	push   %ebp
  8015a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8015a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	52                   	push   %edx
  8015b4:	50                   	push   %eax
  8015b5:	6a 09                	push   $0x9
  8015b7:	e8 b4 fe ff ff       	call   801470 <syscall>
  8015bc:	83 c4 18             	add    $0x18,%esp
}
  8015bf:	c9                   	leave  
  8015c0:	c3                   	ret    

008015c1 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8015c1:	55                   	push   %ebp
  8015c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	ff 75 0c             	pushl  0xc(%ebp)
  8015cd:	ff 75 08             	pushl  0x8(%ebp)
  8015d0:	6a 0a                	push   $0xa
  8015d2:	e8 99 fe ff ff       	call   801470 <syscall>
  8015d7:	83 c4 18             	add    $0x18,%esp
}
  8015da:	c9                   	leave  
  8015db:	c3                   	ret    

008015dc <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8015dc:	55                   	push   %ebp
  8015dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 0b                	push   $0xb
  8015eb:	e8 80 fe ff ff       	call   801470 <syscall>
  8015f0:	83 c4 18             	add    $0x18,%esp
}
  8015f3:	c9                   	leave  
  8015f4:	c3                   	ret    

008015f5 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8015f5:	55                   	push   %ebp
  8015f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 00                	push   $0x0
  801600:	6a 00                	push   $0x0
  801602:	6a 0c                	push   $0xc
  801604:	e8 67 fe ff ff       	call   801470 <syscall>
  801609:	83 c4 18             	add    $0x18,%esp
}
  80160c:	c9                   	leave  
  80160d:	c3                   	ret    

0080160e <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80160e:	55                   	push   %ebp
  80160f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	6a 0d                	push   $0xd
  80161d:	e8 4e fe ff ff       	call   801470 <syscall>
  801622:	83 c4 18             	add    $0x18,%esp
}
  801625:	c9                   	leave  
  801626:	c3                   	ret    

00801627 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801627:	55                   	push   %ebp
  801628:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80162a:	6a 00                	push   $0x0
  80162c:	6a 00                	push   $0x0
  80162e:	6a 00                	push   $0x0
  801630:	ff 75 0c             	pushl  0xc(%ebp)
  801633:	ff 75 08             	pushl  0x8(%ebp)
  801636:	6a 11                	push   $0x11
  801638:	e8 33 fe ff ff       	call   801470 <syscall>
  80163d:	83 c4 18             	add    $0x18,%esp
	return;
  801640:	90                   	nop
}
  801641:	c9                   	leave  
  801642:	c3                   	ret    

00801643 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801643:	55                   	push   %ebp
  801644:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	ff 75 0c             	pushl  0xc(%ebp)
  80164f:	ff 75 08             	pushl  0x8(%ebp)
  801652:	6a 12                	push   $0x12
  801654:	e8 17 fe ff ff       	call   801470 <syscall>
  801659:	83 c4 18             	add    $0x18,%esp
	return ;
  80165c:	90                   	nop
}
  80165d:	c9                   	leave  
  80165e:	c3                   	ret    

0080165f <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80165f:	55                   	push   %ebp
  801660:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	6a 00                	push   $0x0
  80166a:	6a 00                	push   $0x0
  80166c:	6a 0e                	push   $0xe
  80166e:	e8 fd fd ff ff       	call   801470 <syscall>
  801673:	83 c4 18             	add    $0x18,%esp
}
  801676:	c9                   	leave  
  801677:	c3                   	ret    

00801678 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801678:	55                   	push   %ebp
  801679:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80167b:	6a 00                	push   $0x0
  80167d:	6a 00                	push   $0x0
  80167f:	6a 00                	push   $0x0
  801681:	6a 00                	push   $0x0
  801683:	ff 75 08             	pushl  0x8(%ebp)
  801686:	6a 0f                	push   $0xf
  801688:	e8 e3 fd ff ff       	call   801470 <syscall>
  80168d:	83 c4 18             	add    $0x18,%esp
}
  801690:	c9                   	leave  
  801691:	c3                   	ret    

00801692 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801692:	55                   	push   %ebp
  801693:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801695:	6a 00                	push   $0x0
  801697:	6a 00                	push   $0x0
  801699:	6a 00                	push   $0x0
  80169b:	6a 00                	push   $0x0
  80169d:	6a 00                	push   $0x0
  80169f:	6a 10                	push   $0x10
  8016a1:	e8 ca fd ff ff       	call   801470 <syscall>
  8016a6:	83 c4 18             	add    $0x18,%esp
}
  8016a9:	90                   	nop
  8016aa:	c9                   	leave  
  8016ab:	c3                   	ret    

008016ac <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8016ac:	55                   	push   %ebp
  8016ad:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8016af:	6a 00                	push   $0x0
  8016b1:	6a 00                	push   $0x0
  8016b3:	6a 00                	push   $0x0
  8016b5:	6a 00                	push   $0x0
  8016b7:	6a 00                	push   $0x0
  8016b9:	6a 14                	push   $0x14
  8016bb:	e8 b0 fd ff ff       	call   801470 <syscall>
  8016c0:	83 c4 18             	add    $0x18,%esp
}
  8016c3:	90                   	nop
  8016c4:	c9                   	leave  
  8016c5:	c3                   	ret    

008016c6 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8016c6:	55                   	push   %ebp
  8016c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8016c9:	6a 00                	push   $0x0
  8016cb:	6a 00                	push   $0x0
  8016cd:	6a 00                	push   $0x0
  8016cf:	6a 00                	push   $0x0
  8016d1:	6a 00                	push   $0x0
  8016d3:	6a 15                	push   $0x15
  8016d5:	e8 96 fd ff ff       	call   801470 <syscall>
  8016da:	83 c4 18             	add    $0x18,%esp
}
  8016dd:	90                   	nop
  8016de:	c9                   	leave  
  8016df:	c3                   	ret    

008016e0 <sys_cputc>:


void
sys_cputc(const char c)
{
  8016e0:	55                   	push   %ebp
  8016e1:	89 e5                	mov    %esp,%ebp
  8016e3:	83 ec 04             	sub    $0x4,%esp
  8016e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8016ec:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016f0:	6a 00                	push   $0x0
  8016f2:	6a 00                	push   $0x0
  8016f4:	6a 00                	push   $0x0
  8016f6:	6a 00                	push   $0x0
  8016f8:	50                   	push   %eax
  8016f9:	6a 16                	push   $0x16
  8016fb:	e8 70 fd ff ff       	call   801470 <syscall>
  801700:	83 c4 18             	add    $0x18,%esp
}
  801703:	90                   	nop
  801704:	c9                   	leave  
  801705:	c3                   	ret    

00801706 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801706:	55                   	push   %ebp
  801707:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801709:	6a 00                	push   $0x0
  80170b:	6a 00                	push   $0x0
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	6a 17                	push   $0x17
  801715:	e8 56 fd ff ff       	call   801470 <syscall>
  80171a:	83 c4 18             	add    $0x18,%esp
}
  80171d:	90                   	nop
  80171e:	c9                   	leave  
  80171f:	c3                   	ret    

00801720 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801720:	55                   	push   %ebp
  801721:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801723:	8b 45 08             	mov    0x8(%ebp),%eax
  801726:	6a 00                	push   $0x0
  801728:	6a 00                	push   $0x0
  80172a:	6a 00                	push   $0x0
  80172c:	ff 75 0c             	pushl  0xc(%ebp)
  80172f:	50                   	push   %eax
  801730:	6a 18                	push   $0x18
  801732:	e8 39 fd ff ff       	call   801470 <syscall>
  801737:	83 c4 18             	add    $0x18,%esp
}
  80173a:	c9                   	leave  
  80173b:	c3                   	ret    

0080173c <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80173c:	55                   	push   %ebp
  80173d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80173f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801742:	8b 45 08             	mov    0x8(%ebp),%eax
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	52                   	push   %edx
  80174c:	50                   	push   %eax
  80174d:	6a 1b                	push   $0x1b
  80174f:	e8 1c fd ff ff       	call   801470 <syscall>
  801754:	83 c4 18             	add    $0x18,%esp
}
  801757:	c9                   	leave  
  801758:	c3                   	ret    

00801759 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801759:	55                   	push   %ebp
  80175a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80175c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80175f:	8b 45 08             	mov    0x8(%ebp),%eax
  801762:	6a 00                	push   $0x0
  801764:	6a 00                	push   $0x0
  801766:	6a 00                	push   $0x0
  801768:	52                   	push   %edx
  801769:	50                   	push   %eax
  80176a:	6a 19                	push   $0x19
  80176c:	e8 ff fc ff ff       	call   801470 <syscall>
  801771:	83 c4 18             	add    $0x18,%esp
}
  801774:	90                   	nop
  801775:	c9                   	leave  
  801776:	c3                   	ret    

00801777 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801777:	55                   	push   %ebp
  801778:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80177a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80177d:	8b 45 08             	mov    0x8(%ebp),%eax
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	6a 00                	push   $0x0
  801786:	52                   	push   %edx
  801787:	50                   	push   %eax
  801788:	6a 1a                	push   $0x1a
  80178a:	e8 e1 fc ff ff       	call   801470 <syscall>
  80178f:	83 c4 18             	add    $0x18,%esp
}
  801792:	90                   	nop
  801793:	c9                   	leave  
  801794:	c3                   	ret    

00801795 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801795:	55                   	push   %ebp
  801796:	89 e5                	mov    %esp,%ebp
  801798:	83 ec 04             	sub    $0x4,%esp
  80179b:	8b 45 10             	mov    0x10(%ebp),%eax
  80179e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8017a1:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8017a4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8017a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ab:	6a 00                	push   $0x0
  8017ad:	51                   	push   %ecx
  8017ae:	52                   	push   %edx
  8017af:	ff 75 0c             	pushl  0xc(%ebp)
  8017b2:	50                   	push   %eax
  8017b3:	6a 1c                	push   $0x1c
  8017b5:	e8 b6 fc ff ff       	call   801470 <syscall>
  8017ba:	83 c4 18             	add    $0x18,%esp
}
  8017bd:	c9                   	leave  
  8017be:	c3                   	ret    

008017bf <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8017bf:	55                   	push   %ebp
  8017c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8017c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	52                   	push   %edx
  8017cf:	50                   	push   %eax
  8017d0:	6a 1d                	push   $0x1d
  8017d2:	e8 99 fc ff ff       	call   801470 <syscall>
  8017d7:	83 c4 18             	add    $0x18,%esp
}
  8017da:	c9                   	leave  
  8017db:	c3                   	ret    

008017dc <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8017dc:	55                   	push   %ebp
  8017dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8017df:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 00                	push   $0x0
  8017ec:	51                   	push   %ecx
  8017ed:	52                   	push   %edx
  8017ee:	50                   	push   %eax
  8017ef:	6a 1e                	push   $0x1e
  8017f1:	e8 7a fc ff ff       	call   801470 <syscall>
  8017f6:	83 c4 18             	add    $0x18,%esp
}
  8017f9:	c9                   	leave  
  8017fa:	c3                   	ret    

008017fb <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8017fb:	55                   	push   %ebp
  8017fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8017fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801801:	8b 45 08             	mov    0x8(%ebp),%eax
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	6a 00                	push   $0x0
  80180a:	52                   	push   %edx
  80180b:	50                   	push   %eax
  80180c:	6a 1f                	push   $0x1f
  80180e:	e8 5d fc ff ff       	call   801470 <syscall>
  801813:	83 c4 18             	add    $0x18,%esp
}
  801816:	c9                   	leave  
  801817:	c3                   	ret    

00801818 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801818:	55                   	push   %ebp
  801819:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80181b:	6a 00                	push   $0x0
  80181d:	6a 00                	push   $0x0
  80181f:	6a 00                	push   $0x0
  801821:	6a 00                	push   $0x0
  801823:	6a 00                	push   $0x0
  801825:	6a 20                	push   $0x20
  801827:	e8 44 fc ff ff       	call   801470 <syscall>
  80182c:	83 c4 18             	add    $0x18,%esp
}
  80182f:	c9                   	leave  
  801830:	c3                   	ret    

00801831 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801831:	55                   	push   %ebp
  801832:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801834:	8b 45 08             	mov    0x8(%ebp),%eax
  801837:	6a 00                	push   $0x0
  801839:	ff 75 14             	pushl  0x14(%ebp)
  80183c:	ff 75 10             	pushl  0x10(%ebp)
  80183f:	ff 75 0c             	pushl  0xc(%ebp)
  801842:	50                   	push   %eax
  801843:	6a 21                	push   $0x21
  801845:	e8 26 fc ff ff       	call   801470 <syscall>
  80184a:	83 c4 18             	add    $0x18,%esp
}
  80184d:	c9                   	leave  
  80184e:	c3                   	ret    

0080184f <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80184f:	55                   	push   %ebp
  801850:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801852:	8b 45 08             	mov    0x8(%ebp),%eax
  801855:	6a 00                	push   $0x0
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	50                   	push   %eax
  80185e:	6a 22                	push   $0x22
  801860:	e8 0b fc ff ff       	call   801470 <syscall>
  801865:	83 c4 18             	add    $0x18,%esp
}
  801868:	90                   	nop
  801869:	c9                   	leave  
  80186a:	c3                   	ret    

0080186b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80186b:	55                   	push   %ebp
  80186c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80186e:	8b 45 08             	mov    0x8(%ebp),%eax
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	50                   	push   %eax
  80187a:	6a 23                	push   $0x23
  80187c:	e8 ef fb ff ff       	call   801470 <syscall>
  801881:	83 c4 18             	add    $0x18,%esp
}
  801884:	90                   	nop
  801885:	c9                   	leave  
  801886:	c3                   	ret    

00801887 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801887:	55                   	push   %ebp
  801888:	89 e5                	mov    %esp,%ebp
  80188a:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80188d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801890:	8d 50 04             	lea    0x4(%eax),%edx
  801893:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801896:	6a 00                	push   $0x0
  801898:	6a 00                	push   $0x0
  80189a:	6a 00                	push   $0x0
  80189c:	52                   	push   %edx
  80189d:	50                   	push   %eax
  80189e:	6a 24                	push   $0x24
  8018a0:	e8 cb fb ff ff       	call   801470 <syscall>
  8018a5:	83 c4 18             	add    $0x18,%esp
	return result;
  8018a8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ae:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018b1:	89 01                	mov    %eax,(%ecx)
  8018b3:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8018b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b9:	c9                   	leave  
  8018ba:	c2 04 00             	ret    $0x4

008018bd <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8018bd:	55                   	push   %ebp
  8018be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8018c0:	6a 00                	push   $0x0
  8018c2:	6a 00                	push   $0x0
  8018c4:	ff 75 10             	pushl  0x10(%ebp)
  8018c7:	ff 75 0c             	pushl  0xc(%ebp)
  8018ca:	ff 75 08             	pushl  0x8(%ebp)
  8018cd:	6a 13                	push   $0x13
  8018cf:	e8 9c fb ff ff       	call   801470 <syscall>
  8018d4:	83 c4 18             	add    $0x18,%esp
	return ;
  8018d7:	90                   	nop
}
  8018d8:	c9                   	leave  
  8018d9:	c3                   	ret    

008018da <sys_rcr2>:
uint32 sys_rcr2()
{
  8018da:	55                   	push   %ebp
  8018db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 00                	push   $0x0
  8018e5:	6a 00                	push   $0x0
  8018e7:	6a 25                	push   $0x25
  8018e9:	e8 82 fb ff ff       	call   801470 <syscall>
  8018ee:	83 c4 18             	add    $0x18,%esp
}
  8018f1:	c9                   	leave  
  8018f2:	c3                   	ret    

008018f3 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8018f3:	55                   	push   %ebp
  8018f4:	89 e5                	mov    %esp,%ebp
  8018f6:	83 ec 04             	sub    $0x4,%esp
  8018f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8018ff:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801903:	6a 00                	push   $0x0
  801905:	6a 00                	push   $0x0
  801907:	6a 00                	push   $0x0
  801909:	6a 00                	push   $0x0
  80190b:	50                   	push   %eax
  80190c:	6a 26                	push   $0x26
  80190e:	e8 5d fb ff ff       	call   801470 <syscall>
  801913:	83 c4 18             	add    $0x18,%esp
	return ;
  801916:	90                   	nop
}
  801917:	c9                   	leave  
  801918:	c3                   	ret    

00801919 <rsttst>:
void rsttst()
{
  801919:	55                   	push   %ebp
  80191a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	6a 00                	push   $0x0
  801926:	6a 28                	push   $0x28
  801928:	e8 43 fb ff ff       	call   801470 <syscall>
  80192d:	83 c4 18             	add    $0x18,%esp
	return ;
  801930:	90                   	nop
}
  801931:	c9                   	leave  
  801932:	c3                   	ret    

00801933 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801933:	55                   	push   %ebp
  801934:	89 e5                	mov    %esp,%ebp
  801936:	83 ec 04             	sub    $0x4,%esp
  801939:	8b 45 14             	mov    0x14(%ebp),%eax
  80193c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80193f:	8b 55 18             	mov    0x18(%ebp),%edx
  801942:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801946:	52                   	push   %edx
  801947:	50                   	push   %eax
  801948:	ff 75 10             	pushl  0x10(%ebp)
  80194b:	ff 75 0c             	pushl  0xc(%ebp)
  80194e:	ff 75 08             	pushl  0x8(%ebp)
  801951:	6a 27                	push   $0x27
  801953:	e8 18 fb ff ff       	call   801470 <syscall>
  801958:	83 c4 18             	add    $0x18,%esp
	return ;
  80195b:	90                   	nop
}
  80195c:	c9                   	leave  
  80195d:	c3                   	ret    

0080195e <chktst>:
void chktst(uint32 n)
{
  80195e:	55                   	push   %ebp
  80195f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801961:	6a 00                	push   $0x0
  801963:	6a 00                	push   $0x0
  801965:	6a 00                	push   $0x0
  801967:	6a 00                	push   $0x0
  801969:	ff 75 08             	pushl  0x8(%ebp)
  80196c:	6a 29                	push   $0x29
  80196e:	e8 fd fa ff ff       	call   801470 <syscall>
  801973:	83 c4 18             	add    $0x18,%esp
	return ;
  801976:	90                   	nop
}
  801977:	c9                   	leave  
  801978:	c3                   	ret    

00801979 <inctst>:

void inctst()
{
  801979:	55                   	push   %ebp
  80197a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80197c:	6a 00                	push   $0x0
  80197e:	6a 00                	push   $0x0
  801980:	6a 00                	push   $0x0
  801982:	6a 00                	push   $0x0
  801984:	6a 00                	push   $0x0
  801986:	6a 2a                	push   $0x2a
  801988:	e8 e3 fa ff ff       	call   801470 <syscall>
  80198d:	83 c4 18             	add    $0x18,%esp
	return ;
  801990:	90                   	nop
}
  801991:	c9                   	leave  
  801992:	c3                   	ret    

00801993 <gettst>:
uint32 gettst()
{
  801993:	55                   	push   %ebp
  801994:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801996:	6a 00                	push   $0x0
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 2b                	push   $0x2b
  8019a2:	e8 c9 fa ff ff       	call   801470 <syscall>
  8019a7:	83 c4 18             	add    $0x18,%esp
}
  8019aa:	c9                   	leave  
  8019ab:	c3                   	ret    

008019ac <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8019ac:	55                   	push   %ebp
  8019ad:	89 e5                	mov    %esp,%ebp
  8019af:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019b2:	6a 00                	push   $0x0
  8019b4:	6a 00                	push   $0x0
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 2c                	push   $0x2c
  8019be:	e8 ad fa ff ff       	call   801470 <syscall>
  8019c3:	83 c4 18             	add    $0x18,%esp
  8019c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8019c9:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8019cd:	75 07                	jne    8019d6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8019cf:	b8 01 00 00 00       	mov    $0x1,%eax
  8019d4:	eb 05                	jmp    8019db <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8019d6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019db:	c9                   	leave  
  8019dc:	c3                   	ret    

008019dd <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8019dd:	55                   	push   %ebp
  8019de:	89 e5                	mov    %esp,%ebp
  8019e0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 00                	push   $0x0
  8019e9:	6a 00                	push   $0x0
  8019eb:	6a 00                	push   $0x0
  8019ed:	6a 2c                	push   $0x2c
  8019ef:	e8 7c fa ff ff       	call   801470 <syscall>
  8019f4:	83 c4 18             	add    $0x18,%esp
  8019f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8019fa:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8019fe:	75 07                	jne    801a07 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801a00:	b8 01 00 00 00       	mov    $0x1,%eax
  801a05:	eb 05                	jmp    801a0c <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801a07:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a0c:	c9                   	leave  
  801a0d:	c3                   	ret    

00801a0e <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801a0e:	55                   	push   %ebp
  801a0f:	89 e5                	mov    %esp,%ebp
  801a11:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a14:	6a 00                	push   $0x0
  801a16:	6a 00                	push   $0x0
  801a18:	6a 00                	push   $0x0
  801a1a:	6a 00                	push   $0x0
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 2c                	push   $0x2c
  801a20:	e8 4b fa ff ff       	call   801470 <syscall>
  801a25:	83 c4 18             	add    $0x18,%esp
  801a28:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801a2b:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801a2f:	75 07                	jne    801a38 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801a31:	b8 01 00 00 00       	mov    $0x1,%eax
  801a36:	eb 05                	jmp    801a3d <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801a38:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a3d:	c9                   	leave  
  801a3e:	c3                   	ret    

00801a3f <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801a3f:	55                   	push   %ebp
  801a40:	89 e5                	mov    %esp,%ebp
  801a42:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a45:	6a 00                	push   $0x0
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	6a 00                	push   $0x0
  801a4d:	6a 00                	push   $0x0
  801a4f:	6a 2c                	push   $0x2c
  801a51:	e8 1a fa ff ff       	call   801470 <syscall>
  801a56:	83 c4 18             	add    $0x18,%esp
  801a59:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801a5c:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801a60:	75 07                	jne    801a69 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801a62:	b8 01 00 00 00       	mov    $0x1,%eax
  801a67:	eb 05                	jmp    801a6e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801a69:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a6e:	c9                   	leave  
  801a6f:	c3                   	ret    

00801a70 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a70:	55                   	push   %ebp
  801a71:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a73:	6a 00                	push   $0x0
  801a75:	6a 00                	push   $0x0
  801a77:	6a 00                	push   $0x0
  801a79:	6a 00                	push   $0x0
  801a7b:	ff 75 08             	pushl  0x8(%ebp)
  801a7e:	6a 2d                	push   $0x2d
  801a80:	e8 eb f9 ff ff       	call   801470 <syscall>
  801a85:	83 c4 18             	add    $0x18,%esp
	return ;
  801a88:	90                   	nop
}
  801a89:	c9                   	leave  
  801a8a:	c3                   	ret    

00801a8b <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801a8b:	55                   	push   %ebp
  801a8c:	89 e5                	mov    %esp,%ebp
  801a8e:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801a8f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a92:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a95:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a98:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9b:	6a 00                	push   $0x0
  801a9d:	53                   	push   %ebx
  801a9e:	51                   	push   %ecx
  801a9f:	52                   	push   %edx
  801aa0:	50                   	push   %eax
  801aa1:	6a 2e                	push   $0x2e
  801aa3:	e8 c8 f9 ff ff       	call   801470 <syscall>
  801aa8:	83 c4 18             	add    $0x18,%esp
}
  801aab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801aae:	c9                   	leave  
  801aaf:	c3                   	ret    

00801ab0 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801ab0:	55                   	push   %ebp
  801ab1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801ab3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 00                	push   $0x0
  801abd:	6a 00                	push   $0x0
  801abf:	52                   	push   %edx
  801ac0:	50                   	push   %eax
  801ac1:	6a 2f                	push   $0x2f
  801ac3:	e8 a8 f9 ff ff       	call   801470 <syscall>
  801ac8:	83 c4 18             	add    $0x18,%esp
}
  801acb:	c9                   	leave  
  801acc:	c3                   	ret    
  801acd:	66 90                	xchg   %ax,%ax
  801acf:	90                   	nop

00801ad0 <__udivdi3>:
  801ad0:	55                   	push   %ebp
  801ad1:	57                   	push   %edi
  801ad2:	56                   	push   %esi
  801ad3:	53                   	push   %ebx
  801ad4:	83 ec 1c             	sub    $0x1c,%esp
  801ad7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801adb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801adf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ae3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801ae7:	89 ca                	mov    %ecx,%edx
  801ae9:	89 f8                	mov    %edi,%eax
  801aeb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801aef:	85 f6                	test   %esi,%esi
  801af1:	75 2d                	jne    801b20 <__udivdi3+0x50>
  801af3:	39 cf                	cmp    %ecx,%edi
  801af5:	77 65                	ja     801b5c <__udivdi3+0x8c>
  801af7:	89 fd                	mov    %edi,%ebp
  801af9:	85 ff                	test   %edi,%edi
  801afb:	75 0b                	jne    801b08 <__udivdi3+0x38>
  801afd:	b8 01 00 00 00       	mov    $0x1,%eax
  801b02:	31 d2                	xor    %edx,%edx
  801b04:	f7 f7                	div    %edi
  801b06:	89 c5                	mov    %eax,%ebp
  801b08:	31 d2                	xor    %edx,%edx
  801b0a:	89 c8                	mov    %ecx,%eax
  801b0c:	f7 f5                	div    %ebp
  801b0e:	89 c1                	mov    %eax,%ecx
  801b10:	89 d8                	mov    %ebx,%eax
  801b12:	f7 f5                	div    %ebp
  801b14:	89 cf                	mov    %ecx,%edi
  801b16:	89 fa                	mov    %edi,%edx
  801b18:	83 c4 1c             	add    $0x1c,%esp
  801b1b:	5b                   	pop    %ebx
  801b1c:	5e                   	pop    %esi
  801b1d:	5f                   	pop    %edi
  801b1e:	5d                   	pop    %ebp
  801b1f:	c3                   	ret    
  801b20:	39 ce                	cmp    %ecx,%esi
  801b22:	77 28                	ja     801b4c <__udivdi3+0x7c>
  801b24:	0f bd fe             	bsr    %esi,%edi
  801b27:	83 f7 1f             	xor    $0x1f,%edi
  801b2a:	75 40                	jne    801b6c <__udivdi3+0x9c>
  801b2c:	39 ce                	cmp    %ecx,%esi
  801b2e:	72 0a                	jb     801b3a <__udivdi3+0x6a>
  801b30:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b34:	0f 87 9e 00 00 00    	ja     801bd8 <__udivdi3+0x108>
  801b3a:	b8 01 00 00 00       	mov    $0x1,%eax
  801b3f:	89 fa                	mov    %edi,%edx
  801b41:	83 c4 1c             	add    $0x1c,%esp
  801b44:	5b                   	pop    %ebx
  801b45:	5e                   	pop    %esi
  801b46:	5f                   	pop    %edi
  801b47:	5d                   	pop    %ebp
  801b48:	c3                   	ret    
  801b49:	8d 76 00             	lea    0x0(%esi),%esi
  801b4c:	31 ff                	xor    %edi,%edi
  801b4e:	31 c0                	xor    %eax,%eax
  801b50:	89 fa                	mov    %edi,%edx
  801b52:	83 c4 1c             	add    $0x1c,%esp
  801b55:	5b                   	pop    %ebx
  801b56:	5e                   	pop    %esi
  801b57:	5f                   	pop    %edi
  801b58:	5d                   	pop    %ebp
  801b59:	c3                   	ret    
  801b5a:	66 90                	xchg   %ax,%ax
  801b5c:	89 d8                	mov    %ebx,%eax
  801b5e:	f7 f7                	div    %edi
  801b60:	31 ff                	xor    %edi,%edi
  801b62:	89 fa                	mov    %edi,%edx
  801b64:	83 c4 1c             	add    $0x1c,%esp
  801b67:	5b                   	pop    %ebx
  801b68:	5e                   	pop    %esi
  801b69:	5f                   	pop    %edi
  801b6a:	5d                   	pop    %ebp
  801b6b:	c3                   	ret    
  801b6c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b71:	89 eb                	mov    %ebp,%ebx
  801b73:	29 fb                	sub    %edi,%ebx
  801b75:	89 f9                	mov    %edi,%ecx
  801b77:	d3 e6                	shl    %cl,%esi
  801b79:	89 c5                	mov    %eax,%ebp
  801b7b:	88 d9                	mov    %bl,%cl
  801b7d:	d3 ed                	shr    %cl,%ebp
  801b7f:	89 e9                	mov    %ebp,%ecx
  801b81:	09 f1                	or     %esi,%ecx
  801b83:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b87:	89 f9                	mov    %edi,%ecx
  801b89:	d3 e0                	shl    %cl,%eax
  801b8b:	89 c5                	mov    %eax,%ebp
  801b8d:	89 d6                	mov    %edx,%esi
  801b8f:	88 d9                	mov    %bl,%cl
  801b91:	d3 ee                	shr    %cl,%esi
  801b93:	89 f9                	mov    %edi,%ecx
  801b95:	d3 e2                	shl    %cl,%edx
  801b97:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b9b:	88 d9                	mov    %bl,%cl
  801b9d:	d3 e8                	shr    %cl,%eax
  801b9f:	09 c2                	or     %eax,%edx
  801ba1:	89 d0                	mov    %edx,%eax
  801ba3:	89 f2                	mov    %esi,%edx
  801ba5:	f7 74 24 0c          	divl   0xc(%esp)
  801ba9:	89 d6                	mov    %edx,%esi
  801bab:	89 c3                	mov    %eax,%ebx
  801bad:	f7 e5                	mul    %ebp
  801baf:	39 d6                	cmp    %edx,%esi
  801bb1:	72 19                	jb     801bcc <__udivdi3+0xfc>
  801bb3:	74 0b                	je     801bc0 <__udivdi3+0xf0>
  801bb5:	89 d8                	mov    %ebx,%eax
  801bb7:	31 ff                	xor    %edi,%edi
  801bb9:	e9 58 ff ff ff       	jmp    801b16 <__udivdi3+0x46>
  801bbe:	66 90                	xchg   %ax,%ax
  801bc0:	8b 54 24 08          	mov    0x8(%esp),%edx
  801bc4:	89 f9                	mov    %edi,%ecx
  801bc6:	d3 e2                	shl    %cl,%edx
  801bc8:	39 c2                	cmp    %eax,%edx
  801bca:	73 e9                	jae    801bb5 <__udivdi3+0xe5>
  801bcc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801bcf:	31 ff                	xor    %edi,%edi
  801bd1:	e9 40 ff ff ff       	jmp    801b16 <__udivdi3+0x46>
  801bd6:	66 90                	xchg   %ax,%ax
  801bd8:	31 c0                	xor    %eax,%eax
  801bda:	e9 37 ff ff ff       	jmp    801b16 <__udivdi3+0x46>
  801bdf:	90                   	nop

00801be0 <__umoddi3>:
  801be0:	55                   	push   %ebp
  801be1:	57                   	push   %edi
  801be2:	56                   	push   %esi
  801be3:	53                   	push   %ebx
  801be4:	83 ec 1c             	sub    $0x1c,%esp
  801be7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801beb:	8b 74 24 34          	mov    0x34(%esp),%esi
  801bef:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801bf3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801bf7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801bfb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801bff:	89 f3                	mov    %esi,%ebx
  801c01:	89 fa                	mov    %edi,%edx
  801c03:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c07:	89 34 24             	mov    %esi,(%esp)
  801c0a:	85 c0                	test   %eax,%eax
  801c0c:	75 1a                	jne    801c28 <__umoddi3+0x48>
  801c0e:	39 f7                	cmp    %esi,%edi
  801c10:	0f 86 a2 00 00 00    	jbe    801cb8 <__umoddi3+0xd8>
  801c16:	89 c8                	mov    %ecx,%eax
  801c18:	89 f2                	mov    %esi,%edx
  801c1a:	f7 f7                	div    %edi
  801c1c:	89 d0                	mov    %edx,%eax
  801c1e:	31 d2                	xor    %edx,%edx
  801c20:	83 c4 1c             	add    $0x1c,%esp
  801c23:	5b                   	pop    %ebx
  801c24:	5e                   	pop    %esi
  801c25:	5f                   	pop    %edi
  801c26:	5d                   	pop    %ebp
  801c27:	c3                   	ret    
  801c28:	39 f0                	cmp    %esi,%eax
  801c2a:	0f 87 ac 00 00 00    	ja     801cdc <__umoddi3+0xfc>
  801c30:	0f bd e8             	bsr    %eax,%ebp
  801c33:	83 f5 1f             	xor    $0x1f,%ebp
  801c36:	0f 84 ac 00 00 00    	je     801ce8 <__umoddi3+0x108>
  801c3c:	bf 20 00 00 00       	mov    $0x20,%edi
  801c41:	29 ef                	sub    %ebp,%edi
  801c43:	89 fe                	mov    %edi,%esi
  801c45:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c49:	89 e9                	mov    %ebp,%ecx
  801c4b:	d3 e0                	shl    %cl,%eax
  801c4d:	89 d7                	mov    %edx,%edi
  801c4f:	89 f1                	mov    %esi,%ecx
  801c51:	d3 ef                	shr    %cl,%edi
  801c53:	09 c7                	or     %eax,%edi
  801c55:	89 e9                	mov    %ebp,%ecx
  801c57:	d3 e2                	shl    %cl,%edx
  801c59:	89 14 24             	mov    %edx,(%esp)
  801c5c:	89 d8                	mov    %ebx,%eax
  801c5e:	d3 e0                	shl    %cl,%eax
  801c60:	89 c2                	mov    %eax,%edx
  801c62:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c66:	d3 e0                	shl    %cl,%eax
  801c68:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c6c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c70:	89 f1                	mov    %esi,%ecx
  801c72:	d3 e8                	shr    %cl,%eax
  801c74:	09 d0                	or     %edx,%eax
  801c76:	d3 eb                	shr    %cl,%ebx
  801c78:	89 da                	mov    %ebx,%edx
  801c7a:	f7 f7                	div    %edi
  801c7c:	89 d3                	mov    %edx,%ebx
  801c7e:	f7 24 24             	mull   (%esp)
  801c81:	89 c6                	mov    %eax,%esi
  801c83:	89 d1                	mov    %edx,%ecx
  801c85:	39 d3                	cmp    %edx,%ebx
  801c87:	0f 82 87 00 00 00    	jb     801d14 <__umoddi3+0x134>
  801c8d:	0f 84 91 00 00 00    	je     801d24 <__umoddi3+0x144>
  801c93:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c97:	29 f2                	sub    %esi,%edx
  801c99:	19 cb                	sbb    %ecx,%ebx
  801c9b:	89 d8                	mov    %ebx,%eax
  801c9d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ca1:	d3 e0                	shl    %cl,%eax
  801ca3:	89 e9                	mov    %ebp,%ecx
  801ca5:	d3 ea                	shr    %cl,%edx
  801ca7:	09 d0                	or     %edx,%eax
  801ca9:	89 e9                	mov    %ebp,%ecx
  801cab:	d3 eb                	shr    %cl,%ebx
  801cad:	89 da                	mov    %ebx,%edx
  801caf:	83 c4 1c             	add    $0x1c,%esp
  801cb2:	5b                   	pop    %ebx
  801cb3:	5e                   	pop    %esi
  801cb4:	5f                   	pop    %edi
  801cb5:	5d                   	pop    %ebp
  801cb6:	c3                   	ret    
  801cb7:	90                   	nop
  801cb8:	89 fd                	mov    %edi,%ebp
  801cba:	85 ff                	test   %edi,%edi
  801cbc:	75 0b                	jne    801cc9 <__umoddi3+0xe9>
  801cbe:	b8 01 00 00 00       	mov    $0x1,%eax
  801cc3:	31 d2                	xor    %edx,%edx
  801cc5:	f7 f7                	div    %edi
  801cc7:	89 c5                	mov    %eax,%ebp
  801cc9:	89 f0                	mov    %esi,%eax
  801ccb:	31 d2                	xor    %edx,%edx
  801ccd:	f7 f5                	div    %ebp
  801ccf:	89 c8                	mov    %ecx,%eax
  801cd1:	f7 f5                	div    %ebp
  801cd3:	89 d0                	mov    %edx,%eax
  801cd5:	e9 44 ff ff ff       	jmp    801c1e <__umoddi3+0x3e>
  801cda:	66 90                	xchg   %ax,%ax
  801cdc:	89 c8                	mov    %ecx,%eax
  801cde:	89 f2                	mov    %esi,%edx
  801ce0:	83 c4 1c             	add    $0x1c,%esp
  801ce3:	5b                   	pop    %ebx
  801ce4:	5e                   	pop    %esi
  801ce5:	5f                   	pop    %edi
  801ce6:	5d                   	pop    %ebp
  801ce7:	c3                   	ret    
  801ce8:	3b 04 24             	cmp    (%esp),%eax
  801ceb:	72 06                	jb     801cf3 <__umoddi3+0x113>
  801ced:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801cf1:	77 0f                	ja     801d02 <__umoddi3+0x122>
  801cf3:	89 f2                	mov    %esi,%edx
  801cf5:	29 f9                	sub    %edi,%ecx
  801cf7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801cfb:	89 14 24             	mov    %edx,(%esp)
  801cfe:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d02:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d06:	8b 14 24             	mov    (%esp),%edx
  801d09:	83 c4 1c             	add    $0x1c,%esp
  801d0c:	5b                   	pop    %ebx
  801d0d:	5e                   	pop    %esi
  801d0e:	5f                   	pop    %edi
  801d0f:	5d                   	pop    %ebp
  801d10:	c3                   	ret    
  801d11:	8d 76 00             	lea    0x0(%esi),%esi
  801d14:	2b 04 24             	sub    (%esp),%eax
  801d17:	19 fa                	sbb    %edi,%edx
  801d19:	89 d1                	mov    %edx,%ecx
  801d1b:	89 c6                	mov    %eax,%esi
  801d1d:	e9 71 ff ff ff       	jmp    801c93 <__umoddi3+0xb3>
  801d22:	66 90                	xchg   %ax,%ax
  801d24:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d28:	72 ea                	jb     801d14 <__umoddi3+0x134>
  801d2a:	89 d9                	mov    %ebx,%ecx
  801d2c:	e9 62 ff ff ff       	jmp    801c93 <__umoddi3+0xb3>
