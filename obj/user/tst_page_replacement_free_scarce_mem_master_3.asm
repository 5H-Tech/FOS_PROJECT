
obj/user/tst_page_replacement_free_scarce_mem_master_3:     file format elf32-i386


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
  800031:	e8 56 01 00 00       	call   80018c <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	// For EXIT
	int ID = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  80003e:	a1 20 20 80 00       	mov    0x802020,%eax
  800043:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  800049:	a1 20 20 80 00       	mov    0x802020,%eax
  80004e:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800054:	89 c1                	mov    %eax,%ecx
  800056:	a1 20 20 80 00       	mov    0x802020,%eax
  80005b:	8b 40 74             	mov    0x74(%eax),%eax
  80005e:	52                   	push   %edx
  80005f:	51                   	push   %ecx
  800060:	50                   	push   %eax
  800061:	68 c0 1a 80 00       	push   $0x801ac0
  800066:	e8 85 14 00 00       	call   8014f0 <sys_create_env>
  80006b:	83 c4 10             	add    $0x10,%esp
  80006e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	sys_run_env(ID);
  800071:	83 ec 0c             	sub    $0xc,%esp
  800074:	ff 75 f0             	pushl  -0x10(%ebp)
  800077:	e8 92 14 00 00       	call   80150e <sys_run_env>
  80007c:	83 c4 10             	add    $0x10,%esp
	ID = sys_create_env("fos_add", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  80007f:	a1 20 20 80 00       	mov    0x802020,%eax
  800084:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  80008a:	a1 20 20 80 00       	mov    0x802020,%eax
  80008f:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800095:	89 c1                	mov    %eax,%ecx
  800097:	a1 20 20 80 00       	mov    0x802020,%eax
  80009c:	8b 40 74             	mov    0x74(%eax),%eax
  80009f:	52                   	push   %edx
  8000a0:	51                   	push   %ecx
  8000a1:	50                   	push   %eax
  8000a2:	68 cf 1a 80 00       	push   $0x801acf
  8000a7:	e8 44 14 00 00       	call   8014f0 <sys_create_env>
  8000ac:	83 c4 10             	add    $0x10,%esp
  8000af:	89 45 f0             	mov    %eax,-0x10(%ebp)
	sys_run_env(ID);
  8000b2:	83 ec 0c             	sub    $0xc,%esp
  8000b5:	ff 75 f0             	pushl  -0x10(%ebp)
  8000b8:	e8 51 14 00 00       	call   80150e <sys_run_env>
  8000bd:	83 c4 10             	add    $0x10,%esp
	//============

	for (int i = 0; i < 3; ++i) {
  8000c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000c7:	eb 44                	jmp    80010d <_main+0xd5>
			ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000c9:	a1 20 20 80 00       	mov    0x802020,%eax
  8000ce:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8000d4:	a1 20 20 80 00       	mov    0x802020,%eax
  8000d9:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000df:	89 c1                	mov    %eax,%ecx
  8000e1:	a1 20 20 80 00       	mov    0x802020,%eax
  8000e6:	8b 40 74             	mov    0x74(%eax),%eax
  8000e9:	52                   	push   %edx
  8000ea:	51                   	push   %ecx
  8000eb:	50                   	push   %eax
  8000ec:	68 d7 1a 80 00       	push   $0x801ad7
  8000f1:	e8 fa 13 00 00       	call   8014f0 <sys_create_env>
  8000f6:	83 c4 10             	add    $0x10,%esp
  8000f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
			sys_run_env(ID);
  8000fc:	83 ec 0c             	sub    $0xc,%esp
  8000ff:	ff 75 f0             	pushl  -0x10(%ebp)
  800102:	e8 07 14 00 00       	call   80150e <sys_run_env>
  800107:	83 c4 10             	add    $0x10,%esp
	sys_run_env(ID);
	ID = sys_create_env("fos_add", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
	sys_run_env(ID);
	//============

	for (int i = 0; i < 3; ++i) {
  80010a:	ff 45 f4             	incl   -0xc(%ebp)
  80010d:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
  800111:	7e b6                	jle    8000c9 <_main+0x91>
			ID = sys_create_env("dummy_process", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
			sys_run_env(ID);
		}
	env_sleep(10000);
  800113:	83 ec 0c             	sub    $0xc,%esp
  800116:	68 10 27 00 00       	push   $0x2710
  80011b:	e8 6c 16 00 00       	call   80178c <env_sleep>
  800120:	83 c4 10             	add    $0x10,%esp

	ID = sys_create_env("scarceMem3Slave_1", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  800123:	a1 20 20 80 00       	mov    0x802020,%eax
  800128:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  80012e:	a1 20 20 80 00       	mov    0x802020,%eax
  800133:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800139:	89 c1                	mov    %eax,%ecx
  80013b:	a1 20 20 80 00       	mov    0x802020,%eax
  800140:	8b 40 74             	mov    0x74(%eax),%eax
  800143:	52                   	push   %edx
  800144:	51                   	push   %ecx
  800145:	50                   	push   %eax
  800146:	68 e5 1a 80 00       	push   $0x801ae5
  80014b:	e8 a0 13 00 00       	call   8014f0 <sys_create_env>
  800150:	83 c4 10             	add    $0x10,%esp
  800153:	89 45 f0             	mov    %eax,-0x10(%ebp)
	sys_run_env(ID);
  800156:	83 ec 0c             	sub    $0xc,%esp
  800159:	ff 75 f0             	pushl  -0x10(%ebp)
  80015c:	e8 ad 13 00 00       	call   80150e <sys_run_env>
  800161:	83 c4 10             	add    $0x10,%esp

	// To wait till other queues filled with other processes
	env_sleep(10000);
  800164:	83 ec 0c             	sub    $0xc,%esp
  800167:	68 10 27 00 00       	push   $0x2710
  80016c:	e8 1b 16 00 00       	call   80178c <env_sleep>
  800171:	83 c4 10             	add    $0x10,%esp


	// To check that the slave environments completed successfully
	rsttst();
  800174:	e8 5f 14 00 00       	call   8015d8 <rsttst>

	env_sleep(200);
  800179:	83 ec 0c             	sub    $0xc,%esp
  80017c:	68 c8 00 00 00       	push   $0xc8
  800181:	e8 06 16 00 00       	call   80178c <env_sleep>
  800186:	83 c4 10             	add    $0x10,%esp
}
  800189:	90                   	nop
  80018a:	c9                   	leave  
  80018b:	c3                   	ret    

0080018c <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80018c:	55                   	push   %ebp
  80018d:	89 e5                	mov    %esp,%ebp
  80018f:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800192:	e8 39 10 00 00       	call   8011d0 <sys_getenvindex>
  800197:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80019a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80019d:	89 d0                	mov    %edx,%eax
  80019f:	c1 e0 03             	shl    $0x3,%eax
  8001a2:	01 d0                	add    %edx,%eax
  8001a4:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8001ab:	01 c8                	add    %ecx,%eax
  8001ad:	01 c0                	add    %eax,%eax
  8001af:	01 d0                	add    %edx,%eax
  8001b1:	01 c0                	add    %eax,%eax
  8001b3:	01 d0                	add    %edx,%eax
  8001b5:	89 c2                	mov    %eax,%edx
  8001b7:	c1 e2 05             	shl    $0x5,%edx
  8001ba:	29 c2                	sub    %eax,%edx
  8001bc:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8001c3:	89 c2                	mov    %eax,%edx
  8001c5:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8001cb:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001d0:	a1 20 20 80 00       	mov    0x802020,%eax
  8001d5:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8001db:	84 c0                	test   %al,%al
  8001dd:	74 0f                	je     8001ee <libmain+0x62>
		binaryname = myEnv->prog_name;
  8001df:	a1 20 20 80 00       	mov    0x802020,%eax
  8001e4:	05 40 3c 01 00       	add    $0x13c40,%eax
  8001e9:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8001ee:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8001f2:	7e 0a                	jle    8001fe <libmain+0x72>
		binaryname = argv[0];
  8001f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001f7:	8b 00                	mov    (%eax),%eax
  8001f9:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8001fe:	83 ec 08             	sub    $0x8,%esp
  800201:	ff 75 0c             	pushl  0xc(%ebp)
  800204:	ff 75 08             	pushl  0x8(%ebp)
  800207:	e8 2c fe ff ff       	call   800038 <_main>
  80020c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80020f:	e8 57 11 00 00       	call   80136b <sys_disable_interrupt>
	cprintf("**************************************\n");
  800214:	83 ec 0c             	sub    $0xc,%esp
  800217:	68 10 1b 80 00       	push   $0x801b10
  80021c:	e8 84 01 00 00       	call   8003a5 <cprintf>
  800221:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800224:	a1 20 20 80 00       	mov    0x802020,%eax
  800229:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80022f:	a1 20 20 80 00       	mov    0x802020,%eax
  800234:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80023a:	83 ec 04             	sub    $0x4,%esp
  80023d:	52                   	push   %edx
  80023e:	50                   	push   %eax
  80023f:	68 38 1b 80 00       	push   $0x801b38
  800244:	e8 5c 01 00 00       	call   8003a5 <cprintf>
  800249:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80024c:	a1 20 20 80 00       	mov    0x802020,%eax
  800251:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800257:	a1 20 20 80 00       	mov    0x802020,%eax
  80025c:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800262:	83 ec 04             	sub    $0x4,%esp
  800265:	52                   	push   %edx
  800266:	50                   	push   %eax
  800267:	68 60 1b 80 00       	push   $0x801b60
  80026c:	e8 34 01 00 00       	call   8003a5 <cprintf>
  800271:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800274:	a1 20 20 80 00       	mov    0x802020,%eax
  800279:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80027f:	83 ec 08             	sub    $0x8,%esp
  800282:	50                   	push   %eax
  800283:	68 a1 1b 80 00       	push   $0x801ba1
  800288:	e8 18 01 00 00       	call   8003a5 <cprintf>
  80028d:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800290:	83 ec 0c             	sub    $0xc,%esp
  800293:	68 10 1b 80 00       	push   $0x801b10
  800298:	e8 08 01 00 00       	call   8003a5 <cprintf>
  80029d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002a0:	e8 e0 10 00 00       	call   801385 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002a5:	e8 19 00 00 00       	call   8002c3 <exit>
}
  8002aa:	90                   	nop
  8002ab:	c9                   	leave  
  8002ac:	c3                   	ret    

008002ad <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002ad:	55                   	push   %ebp
  8002ae:	89 e5                	mov    %esp,%ebp
  8002b0:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002b3:	83 ec 0c             	sub    $0xc,%esp
  8002b6:	6a 00                	push   $0x0
  8002b8:	e8 df 0e 00 00       	call   80119c <sys_env_destroy>
  8002bd:	83 c4 10             	add    $0x10,%esp
}
  8002c0:	90                   	nop
  8002c1:	c9                   	leave  
  8002c2:	c3                   	ret    

008002c3 <exit>:

void
exit(void)
{
  8002c3:	55                   	push   %ebp
  8002c4:	89 e5                	mov    %esp,%ebp
  8002c6:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002c9:	e8 34 0f 00 00       	call   801202 <sys_env_exit>
}
  8002ce:	90                   	nop
  8002cf:	c9                   	leave  
  8002d0:	c3                   	ret    

008002d1 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8002d1:	55                   	push   %ebp
  8002d2:	89 e5                	mov    %esp,%ebp
  8002d4:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8002d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002da:	8b 00                	mov    (%eax),%eax
  8002dc:	8d 48 01             	lea    0x1(%eax),%ecx
  8002df:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002e2:	89 0a                	mov    %ecx,(%edx)
  8002e4:	8b 55 08             	mov    0x8(%ebp),%edx
  8002e7:	88 d1                	mov    %dl,%cl
  8002e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002ec:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8002f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002f3:	8b 00                	mov    (%eax),%eax
  8002f5:	3d ff 00 00 00       	cmp    $0xff,%eax
  8002fa:	75 2c                	jne    800328 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8002fc:	a0 24 20 80 00       	mov    0x802024,%al
  800301:	0f b6 c0             	movzbl %al,%eax
  800304:	8b 55 0c             	mov    0xc(%ebp),%edx
  800307:	8b 12                	mov    (%edx),%edx
  800309:	89 d1                	mov    %edx,%ecx
  80030b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80030e:	83 c2 08             	add    $0x8,%edx
  800311:	83 ec 04             	sub    $0x4,%esp
  800314:	50                   	push   %eax
  800315:	51                   	push   %ecx
  800316:	52                   	push   %edx
  800317:	e8 3e 0e 00 00       	call   80115a <sys_cputs>
  80031c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80031f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800322:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800328:	8b 45 0c             	mov    0xc(%ebp),%eax
  80032b:	8b 40 04             	mov    0x4(%eax),%eax
  80032e:	8d 50 01             	lea    0x1(%eax),%edx
  800331:	8b 45 0c             	mov    0xc(%ebp),%eax
  800334:	89 50 04             	mov    %edx,0x4(%eax)
}
  800337:	90                   	nop
  800338:	c9                   	leave  
  800339:	c3                   	ret    

0080033a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80033a:	55                   	push   %ebp
  80033b:	89 e5                	mov    %esp,%ebp
  80033d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800343:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80034a:	00 00 00 
	b.cnt = 0;
  80034d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800354:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800357:	ff 75 0c             	pushl  0xc(%ebp)
  80035a:	ff 75 08             	pushl  0x8(%ebp)
  80035d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800363:	50                   	push   %eax
  800364:	68 d1 02 80 00       	push   $0x8002d1
  800369:	e8 11 02 00 00       	call   80057f <vprintfmt>
  80036e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800371:	a0 24 20 80 00       	mov    0x802024,%al
  800376:	0f b6 c0             	movzbl %al,%eax
  800379:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80037f:	83 ec 04             	sub    $0x4,%esp
  800382:	50                   	push   %eax
  800383:	52                   	push   %edx
  800384:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80038a:	83 c0 08             	add    $0x8,%eax
  80038d:	50                   	push   %eax
  80038e:	e8 c7 0d 00 00       	call   80115a <sys_cputs>
  800393:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800396:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  80039d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8003a3:	c9                   	leave  
  8003a4:	c3                   	ret    

008003a5 <cprintf>:

int cprintf(const char *fmt, ...) {
  8003a5:	55                   	push   %ebp
  8003a6:	89 e5                	mov    %esp,%ebp
  8003a8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8003ab:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  8003b2:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bb:	83 ec 08             	sub    $0x8,%esp
  8003be:	ff 75 f4             	pushl  -0xc(%ebp)
  8003c1:	50                   	push   %eax
  8003c2:	e8 73 ff ff ff       	call   80033a <vcprintf>
  8003c7:	83 c4 10             	add    $0x10,%esp
  8003ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8003cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8003d0:	c9                   	leave  
  8003d1:	c3                   	ret    

008003d2 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8003d2:	55                   	push   %ebp
  8003d3:	89 e5                	mov    %esp,%ebp
  8003d5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8003d8:	e8 8e 0f 00 00       	call   80136b <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8003dd:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e6:	83 ec 08             	sub    $0x8,%esp
  8003e9:	ff 75 f4             	pushl  -0xc(%ebp)
  8003ec:	50                   	push   %eax
  8003ed:	e8 48 ff ff ff       	call   80033a <vcprintf>
  8003f2:	83 c4 10             	add    $0x10,%esp
  8003f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8003f8:	e8 88 0f 00 00       	call   801385 <sys_enable_interrupt>
	return cnt;
  8003fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800400:	c9                   	leave  
  800401:	c3                   	ret    

00800402 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800402:	55                   	push   %ebp
  800403:	89 e5                	mov    %esp,%ebp
  800405:	53                   	push   %ebx
  800406:	83 ec 14             	sub    $0x14,%esp
  800409:	8b 45 10             	mov    0x10(%ebp),%eax
  80040c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80040f:	8b 45 14             	mov    0x14(%ebp),%eax
  800412:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800415:	8b 45 18             	mov    0x18(%ebp),%eax
  800418:	ba 00 00 00 00       	mov    $0x0,%edx
  80041d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800420:	77 55                	ja     800477 <printnum+0x75>
  800422:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800425:	72 05                	jb     80042c <printnum+0x2a>
  800427:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80042a:	77 4b                	ja     800477 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80042c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80042f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800432:	8b 45 18             	mov    0x18(%ebp),%eax
  800435:	ba 00 00 00 00       	mov    $0x0,%edx
  80043a:	52                   	push   %edx
  80043b:	50                   	push   %eax
  80043c:	ff 75 f4             	pushl  -0xc(%ebp)
  80043f:	ff 75 f0             	pushl  -0x10(%ebp)
  800442:	e8 f9 13 00 00       	call   801840 <__udivdi3>
  800447:	83 c4 10             	add    $0x10,%esp
  80044a:	83 ec 04             	sub    $0x4,%esp
  80044d:	ff 75 20             	pushl  0x20(%ebp)
  800450:	53                   	push   %ebx
  800451:	ff 75 18             	pushl  0x18(%ebp)
  800454:	52                   	push   %edx
  800455:	50                   	push   %eax
  800456:	ff 75 0c             	pushl  0xc(%ebp)
  800459:	ff 75 08             	pushl  0x8(%ebp)
  80045c:	e8 a1 ff ff ff       	call   800402 <printnum>
  800461:	83 c4 20             	add    $0x20,%esp
  800464:	eb 1a                	jmp    800480 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800466:	83 ec 08             	sub    $0x8,%esp
  800469:	ff 75 0c             	pushl  0xc(%ebp)
  80046c:	ff 75 20             	pushl  0x20(%ebp)
  80046f:	8b 45 08             	mov    0x8(%ebp),%eax
  800472:	ff d0                	call   *%eax
  800474:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800477:	ff 4d 1c             	decl   0x1c(%ebp)
  80047a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80047e:	7f e6                	jg     800466 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800480:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800483:	bb 00 00 00 00       	mov    $0x0,%ebx
  800488:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80048b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80048e:	53                   	push   %ebx
  80048f:	51                   	push   %ecx
  800490:	52                   	push   %edx
  800491:	50                   	push   %eax
  800492:	e8 b9 14 00 00       	call   801950 <__umoddi3>
  800497:	83 c4 10             	add    $0x10,%esp
  80049a:	05 d4 1d 80 00       	add    $0x801dd4,%eax
  80049f:	8a 00                	mov    (%eax),%al
  8004a1:	0f be c0             	movsbl %al,%eax
  8004a4:	83 ec 08             	sub    $0x8,%esp
  8004a7:	ff 75 0c             	pushl  0xc(%ebp)
  8004aa:	50                   	push   %eax
  8004ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ae:	ff d0                	call   *%eax
  8004b0:	83 c4 10             	add    $0x10,%esp
}
  8004b3:	90                   	nop
  8004b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8004b7:	c9                   	leave  
  8004b8:	c3                   	ret    

008004b9 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8004b9:	55                   	push   %ebp
  8004ba:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004bc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004c0:	7e 1c                	jle    8004de <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8004c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c5:	8b 00                	mov    (%eax),%eax
  8004c7:	8d 50 08             	lea    0x8(%eax),%edx
  8004ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8004cd:	89 10                	mov    %edx,(%eax)
  8004cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d2:	8b 00                	mov    (%eax),%eax
  8004d4:	83 e8 08             	sub    $0x8,%eax
  8004d7:	8b 50 04             	mov    0x4(%eax),%edx
  8004da:	8b 00                	mov    (%eax),%eax
  8004dc:	eb 40                	jmp    80051e <getuint+0x65>
	else if (lflag)
  8004de:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004e2:	74 1e                	je     800502 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8004e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e7:	8b 00                	mov    (%eax),%eax
  8004e9:	8d 50 04             	lea    0x4(%eax),%edx
  8004ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ef:	89 10                	mov    %edx,(%eax)
  8004f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f4:	8b 00                	mov    (%eax),%eax
  8004f6:	83 e8 04             	sub    $0x4,%eax
  8004f9:	8b 00                	mov    (%eax),%eax
  8004fb:	ba 00 00 00 00       	mov    $0x0,%edx
  800500:	eb 1c                	jmp    80051e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800502:	8b 45 08             	mov    0x8(%ebp),%eax
  800505:	8b 00                	mov    (%eax),%eax
  800507:	8d 50 04             	lea    0x4(%eax),%edx
  80050a:	8b 45 08             	mov    0x8(%ebp),%eax
  80050d:	89 10                	mov    %edx,(%eax)
  80050f:	8b 45 08             	mov    0x8(%ebp),%eax
  800512:	8b 00                	mov    (%eax),%eax
  800514:	83 e8 04             	sub    $0x4,%eax
  800517:	8b 00                	mov    (%eax),%eax
  800519:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80051e:	5d                   	pop    %ebp
  80051f:	c3                   	ret    

00800520 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800520:	55                   	push   %ebp
  800521:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800523:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800527:	7e 1c                	jle    800545 <getint+0x25>
		return va_arg(*ap, long long);
  800529:	8b 45 08             	mov    0x8(%ebp),%eax
  80052c:	8b 00                	mov    (%eax),%eax
  80052e:	8d 50 08             	lea    0x8(%eax),%edx
  800531:	8b 45 08             	mov    0x8(%ebp),%eax
  800534:	89 10                	mov    %edx,(%eax)
  800536:	8b 45 08             	mov    0x8(%ebp),%eax
  800539:	8b 00                	mov    (%eax),%eax
  80053b:	83 e8 08             	sub    $0x8,%eax
  80053e:	8b 50 04             	mov    0x4(%eax),%edx
  800541:	8b 00                	mov    (%eax),%eax
  800543:	eb 38                	jmp    80057d <getint+0x5d>
	else if (lflag)
  800545:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800549:	74 1a                	je     800565 <getint+0x45>
		return va_arg(*ap, long);
  80054b:	8b 45 08             	mov    0x8(%ebp),%eax
  80054e:	8b 00                	mov    (%eax),%eax
  800550:	8d 50 04             	lea    0x4(%eax),%edx
  800553:	8b 45 08             	mov    0x8(%ebp),%eax
  800556:	89 10                	mov    %edx,(%eax)
  800558:	8b 45 08             	mov    0x8(%ebp),%eax
  80055b:	8b 00                	mov    (%eax),%eax
  80055d:	83 e8 04             	sub    $0x4,%eax
  800560:	8b 00                	mov    (%eax),%eax
  800562:	99                   	cltd   
  800563:	eb 18                	jmp    80057d <getint+0x5d>
	else
		return va_arg(*ap, int);
  800565:	8b 45 08             	mov    0x8(%ebp),%eax
  800568:	8b 00                	mov    (%eax),%eax
  80056a:	8d 50 04             	lea    0x4(%eax),%edx
  80056d:	8b 45 08             	mov    0x8(%ebp),%eax
  800570:	89 10                	mov    %edx,(%eax)
  800572:	8b 45 08             	mov    0x8(%ebp),%eax
  800575:	8b 00                	mov    (%eax),%eax
  800577:	83 e8 04             	sub    $0x4,%eax
  80057a:	8b 00                	mov    (%eax),%eax
  80057c:	99                   	cltd   
}
  80057d:	5d                   	pop    %ebp
  80057e:	c3                   	ret    

