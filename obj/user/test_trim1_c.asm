
obj/user/test_trim1_c:     file format elf32-i386


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
  800031:	e8 e3 00 00 00       	call   800119 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
uint32 requiredMemFrames;
uint32 extraFramesNeeded ;
uint32 memFramesToAllocate;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	remainingfreeframes = sys_calculate_free_frames();
  80003e:	e8 86 14 00 00       	call   8014c9 <sys_calculate_free_frames>
  800043:	a3 00 31 80 00       	mov    %eax,0x803100
	memFramesToAllocate = (remainingfreeframes+0);
  800048:	a1 00 31 80 00       	mov    0x803100,%eax
  80004d:	a3 20 31 80 00       	mov    %eax,0x803120

	requiredMemFrames = sys_calculate_required_frames(USER_HEAP_START, memFramesToAllocate*PAGE_SIZE);
  800052:	a1 20 31 80 00       	mov    0x803120,%eax
  800057:	c1 e0 0c             	shl    $0xc,%eax
  80005a:	83 ec 08             	sub    $0x8,%esp
  80005d:	50                   	push   %eax
  80005e:	68 00 00 00 80       	push   $0x80000000
  800063:	e8 46 14 00 00       	call   8014ae <sys_calculate_required_frames>
  800068:	83 c4 10             	add    $0x10,%esp
  80006b:	a3 04 31 80 00       	mov    %eax,0x803104
	extraFramesNeeded = requiredMemFrames - remainingfreeframes;
  800070:	8b 15 04 31 80 00    	mov    0x803104,%edx
  800076:	a1 00 31 80 00       	mov    0x803100,%eax
  80007b:	29 c2                	sub    %eax,%edx
  80007d:	89 d0                	mov    %edx,%eax
  80007f:	a3 1c 31 80 00       	mov    %eax,0x80311c
	
	//cprintf("remaining frames = %d\n",remainingfreeframes);
	//cprintf("frames desired to be allocated = %d\n",memFramesToAllocate);
	//cprintf("req frames = %d\n",requiredMemFrames);
	
	uint32 size = (memFramesToAllocate)*PAGE_SIZE;
  800084:	a1 20 31 80 00       	mov    0x803120,%eax
  800089:	c1 e0 0c             	shl    $0xc,%eax
  80008c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	char* x = malloc(sizeof(char)*size);
  80008f:	83 ec 0c             	sub    $0xc,%esp
  800092:	ff 75 f0             	pushl  -0x10(%ebp)
  800095:	e8 22 10 00 00       	call   8010bc <malloc>
  80009a:	83 c4 10             	add    $0x10,%esp
  80009d:	89 45 ec             	mov    %eax,-0x14(%ebp)

	uint32 i=0;
  8000a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for(i=0; i<size;i++ )
  8000a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000ae:	eb 0e                	jmp    8000be <_main+0x86>
	{
		x[i]=-1;
  8000b0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8000b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000b6:	01 d0                	add    %edx,%eax
  8000b8:	c6 00 ff             	movb   $0xff,(%eax)
	
	uint32 size = (memFramesToAllocate)*PAGE_SIZE;
	char* x = malloc(sizeof(char)*size);

	uint32 i=0;
	for(i=0; i<size;i++ )
  8000bb:	ff 45 f4             	incl   -0xc(%ebp)
  8000be:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000c1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8000c4:	72 ea                	jb     8000b0 <_main+0x78>
	{
		x[i]=-1;
	}

	uint32 all_frames_to_be_trimmed = ROUNDUP(extraFramesNeeded*2, 3);
  8000c6:	c7 45 e8 03 00 00 00 	movl   $0x3,-0x18(%ebp)
  8000cd:	a1 1c 31 80 00       	mov    0x80311c,%eax
  8000d2:	01 c0                	add    %eax,%eax
  8000d4:	89 c2                	mov    %eax,%edx
  8000d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000d9:	01 d0                	add    %edx,%eax
  8000db:	48                   	dec    %eax
  8000dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000e2:	ba 00 00 00 00       	mov    $0x0,%edx
  8000e7:	f7 75 e8             	divl   -0x18(%ebp)
  8000ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000ed:	29 d0                	sub    %edx,%eax
  8000ef:	89 45 e0             	mov    %eax,-0x20(%ebp)
	uint32 frames_to_trimmed_every_env = all_frames_to_be_trimmed/3;
  8000f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000f5:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
  8000fa:	f7 e2                	mul    %edx
  8000fc:	89 d0                	mov    %edx,%eax
  8000fe:	d1 e8                	shr    %eax
  800100:	89 45 dc             	mov    %eax,-0x24(%ebp)

	cprintf("Frames to be trimmed from A or B = %d\n", frames_to_trimmed_every_env);
  800103:	83 ec 08             	sub    $0x8,%esp
  800106:	ff 75 dc             	pushl  -0x24(%ebp)
  800109:	68 00 1e 80 00       	push   $0x801e00
  80010e:	e8 1f 02 00 00       	call   800332 <cprintf>
  800113:	83 c4 10             	add    $0x10,%esp

	return;	
  800116:	90                   	nop
}
  800117:	c9                   	leave  
  800118:	c3                   	ret    

00800119 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800119:	55                   	push   %ebp
  80011a:	89 e5                	mov    %esp,%ebp
  80011c:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80011f:	e8 da 12 00 00       	call   8013fe <sys_getenvindex>
  800124:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800127:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80012a:	89 d0                	mov    %edx,%eax
  80012c:	c1 e0 03             	shl    $0x3,%eax
  80012f:	01 d0                	add    %edx,%eax
  800131:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800138:	01 c8                	add    %ecx,%eax
  80013a:	01 c0                	add    %eax,%eax
  80013c:	01 d0                	add    %edx,%eax
  80013e:	01 c0                	add    %eax,%eax
  800140:	01 d0                	add    %edx,%eax
  800142:	89 c2                	mov    %eax,%edx
  800144:	c1 e2 05             	shl    $0x5,%edx
  800147:	29 c2                	sub    %eax,%edx
  800149:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800150:	89 c2                	mov    %eax,%edx
  800152:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800158:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80015d:	a1 20 30 80 00       	mov    0x803020,%eax
  800162:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800168:	84 c0                	test   %al,%al
  80016a:	74 0f                	je     80017b <libmain+0x62>
		binaryname = myEnv->prog_name;
  80016c:	a1 20 30 80 00       	mov    0x803020,%eax
  800171:	05 40 3c 01 00       	add    $0x13c40,%eax
  800176:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80017b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80017f:	7e 0a                	jle    80018b <libmain+0x72>
		binaryname = argv[0];
  800181:	8b 45 0c             	mov    0xc(%ebp),%eax
  800184:	8b 00                	mov    (%eax),%eax
  800186:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80018b:	83 ec 08             	sub    $0x8,%esp
  80018e:	ff 75 0c             	pushl  0xc(%ebp)
  800191:	ff 75 08             	pushl  0x8(%ebp)
  800194:	e8 9f fe ff ff       	call   800038 <_main>
  800199:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80019c:	e8 f8 13 00 00       	call   801599 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001a1:	83 ec 0c             	sub    $0xc,%esp
  8001a4:	68 40 1e 80 00       	push   $0x801e40
  8001a9:	e8 84 01 00 00       	call   800332 <cprintf>
  8001ae:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b6:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8001bc:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c1:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8001c7:	83 ec 04             	sub    $0x4,%esp
  8001ca:	52                   	push   %edx
  8001cb:	50                   	push   %eax
  8001cc:	68 68 1e 80 00       	push   $0x801e68
  8001d1:	e8 5c 01 00 00       	call   800332 <cprintf>
  8001d6:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8001d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8001de:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8001e4:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e9:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8001ef:	83 ec 04             	sub    $0x4,%esp
  8001f2:	52                   	push   %edx
  8001f3:	50                   	push   %eax
  8001f4:	68 90 1e 80 00       	push   $0x801e90
  8001f9:	e8 34 01 00 00       	call   800332 <cprintf>
  8001fe:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800201:	a1 20 30 80 00       	mov    0x803020,%eax
  800206:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80020c:	83 ec 08             	sub    $0x8,%esp
  80020f:	50                   	push   %eax
  800210:	68 d1 1e 80 00       	push   $0x801ed1
  800215:	e8 18 01 00 00       	call   800332 <cprintf>
  80021a:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80021d:	83 ec 0c             	sub    $0xc,%esp
  800220:	68 40 1e 80 00       	push   $0x801e40
  800225:	e8 08 01 00 00       	call   800332 <cprintf>
  80022a:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80022d:	e8 81 13 00 00       	call   8015b3 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800232:	e8 19 00 00 00       	call   800250 <exit>
}
  800237:	90                   	nop
  800238:	c9                   	leave  
  800239:	c3                   	ret    

0080023a <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80023a:	55                   	push   %ebp
  80023b:	89 e5                	mov    %esp,%ebp
  80023d:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800240:	83 ec 0c             	sub    $0xc,%esp
  800243:	6a 00                	push   $0x0
  800245:	e8 80 11 00 00       	call   8013ca <sys_env_destroy>
  80024a:	83 c4 10             	add    $0x10,%esp
}
  80024d:	90                   	nop
  80024e:	c9                   	leave  
  80024f:	c3                   	ret    

00800250 <exit>:

void
exit(void)
{
  800250:	55                   	push   %ebp
  800251:	89 e5                	mov    %esp,%ebp
  800253:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800256:	e8 d5 11 00 00       	call   801430 <sys_env_exit>
}
  80025b:	90                   	nop
  80025c:	c9                   	leave  
  80025d:	c3                   	ret    

0080025e <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80025e:	55                   	push   %ebp
  80025f:	89 e5                	mov    %esp,%ebp
  800261:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800264:	8b 45 0c             	mov    0xc(%ebp),%eax
  800267:	8b 00                	mov    (%eax),%eax
  800269:	8d 48 01             	lea    0x1(%eax),%ecx
  80026c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80026f:	89 0a                	mov    %ecx,(%edx)
  800271:	8b 55 08             	mov    0x8(%ebp),%edx
  800274:	88 d1                	mov    %dl,%cl
  800276:	8b 55 0c             	mov    0xc(%ebp),%edx
  800279:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80027d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800280:	8b 00                	mov    (%eax),%eax
  800282:	3d ff 00 00 00       	cmp    $0xff,%eax
  800287:	75 2c                	jne    8002b5 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800289:	a0 24 30 80 00       	mov    0x803024,%al
  80028e:	0f b6 c0             	movzbl %al,%eax
  800291:	8b 55 0c             	mov    0xc(%ebp),%edx
  800294:	8b 12                	mov    (%edx),%edx
  800296:	89 d1                	mov    %edx,%ecx
  800298:	8b 55 0c             	mov    0xc(%ebp),%edx
  80029b:	83 c2 08             	add    $0x8,%edx
  80029e:	83 ec 04             	sub    $0x4,%esp
  8002a1:	50                   	push   %eax
  8002a2:	51                   	push   %ecx
  8002a3:	52                   	push   %edx
  8002a4:	e8 df 10 00 00       	call   801388 <sys_cputs>
  8002a9:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8002ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002af:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8002b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002b8:	8b 40 04             	mov    0x4(%eax),%eax
  8002bb:	8d 50 01             	lea    0x1(%eax),%edx
  8002be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002c1:	89 50 04             	mov    %edx,0x4(%eax)
}
  8002c4:	90                   	nop
  8002c5:	c9                   	leave  
  8002c6:	c3                   	ret    

008002c7 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8002c7:	55                   	push   %ebp
  8002c8:	89 e5                	mov    %esp,%ebp
  8002ca:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8002d0:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8002d7:	00 00 00 
	b.cnt = 0;
  8002da:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8002e1:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8002e4:	ff 75 0c             	pushl  0xc(%ebp)
  8002e7:	ff 75 08             	pushl  0x8(%ebp)
  8002ea:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002f0:	50                   	push   %eax
  8002f1:	68 5e 02 80 00       	push   $0x80025e
  8002f6:	e8 11 02 00 00       	call   80050c <vprintfmt>
  8002fb:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8002fe:	a0 24 30 80 00       	mov    0x803024,%al
  800303:	0f b6 c0             	movzbl %al,%eax
  800306:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80030c:	83 ec 04             	sub    $0x4,%esp
  80030f:	50                   	push   %eax
  800310:	52                   	push   %edx
  800311:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800317:	83 c0 08             	add    $0x8,%eax
  80031a:	50                   	push   %eax
  80031b:	e8 68 10 00 00       	call   801388 <sys_cputs>
  800320:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800323:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80032a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800330:	c9                   	leave  
  800331:	c3                   	ret    

00800332 <cprintf>:

int cprintf(const char *fmt, ...) {
  800332:	55                   	push   %ebp
  800333:	89 e5                	mov    %esp,%ebp
  800335:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800338:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80033f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800342:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800345:	8b 45 08             	mov    0x8(%ebp),%eax
  800348:	83 ec 08             	sub    $0x8,%esp
  80034b:	ff 75 f4             	pushl  -0xc(%ebp)
  80034e:	50                   	push   %eax
  80034f:	e8 73 ff ff ff       	call   8002c7 <vcprintf>
  800354:	83 c4 10             	add    $0x10,%esp
  800357:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80035a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80035d:	c9                   	leave  
  80035e:	c3                   	ret    

0080035f <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80035f:	55                   	push   %ebp
  800360:	89 e5                	mov    %esp,%ebp
  800362:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800365:	e8 2f 12 00 00       	call   801599 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80036a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80036d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800370:	8b 45 08             	mov    0x8(%ebp),%eax
  800373:	83 ec 08             	sub    $0x8,%esp
  800376:	ff 75 f4             	pushl  -0xc(%ebp)
  800379:	50                   	push   %eax
  80037a:	e8 48 ff ff ff       	call   8002c7 <vcprintf>
  80037f:	83 c4 10             	add    $0x10,%esp
  800382:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800385:	e8 29 12 00 00       	call   8015b3 <sys_enable_interrupt>
	return cnt;
  80038a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80038d:	c9                   	leave  
  80038e:	c3                   	ret    

0080038f <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80038f:	55                   	push   %ebp
  800390:	89 e5                	mov    %esp,%ebp
  800392:	53                   	push   %ebx
  800393:	83 ec 14             	sub    $0x14,%esp
  800396:	8b 45 10             	mov    0x10(%ebp),%eax
  800399:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80039c:	8b 45 14             	mov    0x14(%ebp),%eax
  80039f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8003a2:	8b 45 18             	mov    0x18(%ebp),%eax
  8003a5:	ba 00 00 00 00       	mov    $0x0,%edx
  8003aa:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003ad:	77 55                	ja     800404 <printnum+0x75>
  8003af:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003b2:	72 05                	jb     8003b9 <printnum+0x2a>
  8003b4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003b7:	77 4b                	ja     800404 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8003b9:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8003bc:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8003bf:	8b 45 18             	mov    0x18(%ebp),%eax
  8003c2:	ba 00 00 00 00       	mov    $0x0,%edx
  8003c7:	52                   	push   %edx
  8003c8:	50                   	push   %eax
  8003c9:	ff 75 f4             	pushl  -0xc(%ebp)
  8003cc:	ff 75 f0             	pushl  -0x10(%ebp)
  8003cf:	e8 b4 17 00 00       	call   801b88 <__udivdi3>
  8003d4:	83 c4 10             	add    $0x10,%esp
  8003d7:	83 ec 04             	sub    $0x4,%esp
  8003da:	ff 75 20             	pushl  0x20(%ebp)
  8003dd:	53                   	push   %ebx
  8003de:	ff 75 18             	pushl  0x18(%ebp)
  8003e1:	52                   	push   %edx
  8003e2:	50                   	push   %eax
  8003e3:	ff 75 0c             	pushl  0xc(%ebp)
  8003e6:	ff 75 08             	pushl  0x8(%ebp)
  8003e9:	e8 a1 ff ff ff       	call   80038f <printnum>
  8003ee:	83 c4 20             	add    $0x20,%esp
  8003f1:	eb 1a                	jmp    80040d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8003f3:	83 ec 08             	sub    $0x8,%esp
  8003f6:	ff 75 0c             	pushl  0xc(%ebp)
  8003f9:	ff 75 20             	pushl  0x20(%ebp)
  8003fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ff:	ff d0                	call   *%eax
  800401:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800404:	ff 4d 1c             	decl   0x1c(%ebp)
  800407:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80040b:	7f e6                	jg     8003f3 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80040d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800410:	bb 00 00 00 00       	mov    $0x0,%ebx
  800415:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800418:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80041b:	53                   	push   %ebx
  80041c:	51                   	push   %ecx
  80041d:	52                   	push   %edx
  80041e:	50                   	push   %eax
  80041f:	e8 74 18 00 00       	call   801c98 <__umoddi3>
  800424:	83 c4 10             	add    $0x10,%esp
  800427:	05 14 21 80 00       	add    $0x802114,%eax
  80042c:	8a 00                	mov    (%eax),%al
  80042e:	0f be c0             	movsbl %al,%eax
  800431:	83 ec 08             	sub    $0x8,%esp
  800434:	ff 75 0c             	pushl  0xc(%ebp)
  800437:	50                   	push   %eax
  800438:	8b 45 08             	mov    0x8(%ebp),%eax
  80043b:	ff d0                	call   *%eax
  80043d:	83 c4 10             	add    $0x10,%esp
}
  800440:	90                   	nop
  800441:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800444:	c9                   	leave  
  800445:	c3                   	ret    

