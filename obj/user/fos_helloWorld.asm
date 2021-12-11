
obj/user/fos_helloWorld:     file format elf32-i386


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
  800031:	e8 31 00 00 00       	call   800067 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// hello, world
#include <inc/lib.h>

void
_main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 08             	sub    $0x8,%esp
	extern unsigned char * etext;
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D %d\n",4);		
	atomic_cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D \n");
  80003e:	83 ec 0c             	sub    $0xc,%esp
  800041:	68 e0 18 80 00       	push   $0x8018e0
  800046:	e8 62 02 00 00       	call   8002ad <atomic_cprintf>
  80004b:	83 c4 10             	add    $0x10,%esp
	atomic_cprintf("end of code = %x\n",etext);
  80004e:	a1 c9 18 80 00       	mov    0x8018c9,%eax
  800053:	83 ec 08             	sub    $0x8,%esp
  800056:	50                   	push   %eax
  800057:	68 08 19 80 00       	push   $0x801908
  80005c:	e8 4c 02 00 00       	call   8002ad <atomic_cprintf>
  800061:	83 c4 10             	add    $0x10,%esp
}
  800064:	90                   	nop
  800065:	c9                   	leave  
  800066:	c3                   	ret    

00800067 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800067:	55                   	push   %ebp
  800068:	89 e5                	mov    %esp,%ebp
  80006a:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80006d:	e8 39 10 00 00       	call   8010ab <sys_getenvindex>
  800072:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800075:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800078:	89 d0                	mov    %edx,%eax
  80007a:	c1 e0 03             	shl    $0x3,%eax
  80007d:	01 d0                	add    %edx,%eax
  80007f:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800086:	01 c8                	add    %ecx,%eax
  800088:	01 c0                	add    %eax,%eax
  80008a:	01 d0                	add    %edx,%eax
  80008c:	01 c0                	add    %eax,%eax
  80008e:	01 d0                	add    %edx,%eax
  800090:	89 c2                	mov    %eax,%edx
  800092:	c1 e2 05             	shl    $0x5,%edx
  800095:	29 c2                	sub    %eax,%edx
  800097:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80009e:	89 c2                	mov    %eax,%edx
  8000a0:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8000a6:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000ab:	a1 20 20 80 00       	mov    0x802020,%eax
  8000b0:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8000b6:	84 c0                	test   %al,%al
  8000b8:	74 0f                	je     8000c9 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8000ba:	a1 20 20 80 00       	mov    0x802020,%eax
  8000bf:	05 40 3c 01 00       	add    $0x13c40,%eax
  8000c4:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000c9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000cd:	7e 0a                	jle    8000d9 <libmain+0x72>
		binaryname = argv[0];
  8000cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000d2:	8b 00                	mov    (%eax),%eax
  8000d4:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000d9:	83 ec 08             	sub    $0x8,%esp
  8000dc:	ff 75 0c             	pushl  0xc(%ebp)
  8000df:	ff 75 08             	pushl  0x8(%ebp)
  8000e2:	e8 51 ff ff ff       	call   800038 <_main>
  8000e7:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000ea:	e8 57 11 00 00       	call   801246 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000ef:	83 ec 0c             	sub    $0xc,%esp
  8000f2:	68 34 19 80 00       	push   $0x801934
  8000f7:	e8 84 01 00 00       	call   800280 <cprintf>
  8000fc:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8000ff:	a1 20 20 80 00       	mov    0x802020,%eax
  800104:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80010a:	a1 20 20 80 00       	mov    0x802020,%eax
  80010f:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800115:	83 ec 04             	sub    $0x4,%esp
  800118:	52                   	push   %edx
  800119:	50                   	push   %eax
  80011a:	68 5c 19 80 00       	push   $0x80195c
  80011f:	e8 5c 01 00 00       	call   800280 <cprintf>
  800124:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800127:	a1 20 20 80 00       	mov    0x802020,%eax
  80012c:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800132:	a1 20 20 80 00       	mov    0x802020,%eax
  800137:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80013d:	83 ec 04             	sub    $0x4,%esp
  800140:	52                   	push   %edx
  800141:	50                   	push   %eax
  800142:	68 84 19 80 00       	push   $0x801984
  800147:	e8 34 01 00 00       	call   800280 <cprintf>
  80014c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80014f:	a1 20 20 80 00       	mov    0x802020,%eax
  800154:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80015a:	83 ec 08             	sub    $0x8,%esp
  80015d:	50                   	push   %eax
  80015e:	68 c5 19 80 00       	push   $0x8019c5
  800163:	e8 18 01 00 00       	call   800280 <cprintf>
  800168:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80016b:	83 ec 0c             	sub    $0xc,%esp
  80016e:	68 34 19 80 00       	push   $0x801934
  800173:	e8 08 01 00 00       	call   800280 <cprintf>
  800178:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80017b:	e8 e0 10 00 00       	call   801260 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800180:	e8 19 00 00 00       	call   80019e <exit>
}
  800185:	90                   	nop
  800186:	c9                   	leave  
  800187:	c3                   	ret    

00800188 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800188:	55                   	push   %ebp
  800189:	89 e5                	mov    %esp,%ebp
  80018b:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80018e:	83 ec 0c             	sub    $0xc,%esp
  800191:	6a 00                	push   $0x0
  800193:	e8 df 0e 00 00       	call   801077 <sys_env_destroy>
  800198:	83 c4 10             	add    $0x10,%esp
}
  80019b:	90                   	nop
  80019c:	c9                   	leave  
  80019d:	c3                   	ret    

0080019e <exit>:

void
exit(void)
{
  80019e:	55                   	push   %ebp
  80019f:	89 e5                	mov    %esp,%ebp
  8001a1:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001a4:	e8 34 0f 00 00       	call   8010dd <sys_env_exit>
}
  8001a9:	90                   	nop
  8001aa:	c9                   	leave  
  8001ab:	c3                   	ret    

008001ac <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001ac:	55                   	push   %ebp
  8001ad:	89 e5                	mov    %esp,%ebp
  8001af:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001b5:	8b 00                	mov    (%eax),%eax
  8001b7:	8d 48 01             	lea    0x1(%eax),%ecx
  8001ba:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001bd:	89 0a                	mov    %ecx,(%edx)
  8001bf:	8b 55 08             	mov    0x8(%ebp),%edx
  8001c2:	88 d1                	mov    %dl,%cl
  8001c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001c7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ce:	8b 00                	mov    (%eax),%eax
  8001d0:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001d5:	75 2c                	jne    800203 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001d7:	a0 24 20 80 00       	mov    0x802024,%al
  8001dc:	0f b6 c0             	movzbl %al,%eax
  8001df:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001e2:	8b 12                	mov    (%edx),%edx
  8001e4:	89 d1                	mov    %edx,%ecx
  8001e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001e9:	83 c2 08             	add    $0x8,%edx
  8001ec:	83 ec 04             	sub    $0x4,%esp
  8001ef:	50                   	push   %eax
  8001f0:	51                   	push   %ecx
  8001f1:	52                   	push   %edx
  8001f2:	e8 3e 0e 00 00       	call   801035 <sys_cputs>
  8001f7:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001fd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800203:	8b 45 0c             	mov    0xc(%ebp),%eax
  800206:	8b 40 04             	mov    0x4(%eax),%eax
  800209:	8d 50 01             	lea    0x1(%eax),%edx
  80020c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020f:	89 50 04             	mov    %edx,0x4(%eax)
}
  800212:	90                   	nop
  800213:	c9                   	leave  
  800214:	c3                   	ret    

00800215 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800215:	55                   	push   %ebp
  800216:	89 e5                	mov    %esp,%ebp
  800218:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80021e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800225:	00 00 00 
	b.cnt = 0;
  800228:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80022f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800232:	ff 75 0c             	pushl  0xc(%ebp)
  800235:	ff 75 08             	pushl  0x8(%ebp)
  800238:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80023e:	50                   	push   %eax
  80023f:	68 ac 01 80 00       	push   $0x8001ac
  800244:	e8 11 02 00 00       	call   80045a <vprintfmt>
  800249:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80024c:	a0 24 20 80 00       	mov    0x802024,%al
  800251:	0f b6 c0             	movzbl %al,%eax
  800254:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80025a:	83 ec 04             	sub    $0x4,%esp
  80025d:	50                   	push   %eax
  80025e:	52                   	push   %edx
  80025f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800265:	83 c0 08             	add    $0x8,%eax
  800268:	50                   	push   %eax
  800269:	e8 c7 0d 00 00       	call   801035 <sys_cputs>
  80026e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800271:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  800278:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80027e:	c9                   	leave  
  80027f:	c3                   	ret    

00800280 <cprintf>:

int cprintf(const char *fmt, ...) {
  800280:	55                   	push   %ebp
  800281:	89 e5                	mov    %esp,%ebp
  800283:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800286:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  80028d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800290:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800293:	8b 45 08             	mov    0x8(%ebp),%eax
  800296:	83 ec 08             	sub    $0x8,%esp
  800299:	ff 75 f4             	pushl  -0xc(%ebp)
  80029c:	50                   	push   %eax
  80029d:	e8 73 ff ff ff       	call   800215 <vcprintf>
  8002a2:	83 c4 10             	add    $0x10,%esp
  8002a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002ab:	c9                   	leave  
  8002ac:	c3                   	ret    

008002ad <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002ad:	55                   	push   %ebp
  8002ae:	89 e5                	mov    %esp,%ebp
  8002b0:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002b3:	e8 8e 0f 00 00       	call   801246 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002b8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002be:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c1:	83 ec 08             	sub    $0x8,%esp
  8002c4:	ff 75 f4             	pushl  -0xc(%ebp)
  8002c7:	50                   	push   %eax
  8002c8:	e8 48 ff ff ff       	call   800215 <vcprintf>
  8002cd:	83 c4 10             	add    $0x10,%esp
  8002d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002d3:	e8 88 0f 00 00       	call   801260 <sys_enable_interrupt>
	return cnt;
  8002d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002db:	c9                   	leave  
  8002dc:	c3                   	ret    

008002dd <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002dd:	55                   	push   %ebp
  8002de:	89 e5                	mov    %esp,%ebp
  8002e0:	53                   	push   %ebx
  8002e1:	83 ec 14             	sub    $0x14,%esp
  8002e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002ea:	8b 45 14             	mov    0x14(%ebp),%eax
  8002ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002f0:	8b 45 18             	mov    0x18(%ebp),%eax
  8002f3:	ba 00 00 00 00       	mov    $0x0,%edx
  8002f8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002fb:	77 55                	ja     800352 <printnum+0x75>
  8002fd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800300:	72 05                	jb     800307 <printnum+0x2a>
  800302:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800305:	77 4b                	ja     800352 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800307:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80030a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80030d:	8b 45 18             	mov    0x18(%ebp),%eax
  800310:	ba 00 00 00 00       	mov    $0x0,%edx
  800315:	52                   	push   %edx
  800316:	50                   	push   %eax
  800317:	ff 75 f4             	pushl  -0xc(%ebp)
  80031a:	ff 75 f0             	pushl  -0x10(%ebp)
  80031d:	e8 46 13 00 00       	call   801668 <__udivdi3>
  800322:	83 c4 10             	add    $0x10,%esp
  800325:	83 ec 04             	sub    $0x4,%esp
  800328:	ff 75 20             	pushl  0x20(%ebp)
  80032b:	53                   	push   %ebx
  80032c:	ff 75 18             	pushl  0x18(%ebp)
  80032f:	52                   	push   %edx
  800330:	50                   	push   %eax
  800331:	ff 75 0c             	pushl  0xc(%ebp)
  800334:	ff 75 08             	pushl  0x8(%ebp)
  800337:	e8 a1 ff ff ff       	call   8002dd <printnum>
  80033c:	83 c4 20             	add    $0x20,%esp
  80033f:	eb 1a                	jmp    80035b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800341:	83 ec 08             	sub    $0x8,%esp
  800344:	ff 75 0c             	pushl  0xc(%ebp)
  800347:	ff 75 20             	pushl  0x20(%ebp)
  80034a:	8b 45 08             	mov    0x8(%ebp),%eax
  80034d:	ff d0                	call   *%eax
  80034f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800352:	ff 4d 1c             	decl   0x1c(%ebp)
  800355:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800359:	7f e6                	jg     800341 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80035b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80035e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800363:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800366:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800369:	53                   	push   %ebx
  80036a:	51                   	push   %ecx
  80036b:	52                   	push   %edx
  80036c:	50                   	push   %eax
  80036d:	e8 06 14 00 00       	call   801778 <__umoddi3>
  800372:	83 c4 10             	add    $0x10,%esp
  800375:	05 f4 1b 80 00       	add    $0x801bf4,%eax
  80037a:	8a 00                	mov    (%eax),%al
  80037c:	0f be c0             	movsbl %al,%eax
  80037f:	83 ec 08             	sub    $0x8,%esp
  800382:	ff 75 0c             	pushl  0xc(%ebp)
  800385:	50                   	push   %eax
  800386:	8b 45 08             	mov    0x8(%ebp),%eax
  800389:	ff d0                	call   *%eax
  80038b:	83 c4 10             	add    $0x10,%esp
}
  80038e:	90                   	nop
  80038f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800392:	c9                   	leave  
  800393:	c3                   	ret    

00800394 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800394:	55                   	push   %ebp
  800395:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800397:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80039b:	7e 1c                	jle    8003b9 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80039d:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a0:	8b 00                	mov    (%eax),%eax
  8003a2:	8d 50 08             	lea    0x8(%eax),%edx
  8003a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a8:	89 10                	mov    %edx,(%eax)
  8003aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ad:	8b 00                	mov    (%eax),%eax
  8003af:	83 e8 08             	sub    $0x8,%eax
  8003b2:	8b 50 04             	mov    0x4(%eax),%edx
  8003b5:	8b 00                	mov    (%eax),%eax
  8003b7:	eb 40                	jmp    8003f9 <getuint+0x65>
	else if (lflag)
  8003b9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003bd:	74 1e                	je     8003dd <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c2:	8b 00                	mov    (%eax),%eax
  8003c4:	8d 50 04             	lea    0x4(%eax),%edx
  8003c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ca:	89 10                	mov    %edx,(%eax)
  8003cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cf:	8b 00                	mov    (%eax),%eax
  8003d1:	83 e8 04             	sub    $0x4,%eax
  8003d4:	8b 00                	mov    (%eax),%eax
  8003d6:	ba 00 00 00 00       	mov    $0x0,%edx
  8003db:	eb 1c                	jmp    8003f9 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e0:	8b 00                	mov    (%eax),%eax
  8003e2:	8d 50 04             	lea    0x4(%eax),%edx
  8003e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e8:	89 10                	mov    %edx,(%eax)
  8003ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ed:	8b 00                	mov    (%eax),%eax
  8003ef:	83 e8 04             	sub    $0x4,%eax
  8003f2:	8b 00                	mov    (%eax),%eax
  8003f4:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003f9:	5d                   	pop    %ebp
  8003fa:	c3                   	ret    

