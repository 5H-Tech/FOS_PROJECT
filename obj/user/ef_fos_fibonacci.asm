
obj/user/ef_fos_fibonacci:     file format elf32-i386


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
  800031:	e8 82 00 00 00       	call   8000b8 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int fibonacci(int n);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	char buff1[256];
	i1 = 20;
  800048:	c7 45 f4 14 00 00 00 	movl   $0x14,-0xc(%ebp)

	int res = fibonacci(i1) ;
  80004f:	83 ec 0c             	sub    $0xc,%esp
  800052:	ff 75 f4             	pushl  -0xc(%ebp)
  800055:	e8 1f 00 00 00       	call   800079 <fibonacci>
  80005a:	83 c4 10             	add    $0x10,%esp
  80005d:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("Fibonacci #%d = %d\n",i1, res);
  800060:	83 ec 04             	sub    $0x4,%esp
  800063:	ff 75 f0             	pushl  -0x10(%ebp)
  800066:	ff 75 f4             	pushl  -0xc(%ebp)
  800069:	68 20 19 80 00       	push   $0x801920
  80006e:	e8 8b 02 00 00       	call   8002fe <atomic_cprintf>
  800073:	83 c4 10             	add    $0x10,%esp

	return;
  800076:	90                   	nop
}
  800077:	c9                   	leave  
  800078:	c3                   	ret    

00800079 <fibonacci>:


int fibonacci(int n)
{
  800079:	55                   	push   %ebp
  80007a:	89 e5                	mov    %esp,%ebp
  80007c:	53                   	push   %ebx
  80007d:	83 ec 04             	sub    $0x4,%esp
	if (n <= 1)
  800080:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  800084:	7f 07                	jg     80008d <fibonacci+0x14>
		return 1 ;
  800086:	b8 01 00 00 00       	mov    $0x1,%eax
  80008b:	eb 26                	jmp    8000b3 <fibonacci+0x3a>
	return fibonacci(n-1) + fibonacci(n-2) ;
  80008d:	8b 45 08             	mov    0x8(%ebp),%eax
  800090:	48                   	dec    %eax
  800091:	83 ec 0c             	sub    $0xc,%esp
  800094:	50                   	push   %eax
  800095:	e8 df ff ff ff       	call   800079 <fibonacci>
  80009a:	83 c4 10             	add    $0x10,%esp
  80009d:	89 c3                	mov    %eax,%ebx
  80009f:	8b 45 08             	mov    0x8(%ebp),%eax
  8000a2:	83 e8 02             	sub    $0x2,%eax
  8000a5:	83 ec 0c             	sub    $0xc,%esp
  8000a8:	50                   	push   %eax
  8000a9:	e8 cb ff ff ff       	call   800079 <fibonacci>
  8000ae:	83 c4 10             	add    $0x10,%esp
  8000b1:	01 d8                	add    %ebx,%eax
}
  8000b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8000b6:	c9                   	leave  
  8000b7:	c3                   	ret    

008000b8 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000b8:	55                   	push   %ebp
  8000b9:	89 e5                	mov    %esp,%ebp
  8000bb:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000be:	e8 39 10 00 00       	call   8010fc <sys_getenvindex>
  8000c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000c6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000c9:	89 d0                	mov    %edx,%eax
  8000cb:	c1 e0 03             	shl    $0x3,%eax
  8000ce:	01 d0                	add    %edx,%eax
  8000d0:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8000d7:	01 c8                	add    %ecx,%eax
  8000d9:	01 c0                	add    %eax,%eax
  8000db:	01 d0                	add    %edx,%eax
  8000dd:	01 c0                	add    %eax,%eax
  8000df:	01 d0                	add    %edx,%eax
  8000e1:	89 c2                	mov    %eax,%edx
  8000e3:	c1 e2 05             	shl    $0x5,%edx
  8000e6:	29 c2                	sub    %eax,%edx
  8000e8:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8000ef:	89 c2                	mov    %eax,%edx
  8000f1:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8000f7:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000fc:	a1 20 20 80 00       	mov    0x802020,%eax
  800101:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800107:	84 c0                	test   %al,%al
  800109:	74 0f                	je     80011a <libmain+0x62>
		binaryname = myEnv->prog_name;
  80010b:	a1 20 20 80 00       	mov    0x802020,%eax
  800110:	05 40 3c 01 00       	add    $0x13c40,%eax
  800115:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80011a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80011e:	7e 0a                	jle    80012a <libmain+0x72>
		binaryname = argv[0];
  800120:	8b 45 0c             	mov    0xc(%ebp),%eax
  800123:	8b 00                	mov    (%eax),%eax
  800125:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  80012a:	83 ec 08             	sub    $0x8,%esp
  80012d:	ff 75 0c             	pushl  0xc(%ebp)
  800130:	ff 75 08             	pushl  0x8(%ebp)
  800133:	e8 00 ff ff ff       	call   800038 <_main>
  800138:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80013b:	e8 57 11 00 00       	call   801297 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800140:	83 ec 0c             	sub    $0xc,%esp
  800143:	68 4c 19 80 00       	push   $0x80194c
  800148:	e8 84 01 00 00       	call   8002d1 <cprintf>
  80014d:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800150:	a1 20 20 80 00       	mov    0x802020,%eax
  800155:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80015b:	a1 20 20 80 00       	mov    0x802020,%eax
  800160:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800166:	83 ec 04             	sub    $0x4,%esp
  800169:	52                   	push   %edx
  80016a:	50                   	push   %eax
  80016b:	68 74 19 80 00       	push   $0x801974
  800170:	e8 5c 01 00 00       	call   8002d1 <cprintf>
  800175:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800178:	a1 20 20 80 00       	mov    0x802020,%eax
  80017d:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800183:	a1 20 20 80 00       	mov    0x802020,%eax
  800188:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80018e:	83 ec 04             	sub    $0x4,%esp
  800191:	52                   	push   %edx
  800192:	50                   	push   %eax
  800193:	68 9c 19 80 00       	push   $0x80199c
  800198:	e8 34 01 00 00       	call   8002d1 <cprintf>
  80019d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001a0:	a1 20 20 80 00       	mov    0x802020,%eax
  8001a5:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8001ab:	83 ec 08             	sub    $0x8,%esp
  8001ae:	50                   	push   %eax
  8001af:	68 dd 19 80 00       	push   $0x8019dd
  8001b4:	e8 18 01 00 00       	call   8002d1 <cprintf>
  8001b9:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001bc:	83 ec 0c             	sub    $0xc,%esp
  8001bf:	68 4c 19 80 00       	push   $0x80194c
  8001c4:	e8 08 01 00 00       	call   8002d1 <cprintf>
  8001c9:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001cc:	e8 e0 10 00 00       	call   8012b1 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001d1:	e8 19 00 00 00       	call   8001ef <exit>
}
  8001d6:	90                   	nop
  8001d7:	c9                   	leave  
  8001d8:	c3                   	ret    

008001d9 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001d9:	55                   	push   %ebp
  8001da:	89 e5                	mov    %esp,%ebp
  8001dc:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001df:	83 ec 0c             	sub    $0xc,%esp
  8001e2:	6a 00                	push   $0x0
  8001e4:	e8 df 0e 00 00       	call   8010c8 <sys_env_destroy>
  8001e9:	83 c4 10             	add    $0x10,%esp
}
  8001ec:	90                   	nop
  8001ed:	c9                   	leave  
  8001ee:	c3                   	ret    

008001ef <exit>:

void
exit(void)
{
  8001ef:	55                   	push   %ebp
  8001f0:	89 e5                	mov    %esp,%ebp
  8001f2:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001f5:	e8 34 0f 00 00       	call   80112e <sys_env_exit>
}
  8001fa:	90                   	nop
  8001fb:	c9                   	leave  
  8001fc:	c3                   	ret    

008001fd <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001fd:	55                   	push   %ebp
  8001fe:	89 e5                	mov    %esp,%ebp
  800200:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800203:	8b 45 0c             	mov    0xc(%ebp),%eax
  800206:	8b 00                	mov    (%eax),%eax
  800208:	8d 48 01             	lea    0x1(%eax),%ecx
  80020b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80020e:	89 0a                	mov    %ecx,(%edx)
  800210:	8b 55 08             	mov    0x8(%ebp),%edx
  800213:	88 d1                	mov    %dl,%cl
  800215:	8b 55 0c             	mov    0xc(%ebp),%edx
  800218:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80021c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80021f:	8b 00                	mov    (%eax),%eax
  800221:	3d ff 00 00 00       	cmp    $0xff,%eax
  800226:	75 2c                	jne    800254 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800228:	a0 24 20 80 00       	mov    0x802024,%al
  80022d:	0f b6 c0             	movzbl %al,%eax
  800230:	8b 55 0c             	mov    0xc(%ebp),%edx
  800233:	8b 12                	mov    (%edx),%edx
  800235:	89 d1                	mov    %edx,%ecx
  800237:	8b 55 0c             	mov    0xc(%ebp),%edx
  80023a:	83 c2 08             	add    $0x8,%edx
  80023d:	83 ec 04             	sub    $0x4,%esp
  800240:	50                   	push   %eax
  800241:	51                   	push   %ecx
  800242:	52                   	push   %edx
  800243:	e8 3e 0e 00 00       	call   801086 <sys_cputs>
  800248:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80024b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80024e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800254:	8b 45 0c             	mov    0xc(%ebp),%eax
  800257:	8b 40 04             	mov    0x4(%eax),%eax
  80025a:	8d 50 01             	lea    0x1(%eax),%edx
  80025d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800260:	89 50 04             	mov    %edx,0x4(%eax)
}
  800263:	90                   	nop
  800264:	c9                   	leave  
  800265:	c3                   	ret    

00800266 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800266:	55                   	push   %ebp
  800267:	89 e5                	mov    %esp,%ebp
  800269:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80026f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800276:	00 00 00 
	b.cnt = 0;
  800279:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800280:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800283:	ff 75 0c             	pushl  0xc(%ebp)
  800286:	ff 75 08             	pushl  0x8(%ebp)
  800289:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80028f:	50                   	push   %eax
  800290:	68 fd 01 80 00       	push   $0x8001fd
  800295:	e8 11 02 00 00       	call   8004ab <vprintfmt>
  80029a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80029d:	a0 24 20 80 00       	mov    0x802024,%al
  8002a2:	0f b6 c0             	movzbl %al,%eax
  8002a5:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002ab:	83 ec 04             	sub    $0x4,%esp
  8002ae:	50                   	push   %eax
  8002af:	52                   	push   %edx
  8002b0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002b6:	83 c0 08             	add    $0x8,%eax
  8002b9:	50                   	push   %eax
  8002ba:	e8 c7 0d 00 00       	call   801086 <sys_cputs>
  8002bf:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002c2:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  8002c9:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002cf:	c9                   	leave  
  8002d0:	c3                   	ret    

008002d1 <cprintf>:

int cprintf(const char *fmt, ...) {
  8002d1:	55                   	push   %ebp
  8002d2:	89 e5                	mov    %esp,%ebp
  8002d4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002d7:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  8002de:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e7:	83 ec 08             	sub    $0x8,%esp
  8002ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8002ed:	50                   	push   %eax
  8002ee:	e8 73 ff ff ff       	call   800266 <vcprintf>
  8002f3:	83 c4 10             	add    $0x10,%esp
  8002f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002fc:	c9                   	leave  
  8002fd:	c3                   	ret    

008002fe <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002fe:	55                   	push   %ebp
  8002ff:	89 e5                	mov    %esp,%ebp
  800301:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800304:	e8 8e 0f 00 00       	call   801297 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800309:	8d 45 0c             	lea    0xc(%ebp),%eax
  80030c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80030f:	8b 45 08             	mov    0x8(%ebp),%eax
  800312:	83 ec 08             	sub    $0x8,%esp
  800315:	ff 75 f4             	pushl  -0xc(%ebp)
  800318:	50                   	push   %eax
  800319:	e8 48 ff ff ff       	call   800266 <vcprintf>
  80031e:	83 c4 10             	add    $0x10,%esp
  800321:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800324:	e8 88 0f 00 00       	call   8012b1 <sys_enable_interrupt>
	return cnt;
  800329:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80032c:	c9                   	leave  
  80032d:	c3                   	ret    

0080032e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80032e:	55                   	push   %ebp
  80032f:	89 e5                	mov    %esp,%ebp
  800331:	53                   	push   %ebx
  800332:	83 ec 14             	sub    $0x14,%esp
  800335:	8b 45 10             	mov    0x10(%ebp),%eax
  800338:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80033b:	8b 45 14             	mov    0x14(%ebp),%eax
  80033e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800341:	8b 45 18             	mov    0x18(%ebp),%eax
  800344:	ba 00 00 00 00       	mov    $0x0,%edx
  800349:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80034c:	77 55                	ja     8003a3 <printnum+0x75>
  80034e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800351:	72 05                	jb     800358 <printnum+0x2a>
  800353:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800356:	77 4b                	ja     8003a3 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800358:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80035b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80035e:	8b 45 18             	mov    0x18(%ebp),%eax
  800361:	ba 00 00 00 00       	mov    $0x0,%edx
  800366:	52                   	push   %edx
  800367:	50                   	push   %eax
  800368:	ff 75 f4             	pushl  -0xc(%ebp)
  80036b:	ff 75 f0             	pushl  -0x10(%ebp)
  80036e:	e8 45 13 00 00       	call   8016b8 <__udivdi3>
  800373:	83 c4 10             	add    $0x10,%esp
  800376:	83 ec 04             	sub    $0x4,%esp
  800379:	ff 75 20             	pushl  0x20(%ebp)
  80037c:	53                   	push   %ebx
  80037d:	ff 75 18             	pushl  0x18(%ebp)
  800380:	52                   	push   %edx
  800381:	50                   	push   %eax
  800382:	ff 75 0c             	pushl  0xc(%ebp)
  800385:	ff 75 08             	pushl  0x8(%ebp)
  800388:	e8 a1 ff ff ff       	call   80032e <printnum>
  80038d:	83 c4 20             	add    $0x20,%esp
  800390:	eb 1a                	jmp    8003ac <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800392:	83 ec 08             	sub    $0x8,%esp
  800395:	ff 75 0c             	pushl  0xc(%ebp)
  800398:	ff 75 20             	pushl  0x20(%ebp)
  80039b:	8b 45 08             	mov    0x8(%ebp),%eax
  80039e:	ff d0                	call   *%eax
  8003a0:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003a3:	ff 4d 1c             	decl   0x1c(%ebp)
  8003a6:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003aa:	7f e6                	jg     800392 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003ac:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003af:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003ba:	53                   	push   %ebx
  8003bb:	51                   	push   %ecx
  8003bc:	52                   	push   %edx
  8003bd:	50                   	push   %eax
  8003be:	e8 05 14 00 00       	call   8017c8 <__umoddi3>
  8003c3:	83 c4 10             	add    $0x10,%esp
  8003c6:	05 14 1c 80 00       	add    $0x801c14,%eax
  8003cb:	8a 00                	mov    (%eax),%al
  8003cd:	0f be c0             	movsbl %al,%eax
  8003d0:	83 ec 08             	sub    $0x8,%esp
  8003d3:	ff 75 0c             	pushl  0xc(%ebp)
  8003d6:	50                   	push   %eax
  8003d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003da:	ff d0                	call   *%eax
  8003dc:	83 c4 10             	add    $0x10,%esp
}
  8003df:	90                   	nop
  8003e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003e3:	c9                   	leave  
  8003e4:	c3                   	ret    

