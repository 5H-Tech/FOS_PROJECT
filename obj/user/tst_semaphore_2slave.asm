
obj/user/tst_semaphore_2slave:     file format elf32-i386


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
  800031:	e8 8a 00 00 00       	call   8000c0 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	int id = sys_getenvindex();
  80003e:	e8 c1 10 00 00       	call   801104 <sys_getenvindex>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)

	int32 parentenvID = sys_getparentenvid();
  800046:	e8 d2 10 00 00       	call   80111d <sys_getparentenvid>
  80004b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	//cprintf("Cust %d: outside the shop\n", id);

	sys_waitSemaphore(parentenvID, "shopCapacity") ;
  80004e:	83 ec 08             	sub    $0x8,%esp
  800051:	68 e0 19 80 00       	push   $0x8019e0
  800056:	ff 75 f0             	pushl  -0x10(%ebp)
  800059:	e8 ee 12 00 00       	call   80134c <sys_waitSemaphore>
  80005e:	83 c4 10             	add    $0x10,%esp
		cprintf("Cust %d: inside the shop\n", id) ;
  800061:	83 ec 08             	sub    $0x8,%esp
  800064:	ff 75 f4             	pushl  -0xc(%ebp)
  800067:	68 ed 19 80 00       	push   $0x8019ed
  80006c:	e8 68 02 00 00       	call   8002d9 <cprintf>
  800071:	83 c4 10             	add    $0x10,%esp
		env_sleep(1000) ;
  800074:	83 ec 0c             	sub    $0xc,%esp
  800077:	68 e8 03 00 00       	push   $0x3e8
  80007c:	e8 3f 16 00 00       	call   8016c0 <env_sleep>
  800081:	83 c4 10             	add    $0x10,%esp
	sys_signalSemaphore(parentenvID, "shopCapacity") ;
  800084:	83 ec 08             	sub    $0x8,%esp
  800087:	68 e0 19 80 00       	push   $0x8019e0
  80008c:	ff 75 f0             	pushl  -0x10(%ebp)
  80008f:	e8 d6 12 00 00       	call   80136a <sys_signalSemaphore>
  800094:	83 c4 10             	add    $0x10,%esp

	cprintf("Cust %d: exit the shop\n", id);
  800097:	83 ec 08             	sub    $0x8,%esp
  80009a:	ff 75 f4             	pushl  -0xc(%ebp)
  80009d:	68 07 1a 80 00       	push   $0x801a07
  8000a2:	e8 32 02 00 00       	call   8002d9 <cprintf>
  8000a7:	83 c4 10             	add    $0x10,%esp
	sys_signalSemaphore(parentenvID, "depend") ;
  8000aa:	83 ec 08             	sub    $0x8,%esp
  8000ad:	68 1f 1a 80 00       	push   $0x801a1f
  8000b2:	ff 75 f0             	pushl  -0x10(%ebp)
  8000b5:	e8 b0 12 00 00       	call   80136a <sys_signalSemaphore>
  8000ba:	83 c4 10             	add    $0x10,%esp
	return;
  8000bd:	90                   	nop
}
  8000be:	c9                   	leave  
  8000bf:	c3                   	ret    

008000c0 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000c0:	55                   	push   %ebp
  8000c1:	89 e5                	mov    %esp,%ebp
  8000c3:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000c6:	e8 39 10 00 00       	call   801104 <sys_getenvindex>
  8000cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000d1:	89 d0                	mov    %edx,%eax
  8000d3:	c1 e0 03             	shl    $0x3,%eax
  8000d6:	01 d0                	add    %edx,%eax
  8000d8:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8000df:	01 c8                	add    %ecx,%eax
  8000e1:	01 c0                	add    %eax,%eax
  8000e3:	01 d0                	add    %edx,%eax
  8000e5:	01 c0                	add    %eax,%eax
  8000e7:	01 d0                	add    %edx,%eax
  8000e9:	89 c2                	mov    %eax,%edx
  8000eb:	c1 e2 05             	shl    $0x5,%edx
  8000ee:	29 c2                	sub    %eax,%edx
  8000f0:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8000f7:	89 c2                	mov    %eax,%edx
  8000f9:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8000ff:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800104:	a1 20 20 80 00       	mov    0x802020,%eax
  800109:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80010f:	84 c0                	test   %al,%al
  800111:	74 0f                	je     800122 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800113:	a1 20 20 80 00       	mov    0x802020,%eax
  800118:	05 40 3c 01 00       	add    $0x13c40,%eax
  80011d:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800122:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800126:	7e 0a                	jle    800132 <libmain+0x72>
		binaryname = argv[0];
  800128:	8b 45 0c             	mov    0xc(%ebp),%eax
  80012b:	8b 00                	mov    (%eax),%eax
  80012d:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800132:	83 ec 08             	sub    $0x8,%esp
  800135:	ff 75 0c             	pushl  0xc(%ebp)
  800138:	ff 75 08             	pushl  0x8(%ebp)
  80013b:	e8 f8 fe ff ff       	call   800038 <_main>
  800140:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800143:	e8 57 11 00 00       	call   80129f <sys_disable_interrupt>
	cprintf("**************************************\n");
  800148:	83 ec 0c             	sub    $0xc,%esp
  80014b:	68 40 1a 80 00       	push   $0x801a40
  800150:	e8 84 01 00 00       	call   8002d9 <cprintf>
  800155:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800158:	a1 20 20 80 00       	mov    0x802020,%eax
  80015d:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800163:	a1 20 20 80 00       	mov    0x802020,%eax
  800168:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80016e:	83 ec 04             	sub    $0x4,%esp
  800171:	52                   	push   %edx
  800172:	50                   	push   %eax
  800173:	68 68 1a 80 00       	push   $0x801a68
  800178:	e8 5c 01 00 00       	call   8002d9 <cprintf>
  80017d:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800180:	a1 20 20 80 00       	mov    0x802020,%eax
  800185:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80018b:	a1 20 20 80 00       	mov    0x802020,%eax
  800190:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800196:	83 ec 04             	sub    $0x4,%esp
  800199:	52                   	push   %edx
  80019a:	50                   	push   %eax
  80019b:	68 90 1a 80 00       	push   $0x801a90
  8001a0:	e8 34 01 00 00       	call   8002d9 <cprintf>
  8001a5:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001a8:	a1 20 20 80 00       	mov    0x802020,%eax
  8001ad:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	50                   	push   %eax
  8001b7:	68 d1 1a 80 00       	push   $0x801ad1
  8001bc:	e8 18 01 00 00       	call   8002d9 <cprintf>
  8001c1:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001c4:	83 ec 0c             	sub    $0xc,%esp
  8001c7:	68 40 1a 80 00       	push   $0x801a40
  8001cc:	e8 08 01 00 00       	call   8002d9 <cprintf>
  8001d1:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001d4:	e8 e0 10 00 00       	call   8012b9 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001d9:	e8 19 00 00 00       	call   8001f7 <exit>
}
  8001de:	90                   	nop
  8001df:	c9                   	leave  
  8001e0:	c3                   	ret    

008001e1 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001e1:	55                   	push   %ebp
  8001e2:	89 e5                	mov    %esp,%ebp
  8001e4:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001e7:	83 ec 0c             	sub    $0xc,%esp
  8001ea:	6a 00                	push   $0x0
  8001ec:	e8 df 0e 00 00       	call   8010d0 <sys_env_destroy>
  8001f1:	83 c4 10             	add    $0x10,%esp
}
  8001f4:	90                   	nop
  8001f5:	c9                   	leave  
  8001f6:	c3                   	ret    

008001f7 <exit>:

void
exit(void)
{
  8001f7:	55                   	push   %ebp
  8001f8:	89 e5                	mov    %esp,%ebp
  8001fa:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001fd:	e8 34 0f 00 00       	call   801136 <sys_env_exit>
}
  800202:	90                   	nop
  800203:	c9                   	leave  
  800204:	c3                   	ret    

00800205 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800205:	55                   	push   %ebp
  800206:	89 e5                	mov    %esp,%ebp
  800208:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80020b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020e:	8b 00                	mov    (%eax),%eax
  800210:	8d 48 01             	lea    0x1(%eax),%ecx
  800213:	8b 55 0c             	mov    0xc(%ebp),%edx
  800216:	89 0a                	mov    %ecx,(%edx)
  800218:	8b 55 08             	mov    0x8(%ebp),%edx
  80021b:	88 d1                	mov    %dl,%cl
  80021d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800220:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800224:	8b 45 0c             	mov    0xc(%ebp),%eax
  800227:	8b 00                	mov    (%eax),%eax
  800229:	3d ff 00 00 00       	cmp    $0xff,%eax
  80022e:	75 2c                	jne    80025c <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800230:	a0 24 20 80 00       	mov    0x802024,%al
  800235:	0f b6 c0             	movzbl %al,%eax
  800238:	8b 55 0c             	mov    0xc(%ebp),%edx
  80023b:	8b 12                	mov    (%edx),%edx
  80023d:	89 d1                	mov    %edx,%ecx
  80023f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800242:	83 c2 08             	add    $0x8,%edx
  800245:	83 ec 04             	sub    $0x4,%esp
  800248:	50                   	push   %eax
  800249:	51                   	push   %ecx
  80024a:	52                   	push   %edx
  80024b:	e8 3e 0e 00 00       	call   80108e <sys_cputs>
  800250:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800253:	8b 45 0c             	mov    0xc(%ebp),%eax
  800256:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80025c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80025f:	8b 40 04             	mov    0x4(%eax),%eax
  800262:	8d 50 01             	lea    0x1(%eax),%edx
  800265:	8b 45 0c             	mov    0xc(%ebp),%eax
  800268:	89 50 04             	mov    %edx,0x4(%eax)
}
  80026b:	90                   	nop
  80026c:	c9                   	leave  
  80026d:	c3                   	ret    

0080026e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80026e:	55                   	push   %ebp
  80026f:	89 e5                	mov    %esp,%ebp
  800271:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800277:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80027e:	00 00 00 
	b.cnt = 0;
  800281:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800288:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80028b:	ff 75 0c             	pushl  0xc(%ebp)
  80028e:	ff 75 08             	pushl  0x8(%ebp)
  800291:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800297:	50                   	push   %eax
  800298:	68 05 02 80 00       	push   $0x800205
  80029d:	e8 11 02 00 00       	call   8004b3 <vprintfmt>
  8002a2:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8002a5:	a0 24 20 80 00       	mov    0x802024,%al
  8002aa:	0f b6 c0             	movzbl %al,%eax
  8002ad:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002b3:	83 ec 04             	sub    $0x4,%esp
  8002b6:	50                   	push   %eax
  8002b7:	52                   	push   %edx
  8002b8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002be:	83 c0 08             	add    $0x8,%eax
  8002c1:	50                   	push   %eax
  8002c2:	e8 c7 0d 00 00       	call   80108e <sys_cputs>
  8002c7:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002ca:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  8002d1:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002d7:	c9                   	leave  
  8002d8:	c3                   	ret    

008002d9 <cprintf>:

int cprintf(const char *fmt, ...) {
  8002d9:	55                   	push   %ebp
  8002da:	89 e5                	mov    %esp,%ebp
  8002dc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002df:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  8002e6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ef:	83 ec 08             	sub    $0x8,%esp
  8002f2:	ff 75 f4             	pushl  -0xc(%ebp)
  8002f5:	50                   	push   %eax
  8002f6:	e8 73 ff ff ff       	call   80026e <vcprintf>
  8002fb:	83 c4 10             	add    $0x10,%esp
  8002fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800301:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800304:	c9                   	leave  
  800305:	c3                   	ret    

00800306 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800306:	55                   	push   %ebp
  800307:	89 e5                	mov    %esp,%ebp
  800309:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80030c:	e8 8e 0f 00 00       	call   80129f <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800311:	8d 45 0c             	lea    0xc(%ebp),%eax
  800314:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800317:	8b 45 08             	mov    0x8(%ebp),%eax
  80031a:	83 ec 08             	sub    $0x8,%esp
  80031d:	ff 75 f4             	pushl  -0xc(%ebp)
  800320:	50                   	push   %eax
  800321:	e8 48 ff ff ff       	call   80026e <vcprintf>
  800326:	83 c4 10             	add    $0x10,%esp
  800329:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80032c:	e8 88 0f 00 00       	call   8012b9 <sys_enable_interrupt>
	return cnt;
  800331:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800334:	c9                   	leave  
  800335:	c3                   	ret    

00800336 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800336:	55                   	push   %ebp
  800337:	89 e5                	mov    %esp,%ebp
  800339:	53                   	push   %ebx
  80033a:	83 ec 14             	sub    $0x14,%esp
  80033d:	8b 45 10             	mov    0x10(%ebp),%eax
  800340:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800343:	8b 45 14             	mov    0x14(%ebp),%eax
  800346:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800349:	8b 45 18             	mov    0x18(%ebp),%eax
  80034c:	ba 00 00 00 00       	mov    $0x0,%edx
  800351:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800354:	77 55                	ja     8003ab <printnum+0x75>
  800356:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800359:	72 05                	jb     800360 <printnum+0x2a>
  80035b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80035e:	77 4b                	ja     8003ab <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800360:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800363:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800366:	8b 45 18             	mov    0x18(%ebp),%eax
  800369:	ba 00 00 00 00       	mov    $0x0,%edx
  80036e:	52                   	push   %edx
  80036f:	50                   	push   %eax
  800370:	ff 75 f4             	pushl  -0xc(%ebp)
  800373:	ff 75 f0             	pushl  -0x10(%ebp)
  800376:	e8 f9 13 00 00       	call   801774 <__udivdi3>
  80037b:	83 c4 10             	add    $0x10,%esp
  80037e:	83 ec 04             	sub    $0x4,%esp
  800381:	ff 75 20             	pushl  0x20(%ebp)
  800384:	53                   	push   %ebx
  800385:	ff 75 18             	pushl  0x18(%ebp)
  800388:	52                   	push   %edx
  800389:	50                   	push   %eax
  80038a:	ff 75 0c             	pushl  0xc(%ebp)
  80038d:	ff 75 08             	pushl  0x8(%ebp)
  800390:	e8 a1 ff ff ff       	call   800336 <printnum>
  800395:	83 c4 20             	add    $0x20,%esp
  800398:	eb 1a                	jmp    8003b4 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80039a:	83 ec 08             	sub    $0x8,%esp
  80039d:	ff 75 0c             	pushl  0xc(%ebp)
  8003a0:	ff 75 20             	pushl  0x20(%ebp)
  8003a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a6:	ff d0                	call   *%eax
  8003a8:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003ab:	ff 4d 1c             	decl   0x1c(%ebp)
  8003ae:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003b2:	7f e6                	jg     80039a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003b4:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003b7:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003c2:	53                   	push   %ebx
  8003c3:	51                   	push   %ecx
  8003c4:	52                   	push   %edx
  8003c5:	50                   	push   %eax
  8003c6:	e8 b9 14 00 00       	call   801884 <__umoddi3>
  8003cb:	83 c4 10             	add    $0x10,%esp
  8003ce:	05 14 1d 80 00       	add    $0x801d14,%eax
  8003d3:	8a 00                	mov    (%eax),%al
  8003d5:	0f be c0             	movsbl %al,%eax
  8003d8:	83 ec 08             	sub    $0x8,%esp
  8003db:	ff 75 0c             	pushl  0xc(%ebp)
  8003de:	50                   	push   %eax
  8003df:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e2:	ff d0                	call   *%eax
  8003e4:	83 c4 10             	add    $0x10,%esp
}
  8003e7:	90                   	nop
  8003e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003eb:	c9                   	leave  
  8003ec:	c3                   	ret    

