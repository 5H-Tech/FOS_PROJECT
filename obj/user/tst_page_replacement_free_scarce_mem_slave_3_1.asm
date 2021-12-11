
obj/user/tst_page_replacement_free_scarce_mem_slave_3_1:     file format elf32-i386


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
  800031:	e8 bc 00 00 00       	call   8000f2 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	int ID;
	for (int i = 0; i < 3; ++i) {
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800045:	eb 44                	jmp    80008b <_main+0x53>
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  800047:	a1 20 20 80 00       	mov    0x802020,%eax
  80004c:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  800052:	a1 20 20 80 00       	mov    0x802020,%eax
  800057:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80005d:	89 c1                	mov    %eax,%ecx
  80005f:	a1 20 20 80 00       	mov    0x802020,%eax
  800064:	8b 40 74             	mov    0x74(%eax),%eax
  800067:	52                   	push   %edx
  800068:	51                   	push   %ecx
  800069:	50                   	push   %eax
  80006a:	68 20 1a 80 00       	push   $0x801a20
  80006f:	e8 e2 13 00 00       	call   801456 <sys_create_env>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 f0             	mov    %eax,-0x10(%ebp)
		sys_run_env(ID);
  80007a:	83 ec 0c             	sub    $0xc,%esp
  80007d:	ff 75 f0             	pushl  -0x10(%ebp)
  800080:	e8 ef 13 00 00       	call   801474 <sys_run_env>
  800085:	83 c4 10             	add    $0x10,%esp
#include <inc/lib.h>

void _main(void)
{
	int ID;
	for (int i = 0; i < 3; ++i) {
  800088:	ff 45 f4             	incl   -0xc(%ebp)
  80008b:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
  80008f:	7e b6                	jle    800047 <_main+0xf>
		ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
		sys_run_env(ID);
	}
	env_sleep(50);
  800091:	83 ec 0c             	sub    $0xc,%esp
  800094:	6a 32                	push   $0x32
  800096:	e8 57 16 00 00       	call   8016f2 <env_sleep>
  80009b:	83 c4 10             	add    $0x10,%esp

	ID = sys_create_env("scarceMem3Slave_2", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  80009e:	a1 20 20 80 00       	mov    0x802020,%eax
  8000a3:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8000a9:	a1 20 20 80 00       	mov    0x802020,%eax
  8000ae:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000b4:	89 c1                	mov    %eax,%ecx
  8000b6:	a1 20 20 80 00       	mov    0x802020,%eax
  8000bb:	8b 40 74             	mov    0x74(%eax),%eax
  8000be:	52                   	push   %edx
  8000bf:	51                   	push   %ecx
  8000c0:	50                   	push   %eax
  8000c1:	68 2e 1a 80 00       	push   $0x801a2e
  8000c6:	e8 8b 13 00 00       	call   801456 <sys_create_env>
  8000cb:	83 c4 10             	add    $0x10,%esp
  8000ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
	sys_run_env(ID);
  8000d1:	83 ec 0c             	sub    $0xc,%esp
  8000d4:	ff 75 f0             	pushl  -0x10(%ebp)
  8000d7:	e8 98 13 00 00       	call   801474 <sys_run_env>
  8000dc:	83 c4 10             	add    $0x10,%esp

	env_sleep(5000);
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	68 88 13 00 00       	push   $0x1388
  8000e7:	e8 06 16 00 00       	call   8016f2 <env_sleep>
  8000ec:	83 c4 10             	add    $0x10,%esp

	return;
  8000ef:	90                   	nop
}
  8000f0:	c9                   	leave  
  8000f1:	c3                   	ret    

008000f2 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000f2:	55                   	push   %ebp
  8000f3:	89 e5                	mov    %esp,%ebp
  8000f5:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000f8:	e8 39 10 00 00       	call   801136 <sys_getenvindex>
  8000fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800100:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800103:	89 d0                	mov    %edx,%eax
  800105:	c1 e0 03             	shl    $0x3,%eax
  800108:	01 d0                	add    %edx,%eax
  80010a:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800111:	01 c8                	add    %ecx,%eax
  800113:	01 c0                	add    %eax,%eax
  800115:	01 d0                	add    %edx,%eax
  800117:	01 c0                	add    %eax,%eax
  800119:	01 d0                	add    %edx,%eax
  80011b:	89 c2                	mov    %eax,%edx
  80011d:	c1 e2 05             	shl    $0x5,%edx
  800120:	29 c2                	sub    %eax,%edx
  800122:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800129:	89 c2                	mov    %eax,%edx
  80012b:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800131:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800136:	a1 20 20 80 00       	mov    0x802020,%eax
  80013b:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800141:	84 c0                	test   %al,%al
  800143:	74 0f                	je     800154 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800145:	a1 20 20 80 00       	mov    0x802020,%eax
  80014a:	05 40 3c 01 00       	add    $0x13c40,%eax
  80014f:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800154:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800158:	7e 0a                	jle    800164 <libmain+0x72>
		binaryname = argv[0];
  80015a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80015d:	8b 00                	mov    (%eax),%eax
  80015f:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  800164:	83 ec 08             	sub    $0x8,%esp
  800167:	ff 75 0c             	pushl  0xc(%ebp)
  80016a:	ff 75 08             	pushl  0x8(%ebp)
  80016d:	e8 c6 fe ff ff       	call   800038 <_main>
  800172:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800175:	e8 57 11 00 00       	call   8012d1 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80017a:	83 ec 0c             	sub    $0xc,%esp
  80017d:	68 58 1a 80 00       	push   $0x801a58
  800182:	e8 84 01 00 00       	call   80030b <cprintf>
  800187:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80018a:	a1 20 20 80 00       	mov    0x802020,%eax
  80018f:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800195:	a1 20 20 80 00       	mov    0x802020,%eax
  80019a:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8001a0:	83 ec 04             	sub    $0x4,%esp
  8001a3:	52                   	push   %edx
  8001a4:	50                   	push   %eax
  8001a5:	68 80 1a 80 00       	push   $0x801a80
  8001aa:	e8 5c 01 00 00       	call   80030b <cprintf>
  8001af:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8001b2:	a1 20 20 80 00       	mov    0x802020,%eax
  8001b7:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8001bd:	a1 20 20 80 00       	mov    0x802020,%eax
  8001c2:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8001c8:	83 ec 04             	sub    $0x4,%esp
  8001cb:	52                   	push   %edx
  8001cc:	50                   	push   %eax
  8001cd:	68 a8 1a 80 00       	push   $0x801aa8
  8001d2:	e8 34 01 00 00       	call   80030b <cprintf>
  8001d7:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8001da:	a1 20 20 80 00       	mov    0x802020,%eax
  8001df:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8001e5:	83 ec 08             	sub    $0x8,%esp
  8001e8:	50                   	push   %eax
  8001e9:	68 e9 1a 80 00       	push   $0x801ae9
  8001ee:	e8 18 01 00 00       	call   80030b <cprintf>
  8001f3:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8001f6:	83 ec 0c             	sub    $0xc,%esp
  8001f9:	68 58 1a 80 00       	push   $0x801a58
  8001fe:	e8 08 01 00 00       	call   80030b <cprintf>
  800203:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800206:	e8 e0 10 00 00       	call   8012eb <sys_enable_interrupt>

	// exit gracefully
	exit();
  80020b:	e8 19 00 00 00       	call   800229 <exit>
}
  800210:	90                   	nop
  800211:	c9                   	leave  
  800212:	c3                   	ret    

00800213 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800213:	55                   	push   %ebp
  800214:	89 e5                	mov    %esp,%ebp
  800216:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800219:	83 ec 0c             	sub    $0xc,%esp
  80021c:	6a 00                	push   $0x0
  80021e:	e8 df 0e 00 00       	call   801102 <sys_env_destroy>
  800223:	83 c4 10             	add    $0x10,%esp
}
  800226:	90                   	nop
  800227:	c9                   	leave  
  800228:	c3                   	ret    

00800229 <exit>:

void
exit(void)
{
  800229:	55                   	push   %ebp
  80022a:	89 e5                	mov    %esp,%ebp
  80022c:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80022f:	e8 34 0f 00 00       	call   801168 <sys_env_exit>
}
  800234:	90                   	nop
  800235:	c9                   	leave  
  800236:	c3                   	ret    

00800237 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800237:	55                   	push   %ebp
  800238:	89 e5                	mov    %esp,%ebp
  80023a:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80023d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800240:	8b 00                	mov    (%eax),%eax
  800242:	8d 48 01             	lea    0x1(%eax),%ecx
  800245:	8b 55 0c             	mov    0xc(%ebp),%edx
  800248:	89 0a                	mov    %ecx,(%edx)
  80024a:	8b 55 08             	mov    0x8(%ebp),%edx
  80024d:	88 d1                	mov    %dl,%cl
  80024f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800252:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800256:	8b 45 0c             	mov    0xc(%ebp),%eax
  800259:	8b 00                	mov    (%eax),%eax
  80025b:	3d ff 00 00 00       	cmp    $0xff,%eax
  800260:	75 2c                	jne    80028e <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800262:	a0 24 20 80 00       	mov    0x802024,%al
  800267:	0f b6 c0             	movzbl %al,%eax
  80026a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80026d:	8b 12                	mov    (%edx),%edx
  80026f:	89 d1                	mov    %edx,%ecx
  800271:	8b 55 0c             	mov    0xc(%ebp),%edx
  800274:	83 c2 08             	add    $0x8,%edx
  800277:	83 ec 04             	sub    $0x4,%esp
  80027a:	50                   	push   %eax
  80027b:	51                   	push   %ecx
  80027c:	52                   	push   %edx
  80027d:	e8 3e 0e 00 00       	call   8010c0 <sys_cputs>
  800282:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800285:	8b 45 0c             	mov    0xc(%ebp),%eax
  800288:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80028e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800291:	8b 40 04             	mov    0x4(%eax),%eax
  800294:	8d 50 01             	lea    0x1(%eax),%edx
  800297:	8b 45 0c             	mov    0xc(%ebp),%eax
  80029a:	89 50 04             	mov    %edx,0x4(%eax)
}
  80029d:	90                   	nop
  80029e:	c9                   	leave  
  80029f:	c3                   	ret    

008002a0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8002a0:	55                   	push   %ebp
  8002a1:	89 e5                	mov    %esp,%ebp
  8002a3:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8002a9:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8002b0:	00 00 00 
	b.cnt = 0;
  8002b3:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8002ba:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8002bd:	ff 75 0c             	pushl  0xc(%ebp)
  8002c0:	ff 75 08             	pushl  0x8(%ebp)
  8002c3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002c9:	50                   	push   %eax
  8002ca:	68 37 02 80 00       	push   $0x800237
  8002cf:	e8 11 02 00 00       	call   8004e5 <vprintfmt>
  8002d4:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8002d7:	a0 24 20 80 00       	mov    0x802024,%al
  8002dc:	0f b6 c0             	movzbl %al,%eax
  8002df:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002e5:	83 ec 04             	sub    $0x4,%esp
  8002e8:	50                   	push   %eax
  8002e9:	52                   	push   %edx
  8002ea:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002f0:	83 c0 08             	add    $0x8,%eax
  8002f3:	50                   	push   %eax
  8002f4:	e8 c7 0d 00 00       	call   8010c0 <sys_cputs>
  8002f9:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002fc:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  800303:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800309:	c9                   	leave  
  80030a:	c3                   	ret    

0080030b <cprintf>:

int cprintf(const char *fmt, ...) {
  80030b:	55                   	push   %ebp
  80030c:	89 e5                	mov    %esp,%ebp
  80030e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800311:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  800318:	8d 45 0c             	lea    0xc(%ebp),%eax
  80031b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80031e:	8b 45 08             	mov    0x8(%ebp),%eax
  800321:	83 ec 08             	sub    $0x8,%esp
  800324:	ff 75 f4             	pushl  -0xc(%ebp)
  800327:	50                   	push   %eax
  800328:	e8 73 ff ff ff       	call   8002a0 <vcprintf>
  80032d:	83 c4 10             	add    $0x10,%esp
  800330:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800333:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800336:	c9                   	leave  
  800337:	c3                   	ret    

00800338 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800338:	55                   	push   %ebp
  800339:	89 e5                	mov    %esp,%ebp
  80033b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80033e:	e8 8e 0f 00 00       	call   8012d1 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800343:	8d 45 0c             	lea    0xc(%ebp),%eax
  800346:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800349:	8b 45 08             	mov    0x8(%ebp),%eax
  80034c:	83 ec 08             	sub    $0x8,%esp
  80034f:	ff 75 f4             	pushl  -0xc(%ebp)
  800352:	50                   	push   %eax
  800353:	e8 48 ff ff ff       	call   8002a0 <vcprintf>
  800358:	83 c4 10             	add    $0x10,%esp
  80035b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80035e:	e8 88 0f 00 00       	call   8012eb <sys_enable_interrupt>
	return cnt;
  800363:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800366:	c9                   	leave  
  800367:	c3                   	ret    

00800368 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800368:	55                   	push   %ebp
  800369:	89 e5                	mov    %esp,%ebp
  80036b:	53                   	push   %ebx
  80036c:	83 ec 14             	sub    $0x14,%esp
  80036f:	8b 45 10             	mov    0x10(%ebp),%eax
  800372:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800375:	8b 45 14             	mov    0x14(%ebp),%eax
  800378:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80037b:	8b 45 18             	mov    0x18(%ebp),%eax
  80037e:	ba 00 00 00 00       	mov    $0x0,%edx
  800383:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800386:	77 55                	ja     8003dd <printnum+0x75>
  800388:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80038b:	72 05                	jb     800392 <printnum+0x2a>
  80038d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800390:	77 4b                	ja     8003dd <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800392:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800395:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800398:	8b 45 18             	mov    0x18(%ebp),%eax
  80039b:	ba 00 00 00 00       	mov    $0x0,%edx
  8003a0:	52                   	push   %edx
  8003a1:	50                   	push   %eax
  8003a2:	ff 75 f4             	pushl  -0xc(%ebp)
  8003a5:	ff 75 f0             	pushl  -0x10(%ebp)
  8003a8:	e8 fb 13 00 00       	call   8017a8 <__udivdi3>
  8003ad:	83 c4 10             	add    $0x10,%esp
  8003b0:	83 ec 04             	sub    $0x4,%esp
  8003b3:	ff 75 20             	pushl  0x20(%ebp)
  8003b6:	53                   	push   %ebx
  8003b7:	ff 75 18             	pushl  0x18(%ebp)
  8003ba:	52                   	push   %edx
  8003bb:	50                   	push   %eax
  8003bc:	ff 75 0c             	pushl  0xc(%ebp)
  8003bf:	ff 75 08             	pushl  0x8(%ebp)
  8003c2:	e8 a1 ff ff ff       	call   800368 <printnum>
  8003c7:	83 c4 20             	add    $0x20,%esp
  8003ca:	eb 1a                	jmp    8003e6 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8003cc:	83 ec 08             	sub    $0x8,%esp
  8003cf:	ff 75 0c             	pushl  0xc(%ebp)
  8003d2:	ff 75 20             	pushl  0x20(%ebp)
  8003d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d8:	ff d0                	call   *%eax
  8003da:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003dd:	ff 4d 1c             	decl   0x1c(%ebp)
  8003e0:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003e4:	7f e6                	jg     8003cc <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003e6:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003e9:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003f4:	53                   	push   %ebx
  8003f5:	51                   	push   %ecx
  8003f6:	52                   	push   %edx
  8003f7:	50                   	push   %eax
  8003f8:	e8 bb 14 00 00       	call   8018b8 <__umoddi3>
  8003fd:	83 c4 10             	add    $0x10,%esp
  800400:	05 14 1d 80 00       	add    $0x801d14,%eax
  800405:	8a 00                	mov    (%eax),%al
  800407:	0f be c0             	movsbl %al,%eax
  80040a:	83 ec 08             	sub    $0x8,%esp
  80040d:	ff 75 0c             	pushl  0xc(%ebp)
  800410:	50                   	push   %eax
  800411:	8b 45 08             	mov    0x8(%ebp),%eax
  800414:	ff d0                	call   *%eax
  800416:	83 c4 10             	add    $0x10,%esp
}
  800419:	90                   	nop
  80041a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80041d:	c9                   	leave  
  80041e:	c3                   	ret    

