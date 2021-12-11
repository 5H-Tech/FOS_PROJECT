
obj/user/tst_page_replacement_lru:     file format elf32-i386


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
  800031:	e8 f6 02 00 00       	call   80032c <libmain>
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
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	83 ec 6c             	sub    $0x6c,%esp
//	cprintf("envID = %d\n",envID);


	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800041:	a1 20 30 80 00       	mov    0x803020,%eax
  800046:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80004c:	8b 00                	mov    (%eax),%eax
  80004e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800051:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800054:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800059:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005e:	74 14                	je     800074 <_main+0x3c>
  800060:	83 ec 04             	sub    $0x4,%esp
  800063:	68 60 1d 80 00       	push   $0x801d60
  800068:	6a 13                	push   $0x13
  80006a:	68 a4 1d 80 00       	push   $0x801da4
  80006f:	e8 fd 03 00 00       	call   800471 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800074:	a1 20 30 80 00       	mov    0x803020,%eax
  800079:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80007f:	83 c0 10             	add    $0x10,%eax
  800082:	8b 00                	mov    (%eax),%eax
  800084:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800087:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80008a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008f:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800094:	74 14                	je     8000aa <_main+0x72>
  800096:	83 ec 04             	sub    $0x4,%esp
  800099:	68 60 1d 80 00       	push   $0x801d60
  80009e:	6a 14                	push   $0x14
  8000a0:	68 a4 1d 80 00       	push   $0x801da4
  8000a5:	e8 c7 03 00 00       	call   800471 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000aa:	a1 20 30 80 00       	mov    0x803020,%eax
  8000af:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000b5:	83 c0 20             	add    $0x20,%eax
  8000b8:	8b 00                	mov    (%eax),%eax
  8000ba:	89 45 d8             	mov    %eax,-0x28(%ebp)
  8000bd:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000c0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c5:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000ca:	74 14                	je     8000e0 <_main+0xa8>
  8000cc:	83 ec 04             	sub    $0x4,%esp
  8000cf:	68 60 1d 80 00       	push   $0x801d60
  8000d4:	6a 15                	push   $0x15
  8000d6:	68 a4 1d 80 00       	push   $0x801da4
  8000db:	e8 91 03 00 00       	call   800471 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e5:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000eb:	83 c0 30             	add    $0x30,%eax
  8000ee:	8b 00                	mov    (%eax),%eax
  8000f0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8000f3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000fb:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800100:	74 14                	je     800116 <_main+0xde>
  800102:	83 ec 04             	sub    $0x4,%esp
  800105:	68 60 1d 80 00       	push   $0x801d60
  80010a:	6a 16                	push   $0x16
  80010c:	68 a4 1d 80 00       	push   $0x801da4
  800111:	e8 5b 03 00 00       	call   800471 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800116:	a1 20 30 80 00       	mov    0x803020,%eax
  80011b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800121:	83 c0 40             	add    $0x40,%eax
  800124:	8b 00                	mov    (%eax),%eax
  800126:	89 45 d0             	mov    %eax,-0x30(%ebp)
  800129:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80012c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800131:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800136:	74 14                	je     80014c <_main+0x114>
  800138:	83 ec 04             	sub    $0x4,%esp
  80013b:	68 60 1d 80 00       	push   $0x801d60
  800140:	6a 17                	push   $0x17
  800142:	68 a4 1d 80 00       	push   $0x801da4
  800147:	e8 25 03 00 00       	call   800471 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80014c:	a1 20 30 80 00       	mov    0x803020,%eax
  800151:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800157:	83 c0 50             	add    $0x50,%eax
  80015a:	8b 00                	mov    (%eax),%eax
  80015c:	89 45 cc             	mov    %eax,-0x34(%ebp)
  80015f:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800162:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800167:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016c:	74 14                	je     800182 <_main+0x14a>
  80016e:	83 ec 04             	sub    $0x4,%esp
  800171:	68 60 1d 80 00       	push   $0x801d60
  800176:	6a 18                	push   $0x18
  800178:	68 a4 1d 80 00       	push   $0x801da4
  80017d:	e8 ef 02 00 00       	call   800471 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800182:	a1 20 30 80 00       	mov    0x803020,%eax
  800187:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80018d:	83 c0 60             	add    $0x60,%eax
  800190:	8b 00                	mov    (%eax),%eax
  800192:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800195:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800198:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019d:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a2:	74 14                	je     8001b8 <_main+0x180>
  8001a4:	83 ec 04             	sub    $0x4,%esp
  8001a7:	68 60 1d 80 00       	push   $0x801d60
  8001ac:	6a 19                	push   $0x19
  8001ae:	68 a4 1d 80 00       	push   $0x801da4
  8001b3:	e8 b9 02 00 00       	call   800471 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bd:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001c3:	83 c0 70             	add    $0x70,%eax
  8001c6:	8b 00                	mov    (%eax),%eax
  8001c8:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  8001cb:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001ce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d3:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d8:	74 14                	je     8001ee <_main+0x1b6>
  8001da:	83 ec 04             	sub    $0x4,%esp
  8001dd:	68 60 1d 80 00       	push   $0x801d60
  8001e2:	6a 1a                	push   $0x1a
  8001e4:	68 a4 1d 80 00       	push   $0x801da4
  8001e9:	e8 83 02 00 00       	call   800471 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001f9:	83 e8 80             	sub    $0xffffff80,%eax
  8001fc:	8b 00                	mov    (%eax),%eax
  8001fe:	89 45 c0             	mov    %eax,-0x40(%ebp)
  800201:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800204:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800209:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020e:	74 14                	je     800224 <_main+0x1ec>
  800210:	83 ec 04             	sub    $0x4,%esp
  800213:	68 60 1d 80 00       	push   $0x801d60
  800218:	6a 1b                	push   $0x1b
  80021a:	68 a4 1d 80 00       	push   $0x801da4
  80021f:	e8 4d 02 00 00       	call   800471 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800224:	a1 20 30 80 00       	mov    0x803020,%eax
  800229:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80022f:	05 90 00 00 00       	add    $0x90,%eax
  800234:	8b 00                	mov    (%eax),%eax
  800236:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800239:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80023c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800241:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800246:	74 14                	je     80025c <_main+0x224>
  800248:	83 ec 04             	sub    $0x4,%esp
  80024b:	68 60 1d 80 00       	push   $0x801d60
  800250:	6a 1c                	push   $0x1c
  800252:	68 a4 1d 80 00       	push   $0x801da4
  800257:	e8 15 02 00 00       	call   800471 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80025c:	a1 20 30 80 00       	mov    0x803020,%eax
  800261:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800267:	05 a0 00 00 00       	add    $0xa0,%eax
  80026c:	8b 00                	mov    (%eax),%eax
  80026e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800271:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800274:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800279:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80027e:	74 14                	je     800294 <_main+0x25c>
  800280:	83 ec 04             	sub    $0x4,%esp
  800283:	68 60 1d 80 00       	push   $0x801d60
  800288:	6a 1d                	push   $0x1d
  80028a:	68 a4 1d 80 00       	push   $0x801da4
  80028f:	e8 dd 01 00 00       	call   800471 <_panic>
		/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
		//if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
	}

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  800294:	a0 3f e0 80 00       	mov    0x80e03f,%al
  800299:	88 45 b7             	mov    %al,-0x49(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  80029c:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8002a1:	88 45 b6             	mov    %al,-0x4a(%ebp)

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002a4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8002ab:	eb 37                	jmp    8002e4 <_main+0x2ac>
	{
		arr[i] = -1 ;
  8002ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002b0:	05 40 30 80 00       	add    $0x803040,%eax
  8002b5:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  8002b8:	a1 04 30 80 00       	mov    0x803004,%eax
  8002bd:	8b 15 00 30 80 00    	mov    0x803000,%edx
  8002c3:	8a 12                	mov    (%edx),%dl
  8002c5:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  8002c7:	a1 00 30 80 00       	mov    0x803000,%eax
  8002cc:	40                   	inc    %eax
  8002cd:	a3 00 30 80 00       	mov    %eax,0x803000
  8002d2:	a1 04 30 80 00       	mov    0x803004,%eax
  8002d7:	40                   	inc    %eax
  8002d8:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1] ;
	char garbage2 = arr[PAGE_SIZE*12-1] ;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002dd:	81 45 e4 00 08 00 00 	addl   $0x800,-0x1c(%ebp)
  8002e4:	81 7d e4 ff 9f 00 00 	cmpl   $0x9fff,-0x1c(%ebp)
  8002eb:	7e c0                	jle    8002ad <_main+0x275>
		ptr++ ; ptr2++ ;
	}

	//===================

	uint32 expectedPages[11] = {0x809000,0x80a000,0x804000,0x80b000,0x80c000,0x800000,0x801000,0x808000,0x803000,0xeebfd000,0};
  8002ed:	8d 45 88             	lea    -0x78(%ebp),%eax
  8002f0:	bb 20 1e 80 00       	mov    $0x801e20,%ebx
  8002f5:	ba 0b 00 00 00       	mov    $0xb,%edx
  8002fa:	89 c7                	mov    %eax,%edi
  8002fc:	89 de                	mov    %ebx,%esi
  8002fe:	89 d1                	mov    %edx,%ecx
  800300:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	//cprintf("Checking PAGE LRU algorithm... \n");
	{
		CheckWSWithoutLastIndex(expectedPages, 11);
  800302:	83 ec 08             	sub    $0x8,%esp
  800305:	6a 0b                	push   $0xb
  800307:	8d 45 88             	lea    -0x78(%ebp),%eax
  80030a:	50                   	push   %eax
  80030b:	e8 d3 01 00 00       	call   8004e3 <CheckWSWithoutLastIndex>
  800310:	83 c4 10             	add    $0x10,%esp
		/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
		//if(myEnv->page_last_WS_index != 5) panic("wrong PAGE WS pointer location");

	}

	cprintf("Congratulations!! test PAGE replacement [LRU Alg.] is completed successfully.\n");
  800313:	83 ec 0c             	sub    $0xc,%esp
  800316:	68 c4 1d 80 00       	push   $0x801dc4
  80031b:	e8 f3 03 00 00       	call   800713 <cprintf>
  800320:	83 c4 10             	add    $0x10,%esp
	return;
  800323:	90                   	nop
}
  800324:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800327:	5b                   	pop    %ebx
  800328:	5e                   	pop    %esi
  800329:	5f                   	pop    %edi
  80032a:	5d                   	pop    %ebp
  80032b:	c3                   	ret    

0080032c <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80032c:	55                   	push   %ebp
  80032d:	89 e5                	mov    %esp,%ebp
  80032f:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800332:	e8 07 12 00 00       	call   80153e <sys_getenvindex>
  800337:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80033a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80033d:	89 d0                	mov    %edx,%eax
  80033f:	c1 e0 03             	shl    $0x3,%eax
  800342:	01 d0                	add    %edx,%eax
  800344:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80034b:	01 c8                	add    %ecx,%eax
  80034d:	01 c0                	add    %eax,%eax
  80034f:	01 d0                	add    %edx,%eax
  800351:	01 c0                	add    %eax,%eax
  800353:	01 d0                	add    %edx,%eax
  800355:	89 c2                	mov    %eax,%edx
  800357:	c1 e2 05             	shl    $0x5,%edx
  80035a:	29 c2                	sub    %eax,%edx
  80035c:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800363:	89 c2                	mov    %eax,%edx
  800365:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80036b:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800370:	a1 20 30 80 00       	mov    0x803020,%eax
  800375:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80037b:	84 c0                	test   %al,%al
  80037d:	74 0f                	je     80038e <libmain+0x62>
		binaryname = myEnv->prog_name;
  80037f:	a1 20 30 80 00       	mov    0x803020,%eax
  800384:	05 40 3c 01 00       	add    $0x13c40,%eax
  800389:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80038e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800392:	7e 0a                	jle    80039e <libmain+0x72>
		binaryname = argv[0];
  800394:	8b 45 0c             	mov    0xc(%ebp),%eax
  800397:	8b 00                	mov    (%eax),%eax
  800399:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  80039e:	83 ec 08             	sub    $0x8,%esp
  8003a1:	ff 75 0c             	pushl  0xc(%ebp)
  8003a4:	ff 75 08             	pushl  0x8(%ebp)
  8003a7:	e8 8c fc ff ff       	call   800038 <_main>
  8003ac:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8003af:	e8 25 13 00 00       	call   8016d9 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8003b4:	83 ec 0c             	sub    $0xc,%esp
  8003b7:	68 64 1e 80 00       	push   $0x801e64
  8003bc:	e8 52 03 00 00       	call   800713 <cprintf>
  8003c1:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003c4:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c9:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8003cf:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d4:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8003da:	83 ec 04             	sub    $0x4,%esp
  8003dd:	52                   	push   %edx
  8003de:	50                   	push   %eax
  8003df:	68 8c 1e 80 00       	push   $0x801e8c
  8003e4:	e8 2a 03 00 00       	call   800713 <cprintf>
  8003e9:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8003ec:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f1:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8003f7:	a1 20 30 80 00       	mov    0x803020,%eax
  8003fc:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800402:	83 ec 04             	sub    $0x4,%esp
  800405:	52                   	push   %edx
  800406:	50                   	push   %eax
  800407:	68 b4 1e 80 00       	push   $0x801eb4
  80040c:	e8 02 03 00 00       	call   800713 <cprintf>
  800411:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800414:	a1 20 30 80 00       	mov    0x803020,%eax
  800419:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80041f:	83 ec 08             	sub    $0x8,%esp
  800422:	50                   	push   %eax
  800423:	68 f5 1e 80 00       	push   $0x801ef5
  800428:	e8 e6 02 00 00       	call   800713 <cprintf>
  80042d:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800430:	83 ec 0c             	sub    $0xc,%esp
  800433:	68 64 1e 80 00       	push   $0x801e64
  800438:	e8 d6 02 00 00       	call   800713 <cprintf>
  80043d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800440:	e8 ae 12 00 00       	call   8016f3 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800445:	e8 19 00 00 00       	call   800463 <exit>
}
  80044a:	90                   	nop
  80044b:	c9                   	leave  
  80044c:	c3                   	ret    

0080044d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80044d:	55                   	push   %ebp
  80044e:	89 e5                	mov    %esp,%ebp
  800450:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800453:	83 ec 0c             	sub    $0xc,%esp
  800456:	6a 00                	push   $0x0
  800458:	e8 ad 10 00 00       	call   80150a <sys_env_destroy>
  80045d:	83 c4 10             	add    $0x10,%esp
}
  800460:	90                   	nop
  800461:	c9                   	leave  
  800462:	c3                   	ret    

00800463 <exit>:

void
exit(void)
{
  800463:	55                   	push   %ebp
  800464:	89 e5                	mov    %esp,%ebp
  800466:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800469:	e8 02 11 00 00       	call   801570 <sys_env_exit>
}
  80046e:	90                   	nop
  80046f:	c9                   	leave  
  800470:	c3                   	ret    