008003fb <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003fb:	55                   	push   %ebp
  8003fc:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003fe:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800402:	7e 1c                	jle    800420 <getint+0x25>
		return va_arg(*ap, long long);
  800404:	8b 45 08             	mov    0x8(%ebp),%eax
  800407:	8b 00                	mov    (%eax),%eax
  800409:	8d 50 08             	lea    0x8(%eax),%edx
  80040c:	8b 45 08             	mov    0x8(%ebp),%eax
  80040f:	89 10                	mov    %edx,(%eax)
  800411:	8b 45 08             	mov    0x8(%ebp),%eax
  800414:	8b 00                	mov    (%eax),%eax
  800416:	83 e8 08             	sub    $0x8,%eax
  800419:	8b 50 04             	mov    0x4(%eax),%edx
  80041c:	8b 00                	mov    (%eax),%eax
  80041e:	eb 38                	jmp    800458 <getint+0x5d>
	else if (lflag)
  800420:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800424:	74 1a                	je     800440 <getint+0x45>
		return va_arg(*ap, long);
  800426:	8b 45 08             	mov    0x8(%ebp),%eax
  800429:	8b 00                	mov    (%eax),%eax
  80042b:	8d 50 04             	lea    0x4(%eax),%edx
  80042e:	8b 45 08             	mov    0x8(%ebp),%eax
  800431:	89 10                	mov    %edx,(%eax)
  800433:	8b 45 08             	mov    0x8(%ebp),%eax
  800436:	8b 00                	mov    (%eax),%eax
  800438:	83 e8 04             	sub    $0x4,%eax
  80043b:	8b 00                	mov    (%eax),%eax
  80043d:	99                   	cltd   
  80043e:	eb 18                	jmp    800458 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800440:	8b 45 08             	mov    0x8(%ebp),%eax
  800443:	8b 00                	mov    (%eax),%eax
  800445:	8d 50 04             	lea    0x4(%eax),%edx
  800448:	8b 45 08             	mov    0x8(%ebp),%eax
  80044b:	89 10                	mov    %edx,(%eax)
  80044d:	8b 45 08             	mov    0x8(%ebp),%eax
  800450:	8b 00                	mov    (%eax),%eax
  800452:	83 e8 04             	sub    $0x4,%eax
  800455:	8b 00                	mov    (%eax),%eax
  800457:	99                   	cltd   
}
  800458:	5d                   	pop    %ebp
  800459:	c3                   	ret    

0080045a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80045a:	55                   	push   %ebp
  80045b:	89 e5                	mov    %esp,%ebp
  80045d:	56                   	push   %esi
  80045e:	53                   	push   %ebx
  80045f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800462:	eb 17                	jmp    80047b <vprintfmt+0x21>
			if (ch == '\0')
  800464:	85 db                	test   %ebx,%ebx
  800466:	0f 84 af 03 00 00    	je     80081b <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80046c:	83 ec 08             	sub    $0x8,%esp
  80046f:	ff 75 0c             	pushl  0xc(%ebp)
  800472:	53                   	push   %ebx
  800473:	8b 45 08             	mov    0x8(%ebp),%eax
  800476:	ff d0                	call   *%eax
  800478:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80047b:	8b 45 10             	mov    0x10(%ebp),%eax
  80047e:	8d 50 01             	lea    0x1(%eax),%edx
  800481:	89 55 10             	mov    %edx,0x10(%ebp)
  800484:	8a 00                	mov    (%eax),%al
  800486:	0f b6 d8             	movzbl %al,%ebx
  800489:	83 fb 25             	cmp    $0x25,%ebx
  80048c:	75 d6                	jne    800464 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80048e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800492:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800499:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004a0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004a7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8004b1:	8d 50 01             	lea    0x1(%eax),%edx
  8004b4:	89 55 10             	mov    %edx,0x10(%ebp)
  8004b7:	8a 00                	mov    (%eax),%al
  8004b9:	0f b6 d8             	movzbl %al,%ebx
  8004bc:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004bf:	83 f8 55             	cmp    $0x55,%eax
  8004c2:	0f 87 2b 03 00 00    	ja     8007f3 <vprintfmt+0x399>
  8004c8:	8b 04 85 18 1c 80 00 	mov    0x801c18(,%eax,4),%eax
  8004cf:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004d1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004d5:	eb d7                	jmp    8004ae <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004d7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004db:	eb d1                	jmp    8004ae <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004dd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004e4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004e7:	89 d0                	mov    %edx,%eax
  8004e9:	c1 e0 02             	shl    $0x2,%eax
  8004ec:	01 d0                	add    %edx,%eax
  8004ee:	01 c0                	add    %eax,%eax
  8004f0:	01 d8                	add    %ebx,%eax
  8004f2:	83 e8 30             	sub    $0x30,%eax
  8004f5:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8004fb:	8a 00                	mov    (%eax),%al
  8004fd:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800500:	83 fb 2f             	cmp    $0x2f,%ebx
  800503:	7e 3e                	jle    800543 <vprintfmt+0xe9>
  800505:	83 fb 39             	cmp    $0x39,%ebx
  800508:	7f 39                	jg     800543 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80050a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80050d:	eb d5                	jmp    8004e4 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80050f:	8b 45 14             	mov    0x14(%ebp),%eax
  800512:	83 c0 04             	add    $0x4,%eax
  800515:	89 45 14             	mov    %eax,0x14(%ebp)
  800518:	8b 45 14             	mov    0x14(%ebp),%eax
  80051b:	83 e8 04             	sub    $0x4,%eax
  80051e:	8b 00                	mov    (%eax),%eax
  800520:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800523:	eb 1f                	jmp    800544 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800525:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800529:	79 83                	jns    8004ae <vprintfmt+0x54>
				width = 0;
  80052b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800532:	e9 77 ff ff ff       	jmp    8004ae <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800537:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80053e:	e9 6b ff ff ff       	jmp    8004ae <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800543:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800544:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800548:	0f 89 60 ff ff ff    	jns    8004ae <vprintfmt+0x54>
				width = precision, precision = -1;
  80054e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800551:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800554:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80055b:	e9 4e ff ff ff       	jmp    8004ae <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800560:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800563:	e9 46 ff ff ff       	jmp    8004ae <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800568:	8b 45 14             	mov    0x14(%ebp),%eax
  80056b:	83 c0 04             	add    $0x4,%eax
  80056e:	89 45 14             	mov    %eax,0x14(%ebp)
  800571:	8b 45 14             	mov    0x14(%ebp),%eax
  800574:	83 e8 04             	sub    $0x4,%eax
  800577:	8b 00                	mov    (%eax),%eax
  800579:	83 ec 08             	sub    $0x8,%esp
  80057c:	ff 75 0c             	pushl  0xc(%ebp)
  80057f:	50                   	push   %eax
  800580:	8b 45 08             	mov    0x8(%ebp),%eax
  800583:	ff d0                	call   *%eax
  800585:	83 c4 10             	add    $0x10,%esp
			break;
  800588:	e9 89 02 00 00       	jmp    800816 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80058d:	8b 45 14             	mov    0x14(%ebp),%eax
  800590:	83 c0 04             	add    $0x4,%eax
  800593:	89 45 14             	mov    %eax,0x14(%ebp)
  800596:	8b 45 14             	mov    0x14(%ebp),%eax
  800599:	83 e8 04             	sub    $0x4,%eax
  80059c:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80059e:	85 db                	test   %ebx,%ebx
  8005a0:	79 02                	jns    8005a4 <vprintfmt+0x14a>
				err = -err;
  8005a2:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005a4:	83 fb 64             	cmp    $0x64,%ebx
  8005a7:	7f 0b                	jg     8005b4 <vprintfmt+0x15a>
  8005a9:	8b 34 9d 60 1a 80 00 	mov    0x801a60(,%ebx,4),%esi
  8005b0:	85 f6                	test   %esi,%esi
  8005b2:	75 19                	jne    8005cd <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005b4:	53                   	push   %ebx
  8005b5:	68 05 1c 80 00       	push   $0x801c05
  8005ba:	ff 75 0c             	pushl  0xc(%ebp)
  8005bd:	ff 75 08             	pushl  0x8(%ebp)
  8005c0:	e8 5e 02 00 00       	call   800823 <printfmt>
  8005c5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005c8:	e9 49 02 00 00       	jmp    800816 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005cd:	56                   	push   %esi
  8005ce:	68 0e 1c 80 00       	push   $0x801c0e
  8005d3:	ff 75 0c             	pushl  0xc(%ebp)
  8005d6:	ff 75 08             	pushl  0x8(%ebp)
  8005d9:	e8 45 02 00 00       	call   800823 <printfmt>
  8005de:	83 c4 10             	add    $0x10,%esp
			break;
  8005e1:	e9 30 02 00 00       	jmp    800816 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e9:	83 c0 04             	add    $0x4,%eax
  8005ec:	89 45 14             	mov    %eax,0x14(%ebp)
  8005ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8005f2:	83 e8 04             	sub    $0x4,%eax
  8005f5:	8b 30                	mov    (%eax),%esi
  8005f7:	85 f6                	test   %esi,%esi
  8005f9:	75 05                	jne    800600 <vprintfmt+0x1a6>
				p = "(null)";
  8005fb:	be 11 1c 80 00       	mov    $0x801c11,%esi
			if (width > 0 && padc != '-')
  800600:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800604:	7e 6d                	jle    800673 <vprintfmt+0x219>
  800606:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80060a:	74 67                	je     800673 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80060c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80060f:	83 ec 08             	sub    $0x8,%esp
  800612:	50                   	push   %eax
  800613:	56                   	push   %esi
  800614:	e8 0c 03 00 00       	call   800925 <strnlen>
  800619:	83 c4 10             	add    $0x10,%esp
  80061c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80061f:	eb 16                	jmp    800637 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800621:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800625:	83 ec 08             	sub    $0x8,%esp
  800628:	ff 75 0c             	pushl  0xc(%ebp)
  80062b:	50                   	push   %eax
  80062c:	8b 45 08             	mov    0x8(%ebp),%eax
  80062f:	ff d0                	call   *%eax
  800631:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800634:	ff 4d e4             	decl   -0x1c(%ebp)
  800637:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80063b:	7f e4                	jg     800621 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80063d:	eb 34                	jmp    800673 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80063f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800643:	74 1c                	je     800661 <vprintfmt+0x207>
  800645:	83 fb 1f             	cmp    $0x1f,%ebx
  800648:	7e 05                	jle    80064f <vprintfmt+0x1f5>
  80064a:	83 fb 7e             	cmp    $0x7e,%ebx
  80064d:	7e 12                	jle    800661 <vprintfmt+0x207>
					putch('?', putdat);
  80064f:	83 ec 08             	sub    $0x8,%esp
  800652:	ff 75 0c             	pushl  0xc(%ebp)
  800655:	6a 3f                	push   $0x3f
  800657:	8b 45 08             	mov    0x8(%ebp),%eax
  80065a:	ff d0                	call   *%eax
  80065c:	83 c4 10             	add    $0x10,%esp
  80065f:	eb 0f                	jmp    800670 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800661:	83 ec 08             	sub    $0x8,%esp
  800664:	ff 75 0c             	pushl  0xc(%ebp)
  800667:	53                   	push   %ebx
  800668:	8b 45 08             	mov    0x8(%ebp),%eax
  80066b:	ff d0                	call   *%eax
  80066d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800670:	ff 4d e4             	decl   -0x1c(%ebp)
  800673:	89 f0                	mov    %esi,%eax
  800675:	8d 70 01             	lea    0x1(%eax),%esi
  800678:	8a 00                	mov    (%eax),%al
  80067a:	0f be d8             	movsbl %al,%ebx
  80067d:	85 db                	test   %ebx,%ebx
  80067f:	74 24                	je     8006a5 <vprintfmt+0x24b>
  800681:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800685:	78 b8                	js     80063f <vprintfmt+0x1e5>
  800687:	ff 4d e0             	decl   -0x20(%ebp)
  80068a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80068e:	79 af                	jns    80063f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800690:	eb 13                	jmp    8006a5 <vprintfmt+0x24b>
				putch(' ', putdat);
  800692:	83 ec 08             	sub    $0x8,%esp
  800695:	ff 75 0c             	pushl  0xc(%ebp)
  800698:	6a 20                	push   $0x20
  80069a:	8b 45 08             	mov    0x8(%ebp),%eax
  80069d:	ff d0                	call   *%eax
  80069f:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006a2:	ff 4d e4             	decl   -0x1c(%ebp)
  8006a5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006a9:	7f e7                	jg     800692 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006ab:	e9 66 01 00 00       	jmp    800816 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006b0:	83 ec 08             	sub    $0x8,%esp
  8006b3:	ff 75 e8             	pushl  -0x18(%ebp)
  8006b6:	8d 45 14             	lea    0x14(%ebp),%eax
  8006b9:	50                   	push   %eax
  8006ba:	e8 3c fd ff ff       	call   8003fb <getint>
  8006bf:	83 c4 10             	add    $0x10,%esp
  8006c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006c5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006cb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006ce:	85 d2                	test   %edx,%edx
  8006d0:	79 23                	jns    8006f5 <vprintfmt+0x29b>
				putch('-', putdat);
  8006d2:	83 ec 08             	sub    $0x8,%esp
  8006d5:	ff 75 0c             	pushl  0xc(%ebp)
  8006d8:	6a 2d                	push   $0x2d
  8006da:	8b 45 08             	mov    0x8(%ebp),%eax
  8006dd:	ff d0                	call   *%eax
  8006df:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006e8:	f7 d8                	neg    %eax
  8006ea:	83 d2 00             	adc    $0x0,%edx
  8006ed:	f7 da                	neg    %edx
  8006ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006f2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006f5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006fc:	e9 bc 00 00 00       	jmp    8007bd <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800701:	83 ec 08             	sub    $0x8,%esp
  800704:	ff 75 e8             	pushl  -0x18(%ebp)
  800707:	8d 45 14             	lea    0x14(%ebp),%eax
  80070a:	50                   	push   %eax
  80070b:	e8 84 fc ff ff       	call   800394 <getuint>
  800710:	83 c4 10             	add    $0x10,%esp
  800713:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800716:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800719:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800720:	e9 98 00 00 00       	jmp    8007bd <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800725:	83 ec 08             	sub    $0x8,%esp
  800728:	ff 75 0c             	pushl  0xc(%ebp)
  80072b:	6a 58                	push   $0x58
  80072d:	8b 45 08             	mov    0x8(%ebp),%eax
  800730:	ff d0                	call   *%eax
  800732:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800735:	83 ec 08             	sub    $0x8,%esp
  800738:	ff 75 0c             	pushl  0xc(%ebp)
  80073b:	6a 58                	push   $0x58
  80073d:	8b 45 08             	mov    0x8(%ebp),%eax
  800740:	ff d0                	call   *%eax
  800742:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800745:	83 ec 08             	sub    $0x8,%esp
  800748:	ff 75 0c             	pushl  0xc(%ebp)
  80074b:	6a 58                	push   $0x58
  80074d:	8b 45 08             	mov    0x8(%ebp),%eax
  800750:	ff d0                	call   *%eax
  800752:	83 c4 10             	add    $0x10,%esp
			break;
  800755:	e9 bc 00 00 00       	jmp    800816 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80075a:	83 ec 08             	sub    $0x8,%esp
  80075d:	ff 75 0c             	pushl  0xc(%ebp)
  800760:	6a 30                	push   $0x30
  800762:	8b 45 08             	mov    0x8(%ebp),%eax
  800765:	ff d0                	call   *%eax
  800767:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80076a:	83 ec 08             	sub    $0x8,%esp
  80076d:	ff 75 0c             	pushl  0xc(%ebp)
  800770:	6a 78                	push   $0x78
  800772:	8b 45 08             	mov    0x8(%ebp),%eax
  800775:	ff d0                	call   *%eax
  800777:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80077a:	8b 45 14             	mov    0x14(%ebp),%eax
  80077d:	83 c0 04             	add    $0x4,%eax
  800780:	89 45 14             	mov    %eax,0x14(%ebp)
  800783:	8b 45 14             	mov    0x14(%ebp),%eax
  800786:	83 e8 04             	sub    $0x4,%eax
  800789:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80078b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80078e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800795:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80079c:	eb 1f                	jmp    8007bd <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80079e:	83 ec 08             	sub    $0x8,%esp
  8007a1:	ff 75 e8             	pushl  -0x18(%ebp)
  8007a4:	8d 45 14             	lea    0x14(%ebp),%eax
  8007a7:	50                   	push   %eax
  8007a8:	e8 e7 fb ff ff       	call   800394 <getuint>
  8007ad:	83 c4 10             	add    $0x10,%esp
  8007b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007b3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007b6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007bd:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007c4:	83 ec 04             	sub    $0x4,%esp
  8007c7:	52                   	push   %edx
  8007c8:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007cb:	50                   	push   %eax
  8007cc:	ff 75 f4             	pushl  -0xc(%ebp)
  8007cf:	ff 75 f0             	pushl  -0x10(%ebp)
  8007d2:	ff 75 0c             	pushl  0xc(%ebp)
  8007d5:	ff 75 08             	pushl  0x8(%ebp)
  8007d8:	e8 00 fb ff ff       	call   8002dd <printnum>
  8007dd:	83 c4 20             	add    $0x20,%esp
			break;
  8007e0:	eb 34                	jmp    800816 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007e2:	83 ec 08             	sub    $0x8,%esp
  8007e5:	ff 75 0c             	pushl  0xc(%ebp)
  8007e8:	53                   	push   %ebx
  8007e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ec:	ff d0                	call   *%eax
  8007ee:	83 c4 10             	add    $0x10,%esp
			break;
  8007f1:	eb 23                	jmp    800816 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007f3:	83 ec 08             	sub    $0x8,%esp
  8007f6:	ff 75 0c             	pushl  0xc(%ebp)
  8007f9:	6a 25                	push   $0x25
  8007fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fe:	ff d0                	call   *%eax
  800800:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800803:	ff 4d 10             	decl   0x10(%ebp)
  800806:	eb 03                	jmp    80080b <vprintfmt+0x3b1>
  800808:	ff 4d 10             	decl   0x10(%ebp)
  80080b:	8b 45 10             	mov    0x10(%ebp),%eax
  80080e:	48                   	dec    %eax
  80080f:	8a 00                	mov    (%eax),%al
  800811:	3c 25                	cmp    $0x25,%al
  800813:	75 f3                	jne    800808 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800815:	90                   	nop
		}
	}
  800816:	e9 47 fc ff ff       	jmp    800462 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80081b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80081c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80081f:	5b                   	pop    %ebx
  800820:	5e                   	pop    %esi
  800821:	5d                   	pop    %ebp
  800822:	c3                   	ret    

