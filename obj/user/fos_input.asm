
obj/user/fos_input:     file format elf32-i386


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
  800031:	e8 a5 00 00 00       	call   8000db <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void
_main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 04 00 00    	sub    $0x418,%esp
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int i2=0;
  800048:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	char buff1[512];
	char buff2[512];


	atomic_readline("Please enter first number :", buff1);
  80004f:	83 ec 08             	sub    $0x8,%esp
  800052:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  800058:	50                   	push   %eax
  800059:	68 a0 1c 80 00       	push   $0x801ca0
  80005e:	e8 11 0a 00 00       	call   800a74 <atomic_readline>
  800063:	83 c4 10             	add    $0x10,%esp
	i1 = strtol(buff1, NULL, 10);
  800066:	83 ec 04             	sub    $0x4,%esp
  800069:	6a 0a                	push   $0xa
  80006b:	6a 00                	push   $0x0
  80006d:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  800073:	50                   	push   %eax
  800074:	e8 63 0e 00 00       	call   800edc <strtol>
  800079:	83 c4 10             	add    $0x10,%esp
  80007c:	89 45 f4             	mov    %eax,-0xc(%ebp)

	//sleep
	env_sleep(2800);
  80007f:	83 ec 0c             	sub    $0xc,%esp
  800082:	68 f0 0a 00 00       	push   $0xaf0
  800087:	e8 55 18 00 00       	call   8018e1 <env_sleep>
  80008c:	83 c4 10             	add    $0x10,%esp

	atomic_readline("Please enter second number :", buff2);
  80008f:	83 ec 08             	sub    $0x8,%esp
  800092:	8d 85 f0 fb ff ff    	lea    -0x410(%ebp),%eax
  800098:	50                   	push   %eax
  800099:	68 bc 1c 80 00       	push   $0x801cbc
  80009e:	e8 d1 09 00 00       	call   800a74 <atomic_readline>
  8000a3:	83 c4 10             	add    $0x10,%esp
	
	i2 = strtol(buff2, NULL, 10);
  8000a6:	83 ec 04             	sub    $0x4,%esp
  8000a9:	6a 0a                	push   $0xa
  8000ab:	6a 00                	push   $0x0
  8000ad:	8d 85 f0 fb ff ff    	lea    -0x410(%ebp),%eax
  8000b3:	50                   	push   %eax
  8000b4:	e8 23 0e 00 00       	call   800edc <strtol>
  8000b9:	83 c4 10             	add    $0x10,%esp
  8000bc:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("number 1 + number 2 = %d\n",i1+i2);
  8000bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c5:	01 d0                	add    %edx,%eax
  8000c7:	83 ec 08             	sub    $0x8,%esp
  8000ca:	50                   	push   %eax
  8000cb:	68 d9 1c 80 00       	push   $0x801cd9
  8000d0:	e8 4c 02 00 00       	call   800321 <atomic_cprintf>
  8000d5:	83 c4 10             	add    $0x10,%esp
	return;	
  8000d8:	90                   	nop
}
  8000d9:	c9                   	leave  
  8000da:	c3                   	ret    

008000db <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000db:	55                   	push   %ebp
  8000dc:	89 e5                	mov    %esp,%ebp
  8000de:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000e1:	e8 3f 12 00 00       	call   801325 <sys_getenvindex>
  8000e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000ec:	89 d0                	mov    %edx,%eax
  8000ee:	c1 e0 03             	shl    $0x3,%eax
  8000f1:	01 d0                	add    %edx,%eax
  8000f3:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8000fa:	01 c8                	add    %ecx,%eax
  8000fc:	01 c0                	add    %eax,%eax
  8000fe:	01 d0                	add    %edx,%eax
  800100:	01 c0                	add    %eax,%eax
  800102:	01 d0                	add    %edx,%eax
  800104:	89 c2                	mov    %eax,%edx
  800106:	c1 e2 05             	shl    $0x5,%edx
  800109:	29 c2                	sub    %eax,%edx
  80010b:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800112:	89 c2                	mov    %eax,%edx
  800114:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80011a:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80011f:	a1 20 30 80 00       	mov    0x803020,%eax
  800124:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80012a:	84 c0                	test   %al,%al
  80012c:	74 0f                	je     80013d <libmain+0x62>
		binaryname = myEnv->prog_name;
  80012e:	a1 20 30 80 00       	mov    0x803020,%eax
  800133:	05 40 3c 01 00       	add    $0x13c40,%eax
  800138:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80013d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800141:	7e 0a                	jle    80014d <libmain+0x72>
		binaryname = argv[0];
  800143:	8b 45 0c             	mov    0xc(%ebp),%eax
  800146:	8b 00                	mov    (%eax),%eax
  800148:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80014d:	83 ec 08             	sub    $0x8,%esp
  800150:	ff 75 0c             	pushl  0xc(%ebp)
  800153:	ff 75 08             	pushl  0x8(%ebp)
  800156:	e8 dd fe ff ff       	call   800038 <_main>
  80015b:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80015e:	e8 5d 13 00 00       	call   8014c0 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800163:	83 ec 0c             	sub    $0xc,%esp
  800166:	68 0c 1d 80 00       	push   $0x801d0c
  80016b:	e8 84 01 00 00       	call   8002f4 <cprintf>
  800170:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800173:	a1 20 30 80 00       	mov    0x803020,%eax
  800178:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80017e:	a1 20 30 80 00       	mov    0x803020,%eax
  800183:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800189:	83 ec 04             	sub    $0x4,%esp
  80018c:	52                   	push   %edx
  80018d:	50                   	push   %eax
  80018e:	68 34 1d 80 00       	push   $0x801d34
  800193:	e8 5c 01 00 00       	call   8002f4 <cprintf>
  800198:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80019b:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a0:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8001a6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ab:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8001b1:	83 ec 04             	sub    $0x4,%esp
  8001b4:	52                   	push   %edx
  8001b5:	50                   	push   %eax
  8001b6:	68 5c 1d 80 00       	push   $0x801d5c
  8001bb:	e8 34 01 00 00       	call   8002f4 <cprintf>
  8001c0:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c8:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8001ce:	83 ec 08             	sub    $0x8,%esp
  8001d1:	50                   	push   %eax
  8001d2:	68 9d 1d 80 00       	push   $0x801d9d
  8001d7:	e8 18 01 00 00       	call   8002f4 <cprintf>
  8001dc:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001df:	83 ec 0c             	sub    $0xc,%esp
  8001e2:	68 0c 1d 80 00       	push   $0x801d0c
  8001e7:	e8 08 01 00 00       	call   8002f4 <cprintf>
  8001ec:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001ef:	e8 e6 12 00 00       	call   8014da <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001f4:	e8 19 00 00 00       	call   800212 <exit>
}
  8001f9:	90                   	nop
  8001fa:	c9                   	leave  
  8001fb:	c3                   	ret    

008001fc <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001fc:	55                   	push   %ebp
  8001fd:	89 e5                	mov    %esp,%ebp
  8001ff:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800202:	83 ec 0c             	sub    $0xc,%esp
  800205:	6a 00                	push   $0x0
  800207:	e8 e5 10 00 00       	call   8012f1 <sys_env_destroy>
  80020c:	83 c4 10             	add    $0x10,%esp
}
  80020f:	90                   	nop
  800210:	c9                   	leave  
  800211:	c3                   	ret    

00800212 <exit>:

void
exit(void)
{
  800212:	55                   	push   %ebp
  800213:	89 e5                	mov    %esp,%ebp
  800215:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800218:	e8 3a 11 00 00       	call   801357 <sys_env_exit>
}
  80021d:	90                   	nop
  80021e:	c9                   	leave  
  80021f:	c3                   	ret    

00800220 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800220:	55                   	push   %ebp
  800221:	89 e5                	mov    %esp,%ebp
  800223:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800226:	8b 45 0c             	mov    0xc(%ebp),%eax
  800229:	8b 00                	mov    (%eax),%eax
  80022b:	8d 48 01             	lea    0x1(%eax),%ecx
  80022e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800231:	89 0a                	mov    %ecx,(%edx)
  800233:	8b 55 08             	mov    0x8(%ebp),%edx
  800236:	88 d1                	mov    %dl,%cl
  800238:	8b 55 0c             	mov    0xc(%ebp),%edx
  80023b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80023f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800242:	8b 00                	mov    (%eax),%eax
  800244:	3d ff 00 00 00       	cmp    $0xff,%eax
  800249:	75 2c                	jne    800277 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80024b:	a0 24 30 80 00       	mov    0x803024,%al
  800250:	0f b6 c0             	movzbl %al,%eax
  800253:	8b 55 0c             	mov    0xc(%ebp),%edx
  800256:	8b 12                	mov    (%edx),%edx
  800258:	89 d1                	mov    %edx,%ecx
  80025a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80025d:	83 c2 08             	add    $0x8,%edx
  800260:	83 ec 04             	sub    $0x4,%esp
  800263:	50                   	push   %eax
  800264:	51                   	push   %ecx
  800265:	52                   	push   %edx
  800266:	e8 44 10 00 00       	call   8012af <sys_cputs>
  80026b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80026e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800271:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800277:	8b 45 0c             	mov    0xc(%ebp),%eax
  80027a:	8b 40 04             	mov    0x4(%eax),%eax
  80027d:	8d 50 01             	lea    0x1(%eax),%edx
  800280:	8b 45 0c             	mov    0xc(%ebp),%eax
  800283:	89 50 04             	mov    %edx,0x4(%eax)
}
  800286:	90                   	nop
  800287:	c9                   	leave  
  800288:	c3                   	ret    

00800289 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800289:	55                   	push   %ebp
  80028a:	89 e5                	mov    %esp,%ebp
  80028c:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800292:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800299:	00 00 00 
	b.cnt = 0;
  80029c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8002a3:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8002a6:	ff 75 0c             	pushl  0xc(%ebp)
  8002a9:	ff 75 08             	pushl  0x8(%ebp)
  8002ac:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002b2:	50                   	push   %eax
  8002b3:	68 20 02 80 00       	push   $0x800220
  8002b8:	e8 11 02 00 00       	call   8004ce <vprintfmt>
  8002bd:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8002c0:	a0 24 30 80 00       	mov    0x803024,%al
  8002c5:	0f b6 c0             	movzbl %al,%eax
  8002c8:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002ce:	83 ec 04             	sub    $0x4,%esp
  8002d1:	50                   	push   %eax
  8002d2:	52                   	push   %edx
  8002d3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002d9:	83 c0 08             	add    $0x8,%eax
  8002dc:	50                   	push   %eax
  8002dd:	e8 cd 0f 00 00       	call   8012af <sys_cputs>
  8002e2:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002e5:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8002ec:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002f2:	c9                   	leave  
  8002f3:	c3                   	ret    

008002f4 <cprintf>:

int cprintf(const char *fmt, ...) {
  8002f4:	55                   	push   %ebp
  8002f5:	89 e5                	mov    %esp,%ebp
  8002f7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002fa:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800301:	8d 45 0c             	lea    0xc(%ebp),%eax
  800304:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800307:	8b 45 08             	mov    0x8(%ebp),%eax
  80030a:	83 ec 08             	sub    $0x8,%esp
  80030d:	ff 75 f4             	pushl  -0xc(%ebp)
  800310:	50                   	push   %eax
  800311:	e8 73 ff ff ff       	call   800289 <vcprintf>
  800316:	83 c4 10             	add    $0x10,%esp
  800319:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80031c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80031f:	c9                   	leave  
  800320:	c3                   	ret    

00800321 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800321:	55                   	push   %ebp
  800322:	89 e5                	mov    %esp,%ebp
  800324:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800327:	e8 94 11 00 00       	call   8014c0 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80032c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80032f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800332:	8b 45 08             	mov    0x8(%ebp),%eax
  800335:	83 ec 08             	sub    $0x8,%esp
  800338:	ff 75 f4             	pushl  -0xc(%ebp)
  80033b:	50                   	push   %eax
  80033c:	e8 48 ff ff ff       	call   800289 <vcprintf>
  800341:	83 c4 10             	add    $0x10,%esp
  800344:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800347:	e8 8e 11 00 00       	call   8014da <sys_enable_interrupt>
	return cnt;
  80034c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80034f:	c9                   	leave  
  800350:	c3                   	ret    

00800351 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800351:	55                   	push   %ebp
  800352:	89 e5                	mov    %esp,%ebp
  800354:	53                   	push   %ebx
  800355:	83 ec 14             	sub    $0x14,%esp
  800358:	8b 45 10             	mov    0x10(%ebp),%eax
  80035b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80035e:	8b 45 14             	mov    0x14(%ebp),%eax
  800361:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800364:	8b 45 18             	mov    0x18(%ebp),%eax
  800367:	ba 00 00 00 00       	mov    $0x0,%edx
  80036c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80036f:	77 55                	ja     8003c6 <printnum+0x75>
  800371:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800374:	72 05                	jb     80037b <printnum+0x2a>
  800376:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800379:	77 4b                	ja     8003c6 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80037b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80037e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800381:	8b 45 18             	mov    0x18(%ebp),%eax
  800384:	ba 00 00 00 00       	mov    $0x0,%edx
  800389:	52                   	push   %edx
  80038a:	50                   	push   %eax
  80038b:	ff 75 f4             	pushl  -0xc(%ebp)
  80038e:	ff 75 f0             	pushl  -0x10(%ebp)
  800391:	e8 a2 16 00 00       	call   801a38 <__udivdi3>
  800396:	83 c4 10             	add    $0x10,%esp
  800399:	83 ec 04             	sub    $0x4,%esp
  80039c:	ff 75 20             	pushl  0x20(%ebp)
  80039f:	53                   	push   %ebx
  8003a0:	ff 75 18             	pushl  0x18(%ebp)
  8003a3:	52                   	push   %edx
  8003a4:	50                   	push   %eax
  8003a5:	ff 75 0c             	pushl  0xc(%ebp)
  8003a8:	ff 75 08             	pushl  0x8(%ebp)
  8003ab:	e8 a1 ff ff ff       	call   800351 <printnum>
  8003b0:	83 c4 20             	add    $0x20,%esp
  8003b3:	eb 1a                	jmp    8003cf <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8003b5:	83 ec 08             	sub    $0x8,%esp
  8003b8:	ff 75 0c             	pushl  0xc(%ebp)
  8003bb:	ff 75 20             	pushl  0x20(%ebp)
  8003be:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c1:	ff d0                	call   *%eax
  8003c3:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003c6:	ff 4d 1c             	decl   0x1c(%ebp)
  8003c9:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003cd:	7f e6                	jg     8003b5 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003cf:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003d2:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003dd:	53                   	push   %ebx
  8003de:	51                   	push   %ecx
  8003df:	52                   	push   %edx
  8003e0:	50                   	push   %eax
  8003e1:	e8 62 17 00 00       	call   801b48 <__umoddi3>
  8003e6:	83 c4 10             	add    $0x10,%esp
  8003e9:	05 d4 1f 80 00       	add    $0x801fd4,%eax
  8003ee:	8a 00                	mov    (%eax),%al
  8003f0:	0f be c0             	movsbl %al,%eax
  8003f3:	83 ec 08             	sub    $0x8,%esp
  8003f6:	ff 75 0c             	pushl  0xc(%ebp)
  8003f9:	50                   	push   %eax
  8003fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fd:	ff d0                	call   *%eax
  8003ff:	83 c4 10             	add    $0x10,%esp
}
  800402:	90                   	nop
  800403:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800406:	c9                   	leave  
  800407:	c3                   	ret    

