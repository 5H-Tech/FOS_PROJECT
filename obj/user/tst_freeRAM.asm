
obj/user/tst_freeRAM:     file format elf32-i386


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
  800031:	e8 4b 14 00 00       	call   801481 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

char arr[PAGE_SIZE*12];
uint32 WSEntries_before[1000];

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 8c 01 00 00    	sub    $0x18c,%esp
	vcprintf("\n\n===============================================================\n", NULL);
  800044:	83 ec 08             	sub    $0x8,%esp
  800047:	6a 00                	push   $0x0
  800049:	68 80 2f 80 00       	push   $0x802f80
  80004e:	e8 aa 17 00 00       	call   8017fd <vcprintf>
  800053:	83 c4 10             	add    $0x10,%esp
	vcprintf("MAKE SURE to have a FRESH RUN for EACH SCENARIO of this test\n(i.e. don't run any program/test/multiple scenarios before it)\n", NULL);
  800056:	83 ec 08             	sub    $0x8,%esp
  800059:	6a 00                	push   $0x0
  80005b:	68 c4 2f 80 00       	push   $0x802fc4
  800060:	e8 98 17 00 00       	call   8017fd <vcprintf>
  800065:	83 c4 10             	add    $0x10,%esp
	vcprintf("===============================================================\n\n\n", NULL);
  800068:	83 ec 08             	sub    $0x8,%esp
  80006b:	6a 00                	push   $0x0
  80006d:	68 44 30 80 00       	push   $0x803044
  800072:	e8 86 17 00 00       	call   8017fd <vcprintf>
  800077:	83 c4 10             	add    $0x10,%esp

	uint32 testCase;
	if (myEnv->page_WS_max_size == 1000)
  80007a:	a1 20 40 80 00       	mov    0x804020,%eax
  80007f:	8b 40 74             	mov    0x74(%eax),%eax
  800082:	3d e8 03 00 00       	cmp    $0x3e8,%eax
  800087:	75 09                	jne    800092 <_main+0x5a>
	{
		//EVALUATION [40%]
		testCase = 1 ;
  800089:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  800090:	eb 2a                	jmp    8000bc <_main+0x84>
	}
	else if (myEnv->page_WS_max_size == 10)
  800092:	a1 20 40 80 00       	mov    0x804020,%eax
  800097:	8b 40 74             	mov    0x74(%eax),%eax
  80009a:	83 f8 0a             	cmp    $0xa,%eax
  80009d:	75 09                	jne    8000a8 <_main+0x70>
	{
		//EVALUATION [30%]
		testCase = 2 ;
  80009f:	c7 45 e4 02 00 00 00 	movl   $0x2,-0x1c(%ebp)
  8000a6:	eb 14                	jmp    8000bc <_main+0x84>
	}
	else if (myEnv->page_WS_max_size == 26)
  8000a8:	a1 20 40 80 00       	mov    0x804020,%eax
  8000ad:	8b 40 74             	mov    0x74(%eax),%eax
  8000b0:	83 f8 1a             	cmp    $0x1a,%eax
  8000b3:	75 07                	jne    8000bc <_main+0x84>
	{
		//EVALUATION [30%]
		testCase = 3 ;
  8000b5:	c7 45 e4 03 00 00 00 	movl   $0x3,-0x1c(%ebp)
	}
	int32 envIdFib, envIdHelloWorld, helloWorldFrames;
	{
		//CASE1: free the exited env only
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
  8000bc:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  8000c0:	74 0a                	je     8000cc <_main+0x94>
  8000c2:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8000c6:	0f 85 66 01 00 00    	jne    800232 <_main+0x1fa>
		{
			//Load "fib" & "fos_helloWorld" programs into RAM
			cprintf("Loading Fib & fos_helloWorld programs into RAM...");
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	68 88 30 80 00       	push   $0x803088
  8000d4:	e8 8f 17 00 00       	call   801868 <cprintf>
  8000d9:	83 c4 10             	add    $0x10,%esp
			envIdFib = sys_create_env("fib", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000dc:	a1 20 40 80 00       	mov    0x804020,%eax
  8000e1:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8000e7:	a1 20 40 80 00       	mov    0x804020,%eax
  8000ec:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000f2:	89 c1                	mov    %eax,%ecx
  8000f4:	a1 20 40 80 00       	mov    0x804020,%eax
  8000f9:	8b 40 74             	mov    0x74(%eax),%eax
  8000fc:	52                   	push   %edx
  8000fd:	51                   	push   %ecx
  8000fe:	50                   	push   %eax
  8000ff:	68 ba 30 80 00       	push   $0x8030ba
  800104:	e8 aa 28 00 00       	call   8029b3 <sys_create_env>
  800109:	83 c4 10             	add    $0x10,%esp
  80010c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			int freeFrames = sys_calculate_free_frames() ;
  80010f:	e8 4a 26 00 00       	call   80275e <sys_calculate_free_frames>
  800114:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
			envIdHelloWorld = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  80011a:	a1 20 40 80 00       	mov    0x804020,%eax
  80011f:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  800125:	a1 20 40 80 00       	mov    0x804020,%eax
  80012a:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800130:	89 c1                	mov    %eax,%ecx
  800132:	a1 20 40 80 00       	mov    0x804020,%eax
  800137:	8b 40 74             	mov    0x74(%eax),%eax
  80013a:	52                   	push   %edx
  80013b:	51                   	push   %ecx
  80013c:	50                   	push   %eax
  80013d:	68 be 30 80 00       	push   $0x8030be
  800142:	e8 6c 28 00 00       	call   8029b3 <sys_create_env>
  800147:	83 c4 10             	add    $0x10,%esp
  80014a:	89 45 dc             	mov    %eax,-0x24(%ebp)
			helloWorldFrames = freeFrames - sys_calculate_free_frames() ;
  80014d:	8b 9d 7c ff ff ff    	mov    -0x84(%ebp),%ebx
  800153:	e8 06 26 00 00       	call   80275e <sys_calculate_free_frames>
  800158:	29 c3                	sub    %eax,%ebx
  80015a:	89 d8                	mov    %ebx,%eax
  80015c:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
			env_sleep(2000);
  800162:	83 ec 0c             	sub    $0xc,%esp
  800165:	68 d0 07 00 00       	push   $0x7d0
  80016a:	e8 e0 2a 00 00       	call   802c4f <env_sleep>
  80016f:	83 c4 10             	add    $0x10,%esp
			vcprintf("[DONE]\n\n", NULL);
  800172:	83 ec 08             	sub    $0x8,%esp
  800175:	6a 00                	push   $0x0
  800177:	68 cd 30 80 00       	push   $0x8030cd
  80017c:	e8 7c 16 00 00       	call   8017fd <vcprintf>
  800181:	83 c4 10             	add    $0x10,%esp

			//Load and run "fos_add"
			cprintf("Loading fos_add program into RAM...");
  800184:	83 ec 0c             	sub    $0xc,%esp
  800187:	68 d8 30 80 00       	push   $0x8030d8
  80018c:	e8 d7 16 00 00       	call   801868 <cprintf>
  800191:	83 c4 10             	add    $0x10,%esp
			int32 envIdFOSAdd= sys_create_env("fos_add", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  800194:	a1 20 40 80 00       	mov    0x804020,%eax
  800199:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  80019f:	a1 20 40 80 00       	mov    0x804020,%eax
  8001a4:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8001aa:	89 c1                	mov    %eax,%ecx
  8001ac:	a1 20 40 80 00       	mov    0x804020,%eax
  8001b1:	8b 40 74             	mov    0x74(%eax),%eax
  8001b4:	52                   	push   %edx
  8001b5:	51                   	push   %ecx
  8001b6:	50                   	push   %eax
  8001b7:	68 fc 30 80 00       	push   $0x8030fc
  8001bc:	e8 f2 27 00 00       	call   8029b3 <sys_create_env>
  8001c1:	83 c4 10             	add    $0x10,%esp
  8001c4:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
			env_sleep(2000);
  8001ca:	83 ec 0c             	sub    $0xc,%esp
  8001cd:	68 d0 07 00 00       	push   $0x7d0
  8001d2:	e8 78 2a 00 00       	call   802c4f <env_sleep>
  8001d7:	83 c4 10             	add    $0x10,%esp
			vcprintf("[DONE]\n\n", NULL);
  8001da:	83 ec 08             	sub    $0x8,%esp
  8001dd:	6a 00                	push   $0x0
  8001df:	68 cd 30 80 00       	push   $0x8030cd
  8001e4:	e8 14 16 00 00       	call   8017fd <vcprintf>
  8001e9:	83 c4 10             	add    $0x10,%esp

			cprintf("running fos_add program...\n\n");
  8001ec:	83 ec 0c             	sub    $0xc,%esp
  8001ef:	68 04 31 80 00       	push   $0x803104
  8001f4:	e8 6f 16 00 00       	call   801868 <cprintf>
  8001f9:	83 c4 10             	add    $0x10,%esp
			sys_run_env(envIdFOSAdd);
  8001fc:	83 ec 0c             	sub    $0xc,%esp
  8001ff:	ff b5 74 ff ff ff    	pushl  -0x8c(%ebp)
  800205:	e8 c7 27 00 00       	call   8029d1 <sys_run_env>
  80020a:	83 c4 10             	add    $0x10,%esp

			cprintf("please be patient ...\n");
  80020d:	83 ec 0c             	sub    $0xc,%esp
  800210:	68 21 31 80 00       	push   $0x803121
  800215:	e8 4e 16 00 00       	call   801868 <cprintf>
  80021a:	83 c4 10             	add    $0x10,%esp
			env_sleep(5000);
  80021d:	83 ec 0c             	sub    $0xc,%esp
  800220:	68 88 13 00 00       	push   $0x1388
  800225:	e8 25 2a 00 00       	call   802c4f <env_sleep>
  80022a:	83 c4 10             	add    $0x10,%esp
	int32 envIdFib, envIdHelloWorld, helloWorldFrames;
	{
		//CASE1: free the exited env only
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
		{
  80022d:	e9 49 02 00 00       	jmp    80047b <_main+0x443>
				if( myEnv->page_last_WS_index !=  0)  										panic("InitialWSError2: INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
			}
		}
		 */
		//CASE2: free the WS ONLY using FIFO algorithm
		else if (testCase == 2)
  800232:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  800236:	0f 85 3f 02 00 00    	jne    80047b <_main+0x443>
		{
			//("STEP 0: checking InitialWSError2: INITIAL WS entries ...\n");
			{
				if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x804000)  	panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80023c:	a1 20 40 80 00       	mov    0x804020,%eax
  800241:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800247:	8b 00                	mov    (%eax),%eax
  800249:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  80024c:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80024f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800254:	3d 00 40 80 00       	cmp    $0x804000,%eax
  800259:	74 14                	je     80026f <_main+0x237>
  80025b:	83 ec 04             	sub    $0x4,%esp
  80025e:	68 38 31 80 00       	push   $0x803138
  800263:	6a 57                	push   $0x57
  800265:	68 8a 31 80 00       	push   $0x80318a
  80026a:	e8 57 13 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80026f:	a1 20 40 80 00       	mov    0x804020,%eax
  800274:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80027a:	83 c0 10             	add    $0x10,%eax
  80027d:	8b 00                	mov    (%eax),%eax
  80027f:	89 45 a0             	mov    %eax,-0x60(%ebp)
  800282:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800285:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80028a:	3d 00 10 20 00       	cmp    $0x201000,%eax
  80028f:	74 14                	je     8002a5 <_main+0x26d>
  800291:	83 ec 04             	sub    $0x4,%esp
  800294:	68 38 31 80 00       	push   $0x803138
  800299:	6a 58                	push   $0x58
  80029b:	68 8a 31 80 00       	push   $0x80318a
  8002a0:	e8 21 13 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8002a5:	a1 20 40 80 00       	mov    0x804020,%eax
  8002aa:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002b0:	83 c0 20             	add    $0x20,%eax
  8002b3:	8b 00                	mov    (%eax),%eax
  8002b5:	89 45 9c             	mov    %eax,-0x64(%ebp)
  8002b8:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8002bb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002c0:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8002c5:	74 14                	je     8002db <_main+0x2a3>
  8002c7:	83 ec 04             	sub    $0x4,%esp
  8002ca:	68 38 31 80 00       	push   $0x803138
  8002cf:	6a 59                	push   $0x59
  8002d1:	68 8a 31 80 00       	push   $0x80318a
  8002d6:	e8 eb 12 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8002db:	a1 20 40 80 00       	mov    0x804020,%eax
  8002e0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002e6:	83 c0 30             	add    $0x30,%eax
  8002e9:	8b 00                	mov    (%eax),%eax
  8002eb:	89 45 98             	mov    %eax,-0x68(%ebp)
  8002ee:	8b 45 98             	mov    -0x68(%ebp),%eax
  8002f1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002f6:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8002fb:	74 14                	je     800311 <_main+0x2d9>
  8002fd:	83 ec 04             	sub    $0x4,%esp
  800300:	68 38 31 80 00       	push   $0x803138
  800305:	6a 5a                	push   $0x5a
  800307:	68 8a 31 80 00       	push   $0x80318a
  80030c:	e8 b5 12 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800311:	a1 20 40 80 00       	mov    0x804020,%eax
  800316:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80031c:	83 c0 40             	add    $0x40,%eax
  80031f:	8b 00                	mov    (%eax),%eax
  800321:	89 45 94             	mov    %eax,-0x6c(%ebp)
  800324:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800327:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80032c:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800331:	74 14                	je     800347 <_main+0x30f>
  800333:	83 ec 04             	sub    $0x4,%esp
  800336:	68 38 31 80 00       	push   $0x803138
  80033b:	6a 5b                	push   $0x5b
  80033d:	68 8a 31 80 00       	push   $0x80318a
  800342:	e8 7f 12 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800347:	a1 20 40 80 00       	mov    0x804020,%eax
  80034c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800352:	83 c0 50             	add    $0x50,%eax
  800355:	8b 00                	mov    (%eax),%eax
  800357:	89 45 90             	mov    %eax,-0x70(%ebp)
  80035a:	8b 45 90             	mov    -0x70(%ebp),%eax
  80035d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800362:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800367:	74 14                	je     80037d <_main+0x345>
  800369:	83 ec 04             	sub    $0x4,%esp
  80036c:	68 38 31 80 00       	push   $0x803138
  800371:	6a 5c                	push   $0x5c
  800373:	68 8a 31 80 00       	push   $0x80318a
  800378:	e8 49 12 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80037d:	a1 20 40 80 00       	mov    0x804020,%eax
  800382:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800388:	83 c0 60             	add    $0x60,%eax
  80038b:	8b 00                	mov    (%eax),%eax
  80038d:	89 45 8c             	mov    %eax,-0x74(%ebp)
  800390:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800393:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800398:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80039d:	74 14                	je     8003b3 <_main+0x37b>
  80039f:	83 ec 04             	sub    $0x4,%esp
  8003a2:	68 38 31 80 00       	push   $0x803138
  8003a7:	6a 5d                	push   $0x5d
  8003a9:	68 8a 31 80 00       	push   $0x80318a
  8003ae:	e8 13 12 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8003b3:	a1 20 40 80 00       	mov    0x804020,%eax
  8003b8:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003be:	83 c0 70             	add    $0x70,%eax
  8003c1:	8b 00                	mov    (%eax),%eax
  8003c3:	89 45 88             	mov    %eax,-0x78(%ebp)
  8003c6:	8b 45 88             	mov    -0x78(%ebp),%eax
  8003c9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003ce:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8003d3:	74 14                	je     8003e9 <_main+0x3b1>
  8003d5:	83 ec 04             	sub    $0x4,%esp
  8003d8:	68 38 31 80 00       	push   $0x803138
  8003dd:	6a 5e                	push   $0x5e
  8003df:	68 8a 31 80 00       	push   $0x80318a
  8003e4:	e8 dd 11 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8003e9:	a1 20 40 80 00       	mov    0x804020,%eax
  8003ee:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003f4:	83 e8 80             	sub    $0xffffff80,%eax
  8003f7:	8b 00                	mov    (%eax),%eax
  8003f9:	89 45 84             	mov    %eax,-0x7c(%ebp)
  8003fc:	8b 45 84             	mov    -0x7c(%ebp),%eax
  8003ff:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800404:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800409:	74 14                	je     80041f <_main+0x3e7>
  80040b:	83 ec 04             	sub    $0x4,%esp
  80040e:	68 38 31 80 00       	push   $0x803138
  800413:	6a 5f                	push   $0x5f
  800415:	68 8a 31 80 00       	push   $0x80318a
  80041a:	e8 a7 11 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80041f:	a1 20 40 80 00       	mov    0x804020,%eax
  800424:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80042a:	05 90 00 00 00       	add    $0x90,%eax
  80042f:	8b 00                	mov    (%eax),%eax
  800431:	89 45 80             	mov    %eax,-0x80(%ebp)
  800434:	8b 45 80             	mov    -0x80(%ebp),%eax
  800437:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80043c:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800441:	74 14                	je     800457 <_main+0x41f>
  800443:	83 ec 04             	sub    $0x4,%esp
  800446:	68 38 31 80 00       	push   $0x803138
  80044b:	6a 60                	push   $0x60
  80044d:	68 8a 31 80 00       	push   $0x80318a
  800452:	e8 6f 11 00 00       	call   8015c6 <_panic>
				if( myEnv->page_last_WS_index !=  1)  										panic("InitialWSError2: INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  800457:	a1 20 40 80 00       	mov    0x804020,%eax
  80045c:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  800462:	83 f8 01             	cmp    $0x1,%eax
  800465:	74 14                	je     80047b <_main+0x443>
  800467:	83 ec 04             	sub    $0x4,%esp
  80046a:	68 a0 31 80 00       	push   $0x8031a0
  80046f:	6a 61                	push   $0x61
  800471:	68 8a 31 80 00       	push   $0x80318a
  800476:	e8 4b 11 00 00       	call   8015c6 <_panic>
			}
		}

		//Reading (Not Modified)
		char garbage1 = arr[PAGE_SIZE*10-1] ;
  80047b:	a0 3f e0 80 00       	mov    0x80e03f,%al
  800480:	88 85 73 ff ff ff    	mov    %al,-0x8d(%ebp)
		char garbage2 = arr[PAGE_SIZE*11-1] ;
  800486:	a0 3f f0 80 00       	mov    0x80f03f,%al
  80048b:	88 85 72 ff ff ff    	mov    %al,-0x8e(%ebp)
		char garbage3 = arr[PAGE_SIZE*12-1] ;
  800491:	a0 3f 00 81 00       	mov    0x81003f,%al
  800496:	88 85 71 ff ff ff    	mov    %al,-0x8f(%ebp)

		char garbage4, garbage5 ;
		//Writing (Modified)
		int i ;
		for (i = 0 ; i < PAGE_SIZE*4 ; i+=PAGE_SIZE/2)
  80049c:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  8004a3:	eb 26                	jmp    8004cb <_main+0x493>
		{
			arr[i] = -1 ;
  8004a5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8004a8:	05 40 40 80 00       	add    $0x804040,%eax
  8004ad:	c6 00 ff             	movb   $0xff,(%eax)
			//always use pages at 0x801000 and 0x804000
			garbage4 = *ptr ;
  8004b0:	a1 00 40 80 00       	mov    0x804000,%eax
  8004b5:	8a 00                	mov    (%eax),%al
  8004b7:	88 45 db             	mov    %al,-0x25(%ebp)
			garbage5 = *ptr2 ;
  8004ba:	a1 04 40 80 00       	mov    0x804004,%eax
  8004bf:	8a 00                	mov    (%eax),%al
  8004c1:	88 45 da             	mov    %al,-0x26(%ebp)
		char garbage3 = arr[PAGE_SIZE*12-1] ;

		char garbage4, garbage5 ;
		//Writing (Modified)
		int i ;
		for (i = 0 ; i < PAGE_SIZE*4 ; i+=PAGE_SIZE/2)
  8004c4:	81 45 d4 00 08 00 00 	addl   $0x800,-0x2c(%ebp)
  8004cb:	81 7d d4 ff 3f 00 00 	cmpl   $0x3fff,-0x2c(%ebp)
  8004d2:	7e d1                	jle    8004a5 <_main+0x46d>

		//===================

		//CASE1: free the exited env only
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
  8004d4:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  8004d8:	74 0a                	je     8004e4 <_main+0x4ac>
  8004da:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8004de:	0f 85 88 00 00 00    	jne    80056c <_main+0x534>
		{
			int i = 0;
  8004e4:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
			numOfExistPages = 0;
  8004eb:	c7 05 00 01 81 00 00 	movl   $0x0,0x810100
  8004f2:	00 00 00 
			for (i = 0; i < myEnv->page_WS_max_size; ++i)
  8004f5:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
  8004fc:	eb 5a                	jmp    800558 <_main+0x520>
			{
				if (!myEnv->__uptr_pws[i].empty)
  8004fe:	a1 20 40 80 00       	mov    0x804020,%eax
  800503:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800509:	8b 55 d0             	mov    -0x30(%ebp),%edx
  80050c:	c1 e2 04             	shl    $0x4,%edx
  80050f:	01 d0                	add    %edx,%eax
  800511:	8a 40 04             	mov    0x4(%eax),%al
  800514:	84 c0                	test   %al,%al
  800516:	75 3d                	jne    800555 <_main+0x51d>
				{
					WSEntries_before[numOfExistPages++] = ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address, PAGE_SIZE);
  800518:	a1 00 01 81 00       	mov    0x810100,%eax
  80051d:	8d 50 01             	lea    0x1(%eax),%edx
  800520:	89 15 00 01 81 00    	mov    %edx,0x810100
  800526:	8b 15 20 40 80 00    	mov    0x804020,%edx
  80052c:	8b 92 80 3c 01 00    	mov    0x13c80(%edx),%edx
  800532:	8b 4d d0             	mov    -0x30(%ebp),%ecx
  800535:	c1 e1 04             	shl    $0x4,%ecx
  800538:	01 ca                	add    %ecx,%edx
  80053a:	8b 12                	mov    (%edx),%edx
  80053c:	89 95 44 ff ff ff    	mov    %edx,-0xbc(%ebp)
  800542:	8b 95 44 ff ff ff    	mov    -0xbc(%ebp),%edx
  800548:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  80054e:	89 14 85 20 01 81 00 	mov    %edx,0x810120(,%eax,4)
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
		{
			int i = 0;
			numOfExistPages = 0;
			for (i = 0; i < myEnv->page_WS_max_size; ++i)
  800555:	ff 45 d0             	incl   -0x30(%ebp)
  800558:	a1 20 40 80 00       	mov    0x804020,%eax
  80055d:	8b 50 74             	mov    0x74(%eax),%edx
  800560:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800563:	39 c2                	cmp    %eax,%edx
  800565:	77 97                	ja     8004fe <_main+0x4c6>
		//===================

		//CASE1: free the exited env only
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
		{
  800567:	e9 a6 02 00 00       	jmp    800812 <_main+0x7da>
				if(myEnv->page_last_WS_index != 9) panic("wrong PAGE WS pointer location");
			}
		}
		 */
		//CASE2: free the WS ONLY using FIFO algorithm
		else if (testCase == 2)
  80056c:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  800570:	0f 85 9c 02 00 00    	jne    800812 <_main+0x7da>
		{
			//cprintf("Checking PAGE FIFO algorithm... \n");
			{
				if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0x804000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800576:	a1 20 40 80 00       	mov    0x804020,%eax
  80057b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800581:	8b 00                	mov    (%eax),%eax
  800583:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
  800589:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80058f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800594:	3d 00 40 80 00       	cmp    $0x804000,%eax
  800599:	74 17                	je     8005b2 <_main+0x57a>
  80059b:	83 ec 04             	sub    $0x4,%esp
  80059e:	68 f8 31 80 00       	push   $0x8031f8
  8005a3:	68 9e 00 00 00       	push   $0x9e
  8005a8:	68 8a 31 80 00       	push   $0x80318a
  8005ad:	e8 14 10 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x80e000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8005b2:	a1 20 40 80 00       	mov    0x804020,%eax
  8005b7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8005bd:	83 c0 10             	add    $0x10,%eax
  8005c0:	8b 00                	mov    (%eax),%eax
  8005c2:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  8005c8:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  8005ce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005d3:	3d 00 e0 80 00       	cmp    $0x80e000,%eax
  8005d8:	74 17                	je     8005f1 <_main+0x5b9>
  8005da:	83 ec 04             	sub    $0x4,%esp
  8005dd:	68 f8 31 80 00       	push   $0x8031f8
  8005e2:	68 9f 00 00 00       	push   $0x9f
  8005e7:	68 8a 31 80 00       	push   $0x80318a
  8005ec:	e8 d5 0f 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x80f000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8005f1:	a1 20 40 80 00       	mov    0x804020,%eax
  8005f6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8005fc:	83 c0 20             	add    $0x20,%eax
  8005ff:	8b 00                	mov    (%eax),%eax
  800601:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  800607:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  80060d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800612:	3d 00 f0 80 00       	cmp    $0x80f000,%eax
  800617:	74 17                	je     800630 <_main+0x5f8>
  800619:	83 ec 04             	sub    $0x4,%esp
  80061c:	68 f8 31 80 00       	push   $0x8031f8
  800621:	68 a0 00 00 00       	push   $0xa0
  800626:	68 8a 31 80 00       	push   $0x80318a
  80062b:	e8 96 0f 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x810000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800630:	a1 20 40 80 00       	mov    0x804020,%eax
  800635:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80063b:	83 c0 30             	add    $0x30,%eax
  80063e:	8b 00                	mov    (%eax),%eax
  800640:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  800646:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  80064c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800651:	3d 00 00 81 00       	cmp    $0x810000,%eax
  800656:	74 17                	je     80066f <_main+0x637>
  800658:	83 ec 04             	sub    $0x4,%esp
  80065b:	68 f8 31 80 00       	push   $0x8031f8
  800660:	68 a1 00 00 00       	push   $0xa1
  800665:	68 8a 31 80 00       	push   $0x80318a
  80066a:	e8 57 0f 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x805000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80066f:	a1 20 40 80 00       	mov    0x804020,%eax
  800674:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80067a:	83 c0 40             	add    $0x40,%eax
  80067d:	8b 00                	mov    (%eax),%eax
  80067f:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  800685:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  80068b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800690:	3d 00 50 80 00       	cmp    $0x805000,%eax
  800695:	74 17                	je     8006ae <_main+0x676>
  800697:	83 ec 04             	sub    $0x4,%esp
  80069a:	68 f8 31 80 00       	push   $0x8031f8
  80069f:	68 a2 00 00 00       	push   $0xa2
  8006a4:	68 8a 31 80 00       	push   $0x80318a
  8006a9:	e8 18 0f 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x806000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8006ae:	a1 20 40 80 00       	mov    0x804020,%eax
  8006b3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8006b9:	83 c0 50             	add    $0x50,%eax
  8006bc:	8b 00                	mov    (%eax),%eax
  8006be:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
  8006c4:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  8006ca:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8006cf:	3d 00 60 80 00       	cmp    $0x806000,%eax
  8006d4:	74 17                	je     8006ed <_main+0x6b5>
  8006d6:	83 ec 04             	sub    $0x4,%esp
  8006d9:	68 f8 31 80 00       	push   $0x8031f8
  8006de:	68 a3 00 00 00       	push   $0xa3
  8006e3:	68 8a 31 80 00       	push   $0x80318a
  8006e8:	e8 d9 0e 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x807000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8006ed:	a1 20 40 80 00       	mov    0x804020,%eax
  8006f2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8006f8:	83 c0 60             	add    $0x60,%eax
  8006fb:	8b 00                	mov    (%eax),%eax
  8006fd:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
  800703:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800709:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80070e:	3d 00 70 80 00       	cmp    $0x807000,%eax
  800713:	74 17                	je     80072c <_main+0x6f4>
  800715:	83 ec 04             	sub    $0x4,%esp
  800718:	68 f8 31 80 00       	push   $0x8031f8
  80071d:	68 a4 00 00 00       	push   $0xa4
  800722:	68 8a 31 80 00       	push   $0x80318a
  800727:	e8 9a 0e 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x800000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80072c:	a1 20 40 80 00       	mov    0x804020,%eax
  800731:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800737:	83 c0 70             	add    $0x70,%eax
  80073a:	8b 00                	mov    (%eax),%eax
  80073c:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  800742:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800748:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80074d:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800752:	74 17                	je     80076b <_main+0x733>
  800754:	83 ec 04             	sub    $0x4,%esp
  800757:	68 f8 31 80 00       	push   $0x8031f8
  80075c:	68 a5 00 00 00       	push   $0xa5
  800761:	68 8a 31 80 00       	push   $0x80318a
  800766:	e8 5b 0e 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x801000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80076b:	a1 20 40 80 00       	mov    0x804020,%eax
  800770:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800776:	83 e8 80             	sub    $0xffffff80,%eax
  800779:	8b 00                	mov    (%eax),%eax
  80077b:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  800781:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800787:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80078c:	3d 00 10 80 00       	cmp    $0x801000,%eax
  800791:	74 17                	je     8007aa <_main+0x772>
  800793:	83 ec 04             	sub    $0x4,%esp
  800796:	68 f8 31 80 00       	push   $0x8031f8
  80079b:	68 a6 00 00 00       	push   $0xa6
  8007a0:	68 8a 31 80 00       	push   $0x80318a
  8007a5:	e8 1c 0e 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8007aa:	a1 20 40 80 00       	mov    0x804020,%eax
  8007af:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007b5:	05 90 00 00 00       	add    $0x90,%eax
  8007ba:	8b 00                	mov    (%eax),%eax
  8007bc:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
  8007c2:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  8007c8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007cd:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  8007d2:	74 17                	je     8007eb <_main+0x7b3>
  8007d4:	83 ec 04             	sub    $0x4,%esp
  8007d7:	68 f8 31 80 00       	push   $0x8031f8
  8007dc:	68 a7 00 00 00       	push   $0xa7
  8007e1:	68 8a 31 80 00       	push   $0x80318a
  8007e6:	e8 db 0d 00 00       	call   8015c6 <_panic>

				if(myEnv->page_last_WS_index != 9) panic("wrong PAGE WS pointer location");
  8007eb:	a1 20 40 80 00       	mov    0x804020,%eax
  8007f0:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  8007f6:	83 f8 09             	cmp    $0x9,%eax
  8007f9:	74 17                	je     800812 <_main+0x7da>
  8007fb:	83 ec 04             	sub    $0x4,%esp
  8007fe:	68 44 32 80 00       	push   $0x803244
  800803:	68 a9 00 00 00       	push   $0xa9
  800808:	68 8a 31 80 00       	push   $0x80318a
  80080d:	e8 b4 0d 00 00       	call   8015c6 <_panic>
			}
		}

		//=========================================================//
		//Clear the FFL
		sys_clear_ffl();
  800812:	e8 71 20 00 00       	call   802888 <sys_clear_ffl>
		//=========================================================//

		//Writing (Modified) after freeing the entire FFL:
		//	3 frames should be allocated (stack page, mem table, page file table)
		*ptr3 = garbage1 ;
  800817:	a1 08 40 80 00       	mov    0x804008,%eax
  80081c:	8a 95 73 ff ff ff    	mov    -0x8d(%ebp),%dl
  800822:	88 10                	mov    %dl,(%eax)
		//always use pages at 0x801000 and 0x804000
		garbage4 = *ptr ;
  800824:	a1 00 40 80 00       	mov    0x804000,%eax
  800829:	8a 00                	mov    (%eax),%al
  80082b:	88 45 db             	mov    %al,-0x25(%ebp)
		garbage5 = *ptr2 ;
  80082e:	a1 04 40 80 00       	mov    0x804004,%eax
  800833:	8a 00                	mov    (%eax),%al
  800835:	88 45 da             	mov    %al,-0x26(%ebp)

		//CASE1: free the exited env's ONLY
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
  800838:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  80083c:	74 0a                	je     800848 <_main+0x810>
  80083e:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800842:	0f 85 93 00 00 00    	jne    8008db <_main+0x8a3>
		{
			//Add the last reference to our WS
			WSEntries_before[numOfExistPages++] = ROUNDDOWN((uint32)(ptr3), PAGE_SIZE);
  800848:	a1 00 01 81 00       	mov    0x810100,%eax
  80084d:	8d 50 01             	lea    0x1(%eax),%edx
  800850:	89 15 00 01 81 00    	mov    %edx,0x810100
  800856:	8b 15 08 40 80 00    	mov    0x804008,%edx
  80085c:	89 95 3c ff ff ff    	mov    %edx,-0xc4(%ebp)
  800862:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
  800868:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  80086e:	89 14 85 20 01 81 00 	mov    %edx,0x810120(,%eax,4)

			//Make sure that WS is not affected
			for (i = 0; i < numOfExistPages; ++i)
  800875:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  80087c:	eb 4e                	jmp    8008cc <_main+0x894>
			{
				if (WSEntries_before[i] != ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address, PAGE_SIZE))
  80087e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800881:	8b 14 85 20 01 81 00 	mov    0x810120(,%eax,4),%edx
  800888:	a1 20 40 80 00       	mov    0x804020,%eax
  80088d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800893:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  800896:	c1 e1 04             	shl    $0x4,%ecx
  800899:	01 c8                	add    %ecx,%eax
  80089b:	8b 00                	mov    (%eax),%eax
  80089d:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
  8008a3:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  8008a9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8008ae:	39 c2                	cmp    %eax,%edx
  8008b0:	74 17                	je     8008c9 <_main+0x891>
					panic("FreeRAM.Scenario1 or 3: WS is changed while not expected to!");
  8008b2:	83 ec 04             	sub    $0x4,%esp
  8008b5:	68 64 32 80 00       	push   $0x803264
  8008ba:	68 c4 00 00 00       	push   $0xc4
  8008bf:	68 8a 31 80 00       	push   $0x80318a
  8008c4:	e8 fd 0c 00 00       	call   8015c6 <_panic>
		{
			//Add the last reference to our WS
			WSEntries_before[numOfExistPages++] = ROUNDDOWN((uint32)(ptr3), PAGE_SIZE);

			//Make sure that WS is not affected
			for (i = 0; i < numOfExistPages; ++i)
  8008c9:	ff 45 d4             	incl   -0x2c(%ebp)
  8008cc:	a1 00 01 81 00       	mov    0x810100,%eax
  8008d1:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  8008d4:	7c a8                	jl     80087e <_main+0x846>
		garbage4 = *ptr ;
		garbage5 = *ptr2 ;

		//CASE1: free the exited env's ONLY
		//CASE3: free BOTH exited env's and WS
		if (testCase == 1 || testCase == 3)
  8008d6:	e9 39 01 00 00       	jmp    800a14 <_main+0x9dc>
				if (WSEntries_before[i] != ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address, PAGE_SIZE))
					panic("FreeRAM.Scenario1 or 3: WS is changed while not expected to!");
			}
		}
		//Case2: free the WS ONLY by clock algorithm
		else if (testCase == 2)
  8008db:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  8008df:	0f 85 2f 01 00 00    	jne    800a14 <_main+0x9dc>
			}
			 */

			//Check the WS after FIFO algorithm

			if (garbage4 != *ptr || garbage5 != *ptr2) panic("test failed!");
  8008e5:	a1 00 40 80 00       	mov    0x804000,%eax
  8008ea:	8a 00                	mov    (%eax),%al
  8008ec:	3a 45 db             	cmp    -0x25(%ebp),%al
  8008ef:	75 0c                	jne    8008fd <_main+0x8c5>
  8008f1:	a1 04 40 80 00       	mov    0x804004,%eax
  8008f6:	8a 00                	mov    (%eax),%al
  8008f8:	3a 45 da             	cmp    -0x26(%ebp),%al
  8008fb:	74 17                	je     800914 <_main+0x8dc>
  8008fd:	83 ec 04             	sub    $0x4,%esp
  800900:	68 a1 32 80 00       	push   $0x8032a1
  800905:	68 d7 00 00 00       	push   $0xd7
  80090a:	68 8a 31 80 00       	push   $0x80318a
  80090f:	e8 b2 0c 00 00       	call   8015c6 <_panic>

			//There should be two empty locations that are freed for the two tables (mem table and page file table)
			int numOfEmptyLocs = 0 ;
  800914:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
			for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  80091b:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%ebp)
  800922:	eb 20                	jmp    800944 <_main+0x90c>
			{
				if (myEnv->__uptr_pws[i].empty)
  800924:	a1 20 40 80 00       	mov    0x804020,%eax
  800929:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80092f:	8b 55 c8             	mov    -0x38(%ebp),%edx
  800932:	c1 e2 04             	shl    $0x4,%edx
  800935:	01 d0                	add    %edx,%eax
  800937:	8a 40 04             	mov    0x4(%eax),%al
  80093a:	84 c0                	test   %al,%al
  80093c:	74 03                	je     800941 <_main+0x909>
					numOfEmptyLocs++ ;
  80093e:	ff 45 cc             	incl   -0x34(%ebp)

			if (garbage4 != *ptr || garbage5 != *ptr2) panic("test failed!");

			//There should be two empty locations that are freed for the two tables (mem table and page file table)
			int numOfEmptyLocs = 0 ;
			for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  800941:	ff 45 c8             	incl   -0x38(%ebp)
  800944:	a1 20 40 80 00       	mov    0x804020,%eax
  800949:	8b 50 74             	mov    0x74(%eax),%edx
  80094c:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80094f:	39 c2                	cmp    %eax,%edx
  800951:	77 d1                	ja     800924 <_main+0x8ec>
			{
				if (myEnv->__uptr_pws[i].empty)
					numOfEmptyLocs++ ;
			}
			if (numOfEmptyLocs != 2) panic("test failed! either wrong victim or victim is not removed from WS");
  800953:	83 7d cc 02          	cmpl   $0x2,-0x34(%ebp)
  800957:	74 17                	je     800970 <_main+0x938>
  800959:	83 ec 04             	sub    $0x4,%esp
  80095c:	68 b0 32 80 00       	push   $0x8032b0
  800961:	68 e0 00 00 00       	push   $0xe0
  800966:	68 8a 31 80 00       	push   $0x80318a
  80096b:	e8 56 0c 00 00       	call   8015c6 <_panic>

			uint32 expectedAddresses[8] = {0x800000,0x801000,0x802000,0x803000,0x804000,0x807000,0xee7fe000,0xeebfd000} ;
  800970:	8d 85 6c fe ff ff    	lea    -0x194(%ebp),%eax
  800976:	bb c0 33 80 00       	mov    $0x8033c0,%ebx
  80097b:	ba 08 00 00 00       	mov    $0x8,%edx
  800980:	89 c7                	mov    %eax,%edi
  800982:	89 de                	mov    %ebx,%esi
  800984:	89 d1                	mov    %edx,%ecx
  800986:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
			int numOfFoundedAddresses = 0;
  800988:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
			for (int j = 0; j < 8; j++)
  80098f:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
  800996:	eb 59                	jmp    8009f1 <_main+0x9b9>
			{
				for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  800998:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
  80099f:	eb 3e                	jmp    8009df <_main+0x9a7>
				{
					if (ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == expectedAddresses[j])
  8009a1:	a1 20 40 80 00       	mov    0x804020,%eax
  8009a6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8009ac:	8b 55 bc             	mov    -0x44(%ebp),%edx
  8009af:	c1 e2 04             	shl    $0x4,%edx
  8009b2:	01 d0                	add    %edx,%eax
  8009b4:	8b 00                	mov    (%eax),%eax
  8009b6:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
  8009bc:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  8009c2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009c7:	89 c2                	mov    %eax,%edx
  8009c9:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8009cc:	8b 84 85 6c fe ff ff 	mov    -0x194(%ebp,%eax,4),%eax
  8009d3:	39 c2                	cmp    %eax,%edx
  8009d5:	75 05                	jne    8009dc <_main+0x9a4>
					{
						numOfFoundedAddresses++;
  8009d7:	ff 45 c4             	incl   -0x3c(%ebp)
						break;
  8009da:	eb 12                	jmp    8009ee <_main+0x9b6>

			uint32 expectedAddresses[8] = {0x800000,0x801000,0x802000,0x803000,0x804000,0x807000,0xee7fe000,0xeebfd000} ;
			int numOfFoundedAddresses = 0;
			for (int j = 0; j < 8; j++)
			{
				for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  8009dc:	ff 45 bc             	incl   -0x44(%ebp)
  8009df:	a1 20 40 80 00       	mov    0x804020,%eax
  8009e4:	8b 50 74             	mov    0x74(%eax),%edx
  8009e7:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8009ea:	39 c2                	cmp    %eax,%edx
  8009ec:	77 b3                	ja     8009a1 <_main+0x969>
			}
			if (numOfEmptyLocs != 2) panic("test failed! either wrong victim or victim is not removed from WS");

			uint32 expectedAddresses[8] = {0x800000,0x801000,0x802000,0x803000,0x804000,0x807000,0xee7fe000,0xeebfd000} ;
			int numOfFoundedAddresses = 0;
			for (int j = 0; j < 8; j++)
  8009ee:	ff 45 c0             	incl   -0x40(%ebp)
  8009f1:	83 7d c0 07          	cmpl   $0x7,-0x40(%ebp)
  8009f5:	7e a1                	jle    800998 <_main+0x960>
						numOfFoundedAddresses++;
						break;
					}
				}
			}
			if (numOfFoundedAddresses != 8) panic("test failed! either wrong victim or victim is not removed from WS");
  8009f7:	83 7d c4 08          	cmpl   $0x8,-0x3c(%ebp)
  8009fb:	74 17                	je     800a14 <_main+0x9dc>
  8009fd:	83 ec 04             	sub    $0x4,%esp
  800a00:	68 b0 32 80 00       	push   $0x8032b0
  800a05:	68 ef 00 00 00       	push   $0xef
  800a0a:	68 8a 31 80 00       	push   $0x80318a
  800a0f:	e8 b2 0b 00 00       	call   8015c6 <_panic>

		}


		//Case1: free the exited env's ONLY
		if (testCase ==1)
  800a14:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  800a18:	0f 85 81 00 00 00    	jne    800a9f <_main+0xa67>
		{
			cprintf("running fos_helloWorld program...\n\n");
  800a1e:	83 ec 0c             	sub    $0xc,%esp
  800a21:	68 f4 32 80 00       	push   $0x8032f4
  800a26:	e8 3d 0e 00 00       	call   801868 <cprintf>
  800a2b:	83 c4 10             	add    $0x10,%esp
			sys_run_env(envIdHelloWorld);
  800a2e:	83 ec 0c             	sub    $0xc,%esp
  800a31:	ff 75 dc             	pushl  -0x24(%ebp)
  800a34:	e8 98 1f 00 00       	call   8029d1 <sys_run_env>
  800a39:	83 c4 10             	add    $0x10,%esp
			cprintf("please be patient ...\n");
  800a3c:	83 ec 0c             	sub    $0xc,%esp
  800a3f:	68 21 31 80 00       	push   $0x803121
  800a44:	e8 1f 0e 00 00       	call   801868 <cprintf>
  800a49:	83 c4 10             	add    $0x10,%esp
			env_sleep(3000);
  800a4c:	83 ec 0c             	sub    $0xc,%esp
  800a4f:	68 b8 0b 00 00       	push   $0xbb8
  800a54:	e8 f6 21 00 00       	call   802c4f <env_sleep>
  800a59:	83 c4 10             	add    $0x10,%esp

			cprintf("running fos_fib program...\n\n");
  800a5c:	83 ec 0c             	sub    $0xc,%esp
  800a5f:	68 18 33 80 00       	push   $0x803318
  800a64:	e8 ff 0d 00 00       	call   801868 <cprintf>
  800a69:	83 c4 10             	add    $0x10,%esp
			sys_run_env(envIdFib);
  800a6c:	83 ec 0c             	sub    $0xc,%esp
  800a6f:	ff 75 e0             	pushl  -0x20(%ebp)
  800a72:	e8 5a 1f 00 00       	call   8029d1 <sys_run_env>
  800a77:	83 c4 10             	add    $0x10,%esp
			cprintf("please be patient ...\n");
  800a7a:	83 ec 0c             	sub    $0xc,%esp
  800a7d:	68 21 31 80 00       	push   $0x803121
  800a82:	e8 e1 0d 00 00       	call   801868 <cprintf>
  800a87:	83 c4 10             	add    $0x10,%esp
			env_sleep(5000);
  800a8a:	83 ec 0c             	sub    $0xc,%esp
  800a8d:	68 88 13 00 00       	push   $0x1388
  800a92:	e8 b8 21 00 00       	call   802c4f <env_sleep>
  800a97:	83 c4 10             	add    $0x10,%esp
  800a9a:	e9 4e 08 00 00       	jmp    8012ed <_main+0x12b5>
		}
		//CASE3: free BOTH exited env's and WS
		else if (testCase ==3)
  800a9f:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800aa3:	0f 85 44 08 00 00    	jne    8012ed <_main+0x12b5>
				if( ROUNDDOWN(myEnv->__uptr_pws[24].virtual_address,PAGE_SIZE) !=   0xee7fe000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
				if( myEnv->page_last_WS_index !=  0)  										panic("InitialWSError2: INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
			}
			 */

			cprintf("Checking PAGE FIFO algorithm... \n");
  800aa9:	83 ec 0c             	sub    $0xc,%esp
  800aac:	68 38 33 80 00       	push   $0x803338
  800ab1:	e8 b2 0d 00 00       	call   801868 <cprintf>
  800ab6:	83 c4 10             	add    $0x10,%esp
			{
				if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800ab9:	a1 20 40 80 00       	mov    0x804020,%eax
  800abe:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800ac4:	8b 00                	mov    (%eax),%eax
  800ac6:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
  800acc:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800ad2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ad7:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800adc:	74 17                	je     800af5 <_main+0xabd>
  800ade:	83 ec 04             	sub    $0x4,%esp
  800ae1:	68 38 31 80 00       	push   $0x803138
  800ae6:	68 25 01 00 00       	push   $0x125
  800aeb:	68 8a 31 80 00       	push   $0x80318a
  800af0:	e8 d1 0a 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800af5:	a1 20 40 80 00       	mov    0x804020,%eax
  800afa:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b00:	83 c0 10             	add    $0x10,%eax
  800b03:	8b 00                	mov    (%eax),%eax
  800b05:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
  800b0b:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  800b11:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b16:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800b1b:	74 17                	je     800b34 <_main+0xafc>
  800b1d:	83 ec 04             	sub    $0x4,%esp
  800b20:	68 38 31 80 00       	push   $0x803138
  800b25:	68 26 01 00 00       	push   $0x126
  800b2a:	68 8a 31 80 00       	push   $0x80318a
  800b2f:	e8 92 0a 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800b34:	a1 20 40 80 00       	mov    0x804020,%eax
  800b39:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b3f:	83 c0 20             	add    $0x20,%eax
  800b42:	8b 00                	mov    (%eax),%eax
  800b44:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
  800b4a:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  800b50:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b55:	3d 00 20 20 00       	cmp    $0x202000,%eax
  800b5a:	74 17                	je     800b73 <_main+0xb3b>
  800b5c:	83 ec 04             	sub    $0x4,%esp
  800b5f:	68 38 31 80 00       	push   $0x803138
  800b64:	68 27 01 00 00       	push   $0x127
  800b69:	68 8a 31 80 00       	push   $0x80318a
  800b6e:	e8 53 0a 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800b73:	a1 20 40 80 00       	mov    0x804020,%eax
  800b78:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800b7e:	83 c0 30             	add    $0x30,%eax
  800b81:	8b 00                	mov    (%eax),%eax
  800b83:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
  800b89:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
  800b8f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b94:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800b99:	74 17                	je     800bb2 <_main+0xb7a>
  800b9b:	83 ec 04             	sub    $0x4,%esp
  800b9e:	68 38 31 80 00       	push   $0x803138
  800ba3:	68 28 01 00 00       	push   $0x128
  800ba8:	68 8a 31 80 00       	push   $0x80318a
  800bad:	e8 14 0a 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800bb2:	a1 20 40 80 00       	mov    0x804020,%eax
  800bb7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800bbd:	83 c0 40             	add    $0x40,%eax
  800bc0:	8b 00                	mov    (%eax),%eax
  800bc2:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
  800bc8:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  800bce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800bd3:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800bd8:	74 17                	je     800bf1 <_main+0xbb9>
  800bda:	83 ec 04             	sub    $0x4,%esp
  800bdd:	68 38 31 80 00       	push   $0x803138
  800be2:	68 29 01 00 00       	push   $0x129
  800be7:	68 8a 31 80 00       	push   $0x80318a
  800bec:	e8 d5 09 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800bf1:	a1 20 40 80 00       	mov    0x804020,%eax
  800bf6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800bfc:	83 c0 50             	add    $0x50,%eax
  800bff:	8b 00                	mov    (%eax),%eax
  800c01:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
  800c07:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  800c0d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800c12:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800c17:	74 17                	je     800c30 <_main+0xbf8>
  800c19:	83 ec 04             	sub    $0x4,%esp
  800c1c:	68 38 31 80 00       	push   $0x803138
  800c21:	68 2a 01 00 00       	push   $0x12a
  800c26:	68 8a 31 80 00       	push   $0x80318a
  800c2b:	e8 96 09 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800c30:	a1 20 40 80 00       	mov    0x804020,%eax
  800c35:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800c3b:	83 c0 60             	add    $0x60,%eax
  800c3e:	8b 00                	mov    (%eax),%eax
  800c40:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
  800c46:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
  800c4c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800c51:	3d 00 00 80 00       	cmp    $0x800000,%eax
  800c56:	74 17                	je     800c6f <_main+0xc37>
  800c58:	83 ec 04             	sub    $0x4,%esp
  800c5b:	68 38 31 80 00       	push   $0x803138
  800c60:	68 2b 01 00 00       	push   $0x12b
  800c65:	68 8a 31 80 00       	push   $0x80318a
  800c6a:	e8 57 09 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800c6f:	a1 20 40 80 00       	mov    0x804020,%eax
  800c74:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800c7a:	83 c0 70             	add    $0x70,%eax
  800c7d:	8b 00                	mov    (%eax),%eax
  800c7f:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
  800c85:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
  800c8b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800c90:	3d 00 10 80 00       	cmp    $0x801000,%eax
  800c95:	74 17                	je     800cae <_main+0xc76>
  800c97:	83 ec 04             	sub    $0x4,%esp
  800c9a:	68 38 31 80 00       	push   $0x803138
  800c9f:	68 2c 01 00 00       	push   $0x12c
  800ca4:	68 8a 31 80 00       	push   $0x80318a
  800ca9:	e8 18 09 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800cae:	a1 20 40 80 00       	mov    0x804020,%eax
  800cb3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800cb9:	83 e8 80             	sub    $0xffffff80,%eax
  800cbc:	8b 00                	mov    (%eax),%eax
  800cbe:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
  800cc4:	8b 85 14 ff ff ff    	mov    -0xec(%ebp),%eax
  800cca:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ccf:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800cd4:	74 17                	je     800ced <_main+0xcb5>
  800cd6:	83 ec 04             	sub    $0x4,%esp
  800cd9:	68 38 31 80 00       	push   $0x803138
  800cde:	68 2d 01 00 00       	push   $0x12d
  800ce3:	68 8a 31 80 00       	push   $0x80318a
  800ce8:	e8 d9 08 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800ced:	a1 20 40 80 00       	mov    0x804020,%eax
  800cf2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800cf8:	05 90 00 00 00       	add    $0x90,%eax
  800cfd:	8b 00                	mov    (%eax),%eax
  800cff:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%ebp)
  800d05:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  800d0b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d10:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800d15:	74 17                	je     800d2e <_main+0xcf6>
  800d17:	83 ec 04             	sub    $0x4,%esp
  800d1a:	68 38 31 80 00       	push   $0x803138
  800d1f:	68 2e 01 00 00       	push   $0x12e
  800d24:	68 8a 31 80 00       	push   $0x80318a
  800d29:	e8 98 08 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x804000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800d2e:	a1 20 40 80 00       	mov    0x804020,%eax
  800d33:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800d39:	05 a0 00 00 00       	add    $0xa0,%eax
  800d3e:	8b 00                	mov    (%eax),%eax
  800d40:	89 85 0c ff ff ff    	mov    %eax,-0xf4(%ebp)
  800d46:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
  800d4c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d51:	3d 00 40 80 00       	cmp    $0x804000,%eax
  800d56:	74 17                	je     800d6f <_main+0xd37>
  800d58:	83 ec 04             	sub    $0x4,%esp
  800d5b:	68 38 31 80 00       	push   $0x803138
  800d60:	68 2f 01 00 00       	push   $0x12f
  800d65:	68 8a 31 80 00       	push   $0x80318a
  800d6a:	e8 57 08 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0x805000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800d6f:	a1 20 40 80 00       	mov    0x804020,%eax
  800d74:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800d7a:	05 b0 00 00 00       	add    $0xb0,%eax
  800d7f:	8b 00                	mov    (%eax),%eax
  800d81:	89 85 08 ff ff ff    	mov    %eax,-0xf8(%ebp)
  800d87:	8b 85 08 ff ff ff    	mov    -0xf8(%ebp),%eax
  800d8d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d92:	3d 00 50 80 00       	cmp    $0x805000,%eax
  800d97:	74 17                	je     800db0 <_main+0xd78>
  800d99:	83 ec 04             	sub    $0x4,%esp
  800d9c:	68 38 31 80 00       	push   $0x803138
  800da1:	68 30 01 00 00       	push   $0x130
  800da6:	68 8a 31 80 00       	push   $0x80318a
  800dab:	e8 16 08 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[12].virtual_address,PAGE_SIZE) !=   0x806000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800db0:	a1 20 40 80 00       	mov    0x804020,%eax
  800db5:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800dbb:	05 c0 00 00 00       	add    $0xc0,%eax
  800dc0:	8b 00                	mov    (%eax),%eax
  800dc2:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
  800dc8:	8b 85 04 ff ff ff    	mov    -0xfc(%ebp),%eax
  800dce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800dd3:	3d 00 60 80 00       	cmp    $0x806000,%eax
  800dd8:	74 17                	je     800df1 <_main+0xdb9>
  800dda:	83 ec 04             	sub    $0x4,%esp
  800ddd:	68 38 31 80 00       	push   $0x803138
  800de2:	68 31 01 00 00       	push   $0x131
  800de7:	68 8a 31 80 00       	push   $0x80318a
  800dec:	e8 d5 07 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[13].virtual_address,PAGE_SIZE) !=   0x807000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800df1:	a1 20 40 80 00       	mov    0x804020,%eax
  800df6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800dfc:	05 d0 00 00 00       	add    $0xd0,%eax
  800e01:	8b 00                	mov    (%eax),%eax
  800e03:	89 85 00 ff ff ff    	mov    %eax,-0x100(%ebp)
  800e09:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
  800e0f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e14:	3d 00 70 80 00       	cmp    $0x807000,%eax
  800e19:	74 17                	je     800e32 <_main+0xdfa>
  800e1b:	83 ec 04             	sub    $0x4,%esp
  800e1e:	68 38 31 80 00       	push   $0x803138
  800e23:	68 32 01 00 00       	push   $0x132
  800e28:	68 8a 31 80 00       	push   $0x80318a
  800e2d:	e8 94 07 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[14].virtual_address,PAGE_SIZE) !=   0x808000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800e32:	a1 20 40 80 00       	mov    0x804020,%eax
  800e37:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800e3d:	05 e0 00 00 00       	add    $0xe0,%eax
  800e42:	8b 00                	mov    (%eax),%eax
  800e44:	89 85 fc fe ff ff    	mov    %eax,-0x104(%ebp)
  800e4a:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
  800e50:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e55:	3d 00 80 80 00       	cmp    $0x808000,%eax
  800e5a:	74 17                	je     800e73 <_main+0xe3b>
  800e5c:	83 ec 04             	sub    $0x4,%esp
  800e5f:	68 38 31 80 00       	push   $0x803138
  800e64:	68 33 01 00 00       	push   $0x133
  800e69:	68 8a 31 80 00       	push   $0x80318a
  800e6e:	e8 53 07 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[15].virtual_address,PAGE_SIZE) !=   0x809000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800e73:	a1 20 40 80 00       	mov    0x804020,%eax
  800e78:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800e7e:	05 f0 00 00 00       	add    $0xf0,%eax
  800e83:	8b 00                	mov    (%eax),%eax
  800e85:	89 85 f8 fe ff ff    	mov    %eax,-0x108(%ebp)
  800e8b:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
  800e91:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e96:	3d 00 90 80 00       	cmp    $0x809000,%eax
  800e9b:	74 17                	je     800eb4 <_main+0xe7c>
  800e9d:	83 ec 04             	sub    $0x4,%esp
  800ea0:	68 38 31 80 00       	push   $0x803138
  800ea5:	68 34 01 00 00       	push   $0x134
  800eaa:	68 8a 31 80 00       	push   $0x80318a
  800eaf:	e8 12 07 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[16].virtual_address,PAGE_SIZE) !=   0x80A000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800eb4:	a1 20 40 80 00       	mov    0x804020,%eax
  800eb9:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800ebf:	05 00 01 00 00       	add    $0x100,%eax
  800ec4:	8b 00                	mov    (%eax),%eax
  800ec6:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
  800ecc:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  800ed2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ed7:	3d 00 a0 80 00       	cmp    $0x80a000,%eax
  800edc:	74 17                	je     800ef5 <_main+0xebd>
  800ede:	83 ec 04             	sub    $0x4,%esp
  800ee1:	68 38 31 80 00       	push   $0x803138
  800ee6:	68 35 01 00 00       	push   $0x135
  800eeb:	68 8a 31 80 00       	push   $0x80318a
  800ef0:	e8 d1 06 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[17].virtual_address,PAGE_SIZE) !=   0x80B000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800ef5:	a1 20 40 80 00       	mov    0x804020,%eax
  800efa:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800f00:	05 10 01 00 00       	add    $0x110,%eax
  800f05:	8b 00                	mov    (%eax),%eax
  800f07:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
  800f0d:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  800f13:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f18:	3d 00 b0 80 00       	cmp    $0x80b000,%eax
  800f1d:	74 17                	je     800f36 <_main+0xefe>
  800f1f:	83 ec 04             	sub    $0x4,%esp
  800f22:	68 38 31 80 00       	push   $0x803138
  800f27:	68 36 01 00 00       	push   $0x136
  800f2c:	68 8a 31 80 00       	push   $0x80318a
  800f31:	e8 90 06 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[18].virtual_address,PAGE_SIZE) !=   0x80C000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800f36:	a1 20 40 80 00       	mov    0x804020,%eax
  800f3b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800f41:	05 20 01 00 00       	add    $0x120,%eax
  800f46:	8b 00                	mov    (%eax),%eax
  800f48:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
  800f4e:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  800f54:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f59:	3d 00 c0 80 00       	cmp    $0x80c000,%eax
  800f5e:	74 17                	je     800f77 <_main+0xf3f>
  800f60:	83 ec 04             	sub    $0x4,%esp
  800f63:	68 38 31 80 00       	push   $0x803138
  800f68:	68 37 01 00 00       	push   $0x137
  800f6d:	68 8a 31 80 00       	push   $0x80318a
  800f72:	e8 4f 06 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[19].virtual_address,PAGE_SIZE) !=   0x80D000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800f77:	a1 20 40 80 00       	mov    0x804020,%eax
  800f7c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800f82:	05 30 01 00 00       	add    $0x130,%eax
  800f87:	8b 00                	mov    (%eax),%eax
  800f89:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
  800f8f:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
  800f95:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800f9a:	3d 00 d0 80 00       	cmp    $0x80d000,%eax
  800f9f:	74 17                	je     800fb8 <_main+0xf80>
  800fa1:	83 ec 04             	sub    $0x4,%esp
  800fa4:	68 38 31 80 00       	push   $0x803138
  800fa9:	68 38 01 00 00       	push   $0x138
  800fae:	68 8a 31 80 00       	push   $0x80318a
  800fb3:	e8 0e 06 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[20].virtual_address,PAGE_SIZE) !=   0x80E000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800fb8:	a1 20 40 80 00       	mov    0x804020,%eax
  800fbd:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800fc3:	05 40 01 00 00       	add    $0x140,%eax
  800fc8:	8b 00                	mov    (%eax),%eax
  800fca:	89 85 e4 fe ff ff    	mov    %eax,-0x11c(%ebp)
  800fd0:	8b 85 e4 fe ff ff    	mov    -0x11c(%ebp),%eax
  800fd6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800fdb:	3d 00 e0 80 00       	cmp    $0x80e000,%eax
  800fe0:	74 17                	je     800ff9 <_main+0xfc1>
  800fe2:	83 ec 04             	sub    $0x4,%esp
  800fe5:	68 38 31 80 00       	push   $0x803138
  800fea:	68 39 01 00 00       	push   $0x139
  800fef:	68 8a 31 80 00       	push   $0x80318a
  800ff4:	e8 cd 05 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[21].virtual_address,PAGE_SIZE) !=   0x80F000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800ff9:	a1 20 40 80 00       	mov    0x804020,%eax
  800ffe:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801004:	05 50 01 00 00       	add    $0x150,%eax
  801009:	8b 00                	mov    (%eax),%eax
  80100b:	89 85 e0 fe ff ff    	mov    %eax,-0x120(%ebp)
  801011:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  801017:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80101c:	3d 00 f0 80 00       	cmp    $0x80f000,%eax
  801021:	74 17                	je     80103a <_main+0x1002>
  801023:	83 ec 04             	sub    $0x4,%esp
  801026:	68 38 31 80 00       	push   $0x803138
  80102b:	68 3a 01 00 00       	push   $0x13a
  801030:	68 8a 31 80 00       	push   $0x80318a
  801035:	e8 8c 05 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[22].virtual_address,PAGE_SIZE) !=   0x810000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80103a:	a1 20 40 80 00       	mov    0x804020,%eax
  80103f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801045:	05 60 01 00 00       	add    $0x160,%eax
  80104a:	8b 00                	mov    (%eax),%eax
  80104c:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)
  801052:	8b 85 dc fe ff ff    	mov    -0x124(%ebp),%eax
  801058:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80105d:	3d 00 00 81 00       	cmp    $0x810000,%eax
  801062:	74 17                	je     80107b <_main+0x1043>
  801064:	83 ec 04             	sub    $0x4,%esp
  801067:	68 38 31 80 00       	push   $0x803138
  80106c:	68 3b 01 00 00       	push   $0x13b
  801071:	68 8a 31 80 00       	push   $0x80318a
  801076:	e8 4b 05 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[23].virtual_address,PAGE_SIZE) !=   0x811000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80107b:	a1 20 40 80 00       	mov    0x804020,%eax
  801080:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801086:	05 70 01 00 00       	add    $0x170,%eax
  80108b:	8b 00                	mov    (%eax),%eax
  80108d:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
  801093:	8b 85 d8 fe ff ff    	mov    -0x128(%ebp),%eax
  801099:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80109e:	3d 00 10 81 00       	cmp    $0x811000,%eax
  8010a3:	74 17                	je     8010bc <_main+0x1084>
  8010a5:	83 ec 04             	sub    $0x4,%esp
  8010a8:	68 38 31 80 00       	push   $0x803138
  8010ad:	68 3c 01 00 00       	push   $0x13c
  8010b2:	68 8a 31 80 00       	push   $0x80318a
  8010b7:	e8 0a 05 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[24].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8010bc:	a1 20 40 80 00       	mov    0x804020,%eax
  8010c1:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8010c7:	05 80 01 00 00       	add    $0x180,%eax
  8010cc:	8b 00                	mov    (%eax),%eax
  8010ce:	89 85 d4 fe ff ff    	mov    %eax,-0x12c(%ebp)
  8010d4:	8b 85 d4 fe ff ff    	mov    -0x12c(%ebp),%eax
  8010da:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8010df:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  8010e4:	74 17                	je     8010fd <_main+0x10c5>
  8010e6:	83 ec 04             	sub    $0x4,%esp
  8010e9:	68 38 31 80 00       	push   $0x803138
  8010ee:	68 3d 01 00 00       	push   $0x13d
  8010f3:	68 8a 31 80 00       	push   $0x80318a
  8010f8:	e8 c9 04 00 00       	call   8015c6 <_panic>
				if( ROUNDDOWN(myEnv->__uptr_pws[25].virtual_address,PAGE_SIZE) !=   0xee7fe000)  panic("InitialWSError2: INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8010fd:	a1 20 40 80 00       	mov    0x804020,%eax
  801102:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801108:	05 90 01 00 00       	add    $0x190,%eax
  80110d:	8b 00                	mov    (%eax),%eax
  80110f:	89 85 d0 fe ff ff    	mov    %eax,-0x130(%ebp)
  801115:	8b 85 d0 fe ff ff    	mov    -0x130(%ebp),%eax
  80111b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801120:	3d 00 e0 7f ee       	cmp    $0xee7fe000,%eax
  801125:	74 17                	je     80113e <_main+0x1106>
  801127:	83 ec 04             	sub    $0x4,%esp
  80112a:	68 38 31 80 00       	push   $0x803138
  80112f:	68 3e 01 00 00       	push   $0x13e
  801134:	68 8a 31 80 00       	push   $0x80318a
  801139:	e8 88 04 00 00       	call   8015c6 <_panic>
				if( myEnv->page_last_WS_index !=  0)  										panic("InitialWSError2: INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  80113e:	a1 20 40 80 00       	mov    0x804020,%eax
  801143:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  801149:	85 c0                	test   %eax,%eax
  80114b:	74 17                	je     801164 <_main+0x112c>
  80114d:	83 ec 04             	sub    $0x4,%esp
  801150:	68 a0 31 80 00       	push   $0x8031a0
  801155:	68 3f 01 00 00       	push   $0x13f
  80115a:	68 8a 31 80 00       	push   $0x80318a
  80115f:	e8 62 04 00 00       	call   8015c6 <_panic>
			}

			//=========================================================//
			//Clear the FFL
			sys_clear_ffl();
  801164:	e8 1f 17 00 00       	call   802888 <sys_clear_ffl>

			//NOW: it should take from WS

			//Writing (Modified) after freeing the entire FFL:
			//	3 frames should be allocated (stack page, mem table, page file table)
			*ptr4 = garbage2 ;
  801169:	a1 0c 40 80 00       	mov    0x80400c,%eax
  80116e:	8a 95 72 ff ff ff    	mov    -0x8e(%ebp),%dl
  801174:	88 10                	mov    %dl,(%eax)
			//always use pages at 0x801000 and 0x804000
			//			if (garbage4 != *ptr) panic("test failed!");
			//			if (garbage5 != *ptr2) panic("test failed!");

			garbage4 = *ptr ;
  801176:	a1 00 40 80 00       	mov    0x804000,%eax
  80117b:	8a 00                	mov    (%eax),%al
  80117d:	88 45 db             	mov    %al,-0x25(%ebp)
			garbage5 = *ptr2 ;
  801180:	a1 04 40 80 00       	mov    0x804004,%eax
  801185:	8a 00                	mov    (%eax),%al
  801187:	88 45 da             	mov    %al,-0x26(%ebp)

			//Writing (Modified) after freeing the entire FFL:
			//	4 frames should be allocated (4 stack pages)
			*(ptr4+1*PAGE_SIZE) = 'A';
  80118a:	a1 0c 40 80 00       	mov    0x80400c,%eax
  80118f:	05 00 10 00 00       	add    $0x1000,%eax
  801194:	c6 00 41             	movb   $0x41,(%eax)
			*(ptr4+2*PAGE_SIZE) = 'B';
  801197:	a1 0c 40 80 00       	mov    0x80400c,%eax
  80119c:	05 00 20 00 00       	add    $0x2000,%eax
  8011a1:	c6 00 42             	movb   $0x42,(%eax)
			*(ptr4+3*PAGE_SIZE) = 'C';
  8011a4:	a1 0c 40 80 00       	mov    0x80400c,%eax
  8011a9:	05 00 30 00 00       	add    $0x3000,%eax
  8011ae:	c6 00 43             	movb   $0x43,(%eax)
			*(ptr4+4*PAGE_SIZE) = 'D';
  8011b1:	a1 0c 40 80 00       	mov    0x80400c,%eax
  8011b6:	05 00 40 00 00       	add    $0x4000,%eax
  8011bb:	c6 00 44             	movb   $0x44,(%eax)
						ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) ==  0x802000)
					panic("test failed! either wrong victim or victim is not removed from WS");
			}
			 */
			//Check the WS after FIFO algorithm
			if (garbage4 != *ptr || garbage5 != *ptr2) panic("test failed!");
  8011be:	a1 00 40 80 00       	mov    0x804000,%eax
  8011c3:	8a 00                	mov    (%eax),%al
  8011c5:	3a 45 db             	cmp    -0x25(%ebp),%al
  8011c8:	75 0c                	jne    8011d6 <_main+0x119e>
  8011ca:	a1 04 40 80 00       	mov    0x804004,%eax
  8011cf:	8a 00                	mov    (%eax),%al
  8011d1:	3a 45 da             	cmp    -0x26(%ebp),%al
  8011d4:	74 17                	je     8011ed <_main+0x11b5>
  8011d6:	83 ec 04             	sub    $0x4,%esp
  8011d9:	68 a1 32 80 00       	push   $0x8032a1
  8011de:	68 69 01 00 00       	push   $0x169
  8011e3:	68 8a 31 80 00       	push   $0x80318a
  8011e8:	e8 d9 03 00 00       	call   8015c6 <_panic>

			//There should be two empty locations that are freed for the two tables (mem table and page file table)
			int numOfEmptyLocs = 0 ;
  8011ed:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
			for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  8011f4:	c7 45 b4 00 00 00 00 	movl   $0x0,-0x4c(%ebp)
  8011fb:	eb 20                	jmp    80121d <_main+0x11e5>
			{
				if (myEnv->__uptr_pws[i].empty)
  8011fd:	a1 20 40 80 00       	mov    0x804020,%eax
  801202:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801208:	8b 55 b4             	mov    -0x4c(%ebp),%edx
  80120b:	c1 e2 04             	shl    $0x4,%edx
  80120e:	01 d0                	add    %edx,%eax
  801210:	8a 40 04             	mov    0x4(%eax),%al
  801213:	84 c0                	test   %al,%al
  801215:	74 03                	je     80121a <_main+0x11e2>
					numOfEmptyLocs++ ;
  801217:	ff 45 b8             	incl   -0x48(%ebp)
			//Check the WS after FIFO algorithm
			if (garbage4 != *ptr || garbage5 != *ptr2) panic("test failed!");

			//There should be two empty locations that are freed for the two tables (mem table and page file table)
			int numOfEmptyLocs = 0 ;
			for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  80121a:	ff 45 b4             	incl   -0x4c(%ebp)
  80121d:	a1 20 40 80 00       	mov    0x804020,%eax
  801222:	8b 50 74             	mov    0x74(%eax),%edx
  801225:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  801228:	39 c2                	cmp    %eax,%edx
  80122a:	77 d1                	ja     8011fd <_main+0x11c5>
			{
				if (myEnv->__uptr_pws[i].empty)
					numOfEmptyLocs++ ;
			}
			if (numOfEmptyLocs != 2) panic("test failed! either wrong victim or victim is not removed from WS");
  80122c:	83 7d b8 02          	cmpl   $0x2,-0x48(%ebp)
  801230:	74 17                	je     801249 <_main+0x1211>
  801232:	83 ec 04             	sub    $0x4,%esp
  801235:	68 b0 32 80 00       	push   $0x8032b0
  80123a:	68 72 01 00 00       	push   $0x172
  80123f:	68 8a 31 80 00       	push   $0x80318a
  801244:	e8 7d 03 00 00       	call   8015c6 <_panic>

			uint32 expectedAddresses[24] = {0x801000,0x802000,0x803000,0x804000,0x805000,0x806000,0x807000,0x808000,0x809000,0x80a000,0x80b000,0x80c000,0x80d000,0x80e000,0x80f000,0x810000,0x811000,
  801249:	8d 85 6c fe ff ff    	lea    -0x194(%ebp),%eax
  80124f:	bb e0 33 80 00       	mov    $0x8033e0,%ebx
  801254:	ba 18 00 00 00       	mov    $0x18,%edx
  801259:	89 c7                	mov    %eax,%edi
  80125b:	89 de                	mov    %ebx,%esi
  80125d:	89 d1                	mov    %edx,%ecx
  80125f:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
					0xee3f9000,0xee3fa000,0xee3fb000,0xee3fc000,0xee3fd000,0xee7fe000,0xeebfd000} ;

			int numOfFoundedAddresses = 0;
  801261:	c7 45 b0 00 00 00 00 	movl   $0x0,-0x50(%ebp)
			for (int j = 0; j < 24; j++)
  801268:	c7 45 ac 00 00 00 00 	movl   $0x0,-0x54(%ebp)
  80126f:	eb 59                	jmp    8012ca <_main+0x1292>
			{
				for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  801271:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%ebp)
  801278:	eb 3e                	jmp    8012b8 <_main+0x1280>
				{
					if (ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == expectedAddresses[j])
  80127a:	a1 20 40 80 00       	mov    0x804020,%eax
  80127f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801285:	8b 55 a8             	mov    -0x58(%ebp),%edx
  801288:	c1 e2 04             	shl    $0x4,%edx
  80128b:	01 d0                	add    %edx,%eax
  80128d:	8b 00                	mov    (%eax),%eax
  80128f:	89 85 cc fe ff ff    	mov    %eax,-0x134(%ebp)
  801295:	8b 85 cc fe ff ff    	mov    -0x134(%ebp),%eax
  80129b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8012a0:	89 c2                	mov    %eax,%edx
  8012a2:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8012a5:	8b 84 85 6c fe ff ff 	mov    -0x194(%ebp,%eax,4),%eax
  8012ac:	39 c2                	cmp    %eax,%edx
  8012ae:	75 05                	jne    8012b5 <_main+0x127d>
					{
						numOfFoundedAddresses++;
  8012b0:	ff 45 b0             	incl   -0x50(%ebp)
						break;
  8012b3:	eb 12                	jmp    8012c7 <_main+0x128f>
					0xee3f9000,0xee3fa000,0xee3fb000,0xee3fc000,0xee3fd000,0xee7fe000,0xeebfd000} ;

			int numOfFoundedAddresses = 0;
			for (int j = 0; j < 24; j++)
			{
				for (int i = 0 ; i < myEnv->page_WS_max_size; i++)
  8012b5:	ff 45 a8             	incl   -0x58(%ebp)
  8012b8:	a1 20 40 80 00       	mov    0x804020,%eax
  8012bd:	8b 50 74             	mov    0x74(%eax),%edx
  8012c0:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8012c3:	39 c2                	cmp    %eax,%edx
  8012c5:	77 b3                	ja     80127a <_main+0x1242>

			uint32 expectedAddresses[24] = {0x801000,0x802000,0x803000,0x804000,0x805000,0x806000,0x807000,0x808000,0x809000,0x80a000,0x80b000,0x80c000,0x80d000,0x80e000,0x80f000,0x810000,0x811000,
					0xee3f9000,0xee3fa000,0xee3fb000,0xee3fc000,0xee3fd000,0xee7fe000,0xeebfd000} ;

			int numOfFoundedAddresses = 0;
			for (int j = 0; j < 24; j++)
  8012c7:	ff 45 ac             	incl   -0x54(%ebp)
  8012ca:	83 7d ac 17          	cmpl   $0x17,-0x54(%ebp)
  8012ce:	7e a1                	jle    801271 <_main+0x1239>
						numOfFoundedAddresses++;
						break;
					}
				}
			}
			if (numOfFoundedAddresses != 24) panic("test failed! either wrong victim or victim is not removed from WS");
  8012d0:	83 7d b0 18          	cmpl   $0x18,-0x50(%ebp)
  8012d4:	74 17                	je     8012ed <_main+0x12b5>
  8012d6:	83 ec 04             	sub    $0x4,%esp
  8012d9:	68 b0 32 80 00       	push   $0x8032b0
  8012de:	68 83 01 00 00       	push   $0x183
  8012e3:	68 8a 31 80 00       	push   $0x80318a
  8012e8:	e8 d9 02 00 00       	call   8015c6 <_panic>

		}


		//Check that the values are successfully stored
		for (i = 0 ; i < PAGE_SIZE*4 ; i+=PAGE_SIZE/2)
  8012ed:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  8012f4:	eb 2c                	jmp    801322 <_main+0x12ea>
		{
			//cprintf("i = %x, address = %x, arr[i] = %d\n", i, &(arr[i]), arr[i]);
			if (arr[i] != -1) panic("test failed!");
  8012f6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8012f9:	05 40 40 80 00       	add    $0x804040,%eax
  8012fe:	8a 00                	mov    (%eax),%al
  801300:	3c ff                	cmp    $0xff,%al
  801302:	74 17                	je     80131b <_main+0x12e3>
  801304:	83 ec 04             	sub    $0x4,%esp
  801307:	68 a1 32 80 00       	push   $0x8032a1
  80130c:	68 8d 01 00 00       	push   $0x18d
  801311:	68 8a 31 80 00       	push   $0x80318a
  801316:	e8 ab 02 00 00       	call   8015c6 <_panic>

		}


		//Check that the values are successfully stored
		for (i = 0 ; i < PAGE_SIZE*4 ; i+=PAGE_SIZE/2)
  80131b:	81 45 d4 00 08 00 00 	addl   $0x800,-0x2c(%ebp)
  801322:	81 7d d4 ff 3f 00 00 	cmpl   $0x3fff,-0x2c(%ebp)
  801329:	7e cb                	jle    8012f6 <_main+0x12be>
		{
			//cprintf("i = %x, address = %x, arr[i] = %d\n", i, &(arr[i]), arr[i]);
			if (arr[i] != -1) panic("test failed!");
		}
		if (*ptr3 != arr[PAGE_SIZE*10-1]) panic("test failed!");
  80132b:	a1 08 40 80 00       	mov    0x804008,%eax
  801330:	8a 10                	mov    (%eax),%dl
  801332:	a0 3f e0 80 00       	mov    0x80e03f,%al
  801337:	38 c2                	cmp    %al,%dl
  801339:	74 17                	je     801352 <_main+0x131a>
  80133b:	83 ec 04             	sub    $0x4,%esp
  80133e:	68 a1 32 80 00       	push   $0x8032a1
  801343:	68 8f 01 00 00       	push   $0x18f
  801348:	68 8a 31 80 00       	push   $0x80318a
  80134d:	e8 74 02 00 00       	call   8015c6 <_panic>


		if (testCase ==3)
  801352:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  801356:	0f 85 09 01 00 00    	jne    801465 <_main+0x142d>
		{
			//			cprintf("garbage4 = %d, *ptr = %d\n",garbage4, *ptr);
			if (garbage4 != *ptr) panic("test failed!");
  80135c:	a1 00 40 80 00       	mov    0x804000,%eax
  801361:	8a 00                	mov    (%eax),%al
  801363:	3a 45 db             	cmp    -0x25(%ebp),%al
  801366:	74 17                	je     80137f <_main+0x1347>
  801368:	83 ec 04             	sub    $0x4,%esp
  80136b:	68 a1 32 80 00       	push   $0x8032a1
  801370:	68 95 01 00 00       	push   $0x195
  801375:	68 8a 31 80 00       	push   $0x80318a
  80137a:	e8 47 02 00 00       	call   8015c6 <_panic>
			if (garbage5 != *ptr2) panic("test failed!");
  80137f:	a1 04 40 80 00       	mov    0x804004,%eax
  801384:	8a 00                	mov    (%eax),%al
  801386:	3a 45 da             	cmp    -0x26(%ebp),%al
  801389:	74 17                	je     8013a2 <_main+0x136a>
  80138b:	83 ec 04             	sub    $0x4,%esp
  80138e:	68 a1 32 80 00       	push   $0x8032a1
  801393:	68 96 01 00 00       	push   $0x196
  801398:	68 8a 31 80 00       	push   $0x80318a
  80139d:	e8 24 02 00 00       	call   8015c6 <_panic>

			if (*ptr4 != arr[PAGE_SIZE*11-1]) panic("test failed!");
  8013a2:	a1 0c 40 80 00       	mov    0x80400c,%eax
  8013a7:	8a 10                	mov    (%eax),%dl
  8013a9:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8013ae:	38 c2                	cmp    %al,%dl
  8013b0:	74 17                	je     8013c9 <_main+0x1391>
  8013b2:	83 ec 04             	sub    $0x4,%esp
  8013b5:	68 a1 32 80 00       	push   $0x8032a1
  8013ba:	68 98 01 00 00       	push   $0x198
  8013bf:	68 8a 31 80 00       	push   $0x80318a
  8013c4:	e8 fd 01 00 00       	call   8015c6 <_panic>
			if (*(ptr4+1*PAGE_SIZE) != 'A') panic("test failed!");
  8013c9:	a1 0c 40 80 00       	mov    0x80400c,%eax
  8013ce:	05 00 10 00 00       	add    $0x1000,%eax
  8013d3:	8a 00                	mov    (%eax),%al
  8013d5:	3c 41                	cmp    $0x41,%al
  8013d7:	74 17                	je     8013f0 <_main+0x13b8>
  8013d9:	83 ec 04             	sub    $0x4,%esp
  8013dc:	68 a1 32 80 00       	push   $0x8032a1
  8013e1:	68 99 01 00 00       	push   $0x199
  8013e6:	68 8a 31 80 00       	push   $0x80318a
  8013eb:	e8 d6 01 00 00       	call   8015c6 <_panic>
			if (*(ptr4+2*PAGE_SIZE) != 'B') panic("test failed!");
  8013f0:	a1 0c 40 80 00       	mov    0x80400c,%eax
  8013f5:	05 00 20 00 00       	add    $0x2000,%eax
  8013fa:	8a 00                	mov    (%eax),%al
  8013fc:	3c 42                	cmp    $0x42,%al
  8013fe:	74 17                	je     801417 <_main+0x13df>
  801400:	83 ec 04             	sub    $0x4,%esp
  801403:	68 a1 32 80 00       	push   $0x8032a1
  801408:	68 9a 01 00 00       	push   $0x19a
  80140d:	68 8a 31 80 00       	push   $0x80318a
  801412:	e8 af 01 00 00       	call   8015c6 <_panic>
			if (*(ptr4+3*PAGE_SIZE) != 'C') panic("test failed!");
  801417:	a1 0c 40 80 00       	mov    0x80400c,%eax
  80141c:	05 00 30 00 00       	add    $0x3000,%eax
  801421:	8a 00                	mov    (%eax),%al
  801423:	3c 43                	cmp    $0x43,%al
  801425:	74 17                	je     80143e <_main+0x1406>
  801427:	83 ec 04             	sub    $0x4,%esp
  80142a:	68 a1 32 80 00       	push   $0x8032a1
  80142f:	68 9b 01 00 00       	push   $0x19b
  801434:	68 8a 31 80 00       	push   $0x80318a
  801439:	e8 88 01 00 00       	call   8015c6 <_panic>
			if (*(ptr4+4*PAGE_SIZE) != 'D') panic("test failed!");
  80143e:	a1 0c 40 80 00       	mov    0x80400c,%eax
  801443:	05 00 40 00 00       	add    $0x4000,%eax
  801448:	8a 00                	mov    (%eax),%al
  80144a:	3c 44                	cmp    $0x44,%al
  80144c:	74 17                	je     801465 <_main+0x142d>
  80144e:	83 ec 04             	sub    $0x4,%esp
  801451:	68 a1 32 80 00       	push   $0x8032a1
  801456:	68 9c 01 00 00       	push   $0x19c
  80145b:	68 8a 31 80 00       	push   $0x80318a
  801460:	e8 61 01 00 00       	call   8015c6 <_panic>
		}
	}

	cprintf("Congratulations!! test freeRAM (Scenario# %d) completed successfully.\n", testCase);
  801465:	83 ec 08             	sub    $0x8,%esp
  801468:	ff 75 e4             	pushl  -0x1c(%ebp)
  80146b:	68 5c 33 80 00       	push   $0x80335c
  801470:	e8 f3 03 00 00       	call   801868 <cprintf>
  801475:	83 c4 10             	add    $0x10,%esp

	return;
  801478:	90                   	nop
}
  801479:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80147c:	5b                   	pop    %ebx
  80147d:	5e                   	pop    %esi
  80147e:	5f                   	pop    %edi
  80147f:	5d                   	pop    %ebp
  801480:	c3                   	ret    