008003ed <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003ed:	55                   	push   %ebp
  8003ee:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003f0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003f4:	7e 1c                	jle    800412 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f9:	8b 00                	mov    (%eax),%eax
  8003fb:	8d 50 08             	lea    0x8(%eax),%edx
  8003fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800401:	89 10                	mov    %edx,(%eax)
  800403:	8b 45 08             	mov    0x8(%ebp),%eax
  800406:	8b 00                	mov    (%eax),%eax
  800408:	83 e8 08             	sub    $0x8,%eax
  80040b:	8b 50 04             	mov    0x4(%eax),%edx
  80040e:	8b 00                	mov    (%eax),%eax
  800410:	eb 40                	jmp    800452 <getuint+0x65>
	else if (lflag)
  800412:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800416:	74 1e                	je     800436 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800418:	8b 45 08             	mov    0x8(%ebp),%eax
  80041b:	8b 00                	mov    (%eax),%eax
  80041d:	8d 50 04             	lea    0x4(%eax),%edx
  800420:	8b 45 08             	mov    0x8(%ebp),%eax
  800423:	89 10                	mov    %edx,(%eax)
  800425:	8b 45 08             	mov    0x8(%ebp),%eax
  800428:	8b 00                	mov    (%eax),%eax
  80042a:	83 e8 04             	sub    $0x4,%eax
  80042d:	8b 00                	mov    (%eax),%eax
  80042f:	ba 00 00 00 00       	mov    $0x0,%edx
  800434:	eb 1c                	jmp    800452 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800436:	8b 45 08             	mov    0x8(%ebp),%eax
  800439:	8b 00                	mov    (%eax),%eax
  80043b:	8d 50 04             	lea    0x4(%eax),%edx
  80043e:	8b 45 08             	mov    0x8(%ebp),%eax
  800441:	89 10                	mov    %edx,(%eax)
  800443:	8b 45 08             	mov    0x8(%ebp),%eax
  800446:	8b 00                	mov    (%eax),%eax
  800448:	83 e8 04             	sub    $0x4,%eax
  80044b:	8b 00                	mov    (%eax),%eax
  80044d:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800452:	5d                   	pop    %ebp
  800453:	c3                   	ret    

00800454 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800454:	55                   	push   %ebp
  800455:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800457:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80045b:	7e 1c                	jle    800479 <getint+0x25>
		return va_arg(*ap, long long);
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	8b 00                	mov    (%eax),%eax
  800462:	8d 50 08             	lea    0x8(%eax),%edx
  800465:	8b 45 08             	mov    0x8(%ebp),%eax
  800468:	89 10                	mov    %edx,(%eax)
  80046a:	8b 45 08             	mov    0x8(%ebp),%eax
  80046d:	8b 00                	mov    (%eax),%eax
  80046f:	83 e8 08             	sub    $0x8,%eax
  800472:	8b 50 04             	mov    0x4(%eax),%edx
  800475:	8b 00                	mov    (%eax),%eax
  800477:	eb 38                	jmp    8004b1 <getint+0x5d>
	else if (lflag)
  800479:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80047d:	74 1a                	je     800499 <getint+0x45>
		return va_arg(*ap, long);
  80047f:	8b 45 08             	mov    0x8(%ebp),%eax
  800482:	8b 00                	mov    (%eax),%eax
  800484:	8d 50 04             	lea    0x4(%eax),%edx
  800487:	8b 45 08             	mov    0x8(%ebp),%eax
  80048a:	89 10                	mov    %edx,(%eax)
  80048c:	8b 45 08             	mov    0x8(%ebp),%eax
  80048f:	8b 00                	mov    (%eax),%eax
  800491:	83 e8 04             	sub    $0x4,%eax
  800494:	8b 00                	mov    (%eax),%eax
  800496:	99                   	cltd   
  800497:	eb 18                	jmp    8004b1 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800499:	8b 45 08             	mov    0x8(%ebp),%eax
  80049c:	8b 00                	mov    (%eax),%eax
  80049e:	8d 50 04             	lea    0x4(%eax),%edx
  8004a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a4:	89 10                	mov    %edx,(%eax)
  8004a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a9:	8b 00                	mov    (%eax),%eax
  8004ab:	83 e8 04             	sub    $0x4,%eax
  8004ae:	8b 00                	mov    (%eax),%eax
  8004b0:	99                   	cltd   
}
  8004b1:	5d                   	pop    %ebp
  8004b2:	c3                   	ret    

008004b3 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004b3:	55                   	push   %ebp
  8004b4:	89 e5                	mov    %esp,%ebp
  8004b6:	56                   	push   %esi
  8004b7:	53                   	push   %ebx
  8004b8:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004bb:	eb 17                	jmp    8004d4 <vprintfmt+0x21>
			if (ch == '\0')
  8004bd:	85 db                	test   %ebx,%ebx
  8004bf:	0f 84 af 03 00 00    	je     800874 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004c5:	83 ec 08             	sub    $0x8,%esp
  8004c8:	ff 75 0c             	pushl  0xc(%ebp)
  8004cb:	53                   	push   %ebx
  8004cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8004cf:	ff d0                	call   *%eax
  8004d1:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8004d7:	8d 50 01             	lea    0x1(%eax),%edx
  8004da:	89 55 10             	mov    %edx,0x10(%ebp)
  8004dd:	8a 00                	mov    (%eax),%al
  8004df:	0f b6 d8             	movzbl %al,%ebx
  8004e2:	83 fb 25             	cmp    $0x25,%ebx
  8004e5:	75 d6                	jne    8004bd <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004e7:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004eb:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004f2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004f9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800500:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800507:	8b 45 10             	mov    0x10(%ebp),%eax
  80050a:	8d 50 01             	lea    0x1(%eax),%edx
  80050d:	89 55 10             	mov    %edx,0x10(%ebp)
  800510:	8a 00                	mov    (%eax),%al
  800512:	0f b6 d8             	movzbl %al,%ebx
  800515:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800518:	83 f8 55             	cmp    $0x55,%eax
  80051b:	0f 87 2b 03 00 00    	ja     80084c <vprintfmt+0x399>
  800521:	8b 04 85 38 1d 80 00 	mov    0x801d38(,%eax,4),%eax
  800528:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80052a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80052e:	eb d7                	jmp    800507 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800530:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800534:	eb d1                	jmp    800507 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800536:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80053d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800540:	89 d0                	mov    %edx,%eax
  800542:	c1 e0 02             	shl    $0x2,%eax
  800545:	01 d0                	add    %edx,%eax
  800547:	01 c0                	add    %eax,%eax
  800549:	01 d8                	add    %ebx,%eax
  80054b:	83 e8 30             	sub    $0x30,%eax
  80054e:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800551:	8b 45 10             	mov    0x10(%ebp),%eax
  800554:	8a 00                	mov    (%eax),%al
  800556:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800559:	83 fb 2f             	cmp    $0x2f,%ebx
  80055c:	7e 3e                	jle    80059c <vprintfmt+0xe9>
  80055e:	83 fb 39             	cmp    $0x39,%ebx
  800561:	7f 39                	jg     80059c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800563:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800566:	eb d5                	jmp    80053d <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800568:	8b 45 14             	mov    0x14(%ebp),%eax
  80056b:	83 c0 04             	add    $0x4,%eax
  80056e:	89 45 14             	mov    %eax,0x14(%ebp)
  800571:	8b 45 14             	mov    0x14(%ebp),%eax
  800574:	83 e8 04             	sub    $0x4,%eax
  800577:	8b 00                	mov    (%eax),%eax
  800579:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80057c:	eb 1f                	jmp    80059d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80057e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800582:	79 83                	jns    800507 <vprintfmt+0x54>
				width = 0;
  800584:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80058b:	e9 77 ff ff ff       	jmp    800507 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800590:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800597:	e9 6b ff ff ff       	jmp    800507 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80059c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80059d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005a1:	0f 89 60 ff ff ff    	jns    800507 <vprintfmt+0x54>
				width = precision, precision = -1;
  8005a7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005aa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005ad:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005b4:	e9 4e ff ff ff       	jmp    800507 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005b9:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005bc:	e9 46 ff ff ff       	jmp    800507 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c4:	83 c0 04             	add    $0x4,%eax
  8005c7:	89 45 14             	mov    %eax,0x14(%ebp)
  8005ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8005cd:	83 e8 04             	sub    $0x4,%eax
  8005d0:	8b 00                	mov    (%eax),%eax
  8005d2:	83 ec 08             	sub    $0x8,%esp
  8005d5:	ff 75 0c             	pushl  0xc(%ebp)
  8005d8:	50                   	push   %eax
  8005d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005dc:	ff d0                	call   *%eax
  8005de:	83 c4 10             	add    $0x10,%esp
			break;
  8005e1:	e9 89 02 00 00       	jmp    80086f <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e9:	83 c0 04             	add    $0x4,%eax
  8005ec:	89 45 14             	mov    %eax,0x14(%ebp)
  8005ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8005f2:	83 e8 04             	sub    $0x4,%eax
  8005f5:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005f7:	85 db                	test   %ebx,%ebx
  8005f9:	79 02                	jns    8005fd <vprintfmt+0x14a>
				err = -err;
  8005fb:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005fd:	83 fb 64             	cmp    $0x64,%ebx
  800600:	7f 0b                	jg     80060d <vprintfmt+0x15a>
  800602:	8b 34 9d 80 1b 80 00 	mov    0x801b80(,%ebx,4),%esi
  800609:	85 f6                	test   %esi,%esi
  80060b:	75 19                	jne    800626 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80060d:	53                   	push   %ebx
  80060e:	68 25 1d 80 00       	push   $0x801d25
  800613:	ff 75 0c             	pushl  0xc(%ebp)
  800616:	ff 75 08             	pushl  0x8(%ebp)
  800619:	e8 5e 02 00 00       	call   80087c <printfmt>
  80061e:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800621:	e9 49 02 00 00       	jmp    80086f <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800626:	56                   	push   %esi
  800627:	68 2e 1d 80 00       	push   $0x801d2e
  80062c:	ff 75 0c             	pushl  0xc(%ebp)
  80062f:	ff 75 08             	pushl  0x8(%ebp)
  800632:	e8 45 02 00 00       	call   80087c <printfmt>
  800637:	83 c4 10             	add    $0x10,%esp
			break;
  80063a:	e9 30 02 00 00       	jmp    80086f <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80063f:	8b 45 14             	mov    0x14(%ebp),%eax
  800642:	83 c0 04             	add    $0x4,%eax
  800645:	89 45 14             	mov    %eax,0x14(%ebp)
  800648:	8b 45 14             	mov    0x14(%ebp),%eax
  80064b:	83 e8 04             	sub    $0x4,%eax
  80064e:	8b 30                	mov    (%eax),%esi
  800650:	85 f6                	test   %esi,%esi
  800652:	75 05                	jne    800659 <vprintfmt+0x1a6>
				p = "(null)";
  800654:	be 31 1d 80 00       	mov    $0x801d31,%esi
			if (width > 0 && padc != '-')
  800659:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80065d:	7e 6d                	jle    8006cc <vprintfmt+0x219>
  80065f:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800663:	74 67                	je     8006cc <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800665:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800668:	83 ec 08             	sub    $0x8,%esp
  80066b:	50                   	push   %eax
  80066c:	56                   	push   %esi
  80066d:	e8 0c 03 00 00       	call   80097e <strnlen>
  800672:	83 c4 10             	add    $0x10,%esp
  800675:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800678:	eb 16                	jmp    800690 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80067a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80067e:	83 ec 08             	sub    $0x8,%esp
  800681:	ff 75 0c             	pushl  0xc(%ebp)
  800684:	50                   	push   %eax
  800685:	8b 45 08             	mov    0x8(%ebp),%eax
  800688:	ff d0                	call   *%eax
  80068a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80068d:	ff 4d e4             	decl   -0x1c(%ebp)
  800690:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800694:	7f e4                	jg     80067a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800696:	eb 34                	jmp    8006cc <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800698:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80069c:	74 1c                	je     8006ba <vprintfmt+0x207>
  80069e:	83 fb 1f             	cmp    $0x1f,%ebx
  8006a1:	7e 05                	jle    8006a8 <vprintfmt+0x1f5>
  8006a3:	83 fb 7e             	cmp    $0x7e,%ebx
  8006a6:	7e 12                	jle    8006ba <vprintfmt+0x207>
					putch('?', putdat);
  8006a8:	83 ec 08             	sub    $0x8,%esp
  8006ab:	ff 75 0c             	pushl  0xc(%ebp)
  8006ae:	6a 3f                	push   $0x3f
  8006b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b3:	ff d0                	call   *%eax
  8006b5:	83 c4 10             	add    $0x10,%esp
  8006b8:	eb 0f                	jmp    8006c9 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006ba:	83 ec 08             	sub    $0x8,%esp
  8006bd:	ff 75 0c             	pushl  0xc(%ebp)
  8006c0:	53                   	push   %ebx
  8006c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c4:	ff d0                	call   *%eax
  8006c6:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006c9:	ff 4d e4             	decl   -0x1c(%ebp)
  8006cc:	89 f0                	mov    %esi,%eax
  8006ce:	8d 70 01             	lea    0x1(%eax),%esi
  8006d1:	8a 00                	mov    (%eax),%al
  8006d3:	0f be d8             	movsbl %al,%ebx
  8006d6:	85 db                	test   %ebx,%ebx
  8006d8:	74 24                	je     8006fe <vprintfmt+0x24b>
  8006da:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006de:	78 b8                	js     800698 <vprintfmt+0x1e5>
  8006e0:	ff 4d e0             	decl   -0x20(%ebp)
  8006e3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006e7:	79 af                	jns    800698 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006e9:	eb 13                	jmp    8006fe <vprintfmt+0x24b>
				putch(' ', putdat);
  8006eb:	83 ec 08             	sub    $0x8,%esp
  8006ee:	ff 75 0c             	pushl  0xc(%ebp)
  8006f1:	6a 20                	push   $0x20
  8006f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f6:	ff d0                	call   *%eax
  8006f8:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006fb:	ff 4d e4             	decl   -0x1c(%ebp)
  8006fe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800702:	7f e7                	jg     8006eb <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800704:	e9 66 01 00 00       	jmp    80086f <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800709:	83 ec 08             	sub    $0x8,%esp
  80070c:	ff 75 e8             	pushl  -0x18(%ebp)
  80070f:	8d 45 14             	lea    0x14(%ebp),%eax
  800712:	50                   	push   %eax
  800713:	e8 3c fd ff ff       	call   800454 <getint>
  800718:	83 c4 10             	add    $0x10,%esp
  80071b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80071e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800721:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800724:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800727:	85 d2                	test   %edx,%edx
  800729:	79 23                	jns    80074e <vprintfmt+0x29b>
				putch('-', putdat);
  80072b:	83 ec 08             	sub    $0x8,%esp
  80072e:	ff 75 0c             	pushl  0xc(%ebp)
  800731:	6a 2d                	push   $0x2d
  800733:	8b 45 08             	mov    0x8(%ebp),%eax
  800736:	ff d0                	call   *%eax
  800738:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80073b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80073e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800741:	f7 d8                	neg    %eax
  800743:	83 d2 00             	adc    $0x0,%edx
  800746:	f7 da                	neg    %edx
  800748:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80074b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80074e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800755:	e9 bc 00 00 00       	jmp    800816 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80075a:	83 ec 08             	sub    $0x8,%esp
  80075d:	ff 75 e8             	pushl  -0x18(%ebp)
  800760:	8d 45 14             	lea    0x14(%ebp),%eax
  800763:	50                   	push   %eax
  800764:	e8 84 fc ff ff       	call   8003ed <getuint>
  800769:	83 c4 10             	add    $0x10,%esp
  80076c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80076f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800772:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800779:	e9 98 00 00 00       	jmp    800816 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80077e:	83 ec 08             	sub    $0x8,%esp
  800781:	ff 75 0c             	pushl  0xc(%ebp)
  800784:	6a 58                	push   $0x58
  800786:	8b 45 08             	mov    0x8(%ebp),%eax
  800789:	ff d0                	call   *%eax
  80078b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80078e:	83 ec 08             	sub    $0x8,%esp
  800791:	ff 75 0c             	pushl  0xc(%ebp)
  800794:	6a 58                	push   $0x58
  800796:	8b 45 08             	mov    0x8(%ebp),%eax
  800799:	ff d0                	call   *%eax
  80079b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80079e:	83 ec 08             	sub    $0x8,%esp
  8007a1:	ff 75 0c             	pushl  0xc(%ebp)
  8007a4:	6a 58                	push   $0x58
  8007a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a9:	ff d0                	call   *%eax
  8007ab:	83 c4 10             	add    $0x10,%esp
			break;
  8007ae:	e9 bc 00 00 00       	jmp    80086f <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007b3:	83 ec 08             	sub    $0x8,%esp
  8007b6:	ff 75 0c             	pushl  0xc(%ebp)
  8007b9:	6a 30                	push   $0x30
  8007bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007be:	ff d0                	call   *%eax
  8007c0:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007c3:	83 ec 08             	sub    $0x8,%esp
  8007c6:	ff 75 0c             	pushl  0xc(%ebp)
  8007c9:	6a 78                	push   $0x78
  8007cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ce:	ff d0                	call   *%eax
  8007d0:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d6:	83 c0 04             	add    $0x4,%eax
  8007d9:	89 45 14             	mov    %eax,0x14(%ebp)
  8007dc:	8b 45 14             	mov    0x14(%ebp),%eax
  8007df:	83 e8 04             	sub    $0x4,%eax
  8007e2:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007e7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007ee:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007f5:	eb 1f                	jmp    800816 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007f7:	83 ec 08             	sub    $0x8,%esp
  8007fa:	ff 75 e8             	pushl  -0x18(%ebp)
  8007fd:	8d 45 14             	lea    0x14(%ebp),%eax
  800800:	50                   	push   %eax
  800801:	e8 e7 fb ff ff       	call   8003ed <getuint>
  800806:	83 c4 10             	add    $0x10,%esp
  800809:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80080c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80080f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800816:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80081a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80081d:	83 ec 04             	sub    $0x4,%esp
  800820:	52                   	push   %edx
  800821:	ff 75 e4             	pushl  -0x1c(%ebp)
  800824:	50                   	push   %eax
  800825:	ff 75 f4             	pushl  -0xc(%ebp)
  800828:	ff 75 f0             	pushl  -0x10(%ebp)
  80082b:	ff 75 0c             	pushl  0xc(%ebp)
  80082e:	ff 75 08             	pushl  0x8(%ebp)
  800831:	e8 00 fb ff ff       	call   800336 <printnum>
  800836:	83 c4 20             	add    $0x20,%esp
			break;
  800839:	eb 34                	jmp    80086f <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80083b:	83 ec 08             	sub    $0x8,%esp
  80083e:	ff 75 0c             	pushl  0xc(%ebp)
  800841:	53                   	push   %ebx
  800842:	8b 45 08             	mov    0x8(%ebp),%eax
  800845:	ff d0                	call   *%eax
  800847:	83 c4 10             	add    $0x10,%esp
			break;
  80084a:	eb 23                	jmp    80086f <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80084c:	83 ec 08             	sub    $0x8,%esp
  80084f:	ff 75 0c             	pushl  0xc(%ebp)
  800852:	6a 25                	push   $0x25
  800854:	8b 45 08             	mov    0x8(%ebp),%eax
  800857:	ff d0                	call   *%eax
  800859:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80085c:	ff 4d 10             	decl   0x10(%ebp)
  80085f:	eb 03                	jmp    800864 <vprintfmt+0x3b1>
  800861:	ff 4d 10             	decl   0x10(%ebp)
  800864:	8b 45 10             	mov    0x10(%ebp),%eax
  800867:	48                   	dec    %eax
  800868:	8a 00                	mov    (%eax),%al
  80086a:	3c 25                	cmp    $0x25,%al
  80086c:	75 f3                	jne    800861 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80086e:	90                   	nop
		}
	}
  80086f:	e9 47 fc ff ff       	jmp    8004bb <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800874:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800875:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800878:	5b                   	pop    %ebx
  800879:	5e                   	pop    %esi
  80087a:	5d                   	pop    %ebp
  80087b:	c3                   	ret    