00800471 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800471:	55                   	push   %ebp
  800472:	89 e5                	mov    %esp,%ebp
  800474:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800477:	8d 45 10             	lea    0x10(%ebp),%eax
  80047a:	83 c0 04             	add    $0x4,%eax
  80047d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800480:	a1 18 f1 80 00       	mov    0x80f118,%eax
  800485:	85 c0                	test   %eax,%eax
  800487:	74 16                	je     80049f <_panic+0x2e>
		cprintf("%s: ", argv0);
  800489:	a1 18 f1 80 00       	mov    0x80f118,%eax
  80048e:	83 ec 08             	sub    $0x8,%esp
  800491:	50                   	push   %eax
  800492:	68 0c 1f 80 00       	push   $0x801f0c
  800497:	e8 77 02 00 00       	call   800713 <cprintf>
  80049c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80049f:	a1 08 30 80 00       	mov    0x803008,%eax
  8004a4:	ff 75 0c             	pushl  0xc(%ebp)
  8004a7:	ff 75 08             	pushl  0x8(%ebp)
  8004aa:	50                   	push   %eax
  8004ab:	68 11 1f 80 00       	push   $0x801f11
  8004b0:	e8 5e 02 00 00       	call   800713 <cprintf>
  8004b5:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8004b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8004bb:	83 ec 08             	sub    $0x8,%esp
  8004be:	ff 75 f4             	pushl  -0xc(%ebp)
  8004c1:	50                   	push   %eax
  8004c2:	e8 e1 01 00 00       	call   8006a8 <vcprintf>
  8004c7:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8004ca:	83 ec 08             	sub    $0x8,%esp
  8004cd:	6a 00                	push   $0x0
  8004cf:	68 2d 1f 80 00       	push   $0x801f2d
  8004d4:	e8 cf 01 00 00       	call   8006a8 <vcprintf>
  8004d9:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8004dc:	e8 82 ff ff ff       	call   800463 <exit>

	// should not return here
	while (1) ;
  8004e1:	eb fe                	jmp    8004e1 <_panic+0x70>

008004e3 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8004e3:	55                   	push   %ebp
  8004e4:	89 e5                	mov    %esp,%ebp
  8004e6:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8004e9:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ee:	8b 50 74             	mov    0x74(%eax),%edx
  8004f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f4:	39 c2                	cmp    %eax,%edx
  8004f6:	74 14                	je     80050c <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8004f8:	83 ec 04             	sub    $0x4,%esp
  8004fb:	68 30 1f 80 00       	push   $0x801f30
  800500:	6a 26                	push   $0x26
  800502:	68 7c 1f 80 00       	push   $0x801f7c
  800507:	e8 65 ff ff ff       	call   800471 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80050c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800513:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80051a:	e9 b6 00 00 00       	jmp    8005d5 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80051f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800522:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800529:	8b 45 08             	mov    0x8(%ebp),%eax
  80052c:	01 d0                	add    %edx,%eax
  80052e:	8b 00                	mov    (%eax),%eax
  800530:	85 c0                	test   %eax,%eax
  800532:	75 08                	jne    80053c <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800534:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800537:	e9 96 00 00 00       	jmp    8005d2 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80053c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800543:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80054a:	eb 5d                	jmp    8005a9 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80054c:	a1 20 30 80 00       	mov    0x803020,%eax
  800551:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800557:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80055a:	c1 e2 04             	shl    $0x4,%edx
  80055d:	01 d0                	add    %edx,%eax
  80055f:	8a 40 04             	mov    0x4(%eax),%al
  800562:	84 c0                	test   %al,%al
  800564:	75 40                	jne    8005a6 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800566:	a1 20 30 80 00       	mov    0x803020,%eax
  80056b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800571:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800574:	c1 e2 04             	shl    $0x4,%edx
  800577:	01 d0                	add    %edx,%eax
  800579:	8b 00                	mov    (%eax),%eax
  80057b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80057e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800581:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800586:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800588:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80058b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800592:	8b 45 08             	mov    0x8(%ebp),%eax
  800595:	01 c8                	add    %ecx,%eax
  800597:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800599:	39 c2                	cmp    %eax,%edx
  80059b:	75 09                	jne    8005a6 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80059d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8005a4:	eb 12                	jmp    8005b8 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005a6:	ff 45 e8             	incl   -0x18(%ebp)
  8005a9:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ae:	8b 50 74             	mov    0x74(%eax),%edx
  8005b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005b4:	39 c2                	cmp    %eax,%edx
  8005b6:	77 94                	ja     80054c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8005b8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8005bc:	75 14                	jne    8005d2 <CheckWSWithoutLastIndex+0xef>
			panic(
  8005be:	83 ec 04             	sub    $0x4,%esp
  8005c1:	68 88 1f 80 00       	push   $0x801f88
  8005c6:	6a 3a                	push   $0x3a
  8005c8:	68 7c 1f 80 00       	push   $0x801f7c
  8005cd:	e8 9f fe ff ff       	call   800471 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8005d2:	ff 45 f0             	incl   -0x10(%ebp)
  8005d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005d8:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005db:	0f 8c 3e ff ff ff    	jl     80051f <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8005e1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005e8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8005ef:	eb 20                	jmp    800611 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8005f1:	a1 20 30 80 00       	mov    0x803020,%eax
  8005f6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8005fc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005ff:	c1 e2 04             	shl    $0x4,%edx
  800602:	01 d0                	add    %edx,%eax
  800604:	8a 40 04             	mov    0x4(%eax),%al
  800607:	3c 01                	cmp    $0x1,%al
  800609:	75 03                	jne    80060e <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80060b:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80060e:	ff 45 e0             	incl   -0x20(%ebp)
  800611:	a1 20 30 80 00       	mov    0x803020,%eax
  800616:	8b 50 74             	mov    0x74(%eax),%edx
  800619:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80061c:	39 c2                	cmp    %eax,%edx
  80061e:	77 d1                	ja     8005f1 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800620:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800623:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800626:	74 14                	je     80063c <CheckWSWithoutLastIndex+0x159>
		panic(
  800628:	83 ec 04             	sub    $0x4,%esp
  80062b:	68 dc 1f 80 00       	push   $0x801fdc
  800630:	6a 44                	push   $0x44
  800632:	68 7c 1f 80 00       	push   $0x801f7c
  800637:	e8 35 fe ff ff       	call   800471 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80063c:	90                   	nop
  80063d:	c9                   	leave  
  80063e:	c3                   	ret    

0080063f <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80063f:	55                   	push   %ebp
  800640:	89 e5                	mov    %esp,%ebp
  800642:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800645:	8b 45 0c             	mov    0xc(%ebp),%eax
  800648:	8b 00                	mov    (%eax),%eax
  80064a:	8d 48 01             	lea    0x1(%eax),%ecx
  80064d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800650:	89 0a                	mov    %ecx,(%edx)
  800652:	8b 55 08             	mov    0x8(%ebp),%edx
  800655:	88 d1                	mov    %dl,%cl
  800657:	8b 55 0c             	mov    0xc(%ebp),%edx
  80065a:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80065e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800661:	8b 00                	mov    (%eax),%eax
  800663:	3d ff 00 00 00       	cmp    $0xff,%eax
  800668:	75 2c                	jne    800696 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80066a:	a0 24 30 80 00       	mov    0x803024,%al
  80066f:	0f b6 c0             	movzbl %al,%eax
  800672:	8b 55 0c             	mov    0xc(%ebp),%edx
  800675:	8b 12                	mov    (%edx),%edx
  800677:	89 d1                	mov    %edx,%ecx
  800679:	8b 55 0c             	mov    0xc(%ebp),%edx
  80067c:	83 c2 08             	add    $0x8,%edx
  80067f:	83 ec 04             	sub    $0x4,%esp
  800682:	50                   	push   %eax
  800683:	51                   	push   %ecx
  800684:	52                   	push   %edx
  800685:	e8 3e 0e 00 00       	call   8014c8 <sys_cputs>
  80068a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80068d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800690:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800696:	8b 45 0c             	mov    0xc(%ebp),%eax
  800699:	8b 40 04             	mov    0x4(%eax),%eax
  80069c:	8d 50 01             	lea    0x1(%eax),%edx
  80069f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006a2:	89 50 04             	mov    %edx,0x4(%eax)
}
  8006a5:	90                   	nop
  8006a6:	c9                   	leave  
  8006a7:	c3                   	ret    

008006a8 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8006a8:	55                   	push   %ebp
  8006a9:	89 e5                	mov    %esp,%ebp
  8006ab:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8006b1:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8006b8:	00 00 00 
	b.cnt = 0;
  8006bb:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8006c2:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8006c5:	ff 75 0c             	pushl  0xc(%ebp)
  8006c8:	ff 75 08             	pushl  0x8(%ebp)
  8006cb:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006d1:	50                   	push   %eax
  8006d2:	68 3f 06 80 00       	push   $0x80063f
  8006d7:	e8 11 02 00 00       	call   8008ed <vprintfmt>
  8006dc:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8006df:	a0 24 30 80 00       	mov    0x803024,%al
  8006e4:	0f b6 c0             	movzbl %al,%eax
  8006e7:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8006ed:	83 ec 04             	sub    $0x4,%esp
  8006f0:	50                   	push   %eax
  8006f1:	52                   	push   %edx
  8006f2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006f8:	83 c0 08             	add    $0x8,%eax
  8006fb:	50                   	push   %eax
  8006fc:	e8 c7 0d 00 00       	call   8014c8 <sys_cputs>
  800701:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800704:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80070b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800711:	c9                   	leave  
  800712:	c3                   	ret    

00800713 <cprintf>:

int cprintf(const char *fmt, ...) {
  800713:	55                   	push   %ebp
  800714:	89 e5                	mov    %esp,%ebp
  800716:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800719:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800720:	8d 45 0c             	lea    0xc(%ebp),%eax
  800723:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800726:	8b 45 08             	mov    0x8(%ebp),%eax
  800729:	83 ec 08             	sub    $0x8,%esp
  80072c:	ff 75 f4             	pushl  -0xc(%ebp)
  80072f:	50                   	push   %eax
  800730:	e8 73 ff ff ff       	call   8006a8 <vcprintf>
  800735:	83 c4 10             	add    $0x10,%esp
  800738:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80073b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80073e:	c9                   	leave  
  80073f:	c3                   	ret    

00800740 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800740:	55                   	push   %ebp
  800741:	89 e5                	mov    %esp,%ebp
  800743:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800746:	e8 8e 0f 00 00       	call   8016d9 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80074b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80074e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800751:	8b 45 08             	mov    0x8(%ebp),%eax
  800754:	83 ec 08             	sub    $0x8,%esp
  800757:	ff 75 f4             	pushl  -0xc(%ebp)
  80075a:	50                   	push   %eax
  80075b:	e8 48 ff ff ff       	call   8006a8 <vcprintf>
  800760:	83 c4 10             	add    $0x10,%esp
  800763:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800766:	e8 88 0f 00 00       	call   8016f3 <sys_enable_interrupt>
	return cnt;
  80076b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80076e:	c9                   	leave  
  80076f:	c3                   	ret    

00800770 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800770:	55                   	push   %ebp
  800771:	89 e5                	mov    %esp,%ebp
  800773:	53                   	push   %ebx
  800774:	83 ec 14             	sub    $0x14,%esp
  800777:	8b 45 10             	mov    0x10(%ebp),%eax
  80077a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80077d:	8b 45 14             	mov    0x14(%ebp),%eax
  800780:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800783:	8b 45 18             	mov    0x18(%ebp),%eax
  800786:	ba 00 00 00 00       	mov    $0x0,%edx
  80078b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80078e:	77 55                	ja     8007e5 <printnum+0x75>
  800790:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800793:	72 05                	jb     80079a <printnum+0x2a>
  800795:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800798:	77 4b                	ja     8007e5 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80079a:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80079d:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8007a0:	8b 45 18             	mov    0x18(%ebp),%eax
  8007a3:	ba 00 00 00 00       	mov    $0x0,%edx
  8007a8:	52                   	push   %edx
  8007a9:	50                   	push   %eax
  8007aa:	ff 75 f4             	pushl  -0xc(%ebp)
  8007ad:	ff 75 f0             	pushl  -0x10(%ebp)
  8007b0:	e8 47 13 00 00       	call   801afc <__udivdi3>
  8007b5:	83 c4 10             	add    $0x10,%esp
  8007b8:	83 ec 04             	sub    $0x4,%esp
  8007bb:	ff 75 20             	pushl  0x20(%ebp)
  8007be:	53                   	push   %ebx
  8007bf:	ff 75 18             	pushl  0x18(%ebp)
  8007c2:	52                   	push   %edx
  8007c3:	50                   	push   %eax
  8007c4:	ff 75 0c             	pushl  0xc(%ebp)
  8007c7:	ff 75 08             	pushl  0x8(%ebp)
  8007ca:	e8 a1 ff ff ff       	call   800770 <printnum>
  8007cf:	83 c4 20             	add    $0x20,%esp
  8007d2:	eb 1a                	jmp    8007ee <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8007d4:	83 ec 08             	sub    $0x8,%esp
  8007d7:	ff 75 0c             	pushl  0xc(%ebp)
  8007da:	ff 75 20             	pushl  0x20(%ebp)
  8007dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e0:	ff d0                	call   *%eax
  8007e2:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8007e5:	ff 4d 1c             	decl   0x1c(%ebp)
  8007e8:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8007ec:	7f e6                	jg     8007d4 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8007ee:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8007f1:	bb 00 00 00 00       	mov    $0x0,%ebx
  8007f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007fc:	53                   	push   %ebx
  8007fd:	51                   	push   %ecx
  8007fe:	52                   	push   %edx
  8007ff:	50                   	push   %eax
  800800:	e8 07 14 00 00       	call   801c0c <__umoddi3>
  800805:	83 c4 10             	add    $0x10,%esp
  800808:	05 54 22 80 00       	add    $0x802254,%eax
  80080d:	8a 00                	mov    (%eax),%al
  80080f:	0f be c0             	movsbl %al,%eax
  800812:	83 ec 08             	sub    $0x8,%esp
  800815:	ff 75 0c             	pushl  0xc(%ebp)
  800818:	50                   	push   %eax
  800819:	8b 45 08             	mov    0x8(%ebp),%eax
  80081c:	ff d0                	call   *%eax
  80081e:	83 c4 10             	add    $0x10,%esp
}
  800821:	90                   	nop
  800822:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800825:	c9                   	leave  
  800826:	c3                   	ret    

00800827 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800827:	55                   	push   %ebp
  800828:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80082a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80082e:	7e 1c                	jle    80084c <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800830:	8b 45 08             	mov    0x8(%ebp),%eax
  800833:	8b 00                	mov    (%eax),%eax
  800835:	8d 50 08             	lea    0x8(%eax),%edx
  800838:	8b 45 08             	mov    0x8(%ebp),%eax
  80083b:	89 10                	mov    %edx,(%eax)
  80083d:	8b 45 08             	mov    0x8(%ebp),%eax
  800840:	8b 00                	mov    (%eax),%eax
  800842:	83 e8 08             	sub    $0x8,%eax
  800845:	8b 50 04             	mov    0x4(%eax),%edx
  800848:	8b 00                	mov    (%eax),%eax
  80084a:	eb 40                	jmp    80088c <getuint+0x65>
	else if (lflag)
  80084c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800850:	74 1e                	je     800870 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800852:	8b 45 08             	mov    0x8(%ebp),%eax
  800855:	8b 00                	mov    (%eax),%eax
  800857:	8d 50 04             	lea    0x4(%eax),%edx
  80085a:	8b 45 08             	mov    0x8(%ebp),%eax
  80085d:	89 10                	mov    %edx,(%eax)
  80085f:	8b 45 08             	mov    0x8(%ebp),%eax
  800862:	8b 00                	mov    (%eax),%eax
  800864:	83 e8 04             	sub    $0x4,%eax
  800867:	8b 00                	mov    (%eax),%eax
  800869:	ba 00 00 00 00       	mov    $0x0,%edx
  80086e:	eb 1c                	jmp    80088c <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800870:	8b 45 08             	mov    0x8(%ebp),%eax
  800873:	8b 00                	mov    (%eax),%eax
  800875:	8d 50 04             	lea    0x4(%eax),%edx
  800878:	8b 45 08             	mov    0x8(%ebp),%eax
  80087b:	89 10                	mov    %edx,(%eax)
  80087d:	8b 45 08             	mov    0x8(%ebp),%eax
  800880:	8b 00                	mov    (%eax),%eax
  800882:	83 e8 04             	sub    $0x4,%eax
  800885:	8b 00                	mov    (%eax),%eax
  800887:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80088c:	5d                   	pop    %ebp
  80088d:	c3                   	ret    

0080088e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80088e:	55                   	push   %ebp
  80088f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800891:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800895:	7e 1c                	jle    8008b3 <getint+0x25>
		return va_arg(*ap, long long);
  800897:	8b 45 08             	mov    0x8(%ebp),%eax
  80089a:	8b 00                	mov    (%eax),%eax
  80089c:	8d 50 08             	lea    0x8(%eax),%edx
  80089f:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a2:	89 10                	mov    %edx,(%eax)
  8008a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a7:	8b 00                	mov    (%eax),%eax
  8008a9:	83 e8 08             	sub    $0x8,%eax
  8008ac:	8b 50 04             	mov    0x4(%eax),%edx
  8008af:	8b 00                	mov    (%eax),%eax
  8008b1:	eb 38                	jmp    8008eb <getint+0x5d>
	else if (lflag)
  8008b3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008b7:	74 1a                	je     8008d3 <getint+0x45>
		return va_arg(*ap, long);
  8008b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008bc:	8b 00                	mov    (%eax),%eax
  8008be:	8d 50 04             	lea    0x4(%eax),%edx
  8008c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c4:	89 10                	mov    %edx,(%eax)
  8008c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c9:	8b 00                	mov    (%eax),%eax
  8008cb:	83 e8 04             	sub    $0x4,%eax
  8008ce:	8b 00                	mov    (%eax),%eax
  8008d0:	99                   	cltd   
  8008d1:	eb 18                	jmp    8008eb <getint+0x5d>
	else
		return va_arg(*ap, int);
  8008d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d6:	8b 00                	mov    (%eax),%eax
  8008d8:	8d 50 04             	lea    0x4(%eax),%edx
  8008db:	8b 45 08             	mov    0x8(%ebp),%eax
  8008de:	89 10                	mov    %edx,(%eax)
  8008e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e3:	8b 00                	mov    (%eax),%eax
  8008e5:	83 e8 04             	sub    $0x4,%eax
  8008e8:	8b 00                	mov    (%eax),%eax
  8008ea:	99                   	cltd   
}
  8008eb:	5d                   	pop    %ebp
  8008ec:	c3                   	ret    