0080057f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80057f:	55                   	push   %ebp
  800580:	89 e5                	mov    %esp,%ebp
  800582:	56                   	push   %esi
  800583:	53                   	push   %ebx
  800584:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800587:	eb 17                	jmp    8005a0 <vprintfmt+0x21>
			if (ch == '\0')
  800589:	85 db                	test   %ebx,%ebx
  80058b:	0f 84 af 03 00 00    	je     800940 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800591:	83 ec 08             	sub    $0x8,%esp
  800594:	ff 75 0c             	pushl  0xc(%ebp)
  800597:	53                   	push   %ebx
  800598:	8b 45 08             	mov    0x8(%ebp),%eax
  80059b:	ff d0                	call   *%eax
  80059d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8005a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8005a3:	8d 50 01             	lea    0x1(%eax),%edx
  8005a6:	89 55 10             	mov    %edx,0x10(%ebp)
  8005a9:	8a 00                	mov    (%eax),%al
  8005ab:	0f b6 d8             	movzbl %al,%ebx
  8005ae:	83 fb 25             	cmp    $0x25,%ebx
  8005b1:	75 d6                	jne    800589 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8005b3:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8005b7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8005be:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8005c5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8005cc:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8005d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8005d6:	8d 50 01             	lea    0x1(%eax),%edx
  8005d9:	89 55 10             	mov    %edx,0x10(%ebp)
  8005dc:	8a 00                	mov    (%eax),%al
  8005de:	0f b6 d8             	movzbl %al,%ebx
  8005e1:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8005e4:	83 f8 55             	cmp    $0x55,%eax
  8005e7:	0f 87 2b 03 00 00    	ja     800918 <vprintfmt+0x399>
  8005ed:	8b 04 85 f8 1d 80 00 	mov    0x801df8(,%eax,4),%eax
  8005f4:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8005f6:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8005fa:	eb d7                	jmp    8005d3 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8005fc:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800600:	eb d1                	jmp    8005d3 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800602:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800609:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80060c:	89 d0                	mov    %edx,%eax
  80060e:	c1 e0 02             	shl    $0x2,%eax
  800611:	01 d0                	add    %edx,%eax
  800613:	01 c0                	add    %eax,%eax
  800615:	01 d8                	add    %ebx,%eax
  800617:	83 e8 30             	sub    $0x30,%eax
  80061a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80061d:	8b 45 10             	mov    0x10(%ebp),%eax
  800620:	8a 00                	mov    (%eax),%al
  800622:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800625:	83 fb 2f             	cmp    $0x2f,%ebx
  800628:	7e 3e                	jle    800668 <vprintfmt+0xe9>
  80062a:	83 fb 39             	cmp    $0x39,%ebx
  80062d:	7f 39                	jg     800668 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80062f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800632:	eb d5                	jmp    800609 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800634:	8b 45 14             	mov    0x14(%ebp),%eax
  800637:	83 c0 04             	add    $0x4,%eax
  80063a:	89 45 14             	mov    %eax,0x14(%ebp)
  80063d:	8b 45 14             	mov    0x14(%ebp),%eax
  800640:	83 e8 04             	sub    $0x4,%eax
  800643:	8b 00                	mov    (%eax),%eax
  800645:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800648:	eb 1f                	jmp    800669 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80064a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80064e:	79 83                	jns    8005d3 <vprintfmt+0x54>
				width = 0;
  800650:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800657:	e9 77 ff ff ff       	jmp    8005d3 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80065c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800663:	e9 6b ff ff ff       	jmp    8005d3 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800668:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800669:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80066d:	0f 89 60 ff ff ff    	jns    8005d3 <vprintfmt+0x54>
				width = precision, precision = -1;
  800673:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800676:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800679:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800680:	e9 4e ff ff ff       	jmp    8005d3 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800685:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800688:	e9 46 ff ff ff       	jmp    8005d3 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80068d:	8b 45 14             	mov    0x14(%ebp),%eax
  800690:	83 c0 04             	add    $0x4,%eax
  800693:	89 45 14             	mov    %eax,0x14(%ebp)
  800696:	8b 45 14             	mov    0x14(%ebp),%eax
  800699:	83 e8 04             	sub    $0x4,%eax
  80069c:	8b 00                	mov    (%eax),%eax
  80069e:	83 ec 08             	sub    $0x8,%esp
  8006a1:	ff 75 0c             	pushl  0xc(%ebp)
  8006a4:	50                   	push   %eax
  8006a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a8:	ff d0                	call   *%eax
  8006aa:	83 c4 10             	add    $0x10,%esp
			break;
  8006ad:	e9 89 02 00 00       	jmp    80093b <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8006b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8006b5:	83 c0 04             	add    $0x4,%eax
  8006b8:	89 45 14             	mov    %eax,0x14(%ebp)
  8006bb:	8b 45 14             	mov    0x14(%ebp),%eax
  8006be:	83 e8 04             	sub    $0x4,%eax
  8006c1:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8006c3:	85 db                	test   %ebx,%ebx
  8006c5:	79 02                	jns    8006c9 <vprintfmt+0x14a>
				err = -err;
  8006c7:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8006c9:	83 fb 64             	cmp    $0x64,%ebx
  8006cc:	7f 0b                	jg     8006d9 <vprintfmt+0x15a>
  8006ce:	8b 34 9d 40 1c 80 00 	mov    0x801c40(,%ebx,4),%esi
  8006d5:	85 f6                	test   %esi,%esi
  8006d7:	75 19                	jne    8006f2 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8006d9:	53                   	push   %ebx
  8006da:	68 e5 1d 80 00       	push   $0x801de5
  8006df:	ff 75 0c             	pushl  0xc(%ebp)
  8006e2:	ff 75 08             	pushl  0x8(%ebp)
  8006e5:	e8 5e 02 00 00       	call   800948 <printfmt>
  8006ea:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8006ed:	e9 49 02 00 00       	jmp    80093b <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8006f2:	56                   	push   %esi
  8006f3:	68 ee 1d 80 00       	push   $0x801dee
  8006f8:	ff 75 0c             	pushl  0xc(%ebp)
  8006fb:	ff 75 08             	pushl  0x8(%ebp)
  8006fe:	e8 45 02 00 00       	call   800948 <printfmt>
  800703:	83 c4 10             	add    $0x10,%esp
			break;
  800706:	e9 30 02 00 00       	jmp    80093b <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80070b:	8b 45 14             	mov    0x14(%ebp),%eax
  80070e:	83 c0 04             	add    $0x4,%eax
  800711:	89 45 14             	mov    %eax,0x14(%ebp)
  800714:	8b 45 14             	mov    0x14(%ebp),%eax
  800717:	83 e8 04             	sub    $0x4,%eax
  80071a:	8b 30                	mov    (%eax),%esi
  80071c:	85 f6                	test   %esi,%esi
  80071e:	75 05                	jne    800725 <vprintfmt+0x1a6>
				p = "(null)";
  800720:	be f1 1d 80 00       	mov    $0x801df1,%esi
			if (width > 0 && padc != '-')
  800725:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800729:	7e 6d                	jle    800798 <vprintfmt+0x219>
  80072b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80072f:	74 67                	je     800798 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800731:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800734:	83 ec 08             	sub    $0x8,%esp
  800737:	50                   	push   %eax
  800738:	56                   	push   %esi
  800739:	e8 0c 03 00 00       	call   800a4a <strnlen>
  80073e:	83 c4 10             	add    $0x10,%esp
  800741:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800744:	eb 16                	jmp    80075c <vprintfmt+0x1dd>
					putch(padc, putdat);
  800746:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80074a:	83 ec 08             	sub    $0x8,%esp
  80074d:	ff 75 0c             	pushl  0xc(%ebp)
  800750:	50                   	push   %eax
  800751:	8b 45 08             	mov    0x8(%ebp),%eax
  800754:	ff d0                	call   *%eax
  800756:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800759:	ff 4d e4             	decl   -0x1c(%ebp)
  80075c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800760:	7f e4                	jg     800746 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800762:	eb 34                	jmp    800798 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800764:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800768:	74 1c                	je     800786 <vprintfmt+0x207>
  80076a:	83 fb 1f             	cmp    $0x1f,%ebx
  80076d:	7e 05                	jle    800774 <vprintfmt+0x1f5>
  80076f:	83 fb 7e             	cmp    $0x7e,%ebx
  800772:	7e 12                	jle    800786 <vprintfmt+0x207>
					putch('?', putdat);
  800774:	83 ec 08             	sub    $0x8,%esp
  800777:	ff 75 0c             	pushl  0xc(%ebp)
  80077a:	6a 3f                	push   $0x3f
  80077c:	8b 45 08             	mov    0x8(%ebp),%eax
  80077f:	ff d0                	call   *%eax
  800781:	83 c4 10             	add    $0x10,%esp
  800784:	eb 0f                	jmp    800795 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800786:	83 ec 08             	sub    $0x8,%esp
  800789:	ff 75 0c             	pushl  0xc(%ebp)
  80078c:	53                   	push   %ebx
  80078d:	8b 45 08             	mov    0x8(%ebp),%eax
  800790:	ff d0                	call   *%eax
  800792:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800795:	ff 4d e4             	decl   -0x1c(%ebp)
  800798:	89 f0                	mov    %esi,%eax
  80079a:	8d 70 01             	lea    0x1(%eax),%esi
  80079d:	8a 00                	mov    (%eax),%al
  80079f:	0f be d8             	movsbl %al,%ebx
  8007a2:	85 db                	test   %ebx,%ebx
  8007a4:	74 24                	je     8007ca <vprintfmt+0x24b>
  8007a6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8007aa:	78 b8                	js     800764 <vprintfmt+0x1e5>
  8007ac:	ff 4d e0             	decl   -0x20(%ebp)
  8007af:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8007b3:	79 af                	jns    800764 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8007b5:	eb 13                	jmp    8007ca <vprintfmt+0x24b>
				putch(' ', putdat);
  8007b7:	83 ec 08             	sub    $0x8,%esp
  8007ba:	ff 75 0c             	pushl  0xc(%ebp)
  8007bd:	6a 20                	push   $0x20
  8007bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c2:	ff d0                	call   *%eax
  8007c4:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8007c7:	ff 4d e4             	decl   -0x1c(%ebp)
  8007ca:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007ce:	7f e7                	jg     8007b7 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8007d0:	e9 66 01 00 00       	jmp    80093b <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8007d5:	83 ec 08             	sub    $0x8,%esp
  8007d8:	ff 75 e8             	pushl  -0x18(%ebp)
  8007db:	8d 45 14             	lea    0x14(%ebp),%eax
  8007de:	50                   	push   %eax
  8007df:	e8 3c fd ff ff       	call   800520 <getint>
  8007e4:	83 c4 10             	add    $0x10,%esp
  8007e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ea:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8007ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007f3:	85 d2                	test   %edx,%edx
  8007f5:	79 23                	jns    80081a <vprintfmt+0x29b>
				putch('-', putdat);
  8007f7:	83 ec 08             	sub    $0x8,%esp
  8007fa:	ff 75 0c             	pushl  0xc(%ebp)
  8007fd:	6a 2d                	push   $0x2d
  8007ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800802:	ff d0                	call   *%eax
  800804:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800807:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80080a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80080d:	f7 d8                	neg    %eax
  80080f:	83 d2 00             	adc    $0x0,%edx
  800812:	f7 da                	neg    %edx
  800814:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800817:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80081a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800821:	e9 bc 00 00 00       	jmp    8008e2 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800826:	83 ec 08             	sub    $0x8,%esp
  800829:	ff 75 e8             	pushl  -0x18(%ebp)
  80082c:	8d 45 14             	lea    0x14(%ebp),%eax
  80082f:	50                   	push   %eax
  800830:	e8 84 fc ff ff       	call   8004b9 <getuint>
  800835:	83 c4 10             	add    $0x10,%esp
  800838:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80083b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80083e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800845:	e9 98 00 00 00       	jmp    8008e2 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80084a:	83 ec 08             	sub    $0x8,%esp
  80084d:	ff 75 0c             	pushl  0xc(%ebp)
  800850:	6a 58                	push   $0x58
  800852:	8b 45 08             	mov    0x8(%ebp),%eax
  800855:	ff d0                	call   *%eax
  800857:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80085a:	83 ec 08             	sub    $0x8,%esp
  80085d:	ff 75 0c             	pushl  0xc(%ebp)
  800860:	6a 58                	push   $0x58
  800862:	8b 45 08             	mov    0x8(%ebp),%eax
  800865:	ff d0                	call   *%eax
  800867:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80086a:	83 ec 08             	sub    $0x8,%esp
  80086d:	ff 75 0c             	pushl  0xc(%ebp)
  800870:	6a 58                	push   $0x58
  800872:	8b 45 08             	mov    0x8(%ebp),%eax
  800875:	ff d0                	call   *%eax
  800877:	83 c4 10             	add    $0x10,%esp
			break;
  80087a:	e9 bc 00 00 00       	jmp    80093b <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80087f:	83 ec 08             	sub    $0x8,%esp
  800882:	ff 75 0c             	pushl  0xc(%ebp)
  800885:	6a 30                	push   $0x30
  800887:	8b 45 08             	mov    0x8(%ebp),%eax
  80088a:	ff d0                	call   *%eax
  80088c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80088f:	83 ec 08             	sub    $0x8,%esp
  800892:	ff 75 0c             	pushl  0xc(%ebp)
  800895:	6a 78                	push   $0x78
  800897:	8b 45 08             	mov    0x8(%ebp),%eax
  80089a:	ff d0                	call   *%eax
  80089c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80089f:	8b 45 14             	mov    0x14(%ebp),%eax
  8008a2:	83 c0 04             	add    $0x4,%eax
  8008a5:	89 45 14             	mov    %eax,0x14(%ebp)
  8008a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ab:	83 e8 04             	sub    $0x4,%eax
  8008ae:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8008b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8008ba:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8008c1:	eb 1f                	jmp    8008e2 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8008c3:	83 ec 08             	sub    $0x8,%esp
  8008c6:	ff 75 e8             	pushl  -0x18(%ebp)
  8008c9:	8d 45 14             	lea    0x14(%ebp),%eax
  8008cc:	50                   	push   %eax
  8008cd:	e8 e7 fb ff ff       	call   8004b9 <getuint>
  8008d2:	83 c4 10             	add    $0x10,%esp
  8008d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008d8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8008db:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8008e2:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8008e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008e9:	83 ec 04             	sub    $0x4,%esp
  8008ec:	52                   	push   %edx
  8008ed:	ff 75 e4             	pushl  -0x1c(%ebp)
  8008f0:	50                   	push   %eax
  8008f1:	ff 75 f4             	pushl  -0xc(%ebp)
  8008f4:	ff 75 f0             	pushl  -0x10(%ebp)
  8008f7:	ff 75 0c             	pushl  0xc(%ebp)
  8008fa:	ff 75 08             	pushl  0x8(%ebp)
  8008fd:	e8 00 fb ff ff       	call   800402 <printnum>
  800902:	83 c4 20             	add    $0x20,%esp
			break;
  800905:	eb 34                	jmp    80093b <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800907:	83 ec 08             	sub    $0x8,%esp
  80090a:	ff 75 0c             	pushl  0xc(%ebp)
  80090d:	53                   	push   %ebx
  80090e:	8b 45 08             	mov    0x8(%ebp),%eax
  800911:	ff d0                	call   *%eax
  800913:	83 c4 10             	add    $0x10,%esp
			break;
  800916:	eb 23                	jmp    80093b <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800918:	83 ec 08             	sub    $0x8,%esp
  80091b:	ff 75 0c             	pushl  0xc(%ebp)
  80091e:	6a 25                	push   $0x25
  800920:	8b 45 08             	mov    0x8(%ebp),%eax
  800923:	ff d0                	call   *%eax
  800925:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800928:	ff 4d 10             	decl   0x10(%ebp)
  80092b:	eb 03                	jmp    800930 <vprintfmt+0x3b1>
  80092d:	ff 4d 10             	decl   0x10(%ebp)
  800930:	8b 45 10             	mov    0x10(%ebp),%eax
  800933:	48                   	dec    %eax
  800934:	8a 00                	mov    (%eax),%al
  800936:	3c 25                	cmp    $0x25,%al
  800938:	75 f3                	jne    80092d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80093a:	90                   	nop
		}
	}
  80093b:	e9 47 fc ff ff       	jmp    800587 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800940:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800941:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800944:	5b                   	pop    %ebx
  800945:	5e                   	pop    %esi
  800946:	5d                   	pop    %ebp
  800947:	c3                   	ret    