00800823 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800823:	55                   	push   %ebp
  800824:	89 e5                	mov    %esp,%ebp
  800826:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800829:	8d 45 10             	lea    0x10(%ebp),%eax
  80082c:	83 c0 04             	add    $0x4,%eax
  80082f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800832:	8b 45 10             	mov    0x10(%ebp),%eax
  800835:	ff 75 f4             	pushl  -0xc(%ebp)
  800838:	50                   	push   %eax
  800839:	ff 75 0c             	pushl  0xc(%ebp)
  80083c:	ff 75 08             	pushl  0x8(%ebp)
  80083f:	e8 16 fc ff ff       	call   80045a <vprintfmt>
  800844:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800847:	90                   	nop
  800848:	c9                   	leave  
  800849:	c3                   	ret    

0080084a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80084a:	55                   	push   %ebp
  80084b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80084d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800850:	8b 40 08             	mov    0x8(%eax),%eax
  800853:	8d 50 01             	lea    0x1(%eax),%edx
  800856:	8b 45 0c             	mov    0xc(%ebp),%eax
  800859:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80085c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80085f:	8b 10                	mov    (%eax),%edx
  800861:	8b 45 0c             	mov    0xc(%ebp),%eax
  800864:	8b 40 04             	mov    0x4(%eax),%eax
  800867:	39 c2                	cmp    %eax,%edx
  800869:	73 12                	jae    80087d <sprintputch+0x33>
		*b->buf++ = ch;
  80086b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80086e:	8b 00                	mov    (%eax),%eax
  800870:	8d 48 01             	lea    0x1(%eax),%ecx
  800873:	8b 55 0c             	mov    0xc(%ebp),%edx
  800876:	89 0a                	mov    %ecx,(%edx)
  800878:	8b 55 08             	mov    0x8(%ebp),%edx
  80087b:	88 10                	mov    %dl,(%eax)
}
  80087d:	90                   	nop
  80087e:	5d                   	pop    %ebp
  80087f:	c3                   	ret    

00800880 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800880:	55                   	push   %ebp
  800881:	89 e5                	mov    %esp,%ebp
  800883:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800886:	8b 45 08             	mov    0x8(%ebp),%eax
  800889:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80088c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800892:	8b 45 08             	mov    0x8(%ebp),%eax
  800895:	01 d0                	add    %edx,%eax
  800897:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80089a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008a1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008a5:	74 06                	je     8008ad <vsnprintf+0x2d>
  8008a7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008ab:	7f 07                	jg     8008b4 <vsnprintf+0x34>
		return -E_INVAL;
  8008ad:	b8 03 00 00 00       	mov    $0x3,%eax
  8008b2:	eb 20                	jmp    8008d4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008b4:	ff 75 14             	pushl  0x14(%ebp)
  8008b7:	ff 75 10             	pushl  0x10(%ebp)
  8008ba:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008bd:	50                   	push   %eax
  8008be:	68 4a 08 80 00       	push   $0x80084a
  8008c3:	e8 92 fb ff ff       	call   80045a <vprintfmt>
  8008c8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008cb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008ce:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008d4:	c9                   	leave  
  8008d5:	c3                   	ret    

008008d6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008d6:	55                   	push   %ebp
  8008d7:	89 e5                	mov    %esp,%ebp
  8008d9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008dc:	8d 45 10             	lea    0x10(%ebp),%eax
  8008df:	83 c0 04             	add    $0x4,%eax
  8008e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8008e8:	ff 75 f4             	pushl  -0xc(%ebp)
  8008eb:	50                   	push   %eax
  8008ec:	ff 75 0c             	pushl  0xc(%ebp)
  8008ef:	ff 75 08             	pushl  0x8(%ebp)
  8008f2:	e8 89 ff ff ff       	call   800880 <vsnprintf>
  8008f7:	83 c4 10             	add    $0x10,%esp
  8008fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800900:	c9                   	leave  
  800901:	c3                   	ret    

00800902 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800902:	55                   	push   %ebp
  800903:	89 e5                	mov    %esp,%ebp
  800905:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800908:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80090f:	eb 06                	jmp    800917 <strlen+0x15>
		n++;
  800911:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800914:	ff 45 08             	incl   0x8(%ebp)
  800917:	8b 45 08             	mov    0x8(%ebp),%eax
  80091a:	8a 00                	mov    (%eax),%al
  80091c:	84 c0                	test   %al,%al
  80091e:	75 f1                	jne    800911 <strlen+0xf>
		n++;
	return n;
  800920:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800923:	c9                   	leave  
  800924:	c3                   	ret    

00800925 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800925:	55                   	push   %ebp
  800926:	89 e5                	mov    %esp,%ebp
  800928:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80092b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800932:	eb 09                	jmp    80093d <strnlen+0x18>
		n++;
  800934:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800937:	ff 45 08             	incl   0x8(%ebp)
  80093a:	ff 4d 0c             	decl   0xc(%ebp)
  80093d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800941:	74 09                	je     80094c <strnlen+0x27>
  800943:	8b 45 08             	mov    0x8(%ebp),%eax
  800946:	8a 00                	mov    (%eax),%al
  800948:	84 c0                	test   %al,%al
  80094a:	75 e8                	jne    800934 <strnlen+0xf>
		n++;
	return n;
  80094c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80094f:	c9                   	leave  
  800950:	c3                   	ret    

00800951 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800951:	55                   	push   %ebp
  800952:	89 e5                	mov    %esp,%ebp
  800954:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800957:	8b 45 08             	mov    0x8(%ebp),%eax
  80095a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80095d:	90                   	nop
  80095e:	8b 45 08             	mov    0x8(%ebp),%eax
  800961:	8d 50 01             	lea    0x1(%eax),%edx
  800964:	89 55 08             	mov    %edx,0x8(%ebp)
  800967:	8b 55 0c             	mov    0xc(%ebp),%edx
  80096a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80096d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800970:	8a 12                	mov    (%edx),%dl
  800972:	88 10                	mov    %dl,(%eax)
  800974:	8a 00                	mov    (%eax),%al
  800976:	84 c0                	test   %al,%al
  800978:	75 e4                	jne    80095e <strcpy+0xd>
		/* do nothing */;
	return ret;
  80097a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80097d:	c9                   	leave  
  80097e:	c3                   	ret    

0080097f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80097f:	55                   	push   %ebp
  800980:	89 e5                	mov    %esp,%ebp
  800982:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800985:	8b 45 08             	mov    0x8(%ebp),%eax
  800988:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80098b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800992:	eb 1f                	jmp    8009b3 <strncpy+0x34>
		*dst++ = *src;
  800994:	8b 45 08             	mov    0x8(%ebp),%eax
  800997:	8d 50 01             	lea    0x1(%eax),%edx
  80099a:	89 55 08             	mov    %edx,0x8(%ebp)
  80099d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009a0:	8a 12                	mov    (%edx),%dl
  8009a2:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a7:	8a 00                	mov    (%eax),%al
  8009a9:	84 c0                	test   %al,%al
  8009ab:	74 03                	je     8009b0 <strncpy+0x31>
			src++;
  8009ad:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009b0:	ff 45 fc             	incl   -0x4(%ebp)
  8009b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009b6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009b9:	72 d9                	jb     800994 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009be:	c9                   	leave  
  8009bf:	c3                   	ret    

008009c0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009c0:	55                   	push   %ebp
  8009c1:	89 e5                	mov    %esp,%ebp
  8009c3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009cc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009d0:	74 30                	je     800a02 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009d2:	eb 16                	jmp    8009ea <strlcpy+0x2a>
			*dst++ = *src++;
  8009d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d7:	8d 50 01             	lea    0x1(%eax),%edx
  8009da:	89 55 08             	mov    %edx,0x8(%ebp)
  8009dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009e0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009e3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009e6:	8a 12                	mov    (%edx),%dl
  8009e8:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009ea:	ff 4d 10             	decl   0x10(%ebp)
  8009ed:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009f1:	74 09                	je     8009fc <strlcpy+0x3c>
  8009f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f6:	8a 00                	mov    (%eax),%al
  8009f8:	84 c0                	test   %al,%al
  8009fa:	75 d8                	jne    8009d4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ff:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a02:	8b 55 08             	mov    0x8(%ebp),%edx
  800a05:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a08:	29 c2                	sub    %eax,%edx
  800a0a:	89 d0                	mov    %edx,%eax
}
  800a0c:	c9                   	leave  
  800a0d:	c3                   	ret    