008008ed <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8008ed:	55                   	push   %ebp
  8008ee:	89 e5                	mov    %esp,%ebp
  8008f0:	56                   	push   %esi
  8008f1:	53                   	push   %ebx
  8008f2:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008f5:	eb 17                	jmp    80090e <vprintfmt+0x21>
			if (ch == '\0')
  8008f7:	85 db                	test   %ebx,%ebx
  8008f9:	0f 84 af 03 00 00    	je     800cae <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8008ff:	83 ec 08             	sub    $0x8,%esp
  800902:	ff 75 0c             	pushl  0xc(%ebp)
  800905:	53                   	push   %ebx
  800906:	8b 45 08             	mov    0x8(%ebp),%eax
  800909:	ff d0                	call   *%eax
  80090b:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80090e:	8b 45 10             	mov    0x10(%ebp),%eax
  800911:	8d 50 01             	lea    0x1(%eax),%edx
  800914:	89 55 10             	mov    %edx,0x10(%ebp)
  800917:	8a 00                	mov    (%eax),%al
  800919:	0f b6 d8             	movzbl %al,%ebx
  80091c:	83 fb 25             	cmp    $0x25,%ebx
  80091f:	75 d6                	jne    8008f7 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800921:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800925:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80092c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800933:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80093a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800941:	8b 45 10             	mov    0x10(%ebp),%eax
  800944:	8d 50 01             	lea    0x1(%eax),%edx
  800947:	89 55 10             	mov    %edx,0x10(%ebp)
  80094a:	8a 00                	mov    (%eax),%al
  80094c:	0f b6 d8             	movzbl %al,%ebx
  80094f:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800952:	83 f8 55             	cmp    $0x55,%eax
  800955:	0f 87 2b 03 00 00    	ja     800c86 <vprintfmt+0x399>
  80095b:	8b 04 85 78 22 80 00 	mov    0x802278(,%eax,4),%eax
  800962:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800964:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800968:	eb d7                	jmp    800941 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80096a:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80096e:	eb d1                	jmp    800941 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800970:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800977:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80097a:	89 d0                	mov    %edx,%eax
  80097c:	c1 e0 02             	shl    $0x2,%eax
  80097f:	01 d0                	add    %edx,%eax
  800981:	01 c0                	add    %eax,%eax
  800983:	01 d8                	add    %ebx,%eax
  800985:	83 e8 30             	sub    $0x30,%eax
  800988:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80098b:	8b 45 10             	mov    0x10(%ebp),%eax
  80098e:	8a 00                	mov    (%eax),%al
  800990:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800993:	83 fb 2f             	cmp    $0x2f,%ebx
  800996:	7e 3e                	jle    8009d6 <vprintfmt+0xe9>
  800998:	83 fb 39             	cmp    $0x39,%ebx
  80099b:	7f 39                	jg     8009d6 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80099d:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8009a0:	eb d5                	jmp    800977 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8009a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8009a5:	83 c0 04             	add    $0x4,%eax
  8009a8:	89 45 14             	mov    %eax,0x14(%ebp)
  8009ab:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ae:	83 e8 04             	sub    $0x4,%eax
  8009b1:	8b 00                	mov    (%eax),%eax
  8009b3:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8009b6:	eb 1f                	jmp    8009d7 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8009b8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009bc:	79 83                	jns    800941 <vprintfmt+0x54>
				width = 0;
  8009be:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8009c5:	e9 77 ff ff ff       	jmp    800941 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8009ca:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8009d1:	e9 6b ff ff ff       	jmp    800941 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8009d6:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8009d7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009db:	0f 89 60 ff ff ff    	jns    800941 <vprintfmt+0x54>
				width = precision, precision = -1;
  8009e1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8009e7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8009ee:	e9 4e ff ff ff       	jmp    800941 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8009f3:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8009f6:	e9 46 ff ff ff       	jmp    800941 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8009fb:	8b 45 14             	mov    0x14(%ebp),%eax
  8009fe:	83 c0 04             	add    $0x4,%eax
  800a01:	89 45 14             	mov    %eax,0x14(%ebp)
  800a04:	8b 45 14             	mov    0x14(%ebp),%eax
  800a07:	83 e8 04             	sub    $0x4,%eax
  800a0a:	8b 00                	mov    (%eax),%eax
  800a0c:	83 ec 08             	sub    $0x8,%esp
  800a0f:	ff 75 0c             	pushl  0xc(%ebp)
  800a12:	50                   	push   %eax
  800a13:	8b 45 08             	mov    0x8(%ebp),%eax
  800a16:	ff d0                	call   *%eax
  800a18:	83 c4 10             	add    $0x10,%esp
			break;
  800a1b:	e9 89 02 00 00       	jmp    800ca9 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a20:	8b 45 14             	mov    0x14(%ebp),%eax
  800a23:	83 c0 04             	add    $0x4,%eax
  800a26:	89 45 14             	mov    %eax,0x14(%ebp)
  800a29:	8b 45 14             	mov    0x14(%ebp),%eax
  800a2c:	83 e8 04             	sub    $0x4,%eax
  800a2f:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a31:	85 db                	test   %ebx,%ebx
  800a33:	79 02                	jns    800a37 <vprintfmt+0x14a>
				err = -err;
  800a35:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a37:	83 fb 64             	cmp    $0x64,%ebx
  800a3a:	7f 0b                	jg     800a47 <vprintfmt+0x15a>
  800a3c:	8b 34 9d c0 20 80 00 	mov    0x8020c0(,%ebx,4),%esi
  800a43:	85 f6                	test   %esi,%esi
  800a45:	75 19                	jne    800a60 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a47:	53                   	push   %ebx
  800a48:	68 65 22 80 00       	push   $0x802265
  800a4d:	ff 75 0c             	pushl  0xc(%ebp)
  800a50:	ff 75 08             	pushl  0x8(%ebp)
  800a53:	e8 5e 02 00 00       	call   800cb6 <printfmt>
  800a58:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a5b:	e9 49 02 00 00       	jmp    800ca9 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a60:	56                   	push   %esi
  800a61:	68 6e 22 80 00       	push   $0x80226e
  800a66:	ff 75 0c             	pushl  0xc(%ebp)
  800a69:	ff 75 08             	pushl  0x8(%ebp)
  800a6c:	e8 45 02 00 00       	call   800cb6 <printfmt>
  800a71:	83 c4 10             	add    $0x10,%esp
			break;
  800a74:	e9 30 02 00 00       	jmp    800ca9 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a79:	8b 45 14             	mov    0x14(%ebp),%eax
  800a7c:	83 c0 04             	add    $0x4,%eax
  800a7f:	89 45 14             	mov    %eax,0x14(%ebp)
  800a82:	8b 45 14             	mov    0x14(%ebp),%eax
  800a85:	83 e8 04             	sub    $0x4,%eax
  800a88:	8b 30                	mov    (%eax),%esi
  800a8a:	85 f6                	test   %esi,%esi
  800a8c:	75 05                	jne    800a93 <vprintfmt+0x1a6>
				p = "(null)";
  800a8e:	be 71 22 80 00       	mov    $0x802271,%esi
			if (width > 0 && padc != '-')
  800a93:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a97:	7e 6d                	jle    800b06 <vprintfmt+0x219>
  800a99:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a9d:	74 67                	je     800b06 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a9f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800aa2:	83 ec 08             	sub    $0x8,%esp
  800aa5:	50                   	push   %eax
  800aa6:	56                   	push   %esi
  800aa7:	e8 0c 03 00 00       	call   800db8 <strnlen>
  800aac:	83 c4 10             	add    $0x10,%esp
  800aaf:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800ab2:	eb 16                	jmp    800aca <vprintfmt+0x1dd>
					putch(padc, putdat);
  800ab4:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800ab8:	83 ec 08             	sub    $0x8,%esp
  800abb:	ff 75 0c             	pushl  0xc(%ebp)
  800abe:	50                   	push   %eax
  800abf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac2:	ff d0                	call   *%eax
  800ac4:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800ac7:	ff 4d e4             	decl   -0x1c(%ebp)
  800aca:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ace:	7f e4                	jg     800ab4 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ad0:	eb 34                	jmp    800b06 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800ad2:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800ad6:	74 1c                	je     800af4 <vprintfmt+0x207>
  800ad8:	83 fb 1f             	cmp    $0x1f,%ebx
  800adb:	7e 05                	jle    800ae2 <vprintfmt+0x1f5>
  800add:	83 fb 7e             	cmp    $0x7e,%ebx
  800ae0:	7e 12                	jle    800af4 <vprintfmt+0x207>
					putch('?', putdat);
  800ae2:	83 ec 08             	sub    $0x8,%esp
  800ae5:	ff 75 0c             	pushl  0xc(%ebp)
  800ae8:	6a 3f                	push   $0x3f
  800aea:	8b 45 08             	mov    0x8(%ebp),%eax
  800aed:	ff d0                	call   *%eax
  800aef:	83 c4 10             	add    $0x10,%esp
  800af2:	eb 0f                	jmp    800b03 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800af4:	83 ec 08             	sub    $0x8,%esp
  800af7:	ff 75 0c             	pushl  0xc(%ebp)
  800afa:	53                   	push   %ebx
  800afb:	8b 45 08             	mov    0x8(%ebp),%eax
  800afe:	ff d0                	call   *%eax
  800b00:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b03:	ff 4d e4             	decl   -0x1c(%ebp)
  800b06:	89 f0                	mov    %esi,%eax
  800b08:	8d 70 01             	lea    0x1(%eax),%esi
  800b0b:	8a 00                	mov    (%eax),%al
  800b0d:	0f be d8             	movsbl %al,%ebx
  800b10:	85 db                	test   %ebx,%ebx
  800b12:	74 24                	je     800b38 <vprintfmt+0x24b>
  800b14:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b18:	78 b8                	js     800ad2 <vprintfmt+0x1e5>
  800b1a:	ff 4d e0             	decl   -0x20(%ebp)
  800b1d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b21:	79 af                	jns    800ad2 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b23:	eb 13                	jmp    800b38 <vprintfmt+0x24b>
				putch(' ', putdat);
  800b25:	83 ec 08             	sub    $0x8,%esp
  800b28:	ff 75 0c             	pushl  0xc(%ebp)
  800b2b:	6a 20                	push   $0x20
  800b2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b30:	ff d0                	call   *%eax
  800b32:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b35:	ff 4d e4             	decl   -0x1c(%ebp)
  800b38:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b3c:	7f e7                	jg     800b25 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b3e:	e9 66 01 00 00       	jmp    800ca9 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b43:	83 ec 08             	sub    $0x8,%esp
  800b46:	ff 75 e8             	pushl  -0x18(%ebp)
  800b49:	8d 45 14             	lea    0x14(%ebp),%eax
  800b4c:	50                   	push   %eax
  800b4d:	e8 3c fd ff ff       	call   80088e <getint>
  800b52:	83 c4 10             	add    $0x10,%esp
  800b55:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b58:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b5e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b61:	85 d2                	test   %edx,%edx
  800b63:	79 23                	jns    800b88 <vprintfmt+0x29b>
				putch('-', putdat);
  800b65:	83 ec 08             	sub    $0x8,%esp
  800b68:	ff 75 0c             	pushl  0xc(%ebp)
  800b6b:	6a 2d                	push   $0x2d
  800b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b70:	ff d0                	call   *%eax
  800b72:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b75:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b78:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b7b:	f7 d8                	neg    %eax
  800b7d:	83 d2 00             	adc    $0x0,%edx
  800b80:	f7 da                	neg    %edx
  800b82:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b85:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b88:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b8f:	e9 bc 00 00 00       	jmp    800c50 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b94:	83 ec 08             	sub    $0x8,%esp
  800b97:	ff 75 e8             	pushl  -0x18(%ebp)
  800b9a:	8d 45 14             	lea    0x14(%ebp),%eax
  800b9d:	50                   	push   %eax
  800b9e:	e8 84 fc ff ff       	call   800827 <getuint>
  800ba3:	83 c4 10             	add    $0x10,%esp
  800ba6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ba9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800bac:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bb3:	e9 98 00 00 00       	jmp    800c50 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800bb8:	83 ec 08             	sub    $0x8,%esp
  800bbb:	ff 75 0c             	pushl  0xc(%ebp)
  800bbe:	6a 58                	push   $0x58
  800bc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc3:	ff d0                	call   *%eax
  800bc5:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bc8:	83 ec 08             	sub    $0x8,%esp
  800bcb:	ff 75 0c             	pushl  0xc(%ebp)
  800bce:	6a 58                	push   $0x58
  800bd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd3:	ff d0                	call   *%eax
  800bd5:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bd8:	83 ec 08             	sub    $0x8,%esp
  800bdb:	ff 75 0c             	pushl  0xc(%ebp)
  800bde:	6a 58                	push   $0x58
  800be0:	8b 45 08             	mov    0x8(%ebp),%eax
  800be3:	ff d0                	call   *%eax
  800be5:	83 c4 10             	add    $0x10,%esp
			break;
  800be8:	e9 bc 00 00 00       	jmp    800ca9 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800bed:	83 ec 08             	sub    $0x8,%esp
  800bf0:	ff 75 0c             	pushl  0xc(%ebp)
  800bf3:	6a 30                	push   $0x30
  800bf5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf8:	ff d0                	call   *%eax
  800bfa:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800bfd:	83 ec 08             	sub    $0x8,%esp
  800c00:	ff 75 0c             	pushl  0xc(%ebp)
  800c03:	6a 78                	push   $0x78
  800c05:	8b 45 08             	mov    0x8(%ebp),%eax
  800c08:	ff d0                	call   *%eax
  800c0a:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c0d:	8b 45 14             	mov    0x14(%ebp),%eax
  800c10:	83 c0 04             	add    $0x4,%eax
  800c13:	89 45 14             	mov    %eax,0x14(%ebp)
  800c16:	8b 45 14             	mov    0x14(%ebp),%eax
  800c19:	83 e8 04             	sub    $0x4,%eax
  800c1c:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c21:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c28:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c2f:	eb 1f                	jmp    800c50 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c31:	83 ec 08             	sub    $0x8,%esp
  800c34:	ff 75 e8             	pushl  -0x18(%ebp)
  800c37:	8d 45 14             	lea    0x14(%ebp),%eax
  800c3a:	50                   	push   %eax
  800c3b:	e8 e7 fb ff ff       	call   800827 <getuint>
  800c40:	83 c4 10             	add    $0x10,%esp
  800c43:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c46:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c49:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c50:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c54:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c57:	83 ec 04             	sub    $0x4,%esp
  800c5a:	52                   	push   %edx
  800c5b:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c5e:	50                   	push   %eax
  800c5f:	ff 75 f4             	pushl  -0xc(%ebp)
  800c62:	ff 75 f0             	pushl  -0x10(%ebp)
  800c65:	ff 75 0c             	pushl  0xc(%ebp)
  800c68:	ff 75 08             	pushl  0x8(%ebp)
  800c6b:	e8 00 fb ff ff       	call   800770 <printnum>
  800c70:	83 c4 20             	add    $0x20,%esp
			break;
  800c73:	eb 34                	jmp    800ca9 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c75:	83 ec 08             	sub    $0x8,%esp
  800c78:	ff 75 0c             	pushl  0xc(%ebp)
  800c7b:	53                   	push   %ebx
  800c7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7f:	ff d0                	call   *%eax
  800c81:	83 c4 10             	add    $0x10,%esp
			break;
  800c84:	eb 23                	jmp    800ca9 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c86:	83 ec 08             	sub    $0x8,%esp
  800c89:	ff 75 0c             	pushl  0xc(%ebp)
  800c8c:	6a 25                	push   $0x25
  800c8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c91:	ff d0                	call   *%eax
  800c93:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c96:	ff 4d 10             	decl   0x10(%ebp)
  800c99:	eb 03                	jmp    800c9e <vprintfmt+0x3b1>
  800c9b:	ff 4d 10             	decl   0x10(%ebp)
  800c9e:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca1:	48                   	dec    %eax
  800ca2:	8a 00                	mov    (%eax),%al
  800ca4:	3c 25                	cmp    $0x25,%al
  800ca6:	75 f3                	jne    800c9b <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ca8:	90                   	nop
		}
	}
  800ca9:	e9 47 fc ff ff       	jmp    8008f5 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800cae:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800caf:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800cb2:	5b                   	pop    %ebx
  800cb3:	5e                   	pop    %esi
  800cb4:	5d                   	pop    %ebp
  800cb5:	c3                   	ret    