00800948 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800948:	55                   	push   %ebp
  800949:	89 e5                	mov    %esp,%ebp
  80094b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80094e:	8d 45 10             	lea    0x10(%ebp),%eax
  800951:	83 c0 04             	add    $0x4,%eax
  800954:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800957:	8b 45 10             	mov    0x10(%ebp),%eax
  80095a:	ff 75 f4             	pushl  -0xc(%ebp)
  80095d:	50                   	push   %eax
  80095e:	ff 75 0c             	pushl  0xc(%ebp)
  800961:	ff 75 08             	pushl  0x8(%ebp)
  800964:	e8 16 fc ff ff       	call   80057f <vprintfmt>
  800969:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80096c:	90                   	nop
  80096d:	c9                   	leave  
  80096e:	c3                   	ret    

0080096f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80096f:	55                   	push   %ebp
  800970:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800972:	8b 45 0c             	mov    0xc(%ebp),%eax
  800975:	8b 40 08             	mov    0x8(%eax),%eax
  800978:	8d 50 01             	lea    0x1(%eax),%edx
  80097b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80097e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800981:	8b 45 0c             	mov    0xc(%ebp),%eax
  800984:	8b 10                	mov    (%eax),%edx
  800986:	8b 45 0c             	mov    0xc(%ebp),%eax
  800989:	8b 40 04             	mov    0x4(%eax),%eax
  80098c:	39 c2                	cmp    %eax,%edx
  80098e:	73 12                	jae    8009a2 <sprintputch+0x33>
		*b->buf++ = ch;
  800990:	8b 45 0c             	mov    0xc(%ebp),%eax
  800993:	8b 00                	mov    (%eax),%eax
  800995:	8d 48 01             	lea    0x1(%eax),%ecx
  800998:	8b 55 0c             	mov    0xc(%ebp),%edx
  80099b:	89 0a                	mov    %ecx,(%edx)
  80099d:	8b 55 08             	mov    0x8(%ebp),%edx
  8009a0:	88 10                	mov    %dl,(%eax)
}
  8009a2:	90                   	nop
  8009a3:	5d                   	pop    %ebp
  8009a4:	c3                   	ret    

008009a5 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8009a5:	55                   	push   %ebp
  8009a6:	89 e5                	mov    %esp,%ebp
  8009a8:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8009ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8009b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8009b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ba:	01 d0                	add    %edx,%eax
  8009bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8009c6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8009ca:	74 06                	je     8009d2 <vsnprintf+0x2d>
  8009cc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009d0:	7f 07                	jg     8009d9 <vsnprintf+0x34>
		return -E_INVAL;
  8009d2:	b8 03 00 00 00       	mov    $0x3,%eax
  8009d7:	eb 20                	jmp    8009f9 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8009d9:	ff 75 14             	pushl  0x14(%ebp)
  8009dc:	ff 75 10             	pushl  0x10(%ebp)
  8009df:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8009e2:	50                   	push   %eax
  8009e3:	68 6f 09 80 00       	push   $0x80096f
  8009e8:	e8 92 fb ff ff       	call   80057f <vprintfmt>
  8009ed:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8009f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009f3:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8009f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8009f9:	c9                   	leave  
  8009fa:	c3                   	ret    

008009fb <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8009fb:	55                   	push   %ebp
  8009fc:	89 e5                	mov    %esp,%ebp
  8009fe:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800a01:	8d 45 10             	lea    0x10(%ebp),%eax
  800a04:	83 c0 04             	add    $0x4,%eax
  800a07:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800a0a:	8b 45 10             	mov    0x10(%ebp),%eax
  800a0d:	ff 75 f4             	pushl  -0xc(%ebp)
  800a10:	50                   	push   %eax
  800a11:	ff 75 0c             	pushl  0xc(%ebp)
  800a14:	ff 75 08             	pushl  0x8(%ebp)
  800a17:	e8 89 ff ff ff       	call   8009a5 <vsnprintf>
  800a1c:	83 c4 10             	add    $0x10,%esp
  800a1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800a22:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a25:	c9                   	leave  
  800a26:	c3                   	ret    

00800a27 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800a27:	55                   	push   %ebp
  800a28:	89 e5                	mov    %esp,%ebp
  800a2a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800a2d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a34:	eb 06                	jmp    800a3c <strlen+0x15>
		n++;
  800a36:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800a39:	ff 45 08             	incl   0x8(%ebp)
  800a3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3f:	8a 00                	mov    (%eax),%al
  800a41:	84 c0                	test   %al,%al
  800a43:	75 f1                	jne    800a36 <strlen+0xf>
		n++;
	return n;
  800a45:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a48:	c9                   	leave  
  800a49:	c3                   	ret    

00800a4a <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800a4a:	55                   	push   %ebp
  800a4b:	89 e5                	mov    %esp,%ebp
  800a4d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a50:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a57:	eb 09                	jmp    800a62 <strnlen+0x18>
		n++;
  800a59:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a5c:	ff 45 08             	incl   0x8(%ebp)
  800a5f:	ff 4d 0c             	decl   0xc(%ebp)
  800a62:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a66:	74 09                	je     800a71 <strnlen+0x27>
  800a68:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6b:	8a 00                	mov    (%eax),%al
  800a6d:	84 c0                	test   %al,%al
  800a6f:	75 e8                	jne    800a59 <strnlen+0xf>
		n++;
	return n;
  800a71:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a74:	c9                   	leave  
  800a75:	c3                   	ret    

00800a76 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800a76:	55                   	push   %ebp
  800a77:	89 e5                	mov    %esp,%ebp
  800a79:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800a7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800a82:	90                   	nop
  800a83:	8b 45 08             	mov    0x8(%ebp),%eax
  800a86:	8d 50 01             	lea    0x1(%eax),%edx
  800a89:	89 55 08             	mov    %edx,0x8(%ebp)
  800a8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a8f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a92:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a95:	8a 12                	mov    (%edx),%dl
  800a97:	88 10                	mov    %dl,(%eax)
  800a99:	8a 00                	mov    (%eax),%al
  800a9b:	84 c0                	test   %al,%al
  800a9d:	75 e4                	jne    800a83 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a9f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800aa2:	c9                   	leave  
  800aa3:	c3                   	ret    