0080087c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80087c:	55                   	push   %ebp
  80087d:	89 e5                	mov    %esp,%ebp
  80087f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800882:	8d 45 10             	lea    0x10(%ebp),%eax
  800885:	83 c0 04             	add    $0x4,%eax
  800888:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80088b:	8b 45 10             	mov    0x10(%ebp),%eax
  80088e:	ff 75 f4             	pushl  -0xc(%ebp)
  800891:	50                   	push   %eax
  800892:	ff 75 0c             	pushl  0xc(%ebp)
  800895:	ff 75 08             	pushl  0x8(%ebp)
  800898:	e8 16 fc ff ff       	call   8004b3 <vprintfmt>
  80089d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8008a0:	90                   	nop
  8008a1:	c9                   	leave  
  8008a2:	c3                   	ret    

008008a3 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8008a3:	55                   	push   %ebp
  8008a4:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8008a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a9:	8b 40 08             	mov    0x8(%eax),%eax
  8008ac:	8d 50 01             	lea    0x1(%eax),%edx
  8008af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b2:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b8:	8b 10                	mov    (%eax),%edx
  8008ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008bd:	8b 40 04             	mov    0x4(%eax),%eax
  8008c0:	39 c2                	cmp    %eax,%edx
  8008c2:	73 12                	jae    8008d6 <sprintputch+0x33>
		*b->buf++ = ch;
  8008c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c7:	8b 00                	mov    (%eax),%eax
  8008c9:	8d 48 01             	lea    0x1(%eax),%ecx
  8008cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008cf:	89 0a                	mov    %ecx,(%edx)
  8008d1:	8b 55 08             	mov    0x8(%ebp),%edx
  8008d4:	88 10                	mov    %dl,(%eax)
}
  8008d6:	90                   	nop
  8008d7:	5d                   	pop    %ebp
  8008d8:	c3                   	ret    

008008d9 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008d9:	55                   	push   %ebp
  8008da:	89 e5                	mov    %esp,%ebp
  8008dc:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008df:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ee:	01 d0                	add    %edx,%eax
  8008f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008f3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008fa:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008fe:	74 06                	je     800906 <vsnprintf+0x2d>
  800900:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800904:	7f 07                	jg     80090d <vsnprintf+0x34>
		return -E_INVAL;
  800906:	b8 03 00 00 00       	mov    $0x3,%eax
  80090b:	eb 20                	jmp    80092d <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80090d:	ff 75 14             	pushl  0x14(%ebp)
  800910:	ff 75 10             	pushl  0x10(%ebp)
  800913:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800916:	50                   	push   %eax
  800917:	68 a3 08 80 00       	push   $0x8008a3
  80091c:	e8 92 fb ff ff       	call   8004b3 <vprintfmt>
  800921:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800924:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800927:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80092a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80092d:	c9                   	leave  
  80092e:	c3                   	ret    

0080092f <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80092f:	55                   	push   %ebp
  800930:	89 e5                	mov    %esp,%ebp
  800932:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800935:	8d 45 10             	lea    0x10(%ebp),%eax
  800938:	83 c0 04             	add    $0x4,%eax
  80093b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80093e:	8b 45 10             	mov    0x10(%ebp),%eax
  800941:	ff 75 f4             	pushl  -0xc(%ebp)
  800944:	50                   	push   %eax
  800945:	ff 75 0c             	pushl  0xc(%ebp)
  800948:	ff 75 08             	pushl  0x8(%ebp)
  80094b:	e8 89 ff ff ff       	call   8008d9 <vsnprintf>
  800950:	83 c4 10             	add    $0x10,%esp
  800953:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800956:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800959:	c9                   	leave  
  80095a:	c3                   	ret    

0080095b <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80095b:	55                   	push   %ebp
  80095c:	89 e5                	mov    %esp,%ebp
  80095e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800961:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800968:	eb 06                	jmp    800970 <strlen+0x15>
		n++;
  80096a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80096d:	ff 45 08             	incl   0x8(%ebp)
  800970:	8b 45 08             	mov    0x8(%ebp),%eax
  800973:	8a 00                	mov    (%eax),%al
  800975:	84 c0                	test   %al,%al
  800977:	75 f1                	jne    80096a <strlen+0xf>
		n++;
	return n;
  800979:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80097c:	c9                   	leave  
  80097d:	c3                   	ret    

0080097e <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80097e:	55                   	push   %ebp
  80097f:	89 e5                	mov    %esp,%ebp
  800981:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800984:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80098b:	eb 09                	jmp    800996 <strnlen+0x18>
		n++;
  80098d:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800990:	ff 45 08             	incl   0x8(%ebp)
  800993:	ff 4d 0c             	decl   0xc(%ebp)
  800996:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80099a:	74 09                	je     8009a5 <strnlen+0x27>
  80099c:	8b 45 08             	mov    0x8(%ebp),%eax
  80099f:	8a 00                	mov    (%eax),%al
  8009a1:	84 c0                	test   %al,%al
  8009a3:	75 e8                	jne    80098d <strnlen+0xf>
		n++;
	return n;
  8009a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009a8:	c9                   	leave  
  8009a9:	c3                   	ret    

008009aa <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8009aa:	55                   	push   %ebp
  8009ab:	89 e5                	mov    %esp,%ebp
  8009ad:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8009b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8009b6:	90                   	nop
  8009b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ba:	8d 50 01             	lea    0x1(%eax),%edx
  8009bd:	89 55 08             	mov    %edx,0x8(%ebp)
  8009c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009c3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009c6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009c9:	8a 12                	mov    (%edx),%dl
  8009cb:	88 10                	mov    %dl,(%eax)
  8009cd:	8a 00                	mov    (%eax),%al
  8009cf:	84 c0                	test   %al,%al
  8009d1:	75 e4                	jne    8009b7 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8009d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009d6:	c9                   	leave  
  8009d7:	c3                   	ret    

008009d8 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8009d8:	55                   	push   %ebp
  8009d9:	89 e5                	mov    %esp,%ebp
  8009db:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8009de:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009eb:	eb 1f                	jmp    800a0c <strncpy+0x34>
		*dst++ = *src;
  8009ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f0:	8d 50 01             	lea    0x1(%eax),%edx
  8009f3:	89 55 08             	mov    %edx,0x8(%ebp)
  8009f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009f9:	8a 12                	mov    (%edx),%dl
  8009fb:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a00:	8a 00                	mov    (%eax),%al
  800a02:	84 c0                	test   %al,%al
  800a04:	74 03                	je     800a09 <strncpy+0x31>
			src++;
  800a06:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a09:	ff 45 fc             	incl   -0x4(%ebp)
  800a0c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a0f:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a12:	72 d9                	jb     8009ed <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a14:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a17:	c9                   	leave  
  800a18:	c3                   	ret    

00800a19 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a19:	55                   	push   %ebp
  800a1a:	89 e5                	mov    %esp,%ebp
  800a1c:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a22:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a25:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a29:	74 30                	je     800a5b <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a2b:	eb 16                	jmp    800a43 <strlcpy+0x2a>
			*dst++ = *src++;
  800a2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a30:	8d 50 01             	lea    0x1(%eax),%edx
  800a33:	89 55 08             	mov    %edx,0x8(%ebp)
  800a36:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a39:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a3c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a3f:	8a 12                	mov    (%edx),%dl
  800a41:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a43:	ff 4d 10             	decl   0x10(%ebp)
  800a46:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a4a:	74 09                	je     800a55 <strlcpy+0x3c>
  800a4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4f:	8a 00                	mov    (%eax),%al
  800a51:	84 c0                	test   %al,%al
  800a53:	75 d8                	jne    800a2d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a55:	8b 45 08             	mov    0x8(%ebp),%eax
  800a58:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a5b:	8b 55 08             	mov    0x8(%ebp),%edx
  800a5e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a61:	29 c2                	sub    %eax,%edx
  800a63:	89 d0                	mov    %edx,%eax
}
  800a65:	c9                   	leave  
  800a66:	c3                   	ret    

