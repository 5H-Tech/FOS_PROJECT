
obj/user/tst_page_replacement_free_scarce_mem_master_2:     file format elf32-i386


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
  800031:	e8 70 01 00 00       	call   8001a6 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 74 20 00 00    	sub    $0x2074,%esp
	int IDs[20];

	// Create & run the slave environments
	IDs[0] = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  800042:	a1 20 30 80 00       	mov    0x803020,%eax
  800047:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  80004d:	a1 20 30 80 00       	mov    0x803020,%eax
  800052:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800058:	89 c1                	mov    %eax,%ecx
  80005a:	a1 20 30 80 00       	mov    0x803020,%eax
  80005f:	8b 40 74             	mov    0x74(%eax),%eax
  800062:	52                   	push   %edx
  800063:	51                   	push   %ecx
  800064:	50                   	push   %eax
  800065:	68 a0 1c 80 00       	push   $0x801ca0
  80006a:	e8 69 16 00 00       	call   8016d8 <sys_create_env>
  80006f:	83 c4 10             	add    $0x10,%esp
  800072:	89 45 94             	mov    %eax,-0x6c(%ebp)
	sys_run_env(IDs[0]);
  800075:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800078:	83 ec 0c             	sub    $0xc,%esp
  80007b:	50                   	push   %eax
  80007c:	e8 75 16 00 00       	call   8016f6 <sys_run_env>
  800081:	83 c4 10             	add    $0x10,%esp
	for(int i = 1; i < 10; ++i)
  800084:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  80008b:	eb 4f                	jmp    8000dc <_main+0xa4>
	{
		IDs[i] = sys_create_env("dummy_process", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  80008d:	a1 20 30 80 00       	mov    0x803020,%eax
  800092:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  800098:	a1 20 30 80 00       	mov    0x803020,%eax
  80009d:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000a3:	89 c1                	mov    %eax,%ecx
  8000a5:	a1 20 30 80 00       	mov    0x803020,%eax
  8000aa:	8b 40 74             	mov    0x74(%eax),%eax
  8000ad:	52                   	push   %edx
  8000ae:	51                   	push   %ecx
  8000af:	50                   	push   %eax
  8000b0:	68 af 1c 80 00       	push   $0x801caf
  8000b5:	e8 1e 16 00 00       	call   8016d8 <sys_create_env>
  8000ba:	83 c4 10             	add    $0x10,%esp
  8000bd:	89 c2                	mov    %eax,%edx
  8000bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000c2:	89 54 85 94          	mov    %edx,-0x6c(%ebp,%eax,4)
		sys_run_env(IDs[i]);
  8000c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000c9:	8b 44 85 94          	mov    -0x6c(%ebp,%eax,4),%eax
  8000cd:	83 ec 0c             	sub    $0xc,%esp
  8000d0:	50                   	push   %eax
  8000d1:	e8 20 16 00 00       	call   8016f6 <sys_run_env>
  8000d6:	83 c4 10             	add    $0x10,%esp
	int IDs[20];

	// Create & run the slave environments
	IDs[0] = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
	sys_run_env(IDs[0]);
	for(int i = 1; i < 10; ++i)
  8000d9:	ff 45 f4             	incl   -0xc(%ebp)
  8000dc:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
  8000e0:	7e ab                	jle    80008d <_main+0x55>
		IDs[i] = sys_create_env("dummy_process", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
		sys_run_env(IDs[i]);
	}

	// To check that the slave environments completed successfully
	rsttst();
  8000e2:	e8 d9 16 00 00       	call   8017c0 <rsttst>

	env_sleep(3000);
  8000e7:	83 ec 0c             	sub    $0xc,%esp
  8000ea:	68 b8 0b 00 00       	push   $0xbb8
  8000ef:	e8 80 18 00 00       	call   801974 <env_sleep>
  8000f4:	83 c4 10             	add    $0x10,%esp
	sys_scarce_memory();
  8000f7:	e8 3d 14 00 00       	call   801539 <sys_scarce_memory>
	uint32 freePagesBefore = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  8000fc:	e8 82 13 00 00       	call   801483 <sys_calculate_free_frames>
  800101:	89 c3                	mov    %eax,%ebx
  800103:	e8 94 13 00 00       	call   80149c <sys_calculate_modified_frames>
  800108:	01 d8                	add    %ebx,%eax
  80010a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 usedDiskPagesBefore = sys_pf_calculate_allocated_pages();
  80010d:	e8 f4 13 00 00       	call   801506 <sys_pf_calculate_allocated_pages>
  800112:	89 45 ec             	mov    %eax,-0x14(%ebp)

	// Check the number of pages shall be deleted with the first fault after scarce the memory
	int pagesToBeDeletedCount = sys_calculate_pages_tobe_removed_ready_exit(1);
  800115:	83 ec 0c             	sub    $0xc,%esp
  800118:	6a 01                	push   $0x1
  80011a:	e8 00 14 00 00       	call   80151f <sys_calculate_pages_tobe_removed_ready_exit>
  80011f:	83 c4 10             	add    $0x10,%esp
  800122:	89 45 e8             	mov    %eax,-0x18(%ebp)

	char arr[PAGE_SIZE*2];
	// Access the created array in STACK to FAULT and Free SCARCE MEM
	arr[1*PAGE_SIZE] = -1;
  800125:	c6 85 94 ef ff ff ff 	movb   $0xff,-0x106c(%ebp)

	//cprintf("Checking Allocation in Mem & Page File... \n");
	//AFTER freeing MEMORY
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPagesBefore) !=  1) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  80012c:	e8 d5 13 00 00       	call   801506 <sys_pf_calculate_allocated_pages>
  800131:	2b 45 ec             	sub    -0x14(%ebp),%eax
  800134:	83 f8 01             	cmp    $0x1,%eax
  800137:	74 14                	je     80014d <_main+0x115>
  800139:	83 ec 04             	sub    $0x4,%esp
  80013c:	68 c0 1c 80 00       	push   $0x801cc0
  800141:	6a 22                	push   $0x22
  800143:	68 2c 1d 80 00       	push   $0x801d2c
  800148:	e8 9e 01 00 00       	call   8002eb <_panic>
		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  80014d:	e8 31 13 00 00       	call   801483 <sys_calculate_free_frames>
  800152:	89 c3                	mov    %eax,%ebx
  800154:	e8 43 13 00 00       	call   80149c <sys_calculate_modified_frames>
  800159:	01 d8                	add    %ebx,%eax
  80015b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		if( (freePagesBefore + pagesToBeDeletedCount - 1) != freePagesAfter )
  80015e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800161:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800164:	01 d0                	add    %edx,%eax
  800166:	48                   	dec    %eax
  800167:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80016a:	74 14                	je     800180 <_main+0x148>
			panic("Extra memory are wrongly allocated ... It's REplacement: extra/less frames have been FREED after the memory being scarce");
  80016c:	83 ec 04             	sub    $0x4,%esp
  80016f:	68 64 1d 80 00       	push   $0x801d64
  800174:	6a 25                	push   $0x25
  800176:	68 2c 1d 80 00       	push   $0x801d2c
  80017b:	e8 6b 01 00 00       	call   8002eb <_panic>
	}

	env_sleep(80000);
  800180:	83 ec 0c             	sub    $0xc,%esp
  800183:	68 80 38 01 00       	push   $0x13880
  800188:	e8 e7 17 00 00       	call   801974 <env_sleep>
  80018d:	83 c4 10             	add    $0x10,%esp
	// To ensure that the slave environments completed successfully
	cprintf("Congratulations!! test PAGE replacement [FREEING SCARCE MEMORY 2] is completed successfully.\n");
  800190:	83 ec 0c             	sub    $0xc,%esp
  800193:	68 e0 1d 80 00       	push   $0x801de0
  800198:	e8 f0 03 00 00       	call   80058d <cprintf>
  80019d:	83 c4 10             	add    $0x10,%esp
}
  8001a0:	90                   	nop
  8001a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8001a4:	c9                   	leave  
  8001a5:	c3                   	ret    

008001a6 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8001a6:	55                   	push   %ebp
  8001a7:	89 e5                	mov    %esp,%ebp
  8001a9:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001ac:	e8 07 12 00 00       	call   8013b8 <sys_getenvindex>
  8001b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001b7:	89 d0                	mov    %edx,%eax
  8001b9:	c1 e0 03             	shl    $0x3,%eax
  8001bc:	01 d0                	add    %edx,%eax
  8001be:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8001c5:	01 c8                	add    %ecx,%eax
  8001c7:	01 c0                	add    %eax,%eax
  8001c9:	01 d0                	add    %edx,%eax
  8001cb:	01 c0                	add    %eax,%eax
  8001cd:	01 d0                	add    %edx,%eax
  8001cf:	89 c2                	mov    %eax,%edx
  8001d1:	c1 e2 05             	shl    $0x5,%edx
  8001d4:	29 c2                	sub    %eax,%edx
  8001d6:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8001dd:	89 c2                	mov    %eax,%edx
  8001df:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8001e5:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ef:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8001f5:	84 c0                	test   %al,%al
  8001f7:	74 0f                	je     800208 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8001f9:	a1 20 30 80 00       	mov    0x803020,%eax
  8001fe:	05 40 3c 01 00       	add    $0x13c40,%eax
  800203:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800208:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80020c:	7e 0a                	jle    800218 <libmain+0x72>
		binaryname = argv[0];
  80020e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800211:	8b 00                	mov    (%eax),%eax
  800213:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800218:	83 ec 08             	sub    $0x8,%esp
  80021b:	ff 75 0c             	pushl  0xc(%ebp)
  80021e:	ff 75 08             	pushl  0x8(%ebp)
  800221:	e8 12 fe ff ff       	call   800038 <_main>
  800226:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800229:	e8 25 13 00 00       	call   801553 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80022e:	83 ec 0c             	sub    $0xc,%esp
  800231:	68 58 1e 80 00       	push   $0x801e58
  800236:	e8 52 03 00 00       	call   80058d <cprintf>
  80023b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80023e:	a1 20 30 80 00       	mov    0x803020,%eax
  800243:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800249:	a1 20 30 80 00       	mov    0x803020,%eax
  80024e:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800254:	83 ec 04             	sub    $0x4,%esp
  800257:	52                   	push   %edx
  800258:	50                   	push   %eax
  800259:	68 80 1e 80 00       	push   $0x801e80
  80025e:	e8 2a 03 00 00       	call   80058d <cprintf>
  800263:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800266:	a1 20 30 80 00       	mov    0x803020,%eax
  80026b:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800271:	a1 20 30 80 00       	mov    0x803020,%eax
  800276:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80027c:	83 ec 04             	sub    $0x4,%esp
  80027f:	52                   	push   %edx
  800280:	50                   	push   %eax
  800281:	68 a8 1e 80 00       	push   $0x801ea8
  800286:	e8 02 03 00 00       	call   80058d <cprintf>
  80028b:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80028e:	a1 20 30 80 00       	mov    0x803020,%eax
  800293:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800299:	83 ec 08             	sub    $0x8,%esp
  80029c:	50                   	push   %eax
  80029d:	68 e9 1e 80 00       	push   $0x801ee9
  8002a2:	e8 e6 02 00 00       	call   80058d <cprintf>
  8002a7:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8002aa:	83 ec 0c             	sub    $0xc,%esp
  8002ad:	68 58 1e 80 00       	push   $0x801e58
  8002b2:	e8 d6 02 00 00       	call   80058d <cprintf>
  8002b7:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002ba:	e8 ae 12 00 00       	call   80156d <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002bf:	e8 19 00 00 00       	call   8002dd <exit>
}
  8002c4:	90                   	nop
  8002c5:	c9                   	leave  
  8002c6:	c3                   	ret    

008002c7 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002c7:	55                   	push   %ebp
  8002c8:	89 e5                	mov    %esp,%ebp
  8002ca:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002cd:	83 ec 0c             	sub    $0xc,%esp
  8002d0:	6a 00                	push   $0x0
  8002d2:	e8 ad 10 00 00       	call   801384 <sys_env_destroy>
  8002d7:	83 c4 10             	add    $0x10,%esp
}
  8002da:	90                   	nop
  8002db:	c9                   	leave  
  8002dc:	c3                   	ret    

008002dd <exit>:

void
exit(void)
{
  8002dd:	55                   	push   %ebp
  8002de:	89 e5                	mov    %esp,%ebp
  8002e0:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002e3:	e8 02 11 00 00       	call   8013ea <sys_env_exit>
}
  8002e8:	90                   	nop
  8002e9:	c9                   	leave  
  8002ea:	c3                   	ret    

008002eb <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8002eb:	55                   	push   %ebp
  8002ec:	89 e5                	mov    %esp,%ebp
  8002ee:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8002f1:	8d 45 10             	lea    0x10(%ebp),%eax
  8002f4:	83 c0 04             	add    $0x4,%eax
  8002f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8002fa:	a1 18 31 80 00       	mov    0x803118,%eax
  8002ff:	85 c0                	test   %eax,%eax
  800301:	74 16                	je     800319 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800303:	a1 18 31 80 00       	mov    0x803118,%eax
  800308:	83 ec 08             	sub    $0x8,%esp
  80030b:	50                   	push   %eax
  80030c:	68 00 1f 80 00       	push   $0x801f00
  800311:	e8 77 02 00 00       	call   80058d <cprintf>
  800316:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800319:	a1 00 30 80 00       	mov    0x803000,%eax
  80031e:	ff 75 0c             	pushl  0xc(%ebp)
  800321:	ff 75 08             	pushl  0x8(%ebp)
  800324:	50                   	push   %eax
  800325:	68 05 1f 80 00       	push   $0x801f05
  80032a:	e8 5e 02 00 00       	call   80058d <cprintf>
  80032f:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800332:	8b 45 10             	mov    0x10(%ebp),%eax
  800335:	83 ec 08             	sub    $0x8,%esp
  800338:	ff 75 f4             	pushl  -0xc(%ebp)
  80033b:	50                   	push   %eax
  80033c:	e8 e1 01 00 00       	call   800522 <vcprintf>
  800341:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800344:	83 ec 08             	sub    $0x8,%esp
  800347:	6a 00                	push   $0x0
  800349:	68 21 1f 80 00       	push   $0x801f21
  80034e:	e8 cf 01 00 00       	call   800522 <vcprintf>
  800353:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800356:	e8 82 ff ff ff       	call   8002dd <exit>

	// should not return here
	while (1) ;
  80035b:	eb fe                	jmp    80035b <_panic+0x70>