00801481 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  801481:	55                   	push   %ebp
  801482:	89 e5                	mov    %esp,%ebp
  801484:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  801487:	e8 07 12 00 00       	call   802693 <sys_getenvindex>
  80148c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80148f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801492:	89 d0                	mov    %edx,%eax
  801494:	c1 e0 03             	shl    $0x3,%eax
  801497:	01 d0                	add    %edx,%eax
  801499:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8014a0:	01 c8                	add    %ecx,%eax
  8014a2:	01 c0                	add    %eax,%eax
  8014a4:	01 d0                	add    %edx,%eax
  8014a6:	01 c0                	add    %eax,%eax
  8014a8:	01 d0                	add    %edx,%eax
  8014aa:	89 c2                	mov    %eax,%edx
  8014ac:	c1 e2 05             	shl    $0x5,%edx
  8014af:	29 c2                	sub    %eax,%edx
  8014b1:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8014b8:	89 c2                	mov    %eax,%edx
  8014ba:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8014c0:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8014c5:	a1 20 40 80 00       	mov    0x804020,%eax
  8014ca:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8014d0:	84 c0                	test   %al,%al
  8014d2:	74 0f                	je     8014e3 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8014d4:	a1 20 40 80 00       	mov    0x804020,%eax
  8014d9:	05 40 3c 01 00       	add    $0x13c40,%eax
  8014de:	a3 10 40 80 00       	mov    %eax,0x804010

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8014e3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014e7:	7e 0a                	jle    8014f3 <libmain+0x72>
		binaryname = argv[0];
  8014e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ec:	8b 00                	mov    (%eax),%eax
  8014ee:	a3 10 40 80 00       	mov    %eax,0x804010

	// call user main routine
	_main(argc, argv);
  8014f3:	83 ec 08             	sub    $0x8,%esp
  8014f6:	ff 75 0c             	pushl  0xc(%ebp)
  8014f9:	ff 75 08             	pushl  0x8(%ebp)
  8014fc:	e8 37 eb ff ff       	call   800038 <_main>
  801501:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  801504:	e8 25 13 00 00       	call   80282e <sys_disable_interrupt>
	cprintf("**************************************\n");
  801509:	83 ec 0c             	sub    $0xc,%esp
  80150c:	68 58 34 80 00       	push   $0x803458
  801511:	e8 52 03 00 00       	call   801868 <cprintf>
  801516:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  801519:	a1 20 40 80 00       	mov    0x804020,%eax
  80151e:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  801524:	a1 20 40 80 00       	mov    0x804020,%eax
  801529:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80152f:	83 ec 04             	sub    $0x4,%esp
  801532:	52                   	push   %edx
  801533:	50                   	push   %eax
  801534:	68 80 34 80 00       	push   $0x803480
  801539:	e8 2a 03 00 00       	call   801868 <cprintf>
  80153e:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  801541:	a1 20 40 80 00       	mov    0x804020,%eax
  801546:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80154c:	a1 20 40 80 00       	mov    0x804020,%eax
  801551:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  801557:	83 ec 04             	sub    $0x4,%esp
  80155a:	52                   	push   %edx
  80155b:	50                   	push   %eax
  80155c:	68 a8 34 80 00       	push   $0x8034a8
  801561:	e8 02 03 00 00       	call   801868 <cprintf>
  801566:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  801569:	a1 20 40 80 00       	mov    0x804020,%eax
  80156e:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  801574:	83 ec 08             	sub    $0x8,%esp
  801577:	50                   	push   %eax
  801578:	68 e9 34 80 00       	push   $0x8034e9
  80157d:	e8 e6 02 00 00       	call   801868 <cprintf>
  801582:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  801585:	83 ec 0c             	sub    $0xc,%esp
  801588:	68 58 34 80 00       	push   $0x803458
  80158d:	e8 d6 02 00 00       	call   801868 <cprintf>
  801592:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  801595:	e8 ae 12 00 00       	call   802848 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80159a:	e8 19 00 00 00       	call   8015b8 <exit>
}
  80159f:	90                   	nop
  8015a0:	c9                   	leave  
  8015a1:	c3                   	ret    