00800a67 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a67:	55                   	push   %ebp
  800a68:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a6a:	eb 06                	jmp    800a72 <strcmp+0xb>
		p++, q++;
  800a6c:	ff 45 08             	incl   0x8(%ebp)
  800a6f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a72:	8b 45 08             	mov    0x8(%ebp),%eax
  800a75:	8a 00                	mov    (%eax),%al
  800a77:	84 c0                	test   %al,%al
  800a79:	74 0e                	je     800a89 <strcmp+0x22>
  800a7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7e:	8a 10                	mov    (%eax),%dl
  800a80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a83:	8a 00                	mov    (%eax),%al
  800a85:	38 c2                	cmp    %al,%dl
  800a87:	74 e3                	je     800a6c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a89:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8c:	8a 00                	mov    (%eax),%al
  800a8e:	0f b6 d0             	movzbl %al,%edx
  800a91:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a94:	8a 00                	mov    (%eax),%al
  800a96:	0f b6 c0             	movzbl %al,%eax
  800a99:	29 c2                	sub    %eax,%edx
  800a9b:	89 d0                	mov    %edx,%eax
}
  800a9d:	5d                   	pop    %ebp
  800a9e:	c3                   	ret    

00800a9f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a9f:	55                   	push   %ebp
  800aa0:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800aa2:	eb 09                	jmp    800aad <strncmp+0xe>
		n--, p++, q++;
  800aa4:	ff 4d 10             	decl   0x10(%ebp)
  800aa7:	ff 45 08             	incl   0x8(%ebp)
  800aaa:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800aad:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ab1:	74 17                	je     800aca <strncmp+0x2b>
  800ab3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab6:	8a 00                	mov    (%eax),%al
  800ab8:	84 c0                	test   %al,%al
  800aba:	74 0e                	je     800aca <strncmp+0x2b>
  800abc:	8b 45 08             	mov    0x8(%ebp),%eax
  800abf:	8a 10                	mov    (%eax),%dl
  800ac1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac4:	8a 00                	mov    (%eax),%al
  800ac6:	38 c2                	cmp    %al,%dl
  800ac8:	74 da                	je     800aa4 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800aca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ace:	75 07                	jne    800ad7 <strncmp+0x38>
		return 0;
  800ad0:	b8 00 00 00 00       	mov    $0x0,%eax
  800ad5:	eb 14                	jmp    800aeb <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ada:	8a 00                	mov    (%eax),%al
  800adc:	0f b6 d0             	movzbl %al,%edx
  800adf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae2:	8a 00                	mov    (%eax),%al
  800ae4:	0f b6 c0             	movzbl %al,%eax
  800ae7:	29 c2                	sub    %eax,%edx
  800ae9:	89 d0                	mov    %edx,%eax
}
  800aeb:	5d                   	pop    %ebp
  800aec:	c3                   	ret    

00800aed <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800aed:	55                   	push   %ebp
  800aee:	89 e5                	mov    %esp,%ebp
  800af0:	83 ec 04             	sub    $0x4,%esp
  800af3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800af9:	eb 12                	jmp    800b0d <strchr+0x20>
		if (*s == c)
  800afb:	8b 45 08             	mov    0x8(%ebp),%eax
  800afe:	8a 00                	mov    (%eax),%al
  800b00:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b03:	75 05                	jne    800b0a <strchr+0x1d>
			return (char *) s;
  800b05:	8b 45 08             	mov    0x8(%ebp),%eax
  800b08:	eb 11                	jmp    800b1b <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b0a:	ff 45 08             	incl   0x8(%ebp)
  800b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b10:	8a 00                	mov    (%eax),%al
  800b12:	84 c0                	test   %al,%al
  800b14:	75 e5                	jne    800afb <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b16:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b1b:	c9                   	leave  
  800b1c:	c3                   	ret    

00800b1d <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b1d:	55                   	push   %ebp
  800b1e:	89 e5                	mov    %esp,%ebp
  800b20:	83 ec 04             	sub    $0x4,%esp
  800b23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b26:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b29:	eb 0d                	jmp    800b38 <strfind+0x1b>
		if (*s == c)
  800b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2e:	8a 00                	mov    (%eax),%al
  800b30:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b33:	74 0e                	je     800b43 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b35:	ff 45 08             	incl   0x8(%ebp)
  800b38:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3b:	8a 00                	mov    (%eax),%al
  800b3d:	84 c0                	test   %al,%al
  800b3f:	75 ea                	jne    800b2b <strfind+0xe>
  800b41:	eb 01                	jmp    800b44 <strfind+0x27>
		if (*s == c)
			break;
  800b43:	90                   	nop
	return (char *) s;
  800b44:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b47:	c9                   	leave  
  800b48:	c3                   	ret    

00800b49 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b49:	55                   	push   %ebp
  800b4a:	89 e5                	mov    %esp,%ebp
  800b4c:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b52:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b55:	8b 45 10             	mov    0x10(%ebp),%eax
  800b58:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b5b:	eb 0e                	jmp    800b6b <memset+0x22>
		*p++ = c;
  800b5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b60:	8d 50 01             	lea    0x1(%eax),%edx
  800b63:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b66:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b69:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b6b:	ff 4d f8             	decl   -0x8(%ebp)
  800b6e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b72:	79 e9                	jns    800b5d <memset+0x14>
		*p++ = c;

	return v;
  800b74:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b77:	c9                   	leave  
  800b78:	c3                   	ret    

00800b79 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b79:	55                   	push   %ebp
  800b7a:	89 e5                	mov    %esp,%ebp
  800b7c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b82:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b85:	8b 45 08             	mov    0x8(%ebp),%eax
  800b88:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b8b:	eb 16                	jmp    800ba3 <memcpy+0x2a>
		*d++ = *s++;
  800b8d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b90:	8d 50 01             	lea    0x1(%eax),%edx
  800b93:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b96:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b99:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b9c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b9f:	8a 12                	mov    (%edx),%dl
  800ba1:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800ba3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ba9:	89 55 10             	mov    %edx,0x10(%ebp)
  800bac:	85 c0                	test   %eax,%eax
  800bae:	75 dd                	jne    800b8d <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800bb0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bb3:	c9                   	leave  
  800bb4:	c3                   	ret    

00800bb5 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800bb5:	55                   	push   %ebp
  800bb6:	89 e5                	mov    %esp,%ebp
  800bb8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800bbb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bbe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800bc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800bc7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bca:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bcd:	73 50                	jae    800c1f <memmove+0x6a>
  800bcf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bd2:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd5:	01 d0                	add    %edx,%eax
  800bd7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bda:	76 43                	jbe    800c1f <memmove+0x6a>
		s += n;
  800bdc:	8b 45 10             	mov    0x10(%ebp),%eax
  800bdf:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800be2:	8b 45 10             	mov    0x10(%ebp),%eax
  800be5:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800be8:	eb 10                	jmp    800bfa <memmove+0x45>
			*--d = *--s;
  800bea:	ff 4d f8             	decl   -0x8(%ebp)
  800bed:	ff 4d fc             	decl   -0x4(%ebp)
  800bf0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bf3:	8a 10                	mov    (%eax),%dl
  800bf5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bf8:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bfa:	8b 45 10             	mov    0x10(%ebp),%eax
  800bfd:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c00:	89 55 10             	mov    %edx,0x10(%ebp)
  800c03:	85 c0                	test   %eax,%eax
  800c05:	75 e3                	jne    800bea <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c07:	eb 23                	jmp    800c2c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c09:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c0c:	8d 50 01             	lea    0x1(%eax),%edx
  800c0f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c12:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c15:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c18:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c1b:	8a 12                	mov    (%edx),%dl
  800c1d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c1f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c22:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c25:	89 55 10             	mov    %edx,0x10(%ebp)
  800c28:	85 c0                	test   %eax,%eax
  800c2a:	75 dd                	jne    800c09 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c2c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c2f:	c9                   	leave  
  800c30:	c3                   	ret    

00800c31 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c31:	55                   	push   %ebp
  800c32:	89 e5                	mov    %esp,%ebp
  800c34:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c37:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c40:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c43:	eb 2a                	jmp    800c6f <memcmp+0x3e>
		if (*s1 != *s2)
  800c45:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c48:	8a 10                	mov    (%eax),%dl
  800c4a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c4d:	8a 00                	mov    (%eax),%al
  800c4f:	38 c2                	cmp    %al,%dl
  800c51:	74 16                	je     800c69 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c53:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c56:	8a 00                	mov    (%eax),%al
  800c58:	0f b6 d0             	movzbl %al,%edx
  800c5b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c5e:	8a 00                	mov    (%eax),%al
  800c60:	0f b6 c0             	movzbl %al,%eax
  800c63:	29 c2                	sub    %eax,%edx
  800c65:	89 d0                	mov    %edx,%eax
  800c67:	eb 18                	jmp    800c81 <memcmp+0x50>
		s1++, s2++;
  800c69:	ff 45 fc             	incl   -0x4(%ebp)
  800c6c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c6f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c72:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c75:	89 55 10             	mov    %edx,0x10(%ebp)
  800c78:	85 c0                	test   %eax,%eax
  800c7a:	75 c9                	jne    800c45 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c7c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c81:	c9                   	leave  
  800c82:	c3                   	ret    

00800c83 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c83:	55                   	push   %ebp
  800c84:	89 e5                	mov    %esp,%ebp
  800c86:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c89:	8b 55 08             	mov    0x8(%ebp),%edx
  800c8c:	8b 45 10             	mov    0x10(%ebp),%eax
  800c8f:	01 d0                	add    %edx,%eax
  800c91:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c94:	eb 15                	jmp    800cab <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c96:	8b 45 08             	mov    0x8(%ebp),%eax
  800c99:	8a 00                	mov    (%eax),%al
  800c9b:	0f b6 d0             	movzbl %al,%edx
  800c9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca1:	0f b6 c0             	movzbl %al,%eax
  800ca4:	39 c2                	cmp    %eax,%edx
  800ca6:	74 0d                	je     800cb5 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ca8:	ff 45 08             	incl   0x8(%ebp)
  800cab:	8b 45 08             	mov    0x8(%ebp),%eax
  800cae:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800cb1:	72 e3                	jb     800c96 <memfind+0x13>
  800cb3:	eb 01                	jmp    800cb6 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800cb5:	90                   	nop
	return (void *) s;
  800cb6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cb9:	c9                   	leave  
  800cba:	c3                   	ret    

00800cbb <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800cbb:	55                   	push   %ebp
  800cbc:	89 e5                	mov    %esp,%ebp
  800cbe:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800cc1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800cc8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ccf:	eb 03                	jmp    800cd4 <strtol+0x19>
		s++;
  800cd1:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd7:	8a 00                	mov    (%eax),%al
  800cd9:	3c 20                	cmp    $0x20,%al
  800cdb:	74 f4                	je     800cd1 <strtol+0x16>
  800cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce0:	8a 00                	mov    (%eax),%al
  800ce2:	3c 09                	cmp    $0x9,%al
  800ce4:	74 eb                	je     800cd1 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ce6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce9:	8a 00                	mov    (%eax),%al
  800ceb:	3c 2b                	cmp    $0x2b,%al
  800ced:	75 05                	jne    800cf4 <strtol+0x39>
		s++;
  800cef:	ff 45 08             	incl   0x8(%ebp)
  800cf2:	eb 13                	jmp    800d07 <strtol+0x4c>
	else if (*s == '-')
  800cf4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf7:	8a 00                	mov    (%eax),%al
  800cf9:	3c 2d                	cmp    $0x2d,%al
  800cfb:	75 0a                	jne    800d07 <strtol+0x4c>
		s++, neg = 1;
  800cfd:	ff 45 08             	incl   0x8(%ebp)
  800d00:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d07:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d0b:	74 06                	je     800d13 <strtol+0x58>
  800d0d:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d11:	75 20                	jne    800d33 <strtol+0x78>
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
  800d16:	8a 00                	mov    (%eax),%al
  800d18:	3c 30                	cmp    $0x30,%al
  800d1a:	75 17                	jne    800d33 <strtol+0x78>
  800d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1f:	40                   	inc    %eax
  800d20:	8a 00                	mov    (%eax),%al
  800d22:	3c 78                	cmp    $0x78,%al
  800d24:	75 0d                	jne    800d33 <strtol+0x78>
		s += 2, base = 16;
  800d26:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d2a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d31:	eb 28                	jmp    800d5b <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d33:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d37:	75 15                	jne    800d4e <strtol+0x93>
  800d39:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3c:	8a 00                	mov    (%eax),%al
  800d3e:	3c 30                	cmp    $0x30,%al
  800d40:	75 0c                	jne    800d4e <strtol+0x93>
		s++, base = 8;
  800d42:	ff 45 08             	incl   0x8(%ebp)
  800d45:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d4c:	eb 0d                	jmp    800d5b <strtol+0xa0>
	else if (base == 0)
  800d4e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d52:	75 07                	jne    800d5b <strtol+0xa0>
		base = 10;
  800d54:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5e:	8a 00                	mov    (%eax),%al
  800d60:	3c 2f                	cmp    $0x2f,%al
  800d62:	7e 19                	jle    800d7d <strtol+0xc2>
  800d64:	8b 45 08             	mov    0x8(%ebp),%eax
  800d67:	8a 00                	mov    (%eax),%al
  800d69:	3c 39                	cmp    $0x39,%al
  800d6b:	7f 10                	jg     800d7d <strtol+0xc2>
			dig = *s - '0';
  800d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d70:	8a 00                	mov    (%eax),%al
  800d72:	0f be c0             	movsbl %al,%eax
  800d75:	83 e8 30             	sub    $0x30,%eax
  800d78:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d7b:	eb 42                	jmp    800dbf <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d80:	8a 00                	mov    (%eax),%al
  800d82:	3c 60                	cmp    $0x60,%al
  800d84:	7e 19                	jle    800d9f <strtol+0xe4>
  800d86:	8b 45 08             	mov    0x8(%ebp),%eax
  800d89:	8a 00                	mov    (%eax),%al
  800d8b:	3c 7a                	cmp    $0x7a,%al
  800d8d:	7f 10                	jg     800d9f <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d92:	8a 00                	mov    (%eax),%al
  800d94:	0f be c0             	movsbl %al,%eax
  800d97:	83 e8 57             	sub    $0x57,%eax
  800d9a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d9d:	eb 20                	jmp    800dbf <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800da2:	8a 00                	mov    (%eax),%al
  800da4:	3c 40                	cmp    $0x40,%al
  800da6:	7e 39                	jle    800de1 <strtol+0x126>
  800da8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dab:	8a 00                	mov    (%eax),%al
  800dad:	3c 5a                	cmp    $0x5a,%al
  800daf:	7f 30                	jg     800de1 <strtol+0x126>
			dig = *s - 'A' + 10;
  800db1:	8b 45 08             	mov    0x8(%ebp),%eax
  800db4:	8a 00                	mov    (%eax),%al
  800db6:	0f be c0             	movsbl %al,%eax
  800db9:	83 e8 37             	sub    $0x37,%eax
  800dbc:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800dbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dc2:	3b 45 10             	cmp    0x10(%ebp),%eax
  800dc5:	7d 19                	jge    800de0 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800dc7:	ff 45 08             	incl   0x8(%ebp)
  800dca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dcd:	0f af 45 10          	imul   0x10(%ebp),%eax
  800dd1:	89 c2                	mov    %eax,%edx
  800dd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dd6:	01 d0                	add    %edx,%eax
  800dd8:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800ddb:	e9 7b ff ff ff       	jmp    800d5b <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800de0:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800de1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800de5:	74 08                	je     800def <strtol+0x134>
		*endptr = (char *) s;
  800de7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dea:	8b 55 08             	mov    0x8(%ebp),%edx
  800ded:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800def:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800df3:	74 07                	je     800dfc <strtol+0x141>
  800df5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df8:	f7 d8                	neg    %eax
  800dfa:	eb 03                	jmp    800dff <strtol+0x144>
  800dfc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dff:	c9                   	leave  
  800e00:	c3                   	ret    