00800408 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800408:	55                   	push   %ebp
  800409:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80040b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80040f:	7e 1c                	jle    80042d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800411:	8b 45 08             	mov    0x8(%ebp),%eax
  800414:	8b 00                	mov    (%eax),%eax
  800416:	8d 50 08             	lea    0x8(%eax),%edx
  800419:	8b 45 08             	mov    0x8(%ebp),%eax
  80041c:	89 10                	mov    %edx,(%eax)
  80041e:	8b 45 08             	mov    0x8(%ebp),%eax
  800421:	8b 00                	mov    (%eax),%eax
  800423:	83 e8 08             	sub    $0x8,%eax
  800426:	8b 50 04             	mov    0x4(%eax),%edx
  800429:	8b 00                	mov    (%eax),%eax
  80042b:	eb 40                	jmp    80046d <getuint+0x65>
	else if (lflag)
  80042d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800431:	74 1e                	je     800451 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800433:	8b 45 08             	mov    0x8(%ebp),%eax
  800436:	8b 00                	mov    (%eax),%eax
  800438:	8d 50 04             	lea    0x4(%eax),%edx
  80043b:	8b 45 08             	mov    0x8(%ebp),%eax
  80043e:	89 10                	mov    %edx,(%eax)
  800440:	8b 45 08             	mov    0x8(%ebp),%eax
  800443:	8b 00                	mov    (%eax),%eax
  800445:	83 e8 04             	sub    $0x4,%eax
  800448:	8b 00                	mov    (%eax),%eax
  80044a:	ba 00 00 00 00       	mov    $0x0,%edx
  80044f:	eb 1c                	jmp    80046d <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800451:	8b 45 08             	mov    0x8(%ebp),%eax
  800454:	8b 00                	mov    (%eax),%eax
  800456:	8d 50 04             	lea    0x4(%eax),%edx
  800459:	8b 45 08             	mov    0x8(%ebp),%eax
  80045c:	89 10                	mov    %edx,(%eax)
  80045e:	8b 45 08             	mov    0x8(%ebp),%eax
  800461:	8b 00                	mov    (%eax),%eax
  800463:	83 e8 04             	sub    $0x4,%eax
  800466:	8b 00                	mov    (%eax),%eax
  800468:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80046d:	5d                   	pop    %ebp
  80046e:	c3                   	ret    

0080046f <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80046f:	55                   	push   %ebp
  800470:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800472:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800476:	7e 1c                	jle    800494 <getint+0x25>
		return va_arg(*ap, long long);
  800478:	8b 45 08             	mov    0x8(%ebp),%eax
  80047b:	8b 00                	mov    (%eax),%eax
  80047d:	8d 50 08             	lea    0x8(%eax),%edx
  800480:	8b 45 08             	mov    0x8(%ebp),%eax
  800483:	89 10                	mov    %edx,(%eax)
  800485:	8b 45 08             	mov    0x8(%ebp),%eax
  800488:	8b 00                	mov    (%eax),%eax
  80048a:	83 e8 08             	sub    $0x8,%eax
  80048d:	8b 50 04             	mov    0x4(%eax),%edx
  800490:	8b 00                	mov    (%eax),%eax
  800492:	eb 38                	jmp    8004cc <getint+0x5d>
	else if (lflag)
  800494:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800498:	74 1a                	je     8004b4 <getint+0x45>
		return va_arg(*ap, long);
  80049a:	8b 45 08             	mov    0x8(%ebp),%eax
  80049d:	8b 00                	mov    (%eax),%eax
  80049f:	8d 50 04             	lea    0x4(%eax),%edx
  8004a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a5:	89 10                	mov    %edx,(%eax)
  8004a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004aa:	8b 00                	mov    (%eax),%eax
  8004ac:	83 e8 04             	sub    $0x4,%eax
  8004af:	8b 00                	mov    (%eax),%eax
  8004b1:	99                   	cltd   
  8004b2:	eb 18                	jmp    8004cc <getint+0x5d>
	else
		return va_arg(*ap, int);
  8004b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b7:	8b 00                	mov    (%eax),%eax
  8004b9:	8d 50 04             	lea    0x4(%eax),%edx
  8004bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8004bf:	89 10                	mov    %edx,(%eax)
  8004c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c4:	8b 00                	mov    (%eax),%eax
  8004c6:	83 e8 04             	sub    $0x4,%eax
  8004c9:	8b 00                	mov    (%eax),%eax
  8004cb:	99                   	cltd   
}
  8004cc:	5d                   	pop    %ebp
  8004cd:	c3                   	ret    

008004ce <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004ce:	55                   	push   %ebp
  8004cf:	89 e5                	mov    %esp,%ebp
  8004d1:	56                   	push   %esi
  8004d2:	53                   	push   %ebx
  8004d3:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004d6:	eb 17                	jmp    8004ef <vprintfmt+0x21>
			if (ch == '\0')
  8004d8:	85 db                	test   %ebx,%ebx
  8004da:	0f 84 af 03 00 00    	je     80088f <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004e0:	83 ec 08             	sub    $0x8,%esp
  8004e3:	ff 75 0c             	pushl  0xc(%ebp)
  8004e6:	53                   	push   %ebx
  8004e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ea:	ff d0                	call   *%eax
  8004ec:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8004f2:	8d 50 01             	lea    0x1(%eax),%edx
  8004f5:	89 55 10             	mov    %edx,0x10(%ebp)
  8004f8:	8a 00                	mov    (%eax),%al
  8004fa:	0f b6 d8             	movzbl %al,%ebx
  8004fd:	83 fb 25             	cmp    $0x25,%ebx
  800500:	75 d6                	jne    8004d8 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800502:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800506:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80050d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800514:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80051b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800522:	8b 45 10             	mov    0x10(%ebp),%eax
  800525:	8d 50 01             	lea    0x1(%eax),%edx
  800528:	89 55 10             	mov    %edx,0x10(%ebp)
  80052b:	8a 00                	mov    (%eax),%al
  80052d:	0f b6 d8             	movzbl %al,%ebx
  800530:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800533:	83 f8 55             	cmp    $0x55,%eax
  800536:	0f 87 2b 03 00 00    	ja     800867 <vprintfmt+0x399>
  80053c:	8b 04 85 f8 1f 80 00 	mov    0x801ff8(,%eax,4),%eax
  800543:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800545:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800549:	eb d7                	jmp    800522 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80054b:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80054f:	eb d1                	jmp    800522 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800551:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800558:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80055b:	89 d0                	mov    %edx,%eax
  80055d:	c1 e0 02             	shl    $0x2,%eax
  800560:	01 d0                	add    %edx,%eax
  800562:	01 c0                	add    %eax,%eax
  800564:	01 d8                	add    %ebx,%eax
  800566:	83 e8 30             	sub    $0x30,%eax
  800569:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80056c:	8b 45 10             	mov    0x10(%ebp),%eax
  80056f:	8a 00                	mov    (%eax),%al
  800571:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800574:	83 fb 2f             	cmp    $0x2f,%ebx
  800577:	7e 3e                	jle    8005b7 <vprintfmt+0xe9>
  800579:	83 fb 39             	cmp    $0x39,%ebx
  80057c:	7f 39                	jg     8005b7 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80057e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800581:	eb d5                	jmp    800558 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800583:	8b 45 14             	mov    0x14(%ebp),%eax
  800586:	83 c0 04             	add    $0x4,%eax
  800589:	89 45 14             	mov    %eax,0x14(%ebp)
  80058c:	8b 45 14             	mov    0x14(%ebp),%eax
  80058f:	83 e8 04             	sub    $0x4,%eax
  800592:	8b 00                	mov    (%eax),%eax
  800594:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800597:	eb 1f                	jmp    8005b8 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800599:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80059d:	79 83                	jns    800522 <vprintfmt+0x54>
				width = 0;
  80059f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8005a6:	e9 77 ff ff ff       	jmp    800522 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8005ab:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8005b2:	e9 6b ff ff ff       	jmp    800522 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8005b7:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8005b8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005bc:	0f 89 60 ff ff ff    	jns    800522 <vprintfmt+0x54>
				width = precision, precision = -1;
  8005c2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005c8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005cf:	e9 4e ff ff ff       	jmp    800522 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005d4:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005d7:	e9 46 ff ff ff       	jmp    800522 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005dc:	8b 45 14             	mov    0x14(%ebp),%eax
  8005df:	83 c0 04             	add    $0x4,%eax
  8005e2:	89 45 14             	mov    %eax,0x14(%ebp)
  8005e5:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e8:	83 e8 04             	sub    $0x4,%eax
  8005eb:	8b 00                	mov    (%eax),%eax
  8005ed:	83 ec 08             	sub    $0x8,%esp
  8005f0:	ff 75 0c             	pushl  0xc(%ebp)
  8005f3:	50                   	push   %eax
  8005f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f7:	ff d0                	call   *%eax
  8005f9:	83 c4 10             	add    $0x10,%esp
			break;
  8005fc:	e9 89 02 00 00       	jmp    80088a <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800601:	8b 45 14             	mov    0x14(%ebp),%eax
  800604:	83 c0 04             	add    $0x4,%eax
  800607:	89 45 14             	mov    %eax,0x14(%ebp)
  80060a:	8b 45 14             	mov    0x14(%ebp),%eax
  80060d:	83 e8 04             	sub    $0x4,%eax
  800610:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800612:	85 db                	test   %ebx,%ebx
  800614:	79 02                	jns    800618 <vprintfmt+0x14a>
				err = -err;
  800616:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800618:	83 fb 64             	cmp    $0x64,%ebx
  80061b:	7f 0b                	jg     800628 <vprintfmt+0x15a>
  80061d:	8b 34 9d 40 1e 80 00 	mov    0x801e40(,%ebx,4),%esi
  800624:	85 f6                	test   %esi,%esi
  800626:	75 19                	jne    800641 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800628:	53                   	push   %ebx
  800629:	68 e5 1f 80 00       	push   $0x801fe5
  80062e:	ff 75 0c             	pushl  0xc(%ebp)
  800631:	ff 75 08             	pushl  0x8(%ebp)
  800634:	e8 5e 02 00 00       	call   800897 <printfmt>
  800639:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80063c:	e9 49 02 00 00       	jmp    80088a <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800641:	56                   	push   %esi
  800642:	68 ee 1f 80 00       	push   $0x801fee
  800647:	ff 75 0c             	pushl  0xc(%ebp)
  80064a:	ff 75 08             	pushl  0x8(%ebp)
  80064d:	e8 45 02 00 00       	call   800897 <printfmt>
  800652:	83 c4 10             	add    $0x10,%esp
			break;
  800655:	e9 30 02 00 00       	jmp    80088a <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80065a:	8b 45 14             	mov    0x14(%ebp),%eax
  80065d:	83 c0 04             	add    $0x4,%eax
  800660:	89 45 14             	mov    %eax,0x14(%ebp)
  800663:	8b 45 14             	mov    0x14(%ebp),%eax
  800666:	83 e8 04             	sub    $0x4,%eax
  800669:	8b 30                	mov    (%eax),%esi
  80066b:	85 f6                	test   %esi,%esi
  80066d:	75 05                	jne    800674 <vprintfmt+0x1a6>
				p = "(null)";
  80066f:	be f1 1f 80 00       	mov    $0x801ff1,%esi
			if (width > 0 && padc != '-')
  800674:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800678:	7e 6d                	jle    8006e7 <vprintfmt+0x219>
  80067a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80067e:	74 67                	je     8006e7 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800680:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800683:	83 ec 08             	sub    $0x8,%esp
  800686:	50                   	push   %eax
  800687:	56                   	push   %esi
  800688:	e8 12 05 00 00       	call   800b9f <strnlen>
  80068d:	83 c4 10             	add    $0x10,%esp
  800690:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800693:	eb 16                	jmp    8006ab <vprintfmt+0x1dd>
					putch(padc, putdat);
  800695:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800699:	83 ec 08             	sub    $0x8,%esp
  80069c:	ff 75 0c             	pushl  0xc(%ebp)
  80069f:	50                   	push   %eax
  8006a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a3:	ff d0                	call   *%eax
  8006a5:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006a8:	ff 4d e4             	decl   -0x1c(%ebp)
  8006ab:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006af:	7f e4                	jg     800695 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006b1:	eb 34                	jmp    8006e7 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8006b3:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8006b7:	74 1c                	je     8006d5 <vprintfmt+0x207>
  8006b9:	83 fb 1f             	cmp    $0x1f,%ebx
  8006bc:	7e 05                	jle    8006c3 <vprintfmt+0x1f5>
  8006be:	83 fb 7e             	cmp    $0x7e,%ebx
  8006c1:	7e 12                	jle    8006d5 <vprintfmt+0x207>
					putch('?', putdat);
  8006c3:	83 ec 08             	sub    $0x8,%esp
  8006c6:	ff 75 0c             	pushl  0xc(%ebp)
  8006c9:	6a 3f                	push   $0x3f
  8006cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ce:	ff d0                	call   *%eax
  8006d0:	83 c4 10             	add    $0x10,%esp
  8006d3:	eb 0f                	jmp    8006e4 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006d5:	83 ec 08             	sub    $0x8,%esp
  8006d8:	ff 75 0c             	pushl  0xc(%ebp)
  8006db:	53                   	push   %ebx
  8006dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006df:	ff d0                	call   *%eax
  8006e1:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006e4:	ff 4d e4             	decl   -0x1c(%ebp)
  8006e7:	89 f0                	mov    %esi,%eax
  8006e9:	8d 70 01             	lea    0x1(%eax),%esi
  8006ec:	8a 00                	mov    (%eax),%al
  8006ee:	0f be d8             	movsbl %al,%ebx
  8006f1:	85 db                	test   %ebx,%ebx
  8006f3:	74 24                	je     800719 <vprintfmt+0x24b>
  8006f5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006f9:	78 b8                	js     8006b3 <vprintfmt+0x1e5>
  8006fb:	ff 4d e0             	decl   -0x20(%ebp)
  8006fe:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800702:	79 af                	jns    8006b3 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800704:	eb 13                	jmp    800719 <vprintfmt+0x24b>
				putch(' ', putdat);
  800706:	83 ec 08             	sub    $0x8,%esp
  800709:	ff 75 0c             	pushl  0xc(%ebp)
  80070c:	6a 20                	push   $0x20
  80070e:	8b 45 08             	mov    0x8(%ebp),%eax
  800711:	ff d0                	call   *%eax
  800713:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800716:	ff 4d e4             	decl   -0x1c(%ebp)
  800719:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80071d:	7f e7                	jg     800706 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80071f:	e9 66 01 00 00       	jmp    80088a <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800724:	83 ec 08             	sub    $0x8,%esp
  800727:	ff 75 e8             	pushl  -0x18(%ebp)
  80072a:	8d 45 14             	lea    0x14(%ebp),%eax
  80072d:	50                   	push   %eax
  80072e:	e8 3c fd ff ff       	call   80046f <getint>
  800733:	83 c4 10             	add    $0x10,%esp
  800736:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800739:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80073c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80073f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800742:	85 d2                	test   %edx,%edx
  800744:	79 23                	jns    800769 <vprintfmt+0x29b>
				putch('-', putdat);
  800746:	83 ec 08             	sub    $0x8,%esp
  800749:	ff 75 0c             	pushl  0xc(%ebp)
  80074c:	6a 2d                	push   $0x2d
  80074e:	8b 45 08             	mov    0x8(%ebp),%eax
  800751:	ff d0                	call   *%eax
  800753:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800756:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800759:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80075c:	f7 d8                	neg    %eax
  80075e:	83 d2 00             	adc    $0x0,%edx
  800761:	f7 da                	neg    %edx
  800763:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800766:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800769:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800770:	e9 bc 00 00 00       	jmp    800831 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800775:	83 ec 08             	sub    $0x8,%esp
  800778:	ff 75 e8             	pushl  -0x18(%ebp)
  80077b:	8d 45 14             	lea    0x14(%ebp),%eax
  80077e:	50                   	push   %eax
  80077f:	e8 84 fc ff ff       	call   800408 <getuint>
  800784:	83 c4 10             	add    $0x10,%esp
  800787:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80078a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80078d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800794:	e9 98 00 00 00       	jmp    800831 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800799:	83 ec 08             	sub    $0x8,%esp
  80079c:	ff 75 0c             	pushl  0xc(%ebp)
  80079f:	6a 58                	push   $0x58
  8007a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a4:	ff d0                	call   *%eax
  8007a6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007a9:	83 ec 08             	sub    $0x8,%esp
  8007ac:	ff 75 0c             	pushl  0xc(%ebp)
  8007af:	6a 58                	push   $0x58
  8007b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b4:	ff d0                	call   *%eax
  8007b6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007b9:	83 ec 08             	sub    $0x8,%esp
  8007bc:	ff 75 0c             	pushl  0xc(%ebp)
  8007bf:	6a 58                	push   $0x58
  8007c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c4:	ff d0                	call   *%eax
  8007c6:	83 c4 10             	add    $0x10,%esp
			break;
  8007c9:	e9 bc 00 00 00       	jmp    80088a <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007ce:	83 ec 08             	sub    $0x8,%esp
  8007d1:	ff 75 0c             	pushl  0xc(%ebp)
  8007d4:	6a 30                	push   $0x30
  8007d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d9:	ff d0                	call   *%eax
  8007db:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007de:	83 ec 08             	sub    $0x8,%esp
  8007e1:	ff 75 0c             	pushl  0xc(%ebp)
  8007e4:	6a 78                	push   $0x78
  8007e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e9:	ff d0                	call   *%eax
  8007eb:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007ee:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f1:	83 c0 04             	add    $0x4,%eax
  8007f4:	89 45 14             	mov    %eax,0x14(%ebp)
  8007f7:	8b 45 14             	mov    0x14(%ebp),%eax
  8007fa:	83 e8 04             	sub    $0x4,%eax
  8007fd:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800802:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800809:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800810:	eb 1f                	jmp    800831 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800812:	83 ec 08             	sub    $0x8,%esp
  800815:	ff 75 e8             	pushl  -0x18(%ebp)
  800818:	8d 45 14             	lea    0x14(%ebp),%eax
  80081b:	50                   	push   %eax
  80081c:	e8 e7 fb ff ff       	call   800408 <getuint>
  800821:	83 c4 10             	add    $0x10,%esp
  800824:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800827:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80082a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800831:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800835:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800838:	83 ec 04             	sub    $0x4,%esp
  80083b:	52                   	push   %edx
  80083c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80083f:	50                   	push   %eax
  800840:	ff 75 f4             	pushl  -0xc(%ebp)
  800843:	ff 75 f0             	pushl  -0x10(%ebp)
  800846:	ff 75 0c             	pushl  0xc(%ebp)
  800849:	ff 75 08             	pushl  0x8(%ebp)
  80084c:	e8 00 fb ff ff       	call   800351 <printnum>
  800851:	83 c4 20             	add    $0x20,%esp
			break;
  800854:	eb 34                	jmp    80088a <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800856:	83 ec 08             	sub    $0x8,%esp
  800859:	ff 75 0c             	pushl  0xc(%ebp)
  80085c:	53                   	push   %ebx
  80085d:	8b 45 08             	mov    0x8(%ebp),%eax
  800860:	ff d0                	call   *%eax
  800862:	83 c4 10             	add    $0x10,%esp
			break;
  800865:	eb 23                	jmp    80088a <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800867:	83 ec 08             	sub    $0x8,%esp
  80086a:	ff 75 0c             	pushl  0xc(%ebp)
  80086d:	6a 25                	push   $0x25
  80086f:	8b 45 08             	mov    0x8(%ebp),%eax
  800872:	ff d0                	call   *%eax
  800874:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800877:	ff 4d 10             	decl   0x10(%ebp)
  80087a:	eb 03                	jmp    80087f <vprintfmt+0x3b1>
  80087c:	ff 4d 10             	decl   0x10(%ebp)
  80087f:	8b 45 10             	mov    0x10(%ebp),%eax
  800882:	48                   	dec    %eax
  800883:	8a 00                	mov    (%eax),%al
  800885:	3c 25                	cmp    $0x25,%al
  800887:	75 f3                	jne    80087c <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800889:	90                   	nop
		}
	}
  80088a:	e9 47 fc ff ff       	jmp    8004d6 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80088f:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800890:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800893:	5b                   	pop    %ebx
  800894:	5e                   	pop    %esi
  800895:	5d                   	pop    %ebp
  800896:	c3                   	ret    