00800a0e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a0e:	55                   	push   %ebp
  800a0f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a11:	eb 06                	jmp    800a19 <strcmp+0xb>
		p++, q++;
  800a13:	ff 45 08             	incl   0x8(%ebp)
  800a16:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a19:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1c:	8a 00                	mov    (%eax),%al
  800a1e:	84 c0                	test   %al,%al
  800a20:	74 0e                	je     800a30 <strcmp+0x22>
  800a22:	8b 45 08             	mov    0x8(%ebp),%eax
  800a25:	8a 10                	mov    (%eax),%dl
  800a27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a2a:	8a 00                	mov    (%eax),%al
  800a2c:	38 c2                	cmp    %al,%dl
  800a2e:	74 e3                	je     800a13 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a30:	8b 45 08             	mov    0x8(%ebp),%eax
  800a33:	8a 00                	mov    (%eax),%al
  800a35:	0f b6 d0             	movzbl %al,%edx
  800a38:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3b:	8a 00                	mov    (%eax),%al
  800a3d:	0f b6 c0             	movzbl %al,%eax
  800a40:	29 c2                	sub    %eax,%edx
  800a42:	89 d0                	mov    %edx,%eax
}
  800a44:	5d                   	pop    %ebp
  800a45:	c3                   	ret    

00800a46 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a46:	55                   	push   %ebp
  800a47:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a49:	eb 09                	jmp    800a54 <strncmp+0xe>
		n--, p++, q++;
  800a4b:	ff 4d 10             	decl   0x10(%ebp)
  800a4e:	ff 45 08             	incl   0x8(%ebp)
  800a51:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a54:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a58:	74 17                	je     800a71 <strncmp+0x2b>
  800a5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5d:	8a 00                	mov    (%eax),%al
  800a5f:	84 c0                	test   %al,%al
  800a61:	74 0e                	je     800a71 <strncmp+0x2b>
  800a63:	8b 45 08             	mov    0x8(%ebp),%eax
  800a66:	8a 10                	mov    (%eax),%dl
  800a68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6b:	8a 00                	mov    (%eax),%al
  800a6d:	38 c2                	cmp    %al,%dl
  800a6f:	74 da                	je     800a4b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a71:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a75:	75 07                	jne    800a7e <strncmp+0x38>
		return 0;
  800a77:	b8 00 00 00 00       	mov    $0x0,%eax
  800a7c:	eb 14                	jmp    800a92 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a81:	8a 00                	mov    (%eax),%al
  800a83:	0f b6 d0             	movzbl %al,%edx
  800a86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a89:	8a 00                	mov    (%eax),%al
  800a8b:	0f b6 c0             	movzbl %al,%eax
  800a8e:	29 c2                	sub    %eax,%edx
  800a90:	89 d0                	mov    %edx,%eax
}
  800a92:	5d                   	pop    %ebp
  800a93:	c3                   	ret    

00800a94 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a94:	55                   	push   %ebp
  800a95:	89 e5                	mov    %esp,%ebp
  800a97:	83 ec 04             	sub    $0x4,%esp
  800a9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800aa0:	eb 12                	jmp    800ab4 <strchr+0x20>
		if (*s == c)
  800aa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa5:	8a 00                	mov    (%eax),%al
  800aa7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800aaa:	75 05                	jne    800ab1 <strchr+0x1d>
			return (char *) s;
  800aac:	8b 45 08             	mov    0x8(%ebp),%eax
  800aaf:	eb 11                	jmp    800ac2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ab1:	ff 45 08             	incl   0x8(%ebp)
  800ab4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab7:	8a 00                	mov    (%eax),%al
  800ab9:	84 c0                	test   %al,%al
  800abb:	75 e5                	jne    800aa2 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800abd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ac2:	c9                   	leave  
  800ac3:	c3                   	ret    

00800ac4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ac4:	55                   	push   %ebp
  800ac5:	89 e5                	mov    %esp,%ebp
  800ac7:	83 ec 04             	sub    $0x4,%esp
  800aca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800acd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ad0:	eb 0d                	jmp    800adf <strfind+0x1b>
		if (*s == c)
  800ad2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad5:	8a 00                	mov    (%eax),%al
  800ad7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ada:	74 0e                	je     800aea <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800adc:	ff 45 08             	incl   0x8(%ebp)
  800adf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae2:	8a 00                	mov    (%eax),%al
  800ae4:	84 c0                	test   %al,%al
  800ae6:	75 ea                	jne    800ad2 <strfind+0xe>
  800ae8:	eb 01                	jmp    800aeb <strfind+0x27>
		if (*s == c)
			break;
  800aea:	90                   	nop
	return (char *) s;
  800aeb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800aee:	c9                   	leave  
  800aef:	c3                   	ret    

00800af0 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800af0:	55                   	push   %ebp
  800af1:	89 e5                	mov    %esp,%ebp
  800af3:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800af6:	8b 45 08             	mov    0x8(%ebp),%eax
  800af9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800afc:	8b 45 10             	mov    0x10(%ebp),%eax
  800aff:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b02:	eb 0e                	jmp    800b12 <memset+0x22>
		*p++ = c;
  800b04:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b07:	8d 50 01             	lea    0x1(%eax),%edx
  800b0a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b0d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b10:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b12:	ff 4d f8             	decl   -0x8(%ebp)
  800b15:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b19:	79 e9                	jns    800b04 <memset+0x14>
		*p++ = c;

	return v;
  800b1b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b1e:	c9                   	leave  
  800b1f:	c3                   	ret    

00800b20 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b20:	55                   	push   %ebp
  800b21:	89 e5                	mov    %esp,%ebp
  800b23:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b29:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b32:	eb 16                	jmp    800b4a <memcpy+0x2a>
		*d++ = *s++;
  800b34:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b37:	8d 50 01             	lea    0x1(%eax),%edx
  800b3a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b3d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b40:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b43:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b46:	8a 12                	mov    (%edx),%dl
  800b48:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b4a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b4d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b50:	89 55 10             	mov    %edx,0x10(%ebp)
  800b53:	85 c0                	test   %eax,%eax
  800b55:	75 dd                	jne    800b34 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b57:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b5a:	c9                   	leave  
  800b5b:	c3                   	ret    

00800b5c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b5c:	55                   	push   %ebp
  800b5d:	89 e5                	mov    %esp,%ebp
  800b5f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b65:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b68:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b6e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b71:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b74:	73 50                	jae    800bc6 <memmove+0x6a>
  800b76:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b79:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7c:	01 d0                	add    %edx,%eax
  800b7e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b81:	76 43                	jbe    800bc6 <memmove+0x6a>
		s += n;
  800b83:	8b 45 10             	mov    0x10(%ebp),%eax
  800b86:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b89:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8c:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b8f:	eb 10                	jmp    800ba1 <memmove+0x45>
			*--d = *--s;
  800b91:	ff 4d f8             	decl   -0x8(%ebp)
  800b94:	ff 4d fc             	decl   -0x4(%ebp)
  800b97:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b9a:	8a 10                	mov    (%eax),%dl
  800b9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b9f:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800ba1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ba7:	89 55 10             	mov    %edx,0x10(%ebp)
  800baa:	85 c0                	test   %eax,%eax
  800bac:	75 e3                	jne    800b91 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bae:	eb 23                	jmp    800bd3 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bb0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bb3:	8d 50 01             	lea    0x1(%eax),%edx
  800bb6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bb9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bbc:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bbf:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bc2:	8a 12                	mov    (%edx),%dl
  800bc4:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bc6:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bcc:	89 55 10             	mov    %edx,0x10(%ebp)
  800bcf:	85 c0                	test   %eax,%eax
  800bd1:	75 dd                	jne    800bb0 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bd3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bd6:	c9                   	leave  
  800bd7:	c3                   	ret    

00800bd8 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800bd8:	55                   	push   %ebp
  800bd9:	89 e5                	mov    %esp,%ebp
  800bdb:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bde:	8b 45 08             	mov    0x8(%ebp),%eax
  800be1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800be4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be7:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bea:	eb 2a                	jmp    800c16 <memcmp+0x3e>
		if (*s1 != *s2)
  800bec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bef:	8a 10                	mov    (%eax),%dl
  800bf1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bf4:	8a 00                	mov    (%eax),%al
  800bf6:	38 c2                	cmp    %al,%dl
  800bf8:	74 16                	je     800c10 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bfa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bfd:	8a 00                	mov    (%eax),%al
  800bff:	0f b6 d0             	movzbl %al,%edx
  800c02:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c05:	8a 00                	mov    (%eax),%al
  800c07:	0f b6 c0             	movzbl %al,%eax
  800c0a:	29 c2                	sub    %eax,%edx
  800c0c:	89 d0                	mov    %edx,%eax
  800c0e:	eb 18                	jmp    800c28 <memcmp+0x50>
		s1++, s2++;
  800c10:	ff 45 fc             	incl   -0x4(%ebp)
  800c13:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c16:	8b 45 10             	mov    0x10(%ebp),%eax
  800c19:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c1c:	89 55 10             	mov    %edx,0x10(%ebp)
  800c1f:	85 c0                	test   %eax,%eax
  800c21:	75 c9                	jne    800bec <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c23:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c28:	c9                   	leave  
  800c29:	c3                   	ret    

00800c2a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c2a:	55                   	push   %ebp
  800c2b:	89 e5                	mov    %esp,%ebp
  800c2d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c30:	8b 55 08             	mov    0x8(%ebp),%edx
  800c33:	8b 45 10             	mov    0x10(%ebp),%eax
  800c36:	01 d0                	add    %edx,%eax
  800c38:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c3b:	eb 15                	jmp    800c52 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c40:	8a 00                	mov    (%eax),%al
  800c42:	0f b6 d0             	movzbl %al,%edx
  800c45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c48:	0f b6 c0             	movzbl %al,%eax
  800c4b:	39 c2                	cmp    %eax,%edx
  800c4d:	74 0d                	je     800c5c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c4f:	ff 45 08             	incl   0x8(%ebp)
  800c52:	8b 45 08             	mov    0x8(%ebp),%eax
  800c55:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c58:	72 e3                	jb     800c3d <memfind+0x13>
  800c5a:	eb 01                	jmp    800c5d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c5c:	90                   	nop
	return (void *) s;
  800c5d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c60:	c9                   	leave  
  800c61:	c3                   	ret    

00800c62 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c62:	55                   	push   %ebp
  800c63:	89 e5                	mov    %esp,%ebp
  800c65:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c68:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c6f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c76:	eb 03                	jmp    800c7b <strtol+0x19>
		s++;
  800c78:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7e:	8a 00                	mov    (%eax),%al
  800c80:	3c 20                	cmp    $0x20,%al
  800c82:	74 f4                	je     800c78 <strtol+0x16>
  800c84:	8b 45 08             	mov    0x8(%ebp),%eax
  800c87:	8a 00                	mov    (%eax),%al
  800c89:	3c 09                	cmp    $0x9,%al
  800c8b:	74 eb                	je     800c78 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c90:	8a 00                	mov    (%eax),%al
  800c92:	3c 2b                	cmp    $0x2b,%al
  800c94:	75 05                	jne    800c9b <strtol+0x39>
		s++;
  800c96:	ff 45 08             	incl   0x8(%ebp)
  800c99:	eb 13                	jmp    800cae <strtol+0x4c>
	else if (*s == '-')
  800c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9e:	8a 00                	mov    (%eax),%al
  800ca0:	3c 2d                	cmp    $0x2d,%al
  800ca2:	75 0a                	jne    800cae <strtol+0x4c>
		s++, neg = 1;
  800ca4:	ff 45 08             	incl   0x8(%ebp)
  800ca7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cb2:	74 06                	je     800cba <strtol+0x58>
  800cb4:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cb8:	75 20                	jne    800cda <strtol+0x78>
  800cba:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbd:	8a 00                	mov    (%eax),%al
  800cbf:	3c 30                	cmp    $0x30,%al
  800cc1:	75 17                	jne    800cda <strtol+0x78>
  800cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc6:	40                   	inc    %eax
  800cc7:	8a 00                	mov    (%eax),%al
  800cc9:	3c 78                	cmp    $0x78,%al
  800ccb:	75 0d                	jne    800cda <strtol+0x78>
		s += 2, base = 16;
  800ccd:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cd1:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800cd8:	eb 28                	jmp    800d02 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800cda:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cde:	75 15                	jne    800cf5 <strtol+0x93>
  800ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce3:	8a 00                	mov    (%eax),%al
  800ce5:	3c 30                	cmp    $0x30,%al
  800ce7:	75 0c                	jne    800cf5 <strtol+0x93>
		s++, base = 8;
  800ce9:	ff 45 08             	incl   0x8(%ebp)
  800cec:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cf3:	eb 0d                	jmp    800d02 <strtol+0xa0>
	else if (base == 0)
  800cf5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cf9:	75 07                	jne    800d02 <strtol+0xa0>
		base = 10;
  800cfb:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d02:	8b 45 08             	mov    0x8(%ebp),%eax
  800d05:	8a 00                	mov    (%eax),%al
  800d07:	3c 2f                	cmp    $0x2f,%al
  800d09:	7e 19                	jle    800d24 <strtol+0xc2>
  800d0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0e:	8a 00                	mov    (%eax),%al
  800d10:	3c 39                	cmp    $0x39,%al
  800d12:	7f 10                	jg     800d24 <strtol+0xc2>
			dig = *s - '0';
  800d14:	8b 45 08             	mov    0x8(%ebp),%eax
  800d17:	8a 00                	mov    (%eax),%al
  800d19:	0f be c0             	movsbl %al,%eax
  800d1c:	83 e8 30             	sub    $0x30,%eax
  800d1f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d22:	eb 42                	jmp    800d66 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d24:	8b 45 08             	mov    0x8(%ebp),%eax
  800d27:	8a 00                	mov    (%eax),%al
  800d29:	3c 60                	cmp    $0x60,%al
  800d2b:	7e 19                	jle    800d46 <strtol+0xe4>
  800d2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d30:	8a 00                	mov    (%eax),%al
  800d32:	3c 7a                	cmp    $0x7a,%al
  800d34:	7f 10                	jg     800d46 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d36:	8b 45 08             	mov    0x8(%ebp),%eax
  800d39:	8a 00                	mov    (%eax),%al
  800d3b:	0f be c0             	movsbl %al,%eax
  800d3e:	83 e8 57             	sub    $0x57,%eax
  800d41:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d44:	eb 20                	jmp    800d66 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d46:	8b 45 08             	mov    0x8(%ebp),%eax
  800d49:	8a 00                	mov    (%eax),%al
  800d4b:	3c 40                	cmp    $0x40,%al
  800d4d:	7e 39                	jle    800d88 <strtol+0x126>
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	8a 00                	mov    (%eax),%al
  800d54:	3c 5a                	cmp    $0x5a,%al
  800d56:	7f 30                	jg     800d88 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d58:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5b:	8a 00                	mov    (%eax),%al
  800d5d:	0f be c0             	movsbl %al,%eax
  800d60:	83 e8 37             	sub    $0x37,%eax
  800d63:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d66:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d69:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d6c:	7d 19                	jge    800d87 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d6e:	ff 45 08             	incl   0x8(%ebp)
  800d71:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d74:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d78:	89 c2                	mov    %eax,%edx
  800d7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d7d:	01 d0                	add    %edx,%eax
  800d7f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d82:	e9 7b ff ff ff       	jmp    800d02 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d87:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d88:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d8c:	74 08                	je     800d96 <strtol+0x134>
		*endptr = (char *) s;
  800d8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d91:	8b 55 08             	mov    0x8(%ebp),%edx
  800d94:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d96:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d9a:	74 07                	je     800da3 <strtol+0x141>
  800d9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d9f:	f7 d8                	neg    %eax
  800da1:	eb 03                	jmp    800da6 <strtol+0x144>
  800da3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800da6:	c9                   	leave  
  800da7:	c3                   	ret    