008003e5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003e5:	55                   	push   %ebp
  8003e6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003e8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003ec:	7e 1c                	jle    80040a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f1:	8b 00                	mov    (%eax),%eax
  8003f3:	8d 50 08             	lea    0x8(%eax),%edx
  8003f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f9:	89 10                	mov    %edx,(%eax)
  8003fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fe:	8b 00                	mov    (%eax),%eax
  800400:	83 e8 08             	sub    $0x8,%eax
  800403:	8b 50 04             	mov    0x4(%eax),%edx
  800406:	8b 00                	mov    (%eax),%eax
  800408:	eb 40                	jmp    80044a <getuint+0x65>
	else if (lflag)
  80040a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80040e:	74 1e                	je     80042e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800410:	8b 45 08             	mov    0x8(%ebp),%eax
  800413:	8b 00                	mov    (%eax),%eax
  800415:	8d 50 04             	lea    0x4(%eax),%edx
  800418:	8b 45 08             	mov    0x8(%ebp),%eax
  80041b:	89 10                	mov    %edx,(%eax)
  80041d:	8b 45 08             	mov    0x8(%ebp),%eax
  800420:	8b 00                	mov    (%eax),%eax
  800422:	83 e8 04             	sub    $0x4,%eax
  800425:	8b 00                	mov    (%eax),%eax
  800427:	ba 00 00 00 00       	mov    $0x0,%edx
  80042c:	eb 1c                	jmp    80044a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80042e:	8b 45 08             	mov    0x8(%ebp),%eax
  800431:	8b 00                	mov    (%eax),%eax
  800433:	8d 50 04             	lea    0x4(%eax),%edx
  800436:	8b 45 08             	mov    0x8(%ebp),%eax
  800439:	89 10                	mov    %edx,(%eax)
  80043b:	8b 45 08             	mov    0x8(%ebp),%eax
  80043e:	8b 00                	mov    (%eax),%eax
  800440:	83 e8 04             	sub    $0x4,%eax
  800443:	8b 00                	mov    (%eax),%eax
  800445:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80044a:	5d                   	pop    %ebp
  80044b:	c3                   	ret    

0080044c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80044c:	55                   	push   %ebp
  80044d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80044f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800453:	7e 1c                	jle    800471 <getint+0x25>
		return va_arg(*ap, long long);
  800455:	8b 45 08             	mov    0x8(%ebp),%eax
  800458:	8b 00                	mov    (%eax),%eax
  80045a:	8d 50 08             	lea    0x8(%eax),%edx
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	89 10                	mov    %edx,(%eax)
  800462:	8b 45 08             	mov    0x8(%ebp),%eax
  800465:	8b 00                	mov    (%eax),%eax
  800467:	83 e8 08             	sub    $0x8,%eax
  80046a:	8b 50 04             	mov    0x4(%eax),%edx
  80046d:	8b 00                	mov    (%eax),%eax
  80046f:	eb 38                	jmp    8004a9 <getint+0x5d>
	else if (lflag)
  800471:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800475:	74 1a                	je     800491 <getint+0x45>
		return va_arg(*ap, long);
  800477:	8b 45 08             	mov    0x8(%ebp),%eax
  80047a:	8b 00                	mov    (%eax),%eax
  80047c:	8d 50 04             	lea    0x4(%eax),%edx
  80047f:	8b 45 08             	mov    0x8(%ebp),%eax
  800482:	89 10                	mov    %edx,(%eax)
  800484:	8b 45 08             	mov    0x8(%ebp),%eax
  800487:	8b 00                	mov    (%eax),%eax
  800489:	83 e8 04             	sub    $0x4,%eax
  80048c:	8b 00                	mov    (%eax),%eax
  80048e:	99                   	cltd   
  80048f:	eb 18                	jmp    8004a9 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800491:	8b 45 08             	mov    0x8(%ebp),%eax
  800494:	8b 00                	mov    (%eax),%eax
  800496:	8d 50 04             	lea    0x4(%eax),%edx
  800499:	8b 45 08             	mov    0x8(%ebp),%eax
  80049c:	89 10                	mov    %edx,(%eax)
  80049e:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a1:	8b 00                	mov    (%eax),%eax
  8004a3:	83 e8 04             	sub    $0x4,%eax
  8004a6:	8b 00                	mov    (%eax),%eax
  8004a8:	99                   	cltd   
}
  8004a9:	5d                   	pop    %ebp
  8004aa:	c3                   	ret    

008004ab <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004ab:	55                   	push   %ebp
  8004ac:	89 e5                	mov    %esp,%ebp
  8004ae:	56                   	push   %esi
  8004af:	53                   	push   %ebx
  8004b0:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004b3:	eb 17                	jmp    8004cc <vprintfmt+0x21>
			if (ch == '\0')
  8004b5:	85 db                	test   %ebx,%ebx
  8004b7:	0f 84 af 03 00 00    	je     80086c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004bd:	83 ec 08             	sub    $0x8,%esp
  8004c0:	ff 75 0c             	pushl  0xc(%ebp)
  8004c3:	53                   	push   %ebx
  8004c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c7:	ff d0                	call   *%eax
  8004c9:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8004cf:	8d 50 01             	lea    0x1(%eax),%edx
  8004d2:	89 55 10             	mov    %edx,0x10(%ebp)
  8004d5:	8a 00                	mov    (%eax),%al
  8004d7:	0f b6 d8             	movzbl %al,%ebx
  8004da:	83 fb 25             	cmp    $0x25,%ebx
  8004dd:	75 d6                	jne    8004b5 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004df:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004e3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004ea:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004f1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004f8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004ff:	8b 45 10             	mov    0x10(%ebp),%eax
  800502:	8d 50 01             	lea    0x1(%eax),%edx
  800505:	89 55 10             	mov    %edx,0x10(%ebp)
  800508:	8a 00                	mov    (%eax),%al
  80050a:	0f b6 d8             	movzbl %al,%ebx
  80050d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800510:	83 f8 55             	cmp    $0x55,%eax
  800513:	0f 87 2b 03 00 00    	ja     800844 <vprintfmt+0x399>
  800519:	8b 04 85 38 1c 80 00 	mov    0x801c38(,%eax,4),%eax
  800520:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800522:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800526:	eb d7                	jmp    8004ff <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800528:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80052c:	eb d1                	jmp    8004ff <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80052e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800535:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800538:	89 d0                	mov    %edx,%eax
  80053a:	c1 e0 02             	shl    $0x2,%eax
  80053d:	01 d0                	add    %edx,%eax
  80053f:	01 c0                	add    %eax,%eax
  800541:	01 d8                	add    %ebx,%eax
  800543:	83 e8 30             	sub    $0x30,%eax
  800546:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800549:	8b 45 10             	mov    0x10(%ebp),%eax
  80054c:	8a 00                	mov    (%eax),%al
  80054e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800551:	83 fb 2f             	cmp    $0x2f,%ebx
  800554:	7e 3e                	jle    800594 <vprintfmt+0xe9>
  800556:	83 fb 39             	cmp    $0x39,%ebx
  800559:	7f 39                	jg     800594 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80055b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80055e:	eb d5                	jmp    800535 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800560:	8b 45 14             	mov    0x14(%ebp),%eax
  800563:	83 c0 04             	add    $0x4,%eax
  800566:	89 45 14             	mov    %eax,0x14(%ebp)
  800569:	8b 45 14             	mov    0x14(%ebp),%eax
  80056c:	83 e8 04             	sub    $0x4,%eax
  80056f:	8b 00                	mov    (%eax),%eax
  800571:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800574:	eb 1f                	jmp    800595 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800576:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80057a:	79 83                	jns    8004ff <vprintfmt+0x54>
				width = 0;
  80057c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800583:	e9 77 ff ff ff       	jmp    8004ff <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800588:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80058f:	e9 6b ff ff ff       	jmp    8004ff <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800594:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800595:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800599:	0f 89 60 ff ff ff    	jns    8004ff <vprintfmt+0x54>
				width = precision, precision = -1;
  80059f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005a2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005a5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005ac:	e9 4e ff ff ff       	jmp    8004ff <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005b1:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005b4:	e9 46 ff ff ff       	jmp    8004ff <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005b9:	8b 45 14             	mov    0x14(%ebp),%eax
  8005bc:	83 c0 04             	add    $0x4,%eax
  8005bf:	89 45 14             	mov    %eax,0x14(%ebp)
  8005c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c5:	83 e8 04             	sub    $0x4,%eax
  8005c8:	8b 00                	mov    (%eax),%eax
  8005ca:	83 ec 08             	sub    $0x8,%esp
  8005cd:	ff 75 0c             	pushl  0xc(%ebp)
  8005d0:	50                   	push   %eax
  8005d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d4:	ff d0                	call   *%eax
  8005d6:	83 c4 10             	add    $0x10,%esp
			break;
  8005d9:	e9 89 02 00 00       	jmp    800867 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005de:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e1:	83 c0 04             	add    $0x4,%eax
  8005e4:	89 45 14             	mov    %eax,0x14(%ebp)
  8005e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ea:	83 e8 04             	sub    $0x4,%eax
  8005ed:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005ef:	85 db                	test   %ebx,%ebx
  8005f1:	79 02                	jns    8005f5 <vprintfmt+0x14a>
				err = -err;
  8005f3:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005f5:	83 fb 64             	cmp    $0x64,%ebx
  8005f8:	7f 0b                	jg     800605 <vprintfmt+0x15a>
  8005fa:	8b 34 9d 80 1a 80 00 	mov    0x801a80(,%ebx,4),%esi
  800601:	85 f6                	test   %esi,%esi
  800603:	75 19                	jne    80061e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800605:	53                   	push   %ebx
  800606:	68 25 1c 80 00       	push   $0x801c25
  80060b:	ff 75 0c             	pushl  0xc(%ebp)
  80060e:	ff 75 08             	pushl  0x8(%ebp)
  800611:	e8 5e 02 00 00       	call   800874 <printfmt>
  800616:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800619:	e9 49 02 00 00       	jmp    800867 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80061e:	56                   	push   %esi
  80061f:	68 2e 1c 80 00       	push   $0x801c2e
  800624:	ff 75 0c             	pushl  0xc(%ebp)
  800627:	ff 75 08             	pushl  0x8(%ebp)
  80062a:	e8 45 02 00 00       	call   800874 <printfmt>
  80062f:	83 c4 10             	add    $0x10,%esp
			break;
  800632:	e9 30 02 00 00       	jmp    800867 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800637:	8b 45 14             	mov    0x14(%ebp),%eax
  80063a:	83 c0 04             	add    $0x4,%eax
  80063d:	89 45 14             	mov    %eax,0x14(%ebp)
  800640:	8b 45 14             	mov    0x14(%ebp),%eax
  800643:	83 e8 04             	sub    $0x4,%eax
  800646:	8b 30                	mov    (%eax),%esi
  800648:	85 f6                	test   %esi,%esi
  80064a:	75 05                	jne    800651 <vprintfmt+0x1a6>
				p = "(null)";
  80064c:	be 31 1c 80 00       	mov    $0x801c31,%esi
			if (width > 0 && padc != '-')
  800651:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800655:	7e 6d                	jle    8006c4 <vprintfmt+0x219>
  800657:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80065b:	74 67                	je     8006c4 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80065d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800660:	83 ec 08             	sub    $0x8,%esp
  800663:	50                   	push   %eax
  800664:	56                   	push   %esi
  800665:	e8 0c 03 00 00       	call   800976 <strnlen>
  80066a:	83 c4 10             	add    $0x10,%esp
  80066d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800670:	eb 16                	jmp    800688 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800672:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800676:	83 ec 08             	sub    $0x8,%esp
  800679:	ff 75 0c             	pushl  0xc(%ebp)
  80067c:	50                   	push   %eax
  80067d:	8b 45 08             	mov    0x8(%ebp),%eax
  800680:	ff d0                	call   *%eax
  800682:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800685:	ff 4d e4             	decl   -0x1c(%ebp)
  800688:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80068c:	7f e4                	jg     800672 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80068e:	eb 34                	jmp    8006c4 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800690:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800694:	74 1c                	je     8006b2 <vprintfmt+0x207>
  800696:	83 fb 1f             	cmp    $0x1f,%ebx
  800699:	7e 05                	jle    8006a0 <vprintfmt+0x1f5>
  80069b:	83 fb 7e             	cmp    $0x7e,%ebx
  80069e:	7e 12                	jle    8006b2 <vprintfmt+0x207>
					putch('?', putdat);
  8006a0:	83 ec 08             	sub    $0x8,%esp
  8006a3:	ff 75 0c             	pushl  0xc(%ebp)
  8006a6:	6a 3f                	push   $0x3f
  8006a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ab:	ff d0                	call   *%eax
  8006ad:	83 c4 10             	add    $0x10,%esp
  8006b0:	eb 0f                	jmp    8006c1 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006b2:	83 ec 08             	sub    $0x8,%esp
  8006b5:	ff 75 0c             	pushl  0xc(%ebp)
  8006b8:	53                   	push   %ebx
  8006b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bc:	ff d0                	call   *%eax
  8006be:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006c1:	ff 4d e4             	decl   -0x1c(%ebp)
  8006c4:	89 f0                	mov    %esi,%eax
  8006c6:	8d 70 01             	lea    0x1(%eax),%esi
  8006c9:	8a 00                	mov    (%eax),%al
  8006cb:	0f be d8             	movsbl %al,%ebx
  8006ce:	85 db                	test   %ebx,%ebx
  8006d0:	74 24                	je     8006f6 <vprintfmt+0x24b>
  8006d2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006d6:	78 b8                	js     800690 <vprintfmt+0x1e5>
  8006d8:	ff 4d e0             	decl   -0x20(%ebp)
  8006db:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006df:	79 af                	jns    800690 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006e1:	eb 13                	jmp    8006f6 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006e3:	83 ec 08             	sub    $0x8,%esp
  8006e6:	ff 75 0c             	pushl  0xc(%ebp)
  8006e9:	6a 20                	push   $0x20
  8006eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ee:	ff d0                	call   *%eax
  8006f0:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006f3:	ff 4d e4             	decl   -0x1c(%ebp)
  8006f6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006fa:	7f e7                	jg     8006e3 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006fc:	e9 66 01 00 00       	jmp    800867 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800701:	83 ec 08             	sub    $0x8,%esp
  800704:	ff 75 e8             	pushl  -0x18(%ebp)
  800707:	8d 45 14             	lea    0x14(%ebp),%eax
  80070a:	50                   	push   %eax
  80070b:	e8 3c fd ff ff       	call   80044c <getint>
  800710:	83 c4 10             	add    $0x10,%esp
  800713:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800716:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800719:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80071c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80071f:	85 d2                	test   %edx,%edx
  800721:	79 23                	jns    800746 <vprintfmt+0x29b>
				putch('-', putdat);
  800723:	83 ec 08             	sub    $0x8,%esp
  800726:	ff 75 0c             	pushl  0xc(%ebp)
  800729:	6a 2d                	push   $0x2d
  80072b:	8b 45 08             	mov    0x8(%ebp),%eax
  80072e:	ff d0                	call   *%eax
  800730:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800733:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800736:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800739:	f7 d8                	neg    %eax
  80073b:	83 d2 00             	adc    $0x0,%edx
  80073e:	f7 da                	neg    %edx
  800740:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800743:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800746:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80074d:	e9 bc 00 00 00       	jmp    80080e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800752:	83 ec 08             	sub    $0x8,%esp
  800755:	ff 75 e8             	pushl  -0x18(%ebp)
  800758:	8d 45 14             	lea    0x14(%ebp),%eax
  80075b:	50                   	push   %eax
  80075c:	e8 84 fc ff ff       	call   8003e5 <getuint>
  800761:	83 c4 10             	add    $0x10,%esp
  800764:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800767:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80076a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800771:	e9 98 00 00 00       	jmp    80080e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800776:	83 ec 08             	sub    $0x8,%esp
  800779:	ff 75 0c             	pushl  0xc(%ebp)
  80077c:	6a 58                	push   $0x58
  80077e:	8b 45 08             	mov    0x8(%ebp),%eax
  800781:	ff d0                	call   *%eax
  800783:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800786:	83 ec 08             	sub    $0x8,%esp
  800789:	ff 75 0c             	pushl  0xc(%ebp)
  80078c:	6a 58                	push   $0x58
  80078e:	8b 45 08             	mov    0x8(%ebp),%eax
  800791:	ff d0                	call   *%eax
  800793:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800796:	83 ec 08             	sub    $0x8,%esp
  800799:	ff 75 0c             	pushl  0xc(%ebp)
  80079c:	6a 58                	push   $0x58
  80079e:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a1:	ff d0                	call   *%eax
  8007a3:	83 c4 10             	add    $0x10,%esp
			break;
  8007a6:	e9 bc 00 00 00       	jmp    800867 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007ab:	83 ec 08             	sub    $0x8,%esp
  8007ae:	ff 75 0c             	pushl  0xc(%ebp)
  8007b1:	6a 30                	push   $0x30
  8007b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b6:	ff d0                	call   *%eax
  8007b8:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007bb:	83 ec 08             	sub    $0x8,%esp
  8007be:	ff 75 0c             	pushl  0xc(%ebp)
  8007c1:	6a 78                	push   $0x78
  8007c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c6:	ff d0                	call   *%eax
  8007c8:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007cb:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ce:	83 c0 04             	add    $0x4,%eax
  8007d1:	89 45 14             	mov    %eax,0x14(%ebp)
  8007d4:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d7:	83 e8 04             	sub    $0x4,%eax
  8007da:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007e6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007ed:	eb 1f                	jmp    80080e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007ef:	83 ec 08             	sub    $0x8,%esp
  8007f2:	ff 75 e8             	pushl  -0x18(%ebp)
  8007f5:	8d 45 14             	lea    0x14(%ebp),%eax
  8007f8:	50                   	push   %eax
  8007f9:	e8 e7 fb ff ff       	call   8003e5 <getuint>
  8007fe:	83 c4 10             	add    $0x10,%esp
  800801:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800804:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800807:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80080e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800812:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800815:	83 ec 04             	sub    $0x4,%esp
  800818:	52                   	push   %edx
  800819:	ff 75 e4             	pushl  -0x1c(%ebp)
  80081c:	50                   	push   %eax
  80081d:	ff 75 f4             	pushl  -0xc(%ebp)
  800820:	ff 75 f0             	pushl  -0x10(%ebp)
  800823:	ff 75 0c             	pushl  0xc(%ebp)
  800826:	ff 75 08             	pushl  0x8(%ebp)
  800829:	e8 00 fb ff ff       	call   80032e <printnum>
  80082e:	83 c4 20             	add    $0x20,%esp
			break;
  800831:	eb 34                	jmp    800867 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800833:	83 ec 08             	sub    $0x8,%esp
  800836:	ff 75 0c             	pushl  0xc(%ebp)
  800839:	53                   	push   %ebx
  80083a:	8b 45 08             	mov    0x8(%ebp),%eax
  80083d:	ff d0                	call   *%eax
  80083f:	83 c4 10             	add    $0x10,%esp
			break;
  800842:	eb 23                	jmp    800867 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800844:	83 ec 08             	sub    $0x8,%esp
  800847:	ff 75 0c             	pushl  0xc(%ebp)
  80084a:	6a 25                	push   $0x25
  80084c:	8b 45 08             	mov    0x8(%ebp),%eax
  80084f:	ff d0                	call   *%eax
  800851:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800854:	ff 4d 10             	decl   0x10(%ebp)
  800857:	eb 03                	jmp    80085c <vprintfmt+0x3b1>
  800859:	ff 4d 10             	decl   0x10(%ebp)
  80085c:	8b 45 10             	mov    0x10(%ebp),%eax
  80085f:	48                   	dec    %eax
  800860:	8a 00                	mov    (%eax),%al
  800862:	3c 25                	cmp    $0x25,%al
  800864:	75 f3                	jne    800859 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800866:	90                   	nop
		}
	}
  800867:	e9 47 fc ff ff       	jmp    8004b3 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80086c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80086d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800870:	5b                   	pop    %ebx
  800871:	5e                   	pop    %esi
  800872:	5d                   	pop    %ebp
  800873:	c3                   	ret    