0080041f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80041f:	55                   	push   %ebp
  800420:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800422:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800426:	7e 1c                	jle    800444 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800428:	8b 45 08             	mov    0x8(%ebp),%eax
  80042b:	8b 00                	mov    (%eax),%eax
  80042d:	8d 50 08             	lea    0x8(%eax),%edx
  800430:	8b 45 08             	mov    0x8(%ebp),%eax
  800433:	89 10                	mov    %edx,(%eax)
  800435:	8b 45 08             	mov    0x8(%ebp),%eax
  800438:	8b 00                	mov    (%eax),%eax
  80043a:	83 e8 08             	sub    $0x8,%eax
  80043d:	8b 50 04             	mov    0x4(%eax),%edx
  800440:	8b 00                	mov    (%eax),%eax
  800442:	eb 40                	jmp    800484 <getuint+0x65>
	else if (lflag)
  800444:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800448:	74 1e                	je     800468 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80044a:	8b 45 08             	mov    0x8(%ebp),%eax
  80044d:	8b 00                	mov    (%eax),%eax
  80044f:	8d 50 04             	lea    0x4(%eax),%edx
  800452:	8b 45 08             	mov    0x8(%ebp),%eax
  800455:	89 10                	mov    %edx,(%eax)
  800457:	8b 45 08             	mov    0x8(%ebp),%eax
  80045a:	8b 00                	mov    (%eax),%eax
  80045c:	83 e8 04             	sub    $0x4,%eax
  80045f:	8b 00                	mov    (%eax),%eax
  800461:	ba 00 00 00 00       	mov    $0x0,%edx
  800466:	eb 1c                	jmp    800484 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800468:	8b 45 08             	mov    0x8(%ebp),%eax
  80046b:	8b 00                	mov    (%eax),%eax
  80046d:	8d 50 04             	lea    0x4(%eax),%edx
  800470:	8b 45 08             	mov    0x8(%ebp),%eax
  800473:	89 10                	mov    %edx,(%eax)
  800475:	8b 45 08             	mov    0x8(%ebp),%eax
  800478:	8b 00                	mov    (%eax),%eax
  80047a:	83 e8 04             	sub    $0x4,%eax
  80047d:	8b 00                	mov    (%eax),%eax
  80047f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800484:	5d                   	pop    %ebp
  800485:	c3                   	ret    

00800486 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800486:	55                   	push   %ebp
  800487:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800489:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80048d:	7e 1c                	jle    8004ab <getint+0x25>
		return va_arg(*ap, long long);
  80048f:	8b 45 08             	mov    0x8(%ebp),%eax
  800492:	8b 00                	mov    (%eax),%eax
  800494:	8d 50 08             	lea    0x8(%eax),%edx
  800497:	8b 45 08             	mov    0x8(%ebp),%eax
  80049a:	89 10                	mov    %edx,(%eax)
  80049c:	8b 45 08             	mov    0x8(%ebp),%eax
  80049f:	8b 00                	mov    (%eax),%eax
  8004a1:	83 e8 08             	sub    $0x8,%eax
  8004a4:	8b 50 04             	mov    0x4(%eax),%edx
  8004a7:	8b 00                	mov    (%eax),%eax
  8004a9:	eb 38                	jmp    8004e3 <getint+0x5d>
	else if (lflag)
  8004ab:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004af:	74 1a                	je     8004cb <getint+0x45>
		return va_arg(*ap, long);
  8004b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b4:	8b 00                	mov    (%eax),%eax
  8004b6:	8d 50 04             	lea    0x4(%eax),%edx
  8004b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004bc:	89 10                	mov    %edx,(%eax)
  8004be:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c1:	8b 00                	mov    (%eax),%eax
  8004c3:	83 e8 04             	sub    $0x4,%eax
  8004c6:	8b 00                	mov    (%eax),%eax
  8004c8:	99                   	cltd   
  8004c9:	eb 18                	jmp    8004e3 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8004cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ce:	8b 00                	mov    (%eax),%eax
  8004d0:	8d 50 04             	lea    0x4(%eax),%edx
  8004d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d6:	89 10                	mov    %edx,(%eax)
  8004d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004db:	8b 00                	mov    (%eax),%eax
  8004dd:	83 e8 04             	sub    $0x4,%eax
  8004e0:	8b 00                	mov    (%eax),%eax
  8004e2:	99                   	cltd   
}
  8004e3:	5d                   	pop    %ebp
  8004e4:	c3                   	ret    

008004e5 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004e5:	55                   	push   %ebp
  8004e6:	89 e5                	mov    %esp,%ebp
  8004e8:	56                   	push   %esi
  8004e9:	53                   	push   %ebx
  8004ea:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004ed:	eb 17                	jmp    800506 <vprintfmt+0x21>
			if (ch == '\0')
  8004ef:	85 db                	test   %ebx,%ebx
  8004f1:	0f 84 af 03 00 00    	je     8008a6 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004f7:	83 ec 08             	sub    $0x8,%esp
  8004fa:	ff 75 0c             	pushl  0xc(%ebp)
  8004fd:	53                   	push   %ebx
  8004fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800501:	ff d0                	call   *%eax
  800503:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800506:	8b 45 10             	mov    0x10(%ebp),%eax
  800509:	8d 50 01             	lea    0x1(%eax),%edx
  80050c:	89 55 10             	mov    %edx,0x10(%ebp)
  80050f:	8a 00                	mov    (%eax),%al
  800511:	0f b6 d8             	movzbl %al,%ebx
  800514:	83 fb 25             	cmp    $0x25,%ebx
  800517:	75 d6                	jne    8004ef <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800519:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80051d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800524:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80052b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800532:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800539:	8b 45 10             	mov    0x10(%ebp),%eax
  80053c:	8d 50 01             	lea    0x1(%eax),%edx
  80053f:	89 55 10             	mov    %edx,0x10(%ebp)
  800542:	8a 00                	mov    (%eax),%al
  800544:	0f b6 d8             	movzbl %al,%ebx
  800547:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80054a:	83 f8 55             	cmp    $0x55,%eax
  80054d:	0f 87 2b 03 00 00    	ja     80087e <vprintfmt+0x399>
  800553:	8b 04 85 38 1d 80 00 	mov    0x801d38(,%eax,4),%eax
  80055a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80055c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800560:	eb d7                	jmp    800539 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800562:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800566:	eb d1                	jmp    800539 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800568:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80056f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800572:	89 d0                	mov    %edx,%eax
  800574:	c1 e0 02             	shl    $0x2,%eax
  800577:	01 d0                	add    %edx,%eax
  800579:	01 c0                	add    %eax,%eax
  80057b:	01 d8                	add    %ebx,%eax
  80057d:	83 e8 30             	sub    $0x30,%eax
  800580:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800583:	8b 45 10             	mov    0x10(%ebp),%eax
  800586:	8a 00                	mov    (%eax),%al
  800588:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80058b:	83 fb 2f             	cmp    $0x2f,%ebx
  80058e:	7e 3e                	jle    8005ce <vprintfmt+0xe9>
  800590:	83 fb 39             	cmp    $0x39,%ebx
  800593:	7f 39                	jg     8005ce <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800595:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800598:	eb d5                	jmp    80056f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80059a:	8b 45 14             	mov    0x14(%ebp),%eax
  80059d:	83 c0 04             	add    $0x4,%eax
  8005a0:	89 45 14             	mov    %eax,0x14(%ebp)
  8005a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a6:	83 e8 04             	sub    $0x4,%eax
  8005a9:	8b 00                	mov    (%eax),%eax
  8005ab:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8005ae:	eb 1f                	jmp    8005cf <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8005b0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005b4:	79 83                	jns    800539 <vprintfmt+0x54>
				width = 0;
  8005b6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8005bd:	e9 77 ff ff ff       	jmp    800539 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8005c2:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8005c9:	e9 6b ff ff ff       	jmp    800539 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8005ce:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8005cf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005d3:	0f 89 60 ff ff ff    	jns    800539 <vprintfmt+0x54>
				width = precision, precision = -1;
  8005d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005df:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005e6:	e9 4e ff ff ff       	jmp    800539 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005eb:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005ee:	e9 46 ff ff ff       	jmp    800539 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8005f6:	83 c0 04             	add    $0x4,%eax
  8005f9:	89 45 14             	mov    %eax,0x14(%ebp)
  8005fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ff:	83 e8 04             	sub    $0x4,%eax
  800602:	8b 00                	mov    (%eax),%eax
  800604:	83 ec 08             	sub    $0x8,%esp
  800607:	ff 75 0c             	pushl  0xc(%ebp)
  80060a:	50                   	push   %eax
  80060b:	8b 45 08             	mov    0x8(%ebp),%eax
  80060e:	ff d0                	call   *%eax
  800610:	83 c4 10             	add    $0x10,%esp
			break;
  800613:	e9 89 02 00 00       	jmp    8008a1 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800618:	8b 45 14             	mov    0x14(%ebp),%eax
  80061b:	83 c0 04             	add    $0x4,%eax
  80061e:	89 45 14             	mov    %eax,0x14(%ebp)
  800621:	8b 45 14             	mov    0x14(%ebp),%eax
  800624:	83 e8 04             	sub    $0x4,%eax
  800627:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800629:	85 db                	test   %ebx,%ebx
  80062b:	79 02                	jns    80062f <vprintfmt+0x14a>
				err = -err;
  80062d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80062f:	83 fb 64             	cmp    $0x64,%ebx
  800632:	7f 0b                	jg     80063f <vprintfmt+0x15a>
  800634:	8b 34 9d 80 1b 80 00 	mov    0x801b80(,%ebx,4),%esi
  80063b:	85 f6                	test   %esi,%esi
  80063d:	75 19                	jne    800658 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80063f:	53                   	push   %ebx
  800640:	68 25 1d 80 00       	push   $0x801d25
  800645:	ff 75 0c             	pushl  0xc(%ebp)
  800648:	ff 75 08             	pushl  0x8(%ebp)
  80064b:	e8 5e 02 00 00       	call   8008ae <printfmt>
  800650:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800653:	e9 49 02 00 00       	jmp    8008a1 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800658:	56                   	push   %esi
  800659:	68 2e 1d 80 00       	push   $0x801d2e
  80065e:	ff 75 0c             	pushl  0xc(%ebp)
  800661:	ff 75 08             	pushl  0x8(%ebp)
  800664:	e8 45 02 00 00       	call   8008ae <printfmt>
  800669:	83 c4 10             	add    $0x10,%esp
			break;
  80066c:	e9 30 02 00 00       	jmp    8008a1 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800671:	8b 45 14             	mov    0x14(%ebp),%eax
  800674:	83 c0 04             	add    $0x4,%eax
  800677:	89 45 14             	mov    %eax,0x14(%ebp)
  80067a:	8b 45 14             	mov    0x14(%ebp),%eax
  80067d:	83 e8 04             	sub    $0x4,%eax
  800680:	8b 30                	mov    (%eax),%esi
  800682:	85 f6                	test   %esi,%esi
  800684:	75 05                	jne    80068b <vprintfmt+0x1a6>
				p = "(null)";
  800686:	be 31 1d 80 00       	mov    $0x801d31,%esi
			if (width > 0 && padc != '-')
  80068b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80068f:	7e 6d                	jle    8006fe <vprintfmt+0x219>
  800691:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800695:	74 67                	je     8006fe <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800697:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80069a:	83 ec 08             	sub    $0x8,%esp
  80069d:	50                   	push   %eax
  80069e:	56                   	push   %esi
  80069f:	e8 0c 03 00 00       	call   8009b0 <strnlen>
  8006a4:	83 c4 10             	add    $0x10,%esp
  8006a7:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8006aa:	eb 16                	jmp    8006c2 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8006ac:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8006b0:	83 ec 08             	sub    $0x8,%esp
  8006b3:	ff 75 0c             	pushl  0xc(%ebp)
  8006b6:	50                   	push   %eax
  8006b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ba:	ff d0                	call   *%eax
  8006bc:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006bf:	ff 4d e4             	decl   -0x1c(%ebp)
  8006c2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006c6:	7f e4                	jg     8006ac <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006c8:	eb 34                	jmp    8006fe <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8006ca:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8006ce:	74 1c                	je     8006ec <vprintfmt+0x207>
  8006d0:	83 fb 1f             	cmp    $0x1f,%ebx
  8006d3:	7e 05                	jle    8006da <vprintfmt+0x1f5>
  8006d5:	83 fb 7e             	cmp    $0x7e,%ebx
  8006d8:	7e 12                	jle    8006ec <vprintfmt+0x207>
					putch('?', putdat);
  8006da:	83 ec 08             	sub    $0x8,%esp
  8006dd:	ff 75 0c             	pushl  0xc(%ebp)
  8006e0:	6a 3f                	push   $0x3f
  8006e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e5:	ff d0                	call   *%eax
  8006e7:	83 c4 10             	add    $0x10,%esp
  8006ea:	eb 0f                	jmp    8006fb <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006ec:	83 ec 08             	sub    $0x8,%esp
  8006ef:	ff 75 0c             	pushl  0xc(%ebp)
  8006f2:	53                   	push   %ebx
  8006f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f6:	ff d0                	call   *%eax
  8006f8:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006fb:	ff 4d e4             	decl   -0x1c(%ebp)
  8006fe:	89 f0                	mov    %esi,%eax
  800700:	8d 70 01             	lea    0x1(%eax),%esi
  800703:	8a 00                	mov    (%eax),%al
  800705:	0f be d8             	movsbl %al,%ebx
  800708:	85 db                	test   %ebx,%ebx
  80070a:	74 24                	je     800730 <vprintfmt+0x24b>
  80070c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800710:	78 b8                	js     8006ca <vprintfmt+0x1e5>
  800712:	ff 4d e0             	decl   -0x20(%ebp)
  800715:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800719:	79 af                	jns    8006ca <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80071b:	eb 13                	jmp    800730 <vprintfmt+0x24b>
				putch(' ', putdat);
  80071d:	83 ec 08             	sub    $0x8,%esp
  800720:	ff 75 0c             	pushl  0xc(%ebp)
  800723:	6a 20                	push   $0x20
  800725:	8b 45 08             	mov    0x8(%ebp),%eax
  800728:	ff d0                	call   *%eax
  80072a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80072d:	ff 4d e4             	decl   -0x1c(%ebp)
  800730:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800734:	7f e7                	jg     80071d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800736:	e9 66 01 00 00       	jmp    8008a1 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80073b:	83 ec 08             	sub    $0x8,%esp
  80073e:	ff 75 e8             	pushl  -0x18(%ebp)
  800741:	8d 45 14             	lea    0x14(%ebp),%eax
  800744:	50                   	push   %eax
  800745:	e8 3c fd ff ff       	call   800486 <getint>
  80074a:	83 c4 10             	add    $0x10,%esp
  80074d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800750:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800753:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800756:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800759:	85 d2                	test   %edx,%edx
  80075b:	79 23                	jns    800780 <vprintfmt+0x29b>
				putch('-', putdat);
  80075d:	83 ec 08             	sub    $0x8,%esp
  800760:	ff 75 0c             	pushl  0xc(%ebp)
  800763:	6a 2d                	push   $0x2d
  800765:	8b 45 08             	mov    0x8(%ebp),%eax
  800768:	ff d0                	call   *%eax
  80076a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80076d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800770:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800773:	f7 d8                	neg    %eax
  800775:	83 d2 00             	adc    $0x0,%edx
  800778:	f7 da                	neg    %edx
  80077a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80077d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800780:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800787:	e9 bc 00 00 00       	jmp    800848 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80078c:	83 ec 08             	sub    $0x8,%esp
  80078f:	ff 75 e8             	pushl  -0x18(%ebp)
  800792:	8d 45 14             	lea    0x14(%ebp),%eax
  800795:	50                   	push   %eax
  800796:	e8 84 fc ff ff       	call   80041f <getuint>
  80079b:	83 c4 10             	add    $0x10,%esp
  80079e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007a1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8007a4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007ab:	e9 98 00 00 00       	jmp    800848 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8007b0:	83 ec 08             	sub    $0x8,%esp
  8007b3:	ff 75 0c             	pushl  0xc(%ebp)
  8007b6:	6a 58                	push   $0x58
  8007b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bb:	ff d0                	call   *%eax
  8007bd:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007c0:	83 ec 08             	sub    $0x8,%esp
  8007c3:	ff 75 0c             	pushl  0xc(%ebp)
  8007c6:	6a 58                	push   $0x58
  8007c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cb:	ff d0                	call   *%eax
  8007cd:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007d0:	83 ec 08             	sub    $0x8,%esp
  8007d3:	ff 75 0c             	pushl  0xc(%ebp)
  8007d6:	6a 58                	push   $0x58
  8007d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007db:	ff d0                	call   *%eax
  8007dd:	83 c4 10             	add    $0x10,%esp
			break;
  8007e0:	e9 bc 00 00 00       	jmp    8008a1 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007e5:	83 ec 08             	sub    $0x8,%esp
  8007e8:	ff 75 0c             	pushl  0xc(%ebp)
  8007eb:	6a 30                	push   $0x30
  8007ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f0:	ff d0                	call   *%eax
  8007f2:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007f5:	83 ec 08             	sub    $0x8,%esp
  8007f8:	ff 75 0c             	pushl  0xc(%ebp)
  8007fb:	6a 78                	push   $0x78
  8007fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800800:	ff d0                	call   *%eax
  800802:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800805:	8b 45 14             	mov    0x14(%ebp),%eax
  800808:	83 c0 04             	add    $0x4,%eax
  80080b:	89 45 14             	mov    %eax,0x14(%ebp)
  80080e:	8b 45 14             	mov    0x14(%ebp),%eax
  800811:	83 e8 04             	sub    $0x4,%eax
  800814:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800816:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800819:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800820:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800827:	eb 1f                	jmp    800848 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800829:	83 ec 08             	sub    $0x8,%esp
  80082c:	ff 75 e8             	pushl  -0x18(%ebp)
  80082f:	8d 45 14             	lea    0x14(%ebp),%eax
  800832:	50                   	push   %eax
  800833:	e8 e7 fb ff ff       	call   80041f <getuint>
  800838:	83 c4 10             	add    $0x10,%esp
  80083b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80083e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800841:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800848:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80084c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80084f:	83 ec 04             	sub    $0x4,%esp
  800852:	52                   	push   %edx
  800853:	ff 75 e4             	pushl  -0x1c(%ebp)
  800856:	50                   	push   %eax
  800857:	ff 75 f4             	pushl  -0xc(%ebp)
  80085a:	ff 75 f0             	pushl  -0x10(%ebp)
  80085d:	ff 75 0c             	pushl  0xc(%ebp)
  800860:	ff 75 08             	pushl  0x8(%ebp)
  800863:	e8 00 fb ff ff       	call   800368 <printnum>
  800868:	83 c4 20             	add    $0x20,%esp
			break;
  80086b:	eb 34                	jmp    8008a1 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80086d:	83 ec 08             	sub    $0x8,%esp
  800870:	ff 75 0c             	pushl  0xc(%ebp)
  800873:	53                   	push   %ebx
  800874:	8b 45 08             	mov    0x8(%ebp),%eax
  800877:	ff d0                	call   *%eax
  800879:	83 c4 10             	add    $0x10,%esp
			break;
  80087c:	eb 23                	jmp    8008a1 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80087e:	83 ec 08             	sub    $0x8,%esp
  800881:	ff 75 0c             	pushl  0xc(%ebp)
  800884:	6a 25                	push   $0x25
  800886:	8b 45 08             	mov    0x8(%ebp),%eax
  800889:	ff d0                	call   *%eax
  80088b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80088e:	ff 4d 10             	decl   0x10(%ebp)
  800891:	eb 03                	jmp    800896 <vprintfmt+0x3b1>
  800893:	ff 4d 10             	decl   0x10(%ebp)
  800896:	8b 45 10             	mov    0x10(%ebp),%eax
  800899:	48                   	dec    %eax
  80089a:	8a 00                	mov    (%eax),%al
  80089c:	3c 25                	cmp    $0x25,%al
  80089e:	75 f3                	jne    800893 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8008a0:	90                   	nop
		}
	}
  8008a1:	e9 47 fc ff ff       	jmp    8004ed <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8008a6:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8008a7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008aa:	5b                   	pop    %ebx
  8008ab:	5e                   	pop    %esi
  8008ac:	5d                   	pop    %ebp
  8008ad:	c3                   	ret    