00800897 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800897:	55                   	push   %ebp
  800898:	89 e5                	mov    %esp,%ebp
  80089a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80089d:	8d 45 10             	lea    0x10(%ebp),%eax
  8008a0:	83 c0 04             	add    $0x4,%eax
  8008a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8008a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8008a9:	ff 75 f4             	pushl  -0xc(%ebp)
  8008ac:	50                   	push   %eax
  8008ad:	ff 75 0c             	pushl  0xc(%ebp)
  8008b0:	ff 75 08             	pushl  0x8(%ebp)
  8008b3:	e8 16 fc ff ff       	call   8004ce <vprintfmt>
  8008b8:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8008bb:	90                   	nop
  8008bc:	c9                   	leave  
  8008bd:	c3                   	ret    

008008be <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8008be:	55                   	push   %ebp
  8008bf:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8008c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c4:	8b 40 08             	mov    0x8(%eax),%eax
  8008c7:	8d 50 01             	lea    0x1(%eax),%edx
  8008ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008cd:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d3:	8b 10                	mov    (%eax),%edx
  8008d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d8:	8b 40 04             	mov    0x4(%eax),%eax
  8008db:	39 c2                	cmp    %eax,%edx
  8008dd:	73 12                	jae    8008f1 <sprintputch+0x33>
		*b->buf++ = ch;
  8008df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e2:	8b 00                	mov    (%eax),%eax
  8008e4:	8d 48 01             	lea    0x1(%eax),%ecx
  8008e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ea:	89 0a                	mov    %ecx,(%edx)
  8008ec:	8b 55 08             	mov    0x8(%ebp),%edx
  8008ef:	88 10                	mov    %dl,(%eax)
}
  8008f1:	90                   	nop
  8008f2:	5d                   	pop    %ebp
  8008f3:	c3                   	ret    

008008f4 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008f4:	55                   	push   %ebp
  8008f5:	89 e5                	mov    %esp,%ebp
  8008f7:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800900:	8b 45 0c             	mov    0xc(%ebp),%eax
  800903:	8d 50 ff             	lea    -0x1(%eax),%edx
  800906:	8b 45 08             	mov    0x8(%ebp),%eax
  800909:	01 d0                	add    %edx,%eax
  80090b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80090e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800915:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800919:	74 06                	je     800921 <vsnprintf+0x2d>
  80091b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80091f:	7f 07                	jg     800928 <vsnprintf+0x34>
		return -E_INVAL;
  800921:	b8 03 00 00 00       	mov    $0x3,%eax
  800926:	eb 20                	jmp    800948 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800928:	ff 75 14             	pushl  0x14(%ebp)
  80092b:	ff 75 10             	pushl  0x10(%ebp)
  80092e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800931:	50                   	push   %eax
  800932:	68 be 08 80 00       	push   $0x8008be
  800937:	e8 92 fb ff ff       	call   8004ce <vprintfmt>
  80093c:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80093f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800942:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800945:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800948:	c9                   	leave  
  800949:	c3                   	ret    

0080094a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80094a:	55                   	push   %ebp
  80094b:	89 e5                	mov    %esp,%ebp
  80094d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800950:	8d 45 10             	lea    0x10(%ebp),%eax
  800953:	83 c0 04             	add    $0x4,%eax
  800956:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800959:	8b 45 10             	mov    0x10(%ebp),%eax
  80095c:	ff 75 f4             	pushl  -0xc(%ebp)
  80095f:	50                   	push   %eax
  800960:	ff 75 0c             	pushl  0xc(%ebp)
  800963:	ff 75 08             	pushl  0x8(%ebp)
  800966:	e8 89 ff ff ff       	call   8008f4 <vsnprintf>
  80096b:	83 c4 10             	add    $0x10,%esp
  80096e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800971:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800974:	c9                   	leave  
  800975:	c3                   	ret    

00800976 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800976:	55                   	push   %ebp
  800977:	89 e5                	mov    %esp,%ebp
  800979:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80097c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800980:	74 13                	je     800995 <readline+0x1f>
		cprintf("%s", prompt);
  800982:	83 ec 08             	sub    $0x8,%esp
  800985:	ff 75 08             	pushl  0x8(%ebp)
  800988:	68 50 21 80 00       	push   $0x802150
  80098d:	e8 62 f9 ff ff       	call   8002f4 <cprintf>
  800992:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800995:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80099c:	83 ec 0c             	sub    $0xc,%esp
  80099f:	6a 00                	push   $0x0
  8009a1:	e8 85 10 00 00       	call   801a2b <iscons>
  8009a6:	83 c4 10             	add    $0x10,%esp
  8009a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8009ac:	e8 2c 10 00 00       	call   8019dd <getchar>
  8009b1:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8009b4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8009b8:	79 22                	jns    8009dc <readline+0x66>
			if (c != -E_EOF)
  8009ba:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8009be:	0f 84 ad 00 00 00    	je     800a71 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8009c4:	83 ec 08             	sub    $0x8,%esp
  8009c7:	ff 75 ec             	pushl  -0x14(%ebp)
  8009ca:	68 53 21 80 00       	push   $0x802153
  8009cf:	e8 20 f9 ff ff       	call   8002f4 <cprintf>
  8009d4:	83 c4 10             	add    $0x10,%esp
			return;
  8009d7:	e9 95 00 00 00       	jmp    800a71 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8009dc:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8009e0:	7e 34                	jle    800a16 <readline+0xa0>
  8009e2:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8009e9:	7f 2b                	jg     800a16 <readline+0xa0>
			if (echoing)
  8009eb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009ef:	74 0e                	je     8009ff <readline+0x89>
				cputchar(c);
  8009f1:	83 ec 0c             	sub    $0xc,%esp
  8009f4:	ff 75 ec             	pushl  -0x14(%ebp)
  8009f7:	e8 99 0f 00 00       	call   801995 <cputchar>
  8009fc:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8009ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a02:	8d 50 01             	lea    0x1(%eax),%edx
  800a05:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800a08:	89 c2                	mov    %eax,%edx
  800a0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a0d:	01 d0                	add    %edx,%eax
  800a0f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800a12:	88 10                	mov    %dl,(%eax)
  800a14:	eb 56                	jmp    800a6c <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  800a16:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800a1a:	75 1f                	jne    800a3b <readline+0xc5>
  800a1c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800a20:	7e 19                	jle    800a3b <readline+0xc5>
			if (echoing)
  800a22:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a26:	74 0e                	je     800a36 <readline+0xc0>
				cputchar(c);
  800a28:	83 ec 0c             	sub    $0xc,%esp
  800a2b:	ff 75 ec             	pushl  -0x14(%ebp)
  800a2e:	e8 62 0f 00 00       	call   801995 <cputchar>
  800a33:	83 c4 10             	add    $0x10,%esp

			i--;
  800a36:	ff 4d f4             	decl   -0xc(%ebp)
  800a39:	eb 31                	jmp    800a6c <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800a3b:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800a3f:	74 0a                	je     800a4b <readline+0xd5>
  800a41:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800a45:	0f 85 61 ff ff ff    	jne    8009ac <readline+0x36>
			if (echoing)
  800a4b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a4f:	74 0e                	je     800a5f <readline+0xe9>
				cputchar(c);
  800a51:	83 ec 0c             	sub    $0xc,%esp
  800a54:	ff 75 ec             	pushl  -0x14(%ebp)
  800a57:	e8 39 0f 00 00       	call   801995 <cputchar>
  800a5c:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800a5f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a62:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a65:	01 d0                	add    %edx,%eax
  800a67:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800a6a:	eb 06                	jmp    800a72 <readline+0xfc>
		}
	}
  800a6c:	e9 3b ff ff ff       	jmp    8009ac <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800a71:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800a72:	c9                   	leave  
  800a73:	c3                   	ret    

00800a74 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800a74:	55                   	push   %ebp
  800a75:	89 e5                	mov    %esp,%ebp
  800a77:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a7a:	e8 41 0a 00 00       	call   8014c0 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800a7f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a83:	74 13                	je     800a98 <atomic_readline+0x24>
		cprintf("%s", prompt);
  800a85:	83 ec 08             	sub    $0x8,%esp
  800a88:	ff 75 08             	pushl  0x8(%ebp)
  800a8b:	68 50 21 80 00       	push   $0x802150
  800a90:	e8 5f f8 ff ff       	call   8002f4 <cprintf>
  800a95:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800a98:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800a9f:	83 ec 0c             	sub    $0xc,%esp
  800aa2:	6a 00                	push   $0x0
  800aa4:	e8 82 0f 00 00       	call   801a2b <iscons>
  800aa9:	83 c4 10             	add    $0x10,%esp
  800aac:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800aaf:	e8 29 0f 00 00       	call   8019dd <getchar>
  800ab4:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800ab7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800abb:	79 23                	jns    800ae0 <atomic_readline+0x6c>
			if (c != -E_EOF)
  800abd:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800ac1:	74 13                	je     800ad6 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800ac3:	83 ec 08             	sub    $0x8,%esp
  800ac6:	ff 75 ec             	pushl  -0x14(%ebp)
  800ac9:	68 53 21 80 00       	push   $0x802153
  800ace:	e8 21 f8 ff ff       	call   8002f4 <cprintf>
  800ad3:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800ad6:	e8 ff 09 00 00       	call   8014da <sys_enable_interrupt>
			return;
  800adb:	e9 9a 00 00 00       	jmp    800b7a <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800ae0:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800ae4:	7e 34                	jle    800b1a <atomic_readline+0xa6>
  800ae6:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800aed:	7f 2b                	jg     800b1a <atomic_readline+0xa6>
			if (echoing)
  800aef:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800af3:	74 0e                	je     800b03 <atomic_readline+0x8f>
				cputchar(c);
  800af5:	83 ec 0c             	sub    $0xc,%esp
  800af8:	ff 75 ec             	pushl  -0x14(%ebp)
  800afb:	e8 95 0e 00 00       	call   801995 <cputchar>
  800b00:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800b03:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b06:	8d 50 01             	lea    0x1(%eax),%edx
  800b09:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800b0c:	89 c2                	mov    %eax,%edx
  800b0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b11:	01 d0                	add    %edx,%eax
  800b13:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b16:	88 10                	mov    %dl,(%eax)
  800b18:	eb 5b                	jmp    800b75 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800b1a:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800b1e:	75 1f                	jne    800b3f <atomic_readline+0xcb>
  800b20:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800b24:	7e 19                	jle    800b3f <atomic_readline+0xcb>
			if (echoing)
  800b26:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b2a:	74 0e                	je     800b3a <atomic_readline+0xc6>
				cputchar(c);
  800b2c:	83 ec 0c             	sub    $0xc,%esp
  800b2f:	ff 75 ec             	pushl  -0x14(%ebp)
  800b32:	e8 5e 0e 00 00       	call   801995 <cputchar>
  800b37:	83 c4 10             	add    $0x10,%esp
			i--;
  800b3a:	ff 4d f4             	decl   -0xc(%ebp)
  800b3d:	eb 36                	jmp    800b75 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800b3f:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800b43:	74 0a                	je     800b4f <atomic_readline+0xdb>
  800b45:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800b49:	0f 85 60 ff ff ff    	jne    800aaf <atomic_readline+0x3b>
			if (echoing)
  800b4f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b53:	74 0e                	je     800b63 <atomic_readline+0xef>
				cputchar(c);
  800b55:	83 ec 0c             	sub    $0xc,%esp
  800b58:	ff 75 ec             	pushl  -0x14(%ebp)
  800b5b:	e8 35 0e 00 00       	call   801995 <cputchar>
  800b60:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800b63:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b69:	01 d0                	add    %edx,%eax
  800b6b:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800b6e:	e8 67 09 00 00       	call   8014da <sys_enable_interrupt>
			return;
  800b73:	eb 05                	jmp    800b7a <atomic_readline+0x106>
		}
	}
  800b75:	e9 35 ff ff ff       	jmp    800aaf <atomic_readline+0x3b>
}
  800b7a:	c9                   	leave  
  800b7b:	c3                   	ret    