008015a2 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8015a2:	55                   	push   %ebp
  8015a3:	89 e5                	mov    %esp,%ebp
  8015a5:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8015a8:	83 ec 0c             	sub    $0xc,%esp
  8015ab:	6a 00                	push   $0x0
  8015ad:	e8 ad 10 00 00       	call   80265f <sys_env_destroy>
  8015b2:	83 c4 10             	add    $0x10,%esp
}
  8015b5:	90                   	nop
  8015b6:	c9                   	leave  
  8015b7:	c3                   	ret    

008015b8 <exit>:

void
exit(void)
{
  8015b8:	55                   	push   %ebp
  8015b9:	89 e5                	mov    %esp,%ebp
  8015bb:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8015be:	e8 02 11 00 00       	call   8026c5 <sys_env_exit>
}
  8015c3:	90                   	nop
  8015c4:	c9                   	leave  
  8015c5:	c3                   	ret    

008015c6 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8015c6:	55                   	push   %ebp
  8015c7:	89 e5                	mov    %esp,%ebp
  8015c9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8015cc:	8d 45 10             	lea    0x10(%ebp),%eax
  8015cf:	83 c0 04             	add    $0x4,%eax
  8015d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8015d5:	a1 c4 10 81 00       	mov    0x8110c4,%eax
  8015da:	85 c0                	test   %eax,%eax
  8015dc:	74 16                	je     8015f4 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8015de:	a1 c4 10 81 00       	mov    0x8110c4,%eax
  8015e3:	83 ec 08             	sub    $0x8,%esp
  8015e6:	50                   	push   %eax
  8015e7:	68 00 35 80 00       	push   $0x803500
  8015ec:	e8 77 02 00 00       	call   801868 <cprintf>
  8015f1:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8015f4:	a1 10 40 80 00       	mov    0x804010,%eax
  8015f9:	ff 75 0c             	pushl  0xc(%ebp)
  8015fc:	ff 75 08             	pushl  0x8(%ebp)
  8015ff:	50                   	push   %eax
  801600:	68 05 35 80 00       	push   $0x803505
  801605:	e8 5e 02 00 00       	call   801868 <cprintf>
  80160a:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80160d:	8b 45 10             	mov    0x10(%ebp),%eax
  801610:	83 ec 08             	sub    $0x8,%esp
  801613:	ff 75 f4             	pushl  -0xc(%ebp)
  801616:	50                   	push   %eax
  801617:	e8 e1 01 00 00       	call   8017fd <vcprintf>
  80161c:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80161f:	83 ec 08             	sub    $0x8,%esp
  801622:	6a 00                	push   $0x0
  801624:	68 21 35 80 00       	push   $0x803521
  801629:	e8 cf 01 00 00       	call   8017fd <vcprintf>
  80162e:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801631:	e8 82 ff ff ff       	call   8015b8 <exit>

	// should not return here
	while (1) ;
  801636:	eb fe                	jmp    801636 <_panic+0x70>