00800aa4 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800aa4:	55                   	push   %ebp
  800aa5:	89 e5                	mov    %esp,%ebp
  800aa7:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800aaa:	8b 45 08             	mov    0x8(%ebp),%eax
  800aad:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800ab0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ab7:	eb 1f                	jmp    800ad8 <strncpy+0x34>
		*dst++ = *src;
  800ab9:	8b 45 08             	mov    0x8(%ebp),%eax
  800abc:	8d 50 01             	lea    0x1(%eax),%edx
  800abf:	89 55 08             	mov    %edx,0x8(%ebp)
  800ac2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ac5:	8a 12                	mov    (%edx),%dl
  800ac7:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800ac9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800acc:	8a 00                	mov    (%eax),%al
  800ace:	84 c0                	test   %al,%al
  800ad0:	74 03                	je     800ad5 <strncpy+0x31>
			src++;
  800ad2:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800ad5:	ff 45 fc             	incl   -0x4(%ebp)
  800ad8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800adb:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ade:	72 d9                	jb     800ab9 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800ae0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ae3:	c9                   	leave  
  800ae4:	c3                   	ret    

00800ae5 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ae5:	55                   	push   %ebp
  800ae6:	89 e5                	mov    %esp,%ebp
  800ae8:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800aee:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800af1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800af5:	74 30                	je     800b27 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800af7:	eb 16                	jmp    800b0f <strlcpy+0x2a>
			*dst++ = *src++;
  800af9:	8b 45 08             	mov    0x8(%ebp),%eax
  800afc:	8d 50 01             	lea    0x1(%eax),%edx
  800aff:	89 55 08             	mov    %edx,0x8(%ebp)
  800b02:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b05:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b08:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b0b:	8a 12                	mov    (%edx),%dl
  800b0d:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800b0f:	ff 4d 10             	decl   0x10(%ebp)
  800b12:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b16:	74 09                	je     800b21 <strlcpy+0x3c>
  800b18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1b:	8a 00                	mov    (%eax),%al
  800b1d:	84 c0                	test   %al,%al
  800b1f:	75 d8                	jne    800af9 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800b21:	8b 45 08             	mov    0x8(%ebp),%eax
  800b24:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800b27:	8b 55 08             	mov    0x8(%ebp),%edx
  800b2a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b2d:	29 c2                	sub    %eax,%edx
  800b2f:	89 d0                	mov    %edx,%eax
}
  800b31:	c9                   	leave  
  800b32:	c3                   	ret    

00800b33 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800b33:	55                   	push   %ebp
  800b34:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800b36:	eb 06                	jmp    800b3e <strcmp+0xb>
		p++, q++;
  800b38:	ff 45 08             	incl   0x8(%ebp)
  800b3b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b41:	8a 00                	mov    (%eax),%al
  800b43:	84 c0                	test   %al,%al
  800b45:	74 0e                	je     800b55 <strcmp+0x22>
  800b47:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4a:	8a 10                	mov    (%eax),%dl
  800b4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b4f:	8a 00                	mov    (%eax),%al
  800b51:	38 c2                	cmp    %al,%dl
  800b53:	74 e3                	je     800b38 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800b55:	8b 45 08             	mov    0x8(%ebp),%eax
  800b58:	8a 00                	mov    (%eax),%al
  800b5a:	0f b6 d0             	movzbl %al,%edx
  800b5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b60:	8a 00                	mov    (%eax),%al
  800b62:	0f b6 c0             	movzbl %al,%eax
  800b65:	29 c2                	sub    %eax,%edx
  800b67:	89 d0                	mov    %edx,%eax
}
  800b69:	5d                   	pop    %ebp
  800b6a:	c3                   	ret    

00800b6b <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800b6b:	55                   	push   %ebp
  800b6c:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800b6e:	eb 09                	jmp    800b79 <strncmp+0xe>
		n--, p++, q++;
  800b70:	ff 4d 10             	decl   0x10(%ebp)
  800b73:	ff 45 08             	incl   0x8(%ebp)
  800b76:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800b79:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b7d:	74 17                	je     800b96 <strncmp+0x2b>
  800b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b82:	8a 00                	mov    (%eax),%al
  800b84:	84 c0                	test   %al,%al
  800b86:	74 0e                	je     800b96 <strncmp+0x2b>
  800b88:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8b:	8a 10                	mov    (%eax),%dl
  800b8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b90:	8a 00                	mov    (%eax),%al
  800b92:	38 c2                	cmp    %al,%dl
  800b94:	74 da                	je     800b70 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800b96:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b9a:	75 07                	jne    800ba3 <strncmp+0x38>
		return 0;
  800b9c:	b8 00 00 00 00       	mov    $0x0,%eax
  800ba1:	eb 14                	jmp    800bb7 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba6:	8a 00                	mov    (%eax),%al
  800ba8:	0f b6 d0             	movzbl %al,%edx
  800bab:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bae:	8a 00                	mov    (%eax),%al
  800bb0:	0f b6 c0             	movzbl %al,%eax
  800bb3:	29 c2                	sub    %eax,%edx
  800bb5:	89 d0                	mov    %edx,%eax
}
  800bb7:	5d                   	pop    %ebp
  800bb8:	c3                   	ret    

00800bb9 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800bb9:	55                   	push   %ebp
  800bba:	89 e5                	mov    %esp,%ebp
  800bbc:	83 ec 04             	sub    $0x4,%esp
  800bbf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800bc5:	eb 12                	jmp    800bd9 <strchr+0x20>
		if (*s == c)
  800bc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bca:	8a 00                	mov    (%eax),%al
  800bcc:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800bcf:	75 05                	jne    800bd6 <strchr+0x1d>
			return (char *) s;
  800bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd4:	eb 11                	jmp    800be7 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800bd6:	ff 45 08             	incl   0x8(%ebp)
  800bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdc:	8a 00                	mov    (%eax),%al
  800bde:	84 c0                	test   %al,%al
  800be0:	75 e5                	jne    800bc7 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800be2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800be7:	c9                   	leave  
  800be8:	c3                   	ret    

00800be9 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800be9:	55                   	push   %ebp
  800bea:	89 e5                	mov    %esp,%ebp
  800bec:	83 ec 04             	sub    $0x4,%esp
  800bef:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800bf5:	eb 0d                	jmp    800c04 <strfind+0x1b>
		if (*s == c)
  800bf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfa:	8a 00                	mov    (%eax),%al
  800bfc:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800bff:	74 0e                	je     800c0f <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800c01:	ff 45 08             	incl   0x8(%ebp)
  800c04:	8b 45 08             	mov    0x8(%ebp),%eax
  800c07:	8a 00                	mov    (%eax),%al
  800c09:	84 c0                	test   %al,%al
  800c0b:	75 ea                	jne    800bf7 <strfind+0xe>
  800c0d:	eb 01                	jmp    800c10 <strfind+0x27>
		if (*s == c)
			break;
  800c0f:	90                   	nop
	return (char *) s;
  800c10:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c13:	c9                   	leave  
  800c14:	c3                   	ret    

00800c15 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800c15:	55                   	push   %ebp
  800c16:	89 e5                	mov    %esp,%ebp
  800c18:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800c21:	8b 45 10             	mov    0x10(%ebp),%eax
  800c24:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800c27:	eb 0e                	jmp    800c37 <memset+0x22>
		*p++ = c;
  800c29:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c2c:	8d 50 01             	lea    0x1(%eax),%edx
  800c2f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800c32:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c35:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800c37:	ff 4d f8             	decl   -0x8(%ebp)
  800c3a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800c3e:	79 e9                	jns    800c29 <memset+0x14>
		*p++ = c;

	return v;
  800c40:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c43:	c9                   	leave  
  800c44:	c3                   	ret    

00800c45 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800c45:	55                   	push   %ebp
  800c46:	89 e5                	mov    %esp,%ebp
  800c48:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c51:	8b 45 08             	mov    0x8(%ebp),%eax
  800c54:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800c57:	eb 16                	jmp    800c6f <memcpy+0x2a>
		*d++ = *s++;
  800c59:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c5c:	8d 50 01             	lea    0x1(%eax),%edx
  800c5f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c62:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c65:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c68:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c6b:	8a 12                	mov    (%edx),%dl
  800c6d:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800c6f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c72:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c75:	89 55 10             	mov    %edx,0x10(%ebp)
  800c78:	85 c0                	test   %eax,%eax
  800c7a:	75 dd                	jne    800c59 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800c7c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c7f:	c9                   	leave  
  800c80:	c3                   	ret    

00800c81 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800c81:	55                   	push   %ebp
  800c82:	89 e5                	mov    %esp,%ebp
  800c84:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c90:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800c93:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c96:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c99:	73 50                	jae    800ceb <memmove+0x6a>
  800c9b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c9e:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca1:	01 d0                	add    %edx,%eax
  800ca3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ca6:	76 43                	jbe    800ceb <memmove+0x6a>
		s += n;
  800ca8:	8b 45 10             	mov    0x10(%ebp),%eax
  800cab:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800cae:	8b 45 10             	mov    0x10(%ebp),%eax
  800cb1:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800cb4:	eb 10                	jmp    800cc6 <memmove+0x45>
			*--d = *--s;
  800cb6:	ff 4d f8             	decl   -0x8(%ebp)
  800cb9:	ff 4d fc             	decl   -0x4(%ebp)
  800cbc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cbf:	8a 10                	mov    (%eax),%dl
  800cc1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cc4:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800cc6:	8b 45 10             	mov    0x10(%ebp),%eax
  800cc9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ccc:	89 55 10             	mov    %edx,0x10(%ebp)
  800ccf:	85 c0                	test   %eax,%eax
  800cd1:	75 e3                	jne    800cb6 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800cd3:	eb 23                	jmp    800cf8 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800cd5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cd8:	8d 50 01             	lea    0x1(%eax),%edx
  800cdb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800cde:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ce1:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ce4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ce7:	8a 12                	mov    (%edx),%dl
  800ce9:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ceb:	8b 45 10             	mov    0x10(%ebp),%eax
  800cee:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cf1:	89 55 10             	mov    %edx,0x10(%ebp)
  800cf4:	85 c0                	test   %eax,%eax
  800cf6:	75 dd                	jne    800cd5 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800cf8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cfb:	c9                   	leave  
  800cfc:	c3                   	ret    

00800cfd <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800cfd:	55                   	push   %ebp
  800cfe:	89 e5                	mov    %esp,%ebp
  800d00:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800d03:	8b 45 08             	mov    0x8(%ebp),%eax
  800d06:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800d09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d0c:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800d0f:	eb 2a                	jmp    800d3b <memcmp+0x3e>
		if (*s1 != *s2)
  800d11:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d14:	8a 10                	mov    (%eax),%dl
  800d16:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d19:	8a 00                	mov    (%eax),%al
  800d1b:	38 c2                	cmp    %al,%dl
  800d1d:	74 16                	je     800d35 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800d1f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d22:	8a 00                	mov    (%eax),%al
  800d24:	0f b6 d0             	movzbl %al,%edx
  800d27:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d2a:	8a 00                	mov    (%eax),%al
  800d2c:	0f b6 c0             	movzbl %al,%eax
  800d2f:	29 c2                	sub    %eax,%edx
  800d31:	89 d0                	mov    %edx,%eax
  800d33:	eb 18                	jmp    800d4d <memcmp+0x50>
		s1++, s2++;
  800d35:	ff 45 fc             	incl   -0x4(%ebp)
  800d38:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800d3b:	8b 45 10             	mov    0x10(%ebp),%eax
  800d3e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d41:	89 55 10             	mov    %edx,0x10(%ebp)
  800d44:	85 c0                	test   %eax,%eax
  800d46:	75 c9                	jne    800d11 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800d48:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d4d:	c9                   	leave  
  800d4e:	c3                   	ret    

00800d4f <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800d4f:	55                   	push   %ebp
  800d50:	89 e5                	mov    %esp,%ebp
  800d52:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800d55:	8b 55 08             	mov    0x8(%ebp),%edx
  800d58:	8b 45 10             	mov    0x10(%ebp),%eax
  800d5b:	01 d0                	add    %edx,%eax
  800d5d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800d60:	eb 15                	jmp    800d77 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800d62:	8b 45 08             	mov    0x8(%ebp),%eax
  800d65:	8a 00                	mov    (%eax),%al
  800d67:	0f b6 d0             	movzbl %al,%edx
  800d6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d6d:	0f b6 c0             	movzbl %al,%eax
  800d70:	39 c2                	cmp    %eax,%edx
  800d72:	74 0d                	je     800d81 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800d74:	ff 45 08             	incl   0x8(%ebp)
  800d77:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800d7d:	72 e3                	jb     800d62 <memfind+0x13>
  800d7f:	eb 01                	jmp    800d82 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800d81:	90                   	nop
	return (void *) s;
  800d82:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d85:	c9                   	leave  
  800d86:	c3                   	ret    