008008ae <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8008ae:	55                   	push   %ebp
  8008af:	89 e5                	mov    %esp,%ebp
  8008b1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8008b4:	8d 45 10             	lea    0x10(%ebp),%eax
  8008b7:	83 c0 04             	add    $0x4,%eax
  8008ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8008bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8008c0:	ff 75 f4             	pushl  -0xc(%ebp)
  8008c3:	50                   	push   %eax
  8008c4:	ff 75 0c             	pushl  0xc(%ebp)
  8008c7:	ff 75 08             	pushl  0x8(%ebp)
  8008ca:	e8 16 fc ff ff       	call   8004e5 <vprintfmt>
  8008cf:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8008d2:	90                   	nop
  8008d3:	c9                   	leave  
  8008d4:	c3                   	ret    

008008d5 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8008d5:	55                   	push   %ebp
  8008d6:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8008d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008db:	8b 40 08             	mov    0x8(%eax),%eax
  8008de:	8d 50 01             	lea    0x1(%eax),%edx
  8008e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e4:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ea:	8b 10                	mov    (%eax),%edx
  8008ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ef:	8b 40 04             	mov    0x4(%eax),%eax
  8008f2:	39 c2                	cmp    %eax,%edx
  8008f4:	73 12                	jae    800908 <sprintputch+0x33>
		*b->buf++ = ch;
  8008f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f9:	8b 00                	mov    (%eax),%eax
  8008fb:	8d 48 01             	lea    0x1(%eax),%ecx
  8008fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  800901:	89 0a                	mov    %ecx,(%edx)
  800903:	8b 55 08             	mov    0x8(%ebp),%edx
  800906:	88 10                	mov    %dl,(%eax)
}
  800908:	90                   	nop
  800909:	5d                   	pop    %ebp
  80090a:	c3                   	ret    

0080090b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80090b:	55                   	push   %ebp
  80090c:	89 e5                	mov    %esp,%ebp
  80090e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800911:	8b 45 08             	mov    0x8(%ebp),%eax
  800914:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800917:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80091d:	8b 45 08             	mov    0x8(%ebp),%eax
  800920:	01 d0                	add    %edx,%eax
  800922:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800925:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80092c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800930:	74 06                	je     800938 <vsnprintf+0x2d>
  800932:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800936:	7f 07                	jg     80093f <vsnprintf+0x34>
		return -E_INVAL;
  800938:	b8 03 00 00 00       	mov    $0x3,%eax
  80093d:	eb 20                	jmp    80095f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80093f:	ff 75 14             	pushl  0x14(%ebp)
  800942:	ff 75 10             	pushl  0x10(%ebp)
  800945:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800948:	50                   	push   %eax
  800949:	68 d5 08 80 00       	push   $0x8008d5
  80094e:	e8 92 fb ff ff       	call   8004e5 <vprintfmt>
  800953:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800956:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800959:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80095c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80095f:	c9                   	leave  
  800960:	c3                   	ret    

00800961 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800961:	55                   	push   %ebp
  800962:	89 e5                	mov    %esp,%ebp
  800964:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800967:	8d 45 10             	lea    0x10(%ebp),%eax
  80096a:	83 c0 04             	add    $0x4,%eax
  80096d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800970:	8b 45 10             	mov    0x10(%ebp),%eax
  800973:	ff 75 f4             	pushl  -0xc(%ebp)
  800976:	50                   	push   %eax
  800977:	ff 75 0c             	pushl  0xc(%ebp)
  80097a:	ff 75 08             	pushl  0x8(%ebp)
  80097d:	e8 89 ff ff ff       	call   80090b <vsnprintf>
  800982:	83 c4 10             	add    $0x10,%esp
  800985:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800988:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80098b:	c9                   	leave  
  80098c:	c3                   	ret    

0080098d <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80098d:	55                   	push   %ebp
  80098e:	89 e5                	mov    %esp,%ebp
  800990:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800993:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80099a:	eb 06                	jmp    8009a2 <strlen+0x15>
		n++;
  80099c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80099f:	ff 45 08             	incl   0x8(%ebp)
  8009a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a5:	8a 00                	mov    (%eax),%al
  8009a7:	84 c0                	test   %al,%al
  8009a9:	75 f1                	jne    80099c <strlen+0xf>
		n++;
	return n;
  8009ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009ae:	c9                   	leave  
  8009af:	c3                   	ret    

008009b0 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8009b0:	55                   	push   %ebp
  8009b1:	89 e5                	mov    %esp,%ebp
  8009b3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009bd:	eb 09                	jmp    8009c8 <strnlen+0x18>
		n++;
  8009bf:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009c2:	ff 45 08             	incl   0x8(%ebp)
  8009c5:	ff 4d 0c             	decl   0xc(%ebp)
  8009c8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009cc:	74 09                	je     8009d7 <strnlen+0x27>
  8009ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d1:	8a 00                	mov    (%eax),%al
  8009d3:	84 c0                	test   %al,%al
  8009d5:	75 e8                	jne    8009bf <strnlen+0xf>
		n++;
	return n;
  8009d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009da:	c9                   	leave  
  8009db:	c3                   	ret    

008009dc <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8009dc:	55                   	push   %ebp
  8009dd:	89 e5                	mov    %esp,%ebp
  8009df:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8009e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8009e8:	90                   	nop
  8009e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ec:	8d 50 01             	lea    0x1(%eax),%edx
  8009ef:	89 55 08             	mov    %edx,0x8(%ebp)
  8009f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009f5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009f8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009fb:	8a 12                	mov    (%edx),%dl
  8009fd:	88 10                	mov    %dl,(%eax)
  8009ff:	8a 00                	mov    (%eax),%al
  800a01:	84 c0                	test   %al,%al
  800a03:	75 e4                	jne    8009e9 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a05:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a08:	c9                   	leave  
  800a09:	c3                   	ret    

00800a0a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a0a:	55                   	push   %ebp
  800a0b:	89 e5                	mov    %esp,%ebp
  800a0d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a10:	8b 45 08             	mov    0x8(%ebp),%eax
  800a13:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a16:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a1d:	eb 1f                	jmp    800a3e <strncpy+0x34>
		*dst++ = *src;
  800a1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a22:	8d 50 01             	lea    0x1(%eax),%edx
  800a25:	89 55 08             	mov    %edx,0x8(%ebp)
  800a28:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a2b:	8a 12                	mov    (%edx),%dl
  800a2d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a32:	8a 00                	mov    (%eax),%al
  800a34:	84 c0                	test   %al,%al
  800a36:	74 03                	je     800a3b <strncpy+0x31>
			src++;
  800a38:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a3b:	ff 45 fc             	incl   -0x4(%ebp)
  800a3e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a41:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a44:	72 d9                	jb     800a1f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a46:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a49:	c9                   	leave  
  800a4a:	c3                   	ret    

00800a4b <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a4b:	55                   	push   %ebp
  800a4c:	89 e5                	mov    %esp,%ebp
  800a4e:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a51:	8b 45 08             	mov    0x8(%ebp),%eax
  800a54:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a57:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a5b:	74 30                	je     800a8d <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a5d:	eb 16                	jmp    800a75 <strlcpy+0x2a>
			*dst++ = *src++;
  800a5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a62:	8d 50 01             	lea    0x1(%eax),%edx
  800a65:	89 55 08             	mov    %edx,0x8(%ebp)
  800a68:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a6b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a6e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a71:	8a 12                	mov    (%edx),%dl
  800a73:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a75:	ff 4d 10             	decl   0x10(%ebp)
  800a78:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a7c:	74 09                	je     800a87 <strlcpy+0x3c>
  800a7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a81:	8a 00                	mov    (%eax),%al
  800a83:	84 c0                	test   %al,%al
  800a85:	75 d8                	jne    800a5f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a87:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8a:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a8d:	8b 55 08             	mov    0x8(%ebp),%edx
  800a90:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a93:	29 c2                	sub    %eax,%edx
  800a95:	89 d0                	mov    %edx,%eax
}
  800a97:	c9                   	leave  
  800a98:	c3                   	ret    