00800446 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800446:	55                   	push   %ebp
  800447:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800449:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80044d:	7e 1c                	jle    80046b <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80044f:	8b 45 08             	mov    0x8(%ebp),%eax
  800452:	8b 00                	mov    (%eax),%eax
  800454:	8d 50 08             	lea    0x8(%eax),%edx
  800457:	8b 45 08             	mov    0x8(%ebp),%eax
  80045a:	89 10                	mov    %edx,(%eax)
  80045c:	8b 45 08             	mov    0x8(%ebp),%eax
  80045f:	8b 00                	mov    (%eax),%eax
  800461:	83 e8 08             	sub    $0x8,%eax
  800464:	8b 50 04             	mov    0x4(%eax),%edx
  800467:	8b 00                	mov    (%eax),%eax
  800469:	eb 40                	jmp    8004ab <getuint+0x65>
	else if (lflag)
  80046b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80046f:	74 1e                	je     80048f <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800471:	8b 45 08             	mov    0x8(%ebp),%eax
  800474:	8b 00                	mov    (%eax),%eax
  800476:	8d 50 04             	lea    0x4(%eax),%edx
  800479:	8b 45 08             	mov    0x8(%ebp),%eax
  80047c:	89 10                	mov    %edx,(%eax)
  80047e:	8b 45 08             	mov    0x8(%ebp),%eax
  800481:	8b 00                	mov    (%eax),%eax
  800483:	83 e8 04             	sub    $0x4,%eax
  800486:	8b 00                	mov    (%eax),%eax
  800488:	ba 00 00 00 00       	mov    $0x0,%edx
  80048d:	eb 1c                	jmp    8004ab <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80048f:	8b 45 08             	mov    0x8(%ebp),%eax
  800492:	8b 00                	mov    (%eax),%eax
  800494:	8d 50 04             	lea    0x4(%eax),%edx
  800497:	8b 45 08             	mov    0x8(%ebp),%eax
  80049a:	89 10                	mov    %edx,(%eax)
  80049c:	8b 45 08             	mov    0x8(%ebp),%eax
  80049f:	8b 00                	mov    (%eax),%eax
  8004a1:	83 e8 04             	sub    $0x4,%eax
  8004a4:	8b 00                	mov    (%eax),%eax
  8004a6:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8004ab:	5d                   	pop    %ebp
  8004ac:	c3                   	ret    

008004ad <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8004ad:	55                   	push   %ebp
  8004ae:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004b0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004b4:	7e 1c                	jle    8004d2 <getint+0x25>
		return va_arg(*ap, long long);
  8004b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b9:	8b 00                	mov    (%eax),%eax
  8004bb:	8d 50 08             	lea    0x8(%eax),%edx
  8004be:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c1:	89 10                	mov    %edx,(%eax)
  8004c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c6:	8b 00                	mov    (%eax),%eax
  8004c8:	83 e8 08             	sub    $0x8,%eax
  8004cb:	8b 50 04             	mov    0x4(%eax),%edx
  8004ce:	8b 00                	mov    (%eax),%eax
  8004d0:	eb 38                	jmp    80050a <getint+0x5d>
	else if (lflag)
  8004d2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004d6:	74 1a                	je     8004f2 <getint+0x45>
		return va_arg(*ap, long);
  8004d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004db:	8b 00                	mov    (%eax),%eax
  8004dd:	8d 50 04             	lea    0x4(%eax),%edx
  8004e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e3:	89 10                	mov    %edx,(%eax)
  8004e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e8:	8b 00                	mov    (%eax),%eax
  8004ea:	83 e8 04             	sub    $0x4,%eax
  8004ed:	8b 00                	mov    (%eax),%eax
  8004ef:	99                   	cltd   
  8004f0:	eb 18                	jmp    80050a <getint+0x5d>
	else
		return va_arg(*ap, int);
  8004f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f5:	8b 00                	mov    (%eax),%eax
  8004f7:	8d 50 04             	lea    0x4(%eax),%edx
  8004fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8004fd:	89 10                	mov    %edx,(%eax)
  8004ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800502:	8b 00                	mov    (%eax),%eax
  800504:	83 e8 04             	sub    $0x4,%eax
  800507:	8b 00                	mov    (%eax),%eax
  800509:	99                   	cltd   
}
  80050a:	5d                   	pop    %ebp
  80050b:	c3                   	ret    

0080050c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80050c:	55                   	push   %ebp
  80050d:	89 e5                	mov    %esp,%ebp
  80050f:	56                   	push   %esi
  800510:	53                   	push   %ebx
  800511:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800514:	eb 17                	jmp    80052d <vprintfmt+0x21>
			if (ch == '\0')
  800516:	85 db                	test   %ebx,%ebx
  800518:	0f 84 af 03 00 00    	je     8008cd <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80051e:	83 ec 08             	sub    $0x8,%esp
  800521:	ff 75 0c             	pushl  0xc(%ebp)
  800524:	53                   	push   %ebx
  800525:	8b 45 08             	mov    0x8(%ebp),%eax
  800528:	ff d0                	call   *%eax
  80052a:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80052d:	8b 45 10             	mov    0x10(%ebp),%eax
  800530:	8d 50 01             	lea    0x1(%eax),%edx
  800533:	89 55 10             	mov    %edx,0x10(%ebp)
  800536:	8a 00                	mov    (%eax),%al
  800538:	0f b6 d8             	movzbl %al,%ebx
  80053b:	83 fb 25             	cmp    $0x25,%ebx
  80053e:	75 d6                	jne    800516 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800540:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800544:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80054b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800552:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800559:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800560:	8b 45 10             	mov    0x10(%ebp),%eax
  800563:	8d 50 01             	lea    0x1(%eax),%edx
  800566:	89 55 10             	mov    %edx,0x10(%ebp)
  800569:	8a 00                	mov    (%eax),%al
  80056b:	0f b6 d8             	movzbl %al,%ebx
  80056e:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800571:	83 f8 55             	cmp    $0x55,%eax
  800574:	0f 87 2b 03 00 00    	ja     8008a5 <vprintfmt+0x399>
  80057a:	8b 04 85 38 21 80 00 	mov    0x802138(,%eax,4),%eax
  800581:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800583:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800587:	eb d7                	jmp    800560 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800589:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80058d:	eb d1                	jmp    800560 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80058f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800596:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800599:	89 d0                	mov    %edx,%eax
  80059b:	c1 e0 02             	shl    $0x2,%eax
  80059e:	01 d0                	add    %edx,%eax
  8005a0:	01 c0                	add    %eax,%eax
  8005a2:	01 d8                	add    %ebx,%eax
  8005a4:	83 e8 30             	sub    $0x30,%eax
  8005a7:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8005aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8005ad:	8a 00                	mov    (%eax),%al
  8005af:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8005b2:	83 fb 2f             	cmp    $0x2f,%ebx
  8005b5:	7e 3e                	jle    8005f5 <vprintfmt+0xe9>
  8005b7:	83 fb 39             	cmp    $0x39,%ebx
  8005ba:	7f 39                	jg     8005f5 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005bc:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8005bf:	eb d5                	jmp    800596 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8005c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c4:	83 c0 04             	add    $0x4,%eax
  8005c7:	89 45 14             	mov    %eax,0x14(%ebp)
  8005ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8005cd:	83 e8 04             	sub    $0x4,%eax
  8005d0:	8b 00                	mov    (%eax),%eax
  8005d2:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8005d5:	eb 1f                	jmp    8005f6 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8005d7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005db:	79 83                	jns    800560 <vprintfmt+0x54>
				width = 0;
  8005dd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8005e4:	e9 77 ff ff ff       	jmp    800560 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8005e9:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8005f0:	e9 6b ff ff ff       	jmp    800560 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8005f5:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8005f6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005fa:	0f 89 60 ff ff ff    	jns    800560 <vprintfmt+0x54>
				width = precision, precision = -1;
  800600:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800603:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800606:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80060d:	e9 4e ff ff ff       	jmp    800560 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800612:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800615:	e9 46 ff ff ff       	jmp    800560 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80061a:	8b 45 14             	mov    0x14(%ebp),%eax
  80061d:	83 c0 04             	add    $0x4,%eax
  800620:	89 45 14             	mov    %eax,0x14(%ebp)
  800623:	8b 45 14             	mov    0x14(%ebp),%eax
  800626:	83 e8 04             	sub    $0x4,%eax
  800629:	8b 00                	mov    (%eax),%eax
  80062b:	83 ec 08             	sub    $0x8,%esp
  80062e:	ff 75 0c             	pushl  0xc(%ebp)
  800631:	50                   	push   %eax
  800632:	8b 45 08             	mov    0x8(%ebp),%eax
  800635:	ff d0                	call   *%eax
  800637:	83 c4 10             	add    $0x10,%esp
			break;
  80063a:	e9 89 02 00 00       	jmp    8008c8 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80063f:	8b 45 14             	mov    0x14(%ebp),%eax
  800642:	83 c0 04             	add    $0x4,%eax
  800645:	89 45 14             	mov    %eax,0x14(%ebp)
  800648:	8b 45 14             	mov    0x14(%ebp),%eax
  80064b:	83 e8 04             	sub    $0x4,%eax
  80064e:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800650:	85 db                	test   %ebx,%ebx
  800652:	79 02                	jns    800656 <vprintfmt+0x14a>
				err = -err;
  800654:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800656:	83 fb 64             	cmp    $0x64,%ebx
  800659:	7f 0b                	jg     800666 <vprintfmt+0x15a>
  80065b:	8b 34 9d 80 1f 80 00 	mov    0x801f80(,%ebx,4),%esi
  800662:	85 f6                	test   %esi,%esi
  800664:	75 19                	jne    80067f <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800666:	53                   	push   %ebx
  800667:	68 25 21 80 00       	push   $0x802125
  80066c:	ff 75 0c             	pushl  0xc(%ebp)
  80066f:	ff 75 08             	pushl  0x8(%ebp)
  800672:	e8 5e 02 00 00       	call   8008d5 <printfmt>
  800677:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80067a:	e9 49 02 00 00       	jmp    8008c8 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80067f:	56                   	push   %esi
  800680:	68 2e 21 80 00       	push   $0x80212e
  800685:	ff 75 0c             	pushl  0xc(%ebp)
  800688:	ff 75 08             	pushl  0x8(%ebp)
  80068b:	e8 45 02 00 00       	call   8008d5 <printfmt>
  800690:	83 c4 10             	add    $0x10,%esp
			break;
  800693:	e9 30 02 00 00       	jmp    8008c8 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800698:	8b 45 14             	mov    0x14(%ebp),%eax
  80069b:	83 c0 04             	add    $0x4,%eax
  80069e:	89 45 14             	mov    %eax,0x14(%ebp)
  8006a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8006a4:	83 e8 04             	sub    $0x4,%eax
  8006a7:	8b 30                	mov    (%eax),%esi
  8006a9:	85 f6                	test   %esi,%esi
  8006ab:	75 05                	jne    8006b2 <vprintfmt+0x1a6>
				p = "(null)";
  8006ad:	be 31 21 80 00       	mov    $0x802131,%esi
			if (width > 0 && padc != '-')
  8006b2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006b6:	7e 6d                	jle    800725 <vprintfmt+0x219>
  8006b8:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8006bc:	74 67                	je     800725 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8006be:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006c1:	83 ec 08             	sub    $0x8,%esp
  8006c4:	50                   	push   %eax
  8006c5:	56                   	push   %esi
  8006c6:	e8 0c 03 00 00       	call   8009d7 <strnlen>
  8006cb:	83 c4 10             	add    $0x10,%esp
  8006ce:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8006d1:	eb 16                	jmp    8006e9 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8006d3:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8006d7:	83 ec 08             	sub    $0x8,%esp
  8006da:	ff 75 0c             	pushl  0xc(%ebp)
  8006dd:	50                   	push   %eax
  8006de:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e1:	ff d0                	call   *%eax
  8006e3:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006e6:	ff 4d e4             	decl   -0x1c(%ebp)
  8006e9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006ed:	7f e4                	jg     8006d3 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006ef:	eb 34                	jmp    800725 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8006f1:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8006f5:	74 1c                	je     800713 <vprintfmt+0x207>
  8006f7:	83 fb 1f             	cmp    $0x1f,%ebx
  8006fa:	7e 05                	jle    800701 <vprintfmt+0x1f5>
  8006fc:	83 fb 7e             	cmp    $0x7e,%ebx
  8006ff:	7e 12                	jle    800713 <vprintfmt+0x207>
					putch('?', putdat);
  800701:	83 ec 08             	sub    $0x8,%esp
  800704:	ff 75 0c             	pushl  0xc(%ebp)
  800707:	6a 3f                	push   $0x3f
  800709:	8b 45 08             	mov    0x8(%ebp),%eax
  80070c:	ff d0                	call   *%eax
  80070e:	83 c4 10             	add    $0x10,%esp
  800711:	eb 0f                	jmp    800722 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800713:	83 ec 08             	sub    $0x8,%esp
  800716:	ff 75 0c             	pushl  0xc(%ebp)
  800719:	53                   	push   %ebx
  80071a:	8b 45 08             	mov    0x8(%ebp),%eax
  80071d:	ff d0                	call   *%eax
  80071f:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800722:	ff 4d e4             	decl   -0x1c(%ebp)
  800725:	89 f0                	mov    %esi,%eax
  800727:	8d 70 01             	lea    0x1(%eax),%esi
  80072a:	8a 00                	mov    (%eax),%al
  80072c:	0f be d8             	movsbl %al,%ebx
  80072f:	85 db                	test   %ebx,%ebx
  800731:	74 24                	je     800757 <vprintfmt+0x24b>
  800733:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800737:	78 b8                	js     8006f1 <vprintfmt+0x1e5>
  800739:	ff 4d e0             	decl   -0x20(%ebp)
  80073c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800740:	79 af                	jns    8006f1 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800742:	eb 13                	jmp    800757 <vprintfmt+0x24b>
				putch(' ', putdat);
  800744:	83 ec 08             	sub    $0x8,%esp
  800747:	ff 75 0c             	pushl  0xc(%ebp)
  80074a:	6a 20                	push   $0x20
  80074c:	8b 45 08             	mov    0x8(%ebp),%eax
  80074f:	ff d0                	call   *%eax
  800751:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800754:	ff 4d e4             	decl   -0x1c(%ebp)
  800757:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80075b:	7f e7                	jg     800744 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80075d:	e9 66 01 00 00       	jmp    8008c8 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800762:	83 ec 08             	sub    $0x8,%esp
  800765:	ff 75 e8             	pushl  -0x18(%ebp)
  800768:	8d 45 14             	lea    0x14(%ebp),%eax
  80076b:	50                   	push   %eax
  80076c:	e8 3c fd ff ff       	call   8004ad <getint>
  800771:	83 c4 10             	add    $0x10,%esp
  800774:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800777:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80077a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80077d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800780:	85 d2                	test   %edx,%edx
  800782:	79 23                	jns    8007a7 <vprintfmt+0x29b>
				putch('-', putdat);
  800784:	83 ec 08             	sub    $0x8,%esp
  800787:	ff 75 0c             	pushl  0xc(%ebp)
  80078a:	6a 2d                	push   $0x2d
  80078c:	8b 45 08             	mov    0x8(%ebp),%eax
  80078f:	ff d0                	call   *%eax
  800791:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800794:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800797:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80079a:	f7 d8                	neg    %eax
  80079c:	83 d2 00             	adc    $0x0,%edx
  80079f:	f7 da                	neg    %edx
  8007a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007a4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8007a7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007ae:	e9 bc 00 00 00       	jmp    80086f <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8007b3:	83 ec 08             	sub    $0x8,%esp
  8007b6:	ff 75 e8             	pushl  -0x18(%ebp)
  8007b9:	8d 45 14             	lea    0x14(%ebp),%eax
  8007bc:	50                   	push   %eax
  8007bd:	e8 84 fc ff ff       	call   800446 <getuint>
  8007c2:	83 c4 10             	add    $0x10,%esp
  8007c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007c8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8007cb:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007d2:	e9 98 00 00 00       	jmp    80086f <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8007d7:	83 ec 08             	sub    $0x8,%esp
  8007da:	ff 75 0c             	pushl  0xc(%ebp)
  8007dd:	6a 58                	push   $0x58
  8007df:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e2:	ff d0                	call   *%eax
  8007e4:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007e7:	83 ec 08             	sub    $0x8,%esp
  8007ea:	ff 75 0c             	pushl  0xc(%ebp)
  8007ed:	6a 58                	push   $0x58
  8007ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f2:	ff d0                	call   *%eax
  8007f4:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007f7:	83 ec 08             	sub    $0x8,%esp
  8007fa:	ff 75 0c             	pushl  0xc(%ebp)
  8007fd:	6a 58                	push   $0x58
  8007ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800802:	ff d0                	call   *%eax
  800804:	83 c4 10             	add    $0x10,%esp
			break;
  800807:	e9 bc 00 00 00       	jmp    8008c8 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80080c:	83 ec 08             	sub    $0x8,%esp
  80080f:	ff 75 0c             	pushl  0xc(%ebp)
  800812:	6a 30                	push   $0x30
  800814:	8b 45 08             	mov    0x8(%ebp),%eax
  800817:	ff d0                	call   *%eax
  800819:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80081c:	83 ec 08             	sub    $0x8,%esp
  80081f:	ff 75 0c             	pushl  0xc(%ebp)
  800822:	6a 78                	push   $0x78
  800824:	8b 45 08             	mov    0x8(%ebp),%eax
  800827:	ff d0                	call   *%eax
  800829:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80082c:	8b 45 14             	mov    0x14(%ebp),%eax
  80082f:	83 c0 04             	add    $0x4,%eax
  800832:	89 45 14             	mov    %eax,0x14(%ebp)
  800835:	8b 45 14             	mov    0x14(%ebp),%eax
  800838:	83 e8 04             	sub    $0x4,%eax
  80083b:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80083d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800840:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800847:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80084e:	eb 1f                	jmp    80086f <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800850:	83 ec 08             	sub    $0x8,%esp
  800853:	ff 75 e8             	pushl  -0x18(%ebp)
  800856:	8d 45 14             	lea    0x14(%ebp),%eax
  800859:	50                   	push   %eax
  80085a:	e8 e7 fb ff ff       	call   800446 <getuint>
  80085f:	83 c4 10             	add    $0x10,%esp
  800862:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800865:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800868:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80086f:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800873:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800876:	83 ec 04             	sub    $0x4,%esp
  800879:	52                   	push   %edx
  80087a:	ff 75 e4             	pushl  -0x1c(%ebp)
  80087d:	50                   	push   %eax
  80087e:	ff 75 f4             	pushl  -0xc(%ebp)
  800881:	ff 75 f0             	pushl  -0x10(%ebp)
  800884:	ff 75 0c             	pushl  0xc(%ebp)
  800887:	ff 75 08             	pushl  0x8(%ebp)
  80088a:	e8 00 fb ff ff       	call   80038f <printnum>
  80088f:	83 c4 20             	add    $0x20,%esp
			break;
  800892:	eb 34                	jmp    8008c8 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800894:	83 ec 08             	sub    $0x8,%esp
  800897:	ff 75 0c             	pushl  0xc(%ebp)
  80089a:	53                   	push   %ebx
  80089b:	8b 45 08             	mov    0x8(%ebp),%eax
  80089e:	ff d0                	call   *%eax
  8008a0:	83 c4 10             	add    $0x10,%esp
			break;
  8008a3:	eb 23                	jmp    8008c8 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8008a5:	83 ec 08             	sub    $0x8,%esp
  8008a8:	ff 75 0c             	pushl  0xc(%ebp)
  8008ab:	6a 25                	push   $0x25
  8008ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b0:	ff d0                	call   *%eax
  8008b2:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8008b5:	ff 4d 10             	decl   0x10(%ebp)
  8008b8:	eb 03                	jmp    8008bd <vprintfmt+0x3b1>
  8008ba:	ff 4d 10             	decl   0x10(%ebp)
  8008bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8008c0:	48                   	dec    %eax
  8008c1:	8a 00                	mov    (%eax),%al
  8008c3:	3c 25                	cmp    $0x25,%al
  8008c5:	75 f3                	jne    8008ba <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8008c7:	90                   	nop
		}
	}
  8008c8:	e9 47 fc ff ff       	jmp    800514 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8008cd:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8008ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008d1:	5b                   	pop    %ebx
  8008d2:	5e                   	pop    %esi
  8008d3:	5d                   	pop    %ebp
  8008d4:	c3                   	ret    