00800d87 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800d87:	55                   	push   %ebp
  800d88:	89 e5                	mov    %esp,%ebp
  800d8a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d8d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800d94:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d9b:	eb 03                	jmp    800da0 <strtol+0x19>
		s++;
  800d9d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800da0:	8b 45 08             	mov    0x8(%ebp),%eax
  800da3:	8a 00                	mov    (%eax),%al
  800da5:	3c 20                	cmp    $0x20,%al
  800da7:	74 f4                	je     800d9d <strtol+0x16>
  800da9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dac:	8a 00                	mov    (%eax),%al
  800dae:	3c 09                	cmp    $0x9,%al
  800db0:	74 eb                	je     800d9d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800db2:	8b 45 08             	mov    0x8(%ebp),%eax
  800db5:	8a 00                	mov    (%eax),%al
  800db7:	3c 2b                	cmp    $0x2b,%al
  800db9:	75 05                	jne    800dc0 <strtol+0x39>
		s++;
  800dbb:	ff 45 08             	incl   0x8(%ebp)
  800dbe:	eb 13                	jmp    800dd3 <strtol+0x4c>
	else if (*s == '-')
  800dc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc3:	8a 00                	mov    (%eax),%al
  800dc5:	3c 2d                	cmp    $0x2d,%al
  800dc7:	75 0a                	jne    800dd3 <strtol+0x4c>
		s++, neg = 1;
  800dc9:	ff 45 08             	incl   0x8(%ebp)
  800dcc:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800dd3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dd7:	74 06                	je     800ddf <strtol+0x58>
  800dd9:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800ddd:	75 20                	jne    800dff <strtol+0x78>
  800ddf:	8b 45 08             	mov    0x8(%ebp),%eax
  800de2:	8a 00                	mov    (%eax),%al
  800de4:	3c 30                	cmp    $0x30,%al
  800de6:	75 17                	jne    800dff <strtol+0x78>
  800de8:	8b 45 08             	mov    0x8(%ebp),%eax
  800deb:	40                   	inc    %eax
  800dec:	8a 00                	mov    (%eax),%al
  800dee:	3c 78                	cmp    $0x78,%al
  800df0:	75 0d                	jne    800dff <strtol+0x78>
		s += 2, base = 16;
  800df2:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800df6:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800dfd:	eb 28                	jmp    800e27 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800dff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e03:	75 15                	jne    800e1a <strtol+0x93>
  800e05:	8b 45 08             	mov    0x8(%ebp),%eax
  800e08:	8a 00                	mov    (%eax),%al
  800e0a:	3c 30                	cmp    $0x30,%al
  800e0c:	75 0c                	jne    800e1a <strtol+0x93>
		s++, base = 8;
  800e0e:	ff 45 08             	incl   0x8(%ebp)
  800e11:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800e18:	eb 0d                	jmp    800e27 <strtol+0xa0>
	else if (base == 0)
  800e1a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e1e:	75 07                	jne    800e27 <strtol+0xa0>
		base = 10;
  800e20:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800e27:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2a:	8a 00                	mov    (%eax),%al
  800e2c:	3c 2f                	cmp    $0x2f,%al
  800e2e:	7e 19                	jle    800e49 <strtol+0xc2>
  800e30:	8b 45 08             	mov    0x8(%ebp),%eax
  800e33:	8a 00                	mov    (%eax),%al
  800e35:	3c 39                	cmp    $0x39,%al
  800e37:	7f 10                	jg     800e49 <strtol+0xc2>
			dig = *s - '0';
  800e39:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3c:	8a 00                	mov    (%eax),%al
  800e3e:	0f be c0             	movsbl %al,%eax
  800e41:	83 e8 30             	sub    $0x30,%eax
  800e44:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e47:	eb 42                	jmp    800e8b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800e49:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4c:	8a 00                	mov    (%eax),%al
  800e4e:	3c 60                	cmp    $0x60,%al
  800e50:	7e 19                	jle    800e6b <strtol+0xe4>
  800e52:	8b 45 08             	mov    0x8(%ebp),%eax
  800e55:	8a 00                	mov    (%eax),%al
  800e57:	3c 7a                	cmp    $0x7a,%al
  800e59:	7f 10                	jg     800e6b <strtol+0xe4>
			dig = *s - 'a' + 10;
  800e5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5e:	8a 00                	mov    (%eax),%al
  800e60:	0f be c0             	movsbl %al,%eax
  800e63:	83 e8 57             	sub    $0x57,%eax
  800e66:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e69:	eb 20                	jmp    800e8b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800e6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6e:	8a 00                	mov    (%eax),%al
  800e70:	3c 40                	cmp    $0x40,%al
  800e72:	7e 39                	jle    800ead <strtol+0x126>
  800e74:	8b 45 08             	mov    0x8(%ebp),%eax
  800e77:	8a 00                	mov    (%eax),%al
  800e79:	3c 5a                	cmp    $0x5a,%al
  800e7b:	7f 30                	jg     800ead <strtol+0x126>
			dig = *s - 'A' + 10;
  800e7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e80:	8a 00                	mov    (%eax),%al
  800e82:	0f be c0             	movsbl %al,%eax
  800e85:	83 e8 37             	sub    $0x37,%eax
  800e88:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e8e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e91:	7d 19                	jge    800eac <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800e93:	ff 45 08             	incl   0x8(%ebp)
  800e96:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e99:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e9d:	89 c2                	mov    %eax,%edx
  800e9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ea2:	01 d0                	add    %edx,%eax
  800ea4:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800ea7:	e9 7b ff ff ff       	jmp    800e27 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800eac:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800ead:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800eb1:	74 08                	je     800ebb <strtol+0x134>
		*endptr = (char *) s;
  800eb3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb6:	8b 55 08             	mov    0x8(%ebp),%edx
  800eb9:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800ebb:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ebf:	74 07                	je     800ec8 <strtol+0x141>
  800ec1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ec4:	f7 d8                	neg    %eax
  800ec6:	eb 03                	jmp    800ecb <strtol+0x144>
  800ec8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ecb:	c9                   	leave  
  800ecc:	c3                   	ret    

00800ecd <ltostr>:

void
ltostr(long value, char *str)
{
  800ecd:	55                   	push   %ebp
  800ece:	89 e5                	mov    %esp,%ebp
  800ed0:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800ed3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800eda:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800ee1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ee5:	79 13                	jns    800efa <ltostr+0x2d>
	{
		neg = 1;
  800ee7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800eee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef1:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800ef4:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800ef7:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800efa:	8b 45 08             	mov    0x8(%ebp),%eax
  800efd:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800f02:	99                   	cltd   
  800f03:	f7 f9                	idiv   %ecx
  800f05:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800f08:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f0b:	8d 50 01             	lea    0x1(%eax),%edx
  800f0e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f11:	89 c2                	mov    %eax,%edx
  800f13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f16:	01 d0                	add    %edx,%eax
  800f18:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800f1b:	83 c2 30             	add    $0x30,%edx
  800f1e:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800f20:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800f23:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800f28:	f7 e9                	imul   %ecx
  800f2a:	c1 fa 02             	sar    $0x2,%edx
  800f2d:	89 c8                	mov    %ecx,%eax
  800f2f:	c1 f8 1f             	sar    $0x1f,%eax
  800f32:	29 c2                	sub    %eax,%edx
  800f34:	89 d0                	mov    %edx,%eax
  800f36:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800f39:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800f3c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800f41:	f7 e9                	imul   %ecx
  800f43:	c1 fa 02             	sar    $0x2,%edx
  800f46:	89 c8                	mov    %ecx,%eax
  800f48:	c1 f8 1f             	sar    $0x1f,%eax
  800f4b:	29 c2                	sub    %eax,%edx
  800f4d:	89 d0                	mov    %edx,%eax
  800f4f:	c1 e0 02             	shl    $0x2,%eax
  800f52:	01 d0                	add    %edx,%eax
  800f54:	01 c0                	add    %eax,%eax
  800f56:	29 c1                	sub    %eax,%ecx
  800f58:	89 ca                	mov    %ecx,%edx
  800f5a:	85 d2                	test   %edx,%edx
  800f5c:	75 9c                	jne    800efa <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800f5e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800f65:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f68:	48                   	dec    %eax
  800f69:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800f6c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f70:	74 3d                	je     800faf <ltostr+0xe2>
		start = 1 ;
  800f72:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800f79:	eb 34                	jmp    800faf <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800f7b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f81:	01 d0                	add    %edx,%eax
  800f83:	8a 00                	mov    (%eax),%al
  800f85:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800f88:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8e:	01 c2                	add    %eax,%edx
  800f90:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800f93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f96:	01 c8                	add    %ecx,%eax
  800f98:	8a 00                	mov    (%eax),%al
  800f9a:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f9c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa2:	01 c2                	add    %eax,%edx
  800fa4:	8a 45 eb             	mov    -0x15(%ebp),%al
  800fa7:	88 02                	mov    %al,(%edx)
		start++ ;
  800fa9:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800fac:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800faf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fb2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fb5:	7c c4                	jl     800f7b <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800fb7:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800fba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbd:	01 d0                	add    %edx,%eax
  800fbf:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800fc2:	90                   	nop
  800fc3:	c9                   	leave  
  800fc4:	c3                   	ret    

00800fc5 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800fc5:	55                   	push   %ebp
  800fc6:	89 e5                	mov    %esp,%ebp
  800fc8:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800fcb:	ff 75 08             	pushl  0x8(%ebp)
  800fce:	e8 54 fa ff ff       	call   800a27 <strlen>
  800fd3:	83 c4 04             	add    $0x4,%esp
  800fd6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800fd9:	ff 75 0c             	pushl  0xc(%ebp)
  800fdc:	e8 46 fa ff ff       	call   800a27 <strlen>
  800fe1:	83 c4 04             	add    $0x4,%esp
  800fe4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800fe7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800fee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ff5:	eb 17                	jmp    80100e <strcconcat+0x49>
		final[s] = str1[s] ;
  800ff7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ffa:	8b 45 10             	mov    0x10(%ebp),%eax
  800ffd:	01 c2                	add    %eax,%edx
  800fff:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801002:	8b 45 08             	mov    0x8(%ebp),%eax
  801005:	01 c8                	add    %ecx,%eax
  801007:	8a 00                	mov    (%eax),%al
  801009:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80100b:	ff 45 fc             	incl   -0x4(%ebp)
  80100e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801011:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801014:	7c e1                	jl     800ff7 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801016:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80101d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801024:	eb 1f                	jmp    801045 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801026:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801029:	8d 50 01             	lea    0x1(%eax),%edx
  80102c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80102f:	89 c2                	mov    %eax,%edx
  801031:	8b 45 10             	mov    0x10(%ebp),%eax
  801034:	01 c2                	add    %eax,%edx
  801036:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801039:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103c:	01 c8                	add    %ecx,%eax
  80103e:	8a 00                	mov    (%eax),%al
  801040:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801042:	ff 45 f8             	incl   -0x8(%ebp)
  801045:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801048:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80104b:	7c d9                	jl     801026 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80104d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801050:	8b 45 10             	mov    0x10(%ebp),%eax
  801053:	01 d0                	add    %edx,%eax
  801055:	c6 00 00             	movb   $0x0,(%eax)
}
  801058:	90                   	nop
  801059:	c9                   	leave  
  80105a:	c3                   	ret    

0080105b <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80105b:	55                   	push   %ebp
  80105c:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80105e:	8b 45 14             	mov    0x14(%ebp),%eax
  801061:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801067:	8b 45 14             	mov    0x14(%ebp),%eax
  80106a:	8b 00                	mov    (%eax),%eax
  80106c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801073:	8b 45 10             	mov    0x10(%ebp),%eax
  801076:	01 d0                	add    %edx,%eax
  801078:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80107e:	eb 0c                	jmp    80108c <strsplit+0x31>
			*string++ = 0;
  801080:	8b 45 08             	mov    0x8(%ebp),%eax
  801083:	8d 50 01             	lea    0x1(%eax),%edx
  801086:	89 55 08             	mov    %edx,0x8(%ebp)
  801089:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80108c:	8b 45 08             	mov    0x8(%ebp),%eax
  80108f:	8a 00                	mov    (%eax),%al
  801091:	84 c0                	test   %al,%al
  801093:	74 18                	je     8010ad <strsplit+0x52>
  801095:	8b 45 08             	mov    0x8(%ebp),%eax
  801098:	8a 00                	mov    (%eax),%al
  80109a:	0f be c0             	movsbl %al,%eax
  80109d:	50                   	push   %eax
  80109e:	ff 75 0c             	pushl  0xc(%ebp)
  8010a1:	e8 13 fb ff ff       	call   800bb9 <strchr>
  8010a6:	83 c4 08             	add    $0x8,%esp
  8010a9:	85 c0                	test   %eax,%eax
  8010ab:	75 d3                	jne    801080 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8010ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b0:	8a 00                	mov    (%eax),%al
  8010b2:	84 c0                	test   %al,%al
  8010b4:	74 5a                	je     801110 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8010b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8010b9:	8b 00                	mov    (%eax),%eax
  8010bb:	83 f8 0f             	cmp    $0xf,%eax
  8010be:	75 07                	jne    8010c7 <strsplit+0x6c>
		{
			return 0;
  8010c0:	b8 00 00 00 00       	mov    $0x0,%eax
  8010c5:	eb 66                	jmp    80112d <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8010c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8010ca:	8b 00                	mov    (%eax),%eax
  8010cc:	8d 48 01             	lea    0x1(%eax),%ecx
  8010cf:	8b 55 14             	mov    0x14(%ebp),%edx
  8010d2:	89 0a                	mov    %ecx,(%edx)
  8010d4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010db:	8b 45 10             	mov    0x10(%ebp),%eax
  8010de:	01 c2                	add    %eax,%edx
  8010e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e3:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8010e5:	eb 03                	jmp    8010ea <strsplit+0x8f>
			string++;
  8010e7:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8010ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ed:	8a 00                	mov    (%eax),%al
  8010ef:	84 c0                	test   %al,%al
  8010f1:	74 8b                	je     80107e <strsplit+0x23>
  8010f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f6:	8a 00                	mov    (%eax),%al
  8010f8:	0f be c0             	movsbl %al,%eax
  8010fb:	50                   	push   %eax
  8010fc:	ff 75 0c             	pushl  0xc(%ebp)
  8010ff:	e8 b5 fa ff ff       	call   800bb9 <strchr>
  801104:	83 c4 08             	add    $0x8,%esp
  801107:	85 c0                	test   %eax,%eax
  801109:	74 dc                	je     8010e7 <strsplit+0x8c>
			string++;
	}
  80110b:	e9 6e ff ff ff       	jmp    80107e <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801110:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801111:	8b 45 14             	mov    0x14(%ebp),%eax
  801114:	8b 00                	mov    (%eax),%eax
  801116:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80111d:	8b 45 10             	mov    0x10(%ebp),%eax
  801120:	01 d0                	add    %edx,%eax
  801122:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801128:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80112d:	c9                   	leave  
  80112e:	c3                   	ret    

0080112f <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80112f:	55                   	push   %ebp
  801130:	89 e5                	mov    %esp,%ebp
  801132:	57                   	push   %edi
  801133:	56                   	push   %esi
  801134:	53                   	push   %ebx
  801135:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801138:	8b 45 08             	mov    0x8(%ebp),%eax
  80113b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80113e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801141:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801144:	8b 7d 18             	mov    0x18(%ebp),%edi
  801147:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80114a:	cd 30                	int    $0x30
  80114c:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80114f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801152:	83 c4 10             	add    $0x10,%esp
  801155:	5b                   	pop    %ebx
  801156:	5e                   	pop    %esi
  801157:	5f                   	pop    %edi
  801158:	5d                   	pop    %ebp
  801159:	c3                   	ret    

0080115a <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80115a:	55                   	push   %ebp
  80115b:	89 e5                	mov    %esp,%ebp
  80115d:	83 ec 04             	sub    $0x4,%esp
  801160:	8b 45 10             	mov    0x10(%ebp),%eax
  801163:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801166:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80116a:	8b 45 08             	mov    0x8(%ebp),%eax
  80116d:	6a 00                	push   $0x0
  80116f:	6a 00                	push   $0x0
  801171:	52                   	push   %edx
  801172:	ff 75 0c             	pushl  0xc(%ebp)
  801175:	50                   	push   %eax
  801176:	6a 00                	push   $0x0
  801178:	e8 b2 ff ff ff       	call   80112f <syscall>
  80117d:	83 c4 18             	add    $0x18,%esp
}
  801180:	90                   	nop
  801181:	c9                   	leave  
  801182:	c3                   	ret    

00801183 <sys_cgetc>:

int
sys_cgetc(void)
{
  801183:	55                   	push   %ebp
  801184:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801186:	6a 00                	push   $0x0
  801188:	6a 00                	push   $0x0
  80118a:	6a 00                	push   $0x0
  80118c:	6a 00                	push   $0x0
  80118e:	6a 00                	push   $0x0
  801190:	6a 01                	push   $0x1
  801192:	e8 98 ff ff ff       	call   80112f <syscall>
  801197:	83 c4 18             	add    $0x18,%esp
}
  80119a:	c9                   	leave  
  80119b:	c3                   	ret    

0080119c <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80119c:	55                   	push   %ebp
  80119d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80119f:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a2:	6a 00                	push   $0x0
  8011a4:	6a 00                	push   $0x0
  8011a6:	6a 00                	push   $0x0
  8011a8:	6a 00                	push   $0x0
  8011aa:	50                   	push   %eax
  8011ab:	6a 05                	push   $0x5
  8011ad:	e8 7d ff ff ff       	call   80112f <syscall>
  8011b2:	83 c4 18             	add    $0x18,%esp
}
  8011b5:	c9                   	leave  
  8011b6:	c3                   	ret    

008011b7 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8011b7:	55                   	push   %ebp
  8011b8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8011ba:	6a 00                	push   $0x0
  8011bc:	6a 00                	push   $0x0
  8011be:	6a 00                	push   $0x0
  8011c0:	6a 00                	push   $0x0
  8011c2:	6a 00                	push   $0x0
  8011c4:	6a 02                	push   $0x2
  8011c6:	e8 64 ff ff ff       	call   80112f <syscall>
  8011cb:	83 c4 18             	add    $0x18,%esp
}
  8011ce:	c9                   	leave  
  8011cf:	c3                   	ret    