00800a99 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a99:	55                   	push   %ebp
  800a9a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a9c:	eb 06                	jmp    800aa4 <strcmp+0xb>
		p++, q++;
  800a9e:	ff 45 08             	incl   0x8(%ebp)
  800aa1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800aa4:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa7:	8a 00                	mov    (%eax),%al
  800aa9:	84 c0                	test   %al,%al
  800aab:	74 0e                	je     800abb <strcmp+0x22>
  800aad:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab0:	8a 10                	mov    (%eax),%dl
  800ab2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab5:	8a 00                	mov    (%eax),%al
  800ab7:	38 c2                	cmp    %al,%dl
  800ab9:	74 e3                	je     800a9e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800abb:	8b 45 08             	mov    0x8(%ebp),%eax
  800abe:	8a 00                	mov    (%eax),%al
  800ac0:	0f b6 d0             	movzbl %al,%edx
  800ac3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac6:	8a 00                	mov    (%eax),%al
  800ac8:	0f b6 c0             	movzbl %al,%eax
  800acb:	29 c2                	sub    %eax,%edx
  800acd:	89 d0                	mov    %edx,%eax
}
  800acf:	5d                   	pop    %ebp
  800ad0:	c3                   	ret    

00800ad1 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ad1:	55                   	push   %ebp
  800ad2:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ad4:	eb 09                	jmp    800adf <strncmp+0xe>
		n--, p++, q++;
  800ad6:	ff 4d 10             	decl   0x10(%ebp)
  800ad9:	ff 45 08             	incl   0x8(%ebp)
  800adc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800adf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ae3:	74 17                	je     800afc <strncmp+0x2b>
  800ae5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae8:	8a 00                	mov    (%eax),%al
  800aea:	84 c0                	test   %al,%al
  800aec:	74 0e                	je     800afc <strncmp+0x2b>
  800aee:	8b 45 08             	mov    0x8(%ebp),%eax
  800af1:	8a 10                	mov    (%eax),%dl
  800af3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af6:	8a 00                	mov    (%eax),%al
  800af8:	38 c2                	cmp    %al,%dl
  800afa:	74 da                	je     800ad6 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800afc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b00:	75 07                	jne    800b09 <strncmp+0x38>
		return 0;
  800b02:	b8 00 00 00 00       	mov    $0x0,%eax
  800b07:	eb 14                	jmp    800b1d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b09:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0c:	8a 00                	mov    (%eax),%al
  800b0e:	0f b6 d0             	movzbl %al,%edx
  800b11:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b14:	8a 00                	mov    (%eax),%al
  800b16:	0f b6 c0             	movzbl %al,%eax
  800b19:	29 c2                	sub    %eax,%edx
  800b1b:	89 d0                	mov    %edx,%eax
}
  800b1d:	5d                   	pop    %ebp
  800b1e:	c3                   	ret    

00800b1f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b1f:	55                   	push   %ebp
  800b20:	89 e5                	mov    %esp,%ebp
  800b22:	83 ec 04             	sub    $0x4,%esp
  800b25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b28:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b2b:	eb 12                	jmp    800b3f <strchr+0x20>
		if (*s == c)
  800b2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b30:	8a 00                	mov    (%eax),%al
  800b32:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b35:	75 05                	jne    800b3c <strchr+0x1d>
			return (char *) s;
  800b37:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3a:	eb 11                	jmp    800b4d <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b3c:	ff 45 08             	incl   0x8(%ebp)
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	8a 00                	mov    (%eax),%al
  800b44:	84 c0                	test   %al,%al
  800b46:	75 e5                	jne    800b2d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b48:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b4d:	c9                   	leave  
  800b4e:	c3                   	ret    

00800b4f <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b4f:	55                   	push   %ebp
  800b50:	89 e5                	mov    %esp,%ebp
  800b52:	83 ec 04             	sub    $0x4,%esp
  800b55:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b58:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b5b:	eb 0d                	jmp    800b6a <strfind+0x1b>
		if (*s == c)
  800b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b60:	8a 00                	mov    (%eax),%al
  800b62:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b65:	74 0e                	je     800b75 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b67:	ff 45 08             	incl   0x8(%ebp)
  800b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6d:	8a 00                	mov    (%eax),%al
  800b6f:	84 c0                	test   %al,%al
  800b71:	75 ea                	jne    800b5d <strfind+0xe>
  800b73:	eb 01                	jmp    800b76 <strfind+0x27>
		if (*s == c)
			break;
  800b75:	90                   	nop
	return (char *) s;
  800b76:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b79:	c9                   	leave  
  800b7a:	c3                   	ret    

00800b7b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b7b:	55                   	push   %ebp
  800b7c:	89 e5                	mov    %esp,%ebp
  800b7e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b81:	8b 45 08             	mov    0x8(%ebp),%eax
  800b84:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b87:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b8d:	eb 0e                	jmp    800b9d <memset+0x22>
		*p++ = c;
  800b8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b92:	8d 50 01             	lea    0x1(%eax),%edx
  800b95:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b98:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b9b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b9d:	ff 4d f8             	decl   -0x8(%ebp)
  800ba0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ba4:	79 e9                	jns    800b8f <memset+0x14>
		*p++ = c;

	return v;
  800ba6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ba9:	c9                   	leave  
  800baa:	c3                   	ret    

00800bab <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800bab:	55                   	push   %ebp
  800bac:	89 e5                	mov    %esp,%ebp
  800bae:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800bb1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800bb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bba:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800bbd:	eb 16                	jmp    800bd5 <memcpy+0x2a>
		*d++ = *s++;
  800bbf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bc2:	8d 50 01             	lea    0x1(%eax),%edx
  800bc5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bc8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bcb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bce:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bd1:	8a 12                	mov    (%edx),%dl
  800bd3:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800bd5:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bdb:	89 55 10             	mov    %edx,0x10(%ebp)
  800bde:	85 c0                	test   %eax,%eax
  800be0:	75 dd                	jne    800bbf <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800be2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800be5:	c9                   	leave  
  800be6:	c3                   	ret    

00800be7 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800be7:	55                   	push   %ebp
  800be8:	89 e5                	mov    %esp,%ebp
  800bea:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800bed:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800bf9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bfc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bff:	73 50                	jae    800c51 <memmove+0x6a>
  800c01:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c04:	8b 45 10             	mov    0x10(%ebp),%eax
  800c07:	01 d0                	add    %edx,%eax
  800c09:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c0c:	76 43                	jbe    800c51 <memmove+0x6a>
		s += n;
  800c0e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c11:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c14:	8b 45 10             	mov    0x10(%ebp),%eax
  800c17:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c1a:	eb 10                	jmp    800c2c <memmove+0x45>
			*--d = *--s;
  800c1c:	ff 4d f8             	decl   -0x8(%ebp)
  800c1f:	ff 4d fc             	decl   -0x4(%ebp)
  800c22:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c25:	8a 10                	mov    (%eax),%dl
  800c27:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c2a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800c2c:	8b 45 10             	mov    0x10(%ebp),%eax
  800c2f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c32:	89 55 10             	mov    %edx,0x10(%ebp)
  800c35:	85 c0                	test   %eax,%eax
  800c37:	75 e3                	jne    800c1c <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c39:	eb 23                	jmp    800c5e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c3b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c3e:	8d 50 01             	lea    0x1(%eax),%edx
  800c41:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c44:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c47:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c4a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c4d:	8a 12                	mov    (%edx),%dl
  800c4f:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c51:	8b 45 10             	mov    0x10(%ebp),%eax
  800c54:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c57:	89 55 10             	mov    %edx,0x10(%ebp)
  800c5a:	85 c0                	test   %eax,%eax
  800c5c:	75 dd                	jne    800c3b <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c5e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c61:	c9                   	leave  
  800c62:	c3                   	ret    

00800c63 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c63:	55                   	push   %ebp
  800c64:	89 e5                	mov    %esp,%ebp
  800c66:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c69:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c72:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c75:	eb 2a                	jmp    800ca1 <memcmp+0x3e>
		if (*s1 != *s2)
  800c77:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c7a:	8a 10                	mov    (%eax),%dl
  800c7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c7f:	8a 00                	mov    (%eax),%al
  800c81:	38 c2                	cmp    %al,%dl
  800c83:	74 16                	je     800c9b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c85:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c88:	8a 00                	mov    (%eax),%al
  800c8a:	0f b6 d0             	movzbl %al,%edx
  800c8d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c90:	8a 00                	mov    (%eax),%al
  800c92:	0f b6 c0             	movzbl %al,%eax
  800c95:	29 c2                	sub    %eax,%edx
  800c97:	89 d0                	mov    %edx,%eax
  800c99:	eb 18                	jmp    800cb3 <memcmp+0x50>
		s1++, s2++;
  800c9b:	ff 45 fc             	incl   -0x4(%ebp)
  800c9e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800ca1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ca7:	89 55 10             	mov    %edx,0x10(%ebp)
  800caa:	85 c0                	test   %eax,%eax
  800cac:	75 c9                	jne    800c77 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800cae:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cb3:	c9                   	leave  
  800cb4:	c3                   	ret    

00800cb5 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800cb5:	55                   	push   %ebp
  800cb6:	89 e5                	mov    %esp,%ebp
  800cb8:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800cbb:	8b 55 08             	mov    0x8(%ebp),%edx
  800cbe:	8b 45 10             	mov    0x10(%ebp),%eax
  800cc1:	01 d0                	add    %edx,%eax
  800cc3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800cc6:	eb 15                	jmp    800cdd <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccb:	8a 00                	mov    (%eax),%al
  800ccd:	0f b6 d0             	movzbl %al,%edx
  800cd0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd3:	0f b6 c0             	movzbl %al,%eax
  800cd6:	39 c2                	cmp    %eax,%edx
  800cd8:	74 0d                	je     800ce7 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800cda:	ff 45 08             	incl   0x8(%ebp)
  800cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ce3:	72 e3                	jb     800cc8 <memfind+0x13>
  800ce5:	eb 01                	jmp    800ce8 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ce7:	90                   	nop
	return (void *) s;
  800ce8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ceb:	c9                   	leave  
  800cec:	c3                   	ret    

00800ced <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ced:	55                   	push   %ebp
  800cee:	89 e5                	mov    %esp,%ebp
  800cf0:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800cf3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800cfa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d01:	eb 03                	jmp    800d06 <strtol+0x19>
		s++;
  800d03:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	8a 00                	mov    (%eax),%al
  800d0b:	3c 20                	cmp    $0x20,%al
  800d0d:	74 f4                	je     800d03 <strtol+0x16>
  800d0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d12:	8a 00                	mov    (%eax),%al
  800d14:	3c 09                	cmp    $0x9,%al
  800d16:	74 eb                	je     800d03 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d18:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1b:	8a 00                	mov    (%eax),%al
  800d1d:	3c 2b                	cmp    $0x2b,%al
  800d1f:	75 05                	jne    800d26 <strtol+0x39>
		s++;
  800d21:	ff 45 08             	incl   0x8(%ebp)
  800d24:	eb 13                	jmp    800d39 <strtol+0x4c>
	else if (*s == '-')
  800d26:	8b 45 08             	mov    0x8(%ebp),%eax
  800d29:	8a 00                	mov    (%eax),%al
  800d2b:	3c 2d                	cmp    $0x2d,%al
  800d2d:	75 0a                	jne    800d39 <strtol+0x4c>
		s++, neg = 1;
  800d2f:	ff 45 08             	incl   0x8(%ebp)
  800d32:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d39:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d3d:	74 06                	je     800d45 <strtol+0x58>
  800d3f:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d43:	75 20                	jne    800d65 <strtol+0x78>
  800d45:	8b 45 08             	mov    0x8(%ebp),%eax
  800d48:	8a 00                	mov    (%eax),%al
  800d4a:	3c 30                	cmp    $0x30,%al
  800d4c:	75 17                	jne    800d65 <strtol+0x78>
  800d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d51:	40                   	inc    %eax
  800d52:	8a 00                	mov    (%eax),%al
  800d54:	3c 78                	cmp    $0x78,%al
  800d56:	75 0d                	jne    800d65 <strtol+0x78>
		s += 2, base = 16;
  800d58:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d5c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d63:	eb 28                	jmp    800d8d <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d65:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d69:	75 15                	jne    800d80 <strtol+0x93>
  800d6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6e:	8a 00                	mov    (%eax),%al
  800d70:	3c 30                	cmp    $0x30,%al
  800d72:	75 0c                	jne    800d80 <strtol+0x93>
		s++, base = 8;
  800d74:	ff 45 08             	incl   0x8(%ebp)
  800d77:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d7e:	eb 0d                	jmp    800d8d <strtol+0xa0>
	else if (base == 0)
  800d80:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d84:	75 07                	jne    800d8d <strtol+0xa0>
		base = 10;
  800d86:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d90:	8a 00                	mov    (%eax),%al
  800d92:	3c 2f                	cmp    $0x2f,%al
  800d94:	7e 19                	jle    800daf <strtol+0xc2>
  800d96:	8b 45 08             	mov    0x8(%ebp),%eax
  800d99:	8a 00                	mov    (%eax),%al
  800d9b:	3c 39                	cmp    $0x39,%al
  800d9d:	7f 10                	jg     800daf <strtol+0xc2>
			dig = *s - '0';
  800d9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800da2:	8a 00                	mov    (%eax),%al
  800da4:	0f be c0             	movsbl %al,%eax
  800da7:	83 e8 30             	sub    $0x30,%eax
  800daa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dad:	eb 42                	jmp    800df1 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800daf:	8b 45 08             	mov    0x8(%ebp),%eax
  800db2:	8a 00                	mov    (%eax),%al
  800db4:	3c 60                	cmp    $0x60,%al
  800db6:	7e 19                	jle    800dd1 <strtol+0xe4>
  800db8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbb:	8a 00                	mov    (%eax),%al
  800dbd:	3c 7a                	cmp    $0x7a,%al
  800dbf:	7f 10                	jg     800dd1 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	8a 00                	mov    (%eax),%al
  800dc6:	0f be c0             	movsbl %al,%eax
  800dc9:	83 e8 57             	sub    $0x57,%eax
  800dcc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dcf:	eb 20                	jmp    800df1 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800dd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd4:	8a 00                	mov    (%eax),%al
  800dd6:	3c 40                	cmp    $0x40,%al
  800dd8:	7e 39                	jle    800e13 <strtol+0x126>
  800dda:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddd:	8a 00                	mov    (%eax),%al
  800ddf:	3c 5a                	cmp    $0x5a,%al
  800de1:	7f 30                	jg     800e13 <strtol+0x126>
			dig = *s - 'A' + 10;
  800de3:	8b 45 08             	mov    0x8(%ebp),%eax
  800de6:	8a 00                	mov    (%eax),%al
  800de8:	0f be c0             	movsbl %al,%eax
  800deb:	83 e8 37             	sub    $0x37,%eax
  800dee:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800df1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800df4:	3b 45 10             	cmp    0x10(%ebp),%eax
  800df7:	7d 19                	jge    800e12 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800df9:	ff 45 08             	incl   0x8(%ebp)
  800dfc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dff:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e03:	89 c2                	mov    %eax,%edx
  800e05:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e08:	01 d0                	add    %edx,%eax
  800e0a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e0d:	e9 7b ff ff ff       	jmp    800d8d <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e12:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e13:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e17:	74 08                	je     800e21 <strtol+0x134>
		*endptr = (char *) s;
  800e19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1c:	8b 55 08             	mov    0x8(%ebp),%edx
  800e1f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e21:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e25:	74 07                	je     800e2e <strtol+0x141>
  800e27:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e2a:	f7 d8                	neg    %eax
  800e2c:	eb 03                	jmp    800e31 <strtol+0x144>
  800e2e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e31:	c9                   	leave  
  800e32:	c3                   	ret    