00800cb6 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800cb6:	55                   	push   %ebp
  800cb7:	89 e5                	mov    %esp,%ebp
  800cb9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800cbc:	8d 45 10             	lea    0x10(%ebp),%eax
  800cbf:	83 c0 04             	add    $0x4,%eax
  800cc2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800cc5:	8b 45 10             	mov    0x10(%ebp),%eax
  800cc8:	ff 75 f4             	pushl  -0xc(%ebp)
  800ccb:	50                   	push   %eax
  800ccc:	ff 75 0c             	pushl  0xc(%ebp)
  800ccf:	ff 75 08             	pushl  0x8(%ebp)
  800cd2:	e8 16 fc ff ff       	call   8008ed <vprintfmt>
  800cd7:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800cda:	90                   	nop
  800cdb:	c9                   	leave  
  800cdc:	c3                   	ret    

00800cdd <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800cdd:	55                   	push   %ebp
  800cde:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ce0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce3:	8b 40 08             	mov    0x8(%eax),%eax
  800ce6:	8d 50 01             	lea    0x1(%eax),%edx
  800ce9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cec:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800cef:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf2:	8b 10                	mov    (%eax),%edx
  800cf4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf7:	8b 40 04             	mov    0x4(%eax),%eax
  800cfa:	39 c2                	cmp    %eax,%edx
  800cfc:	73 12                	jae    800d10 <sprintputch+0x33>
		*b->buf++ = ch;
  800cfe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d01:	8b 00                	mov    (%eax),%eax
  800d03:	8d 48 01             	lea    0x1(%eax),%ecx
  800d06:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d09:	89 0a                	mov    %ecx,(%edx)
  800d0b:	8b 55 08             	mov    0x8(%ebp),%edx
  800d0e:	88 10                	mov    %dl,(%eax)
}
  800d10:	90                   	nop
  800d11:	5d                   	pop    %ebp
  800d12:	c3                   	ret    

00800d13 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d13:	55                   	push   %ebp
  800d14:	89 e5                	mov    %esp,%ebp
  800d16:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d19:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d22:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d25:	8b 45 08             	mov    0x8(%ebp),%eax
  800d28:	01 d0                	add    %edx,%eax
  800d2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d2d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d34:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d38:	74 06                	je     800d40 <vsnprintf+0x2d>
  800d3a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d3e:	7f 07                	jg     800d47 <vsnprintf+0x34>
		return -E_INVAL;
  800d40:	b8 03 00 00 00       	mov    $0x3,%eax
  800d45:	eb 20                	jmp    800d67 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d47:	ff 75 14             	pushl  0x14(%ebp)
  800d4a:	ff 75 10             	pushl  0x10(%ebp)
  800d4d:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d50:	50                   	push   %eax
  800d51:	68 dd 0c 80 00       	push   $0x800cdd
  800d56:	e8 92 fb ff ff       	call   8008ed <vprintfmt>
  800d5b:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d5e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d61:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d64:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d67:	c9                   	leave  
  800d68:	c3                   	ret    

00800d69 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d69:	55                   	push   %ebp
  800d6a:	89 e5                	mov    %esp,%ebp
  800d6c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d6f:	8d 45 10             	lea    0x10(%ebp),%eax
  800d72:	83 c0 04             	add    $0x4,%eax
  800d75:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d78:	8b 45 10             	mov    0x10(%ebp),%eax
  800d7b:	ff 75 f4             	pushl  -0xc(%ebp)
  800d7e:	50                   	push   %eax
  800d7f:	ff 75 0c             	pushl  0xc(%ebp)
  800d82:	ff 75 08             	pushl  0x8(%ebp)
  800d85:	e8 89 ff ff ff       	call   800d13 <vsnprintf>
  800d8a:	83 c4 10             	add    $0x10,%esp
  800d8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d90:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d93:	c9                   	leave  
  800d94:	c3                   	ret    

00800d95 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d95:	55                   	push   %ebp
  800d96:	89 e5                	mov    %esp,%ebp
  800d98:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d9b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800da2:	eb 06                	jmp    800daa <strlen+0x15>
		n++;
  800da4:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800da7:	ff 45 08             	incl   0x8(%ebp)
  800daa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dad:	8a 00                	mov    (%eax),%al
  800daf:	84 c0                	test   %al,%al
  800db1:	75 f1                	jne    800da4 <strlen+0xf>
		n++;
	return n;
  800db3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800db6:	c9                   	leave  
  800db7:	c3                   	ret    

00800db8 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800db8:	55                   	push   %ebp
  800db9:	89 e5                	mov    %esp,%ebp
  800dbb:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800dbe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800dc5:	eb 09                	jmp    800dd0 <strnlen+0x18>
		n++;
  800dc7:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800dca:	ff 45 08             	incl   0x8(%ebp)
  800dcd:	ff 4d 0c             	decl   0xc(%ebp)
  800dd0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dd4:	74 09                	je     800ddf <strnlen+0x27>
  800dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd9:	8a 00                	mov    (%eax),%al
  800ddb:	84 c0                	test   %al,%al
  800ddd:	75 e8                	jne    800dc7 <strnlen+0xf>
		n++;
	return n;
  800ddf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800de2:	c9                   	leave  
  800de3:	c3                   	ret    

00800de4 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800de4:	55                   	push   %ebp
  800de5:	89 e5                	mov    %esp,%ebp
  800de7:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800dea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ded:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800df0:	90                   	nop
  800df1:	8b 45 08             	mov    0x8(%ebp),%eax
  800df4:	8d 50 01             	lea    0x1(%eax),%edx
  800df7:	89 55 08             	mov    %edx,0x8(%ebp)
  800dfa:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dfd:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e00:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e03:	8a 12                	mov    (%edx),%dl
  800e05:	88 10                	mov    %dl,(%eax)
  800e07:	8a 00                	mov    (%eax),%al
  800e09:	84 c0                	test   %al,%al
  800e0b:	75 e4                	jne    800df1 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e10:	c9                   	leave  
  800e11:	c3                   	ret    

00800e12 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e12:	55                   	push   %ebp
  800e13:	89 e5                	mov    %esp,%ebp
  800e15:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e18:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e1e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e25:	eb 1f                	jmp    800e46 <strncpy+0x34>
		*dst++ = *src;
  800e27:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2a:	8d 50 01             	lea    0x1(%eax),%edx
  800e2d:	89 55 08             	mov    %edx,0x8(%ebp)
  800e30:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e33:	8a 12                	mov    (%edx),%dl
  800e35:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3a:	8a 00                	mov    (%eax),%al
  800e3c:	84 c0                	test   %al,%al
  800e3e:	74 03                	je     800e43 <strncpy+0x31>
			src++;
  800e40:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e43:	ff 45 fc             	incl   -0x4(%ebp)
  800e46:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e49:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e4c:	72 d9                	jb     800e27 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e4e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e51:	c9                   	leave  
  800e52:	c3                   	ret    

00800e53 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e53:	55                   	push   %ebp
  800e54:	89 e5                	mov    %esp,%ebp
  800e56:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e59:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e5f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e63:	74 30                	je     800e95 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e65:	eb 16                	jmp    800e7d <strlcpy+0x2a>
			*dst++ = *src++;
  800e67:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6a:	8d 50 01             	lea    0x1(%eax),%edx
  800e6d:	89 55 08             	mov    %edx,0x8(%ebp)
  800e70:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e73:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e76:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e79:	8a 12                	mov    (%edx),%dl
  800e7b:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e7d:	ff 4d 10             	decl   0x10(%ebp)
  800e80:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e84:	74 09                	je     800e8f <strlcpy+0x3c>
  800e86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e89:	8a 00                	mov    (%eax),%al
  800e8b:	84 c0                	test   %al,%al
  800e8d:	75 d8                	jne    800e67 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e92:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e95:	8b 55 08             	mov    0x8(%ebp),%edx
  800e98:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e9b:	29 c2                	sub    %eax,%edx
  800e9d:	89 d0                	mov    %edx,%eax
}
  800e9f:	c9                   	leave  
  800ea0:	c3                   	ret    

00800ea1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ea1:	55                   	push   %ebp
  800ea2:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ea4:	eb 06                	jmp    800eac <strcmp+0xb>
		p++, q++;
  800ea6:	ff 45 08             	incl   0x8(%ebp)
  800ea9:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800eac:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaf:	8a 00                	mov    (%eax),%al
  800eb1:	84 c0                	test   %al,%al
  800eb3:	74 0e                	je     800ec3 <strcmp+0x22>
  800eb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb8:	8a 10                	mov    (%eax),%dl
  800eba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebd:	8a 00                	mov    (%eax),%al
  800ebf:	38 c2                	cmp    %al,%dl
  800ec1:	74 e3                	je     800ea6 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ec3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec6:	8a 00                	mov    (%eax),%al
  800ec8:	0f b6 d0             	movzbl %al,%edx
  800ecb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ece:	8a 00                	mov    (%eax),%al
  800ed0:	0f b6 c0             	movzbl %al,%eax
  800ed3:	29 c2                	sub    %eax,%edx
  800ed5:	89 d0                	mov    %edx,%eax
}
  800ed7:	5d                   	pop    %ebp
  800ed8:	c3                   	ret    

00800ed9 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ed9:	55                   	push   %ebp
  800eda:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800edc:	eb 09                	jmp    800ee7 <strncmp+0xe>
		n--, p++, q++;
  800ede:	ff 4d 10             	decl   0x10(%ebp)
  800ee1:	ff 45 08             	incl   0x8(%ebp)
  800ee4:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ee7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eeb:	74 17                	je     800f04 <strncmp+0x2b>
  800eed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef0:	8a 00                	mov    (%eax),%al
  800ef2:	84 c0                	test   %al,%al
  800ef4:	74 0e                	je     800f04 <strncmp+0x2b>
  800ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef9:	8a 10                	mov    (%eax),%dl
  800efb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efe:	8a 00                	mov    (%eax),%al
  800f00:	38 c2                	cmp    %al,%dl
  800f02:	74 da                	je     800ede <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f04:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f08:	75 07                	jne    800f11 <strncmp+0x38>
		return 0;
  800f0a:	b8 00 00 00 00       	mov    $0x0,%eax
  800f0f:	eb 14                	jmp    800f25 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f11:	8b 45 08             	mov    0x8(%ebp),%eax
  800f14:	8a 00                	mov    (%eax),%al
  800f16:	0f b6 d0             	movzbl %al,%edx
  800f19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1c:	8a 00                	mov    (%eax),%al
  800f1e:	0f b6 c0             	movzbl %al,%eax
  800f21:	29 c2                	sub    %eax,%edx
  800f23:	89 d0                	mov    %edx,%eax
}
  800f25:	5d                   	pop    %ebp
  800f26:	c3                   	ret    

00800f27 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f27:	55                   	push   %ebp
  800f28:	89 e5                	mov    %esp,%ebp
  800f2a:	83 ec 04             	sub    $0x4,%esp
  800f2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f30:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f33:	eb 12                	jmp    800f47 <strchr+0x20>
		if (*s == c)
  800f35:	8b 45 08             	mov    0x8(%ebp),%eax
  800f38:	8a 00                	mov    (%eax),%al
  800f3a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f3d:	75 05                	jne    800f44 <strchr+0x1d>
			return (char *) s;
  800f3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f42:	eb 11                	jmp    800f55 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f44:	ff 45 08             	incl   0x8(%ebp)
  800f47:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4a:	8a 00                	mov    (%eax),%al
  800f4c:	84 c0                	test   %al,%al
  800f4e:	75 e5                	jne    800f35 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f50:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f55:	c9                   	leave  
  800f56:	c3                   	ret    

00800f57 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f57:	55                   	push   %ebp
  800f58:	89 e5                	mov    %esp,%ebp
  800f5a:	83 ec 04             	sub    $0x4,%esp
  800f5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f60:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f63:	eb 0d                	jmp    800f72 <strfind+0x1b>
		if (*s == c)
  800f65:	8b 45 08             	mov    0x8(%ebp),%eax
  800f68:	8a 00                	mov    (%eax),%al
  800f6a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f6d:	74 0e                	je     800f7d <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f6f:	ff 45 08             	incl   0x8(%ebp)
  800f72:	8b 45 08             	mov    0x8(%ebp),%eax
  800f75:	8a 00                	mov    (%eax),%al
  800f77:	84 c0                	test   %al,%al
  800f79:	75 ea                	jne    800f65 <strfind+0xe>
  800f7b:	eb 01                	jmp    800f7e <strfind+0x27>
		if (*s == c)
			break;
  800f7d:	90                   	nop
	return (char *) s;
  800f7e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f81:	c9                   	leave  
  800f82:	c3                   	ret    

00800f83 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800f83:	55                   	push   %ebp
  800f84:	89 e5                	mov    %esp,%ebp
  800f86:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f89:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f92:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f95:	eb 0e                	jmp    800fa5 <memset+0x22>
		*p++ = c;
  800f97:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f9a:	8d 50 01             	lea    0x1(%eax),%edx
  800f9d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fa0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fa3:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800fa5:	ff 4d f8             	decl   -0x8(%ebp)
  800fa8:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800fac:	79 e9                	jns    800f97 <memset+0x14>
		*p++ = c;

	return v;
  800fae:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fb1:	c9                   	leave  
  800fb2:	c3                   	ret    