008011d0 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8011d0:	55                   	push   %ebp
  8011d1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8011d3:	6a 00                	push   $0x0
  8011d5:	6a 00                	push   $0x0
  8011d7:	6a 00                	push   $0x0
  8011d9:	6a 00                	push   $0x0
  8011db:	6a 00                	push   $0x0
  8011dd:	6a 03                	push   $0x3
  8011df:	e8 4b ff ff ff       	call   80112f <syscall>
  8011e4:	83 c4 18             	add    $0x18,%esp
}
  8011e7:	c9                   	leave  
  8011e8:	c3                   	ret    

008011e9 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8011e9:	55                   	push   %ebp
  8011ea:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8011ec:	6a 00                	push   $0x0
  8011ee:	6a 00                	push   $0x0
  8011f0:	6a 00                	push   $0x0
  8011f2:	6a 00                	push   $0x0
  8011f4:	6a 00                	push   $0x0
  8011f6:	6a 04                	push   $0x4
  8011f8:	e8 32 ff ff ff       	call   80112f <syscall>
  8011fd:	83 c4 18             	add    $0x18,%esp
}
  801200:	c9                   	leave  
  801201:	c3                   	ret    

00801202 <sys_env_exit>:


void sys_env_exit(void)
{
  801202:	55                   	push   %ebp
  801203:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801205:	6a 00                	push   $0x0
  801207:	6a 00                	push   $0x0
  801209:	6a 00                	push   $0x0
  80120b:	6a 00                	push   $0x0
  80120d:	6a 00                	push   $0x0
  80120f:	6a 06                	push   $0x6
  801211:	e8 19 ff ff ff       	call   80112f <syscall>
  801216:	83 c4 18             	add    $0x18,%esp
}
  801219:	90                   	nop
  80121a:	c9                   	leave  
  80121b:	c3                   	ret    

0080121c <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80121c:	55                   	push   %ebp
  80121d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80121f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801222:	8b 45 08             	mov    0x8(%ebp),%eax
  801225:	6a 00                	push   $0x0
  801227:	6a 00                	push   $0x0
  801229:	6a 00                	push   $0x0
  80122b:	52                   	push   %edx
  80122c:	50                   	push   %eax
  80122d:	6a 07                	push   $0x7
  80122f:	e8 fb fe ff ff       	call   80112f <syscall>
  801234:	83 c4 18             	add    $0x18,%esp
}
  801237:	c9                   	leave  
  801238:	c3                   	ret    

00801239 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801239:	55                   	push   %ebp
  80123a:	89 e5                	mov    %esp,%ebp
  80123c:	56                   	push   %esi
  80123d:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80123e:	8b 75 18             	mov    0x18(%ebp),%esi
  801241:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801244:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801247:	8b 55 0c             	mov    0xc(%ebp),%edx
  80124a:	8b 45 08             	mov    0x8(%ebp),%eax
  80124d:	56                   	push   %esi
  80124e:	53                   	push   %ebx
  80124f:	51                   	push   %ecx
  801250:	52                   	push   %edx
  801251:	50                   	push   %eax
  801252:	6a 08                	push   $0x8
  801254:	e8 d6 fe ff ff       	call   80112f <syscall>
  801259:	83 c4 18             	add    $0x18,%esp
}
  80125c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80125f:	5b                   	pop    %ebx
  801260:	5e                   	pop    %esi
  801261:	5d                   	pop    %ebp
  801262:	c3                   	ret    

00801263 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801263:	55                   	push   %ebp
  801264:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801266:	8b 55 0c             	mov    0xc(%ebp),%edx
  801269:	8b 45 08             	mov    0x8(%ebp),%eax
  80126c:	6a 00                	push   $0x0
  80126e:	6a 00                	push   $0x0
  801270:	6a 00                	push   $0x0
  801272:	52                   	push   %edx
  801273:	50                   	push   %eax
  801274:	6a 09                	push   $0x9
  801276:	e8 b4 fe ff ff       	call   80112f <syscall>
  80127b:	83 c4 18             	add    $0x18,%esp
}
  80127e:	c9                   	leave  
  80127f:	c3                   	ret    

00801280 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801280:	55                   	push   %ebp
  801281:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801283:	6a 00                	push   $0x0
  801285:	6a 00                	push   $0x0
  801287:	6a 00                	push   $0x0
  801289:	ff 75 0c             	pushl  0xc(%ebp)
  80128c:	ff 75 08             	pushl  0x8(%ebp)
  80128f:	6a 0a                	push   $0xa
  801291:	e8 99 fe ff ff       	call   80112f <syscall>
  801296:	83 c4 18             	add    $0x18,%esp
}
  801299:	c9                   	leave  
  80129a:	c3                   	ret    

0080129b <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80129b:	55                   	push   %ebp
  80129c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80129e:	6a 00                	push   $0x0
  8012a0:	6a 00                	push   $0x0
  8012a2:	6a 00                	push   $0x0
  8012a4:	6a 00                	push   $0x0
  8012a6:	6a 00                	push   $0x0
  8012a8:	6a 0b                	push   $0xb
  8012aa:	e8 80 fe ff ff       	call   80112f <syscall>
  8012af:	83 c4 18             	add    $0x18,%esp
}
  8012b2:	c9                   	leave  
  8012b3:	c3                   	ret    

008012b4 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8012b4:	55                   	push   %ebp
  8012b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8012b7:	6a 00                	push   $0x0
  8012b9:	6a 00                	push   $0x0
  8012bb:	6a 00                	push   $0x0
  8012bd:	6a 00                	push   $0x0
  8012bf:	6a 00                	push   $0x0
  8012c1:	6a 0c                	push   $0xc
  8012c3:	e8 67 fe ff ff       	call   80112f <syscall>
  8012c8:	83 c4 18             	add    $0x18,%esp
}
  8012cb:	c9                   	leave  
  8012cc:	c3                   	ret    

008012cd <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8012cd:	55                   	push   %ebp
  8012ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8012d0:	6a 00                	push   $0x0
  8012d2:	6a 00                	push   $0x0
  8012d4:	6a 00                	push   $0x0
  8012d6:	6a 00                	push   $0x0
  8012d8:	6a 00                	push   $0x0
  8012da:	6a 0d                	push   $0xd
  8012dc:	e8 4e fe ff ff       	call   80112f <syscall>
  8012e1:	83 c4 18             	add    $0x18,%esp
}
  8012e4:	c9                   	leave  
  8012e5:	c3                   	ret    

008012e6 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8012e6:	55                   	push   %ebp
  8012e7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8012e9:	6a 00                	push   $0x0
  8012eb:	6a 00                	push   $0x0
  8012ed:	6a 00                	push   $0x0
  8012ef:	ff 75 0c             	pushl  0xc(%ebp)
  8012f2:	ff 75 08             	pushl  0x8(%ebp)
  8012f5:	6a 11                	push   $0x11
  8012f7:	e8 33 fe ff ff       	call   80112f <syscall>
  8012fc:	83 c4 18             	add    $0x18,%esp
	return;
  8012ff:	90                   	nop
}
  801300:	c9                   	leave  
  801301:	c3                   	ret    

00801302 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801302:	55                   	push   %ebp
  801303:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801305:	6a 00                	push   $0x0
  801307:	6a 00                	push   $0x0
  801309:	6a 00                	push   $0x0
  80130b:	ff 75 0c             	pushl  0xc(%ebp)
  80130e:	ff 75 08             	pushl  0x8(%ebp)
  801311:	6a 12                	push   $0x12
  801313:	e8 17 fe ff ff       	call   80112f <syscall>
  801318:	83 c4 18             	add    $0x18,%esp
	return ;
  80131b:	90                   	nop
}
  80131c:	c9                   	leave  
  80131d:	c3                   	ret    

0080131e <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80131e:	55                   	push   %ebp
  80131f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801321:	6a 00                	push   $0x0
  801323:	6a 00                	push   $0x0
  801325:	6a 00                	push   $0x0
  801327:	6a 00                	push   $0x0
  801329:	6a 00                	push   $0x0
  80132b:	6a 0e                	push   $0xe
  80132d:	e8 fd fd ff ff       	call   80112f <syscall>
  801332:	83 c4 18             	add    $0x18,%esp
}
  801335:	c9                   	leave  
  801336:	c3                   	ret    

00801337 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801337:	55                   	push   %ebp
  801338:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80133a:	6a 00                	push   $0x0
  80133c:	6a 00                	push   $0x0
  80133e:	6a 00                	push   $0x0
  801340:	6a 00                	push   $0x0
  801342:	ff 75 08             	pushl  0x8(%ebp)
  801345:	6a 0f                	push   $0xf
  801347:	e8 e3 fd ff ff       	call   80112f <syscall>
  80134c:	83 c4 18             	add    $0x18,%esp
}
  80134f:	c9                   	leave  
  801350:	c3                   	ret    

00801351 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801351:	55                   	push   %ebp
  801352:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801354:	6a 00                	push   $0x0
  801356:	6a 00                	push   $0x0
  801358:	6a 00                	push   $0x0
  80135a:	6a 00                	push   $0x0
  80135c:	6a 00                	push   $0x0
  80135e:	6a 10                	push   $0x10
  801360:	e8 ca fd ff ff       	call   80112f <syscall>
  801365:	83 c4 18             	add    $0x18,%esp
}
  801368:	90                   	nop
  801369:	c9                   	leave  
  80136a:	c3                   	ret    

0080136b <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80136b:	55                   	push   %ebp
  80136c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80136e:	6a 00                	push   $0x0
  801370:	6a 00                	push   $0x0
  801372:	6a 00                	push   $0x0
  801374:	6a 00                	push   $0x0
  801376:	6a 00                	push   $0x0
  801378:	6a 14                	push   $0x14
  80137a:	e8 b0 fd ff ff       	call   80112f <syscall>
  80137f:	83 c4 18             	add    $0x18,%esp
}
  801382:	90                   	nop
  801383:	c9                   	leave  
  801384:	c3                   	ret    

00801385 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801385:	55                   	push   %ebp
  801386:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801388:	6a 00                	push   $0x0
  80138a:	6a 00                	push   $0x0
  80138c:	6a 00                	push   $0x0
  80138e:	6a 00                	push   $0x0
  801390:	6a 00                	push   $0x0
  801392:	6a 15                	push   $0x15
  801394:	e8 96 fd ff ff       	call   80112f <syscall>
  801399:	83 c4 18             	add    $0x18,%esp
}
  80139c:	90                   	nop
  80139d:	c9                   	leave  
  80139e:	c3                   	ret    

0080139f <sys_cputc>:


void
sys_cputc(const char c)
{
  80139f:	55                   	push   %ebp
  8013a0:	89 e5                	mov    %esp,%ebp
  8013a2:	83 ec 04             	sub    $0x4,%esp
  8013a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8013ab:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8013af:	6a 00                	push   $0x0
  8013b1:	6a 00                	push   $0x0
  8013b3:	6a 00                	push   $0x0
  8013b5:	6a 00                	push   $0x0
  8013b7:	50                   	push   %eax
  8013b8:	6a 16                	push   $0x16
  8013ba:	e8 70 fd ff ff       	call   80112f <syscall>
  8013bf:	83 c4 18             	add    $0x18,%esp
}
  8013c2:	90                   	nop
  8013c3:	c9                   	leave  
  8013c4:	c3                   	ret    

008013c5 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8013c5:	55                   	push   %ebp
  8013c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8013c8:	6a 00                	push   $0x0
  8013ca:	6a 00                	push   $0x0
  8013cc:	6a 00                	push   $0x0
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 17                	push   $0x17
  8013d4:	e8 56 fd ff ff       	call   80112f <syscall>
  8013d9:	83 c4 18             	add    $0x18,%esp
}
  8013dc:	90                   	nop
  8013dd:	c9                   	leave  
  8013de:	c3                   	ret    

008013df <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8013df:	55                   	push   %ebp
  8013e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8013e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e5:	6a 00                	push   $0x0
  8013e7:	6a 00                	push   $0x0
  8013e9:	6a 00                	push   $0x0
  8013eb:	ff 75 0c             	pushl  0xc(%ebp)
  8013ee:	50                   	push   %eax
  8013ef:	6a 18                	push   $0x18
  8013f1:	e8 39 fd ff ff       	call   80112f <syscall>
  8013f6:	83 c4 18             	add    $0x18,%esp
}
  8013f9:	c9                   	leave  
  8013fa:	c3                   	ret    

008013fb <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8013fb:	55                   	push   %ebp
  8013fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8013fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801401:	8b 45 08             	mov    0x8(%ebp),%eax
  801404:	6a 00                	push   $0x0
  801406:	6a 00                	push   $0x0
  801408:	6a 00                	push   $0x0
  80140a:	52                   	push   %edx
  80140b:	50                   	push   %eax
  80140c:	6a 1b                	push   $0x1b
  80140e:	e8 1c fd ff ff       	call   80112f <syscall>
  801413:	83 c4 18             	add    $0x18,%esp
}
  801416:	c9                   	leave  
  801417:	c3                   	ret    

00801418 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801418:	55                   	push   %ebp
  801419:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80141b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80141e:	8b 45 08             	mov    0x8(%ebp),%eax
  801421:	6a 00                	push   $0x0
  801423:	6a 00                	push   $0x0
  801425:	6a 00                	push   $0x0
  801427:	52                   	push   %edx
  801428:	50                   	push   %eax
  801429:	6a 19                	push   $0x19
  80142b:	e8 ff fc ff ff       	call   80112f <syscall>
  801430:	83 c4 18             	add    $0x18,%esp
}
  801433:	90                   	nop
  801434:	c9                   	leave  
  801435:	c3                   	ret    

00801436 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801436:	55                   	push   %ebp
  801437:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801439:	8b 55 0c             	mov    0xc(%ebp),%edx
  80143c:	8b 45 08             	mov    0x8(%ebp),%eax
  80143f:	6a 00                	push   $0x0
  801441:	6a 00                	push   $0x0
  801443:	6a 00                	push   $0x0
  801445:	52                   	push   %edx
  801446:	50                   	push   %eax
  801447:	6a 1a                	push   $0x1a
  801449:	e8 e1 fc ff ff       	call   80112f <syscall>
  80144e:	83 c4 18             	add    $0x18,%esp
}
  801451:	90                   	nop
  801452:	c9                   	leave  
  801453:	c3                   	ret    

00801454 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801454:	55                   	push   %ebp
  801455:	89 e5                	mov    %esp,%ebp
  801457:	83 ec 04             	sub    $0x4,%esp
  80145a:	8b 45 10             	mov    0x10(%ebp),%eax
  80145d:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801460:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801463:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801467:	8b 45 08             	mov    0x8(%ebp),%eax
  80146a:	6a 00                	push   $0x0
  80146c:	51                   	push   %ecx
  80146d:	52                   	push   %edx
  80146e:	ff 75 0c             	pushl  0xc(%ebp)
  801471:	50                   	push   %eax
  801472:	6a 1c                	push   $0x1c
  801474:	e8 b6 fc ff ff       	call   80112f <syscall>
  801479:	83 c4 18             	add    $0x18,%esp
}
  80147c:	c9                   	leave  
  80147d:	c3                   	ret    