00800e33 <ltostr>:

void
ltostr(long value, char *str)
{
  800e33:	55                   	push   %ebp
  800e34:	89 e5                	mov    %esp,%ebp
  800e36:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e39:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e40:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e47:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e4b:	79 13                	jns    800e60 <ltostr+0x2d>
	{
		neg = 1;
  800e4d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e54:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e57:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e5a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e5d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e60:	8b 45 08             	mov    0x8(%ebp),%eax
  800e63:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e68:	99                   	cltd   
  800e69:	f7 f9                	idiv   %ecx
  800e6b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e6e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e71:	8d 50 01             	lea    0x1(%eax),%edx
  800e74:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e77:	89 c2                	mov    %eax,%edx
  800e79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7c:	01 d0                	add    %edx,%eax
  800e7e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e81:	83 c2 30             	add    $0x30,%edx
  800e84:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e86:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e89:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e8e:	f7 e9                	imul   %ecx
  800e90:	c1 fa 02             	sar    $0x2,%edx
  800e93:	89 c8                	mov    %ecx,%eax
  800e95:	c1 f8 1f             	sar    $0x1f,%eax
  800e98:	29 c2                	sub    %eax,%edx
  800e9a:	89 d0                	mov    %edx,%eax
  800e9c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e9f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ea2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800ea7:	f7 e9                	imul   %ecx
  800ea9:	c1 fa 02             	sar    $0x2,%edx
  800eac:	89 c8                	mov    %ecx,%eax
  800eae:	c1 f8 1f             	sar    $0x1f,%eax
  800eb1:	29 c2                	sub    %eax,%edx
  800eb3:	89 d0                	mov    %edx,%eax
  800eb5:	c1 e0 02             	shl    $0x2,%eax
  800eb8:	01 d0                	add    %edx,%eax
  800eba:	01 c0                	add    %eax,%eax
  800ebc:	29 c1                	sub    %eax,%ecx
  800ebe:	89 ca                	mov    %ecx,%edx
  800ec0:	85 d2                	test   %edx,%edx
  800ec2:	75 9c                	jne    800e60 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800ec4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800ecb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ece:	48                   	dec    %eax
  800ecf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800ed2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ed6:	74 3d                	je     800f15 <ltostr+0xe2>
		start = 1 ;
  800ed8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800edf:	eb 34                	jmp    800f15 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800ee1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ee4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee7:	01 d0                	add    %edx,%eax
  800ee9:	8a 00                	mov    (%eax),%al
  800eeb:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800eee:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ef1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef4:	01 c2                	add    %eax,%edx
  800ef6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800ef9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800efc:	01 c8                	add    %ecx,%eax
  800efe:	8a 00                	mov    (%eax),%al
  800f00:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f02:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f08:	01 c2                	add    %eax,%edx
  800f0a:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f0d:	88 02                	mov    %al,(%edx)
		start++ ;
  800f0f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f12:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f15:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f18:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f1b:	7c c4                	jl     800ee1 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f1d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f20:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f23:	01 d0                	add    %edx,%eax
  800f25:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f28:	90                   	nop
  800f29:	c9                   	leave  
  800f2a:	c3                   	ret    

00800f2b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800f2b:	55                   	push   %ebp
  800f2c:	89 e5                	mov    %esp,%ebp
  800f2e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f31:	ff 75 08             	pushl  0x8(%ebp)
  800f34:	e8 54 fa ff ff       	call   80098d <strlen>
  800f39:	83 c4 04             	add    $0x4,%esp
  800f3c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f3f:	ff 75 0c             	pushl  0xc(%ebp)
  800f42:	e8 46 fa ff ff       	call   80098d <strlen>
  800f47:	83 c4 04             	add    $0x4,%esp
  800f4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f4d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f54:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f5b:	eb 17                	jmp    800f74 <strcconcat+0x49>
		final[s] = str1[s] ;
  800f5d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f60:	8b 45 10             	mov    0x10(%ebp),%eax
  800f63:	01 c2                	add    %eax,%edx
  800f65:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f68:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6b:	01 c8                	add    %ecx,%eax
  800f6d:	8a 00                	mov    (%eax),%al
  800f6f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f71:	ff 45 fc             	incl   -0x4(%ebp)
  800f74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f77:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f7a:	7c e1                	jl     800f5d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f7c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f83:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f8a:	eb 1f                	jmp    800fab <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f8f:	8d 50 01             	lea    0x1(%eax),%edx
  800f92:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f95:	89 c2                	mov    %eax,%edx
  800f97:	8b 45 10             	mov    0x10(%ebp),%eax
  800f9a:	01 c2                	add    %eax,%edx
  800f9c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa2:	01 c8                	add    %ecx,%eax
  800fa4:	8a 00                	mov    (%eax),%al
  800fa6:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800fa8:	ff 45 f8             	incl   -0x8(%ebp)
  800fab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fae:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fb1:	7c d9                	jl     800f8c <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800fb3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fb6:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb9:	01 d0                	add    %edx,%eax
  800fbb:	c6 00 00             	movb   $0x0,(%eax)
}
  800fbe:	90                   	nop
  800fbf:	c9                   	leave  
  800fc0:	c3                   	ret    

00800fc1 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800fc1:	55                   	push   %ebp
  800fc2:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800fc4:	8b 45 14             	mov    0x14(%ebp),%eax
  800fc7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800fcd:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd0:	8b 00                	mov    (%eax),%eax
  800fd2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fd9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fdc:	01 d0                	add    %edx,%eax
  800fde:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800fe4:	eb 0c                	jmp    800ff2 <strsplit+0x31>
			*string++ = 0;
  800fe6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe9:	8d 50 01             	lea    0x1(%eax),%edx
  800fec:	89 55 08             	mov    %edx,0x8(%ebp)
  800fef:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800ff2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff5:	8a 00                	mov    (%eax),%al
  800ff7:	84 c0                	test   %al,%al
  800ff9:	74 18                	je     801013 <strsplit+0x52>
  800ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffe:	8a 00                	mov    (%eax),%al
  801000:	0f be c0             	movsbl %al,%eax
  801003:	50                   	push   %eax
  801004:	ff 75 0c             	pushl  0xc(%ebp)
  801007:	e8 13 fb ff ff       	call   800b1f <strchr>
  80100c:	83 c4 08             	add    $0x8,%esp
  80100f:	85 c0                	test   %eax,%eax
  801011:	75 d3                	jne    800fe6 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801013:	8b 45 08             	mov    0x8(%ebp),%eax
  801016:	8a 00                	mov    (%eax),%al
  801018:	84 c0                	test   %al,%al
  80101a:	74 5a                	je     801076 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80101c:	8b 45 14             	mov    0x14(%ebp),%eax
  80101f:	8b 00                	mov    (%eax),%eax
  801021:	83 f8 0f             	cmp    $0xf,%eax
  801024:	75 07                	jne    80102d <strsplit+0x6c>
		{
			return 0;
  801026:	b8 00 00 00 00       	mov    $0x0,%eax
  80102b:	eb 66                	jmp    801093 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80102d:	8b 45 14             	mov    0x14(%ebp),%eax
  801030:	8b 00                	mov    (%eax),%eax
  801032:	8d 48 01             	lea    0x1(%eax),%ecx
  801035:	8b 55 14             	mov    0x14(%ebp),%edx
  801038:	89 0a                	mov    %ecx,(%edx)
  80103a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801041:	8b 45 10             	mov    0x10(%ebp),%eax
  801044:	01 c2                	add    %eax,%edx
  801046:	8b 45 08             	mov    0x8(%ebp),%eax
  801049:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80104b:	eb 03                	jmp    801050 <strsplit+0x8f>
			string++;
  80104d:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801050:	8b 45 08             	mov    0x8(%ebp),%eax
  801053:	8a 00                	mov    (%eax),%al
  801055:	84 c0                	test   %al,%al
  801057:	74 8b                	je     800fe4 <strsplit+0x23>
  801059:	8b 45 08             	mov    0x8(%ebp),%eax
  80105c:	8a 00                	mov    (%eax),%al
  80105e:	0f be c0             	movsbl %al,%eax
  801061:	50                   	push   %eax
  801062:	ff 75 0c             	pushl  0xc(%ebp)
  801065:	e8 b5 fa ff ff       	call   800b1f <strchr>
  80106a:	83 c4 08             	add    $0x8,%esp
  80106d:	85 c0                	test   %eax,%eax
  80106f:	74 dc                	je     80104d <strsplit+0x8c>
			string++;
	}
  801071:	e9 6e ff ff ff       	jmp    800fe4 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801076:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801077:	8b 45 14             	mov    0x14(%ebp),%eax
  80107a:	8b 00                	mov    (%eax),%eax
  80107c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801083:	8b 45 10             	mov    0x10(%ebp),%eax
  801086:	01 d0                	add    %edx,%eax
  801088:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80108e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801093:	c9                   	leave  
  801094:	c3                   	ret    

00801095 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801095:	55                   	push   %ebp
  801096:	89 e5                	mov    %esp,%ebp
  801098:	57                   	push   %edi
  801099:	56                   	push   %esi
  80109a:	53                   	push   %ebx
  80109b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80109e:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010a4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010a7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010aa:	8b 7d 18             	mov    0x18(%ebp),%edi
  8010ad:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8010b0:	cd 30                	int    $0x30
  8010b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8010b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010b8:	83 c4 10             	add    $0x10,%esp
  8010bb:	5b                   	pop    %ebx
  8010bc:	5e                   	pop    %esi
  8010bd:	5f                   	pop    %edi
  8010be:	5d                   	pop    %ebp
  8010bf:	c3                   	ret    

008010c0 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8010c0:	55                   	push   %ebp
  8010c1:	89 e5                	mov    %esp,%ebp
  8010c3:	83 ec 04             	sub    $0x4,%esp
  8010c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8010cc:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8010d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d3:	6a 00                	push   $0x0
  8010d5:	6a 00                	push   $0x0
  8010d7:	52                   	push   %edx
  8010d8:	ff 75 0c             	pushl  0xc(%ebp)
  8010db:	50                   	push   %eax
  8010dc:	6a 00                	push   $0x0
  8010de:	e8 b2 ff ff ff       	call   801095 <syscall>
  8010e3:	83 c4 18             	add    $0x18,%esp
}
  8010e6:	90                   	nop
  8010e7:	c9                   	leave  
  8010e8:	c3                   	ret    

008010e9 <sys_cgetc>:

int
sys_cgetc(void)
{
  8010e9:	55                   	push   %ebp
  8010ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8010ec:	6a 00                	push   $0x0
  8010ee:	6a 00                	push   $0x0
  8010f0:	6a 00                	push   $0x0
  8010f2:	6a 00                	push   $0x0
  8010f4:	6a 00                	push   $0x0
  8010f6:	6a 01                	push   $0x1
  8010f8:	e8 98 ff ff ff       	call   801095 <syscall>
  8010fd:	83 c4 18             	add    $0x18,%esp
}
  801100:	c9                   	leave  
  801101:	c3                   	ret    

00801102 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801102:	55                   	push   %ebp
  801103:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801105:	8b 45 08             	mov    0x8(%ebp),%eax
  801108:	6a 00                	push   $0x0
  80110a:	6a 00                	push   $0x0
  80110c:	6a 00                	push   $0x0
  80110e:	6a 00                	push   $0x0
  801110:	50                   	push   %eax
  801111:	6a 05                	push   $0x5
  801113:	e8 7d ff ff ff       	call   801095 <syscall>
  801118:	83 c4 18             	add    $0x18,%esp
}
  80111b:	c9                   	leave  
  80111c:	c3                   	ret    

0080111d <sys_getenvid>:

int32 sys_getenvid(void)
{
  80111d:	55                   	push   %ebp
  80111e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801120:	6a 00                	push   $0x0
  801122:	6a 00                	push   $0x0
  801124:	6a 00                	push   $0x0
  801126:	6a 00                	push   $0x0
  801128:	6a 00                	push   $0x0
  80112a:	6a 02                	push   $0x2
  80112c:	e8 64 ff ff ff       	call   801095 <syscall>
  801131:	83 c4 18             	add    $0x18,%esp
}
  801134:	c9                   	leave  
  801135:	c3                   	ret    

00801136 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801136:	55                   	push   %ebp
  801137:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801139:	6a 00                	push   $0x0
  80113b:	6a 00                	push   $0x0
  80113d:	6a 00                	push   $0x0
  80113f:	6a 00                	push   $0x0
  801141:	6a 00                	push   $0x0
  801143:	6a 03                	push   $0x3
  801145:	e8 4b ff ff ff       	call   801095 <syscall>
  80114a:	83 c4 18             	add    $0x18,%esp
}
  80114d:	c9                   	leave  
  80114e:	c3                   	ret    

0080114f <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80114f:	55                   	push   %ebp
  801150:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801152:	6a 00                	push   $0x0
  801154:	6a 00                	push   $0x0
  801156:	6a 00                	push   $0x0
  801158:	6a 00                	push   $0x0
  80115a:	6a 00                	push   $0x0
  80115c:	6a 04                	push   $0x4
  80115e:	e8 32 ff ff ff       	call   801095 <syscall>
  801163:	83 c4 18             	add    $0x18,%esp
}
  801166:	c9                   	leave  
  801167:	c3                   	ret    

00801168 <sys_env_exit>:


void sys_env_exit(void)
{
  801168:	55                   	push   %ebp
  801169:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80116b:	6a 00                	push   $0x0
  80116d:	6a 00                	push   $0x0
  80116f:	6a 00                	push   $0x0
  801171:	6a 00                	push   $0x0
  801173:	6a 00                	push   $0x0
  801175:	6a 06                	push   $0x6
  801177:	e8 19 ff ff ff       	call   801095 <syscall>
  80117c:	83 c4 18             	add    $0x18,%esp
}
  80117f:	90                   	nop
  801180:	c9                   	leave  
  801181:	c3                   	ret    