00800b7c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b7c:	55                   	push   %ebp
  800b7d:	89 e5                	mov    %esp,%ebp
  800b7f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b82:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b89:	eb 06                	jmp    800b91 <strlen+0x15>
		n++;
  800b8b:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b8e:	ff 45 08             	incl   0x8(%ebp)
  800b91:	8b 45 08             	mov    0x8(%ebp),%eax
  800b94:	8a 00                	mov    (%eax),%al
  800b96:	84 c0                	test   %al,%al
  800b98:	75 f1                	jne    800b8b <strlen+0xf>
		n++;
	return n;
  800b9a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b9d:	c9                   	leave  
  800b9e:	c3                   	ret    

00800b9f <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b9f:	55                   	push   %ebp
  800ba0:	89 e5                	mov    %esp,%ebp
  800ba2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ba5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bac:	eb 09                	jmp    800bb7 <strnlen+0x18>
		n++;
  800bae:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bb1:	ff 45 08             	incl   0x8(%ebp)
  800bb4:	ff 4d 0c             	decl   0xc(%ebp)
  800bb7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bbb:	74 09                	je     800bc6 <strnlen+0x27>
  800bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc0:	8a 00                	mov    (%eax),%al
  800bc2:	84 c0                	test   %al,%al
  800bc4:	75 e8                	jne    800bae <strnlen+0xf>
		n++;
	return n;
  800bc6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bc9:	c9                   	leave  
  800bca:	c3                   	ret    

00800bcb <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bcb:	55                   	push   %ebp
  800bcc:	89 e5                	mov    %esp,%ebp
  800bce:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bd7:	90                   	nop
  800bd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdb:	8d 50 01             	lea    0x1(%eax),%edx
  800bde:	89 55 08             	mov    %edx,0x8(%ebp)
  800be1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800be4:	8d 4a 01             	lea    0x1(%edx),%ecx
  800be7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bea:	8a 12                	mov    (%edx),%dl
  800bec:	88 10                	mov    %dl,(%eax)
  800bee:	8a 00                	mov    (%eax),%al
  800bf0:	84 c0                	test   %al,%al
  800bf2:	75 e4                	jne    800bd8 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bf4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bf7:	c9                   	leave  
  800bf8:	c3                   	ret    

00800bf9 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bf9:	55                   	push   %ebp
  800bfa:	89 e5                	mov    %esp,%ebp
  800bfc:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bff:	8b 45 08             	mov    0x8(%ebp),%eax
  800c02:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c05:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c0c:	eb 1f                	jmp    800c2d <strncpy+0x34>
		*dst++ = *src;
  800c0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c11:	8d 50 01             	lea    0x1(%eax),%edx
  800c14:	89 55 08             	mov    %edx,0x8(%ebp)
  800c17:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c1a:	8a 12                	mov    (%edx),%dl
  800c1c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c21:	8a 00                	mov    (%eax),%al
  800c23:	84 c0                	test   %al,%al
  800c25:	74 03                	je     800c2a <strncpy+0x31>
			src++;
  800c27:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c2a:	ff 45 fc             	incl   -0x4(%ebp)
  800c2d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c30:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c33:	72 d9                	jb     800c0e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c35:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c38:	c9                   	leave  
  800c39:	c3                   	ret    

00800c3a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c3a:	55                   	push   %ebp
  800c3b:	89 e5                	mov    %esp,%ebp
  800c3d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c40:	8b 45 08             	mov    0x8(%ebp),%eax
  800c43:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c46:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c4a:	74 30                	je     800c7c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c4c:	eb 16                	jmp    800c64 <strlcpy+0x2a>
			*dst++ = *src++;
  800c4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c51:	8d 50 01             	lea    0x1(%eax),%edx
  800c54:	89 55 08             	mov    %edx,0x8(%ebp)
  800c57:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c5a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c5d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c60:	8a 12                	mov    (%edx),%dl
  800c62:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c64:	ff 4d 10             	decl   0x10(%ebp)
  800c67:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c6b:	74 09                	je     800c76 <strlcpy+0x3c>
  800c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c70:	8a 00                	mov    (%eax),%al
  800c72:	84 c0                	test   %al,%al
  800c74:	75 d8                	jne    800c4e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c76:	8b 45 08             	mov    0x8(%ebp),%eax
  800c79:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c7c:	8b 55 08             	mov    0x8(%ebp),%edx
  800c7f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c82:	29 c2                	sub    %eax,%edx
  800c84:	89 d0                	mov    %edx,%eax
}
  800c86:	c9                   	leave  
  800c87:	c3                   	ret    

00800c88 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c88:	55                   	push   %ebp
  800c89:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c8b:	eb 06                	jmp    800c93 <strcmp+0xb>
		p++, q++;
  800c8d:	ff 45 08             	incl   0x8(%ebp)
  800c90:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c93:	8b 45 08             	mov    0x8(%ebp),%eax
  800c96:	8a 00                	mov    (%eax),%al
  800c98:	84 c0                	test   %al,%al
  800c9a:	74 0e                	je     800caa <strcmp+0x22>
  800c9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9f:	8a 10                	mov    (%eax),%dl
  800ca1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca4:	8a 00                	mov    (%eax),%al
  800ca6:	38 c2                	cmp    %al,%dl
  800ca8:	74 e3                	je     800c8d <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800caa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cad:	8a 00                	mov    (%eax),%al
  800caf:	0f b6 d0             	movzbl %al,%edx
  800cb2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb5:	8a 00                	mov    (%eax),%al
  800cb7:	0f b6 c0             	movzbl %al,%eax
  800cba:	29 c2                	sub    %eax,%edx
  800cbc:	89 d0                	mov    %edx,%eax
}
  800cbe:	5d                   	pop    %ebp
  800cbf:	c3                   	ret    

00800cc0 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cc0:	55                   	push   %ebp
  800cc1:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cc3:	eb 09                	jmp    800cce <strncmp+0xe>
		n--, p++, q++;
  800cc5:	ff 4d 10             	decl   0x10(%ebp)
  800cc8:	ff 45 08             	incl   0x8(%ebp)
  800ccb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cce:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd2:	74 17                	je     800ceb <strncmp+0x2b>
  800cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd7:	8a 00                	mov    (%eax),%al
  800cd9:	84 c0                	test   %al,%al
  800cdb:	74 0e                	je     800ceb <strncmp+0x2b>
  800cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce0:	8a 10                	mov    (%eax),%dl
  800ce2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce5:	8a 00                	mov    (%eax),%al
  800ce7:	38 c2                	cmp    %al,%dl
  800ce9:	74 da                	je     800cc5 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ceb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cef:	75 07                	jne    800cf8 <strncmp+0x38>
		return 0;
  800cf1:	b8 00 00 00 00       	mov    $0x0,%eax
  800cf6:	eb 14                	jmp    800d0c <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cf8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfb:	8a 00                	mov    (%eax),%al
  800cfd:	0f b6 d0             	movzbl %al,%edx
  800d00:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d03:	8a 00                	mov    (%eax),%al
  800d05:	0f b6 c0             	movzbl %al,%eax
  800d08:	29 c2                	sub    %eax,%edx
  800d0a:	89 d0                	mov    %edx,%eax
}
  800d0c:	5d                   	pop    %ebp
  800d0d:	c3                   	ret    

00800d0e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d0e:	55                   	push   %ebp
  800d0f:	89 e5                	mov    %esp,%ebp
  800d11:	83 ec 04             	sub    $0x4,%esp
  800d14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d17:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d1a:	eb 12                	jmp    800d2e <strchr+0x20>
		if (*s == c)
  800d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1f:	8a 00                	mov    (%eax),%al
  800d21:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d24:	75 05                	jne    800d2b <strchr+0x1d>
			return (char *) s;
  800d26:	8b 45 08             	mov    0x8(%ebp),%eax
  800d29:	eb 11                	jmp    800d3c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d2b:	ff 45 08             	incl   0x8(%ebp)
  800d2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d31:	8a 00                	mov    (%eax),%al
  800d33:	84 c0                	test   %al,%al
  800d35:	75 e5                	jne    800d1c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d37:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d3c:	c9                   	leave  
  800d3d:	c3                   	ret    

00800d3e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d3e:	55                   	push   %ebp
  800d3f:	89 e5                	mov    %esp,%ebp
  800d41:	83 ec 04             	sub    $0x4,%esp
  800d44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d47:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d4a:	eb 0d                	jmp    800d59 <strfind+0x1b>
		if (*s == c)
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	8a 00                	mov    (%eax),%al
  800d51:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d54:	74 0e                	je     800d64 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d56:	ff 45 08             	incl   0x8(%ebp)
  800d59:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5c:	8a 00                	mov    (%eax),%al
  800d5e:	84 c0                	test   %al,%al
  800d60:	75 ea                	jne    800d4c <strfind+0xe>
  800d62:	eb 01                	jmp    800d65 <strfind+0x27>
		if (*s == c)
			break;
  800d64:	90                   	nop
	return (char *) s;
  800d65:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d68:	c9                   	leave  
  800d69:	c3                   	ret    

00800d6a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d6a:	55                   	push   %ebp
  800d6b:	89 e5                	mov    %esp,%ebp
  800d6d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d70:	8b 45 08             	mov    0x8(%ebp),%eax
  800d73:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d76:	8b 45 10             	mov    0x10(%ebp),%eax
  800d79:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d7c:	eb 0e                	jmp    800d8c <memset+0x22>
		*p++ = c;
  800d7e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d81:	8d 50 01             	lea    0x1(%eax),%edx
  800d84:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d87:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d8a:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d8c:	ff 4d f8             	decl   -0x8(%ebp)
  800d8f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d93:	79 e9                	jns    800d7e <memset+0x14>
		*p++ = c;

	return v;
  800d95:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d98:	c9                   	leave  
  800d99:	c3                   	ret    

00800d9a <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d9a:	55                   	push   %ebp
  800d9b:	89 e5                	mov    %esp,%ebp
  800d9d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800da0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800da6:	8b 45 08             	mov    0x8(%ebp),%eax
  800da9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800dac:	eb 16                	jmp    800dc4 <memcpy+0x2a>
		*d++ = *s++;
  800dae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800db1:	8d 50 01             	lea    0x1(%eax),%edx
  800db4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800db7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dba:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dbd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dc0:	8a 12                	mov    (%edx),%dl
  800dc2:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800dc4:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dca:	89 55 10             	mov    %edx,0x10(%ebp)
  800dcd:	85 c0                	test   %eax,%eax
  800dcf:	75 dd                	jne    800dae <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800dd1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dd4:	c9                   	leave  
  800dd5:	c3                   	ret    

00800dd6 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800dd6:	55                   	push   %ebp
  800dd7:	89 e5                	mov    %esp,%ebp
  800dd9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ddc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ddf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800de2:	8b 45 08             	mov    0x8(%ebp),%eax
  800de5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800de8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800deb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dee:	73 50                	jae    800e40 <memmove+0x6a>
  800df0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800df3:	8b 45 10             	mov    0x10(%ebp),%eax
  800df6:	01 d0                	add    %edx,%eax
  800df8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dfb:	76 43                	jbe    800e40 <memmove+0x6a>
		s += n;
  800dfd:	8b 45 10             	mov    0x10(%ebp),%eax
  800e00:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e03:	8b 45 10             	mov    0x10(%ebp),%eax
  800e06:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e09:	eb 10                	jmp    800e1b <memmove+0x45>
			*--d = *--s;
  800e0b:	ff 4d f8             	decl   -0x8(%ebp)
  800e0e:	ff 4d fc             	decl   -0x4(%ebp)
  800e11:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e14:	8a 10                	mov    (%eax),%dl
  800e16:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e19:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e1b:	8b 45 10             	mov    0x10(%ebp),%eax
  800e1e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e21:	89 55 10             	mov    %edx,0x10(%ebp)
  800e24:	85 c0                	test   %eax,%eax
  800e26:	75 e3                	jne    800e0b <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e28:	eb 23                	jmp    800e4d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e2a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e2d:	8d 50 01             	lea    0x1(%eax),%edx
  800e30:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e33:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e36:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e39:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e3c:	8a 12                	mov    (%edx),%dl
  800e3e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e40:	8b 45 10             	mov    0x10(%ebp),%eax
  800e43:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e46:	89 55 10             	mov    %edx,0x10(%ebp)
  800e49:	85 c0                	test   %eax,%eax
  800e4b:	75 dd                	jne    800e2a <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e4d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e50:	c9                   	leave  
  800e51:	c3                   	ret    

00800e52 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e52:	55                   	push   %ebp
  800e53:	89 e5                	mov    %esp,%ebp
  800e55:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e58:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e61:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e64:	eb 2a                	jmp    800e90 <memcmp+0x3e>
		if (*s1 != *s2)
  800e66:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e69:	8a 10                	mov    (%eax),%dl
  800e6b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e6e:	8a 00                	mov    (%eax),%al
  800e70:	38 c2                	cmp    %al,%dl
  800e72:	74 16                	je     800e8a <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e77:	8a 00                	mov    (%eax),%al
  800e79:	0f b6 d0             	movzbl %al,%edx
  800e7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e7f:	8a 00                	mov    (%eax),%al
  800e81:	0f b6 c0             	movzbl %al,%eax
  800e84:	29 c2                	sub    %eax,%edx
  800e86:	89 d0                	mov    %edx,%eax
  800e88:	eb 18                	jmp    800ea2 <memcmp+0x50>
		s1++, s2++;
  800e8a:	ff 45 fc             	incl   -0x4(%ebp)
  800e8d:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e90:	8b 45 10             	mov    0x10(%ebp),%eax
  800e93:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e96:	89 55 10             	mov    %edx,0x10(%ebp)
  800e99:	85 c0                	test   %eax,%eax
  800e9b:	75 c9                	jne    800e66 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e9d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ea2:	c9                   	leave  
  800ea3:	c3                   	ret    

00800ea4 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ea4:	55                   	push   %ebp
  800ea5:	89 e5                	mov    %esp,%ebp
  800ea7:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800eaa:	8b 55 08             	mov    0x8(%ebp),%edx
  800ead:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb0:	01 d0                	add    %edx,%eax
  800eb2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800eb5:	eb 15                	jmp    800ecc <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800eb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eba:	8a 00                	mov    (%eax),%al
  800ebc:	0f b6 d0             	movzbl %al,%edx
  800ebf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec2:	0f b6 c0             	movzbl %al,%eax
  800ec5:	39 c2                	cmp    %eax,%edx
  800ec7:	74 0d                	je     800ed6 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ec9:	ff 45 08             	incl   0x8(%ebp)
  800ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecf:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ed2:	72 e3                	jb     800eb7 <memfind+0x13>
  800ed4:	eb 01                	jmp    800ed7 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ed6:	90                   	nop
	return (void *) s;
  800ed7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800eda:	c9                   	leave  
  800edb:	c3                   	ret    