00800874 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800874:	55                   	push   %ebp
  800875:	89 e5                	mov    %esp,%ebp
  800877:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80087a:	8d 45 10             	lea    0x10(%ebp),%eax
  80087d:	83 c0 04             	add    $0x4,%eax
  800880:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800883:	8b 45 10             	mov    0x10(%ebp),%eax
  800886:	ff 75 f4             	pushl  -0xc(%ebp)
  800889:	50                   	push   %eax
  80088a:	ff 75 0c             	pushl  0xc(%ebp)
  80088d:	ff 75 08             	pushl  0x8(%ebp)
  800890:	e8 16 fc ff ff       	call   8004ab <vprintfmt>
  800895:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800898:	90                   	nop
  800899:	c9                   	leave  
  80089a:	c3                   	ret    

0080089b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80089b:	55                   	push   %ebp
  80089c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80089e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a1:	8b 40 08             	mov    0x8(%eax),%eax
  8008a4:	8d 50 01             	lea    0x1(%eax),%edx
  8008a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008aa:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b0:	8b 10                	mov    (%eax),%edx
  8008b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b5:	8b 40 04             	mov    0x4(%eax),%eax
  8008b8:	39 c2                	cmp    %eax,%edx
  8008ba:	73 12                	jae    8008ce <sprintputch+0x33>
		*b->buf++ = ch;
  8008bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008bf:	8b 00                	mov    (%eax),%eax
  8008c1:	8d 48 01             	lea    0x1(%eax),%ecx
  8008c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008c7:	89 0a                	mov    %ecx,(%edx)
  8008c9:	8b 55 08             	mov    0x8(%ebp),%edx
  8008cc:	88 10                	mov    %dl,(%eax)
}
  8008ce:	90                   	nop
  8008cf:	5d                   	pop    %ebp
  8008d0:	c3                   	ret    

008008d1 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008d1:	55                   	push   %ebp
  8008d2:	89 e5                	mov    %esp,%ebp
  8008d4:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008da:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e6:	01 d0                	add    %edx,%eax
  8008e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008eb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008f2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008f6:	74 06                	je     8008fe <vsnprintf+0x2d>
  8008f8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008fc:	7f 07                	jg     800905 <vsnprintf+0x34>
		return -E_INVAL;
  8008fe:	b8 03 00 00 00       	mov    $0x3,%eax
  800903:	eb 20                	jmp    800925 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800905:	ff 75 14             	pushl  0x14(%ebp)
  800908:	ff 75 10             	pushl  0x10(%ebp)
  80090b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80090e:	50                   	push   %eax
  80090f:	68 9b 08 80 00       	push   $0x80089b
  800914:	e8 92 fb ff ff       	call   8004ab <vprintfmt>
  800919:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80091c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80091f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800922:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800925:	c9                   	leave  
  800926:	c3                   	ret    

00800927 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800927:	55                   	push   %ebp
  800928:	89 e5                	mov    %esp,%ebp
  80092a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80092d:	8d 45 10             	lea    0x10(%ebp),%eax
  800930:	83 c0 04             	add    $0x4,%eax
  800933:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800936:	8b 45 10             	mov    0x10(%ebp),%eax
  800939:	ff 75 f4             	pushl  -0xc(%ebp)
  80093c:	50                   	push   %eax
  80093d:	ff 75 0c             	pushl  0xc(%ebp)
  800940:	ff 75 08             	pushl  0x8(%ebp)
  800943:	e8 89 ff ff ff       	call   8008d1 <vsnprintf>
  800948:	83 c4 10             	add    $0x10,%esp
  80094b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80094e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800951:	c9                   	leave  
  800952:	c3                   	ret    

00800953 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800953:	55                   	push   %ebp
  800954:	89 e5                	mov    %esp,%ebp
  800956:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800959:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800960:	eb 06                	jmp    800968 <strlen+0x15>
		n++;
  800962:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800965:	ff 45 08             	incl   0x8(%ebp)
  800968:	8b 45 08             	mov    0x8(%ebp),%eax
  80096b:	8a 00                	mov    (%eax),%al
  80096d:	84 c0                	test   %al,%al
  80096f:	75 f1                	jne    800962 <strlen+0xf>
		n++;
	return n;
  800971:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800974:	c9                   	leave  
  800975:	c3                   	ret    

00800976 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800976:	55                   	push   %ebp
  800977:	89 e5                	mov    %esp,%ebp
  800979:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80097c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800983:	eb 09                	jmp    80098e <strnlen+0x18>
		n++;
  800985:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800988:	ff 45 08             	incl   0x8(%ebp)
  80098b:	ff 4d 0c             	decl   0xc(%ebp)
  80098e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800992:	74 09                	je     80099d <strnlen+0x27>
  800994:	8b 45 08             	mov    0x8(%ebp),%eax
  800997:	8a 00                	mov    (%eax),%al
  800999:	84 c0                	test   %al,%al
  80099b:	75 e8                	jne    800985 <strnlen+0xf>
		n++;
	return n;
  80099d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009a0:	c9                   	leave  
  8009a1:	c3                   	ret    

008009a2 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8009a2:	55                   	push   %ebp
  8009a3:	89 e5                	mov    %esp,%ebp
  8009a5:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8009a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8009ae:	90                   	nop
  8009af:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b2:	8d 50 01             	lea    0x1(%eax),%edx
  8009b5:	89 55 08             	mov    %edx,0x8(%ebp)
  8009b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009bb:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009be:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009c1:	8a 12                	mov    (%edx),%dl
  8009c3:	88 10                	mov    %dl,(%eax)
  8009c5:	8a 00                	mov    (%eax),%al
  8009c7:	84 c0                	test   %al,%al
  8009c9:	75 e4                	jne    8009af <strcpy+0xd>
		/* do nothing */;
	return ret;
  8009cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009ce:	c9                   	leave  
  8009cf:	c3                   	ret    

008009d0 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8009d0:	55                   	push   %ebp
  8009d1:	89 e5                	mov    %esp,%ebp
  8009d3:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8009d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009e3:	eb 1f                	jmp    800a04 <strncpy+0x34>
		*dst++ = *src;
  8009e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e8:	8d 50 01             	lea    0x1(%eax),%edx
  8009eb:	89 55 08             	mov    %edx,0x8(%ebp)
  8009ee:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009f1:	8a 12                	mov    (%edx),%dl
  8009f3:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f8:	8a 00                	mov    (%eax),%al
  8009fa:	84 c0                	test   %al,%al
  8009fc:	74 03                	je     800a01 <strncpy+0x31>
			src++;
  8009fe:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a01:	ff 45 fc             	incl   -0x4(%ebp)
  800a04:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a07:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a0a:	72 d9                	jb     8009e5 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a0c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a0f:	c9                   	leave  
  800a10:	c3                   	ret    

00800a11 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a11:	55                   	push   %ebp
  800a12:	89 e5                	mov    %esp,%ebp
  800a14:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a17:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a1d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a21:	74 30                	je     800a53 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a23:	eb 16                	jmp    800a3b <strlcpy+0x2a>
			*dst++ = *src++;
  800a25:	8b 45 08             	mov    0x8(%ebp),%eax
  800a28:	8d 50 01             	lea    0x1(%eax),%edx
  800a2b:	89 55 08             	mov    %edx,0x8(%ebp)
  800a2e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a31:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a34:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a37:	8a 12                	mov    (%edx),%dl
  800a39:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a3b:	ff 4d 10             	decl   0x10(%ebp)
  800a3e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a42:	74 09                	je     800a4d <strlcpy+0x3c>
  800a44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a47:	8a 00                	mov    (%eax),%al
  800a49:	84 c0                	test   %al,%al
  800a4b:	75 d8                	jne    800a25 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a50:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a53:	8b 55 08             	mov    0x8(%ebp),%edx
  800a56:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a59:	29 c2                	sub    %eax,%edx
  800a5b:	89 d0                	mov    %edx,%eax
}
  800a5d:	c9                   	leave  
  800a5e:	c3                   	ret    

