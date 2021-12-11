
obj/user/tst_semaphore_2master:     file format elf32-i386


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
  800031:	e8 8e 01 00 00       	call   8001c4 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Master program: take user input, create the semaphores, run slaves and wait them to finish
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 28 01 00 00    	sub    $0x128,%esp
	int envID = sys_getenvid();
  800041:	e8 7d 15 00 00       	call   8015c3 <sys_getenvid>
  800046:	89 45 f0             	mov    %eax,-0x10(%ebp)
	char line[256] ;
	readline("Enter total number of customers: ", line) ;
  800049:	83 ec 08             	sub    $0x8,%esp
  80004c:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
  800052:	50                   	push   %eax
  800053:	68 a0 1e 80 00       	push   $0x801ea0
  800058:	e8 d0 0b 00 00       	call   800c2d <readline>
  80005d:	83 c4 10             	add    $0x10,%esp
	int totalNumOfCusts = strtol(line, NULL, 10);
  800060:	83 ec 04             	sub    $0x4,%esp
  800063:	6a 0a                	push   $0xa
  800065:	6a 00                	push   $0x0
  800067:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
  80006d:	50                   	push   %eax
  80006e:	e8 20 11 00 00       	call   801193 <strtol>
  800073:	83 c4 10             	add    $0x10,%esp
  800076:	89 45 ec             	mov    %eax,-0x14(%ebp)
	readline("Enter shop capacity: ", line) ;
  800079:	83 ec 08             	sub    $0x8,%esp
  80007c:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
  800082:	50                   	push   %eax
  800083:	68 c2 1e 80 00       	push   $0x801ec2
  800088:	e8 a0 0b 00 00       	call   800c2d <readline>
  80008d:	83 c4 10             	add    $0x10,%esp
	int shopCapacity = strtol(line, NULL, 10);
  800090:	83 ec 04             	sub    $0x4,%esp
  800093:	6a 0a                	push   $0xa
  800095:	6a 00                	push   $0x0
  800097:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
  80009d:	50                   	push   %eax
  80009e:	e8 f0 10 00 00       	call   801193 <strtol>
  8000a3:	83 c4 10             	add    $0x10,%esp
  8000a6:	89 45 e8             	mov    %eax,-0x18(%ebp)

	sys_createSemaphore("shopCapacity", shopCapacity);
  8000a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000ac:	83 ec 08             	sub    $0x8,%esp
  8000af:	50                   	push   %eax
  8000b0:	68 d8 1e 80 00       	push   $0x801ed8
  8000b5:	e8 31 17 00 00       	call   8017eb <sys_createSemaphore>
  8000ba:	83 c4 10             	add    $0x10,%esp
	sys_createSemaphore("depend", 0);
  8000bd:	83 ec 08             	sub    $0x8,%esp
  8000c0:	6a 00                	push   $0x0
  8000c2:	68 e5 1e 80 00       	push   $0x801ee5
  8000c7:	e8 1f 17 00 00       	call   8017eb <sys_createSemaphore>
  8000cc:	83 c4 10             	add    $0x10,%esp

	int i = 0 ;
  8000cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int id ;
	for (; i<totalNumOfCusts; i++)
  8000d6:	eb 5e                	jmp    800136 <_main+0xfe>
	{
		id = sys_create_env("sem2Slave", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  8000d8:	a1 20 30 80 00       	mov    0x803020,%eax
  8000dd:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8000e3:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e8:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000ee:	89 c1                	mov    %eax,%ecx
  8000f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000f5:	8b 40 74             	mov    0x74(%eax),%eax
  8000f8:	52                   	push   %edx
  8000f9:	51                   	push   %ecx
  8000fa:	50                   	push   %eax
  8000fb:	68 ec 1e 80 00       	push   $0x801eec
  800100:	e8 f7 17 00 00       	call   8018fc <sys_create_env>
  800105:	83 c4 10             	add    $0x10,%esp
  800108:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		if (id == E_ENV_CREATION_ERROR)
  80010b:	83 7d e4 ef          	cmpl   $0xffffffef,-0x1c(%ebp)
  80010f:	75 14                	jne    800125 <_main+0xed>
			panic("NO AVAILABLE ENVs... Please reduce the number of customers and try again...");
  800111:	83 ec 04             	sub    $0x4,%esp
  800114:	68 f8 1e 80 00       	push   $0x801ef8
  800119:	6a 18                	push   $0x18
  80011b:	68 44 1f 80 00       	push   $0x801f44
  800120:	e8 e4 01 00 00       	call   800309 <_panic>
		sys_run_env(id) ;
  800125:	83 ec 0c             	sub    $0xc,%esp
  800128:	ff 75 e4             	pushl  -0x1c(%ebp)
  80012b:	e8 ea 17 00 00       	call   80191a <sys_run_env>
  800130:	83 c4 10             	add    $0x10,%esp
	sys_createSemaphore("shopCapacity", shopCapacity);
	sys_createSemaphore("depend", 0);

	int i = 0 ;
	int id ;
	for (; i<totalNumOfCusts; i++)
  800133:	ff 45 f4             	incl   -0xc(%ebp)
  800136:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800139:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  80013c:	7c 9a                	jl     8000d8 <_main+0xa0>
		if (id == E_ENV_CREATION_ERROR)
			panic("NO AVAILABLE ENVs... Please reduce the number of customers and try again...");
		sys_run_env(id) ;
	}

	for (i = 0 ; i<totalNumOfCusts; i++)
  80013e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800145:	eb 16                	jmp    80015d <_main+0x125>
	{
		sys_waitSemaphore(envID, "depend") ;
  800147:	83 ec 08             	sub    $0x8,%esp
  80014a:	68 e5 1e 80 00       	push   $0x801ee5
  80014f:	ff 75 f0             	pushl  -0x10(%ebp)
  800152:	e8 cd 16 00 00       	call   801824 <sys_waitSemaphore>
  800157:	83 c4 10             	add    $0x10,%esp
		if (id == E_ENV_CREATION_ERROR)
			panic("NO AVAILABLE ENVs... Please reduce the number of customers and try again...");
		sys_run_env(id) ;
	}

	for (i = 0 ; i<totalNumOfCusts; i++)
  80015a:	ff 45 f4             	incl   -0xc(%ebp)
  80015d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800160:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  800163:	7c e2                	jl     800147 <_main+0x10f>
	{
		sys_waitSemaphore(envID, "depend") ;
	}
	int sem1val = sys_getSemaphoreValue(envID, "shopCapacity");
  800165:	83 ec 08             	sub    $0x8,%esp
  800168:	68 d8 1e 80 00       	push   $0x801ed8
  80016d:	ff 75 f0             	pushl  -0x10(%ebp)
  800170:	e8 92 16 00 00       	call   801807 <sys_getSemaphoreValue>
  800175:	83 c4 10             	add    $0x10,%esp
  800178:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int sem2val = sys_getSemaphoreValue(envID, "depend");
  80017b:	83 ec 08             	sub    $0x8,%esp
  80017e:	68 e5 1e 80 00       	push   $0x801ee5
  800183:	ff 75 f0             	pushl  -0x10(%ebp)
  800186:	e8 7c 16 00 00       	call   801807 <sys_getSemaphoreValue>
  80018b:	83 c4 10             	add    $0x10,%esp
  80018e:	89 45 dc             	mov    %eax,-0x24(%ebp)
	if (sem2val == 0 && sem1val == shopCapacity)
  800191:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800195:	75 1a                	jne    8001b1 <_main+0x179>
  800197:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80019a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80019d:	75 12                	jne    8001b1 <_main+0x179>
		cprintf("Congratulations!! Test of Semaphores [2] completed successfully!!\n\n\n");
  80019f:	83 ec 0c             	sub    $0xc,%esp
  8001a2:	68 64 1f 80 00       	push   $0x801f64
  8001a7:	e8 ff 03 00 00       	call   8005ab <cprintf>
  8001ac:	83 c4 10             	add    $0x10,%esp
  8001af:	eb 10                	jmp    8001c1 <_main+0x189>
	else
		cprintf("Error: wrong semaphore value... please review your semaphore code again...");
  8001b1:	83 ec 0c             	sub    $0xc,%esp
  8001b4:	68 ac 1f 80 00       	push   $0x801fac
  8001b9:	e8 ed 03 00 00       	call   8005ab <cprintf>
  8001be:	83 c4 10             	add    $0x10,%esp

	return;
  8001c1:	90                   	nop
}
  8001c2:	c9                   	leave  
  8001c3:	c3                   	ret    

008001c4 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8001c4:	55                   	push   %ebp
  8001c5:	89 e5                	mov    %esp,%ebp
  8001c7:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001ca:	e8 0d 14 00 00       	call   8015dc <sys_getenvindex>
  8001cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001d2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001d5:	89 d0                	mov    %edx,%eax
  8001d7:	c1 e0 03             	shl    $0x3,%eax
  8001da:	01 d0                	add    %edx,%eax
  8001dc:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8001e3:	01 c8                	add    %ecx,%eax
  8001e5:	01 c0                	add    %eax,%eax
  8001e7:	01 d0                	add    %edx,%eax
  8001e9:	01 c0                	add    %eax,%eax
  8001eb:	01 d0                	add    %edx,%eax
  8001ed:	89 c2                	mov    %eax,%edx
  8001ef:	c1 e2 05             	shl    $0x5,%edx
  8001f2:	29 c2                	sub    %eax,%edx
  8001f4:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8001fb:	89 c2                	mov    %eax,%edx
  8001fd:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800203:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800208:	a1 20 30 80 00       	mov    0x803020,%eax
  80020d:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800213:	84 c0                	test   %al,%al
  800215:	74 0f                	je     800226 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800217:	a1 20 30 80 00       	mov    0x803020,%eax
  80021c:	05 40 3c 01 00       	add    $0x13c40,%eax
  800221:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800226:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80022a:	7e 0a                	jle    800236 <libmain+0x72>
		binaryname = argv[0];
  80022c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80022f:	8b 00                	mov    (%eax),%eax
  800231:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800236:	83 ec 08             	sub    $0x8,%esp
  800239:	ff 75 0c             	pushl  0xc(%ebp)
  80023c:	ff 75 08             	pushl  0x8(%ebp)
  80023f:	e8 f4 fd ff ff       	call   800038 <_main>
  800244:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800247:	e8 2b 15 00 00       	call   801777 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80024c:	83 ec 0c             	sub    $0xc,%esp
  80024f:	68 10 20 80 00       	push   $0x802010
  800254:	e8 52 03 00 00       	call   8005ab <cprintf>
  800259:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80025c:	a1 20 30 80 00       	mov    0x803020,%eax
  800261:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800267:	a1 20 30 80 00       	mov    0x803020,%eax
  80026c:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800272:	83 ec 04             	sub    $0x4,%esp
  800275:	52                   	push   %edx
  800276:	50                   	push   %eax
  800277:	68 38 20 80 00       	push   $0x802038
  80027c:	e8 2a 03 00 00       	call   8005ab <cprintf>
  800281:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800284:	a1 20 30 80 00       	mov    0x803020,%eax
  800289:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80028f:	a1 20 30 80 00       	mov    0x803020,%eax
  800294:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80029a:	83 ec 04             	sub    $0x4,%esp
  80029d:	52                   	push   %edx
  80029e:	50                   	push   %eax
  80029f:	68 60 20 80 00       	push   $0x802060
  8002a4:	e8 02 03 00 00       	call   8005ab <cprintf>
  8002a9:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8002ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b1:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8002b7:	83 ec 08             	sub    $0x8,%esp
  8002ba:	50                   	push   %eax
  8002bb:	68 a1 20 80 00       	push   $0x8020a1
  8002c0:	e8 e6 02 00 00       	call   8005ab <cprintf>
  8002c5:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8002c8:	83 ec 0c             	sub    $0xc,%esp
  8002cb:	68 10 20 80 00       	push   $0x802010
  8002d0:	e8 d6 02 00 00       	call   8005ab <cprintf>
  8002d5:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002d8:	e8 b4 14 00 00       	call   801791 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002dd:	e8 19 00 00 00       	call   8002fb <exit>
}
  8002e2:	90                   	nop
  8002e3:	c9                   	leave  
  8002e4:	c3                   	ret    

008002e5 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002e5:	55                   	push   %ebp
  8002e6:	89 e5                	mov    %esp,%ebp
  8002e8:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002eb:	83 ec 0c             	sub    $0xc,%esp
  8002ee:	6a 00                	push   $0x0
  8002f0:	e8 b3 12 00 00       	call   8015a8 <sys_env_destroy>
  8002f5:	83 c4 10             	add    $0x10,%esp
}
  8002f8:	90                   	nop
  8002f9:	c9                   	leave  
  8002fa:	c3                   	ret    

008002fb <exit>:

void
exit(void)
{
  8002fb:	55                   	push   %ebp
  8002fc:	89 e5                	mov    %esp,%ebp
  8002fe:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800301:	e8 08 13 00 00       	call   80160e <sys_env_exit>
}
  800306:	90                   	nop
  800307:	c9                   	leave  
  800308:	c3                   	ret    

00800309 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800309:	55                   	push   %ebp
  80030a:	89 e5                	mov    %esp,%ebp
  80030c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80030f:	8d 45 10             	lea    0x10(%ebp),%eax
  800312:	83 c0 04             	add    $0x4,%eax
  800315:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800318:	a1 18 31 80 00       	mov    0x803118,%eax
  80031d:	85 c0                	test   %eax,%eax
  80031f:	74 16                	je     800337 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800321:	a1 18 31 80 00       	mov    0x803118,%eax
  800326:	83 ec 08             	sub    $0x8,%esp
  800329:	50                   	push   %eax
  80032a:	68 b8 20 80 00       	push   $0x8020b8
  80032f:	e8 77 02 00 00       	call   8005ab <cprintf>
  800334:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800337:	a1 00 30 80 00       	mov    0x803000,%eax
  80033c:	ff 75 0c             	pushl  0xc(%ebp)
  80033f:	ff 75 08             	pushl  0x8(%ebp)
  800342:	50                   	push   %eax
  800343:	68 bd 20 80 00       	push   $0x8020bd
  800348:	e8 5e 02 00 00       	call   8005ab <cprintf>
  80034d:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800350:	8b 45 10             	mov    0x10(%ebp),%eax
  800353:	83 ec 08             	sub    $0x8,%esp
  800356:	ff 75 f4             	pushl  -0xc(%ebp)
  800359:	50                   	push   %eax
  80035a:	e8 e1 01 00 00       	call   800540 <vcprintf>
  80035f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800362:	83 ec 08             	sub    $0x8,%esp
  800365:	6a 00                	push   $0x0
  800367:	68 d9 20 80 00       	push   $0x8020d9
  80036c:	e8 cf 01 00 00       	call   800540 <vcprintf>
  800371:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800374:	e8 82 ff ff ff       	call   8002fb <exit>

	// should not return here
	while (1) ;
  800379:	eb fe                	jmp    800379 <_panic+0x70>

