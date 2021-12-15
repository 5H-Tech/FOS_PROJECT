
obj/user/tst_freeRAM_2:     file format elf32-i386


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
  800031:	e8 ac 05 00 00       	call   8005e2 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
	char a;
	short b;
	int c;
};
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	81 ec b0 00 00 00    	sub    $0xb0,%esp





	int Mega = 1024*1024;
  800043:	c7 45 f4 00 00 10 00 	movl   $0x100000,-0xc(%ebp)
	int kilo = 1024;
  80004a:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)
	char minByte = 1<<7;
  800051:	c6 45 ef 80          	movb   $0x80,-0x11(%ebp)
	char maxByte = 0x7F;
  800055:	c6 45 ee 7f          	movb   $0x7f,-0x12(%ebp)
	short minShort = 1<<15 ;
  800059:	66 c7 45 ec 00 80    	movw   $0x8000,-0x14(%ebp)
	short maxShort = 0x7FFF;
  80005f:	66 c7 45 ea ff 7f    	movw   $0x7fff,-0x16(%ebp)
	int minInt = 1<<31 ;
  800065:	c7 45 e4 00 00 00 80 	movl   $0x80000000,-0x1c(%ebp)
	int maxInt = 0x7FFFFFFF;
  80006c:	c7 45 e0 ff ff ff 7f 	movl   $0x7fffffff,-0x20(%ebp)

	void* ptr_allocations[20] = {0};
  800073:	8d 95 4c ff ff ff    	lea    -0xb4(%ebp),%edx
  800079:	b9 14 00 00 00       	mov    $0x14,%ecx
  80007e:	b8 00 00 00 00       	mov    $0x0,%eax
  800083:	89 d7                	mov    %edx,%edi
  800085:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		//Load "fib" & "fos_helloWorld" programs into RAM
		cprintf("Loading Fib & fos_helloWorld programs into RAM...");
  800087:	83 ec 0c             	sub    $0xc,%esp
  80008a:	68 80 23 80 00       	push   $0x802380
  80008f:	e8 35 09 00 00       	call   8009c9 <cprintf>
  800094:	83 c4 10             	add    $0x10,%esp
		int32 envIdFib = sys_create_env("fib", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  800097:	a1 20 30 80 00       	mov    0x803020,%eax
  80009c:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8000a2:	a1 20 30 80 00       	mov    0x803020,%eax
  8000a7:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000ad:	89 c1                	mov    %eax,%ecx
  8000af:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b4:	8b 40 74             	mov    0x74(%eax),%eax
  8000b7:	52                   	push   %edx
  8000b8:	51                   	push   %ecx
  8000b9:	50                   	push   %eax
  8000ba:	68 b2 23 80 00       	push   $0x8023b2
  8000bf:	e8 f1 1c 00 00       	call   801db5 <sys_create_env>
  8000c4:	83 c4 10             	add    $0x10,%esp
  8000c7:	89 45 dc             	mov    %eax,-0x24(%ebp)
		int freeFrames = sys_calculate_free_frames() ;
  8000ca:	e8 91 1a 00 00       	call   801b60 <sys_calculate_free_frames>
  8000cf:	89 45 d8             	mov    %eax,-0x28(%ebp)
		int32 envIdHelloWorld = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d7:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8000dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e2:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8000e8:	89 c1                	mov    %eax,%ecx
  8000ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ef:	8b 40 74             	mov    0x74(%eax),%eax
  8000f2:	52                   	push   %edx
  8000f3:	51                   	push   %ecx
  8000f4:	50                   	push   %eax
  8000f5:	68 b6 23 80 00       	push   $0x8023b6
  8000fa:	e8 b6 1c 00 00       	call   801db5 <sys_create_env>
  8000ff:	83 c4 10             	add    $0x10,%esp
  800102:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		int helloWorldFrames = freeFrames - sys_calculate_free_frames() ;
  800105:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  800108:	e8 53 1a 00 00       	call   801b60 <sys_calculate_free_frames>
  80010d:	29 c3                	sub    %eax,%ebx
  80010f:	89 d8                	mov    %ebx,%eax
  800111:	89 45 d0             	mov    %eax,-0x30(%ebp)
		env_sleep(2000);
  800114:	83 ec 0c             	sub    $0xc,%esp
  800117:	68 d0 07 00 00       	push   $0x7d0
  80011c:	e8 30 1f 00 00       	call   802051 <env_sleep>
  800121:	83 c4 10             	add    $0x10,%esp
		cprintf("[DONE]\n\n");
  800124:	83 ec 0c             	sub    $0xc,%esp
  800127:	68 c5 23 80 00       	push   $0x8023c5
  80012c:	e8 98 08 00 00       	call   8009c9 <cprintf>
  800131:	83 c4 10             	add    $0x10,%esp

		//Load and run "fos_add"
		cprintf("Loading fos_add program into RAM...");
  800134:	83 ec 0c             	sub    $0xc,%esp
  800137:	68 d0 23 80 00       	push   $0x8023d0
  80013c:	e8 88 08 00 00       	call   8009c9 <cprintf>
  800141:	83 c4 10             	add    $0x10,%esp
		int32 envIdFOSAdd= sys_create_env("fos_add", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  800144:	a1 20 30 80 00       	mov    0x803020,%eax
  800149:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  80014f:	a1 20 30 80 00       	mov    0x803020,%eax
  800154:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  80015a:	89 c1                	mov    %eax,%ecx
  80015c:	a1 20 30 80 00       	mov    0x803020,%eax
  800161:	8b 40 74             	mov    0x74(%eax),%eax
  800164:	52                   	push   %edx
  800165:	51                   	push   %ecx
  800166:	50                   	push   %eax
  800167:	68 f4 23 80 00       	push   $0x8023f4
  80016c:	e8 44 1c 00 00       	call   801db5 <sys_create_env>
  800171:	83 c4 10             	add    $0x10,%esp
  800174:	89 45 cc             	mov    %eax,-0x34(%ebp)
		env_sleep(2000);
  800177:	83 ec 0c             	sub    $0xc,%esp
  80017a:	68 d0 07 00 00       	push   $0x7d0
  80017f:	e8 cd 1e 00 00       	call   802051 <env_sleep>
  800184:	83 c4 10             	add    $0x10,%esp
		cprintf("[DONE]\n\n");
  800187:	83 ec 0c             	sub    $0xc,%esp
  80018a:	68 c5 23 80 00       	push   $0x8023c5
  80018f:	e8 35 08 00 00       	call   8009c9 <cprintf>
  800194:	83 c4 10             	add    $0x10,%esp
		cprintf("running fos_add program...\n\n");
  800197:	83 ec 0c             	sub    $0xc,%esp
  80019a:	68 fc 23 80 00       	push   $0x8023fc
  80019f:	e8 25 08 00 00       	call   8009c9 <cprintf>
  8001a4:	83 c4 10             	add    $0x10,%esp
		sys_run_env(envIdFOSAdd);
  8001a7:	83 ec 0c             	sub    $0xc,%esp
  8001aa:	ff 75 cc             	pushl  -0x34(%ebp)
  8001ad:	e8 21 1c 00 00       	call   801dd3 <sys_run_env>
  8001b2:	83 c4 10             	add    $0x10,%esp

		cprintf("please be patient ...\n");
  8001b5:	83 ec 0c             	sub    $0xc,%esp
  8001b8:	68 19 24 80 00       	push   $0x802419
  8001bd:	e8 07 08 00 00       	call   8009c9 <cprintf>
  8001c2:	83 c4 10             	add    $0x10,%esp
		env_sleep(5000);
  8001c5:	83 ec 0c             	sub    $0xc,%esp
  8001c8:	68 88 13 00 00       	push   $0x1388
  8001cd:	e8 7f 1e 00 00       	call   802051 <env_sleep>
  8001d2:	83 c4 10             	add    $0x10,%esp

		//Allocate 2 MB
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8001d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001d8:	01 c0                	add    %eax,%eax
  8001da:	2b 45 f0             	sub    -0x10(%ebp),%eax
  8001dd:	83 ec 0c             	sub    $0xc,%esp
  8001e0:	50                   	push   %eax
  8001e1:	e8 6d 15 00 00       	call   801753 <malloc>
  8001e6:	83 c4 10             	add    $0x10,%esp
  8001e9:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
		char *byteArr = (char *) ptr_allocations[0];
  8001ef:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  8001f5:	89 45 c8             	mov    %eax,-0x38(%ebp)
		int lastIndexOfByte = (2*Mega-kilo)/sizeof(char) - 1;
  8001f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001fb:	01 c0                	add    %eax,%eax
  8001fd:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800200:	48                   	dec    %eax
  800201:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		byteArr[0] = minByte ;
  800204:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800207:	8a 55 ef             	mov    -0x11(%ebp),%dl
  80020a:	88 10                	mov    %dl,(%eax)
		byteArr[lastIndexOfByte] = maxByte ;
  80020c:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  80020f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800212:	01 c2                	add    %eax,%edx
  800214:	8a 45 ee             	mov    -0x12(%ebp),%al
  800217:	88 02                	mov    %al,(%edx)

		//Allocate another 2 MB
		ptr_allocations[1] = malloc(2*Mega-kilo);
  800219:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80021c:	01 c0                	add    %eax,%eax
  80021e:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800221:	83 ec 0c             	sub    $0xc,%esp
  800224:	50                   	push   %eax
  800225:	e8 29 15 00 00       	call   801753 <malloc>
  80022a:	83 c4 10             	add    $0x10,%esp
  80022d:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
		short *shortArr = (short *) ptr_allocations[1];
  800233:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800239:	89 45 c0             	mov    %eax,-0x40(%ebp)
		int lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  80023c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80023f:	01 c0                	add    %eax,%eax
  800241:	2b 45 f0             	sub    -0x10(%ebp),%eax
  800244:	d1 e8                	shr    %eax
  800246:	48                   	dec    %eax
  800247:	89 45 bc             	mov    %eax,-0x44(%ebp)
		shortArr[0] = minShort;
  80024a:	8b 55 c0             	mov    -0x40(%ebp),%edx
  80024d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800250:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  800253:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800256:	01 c0                	add    %eax,%eax
  800258:	89 c2                	mov    %eax,%edx
  80025a:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80025d:	01 c2                	add    %eax,%edx
  80025f:	66 8b 45 ea          	mov    -0x16(%ebp),%ax
  800263:	66 89 02             	mov    %ax,(%edx)

		//Allocate all remaining RAM (Here: it requires to free some RAM by removing exited program (fos_add))
		freeFrames = sys_calculate_free_frames() ;
  800266:	e8 f5 18 00 00       	call   801b60 <sys_calculate_free_frames>
  80026b:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[2] = malloc(freeFrames*PAGE_SIZE);
  80026e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800271:	c1 e0 0c             	shl    $0xc,%eax
  800274:	83 ec 0c             	sub    $0xc,%esp
  800277:	50                   	push   %eax
  800278:	e8 d6 14 00 00       	call   801753 <malloc>
  80027d:	83 c4 10             	add    $0x10,%esp
  800280:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
		int *intArr = (int *) ptr_allocations[2];
  800286:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  80028c:	89 45 b8             	mov    %eax,-0x48(%ebp)
		int lastIndexOfInt = (freeFrames*PAGE_SIZE)/sizeof(int) - 1;
  80028f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800292:	c1 e0 0c             	shl    $0xc,%eax
  800295:	c1 e8 02             	shr    $0x2,%eax
  800298:	48                   	dec    %eax
  800299:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		intArr[0] = minInt;
  80029c:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80029f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8002a2:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  8002a4:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8002a7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002ae:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8002b1:	01 c2                	add    %eax,%edx
  8002b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002b6:	89 02                	mov    %eax,(%edx)

		//Allocate 7 KB after freeing some RAM
		ptr_allocations[3] = malloc(7*kilo);
  8002b8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8002bb:	89 d0                	mov    %edx,%eax
  8002bd:	01 c0                	add    %eax,%eax
  8002bf:	01 d0                	add    %edx,%eax
  8002c1:	01 c0                	add    %eax,%eax
  8002c3:	01 d0                	add    %edx,%eax
  8002c5:	83 ec 0c             	sub    $0xc,%esp
  8002c8:	50                   	push   %eax
  8002c9:	e8 85 14 00 00       	call   801753 <malloc>
  8002ce:	83 c4 10             	add    $0x10,%esp
  8002d1:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
		struct MyStruct *structArr = (struct MyStruct *) ptr_allocations[3];
  8002d7:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  8002dd:	89 45 b0             	mov    %eax,-0x50(%ebp)
		int lastIndexOfStruct = (7*kilo)/sizeof(struct MyStruct) - 1;
  8002e0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8002e3:	89 d0                	mov    %edx,%eax
  8002e5:	01 c0                	add    %eax,%eax
  8002e7:	01 d0                	add    %edx,%eax
  8002e9:	01 c0                	add    %eax,%eax
  8002eb:	01 d0                	add    %edx,%eax
  8002ed:	c1 e8 03             	shr    $0x3,%eax
  8002f0:	48                   	dec    %eax
  8002f1:	89 45 ac             	mov    %eax,-0x54(%ebp)
		structArr[0].a = minByte; structArr[0].b = minShort; structArr[0].c = minInt;
  8002f4:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8002f7:	8a 55 ef             	mov    -0x11(%ebp),%dl
  8002fa:	88 10                	mov    %dl,(%eax)
  8002fc:	8b 55 b0             	mov    -0x50(%ebp),%edx
  8002ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800302:	66 89 42 02          	mov    %ax,0x2(%edx)
  800306:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800309:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80030c:	89 50 04             	mov    %edx,0x4(%eax)
		structArr[lastIndexOfStruct].a = maxByte; structArr[lastIndexOfStruct].b = maxShort; structArr[lastIndexOfStruct].c = maxInt;
  80030f:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800312:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800319:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80031c:	01 c2                	add    %eax,%edx
  80031e:	8a 45 ee             	mov    -0x12(%ebp),%al
  800321:	88 02                	mov    %al,(%edx)
  800323:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800326:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80032d:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800330:	01 c2                	add    %eax,%edx
  800332:	66 8b 45 ea          	mov    -0x16(%ebp),%ax
  800336:	66 89 42 02          	mov    %ax,0x2(%edx)
  80033a:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80033d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800344:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800347:	01 c2                	add    %eax,%edx
  800349:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80034c:	89 42 04             	mov    %eax,0x4(%edx)

		cprintf("running fos_helloWorld program...\n\n");
  80034f:	83 ec 0c             	sub    $0xc,%esp
  800352:	68 30 24 80 00       	push   $0x802430
  800357:	e8 6d 06 00 00       	call   8009c9 <cprintf>
  80035c:	83 c4 10             	add    $0x10,%esp
		sys_run_env(envIdHelloWorld);
  80035f:	83 ec 0c             	sub    $0xc,%esp
  800362:	ff 75 d4             	pushl  -0x2c(%ebp)
  800365:	e8 69 1a 00 00       	call   801dd3 <sys_run_env>
  80036a:	83 c4 10             	add    $0x10,%esp

		cprintf("please be patient ...\n");
  80036d:	83 ec 0c             	sub    $0xc,%esp
  800370:	68 19 24 80 00       	push   $0x802419
  800375:	e8 4f 06 00 00       	call   8009c9 <cprintf>
  80037a:	83 c4 10             	add    $0x10,%esp
		env_sleep(5000);
  80037d:	83 ec 0c             	sub    $0xc,%esp
  800380:	68 88 13 00 00       	push   $0x1388
  800385:	e8 c7 1c 00 00       	call   802051 <env_sleep>
  80038a:	83 c4 10             	add    $0x10,%esp

		//Allocate the remaining RAM + extra RAM by the size of helloWorld program (Here: it requires to free some RAM by removing exited & loaded program(s) (fos_helloWorld & fib))
		freeFrames = sys_calculate_free_frames() ;
  80038d:	e8 ce 17 00 00       	call   801b60 <sys_calculate_free_frames>
  800392:	89 45 d8             	mov    %eax,-0x28(%ebp)
		ptr_allocations[4] = malloc((freeFrames + helloWorldFrames)*PAGE_SIZE);
  800395:	8b 55 d8             	mov    -0x28(%ebp),%edx
  800398:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80039b:	01 d0                	add    %edx,%eax
  80039d:	c1 e0 0c             	shl    $0xc,%eax
  8003a0:	83 ec 0c             	sub    $0xc,%esp
  8003a3:	50                   	push   %eax
  8003a4:	e8 aa 13 00 00       	call   801753 <malloc>
  8003a9:	83 c4 10             	add    $0x10,%esp
  8003ac:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
		int *intArr2 = (int *) ptr_allocations[4];
  8003b2:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  8003b8:	89 45 a8             	mov    %eax,-0x58(%ebp)
		int lastIndexOfInt2 = ((freeFrames + helloWorldFrames)*PAGE_SIZE)/sizeof(int) - 1;
  8003bb:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8003be:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8003c1:	01 d0                	add    %edx,%eax
  8003c3:	c1 e0 0c             	shl    $0xc,%eax
  8003c6:	c1 e8 02             	shr    $0x2,%eax
  8003c9:	48                   	dec    %eax
  8003ca:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		intArr2[0] = minInt;
  8003cd:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8003d3:	89 10                	mov    %edx,(%eax)
		intArr2[lastIndexOfInt2] = maxInt;
  8003d5:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003d8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003df:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003e2:	01 c2                	add    %eax,%edx
  8003e4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003e7:	89 02                	mov    %eax,(%edx)

		//Allocate 8 B after freeing the RAM
		ptr_allocations[5] = malloc(8);
  8003e9:	83 ec 0c             	sub    $0xc,%esp
  8003ec:	6a 08                	push   $0x8
  8003ee:	e8 60 13 00 00       	call   801753 <malloc>
  8003f3:	83 c4 10             	add    $0x10,%esp
  8003f6:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
		int *intArr3 = (int *) ptr_allocations[5];
  8003fc:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  800402:	89 45 a0             	mov    %eax,-0x60(%ebp)
		int lastIndexOfInt3 = 8/sizeof(int) - 1;
  800405:	c7 45 9c 01 00 00 00 	movl   $0x1,-0x64(%ebp)
		intArr3[0] = minInt;
  80040c:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80040f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800412:	89 10                	mov    %edx,(%eax)
		intArr3[lastIndexOfInt3] = maxInt;
  800414:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800417:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80041e:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800421:	01 c2                	add    %eax,%edx
  800423:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800426:	89 02                	mov    %eax,(%edx)

		//Check that the values are successfully stored
		if (byteArr[0] 	!= minByte 	|| byteArr[lastIndexOfByte] 	!= maxByte) panic("Wrong allocation: stored values are wrongly changed!");
  800428:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80042b:	8a 00                	mov    (%eax),%al
  80042d:	3a 45 ef             	cmp    -0x11(%ebp),%al
  800430:	75 0f                	jne    800441 <_main+0x409>
  800432:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  800435:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800438:	01 d0                	add    %edx,%eax
  80043a:	8a 00                	mov    (%eax),%al
  80043c:	3a 45 ee             	cmp    -0x12(%ebp),%al
  80043f:	74 14                	je     800455 <_main+0x41d>
  800441:	83 ec 04             	sub    $0x4,%esp
  800444:	68 54 24 80 00       	push   $0x802454
  800449:	6a 62                	push   $0x62
  80044b:	68 89 24 80 00       	push   $0x802489
  800450:	e8 d2 02 00 00       	call   800727 <_panic>
		if (shortArr[0] != minShort || shortArr[lastIndexOfShort] 	!= maxShort) panic("Wrong allocation: stored values are wrongly changed!");
  800455:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800458:	66 8b 00             	mov    (%eax),%ax
  80045b:	66 3b 45 ec          	cmp    -0x14(%ebp),%ax
  80045f:	75 15                	jne    800476 <_main+0x43e>
  800461:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800464:	01 c0                	add    %eax,%eax
  800466:	89 c2                	mov    %eax,%edx
  800468:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80046b:	01 d0                	add    %edx,%eax
  80046d:	66 8b 00             	mov    (%eax),%ax
  800470:	66 3b 45 ea          	cmp    -0x16(%ebp),%ax
  800474:	74 14                	je     80048a <_main+0x452>
  800476:	83 ec 04             	sub    $0x4,%esp
  800479:	68 54 24 80 00       	push   $0x802454
  80047e:	6a 63                	push   $0x63
  800480:	68 89 24 80 00       	push   $0x802489
  800485:	e8 9d 02 00 00       	call   800727 <_panic>
		if (intArr[0] 	!= minInt 	|| intArr[lastIndexOfInt] 		!= maxInt) panic("Wrong allocation: stored values are wrongly changed!");
  80048a:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80048d:	8b 00                	mov    (%eax),%eax
  80048f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800492:	75 16                	jne    8004aa <_main+0x472>
  800494:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800497:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80049e:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8004a1:	01 d0                	add    %edx,%eax
  8004a3:	8b 00                	mov    (%eax),%eax
  8004a5:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8004a8:	74 14                	je     8004be <_main+0x486>
  8004aa:	83 ec 04             	sub    $0x4,%esp
  8004ad:	68 54 24 80 00       	push   $0x802454
  8004b2:	6a 64                	push   $0x64
  8004b4:	68 89 24 80 00       	push   $0x802489
  8004b9:	e8 69 02 00 00       	call   800727 <_panic>
		if (intArr2[0] 	!= minInt 	|| intArr2[lastIndexOfInt2] 	!= maxInt) panic("Wrong allocation: stored values are wrongly changed!");
  8004be:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8004c1:	8b 00                	mov    (%eax),%eax
  8004c3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004c6:	75 16                	jne    8004de <_main+0x4a6>
  8004c8:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8004cb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004d2:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8004d5:	01 d0                	add    %edx,%eax
  8004d7:	8b 00                	mov    (%eax),%eax
  8004d9:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8004dc:	74 14                	je     8004f2 <_main+0x4ba>
  8004de:	83 ec 04             	sub    $0x4,%esp
  8004e1:	68 54 24 80 00       	push   $0x802454
  8004e6:	6a 65                	push   $0x65
  8004e8:	68 89 24 80 00       	push   $0x802489
  8004ed:	e8 35 02 00 00       	call   800727 <_panic>
		if (intArr3[0] 	!= minInt 	|| intArr3[lastIndexOfInt3] 	!= maxInt) panic("Wrong allocation: stored values are wrongly changed!");
  8004f2:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8004f5:	8b 00                	mov    (%eax),%eax
  8004f7:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004fa:	75 16                	jne    800512 <_main+0x4da>
  8004fc:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8004ff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800506:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800509:	01 d0                	add    %edx,%eax
  80050b:	8b 00                	mov    (%eax),%eax
  80050d:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800510:	74 14                	je     800526 <_main+0x4ee>
  800512:	83 ec 04             	sub    $0x4,%esp
  800515:	68 54 24 80 00       	push   $0x802454
  80051a:	6a 66                	push   $0x66
  80051c:	68 89 24 80 00       	push   $0x802489
  800521:	e8 01 02 00 00       	call   800727 <_panic>

		if (structArr[0].a != minByte 	|| structArr[lastIndexOfStruct].a != maxByte) 	panic("Wrong allocation: stored values are wrongly changed!");
  800526:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800529:	8a 00                	mov    (%eax),%al
  80052b:	3a 45 ef             	cmp    -0x11(%ebp),%al
  80052e:	75 16                	jne    800546 <_main+0x50e>
  800530:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800533:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  80053a:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80053d:	01 d0                	add    %edx,%eax
  80053f:	8a 00                	mov    (%eax),%al
  800541:	3a 45 ee             	cmp    -0x12(%ebp),%al
  800544:	74 14                	je     80055a <_main+0x522>
  800546:	83 ec 04             	sub    $0x4,%esp
  800549:	68 54 24 80 00       	push   $0x802454
  80054e:	6a 68                	push   $0x68
  800550:	68 89 24 80 00       	push   $0x802489
  800555:	e8 cd 01 00 00       	call   800727 <_panic>
		if (structArr[0].b != minShort 	|| structArr[lastIndexOfStruct].b != maxShort) 	panic("Wrong allocation: stored values are wrongly changed!");
  80055a:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80055d:	66 8b 40 02          	mov    0x2(%eax),%ax
  800561:	66 3b 45 ec          	cmp    -0x14(%ebp),%ax
  800565:	75 19                	jne    800580 <_main+0x548>
  800567:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80056a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  800571:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800574:	01 d0                	add    %edx,%eax
  800576:	66 8b 40 02          	mov    0x2(%eax),%ax
  80057a:	66 3b 45 ea          	cmp    -0x16(%ebp),%ax
  80057e:	74 14                	je     800594 <_main+0x55c>
  800580:	83 ec 04             	sub    $0x4,%esp
  800583:	68 54 24 80 00       	push   $0x802454
  800588:	6a 69                	push   $0x69
  80058a:	68 89 24 80 00       	push   $0x802489
  80058f:	e8 93 01 00 00       	call   800727 <_panic>
		if (structArr[0].c != minInt 	|| structArr[lastIndexOfStruct].c != maxInt) 	panic("Wrong allocation: stored values are wrongly changed!");
  800594:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800597:	8b 40 04             	mov    0x4(%eax),%eax
  80059a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80059d:	75 17                	jne    8005b6 <_main+0x57e>
  80059f:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8005a2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
  8005a9:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8005ac:	01 d0                	add    %edx,%eax
  8005ae:	8b 40 04             	mov    0x4(%eax),%eax
  8005b1:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005b4:	74 14                	je     8005ca <_main+0x592>
  8005b6:	83 ec 04             	sub    $0x4,%esp
  8005b9:	68 54 24 80 00       	push   $0x802454
  8005be:	6a 6a                	push   $0x6a
  8005c0:	68 89 24 80 00       	push   $0x802489
  8005c5:	e8 5d 01 00 00       	call   800727 <_panic>


	}

	cprintf("Congratulations!! test freeRAM (1) completed successfully.\n");
  8005ca:	83 ec 0c             	sub    $0xc,%esp
  8005cd:	68 a0 24 80 00       	push   $0x8024a0
  8005d2:	e8 f2 03 00 00       	call   8009c9 <cprintf>
  8005d7:	83 c4 10             	add    $0x10,%esp

	return;
  8005da:	90                   	nop
}
  8005db:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8005de:	5b                   	pop    %ebx
  8005df:	5f                   	pop    %edi
  8005e0:	5d                   	pop    %ebp
  8005e1:	c3                   	ret    