008008d5 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8008d5:	55                   	push   %ebp
  8008d6:	89 e5                	mov    %esp,%ebp
  8008d8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8008db:	8d 45 10             	lea    0x10(%ebp),%eax
  8008de:	83 c0 04             	add    $0x4,%eax
  8008e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8008e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8008e7:	ff 75 f4             	pushl  -0xc(%ebp)
  8008ea:	50                   	push   %eax
  8008eb:	ff 75 0c             	pushl  0xc(%ebp)
  8008ee:	ff 75 08             	pushl  0x8(%ebp)
  8008f1:	e8 16 fc ff ff       	call   80050c <vprintfmt>
  8008f6:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8008f9:	90                   	nop
  8008fa:	c9                   	leave  
  8008fb:	c3                   	ret    

008008fc <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8008fc:	55                   	push   %ebp
  8008fd:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8008ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800902:	8b 40 08             	mov    0x8(%eax),%eax
  800905:	8d 50 01             	lea    0x1(%eax),%edx
  800908:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80090e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800911:	8b 10                	mov    (%eax),%edx
  800913:	8b 45 0c             	mov    0xc(%ebp),%eax
  800916:	8b 40 04             	mov    0x4(%eax),%eax
  800919:	39 c2                	cmp    %eax,%edx
  80091b:	73 12                	jae    80092f <sprintputch+0x33>
		*b->buf++ = ch;
  80091d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800920:	8b 00                	mov    (%eax),%eax
  800922:	8d 48 01             	lea    0x1(%eax),%ecx
  800925:	8b 55 0c             	mov    0xc(%ebp),%edx
  800928:	89 0a                	mov    %ecx,(%edx)
  80092a:	8b 55 08             	mov    0x8(%ebp),%edx
  80092d:	88 10                	mov    %dl,(%eax)
}
  80092f:	90                   	nop
  800930:	5d                   	pop    %ebp
  800931:	c3                   	ret    

00800932 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800932:	55                   	push   %ebp
  800933:	89 e5                	mov    %esp,%ebp
  800935:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800938:	8b 45 08             	mov    0x8(%ebp),%eax
  80093b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80093e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800941:	8d 50 ff             	lea    -0x1(%eax),%edx
  800944:	8b 45 08             	mov    0x8(%ebp),%eax
  800947:	01 d0                	add    %edx,%eax
  800949:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80094c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800953:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800957:	74 06                	je     80095f <vsnprintf+0x2d>
  800959:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80095d:	7f 07                	jg     800966 <vsnprintf+0x34>
		return -E_INVAL;
  80095f:	b8 03 00 00 00       	mov    $0x3,%eax
  800964:	eb 20                	jmp    800986 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800966:	ff 75 14             	pushl  0x14(%ebp)
  800969:	ff 75 10             	pushl  0x10(%ebp)
  80096c:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80096f:	50                   	push   %eax
  800970:	68 fc 08 80 00       	push   $0x8008fc
  800975:	e8 92 fb ff ff       	call   80050c <vprintfmt>
  80097a:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80097d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800980:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800983:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800986:	c9                   	leave  
  800987:	c3                   	ret    

00800988 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800988:	55                   	push   %ebp
  800989:	89 e5                	mov    %esp,%ebp
  80098b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80098e:	8d 45 10             	lea    0x10(%ebp),%eax
  800991:	83 c0 04             	add    $0x4,%eax
  800994:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800997:	8b 45 10             	mov    0x10(%ebp),%eax
  80099a:	ff 75 f4             	pushl  -0xc(%ebp)
  80099d:	50                   	push   %eax
  80099e:	ff 75 0c             	pushl  0xc(%ebp)
  8009a1:	ff 75 08             	pushl  0x8(%ebp)
  8009a4:	e8 89 ff ff ff       	call   800932 <vsnprintf>
  8009a9:	83 c4 10             	add    $0x10,%esp
  8009ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8009af:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009b2:	c9                   	leave  
  8009b3:	c3                   	ret    

008009b4 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8009b4:	55                   	push   %ebp
  8009b5:	89 e5                	mov    %esp,%ebp
  8009b7:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8009ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009c1:	eb 06                	jmp    8009c9 <strlen+0x15>
		n++;
  8009c3:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8009c6:	ff 45 08             	incl   0x8(%ebp)
  8009c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cc:	8a 00                	mov    (%eax),%al
  8009ce:	84 c0                	test   %al,%al
  8009d0:	75 f1                	jne    8009c3 <strlen+0xf>
		n++;
	return n;
  8009d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009d5:	c9                   	leave  
  8009d6:	c3                   	ret    

008009d7 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8009d7:	55                   	push   %ebp
  8009d8:	89 e5                	mov    %esp,%ebp
  8009da:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009dd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009e4:	eb 09                	jmp    8009ef <strnlen+0x18>
		n++;
  8009e6:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009e9:	ff 45 08             	incl   0x8(%ebp)
  8009ec:	ff 4d 0c             	decl   0xc(%ebp)
  8009ef:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009f3:	74 09                	je     8009fe <strnlen+0x27>
  8009f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f8:	8a 00                	mov    (%eax),%al
  8009fa:	84 c0                	test   %al,%al
  8009fc:	75 e8                	jne    8009e6 <strnlen+0xf>
		n++;
	return n;
  8009fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a01:	c9                   	leave  
  800a02:	c3                   	ret    

00800a03 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800a03:	55                   	push   %ebp
  800a04:	89 e5                	mov    %esp,%ebp
  800a06:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800a09:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800a0f:	90                   	nop
  800a10:	8b 45 08             	mov    0x8(%ebp),%eax
  800a13:	8d 50 01             	lea    0x1(%eax),%edx
  800a16:	89 55 08             	mov    %edx,0x8(%ebp)
  800a19:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a1c:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a1f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a22:	8a 12                	mov    (%edx),%dl
  800a24:	88 10                	mov    %dl,(%eax)
  800a26:	8a 00                	mov    (%eax),%al
  800a28:	84 c0                	test   %al,%al
  800a2a:	75 e4                	jne    800a10 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a2f:	c9                   	leave  
  800a30:	c3                   	ret    

00800a31 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a31:	55                   	push   %ebp
  800a32:	89 e5                	mov    %esp,%ebp
  800a34:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a37:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a3d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a44:	eb 1f                	jmp    800a65 <strncpy+0x34>
		*dst++ = *src;
  800a46:	8b 45 08             	mov    0x8(%ebp),%eax
  800a49:	8d 50 01             	lea    0x1(%eax),%edx
  800a4c:	89 55 08             	mov    %edx,0x8(%ebp)
  800a4f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a52:	8a 12                	mov    (%edx),%dl
  800a54:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a59:	8a 00                	mov    (%eax),%al
  800a5b:	84 c0                	test   %al,%al
  800a5d:	74 03                	je     800a62 <strncpy+0x31>
			src++;
  800a5f:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a62:	ff 45 fc             	incl   -0x4(%ebp)
  800a65:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a68:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a6b:	72 d9                	jb     800a46 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a6d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a70:	c9                   	leave  
  800a71:	c3                   	ret    

00800a72 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a72:	55                   	push   %ebp
  800a73:	89 e5                	mov    %esp,%ebp
  800a75:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a78:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a7e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a82:	74 30                	je     800ab4 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a84:	eb 16                	jmp    800a9c <strlcpy+0x2a>
			*dst++ = *src++;
  800a86:	8b 45 08             	mov    0x8(%ebp),%eax
  800a89:	8d 50 01             	lea    0x1(%eax),%edx
  800a8c:	89 55 08             	mov    %edx,0x8(%ebp)
  800a8f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a92:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a95:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a98:	8a 12                	mov    (%edx),%dl
  800a9a:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a9c:	ff 4d 10             	decl   0x10(%ebp)
  800a9f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800aa3:	74 09                	je     800aae <strlcpy+0x3c>
  800aa5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa8:	8a 00                	mov    (%eax),%al
  800aaa:	84 c0                	test   %al,%al
  800aac:	75 d8                	jne    800a86 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800aae:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab1:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ab4:	8b 55 08             	mov    0x8(%ebp),%edx
  800ab7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800aba:	29 c2                	sub    %eax,%edx
  800abc:	89 d0                	mov    %edx,%eax
}
  800abe:	c9                   	leave  
  800abf:	c3                   	ret    

00800ac0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ac0:	55                   	push   %ebp
  800ac1:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ac3:	eb 06                	jmp    800acb <strcmp+0xb>
		p++, q++;
  800ac5:	ff 45 08             	incl   0x8(%ebp)
  800ac8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800acb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ace:	8a 00                	mov    (%eax),%al
  800ad0:	84 c0                	test   %al,%al
  800ad2:	74 0e                	je     800ae2 <strcmp+0x22>
  800ad4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad7:	8a 10                	mov    (%eax),%dl
  800ad9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800adc:	8a 00                	mov    (%eax),%al
  800ade:	38 c2                	cmp    %al,%dl
  800ae0:	74 e3                	je     800ac5 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ae2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae5:	8a 00                	mov    (%eax),%al
  800ae7:	0f b6 d0             	movzbl %al,%edx
  800aea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aed:	8a 00                	mov    (%eax),%al
  800aef:	0f b6 c0             	movzbl %al,%eax
  800af2:	29 c2                	sub    %eax,%edx
  800af4:	89 d0                	mov    %edx,%eax
}
  800af6:	5d                   	pop    %ebp
  800af7:	c3                   	ret    

00800af8 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800af8:	55                   	push   %ebp
  800af9:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800afb:	eb 09                	jmp    800b06 <strncmp+0xe>
		n--, p++, q++;
  800afd:	ff 4d 10             	decl   0x10(%ebp)
  800b00:	ff 45 08             	incl   0x8(%ebp)
  800b03:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800b06:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b0a:	74 17                	je     800b23 <strncmp+0x2b>
  800b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0f:	8a 00                	mov    (%eax),%al
  800b11:	84 c0                	test   %al,%al
  800b13:	74 0e                	je     800b23 <strncmp+0x2b>
  800b15:	8b 45 08             	mov    0x8(%ebp),%eax
  800b18:	8a 10                	mov    (%eax),%dl
  800b1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1d:	8a 00                	mov    (%eax),%al
  800b1f:	38 c2                	cmp    %al,%dl
  800b21:	74 da                	je     800afd <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800b23:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b27:	75 07                	jne    800b30 <strncmp+0x38>
		return 0;
  800b29:	b8 00 00 00 00       	mov    $0x0,%eax
  800b2e:	eb 14                	jmp    800b44 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b30:	8b 45 08             	mov    0x8(%ebp),%eax
  800b33:	8a 00                	mov    (%eax),%al
  800b35:	0f b6 d0             	movzbl %al,%edx
  800b38:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3b:	8a 00                	mov    (%eax),%al
  800b3d:	0f b6 c0             	movzbl %al,%eax
  800b40:	29 c2                	sub    %eax,%edx
  800b42:	89 d0                	mov    %edx,%eax
}
  800b44:	5d                   	pop    %ebp
  800b45:	c3                   	ret    

00800b46 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b46:	55                   	push   %ebp
  800b47:	89 e5                	mov    %esp,%ebp
  800b49:	83 ec 04             	sub    $0x4,%esp
  800b4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b4f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b52:	eb 12                	jmp    800b66 <strchr+0x20>
		if (*s == c)
  800b54:	8b 45 08             	mov    0x8(%ebp),%eax
  800b57:	8a 00                	mov    (%eax),%al
  800b59:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b5c:	75 05                	jne    800b63 <strchr+0x1d>
			return (char *) s;
  800b5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b61:	eb 11                	jmp    800b74 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b63:	ff 45 08             	incl   0x8(%ebp)
  800b66:	8b 45 08             	mov    0x8(%ebp),%eax
  800b69:	8a 00                	mov    (%eax),%al
  800b6b:	84 c0                	test   %al,%al
  800b6d:	75 e5                	jne    800b54 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b6f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b74:	c9                   	leave  
  800b75:	c3                   	ret    