00800fb3 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800fb3:	55                   	push   %ebp
  800fb4:	89 e5                	mov    %esp,%ebp
  800fb6:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fb9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800fc5:	eb 16                	jmp    800fdd <memcpy+0x2a>
		*d++ = *s++;
  800fc7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fca:	8d 50 01             	lea    0x1(%eax),%edx
  800fcd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fd0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fd3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fd6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fd9:	8a 12                	mov    (%edx),%dl
  800fdb:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800fdd:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fe3:	89 55 10             	mov    %edx,0x10(%ebp)
  800fe6:	85 c0                	test   %eax,%eax
  800fe8:	75 dd                	jne    800fc7 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800fea:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fed:	c9                   	leave  
  800fee:	c3                   	ret    

00800fef <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800fef:	55                   	push   %ebp
  800ff0:	89 e5                	mov    %esp,%ebp
  800ff2:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ff5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffe:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801001:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801004:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801007:	73 50                	jae    801059 <memmove+0x6a>
  801009:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80100c:	8b 45 10             	mov    0x10(%ebp),%eax
  80100f:	01 d0                	add    %edx,%eax
  801011:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801014:	76 43                	jbe    801059 <memmove+0x6a>
		s += n;
  801016:	8b 45 10             	mov    0x10(%ebp),%eax
  801019:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80101c:	8b 45 10             	mov    0x10(%ebp),%eax
  80101f:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801022:	eb 10                	jmp    801034 <memmove+0x45>
			*--d = *--s;
  801024:	ff 4d f8             	decl   -0x8(%ebp)
  801027:	ff 4d fc             	decl   -0x4(%ebp)
  80102a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80102d:	8a 10                	mov    (%eax),%dl
  80102f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801032:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801034:	8b 45 10             	mov    0x10(%ebp),%eax
  801037:	8d 50 ff             	lea    -0x1(%eax),%edx
  80103a:	89 55 10             	mov    %edx,0x10(%ebp)
  80103d:	85 c0                	test   %eax,%eax
  80103f:	75 e3                	jne    801024 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801041:	eb 23                	jmp    801066 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801043:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801046:	8d 50 01             	lea    0x1(%eax),%edx
  801049:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80104c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80104f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801052:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801055:	8a 12                	mov    (%edx),%dl
  801057:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801059:	8b 45 10             	mov    0x10(%ebp),%eax
  80105c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80105f:	89 55 10             	mov    %edx,0x10(%ebp)
  801062:	85 c0                	test   %eax,%eax
  801064:	75 dd                	jne    801043 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801066:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801069:	c9                   	leave  
  80106a:	c3                   	ret    

0080106b <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80106b:	55                   	push   %ebp
  80106c:	89 e5                	mov    %esp,%ebp
  80106e:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801071:	8b 45 08             	mov    0x8(%ebp),%eax
  801074:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801077:	8b 45 0c             	mov    0xc(%ebp),%eax
  80107a:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80107d:	eb 2a                	jmp    8010a9 <memcmp+0x3e>
		if (*s1 != *s2)
  80107f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801082:	8a 10                	mov    (%eax),%dl
  801084:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801087:	8a 00                	mov    (%eax),%al
  801089:	38 c2                	cmp    %al,%dl
  80108b:	74 16                	je     8010a3 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80108d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801090:	8a 00                	mov    (%eax),%al
  801092:	0f b6 d0             	movzbl %al,%edx
  801095:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801098:	8a 00                	mov    (%eax),%al
  80109a:	0f b6 c0             	movzbl %al,%eax
  80109d:	29 c2                	sub    %eax,%edx
  80109f:	89 d0                	mov    %edx,%eax
  8010a1:	eb 18                	jmp    8010bb <memcmp+0x50>
		s1++, s2++;
  8010a3:	ff 45 fc             	incl   -0x4(%ebp)
  8010a6:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ac:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010af:	89 55 10             	mov    %edx,0x10(%ebp)
  8010b2:	85 c0                	test   %eax,%eax
  8010b4:	75 c9                	jne    80107f <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8010b6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010bb:	c9                   	leave  
  8010bc:	c3                   	ret    

008010bd <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8010bd:	55                   	push   %ebp
  8010be:	89 e5                	mov    %esp,%ebp
  8010c0:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8010c3:	8b 55 08             	mov    0x8(%ebp),%edx
  8010c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c9:	01 d0                	add    %edx,%eax
  8010cb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010ce:	eb 15                	jmp    8010e5 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d3:	8a 00                	mov    (%eax),%al
  8010d5:	0f b6 d0             	movzbl %al,%edx
  8010d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010db:	0f b6 c0             	movzbl %al,%eax
  8010de:	39 c2                	cmp    %eax,%edx
  8010e0:	74 0d                	je     8010ef <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8010e2:	ff 45 08             	incl   0x8(%ebp)
  8010e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8010eb:	72 e3                	jb     8010d0 <memfind+0x13>
  8010ed:	eb 01                	jmp    8010f0 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8010ef:	90                   	nop
	return (void *) s;
  8010f0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010f3:	c9                   	leave  
  8010f4:	c3                   	ret    

008010f5 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8010f5:	55                   	push   %ebp
  8010f6:	89 e5                	mov    %esp,%ebp
  8010f8:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8010fb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801102:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801109:	eb 03                	jmp    80110e <strtol+0x19>
		s++;
  80110b:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80110e:	8b 45 08             	mov    0x8(%ebp),%eax
  801111:	8a 00                	mov    (%eax),%al
  801113:	3c 20                	cmp    $0x20,%al
  801115:	74 f4                	je     80110b <strtol+0x16>
  801117:	8b 45 08             	mov    0x8(%ebp),%eax
  80111a:	8a 00                	mov    (%eax),%al
  80111c:	3c 09                	cmp    $0x9,%al
  80111e:	74 eb                	je     80110b <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801120:	8b 45 08             	mov    0x8(%ebp),%eax
  801123:	8a 00                	mov    (%eax),%al
  801125:	3c 2b                	cmp    $0x2b,%al
  801127:	75 05                	jne    80112e <strtol+0x39>
		s++;
  801129:	ff 45 08             	incl   0x8(%ebp)
  80112c:	eb 13                	jmp    801141 <strtol+0x4c>
	else if (*s == '-')
  80112e:	8b 45 08             	mov    0x8(%ebp),%eax
  801131:	8a 00                	mov    (%eax),%al
  801133:	3c 2d                	cmp    $0x2d,%al
  801135:	75 0a                	jne    801141 <strtol+0x4c>
		s++, neg = 1;
  801137:	ff 45 08             	incl   0x8(%ebp)
  80113a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801141:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801145:	74 06                	je     80114d <strtol+0x58>
  801147:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80114b:	75 20                	jne    80116d <strtol+0x78>
  80114d:	8b 45 08             	mov    0x8(%ebp),%eax
  801150:	8a 00                	mov    (%eax),%al
  801152:	3c 30                	cmp    $0x30,%al
  801154:	75 17                	jne    80116d <strtol+0x78>
  801156:	8b 45 08             	mov    0x8(%ebp),%eax
  801159:	40                   	inc    %eax
  80115a:	8a 00                	mov    (%eax),%al
  80115c:	3c 78                	cmp    $0x78,%al
  80115e:	75 0d                	jne    80116d <strtol+0x78>
		s += 2, base = 16;
  801160:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801164:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80116b:	eb 28                	jmp    801195 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80116d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801171:	75 15                	jne    801188 <strtol+0x93>
  801173:	8b 45 08             	mov    0x8(%ebp),%eax
  801176:	8a 00                	mov    (%eax),%al
  801178:	3c 30                	cmp    $0x30,%al
  80117a:	75 0c                	jne    801188 <strtol+0x93>
		s++, base = 8;
  80117c:	ff 45 08             	incl   0x8(%ebp)
  80117f:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801186:	eb 0d                	jmp    801195 <strtol+0xa0>
	else if (base == 0)
  801188:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80118c:	75 07                	jne    801195 <strtol+0xa0>
		base = 10;
  80118e:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801195:	8b 45 08             	mov    0x8(%ebp),%eax
  801198:	8a 00                	mov    (%eax),%al
  80119a:	3c 2f                	cmp    $0x2f,%al
  80119c:	7e 19                	jle    8011b7 <strtol+0xc2>
  80119e:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a1:	8a 00                	mov    (%eax),%al
  8011a3:	3c 39                	cmp    $0x39,%al
  8011a5:	7f 10                	jg     8011b7 <strtol+0xc2>
			dig = *s - '0';
  8011a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011aa:	8a 00                	mov    (%eax),%al
  8011ac:	0f be c0             	movsbl %al,%eax
  8011af:	83 e8 30             	sub    $0x30,%eax
  8011b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011b5:	eb 42                	jmp    8011f9 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8011b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ba:	8a 00                	mov    (%eax),%al
  8011bc:	3c 60                	cmp    $0x60,%al
  8011be:	7e 19                	jle    8011d9 <strtol+0xe4>
  8011c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c3:	8a 00                	mov    (%eax),%al
  8011c5:	3c 7a                	cmp    $0x7a,%al
  8011c7:	7f 10                	jg     8011d9 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8011c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cc:	8a 00                	mov    (%eax),%al
  8011ce:	0f be c0             	movsbl %al,%eax
  8011d1:	83 e8 57             	sub    $0x57,%eax
  8011d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011d7:	eb 20                	jmp    8011f9 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dc:	8a 00                	mov    (%eax),%al
  8011de:	3c 40                	cmp    $0x40,%al
  8011e0:	7e 39                	jle    80121b <strtol+0x126>
  8011e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e5:	8a 00                	mov    (%eax),%al
  8011e7:	3c 5a                	cmp    $0x5a,%al
  8011e9:	7f 30                	jg     80121b <strtol+0x126>
			dig = *s - 'A' + 10;
  8011eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ee:	8a 00                	mov    (%eax),%al
  8011f0:	0f be c0             	movsbl %al,%eax
  8011f3:	83 e8 37             	sub    $0x37,%eax
  8011f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8011f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011fc:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011ff:	7d 19                	jge    80121a <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801201:	ff 45 08             	incl   0x8(%ebp)
  801204:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801207:	0f af 45 10          	imul   0x10(%ebp),%eax
  80120b:	89 c2                	mov    %eax,%edx
  80120d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801210:	01 d0                	add    %edx,%eax
  801212:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801215:	e9 7b ff ff ff       	jmp    801195 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80121a:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80121b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80121f:	74 08                	je     801229 <strtol+0x134>
		*endptr = (char *) s;
  801221:	8b 45 0c             	mov    0xc(%ebp),%eax
  801224:	8b 55 08             	mov    0x8(%ebp),%edx
  801227:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801229:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80122d:	74 07                	je     801236 <strtol+0x141>
  80122f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801232:	f7 d8                	neg    %eax
  801234:	eb 03                	jmp    801239 <strtol+0x144>
  801236:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801239:	c9                   	leave  
  80123a:	c3                   	ret    

0080123b <ltostr>:

void
ltostr(long value, char *str)
{
  80123b:	55                   	push   %ebp
  80123c:	89 e5                	mov    %esp,%ebp
  80123e:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801241:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801248:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80124f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801253:	79 13                	jns    801268 <ltostr+0x2d>
	{
		neg = 1;
  801255:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80125c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80125f:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801262:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801265:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801268:	8b 45 08             	mov    0x8(%ebp),%eax
  80126b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801270:	99                   	cltd   
  801271:	f7 f9                	idiv   %ecx
  801273:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801276:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801279:	8d 50 01             	lea    0x1(%eax),%edx
  80127c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80127f:	89 c2                	mov    %eax,%edx
  801281:	8b 45 0c             	mov    0xc(%ebp),%eax
  801284:	01 d0                	add    %edx,%eax
  801286:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801289:	83 c2 30             	add    $0x30,%edx
  80128c:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80128e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801291:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801296:	f7 e9                	imul   %ecx
  801298:	c1 fa 02             	sar    $0x2,%edx
  80129b:	89 c8                	mov    %ecx,%eax
  80129d:	c1 f8 1f             	sar    $0x1f,%eax
  8012a0:	29 c2                	sub    %eax,%edx
  8012a2:	89 d0                	mov    %edx,%eax
  8012a4:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8012a7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012aa:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012af:	f7 e9                	imul   %ecx
  8012b1:	c1 fa 02             	sar    $0x2,%edx
  8012b4:	89 c8                	mov    %ecx,%eax
  8012b6:	c1 f8 1f             	sar    $0x1f,%eax
  8012b9:	29 c2                	sub    %eax,%edx
  8012bb:	89 d0                	mov    %edx,%eax
  8012bd:	c1 e0 02             	shl    $0x2,%eax
  8012c0:	01 d0                	add    %edx,%eax
  8012c2:	01 c0                	add    %eax,%eax
  8012c4:	29 c1                	sub    %eax,%ecx
  8012c6:	89 ca                	mov    %ecx,%edx
  8012c8:	85 d2                	test   %edx,%edx
  8012ca:	75 9c                	jne    801268 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012d6:	48                   	dec    %eax
  8012d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8012da:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012de:	74 3d                	je     80131d <ltostr+0xe2>
		start = 1 ;
  8012e0:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8012e7:	eb 34                	jmp    80131d <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8012e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ef:	01 d0                	add    %edx,%eax
  8012f1:	8a 00                	mov    (%eax),%al
  8012f3:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012fc:	01 c2                	add    %eax,%edx
  8012fe:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801301:	8b 45 0c             	mov    0xc(%ebp),%eax
  801304:	01 c8                	add    %ecx,%eax
  801306:	8a 00                	mov    (%eax),%al
  801308:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80130a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80130d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801310:	01 c2                	add    %eax,%edx
  801312:	8a 45 eb             	mov    -0x15(%ebp),%al
  801315:	88 02                	mov    %al,(%edx)
		start++ ;
  801317:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80131a:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80131d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801320:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801323:	7c c4                	jl     8012e9 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801325:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801328:	8b 45 0c             	mov    0xc(%ebp),%eax
  80132b:	01 d0                	add    %edx,%eax
  80132d:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801330:	90                   	nop
  801331:	c9                   	leave  
  801332:	c3                   	ret    

00801333 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801333:	55                   	push   %ebp
  801334:	89 e5                	mov    %esp,%ebp
  801336:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801339:	ff 75 08             	pushl  0x8(%ebp)
  80133c:	e8 54 fa ff ff       	call   800d95 <strlen>
  801341:	83 c4 04             	add    $0x4,%esp
  801344:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801347:	ff 75 0c             	pushl  0xc(%ebp)
  80134a:	e8 46 fa ff ff       	call   800d95 <strlen>
  80134f:	83 c4 04             	add    $0x4,%esp
  801352:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801355:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80135c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801363:	eb 17                	jmp    80137c <strcconcat+0x49>
		final[s] = str1[s] ;
  801365:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801368:	8b 45 10             	mov    0x10(%ebp),%eax
  80136b:	01 c2                	add    %eax,%edx
  80136d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801370:	8b 45 08             	mov    0x8(%ebp),%eax
  801373:	01 c8                	add    %ecx,%eax
  801375:	8a 00                	mov    (%eax),%al
  801377:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801379:	ff 45 fc             	incl   -0x4(%ebp)
  80137c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80137f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801382:	7c e1                	jl     801365 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801384:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80138b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801392:	eb 1f                	jmp    8013b3 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801394:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801397:	8d 50 01             	lea    0x1(%eax),%edx
  80139a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80139d:	89 c2                	mov    %eax,%edx
  80139f:	8b 45 10             	mov    0x10(%ebp),%eax
  8013a2:	01 c2                	add    %eax,%edx
  8013a4:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013aa:	01 c8                	add    %ecx,%eax
  8013ac:	8a 00                	mov    (%eax),%al
  8013ae:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013b0:	ff 45 f8             	incl   -0x8(%ebp)
  8013b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013b6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013b9:	7c d9                	jl     801394 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013bb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013be:	8b 45 10             	mov    0x10(%ebp),%eax
  8013c1:	01 d0                	add    %edx,%eax
  8013c3:	c6 00 00             	movb   $0x0,(%eax)
}
  8013c6:	90                   	nop
  8013c7:	c9                   	leave  
  8013c8:	c3                   	ret    

008013c9 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013c9:	55                   	push   %ebp
  8013ca:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013cc:	8b 45 14             	mov    0x14(%ebp),%eax
  8013cf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8013d5:	8b 45 14             	mov    0x14(%ebp),%eax
  8013d8:	8b 00                	mov    (%eax),%eax
  8013da:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8013e4:	01 d0                	add    %edx,%eax
  8013e6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013ec:	eb 0c                	jmp    8013fa <strsplit+0x31>
			*string++ = 0;
  8013ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f1:	8d 50 01             	lea    0x1(%eax),%edx
  8013f4:	89 55 08             	mov    %edx,0x8(%ebp)
  8013f7:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fd:	8a 00                	mov    (%eax),%al
  8013ff:	84 c0                	test   %al,%al
  801401:	74 18                	je     80141b <strsplit+0x52>
  801403:	8b 45 08             	mov    0x8(%ebp),%eax
  801406:	8a 00                	mov    (%eax),%al
  801408:	0f be c0             	movsbl %al,%eax
  80140b:	50                   	push   %eax
  80140c:	ff 75 0c             	pushl  0xc(%ebp)
  80140f:	e8 13 fb ff ff       	call   800f27 <strchr>
  801414:	83 c4 08             	add    $0x8,%esp
  801417:	85 c0                	test   %eax,%eax
  801419:	75 d3                	jne    8013ee <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80141b:	8b 45 08             	mov    0x8(%ebp),%eax
  80141e:	8a 00                	mov    (%eax),%al
  801420:	84 c0                	test   %al,%al
  801422:	74 5a                	je     80147e <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801424:	8b 45 14             	mov    0x14(%ebp),%eax
  801427:	8b 00                	mov    (%eax),%eax
  801429:	83 f8 0f             	cmp    $0xf,%eax
  80142c:	75 07                	jne    801435 <strsplit+0x6c>
		{
			return 0;
  80142e:	b8 00 00 00 00       	mov    $0x0,%eax
  801433:	eb 66                	jmp    80149b <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801435:	8b 45 14             	mov    0x14(%ebp),%eax
  801438:	8b 00                	mov    (%eax),%eax
  80143a:	8d 48 01             	lea    0x1(%eax),%ecx
  80143d:	8b 55 14             	mov    0x14(%ebp),%edx
  801440:	89 0a                	mov    %ecx,(%edx)
  801442:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801449:	8b 45 10             	mov    0x10(%ebp),%eax
  80144c:	01 c2                	add    %eax,%edx
  80144e:	8b 45 08             	mov    0x8(%ebp),%eax
  801451:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801453:	eb 03                	jmp    801458 <strsplit+0x8f>
			string++;
  801455:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801458:	8b 45 08             	mov    0x8(%ebp),%eax
  80145b:	8a 00                	mov    (%eax),%al
  80145d:	84 c0                	test   %al,%al
  80145f:	74 8b                	je     8013ec <strsplit+0x23>
  801461:	8b 45 08             	mov    0x8(%ebp),%eax
  801464:	8a 00                	mov    (%eax),%al
  801466:	0f be c0             	movsbl %al,%eax
  801469:	50                   	push   %eax
  80146a:	ff 75 0c             	pushl  0xc(%ebp)
  80146d:	e8 b5 fa ff ff       	call   800f27 <strchr>
  801472:	83 c4 08             	add    $0x8,%esp
  801475:	85 c0                	test   %eax,%eax
  801477:	74 dc                	je     801455 <strsplit+0x8c>
			string++;
	}
  801479:	e9 6e ff ff ff       	jmp    8013ec <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80147e:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80147f:	8b 45 14             	mov    0x14(%ebp),%eax
  801482:	8b 00                	mov    (%eax),%eax
  801484:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80148b:	8b 45 10             	mov    0x10(%ebp),%eax
  80148e:	01 d0                	add    %edx,%eax
  801490:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801496:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80149b:	c9                   	leave  
  80149c:	c3                   	ret    

0080149d <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80149d:	55                   	push   %ebp
  80149e:	89 e5                	mov    %esp,%ebp
  8014a0:	57                   	push   %edi
  8014a1:	56                   	push   %esi
  8014a2:	53                   	push   %ebx
  8014a3:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8014a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ac:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8014af:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8014b2:	8b 7d 18             	mov    0x18(%ebp),%edi
  8014b5:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8014b8:	cd 30                	int    $0x30
  8014ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8014bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8014c0:	83 c4 10             	add    $0x10,%esp
  8014c3:	5b                   	pop    %ebx
  8014c4:	5e                   	pop    %esi
  8014c5:	5f                   	pop    %edi
  8014c6:	5d                   	pop    %ebp
  8014c7:	c3                   	ret    

008014c8 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
  8014cb:	83 ec 04             	sub    $0x4,%esp
  8014ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8014d4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	52                   	push   %edx
  8014e0:	ff 75 0c             	pushl  0xc(%ebp)
  8014e3:	50                   	push   %eax
  8014e4:	6a 00                	push   $0x0
  8014e6:	e8 b2 ff ff ff       	call   80149d <syscall>
  8014eb:	83 c4 18             	add    $0x18,%esp
}
  8014ee:	90                   	nop
  8014ef:	c9                   	leave  
  8014f0:	c3                   	ret    