008005e2 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005e2:	55                   	push   %ebp
  8005e3:	89 e5                	mov    %esp,%ebp
  8005e5:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005e8:	e8 a8 14 00 00       	call   801a95 <sys_getenvindex>
  8005ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005f3:	89 d0                	mov    %edx,%eax
  8005f5:	c1 e0 03             	shl    $0x3,%eax
  8005f8:	01 d0                	add    %edx,%eax
  8005fa:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800601:	01 c8                	add    %ecx,%eax
  800603:	01 c0                	add    %eax,%eax
  800605:	01 d0                	add    %edx,%eax
  800607:	01 c0                	add    %eax,%eax
  800609:	01 d0                	add    %edx,%eax
  80060b:	89 c2                	mov    %eax,%edx
  80060d:	c1 e2 05             	shl    $0x5,%edx
  800610:	29 c2                	sub    %eax,%edx
  800612:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800619:	89 c2                	mov    %eax,%edx
  80061b:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800621:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800626:	a1 20 30 80 00       	mov    0x803020,%eax
  80062b:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800631:	84 c0                	test   %al,%al
  800633:	74 0f                	je     800644 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800635:	a1 20 30 80 00       	mov    0x803020,%eax
  80063a:	05 40 3c 01 00       	add    $0x13c40,%eax
  80063f:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800644:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800648:	7e 0a                	jle    800654 <libmain+0x72>
		binaryname = argv[0];
  80064a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80064d:	8b 00                	mov    (%eax),%eax
  80064f:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800654:	83 ec 08             	sub    $0x8,%esp
  800657:	ff 75 0c             	pushl  0xc(%ebp)
  80065a:	ff 75 08             	pushl  0x8(%ebp)
  80065d:	e8 d6 f9 ff ff       	call   800038 <_main>
  800662:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800665:	e8 c6 15 00 00       	call   801c30 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80066a:	83 ec 0c             	sub    $0xc,%esp
  80066d:	68 f4 24 80 00       	push   $0x8024f4
  800672:	e8 52 03 00 00       	call   8009c9 <cprintf>
  800677:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80067a:	a1 20 30 80 00       	mov    0x803020,%eax
  80067f:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800685:	a1 20 30 80 00       	mov    0x803020,%eax
  80068a:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800690:	83 ec 04             	sub    $0x4,%esp
  800693:	52                   	push   %edx
  800694:	50                   	push   %eax
  800695:	68 1c 25 80 00       	push   $0x80251c
  80069a:	e8 2a 03 00 00       	call   8009c9 <cprintf>
  80069f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8006a2:	a1 20 30 80 00       	mov    0x803020,%eax
  8006a7:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8006ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8006b2:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8006b8:	83 ec 04             	sub    $0x4,%esp
  8006bb:	52                   	push   %edx
  8006bc:	50                   	push   %eax
  8006bd:	68 44 25 80 00       	push   $0x802544
  8006c2:	e8 02 03 00 00       	call   8009c9 <cprintf>
  8006c7:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006ca:	a1 20 30 80 00       	mov    0x803020,%eax
  8006cf:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8006d5:	83 ec 08             	sub    $0x8,%esp
  8006d8:	50                   	push   %eax
  8006d9:	68 85 25 80 00       	push   $0x802585
  8006de:	e8 e6 02 00 00       	call   8009c9 <cprintf>
  8006e3:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006e6:	83 ec 0c             	sub    $0xc,%esp
  8006e9:	68 f4 24 80 00       	push   $0x8024f4
  8006ee:	e8 d6 02 00 00       	call   8009c9 <cprintf>
  8006f3:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006f6:	e8 4f 15 00 00       	call   801c4a <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006fb:	e8 19 00 00 00       	call   800719 <exit>
}
  800700:	90                   	nop
  800701:	c9                   	leave  
  800702:	c3                   	ret    

00800703 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800703:	55                   	push   %ebp
  800704:	89 e5                	mov    %esp,%ebp
  800706:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800709:	83 ec 0c             	sub    $0xc,%esp
  80070c:	6a 00                	push   $0x0
  80070e:	e8 4e 13 00 00       	call   801a61 <sys_env_destroy>
  800713:	83 c4 10             	add    $0x10,%esp
}
  800716:	90                   	nop
  800717:	c9                   	leave  
  800718:	c3                   	ret    

00800719 <exit>:

void
exit(void)
{
  800719:	55                   	push   %ebp
  80071a:	89 e5                	mov    %esp,%ebp
  80071c:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80071f:	e8 a3 13 00 00       	call   801ac7 <sys_env_exit>
}
  800724:	90                   	nop
  800725:	c9                   	leave  
  800726:	c3                   	ret    

00800727 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800727:	55                   	push   %ebp
  800728:	89 e5                	mov    %esp,%ebp
  80072a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80072d:	8d 45 10             	lea    0x10(%ebp),%eax
  800730:	83 c0 04             	add    $0x4,%eax
  800733:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800736:	a1 18 31 80 00       	mov    0x803118,%eax
  80073b:	85 c0                	test   %eax,%eax
  80073d:	74 16                	je     800755 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80073f:	a1 18 31 80 00       	mov    0x803118,%eax
  800744:	83 ec 08             	sub    $0x8,%esp
  800747:	50                   	push   %eax
  800748:	68 9c 25 80 00       	push   $0x80259c
  80074d:	e8 77 02 00 00       	call   8009c9 <cprintf>
  800752:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800755:	a1 00 30 80 00       	mov    0x803000,%eax
  80075a:	ff 75 0c             	pushl  0xc(%ebp)
  80075d:	ff 75 08             	pushl  0x8(%ebp)
  800760:	50                   	push   %eax
  800761:	68 a1 25 80 00       	push   $0x8025a1
  800766:	e8 5e 02 00 00       	call   8009c9 <cprintf>
  80076b:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80076e:	8b 45 10             	mov    0x10(%ebp),%eax
  800771:	83 ec 08             	sub    $0x8,%esp
  800774:	ff 75 f4             	pushl  -0xc(%ebp)
  800777:	50                   	push   %eax
  800778:	e8 e1 01 00 00       	call   80095e <vcprintf>
  80077d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800780:	83 ec 08             	sub    $0x8,%esp
  800783:	6a 00                	push   $0x0
  800785:	68 bd 25 80 00       	push   $0x8025bd
  80078a:	e8 cf 01 00 00       	call   80095e <vcprintf>
  80078f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800792:	e8 82 ff ff ff       	call   800719 <exit>

	// should not return here
	while (1) ;
  800797:	eb fe                	jmp    800797 <_panic+0x70>

00800799 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800799:	55                   	push   %ebp
  80079a:	89 e5                	mov    %esp,%ebp
  80079c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80079f:	a1 20 30 80 00       	mov    0x803020,%eax
  8007a4:	8b 50 74             	mov    0x74(%eax),%edx
  8007a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007aa:	39 c2                	cmp    %eax,%edx
  8007ac:	74 14                	je     8007c2 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007ae:	83 ec 04             	sub    $0x4,%esp
  8007b1:	68 c0 25 80 00       	push   $0x8025c0
  8007b6:	6a 26                	push   $0x26
  8007b8:	68 0c 26 80 00       	push   $0x80260c
  8007bd:	e8 65 ff ff ff       	call   800727 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007c9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007d0:	e9 b6 00 00 00       	jmp    80088b <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8007d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007d8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007df:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e2:	01 d0                	add    %edx,%eax
  8007e4:	8b 00                	mov    (%eax),%eax
  8007e6:	85 c0                	test   %eax,%eax
  8007e8:	75 08                	jne    8007f2 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007ea:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007ed:	e9 96 00 00 00       	jmp    800888 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8007f2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007f9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800800:	eb 5d                	jmp    80085f <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800802:	a1 20 30 80 00       	mov    0x803020,%eax
  800807:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80080d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800810:	c1 e2 04             	shl    $0x4,%edx
  800813:	01 d0                	add    %edx,%eax
  800815:	8a 40 04             	mov    0x4(%eax),%al
  800818:	84 c0                	test   %al,%al
  80081a:	75 40                	jne    80085c <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80081c:	a1 20 30 80 00       	mov    0x803020,%eax
  800821:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800827:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80082a:	c1 e2 04             	shl    $0x4,%edx
  80082d:	01 d0                	add    %edx,%eax
  80082f:	8b 00                	mov    (%eax),%eax
  800831:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800834:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800837:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80083c:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80083e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800841:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800848:	8b 45 08             	mov    0x8(%ebp),%eax
  80084b:	01 c8                	add    %ecx,%eax
  80084d:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80084f:	39 c2                	cmp    %eax,%edx
  800851:	75 09                	jne    80085c <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800853:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80085a:	eb 12                	jmp    80086e <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80085c:	ff 45 e8             	incl   -0x18(%ebp)
  80085f:	a1 20 30 80 00       	mov    0x803020,%eax
  800864:	8b 50 74             	mov    0x74(%eax),%edx
  800867:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80086a:	39 c2                	cmp    %eax,%edx
  80086c:	77 94                	ja     800802 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80086e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800872:	75 14                	jne    800888 <CheckWSWithoutLastIndex+0xef>
			panic(
  800874:	83 ec 04             	sub    $0x4,%esp
  800877:	68 18 26 80 00       	push   $0x802618
  80087c:	6a 3a                	push   $0x3a
  80087e:	68 0c 26 80 00       	push   $0x80260c
  800883:	e8 9f fe ff ff       	call   800727 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800888:	ff 45 f0             	incl   -0x10(%ebp)
  80088b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80088e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800891:	0f 8c 3e ff ff ff    	jl     8007d5 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800897:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80089e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008a5:	eb 20                	jmp    8008c7 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8008ac:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8008b2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008b5:	c1 e2 04             	shl    $0x4,%edx
  8008b8:	01 d0                	add    %edx,%eax
  8008ba:	8a 40 04             	mov    0x4(%eax),%al
  8008bd:	3c 01                	cmp    $0x1,%al
  8008bf:	75 03                	jne    8008c4 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8008c1:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008c4:	ff 45 e0             	incl   -0x20(%ebp)
  8008c7:	a1 20 30 80 00       	mov    0x803020,%eax
  8008cc:	8b 50 74             	mov    0x74(%eax),%edx
  8008cf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008d2:	39 c2                	cmp    %eax,%edx
  8008d4:	77 d1                	ja     8008a7 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008d9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008dc:	74 14                	je     8008f2 <CheckWSWithoutLastIndex+0x159>
		panic(
  8008de:	83 ec 04             	sub    $0x4,%esp
  8008e1:	68 6c 26 80 00       	push   $0x80266c
  8008e6:	6a 44                	push   $0x44
  8008e8:	68 0c 26 80 00       	push   $0x80260c
  8008ed:	e8 35 fe ff ff       	call   800727 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008f2:	90                   	nop
  8008f3:	c9                   	leave  
  8008f4:	c3                   	ret    

008008f5 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008f5:	55                   	push   %ebp
  8008f6:	89 e5                	mov    %esp,%ebp
  8008f8:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fe:	8b 00                	mov    (%eax),%eax
  800900:	8d 48 01             	lea    0x1(%eax),%ecx
  800903:	8b 55 0c             	mov    0xc(%ebp),%edx
  800906:	89 0a                	mov    %ecx,(%edx)
  800908:	8b 55 08             	mov    0x8(%ebp),%edx
  80090b:	88 d1                	mov    %dl,%cl
  80090d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800910:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800914:	8b 45 0c             	mov    0xc(%ebp),%eax
  800917:	8b 00                	mov    (%eax),%eax
  800919:	3d ff 00 00 00       	cmp    $0xff,%eax
  80091e:	75 2c                	jne    80094c <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800920:	a0 24 30 80 00       	mov    0x803024,%al
  800925:	0f b6 c0             	movzbl %al,%eax
  800928:	8b 55 0c             	mov    0xc(%ebp),%edx
  80092b:	8b 12                	mov    (%edx),%edx
  80092d:	89 d1                	mov    %edx,%ecx
  80092f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800932:	83 c2 08             	add    $0x8,%edx
  800935:	83 ec 04             	sub    $0x4,%esp
  800938:	50                   	push   %eax
  800939:	51                   	push   %ecx
  80093a:	52                   	push   %edx
  80093b:	e8 df 10 00 00       	call   801a1f <sys_cputs>
  800940:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800943:	8b 45 0c             	mov    0xc(%ebp),%eax
  800946:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80094c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80094f:	8b 40 04             	mov    0x4(%eax),%eax
  800952:	8d 50 01             	lea    0x1(%eax),%edx
  800955:	8b 45 0c             	mov    0xc(%ebp),%eax
  800958:	89 50 04             	mov    %edx,0x4(%eax)
}
  80095b:	90                   	nop
  80095c:	c9                   	leave  
  80095d:	c3                   	ret    

0080095e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80095e:	55                   	push   %ebp
  80095f:	89 e5                	mov    %esp,%ebp
  800961:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800967:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80096e:	00 00 00 
	b.cnt = 0;
  800971:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800978:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80097b:	ff 75 0c             	pushl  0xc(%ebp)
  80097e:	ff 75 08             	pushl  0x8(%ebp)
  800981:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800987:	50                   	push   %eax
  800988:	68 f5 08 80 00       	push   $0x8008f5
  80098d:	e8 11 02 00 00       	call   800ba3 <vprintfmt>
  800992:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800995:	a0 24 30 80 00       	mov    0x803024,%al
  80099a:	0f b6 c0             	movzbl %al,%eax
  80099d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009a3:	83 ec 04             	sub    $0x4,%esp
  8009a6:	50                   	push   %eax
  8009a7:	52                   	push   %edx
  8009a8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009ae:	83 c0 08             	add    $0x8,%eax
  8009b1:	50                   	push   %eax
  8009b2:	e8 68 10 00 00       	call   801a1f <sys_cputs>
  8009b7:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009ba:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8009c1:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009c7:	c9                   	leave  
  8009c8:	c3                   	ret    

008009c9 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009c9:	55                   	push   %ebp
  8009ca:	89 e5                	mov    %esp,%ebp
  8009cc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009cf:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8009d6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009df:	83 ec 08             	sub    $0x8,%esp
  8009e2:	ff 75 f4             	pushl  -0xc(%ebp)
  8009e5:	50                   	push   %eax
  8009e6:	e8 73 ff ff ff       	call   80095e <vcprintf>
  8009eb:	83 c4 10             	add    $0x10,%esp
  8009ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009f4:	c9                   	leave  
  8009f5:	c3                   	ret    

008009f6 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009f6:	55                   	push   %ebp
  8009f7:	89 e5                	mov    %esp,%ebp
  8009f9:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009fc:	e8 2f 12 00 00       	call   801c30 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a01:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a04:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a07:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0a:	83 ec 08             	sub    $0x8,%esp
  800a0d:	ff 75 f4             	pushl  -0xc(%ebp)
  800a10:	50                   	push   %eax
  800a11:	e8 48 ff ff ff       	call   80095e <vcprintf>
  800a16:	83 c4 10             	add    $0x10,%esp
  800a19:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a1c:	e8 29 12 00 00       	call   801c4a <sys_enable_interrupt>
	return cnt;
  800a21:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a24:	c9                   	leave  
  800a25:	c3                   	ret    

00800a26 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a26:	55                   	push   %ebp
  800a27:	89 e5                	mov    %esp,%ebp
  800a29:	53                   	push   %ebx
  800a2a:	83 ec 14             	sub    $0x14,%esp
  800a2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800a30:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a33:	8b 45 14             	mov    0x14(%ebp),%eax
  800a36:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a39:	8b 45 18             	mov    0x18(%ebp),%eax
  800a3c:	ba 00 00 00 00       	mov    $0x0,%edx
  800a41:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a44:	77 55                	ja     800a9b <printnum+0x75>
  800a46:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a49:	72 05                	jb     800a50 <printnum+0x2a>
  800a4b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a4e:	77 4b                	ja     800a9b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a50:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a53:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a56:	8b 45 18             	mov    0x18(%ebp),%eax
  800a59:	ba 00 00 00 00       	mov    $0x0,%edx
  800a5e:	52                   	push   %edx
  800a5f:	50                   	push   %eax
  800a60:	ff 75 f4             	pushl  -0xc(%ebp)
  800a63:	ff 75 f0             	pushl  -0x10(%ebp)
  800a66:	e8 9d 16 00 00       	call   802108 <__udivdi3>
  800a6b:	83 c4 10             	add    $0x10,%esp
  800a6e:	83 ec 04             	sub    $0x4,%esp
  800a71:	ff 75 20             	pushl  0x20(%ebp)
  800a74:	53                   	push   %ebx
  800a75:	ff 75 18             	pushl  0x18(%ebp)
  800a78:	52                   	push   %edx
  800a79:	50                   	push   %eax
  800a7a:	ff 75 0c             	pushl  0xc(%ebp)
  800a7d:	ff 75 08             	pushl  0x8(%ebp)
  800a80:	e8 a1 ff ff ff       	call   800a26 <printnum>
  800a85:	83 c4 20             	add    $0x20,%esp
  800a88:	eb 1a                	jmp    800aa4 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a8a:	83 ec 08             	sub    $0x8,%esp
  800a8d:	ff 75 0c             	pushl  0xc(%ebp)
  800a90:	ff 75 20             	pushl  0x20(%ebp)
  800a93:	8b 45 08             	mov    0x8(%ebp),%eax
  800a96:	ff d0                	call   *%eax
  800a98:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a9b:	ff 4d 1c             	decl   0x1c(%ebp)
  800a9e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800aa2:	7f e6                	jg     800a8a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800aa4:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800aa7:	bb 00 00 00 00       	mov    $0x0,%ebx
  800aac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aaf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ab2:	53                   	push   %ebx
  800ab3:	51                   	push   %ecx
  800ab4:	52                   	push   %edx
  800ab5:	50                   	push   %eax
  800ab6:	e8 5d 17 00 00       	call   802218 <__umoddi3>
  800abb:	83 c4 10             	add    $0x10,%esp
  800abe:	05 d4 28 80 00       	add    $0x8028d4,%eax
  800ac3:	8a 00                	mov    (%eax),%al
  800ac5:	0f be c0             	movsbl %al,%eax
  800ac8:	83 ec 08             	sub    $0x8,%esp
  800acb:	ff 75 0c             	pushl  0xc(%ebp)
  800ace:	50                   	push   %eax
  800acf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad2:	ff d0                	call   *%eax
  800ad4:	83 c4 10             	add    $0x10,%esp
}
  800ad7:	90                   	nop
  800ad8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800adb:	c9                   	leave  
  800adc:	c3                   	ret    