00800b76 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b76:	55                   	push   %ebp
  800b77:	89 e5                	mov    %esp,%ebp
  800b79:	83 ec 04             	sub    $0x4,%esp
  800b7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b7f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b82:	eb 0d                	jmp    800b91 <strfind+0x1b>
		if (*s == c)
  800b84:	8b 45 08             	mov    0x8(%ebp),%eax
  800b87:	8a 00                	mov    (%eax),%al
  800b89:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b8c:	74 0e                	je     800b9c <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b8e:	ff 45 08             	incl   0x8(%ebp)
  800b91:	8b 45 08             	mov    0x8(%ebp),%eax
  800b94:	8a 00                	mov    (%eax),%al
  800b96:	84 c0                	test   %al,%al
  800b98:	75 ea                	jne    800b84 <strfind+0xe>
  800b9a:	eb 01                	jmp    800b9d <strfind+0x27>
		if (*s == c)
			break;
  800b9c:	90                   	nop
	return (char *) s;
  800b9d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ba0:	c9                   	leave  
  800ba1:	c3                   	ret    

00800ba2 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ba2:	55                   	push   %ebp
  800ba3:	89 e5                	mov    %esp,%ebp
  800ba5:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ba8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bab:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800bae:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800bb4:	eb 0e                	jmp    800bc4 <memset+0x22>
		*p++ = c;
  800bb6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bb9:	8d 50 01             	lea    0x1(%eax),%edx
  800bbc:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800bbf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc2:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800bc4:	ff 4d f8             	decl   -0x8(%ebp)
  800bc7:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800bcb:	79 e9                	jns    800bb6 <memset+0x14>
		*p++ = c;

	return v;
  800bcd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bd0:	c9                   	leave  
  800bd1:	c3                   	ret    

00800bd2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800bd2:	55                   	push   %ebp
  800bd3:	89 e5                	mov    %esp,%ebp
  800bd5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800bd8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bdb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800bde:	8b 45 08             	mov    0x8(%ebp),%eax
  800be1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800be4:	eb 16                	jmp    800bfc <memcpy+0x2a>
		*d++ = *s++;
  800be6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800be9:	8d 50 01             	lea    0x1(%eax),%edx
  800bec:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bef:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bf2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bf5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bf8:	8a 12                	mov    (%edx),%dl
  800bfa:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800bfc:	8b 45 10             	mov    0x10(%ebp),%eax
  800bff:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c02:	89 55 10             	mov    %edx,0x10(%ebp)
  800c05:	85 c0                	test   %eax,%eax
  800c07:	75 dd                	jne    800be6 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800c09:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c0c:	c9                   	leave  
  800c0d:	c3                   	ret    

00800c0e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800c0e:	55                   	push   %ebp
  800c0f:	89 e5                	mov    %esp,%ebp
  800c11:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c17:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800c20:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c23:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c26:	73 50                	jae    800c78 <memmove+0x6a>
  800c28:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c2e:	01 d0                	add    %edx,%eax
  800c30:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c33:	76 43                	jbe    800c78 <memmove+0x6a>
		s += n;
  800c35:	8b 45 10             	mov    0x10(%ebp),%eax
  800c38:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c3b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3e:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c41:	eb 10                	jmp    800c53 <memmove+0x45>
			*--d = *--s;
  800c43:	ff 4d f8             	decl   -0x8(%ebp)
  800c46:	ff 4d fc             	decl   -0x4(%ebp)
  800c49:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c4c:	8a 10                	mov    (%eax),%dl
  800c4e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c51:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800c53:	8b 45 10             	mov    0x10(%ebp),%eax
  800c56:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c59:	89 55 10             	mov    %edx,0x10(%ebp)
  800c5c:	85 c0                	test   %eax,%eax
  800c5e:	75 e3                	jne    800c43 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c60:	eb 23                	jmp    800c85 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c62:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c65:	8d 50 01             	lea    0x1(%eax),%edx
  800c68:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c6b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c6e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c71:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c74:	8a 12                	mov    (%edx),%dl
  800c76:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c78:	8b 45 10             	mov    0x10(%ebp),%eax
  800c7b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c7e:	89 55 10             	mov    %edx,0x10(%ebp)
  800c81:	85 c0                	test   %eax,%eax
  800c83:	75 dd                	jne    800c62 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c85:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c88:	c9                   	leave  
  800c89:	c3                   	ret    

00800c8a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c8a:	55                   	push   %ebp
  800c8b:	89 e5                	mov    %esp,%ebp
  800c8d:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c90:	8b 45 08             	mov    0x8(%ebp),%eax
  800c93:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c99:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c9c:	eb 2a                	jmp    800cc8 <memcmp+0x3e>
		if (*s1 != *s2)
  800c9e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ca1:	8a 10                	mov    (%eax),%dl
  800ca3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ca6:	8a 00                	mov    (%eax),%al
  800ca8:	38 c2                	cmp    %al,%dl
  800caa:	74 16                	je     800cc2 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800cac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800caf:	8a 00                	mov    (%eax),%al
  800cb1:	0f b6 d0             	movzbl %al,%edx
  800cb4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cb7:	8a 00                	mov    (%eax),%al
  800cb9:	0f b6 c0             	movzbl %al,%eax
  800cbc:	29 c2                	sub    %eax,%edx
  800cbe:	89 d0                	mov    %edx,%eax
  800cc0:	eb 18                	jmp    800cda <memcmp+0x50>
		s1++, s2++;
  800cc2:	ff 45 fc             	incl   -0x4(%ebp)
  800cc5:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800cc8:	8b 45 10             	mov    0x10(%ebp),%eax
  800ccb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cce:	89 55 10             	mov    %edx,0x10(%ebp)
  800cd1:	85 c0                	test   %eax,%eax
  800cd3:	75 c9                	jne    800c9e <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800cd5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cda:	c9                   	leave  
  800cdb:	c3                   	ret    

00800cdc <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800cdc:	55                   	push   %ebp
  800cdd:	89 e5                	mov    %esp,%ebp
  800cdf:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800ce2:	8b 55 08             	mov    0x8(%ebp),%edx
  800ce5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce8:	01 d0                	add    %edx,%eax
  800cea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ced:	eb 15                	jmp    800d04 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800cef:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf2:	8a 00                	mov    (%eax),%al
  800cf4:	0f b6 d0             	movzbl %al,%edx
  800cf7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cfa:	0f b6 c0             	movzbl %al,%eax
  800cfd:	39 c2                	cmp    %eax,%edx
  800cff:	74 0d                	je     800d0e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800d01:	ff 45 08             	incl   0x8(%ebp)
  800d04:	8b 45 08             	mov    0x8(%ebp),%eax
  800d07:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800d0a:	72 e3                	jb     800cef <memfind+0x13>
  800d0c:	eb 01                	jmp    800d0f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800d0e:	90                   	nop
	return (void *) s;
  800d0f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d12:	c9                   	leave  
  800d13:	c3                   	ret    

00800d14 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800d14:	55                   	push   %ebp
  800d15:	89 e5                	mov    %esp,%ebp
  800d17:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d1a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800d21:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d28:	eb 03                	jmp    800d2d <strtol+0x19>
		s++;
  800d2a:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d30:	8a 00                	mov    (%eax),%al
  800d32:	3c 20                	cmp    $0x20,%al
  800d34:	74 f4                	je     800d2a <strtol+0x16>
  800d36:	8b 45 08             	mov    0x8(%ebp),%eax
  800d39:	8a 00                	mov    (%eax),%al
  800d3b:	3c 09                	cmp    $0x9,%al
  800d3d:	74 eb                	je     800d2a <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d42:	8a 00                	mov    (%eax),%al
  800d44:	3c 2b                	cmp    $0x2b,%al
  800d46:	75 05                	jne    800d4d <strtol+0x39>
		s++;
  800d48:	ff 45 08             	incl   0x8(%ebp)
  800d4b:	eb 13                	jmp    800d60 <strtol+0x4c>
	else if (*s == '-')
  800d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d50:	8a 00                	mov    (%eax),%al
  800d52:	3c 2d                	cmp    $0x2d,%al
  800d54:	75 0a                	jne    800d60 <strtol+0x4c>
		s++, neg = 1;
  800d56:	ff 45 08             	incl   0x8(%ebp)
  800d59:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d60:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d64:	74 06                	je     800d6c <strtol+0x58>
  800d66:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d6a:	75 20                	jne    800d8c <strtol+0x78>
  800d6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6f:	8a 00                	mov    (%eax),%al
  800d71:	3c 30                	cmp    $0x30,%al
  800d73:	75 17                	jne    800d8c <strtol+0x78>
  800d75:	8b 45 08             	mov    0x8(%ebp),%eax
  800d78:	40                   	inc    %eax
  800d79:	8a 00                	mov    (%eax),%al
  800d7b:	3c 78                	cmp    $0x78,%al
  800d7d:	75 0d                	jne    800d8c <strtol+0x78>
		s += 2, base = 16;
  800d7f:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d83:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d8a:	eb 28                	jmp    800db4 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d8c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d90:	75 15                	jne    800da7 <strtol+0x93>
  800d92:	8b 45 08             	mov    0x8(%ebp),%eax
  800d95:	8a 00                	mov    (%eax),%al
  800d97:	3c 30                	cmp    $0x30,%al
  800d99:	75 0c                	jne    800da7 <strtol+0x93>
		s++, base = 8;
  800d9b:	ff 45 08             	incl   0x8(%ebp)
  800d9e:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800da5:	eb 0d                	jmp    800db4 <strtol+0xa0>
	else if (base == 0)
  800da7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dab:	75 07                	jne    800db4 <strtol+0xa0>
		base = 10;
  800dad:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800db4:	8b 45 08             	mov    0x8(%ebp),%eax
  800db7:	8a 00                	mov    (%eax),%al
  800db9:	3c 2f                	cmp    $0x2f,%al
  800dbb:	7e 19                	jle    800dd6 <strtol+0xc2>
  800dbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc0:	8a 00                	mov    (%eax),%al
  800dc2:	3c 39                	cmp    $0x39,%al
  800dc4:	7f 10                	jg     800dd6 <strtol+0xc2>
			dig = *s - '0';
  800dc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc9:	8a 00                	mov    (%eax),%al
  800dcb:	0f be c0             	movsbl %al,%eax
  800dce:	83 e8 30             	sub    $0x30,%eax
  800dd1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dd4:	eb 42                	jmp    800e18 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd9:	8a 00                	mov    (%eax),%al
  800ddb:	3c 60                	cmp    $0x60,%al
  800ddd:	7e 19                	jle    800df8 <strtol+0xe4>
  800ddf:	8b 45 08             	mov    0x8(%ebp),%eax
  800de2:	8a 00                	mov    (%eax),%al
  800de4:	3c 7a                	cmp    $0x7a,%al
  800de6:	7f 10                	jg     800df8 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800de8:	8b 45 08             	mov    0x8(%ebp),%eax
  800deb:	8a 00                	mov    (%eax),%al
  800ded:	0f be c0             	movsbl %al,%eax
  800df0:	83 e8 57             	sub    $0x57,%eax
  800df3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800df6:	eb 20                	jmp    800e18 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800df8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfb:	8a 00                	mov    (%eax),%al
  800dfd:	3c 40                	cmp    $0x40,%al
  800dff:	7e 39                	jle    800e3a <strtol+0x126>
  800e01:	8b 45 08             	mov    0x8(%ebp),%eax
  800e04:	8a 00                	mov    (%eax),%al
  800e06:	3c 5a                	cmp    $0x5a,%al
  800e08:	7f 30                	jg     800e3a <strtol+0x126>
			dig = *s - 'A' + 10;
  800e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0d:	8a 00                	mov    (%eax),%al
  800e0f:	0f be c0             	movsbl %al,%eax
  800e12:	83 e8 37             	sub    $0x37,%eax
  800e15:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e18:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e1b:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e1e:	7d 19                	jge    800e39 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800e20:	ff 45 08             	incl   0x8(%ebp)
  800e23:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e26:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e2a:	89 c2                	mov    %eax,%edx
  800e2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e2f:	01 d0                	add    %edx,%eax
  800e31:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e34:	e9 7b ff ff ff       	jmp    800db4 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e39:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e3a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e3e:	74 08                	je     800e48 <strtol+0x134>
		*endptr = (char *) s;
  800e40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e43:	8b 55 08             	mov    0x8(%ebp),%edx
  800e46:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e48:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e4c:	74 07                	je     800e55 <strtol+0x141>
  800e4e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e51:	f7 d8                	neg    %eax
  800e53:	eb 03                	jmp    800e58 <strtol+0x144>
  800e55:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e58:	c9                   	leave  
  800e59:	c3                   	ret    

00800e5a <ltostr>:

void
ltostr(long value, char *str)
{
  800e5a:	55                   	push   %ebp
  800e5b:	89 e5                	mov    %esp,%ebp
  800e5d:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e60:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e67:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e6e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e72:	79 13                	jns    800e87 <ltostr+0x2d>
	{
		neg = 1;
  800e74:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7e:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e81:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e84:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e87:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8a:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e8f:	99                   	cltd   
  800e90:	f7 f9                	idiv   %ecx
  800e92:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e95:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e98:	8d 50 01             	lea    0x1(%eax),%edx
  800e9b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e9e:	89 c2                	mov    %eax,%edx
  800ea0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea3:	01 d0                	add    %edx,%eax
  800ea5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800ea8:	83 c2 30             	add    $0x30,%edx
  800eab:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800ead:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800eb0:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800eb5:	f7 e9                	imul   %ecx
  800eb7:	c1 fa 02             	sar    $0x2,%edx
  800eba:	89 c8                	mov    %ecx,%eax
  800ebc:	c1 f8 1f             	sar    $0x1f,%eax
  800ebf:	29 c2                	sub    %eax,%edx
  800ec1:	89 d0                	mov    %edx,%eax
  800ec3:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800ec6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ec9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800ece:	f7 e9                	imul   %ecx
  800ed0:	c1 fa 02             	sar    $0x2,%edx
  800ed3:	89 c8                	mov    %ecx,%eax
  800ed5:	c1 f8 1f             	sar    $0x1f,%eax
  800ed8:	29 c2                	sub    %eax,%edx
  800eda:	89 d0                	mov    %edx,%eax
  800edc:	c1 e0 02             	shl    $0x2,%eax
  800edf:	01 d0                	add    %edx,%eax
  800ee1:	01 c0                	add    %eax,%eax
  800ee3:	29 c1                	sub    %eax,%ecx
  800ee5:	89 ca                	mov    %ecx,%edx
  800ee7:	85 d2                	test   %edx,%edx
  800ee9:	75 9c                	jne    800e87 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800eeb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800ef2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ef5:	48                   	dec    %eax
  800ef6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800ef9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800efd:	74 3d                	je     800f3c <ltostr+0xe2>
		start = 1 ;
  800eff:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800f06:	eb 34                	jmp    800f3c <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800f08:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0e:	01 d0                	add    %edx,%eax
  800f10:	8a 00                	mov    (%eax),%al
  800f12:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800f15:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1b:	01 c2                	add    %eax,%edx
  800f1d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800f20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f23:	01 c8                	add    %ecx,%eax
  800f25:	8a 00                	mov    (%eax),%al
  800f27:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f29:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2f:	01 c2                	add    %eax,%edx
  800f31:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f34:	88 02                	mov    %al,(%edx)
		start++ ;
  800f36:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f39:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f3f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f42:	7c c4                	jl     800f08 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f44:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4a:	01 d0                	add    %edx,%eax
  800f4c:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f4f:	90                   	nop
  800f50:	c9                   	leave  
  800f51:	c3                   	ret    

00800f52 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800f52:	55                   	push   %ebp
  800f53:	89 e5                	mov    %esp,%ebp
  800f55:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f58:	ff 75 08             	pushl  0x8(%ebp)
  800f5b:	e8 54 fa ff ff       	call   8009b4 <strlen>
  800f60:	83 c4 04             	add    $0x4,%esp
  800f63:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f66:	ff 75 0c             	pushl  0xc(%ebp)
  800f69:	e8 46 fa ff ff       	call   8009b4 <strlen>
  800f6e:	83 c4 04             	add    $0x4,%esp
  800f71:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f74:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f7b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f82:	eb 17                	jmp    800f9b <strcconcat+0x49>
		final[s] = str1[s] ;
  800f84:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f87:	8b 45 10             	mov    0x10(%ebp),%eax
  800f8a:	01 c2                	add    %eax,%edx
  800f8c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f92:	01 c8                	add    %ecx,%eax
  800f94:	8a 00                	mov    (%eax),%al
  800f96:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f98:	ff 45 fc             	incl   -0x4(%ebp)
  800f9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f9e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800fa1:	7c e1                	jl     800f84 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800fa3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800faa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800fb1:	eb 1f                	jmp    800fd2 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800fb3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fb6:	8d 50 01             	lea    0x1(%eax),%edx
  800fb9:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fbc:	89 c2                	mov    %eax,%edx
  800fbe:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc1:	01 c2                	add    %eax,%edx
  800fc3:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800fc6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc9:	01 c8                	add    %ecx,%eax
  800fcb:	8a 00                	mov    (%eax),%al
  800fcd:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800fcf:	ff 45 f8             	incl   -0x8(%ebp)
  800fd2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fd8:	7c d9                	jl     800fb3 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800fda:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fdd:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe0:	01 d0                	add    %edx,%eax
  800fe2:	c6 00 00             	movb   $0x0,(%eax)
}
  800fe5:	90                   	nop
  800fe6:	c9                   	leave  
  800fe7:	c3                   	ret    

00800fe8 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800fe8:	55                   	push   %ebp
  800fe9:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800feb:	8b 45 14             	mov    0x14(%ebp),%eax
  800fee:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800ff4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff7:	8b 00                	mov    (%eax),%eax
  800ff9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801000:	8b 45 10             	mov    0x10(%ebp),%eax
  801003:	01 d0                	add    %edx,%eax
  801005:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80100b:	eb 0c                	jmp    801019 <strsplit+0x31>
			*string++ = 0;
  80100d:	8b 45 08             	mov    0x8(%ebp),%eax
  801010:	8d 50 01             	lea    0x1(%eax),%edx
  801013:	89 55 08             	mov    %edx,0x8(%ebp)
  801016:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801019:	8b 45 08             	mov    0x8(%ebp),%eax
  80101c:	8a 00                	mov    (%eax),%al
  80101e:	84 c0                	test   %al,%al
  801020:	74 18                	je     80103a <strsplit+0x52>
  801022:	8b 45 08             	mov    0x8(%ebp),%eax
  801025:	8a 00                	mov    (%eax),%al
  801027:	0f be c0             	movsbl %al,%eax
  80102a:	50                   	push   %eax
  80102b:	ff 75 0c             	pushl  0xc(%ebp)
  80102e:	e8 13 fb ff ff       	call   800b46 <strchr>
  801033:	83 c4 08             	add    $0x8,%esp
  801036:	85 c0                	test   %eax,%eax
  801038:	75 d3                	jne    80100d <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80103a:	8b 45 08             	mov    0x8(%ebp),%eax
  80103d:	8a 00                	mov    (%eax),%al
  80103f:	84 c0                	test   %al,%al
  801041:	74 5a                	je     80109d <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801043:	8b 45 14             	mov    0x14(%ebp),%eax
  801046:	8b 00                	mov    (%eax),%eax
  801048:	83 f8 0f             	cmp    $0xf,%eax
  80104b:	75 07                	jne    801054 <strsplit+0x6c>
		{
			return 0;
  80104d:	b8 00 00 00 00       	mov    $0x0,%eax
  801052:	eb 66                	jmp    8010ba <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801054:	8b 45 14             	mov    0x14(%ebp),%eax
  801057:	8b 00                	mov    (%eax),%eax
  801059:	8d 48 01             	lea    0x1(%eax),%ecx
  80105c:	8b 55 14             	mov    0x14(%ebp),%edx
  80105f:	89 0a                	mov    %ecx,(%edx)
  801061:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801068:	8b 45 10             	mov    0x10(%ebp),%eax
  80106b:	01 c2                	add    %eax,%edx
  80106d:	8b 45 08             	mov    0x8(%ebp),%eax
  801070:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801072:	eb 03                	jmp    801077 <strsplit+0x8f>
			string++;
  801074:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801077:	8b 45 08             	mov    0x8(%ebp),%eax
  80107a:	8a 00                	mov    (%eax),%al
  80107c:	84 c0                	test   %al,%al
  80107e:	74 8b                	je     80100b <strsplit+0x23>
  801080:	8b 45 08             	mov    0x8(%ebp),%eax
  801083:	8a 00                	mov    (%eax),%al
  801085:	0f be c0             	movsbl %al,%eax
  801088:	50                   	push   %eax
  801089:	ff 75 0c             	pushl  0xc(%ebp)
  80108c:	e8 b5 fa ff ff       	call   800b46 <strchr>
  801091:	83 c4 08             	add    $0x8,%esp
  801094:	85 c0                	test   %eax,%eax
  801096:	74 dc                	je     801074 <strsplit+0x8c>
			string++;
	}
  801098:	e9 6e ff ff ff       	jmp    80100b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80109d:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80109e:	8b 45 14             	mov    0x14(%ebp),%eax
  8010a1:	8b 00                	mov    (%eax),%eax
  8010a3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ad:	01 d0                	add    %edx,%eax
  8010af:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8010b5:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8010ba:	c9                   	leave  
  8010bb:	c3                   	ret    

008010bc <malloc>:
int changes=0;
int sizeofarray=0;
uint32 addresses[100];
int changed[100];
void* malloc(uint32 size)
{
  8010bc:	55                   	push   %ebp
  8010bd:	89 e5                	mov    %esp,%ebp
  8010bf:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  8010c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c5:	c1 e8 0c             	shr    $0xc,%eax
  8010c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;
		if(size%PAGE_SIZE!=0)
  8010cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ce:	25 ff 0f 00 00       	and    $0xfff,%eax
  8010d3:	85 c0                	test   %eax,%eax
  8010d5:	74 03                	je     8010da <malloc+0x1e>
			num++;
  8010d7:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  8010da:	a1 04 30 80 00       	mov    0x803004,%eax
  8010df:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8010e4:	75 64                	jne    80114a <malloc+0x8e>
		{
			sys_allocateMem(USER_HEAP_START,size);
  8010e6:	83 ec 08             	sub    $0x8,%esp
  8010e9:	ff 75 08             	pushl  0x8(%ebp)
  8010ec:	68 00 00 00 80       	push   $0x80000000
  8010f1:	e8 3a 04 00 00       	call   801530 <sys_allocateMem>
  8010f6:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  8010f9:	a1 04 30 80 00       	mov    0x803004,%eax
  8010fe:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  801101:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801104:	c1 e0 0c             	shl    $0xc,%eax
  801107:	89 c2                	mov    %eax,%edx
  801109:	a1 04 30 80 00       	mov    0x803004,%eax
  80110e:	01 d0                	add    %edx,%eax
  801110:	a3 04 30 80 00       	mov    %eax,0x803004
			addresses[sizeofarray]=last_addres;
  801115:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80111a:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801120:	89 14 85 40 31 80 00 	mov    %edx,0x803140(,%eax,4)
			changed[sizeofarray]=1;
  801127:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80112c:	c7 04 85 e0 32 80 00 	movl   $0x1,0x8032e0(,%eax,4)
  801133:	01 00 00 00 
			sizeofarray++;
  801137:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80113c:	40                   	inc    %eax
  80113d:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  801142:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801145:	e9 26 01 00 00       	jmp    801270 <malloc+0x1b4>
		}
		else
		{
			if(changes==0)
  80114a:	a1 28 30 80 00       	mov    0x803028,%eax
  80114f:	85 c0                	test   %eax,%eax
  801151:	75 62                	jne    8011b5 <malloc+0xf9>
			{
				sys_allocateMem(last_addres,size);
  801153:	a1 04 30 80 00       	mov    0x803004,%eax
  801158:	83 ec 08             	sub    $0x8,%esp
  80115b:	ff 75 08             	pushl  0x8(%ebp)
  80115e:	50                   	push   %eax
  80115f:	e8 cc 03 00 00       	call   801530 <sys_allocateMem>
  801164:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801167:	a1 04 30 80 00       	mov    0x803004,%eax
  80116c:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  80116f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801172:	c1 e0 0c             	shl    $0xc,%eax
  801175:	89 c2                	mov    %eax,%edx
  801177:	a1 04 30 80 00       	mov    0x803004,%eax
  80117c:	01 d0                	add    %edx,%eax
  80117e:	a3 04 30 80 00       	mov    %eax,0x803004
				addresses[sizeofarray]=return_addres;
  801183:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801188:	8b 55 d8             	mov    -0x28(%ebp),%edx
  80118b:	89 14 85 40 31 80 00 	mov    %edx,0x803140(,%eax,4)
				changed[sizeofarray]=1;
  801192:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801197:	c7 04 85 e0 32 80 00 	movl   $0x1,0x8032e0(,%eax,4)
  80119e:	01 00 00 00 
				sizeofarray++;
  8011a2:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8011a7:	40                   	inc    %eax
  8011a8:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  8011ad:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8011b0:	e9 bb 00 00 00       	jmp    801270 <malloc+0x1b4>
			}
			else{
				int count=0;
  8011b5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  8011bc:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  8011c3:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8011ca:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  8011d1:	eb 7c                	jmp    80124f <malloc+0x193>
				{
					uint32 *pg=NULL;
  8011d3:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  8011da:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  8011e1:	eb 1a                	jmp    8011fd <malloc+0x141>
					{
						if(addresses[j]==i)
  8011e3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8011e6:	8b 04 85 40 31 80 00 	mov    0x803140(,%eax,4),%eax
  8011ed:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8011f0:	75 08                	jne    8011fa <malloc+0x13e>
						{
							index=j;
  8011f2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8011f5:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  8011f8:	eb 0d                	jmp    801207 <malloc+0x14b>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  8011fa:	ff 45 dc             	incl   -0x24(%ebp)
  8011fd:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801202:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801205:	7c dc                	jl     8011e3 <malloc+0x127>
							index=j;
							break;
						}
					}

					if(index==-1)
  801207:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  80120b:	75 05                	jne    801212 <malloc+0x156>
					{
						count++;
  80120d:	ff 45 f0             	incl   -0x10(%ebp)
  801210:	eb 36                	jmp    801248 <malloc+0x18c>
					}
					else
					{
						if(changed[index]==0)
  801212:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801215:	8b 04 85 e0 32 80 00 	mov    0x8032e0(,%eax,4),%eax
  80121c:	85 c0                	test   %eax,%eax
  80121e:	75 05                	jne    801225 <malloc+0x169>
						{
							count++;
  801220:	ff 45 f0             	incl   -0x10(%ebp)
  801223:	eb 23                	jmp    801248 <malloc+0x18c>
						}
						else
						{
							if(count<min&&count>=num)
  801225:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801228:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  80122b:	7d 14                	jge    801241 <malloc+0x185>
  80122d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801230:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801233:	7c 0c                	jl     801241 <malloc+0x185>
							{
								min=count;
  801235:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801238:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  80123b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80123e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  801241:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801248:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  80124f:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801256:	0f 86 77 ff ff ff    	jbe    8011d3 <malloc+0x117>

					}

					}

				sys_allocateMem(min_addresss,size);
  80125c:	83 ec 08             	sub    $0x8,%esp
  80125f:	ff 75 08             	pushl  0x8(%ebp)
  801262:	ff 75 e4             	pushl  -0x1c(%ebp)
  801265:	e8 c6 02 00 00       	call   801530 <sys_allocateMem>
  80126a:	83 c4 10             	add    $0x10,%esp

				return(void*) min_addresss;
  80126d:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801270:	c9                   	leave  
  801271:	c3                   	ret    

00801272 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801272:	55                   	push   %ebp
  801273:	89 e5                	mov    %esp,%ebp
  801275:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801278:	83 ec 04             	sub    $0x4,%esp
  80127b:	68 90 22 80 00       	push   $0x802290
  801280:	6a 7b                	push   $0x7b
  801282:	68 b3 22 80 00       	push   $0x8022b3
  801287:	e8 2e 07 00 00       	call   8019ba <_panic>

0080128c <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80128c:	55                   	push   %ebp
  80128d:	89 e5                	mov    %esp,%ebp
  80128f:	83 ec 18             	sub    $0x18,%esp
  801292:	8b 45 10             	mov    0x10(%ebp),%eax
  801295:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801298:	83 ec 04             	sub    $0x4,%esp
  80129b:	68 c0 22 80 00       	push   $0x8022c0
  8012a0:	68 88 00 00 00       	push   $0x88
  8012a5:	68 b3 22 80 00       	push   $0x8022b3
  8012aa:	e8 0b 07 00 00       	call   8019ba <_panic>

008012af <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8012af:	55                   	push   %ebp
  8012b0:	89 e5                	mov    %esp,%ebp
  8012b2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8012b5:	83 ec 04             	sub    $0x4,%esp
  8012b8:	68 c0 22 80 00       	push   $0x8022c0
  8012bd:	68 8e 00 00 00       	push   $0x8e
  8012c2:	68 b3 22 80 00       	push   $0x8022b3
  8012c7:	e8 ee 06 00 00       	call   8019ba <_panic>

008012cc <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8012cc:	55                   	push   %ebp
  8012cd:	89 e5                	mov    %esp,%ebp
  8012cf:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8012d2:	83 ec 04             	sub    $0x4,%esp
  8012d5:	68 c0 22 80 00       	push   $0x8022c0
  8012da:	68 94 00 00 00       	push   $0x94
  8012df:	68 b3 22 80 00       	push   $0x8022b3
  8012e4:	e8 d1 06 00 00       	call   8019ba <_panic>

008012e9 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  8012e9:	55                   	push   %ebp
  8012ea:	89 e5                	mov    %esp,%ebp
  8012ec:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8012ef:	83 ec 04             	sub    $0x4,%esp
  8012f2:	68 c0 22 80 00       	push   $0x8022c0
  8012f7:	68 99 00 00 00       	push   $0x99
  8012fc:	68 b3 22 80 00       	push   $0x8022b3
  801301:	e8 b4 06 00 00       	call   8019ba <_panic>

00801306 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801306:	55                   	push   %ebp
  801307:	89 e5                	mov    %esp,%ebp
  801309:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80130c:	83 ec 04             	sub    $0x4,%esp
  80130f:	68 c0 22 80 00       	push   $0x8022c0
  801314:	68 9f 00 00 00       	push   $0x9f
  801319:	68 b3 22 80 00       	push   $0x8022b3
  80131e:	e8 97 06 00 00       	call   8019ba <_panic>

00801323 <shrink>:
}
void shrink(uint32 newSize)
{
  801323:	55                   	push   %ebp
  801324:	89 e5                	mov    %esp,%ebp
  801326:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801329:	83 ec 04             	sub    $0x4,%esp
  80132c:	68 c0 22 80 00       	push   $0x8022c0
  801331:	68 a3 00 00 00       	push   $0xa3
  801336:	68 b3 22 80 00       	push   $0x8022b3
  80133b:	e8 7a 06 00 00       	call   8019ba <_panic>

00801340 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801340:	55                   	push   %ebp
  801341:	89 e5                	mov    %esp,%ebp
  801343:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801346:	83 ec 04             	sub    $0x4,%esp
  801349:	68 c0 22 80 00       	push   $0x8022c0
  80134e:	68 a8 00 00 00       	push   $0xa8
  801353:	68 b3 22 80 00       	push   $0x8022b3
  801358:	e8 5d 06 00 00       	call   8019ba <_panic>

0080135d <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80135d:	55                   	push   %ebp
  80135e:	89 e5                	mov    %esp,%ebp
  801360:	57                   	push   %edi
  801361:	56                   	push   %esi
  801362:	53                   	push   %ebx
  801363:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801366:	8b 45 08             	mov    0x8(%ebp),%eax
  801369:	8b 55 0c             	mov    0xc(%ebp),%edx
  80136c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80136f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801372:	8b 7d 18             	mov    0x18(%ebp),%edi
  801375:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801378:	cd 30                	int    $0x30
  80137a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80137d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801380:	83 c4 10             	add    $0x10,%esp
  801383:	5b                   	pop    %ebx
  801384:	5e                   	pop    %esi
  801385:	5f                   	pop    %edi
  801386:	5d                   	pop    %ebp
  801387:	c3                   	ret    

00801388 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801388:	55                   	push   %ebp
  801389:	89 e5                	mov    %esp,%ebp
  80138b:	83 ec 04             	sub    $0x4,%esp
  80138e:	8b 45 10             	mov    0x10(%ebp),%eax
  801391:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801394:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801398:	8b 45 08             	mov    0x8(%ebp),%eax
  80139b:	6a 00                	push   $0x0
  80139d:	6a 00                	push   $0x0
  80139f:	52                   	push   %edx
  8013a0:	ff 75 0c             	pushl  0xc(%ebp)
  8013a3:	50                   	push   %eax
  8013a4:	6a 00                	push   $0x0
  8013a6:	e8 b2 ff ff ff       	call   80135d <syscall>
  8013ab:	83 c4 18             	add    $0x18,%esp
}
  8013ae:	90                   	nop
  8013af:	c9                   	leave  
  8013b0:	c3                   	ret    

008013b1 <sys_cgetc>:

int
sys_cgetc(void)
{
  8013b1:	55                   	push   %ebp
  8013b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8013b4:	6a 00                	push   $0x0
  8013b6:	6a 00                	push   $0x0
  8013b8:	6a 00                	push   $0x0
  8013ba:	6a 00                	push   $0x0
  8013bc:	6a 00                	push   $0x0
  8013be:	6a 01                	push   $0x1
  8013c0:	e8 98 ff ff ff       	call   80135d <syscall>
  8013c5:	83 c4 18             	add    $0x18,%esp
}
  8013c8:	c9                   	leave  
  8013c9:	c3                   	ret    

008013ca <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8013ca:	55                   	push   %ebp
  8013cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8013cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 00                	push   $0x0
  8013d8:	50                   	push   %eax
  8013d9:	6a 05                	push   $0x5
  8013db:	e8 7d ff ff ff       	call   80135d <syscall>
  8013e0:	83 c4 18             	add    $0x18,%esp
}
  8013e3:	c9                   	leave  
  8013e4:	c3                   	ret    

008013e5 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8013e5:	55                   	push   %ebp
  8013e6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 00                	push   $0x0
  8013ec:	6a 00                	push   $0x0
  8013ee:	6a 00                	push   $0x0
  8013f0:	6a 00                	push   $0x0
  8013f2:	6a 02                	push   $0x2
  8013f4:	e8 64 ff ff ff       	call   80135d <syscall>
  8013f9:	83 c4 18             	add    $0x18,%esp
}
  8013fc:	c9                   	leave  
  8013fd:	c3                   	ret    

008013fe <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8013fe:	55                   	push   %ebp
  8013ff:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	6a 00                	push   $0x0
  801407:	6a 00                	push   $0x0
  801409:	6a 00                	push   $0x0
  80140b:	6a 03                	push   $0x3
  80140d:	e8 4b ff ff ff       	call   80135d <syscall>
  801412:	83 c4 18             	add    $0x18,%esp
}
  801415:	c9                   	leave  
  801416:	c3                   	ret    

00801417 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801417:	55                   	push   %ebp
  801418:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80141a:	6a 00                	push   $0x0
  80141c:	6a 00                	push   $0x0
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	6a 00                	push   $0x0
  801424:	6a 04                	push   $0x4
  801426:	e8 32 ff ff ff       	call   80135d <syscall>
  80142b:	83 c4 18             	add    $0x18,%esp
}
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <sys_env_exit>:


void sys_env_exit(void)
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	6a 00                	push   $0x0
  801439:	6a 00                	push   $0x0
  80143b:	6a 00                	push   $0x0
  80143d:	6a 06                	push   $0x6
  80143f:	e8 19 ff ff ff       	call   80135d <syscall>
  801444:	83 c4 18             	add    $0x18,%esp
}
  801447:	90                   	nop
  801448:	c9                   	leave  
  801449:	c3                   	ret    