0080037b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80037b:	55                   	push   %ebp
  80037c:	89 e5                	mov    %esp,%ebp
  80037e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800381:	a1 20 30 80 00       	mov    0x803020,%eax
  800386:	8b 50 74             	mov    0x74(%eax),%edx
  800389:	8b 45 0c             	mov    0xc(%ebp),%eax
  80038c:	39 c2                	cmp    %eax,%edx
  80038e:	74 14                	je     8003a4 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800390:	83 ec 04             	sub    $0x4,%esp
  800393:	68 dc 20 80 00       	push   $0x8020dc
  800398:	6a 26                	push   $0x26
  80039a:	68 28 21 80 00       	push   $0x802128
  80039f:	e8 65 ff ff ff       	call   800309 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8003a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8003ab:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8003b2:	e9 b6 00 00 00       	jmp    80046d <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8003b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003ba:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c4:	01 d0                	add    %edx,%eax
  8003c6:	8b 00                	mov    (%eax),%eax
  8003c8:	85 c0                	test   %eax,%eax
  8003ca:	75 08                	jne    8003d4 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8003cc:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8003cf:	e9 96 00 00 00       	jmp    80046a <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8003d4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003db:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8003e2:	eb 5d                	jmp    800441 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8003e4:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e9:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003ef:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003f2:	c1 e2 04             	shl    $0x4,%edx
  8003f5:	01 d0                	add    %edx,%eax
  8003f7:	8a 40 04             	mov    0x4(%eax),%al
  8003fa:	84 c0                	test   %al,%al
  8003fc:	75 40                	jne    80043e <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003fe:	a1 20 30 80 00       	mov    0x803020,%eax
  800403:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800409:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80040c:	c1 e2 04             	shl    $0x4,%edx
  80040f:	01 d0                	add    %edx,%eax
  800411:	8b 00                	mov    (%eax),%eax
  800413:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800416:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800419:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80041e:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800420:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800423:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80042a:	8b 45 08             	mov    0x8(%ebp),%eax
  80042d:	01 c8                	add    %ecx,%eax
  80042f:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800431:	39 c2                	cmp    %eax,%edx
  800433:	75 09                	jne    80043e <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800435:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80043c:	eb 12                	jmp    800450 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80043e:	ff 45 e8             	incl   -0x18(%ebp)
  800441:	a1 20 30 80 00       	mov    0x803020,%eax
  800446:	8b 50 74             	mov    0x74(%eax),%edx
  800449:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80044c:	39 c2                	cmp    %eax,%edx
  80044e:	77 94                	ja     8003e4 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800450:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800454:	75 14                	jne    80046a <CheckWSWithoutLastIndex+0xef>
			panic(
  800456:	83 ec 04             	sub    $0x4,%esp
  800459:	68 34 21 80 00       	push   $0x802134
  80045e:	6a 3a                	push   $0x3a
  800460:	68 28 21 80 00       	push   $0x802128
  800465:	e8 9f fe ff ff       	call   800309 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80046a:	ff 45 f0             	incl   -0x10(%ebp)
  80046d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800470:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800473:	0f 8c 3e ff ff ff    	jl     8003b7 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800479:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800480:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800487:	eb 20                	jmp    8004a9 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800489:	a1 20 30 80 00       	mov    0x803020,%eax
  80048e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800494:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800497:	c1 e2 04             	shl    $0x4,%edx
  80049a:	01 d0                	add    %edx,%eax
  80049c:	8a 40 04             	mov    0x4(%eax),%al
  80049f:	3c 01                	cmp    $0x1,%al
  8004a1:	75 03                	jne    8004a6 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8004a3:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004a6:	ff 45 e0             	incl   -0x20(%ebp)
  8004a9:	a1 20 30 80 00       	mov    0x803020,%eax
  8004ae:	8b 50 74             	mov    0x74(%eax),%edx
  8004b1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004b4:	39 c2                	cmp    %eax,%edx
  8004b6:	77 d1                	ja     800489 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8004b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004bb:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004be:	74 14                	je     8004d4 <CheckWSWithoutLastIndex+0x159>
		panic(
  8004c0:	83 ec 04             	sub    $0x4,%esp
  8004c3:	68 88 21 80 00       	push   $0x802188
  8004c8:	6a 44                	push   $0x44
  8004ca:	68 28 21 80 00       	push   $0x802128
  8004cf:	e8 35 fe ff ff       	call   800309 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8004d4:	90                   	nop
  8004d5:	c9                   	leave  
  8004d6:	c3                   	ret    

008004d7 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8004d7:	55                   	push   %ebp
  8004d8:	89 e5                	mov    %esp,%ebp
  8004da:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8004dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004e0:	8b 00                	mov    (%eax),%eax
  8004e2:	8d 48 01             	lea    0x1(%eax),%ecx
  8004e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004e8:	89 0a                	mov    %ecx,(%edx)
  8004ea:	8b 55 08             	mov    0x8(%ebp),%edx
  8004ed:	88 d1                	mov    %dl,%cl
  8004ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004f2:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f9:	8b 00                	mov    (%eax),%eax
  8004fb:	3d ff 00 00 00       	cmp    $0xff,%eax
  800500:	75 2c                	jne    80052e <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800502:	a0 24 30 80 00       	mov    0x803024,%al
  800507:	0f b6 c0             	movzbl %al,%eax
  80050a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80050d:	8b 12                	mov    (%edx),%edx
  80050f:	89 d1                	mov    %edx,%ecx
  800511:	8b 55 0c             	mov    0xc(%ebp),%edx
  800514:	83 c2 08             	add    $0x8,%edx
  800517:	83 ec 04             	sub    $0x4,%esp
  80051a:	50                   	push   %eax
  80051b:	51                   	push   %ecx
  80051c:	52                   	push   %edx
  80051d:	e8 44 10 00 00       	call   801566 <sys_cputs>
  800522:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800525:	8b 45 0c             	mov    0xc(%ebp),%eax
  800528:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80052e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800531:	8b 40 04             	mov    0x4(%eax),%eax
  800534:	8d 50 01             	lea    0x1(%eax),%edx
  800537:	8b 45 0c             	mov    0xc(%ebp),%eax
  80053a:	89 50 04             	mov    %edx,0x4(%eax)
}
  80053d:	90                   	nop
  80053e:	c9                   	leave  
  80053f:	c3                   	ret    

00800540 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800540:	55                   	push   %ebp
  800541:	89 e5                	mov    %esp,%ebp
  800543:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800549:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800550:	00 00 00 
	b.cnt = 0;
  800553:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80055a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80055d:	ff 75 0c             	pushl  0xc(%ebp)
  800560:	ff 75 08             	pushl  0x8(%ebp)
  800563:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800569:	50                   	push   %eax
  80056a:	68 d7 04 80 00       	push   $0x8004d7
  80056f:	e8 11 02 00 00       	call   800785 <vprintfmt>
  800574:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800577:	a0 24 30 80 00       	mov    0x803024,%al
  80057c:	0f b6 c0             	movzbl %al,%eax
  80057f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800585:	83 ec 04             	sub    $0x4,%esp
  800588:	50                   	push   %eax
  800589:	52                   	push   %edx
  80058a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800590:	83 c0 08             	add    $0x8,%eax
  800593:	50                   	push   %eax
  800594:	e8 cd 0f 00 00       	call   801566 <sys_cputs>
  800599:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80059c:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8005a3:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005a9:	c9                   	leave  
  8005aa:	c3                   	ret    

008005ab <cprintf>:

int cprintf(const char *fmt, ...) {
  8005ab:	55                   	push   %ebp
  8005ac:	89 e5                	mov    %esp,%ebp
  8005ae:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005b1:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8005b8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005be:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c1:	83 ec 08             	sub    $0x8,%esp
  8005c4:	ff 75 f4             	pushl  -0xc(%ebp)
  8005c7:	50                   	push   %eax
  8005c8:	e8 73 ff ff ff       	call   800540 <vcprintf>
  8005cd:	83 c4 10             	add    $0x10,%esp
  8005d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005d6:	c9                   	leave  
  8005d7:	c3                   	ret    

008005d8 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8005d8:	55                   	push   %ebp
  8005d9:	89 e5                	mov    %esp,%ebp
  8005db:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005de:	e8 94 11 00 00       	call   801777 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8005e3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ec:	83 ec 08             	sub    $0x8,%esp
  8005ef:	ff 75 f4             	pushl  -0xc(%ebp)
  8005f2:	50                   	push   %eax
  8005f3:	e8 48 ff ff ff       	call   800540 <vcprintf>
  8005f8:	83 c4 10             	add    $0x10,%esp
  8005fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8005fe:	e8 8e 11 00 00       	call   801791 <sys_enable_interrupt>
	return cnt;
  800603:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800606:	c9                   	leave  
  800607:	c3                   	ret    

00800608 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800608:	55                   	push   %ebp
  800609:	89 e5                	mov    %esp,%ebp
  80060b:	53                   	push   %ebx
  80060c:	83 ec 14             	sub    $0x14,%esp
  80060f:	8b 45 10             	mov    0x10(%ebp),%eax
  800612:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800615:	8b 45 14             	mov    0x14(%ebp),%eax
  800618:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80061b:	8b 45 18             	mov    0x18(%ebp),%eax
  80061e:	ba 00 00 00 00       	mov    $0x0,%edx
  800623:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800626:	77 55                	ja     80067d <printnum+0x75>
  800628:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80062b:	72 05                	jb     800632 <printnum+0x2a>
  80062d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800630:	77 4b                	ja     80067d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800632:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800635:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800638:	8b 45 18             	mov    0x18(%ebp),%eax
  80063b:	ba 00 00 00 00       	mov    $0x0,%edx
  800640:	52                   	push   %edx
  800641:	50                   	push   %eax
  800642:	ff 75 f4             	pushl  -0xc(%ebp)
  800645:	ff 75 f0             	pushl  -0x10(%ebp)
  800648:	e8 eb 15 00 00       	call   801c38 <__udivdi3>
  80064d:	83 c4 10             	add    $0x10,%esp
  800650:	83 ec 04             	sub    $0x4,%esp
  800653:	ff 75 20             	pushl  0x20(%ebp)
  800656:	53                   	push   %ebx
  800657:	ff 75 18             	pushl  0x18(%ebp)
  80065a:	52                   	push   %edx
  80065b:	50                   	push   %eax
  80065c:	ff 75 0c             	pushl  0xc(%ebp)
  80065f:	ff 75 08             	pushl  0x8(%ebp)
  800662:	e8 a1 ff ff ff       	call   800608 <printnum>
  800667:	83 c4 20             	add    $0x20,%esp
  80066a:	eb 1a                	jmp    800686 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80066c:	83 ec 08             	sub    $0x8,%esp
  80066f:	ff 75 0c             	pushl  0xc(%ebp)
  800672:	ff 75 20             	pushl  0x20(%ebp)
  800675:	8b 45 08             	mov    0x8(%ebp),%eax
  800678:	ff d0                	call   *%eax
  80067a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80067d:	ff 4d 1c             	decl   0x1c(%ebp)
  800680:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800684:	7f e6                	jg     80066c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800686:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800689:	bb 00 00 00 00       	mov    $0x0,%ebx
  80068e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800691:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800694:	53                   	push   %ebx
  800695:	51                   	push   %ecx
  800696:	52                   	push   %edx
  800697:	50                   	push   %eax
  800698:	e8 ab 16 00 00       	call   801d48 <__umoddi3>
  80069d:	83 c4 10             	add    $0x10,%esp
  8006a0:	05 f4 23 80 00       	add    $0x8023f4,%eax
  8006a5:	8a 00                	mov    (%eax),%al
  8006a7:	0f be c0             	movsbl %al,%eax
  8006aa:	83 ec 08             	sub    $0x8,%esp
  8006ad:	ff 75 0c             	pushl  0xc(%ebp)
  8006b0:	50                   	push   %eax
  8006b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b4:	ff d0                	call   *%eax
  8006b6:	83 c4 10             	add    $0x10,%esp
}
  8006b9:	90                   	nop
  8006ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006bd:	c9                   	leave  
  8006be:	c3                   	ret    

008006bf <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006bf:	55                   	push   %ebp
  8006c0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006c2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006c6:	7e 1c                	jle    8006e4 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8006c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cb:	8b 00                	mov    (%eax),%eax
  8006cd:	8d 50 08             	lea    0x8(%eax),%edx
  8006d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d3:	89 10                	mov    %edx,(%eax)
  8006d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d8:	8b 00                	mov    (%eax),%eax
  8006da:	83 e8 08             	sub    $0x8,%eax
  8006dd:	8b 50 04             	mov    0x4(%eax),%edx
  8006e0:	8b 00                	mov    (%eax),%eax
  8006e2:	eb 40                	jmp    800724 <getuint+0x65>
	else if (lflag)
  8006e4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006e8:	74 1e                	je     800708 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8006ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ed:	8b 00                	mov    (%eax),%eax
  8006ef:	8d 50 04             	lea    0x4(%eax),%edx
  8006f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f5:	89 10                	mov    %edx,(%eax)
  8006f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fa:	8b 00                	mov    (%eax),%eax
  8006fc:	83 e8 04             	sub    $0x4,%eax
  8006ff:	8b 00                	mov    (%eax),%eax
  800701:	ba 00 00 00 00       	mov    $0x0,%edx
  800706:	eb 1c                	jmp    800724 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800708:	8b 45 08             	mov    0x8(%ebp),%eax
  80070b:	8b 00                	mov    (%eax),%eax
  80070d:	8d 50 04             	lea    0x4(%eax),%edx
  800710:	8b 45 08             	mov    0x8(%ebp),%eax
  800713:	89 10                	mov    %edx,(%eax)
  800715:	8b 45 08             	mov    0x8(%ebp),%eax
  800718:	8b 00                	mov    (%eax),%eax
  80071a:	83 e8 04             	sub    $0x4,%eax
  80071d:	8b 00                	mov    (%eax),%eax
  80071f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800724:	5d                   	pop    %ebp
  800725:	c3                   	ret    

00800726 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800726:	55                   	push   %ebp
  800727:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800729:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80072d:	7e 1c                	jle    80074b <getint+0x25>
		return va_arg(*ap, long long);
  80072f:	8b 45 08             	mov    0x8(%ebp),%eax
  800732:	8b 00                	mov    (%eax),%eax
  800734:	8d 50 08             	lea    0x8(%eax),%edx
  800737:	8b 45 08             	mov    0x8(%ebp),%eax
  80073a:	89 10                	mov    %edx,(%eax)
  80073c:	8b 45 08             	mov    0x8(%ebp),%eax
  80073f:	8b 00                	mov    (%eax),%eax
  800741:	83 e8 08             	sub    $0x8,%eax
  800744:	8b 50 04             	mov    0x4(%eax),%edx
  800747:	8b 00                	mov    (%eax),%eax
  800749:	eb 38                	jmp    800783 <getint+0x5d>
	else if (lflag)
  80074b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80074f:	74 1a                	je     80076b <getint+0x45>
		return va_arg(*ap, long);
  800751:	8b 45 08             	mov    0x8(%ebp),%eax
  800754:	8b 00                	mov    (%eax),%eax
  800756:	8d 50 04             	lea    0x4(%eax),%edx
  800759:	8b 45 08             	mov    0x8(%ebp),%eax
  80075c:	89 10                	mov    %edx,(%eax)
  80075e:	8b 45 08             	mov    0x8(%ebp),%eax
  800761:	8b 00                	mov    (%eax),%eax
  800763:	83 e8 04             	sub    $0x4,%eax
  800766:	8b 00                	mov    (%eax),%eax
  800768:	99                   	cltd   
  800769:	eb 18                	jmp    800783 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80076b:	8b 45 08             	mov    0x8(%ebp),%eax
  80076e:	8b 00                	mov    (%eax),%eax
  800770:	8d 50 04             	lea    0x4(%eax),%edx
  800773:	8b 45 08             	mov    0x8(%ebp),%eax
  800776:	89 10                	mov    %edx,(%eax)
  800778:	8b 45 08             	mov    0x8(%ebp),%eax
  80077b:	8b 00                	mov    (%eax),%eax
  80077d:	83 e8 04             	sub    $0x4,%eax
  800780:	8b 00                	mov    (%eax),%eax
  800782:	99                   	cltd   
}
  800783:	5d                   	pop    %ebp
  800784:	c3                   	ret    