00801182 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801182:	55                   	push   %ebp
  801183:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801185:	8b 55 0c             	mov    0xc(%ebp),%edx
  801188:	8b 45 08             	mov    0x8(%ebp),%eax
  80118b:	6a 00                	push   $0x0
  80118d:	6a 00                	push   $0x0
  80118f:	6a 00                	push   $0x0
  801191:	52                   	push   %edx
  801192:	50                   	push   %eax
  801193:	6a 07                	push   $0x7
  801195:	e8 fb fe ff ff       	call   801095 <syscall>
  80119a:	83 c4 18             	add    $0x18,%esp
}
  80119d:	c9                   	leave  
  80119e:	c3                   	ret    

0080119f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80119f:	55                   	push   %ebp
  8011a0:	89 e5                	mov    %esp,%ebp
  8011a2:	56                   	push   %esi
  8011a3:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8011a4:	8b 75 18             	mov    0x18(%ebp),%esi
  8011a7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8011aa:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8011ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b3:	56                   	push   %esi
  8011b4:	53                   	push   %ebx
  8011b5:	51                   	push   %ecx
  8011b6:	52                   	push   %edx
  8011b7:	50                   	push   %eax
  8011b8:	6a 08                	push   $0x8
  8011ba:	e8 d6 fe ff ff       	call   801095 <syscall>
  8011bf:	83 c4 18             	add    $0x18,%esp
}
  8011c2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8011c5:	5b                   	pop    %ebx
  8011c6:	5e                   	pop    %esi
  8011c7:	5d                   	pop    %ebp
  8011c8:	c3                   	ret    

008011c9 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8011c9:	55                   	push   %ebp
  8011ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8011cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d2:	6a 00                	push   $0x0
  8011d4:	6a 00                	push   $0x0
  8011d6:	6a 00                	push   $0x0
  8011d8:	52                   	push   %edx
  8011d9:	50                   	push   %eax
  8011da:	6a 09                	push   $0x9
  8011dc:	e8 b4 fe ff ff       	call   801095 <syscall>
  8011e1:	83 c4 18             	add    $0x18,%esp
}
  8011e4:	c9                   	leave  
  8011e5:	c3                   	ret    

008011e6 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8011e6:	55                   	push   %ebp
  8011e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8011e9:	6a 00                	push   $0x0
  8011eb:	6a 00                	push   $0x0
  8011ed:	6a 00                	push   $0x0
  8011ef:	ff 75 0c             	pushl  0xc(%ebp)
  8011f2:	ff 75 08             	pushl  0x8(%ebp)
  8011f5:	6a 0a                	push   $0xa
  8011f7:	e8 99 fe ff ff       	call   801095 <syscall>
  8011fc:	83 c4 18             	add    $0x18,%esp
}
  8011ff:	c9                   	leave  
  801200:	c3                   	ret    

00801201 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801201:	55                   	push   %ebp
  801202:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801204:	6a 00                	push   $0x0
  801206:	6a 00                	push   $0x0
  801208:	6a 00                	push   $0x0
  80120a:	6a 00                	push   $0x0
  80120c:	6a 00                	push   $0x0
  80120e:	6a 0b                	push   $0xb
  801210:	e8 80 fe ff ff       	call   801095 <syscall>
  801215:	83 c4 18             	add    $0x18,%esp
}
  801218:	c9                   	leave  
  801219:	c3                   	ret    

0080121a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80121a:	55                   	push   %ebp
  80121b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80121d:	6a 00                	push   $0x0
  80121f:	6a 00                	push   $0x0
  801221:	6a 00                	push   $0x0
  801223:	6a 00                	push   $0x0
  801225:	6a 00                	push   $0x0
  801227:	6a 0c                	push   $0xc
  801229:	e8 67 fe ff ff       	call   801095 <syscall>
  80122e:	83 c4 18             	add    $0x18,%esp
}
  801231:	c9                   	leave  
  801232:	c3                   	ret    

00801233 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801233:	55                   	push   %ebp
  801234:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801236:	6a 00                	push   $0x0
  801238:	6a 00                	push   $0x0
  80123a:	6a 00                	push   $0x0
  80123c:	6a 00                	push   $0x0
  80123e:	6a 00                	push   $0x0
  801240:	6a 0d                	push   $0xd
  801242:	e8 4e fe ff ff       	call   801095 <syscall>
  801247:	83 c4 18             	add    $0x18,%esp
}
  80124a:	c9                   	leave  
  80124b:	c3                   	ret    

0080124c <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80124c:	55                   	push   %ebp
  80124d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80124f:	6a 00                	push   $0x0
  801251:	6a 00                	push   $0x0
  801253:	6a 00                	push   $0x0
  801255:	ff 75 0c             	pushl  0xc(%ebp)
  801258:	ff 75 08             	pushl  0x8(%ebp)
  80125b:	6a 11                	push   $0x11
  80125d:	e8 33 fe ff ff       	call   801095 <syscall>
  801262:	83 c4 18             	add    $0x18,%esp
	return;
  801265:	90                   	nop
}
  801266:	c9                   	leave  
  801267:	c3                   	ret    

00801268 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801268:	55                   	push   %ebp
  801269:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80126b:	6a 00                	push   $0x0
  80126d:	6a 00                	push   $0x0
  80126f:	6a 00                	push   $0x0
  801271:	ff 75 0c             	pushl  0xc(%ebp)
  801274:	ff 75 08             	pushl  0x8(%ebp)
  801277:	6a 12                	push   $0x12
  801279:	e8 17 fe ff ff       	call   801095 <syscall>
  80127e:	83 c4 18             	add    $0x18,%esp
	return ;
  801281:	90                   	nop
}
  801282:	c9                   	leave  
  801283:	c3                   	ret    

00801284 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801284:	55                   	push   %ebp
  801285:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801287:	6a 00                	push   $0x0
  801289:	6a 00                	push   $0x0
  80128b:	6a 00                	push   $0x0
  80128d:	6a 00                	push   $0x0
  80128f:	6a 00                	push   $0x0
  801291:	6a 0e                	push   $0xe
  801293:	e8 fd fd ff ff       	call   801095 <syscall>
  801298:	83 c4 18             	add    $0x18,%esp
}
  80129b:	c9                   	leave  
  80129c:	c3                   	ret    

0080129d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80129d:	55                   	push   %ebp
  80129e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8012a0:	6a 00                	push   $0x0
  8012a2:	6a 00                	push   $0x0
  8012a4:	6a 00                	push   $0x0
  8012a6:	6a 00                	push   $0x0
  8012a8:	ff 75 08             	pushl  0x8(%ebp)
  8012ab:	6a 0f                	push   $0xf
  8012ad:	e8 e3 fd ff ff       	call   801095 <syscall>
  8012b2:	83 c4 18             	add    $0x18,%esp
}
  8012b5:	c9                   	leave  
  8012b6:	c3                   	ret    

008012b7 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8012b7:	55                   	push   %ebp
  8012b8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8012ba:	6a 00                	push   $0x0
  8012bc:	6a 00                	push   $0x0
  8012be:	6a 00                	push   $0x0
  8012c0:	6a 00                	push   $0x0
  8012c2:	6a 00                	push   $0x0
  8012c4:	6a 10                	push   $0x10
  8012c6:	e8 ca fd ff ff       	call   801095 <syscall>
  8012cb:	83 c4 18             	add    $0x18,%esp
}
  8012ce:	90                   	nop
  8012cf:	c9                   	leave  
  8012d0:	c3                   	ret    

008012d1 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8012d1:	55                   	push   %ebp
  8012d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8012d4:	6a 00                	push   $0x0
  8012d6:	6a 00                	push   $0x0
  8012d8:	6a 00                	push   $0x0
  8012da:	6a 00                	push   $0x0
  8012dc:	6a 00                	push   $0x0
  8012de:	6a 14                	push   $0x14
  8012e0:	e8 b0 fd ff ff       	call   801095 <syscall>
  8012e5:	83 c4 18             	add    $0x18,%esp
}
  8012e8:	90                   	nop
  8012e9:	c9                   	leave  
  8012ea:	c3                   	ret    

008012eb <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8012eb:	55                   	push   %ebp
  8012ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8012ee:	6a 00                	push   $0x0
  8012f0:	6a 00                	push   $0x0
  8012f2:	6a 00                	push   $0x0
  8012f4:	6a 00                	push   $0x0
  8012f6:	6a 00                	push   $0x0
  8012f8:	6a 15                	push   $0x15
  8012fa:	e8 96 fd ff ff       	call   801095 <syscall>
  8012ff:	83 c4 18             	add    $0x18,%esp
}
  801302:	90                   	nop
  801303:	c9                   	leave  
  801304:	c3                   	ret    

00801305 <sys_cputc>:


void
sys_cputc(const char c)
{
  801305:	55                   	push   %ebp
  801306:	89 e5                	mov    %esp,%ebp
  801308:	83 ec 04             	sub    $0x4,%esp
  80130b:	8b 45 08             	mov    0x8(%ebp),%eax
  80130e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801311:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801315:	6a 00                	push   $0x0
  801317:	6a 00                	push   $0x0
  801319:	6a 00                	push   $0x0
  80131b:	6a 00                	push   $0x0
  80131d:	50                   	push   %eax
  80131e:	6a 16                	push   $0x16
  801320:	e8 70 fd ff ff       	call   801095 <syscall>
  801325:	83 c4 18             	add    $0x18,%esp
}
  801328:	90                   	nop
  801329:	c9                   	leave  
  80132a:	c3                   	ret    

0080132b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80132b:	55                   	push   %ebp
  80132c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80132e:	6a 00                	push   $0x0
  801330:	6a 00                	push   $0x0
  801332:	6a 00                	push   $0x0
  801334:	6a 00                	push   $0x0
  801336:	6a 00                	push   $0x0
  801338:	6a 17                	push   $0x17
  80133a:	e8 56 fd ff ff       	call   801095 <syscall>
  80133f:	83 c4 18             	add    $0x18,%esp
}
  801342:	90                   	nop
  801343:	c9                   	leave  
  801344:	c3                   	ret    

00801345 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801345:	55                   	push   %ebp
  801346:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801348:	8b 45 08             	mov    0x8(%ebp),%eax
  80134b:	6a 00                	push   $0x0
  80134d:	6a 00                	push   $0x0
  80134f:	6a 00                	push   $0x0
  801351:	ff 75 0c             	pushl  0xc(%ebp)
  801354:	50                   	push   %eax
  801355:	6a 18                	push   $0x18
  801357:	e8 39 fd ff ff       	call   801095 <syscall>
  80135c:	83 c4 18             	add    $0x18,%esp
}
  80135f:	c9                   	leave  
  801360:	c3                   	ret    

00801361 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801361:	55                   	push   %ebp
  801362:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801364:	8b 55 0c             	mov    0xc(%ebp),%edx
  801367:	8b 45 08             	mov    0x8(%ebp),%eax
  80136a:	6a 00                	push   $0x0
  80136c:	6a 00                	push   $0x0
  80136e:	6a 00                	push   $0x0
  801370:	52                   	push   %edx
  801371:	50                   	push   %eax
  801372:	6a 1b                	push   $0x1b
  801374:	e8 1c fd ff ff       	call   801095 <syscall>
  801379:	83 c4 18             	add    $0x18,%esp
}
  80137c:	c9                   	leave  
  80137d:	c3                   	ret    

0080137e <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80137e:	55                   	push   %ebp
  80137f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801381:	8b 55 0c             	mov    0xc(%ebp),%edx
  801384:	8b 45 08             	mov    0x8(%ebp),%eax
  801387:	6a 00                	push   $0x0
  801389:	6a 00                	push   $0x0
  80138b:	6a 00                	push   $0x0
  80138d:	52                   	push   %edx
  80138e:	50                   	push   %eax
  80138f:	6a 19                	push   $0x19
  801391:	e8 ff fc ff ff       	call   801095 <syscall>
  801396:	83 c4 18             	add    $0x18,%esp
}
  801399:	90                   	nop
  80139a:	c9                   	leave  
  80139b:	c3                   	ret    

0080139c <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80139c:	55                   	push   %ebp
  80139d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80139f:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a5:	6a 00                	push   $0x0
  8013a7:	6a 00                	push   $0x0
  8013a9:	6a 00                	push   $0x0
  8013ab:	52                   	push   %edx
  8013ac:	50                   	push   %eax
  8013ad:	6a 1a                	push   $0x1a
  8013af:	e8 e1 fc ff ff       	call   801095 <syscall>
  8013b4:	83 c4 18             	add    $0x18,%esp
}
  8013b7:	90                   	nop
  8013b8:	c9                   	leave  
  8013b9:	c3                   	ret    

008013ba <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8013ba:	55                   	push   %ebp
  8013bb:	89 e5                	mov    %esp,%ebp
  8013bd:	83 ec 04             	sub    $0x4,%esp
  8013c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8013c3:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8013c6:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8013c9:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8013cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d0:	6a 00                	push   $0x0
  8013d2:	51                   	push   %ecx
  8013d3:	52                   	push   %edx
  8013d4:	ff 75 0c             	pushl  0xc(%ebp)
  8013d7:	50                   	push   %eax
  8013d8:	6a 1c                	push   $0x1c
  8013da:	e8 b6 fc ff ff       	call   801095 <syscall>
  8013df:	83 c4 18             	add    $0x18,%esp
}
  8013e2:	c9                   	leave  
  8013e3:	c3                   	ret    

008013e4 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8013e4:	55                   	push   %ebp
  8013e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8013e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 00                	push   $0x0
  8013f1:	6a 00                	push   $0x0
  8013f3:	52                   	push   %edx
  8013f4:	50                   	push   %eax
  8013f5:	6a 1d                	push   $0x1d
  8013f7:	e8 99 fc ff ff       	call   801095 <syscall>
  8013fc:	83 c4 18             	add    $0x18,%esp
}
  8013ff:	c9                   	leave  
  801400:	c3                   	ret    

00801401 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801401:	55                   	push   %ebp
  801402:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801404:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801407:	8b 55 0c             	mov    0xc(%ebp),%edx
  80140a:	8b 45 08             	mov    0x8(%ebp),%eax
  80140d:	6a 00                	push   $0x0
  80140f:	6a 00                	push   $0x0
  801411:	51                   	push   %ecx
  801412:	52                   	push   %edx
  801413:	50                   	push   %eax
  801414:	6a 1e                	push   $0x1e
  801416:	e8 7a fc ff ff       	call   801095 <syscall>
  80141b:	83 c4 18             	add    $0x18,%esp
}
  80141e:	c9                   	leave  
  80141f:	c3                   	ret    