00800edc <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800edc:	55                   	push   %ebp
  800edd:	89 e5                	mov    %esp,%ebp
  800edf:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ee2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ee9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ef0:	eb 03                	jmp    800ef5 <strtol+0x19>
		s++;
  800ef2:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ef5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef8:	8a 00                	mov    (%eax),%al
  800efa:	3c 20                	cmp    $0x20,%al
  800efc:	74 f4                	je     800ef2 <strtol+0x16>
  800efe:	8b 45 08             	mov    0x8(%ebp),%eax
  800f01:	8a 00                	mov    (%eax),%al
  800f03:	3c 09                	cmp    $0x9,%al
  800f05:	74 eb                	je     800ef2 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f07:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0a:	8a 00                	mov    (%eax),%al
  800f0c:	3c 2b                	cmp    $0x2b,%al
  800f0e:	75 05                	jne    800f15 <strtol+0x39>
		s++;
  800f10:	ff 45 08             	incl   0x8(%ebp)
  800f13:	eb 13                	jmp    800f28 <strtol+0x4c>
	else if (*s == '-')
  800f15:	8b 45 08             	mov    0x8(%ebp),%eax
  800f18:	8a 00                	mov    (%eax),%al
  800f1a:	3c 2d                	cmp    $0x2d,%al
  800f1c:	75 0a                	jne    800f28 <strtol+0x4c>
		s++, neg = 1;
  800f1e:	ff 45 08             	incl   0x8(%ebp)
  800f21:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f28:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f2c:	74 06                	je     800f34 <strtol+0x58>
  800f2e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f32:	75 20                	jne    800f54 <strtol+0x78>
  800f34:	8b 45 08             	mov    0x8(%ebp),%eax
  800f37:	8a 00                	mov    (%eax),%al
  800f39:	3c 30                	cmp    $0x30,%al
  800f3b:	75 17                	jne    800f54 <strtol+0x78>
  800f3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f40:	40                   	inc    %eax
  800f41:	8a 00                	mov    (%eax),%al
  800f43:	3c 78                	cmp    $0x78,%al
  800f45:	75 0d                	jne    800f54 <strtol+0x78>
		s += 2, base = 16;
  800f47:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f4b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f52:	eb 28                	jmp    800f7c <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f54:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f58:	75 15                	jne    800f6f <strtol+0x93>
  800f5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5d:	8a 00                	mov    (%eax),%al
  800f5f:	3c 30                	cmp    $0x30,%al
  800f61:	75 0c                	jne    800f6f <strtol+0x93>
		s++, base = 8;
  800f63:	ff 45 08             	incl   0x8(%ebp)
  800f66:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f6d:	eb 0d                	jmp    800f7c <strtol+0xa0>
	else if (base == 0)
  800f6f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f73:	75 07                	jne    800f7c <strtol+0xa0>
		base = 10;
  800f75:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7f:	8a 00                	mov    (%eax),%al
  800f81:	3c 2f                	cmp    $0x2f,%al
  800f83:	7e 19                	jle    800f9e <strtol+0xc2>
  800f85:	8b 45 08             	mov    0x8(%ebp),%eax
  800f88:	8a 00                	mov    (%eax),%al
  800f8a:	3c 39                	cmp    $0x39,%al
  800f8c:	7f 10                	jg     800f9e <strtol+0xc2>
			dig = *s - '0';
  800f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f91:	8a 00                	mov    (%eax),%al
  800f93:	0f be c0             	movsbl %al,%eax
  800f96:	83 e8 30             	sub    $0x30,%eax
  800f99:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f9c:	eb 42                	jmp    800fe0 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa1:	8a 00                	mov    (%eax),%al
  800fa3:	3c 60                	cmp    $0x60,%al
  800fa5:	7e 19                	jle    800fc0 <strtol+0xe4>
  800fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800faa:	8a 00                	mov    (%eax),%al
  800fac:	3c 7a                	cmp    $0x7a,%al
  800fae:	7f 10                	jg     800fc0 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb3:	8a 00                	mov    (%eax),%al
  800fb5:	0f be c0             	movsbl %al,%eax
  800fb8:	83 e8 57             	sub    $0x57,%eax
  800fbb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fbe:	eb 20                	jmp    800fe0 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc3:	8a 00                	mov    (%eax),%al
  800fc5:	3c 40                	cmp    $0x40,%al
  800fc7:	7e 39                	jle    801002 <strtol+0x126>
  800fc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcc:	8a 00                	mov    (%eax),%al
  800fce:	3c 5a                	cmp    $0x5a,%al
  800fd0:	7f 30                	jg     801002 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd5:	8a 00                	mov    (%eax),%al
  800fd7:	0f be c0             	movsbl %al,%eax
  800fda:	83 e8 37             	sub    $0x37,%eax
  800fdd:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fe0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fe3:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fe6:	7d 19                	jge    801001 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fe8:	ff 45 08             	incl   0x8(%ebp)
  800feb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fee:	0f af 45 10          	imul   0x10(%ebp),%eax
  800ff2:	89 c2                	mov    %eax,%edx
  800ff4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ff7:	01 d0                	add    %edx,%eax
  800ff9:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800ffc:	e9 7b ff ff ff       	jmp    800f7c <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801001:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801002:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801006:	74 08                	je     801010 <strtol+0x134>
		*endptr = (char *) s;
  801008:	8b 45 0c             	mov    0xc(%ebp),%eax
  80100b:	8b 55 08             	mov    0x8(%ebp),%edx
  80100e:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801010:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801014:	74 07                	je     80101d <strtol+0x141>
  801016:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801019:	f7 d8                	neg    %eax
  80101b:	eb 03                	jmp    801020 <strtol+0x144>
  80101d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801020:	c9                   	leave  
  801021:	c3                   	ret    

00801022 <ltostr>:

void
ltostr(long value, char *str)
{
  801022:	55                   	push   %ebp
  801023:	89 e5                	mov    %esp,%ebp
  801025:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801028:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80102f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801036:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80103a:	79 13                	jns    80104f <ltostr+0x2d>
	{
		neg = 1;
  80103c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801043:	8b 45 0c             	mov    0xc(%ebp),%eax
  801046:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801049:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80104c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80104f:	8b 45 08             	mov    0x8(%ebp),%eax
  801052:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801057:	99                   	cltd   
  801058:	f7 f9                	idiv   %ecx
  80105a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80105d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801060:	8d 50 01             	lea    0x1(%eax),%edx
  801063:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801066:	89 c2                	mov    %eax,%edx
  801068:	8b 45 0c             	mov    0xc(%ebp),%eax
  80106b:	01 d0                	add    %edx,%eax
  80106d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801070:	83 c2 30             	add    $0x30,%edx
  801073:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801075:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801078:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80107d:	f7 e9                	imul   %ecx
  80107f:	c1 fa 02             	sar    $0x2,%edx
  801082:	89 c8                	mov    %ecx,%eax
  801084:	c1 f8 1f             	sar    $0x1f,%eax
  801087:	29 c2                	sub    %eax,%edx
  801089:	89 d0                	mov    %edx,%eax
  80108b:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80108e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801091:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801096:	f7 e9                	imul   %ecx
  801098:	c1 fa 02             	sar    $0x2,%edx
  80109b:	89 c8                	mov    %ecx,%eax
  80109d:	c1 f8 1f             	sar    $0x1f,%eax
  8010a0:	29 c2                	sub    %eax,%edx
  8010a2:	89 d0                	mov    %edx,%eax
  8010a4:	c1 e0 02             	shl    $0x2,%eax
  8010a7:	01 d0                	add    %edx,%eax
  8010a9:	01 c0                	add    %eax,%eax
  8010ab:	29 c1                	sub    %eax,%ecx
  8010ad:	89 ca                	mov    %ecx,%edx
  8010af:	85 d2                	test   %edx,%edx
  8010b1:	75 9c                	jne    80104f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010bd:	48                   	dec    %eax
  8010be:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010c1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010c5:	74 3d                	je     801104 <ltostr+0xe2>
		start = 1 ;
  8010c7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010ce:	eb 34                	jmp    801104 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010d0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d6:	01 d0                	add    %edx,%eax
  8010d8:	8a 00                	mov    (%eax),%al
  8010da:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010dd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e3:	01 c2                	add    %eax,%edx
  8010e5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010eb:	01 c8                	add    %ecx,%eax
  8010ed:	8a 00                	mov    (%eax),%al
  8010ef:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010f1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f7:	01 c2                	add    %eax,%edx
  8010f9:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010fc:	88 02                	mov    %al,(%edx)
		start++ ;
  8010fe:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801101:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801104:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801107:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80110a:	7c c4                	jl     8010d0 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80110c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80110f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801112:	01 d0                	add    %edx,%eax
  801114:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801117:	90                   	nop
  801118:	c9                   	leave  
  801119:	c3                   	ret    

0080111a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80111a:	55                   	push   %ebp
  80111b:	89 e5                	mov    %esp,%ebp
  80111d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801120:	ff 75 08             	pushl  0x8(%ebp)
  801123:	e8 54 fa ff ff       	call   800b7c <strlen>
  801128:	83 c4 04             	add    $0x4,%esp
  80112b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80112e:	ff 75 0c             	pushl  0xc(%ebp)
  801131:	e8 46 fa ff ff       	call   800b7c <strlen>
  801136:	83 c4 04             	add    $0x4,%esp
  801139:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80113c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801143:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80114a:	eb 17                	jmp    801163 <strcconcat+0x49>
		final[s] = str1[s] ;
  80114c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80114f:	8b 45 10             	mov    0x10(%ebp),%eax
  801152:	01 c2                	add    %eax,%edx
  801154:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801157:	8b 45 08             	mov    0x8(%ebp),%eax
  80115a:	01 c8                	add    %ecx,%eax
  80115c:	8a 00                	mov    (%eax),%al
  80115e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801160:	ff 45 fc             	incl   -0x4(%ebp)
  801163:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801166:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801169:	7c e1                	jl     80114c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80116b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801172:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801179:	eb 1f                	jmp    80119a <strcconcat+0x80>
		final[s++] = str2[i] ;
  80117b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80117e:	8d 50 01             	lea    0x1(%eax),%edx
  801181:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801184:	89 c2                	mov    %eax,%edx
  801186:	8b 45 10             	mov    0x10(%ebp),%eax
  801189:	01 c2                	add    %eax,%edx
  80118b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80118e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801191:	01 c8                	add    %ecx,%eax
  801193:	8a 00                	mov    (%eax),%al
  801195:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801197:	ff 45 f8             	incl   -0x8(%ebp)
  80119a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80119d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011a0:	7c d9                	jl     80117b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011a2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a8:	01 d0                	add    %edx,%eax
  8011aa:	c6 00 00             	movb   $0x0,(%eax)
}
  8011ad:	90                   	nop
  8011ae:	c9                   	leave  
  8011af:	c3                   	ret    

008011b0 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011b0:	55                   	push   %ebp
  8011b1:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8011b6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8011bf:	8b 00                	mov    (%eax),%eax
  8011c1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011cb:	01 d0                	add    %edx,%eax
  8011cd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011d3:	eb 0c                	jmp    8011e1 <strsplit+0x31>
			*string++ = 0;
  8011d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d8:	8d 50 01             	lea    0x1(%eax),%edx
  8011db:	89 55 08             	mov    %edx,0x8(%ebp)
  8011de:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e4:	8a 00                	mov    (%eax),%al
  8011e6:	84 c0                	test   %al,%al
  8011e8:	74 18                	je     801202 <strsplit+0x52>
  8011ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ed:	8a 00                	mov    (%eax),%al
  8011ef:	0f be c0             	movsbl %al,%eax
  8011f2:	50                   	push   %eax
  8011f3:	ff 75 0c             	pushl  0xc(%ebp)
  8011f6:	e8 13 fb ff ff       	call   800d0e <strchr>
  8011fb:	83 c4 08             	add    $0x8,%esp
  8011fe:	85 c0                	test   %eax,%eax
  801200:	75 d3                	jne    8011d5 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801202:	8b 45 08             	mov    0x8(%ebp),%eax
  801205:	8a 00                	mov    (%eax),%al
  801207:	84 c0                	test   %al,%al
  801209:	74 5a                	je     801265 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80120b:	8b 45 14             	mov    0x14(%ebp),%eax
  80120e:	8b 00                	mov    (%eax),%eax
  801210:	83 f8 0f             	cmp    $0xf,%eax
  801213:	75 07                	jne    80121c <strsplit+0x6c>
		{
			return 0;
  801215:	b8 00 00 00 00       	mov    $0x0,%eax
  80121a:	eb 66                	jmp    801282 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80121c:	8b 45 14             	mov    0x14(%ebp),%eax
  80121f:	8b 00                	mov    (%eax),%eax
  801221:	8d 48 01             	lea    0x1(%eax),%ecx
  801224:	8b 55 14             	mov    0x14(%ebp),%edx
  801227:	89 0a                	mov    %ecx,(%edx)
  801229:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801230:	8b 45 10             	mov    0x10(%ebp),%eax
  801233:	01 c2                	add    %eax,%edx
  801235:	8b 45 08             	mov    0x8(%ebp),%eax
  801238:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80123a:	eb 03                	jmp    80123f <strsplit+0x8f>
			string++;
  80123c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80123f:	8b 45 08             	mov    0x8(%ebp),%eax
  801242:	8a 00                	mov    (%eax),%al
  801244:	84 c0                	test   %al,%al
  801246:	74 8b                	je     8011d3 <strsplit+0x23>
  801248:	8b 45 08             	mov    0x8(%ebp),%eax
  80124b:	8a 00                	mov    (%eax),%al
  80124d:	0f be c0             	movsbl %al,%eax
  801250:	50                   	push   %eax
  801251:	ff 75 0c             	pushl  0xc(%ebp)
  801254:	e8 b5 fa ff ff       	call   800d0e <strchr>
  801259:	83 c4 08             	add    $0x8,%esp
  80125c:	85 c0                	test   %eax,%eax
  80125e:	74 dc                	je     80123c <strsplit+0x8c>
			string++;
	}
  801260:	e9 6e ff ff ff       	jmp    8011d3 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801265:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801266:	8b 45 14             	mov    0x14(%ebp),%eax
  801269:	8b 00                	mov    (%eax),%eax
  80126b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801272:	8b 45 10             	mov    0x10(%ebp),%eax
  801275:	01 d0                	add    %edx,%eax
  801277:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80127d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801282:	c9                   	leave  
  801283:	c3                   	ret    

00801284 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801284:	55                   	push   %ebp
  801285:	89 e5                	mov    %esp,%ebp
  801287:	57                   	push   %edi
  801288:	56                   	push   %esi
  801289:	53                   	push   %ebx
  80128a:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80128d:	8b 45 08             	mov    0x8(%ebp),%eax
  801290:	8b 55 0c             	mov    0xc(%ebp),%edx
  801293:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801296:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801299:	8b 7d 18             	mov    0x18(%ebp),%edi
  80129c:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80129f:	cd 30                	int    $0x30
  8012a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012a7:	83 c4 10             	add    $0x10,%esp
  8012aa:	5b                   	pop    %ebx
  8012ab:	5e                   	pop    %esi
  8012ac:	5f                   	pop    %edi
  8012ad:	5d                   	pop    %ebp
  8012ae:	c3                   	ret    

008012af <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012af:	55                   	push   %ebp
  8012b0:	89 e5                	mov    %esp,%ebp
  8012b2:	83 ec 04             	sub    $0x4,%esp
  8012b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012bb:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c2:	6a 00                	push   $0x0
  8012c4:	6a 00                	push   $0x0
  8012c6:	52                   	push   %edx
  8012c7:	ff 75 0c             	pushl  0xc(%ebp)
  8012ca:	50                   	push   %eax
  8012cb:	6a 00                	push   $0x0
  8012cd:	e8 b2 ff ff ff       	call   801284 <syscall>
  8012d2:	83 c4 18             	add    $0x18,%esp
}
  8012d5:	90                   	nop
  8012d6:	c9                   	leave  
  8012d7:	c3                   	ret    

008012d8 <sys_cgetc>:

int
sys_cgetc(void)
{
  8012d8:	55                   	push   %ebp
  8012d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012db:	6a 00                	push   $0x0
  8012dd:	6a 00                	push   $0x0
  8012df:	6a 00                	push   $0x0
  8012e1:	6a 00                	push   $0x0
  8012e3:	6a 00                	push   $0x0
  8012e5:	6a 01                	push   $0x1
  8012e7:	e8 98 ff ff ff       	call   801284 <syscall>
  8012ec:	83 c4 18             	add    $0x18,%esp
}
  8012ef:	c9                   	leave  
  8012f0:	c3                   	ret    