00800785 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800785:	55                   	push   %ebp
  800786:	89 e5                	mov    %esp,%ebp
  800788:	56                   	push   %esi
  800789:	53                   	push   %ebx
  80078a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80078d:	eb 17                	jmp    8007a6 <vprintfmt+0x21>
			if (ch == '\0')
  80078f:	85 db                	test   %ebx,%ebx
  800791:	0f 84 af 03 00 00    	je     800b46 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800797:	83 ec 08             	sub    $0x8,%esp
  80079a:	ff 75 0c             	pushl  0xc(%ebp)
  80079d:	53                   	push   %ebx
  80079e:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a1:	ff d0                	call   *%eax
  8007a3:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8007a9:	8d 50 01             	lea    0x1(%eax),%edx
  8007ac:	89 55 10             	mov    %edx,0x10(%ebp)
  8007af:	8a 00                	mov    (%eax),%al
  8007b1:	0f b6 d8             	movzbl %al,%ebx
  8007b4:	83 fb 25             	cmp    $0x25,%ebx
  8007b7:	75 d6                	jne    80078f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007b9:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007bd:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8007c4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8007cb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8007d2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8007d9:	8b 45 10             	mov    0x10(%ebp),%eax
  8007dc:	8d 50 01             	lea    0x1(%eax),%edx
  8007df:	89 55 10             	mov    %edx,0x10(%ebp)
  8007e2:	8a 00                	mov    (%eax),%al
  8007e4:	0f b6 d8             	movzbl %al,%ebx
  8007e7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8007ea:	83 f8 55             	cmp    $0x55,%eax
  8007ed:	0f 87 2b 03 00 00    	ja     800b1e <vprintfmt+0x399>
  8007f3:	8b 04 85 18 24 80 00 	mov    0x802418(,%eax,4),%eax
  8007fa:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8007fc:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800800:	eb d7                	jmp    8007d9 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800802:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800806:	eb d1                	jmp    8007d9 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800808:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80080f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800812:	89 d0                	mov    %edx,%eax
  800814:	c1 e0 02             	shl    $0x2,%eax
  800817:	01 d0                	add    %edx,%eax
  800819:	01 c0                	add    %eax,%eax
  80081b:	01 d8                	add    %ebx,%eax
  80081d:	83 e8 30             	sub    $0x30,%eax
  800820:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800823:	8b 45 10             	mov    0x10(%ebp),%eax
  800826:	8a 00                	mov    (%eax),%al
  800828:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80082b:	83 fb 2f             	cmp    $0x2f,%ebx
  80082e:	7e 3e                	jle    80086e <vprintfmt+0xe9>
  800830:	83 fb 39             	cmp    $0x39,%ebx
  800833:	7f 39                	jg     80086e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800835:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800838:	eb d5                	jmp    80080f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80083a:	8b 45 14             	mov    0x14(%ebp),%eax
  80083d:	83 c0 04             	add    $0x4,%eax
  800840:	89 45 14             	mov    %eax,0x14(%ebp)
  800843:	8b 45 14             	mov    0x14(%ebp),%eax
  800846:	83 e8 04             	sub    $0x4,%eax
  800849:	8b 00                	mov    (%eax),%eax
  80084b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80084e:	eb 1f                	jmp    80086f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800850:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800854:	79 83                	jns    8007d9 <vprintfmt+0x54>
				width = 0;
  800856:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80085d:	e9 77 ff ff ff       	jmp    8007d9 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800862:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800869:	e9 6b ff ff ff       	jmp    8007d9 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80086e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80086f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800873:	0f 89 60 ff ff ff    	jns    8007d9 <vprintfmt+0x54>
				width = precision, precision = -1;
  800879:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80087c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80087f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800886:	e9 4e ff ff ff       	jmp    8007d9 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80088b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80088e:	e9 46 ff ff ff       	jmp    8007d9 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800893:	8b 45 14             	mov    0x14(%ebp),%eax
  800896:	83 c0 04             	add    $0x4,%eax
  800899:	89 45 14             	mov    %eax,0x14(%ebp)
  80089c:	8b 45 14             	mov    0x14(%ebp),%eax
  80089f:	83 e8 04             	sub    $0x4,%eax
  8008a2:	8b 00                	mov    (%eax),%eax
  8008a4:	83 ec 08             	sub    $0x8,%esp
  8008a7:	ff 75 0c             	pushl  0xc(%ebp)
  8008aa:	50                   	push   %eax
  8008ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ae:	ff d0                	call   *%eax
  8008b0:	83 c4 10             	add    $0x10,%esp
			break;
  8008b3:	e9 89 02 00 00       	jmp    800b41 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8008b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8008bb:	83 c0 04             	add    $0x4,%eax
  8008be:	89 45 14             	mov    %eax,0x14(%ebp)
  8008c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8008c4:	83 e8 04             	sub    $0x4,%eax
  8008c7:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8008c9:	85 db                	test   %ebx,%ebx
  8008cb:	79 02                	jns    8008cf <vprintfmt+0x14a>
				err = -err;
  8008cd:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8008cf:	83 fb 64             	cmp    $0x64,%ebx
  8008d2:	7f 0b                	jg     8008df <vprintfmt+0x15a>
  8008d4:	8b 34 9d 60 22 80 00 	mov    0x802260(,%ebx,4),%esi
  8008db:	85 f6                	test   %esi,%esi
  8008dd:	75 19                	jne    8008f8 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8008df:	53                   	push   %ebx
  8008e0:	68 05 24 80 00       	push   $0x802405
  8008e5:	ff 75 0c             	pushl  0xc(%ebp)
  8008e8:	ff 75 08             	pushl  0x8(%ebp)
  8008eb:	e8 5e 02 00 00       	call   800b4e <printfmt>
  8008f0:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8008f3:	e9 49 02 00 00       	jmp    800b41 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8008f8:	56                   	push   %esi
  8008f9:	68 0e 24 80 00       	push   $0x80240e
  8008fe:	ff 75 0c             	pushl  0xc(%ebp)
  800901:	ff 75 08             	pushl  0x8(%ebp)
  800904:	e8 45 02 00 00       	call   800b4e <printfmt>
  800909:	83 c4 10             	add    $0x10,%esp
			break;
  80090c:	e9 30 02 00 00       	jmp    800b41 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800911:	8b 45 14             	mov    0x14(%ebp),%eax
  800914:	83 c0 04             	add    $0x4,%eax
  800917:	89 45 14             	mov    %eax,0x14(%ebp)
  80091a:	8b 45 14             	mov    0x14(%ebp),%eax
  80091d:	83 e8 04             	sub    $0x4,%eax
  800920:	8b 30                	mov    (%eax),%esi
  800922:	85 f6                	test   %esi,%esi
  800924:	75 05                	jne    80092b <vprintfmt+0x1a6>
				p = "(null)";
  800926:	be 11 24 80 00       	mov    $0x802411,%esi
			if (width > 0 && padc != '-')
  80092b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80092f:	7e 6d                	jle    80099e <vprintfmt+0x219>
  800931:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800935:	74 67                	je     80099e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800937:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80093a:	83 ec 08             	sub    $0x8,%esp
  80093d:	50                   	push   %eax
  80093e:	56                   	push   %esi
  80093f:	e8 12 05 00 00       	call   800e56 <strnlen>
  800944:	83 c4 10             	add    $0x10,%esp
  800947:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80094a:	eb 16                	jmp    800962 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80094c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800950:	83 ec 08             	sub    $0x8,%esp
  800953:	ff 75 0c             	pushl  0xc(%ebp)
  800956:	50                   	push   %eax
  800957:	8b 45 08             	mov    0x8(%ebp),%eax
  80095a:	ff d0                	call   *%eax
  80095c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80095f:	ff 4d e4             	decl   -0x1c(%ebp)
  800962:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800966:	7f e4                	jg     80094c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800968:	eb 34                	jmp    80099e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80096a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80096e:	74 1c                	je     80098c <vprintfmt+0x207>
  800970:	83 fb 1f             	cmp    $0x1f,%ebx
  800973:	7e 05                	jle    80097a <vprintfmt+0x1f5>
  800975:	83 fb 7e             	cmp    $0x7e,%ebx
  800978:	7e 12                	jle    80098c <vprintfmt+0x207>
					putch('?', putdat);
  80097a:	83 ec 08             	sub    $0x8,%esp
  80097d:	ff 75 0c             	pushl  0xc(%ebp)
  800980:	6a 3f                	push   $0x3f
  800982:	8b 45 08             	mov    0x8(%ebp),%eax
  800985:	ff d0                	call   *%eax
  800987:	83 c4 10             	add    $0x10,%esp
  80098a:	eb 0f                	jmp    80099b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80098c:	83 ec 08             	sub    $0x8,%esp
  80098f:	ff 75 0c             	pushl  0xc(%ebp)
  800992:	53                   	push   %ebx
  800993:	8b 45 08             	mov    0x8(%ebp),%eax
  800996:	ff d0                	call   *%eax
  800998:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80099b:	ff 4d e4             	decl   -0x1c(%ebp)
  80099e:	89 f0                	mov    %esi,%eax
  8009a0:	8d 70 01             	lea    0x1(%eax),%esi
  8009a3:	8a 00                	mov    (%eax),%al
  8009a5:	0f be d8             	movsbl %al,%ebx
  8009a8:	85 db                	test   %ebx,%ebx
  8009aa:	74 24                	je     8009d0 <vprintfmt+0x24b>
  8009ac:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009b0:	78 b8                	js     80096a <vprintfmt+0x1e5>
  8009b2:	ff 4d e0             	decl   -0x20(%ebp)
  8009b5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009b9:	79 af                	jns    80096a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009bb:	eb 13                	jmp    8009d0 <vprintfmt+0x24b>
				putch(' ', putdat);
  8009bd:	83 ec 08             	sub    $0x8,%esp
  8009c0:	ff 75 0c             	pushl  0xc(%ebp)
  8009c3:	6a 20                	push   $0x20
  8009c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c8:	ff d0                	call   *%eax
  8009ca:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009cd:	ff 4d e4             	decl   -0x1c(%ebp)
  8009d0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009d4:	7f e7                	jg     8009bd <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8009d6:	e9 66 01 00 00       	jmp    800b41 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8009db:	83 ec 08             	sub    $0x8,%esp
  8009de:	ff 75 e8             	pushl  -0x18(%ebp)
  8009e1:	8d 45 14             	lea    0x14(%ebp),%eax
  8009e4:	50                   	push   %eax
  8009e5:	e8 3c fd ff ff       	call   800726 <getint>
  8009ea:	83 c4 10             	add    $0x10,%esp
  8009ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009f0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8009f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009f9:	85 d2                	test   %edx,%edx
  8009fb:	79 23                	jns    800a20 <vprintfmt+0x29b>
				putch('-', putdat);
  8009fd:	83 ec 08             	sub    $0x8,%esp
  800a00:	ff 75 0c             	pushl  0xc(%ebp)
  800a03:	6a 2d                	push   $0x2d
  800a05:	8b 45 08             	mov    0x8(%ebp),%eax
  800a08:	ff d0                	call   *%eax
  800a0a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a10:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a13:	f7 d8                	neg    %eax
  800a15:	83 d2 00             	adc    $0x0,%edx
  800a18:	f7 da                	neg    %edx
  800a1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a1d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a20:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a27:	e9 bc 00 00 00       	jmp    800ae8 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a2c:	83 ec 08             	sub    $0x8,%esp
  800a2f:	ff 75 e8             	pushl  -0x18(%ebp)
  800a32:	8d 45 14             	lea    0x14(%ebp),%eax
  800a35:	50                   	push   %eax
  800a36:	e8 84 fc ff ff       	call   8006bf <getuint>
  800a3b:	83 c4 10             	add    $0x10,%esp
  800a3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a41:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a44:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a4b:	e9 98 00 00 00       	jmp    800ae8 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a50:	83 ec 08             	sub    $0x8,%esp
  800a53:	ff 75 0c             	pushl  0xc(%ebp)
  800a56:	6a 58                	push   $0x58
  800a58:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5b:	ff d0                	call   *%eax
  800a5d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a60:	83 ec 08             	sub    $0x8,%esp
  800a63:	ff 75 0c             	pushl  0xc(%ebp)
  800a66:	6a 58                	push   $0x58
  800a68:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6b:	ff d0                	call   *%eax
  800a6d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a70:	83 ec 08             	sub    $0x8,%esp
  800a73:	ff 75 0c             	pushl  0xc(%ebp)
  800a76:	6a 58                	push   $0x58
  800a78:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7b:	ff d0                	call   *%eax
  800a7d:	83 c4 10             	add    $0x10,%esp
			break;
  800a80:	e9 bc 00 00 00       	jmp    800b41 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a85:	83 ec 08             	sub    $0x8,%esp
  800a88:	ff 75 0c             	pushl  0xc(%ebp)
  800a8b:	6a 30                	push   $0x30
  800a8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a90:	ff d0                	call   *%eax
  800a92:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a95:	83 ec 08             	sub    $0x8,%esp
  800a98:	ff 75 0c             	pushl  0xc(%ebp)
  800a9b:	6a 78                	push   $0x78
  800a9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa0:	ff d0                	call   *%eax
  800aa2:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800aa5:	8b 45 14             	mov    0x14(%ebp),%eax
  800aa8:	83 c0 04             	add    $0x4,%eax
  800aab:	89 45 14             	mov    %eax,0x14(%ebp)
  800aae:	8b 45 14             	mov    0x14(%ebp),%eax
  800ab1:	83 e8 04             	sub    $0x4,%eax
  800ab4:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ab6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ab9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ac0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ac7:	eb 1f                	jmp    800ae8 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ac9:	83 ec 08             	sub    $0x8,%esp
  800acc:	ff 75 e8             	pushl  -0x18(%ebp)
  800acf:	8d 45 14             	lea    0x14(%ebp),%eax
  800ad2:	50                   	push   %eax
  800ad3:	e8 e7 fb ff ff       	call   8006bf <getuint>
  800ad8:	83 c4 10             	add    $0x10,%esp
  800adb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ade:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ae1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ae8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800aec:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800aef:	83 ec 04             	sub    $0x4,%esp
  800af2:	52                   	push   %edx
  800af3:	ff 75 e4             	pushl  -0x1c(%ebp)
  800af6:	50                   	push   %eax
  800af7:	ff 75 f4             	pushl  -0xc(%ebp)
  800afa:	ff 75 f0             	pushl  -0x10(%ebp)
  800afd:	ff 75 0c             	pushl  0xc(%ebp)
  800b00:	ff 75 08             	pushl  0x8(%ebp)
  800b03:	e8 00 fb ff ff       	call   800608 <printnum>
  800b08:	83 c4 20             	add    $0x20,%esp
			break;
  800b0b:	eb 34                	jmp    800b41 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b0d:	83 ec 08             	sub    $0x8,%esp
  800b10:	ff 75 0c             	pushl  0xc(%ebp)
  800b13:	53                   	push   %ebx
  800b14:	8b 45 08             	mov    0x8(%ebp),%eax
  800b17:	ff d0                	call   *%eax
  800b19:	83 c4 10             	add    $0x10,%esp
			break;
  800b1c:	eb 23                	jmp    800b41 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b1e:	83 ec 08             	sub    $0x8,%esp
  800b21:	ff 75 0c             	pushl  0xc(%ebp)
  800b24:	6a 25                	push   $0x25
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
  800b29:	ff d0                	call   *%eax
  800b2b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b2e:	ff 4d 10             	decl   0x10(%ebp)
  800b31:	eb 03                	jmp    800b36 <vprintfmt+0x3b1>
  800b33:	ff 4d 10             	decl   0x10(%ebp)
  800b36:	8b 45 10             	mov    0x10(%ebp),%eax
  800b39:	48                   	dec    %eax
  800b3a:	8a 00                	mov    (%eax),%al
  800b3c:	3c 25                	cmp    $0x25,%al
  800b3e:	75 f3                	jne    800b33 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b40:	90                   	nop
		}
	}
  800b41:	e9 47 fc ff ff       	jmp    80078d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b46:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b47:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b4a:	5b                   	pop    %ebx
  800b4b:	5e                   	pop    %esi
  800b4c:	5d                   	pop    %ebp
  800b4d:	c3                   	ret    

00800b4e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b4e:	55                   	push   %ebp
  800b4f:	89 e5                	mov    %esp,%ebp
  800b51:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b54:	8d 45 10             	lea    0x10(%ebp),%eax
  800b57:	83 c0 04             	add    $0x4,%eax
  800b5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b5d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b60:	ff 75 f4             	pushl  -0xc(%ebp)
  800b63:	50                   	push   %eax
  800b64:	ff 75 0c             	pushl  0xc(%ebp)
  800b67:	ff 75 08             	pushl  0x8(%ebp)
  800b6a:	e8 16 fc ff ff       	call   800785 <vprintfmt>
  800b6f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b72:	90                   	nop
  800b73:	c9                   	leave  
  800b74:	c3                   	ret    

00800b75 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b75:	55                   	push   %ebp
  800b76:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b7b:	8b 40 08             	mov    0x8(%eax),%eax
  800b7e:	8d 50 01             	lea    0x1(%eax),%edx
  800b81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b84:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8a:	8b 10                	mov    (%eax),%edx
  800b8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b8f:	8b 40 04             	mov    0x4(%eax),%eax
  800b92:	39 c2                	cmp    %eax,%edx
  800b94:	73 12                	jae    800ba8 <sprintputch+0x33>
		*b->buf++ = ch;
  800b96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b99:	8b 00                	mov    (%eax),%eax
  800b9b:	8d 48 01             	lea    0x1(%eax),%ecx
  800b9e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ba1:	89 0a                	mov    %ecx,(%edx)
  800ba3:	8b 55 08             	mov    0x8(%ebp),%edx
  800ba6:	88 10                	mov    %dl,(%eax)
}
  800ba8:	90                   	nop
  800ba9:	5d                   	pop    %ebp
  800baa:	c3                   	ret    

00800bab <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800bab:	55                   	push   %ebp
  800bac:	89 e5                	mov    %esp,%ebp
  800bae:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800bb7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bba:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc0:	01 d0                	add    %edx,%eax
  800bc2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bc5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800bcc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bd0:	74 06                	je     800bd8 <vsnprintf+0x2d>
  800bd2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bd6:	7f 07                	jg     800bdf <vsnprintf+0x34>
		return -E_INVAL;
  800bd8:	b8 03 00 00 00       	mov    $0x3,%eax
  800bdd:	eb 20                	jmp    800bff <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800bdf:	ff 75 14             	pushl  0x14(%ebp)
  800be2:	ff 75 10             	pushl  0x10(%ebp)
  800be5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800be8:	50                   	push   %eax
  800be9:	68 75 0b 80 00       	push   $0x800b75
  800bee:	e8 92 fb ff ff       	call   800785 <vprintfmt>
  800bf3:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800bf6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bf9:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800bfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800bff:	c9                   	leave  
  800c00:	c3                   	ret    

00800c01 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c01:	55                   	push   %ebp
  800c02:	89 e5                	mov    %esp,%ebp
  800c04:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c07:	8d 45 10             	lea    0x10(%ebp),%eax
  800c0a:	83 c0 04             	add    $0x4,%eax
  800c0d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c10:	8b 45 10             	mov    0x10(%ebp),%eax
  800c13:	ff 75 f4             	pushl  -0xc(%ebp)
  800c16:	50                   	push   %eax
  800c17:	ff 75 0c             	pushl  0xc(%ebp)
  800c1a:	ff 75 08             	pushl  0x8(%ebp)
  800c1d:	e8 89 ff ff ff       	call   800bab <vsnprintf>
  800c22:	83 c4 10             	add    $0x10,%esp
  800c25:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c28:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c2b:	c9                   	leave  
  800c2c:	c3                   	ret    