0080035d <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80035d:	55                   	push   %ebp
  80035e:	89 e5                	mov    %esp,%ebp
  800360:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800363:	a1 20 30 80 00       	mov    0x803020,%eax
  800368:	8b 50 74             	mov    0x74(%eax),%edx
  80036b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80036e:	39 c2                	cmp    %eax,%edx
  800370:	74 14                	je     800386 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800372:	83 ec 04             	sub    $0x4,%esp
  800375:	68 24 1f 80 00       	push   $0x801f24
  80037a:	6a 26                	push   $0x26
  80037c:	68 70 1f 80 00       	push   $0x801f70
  800381:	e8 65 ff ff ff       	call   8002eb <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800386:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80038d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800394:	e9 b6 00 00 00       	jmp    80044f <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800399:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80039c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a6:	01 d0                	add    %edx,%eax
  8003a8:	8b 00                	mov    (%eax),%eax
  8003aa:	85 c0                	test   %eax,%eax
  8003ac:	75 08                	jne    8003b6 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8003ae:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8003b1:	e9 96 00 00 00       	jmp    80044c <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8003b6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003bd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8003c4:	eb 5d                	jmp    800423 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8003c6:	a1 20 30 80 00       	mov    0x803020,%eax
  8003cb:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003d1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003d4:	c1 e2 04             	shl    $0x4,%edx
  8003d7:	01 d0                	add    %edx,%eax
  8003d9:	8a 40 04             	mov    0x4(%eax),%al
  8003dc:	84 c0                	test   %al,%al
  8003de:	75 40                	jne    800420 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e5:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003eb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003ee:	c1 e2 04             	shl    $0x4,%edx
  8003f1:	01 d0                	add    %edx,%eax
  8003f3:	8b 00                	mov    (%eax),%eax
  8003f5:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8003f8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8003fb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800400:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800402:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800405:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80040c:	8b 45 08             	mov    0x8(%ebp),%eax
  80040f:	01 c8                	add    %ecx,%eax
  800411:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800413:	39 c2                	cmp    %eax,%edx
  800415:	75 09                	jne    800420 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800417:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80041e:	eb 12                	jmp    800432 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800420:	ff 45 e8             	incl   -0x18(%ebp)
  800423:	a1 20 30 80 00       	mov    0x803020,%eax
  800428:	8b 50 74             	mov    0x74(%eax),%edx
  80042b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80042e:	39 c2                	cmp    %eax,%edx
  800430:	77 94                	ja     8003c6 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800432:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800436:	75 14                	jne    80044c <CheckWSWithoutLastIndex+0xef>
			panic(
  800438:	83 ec 04             	sub    $0x4,%esp
  80043b:	68 7c 1f 80 00       	push   $0x801f7c
  800440:	6a 3a                	push   $0x3a
  800442:	68 70 1f 80 00       	push   $0x801f70
  800447:	e8 9f fe ff ff       	call   8002eb <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80044c:	ff 45 f0             	incl   -0x10(%ebp)
  80044f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800452:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800455:	0f 8c 3e ff ff ff    	jl     800399 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80045b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800462:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800469:	eb 20                	jmp    80048b <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80046b:	a1 20 30 80 00       	mov    0x803020,%eax
  800470:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800476:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800479:	c1 e2 04             	shl    $0x4,%edx
  80047c:	01 d0                	add    %edx,%eax
  80047e:	8a 40 04             	mov    0x4(%eax),%al
  800481:	3c 01                	cmp    $0x1,%al
  800483:	75 03                	jne    800488 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800485:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800488:	ff 45 e0             	incl   -0x20(%ebp)
  80048b:	a1 20 30 80 00       	mov    0x803020,%eax
  800490:	8b 50 74             	mov    0x74(%eax),%edx
  800493:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800496:	39 c2                	cmp    %eax,%edx
  800498:	77 d1                	ja     80046b <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80049a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80049d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004a0:	74 14                	je     8004b6 <CheckWSWithoutLastIndex+0x159>
		panic(
  8004a2:	83 ec 04             	sub    $0x4,%esp
  8004a5:	68 d0 1f 80 00       	push   $0x801fd0
  8004aa:	6a 44                	push   $0x44
  8004ac:	68 70 1f 80 00       	push   $0x801f70
  8004b1:	e8 35 fe ff ff       	call   8002eb <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8004b6:	90                   	nop
  8004b7:	c9                   	leave  
  8004b8:	c3                   	ret    

008004b9 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8004b9:	55                   	push   %ebp
  8004ba:	89 e5                	mov    %esp,%ebp
  8004bc:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8004bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004c2:	8b 00                	mov    (%eax),%eax
  8004c4:	8d 48 01             	lea    0x1(%eax),%ecx
  8004c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004ca:	89 0a                	mov    %ecx,(%edx)
  8004cc:	8b 55 08             	mov    0x8(%ebp),%edx
  8004cf:	88 d1                	mov    %dl,%cl
  8004d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004d4:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004db:	8b 00                	mov    (%eax),%eax
  8004dd:	3d ff 00 00 00       	cmp    $0xff,%eax
  8004e2:	75 2c                	jne    800510 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8004e4:	a0 24 30 80 00       	mov    0x803024,%al
  8004e9:	0f b6 c0             	movzbl %al,%eax
  8004ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004ef:	8b 12                	mov    (%edx),%edx
  8004f1:	89 d1                	mov    %edx,%ecx
  8004f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004f6:	83 c2 08             	add    $0x8,%edx
  8004f9:	83 ec 04             	sub    $0x4,%esp
  8004fc:	50                   	push   %eax
  8004fd:	51                   	push   %ecx
  8004fe:	52                   	push   %edx
  8004ff:	e8 3e 0e 00 00       	call   801342 <sys_cputs>
  800504:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800507:	8b 45 0c             	mov    0xc(%ebp),%eax
  80050a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800510:	8b 45 0c             	mov    0xc(%ebp),%eax
  800513:	8b 40 04             	mov    0x4(%eax),%eax
  800516:	8d 50 01             	lea    0x1(%eax),%edx
  800519:	8b 45 0c             	mov    0xc(%ebp),%eax
  80051c:	89 50 04             	mov    %edx,0x4(%eax)
}
  80051f:	90                   	nop
  800520:	c9                   	leave  
  800521:	c3                   	ret    

00800522 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800522:	55                   	push   %ebp
  800523:	89 e5                	mov    %esp,%ebp
  800525:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80052b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800532:	00 00 00 
	b.cnt = 0;
  800535:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80053c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80053f:	ff 75 0c             	pushl  0xc(%ebp)
  800542:	ff 75 08             	pushl  0x8(%ebp)
  800545:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80054b:	50                   	push   %eax
  80054c:	68 b9 04 80 00       	push   $0x8004b9
  800551:	e8 11 02 00 00       	call   800767 <vprintfmt>
  800556:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800559:	a0 24 30 80 00       	mov    0x803024,%al
  80055e:	0f b6 c0             	movzbl %al,%eax
  800561:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800567:	83 ec 04             	sub    $0x4,%esp
  80056a:	50                   	push   %eax
  80056b:	52                   	push   %edx
  80056c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800572:	83 c0 08             	add    $0x8,%eax
  800575:	50                   	push   %eax
  800576:	e8 c7 0d 00 00       	call   801342 <sys_cputs>
  80057b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80057e:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800585:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80058b:	c9                   	leave  
  80058c:	c3                   	ret    

0080058d <cprintf>:

int cprintf(const char *fmt, ...) {
  80058d:	55                   	push   %ebp
  80058e:	89 e5                	mov    %esp,%ebp
  800590:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800593:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80059a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80059d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a3:	83 ec 08             	sub    $0x8,%esp
  8005a6:	ff 75 f4             	pushl  -0xc(%ebp)
  8005a9:	50                   	push   %eax
  8005aa:	e8 73 ff ff ff       	call   800522 <vcprintf>
  8005af:	83 c4 10             	add    $0x10,%esp
  8005b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005b8:	c9                   	leave  
  8005b9:	c3                   	ret    

008005ba <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8005ba:	55                   	push   %ebp
  8005bb:	89 e5                	mov    %esp,%ebp
  8005bd:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005c0:	e8 8e 0f 00 00       	call   801553 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8005c5:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ce:	83 ec 08             	sub    $0x8,%esp
  8005d1:	ff 75 f4             	pushl  -0xc(%ebp)
  8005d4:	50                   	push   %eax
  8005d5:	e8 48 ff ff ff       	call   800522 <vcprintf>
  8005da:	83 c4 10             	add    $0x10,%esp
  8005dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8005e0:	e8 88 0f 00 00       	call   80156d <sys_enable_interrupt>
	return cnt;
  8005e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005e8:	c9                   	leave  
  8005e9:	c3                   	ret    

008005ea <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8005ea:	55                   	push   %ebp
  8005eb:	89 e5                	mov    %esp,%ebp
  8005ed:	53                   	push   %ebx
  8005ee:	83 ec 14             	sub    $0x14,%esp
  8005f1:	8b 45 10             	mov    0x10(%ebp),%eax
  8005f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8005f7:	8b 45 14             	mov    0x14(%ebp),%eax
  8005fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8005fd:	8b 45 18             	mov    0x18(%ebp),%eax
  800600:	ba 00 00 00 00       	mov    $0x0,%edx
  800605:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800608:	77 55                	ja     80065f <printnum+0x75>
  80060a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80060d:	72 05                	jb     800614 <printnum+0x2a>
  80060f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800612:	77 4b                	ja     80065f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800614:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800617:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80061a:	8b 45 18             	mov    0x18(%ebp),%eax
  80061d:	ba 00 00 00 00       	mov    $0x0,%edx
  800622:	52                   	push   %edx
  800623:	50                   	push   %eax
  800624:	ff 75 f4             	pushl  -0xc(%ebp)
  800627:	ff 75 f0             	pushl  -0x10(%ebp)
  80062a:	e8 f9 13 00 00       	call   801a28 <__udivdi3>
  80062f:	83 c4 10             	add    $0x10,%esp
  800632:	83 ec 04             	sub    $0x4,%esp
  800635:	ff 75 20             	pushl  0x20(%ebp)
  800638:	53                   	push   %ebx
  800639:	ff 75 18             	pushl  0x18(%ebp)
  80063c:	52                   	push   %edx
  80063d:	50                   	push   %eax
  80063e:	ff 75 0c             	pushl  0xc(%ebp)
  800641:	ff 75 08             	pushl  0x8(%ebp)
  800644:	e8 a1 ff ff ff       	call   8005ea <printnum>
  800649:	83 c4 20             	add    $0x20,%esp
  80064c:	eb 1a                	jmp    800668 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80064e:	83 ec 08             	sub    $0x8,%esp
  800651:	ff 75 0c             	pushl  0xc(%ebp)
  800654:	ff 75 20             	pushl  0x20(%ebp)
  800657:	8b 45 08             	mov    0x8(%ebp),%eax
  80065a:	ff d0                	call   *%eax
  80065c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80065f:	ff 4d 1c             	decl   0x1c(%ebp)
  800662:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800666:	7f e6                	jg     80064e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800668:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80066b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800670:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800673:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800676:	53                   	push   %ebx
  800677:	51                   	push   %ecx
  800678:	52                   	push   %edx
  800679:	50                   	push   %eax
  80067a:	e8 b9 14 00 00       	call   801b38 <__umoddi3>
  80067f:	83 c4 10             	add    $0x10,%esp
  800682:	05 34 22 80 00       	add    $0x802234,%eax
  800687:	8a 00                	mov    (%eax),%al
  800689:	0f be c0             	movsbl %al,%eax
  80068c:	83 ec 08             	sub    $0x8,%esp
  80068f:	ff 75 0c             	pushl  0xc(%ebp)
  800692:	50                   	push   %eax
  800693:	8b 45 08             	mov    0x8(%ebp),%eax
  800696:	ff d0                	call   *%eax
  800698:	83 c4 10             	add    $0x10,%esp
}
  80069b:	90                   	nop
  80069c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80069f:	c9                   	leave  
  8006a0:	c3                   	ret    

008006a1 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006a1:	55                   	push   %ebp
  8006a2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006a4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006a8:	7e 1c                	jle    8006c6 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8006aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ad:	8b 00                	mov    (%eax),%eax
  8006af:	8d 50 08             	lea    0x8(%eax),%edx
  8006b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b5:	89 10                	mov    %edx,(%eax)
  8006b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ba:	8b 00                	mov    (%eax),%eax
  8006bc:	83 e8 08             	sub    $0x8,%eax
  8006bf:	8b 50 04             	mov    0x4(%eax),%edx
  8006c2:	8b 00                	mov    (%eax),%eax
  8006c4:	eb 40                	jmp    800706 <getuint+0x65>
	else if (lflag)
  8006c6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006ca:	74 1e                	je     8006ea <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8006cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cf:	8b 00                	mov    (%eax),%eax
  8006d1:	8d 50 04             	lea    0x4(%eax),%edx
  8006d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d7:	89 10                	mov    %edx,(%eax)
  8006d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006dc:	8b 00                	mov    (%eax),%eax
  8006de:	83 e8 04             	sub    $0x4,%eax
  8006e1:	8b 00                	mov    (%eax),%eax
  8006e3:	ba 00 00 00 00       	mov    $0x0,%edx
  8006e8:	eb 1c                	jmp    800706 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
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
}
  800706:	5d                   	pop    %ebp
  800707:	c3                   	ret    

00800708 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800708:	55                   	push   %ebp
  800709:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80070b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80070f:	7e 1c                	jle    80072d <getint+0x25>
		return va_arg(*ap, long long);
  800711:	8b 45 08             	mov    0x8(%ebp),%eax
  800714:	8b 00                	mov    (%eax),%eax
  800716:	8d 50 08             	lea    0x8(%eax),%edx
  800719:	8b 45 08             	mov    0x8(%ebp),%eax
  80071c:	89 10                	mov    %edx,(%eax)
  80071e:	8b 45 08             	mov    0x8(%ebp),%eax
  800721:	8b 00                	mov    (%eax),%eax
  800723:	83 e8 08             	sub    $0x8,%eax
  800726:	8b 50 04             	mov    0x4(%eax),%edx
  800729:	8b 00                	mov    (%eax),%eax
  80072b:	eb 38                	jmp    800765 <getint+0x5d>
	else if (lflag)
  80072d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800731:	74 1a                	je     80074d <getint+0x45>
		return va_arg(*ap, long);
  800733:	8b 45 08             	mov    0x8(%ebp),%eax
  800736:	8b 00                	mov    (%eax),%eax
  800738:	8d 50 04             	lea    0x4(%eax),%edx
  80073b:	8b 45 08             	mov    0x8(%ebp),%eax
  80073e:	89 10                	mov    %edx,(%eax)
  800740:	8b 45 08             	mov    0x8(%ebp),%eax
  800743:	8b 00                	mov    (%eax),%eax
  800745:	83 e8 04             	sub    $0x4,%eax
  800748:	8b 00                	mov    (%eax),%eax
  80074a:	99                   	cltd   
  80074b:	eb 18                	jmp    800765 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80074d:	8b 45 08             	mov    0x8(%ebp),%eax
  800750:	8b 00                	mov    (%eax),%eax
  800752:	8d 50 04             	lea    0x4(%eax),%edx
  800755:	8b 45 08             	mov    0x8(%ebp),%eax
  800758:	89 10                	mov    %edx,(%eax)
  80075a:	8b 45 08             	mov    0x8(%ebp),%eax
  80075d:	8b 00                	mov    (%eax),%eax
  80075f:	83 e8 04             	sub    $0x4,%eax
  800762:	8b 00                	mov    (%eax),%eax
  800764:	99                   	cltd   
}
  800765:	5d                   	pop    %ebp
  800766:	c3                   	ret    