0080144a <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80144a:	55                   	push   %ebp
  80144b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80144d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801450:	8b 45 08             	mov    0x8(%ebp),%eax
  801453:	6a 00                	push   $0x0
  801455:	6a 00                	push   $0x0
  801457:	6a 00                	push   $0x0
  801459:	52                   	push   %edx
  80145a:	50                   	push   %eax
  80145b:	6a 07                	push   $0x7
  80145d:	e8 fb fe ff ff       	call   80135d <syscall>
  801462:	83 c4 18             	add    $0x18,%esp
}
  801465:	c9                   	leave  
  801466:	c3                   	ret    

00801467 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801467:	55                   	push   %ebp
  801468:	89 e5                	mov    %esp,%ebp
  80146a:	56                   	push   %esi
  80146b:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80146c:	8b 75 18             	mov    0x18(%ebp),%esi
  80146f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801472:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801475:	8b 55 0c             	mov    0xc(%ebp),%edx
  801478:	8b 45 08             	mov    0x8(%ebp),%eax
  80147b:	56                   	push   %esi
  80147c:	53                   	push   %ebx
  80147d:	51                   	push   %ecx
  80147e:	52                   	push   %edx
  80147f:	50                   	push   %eax
  801480:	6a 08                	push   $0x8
  801482:	e8 d6 fe ff ff       	call   80135d <syscall>
  801487:	83 c4 18             	add    $0x18,%esp
}
  80148a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80148d:	5b                   	pop    %ebx
  80148e:	5e                   	pop    %esi
  80148f:	5d                   	pop    %ebp
  801490:	c3                   	ret    

00801491 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801491:	55                   	push   %ebp
  801492:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801494:	8b 55 0c             	mov    0xc(%ebp),%edx
  801497:	8b 45 08             	mov    0x8(%ebp),%eax
  80149a:	6a 00                	push   $0x0
  80149c:	6a 00                	push   $0x0
  80149e:	6a 00                	push   $0x0
  8014a0:	52                   	push   %edx
  8014a1:	50                   	push   %eax
  8014a2:	6a 09                	push   $0x9
  8014a4:	e8 b4 fe ff ff       	call   80135d <syscall>
  8014a9:	83 c4 18             	add    $0x18,%esp
}
  8014ac:	c9                   	leave  
  8014ad:	c3                   	ret    

008014ae <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8014ae:	55                   	push   %ebp
  8014af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	6a 00                	push   $0x0
  8014b7:	ff 75 0c             	pushl  0xc(%ebp)
  8014ba:	ff 75 08             	pushl  0x8(%ebp)
  8014bd:	6a 0a                	push   $0xa
  8014bf:	e8 99 fe ff ff       	call   80135d <syscall>
  8014c4:	83 c4 18             	add    $0x18,%esp
}
  8014c7:	c9                   	leave  
  8014c8:	c3                   	ret    

008014c9 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8014c9:	55                   	push   %ebp
  8014ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 0b                	push   $0xb
  8014d8:	e8 80 fe ff ff       	call   80135d <syscall>
  8014dd:	83 c4 18             	add    $0x18,%esp
}
  8014e0:	c9                   	leave  
  8014e1:	c3                   	ret    

008014e2 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8014e2:	55                   	push   %ebp
  8014e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 00                	push   $0x0
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 00                	push   $0x0
  8014ef:	6a 0c                	push   $0xc
  8014f1:	e8 67 fe ff ff       	call   80135d <syscall>
  8014f6:	83 c4 18             	add    $0x18,%esp
}
  8014f9:	c9                   	leave  
  8014fa:	c3                   	ret    

008014fb <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8014fb:	55                   	push   %ebp
  8014fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8014fe:	6a 00                	push   $0x0
  801500:	6a 00                	push   $0x0
  801502:	6a 00                	push   $0x0
  801504:	6a 00                	push   $0x0
  801506:	6a 00                	push   $0x0
  801508:	6a 0d                	push   $0xd
  80150a:	e8 4e fe ff ff       	call   80135d <syscall>
  80150f:	83 c4 18             	add    $0x18,%esp
}
  801512:	c9                   	leave  
  801513:	c3                   	ret    

00801514 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801514:	55                   	push   %ebp
  801515:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	ff 75 0c             	pushl  0xc(%ebp)
  801520:	ff 75 08             	pushl  0x8(%ebp)
  801523:	6a 11                	push   $0x11
  801525:	e8 33 fe ff ff       	call   80135d <syscall>
  80152a:	83 c4 18             	add    $0x18,%esp
	return;
  80152d:	90                   	nop
}
  80152e:	c9                   	leave  
  80152f:	c3                   	ret    

00801530 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801530:	55                   	push   %ebp
  801531:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801533:	6a 00                	push   $0x0
  801535:	6a 00                	push   $0x0
  801537:	6a 00                	push   $0x0
  801539:	ff 75 0c             	pushl  0xc(%ebp)
  80153c:	ff 75 08             	pushl  0x8(%ebp)
  80153f:	6a 12                	push   $0x12
  801541:	e8 17 fe ff ff       	call   80135d <syscall>
  801546:	83 c4 18             	add    $0x18,%esp
	return ;
  801549:	90                   	nop
}
  80154a:	c9                   	leave  
  80154b:	c3                   	ret    

0080154c <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80154c:	55                   	push   %ebp
  80154d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	6a 00                	push   $0x0
  801559:	6a 0e                	push   $0xe
  80155b:	e8 fd fd ff ff       	call   80135d <syscall>
  801560:	83 c4 18             	add    $0x18,%esp
}
  801563:	c9                   	leave  
  801564:	c3                   	ret    

00801565 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801565:	55                   	push   %ebp
  801566:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801568:	6a 00                	push   $0x0
  80156a:	6a 00                	push   $0x0
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	ff 75 08             	pushl  0x8(%ebp)
  801573:	6a 0f                	push   $0xf
  801575:	e8 e3 fd ff ff       	call   80135d <syscall>
  80157a:	83 c4 18             	add    $0x18,%esp
}
  80157d:	c9                   	leave  
  80157e:	c3                   	ret    

0080157f <sys_scarce_memory>:

void sys_scarce_memory()
{
  80157f:	55                   	push   %ebp
  801580:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801582:	6a 00                	push   $0x0
  801584:	6a 00                	push   $0x0
  801586:	6a 00                	push   $0x0
  801588:	6a 00                	push   $0x0
  80158a:	6a 00                	push   $0x0
  80158c:	6a 10                	push   $0x10
  80158e:	e8 ca fd ff ff       	call   80135d <syscall>
  801593:	83 c4 18             	add    $0x18,%esp
}
  801596:	90                   	nop
  801597:	c9                   	leave  
  801598:	c3                   	ret    

00801599 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801599:	55                   	push   %ebp
  80159a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80159c:	6a 00                	push   $0x0
  80159e:	6a 00                	push   $0x0
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 14                	push   $0x14
  8015a8:	e8 b0 fd ff ff       	call   80135d <syscall>
  8015ad:	83 c4 18             	add    $0x18,%esp
}
  8015b0:	90                   	nop
  8015b1:	c9                   	leave  
  8015b2:	c3                   	ret    

008015b3 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8015b3:	55                   	push   %ebp
  8015b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	6a 00                	push   $0x0
  8015bc:	6a 00                	push   $0x0
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 15                	push   $0x15
  8015c2:	e8 96 fd ff ff       	call   80135d <syscall>
  8015c7:	83 c4 18             	add    $0x18,%esp
}
  8015ca:	90                   	nop
  8015cb:	c9                   	leave  
  8015cc:	c3                   	ret    

008015cd <sys_cputc>:


void
sys_cputc(const char c)
{
  8015cd:	55                   	push   %ebp
  8015ce:	89 e5                	mov    %esp,%ebp
  8015d0:	83 ec 04             	sub    $0x4,%esp
  8015d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8015d9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	50                   	push   %eax
  8015e6:	6a 16                	push   $0x16
  8015e8:	e8 70 fd ff ff       	call   80135d <syscall>
  8015ed:	83 c4 18             	add    $0x18,%esp
}
  8015f0:	90                   	nop
  8015f1:	c9                   	leave  
  8015f2:	c3                   	ret    

008015f3 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8015f3:	55                   	push   %ebp
  8015f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 00                	push   $0x0
  801600:	6a 17                	push   $0x17
  801602:	e8 56 fd ff ff       	call   80135d <syscall>
  801607:	83 c4 18             	add    $0x18,%esp
}
  80160a:	90                   	nop
  80160b:	c9                   	leave  
  80160c:	c3                   	ret    

0080160d <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80160d:	55                   	push   %ebp
  80160e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801610:	8b 45 08             	mov    0x8(%ebp),%eax
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	ff 75 0c             	pushl  0xc(%ebp)
  80161c:	50                   	push   %eax
  80161d:	6a 18                	push   $0x18
  80161f:	e8 39 fd ff ff       	call   80135d <syscall>
  801624:	83 c4 18             	add    $0x18,%esp
}
  801627:	c9                   	leave  
  801628:	c3                   	ret    

00801629 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801629:	55                   	push   %ebp
  80162a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80162c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80162f:	8b 45 08             	mov    0x8(%ebp),%eax
  801632:	6a 00                	push   $0x0
  801634:	6a 00                	push   $0x0
  801636:	6a 00                	push   $0x0
  801638:	52                   	push   %edx
  801639:	50                   	push   %eax
  80163a:	6a 1b                	push   $0x1b
  80163c:	e8 1c fd ff ff       	call   80135d <syscall>
  801641:	83 c4 18             	add    $0x18,%esp
}
  801644:	c9                   	leave  
  801645:	c3                   	ret    

00801646 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801646:	55                   	push   %ebp
  801647:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801649:	8b 55 0c             	mov    0xc(%ebp),%edx
  80164c:	8b 45 08             	mov    0x8(%ebp),%eax
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	6a 00                	push   $0x0
  801655:	52                   	push   %edx
  801656:	50                   	push   %eax
  801657:	6a 19                	push   $0x19
  801659:	e8 ff fc ff ff       	call   80135d <syscall>
  80165e:	83 c4 18             	add    $0x18,%esp
}
  801661:	90                   	nop
  801662:	c9                   	leave  
  801663:	c3                   	ret    

00801664 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801664:	55                   	push   %ebp
  801665:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801667:	8b 55 0c             	mov    0xc(%ebp),%edx
  80166a:	8b 45 08             	mov    0x8(%ebp),%eax
  80166d:	6a 00                	push   $0x0
  80166f:	6a 00                	push   $0x0
  801671:	6a 00                	push   $0x0
  801673:	52                   	push   %edx
  801674:	50                   	push   %eax
  801675:	6a 1a                	push   $0x1a
  801677:	e8 e1 fc ff ff       	call   80135d <syscall>
  80167c:	83 c4 18             	add    $0x18,%esp
}
  80167f:	90                   	nop
  801680:	c9                   	leave  
  801681:	c3                   	ret    

00801682 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801682:	55                   	push   %ebp
  801683:	89 e5                	mov    %esp,%ebp
  801685:	83 ec 04             	sub    $0x4,%esp
  801688:	8b 45 10             	mov    0x10(%ebp),%eax
  80168b:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80168e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801691:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801695:	8b 45 08             	mov    0x8(%ebp),%eax
  801698:	6a 00                	push   $0x0
  80169a:	51                   	push   %ecx
  80169b:	52                   	push   %edx
  80169c:	ff 75 0c             	pushl  0xc(%ebp)
  80169f:	50                   	push   %eax
  8016a0:	6a 1c                	push   $0x1c
  8016a2:	e8 b6 fc ff ff       	call   80135d <syscall>
  8016a7:	83 c4 18             	add    $0x18,%esp
}
  8016aa:	c9                   	leave  
  8016ab:	c3                   	ret    

008016ac <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8016ac:	55                   	push   %ebp
  8016ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8016af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b5:	6a 00                	push   $0x0
  8016b7:	6a 00                	push   $0x0
  8016b9:	6a 00                	push   $0x0
  8016bb:	52                   	push   %edx
  8016bc:	50                   	push   %eax
  8016bd:	6a 1d                	push   $0x1d
  8016bf:	e8 99 fc ff ff       	call   80135d <syscall>
  8016c4:	83 c4 18             	add    $0x18,%esp
}
  8016c7:	c9                   	leave  
  8016c8:	c3                   	ret    

008016c9 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8016c9:	55                   	push   %ebp
  8016ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8016cc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d5:	6a 00                	push   $0x0
  8016d7:	6a 00                	push   $0x0
  8016d9:	51                   	push   %ecx
  8016da:	52                   	push   %edx
  8016db:	50                   	push   %eax
  8016dc:	6a 1e                	push   $0x1e
  8016de:	e8 7a fc ff ff       	call   80135d <syscall>
  8016e3:	83 c4 18             	add    $0x18,%esp
}
  8016e6:	c9                   	leave  
  8016e7:	c3                   	ret    

008016e8 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8016e8:	55                   	push   %ebp
  8016e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8016eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 00                	push   $0x0
  8016f7:	52                   	push   %edx
  8016f8:	50                   	push   %eax
  8016f9:	6a 1f                	push   $0x1f
  8016fb:	e8 5d fc ff ff       	call   80135d <syscall>
  801700:	83 c4 18             	add    $0x18,%esp
}
  801703:	c9                   	leave  
  801704:	c3                   	ret    