0080147e <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80147e:	55                   	push   %ebp
  80147f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801481:	8b 55 0c             	mov    0xc(%ebp),%edx
  801484:	8b 45 08             	mov    0x8(%ebp),%eax
  801487:	6a 00                	push   $0x0
  801489:	6a 00                	push   $0x0
  80148b:	6a 00                	push   $0x0
  80148d:	52                   	push   %edx
  80148e:	50                   	push   %eax
  80148f:	6a 1d                	push   $0x1d
  801491:	e8 99 fc ff ff       	call   80112f <syscall>
  801496:	83 c4 18             	add    $0x18,%esp
}
  801499:	c9                   	leave  
  80149a:	c3                   	ret    

0080149b <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80149b:	55                   	push   %ebp
  80149c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80149e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8014a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	51                   	push   %ecx
  8014ac:	52                   	push   %edx
  8014ad:	50                   	push   %eax
  8014ae:	6a 1e                	push   $0x1e
  8014b0:	e8 7a fc ff ff       	call   80112f <syscall>
  8014b5:	83 c4 18             	add    $0x18,%esp
}
  8014b8:	c9                   	leave  
  8014b9:	c3                   	ret    

008014ba <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8014ba:	55                   	push   %ebp
  8014bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8014bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 00                	push   $0x0
  8014c7:	6a 00                	push   $0x0
  8014c9:	52                   	push   %edx
  8014ca:	50                   	push   %eax
  8014cb:	6a 1f                	push   $0x1f
  8014cd:	e8 5d fc ff ff       	call   80112f <syscall>
  8014d2:	83 c4 18             	add    $0x18,%esp
}
  8014d5:	c9                   	leave  
  8014d6:	c3                   	ret    

008014d7 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8014d7:	55                   	push   %ebp
  8014d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8014da:	6a 00                	push   $0x0
  8014dc:	6a 00                	push   $0x0
  8014de:	6a 00                	push   $0x0
  8014e0:	6a 00                	push   $0x0
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 20                	push   $0x20
  8014e6:	e8 44 fc ff ff       	call   80112f <syscall>
  8014eb:	83 c4 18             	add    $0x18,%esp
}
  8014ee:	c9                   	leave  
  8014ef:	c3                   	ret    

008014f0 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8014f0:	55                   	push   %ebp
  8014f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8014f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f6:	6a 00                	push   $0x0
  8014f8:	ff 75 14             	pushl  0x14(%ebp)
  8014fb:	ff 75 10             	pushl  0x10(%ebp)
  8014fe:	ff 75 0c             	pushl  0xc(%ebp)
  801501:	50                   	push   %eax
  801502:	6a 21                	push   $0x21
  801504:	e8 26 fc ff ff       	call   80112f <syscall>
  801509:	83 c4 18             	add    $0x18,%esp
}
  80150c:	c9                   	leave  
  80150d:	c3                   	ret    

0080150e <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80150e:	55                   	push   %ebp
  80150f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801511:	8b 45 08             	mov    0x8(%ebp),%eax
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	6a 00                	push   $0x0
  80151c:	50                   	push   %eax
  80151d:	6a 22                	push   $0x22
  80151f:	e8 0b fc ff ff       	call   80112f <syscall>
  801524:	83 c4 18             	add    $0x18,%esp
}
  801527:	90                   	nop
  801528:	c9                   	leave  
  801529:	c3                   	ret    

0080152a <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80152a:	55                   	push   %ebp
  80152b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80152d:	8b 45 08             	mov    0x8(%ebp),%eax
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	50                   	push   %eax
  801539:	6a 23                	push   $0x23
  80153b:	e8 ef fb ff ff       	call   80112f <syscall>
  801540:	83 c4 18             	add    $0x18,%esp
}
  801543:	90                   	nop
  801544:	c9                   	leave  
  801545:	c3                   	ret    

00801546 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801546:	55                   	push   %ebp
  801547:	89 e5                	mov    %esp,%ebp
  801549:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80154c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80154f:	8d 50 04             	lea    0x4(%eax),%edx
  801552:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801555:	6a 00                	push   $0x0
  801557:	6a 00                	push   $0x0
  801559:	6a 00                	push   $0x0
  80155b:	52                   	push   %edx
  80155c:	50                   	push   %eax
  80155d:	6a 24                	push   $0x24
  80155f:	e8 cb fb ff ff       	call   80112f <syscall>
  801564:	83 c4 18             	add    $0x18,%esp
	return result;
  801567:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80156a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80156d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801570:	89 01                	mov    %eax,(%ecx)
  801572:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801575:	8b 45 08             	mov    0x8(%ebp),%eax
  801578:	c9                   	leave  
  801579:	c2 04 00             	ret    $0x4

0080157c <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80157c:	55                   	push   %ebp
  80157d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80157f:	6a 00                	push   $0x0
  801581:	6a 00                	push   $0x0
  801583:	ff 75 10             	pushl  0x10(%ebp)
  801586:	ff 75 0c             	pushl  0xc(%ebp)
  801589:	ff 75 08             	pushl  0x8(%ebp)
  80158c:	6a 13                	push   $0x13
  80158e:	e8 9c fb ff ff       	call   80112f <syscall>
  801593:	83 c4 18             	add    $0x18,%esp
	return ;
  801596:	90                   	nop
}
  801597:	c9                   	leave  
  801598:	c3                   	ret    

00801599 <sys_rcr2>:
uint32 sys_rcr2()
{
  801599:	55                   	push   %ebp
  80159a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80159c:	6a 00                	push   $0x0
  80159e:	6a 00                	push   $0x0
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 25                	push   $0x25
  8015a8:	e8 82 fb ff ff       	call   80112f <syscall>
  8015ad:	83 c4 18             	add    $0x18,%esp
}
  8015b0:	c9                   	leave  
  8015b1:	c3                   	ret    

008015b2 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8015b2:	55                   	push   %ebp
  8015b3:	89 e5                	mov    %esp,%ebp
  8015b5:	83 ec 04             	sub    $0x4,%esp
  8015b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8015be:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8015c2:	6a 00                	push   $0x0
  8015c4:	6a 00                	push   $0x0
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	50                   	push   %eax
  8015cb:	6a 26                	push   $0x26
  8015cd:	e8 5d fb ff ff       	call   80112f <syscall>
  8015d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8015d5:	90                   	nop
}
  8015d6:	c9                   	leave  
  8015d7:	c3                   	ret    

008015d8 <rsttst>:
void rsttst()
{
  8015d8:	55                   	push   %ebp
  8015d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8015db:	6a 00                	push   $0x0
  8015dd:	6a 00                	push   $0x0
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 28                	push   $0x28
  8015e7:	e8 43 fb ff ff       	call   80112f <syscall>
  8015ec:	83 c4 18             	add    $0x18,%esp
	return ;
  8015ef:	90                   	nop
}
  8015f0:	c9                   	leave  
  8015f1:	c3                   	ret    

008015f2 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8015f2:	55                   	push   %ebp
  8015f3:	89 e5                	mov    %esp,%ebp
  8015f5:	83 ec 04             	sub    $0x4,%esp
  8015f8:	8b 45 14             	mov    0x14(%ebp),%eax
  8015fb:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8015fe:	8b 55 18             	mov    0x18(%ebp),%edx
  801601:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801605:	52                   	push   %edx
  801606:	50                   	push   %eax
  801607:	ff 75 10             	pushl  0x10(%ebp)
  80160a:	ff 75 0c             	pushl  0xc(%ebp)
  80160d:	ff 75 08             	pushl  0x8(%ebp)
  801610:	6a 27                	push   $0x27
  801612:	e8 18 fb ff ff       	call   80112f <syscall>
  801617:	83 c4 18             	add    $0x18,%esp
	return ;
  80161a:	90                   	nop
}
  80161b:	c9                   	leave  
  80161c:	c3                   	ret    

0080161d <chktst>:
void chktst(uint32 n)
{
  80161d:	55                   	push   %ebp
  80161e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801620:	6a 00                	push   $0x0
  801622:	6a 00                	push   $0x0
  801624:	6a 00                	push   $0x0
  801626:	6a 00                	push   $0x0
  801628:	ff 75 08             	pushl  0x8(%ebp)
  80162b:	6a 29                	push   $0x29
  80162d:	e8 fd fa ff ff       	call   80112f <syscall>
  801632:	83 c4 18             	add    $0x18,%esp
	return ;
  801635:	90                   	nop
}
  801636:	c9                   	leave  
  801637:	c3                   	ret    

00801638 <inctst>:

void inctst()
{
  801638:	55                   	push   %ebp
  801639:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80163b:	6a 00                	push   $0x0
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	6a 00                	push   $0x0
  801643:	6a 00                	push   $0x0
  801645:	6a 2a                	push   $0x2a
  801647:	e8 e3 fa ff ff       	call   80112f <syscall>
  80164c:	83 c4 18             	add    $0x18,%esp
	return ;
  80164f:	90                   	nop
}
  801650:	c9                   	leave  
  801651:	c3                   	ret    

00801652 <gettst>:
uint32 gettst()
{
  801652:	55                   	push   %ebp
  801653:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801655:	6a 00                	push   $0x0
  801657:	6a 00                	push   $0x0
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	6a 00                	push   $0x0
  80165f:	6a 2b                	push   $0x2b
  801661:	e8 c9 fa ff ff       	call   80112f <syscall>
  801666:	83 c4 18             	add    $0x18,%esp
}
  801669:	c9                   	leave  
  80166a:	c3                   	ret    

0080166b <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80166b:	55                   	push   %ebp
  80166c:	89 e5                	mov    %esp,%ebp
  80166e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801671:	6a 00                	push   $0x0
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	6a 2c                	push   $0x2c
  80167d:	e8 ad fa ff ff       	call   80112f <syscall>
  801682:	83 c4 18             	add    $0x18,%esp
  801685:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801688:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80168c:	75 07                	jne    801695 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80168e:	b8 01 00 00 00       	mov    $0x1,%eax
  801693:	eb 05                	jmp    80169a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801695:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80169a:	c9                   	leave  
  80169b:	c3                   	ret    

0080169c <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80169c:	55                   	push   %ebp
  80169d:	89 e5                	mov    %esp,%ebp
  80169f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016a2:	6a 00                	push   $0x0
  8016a4:	6a 00                	push   $0x0
  8016a6:	6a 00                	push   $0x0
  8016a8:	6a 00                	push   $0x0
  8016aa:	6a 00                	push   $0x0
  8016ac:	6a 2c                	push   $0x2c
  8016ae:	e8 7c fa ff ff       	call   80112f <syscall>
  8016b3:	83 c4 18             	add    $0x18,%esp
  8016b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8016b9:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8016bd:	75 07                	jne    8016c6 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8016bf:	b8 01 00 00 00       	mov    $0x1,%eax
  8016c4:	eb 05                	jmp    8016cb <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8016c6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016cb:	c9                   	leave  
  8016cc:	c3                   	ret    

008016cd <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8016cd:	55                   	push   %ebp
  8016ce:	89 e5                	mov    %esp,%ebp
  8016d0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 00                	push   $0x0
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 2c                	push   $0x2c
  8016df:	e8 4b fa ff ff       	call   80112f <syscall>
  8016e4:	83 c4 18             	add    $0x18,%esp
  8016e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8016ea:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8016ee:	75 07                	jne    8016f7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8016f0:	b8 01 00 00 00       	mov    $0x1,%eax
  8016f5:	eb 05                	jmp    8016fc <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8016f7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016fc:	c9                   	leave  
  8016fd:	c3                   	ret    

008016fe <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8016fe:	55                   	push   %ebp
  8016ff:	89 e5                	mov    %esp,%ebp
  801701:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	6a 00                	push   $0x0
  80170a:	6a 00                	push   $0x0
  80170c:	6a 00                	push   $0x0
  80170e:	6a 2c                	push   $0x2c
  801710:	e8 1a fa ff ff       	call   80112f <syscall>
  801715:	83 c4 18             	add    $0x18,%esp
  801718:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80171b:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80171f:	75 07                	jne    801728 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801721:	b8 01 00 00 00       	mov    $0x1,%eax
  801726:	eb 05                	jmp    80172d <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801728:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80172d:	c9                   	leave  
  80172e:	c3                   	ret    

0080172f <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80172f:	55                   	push   %ebp
  801730:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801732:	6a 00                	push   $0x0
  801734:	6a 00                	push   $0x0
  801736:	6a 00                	push   $0x0
  801738:	6a 00                	push   $0x0
  80173a:	ff 75 08             	pushl  0x8(%ebp)
  80173d:	6a 2d                	push   $0x2d
  80173f:	e8 eb f9 ff ff       	call   80112f <syscall>
  801744:	83 c4 18             	add    $0x18,%esp
	return ;
  801747:	90                   	nop
}
  801748:	c9                   	leave  
  801749:	c3                   	ret    

0080174a <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80174a:	55                   	push   %ebp
  80174b:	89 e5                	mov    %esp,%ebp
  80174d:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80174e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801751:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801754:	8b 55 0c             	mov    0xc(%ebp),%edx
  801757:	8b 45 08             	mov    0x8(%ebp),%eax
  80175a:	6a 00                	push   $0x0
  80175c:	53                   	push   %ebx
  80175d:	51                   	push   %ecx
  80175e:	52                   	push   %edx
  80175f:	50                   	push   %eax
  801760:	6a 2e                	push   $0x2e
  801762:	e8 c8 f9 ff ff       	call   80112f <syscall>
  801767:	83 c4 18             	add    $0x18,%esp
}
  80176a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80176d:	c9                   	leave  
  80176e:	c3                   	ret    

0080176f <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80176f:	55                   	push   %ebp
  801770:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801772:	8b 55 0c             	mov    0xc(%ebp),%edx
  801775:	8b 45 08             	mov    0x8(%ebp),%eax
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	52                   	push   %edx
  80177f:	50                   	push   %eax
  801780:	6a 2f                	push   $0x2f
  801782:	e8 a8 f9 ff ff       	call   80112f <syscall>
  801787:	83 c4 18             	add    $0x18,%esp
}
  80178a:	c9                   	leave  
  80178b:	c3                   	ret    

0080178c <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  80178c:	55                   	push   %ebp
  80178d:	89 e5                	mov    %esp,%ebp
  80178f:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801792:	8b 55 08             	mov    0x8(%ebp),%edx
  801795:	89 d0                	mov    %edx,%eax
  801797:	c1 e0 02             	shl    $0x2,%eax
  80179a:	01 d0                	add    %edx,%eax
  80179c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8017a3:	01 d0                	add    %edx,%eax
  8017a5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8017ac:	01 d0                	add    %edx,%eax
  8017ae:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8017b5:	01 d0                	add    %edx,%eax
  8017b7:	c1 e0 04             	shl    $0x4,%eax
  8017ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8017bd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8017c4:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8017c7:	83 ec 0c             	sub    $0xc,%esp
  8017ca:	50                   	push   %eax
  8017cb:	e8 76 fd ff ff       	call   801546 <sys_get_virtual_time>
  8017d0:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8017d3:	eb 41                	jmp    801816 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8017d5:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8017d8:	83 ec 0c             	sub    $0xc,%esp
  8017db:	50                   	push   %eax
  8017dc:	e8 65 fd ff ff       	call   801546 <sys_get_virtual_time>
  8017e1:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8017e4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8017e7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8017ea:	29 c2                	sub    %eax,%edx
  8017ec:	89 d0                	mov    %edx,%eax
  8017ee:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8017f1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8017f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8017f7:	89 d1                	mov    %edx,%ecx
  8017f9:	29 c1                	sub    %eax,%ecx
  8017fb:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8017fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801801:	39 c2                	cmp    %eax,%edx
  801803:	0f 97 c0             	seta   %al
  801806:	0f b6 c0             	movzbl %al,%eax
  801809:	29 c1                	sub    %eax,%ecx
  80180b:	89 c8                	mov    %ecx,%eax
  80180d:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801810:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801813:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801816:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801819:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80181c:	72 b7                	jb     8017d5 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  80181e:	90                   	nop
  80181f:	c9                   	leave  
  801820:	c3                   	ret    