00800767 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800767:	55                   	push   %ebp
  800768:	89 e5                	mov    %esp,%ebp
  80076a:	56                   	push   %esi
  80076b:	53                   	push   %ebx
  80076c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80076f:	eb 17                	jmp    800788 <vprintfmt+0x21>
			if (ch == '\0')
  800771:	85 db                	test   %ebx,%ebx
  800773:	0f 84 af 03 00 00    	je     800b28 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800779:	83 ec 08             	sub    $0x8,%esp
  80077c:	ff 75 0c             	pushl  0xc(%ebp)
  80077f:	53                   	push   %ebx
  800780:	8b 45 08             	mov    0x8(%ebp),%eax
  800783:	ff d0                	call   *%eax
  800785:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800788:	8b 45 10             	mov    0x10(%ebp),%eax
  80078b:	8d 50 01             	lea    0x1(%eax),%edx
  80078e:	89 55 10             	mov    %edx,0x10(%ebp)
  800791:	8a 00                	mov    (%eax),%al
  800793:	0f b6 d8             	movzbl %al,%ebx
  800796:	83 fb 25             	cmp    $0x25,%ebx
  800799:	75 d6                	jne    800771 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80079b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80079f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8007a6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8007ad:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8007b4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8007bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8007be:	8d 50 01             	lea    0x1(%eax),%edx
  8007c1:	89 55 10             	mov    %edx,0x10(%ebp)
  8007c4:	8a 00                	mov    (%eax),%al
  8007c6:	0f b6 d8             	movzbl %al,%ebx
  8007c9:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8007cc:	83 f8 55             	cmp    $0x55,%eax
  8007cf:	0f 87 2b 03 00 00    	ja     800b00 <vprintfmt+0x399>
  8007d5:	8b 04 85 58 22 80 00 	mov    0x802258(,%eax,4),%eax
  8007dc:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8007de:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8007e2:	eb d7                	jmp    8007bb <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8007e4:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8007e8:	eb d1                	jmp    8007bb <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007ea:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8007f1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8007f4:	89 d0                	mov    %edx,%eax
  8007f6:	c1 e0 02             	shl    $0x2,%eax
  8007f9:	01 d0                	add    %edx,%eax
  8007fb:	01 c0                	add    %eax,%eax
  8007fd:	01 d8                	add    %ebx,%eax
  8007ff:	83 e8 30             	sub    $0x30,%eax
  800802:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800805:	8b 45 10             	mov    0x10(%ebp),%eax
  800808:	8a 00                	mov    (%eax),%al
  80080a:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80080d:	83 fb 2f             	cmp    $0x2f,%ebx
  800810:	7e 3e                	jle    800850 <vprintfmt+0xe9>
  800812:	83 fb 39             	cmp    $0x39,%ebx
  800815:	7f 39                	jg     800850 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800817:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80081a:	eb d5                	jmp    8007f1 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80081c:	8b 45 14             	mov    0x14(%ebp),%eax
  80081f:	83 c0 04             	add    $0x4,%eax
  800822:	89 45 14             	mov    %eax,0x14(%ebp)
  800825:	8b 45 14             	mov    0x14(%ebp),%eax
  800828:	83 e8 04             	sub    $0x4,%eax
  80082b:	8b 00                	mov    (%eax),%eax
  80082d:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800830:	eb 1f                	jmp    800851 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800832:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800836:	79 83                	jns    8007bb <vprintfmt+0x54>
				width = 0;
  800838:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80083f:	e9 77 ff ff ff       	jmp    8007bb <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800844:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80084b:	e9 6b ff ff ff       	jmp    8007bb <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800850:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800851:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800855:	0f 89 60 ff ff ff    	jns    8007bb <vprintfmt+0x54>
				width = precision, precision = -1;
  80085b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80085e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800861:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800868:	e9 4e ff ff ff       	jmp    8007bb <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80086d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800870:	e9 46 ff ff ff       	jmp    8007bb <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800875:	8b 45 14             	mov    0x14(%ebp),%eax
  800878:	83 c0 04             	add    $0x4,%eax
  80087b:	89 45 14             	mov    %eax,0x14(%ebp)
  80087e:	8b 45 14             	mov    0x14(%ebp),%eax
  800881:	83 e8 04             	sub    $0x4,%eax
  800884:	8b 00                	mov    (%eax),%eax
  800886:	83 ec 08             	sub    $0x8,%esp
  800889:	ff 75 0c             	pushl  0xc(%ebp)
  80088c:	50                   	push   %eax
  80088d:	8b 45 08             	mov    0x8(%ebp),%eax
  800890:	ff d0                	call   *%eax
  800892:	83 c4 10             	add    $0x10,%esp
			break;
  800895:	e9 89 02 00 00       	jmp    800b23 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80089a:	8b 45 14             	mov    0x14(%ebp),%eax
  80089d:	83 c0 04             	add    $0x4,%eax
  8008a0:	89 45 14             	mov    %eax,0x14(%ebp)
  8008a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8008a6:	83 e8 04             	sub    $0x4,%eax
  8008a9:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8008ab:	85 db                	test   %ebx,%ebx
  8008ad:	79 02                	jns    8008b1 <vprintfmt+0x14a>
				err = -err;
  8008af:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8008b1:	83 fb 64             	cmp    $0x64,%ebx
  8008b4:	7f 0b                	jg     8008c1 <vprintfmt+0x15a>
  8008b6:	8b 34 9d a0 20 80 00 	mov    0x8020a0(,%ebx,4),%esi
  8008bd:	85 f6                	test   %esi,%esi
  8008bf:	75 19                	jne    8008da <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8008c1:	53                   	push   %ebx
  8008c2:	68 45 22 80 00       	push   $0x802245
  8008c7:	ff 75 0c             	pushl  0xc(%ebp)
  8008ca:	ff 75 08             	pushl  0x8(%ebp)
  8008cd:	e8 5e 02 00 00       	call   800b30 <printfmt>
  8008d2:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8008d5:	e9 49 02 00 00       	jmp    800b23 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8008da:	56                   	push   %esi
  8008db:	68 4e 22 80 00       	push   $0x80224e
  8008e0:	ff 75 0c             	pushl  0xc(%ebp)
  8008e3:	ff 75 08             	pushl  0x8(%ebp)
  8008e6:	e8 45 02 00 00       	call   800b30 <printfmt>
  8008eb:	83 c4 10             	add    $0x10,%esp
			break;
  8008ee:	e9 30 02 00 00       	jmp    800b23 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8008f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8008f6:	83 c0 04             	add    $0x4,%eax
  8008f9:	89 45 14             	mov    %eax,0x14(%ebp)
  8008fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ff:	83 e8 04             	sub    $0x4,%eax
  800902:	8b 30                	mov    (%eax),%esi
  800904:	85 f6                	test   %esi,%esi
  800906:	75 05                	jne    80090d <vprintfmt+0x1a6>
				p = "(null)";
  800908:	be 51 22 80 00       	mov    $0x802251,%esi
			if (width > 0 && padc != '-')
  80090d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800911:	7e 6d                	jle    800980 <vprintfmt+0x219>
  800913:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800917:	74 67                	je     800980 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800919:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80091c:	83 ec 08             	sub    $0x8,%esp
  80091f:	50                   	push   %eax
  800920:	56                   	push   %esi
  800921:	e8 0c 03 00 00       	call   800c32 <strnlen>
  800926:	83 c4 10             	add    $0x10,%esp
  800929:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80092c:	eb 16                	jmp    800944 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80092e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800932:	83 ec 08             	sub    $0x8,%esp
  800935:	ff 75 0c             	pushl  0xc(%ebp)
  800938:	50                   	push   %eax
  800939:	8b 45 08             	mov    0x8(%ebp),%eax
  80093c:	ff d0                	call   *%eax
  80093e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800941:	ff 4d e4             	decl   -0x1c(%ebp)
  800944:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800948:	7f e4                	jg     80092e <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80094a:	eb 34                	jmp    800980 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80094c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800950:	74 1c                	je     80096e <vprintfmt+0x207>
  800952:	83 fb 1f             	cmp    $0x1f,%ebx
  800955:	7e 05                	jle    80095c <vprintfmt+0x1f5>
  800957:	83 fb 7e             	cmp    $0x7e,%ebx
  80095a:	7e 12                	jle    80096e <vprintfmt+0x207>
					putch('?', putdat);
  80095c:	83 ec 08             	sub    $0x8,%esp
  80095f:	ff 75 0c             	pushl  0xc(%ebp)
  800962:	6a 3f                	push   $0x3f
  800964:	8b 45 08             	mov    0x8(%ebp),%eax
  800967:	ff d0                	call   *%eax
  800969:	83 c4 10             	add    $0x10,%esp
  80096c:	eb 0f                	jmp    80097d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80096e:	83 ec 08             	sub    $0x8,%esp
  800971:	ff 75 0c             	pushl  0xc(%ebp)
  800974:	53                   	push   %ebx
  800975:	8b 45 08             	mov    0x8(%ebp),%eax
  800978:	ff d0                	call   *%eax
  80097a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80097d:	ff 4d e4             	decl   -0x1c(%ebp)
  800980:	89 f0                	mov    %esi,%eax
  800982:	8d 70 01             	lea    0x1(%eax),%esi
  800985:	8a 00                	mov    (%eax),%al
  800987:	0f be d8             	movsbl %al,%ebx
  80098a:	85 db                	test   %ebx,%ebx
  80098c:	74 24                	je     8009b2 <vprintfmt+0x24b>
  80098e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800992:	78 b8                	js     80094c <vprintfmt+0x1e5>
  800994:	ff 4d e0             	decl   -0x20(%ebp)
  800997:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80099b:	79 af                	jns    80094c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80099d:	eb 13                	jmp    8009b2 <vprintfmt+0x24b>
				putch(' ', putdat);
  80099f:	83 ec 08             	sub    $0x8,%esp
  8009a2:	ff 75 0c             	pushl  0xc(%ebp)
  8009a5:	6a 20                	push   $0x20
  8009a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009aa:	ff d0                	call   *%eax
  8009ac:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009af:	ff 4d e4             	decl   -0x1c(%ebp)
  8009b2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009b6:	7f e7                	jg     80099f <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8009b8:	e9 66 01 00 00       	jmp    800b23 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8009bd:	83 ec 08             	sub    $0x8,%esp
  8009c0:	ff 75 e8             	pushl  -0x18(%ebp)
  8009c3:	8d 45 14             	lea    0x14(%ebp),%eax
  8009c6:	50                   	push   %eax
  8009c7:	e8 3c fd ff ff       	call   800708 <getint>
  8009cc:	83 c4 10             	add    $0x10,%esp
  8009cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009d2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8009d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009db:	85 d2                	test   %edx,%edx
  8009dd:	79 23                	jns    800a02 <vprintfmt+0x29b>
				putch('-', putdat);
  8009df:	83 ec 08             	sub    $0x8,%esp
  8009e2:	ff 75 0c             	pushl  0xc(%ebp)
  8009e5:	6a 2d                	push   $0x2d
  8009e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ea:	ff d0                	call   *%eax
  8009ec:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8009ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009f2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009f5:	f7 d8                	neg    %eax
  8009f7:	83 d2 00             	adc    $0x0,%edx
  8009fa:	f7 da                	neg    %edx
  8009fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009ff:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a02:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a09:	e9 bc 00 00 00       	jmp    800aca <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a0e:	83 ec 08             	sub    $0x8,%esp
  800a11:	ff 75 e8             	pushl  -0x18(%ebp)
  800a14:	8d 45 14             	lea    0x14(%ebp),%eax
  800a17:	50                   	push   %eax
  800a18:	e8 84 fc ff ff       	call   8006a1 <getuint>
  800a1d:	83 c4 10             	add    $0x10,%esp
  800a20:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a23:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a26:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a2d:	e9 98 00 00 00       	jmp    800aca <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a32:	83 ec 08             	sub    $0x8,%esp
  800a35:	ff 75 0c             	pushl  0xc(%ebp)
  800a38:	6a 58                	push   $0x58
  800a3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3d:	ff d0                	call   *%eax
  800a3f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a42:	83 ec 08             	sub    $0x8,%esp
  800a45:	ff 75 0c             	pushl  0xc(%ebp)
  800a48:	6a 58                	push   $0x58
  800a4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4d:	ff d0                	call   *%eax
  800a4f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a52:	83 ec 08             	sub    $0x8,%esp
  800a55:	ff 75 0c             	pushl  0xc(%ebp)
  800a58:	6a 58                	push   $0x58
  800a5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a5d:	ff d0                	call   *%eax
  800a5f:	83 c4 10             	add    $0x10,%esp
			break;
  800a62:	e9 bc 00 00 00       	jmp    800b23 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a67:	83 ec 08             	sub    $0x8,%esp
  800a6a:	ff 75 0c             	pushl  0xc(%ebp)
  800a6d:	6a 30                	push   $0x30
  800a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a72:	ff d0                	call   *%eax
  800a74:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a77:	83 ec 08             	sub    $0x8,%esp
  800a7a:	ff 75 0c             	pushl  0xc(%ebp)
  800a7d:	6a 78                	push   $0x78
  800a7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a82:	ff d0                	call   *%eax
  800a84:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a87:	8b 45 14             	mov    0x14(%ebp),%eax
  800a8a:	83 c0 04             	add    $0x4,%eax
  800a8d:	89 45 14             	mov    %eax,0x14(%ebp)
  800a90:	8b 45 14             	mov    0x14(%ebp),%eax
  800a93:	83 e8 04             	sub    $0x4,%eax
  800a96:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a98:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a9b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800aa2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800aa9:	eb 1f                	jmp    800aca <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800aab:	83 ec 08             	sub    $0x8,%esp
  800aae:	ff 75 e8             	pushl  -0x18(%ebp)
  800ab1:	8d 45 14             	lea    0x14(%ebp),%eax
  800ab4:	50                   	push   %eax
  800ab5:	e8 e7 fb ff ff       	call   8006a1 <getuint>
  800aba:	83 c4 10             	add    $0x10,%esp
  800abd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ac0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ac3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800aca:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ace:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ad1:	83 ec 04             	sub    $0x4,%esp
  800ad4:	52                   	push   %edx
  800ad5:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ad8:	50                   	push   %eax
  800ad9:	ff 75 f4             	pushl  -0xc(%ebp)
  800adc:	ff 75 f0             	pushl  -0x10(%ebp)
  800adf:	ff 75 0c             	pushl  0xc(%ebp)
  800ae2:	ff 75 08             	pushl  0x8(%ebp)
  800ae5:	e8 00 fb ff ff       	call   8005ea <printnum>
  800aea:	83 c4 20             	add    $0x20,%esp
			break;
  800aed:	eb 34                	jmp    800b23 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800aef:	83 ec 08             	sub    $0x8,%esp
  800af2:	ff 75 0c             	pushl  0xc(%ebp)
  800af5:	53                   	push   %ebx
  800af6:	8b 45 08             	mov    0x8(%ebp),%eax
  800af9:	ff d0                	call   *%eax
  800afb:	83 c4 10             	add    $0x10,%esp
			break;
  800afe:	eb 23                	jmp    800b23 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b00:	83 ec 08             	sub    $0x8,%esp
  800b03:	ff 75 0c             	pushl  0xc(%ebp)
  800b06:	6a 25                	push   $0x25
  800b08:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0b:	ff d0                	call   *%eax
  800b0d:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b10:	ff 4d 10             	decl   0x10(%ebp)
  800b13:	eb 03                	jmp    800b18 <vprintfmt+0x3b1>
  800b15:	ff 4d 10             	decl   0x10(%ebp)
  800b18:	8b 45 10             	mov    0x10(%ebp),%eax
  800b1b:	48                   	dec    %eax
  800b1c:	8a 00                	mov    (%eax),%al
  800b1e:	3c 25                	cmp    $0x25,%al
  800b20:	75 f3                	jne    800b15 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b22:	90                   	nop
		}
	}
  800b23:	e9 47 fc ff ff       	jmp    80076f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b28:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b29:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b2c:	5b                   	pop    %ebx
  800b2d:	5e                   	pop    %esi
  800b2e:	5d                   	pop    %ebp
  800b2f:	c3                   	ret    

00800b30 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b30:	55                   	push   %ebp
  800b31:	89 e5                	mov    %esp,%ebp
  800b33:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b36:	8d 45 10             	lea    0x10(%ebp),%eax
  800b39:	83 c0 04             	add    $0x4,%eax
  800b3c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b3f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b42:	ff 75 f4             	pushl  -0xc(%ebp)
  800b45:	50                   	push   %eax
  800b46:	ff 75 0c             	pushl  0xc(%ebp)
  800b49:	ff 75 08             	pushl  0x8(%ebp)
  800b4c:	e8 16 fc ff ff       	call   800767 <vprintfmt>
  800b51:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b54:	90                   	nop
  800b55:	c9                   	leave  
  800b56:	c3                   	ret    

00800b57 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b57:	55                   	push   %ebp
  800b58:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b5d:	8b 40 08             	mov    0x8(%eax),%eax
  800b60:	8d 50 01             	lea    0x1(%eax),%edx
  800b63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b66:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b69:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6c:	8b 10                	mov    (%eax),%edx
  800b6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b71:	8b 40 04             	mov    0x4(%eax),%eax
  800b74:	39 c2                	cmp    %eax,%edx
  800b76:	73 12                	jae    800b8a <sprintputch+0x33>
		*b->buf++ = ch;
  800b78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b7b:	8b 00                	mov    (%eax),%eax
  800b7d:	8d 48 01             	lea    0x1(%eax),%ecx
  800b80:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b83:	89 0a                	mov    %ecx,(%edx)
  800b85:	8b 55 08             	mov    0x8(%ebp),%edx
  800b88:	88 10                	mov    %dl,(%eax)
}
  800b8a:	90                   	nop
  800b8b:	5d                   	pop    %ebp
  800b8c:	c3                   	ret    