00801705 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801705:	55                   	push   %ebp
  801706:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801708:	6a 00                	push   $0x0
  80170a:	6a 00                	push   $0x0
  80170c:	6a 00                	push   $0x0
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	6a 20                	push   $0x20
  801714:	e8 44 fc ff ff       	call   80135d <syscall>
  801719:	83 c4 18             	add    $0x18,%esp
}
  80171c:	c9                   	leave  
  80171d:	c3                   	ret    

0080171e <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80171e:	55                   	push   %ebp
  80171f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801721:	8b 45 08             	mov    0x8(%ebp),%eax
  801724:	6a 00                	push   $0x0
  801726:	ff 75 14             	pushl  0x14(%ebp)
  801729:	ff 75 10             	pushl  0x10(%ebp)
  80172c:	ff 75 0c             	pushl  0xc(%ebp)
  80172f:	50                   	push   %eax
  801730:	6a 21                	push   $0x21
  801732:	e8 26 fc ff ff       	call   80135d <syscall>
  801737:	83 c4 18             	add    $0x18,%esp
}
  80173a:	c9                   	leave  
  80173b:	c3                   	ret    

0080173c <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80173c:	55                   	push   %ebp
  80173d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80173f:	8b 45 08             	mov    0x8(%ebp),%eax
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	50                   	push   %eax
  80174b:	6a 22                	push   $0x22
  80174d:	e8 0b fc ff ff       	call   80135d <syscall>
  801752:	83 c4 18             	add    $0x18,%esp
}
  801755:	90                   	nop
  801756:	c9                   	leave  
  801757:	c3                   	ret    

00801758 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801758:	55                   	push   %ebp
  801759:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80175b:	8b 45 08             	mov    0x8(%ebp),%eax
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	6a 00                	push   $0x0
  801764:	6a 00                	push   $0x0
  801766:	50                   	push   %eax
  801767:	6a 23                	push   $0x23
  801769:	e8 ef fb ff ff       	call   80135d <syscall>
  80176e:	83 c4 18             	add    $0x18,%esp
}
  801771:	90                   	nop
  801772:	c9                   	leave  
  801773:	c3                   	ret    

00801774 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801774:	55                   	push   %ebp
  801775:	89 e5                	mov    %esp,%ebp
  801777:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80177a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80177d:	8d 50 04             	lea    0x4(%eax),%edx
  801780:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	52                   	push   %edx
  80178a:	50                   	push   %eax
  80178b:	6a 24                	push   $0x24
  80178d:	e8 cb fb ff ff       	call   80135d <syscall>
  801792:	83 c4 18             	add    $0x18,%esp
	return result;
  801795:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801798:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80179b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80179e:	89 01                	mov    %eax,(%ecx)
  8017a0:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8017a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a6:	c9                   	leave  
  8017a7:	c2 04 00             	ret    $0x4

008017aa <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8017aa:	55                   	push   %ebp
  8017ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 00                	push   $0x0
  8017b1:	ff 75 10             	pushl  0x10(%ebp)
  8017b4:	ff 75 0c             	pushl  0xc(%ebp)
  8017b7:	ff 75 08             	pushl  0x8(%ebp)
  8017ba:	6a 13                	push   $0x13
  8017bc:	e8 9c fb ff ff       	call   80135d <syscall>
  8017c1:	83 c4 18             	add    $0x18,%esp
	return ;
  8017c4:	90                   	nop
}
  8017c5:	c9                   	leave  
  8017c6:	c3                   	ret    

008017c7 <sys_rcr2>:
uint32 sys_rcr2()
{
  8017c7:	55                   	push   %ebp
  8017c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 25                	push   $0x25
  8017d6:	e8 82 fb ff ff       	call   80135d <syscall>
  8017db:	83 c4 18             	add    $0x18,%esp
}
  8017de:	c9                   	leave  
  8017df:	c3                   	ret    

008017e0 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8017e0:	55                   	push   %ebp
  8017e1:	89 e5                	mov    %esp,%ebp
  8017e3:	83 ec 04             	sub    $0x4,%esp
  8017e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017ec:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017f0:	6a 00                	push   $0x0
  8017f2:	6a 00                	push   $0x0
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 00                	push   $0x0
  8017f8:	50                   	push   %eax
  8017f9:	6a 26                	push   $0x26
  8017fb:	e8 5d fb ff ff       	call   80135d <syscall>
  801800:	83 c4 18             	add    $0x18,%esp
	return ;
  801803:	90                   	nop
}
  801804:	c9                   	leave  
  801805:	c3                   	ret    

00801806 <rsttst>:
void rsttst()
{
  801806:	55                   	push   %ebp
  801807:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801809:	6a 00                	push   $0x0
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	6a 00                	push   $0x0
  801811:	6a 00                	push   $0x0
  801813:	6a 28                	push   $0x28
  801815:	e8 43 fb ff ff       	call   80135d <syscall>
  80181a:	83 c4 18             	add    $0x18,%esp
	return ;
  80181d:	90                   	nop
}
  80181e:	c9                   	leave  
  80181f:	c3                   	ret    

00801820 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801820:	55                   	push   %ebp
  801821:	89 e5                	mov    %esp,%ebp
  801823:	83 ec 04             	sub    $0x4,%esp
  801826:	8b 45 14             	mov    0x14(%ebp),%eax
  801829:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80182c:	8b 55 18             	mov    0x18(%ebp),%edx
  80182f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801833:	52                   	push   %edx
  801834:	50                   	push   %eax
  801835:	ff 75 10             	pushl  0x10(%ebp)
  801838:	ff 75 0c             	pushl  0xc(%ebp)
  80183b:	ff 75 08             	pushl  0x8(%ebp)
  80183e:	6a 27                	push   $0x27
  801840:	e8 18 fb ff ff       	call   80135d <syscall>
  801845:	83 c4 18             	add    $0x18,%esp
	return ;
  801848:	90                   	nop
}
  801849:	c9                   	leave  
  80184a:	c3                   	ret    

0080184b <chktst>:
void chktst(uint32 n)
{
  80184b:	55                   	push   %ebp
  80184c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80184e:	6a 00                	push   $0x0
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	6a 00                	push   $0x0
  801856:	ff 75 08             	pushl  0x8(%ebp)
  801859:	6a 29                	push   $0x29
  80185b:	e8 fd fa ff ff       	call   80135d <syscall>
  801860:	83 c4 18             	add    $0x18,%esp
	return ;
  801863:	90                   	nop
}
  801864:	c9                   	leave  
  801865:	c3                   	ret    

00801866 <inctst>:

void inctst()
{
  801866:	55                   	push   %ebp
  801867:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801869:	6a 00                	push   $0x0
  80186b:	6a 00                	push   $0x0
  80186d:	6a 00                	push   $0x0
  80186f:	6a 00                	push   $0x0
  801871:	6a 00                	push   $0x0
  801873:	6a 2a                	push   $0x2a
  801875:	e8 e3 fa ff ff       	call   80135d <syscall>
  80187a:	83 c4 18             	add    $0x18,%esp
	return ;
  80187d:	90                   	nop
}
  80187e:	c9                   	leave  
  80187f:	c3                   	ret    

00801880 <gettst>:
uint32 gettst()
{
  801880:	55                   	push   %ebp
  801881:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801883:	6a 00                	push   $0x0
  801885:	6a 00                	push   $0x0
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 2b                	push   $0x2b
  80188f:	e8 c9 fa ff ff       	call   80135d <syscall>
  801894:	83 c4 18             	add    $0x18,%esp
}
  801897:	c9                   	leave  
  801898:	c3                   	ret    

00801899 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801899:	55                   	push   %ebp
  80189a:	89 e5                	mov    %esp,%ebp
  80189c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 00                	push   $0x0
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 2c                	push   $0x2c
  8018ab:	e8 ad fa ff ff       	call   80135d <syscall>
  8018b0:	83 c4 18             	add    $0x18,%esp
  8018b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8018b6:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8018ba:	75 07                	jne    8018c3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8018bc:	b8 01 00 00 00       	mov    $0x1,%eax
  8018c1:	eb 05                	jmp    8018c8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8018c3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018c8:	c9                   	leave  
  8018c9:	c3                   	ret    

008018ca <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8018ca:	55                   	push   %ebp
  8018cb:	89 e5                	mov    %esp,%ebp
  8018cd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018d0:	6a 00                	push   $0x0
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 00                	push   $0x0
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 00                	push   $0x0
  8018da:	6a 2c                	push   $0x2c
  8018dc:	e8 7c fa ff ff       	call   80135d <syscall>
  8018e1:	83 c4 18             	add    $0x18,%esp
  8018e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8018e7:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8018eb:	75 07                	jne    8018f4 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8018ed:	b8 01 00 00 00       	mov    $0x1,%eax
  8018f2:	eb 05                	jmp    8018f9 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8018f4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018f9:	c9                   	leave  
  8018fa:	c3                   	ret    

008018fb <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8018fb:	55                   	push   %ebp
  8018fc:	89 e5                	mov    %esp,%ebp
  8018fe:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801901:	6a 00                	push   $0x0
  801903:	6a 00                	push   $0x0
  801905:	6a 00                	push   $0x0
  801907:	6a 00                	push   $0x0
  801909:	6a 00                	push   $0x0
  80190b:	6a 2c                	push   $0x2c
  80190d:	e8 4b fa ff ff       	call   80135d <syscall>
  801912:	83 c4 18             	add    $0x18,%esp
  801915:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801918:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80191c:	75 07                	jne    801925 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80191e:	b8 01 00 00 00       	mov    $0x1,%eax
  801923:	eb 05                	jmp    80192a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801925:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80192a:	c9                   	leave  
  80192b:	c3                   	ret    

0080192c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80192c:	55                   	push   %ebp
  80192d:	89 e5                	mov    %esp,%ebp
  80192f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 2c                	push   $0x2c
  80193e:	e8 1a fa ff ff       	call   80135d <syscall>
  801943:	83 c4 18             	add    $0x18,%esp
  801946:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801949:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80194d:	75 07                	jne    801956 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80194f:	b8 01 00 00 00       	mov    $0x1,%eax
  801954:	eb 05                	jmp    80195b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801956:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80195b:	c9                   	leave  
  80195c:	c3                   	ret    

0080195d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80195d:	55                   	push   %ebp
  80195e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801960:	6a 00                	push   $0x0
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	6a 00                	push   $0x0
  801968:	ff 75 08             	pushl  0x8(%ebp)
  80196b:	6a 2d                	push   $0x2d
  80196d:	e8 eb f9 ff ff       	call   80135d <syscall>
  801972:	83 c4 18             	add    $0x18,%esp
	return ;
  801975:	90                   	nop
}
  801976:	c9                   	leave  
  801977:	c3                   	ret    

00801978 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801978:	55                   	push   %ebp
  801979:	89 e5                	mov    %esp,%ebp
  80197b:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80197c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80197f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801982:	8b 55 0c             	mov    0xc(%ebp),%edx
  801985:	8b 45 08             	mov    0x8(%ebp),%eax
  801988:	6a 00                	push   $0x0
  80198a:	53                   	push   %ebx
  80198b:	51                   	push   %ecx
  80198c:	52                   	push   %edx
  80198d:	50                   	push   %eax
  80198e:	6a 2e                	push   $0x2e
  801990:	e8 c8 f9 ff ff       	call   80135d <syscall>
  801995:	83 c4 18             	add    $0x18,%esp
}
  801998:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80199b:	c9                   	leave  
  80199c:	c3                   	ret    

0080199d <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80199d:	55                   	push   %ebp
  80199e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8019a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 00                	push   $0x0
  8019aa:	6a 00                	push   $0x0
  8019ac:	52                   	push   %edx
  8019ad:	50                   	push   %eax
  8019ae:	6a 2f                	push   $0x2f
  8019b0:	e8 a8 f9 ff ff       	call   80135d <syscall>
  8019b5:	83 c4 18             	add    $0x18,%esp
}
  8019b8:	c9                   	leave  
  8019b9:	c3                   	ret    

008019ba <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8019ba:	55                   	push   %ebp
  8019bb:	89 e5                	mov    %esp,%ebp
  8019bd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8019c0:	8d 45 10             	lea    0x10(%ebp),%eax
  8019c3:	83 c0 04             	add    $0x4,%eax
  8019c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8019c9:	a1 70 34 80 00       	mov    0x803470,%eax
  8019ce:	85 c0                	test   %eax,%eax
  8019d0:	74 16                	je     8019e8 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8019d2:	a1 70 34 80 00       	mov    0x803470,%eax
  8019d7:	83 ec 08             	sub    $0x8,%esp
  8019da:	50                   	push   %eax
  8019db:	68 e4 22 80 00       	push   $0x8022e4
  8019e0:	e8 4d e9 ff ff       	call   800332 <cprintf>
  8019e5:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8019e8:	a1 00 30 80 00       	mov    0x803000,%eax
  8019ed:	ff 75 0c             	pushl  0xc(%ebp)
  8019f0:	ff 75 08             	pushl  0x8(%ebp)
  8019f3:	50                   	push   %eax
  8019f4:	68 e9 22 80 00       	push   $0x8022e9
  8019f9:	e8 34 e9 ff ff       	call   800332 <cprintf>
  8019fe:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801a01:	8b 45 10             	mov    0x10(%ebp),%eax
  801a04:	83 ec 08             	sub    $0x8,%esp
  801a07:	ff 75 f4             	pushl  -0xc(%ebp)
  801a0a:	50                   	push   %eax
  801a0b:	e8 b7 e8 ff ff       	call   8002c7 <vcprintf>
  801a10:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801a13:	83 ec 08             	sub    $0x8,%esp
  801a16:	6a 00                	push   $0x0
  801a18:	68 05 23 80 00       	push   $0x802305
  801a1d:	e8 a5 e8 ff ff       	call   8002c7 <vcprintf>
  801a22:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801a25:	e8 26 e8 ff ff       	call   800250 <exit>

	// should not return here
	while (1) ;
  801a2a:	eb fe                	jmp    801a2a <_panic+0x70>