00800add <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800add:	55                   	push   %ebp
  800ade:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ae0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ae4:	7e 1c                	jle    800b02 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae9:	8b 00                	mov    (%eax),%eax
  800aeb:	8d 50 08             	lea    0x8(%eax),%edx
  800aee:	8b 45 08             	mov    0x8(%ebp),%eax
  800af1:	89 10                	mov    %edx,(%eax)
  800af3:	8b 45 08             	mov    0x8(%ebp),%eax
  800af6:	8b 00                	mov    (%eax),%eax
  800af8:	83 e8 08             	sub    $0x8,%eax
  800afb:	8b 50 04             	mov    0x4(%eax),%edx
  800afe:	8b 00                	mov    (%eax),%eax
  800b00:	eb 40                	jmp    800b42 <getuint+0x65>
	else if (lflag)
  800b02:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b06:	74 1e                	je     800b26 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b08:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0b:	8b 00                	mov    (%eax),%eax
  800b0d:	8d 50 04             	lea    0x4(%eax),%edx
  800b10:	8b 45 08             	mov    0x8(%ebp),%eax
  800b13:	89 10                	mov    %edx,(%eax)
  800b15:	8b 45 08             	mov    0x8(%ebp),%eax
  800b18:	8b 00                	mov    (%eax),%eax
  800b1a:	83 e8 04             	sub    $0x4,%eax
  800b1d:	8b 00                	mov    (%eax),%eax
  800b1f:	ba 00 00 00 00       	mov    $0x0,%edx
  800b24:	eb 1c                	jmp    800b42 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
  800b29:	8b 00                	mov    (%eax),%eax
  800b2b:	8d 50 04             	lea    0x4(%eax),%edx
  800b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b31:	89 10                	mov    %edx,(%eax)
  800b33:	8b 45 08             	mov    0x8(%ebp),%eax
  800b36:	8b 00                	mov    (%eax),%eax
  800b38:	83 e8 04             	sub    $0x4,%eax
  800b3b:	8b 00                	mov    (%eax),%eax
  800b3d:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b42:	5d                   	pop    %ebp
  800b43:	c3                   	ret    

00800b44 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b44:	55                   	push   %ebp
  800b45:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b47:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b4b:	7e 1c                	jle    800b69 <getint+0x25>
		return va_arg(*ap, long long);
  800b4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b50:	8b 00                	mov    (%eax),%eax
  800b52:	8d 50 08             	lea    0x8(%eax),%edx
  800b55:	8b 45 08             	mov    0x8(%ebp),%eax
  800b58:	89 10                	mov    %edx,(%eax)
  800b5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5d:	8b 00                	mov    (%eax),%eax
  800b5f:	83 e8 08             	sub    $0x8,%eax
  800b62:	8b 50 04             	mov    0x4(%eax),%edx
  800b65:	8b 00                	mov    (%eax),%eax
  800b67:	eb 38                	jmp    800ba1 <getint+0x5d>
	else if (lflag)
  800b69:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b6d:	74 1a                	je     800b89 <getint+0x45>
		return va_arg(*ap, long);
  800b6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b72:	8b 00                	mov    (%eax),%eax
  800b74:	8d 50 04             	lea    0x4(%eax),%edx
  800b77:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7a:	89 10                	mov    %edx,(%eax)
  800b7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7f:	8b 00                	mov    (%eax),%eax
  800b81:	83 e8 04             	sub    $0x4,%eax
  800b84:	8b 00                	mov    (%eax),%eax
  800b86:	99                   	cltd   
  800b87:	eb 18                	jmp    800ba1 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b89:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8c:	8b 00                	mov    (%eax),%eax
  800b8e:	8d 50 04             	lea    0x4(%eax),%edx
  800b91:	8b 45 08             	mov    0x8(%ebp),%eax
  800b94:	89 10                	mov    %edx,(%eax)
  800b96:	8b 45 08             	mov    0x8(%ebp),%eax
  800b99:	8b 00                	mov    (%eax),%eax
  800b9b:	83 e8 04             	sub    $0x4,%eax
  800b9e:	8b 00                	mov    (%eax),%eax
  800ba0:	99                   	cltd   
}
  800ba1:	5d                   	pop    %ebp
  800ba2:	c3                   	ret    

00800ba3 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800ba3:	55                   	push   %ebp
  800ba4:	89 e5                	mov    %esp,%ebp
  800ba6:	56                   	push   %esi
  800ba7:	53                   	push   %ebx
  800ba8:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bab:	eb 17                	jmp    800bc4 <vprintfmt+0x21>
			if (ch == '\0')
  800bad:	85 db                	test   %ebx,%ebx
  800baf:	0f 84 af 03 00 00    	je     800f64 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bb5:	83 ec 08             	sub    $0x8,%esp
  800bb8:	ff 75 0c             	pushl  0xc(%ebp)
  800bbb:	53                   	push   %ebx
  800bbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbf:	ff d0                	call   *%eax
  800bc1:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bc4:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc7:	8d 50 01             	lea    0x1(%eax),%edx
  800bca:	89 55 10             	mov    %edx,0x10(%ebp)
  800bcd:	8a 00                	mov    (%eax),%al
  800bcf:	0f b6 d8             	movzbl %al,%ebx
  800bd2:	83 fb 25             	cmp    $0x25,%ebx
  800bd5:	75 d6                	jne    800bad <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bd7:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bdb:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800be2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800be9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bf0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bf7:	8b 45 10             	mov    0x10(%ebp),%eax
  800bfa:	8d 50 01             	lea    0x1(%eax),%edx
  800bfd:	89 55 10             	mov    %edx,0x10(%ebp)
  800c00:	8a 00                	mov    (%eax),%al
  800c02:	0f b6 d8             	movzbl %al,%ebx
  800c05:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c08:	83 f8 55             	cmp    $0x55,%eax
  800c0b:	0f 87 2b 03 00 00    	ja     800f3c <vprintfmt+0x399>
  800c11:	8b 04 85 f8 28 80 00 	mov    0x8028f8(,%eax,4),%eax
  800c18:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c1a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c1e:	eb d7                	jmp    800bf7 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c20:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c24:	eb d1                	jmp    800bf7 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c26:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c2d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c30:	89 d0                	mov    %edx,%eax
  800c32:	c1 e0 02             	shl    $0x2,%eax
  800c35:	01 d0                	add    %edx,%eax
  800c37:	01 c0                	add    %eax,%eax
  800c39:	01 d8                	add    %ebx,%eax
  800c3b:	83 e8 30             	sub    $0x30,%eax
  800c3e:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c41:	8b 45 10             	mov    0x10(%ebp),%eax
  800c44:	8a 00                	mov    (%eax),%al
  800c46:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c49:	83 fb 2f             	cmp    $0x2f,%ebx
  800c4c:	7e 3e                	jle    800c8c <vprintfmt+0xe9>
  800c4e:	83 fb 39             	cmp    $0x39,%ebx
  800c51:	7f 39                	jg     800c8c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c53:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c56:	eb d5                	jmp    800c2d <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c58:	8b 45 14             	mov    0x14(%ebp),%eax
  800c5b:	83 c0 04             	add    $0x4,%eax
  800c5e:	89 45 14             	mov    %eax,0x14(%ebp)
  800c61:	8b 45 14             	mov    0x14(%ebp),%eax
  800c64:	83 e8 04             	sub    $0x4,%eax
  800c67:	8b 00                	mov    (%eax),%eax
  800c69:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c6c:	eb 1f                	jmp    800c8d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c6e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c72:	79 83                	jns    800bf7 <vprintfmt+0x54>
				width = 0;
  800c74:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c7b:	e9 77 ff ff ff       	jmp    800bf7 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c80:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c87:	e9 6b ff ff ff       	jmp    800bf7 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c8c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c8d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c91:	0f 89 60 ff ff ff    	jns    800bf7 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c97:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c9a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c9d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800ca4:	e9 4e ff ff ff       	jmp    800bf7 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ca9:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800cac:	e9 46 ff ff ff       	jmp    800bf7 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cb1:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb4:	83 c0 04             	add    $0x4,%eax
  800cb7:	89 45 14             	mov    %eax,0x14(%ebp)
  800cba:	8b 45 14             	mov    0x14(%ebp),%eax
  800cbd:	83 e8 04             	sub    $0x4,%eax
  800cc0:	8b 00                	mov    (%eax),%eax
  800cc2:	83 ec 08             	sub    $0x8,%esp
  800cc5:	ff 75 0c             	pushl  0xc(%ebp)
  800cc8:	50                   	push   %eax
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	ff d0                	call   *%eax
  800cce:	83 c4 10             	add    $0x10,%esp
			break;
  800cd1:	e9 89 02 00 00       	jmp    800f5f <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cd6:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd9:	83 c0 04             	add    $0x4,%eax
  800cdc:	89 45 14             	mov    %eax,0x14(%ebp)
  800cdf:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce2:	83 e8 04             	sub    $0x4,%eax
  800ce5:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ce7:	85 db                	test   %ebx,%ebx
  800ce9:	79 02                	jns    800ced <vprintfmt+0x14a>
				err = -err;
  800ceb:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ced:	83 fb 64             	cmp    $0x64,%ebx
  800cf0:	7f 0b                	jg     800cfd <vprintfmt+0x15a>
  800cf2:	8b 34 9d 40 27 80 00 	mov    0x802740(,%ebx,4),%esi
  800cf9:	85 f6                	test   %esi,%esi
  800cfb:	75 19                	jne    800d16 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cfd:	53                   	push   %ebx
  800cfe:	68 e5 28 80 00       	push   $0x8028e5
  800d03:	ff 75 0c             	pushl  0xc(%ebp)
  800d06:	ff 75 08             	pushl  0x8(%ebp)
  800d09:	e8 5e 02 00 00       	call   800f6c <printfmt>
  800d0e:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d11:	e9 49 02 00 00       	jmp    800f5f <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d16:	56                   	push   %esi
  800d17:	68 ee 28 80 00       	push   $0x8028ee
  800d1c:	ff 75 0c             	pushl  0xc(%ebp)
  800d1f:	ff 75 08             	pushl  0x8(%ebp)
  800d22:	e8 45 02 00 00       	call   800f6c <printfmt>
  800d27:	83 c4 10             	add    $0x10,%esp
			break;
  800d2a:	e9 30 02 00 00       	jmp    800f5f <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d2f:	8b 45 14             	mov    0x14(%ebp),%eax
  800d32:	83 c0 04             	add    $0x4,%eax
  800d35:	89 45 14             	mov    %eax,0x14(%ebp)
  800d38:	8b 45 14             	mov    0x14(%ebp),%eax
  800d3b:	83 e8 04             	sub    $0x4,%eax
  800d3e:	8b 30                	mov    (%eax),%esi
  800d40:	85 f6                	test   %esi,%esi
  800d42:	75 05                	jne    800d49 <vprintfmt+0x1a6>
				p = "(null)";
  800d44:	be f1 28 80 00       	mov    $0x8028f1,%esi
			if (width > 0 && padc != '-')
  800d49:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d4d:	7e 6d                	jle    800dbc <vprintfmt+0x219>
  800d4f:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d53:	74 67                	je     800dbc <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d55:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d58:	83 ec 08             	sub    $0x8,%esp
  800d5b:	50                   	push   %eax
  800d5c:	56                   	push   %esi
  800d5d:	e8 0c 03 00 00       	call   80106e <strnlen>
  800d62:	83 c4 10             	add    $0x10,%esp
  800d65:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d68:	eb 16                	jmp    800d80 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d6a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d6e:	83 ec 08             	sub    $0x8,%esp
  800d71:	ff 75 0c             	pushl  0xc(%ebp)
  800d74:	50                   	push   %eax
  800d75:	8b 45 08             	mov    0x8(%ebp),%eax
  800d78:	ff d0                	call   *%eax
  800d7a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d7d:	ff 4d e4             	decl   -0x1c(%ebp)
  800d80:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d84:	7f e4                	jg     800d6a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d86:	eb 34                	jmp    800dbc <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d88:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d8c:	74 1c                	je     800daa <vprintfmt+0x207>
  800d8e:	83 fb 1f             	cmp    $0x1f,%ebx
  800d91:	7e 05                	jle    800d98 <vprintfmt+0x1f5>
  800d93:	83 fb 7e             	cmp    $0x7e,%ebx
  800d96:	7e 12                	jle    800daa <vprintfmt+0x207>
					putch('?', putdat);
  800d98:	83 ec 08             	sub    $0x8,%esp
  800d9b:	ff 75 0c             	pushl  0xc(%ebp)
  800d9e:	6a 3f                	push   $0x3f
  800da0:	8b 45 08             	mov    0x8(%ebp),%eax
  800da3:	ff d0                	call   *%eax
  800da5:	83 c4 10             	add    $0x10,%esp
  800da8:	eb 0f                	jmp    800db9 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800daa:	83 ec 08             	sub    $0x8,%esp
  800dad:	ff 75 0c             	pushl  0xc(%ebp)
  800db0:	53                   	push   %ebx
  800db1:	8b 45 08             	mov    0x8(%ebp),%eax
  800db4:	ff d0                	call   *%eax
  800db6:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800db9:	ff 4d e4             	decl   -0x1c(%ebp)
  800dbc:	89 f0                	mov    %esi,%eax
  800dbe:	8d 70 01             	lea    0x1(%eax),%esi
  800dc1:	8a 00                	mov    (%eax),%al
  800dc3:	0f be d8             	movsbl %al,%ebx
  800dc6:	85 db                	test   %ebx,%ebx
  800dc8:	74 24                	je     800dee <vprintfmt+0x24b>
  800dca:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dce:	78 b8                	js     800d88 <vprintfmt+0x1e5>
  800dd0:	ff 4d e0             	decl   -0x20(%ebp)
  800dd3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dd7:	79 af                	jns    800d88 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dd9:	eb 13                	jmp    800dee <vprintfmt+0x24b>
				putch(' ', putdat);
  800ddb:	83 ec 08             	sub    $0x8,%esp
  800dde:	ff 75 0c             	pushl  0xc(%ebp)
  800de1:	6a 20                	push   $0x20
  800de3:	8b 45 08             	mov    0x8(%ebp),%eax
  800de6:	ff d0                	call   *%eax
  800de8:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800deb:	ff 4d e4             	decl   -0x1c(%ebp)
  800dee:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800df2:	7f e7                	jg     800ddb <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800df4:	e9 66 01 00 00       	jmp    800f5f <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800df9:	83 ec 08             	sub    $0x8,%esp
  800dfc:	ff 75 e8             	pushl  -0x18(%ebp)
  800dff:	8d 45 14             	lea    0x14(%ebp),%eax
  800e02:	50                   	push   %eax
  800e03:	e8 3c fd ff ff       	call   800b44 <getint>
  800e08:	83 c4 10             	add    $0x10,%esp
  800e0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e0e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e11:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e14:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e17:	85 d2                	test   %edx,%edx
  800e19:	79 23                	jns    800e3e <vprintfmt+0x29b>
				putch('-', putdat);
  800e1b:	83 ec 08             	sub    $0x8,%esp
  800e1e:	ff 75 0c             	pushl  0xc(%ebp)
  800e21:	6a 2d                	push   $0x2d
  800e23:	8b 45 08             	mov    0x8(%ebp),%eax
  800e26:	ff d0                	call   *%eax
  800e28:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e2e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e31:	f7 d8                	neg    %eax
  800e33:	83 d2 00             	adc    $0x0,%edx
  800e36:	f7 da                	neg    %edx
  800e38:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e3b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e3e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e45:	e9 bc 00 00 00       	jmp    800f06 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e4a:	83 ec 08             	sub    $0x8,%esp
  800e4d:	ff 75 e8             	pushl  -0x18(%ebp)
  800e50:	8d 45 14             	lea    0x14(%ebp),%eax
  800e53:	50                   	push   %eax
  800e54:	e8 84 fc ff ff       	call   800add <getuint>
  800e59:	83 c4 10             	add    $0x10,%esp
  800e5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e5f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e62:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e69:	e9 98 00 00 00       	jmp    800f06 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e6e:	83 ec 08             	sub    $0x8,%esp
  800e71:	ff 75 0c             	pushl  0xc(%ebp)
  800e74:	6a 58                	push   $0x58
  800e76:	8b 45 08             	mov    0x8(%ebp),%eax
  800e79:	ff d0                	call   *%eax
  800e7b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e7e:	83 ec 08             	sub    $0x8,%esp
  800e81:	ff 75 0c             	pushl  0xc(%ebp)
  800e84:	6a 58                	push   $0x58
  800e86:	8b 45 08             	mov    0x8(%ebp),%eax
  800e89:	ff d0                	call   *%eax
  800e8b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e8e:	83 ec 08             	sub    $0x8,%esp
  800e91:	ff 75 0c             	pushl  0xc(%ebp)
  800e94:	6a 58                	push   $0x58
  800e96:	8b 45 08             	mov    0x8(%ebp),%eax
  800e99:	ff d0                	call   *%eax
  800e9b:	83 c4 10             	add    $0x10,%esp
			break;
  800e9e:	e9 bc 00 00 00       	jmp    800f5f <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ea3:	83 ec 08             	sub    $0x8,%esp
  800ea6:	ff 75 0c             	pushl  0xc(%ebp)
  800ea9:	6a 30                	push   $0x30
  800eab:	8b 45 08             	mov    0x8(%ebp),%eax
  800eae:	ff d0                	call   *%eax
  800eb0:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800eb3:	83 ec 08             	sub    $0x8,%esp
  800eb6:	ff 75 0c             	pushl  0xc(%ebp)
  800eb9:	6a 78                	push   $0x78
  800ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebe:	ff d0                	call   *%eax
  800ec0:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ec3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ec6:	83 c0 04             	add    $0x4,%eax
  800ec9:	89 45 14             	mov    %eax,0x14(%ebp)
  800ecc:	8b 45 14             	mov    0x14(%ebp),%eax
  800ecf:	83 e8 04             	sub    $0x4,%eax
  800ed2:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ed4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ed7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ede:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ee5:	eb 1f                	jmp    800f06 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ee7:	83 ec 08             	sub    $0x8,%esp
  800eea:	ff 75 e8             	pushl  -0x18(%ebp)
  800eed:	8d 45 14             	lea    0x14(%ebp),%eax
  800ef0:	50                   	push   %eax
  800ef1:	e8 e7 fb ff ff       	call   800add <getuint>
  800ef6:	83 c4 10             	add    $0x10,%esp
  800ef9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800efc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800eff:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f06:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f0a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f0d:	83 ec 04             	sub    $0x4,%esp
  800f10:	52                   	push   %edx
  800f11:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f14:	50                   	push   %eax
  800f15:	ff 75 f4             	pushl  -0xc(%ebp)
  800f18:	ff 75 f0             	pushl  -0x10(%ebp)
  800f1b:	ff 75 0c             	pushl  0xc(%ebp)
  800f1e:	ff 75 08             	pushl  0x8(%ebp)
  800f21:	e8 00 fb ff ff       	call   800a26 <printnum>
  800f26:	83 c4 20             	add    $0x20,%esp
			break;
  800f29:	eb 34                	jmp    800f5f <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f2b:	83 ec 08             	sub    $0x8,%esp
  800f2e:	ff 75 0c             	pushl  0xc(%ebp)
  800f31:	53                   	push   %ebx
  800f32:	8b 45 08             	mov    0x8(%ebp),%eax
  800f35:	ff d0                	call   *%eax
  800f37:	83 c4 10             	add    $0x10,%esp
			break;
  800f3a:	eb 23                	jmp    800f5f <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f3c:	83 ec 08             	sub    $0x8,%esp
  800f3f:	ff 75 0c             	pushl  0xc(%ebp)
  800f42:	6a 25                	push   $0x25
  800f44:	8b 45 08             	mov    0x8(%ebp),%eax
  800f47:	ff d0                	call   *%eax
  800f49:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f4c:	ff 4d 10             	decl   0x10(%ebp)
  800f4f:	eb 03                	jmp    800f54 <vprintfmt+0x3b1>
  800f51:	ff 4d 10             	decl   0x10(%ebp)
  800f54:	8b 45 10             	mov    0x10(%ebp),%eax
  800f57:	48                   	dec    %eax
  800f58:	8a 00                	mov    (%eax),%al
  800f5a:	3c 25                	cmp    $0x25,%al
  800f5c:	75 f3                	jne    800f51 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f5e:	90                   	nop
		}
	}
  800f5f:	e9 47 fc ff ff       	jmp    800bab <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f64:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f65:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f68:	5b                   	pop    %ebx
  800f69:	5e                   	pop    %esi
  800f6a:	5d                   	pop    %ebp
  800f6b:	c3                   	ret    