00800b8d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b8d:	55                   	push   %ebp
  800b8e:	89 e5                	mov    %esp,%ebp
  800b90:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b93:	8b 45 08             	mov    0x8(%ebp),%eax
  800b96:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b9c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba2:	01 d0                	add    %edx,%eax
  800ba4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ba7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800bae:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bb2:	74 06                	je     800bba <vsnprintf+0x2d>
  800bb4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bb8:	7f 07                	jg     800bc1 <vsnprintf+0x34>
		return -E_INVAL;
  800bba:	b8 03 00 00 00       	mov    $0x3,%eax
  800bbf:	eb 20                	jmp    800be1 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800bc1:	ff 75 14             	pushl  0x14(%ebp)
  800bc4:	ff 75 10             	pushl  0x10(%ebp)
  800bc7:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800bca:	50                   	push   %eax
  800bcb:	68 57 0b 80 00       	push   $0x800b57
  800bd0:	e8 92 fb ff ff       	call   800767 <vprintfmt>
  800bd5:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800bd8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bdb:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800bde:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800be1:	c9                   	leave  
  800be2:	c3                   	ret    

00800be3 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800be3:	55                   	push   %ebp
  800be4:	89 e5                	mov    %esp,%ebp
  800be6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800be9:	8d 45 10             	lea    0x10(%ebp),%eax
  800bec:	83 c0 04             	add    $0x4,%eax
  800bef:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800bf2:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf5:	ff 75 f4             	pushl  -0xc(%ebp)
  800bf8:	50                   	push   %eax
  800bf9:	ff 75 0c             	pushl  0xc(%ebp)
  800bfc:	ff 75 08             	pushl  0x8(%ebp)
  800bff:	e8 89 ff ff ff       	call   800b8d <vsnprintf>
  800c04:	83 c4 10             	add    $0x10,%esp
  800c07:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c0d:	c9                   	leave  
  800c0e:	c3                   	ret    

00800c0f <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c0f:	55                   	push   %ebp
  800c10:	89 e5                	mov    %esp,%ebp
  800c12:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c15:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c1c:	eb 06                	jmp    800c24 <strlen+0x15>
		n++;
  800c1e:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c21:	ff 45 08             	incl   0x8(%ebp)
  800c24:	8b 45 08             	mov    0x8(%ebp),%eax
  800c27:	8a 00                	mov    (%eax),%al
  800c29:	84 c0                	test   %al,%al
  800c2b:	75 f1                	jne    800c1e <strlen+0xf>
		n++;
	return n;
  800c2d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c30:	c9                   	leave  
  800c31:	c3                   	ret    

00800c32 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c32:	55                   	push   %ebp
  800c33:	89 e5                	mov    %esp,%ebp
  800c35:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c38:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c3f:	eb 09                	jmp    800c4a <strnlen+0x18>
		n++;
  800c41:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c44:	ff 45 08             	incl   0x8(%ebp)
  800c47:	ff 4d 0c             	decl   0xc(%ebp)
  800c4a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c4e:	74 09                	je     800c59 <strnlen+0x27>
  800c50:	8b 45 08             	mov    0x8(%ebp),%eax
  800c53:	8a 00                	mov    (%eax),%al
  800c55:	84 c0                	test   %al,%al
  800c57:	75 e8                	jne    800c41 <strnlen+0xf>
		n++;
	return n;
  800c59:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c5c:	c9                   	leave  
  800c5d:	c3                   	ret    

00800c5e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c5e:	55                   	push   %ebp
  800c5f:	89 e5                	mov    %esp,%ebp
  800c61:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c64:	8b 45 08             	mov    0x8(%ebp),%eax
  800c67:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c6a:	90                   	nop
  800c6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6e:	8d 50 01             	lea    0x1(%eax),%edx
  800c71:	89 55 08             	mov    %edx,0x8(%ebp)
  800c74:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c77:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c7a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c7d:	8a 12                	mov    (%edx),%dl
  800c7f:	88 10                	mov    %dl,(%eax)
  800c81:	8a 00                	mov    (%eax),%al
  800c83:	84 c0                	test   %al,%al
  800c85:	75 e4                	jne    800c6b <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c87:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c8a:	c9                   	leave  
  800c8b:	c3                   	ret    

00800c8c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c8c:	55                   	push   %ebp
  800c8d:	89 e5                	mov    %esp,%ebp
  800c8f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c92:	8b 45 08             	mov    0x8(%ebp),%eax
  800c95:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c98:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c9f:	eb 1f                	jmp    800cc0 <strncpy+0x34>
		*dst++ = *src;
  800ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca4:	8d 50 01             	lea    0x1(%eax),%edx
  800ca7:	89 55 08             	mov    %edx,0x8(%ebp)
  800caa:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cad:	8a 12                	mov    (%edx),%dl
  800caf:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800cb1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb4:	8a 00                	mov    (%eax),%al
  800cb6:	84 c0                	test   %al,%al
  800cb8:	74 03                	je     800cbd <strncpy+0x31>
			src++;
  800cba:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800cbd:	ff 45 fc             	incl   -0x4(%ebp)
  800cc0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cc3:	3b 45 10             	cmp    0x10(%ebp),%eax
  800cc6:	72 d9                	jb     800ca1 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800cc8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ccb:	c9                   	leave  
  800ccc:	c3                   	ret    

00800ccd <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ccd:	55                   	push   %ebp
  800cce:	89 e5                	mov    %esp,%ebp
  800cd0:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800cd9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cdd:	74 30                	je     800d0f <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800cdf:	eb 16                	jmp    800cf7 <strlcpy+0x2a>
			*dst++ = *src++;
  800ce1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce4:	8d 50 01             	lea    0x1(%eax),%edx
  800ce7:	89 55 08             	mov    %edx,0x8(%ebp)
  800cea:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ced:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cf0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cf3:	8a 12                	mov    (%edx),%dl
  800cf5:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800cf7:	ff 4d 10             	decl   0x10(%ebp)
  800cfa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cfe:	74 09                	je     800d09 <strlcpy+0x3c>
  800d00:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d03:	8a 00                	mov    (%eax),%al
  800d05:	84 c0                	test   %al,%al
  800d07:	75 d8                	jne    800ce1 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d09:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0c:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d0f:	8b 55 08             	mov    0x8(%ebp),%edx
  800d12:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d15:	29 c2                	sub    %eax,%edx
  800d17:	89 d0                	mov    %edx,%eax
}
  800d19:	c9                   	leave  
  800d1a:	c3                   	ret    

00800d1b <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d1b:	55                   	push   %ebp
  800d1c:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d1e:	eb 06                	jmp    800d26 <strcmp+0xb>
		p++, q++;
  800d20:	ff 45 08             	incl   0x8(%ebp)
  800d23:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d26:	8b 45 08             	mov    0x8(%ebp),%eax
  800d29:	8a 00                	mov    (%eax),%al
  800d2b:	84 c0                	test   %al,%al
  800d2d:	74 0e                	je     800d3d <strcmp+0x22>
  800d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d32:	8a 10                	mov    (%eax),%dl
  800d34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d37:	8a 00                	mov    (%eax),%al
  800d39:	38 c2                	cmp    %al,%dl
  800d3b:	74 e3                	je     800d20 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d40:	8a 00                	mov    (%eax),%al
  800d42:	0f b6 d0             	movzbl %al,%edx
  800d45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d48:	8a 00                	mov    (%eax),%al
  800d4a:	0f b6 c0             	movzbl %al,%eax
  800d4d:	29 c2                	sub    %eax,%edx
  800d4f:	89 d0                	mov    %edx,%eax
}
  800d51:	5d                   	pop    %ebp
  800d52:	c3                   	ret    

00800d53 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d53:	55                   	push   %ebp
  800d54:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d56:	eb 09                	jmp    800d61 <strncmp+0xe>
		n--, p++, q++;
  800d58:	ff 4d 10             	decl   0x10(%ebp)
  800d5b:	ff 45 08             	incl   0x8(%ebp)
  800d5e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d61:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d65:	74 17                	je     800d7e <strncmp+0x2b>
  800d67:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6a:	8a 00                	mov    (%eax),%al
  800d6c:	84 c0                	test   %al,%al
  800d6e:	74 0e                	je     800d7e <strncmp+0x2b>
  800d70:	8b 45 08             	mov    0x8(%ebp),%eax
  800d73:	8a 10                	mov    (%eax),%dl
  800d75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d78:	8a 00                	mov    (%eax),%al
  800d7a:	38 c2                	cmp    %al,%dl
  800d7c:	74 da                	je     800d58 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d7e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d82:	75 07                	jne    800d8b <strncmp+0x38>
		return 0;
  800d84:	b8 00 00 00 00       	mov    $0x0,%eax
  800d89:	eb 14                	jmp    800d9f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8e:	8a 00                	mov    (%eax),%al
  800d90:	0f b6 d0             	movzbl %al,%edx
  800d93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d96:	8a 00                	mov    (%eax),%al
  800d98:	0f b6 c0             	movzbl %al,%eax
  800d9b:	29 c2                	sub    %eax,%edx
  800d9d:	89 d0                	mov    %edx,%eax
}
  800d9f:	5d                   	pop    %ebp
  800da0:	c3                   	ret    

00800da1 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800da1:	55                   	push   %ebp
  800da2:	89 e5                	mov    %esp,%ebp
  800da4:	83 ec 04             	sub    $0x4,%esp
  800da7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800daa:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800dad:	eb 12                	jmp    800dc1 <strchr+0x20>
		if (*s == c)
  800daf:	8b 45 08             	mov    0x8(%ebp),%eax
  800db2:	8a 00                	mov    (%eax),%al
  800db4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800db7:	75 05                	jne    800dbe <strchr+0x1d>
			return (char *) s;
  800db9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbc:	eb 11                	jmp    800dcf <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800dbe:	ff 45 08             	incl   0x8(%ebp)
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	8a 00                	mov    (%eax),%al
  800dc6:	84 c0                	test   %al,%al
  800dc8:	75 e5                	jne    800daf <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800dca:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800dcf:	c9                   	leave  
  800dd0:	c3                   	ret    

00800dd1 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800dd1:	55                   	push   %ebp
  800dd2:	89 e5                	mov    %esp,%ebp
  800dd4:	83 ec 04             	sub    $0x4,%esp
  800dd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dda:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ddd:	eb 0d                	jmp    800dec <strfind+0x1b>
		if (*s == c)
  800ddf:	8b 45 08             	mov    0x8(%ebp),%eax
  800de2:	8a 00                	mov    (%eax),%al
  800de4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800de7:	74 0e                	je     800df7 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800de9:	ff 45 08             	incl   0x8(%ebp)
  800dec:	8b 45 08             	mov    0x8(%ebp),%eax
  800def:	8a 00                	mov    (%eax),%al
  800df1:	84 c0                	test   %al,%al
  800df3:	75 ea                	jne    800ddf <strfind+0xe>
  800df5:	eb 01                	jmp    800df8 <strfind+0x27>
		if (*s == c)
			break;
  800df7:	90                   	nop
	return (char *) s;
  800df8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dfb:	c9                   	leave  
  800dfc:	c3                   	ret    

00800dfd <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800dfd:	55                   	push   %ebp
  800dfe:	89 e5                	mov    %esp,%ebp
  800e00:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e03:	8b 45 08             	mov    0x8(%ebp),%eax
  800e06:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e09:	8b 45 10             	mov    0x10(%ebp),%eax
  800e0c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e0f:	eb 0e                	jmp    800e1f <memset+0x22>
		*p++ = c;
  800e11:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e14:	8d 50 01             	lea    0x1(%eax),%edx
  800e17:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e1a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e1d:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e1f:	ff 4d f8             	decl   -0x8(%ebp)
  800e22:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e26:	79 e9                	jns    800e11 <memset+0x14>
		*p++ = c;

	return v;
  800e28:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e2b:	c9                   	leave  
  800e2c:	c3                   	ret    

00800e2d <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e2d:	55                   	push   %ebp
  800e2e:	89 e5                	mov    %esp,%ebp
  800e30:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e36:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e39:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e3f:	eb 16                	jmp    800e57 <memcpy+0x2a>
		*d++ = *s++;
  800e41:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e44:	8d 50 01             	lea    0x1(%eax),%edx
  800e47:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e4a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e4d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e50:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e53:	8a 12                	mov    (%edx),%dl
  800e55:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e57:	8b 45 10             	mov    0x10(%ebp),%eax
  800e5a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e5d:	89 55 10             	mov    %edx,0x10(%ebp)
  800e60:	85 c0                	test   %eax,%eax
  800e62:	75 dd                	jne    800e41 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e64:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e67:	c9                   	leave  
  800e68:	c3                   	ret    

00800e69 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e69:	55                   	push   %ebp
  800e6a:	89 e5                	mov    %esp,%ebp
  800e6c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e72:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e75:	8b 45 08             	mov    0x8(%ebp),%eax
  800e78:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e7b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e7e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e81:	73 50                	jae    800ed3 <memmove+0x6a>
  800e83:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e86:	8b 45 10             	mov    0x10(%ebp),%eax
  800e89:	01 d0                	add    %edx,%eax
  800e8b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e8e:	76 43                	jbe    800ed3 <memmove+0x6a>
		s += n;
  800e90:	8b 45 10             	mov    0x10(%ebp),%eax
  800e93:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e96:	8b 45 10             	mov    0x10(%ebp),%eax
  800e99:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e9c:	eb 10                	jmp    800eae <memmove+0x45>
			*--d = *--s;
  800e9e:	ff 4d f8             	decl   -0x8(%ebp)
  800ea1:	ff 4d fc             	decl   -0x4(%ebp)
  800ea4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ea7:	8a 10                	mov    (%eax),%dl
  800ea9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eac:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800eae:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800eb4:	89 55 10             	mov    %edx,0x10(%ebp)
  800eb7:	85 c0                	test   %eax,%eax
  800eb9:	75 e3                	jne    800e9e <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800ebb:	eb 23                	jmp    800ee0 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ebd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ec0:	8d 50 01             	lea    0x1(%eax),%edx
  800ec3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ec6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ec9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ecc:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ecf:	8a 12                	mov    (%edx),%dl
  800ed1:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800ed3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ed9:	89 55 10             	mov    %edx,0x10(%ebp)
  800edc:	85 c0                	test   %eax,%eax
  800ede:	75 dd                	jne    800ebd <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ee0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ee3:	c9                   	leave  
  800ee4:	c3                   	ret    

00800ee5 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800ee5:	55                   	push   %ebp
  800ee6:	89 e5                	mov    %esp,%ebp
  800ee8:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800eee:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ef1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef4:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ef7:	eb 2a                	jmp    800f23 <memcmp+0x3e>
		if (*s1 != *s2)
  800ef9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800efc:	8a 10                	mov    (%eax),%dl
  800efe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f01:	8a 00                	mov    (%eax),%al
  800f03:	38 c2                	cmp    %al,%dl
  800f05:	74 16                	je     800f1d <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f07:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f0a:	8a 00                	mov    (%eax),%al
  800f0c:	0f b6 d0             	movzbl %al,%edx
  800f0f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f12:	8a 00                	mov    (%eax),%al
  800f14:	0f b6 c0             	movzbl %al,%eax
  800f17:	29 c2                	sub    %eax,%edx
  800f19:	89 d0                	mov    %edx,%eax
  800f1b:	eb 18                	jmp    800f35 <memcmp+0x50>
		s1++, s2++;
  800f1d:	ff 45 fc             	incl   -0x4(%ebp)
  800f20:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f23:	8b 45 10             	mov    0x10(%ebp),%eax
  800f26:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f29:	89 55 10             	mov    %edx,0x10(%ebp)
  800f2c:	85 c0                	test   %eax,%eax
  800f2e:	75 c9                	jne    800ef9 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f30:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f35:	c9                   	leave  
  800f36:	c3                   	ret    