00800e01 <ltostr>:

void
ltostr(long value, char *str)
{
  800e01:	55                   	push   %ebp
  800e02:	89 e5                	mov    %esp,%ebp
  800e04:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e07:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e0e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e15:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e19:	79 13                	jns    800e2e <ltostr+0x2d>
	{
		neg = 1;
  800e1b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e25:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e28:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e2b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e31:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e36:	99                   	cltd   
  800e37:	f7 f9                	idiv   %ecx
  800e39:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e3c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e3f:	8d 50 01             	lea    0x1(%eax),%edx
  800e42:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e45:	89 c2                	mov    %eax,%edx
  800e47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4a:	01 d0                	add    %edx,%eax
  800e4c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e4f:	83 c2 30             	add    $0x30,%edx
  800e52:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e54:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e57:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e5c:	f7 e9                	imul   %ecx
  800e5e:	c1 fa 02             	sar    $0x2,%edx
  800e61:	89 c8                	mov    %ecx,%eax
  800e63:	c1 f8 1f             	sar    $0x1f,%eax
  800e66:	29 c2                	sub    %eax,%edx
  800e68:	89 d0                	mov    %edx,%eax
  800e6a:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e6d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e70:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e75:	f7 e9                	imul   %ecx
  800e77:	c1 fa 02             	sar    $0x2,%edx
  800e7a:	89 c8                	mov    %ecx,%eax
  800e7c:	c1 f8 1f             	sar    $0x1f,%eax
  800e7f:	29 c2                	sub    %eax,%edx
  800e81:	89 d0                	mov    %edx,%eax
  800e83:	c1 e0 02             	shl    $0x2,%eax
  800e86:	01 d0                	add    %edx,%eax
  800e88:	01 c0                	add    %eax,%eax
  800e8a:	29 c1                	sub    %eax,%ecx
  800e8c:	89 ca                	mov    %ecx,%edx
  800e8e:	85 d2                	test   %edx,%edx
  800e90:	75 9c                	jne    800e2e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e92:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e99:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e9c:	48                   	dec    %eax
  800e9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800ea0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ea4:	74 3d                	je     800ee3 <ltostr+0xe2>
		start = 1 ;
  800ea6:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800ead:	eb 34                	jmp    800ee3 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800eaf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800eb2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb5:	01 d0                	add    %edx,%eax
  800eb7:	8a 00                	mov    (%eax),%al
  800eb9:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800ebc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ebf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec2:	01 c2                	add    %eax,%edx
  800ec4:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800ec7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eca:	01 c8                	add    %ecx,%eax
  800ecc:	8a 00                	mov    (%eax),%al
  800ece:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800ed0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800ed3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed6:	01 c2                	add    %eax,%edx
  800ed8:	8a 45 eb             	mov    -0x15(%ebp),%al
  800edb:	88 02                	mov    %al,(%edx)
		start++ ;
  800edd:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800ee0:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800ee3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ee6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ee9:	7c c4                	jl     800eaf <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800eeb:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800eee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef1:	01 d0                	add    %edx,%eax
  800ef3:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800ef6:	90                   	nop
  800ef7:	c9                   	leave  
  800ef8:	c3                   	ret    

00800ef9 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800ef9:	55                   	push   %ebp
  800efa:	89 e5                	mov    %esp,%ebp
  800efc:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800eff:	ff 75 08             	pushl  0x8(%ebp)
  800f02:	e8 54 fa ff ff       	call   80095b <strlen>
  800f07:	83 c4 04             	add    $0x4,%esp
  800f0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f0d:	ff 75 0c             	pushl  0xc(%ebp)
  800f10:	e8 46 fa ff ff       	call   80095b <strlen>
  800f15:	83 c4 04             	add    $0x4,%esp
  800f18:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f1b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f22:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f29:	eb 17                	jmp    800f42 <strcconcat+0x49>
		final[s] = str1[s] ;
  800f2b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f2e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f31:	01 c2                	add    %eax,%edx
  800f33:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f36:	8b 45 08             	mov    0x8(%ebp),%eax
  800f39:	01 c8                	add    %ecx,%eax
  800f3b:	8a 00                	mov    (%eax),%al
  800f3d:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f3f:	ff 45 fc             	incl   -0x4(%ebp)
  800f42:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f45:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f48:	7c e1                	jl     800f2b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f4a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f51:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f58:	eb 1f                	jmp    800f79 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f5d:	8d 50 01             	lea    0x1(%eax),%edx
  800f60:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f63:	89 c2                	mov    %eax,%edx
  800f65:	8b 45 10             	mov    0x10(%ebp),%eax
  800f68:	01 c2                	add    %eax,%edx
  800f6a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f70:	01 c8                	add    %ecx,%eax
  800f72:	8a 00                	mov    (%eax),%al
  800f74:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f76:	ff 45 f8             	incl   -0x8(%ebp)
  800f79:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f7c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f7f:	7c d9                	jl     800f5a <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f81:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f84:	8b 45 10             	mov    0x10(%ebp),%eax
  800f87:	01 d0                	add    %edx,%eax
  800f89:	c6 00 00             	movb   $0x0,(%eax)
}
  800f8c:	90                   	nop
  800f8d:	c9                   	leave  
  800f8e:	c3                   	ret    

00800f8f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f8f:	55                   	push   %ebp
  800f90:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f92:	8b 45 14             	mov    0x14(%ebp),%eax
  800f95:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f9b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f9e:	8b 00                	mov    (%eax),%eax
  800fa0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fa7:	8b 45 10             	mov    0x10(%ebp),%eax
  800faa:	01 d0                	add    %edx,%eax
  800fac:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800fb2:	eb 0c                	jmp    800fc0 <strsplit+0x31>
			*string++ = 0;
  800fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb7:	8d 50 01             	lea    0x1(%eax),%edx
  800fba:	89 55 08             	mov    %edx,0x8(%ebp)
  800fbd:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800fc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc3:	8a 00                	mov    (%eax),%al
  800fc5:	84 c0                	test   %al,%al
  800fc7:	74 18                	je     800fe1 <strsplit+0x52>
  800fc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcc:	8a 00                	mov    (%eax),%al
  800fce:	0f be c0             	movsbl %al,%eax
  800fd1:	50                   	push   %eax
  800fd2:	ff 75 0c             	pushl  0xc(%ebp)
  800fd5:	e8 13 fb ff ff       	call   800aed <strchr>
  800fda:	83 c4 08             	add    $0x8,%esp
  800fdd:	85 c0                	test   %eax,%eax
  800fdf:	75 d3                	jne    800fb4 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800fe1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe4:	8a 00                	mov    (%eax),%al
  800fe6:	84 c0                	test   %al,%al
  800fe8:	74 5a                	je     801044 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800fea:	8b 45 14             	mov    0x14(%ebp),%eax
  800fed:	8b 00                	mov    (%eax),%eax
  800fef:	83 f8 0f             	cmp    $0xf,%eax
  800ff2:	75 07                	jne    800ffb <strsplit+0x6c>
		{
			return 0;
  800ff4:	b8 00 00 00 00       	mov    $0x0,%eax
  800ff9:	eb 66                	jmp    801061 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800ffb:	8b 45 14             	mov    0x14(%ebp),%eax
  800ffe:	8b 00                	mov    (%eax),%eax
  801000:	8d 48 01             	lea    0x1(%eax),%ecx
  801003:	8b 55 14             	mov    0x14(%ebp),%edx
  801006:	89 0a                	mov    %ecx,(%edx)
  801008:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80100f:	8b 45 10             	mov    0x10(%ebp),%eax
  801012:	01 c2                	add    %eax,%edx
  801014:	8b 45 08             	mov    0x8(%ebp),%eax
  801017:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801019:	eb 03                	jmp    80101e <strsplit+0x8f>
			string++;
  80101b:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80101e:	8b 45 08             	mov    0x8(%ebp),%eax
  801021:	8a 00                	mov    (%eax),%al
  801023:	84 c0                	test   %al,%al
  801025:	74 8b                	je     800fb2 <strsplit+0x23>
  801027:	8b 45 08             	mov    0x8(%ebp),%eax
  80102a:	8a 00                	mov    (%eax),%al
  80102c:	0f be c0             	movsbl %al,%eax
  80102f:	50                   	push   %eax
  801030:	ff 75 0c             	pushl  0xc(%ebp)
  801033:	e8 b5 fa ff ff       	call   800aed <strchr>
  801038:	83 c4 08             	add    $0x8,%esp
  80103b:	85 c0                	test   %eax,%eax
  80103d:	74 dc                	je     80101b <strsplit+0x8c>
			string++;
	}
  80103f:	e9 6e ff ff ff       	jmp    800fb2 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801044:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801045:	8b 45 14             	mov    0x14(%ebp),%eax
  801048:	8b 00                	mov    (%eax),%eax
  80104a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801051:	8b 45 10             	mov    0x10(%ebp),%eax
  801054:	01 d0                	add    %edx,%eax
  801056:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80105c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801061:	c9                   	leave  
  801062:	c3                   	ret    

00801063 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801063:	55                   	push   %ebp
  801064:	89 e5                	mov    %esp,%ebp
  801066:	57                   	push   %edi
  801067:	56                   	push   %esi
  801068:	53                   	push   %ebx
  801069:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80106c:	8b 45 08             	mov    0x8(%ebp),%eax
  80106f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801072:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801075:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801078:	8b 7d 18             	mov    0x18(%ebp),%edi
  80107b:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80107e:	cd 30                	int    $0x30
  801080:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801083:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801086:	83 c4 10             	add    $0x10,%esp
  801089:	5b                   	pop    %ebx
  80108a:	5e                   	pop    %esi
  80108b:	5f                   	pop    %edi
  80108c:	5d                   	pop    %ebp
  80108d:	c3                   	ret    

0080108e <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80108e:	55                   	push   %ebp
  80108f:	89 e5                	mov    %esp,%ebp
  801091:	83 ec 04             	sub    $0x4,%esp
  801094:	8b 45 10             	mov    0x10(%ebp),%eax
  801097:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80109a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80109e:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a1:	6a 00                	push   $0x0
  8010a3:	6a 00                	push   $0x0
  8010a5:	52                   	push   %edx
  8010a6:	ff 75 0c             	pushl  0xc(%ebp)
  8010a9:	50                   	push   %eax
  8010aa:	6a 00                	push   $0x0
  8010ac:	e8 b2 ff ff ff       	call   801063 <syscall>
  8010b1:	83 c4 18             	add    $0x18,%esp
}
  8010b4:	90                   	nop
  8010b5:	c9                   	leave  
  8010b6:	c3                   	ret    

008010b7 <sys_cgetc>:

int
sys_cgetc(void)
{
  8010b7:	55                   	push   %ebp
  8010b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8010ba:	6a 00                	push   $0x0
  8010bc:	6a 00                	push   $0x0
  8010be:	6a 00                	push   $0x0
  8010c0:	6a 00                	push   $0x0
  8010c2:	6a 00                	push   $0x0
  8010c4:	6a 01                	push   $0x1
  8010c6:	e8 98 ff ff ff       	call   801063 <syscall>
  8010cb:	83 c4 18             	add    $0x18,%esp
}
  8010ce:	c9                   	leave  
  8010cf:	c3                   	ret    

008010d0 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8010d0:	55                   	push   %ebp
  8010d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8010d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d6:	6a 00                	push   $0x0
  8010d8:	6a 00                	push   $0x0
  8010da:	6a 00                	push   $0x0
  8010dc:	6a 00                	push   $0x0
  8010de:	50                   	push   %eax
  8010df:	6a 05                	push   $0x5
  8010e1:	e8 7d ff ff ff       	call   801063 <syscall>
  8010e6:	83 c4 18             	add    $0x18,%esp
}
  8010e9:	c9                   	leave  
  8010ea:	c3                   	ret    

008010eb <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010eb:	55                   	push   %ebp
  8010ec:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010ee:	6a 00                	push   $0x0
  8010f0:	6a 00                	push   $0x0
  8010f2:	6a 00                	push   $0x0
  8010f4:	6a 00                	push   $0x0
  8010f6:	6a 00                	push   $0x0
  8010f8:	6a 02                	push   $0x2
  8010fa:	e8 64 ff ff ff       	call   801063 <syscall>
  8010ff:	83 c4 18             	add    $0x18,%esp
}
  801102:	c9                   	leave  
  801103:	c3                   	ret    

00801104 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801104:	55                   	push   %ebp
  801105:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801107:	6a 00                	push   $0x0
  801109:	6a 00                	push   $0x0
  80110b:	6a 00                	push   $0x0
  80110d:	6a 00                	push   $0x0
  80110f:	6a 00                	push   $0x0
  801111:	6a 03                	push   $0x3
  801113:	e8 4b ff ff ff       	call   801063 <syscall>
  801118:	83 c4 18             	add    $0x18,%esp
}
  80111b:	c9                   	leave  
  80111c:	c3                   	ret    

0080111d <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80111d:	55                   	push   %ebp
  80111e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801120:	6a 00                	push   $0x0
  801122:	6a 00                	push   $0x0
  801124:	6a 00                	push   $0x0
  801126:	6a 00                	push   $0x0
  801128:	6a 00                	push   $0x0
  80112a:	6a 04                	push   $0x4
  80112c:	e8 32 ff ff ff       	call   801063 <syscall>
  801131:	83 c4 18             	add    $0x18,%esp
}
  801134:	c9                   	leave  
  801135:	c3                   	ret    

00801136 <sys_env_exit>:


void sys_env_exit(void)
{
  801136:	55                   	push   %ebp
  801137:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801139:	6a 00                	push   $0x0
  80113b:	6a 00                	push   $0x0
  80113d:	6a 00                	push   $0x0
  80113f:	6a 00                	push   $0x0
  801141:	6a 00                	push   $0x0
  801143:	6a 06                	push   $0x6
  801145:	e8 19 ff ff ff       	call   801063 <syscall>
  80114a:	83 c4 18             	add    $0x18,%esp
}
  80114d:	90                   	nop
  80114e:	c9                   	leave  
  80114f:	c3                   	ret    