00801420 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801420:	55                   	push   %ebp
  801421:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801423:	8b 55 0c             	mov    0xc(%ebp),%edx
  801426:	8b 45 08             	mov    0x8(%ebp),%eax
  801429:	6a 00                	push   $0x0
  80142b:	6a 00                	push   $0x0
  80142d:	6a 00                	push   $0x0
  80142f:	52                   	push   %edx
  801430:	50                   	push   %eax
  801431:	6a 1f                	push   $0x1f
  801433:	e8 5d fc ff ff       	call   801095 <syscall>
  801438:	83 c4 18             	add    $0x18,%esp
}
  80143b:	c9                   	leave  
  80143c:	c3                   	ret    

0080143d <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80143d:	55                   	push   %ebp
  80143e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801440:	6a 00                	push   $0x0
  801442:	6a 00                	push   $0x0
  801444:	6a 00                	push   $0x0
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	6a 20                	push   $0x20
  80144c:	e8 44 fc ff ff       	call   801095 <syscall>
  801451:	83 c4 18             	add    $0x18,%esp
}
  801454:	c9                   	leave  
  801455:	c3                   	ret    

00801456 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801456:	55                   	push   %ebp
  801457:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801459:	8b 45 08             	mov    0x8(%ebp),%eax
  80145c:	6a 00                	push   $0x0
  80145e:	ff 75 14             	pushl  0x14(%ebp)
  801461:	ff 75 10             	pushl  0x10(%ebp)
  801464:	ff 75 0c             	pushl  0xc(%ebp)
  801467:	50                   	push   %eax
  801468:	6a 21                	push   $0x21
  80146a:	e8 26 fc ff ff       	call   801095 <syscall>
  80146f:	83 c4 18             	add    $0x18,%esp
}
  801472:	c9                   	leave  
  801473:	c3                   	ret    

00801474 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801474:	55                   	push   %ebp
  801475:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801477:	8b 45 08             	mov    0x8(%ebp),%eax
  80147a:	6a 00                	push   $0x0
  80147c:	6a 00                	push   $0x0
  80147e:	6a 00                	push   $0x0
  801480:	6a 00                	push   $0x0
  801482:	50                   	push   %eax
  801483:	6a 22                	push   $0x22
  801485:	e8 0b fc ff ff       	call   801095 <syscall>
  80148a:	83 c4 18             	add    $0x18,%esp
}
  80148d:	90                   	nop
  80148e:	c9                   	leave  
  80148f:	c3                   	ret    

00801490 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801490:	55                   	push   %ebp
  801491:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801493:	8b 45 08             	mov    0x8(%ebp),%eax
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	6a 00                	push   $0x0
  80149c:	6a 00                	push   $0x0
  80149e:	50                   	push   %eax
  80149f:	6a 23                	push   $0x23
  8014a1:	e8 ef fb ff ff       	call   801095 <syscall>
  8014a6:	83 c4 18             	add    $0x18,%esp
}
  8014a9:	90                   	nop
  8014aa:	c9                   	leave  
  8014ab:	c3                   	ret    

008014ac <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8014ac:	55                   	push   %ebp
  8014ad:	89 e5                	mov    %esp,%ebp
  8014af:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8014b2:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8014b5:	8d 50 04             	lea    0x4(%eax),%edx
  8014b8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	6a 00                	push   $0x0
  8014c1:	52                   	push   %edx
  8014c2:	50                   	push   %eax
  8014c3:	6a 24                	push   $0x24
  8014c5:	e8 cb fb ff ff       	call   801095 <syscall>
  8014ca:	83 c4 18             	add    $0x18,%esp
	return result;
  8014cd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014d6:	89 01                	mov    %eax,(%ecx)
  8014d8:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8014db:	8b 45 08             	mov    0x8(%ebp),%eax
  8014de:	c9                   	leave  
  8014df:	c2 04 00             	ret    $0x4

008014e2 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8014e2:	55                   	push   %ebp
  8014e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	ff 75 10             	pushl  0x10(%ebp)
  8014ec:	ff 75 0c             	pushl  0xc(%ebp)
  8014ef:	ff 75 08             	pushl  0x8(%ebp)
  8014f2:	6a 13                	push   $0x13
  8014f4:	e8 9c fb ff ff       	call   801095 <syscall>
  8014f9:	83 c4 18             	add    $0x18,%esp
	return ;
  8014fc:	90                   	nop
}
  8014fd:	c9                   	leave  
  8014fe:	c3                   	ret    

008014ff <sys_rcr2>:
uint32 sys_rcr2()
{
  8014ff:	55                   	push   %ebp
  801500:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801502:	6a 00                	push   $0x0
  801504:	6a 00                	push   $0x0
  801506:	6a 00                	push   $0x0
  801508:	6a 00                	push   $0x0
  80150a:	6a 00                	push   $0x0
  80150c:	6a 25                	push   $0x25
  80150e:	e8 82 fb ff ff       	call   801095 <syscall>
  801513:	83 c4 18             	add    $0x18,%esp
}
  801516:	c9                   	leave  
  801517:	c3                   	ret    

00801518 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801518:	55                   	push   %ebp
  801519:	89 e5                	mov    %esp,%ebp
  80151b:	83 ec 04             	sub    $0x4,%esp
  80151e:	8b 45 08             	mov    0x8(%ebp),%eax
  801521:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801524:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801528:	6a 00                	push   $0x0
  80152a:	6a 00                	push   $0x0
  80152c:	6a 00                	push   $0x0
  80152e:	6a 00                	push   $0x0
  801530:	50                   	push   %eax
  801531:	6a 26                	push   $0x26
  801533:	e8 5d fb ff ff       	call   801095 <syscall>
  801538:	83 c4 18             	add    $0x18,%esp
	return ;
  80153b:	90                   	nop
}
  80153c:	c9                   	leave  
  80153d:	c3                   	ret    

0080153e <rsttst>:
void rsttst()
{
  80153e:	55                   	push   %ebp
  80153f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	6a 00                	push   $0x0
  801547:	6a 00                	push   $0x0
  801549:	6a 00                	push   $0x0
  80154b:	6a 28                	push   $0x28
  80154d:	e8 43 fb ff ff       	call   801095 <syscall>
  801552:	83 c4 18             	add    $0x18,%esp
	return ;
  801555:	90                   	nop
}
  801556:	c9                   	leave  
  801557:	c3                   	ret    

00801558 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801558:	55                   	push   %ebp
  801559:	89 e5                	mov    %esp,%ebp
  80155b:	83 ec 04             	sub    $0x4,%esp
  80155e:	8b 45 14             	mov    0x14(%ebp),%eax
  801561:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801564:	8b 55 18             	mov    0x18(%ebp),%edx
  801567:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80156b:	52                   	push   %edx
  80156c:	50                   	push   %eax
  80156d:	ff 75 10             	pushl  0x10(%ebp)
  801570:	ff 75 0c             	pushl  0xc(%ebp)
  801573:	ff 75 08             	pushl  0x8(%ebp)
  801576:	6a 27                	push   $0x27
  801578:	e8 18 fb ff ff       	call   801095 <syscall>
  80157d:	83 c4 18             	add    $0x18,%esp
	return ;
  801580:	90                   	nop
}
  801581:	c9                   	leave  
  801582:	c3                   	ret    

00801583 <chktst>:
void chktst(uint32 n)
{
  801583:	55                   	push   %ebp
  801584:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801586:	6a 00                	push   $0x0
  801588:	6a 00                	push   $0x0
  80158a:	6a 00                	push   $0x0
  80158c:	6a 00                	push   $0x0
  80158e:	ff 75 08             	pushl  0x8(%ebp)
  801591:	6a 29                	push   $0x29
  801593:	e8 fd fa ff ff       	call   801095 <syscall>
  801598:	83 c4 18             	add    $0x18,%esp
	return ;
  80159b:	90                   	nop
}
  80159c:	c9                   	leave  
  80159d:	c3                   	ret    

0080159e <inctst>:

void inctst()
{
  80159e:	55                   	push   %ebp
  80159f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 00                	push   $0x0
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 2a                	push   $0x2a
  8015ad:	e8 e3 fa ff ff       	call   801095 <syscall>
  8015b2:	83 c4 18             	add    $0x18,%esp
	return ;
  8015b5:	90                   	nop
}
  8015b6:	c9                   	leave  
  8015b7:	c3                   	ret    

008015b8 <gettst>:
uint32 gettst()
{
  8015b8:	55                   	push   %ebp
  8015b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 2b                	push   $0x2b
  8015c7:	e8 c9 fa ff ff       	call   801095 <syscall>
  8015cc:	83 c4 18             	add    $0x18,%esp
}
  8015cf:	c9                   	leave  
  8015d0:	c3                   	ret    

008015d1 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8015d1:	55                   	push   %ebp
  8015d2:	89 e5                	mov    %esp,%ebp
  8015d4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015d7:	6a 00                	push   $0x0
  8015d9:	6a 00                	push   $0x0
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 2c                	push   $0x2c
  8015e3:	e8 ad fa ff ff       	call   801095 <syscall>
  8015e8:	83 c4 18             	add    $0x18,%esp
  8015eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8015ee:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8015f2:	75 07                	jne    8015fb <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8015f4:	b8 01 00 00 00       	mov    $0x1,%eax
  8015f9:	eb 05                	jmp    801600 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8015fb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801600:	c9                   	leave  
  801601:	c3                   	ret    

00801602 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801602:	55                   	push   %ebp
  801603:	89 e5                	mov    %esp,%ebp
  801605:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801608:	6a 00                	push   $0x0
  80160a:	6a 00                	push   $0x0
  80160c:	6a 00                	push   $0x0
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 2c                	push   $0x2c
  801614:	e8 7c fa ff ff       	call   801095 <syscall>
  801619:	83 c4 18             	add    $0x18,%esp
  80161c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80161f:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801623:	75 07                	jne    80162c <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801625:	b8 01 00 00 00       	mov    $0x1,%eax
  80162a:	eb 05                	jmp    801631 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80162c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801631:	c9                   	leave  
  801632:	c3                   	ret    

00801633 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801633:	55                   	push   %ebp
  801634:	89 e5                	mov    %esp,%ebp
  801636:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	6a 00                	push   $0x0
  801643:	6a 2c                	push   $0x2c
  801645:	e8 4b fa ff ff       	call   801095 <syscall>
  80164a:	83 c4 18             	add    $0x18,%esp
  80164d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801650:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801654:	75 07                	jne    80165d <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801656:	b8 01 00 00 00       	mov    $0x1,%eax
  80165b:	eb 05                	jmp    801662 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80165d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801662:	c9                   	leave  
  801663:	c3                   	ret    

00801664 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801664:	55                   	push   %ebp
  801665:	89 e5                	mov    %esp,%ebp
  801667:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80166a:	6a 00                	push   $0x0
  80166c:	6a 00                	push   $0x0
  80166e:	6a 00                	push   $0x0
  801670:	6a 00                	push   $0x0
  801672:	6a 00                	push   $0x0
  801674:	6a 2c                	push   $0x2c
  801676:	e8 1a fa ff ff       	call   801095 <syscall>
  80167b:	83 c4 18             	add    $0x18,%esp
  80167e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801681:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801685:	75 07                	jne    80168e <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801687:	b8 01 00 00 00       	mov    $0x1,%eax
  80168c:	eb 05                	jmp    801693 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80168e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801693:	c9                   	leave  
  801694:	c3                   	ret    

00801695 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801695:	55                   	push   %ebp
  801696:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801698:	6a 00                	push   $0x0
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	6a 00                	push   $0x0
  8016a0:	ff 75 08             	pushl  0x8(%ebp)
  8016a3:	6a 2d                	push   $0x2d
  8016a5:	e8 eb f9 ff ff       	call   801095 <syscall>
  8016aa:	83 c4 18             	add    $0x18,%esp
	return ;
  8016ad:	90                   	nop
}
  8016ae:	c9                   	leave  
  8016af:	c3                   	ret    

008016b0 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8016b0:	55                   	push   %ebp
  8016b1:	89 e5                	mov    %esp,%ebp
  8016b3:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8016b4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016ba:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c0:	6a 00                	push   $0x0
  8016c2:	53                   	push   %ebx
  8016c3:	51                   	push   %ecx
  8016c4:	52                   	push   %edx
  8016c5:	50                   	push   %eax
  8016c6:	6a 2e                	push   $0x2e
  8016c8:	e8 c8 f9 ff ff       	call   801095 <syscall>
  8016cd:	83 c4 18             	add    $0x18,%esp
}
  8016d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8016d3:	c9                   	leave  
  8016d4:	c3                   	ret    

008016d5 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8016d5:	55                   	push   %ebp
  8016d6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8016d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016db:	8b 45 08             	mov    0x8(%ebp),%eax
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	52                   	push   %edx
  8016e5:	50                   	push   %eax
  8016e6:	6a 2f                	push   $0x2f
  8016e8:	e8 a8 f9 ff ff       	call   801095 <syscall>
  8016ed:	83 c4 18             	add    $0x18,%esp
}
  8016f0:	c9                   	leave  
  8016f1:	c3                   	ret    

008016f2 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8016f2:	55                   	push   %ebp
  8016f3:	89 e5                	mov    %esp,%ebp
  8016f5:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8016f8:	8b 55 08             	mov    0x8(%ebp),%edx
  8016fb:	89 d0                	mov    %edx,%eax
  8016fd:	c1 e0 02             	shl    $0x2,%eax
  801700:	01 d0                	add    %edx,%eax
  801702:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801709:	01 d0                	add    %edx,%eax
  80170b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801712:	01 d0                	add    %edx,%eax
  801714:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80171b:	01 d0                	add    %edx,%eax
  80171d:	c1 e0 04             	shl    $0x4,%eax
  801720:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801723:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  80172a:	8d 45 e8             	lea    -0x18(%ebp),%eax
  80172d:	83 ec 0c             	sub    $0xc,%esp
  801730:	50                   	push   %eax
  801731:	e8 76 fd ff ff       	call   8014ac <sys_get_virtual_time>
  801736:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801739:	eb 41                	jmp    80177c <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  80173b:	8d 45 e0             	lea    -0x20(%ebp),%eax
  80173e:	83 ec 0c             	sub    $0xc,%esp
  801741:	50                   	push   %eax
  801742:	e8 65 fd ff ff       	call   8014ac <sys_get_virtual_time>
  801747:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  80174a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80174d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801750:	29 c2                	sub    %eax,%edx
  801752:	89 d0                	mov    %edx,%eax
  801754:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801757:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80175a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80175d:	89 d1                	mov    %edx,%ecx
  80175f:	29 c1                	sub    %eax,%ecx
  801761:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801764:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801767:	39 c2                	cmp    %eax,%edx
  801769:	0f 97 c0             	seta   %al
  80176c:	0f b6 c0             	movzbl %al,%eax
  80176f:	29 c1                	sub    %eax,%ecx
  801771:	89 c8                	mov    %ecx,%eax
  801773:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801776:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801779:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  80177c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80177f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801782:	72 b7                	jb     80173b <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801784:	90                   	nop
  801785:	c9                   	leave  
  801786:	c3                   	ret    