00800f37 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f37:	55                   	push   %ebp
  800f38:	89 e5                	mov    %esp,%ebp
  800f3a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f3d:	8b 55 08             	mov    0x8(%ebp),%edx
  800f40:	8b 45 10             	mov    0x10(%ebp),%eax
  800f43:	01 d0                	add    %edx,%eax
  800f45:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f48:	eb 15                	jmp    800f5f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4d:	8a 00                	mov    (%eax),%al
  800f4f:	0f b6 d0             	movzbl %al,%edx
  800f52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f55:	0f b6 c0             	movzbl %al,%eax
  800f58:	39 c2                	cmp    %eax,%edx
  800f5a:	74 0d                	je     800f69 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f5c:	ff 45 08             	incl   0x8(%ebp)
  800f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f62:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f65:	72 e3                	jb     800f4a <memfind+0x13>
  800f67:	eb 01                	jmp    800f6a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f69:	90                   	nop
	return (void *) s;
  800f6a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f6d:	c9                   	leave  
  800f6e:	c3                   	ret    

00800f6f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f6f:	55                   	push   %ebp
  800f70:	89 e5                	mov    %esp,%ebp
  800f72:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f75:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f7c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f83:	eb 03                	jmp    800f88 <strtol+0x19>
		s++;
  800f85:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f88:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8b:	8a 00                	mov    (%eax),%al
  800f8d:	3c 20                	cmp    $0x20,%al
  800f8f:	74 f4                	je     800f85 <strtol+0x16>
  800f91:	8b 45 08             	mov    0x8(%ebp),%eax
  800f94:	8a 00                	mov    (%eax),%al
  800f96:	3c 09                	cmp    $0x9,%al
  800f98:	74 eb                	je     800f85 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9d:	8a 00                	mov    (%eax),%al
  800f9f:	3c 2b                	cmp    $0x2b,%al
  800fa1:	75 05                	jne    800fa8 <strtol+0x39>
		s++;
  800fa3:	ff 45 08             	incl   0x8(%ebp)
  800fa6:	eb 13                	jmp    800fbb <strtol+0x4c>
	else if (*s == '-')
  800fa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fab:	8a 00                	mov    (%eax),%al
  800fad:	3c 2d                	cmp    $0x2d,%al
  800faf:	75 0a                	jne    800fbb <strtol+0x4c>
		s++, neg = 1;
  800fb1:	ff 45 08             	incl   0x8(%ebp)
  800fb4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800fbb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fbf:	74 06                	je     800fc7 <strtol+0x58>
  800fc1:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800fc5:	75 20                	jne    800fe7 <strtol+0x78>
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	8a 00                	mov    (%eax),%al
  800fcc:	3c 30                	cmp    $0x30,%al
  800fce:	75 17                	jne    800fe7 <strtol+0x78>
  800fd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd3:	40                   	inc    %eax
  800fd4:	8a 00                	mov    (%eax),%al
  800fd6:	3c 78                	cmp    $0x78,%al
  800fd8:	75 0d                	jne    800fe7 <strtol+0x78>
		s += 2, base = 16;
  800fda:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800fde:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800fe5:	eb 28                	jmp    80100f <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800fe7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800feb:	75 15                	jne    801002 <strtol+0x93>
  800fed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff0:	8a 00                	mov    (%eax),%al
  800ff2:	3c 30                	cmp    $0x30,%al
  800ff4:	75 0c                	jne    801002 <strtol+0x93>
		s++, base = 8;
  800ff6:	ff 45 08             	incl   0x8(%ebp)
  800ff9:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801000:	eb 0d                	jmp    80100f <strtol+0xa0>
	else if (base == 0)
  801002:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801006:	75 07                	jne    80100f <strtol+0xa0>
		base = 10;
  801008:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80100f:	8b 45 08             	mov    0x8(%ebp),%eax
  801012:	8a 00                	mov    (%eax),%al
  801014:	3c 2f                	cmp    $0x2f,%al
  801016:	7e 19                	jle    801031 <strtol+0xc2>
  801018:	8b 45 08             	mov    0x8(%ebp),%eax
  80101b:	8a 00                	mov    (%eax),%al
  80101d:	3c 39                	cmp    $0x39,%al
  80101f:	7f 10                	jg     801031 <strtol+0xc2>
			dig = *s - '0';
  801021:	8b 45 08             	mov    0x8(%ebp),%eax
  801024:	8a 00                	mov    (%eax),%al
  801026:	0f be c0             	movsbl %al,%eax
  801029:	83 e8 30             	sub    $0x30,%eax
  80102c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80102f:	eb 42                	jmp    801073 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801031:	8b 45 08             	mov    0x8(%ebp),%eax
  801034:	8a 00                	mov    (%eax),%al
  801036:	3c 60                	cmp    $0x60,%al
  801038:	7e 19                	jle    801053 <strtol+0xe4>
  80103a:	8b 45 08             	mov    0x8(%ebp),%eax
  80103d:	8a 00                	mov    (%eax),%al
  80103f:	3c 7a                	cmp    $0x7a,%al
  801041:	7f 10                	jg     801053 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801043:	8b 45 08             	mov    0x8(%ebp),%eax
  801046:	8a 00                	mov    (%eax),%al
  801048:	0f be c0             	movsbl %al,%eax
  80104b:	83 e8 57             	sub    $0x57,%eax
  80104e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801051:	eb 20                	jmp    801073 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801053:	8b 45 08             	mov    0x8(%ebp),%eax
  801056:	8a 00                	mov    (%eax),%al
  801058:	3c 40                	cmp    $0x40,%al
  80105a:	7e 39                	jle    801095 <strtol+0x126>
  80105c:	8b 45 08             	mov    0x8(%ebp),%eax
  80105f:	8a 00                	mov    (%eax),%al
  801061:	3c 5a                	cmp    $0x5a,%al
  801063:	7f 30                	jg     801095 <strtol+0x126>
			dig = *s - 'A' + 10;
  801065:	8b 45 08             	mov    0x8(%ebp),%eax
  801068:	8a 00                	mov    (%eax),%al
  80106a:	0f be c0             	movsbl %al,%eax
  80106d:	83 e8 37             	sub    $0x37,%eax
  801070:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801073:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801076:	3b 45 10             	cmp    0x10(%ebp),%eax
  801079:	7d 19                	jge    801094 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80107b:	ff 45 08             	incl   0x8(%ebp)
  80107e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801081:	0f af 45 10          	imul   0x10(%ebp),%eax
  801085:	89 c2                	mov    %eax,%edx
  801087:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80108a:	01 d0                	add    %edx,%eax
  80108c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80108f:	e9 7b ff ff ff       	jmp    80100f <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801094:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801095:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801099:	74 08                	je     8010a3 <strtol+0x134>
		*endptr = (char *) s;
  80109b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109e:	8b 55 08             	mov    0x8(%ebp),%edx
  8010a1:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8010a3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010a7:	74 07                	je     8010b0 <strtol+0x141>
  8010a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ac:	f7 d8                	neg    %eax
  8010ae:	eb 03                	jmp    8010b3 <strtol+0x144>
  8010b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010b3:	c9                   	leave  
  8010b4:	c3                   	ret    

008010b5 <ltostr>:

void
ltostr(long value, char *str)
{
  8010b5:	55                   	push   %ebp
  8010b6:	89 e5                	mov    %esp,%ebp
  8010b8:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8010bb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8010c2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8010c9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010cd:	79 13                	jns    8010e2 <ltostr+0x2d>
	{
		neg = 1;
  8010cf:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8010d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d9:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8010dc:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8010df:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8010e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e5:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8010ea:	99                   	cltd   
  8010eb:	f7 f9                	idiv   %ecx
  8010ed:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8010f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010f3:	8d 50 01             	lea    0x1(%eax),%edx
  8010f6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010f9:	89 c2                	mov    %eax,%edx
  8010fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fe:	01 d0                	add    %edx,%eax
  801100:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801103:	83 c2 30             	add    $0x30,%edx
  801106:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801108:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80110b:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801110:	f7 e9                	imul   %ecx
  801112:	c1 fa 02             	sar    $0x2,%edx
  801115:	89 c8                	mov    %ecx,%eax
  801117:	c1 f8 1f             	sar    $0x1f,%eax
  80111a:	29 c2                	sub    %eax,%edx
  80111c:	89 d0                	mov    %edx,%eax
  80111e:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801121:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801124:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801129:	f7 e9                	imul   %ecx
  80112b:	c1 fa 02             	sar    $0x2,%edx
  80112e:	89 c8                	mov    %ecx,%eax
  801130:	c1 f8 1f             	sar    $0x1f,%eax
  801133:	29 c2                	sub    %eax,%edx
  801135:	89 d0                	mov    %edx,%eax
  801137:	c1 e0 02             	shl    $0x2,%eax
  80113a:	01 d0                	add    %edx,%eax
  80113c:	01 c0                	add    %eax,%eax
  80113e:	29 c1                	sub    %eax,%ecx
  801140:	89 ca                	mov    %ecx,%edx
  801142:	85 d2                	test   %edx,%edx
  801144:	75 9c                	jne    8010e2 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801146:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80114d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801150:	48                   	dec    %eax
  801151:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801154:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801158:	74 3d                	je     801197 <ltostr+0xe2>
		start = 1 ;
  80115a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801161:	eb 34                	jmp    801197 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801163:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801166:	8b 45 0c             	mov    0xc(%ebp),%eax
  801169:	01 d0                	add    %edx,%eax
  80116b:	8a 00                	mov    (%eax),%al
  80116d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801170:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801173:	8b 45 0c             	mov    0xc(%ebp),%eax
  801176:	01 c2                	add    %eax,%edx
  801178:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80117b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117e:	01 c8                	add    %ecx,%eax
  801180:	8a 00                	mov    (%eax),%al
  801182:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801184:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801187:	8b 45 0c             	mov    0xc(%ebp),%eax
  80118a:	01 c2                	add    %eax,%edx
  80118c:	8a 45 eb             	mov    -0x15(%ebp),%al
  80118f:	88 02                	mov    %al,(%edx)
		start++ ;
  801191:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801194:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801197:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80119a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80119d:	7c c4                	jl     801163 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80119f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8011a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a5:	01 d0                	add    %edx,%eax
  8011a7:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8011aa:	90                   	nop
  8011ab:	c9                   	leave  
  8011ac:	c3                   	ret    

008011ad <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8011ad:	55                   	push   %ebp
  8011ae:	89 e5                	mov    %esp,%ebp
  8011b0:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8011b3:	ff 75 08             	pushl  0x8(%ebp)
  8011b6:	e8 54 fa ff ff       	call   800c0f <strlen>
  8011bb:	83 c4 04             	add    $0x4,%esp
  8011be:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8011c1:	ff 75 0c             	pushl  0xc(%ebp)
  8011c4:	e8 46 fa ff ff       	call   800c0f <strlen>
  8011c9:	83 c4 04             	add    $0x4,%esp
  8011cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8011cf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8011d6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011dd:	eb 17                	jmp    8011f6 <strcconcat+0x49>
		final[s] = str1[s] ;
  8011df:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e5:	01 c2                	add    %eax,%edx
  8011e7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8011ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ed:	01 c8                	add    %ecx,%eax
  8011ef:	8a 00                	mov    (%eax),%al
  8011f1:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8011f3:	ff 45 fc             	incl   -0x4(%ebp)
  8011f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011f9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8011fc:	7c e1                	jl     8011df <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8011fe:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801205:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80120c:	eb 1f                	jmp    80122d <strcconcat+0x80>
		final[s++] = str2[i] ;
  80120e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801211:	8d 50 01             	lea    0x1(%eax),%edx
  801214:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801217:	89 c2                	mov    %eax,%edx
  801219:	8b 45 10             	mov    0x10(%ebp),%eax
  80121c:	01 c2                	add    %eax,%edx
  80121e:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801221:	8b 45 0c             	mov    0xc(%ebp),%eax
  801224:	01 c8                	add    %ecx,%eax
  801226:	8a 00                	mov    (%eax),%al
  801228:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80122a:	ff 45 f8             	incl   -0x8(%ebp)
  80122d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801230:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801233:	7c d9                	jl     80120e <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801235:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801238:	8b 45 10             	mov    0x10(%ebp),%eax
  80123b:	01 d0                	add    %edx,%eax
  80123d:	c6 00 00             	movb   $0x0,(%eax)
}
  801240:	90                   	nop
  801241:	c9                   	leave  
  801242:	c3                   	ret    

00801243 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801243:	55                   	push   %ebp
  801244:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801246:	8b 45 14             	mov    0x14(%ebp),%eax
  801249:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80124f:	8b 45 14             	mov    0x14(%ebp),%eax
  801252:	8b 00                	mov    (%eax),%eax
  801254:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80125b:	8b 45 10             	mov    0x10(%ebp),%eax
  80125e:	01 d0                	add    %edx,%eax
  801260:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801266:	eb 0c                	jmp    801274 <strsplit+0x31>
			*string++ = 0;
  801268:	8b 45 08             	mov    0x8(%ebp),%eax
  80126b:	8d 50 01             	lea    0x1(%eax),%edx
  80126e:	89 55 08             	mov    %edx,0x8(%ebp)
  801271:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801274:	8b 45 08             	mov    0x8(%ebp),%eax
  801277:	8a 00                	mov    (%eax),%al
  801279:	84 c0                	test   %al,%al
  80127b:	74 18                	je     801295 <strsplit+0x52>
  80127d:	8b 45 08             	mov    0x8(%ebp),%eax
  801280:	8a 00                	mov    (%eax),%al
  801282:	0f be c0             	movsbl %al,%eax
  801285:	50                   	push   %eax
  801286:	ff 75 0c             	pushl  0xc(%ebp)
  801289:	e8 13 fb ff ff       	call   800da1 <strchr>
  80128e:	83 c4 08             	add    $0x8,%esp
  801291:	85 c0                	test   %eax,%eax
  801293:	75 d3                	jne    801268 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801295:	8b 45 08             	mov    0x8(%ebp),%eax
  801298:	8a 00                	mov    (%eax),%al
  80129a:	84 c0                	test   %al,%al
  80129c:	74 5a                	je     8012f8 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80129e:	8b 45 14             	mov    0x14(%ebp),%eax
  8012a1:	8b 00                	mov    (%eax),%eax
  8012a3:	83 f8 0f             	cmp    $0xf,%eax
  8012a6:	75 07                	jne    8012af <strsplit+0x6c>
		{
			return 0;
  8012a8:	b8 00 00 00 00       	mov    $0x0,%eax
  8012ad:	eb 66                	jmp    801315 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8012af:	8b 45 14             	mov    0x14(%ebp),%eax
  8012b2:	8b 00                	mov    (%eax),%eax
  8012b4:	8d 48 01             	lea    0x1(%eax),%ecx
  8012b7:	8b 55 14             	mov    0x14(%ebp),%edx
  8012ba:	89 0a                	mov    %ecx,(%edx)
  8012bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c6:	01 c2                	add    %eax,%edx
  8012c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cb:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012cd:	eb 03                	jmp    8012d2 <strsplit+0x8f>
			string++;
  8012cf:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d5:	8a 00                	mov    (%eax),%al
  8012d7:	84 c0                	test   %al,%al
  8012d9:	74 8b                	je     801266 <strsplit+0x23>
  8012db:	8b 45 08             	mov    0x8(%ebp),%eax
  8012de:	8a 00                	mov    (%eax),%al
  8012e0:	0f be c0             	movsbl %al,%eax
  8012e3:	50                   	push   %eax
  8012e4:	ff 75 0c             	pushl  0xc(%ebp)
  8012e7:	e8 b5 fa ff ff       	call   800da1 <strchr>
  8012ec:	83 c4 08             	add    $0x8,%esp
  8012ef:	85 c0                	test   %eax,%eax
  8012f1:	74 dc                	je     8012cf <strsplit+0x8c>
			string++;
	}
  8012f3:	e9 6e ff ff ff       	jmp    801266 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8012f8:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8012f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8012fc:	8b 00                	mov    (%eax),%eax
  8012fe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801305:	8b 45 10             	mov    0x10(%ebp),%eax
  801308:	01 d0                	add    %edx,%eax
  80130a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801310:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801315:	c9                   	leave  
  801316:	c3                   	ret    

00801317 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801317:	55                   	push   %ebp
  801318:	89 e5                	mov    %esp,%ebp
  80131a:	57                   	push   %edi
  80131b:	56                   	push   %esi
  80131c:	53                   	push   %ebx
  80131d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801320:	8b 45 08             	mov    0x8(%ebp),%eax
  801323:	8b 55 0c             	mov    0xc(%ebp),%edx
  801326:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801329:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80132c:	8b 7d 18             	mov    0x18(%ebp),%edi
  80132f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801332:	cd 30                	int    $0x30
  801334:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801337:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80133a:	83 c4 10             	add    $0x10,%esp
  80133d:	5b                   	pop    %ebx
  80133e:	5e                   	pop    %esi
  80133f:	5f                   	pop    %edi
  801340:	5d                   	pop    %ebp
  801341:	c3                   	ret    

00801342 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801342:	55                   	push   %ebp
  801343:	89 e5                	mov    %esp,%ebp
  801345:	83 ec 04             	sub    $0x4,%esp
  801348:	8b 45 10             	mov    0x10(%ebp),%eax
  80134b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80134e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801352:	8b 45 08             	mov    0x8(%ebp),%eax
  801355:	6a 00                	push   $0x0
  801357:	6a 00                	push   $0x0
  801359:	52                   	push   %edx
  80135a:	ff 75 0c             	pushl  0xc(%ebp)
  80135d:	50                   	push   %eax
  80135e:	6a 00                	push   $0x0
  801360:	e8 b2 ff ff ff       	call   801317 <syscall>
  801365:	83 c4 18             	add    $0x18,%esp
}
  801368:	90                   	nop
  801369:	c9                   	leave  
  80136a:	c3                   	ret    