00800c2d <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800c2d:	55                   	push   %ebp
  800c2e:	89 e5                	mov    %esp,%ebp
  800c30:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  800c33:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c37:	74 13                	je     800c4c <readline+0x1f>
		cprintf("%s", prompt);
  800c39:	83 ec 08             	sub    $0x8,%esp
  800c3c:	ff 75 08             	pushl  0x8(%ebp)
  800c3f:	68 70 25 80 00       	push   $0x802570
  800c44:	e8 62 f9 ff ff       	call   8005ab <cprintf>
  800c49:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800c4c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800c53:	83 ec 0c             	sub    $0xc,%esp
  800c56:	6a 00                	push   $0x0
  800c58:	e8 d1 0f 00 00       	call   801c2e <iscons>
  800c5d:	83 c4 10             	add    $0x10,%esp
  800c60:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800c63:	e8 78 0f 00 00       	call   801be0 <getchar>
  800c68:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800c6b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800c6f:	79 22                	jns    800c93 <readline+0x66>
			if (c != -E_EOF)
  800c71:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800c75:	0f 84 ad 00 00 00    	je     800d28 <readline+0xfb>
				cprintf("read error: %e\n", c);
  800c7b:	83 ec 08             	sub    $0x8,%esp
  800c7e:	ff 75 ec             	pushl  -0x14(%ebp)
  800c81:	68 73 25 80 00       	push   $0x802573
  800c86:	e8 20 f9 ff ff       	call   8005ab <cprintf>
  800c8b:	83 c4 10             	add    $0x10,%esp
			return;
  800c8e:	e9 95 00 00 00       	jmp    800d28 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800c93:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800c97:	7e 34                	jle    800ccd <readline+0xa0>
  800c99:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800ca0:	7f 2b                	jg     800ccd <readline+0xa0>
			if (echoing)
  800ca2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800ca6:	74 0e                	je     800cb6 <readline+0x89>
				cputchar(c);
  800ca8:	83 ec 0c             	sub    $0xc,%esp
  800cab:	ff 75 ec             	pushl  -0x14(%ebp)
  800cae:	e8 e5 0e 00 00       	call   801b98 <cputchar>
  800cb3:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800cb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800cb9:	8d 50 01             	lea    0x1(%eax),%edx
  800cbc:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800cbf:	89 c2                	mov    %eax,%edx
  800cc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc4:	01 d0                	add    %edx,%eax
  800cc6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800cc9:	88 10                	mov    %dl,(%eax)
  800ccb:	eb 56                	jmp    800d23 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  800ccd:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800cd1:	75 1f                	jne    800cf2 <readline+0xc5>
  800cd3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800cd7:	7e 19                	jle    800cf2 <readline+0xc5>
			if (echoing)
  800cd9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800cdd:	74 0e                	je     800ced <readline+0xc0>
				cputchar(c);
  800cdf:	83 ec 0c             	sub    $0xc,%esp
  800ce2:	ff 75 ec             	pushl  -0x14(%ebp)
  800ce5:	e8 ae 0e 00 00       	call   801b98 <cputchar>
  800cea:	83 c4 10             	add    $0x10,%esp

			i--;
  800ced:	ff 4d f4             	decl   -0xc(%ebp)
  800cf0:	eb 31                	jmp    800d23 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800cf2:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800cf6:	74 0a                	je     800d02 <readline+0xd5>
  800cf8:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800cfc:	0f 85 61 ff ff ff    	jne    800c63 <readline+0x36>
			if (echoing)
  800d02:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800d06:	74 0e                	je     800d16 <readline+0xe9>
				cputchar(c);
  800d08:	83 ec 0c             	sub    $0xc,%esp
  800d0b:	ff 75 ec             	pushl  -0x14(%ebp)
  800d0e:	e8 85 0e 00 00       	call   801b98 <cputchar>
  800d13:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800d16:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1c:	01 d0                	add    %edx,%eax
  800d1e:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800d21:	eb 06                	jmp    800d29 <readline+0xfc>
		}
	}
  800d23:	e9 3b ff ff ff       	jmp    800c63 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800d28:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800d29:	c9                   	leave  
  800d2a:	c3                   	ret    

00800d2b <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800d2b:	55                   	push   %ebp
  800d2c:	89 e5                	mov    %esp,%ebp
  800d2e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800d31:	e8 41 0a 00 00       	call   801777 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800d36:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d3a:	74 13                	je     800d4f <atomic_readline+0x24>
		cprintf("%s", prompt);
  800d3c:	83 ec 08             	sub    $0x8,%esp
  800d3f:	ff 75 08             	pushl  0x8(%ebp)
  800d42:	68 70 25 80 00       	push   $0x802570
  800d47:	e8 5f f8 ff ff       	call   8005ab <cprintf>
  800d4c:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800d4f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800d56:	83 ec 0c             	sub    $0xc,%esp
  800d59:	6a 00                	push   $0x0
  800d5b:	e8 ce 0e 00 00       	call   801c2e <iscons>
  800d60:	83 c4 10             	add    $0x10,%esp
  800d63:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800d66:	e8 75 0e 00 00       	call   801be0 <getchar>
  800d6b:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800d6e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800d72:	79 23                	jns    800d97 <atomic_readline+0x6c>
			if (c != -E_EOF)
  800d74:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800d78:	74 13                	je     800d8d <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800d7a:	83 ec 08             	sub    $0x8,%esp
  800d7d:	ff 75 ec             	pushl  -0x14(%ebp)
  800d80:	68 73 25 80 00       	push   $0x802573
  800d85:	e8 21 f8 ff ff       	call   8005ab <cprintf>
  800d8a:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800d8d:	e8 ff 09 00 00       	call   801791 <sys_enable_interrupt>
			return;
  800d92:	e9 9a 00 00 00       	jmp    800e31 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800d97:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800d9b:	7e 34                	jle    800dd1 <atomic_readline+0xa6>
  800d9d:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800da4:	7f 2b                	jg     800dd1 <atomic_readline+0xa6>
			if (echoing)
  800da6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800daa:	74 0e                	je     800dba <atomic_readline+0x8f>
				cputchar(c);
  800dac:	83 ec 0c             	sub    $0xc,%esp
  800daf:	ff 75 ec             	pushl  -0x14(%ebp)
  800db2:	e8 e1 0d 00 00       	call   801b98 <cputchar>
  800db7:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800dba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dbd:	8d 50 01             	lea    0x1(%eax),%edx
  800dc0:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800dc3:	89 c2                	mov    %eax,%edx
  800dc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc8:	01 d0                	add    %edx,%eax
  800dca:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dcd:	88 10                	mov    %dl,(%eax)
  800dcf:	eb 5b                	jmp    800e2c <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800dd1:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800dd5:	75 1f                	jne    800df6 <atomic_readline+0xcb>
  800dd7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800ddb:	7e 19                	jle    800df6 <atomic_readline+0xcb>
			if (echoing)
  800ddd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800de1:	74 0e                	je     800df1 <atomic_readline+0xc6>
				cputchar(c);
  800de3:	83 ec 0c             	sub    $0xc,%esp
  800de6:	ff 75 ec             	pushl  -0x14(%ebp)
  800de9:	e8 aa 0d 00 00       	call   801b98 <cputchar>
  800dee:	83 c4 10             	add    $0x10,%esp
			i--;
  800df1:	ff 4d f4             	decl   -0xc(%ebp)
  800df4:	eb 36                	jmp    800e2c <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800df6:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800dfa:	74 0a                	je     800e06 <atomic_readline+0xdb>
  800dfc:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800e00:	0f 85 60 ff ff ff    	jne    800d66 <atomic_readline+0x3b>
			if (echoing)
  800e06:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800e0a:	74 0e                	je     800e1a <atomic_readline+0xef>
				cputchar(c);
  800e0c:	83 ec 0c             	sub    $0xc,%esp
  800e0f:	ff 75 ec             	pushl  -0x14(%ebp)
  800e12:	e8 81 0d 00 00       	call   801b98 <cputchar>
  800e17:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800e1a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e20:	01 d0                	add    %edx,%eax
  800e22:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800e25:	e8 67 09 00 00       	call   801791 <sys_enable_interrupt>
			return;
  800e2a:	eb 05                	jmp    800e31 <atomic_readline+0x106>
		}
	}
  800e2c:	e9 35 ff ff ff       	jmp    800d66 <atomic_readline+0x3b>
}
  800e31:	c9                   	leave  
  800e32:	c3                   	ret    

00800e33 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800e33:	55                   	push   %ebp
  800e34:	89 e5                	mov    %esp,%ebp
  800e36:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800e39:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e40:	eb 06                	jmp    800e48 <strlen+0x15>
		n++;
  800e42:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800e45:	ff 45 08             	incl   0x8(%ebp)
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	8a 00                	mov    (%eax),%al
  800e4d:	84 c0                	test   %al,%al
  800e4f:	75 f1                	jne    800e42 <strlen+0xf>
		n++;
	return n;
  800e51:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e54:	c9                   	leave  
  800e55:	c3                   	ret    

00800e56 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e56:	55                   	push   %ebp
  800e57:	89 e5                	mov    %esp,%ebp
  800e59:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e5c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e63:	eb 09                	jmp    800e6e <strnlen+0x18>
		n++;
  800e65:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e68:	ff 45 08             	incl   0x8(%ebp)
  800e6b:	ff 4d 0c             	decl   0xc(%ebp)
  800e6e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e72:	74 09                	je     800e7d <strnlen+0x27>
  800e74:	8b 45 08             	mov    0x8(%ebp),%eax
  800e77:	8a 00                	mov    (%eax),%al
  800e79:	84 c0                	test   %al,%al
  800e7b:	75 e8                	jne    800e65 <strnlen+0xf>
		n++;
	return n;
  800e7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e80:	c9                   	leave  
  800e81:	c3                   	ret    

00800e82 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e82:	55                   	push   %ebp
  800e83:	89 e5                	mov    %esp,%ebp
  800e85:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e88:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e8e:	90                   	nop
  800e8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e92:	8d 50 01             	lea    0x1(%eax),%edx
  800e95:	89 55 08             	mov    %edx,0x8(%ebp)
  800e98:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e9b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e9e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ea1:	8a 12                	mov    (%edx),%dl
  800ea3:	88 10                	mov    %dl,(%eax)
  800ea5:	8a 00                	mov    (%eax),%al
  800ea7:	84 c0                	test   %al,%al
  800ea9:	75 e4                	jne    800e8f <strcpy+0xd>
		/* do nothing */;
	return ret;
  800eab:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800eae:	c9                   	leave  
  800eaf:	c3                   	ret    

00800eb0 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800eb0:	55                   	push   %ebp
  800eb1:	89 e5                	mov    %esp,%ebp
  800eb3:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800eb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800ebc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ec3:	eb 1f                	jmp    800ee4 <strncpy+0x34>
		*dst++ = *src;
  800ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec8:	8d 50 01             	lea    0x1(%eax),%edx
  800ecb:	89 55 08             	mov    %edx,0x8(%ebp)
  800ece:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ed1:	8a 12                	mov    (%edx),%dl
  800ed3:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800ed5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed8:	8a 00                	mov    (%eax),%al
  800eda:	84 c0                	test   %al,%al
  800edc:	74 03                	je     800ee1 <strncpy+0x31>
			src++;
  800ede:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800ee1:	ff 45 fc             	incl   -0x4(%ebp)
  800ee4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ee7:	3b 45 10             	cmp    0x10(%ebp),%eax
  800eea:	72 d9                	jb     800ec5 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800eec:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800eef:	c9                   	leave  
  800ef0:	c3                   	ret    

00800ef1 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ef1:	55                   	push   %ebp
  800ef2:	89 e5                	mov    %esp,%ebp
  800ef4:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ef7:	8b 45 08             	mov    0x8(%ebp),%eax
  800efa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800efd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f01:	74 30                	je     800f33 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f03:	eb 16                	jmp    800f1b <strlcpy+0x2a>
			*dst++ = *src++;
  800f05:	8b 45 08             	mov    0x8(%ebp),%eax
  800f08:	8d 50 01             	lea    0x1(%eax),%edx
  800f0b:	89 55 08             	mov    %edx,0x8(%ebp)
  800f0e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f11:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f14:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f17:	8a 12                	mov    (%edx),%dl
  800f19:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800f1b:	ff 4d 10             	decl   0x10(%ebp)
  800f1e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f22:	74 09                	je     800f2d <strlcpy+0x3c>
  800f24:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f27:	8a 00                	mov    (%eax),%al
  800f29:	84 c0                	test   %al,%al
  800f2b:	75 d8                	jne    800f05 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800f2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f30:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800f33:	8b 55 08             	mov    0x8(%ebp),%edx
  800f36:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f39:	29 c2                	sub    %eax,%edx
  800f3b:	89 d0                	mov    %edx,%eax
}
  800f3d:	c9                   	leave  
  800f3e:	c3                   	ret    

00800f3f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800f3f:	55                   	push   %ebp
  800f40:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800f42:	eb 06                	jmp    800f4a <strcmp+0xb>
		p++, q++;
  800f44:	ff 45 08             	incl   0x8(%ebp)
  800f47:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4d:	8a 00                	mov    (%eax),%al
  800f4f:	84 c0                	test   %al,%al
  800f51:	74 0e                	je     800f61 <strcmp+0x22>
  800f53:	8b 45 08             	mov    0x8(%ebp),%eax
  800f56:	8a 10                	mov    (%eax),%dl
  800f58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5b:	8a 00                	mov    (%eax),%al
  800f5d:	38 c2                	cmp    %al,%dl
  800f5f:	74 e3                	je     800f44 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f61:	8b 45 08             	mov    0x8(%ebp),%eax
  800f64:	8a 00                	mov    (%eax),%al
  800f66:	0f b6 d0             	movzbl %al,%edx
  800f69:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6c:	8a 00                	mov    (%eax),%al
  800f6e:	0f b6 c0             	movzbl %al,%eax
  800f71:	29 c2                	sub    %eax,%edx
  800f73:	89 d0                	mov    %edx,%eax
}
  800f75:	5d                   	pop    %ebp
  800f76:	c3                   	ret    

00800f77 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f77:	55                   	push   %ebp
  800f78:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f7a:	eb 09                	jmp    800f85 <strncmp+0xe>
		n--, p++, q++;
  800f7c:	ff 4d 10             	decl   0x10(%ebp)
  800f7f:	ff 45 08             	incl   0x8(%ebp)
  800f82:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f85:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f89:	74 17                	je     800fa2 <strncmp+0x2b>
  800f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8e:	8a 00                	mov    (%eax),%al
  800f90:	84 c0                	test   %al,%al
  800f92:	74 0e                	je     800fa2 <strncmp+0x2b>
  800f94:	8b 45 08             	mov    0x8(%ebp),%eax
  800f97:	8a 10                	mov    (%eax),%dl
  800f99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9c:	8a 00                	mov    (%eax),%al
  800f9e:	38 c2                	cmp    %al,%dl
  800fa0:	74 da                	je     800f7c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800fa2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa6:	75 07                	jne    800faf <strncmp+0x38>
		return 0;
  800fa8:	b8 00 00 00 00       	mov    $0x0,%eax
  800fad:	eb 14                	jmp    800fc3 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800faf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb2:	8a 00                	mov    (%eax),%al
  800fb4:	0f b6 d0             	movzbl %al,%edx
  800fb7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fba:	8a 00                	mov    (%eax),%al
  800fbc:	0f b6 c0             	movzbl %al,%eax
  800fbf:	29 c2                	sub    %eax,%edx
  800fc1:	89 d0                	mov    %edx,%eax
}
  800fc3:	5d                   	pop    %ebp
  800fc4:	c3                   	ret    

00800fc5 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800fc5:	55                   	push   %ebp
  800fc6:	89 e5                	mov    %esp,%ebp
  800fc8:	83 ec 04             	sub    $0x4,%esp
  800fcb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fce:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fd1:	eb 12                	jmp    800fe5 <strchr+0x20>
		if (*s == c)
  800fd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd6:	8a 00                	mov    (%eax),%al
  800fd8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fdb:	75 05                	jne    800fe2 <strchr+0x1d>
			return (char *) s;
  800fdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe0:	eb 11                	jmp    800ff3 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800fe2:	ff 45 08             	incl   0x8(%ebp)
  800fe5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe8:	8a 00                	mov    (%eax),%al
  800fea:	84 c0                	test   %al,%al
  800fec:	75 e5                	jne    800fd3 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800fee:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ff3:	c9                   	leave  
  800ff4:	c3                   	ret    

00800ff5 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ff5:	55                   	push   %ebp
  800ff6:	89 e5                	mov    %esp,%ebp
  800ff8:	83 ec 04             	sub    $0x4,%esp
  800ffb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffe:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801001:	eb 0d                	jmp    801010 <strfind+0x1b>
		if (*s == c)
  801003:	8b 45 08             	mov    0x8(%ebp),%eax
  801006:	8a 00                	mov    (%eax),%al
  801008:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80100b:	74 0e                	je     80101b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80100d:	ff 45 08             	incl   0x8(%ebp)
  801010:	8b 45 08             	mov    0x8(%ebp),%eax
  801013:	8a 00                	mov    (%eax),%al
  801015:	84 c0                	test   %al,%al
  801017:	75 ea                	jne    801003 <strfind+0xe>
  801019:	eb 01                	jmp    80101c <strfind+0x27>
		if (*s == c)
			break;
  80101b:	90                   	nop
	return (char *) s;
  80101c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80101f:	c9                   	leave  
  801020:	c3                   	ret    