00801638 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801638:	55                   	push   %ebp
  801639:	89 e5                	mov    %esp,%ebp
  80163b:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80163e:	a1 20 40 80 00       	mov    0x804020,%eax
  801643:	8b 50 74             	mov    0x74(%eax),%edx
  801646:	8b 45 0c             	mov    0xc(%ebp),%eax
  801649:	39 c2                	cmp    %eax,%edx
  80164b:	74 14                	je     801661 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80164d:	83 ec 04             	sub    $0x4,%esp
  801650:	68 24 35 80 00       	push   $0x803524
  801655:	6a 26                	push   $0x26
  801657:	68 70 35 80 00       	push   $0x803570
  80165c:	e8 65 ff ff ff       	call   8015c6 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801661:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801668:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80166f:	e9 b6 00 00 00       	jmp    80172a <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801674:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801677:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80167e:	8b 45 08             	mov    0x8(%ebp),%eax
  801681:	01 d0                	add    %edx,%eax
  801683:	8b 00                	mov    (%eax),%eax
  801685:	85 c0                	test   %eax,%eax
  801687:	75 08                	jne    801691 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801689:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80168c:	e9 96 00 00 00       	jmp    801727 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  801691:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801698:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80169f:	eb 5d                	jmp    8016fe <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8016a1:	a1 20 40 80 00       	mov    0x804020,%eax
  8016a6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8016ac:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8016af:	c1 e2 04             	shl    $0x4,%edx
  8016b2:	01 d0                	add    %edx,%eax
  8016b4:	8a 40 04             	mov    0x4(%eax),%al
  8016b7:	84 c0                	test   %al,%al
  8016b9:	75 40                	jne    8016fb <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8016bb:	a1 20 40 80 00       	mov    0x804020,%eax
  8016c0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8016c6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8016c9:	c1 e2 04             	shl    $0x4,%edx
  8016cc:	01 d0                	add    %edx,%eax
  8016ce:	8b 00                	mov    (%eax),%eax
  8016d0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8016d3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8016d6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8016db:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8016dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016e0:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8016e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ea:	01 c8                	add    %ecx,%eax
  8016ec:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8016ee:	39 c2                	cmp    %eax,%edx
  8016f0:	75 09                	jne    8016fb <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8016f2:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8016f9:	eb 12                	jmp    80170d <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8016fb:	ff 45 e8             	incl   -0x18(%ebp)
  8016fe:	a1 20 40 80 00       	mov    0x804020,%eax
  801703:	8b 50 74             	mov    0x74(%eax),%edx
  801706:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801709:	39 c2                	cmp    %eax,%edx
  80170b:	77 94                	ja     8016a1 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80170d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801711:	75 14                	jne    801727 <CheckWSWithoutLastIndex+0xef>
			panic(
  801713:	83 ec 04             	sub    $0x4,%esp
  801716:	68 7c 35 80 00       	push   $0x80357c
  80171b:	6a 3a                	push   $0x3a
  80171d:	68 70 35 80 00       	push   $0x803570
  801722:	e8 9f fe ff ff       	call   8015c6 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801727:	ff 45 f0             	incl   -0x10(%ebp)
  80172a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80172d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801730:	0f 8c 3e ff ff ff    	jl     801674 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801736:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80173d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801744:	eb 20                	jmp    801766 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801746:	a1 20 40 80 00       	mov    0x804020,%eax
  80174b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801751:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801754:	c1 e2 04             	shl    $0x4,%edx
  801757:	01 d0                	add    %edx,%eax
  801759:	8a 40 04             	mov    0x4(%eax),%al
  80175c:	3c 01                	cmp    $0x1,%al
  80175e:	75 03                	jne    801763 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  801760:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801763:	ff 45 e0             	incl   -0x20(%ebp)
  801766:	a1 20 40 80 00       	mov    0x804020,%eax
  80176b:	8b 50 74             	mov    0x74(%eax),%edx
  80176e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801771:	39 c2                	cmp    %eax,%edx
  801773:	77 d1                	ja     801746 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801775:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801778:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80177b:	74 14                	je     801791 <CheckWSWithoutLastIndex+0x159>
		panic(
  80177d:	83 ec 04             	sub    $0x4,%esp
  801780:	68 d0 35 80 00       	push   $0x8035d0
  801785:	6a 44                	push   $0x44
  801787:	68 70 35 80 00       	push   $0x803570
  80178c:	e8 35 fe ff ff       	call   8015c6 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801791:	90                   	nop
  801792:	c9                   	leave  
  801793:	c3                   	ret    

00801794 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  801794:	55                   	push   %ebp
  801795:	89 e5                	mov    %esp,%ebp
  801797:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80179a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80179d:	8b 00                	mov    (%eax),%eax
  80179f:	8d 48 01             	lea    0x1(%eax),%ecx
  8017a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017a5:	89 0a                	mov    %ecx,(%edx)
  8017a7:	8b 55 08             	mov    0x8(%ebp),%edx
  8017aa:	88 d1                	mov    %dl,%cl
  8017ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017af:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8017b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b6:	8b 00                	mov    (%eax),%eax
  8017b8:	3d ff 00 00 00       	cmp    $0xff,%eax
  8017bd:	75 2c                	jne    8017eb <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8017bf:	a0 24 40 80 00       	mov    0x804024,%al
  8017c4:	0f b6 c0             	movzbl %al,%eax
  8017c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017ca:	8b 12                	mov    (%edx),%edx
  8017cc:	89 d1                	mov    %edx,%ecx
  8017ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017d1:	83 c2 08             	add    $0x8,%edx
  8017d4:	83 ec 04             	sub    $0x4,%esp
  8017d7:	50                   	push   %eax
  8017d8:	51                   	push   %ecx
  8017d9:	52                   	push   %edx
  8017da:	e8 3e 0e 00 00       	call   80261d <sys_cputs>
  8017df:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8017e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8017eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ee:	8b 40 04             	mov    0x4(%eax),%eax
  8017f1:	8d 50 01             	lea    0x1(%eax),%edx
  8017f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017f7:	89 50 04             	mov    %edx,0x4(%eax)
}
  8017fa:	90                   	nop
  8017fb:	c9                   	leave  
  8017fc:	c3                   	ret    

008017fd <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8017fd:	55                   	push   %ebp
  8017fe:	89 e5                	mov    %esp,%ebp
  801800:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  801806:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80180d:	00 00 00 
	b.cnt = 0;
  801810:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  801817:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80181a:	ff 75 0c             	pushl  0xc(%ebp)
  80181d:	ff 75 08             	pushl  0x8(%ebp)
  801820:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801826:	50                   	push   %eax
  801827:	68 94 17 80 00       	push   $0x801794
  80182c:	e8 11 02 00 00       	call   801a42 <vprintfmt>
  801831:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  801834:	a0 24 40 80 00       	mov    0x804024,%al
  801839:	0f b6 c0             	movzbl %al,%eax
  80183c:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  801842:	83 ec 04             	sub    $0x4,%esp
  801845:	50                   	push   %eax
  801846:	52                   	push   %edx
  801847:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80184d:	83 c0 08             	add    $0x8,%eax
  801850:	50                   	push   %eax
  801851:	e8 c7 0d 00 00       	call   80261d <sys_cputs>
  801856:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  801859:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  801860:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  801866:	c9                   	leave  
  801867:	c3                   	ret    

00801868 <cprintf>:

int cprintf(const char *fmt, ...) {
  801868:	55                   	push   %ebp
  801869:	89 e5                	mov    %esp,%ebp
  80186b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80186e:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  801875:	8d 45 0c             	lea    0xc(%ebp),%eax
  801878:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80187b:	8b 45 08             	mov    0x8(%ebp),%eax
  80187e:	83 ec 08             	sub    $0x8,%esp
  801881:	ff 75 f4             	pushl  -0xc(%ebp)
  801884:	50                   	push   %eax
  801885:	e8 73 ff ff ff       	call   8017fd <vcprintf>
  80188a:	83 c4 10             	add    $0x10,%esp
  80188d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  801890:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801893:	c9                   	leave  
  801894:	c3                   	ret    

00801895 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  801895:	55                   	push   %ebp
  801896:	89 e5                	mov    %esp,%ebp
  801898:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80189b:	e8 8e 0f 00 00       	call   80282e <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8018a0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8018a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8018a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a9:	83 ec 08             	sub    $0x8,%esp
  8018ac:	ff 75 f4             	pushl  -0xc(%ebp)
  8018af:	50                   	push   %eax
  8018b0:	e8 48 ff ff ff       	call   8017fd <vcprintf>
  8018b5:	83 c4 10             	add    $0x10,%esp
  8018b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8018bb:	e8 88 0f 00 00       	call   802848 <sys_enable_interrupt>
	return cnt;
  8018c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8018c3:	c9                   	leave  
  8018c4:	c3                   	ret    

008018c5 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8018c5:	55                   	push   %ebp
  8018c6:	89 e5                	mov    %esp,%ebp
  8018c8:	53                   	push   %ebx
  8018c9:	83 ec 14             	sub    $0x14,%esp
  8018cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8018cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8018d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8018d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8018d8:	8b 45 18             	mov    0x18(%ebp),%eax
  8018db:	ba 00 00 00 00       	mov    $0x0,%edx
  8018e0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8018e3:	77 55                	ja     80193a <printnum+0x75>
  8018e5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8018e8:	72 05                	jb     8018ef <printnum+0x2a>
  8018ea:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018ed:	77 4b                	ja     80193a <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8018ef:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8018f2:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8018f5:	8b 45 18             	mov    0x18(%ebp),%eax
  8018f8:	ba 00 00 00 00       	mov    $0x0,%edx
  8018fd:	52                   	push   %edx
  8018fe:	50                   	push   %eax
  8018ff:	ff 75 f4             	pushl  -0xc(%ebp)
  801902:	ff 75 f0             	pushl  -0x10(%ebp)
  801905:	e8 fa 13 00 00       	call   802d04 <__udivdi3>
  80190a:	83 c4 10             	add    $0x10,%esp
  80190d:	83 ec 04             	sub    $0x4,%esp
  801910:	ff 75 20             	pushl  0x20(%ebp)
  801913:	53                   	push   %ebx
  801914:	ff 75 18             	pushl  0x18(%ebp)
  801917:	52                   	push   %edx
  801918:	50                   	push   %eax
  801919:	ff 75 0c             	pushl  0xc(%ebp)
  80191c:	ff 75 08             	pushl  0x8(%ebp)
  80191f:	e8 a1 ff ff ff       	call   8018c5 <printnum>
  801924:	83 c4 20             	add    $0x20,%esp
  801927:	eb 1a                	jmp    801943 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801929:	83 ec 08             	sub    $0x8,%esp
  80192c:	ff 75 0c             	pushl  0xc(%ebp)
  80192f:	ff 75 20             	pushl  0x20(%ebp)
  801932:	8b 45 08             	mov    0x8(%ebp),%eax
  801935:	ff d0                	call   *%eax
  801937:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80193a:	ff 4d 1c             	decl   0x1c(%ebp)
  80193d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801941:	7f e6                	jg     801929 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801943:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801946:	bb 00 00 00 00       	mov    $0x0,%ebx
  80194b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80194e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801951:	53                   	push   %ebx
  801952:	51                   	push   %ecx
  801953:	52                   	push   %edx
  801954:	50                   	push   %eax
  801955:	e8 ba 14 00 00       	call   802e14 <__umoddi3>
  80195a:	83 c4 10             	add    $0x10,%esp
  80195d:	05 34 38 80 00       	add    $0x803834,%eax
  801962:	8a 00                	mov    (%eax),%al
  801964:	0f be c0             	movsbl %al,%eax
  801967:	83 ec 08             	sub    $0x8,%esp
  80196a:	ff 75 0c             	pushl  0xc(%ebp)
  80196d:	50                   	push   %eax
  80196e:	8b 45 08             	mov    0x8(%ebp),%eax
  801971:	ff d0                	call   *%eax
  801973:	83 c4 10             	add    $0x10,%esp
}
  801976:	90                   	nop
  801977:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80197a:	c9                   	leave  
  80197b:	c3                   	ret    

0080197c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80197c:	55                   	push   %ebp
  80197d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80197f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801983:	7e 1c                	jle    8019a1 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801985:	8b 45 08             	mov    0x8(%ebp),%eax
  801988:	8b 00                	mov    (%eax),%eax
  80198a:	8d 50 08             	lea    0x8(%eax),%edx
  80198d:	8b 45 08             	mov    0x8(%ebp),%eax
  801990:	89 10                	mov    %edx,(%eax)
  801992:	8b 45 08             	mov    0x8(%ebp),%eax
  801995:	8b 00                	mov    (%eax),%eax
  801997:	83 e8 08             	sub    $0x8,%eax
  80199a:	8b 50 04             	mov    0x4(%eax),%edx
  80199d:	8b 00                	mov    (%eax),%eax
  80199f:	eb 40                	jmp    8019e1 <getuint+0x65>
	else if (lflag)
  8019a1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8019a5:	74 1e                	je     8019c5 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8019a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019aa:	8b 00                	mov    (%eax),%eax
  8019ac:	8d 50 04             	lea    0x4(%eax),%edx
  8019af:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b2:	89 10                	mov    %edx,(%eax)
  8019b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b7:	8b 00                	mov    (%eax),%eax
  8019b9:	83 e8 04             	sub    $0x4,%eax
  8019bc:	8b 00                	mov    (%eax),%eax
  8019be:	ba 00 00 00 00       	mov    $0x0,%edx
  8019c3:	eb 1c                	jmp    8019e1 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8019c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c8:	8b 00                	mov    (%eax),%eax
  8019ca:	8d 50 04             	lea    0x4(%eax),%edx
  8019cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d0:	89 10                	mov    %edx,(%eax)
  8019d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d5:	8b 00                	mov    (%eax),%eax
  8019d7:	83 e8 04             	sub    $0x4,%eax
  8019da:	8b 00                	mov    (%eax),%eax
  8019dc:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8019e1:	5d                   	pop    %ebp
  8019e2:	c3                   	ret    

008019e3 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8019e3:	55                   	push   %ebp
  8019e4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8019e6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8019ea:	7e 1c                	jle    801a08 <getint+0x25>
		return va_arg(*ap, long long);
  8019ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ef:	8b 00                	mov    (%eax),%eax
  8019f1:	8d 50 08             	lea    0x8(%eax),%edx
  8019f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f7:	89 10                	mov    %edx,(%eax)
  8019f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fc:	8b 00                	mov    (%eax),%eax
  8019fe:	83 e8 08             	sub    $0x8,%eax
  801a01:	8b 50 04             	mov    0x4(%eax),%edx
  801a04:	8b 00                	mov    (%eax),%eax
  801a06:	eb 38                	jmp    801a40 <getint+0x5d>
	else if (lflag)
  801a08:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801a0c:	74 1a                	je     801a28 <getint+0x45>
		return va_arg(*ap, long);
  801a0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a11:	8b 00                	mov    (%eax),%eax
  801a13:	8d 50 04             	lea    0x4(%eax),%edx
  801a16:	8b 45 08             	mov    0x8(%ebp),%eax
  801a19:	89 10                	mov    %edx,(%eax)
  801a1b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a1e:	8b 00                	mov    (%eax),%eax
  801a20:	83 e8 04             	sub    $0x4,%eax
  801a23:	8b 00                	mov    (%eax),%eax
  801a25:	99                   	cltd   
  801a26:	eb 18                	jmp    801a40 <getint+0x5d>
	else
		return va_arg(*ap, int);
  801a28:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2b:	8b 00                	mov    (%eax),%eax
  801a2d:	8d 50 04             	lea    0x4(%eax),%edx
  801a30:	8b 45 08             	mov    0x8(%ebp),%eax
  801a33:	89 10                	mov    %edx,(%eax)
  801a35:	8b 45 08             	mov    0x8(%ebp),%eax
  801a38:	8b 00                	mov    (%eax),%eax
  801a3a:	83 e8 04             	sub    $0x4,%eax
  801a3d:	8b 00                	mov    (%eax),%eax
  801a3f:	99                   	cltd   
}
  801a40:	5d                   	pop    %ebp
  801a41:	c3                   	ret    