008012f1 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012f1:	55                   	push   %ebp
  8012f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f7:	6a 00                	push   $0x0
  8012f9:	6a 00                	push   $0x0
  8012fb:	6a 00                	push   $0x0
  8012fd:	6a 00                	push   $0x0
  8012ff:	50                   	push   %eax
  801300:	6a 05                	push   $0x5
  801302:	e8 7d ff ff ff       	call   801284 <syscall>
  801307:	83 c4 18             	add    $0x18,%esp
}
  80130a:	c9                   	leave  
  80130b:	c3                   	ret    

0080130c <sys_getenvid>:

int32 sys_getenvid(void)
{
  80130c:	55                   	push   %ebp
  80130d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80130f:	6a 00                	push   $0x0
  801311:	6a 00                	push   $0x0
  801313:	6a 00                	push   $0x0
  801315:	6a 00                	push   $0x0
  801317:	6a 00                	push   $0x0
  801319:	6a 02                	push   $0x2
  80131b:	e8 64 ff ff ff       	call   801284 <syscall>
  801320:	83 c4 18             	add    $0x18,%esp
}
  801323:	c9                   	leave  
  801324:	c3                   	ret    

00801325 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801325:	55                   	push   %ebp
  801326:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801328:	6a 00                	push   $0x0
  80132a:	6a 00                	push   $0x0
  80132c:	6a 00                	push   $0x0
  80132e:	6a 00                	push   $0x0
  801330:	6a 00                	push   $0x0
  801332:	6a 03                	push   $0x3
  801334:	e8 4b ff ff ff       	call   801284 <syscall>
  801339:	83 c4 18             	add    $0x18,%esp
}
  80133c:	c9                   	leave  
  80133d:	c3                   	ret    

0080133e <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80133e:	55                   	push   %ebp
  80133f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801341:	6a 00                	push   $0x0
  801343:	6a 00                	push   $0x0
  801345:	6a 00                	push   $0x0
  801347:	6a 00                	push   $0x0
  801349:	6a 00                	push   $0x0
  80134b:	6a 04                	push   $0x4
  80134d:	e8 32 ff ff ff       	call   801284 <syscall>
  801352:	83 c4 18             	add    $0x18,%esp
}
  801355:	c9                   	leave  
  801356:	c3                   	ret    

00801357 <sys_env_exit>:


void sys_env_exit(void)
{
  801357:	55                   	push   %ebp
  801358:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80135a:	6a 00                	push   $0x0
  80135c:	6a 00                	push   $0x0
  80135e:	6a 00                	push   $0x0
  801360:	6a 00                	push   $0x0
  801362:	6a 00                	push   $0x0
  801364:	6a 06                	push   $0x6
  801366:	e8 19 ff ff ff       	call   801284 <syscall>
  80136b:	83 c4 18             	add    $0x18,%esp
}
  80136e:	90                   	nop
  80136f:	c9                   	leave  
  801370:	c3                   	ret    

00801371 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801371:	55                   	push   %ebp
  801372:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801374:	8b 55 0c             	mov    0xc(%ebp),%edx
  801377:	8b 45 08             	mov    0x8(%ebp),%eax
  80137a:	6a 00                	push   $0x0
  80137c:	6a 00                	push   $0x0
  80137e:	6a 00                	push   $0x0
  801380:	52                   	push   %edx
  801381:	50                   	push   %eax
  801382:	6a 07                	push   $0x7
  801384:	e8 fb fe ff ff       	call   801284 <syscall>
  801389:	83 c4 18             	add    $0x18,%esp
}
  80138c:	c9                   	leave  
  80138d:	c3                   	ret    

0080138e <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80138e:	55                   	push   %ebp
  80138f:	89 e5                	mov    %esp,%ebp
  801391:	56                   	push   %esi
  801392:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801393:	8b 75 18             	mov    0x18(%ebp),%esi
  801396:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801399:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80139c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80139f:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a2:	56                   	push   %esi
  8013a3:	53                   	push   %ebx
  8013a4:	51                   	push   %ecx
  8013a5:	52                   	push   %edx
  8013a6:	50                   	push   %eax
  8013a7:	6a 08                	push   $0x8
  8013a9:	e8 d6 fe ff ff       	call   801284 <syscall>
  8013ae:	83 c4 18             	add    $0x18,%esp
}
  8013b1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013b4:	5b                   	pop    %ebx
  8013b5:	5e                   	pop    %esi
  8013b6:	5d                   	pop    %ebp
  8013b7:	c3                   	ret    

008013b8 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013b8:	55                   	push   %ebp
  8013b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013be:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c1:	6a 00                	push   $0x0
  8013c3:	6a 00                	push   $0x0
  8013c5:	6a 00                	push   $0x0
  8013c7:	52                   	push   %edx
  8013c8:	50                   	push   %eax
  8013c9:	6a 09                	push   $0x9
  8013cb:	e8 b4 fe ff ff       	call   801284 <syscall>
  8013d0:	83 c4 18             	add    $0x18,%esp
}
  8013d3:	c9                   	leave  
  8013d4:	c3                   	ret    

008013d5 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013d5:	55                   	push   %ebp
  8013d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013d8:	6a 00                	push   $0x0
  8013da:	6a 00                	push   $0x0
  8013dc:	6a 00                	push   $0x0
  8013de:	ff 75 0c             	pushl  0xc(%ebp)
  8013e1:	ff 75 08             	pushl  0x8(%ebp)
  8013e4:	6a 0a                	push   $0xa
  8013e6:	e8 99 fe ff ff       	call   801284 <syscall>
  8013eb:	83 c4 18             	add    $0x18,%esp
}
  8013ee:	c9                   	leave  
  8013ef:	c3                   	ret    

008013f0 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013f0:	55                   	push   %ebp
  8013f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013f3:	6a 00                	push   $0x0
  8013f5:	6a 00                	push   $0x0
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 00                	push   $0x0
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 0b                	push   $0xb
  8013ff:	e8 80 fe ff ff       	call   801284 <syscall>
  801404:	83 c4 18             	add    $0x18,%esp
}
  801407:	c9                   	leave  
  801408:	c3                   	ret    

00801409 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801409:	55                   	push   %ebp
  80140a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80140c:	6a 00                	push   $0x0
  80140e:	6a 00                	push   $0x0
  801410:	6a 00                	push   $0x0
  801412:	6a 00                	push   $0x0
  801414:	6a 00                	push   $0x0
  801416:	6a 0c                	push   $0xc
  801418:	e8 67 fe ff ff       	call   801284 <syscall>
  80141d:	83 c4 18             	add    $0x18,%esp
}
  801420:	c9                   	leave  
  801421:	c3                   	ret    

00801422 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801422:	55                   	push   %ebp
  801423:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801425:	6a 00                	push   $0x0
  801427:	6a 00                	push   $0x0
  801429:	6a 00                	push   $0x0
  80142b:	6a 00                	push   $0x0
  80142d:	6a 00                	push   $0x0
  80142f:	6a 0d                	push   $0xd
  801431:	e8 4e fe ff ff       	call   801284 <syscall>
  801436:	83 c4 18             	add    $0x18,%esp
}
  801439:	c9                   	leave  
  80143a:	c3                   	ret    

0080143b <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80143b:	55                   	push   %ebp
  80143c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80143e:	6a 00                	push   $0x0
  801440:	6a 00                	push   $0x0
  801442:	6a 00                	push   $0x0
  801444:	ff 75 0c             	pushl  0xc(%ebp)
  801447:	ff 75 08             	pushl  0x8(%ebp)
  80144a:	6a 11                	push   $0x11
  80144c:	e8 33 fe ff ff       	call   801284 <syscall>
  801451:	83 c4 18             	add    $0x18,%esp
	return;
  801454:	90                   	nop
}
  801455:	c9                   	leave  
  801456:	c3                   	ret    

00801457 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801457:	55                   	push   %ebp
  801458:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	6a 00                	push   $0x0
  801460:	ff 75 0c             	pushl  0xc(%ebp)
  801463:	ff 75 08             	pushl  0x8(%ebp)
  801466:	6a 12                	push   $0x12
  801468:	e8 17 fe ff ff       	call   801284 <syscall>
  80146d:	83 c4 18             	add    $0x18,%esp
	return ;
  801470:	90                   	nop
}
  801471:	c9                   	leave  
  801472:	c3                   	ret    

00801473 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801473:	55                   	push   %ebp
  801474:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801476:	6a 00                	push   $0x0
  801478:	6a 00                	push   $0x0
  80147a:	6a 00                	push   $0x0
  80147c:	6a 00                	push   $0x0
  80147e:	6a 00                	push   $0x0
  801480:	6a 0e                	push   $0xe
  801482:	e8 fd fd ff ff       	call   801284 <syscall>
  801487:	83 c4 18             	add    $0x18,%esp
}
  80148a:	c9                   	leave  
  80148b:	c3                   	ret    

0080148c <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80148c:	55                   	push   %ebp
  80148d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80148f:	6a 00                	push   $0x0
  801491:	6a 00                	push   $0x0
  801493:	6a 00                	push   $0x0
  801495:	6a 00                	push   $0x0
  801497:	ff 75 08             	pushl  0x8(%ebp)
  80149a:	6a 0f                	push   $0xf
  80149c:	e8 e3 fd ff ff       	call   801284 <syscall>
  8014a1:	83 c4 18             	add    $0x18,%esp
}
  8014a4:	c9                   	leave  
  8014a5:	c3                   	ret    

008014a6 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014a6:	55                   	push   %ebp
  8014a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 00                	push   $0x0
  8014ad:	6a 00                	push   $0x0
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 10                	push   $0x10
  8014b5:	e8 ca fd ff ff       	call   801284 <syscall>
  8014ba:	83 c4 18             	add    $0x18,%esp
}
  8014bd:	90                   	nop
  8014be:	c9                   	leave  
  8014bf:	c3                   	ret    

008014c0 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014c0:	55                   	push   %ebp
  8014c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 00                	push   $0x0
  8014c7:	6a 00                	push   $0x0
  8014c9:	6a 00                	push   $0x0
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 14                	push   $0x14
  8014cf:	e8 b0 fd ff ff       	call   801284 <syscall>
  8014d4:	83 c4 18             	add    $0x18,%esp
}
  8014d7:	90                   	nop
  8014d8:	c9                   	leave  
  8014d9:	c3                   	ret    

008014da <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014da:	55                   	push   %ebp
  8014db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	6a 00                	push   $0x0
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 15                	push   $0x15
  8014e9:	e8 96 fd ff ff       	call   801284 <syscall>
  8014ee:	83 c4 18             	add    $0x18,%esp
}
  8014f1:	90                   	nop
  8014f2:	c9                   	leave  
  8014f3:	c3                   	ret    

008014f4 <sys_cputc>:


void
sys_cputc(const char c)
{
  8014f4:	55                   	push   %ebp
  8014f5:	89 e5                	mov    %esp,%ebp
  8014f7:	83 ec 04             	sub    $0x4,%esp
  8014fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801500:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801504:	6a 00                	push   $0x0
  801506:	6a 00                	push   $0x0
  801508:	6a 00                	push   $0x0
  80150a:	6a 00                	push   $0x0
  80150c:	50                   	push   %eax
  80150d:	6a 16                	push   $0x16
  80150f:	e8 70 fd ff ff       	call   801284 <syscall>
  801514:	83 c4 18             	add    $0x18,%esp
}
  801517:	90                   	nop
  801518:	c9                   	leave  
  801519:	c3                   	ret    

0080151a <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80151a:	55                   	push   %ebp
  80151b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80151d:	6a 00                	push   $0x0
  80151f:	6a 00                	push   $0x0
  801521:	6a 00                	push   $0x0
  801523:	6a 00                	push   $0x0
  801525:	6a 00                	push   $0x0
  801527:	6a 17                	push   $0x17
  801529:	e8 56 fd ff ff       	call   801284 <syscall>
  80152e:	83 c4 18             	add    $0x18,%esp
}
  801531:	90                   	nop
  801532:	c9                   	leave  
  801533:	c3                   	ret    

00801534 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801534:	55                   	push   %ebp
  801535:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801537:	8b 45 08             	mov    0x8(%ebp),%eax
  80153a:	6a 00                	push   $0x0
  80153c:	6a 00                	push   $0x0
  80153e:	6a 00                	push   $0x0
  801540:	ff 75 0c             	pushl  0xc(%ebp)
  801543:	50                   	push   %eax
  801544:	6a 18                	push   $0x18
  801546:	e8 39 fd ff ff       	call   801284 <syscall>
  80154b:	83 c4 18             	add    $0x18,%esp
}
  80154e:	c9                   	leave  
  80154f:	c3                   	ret    

00801550 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801550:	55                   	push   %ebp
  801551:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801553:	8b 55 0c             	mov    0xc(%ebp),%edx
  801556:	8b 45 08             	mov    0x8(%ebp),%eax
  801559:	6a 00                	push   $0x0
  80155b:	6a 00                	push   $0x0
  80155d:	6a 00                	push   $0x0
  80155f:	52                   	push   %edx
  801560:	50                   	push   %eax
  801561:	6a 1b                	push   $0x1b
  801563:	e8 1c fd ff ff       	call   801284 <syscall>
  801568:	83 c4 18             	add    $0x18,%esp
}
  80156b:	c9                   	leave  
  80156c:	c3                   	ret    

0080156d <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80156d:	55                   	push   %ebp
  80156e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801570:	8b 55 0c             	mov    0xc(%ebp),%edx
  801573:	8b 45 08             	mov    0x8(%ebp),%eax
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	6a 00                	push   $0x0
  80157c:	52                   	push   %edx
  80157d:	50                   	push   %eax
  80157e:	6a 19                	push   $0x19
  801580:	e8 ff fc ff ff       	call   801284 <syscall>
  801585:	83 c4 18             	add    $0x18,%esp
}
  801588:	90                   	nop
  801589:	c9                   	leave  
  80158a:	c3                   	ret    

0080158b <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80158b:	55                   	push   %ebp
  80158c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80158e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801591:	8b 45 08             	mov    0x8(%ebp),%eax
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	52                   	push   %edx
  80159b:	50                   	push   %eax
  80159c:	6a 1a                	push   $0x1a
  80159e:	e8 e1 fc ff ff       	call   801284 <syscall>
  8015a3:	83 c4 18             	add    $0x18,%esp
}
  8015a6:	90                   	nop
  8015a7:	c9                   	leave  
  8015a8:	c3                   	ret    

008015a9 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015a9:	55                   	push   %ebp
  8015aa:	89 e5                	mov    %esp,%ebp
  8015ac:	83 ec 04             	sub    $0x4,%esp
  8015af:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b2:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015b5:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015b8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bf:	6a 00                	push   $0x0
  8015c1:	51                   	push   %ecx
  8015c2:	52                   	push   %edx
  8015c3:	ff 75 0c             	pushl  0xc(%ebp)
  8015c6:	50                   	push   %eax
  8015c7:	6a 1c                	push   $0x1c
  8015c9:	e8 b6 fc ff ff       	call   801284 <syscall>
  8015ce:	83 c4 18             	add    $0x18,%esp
}
  8015d1:	c9                   	leave  
  8015d2:	c3                   	ret    

008015d3 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015d3:	55                   	push   %ebp
  8015d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	52                   	push   %edx
  8015e3:	50                   	push   %eax
  8015e4:	6a 1d                	push   $0x1d
  8015e6:	e8 99 fc ff ff       	call   801284 <syscall>
  8015eb:	83 c4 18             	add    $0x18,%esp
}
  8015ee:	c9                   	leave  
  8015ef:	c3                   	ret    

008015f0 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015f0:	55                   	push   %ebp
  8015f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015f3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 00                	push   $0x0
  801600:	51                   	push   %ecx
  801601:	52                   	push   %edx
  801602:	50                   	push   %eax
  801603:	6a 1e                	push   $0x1e
  801605:	e8 7a fc ff ff       	call   801284 <syscall>
  80160a:	83 c4 18             	add    $0x18,%esp
}
  80160d:	c9                   	leave  
  80160e:	c3                   	ret    