00801021 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801021:	55                   	push   %ebp
  801022:	89 e5                	mov    %esp,%ebp
  801024:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801027:	8b 45 08             	mov    0x8(%ebp),%eax
  80102a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80102d:	8b 45 10             	mov    0x10(%ebp),%eax
  801030:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801033:	eb 0e                	jmp    801043 <memset+0x22>
		*p++ = c;
  801035:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801038:	8d 50 01             	lea    0x1(%eax),%edx
  80103b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80103e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801041:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801043:	ff 4d f8             	decl   -0x8(%ebp)
  801046:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80104a:	79 e9                	jns    801035 <memset+0x14>
		*p++ = c;

	return v;
  80104c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80104f:	c9                   	leave  
  801050:	c3                   	ret    

00801051 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801051:	55                   	push   %ebp
  801052:	89 e5                	mov    %esp,%ebp
  801054:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801057:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80105d:	8b 45 08             	mov    0x8(%ebp),%eax
  801060:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801063:	eb 16                	jmp    80107b <memcpy+0x2a>
		*d++ = *s++;
  801065:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801068:	8d 50 01             	lea    0x1(%eax),%edx
  80106b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80106e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801071:	8d 4a 01             	lea    0x1(%edx),%ecx
  801074:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801077:	8a 12                	mov    (%edx),%dl
  801079:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80107b:	8b 45 10             	mov    0x10(%ebp),%eax
  80107e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801081:	89 55 10             	mov    %edx,0x10(%ebp)
  801084:	85 c0                	test   %eax,%eax
  801086:	75 dd                	jne    801065 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801088:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80108b:	c9                   	leave  
  80108c:	c3                   	ret    

0080108d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80108d:	55                   	push   %ebp
  80108e:	89 e5                	mov    %esp,%ebp
  801090:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801093:	8b 45 0c             	mov    0xc(%ebp),%eax
  801096:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801099:	8b 45 08             	mov    0x8(%ebp),%eax
  80109c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80109f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010a2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010a5:	73 50                	jae    8010f7 <memmove+0x6a>
  8010a7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ad:	01 d0                	add    %edx,%eax
  8010af:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010b2:	76 43                	jbe    8010f7 <memmove+0x6a>
		s += n;
  8010b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b7:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8010ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8010bd:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8010c0:	eb 10                	jmp    8010d2 <memmove+0x45>
			*--d = *--s;
  8010c2:	ff 4d f8             	decl   -0x8(%ebp)
  8010c5:	ff 4d fc             	decl   -0x4(%ebp)
  8010c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010cb:	8a 10                	mov    (%eax),%dl
  8010cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010d0:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8010d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010d8:	89 55 10             	mov    %edx,0x10(%ebp)
  8010db:	85 c0                	test   %eax,%eax
  8010dd:	75 e3                	jne    8010c2 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8010df:	eb 23                	jmp    801104 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8010e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010e4:	8d 50 01             	lea    0x1(%eax),%edx
  8010e7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010ea:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010ed:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010f0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010f3:	8a 12                	mov    (%edx),%dl
  8010f5:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8010f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8010fa:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010fd:	89 55 10             	mov    %edx,0x10(%ebp)
  801100:	85 c0                	test   %eax,%eax
  801102:	75 dd                	jne    8010e1 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801104:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801107:	c9                   	leave  
  801108:	c3                   	ret    

00801109 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801109:	55                   	push   %ebp
  80110a:	89 e5                	mov    %esp,%ebp
  80110c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80110f:	8b 45 08             	mov    0x8(%ebp),%eax
  801112:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801115:	8b 45 0c             	mov    0xc(%ebp),%eax
  801118:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80111b:	eb 2a                	jmp    801147 <memcmp+0x3e>
		if (*s1 != *s2)
  80111d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801120:	8a 10                	mov    (%eax),%dl
  801122:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801125:	8a 00                	mov    (%eax),%al
  801127:	38 c2                	cmp    %al,%dl
  801129:	74 16                	je     801141 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80112b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80112e:	8a 00                	mov    (%eax),%al
  801130:	0f b6 d0             	movzbl %al,%edx
  801133:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801136:	8a 00                	mov    (%eax),%al
  801138:	0f b6 c0             	movzbl %al,%eax
  80113b:	29 c2                	sub    %eax,%edx
  80113d:	89 d0                	mov    %edx,%eax
  80113f:	eb 18                	jmp    801159 <memcmp+0x50>
		s1++, s2++;
  801141:	ff 45 fc             	incl   -0x4(%ebp)
  801144:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801147:	8b 45 10             	mov    0x10(%ebp),%eax
  80114a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80114d:	89 55 10             	mov    %edx,0x10(%ebp)
  801150:	85 c0                	test   %eax,%eax
  801152:	75 c9                	jne    80111d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801154:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801159:	c9                   	leave  
  80115a:	c3                   	ret    

0080115b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80115b:	55                   	push   %ebp
  80115c:	89 e5                	mov    %esp,%ebp
  80115e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801161:	8b 55 08             	mov    0x8(%ebp),%edx
  801164:	8b 45 10             	mov    0x10(%ebp),%eax
  801167:	01 d0                	add    %edx,%eax
  801169:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80116c:	eb 15                	jmp    801183 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80116e:	8b 45 08             	mov    0x8(%ebp),%eax
  801171:	8a 00                	mov    (%eax),%al
  801173:	0f b6 d0             	movzbl %al,%edx
  801176:	8b 45 0c             	mov    0xc(%ebp),%eax
  801179:	0f b6 c0             	movzbl %al,%eax
  80117c:	39 c2                	cmp    %eax,%edx
  80117e:	74 0d                	je     80118d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801180:	ff 45 08             	incl   0x8(%ebp)
  801183:	8b 45 08             	mov    0x8(%ebp),%eax
  801186:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801189:	72 e3                	jb     80116e <memfind+0x13>
  80118b:	eb 01                	jmp    80118e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80118d:	90                   	nop
	return (void *) s;
  80118e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801191:	c9                   	leave  
  801192:	c3                   	ret    

00801193 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801193:	55                   	push   %ebp
  801194:	89 e5                	mov    %esp,%ebp
  801196:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801199:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8011a0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011a7:	eb 03                	jmp    8011ac <strtol+0x19>
		s++;
  8011a9:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8011af:	8a 00                	mov    (%eax),%al
  8011b1:	3c 20                	cmp    $0x20,%al
  8011b3:	74 f4                	je     8011a9 <strtol+0x16>
  8011b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b8:	8a 00                	mov    (%eax),%al
  8011ba:	3c 09                	cmp    $0x9,%al
  8011bc:	74 eb                	je     8011a9 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8011be:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c1:	8a 00                	mov    (%eax),%al
  8011c3:	3c 2b                	cmp    $0x2b,%al
  8011c5:	75 05                	jne    8011cc <strtol+0x39>
		s++;
  8011c7:	ff 45 08             	incl   0x8(%ebp)
  8011ca:	eb 13                	jmp    8011df <strtol+0x4c>
	else if (*s == '-')
  8011cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cf:	8a 00                	mov    (%eax),%al
  8011d1:	3c 2d                	cmp    $0x2d,%al
  8011d3:	75 0a                	jne    8011df <strtol+0x4c>
		s++, neg = 1;
  8011d5:	ff 45 08             	incl   0x8(%ebp)
  8011d8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8011df:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011e3:	74 06                	je     8011eb <strtol+0x58>
  8011e5:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8011e9:	75 20                	jne    80120b <strtol+0x78>
  8011eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ee:	8a 00                	mov    (%eax),%al
  8011f0:	3c 30                	cmp    $0x30,%al
  8011f2:	75 17                	jne    80120b <strtol+0x78>
  8011f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f7:	40                   	inc    %eax
  8011f8:	8a 00                	mov    (%eax),%al
  8011fa:	3c 78                	cmp    $0x78,%al
  8011fc:	75 0d                	jne    80120b <strtol+0x78>
		s += 2, base = 16;
  8011fe:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801202:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801209:	eb 28                	jmp    801233 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80120b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80120f:	75 15                	jne    801226 <strtol+0x93>
  801211:	8b 45 08             	mov    0x8(%ebp),%eax
  801214:	8a 00                	mov    (%eax),%al
  801216:	3c 30                	cmp    $0x30,%al
  801218:	75 0c                	jne    801226 <strtol+0x93>
		s++, base = 8;
  80121a:	ff 45 08             	incl   0x8(%ebp)
  80121d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801224:	eb 0d                	jmp    801233 <strtol+0xa0>
	else if (base == 0)
  801226:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80122a:	75 07                	jne    801233 <strtol+0xa0>
		base = 10;
  80122c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801233:	8b 45 08             	mov    0x8(%ebp),%eax
  801236:	8a 00                	mov    (%eax),%al
  801238:	3c 2f                	cmp    $0x2f,%al
  80123a:	7e 19                	jle    801255 <strtol+0xc2>
  80123c:	8b 45 08             	mov    0x8(%ebp),%eax
  80123f:	8a 00                	mov    (%eax),%al
  801241:	3c 39                	cmp    $0x39,%al
  801243:	7f 10                	jg     801255 <strtol+0xc2>
			dig = *s - '0';
  801245:	8b 45 08             	mov    0x8(%ebp),%eax
  801248:	8a 00                	mov    (%eax),%al
  80124a:	0f be c0             	movsbl %al,%eax
  80124d:	83 e8 30             	sub    $0x30,%eax
  801250:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801253:	eb 42                	jmp    801297 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801255:	8b 45 08             	mov    0x8(%ebp),%eax
  801258:	8a 00                	mov    (%eax),%al
  80125a:	3c 60                	cmp    $0x60,%al
  80125c:	7e 19                	jle    801277 <strtol+0xe4>
  80125e:	8b 45 08             	mov    0x8(%ebp),%eax
  801261:	8a 00                	mov    (%eax),%al
  801263:	3c 7a                	cmp    $0x7a,%al
  801265:	7f 10                	jg     801277 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801267:	8b 45 08             	mov    0x8(%ebp),%eax
  80126a:	8a 00                	mov    (%eax),%al
  80126c:	0f be c0             	movsbl %al,%eax
  80126f:	83 e8 57             	sub    $0x57,%eax
  801272:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801275:	eb 20                	jmp    801297 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801277:	8b 45 08             	mov    0x8(%ebp),%eax
  80127a:	8a 00                	mov    (%eax),%al
  80127c:	3c 40                	cmp    $0x40,%al
  80127e:	7e 39                	jle    8012b9 <strtol+0x126>
  801280:	8b 45 08             	mov    0x8(%ebp),%eax
  801283:	8a 00                	mov    (%eax),%al
  801285:	3c 5a                	cmp    $0x5a,%al
  801287:	7f 30                	jg     8012b9 <strtol+0x126>
			dig = *s - 'A' + 10;
  801289:	8b 45 08             	mov    0x8(%ebp),%eax
  80128c:	8a 00                	mov    (%eax),%al
  80128e:	0f be c0             	movsbl %al,%eax
  801291:	83 e8 37             	sub    $0x37,%eax
  801294:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801297:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80129a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80129d:	7d 19                	jge    8012b8 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80129f:	ff 45 08             	incl   0x8(%ebp)
  8012a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012a5:	0f af 45 10          	imul   0x10(%ebp),%eax
  8012a9:	89 c2                	mov    %eax,%edx
  8012ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012ae:	01 d0                	add    %edx,%eax
  8012b0:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8012b3:	e9 7b ff ff ff       	jmp    801233 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8012b8:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8012b9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012bd:	74 08                	je     8012c7 <strtol+0x134>
		*endptr = (char *) s;
  8012bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c2:	8b 55 08             	mov    0x8(%ebp),%edx
  8012c5:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8012c7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012cb:	74 07                	je     8012d4 <strtol+0x141>
  8012cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012d0:	f7 d8                	neg    %eax
  8012d2:	eb 03                	jmp    8012d7 <strtol+0x144>
  8012d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012d7:	c9                   	leave  
  8012d8:	c3                   	ret    

008012d9 <ltostr>:

void
ltostr(long value, char *str)
{
  8012d9:	55                   	push   %ebp
  8012da:	89 e5                	mov    %esp,%ebp
  8012dc:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8012df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8012e6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8012ed:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012f1:	79 13                	jns    801306 <ltostr+0x2d>
	{
		neg = 1;
  8012f3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8012fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012fd:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801300:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801303:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801306:	8b 45 08             	mov    0x8(%ebp),%eax
  801309:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80130e:	99                   	cltd   
  80130f:	f7 f9                	idiv   %ecx
  801311:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801314:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801317:	8d 50 01             	lea    0x1(%eax),%edx
  80131a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80131d:	89 c2                	mov    %eax,%edx
  80131f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801322:	01 d0                	add    %edx,%eax
  801324:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801327:	83 c2 30             	add    $0x30,%edx
  80132a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80132c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80132f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801334:	f7 e9                	imul   %ecx
  801336:	c1 fa 02             	sar    $0x2,%edx
  801339:	89 c8                	mov    %ecx,%eax
  80133b:	c1 f8 1f             	sar    $0x1f,%eax
  80133e:	29 c2                	sub    %eax,%edx
  801340:	89 d0                	mov    %edx,%eax
  801342:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801345:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801348:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80134d:	f7 e9                	imul   %ecx
  80134f:	c1 fa 02             	sar    $0x2,%edx
  801352:	89 c8                	mov    %ecx,%eax
  801354:	c1 f8 1f             	sar    $0x1f,%eax
  801357:	29 c2                	sub    %eax,%edx
  801359:	89 d0                	mov    %edx,%eax
  80135b:	c1 e0 02             	shl    $0x2,%eax
  80135e:	01 d0                	add    %edx,%eax
  801360:	01 c0                	add    %eax,%eax
  801362:	29 c1                	sub    %eax,%ecx
  801364:	89 ca                	mov    %ecx,%edx
  801366:	85 d2                	test   %edx,%edx
  801368:	75 9c                	jne    801306 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80136a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801371:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801374:	48                   	dec    %eax
  801375:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801378:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80137c:	74 3d                	je     8013bb <ltostr+0xe2>
		start = 1 ;
  80137e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801385:	eb 34                	jmp    8013bb <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801387:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80138a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138d:	01 d0                	add    %edx,%eax
  80138f:	8a 00                	mov    (%eax),%al
  801391:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801394:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801397:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139a:	01 c2                	add    %eax,%edx
  80139c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80139f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a2:	01 c8                	add    %ecx,%eax
  8013a4:	8a 00                	mov    (%eax),%al
  8013a6:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8013a8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8013ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ae:	01 c2                	add    %eax,%edx
  8013b0:	8a 45 eb             	mov    -0x15(%ebp),%al
  8013b3:	88 02                	mov    %al,(%edx)
		start++ ;
  8013b5:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8013b8:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8013bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013be:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013c1:	7c c4                	jl     801387 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8013c3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8013c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c9:	01 d0                	add    %edx,%eax
  8013cb:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8013ce:	90                   	nop
  8013cf:	c9                   	leave  
  8013d0:	c3                   	ret    

008013d1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8013d1:	55                   	push   %ebp
  8013d2:	89 e5                	mov    %esp,%ebp
  8013d4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8013d7:	ff 75 08             	pushl  0x8(%ebp)
  8013da:	e8 54 fa ff ff       	call   800e33 <strlen>
  8013df:	83 c4 04             	add    $0x4,%esp
  8013e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8013e5:	ff 75 0c             	pushl  0xc(%ebp)
  8013e8:	e8 46 fa ff ff       	call   800e33 <strlen>
  8013ed:	83 c4 04             	add    $0x4,%esp
  8013f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8013f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8013fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801401:	eb 17                	jmp    80141a <strcconcat+0x49>
		final[s] = str1[s] ;
  801403:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801406:	8b 45 10             	mov    0x10(%ebp),%eax
  801409:	01 c2                	add    %eax,%edx
  80140b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80140e:	8b 45 08             	mov    0x8(%ebp),%eax
  801411:	01 c8                	add    %ecx,%eax
  801413:	8a 00                	mov    (%eax),%al
  801415:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801417:	ff 45 fc             	incl   -0x4(%ebp)
  80141a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80141d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801420:	7c e1                	jl     801403 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801422:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801429:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801430:	eb 1f                	jmp    801451 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801432:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801435:	8d 50 01             	lea    0x1(%eax),%edx
  801438:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80143b:	89 c2                	mov    %eax,%edx
  80143d:	8b 45 10             	mov    0x10(%ebp),%eax
  801440:	01 c2                	add    %eax,%edx
  801442:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801445:	8b 45 0c             	mov    0xc(%ebp),%eax
  801448:	01 c8                	add    %ecx,%eax
  80144a:	8a 00                	mov    (%eax),%al
  80144c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80144e:	ff 45 f8             	incl   -0x8(%ebp)
  801451:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801454:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801457:	7c d9                	jl     801432 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801459:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80145c:	8b 45 10             	mov    0x10(%ebp),%eax
  80145f:	01 d0                	add    %edx,%eax
  801461:	c6 00 00             	movb   $0x0,(%eax)
}
  801464:	90                   	nop
  801465:	c9                   	leave  
  801466:	c3                   	ret    

00801467 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801467:	55                   	push   %ebp
  801468:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80146a:	8b 45 14             	mov    0x14(%ebp),%eax
  80146d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801473:	8b 45 14             	mov    0x14(%ebp),%eax
  801476:	8b 00                	mov    (%eax),%eax
  801478:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80147f:	8b 45 10             	mov    0x10(%ebp),%eax
  801482:	01 d0                	add    %edx,%eax
  801484:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80148a:	eb 0c                	jmp    801498 <strsplit+0x31>
			*string++ = 0;
  80148c:	8b 45 08             	mov    0x8(%ebp),%eax
  80148f:	8d 50 01             	lea    0x1(%eax),%edx
  801492:	89 55 08             	mov    %edx,0x8(%ebp)
  801495:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801498:	8b 45 08             	mov    0x8(%ebp),%eax
  80149b:	8a 00                	mov    (%eax),%al
  80149d:	84 c0                	test   %al,%al
  80149f:	74 18                	je     8014b9 <strsplit+0x52>
  8014a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a4:	8a 00                	mov    (%eax),%al
  8014a6:	0f be c0             	movsbl %al,%eax
  8014a9:	50                   	push   %eax
  8014aa:	ff 75 0c             	pushl  0xc(%ebp)
  8014ad:	e8 13 fb ff ff       	call   800fc5 <strchr>
  8014b2:	83 c4 08             	add    $0x8,%esp
  8014b5:	85 c0                	test   %eax,%eax
  8014b7:	75 d3                	jne    80148c <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8014b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bc:	8a 00                	mov    (%eax),%al
  8014be:	84 c0                	test   %al,%al
  8014c0:	74 5a                	je     80151c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8014c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8014c5:	8b 00                	mov    (%eax),%eax
  8014c7:	83 f8 0f             	cmp    $0xf,%eax
  8014ca:	75 07                	jne    8014d3 <strsplit+0x6c>
		{
			return 0;
  8014cc:	b8 00 00 00 00       	mov    $0x0,%eax
  8014d1:	eb 66                	jmp    801539 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8014d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8014d6:	8b 00                	mov    (%eax),%eax
  8014d8:	8d 48 01             	lea    0x1(%eax),%ecx
  8014db:	8b 55 14             	mov    0x14(%ebp),%edx
  8014de:	89 0a                	mov    %ecx,(%edx)
  8014e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ea:	01 c2                	add    %eax,%edx
  8014ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ef:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014f1:	eb 03                	jmp    8014f6 <strsplit+0x8f>
			string++;
  8014f3:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f9:	8a 00                	mov    (%eax),%al
  8014fb:	84 c0                	test   %al,%al
  8014fd:	74 8b                	je     80148a <strsplit+0x23>
  8014ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801502:	8a 00                	mov    (%eax),%al
  801504:	0f be c0             	movsbl %al,%eax
  801507:	50                   	push   %eax
  801508:	ff 75 0c             	pushl  0xc(%ebp)
  80150b:	e8 b5 fa ff ff       	call   800fc5 <strchr>
  801510:	83 c4 08             	add    $0x8,%esp
  801513:	85 c0                	test   %eax,%eax
  801515:	74 dc                	je     8014f3 <strsplit+0x8c>
			string++;
	}
  801517:	e9 6e ff ff ff       	jmp    80148a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80151c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80151d:	8b 45 14             	mov    0x14(%ebp),%eax
  801520:	8b 00                	mov    (%eax),%eax
  801522:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801529:	8b 45 10             	mov    0x10(%ebp),%eax
  80152c:	01 d0                	add    %edx,%eax
  80152e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801534:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801539:	c9                   	leave  
  80153a:	c3                   	ret    

0080153b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80153b:	55                   	push   %ebp
  80153c:	89 e5                	mov    %esp,%ebp
  80153e:	57                   	push   %edi
  80153f:	56                   	push   %esi
  801540:	53                   	push   %ebx
  801541:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801544:	8b 45 08             	mov    0x8(%ebp),%eax
  801547:	8b 55 0c             	mov    0xc(%ebp),%edx
  80154a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80154d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801550:	8b 7d 18             	mov    0x18(%ebp),%edi
  801553:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801556:	cd 30                	int    $0x30
  801558:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80155b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80155e:	83 c4 10             	add    $0x10,%esp
  801561:	5b                   	pop    %ebx
  801562:	5e                   	pop    %esi
  801563:	5f                   	pop    %edi
  801564:	5d                   	pop    %ebp
  801565:	c3                   	ret    

00801566 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801566:	55                   	push   %ebp
  801567:	89 e5                	mov    %esp,%ebp
  801569:	83 ec 04             	sub    $0x4,%esp
  80156c:	8b 45 10             	mov    0x10(%ebp),%eax
  80156f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801572:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801576:	8b 45 08             	mov    0x8(%ebp),%eax
  801579:	6a 00                	push   $0x0
  80157b:	6a 00                	push   $0x0
  80157d:	52                   	push   %edx
  80157e:	ff 75 0c             	pushl  0xc(%ebp)
  801581:	50                   	push   %eax
  801582:	6a 00                	push   $0x0
  801584:	e8 b2 ff ff ff       	call   80153b <syscall>
  801589:	83 c4 18             	add    $0x18,%esp
}
  80158c:	90                   	nop
  80158d:	c9                   	leave  
  80158e:	c3                   	ret    

0080158f <sys_cgetc>:

int
sys_cgetc(void)
{
  80158f:	55                   	push   %ebp
  801590:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	6a 00                	push   $0x0
  80159c:	6a 01                	push   $0x1
  80159e:	e8 98 ff ff ff       	call   80153b <syscall>
  8015a3:	83 c4 18             	add    $0x18,%esp
}
  8015a6:	c9                   	leave  
  8015a7:	c3                   	ret    

008015a8 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8015a8:	55                   	push   %ebp
  8015a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8015ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	50                   	push   %eax
  8015b7:	6a 05                	push   $0x5
  8015b9:	e8 7d ff ff ff       	call   80153b <syscall>
  8015be:	83 c4 18             	add    $0x18,%esp
}
  8015c1:	c9                   	leave  
  8015c2:	c3                   	ret    

008015c3 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8015c3:	55                   	push   %ebp
  8015c4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	6a 00                	push   $0x0
  8015ce:	6a 00                	push   $0x0
  8015d0:	6a 02                	push   $0x2
  8015d2:	e8 64 ff ff ff       	call   80153b <syscall>
  8015d7:	83 c4 18             	add    $0x18,%esp
}
  8015da:	c9                   	leave  
  8015db:	c3                   	ret    

008015dc <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8015dc:	55                   	push   %ebp
  8015dd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 03                	push   $0x3
  8015eb:	e8 4b ff ff ff       	call   80153b <syscall>
  8015f0:	83 c4 18             	add    $0x18,%esp
}
  8015f3:	c9                   	leave  
  8015f4:	c3                   	ret    

008015f5 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8015f5:	55                   	push   %ebp
  8015f6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 00                	push   $0x0
  801600:	6a 00                	push   $0x0
  801602:	6a 04                	push   $0x4
  801604:	e8 32 ff ff ff       	call   80153b <syscall>
  801609:	83 c4 18             	add    $0x18,%esp
}
  80160c:	c9                   	leave  
  80160d:	c3                   	ret    

0080160e <sys_env_exit>:


void sys_env_exit(void)
{
  80160e:	55                   	push   %ebp
  80160f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	6a 06                	push   $0x6
  80161d:	e8 19 ff ff ff       	call   80153b <syscall>
  801622:	83 c4 18             	add    $0x18,%esp
}
  801625:	90                   	nop
  801626:	c9                   	leave  
  801627:	c3                   	ret    

00801628 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801628:	55                   	push   %ebp
  801629:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80162b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80162e:	8b 45 08             	mov    0x8(%ebp),%eax
  801631:	6a 00                	push   $0x0
  801633:	6a 00                	push   $0x0
  801635:	6a 00                	push   $0x0
  801637:	52                   	push   %edx
  801638:	50                   	push   %eax
  801639:	6a 07                	push   $0x7
  80163b:	e8 fb fe ff ff       	call   80153b <syscall>
  801640:	83 c4 18             	add    $0x18,%esp
}
  801643:	c9                   	leave  
  801644:	c3                   	ret    

00801645 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801645:	55                   	push   %ebp
  801646:	89 e5                	mov    %esp,%ebp
  801648:	56                   	push   %esi
  801649:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80164a:	8b 75 18             	mov    0x18(%ebp),%esi
  80164d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801650:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801653:	8b 55 0c             	mov    0xc(%ebp),%edx
  801656:	8b 45 08             	mov    0x8(%ebp),%eax
  801659:	56                   	push   %esi
  80165a:	53                   	push   %ebx
  80165b:	51                   	push   %ecx
  80165c:	52                   	push   %edx
  80165d:	50                   	push   %eax
  80165e:	6a 08                	push   $0x8
  801660:	e8 d6 fe ff ff       	call   80153b <syscall>
  801665:	83 c4 18             	add    $0x18,%esp
}
  801668:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80166b:	5b                   	pop    %ebx
  80166c:	5e                   	pop    %esi
  80166d:	5d                   	pop    %ebp
  80166e:	c3                   	ret    

0080166f <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80166f:	55                   	push   %ebp
  801670:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801672:	8b 55 0c             	mov    0xc(%ebp),%edx
  801675:	8b 45 08             	mov    0x8(%ebp),%eax
  801678:	6a 00                	push   $0x0
  80167a:	6a 00                	push   $0x0
  80167c:	6a 00                	push   $0x0
  80167e:	52                   	push   %edx
  80167f:	50                   	push   %eax
  801680:	6a 09                	push   $0x9
  801682:	e8 b4 fe ff ff       	call   80153b <syscall>
  801687:	83 c4 18             	add    $0x18,%esp
}
  80168a:	c9                   	leave  
  80168b:	c3                   	ret    

0080168c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80168c:	55                   	push   %ebp
  80168d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	6a 00                	push   $0x0
  801695:	ff 75 0c             	pushl  0xc(%ebp)
  801698:	ff 75 08             	pushl  0x8(%ebp)
  80169b:	6a 0a                	push   $0xa
  80169d:	e8 99 fe ff ff       	call   80153b <syscall>
  8016a2:	83 c4 18             	add    $0x18,%esp
}
  8016a5:	c9                   	leave  
  8016a6:	c3                   	ret    

008016a7 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8016a7:	55                   	push   %ebp
  8016a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8016aa:	6a 00                	push   $0x0
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 0b                	push   $0xb
  8016b6:	e8 80 fe ff ff       	call   80153b <syscall>
  8016bb:	83 c4 18             	add    $0x18,%esp
}
  8016be:	c9                   	leave  
  8016bf:	c3                   	ret    

008016c0 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8016c0:	55                   	push   %ebp
  8016c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8016c3:	6a 00                	push   $0x0
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	6a 00                	push   $0x0
  8016cd:	6a 0c                	push   $0xc
  8016cf:	e8 67 fe ff ff       	call   80153b <syscall>
  8016d4:	83 c4 18             	add    $0x18,%esp
}
  8016d7:	c9                   	leave  
  8016d8:	c3                   	ret    

008016d9 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8016d9:	55                   	push   %ebp
  8016da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	6a 00                	push   $0x0
  8016e6:	6a 0d                	push   $0xd
  8016e8:	e8 4e fe ff ff       	call   80153b <syscall>
  8016ed:	83 c4 18             	add    $0x18,%esp
}
  8016f0:	c9                   	leave  
  8016f1:	c3                   	ret    

008016f2 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8016f2:	55                   	push   %ebp
  8016f3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 00                	push   $0x0
  8016fb:	ff 75 0c             	pushl  0xc(%ebp)
  8016fe:	ff 75 08             	pushl  0x8(%ebp)
  801701:	6a 11                	push   $0x11
  801703:	e8 33 fe ff ff       	call   80153b <syscall>
  801708:	83 c4 18             	add    $0x18,%esp
	return;
  80170b:	90                   	nop
}
  80170c:	c9                   	leave  
  80170d:	c3                   	ret    

0080170e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80170e:	55                   	push   %ebp
  80170f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801711:	6a 00                	push   $0x0
  801713:	6a 00                	push   $0x0
  801715:	6a 00                	push   $0x0
  801717:	ff 75 0c             	pushl  0xc(%ebp)
  80171a:	ff 75 08             	pushl  0x8(%ebp)
  80171d:	6a 12                	push   $0x12
  80171f:	e8 17 fe ff ff       	call   80153b <syscall>
  801724:	83 c4 18             	add    $0x18,%esp
	return ;
  801727:	90                   	nop
}
  801728:	c9                   	leave  
  801729:	c3                   	ret    

0080172a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80172a:	55                   	push   %ebp
  80172b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80172d:	6a 00                	push   $0x0
  80172f:	6a 00                	push   $0x0
  801731:	6a 00                	push   $0x0
  801733:	6a 00                	push   $0x0
  801735:	6a 00                	push   $0x0
  801737:	6a 0e                	push   $0xe
  801739:	e8 fd fd ff ff       	call   80153b <syscall>
  80173e:	83 c4 18             	add    $0x18,%esp
}
  801741:	c9                   	leave  
  801742:	c3                   	ret    

00801743 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801743:	55                   	push   %ebp
  801744:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	6a 00                	push   $0x0
  80174c:	6a 00                	push   $0x0
  80174e:	ff 75 08             	pushl  0x8(%ebp)
  801751:	6a 0f                	push   $0xf
  801753:	e8 e3 fd ff ff       	call   80153b <syscall>
  801758:	83 c4 18             	add    $0x18,%esp
}
  80175b:	c9                   	leave  
  80175c:	c3                   	ret    

0080175d <sys_scarce_memory>:

void sys_scarce_memory()
{
  80175d:	55                   	push   %ebp
  80175e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801760:	6a 00                	push   $0x0
  801762:	6a 00                	push   $0x0
  801764:	6a 00                	push   $0x0
  801766:	6a 00                	push   $0x0
  801768:	6a 00                	push   $0x0
  80176a:	6a 10                	push   $0x10
  80176c:	e8 ca fd ff ff       	call   80153b <syscall>
  801771:	83 c4 18             	add    $0x18,%esp
}
  801774:	90                   	nop
  801775:	c9                   	leave  
  801776:	c3                   	ret    

00801777 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801777:	55                   	push   %ebp
  801778:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	6a 00                	push   $0x0
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	6a 14                	push   $0x14
  801786:	e8 b0 fd ff ff       	call   80153b <syscall>
  80178b:	83 c4 18             	add    $0x18,%esp
}
  80178e:	90                   	nop
  80178f:	c9                   	leave  
  801790:	c3                   	ret    

00801791 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801791:	55                   	push   %ebp
  801792:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 15                	push   $0x15
  8017a0:	e8 96 fd ff ff       	call   80153b <syscall>
  8017a5:	83 c4 18             	add    $0x18,%esp
}
  8017a8:	90                   	nop
  8017a9:	c9                   	leave  
  8017aa:	c3                   	ret    

008017ab <sys_cputc>:


void
sys_cputc(const char c)
{
  8017ab:	55                   	push   %ebp
  8017ac:	89 e5                	mov    %esp,%ebp
  8017ae:	83 ec 04             	sub    $0x4,%esp
  8017b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8017b7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017bb:	6a 00                	push   $0x0
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	50                   	push   %eax
  8017c4:	6a 16                	push   $0x16
  8017c6:	e8 70 fd ff ff       	call   80153b <syscall>
  8017cb:	83 c4 18             	add    $0x18,%esp
}
  8017ce:	90                   	nop
  8017cf:	c9                   	leave  
  8017d0:	c3                   	ret    

008017d1 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8017d1:	55                   	push   %ebp
  8017d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 17                	push   $0x17
  8017e0:	e8 56 fd ff ff       	call   80153b <syscall>
  8017e5:	83 c4 18             	add    $0x18,%esp
}
  8017e8:	90                   	nop
  8017e9:	c9                   	leave  
  8017ea:	c3                   	ret    

008017eb <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8017eb:	55                   	push   %ebp
  8017ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8017ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 00                	push   $0x0
  8017f7:	ff 75 0c             	pushl  0xc(%ebp)
  8017fa:	50                   	push   %eax
  8017fb:	6a 18                	push   $0x18
  8017fd:	e8 39 fd ff ff       	call   80153b <syscall>
  801802:	83 c4 18             	add    $0x18,%esp
}
  801805:	c9                   	leave  
  801806:	c3                   	ret    

00801807 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801807:	55                   	push   %ebp
  801808:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80180a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80180d:	8b 45 08             	mov    0x8(%ebp),%eax
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	52                   	push   %edx
  801817:	50                   	push   %eax
  801818:	6a 1b                	push   $0x1b
  80181a:	e8 1c fd ff ff       	call   80153b <syscall>
  80181f:	83 c4 18             	add    $0x18,%esp
}
  801822:	c9                   	leave  
  801823:	c3                   	ret    