008014f1 <sys_cgetc>:

int
sys_cgetc(void)
{
  8014f1:	55                   	push   %ebp
  8014f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 01                	push   $0x1
  801500:	e8 98 ff ff ff       	call   80149d <syscall>
  801505:	83 c4 18             	add    $0x18,%esp
}
  801508:	c9                   	leave  
  801509:	c3                   	ret    

0080150a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80150a:	55                   	push   %ebp
  80150b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80150d:	8b 45 08             	mov    0x8(%ebp),%eax
  801510:	6a 00                	push   $0x0
  801512:	6a 00                	push   $0x0
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	50                   	push   %eax
  801519:	6a 05                	push   $0x5
  80151b:	e8 7d ff ff ff       	call   80149d <syscall>
  801520:	83 c4 18             	add    $0x18,%esp
}
  801523:	c9                   	leave  
  801524:	c3                   	ret    

00801525 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801525:	55                   	push   %ebp
  801526:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801528:	6a 00                	push   $0x0
  80152a:	6a 00                	push   $0x0
  80152c:	6a 00                	push   $0x0
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	6a 02                	push   $0x2
  801534:	e8 64 ff ff ff       	call   80149d <syscall>
  801539:	83 c4 18             	add    $0x18,%esp
}
  80153c:	c9                   	leave  
  80153d:	c3                   	ret    

0080153e <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80153e:	55                   	push   %ebp
  80153f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	6a 00                	push   $0x0
  801547:	6a 00                	push   $0x0
  801549:	6a 00                	push   $0x0
  80154b:	6a 03                	push   $0x3
  80154d:	e8 4b ff ff ff       	call   80149d <syscall>
  801552:	83 c4 18             	add    $0x18,%esp
}
  801555:	c9                   	leave  
  801556:	c3                   	ret    

00801557 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801557:	55                   	push   %ebp
  801558:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80155a:	6a 00                	push   $0x0
  80155c:	6a 00                	push   $0x0
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	6a 00                	push   $0x0
  801564:	6a 04                	push   $0x4
  801566:	e8 32 ff ff ff       	call   80149d <syscall>
  80156b:	83 c4 18             	add    $0x18,%esp
}
  80156e:	c9                   	leave  
  80156f:	c3                   	ret    

00801570 <sys_env_exit>:


void sys_env_exit(void)
{
  801570:	55                   	push   %ebp
  801571:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801573:	6a 00                	push   $0x0
  801575:	6a 00                	push   $0x0
  801577:	6a 00                	push   $0x0
  801579:	6a 00                	push   $0x0
  80157b:	6a 00                	push   $0x0
  80157d:	6a 06                	push   $0x6
  80157f:	e8 19 ff ff ff       	call   80149d <syscall>
  801584:	83 c4 18             	add    $0x18,%esp
}
  801587:	90                   	nop
  801588:	c9                   	leave  
  801589:	c3                   	ret    

0080158a <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80158a:	55                   	push   %ebp
  80158b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80158d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801590:	8b 45 08             	mov    0x8(%ebp),%eax
  801593:	6a 00                	push   $0x0
  801595:	6a 00                	push   $0x0
  801597:	6a 00                	push   $0x0
  801599:	52                   	push   %edx
  80159a:	50                   	push   %eax
  80159b:	6a 07                	push   $0x7
  80159d:	e8 fb fe ff ff       	call   80149d <syscall>
  8015a2:	83 c4 18             	add    $0x18,%esp
}
  8015a5:	c9                   	leave  
  8015a6:	c3                   	ret    

008015a7 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8015a7:	55                   	push   %ebp
  8015a8:	89 e5                	mov    %esp,%ebp
  8015aa:	56                   	push   %esi
  8015ab:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8015ac:	8b 75 18             	mov    0x18(%ebp),%esi
  8015af:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015b2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bb:	56                   	push   %esi
  8015bc:	53                   	push   %ebx
  8015bd:	51                   	push   %ecx
  8015be:	52                   	push   %edx
  8015bf:	50                   	push   %eax
  8015c0:	6a 08                	push   $0x8
  8015c2:	e8 d6 fe ff ff       	call   80149d <syscall>
  8015c7:	83 c4 18             	add    $0x18,%esp
}
  8015ca:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8015cd:	5b                   	pop    %ebx
  8015ce:	5e                   	pop    %esi
  8015cf:	5d                   	pop    %ebp
  8015d0:	c3                   	ret    

008015d1 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8015d1:	55                   	push   %ebp
  8015d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8015d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	52                   	push   %edx
  8015e1:	50                   	push   %eax
  8015e2:	6a 09                	push   $0x9
  8015e4:	e8 b4 fe ff ff       	call   80149d <syscall>
  8015e9:	83 c4 18             	add    $0x18,%esp
}
  8015ec:	c9                   	leave  
  8015ed:	c3                   	ret    

008015ee <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8015ee:	55                   	push   %ebp
  8015ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 00                	push   $0x0
  8015f5:	6a 00                	push   $0x0
  8015f7:	ff 75 0c             	pushl  0xc(%ebp)
  8015fa:	ff 75 08             	pushl  0x8(%ebp)
  8015fd:	6a 0a                	push   $0xa
  8015ff:	e8 99 fe ff ff       	call   80149d <syscall>
  801604:	83 c4 18             	add    $0x18,%esp
}
  801607:	c9                   	leave  
  801608:	c3                   	ret    

00801609 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801609:	55                   	push   %ebp
  80160a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80160c:	6a 00                	push   $0x0
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	6a 0b                	push   $0xb
  801618:	e8 80 fe ff ff       	call   80149d <syscall>
  80161d:	83 c4 18             	add    $0x18,%esp
}
  801620:	c9                   	leave  
  801621:	c3                   	ret    

00801622 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801622:	55                   	push   %ebp
  801623:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801625:	6a 00                	push   $0x0
  801627:	6a 00                	push   $0x0
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	6a 0c                	push   $0xc
  801631:	e8 67 fe ff ff       	call   80149d <syscall>
  801636:	83 c4 18             	add    $0x18,%esp
}
  801639:	c9                   	leave  
  80163a:	c3                   	ret    

0080163b <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80163b:	55                   	push   %ebp
  80163c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80163e:	6a 00                	push   $0x0
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	6a 0d                	push   $0xd
  80164a:	e8 4e fe ff ff       	call   80149d <syscall>
  80164f:	83 c4 18             	add    $0x18,%esp
}
  801652:	c9                   	leave  
  801653:	c3                   	ret    

00801654 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801654:	55                   	push   %ebp
  801655:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801657:	6a 00                	push   $0x0
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	ff 75 0c             	pushl  0xc(%ebp)
  801660:	ff 75 08             	pushl  0x8(%ebp)
  801663:	6a 11                	push   $0x11
  801665:	e8 33 fe ff ff       	call   80149d <syscall>
  80166a:	83 c4 18             	add    $0x18,%esp
	return;
  80166d:	90                   	nop
}
  80166e:	c9                   	leave  
  80166f:	c3                   	ret    

00801670 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801670:	55                   	push   %ebp
  801671:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	ff 75 0c             	pushl  0xc(%ebp)
  80167c:	ff 75 08             	pushl  0x8(%ebp)
  80167f:	6a 12                	push   $0x12
  801681:	e8 17 fe ff ff       	call   80149d <syscall>
  801686:	83 c4 18             	add    $0x18,%esp
	return ;
  801689:	90                   	nop
}
  80168a:	c9                   	leave  
  80168b:	c3                   	ret    

0080168c <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80168c:	55                   	push   %ebp
  80168d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	6a 00                	push   $0x0
  801695:	6a 00                	push   $0x0
  801697:	6a 00                	push   $0x0
  801699:	6a 0e                	push   $0xe
  80169b:	e8 fd fd ff ff       	call   80149d <syscall>
  8016a0:	83 c4 18             	add    $0x18,%esp
}
  8016a3:	c9                   	leave  
  8016a4:	c3                   	ret    

008016a5 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8016a5:	55                   	push   %ebp
  8016a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8016a8:	6a 00                	push   $0x0
  8016aa:	6a 00                	push   $0x0
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	ff 75 08             	pushl  0x8(%ebp)
  8016b3:	6a 0f                	push   $0xf
  8016b5:	e8 e3 fd ff ff       	call   80149d <syscall>
  8016ba:	83 c4 18             	add    $0x18,%esp
}
  8016bd:	c9                   	leave  
  8016be:	c3                   	ret    

008016bf <sys_scarce_memory>:

void sys_scarce_memory()
{
  8016bf:	55                   	push   %ebp
  8016c0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 00                	push   $0x0
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 10                	push   $0x10
  8016ce:	e8 ca fd ff ff       	call   80149d <syscall>
  8016d3:	83 c4 18             	add    $0x18,%esp
}
  8016d6:	90                   	nop
  8016d7:	c9                   	leave  
  8016d8:	c3                   	ret    

008016d9 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8016d9:	55                   	push   %ebp
  8016da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	6a 00                	push   $0x0
  8016e6:	6a 14                	push   $0x14
  8016e8:	e8 b0 fd ff ff       	call   80149d <syscall>
  8016ed:	83 c4 18             	add    $0x18,%esp
}
  8016f0:	90                   	nop
  8016f1:	c9                   	leave  
  8016f2:	c3                   	ret    

008016f3 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8016f3:	55                   	push   %ebp
  8016f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8016f6:	6a 00                	push   $0x0
  8016f8:	6a 00                	push   $0x0
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 00                	push   $0x0
  801700:	6a 15                	push   $0x15
  801702:	e8 96 fd ff ff       	call   80149d <syscall>
  801707:	83 c4 18             	add    $0x18,%esp
}
  80170a:	90                   	nop
  80170b:	c9                   	leave  
  80170c:	c3                   	ret    

0080170d <sys_cputc>:


void
sys_cputc(const char c)
{
  80170d:	55                   	push   %ebp
  80170e:	89 e5                	mov    %esp,%ebp
  801710:	83 ec 04             	sub    $0x4,%esp
  801713:	8b 45 08             	mov    0x8(%ebp),%eax
  801716:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801719:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80171d:	6a 00                	push   $0x0
  80171f:	6a 00                	push   $0x0
  801721:	6a 00                	push   $0x0
  801723:	6a 00                	push   $0x0
  801725:	50                   	push   %eax
  801726:	6a 16                	push   $0x16
  801728:	e8 70 fd ff ff       	call   80149d <syscall>
  80172d:	83 c4 18             	add    $0x18,%esp
}
  801730:	90                   	nop
  801731:	c9                   	leave  
  801732:	c3                   	ret    