00800f6c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f6c:	55                   	push   %ebp
  800f6d:	89 e5                	mov    %esp,%ebp
  800f6f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f72:	8d 45 10             	lea    0x10(%ebp),%eax
  800f75:	83 c0 04             	add    $0x4,%eax
  800f78:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f7b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7e:	ff 75 f4             	pushl  -0xc(%ebp)
  800f81:	50                   	push   %eax
  800f82:	ff 75 0c             	pushl  0xc(%ebp)
  800f85:	ff 75 08             	pushl  0x8(%ebp)
  800f88:	e8 16 fc ff ff       	call   800ba3 <vprintfmt>
  800f8d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f90:	90                   	nop
  800f91:	c9                   	leave  
  800f92:	c3                   	ret    

00800f93 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f93:	55                   	push   %ebp
  800f94:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f99:	8b 40 08             	mov    0x8(%eax),%eax
  800f9c:	8d 50 01             	lea    0x1(%eax),%edx
  800f9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa2:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800fa5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa8:	8b 10                	mov    (%eax),%edx
  800faa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fad:	8b 40 04             	mov    0x4(%eax),%eax
  800fb0:	39 c2                	cmp    %eax,%edx
  800fb2:	73 12                	jae    800fc6 <sprintputch+0x33>
		*b->buf++ = ch;
  800fb4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb7:	8b 00                	mov    (%eax),%eax
  800fb9:	8d 48 01             	lea    0x1(%eax),%ecx
  800fbc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fbf:	89 0a                	mov    %ecx,(%edx)
  800fc1:	8b 55 08             	mov    0x8(%ebp),%edx
  800fc4:	88 10                	mov    %dl,(%eax)
}
  800fc6:	90                   	nop
  800fc7:	5d                   	pop    %ebp
  800fc8:	c3                   	ret    

00800fc9 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fc9:	55                   	push   %ebp
  800fca:	89 e5                	mov    %esp,%ebp
  800fcc:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fd5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fde:	01 d0                	add    %edx,%eax
  800fe0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fe3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fea:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fee:	74 06                	je     800ff6 <vsnprintf+0x2d>
  800ff0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ff4:	7f 07                	jg     800ffd <vsnprintf+0x34>
		return -E_INVAL;
  800ff6:	b8 03 00 00 00       	mov    $0x3,%eax
  800ffb:	eb 20                	jmp    80101d <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ffd:	ff 75 14             	pushl  0x14(%ebp)
  801000:	ff 75 10             	pushl  0x10(%ebp)
  801003:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801006:	50                   	push   %eax
  801007:	68 93 0f 80 00       	push   $0x800f93
  80100c:	e8 92 fb ff ff       	call   800ba3 <vprintfmt>
  801011:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801014:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801017:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80101a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80101d:	c9                   	leave  
  80101e:	c3                   	ret    

0080101f <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80101f:	55                   	push   %ebp
  801020:	89 e5                	mov    %esp,%ebp
  801022:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801025:	8d 45 10             	lea    0x10(%ebp),%eax
  801028:	83 c0 04             	add    $0x4,%eax
  80102b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80102e:	8b 45 10             	mov    0x10(%ebp),%eax
  801031:	ff 75 f4             	pushl  -0xc(%ebp)
  801034:	50                   	push   %eax
  801035:	ff 75 0c             	pushl  0xc(%ebp)
  801038:	ff 75 08             	pushl  0x8(%ebp)
  80103b:	e8 89 ff ff ff       	call   800fc9 <vsnprintf>
  801040:	83 c4 10             	add    $0x10,%esp
  801043:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801046:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801049:	c9                   	leave  
  80104a:	c3                   	ret    

0080104b <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80104b:	55                   	push   %ebp
  80104c:	89 e5                	mov    %esp,%ebp
  80104e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801051:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801058:	eb 06                	jmp    801060 <strlen+0x15>
		n++;
  80105a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80105d:	ff 45 08             	incl   0x8(%ebp)
  801060:	8b 45 08             	mov    0x8(%ebp),%eax
  801063:	8a 00                	mov    (%eax),%al
  801065:	84 c0                	test   %al,%al
  801067:	75 f1                	jne    80105a <strlen+0xf>
		n++;
	return n;
  801069:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80106c:	c9                   	leave  
  80106d:	c3                   	ret    

0080106e <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80106e:	55                   	push   %ebp
  80106f:	89 e5                	mov    %esp,%ebp
  801071:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801074:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80107b:	eb 09                	jmp    801086 <strnlen+0x18>
		n++;
  80107d:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801080:	ff 45 08             	incl   0x8(%ebp)
  801083:	ff 4d 0c             	decl   0xc(%ebp)
  801086:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80108a:	74 09                	je     801095 <strnlen+0x27>
  80108c:	8b 45 08             	mov    0x8(%ebp),%eax
  80108f:	8a 00                	mov    (%eax),%al
  801091:	84 c0                	test   %al,%al
  801093:	75 e8                	jne    80107d <strnlen+0xf>
		n++;
	return n;
  801095:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801098:	c9                   	leave  
  801099:	c3                   	ret    

0080109a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80109a:	55                   	push   %ebp
  80109b:	89 e5                	mov    %esp,%ebp
  80109d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8010a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8010a6:	90                   	nop
  8010a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010aa:	8d 50 01             	lea    0x1(%eax),%edx
  8010ad:	89 55 08             	mov    %edx,0x8(%ebp)
  8010b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010b3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010b6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010b9:	8a 12                	mov    (%edx),%dl
  8010bb:	88 10                	mov    %dl,(%eax)
  8010bd:	8a 00                	mov    (%eax),%al
  8010bf:	84 c0                	test   %al,%al
  8010c1:	75 e4                	jne    8010a7 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8010c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010c6:	c9                   	leave  
  8010c7:	c3                   	ret    

008010c8 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8010c8:	55                   	push   %ebp
  8010c9:	89 e5                	mov    %esp,%ebp
  8010cb:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8010ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8010d4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010db:	eb 1f                	jmp    8010fc <strncpy+0x34>
		*dst++ = *src;
  8010dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e0:	8d 50 01             	lea    0x1(%eax),%edx
  8010e3:	89 55 08             	mov    %edx,0x8(%ebp)
  8010e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010e9:	8a 12                	mov    (%edx),%dl
  8010eb:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f0:	8a 00                	mov    (%eax),%al
  8010f2:	84 c0                	test   %al,%al
  8010f4:	74 03                	je     8010f9 <strncpy+0x31>
			src++;
  8010f6:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010f9:	ff 45 fc             	incl   -0x4(%ebp)
  8010fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ff:	3b 45 10             	cmp    0x10(%ebp),%eax
  801102:	72 d9                	jb     8010dd <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801104:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801107:	c9                   	leave  
  801108:	c3                   	ret    

00801109 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801109:	55                   	push   %ebp
  80110a:	89 e5                	mov    %esp,%ebp
  80110c:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80110f:	8b 45 08             	mov    0x8(%ebp),%eax
  801112:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801115:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801119:	74 30                	je     80114b <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80111b:	eb 16                	jmp    801133 <strlcpy+0x2a>
			*dst++ = *src++;
  80111d:	8b 45 08             	mov    0x8(%ebp),%eax
  801120:	8d 50 01             	lea    0x1(%eax),%edx
  801123:	89 55 08             	mov    %edx,0x8(%ebp)
  801126:	8b 55 0c             	mov    0xc(%ebp),%edx
  801129:	8d 4a 01             	lea    0x1(%edx),%ecx
  80112c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80112f:	8a 12                	mov    (%edx),%dl
  801131:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801133:	ff 4d 10             	decl   0x10(%ebp)
  801136:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80113a:	74 09                	je     801145 <strlcpy+0x3c>
  80113c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113f:	8a 00                	mov    (%eax),%al
  801141:	84 c0                	test   %al,%al
  801143:	75 d8                	jne    80111d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801145:	8b 45 08             	mov    0x8(%ebp),%eax
  801148:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80114b:	8b 55 08             	mov    0x8(%ebp),%edx
  80114e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801151:	29 c2                	sub    %eax,%edx
  801153:	89 d0                	mov    %edx,%eax
}
  801155:	c9                   	leave  
  801156:	c3                   	ret    

00801157 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801157:	55                   	push   %ebp
  801158:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80115a:	eb 06                	jmp    801162 <strcmp+0xb>
		p++, q++;
  80115c:	ff 45 08             	incl   0x8(%ebp)
  80115f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801162:	8b 45 08             	mov    0x8(%ebp),%eax
  801165:	8a 00                	mov    (%eax),%al
  801167:	84 c0                	test   %al,%al
  801169:	74 0e                	je     801179 <strcmp+0x22>
  80116b:	8b 45 08             	mov    0x8(%ebp),%eax
  80116e:	8a 10                	mov    (%eax),%dl
  801170:	8b 45 0c             	mov    0xc(%ebp),%eax
  801173:	8a 00                	mov    (%eax),%al
  801175:	38 c2                	cmp    %al,%dl
  801177:	74 e3                	je     80115c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801179:	8b 45 08             	mov    0x8(%ebp),%eax
  80117c:	8a 00                	mov    (%eax),%al
  80117e:	0f b6 d0             	movzbl %al,%edx
  801181:	8b 45 0c             	mov    0xc(%ebp),%eax
  801184:	8a 00                	mov    (%eax),%al
  801186:	0f b6 c0             	movzbl %al,%eax
  801189:	29 c2                	sub    %eax,%edx
  80118b:	89 d0                	mov    %edx,%eax
}
  80118d:	5d                   	pop    %ebp
  80118e:	c3                   	ret    

0080118f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80118f:	55                   	push   %ebp
  801190:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801192:	eb 09                	jmp    80119d <strncmp+0xe>
		n--, p++, q++;
  801194:	ff 4d 10             	decl   0x10(%ebp)
  801197:	ff 45 08             	incl   0x8(%ebp)
  80119a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80119d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011a1:	74 17                	je     8011ba <strncmp+0x2b>
  8011a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a6:	8a 00                	mov    (%eax),%al
  8011a8:	84 c0                	test   %al,%al
  8011aa:	74 0e                	je     8011ba <strncmp+0x2b>
  8011ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8011af:	8a 10                	mov    (%eax),%dl
  8011b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b4:	8a 00                	mov    (%eax),%al
  8011b6:	38 c2                	cmp    %al,%dl
  8011b8:	74 da                	je     801194 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8011ba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011be:	75 07                	jne    8011c7 <strncmp+0x38>
		return 0;
  8011c0:	b8 00 00 00 00       	mov    $0x0,%eax
  8011c5:	eb 14                	jmp    8011db <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8011c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ca:	8a 00                	mov    (%eax),%al
  8011cc:	0f b6 d0             	movzbl %al,%edx
  8011cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d2:	8a 00                	mov    (%eax),%al
  8011d4:	0f b6 c0             	movzbl %al,%eax
  8011d7:	29 c2                	sub    %eax,%edx
  8011d9:	89 d0                	mov    %edx,%eax
}
  8011db:	5d                   	pop    %ebp
  8011dc:	c3                   	ret    

008011dd <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011dd:	55                   	push   %ebp
  8011de:	89 e5                	mov    %esp,%ebp
  8011e0:	83 ec 04             	sub    $0x4,%esp
  8011e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011e9:	eb 12                	jmp    8011fd <strchr+0x20>
		if (*s == c)
  8011eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ee:	8a 00                	mov    (%eax),%al
  8011f0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011f3:	75 05                	jne    8011fa <strchr+0x1d>
			return (char *) s;
  8011f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f8:	eb 11                	jmp    80120b <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011fa:	ff 45 08             	incl   0x8(%ebp)
  8011fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801200:	8a 00                	mov    (%eax),%al
  801202:	84 c0                	test   %al,%al
  801204:	75 e5                	jne    8011eb <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801206:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80120b:	c9                   	leave  
  80120c:	c3                   	ret    

0080120d <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80120d:	55                   	push   %ebp
  80120e:	89 e5                	mov    %esp,%ebp
  801210:	83 ec 04             	sub    $0x4,%esp
  801213:	8b 45 0c             	mov    0xc(%ebp),%eax
  801216:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801219:	eb 0d                	jmp    801228 <strfind+0x1b>
		if (*s == c)
  80121b:	8b 45 08             	mov    0x8(%ebp),%eax
  80121e:	8a 00                	mov    (%eax),%al
  801220:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801223:	74 0e                	je     801233 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801225:	ff 45 08             	incl   0x8(%ebp)
  801228:	8b 45 08             	mov    0x8(%ebp),%eax
  80122b:	8a 00                	mov    (%eax),%al
  80122d:	84 c0                	test   %al,%al
  80122f:	75 ea                	jne    80121b <strfind+0xe>
  801231:	eb 01                	jmp    801234 <strfind+0x27>
		if (*s == c)
			break;
  801233:	90                   	nop
	return (char *) s;
  801234:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801237:	c9                   	leave  
  801238:	c3                   	ret    

00801239 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801239:	55                   	push   %ebp
  80123a:	89 e5                	mov    %esp,%ebp
  80123c:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80123f:	8b 45 08             	mov    0x8(%ebp),%eax
  801242:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801245:	8b 45 10             	mov    0x10(%ebp),%eax
  801248:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80124b:	eb 0e                	jmp    80125b <memset+0x22>
		*p++ = c;
  80124d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801250:	8d 50 01             	lea    0x1(%eax),%edx
  801253:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801256:	8b 55 0c             	mov    0xc(%ebp),%edx
  801259:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80125b:	ff 4d f8             	decl   -0x8(%ebp)
  80125e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801262:	79 e9                	jns    80124d <memset+0x14>
		*p++ = c;

	return v;
  801264:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801267:	c9                   	leave  
  801268:	c3                   	ret    