00800a5f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a5f:	55                   	push   %ebp
  800a60:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a62:	eb 06                	jmp    800a6a <strcmp+0xb>
		p++, q++;
  800a64:	ff 45 08             	incl   0x8(%ebp)
  800a67:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6d:	8a 00                	mov    (%eax),%al
  800a6f:	84 c0                	test   %al,%al
  800a71:	74 0e                	je     800a81 <strcmp+0x22>
  800a73:	8b 45 08             	mov    0x8(%ebp),%eax
  800a76:	8a 10                	mov    (%eax),%dl
  800a78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a7b:	8a 00                	mov    (%eax),%al
  800a7d:	38 c2                	cmp    %al,%dl
  800a7f:	74 e3                	je     800a64 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a81:	8b 45 08             	mov    0x8(%ebp),%eax
  800a84:	8a 00                	mov    (%eax),%al
  800a86:	0f b6 d0             	movzbl %al,%edx
  800a89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8c:	8a 00                	mov    (%eax),%al
  800a8e:	0f b6 c0             	movzbl %al,%eax
  800a91:	29 c2                	sub    %eax,%edx
  800a93:	89 d0                	mov    %edx,%eax
}
  800a95:	5d                   	pop    %ebp
  800a96:	c3                   	ret    

00800a97 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a97:	55                   	push   %ebp
  800a98:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a9a:	eb 09                	jmp    800aa5 <strncmp+0xe>
		n--, p++, q++;
  800a9c:	ff 4d 10             	decl   0x10(%ebp)
  800a9f:	ff 45 08             	incl   0x8(%ebp)
  800aa2:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800aa5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800aa9:	74 17                	je     800ac2 <strncmp+0x2b>
  800aab:	8b 45 08             	mov    0x8(%ebp),%eax
  800aae:	8a 00                	mov    (%eax),%al
  800ab0:	84 c0                	test   %al,%al
  800ab2:	74 0e                	je     800ac2 <strncmp+0x2b>
  800ab4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab7:	8a 10                	mov    (%eax),%dl
  800ab9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800abc:	8a 00                	mov    (%eax),%al
  800abe:	38 c2                	cmp    %al,%dl
  800ac0:	74 da                	je     800a9c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ac2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ac6:	75 07                	jne    800acf <strncmp+0x38>
		return 0;
  800ac8:	b8 00 00 00 00       	mov    $0x0,%eax
  800acd:	eb 14                	jmp    800ae3 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800acf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad2:	8a 00                	mov    (%eax),%al
  800ad4:	0f b6 d0             	movzbl %al,%edx
  800ad7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ada:	8a 00                	mov    (%eax),%al
  800adc:	0f b6 c0             	movzbl %al,%eax
  800adf:	29 c2                	sub    %eax,%edx
  800ae1:	89 d0                	mov    %edx,%eax
}
  800ae3:	5d                   	pop    %ebp
  800ae4:	c3                   	ret    

00800ae5 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ae5:	55                   	push   %ebp
  800ae6:	89 e5                	mov    %esp,%ebp
  800ae8:	83 ec 04             	sub    $0x4,%esp
  800aeb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aee:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800af1:	eb 12                	jmp    800b05 <strchr+0x20>
		if (*s == c)
  800af3:	8b 45 08             	mov    0x8(%ebp),%eax
  800af6:	8a 00                	mov    (%eax),%al
  800af8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800afb:	75 05                	jne    800b02 <strchr+0x1d>
			return (char *) s;
  800afd:	8b 45 08             	mov    0x8(%ebp),%eax
  800b00:	eb 11                	jmp    800b13 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b02:	ff 45 08             	incl   0x8(%ebp)
  800b05:	8b 45 08             	mov    0x8(%ebp),%eax
  800b08:	8a 00                	mov    (%eax),%al
  800b0a:	84 c0                	test   %al,%al
  800b0c:	75 e5                	jne    800af3 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b0e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b13:	c9                   	leave  
  800b14:	c3                   	ret    

00800b15 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b15:	55                   	push   %ebp
  800b16:	89 e5                	mov    %esp,%ebp
  800b18:	83 ec 04             	sub    $0x4,%esp
  800b1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b21:	eb 0d                	jmp    800b30 <strfind+0x1b>
		if (*s == c)
  800b23:	8b 45 08             	mov    0x8(%ebp),%eax
  800b26:	8a 00                	mov    (%eax),%al
  800b28:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b2b:	74 0e                	je     800b3b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b2d:	ff 45 08             	incl   0x8(%ebp)
  800b30:	8b 45 08             	mov    0x8(%ebp),%eax
  800b33:	8a 00                	mov    (%eax),%al
  800b35:	84 c0                	test   %al,%al
  800b37:	75 ea                	jne    800b23 <strfind+0xe>
  800b39:	eb 01                	jmp    800b3c <strfind+0x27>
		if (*s == c)
			break;
  800b3b:	90                   	nop
	return (char *) s;
  800b3c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b3f:	c9                   	leave  
  800b40:	c3                   	ret    

00800b41 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b41:	55                   	push   %ebp
  800b42:	89 e5                	mov    %esp,%ebp
  800b44:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b47:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b4d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b50:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b53:	eb 0e                	jmp    800b63 <memset+0x22>
		*p++ = c;
  800b55:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b58:	8d 50 01             	lea    0x1(%eax),%edx
  800b5b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b61:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b63:	ff 4d f8             	decl   -0x8(%ebp)
  800b66:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b6a:	79 e9                	jns    800b55 <memset+0x14>
		*p++ = c;

	return v;
  800b6c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b6f:	c9                   	leave  
  800b70:	c3                   	ret    

00800b71 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b71:	55                   	push   %ebp
  800b72:	89 e5                	mov    %esp,%ebp
  800b74:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b7a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b80:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b83:	eb 16                	jmp    800b9b <memcpy+0x2a>
		*d++ = *s++;
  800b85:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b88:	8d 50 01             	lea    0x1(%eax),%edx
  800b8b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b8e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b91:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b94:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b97:	8a 12                	mov    (%edx),%dl
  800b99:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b9b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b9e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ba1:	89 55 10             	mov    %edx,0x10(%ebp)
  800ba4:	85 c0                	test   %eax,%eax
  800ba6:	75 dd                	jne    800b85 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ba8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bab:	c9                   	leave  
  800bac:	c3                   	ret    

00800bad <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800bad:	55                   	push   %ebp
  800bae:	89 e5                	mov    %esp,%ebp
  800bb0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800bb3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800bbf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bc2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bc5:	73 50                	jae    800c17 <memmove+0x6a>
  800bc7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bca:	8b 45 10             	mov    0x10(%ebp),%eax
  800bcd:	01 d0                	add    %edx,%eax
  800bcf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bd2:	76 43                	jbe    800c17 <memmove+0x6a>
		s += n;
  800bd4:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd7:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800bda:	8b 45 10             	mov    0x10(%ebp),%eax
  800bdd:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800be0:	eb 10                	jmp    800bf2 <memmove+0x45>
			*--d = *--s;
  800be2:	ff 4d f8             	decl   -0x8(%ebp)
  800be5:	ff 4d fc             	decl   -0x4(%ebp)
  800be8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800beb:	8a 10                	mov    (%eax),%dl
  800bed:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bf0:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bf2:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bf8:	89 55 10             	mov    %edx,0x10(%ebp)
  800bfb:	85 c0                	test   %eax,%eax
  800bfd:	75 e3                	jne    800be2 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bff:	eb 23                	jmp    800c24 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c01:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c04:	8d 50 01             	lea    0x1(%eax),%edx
  800c07:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c0a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c0d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c10:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c13:	8a 12                	mov    (%edx),%dl
  800c15:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c17:	8b 45 10             	mov    0x10(%ebp),%eax
  800c1a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c1d:	89 55 10             	mov    %edx,0x10(%ebp)
  800c20:	85 c0                	test   %eax,%eax
  800c22:	75 dd                	jne    800c01 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c24:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c27:	c9                   	leave  
  800c28:	c3                   	ret    

00800c29 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c29:	55                   	push   %ebp
  800c2a:	89 e5                	mov    %esp,%ebp
  800c2c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c32:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c38:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c3b:	eb 2a                	jmp    800c67 <memcmp+0x3e>
		if (*s1 != *s2)
  800c3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c40:	8a 10                	mov    (%eax),%dl
  800c42:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c45:	8a 00                	mov    (%eax),%al
  800c47:	38 c2                	cmp    %al,%dl
  800c49:	74 16                	je     800c61 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c4e:	8a 00                	mov    (%eax),%al
  800c50:	0f b6 d0             	movzbl %al,%edx
  800c53:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c56:	8a 00                	mov    (%eax),%al
  800c58:	0f b6 c0             	movzbl %al,%eax
  800c5b:	29 c2                	sub    %eax,%edx
  800c5d:	89 d0                	mov    %edx,%eax
  800c5f:	eb 18                	jmp    800c79 <memcmp+0x50>
		s1++, s2++;
  800c61:	ff 45 fc             	incl   -0x4(%ebp)
  800c64:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c67:	8b 45 10             	mov    0x10(%ebp),%eax
  800c6a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c6d:	89 55 10             	mov    %edx,0x10(%ebp)
  800c70:	85 c0                	test   %eax,%eax
  800c72:	75 c9                	jne    800c3d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c74:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c79:	c9                   	leave  
  800c7a:	c3                   	ret    

00800c7b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c7b:	55                   	push   %ebp
  800c7c:	89 e5                	mov    %esp,%ebp
  800c7e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c81:	8b 55 08             	mov    0x8(%ebp),%edx
  800c84:	8b 45 10             	mov    0x10(%ebp),%eax
  800c87:	01 d0                	add    %edx,%eax
  800c89:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c8c:	eb 15                	jmp    800ca3 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c91:	8a 00                	mov    (%eax),%al
  800c93:	0f b6 d0             	movzbl %al,%edx
  800c96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c99:	0f b6 c0             	movzbl %al,%eax
  800c9c:	39 c2                	cmp    %eax,%edx
  800c9e:	74 0d                	je     800cad <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ca0:	ff 45 08             	incl   0x8(%ebp)
  800ca3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ca9:	72 e3                	jb     800c8e <memfind+0x13>
  800cab:	eb 01                	jmp    800cae <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800cad:	90                   	nop
	return (void *) s;
  800cae:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cb1:	c9                   	leave  
  800cb2:	c3                   	ret    

00800cb3 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800cb3:	55                   	push   %ebp
  800cb4:	89 e5                	mov    %esp,%ebp
  800cb6:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800cb9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800cc0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cc7:	eb 03                	jmp    800ccc <strtol+0x19>
		s++;
  800cc9:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccf:	8a 00                	mov    (%eax),%al
  800cd1:	3c 20                	cmp    $0x20,%al
  800cd3:	74 f4                	je     800cc9 <strtol+0x16>
  800cd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd8:	8a 00                	mov    (%eax),%al
  800cda:	3c 09                	cmp    $0x9,%al
  800cdc:	74 eb                	je     800cc9 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800cde:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce1:	8a 00                	mov    (%eax),%al
  800ce3:	3c 2b                	cmp    $0x2b,%al
  800ce5:	75 05                	jne    800cec <strtol+0x39>
		s++;
  800ce7:	ff 45 08             	incl   0x8(%ebp)
  800cea:	eb 13                	jmp    800cff <strtol+0x4c>
	else if (*s == '-')
  800cec:	8b 45 08             	mov    0x8(%ebp),%eax
  800cef:	8a 00                	mov    (%eax),%al
  800cf1:	3c 2d                	cmp    $0x2d,%al
  800cf3:	75 0a                	jne    800cff <strtol+0x4c>
		s++, neg = 1;
  800cf5:	ff 45 08             	incl   0x8(%ebp)
  800cf8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d03:	74 06                	je     800d0b <strtol+0x58>
  800d05:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d09:	75 20                	jne    800d2b <strtol+0x78>
  800d0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0e:	8a 00                	mov    (%eax),%al
  800d10:	3c 30                	cmp    $0x30,%al
  800d12:	75 17                	jne    800d2b <strtol+0x78>
  800d14:	8b 45 08             	mov    0x8(%ebp),%eax
  800d17:	40                   	inc    %eax
  800d18:	8a 00                	mov    (%eax),%al
  800d1a:	3c 78                	cmp    $0x78,%al
  800d1c:	75 0d                	jne    800d2b <strtol+0x78>
		s += 2, base = 16;
  800d1e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d22:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d29:	eb 28                	jmp    800d53 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d2b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d2f:	75 15                	jne    800d46 <strtol+0x93>
  800d31:	8b 45 08             	mov    0x8(%ebp),%eax
  800d34:	8a 00                	mov    (%eax),%al
  800d36:	3c 30                	cmp    $0x30,%al
  800d38:	75 0c                	jne    800d46 <strtol+0x93>
		s++, base = 8;
  800d3a:	ff 45 08             	incl   0x8(%ebp)
  800d3d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d44:	eb 0d                	jmp    800d53 <strtol+0xa0>
	else if (base == 0)
  800d46:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d4a:	75 07                	jne    800d53 <strtol+0xa0>
		base = 10;
  800d4c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d53:	8b 45 08             	mov    0x8(%ebp),%eax
  800d56:	8a 00                	mov    (%eax),%al
  800d58:	3c 2f                	cmp    $0x2f,%al
  800d5a:	7e 19                	jle    800d75 <strtol+0xc2>
  800d5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5f:	8a 00                	mov    (%eax),%al
  800d61:	3c 39                	cmp    $0x39,%al
  800d63:	7f 10                	jg     800d75 <strtol+0xc2>
			dig = *s - '0';
  800d65:	8b 45 08             	mov    0x8(%ebp),%eax
  800d68:	8a 00                	mov    (%eax),%al
  800d6a:	0f be c0             	movsbl %al,%eax
  800d6d:	83 e8 30             	sub    $0x30,%eax
  800d70:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d73:	eb 42                	jmp    800db7 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d75:	8b 45 08             	mov    0x8(%ebp),%eax
  800d78:	8a 00                	mov    (%eax),%al
  800d7a:	3c 60                	cmp    $0x60,%al
  800d7c:	7e 19                	jle    800d97 <strtol+0xe4>
  800d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d81:	8a 00                	mov    (%eax),%al
  800d83:	3c 7a                	cmp    $0x7a,%al
  800d85:	7f 10                	jg     800d97 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d87:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8a:	8a 00                	mov    (%eax),%al
  800d8c:	0f be c0             	movsbl %al,%eax
  800d8f:	83 e8 57             	sub    $0x57,%eax
  800d92:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d95:	eb 20                	jmp    800db7 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d97:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9a:	8a 00                	mov    (%eax),%al
  800d9c:	3c 40                	cmp    $0x40,%al
  800d9e:	7e 39                	jle    800dd9 <strtol+0x126>
  800da0:	8b 45 08             	mov    0x8(%ebp),%eax
  800da3:	8a 00                	mov    (%eax),%al
  800da5:	3c 5a                	cmp    $0x5a,%al
  800da7:	7f 30                	jg     800dd9 <strtol+0x126>
			dig = *s - 'A' + 10;
  800da9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dac:	8a 00                	mov    (%eax),%al
  800dae:	0f be c0             	movsbl %al,%eax
  800db1:	83 e8 37             	sub    $0x37,%eax
  800db4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800db7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dba:	3b 45 10             	cmp    0x10(%ebp),%eax
  800dbd:	7d 19                	jge    800dd8 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800dbf:	ff 45 08             	incl   0x8(%ebp)
  800dc2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dc5:	0f af 45 10          	imul   0x10(%ebp),%eax
  800dc9:	89 c2                	mov    %eax,%edx
  800dcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dce:	01 d0                	add    %edx,%eax
  800dd0:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800dd3:	e9 7b ff ff ff       	jmp    800d53 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800dd8:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800dd9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ddd:	74 08                	je     800de7 <strtol+0x134>
		*endptr = (char *) s;
  800ddf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de2:	8b 55 08             	mov    0x8(%ebp),%edx
  800de5:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800de7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800deb:	74 07                	je     800df4 <strtol+0x141>
  800ded:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df0:	f7 d8                	neg    %eax
  800df2:	eb 03                	jmp    800df7 <strtol+0x144>
  800df4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800df7:	c9                   	leave  
  800df8:	c3                   	ret    