00801a42 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801a42:	55                   	push   %ebp
  801a43:	89 e5                	mov    %esp,%ebp
  801a45:	56                   	push   %esi
  801a46:	53                   	push   %ebx
  801a47:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801a4a:	eb 17                	jmp    801a63 <vprintfmt+0x21>
			if (ch == '\0')
  801a4c:	85 db                	test   %ebx,%ebx
  801a4e:	0f 84 af 03 00 00    	je     801e03 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801a54:	83 ec 08             	sub    $0x8,%esp
  801a57:	ff 75 0c             	pushl  0xc(%ebp)
  801a5a:	53                   	push   %ebx
  801a5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5e:	ff d0                	call   *%eax
  801a60:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801a63:	8b 45 10             	mov    0x10(%ebp),%eax
  801a66:	8d 50 01             	lea    0x1(%eax),%edx
  801a69:	89 55 10             	mov    %edx,0x10(%ebp)
  801a6c:	8a 00                	mov    (%eax),%al
  801a6e:	0f b6 d8             	movzbl %al,%ebx
  801a71:	83 fb 25             	cmp    $0x25,%ebx
  801a74:	75 d6                	jne    801a4c <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801a76:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801a7a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801a81:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801a88:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801a8f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801a96:	8b 45 10             	mov    0x10(%ebp),%eax
  801a99:	8d 50 01             	lea    0x1(%eax),%edx
  801a9c:	89 55 10             	mov    %edx,0x10(%ebp)
  801a9f:	8a 00                	mov    (%eax),%al
  801aa1:	0f b6 d8             	movzbl %al,%ebx
  801aa4:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801aa7:	83 f8 55             	cmp    $0x55,%eax
  801aaa:	0f 87 2b 03 00 00    	ja     801ddb <vprintfmt+0x399>
  801ab0:	8b 04 85 58 38 80 00 	mov    0x803858(,%eax,4),%eax
  801ab7:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801ab9:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801abd:	eb d7                	jmp    801a96 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801abf:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801ac3:	eb d1                	jmp    801a96 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801ac5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801acc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801acf:	89 d0                	mov    %edx,%eax
  801ad1:	c1 e0 02             	shl    $0x2,%eax
  801ad4:	01 d0                	add    %edx,%eax
  801ad6:	01 c0                	add    %eax,%eax
  801ad8:	01 d8                	add    %ebx,%eax
  801ada:	83 e8 30             	sub    $0x30,%eax
  801add:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801ae0:	8b 45 10             	mov    0x10(%ebp),%eax
  801ae3:	8a 00                	mov    (%eax),%al
  801ae5:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801ae8:	83 fb 2f             	cmp    $0x2f,%ebx
  801aeb:	7e 3e                	jle    801b2b <vprintfmt+0xe9>
  801aed:	83 fb 39             	cmp    $0x39,%ebx
  801af0:	7f 39                	jg     801b2b <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801af2:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801af5:	eb d5                	jmp    801acc <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801af7:	8b 45 14             	mov    0x14(%ebp),%eax
  801afa:	83 c0 04             	add    $0x4,%eax
  801afd:	89 45 14             	mov    %eax,0x14(%ebp)
  801b00:	8b 45 14             	mov    0x14(%ebp),%eax
  801b03:	83 e8 04             	sub    $0x4,%eax
  801b06:	8b 00                	mov    (%eax),%eax
  801b08:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801b0b:	eb 1f                	jmp    801b2c <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801b0d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801b11:	79 83                	jns    801a96 <vprintfmt+0x54>
				width = 0;
  801b13:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801b1a:	e9 77 ff ff ff       	jmp    801a96 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801b1f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801b26:	e9 6b ff ff ff       	jmp    801a96 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801b2b:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801b2c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801b30:	0f 89 60 ff ff ff    	jns    801a96 <vprintfmt+0x54>
				width = precision, precision = -1;
  801b36:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b39:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801b3c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801b43:	e9 4e ff ff ff       	jmp    801a96 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801b48:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801b4b:	e9 46 ff ff ff       	jmp    801a96 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801b50:	8b 45 14             	mov    0x14(%ebp),%eax
  801b53:	83 c0 04             	add    $0x4,%eax
  801b56:	89 45 14             	mov    %eax,0x14(%ebp)
  801b59:	8b 45 14             	mov    0x14(%ebp),%eax
  801b5c:	83 e8 04             	sub    $0x4,%eax
  801b5f:	8b 00                	mov    (%eax),%eax
  801b61:	83 ec 08             	sub    $0x8,%esp
  801b64:	ff 75 0c             	pushl  0xc(%ebp)
  801b67:	50                   	push   %eax
  801b68:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6b:	ff d0                	call   *%eax
  801b6d:	83 c4 10             	add    $0x10,%esp
			break;
  801b70:	e9 89 02 00 00       	jmp    801dfe <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801b75:	8b 45 14             	mov    0x14(%ebp),%eax
  801b78:	83 c0 04             	add    $0x4,%eax
  801b7b:	89 45 14             	mov    %eax,0x14(%ebp)
  801b7e:	8b 45 14             	mov    0x14(%ebp),%eax
  801b81:	83 e8 04             	sub    $0x4,%eax
  801b84:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801b86:	85 db                	test   %ebx,%ebx
  801b88:	79 02                	jns    801b8c <vprintfmt+0x14a>
				err = -err;
  801b8a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801b8c:	83 fb 64             	cmp    $0x64,%ebx
  801b8f:	7f 0b                	jg     801b9c <vprintfmt+0x15a>
  801b91:	8b 34 9d a0 36 80 00 	mov    0x8036a0(,%ebx,4),%esi
  801b98:	85 f6                	test   %esi,%esi
  801b9a:	75 19                	jne    801bb5 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801b9c:	53                   	push   %ebx
  801b9d:	68 45 38 80 00       	push   $0x803845
  801ba2:	ff 75 0c             	pushl  0xc(%ebp)
  801ba5:	ff 75 08             	pushl  0x8(%ebp)
  801ba8:	e8 5e 02 00 00       	call   801e0b <printfmt>
  801bad:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801bb0:	e9 49 02 00 00       	jmp    801dfe <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801bb5:	56                   	push   %esi
  801bb6:	68 4e 38 80 00       	push   $0x80384e
  801bbb:	ff 75 0c             	pushl  0xc(%ebp)
  801bbe:	ff 75 08             	pushl  0x8(%ebp)
  801bc1:	e8 45 02 00 00       	call   801e0b <printfmt>
  801bc6:	83 c4 10             	add    $0x10,%esp
			break;
  801bc9:	e9 30 02 00 00       	jmp    801dfe <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801bce:	8b 45 14             	mov    0x14(%ebp),%eax
  801bd1:	83 c0 04             	add    $0x4,%eax
  801bd4:	89 45 14             	mov    %eax,0x14(%ebp)
  801bd7:	8b 45 14             	mov    0x14(%ebp),%eax
  801bda:	83 e8 04             	sub    $0x4,%eax
  801bdd:	8b 30                	mov    (%eax),%esi
  801bdf:	85 f6                	test   %esi,%esi
  801be1:	75 05                	jne    801be8 <vprintfmt+0x1a6>
				p = "(null)";
  801be3:	be 51 38 80 00       	mov    $0x803851,%esi
			if (width > 0 && padc != '-')
  801be8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801bec:	7e 6d                	jle    801c5b <vprintfmt+0x219>
  801bee:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801bf2:	74 67                	je     801c5b <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801bf4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801bf7:	83 ec 08             	sub    $0x8,%esp
  801bfa:	50                   	push   %eax
  801bfb:	56                   	push   %esi
  801bfc:	e8 0c 03 00 00       	call   801f0d <strnlen>
  801c01:	83 c4 10             	add    $0x10,%esp
  801c04:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801c07:	eb 16                	jmp    801c1f <vprintfmt+0x1dd>
					putch(padc, putdat);
  801c09:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801c0d:	83 ec 08             	sub    $0x8,%esp
  801c10:	ff 75 0c             	pushl  0xc(%ebp)
  801c13:	50                   	push   %eax
  801c14:	8b 45 08             	mov    0x8(%ebp),%eax
  801c17:	ff d0                	call   *%eax
  801c19:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801c1c:	ff 4d e4             	decl   -0x1c(%ebp)
  801c1f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801c23:	7f e4                	jg     801c09 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801c25:	eb 34                	jmp    801c5b <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801c27:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801c2b:	74 1c                	je     801c49 <vprintfmt+0x207>
  801c2d:	83 fb 1f             	cmp    $0x1f,%ebx
  801c30:	7e 05                	jle    801c37 <vprintfmt+0x1f5>
  801c32:	83 fb 7e             	cmp    $0x7e,%ebx
  801c35:	7e 12                	jle    801c49 <vprintfmt+0x207>
					putch('?', putdat);
  801c37:	83 ec 08             	sub    $0x8,%esp
  801c3a:	ff 75 0c             	pushl  0xc(%ebp)
  801c3d:	6a 3f                	push   $0x3f
  801c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c42:	ff d0                	call   *%eax
  801c44:	83 c4 10             	add    $0x10,%esp
  801c47:	eb 0f                	jmp    801c58 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801c49:	83 ec 08             	sub    $0x8,%esp
  801c4c:	ff 75 0c             	pushl  0xc(%ebp)
  801c4f:	53                   	push   %ebx
  801c50:	8b 45 08             	mov    0x8(%ebp),%eax
  801c53:	ff d0                	call   *%eax
  801c55:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801c58:	ff 4d e4             	decl   -0x1c(%ebp)
  801c5b:	89 f0                	mov    %esi,%eax
  801c5d:	8d 70 01             	lea    0x1(%eax),%esi
  801c60:	8a 00                	mov    (%eax),%al
  801c62:	0f be d8             	movsbl %al,%ebx
  801c65:	85 db                	test   %ebx,%ebx
  801c67:	74 24                	je     801c8d <vprintfmt+0x24b>
  801c69:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801c6d:	78 b8                	js     801c27 <vprintfmt+0x1e5>
  801c6f:	ff 4d e0             	decl   -0x20(%ebp)
  801c72:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801c76:	79 af                	jns    801c27 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801c78:	eb 13                	jmp    801c8d <vprintfmt+0x24b>
				putch(' ', putdat);
  801c7a:	83 ec 08             	sub    $0x8,%esp
  801c7d:	ff 75 0c             	pushl  0xc(%ebp)
  801c80:	6a 20                	push   $0x20
  801c82:	8b 45 08             	mov    0x8(%ebp),%eax
  801c85:	ff d0                	call   *%eax
  801c87:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801c8a:	ff 4d e4             	decl   -0x1c(%ebp)
  801c8d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801c91:	7f e7                	jg     801c7a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801c93:	e9 66 01 00 00       	jmp    801dfe <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801c98:	83 ec 08             	sub    $0x8,%esp
  801c9b:	ff 75 e8             	pushl  -0x18(%ebp)
  801c9e:	8d 45 14             	lea    0x14(%ebp),%eax
  801ca1:	50                   	push   %eax
  801ca2:	e8 3c fd ff ff       	call   8019e3 <getint>
  801ca7:	83 c4 10             	add    $0x10,%esp
  801caa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801cad:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801cb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cb3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801cb6:	85 d2                	test   %edx,%edx
  801cb8:	79 23                	jns    801cdd <vprintfmt+0x29b>
				putch('-', putdat);
  801cba:	83 ec 08             	sub    $0x8,%esp
  801cbd:	ff 75 0c             	pushl  0xc(%ebp)
  801cc0:	6a 2d                	push   $0x2d
  801cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc5:	ff d0                	call   *%eax
  801cc7:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801cca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ccd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801cd0:	f7 d8                	neg    %eax
  801cd2:	83 d2 00             	adc    $0x0,%edx
  801cd5:	f7 da                	neg    %edx
  801cd7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801cda:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801cdd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801ce4:	e9 bc 00 00 00       	jmp    801da5 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801ce9:	83 ec 08             	sub    $0x8,%esp
  801cec:	ff 75 e8             	pushl  -0x18(%ebp)
  801cef:	8d 45 14             	lea    0x14(%ebp),%eax
  801cf2:	50                   	push   %eax
  801cf3:	e8 84 fc ff ff       	call   80197c <getuint>
  801cf8:	83 c4 10             	add    $0x10,%esp
  801cfb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801cfe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801d01:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801d08:	e9 98 00 00 00       	jmp    801da5 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801d0d:	83 ec 08             	sub    $0x8,%esp
  801d10:	ff 75 0c             	pushl  0xc(%ebp)
  801d13:	6a 58                	push   $0x58
  801d15:	8b 45 08             	mov    0x8(%ebp),%eax
  801d18:	ff d0                	call   *%eax
  801d1a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801d1d:	83 ec 08             	sub    $0x8,%esp
  801d20:	ff 75 0c             	pushl  0xc(%ebp)
  801d23:	6a 58                	push   $0x58
  801d25:	8b 45 08             	mov    0x8(%ebp),%eax
  801d28:	ff d0                	call   *%eax
  801d2a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801d2d:	83 ec 08             	sub    $0x8,%esp
  801d30:	ff 75 0c             	pushl  0xc(%ebp)
  801d33:	6a 58                	push   $0x58
  801d35:	8b 45 08             	mov    0x8(%ebp),%eax
  801d38:	ff d0                	call   *%eax
  801d3a:	83 c4 10             	add    $0x10,%esp
			break;
  801d3d:	e9 bc 00 00 00       	jmp    801dfe <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801d42:	83 ec 08             	sub    $0x8,%esp
  801d45:	ff 75 0c             	pushl  0xc(%ebp)
  801d48:	6a 30                	push   $0x30
  801d4a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4d:	ff d0                	call   *%eax
  801d4f:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801d52:	83 ec 08             	sub    $0x8,%esp
  801d55:	ff 75 0c             	pushl  0xc(%ebp)
  801d58:	6a 78                	push   $0x78
  801d5a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5d:	ff d0                	call   *%eax
  801d5f:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801d62:	8b 45 14             	mov    0x14(%ebp),%eax
  801d65:	83 c0 04             	add    $0x4,%eax
  801d68:	89 45 14             	mov    %eax,0x14(%ebp)
  801d6b:	8b 45 14             	mov    0x14(%ebp),%eax
  801d6e:	83 e8 04             	sub    $0x4,%eax
  801d71:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801d73:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801d76:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801d7d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801d84:	eb 1f                	jmp    801da5 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801d86:	83 ec 08             	sub    $0x8,%esp
  801d89:	ff 75 e8             	pushl  -0x18(%ebp)
  801d8c:	8d 45 14             	lea    0x14(%ebp),%eax
  801d8f:	50                   	push   %eax
  801d90:	e8 e7 fb ff ff       	call   80197c <getuint>
  801d95:	83 c4 10             	add    $0x10,%esp
  801d98:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801d9b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801d9e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801da5:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801da9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801dac:	83 ec 04             	sub    $0x4,%esp
  801daf:	52                   	push   %edx
  801db0:	ff 75 e4             	pushl  -0x1c(%ebp)
  801db3:	50                   	push   %eax
  801db4:	ff 75 f4             	pushl  -0xc(%ebp)
  801db7:	ff 75 f0             	pushl  -0x10(%ebp)
  801dba:	ff 75 0c             	pushl  0xc(%ebp)
  801dbd:	ff 75 08             	pushl  0x8(%ebp)
  801dc0:	e8 00 fb ff ff       	call   8018c5 <printnum>
  801dc5:	83 c4 20             	add    $0x20,%esp
			break;
  801dc8:	eb 34                	jmp    801dfe <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801dca:	83 ec 08             	sub    $0x8,%esp
  801dcd:	ff 75 0c             	pushl  0xc(%ebp)
  801dd0:	53                   	push   %ebx
  801dd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd4:	ff d0                	call   *%eax
  801dd6:	83 c4 10             	add    $0x10,%esp
			break;
  801dd9:	eb 23                	jmp    801dfe <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801ddb:	83 ec 08             	sub    $0x8,%esp
  801dde:	ff 75 0c             	pushl  0xc(%ebp)
  801de1:	6a 25                	push   $0x25
  801de3:	8b 45 08             	mov    0x8(%ebp),%eax
  801de6:	ff d0                	call   *%eax
  801de8:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801deb:	ff 4d 10             	decl   0x10(%ebp)
  801dee:	eb 03                	jmp    801df3 <vprintfmt+0x3b1>
  801df0:	ff 4d 10             	decl   0x10(%ebp)
  801df3:	8b 45 10             	mov    0x10(%ebp),%eax
  801df6:	48                   	dec    %eax
  801df7:	8a 00                	mov    (%eax),%al
  801df9:	3c 25                	cmp    $0x25,%al
  801dfb:	75 f3                	jne    801df0 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801dfd:	90                   	nop
		}
	}
  801dfe:	e9 47 fc ff ff       	jmp    801a4a <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801e03:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801e04:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801e07:	5b                   	pop    %ebx
  801e08:	5e                   	pop    %esi
  801e09:	5d                   	pop    %ebp
  801e0a:	c3                   	ret    

00801e0b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801e0b:	55                   	push   %ebp
  801e0c:	89 e5                	mov    %esp,%ebp
  801e0e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801e11:	8d 45 10             	lea    0x10(%ebp),%eax
  801e14:	83 c0 04             	add    $0x4,%eax
  801e17:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801e1a:	8b 45 10             	mov    0x10(%ebp),%eax
  801e1d:	ff 75 f4             	pushl  -0xc(%ebp)
  801e20:	50                   	push   %eax
  801e21:	ff 75 0c             	pushl  0xc(%ebp)
  801e24:	ff 75 08             	pushl  0x8(%ebp)
  801e27:	e8 16 fc ff ff       	call   801a42 <vprintfmt>
  801e2c:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801e2f:	90                   	nop
  801e30:	c9                   	leave  
  801e31:	c3                   	ret    

00801e32 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801e32:	55                   	push   %ebp
  801e33:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801e35:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e38:	8b 40 08             	mov    0x8(%eax),%eax
  801e3b:	8d 50 01             	lea    0x1(%eax),%edx
  801e3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e41:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801e44:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e47:	8b 10                	mov    (%eax),%edx
  801e49:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e4c:	8b 40 04             	mov    0x4(%eax),%eax
  801e4f:	39 c2                	cmp    %eax,%edx
  801e51:	73 12                	jae    801e65 <sprintputch+0x33>
		*b->buf++ = ch;
  801e53:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e56:	8b 00                	mov    (%eax),%eax
  801e58:	8d 48 01             	lea    0x1(%eax),%ecx
  801e5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e5e:	89 0a                	mov    %ecx,(%edx)
  801e60:	8b 55 08             	mov    0x8(%ebp),%edx
  801e63:	88 10                	mov    %dl,(%eax)
}
  801e65:	90                   	nop
  801e66:	5d                   	pop    %ebp
  801e67:	c3                   	ret    

00801e68 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801e68:	55                   	push   %ebp
  801e69:	89 e5                	mov    %esp,%ebp
  801e6b:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e71:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801e74:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e77:	8d 50 ff             	lea    -0x1(%eax),%edx
  801e7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e7d:	01 d0                	add    %edx,%eax
  801e7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801e82:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801e89:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801e8d:	74 06                	je     801e95 <vsnprintf+0x2d>
  801e8f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801e93:	7f 07                	jg     801e9c <vsnprintf+0x34>
		return -E_INVAL;
  801e95:	b8 03 00 00 00       	mov    $0x3,%eax
  801e9a:	eb 20                	jmp    801ebc <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801e9c:	ff 75 14             	pushl  0x14(%ebp)
  801e9f:	ff 75 10             	pushl  0x10(%ebp)
  801ea2:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801ea5:	50                   	push   %eax
  801ea6:	68 32 1e 80 00       	push   $0x801e32
  801eab:	e8 92 fb ff ff       	call   801a42 <vprintfmt>
  801eb0:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801eb3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801eb6:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801eb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801ebc:	c9                   	leave  
  801ebd:	c3                   	ret    

00801ebe <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801ebe:	55                   	push   %ebp
  801ebf:	89 e5                	mov    %esp,%ebp
  801ec1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801ec4:	8d 45 10             	lea    0x10(%ebp),%eax
  801ec7:	83 c0 04             	add    $0x4,%eax
  801eca:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801ecd:	8b 45 10             	mov    0x10(%ebp),%eax
  801ed0:	ff 75 f4             	pushl  -0xc(%ebp)
  801ed3:	50                   	push   %eax
  801ed4:	ff 75 0c             	pushl  0xc(%ebp)
  801ed7:	ff 75 08             	pushl  0x8(%ebp)
  801eda:	e8 89 ff ff ff       	call   801e68 <vsnprintf>
  801edf:	83 c4 10             	add    $0x10,%esp
  801ee2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801ee5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ee8:	c9                   	leave  
  801ee9:	c3                   	ret    

00801eea <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801eea:	55                   	push   %ebp
  801eeb:	89 e5                	mov    %esp,%ebp
  801eed:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801ef0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801ef7:	eb 06                	jmp    801eff <strlen+0x15>
		n++;
  801ef9:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801efc:	ff 45 08             	incl   0x8(%ebp)
  801eff:	8b 45 08             	mov    0x8(%ebp),%eax
  801f02:	8a 00                	mov    (%eax),%al
  801f04:	84 c0                	test   %al,%al
  801f06:	75 f1                	jne    801ef9 <strlen+0xf>
		n++;
	return n;
  801f08:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801f0b:	c9                   	leave  
  801f0c:	c3                   	ret    

00801f0d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801f0d:	55                   	push   %ebp
  801f0e:	89 e5                	mov    %esp,%ebp
  801f10:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801f13:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801f1a:	eb 09                	jmp    801f25 <strnlen+0x18>
		n++;
  801f1c:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801f1f:	ff 45 08             	incl   0x8(%ebp)
  801f22:	ff 4d 0c             	decl   0xc(%ebp)
  801f25:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801f29:	74 09                	je     801f34 <strnlen+0x27>
  801f2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2e:	8a 00                	mov    (%eax),%al
  801f30:	84 c0                	test   %al,%al
  801f32:	75 e8                	jne    801f1c <strnlen+0xf>
		n++;
	return n;
  801f34:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801f37:	c9                   	leave  
  801f38:	c3                   	ret    

00801f39 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801f39:	55                   	push   %ebp
  801f3a:	89 e5                	mov    %esp,%ebp
  801f3c:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801f3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f42:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801f45:	90                   	nop
  801f46:	8b 45 08             	mov    0x8(%ebp),%eax
  801f49:	8d 50 01             	lea    0x1(%eax),%edx
  801f4c:	89 55 08             	mov    %edx,0x8(%ebp)
  801f4f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f52:	8d 4a 01             	lea    0x1(%edx),%ecx
  801f55:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801f58:	8a 12                	mov    (%edx),%dl
  801f5a:	88 10                	mov    %dl,(%eax)
  801f5c:	8a 00                	mov    (%eax),%al
  801f5e:	84 c0                	test   %al,%al
  801f60:	75 e4                	jne    801f46 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801f62:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801f65:	c9                   	leave  
  801f66:	c3                   	ret    

00801f67 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801f67:	55                   	push   %ebp
  801f68:	89 e5                	mov    %esp,%ebp
  801f6a:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f70:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801f73:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801f7a:	eb 1f                	jmp    801f9b <strncpy+0x34>
		*dst++ = *src;
  801f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f7f:	8d 50 01             	lea    0x1(%eax),%edx
  801f82:	89 55 08             	mov    %edx,0x8(%ebp)
  801f85:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f88:	8a 12                	mov    (%edx),%dl
  801f8a:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801f8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f8f:	8a 00                	mov    (%eax),%al
  801f91:	84 c0                	test   %al,%al
  801f93:	74 03                	je     801f98 <strncpy+0x31>
			src++;
  801f95:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801f98:	ff 45 fc             	incl   -0x4(%ebp)
  801f9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801f9e:	3b 45 10             	cmp    0x10(%ebp),%eax
  801fa1:	72 d9                	jb     801f7c <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801fa3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801fa6:	c9                   	leave  
  801fa7:	c3                   	ret    

00801fa8 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801fa8:	55                   	push   %ebp
  801fa9:	89 e5                	mov    %esp,%ebp
  801fab:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801fae:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801fb4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801fb8:	74 30                	je     801fea <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801fba:	eb 16                	jmp    801fd2 <strlcpy+0x2a>
			*dst++ = *src++;
  801fbc:	8b 45 08             	mov    0x8(%ebp),%eax
  801fbf:	8d 50 01             	lea    0x1(%eax),%edx
  801fc2:	89 55 08             	mov    %edx,0x8(%ebp)
  801fc5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fc8:	8d 4a 01             	lea    0x1(%edx),%ecx
  801fcb:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801fce:	8a 12                	mov    (%edx),%dl
  801fd0:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801fd2:	ff 4d 10             	decl   0x10(%ebp)
  801fd5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801fd9:	74 09                	je     801fe4 <strlcpy+0x3c>
  801fdb:	8b 45 0c             	mov    0xc(%ebp),%eax
  801fde:	8a 00                	mov    (%eax),%al
  801fe0:	84 c0                	test   %al,%al
  801fe2:	75 d8                	jne    801fbc <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801fe4:	8b 45 08             	mov    0x8(%ebp),%eax
  801fe7:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801fea:	8b 55 08             	mov    0x8(%ebp),%edx
  801fed:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ff0:	29 c2                	sub    %eax,%edx
  801ff2:	89 d0                	mov    %edx,%eax
}
  801ff4:	c9                   	leave  
  801ff5:	c3                   	ret    