0080160f <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80160f:	55                   	push   %ebp
  801610:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801612:	8b 55 0c             	mov    0xc(%ebp),%edx
  801615:	8b 45 08             	mov    0x8(%ebp),%eax
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	6a 00                	push   $0x0
  80161e:	52                   	push   %edx
  80161f:	50                   	push   %eax
  801620:	6a 1f                	push   $0x1f
  801622:	e8 5d fc ff ff       	call   801284 <syscall>
  801627:	83 c4 18             	add    $0x18,%esp
}
  80162a:	c9                   	leave  
  80162b:	c3                   	ret    

0080162c <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80162c:	55                   	push   %ebp
  80162d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80162f:	6a 00                	push   $0x0
  801631:	6a 00                	push   $0x0
  801633:	6a 00                	push   $0x0
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	6a 20                	push   $0x20
  80163b:	e8 44 fc ff ff       	call   801284 <syscall>
  801640:	83 c4 18             	add    $0x18,%esp
}
  801643:	c9                   	leave  
  801644:	c3                   	ret    

00801645 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801645:	55                   	push   %ebp
  801646:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801648:	8b 45 08             	mov    0x8(%ebp),%eax
  80164b:	6a 00                	push   $0x0
  80164d:	ff 75 14             	pushl  0x14(%ebp)
  801650:	ff 75 10             	pushl  0x10(%ebp)
  801653:	ff 75 0c             	pushl  0xc(%ebp)
  801656:	50                   	push   %eax
  801657:	6a 21                	push   $0x21
  801659:	e8 26 fc ff ff       	call   801284 <syscall>
  80165e:	83 c4 18             	add    $0x18,%esp
}
  801661:	c9                   	leave  
  801662:	c3                   	ret    

00801663 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801663:	55                   	push   %ebp
  801664:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801666:	8b 45 08             	mov    0x8(%ebp),%eax
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 00                	push   $0x0
  801671:	50                   	push   %eax
  801672:	6a 22                	push   $0x22
  801674:	e8 0b fc ff ff       	call   801284 <syscall>
  801679:	83 c4 18             	add    $0x18,%esp
}
  80167c:	90                   	nop
  80167d:	c9                   	leave  
  80167e:	c3                   	ret    

0080167f <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80167f:	55                   	push   %ebp
  801680:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801682:	8b 45 08             	mov    0x8(%ebp),%eax
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	6a 00                	push   $0x0
  80168d:	50                   	push   %eax
  80168e:	6a 23                	push   $0x23
  801690:	e8 ef fb ff ff       	call   801284 <syscall>
  801695:	83 c4 18             	add    $0x18,%esp
}
  801698:	90                   	nop
  801699:	c9                   	leave  
  80169a:	c3                   	ret    

0080169b <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80169b:	55                   	push   %ebp
  80169c:	89 e5                	mov    %esp,%ebp
  80169e:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8016a1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016a4:	8d 50 04             	lea    0x4(%eax),%edx
  8016a7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016aa:	6a 00                	push   $0x0
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	52                   	push   %edx
  8016b1:	50                   	push   %eax
  8016b2:	6a 24                	push   $0x24
  8016b4:	e8 cb fb ff ff       	call   801284 <syscall>
  8016b9:	83 c4 18             	add    $0x18,%esp
	return result;
  8016bc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016c2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016c5:	89 01                	mov    %eax,(%ecx)
  8016c7:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cd:	c9                   	leave  
  8016ce:	c2 04 00             	ret    $0x4

008016d1 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016d1:	55                   	push   %ebp
  8016d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016d4:	6a 00                	push   $0x0
  8016d6:	6a 00                	push   $0x0
  8016d8:	ff 75 10             	pushl  0x10(%ebp)
  8016db:	ff 75 0c             	pushl  0xc(%ebp)
  8016de:	ff 75 08             	pushl  0x8(%ebp)
  8016e1:	6a 13                	push   $0x13
  8016e3:	e8 9c fb ff ff       	call   801284 <syscall>
  8016e8:	83 c4 18             	add    $0x18,%esp
	return ;
  8016eb:	90                   	nop
}
  8016ec:	c9                   	leave  
  8016ed:	c3                   	ret    

008016ee <sys_rcr2>:
uint32 sys_rcr2()
{
  8016ee:	55                   	push   %ebp
  8016ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016f1:	6a 00                	push   $0x0
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 25                	push   $0x25
  8016fd:	e8 82 fb ff ff       	call   801284 <syscall>
  801702:	83 c4 18             	add    $0x18,%esp
}
  801705:	c9                   	leave  
  801706:	c3                   	ret    

00801707 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801707:	55                   	push   %ebp
  801708:	89 e5                	mov    %esp,%ebp
  80170a:	83 ec 04             	sub    $0x4,%esp
  80170d:	8b 45 08             	mov    0x8(%ebp),%eax
  801710:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801713:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801717:	6a 00                	push   $0x0
  801719:	6a 00                	push   $0x0
  80171b:	6a 00                	push   $0x0
  80171d:	6a 00                	push   $0x0
  80171f:	50                   	push   %eax
  801720:	6a 26                	push   $0x26
  801722:	e8 5d fb ff ff       	call   801284 <syscall>
  801727:	83 c4 18             	add    $0x18,%esp
	return ;
  80172a:	90                   	nop
}
  80172b:	c9                   	leave  
  80172c:	c3                   	ret    

0080172d <rsttst>:
void rsttst()
{
  80172d:	55                   	push   %ebp
  80172e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801730:	6a 00                	push   $0x0
  801732:	6a 00                	push   $0x0
  801734:	6a 00                	push   $0x0
  801736:	6a 00                	push   $0x0
  801738:	6a 00                	push   $0x0
  80173a:	6a 28                	push   $0x28
  80173c:	e8 43 fb ff ff       	call   801284 <syscall>
  801741:	83 c4 18             	add    $0x18,%esp
	return ;
  801744:	90                   	nop
}
  801745:	c9                   	leave  
  801746:	c3                   	ret    

00801747 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801747:	55                   	push   %ebp
  801748:	89 e5                	mov    %esp,%ebp
  80174a:	83 ec 04             	sub    $0x4,%esp
  80174d:	8b 45 14             	mov    0x14(%ebp),%eax
  801750:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801753:	8b 55 18             	mov    0x18(%ebp),%edx
  801756:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80175a:	52                   	push   %edx
  80175b:	50                   	push   %eax
  80175c:	ff 75 10             	pushl  0x10(%ebp)
  80175f:	ff 75 0c             	pushl  0xc(%ebp)
  801762:	ff 75 08             	pushl  0x8(%ebp)
  801765:	6a 27                	push   $0x27
  801767:	e8 18 fb ff ff       	call   801284 <syscall>
  80176c:	83 c4 18             	add    $0x18,%esp
	return ;
  80176f:	90                   	nop
}
  801770:	c9                   	leave  
  801771:	c3                   	ret    

00801772 <chktst>:
void chktst(uint32 n)
{
  801772:	55                   	push   %ebp
  801773:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	ff 75 08             	pushl  0x8(%ebp)
  801780:	6a 29                	push   $0x29
  801782:	e8 fd fa ff ff       	call   801284 <syscall>
  801787:	83 c4 18             	add    $0x18,%esp
	return ;
  80178a:	90                   	nop
}
  80178b:	c9                   	leave  
  80178c:	c3                   	ret    

0080178d <inctst>:

void inctst()
{
  80178d:	55                   	push   %ebp
  80178e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801790:	6a 00                	push   $0x0
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 2a                	push   $0x2a
  80179c:	e8 e3 fa ff ff       	call   801284 <syscall>
  8017a1:	83 c4 18             	add    $0x18,%esp
	return ;
  8017a4:	90                   	nop
}
  8017a5:	c9                   	leave  
  8017a6:	c3                   	ret    

008017a7 <gettst>:
uint32 gettst()
{
  8017a7:	55                   	push   %ebp
  8017a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 2b                	push   $0x2b
  8017b6:	e8 c9 fa ff ff       	call   801284 <syscall>
  8017bb:	83 c4 18             	add    $0x18,%esp
}
  8017be:	c9                   	leave  
  8017bf:	c3                   	ret    

008017c0 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017c0:	55                   	push   %ebp
  8017c1:	89 e5                	mov    %esp,%ebp
  8017c3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 2c                	push   $0x2c
  8017d2:	e8 ad fa ff ff       	call   801284 <syscall>
  8017d7:	83 c4 18             	add    $0x18,%esp
  8017da:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017dd:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017e1:	75 07                	jne    8017ea <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017e3:	b8 01 00 00 00       	mov    $0x1,%eax
  8017e8:	eb 05                	jmp    8017ef <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017ea:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017ef:	c9                   	leave  
  8017f0:	c3                   	ret    

008017f1 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017f1:	55                   	push   %ebp
  8017f2:	89 e5                	mov    %esp,%ebp
  8017f4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 2c                	push   $0x2c
  801803:	e8 7c fa ff ff       	call   801284 <syscall>
  801808:	83 c4 18             	add    $0x18,%esp
  80180b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80180e:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801812:	75 07                	jne    80181b <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801814:	b8 01 00 00 00       	mov    $0x1,%eax
  801819:	eb 05                	jmp    801820 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80181b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801820:	c9                   	leave  
  801821:	c3                   	ret    

00801822 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801822:	55                   	push   %ebp
  801823:	89 e5                	mov    %esp,%ebp
  801825:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 2c                	push   $0x2c
  801834:	e8 4b fa ff ff       	call   801284 <syscall>
  801839:	83 c4 18             	add    $0x18,%esp
  80183c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80183f:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801843:	75 07                	jne    80184c <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801845:	b8 01 00 00 00       	mov    $0x1,%eax
  80184a:	eb 05                	jmp    801851 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80184c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801851:	c9                   	leave  
  801852:	c3                   	ret    

00801853 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801853:	55                   	push   %ebp
  801854:	89 e5                	mov    %esp,%ebp
  801856:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801859:	6a 00                	push   $0x0
  80185b:	6a 00                	push   $0x0
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	6a 2c                	push   $0x2c
  801865:	e8 1a fa ff ff       	call   801284 <syscall>
  80186a:	83 c4 18             	add    $0x18,%esp
  80186d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801870:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801874:	75 07                	jne    80187d <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801876:	b8 01 00 00 00       	mov    $0x1,%eax
  80187b:	eb 05                	jmp    801882 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80187d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801882:	c9                   	leave  
  801883:	c3                   	ret    

00801884 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801884:	55                   	push   %ebp
  801885:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801887:	6a 00                	push   $0x0
  801889:	6a 00                	push   $0x0
  80188b:	6a 00                	push   $0x0
  80188d:	6a 00                	push   $0x0
  80188f:	ff 75 08             	pushl  0x8(%ebp)
  801892:	6a 2d                	push   $0x2d
  801894:	e8 eb f9 ff ff       	call   801284 <syscall>
  801899:	83 c4 18             	add    $0x18,%esp
	return ;
  80189c:	90                   	nop
}
  80189d:	c9                   	leave  
  80189e:	c3                   	ret    

0080189f <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80189f:	55                   	push   %ebp
  8018a0:	89 e5                	mov    %esp,%ebp
  8018a2:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8018a3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018a6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8018af:	6a 00                	push   $0x0
  8018b1:	53                   	push   %ebx
  8018b2:	51                   	push   %ecx
  8018b3:	52                   	push   %edx
  8018b4:	50                   	push   %eax
  8018b5:	6a 2e                	push   $0x2e
  8018b7:	e8 c8 f9 ff ff       	call   801284 <syscall>
  8018bc:	83 c4 18             	add    $0x18,%esp
}
  8018bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8018c2:	c9                   	leave  
  8018c3:	c3                   	ret    

008018c4 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8018c4:	55                   	push   %ebp
  8018c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8018c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	52                   	push   %edx
  8018d4:	50                   	push   %eax
  8018d5:	6a 2f                	push   $0x2f
  8018d7:	e8 a8 f9 ff ff       	call   801284 <syscall>
  8018dc:	83 c4 18             	add    $0x18,%esp
}
  8018df:	c9                   	leave  
  8018e0:	c3                   	ret    

008018e1 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8018e1:	55                   	push   %ebp
  8018e2:	89 e5                	mov    %esp,%ebp
  8018e4:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8018e7:	8b 55 08             	mov    0x8(%ebp),%edx
  8018ea:	89 d0                	mov    %edx,%eax
  8018ec:	c1 e0 02             	shl    $0x2,%eax
  8018ef:	01 d0                	add    %edx,%eax
  8018f1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018f8:	01 d0                	add    %edx,%eax
  8018fa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801901:	01 d0                	add    %edx,%eax
  801903:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80190a:	01 d0                	add    %edx,%eax
  80190c:	c1 e0 04             	shl    $0x4,%eax
  80190f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801912:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801919:	8d 45 e8             	lea    -0x18(%ebp),%eax
  80191c:	83 ec 0c             	sub    $0xc,%esp
  80191f:	50                   	push   %eax
  801920:	e8 76 fd ff ff       	call   80169b <sys_get_virtual_time>
  801925:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801928:	eb 41                	jmp    80196b <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  80192a:	8d 45 e0             	lea    -0x20(%ebp),%eax
  80192d:	83 ec 0c             	sub    $0xc,%esp
  801930:	50                   	push   %eax
  801931:	e8 65 fd ff ff       	call   80169b <sys_get_virtual_time>
  801936:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801939:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80193c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80193f:	29 c2                	sub    %eax,%edx
  801941:	89 d0                	mov    %edx,%eax
  801943:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801946:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801949:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80194c:	89 d1                	mov    %edx,%ecx
  80194e:	29 c1                	sub    %eax,%ecx
  801950:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801953:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801956:	39 c2                	cmp    %eax,%edx
  801958:	0f 97 c0             	seta   %al
  80195b:	0f b6 c0             	movzbl %al,%eax
  80195e:	29 c1                	sub    %eax,%ecx
  801960:	89 c8                	mov    %ecx,%eax
  801962:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801965:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801968:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  80196b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80196e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801971:	72 b7                	jb     80192a <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801973:	90                   	nop
  801974:	c9                   	leave  
  801975:	c3                   	ret    

00801976 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801976:	55                   	push   %ebp
  801977:	89 e5                	mov    %esp,%ebp
  801979:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80197c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801983:	eb 03                	jmp    801988 <busy_wait+0x12>
  801985:	ff 45 fc             	incl   -0x4(%ebp)
  801988:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80198b:	3b 45 08             	cmp    0x8(%ebp),%eax
  80198e:	72 f5                	jb     801985 <busy_wait+0xf>
	return i;
  801990:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801993:	c9                   	leave  
  801994:	c3                   	ret    

00801995 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  801995:	55                   	push   %ebp
  801996:	89 e5                	mov    %esp,%ebp
  801998:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80199b:	8b 45 08             	mov    0x8(%ebp),%eax
  80199e:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8019a1:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8019a5:	83 ec 0c             	sub    $0xc,%esp
  8019a8:	50                   	push   %eax
  8019a9:	e8 46 fb ff ff       	call   8014f4 <sys_cputc>
  8019ae:	83 c4 10             	add    $0x10,%esp
}
  8019b1:	90                   	nop
  8019b2:	c9                   	leave  
  8019b3:	c3                   	ret    

008019b4 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8019b4:	55                   	push   %ebp
  8019b5:	89 e5                	mov    %esp,%ebp
  8019b7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8019ba:	e8 01 fb ff ff       	call   8014c0 <sys_disable_interrupt>
	char c = ch;
  8019bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c2:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8019c5:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8019c9:	83 ec 0c             	sub    $0xc,%esp
  8019cc:	50                   	push   %eax
  8019cd:	e8 22 fb ff ff       	call   8014f4 <sys_cputc>
  8019d2:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8019d5:	e8 00 fb ff ff       	call   8014da <sys_enable_interrupt>
}
  8019da:	90                   	nop
  8019db:	c9                   	leave  
  8019dc:	c3                   	ret    