00800df9 <ltostr>:

void
ltostr(long value, char *str)
{
  800df9:	55                   	push   %ebp
  800dfa:	89 e5                	mov    %esp,%ebp
  800dfc:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800dff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e06:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e0d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e11:	79 13                	jns    800e26 <ltostr+0x2d>
	{
		neg = 1;
  800e13:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e20:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e23:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e26:	8b 45 08             	mov    0x8(%ebp),%eax
  800e29:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e2e:	99                   	cltd   
  800e2f:	f7 f9                	idiv   %ecx
  800e31:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e34:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e37:	8d 50 01             	lea    0x1(%eax),%edx
  800e3a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e3d:	89 c2                	mov    %eax,%edx
  800e3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e42:	01 d0                	add    %edx,%eax
  800e44:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e47:	83 c2 30             	add    $0x30,%edx
  800e4a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e4c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e4f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e54:	f7 e9                	imul   %ecx
  800e56:	c1 fa 02             	sar    $0x2,%edx
  800e59:	89 c8                	mov    %ecx,%eax
  800e5b:	c1 f8 1f             	sar    $0x1f,%eax
  800e5e:	29 c2                	sub    %eax,%edx
  800e60:	89 d0                	mov    %edx,%eax
  800e62:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e65:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e68:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e6d:	f7 e9                	imul   %ecx
  800e6f:	c1 fa 02             	sar    $0x2,%edx
  800e72:	89 c8                	mov    %ecx,%eax
  800e74:	c1 f8 1f             	sar    $0x1f,%eax
  800e77:	29 c2                	sub    %eax,%edx
  800e79:	89 d0                	mov    %edx,%eax
  800e7b:	c1 e0 02             	shl    $0x2,%eax
  800e7e:	01 d0                	add    %edx,%eax
  800e80:	01 c0                	add    %eax,%eax
  800e82:	29 c1                	sub    %eax,%ecx
  800e84:	89 ca                	mov    %ecx,%edx
  800e86:	85 d2                	test   %edx,%edx
  800e88:	75 9c                	jne    800e26 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e8a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e91:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e94:	48                   	dec    %eax
  800e95:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e98:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e9c:	74 3d                	je     800edb <ltostr+0xe2>
		start = 1 ;
  800e9e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800ea5:	eb 34                	jmp    800edb <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800ea7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800eaa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ead:	01 d0                	add    %edx,%eax
  800eaf:	8a 00                	mov    (%eax),%al
  800eb1:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800eb4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800eb7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eba:	01 c2                	add    %eax,%edx
  800ebc:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800ebf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec2:	01 c8                	add    %ecx,%eax
  800ec4:	8a 00                	mov    (%eax),%al
  800ec6:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800ec8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800ecb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ece:	01 c2                	add    %eax,%edx
  800ed0:	8a 45 eb             	mov    -0x15(%ebp),%al
  800ed3:	88 02                	mov    %al,(%edx)
		start++ ;
  800ed5:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800ed8:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800edb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ede:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ee1:	7c c4                	jl     800ea7 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800ee3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ee6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee9:	01 d0                	add    %edx,%eax
  800eeb:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800eee:	90                   	nop
  800eef:	c9                   	leave  
  800ef0:	c3                   	ret    

00800ef1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800ef1:	55                   	push   %ebp
  800ef2:	89 e5                	mov    %esp,%ebp
  800ef4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ef7:	ff 75 08             	pushl  0x8(%ebp)
  800efa:	e8 54 fa ff ff       	call   800953 <strlen>
  800eff:	83 c4 04             	add    $0x4,%esp
  800f02:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f05:	ff 75 0c             	pushl  0xc(%ebp)
  800f08:	e8 46 fa ff ff       	call   800953 <strlen>
  800f0d:	83 c4 04             	add    $0x4,%esp
  800f10:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f13:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f1a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f21:	eb 17                	jmp    800f3a <strcconcat+0x49>
		final[s] = str1[s] ;
  800f23:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f26:	8b 45 10             	mov    0x10(%ebp),%eax
  800f29:	01 c2                	add    %eax,%edx
  800f2b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f31:	01 c8                	add    %ecx,%eax
  800f33:	8a 00                	mov    (%eax),%al
  800f35:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f37:	ff 45 fc             	incl   -0x4(%ebp)
  800f3a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f3d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f40:	7c e1                	jl     800f23 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f42:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f49:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f50:	eb 1f                	jmp    800f71 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f52:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f55:	8d 50 01             	lea    0x1(%eax),%edx
  800f58:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f5b:	89 c2                	mov    %eax,%edx
  800f5d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f60:	01 c2                	add    %eax,%edx
  800f62:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f68:	01 c8                	add    %ecx,%eax
  800f6a:	8a 00                	mov    (%eax),%al
  800f6c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f6e:	ff 45 f8             	incl   -0x8(%ebp)
  800f71:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f74:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f77:	7c d9                	jl     800f52 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f79:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f7c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7f:	01 d0                	add    %edx,%eax
  800f81:	c6 00 00             	movb   $0x0,(%eax)
}
  800f84:	90                   	nop
  800f85:	c9                   	leave  
  800f86:	c3                   	ret    

00800f87 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f87:	55                   	push   %ebp
  800f88:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f8a:	8b 45 14             	mov    0x14(%ebp),%eax
  800f8d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f93:	8b 45 14             	mov    0x14(%ebp),%eax
  800f96:	8b 00                	mov    (%eax),%eax
  800f98:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f9f:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa2:	01 d0                	add    %edx,%eax
  800fa4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800faa:	eb 0c                	jmp    800fb8 <strsplit+0x31>
			*string++ = 0;
  800fac:	8b 45 08             	mov    0x8(%ebp),%eax
  800faf:	8d 50 01             	lea    0x1(%eax),%edx
  800fb2:	89 55 08             	mov    %edx,0x8(%ebp)
  800fb5:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	8a 00                	mov    (%eax),%al
  800fbd:	84 c0                	test   %al,%al
  800fbf:	74 18                	je     800fd9 <strsplit+0x52>
  800fc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc4:	8a 00                	mov    (%eax),%al
  800fc6:	0f be c0             	movsbl %al,%eax
  800fc9:	50                   	push   %eax
  800fca:	ff 75 0c             	pushl  0xc(%ebp)
  800fcd:	e8 13 fb ff ff       	call   800ae5 <strchr>
  800fd2:	83 c4 08             	add    $0x8,%esp
  800fd5:	85 c0                	test   %eax,%eax
  800fd7:	75 d3                	jne    800fac <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800fd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdc:	8a 00                	mov    (%eax),%al
  800fde:	84 c0                	test   %al,%al
  800fe0:	74 5a                	je     80103c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800fe2:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe5:	8b 00                	mov    (%eax),%eax
  800fe7:	83 f8 0f             	cmp    $0xf,%eax
  800fea:	75 07                	jne    800ff3 <strsplit+0x6c>
		{
			return 0;
  800fec:	b8 00 00 00 00       	mov    $0x0,%eax
  800ff1:	eb 66                	jmp    801059 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800ff3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff6:	8b 00                	mov    (%eax),%eax
  800ff8:	8d 48 01             	lea    0x1(%eax),%ecx
  800ffb:	8b 55 14             	mov    0x14(%ebp),%edx
  800ffe:	89 0a                	mov    %ecx,(%edx)
  801000:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801007:	8b 45 10             	mov    0x10(%ebp),%eax
  80100a:	01 c2                	add    %eax,%edx
  80100c:	8b 45 08             	mov    0x8(%ebp),%eax
  80100f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801011:	eb 03                	jmp    801016 <strsplit+0x8f>
			string++;
  801013:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801016:	8b 45 08             	mov    0x8(%ebp),%eax
  801019:	8a 00                	mov    (%eax),%al
  80101b:	84 c0                	test   %al,%al
  80101d:	74 8b                	je     800faa <strsplit+0x23>
  80101f:	8b 45 08             	mov    0x8(%ebp),%eax
  801022:	8a 00                	mov    (%eax),%al
  801024:	0f be c0             	movsbl %al,%eax
  801027:	50                   	push   %eax
  801028:	ff 75 0c             	pushl  0xc(%ebp)
  80102b:	e8 b5 fa ff ff       	call   800ae5 <strchr>
  801030:	83 c4 08             	add    $0x8,%esp
  801033:	85 c0                	test   %eax,%eax
  801035:	74 dc                	je     801013 <strsplit+0x8c>
			string++;
	}
  801037:	e9 6e ff ff ff       	jmp    800faa <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80103c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80103d:	8b 45 14             	mov    0x14(%ebp),%eax
  801040:	8b 00                	mov    (%eax),%eax
  801042:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801049:	8b 45 10             	mov    0x10(%ebp),%eax
  80104c:	01 d0                	add    %edx,%eax
  80104e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801054:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801059:	c9                   	leave  
  80105a:	c3                   	ret    

0080105b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80105b:	55                   	push   %ebp
  80105c:	89 e5                	mov    %esp,%ebp
  80105e:	57                   	push   %edi
  80105f:	56                   	push   %esi
  801060:	53                   	push   %ebx
  801061:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801064:	8b 45 08             	mov    0x8(%ebp),%eax
  801067:	8b 55 0c             	mov    0xc(%ebp),%edx
  80106a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80106d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801070:	8b 7d 18             	mov    0x18(%ebp),%edi
  801073:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801076:	cd 30                	int    $0x30
  801078:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80107b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80107e:	83 c4 10             	add    $0x10,%esp
  801081:	5b                   	pop    %ebx
  801082:	5e                   	pop    %esi
  801083:	5f                   	pop    %edi
  801084:	5d                   	pop    %ebp
  801085:	c3                   	ret    

00801086 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801086:	55                   	push   %ebp
  801087:	89 e5                	mov    %esp,%ebp
  801089:	83 ec 04             	sub    $0x4,%esp
  80108c:	8b 45 10             	mov    0x10(%ebp),%eax
  80108f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801092:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801096:	8b 45 08             	mov    0x8(%ebp),%eax
  801099:	6a 00                	push   $0x0
  80109b:	6a 00                	push   $0x0
  80109d:	52                   	push   %edx
  80109e:	ff 75 0c             	pushl  0xc(%ebp)
  8010a1:	50                   	push   %eax
  8010a2:	6a 00                	push   $0x0
  8010a4:	e8 b2 ff ff ff       	call   80105b <syscall>
  8010a9:	83 c4 18             	add    $0x18,%esp
}
  8010ac:	90                   	nop
  8010ad:	c9                   	leave  
  8010ae:	c3                   	ret    

008010af <sys_cgetc>:

int
sys_cgetc(void)
{
  8010af:	55                   	push   %ebp
  8010b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8010b2:	6a 00                	push   $0x0
  8010b4:	6a 00                	push   $0x0
  8010b6:	6a 00                	push   $0x0
  8010b8:	6a 00                	push   $0x0
  8010ba:	6a 00                	push   $0x0
  8010bc:	6a 01                	push   $0x1
  8010be:	e8 98 ff ff ff       	call   80105b <syscall>
  8010c3:	83 c4 18             	add    $0x18,%esp
}
  8010c6:	c9                   	leave  
  8010c7:	c3                   	ret    

008010c8 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8010c8:	55                   	push   %ebp
  8010c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8010cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ce:	6a 00                	push   $0x0
  8010d0:	6a 00                	push   $0x0
  8010d2:	6a 00                	push   $0x0
  8010d4:	6a 00                	push   $0x0
  8010d6:	50                   	push   %eax
  8010d7:	6a 05                	push   $0x5
  8010d9:	e8 7d ff ff ff       	call   80105b <syscall>
  8010de:	83 c4 18             	add    $0x18,%esp
}
  8010e1:	c9                   	leave  
  8010e2:	c3                   	ret    

008010e3 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010e3:	55                   	push   %ebp
  8010e4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010e6:	6a 00                	push   $0x0
  8010e8:	6a 00                	push   $0x0
  8010ea:	6a 00                	push   $0x0
  8010ec:	6a 00                	push   $0x0
  8010ee:	6a 00                	push   $0x0
  8010f0:	6a 02                	push   $0x2
  8010f2:	e8 64 ff ff ff       	call   80105b <syscall>
  8010f7:	83 c4 18             	add    $0x18,%esp
}
  8010fa:	c9                   	leave  
  8010fb:	c3                   	ret    

008010fc <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010fc:	55                   	push   %ebp
  8010fd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010ff:	6a 00                	push   $0x0
  801101:	6a 00                	push   $0x0
  801103:	6a 00                	push   $0x0
  801105:	6a 00                	push   $0x0
  801107:	6a 00                	push   $0x0
  801109:	6a 03                	push   $0x3
  80110b:	e8 4b ff ff ff       	call   80105b <syscall>
  801110:	83 c4 18             	add    $0x18,%esp
}
  801113:	c9                   	leave  
  801114:	c3                   	ret    