00801150 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801150:	55                   	push   %ebp
  801151:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801153:	8b 55 0c             	mov    0xc(%ebp),%edx
  801156:	8b 45 08             	mov    0x8(%ebp),%eax
  801159:	6a 00                	push   $0x0
  80115b:	6a 00                	push   $0x0
  80115d:	6a 00                	push   $0x0
  80115f:	52                   	push   %edx
  801160:	50                   	push   %eax
  801161:	6a 07                	push   $0x7
  801163:	e8 fb fe ff ff       	call   801063 <syscall>
  801168:	83 c4 18             	add    $0x18,%esp
}
  80116b:	c9                   	leave  
  80116c:	c3                   	ret    

0080116d <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80116d:	55                   	push   %ebp
  80116e:	89 e5                	mov    %esp,%ebp
  801170:	56                   	push   %esi
  801171:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801172:	8b 75 18             	mov    0x18(%ebp),%esi
  801175:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801178:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80117b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80117e:	8b 45 08             	mov    0x8(%ebp),%eax
  801181:	56                   	push   %esi
  801182:	53                   	push   %ebx
  801183:	51                   	push   %ecx
  801184:	52                   	push   %edx
  801185:	50                   	push   %eax
  801186:	6a 08                	push   $0x8
  801188:	e8 d6 fe ff ff       	call   801063 <syscall>
  80118d:	83 c4 18             	add    $0x18,%esp
}
  801190:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801193:	5b                   	pop    %ebx
  801194:	5e                   	pop    %esi
  801195:	5d                   	pop    %ebp
  801196:	c3                   	ret    

00801197 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801197:	55                   	push   %ebp
  801198:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80119a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80119d:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a0:	6a 00                	push   $0x0
  8011a2:	6a 00                	push   $0x0
  8011a4:	6a 00                	push   $0x0
  8011a6:	52                   	push   %edx
  8011a7:	50                   	push   %eax
  8011a8:	6a 09                	push   $0x9
  8011aa:	e8 b4 fe ff ff       	call   801063 <syscall>
  8011af:	83 c4 18             	add    $0x18,%esp
}
  8011b2:	c9                   	leave  
  8011b3:	c3                   	ret    

008011b4 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8011b4:	55                   	push   %ebp
  8011b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8011b7:	6a 00                	push   $0x0
  8011b9:	6a 00                	push   $0x0
  8011bb:	6a 00                	push   $0x0
  8011bd:	ff 75 0c             	pushl  0xc(%ebp)
  8011c0:	ff 75 08             	pushl  0x8(%ebp)
  8011c3:	6a 0a                	push   $0xa
  8011c5:	e8 99 fe ff ff       	call   801063 <syscall>
  8011ca:	83 c4 18             	add    $0x18,%esp
}
  8011cd:	c9                   	leave  
  8011ce:	c3                   	ret    

008011cf <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8011cf:	55                   	push   %ebp
  8011d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8011d2:	6a 00                	push   $0x0
  8011d4:	6a 00                	push   $0x0
  8011d6:	6a 00                	push   $0x0
  8011d8:	6a 00                	push   $0x0
  8011da:	6a 00                	push   $0x0
  8011dc:	6a 0b                	push   $0xb
  8011de:	e8 80 fe ff ff       	call   801063 <syscall>
  8011e3:	83 c4 18             	add    $0x18,%esp
}
  8011e6:	c9                   	leave  
  8011e7:	c3                   	ret    

008011e8 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011e8:	55                   	push   %ebp
  8011e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011eb:	6a 00                	push   $0x0
  8011ed:	6a 00                	push   $0x0
  8011ef:	6a 00                	push   $0x0
  8011f1:	6a 00                	push   $0x0
  8011f3:	6a 00                	push   $0x0
  8011f5:	6a 0c                	push   $0xc
  8011f7:	e8 67 fe ff ff       	call   801063 <syscall>
  8011fc:	83 c4 18             	add    $0x18,%esp
}
  8011ff:	c9                   	leave  
  801200:	c3                   	ret    

00801201 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801201:	55                   	push   %ebp
  801202:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801204:	6a 00                	push   $0x0
  801206:	6a 00                	push   $0x0
  801208:	6a 00                	push   $0x0
  80120a:	6a 00                	push   $0x0
  80120c:	6a 00                	push   $0x0
  80120e:	6a 0d                	push   $0xd
  801210:	e8 4e fe ff ff       	call   801063 <syscall>
  801215:	83 c4 18             	add    $0x18,%esp
}
  801218:	c9                   	leave  
  801219:	c3                   	ret    

0080121a <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80121a:	55                   	push   %ebp
  80121b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80121d:	6a 00                	push   $0x0
  80121f:	6a 00                	push   $0x0
  801221:	6a 00                	push   $0x0
  801223:	ff 75 0c             	pushl  0xc(%ebp)
  801226:	ff 75 08             	pushl  0x8(%ebp)
  801229:	6a 11                	push   $0x11
  80122b:	e8 33 fe ff ff       	call   801063 <syscall>
  801230:	83 c4 18             	add    $0x18,%esp
	return;
  801233:	90                   	nop
}
  801234:	c9                   	leave  
  801235:	c3                   	ret    

00801236 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801236:	55                   	push   %ebp
  801237:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801239:	6a 00                	push   $0x0
  80123b:	6a 00                	push   $0x0
  80123d:	6a 00                	push   $0x0
  80123f:	ff 75 0c             	pushl  0xc(%ebp)
  801242:	ff 75 08             	pushl  0x8(%ebp)
  801245:	6a 12                	push   $0x12
  801247:	e8 17 fe ff ff       	call   801063 <syscall>
  80124c:	83 c4 18             	add    $0x18,%esp
	return ;
  80124f:	90                   	nop
}
  801250:	c9                   	leave  
  801251:	c3                   	ret    

00801252 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801252:	55                   	push   %ebp
  801253:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801255:	6a 00                	push   $0x0
  801257:	6a 00                	push   $0x0
  801259:	6a 00                	push   $0x0
  80125b:	6a 00                	push   $0x0
  80125d:	6a 00                	push   $0x0
  80125f:	6a 0e                	push   $0xe
  801261:	e8 fd fd ff ff       	call   801063 <syscall>
  801266:	83 c4 18             	add    $0x18,%esp
}
  801269:	c9                   	leave  
  80126a:	c3                   	ret    

0080126b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80126b:	55                   	push   %ebp
  80126c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80126e:	6a 00                	push   $0x0
  801270:	6a 00                	push   $0x0
  801272:	6a 00                	push   $0x0
  801274:	6a 00                	push   $0x0
  801276:	ff 75 08             	pushl  0x8(%ebp)
  801279:	6a 0f                	push   $0xf
  80127b:	e8 e3 fd ff ff       	call   801063 <syscall>
  801280:	83 c4 18             	add    $0x18,%esp
}
  801283:	c9                   	leave  
  801284:	c3                   	ret    

00801285 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801285:	55                   	push   %ebp
  801286:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801288:	6a 00                	push   $0x0
  80128a:	6a 00                	push   $0x0
  80128c:	6a 00                	push   $0x0
  80128e:	6a 00                	push   $0x0
  801290:	6a 00                	push   $0x0
  801292:	6a 10                	push   $0x10
  801294:	e8 ca fd ff ff       	call   801063 <syscall>
  801299:	83 c4 18             	add    $0x18,%esp
}
  80129c:	90                   	nop
  80129d:	c9                   	leave  
  80129e:	c3                   	ret    

0080129f <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80129f:	55                   	push   %ebp
  8012a0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8012a2:	6a 00                	push   $0x0
  8012a4:	6a 00                	push   $0x0
  8012a6:	6a 00                	push   $0x0
  8012a8:	6a 00                	push   $0x0
  8012aa:	6a 00                	push   $0x0
  8012ac:	6a 14                	push   $0x14
  8012ae:	e8 b0 fd ff ff       	call   801063 <syscall>
  8012b3:	83 c4 18             	add    $0x18,%esp
}
  8012b6:	90                   	nop
  8012b7:	c9                   	leave  
  8012b8:	c3                   	ret    

008012b9 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8012b9:	55                   	push   %ebp
  8012ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8012bc:	6a 00                	push   $0x0
  8012be:	6a 00                	push   $0x0
  8012c0:	6a 00                	push   $0x0
  8012c2:	6a 00                	push   $0x0
  8012c4:	6a 00                	push   $0x0
  8012c6:	6a 15                	push   $0x15
  8012c8:	e8 96 fd ff ff       	call   801063 <syscall>
  8012cd:	83 c4 18             	add    $0x18,%esp
}
  8012d0:	90                   	nop
  8012d1:	c9                   	leave  
  8012d2:	c3                   	ret    

008012d3 <sys_cputc>:


void
sys_cputc(const char c)
{
  8012d3:	55                   	push   %ebp
  8012d4:	89 e5                	mov    %esp,%ebp
  8012d6:	83 ec 04             	sub    $0x4,%esp
  8012d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8012df:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8012e3:	6a 00                	push   $0x0
  8012e5:	6a 00                	push   $0x0
  8012e7:	6a 00                	push   $0x0
  8012e9:	6a 00                	push   $0x0
  8012eb:	50                   	push   %eax
  8012ec:	6a 16                	push   $0x16
  8012ee:	e8 70 fd ff ff       	call   801063 <syscall>
  8012f3:	83 c4 18             	add    $0x18,%esp
}
  8012f6:	90                   	nop
  8012f7:	c9                   	leave  
  8012f8:	c3                   	ret    

008012f9 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012f9:	55                   	push   %ebp
  8012fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012fc:	6a 00                	push   $0x0
  8012fe:	6a 00                	push   $0x0
  801300:	6a 00                	push   $0x0
  801302:	6a 00                	push   $0x0
  801304:	6a 00                	push   $0x0
  801306:	6a 17                	push   $0x17
  801308:	e8 56 fd ff ff       	call   801063 <syscall>
  80130d:	83 c4 18             	add    $0x18,%esp
}
  801310:	90                   	nop
  801311:	c9                   	leave  
  801312:	c3                   	ret    

00801313 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801313:	55                   	push   %ebp
  801314:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801316:	8b 45 08             	mov    0x8(%ebp),%eax
  801319:	6a 00                	push   $0x0
  80131b:	6a 00                	push   $0x0
  80131d:	6a 00                	push   $0x0
  80131f:	ff 75 0c             	pushl  0xc(%ebp)
  801322:	50                   	push   %eax
  801323:	6a 18                	push   $0x18
  801325:	e8 39 fd ff ff       	call   801063 <syscall>
  80132a:	83 c4 18             	add    $0x18,%esp
}
  80132d:	c9                   	leave  
  80132e:	c3                   	ret    

0080132f <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80132f:	55                   	push   %ebp
  801330:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801332:	8b 55 0c             	mov    0xc(%ebp),%edx
  801335:	8b 45 08             	mov    0x8(%ebp),%eax
  801338:	6a 00                	push   $0x0
  80133a:	6a 00                	push   $0x0
  80133c:	6a 00                	push   $0x0
  80133e:	52                   	push   %edx
  80133f:	50                   	push   %eax
  801340:	6a 1b                	push   $0x1b
  801342:	e8 1c fd ff ff       	call   801063 <syscall>
  801347:	83 c4 18             	add    $0x18,%esp
}
  80134a:	c9                   	leave  
  80134b:	c3                   	ret    

0080134c <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80134c:	55                   	push   %ebp
  80134d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80134f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801352:	8b 45 08             	mov    0x8(%ebp),%eax
  801355:	6a 00                	push   $0x0
  801357:	6a 00                	push   $0x0
  801359:	6a 00                	push   $0x0
  80135b:	52                   	push   %edx
  80135c:	50                   	push   %eax
  80135d:	6a 19                	push   $0x19
  80135f:	e8 ff fc ff ff       	call   801063 <syscall>
  801364:	83 c4 18             	add    $0x18,%esp
}
  801367:	90                   	nop
  801368:	c9                   	leave  
  801369:	c3                   	ret    

0080136a <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80136a:	55                   	push   %ebp
  80136b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80136d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801370:	8b 45 08             	mov    0x8(%ebp),%eax
  801373:	6a 00                	push   $0x0
  801375:	6a 00                	push   $0x0
  801377:	6a 00                	push   $0x0
  801379:	52                   	push   %edx
  80137a:	50                   	push   %eax
  80137b:	6a 1a                	push   $0x1a
  80137d:	e8 e1 fc ff ff       	call   801063 <syscall>
  801382:	83 c4 18             	add    $0x18,%esp
}
  801385:	90                   	nop
  801386:	c9                   	leave  
  801387:	c3                   	ret    

00801388 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801388:	55                   	push   %ebp
  801389:	89 e5                	mov    %esp,%ebp
  80138b:	83 ec 04             	sub    $0x4,%esp
  80138e:	8b 45 10             	mov    0x10(%ebp),%eax
  801391:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801394:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801397:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80139b:	8b 45 08             	mov    0x8(%ebp),%eax
  80139e:	6a 00                	push   $0x0
  8013a0:	51                   	push   %ecx
  8013a1:	52                   	push   %edx
  8013a2:	ff 75 0c             	pushl  0xc(%ebp)
  8013a5:	50                   	push   %eax
  8013a6:	6a 1c                	push   $0x1c
  8013a8:	e8 b6 fc ff ff       	call   801063 <syscall>
  8013ad:	83 c4 18             	add    $0x18,%esp
}
  8013b0:	c9                   	leave  
  8013b1:	c3                   	ret    

008013b2 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8013b2:	55                   	push   %ebp
  8013b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8013b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bb:	6a 00                	push   $0x0
  8013bd:	6a 00                	push   $0x0
  8013bf:	6a 00                	push   $0x0
  8013c1:	52                   	push   %edx
  8013c2:	50                   	push   %eax
  8013c3:	6a 1d                	push   $0x1d
  8013c5:	e8 99 fc ff ff       	call   801063 <syscall>
  8013ca:	83 c4 18             	add    $0x18,%esp
}
  8013cd:	c9                   	leave  
  8013ce:	c3                   	ret    

008013cf <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8013cf:	55                   	push   %ebp
  8013d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8013d2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013db:	6a 00                	push   $0x0
  8013dd:	6a 00                	push   $0x0
  8013df:	51                   	push   %ecx
  8013e0:	52                   	push   %edx
  8013e1:	50                   	push   %eax
  8013e2:	6a 1e                	push   $0x1e
  8013e4:	e8 7a fc ff ff       	call   801063 <syscall>
  8013e9:	83 c4 18             	add    $0x18,%esp
}
  8013ec:	c9                   	leave  
  8013ed:	c3                   	ret    

008013ee <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013ee:	55                   	push   %ebp
  8013ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 00                	push   $0x0
  8013fb:	6a 00                	push   $0x0
  8013fd:	52                   	push   %edx
  8013fe:	50                   	push   %eax
  8013ff:	6a 1f                	push   $0x1f
  801401:	e8 5d fc ff ff       	call   801063 <syscall>
  801406:	83 c4 18             	add    $0x18,%esp
}
  801409:	c9                   	leave  
  80140a:	c3                   	ret    