0080136b <sys_cgetc>:

int
sys_cgetc(void)
{
  80136b:	55                   	push   %ebp
  80136c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80136e:	6a 00                	push   $0x0
  801370:	6a 00                	push   $0x0
  801372:	6a 00                	push   $0x0
  801374:	6a 00                	push   $0x0
  801376:	6a 00                	push   $0x0
  801378:	6a 01                	push   $0x1
  80137a:	e8 98 ff ff ff       	call   801317 <syscall>
  80137f:	83 c4 18             	add    $0x18,%esp
}
  801382:	c9                   	leave  
  801383:	c3                   	ret    

00801384 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801384:	55                   	push   %ebp
  801385:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801387:	8b 45 08             	mov    0x8(%ebp),%eax
  80138a:	6a 00                	push   $0x0
  80138c:	6a 00                	push   $0x0
  80138e:	6a 00                	push   $0x0
  801390:	6a 00                	push   $0x0
  801392:	50                   	push   %eax
  801393:	6a 05                	push   $0x5
  801395:	e8 7d ff ff ff       	call   801317 <syscall>
  80139a:	83 c4 18             	add    $0x18,%esp
}
  80139d:	c9                   	leave  
  80139e:	c3                   	ret    

0080139f <sys_getenvid>:

int32 sys_getenvid(void)
{
  80139f:	55                   	push   %ebp
  8013a0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8013a2:	6a 00                	push   $0x0
  8013a4:	6a 00                	push   $0x0
  8013a6:	6a 00                	push   $0x0
  8013a8:	6a 00                	push   $0x0
  8013aa:	6a 00                	push   $0x0
  8013ac:	6a 02                	push   $0x2
  8013ae:	e8 64 ff ff ff       	call   801317 <syscall>
  8013b3:	83 c4 18             	add    $0x18,%esp
}
  8013b6:	c9                   	leave  
  8013b7:	c3                   	ret    

008013b8 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8013b8:	55                   	push   %ebp
  8013b9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8013bb:	6a 00                	push   $0x0
  8013bd:	6a 00                	push   $0x0
  8013bf:	6a 00                	push   $0x0
  8013c1:	6a 00                	push   $0x0
  8013c3:	6a 00                	push   $0x0
  8013c5:	6a 03                	push   $0x3
  8013c7:	e8 4b ff ff ff       	call   801317 <syscall>
  8013cc:	83 c4 18             	add    $0x18,%esp
}
  8013cf:	c9                   	leave  
  8013d0:	c3                   	ret    

008013d1 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8013d1:	55                   	push   %ebp
  8013d2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 00                	push   $0x0
  8013da:	6a 00                	push   $0x0
  8013dc:	6a 00                	push   $0x0
  8013de:	6a 04                	push   $0x4
  8013e0:	e8 32 ff ff ff       	call   801317 <syscall>
  8013e5:	83 c4 18             	add    $0x18,%esp
}
  8013e8:	c9                   	leave  
  8013e9:	c3                   	ret    

008013ea <sys_env_exit>:


void sys_env_exit(void)
{
  8013ea:	55                   	push   %ebp
  8013eb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 00                	push   $0x0
  8013f1:	6a 00                	push   $0x0
  8013f3:	6a 00                	push   $0x0
  8013f5:	6a 00                	push   $0x0
  8013f7:	6a 06                	push   $0x6
  8013f9:	e8 19 ff ff ff       	call   801317 <syscall>
  8013fe:	83 c4 18             	add    $0x18,%esp
}
  801401:	90                   	nop
  801402:	c9                   	leave  
  801403:	c3                   	ret    

00801404 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801404:	55                   	push   %ebp
  801405:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801407:	8b 55 0c             	mov    0xc(%ebp),%edx
  80140a:	8b 45 08             	mov    0x8(%ebp),%eax
  80140d:	6a 00                	push   $0x0
  80140f:	6a 00                	push   $0x0
  801411:	6a 00                	push   $0x0
  801413:	52                   	push   %edx
  801414:	50                   	push   %eax
  801415:	6a 07                	push   $0x7
  801417:	e8 fb fe ff ff       	call   801317 <syscall>
  80141c:	83 c4 18             	add    $0x18,%esp
}
  80141f:	c9                   	leave  
  801420:	c3                   	ret    

00801421 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801421:	55                   	push   %ebp
  801422:	89 e5                	mov    %esp,%ebp
  801424:	56                   	push   %esi
  801425:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801426:	8b 75 18             	mov    0x18(%ebp),%esi
  801429:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80142c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80142f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801432:	8b 45 08             	mov    0x8(%ebp),%eax
  801435:	56                   	push   %esi
  801436:	53                   	push   %ebx
  801437:	51                   	push   %ecx
  801438:	52                   	push   %edx
  801439:	50                   	push   %eax
  80143a:	6a 08                	push   $0x8
  80143c:	e8 d6 fe ff ff       	call   801317 <syscall>
  801441:	83 c4 18             	add    $0x18,%esp
}
  801444:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801447:	5b                   	pop    %ebx
  801448:	5e                   	pop    %esi
  801449:	5d                   	pop    %ebp
  80144a:	c3                   	ret    

0080144b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80144b:	55                   	push   %ebp
  80144c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80144e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801451:	8b 45 08             	mov    0x8(%ebp),%eax
  801454:	6a 00                	push   $0x0
  801456:	6a 00                	push   $0x0
  801458:	6a 00                	push   $0x0
  80145a:	52                   	push   %edx
  80145b:	50                   	push   %eax
  80145c:	6a 09                	push   $0x9
  80145e:	e8 b4 fe ff ff       	call   801317 <syscall>
  801463:	83 c4 18             	add    $0x18,%esp
}
  801466:	c9                   	leave  
  801467:	c3                   	ret    

00801468 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801468:	55                   	push   %ebp
  801469:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80146b:	6a 00                	push   $0x0
  80146d:	6a 00                	push   $0x0
  80146f:	6a 00                	push   $0x0
  801471:	ff 75 0c             	pushl  0xc(%ebp)
  801474:	ff 75 08             	pushl  0x8(%ebp)
  801477:	6a 0a                	push   $0xa
  801479:	e8 99 fe ff ff       	call   801317 <syscall>
  80147e:	83 c4 18             	add    $0x18,%esp
}
  801481:	c9                   	leave  
  801482:	c3                   	ret    

00801483 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801483:	55                   	push   %ebp
  801484:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801486:	6a 00                	push   $0x0
  801488:	6a 00                	push   $0x0
  80148a:	6a 00                	push   $0x0
  80148c:	6a 00                	push   $0x0
  80148e:	6a 00                	push   $0x0
  801490:	6a 0b                	push   $0xb
  801492:	e8 80 fe ff ff       	call   801317 <syscall>
  801497:	83 c4 18             	add    $0x18,%esp
}
  80149a:	c9                   	leave  
  80149b:	c3                   	ret    

0080149c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80149c:	55                   	push   %ebp
  80149d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 00                	push   $0x0
  8014a3:	6a 00                	push   $0x0
  8014a5:	6a 00                	push   $0x0
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 0c                	push   $0xc
  8014ab:	e8 67 fe ff ff       	call   801317 <syscall>
  8014b0:	83 c4 18             	add    $0x18,%esp
}
  8014b3:	c9                   	leave  
  8014b4:	c3                   	ret    

008014b5 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8014b5:	55                   	push   %ebp
  8014b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8014b8:	6a 00                	push   $0x0
  8014ba:	6a 00                	push   $0x0
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 0d                	push   $0xd
  8014c4:	e8 4e fe ff ff       	call   801317 <syscall>
  8014c9:	83 c4 18             	add    $0x18,%esp
}
  8014cc:	c9                   	leave  
  8014cd:	c3                   	ret    

008014ce <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8014ce:	55                   	push   %ebp
  8014cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8014d1:	6a 00                	push   $0x0
  8014d3:	6a 00                	push   $0x0
  8014d5:	6a 00                	push   $0x0
  8014d7:	ff 75 0c             	pushl  0xc(%ebp)
  8014da:	ff 75 08             	pushl  0x8(%ebp)
  8014dd:	6a 11                	push   $0x11
  8014df:	e8 33 fe ff ff       	call   801317 <syscall>
  8014e4:	83 c4 18             	add    $0x18,%esp
	return;
  8014e7:	90                   	nop
}
  8014e8:	c9                   	leave  
  8014e9:	c3                   	ret    

008014ea <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8014ea:	55                   	push   %ebp
  8014eb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8014ed:	6a 00                	push   $0x0
  8014ef:	6a 00                	push   $0x0
  8014f1:	6a 00                	push   $0x0
  8014f3:	ff 75 0c             	pushl  0xc(%ebp)
  8014f6:	ff 75 08             	pushl  0x8(%ebp)
  8014f9:	6a 12                	push   $0x12
  8014fb:	e8 17 fe ff ff       	call   801317 <syscall>
  801500:	83 c4 18             	add    $0x18,%esp
	return ;
  801503:	90                   	nop
}
  801504:	c9                   	leave  
  801505:	c3                   	ret    

00801506 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801506:	55                   	push   %ebp
  801507:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801509:	6a 00                	push   $0x0
  80150b:	6a 00                	push   $0x0
  80150d:	6a 00                	push   $0x0
  80150f:	6a 00                	push   $0x0
  801511:	6a 00                	push   $0x0
  801513:	6a 0e                	push   $0xe
  801515:	e8 fd fd ff ff       	call   801317 <syscall>
  80151a:	83 c4 18             	add    $0x18,%esp
}
  80151d:	c9                   	leave  
  80151e:	c3                   	ret    

0080151f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80151f:	55                   	push   %ebp
  801520:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801522:	6a 00                	push   $0x0
  801524:	6a 00                	push   $0x0
  801526:	6a 00                	push   $0x0
  801528:	6a 00                	push   $0x0
  80152a:	ff 75 08             	pushl  0x8(%ebp)
  80152d:	6a 0f                	push   $0xf
  80152f:	e8 e3 fd ff ff       	call   801317 <syscall>
  801534:	83 c4 18             	add    $0x18,%esp
}
  801537:	c9                   	leave  
  801538:	c3                   	ret    

00801539 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801539:	55                   	push   %ebp
  80153a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80153c:	6a 00                	push   $0x0
  80153e:	6a 00                	push   $0x0
  801540:	6a 00                	push   $0x0
  801542:	6a 00                	push   $0x0
  801544:	6a 00                	push   $0x0
  801546:	6a 10                	push   $0x10
  801548:	e8 ca fd ff ff       	call   801317 <syscall>
  80154d:	83 c4 18             	add    $0x18,%esp
}
  801550:	90                   	nop
  801551:	c9                   	leave  
  801552:	c3                   	ret    

00801553 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801553:	55                   	push   %ebp
  801554:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 00                	push   $0x0
  80155e:	6a 00                	push   $0x0
  801560:	6a 14                	push   $0x14
  801562:	e8 b0 fd ff ff       	call   801317 <syscall>
  801567:	83 c4 18             	add    $0x18,%esp
}
  80156a:	90                   	nop
  80156b:	c9                   	leave  
  80156c:	c3                   	ret    

0080156d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80156d:	55                   	push   %ebp
  80156e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801570:	6a 00                	push   $0x0
  801572:	6a 00                	push   $0x0
  801574:	6a 00                	push   $0x0
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	6a 15                	push   $0x15
  80157c:	e8 96 fd ff ff       	call   801317 <syscall>
  801581:	83 c4 18             	add    $0x18,%esp
}
  801584:	90                   	nop
  801585:	c9                   	leave  
  801586:	c3                   	ret    

00801587 <sys_cputc>:


void
sys_cputc(const char c)
{
  801587:	55                   	push   %ebp
  801588:	89 e5                	mov    %esp,%ebp
  80158a:	83 ec 04             	sub    $0x4,%esp
  80158d:	8b 45 08             	mov    0x8(%ebp),%eax
  801590:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801593:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	50                   	push   %eax
  8015a0:	6a 16                	push   $0x16
  8015a2:	e8 70 fd ff ff       	call   801317 <syscall>
  8015a7:	83 c4 18             	add    $0x18,%esp
}
  8015aa:	90                   	nop
  8015ab:	c9                   	leave  
  8015ac:	c3                   	ret    

008015ad <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8015ad:	55                   	push   %ebp
  8015ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	6a 17                	push   $0x17
  8015bc:	e8 56 fd ff ff       	call   801317 <syscall>
  8015c1:	83 c4 18             	add    $0x18,%esp
}
  8015c4:	90                   	nop
  8015c5:	c9                   	leave  
  8015c6:	c3                   	ret    

008015c7 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8015c7:	55                   	push   %ebp
  8015c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8015ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cd:	6a 00                	push   $0x0
  8015cf:	6a 00                	push   $0x0
  8015d1:	6a 00                	push   $0x0
  8015d3:	ff 75 0c             	pushl  0xc(%ebp)
  8015d6:	50                   	push   %eax
  8015d7:	6a 18                	push   $0x18
  8015d9:	e8 39 fd ff ff       	call   801317 <syscall>
  8015de:	83 c4 18             	add    $0x18,%esp
}
  8015e1:	c9                   	leave  
  8015e2:	c3                   	ret    

008015e3 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8015e3:	55                   	push   %ebp
  8015e4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8015e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 00                	push   $0x0
  8015f0:	6a 00                	push   $0x0
  8015f2:	52                   	push   %edx
  8015f3:	50                   	push   %eax
  8015f4:	6a 1b                	push   $0x1b
  8015f6:	e8 1c fd ff ff       	call   801317 <syscall>
  8015fb:	83 c4 18             	add    $0x18,%esp
}
  8015fe:	c9                   	leave  
  8015ff:	c3                   	ret    

00801600 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801600:	55                   	push   %ebp
  801601:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801603:	8b 55 0c             	mov    0xc(%ebp),%edx
  801606:	8b 45 08             	mov    0x8(%ebp),%eax
  801609:	6a 00                	push   $0x0
  80160b:	6a 00                	push   $0x0
  80160d:	6a 00                	push   $0x0
  80160f:	52                   	push   %edx
  801610:	50                   	push   %eax
  801611:	6a 19                	push   $0x19
  801613:	e8 ff fc ff ff       	call   801317 <syscall>
  801618:	83 c4 18             	add    $0x18,%esp
}
  80161b:	90                   	nop
  80161c:	c9                   	leave  
  80161d:	c3                   	ret    