00801115 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801115:	55                   	push   %ebp
  801116:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801118:	6a 00                	push   $0x0
  80111a:	6a 00                	push   $0x0
  80111c:	6a 00                	push   $0x0
  80111e:	6a 00                	push   $0x0
  801120:	6a 00                	push   $0x0
  801122:	6a 04                	push   $0x4
  801124:	e8 32 ff ff ff       	call   80105b <syscall>
  801129:	83 c4 18             	add    $0x18,%esp
}
  80112c:	c9                   	leave  
  80112d:	c3                   	ret    

0080112e <sys_env_exit>:


void sys_env_exit(void)
{
  80112e:	55                   	push   %ebp
  80112f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801131:	6a 00                	push   $0x0
  801133:	6a 00                	push   $0x0
  801135:	6a 00                	push   $0x0
  801137:	6a 00                	push   $0x0
  801139:	6a 00                	push   $0x0
  80113b:	6a 06                	push   $0x6
  80113d:	e8 19 ff ff ff       	call   80105b <syscall>
  801142:	83 c4 18             	add    $0x18,%esp
}
  801145:	90                   	nop
  801146:	c9                   	leave  
  801147:	c3                   	ret    

00801148 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801148:	55                   	push   %ebp
  801149:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80114b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80114e:	8b 45 08             	mov    0x8(%ebp),%eax
  801151:	6a 00                	push   $0x0
  801153:	6a 00                	push   $0x0
  801155:	6a 00                	push   $0x0
  801157:	52                   	push   %edx
  801158:	50                   	push   %eax
  801159:	6a 07                	push   $0x7
  80115b:	e8 fb fe ff ff       	call   80105b <syscall>
  801160:	83 c4 18             	add    $0x18,%esp
}
  801163:	c9                   	leave  
  801164:	c3                   	ret    

00801165 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801165:	55                   	push   %ebp
  801166:	89 e5                	mov    %esp,%ebp
  801168:	56                   	push   %esi
  801169:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80116a:	8b 75 18             	mov    0x18(%ebp),%esi
  80116d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801170:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801173:	8b 55 0c             	mov    0xc(%ebp),%edx
  801176:	8b 45 08             	mov    0x8(%ebp),%eax
  801179:	56                   	push   %esi
  80117a:	53                   	push   %ebx
  80117b:	51                   	push   %ecx
  80117c:	52                   	push   %edx
  80117d:	50                   	push   %eax
  80117e:	6a 08                	push   $0x8
  801180:	e8 d6 fe ff ff       	call   80105b <syscall>
  801185:	83 c4 18             	add    $0x18,%esp
}
  801188:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80118b:	5b                   	pop    %ebx
  80118c:	5e                   	pop    %esi
  80118d:	5d                   	pop    %ebp
  80118e:	c3                   	ret    

0080118f <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80118f:	55                   	push   %ebp
  801190:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801192:	8b 55 0c             	mov    0xc(%ebp),%edx
  801195:	8b 45 08             	mov    0x8(%ebp),%eax
  801198:	6a 00                	push   $0x0
  80119a:	6a 00                	push   $0x0
  80119c:	6a 00                	push   $0x0
  80119e:	52                   	push   %edx
  80119f:	50                   	push   %eax
  8011a0:	6a 09                	push   $0x9
  8011a2:	e8 b4 fe ff ff       	call   80105b <syscall>
  8011a7:	83 c4 18             	add    $0x18,%esp
}
  8011aa:	c9                   	leave  
  8011ab:	c3                   	ret    

008011ac <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8011ac:	55                   	push   %ebp
  8011ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8011af:	6a 00                	push   $0x0
  8011b1:	6a 00                	push   $0x0
  8011b3:	6a 00                	push   $0x0
  8011b5:	ff 75 0c             	pushl  0xc(%ebp)
  8011b8:	ff 75 08             	pushl  0x8(%ebp)
  8011bb:	6a 0a                	push   $0xa
  8011bd:	e8 99 fe ff ff       	call   80105b <syscall>
  8011c2:	83 c4 18             	add    $0x18,%esp
}
  8011c5:	c9                   	leave  
  8011c6:	c3                   	ret    

008011c7 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8011c7:	55                   	push   %ebp
  8011c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8011ca:	6a 00                	push   $0x0
  8011cc:	6a 00                	push   $0x0
  8011ce:	6a 00                	push   $0x0
  8011d0:	6a 00                	push   $0x0
  8011d2:	6a 00                	push   $0x0
  8011d4:	6a 0b                	push   $0xb
  8011d6:	e8 80 fe ff ff       	call   80105b <syscall>
  8011db:	83 c4 18             	add    $0x18,%esp
}
  8011de:	c9                   	leave  
  8011df:	c3                   	ret    

008011e0 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011e0:	55                   	push   %ebp
  8011e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011e3:	6a 00                	push   $0x0
  8011e5:	6a 00                	push   $0x0
  8011e7:	6a 00                	push   $0x0
  8011e9:	6a 00                	push   $0x0
  8011eb:	6a 00                	push   $0x0
  8011ed:	6a 0c                	push   $0xc
  8011ef:	e8 67 fe ff ff       	call   80105b <syscall>
  8011f4:	83 c4 18             	add    $0x18,%esp
}
  8011f7:	c9                   	leave  
  8011f8:	c3                   	ret    

008011f9 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011f9:	55                   	push   %ebp
  8011fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011fc:	6a 00                	push   $0x0
  8011fe:	6a 00                	push   $0x0
  801200:	6a 00                	push   $0x0
  801202:	6a 00                	push   $0x0
  801204:	6a 00                	push   $0x0
  801206:	6a 0d                	push   $0xd
  801208:	e8 4e fe ff ff       	call   80105b <syscall>
  80120d:	83 c4 18             	add    $0x18,%esp
}
  801210:	c9                   	leave  
  801211:	c3                   	ret    

00801212 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801212:	55                   	push   %ebp
  801213:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801215:	6a 00                	push   $0x0
  801217:	6a 00                	push   $0x0
  801219:	6a 00                	push   $0x0
  80121b:	ff 75 0c             	pushl  0xc(%ebp)
  80121e:	ff 75 08             	pushl  0x8(%ebp)
  801221:	6a 11                	push   $0x11
  801223:	e8 33 fe ff ff       	call   80105b <syscall>
  801228:	83 c4 18             	add    $0x18,%esp
	return;
  80122b:	90                   	nop
}
  80122c:	c9                   	leave  
  80122d:	c3                   	ret    

0080122e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80122e:	55                   	push   %ebp
  80122f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801231:	6a 00                	push   $0x0
  801233:	6a 00                	push   $0x0
  801235:	6a 00                	push   $0x0
  801237:	ff 75 0c             	pushl  0xc(%ebp)
  80123a:	ff 75 08             	pushl  0x8(%ebp)
  80123d:	6a 12                	push   $0x12
  80123f:	e8 17 fe ff ff       	call   80105b <syscall>
  801244:	83 c4 18             	add    $0x18,%esp
	return ;
  801247:	90                   	nop
}
  801248:	c9                   	leave  
  801249:	c3                   	ret    

0080124a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80124a:	55                   	push   %ebp
  80124b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80124d:	6a 00                	push   $0x0
  80124f:	6a 00                	push   $0x0
  801251:	6a 00                	push   $0x0
  801253:	6a 00                	push   $0x0
  801255:	6a 00                	push   $0x0
  801257:	6a 0e                	push   $0xe
  801259:	e8 fd fd ff ff       	call   80105b <syscall>
  80125e:	83 c4 18             	add    $0x18,%esp
}
  801261:	c9                   	leave  
  801262:	c3                   	ret    

00801263 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801263:	55                   	push   %ebp
  801264:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801266:	6a 00                	push   $0x0
  801268:	6a 00                	push   $0x0
  80126a:	6a 00                	push   $0x0
  80126c:	6a 00                	push   $0x0
  80126e:	ff 75 08             	pushl  0x8(%ebp)
  801271:	6a 0f                	push   $0xf
  801273:	e8 e3 fd ff ff       	call   80105b <syscall>
  801278:	83 c4 18             	add    $0x18,%esp
}
  80127b:	c9                   	leave  
  80127c:	c3                   	ret    

0080127d <sys_scarce_memory>:

void sys_scarce_memory()
{
  80127d:	55                   	push   %ebp
  80127e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801280:	6a 00                	push   $0x0
  801282:	6a 00                	push   $0x0
  801284:	6a 00                	push   $0x0
  801286:	6a 00                	push   $0x0
  801288:	6a 00                	push   $0x0
  80128a:	6a 10                	push   $0x10
  80128c:	e8 ca fd ff ff       	call   80105b <syscall>
  801291:	83 c4 18             	add    $0x18,%esp
}
  801294:	90                   	nop
  801295:	c9                   	leave  
  801296:	c3                   	ret    

00801297 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801297:	55                   	push   %ebp
  801298:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80129a:	6a 00                	push   $0x0
  80129c:	6a 00                	push   $0x0
  80129e:	6a 00                	push   $0x0
  8012a0:	6a 00                	push   $0x0
  8012a2:	6a 00                	push   $0x0
  8012a4:	6a 14                	push   $0x14
  8012a6:	e8 b0 fd ff ff       	call   80105b <syscall>
  8012ab:	83 c4 18             	add    $0x18,%esp
}
  8012ae:	90                   	nop
  8012af:	c9                   	leave  
  8012b0:	c3                   	ret    

008012b1 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8012b1:	55                   	push   %ebp
  8012b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 00                	push   $0x0
  8012b8:	6a 00                	push   $0x0
  8012ba:	6a 00                	push   $0x0
  8012bc:	6a 00                	push   $0x0
  8012be:	6a 15                	push   $0x15
  8012c0:	e8 96 fd ff ff       	call   80105b <syscall>
  8012c5:	83 c4 18             	add    $0x18,%esp
}
  8012c8:	90                   	nop
  8012c9:	c9                   	leave  
  8012ca:	c3                   	ret    

008012cb <sys_cputc>:


void
sys_cputc(const char c)
{
  8012cb:	55                   	push   %ebp
  8012cc:	89 e5                	mov    %esp,%ebp
  8012ce:	83 ec 04             	sub    $0x4,%esp
  8012d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8012d7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8012db:	6a 00                	push   $0x0
  8012dd:	6a 00                	push   $0x0
  8012df:	6a 00                	push   $0x0
  8012e1:	6a 00                	push   $0x0
  8012e3:	50                   	push   %eax
  8012e4:	6a 16                	push   $0x16
  8012e6:	e8 70 fd ff ff       	call   80105b <syscall>
  8012eb:	83 c4 18             	add    $0x18,%esp
}
  8012ee:	90                   	nop
  8012ef:	c9                   	leave  
  8012f0:	c3                   	ret    

008012f1 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012f1:	55                   	push   %ebp
  8012f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012f4:	6a 00                	push   $0x0
  8012f6:	6a 00                	push   $0x0
  8012f8:	6a 00                	push   $0x0
  8012fa:	6a 00                	push   $0x0
  8012fc:	6a 00                	push   $0x0
  8012fe:	6a 17                	push   $0x17
  801300:	e8 56 fd ff ff       	call   80105b <syscall>
  801305:	83 c4 18             	add    $0x18,%esp
}
  801308:	90                   	nop
  801309:	c9                   	leave  
  80130a:	c3                   	ret    

0080130b <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80130b:	55                   	push   %ebp
  80130c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80130e:	8b 45 08             	mov    0x8(%ebp),%eax
  801311:	6a 00                	push   $0x0
  801313:	6a 00                	push   $0x0
  801315:	6a 00                	push   $0x0
  801317:	ff 75 0c             	pushl  0xc(%ebp)
  80131a:	50                   	push   %eax
  80131b:	6a 18                	push   $0x18
  80131d:	e8 39 fd ff ff       	call   80105b <syscall>
  801322:	83 c4 18             	add    $0x18,%esp
}
  801325:	c9                   	leave  
  801326:	c3                   	ret    

00801327 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801327:	55                   	push   %ebp
  801328:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80132a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80132d:	8b 45 08             	mov    0x8(%ebp),%eax
  801330:	6a 00                	push   $0x0
  801332:	6a 00                	push   $0x0
  801334:	6a 00                	push   $0x0
  801336:	52                   	push   %edx
  801337:	50                   	push   %eax
  801338:	6a 1b                	push   $0x1b
  80133a:	e8 1c fd ff ff       	call   80105b <syscall>
  80133f:	83 c4 18             	add    $0x18,%esp
}
  801342:	c9                   	leave  
  801343:	c3                   	ret    

00801344 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801344:	55                   	push   %ebp
  801345:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801347:	8b 55 0c             	mov    0xc(%ebp),%edx
  80134a:	8b 45 08             	mov    0x8(%ebp),%eax
  80134d:	6a 00                	push   $0x0
  80134f:	6a 00                	push   $0x0
  801351:	6a 00                	push   $0x0
  801353:	52                   	push   %edx
  801354:	50                   	push   %eax
  801355:	6a 19                	push   $0x19
  801357:	e8 ff fc ff ff       	call   80105b <syscall>
  80135c:	83 c4 18             	add    $0x18,%esp
}
  80135f:	90                   	nop
  801360:	c9                   	leave  
  801361:	c3                   	ret    

00801362 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801362:	55                   	push   %ebp
  801363:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801365:	8b 55 0c             	mov    0xc(%ebp),%edx
  801368:	8b 45 08             	mov    0x8(%ebp),%eax
  80136b:	6a 00                	push   $0x0
  80136d:	6a 00                	push   $0x0
  80136f:	6a 00                	push   $0x0
  801371:	52                   	push   %edx
  801372:	50                   	push   %eax
  801373:	6a 1a                	push   $0x1a
  801375:	e8 e1 fc ff ff       	call   80105b <syscall>
  80137a:	83 c4 18             	add    $0x18,%esp
}
  80137d:	90                   	nop
  80137e:	c9                   	leave  
  80137f:	c3                   	ret    