00801733 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801733:	55                   	push   %ebp
  801734:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801736:	6a 00                	push   $0x0
  801738:	6a 00                	push   $0x0
  80173a:	6a 00                	push   $0x0
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	6a 17                	push   $0x17
  801742:	e8 56 fd ff ff       	call   80149d <syscall>
  801747:	83 c4 18             	add    $0x18,%esp
}
  80174a:	90                   	nop
  80174b:	c9                   	leave  
  80174c:	c3                   	ret    

0080174d <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80174d:	55                   	push   %ebp
  80174e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801750:	8b 45 08             	mov    0x8(%ebp),%eax
  801753:	6a 00                	push   $0x0
  801755:	6a 00                	push   $0x0
  801757:	6a 00                	push   $0x0
  801759:	ff 75 0c             	pushl  0xc(%ebp)
  80175c:	50                   	push   %eax
  80175d:	6a 18                	push   $0x18
  80175f:	e8 39 fd ff ff       	call   80149d <syscall>
  801764:	83 c4 18             	add    $0x18,%esp
}
  801767:	c9                   	leave  
  801768:	c3                   	ret    

00801769 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801769:	55                   	push   %ebp
  80176a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80176c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80176f:	8b 45 08             	mov    0x8(%ebp),%eax
  801772:	6a 00                	push   $0x0
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	52                   	push   %edx
  801779:	50                   	push   %eax
  80177a:	6a 1b                	push   $0x1b
  80177c:	e8 1c fd ff ff       	call   80149d <syscall>
  801781:	83 c4 18             	add    $0x18,%esp
}
  801784:	c9                   	leave  
  801785:	c3                   	ret    

00801786 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801786:	55                   	push   %ebp
  801787:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801789:	8b 55 0c             	mov    0xc(%ebp),%edx
  80178c:	8b 45 08             	mov    0x8(%ebp),%eax
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	52                   	push   %edx
  801796:	50                   	push   %eax
  801797:	6a 19                	push   $0x19
  801799:	e8 ff fc ff ff       	call   80149d <syscall>
  80179e:	83 c4 18             	add    $0x18,%esp
}
  8017a1:	90                   	nop
  8017a2:	c9                   	leave  
  8017a3:	c3                   	ret    

008017a4 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017a4:	55                   	push   %ebp
  8017a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 00                	push   $0x0
  8017b3:	52                   	push   %edx
  8017b4:	50                   	push   %eax
  8017b5:	6a 1a                	push   $0x1a
  8017b7:	e8 e1 fc ff ff       	call   80149d <syscall>
  8017bc:	83 c4 18             	add    $0x18,%esp
}
  8017bf:	90                   	nop
  8017c0:	c9                   	leave  
  8017c1:	c3                   	ret    

008017c2 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8017c2:	55                   	push   %ebp
  8017c3:	89 e5                	mov    %esp,%ebp
  8017c5:	83 ec 04             	sub    $0x4,%esp
  8017c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8017cb:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8017ce:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8017d1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8017d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d8:	6a 00                	push   $0x0
  8017da:	51                   	push   %ecx
  8017db:	52                   	push   %edx
  8017dc:	ff 75 0c             	pushl  0xc(%ebp)
  8017df:	50                   	push   %eax
  8017e0:	6a 1c                	push   $0x1c
  8017e2:	e8 b6 fc ff ff       	call   80149d <syscall>
  8017e7:	83 c4 18             	add    $0x18,%esp
}
  8017ea:	c9                   	leave  
  8017eb:	c3                   	ret    

008017ec <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8017ec:	55                   	push   %ebp
  8017ed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8017ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	52                   	push   %edx
  8017fc:	50                   	push   %eax
  8017fd:	6a 1d                	push   $0x1d
  8017ff:	e8 99 fc ff ff       	call   80149d <syscall>
  801804:	83 c4 18             	add    $0x18,%esp
}
  801807:	c9                   	leave  
  801808:	c3                   	ret    

00801809 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801809:	55                   	push   %ebp
  80180a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80180c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80180f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801812:	8b 45 08             	mov    0x8(%ebp),%eax
  801815:	6a 00                	push   $0x0
  801817:	6a 00                	push   $0x0
  801819:	51                   	push   %ecx
  80181a:	52                   	push   %edx
  80181b:	50                   	push   %eax
  80181c:	6a 1e                	push   $0x1e
  80181e:	e8 7a fc ff ff       	call   80149d <syscall>
  801823:	83 c4 18             	add    $0x18,%esp
}
  801826:	c9                   	leave  
  801827:	c3                   	ret    

00801828 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801828:	55                   	push   %ebp
  801829:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80182b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80182e:	8b 45 08             	mov    0x8(%ebp),%eax
  801831:	6a 00                	push   $0x0
  801833:	6a 00                	push   $0x0
  801835:	6a 00                	push   $0x0
  801837:	52                   	push   %edx
  801838:	50                   	push   %eax
  801839:	6a 1f                	push   $0x1f
  80183b:	e8 5d fc ff ff       	call   80149d <syscall>
  801840:	83 c4 18             	add    $0x18,%esp
}
  801843:	c9                   	leave  
  801844:	c3                   	ret    

00801845 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801845:	55                   	push   %ebp
  801846:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 00                	push   $0x0
  80184e:	6a 00                	push   $0x0
  801850:	6a 00                	push   $0x0
  801852:	6a 20                	push   $0x20
  801854:	e8 44 fc ff ff       	call   80149d <syscall>
  801859:	83 c4 18             	add    $0x18,%esp
}
  80185c:	c9                   	leave  
  80185d:	c3                   	ret    

0080185e <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80185e:	55                   	push   %ebp
  80185f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801861:	8b 45 08             	mov    0x8(%ebp),%eax
  801864:	6a 00                	push   $0x0
  801866:	ff 75 14             	pushl  0x14(%ebp)
  801869:	ff 75 10             	pushl  0x10(%ebp)
  80186c:	ff 75 0c             	pushl  0xc(%ebp)
  80186f:	50                   	push   %eax
  801870:	6a 21                	push   $0x21
  801872:	e8 26 fc ff ff       	call   80149d <syscall>
  801877:	83 c4 18             	add    $0x18,%esp
}
  80187a:	c9                   	leave  
  80187b:	c3                   	ret    

0080187c <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80187c:	55                   	push   %ebp
  80187d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80187f:	8b 45 08             	mov    0x8(%ebp),%eax
  801882:	6a 00                	push   $0x0
  801884:	6a 00                	push   $0x0
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	50                   	push   %eax
  80188b:	6a 22                	push   $0x22
  80188d:	e8 0b fc ff ff       	call   80149d <syscall>
  801892:	83 c4 18             	add    $0x18,%esp
}
  801895:	90                   	nop
  801896:	c9                   	leave  
  801897:	c3                   	ret    

00801898 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801898:	55                   	push   %ebp
  801899:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80189b:	8b 45 08             	mov    0x8(%ebp),%eax
  80189e:	6a 00                	push   $0x0
  8018a0:	6a 00                	push   $0x0
  8018a2:	6a 00                	push   $0x0
  8018a4:	6a 00                	push   $0x0
  8018a6:	50                   	push   %eax
  8018a7:	6a 23                	push   $0x23
  8018a9:	e8 ef fb ff ff       	call   80149d <syscall>
  8018ae:	83 c4 18             	add    $0x18,%esp
}
  8018b1:	90                   	nop
  8018b2:	c9                   	leave  
  8018b3:	c3                   	ret    

008018b4 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8018b4:	55                   	push   %ebp
  8018b5:	89 e5                	mov    %esp,%ebp
  8018b7:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8018ba:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8018bd:	8d 50 04             	lea    0x4(%eax),%edx
  8018c0:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	6a 00                	push   $0x0
  8018c9:	52                   	push   %edx
  8018ca:	50                   	push   %eax
  8018cb:	6a 24                	push   $0x24
  8018cd:	e8 cb fb ff ff       	call   80149d <syscall>
  8018d2:	83 c4 18             	add    $0x18,%esp
	return result;
  8018d5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018db:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018de:	89 01                	mov    %eax,(%ecx)
  8018e0:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8018e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e6:	c9                   	leave  
  8018e7:	c2 04 00             	ret    $0x4

008018ea <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8018ea:	55                   	push   %ebp
  8018eb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8018ed:	6a 00                	push   $0x0
  8018ef:	6a 00                	push   $0x0
  8018f1:	ff 75 10             	pushl  0x10(%ebp)
  8018f4:	ff 75 0c             	pushl  0xc(%ebp)
  8018f7:	ff 75 08             	pushl  0x8(%ebp)
  8018fa:	6a 13                	push   $0x13
  8018fc:	e8 9c fb ff ff       	call   80149d <syscall>
  801901:	83 c4 18             	add    $0x18,%esp
	return ;
  801904:	90                   	nop
}
  801905:	c9                   	leave  
  801906:	c3                   	ret    

00801907 <sys_rcr2>:
uint32 sys_rcr2()
{
  801907:	55                   	push   %ebp
  801908:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	6a 25                	push   $0x25
  801916:	e8 82 fb ff ff       	call   80149d <syscall>
  80191b:	83 c4 18             	add    $0x18,%esp
}
  80191e:	c9                   	leave  
  80191f:	c3                   	ret    

00801920 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801920:	55                   	push   %ebp
  801921:	89 e5                	mov    %esp,%ebp
  801923:	83 ec 04             	sub    $0x4,%esp
  801926:	8b 45 08             	mov    0x8(%ebp),%eax
  801929:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80192c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801930:	6a 00                	push   $0x0
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	50                   	push   %eax
  801939:	6a 26                	push   $0x26
  80193b:	e8 5d fb ff ff       	call   80149d <syscall>
  801940:	83 c4 18             	add    $0x18,%esp
	return ;
  801943:	90                   	nop
}
  801944:	c9                   	leave  
  801945:	c3                   	ret    

00801946 <rsttst>:
void rsttst()
{
  801946:	55                   	push   %ebp
  801947:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801949:	6a 00                	push   $0x0
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	6a 00                	push   $0x0
  801953:	6a 28                	push   $0x28
  801955:	e8 43 fb ff ff       	call   80149d <syscall>
  80195a:	83 c4 18             	add    $0x18,%esp
	return ;
  80195d:	90                   	nop
}
  80195e:	c9                   	leave  
  80195f:	c3                   	ret    

00801960 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801960:	55                   	push   %ebp
  801961:	89 e5                	mov    %esp,%ebp
  801963:	83 ec 04             	sub    $0x4,%esp
  801966:	8b 45 14             	mov    0x14(%ebp),%eax
  801969:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80196c:	8b 55 18             	mov    0x18(%ebp),%edx
  80196f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801973:	52                   	push   %edx
  801974:	50                   	push   %eax
  801975:	ff 75 10             	pushl  0x10(%ebp)
  801978:	ff 75 0c             	pushl  0xc(%ebp)
  80197b:	ff 75 08             	pushl  0x8(%ebp)
  80197e:	6a 27                	push   $0x27
  801980:	e8 18 fb ff ff       	call   80149d <syscall>
  801985:	83 c4 18             	add    $0x18,%esp
	return ;
  801988:	90                   	nop
}
  801989:	c9                   	leave  
  80198a:	c3                   	ret    

0080198b <chktst>:
void chktst(uint32 n)
{
  80198b:	55                   	push   %ebp
  80198c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80198e:	6a 00                	push   $0x0
  801990:	6a 00                	push   $0x0
  801992:	6a 00                	push   $0x0
  801994:	6a 00                	push   $0x0
  801996:	ff 75 08             	pushl  0x8(%ebp)
  801999:	6a 29                	push   $0x29
  80199b:	e8 fd fa ff ff       	call   80149d <syscall>
  8019a0:	83 c4 18             	add    $0x18,%esp
	return ;
  8019a3:	90                   	nop
}
  8019a4:	c9                   	leave  
  8019a5:	c3                   	ret    

008019a6 <inctst>:

void inctst()
{
  8019a6:	55                   	push   %ebp
  8019a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8019a9:	6a 00                	push   $0x0
  8019ab:	6a 00                	push   $0x0
  8019ad:	6a 00                	push   $0x0
  8019af:	6a 00                	push   $0x0
  8019b1:	6a 00                	push   $0x0
  8019b3:	6a 2a                	push   $0x2a
  8019b5:	e8 e3 fa ff ff       	call   80149d <syscall>
  8019ba:	83 c4 18             	add    $0x18,%esp
	return ;
  8019bd:	90                   	nop
}
  8019be:	c9                   	leave  
  8019bf:	c3                   	ret    

008019c0 <gettst>:
uint32 gettst()
{
  8019c0:	55                   	push   %ebp
  8019c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 00                	push   $0x0
  8019cd:	6a 2b                	push   $0x2b
  8019cf:	e8 c9 fa ff ff       	call   80149d <syscall>
  8019d4:	83 c4 18             	add    $0x18,%esp
}
  8019d7:	c9                   	leave  
  8019d8:	c3                   	ret    

008019d9 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8019d9:	55                   	push   %ebp
  8019da:	89 e5                	mov    %esp,%ebp
  8019dc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019df:	6a 00                	push   $0x0
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 00                	push   $0x0
  8019e9:	6a 2c                	push   $0x2c
  8019eb:	e8 ad fa ff ff       	call   80149d <syscall>
  8019f0:	83 c4 18             	add    $0x18,%esp
  8019f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8019f6:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8019fa:	75 07                	jne    801a03 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8019fc:	b8 01 00 00 00       	mov    $0x1,%eax
  801a01:	eb 05                	jmp    801a08 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801a03:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a08:	c9                   	leave  
  801a09:	c3                   	ret    

00801a0a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801a0a:	55                   	push   %ebp
  801a0b:	89 e5                	mov    %esp,%ebp
  801a0d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a10:	6a 00                	push   $0x0
  801a12:	6a 00                	push   $0x0
  801a14:	6a 00                	push   $0x0
  801a16:	6a 00                	push   $0x0
  801a18:	6a 00                	push   $0x0
  801a1a:	6a 2c                	push   $0x2c
  801a1c:	e8 7c fa ff ff       	call   80149d <syscall>
  801a21:	83 c4 18             	add    $0x18,%esp
  801a24:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801a27:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801a2b:	75 07                	jne    801a34 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801a2d:	b8 01 00 00 00       	mov    $0x1,%eax
  801a32:	eb 05                	jmp    801a39 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801a34:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a39:	c9                   	leave  
  801a3a:	c3                   	ret    

00801a3b <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801a3b:	55                   	push   %ebp
  801a3c:	89 e5                	mov    %esp,%ebp
  801a3e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a41:	6a 00                	push   $0x0
  801a43:	6a 00                	push   $0x0
  801a45:	6a 00                	push   $0x0
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	6a 2c                	push   $0x2c
  801a4d:	e8 4b fa ff ff       	call   80149d <syscall>
  801a52:	83 c4 18             	add    $0x18,%esp
  801a55:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801a58:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801a5c:	75 07                	jne    801a65 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801a5e:	b8 01 00 00 00       	mov    $0x1,%eax
  801a63:	eb 05                	jmp    801a6a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801a65:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a6a:	c9                   	leave  
  801a6b:	c3                   	ret    

00801a6c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801a6c:	55                   	push   %ebp
  801a6d:	89 e5                	mov    %esp,%ebp
  801a6f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a72:	6a 00                	push   $0x0
  801a74:	6a 00                	push   $0x0
  801a76:	6a 00                	push   $0x0
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 2c                	push   $0x2c
  801a7e:	e8 1a fa ff ff       	call   80149d <syscall>
  801a83:	83 c4 18             	add    $0x18,%esp
  801a86:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801a89:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801a8d:	75 07                	jne    801a96 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801a8f:	b8 01 00 00 00       	mov    $0x1,%eax
  801a94:	eb 05                	jmp    801a9b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801a96:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a9b:	c9                   	leave  
  801a9c:	c3                   	ret    