00801269 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801269:	55                   	push   %ebp
  80126a:	89 e5                	mov    %esp,%ebp
  80126c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80126f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801272:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801275:	8b 45 08             	mov    0x8(%ebp),%eax
  801278:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80127b:	eb 16                	jmp    801293 <memcpy+0x2a>
		*d++ = *s++;
  80127d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801280:	8d 50 01             	lea    0x1(%eax),%edx
  801283:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801286:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801289:	8d 4a 01             	lea    0x1(%edx),%ecx
  80128c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80128f:	8a 12                	mov    (%edx),%dl
  801291:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801293:	8b 45 10             	mov    0x10(%ebp),%eax
  801296:	8d 50 ff             	lea    -0x1(%eax),%edx
  801299:	89 55 10             	mov    %edx,0x10(%ebp)
  80129c:	85 c0                	test   %eax,%eax
  80129e:	75 dd                	jne    80127d <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8012a0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012a3:	c9                   	leave  
  8012a4:	c3                   	ret    

008012a5 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8012a5:	55                   	push   %ebp
  8012a6:	89 e5                	mov    %esp,%ebp
  8012a8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8012ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8012b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8012b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012bd:	73 50                	jae    80130f <memmove+0x6a>
  8012bf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c5:	01 d0                	add    %edx,%eax
  8012c7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012ca:	76 43                	jbe    80130f <memmove+0x6a>
		s += n;
  8012cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8012cf:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8012d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d5:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8012d8:	eb 10                	jmp    8012ea <memmove+0x45>
			*--d = *--s;
  8012da:	ff 4d f8             	decl   -0x8(%ebp)
  8012dd:	ff 4d fc             	decl   -0x4(%ebp)
  8012e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012e3:	8a 10                	mov    (%eax),%dl
  8012e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012e8:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ed:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012f0:	89 55 10             	mov    %edx,0x10(%ebp)
  8012f3:	85 c0                	test   %eax,%eax
  8012f5:	75 e3                	jne    8012da <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012f7:	eb 23                	jmp    80131c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012fc:	8d 50 01             	lea    0x1(%eax),%edx
  8012ff:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801302:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801305:	8d 4a 01             	lea    0x1(%edx),%ecx
  801308:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80130b:	8a 12                	mov    (%edx),%dl
  80130d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80130f:	8b 45 10             	mov    0x10(%ebp),%eax
  801312:	8d 50 ff             	lea    -0x1(%eax),%edx
  801315:	89 55 10             	mov    %edx,0x10(%ebp)
  801318:	85 c0                	test   %eax,%eax
  80131a:	75 dd                	jne    8012f9 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80131c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80131f:	c9                   	leave  
  801320:	c3                   	ret    

00801321 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801321:	55                   	push   %ebp
  801322:	89 e5                	mov    %esp,%ebp
  801324:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801327:	8b 45 08             	mov    0x8(%ebp),%eax
  80132a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80132d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801330:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801333:	eb 2a                	jmp    80135f <memcmp+0x3e>
		if (*s1 != *s2)
  801335:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801338:	8a 10                	mov    (%eax),%dl
  80133a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80133d:	8a 00                	mov    (%eax),%al
  80133f:	38 c2                	cmp    %al,%dl
  801341:	74 16                	je     801359 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801343:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801346:	8a 00                	mov    (%eax),%al
  801348:	0f b6 d0             	movzbl %al,%edx
  80134b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80134e:	8a 00                	mov    (%eax),%al
  801350:	0f b6 c0             	movzbl %al,%eax
  801353:	29 c2                	sub    %eax,%edx
  801355:	89 d0                	mov    %edx,%eax
  801357:	eb 18                	jmp    801371 <memcmp+0x50>
		s1++, s2++;
  801359:	ff 45 fc             	incl   -0x4(%ebp)
  80135c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80135f:	8b 45 10             	mov    0x10(%ebp),%eax
  801362:	8d 50 ff             	lea    -0x1(%eax),%edx
  801365:	89 55 10             	mov    %edx,0x10(%ebp)
  801368:	85 c0                	test   %eax,%eax
  80136a:	75 c9                	jne    801335 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80136c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801371:	c9                   	leave  
  801372:	c3                   	ret    

00801373 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801373:	55                   	push   %ebp
  801374:	89 e5                	mov    %esp,%ebp
  801376:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801379:	8b 55 08             	mov    0x8(%ebp),%edx
  80137c:	8b 45 10             	mov    0x10(%ebp),%eax
  80137f:	01 d0                	add    %edx,%eax
  801381:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801384:	eb 15                	jmp    80139b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801386:	8b 45 08             	mov    0x8(%ebp),%eax
  801389:	8a 00                	mov    (%eax),%al
  80138b:	0f b6 d0             	movzbl %al,%edx
  80138e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801391:	0f b6 c0             	movzbl %al,%eax
  801394:	39 c2                	cmp    %eax,%edx
  801396:	74 0d                	je     8013a5 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801398:	ff 45 08             	incl   0x8(%ebp)
  80139b:	8b 45 08             	mov    0x8(%ebp),%eax
  80139e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8013a1:	72 e3                	jb     801386 <memfind+0x13>
  8013a3:	eb 01                	jmp    8013a6 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8013a5:	90                   	nop
	return (void *) s;
  8013a6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013a9:	c9                   	leave  
  8013aa:	c3                   	ret    

008013ab <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8013ab:	55                   	push   %ebp
  8013ac:	89 e5                	mov    %esp,%ebp
  8013ae:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8013b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8013b8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013bf:	eb 03                	jmp    8013c4 <strtol+0x19>
		s++;
  8013c1:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c7:	8a 00                	mov    (%eax),%al
  8013c9:	3c 20                	cmp    $0x20,%al
  8013cb:	74 f4                	je     8013c1 <strtol+0x16>
  8013cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d0:	8a 00                	mov    (%eax),%al
  8013d2:	3c 09                	cmp    $0x9,%al
  8013d4:	74 eb                	je     8013c1 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8013d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d9:	8a 00                	mov    (%eax),%al
  8013db:	3c 2b                	cmp    $0x2b,%al
  8013dd:	75 05                	jne    8013e4 <strtol+0x39>
		s++;
  8013df:	ff 45 08             	incl   0x8(%ebp)
  8013e2:	eb 13                	jmp    8013f7 <strtol+0x4c>
	else if (*s == '-')
  8013e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e7:	8a 00                	mov    (%eax),%al
  8013e9:	3c 2d                	cmp    $0x2d,%al
  8013eb:	75 0a                	jne    8013f7 <strtol+0x4c>
		s++, neg = 1;
  8013ed:	ff 45 08             	incl   0x8(%ebp)
  8013f0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013f7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013fb:	74 06                	je     801403 <strtol+0x58>
  8013fd:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801401:	75 20                	jne    801423 <strtol+0x78>
  801403:	8b 45 08             	mov    0x8(%ebp),%eax
  801406:	8a 00                	mov    (%eax),%al
  801408:	3c 30                	cmp    $0x30,%al
  80140a:	75 17                	jne    801423 <strtol+0x78>
  80140c:	8b 45 08             	mov    0x8(%ebp),%eax
  80140f:	40                   	inc    %eax
  801410:	8a 00                	mov    (%eax),%al
  801412:	3c 78                	cmp    $0x78,%al
  801414:	75 0d                	jne    801423 <strtol+0x78>
		s += 2, base = 16;
  801416:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80141a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801421:	eb 28                	jmp    80144b <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801423:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801427:	75 15                	jne    80143e <strtol+0x93>
  801429:	8b 45 08             	mov    0x8(%ebp),%eax
  80142c:	8a 00                	mov    (%eax),%al
  80142e:	3c 30                	cmp    $0x30,%al
  801430:	75 0c                	jne    80143e <strtol+0x93>
		s++, base = 8;
  801432:	ff 45 08             	incl   0x8(%ebp)
  801435:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80143c:	eb 0d                	jmp    80144b <strtol+0xa0>
	else if (base == 0)
  80143e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801442:	75 07                	jne    80144b <strtol+0xa0>
		base = 10;
  801444:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80144b:	8b 45 08             	mov    0x8(%ebp),%eax
  80144e:	8a 00                	mov    (%eax),%al
  801450:	3c 2f                	cmp    $0x2f,%al
  801452:	7e 19                	jle    80146d <strtol+0xc2>
  801454:	8b 45 08             	mov    0x8(%ebp),%eax
  801457:	8a 00                	mov    (%eax),%al
  801459:	3c 39                	cmp    $0x39,%al
  80145b:	7f 10                	jg     80146d <strtol+0xc2>
			dig = *s - '0';
  80145d:	8b 45 08             	mov    0x8(%ebp),%eax
  801460:	8a 00                	mov    (%eax),%al
  801462:	0f be c0             	movsbl %al,%eax
  801465:	83 e8 30             	sub    $0x30,%eax
  801468:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80146b:	eb 42                	jmp    8014af <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80146d:	8b 45 08             	mov    0x8(%ebp),%eax
  801470:	8a 00                	mov    (%eax),%al
  801472:	3c 60                	cmp    $0x60,%al
  801474:	7e 19                	jle    80148f <strtol+0xe4>
  801476:	8b 45 08             	mov    0x8(%ebp),%eax
  801479:	8a 00                	mov    (%eax),%al
  80147b:	3c 7a                	cmp    $0x7a,%al
  80147d:	7f 10                	jg     80148f <strtol+0xe4>
			dig = *s - 'a' + 10;
  80147f:	8b 45 08             	mov    0x8(%ebp),%eax
  801482:	8a 00                	mov    (%eax),%al
  801484:	0f be c0             	movsbl %al,%eax
  801487:	83 e8 57             	sub    $0x57,%eax
  80148a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80148d:	eb 20                	jmp    8014af <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80148f:	8b 45 08             	mov    0x8(%ebp),%eax
  801492:	8a 00                	mov    (%eax),%al
  801494:	3c 40                	cmp    $0x40,%al
  801496:	7e 39                	jle    8014d1 <strtol+0x126>
  801498:	8b 45 08             	mov    0x8(%ebp),%eax
  80149b:	8a 00                	mov    (%eax),%al
  80149d:	3c 5a                	cmp    $0x5a,%al
  80149f:	7f 30                	jg     8014d1 <strtol+0x126>
			dig = *s - 'A' + 10;
  8014a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a4:	8a 00                	mov    (%eax),%al
  8014a6:	0f be c0             	movsbl %al,%eax
  8014a9:	83 e8 37             	sub    $0x37,%eax
  8014ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8014af:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014b2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014b5:	7d 19                	jge    8014d0 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8014b7:	ff 45 08             	incl   0x8(%ebp)
  8014ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014bd:	0f af 45 10          	imul   0x10(%ebp),%eax
  8014c1:	89 c2                	mov    %eax,%edx
  8014c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014c6:	01 d0                	add    %edx,%eax
  8014c8:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8014cb:	e9 7b ff ff ff       	jmp    80144b <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8014d0:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8014d1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014d5:	74 08                	je     8014df <strtol+0x134>
		*endptr = (char *) s;
  8014d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014da:	8b 55 08             	mov    0x8(%ebp),%edx
  8014dd:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014df:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014e3:	74 07                	je     8014ec <strtol+0x141>
  8014e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014e8:	f7 d8                	neg    %eax
  8014ea:	eb 03                	jmp    8014ef <strtol+0x144>
  8014ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014ef:	c9                   	leave  
  8014f0:	c3                   	ret    

008014f1 <ltostr>:

void
ltostr(long value, char *str)
{
  8014f1:	55                   	push   %ebp
  8014f2:	89 e5                	mov    %esp,%ebp
  8014f4:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014fe:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801505:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801509:	79 13                	jns    80151e <ltostr+0x2d>
	{
		neg = 1;
  80150b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801512:	8b 45 0c             	mov    0xc(%ebp),%eax
  801515:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801518:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80151b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80151e:	8b 45 08             	mov    0x8(%ebp),%eax
  801521:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801526:	99                   	cltd   
  801527:	f7 f9                	idiv   %ecx
  801529:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80152c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80152f:	8d 50 01             	lea    0x1(%eax),%edx
  801532:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801535:	89 c2                	mov    %eax,%edx
  801537:	8b 45 0c             	mov    0xc(%ebp),%eax
  80153a:	01 d0                	add    %edx,%eax
  80153c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80153f:	83 c2 30             	add    $0x30,%edx
  801542:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801544:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801547:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80154c:	f7 e9                	imul   %ecx
  80154e:	c1 fa 02             	sar    $0x2,%edx
  801551:	89 c8                	mov    %ecx,%eax
  801553:	c1 f8 1f             	sar    $0x1f,%eax
  801556:	29 c2                	sub    %eax,%edx
  801558:	89 d0                	mov    %edx,%eax
  80155a:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80155d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801560:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801565:	f7 e9                	imul   %ecx
  801567:	c1 fa 02             	sar    $0x2,%edx
  80156a:	89 c8                	mov    %ecx,%eax
  80156c:	c1 f8 1f             	sar    $0x1f,%eax
  80156f:	29 c2                	sub    %eax,%edx
  801571:	89 d0                	mov    %edx,%eax
  801573:	c1 e0 02             	shl    $0x2,%eax
  801576:	01 d0                	add    %edx,%eax
  801578:	01 c0                	add    %eax,%eax
  80157a:	29 c1                	sub    %eax,%ecx
  80157c:	89 ca                	mov    %ecx,%edx
  80157e:	85 d2                	test   %edx,%edx
  801580:	75 9c                	jne    80151e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801582:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801589:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80158c:	48                   	dec    %eax
  80158d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801590:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801594:	74 3d                	je     8015d3 <ltostr+0xe2>
		start = 1 ;
  801596:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80159d:	eb 34                	jmp    8015d3 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80159f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a5:	01 d0                	add    %edx,%eax
  8015a7:	8a 00                	mov    (%eax),%al
  8015a9:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8015ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b2:	01 c2                	add    %eax,%edx
  8015b4:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8015b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ba:	01 c8                	add    %ecx,%eax
  8015bc:	8a 00                	mov    (%eax),%al
  8015be:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8015c0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c6:	01 c2                	add    %eax,%edx
  8015c8:	8a 45 eb             	mov    -0x15(%ebp),%al
  8015cb:	88 02                	mov    %al,(%edx)
		start++ ;
  8015cd:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8015d0:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8015d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015d6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015d9:	7c c4                	jl     80159f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015db:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e1:	01 d0                	add    %edx,%eax
  8015e3:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015e6:	90                   	nop
  8015e7:	c9                   	leave  
  8015e8:	c3                   	ret    

008015e9 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015e9:	55                   	push   %ebp
  8015ea:	89 e5                	mov    %esp,%ebp
  8015ec:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015ef:	ff 75 08             	pushl  0x8(%ebp)
  8015f2:	e8 54 fa ff ff       	call   80104b <strlen>
  8015f7:	83 c4 04             	add    $0x4,%esp
  8015fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015fd:	ff 75 0c             	pushl  0xc(%ebp)
  801600:	e8 46 fa ff ff       	call   80104b <strlen>
  801605:	83 c4 04             	add    $0x4,%esp
  801608:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80160b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801612:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801619:	eb 17                	jmp    801632 <strcconcat+0x49>
		final[s] = str1[s] ;
  80161b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80161e:	8b 45 10             	mov    0x10(%ebp),%eax
  801621:	01 c2                	add    %eax,%edx
  801623:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801626:	8b 45 08             	mov    0x8(%ebp),%eax
  801629:	01 c8                	add    %ecx,%eax
  80162b:	8a 00                	mov    (%eax),%al
  80162d:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80162f:	ff 45 fc             	incl   -0x4(%ebp)
  801632:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801635:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801638:	7c e1                	jl     80161b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80163a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801641:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801648:	eb 1f                	jmp    801669 <strcconcat+0x80>
		final[s++] = str2[i] ;
  80164a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80164d:	8d 50 01             	lea    0x1(%eax),%edx
  801650:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801653:	89 c2                	mov    %eax,%edx
  801655:	8b 45 10             	mov    0x10(%ebp),%eax
  801658:	01 c2                	add    %eax,%edx
  80165a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80165d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801660:	01 c8                	add    %ecx,%eax
  801662:	8a 00                	mov    (%eax),%al
  801664:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801666:	ff 45 f8             	incl   -0x8(%ebp)
  801669:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80166c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80166f:	7c d9                	jl     80164a <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801671:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801674:	8b 45 10             	mov    0x10(%ebp),%eax
  801677:	01 d0                	add    %edx,%eax
  801679:	c6 00 00             	movb   $0x0,(%eax)
}
  80167c:	90                   	nop
  80167d:	c9                   	leave  
  80167e:	c3                   	ret    

0080167f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80167f:	55                   	push   %ebp
  801680:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801682:	8b 45 14             	mov    0x14(%ebp),%eax
  801685:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80168b:	8b 45 14             	mov    0x14(%ebp),%eax
  80168e:	8b 00                	mov    (%eax),%eax
  801690:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801697:	8b 45 10             	mov    0x10(%ebp),%eax
  80169a:	01 d0                	add    %edx,%eax
  80169c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016a2:	eb 0c                	jmp    8016b0 <strsplit+0x31>
			*string++ = 0;
  8016a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a7:	8d 50 01             	lea    0x1(%eax),%edx
  8016aa:	89 55 08             	mov    %edx,0x8(%ebp)
  8016ad:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8016b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b3:	8a 00                	mov    (%eax),%al
  8016b5:	84 c0                	test   %al,%al
  8016b7:	74 18                	je     8016d1 <strsplit+0x52>
  8016b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bc:	8a 00                	mov    (%eax),%al
  8016be:	0f be c0             	movsbl %al,%eax
  8016c1:	50                   	push   %eax
  8016c2:	ff 75 0c             	pushl  0xc(%ebp)
  8016c5:	e8 13 fb ff ff       	call   8011dd <strchr>
  8016ca:	83 c4 08             	add    $0x8,%esp
  8016cd:	85 c0                	test   %eax,%eax
  8016cf:	75 d3                	jne    8016a4 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8016d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d4:	8a 00                	mov    (%eax),%al
  8016d6:	84 c0                	test   %al,%al
  8016d8:	74 5a                	je     801734 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8016da:	8b 45 14             	mov    0x14(%ebp),%eax
  8016dd:	8b 00                	mov    (%eax),%eax
  8016df:	83 f8 0f             	cmp    $0xf,%eax
  8016e2:	75 07                	jne    8016eb <strsplit+0x6c>
		{
			return 0;
  8016e4:	b8 00 00 00 00       	mov    $0x0,%eax
  8016e9:	eb 66                	jmp    801751 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8016ee:	8b 00                	mov    (%eax),%eax
  8016f0:	8d 48 01             	lea    0x1(%eax),%ecx
  8016f3:	8b 55 14             	mov    0x14(%ebp),%edx
  8016f6:	89 0a                	mov    %ecx,(%edx)
  8016f8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016ff:	8b 45 10             	mov    0x10(%ebp),%eax
  801702:	01 c2                	add    %eax,%edx
  801704:	8b 45 08             	mov    0x8(%ebp),%eax
  801707:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801709:	eb 03                	jmp    80170e <strsplit+0x8f>
			string++;
  80170b:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80170e:	8b 45 08             	mov    0x8(%ebp),%eax
  801711:	8a 00                	mov    (%eax),%al
  801713:	84 c0                	test   %al,%al
  801715:	74 8b                	je     8016a2 <strsplit+0x23>
  801717:	8b 45 08             	mov    0x8(%ebp),%eax
  80171a:	8a 00                	mov    (%eax),%al
  80171c:	0f be c0             	movsbl %al,%eax
  80171f:	50                   	push   %eax
  801720:	ff 75 0c             	pushl  0xc(%ebp)
  801723:	e8 b5 fa ff ff       	call   8011dd <strchr>
  801728:	83 c4 08             	add    $0x8,%esp
  80172b:	85 c0                	test   %eax,%eax
  80172d:	74 dc                	je     80170b <strsplit+0x8c>
			string++;
	}
  80172f:	e9 6e ff ff ff       	jmp    8016a2 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801734:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801735:	8b 45 14             	mov    0x14(%ebp),%eax
  801738:	8b 00                	mov    (%eax),%eax
  80173a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801741:	8b 45 10             	mov    0x10(%ebp),%eax
  801744:	01 d0                	add    %edx,%eax
  801746:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80174c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801751:	c9                   	leave  
  801752:	c3                   	ret    

00801753 <malloc>:
int changes=0;
int sizeofarray=0;
uint32 addresses[100];
int changed[100];
void* malloc(uint32 size)
{
  801753:	55                   	push   %ebp
  801754:	89 e5                	mov    %esp,%ebp
  801756:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801759:	8b 45 08             	mov    0x8(%ebp),%eax
  80175c:	c1 e8 0c             	shr    $0xc,%eax
  80175f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;
		if(size%PAGE_SIZE!=0)
  801762:	8b 45 08             	mov    0x8(%ebp),%eax
  801765:	25 ff 0f 00 00       	and    $0xfff,%eax
  80176a:	85 c0                	test   %eax,%eax
  80176c:	74 03                	je     801771 <malloc+0x1e>
			num++;
  80176e:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  801771:	a1 04 30 80 00       	mov    0x803004,%eax
  801776:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  80177b:	75 64                	jne    8017e1 <malloc+0x8e>
		{
			sys_allocateMem(USER_HEAP_START,size);
  80177d:	83 ec 08             	sub    $0x8,%esp
  801780:	ff 75 08             	pushl  0x8(%ebp)
  801783:	68 00 00 00 80       	push   $0x80000000
  801788:	e8 3a 04 00 00       	call   801bc7 <sys_allocateMem>
  80178d:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  801790:	a1 04 30 80 00       	mov    0x803004,%eax
  801795:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  801798:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80179b:	c1 e0 0c             	shl    $0xc,%eax
  80179e:	89 c2                	mov    %eax,%edx
  8017a0:	a1 04 30 80 00       	mov    0x803004,%eax
  8017a5:	01 d0                	add    %edx,%eax
  8017a7:	a3 04 30 80 00       	mov    %eax,0x803004
			addresses[sizeofarray]=last_addres;
  8017ac:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017b1:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8017b7:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  8017be:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017c3:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  8017ca:	01 00 00 00 
			sizeofarray++;
  8017ce:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017d3:	40                   	inc    %eax
  8017d4:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  8017d9:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8017dc:	e9 26 01 00 00       	jmp    801907 <malloc+0x1b4>
		}
		else
		{
			if(changes==0)
  8017e1:	a1 28 30 80 00       	mov    0x803028,%eax
  8017e6:	85 c0                	test   %eax,%eax
  8017e8:	75 62                	jne    80184c <malloc+0xf9>
			{
				sys_allocateMem(last_addres,size);
  8017ea:	a1 04 30 80 00       	mov    0x803004,%eax
  8017ef:	83 ec 08             	sub    $0x8,%esp
  8017f2:	ff 75 08             	pushl  0x8(%ebp)
  8017f5:	50                   	push   %eax
  8017f6:	e8 cc 03 00 00       	call   801bc7 <sys_allocateMem>
  8017fb:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  8017fe:	a1 04 30 80 00       	mov    0x803004,%eax
  801803:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801806:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801809:	c1 e0 0c             	shl    $0xc,%eax
  80180c:	89 c2                	mov    %eax,%edx
  80180e:	a1 04 30 80 00       	mov    0x803004,%eax
  801813:	01 d0                	add    %edx,%eax
  801815:	a3 04 30 80 00       	mov    %eax,0x803004
				addresses[sizeofarray]=return_addres;
  80181a:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80181f:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801822:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801829:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80182e:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  801835:	01 00 00 00 
				sizeofarray++;
  801839:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80183e:	40                   	inc    %eax
  80183f:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  801844:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801847:	e9 bb 00 00 00       	jmp    801907 <malloc+0x1b4>
			}
			else{
				int count=0;
  80184c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801853:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  80185a:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801861:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801868:	eb 7c                	jmp    8018e6 <malloc+0x193>
				{
					uint32 *pg=NULL;
  80186a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801871:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801878:	eb 1a                	jmp    801894 <malloc+0x141>
					{
						if(addresses[j]==i)
  80187a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80187d:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801884:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801887:	75 08                	jne    801891 <malloc+0x13e>
						{
							index=j;
  801889:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80188c:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  80188f:	eb 0d                	jmp    80189e <malloc+0x14b>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801891:	ff 45 dc             	incl   -0x24(%ebp)
  801894:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801899:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  80189c:	7c dc                	jl     80187a <malloc+0x127>
							index=j;
							break;
						}
					}

					if(index==-1)
  80189e:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  8018a2:	75 05                	jne    8018a9 <malloc+0x156>
					{
						count++;
  8018a4:	ff 45 f0             	incl   -0x10(%ebp)
  8018a7:	eb 36                	jmp    8018df <malloc+0x18c>
					}
					else
					{
						if(changed[index]==0)
  8018a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8018ac:	8b 04 85 c0 32 80 00 	mov    0x8032c0(,%eax,4),%eax
  8018b3:	85 c0                	test   %eax,%eax
  8018b5:	75 05                	jne    8018bc <malloc+0x169>
						{
							count++;
  8018b7:	ff 45 f0             	incl   -0x10(%ebp)
  8018ba:	eb 23                	jmp    8018df <malloc+0x18c>
						}
						else
						{
							if(count<min&&count>=num)
  8018bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018bf:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8018c2:	7d 14                	jge    8018d8 <malloc+0x185>
  8018c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018c7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018ca:	7c 0c                	jl     8018d8 <malloc+0x185>
							{
								min=count;
  8018cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018cf:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  8018d2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8018d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  8018d8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8018df:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  8018e6:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  8018ed:	0f 86 77 ff ff ff    	jbe    80186a <malloc+0x117>

					}

					}

				sys_allocateMem(min_addresss,size);
  8018f3:	83 ec 08             	sub    $0x8,%esp
  8018f6:	ff 75 08             	pushl  0x8(%ebp)
  8018f9:	ff 75 e4             	pushl  -0x1c(%ebp)
  8018fc:	e8 c6 02 00 00       	call   801bc7 <sys_allocateMem>
  801901:	83 c4 10             	add    $0x10,%esp

				return(void*) min_addresss;
  801904:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801907:	c9                   	leave  
  801908:	c3                   	ret    

00801909 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801909:	55                   	push   %ebp
  80190a:	89 e5                	mov    %esp,%ebp
  80190c:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  80190f:	83 ec 04             	sub    $0x4,%esp
  801912:	68 50 2a 80 00       	push   $0x802a50
  801917:	6a 7b                	push   $0x7b
  801919:	68 73 2a 80 00       	push   $0x802a73
  80191e:	e8 04 ee ff ff       	call   800727 <_panic>

00801923 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801923:	55                   	push   %ebp
  801924:	89 e5                	mov    %esp,%ebp
  801926:	83 ec 18             	sub    $0x18,%esp
  801929:	8b 45 10             	mov    0x10(%ebp),%eax
  80192c:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  80192f:	83 ec 04             	sub    $0x4,%esp
  801932:	68 80 2a 80 00       	push   $0x802a80
  801937:	68 88 00 00 00       	push   $0x88
  80193c:	68 73 2a 80 00       	push   $0x802a73
  801941:	e8 e1 ed ff ff       	call   800727 <_panic>

00801946 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801946:	55                   	push   %ebp
  801947:	89 e5                	mov    %esp,%ebp
  801949:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80194c:	83 ec 04             	sub    $0x4,%esp
  80194f:	68 80 2a 80 00       	push   $0x802a80
  801954:	68 8e 00 00 00       	push   $0x8e
  801959:	68 73 2a 80 00       	push   $0x802a73
  80195e:	e8 c4 ed ff ff       	call   800727 <_panic>

00801963 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801963:	55                   	push   %ebp
  801964:	89 e5                	mov    %esp,%ebp
  801966:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801969:	83 ec 04             	sub    $0x4,%esp
  80196c:	68 80 2a 80 00       	push   $0x802a80
  801971:	68 94 00 00 00       	push   $0x94
  801976:	68 73 2a 80 00       	push   $0x802a73
  80197b:	e8 a7 ed ff ff       	call   800727 <_panic>

00801980 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801980:	55                   	push   %ebp
  801981:	89 e5                	mov    %esp,%ebp
  801983:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801986:	83 ec 04             	sub    $0x4,%esp
  801989:	68 80 2a 80 00       	push   $0x802a80
  80198e:	68 99 00 00 00       	push   $0x99
  801993:	68 73 2a 80 00       	push   $0x802a73
  801998:	e8 8a ed ff ff       	call   800727 <_panic>

0080199d <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  80199d:	55                   	push   %ebp
  80199e:	89 e5                	mov    %esp,%ebp
  8019a0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019a3:	83 ec 04             	sub    $0x4,%esp
  8019a6:	68 80 2a 80 00       	push   $0x802a80
  8019ab:	68 9f 00 00 00       	push   $0x9f
  8019b0:	68 73 2a 80 00       	push   $0x802a73
  8019b5:	e8 6d ed ff ff       	call   800727 <_panic>

008019ba <shrink>:
}
void shrink(uint32 newSize)
{
  8019ba:	55                   	push   %ebp
  8019bb:	89 e5                	mov    %esp,%ebp
  8019bd:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019c0:	83 ec 04             	sub    $0x4,%esp
  8019c3:	68 80 2a 80 00       	push   $0x802a80
  8019c8:	68 a3 00 00 00       	push   $0xa3
  8019cd:	68 73 2a 80 00       	push   $0x802a73
  8019d2:	e8 50 ed ff ff       	call   800727 <_panic>

008019d7 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8019d7:	55                   	push   %ebp
  8019d8:	89 e5                	mov    %esp,%ebp
  8019da:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019dd:	83 ec 04             	sub    $0x4,%esp
  8019e0:	68 80 2a 80 00       	push   $0x802a80
  8019e5:	68 a8 00 00 00       	push   $0xa8
  8019ea:	68 73 2a 80 00       	push   $0x802a73
  8019ef:	e8 33 ed ff ff       	call   800727 <_panic>

008019f4 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8019f4:	55                   	push   %ebp
  8019f5:	89 e5                	mov    %esp,%ebp
  8019f7:	57                   	push   %edi
  8019f8:	56                   	push   %esi
  8019f9:	53                   	push   %ebx
  8019fa:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8019fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801a00:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a03:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a06:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a09:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a0c:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801a0f:	cd 30                	int    $0x30
  801a11:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801a14:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a17:	83 c4 10             	add    $0x10,%esp
  801a1a:	5b                   	pop    %ebx
  801a1b:	5e                   	pop    %esi
  801a1c:	5f                   	pop    %edi
  801a1d:	5d                   	pop    %ebp
  801a1e:	c3                   	ret    

00801a1f <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801a1f:	55                   	push   %ebp
  801a20:	89 e5                	mov    %esp,%ebp
  801a22:	83 ec 04             	sub    $0x4,%esp
  801a25:	8b 45 10             	mov    0x10(%ebp),%eax
  801a28:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801a2b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a32:	6a 00                	push   $0x0
  801a34:	6a 00                	push   $0x0
  801a36:	52                   	push   %edx
  801a37:	ff 75 0c             	pushl  0xc(%ebp)
  801a3a:	50                   	push   %eax
  801a3b:	6a 00                	push   $0x0
  801a3d:	e8 b2 ff ff ff       	call   8019f4 <syscall>
  801a42:	83 c4 18             	add    $0x18,%esp
}
  801a45:	90                   	nop
  801a46:	c9                   	leave  
  801a47:	c3                   	ret    

00801a48 <sys_cgetc>:

int
sys_cgetc(void)
{
  801a48:	55                   	push   %ebp
  801a49:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a4b:	6a 00                	push   $0x0
  801a4d:	6a 00                	push   $0x0
  801a4f:	6a 00                	push   $0x0
  801a51:	6a 00                	push   $0x0
  801a53:	6a 00                	push   $0x0
  801a55:	6a 01                	push   $0x1
  801a57:	e8 98 ff ff ff       	call   8019f4 <syscall>
  801a5c:	83 c4 18             	add    $0x18,%esp
}
  801a5f:	c9                   	leave  
  801a60:	c3                   	ret    

00801a61 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801a61:	55                   	push   %ebp
  801a62:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801a64:	8b 45 08             	mov    0x8(%ebp),%eax
  801a67:	6a 00                	push   $0x0
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 00                	push   $0x0
  801a6d:	6a 00                	push   $0x0
  801a6f:	50                   	push   %eax
  801a70:	6a 05                	push   $0x5
  801a72:	e8 7d ff ff ff       	call   8019f4 <syscall>
  801a77:	83 c4 18             	add    $0x18,%esp
}
  801a7a:	c9                   	leave  
  801a7b:	c3                   	ret    

00801a7c <sys_getenvid>:

int32 sys_getenvid(void)
{
  801a7c:	55                   	push   %ebp
  801a7d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801a7f:	6a 00                	push   $0x0
  801a81:	6a 00                	push   $0x0
  801a83:	6a 00                	push   $0x0
  801a85:	6a 00                	push   $0x0
  801a87:	6a 00                	push   $0x0
  801a89:	6a 02                	push   $0x2
  801a8b:	e8 64 ff ff ff       	call   8019f4 <syscall>
  801a90:	83 c4 18             	add    $0x18,%esp
}
  801a93:	c9                   	leave  
  801a94:	c3                   	ret    

00801a95 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801a95:	55                   	push   %ebp
  801a96:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 00                	push   $0x0
  801a9e:	6a 00                	push   $0x0
  801aa0:	6a 00                	push   $0x0
  801aa2:	6a 03                	push   $0x3
  801aa4:	e8 4b ff ff ff       	call   8019f4 <syscall>
  801aa9:	83 c4 18             	add    $0x18,%esp
}
  801aac:	c9                   	leave  
  801aad:	c3                   	ret    

00801aae <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801aae:	55                   	push   %ebp
  801aaf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	6a 00                	push   $0x0
  801ab7:	6a 00                	push   $0x0
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 04                	push   $0x4
  801abd:	e8 32 ff ff ff       	call   8019f4 <syscall>
  801ac2:	83 c4 18             	add    $0x18,%esp
}
  801ac5:	c9                   	leave  
  801ac6:	c3                   	ret    

00801ac7 <sys_env_exit>:


void sys_env_exit(void)
{
  801ac7:	55                   	push   %ebp
  801ac8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 06                	push   $0x6
  801ad6:	e8 19 ff ff ff       	call   8019f4 <syscall>
  801adb:	83 c4 18             	add    $0x18,%esp
}
  801ade:	90                   	nop
  801adf:	c9                   	leave  
  801ae0:	c3                   	ret    

00801ae1 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801ae1:	55                   	push   %ebp
  801ae2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801ae4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  801aea:	6a 00                	push   $0x0
  801aec:	6a 00                	push   $0x0
  801aee:	6a 00                	push   $0x0
  801af0:	52                   	push   %edx
  801af1:	50                   	push   %eax
  801af2:	6a 07                	push   $0x7
  801af4:	e8 fb fe ff ff       	call   8019f4 <syscall>
  801af9:	83 c4 18             	add    $0x18,%esp
}
  801afc:	c9                   	leave  
  801afd:	c3                   	ret    

00801afe <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801afe:	55                   	push   %ebp
  801aff:	89 e5                	mov    %esp,%ebp
  801b01:	56                   	push   %esi
  801b02:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801b03:	8b 75 18             	mov    0x18(%ebp),%esi
  801b06:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b09:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b12:	56                   	push   %esi
  801b13:	53                   	push   %ebx
  801b14:	51                   	push   %ecx
  801b15:	52                   	push   %edx
  801b16:	50                   	push   %eax
  801b17:	6a 08                	push   $0x8
  801b19:	e8 d6 fe ff ff       	call   8019f4 <syscall>
  801b1e:	83 c4 18             	add    $0x18,%esp
}
  801b21:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b24:	5b                   	pop    %ebx
  801b25:	5e                   	pop    %esi
  801b26:	5d                   	pop    %ebp
  801b27:	c3                   	ret    

00801b28 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801b28:	55                   	push   %ebp
  801b29:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801b2b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b31:	6a 00                	push   $0x0
  801b33:	6a 00                	push   $0x0
  801b35:	6a 00                	push   $0x0
  801b37:	52                   	push   %edx
  801b38:	50                   	push   %eax
  801b39:	6a 09                	push   $0x9
  801b3b:	e8 b4 fe ff ff       	call   8019f4 <syscall>
  801b40:	83 c4 18             	add    $0x18,%esp
}
  801b43:	c9                   	leave  
  801b44:	c3                   	ret    

00801b45 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b45:	55                   	push   %ebp
  801b46:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b48:	6a 00                	push   $0x0
  801b4a:	6a 00                	push   $0x0
  801b4c:	6a 00                	push   $0x0
  801b4e:	ff 75 0c             	pushl  0xc(%ebp)
  801b51:	ff 75 08             	pushl  0x8(%ebp)
  801b54:	6a 0a                	push   $0xa
  801b56:	e8 99 fe ff ff       	call   8019f4 <syscall>
  801b5b:	83 c4 18             	add    $0x18,%esp
}
  801b5e:	c9                   	leave  
  801b5f:	c3                   	ret    

00801b60 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801b60:	55                   	push   %ebp
  801b61:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801b63:	6a 00                	push   $0x0
  801b65:	6a 00                	push   $0x0
  801b67:	6a 00                	push   $0x0
  801b69:	6a 00                	push   $0x0
  801b6b:	6a 00                	push   $0x0
  801b6d:	6a 0b                	push   $0xb
  801b6f:	e8 80 fe ff ff       	call   8019f4 <syscall>
  801b74:	83 c4 18             	add    $0x18,%esp
}
  801b77:	c9                   	leave  
  801b78:	c3                   	ret    

00801b79 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801b79:	55                   	push   %ebp
  801b7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	6a 00                	push   $0x0
  801b86:	6a 0c                	push   $0xc
  801b88:	e8 67 fe ff ff       	call   8019f4 <syscall>
  801b8d:	83 c4 18             	add    $0x18,%esp
}
  801b90:	c9                   	leave  
  801b91:	c3                   	ret    

00801b92 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801b92:	55                   	push   %ebp
  801b93:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 0d                	push   $0xd
  801ba1:	e8 4e fe ff ff       	call   8019f4 <syscall>
  801ba6:	83 c4 18             	add    $0x18,%esp
}
  801ba9:	c9                   	leave  
  801baa:	c3                   	ret    

00801bab <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801bab:	55                   	push   %ebp
  801bac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 00                	push   $0x0
  801bb4:	ff 75 0c             	pushl  0xc(%ebp)
  801bb7:	ff 75 08             	pushl  0x8(%ebp)
  801bba:	6a 11                	push   $0x11
  801bbc:	e8 33 fe ff ff       	call   8019f4 <syscall>
  801bc1:	83 c4 18             	add    $0x18,%esp
	return;
  801bc4:	90                   	nop
}
  801bc5:	c9                   	leave  
  801bc6:	c3                   	ret    

00801bc7 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801bc7:	55                   	push   %ebp
  801bc8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801bca:	6a 00                	push   $0x0
  801bcc:	6a 00                	push   $0x0
  801bce:	6a 00                	push   $0x0
  801bd0:	ff 75 0c             	pushl  0xc(%ebp)
  801bd3:	ff 75 08             	pushl  0x8(%ebp)
  801bd6:	6a 12                	push   $0x12
  801bd8:	e8 17 fe ff ff       	call   8019f4 <syscall>
  801bdd:	83 c4 18             	add    $0x18,%esp
	return ;
  801be0:	90                   	nop
}
  801be1:	c9                   	leave  
  801be2:	c3                   	ret    