00801380 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801380:	55                   	push   %ebp
  801381:	89 e5                	mov    %esp,%ebp
  801383:	83 ec 04             	sub    $0x4,%esp
  801386:	8b 45 10             	mov    0x10(%ebp),%eax
  801389:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80138c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80138f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801393:	8b 45 08             	mov    0x8(%ebp),%eax
  801396:	6a 00                	push   $0x0
  801398:	51                   	push   %ecx
  801399:	52                   	push   %edx
  80139a:	ff 75 0c             	pushl  0xc(%ebp)
  80139d:	50                   	push   %eax
  80139e:	6a 1c                	push   $0x1c
  8013a0:	e8 b6 fc ff ff       	call   80105b <syscall>
  8013a5:	83 c4 18             	add    $0x18,%esp
}
  8013a8:	c9                   	leave  
  8013a9:	c3                   	ret    

008013aa <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8013aa:	55                   	push   %ebp
  8013ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8013ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b3:	6a 00                	push   $0x0
  8013b5:	6a 00                	push   $0x0
  8013b7:	6a 00                	push   $0x0
  8013b9:	52                   	push   %edx
  8013ba:	50                   	push   %eax
  8013bb:	6a 1d                	push   $0x1d
  8013bd:	e8 99 fc ff ff       	call   80105b <syscall>
  8013c2:	83 c4 18             	add    $0x18,%esp
}
  8013c5:	c9                   	leave  
  8013c6:	c3                   	ret    

008013c7 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8013c7:	55                   	push   %ebp
  8013c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8013ca:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d3:	6a 00                	push   $0x0
  8013d5:	6a 00                	push   $0x0
  8013d7:	51                   	push   %ecx
  8013d8:	52                   	push   %edx
  8013d9:	50                   	push   %eax
  8013da:	6a 1e                	push   $0x1e
  8013dc:	e8 7a fc ff ff       	call   80105b <syscall>
  8013e1:	83 c4 18             	add    $0x18,%esp
}
  8013e4:	c9                   	leave  
  8013e5:	c3                   	ret    

008013e6 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013e6:	55                   	push   %ebp
  8013e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ef:	6a 00                	push   $0x0
  8013f1:	6a 00                	push   $0x0
  8013f3:	6a 00                	push   $0x0
  8013f5:	52                   	push   %edx
  8013f6:	50                   	push   %eax
  8013f7:	6a 1f                	push   $0x1f
  8013f9:	e8 5d fc ff ff       	call   80105b <syscall>
  8013fe:	83 c4 18             	add    $0x18,%esp
}
  801401:	c9                   	leave  
  801402:	c3                   	ret    

00801403 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801403:	55                   	push   %ebp
  801404:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801406:	6a 00                	push   $0x0
  801408:	6a 00                	push   $0x0
  80140a:	6a 00                	push   $0x0
  80140c:	6a 00                	push   $0x0
  80140e:	6a 00                	push   $0x0
  801410:	6a 20                	push   $0x20
  801412:	e8 44 fc ff ff       	call   80105b <syscall>
  801417:	83 c4 18             	add    $0x18,%esp
}
  80141a:	c9                   	leave  
  80141b:	c3                   	ret    

0080141c <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80141c:	55                   	push   %ebp
  80141d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80141f:	8b 45 08             	mov    0x8(%ebp),%eax
  801422:	6a 00                	push   $0x0
  801424:	ff 75 14             	pushl  0x14(%ebp)
  801427:	ff 75 10             	pushl  0x10(%ebp)
  80142a:	ff 75 0c             	pushl  0xc(%ebp)
  80142d:	50                   	push   %eax
  80142e:	6a 21                	push   $0x21
  801430:	e8 26 fc ff ff       	call   80105b <syscall>
  801435:	83 c4 18             	add    $0x18,%esp
}
  801438:	c9                   	leave  
  801439:	c3                   	ret    

0080143a <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80143a:	55                   	push   %ebp
  80143b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80143d:	8b 45 08             	mov    0x8(%ebp),%eax
  801440:	6a 00                	push   $0x0
  801442:	6a 00                	push   $0x0
  801444:	6a 00                	push   $0x0
  801446:	6a 00                	push   $0x0
  801448:	50                   	push   %eax
  801449:	6a 22                	push   $0x22
  80144b:	e8 0b fc ff ff       	call   80105b <syscall>
  801450:	83 c4 18             	add    $0x18,%esp
}
  801453:	90                   	nop
  801454:	c9                   	leave  
  801455:	c3                   	ret    

00801456 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801456:	55                   	push   %ebp
  801457:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801459:	8b 45 08             	mov    0x8(%ebp),%eax
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	6a 00                	push   $0x0
  801462:	6a 00                	push   $0x0
  801464:	50                   	push   %eax
  801465:	6a 23                	push   $0x23
  801467:	e8 ef fb ff ff       	call   80105b <syscall>
  80146c:	83 c4 18             	add    $0x18,%esp
}
  80146f:	90                   	nop
  801470:	c9                   	leave  
  801471:	c3                   	ret    

00801472 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801472:	55                   	push   %ebp
  801473:	89 e5                	mov    %esp,%ebp
  801475:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801478:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80147b:	8d 50 04             	lea    0x4(%eax),%edx
  80147e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801481:	6a 00                	push   $0x0
  801483:	6a 00                	push   $0x0
  801485:	6a 00                	push   $0x0
  801487:	52                   	push   %edx
  801488:	50                   	push   %eax
  801489:	6a 24                	push   $0x24
  80148b:	e8 cb fb ff ff       	call   80105b <syscall>
  801490:	83 c4 18             	add    $0x18,%esp
	return result;
  801493:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801496:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801499:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80149c:	89 01                	mov    %eax,(%ecx)
  80149e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8014a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a4:	c9                   	leave  
  8014a5:	c2 04 00             	ret    $0x4

008014a8 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8014a8:	55                   	push   %ebp
  8014a9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8014ab:	6a 00                	push   $0x0
  8014ad:	6a 00                	push   $0x0
  8014af:	ff 75 10             	pushl  0x10(%ebp)
  8014b2:	ff 75 0c             	pushl  0xc(%ebp)
  8014b5:	ff 75 08             	pushl  0x8(%ebp)
  8014b8:	6a 13                	push   $0x13
  8014ba:	e8 9c fb ff ff       	call   80105b <syscall>
  8014bf:	83 c4 18             	add    $0x18,%esp
	return ;
  8014c2:	90                   	nop
}
  8014c3:	c9                   	leave  
  8014c4:	c3                   	ret    

008014c5 <sys_rcr2>:
uint32 sys_rcr2()
{
  8014c5:	55                   	push   %ebp
  8014c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 25                	push   $0x25
  8014d4:	e8 82 fb ff ff       	call   80105b <syscall>
  8014d9:	83 c4 18             	add    $0x18,%esp
}
  8014dc:	c9                   	leave  
  8014dd:	c3                   	ret    

008014de <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8014de:	55                   	push   %ebp
  8014df:	89 e5                	mov    %esp,%ebp
  8014e1:	83 ec 04             	sub    $0x4,%esp
  8014e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014ea:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014ee:	6a 00                	push   $0x0
  8014f0:	6a 00                	push   $0x0
  8014f2:	6a 00                	push   $0x0
  8014f4:	6a 00                	push   $0x0
  8014f6:	50                   	push   %eax
  8014f7:	6a 26                	push   $0x26
  8014f9:	e8 5d fb ff ff       	call   80105b <syscall>
  8014fe:	83 c4 18             	add    $0x18,%esp
	return ;
  801501:	90                   	nop
}
  801502:	c9                   	leave  
  801503:	c3                   	ret    

00801504 <rsttst>:
void rsttst()
{
  801504:	55                   	push   %ebp
  801505:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801507:	6a 00                	push   $0x0
  801509:	6a 00                	push   $0x0
  80150b:	6a 00                	push   $0x0
  80150d:	6a 00                	push   $0x0
  80150f:	6a 00                	push   $0x0
  801511:	6a 28                	push   $0x28
  801513:	e8 43 fb ff ff       	call   80105b <syscall>
  801518:	83 c4 18             	add    $0x18,%esp
	return ;
  80151b:	90                   	nop
}
  80151c:	c9                   	leave  
  80151d:	c3                   	ret    

0080151e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80151e:	55                   	push   %ebp
  80151f:	89 e5                	mov    %esp,%ebp
  801521:	83 ec 04             	sub    $0x4,%esp
  801524:	8b 45 14             	mov    0x14(%ebp),%eax
  801527:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80152a:	8b 55 18             	mov    0x18(%ebp),%edx
  80152d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801531:	52                   	push   %edx
  801532:	50                   	push   %eax
  801533:	ff 75 10             	pushl  0x10(%ebp)
  801536:	ff 75 0c             	pushl  0xc(%ebp)
  801539:	ff 75 08             	pushl  0x8(%ebp)
  80153c:	6a 27                	push   $0x27
  80153e:	e8 18 fb ff ff       	call   80105b <syscall>
  801543:	83 c4 18             	add    $0x18,%esp
	return ;
  801546:	90                   	nop
}
  801547:	c9                   	leave  
  801548:	c3                   	ret    

00801549 <chktst>:
void chktst(uint32 n)
{
  801549:	55                   	push   %ebp
  80154a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 00                	push   $0x0
  801552:	6a 00                	push   $0x0
  801554:	ff 75 08             	pushl  0x8(%ebp)
  801557:	6a 29                	push   $0x29
  801559:	e8 fd fa ff ff       	call   80105b <syscall>
  80155e:	83 c4 18             	add    $0x18,%esp
	return ;
  801561:	90                   	nop
}
  801562:	c9                   	leave  
  801563:	c3                   	ret    

00801564 <inctst>:

void inctst()
{
  801564:	55                   	push   %ebp
  801565:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801567:	6a 00                	push   $0x0
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	6a 00                	push   $0x0
  801571:	6a 2a                	push   $0x2a
  801573:	e8 e3 fa ff ff       	call   80105b <syscall>
  801578:	83 c4 18             	add    $0x18,%esp
	return ;
  80157b:	90                   	nop
}
  80157c:	c9                   	leave  
  80157d:	c3                   	ret    

0080157e <gettst>:
uint32 gettst()
{
  80157e:	55                   	push   %ebp
  80157f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 2b                	push   $0x2b
  80158d:	e8 c9 fa ff ff       	call   80105b <syscall>
  801592:	83 c4 18             	add    $0x18,%esp
}
  801595:	c9                   	leave  
  801596:	c3                   	ret    

00801597 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801597:	55                   	push   %ebp
  801598:	89 e5                	mov    %esp,%ebp
  80159a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80159d:	6a 00                	push   $0x0
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 00                	push   $0x0
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 2c                	push   $0x2c
  8015a9:	e8 ad fa ff ff       	call   80105b <syscall>
  8015ae:	83 c4 18             	add    $0x18,%esp
  8015b1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8015b4:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8015b8:	75 07                	jne    8015c1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8015ba:	b8 01 00 00 00       	mov    $0x1,%eax
  8015bf:	eb 05                	jmp    8015c6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8015c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015c6:	c9                   	leave  
  8015c7:	c3                   	ret    

008015c8 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8015c8:	55                   	push   %ebp
  8015c9:	89 e5                	mov    %esp,%ebp
  8015cb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015ce:	6a 00                	push   $0x0
  8015d0:	6a 00                	push   $0x0
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 00                	push   $0x0
  8015d6:	6a 00                	push   $0x0
  8015d8:	6a 2c                	push   $0x2c
  8015da:	e8 7c fa ff ff       	call   80105b <syscall>
  8015df:	83 c4 18             	add    $0x18,%esp
  8015e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015e5:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015e9:	75 07                	jne    8015f2 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015eb:	b8 01 00 00 00       	mov    $0x1,%eax
  8015f0:	eb 05                	jmp    8015f7 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015f7:	c9                   	leave  
  8015f8:	c3                   	ret    

008015f9 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015f9:	55                   	push   %ebp
  8015fa:	89 e5                	mov    %esp,%ebp
  8015fc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015ff:	6a 00                	push   $0x0
  801601:	6a 00                	push   $0x0
  801603:	6a 00                	push   $0x0
  801605:	6a 00                	push   $0x0
  801607:	6a 00                	push   $0x0
  801609:	6a 2c                	push   $0x2c
  80160b:	e8 4b fa ff ff       	call   80105b <syscall>
  801610:	83 c4 18             	add    $0x18,%esp
  801613:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801616:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80161a:	75 07                	jne    801623 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80161c:	b8 01 00 00 00       	mov    $0x1,%eax
  801621:	eb 05                	jmp    801628 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801623:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801628:	c9                   	leave  
  801629:	c3                   	ret    

0080162a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80162a:	55                   	push   %ebp
  80162b:	89 e5                	mov    %esp,%ebp
  80162d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801630:	6a 00                	push   $0x0
  801632:	6a 00                	push   $0x0
  801634:	6a 00                	push   $0x0
  801636:	6a 00                	push   $0x0
  801638:	6a 00                	push   $0x0
  80163a:	6a 2c                	push   $0x2c
  80163c:	e8 1a fa ff ff       	call   80105b <syscall>
  801641:	83 c4 18             	add    $0x18,%esp
  801644:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801647:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80164b:	75 07                	jne    801654 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80164d:	b8 01 00 00 00       	mov    $0x1,%eax
  801652:	eb 05                	jmp    801659 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801654:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801659:	c9                   	leave  
  80165a:	c3                   	ret    

0080165b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80165b:	55                   	push   %ebp
  80165c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	ff 75 08             	pushl  0x8(%ebp)
  801669:	6a 2d                	push   $0x2d
  80166b:	e8 eb f9 ff ff       	call   80105b <syscall>
  801670:	83 c4 18             	add    $0x18,%esp
	return ;
  801673:	90                   	nop
}
  801674:	c9                   	leave  
  801675:	c3                   	ret    

00801676 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801676:	55                   	push   %ebp
  801677:	89 e5                	mov    %esp,%ebp
  801679:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80167a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80167d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801680:	8b 55 0c             	mov    0xc(%ebp),%edx
  801683:	8b 45 08             	mov    0x8(%ebp),%eax
  801686:	6a 00                	push   $0x0
  801688:	53                   	push   %ebx
  801689:	51                   	push   %ecx
  80168a:	52                   	push   %edx
  80168b:	50                   	push   %eax
  80168c:	6a 2e                	push   $0x2e
  80168e:	e8 c8 f9 ff ff       	call   80105b <syscall>
  801693:	83 c4 18             	add    $0x18,%esp
}
  801696:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801699:	c9                   	leave  
  80169a:	c3                   	ret    

0080169b <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80169b:	55                   	push   %ebp
  80169c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80169e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a4:	6a 00                	push   $0x0
  8016a6:	6a 00                	push   $0x0
  8016a8:	6a 00                	push   $0x0
  8016aa:	52                   	push   %edx
  8016ab:	50                   	push   %eax
  8016ac:	6a 2f                	push   $0x2f
  8016ae:	e8 a8 f9 ff ff       	call   80105b <syscall>
  8016b3:	83 c4 18             	add    $0x18,%esp
}
  8016b6:	c9                   	leave  
  8016b7:	c3                   	ret    