0080140b <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80140b:	55                   	push   %ebp
  80140c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80140e:	6a 00                	push   $0x0
  801410:	6a 00                	push   $0x0
  801412:	6a 00                	push   $0x0
  801414:	6a 00                	push   $0x0
  801416:	6a 00                	push   $0x0
  801418:	6a 20                	push   $0x20
  80141a:	e8 44 fc ff ff       	call   801063 <syscall>
  80141f:	83 c4 18             	add    $0x18,%esp
}
  801422:	c9                   	leave  
  801423:	c3                   	ret    

00801424 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801424:	55                   	push   %ebp
  801425:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801427:	8b 45 08             	mov    0x8(%ebp),%eax
  80142a:	6a 00                	push   $0x0
  80142c:	ff 75 14             	pushl  0x14(%ebp)
  80142f:	ff 75 10             	pushl  0x10(%ebp)
  801432:	ff 75 0c             	pushl  0xc(%ebp)
  801435:	50                   	push   %eax
  801436:	6a 21                	push   $0x21
  801438:	e8 26 fc ff ff       	call   801063 <syscall>
  80143d:	83 c4 18             	add    $0x18,%esp
}
  801440:	c9                   	leave  
  801441:	c3                   	ret    

00801442 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801442:	55                   	push   %ebp
  801443:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801445:	8b 45 08             	mov    0x8(%ebp),%eax
  801448:	6a 00                	push   $0x0
  80144a:	6a 00                	push   $0x0
  80144c:	6a 00                	push   $0x0
  80144e:	6a 00                	push   $0x0
  801450:	50                   	push   %eax
  801451:	6a 22                	push   $0x22
  801453:	e8 0b fc ff ff       	call   801063 <syscall>
  801458:	83 c4 18             	add    $0x18,%esp
}
  80145b:	90                   	nop
  80145c:	c9                   	leave  
  80145d:	c3                   	ret    

0080145e <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80145e:	55                   	push   %ebp
  80145f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801461:	8b 45 08             	mov    0x8(%ebp),%eax
  801464:	6a 00                	push   $0x0
  801466:	6a 00                	push   $0x0
  801468:	6a 00                	push   $0x0
  80146a:	6a 00                	push   $0x0
  80146c:	50                   	push   %eax
  80146d:	6a 23                	push   $0x23
  80146f:	e8 ef fb ff ff       	call   801063 <syscall>
  801474:	83 c4 18             	add    $0x18,%esp
}
  801477:	90                   	nop
  801478:	c9                   	leave  
  801479:	c3                   	ret    

0080147a <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80147a:	55                   	push   %ebp
  80147b:	89 e5                	mov    %esp,%ebp
  80147d:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801480:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801483:	8d 50 04             	lea    0x4(%eax),%edx
  801486:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801489:	6a 00                	push   $0x0
  80148b:	6a 00                	push   $0x0
  80148d:	6a 00                	push   $0x0
  80148f:	52                   	push   %edx
  801490:	50                   	push   %eax
  801491:	6a 24                	push   $0x24
  801493:	e8 cb fb ff ff       	call   801063 <syscall>
  801498:	83 c4 18             	add    $0x18,%esp
	return result;
  80149b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80149e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014a1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014a4:	89 01                	mov    %eax,(%ecx)
  8014a6:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8014a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ac:	c9                   	leave  
  8014ad:	c2 04 00             	ret    $0x4

008014b0 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8014b0:	55                   	push   %ebp
  8014b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8014b3:	6a 00                	push   $0x0
  8014b5:	6a 00                	push   $0x0
  8014b7:	ff 75 10             	pushl  0x10(%ebp)
  8014ba:	ff 75 0c             	pushl  0xc(%ebp)
  8014bd:	ff 75 08             	pushl  0x8(%ebp)
  8014c0:	6a 13                	push   $0x13
  8014c2:	e8 9c fb ff ff       	call   801063 <syscall>
  8014c7:	83 c4 18             	add    $0x18,%esp
	return ;
  8014ca:	90                   	nop
}
  8014cb:	c9                   	leave  
  8014cc:	c3                   	ret    

008014cd <sys_rcr2>:
uint32 sys_rcr2()
{
  8014cd:	55                   	push   %ebp
  8014ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 00                	push   $0x0
  8014da:	6a 25                	push   $0x25
  8014dc:	e8 82 fb ff ff       	call   801063 <syscall>
  8014e1:	83 c4 18             	add    $0x18,%esp
}
  8014e4:	c9                   	leave  
  8014e5:	c3                   	ret    

008014e6 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8014e6:	55                   	push   %ebp
  8014e7:	89 e5                	mov    %esp,%ebp
  8014e9:	83 ec 04             	sub    $0x4,%esp
  8014ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ef:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014f2:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 00                	push   $0x0
  8014fe:	50                   	push   %eax
  8014ff:	6a 26                	push   $0x26
  801501:	e8 5d fb ff ff       	call   801063 <syscall>
  801506:	83 c4 18             	add    $0x18,%esp
	return ;
  801509:	90                   	nop
}
  80150a:	c9                   	leave  
  80150b:	c3                   	ret    

0080150c <rsttst>:
void rsttst()
{
  80150c:	55                   	push   %ebp
  80150d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80150f:	6a 00                	push   $0x0
  801511:	6a 00                	push   $0x0
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	6a 28                	push   $0x28
  80151b:	e8 43 fb ff ff       	call   801063 <syscall>
  801520:	83 c4 18             	add    $0x18,%esp
	return ;
  801523:	90                   	nop
}
  801524:	c9                   	leave  
  801525:	c3                   	ret    

00801526 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801526:	55                   	push   %ebp
  801527:	89 e5                	mov    %esp,%ebp
  801529:	83 ec 04             	sub    $0x4,%esp
  80152c:	8b 45 14             	mov    0x14(%ebp),%eax
  80152f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801532:	8b 55 18             	mov    0x18(%ebp),%edx
  801535:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801539:	52                   	push   %edx
  80153a:	50                   	push   %eax
  80153b:	ff 75 10             	pushl  0x10(%ebp)
  80153e:	ff 75 0c             	pushl  0xc(%ebp)
  801541:	ff 75 08             	pushl  0x8(%ebp)
  801544:	6a 27                	push   $0x27
  801546:	e8 18 fb ff ff       	call   801063 <syscall>
  80154b:	83 c4 18             	add    $0x18,%esp
	return ;
  80154e:	90                   	nop
}
  80154f:	c9                   	leave  
  801550:	c3                   	ret    

00801551 <chktst>:
void chktst(uint32 n)
{
  801551:	55                   	push   %ebp
  801552:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801554:	6a 00                	push   $0x0
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	ff 75 08             	pushl  0x8(%ebp)
  80155f:	6a 29                	push   $0x29
  801561:	e8 fd fa ff ff       	call   801063 <syscall>
  801566:	83 c4 18             	add    $0x18,%esp
	return ;
  801569:	90                   	nop
}
  80156a:	c9                   	leave  
  80156b:	c3                   	ret    

0080156c <inctst>:

void inctst()
{
  80156c:	55                   	push   %ebp
  80156d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80156f:	6a 00                	push   $0x0
  801571:	6a 00                	push   $0x0
  801573:	6a 00                	push   $0x0
  801575:	6a 00                	push   $0x0
  801577:	6a 00                	push   $0x0
  801579:	6a 2a                	push   $0x2a
  80157b:	e8 e3 fa ff ff       	call   801063 <syscall>
  801580:	83 c4 18             	add    $0x18,%esp
	return ;
  801583:	90                   	nop
}
  801584:	c9                   	leave  
  801585:	c3                   	ret    

00801586 <gettst>:
uint32 gettst()
{
  801586:	55                   	push   %ebp
  801587:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	6a 00                	push   $0x0
  801591:	6a 00                	push   $0x0
  801593:	6a 2b                	push   $0x2b
  801595:	e8 c9 fa ff ff       	call   801063 <syscall>
  80159a:	83 c4 18             	add    $0x18,%esp
}
  80159d:	c9                   	leave  
  80159e:	c3                   	ret    

0080159f <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80159f:	55                   	push   %ebp
  8015a0:	89 e5                	mov    %esp,%ebp
  8015a2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 2c                	push   $0x2c
  8015b1:	e8 ad fa ff ff       	call   801063 <syscall>
  8015b6:	83 c4 18             	add    $0x18,%esp
  8015b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8015bc:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8015c0:	75 07                	jne    8015c9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8015c2:	b8 01 00 00 00       	mov    $0x1,%eax
  8015c7:	eb 05                	jmp    8015ce <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8015c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015ce:	c9                   	leave  
  8015cf:	c3                   	ret    

008015d0 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8015d0:	55                   	push   %ebp
  8015d1:	89 e5                	mov    %esp,%ebp
  8015d3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015d6:	6a 00                	push   $0x0
  8015d8:	6a 00                	push   $0x0
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 2c                	push   $0x2c
  8015e2:	e8 7c fa ff ff       	call   801063 <syscall>
  8015e7:	83 c4 18             	add    $0x18,%esp
  8015ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015ed:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015f1:	75 07                	jne    8015fa <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015f3:	b8 01 00 00 00       	mov    $0x1,%eax
  8015f8:	eb 05                	jmp    8015ff <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015fa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015ff:	c9                   	leave  
  801600:	c3                   	ret    

00801601 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801601:	55                   	push   %ebp
  801602:	89 e5                	mov    %esp,%ebp
  801604:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801607:	6a 00                	push   $0x0
  801609:	6a 00                	push   $0x0
  80160b:	6a 00                	push   $0x0
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	6a 2c                	push   $0x2c
  801613:	e8 4b fa ff ff       	call   801063 <syscall>
  801618:	83 c4 18             	add    $0x18,%esp
  80161b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80161e:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801622:	75 07                	jne    80162b <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801624:	b8 01 00 00 00       	mov    $0x1,%eax
  801629:	eb 05                	jmp    801630 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80162b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801630:	c9                   	leave  
  801631:	c3                   	ret    

00801632 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801632:	55                   	push   %ebp
  801633:	89 e5                	mov    %esp,%ebp
  801635:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801638:	6a 00                	push   $0x0
  80163a:	6a 00                	push   $0x0
  80163c:	6a 00                	push   $0x0
  80163e:	6a 00                	push   $0x0
  801640:	6a 00                	push   $0x0
  801642:	6a 2c                	push   $0x2c
  801644:	e8 1a fa ff ff       	call   801063 <syscall>
  801649:	83 c4 18             	add    $0x18,%esp
  80164c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80164f:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801653:	75 07                	jne    80165c <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801655:	b8 01 00 00 00       	mov    $0x1,%eax
  80165a:	eb 05                	jmp    801661 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80165c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801661:	c9                   	leave  
  801662:	c3                   	ret    

00801663 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801663:	55                   	push   %ebp
  801664:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801666:	6a 00                	push   $0x0
  801668:	6a 00                	push   $0x0
  80166a:	6a 00                	push   $0x0
  80166c:	6a 00                	push   $0x0
  80166e:	ff 75 08             	pushl  0x8(%ebp)
  801671:	6a 2d                	push   $0x2d
  801673:	e8 eb f9 ff ff       	call   801063 <syscall>
  801678:	83 c4 18             	add    $0x18,%esp
	return ;
  80167b:	90                   	nop
}
  80167c:	c9                   	leave  
  80167d:	c3                   	ret    

0080167e <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80167e:	55                   	push   %ebp
  80167f:	89 e5                	mov    %esp,%ebp
  801681:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801682:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801685:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801688:	8b 55 0c             	mov    0xc(%ebp),%edx
  80168b:	8b 45 08             	mov    0x8(%ebp),%eax
  80168e:	6a 00                	push   $0x0
  801690:	53                   	push   %ebx
  801691:	51                   	push   %ecx
  801692:	52                   	push   %edx
  801693:	50                   	push   %eax
  801694:	6a 2e                	push   $0x2e
  801696:	e8 c8 f9 ff ff       	call   801063 <syscall>
  80169b:	83 c4 18             	add    $0x18,%esp
}
  80169e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8016a1:	c9                   	leave  
  8016a2:	c3                   	ret    

008016a3 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8016a3:	55                   	push   %ebp
  8016a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8016a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	6a 00                	push   $0x0
  8016b2:	52                   	push   %edx
  8016b3:	50                   	push   %eax
  8016b4:	6a 2f                	push   $0x2f
  8016b6:	e8 a8 f9 ff ff       	call   801063 <syscall>
  8016bb:	83 c4 18             	add    $0x18,%esp
}
  8016be:	c9                   	leave  
  8016bf:	c3                   	ret    

008016c0 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8016c0:	55                   	push   %ebp
  8016c1:	89 e5                	mov    %esp,%ebp
  8016c3:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8016c6:	8b 55 08             	mov    0x8(%ebp),%edx
  8016c9:	89 d0                	mov    %edx,%eax
  8016cb:	c1 e0 02             	shl    $0x2,%eax
  8016ce:	01 d0                	add    %edx,%eax
  8016d0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016d7:	01 d0                	add    %edx,%eax
  8016d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016e0:	01 d0                	add    %edx,%eax
  8016e2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016e9:	01 d0                	add    %edx,%eax
  8016eb:	c1 e0 04             	shl    $0x4,%eax
  8016ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8016f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8016f8:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8016fb:	83 ec 0c             	sub    $0xc,%esp
  8016fe:	50                   	push   %eax
  8016ff:	e8 76 fd ff ff       	call   80147a <sys_get_virtual_time>
  801704:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801707:	eb 41                	jmp    80174a <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801709:	8d 45 e0             	lea    -0x20(%ebp),%eax
  80170c:	83 ec 0c             	sub    $0xc,%esp
  80170f:	50                   	push   %eax
  801710:	e8 65 fd ff ff       	call   80147a <sys_get_virtual_time>
  801715:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801718:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80171b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80171e:	29 c2                	sub    %eax,%edx
  801720:	89 d0                	mov    %edx,%eax
  801722:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801725:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801728:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80172b:	89 d1                	mov    %edx,%ecx
  80172d:	29 c1                	sub    %eax,%ecx
  80172f:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801732:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801735:	39 c2                	cmp    %eax,%edx
  801737:	0f 97 c0             	seta   %al
  80173a:	0f b6 c0             	movzbl %al,%eax
  80173d:	29 c1                	sub    %eax,%ecx
  80173f:	89 c8                	mov    %ecx,%eax
  801741:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801744:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801747:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  80174a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80174d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801750:	72 b7                	jb     801709 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801752:	90                   	nop
  801753:	c9                   	leave  
  801754:	c3                   	ret    