0080161e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80161e:	55                   	push   %ebp
  80161f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801621:	8b 55 0c             	mov    0xc(%ebp),%edx
  801624:	8b 45 08             	mov    0x8(%ebp),%eax
  801627:	6a 00                	push   $0x0
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	52                   	push   %edx
  80162e:	50                   	push   %eax
  80162f:	6a 1a                	push   $0x1a
  801631:	e8 e1 fc ff ff       	call   801317 <syscall>
  801636:	83 c4 18             	add    $0x18,%esp
}
  801639:	90                   	nop
  80163a:	c9                   	leave  
  80163b:	c3                   	ret    

0080163c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80163c:	55                   	push   %ebp
  80163d:	89 e5                	mov    %esp,%ebp
  80163f:	83 ec 04             	sub    $0x4,%esp
  801642:	8b 45 10             	mov    0x10(%ebp),%eax
  801645:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801648:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80164b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80164f:	8b 45 08             	mov    0x8(%ebp),%eax
  801652:	6a 00                	push   $0x0
  801654:	51                   	push   %ecx
  801655:	52                   	push   %edx
  801656:	ff 75 0c             	pushl  0xc(%ebp)
  801659:	50                   	push   %eax
  80165a:	6a 1c                	push   $0x1c
  80165c:	e8 b6 fc ff ff       	call   801317 <syscall>
  801661:	83 c4 18             	add    $0x18,%esp
}
  801664:	c9                   	leave  
  801665:	c3                   	ret    

00801666 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801666:	55                   	push   %ebp
  801667:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801669:	8b 55 0c             	mov    0xc(%ebp),%edx
  80166c:	8b 45 08             	mov    0x8(%ebp),%eax
  80166f:	6a 00                	push   $0x0
  801671:	6a 00                	push   $0x0
  801673:	6a 00                	push   $0x0
  801675:	52                   	push   %edx
  801676:	50                   	push   %eax
  801677:	6a 1d                	push   $0x1d
  801679:	e8 99 fc ff ff       	call   801317 <syscall>
  80167e:	83 c4 18             	add    $0x18,%esp
}
  801681:	c9                   	leave  
  801682:	c3                   	ret    

00801683 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801683:	55                   	push   %ebp
  801684:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801686:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801689:	8b 55 0c             	mov    0xc(%ebp),%edx
  80168c:	8b 45 08             	mov    0x8(%ebp),%eax
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	51                   	push   %ecx
  801694:	52                   	push   %edx
  801695:	50                   	push   %eax
  801696:	6a 1e                	push   $0x1e
  801698:	e8 7a fc ff ff       	call   801317 <syscall>
  80169d:	83 c4 18             	add    $0x18,%esp
}
  8016a0:	c9                   	leave  
  8016a1:	c3                   	ret    

008016a2 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8016a2:	55                   	push   %ebp
  8016a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8016a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 00                	push   $0x0
  8016b1:	52                   	push   %edx
  8016b2:	50                   	push   %eax
  8016b3:	6a 1f                	push   $0x1f
  8016b5:	e8 5d fc ff ff       	call   801317 <syscall>
  8016ba:	83 c4 18             	add    $0x18,%esp
}
  8016bd:	c9                   	leave  
  8016be:	c3                   	ret    

008016bf <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8016bf:	55                   	push   %ebp
  8016c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 00                	push   $0x0
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 20                	push   $0x20
  8016ce:	e8 44 fc ff ff       	call   801317 <syscall>
  8016d3:	83 c4 18             	add    $0x18,%esp
}
  8016d6:	c9                   	leave  
  8016d7:	c3                   	ret    

008016d8 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8016d8:	55                   	push   %ebp
  8016d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8016db:	8b 45 08             	mov    0x8(%ebp),%eax
  8016de:	6a 00                	push   $0x0
  8016e0:	ff 75 14             	pushl  0x14(%ebp)
  8016e3:	ff 75 10             	pushl  0x10(%ebp)
  8016e6:	ff 75 0c             	pushl  0xc(%ebp)
  8016e9:	50                   	push   %eax
  8016ea:	6a 21                	push   $0x21
  8016ec:	e8 26 fc ff ff       	call   801317 <syscall>
  8016f1:	83 c4 18             	add    $0x18,%esp
}
  8016f4:	c9                   	leave  
  8016f5:	c3                   	ret    

008016f6 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8016f6:	55                   	push   %ebp
  8016f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8016f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 00                	push   $0x0
  801700:	6a 00                	push   $0x0
  801702:	6a 00                	push   $0x0
  801704:	50                   	push   %eax
  801705:	6a 22                	push   $0x22
  801707:	e8 0b fc ff ff       	call   801317 <syscall>
  80170c:	83 c4 18             	add    $0x18,%esp
}
  80170f:	90                   	nop
  801710:	c9                   	leave  
  801711:	c3                   	ret    

00801712 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801712:	55                   	push   %ebp
  801713:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801715:	8b 45 08             	mov    0x8(%ebp),%eax
  801718:	6a 00                	push   $0x0
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	6a 00                	push   $0x0
  801720:	50                   	push   %eax
  801721:	6a 23                	push   $0x23
  801723:	e8 ef fb ff ff       	call   801317 <syscall>
  801728:	83 c4 18             	add    $0x18,%esp
}
  80172b:	90                   	nop
  80172c:	c9                   	leave  
  80172d:	c3                   	ret    

0080172e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80172e:	55                   	push   %ebp
  80172f:	89 e5                	mov    %esp,%ebp
  801731:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801734:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801737:	8d 50 04             	lea    0x4(%eax),%edx
  80173a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80173d:	6a 00                	push   $0x0
  80173f:	6a 00                	push   $0x0
  801741:	6a 00                	push   $0x0
  801743:	52                   	push   %edx
  801744:	50                   	push   %eax
  801745:	6a 24                	push   $0x24
  801747:	e8 cb fb ff ff       	call   801317 <syscall>
  80174c:	83 c4 18             	add    $0x18,%esp
	return result;
  80174f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801752:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801755:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801758:	89 01                	mov    %eax,(%ecx)
  80175a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80175d:	8b 45 08             	mov    0x8(%ebp),%eax
  801760:	c9                   	leave  
  801761:	c2 04 00             	ret    $0x4

00801764 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801764:	55                   	push   %ebp
  801765:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	ff 75 10             	pushl  0x10(%ebp)
  80176e:	ff 75 0c             	pushl  0xc(%ebp)
  801771:	ff 75 08             	pushl  0x8(%ebp)
  801774:	6a 13                	push   $0x13
  801776:	e8 9c fb ff ff       	call   801317 <syscall>
  80177b:	83 c4 18             	add    $0x18,%esp
	return ;
  80177e:	90                   	nop
}
  80177f:	c9                   	leave  
  801780:	c3                   	ret    

00801781 <sys_rcr2>:
uint32 sys_rcr2()
{
  801781:	55                   	push   %ebp
  801782:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	6a 00                	push   $0x0
  80178e:	6a 25                	push   $0x25
  801790:	e8 82 fb ff ff       	call   801317 <syscall>
  801795:	83 c4 18             	add    $0x18,%esp
}
  801798:	c9                   	leave  
  801799:	c3                   	ret    

0080179a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80179a:	55                   	push   %ebp
  80179b:	89 e5                	mov    %esp,%ebp
  80179d:	83 ec 04             	sub    $0x4,%esp
  8017a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8017a6:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8017aa:	6a 00                	push   $0x0
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	50                   	push   %eax
  8017b3:	6a 26                	push   $0x26
  8017b5:	e8 5d fb ff ff       	call   801317 <syscall>
  8017ba:	83 c4 18             	add    $0x18,%esp
	return ;
  8017bd:	90                   	nop
}
  8017be:	c9                   	leave  
  8017bf:	c3                   	ret    

008017c0 <rsttst>:
void rsttst()
{
  8017c0:	55                   	push   %ebp
  8017c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 28                	push   $0x28
  8017cf:	e8 43 fb ff ff       	call   801317 <syscall>
  8017d4:	83 c4 18             	add    $0x18,%esp
	return ;
  8017d7:	90                   	nop
}
  8017d8:	c9                   	leave  
  8017d9:	c3                   	ret    

008017da <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8017da:	55                   	push   %ebp
  8017db:	89 e5                	mov    %esp,%ebp
  8017dd:	83 ec 04             	sub    $0x4,%esp
  8017e0:	8b 45 14             	mov    0x14(%ebp),%eax
  8017e3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8017e6:	8b 55 18             	mov    0x18(%ebp),%edx
  8017e9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017ed:	52                   	push   %edx
  8017ee:	50                   	push   %eax
  8017ef:	ff 75 10             	pushl  0x10(%ebp)
  8017f2:	ff 75 0c             	pushl  0xc(%ebp)
  8017f5:	ff 75 08             	pushl  0x8(%ebp)
  8017f8:	6a 27                	push   $0x27
  8017fa:	e8 18 fb ff ff       	call   801317 <syscall>
  8017ff:	83 c4 18             	add    $0x18,%esp
	return ;
  801802:	90                   	nop
}
  801803:	c9                   	leave  
  801804:	c3                   	ret    

00801805 <chktst>:
void chktst(uint32 n)
{
  801805:	55                   	push   %ebp
  801806:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801808:	6a 00                	push   $0x0
  80180a:	6a 00                	push   $0x0
  80180c:	6a 00                	push   $0x0
  80180e:	6a 00                	push   $0x0
  801810:	ff 75 08             	pushl  0x8(%ebp)
  801813:	6a 29                	push   $0x29
  801815:	e8 fd fa ff ff       	call   801317 <syscall>
  80181a:	83 c4 18             	add    $0x18,%esp
	return ;
  80181d:	90                   	nop
}
  80181e:	c9                   	leave  
  80181f:	c3                   	ret    

00801820 <inctst>:

void inctst()
{
  801820:	55                   	push   %ebp
  801821:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801823:	6a 00                	push   $0x0
  801825:	6a 00                	push   $0x0
  801827:	6a 00                	push   $0x0
  801829:	6a 00                	push   $0x0
  80182b:	6a 00                	push   $0x0
  80182d:	6a 2a                	push   $0x2a
  80182f:	e8 e3 fa ff ff       	call   801317 <syscall>
  801834:	83 c4 18             	add    $0x18,%esp
	return ;
  801837:	90                   	nop
}
  801838:	c9                   	leave  
  801839:	c3                   	ret    

0080183a <gettst>:
uint32 gettst()
{
  80183a:	55                   	push   %ebp
  80183b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	6a 00                	push   $0x0
  801847:	6a 2b                	push   $0x2b
  801849:	e8 c9 fa ff ff       	call   801317 <syscall>
  80184e:	83 c4 18             	add    $0x18,%esp
}
  801851:	c9                   	leave  
  801852:	c3                   	ret    

00801853 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
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
  801865:	e8 ad fa ff ff       	call   801317 <syscall>
  80186a:	83 c4 18             	add    $0x18,%esp
  80186d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801870:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801874:	75 07                	jne    80187d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801876:	b8 01 00 00 00       	mov    $0x1,%eax
  80187b:	eb 05                	jmp    801882 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80187d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801882:	c9                   	leave  
  801883:	c3                   	ret    

00801884 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801884:	55                   	push   %ebp
  801885:	89 e5                	mov    %esp,%ebp
  801887:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	6a 2c                	push   $0x2c
  801896:	e8 7c fa ff ff       	call   801317 <syscall>
  80189b:	83 c4 18             	add    $0x18,%esp
  80189e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8018a1:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8018a5:	75 07                	jne    8018ae <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8018a7:	b8 01 00 00 00       	mov    $0x1,%eax
  8018ac:	eb 05                	jmp    8018b3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8018ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018b3:	c9                   	leave  
  8018b4:	c3                   	ret    

008018b5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8018b5:	55                   	push   %ebp
  8018b6:	89 e5                	mov    %esp,%ebp
  8018b8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 2c                	push   $0x2c
  8018c7:	e8 4b fa ff ff       	call   801317 <syscall>
  8018cc:	83 c4 18             	add    $0x18,%esp
  8018cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8018d2:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8018d6:	75 07                	jne    8018df <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8018d8:	b8 01 00 00 00       	mov    $0x1,%eax
  8018dd:	eb 05                	jmp    8018e4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8018df:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018e4:	c9                   	leave  
  8018e5:	c3                   	ret    

008018e6 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8018e6:	55                   	push   %ebp
  8018e7:	89 e5                	mov    %esp,%ebp
  8018e9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8018ec:	6a 00                	push   $0x0
  8018ee:	6a 00                	push   $0x0
  8018f0:	6a 00                	push   $0x0
  8018f2:	6a 00                	push   $0x0
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 2c                	push   $0x2c
  8018f8:	e8 1a fa ff ff       	call   801317 <syscall>
  8018fd:	83 c4 18             	add    $0x18,%esp
  801900:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801903:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801907:	75 07                	jne    801910 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801909:	b8 01 00 00 00       	mov    $0x1,%eax
  80190e:	eb 05                	jmp    801915 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801910:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801915:	c9                   	leave  
  801916:	c3                   	ret    

00801917 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801917:	55                   	push   %ebp
  801918:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80191a:	6a 00                	push   $0x0
  80191c:	6a 00                	push   $0x0
  80191e:	6a 00                	push   $0x0
  801920:	6a 00                	push   $0x0
  801922:	ff 75 08             	pushl  0x8(%ebp)
  801925:	6a 2d                	push   $0x2d
  801927:	e8 eb f9 ff ff       	call   801317 <syscall>
  80192c:	83 c4 18             	add    $0x18,%esp
	return ;
  80192f:	90                   	nop
}
  801930:	c9                   	leave  
  801931:	c3                   	ret    

00801932 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801932:	55                   	push   %ebp
  801933:	89 e5                	mov    %esp,%ebp
  801935:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801936:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801939:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80193c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80193f:	8b 45 08             	mov    0x8(%ebp),%eax
  801942:	6a 00                	push   $0x0
  801944:	53                   	push   %ebx
  801945:	51                   	push   %ecx
  801946:	52                   	push   %edx
  801947:	50                   	push   %eax
  801948:	6a 2e                	push   $0x2e
  80194a:	e8 c8 f9 ff ff       	call   801317 <syscall>
  80194f:	83 c4 18             	add    $0x18,%esp
}
  801952:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801955:	c9                   	leave  
  801956:	c3                   	ret    

00801957 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801957:	55                   	push   %ebp
  801958:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80195a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80195d:	8b 45 08             	mov    0x8(%ebp),%eax
  801960:	6a 00                	push   $0x0
  801962:	6a 00                	push   $0x0
  801964:	6a 00                	push   $0x0
  801966:	52                   	push   %edx
  801967:	50                   	push   %eax
  801968:	6a 2f                	push   $0x2f
  80196a:	e8 a8 f9 ff ff       	call   801317 <syscall>
  80196f:	83 c4 18             	add    $0x18,%esp
}
  801972:	c9                   	leave  
  801973:	c3                   	ret    