00801824 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801824:	55                   	push   %ebp
  801825:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801827:	8b 55 0c             	mov    0xc(%ebp),%edx
  80182a:	8b 45 08             	mov    0x8(%ebp),%eax
  80182d:	6a 00                	push   $0x0
  80182f:	6a 00                	push   $0x0
  801831:	6a 00                	push   $0x0
  801833:	52                   	push   %edx
  801834:	50                   	push   %eax
  801835:	6a 19                	push   $0x19
  801837:	e8 ff fc ff ff       	call   80153b <syscall>
  80183c:	83 c4 18             	add    $0x18,%esp
}
  80183f:	90                   	nop
  801840:	c9                   	leave  
  801841:	c3                   	ret    

00801842 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801842:	55                   	push   %ebp
  801843:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801845:	8b 55 0c             	mov    0xc(%ebp),%edx
  801848:	8b 45 08             	mov    0x8(%ebp),%eax
  80184b:	6a 00                	push   $0x0
  80184d:	6a 00                	push   $0x0
  80184f:	6a 00                	push   $0x0
  801851:	52                   	push   %edx
  801852:	50                   	push   %eax
  801853:	6a 1a                	push   $0x1a
  801855:	e8 e1 fc ff ff       	call   80153b <syscall>
  80185a:	83 c4 18             	add    $0x18,%esp
}
  80185d:	90                   	nop
  80185e:	c9                   	leave  
  80185f:	c3                   	ret    

00801860 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801860:	55                   	push   %ebp
  801861:	89 e5                	mov    %esp,%ebp
  801863:	83 ec 04             	sub    $0x4,%esp
  801866:	8b 45 10             	mov    0x10(%ebp),%eax
  801869:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80186c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80186f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801873:	8b 45 08             	mov    0x8(%ebp),%eax
  801876:	6a 00                	push   $0x0
  801878:	51                   	push   %ecx
  801879:	52                   	push   %edx
  80187a:	ff 75 0c             	pushl  0xc(%ebp)
  80187d:	50                   	push   %eax
  80187e:	6a 1c                	push   $0x1c
  801880:	e8 b6 fc ff ff       	call   80153b <syscall>
  801885:	83 c4 18             	add    $0x18,%esp
}
  801888:	c9                   	leave  
  801889:	c3                   	ret    

0080188a <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80188a:	55                   	push   %ebp
  80188b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80188d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801890:	8b 45 08             	mov    0x8(%ebp),%eax
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	52                   	push   %edx
  80189a:	50                   	push   %eax
  80189b:	6a 1d                	push   $0x1d
  80189d:	e8 99 fc ff ff       	call   80153b <syscall>
  8018a2:	83 c4 18             	add    $0x18,%esp
}
  8018a5:	c9                   	leave  
  8018a6:	c3                   	ret    

008018a7 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8018a7:	55                   	push   %ebp
  8018a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8018aa:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b3:	6a 00                	push   $0x0
  8018b5:	6a 00                	push   $0x0
  8018b7:	51                   	push   %ecx
  8018b8:	52                   	push   %edx
  8018b9:	50                   	push   %eax
  8018ba:	6a 1e                	push   $0x1e
  8018bc:	e8 7a fc ff ff       	call   80153b <syscall>
  8018c1:	83 c4 18             	add    $0x18,%esp
}
  8018c4:	c9                   	leave  
  8018c5:	c3                   	ret    

008018c6 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8018c6:	55                   	push   %ebp
  8018c7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8018c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	52                   	push   %edx
  8018d6:	50                   	push   %eax
  8018d7:	6a 1f                	push   $0x1f
  8018d9:	e8 5d fc ff ff       	call   80153b <syscall>
  8018de:	83 c4 18             	add    $0x18,%esp
}
  8018e1:	c9                   	leave  
  8018e2:	c3                   	ret    

008018e3 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8018e3:	55                   	push   %ebp
  8018e4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8018e6:	6a 00                	push   $0x0
  8018e8:	6a 00                	push   $0x0
  8018ea:	6a 00                	push   $0x0
  8018ec:	6a 00                	push   $0x0
  8018ee:	6a 00                	push   $0x0
  8018f0:	6a 20                	push   $0x20
  8018f2:	e8 44 fc ff ff       	call   80153b <syscall>
  8018f7:	83 c4 18             	add    $0x18,%esp
}
  8018fa:	c9                   	leave  
  8018fb:	c3                   	ret    

008018fc <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8018fc:	55                   	push   %ebp
  8018fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8018ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801902:	6a 00                	push   $0x0
  801904:	ff 75 14             	pushl  0x14(%ebp)
  801907:	ff 75 10             	pushl  0x10(%ebp)
  80190a:	ff 75 0c             	pushl  0xc(%ebp)
  80190d:	50                   	push   %eax
  80190e:	6a 21                	push   $0x21
  801910:	e8 26 fc ff ff       	call   80153b <syscall>
  801915:	83 c4 18             	add    $0x18,%esp
}
  801918:	c9                   	leave  
  801919:	c3                   	ret    

0080191a <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80191a:	55                   	push   %ebp
  80191b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80191d:	8b 45 08             	mov    0x8(%ebp),%eax
  801920:	6a 00                	push   $0x0
  801922:	6a 00                	push   $0x0
  801924:	6a 00                	push   $0x0
  801926:	6a 00                	push   $0x0
  801928:	50                   	push   %eax
  801929:	6a 22                	push   $0x22
  80192b:	e8 0b fc ff ff       	call   80153b <syscall>
  801930:	83 c4 18             	add    $0x18,%esp
}
  801933:	90                   	nop
  801934:	c9                   	leave  
  801935:	c3                   	ret    

00801936 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801936:	55                   	push   %ebp
  801937:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801939:	8b 45 08             	mov    0x8(%ebp),%eax
  80193c:	6a 00                	push   $0x0
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	6a 00                	push   $0x0
  801944:	50                   	push   %eax
  801945:	6a 23                	push   $0x23
  801947:	e8 ef fb ff ff       	call   80153b <syscall>
  80194c:	83 c4 18             	add    $0x18,%esp
}
  80194f:	90                   	nop
  801950:	c9                   	leave  
  801951:	c3                   	ret    

00801952 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801952:	55                   	push   %ebp
  801953:	89 e5                	mov    %esp,%ebp
  801955:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801958:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80195b:	8d 50 04             	lea    0x4(%eax),%edx
  80195e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801961:	6a 00                	push   $0x0
  801963:	6a 00                	push   $0x0
  801965:	6a 00                	push   $0x0
  801967:	52                   	push   %edx
  801968:	50                   	push   %eax
  801969:	6a 24                	push   $0x24
  80196b:	e8 cb fb ff ff       	call   80153b <syscall>
  801970:	83 c4 18             	add    $0x18,%esp
	return result;
  801973:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801976:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801979:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80197c:	89 01                	mov    %eax,(%ecx)
  80197e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801981:	8b 45 08             	mov    0x8(%ebp),%eax
  801984:	c9                   	leave  
  801985:	c2 04 00             	ret    $0x4

00801988 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801988:	55                   	push   %ebp
  801989:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80198b:	6a 00                	push   $0x0
  80198d:	6a 00                	push   $0x0
  80198f:	ff 75 10             	pushl  0x10(%ebp)
  801992:	ff 75 0c             	pushl  0xc(%ebp)
  801995:	ff 75 08             	pushl  0x8(%ebp)
  801998:	6a 13                	push   $0x13
  80199a:	e8 9c fb ff ff       	call   80153b <syscall>
  80199f:	83 c4 18             	add    $0x18,%esp
	return ;
  8019a2:	90                   	nop
}
  8019a3:	c9                   	leave  
  8019a4:	c3                   	ret    

008019a5 <sys_rcr2>:
uint32 sys_rcr2()
{
  8019a5:	55                   	push   %ebp
  8019a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8019a8:	6a 00                	push   $0x0
  8019aa:	6a 00                	push   $0x0
  8019ac:	6a 00                	push   $0x0
  8019ae:	6a 00                	push   $0x0
  8019b0:	6a 00                	push   $0x0
  8019b2:	6a 25                	push   $0x25
  8019b4:	e8 82 fb ff ff       	call   80153b <syscall>
  8019b9:	83 c4 18             	add    $0x18,%esp
}
  8019bc:	c9                   	leave  
  8019bd:	c3                   	ret    

008019be <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8019be:	55                   	push   %ebp
  8019bf:	89 e5                	mov    %esp,%ebp
  8019c1:	83 ec 04             	sub    $0x4,%esp
  8019c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8019ca:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8019ce:	6a 00                	push   $0x0
  8019d0:	6a 00                	push   $0x0
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 00                	push   $0x0
  8019d6:	50                   	push   %eax
  8019d7:	6a 26                	push   $0x26
  8019d9:	e8 5d fb ff ff       	call   80153b <syscall>
  8019de:	83 c4 18             	add    $0x18,%esp
	return ;
  8019e1:	90                   	nop
}
  8019e2:	c9                   	leave  
  8019e3:	c3                   	ret    

008019e4 <rsttst>:
void rsttst()
{
  8019e4:	55                   	push   %ebp
  8019e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8019e7:	6a 00                	push   $0x0
  8019e9:	6a 00                	push   $0x0
  8019eb:	6a 00                	push   $0x0
  8019ed:	6a 00                	push   $0x0
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 28                	push   $0x28
  8019f3:	e8 43 fb ff ff       	call   80153b <syscall>
  8019f8:	83 c4 18             	add    $0x18,%esp
	return ;
  8019fb:	90                   	nop
}
  8019fc:	c9                   	leave  
  8019fd:	c3                   	ret    

008019fe <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8019fe:	55                   	push   %ebp
  8019ff:	89 e5                	mov    %esp,%ebp
  801a01:	83 ec 04             	sub    $0x4,%esp
  801a04:	8b 45 14             	mov    0x14(%ebp),%eax
  801a07:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a0a:	8b 55 18             	mov    0x18(%ebp),%edx
  801a0d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a11:	52                   	push   %edx
  801a12:	50                   	push   %eax
  801a13:	ff 75 10             	pushl  0x10(%ebp)
  801a16:	ff 75 0c             	pushl  0xc(%ebp)
  801a19:	ff 75 08             	pushl  0x8(%ebp)
  801a1c:	6a 27                	push   $0x27
  801a1e:	e8 18 fb ff ff       	call   80153b <syscall>
  801a23:	83 c4 18             	add    $0x18,%esp
	return ;
  801a26:	90                   	nop
}
  801a27:	c9                   	leave  
  801a28:	c3                   	ret    

00801a29 <chktst>:
void chktst(uint32 n)
{
  801a29:	55                   	push   %ebp
  801a2a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	6a 00                	push   $0x0
  801a32:	6a 00                	push   $0x0
  801a34:	ff 75 08             	pushl  0x8(%ebp)
  801a37:	6a 29                	push   $0x29
  801a39:	e8 fd fa ff ff       	call   80153b <syscall>
  801a3e:	83 c4 18             	add    $0x18,%esp
	return ;
  801a41:	90                   	nop
}
  801a42:	c9                   	leave  
  801a43:	c3                   	ret    

00801a44 <inctst>:

void inctst()
{
  801a44:	55                   	push   %ebp
  801a45:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	6a 00                	push   $0x0
  801a4d:	6a 00                	push   $0x0
  801a4f:	6a 00                	push   $0x0
  801a51:	6a 2a                	push   $0x2a
  801a53:	e8 e3 fa ff ff       	call   80153b <syscall>
  801a58:	83 c4 18             	add    $0x18,%esp
	return ;
  801a5b:	90                   	nop
}
  801a5c:	c9                   	leave  
  801a5d:	c3                   	ret    

00801a5e <gettst>:
uint32 gettst()
{
  801a5e:	55                   	push   %ebp
  801a5f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	6a 00                	push   $0x0
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 2b                	push   $0x2b
  801a6d:	e8 c9 fa ff ff       	call   80153b <syscall>
  801a72:	83 c4 18             	add    $0x18,%esp
}
  801a75:	c9                   	leave  
  801a76:	c3                   	ret    

00801a77 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a77:	55                   	push   %ebp
  801a78:	89 e5                	mov    %esp,%ebp
  801a7a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	6a 00                	push   $0x0
  801a83:	6a 00                	push   $0x0
  801a85:	6a 00                	push   $0x0
  801a87:	6a 2c                	push   $0x2c
  801a89:	e8 ad fa ff ff       	call   80153b <syscall>
  801a8e:	83 c4 18             	add    $0x18,%esp
  801a91:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a94:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801a98:	75 07                	jne    801aa1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801a9a:	b8 01 00 00 00       	mov    $0x1,%eax
  801a9f:	eb 05                	jmp    801aa6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801aa1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801aa6:	c9                   	leave  
  801aa7:	c3                   	ret    

00801aa8 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801aa8:	55                   	push   %ebp
  801aa9:	89 e5                	mov    %esp,%ebp
  801aab:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	6a 2c                	push   $0x2c
  801aba:	e8 7c fa ff ff       	call   80153b <syscall>
  801abf:	83 c4 18             	add    $0x18,%esp
  801ac2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801ac5:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801ac9:	75 07                	jne    801ad2 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801acb:	b8 01 00 00 00       	mov    $0x1,%eax
  801ad0:	eb 05                	jmp    801ad7 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801ad2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ad7:	c9                   	leave  
  801ad8:	c3                   	ret    

00801ad9 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ad9:	55                   	push   %ebp
  801ada:	89 e5                	mov    %esp,%ebp
  801adc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801adf:	6a 00                	push   $0x0
  801ae1:	6a 00                	push   $0x0
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 2c                	push   $0x2c
  801aeb:	e8 4b fa ff ff       	call   80153b <syscall>
  801af0:	83 c4 18             	add    $0x18,%esp
  801af3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801af6:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801afa:	75 07                	jne    801b03 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801afc:	b8 01 00 00 00       	mov    $0x1,%eax
  801b01:	eb 05                	jmp    801b08 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801b03:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b08:	c9                   	leave  
  801b09:	c3                   	ret    

00801b0a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801b0a:	55                   	push   %ebp
  801b0b:	89 e5                	mov    %esp,%ebp
  801b0d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b10:	6a 00                	push   $0x0
  801b12:	6a 00                	push   $0x0
  801b14:	6a 00                	push   $0x0
  801b16:	6a 00                	push   $0x0
  801b18:	6a 00                	push   $0x0
  801b1a:	6a 2c                	push   $0x2c
  801b1c:	e8 1a fa ff ff       	call   80153b <syscall>
  801b21:	83 c4 18             	add    $0x18,%esp
  801b24:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801b27:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801b2b:	75 07                	jne    801b34 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801b2d:	b8 01 00 00 00       	mov    $0x1,%eax
  801b32:	eb 05                	jmp    801b39 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801b34:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b39:	c9                   	leave  
  801b3a:	c3                   	ret    

00801b3b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b3b:	55                   	push   %ebp
  801b3c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b3e:	6a 00                	push   $0x0
  801b40:	6a 00                	push   $0x0
  801b42:	6a 00                	push   $0x0
  801b44:	6a 00                	push   $0x0
  801b46:	ff 75 08             	pushl  0x8(%ebp)
  801b49:	6a 2d                	push   $0x2d
  801b4b:	e8 eb f9 ff ff       	call   80153b <syscall>
  801b50:	83 c4 18             	add    $0x18,%esp
	return ;
  801b53:	90                   	nop
}
  801b54:	c9                   	leave  
  801b55:	c3                   	ret    

00801b56 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b56:	55                   	push   %ebp
  801b57:	89 e5                	mov    %esp,%ebp
  801b59:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b5a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b5d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b60:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b63:	8b 45 08             	mov    0x8(%ebp),%eax
  801b66:	6a 00                	push   $0x0
  801b68:	53                   	push   %ebx
  801b69:	51                   	push   %ecx
  801b6a:	52                   	push   %edx
  801b6b:	50                   	push   %eax
  801b6c:	6a 2e                	push   $0x2e
  801b6e:	e8 c8 f9 ff ff       	call   80153b <syscall>
  801b73:	83 c4 18             	add    $0x18,%esp
}
  801b76:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b79:	c9                   	leave  
  801b7a:	c3                   	ret    

00801b7b <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b7b:	55                   	push   %ebp
  801b7c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b7e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b81:	8b 45 08             	mov    0x8(%ebp),%eax
  801b84:	6a 00                	push   $0x0
  801b86:	6a 00                	push   $0x0
  801b88:	6a 00                	push   $0x0
  801b8a:	52                   	push   %edx
  801b8b:	50                   	push   %eax
  801b8c:	6a 2f                	push   $0x2f
  801b8e:	e8 a8 f9 ff ff       	call   80153b <syscall>
  801b93:	83 c4 18             	add    $0x18,%esp
}
  801b96:	c9                   	leave  
  801b97:	c3                   	ret    