00801755 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801755:	55                   	push   %ebp
  801756:	89 e5                	mov    %esp,%ebp
  801758:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80175b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801762:	eb 03                	jmp    801767 <busy_wait+0x12>
  801764:	ff 45 fc             	incl   -0x4(%ebp)
  801767:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80176a:	3b 45 08             	cmp    0x8(%ebp),%eax
  80176d:	72 f5                	jb     801764 <busy_wait+0xf>
	return i;
  80176f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801772:	c9                   	leave  
  801773:	c3                   	ret    

00801774 <__udivdi3>:
  801774:	55                   	push   %ebp
  801775:	57                   	push   %edi
  801776:	56                   	push   %esi
  801777:	53                   	push   %ebx
  801778:	83 ec 1c             	sub    $0x1c,%esp
  80177b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80177f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801783:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801787:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80178b:	89 ca                	mov    %ecx,%edx
  80178d:	89 f8                	mov    %edi,%eax
  80178f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801793:	85 f6                	test   %esi,%esi
  801795:	75 2d                	jne    8017c4 <__udivdi3+0x50>
  801797:	39 cf                	cmp    %ecx,%edi
  801799:	77 65                	ja     801800 <__udivdi3+0x8c>
  80179b:	89 fd                	mov    %edi,%ebp
  80179d:	85 ff                	test   %edi,%edi
  80179f:	75 0b                	jne    8017ac <__udivdi3+0x38>
  8017a1:	b8 01 00 00 00       	mov    $0x1,%eax
  8017a6:	31 d2                	xor    %edx,%edx
  8017a8:	f7 f7                	div    %edi
  8017aa:	89 c5                	mov    %eax,%ebp
  8017ac:	31 d2                	xor    %edx,%edx
  8017ae:	89 c8                	mov    %ecx,%eax
  8017b0:	f7 f5                	div    %ebp
  8017b2:	89 c1                	mov    %eax,%ecx
  8017b4:	89 d8                	mov    %ebx,%eax
  8017b6:	f7 f5                	div    %ebp
  8017b8:	89 cf                	mov    %ecx,%edi
  8017ba:	89 fa                	mov    %edi,%edx
  8017bc:	83 c4 1c             	add    $0x1c,%esp
  8017bf:	5b                   	pop    %ebx
  8017c0:	5e                   	pop    %esi
  8017c1:	5f                   	pop    %edi
  8017c2:	5d                   	pop    %ebp
  8017c3:	c3                   	ret    
  8017c4:	39 ce                	cmp    %ecx,%esi
  8017c6:	77 28                	ja     8017f0 <__udivdi3+0x7c>
  8017c8:	0f bd fe             	bsr    %esi,%edi
  8017cb:	83 f7 1f             	xor    $0x1f,%edi
  8017ce:	75 40                	jne    801810 <__udivdi3+0x9c>
  8017d0:	39 ce                	cmp    %ecx,%esi
  8017d2:	72 0a                	jb     8017de <__udivdi3+0x6a>
  8017d4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8017d8:	0f 87 9e 00 00 00    	ja     80187c <__udivdi3+0x108>
  8017de:	b8 01 00 00 00       	mov    $0x1,%eax
  8017e3:	89 fa                	mov    %edi,%edx
  8017e5:	83 c4 1c             	add    $0x1c,%esp
  8017e8:	5b                   	pop    %ebx
  8017e9:	5e                   	pop    %esi
  8017ea:	5f                   	pop    %edi
  8017eb:	5d                   	pop    %ebp
  8017ec:	c3                   	ret    
  8017ed:	8d 76 00             	lea    0x0(%esi),%esi
  8017f0:	31 ff                	xor    %edi,%edi
  8017f2:	31 c0                	xor    %eax,%eax
  8017f4:	89 fa                	mov    %edi,%edx
  8017f6:	83 c4 1c             	add    $0x1c,%esp
  8017f9:	5b                   	pop    %ebx
  8017fa:	5e                   	pop    %esi
  8017fb:	5f                   	pop    %edi
  8017fc:	5d                   	pop    %ebp
  8017fd:	c3                   	ret    
  8017fe:	66 90                	xchg   %ax,%ax
  801800:	89 d8                	mov    %ebx,%eax
  801802:	f7 f7                	div    %edi
  801804:	31 ff                	xor    %edi,%edi
  801806:	89 fa                	mov    %edi,%edx
  801808:	83 c4 1c             	add    $0x1c,%esp
  80180b:	5b                   	pop    %ebx
  80180c:	5e                   	pop    %esi
  80180d:	5f                   	pop    %edi
  80180e:	5d                   	pop    %ebp
  80180f:	c3                   	ret    
  801810:	bd 20 00 00 00       	mov    $0x20,%ebp
  801815:	89 eb                	mov    %ebp,%ebx
  801817:	29 fb                	sub    %edi,%ebx
  801819:	89 f9                	mov    %edi,%ecx
  80181b:	d3 e6                	shl    %cl,%esi
  80181d:	89 c5                	mov    %eax,%ebp
  80181f:	88 d9                	mov    %bl,%cl
  801821:	d3 ed                	shr    %cl,%ebp
  801823:	89 e9                	mov    %ebp,%ecx
  801825:	09 f1                	or     %esi,%ecx
  801827:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80182b:	89 f9                	mov    %edi,%ecx
  80182d:	d3 e0                	shl    %cl,%eax
  80182f:	89 c5                	mov    %eax,%ebp
  801831:	89 d6                	mov    %edx,%esi
  801833:	88 d9                	mov    %bl,%cl
  801835:	d3 ee                	shr    %cl,%esi
  801837:	89 f9                	mov    %edi,%ecx
  801839:	d3 e2                	shl    %cl,%edx
  80183b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80183f:	88 d9                	mov    %bl,%cl
  801841:	d3 e8                	shr    %cl,%eax
  801843:	09 c2                	or     %eax,%edx
  801845:	89 d0                	mov    %edx,%eax
  801847:	89 f2                	mov    %esi,%edx
  801849:	f7 74 24 0c          	divl   0xc(%esp)
  80184d:	89 d6                	mov    %edx,%esi
  80184f:	89 c3                	mov    %eax,%ebx
  801851:	f7 e5                	mul    %ebp
  801853:	39 d6                	cmp    %edx,%esi
  801855:	72 19                	jb     801870 <__udivdi3+0xfc>
  801857:	74 0b                	je     801864 <__udivdi3+0xf0>
  801859:	89 d8                	mov    %ebx,%eax
  80185b:	31 ff                	xor    %edi,%edi
  80185d:	e9 58 ff ff ff       	jmp    8017ba <__udivdi3+0x46>
  801862:	66 90                	xchg   %ax,%ax
  801864:	8b 54 24 08          	mov    0x8(%esp),%edx
  801868:	89 f9                	mov    %edi,%ecx
  80186a:	d3 e2                	shl    %cl,%edx
  80186c:	39 c2                	cmp    %eax,%edx
  80186e:	73 e9                	jae    801859 <__udivdi3+0xe5>
  801870:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801873:	31 ff                	xor    %edi,%edi
  801875:	e9 40 ff ff ff       	jmp    8017ba <__udivdi3+0x46>
  80187a:	66 90                	xchg   %ax,%ax
  80187c:	31 c0                	xor    %eax,%eax
  80187e:	e9 37 ff ff ff       	jmp    8017ba <__udivdi3+0x46>
  801883:	90                   	nop

00801884 <__umoddi3>:
  801884:	55                   	push   %ebp
  801885:	57                   	push   %edi
  801886:	56                   	push   %esi
  801887:	53                   	push   %ebx
  801888:	83 ec 1c             	sub    $0x1c,%esp
  80188b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80188f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801893:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801897:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80189b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80189f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8018a3:	89 f3                	mov    %esi,%ebx
  8018a5:	89 fa                	mov    %edi,%edx
  8018a7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018ab:	89 34 24             	mov    %esi,(%esp)
  8018ae:	85 c0                	test   %eax,%eax
  8018b0:	75 1a                	jne    8018cc <__umoddi3+0x48>
  8018b2:	39 f7                	cmp    %esi,%edi
  8018b4:	0f 86 a2 00 00 00    	jbe    80195c <__umoddi3+0xd8>
  8018ba:	89 c8                	mov    %ecx,%eax
  8018bc:	89 f2                	mov    %esi,%edx
  8018be:	f7 f7                	div    %edi
  8018c0:	89 d0                	mov    %edx,%eax
  8018c2:	31 d2                	xor    %edx,%edx
  8018c4:	83 c4 1c             	add    $0x1c,%esp
  8018c7:	5b                   	pop    %ebx
  8018c8:	5e                   	pop    %esi
  8018c9:	5f                   	pop    %edi
  8018ca:	5d                   	pop    %ebp
  8018cb:	c3                   	ret    
  8018cc:	39 f0                	cmp    %esi,%eax
  8018ce:	0f 87 ac 00 00 00    	ja     801980 <__umoddi3+0xfc>
  8018d4:	0f bd e8             	bsr    %eax,%ebp
  8018d7:	83 f5 1f             	xor    $0x1f,%ebp
  8018da:	0f 84 ac 00 00 00    	je     80198c <__umoddi3+0x108>
  8018e0:	bf 20 00 00 00       	mov    $0x20,%edi
  8018e5:	29 ef                	sub    %ebp,%edi
  8018e7:	89 fe                	mov    %edi,%esi
  8018e9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8018ed:	89 e9                	mov    %ebp,%ecx
  8018ef:	d3 e0                	shl    %cl,%eax
  8018f1:	89 d7                	mov    %edx,%edi
  8018f3:	89 f1                	mov    %esi,%ecx
  8018f5:	d3 ef                	shr    %cl,%edi
  8018f7:	09 c7                	or     %eax,%edi
  8018f9:	89 e9                	mov    %ebp,%ecx
  8018fb:	d3 e2                	shl    %cl,%edx
  8018fd:	89 14 24             	mov    %edx,(%esp)
  801900:	89 d8                	mov    %ebx,%eax
  801902:	d3 e0                	shl    %cl,%eax
  801904:	89 c2                	mov    %eax,%edx
  801906:	8b 44 24 08          	mov    0x8(%esp),%eax
  80190a:	d3 e0                	shl    %cl,%eax
  80190c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801910:	8b 44 24 08          	mov    0x8(%esp),%eax
  801914:	89 f1                	mov    %esi,%ecx
  801916:	d3 e8                	shr    %cl,%eax
  801918:	09 d0                	or     %edx,%eax
  80191a:	d3 eb                	shr    %cl,%ebx
  80191c:	89 da                	mov    %ebx,%edx
  80191e:	f7 f7                	div    %edi
  801920:	89 d3                	mov    %edx,%ebx
  801922:	f7 24 24             	mull   (%esp)
  801925:	89 c6                	mov    %eax,%esi
  801927:	89 d1                	mov    %edx,%ecx
  801929:	39 d3                	cmp    %edx,%ebx
  80192b:	0f 82 87 00 00 00    	jb     8019b8 <__umoddi3+0x134>
  801931:	0f 84 91 00 00 00    	je     8019c8 <__umoddi3+0x144>
  801937:	8b 54 24 04          	mov    0x4(%esp),%edx
  80193b:	29 f2                	sub    %esi,%edx
  80193d:	19 cb                	sbb    %ecx,%ebx
  80193f:	89 d8                	mov    %ebx,%eax
  801941:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801945:	d3 e0                	shl    %cl,%eax
  801947:	89 e9                	mov    %ebp,%ecx
  801949:	d3 ea                	shr    %cl,%edx
  80194b:	09 d0                	or     %edx,%eax
  80194d:	89 e9                	mov    %ebp,%ecx
  80194f:	d3 eb                	shr    %cl,%ebx
  801951:	89 da                	mov    %ebx,%edx
  801953:	83 c4 1c             	add    $0x1c,%esp
  801956:	5b                   	pop    %ebx
  801957:	5e                   	pop    %esi
  801958:	5f                   	pop    %edi
  801959:	5d                   	pop    %ebp
  80195a:	c3                   	ret    
  80195b:	90                   	nop
  80195c:	89 fd                	mov    %edi,%ebp
  80195e:	85 ff                	test   %edi,%edi
  801960:	75 0b                	jne    80196d <__umoddi3+0xe9>
  801962:	b8 01 00 00 00       	mov    $0x1,%eax
  801967:	31 d2                	xor    %edx,%edx
  801969:	f7 f7                	div    %edi
  80196b:	89 c5                	mov    %eax,%ebp
  80196d:	89 f0                	mov    %esi,%eax
  80196f:	31 d2                	xor    %edx,%edx
  801971:	f7 f5                	div    %ebp
  801973:	89 c8                	mov    %ecx,%eax
  801975:	f7 f5                	div    %ebp
  801977:	89 d0                	mov    %edx,%eax
  801979:	e9 44 ff ff ff       	jmp    8018c2 <__umoddi3+0x3e>
  80197e:	66 90                	xchg   %ax,%ax
  801980:	89 c8                	mov    %ecx,%eax
  801982:	89 f2                	mov    %esi,%edx
  801984:	83 c4 1c             	add    $0x1c,%esp
  801987:	5b                   	pop    %ebx
  801988:	5e                   	pop    %esi
  801989:	5f                   	pop    %edi
  80198a:	5d                   	pop    %ebp
  80198b:	c3                   	ret    
  80198c:	3b 04 24             	cmp    (%esp),%eax
  80198f:	72 06                	jb     801997 <__umoddi3+0x113>
  801991:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801995:	77 0f                	ja     8019a6 <__umoddi3+0x122>
  801997:	89 f2                	mov    %esi,%edx
  801999:	29 f9                	sub    %edi,%ecx
  80199b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80199f:	89 14 24             	mov    %edx,(%esp)
  8019a2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8019a6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8019aa:	8b 14 24             	mov    (%esp),%edx
  8019ad:	83 c4 1c             	add    $0x1c,%esp
  8019b0:	5b                   	pop    %ebx
  8019b1:	5e                   	pop    %esi
  8019b2:	5f                   	pop    %edi
  8019b3:	5d                   	pop    %ebp
  8019b4:	c3                   	ret    
  8019b5:	8d 76 00             	lea    0x0(%esi),%esi
  8019b8:	2b 04 24             	sub    (%esp),%eax
  8019bb:	19 fa                	sbb    %edi,%edx
  8019bd:	89 d1                	mov    %edx,%ecx
  8019bf:	89 c6                	mov    %eax,%esi
  8019c1:	e9 71 ff ff ff       	jmp    801937 <__umoddi3+0xb3>
  8019c6:	66 90                	xchg   %ax,%ax
  8019c8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8019cc:	72 ea                	jb     8019b8 <__umoddi3+0x134>
  8019ce:	89 d9                	mov    %ebx,%ecx
  8019d0:	e9 62 ff ff ff       	jmp    801937 <__umoddi3+0xb3>