00801974 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801974:	55                   	push   %ebp
  801975:	89 e5                	mov    %esp,%ebp
  801977:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  80197a:	8b 55 08             	mov    0x8(%ebp),%edx
  80197d:	89 d0                	mov    %edx,%eax
  80197f:	c1 e0 02             	shl    $0x2,%eax
  801982:	01 d0                	add    %edx,%eax
  801984:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80198b:	01 d0                	add    %edx,%eax
  80198d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801994:	01 d0                	add    %edx,%eax
  801996:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80199d:	01 d0                	add    %edx,%eax
  80199f:	c1 e0 04             	shl    $0x4,%eax
  8019a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8019a5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8019ac:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8019af:	83 ec 0c             	sub    $0xc,%esp
  8019b2:	50                   	push   %eax
  8019b3:	e8 76 fd ff ff       	call   80172e <sys_get_virtual_time>
  8019b8:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8019bb:	eb 41                	jmp    8019fe <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8019bd:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8019c0:	83 ec 0c             	sub    $0xc,%esp
  8019c3:	50                   	push   %eax
  8019c4:	e8 65 fd ff ff       	call   80172e <sys_get_virtual_time>
  8019c9:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8019cc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8019cf:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8019d2:	29 c2                	sub    %eax,%edx
  8019d4:	89 d0                	mov    %edx,%eax
  8019d6:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8019d9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8019dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8019df:	89 d1                	mov    %edx,%ecx
  8019e1:	29 c1                	sub    %eax,%ecx
  8019e3:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8019e6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8019e9:	39 c2                	cmp    %eax,%edx
  8019eb:	0f 97 c0             	seta   %al
  8019ee:	0f b6 c0             	movzbl %al,%eax
  8019f1:	29 c1                	sub    %eax,%ecx
  8019f3:	89 c8                	mov    %ecx,%eax
  8019f5:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  8019f8:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8019fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  8019fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a01:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a04:	72 b7                	jb     8019bd <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801a06:	90                   	nop
  801a07:	c9                   	leave  
  801a08:	c3                   	ret    

00801a09 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801a09:	55                   	push   %ebp
  801a0a:	89 e5                	mov    %esp,%ebp
  801a0c:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801a0f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801a16:	eb 03                	jmp    801a1b <busy_wait+0x12>
  801a18:	ff 45 fc             	incl   -0x4(%ebp)
  801a1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a1e:	3b 45 08             	cmp    0x8(%ebp),%eax
  801a21:	72 f5                	jb     801a18 <busy_wait+0xf>
	return i;
  801a23:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801a26:	c9                   	leave  
  801a27:	c3                   	ret    

00801a28 <__udivdi3>:
  801a28:	55                   	push   %ebp
  801a29:	57                   	push   %edi
  801a2a:	56                   	push   %esi
  801a2b:	53                   	push   %ebx
  801a2c:	83 ec 1c             	sub    $0x1c,%esp
  801a2f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a33:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a37:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a3b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a3f:	89 ca                	mov    %ecx,%edx
  801a41:	89 f8                	mov    %edi,%eax
  801a43:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a47:	85 f6                	test   %esi,%esi
  801a49:	75 2d                	jne    801a78 <__udivdi3+0x50>
  801a4b:	39 cf                	cmp    %ecx,%edi
  801a4d:	77 65                	ja     801ab4 <__udivdi3+0x8c>
  801a4f:	89 fd                	mov    %edi,%ebp
  801a51:	85 ff                	test   %edi,%edi
  801a53:	75 0b                	jne    801a60 <__udivdi3+0x38>
  801a55:	b8 01 00 00 00       	mov    $0x1,%eax
  801a5a:	31 d2                	xor    %edx,%edx
  801a5c:	f7 f7                	div    %edi
  801a5e:	89 c5                	mov    %eax,%ebp
  801a60:	31 d2                	xor    %edx,%edx
  801a62:	89 c8                	mov    %ecx,%eax
  801a64:	f7 f5                	div    %ebp
  801a66:	89 c1                	mov    %eax,%ecx
  801a68:	89 d8                	mov    %ebx,%eax
  801a6a:	f7 f5                	div    %ebp
  801a6c:	89 cf                	mov    %ecx,%edi
  801a6e:	89 fa                	mov    %edi,%edx
  801a70:	83 c4 1c             	add    $0x1c,%esp
  801a73:	5b                   	pop    %ebx
  801a74:	5e                   	pop    %esi
  801a75:	5f                   	pop    %edi
  801a76:	5d                   	pop    %ebp
  801a77:	c3                   	ret    
  801a78:	39 ce                	cmp    %ecx,%esi
  801a7a:	77 28                	ja     801aa4 <__udivdi3+0x7c>
  801a7c:	0f bd fe             	bsr    %esi,%edi
  801a7f:	83 f7 1f             	xor    $0x1f,%edi
  801a82:	75 40                	jne    801ac4 <__udivdi3+0x9c>
  801a84:	39 ce                	cmp    %ecx,%esi
  801a86:	72 0a                	jb     801a92 <__udivdi3+0x6a>
  801a88:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a8c:	0f 87 9e 00 00 00    	ja     801b30 <__udivdi3+0x108>
  801a92:	b8 01 00 00 00       	mov    $0x1,%eax
  801a97:	89 fa                	mov    %edi,%edx
  801a99:	83 c4 1c             	add    $0x1c,%esp
  801a9c:	5b                   	pop    %ebx
  801a9d:	5e                   	pop    %esi
  801a9e:	5f                   	pop    %edi
  801a9f:	5d                   	pop    %ebp
  801aa0:	c3                   	ret    
  801aa1:	8d 76 00             	lea    0x0(%esi),%esi
  801aa4:	31 ff                	xor    %edi,%edi
  801aa6:	31 c0                	xor    %eax,%eax
  801aa8:	89 fa                	mov    %edi,%edx
  801aaa:	83 c4 1c             	add    $0x1c,%esp
  801aad:	5b                   	pop    %ebx
  801aae:	5e                   	pop    %esi
  801aaf:	5f                   	pop    %edi
  801ab0:	5d                   	pop    %ebp
  801ab1:	c3                   	ret    
  801ab2:	66 90                	xchg   %ax,%ax
  801ab4:	89 d8                	mov    %ebx,%eax
  801ab6:	f7 f7                	div    %edi
  801ab8:	31 ff                	xor    %edi,%edi
  801aba:	89 fa                	mov    %edi,%edx
  801abc:	83 c4 1c             	add    $0x1c,%esp
  801abf:	5b                   	pop    %ebx
  801ac0:	5e                   	pop    %esi
  801ac1:	5f                   	pop    %edi
  801ac2:	5d                   	pop    %ebp
  801ac3:	c3                   	ret    
  801ac4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ac9:	89 eb                	mov    %ebp,%ebx
  801acb:	29 fb                	sub    %edi,%ebx
  801acd:	89 f9                	mov    %edi,%ecx
  801acf:	d3 e6                	shl    %cl,%esi
  801ad1:	89 c5                	mov    %eax,%ebp
  801ad3:	88 d9                	mov    %bl,%cl
  801ad5:	d3 ed                	shr    %cl,%ebp
  801ad7:	89 e9                	mov    %ebp,%ecx
  801ad9:	09 f1                	or     %esi,%ecx
  801adb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801adf:	89 f9                	mov    %edi,%ecx
  801ae1:	d3 e0                	shl    %cl,%eax
  801ae3:	89 c5                	mov    %eax,%ebp
  801ae5:	89 d6                	mov    %edx,%esi
  801ae7:	88 d9                	mov    %bl,%cl
  801ae9:	d3 ee                	shr    %cl,%esi
  801aeb:	89 f9                	mov    %edi,%ecx
  801aed:	d3 e2                	shl    %cl,%edx
  801aef:	8b 44 24 08          	mov    0x8(%esp),%eax
  801af3:	88 d9                	mov    %bl,%cl
  801af5:	d3 e8                	shr    %cl,%eax
  801af7:	09 c2                	or     %eax,%edx
  801af9:	89 d0                	mov    %edx,%eax
  801afb:	89 f2                	mov    %esi,%edx
  801afd:	f7 74 24 0c          	divl   0xc(%esp)
  801b01:	89 d6                	mov    %edx,%esi
  801b03:	89 c3                	mov    %eax,%ebx
  801b05:	f7 e5                	mul    %ebp
  801b07:	39 d6                	cmp    %edx,%esi
  801b09:	72 19                	jb     801b24 <__udivdi3+0xfc>
  801b0b:	74 0b                	je     801b18 <__udivdi3+0xf0>
  801b0d:	89 d8                	mov    %ebx,%eax
  801b0f:	31 ff                	xor    %edi,%edi
  801b11:	e9 58 ff ff ff       	jmp    801a6e <__udivdi3+0x46>
  801b16:	66 90                	xchg   %ax,%ax
  801b18:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b1c:	89 f9                	mov    %edi,%ecx
  801b1e:	d3 e2                	shl    %cl,%edx
  801b20:	39 c2                	cmp    %eax,%edx
  801b22:	73 e9                	jae    801b0d <__udivdi3+0xe5>
  801b24:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b27:	31 ff                	xor    %edi,%edi
  801b29:	e9 40 ff ff ff       	jmp    801a6e <__udivdi3+0x46>
  801b2e:	66 90                	xchg   %ax,%ax
  801b30:	31 c0                	xor    %eax,%eax
  801b32:	e9 37 ff ff ff       	jmp    801a6e <__udivdi3+0x46>
  801b37:	90                   	nop

00801b38 <__umoddi3>:
  801b38:	55                   	push   %ebp
  801b39:	57                   	push   %edi
  801b3a:	56                   	push   %esi
  801b3b:	53                   	push   %ebx
  801b3c:	83 ec 1c             	sub    $0x1c,%esp
  801b3f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b43:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b47:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b4b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b4f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b53:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b57:	89 f3                	mov    %esi,%ebx
  801b59:	89 fa                	mov    %edi,%edx
  801b5b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b5f:	89 34 24             	mov    %esi,(%esp)
  801b62:	85 c0                	test   %eax,%eax
  801b64:	75 1a                	jne    801b80 <__umoddi3+0x48>
  801b66:	39 f7                	cmp    %esi,%edi
  801b68:	0f 86 a2 00 00 00    	jbe    801c10 <__umoddi3+0xd8>
  801b6e:	89 c8                	mov    %ecx,%eax
  801b70:	89 f2                	mov    %esi,%edx
  801b72:	f7 f7                	div    %edi
  801b74:	89 d0                	mov    %edx,%eax
  801b76:	31 d2                	xor    %edx,%edx
  801b78:	83 c4 1c             	add    $0x1c,%esp
  801b7b:	5b                   	pop    %ebx
  801b7c:	5e                   	pop    %esi
  801b7d:	5f                   	pop    %edi
  801b7e:	5d                   	pop    %ebp
  801b7f:	c3                   	ret    
  801b80:	39 f0                	cmp    %esi,%eax
  801b82:	0f 87 ac 00 00 00    	ja     801c34 <__umoddi3+0xfc>
  801b88:	0f bd e8             	bsr    %eax,%ebp
  801b8b:	83 f5 1f             	xor    $0x1f,%ebp
  801b8e:	0f 84 ac 00 00 00    	je     801c40 <__umoddi3+0x108>
  801b94:	bf 20 00 00 00       	mov    $0x20,%edi
  801b99:	29 ef                	sub    %ebp,%edi
  801b9b:	89 fe                	mov    %edi,%esi
  801b9d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ba1:	89 e9                	mov    %ebp,%ecx
  801ba3:	d3 e0                	shl    %cl,%eax
  801ba5:	89 d7                	mov    %edx,%edi
  801ba7:	89 f1                	mov    %esi,%ecx
  801ba9:	d3 ef                	shr    %cl,%edi
  801bab:	09 c7                	or     %eax,%edi
  801bad:	89 e9                	mov    %ebp,%ecx
  801baf:	d3 e2                	shl    %cl,%edx
  801bb1:	89 14 24             	mov    %edx,(%esp)
  801bb4:	89 d8                	mov    %ebx,%eax
  801bb6:	d3 e0                	shl    %cl,%eax
  801bb8:	89 c2                	mov    %eax,%edx
  801bba:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bbe:	d3 e0                	shl    %cl,%eax
  801bc0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bc4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bc8:	89 f1                	mov    %esi,%ecx
  801bca:	d3 e8                	shr    %cl,%eax
  801bcc:	09 d0                	or     %edx,%eax
  801bce:	d3 eb                	shr    %cl,%ebx
  801bd0:	89 da                	mov    %ebx,%edx
  801bd2:	f7 f7                	div    %edi
  801bd4:	89 d3                	mov    %edx,%ebx
  801bd6:	f7 24 24             	mull   (%esp)
  801bd9:	89 c6                	mov    %eax,%esi
  801bdb:	89 d1                	mov    %edx,%ecx
  801bdd:	39 d3                	cmp    %edx,%ebx
  801bdf:	0f 82 87 00 00 00    	jb     801c6c <__umoddi3+0x134>
  801be5:	0f 84 91 00 00 00    	je     801c7c <__umoddi3+0x144>
  801beb:	8b 54 24 04          	mov    0x4(%esp),%edx
  801bef:	29 f2                	sub    %esi,%edx
  801bf1:	19 cb                	sbb    %ecx,%ebx
  801bf3:	89 d8                	mov    %ebx,%eax
  801bf5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801bf9:	d3 e0                	shl    %cl,%eax
  801bfb:	89 e9                	mov    %ebp,%ecx
  801bfd:	d3 ea                	shr    %cl,%edx
  801bff:	09 d0                	or     %edx,%eax
  801c01:	89 e9                	mov    %ebp,%ecx
  801c03:	d3 eb                	shr    %cl,%ebx
  801c05:	89 da                	mov    %ebx,%edx
  801c07:	83 c4 1c             	add    $0x1c,%esp
  801c0a:	5b                   	pop    %ebx
  801c0b:	5e                   	pop    %esi
  801c0c:	5f                   	pop    %edi
  801c0d:	5d                   	pop    %ebp
  801c0e:	c3                   	ret    
  801c0f:	90                   	nop
  801c10:	89 fd                	mov    %edi,%ebp
  801c12:	85 ff                	test   %edi,%edi
  801c14:	75 0b                	jne    801c21 <__umoddi3+0xe9>
  801c16:	b8 01 00 00 00       	mov    $0x1,%eax
  801c1b:	31 d2                	xor    %edx,%edx
  801c1d:	f7 f7                	div    %edi
  801c1f:	89 c5                	mov    %eax,%ebp
  801c21:	89 f0                	mov    %esi,%eax
  801c23:	31 d2                	xor    %edx,%edx
  801c25:	f7 f5                	div    %ebp
  801c27:	89 c8                	mov    %ecx,%eax
  801c29:	f7 f5                	div    %ebp
  801c2b:	89 d0                	mov    %edx,%eax
  801c2d:	e9 44 ff ff ff       	jmp    801b76 <__umoddi3+0x3e>
  801c32:	66 90                	xchg   %ax,%ax
  801c34:	89 c8                	mov    %ecx,%eax
  801c36:	89 f2                	mov    %esi,%edx
  801c38:	83 c4 1c             	add    $0x1c,%esp
  801c3b:	5b                   	pop    %ebx
  801c3c:	5e                   	pop    %esi
  801c3d:	5f                   	pop    %edi
  801c3e:	5d                   	pop    %ebp
  801c3f:	c3                   	ret    
  801c40:	3b 04 24             	cmp    (%esp),%eax
  801c43:	72 06                	jb     801c4b <__umoddi3+0x113>
  801c45:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c49:	77 0f                	ja     801c5a <__umoddi3+0x122>
  801c4b:	89 f2                	mov    %esi,%edx
  801c4d:	29 f9                	sub    %edi,%ecx
  801c4f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c53:	89 14 24             	mov    %edx,(%esp)
  801c56:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c5a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c5e:	8b 14 24             	mov    (%esp),%edx
  801c61:	83 c4 1c             	add    $0x1c,%esp
  801c64:	5b                   	pop    %ebx
  801c65:	5e                   	pop    %esi
  801c66:	5f                   	pop    %edi
  801c67:	5d                   	pop    %ebp
  801c68:	c3                   	ret    
  801c69:	8d 76 00             	lea    0x0(%esi),%esi
  801c6c:	2b 04 24             	sub    (%esp),%eax
  801c6f:	19 fa                	sbb    %edi,%edx
  801c71:	89 d1                	mov    %edx,%ecx
  801c73:	89 c6                	mov    %eax,%esi
  801c75:	e9 71 ff ff ff       	jmp    801beb <__umoddi3+0xb3>
  801c7a:	66 90                	xchg   %ax,%ax
  801c7c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c80:	72 ea                	jb     801c6c <__umoddi3+0x134>
  801c82:	89 d9                	mov    %ebx,%ecx
  801c84:	e9 62 ff ff ff       	jmp    801beb <__umoddi3+0xb3>