00800da8 <ltostr>:

void
ltostr(long value, char *str)
{
  800da8:	55                   	push   %ebp
  800da9:	89 e5                	mov    %esp,%ebp
  800dab:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800dae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800db5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800dbc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dc0:	79 13                	jns    800dd5 <ltostr+0x2d>
	{
		neg = 1;
  800dc2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800dc9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dcc:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800dcf:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800dd2:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800dd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800ddd:	99                   	cltd   
  800dde:	f7 f9                	idiv   %ecx
  800de0:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800de3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de6:	8d 50 01             	lea    0x1(%eax),%edx
  800de9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dec:	89 c2                	mov    %eax,%edx
  800dee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df1:	01 d0                	add    %edx,%eax
  800df3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800df6:	83 c2 30             	add    $0x30,%edx
  800df9:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800dfb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dfe:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e03:	f7 e9                	imul   %ecx
  800e05:	c1 fa 02             	sar    $0x2,%edx
  800e08:	89 c8                	mov    %ecx,%eax
  800e0a:	c1 f8 1f             	sar    $0x1f,%eax
  800e0d:	29 c2                	sub    %eax,%edx
  800e0f:	89 d0                	mov    %edx,%eax
  800e11:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e14:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e17:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e1c:	f7 e9                	imul   %ecx
  800e1e:	c1 fa 02             	sar    $0x2,%edx
  800e21:	89 c8                	mov    %ecx,%eax
  800e23:	c1 f8 1f             	sar    $0x1f,%eax
  800e26:	29 c2                	sub    %eax,%edx
  800e28:	89 d0                	mov    %edx,%eax
  800e2a:	c1 e0 02             	shl    $0x2,%eax
  800e2d:	01 d0                	add    %edx,%eax
  800e2f:	01 c0                	add    %eax,%eax
  800e31:	29 c1                	sub    %eax,%ecx
  800e33:	89 ca                	mov    %ecx,%edx
  800e35:	85 d2                	test   %edx,%edx
  800e37:	75 9c                	jne    800dd5 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e39:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e40:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e43:	48                   	dec    %eax
  800e44:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e47:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e4b:	74 3d                	je     800e8a <ltostr+0xe2>
		start = 1 ;
  800e4d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e54:	eb 34                	jmp    800e8a <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e56:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5c:	01 d0                	add    %edx,%eax
  800e5e:	8a 00                	mov    (%eax),%al
  800e60:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e63:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e69:	01 c2                	add    %eax,%edx
  800e6b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e71:	01 c8                	add    %ecx,%eax
  800e73:	8a 00                	mov    (%eax),%al
  800e75:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e77:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7d:	01 c2                	add    %eax,%edx
  800e7f:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e82:	88 02                	mov    %al,(%edx)
		start++ ;
  800e84:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e87:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e8d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e90:	7c c4                	jl     800e56 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e92:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e98:	01 d0                	add    %edx,%eax
  800e9a:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e9d:	90                   	nop
  800e9e:	c9                   	leave  
  800e9f:	c3                   	ret    

00800ea0 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800ea0:	55                   	push   %ebp
  800ea1:	89 e5                	mov    %esp,%ebp
  800ea3:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ea6:	ff 75 08             	pushl  0x8(%ebp)
  800ea9:	e8 54 fa ff ff       	call   800902 <strlen>
  800eae:	83 c4 04             	add    $0x4,%esp
  800eb1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800eb4:	ff 75 0c             	pushl  0xc(%ebp)
  800eb7:	e8 46 fa ff ff       	call   800902 <strlen>
  800ebc:	83 c4 04             	add    $0x4,%esp
  800ebf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ec2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ec9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ed0:	eb 17                	jmp    800ee9 <strcconcat+0x49>
		final[s] = str1[s] ;
  800ed2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ed5:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed8:	01 c2                	add    %eax,%edx
  800eda:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800edd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee0:	01 c8                	add    %ecx,%eax
  800ee2:	8a 00                	mov    (%eax),%al
  800ee4:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800ee6:	ff 45 fc             	incl   -0x4(%ebp)
  800ee9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eec:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800eef:	7c e1                	jl     800ed2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800ef1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800ef8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800eff:	eb 1f                	jmp    800f20 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f01:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f04:	8d 50 01             	lea    0x1(%eax),%edx
  800f07:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f0a:	89 c2                	mov    %eax,%edx
  800f0c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f0f:	01 c2                	add    %eax,%edx
  800f11:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f17:	01 c8                	add    %ecx,%eax
  800f19:	8a 00                	mov    (%eax),%al
  800f1b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f1d:	ff 45 f8             	incl   -0x8(%ebp)
  800f20:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f23:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f26:	7c d9                	jl     800f01 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f28:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2e:	01 d0                	add    %edx,%eax
  800f30:	c6 00 00             	movb   $0x0,(%eax)
}
  800f33:	90                   	nop
  800f34:	c9                   	leave  
  800f35:	c3                   	ret    

00800f36 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f36:	55                   	push   %ebp
  800f37:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f39:	8b 45 14             	mov    0x14(%ebp),%eax
  800f3c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f42:	8b 45 14             	mov    0x14(%ebp),%eax
  800f45:	8b 00                	mov    (%eax),%eax
  800f47:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f4e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f51:	01 d0                	add    %edx,%eax
  800f53:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f59:	eb 0c                	jmp    800f67 <strsplit+0x31>
			*string++ = 0;
  800f5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5e:	8d 50 01             	lea    0x1(%eax),%edx
  800f61:	89 55 08             	mov    %edx,0x8(%ebp)
  800f64:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f67:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6a:	8a 00                	mov    (%eax),%al
  800f6c:	84 c0                	test   %al,%al
  800f6e:	74 18                	je     800f88 <strsplit+0x52>
  800f70:	8b 45 08             	mov    0x8(%ebp),%eax
  800f73:	8a 00                	mov    (%eax),%al
  800f75:	0f be c0             	movsbl %al,%eax
  800f78:	50                   	push   %eax
  800f79:	ff 75 0c             	pushl  0xc(%ebp)
  800f7c:	e8 13 fb ff ff       	call   800a94 <strchr>
  800f81:	83 c4 08             	add    $0x8,%esp
  800f84:	85 c0                	test   %eax,%eax
  800f86:	75 d3                	jne    800f5b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800f88:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8b:	8a 00                	mov    (%eax),%al
  800f8d:	84 c0                	test   %al,%al
  800f8f:	74 5a                	je     800feb <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800f91:	8b 45 14             	mov    0x14(%ebp),%eax
  800f94:	8b 00                	mov    (%eax),%eax
  800f96:	83 f8 0f             	cmp    $0xf,%eax
  800f99:	75 07                	jne    800fa2 <strsplit+0x6c>
		{
			return 0;
  800f9b:	b8 00 00 00 00       	mov    $0x0,%eax
  800fa0:	eb 66                	jmp    801008 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fa2:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa5:	8b 00                	mov    (%eax),%eax
  800fa7:	8d 48 01             	lea    0x1(%eax),%ecx
  800faa:	8b 55 14             	mov    0x14(%ebp),%edx
  800fad:	89 0a                	mov    %ecx,(%edx)
  800faf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fb6:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb9:	01 c2                	add    %eax,%edx
  800fbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbe:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fc0:	eb 03                	jmp    800fc5 <strsplit+0x8f>
			string++;
  800fc2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc8:	8a 00                	mov    (%eax),%al
  800fca:	84 c0                	test   %al,%al
  800fcc:	74 8b                	je     800f59 <strsplit+0x23>
  800fce:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd1:	8a 00                	mov    (%eax),%al
  800fd3:	0f be c0             	movsbl %al,%eax
  800fd6:	50                   	push   %eax
  800fd7:	ff 75 0c             	pushl  0xc(%ebp)
  800fda:	e8 b5 fa ff ff       	call   800a94 <strchr>
  800fdf:	83 c4 08             	add    $0x8,%esp
  800fe2:	85 c0                	test   %eax,%eax
  800fe4:	74 dc                	je     800fc2 <strsplit+0x8c>
			string++;
	}
  800fe6:	e9 6e ff ff ff       	jmp    800f59 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800feb:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fec:	8b 45 14             	mov    0x14(%ebp),%eax
  800fef:	8b 00                	mov    (%eax),%eax
  800ff1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ff8:	8b 45 10             	mov    0x10(%ebp),%eax
  800ffb:	01 d0                	add    %edx,%eax
  800ffd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801003:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801008:	c9                   	leave  
  801009:	c3                   	ret    

0080100a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80100a:	55                   	push   %ebp
  80100b:	89 e5                	mov    %esp,%ebp
  80100d:	57                   	push   %edi
  80100e:	56                   	push   %esi
  80100f:	53                   	push   %ebx
  801010:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801013:	8b 45 08             	mov    0x8(%ebp),%eax
  801016:	8b 55 0c             	mov    0xc(%ebp),%edx
  801019:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80101c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80101f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801022:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801025:	cd 30                	int    $0x30
  801027:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80102a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80102d:	83 c4 10             	add    $0x10,%esp
  801030:	5b                   	pop    %ebx
  801031:	5e                   	pop    %esi
  801032:	5f                   	pop    %edi
  801033:	5d                   	pop    %ebp
  801034:	c3                   	ret    

00801035 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801035:	55                   	push   %ebp
  801036:	89 e5                	mov    %esp,%ebp
  801038:	83 ec 04             	sub    $0x4,%esp
  80103b:	8b 45 10             	mov    0x10(%ebp),%eax
  80103e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801041:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801045:	8b 45 08             	mov    0x8(%ebp),%eax
  801048:	6a 00                	push   $0x0
  80104a:	6a 00                	push   $0x0
  80104c:	52                   	push   %edx
  80104d:	ff 75 0c             	pushl  0xc(%ebp)
  801050:	50                   	push   %eax
  801051:	6a 00                	push   $0x0
  801053:	e8 b2 ff ff ff       	call   80100a <syscall>
  801058:	83 c4 18             	add    $0x18,%esp
}
  80105b:	90                   	nop
  80105c:	c9                   	leave  
  80105d:	c3                   	ret    

0080105e <sys_cgetc>:

int
sys_cgetc(void)
{
  80105e:	55                   	push   %ebp
  80105f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801061:	6a 00                	push   $0x0
  801063:	6a 00                	push   $0x0
  801065:	6a 00                	push   $0x0
  801067:	6a 00                	push   $0x0
  801069:	6a 00                	push   $0x0
  80106b:	6a 01                	push   $0x1
  80106d:	e8 98 ff ff ff       	call   80100a <syscall>
  801072:	83 c4 18             	add    $0x18,%esp
}
  801075:	c9                   	leave  
  801076:	c3                   	ret    

00801077 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801077:	55                   	push   %ebp
  801078:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80107a:	8b 45 08             	mov    0x8(%ebp),%eax
  80107d:	6a 00                	push   $0x0
  80107f:	6a 00                	push   $0x0
  801081:	6a 00                	push   $0x0
  801083:	6a 00                	push   $0x0
  801085:	50                   	push   %eax
  801086:	6a 05                	push   $0x5
  801088:	e8 7d ff ff ff       	call   80100a <syscall>
  80108d:	83 c4 18             	add    $0x18,%esp
}
  801090:	c9                   	leave  
  801091:	c3                   	ret    

00801092 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801092:	55                   	push   %ebp
  801093:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801095:	6a 00                	push   $0x0
  801097:	6a 00                	push   $0x0
  801099:	6a 00                	push   $0x0
  80109b:	6a 00                	push   $0x0
  80109d:	6a 00                	push   $0x0
  80109f:	6a 02                	push   $0x2
  8010a1:	e8 64 ff ff ff       	call   80100a <syscall>
  8010a6:	83 c4 18             	add    $0x18,%esp
}
  8010a9:	c9                   	leave  
  8010aa:	c3                   	ret    

008010ab <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010ab:	55                   	push   %ebp
  8010ac:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010ae:	6a 00                	push   $0x0
  8010b0:	6a 00                	push   $0x0
  8010b2:	6a 00                	push   $0x0
  8010b4:	6a 00                	push   $0x0
  8010b6:	6a 00                	push   $0x0
  8010b8:	6a 03                	push   $0x3
  8010ba:	e8 4b ff ff ff       	call   80100a <syscall>
  8010bf:	83 c4 18             	add    $0x18,%esp
}
  8010c2:	c9                   	leave  
  8010c3:	c3                   	ret    

008010c4 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010c4:	55                   	push   %ebp
  8010c5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010c7:	6a 00                	push   $0x0
  8010c9:	6a 00                	push   $0x0
  8010cb:	6a 00                	push   $0x0
  8010cd:	6a 00                	push   $0x0
  8010cf:	6a 00                	push   $0x0
  8010d1:	6a 04                	push   $0x4
  8010d3:	e8 32 ff ff ff       	call   80100a <syscall>
  8010d8:	83 c4 18             	add    $0x18,%esp
}
  8010db:	c9                   	leave  
  8010dc:	c3                   	ret    