008016b8 <__udivdi3>:
  8016b8:	55                   	push   %ebp
  8016b9:	57                   	push   %edi
  8016ba:	56                   	push   %esi
  8016bb:	53                   	push   %ebx
  8016bc:	83 ec 1c             	sub    $0x1c,%esp
  8016bf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8016c3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8016c7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016cb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8016cf:	89 ca                	mov    %ecx,%edx
  8016d1:	89 f8                	mov    %edi,%eax
  8016d3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8016d7:	85 f6                	test   %esi,%esi
  8016d9:	75 2d                	jne    801708 <__udivdi3+0x50>
  8016db:	39 cf                	cmp    %ecx,%edi
  8016dd:	77 65                	ja     801744 <__udivdi3+0x8c>
  8016df:	89 fd                	mov    %edi,%ebp
  8016e1:	85 ff                	test   %edi,%edi
  8016e3:	75 0b                	jne    8016f0 <__udivdi3+0x38>
  8016e5:	b8 01 00 00 00       	mov    $0x1,%eax
  8016ea:	31 d2                	xor    %edx,%edx
  8016ec:	f7 f7                	div    %edi
  8016ee:	89 c5                	mov    %eax,%ebp
  8016f0:	31 d2                	xor    %edx,%edx
  8016f2:	89 c8                	mov    %ecx,%eax
  8016f4:	f7 f5                	div    %ebp
  8016f6:	89 c1                	mov    %eax,%ecx
  8016f8:	89 d8                	mov    %ebx,%eax
  8016fa:	f7 f5                	div    %ebp
  8016fc:	89 cf                	mov    %ecx,%edi
  8016fe:	89 fa                	mov    %edi,%edx
  801700:	83 c4 1c             	add    $0x1c,%esp
  801703:	5b                   	pop    %ebx
  801704:	5e                   	pop    %esi
  801705:	5f                   	pop    %edi
  801706:	5d                   	pop    %ebp
  801707:	c3                   	ret    
  801708:	39 ce                	cmp    %ecx,%esi
  80170a:	77 28                	ja     801734 <__udivdi3+0x7c>
  80170c:	0f bd fe             	bsr    %esi,%edi
  80170f:	83 f7 1f             	xor    $0x1f,%edi
  801712:	75 40                	jne    801754 <__udivdi3+0x9c>
  801714:	39 ce                	cmp    %ecx,%esi
  801716:	72 0a                	jb     801722 <__udivdi3+0x6a>
  801718:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80171c:	0f 87 9e 00 00 00    	ja     8017c0 <__udivdi3+0x108>
  801722:	b8 01 00 00 00       	mov    $0x1,%eax
  801727:	89 fa                	mov    %edi,%edx
  801729:	83 c4 1c             	add    $0x1c,%esp
  80172c:	5b                   	pop    %ebx
  80172d:	5e                   	pop    %esi
  80172e:	5f                   	pop    %edi
  80172f:	5d                   	pop    %ebp
  801730:	c3                   	ret    
  801731:	8d 76 00             	lea    0x0(%esi),%esi
  801734:	31 ff                	xor    %edi,%edi
  801736:	31 c0                	xor    %eax,%eax
  801738:	89 fa                	mov    %edi,%edx
  80173a:	83 c4 1c             	add    $0x1c,%esp
  80173d:	5b                   	pop    %ebx
  80173e:	5e                   	pop    %esi
  80173f:	5f                   	pop    %edi
  801740:	5d                   	pop    %ebp
  801741:	c3                   	ret    
  801742:	66 90                	xchg   %ax,%ax
  801744:	89 d8                	mov    %ebx,%eax
  801746:	f7 f7                	div    %edi
  801748:	31 ff                	xor    %edi,%edi
  80174a:	89 fa                	mov    %edi,%edx
  80174c:	83 c4 1c             	add    $0x1c,%esp
  80174f:	5b                   	pop    %ebx
  801750:	5e                   	pop    %esi
  801751:	5f                   	pop    %edi
  801752:	5d                   	pop    %ebp
  801753:	c3                   	ret    
  801754:	bd 20 00 00 00       	mov    $0x20,%ebp
  801759:	89 eb                	mov    %ebp,%ebx
  80175b:	29 fb                	sub    %edi,%ebx
  80175d:	89 f9                	mov    %edi,%ecx
  80175f:	d3 e6                	shl    %cl,%esi
  801761:	89 c5                	mov    %eax,%ebp
  801763:	88 d9                	mov    %bl,%cl
  801765:	d3 ed                	shr    %cl,%ebp
  801767:	89 e9                	mov    %ebp,%ecx
  801769:	09 f1                	or     %esi,%ecx
  80176b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80176f:	89 f9                	mov    %edi,%ecx
  801771:	d3 e0                	shl    %cl,%eax
  801773:	89 c5                	mov    %eax,%ebp
  801775:	89 d6                	mov    %edx,%esi
  801777:	88 d9                	mov    %bl,%cl
  801779:	d3 ee                	shr    %cl,%esi
  80177b:	89 f9                	mov    %edi,%ecx
  80177d:	d3 e2                	shl    %cl,%edx
  80177f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801783:	88 d9                	mov    %bl,%cl
  801785:	d3 e8                	shr    %cl,%eax
  801787:	09 c2                	or     %eax,%edx
  801789:	89 d0                	mov    %edx,%eax
  80178b:	89 f2                	mov    %esi,%edx
  80178d:	f7 74 24 0c          	divl   0xc(%esp)
  801791:	89 d6                	mov    %edx,%esi
  801793:	89 c3                	mov    %eax,%ebx
  801795:	f7 e5                	mul    %ebp
  801797:	39 d6                	cmp    %edx,%esi
  801799:	72 19                	jb     8017b4 <__udivdi3+0xfc>
  80179b:	74 0b                	je     8017a8 <__udivdi3+0xf0>
  80179d:	89 d8                	mov    %ebx,%eax
  80179f:	31 ff                	xor    %edi,%edi
  8017a1:	e9 58 ff ff ff       	jmp    8016fe <__udivdi3+0x46>
  8017a6:	66 90                	xchg   %ax,%ax
  8017a8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8017ac:	89 f9                	mov    %edi,%ecx
  8017ae:	d3 e2                	shl    %cl,%edx
  8017b0:	39 c2                	cmp    %eax,%edx
  8017b2:	73 e9                	jae    80179d <__udivdi3+0xe5>
  8017b4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8017b7:	31 ff                	xor    %edi,%edi
  8017b9:	e9 40 ff ff ff       	jmp    8016fe <__udivdi3+0x46>
  8017be:	66 90                	xchg   %ax,%ax
  8017c0:	31 c0                	xor    %eax,%eax
  8017c2:	e9 37 ff ff ff       	jmp    8016fe <__udivdi3+0x46>
  8017c7:	90                   	nop

008017c8 <__umoddi3>:
  8017c8:	55                   	push   %ebp
  8017c9:	57                   	push   %edi
  8017ca:	56                   	push   %esi
  8017cb:	53                   	push   %ebx
  8017cc:	83 ec 1c             	sub    $0x1c,%esp
  8017cf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8017d3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8017d7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017db:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8017df:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8017e3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8017e7:	89 f3                	mov    %esi,%ebx
  8017e9:	89 fa                	mov    %edi,%edx
  8017eb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8017ef:	89 34 24             	mov    %esi,(%esp)
  8017f2:	85 c0                	test   %eax,%eax
  8017f4:	75 1a                	jne    801810 <__umoddi3+0x48>
  8017f6:	39 f7                	cmp    %esi,%edi
  8017f8:	0f 86 a2 00 00 00    	jbe    8018a0 <__umoddi3+0xd8>
  8017fe:	89 c8                	mov    %ecx,%eax
  801800:	89 f2                	mov    %esi,%edx
  801802:	f7 f7                	div    %edi
  801804:	89 d0                	mov    %edx,%eax
  801806:	31 d2                	xor    %edx,%edx
  801808:	83 c4 1c             	add    $0x1c,%esp
  80180b:	5b                   	pop    %ebx
  80180c:	5e                   	pop    %esi
  80180d:	5f                   	pop    %edi
  80180e:	5d                   	pop    %ebp
  80180f:	c3                   	ret    
  801810:	39 f0                	cmp    %esi,%eax
  801812:	0f 87 ac 00 00 00    	ja     8018c4 <__umoddi3+0xfc>
  801818:	0f bd e8             	bsr    %eax,%ebp
  80181b:	83 f5 1f             	xor    $0x1f,%ebp
  80181e:	0f 84 ac 00 00 00    	je     8018d0 <__umoddi3+0x108>
  801824:	bf 20 00 00 00       	mov    $0x20,%edi
  801829:	29 ef                	sub    %ebp,%edi
  80182b:	89 fe                	mov    %edi,%esi
  80182d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801831:	89 e9                	mov    %ebp,%ecx
  801833:	d3 e0                	shl    %cl,%eax
  801835:	89 d7                	mov    %edx,%edi
  801837:	89 f1                	mov    %esi,%ecx
  801839:	d3 ef                	shr    %cl,%edi
  80183b:	09 c7                	or     %eax,%edi
  80183d:	89 e9                	mov    %ebp,%ecx
  80183f:	d3 e2                	shl    %cl,%edx
  801841:	89 14 24             	mov    %edx,(%esp)
  801844:	89 d8                	mov    %ebx,%eax
  801846:	d3 e0                	shl    %cl,%eax
  801848:	89 c2                	mov    %eax,%edx
  80184a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80184e:	d3 e0                	shl    %cl,%eax
  801850:	89 44 24 04          	mov    %eax,0x4(%esp)
  801854:	8b 44 24 08          	mov    0x8(%esp),%eax
  801858:	89 f1                	mov    %esi,%ecx
  80185a:	d3 e8                	shr    %cl,%eax
  80185c:	09 d0                	or     %edx,%eax
  80185e:	d3 eb                	shr    %cl,%ebx
  801860:	89 da                	mov    %ebx,%edx
  801862:	f7 f7                	div    %edi
  801864:	89 d3                	mov    %edx,%ebx
  801866:	f7 24 24             	mull   (%esp)
  801869:	89 c6                	mov    %eax,%esi
  80186b:	89 d1                	mov    %edx,%ecx
  80186d:	39 d3                	cmp    %edx,%ebx
  80186f:	0f 82 87 00 00 00    	jb     8018fc <__umoddi3+0x134>
  801875:	0f 84 91 00 00 00    	je     80190c <__umoddi3+0x144>
  80187b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80187f:	29 f2                	sub    %esi,%edx
  801881:	19 cb                	sbb    %ecx,%ebx
  801883:	89 d8                	mov    %ebx,%eax
  801885:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801889:	d3 e0                	shl    %cl,%eax
  80188b:	89 e9                	mov    %ebp,%ecx
  80188d:	d3 ea                	shr    %cl,%edx
  80188f:	09 d0                	or     %edx,%eax
  801891:	89 e9                	mov    %ebp,%ecx
  801893:	d3 eb                	shr    %cl,%ebx
  801895:	89 da                	mov    %ebx,%edx
  801897:	83 c4 1c             	add    $0x1c,%esp
  80189a:	5b                   	pop    %ebx
  80189b:	5e                   	pop    %esi
  80189c:	5f                   	pop    %edi
  80189d:	5d                   	pop    %ebp
  80189e:	c3                   	ret    
  80189f:	90                   	nop
  8018a0:	89 fd                	mov    %edi,%ebp
  8018a2:	85 ff                	test   %edi,%edi
  8018a4:	75 0b                	jne    8018b1 <__umoddi3+0xe9>
  8018a6:	b8 01 00 00 00       	mov    $0x1,%eax
  8018ab:	31 d2                	xor    %edx,%edx
  8018ad:	f7 f7                	div    %edi
  8018af:	89 c5                	mov    %eax,%ebp
  8018b1:	89 f0                	mov    %esi,%eax
  8018b3:	31 d2                	xor    %edx,%edx
  8018b5:	f7 f5                	div    %ebp
  8018b7:	89 c8                	mov    %ecx,%eax
  8018b9:	f7 f5                	div    %ebp
  8018bb:	89 d0                	mov    %edx,%eax
  8018bd:	e9 44 ff ff ff       	jmp    801806 <__umoddi3+0x3e>
  8018c2:	66 90                	xchg   %ax,%ax
  8018c4:	89 c8                	mov    %ecx,%eax
  8018c6:	89 f2                	mov    %esi,%edx
  8018c8:	83 c4 1c             	add    $0x1c,%esp
  8018cb:	5b                   	pop    %ebx
  8018cc:	5e                   	pop    %esi
  8018cd:	5f                   	pop    %edi
  8018ce:	5d                   	pop    %ebp
  8018cf:	c3                   	ret    
  8018d0:	3b 04 24             	cmp    (%esp),%eax
  8018d3:	72 06                	jb     8018db <__umoddi3+0x113>
  8018d5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8018d9:	77 0f                	ja     8018ea <__umoddi3+0x122>
  8018db:	89 f2                	mov    %esi,%edx
  8018dd:	29 f9                	sub    %edi,%ecx
  8018df:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8018e3:	89 14 24             	mov    %edx,(%esp)
  8018e6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018ea:	8b 44 24 04          	mov    0x4(%esp),%eax
  8018ee:	8b 14 24             	mov    (%esp),%edx
  8018f1:	83 c4 1c             	add    $0x1c,%esp
  8018f4:	5b                   	pop    %ebx
  8018f5:	5e                   	pop    %esi
  8018f6:	5f                   	pop    %edi
  8018f7:	5d                   	pop    %ebp
  8018f8:	c3                   	ret    
  8018f9:	8d 76 00             	lea    0x0(%esi),%esi
  8018fc:	2b 04 24             	sub    (%esp),%eax
  8018ff:	19 fa                	sbb    %edi,%edx
  801901:	89 d1                	mov    %edx,%ecx
  801903:	89 c6                	mov    %eax,%esi
  801905:	e9 71 ff ff ff       	jmp    80187b <__umoddi3+0xb3>
  80190a:	66 90                	xchg   %ax,%ax
  80190c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801910:	72 ea                	jb     8018fc <__umoddi3+0x134>
  801912:	89 d9                	mov    %ebx,%ecx
  801914:	e9 62 ff ff ff       	jmp    80187b <__umoddi3+0xb3>