00801a9d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a9d:	55                   	push   %ebp
  801a9e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 00                	push   $0x0
  801aa4:	6a 00                	push   $0x0
  801aa6:	6a 00                	push   $0x0
  801aa8:	ff 75 08             	pushl  0x8(%ebp)
  801aab:	6a 2d                	push   $0x2d
  801aad:	e8 eb f9 ff ff       	call   80149d <syscall>
  801ab2:	83 c4 18             	add    $0x18,%esp
	return ;
  801ab5:	90                   	nop
}
  801ab6:	c9                   	leave  
  801ab7:	c3                   	ret    

00801ab8 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801ab8:	55                   	push   %ebp
  801ab9:	89 e5                	mov    %esp,%ebp
  801abb:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801abc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801abf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ac2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ac5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac8:	6a 00                	push   $0x0
  801aca:	53                   	push   %ebx
  801acb:	51                   	push   %ecx
  801acc:	52                   	push   %edx
  801acd:	50                   	push   %eax
  801ace:	6a 2e                	push   $0x2e
  801ad0:	e8 c8 f9 ff ff       	call   80149d <syscall>
  801ad5:	83 c4 18             	add    $0x18,%esp
}
  801ad8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801adb:	c9                   	leave  
  801adc:	c3                   	ret    

00801add <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801add:	55                   	push   %ebp
  801ade:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801ae0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	6a 00                	push   $0x0
  801aec:	52                   	push   %edx
  801aed:	50                   	push   %eax
  801aee:	6a 2f                	push   $0x2f
  801af0:	e8 a8 f9 ff ff       	call   80149d <syscall>
  801af5:	83 c4 18             	add    $0x18,%esp
}
  801af8:	c9                   	leave  
  801af9:	c3                   	ret    
  801afa:	66 90                	xchg   %ax,%ax

00801afc <__udivdi3>:
  801afc:	55                   	push   %ebp
  801afd:	57                   	push   %edi
  801afe:	56                   	push   %esi
  801aff:	53                   	push   %ebx
  801b00:	83 ec 1c             	sub    $0x1c,%esp
  801b03:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b07:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801b0b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b0f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b13:	89 ca                	mov    %ecx,%edx
  801b15:	89 f8                	mov    %edi,%eax
  801b17:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801b1b:	85 f6                	test   %esi,%esi
  801b1d:	75 2d                	jne    801b4c <__udivdi3+0x50>
  801b1f:	39 cf                	cmp    %ecx,%edi
  801b21:	77 65                	ja     801b88 <__udivdi3+0x8c>
  801b23:	89 fd                	mov    %edi,%ebp
  801b25:	85 ff                	test   %edi,%edi
  801b27:	75 0b                	jne    801b34 <__udivdi3+0x38>
  801b29:	b8 01 00 00 00       	mov    $0x1,%eax
  801b2e:	31 d2                	xor    %edx,%edx
  801b30:	f7 f7                	div    %edi
  801b32:	89 c5                	mov    %eax,%ebp
  801b34:	31 d2                	xor    %edx,%edx
  801b36:	89 c8                	mov    %ecx,%eax
  801b38:	f7 f5                	div    %ebp
  801b3a:	89 c1                	mov    %eax,%ecx
  801b3c:	89 d8                	mov    %ebx,%eax
  801b3e:	f7 f5                	div    %ebp
  801b40:	89 cf                	mov    %ecx,%edi
  801b42:	89 fa                	mov    %edi,%edx
  801b44:	83 c4 1c             	add    $0x1c,%esp
  801b47:	5b                   	pop    %ebx
  801b48:	5e                   	pop    %esi
  801b49:	5f                   	pop    %edi
  801b4a:	5d                   	pop    %ebp
  801b4b:	c3                   	ret    
  801b4c:	39 ce                	cmp    %ecx,%esi
  801b4e:	77 28                	ja     801b78 <__udivdi3+0x7c>
  801b50:	0f bd fe             	bsr    %esi,%edi
  801b53:	83 f7 1f             	xor    $0x1f,%edi
  801b56:	75 40                	jne    801b98 <__udivdi3+0x9c>
  801b58:	39 ce                	cmp    %ecx,%esi
  801b5a:	72 0a                	jb     801b66 <__udivdi3+0x6a>
  801b5c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b60:	0f 87 9e 00 00 00    	ja     801c04 <__udivdi3+0x108>
  801b66:	b8 01 00 00 00       	mov    $0x1,%eax
  801b6b:	89 fa                	mov    %edi,%edx
  801b6d:	83 c4 1c             	add    $0x1c,%esp
  801b70:	5b                   	pop    %ebx
  801b71:	5e                   	pop    %esi
  801b72:	5f                   	pop    %edi
  801b73:	5d                   	pop    %ebp
  801b74:	c3                   	ret    
  801b75:	8d 76 00             	lea    0x0(%esi),%esi
  801b78:	31 ff                	xor    %edi,%edi
  801b7a:	31 c0                	xor    %eax,%eax
  801b7c:	89 fa                	mov    %edi,%edx
  801b7e:	83 c4 1c             	add    $0x1c,%esp
  801b81:	5b                   	pop    %ebx
  801b82:	5e                   	pop    %esi
  801b83:	5f                   	pop    %edi
  801b84:	5d                   	pop    %ebp
  801b85:	c3                   	ret    
  801b86:	66 90                	xchg   %ax,%ax
  801b88:	89 d8                	mov    %ebx,%eax
  801b8a:	f7 f7                	div    %edi
  801b8c:	31 ff                	xor    %edi,%edi
  801b8e:	89 fa                	mov    %edi,%edx
  801b90:	83 c4 1c             	add    $0x1c,%esp
  801b93:	5b                   	pop    %ebx
  801b94:	5e                   	pop    %esi
  801b95:	5f                   	pop    %edi
  801b96:	5d                   	pop    %ebp
  801b97:	c3                   	ret    
  801b98:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b9d:	89 eb                	mov    %ebp,%ebx
  801b9f:	29 fb                	sub    %edi,%ebx
  801ba1:	89 f9                	mov    %edi,%ecx
  801ba3:	d3 e6                	shl    %cl,%esi
  801ba5:	89 c5                	mov    %eax,%ebp
  801ba7:	88 d9                	mov    %bl,%cl
  801ba9:	d3 ed                	shr    %cl,%ebp
  801bab:	89 e9                	mov    %ebp,%ecx
  801bad:	09 f1                	or     %esi,%ecx
  801baf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801bb3:	89 f9                	mov    %edi,%ecx
  801bb5:	d3 e0                	shl    %cl,%eax
  801bb7:	89 c5                	mov    %eax,%ebp
  801bb9:	89 d6                	mov    %edx,%esi
  801bbb:	88 d9                	mov    %bl,%cl
  801bbd:	d3 ee                	shr    %cl,%esi
  801bbf:	89 f9                	mov    %edi,%ecx
  801bc1:	d3 e2                	shl    %cl,%edx
  801bc3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bc7:	88 d9                	mov    %bl,%cl
  801bc9:	d3 e8                	shr    %cl,%eax
  801bcb:	09 c2                	or     %eax,%edx
  801bcd:	89 d0                	mov    %edx,%eax
  801bcf:	89 f2                	mov    %esi,%edx
  801bd1:	f7 74 24 0c          	divl   0xc(%esp)
  801bd5:	89 d6                	mov    %edx,%esi
  801bd7:	89 c3                	mov    %eax,%ebx
  801bd9:	f7 e5                	mul    %ebp
  801bdb:	39 d6                	cmp    %edx,%esi
  801bdd:	72 19                	jb     801bf8 <__udivdi3+0xfc>
  801bdf:	74 0b                	je     801bec <__udivdi3+0xf0>
  801be1:	89 d8                	mov    %ebx,%eax
  801be3:	31 ff                	xor    %edi,%edi
  801be5:	e9 58 ff ff ff       	jmp    801b42 <__udivdi3+0x46>
  801bea:	66 90                	xchg   %ax,%ax
  801bec:	8b 54 24 08          	mov    0x8(%esp),%edx
  801bf0:	89 f9                	mov    %edi,%ecx
  801bf2:	d3 e2                	shl    %cl,%edx
  801bf4:	39 c2                	cmp    %eax,%edx
  801bf6:	73 e9                	jae    801be1 <__udivdi3+0xe5>
  801bf8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801bfb:	31 ff                	xor    %edi,%edi
  801bfd:	e9 40 ff ff ff       	jmp    801b42 <__udivdi3+0x46>
  801c02:	66 90                	xchg   %ax,%ax
  801c04:	31 c0                	xor    %eax,%eax
  801c06:	e9 37 ff ff ff       	jmp    801b42 <__udivdi3+0x46>
  801c0b:	90                   	nop

00801c0c <__umoddi3>:
  801c0c:	55                   	push   %ebp
  801c0d:	57                   	push   %edi
  801c0e:	56                   	push   %esi
  801c0f:	53                   	push   %ebx
  801c10:	83 ec 1c             	sub    $0x1c,%esp
  801c13:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801c17:	8b 74 24 34          	mov    0x34(%esp),%esi
  801c1b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c1f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801c23:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c27:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c2b:	89 f3                	mov    %esi,%ebx
  801c2d:	89 fa                	mov    %edi,%edx
  801c2f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c33:	89 34 24             	mov    %esi,(%esp)
  801c36:	85 c0                	test   %eax,%eax
  801c38:	75 1a                	jne    801c54 <__umoddi3+0x48>
  801c3a:	39 f7                	cmp    %esi,%edi
  801c3c:	0f 86 a2 00 00 00    	jbe    801ce4 <__umoddi3+0xd8>
  801c42:	89 c8                	mov    %ecx,%eax
  801c44:	89 f2                	mov    %esi,%edx
  801c46:	f7 f7                	div    %edi
  801c48:	89 d0                	mov    %edx,%eax
  801c4a:	31 d2                	xor    %edx,%edx
  801c4c:	83 c4 1c             	add    $0x1c,%esp
  801c4f:	5b                   	pop    %ebx
  801c50:	5e                   	pop    %esi
  801c51:	5f                   	pop    %edi
  801c52:	5d                   	pop    %ebp
  801c53:	c3                   	ret    
  801c54:	39 f0                	cmp    %esi,%eax
  801c56:	0f 87 ac 00 00 00    	ja     801d08 <__umoddi3+0xfc>
  801c5c:	0f bd e8             	bsr    %eax,%ebp
  801c5f:	83 f5 1f             	xor    $0x1f,%ebp
  801c62:	0f 84 ac 00 00 00    	je     801d14 <__umoddi3+0x108>
  801c68:	bf 20 00 00 00       	mov    $0x20,%edi
  801c6d:	29 ef                	sub    %ebp,%edi
  801c6f:	89 fe                	mov    %edi,%esi
  801c71:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c75:	89 e9                	mov    %ebp,%ecx
  801c77:	d3 e0                	shl    %cl,%eax
  801c79:	89 d7                	mov    %edx,%edi
  801c7b:	89 f1                	mov    %esi,%ecx
  801c7d:	d3 ef                	shr    %cl,%edi
  801c7f:	09 c7                	or     %eax,%edi
  801c81:	89 e9                	mov    %ebp,%ecx
  801c83:	d3 e2                	shl    %cl,%edx
  801c85:	89 14 24             	mov    %edx,(%esp)
  801c88:	89 d8                	mov    %ebx,%eax
  801c8a:	d3 e0                	shl    %cl,%eax
  801c8c:	89 c2                	mov    %eax,%edx
  801c8e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c92:	d3 e0                	shl    %cl,%eax
  801c94:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c98:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c9c:	89 f1                	mov    %esi,%ecx
  801c9e:	d3 e8                	shr    %cl,%eax
  801ca0:	09 d0                	or     %edx,%eax
  801ca2:	d3 eb                	shr    %cl,%ebx
  801ca4:	89 da                	mov    %ebx,%edx
  801ca6:	f7 f7                	div    %edi
  801ca8:	89 d3                	mov    %edx,%ebx
  801caa:	f7 24 24             	mull   (%esp)
  801cad:	89 c6                	mov    %eax,%esi
  801caf:	89 d1                	mov    %edx,%ecx
  801cb1:	39 d3                	cmp    %edx,%ebx
  801cb3:	0f 82 87 00 00 00    	jb     801d40 <__umoddi3+0x134>
  801cb9:	0f 84 91 00 00 00    	je     801d50 <__umoddi3+0x144>
  801cbf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801cc3:	29 f2                	sub    %esi,%edx
  801cc5:	19 cb                	sbb    %ecx,%ebx
  801cc7:	89 d8                	mov    %ebx,%eax
  801cc9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ccd:	d3 e0                	shl    %cl,%eax
  801ccf:	89 e9                	mov    %ebp,%ecx
  801cd1:	d3 ea                	shr    %cl,%edx
  801cd3:	09 d0                	or     %edx,%eax
  801cd5:	89 e9                	mov    %ebp,%ecx
  801cd7:	d3 eb                	shr    %cl,%ebx
  801cd9:	89 da                	mov    %ebx,%edx
  801cdb:	83 c4 1c             	add    $0x1c,%esp
  801cde:	5b                   	pop    %ebx
  801cdf:	5e                   	pop    %esi
  801ce0:	5f                   	pop    %edi
  801ce1:	5d                   	pop    %ebp
  801ce2:	c3                   	ret    
  801ce3:	90                   	nop
  801ce4:	89 fd                	mov    %edi,%ebp
  801ce6:	85 ff                	test   %edi,%edi
  801ce8:	75 0b                	jne    801cf5 <__umoddi3+0xe9>
  801cea:	b8 01 00 00 00       	mov    $0x1,%eax
  801cef:	31 d2                	xor    %edx,%edx
  801cf1:	f7 f7                	div    %edi
  801cf3:	89 c5                	mov    %eax,%ebp
  801cf5:	89 f0                	mov    %esi,%eax
  801cf7:	31 d2                	xor    %edx,%edx
  801cf9:	f7 f5                	div    %ebp
  801cfb:	89 c8                	mov    %ecx,%eax
  801cfd:	f7 f5                	div    %ebp
  801cff:	89 d0                	mov    %edx,%eax
  801d01:	e9 44 ff ff ff       	jmp    801c4a <__umoddi3+0x3e>
  801d06:	66 90                	xchg   %ax,%ax
  801d08:	89 c8                	mov    %ecx,%eax
  801d0a:	89 f2                	mov    %esi,%edx
  801d0c:	83 c4 1c             	add    $0x1c,%esp
  801d0f:	5b                   	pop    %ebx
  801d10:	5e                   	pop    %esi
  801d11:	5f                   	pop    %edi
  801d12:	5d                   	pop    %ebp
  801d13:	c3                   	ret    
  801d14:	3b 04 24             	cmp    (%esp),%eax
  801d17:	72 06                	jb     801d1f <__umoddi3+0x113>
  801d19:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801d1d:	77 0f                	ja     801d2e <__umoddi3+0x122>
  801d1f:	89 f2                	mov    %esi,%edx
  801d21:	29 f9                	sub    %edi,%ecx
  801d23:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d27:	89 14 24             	mov    %edx,(%esp)
  801d2a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d2e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d32:	8b 14 24             	mov    (%esp),%edx
  801d35:	83 c4 1c             	add    $0x1c,%esp
  801d38:	5b                   	pop    %ebx
  801d39:	5e                   	pop    %esi
  801d3a:	5f                   	pop    %edi
  801d3b:	5d                   	pop    %ebp
  801d3c:	c3                   	ret    
  801d3d:	8d 76 00             	lea    0x0(%esi),%esi
  801d40:	2b 04 24             	sub    (%esp),%eax
  801d43:	19 fa                	sbb    %edi,%edx
  801d45:	89 d1                	mov    %edx,%ecx
  801d47:	89 c6                	mov    %eax,%esi
  801d49:	e9 71 ff ff ff       	jmp    801cbf <__umoddi3+0xb3>
  801d4e:	66 90                	xchg   %ax,%ax
  801d50:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d54:	72 ea                	jb     801d40 <__umoddi3+0x134>
  801d56:	89 d9                	mov    %ebx,%ecx
  801d58:	e9 62 ff ff ff       	jmp    801cbf <__umoddi3+0xb3>