008019dd <getchar>:

int
getchar(void)
{
  8019dd:	55                   	push   %ebp
  8019de:	89 e5                	mov    %esp,%ebp
  8019e0:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8019e3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8019ea:	eb 08                	jmp    8019f4 <getchar+0x17>
	{
		c = sys_cgetc();
  8019ec:	e8 e7 f8 ff ff       	call   8012d8 <sys_cgetc>
  8019f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8019f4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8019f8:	74 f2                	je     8019ec <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8019fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8019fd:	c9                   	leave  
  8019fe:	c3                   	ret    

008019ff <atomic_getchar>:

int
atomic_getchar(void)
{
  8019ff:	55                   	push   %ebp
  801a00:	89 e5                	mov    %esp,%ebp
  801a02:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801a05:	e8 b6 fa ff ff       	call   8014c0 <sys_disable_interrupt>
	int c=0;
  801a0a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801a11:	eb 08                	jmp    801a1b <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  801a13:	e8 c0 f8 ff ff       	call   8012d8 <sys_cgetc>
  801a18:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  801a1b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801a1f:	74 f2                	je     801a13 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  801a21:	e8 b4 fa ff ff       	call   8014da <sys_enable_interrupt>
	return c;
  801a26:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801a29:	c9                   	leave  
  801a2a:	c3                   	ret    

00801a2b <iscons>:

int iscons(int fdnum)
{
  801a2b:	55                   	push   %ebp
  801a2c:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  801a2e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a33:	5d                   	pop    %ebp
  801a34:	c3                   	ret    
  801a35:	66 90                	xchg   %ax,%ax
  801a37:	90                   	nop

00801a38 <__udivdi3>:
  801a38:	55                   	push   %ebp
  801a39:	57                   	push   %edi
  801a3a:	56                   	push   %esi
  801a3b:	53                   	push   %ebx
  801a3c:	83 ec 1c             	sub    $0x1c,%esp
  801a3f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a43:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a47:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a4b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a4f:	89 ca                	mov    %ecx,%edx
  801a51:	89 f8                	mov    %edi,%eax
  801a53:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a57:	85 f6                	test   %esi,%esi
  801a59:	75 2d                	jne    801a88 <__udivdi3+0x50>
  801a5b:	39 cf                	cmp    %ecx,%edi
  801a5d:	77 65                	ja     801ac4 <__udivdi3+0x8c>
  801a5f:	89 fd                	mov    %edi,%ebp
  801a61:	85 ff                	test   %edi,%edi
  801a63:	75 0b                	jne    801a70 <__udivdi3+0x38>
  801a65:	b8 01 00 00 00       	mov    $0x1,%eax
  801a6a:	31 d2                	xor    %edx,%edx
  801a6c:	f7 f7                	div    %edi
  801a6e:	89 c5                	mov    %eax,%ebp
  801a70:	31 d2                	xor    %edx,%edx
  801a72:	89 c8                	mov    %ecx,%eax
  801a74:	f7 f5                	div    %ebp
  801a76:	89 c1                	mov    %eax,%ecx
  801a78:	89 d8                	mov    %ebx,%eax
  801a7a:	f7 f5                	div    %ebp
  801a7c:	89 cf                	mov    %ecx,%edi
  801a7e:	89 fa                	mov    %edi,%edx
  801a80:	83 c4 1c             	add    $0x1c,%esp
  801a83:	5b                   	pop    %ebx
  801a84:	5e                   	pop    %esi
  801a85:	5f                   	pop    %edi
  801a86:	5d                   	pop    %ebp
  801a87:	c3                   	ret    
  801a88:	39 ce                	cmp    %ecx,%esi
  801a8a:	77 28                	ja     801ab4 <__udivdi3+0x7c>
  801a8c:	0f bd fe             	bsr    %esi,%edi
  801a8f:	83 f7 1f             	xor    $0x1f,%edi
  801a92:	75 40                	jne    801ad4 <__udivdi3+0x9c>
  801a94:	39 ce                	cmp    %ecx,%esi
  801a96:	72 0a                	jb     801aa2 <__udivdi3+0x6a>
  801a98:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a9c:	0f 87 9e 00 00 00    	ja     801b40 <__udivdi3+0x108>
  801aa2:	b8 01 00 00 00       	mov    $0x1,%eax
  801aa7:	89 fa                	mov    %edi,%edx
  801aa9:	83 c4 1c             	add    $0x1c,%esp
  801aac:	5b                   	pop    %ebx
  801aad:	5e                   	pop    %esi
  801aae:	5f                   	pop    %edi
  801aaf:	5d                   	pop    %ebp
  801ab0:	c3                   	ret    
  801ab1:	8d 76 00             	lea    0x0(%esi),%esi
  801ab4:	31 ff                	xor    %edi,%edi
  801ab6:	31 c0                	xor    %eax,%eax
  801ab8:	89 fa                	mov    %edi,%edx
  801aba:	83 c4 1c             	add    $0x1c,%esp
  801abd:	5b                   	pop    %ebx
  801abe:	5e                   	pop    %esi
  801abf:	5f                   	pop    %edi
  801ac0:	5d                   	pop    %ebp
  801ac1:	c3                   	ret    
  801ac2:	66 90                	xchg   %ax,%ax
  801ac4:	89 d8                	mov    %ebx,%eax
  801ac6:	f7 f7                	div    %edi
  801ac8:	31 ff                	xor    %edi,%edi
  801aca:	89 fa                	mov    %edi,%edx
  801acc:	83 c4 1c             	add    $0x1c,%esp
  801acf:	5b                   	pop    %ebx
  801ad0:	5e                   	pop    %esi
  801ad1:	5f                   	pop    %edi
  801ad2:	5d                   	pop    %ebp
  801ad3:	c3                   	ret    
  801ad4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ad9:	89 eb                	mov    %ebp,%ebx
  801adb:	29 fb                	sub    %edi,%ebx
  801add:	89 f9                	mov    %edi,%ecx
  801adf:	d3 e6                	shl    %cl,%esi
  801ae1:	89 c5                	mov    %eax,%ebp
  801ae3:	88 d9                	mov    %bl,%cl
  801ae5:	d3 ed                	shr    %cl,%ebp
  801ae7:	89 e9                	mov    %ebp,%ecx
  801ae9:	09 f1                	or     %esi,%ecx
  801aeb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801aef:	89 f9                	mov    %edi,%ecx
  801af1:	d3 e0                	shl    %cl,%eax
  801af3:	89 c5                	mov    %eax,%ebp
  801af5:	89 d6                	mov    %edx,%esi
  801af7:	88 d9                	mov    %bl,%cl
  801af9:	d3 ee                	shr    %cl,%esi
  801afb:	89 f9                	mov    %edi,%ecx
  801afd:	d3 e2                	shl    %cl,%edx
  801aff:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b03:	88 d9                	mov    %bl,%cl
  801b05:	d3 e8                	shr    %cl,%eax
  801b07:	09 c2                	or     %eax,%edx
  801b09:	89 d0                	mov    %edx,%eax
  801b0b:	89 f2                	mov    %esi,%edx
  801b0d:	f7 74 24 0c          	divl   0xc(%esp)
  801b11:	89 d6                	mov    %edx,%esi
  801b13:	89 c3                	mov    %eax,%ebx
  801b15:	f7 e5                	mul    %ebp
  801b17:	39 d6                	cmp    %edx,%esi
  801b19:	72 19                	jb     801b34 <__udivdi3+0xfc>
  801b1b:	74 0b                	je     801b28 <__udivdi3+0xf0>
  801b1d:	89 d8                	mov    %ebx,%eax
  801b1f:	31 ff                	xor    %edi,%edi
  801b21:	e9 58 ff ff ff       	jmp    801a7e <__udivdi3+0x46>
  801b26:	66 90                	xchg   %ax,%ax
  801b28:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b2c:	89 f9                	mov    %edi,%ecx
  801b2e:	d3 e2                	shl    %cl,%edx
  801b30:	39 c2                	cmp    %eax,%edx
  801b32:	73 e9                	jae    801b1d <__udivdi3+0xe5>
  801b34:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b37:	31 ff                	xor    %edi,%edi
  801b39:	e9 40 ff ff ff       	jmp    801a7e <__udivdi3+0x46>
  801b3e:	66 90                	xchg   %ax,%ax
  801b40:	31 c0                	xor    %eax,%eax
  801b42:	e9 37 ff ff ff       	jmp    801a7e <__udivdi3+0x46>
  801b47:	90                   	nop

00801b48 <__umoddi3>:
  801b48:	55                   	push   %ebp
  801b49:	57                   	push   %edi
  801b4a:	56                   	push   %esi
  801b4b:	53                   	push   %ebx
  801b4c:	83 ec 1c             	sub    $0x1c,%esp
  801b4f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b53:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b57:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b5b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b5f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b63:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b67:	89 f3                	mov    %esi,%ebx
  801b69:	89 fa                	mov    %edi,%edx
  801b6b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b6f:	89 34 24             	mov    %esi,(%esp)
  801b72:	85 c0                	test   %eax,%eax
  801b74:	75 1a                	jne    801b90 <__umoddi3+0x48>
  801b76:	39 f7                	cmp    %esi,%edi
  801b78:	0f 86 a2 00 00 00    	jbe    801c20 <__umoddi3+0xd8>
  801b7e:	89 c8                	mov    %ecx,%eax
  801b80:	89 f2                	mov    %esi,%edx
  801b82:	f7 f7                	div    %edi
  801b84:	89 d0                	mov    %edx,%eax
  801b86:	31 d2                	xor    %edx,%edx
  801b88:	83 c4 1c             	add    $0x1c,%esp
  801b8b:	5b                   	pop    %ebx
  801b8c:	5e                   	pop    %esi
  801b8d:	5f                   	pop    %edi
  801b8e:	5d                   	pop    %ebp
  801b8f:	c3                   	ret    
  801b90:	39 f0                	cmp    %esi,%eax
  801b92:	0f 87 ac 00 00 00    	ja     801c44 <__umoddi3+0xfc>
  801b98:	0f bd e8             	bsr    %eax,%ebp
  801b9b:	83 f5 1f             	xor    $0x1f,%ebp
  801b9e:	0f 84 ac 00 00 00    	je     801c50 <__umoddi3+0x108>
  801ba4:	bf 20 00 00 00       	mov    $0x20,%edi
  801ba9:	29 ef                	sub    %ebp,%edi
  801bab:	89 fe                	mov    %edi,%esi
  801bad:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801bb1:	89 e9                	mov    %ebp,%ecx
  801bb3:	d3 e0                	shl    %cl,%eax
  801bb5:	89 d7                	mov    %edx,%edi
  801bb7:	89 f1                	mov    %esi,%ecx
  801bb9:	d3 ef                	shr    %cl,%edi
  801bbb:	09 c7                	or     %eax,%edi
  801bbd:	89 e9                	mov    %ebp,%ecx
  801bbf:	d3 e2                	shl    %cl,%edx
  801bc1:	89 14 24             	mov    %edx,(%esp)
  801bc4:	89 d8                	mov    %ebx,%eax
  801bc6:	d3 e0                	shl    %cl,%eax
  801bc8:	89 c2                	mov    %eax,%edx
  801bca:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bce:	d3 e0                	shl    %cl,%eax
  801bd0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bd4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bd8:	89 f1                	mov    %esi,%ecx
  801bda:	d3 e8                	shr    %cl,%eax
  801bdc:	09 d0                	or     %edx,%eax
  801bde:	d3 eb                	shr    %cl,%ebx
  801be0:	89 da                	mov    %ebx,%edx
  801be2:	f7 f7                	div    %edi
  801be4:	89 d3                	mov    %edx,%ebx
  801be6:	f7 24 24             	mull   (%esp)
  801be9:	89 c6                	mov    %eax,%esi
  801beb:	89 d1                	mov    %edx,%ecx
  801bed:	39 d3                	cmp    %edx,%ebx
  801bef:	0f 82 87 00 00 00    	jb     801c7c <__umoddi3+0x134>
  801bf5:	0f 84 91 00 00 00    	je     801c8c <__umoddi3+0x144>
  801bfb:	8b 54 24 04          	mov    0x4(%esp),%edx
  801bff:	29 f2                	sub    %esi,%edx
  801c01:	19 cb                	sbb    %ecx,%ebx
  801c03:	89 d8                	mov    %ebx,%eax
  801c05:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c09:	d3 e0                	shl    %cl,%eax
  801c0b:	89 e9                	mov    %ebp,%ecx
  801c0d:	d3 ea                	shr    %cl,%edx
  801c0f:	09 d0                	or     %edx,%eax
  801c11:	89 e9                	mov    %ebp,%ecx
  801c13:	d3 eb                	shr    %cl,%ebx
  801c15:	89 da                	mov    %ebx,%edx
  801c17:	83 c4 1c             	add    $0x1c,%esp
  801c1a:	5b                   	pop    %ebx
  801c1b:	5e                   	pop    %esi
  801c1c:	5f                   	pop    %edi
  801c1d:	5d                   	pop    %ebp
  801c1e:	c3                   	ret    
  801c1f:	90                   	nop
  801c20:	89 fd                	mov    %edi,%ebp
  801c22:	85 ff                	test   %edi,%edi
  801c24:	75 0b                	jne    801c31 <__umoddi3+0xe9>
  801c26:	b8 01 00 00 00       	mov    $0x1,%eax
  801c2b:	31 d2                	xor    %edx,%edx
  801c2d:	f7 f7                	div    %edi
  801c2f:	89 c5                	mov    %eax,%ebp
  801c31:	89 f0                	mov    %esi,%eax
  801c33:	31 d2                	xor    %edx,%edx
  801c35:	f7 f5                	div    %ebp
  801c37:	89 c8                	mov    %ecx,%eax
  801c39:	f7 f5                	div    %ebp
  801c3b:	89 d0                	mov    %edx,%eax
  801c3d:	e9 44 ff ff ff       	jmp    801b86 <__umoddi3+0x3e>
  801c42:	66 90                	xchg   %ax,%ax
  801c44:	89 c8                	mov    %ecx,%eax
  801c46:	89 f2                	mov    %esi,%edx
  801c48:	83 c4 1c             	add    $0x1c,%esp
  801c4b:	5b                   	pop    %ebx
  801c4c:	5e                   	pop    %esi
  801c4d:	5f                   	pop    %edi
  801c4e:	5d                   	pop    %ebp
  801c4f:	c3                   	ret    
  801c50:	3b 04 24             	cmp    (%esp),%eax
  801c53:	72 06                	jb     801c5b <__umoddi3+0x113>
  801c55:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c59:	77 0f                	ja     801c6a <__umoddi3+0x122>
  801c5b:	89 f2                	mov    %esi,%edx
  801c5d:	29 f9                	sub    %edi,%ecx
  801c5f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c63:	89 14 24             	mov    %edx,(%esp)
  801c66:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c6a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c6e:	8b 14 24             	mov    (%esp),%edx
  801c71:	83 c4 1c             	add    $0x1c,%esp
  801c74:	5b                   	pop    %ebx
  801c75:	5e                   	pop    %esi
  801c76:	5f                   	pop    %edi
  801c77:	5d                   	pop    %ebp
  801c78:	c3                   	ret    
  801c79:	8d 76 00             	lea    0x0(%esi),%esi
  801c7c:	2b 04 24             	sub    (%esp),%eax
  801c7f:	19 fa                	sbb    %edi,%edx
  801c81:	89 d1                	mov    %edx,%ecx
  801c83:	89 c6                	mov    %eax,%esi
  801c85:	e9 71 ff ff ff       	jmp    801bfb <__umoddi3+0xb3>
  801c8a:	66 90                	xchg   %ax,%ax
  801c8c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c90:	72 ea                	jb     801c7c <__umoddi3+0x134>
  801c92:	89 d9                	mov    %ebx,%ecx
  801c94:	e9 62 ff ff ff       	jmp    801bfb <__umoddi3+0xb3>