008010dd <sys_env_exit>:


void sys_env_exit(void)
{
  8010dd:	55                   	push   %ebp
  8010de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010e0:	6a 00                	push   $0x0
  8010e2:	6a 00                	push   $0x0
  8010e4:	6a 00                	push   $0x0
  8010e6:	6a 00                	push   $0x0
  8010e8:	6a 00                	push   $0x0
  8010ea:	6a 06                	push   $0x6
  8010ec:	e8 19 ff ff ff       	call   80100a <syscall>
  8010f1:	83 c4 18             	add    $0x18,%esp
}
  8010f4:	90                   	nop
  8010f5:	c9                   	leave  
  8010f6:	c3                   	ret    

008010f7 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010f7:	55                   	push   %ebp
  8010f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801100:	6a 00                	push   $0x0
  801102:	6a 00                	push   $0x0
  801104:	6a 00                	push   $0x0
  801106:	52                   	push   %edx
  801107:	50                   	push   %eax
  801108:	6a 07                	push   $0x7
  80110a:	e8 fb fe ff ff       	call   80100a <syscall>
  80110f:	83 c4 18             	add    $0x18,%esp
}
  801112:	c9                   	leave  
  801113:	c3                   	ret    

00801114 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801114:	55                   	push   %ebp
  801115:	89 e5                	mov    %esp,%ebp
  801117:	56                   	push   %esi
  801118:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801119:	8b 75 18             	mov    0x18(%ebp),%esi
  80111c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80111f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801122:	8b 55 0c             	mov    0xc(%ebp),%edx
  801125:	8b 45 08             	mov    0x8(%ebp),%eax
  801128:	56                   	push   %esi
  801129:	53                   	push   %ebx
  80112a:	51                   	push   %ecx
  80112b:	52                   	push   %edx
  80112c:	50                   	push   %eax
  80112d:	6a 08                	push   $0x8
  80112f:	e8 d6 fe ff ff       	call   80100a <syscall>
  801134:	83 c4 18             	add    $0x18,%esp
}
  801137:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80113a:	5b                   	pop    %ebx
  80113b:	5e                   	pop    %esi
  80113c:	5d                   	pop    %ebp
  80113d:	c3                   	ret    

0080113e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80113e:	55                   	push   %ebp
  80113f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801141:	8b 55 0c             	mov    0xc(%ebp),%edx
  801144:	8b 45 08             	mov    0x8(%ebp),%eax
  801147:	6a 00                	push   $0x0
  801149:	6a 00                	push   $0x0
  80114b:	6a 00                	push   $0x0
  80114d:	52                   	push   %edx
  80114e:	50                   	push   %eax
  80114f:	6a 09                	push   $0x9
  801151:	e8 b4 fe ff ff       	call   80100a <syscall>
  801156:	83 c4 18             	add    $0x18,%esp
}
  801159:	c9                   	leave  
  80115a:	c3                   	ret    

0080115b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80115b:	55                   	push   %ebp
  80115c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80115e:	6a 00                	push   $0x0
  801160:	6a 00                	push   $0x0
  801162:	6a 00                	push   $0x0
  801164:	ff 75 0c             	pushl  0xc(%ebp)
  801167:	ff 75 08             	pushl  0x8(%ebp)
  80116a:	6a 0a                	push   $0xa
  80116c:	e8 99 fe ff ff       	call   80100a <syscall>
  801171:	83 c4 18             	add    $0x18,%esp
}
  801174:	c9                   	leave  
  801175:	c3                   	ret    

00801176 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801176:	55                   	push   %ebp
  801177:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801179:	6a 00                	push   $0x0
  80117b:	6a 00                	push   $0x0
  80117d:	6a 00                	push   $0x0
  80117f:	6a 00                	push   $0x0
  801181:	6a 00                	push   $0x0
  801183:	6a 0b                	push   $0xb
  801185:	e8 80 fe ff ff       	call   80100a <syscall>
  80118a:	83 c4 18             	add    $0x18,%esp
}
  80118d:	c9                   	leave  
  80118e:	c3                   	ret    

0080118f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80118f:	55                   	push   %ebp
  801190:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801192:	6a 00                	push   $0x0
  801194:	6a 00                	push   $0x0
  801196:	6a 00                	push   $0x0
  801198:	6a 00                	push   $0x0
  80119a:	6a 00                	push   $0x0
  80119c:	6a 0c                	push   $0xc
  80119e:	e8 67 fe ff ff       	call   80100a <syscall>
  8011a3:	83 c4 18             	add    $0x18,%esp
}
  8011a6:	c9                   	leave  
  8011a7:	c3                   	ret    

008011a8 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011a8:	55                   	push   %ebp
  8011a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011ab:	6a 00                	push   $0x0
  8011ad:	6a 00                	push   $0x0
  8011af:	6a 00                	push   $0x0
  8011b1:	6a 00                	push   $0x0
  8011b3:	6a 00                	push   $0x0
  8011b5:	6a 0d                	push   $0xd
  8011b7:	e8 4e fe ff ff       	call   80100a <syscall>
  8011bc:	83 c4 18             	add    $0x18,%esp
}
  8011bf:	c9                   	leave  
  8011c0:	c3                   	ret    

008011c1 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011c1:	55                   	push   %ebp
  8011c2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011c4:	6a 00                	push   $0x0
  8011c6:	6a 00                	push   $0x0
  8011c8:	6a 00                	push   $0x0
  8011ca:	ff 75 0c             	pushl  0xc(%ebp)
  8011cd:	ff 75 08             	pushl  0x8(%ebp)
  8011d0:	6a 11                	push   $0x11
  8011d2:	e8 33 fe ff ff       	call   80100a <syscall>
  8011d7:	83 c4 18             	add    $0x18,%esp
	return;
  8011da:	90                   	nop
}
  8011db:	c9                   	leave  
  8011dc:	c3                   	ret    

008011dd <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011dd:	55                   	push   %ebp
  8011de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011e0:	6a 00                	push   $0x0
  8011e2:	6a 00                	push   $0x0
  8011e4:	6a 00                	push   $0x0
  8011e6:	ff 75 0c             	pushl  0xc(%ebp)
  8011e9:	ff 75 08             	pushl  0x8(%ebp)
  8011ec:	6a 12                	push   $0x12
  8011ee:	e8 17 fe ff ff       	call   80100a <syscall>
  8011f3:	83 c4 18             	add    $0x18,%esp
	return ;
  8011f6:	90                   	nop
}
  8011f7:	c9                   	leave  
  8011f8:	c3                   	ret    

008011f9 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011f9:	55                   	push   %ebp
  8011fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011fc:	6a 00                	push   $0x0
  8011fe:	6a 00                	push   $0x0
  801200:	6a 00                	push   $0x0
  801202:	6a 00                	push   $0x0
  801204:	6a 00                	push   $0x0
  801206:	6a 0e                	push   $0xe
  801208:	e8 fd fd ff ff       	call   80100a <syscall>
  80120d:	83 c4 18             	add    $0x18,%esp
}
  801210:	c9                   	leave  
  801211:	c3                   	ret    

00801212 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801212:	55                   	push   %ebp
  801213:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801215:	6a 00                	push   $0x0
  801217:	6a 00                	push   $0x0
  801219:	6a 00                	push   $0x0
  80121b:	6a 00                	push   $0x0
  80121d:	ff 75 08             	pushl  0x8(%ebp)
  801220:	6a 0f                	push   $0xf
  801222:	e8 e3 fd ff ff       	call   80100a <syscall>
  801227:	83 c4 18             	add    $0x18,%esp
}
  80122a:	c9                   	leave  
  80122b:	c3                   	ret    

0080122c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80122c:	55                   	push   %ebp
  80122d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80122f:	6a 00                	push   $0x0
  801231:	6a 00                	push   $0x0
  801233:	6a 00                	push   $0x0
  801235:	6a 00                	push   $0x0
  801237:	6a 00                	push   $0x0
  801239:	6a 10                	push   $0x10
  80123b:	e8 ca fd ff ff       	call   80100a <syscall>
  801240:	83 c4 18             	add    $0x18,%esp
}
  801243:	90                   	nop
  801244:	c9                   	leave  
  801245:	c3                   	ret    

00801246 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801246:	55                   	push   %ebp
  801247:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801249:	6a 00                	push   $0x0
  80124b:	6a 00                	push   $0x0
  80124d:	6a 00                	push   $0x0
  80124f:	6a 00                	push   $0x0
  801251:	6a 00                	push   $0x0
  801253:	6a 14                	push   $0x14
  801255:	e8 b0 fd ff ff       	call   80100a <syscall>
  80125a:	83 c4 18             	add    $0x18,%esp
}
  80125d:	90                   	nop
  80125e:	c9                   	leave  
  80125f:	c3                   	ret    

00801260 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801260:	55                   	push   %ebp
  801261:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801263:	6a 00                	push   $0x0
  801265:	6a 00                	push   $0x0
  801267:	6a 00                	push   $0x0
  801269:	6a 00                	push   $0x0
  80126b:	6a 00                	push   $0x0
  80126d:	6a 15                	push   $0x15
  80126f:	e8 96 fd ff ff       	call   80100a <syscall>
  801274:	83 c4 18             	add    $0x18,%esp
}
  801277:	90                   	nop
  801278:	c9                   	leave  
  801279:	c3                   	ret    

0080127a <sys_cputc>:


void
sys_cputc(const char c)
{
  80127a:	55                   	push   %ebp
  80127b:	89 e5                	mov    %esp,%ebp
  80127d:	83 ec 04             	sub    $0x4,%esp
  801280:	8b 45 08             	mov    0x8(%ebp),%eax
  801283:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801286:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80128a:	6a 00                	push   $0x0
  80128c:	6a 00                	push   $0x0
  80128e:	6a 00                	push   $0x0
  801290:	6a 00                	push   $0x0
  801292:	50                   	push   %eax
  801293:	6a 16                	push   $0x16
  801295:	e8 70 fd ff ff       	call   80100a <syscall>
  80129a:	83 c4 18             	add    $0x18,%esp
}
  80129d:	90                   	nop
  80129e:	c9                   	leave  
  80129f:	c3                   	ret    

008012a0 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012a0:	55                   	push   %ebp
  8012a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012a3:	6a 00                	push   $0x0
  8012a5:	6a 00                	push   $0x0
  8012a7:	6a 00                	push   $0x0
  8012a9:	6a 00                	push   $0x0
  8012ab:	6a 00                	push   $0x0
  8012ad:	6a 17                	push   $0x17
  8012af:	e8 56 fd ff ff       	call   80100a <syscall>
  8012b4:	83 c4 18             	add    $0x18,%esp
}
  8012b7:	90                   	nop
  8012b8:	c9                   	leave  
  8012b9:	c3                   	ret    

008012ba <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012ba:	55                   	push   %ebp
  8012bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c0:	6a 00                	push   $0x0
  8012c2:	6a 00                	push   $0x0
  8012c4:	6a 00                	push   $0x0
  8012c6:	ff 75 0c             	pushl  0xc(%ebp)
  8012c9:	50                   	push   %eax
  8012ca:	6a 18                	push   $0x18
  8012cc:	e8 39 fd ff ff       	call   80100a <syscall>
  8012d1:	83 c4 18             	add    $0x18,%esp
}
  8012d4:	c9                   	leave  
  8012d5:	c3                   	ret    

008012d6 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012d6:	55                   	push   %ebp
  8012d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012df:	6a 00                	push   $0x0
  8012e1:	6a 00                	push   $0x0
  8012e3:	6a 00                	push   $0x0
  8012e5:	52                   	push   %edx
  8012e6:	50                   	push   %eax
  8012e7:	6a 1b                	push   $0x1b
  8012e9:	e8 1c fd ff ff       	call   80100a <syscall>
  8012ee:	83 c4 18             	add    $0x18,%esp
}
  8012f1:	c9                   	leave  
  8012f2:	c3                   	ret    

008012f3 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012f3:	55                   	push   %ebp
  8012f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fc:	6a 00                	push   $0x0
  8012fe:	6a 00                	push   $0x0
  801300:	6a 00                	push   $0x0
  801302:	52                   	push   %edx
  801303:	50                   	push   %eax
  801304:	6a 19                	push   $0x19
  801306:	e8 ff fc ff ff       	call   80100a <syscall>
  80130b:	83 c4 18             	add    $0x18,%esp
}
  80130e:	90                   	nop
  80130f:	c9                   	leave  
  801310:	c3                   	ret    

00801311 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801311:	55                   	push   %ebp
  801312:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801314:	8b 55 0c             	mov    0xc(%ebp),%edx
  801317:	8b 45 08             	mov    0x8(%ebp),%eax
  80131a:	6a 00                	push   $0x0
  80131c:	6a 00                	push   $0x0
  80131e:	6a 00                	push   $0x0
  801320:	52                   	push   %edx
  801321:	50                   	push   %eax
  801322:	6a 1a                	push   $0x1a
  801324:	e8 e1 fc ff ff       	call   80100a <syscall>
  801329:	83 c4 18             	add    $0x18,%esp
}
  80132c:	90                   	nop
  80132d:	c9                   	leave  
  80132e:	c3                   	ret    

0080132f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80132f:	55                   	push   %ebp
  801330:	89 e5                	mov    %esp,%ebp
  801332:	83 ec 04             	sub    $0x4,%esp
  801335:	8b 45 10             	mov    0x10(%ebp),%eax
  801338:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80133b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80133e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801342:	8b 45 08             	mov    0x8(%ebp),%eax
  801345:	6a 00                	push   $0x0
  801347:	51                   	push   %ecx
  801348:	52                   	push   %edx
  801349:	ff 75 0c             	pushl  0xc(%ebp)
  80134c:	50                   	push   %eax
  80134d:	6a 1c                	push   $0x1c
  80134f:	e8 b6 fc ff ff       	call   80100a <syscall>
  801354:	83 c4 18             	add    $0x18,%esp
}
  801357:	c9                   	leave  
  801358:	c3                   	ret    