00801ff6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801ff6:	55                   	push   %ebp
  801ff7:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801ff9:	eb 06                	jmp    802001 <strcmp+0xb>
		p++, q++;
  801ffb:	ff 45 08             	incl   0x8(%ebp)
  801ffe:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  802001:	8b 45 08             	mov    0x8(%ebp),%eax
  802004:	8a 00                	mov    (%eax),%al
  802006:	84 c0                	test   %al,%al
  802008:	74 0e                	je     802018 <strcmp+0x22>
  80200a:	8b 45 08             	mov    0x8(%ebp),%eax
  80200d:	8a 10                	mov    (%eax),%dl
  80200f:	8b 45 0c             	mov    0xc(%ebp),%eax
  802012:	8a 00                	mov    (%eax),%al
  802014:	38 c2                	cmp    %al,%dl
  802016:	74 e3                	je     801ffb <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  802018:	8b 45 08             	mov    0x8(%ebp),%eax
  80201b:	8a 00                	mov    (%eax),%al
  80201d:	0f b6 d0             	movzbl %al,%edx
  802020:	8b 45 0c             	mov    0xc(%ebp),%eax
  802023:	8a 00                	mov    (%eax),%al
  802025:	0f b6 c0             	movzbl %al,%eax
  802028:	29 c2                	sub    %eax,%edx
  80202a:	89 d0                	mov    %edx,%eax
}
  80202c:	5d                   	pop    %ebp
  80202d:	c3                   	ret    

0080202e <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80202e:	55                   	push   %ebp
  80202f:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  802031:	eb 09                	jmp    80203c <strncmp+0xe>
		n--, p++, q++;
  802033:	ff 4d 10             	decl   0x10(%ebp)
  802036:	ff 45 08             	incl   0x8(%ebp)
  802039:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80203c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802040:	74 17                	je     802059 <strncmp+0x2b>
  802042:	8b 45 08             	mov    0x8(%ebp),%eax
  802045:	8a 00                	mov    (%eax),%al
  802047:	84 c0                	test   %al,%al
  802049:	74 0e                	je     802059 <strncmp+0x2b>
  80204b:	8b 45 08             	mov    0x8(%ebp),%eax
  80204e:	8a 10                	mov    (%eax),%dl
  802050:	8b 45 0c             	mov    0xc(%ebp),%eax
  802053:	8a 00                	mov    (%eax),%al
  802055:	38 c2                	cmp    %al,%dl
  802057:	74 da                	je     802033 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  802059:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80205d:	75 07                	jne    802066 <strncmp+0x38>
		return 0;
  80205f:	b8 00 00 00 00       	mov    $0x0,%eax
  802064:	eb 14                	jmp    80207a <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  802066:	8b 45 08             	mov    0x8(%ebp),%eax
  802069:	8a 00                	mov    (%eax),%al
  80206b:	0f b6 d0             	movzbl %al,%edx
  80206e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802071:	8a 00                	mov    (%eax),%al
  802073:	0f b6 c0             	movzbl %al,%eax
  802076:	29 c2                	sub    %eax,%edx
  802078:	89 d0                	mov    %edx,%eax
}
  80207a:	5d                   	pop    %ebp
  80207b:	c3                   	ret    

0080207c <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80207c:	55                   	push   %ebp
  80207d:	89 e5                	mov    %esp,%ebp
  80207f:	83 ec 04             	sub    $0x4,%esp
  802082:	8b 45 0c             	mov    0xc(%ebp),%eax
  802085:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  802088:	eb 12                	jmp    80209c <strchr+0x20>
		if (*s == c)
  80208a:	8b 45 08             	mov    0x8(%ebp),%eax
  80208d:	8a 00                	mov    (%eax),%al
  80208f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  802092:	75 05                	jne    802099 <strchr+0x1d>
			return (char *) s;
  802094:	8b 45 08             	mov    0x8(%ebp),%eax
  802097:	eb 11                	jmp    8020aa <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  802099:	ff 45 08             	incl   0x8(%ebp)
  80209c:	8b 45 08             	mov    0x8(%ebp),%eax
  80209f:	8a 00                	mov    (%eax),%al
  8020a1:	84 c0                	test   %al,%al
  8020a3:	75 e5                	jne    80208a <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8020a5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020aa:	c9                   	leave  
  8020ab:	c3                   	ret    

008020ac <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8020ac:	55                   	push   %ebp
  8020ad:	89 e5                	mov    %esp,%ebp
  8020af:	83 ec 04             	sub    $0x4,%esp
  8020b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020b5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8020b8:	eb 0d                	jmp    8020c7 <strfind+0x1b>
		if (*s == c)
  8020ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8020bd:	8a 00                	mov    (%eax),%al
  8020bf:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8020c2:	74 0e                	je     8020d2 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8020c4:	ff 45 08             	incl   0x8(%ebp)
  8020c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ca:	8a 00                	mov    (%eax),%al
  8020cc:	84 c0                	test   %al,%al
  8020ce:	75 ea                	jne    8020ba <strfind+0xe>
  8020d0:	eb 01                	jmp    8020d3 <strfind+0x27>
		if (*s == c)
			break;
  8020d2:	90                   	nop
	return (char *) s;
  8020d3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8020d6:	c9                   	leave  
  8020d7:	c3                   	ret    

008020d8 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8020d8:	55                   	push   %ebp
  8020d9:	89 e5                	mov    %esp,%ebp
  8020db:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8020de:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8020e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8020e7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8020ea:	eb 0e                	jmp    8020fa <memset+0x22>
		*p++ = c;
  8020ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8020ef:	8d 50 01             	lea    0x1(%eax),%edx
  8020f2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8020f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020f8:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8020fa:	ff 4d f8             	decl   -0x8(%ebp)
  8020fd:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  802101:	79 e9                	jns    8020ec <memset+0x14>
		*p++ = c;

	return v;
  802103:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802106:	c9                   	leave  
  802107:	c3                   	ret    

00802108 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  802108:	55                   	push   %ebp
  802109:	89 e5                	mov    %esp,%ebp
  80210b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80210e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802111:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  802114:	8b 45 08             	mov    0x8(%ebp),%eax
  802117:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80211a:	eb 16                	jmp    802132 <memcpy+0x2a>
		*d++ = *s++;
  80211c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80211f:	8d 50 01             	lea    0x1(%eax),%edx
  802122:	89 55 f8             	mov    %edx,-0x8(%ebp)
  802125:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802128:	8d 4a 01             	lea    0x1(%edx),%ecx
  80212b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80212e:	8a 12                	mov    (%edx),%dl
  802130:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  802132:	8b 45 10             	mov    0x10(%ebp),%eax
  802135:	8d 50 ff             	lea    -0x1(%eax),%edx
  802138:	89 55 10             	mov    %edx,0x10(%ebp)
  80213b:	85 c0                	test   %eax,%eax
  80213d:	75 dd                	jne    80211c <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80213f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802142:	c9                   	leave  
  802143:	c3                   	ret    

00802144 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  802144:	55                   	push   %ebp
  802145:	89 e5                	mov    %esp,%ebp
  802147:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80214a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80214d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  802150:	8b 45 08             	mov    0x8(%ebp),%eax
  802153:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  802156:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802159:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80215c:	73 50                	jae    8021ae <memmove+0x6a>
  80215e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802161:	8b 45 10             	mov    0x10(%ebp),%eax
  802164:	01 d0                	add    %edx,%eax
  802166:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  802169:	76 43                	jbe    8021ae <memmove+0x6a>
		s += n;
  80216b:	8b 45 10             	mov    0x10(%ebp),%eax
  80216e:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  802171:	8b 45 10             	mov    0x10(%ebp),%eax
  802174:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  802177:	eb 10                	jmp    802189 <memmove+0x45>
			*--d = *--s;
  802179:	ff 4d f8             	decl   -0x8(%ebp)
  80217c:	ff 4d fc             	decl   -0x4(%ebp)
  80217f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802182:	8a 10                	mov    (%eax),%dl
  802184:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802187:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  802189:	8b 45 10             	mov    0x10(%ebp),%eax
  80218c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80218f:	89 55 10             	mov    %edx,0x10(%ebp)
  802192:	85 c0                	test   %eax,%eax
  802194:	75 e3                	jne    802179 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  802196:	eb 23                	jmp    8021bb <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  802198:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80219b:	8d 50 01             	lea    0x1(%eax),%edx
  80219e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8021a1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8021a4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8021a7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8021aa:	8a 12                	mov    (%edx),%dl
  8021ac:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8021ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8021b1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8021b4:	89 55 10             	mov    %edx,0x10(%ebp)
  8021b7:	85 c0                	test   %eax,%eax
  8021b9:	75 dd                	jne    802198 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8021bb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8021be:	c9                   	leave  
  8021bf:	c3                   	ret    

008021c0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8021c0:	55                   	push   %ebp
  8021c1:	89 e5                	mov    %esp,%ebp
  8021c3:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8021c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8021cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021cf:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8021d2:	eb 2a                	jmp    8021fe <memcmp+0x3e>
		if (*s1 != *s2)
  8021d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8021d7:	8a 10                	mov    (%eax),%dl
  8021d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021dc:	8a 00                	mov    (%eax),%al
  8021de:	38 c2                	cmp    %al,%dl
  8021e0:	74 16                	je     8021f8 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8021e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8021e5:	8a 00                	mov    (%eax),%al
  8021e7:	0f b6 d0             	movzbl %al,%edx
  8021ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021ed:	8a 00                	mov    (%eax),%al
  8021ef:	0f b6 c0             	movzbl %al,%eax
  8021f2:	29 c2                	sub    %eax,%edx
  8021f4:	89 d0                	mov    %edx,%eax
  8021f6:	eb 18                	jmp    802210 <memcmp+0x50>
		s1++, s2++;
  8021f8:	ff 45 fc             	incl   -0x4(%ebp)
  8021fb:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8021fe:	8b 45 10             	mov    0x10(%ebp),%eax
  802201:	8d 50 ff             	lea    -0x1(%eax),%edx
  802204:	89 55 10             	mov    %edx,0x10(%ebp)
  802207:	85 c0                	test   %eax,%eax
  802209:	75 c9                	jne    8021d4 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80220b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802210:	c9                   	leave  
  802211:	c3                   	ret    

00802212 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  802212:	55                   	push   %ebp
  802213:	89 e5                	mov    %esp,%ebp
  802215:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  802218:	8b 55 08             	mov    0x8(%ebp),%edx
  80221b:	8b 45 10             	mov    0x10(%ebp),%eax
  80221e:	01 d0                	add    %edx,%eax
  802220:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  802223:	eb 15                	jmp    80223a <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  802225:	8b 45 08             	mov    0x8(%ebp),%eax
  802228:	8a 00                	mov    (%eax),%al
  80222a:	0f b6 d0             	movzbl %al,%edx
  80222d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802230:	0f b6 c0             	movzbl %al,%eax
  802233:	39 c2                	cmp    %eax,%edx
  802235:	74 0d                	je     802244 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  802237:	ff 45 08             	incl   0x8(%ebp)
  80223a:	8b 45 08             	mov    0x8(%ebp),%eax
  80223d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  802240:	72 e3                	jb     802225 <memfind+0x13>
  802242:	eb 01                	jmp    802245 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  802244:	90                   	nop
	return (void *) s;
  802245:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802248:	c9                   	leave  
  802249:	c3                   	ret    

0080224a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80224a:	55                   	push   %ebp
  80224b:	89 e5                	mov    %esp,%ebp
  80224d:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  802250:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  802257:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80225e:	eb 03                	jmp    802263 <strtol+0x19>
		s++;
  802260:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  802263:	8b 45 08             	mov    0x8(%ebp),%eax
  802266:	8a 00                	mov    (%eax),%al
  802268:	3c 20                	cmp    $0x20,%al
  80226a:	74 f4                	je     802260 <strtol+0x16>
  80226c:	8b 45 08             	mov    0x8(%ebp),%eax
  80226f:	8a 00                	mov    (%eax),%al
  802271:	3c 09                	cmp    $0x9,%al
  802273:	74 eb                	je     802260 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  802275:	8b 45 08             	mov    0x8(%ebp),%eax
  802278:	8a 00                	mov    (%eax),%al
  80227a:	3c 2b                	cmp    $0x2b,%al
  80227c:	75 05                	jne    802283 <strtol+0x39>
		s++;
  80227e:	ff 45 08             	incl   0x8(%ebp)
  802281:	eb 13                	jmp    802296 <strtol+0x4c>
	else if (*s == '-')
  802283:	8b 45 08             	mov    0x8(%ebp),%eax
  802286:	8a 00                	mov    (%eax),%al
  802288:	3c 2d                	cmp    $0x2d,%al
  80228a:	75 0a                	jne    802296 <strtol+0x4c>
		s++, neg = 1;
  80228c:	ff 45 08             	incl   0x8(%ebp)
  80228f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  802296:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80229a:	74 06                	je     8022a2 <strtol+0x58>
  80229c:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8022a0:	75 20                	jne    8022c2 <strtol+0x78>
  8022a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8022a5:	8a 00                	mov    (%eax),%al
  8022a7:	3c 30                	cmp    $0x30,%al
  8022a9:	75 17                	jne    8022c2 <strtol+0x78>
  8022ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ae:	40                   	inc    %eax
  8022af:	8a 00                	mov    (%eax),%al
  8022b1:	3c 78                	cmp    $0x78,%al
  8022b3:	75 0d                	jne    8022c2 <strtol+0x78>
		s += 2, base = 16;
  8022b5:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8022b9:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8022c0:	eb 28                	jmp    8022ea <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8022c2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8022c6:	75 15                	jne    8022dd <strtol+0x93>
  8022c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8022cb:	8a 00                	mov    (%eax),%al
  8022cd:	3c 30                	cmp    $0x30,%al
  8022cf:	75 0c                	jne    8022dd <strtol+0x93>
		s++, base = 8;
  8022d1:	ff 45 08             	incl   0x8(%ebp)
  8022d4:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8022db:	eb 0d                	jmp    8022ea <strtol+0xa0>
	else if (base == 0)
  8022dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8022e1:	75 07                	jne    8022ea <strtol+0xa0>
		base = 10;
  8022e3:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8022ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ed:	8a 00                	mov    (%eax),%al
  8022ef:	3c 2f                	cmp    $0x2f,%al
  8022f1:	7e 19                	jle    80230c <strtol+0xc2>
  8022f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8022f6:	8a 00                	mov    (%eax),%al
  8022f8:	3c 39                	cmp    $0x39,%al
  8022fa:	7f 10                	jg     80230c <strtol+0xc2>
			dig = *s - '0';
  8022fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ff:	8a 00                	mov    (%eax),%al
  802301:	0f be c0             	movsbl %al,%eax
  802304:	83 e8 30             	sub    $0x30,%eax
  802307:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80230a:	eb 42                	jmp    80234e <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80230c:	8b 45 08             	mov    0x8(%ebp),%eax
  80230f:	8a 00                	mov    (%eax),%al
  802311:	3c 60                	cmp    $0x60,%al
  802313:	7e 19                	jle    80232e <strtol+0xe4>
  802315:	8b 45 08             	mov    0x8(%ebp),%eax
  802318:	8a 00                	mov    (%eax),%al
  80231a:	3c 7a                	cmp    $0x7a,%al
  80231c:	7f 10                	jg     80232e <strtol+0xe4>
			dig = *s - 'a' + 10;
  80231e:	8b 45 08             	mov    0x8(%ebp),%eax
  802321:	8a 00                	mov    (%eax),%al
  802323:	0f be c0             	movsbl %al,%eax
  802326:	83 e8 57             	sub    $0x57,%eax
  802329:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80232c:	eb 20                	jmp    80234e <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80232e:	8b 45 08             	mov    0x8(%ebp),%eax
  802331:	8a 00                	mov    (%eax),%al
  802333:	3c 40                	cmp    $0x40,%al
  802335:	7e 39                	jle    802370 <strtol+0x126>
  802337:	8b 45 08             	mov    0x8(%ebp),%eax
  80233a:	8a 00                	mov    (%eax),%al
  80233c:	3c 5a                	cmp    $0x5a,%al
  80233e:	7f 30                	jg     802370 <strtol+0x126>
			dig = *s - 'A' + 10;
  802340:	8b 45 08             	mov    0x8(%ebp),%eax
  802343:	8a 00                	mov    (%eax),%al
  802345:	0f be c0             	movsbl %al,%eax
  802348:	83 e8 37             	sub    $0x37,%eax
  80234b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80234e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802351:	3b 45 10             	cmp    0x10(%ebp),%eax
  802354:	7d 19                	jge    80236f <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  802356:	ff 45 08             	incl   0x8(%ebp)
  802359:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80235c:	0f af 45 10          	imul   0x10(%ebp),%eax
  802360:	89 c2                	mov    %eax,%edx
  802362:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802365:	01 d0                	add    %edx,%eax
  802367:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80236a:	e9 7b ff ff ff       	jmp    8022ea <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80236f:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  802370:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  802374:	74 08                	je     80237e <strtol+0x134>
		*endptr = (char *) s;
  802376:	8b 45 0c             	mov    0xc(%ebp),%eax
  802379:	8b 55 08             	mov    0x8(%ebp),%edx
  80237c:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80237e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  802382:	74 07                	je     80238b <strtol+0x141>
  802384:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802387:	f7 d8                	neg    %eax
  802389:	eb 03                	jmp    80238e <strtol+0x144>
  80238b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80238e:	c9                   	leave  
  80238f:	c3                   	ret    

00802390 <ltostr>:

void
ltostr(long value, char *str)
{
  802390:	55                   	push   %ebp
  802391:	89 e5                	mov    %esp,%ebp
  802393:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  802396:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80239d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8023a4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8023a8:	79 13                	jns    8023bd <ltostr+0x2d>
	{
		neg = 1;
  8023aa:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8023b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023b4:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8023b7:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8023ba:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8023bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8023c0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8023c5:	99                   	cltd   
  8023c6:	f7 f9                	idiv   %ecx
  8023c8:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8023cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8023ce:	8d 50 01             	lea    0x1(%eax),%edx
  8023d1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8023d4:	89 c2                	mov    %eax,%edx
  8023d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023d9:	01 d0                	add    %edx,%eax
  8023db:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8023de:	83 c2 30             	add    $0x30,%edx
  8023e1:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8023e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8023e6:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8023eb:	f7 e9                	imul   %ecx
  8023ed:	c1 fa 02             	sar    $0x2,%edx
  8023f0:	89 c8                	mov    %ecx,%eax
  8023f2:	c1 f8 1f             	sar    $0x1f,%eax
  8023f5:	29 c2                	sub    %eax,%edx
  8023f7:	89 d0                	mov    %edx,%eax
  8023f9:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8023fc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8023ff:	b8 67 66 66 66       	mov    $0x66666667,%eax
  802404:	f7 e9                	imul   %ecx
  802406:	c1 fa 02             	sar    $0x2,%edx
  802409:	89 c8                	mov    %ecx,%eax
  80240b:	c1 f8 1f             	sar    $0x1f,%eax
  80240e:	29 c2                	sub    %eax,%edx
  802410:	89 d0                	mov    %edx,%eax
  802412:	c1 e0 02             	shl    $0x2,%eax
  802415:	01 d0                	add    %edx,%eax
  802417:	01 c0                	add    %eax,%eax
  802419:	29 c1                	sub    %eax,%ecx
  80241b:	89 ca                	mov    %ecx,%edx
  80241d:	85 d2                	test   %edx,%edx
  80241f:	75 9c                	jne    8023bd <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  802421:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  802428:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80242b:	48                   	dec    %eax
  80242c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80242f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  802433:	74 3d                	je     802472 <ltostr+0xe2>
		start = 1 ;
  802435:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80243c:	eb 34                	jmp    802472 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80243e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  802441:	8b 45 0c             	mov    0xc(%ebp),%eax
  802444:	01 d0                	add    %edx,%eax
  802446:	8a 00                	mov    (%eax),%al
  802448:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80244b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80244e:	8b 45 0c             	mov    0xc(%ebp),%eax
  802451:	01 c2                	add    %eax,%edx
  802453:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  802456:	8b 45 0c             	mov    0xc(%ebp),%eax
  802459:	01 c8                	add    %ecx,%eax
  80245b:	8a 00                	mov    (%eax),%al
  80245d:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80245f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  802462:	8b 45 0c             	mov    0xc(%ebp),%eax
  802465:	01 c2                	add    %eax,%edx
  802467:	8a 45 eb             	mov    -0x15(%ebp),%al
  80246a:	88 02                	mov    %al,(%edx)
		start++ ;
  80246c:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80246f:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  802472:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802475:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802478:	7c c4                	jl     80243e <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80247a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80247d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802480:	01 d0                	add    %edx,%eax
  802482:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  802485:	90                   	nop
  802486:	c9                   	leave  
  802487:	c3                   	ret    

00802488 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  802488:	55                   	push   %ebp
  802489:	89 e5                	mov    %esp,%ebp
  80248b:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80248e:	ff 75 08             	pushl  0x8(%ebp)
  802491:	e8 54 fa ff ff       	call   801eea <strlen>
  802496:	83 c4 04             	add    $0x4,%esp
  802499:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80249c:	ff 75 0c             	pushl  0xc(%ebp)
  80249f:	e8 46 fa ff ff       	call   801eea <strlen>
  8024a4:	83 c4 04             	add    $0x4,%esp
  8024a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8024aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8024b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8024b8:	eb 17                	jmp    8024d1 <strcconcat+0x49>
		final[s] = str1[s] ;
  8024ba:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8024bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8024c0:	01 c2                	add    %eax,%edx
  8024c2:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8024c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8024c8:	01 c8                	add    %ecx,%eax
  8024ca:	8a 00                	mov    (%eax),%al
  8024cc:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8024ce:	ff 45 fc             	incl   -0x4(%ebp)
  8024d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8024d4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8024d7:	7c e1                	jl     8024ba <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8024d9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8024e0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8024e7:	eb 1f                	jmp    802508 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8024e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8024ec:	8d 50 01             	lea    0x1(%eax),%edx
  8024ef:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8024f2:	89 c2                	mov    %eax,%edx
  8024f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8024f7:	01 c2                	add    %eax,%edx
  8024f9:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8024fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8024ff:	01 c8                	add    %ecx,%eax
  802501:	8a 00                	mov    (%eax),%al
  802503:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  802505:	ff 45 f8             	incl   -0x8(%ebp)
  802508:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80250b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80250e:	7c d9                	jl     8024e9 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  802510:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802513:	8b 45 10             	mov    0x10(%ebp),%eax
  802516:	01 d0                	add    %edx,%eax
  802518:	c6 00 00             	movb   $0x0,(%eax)
}
  80251b:	90                   	nop
  80251c:	c9                   	leave  
  80251d:	c3                   	ret    

0080251e <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80251e:	55                   	push   %ebp
  80251f:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  802521:	8b 45 14             	mov    0x14(%ebp),%eax
  802524:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80252a:	8b 45 14             	mov    0x14(%ebp),%eax
  80252d:	8b 00                	mov    (%eax),%eax
  80252f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802536:	8b 45 10             	mov    0x10(%ebp),%eax
  802539:	01 d0                	add    %edx,%eax
  80253b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  802541:	eb 0c                	jmp    80254f <strsplit+0x31>
			*string++ = 0;
  802543:	8b 45 08             	mov    0x8(%ebp),%eax
  802546:	8d 50 01             	lea    0x1(%eax),%edx
  802549:	89 55 08             	mov    %edx,0x8(%ebp)
  80254c:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80254f:	8b 45 08             	mov    0x8(%ebp),%eax
  802552:	8a 00                	mov    (%eax),%al
  802554:	84 c0                	test   %al,%al
  802556:	74 18                	je     802570 <strsplit+0x52>
  802558:	8b 45 08             	mov    0x8(%ebp),%eax
  80255b:	8a 00                	mov    (%eax),%al
  80255d:	0f be c0             	movsbl %al,%eax
  802560:	50                   	push   %eax
  802561:	ff 75 0c             	pushl  0xc(%ebp)
  802564:	e8 13 fb ff ff       	call   80207c <strchr>
  802569:	83 c4 08             	add    $0x8,%esp
  80256c:	85 c0                	test   %eax,%eax
  80256e:	75 d3                	jne    802543 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  802570:	8b 45 08             	mov    0x8(%ebp),%eax
  802573:	8a 00                	mov    (%eax),%al
  802575:	84 c0                	test   %al,%al
  802577:	74 5a                	je     8025d3 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  802579:	8b 45 14             	mov    0x14(%ebp),%eax
  80257c:	8b 00                	mov    (%eax),%eax
  80257e:	83 f8 0f             	cmp    $0xf,%eax
  802581:	75 07                	jne    80258a <strsplit+0x6c>
		{
			return 0;
  802583:	b8 00 00 00 00       	mov    $0x0,%eax
  802588:	eb 66                	jmp    8025f0 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80258a:	8b 45 14             	mov    0x14(%ebp),%eax
  80258d:	8b 00                	mov    (%eax),%eax
  80258f:	8d 48 01             	lea    0x1(%eax),%ecx
  802592:	8b 55 14             	mov    0x14(%ebp),%edx
  802595:	89 0a                	mov    %ecx,(%edx)
  802597:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80259e:	8b 45 10             	mov    0x10(%ebp),%eax
  8025a1:	01 c2                	add    %eax,%edx
  8025a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8025a6:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8025a8:	eb 03                	jmp    8025ad <strsplit+0x8f>
			string++;
  8025aa:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8025ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8025b0:	8a 00                	mov    (%eax),%al
  8025b2:	84 c0                	test   %al,%al
  8025b4:	74 8b                	je     802541 <strsplit+0x23>
  8025b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8025b9:	8a 00                	mov    (%eax),%al
  8025bb:	0f be c0             	movsbl %al,%eax
  8025be:	50                   	push   %eax
  8025bf:	ff 75 0c             	pushl  0xc(%ebp)
  8025c2:	e8 b5 fa ff ff       	call   80207c <strchr>
  8025c7:	83 c4 08             	add    $0x8,%esp
  8025ca:	85 c0                	test   %eax,%eax
  8025cc:	74 dc                	je     8025aa <strsplit+0x8c>
			string++;
	}
  8025ce:	e9 6e ff ff ff       	jmp    802541 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8025d3:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8025d4:	8b 45 14             	mov    0x14(%ebp),%eax
  8025d7:	8b 00                	mov    (%eax),%eax
  8025d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8025e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8025e3:	01 d0                	add    %edx,%eax
  8025e5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8025eb:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8025f0:	c9                   	leave  
  8025f1:	c3                   	ret    

008025f2 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8025f2:	55                   	push   %ebp
  8025f3:	89 e5                	mov    %esp,%ebp
  8025f5:	57                   	push   %edi
  8025f6:	56                   	push   %esi
  8025f7:	53                   	push   %ebx
  8025f8:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8025fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8025fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  802601:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802604:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802607:	8b 7d 18             	mov    0x18(%ebp),%edi
  80260a:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80260d:	cd 30                	int    $0x30
  80260f:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802612:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802615:	83 c4 10             	add    $0x10,%esp
  802618:	5b                   	pop    %ebx
  802619:	5e                   	pop    %esi
  80261a:	5f                   	pop    %edi
  80261b:	5d                   	pop    %ebp
  80261c:	c3                   	ret    

0080261d <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80261d:	55                   	push   %ebp
  80261e:	89 e5                	mov    %esp,%ebp
  802620:	83 ec 04             	sub    $0x4,%esp
  802623:	8b 45 10             	mov    0x10(%ebp),%eax
  802626:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802629:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80262d:	8b 45 08             	mov    0x8(%ebp),%eax
  802630:	6a 00                	push   $0x0
  802632:	6a 00                	push   $0x0
  802634:	52                   	push   %edx
  802635:	ff 75 0c             	pushl  0xc(%ebp)
  802638:	50                   	push   %eax
  802639:	6a 00                	push   $0x0
  80263b:	e8 b2 ff ff ff       	call   8025f2 <syscall>
  802640:	83 c4 18             	add    $0x18,%esp
}
  802643:	90                   	nop
  802644:	c9                   	leave  
  802645:	c3                   	ret    