00801a2c <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801a2c:	55                   	push   %ebp
  801a2d:	89 e5                	mov    %esp,%ebp
  801a2f:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801a32:	a1 20 30 80 00       	mov    0x803020,%eax
  801a37:	8b 50 74             	mov    0x74(%eax),%edx
  801a3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a3d:	39 c2                	cmp    %eax,%edx
  801a3f:	74 14                	je     801a55 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801a41:	83 ec 04             	sub    $0x4,%esp
  801a44:	68 08 23 80 00       	push   $0x802308
  801a49:	6a 26                	push   $0x26
  801a4b:	68 54 23 80 00       	push   $0x802354
  801a50:	e8 65 ff ff ff       	call   8019ba <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801a55:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801a5c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801a63:	e9 b6 00 00 00       	jmp    801b1e <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801a68:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a6b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a72:	8b 45 08             	mov    0x8(%ebp),%eax
  801a75:	01 d0                	add    %edx,%eax
  801a77:	8b 00                	mov    (%eax),%eax
  801a79:	85 c0                	test   %eax,%eax
  801a7b:	75 08                	jne    801a85 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801a7d:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801a80:	e9 96 00 00 00       	jmp    801b1b <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  801a85:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801a8c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801a93:	eb 5d                	jmp    801af2 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801a95:	a1 20 30 80 00       	mov    0x803020,%eax
  801a9a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801aa0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801aa3:	c1 e2 04             	shl    $0x4,%edx
  801aa6:	01 d0                	add    %edx,%eax
  801aa8:	8a 40 04             	mov    0x4(%eax),%al
  801aab:	84 c0                	test   %al,%al
  801aad:	75 40                	jne    801aef <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801aaf:	a1 20 30 80 00       	mov    0x803020,%eax
  801ab4:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801aba:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801abd:	c1 e2 04             	shl    $0x4,%edx
  801ac0:	01 d0                	add    %edx,%eax
  801ac2:	8b 00                	mov    (%eax),%eax
  801ac4:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801ac7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801aca:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801acf:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801ad1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ad4:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801adb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ade:	01 c8                	add    %ecx,%eax
  801ae0:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801ae2:	39 c2                	cmp    %eax,%edx
  801ae4:	75 09                	jne    801aef <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  801ae6:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801aed:	eb 12                	jmp    801b01 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801aef:	ff 45 e8             	incl   -0x18(%ebp)
  801af2:	a1 20 30 80 00       	mov    0x803020,%eax
  801af7:	8b 50 74             	mov    0x74(%eax),%edx
  801afa:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801afd:	39 c2                	cmp    %eax,%edx
  801aff:	77 94                	ja     801a95 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801b01:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801b05:	75 14                	jne    801b1b <CheckWSWithoutLastIndex+0xef>
			panic(
  801b07:	83 ec 04             	sub    $0x4,%esp
  801b0a:	68 60 23 80 00       	push   $0x802360
  801b0f:	6a 3a                	push   $0x3a
  801b11:	68 54 23 80 00       	push   $0x802354
  801b16:	e8 9f fe ff ff       	call   8019ba <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801b1b:	ff 45 f0             	incl   -0x10(%ebp)
  801b1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b21:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801b24:	0f 8c 3e ff ff ff    	jl     801a68 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801b2a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b31:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801b38:	eb 20                	jmp    801b5a <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801b3a:	a1 20 30 80 00       	mov    0x803020,%eax
  801b3f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801b45:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801b48:	c1 e2 04             	shl    $0x4,%edx
  801b4b:	01 d0                	add    %edx,%eax
  801b4d:	8a 40 04             	mov    0x4(%eax),%al
  801b50:	3c 01                	cmp    $0x1,%al
  801b52:	75 03                	jne    801b57 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  801b54:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801b57:	ff 45 e0             	incl   -0x20(%ebp)
  801b5a:	a1 20 30 80 00       	mov    0x803020,%eax
  801b5f:	8b 50 74             	mov    0x74(%eax),%edx
  801b62:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b65:	39 c2                	cmp    %eax,%edx
  801b67:	77 d1                	ja     801b3a <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801b69:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b6c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801b6f:	74 14                	je     801b85 <CheckWSWithoutLastIndex+0x159>
		panic(
  801b71:	83 ec 04             	sub    $0x4,%esp
  801b74:	68 b4 23 80 00       	push   $0x8023b4
  801b79:	6a 44                	push   $0x44
  801b7b:	68 54 23 80 00       	push   $0x802354
  801b80:	e8 35 fe ff ff       	call   8019ba <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801b85:	90                   	nop
  801b86:	c9                   	leave  
  801b87:	c3                   	ret    

00801b88 <__udivdi3>:
  801b88:	55                   	push   %ebp
  801b89:	57                   	push   %edi
  801b8a:	56                   	push   %esi
  801b8b:	53                   	push   %ebx
  801b8c:	83 ec 1c             	sub    $0x1c,%esp
  801b8f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b93:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801b97:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b9b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b9f:	89 ca                	mov    %ecx,%edx
  801ba1:	89 f8                	mov    %edi,%eax
  801ba3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801ba7:	85 f6                	test   %esi,%esi
  801ba9:	75 2d                	jne    801bd8 <__udivdi3+0x50>
  801bab:	39 cf                	cmp    %ecx,%edi
  801bad:	77 65                	ja     801c14 <__udivdi3+0x8c>
  801baf:	89 fd                	mov    %edi,%ebp
  801bb1:	85 ff                	test   %edi,%edi
  801bb3:	75 0b                	jne    801bc0 <__udivdi3+0x38>
  801bb5:	b8 01 00 00 00       	mov    $0x1,%eax
  801bba:	31 d2                	xor    %edx,%edx
  801bbc:	f7 f7                	div    %edi
  801bbe:	89 c5                	mov    %eax,%ebp
  801bc0:	31 d2                	xor    %edx,%edx
  801bc2:	89 c8                	mov    %ecx,%eax
  801bc4:	f7 f5                	div    %ebp
  801bc6:	89 c1                	mov    %eax,%ecx
  801bc8:	89 d8                	mov    %ebx,%eax
  801bca:	f7 f5                	div    %ebp
  801bcc:	89 cf                	mov    %ecx,%edi
  801bce:	89 fa                	mov    %edi,%edx
  801bd0:	83 c4 1c             	add    $0x1c,%esp
  801bd3:	5b                   	pop    %ebx
  801bd4:	5e                   	pop    %esi
  801bd5:	5f                   	pop    %edi
  801bd6:	5d                   	pop    %ebp
  801bd7:	c3                   	ret    
  801bd8:	39 ce                	cmp    %ecx,%esi
  801bda:	77 28                	ja     801c04 <__udivdi3+0x7c>
  801bdc:	0f bd fe             	bsr    %esi,%edi
  801bdf:	83 f7 1f             	xor    $0x1f,%edi
  801be2:	75 40                	jne    801c24 <__udivdi3+0x9c>
  801be4:	39 ce                	cmp    %ecx,%esi
  801be6:	72 0a                	jb     801bf2 <__udivdi3+0x6a>
  801be8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801bec:	0f 87 9e 00 00 00    	ja     801c90 <__udivdi3+0x108>
  801bf2:	b8 01 00 00 00       	mov    $0x1,%eax
  801bf7:	89 fa                	mov    %edi,%edx
  801bf9:	83 c4 1c             	add    $0x1c,%esp
  801bfc:	5b                   	pop    %ebx
  801bfd:	5e                   	pop    %esi
  801bfe:	5f                   	pop    %edi
  801bff:	5d                   	pop    %ebp
  801c00:	c3                   	ret    
  801c01:	8d 76 00             	lea    0x0(%esi),%esi
  801c04:	31 ff                	xor    %edi,%edi
  801c06:	31 c0                	xor    %eax,%eax
  801c08:	89 fa                	mov    %edi,%edx
  801c0a:	83 c4 1c             	add    $0x1c,%esp
  801c0d:	5b                   	pop    %ebx
  801c0e:	5e                   	pop    %esi
  801c0f:	5f                   	pop    %edi
  801c10:	5d                   	pop    %ebp
  801c11:	c3                   	ret    
  801c12:	66 90                	xchg   %ax,%ax
  801c14:	89 d8                	mov    %ebx,%eax
  801c16:	f7 f7                	div    %edi
  801c18:	31 ff                	xor    %edi,%edi
  801c1a:	89 fa                	mov    %edi,%edx
  801c1c:	83 c4 1c             	add    $0x1c,%esp
  801c1f:	5b                   	pop    %ebx
  801c20:	5e                   	pop    %esi
  801c21:	5f                   	pop    %edi
  801c22:	5d                   	pop    %ebp
  801c23:	c3                   	ret    
  801c24:	bd 20 00 00 00       	mov    $0x20,%ebp
  801c29:	89 eb                	mov    %ebp,%ebx
  801c2b:	29 fb                	sub    %edi,%ebx
  801c2d:	89 f9                	mov    %edi,%ecx
  801c2f:	d3 e6                	shl    %cl,%esi
  801c31:	89 c5                	mov    %eax,%ebp
  801c33:	88 d9                	mov    %bl,%cl
  801c35:	d3 ed                	shr    %cl,%ebp
  801c37:	89 e9                	mov    %ebp,%ecx
  801c39:	09 f1                	or     %esi,%ecx
  801c3b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801c3f:	89 f9                	mov    %edi,%ecx
  801c41:	d3 e0                	shl    %cl,%eax
  801c43:	89 c5                	mov    %eax,%ebp
  801c45:	89 d6                	mov    %edx,%esi
  801c47:	88 d9                	mov    %bl,%cl
  801c49:	d3 ee                	shr    %cl,%esi
  801c4b:	89 f9                	mov    %edi,%ecx
  801c4d:	d3 e2                	shl    %cl,%edx
  801c4f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c53:	88 d9                	mov    %bl,%cl
  801c55:	d3 e8                	shr    %cl,%eax
  801c57:	09 c2                	or     %eax,%edx
  801c59:	89 d0                	mov    %edx,%eax
  801c5b:	89 f2                	mov    %esi,%edx
  801c5d:	f7 74 24 0c          	divl   0xc(%esp)
  801c61:	89 d6                	mov    %edx,%esi
  801c63:	89 c3                	mov    %eax,%ebx
  801c65:	f7 e5                	mul    %ebp
  801c67:	39 d6                	cmp    %edx,%esi
  801c69:	72 19                	jb     801c84 <__udivdi3+0xfc>
  801c6b:	74 0b                	je     801c78 <__udivdi3+0xf0>
  801c6d:	89 d8                	mov    %ebx,%eax
  801c6f:	31 ff                	xor    %edi,%edi
  801c71:	e9 58 ff ff ff       	jmp    801bce <__udivdi3+0x46>
  801c76:	66 90                	xchg   %ax,%ax
  801c78:	8b 54 24 08          	mov    0x8(%esp),%edx
  801c7c:	89 f9                	mov    %edi,%ecx
  801c7e:	d3 e2                	shl    %cl,%edx
  801c80:	39 c2                	cmp    %eax,%edx
  801c82:	73 e9                	jae    801c6d <__udivdi3+0xe5>
  801c84:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801c87:	31 ff                	xor    %edi,%edi
  801c89:	e9 40 ff ff ff       	jmp    801bce <__udivdi3+0x46>
  801c8e:	66 90                	xchg   %ax,%ax
  801c90:	31 c0                	xor    %eax,%eax
  801c92:	e9 37 ff ff ff       	jmp    801bce <__udivdi3+0x46>
  801c97:	90                   	nop

00801c98 <__umoddi3>:
  801c98:	55                   	push   %ebp
  801c99:	57                   	push   %edi
  801c9a:	56                   	push   %esi
  801c9b:	53                   	push   %ebx
  801c9c:	83 ec 1c             	sub    $0x1c,%esp
  801c9f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ca3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ca7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801cab:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801caf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801cb3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801cb7:	89 f3                	mov    %esi,%ebx
  801cb9:	89 fa                	mov    %edi,%edx
  801cbb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801cbf:	89 34 24             	mov    %esi,(%esp)
  801cc2:	85 c0                	test   %eax,%eax
  801cc4:	75 1a                	jne    801ce0 <__umoddi3+0x48>
  801cc6:	39 f7                	cmp    %esi,%edi
  801cc8:	0f 86 a2 00 00 00    	jbe    801d70 <__umoddi3+0xd8>
  801cce:	89 c8                	mov    %ecx,%eax
  801cd0:	89 f2                	mov    %esi,%edx
  801cd2:	f7 f7                	div    %edi
  801cd4:	89 d0                	mov    %edx,%eax
  801cd6:	31 d2                	xor    %edx,%edx
  801cd8:	83 c4 1c             	add    $0x1c,%esp
  801cdb:	5b                   	pop    %ebx
  801cdc:	5e                   	pop    %esi
  801cdd:	5f                   	pop    %edi
  801cde:	5d                   	pop    %ebp
  801cdf:	c3                   	ret    
  801ce0:	39 f0                	cmp    %esi,%eax
  801ce2:	0f 87 ac 00 00 00    	ja     801d94 <__umoddi3+0xfc>
  801ce8:	0f bd e8             	bsr    %eax,%ebp
  801ceb:	83 f5 1f             	xor    $0x1f,%ebp
  801cee:	0f 84 ac 00 00 00    	je     801da0 <__umoddi3+0x108>
  801cf4:	bf 20 00 00 00       	mov    $0x20,%edi
  801cf9:	29 ef                	sub    %ebp,%edi
  801cfb:	89 fe                	mov    %edi,%esi
  801cfd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801d01:	89 e9                	mov    %ebp,%ecx
  801d03:	d3 e0                	shl    %cl,%eax
  801d05:	89 d7                	mov    %edx,%edi
  801d07:	89 f1                	mov    %esi,%ecx
  801d09:	d3 ef                	shr    %cl,%edi
  801d0b:	09 c7                	or     %eax,%edi
  801d0d:	89 e9                	mov    %ebp,%ecx
  801d0f:	d3 e2                	shl    %cl,%edx
  801d11:	89 14 24             	mov    %edx,(%esp)
  801d14:	89 d8                	mov    %ebx,%eax
  801d16:	d3 e0                	shl    %cl,%eax
  801d18:	89 c2                	mov    %eax,%edx
  801d1a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d1e:	d3 e0                	shl    %cl,%eax
  801d20:	89 44 24 04          	mov    %eax,0x4(%esp)
  801d24:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d28:	89 f1                	mov    %esi,%ecx
  801d2a:	d3 e8                	shr    %cl,%eax
  801d2c:	09 d0                	or     %edx,%eax
  801d2e:	d3 eb                	shr    %cl,%ebx
  801d30:	89 da                	mov    %ebx,%edx
  801d32:	f7 f7                	div    %edi
  801d34:	89 d3                	mov    %edx,%ebx
  801d36:	f7 24 24             	mull   (%esp)
  801d39:	89 c6                	mov    %eax,%esi
  801d3b:	89 d1                	mov    %edx,%ecx
  801d3d:	39 d3                	cmp    %edx,%ebx
  801d3f:	0f 82 87 00 00 00    	jb     801dcc <__umoddi3+0x134>
  801d45:	0f 84 91 00 00 00    	je     801ddc <__umoddi3+0x144>
  801d4b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801d4f:	29 f2                	sub    %esi,%edx
  801d51:	19 cb                	sbb    %ecx,%ebx
  801d53:	89 d8                	mov    %ebx,%eax
  801d55:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801d59:	d3 e0                	shl    %cl,%eax
  801d5b:	89 e9                	mov    %ebp,%ecx
  801d5d:	d3 ea                	shr    %cl,%edx
  801d5f:	09 d0                	or     %edx,%eax
  801d61:	89 e9                	mov    %ebp,%ecx
  801d63:	d3 eb                	shr    %cl,%ebx
  801d65:	89 da                	mov    %ebx,%edx
  801d67:	83 c4 1c             	add    $0x1c,%esp
  801d6a:	5b                   	pop    %ebx
  801d6b:	5e                   	pop    %esi
  801d6c:	5f                   	pop    %edi
  801d6d:	5d                   	pop    %ebp
  801d6e:	c3                   	ret    
  801d6f:	90                   	nop
  801d70:	89 fd                	mov    %edi,%ebp
  801d72:	85 ff                	test   %edi,%edi
  801d74:	75 0b                	jne    801d81 <__umoddi3+0xe9>
  801d76:	b8 01 00 00 00       	mov    $0x1,%eax
  801d7b:	31 d2                	xor    %edx,%edx
  801d7d:	f7 f7                	div    %edi
  801d7f:	89 c5                	mov    %eax,%ebp
  801d81:	89 f0                	mov    %esi,%eax
  801d83:	31 d2                	xor    %edx,%edx
  801d85:	f7 f5                	div    %ebp
  801d87:	89 c8                	mov    %ecx,%eax
  801d89:	f7 f5                	div    %ebp
  801d8b:	89 d0                	mov    %edx,%eax
  801d8d:	e9 44 ff ff ff       	jmp    801cd6 <__umoddi3+0x3e>
  801d92:	66 90                	xchg   %ax,%ax
  801d94:	89 c8                	mov    %ecx,%eax
  801d96:	89 f2                	mov    %esi,%edx
  801d98:	83 c4 1c             	add    $0x1c,%esp
  801d9b:	5b                   	pop    %ebx
  801d9c:	5e                   	pop    %esi
  801d9d:	5f                   	pop    %edi
  801d9e:	5d                   	pop    %ebp
  801d9f:	c3                   	ret    
  801da0:	3b 04 24             	cmp    (%esp),%eax
  801da3:	72 06                	jb     801dab <__umoddi3+0x113>
  801da5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801da9:	77 0f                	ja     801dba <__umoddi3+0x122>
  801dab:	89 f2                	mov    %esi,%edx
  801dad:	29 f9                	sub    %edi,%ecx
  801daf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801db3:	89 14 24             	mov    %edx,(%esp)
  801db6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801dba:	8b 44 24 04          	mov    0x4(%esp),%eax
  801dbe:	8b 14 24             	mov    (%esp),%edx
  801dc1:	83 c4 1c             	add    $0x1c,%esp
  801dc4:	5b                   	pop    %ebx
  801dc5:	5e                   	pop    %esi
  801dc6:	5f                   	pop    %edi
  801dc7:	5d                   	pop    %ebp
  801dc8:	c3                   	ret    
  801dc9:	8d 76 00             	lea    0x0(%esi),%esi
  801dcc:	2b 04 24             	sub    (%esp),%eax
  801dcf:	19 fa                	sbb    %edi,%edx
  801dd1:	89 d1                	mov    %edx,%ecx
  801dd3:	89 c6                	mov    %eax,%esi
  801dd5:	e9 71 ff ff ff       	jmp    801d4b <__umoddi3+0xb3>
  801dda:	66 90                	xchg   %ax,%ax
  801ddc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801de0:	72 ea                	jb     801dcc <__umoddi3+0x134>
  801de2:	89 d9                	mov    %ebx,%ecx
  801de4:	e9 62 ff ff ff       	jmp    801d4b <__umoddi3+0xb3>