00801359 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801359:	55                   	push   %ebp
  80135a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80135c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80135f:	8b 45 08             	mov    0x8(%ebp),%eax
  801362:	6a 00                	push   $0x0
  801364:	6a 00                	push   $0x0
  801366:	6a 00                	push   $0x0
  801368:	52                   	push   %edx
  801369:	50                   	push   %eax
  80136a:	6a 1d                	push   $0x1d
  80136c:	e8 99 fc ff ff       	call   80100a <syscall>
  801371:	83 c4 18             	add    $0x18,%esp
}
  801374:	c9                   	leave  
  801375:	c3                   	ret    

00801376 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801376:	55                   	push   %ebp
  801377:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801379:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80137c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80137f:	8b 45 08             	mov    0x8(%ebp),%eax
  801382:	6a 00                	push   $0x0
  801384:	6a 00                	push   $0x0
  801386:	51                   	push   %ecx
  801387:	52                   	push   %edx
  801388:	50                   	push   %eax
  801389:	6a 1e                	push   $0x1e
  80138b:	e8 7a fc ff ff       	call   80100a <syscall>
  801390:	83 c4 18             	add    $0x18,%esp
}
  801393:	c9                   	leave  
  801394:	c3                   	ret    

00801395 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801395:	55                   	push   %ebp
  801396:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801398:	8b 55 0c             	mov    0xc(%ebp),%edx
  80139b:	8b 45 08             	mov    0x8(%ebp),%eax
  80139e:	6a 00                	push   $0x0
  8013a0:	6a 00                	push   $0x0
  8013a2:	6a 00                	push   $0x0
  8013a4:	52                   	push   %edx
  8013a5:	50                   	push   %eax
  8013a6:	6a 1f                	push   $0x1f
  8013a8:	e8 5d fc ff ff       	call   80100a <syscall>
  8013ad:	83 c4 18             	add    $0x18,%esp
}
  8013b0:	c9                   	leave  
  8013b1:	c3                   	ret    

008013b2 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013b2:	55                   	push   %ebp
  8013b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013b5:	6a 00                	push   $0x0
  8013b7:	6a 00                	push   $0x0
  8013b9:	6a 00                	push   $0x0
  8013bb:	6a 00                	push   $0x0
  8013bd:	6a 00                	push   $0x0
  8013bf:	6a 20                	push   $0x20
  8013c1:	e8 44 fc ff ff       	call   80100a <syscall>
  8013c6:	83 c4 18             	add    $0x18,%esp
}
  8013c9:	c9                   	leave  
  8013ca:	c3                   	ret    

008013cb <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8013cb:	55                   	push   %ebp
  8013cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8013ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d1:	6a 00                	push   $0x0
  8013d3:	ff 75 14             	pushl  0x14(%ebp)
  8013d6:	ff 75 10             	pushl  0x10(%ebp)
  8013d9:	ff 75 0c             	pushl  0xc(%ebp)
  8013dc:	50                   	push   %eax
  8013dd:	6a 21                	push   $0x21
  8013df:	e8 26 fc ff ff       	call   80100a <syscall>
  8013e4:	83 c4 18             	add    $0x18,%esp
}
  8013e7:	c9                   	leave  
  8013e8:	c3                   	ret    

008013e9 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8013e9:	55                   	push   %ebp
  8013ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ef:	6a 00                	push   $0x0
  8013f1:	6a 00                	push   $0x0
  8013f3:	6a 00                	push   $0x0
  8013f5:	6a 00                	push   $0x0
  8013f7:	50                   	push   %eax
  8013f8:	6a 22                	push   $0x22
  8013fa:	e8 0b fc ff ff       	call   80100a <syscall>
  8013ff:	83 c4 18             	add    $0x18,%esp
}
  801402:	90                   	nop
  801403:	c9                   	leave  
  801404:	c3                   	ret    

00801405 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801405:	55                   	push   %ebp
  801406:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801408:	8b 45 08             	mov    0x8(%ebp),%eax
  80140b:	6a 00                	push   $0x0
  80140d:	6a 00                	push   $0x0
  80140f:	6a 00                	push   $0x0
  801411:	6a 00                	push   $0x0
  801413:	50                   	push   %eax
  801414:	6a 23                	push   $0x23
  801416:	e8 ef fb ff ff       	call   80100a <syscall>
  80141b:	83 c4 18             	add    $0x18,%esp
}
  80141e:	90                   	nop
  80141f:	c9                   	leave  
  801420:	c3                   	ret    

00801421 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801421:	55                   	push   %ebp
  801422:	89 e5                	mov    %esp,%ebp
  801424:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801427:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80142a:	8d 50 04             	lea    0x4(%eax),%edx
  80142d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801430:	6a 00                	push   $0x0
  801432:	6a 00                	push   $0x0
  801434:	6a 00                	push   $0x0
  801436:	52                   	push   %edx
  801437:	50                   	push   %eax
  801438:	6a 24                	push   $0x24
  80143a:	e8 cb fb ff ff       	call   80100a <syscall>
  80143f:	83 c4 18             	add    $0x18,%esp
	return result;
  801442:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801445:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801448:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80144b:	89 01                	mov    %eax,(%ecx)
  80144d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801450:	8b 45 08             	mov    0x8(%ebp),%eax
  801453:	c9                   	leave  
  801454:	c2 04 00             	ret    $0x4

00801457 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801457:	55                   	push   %ebp
  801458:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	ff 75 10             	pushl  0x10(%ebp)
  801461:	ff 75 0c             	pushl  0xc(%ebp)
  801464:	ff 75 08             	pushl  0x8(%ebp)
  801467:	6a 13                	push   $0x13
  801469:	e8 9c fb ff ff       	call   80100a <syscall>
  80146e:	83 c4 18             	add    $0x18,%esp
	return ;
  801471:	90                   	nop
}
  801472:	c9                   	leave  
  801473:	c3                   	ret    

00801474 <sys_rcr2>:
uint32 sys_rcr2()
{
  801474:	55                   	push   %ebp
  801475:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801477:	6a 00                	push   $0x0
  801479:	6a 00                	push   $0x0
  80147b:	6a 00                	push   $0x0
  80147d:	6a 00                	push   $0x0
  80147f:	6a 00                	push   $0x0
  801481:	6a 25                	push   $0x25
  801483:	e8 82 fb ff ff       	call   80100a <syscall>
  801488:	83 c4 18             	add    $0x18,%esp
}
  80148b:	c9                   	leave  
  80148c:	c3                   	ret    

0080148d <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80148d:	55                   	push   %ebp
  80148e:	89 e5                	mov    %esp,%ebp
  801490:	83 ec 04             	sub    $0x4,%esp
  801493:	8b 45 08             	mov    0x8(%ebp),%eax
  801496:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801499:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80149d:	6a 00                	push   $0x0
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 00                	push   $0x0
  8014a3:	6a 00                	push   $0x0
  8014a5:	50                   	push   %eax
  8014a6:	6a 26                	push   $0x26
  8014a8:	e8 5d fb ff ff       	call   80100a <syscall>
  8014ad:	83 c4 18             	add    $0x18,%esp
	return ;
  8014b0:	90                   	nop
}
  8014b1:	c9                   	leave  
  8014b2:	c3                   	ret    

008014b3 <rsttst>:
void rsttst()
{
  8014b3:	55                   	push   %ebp
  8014b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 00                	push   $0x0
  8014ba:	6a 00                	push   $0x0
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 28                	push   $0x28
  8014c2:	e8 43 fb ff ff       	call   80100a <syscall>
  8014c7:	83 c4 18             	add    $0x18,%esp
	return ;
  8014ca:	90                   	nop
}
  8014cb:	c9                   	leave  
  8014cc:	c3                   	ret    

008014cd <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014cd:	55                   	push   %ebp
  8014ce:	89 e5                	mov    %esp,%ebp
  8014d0:	83 ec 04             	sub    $0x4,%esp
  8014d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8014d6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014d9:	8b 55 18             	mov    0x18(%ebp),%edx
  8014dc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014e0:	52                   	push   %edx
  8014e1:	50                   	push   %eax
  8014e2:	ff 75 10             	pushl  0x10(%ebp)
  8014e5:	ff 75 0c             	pushl  0xc(%ebp)
  8014e8:	ff 75 08             	pushl  0x8(%ebp)
  8014eb:	6a 27                	push   $0x27
  8014ed:	e8 18 fb ff ff       	call   80100a <syscall>
  8014f2:	83 c4 18             	add    $0x18,%esp
	return ;
  8014f5:	90                   	nop
}
  8014f6:	c9                   	leave  
  8014f7:	c3                   	ret    

008014f8 <chktst>:
void chktst(uint32 n)
{
  8014f8:	55                   	push   %ebp
  8014f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014fb:	6a 00                	push   $0x0
  8014fd:	6a 00                	push   $0x0
  8014ff:	6a 00                	push   $0x0
  801501:	6a 00                	push   $0x0
  801503:	ff 75 08             	pushl  0x8(%ebp)
  801506:	6a 29                	push   $0x29
  801508:	e8 fd fa ff ff       	call   80100a <syscall>
  80150d:	83 c4 18             	add    $0x18,%esp
	return ;
  801510:	90                   	nop
}
  801511:	c9                   	leave  
  801512:	c3                   	ret    

00801513 <inctst>:

void inctst()
{
  801513:	55                   	push   %ebp
  801514:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	6a 00                	push   $0x0
  80151c:	6a 00                	push   $0x0
  80151e:	6a 00                	push   $0x0
  801520:	6a 2a                	push   $0x2a
  801522:	e8 e3 fa ff ff       	call   80100a <syscall>
  801527:	83 c4 18             	add    $0x18,%esp
	return ;
  80152a:	90                   	nop
}
  80152b:	c9                   	leave  
  80152c:	c3                   	ret    

0080152d <gettst>:
uint32 gettst()
{
  80152d:	55                   	push   %ebp
  80152e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	6a 2b                	push   $0x2b
  80153c:	e8 c9 fa ff ff       	call   80100a <syscall>
  801541:	83 c4 18             	add    $0x18,%esp
}
  801544:	c9                   	leave  
  801545:	c3                   	ret    

00801546 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801546:	55                   	push   %ebp
  801547:	89 e5                	mov    %esp,%ebp
  801549:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	6a 00                	push   $0x0
  801556:	6a 2c                	push   $0x2c
  801558:	e8 ad fa ff ff       	call   80100a <syscall>
  80155d:	83 c4 18             	add    $0x18,%esp
  801560:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801563:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801567:	75 07                	jne    801570 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801569:	b8 01 00 00 00       	mov    $0x1,%eax
  80156e:	eb 05                	jmp    801575 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801570:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801575:	c9                   	leave  
  801576:	c3                   	ret    

00801577 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801577:	55                   	push   %ebp
  801578:	89 e5                	mov    %esp,%ebp
  80157a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80157d:	6a 00                	push   $0x0
  80157f:	6a 00                	push   $0x0
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	6a 00                	push   $0x0
  801587:	6a 2c                	push   $0x2c
  801589:	e8 7c fa ff ff       	call   80100a <syscall>
  80158e:	83 c4 18             	add    $0x18,%esp
  801591:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801594:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801598:	75 07                	jne    8015a1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80159a:	b8 01 00 00 00       	mov    $0x1,%eax
  80159f:	eb 05                	jmp    8015a6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015a6:	c9                   	leave  
  8015a7:	c3                   	ret    

008015a8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015a8:	55                   	push   %ebp
  8015a9:	89 e5                	mov    %esp,%ebp
  8015ab:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 2c                	push   $0x2c
  8015ba:	e8 4b fa ff ff       	call   80100a <syscall>
  8015bf:	83 c4 18             	add    $0x18,%esp
  8015c2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015c5:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015c9:	75 07                	jne    8015d2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015cb:	b8 01 00 00 00       	mov    $0x1,%eax
  8015d0:	eb 05                	jmp    8015d7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015d2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d7:	c9                   	leave  
  8015d8:	c3                   	ret    

008015d9 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015d9:	55                   	push   %ebp
  8015da:	89 e5                	mov    %esp,%ebp
  8015dc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 2c                	push   $0x2c
  8015eb:	e8 1a fa ff ff       	call   80100a <syscall>
  8015f0:	83 c4 18             	add    $0x18,%esp
  8015f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015f6:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015fa:	75 07                	jne    801603 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015fc:	b8 01 00 00 00       	mov    $0x1,%eax
  801601:	eb 05                	jmp    801608 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801603:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801608:	c9                   	leave  
  801609:	c3                   	ret    

0080160a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80160a:	55                   	push   %ebp
  80160b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	ff 75 08             	pushl  0x8(%ebp)
  801618:	6a 2d                	push   $0x2d
  80161a:	e8 eb f9 ff ff       	call   80100a <syscall>
  80161f:	83 c4 18             	add    $0x18,%esp
	return ;
  801622:	90                   	nop
}
  801623:	c9                   	leave  
  801624:	c3                   	ret    

00801625 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801625:	55                   	push   %ebp
  801626:	89 e5                	mov    %esp,%ebp
  801628:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801629:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80162c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80162f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801632:	8b 45 08             	mov    0x8(%ebp),%eax
  801635:	6a 00                	push   $0x0
  801637:	53                   	push   %ebx
  801638:	51                   	push   %ecx
  801639:	52                   	push   %edx
  80163a:	50                   	push   %eax
  80163b:	6a 2e                	push   $0x2e
  80163d:	e8 c8 f9 ff ff       	call   80100a <syscall>
  801642:	83 c4 18             	add    $0x18,%esp
}
  801645:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801648:	c9                   	leave  
  801649:	c3                   	ret    

0080164a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80164a:	55                   	push   %ebp
  80164b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80164d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801650:	8b 45 08             	mov    0x8(%ebp),%eax
  801653:	6a 00                	push   $0x0
  801655:	6a 00                	push   $0x0
  801657:	6a 00                	push   $0x0
  801659:	52                   	push   %edx
  80165a:	50                   	push   %eax
  80165b:	6a 2f                	push   $0x2f
  80165d:	e8 a8 f9 ff ff       	call   80100a <syscall>
  801662:	83 c4 18             	add    $0x18,%esp
}
  801665:	c9                   	leave  
  801666:	c3                   	ret    
  801667:	90                   	nop