00801b98 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  801b98:	55                   	push   %ebp
  801b99:	89 e5                	mov    %esp,%ebp
  801b9b:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  801b9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba1:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  801ba4:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  801ba8:	83 ec 0c             	sub    $0xc,%esp
  801bab:	50                   	push   %eax
  801bac:	e8 fa fb ff ff       	call   8017ab <sys_cputc>
  801bb1:	83 c4 10             	add    $0x10,%esp
}
  801bb4:	90                   	nop
  801bb5:	c9                   	leave  
  801bb6:	c3                   	ret    

00801bb7 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  801bb7:	55                   	push   %ebp
  801bb8:	89 e5                	mov    %esp,%ebp
  801bba:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801bbd:	e8 b5 fb ff ff       	call   801777 <sys_disable_interrupt>
	char c = ch;
  801bc2:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc5:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  801bc8:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  801bcc:	83 ec 0c             	sub    $0xc,%esp
  801bcf:	50                   	push   %eax
  801bd0:	e8 d6 fb ff ff       	call   8017ab <sys_cputc>
  801bd5:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  801bd8:	e8 b4 fb ff ff       	call   801791 <sys_enable_interrupt>
}
  801bdd:	90                   	nop
  801bde:	c9                   	leave  
  801bdf:	c3                   	ret    

00801be0 <getchar>:

int
getchar(void)
{
  801be0:	55                   	push   %ebp
  801be1:	89 e5                	mov    %esp,%ebp
  801be3:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  801be6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801bed:	eb 08                	jmp    801bf7 <getchar+0x17>
	{
		c = sys_cgetc();
  801bef:	e8 9b f9 ff ff       	call   80158f <sys_cgetc>
  801bf4:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  801bf7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801bfb:	74 f2                	je     801bef <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  801bfd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801c00:	c9                   	leave  
  801c01:	c3                   	ret    

00801c02 <atomic_getchar>:

int
atomic_getchar(void)
{
  801c02:	55                   	push   %ebp
  801c03:	89 e5                	mov    %esp,%ebp
  801c05:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801c08:	e8 6a fb ff ff       	call   801777 <sys_disable_interrupt>
	int c=0;
  801c0d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801c14:	eb 08                	jmp    801c1e <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  801c16:	e8 74 f9 ff ff       	call   80158f <sys_cgetc>
  801c1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  801c1e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801c22:	74 f2                	je     801c16 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  801c24:	e8 68 fb ff ff       	call   801791 <sys_enable_interrupt>
	return c;
  801c29:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801c2c:	c9                   	leave  
  801c2d:	c3                   	ret    

00801c2e <iscons>:

int iscons(int fdnum)
{
  801c2e:	55                   	push   %ebp
  801c2f:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  801c31:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801c36:	5d                   	pop    %ebp
  801c37:	c3                   	ret    

00801c38 <__udivdi3>:
  801c38:	55                   	push   %ebp
  801c39:	57                   	push   %edi
  801c3a:	56                   	push   %esi
  801c3b:	53                   	push   %ebx
  801c3c:	83 ec 1c             	sub    $0x1c,%esp
  801c3f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801c43:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801c47:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c4b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801c4f:	89 ca                	mov    %ecx,%edx
  801c51:	89 f8                	mov    %edi,%eax
  801c53:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801c57:	85 f6                	test   %esi,%esi
  801c59:	75 2d                	jne    801c88 <__udivdi3+0x50>
  801c5b:	39 cf                	cmp    %ecx,%edi
  801c5d:	77 65                	ja     801cc4 <__udivdi3+0x8c>
  801c5f:	89 fd                	mov    %edi,%ebp
  801c61:	85 ff                	test   %edi,%edi
  801c63:	75 0b                	jne    801c70 <__udivdi3+0x38>
  801c65:	b8 01 00 00 00       	mov    $0x1,%eax
  801c6a:	31 d2                	xor    %edx,%edx
  801c6c:	f7 f7                	div    %edi
  801c6e:	89 c5                	mov    %eax,%ebp
  801c70:	31 d2                	xor    %edx,%edx
  801c72:	89 c8                	mov    %ecx,%eax
  801c74:	f7 f5                	div    %ebp
  801c76:	89 c1                	mov    %eax,%ecx
  801c78:	89 d8                	mov    %ebx,%eax
  801c7a:	f7 f5                	div    %ebp
  801c7c:	89 cf                	mov    %ecx,%edi
  801c7e:	89 fa                	mov    %edi,%edx
  801c80:	83 c4 1c             	add    $0x1c,%esp
  801c83:	5b                   	pop    %ebx
  801c84:	5e                   	pop    %esi
  801c85:	5f                   	pop    %edi
  801c86:	5d                   	pop    %ebp
  801c87:	c3                   	ret    
  801c88:	39 ce                	cmp    %ecx,%esi
  801c8a:	77 28                	ja     801cb4 <__udivdi3+0x7c>
  801c8c:	0f bd fe             	bsr    %esi,%edi
  801c8f:	83 f7 1f             	xor    $0x1f,%edi
  801c92:	75 40                	jne    801cd4 <__udivdi3+0x9c>
  801c94:	39 ce                	cmp    %ecx,%esi
  801c96:	72 0a                	jb     801ca2 <__udivdi3+0x6a>
  801c98:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801c9c:	0f 87 9e 00 00 00    	ja     801d40 <__udivdi3+0x108>
  801ca2:	b8 01 00 00 00       	mov    $0x1,%eax
  801ca7:	89 fa                	mov    %edi,%edx
  801ca9:	83 c4 1c             	add    $0x1c,%esp
  801cac:	5b                   	pop    %ebx
  801cad:	5e                   	pop    %esi
  801cae:	5f                   	pop    %edi
  801caf:	5d                   	pop    %ebp
  801cb0:	c3                   	ret    
  801cb1:	8d 76 00             	lea    0x0(%esi),%esi
  801cb4:	31 ff                	xor    %edi,%edi
  801cb6:	31 c0                	xor    %eax,%eax
  801cb8:	89 fa                	mov    %edi,%edx
  801cba:	83 c4 1c             	add    $0x1c,%esp
  801cbd:	5b                   	pop    %ebx
  801cbe:	5e                   	pop    %esi
  801cbf:	5f                   	pop    %edi
  801cc0:	5d                   	pop    %ebp
  801cc1:	c3                   	ret    
  801cc2:	66 90                	xchg   %ax,%ax
  801cc4:	89 d8                	mov    %ebx,%eax
  801cc6:	f7 f7                	div    %edi
  801cc8:	31 ff                	xor    %edi,%edi
  801cca:	89 fa                	mov    %edi,%edx
  801ccc:	83 c4 1c             	add    $0x1c,%esp
  801ccf:	5b                   	pop    %ebx
  801cd0:	5e                   	pop    %esi
  801cd1:	5f                   	pop    %edi
  801cd2:	5d                   	pop    %ebp
  801cd3:	c3                   	ret    
  801cd4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801cd9:	89 eb                	mov    %ebp,%ebx
  801cdb:	29 fb                	sub    %edi,%ebx
  801cdd:	89 f9                	mov    %edi,%ecx
  801cdf:	d3 e6                	shl    %cl,%esi
  801ce1:	89 c5                	mov    %eax,%ebp
  801ce3:	88 d9                	mov    %bl,%cl
  801ce5:	d3 ed                	shr    %cl,%ebp
  801ce7:	89 e9                	mov    %ebp,%ecx
  801ce9:	09 f1                	or     %esi,%ecx
  801ceb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801cef:	89 f9                	mov    %edi,%ecx
  801cf1:	d3 e0                	shl    %cl,%eax
  801cf3:	89 c5                	mov    %eax,%ebp
  801cf5:	89 d6                	mov    %edx,%esi
  801cf7:	88 d9                	mov    %bl,%cl
  801cf9:	d3 ee                	shr    %cl,%esi
  801cfb:	89 f9                	mov    %edi,%ecx
  801cfd:	d3 e2                	shl    %cl,%edx
  801cff:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d03:	88 d9                	mov    %bl,%cl
  801d05:	d3 e8                	shr    %cl,%eax
  801d07:	09 c2                	or     %eax,%edx
  801d09:	89 d0                	mov    %edx,%eax
  801d0b:	89 f2                	mov    %esi,%edx
  801d0d:	f7 74 24 0c          	divl   0xc(%esp)
  801d11:	89 d6                	mov    %edx,%esi
  801d13:	89 c3                	mov    %eax,%ebx
  801d15:	f7 e5                	mul    %ebp
  801d17:	39 d6                	cmp    %edx,%esi
  801d19:	72 19                	jb     801d34 <__udivdi3+0xfc>
  801d1b:	74 0b                	je     801d28 <__udivdi3+0xf0>
  801d1d:	89 d8                	mov    %ebx,%eax
  801d1f:	31 ff                	xor    %edi,%edi
  801d21:	e9 58 ff ff ff       	jmp    801c7e <__udivdi3+0x46>
  801d26:	66 90                	xchg   %ax,%ax
  801d28:	8b 54 24 08          	mov    0x8(%esp),%edx
  801d2c:	89 f9                	mov    %edi,%ecx
  801d2e:	d3 e2                	shl    %cl,%edx
  801d30:	39 c2                	cmp    %eax,%edx
  801d32:	73 e9                	jae    801d1d <__udivdi3+0xe5>
  801d34:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801d37:	31 ff                	xor    %edi,%edi
  801d39:	e9 40 ff ff ff       	jmp    801c7e <__udivdi3+0x46>
  801d3e:	66 90                	xchg   %ax,%ax
  801d40:	31 c0                	xor    %eax,%eax
  801d42:	e9 37 ff ff ff       	jmp    801c7e <__udivdi3+0x46>
  801d47:	90                   	nop

00801d48 <__umoddi3>:
  801d48:	55                   	push   %ebp
  801d49:	57                   	push   %edi
  801d4a:	56                   	push   %esi
  801d4b:	53                   	push   %ebx
  801d4c:	83 ec 1c             	sub    $0x1c,%esp
  801d4f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801d53:	8b 74 24 34          	mov    0x34(%esp),%esi
  801d57:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d5b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801d5f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801d63:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801d67:	89 f3                	mov    %esi,%ebx
  801d69:	89 fa                	mov    %edi,%edx
  801d6b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d6f:	89 34 24             	mov    %esi,(%esp)
  801d72:	85 c0                	test   %eax,%eax
  801d74:	75 1a                	jne    801d90 <__umoddi3+0x48>
  801d76:	39 f7                	cmp    %esi,%edi
  801d78:	0f 86 a2 00 00 00    	jbe    801e20 <__umoddi3+0xd8>
  801d7e:	89 c8                	mov    %ecx,%eax
  801d80:	89 f2                	mov    %esi,%edx
  801d82:	f7 f7                	div    %edi
  801d84:	89 d0                	mov    %edx,%eax
  801d86:	31 d2                	xor    %edx,%edx
  801d88:	83 c4 1c             	add    $0x1c,%esp
  801d8b:	5b                   	pop    %ebx
  801d8c:	5e                   	pop    %esi
  801d8d:	5f                   	pop    %edi
  801d8e:	5d                   	pop    %ebp
  801d8f:	c3                   	ret    
  801d90:	39 f0                	cmp    %esi,%eax
  801d92:	0f 87 ac 00 00 00    	ja     801e44 <__umoddi3+0xfc>
  801d98:	0f bd e8             	bsr    %eax,%ebp
  801d9b:	83 f5 1f             	xor    $0x1f,%ebp
  801d9e:	0f 84 ac 00 00 00    	je     801e50 <__umoddi3+0x108>
  801da4:	bf 20 00 00 00       	mov    $0x20,%edi
  801da9:	29 ef                	sub    %ebp,%edi
  801dab:	89 fe                	mov    %edi,%esi
  801dad:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801db1:	89 e9                	mov    %ebp,%ecx
  801db3:	d3 e0                	shl    %cl,%eax
  801db5:	89 d7                	mov    %edx,%edi
  801db7:	89 f1                	mov    %esi,%ecx
  801db9:	d3 ef                	shr    %cl,%edi
  801dbb:	09 c7                	or     %eax,%edi
  801dbd:	89 e9                	mov    %ebp,%ecx
  801dbf:	d3 e2                	shl    %cl,%edx
  801dc1:	89 14 24             	mov    %edx,(%esp)
  801dc4:	89 d8                	mov    %ebx,%eax
  801dc6:	d3 e0                	shl    %cl,%eax
  801dc8:	89 c2                	mov    %eax,%edx
  801dca:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dce:	d3 e0                	shl    %cl,%eax
  801dd0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801dd4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dd8:	89 f1                	mov    %esi,%ecx
  801dda:	d3 e8                	shr    %cl,%eax
  801ddc:	09 d0                	or     %edx,%eax
  801dde:	d3 eb                	shr    %cl,%ebx
  801de0:	89 da                	mov    %ebx,%edx
  801de2:	f7 f7                	div    %edi
  801de4:	89 d3                	mov    %edx,%ebx
  801de6:	f7 24 24             	mull   (%esp)
  801de9:	89 c6                	mov    %eax,%esi
  801deb:	89 d1                	mov    %edx,%ecx
  801ded:	39 d3                	cmp    %edx,%ebx
  801def:	0f 82 87 00 00 00    	jb     801e7c <__umoddi3+0x134>
  801df5:	0f 84 91 00 00 00    	je     801e8c <__umoddi3+0x144>
  801dfb:	8b 54 24 04          	mov    0x4(%esp),%edx
  801dff:	29 f2                	sub    %esi,%edx
  801e01:	19 cb                	sbb    %ecx,%ebx
  801e03:	89 d8                	mov    %ebx,%eax
  801e05:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801e09:	d3 e0                	shl    %cl,%eax
  801e0b:	89 e9                	mov    %ebp,%ecx
  801e0d:	d3 ea                	shr    %cl,%edx
  801e0f:	09 d0                	or     %edx,%eax
  801e11:	89 e9                	mov    %ebp,%ecx
  801e13:	d3 eb                	shr    %cl,%ebx
  801e15:	89 da                	mov    %ebx,%edx
  801e17:	83 c4 1c             	add    $0x1c,%esp
  801e1a:	5b                   	pop    %ebx
  801e1b:	5e                   	pop    %esi
  801e1c:	5f                   	pop    %edi
  801e1d:	5d                   	pop    %ebp
  801e1e:	c3                   	ret    
  801e1f:	90                   	nop
  801e20:	89 fd                	mov    %edi,%ebp
  801e22:	85 ff                	test   %edi,%edi
  801e24:	75 0b                	jne    801e31 <__umoddi3+0xe9>
  801e26:	b8 01 00 00 00       	mov    $0x1,%eax
  801e2b:	31 d2                	xor    %edx,%edx
  801e2d:	f7 f7                	div    %edi
  801e2f:	89 c5                	mov    %eax,%ebp
  801e31:	89 f0                	mov    %esi,%eax
  801e33:	31 d2                	xor    %edx,%edx
  801e35:	f7 f5                	div    %ebp
  801e37:	89 c8                	mov    %ecx,%eax
  801e39:	f7 f5                	div    %ebp
  801e3b:	89 d0                	mov    %edx,%eax
  801e3d:	e9 44 ff ff ff       	jmp    801d86 <__umoddi3+0x3e>
  801e42:	66 90                	xchg   %ax,%ax
  801e44:	89 c8                	mov    %ecx,%eax
  801e46:	89 f2                	mov    %esi,%edx
  801e48:	83 c4 1c             	add    $0x1c,%esp
  801e4b:	5b                   	pop    %ebx
  801e4c:	5e                   	pop    %esi
  801e4d:	5f                   	pop    %edi
  801e4e:	5d                   	pop    %ebp
  801e4f:	c3                   	ret    
  801e50:	3b 04 24             	cmp    (%esp),%eax
  801e53:	72 06                	jb     801e5b <__umoddi3+0x113>
  801e55:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801e59:	77 0f                	ja     801e6a <__umoddi3+0x122>
  801e5b:	89 f2                	mov    %esi,%edx
  801e5d:	29 f9                	sub    %edi,%ecx
  801e5f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801e63:	89 14 24             	mov    %edx,(%esp)
  801e66:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e6a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801e6e:	8b 14 24             	mov    (%esp),%edx
  801e71:	83 c4 1c             	add    $0x1c,%esp
  801e74:	5b                   	pop    %ebx
  801e75:	5e                   	pop    %esi
  801e76:	5f                   	pop    %edi
  801e77:	5d                   	pop    %ebp
  801e78:	c3                   	ret    
  801e79:	8d 76 00             	lea    0x0(%esi),%esi
  801e7c:	2b 04 24             	sub    (%esp),%eax
  801e7f:	19 fa                	sbb    %edi,%edx
  801e81:	89 d1                	mov    %edx,%ecx
  801e83:	89 c6                	mov    %eax,%esi
  801e85:	e9 71 ff ff ff       	jmp    801dfb <__umoddi3+0xb3>
  801e8a:	66 90                	xchg   %ax,%ax
  801e8c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801e90:	72 ea                	jb     801e7c <__umoddi3+0x134>
  801e92:	89 d9                	mov    %ebx,%ecx
  801e94:	e9 62 ff ff ff       	jmp    801dfb <__umoddi3+0xb3>