00801be3 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801be3:	55                   	push   %ebp
  801be4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801be6:	6a 00                	push   $0x0
  801be8:	6a 00                	push   $0x0
  801bea:	6a 00                	push   $0x0
  801bec:	6a 00                	push   $0x0
  801bee:	6a 00                	push   $0x0
  801bf0:	6a 0e                	push   $0xe
  801bf2:	e8 fd fd ff ff       	call   8019f4 <syscall>
  801bf7:	83 c4 18             	add    $0x18,%esp
}
  801bfa:	c9                   	leave  
  801bfb:	c3                   	ret    

00801bfc <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801bfc:	55                   	push   %ebp
  801bfd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801bff:	6a 00                	push   $0x0
  801c01:	6a 00                	push   $0x0
  801c03:	6a 00                	push   $0x0
  801c05:	6a 00                	push   $0x0
  801c07:	ff 75 08             	pushl  0x8(%ebp)
  801c0a:	6a 0f                	push   $0xf
  801c0c:	e8 e3 fd ff ff       	call   8019f4 <syscall>
  801c11:	83 c4 18             	add    $0x18,%esp
}
  801c14:	c9                   	leave  
  801c15:	c3                   	ret    

00801c16 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801c16:	55                   	push   %ebp
  801c17:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 00                	push   $0x0
  801c1d:	6a 00                	push   $0x0
  801c1f:	6a 00                	push   $0x0
  801c21:	6a 00                	push   $0x0
  801c23:	6a 10                	push   $0x10
  801c25:	e8 ca fd ff ff       	call   8019f4 <syscall>
  801c2a:	83 c4 18             	add    $0x18,%esp
}
  801c2d:	90                   	nop
  801c2e:	c9                   	leave  
  801c2f:	c3                   	ret    

00801c30 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801c30:	55                   	push   %ebp
  801c31:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801c33:	6a 00                	push   $0x0
  801c35:	6a 00                	push   $0x0
  801c37:	6a 00                	push   $0x0
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 00                	push   $0x0
  801c3d:	6a 14                	push   $0x14
  801c3f:	e8 b0 fd ff ff       	call   8019f4 <syscall>
  801c44:	83 c4 18             	add    $0x18,%esp
}
  801c47:	90                   	nop
  801c48:	c9                   	leave  
  801c49:	c3                   	ret    

00801c4a <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801c4a:	55                   	push   %ebp
  801c4b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801c4d:	6a 00                	push   $0x0
  801c4f:	6a 00                	push   $0x0
  801c51:	6a 00                	push   $0x0
  801c53:	6a 00                	push   $0x0
  801c55:	6a 00                	push   $0x0
  801c57:	6a 15                	push   $0x15
  801c59:	e8 96 fd ff ff       	call   8019f4 <syscall>
  801c5e:	83 c4 18             	add    $0x18,%esp
}
  801c61:	90                   	nop
  801c62:	c9                   	leave  
  801c63:	c3                   	ret    

00801c64 <sys_cputc>:


void
sys_cputc(const char c)
{
  801c64:	55                   	push   %ebp
  801c65:	89 e5                	mov    %esp,%ebp
  801c67:	83 ec 04             	sub    $0x4,%esp
  801c6a:	8b 45 08             	mov    0x8(%ebp),%eax
  801c6d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801c70:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c74:	6a 00                	push   $0x0
  801c76:	6a 00                	push   $0x0
  801c78:	6a 00                	push   $0x0
  801c7a:	6a 00                	push   $0x0
  801c7c:	50                   	push   %eax
  801c7d:	6a 16                	push   $0x16
  801c7f:	e8 70 fd ff ff       	call   8019f4 <syscall>
  801c84:	83 c4 18             	add    $0x18,%esp
}
  801c87:	90                   	nop
  801c88:	c9                   	leave  
  801c89:	c3                   	ret    

00801c8a <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801c8a:	55                   	push   %ebp
  801c8b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 00                	push   $0x0
  801c93:	6a 00                	push   $0x0
  801c95:	6a 00                	push   $0x0
  801c97:	6a 17                	push   $0x17
  801c99:	e8 56 fd ff ff       	call   8019f4 <syscall>
  801c9e:	83 c4 18             	add    $0x18,%esp
}
  801ca1:	90                   	nop
  801ca2:	c9                   	leave  
  801ca3:	c3                   	ret    

00801ca4 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801ca4:	55                   	push   %ebp
  801ca5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  801caa:	6a 00                	push   $0x0
  801cac:	6a 00                	push   $0x0
  801cae:	6a 00                	push   $0x0
  801cb0:	ff 75 0c             	pushl  0xc(%ebp)
  801cb3:	50                   	push   %eax
  801cb4:	6a 18                	push   $0x18
  801cb6:	e8 39 fd ff ff       	call   8019f4 <syscall>
  801cbb:	83 c4 18             	add    $0x18,%esp
}
  801cbe:	c9                   	leave  
  801cbf:	c3                   	ret    

00801cc0 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801cc0:	55                   	push   %ebp
  801cc1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cc3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 00                	push   $0x0
  801ccf:	52                   	push   %edx
  801cd0:	50                   	push   %eax
  801cd1:	6a 1b                	push   $0x1b
  801cd3:	e8 1c fd ff ff       	call   8019f4 <syscall>
  801cd8:	83 c4 18             	add    $0x18,%esp
}
  801cdb:	c9                   	leave  
  801cdc:	c3                   	ret    

00801cdd <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801cdd:	55                   	push   %ebp
  801cde:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ce0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce6:	6a 00                	push   $0x0
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 00                	push   $0x0
  801cec:	52                   	push   %edx
  801ced:	50                   	push   %eax
  801cee:	6a 19                	push   $0x19
  801cf0:	e8 ff fc ff ff       	call   8019f4 <syscall>
  801cf5:	83 c4 18             	add    $0x18,%esp
}
  801cf8:	90                   	nop
  801cf9:	c9                   	leave  
  801cfa:	c3                   	ret    

00801cfb <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801cfb:	55                   	push   %ebp
  801cfc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cfe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d01:	8b 45 08             	mov    0x8(%ebp),%eax
  801d04:	6a 00                	push   $0x0
  801d06:	6a 00                	push   $0x0
  801d08:	6a 00                	push   $0x0
  801d0a:	52                   	push   %edx
  801d0b:	50                   	push   %eax
  801d0c:	6a 1a                	push   $0x1a
  801d0e:	e8 e1 fc ff ff       	call   8019f4 <syscall>
  801d13:	83 c4 18             	add    $0x18,%esp
}
  801d16:	90                   	nop
  801d17:	c9                   	leave  
  801d18:	c3                   	ret    

00801d19 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801d19:	55                   	push   %ebp
  801d1a:	89 e5                	mov    %esp,%ebp
  801d1c:	83 ec 04             	sub    $0x4,%esp
  801d1f:	8b 45 10             	mov    0x10(%ebp),%eax
  801d22:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801d25:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d28:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2f:	6a 00                	push   $0x0
  801d31:	51                   	push   %ecx
  801d32:	52                   	push   %edx
  801d33:	ff 75 0c             	pushl  0xc(%ebp)
  801d36:	50                   	push   %eax
  801d37:	6a 1c                	push   $0x1c
  801d39:	e8 b6 fc ff ff       	call   8019f4 <syscall>
  801d3e:	83 c4 18             	add    $0x18,%esp
}
  801d41:	c9                   	leave  
  801d42:	c3                   	ret    

00801d43 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801d43:	55                   	push   %ebp
  801d44:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801d46:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d49:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4c:	6a 00                	push   $0x0
  801d4e:	6a 00                	push   $0x0
  801d50:	6a 00                	push   $0x0
  801d52:	52                   	push   %edx
  801d53:	50                   	push   %eax
  801d54:	6a 1d                	push   $0x1d
  801d56:	e8 99 fc ff ff       	call   8019f4 <syscall>
  801d5b:	83 c4 18             	add    $0x18,%esp
}
  801d5e:	c9                   	leave  
  801d5f:	c3                   	ret    

00801d60 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801d60:	55                   	push   %ebp
  801d61:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801d63:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d66:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d69:	8b 45 08             	mov    0x8(%ebp),%eax
  801d6c:	6a 00                	push   $0x0
  801d6e:	6a 00                	push   $0x0
  801d70:	51                   	push   %ecx
  801d71:	52                   	push   %edx
  801d72:	50                   	push   %eax
  801d73:	6a 1e                	push   $0x1e
  801d75:	e8 7a fc ff ff       	call   8019f4 <syscall>
  801d7a:	83 c4 18             	add    $0x18,%esp
}
  801d7d:	c9                   	leave  
  801d7e:	c3                   	ret    

00801d7f <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801d7f:	55                   	push   %ebp
  801d80:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801d82:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d85:	8b 45 08             	mov    0x8(%ebp),%eax
  801d88:	6a 00                	push   $0x0
  801d8a:	6a 00                	push   $0x0
  801d8c:	6a 00                	push   $0x0
  801d8e:	52                   	push   %edx
  801d8f:	50                   	push   %eax
  801d90:	6a 1f                	push   $0x1f
  801d92:	e8 5d fc ff ff       	call   8019f4 <syscall>
  801d97:	83 c4 18             	add    $0x18,%esp
}
  801d9a:	c9                   	leave  
  801d9b:	c3                   	ret    

00801d9c <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801d9c:	55                   	push   %ebp
  801d9d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801d9f:	6a 00                	push   $0x0
  801da1:	6a 00                	push   $0x0
  801da3:	6a 00                	push   $0x0
  801da5:	6a 00                	push   $0x0
  801da7:	6a 00                	push   $0x0
  801da9:	6a 20                	push   $0x20
  801dab:	e8 44 fc ff ff       	call   8019f4 <syscall>
  801db0:	83 c4 18             	add    $0x18,%esp
}
  801db3:	c9                   	leave  
  801db4:	c3                   	ret    

00801db5 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801db5:	55                   	push   %ebp
  801db6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801db8:	8b 45 08             	mov    0x8(%ebp),%eax
  801dbb:	6a 00                	push   $0x0
  801dbd:	ff 75 14             	pushl  0x14(%ebp)
  801dc0:	ff 75 10             	pushl  0x10(%ebp)
  801dc3:	ff 75 0c             	pushl  0xc(%ebp)
  801dc6:	50                   	push   %eax
  801dc7:	6a 21                	push   $0x21
  801dc9:	e8 26 fc ff ff       	call   8019f4 <syscall>
  801dce:	83 c4 18             	add    $0x18,%esp
}
  801dd1:	c9                   	leave  
  801dd2:	c3                   	ret    

00801dd3 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801dd3:	55                   	push   %ebp
  801dd4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd9:	6a 00                	push   $0x0
  801ddb:	6a 00                	push   $0x0
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 00                	push   $0x0
  801de1:	50                   	push   %eax
  801de2:	6a 22                	push   $0x22
  801de4:	e8 0b fc ff ff       	call   8019f4 <syscall>
  801de9:	83 c4 18             	add    $0x18,%esp
}
  801dec:	90                   	nop
  801ded:	c9                   	leave  
  801dee:	c3                   	ret    

00801def <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801def:	55                   	push   %ebp
  801df0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801df2:	8b 45 08             	mov    0x8(%ebp),%eax
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	50                   	push   %eax
  801dfe:	6a 23                	push   $0x23
  801e00:	e8 ef fb ff ff       	call   8019f4 <syscall>
  801e05:	83 c4 18             	add    $0x18,%esp
}
  801e08:	90                   	nop
  801e09:	c9                   	leave  
  801e0a:	c3                   	ret    

00801e0b <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801e0b:	55                   	push   %ebp
  801e0c:	89 e5                	mov    %esp,%ebp
  801e0e:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801e11:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e14:	8d 50 04             	lea    0x4(%eax),%edx
  801e17:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e1a:	6a 00                	push   $0x0
  801e1c:	6a 00                	push   $0x0
  801e1e:	6a 00                	push   $0x0
  801e20:	52                   	push   %edx
  801e21:	50                   	push   %eax
  801e22:	6a 24                	push   $0x24
  801e24:	e8 cb fb ff ff       	call   8019f4 <syscall>
  801e29:	83 c4 18             	add    $0x18,%esp
	return result;
  801e2c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801e2f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e32:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e35:	89 01                	mov    %eax,(%ecx)
  801e37:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801e3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3d:	c9                   	leave  
  801e3e:	c2 04 00             	ret    $0x4

00801e41 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e41:	55                   	push   %ebp
  801e42:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e44:	6a 00                	push   $0x0
  801e46:	6a 00                	push   $0x0
  801e48:	ff 75 10             	pushl  0x10(%ebp)
  801e4b:	ff 75 0c             	pushl  0xc(%ebp)
  801e4e:	ff 75 08             	pushl  0x8(%ebp)
  801e51:	6a 13                	push   $0x13
  801e53:	e8 9c fb ff ff       	call   8019f4 <syscall>
  801e58:	83 c4 18             	add    $0x18,%esp
	return ;
  801e5b:	90                   	nop
}
  801e5c:	c9                   	leave  
  801e5d:	c3                   	ret    

00801e5e <sys_rcr2>:
uint32 sys_rcr2()
{
  801e5e:	55                   	push   %ebp
  801e5f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801e61:	6a 00                	push   $0x0
  801e63:	6a 00                	push   $0x0
  801e65:	6a 00                	push   $0x0
  801e67:	6a 00                	push   $0x0
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 25                	push   $0x25
  801e6d:	e8 82 fb ff ff       	call   8019f4 <syscall>
  801e72:	83 c4 18             	add    $0x18,%esp
}
  801e75:	c9                   	leave  
  801e76:	c3                   	ret    

00801e77 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801e77:	55                   	push   %ebp
  801e78:	89 e5                	mov    %esp,%ebp
  801e7a:	83 ec 04             	sub    $0x4,%esp
  801e7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e80:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801e83:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801e87:	6a 00                	push   $0x0
  801e89:	6a 00                	push   $0x0
  801e8b:	6a 00                	push   $0x0
  801e8d:	6a 00                	push   $0x0
  801e8f:	50                   	push   %eax
  801e90:	6a 26                	push   $0x26
  801e92:	e8 5d fb ff ff       	call   8019f4 <syscall>
  801e97:	83 c4 18             	add    $0x18,%esp
	return ;
  801e9a:	90                   	nop
}
  801e9b:	c9                   	leave  
  801e9c:	c3                   	ret    

00801e9d <rsttst>:
void rsttst()
{
  801e9d:	55                   	push   %ebp
  801e9e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 00                	push   $0x0
  801ea4:	6a 00                	push   $0x0
  801ea6:	6a 00                	push   $0x0
  801ea8:	6a 00                	push   $0x0
  801eaa:	6a 28                	push   $0x28
  801eac:	e8 43 fb ff ff       	call   8019f4 <syscall>
  801eb1:	83 c4 18             	add    $0x18,%esp
	return ;
  801eb4:	90                   	nop
}
  801eb5:	c9                   	leave  
  801eb6:	c3                   	ret    

00801eb7 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801eb7:	55                   	push   %ebp
  801eb8:	89 e5                	mov    %esp,%ebp
  801eba:	83 ec 04             	sub    $0x4,%esp
  801ebd:	8b 45 14             	mov    0x14(%ebp),%eax
  801ec0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ec3:	8b 55 18             	mov    0x18(%ebp),%edx
  801ec6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801eca:	52                   	push   %edx
  801ecb:	50                   	push   %eax
  801ecc:	ff 75 10             	pushl  0x10(%ebp)
  801ecf:	ff 75 0c             	pushl  0xc(%ebp)
  801ed2:	ff 75 08             	pushl  0x8(%ebp)
  801ed5:	6a 27                	push   $0x27
  801ed7:	e8 18 fb ff ff       	call   8019f4 <syscall>
  801edc:	83 c4 18             	add    $0x18,%esp
	return ;
  801edf:	90                   	nop
}
  801ee0:	c9                   	leave  
  801ee1:	c3                   	ret    

00801ee2 <chktst>:
void chktst(uint32 n)
{
  801ee2:	55                   	push   %ebp
  801ee3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801ee5:	6a 00                	push   $0x0
  801ee7:	6a 00                	push   $0x0
  801ee9:	6a 00                	push   $0x0
  801eeb:	6a 00                	push   $0x0
  801eed:	ff 75 08             	pushl  0x8(%ebp)
  801ef0:	6a 29                	push   $0x29
  801ef2:	e8 fd fa ff ff       	call   8019f4 <syscall>
  801ef7:	83 c4 18             	add    $0x18,%esp
	return ;
  801efa:	90                   	nop
}
  801efb:	c9                   	leave  
  801efc:	c3                   	ret    

00801efd <inctst>:

void inctst()
{
  801efd:	55                   	push   %ebp
  801efe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801f00:	6a 00                	push   $0x0
  801f02:	6a 00                	push   $0x0
  801f04:	6a 00                	push   $0x0
  801f06:	6a 00                	push   $0x0
  801f08:	6a 00                	push   $0x0
  801f0a:	6a 2a                	push   $0x2a
  801f0c:	e8 e3 fa ff ff       	call   8019f4 <syscall>
  801f11:	83 c4 18             	add    $0x18,%esp
	return ;
  801f14:	90                   	nop
}
  801f15:	c9                   	leave  
  801f16:	c3                   	ret    

00801f17 <gettst>:
uint32 gettst()
{
  801f17:	55                   	push   %ebp
  801f18:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 00                	push   $0x0
  801f20:	6a 00                	push   $0x0
  801f22:	6a 00                	push   $0x0
  801f24:	6a 2b                	push   $0x2b
  801f26:	e8 c9 fa ff ff       	call   8019f4 <syscall>
  801f2b:	83 c4 18             	add    $0x18,%esp
}
  801f2e:	c9                   	leave  
  801f2f:	c3                   	ret    

00801f30 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801f30:	55                   	push   %ebp
  801f31:	89 e5                	mov    %esp,%ebp
  801f33:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 00                	push   $0x0
  801f3c:	6a 00                	push   $0x0
  801f3e:	6a 00                	push   $0x0
  801f40:	6a 2c                	push   $0x2c
  801f42:	e8 ad fa ff ff       	call   8019f4 <syscall>
  801f47:	83 c4 18             	add    $0x18,%esp
  801f4a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801f4d:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801f51:	75 07                	jne    801f5a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801f53:	b8 01 00 00 00       	mov    $0x1,%eax
  801f58:	eb 05                	jmp    801f5f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801f5a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f5f:	c9                   	leave  
  801f60:	c3                   	ret    

00801f61 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801f61:	55                   	push   %ebp
  801f62:	89 e5                	mov    %esp,%ebp
  801f64:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f67:	6a 00                	push   $0x0
  801f69:	6a 00                	push   $0x0
  801f6b:	6a 00                	push   $0x0
  801f6d:	6a 00                	push   $0x0
  801f6f:	6a 00                	push   $0x0
  801f71:	6a 2c                	push   $0x2c
  801f73:	e8 7c fa ff ff       	call   8019f4 <syscall>
  801f78:	83 c4 18             	add    $0x18,%esp
  801f7b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801f7e:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801f82:	75 07                	jne    801f8b <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801f84:	b8 01 00 00 00       	mov    $0x1,%eax
  801f89:	eb 05                	jmp    801f90 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801f8b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f90:	c9                   	leave  
  801f91:	c3                   	ret    

00801f92 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801f92:	55                   	push   %ebp
  801f93:	89 e5                	mov    %esp,%ebp
  801f95:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 00                	push   $0x0
  801f9c:	6a 00                	push   $0x0
  801f9e:	6a 00                	push   $0x0
  801fa0:	6a 00                	push   $0x0
  801fa2:	6a 2c                	push   $0x2c
  801fa4:	e8 4b fa ff ff       	call   8019f4 <syscall>
  801fa9:	83 c4 18             	add    $0x18,%esp
  801fac:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801faf:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801fb3:	75 07                	jne    801fbc <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801fb5:	b8 01 00 00 00       	mov    $0x1,%eax
  801fba:	eb 05                	jmp    801fc1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801fbc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fc1:	c9                   	leave  
  801fc2:	c3                   	ret    