00801821 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801821:	55                   	push   %ebp
  801822:	89 e5                	mov    %esp,%ebp
  801824:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801827:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  80182e:	eb 03                	jmp    801833 <busy_wait+0x12>
  801830:	ff 45 fc             	incl   -0x4(%ebp)
  801833:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801836:	3b 45 08             	cmp    0x8(%ebp),%eax
  801839:	72 f5                	jb     801830 <busy_wait+0xf>
	return i;
  80183b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80183e:	c9                   	leave  
  80183f:	c3                   	ret    

00801840 <__udivdi3>:
  801840:	55                   	push   %ebp
  801841:	57                   	push   %edi
  801842:	56                   	push   %esi
  801843:	53                   	push   %ebx
  801844:	83 ec 1c             	sub    $0x1c,%esp
  801847:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80184b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80184f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801853:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801857:	89 ca                	mov    %ecx,%edx
  801859:	89 f8                	mov    %edi,%eax
  80185b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80185f:	85 f6                	test   %esi,%esi
  801861:	75 2d                	jne    801890 <__udivdi3+0x50>
  801863:	39 cf                	cmp    %ecx,%edi
  801865:	77 65                	ja     8018cc <__udivdi3+0x8c>
  801867:	89 fd                	mov    %edi,%ebp
  801869:	85 ff                	test   %edi,%edi
  80186b:	75 0b                	jne    801878 <__udivdi3+0x38>
  80186d:	b8 01 00 00 00       	mov    $0x1,%eax
  801872:	31 d2                	xor    %edx,%edx
  801874:	f7 f7                	div    %edi
  801876:	89 c5                	mov    %eax,%ebp
  801878:	31 d2                	xor    %edx,%edx
  80187a:	89 c8                	mov    %ecx,%eax
  80187c:	f7 f5                	div    %ebp
  80187e:	89 c1                	mov    %eax,%ecx
  801880:	89 d8                	mov    %ebx,%eax
  801882:	f7 f5                	div    %ebp
  801884:	89 cf                	mov    %ecx,%edi
  801886:	89 fa                	mov    %edi,%edx
  801888:	83 c4 1c             	add    $0x1c,%esp
  80188b:	5b                   	pop    %ebx
  80188c:	5e                   	pop    %esi
  80188d:	5f                   	pop    %edi
  80188e:	5d                   	pop    %ebp
  80188f:	c3                   	ret    
  801890:	39 ce                	cmp    %ecx,%esi
  801892:	77 28                	ja     8018bc <__udivdi3+0x7c>
  801894:	0f bd fe             	bsr    %esi,%edi
  801897:	83 f7 1f             	xor    $0x1f,%edi
  80189a:	75 40                	jne    8018dc <__udivdi3+0x9c>
  80189c:	39 ce                	cmp    %ecx,%esi
  80189e:	72 0a                	jb     8018aa <__udivdi3+0x6a>
  8018a0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8018a4:	0f 87 9e 00 00 00    	ja     801948 <__udivdi3+0x108>
  8018aa:	b8 01 00 00 00       	mov    $0x1,%eax
  8018af:	89 fa                	mov    %edi,%edx
  8018b1:	83 c4 1c             	add    $0x1c,%esp
  8018b4:	5b                   	pop    %ebx
  8018b5:	5e                   	pop    %esi
  8018b6:	5f                   	pop    %edi
  8018b7:	5d                   	pop    %ebp
  8018b8:	c3                   	ret    
  8018b9:	8d 76 00             	lea    0x0(%esi),%esi
  8018bc:	31 ff                	xor    %edi,%edi
  8018be:	31 c0                	xor    %eax,%eax
  8018c0:	89 fa                	mov    %edi,%edx
  8018c2:	83 c4 1c             	add    $0x1c,%esp
  8018c5:	5b                   	pop    %ebx
  8018c6:	5e                   	pop    %esi
  8018c7:	5f                   	pop    %edi
  8018c8:	5d                   	pop    %ebp
  8018c9:	c3                   	ret    
  8018ca:	66 90                	xchg   %ax,%ax
  8018cc:	89 d8                	mov    %ebx,%eax
  8018ce:	f7 f7                	div    %edi
  8018d0:	31 ff                	xor    %edi,%edi
  8018d2:	89 fa                	mov    %edi,%edx
  8018d4:	83 c4 1c             	add    $0x1c,%esp
  8018d7:	5b                   	pop    %ebx
  8018d8:	5e                   	pop    %esi
  8018d9:	5f                   	pop    %edi
  8018da:	5d                   	pop    %ebp
  8018db:	c3                   	ret    
  8018dc:	bd 20 00 00 00       	mov    $0x20,%ebp
  8018e1:	89 eb                	mov    %ebp,%ebx
  8018e3:	29 fb                	sub    %edi,%ebx
  8018e5:	89 f9                	mov    %edi,%ecx
  8018e7:	d3 e6                	shl    %cl,%esi
  8018e9:	89 c5                	mov    %eax,%ebp
  8018eb:	88 d9                	mov    %bl,%cl
  8018ed:	d3 ed                	shr    %cl,%ebp
  8018ef:	89 e9                	mov    %ebp,%ecx
  8018f1:	09 f1                	or     %esi,%ecx
  8018f3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8018f7:	89 f9                	mov    %edi,%ecx
  8018f9:	d3 e0                	shl    %cl,%eax
  8018fb:	89 c5                	mov    %eax,%ebp
  8018fd:	89 d6                	mov    %edx,%esi
  8018ff:	88 d9                	mov    %bl,%cl
  801901:	d3 ee                	shr    %cl,%esi
  801903:	89 f9                	mov    %edi,%ecx
  801905:	d3 e2                	shl    %cl,%edx
  801907:	8b 44 24 08          	mov    0x8(%esp),%eax
  80190b:	88 d9                	mov    %bl,%cl
  80190d:	d3 e8                	shr    %cl,%eax
  80190f:	09 c2                	or     %eax,%edx
  801911:	89 d0                	mov    %edx,%eax
  801913:	89 f2                	mov    %esi,%edx
  801915:	f7 74 24 0c          	divl   0xc(%esp)
  801919:	89 d6                	mov    %edx,%esi
  80191b:	89 c3                	mov    %eax,%ebx
  80191d:	f7 e5                	mul    %ebp
  80191f:	39 d6                	cmp    %edx,%esi
  801921:	72 19                	jb     80193c <__udivdi3+0xfc>
  801923:	74 0b                	je     801930 <__udivdi3+0xf0>
  801925:	89 d8                	mov    %ebx,%eax
  801927:	31 ff                	xor    %edi,%edi
  801929:	e9 58 ff ff ff       	jmp    801886 <__udivdi3+0x46>
  80192e:	66 90                	xchg   %ax,%ax
  801930:	8b 54 24 08          	mov    0x8(%esp),%edx
  801934:	89 f9                	mov    %edi,%ecx
  801936:	d3 e2                	shl    %cl,%edx
  801938:	39 c2                	cmp    %eax,%edx
  80193a:	73 e9                	jae    801925 <__udivdi3+0xe5>
  80193c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80193f:	31 ff                	xor    %edi,%edi
  801941:	e9 40 ff ff ff       	jmp    801886 <__udivdi3+0x46>
  801946:	66 90                	xchg   %ax,%ax
  801948:	31 c0                	xor    %eax,%eax
  80194a:	e9 37 ff ff ff       	jmp    801886 <__udivdi3+0x46>
  80194f:	90                   	nop

00801950 <__umoddi3>:
  801950:	55                   	push   %ebp
  801951:	57                   	push   %edi
  801952:	56                   	push   %esi
  801953:	53                   	push   %ebx
  801954:	83 ec 1c             	sub    $0x1c,%esp
  801957:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80195b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80195f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801963:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801967:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80196b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80196f:	89 f3                	mov    %esi,%ebx
  801971:	89 fa                	mov    %edi,%edx
  801973:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801977:	89 34 24             	mov    %esi,(%esp)
  80197a:	85 c0                	test   %eax,%eax
  80197c:	75 1a                	jne    801998 <__umoddi3+0x48>
  80197e:	39 f7                	cmp    %esi,%edi
  801980:	0f 86 a2 00 00 00    	jbe    801a28 <__umoddi3+0xd8>
  801986:	89 c8                	mov    %ecx,%eax
  801988:	89 f2                	mov    %esi,%edx
  80198a:	f7 f7                	div    %edi
  80198c:	89 d0                	mov    %edx,%eax
  80198e:	31 d2                	xor    %edx,%edx
  801990:	83 c4 1c             	add    $0x1c,%esp
  801993:	5b                   	pop    %ebx
  801994:	5e                   	pop    %esi
  801995:	5f                   	pop    %edi
  801996:	5d                   	pop    %ebp
  801997:	c3                   	ret    
  801998:	39 f0                	cmp    %esi,%eax
  80199a:	0f 87 ac 00 00 00    	ja     801a4c <__umoddi3+0xfc>
  8019a0:	0f bd e8             	bsr    %eax,%ebp
  8019a3:	83 f5 1f             	xor    $0x1f,%ebp
  8019a6:	0f 84 ac 00 00 00    	je     801a58 <__umoddi3+0x108>
  8019ac:	bf 20 00 00 00       	mov    $0x20,%edi
  8019b1:	29 ef                	sub    %ebp,%edi
  8019b3:	89 fe                	mov    %edi,%esi
  8019b5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8019b9:	89 e9                	mov    %ebp,%ecx
  8019bb:	d3 e0                	shl    %cl,%eax
  8019bd:	89 d7                	mov    %edx,%edi
  8019bf:	89 f1                	mov    %esi,%ecx
  8019c1:	d3 ef                	shr    %cl,%edi
  8019c3:	09 c7                	or     %eax,%edi
  8019c5:	89 e9                	mov    %ebp,%ecx
  8019c7:	d3 e2                	shl    %cl,%edx
  8019c9:	89 14 24             	mov    %edx,(%esp)
  8019cc:	89 d8                	mov    %ebx,%eax
  8019ce:	d3 e0                	shl    %cl,%eax
  8019d0:	89 c2                	mov    %eax,%edx
  8019d2:	8b 44 24 08          	mov    0x8(%esp),%eax
  8019d6:	d3 e0                	shl    %cl,%eax
  8019d8:	89 44 24 04          	mov    %eax,0x4(%esp)
  8019dc:	8b 44 24 08          	mov    0x8(%esp),%eax
  8019e0:	89 f1                	mov    %esi,%ecx
  8019e2:	d3 e8                	shr    %cl,%eax
  8019e4:	09 d0                	or     %edx,%eax
  8019e6:	d3 eb                	shr    %cl,%ebx
  8019e8:	89 da                	mov    %ebx,%edx
  8019ea:	f7 f7                	div    %edi
  8019ec:	89 d3                	mov    %edx,%ebx
  8019ee:	f7 24 24             	mull   (%esp)
  8019f1:	89 c6                	mov    %eax,%esi
  8019f3:	89 d1                	mov    %edx,%ecx
  8019f5:	39 d3                	cmp    %edx,%ebx
  8019f7:	0f 82 87 00 00 00    	jb     801a84 <__umoddi3+0x134>
  8019fd:	0f 84 91 00 00 00    	je     801a94 <__umoddi3+0x144>
  801a03:	8b 54 24 04          	mov    0x4(%esp),%edx
  801a07:	29 f2                	sub    %esi,%edx
  801a09:	19 cb                	sbb    %ecx,%ebx
  801a0b:	89 d8                	mov    %ebx,%eax
  801a0d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801a11:	d3 e0                	shl    %cl,%eax
  801a13:	89 e9                	mov    %ebp,%ecx
  801a15:	d3 ea                	shr    %cl,%edx
  801a17:	09 d0                	or     %edx,%eax
  801a19:	89 e9                	mov    %ebp,%ecx
  801a1b:	d3 eb                	shr    %cl,%ebx
  801a1d:	89 da                	mov    %ebx,%edx
  801a1f:	83 c4 1c             	add    $0x1c,%esp
  801a22:	5b                   	pop    %ebx
  801a23:	5e                   	pop    %esi
  801a24:	5f                   	pop    %edi
  801a25:	5d                   	pop    %ebp
  801a26:	c3                   	ret    
  801a27:	90                   	nop
  801a28:	89 fd                	mov    %edi,%ebp
  801a2a:	85 ff                	test   %edi,%edi
  801a2c:	75 0b                	jne    801a39 <__umoddi3+0xe9>
  801a2e:	b8 01 00 00 00       	mov    $0x1,%eax
  801a33:	31 d2                	xor    %edx,%edx
  801a35:	f7 f7                	div    %edi
  801a37:	89 c5                	mov    %eax,%ebp
  801a39:	89 f0                	mov    %esi,%eax
  801a3b:	31 d2                	xor    %edx,%edx
  801a3d:	f7 f5                	div    %ebp
  801a3f:	89 c8                	mov    %ecx,%eax
  801a41:	f7 f5                	div    %ebp
  801a43:	89 d0                	mov    %edx,%eax
  801a45:	e9 44 ff ff ff       	jmp    80198e <__umoddi3+0x3e>
  801a4a:	66 90                	xchg   %ax,%ax
  801a4c:	89 c8                	mov    %ecx,%eax
  801a4e:	89 f2                	mov    %esi,%edx
  801a50:	83 c4 1c             	add    $0x1c,%esp
  801a53:	5b                   	pop    %ebx
  801a54:	5e                   	pop    %esi
  801a55:	5f                   	pop    %edi
  801a56:	5d                   	pop    %ebp
  801a57:	c3                   	ret    
  801a58:	3b 04 24             	cmp    (%esp),%eax
  801a5b:	72 06                	jb     801a63 <__umoddi3+0x113>
  801a5d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801a61:	77 0f                	ja     801a72 <__umoddi3+0x122>
  801a63:	89 f2                	mov    %esi,%edx
  801a65:	29 f9                	sub    %edi,%ecx
  801a67:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801a6b:	89 14 24             	mov    %edx,(%esp)
  801a6e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a72:	8b 44 24 04          	mov    0x4(%esp),%eax
  801a76:	8b 14 24             	mov    (%esp),%edx
  801a79:	83 c4 1c             	add    $0x1c,%esp
  801a7c:	5b                   	pop    %ebx
  801a7d:	5e                   	pop    %esi
  801a7e:	5f                   	pop    %edi
  801a7f:	5d                   	pop    %ebp
  801a80:	c3                   	ret    
  801a81:	8d 76 00             	lea    0x0(%esi),%esi
  801a84:	2b 04 24             	sub    (%esp),%eax
  801a87:	19 fa                	sbb    %edi,%edx
  801a89:	89 d1                	mov    %edx,%ecx
  801a8b:	89 c6                	mov    %eax,%esi
  801a8d:	e9 71 ff ff ff       	jmp    801a03 <__umoddi3+0xb3>
  801a92:	66 90                	xchg   %ax,%ax
  801a94:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801a98:	72 ea                	jb     801a84 <__umoddi3+0x134>
  801a9a:	89 d9                	mov    %ebx,%ecx
  801a9c:	e9 62 ff ff ff       	jmp    801a03 <__umoddi3+0xb3>