00801787 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801787:	55                   	push   %ebp
  801788:	89 e5                	mov    %esp,%ebp
  80178a:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80178d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801794:	eb 03                	jmp    801799 <busy_wait+0x12>
  801796:	ff 45 fc             	incl   -0x4(%ebp)
  801799:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80179c:	3b 45 08             	cmp    0x8(%ebp),%eax
  80179f:	72 f5                	jb     801796 <busy_wait+0xf>
	return i;
  8017a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8017a4:	c9                   	leave  
  8017a5:	c3                   	ret    
  8017a6:	66 90                	xchg   %ax,%ax

008017a8 <__udivdi3>:
  8017a8:	55                   	push   %ebp
  8017a9:	57                   	push   %edi
  8017aa:	56                   	push   %esi
  8017ab:	53                   	push   %ebx
  8017ac:	83 ec 1c             	sub    $0x1c,%esp
  8017af:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8017b3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8017b7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017bb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8017bf:	89 ca                	mov    %ecx,%edx
  8017c1:	89 f8                	mov    %edi,%eax
  8017c3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8017c7:	85 f6                	test   %esi,%esi
  8017c9:	75 2d                	jne    8017f8 <__udivdi3+0x50>
  8017cb:	39 cf                	cmp    %ecx,%edi
  8017cd:	77 65                	ja     801834 <__udivdi3+0x8c>
  8017cf:	89 fd                	mov    %edi,%ebp
  8017d1:	85 ff                	test   %edi,%edi
  8017d3:	75 0b                	jne    8017e0 <__udivdi3+0x38>
  8017d5:	b8 01 00 00 00       	mov    $0x1,%eax
  8017da:	31 d2                	xor    %edx,%edx
  8017dc:	f7 f7                	div    %edi
  8017de:	89 c5                	mov    %eax,%ebp
  8017e0:	31 d2                	xor    %edx,%edx
  8017e2:	89 c8                	mov    %ecx,%eax
  8017e4:	f7 f5                	div    %ebp
  8017e6:	89 c1                	mov    %eax,%ecx
  8017e8:	89 d8                	mov    %ebx,%eax
  8017ea:	f7 f5                	div    %ebp
  8017ec:	89 cf                	mov    %ecx,%edi
  8017ee:	89 fa                	mov    %edi,%edx
  8017f0:	83 c4 1c             	add    $0x1c,%esp
  8017f3:	5b                   	pop    %ebx
  8017f4:	5e                   	pop    %esi
  8017f5:	5f                   	pop    %edi
  8017f6:	5d                   	pop    %ebp
  8017f7:	c3                   	ret    
  8017f8:	39 ce                	cmp    %ecx,%esi
  8017fa:	77 28                	ja     801824 <__udivdi3+0x7c>
  8017fc:	0f bd fe             	bsr    %esi,%edi
  8017ff:	83 f7 1f             	xor    $0x1f,%edi
  801802:	75 40                	jne    801844 <__udivdi3+0x9c>
  801804:	39 ce                	cmp    %ecx,%esi
  801806:	72 0a                	jb     801812 <__udivdi3+0x6a>
  801808:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80180c:	0f 87 9e 00 00 00    	ja     8018b0 <__udivdi3+0x108>
  801812:	b8 01 00 00 00       	mov    $0x1,%eax
  801817:	89 fa                	mov    %edi,%edx
  801819:	83 c4 1c             	add    $0x1c,%esp
  80181c:	5b                   	pop    %ebx
  80181d:	5e                   	pop    %esi
  80181e:	5f                   	pop    %edi
  80181f:	5d                   	pop    %ebp
  801820:	c3                   	ret    
  801821:	8d 76 00             	lea    0x0(%esi),%esi
  801824:	31 ff                	xor    %edi,%edi
  801826:	31 c0                	xor    %eax,%eax
  801828:	89 fa                	mov    %edi,%edx
  80182a:	83 c4 1c             	add    $0x1c,%esp
  80182d:	5b                   	pop    %ebx
  80182e:	5e                   	pop    %esi
  80182f:	5f                   	pop    %edi
  801830:	5d                   	pop    %ebp
  801831:	c3                   	ret    
  801832:	66 90                	xchg   %ax,%ax
  801834:	89 d8                	mov    %ebx,%eax
  801836:	f7 f7                	div    %edi
  801838:	31 ff                	xor    %edi,%edi
  80183a:	89 fa                	mov    %edi,%edx
  80183c:	83 c4 1c             	add    $0x1c,%esp
  80183f:	5b                   	pop    %ebx
  801840:	5e                   	pop    %esi
  801841:	5f                   	pop    %edi
  801842:	5d                   	pop    %ebp
  801843:	c3                   	ret    
  801844:	bd 20 00 00 00       	mov    $0x20,%ebp
  801849:	89 eb                	mov    %ebp,%ebx
  80184b:	29 fb                	sub    %edi,%ebx
  80184d:	89 f9                	mov    %edi,%ecx
  80184f:	d3 e6                	shl    %cl,%esi
  801851:	89 c5                	mov    %eax,%ebp
  801853:	88 d9                	mov    %bl,%cl
  801855:	d3 ed                	shr    %cl,%ebp
  801857:	89 e9                	mov    %ebp,%ecx
  801859:	09 f1                	or     %esi,%ecx
  80185b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80185f:	89 f9                	mov    %edi,%ecx
  801861:	d3 e0                	shl    %cl,%eax
  801863:	89 c5                	mov    %eax,%ebp
  801865:	89 d6                	mov    %edx,%esi
  801867:	88 d9                	mov    %bl,%cl
  801869:	d3 ee                	shr    %cl,%esi
  80186b:	89 f9                	mov    %edi,%ecx
  80186d:	d3 e2                	shl    %cl,%edx
  80186f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801873:	88 d9                	mov    %bl,%cl
  801875:	d3 e8                	shr    %cl,%eax
  801877:	09 c2                	or     %eax,%edx
  801879:	89 d0                	mov    %edx,%eax
  80187b:	89 f2                	mov    %esi,%edx
  80187d:	f7 74 24 0c          	divl   0xc(%esp)
  801881:	89 d6                	mov    %edx,%esi
  801883:	89 c3                	mov    %eax,%ebx
  801885:	f7 e5                	mul    %ebp
  801887:	39 d6                	cmp    %edx,%esi
  801889:	72 19                	jb     8018a4 <__udivdi3+0xfc>
  80188b:	74 0b                	je     801898 <__udivdi3+0xf0>
  80188d:	89 d8                	mov    %ebx,%eax
  80188f:	31 ff                	xor    %edi,%edi
  801891:	e9 58 ff ff ff       	jmp    8017ee <__udivdi3+0x46>
  801896:	66 90                	xchg   %ax,%ax
  801898:	8b 54 24 08          	mov    0x8(%esp),%edx
  80189c:	89 f9                	mov    %edi,%ecx
  80189e:	d3 e2                	shl    %cl,%edx
  8018a0:	39 c2                	cmp    %eax,%edx
  8018a2:	73 e9                	jae    80188d <__udivdi3+0xe5>
  8018a4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8018a7:	31 ff                	xor    %edi,%edi
  8018a9:	e9 40 ff ff ff       	jmp    8017ee <__udivdi3+0x46>
  8018ae:	66 90                	xchg   %ax,%ax
  8018b0:	31 c0                	xor    %eax,%eax
  8018b2:	e9 37 ff ff ff       	jmp    8017ee <__udivdi3+0x46>
  8018b7:	90                   	nop

008018b8 <__umoddi3>:
  8018b8:	55                   	push   %ebp
  8018b9:	57                   	push   %edi
  8018ba:	56                   	push   %esi
  8018bb:	53                   	push   %ebx
  8018bc:	83 ec 1c             	sub    $0x1c,%esp
  8018bf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8018c3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8018c7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8018cb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8018cf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8018d3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8018d7:	89 f3                	mov    %esi,%ebx
  8018d9:	89 fa                	mov    %edi,%edx
  8018db:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018df:	89 34 24             	mov    %esi,(%esp)
  8018e2:	85 c0                	test   %eax,%eax
  8018e4:	75 1a                	jne    801900 <__umoddi3+0x48>
  8018e6:	39 f7                	cmp    %esi,%edi
  8018e8:	0f 86 a2 00 00 00    	jbe    801990 <__umoddi3+0xd8>
  8018ee:	89 c8                	mov    %ecx,%eax
  8018f0:	89 f2                	mov    %esi,%edx
  8018f2:	f7 f7                	div    %edi
  8018f4:	89 d0                	mov    %edx,%eax
  8018f6:	31 d2                	xor    %edx,%edx
  8018f8:	83 c4 1c             	add    $0x1c,%esp
  8018fb:	5b                   	pop    %ebx
  8018fc:	5e                   	pop    %esi
  8018fd:	5f                   	pop    %edi
  8018fe:	5d                   	pop    %ebp
  8018ff:	c3                   	ret    
  801900:	39 f0                	cmp    %esi,%eax
  801902:	0f 87 ac 00 00 00    	ja     8019b4 <__umoddi3+0xfc>
  801908:	0f bd e8             	bsr    %eax,%ebp
  80190b:	83 f5 1f             	xor    $0x1f,%ebp
  80190e:	0f 84 ac 00 00 00    	je     8019c0 <__umoddi3+0x108>
  801914:	bf 20 00 00 00       	mov    $0x20,%edi
  801919:	29 ef                	sub    %ebp,%edi
  80191b:	89 fe                	mov    %edi,%esi
  80191d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801921:	89 e9                	mov    %ebp,%ecx
  801923:	d3 e0                	shl    %cl,%eax
  801925:	89 d7                	mov    %edx,%edi
  801927:	89 f1                	mov    %esi,%ecx
  801929:	d3 ef                	shr    %cl,%edi
  80192b:	09 c7                	or     %eax,%edi
  80192d:	89 e9                	mov    %ebp,%ecx
  80192f:	d3 e2                	shl    %cl,%edx
  801931:	89 14 24             	mov    %edx,(%esp)
  801934:	89 d8                	mov    %ebx,%eax
  801936:	d3 e0                	shl    %cl,%eax
  801938:	89 c2                	mov    %eax,%edx
  80193a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80193e:	d3 e0                	shl    %cl,%eax
  801940:	89 44 24 04          	mov    %eax,0x4(%esp)
  801944:	8b 44 24 08          	mov    0x8(%esp),%eax
  801948:	89 f1                	mov    %esi,%ecx
  80194a:	d3 e8                	shr    %cl,%eax
  80194c:	09 d0                	or     %edx,%eax
  80194e:	d3 eb                	shr    %cl,%ebx
  801950:	89 da                	mov    %ebx,%edx
  801952:	f7 f7                	div    %edi
  801954:	89 d3                	mov    %edx,%ebx
  801956:	f7 24 24             	mull   (%esp)
  801959:	89 c6                	mov    %eax,%esi
  80195b:	89 d1                	mov    %edx,%ecx
  80195d:	39 d3                	cmp    %edx,%ebx
  80195f:	0f 82 87 00 00 00    	jb     8019ec <__umoddi3+0x134>
  801965:	0f 84 91 00 00 00    	je     8019fc <__umoddi3+0x144>
  80196b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80196f:	29 f2                	sub    %esi,%edx
  801971:	19 cb                	sbb    %ecx,%ebx
  801973:	89 d8                	mov    %ebx,%eax
  801975:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801979:	d3 e0                	shl    %cl,%eax
  80197b:	89 e9                	mov    %ebp,%ecx
  80197d:	d3 ea                	shr    %cl,%edx
  80197f:	09 d0                	or     %edx,%eax
  801981:	89 e9                	mov    %ebp,%ecx
  801983:	d3 eb                	shr    %cl,%ebx
  801985:	89 da                	mov    %ebx,%edx
  801987:	83 c4 1c             	add    $0x1c,%esp
  80198a:	5b                   	pop    %ebx
  80198b:	5e                   	pop    %esi
  80198c:	5f                   	pop    %edi
  80198d:	5d                   	pop    %ebp
  80198e:	c3                   	ret    
  80198f:	90                   	nop
  801990:	89 fd                	mov    %edi,%ebp
  801992:	85 ff                	test   %edi,%edi
  801994:	75 0b                	jne    8019a1 <__umoddi3+0xe9>
  801996:	b8 01 00 00 00       	mov    $0x1,%eax
  80199b:	31 d2                	xor    %edx,%edx
  80199d:	f7 f7                	div    %edi
  80199f:	89 c5                	mov    %eax,%ebp
  8019a1:	89 f0                	mov    %esi,%eax
  8019a3:	31 d2                	xor    %edx,%edx
  8019a5:	f7 f5                	div    %ebp
  8019a7:	89 c8                	mov    %ecx,%eax
  8019a9:	f7 f5                	div    %ebp
  8019ab:	89 d0                	mov    %edx,%eax
  8019ad:	e9 44 ff ff ff       	jmp    8018f6 <__umoddi3+0x3e>
  8019b2:	66 90                	xchg   %ax,%ax
  8019b4:	89 c8                	mov    %ecx,%eax
  8019b6:	89 f2                	mov    %esi,%edx
  8019b8:	83 c4 1c             	add    $0x1c,%esp
  8019bb:	5b                   	pop    %ebx
  8019bc:	5e                   	pop    %esi
  8019bd:	5f                   	pop    %edi
  8019be:	5d                   	pop    %ebp
  8019bf:	c3                   	ret    
  8019c0:	3b 04 24             	cmp    (%esp),%eax
  8019c3:	72 06                	jb     8019cb <__umoddi3+0x113>
  8019c5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8019c9:	77 0f                	ja     8019da <__umoddi3+0x122>
  8019cb:	89 f2                	mov    %esi,%edx
  8019cd:	29 f9                	sub    %edi,%ecx
  8019cf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8019d3:	89 14 24             	mov    %edx,(%esp)
  8019d6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8019da:	8b 44 24 04          	mov    0x4(%esp),%eax
  8019de:	8b 14 24             	mov    (%esp),%edx
  8019e1:	83 c4 1c             	add    $0x1c,%esp
  8019e4:	5b                   	pop    %ebx
  8019e5:	5e                   	pop    %esi
  8019e6:	5f                   	pop    %edi
  8019e7:	5d                   	pop    %ebp
  8019e8:	c3                   	ret    
  8019e9:	8d 76 00             	lea    0x0(%esi),%esi
  8019ec:	2b 04 24             	sub    (%esp),%eax
  8019ef:	19 fa                	sbb    %edi,%edx
  8019f1:	89 d1                	mov    %edx,%ecx
  8019f3:	89 c6                	mov    %eax,%esi
  8019f5:	e9 71 ff ff ff       	jmp    80196b <__umoddi3+0xb3>
  8019fa:	66 90                	xchg   %ax,%ax
  8019fc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801a00:	72 ea                	jb     8019ec <__umoddi3+0x134>
  801a02:	89 d9                	mov    %ebx,%ecx
  801a04:	e9 62 ff ff ff       	jmp    80196b <__umoddi3+0xb3>