00801fc3 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801fc3:	55                   	push   %ebp
  801fc4:	89 e5                	mov    %esp,%ebp
  801fc6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fc9:	6a 00                	push   $0x0
  801fcb:	6a 00                	push   $0x0
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 00                	push   $0x0
  801fd3:	6a 2c                	push   $0x2c
  801fd5:	e8 1a fa ff ff       	call   8019f4 <syscall>
  801fda:	83 c4 18             	add    $0x18,%esp
  801fdd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801fe0:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801fe4:	75 07                	jne    801fed <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801fe6:	b8 01 00 00 00       	mov    $0x1,%eax
  801feb:	eb 05                	jmp    801ff2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801fed:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ff2:	c9                   	leave  
  801ff3:	c3                   	ret    

00801ff4 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801ff4:	55                   	push   %ebp
  801ff5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801ff7:	6a 00                	push   $0x0
  801ff9:	6a 00                	push   $0x0
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 00                	push   $0x0
  801fff:	ff 75 08             	pushl  0x8(%ebp)
  802002:	6a 2d                	push   $0x2d
  802004:	e8 eb f9 ff ff       	call   8019f4 <syscall>
  802009:	83 c4 18             	add    $0x18,%esp
	return ;
  80200c:	90                   	nop
}
  80200d:	c9                   	leave  
  80200e:	c3                   	ret    

0080200f <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80200f:	55                   	push   %ebp
  802010:	89 e5                	mov    %esp,%ebp
  802012:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802013:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802016:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802019:	8b 55 0c             	mov    0xc(%ebp),%edx
  80201c:	8b 45 08             	mov    0x8(%ebp),%eax
  80201f:	6a 00                	push   $0x0
  802021:	53                   	push   %ebx
  802022:	51                   	push   %ecx
  802023:	52                   	push   %edx
  802024:	50                   	push   %eax
  802025:	6a 2e                	push   $0x2e
  802027:	e8 c8 f9 ff ff       	call   8019f4 <syscall>
  80202c:	83 c4 18             	add    $0x18,%esp
}
  80202f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802032:	c9                   	leave  
  802033:	c3                   	ret    

00802034 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802034:	55                   	push   %ebp
  802035:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802037:	8b 55 0c             	mov    0xc(%ebp),%edx
  80203a:	8b 45 08             	mov    0x8(%ebp),%eax
  80203d:	6a 00                	push   $0x0
  80203f:	6a 00                	push   $0x0
  802041:	6a 00                	push   $0x0
  802043:	52                   	push   %edx
  802044:	50                   	push   %eax
  802045:	6a 2f                	push   $0x2f
  802047:	e8 a8 f9 ff ff       	call   8019f4 <syscall>
  80204c:	83 c4 18             	add    $0x18,%esp
}
  80204f:	c9                   	leave  
  802050:	c3                   	ret    

00802051 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  802051:	55                   	push   %ebp
  802052:	89 e5                	mov    %esp,%ebp
  802054:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  802057:	8b 55 08             	mov    0x8(%ebp),%edx
  80205a:	89 d0                	mov    %edx,%eax
  80205c:	c1 e0 02             	shl    $0x2,%eax
  80205f:	01 d0                	add    %edx,%eax
  802061:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802068:	01 d0                	add    %edx,%eax
  80206a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802071:	01 d0                	add    %edx,%eax
  802073:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80207a:	01 d0                	add    %edx,%eax
  80207c:	c1 e0 04             	shl    $0x4,%eax
  80207f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  802082:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  802089:	8d 45 e8             	lea    -0x18(%ebp),%eax
  80208c:	83 ec 0c             	sub    $0xc,%esp
  80208f:	50                   	push   %eax
  802090:	e8 76 fd ff ff       	call   801e0b <sys_get_virtual_time>
  802095:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  802098:	eb 41                	jmp    8020db <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  80209a:	8d 45 e0             	lea    -0x20(%ebp),%eax
  80209d:	83 ec 0c             	sub    $0xc,%esp
  8020a0:	50                   	push   %eax
  8020a1:	e8 65 fd ff ff       	call   801e0b <sys_get_virtual_time>
  8020a6:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  8020a9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8020ac:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8020af:	29 c2                	sub    %eax,%edx
  8020b1:	89 d0                	mov    %edx,%eax
  8020b3:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  8020b6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8020b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8020bc:	89 d1                	mov    %edx,%ecx
  8020be:	29 c1                	sub    %eax,%ecx
  8020c0:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8020c3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8020c6:	39 c2                	cmp    %eax,%edx
  8020c8:	0f 97 c0             	seta   %al
  8020cb:	0f b6 c0             	movzbl %al,%eax
  8020ce:	29 c1                	sub    %eax,%ecx
  8020d0:	89 c8                	mov    %ecx,%eax
  8020d2:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  8020d5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8020d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  8020db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8020de:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8020e1:	72 b7                	jb     80209a <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  8020e3:	90                   	nop
  8020e4:	c9                   	leave  
  8020e5:	c3                   	ret    

008020e6 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  8020e6:	55                   	push   %ebp
  8020e7:	89 e5                	mov    %esp,%ebp
  8020e9:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  8020ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  8020f3:	eb 03                	jmp    8020f8 <busy_wait+0x12>
  8020f5:	ff 45 fc             	incl   -0x4(%ebp)
  8020f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8020fb:	3b 45 08             	cmp    0x8(%ebp),%eax
  8020fe:	72 f5                	jb     8020f5 <busy_wait+0xf>
	return i;
  802100:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  802103:	c9                   	leave  
  802104:	c3                   	ret    
  802105:	66 90                	xchg   %ax,%ax
  802107:	90                   	nop

00802108 <__udivdi3>:
  802108:	55                   	push   %ebp
  802109:	57                   	push   %edi
  80210a:	56                   	push   %esi
  80210b:	53                   	push   %ebx
  80210c:	83 ec 1c             	sub    $0x1c,%esp
  80210f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802113:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802117:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80211b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80211f:	89 ca                	mov    %ecx,%edx
  802121:	89 f8                	mov    %edi,%eax
  802123:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802127:	85 f6                	test   %esi,%esi
  802129:	75 2d                	jne    802158 <__udivdi3+0x50>
  80212b:	39 cf                	cmp    %ecx,%edi
  80212d:	77 65                	ja     802194 <__udivdi3+0x8c>
  80212f:	89 fd                	mov    %edi,%ebp
  802131:	85 ff                	test   %edi,%edi
  802133:	75 0b                	jne    802140 <__udivdi3+0x38>
  802135:	b8 01 00 00 00       	mov    $0x1,%eax
  80213a:	31 d2                	xor    %edx,%edx
  80213c:	f7 f7                	div    %edi
  80213e:	89 c5                	mov    %eax,%ebp
  802140:	31 d2                	xor    %edx,%edx
  802142:	89 c8                	mov    %ecx,%eax
  802144:	f7 f5                	div    %ebp
  802146:	89 c1                	mov    %eax,%ecx
  802148:	89 d8                	mov    %ebx,%eax
  80214a:	f7 f5                	div    %ebp
  80214c:	89 cf                	mov    %ecx,%edi
  80214e:	89 fa                	mov    %edi,%edx
  802150:	83 c4 1c             	add    $0x1c,%esp
  802153:	5b                   	pop    %ebx
  802154:	5e                   	pop    %esi
  802155:	5f                   	pop    %edi
  802156:	5d                   	pop    %ebp
  802157:	c3                   	ret    
  802158:	39 ce                	cmp    %ecx,%esi
  80215a:	77 28                	ja     802184 <__udivdi3+0x7c>
  80215c:	0f bd fe             	bsr    %esi,%edi
  80215f:	83 f7 1f             	xor    $0x1f,%edi
  802162:	75 40                	jne    8021a4 <__udivdi3+0x9c>
  802164:	39 ce                	cmp    %ecx,%esi
  802166:	72 0a                	jb     802172 <__udivdi3+0x6a>
  802168:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80216c:	0f 87 9e 00 00 00    	ja     802210 <__udivdi3+0x108>
  802172:	b8 01 00 00 00       	mov    $0x1,%eax
  802177:	89 fa                	mov    %edi,%edx
  802179:	83 c4 1c             	add    $0x1c,%esp
  80217c:	5b                   	pop    %ebx
  80217d:	5e                   	pop    %esi
  80217e:	5f                   	pop    %edi
  80217f:	5d                   	pop    %ebp
  802180:	c3                   	ret    
  802181:	8d 76 00             	lea    0x0(%esi),%esi
  802184:	31 ff                	xor    %edi,%edi
  802186:	31 c0                	xor    %eax,%eax
  802188:	89 fa                	mov    %edi,%edx
  80218a:	83 c4 1c             	add    $0x1c,%esp
  80218d:	5b                   	pop    %ebx
  80218e:	5e                   	pop    %esi
  80218f:	5f                   	pop    %edi
  802190:	5d                   	pop    %ebp
  802191:	c3                   	ret    
  802192:	66 90                	xchg   %ax,%ax
  802194:	89 d8                	mov    %ebx,%eax
  802196:	f7 f7                	div    %edi
  802198:	31 ff                	xor    %edi,%edi
  80219a:	89 fa                	mov    %edi,%edx
  80219c:	83 c4 1c             	add    $0x1c,%esp
  80219f:	5b                   	pop    %ebx
  8021a0:	5e                   	pop    %esi
  8021a1:	5f                   	pop    %edi
  8021a2:	5d                   	pop    %ebp
  8021a3:	c3                   	ret    
  8021a4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8021a9:	89 eb                	mov    %ebp,%ebx
  8021ab:	29 fb                	sub    %edi,%ebx
  8021ad:	89 f9                	mov    %edi,%ecx
  8021af:	d3 e6                	shl    %cl,%esi
  8021b1:	89 c5                	mov    %eax,%ebp
  8021b3:	88 d9                	mov    %bl,%cl
  8021b5:	d3 ed                	shr    %cl,%ebp
  8021b7:	89 e9                	mov    %ebp,%ecx
  8021b9:	09 f1                	or     %esi,%ecx
  8021bb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8021bf:	89 f9                	mov    %edi,%ecx
  8021c1:	d3 e0                	shl    %cl,%eax
  8021c3:	89 c5                	mov    %eax,%ebp
  8021c5:	89 d6                	mov    %edx,%esi
  8021c7:	88 d9                	mov    %bl,%cl
  8021c9:	d3 ee                	shr    %cl,%esi
  8021cb:	89 f9                	mov    %edi,%ecx
  8021cd:	d3 e2                	shl    %cl,%edx
  8021cf:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021d3:	88 d9                	mov    %bl,%cl
  8021d5:	d3 e8                	shr    %cl,%eax
  8021d7:	09 c2                	or     %eax,%edx
  8021d9:	89 d0                	mov    %edx,%eax
  8021db:	89 f2                	mov    %esi,%edx
  8021dd:	f7 74 24 0c          	divl   0xc(%esp)
  8021e1:	89 d6                	mov    %edx,%esi
  8021e3:	89 c3                	mov    %eax,%ebx
  8021e5:	f7 e5                	mul    %ebp
  8021e7:	39 d6                	cmp    %edx,%esi
  8021e9:	72 19                	jb     802204 <__udivdi3+0xfc>
  8021eb:	74 0b                	je     8021f8 <__udivdi3+0xf0>
  8021ed:	89 d8                	mov    %ebx,%eax
  8021ef:	31 ff                	xor    %edi,%edi
  8021f1:	e9 58 ff ff ff       	jmp    80214e <__udivdi3+0x46>
  8021f6:	66 90                	xchg   %ax,%ax
  8021f8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8021fc:	89 f9                	mov    %edi,%ecx
  8021fe:	d3 e2                	shl    %cl,%edx
  802200:	39 c2                	cmp    %eax,%edx
  802202:	73 e9                	jae    8021ed <__udivdi3+0xe5>
  802204:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802207:	31 ff                	xor    %edi,%edi
  802209:	e9 40 ff ff ff       	jmp    80214e <__udivdi3+0x46>
  80220e:	66 90                	xchg   %ax,%ax
  802210:	31 c0                	xor    %eax,%eax
  802212:	e9 37 ff ff ff       	jmp    80214e <__udivdi3+0x46>
  802217:	90                   	nop

00802218 <__umoddi3>:
  802218:	55                   	push   %ebp
  802219:	57                   	push   %edi
  80221a:	56                   	push   %esi
  80221b:	53                   	push   %ebx
  80221c:	83 ec 1c             	sub    $0x1c,%esp
  80221f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802223:	8b 74 24 34          	mov    0x34(%esp),%esi
  802227:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80222b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80222f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802233:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802237:	89 f3                	mov    %esi,%ebx
  802239:	89 fa                	mov    %edi,%edx
  80223b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80223f:	89 34 24             	mov    %esi,(%esp)
  802242:	85 c0                	test   %eax,%eax
  802244:	75 1a                	jne    802260 <__umoddi3+0x48>
  802246:	39 f7                	cmp    %esi,%edi
  802248:	0f 86 a2 00 00 00    	jbe    8022f0 <__umoddi3+0xd8>
  80224e:	89 c8                	mov    %ecx,%eax
  802250:	89 f2                	mov    %esi,%edx
  802252:	f7 f7                	div    %edi
  802254:	89 d0                	mov    %edx,%eax
  802256:	31 d2                	xor    %edx,%edx
  802258:	83 c4 1c             	add    $0x1c,%esp
  80225b:	5b                   	pop    %ebx
  80225c:	5e                   	pop    %esi
  80225d:	5f                   	pop    %edi
  80225e:	5d                   	pop    %ebp
  80225f:	c3                   	ret    
  802260:	39 f0                	cmp    %esi,%eax
  802262:	0f 87 ac 00 00 00    	ja     802314 <__umoddi3+0xfc>
  802268:	0f bd e8             	bsr    %eax,%ebp
  80226b:	83 f5 1f             	xor    $0x1f,%ebp
  80226e:	0f 84 ac 00 00 00    	je     802320 <__umoddi3+0x108>
  802274:	bf 20 00 00 00       	mov    $0x20,%edi
  802279:	29 ef                	sub    %ebp,%edi
  80227b:	89 fe                	mov    %edi,%esi
  80227d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802281:	89 e9                	mov    %ebp,%ecx
  802283:	d3 e0                	shl    %cl,%eax
  802285:	89 d7                	mov    %edx,%edi
  802287:	89 f1                	mov    %esi,%ecx
  802289:	d3 ef                	shr    %cl,%edi
  80228b:	09 c7                	or     %eax,%edi
  80228d:	89 e9                	mov    %ebp,%ecx
  80228f:	d3 e2                	shl    %cl,%edx
  802291:	89 14 24             	mov    %edx,(%esp)
  802294:	89 d8                	mov    %ebx,%eax
  802296:	d3 e0                	shl    %cl,%eax
  802298:	89 c2                	mov    %eax,%edx
  80229a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80229e:	d3 e0                	shl    %cl,%eax
  8022a0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8022a4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022a8:	89 f1                	mov    %esi,%ecx
  8022aa:	d3 e8                	shr    %cl,%eax
  8022ac:	09 d0                	or     %edx,%eax
  8022ae:	d3 eb                	shr    %cl,%ebx
  8022b0:	89 da                	mov    %ebx,%edx
  8022b2:	f7 f7                	div    %edi
  8022b4:	89 d3                	mov    %edx,%ebx
  8022b6:	f7 24 24             	mull   (%esp)
  8022b9:	89 c6                	mov    %eax,%esi
  8022bb:	89 d1                	mov    %edx,%ecx
  8022bd:	39 d3                	cmp    %edx,%ebx
  8022bf:	0f 82 87 00 00 00    	jb     80234c <__umoddi3+0x134>
  8022c5:	0f 84 91 00 00 00    	je     80235c <__umoddi3+0x144>
  8022cb:	8b 54 24 04          	mov    0x4(%esp),%edx
  8022cf:	29 f2                	sub    %esi,%edx
  8022d1:	19 cb                	sbb    %ecx,%ebx
  8022d3:	89 d8                	mov    %ebx,%eax
  8022d5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8022d9:	d3 e0                	shl    %cl,%eax
  8022db:	89 e9                	mov    %ebp,%ecx
  8022dd:	d3 ea                	shr    %cl,%edx
  8022df:	09 d0                	or     %edx,%eax
  8022e1:	89 e9                	mov    %ebp,%ecx
  8022e3:	d3 eb                	shr    %cl,%ebx
  8022e5:	89 da                	mov    %ebx,%edx
  8022e7:	83 c4 1c             	add    $0x1c,%esp
  8022ea:	5b                   	pop    %ebx
  8022eb:	5e                   	pop    %esi
  8022ec:	5f                   	pop    %edi
  8022ed:	5d                   	pop    %ebp
  8022ee:	c3                   	ret    
  8022ef:	90                   	nop
  8022f0:	89 fd                	mov    %edi,%ebp
  8022f2:	85 ff                	test   %edi,%edi
  8022f4:	75 0b                	jne    802301 <__umoddi3+0xe9>
  8022f6:	b8 01 00 00 00       	mov    $0x1,%eax
  8022fb:	31 d2                	xor    %edx,%edx
  8022fd:	f7 f7                	div    %edi
  8022ff:	89 c5                	mov    %eax,%ebp
  802301:	89 f0                	mov    %esi,%eax
  802303:	31 d2                	xor    %edx,%edx
  802305:	f7 f5                	div    %ebp
  802307:	89 c8                	mov    %ecx,%eax
  802309:	f7 f5                	div    %ebp
  80230b:	89 d0                	mov    %edx,%eax
  80230d:	e9 44 ff ff ff       	jmp    802256 <__umoddi3+0x3e>
  802312:	66 90                	xchg   %ax,%ax
  802314:	89 c8                	mov    %ecx,%eax
  802316:	89 f2                	mov    %esi,%edx
  802318:	83 c4 1c             	add    $0x1c,%esp
  80231b:	5b                   	pop    %ebx
  80231c:	5e                   	pop    %esi
  80231d:	5f                   	pop    %edi
  80231e:	5d                   	pop    %ebp
  80231f:	c3                   	ret    
  802320:	3b 04 24             	cmp    (%esp),%eax
  802323:	72 06                	jb     80232b <__umoddi3+0x113>
  802325:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802329:	77 0f                	ja     80233a <__umoddi3+0x122>
  80232b:	89 f2                	mov    %esi,%edx
  80232d:	29 f9                	sub    %edi,%ecx
  80232f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802333:	89 14 24             	mov    %edx,(%esp)
  802336:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80233a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80233e:	8b 14 24             	mov    (%esp),%edx
  802341:	83 c4 1c             	add    $0x1c,%esp
  802344:	5b                   	pop    %ebx
  802345:	5e                   	pop    %esi
  802346:	5f                   	pop    %edi
  802347:	5d                   	pop    %ebp
  802348:	c3                   	ret    
  802349:	8d 76 00             	lea    0x0(%esi),%esi
  80234c:	2b 04 24             	sub    (%esp),%eax
  80234f:	19 fa                	sbb    %edi,%edx
  802351:	89 d1                	mov    %edx,%ecx
  802353:	89 c6                	mov    %eax,%esi
  802355:	e9 71 ff ff ff       	jmp    8022cb <__umoddi3+0xb3>
  80235a:	66 90                	xchg   %ax,%ax
  80235c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802360:	72 ea                	jb     80234c <__umoddi3+0x134>
  802362:	89 d9                	mov    %ebx,%ecx
  802364:	e9 62 ff ff ff       	jmp    8022cb <__umoddi3+0xb3>