00801668 <__udivdi3>:
  801668:	55                   	push   %ebp
  801669:	57                   	push   %edi
  80166a:	56                   	push   %esi
  80166b:	53                   	push   %ebx
  80166c:	83 ec 1c             	sub    $0x1c,%esp
  80166f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801673:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801677:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80167b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80167f:	89 ca                	mov    %ecx,%edx
  801681:	89 f8                	mov    %edi,%eax
  801683:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801687:	85 f6                	test   %esi,%esi
  801689:	75 2d                	jne    8016b8 <__udivdi3+0x50>
  80168b:	39 cf                	cmp    %ecx,%edi
  80168d:	77 65                	ja     8016f4 <__udivdi3+0x8c>
  80168f:	89 fd                	mov    %edi,%ebp
  801691:	85 ff                	test   %edi,%edi
  801693:	75 0b                	jne    8016a0 <__udivdi3+0x38>
  801695:	b8 01 00 00 00       	mov    $0x1,%eax
  80169a:	31 d2                	xor    %edx,%edx
  80169c:	f7 f7                	div    %edi
  80169e:	89 c5                	mov    %eax,%ebp
  8016a0:	31 d2                	xor    %edx,%edx
  8016a2:	89 c8                	mov    %ecx,%eax
  8016a4:	f7 f5                	div    %ebp
  8016a6:	89 c1                	mov    %eax,%ecx
  8016a8:	89 d8                	mov    %ebx,%eax
  8016aa:	f7 f5                	div    %ebp
  8016ac:	89 cf                	mov    %ecx,%edi
  8016ae:	89 fa                	mov    %edi,%edx
  8016b0:	83 c4 1c             	add    $0x1c,%esp
  8016b3:	5b                   	pop    %ebx
  8016b4:	5e                   	pop    %esi
  8016b5:	5f                   	pop    %edi
  8016b6:	5d                   	pop    %ebp
  8016b7:	c3                   	ret    
  8016b8:	39 ce                	cmp    %ecx,%esi
  8016ba:	77 28                	ja     8016e4 <__udivdi3+0x7c>
  8016bc:	0f bd fe             	bsr    %esi,%edi
  8016bf:	83 f7 1f             	xor    $0x1f,%edi
  8016c2:	75 40                	jne    801704 <__udivdi3+0x9c>
  8016c4:	39 ce                	cmp    %ecx,%esi
  8016c6:	72 0a                	jb     8016d2 <__udivdi3+0x6a>
  8016c8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8016cc:	0f 87 9e 00 00 00    	ja     801770 <__udivdi3+0x108>
  8016d2:	b8 01 00 00 00       	mov    $0x1,%eax
  8016d7:	89 fa                	mov    %edi,%edx
  8016d9:	83 c4 1c             	add    $0x1c,%esp
  8016dc:	5b                   	pop    %ebx
  8016dd:	5e                   	pop    %esi
  8016de:	5f                   	pop    %edi
  8016df:	5d                   	pop    %ebp
  8016e0:	c3                   	ret    
  8016e1:	8d 76 00             	lea    0x0(%esi),%esi
  8016e4:	31 ff                	xor    %edi,%edi
  8016e6:	31 c0                	xor    %eax,%eax
  8016e8:	89 fa                	mov    %edi,%edx
  8016ea:	83 c4 1c             	add    $0x1c,%esp
  8016ed:	5b                   	pop    %ebx
  8016ee:	5e                   	pop    %esi
  8016ef:	5f                   	pop    %edi
  8016f0:	5d                   	pop    %ebp
  8016f1:	c3                   	ret    
  8016f2:	66 90                	xchg   %ax,%ax
  8016f4:	89 d8                	mov    %ebx,%eax
  8016f6:	f7 f7                	div    %edi
  8016f8:	31 ff                	xor    %edi,%edi
  8016fa:	89 fa                	mov    %edi,%edx
  8016fc:	83 c4 1c             	add    $0x1c,%esp
  8016ff:	5b                   	pop    %ebx
  801700:	5e                   	pop    %esi
  801701:	5f                   	pop    %edi
  801702:	5d                   	pop    %ebp
  801703:	c3                   	ret    
  801704:	bd 20 00 00 00       	mov    $0x20,%ebp
  801709:	89 eb                	mov    %ebp,%ebx
  80170b:	29 fb                	sub    %edi,%ebx
  80170d:	89 f9                	mov    %edi,%ecx
  80170f:	d3 e6                	shl    %cl,%esi
  801711:	89 c5                	mov    %eax,%ebp
  801713:	88 d9                	mov    %bl,%cl
  801715:	d3 ed                	shr    %cl,%ebp
  801717:	89 e9                	mov    %ebp,%ecx
  801719:	09 f1                	or     %esi,%ecx
  80171b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80171f:	89 f9                	mov    %edi,%ecx
  801721:	d3 e0                	shl    %cl,%eax
  801723:	89 c5                	mov    %eax,%ebp
  801725:	89 d6                	mov    %edx,%esi
  801727:	88 d9                	mov    %bl,%cl
  801729:	d3 ee                	shr    %cl,%esi
  80172b:	89 f9                	mov    %edi,%ecx
  80172d:	d3 e2                	shl    %cl,%edx
  80172f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801733:	88 d9                	mov    %bl,%cl
  801735:	d3 e8                	shr    %cl,%eax
  801737:	09 c2                	or     %eax,%edx
  801739:	89 d0                	mov    %edx,%eax
  80173b:	89 f2                	mov    %esi,%edx
  80173d:	f7 74 24 0c          	divl   0xc(%esp)
  801741:	89 d6                	mov    %edx,%esi
  801743:	89 c3                	mov    %eax,%ebx
  801745:	f7 e5                	mul    %ebp
  801747:	39 d6                	cmp    %edx,%esi
  801749:	72 19                	jb     801764 <__udivdi3+0xfc>
  80174b:	74 0b                	je     801758 <__udivdi3+0xf0>
  80174d:	89 d8                	mov    %ebx,%eax
  80174f:	31 ff                	xor    %edi,%edi
  801751:	e9 58 ff ff ff       	jmp    8016ae <__udivdi3+0x46>
  801756:	66 90                	xchg   %ax,%ax
  801758:	8b 54 24 08          	mov    0x8(%esp),%edx
  80175c:	89 f9                	mov    %edi,%ecx
  80175e:	d3 e2                	shl    %cl,%edx
  801760:	39 c2                	cmp    %eax,%edx
  801762:	73 e9                	jae    80174d <__udivdi3+0xe5>
  801764:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801767:	31 ff                	xor    %edi,%edi
  801769:	e9 40 ff ff ff       	jmp    8016ae <__udivdi3+0x46>
  80176e:	66 90                	xchg   %ax,%ax
  801770:	31 c0                	xor    %eax,%eax
  801772:	e9 37 ff ff ff       	jmp    8016ae <__udivdi3+0x46>
  801777:	90                   	nop

00801778 <__umoddi3>:
  801778:	55                   	push   %ebp
  801779:	57                   	push   %edi
  80177a:	56                   	push   %esi
  80177b:	53                   	push   %ebx
  80177c:	83 ec 1c             	sub    $0x1c,%esp
  80177f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801783:	8b 74 24 34          	mov    0x34(%esp),%esi
  801787:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80178b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80178f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801793:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801797:	89 f3                	mov    %esi,%ebx
  801799:	89 fa                	mov    %edi,%edx
  80179b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80179f:	89 34 24             	mov    %esi,(%esp)
  8017a2:	85 c0                	test   %eax,%eax
  8017a4:	75 1a                	jne    8017c0 <__umoddi3+0x48>
  8017a6:	39 f7                	cmp    %esi,%edi
  8017a8:	0f 86 a2 00 00 00    	jbe    801850 <__umoddi3+0xd8>
  8017ae:	89 c8                	mov    %ecx,%eax
  8017b0:	89 f2                	mov    %esi,%edx
  8017b2:	f7 f7                	div    %edi
  8017b4:	89 d0                	mov    %edx,%eax
  8017b6:	31 d2                	xor    %edx,%edx
  8017b8:	83 c4 1c             	add    $0x1c,%esp
  8017bb:	5b                   	pop    %ebx
  8017bc:	5e                   	pop    %esi
  8017bd:	5f                   	pop    %edi
  8017be:	5d                   	pop    %ebp
  8017bf:	c3                   	ret    
  8017c0:	39 f0                	cmp    %esi,%eax
  8017c2:	0f 87 ac 00 00 00    	ja     801874 <__umoddi3+0xfc>
  8017c8:	0f bd e8             	bsr    %eax,%ebp
  8017cb:	83 f5 1f             	xor    $0x1f,%ebp
  8017ce:	0f 84 ac 00 00 00    	je     801880 <__umoddi3+0x108>
  8017d4:	bf 20 00 00 00       	mov    $0x20,%edi
  8017d9:	29 ef                	sub    %ebp,%edi
  8017db:	89 fe                	mov    %edi,%esi
  8017dd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8017e1:	89 e9                	mov    %ebp,%ecx
  8017e3:	d3 e0                	shl    %cl,%eax
  8017e5:	89 d7                	mov    %edx,%edi
  8017e7:	89 f1                	mov    %esi,%ecx
  8017e9:	d3 ef                	shr    %cl,%edi
  8017eb:	09 c7                	or     %eax,%edi
  8017ed:	89 e9                	mov    %ebp,%ecx
  8017ef:	d3 e2                	shl    %cl,%edx
  8017f1:	89 14 24             	mov    %edx,(%esp)
  8017f4:	89 d8                	mov    %ebx,%eax
  8017f6:	d3 e0                	shl    %cl,%eax
  8017f8:	89 c2                	mov    %eax,%edx
  8017fa:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017fe:	d3 e0                	shl    %cl,%eax
  801800:	89 44 24 04          	mov    %eax,0x4(%esp)
  801804:	8b 44 24 08          	mov    0x8(%esp),%eax
  801808:	89 f1                	mov    %esi,%ecx
  80180a:	d3 e8                	shr    %cl,%eax
  80180c:	09 d0                	or     %edx,%eax
  80180e:	d3 eb                	shr    %cl,%ebx
  801810:	89 da                	mov    %ebx,%edx
  801812:	f7 f7                	div    %edi
  801814:	89 d3                	mov    %edx,%ebx
  801816:	f7 24 24             	mull   (%esp)
  801819:	89 c6                	mov    %eax,%esi
  80181b:	89 d1                	mov    %edx,%ecx
  80181d:	39 d3                	cmp    %edx,%ebx
  80181f:	0f 82 87 00 00 00    	jb     8018ac <__umoddi3+0x134>
  801825:	0f 84 91 00 00 00    	je     8018bc <__umoddi3+0x144>
  80182b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80182f:	29 f2                	sub    %esi,%edx
  801831:	19 cb                	sbb    %ecx,%ebx
  801833:	89 d8                	mov    %ebx,%eax
  801835:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801839:	d3 e0                	shl    %cl,%eax
  80183b:	89 e9                	mov    %ebp,%ecx
  80183d:	d3 ea                	shr    %cl,%edx
  80183f:	09 d0                	or     %edx,%eax
  801841:	89 e9                	mov    %ebp,%ecx
  801843:	d3 eb                	shr    %cl,%ebx
  801845:	89 da                	mov    %ebx,%edx
  801847:	83 c4 1c             	add    $0x1c,%esp
  80184a:	5b                   	pop    %ebx
  80184b:	5e                   	pop    %esi
  80184c:	5f                   	pop    %edi
  80184d:	5d                   	pop    %ebp
  80184e:	c3                   	ret    
  80184f:	90                   	nop
  801850:	89 fd                	mov    %edi,%ebp
  801852:	85 ff                	test   %edi,%edi
  801854:	75 0b                	jne    801861 <__umoddi3+0xe9>
  801856:	b8 01 00 00 00       	mov    $0x1,%eax
  80185b:	31 d2                	xor    %edx,%edx
  80185d:	f7 f7                	div    %edi
  80185f:	89 c5                	mov    %eax,%ebp
  801861:	89 f0                	mov    %esi,%eax
  801863:	31 d2                	xor    %edx,%edx
  801865:	f7 f5                	div    %ebp
  801867:	89 c8                	mov    %ecx,%eax
  801869:	f7 f5                	div    %ebp
  80186b:	89 d0                	mov    %edx,%eax
  80186d:	e9 44 ff ff ff       	jmp    8017b6 <__umoddi3+0x3e>
  801872:	66 90                	xchg   %ax,%ax
  801874:	89 c8                	mov    %ecx,%eax
  801876:	89 f2                	mov    %esi,%edx
  801878:	83 c4 1c             	add    $0x1c,%esp
  80187b:	5b                   	pop    %ebx
  80187c:	5e                   	pop    %esi
  80187d:	5f                   	pop    %edi
  80187e:	5d                   	pop    %ebp
  80187f:	c3                   	ret    
  801880:	3b 04 24             	cmp    (%esp),%eax
  801883:	72 06                	jb     80188b <__umoddi3+0x113>
  801885:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801889:	77 0f                	ja     80189a <__umoddi3+0x122>
  80188b:	89 f2                	mov    %esi,%edx
  80188d:	29 f9                	sub    %edi,%ecx
  80188f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801893:	89 14 24             	mov    %edx,(%esp)
  801896:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80189a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80189e:	8b 14 24             	mov    (%esp),%edx
  8018a1:	83 c4 1c             	add    $0x1c,%esp
  8018a4:	5b                   	pop    %ebx
  8018a5:	5e                   	pop    %esi
  8018a6:	5f                   	pop    %edi
  8018a7:	5d                   	pop    %ebp
  8018a8:	c3                   	ret    
  8018a9:	8d 76 00             	lea    0x0(%esi),%esi
  8018ac:	2b 04 24             	sub    (%esp),%eax
  8018af:	19 fa                	sbb    %edi,%edx
  8018b1:	89 d1                	mov    %edx,%ecx
  8018b3:	89 c6                	mov    %eax,%esi
  8018b5:	e9 71 ff ff ff       	jmp    80182b <__umoddi3+0xb3>
  8018ba:	66 90                	xchg   %ax,%ax
  8018bc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8018c0:	72 ea                	jb     8018ac <__umoddi3+0x134>
  8018c2:	89 d9                	mov    %ebx,%ecx
  8018c4:	e9 62 ff ff ff       	jmp    80182b <__umoddi3+0xb3>