00802646 <sys_cgetc>:

int
sys_cgetc(void)
{
  802646:	55                   	push   %ebp
  802647:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802649:	6a 00                	push   $0x0
  80264b:	6a 00                	push   $0x0
  80264d:	6a 00                	push   $0x0
  80264f:	6a 00                	push   $0x0
  802651:	6a 00                	push   $0x0
  802653:	6a 01                	push   $0x1
  802655:	e8 98 ff ff ff       	call   8025f2 <syscall>
  80265a:	83 c4 18             	add    $0x18,%esp
}
  80265d:	c9                   	leave  
  80265e:	c3                   	ret    

0080265f <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80265f:	55                   	push   %ebp
  802660:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802662:	8b 45 08             	mov    0x8(%ebp),%eax
  802665:	6a 00                	push   $0x0
  802667:	6a 00                	push   $0x0
  802669:	6a 00                	push   $0x0
  80266b:	6a 00                	push   $0x0
  80266d:	50                   	push   %eax
  80266e:	6a 05                	push   $0x5
  802670:	e8 7d ff ff ff       	call   8025f2 <syscall>
  802675:	83 c4 18             	add    $0x18,%esp
}
  802678:	c9                   	leave  
  802679:	c3                   	ret    

0080267a <sys_getenvid>:

int32 sys_getenvid(void)
{
  80267a:	55                   	push   %ebp
  80267b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80267d:	6a 00                	push   $0x0
  80267f:	6a 00                	push   $0x0
  802681:	6a 00                	push   $0x0
  802683:	6a 00                	push   $0x0
  802685:	6a 00                	push   $0x0
  802687:	6a 02                	push   $0x2
  802689:	e8 64 ff ff ff       	call   8025f2 <syscall>
  80268e:	83 c4 18             	add    $0x18,%esp
}
  802691:	c9                   	leave  
  802692:	c3                   	ret    

00802693 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802693:	55                   	push   %ebp
  802694:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802696:	6a 00                	push   $0x0
  802698:	6a 00                	push   $0x0
  80269a:	6a 00                	push   $0x0
  80269c:	6a 00                	push   $0x0
  80269e:	6a 00                	push   $0x0
  8026a0:	6a 03                	push   $0x3
  8026a2:	e8 4b ff ff ff       	call   8025f2 <syscall>
  8026a7:	83 c4 18             	add    $0x18,%esp
}
  8026aa:	c9                   	leave  
  8026ab:	c3                   	ret    

008026ac <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8026ac:	55                   	push   %ebp
  8026ad:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8026af:	6a 00                	push   $0x0
  8026b1:	6a 00                	push   $0x0
  8026b3:	6a 00                	push   $0x0
  8026b5:	6a 00                	push   $0x0
  8026b7:	6a 00                	push   $0x0
  8026b9:	6a 04                	push   $0x4
  8026bb:	e8 32 ff ff ff       	call   8025f2 <syscall>
  8026c0:	83 c4 18             	add    $0x18,%esp
}
  8026c3:	c9                   	leave  
  8026c4:	c3                   	ret    

008026c5 <sys_env_exit>:


void sys_env_exit(void)
{
  8026c5:	55                   	push   %ebp
  8026c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8026c8:	6a 00                	push   $0x0
  8026ca:	6a 00                	push   $0x0
  8026cc:	6a 00                	push   $0x0
  8026ce:	6a 00                	push   $0x0
  8026d0:	6a 00                	push   $0x0
  8026d2:	6a 06                	push   $0x6
  8026d4:	e8 19 ff ff ff       	call   8025f2 <syscall>
  8026d9:	83 c4 18             	add    $0x18,%esp
}
  8026dc:	90                   	nop
  8026dd:	c9                   	leave  
  8026de:	c3                   	ret    

008026df <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8026df:	55                   	push   %ebp
  8026e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8026e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8026e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8026e8:	6a 00                	push   $0x0
  8026ea:	6a 00                	push   $0x0
  8026ec:	6a 00                	push   $0x0
  8026ee:	52                   	push   %edx
  8026ef:	50                   	push   %eax
  8026f0:	6a 07                	push   $0x7
  8026f2:	e8 fb fe ff ff       	call   8025f2 <syscall>
  8026f7:	83 c4 18             	add    $0x18,%esp
}
  8026fa:	c9                   	leave  
  8026fb:	c3                   	ret    

008026fc <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8026fc:	55                   	push   %ebp
  8026fd:	89 e5                	mov    %esp,%ebp
  8026ff:	56                   	push   %esi
  802700:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802701:	8b 75 18             	mov    0x18(%ebp),%esi
  802704:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802707:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80270a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80270d:	8b 45 08             	mov    0x8(%ebp),%eax
  802710:	56                   	push   %esi
  802711:	53                   	push   %ebx
  802712:	51                   	push   %ecx
  802713:	52                   	push   %edx
  802714:	50                   	push   %eax
  802715:	6a 08                	push   $0x8
  802717:	e8 d6 fe ff ff       	call   8025f2 <syscall>
  80271c:	83 c4 18             	add    $0x18,%esp
}
  80271f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802722:	5b                   	pop    %ebx
  802723:	5e                   	pop    %esi
  802724:	5d                   	pop    %ebp
  802725:	c3                   	ret    

00802726 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802726:	55                   	push   %ebp
  802727:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802729:	8b 55 0c             	mov    0xc(%ebp),%edx
  80272c:	8b 45 08             	mov    0x8(%ebp),%eax
  80272f:	6a 00                	push   $0x0
  802731:	6a 00                	push   $0x0
  802733:	6a 00                	push   $0x0
  802735:	52                   	push   %edx
  802736:	50                   	push   %eax
  802737:	6a 09                	push   $0x9
  802739:	e8 b4 fe ff ff       	call   8025f2 <syscall>
  80273e:	83 c4 18             	add    $0x18,%esp
}
  802741:	c9                   	leave  
  802742:	c3                   	ret    

00802743 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802743:	55                   	push   %ebp
  802744:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802746:	6a 00                	push   $0x0
  802748:	6a 00                	push   $0x0
  80274a:	6a 00                	push   $0x0
  80274c:	ff 75 0c             	pushl  0xc(%ebp)
  80274f:	ff 75 08             	pushl  0x8(%ebp)
  802752:	6a 0a                	push   $0xa
  802754:	e8 99 fe ff ff       	call   8025f2 <syscall>
  802759:	83 c4 18             	add    $0x18,%esp
}
  80275c:	c9                   	leave  
  80275d:	c3                   	ret    

0080275e <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80275e:	55                   	push   %ebp
  80275f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802761:	6a 00                	push   $0x0
  802763:	6a 00                	push   $0x0
  802765:	6a 00                	push   $0x0
  802767:	6a 00                	push   $0x0
  802769:	6a 00                	push   $0x0
  80276b:	6a 0b                	push   $0xb
  80276d:	e8 80 fe ff ff       	call   8025f2 <syscall>
  802772:	83 c4 18             	add    $0x18,%esp
}
  802775:	c9                   	leave  
  802776:	c3                   	ret    

00802777 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802777:	55                   	push   %ebp
  802778:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80277a:	6a 00                	push   $0x0
  80277c:	6a 00                	push   $0x0
  80277e:	6a 00                	push   $0x0
  802780:	6a 00                	push   $0x0
  802782:	6a 00                	push   $0x0
  802784:	6a 0c                	push   $0xc
  802786:	e8 67 fe ff ff       	call   8025f2 <syscall>
  80278b:	83 c4 18             	add    $0x18,%esp
}
  80278e:	c9                   	leave  
  80278f:	c3                   	ret    

00802790 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802790:	55                   	push   %ebp
  802791:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802793:	6a 00                	push   $0x0
  802795:	6a 00                	push   $0x0
  802797:	6a 00                	push   $0x0
  802799:	6a 00                	push   $0x0
  80279b:	6a 00                	push   $0x0
  80279d:	6a 0d                	push   $0xd
  80279f:	e8 4e fe ff ff       	call   8025f2 <syscall>
  8027a4:	83 c4 18             	add    $0x18,%esp
}
  8027a7:	c9                   	leave  
  8027a8:	c3                   	ret    

008027a9 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8027a9:	55                   	push   %ebp
  8027aa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8027ac:	6a 00                	push   $0x0
  8027ae:	6a 00                	push   $0x0
  8027b0:	6a 00                	push   $0x0
  8027b2:	ff 75 0c             	pushl  0xc(%ebp)
  8027b5:	ff 75 08             	pushl  0x8(%ebp)
  8027b8:	6a 11                	push   $0x11
  8027ba:	e8 33 fe ff ff       	call   8025f2 <syscall>
  8027bf:	83 c4 18             	add    $0x18,%esp
	return;
  8027c2:	90                   	nop
}
  8027c3:	c9                   	leave  
  8027c4:	c3                   	ret    

008027c5 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8027c5:	55                   	push   %ebp
  8027c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8027c8:	6a 00                	push   $0x0
  8027ca:	6a 00                	push   $0x0
  8027cc:	6a 00                	push   $0x0
  8027ce:	ff 75 0c             	pushl  0xc(%ebp)
  8027d1:	ff 75 08             	pushl  0x8(%ebp)
  8027d4:	6a 12                	push   $0x12
  8027d6:	e8 17 fe ff ff       	call   8025f2 <syscall>
  8027db:	83 c4 18             	add    $0x18,%esp
	return ;
  8027de:	90                   	nop
}
  8027df:	c9                   	leave  
  8027e0:	c3                   	ret    

008027e1 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8027e1:	55                   	push   %ebp
  8027e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8027e4:	6a 00                	push   $0x0
  8027e6:	6a 00                	push   $0x0
  8027e8:	6a 00                	push   $0x0
  8027ea:	6a 00                	push   $0x0
  8027ec:	6a 00                	push   $0x0
  8027ee:	6a 0e                	push   $0xe
  8027f0:	e8 fd fd ff ff       	call   8025f2 <syscall>
  8027f5:	83 c4 18             	add    $0x18,%esp
}
  8027f8:	c9                   	leave  
  8027f9:	c3                   	ret    

008027fa <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8027fa:	55                   	push   %ebp
  8027fb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8027fd:	6a 00                	push   $0x0
  8027ff:	6a 00                	push   $0x0
  802801:	6a 00                	push   $0x0
  802803:	6a 00                	push   $0x0
  802805:	ff 75 08             	pushl  0x8(%ebp)
  802808:	6a 0f                	push   $0xf
  80280a:	e8 e3 fd ff ff       	call   8025f2 <syscall>
  80280f:	83 c4 18             	add    $0x18,%esp
}
  802812:	c9                   	leave  
  802813:	c3                   	ret    

00802814 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802814:	55                   	push   %ebp
  802815:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802817:	6a 00                	push   $0x0
  802819:	6a 00                	push   $0x0
  80281b:	6a 00                	push   $0x0
  80281d:	6a 00                	push   $0x0
  80281f:	6a 00                	push   $0x0
  802821:	6a 10                	push   $0x10
  802823:	e8 ca fd ff ff       	call   8025f2 <syscall>
  802828:	83 c4 18             	add    $0x18,%esp
}
  80282b:	90                   	nop
  80282c:	c9                   	leave  
  80282d:	c3                   	ret    

0080282e <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80282e:	55                   	push   %ebp
  80282f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802831:	6a 00                	push   $0x0
  802833:	6a 00                	push   $0x0
  802835:	6a 00                	push   $0x0
  802837:	6a 00                	push   $0x0
  802839:	6a 00                	push   $0x0
  80283b:	6a 14                	push   $0x14
  80283d:	e8 b0 fd ff ff       	call   8025f2 <syscall>
  802842:	83 c4 18             	add    $0x18,%esp
}
  802845:	90                   	nop
  802846:	c9                   	leave  
  802847:	c3                   	ret    

00802848 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802848:	55                   	push   %ebp
  802849:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80284b:	6a 00                	push   $0x0
  80284d:	6a 00                	push   $0x0
  80284f:	6a 00                	push   $0x0
  802851:	6a 00                	push   $0x0
  802853:	6a 00                	push   $0x0
  802855:	6a 15                	push   $0x15
  802857:	e8 96 fd ff ff       	call   8025f2 <syscall>
  80285c:	83 c4 18             	add    $0x18,%esp
}
  80285f:	90                   	nop
  802860:	c9                   	leave  
  802861:	c3                   	ret    

00802862 <sys_cputc>:


void
sys_cputc(const char c)
{
  802862:	55                   	push   %ebp
  802863:	89 e5                	mov    %esp,%ebp
  802865:	83 ec 04             	sub    $0x4,%esp
  802868:	8b 45 08             	mov    0x8(%ebp),%eax
  80286b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80286e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802872:	6a 00                	push   $0x0
  802874:	6a 00                	push   $0x0
  802876:	6a 00                	push   $0x0
  802878:	6a 00                	push   $0x0
  80287a:	50                   	push   %eax
  80287b:	6a 16                	push   $0x16
  80287d:	e8 70 fd ff ff       	call   8025f2 <syscall>
  802882:	83 c4 18             	add    $0x18,%esp
}
  802885:	90                   	nop
  802886:	c9                   	leave  
  802887:	c3                   	ret    

00802888 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802888:	55                   	push   %ebp
  802889:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80288b:	6a 00                	push   $0x0
  80288d:	6a 00                	push   $0x0
  80288f:	6a 00                	push   $0x0
  802891:	6a 00                	push   $0x0
  802893:	6a 00                	push   $0x0
  802895:	6a 17                	push   $0x17
  802897:	e8 56 fd ff ff       	call   8025f2 <syscall>
  80289c:	83 c4 18             	add    $0x18,%esp
}
  80289f:	90                   	nop
  8028a0:	c9                   	leave  
  8028a1:	c3                   	ret    

008028a2 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8028a2:	55                   	push   %ebp
  8028a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8028a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8028a8:	6a 00                	push   $0x0
  8028aa:	6a 00                	push   $0x0
  8028ac:	6a 00                	push   $0x0
  8028ae:	ff 75 0c             	pushl  0xc(%ebp)
  8028b1:	50                   	push   %eax
  8028b2:	6a 18                	push   $0x18
  8028b4:	e8 39 fd ff ff       	call   8025f2 <syscall>
  8028b9:	83 c4 18             	add    $0x18,%esp
}
  8028bc:	c9                   	leave  
  8028bd:	c3                   	ret    

008028be <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8028be:	55                   	push   %ebp
  8028bf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8028c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8028c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8028c7:	6a 00                	push   $0x0
  8028c9:	6a 00                	push   $0x0
  8028cb:	6a 00                	push   $0x0
  8028cd:	52                   	push   %edx
  8028ce:	50                   	push   %eax
  8028cf:	6a 1b                	push   $0x1b
  8028d1:	e8 1c fd ff ff       	call   8025f2 <syscall>
  8028d6:	83 c4 18             	add    $0x18,%esp
}
  8028d9:	c9                   	leave  
  8028da:	c3                   	ret    

008028db <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8028db:	55                   	push   %ebp
  8028dc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8028de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8028e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8028e4:	6a 00                	push   $0x0
  8028e6:	6a 00                	push   $0x0
  8028e8:	6a 00                	push   $0x0
  8028ea:	52                   	push   %edx
  8028eb:	50                   	push   %eax
  8028ec:	6a 19                	push   $0x19
  8028ee:	e8 ff fc ff ff       	call   8025f2 <syscall>
  8028f3:	83 c4 18             	add    $0x18,%esp
}
  8028f6:	90                   	nop
  8028f7:	c9                   	leave  
  8028f8:	c3                   	ret    

008028f9 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8028f9:	55                   	push   %ebp
  8028fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8028fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8028ff:	8b 45 08             	mov    0x8(%ebp),%eax
  802902:	6a 00                	push   $0x0
  802904:	6a 00                	push   $0x0
  802906:	6a 00                	push   $0x0
  802908:	52                   	push   %edx
  802909:	50                   	push   %eax
  80290a:	6a 1a                	push   $0x1a
  80290c:	e8 e1 fc ff ff       	call   8025f2 <syscall>
  802911:	83 c4 18             	add    $0x18,%esp
}
  802914:	90                   	nop
  802915:	c9                   	leave  
  802916:	c3                   	ret    

00802917 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802917:	55                   	push   %ebp
  802918:	89 e5                	mov    %esp,%ebp
  80291a:	83 ec 04             	sub    $0x4,%esp
  80291d:	8b 45 10             	mov    0x10(%ebp),%eax
  802920:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802923:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802926:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80292a:	8b 45 08             	mov    0x8(%ebp),%eax
  80292d:	6a 00                	push   $0x0
  80292f:	51                   	push   %ecx
  802930:	52                   	push   %edx
  802931:	ff 75 0c             	pushl  0xc(%ebp)
  802934:	50                   	push   %eax
  802935:	6a 1c                	push   $0x1c
  802937:	e8 b6 fc ff ff       	call   8025f2 <syscall>
  80293c:	83 c4 18             	add    $0x18,%esp
}
  80293f:	c9                   	leave  
  802940:	c3                   	ret    

00802941 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802941:	55                   	push   %ebp
  802942:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802944:	8b 55 0c             	mov    0xc(%ebp),%edx
  802947:	8b 45 08             	mov    0x8(%ebp),%eax
  80294a:	6a 00                	push   $0x0
  80294c:	6a 00                	push   $0x0
  80294e:	6a 00                	push   $0x0
  802950:	52                   	push   %edx
  802951:	50                   	push   %eax
  802952:	6a 1d                	push   $0x1d
  802954:	e8 99 fc ff ff       	call   8025f2 <syscall>
  802959:	83 c4 18             	add    $0x18,%esp
}
  80295c:	c9                   	leave  
  80295d:	c3                   	ret    

0080295e <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80295e:	55                   	push   %ebp
  80295f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802961:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802964:	8b 55 0c             	mov    0xc(%ebp),%edx
  802967:	8b 45 08             	mov    0x8(%ebp),%eax
  80296a:	6a 00                	push   $0x0
  80296c:	6a 00                	push   $0x0
  80296e:	51                   	push   %ecx
  80296f:	52                   	push   %edx
  802970:	50                   	push   %eax
  802971:	6a 1e                	push   $0x1e
  802973:	e8 7a fc ff ff       	call   8025f2 <syscall>
  802978:	83 c4 18             	add    $0x18,%esp
}
  80297b:	c9                   	leave  
  80297c:	c3                   	ret    

0080297d <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80297d:	55                   	push   %ebp
  80297e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802980:	8b 55 0c             	mov    0xc(%ebp),%edx
  802983:	8b 45 08             	mov    0x8(%ebp),%eax
  802986:	6a 00                	push   $0x0
  802988:	6a 00                	push   $0x0
  80298a:	6a 00                	push   $0x0
  80298c:	52                   	push   %edx
  80298d:	50                   	push   %eax
  80298e:	6a 1f                	push   $0x1f
  802990:	e8 5d fc ff ff       	call   8025f2 <syscall>
  802995:	83 c4 18             	add    $0x18,%esp
}
  802998:	c9                   	leave  
  802999:	c3                   	ret    

0080299a <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80299a:	55                   	push   %ebp
  80299b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80299d:	6a 00                	push   $0x0
  80299f:	6a 00                	push   $0x0
  8029a1:	6a 00                	push   $0x0
  8029a3:	6a 00                	push   $0x0
  8029a5:	6a 00                	push   $0x0
  8029a7:	6a 20                	push   $0x20
  8029a9:	e8 44 fc ff ff       	call   8025f2 <syscall>
  8029ae:	83 c4 18             	add    $0x18,%esp
}
  8029b1:	c9                   	leave  
  8029b2:	c3                   	ret    

008029b3 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8029b3:	55                   	push   %ebp
  8029b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8029b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8029b9:	6a 00                	push   $0x0
  8029bb:	ff 75 14             	pushl  0x14(%ebp)
  8029be:	ff 75 10             	pushl  0x10(%ebp)
  8029c1:	ff 75 0c             	pushl  0xc(%ebp)
  8029c4:	50                   	push   %eax
  8029c5:	6a 21                	push   $0x21
  8029c7:	e8 26 fc ff ff       	call   8025f2 <syscall>
  8029cc:	83 c4 18             	add    $0x18,%esp
}
  8029cf:	c9                   	leave  
  8029d0:	c3                   	ret    

008029d1 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8029d1:	55                   	push   %ebp
  8029d2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8029d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8029d7:	6a 00                	push   $0x0
  8029d9:	6a 00                	push   $0x0
  8029db:	6a 00                	push   $0x0
  8029dd:	6a 00                	push   $0x0
  8029df:	50                   	push   %eax
  8029e0:	6a 22                	push   $0x22
  8029e2:	e8 0b fc ff ff       	call   8025f2 <syscall>
  8029e7:	83 c4 18             	add    $0x18,%esp
}
  8029ea:	90                   	nop
  8029eb:	c9                   	leave  
  8029ec:	c3                   	ret    

008029ed <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8029ed:	55                   	push   %ebp
  8029ee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8029f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8029f3:	6a 00                	push   $0x0
  8029f5:	6a 00                	push   $0x0
  8029f7:	6a 00                	push   $0x0
  8029f9:	6a 00                	push   $0x0
  8029fb:	50                   	push   %eax
  8029fc:	6a 23                	push   $0x23
  8029fe:	e8 ef fb ff ff       	call   8025f2 <syscall>
  802a03:	83 c4 18             	add    $0x18,%esp
}
  802a06:	90                   	nop
  802a07:	c9                   	leave  
  802a08:	c3                   	ret    

00802a09 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802a09:	55                   	push   %ebp
  802a0a:	89 e5                	mov    %esp,%ebp
  802a0c:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802a0f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802a12:	8d 50 04             	lea    0x4(%eax),%edx
  802a15:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802a18:	6a 00                	push   $0x0
  802a1a:	6a 00                	push   $0x0
  802a1c:	6a 00                	push   $0x0
  802a1e:	52                   	push   %edx
  802a1f:	50                   	push   %eax
  802a20:	6a 24                	push   $0x24
  802a22:	e8 cb fb ff ff       	call   8025f2 <syscall>
  802a27:	83 c4 18             	add    $0x18,%esp
	return result;
  802a2a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802a2d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802a30:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802a33:	89 01                	mov    %eax,(%ecx)
  802a35:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802a38:	8b 45 08             	mov    0x8(%ebp),%eax
  802a3b:	c9                   	leave  
  802a3c:	c2 04 00             	ret    $0x4

00802a3f <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802a3f:	55                   	push   %ebp
  802a40:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802a42:	6a 00                	push   $0x0
  802a44:	6a 00                	push   $0x0
  802a46:	ff 75 10             	pushl  0x10(%ebp)
  802a49:	ff 75 0c             	pushl  0xc(%ebp)
  802a4c:	ff 75 08             	pushl  0x8(%ebp)
  802a4f:	6a 13                	push   $0x13
  802a51:	e8 9c fb ff ff       	call   8025f2 <syscall>
  802a56:	83 c4 18             	add    $0x18,%esp
	return ;
  802a59:	90                   	nop
}
  802a5a:	c9                   	leave  
  802a5b:	c3                   	ret    

00802a5c <sys_rcr2>:
uint32 sys_rcr2()
{
  802a5c:	55                   	push   %ebp
  802a5d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802a5f:	6a 00                	push   $0x0
  802a61:	6a 00                	push   $0x0
  802a63:	6a 00                	push   $0x0
  802a65:	6a 00                	push   $0x0
  802a67:	6a 00                	push   $0x0
  802a69:	6a 25                	push   $0x25
  802a6b:	e8 82 fb ff ff       	call   8025f2 <syscall>
  802a70:	83 c4 18             	add    $0x18,%esp
}
  802a73:	c9                   	leave  
  802a74:	c3                   	ret    

00802a75 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802a75:	55                   	push   %ebp
  802a76:	89 e5                	mov    %esp,%ebp
  802a78:	83 ec 04             	sub    $0x4,%esp
  802a7b:	8b 45 08             	mov    0x8(%ebp),%eax
  802a7e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802a81:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802a85:	6a 00                	push   $0x0
  802a87:	6a 00                	push   $0x0
  802a89:	6a 00                	push   $0x0
  802a8b:	6a 00                	push   $0x0
  802a8d:	50                   	push   %eax
  802a8e:	6a 26                	push   $0x26
  802a90:	e8 5d fb ff ff       	call   8025f2 <syscall>
  802a95:	83 c4 18             	add    $0x18,%esp
	return ;
  802a98:	90                   	nop
}
  802a99:	c9                   	leave  
  802a9a:	c3                   	ret    

00802a9b <rsttst>:
void rsttst()
{
  802a9b:	55                   	push   %ebp
  802a9c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802a9e:	6a 00                	push   $0x0
  802aa0:	6a 00                	push   $0x0
  802aa2:	6a 00                	push   $0x0
  802aa4:	6a 00                	push   $0x0
  802aa6:	6a 00                	push   $0x0
  802aa8:	6a 28                	push   $0x28
  802aaa:	e8 43 fb ff ff       	call   8025f2 <syscall>
  802aaf:	83 c4 18             	add    $0x18,%esp
	return ;
  802ab2:	90                   	nop
}
  802ab3:	c9                   	leave  
  802ab4:	c3                   	ret    

00802ab5 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802ab5:	55                   	push   %ebp
  802ab6:	89 e5                	mov    %esp,%ebp
  802ab8:	83 ec 04             	sub    $0x4,%esp
  802abb:	8b 45 14             	mov    0x14(%ebp),%eax
  802abe:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802ac1:	8b 55 18             	mov    0x18(%ebp),%edx
  802ac4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802ac8:	52                   	push   %edx
  802ac9:	50                   	push   %eax
  802aca:	ff 75 10             	pushl  0x10(%ebp)
  802acd:	ff 75 0c             	pushl  0xc(%ebp)
  802ad0:	ff 75 08             	pushl  0x8(%ebp)
  802ad3:	6a 27                	push   $0x27
  802ad5:	e8 18 fb ff ff       	call   8025f2 <syscall>
  802ada:	83 c4 18             	add    $0x18,%esp
	return ;
  802add:	90                   	nop
}
  802ade:	c9                   	leave  
  802adf:	c3                   	ret    

00802ae0 <chktst>:
void chktst(uint32 n)
{
  802ae0:	55                   	push   %ebp
  802ae1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802ae3:	6a 00                	push   $0x0
  802ae5:	6a 00                	push   $0x0
  802ae7:	6a 00                	push   $0x0
  802ae9:	6a 00                	push   $0x0
  802aeb:	ff 75 08             	pushl  0x8(%ebp)
  802aee:	6a 29                	push   $0x29
  802af0:	e8 fd fa ff ff       	call   8025f2 <syscall>
  802af5:	83 c4 18             	add    $0x18,%esp
	return ;
  802af8:	90                   	nop
}
  802af9:	c9                   	leave  
  802afa:	c3                   	ret    

00802afb <inctst>:

void inctst()
{
  802afb:	55                   	push   %ebp
  802afc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802afe:	6a 00                	push   $0x0
  802b00:	6a 00                	push   $0x0
  802b02:	6a 00                	push   $0x0
  802b04:	6a 00                	push   $0x0
  802b06:	6a 00                	push   $0x0
  802b08:	6a 2a                	push   $0x2a
  802b0a:	e8 e3 fa ff ff       	call   8025f2 <syscall>
  802b0f:	83 c4 18             	add    $0x18,%esp
	return ;
  802b12:	90                   	nop
}
  802b13:	c9                   	leave  
  802b14:	c3                   	ret    

00802b15 <gettst>:
uint32 gettst()
{
  802b15:	55                   	push   %ebp
  802b16:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802b18:	6a 00                	push   $0x0
  802b1a:	6a 00                	push   $0x0
  802b1c:	6a 00                	push   $0x0
  802b1e:	6a 00                	push   $0x0
  802b20:	6a 00                	push   $0x0
  802b22:	6a 2b                	push   $0x2b
  802b24:	e8 c9 fa ff ff       	call   8025f2 <syscall>
  802b29:	83 c4 18             	add    $0x18,%esp
}
  802b2c:	c9                   	leave  
  802b2d:	c3                   	ret    

00802b2e <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802b2e:	55                   	push   %ebp
  802b2f:	89 e5                	mov    %esp,%ebp
  802b31:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802b34:	6a 00                	push   $0x0
  802b36:	6a 00                	push   $0x0
  802b38:	6a 00                	push   $0x0
  802b3a:	6a 00                	push   $0x0
  802b3c:	6a 00                	push   $0x0
  802b3e:	6a 2c                	push   $0x2c
  802b40:	e8 ad fa ff ff       	call   8025f2 <syscall>
  802b45:	83 c4 18             	add    $0x18,%esp
  802b48:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802b4b:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802b4f:	75 07                	jne    802b58 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802b51:	b8 01 00 00 00       	mov    $0x1,%eax
  802b56:	eb 05                	jmp    802b5d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802b58:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802b5d:	c9                   	leave  
  802b5e:	c3                   	ret    

00802b5f <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802b5f:	55                   	push   %ebp
  802b60:	89 e5                	mov    %esp,%ebp
  802b62:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802b65:	6a 00                	push   $0x0
  802b67:	6a 00                	push   $0x0
  802b69:	6a 00                	push   $0x0
  802b6b:	6a 00                	push   $0x0
  802b6d:	6a 00                	push   $0x0
  802b6f:	6a 2c                	push   $0x2c
  802b71:	e8 7c fa ff ff       	call   8025f2 <syscall>
  802b76:	83 c4 18             	add    $0x18,%esp
  802b79:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802b7c:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802b80:	75 07                	jne    802b89 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802b82:	b8 01 00 00 00       	mov    $0x1,%eax
  802b87:	eb 05                	jmp    802b8e <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802b89:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802b8e:	c9                   	leave  
  802b8f:	c3                   	ret    

00802b90 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802b90:	55                   	push   %ebp
  802b91:	89 e5                	mov    %esp,%ebp
  802b93:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802b96:	6a 00                	push   $0x0
  802b98:	6a 00                	push   $0x0
  802b9a:	6a 00                	push   $0x0
  802b9c:	6a 00                	push   $0x0
  802b9e:	6a 00                	push   $0x0
  802ba0:	6a 2c                	push   $0x2c
  802ba2:	e8 4b fa ff ff       	call   8025f2 <syscall>
  802ba7:	83 c4 18             	add    $0x18,%esp
  802baa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802bad:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802bb1:	75 07                	jne    802bba <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802bb3:	b8 01 00 00 00       	mov    $0x1,%eax
  802bb8:	eb 05                	jmp    802bbf <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802bba:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802bbf:	c9                   	leave  
  802bc0:	c3                   	ret    

00802bc1 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802bc1:	55                   	push   %ebp
  802bc2:	89 e5                	mov    %esp,%ebp
  802bc4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802bc7:	6a 00                	push   $0x0
  802bc9:	6a 00                	push   $0x0
  802bcb:	6a 00                	push   $0x0
  802bcd:	6a 00                	push   $0x0
  802bcf:	6a 00                	push   $0x0
  802bd1:	6a 2c                	push   $0x2c
  802bd3:	e8 1a fa ff ff       	call   8025f2 <syscall>
  802bd8:	83 c4 18             	add    $0x18,%esp
  802bdb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802bde:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802be2:	75 07                	jne    802beb <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802be4:	b8 01 00 00 00       	mov    $0x1,%eax
  802be9:	eb 05                	jmp    802bf0 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802beb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802bf0:	c9                   	leave  
  802bf1:	c3                   	ret    

00802bf2 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802bf2:	55                   	push   %ebp
  802bf3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802bf5:	6a 00                	push   $0x0
  802bf7:	6a 00                	push   $0x0
  802bf9:	6a 00                	push   $0x0
  802bfb:	6a 00                	push   $0x0
  802bfd:	ff 75 08             	pushl  0x8(%ebp)
  802c00:	6a 2d                	push   $0x2d
  802c02:	e8 eb f9 ff ff       	call   8025f2 <syscall>
  802c07:	83 c4 18             	add    $0x18,%esp
	return ;
  802c0a:	90                   	nop
}
  802c0b:	c9                   	leave  
  802c0c:	c3                   	ret    

00802c0d <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802c0d:	55                   	push   %ebp
  802c0e:	89 e5                	mov    %esp,%ebp
  802c10:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802c11:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802c14:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802c17:	8b 55 0c             	mov    0xc(%ebp),%edx
  802c1a:	8b 45 08             	mov    0x8(%ebp),%eax
  802c1d:	6a 00                	push   $0x0
  802c1f:	53                   	push   %ebx
  802c20:	51                   	push   %ecx
  802c21:	52                   	push   %edx
  802c22:	50                   	push   %eax
  802c23:	6a 2e                	push   $0x2e
  802c25:	e8 c8 f9 ff ff       	call   8025f2 <syscall>
  802c2a:	83 c4 18             	add    $0x18,%esp
}
  802c2d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802c30:	c9                   	leave  
  802c31:	c3                   	ret    

00802c32 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802c32:	55                   	push   %ebp
  802c33:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802c35:	8b 55 0c             	mov    0xc(%ebp),%edx
  802c38:	8b 45 08             	mov    0x8(%ebp),%eax
  802c3b:	6a 00                	push   $0x0
  802c3d:	6a 00                	push   $0x0
  802c3f:	6a 00                	push   $0x0
  802c41:	52                   	push   %edx
  802c42:	50                   	push   %eax
  802c43:	6a 2f                	push   $0x2f
  802c45:	e8 a8 f9 ff ff       	call   8025f2 <syscall>
  802c4a:	83 c4 18             	add    $0x18,%esp
}
  802c4d:	c9                   	leave  
  802c4e:	c3                   	ret    

00802c4f <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  802c4f:	55                   	push   %ebp
  802c50:	89 e5                	mov    %esp,%ebp
  802c52:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  802c55:	8b 55 08             	mov    0x8(%ebp),%edx
  802c58:	89 d0                	mov    %edx,%eax
  802c5a:	c1 e0 02             	shl    $0x2,%eax
  802c5d:	01 d0                	add    %edx,%eax
  802c5f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802c66:	01 d0                	add    %edx,%eax
  802c68:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802c6f:	01 d0                	add    %edx,%eax
  802c71:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802c78:	01 d0                	add    %edx,%eax
  802c7a:	c1 e0 04             	shl    $0x4,%eax
  802c7d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  802c80:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  802c87:	8d 45 e8             	lea    -0x18(%ebp),%eax
  802c8a:	83 ec 0c             	sub    $0xc,%esp
  802c8d:	50                   	push   %eax
  802c8e:	e8 76 fd ff ff       	call   802a09 <sys_get_virtual_time>
  802c93:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  802c96:	eb 41                	jmp    802cd9 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  802c98:	8d 45 e0             	lea    -0x20(%ebp),%eax
  802c9b:	83 ec 0c             	sub    $0xc,%esp
  802c9e:	50                   	push   %eax
  802c9f:	e8 65 fd ff ff       	call   802a09 <sys_get_virtual_time>
  802ca4:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  802ca7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  802caa:	8b 45 e8             	mov    -0x18(%ebp),%eax
  802cad:	29 c2                	sub    %eax,%edx
  802caf:	89 d0                	mov    %edx,%eax
  802cb1:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  802cb4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  802cb7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  802cba:	89 d1                	mov    %edx,%ecx
  802cbc:	29 c1                	sub    %eax,%ecx
  802cbe:	8b 55 d8             	mov    -0x28(%ebp),%edx
  802cc1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  802cc4:	39 c2                	cmp    %eax,%edx
  802cc6:	0f 97 c0             	seta   %al
  802cc9:	0f b6 c0             	movzbl %al,%eax
  802ccc:	29 c1                	sub    %eax,%ecx
  802cce:	89 c8                	mov    %ecx,%eax
  802cd0:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  802cd3:	8b 45 d8             	mov    -0x28(%ebp),%eax
  802cd6:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  802cd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  802cdc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802cdf:	72 b7                	jb     802c98 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  802ce1:	90                   	nop
  802ce2:	c9                   	leave  
  802ce3:	c3                   	ret    

00802ce4 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  802ce4:	55                   	push   %ebp
  802ce5:	89 e5                	mov    %esp,%ebp
  802ce7:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  802cea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  802cf1:	eb 03                	jmp    802cf6 <busy_wait+0x12>
  802cf3:	ff 45 fc             	incl   -0x4(%ebp)
  802cf6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802cf9:	3b 45 08             	cmp    0x8(%ebp),%eax
  802cfc:	72 f5                	jb     802cf3 <busy_wait+0xf>
	return i;
  802cfe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802d01:	c9                   	leave  
  802d02:	c3                   	ret    
  802d03:	90                   	nop

00802d04 <__udivdi3>:
  802d04:	55                   	push   %ebp
  802d05:	57                   	push   %edi
  802d06:	56                   	push   %esi
  802d07:	53                   	push   %ebx
  802d08:	83 ec 1c             	sub    $0x1c,%esp
  802d0b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802d0f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802d13:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802d17:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802d1b:	89 ca                	mov    %ecx,%edx
  802d1d:	89 f8                	mov    %edi,%eax
  802d1f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802d23:	85 f6                	test   %esi,%esi
  802d25:	75 2d                	jne    802d54 <__udivdi3+0x50>
  802d27:	39 cf                	cmp    %ecx,%edi
  802d29:	77 65                	ja     802d90 <__udivdi3+0x8c>
  802d2b:	89 fd                	mov    %edi,%ebp
  802d2d:	85 ff                	test   %edi,%edi
  802d2f:	75 0b                	jne    802d3c <__udivdi3+0x38>
  802d31:	b8 01 00 00 00       	mov    $0x1,%eax
  802d36:	31 d2                	xor    %edx,%edx
  802d38:	f7 f7                	div    %edi
  802d3a:	89 c5                	mov    %eax,%ebp
  802d3c:	31 d2                	xor    %edx,%edx
  802d3e:	89 c8                	mov    %ecx,%eax
  802d40:	f7 f5                	div    %ebp
  802d42:	89 c1                	mov    %eax,%ecx
  802d44:	89 d8                	mov    %ebx,%eax
  802d46:	f7 f5                	div    %ebp
  802d48:	89 cf                	mov    %ecx,%edi
  802d4a:	89 fa                	mov    %edi,%edx
  802d4c:	83 c4 1c             	add    $0x1c,%esp
  802d4f:	5b                   	pop    %ebx
  802d50:	5e                   	pop    %esi
  802d51:	5f                   	pop    %edi
  802d52:	5d                   	pop    %ebp
  802d53:	c3                   	ret    
  802d54:	39 ce                	cmp    %ecx,%esi
  802d56:	77 28                	ja     802d80 <__udivdi3+0x7c>
  802d58:	0f bd fe             	bsr    %esi,%edi
  802d5b:	83 f7 1f             	xor    $0x1f,%edi
  802d5e:	75 40                	jne    802da0 <__udivdi3+0x9c>
  802d60:	39 ce                	cmp    %ecx,%esi
  802d62:	72 0a                	jb     802d6e <__udivdi3+0x6a>
  802d64:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802d68:	0f 87 9e 00 00 00    	ja     802e0c <__udivdi3+0x108>
  802d6e:	b8 01 00 00 00       	mov    $0x1,%eax
  802d73:	89 fa                	mov    %edi,%edx
  802d75:	83 c4 1c             	add    $0x1c,%esp
  802d78:	5b                   	pop    %ebx
  802d79:	5e                   	pop    %esi
  802d7a:	5f                   	pop    %edi
  802d7b:	5d                   	pop    %ebp
  802d7c:	c3                   	ret    
  802d7d:	8d 76 00             	lea    0x0(%esi),%esi
  802d80:	31 ff                	xor    %edi,%edi
  802d82:	31 c0                	xor    %eax,%eax
  802d84:	89 fa                	mov    %edi,%edx
  802d86:	83 c4 1c             	add    $0x1c,%esp
  802d89:	5b                   	pop    %ebx
  802d8a:	5e                   	pop    %esi
  802d8b:	5f                   	pop    %edi
  802d8c:	5d                   	pop    %ebp
  802d8d:	c3                   	ret    
  802d8e:	66 90                	xchg   %ax,%ax
  802d90:	89 d8                	mov    %ebx,%eax
  802d92:	f7 f7                	div    %edi
  802d94:	31 ff                	xor    %edi,%edi
  802d96:	89 fa                	mov    %edi,%edx
  802d98:	83 c4 1c             	add    $0x1c,%esp
  802d9b:	5b                   	pop    %ebx
  802d9c:	5e                   	pop    %esi
  802d9d:	5f                   	pop    %edi
  802d9e:	5d                   	pop    %ebp
  802d9f:	c3                   	ret    
  802da0:	bd 20 00 00 00       	mov    $0x20,%ebp
  802da5:	89 eb                	mov    %ebp,%ebx
  802da7:	29 fb                	sub    %edi,%ebx
  802da9:	89 f9                	mov    %edi,%ecx
  802dab:	d3 e6                	shl    %cl,%esi
  802dad:	89 c5                	mov    %eax,%ebp
  802daf:	88 d9                	mov    %bl,%cl
  802db1:	d3 ed                	shr    %cl,%ebp
  802db3:	89 e9                	mov    %ebp,%ecx
  802db5:	09 f1                	or     %esi,%ecx
  802db7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802dbb:	89 f9                	mov    %edi,%ecx
  802dbd:	d3 e0                	shl    %cl,%eax
  802dbf:	89 c5                	mov    %eax,%ebp
  802dc1:	89 d6                	mov    %edx,%esi
  802dc3:	88 d9                	mov    %bl,%cl
  802dc5:	d3 ee                	shr    %cl,%esi
  802dc7:	89 f9                	mov    %edi,%ecx
  802dc9:	d3 e2                	shl    %cl,%edx
  802dcb:	8b 44 24 08          	mov    0x8(%esp),%eax
  802dcf:	88 d9                	mov    %bl,%cl
  802dd1:	d3 e8                	shr    %cl,%eax
  802dd3:	09 c2                	or     %eax,%edx
  802dd5:	89 d0                	mov    %edx,%eax
  802dd7:	89 f2                	mov    %esi,%edx
  802dd9:	f7 74 24 0c          	divl   0xc(%esp)
  802ddd:	89 d6                	mov    %edx,%esi
  802ddf:	89 c3                	mov    %eax,%ebx
  802de1:	f7 e5                	mul    %ebp
  802de3:	39 d6                	cmp    %edx,%esi
  802de5:	72 19                	jb     802e00 <__udivdi3+0xfc>
  802de7:	74 0b                	je     802df4 <__udivdi3+0xf0>
  802de9:	89 d8                	mov    %ebx,%eax
  802deb:	31 ff                	xor    %edi,%edi
  802ded:	e9 58 ff ff ff       	jmp    802d4a <__udivdi3+0x46>
  802df2:	66 90                	xchg   %ax,%ax
  802df4:	8b 54 24 08          	mov    0x8(%esp),%edx
  802df8:	89 f9                	mov    %edi,%ecx
  802dfa:	d3 e2                	shl    %cl,%edx
  802dfc:	39 c2                	cmp    %eax,%edx
  802dfe:	73 e9                	jae    802de9 <__udivdi3+0xe5>
  802e00:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802e03:	31 ff                	xor    %edi,%edi
  802e05:	e9 40 ff ff ff       	jmp    802d4a <__udivdi3+0x46>
  802e0a:	66 90                	xchg   %ax,%ax
  802e0c:	31 c0                	xor    %eax,%eax
  802e0e:	e9 37 ff ff ff       	jmp    802d4a <__udivdi3+0x46>
  802e13:	90                   	nop

00802e14 <__umoddi3>:
  802e14:	55                   	push   %ebp
  802e15:	57                   	push   %edi
  802e16:	56                   	push   %esi
  802e17:	53                   	push   %ebx
  802e18:	83 ec 1c             	sub    $0x1c,%esp
  802e1b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802e1f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802e23:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802e27:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802e2b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802e2f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802e33:	89 f3                	mov    %esi,%ebx
  802e35:	89 fa                	mov    %edi,%edx
  802e37:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802e3b:	89 34 24             	mov    %esi,(%esp)
  802e3e:	85 c0                	test   %eax,%eax
  802e40:	75 1a                	jne    802e5c <__umoddi3+0x48>
  802e42:	39 f7                	cmp    %esi,%edi
  802e44:	0f 86 a2 00 00 00    	jbe    802eec <__umoddi3+0xd8>
  802e4a:	89 c8                	mov    %ecx,%eax
  802e4c:	89 f2                	mov    %esi,%edx
  802e4e:	f7 f7                	div    %edi
  802e50:	89 d0                	mov    %edx,%eax
  802e52:	31 d2                	xor    %edx,%edx
  802e54:	83 c4 1c             	add    $0x1c,%esp
  802e57:	5b                   	pop    %ebx
  802e58:	5e                   	pop    %esi
  802e59:	5f                   	pop    %edi
  802e5a:	5d                   	pop    %ebp
  802e5b:	c3                   	ret    
  802e5c:	39 f0                	cmp    %esi,%eax
  802e5e:	0f 87 ac 00 00 00    	ja     802f10 <__umoddi3+0xfc>
  802e64:	0f bd e8             	bsr    %eax,%ebp
  802e67:	83 f5 1f             	xor    $0x1f,%ebp
  802e6a:	0f 84 ac 00 00 00    	je     802f1c <__umoddi3+0x108>
  802e70:	bf 20 00 00 00       	mov    $0x20,%edi
  802e75:	29 ef                	sub    %ebp,%edi
  802e77:	89 fe                	mov    %edi,%esi
  802e79:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802e7d:	89 e9                	mov    %ebp,%ecx
  802e7f:	d3 e0                	shl    %cl,%eax
  802e81:	89 d7                	mov    %edx,%edi
  802e83:	89 f1                	mov    %esi,%ecx
  802e85:	d3 ef                	shr    %cl,%edi
  802e87:	09 c7                	or     %eax,%edi
  802e89:	89 e9                	mov    %ebp,%ecx
  802e8b:	d3 e2                	shl    %cl,%edx
  802e8d:	89 14 24             	mov    %edx,(%esp)
  802e90:	89 d8                	mov    %ebx,%eax
  802e92:	d3 e0                	shl    %cl,%eax
  802e94:	89 c2                	mov    %eax,%edx
  802e96:	8b 44 24 08          	mov    0x8(%esp),%eax
  802e9a:	d3 e0                	shl    %cl,%eax
  802e9c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802ea0:	8b 44 24 08          	mov    0x8(%esp),%eax
  802ea4:	89 f1                	mov    %esi,%ecx
  802ea6:	d3 e8                	shr    %cl,%eax
  802ea8:	09 d0                	or     %edx,%eax
  802eaa:	d3 eb                	shr    %cl,%ebx
  802eac:	89 da                	mov    %ebx,%edx
  802eae:	f7 f7                	div    %edi
  802eb0:	89 d3                	mov    %edx,%ebx
  802eb2:	f7 24 24             	mull   (%esp)
  802eb5:	89 c6                	mov    %eax,%esi
  802eb7:	89 d1                	mov    %edx,%ecx
  802eb9:	39 d3                	cmp    %edx,%ebx
  802ebb:	0f 82 87 00 00 00    	jb     802f48 <__umoddi3+0x134>
  802ec1:	0f 84 91 00 00 00    	je     802f58 <__umoddi3+0x144>
  802ec7:	8b 54 24 04          	mov    0x4(%esp),%edx
  802ecb:	29 f2                	sub    %esi,%edx
  802ecd:	19 cb                	sbb    %ecx,%ebx
  802ecf:	89 d8                	mov    %ebx,%eax
  802ed1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802ed5:	d3 e0                	shl    %cl,%eax
  802ed7:	89 e9                	mov    %ebp,%ecx
  802ed9:	d3 ea                	shr    %cl,%edx
  802edb:	09 d0                	or     %edx,%eax
  802edd:	89 e9                	mov    %ebp,%ecx
  802edf:	d3 eb                	shr    %cl,%ebx
  802ee1:	89 da                	mov    %ebx,%edx
  802ee3:	83 c4 1c             	add    $0x1c,%esp
  802ee6:	5b                   	pop    %ebx
  802ee7:	5e                   	pop    %esi
  802ee8:	5f                   	pop    %edi
  802ee9:	5d                   	pop    %ebp
  802eea:	c3                   	ret    
  802eeb:	90                   	nop
  802eec:	89 fd                	mov    %edi,%ebp
  802eee:	85 ff                	test   %edi,%edi
  802ef0:	75 0b                	jne    802efd <__umoddi3+0xe9>
  802ef2:	b8 01 00 00 00       	mov    $0x1,%eax
  802ef7:	31 d2                	xor    %edx,%edx
  802ef9:	f7 f7                	div    %edi
  802efb:	89 c5                	mov    %eax,%ebp
  802efd:	89 f0                	mov    %esi,%eax
  802eff:	31 d2                	xor    %edx,%edx
  802f01:	f7 f5                	div    %ebp
  802f03:	89 c8                	mov    %ecx,%eax
  802f05:	f7 f5                	div    %ebp
  802f07:	89 d0                	mov    %edx,%eax
  802f09:	e9 44 ff ff ff       	jmp    802e52 <__umoddi3+0x3e>
  802f0e:	66 90                	xchg   %ax,%ax
  802f10:	89 c8                	mov    %ecx,%eax
  802f12:	89 f2                	mov    %esi,%edx
  802f14:	83 c4 1c             	add    $0x1c,%esp
  802f17:	5b                   	pop    %ebx
  802f18:	5e                   	pop    %esi
  802f19:	5f                   	pop    %edi
  802f1a:	5d                   	pop    %ebp
  802f1b:	c3                   	ret    
  802f1c:	3b 04 24             	cmp    (%esp),%eax
  802f1f:	72 06                	jb     802f27 <__umoddi3+0x113>
  802f21:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802f25:	77 0f                	ja     802f36 <__umoddi3+0x122>
  802f27:	89 f2                	mov    %esi,%edx
  802f29:	29 f9                	sub    %edi,%ecx
  802f2b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802f2f:	89 14 24             	mov    %edx,(%esp)
  802f32:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802f36:	8b 44 24 04          	mov    0x4(%esp),%eax
  802f3a:	8b 14 24             	mov    (%esp),%edx
  802f3d:	83 c4 1c             	add    $0x1c,%esp
  802f40:	5b                   	pop    %ebx
  802f41:	5e                   	pop    %esi
  802f42:	5f                   	pop    %edi
  802f43:	5d                   	pop    %ebp
  802f44:	c3                   	ret    
  802f45:	8d 76 00             	lea    0x0(%esi),%esi
  802f48:	2b 04 24             	sub    (%esp),%eax
  802f4b:	19 fa                	sbb    %edi,%edx
  802f4d:	89 d1                	mov    %edx,%ecx
  802f4f:	89 c6                	mov    %eax,%esi
  802f51:	e9 71 ff ff ff       	jmp    802ec7 <__umoddi3+0xb3>
  802f56:	66 90                	xchg   %ax,%ax
  802f58:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802f5c:	72 ea                	jb     802f48 <__umoddi3+0x134>
  802f5e:	89 d9                	mov    %ebx,%ecx
  802f60:	e9 62 ff ff ff       	jmp    802ec7 <__umoddi3+0xb3>
