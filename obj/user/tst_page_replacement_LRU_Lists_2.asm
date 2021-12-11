
obj/user/tst_page_replacement_LRU_Lists_2:     file format elf32-i386


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
  800031:	e8 83 02 00 00       	call   8002b9 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
char arr[PAGE_SIZE*13];
char* ptr = (char* )0x0801000 ;
char* ptr2 = (char* )0x0804000 ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 8c 00 00 00    	sub    $0x8c,%esp
//	cprintf("envID = %d\n",envID);
	int x = 0;
  800044:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)

	//("STEP 0: checking Initial WS entries ...\n");
	{
		uint32 actual_active_list[6] = {0x803000, 0x801000, 0x800000, 0xeebfd000, 0x204000, 0x203000};
  80004b:	8d 45 84             	lea    -0x7c(%ebp),%eax
  80004e:	bb d8 1e 80 00       	mov    $0x801ed8,%ebx
  800053:	ba 06 00 00 00       	mov    $0x6,%edx
  800058:	89 c7                	mov    %eax,%edi
  80005a:	89 de                	mov    %ebx,%esi
  80005c:	89 d1                	mov    %edx,%ecx
  80005e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
		uint32 actual_second_list[5] = {0x202000, 0x201000, 0x200000, 0x802000, 0x205000};
  800060:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
  800066:	bb f0 1e 80 00       	mov    $0x801ef0,%ebx
  80006b:	ba 05 00 00 00       	mov    $0x5,%edx
  800070:	89 c7                	mov    %eax,%edi
  800072:	89 de                	mov    %ebx,%esi
  800074:	89 d1                	mov    %edx,%ecx
  800076:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
		int check = sys_check_LRU_lists(actual_active_list, actual_second_list, 6, 5);
  800078:	6a 05                	push   $0x5
  80007a:	6a 06                	push   $0x6
  80007c:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
  800082:	50                   	push   %eax
  800083:	8d 45 84             	lea    -0x7c(%ebp),%eax
  800086:	50                   	push   %eax
  800087:	e8 b9 19 00 00       	call   801a45 <sys_check_LRU_lists>
  80008c:	83 c4 10             	add    $0x10,%esp
  80008f:	89 45 dc             	mov    %eax,-0x24(%ebp)
		if(check == 0)
  800092:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800096:	75 14                	jne    8000ac <_main+0x74>
			panic("INITIAL PAGE LRU LISTs entry checking failed! Review size of the LRU lists..!!");
  800098:	83 ec 04             	sub    $0x4,%esp
  80009b:	68 00 1d 80 00       	push   $0x801d00
  8000a0:	6a 18                	push   $0x18
  8000a2:	68 50 1d 80 00       	push   $0x801d50
  8000a7:	e8 52 03 00 00       	call   8003fe <_panic>
	}

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  8000ac:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8000b1:	88 45 db             	mov    %al,-0x25(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  8000b4:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8000b9:	88 45 da             	mov    %al,-0x26(%ebp)

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8000bc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8000c3:	eb 37                	jmp    8000fc <_main+0xc4>
	{
		arr[i] = -1 ;
  8000c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000c8:	05 40 30 80 00       	add    $0x803040,%eax
  8000cd:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  8000d0:	a1 04 30 80 00       	mov    0x803004,%eax
  8000d5:	8b 15 00 30 80 00    	mov    0x803000,%edx
  8000db:	8a 12                	mov    (%edx),%dl
  8000dd:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  8000df:	a1 00 30 80 00       	mov    0x803000,%eax
  8000e4:	40                   	inc    %eax
  8000e5:	a3 00 30 80 00       	mov    %eax,0x803000
  8000ea:	a1 04 30 80 00       	mov    0x803004,%eax
  8000ef:	40                   	inc    %eax
  8000f0:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1] ;
	char garbage2 = arr[PAGE_SIZE*12-1] ;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8000f5:	81 45 e4 00 08 00 00 	addl   $0x800,-0x1c(%ebp)
  8000fc:	81 7d e4 ff 9f 00 00 	cmpl   $0x9fff,-0x1c(%ebp)
  800103:	7e c0                	jle    8000c5 <_main+0x8d>
	}

	//===================

	//("STEP 1: checking LRU LISTS after a new page FAULTS...\n");
	uint32 actual_active_list[6] = {0x803000, 0x801000, 0x800000, 0xeebfd000, 0x804000, 0x80c000};
  800105:	8d 45 b0             	lea    -0x50(%ebp),%eax
  800108:	bb 04 1f 80 00       	mov    $0x801f04,%ebx
  80010d:	ba 06 00 00 00       	mov    $0x6,%edx
  800112:	89 c7                	mov    %eax,%edi
  800114:	89 de                	mov    %ebx,%esi
  800116:	89 d1                	mov    %edx,%ecx
  800118:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	uint32 actual_second_list[5] = {0x80b000, 0x80a000, 0x809000, 0x808000, 0x807000};
  80011a:	8d 45 9c             	lea    -0x64(%ebp),%eax
  80011d:	bb 1c 1f 80 00       	mov    $0x801f1c,%ebx
  800122:	ba 05 00 00 00       	mov    $0x5,%edx
  800127:	89 c7                	mov    %eax,%edi
  800129:	89 de                	mov    %ebx,%esi
  80012b:	89 d1                	mov    %edx,%ecx
  80012d:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	int check = sys_check_LRU_lists(actual_active_list, actual_second_list, 6, 5);
  80012f:	6a 05                	push   $0x5
  800131:	6a 06                	push   $0x6
  800133:	8d 45 9c             	lea    -0x64(%ebp),%eax
  800136:	50                   	push   %eax
  800137:	8d 45 b0             	lea    -0x50(%ebp),%eax
  80013a:	50                   	push   %eax
  80013b:	e8 05 19 00 00       	call   801a45 <sys_check_LRU_lists>
  800140:	83 c4 10             	add    $0x10,%esp
  800143:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	if(check == 0)
  800146:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  80014a:	75 14                	jne    800160 <_main+0x128>
		panic("PAGE LRU Lists entry checking failed when a new PAGE FAULTs occurred..!!");
  80014c:	83 ec 04             	sub    $0x4,%esp
  80014f:	68 78 1d 80 00       	push   $0x801d78
  800154:	6a 33                	push   $0x33
  800156:	68 50 1d 80 00       	push   $0x801d50
  80015b:	e8 9e 02 00 00       	call   8003fe <_panic>


	//("STEP 2: Checking PAGE LRU LIST algorithm after faults due to ACCESS in the second chance list... \n");
	{
		uint32* secondlistVA = (uint32*)0x809000;
  800160:	c7 45 d0 00 90 80 00 	movl   $0x809000,-0x30(%ebp)
		x = x + *secondlistVA;
  800167:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80016a:	8b 10                	mov    (%eax),%edx
  80016c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80016f:	01 d0                	add    %edx,%eax
  800171:	89 45 e0             	mov    %eax,-0x20(%ebp)
		secondlistVA = (uint32*)0x807000;
  800174:	c7 45 d0 00 70 80 00 	movl   $0x807000,-0x30(%ebp)
		x = x + *secondlistVA;
  80017b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80017e:	8b 10                	mov    (%eax),%edx
  800180:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800183:	01 d0                	add    %edx,%eax
  800185:	89 45 e0             	mov    %eax,-0x20(%ebp)
		secondlistVA = (uint32*)0x804000;
  800188:	c7 45 d0 00 40 80 00 	movl   $0x804000,-0x30(%ebp)
		x = x + *secondlistVA;
  80018f:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800192:	8b 10                	mov    (%eax),%edx
  800194:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800197:	01 d0                	add    %edx,%eax
  800199:	89 45 e0             	mov    %eax,-0x20(%ebp)

		actual_active_list[0] = 0x801000;
  80019c:	c7 45 b0 00 10 80 00 	movl   $0x801000,-0x50(%ebp)
		actual_active_list[1] = 0x800000;
  8001a3:	c7 45 b4 00 00 80 00 	movl   $0x800000,-0x4c(%ebp)
		actual_active_list[2] = 0xeebfd000;
  8001aa:	c7 45 b8 00 d0 bf ee 	movl   $0xeebfd000,-0x48(%ebp)
		actual_active_list[3] = 0x804000;
  8001b1:	c7 45 bc 00 40 80 00 	movl   $0x804000,-0x44(%ebp)
		actual_active_list[4] = 0x807000;
  8001b8:	c7 45 c0 00 70 80 00 	movl   $0x807000,-0x40(%ebp)
		actual_active_list[5] = 0x809000;
  8001bf:	c7 45 c4 00 90 80 00 	movl   $0x809000,-0x3c(%ebp)

		actual_second_list[0] = 0x803000;
  8001c6:	c7 45 9c 00 30 80 00 	movl   $0x803000,-0x64(%ebp)
		actual_second_list[1] = 0x80c000;
  8001cd:	c7 45 a0 00 c0 80 00 	movl   $0x80c000,-0x60(%ebp)
		actual_second_list[2] = 0x80b000;
  8001d4:	c7 45 a4 00 b0 80 00 	movl   $0x80b000,-0x5c(%ebp)
		actual_second_list[3] = 0x80a000;
  8001db:	c7 45 a8 00 a0 80 00 	movl   $0x80a000,-0x58(%ebp)
		actual_second_list[4] = 0x808000;
  8001e2:	c7 45 ac 00 80 80 00 	movl   $0x808000,-0x54(%ebp)
		int check = sys_check_LRU_lists(actual_active_list, actual_second_list, 6, 5);
  8001e9:	6a 05                	push   $0x5
  8001eb:	6a 06                	push   $0x6
  8001ed:	8d 45 9c             	lea    -0x64(%ebp),%eax
  8001f0:	50                   	push   %eax
  8001f1:	8d 45 b0             	lea    -0x50(%ebp),%eax
  8001f4:	50                   	push   %eax
  8001f5:	e8 4b 18 00 00       	call   801a45 <sys_check_LRU_lists>
  8001fa:	83 c4 10             	add    $0x10,%esp
  8001fd:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if(check == 0)
  800200:	83 7d cc 00          	cmpl   $0x0,-0x34(%ebp)
  800204:	75 14                	jne    80021a <_main+0x1e2>
			panic("PAGE LRU Lists entry checking failed when a new PAGE ACCESS from the SECOND LIST is occurred..!!");
  800206:	83 ec 04             	sub    $0x4,%esp
  800209:	68 c4 1d 80 00       	push   $0x801dc4
  80020e:	6a 4d                	push   $0x4d
  800210:	68 50 1d 80 00       	push   $0x801d50
  800215:	e8 e4 01 00 00       	call   8003fe <_panic>
	}

	//("STEP 3: NEW FAULTS to test applying LRU algorithm on the second list by removing the LRU page... \n");
	{
		//Reading (Not Modified)
		char garbage3 = arr[PAGE_SIZE*13-1] ;
  80021a:	a0 3f 00 81 00       	mov    0x81003f,%al
  80021f:	88 45 cb             	mov    %al,-0x35(%ebp)
		actual_active_list[0] = 0x810000;
  800222:	c7 45 b0 00 00 81 00 	movl   $0x810000,-0x50(%ebp)
		actual_active_list[1] = 0x801000;
  800229:	c7 45 b4 00 10 80 00 	movl   $0x801000,-0x4c(%ebp)
		actual_active_list[2] = 0x800000;
  800230:	c7 45 b8 00 00 80 00 	movl   $0x800000,-0x48(%ebp)
		actual_active_list[3] = 0xeebfd000;
  800237:	c7 45 bc 00 d0 bf ee 	movl   $0xeebfd000,-0x44(%ebp)
		actual_active_list[4] = 0x804000;
  80023e:	c7 45 c0 00 40 80 00 	movl   $0x804000,-0x40(%ebp)
		actual_active_list[5] = 0x807000;
  800245:	c7 45 c4 00 70 80 00 	movl   $0x807000,-0x3c(%ebp)

		actual_second_list[0] = 0x809000;
  80024c:	c7 45 9c 00 90 80 00 	movl   $0x809000,-0x64(%ebp)
		actual_second_list[1] = 0x803000;
  800253:	c7 45 a0 00 30 80 00 	movl   $0x803000,-0x60(%ebp)
		actual_second_list[2] = 0x80c000;
  80025a:	c7 45 a4 00 c0 80 00 	movl   $0x80c000,-0x5c(%ebp)
		actual_second_list[3] = 0x80b000;
  800261:	c7 45 a8 00 b0 80 00 	movl   $0x80b000,-0x58(%ebp)
		actual_second_list[4] = 0x80a000;
  800268:	c7 45 ac 00 a0 80 00 	movl   $0x80a000,-0x54(%ebp)
		check = sys_check_LRU_lists(actual_active_list, actual_second_list, 6, 5);
  80026f:	6a 05                	push   $0x5
  800271:	6a 06                	push   $0x6
  800273:	8d 45 9c             	lea    -0x64(%ebp),%eax
  800276:	50                   	push   %eax
  800277:	8d 45 b0             	lea    -0x50(%ebp),%eax
  80027a:	50                   	push   %eax
  80027b:	e8 c5 17 00 00       	call   801a45 <sys_check_LRU_lists>
  800280:	83 c4 10             	add    $0x10,%esp
  800283:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		if(check == 0)
  800286:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  80028a:	75 14                	jne    8002a0 <_main+0x268>
			panic("PAGE LRU Lists entry checking failed when a new PAGE FAULT occurred..!!");
  80028c:	83 ec 04             	sub    $0x4,%esp
  80028f:	68 28 1e 80 00       	push   $0x801e28
  800294:	6a 62                	push   $0x62
  800296:	68 50 1d 80 00       	push   $0x801d50
  80029b:	e8 5e 01 00 00       	call   8003fe <_panic>
	}
	cprintf("Congratulations!! test PAGE replacement [LRU Alg. on the 2nd chance list] is completed successfully.\n");
  8002a0:	83 ec 0c             	sub    $0xc,%esp
  8002a3:	68 70 1e 80 00       	push   $0x801e70
  8002a8:	e8 f3 03 00 00       	call   8006a0 <cprintf>
  8002ad:	83 c4 10             	add    $0x10,%esp
	return;
  8002b0:	90                   	nop
}
  8002b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8002b4:	5b                   	pop    %ebx
  8002b5:	5e                   	pop    %esi
  8002b6:	5f                   	pop    %edi
  8002b7:	5d                   	pop    %ebp
  8002b8:	c3                   	ret    

008002b9 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8002b9:	55                   	push   %ebp
  8002ba:	89 e5                	mov    %esp,%ebp
  8002bc:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8002bf:	e8 07 12 00 00       	call   8014cb <sys_getenvindex>
  8002c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8002c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002ca:	89 d0                	mov    %edx,%eax
  8002cc:	c1 e0 03             	shl    $0x3,%eax
  8002cf:	01 d0                	add    %edx,%eax
  8002d1:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8002d8:	01 c8                	add    %ecx,%eax
  8002da:	01 c0                	add    %eax,%eax
  8002dc:	01 d0                	add    %edx,%eax
  8002de:	01 c0                	add    %eax,%eax
  8002e0:	01 d0                	add    %edx,%eax
  8002e2:	89 c2                	mov    %eax,%edx
  8002e4:	c1 e2 05             	shl    $0x5,%edx
  8002e7:	29 c2                	sub    %eax,%edx
  8002e9:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8002f0:	89 c2                	mov    %eax,%edx
  8002f2:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8002f8:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8002fd:	a1 20 30 80 00       	mov    0x803020,%eax
  800302:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800308:	84 c0                	test   %al,%al
  80030a:	74 0f                	je     80031b <libmain+0x62>
		binaryname = myEnv->prog_name;
  80030c:	a1 20 30 80 00       	mov    0x803020,%eax
  800311:	05 40 3c 01 00       	add    $0x13c40,%eax
  800316:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80031b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80031f:	7e 0a                	jle    80032b <libmain+0x72>
		binaryname = argv[0];
  800321:	8b 45 0c             	mov    0xc(%ebp),%eax
  800324:	8b 00                	mov    (%eax),%eax
  800326:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  80032b:	83 ec 08             	sub    $0x8,%esp
  80032e:	ff 75 0c             	pushl  0xc(%ebp)
  800331:	ff 75 08             	pushl  0x8(%ebp)
  800334:	e8 ff fc ff ff       	call   800038 <_main>
  800339:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80033c:	e8 25 13 00 00       	call   801666 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800341:	83 ec 0c             	sub    $0xc,%esp
  800344:	68 48 1f 80 00       	push   $0x801f48
  800349:	e8 52 03 00 00       	call   8006a0 <cprintf>
  80034e:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800351:	a1 20 30 80 00       	mov    0x803020,%eax
  800356:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80035c:	a1 20 30 80 00       	mov    0x803020,%eax
  800361:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800367:	83 ec 04             	sub    $0x4,%esp
  80036a:	52                   	push   %edx
  80036b:	50                   	push   %eax
  80036c:	68 70 1f 80 00       	push   $0x801f70
  800371:	e8 2a 03 00 00       	call   8006a0 <cprintf>
  800376:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800379:	a1 20 30 80 00       	mov    0x803020,%eax
  80037e:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800384:	a1 20 30 80 00       	mov    0x803020,%eax
  800389:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80038f:	83 ec 04             	sub    $0x4,%esp
  800392:	52                   	push   %edx
  800393:	50                   	push   %eax
  800394:	68 98 1f 80 00       	push   $0x801f98
  800399:	e8 02 03 00 00       	call   8006a0 <cprintf>
  80039e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8003a1:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a6:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8003ac:	83 ec 08             	sub    $0x8,%esp
  8003af:	50                   	push   %eax
  8003b0:	68 d9 1f 80 00       	push   $0x801fd9
  8003b5:	e8 e6 02 00 00       	call   8006a0 <cprintf>
  8003ba:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8003bd:	83 ec 0c             	sub    $0xc,%esp
  8003c0:	68 48 1f 80 00       	push   $0x801f48
  8003c5:	e8 d6 02 00 00       	call   8006a0 <cprintf>
  8003ca:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8003cd:	e8 ae 12 00 00       	call   801680 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8003d2:	e8 19 00 00 00       	call   8003f0 <exit>
}
  8003d7:	90                   	nop
  8003d8:	c9                   	leave  
  8003d9:	c3                   	ret    

008003da <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8003da:	55                   	push   %ebp
  8003db:	89 e5                	mov    %esp,%ebp
  8003dd:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8003e0:	83 ec 0c             	sub    $0xc,%esp
  8003e3:	6a 00                	push   $0x0
  8003e5:	e8 ad 10 00 00       	call   801497 <sys_env_destroy>
  8003ea:	83 c4 10             	add    $0x10,%esp
}
  8003ed:	90                   	nop
  8003ee:	c9                   	leave  
  8003ef:	c3                   	ret    

008003f0 <exit>:

void
exit(void)
{
  8003f0:	55                   	push   %ebp
  8003f1:	89 e5                	mov    %esp,%ebp
  8003f3:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8003f6:	e8 02 11 00 00       	call   8014fd <sys_env_exit>
}
  8003fb:	90                   	nop
  8003fc:	c9                   	leave  
  8003fd:	c3                   	ret    

008003fe <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8003fe:	55                   	push   %ebp
  8003ff:	89 e5                	mov    %esp,%ebp
  800401:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800404:	8d 45 10             	lea    0x10(%ebp),%eax
  800407:	83 c0 04             	add    $0x4,%eax
  80040a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80040d:	a1 18 01 81 00       	mov    0x810118,%eax
  800412:	85 c0                	test   %eax,%eax
  800414:	74 16                	je     80042c <_panic+0x2e>
		cprintf("%s: ", argv0);
  800416:	a1 18 01 81 00       	mov    0x810118,%eax
  80041b:	83 ec 08             	sub    $0x8,%esp
  80041e:	50                   	push   %eax
  80041f:	68 f0 1f 80 00       	push   $0x801ff0
  800424:	e8 77 02 00 00       	call   8006a0 <cprintf>
  800429:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80042c:	a1 08 30 80 00       	mov    0x803008,%eax
  800431:	ff 75 0c             	pushl  0xc(%ebp)
  800434:	ff 75 08             	pushl  0x8(%ebp)
  800437:	50                   	push   %eax
  800438:	68 f5 1f 80 00       	push   $0x801ff5
  80043d:	e8 5e 02 00 00       	call   8006a0 <cprintf>
  800442:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800445:	8b 45 10             	mov    0x10(%ebp),%eax
  800448:	83 ec 08             	sub    $0x8,%esp
  80044b:	ff 75 f4             	pushl  -0xc(%ebp)
  80044e:	50                   	push   %eax
  80044f:	e8 e1 01 00 00       	call   800635 <vcprintf>
  800454:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800457:	83 ec 08             	sub    $0x8,%esp
  80045a:	6a 00                	push   $0x0
  80045c:	68 11 20 80 00       	push   $0x802011
  800461:	e8 cf 01 00 00       	call   800635 <vcprintf>
  800466:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800469:	e8 82 ff ff ff       	call   8003f0 <exit>

	// should not return here
	while (1) ;
  80046e:	eb fe                	jmp    80046e <_panic+0x70>

00800470 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800470:	55                   	push   %ebp
  800471:	89 e5                	mov    %esp,%ebp
  800473:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800476:	a1 20 30 80 00       	mov    0x803020,%eax
  80047b:	8b 50 74             	mov    0x74(%eax),%edx
  80047e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800481:	39 c2                	cmp    %eax,%edx
  800483:	74 14                	je     800499 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800485:	83 ec 04             	sub    $0x4,%esp
  800488:	68 14 20 80 00       	push   $0x802014
  80048d:	6a 26                	push   $0x26
  80048f:	68 60 20 80 00       	push   $0x802060
  800494:	e8 65 ff ff ff       	call   8003fe <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800499:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8004a0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8004a7:	e9 b6 00 00 00       	jmp    800562 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8004ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004af:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b9:	01 d0                	add    %edx,%eax
  8004bb:	8b 00                	mov    (%eax),%eax
  8004bd:	85 c0                	test   %eax,%eax
  8004bf:	75 08                	jne    8004c9 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8004c1:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8004c4:	e9 96 00 00 00       	jmp    80055f <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8004c9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004d0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8004d7:	eb 5d                	jmp    800536 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8004d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8004de:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004e4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8004e7:	c1 e2 04             	shl    $0x4,%edx
  8004ea:	01 d0                	add    %edx,%eax
  8004ec:	8a 40 04             	mov    0x4(%eax),%al
  8004ef:	84 c0                	test   %al,%al
  8004f1:	75 40                	jne    800533 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8004f3:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f8:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004fe:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800501:	c1 e2 04             	shl    $0x4,%edx
  800504:	01 d0                	add    %edx,%eax
  800506:	8b 00                	mov    (%eax),%eax
  800508:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80050b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80050e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800513:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800515:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800518:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80051f:	8b 45 08             	mov    0x8(%ebp),%eax
  800522:	01 c8                	add    %ecx,%eax
  800524:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800526:	39 c2                	cmp    %eax,%edx
  800528:	75 09                	jne    800533 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80052a:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800531:	eb 12                	jmp    800545 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800533:	ff 45 e8             	incl   -0x18(%ebp)
  800536:	a1 20 30 80 00       	mov    0x803020,%eax
  80053b:	8b 50 74             	mov    0x74(%eax),%edx
  80053e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800541:	39 c2                	cmp    %eax,%edx
  800543:	77 94                	ja     8004d9 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800545:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800549:	75 14                	jne    80055f <CheckWSWithoutLastIndex+0xef>
			panic(
  80054b:	83 ec 04             	sub    $0x4,%esp
  80054e:	68 6c 20 80 00       	push   $0x80206c
  800553:	6a 3a                	push   $0x3a
  800555:	68 60 20 80 00       	push   $0x802060
  80055a:	e8 9f fe ff ff       	call   8003fe <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80055f:	ff 45 f0             	incl   -0x10(%ebp)
  800562:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800565:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800568:	0f 8c 3e ff ff ff    	jl     8004ac <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80056e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800575:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80057c:	eb 20                	jmp    80059e <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80057e:	a1 20 30 80 00       	mov    0x803020,%eax
  800583:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800589:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80058c:	c1 e2 04             	shl    $0x4,%edx
  80058f:	01 d0                	add    %edx,%eax
  800591:	8a 40 04             	mov    0x4(%eax),%al
  800594:	3c 01                	cmp    $0x1,%al
  800596:	75 03                	jne    80059b <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800598:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80059b:	ff 45 e0             	incl   -0x20(%ebp)
  80059e:	a1 20 30 80 00       	mov    0x803020,%eax
  8005a3:	8b 50 74             	mov    0x74(%eax),%edx
  8005a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005a9:	39 c2                	cmp    %eax,%edx
  8005ab:	77 d1                	ja     80057e <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8005ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005b0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8005b3:	74 14                	je     8005c9 <CheckWSWithoutLastIndex+0x159>
		panic(
  8005b5:	83 ec 04             	sub    $0x4,%esp
  8005b8:	68 c0 20 80 00       	push   $0x8020c0
  8005bd:	6a 44                	push   $0x44
  8005bf:	68 60 20 80 00       	push   $0x802060
  8005c4:	e8 35 fe ff ff       	call   8003fe <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8005c9:	90                   	nop
  8005ca:	c9                   	leave  
  8005cb:	c3                   	ret    

008005cc <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8005cc:	55                   	push   %ebp
  8005cd:	89 e5                	mov    %esp,%ebp
  8005cf:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8005d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005d5:	8b 00                	mov    (%eax),%eax
  8005d7:	8d 48 01             	lea    0x1(%eax),%ecx
  8005da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005dd:	89 0a                	mov    %ecx,(%edx)
  8005df:	8b 55 08             	mov    0x8(%ebp),%edx
  8005e2:	88 d1                	mov    %dl,%cl
  8005e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005e7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8005eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ee:	8b 00                	mov    (%eax),%eax
  8005f0:	3d ff 00 00 00       	cmp    $0xff,%eax
  8005f5:	75 2c                	jne    800623 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8005f7:	a0 24 30 80 00       	mov    0x803024,%al
  8005fc:	0f b6 c0             	movzbl %al,%eax
  8005ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  800602:	8b 12                	mov    (%edx),%edx
  800604:	89 d1                	mov    %edx,%ecx
  800606:	8b 55 0c             	mov    0xc(%ebp),%edx
  800609:	83 c2 08             	add    $0x8,%edx
  80060c:	83 ec 04             	sub    $0x4,%esp
  80060f:	50                   	push   %eax
  800610:	51                   	push   %ecx
  800611:	52                   	push   %edx
  800612:	e8 3e 0e 00 00       	call   801455 <sys_cputs>
  800617:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80061a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80061d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800623:	8b 45 0c             	mov    0xc(%ebp),%eax
  800626:	8b 40 04             	mov    0x4(%eax),%eax
  800629:	8d 50 01             	lea    0x1(%eax),%edx
  80062c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80062f:	89 50 04             	mov    %edx,0x4(%eax)
}
  800632:	90                   	nop
  800633:	c9                   	leave  
  800634:	c3                   	ret    

00800635 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800635:	55                   	push   %ebp
  800636:	89 e5                	mov    %esp,%ebp
  800638:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80063e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800645:	00 00 00 
	b.cnt = 0;
  800648:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80064f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800652:	ff 75 0c             	pushl  0xc(%ebp)
  800655:	ff 75 08             	pushl  0x8(%ebp)
  800658:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80065e:	50                   	push   %eax
  80065f:	68 cc 05 80 00       	push   $0x8005cc
  800664:	e8 11 02 00 00       	call   80087a <vprintfmt>
  800669:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80066c:	a0 24 30 80 00       	mov    0x803024,%al
  800671:	0f b6 c0             	movzbl %al,%eax
  800674:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80067a:	83 ec 04             	sub    $0x4,%esp
  80067d:	50                   	push   %eax
  80067e:	52                   	push   %edx
  80067f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800685:	83 c0 08             	add    $0x8,%eax
  800688:	50                   	push   %eax
  800689:	e8 c7 0d 00 00       	call   801455 <sys_cputs>
  80068e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800691:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800698:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80069e:	c9                   	leave  
  80069f:	c3                   	ret    

008006a0 <cprintf>:

int cprintf(const char *fmt, ...) {
  8006a0:	55                   	push   %ebp
  8006a1:	89 e5                	mov    %esp,%ebp
  8006a3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8006a6:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8006ad:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b6:	83 ec 08             	sub    $0x8,%esp
  8006b9:	ff 75 f4             	pushl  -0xc(%ebp)
  8006bc:	50                   	push   %eax
  8006bd:	e8 73 ff ff ff       	call   800635 <vcprintf>
  8006c2:	83 c4 10             	add    $0x10,%esp
  8006c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8006c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006cb:	c9                   	leave  
  8006cc:	c3                   	ret    

008006cd <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8006cd:	55                   	push   %ebp
  8006ce:	89 e5                	mov    %esp,%ebp
  8006d0:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8006d3:	e8 8e 0f 00 00       	call   801666 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8006d8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006db:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006de:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e1:	83 ec 08             	sub    $0x8,%esp
  8006e4:	ff 75 f4             	pushl  -0xc(%ebp)
  8006e7:	50                   	push   %eax
  8006e8:	e8 48 ff ff ff       	call   800635 <vcprintf>
  8006ed:	83 c4 10             	add    $0x10,%esp
  8006f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8006f3:	e8 88 0f 00 00       	call   801680 <sys_enable_interrupt>
	return cnt;
  8006f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006fb:	c9                   	leave  
  8006fc:	c3                   	ret    

008006fd <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8006fd:	55                   	push   %ebp
  8006fe:	89 e5                	mov    %esp,%ebp
  800700:	53                   	push   %ebx
  800701:	83 ec 14             	sub    $0x14,%esp
  800704:	8b 45 10             	mov    0x10(%ebp),%eax
  800707:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80070a:	8b 45 14             	mov    0x14(%ebp),%eax
  80070d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800710:	8b 45 18             	mov    0x18(%ebp),%eax
  800713:	ba 00 00 00 00       	mov    $0x0,%edx
  800718:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80071b:	77 55                	ja     800772 <printnum+0x75>
  80071d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800720:	72 05                	jb     800727 <printnum+0x2a>
  800722:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800725:	77 4b                	ja     800772 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800727:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80072a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80072d:	8b 45 18             	mov    0x18(%ebp),%eax
  800730:	ba 00 00 00 00       	mov    $0x0,%edx
  800735:	52                   	push   %edx
  800736:	50                   	push   %eax
  800737:	ff 75 f4             	pushl  -0xc(%ebp)
  80073a:	ff 75 f0             	pushl  -0x10(%ebp)
  80073d:	e8 46 13 00 00       	call   801a88 <__udivdi3>
  800742:	83 c4 10             	add    $0x10,%esp
  800745:	83 ec 04             	sub    $0x4,%esp
  800748:	ff 75 20             	pushl  0x20(%ebp)
  80074b:	53                   	push   %ebx
  80074c:	ff 75 18             	pushl  0x18(%ebp)
  80074f:	52                   	push   %edx
  800750:	50                   	push   %eax
  800751:	ff 75 0c             	pushl  0xc(%ebp)
  800754:	ff 75 08             	pushl  0x8(%ebp)
  800757:	e8 a1 ff ff ff       	call   8006fd <printnum>
  80075c:	83 c4 20             	add    $0x20,%esp
  80075f:	eb 1a                	jmp    80077b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800761:	83 ec 08             	sub    $0x8,%esp
  800764:	ff 75 0c             	pushl  0xc(%ebp)
  800767:	ff 75 20             	pushl  0x20(%ebp)
  80076a:	8b 45 08             	mov    0x8(%ebp),%eax
  80076d:	ff d0                	call   *%eax
  80076f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800772:	ff 4d 1c             	decl   0x1c(%ebp)
  800775:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800779:	7f e6                	jg     800761 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80077b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80077e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800783:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800786:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800789:	53                   	push   %ebx
  80078a:	51                   	push   %ecx
  80078b:	52                   	push   %edx
  80078c:	50                   	push   %eax
  80078d:	e8 06 14 00 00       	call   801b98 <__umoddi3>
  800792:	83 c4 10             	add    $0x10,%esp
  800795:	05 34 23 80 00       	add    $0x802334,%eax
  80079a:	8a 00                	mov    (%eax),%al
  80079c:	0f be c0             	movsbl %al,%eax
  80079f:	83 ec 08             	sub    $0x8,%esp
  8007a2:	ff 75 0c             	pushl  0xc(%ebp)
  8007a5:	50                   	push   %eax
  8007a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a9:	ff d0                	call   *%eax
  8007ab:	83 c4 10             	add    $0x10,%esp
}
  8007ae:	90                   	nop
  8007af:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8007b2:	c9                   	leave  
  8007b3:	c3                   	ret    

008007b4 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8007b4:	55                   	push   %ebp
  8007b5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007b7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007bb:	7e 1c                	jle    8007d9 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8007bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c0:	8b 00                	mov    (%eax),%eax
  8007c2:	8d 50 08             	lea    0x8(%eax),%edx
  8007c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c8:	89 10                	mov    %edx,(%eax)
  8007ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cd:	8b 00                	mov    (%eax),%eax
  8007cf:	83 e8 08             	sub    $0x8,%eax
  8007d2:	8b 50 04             	mov    0x4(%eax),%edx
  8007d5:	8b 00                	mov    (%eax),%eax
  8007d7:	eb 40                	jmp    800819 <getuint+0x65>
	else if (lflag)
  8007d9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007dd:	74 1e                	je     8007fd <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8007df:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e2:	8b 00                	mov    (%eax),%eax
  8007e4:	8d 50 04             	lea    0x4(%eax),%edx
  8007e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ea:	89 10                	mov    %edx,(%eax)
  8007ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ef:	8b 00                	mov    (%eax),%eax
  8007f1:	83 e8 04             	sub    $0x4,%eax
  8007f4:	8b 00                	mov    (%eax),%eax
  8007f6:	ba 00 00 00 00       	mov    $0x0,%edx
  8007fb:	eb 1c                	jmp    800819 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8007fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800800:	8b 00                	mov    (%eax),%eax
  800802:	8d 50 04             	lea    0x4(%eax),%edx
  800805:	8b 45 08             	mov    0x8(%ebp),%eax
  800808:	89 10                	mov    %edx,(%eax)
  80080a:	8b 45 08             	mov    0x8(%ebp),%eax
  80080d:	8b 00                	mov    (%eax),%eax
  80080f:	83 e8 04             	sub    $0x4,%eax
  800812:	8b 00                	mov    (%eax),%eax
  800814:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800819:	5d                   	pop    %ebp
  80081a:	c3                   	ret    

0080081b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80081b:	55                   	push   %ebp
  80081c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80081e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800822:	7e 1c                	jle    800840 <getint+0x25>
		return va_arg(*ap, long long);
  800824:	8b 45 08             	mov    0x8(%ebp),%eax
  800827:	8b 00                	mov    (%eax),%eax
  800829:	8d 50 08             	lea    0x8(%eax),%edx
  80082c:	8b 45 08             	mov    0x8(%ebp),%eax
  80082f:	89 10                	mov    %edx,(%eax)
  800831:	8b 45 08             	mov    0x8(%ebp),%eax
  800834:	8b 00                	mov    (%eax),%eax
  800836:	83 e8 08             	sub    $0x8,%eax
  800839:	8b 50 04             	mov    0x4(%eax),%edx
  80083c:	8b 00                	mov    (%eax),%eax
  80083e:	eb 38                	jmp    800878 <getint+0x5d>
	else if (lflag)
  800840:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800844:	74 1a                	je     800860 <getint+0x45>
		return va_arg(*ap, long);
  800846:	8b 45 08             	mov    0x8(%ebp),%eax
  800849:	8b 00                	mov    (%eax),%eax
  80084b:	8d 50 04             	lea    0x4(%eax),%edx
  80084e:	8b 45 08             	mov    0x8(%ebp),%eax
  800851:	89 10                	mov    %edx,(%eax)
  800853:	8b 45 08             	mov    0x8(%ebp),%eax
  800856:	8b 00                	mov    (%eax),%eax
  800858:	83 e8 04             	sub    $0x4,%eax
  80085b:	8b 00                	mov    (%eax),%eax
  80085d:	99                   	cltd   
  80085e:	eb 18                	jmp    800878 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800860:	8b 45 08             	mov    0x8(%ebp),%eax
  800863:	8b 00                	mov    (%eax),%eax
  800865:	8d 50 04             	lea    0x4(%eax),%edx
  800868:	8b 45 08             	mov    0x8(%ebp),%eax
  80086b:	89 10                	mov    %edx,(%eax)
  80086d:	8b 45 08             	mov    0x8(%ebp),%eax
  800870:	8b 00                	mov    (%eax),%eax
  800872:	83 e8 04             	sub    $0x4,%eax
  800875:	8b 00                	mov    (%eax),%eax
  800877:	99                   	cltd   
}
  800878:	5d                   	pop    %ebp
  800879:	c3                   	ret    

0080087a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80087a:	55                   	push   %ebp
  80087b:	89 e5                	mov    %esp,%ebp
  80087d:	56                   	push   %esi
  80087e:	53                   	push   %ebx
  80087f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800882:	eb 17                	jmp    80089b <vprintfmt+0x21>
			if (ch == '\0')
  800884:	85 db                	test   %ebx,%ebx
  800886:	0f 84 af 03 00 00    	je     800c3b <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80088c:	83 ec 08             	sub    $0x8,%esp
  80088f:	ff 75 0c             	pushl  0xc(%ebp)
  800892:	53                   	push   %ebx
  800893:	8b 45 08             	mov    0x8(%ebp),%eax
  800896:	ff d0                	call   *%eax
  800898:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80089b:	8b 45 10             	mov    0x10(%ebp),%eax
  80089e:	8d 50 01             	lea    0x1(%eax),%edx
  8008a1:	89 55 10             	mov    %edx,0x10(%ebp)
  8008a4:	8a 00                	mov    (%eax),%al
  8008a6:	0f b6 d8             	movzbl %al,%ebx
  8008a9:	83 fb 25             	cmp    $0x25,%ebx
  8008ac:	75 d6                	jne    800884 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8008ae:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8008b2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8008b9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8008c0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8008c7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8008ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8008d1:	8d 50 01             	lea    0x1(%eax),%edx
  8008d4:	89 55 10             	mov    %edx,0x10(%ebp)
  8008d7:	8a 00                	mov    (%eax),%al
  8008d9:	0f b6 d8             	movzbl %al,%ebx
  8008dc:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8008df:	83 f8 55             	cmp    $0x55,%eax
  8008e2:	0f 87 2b 03 00 00    	ja     800c13 <vprintfmt+0x399>
  8008e8:	8b 04 85 58 23 80 00 	mov    0x802358(,%eax,4),%eax
  8008ef:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8008f1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8008f5:	eb d7                	jmp    8008ce <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8008f7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8008fb:	eb d1                	jmp    8008ce <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8008fd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800904:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800907:	89 d0                	mov    %edx,%eax
  800909:	c1 e0 02             	shl    $0x2,%eax
  80090c:	01 d0                	add    %edx,%eax
  80090e:	01 c0                	add    %eax,%eax
  800910:	01 d8                	add    %ebx,%eax
  800912:	83 e8 30             	sub    $0x30,%eax
  800915:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800918:	8b 45 10             	mov    0x10(%ebp),%eax
  80091b:	8a 00                	mov    (%eax),%al
  80091d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800920:	83 fb 2f             	cmp    $0x2f,%ebx
  800923:	7e 3e                	jle    800963 <vprintfmt+0xe9>
  800925:	83 fb 39             	cmp    $0x39,%ebx
  800928:	7f 39                	jg     800963 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80092a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80092d:	eb d5                	jmp    800904 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80092f:	8b 45 14             	mov    0x14(%ebp),%eax
  800932:	83 c0 04             	add    $0x4,%eax
  800935:	89 45 14             	mov    %eax,0x14(%ebp)
  800938:	8b 45 14             	mov    0x14(%ebp),%eax
  80093b:	83 e8 04             	sub    $0x4,%eax
  80093e:	8b 00                	mov    (%eax),%eax
  800940:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800943:	eb 1f                	jmp    800964 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800945:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800949:	79 83                	jns    8008ce <vprintfmt+0x54>
				width = 0;
  80094b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800952:	e9 77 ff ff ff       	jmp    8008ce <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800957:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80095e:	e9 6b ff ff ff       	jmp    8008ce <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800963:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800964:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800968:	0f 89 60 ff ff ff    	jns    8008ce <vprintfmt+0x54>
				width = precision, precision = -1;
  80096e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800971:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800974:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80097b:	e9 4e ff ff ff       	jmp    8008ce <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800980:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800983:	e9 46 ff ff ff       	jmp    8008ce <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800988:	8b 45 14             	mov    0x14(%ebp),%eax
  80098b:	83 c0 04             	add    $0x4,%eax
  80098e:	89 45 14             	mov    %eax,0x14(%ebp)
  800991:	8b 45 14             	mov    0x14(%ebp),%eax
  800994:	83 e8 04             	sub    $0x4,%eax
  800997:	8b 00                	mov    (%eax),%eax
  800999:	83 ec 08             	sub    $0x8,%esp
  80099c:	ff 75 0c             	pushl  0xc(%ebp)
  80099f:	50                   	push   %eax
  8009a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a3:	ff d0                	call   *%eax
  8009a5:	83 c4 10             	add    $0x10,%esp
			break;
  8009a8:	e9 89 02 00 00       	jmp    800c36 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8009ad:	8b 45 14             	mov    0x14(%ebp),%eax
  8009b0:	83 c0 04             	add    $0x4,%eax
  8009b3:	89 45 14             	mov    %eax,0x14(%ebp)
  8009b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8009b9:	83 e8 04             	sub    $0x4,%eax
  8009bc:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8009be:	85 db                	test   %ebx,%ebx
  8009c0:	79 02                	jns    8009c4 <vprintfmt+0x14a>
				err = -err;
  8009c2:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8009c4:	83 fb 64             	cmp    $0x64,%ebx
  8009c7:	7f 0b                	jg     8009d4 <vprintfmt+0x15a>
  8009c9:	8b 34 9d a0 21 80 00 	mov    0x8021a0(,%ebx,4),%esi
  8009d0:	85 f6                	test   %esi,%esi
  8009d2:	75 19                	jne    8009ed <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8009d4:	53                   	push   %ebx
  8009d5:	68 45 23 80 00       	push   $0x802345
  8009da:	ff 75 0c             	pushl  0xc(%ebp)
  8009dd:	ff 75 08             	pushl  0x8(%ebp)
  8009e0:	e8 5e 02 00 00       	call   800c43 <printfmt>
  8009e5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8009e8:	e9 49 02 00 00       	jmp    800c36 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8009ed:	56                   	push   %esi
  8009ee:	68 4e 23 80 00       	push   $0x80234e
  8009f3:	ff 75 0c             	pushl  0xc(%ebp)
  8009f6:	ff 75 08             	pushl  0x8(%ebp)
  8009f9:	e8 45 02 00 00       	call   800c43 <printfmt>
  8009fe:	83 c4 10             	add    $0x10,%esp
			break;
  800a01:	e9 30 02 00 00       	jmp    800c36 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a06:	8b 45 14             	mov    0x14(%ebp),%eax
  800a09:	83 c0 04             	add    $0x4,%eax
  800a0c:	89 45 14             	mov    %eax,0x14(%ebp)
  800a0f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a12:	83 e8 04             	sub    $0x4,%eax
  800a15:	8b 30                	mov    (%eax),%esi
  800a17:	85 f6                	test   %esi,%esi
  800a19:	75 05                	jne    800a20 <vprintfmt+0x1a6>
				p = "(null)";
  800a1b:	be 51 23 80 00       	mov    $0x802351,%esi
			if (width > 0 && padc != '-')
  800a20:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a24:	7e 6d                	jle    800a93 <vprintfmt+0x219>
  800a26:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a2a:	74 67                	je     800a93 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a2c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a2f:	83 ec 08             	sub    $0x8,%esp
  800a32:	50                   	push   %eax
  800a33:	56                   	push   %esi
  800a34:	e8 0c 03 00 00       	call   800d45 <strnlen>
  800a39:	83 c4 10             	add    $0x10,%esp
  800a3c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a3f:	eb 16                	jmp    800a57 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a41:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a45:	83 ec 08             	sub    $0x8,%esp
  800a48:	ff 75 0c             	pushl  0xc(%ebp)
  800a4b:	50                   	push   %eax
  800a4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4f:	ff d0                	call   *%eax
  800a51:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a54:	ff 4d e4             	decl   -0x1c(%ebp)
  800a57:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a5b:	7f e4                	jg     800a41 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a5d:	eb 34                	jmp    800a93 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a5f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a63:	74 1c                	je     800a81 <vprintfmt+0x207>
  800a65:	83 fb 1f             	cmp    $0x1f,%ebx
  800a68:	7e 05                	jle    800a6f <vprintfmt+0x1f5>
  800a6a:	83 fb 7e             	cmp    $0x7e,%ebx
  800a6d:	7e 12                	jle    800a81 <vprintfmt+0x207>
					putch('?', putdat);
  800a6f:	83 ec 08             	sub    $0x8,%esp
  800a72:	ff 75 0c             	pushl  0xc(%ebp)
  800a75:	6a 3f                	push   $0x3f
  800a77:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7a:	ff d0                	call   *%eax
  800a7c:	83 c4 10             	add    $0x10,%esp
  800a7f:	eb 0f                	jmp    800a90 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800a81:	83 ec 08             	sub    $0x8,%esp
  800a84:	ff 75 0c             	pushl  0xc(%ebp)
  800a87:	53                   	push   %ebx
  800a88:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8b:	ff d0                	call   *%eax
  800a8d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a90:	ff 4d e4             	decl   -0x1c(%ebp)
  800a93:	89 f0                	mov    %esi,%eax
  800a95:	8d 70 01             	lea    0x1(%eax),%esi
  800a98:	8a 00                	mov    (%eax),%al
  800a9a:	0f be d8             	movsbl %al,%ebx
  800a9d:	85 db                	test   %ebx,%ebx
  800a9f:	74 24                	je     800ac5 <vprintfmt+0x24b>
  800aa1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800aa5:	78 b8                	js     800a5f <vprintfmt+0x1e5>
  800aa7:	ff 4d e0             	decl   -0x20(%ebp)
  800aaa:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800aae:	79 af                	jns    800a5f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ab0:	eb 13                	jmp    800ac5 <vprintfmt+0x24b>
				putch(' ', putdat);
  800ab2:	83 ec 08             	sub    $0x8,%esp
  800ab5:	ff 75 0c             	pushl  0xc(%ebp)
  800ab8:	6a 20                	push   $0x20
  800aba:	8b 45 08             	mov    0x8(%ebp),%eax
  800abd:	ff d0                	call   *%eax
  800abf:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ac2:	ff 4d e4             	decl   -0x1c(%ebp)
  800ac5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ac9:	7f e7                	jg     800ab2 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800acb:	e9 66 01 00 00       	jmp    800c36 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ad0:	83 ec 08             	sub    $0x8,%esp
  800ad3:	ff 75 e8             	pushl  -0x18(%ebp)
  800ad6:	8d 45 14             	lea    0x14(%ebp),%eax
  800ad9:	50                   	push   %eax
  800ada:	e8 3c fd ff ff       	call   80081b <getint>
  800adf:	83 c4 10             	add    $0x10,%esp
  800ae2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ae5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ae8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aeb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800aee:	85 d2                	test   %edx,%edx
  800af0:	79 23                	jns    800b15 <vprintfmt+0x29b>
				putch('-', putdat);
  800af2:	83 ec 08             	sub    $0x8,%esp
  800af5:	ff 75 0c             	pushl  0xc(%ebp)
  800af8:	6a 2d                	push   $0x2d
  800afa:	8b 45 08             	mov    0x8(%ebp),%eax
  800afd:	ff d0                	call   *%eax
  800aff:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b02:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b05:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b08:	f7 d8                	neg    %eax
  800b0a:	83 d2 00             	adc    $0x0,%edx
  800b0d:	f7 da                	neg    %edx
  800b0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b12:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b15:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b1c:	e9 bc 00 00 00       	jmp    800bdd <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b21:	83 ec 08             	sub    $0x8,%esp
  800b24:	ff 75 e8             	pushl  -0x18(%ebp)
  800b27:	8d 45 14             	lea    0x14(%ebp),%eax
  800b2a:	50                   	push   %eax
  800b2b:	e8 84 fc ff ff       	call   8007b4 <getuint>
  800b30:	83 c4 10             	add    $0x10,%esp
  800b33:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b36:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b39:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b40:	e9 98 00 00 00       	jmp    800bdd <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b45:	83 ec 08             	sub    $0x8,%esp
  800b48:	ff 75 0c             	pushl  0xc(%ebp)
  800b4b:	6a 58                	push   $0x58
  800b4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b50:	ff d0                	call   *%eax
  800b52:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b55:	83 ec 08             	sub    $0x8,%esp
  800b58:	ff 75 0c             	pushl  0xc(%ebp)
  800b5b:	6a 58                	push   $0x58
  800b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b60:	ff d0                	call   *%eax
  800b62:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b65:	83 ec 08             	sub    $0x8,%esp
  800b68:	ff 75 0c             	pushl  0xc(%ebp)
  800b6b:	6a 58                	push   $0x58
  800b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b70:	ff d0                	call   *%eax
  800b72:	83 c4 10             	add    $0x10,%esp
			break;
  800b75:	e9 bc 00 00 00       	jmp    800c36 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b7a:	83 ec 08             	sub    $0x8,%esp
  800b7d:	ff 75 0c             	pushl  0xc(%ebp)
  800b80:	6a 30                	push   $0x30
  800b82:	8b 45 08             	mov    0x8(%ebp),%eax
  800b85:	ff d0                	call   *%eax
  800b87:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800b8a:	83 ec 08             	sub    $0x8,%esp
  800b8d:	ff 75 0c             	pushl  0xc(%ebp)
  800b90:	6a 78                	push   $0x78
  800b92:	8b 45 08             	mov    0x8(%ebp),%eax
  800b95:	ff d0                	call   *%eax
  800b97:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800b9a:	8b 45 14             	mov    0x14(%ebp),%eax
  800b9d:	83 c0 04             	add    $0x4,%eax
  800ba0:	89 45 14             	mov    %eax,0x14(%ebp)
  800ba3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ba6:	83 e8 04             	sub    $0x4,%eax
  800ba9:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800bab:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800bb5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800bbc:	eb 1f                	jmp    800bdd <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800bbe:	83 ec 08             	sub    $0x8,%esp
  800bc1:	ff 75 e8             	pushl  -0x18(%ebp)
  800bc4:	8d 45 14             	lea    0x14(%ebp),%eax
  800bc7:	50                   	push   %eax
  800bc8:	e8 e7 fb ff ff       	call   8007b4 <getuint>
  800bcd:	83 c4 10             	add    $0x10,%esp
  800bd0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bd3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800bd6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800bdd:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800be1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800be4:	83 ec 04             	sub    $0x4,%esp
  800be7:	52                   	push   %edx
  800be8:	ff 75 e4             	pushl  -0x1c(%ebp)
  800beb:	50                   	push   %eax
  800bec:	ff 75 f4             	pushl  -0xc(%ebp)
  800bef:	ff 75 f0             	pushl  -0x10(%ebp)
  800bf2:	ff 75 0c             	pushl  0xc(%ebp)
  800bf5:	ff 75 08             	pushl  0x8(%ebp)
  800bf8:	e8 00 fb ff ff       	call   8006fd <printnum>
  800bfd:	83 c4 20             	add    $0x20,%esp
			break;
  800c00:	eb 34                	jmp    800c36 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c02:	83 ec 08             	sub    $0x8,%esp
  800c05:	ff 75 0c             	pushl  0xc(%ebp)
  800c08:	53                   	push   %ebx
  800c09:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0c:	ff d0                	call   *%eax
  800c0e:	83 c4 10             	add    $0x10,%esp
			break;
  800c11:	eb 23                	jmp    800c36 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c13:	83 ec 08             	sub    $0x8,%esp
  800c16:	ff 75 0c             	pushl  0xc(%ebp)
  800c19:	6a 25                	push   $0x25
  800c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1e:	ff d0                	call   *%eax
  800c20:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c23:	ff 4d 10             	decl   0x10(%ebp)
  800c26:	eb 03                	jmp    800c2b <vprintfmt+0x3b1>
  800c28:	ff 4d 10             	decl   0x10(%ebp)
  800c2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c2e:	48                   	dec    %eax
  800c2f:	8a 00                	mov    (%eax),%al
  800c31:	3c 25                	cmp    $0x25,%al
  800c33:	75 f3                	jne    800c28 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c35:	90                   	nop
		}
	}
  800c36:	e9 47 fc ff ff       	jmp    800882 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c3b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c3c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c3f:	5b                   	pop    %ebx
  800c40:	5e                   	pop    %esi
  800c41:	5d                   	pop    %ebp
  800c42:	c3                   	ret    

00800c43 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c43:	55                   	push   %ebp
  800c44:	89 e5                	mov    %esp,%ebp
  800c46:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c49:	8d 45 10             	lea    0x10(%ebp),%eax
  800c4c:	83 c0 04             	add    $0x4,%eax
  800c4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c52:	8b 45 10             	mov    0x10(%ebp),%eax
  800c55:	ff 75 f4             	pushl  -0xc(%ebp)
  800c58:	50                   	push   %eax
  800c59:	ff 75 0c             	pushl  0xc(%ebp)
  800c5c:	ff 75 08             	pushl  0x8(%ebp)
  800c5f:	e8 16 fc ff ff       	call   80087a <vprintfmt>
  800c64:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c67:	90                   	nop
  800c68:	c9                   	leave  
  800c69:	c3                   	ret    

00800c6a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c6a:	55                   	push   %ebp
  800c6b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c70:	8b 40 08             	mov    0x8(%eax),%eax
  800c73:	8d 50 01             	lea    0x1(%eax),%edx
  800c76:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c79:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7f:	8b 10                	mov    (%eax),%edx
  800c81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c84:	8b 40 04             	mov    0x4(%eax),%eax
  800c87:	39 c2                	cmp    %eax,%edx
  800c89:	73 12                	jae    800c9d <sprintputch+0x33>
		*b->buf++ = ch;
  800c8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8e:	8b 00                	mov    (%eax),%eax
  800c90:	8d 48 01             	lea    0x1(%eax),%ecx
  800c93:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c96:	89 0a                	mov    %ecx,(%edx)
  800c98:	8b 55 08             	mov    0x8(%ebp),%edx
  800c9b:	88 10                	mov    %dl,(%eax)
}
  800c9d:	90                   	nop
  800c9e:	5d                   	pop    %ebp
  800c9f:	c3                   	ret    

00800ca0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800ca0:	55                   	push   %ebp
  800ca1:	89 e5                	mov    %esp,%ebp
  800ca3:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800cac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800caf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb5:	01 d0                	add    %edx,%eax
  800cb7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800cc1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800cc5:	74 06                	je     800ccd <vsnprintf+0x2d>
  800cc7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ccb:	7f 07                	jg     800cd4 <vsnprintf+0x34>
		return -E_INVAL;
  800ccd:	b8 03 00 00 00       	mov    $0x3,%eax
  800cd2:	eb 20                	jmp    800cf4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800cd4:	ff 75 14             	pushl  0x14(%ebp)
  800cd7:	ff 75 10             	pushl  0x10(%ebp)
  800cda:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800cdd:	50                   	push   %eax
  800cde:	68 6a 0c 80 00       	push   $0x800c6a
  800ce3:	e8 92 fb ff ff       	call   80087a <vprintfmt>
  800ce8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ceb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800cee:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800cf1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800cf4:	c9                   	leave  
  800cf5:	c3                   	ret    

00800cf6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800cf6:	55                   	push   %ebp
  800cf7:	89 e5                	mov    %esp,%ebp
  800cf9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800cfc:	8d 45 10             	lea    0x10(%ebp),%eax
  800cff:	83 c0 04             	add    $0x4,%eax
  800d02:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d05:	8b 45 10             	mov    0x10(%ebp),%eax
  800d08:	ff 75 f4             	pushl  -0xc(%ebp)
  800d0b:	50                   	push   %eax
  800d0c:	ff 75 0c             	pushl  0xc(%ebp)
  800d0f:	ff 75 08             	pushl  0x8(%ebp)
  800d12:	e8 89 ff ff ff       	call   800ca0 <vsnprintf>
  800d17:	83 c4 10             	add    $0x10,%esp
  800d1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d20:	c9                   	leave  
  800d21:	c3                   	ret    

00800d22 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d22:	55                   	push   %ebp
  800d23:	89 e5                	mov    %esp,%ebp
  800d25:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d28:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d2f:	eb 06                	jmp    800d37 <strlen+0x15>
		n++;
  800d31:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d34:	ff 45 08             	incl   0x8(%ebp)
  800d37:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3a:	8a 00                	mov    (%eax),%al
  800d3c:	84 c0                	test   %al,%al
  800d3e:	75 f1                	jne    800d31 <strlen+0xf>
		n++;
	return n;
  800d40:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d43:	c9                   	leave  
  800d44:	c3                   	ret    

00800d45 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d45:	55                   	push   %ebp
  800d46:	89 e5                	mov    %esp,%ebp
  800d48:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d4b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d52:	eb 09                	jmp    800d5d <strnlen+0x18>
		n++;
  800d54:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d57:	ff 45 08             	incl   0x8(%ebp)
  800d5a:	ff 4d 0c             	decl   0xc(%ebp)
  800d5d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d61:	74 09                	je     800d6c <strnlen+0x27>
  800d63:	8b 45 08             	mov    0x8(%ebp),%eax
  800d66:	8a 00                	mov    (%eax),%al
  800d68:	84 c0                	test   %al,%al
  800d6a:	75 e8                	jne    800d54 <strnlen+0xf>
		n++;
	return n;
  800d6c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d6f:	c9                   	leave  
  800d70:	c3                   	ret    

00800d71 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d71:	55                   	push   %ebp
  800d72:	89 e5                	mov    %esp,%ebp
  800d74:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d77:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d7d:	90                   	nop
  800d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d81:	8d 50 01             	lea    0x1(%eax),%edx
  800d84:	89 55 08             	mov    %edx,0x8(%ebp)
  800d87:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d8a:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d8d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d90:	8a 12                	mov    (%edx),%dl
  800d92:	88 10                	mov    %dl,(%eax)
  800d94:	8a 00                	mov    (%eax),%al
  800d96:	84 c0                	test   %al,%al
  800d98:	75 e4                	jne    800d7e <strcpy+0xd>
		/* do nothing */;
	return ret;
  800d9a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d9d:	c9                   	leave  
  800d9e:	c3                   	ret    

00800d9f <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800d9f:	55                   	push   %ebp
  800da0:	89 e5                	mov    %esp,%ebp
  800da2:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800da5:	8b 45 08             	mov    0x8(%ebp),%eax
  800da8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800dab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800db2:	eb 1f                	jmp    800dd3 <strncpy+0x34>
		*dst++ = *src;
  800db4:	8b 45 08             	mov    0x8(%ebp),%eax
  800db7:	8d 50 01             	lea    0x1(%eax),%edx
  800dba:	89 55 08             	mov    %edx,0x8(%ebp)
  800dbd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dc0:	8a 12                	mov    (%edx),%dl
  800dc2:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800dc4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc7:	8a 00                	mov    (%eax),%al
  800dc9:	84 c0                	test   %al,%al
  800dcb:	74 03                	je     800dd0 <strncpy+0x31>
			src++;
  800dcd:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800dd0:	ff 45 fc             	incl   -0x4(%ebp)
  800dd3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dd6:	3b 45 10             	cmp    0x10(%ebp),%eax
  800dd9:	72 d9                	jb     800db4 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800ddb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dde:	c9                   	leave  
  800ddf:	c3                   	ret    

00800de0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800de0:	55                   	push   %ebp
  800de1:	89 e5                	mov    %esp,%ebp
  800de3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800de6:	8b 45 08             	mov    0x8(%ebp),%eax
  800de9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800dec:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800df0:	74 30                	je     800e22 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800df2:	eb 16                	jmp    800e0a <strlcpy+0x2a>
			*dst++ = *src++;
  800df4:	8b 45 08             	mov    0x8(%ebp),%eax
  800df7:	8d 50 01             	lea    0x1(%eax),%edx
  800dfa:	89 55 08             	mov    %edx,0x8(%ebp)
  800dfd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e00:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e03:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e06:	8a 12                	mov    (%edx),%dl
  800e08:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e0a:	ff 4d 10             	decl   0x10(%ebp)
  800e0d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e11:	74 09                	je     800e1c <strlcpy+0x3c>
  800e13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e16:	8a 00                	mov    (%eax),%al
  800e18:	84 c0                	test   %al,%al
  800e1a:	75 d8                	jne    800df4 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e22:	8b 55 08             	mov    0x8(%ebp),%edx
  800e25:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e28:	29 c2                	sub    %eax,%edx
  800e2a:	89 d0                	mov    %edx,%eax
}
  800e2c:	c9                   	leave  
  800e2d:	c3                   	ret    

00800e2e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e2e:	55                   	push   %ebp
  800e2f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e31:	eb 06                	jmp    800e39 <strcmp+0xb>
		p++, q++;
  800e33:	ff 45 08             	incl   0x8(%ebp)
  800e36:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e39:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3c:	8a 00                	mov    (%eax),%al
  800e3e:	84 c0                	test   %al,%al
  800e40:	74 0e                	je     800e50 <strcmp+0x22>
  800e42:	8b 45 08             	mov    0x8(%ebp),%eax
  800e45:	8a 10                	mov    (%eax),%dl
  800e47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e4a:	8a 00                	mov    (%eax),%al
  800e4c:	38 c2                	cmp    %al,%dl
  800e4e:	74 e3                	je     800e33 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e50:	8b 45 08             	mov    0x8(%ebp),%eax
  800e53:	8a 00                	mov    (%eax),%al
  800e55:	0f b6 d0             	movzbl %al,%edx
  800e58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5b:	8a 00                	mov    (%eax),%al
  800e5d:	0f b6 c0             	movzbl %al,%eax
  800e60:	29 c2                	sub    %eax,%edx
  800e62:	89 d0                	mov    %edx,%eax
}
  800e64:	5d                   	pop    %ebp
  800e65:	c3                   	ret    

00800e66 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e66:	55                   	push   %ebp
  800e67:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e69:	eb 09                	jmp    800e74 <strncmp+0xe>
		n--, p++, q++;
  800e6b:	ff 4d 10             	decl   0x10(%ebp)
  800e6e:	ff 45 08             	incl   0x8(%ebp)
  800e71:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e74:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e78:	74 17                	je     800e91 <strncmp+0x2b>
  800e7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7d:	8a 00                	mov    (%eax),%al
  800e7f:	84 c0                	test   %al,%al
  800e81:	74 0e                	je     800e91 <strncmp+0x2b>
  800e83:	8b 45 08             	mov    0x8(%ebp),%eax
  800e86:	8a 10                	mov    (%eax),%dl
  800e88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8b:	8a 00                	mov    (%eax),%al
  800e8d:	38 c2                	cmp    %al,%dl
  800e8f:	74 da                	je     800e6b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800e91:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e95:	75 07                	jne    800e9e <strncmp+0x38>
		return 0;
  800e97:	b8 00 00 00 00       	mov    $0x0,%eax
  800e9c:	eb 14                	jmp    800eb2 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800e9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea1:	8a 00                	mov    (%eax),%al
  800ea3:	0f b6 d0             	movzbl %al,%edx
  800ea6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea9:	8a 00                	mov    (%eax),%al
  800eab:	0f b6 c0             	movzbl %al,%eax
  800eae:	29 c2                	sub    %eax,%edx
  800eb0:	89 d0                	mov    %edx,%eax
}
  800eb2:	5d                   	pop    %ebp
  800eb3:	c3                   	ret    

00800eb4 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800eb4:	55                   	push   %ebp
  800eb5:	89 e5                	mov    %esp,%ebp
  800eb7:	83 ec 04             	sub    $0x4,%esp
  800eba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ec0:	eb 12                	jmp    800ed4 <strchr+0x20>
		if (*s == c)
  800ec2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec5:	8a 00                	mov    (%eax),%al
  800ec7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800eca:	75 05                	jne    800ed1 <strchr+0x1d>
			return (char *) s;
  800ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecf:	eb 11                	jmp    800ee2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ed1:	ff 45 08             	incl   0x8(%ebp)
  800ed4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed7:	8a 00                	mov    (%eax),%al
  800ed9:	84 c0                	test   %al,%al
  800edb:	75 e5                	jne    800ec2 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800edd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ee2:	c9                   	leave  
  800ee3:	c3                   	ret    

00800ee4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ee4:	55                   	push   %ebp
  800ee5:	89 e5                	mov    %esp,%ebp
  800ee7:	83 ec 04             	sub    $0x4,%esp
  800eea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eed:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ef0:	eb 0d                	jmp    800eff <strfind+0x1b>
		if (*s == c)
  800ef2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef5:	8a 00                	mov    (%eax),%al
  800ef7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800efa:	74 0e                	je     800f0a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800efc:	ff 45 08             	incl   0x8(%ebp)
  800eff:	8b 45 08             	mov    0x8(%ebp),%eax
  800f02:	8a 00                	mov    (%eax),%al
  800f04:	84 c0                	test   %al,%al
  800f06:	75 ea                	jne    800ef2 <strfind+0xe>
  800f08:	eb 01                	jmp    800f0b <strfind+0x27>
		if (*s == c)
			break;
  800f0a:	90                   	nop
	return (char *) s;
  800f0b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f0e:	c9                   	leave  
  800f0f:	c3                   	ret    

00800f10 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800f10:	55                   	push   %ebp
  800f11:	89 e5                	mov    %esp,%ebp
  800f13:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f16:	8b 45 08             	mov    0x8(%ebp),%eax
  800f19:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f1c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f22:	eb 0e                	jmp    800f32 <memset+0x22>
		*p++ = c;
  800f24:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f27:	8d 50 01             	lea    0x1(%eax),%edx
  800f2a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f2d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f30:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f32:	ff 4d f8             	decl   -0x8(%ebp)
  800f35:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f39:	79 e9                	jns    800f24 <memset+0x14>
		*p++ = c;

	return v;
  800f3b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f3e:	c9                   	leave  
  800f3f:	c3                   	ret    

00800f40 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f40:	55                   	push   %ebp
  800f41:	89 e5                	mov    %esp,%ebp
  800f43:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f46:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f49:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f52:	eb 16                	jmp    800f6a <memcpy+0x2a>
		*d++ = *s++;
  800f54:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f57:	8d 50 01             	lea    0x1(%eax),%edx
  800f5a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f5d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f60:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f63:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f66:	8a 12                	mov    (%edx),%dl
  800f68:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800f6a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f70:	89 55 10             	mov    %edx,0x10(%ebp)
  800f73:	85 c0                	test   %eax,%eax
  800f75:	75 dd                	jne    800f54 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800f77:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f7a:	c9                   	leave  
  800f7b:	c3                   	ret    

00800f7c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f7c:	55                   	push   %ebp
  800f7d:	89 e5                	mov    %esp,%ebp
  800f7f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f82:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f85:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f88:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800f8e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f91:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800f94:	73 50                	jae    800fe6 <memmove+0x6a>
  800f96:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f99:	8b 45 10             	mov    0x10(%ebp),%eax
  800f9c:	01 d0                	add    %edx,%eax
  800f9e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fa1:	76 43                	jbe    800fe6 <memmove+0x6a>
		s += n;
  800fa3:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa6:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800fa9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fac:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800faf:	eb 10                	jmp    800fc1 <memmove+0x45>
			*--d = *--s;
  800fb1:	ff 4d f8             	decl   -0x8(%ebp)
  800fb4:	ff 4d fc             	decl   -0x4(%ebp)
  800fb7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fba:	8a 10                	mov    (%eax),%dl
  800fbc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fbf:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800fc1:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fc7:	89 55 10             	mov    %edx,0x10(%ebp)
  800fca:	85 c0                	test   %eax,%eax
  800fcc:	75 e3                	jne    800fb1 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800fce:	eb 23                	jmp    800ff3 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800fd0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fd3:	8d 50 01             	lea    0x1(%eax),%edx
  800fd6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fd9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fdc:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fdf:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fe2:	8a 12                	mov    (%edx),%dl
  800fe4:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800fe6:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fec:	89 55 10             	mov    %edx,0x10(%ebp)
  800fef:	85 c0                	test   %eax,%eax
  800ff1:	75 dd                	jne    800fd0 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ff3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ff6:	c9                   	leave  
  800ff7:	c3                   	ret    

00800ff8 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800ff8:	55                   	push   %ebp
  800ff9:	89 e5                	mov    %esp,%ebp
  800ffb:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800ffe:	8b 45 08             	mov    0x8(%ebp),%eax
  801001:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801004:	8b 45 0c             	mov    0xc(%ebp),%eax
  801007:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80100a:	eb 2a                	jmp    801036 <memcmp+0x3e>
		if (*s1 != *s2)
  80100c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80100f:	8a 10                	mov    (%eax),%dl
  801011:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801014:	8a 00                	mov    (%eax),%al
  801016:	38 c2                	cmp    %al,%dl
  801018:	74 16                	je     801030 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80101a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80101d:	8a 00                	mov    (%eax),%al
  80101f:	0f b6 d0             	movzbl %al,%edx
  801022:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801025:	8a 00                	mov    (%eax),%al
  801027:	0f b6 c0             	movzbl %al,%eax
  80102a:	29 c2                	sub    %eax,%edx
  80102c:	89 d0                	mov    %edx,%eax
  80102e:	eb 18                	jmp    801048 <memcmp+0x50>
		s1++, s2++;
  801030:	ff 45 fc             	incl   -0x4(%ebp)
  801033:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801036:	8b 45 10             	mov    0x10(%ebp),%eax
  801039:	8d 50 ff             	lea    -0x1(%eax),%edx
  80103c:	89 55 10             	mov    %edx,0x10(%ebp)
  80103f:	85 c0                	test   %eax,%eax
  801041:	75 c9                	jne    80100c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801043:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801048:	c9                   	leave  
  801049:	c3                   	ret    

0080104a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80104a:	55                   	push   %ebp
  80104b:	89 e5                	mov    %esp,%ebp
  80104d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801050:	8b 55 08             	mov    0x8(%ebp),%edx
  801053:	8b 45 10             	mov    0x10(%ebp),%eax
  801056:	01 d0                	add    %edx,%eax
  801058:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80105b:	eb 15                	jmp    801072 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80105d:	8b 45 08             	mov    0x8(%ebp),%eax
  801060:	8a 00                	mov    (%eax),%al
  801062:	0f b6 d0             	movzbl %al,%edx
  801065:	8b 45 0c             	mov    0xc(%ebp),%eax
  801068:	0f b6 c0             	movzbl %al,%eax
  80106b:	39 c2                	cmp    %eax,%edx
  80106d:	74 0d                	je     80107c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80106f:	ff 45 08             	incl   0x8(%ebp)
  801072:	8b 45 08             	mov    0x8(%ebp),%eax
  801075:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801078:	72 e3                	jb     80105d <memfind+0x13>
  80107a:	eb 01                	jmp    80107d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80107c:	90                   	nop
	return (void *) s;
  80107d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801080:	c9                   	leave  
  801081:	c3                   	ret    

00801082 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801082:	55                   	push   %ebp
  801083:	89 e5                	mov    %esp,%ebp
  801085:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801088:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80108f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801096:	eb 03                	jmp    80109b <strtol+0x19>
		s++;
  801098:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80109b:	8b 45 08             	mov    0x8(%ebp),%eax
  80109e:	8a 00                	mov    (%eax),%al
  8010a0:	3c 20                	cmp    $0x20,%al
  8010a2:	74 f4                	je     801098 <strtol+0x16>
  8010a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a7:	8a 00                	mov    (%eax),%al
  8010a9:	3c 09                	cmp    $0x9,%al
  8010ab:	74 eb                	je     801098 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8010ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b0:	8a 00                	mov    (%eax),%al
  8010b2:	3c 2b                	cmp    $0x2b,%al
  8010b4:	75 05                	jne    8010bb <strtol+0x39>
		s++;
  8010b6:	ff 45 08             	incl   0x8(%ebp)
  8010b9:	eb 13                	jmp    8010ce <strtol+0x4c>
	else if (*s == '-')
  8010bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010be:	8a 00                	mov    (%eax),%al
  8010c0:	3c 2d                	cmp    $0x2d,%al
  8010c2:	75 0a                	jne    8010ce <strtol+0x4c>
		s++, neg = 1;
  8010c4:	ff 45 08             	incl   0x8(%ebp)
  8010c7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8010ce:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010d2:	74 06                	je     8010da <strtol+0x58>
  8010d4:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8010d8:	75 20                	jne    8010fa <strtol+0x78>
  8010da:	8b 45 08             	mov    0x8(%ebp),%eax
  8010dd:	8a 00                	mov    (%eax),%al
  8010df:	3c 30                	cmp    $0x30,%al
  8010e1:	75 17                	jne    8010fa <strtol+0x78>
  8010e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e6:	40                   	inc    %eax
  8010e7:	8a 00                	mov    (%eax),%al
  8010e9:	3c 78                	cmp    $0x78,%al
  8010eb:	75 0d                	jne    8010fa <strtol+0x78>
		s += 2, base = 16;
  8010ed:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8010f1:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8010f8:	eb 28                	jmp    801122 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8010fa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010fe:	75 15                	jne    801115 <strtol+0x93>
  801100:	8b 45 08             	mov    0x8(%ebp),%eax
  801103:	8a 00                	mov    (%eax),%al
  801105:	3c 30                	cmp    $0x30,%al
  801107:	75 0c                	jne    801115 <strtol+0x93>
		s++, base = 8;
  801109:	ff 45 08             	incl   0x8(%ebp)
  80110c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801113:	eb 0d                	jmp    801122 <strtol+0xa0>
	else if (base == 0)
  801115:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801119:	75 07                	jne    801122 <strtol+0xa0>
		base = 10;
  80111b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801122:	8b 45 08             	mov    0x8(%ebp),%eax
  801125:	8a 00                	mov    (%eax),%al
  801127:	3c 2f                	cmp    $0x2f,%al
  801129:	7e 19                	jle    801144 <strtol+0xc2>
  80112b:	8b 45 08             	mov    0x8(%ebp),%eax
  80112e:	8a 00                	mov    (%eax),%al
  801130:	3c 39                	cmp    $0x39,%al
  801132:	7f 10                	jg     801144 <strtol+0xc2>
			dig = *s - '0';
  801134:	8b 45 08             	mov    0x8(%ebp),%eax
  801137:	8a 00                	mov    (%eax),%al
  801139:	0f be c0             	movsbl %al,%eax
  80113c:	83 e8 30             	sub    $0x30,%eax
  80113f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801142:	eb 42                	jmp    801186 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801144:	8b 45 08             	mov    0x8(%ebp),%eax
  801147:	8a 00                	mov    (%eax),%al
  801149:	3c 60                	cmp    $0x60,%al
  80114b:	7e 19                	jle    801166 <strtol+0xe4>
  80114d:	8b 45 08             	mov    0x8(%ebp),%eax
  801150:	8a 00                	mov    (%eax),%al
  801152:	3c 7a                	cmp    $0x7a,%al
  801154:	7f 10                	jg     801166 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801156:	8b 45 08             	mov    0x8(%ebp),%eax
  801159:	8a 00                	mov    (%eax),%al
  80115b:	0f be c0             	movsbl %al,%eax
  80115e:	83 e8 57             	sub    $0x57,%eax
  801161:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801164:	eb 20                	jmp    801186 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801166:	8b 45 08             	mov    0x8(%ebp),%eax
  801169:	8a 00                	mov    (%eax),%al
  80116b:	3c 40                	cmp    $0x40,%al
  80116d:	7e 39                	jle    8011a8 <strtol+0x126>
  80116f:	8b 45 08             	mov    0x8(%ebp),%eax
  801172:	8a 00                	mov    (%eax),%al
  801174:	3c 5a                	cmp    $0x5a,%al
  801176:	7f 30                	jg     8011a8 <strtol+0x126>
			dig = *s - 'A' + 10;
  801178:	8b 45 08             	mov    0x8(%ebp),%eax
  80117b:	8a 00                	mov    (%eax),%al
  80117d:	0f be c0             	movsbl %al,%eax
  801180:	83 e8 37             	sub    $0x37,%eax
  801183:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801186:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801189:	3b 45 10             	cmp    0x10(%ebp),%eax
  80118c:	7d 19                	jge    8011a7 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80118e:	ff 45 08             	incl   0x8(%ebp)
  801191:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801194:	0f af 45 10          	imul   0x10(%ebp),%eax
  801198:	89 c2                	mov    %eax,%edx
  80119a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80119d:	01 d0                	add    %edx,%eax
  80119f:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8011a2:	e9 7b ff ff ff       	jmp    801122 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8011a7:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8011a8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011ac:	74 08                	je     8011b6 <strtol+0x134>
		*endptr = (char *) s;
  8011ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b1:	8b 55 08             	mov    0x8(%ebp),%edx
  8011b4:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8011b6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011ba:	74 07                	je     8011c3 <strtol+0x141>
  8011bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011bf:	f7 d8                	neg    %eax
  8011c1:	eb 03                	jmp    8011c6 <strtol+0x144>
  8011c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011c6:	c9                   	leave  
  8011c7:	c3                   	ret    

008011c8 <ltostr>:

void
ltostr(long value, char *str)
{
  8011c8:	55                   	push   %ebp
  8011c9:	89 e5                	mov    %esp,%ebp
  8011cb:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8011ce:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8011d5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8011dc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011e0:	79 13                	jns    8011f5 <ltostr+0x2d>
	{
		neg = 1;
  8011e2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8011e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ec:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8011ef:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8011f2:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8011f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8011fd:	99                   	cltd   
  8011fe:	f7 f9                	idiv   %ecx
  801200:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801203:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801206:	8d 50 01             	lea    0x1(%eax),%edx
  801209:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80120c:	89 c2                	mov    %eax,%edx
  80120e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801211:	01 d0                	add    %edx,%eax
  801213:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801216:	83 c2 30             	add    $0x30,%edx
  801219:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80121b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80121e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801223:	f7 e9                	imul   %ecx
  801225:	c1 fa 02             	sar    $0x2,%edx
  801228:	89 c8                	mov    %ecx,%eax
  80122a:	c1 f8 1f             	sar    $0x1f,%eax
  80122d:	29 c2                	sub    %eax,%edx
  80122f:	89 d0                	mov    %edx,%eax
  801231:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801234:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801237:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80123c:	f7 e9                	imul   %ecx
  80123e:	c1 fa 02             	sar    $0x2,%edx
  801241:	89 c8                	mov    %ecx,%eax
  801243:	c1 f8 1f             	sar    $0x1f,%eax
  801246:	29 c2                	sub    %eax,%edx
  801248:	89 d0                	mov    %edx,%eax
  80124a:	c1 e0 02             	shl    $0x2,%eax
  80124d:	01 d0                	add    %edx,%eax
  80124f:	01 c0                	add    %eax,%eax
  801251:	29 c1                	sub    %eax,%ecx
  801253:	89 ca                	mov    %ecx,%edx
  801255:	85 d2                	test   %edx,%edx
  801257:	75 9c                	jne    8011f5 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801259:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801260:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801263:	48                   	dec    %eax
  801264:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801267:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80126b:	74 3d                	je     8012aa <ltostr+0xe2>
		start = 1 ;
  80126d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801274:	eb 34                	jmp    8012aa <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801276:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801279:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127c:	01 d0                	add    %edx,%eax
  80127e:	8a 00                	mov    (%eax),%al
  801280:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801283:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801286:	8b 45 0c             	mov    0xc(%ebp),%eax
  801289:	01 c2                	add    %eax,%edx
  80128b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80128e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801291:	01 c8                	add    %ecx,%eax
  801293:	8a 00                	mov    (%eax),%al
  801295:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801297:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80129a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129d:	01 c2                	add    %eax,%edx
  80129f:	8a 45 eb             	mov    -0x15(%ebp),%al
  8012a2:	88 02                	mov    %al,(%edx)
		start++ ;
  8012a4:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8012a7:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8012aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012ad:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012b0:	7c c4                	jl     801276 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8012b2:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8012b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b8:	01 d0                	add    %edx,%eax
  8012ba:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8012bd:	90                   	nop
  8012be:	c9                   	leave  
  8012bf:	c3                   	ret    

008012c0 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8012c0:	55                   	push   %ebp
  8012c1:	89 e5                	mov    %esp,%ebp
  8012c3:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8012c6:	ff 75 08             	pushl  0x8(%ebp)
  8012c9:	e8 54 fa ff ff       	call   800d22 <strlen>
  8012ce:	83 c4 04             	add    $0x4,%esp
  8012d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8012d4:	ff 75 0c             	pushl  0xc(%ebp)
  8012d7:	e8 46 fa ff ff       	call   800d22 <strlen>
  8012dc:	83 c4 04             	add    $0x4,%esp
  8012df:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8012e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8012e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012f0:	eb 17                	jmp    801309 <strcconcat+0x49>
		final[s] = str1[s] ;
  8012f2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012f5:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f8:	01 c2                	add    %eax,%edx
  8012fa:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8012fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801300:	01 c8                	add    %ecx,%eax
  801302:	8a 00                	mov    (%eax),%al
  801304:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801306:	ff 45 fc             	incl   -0x4(%ebp)
  801309:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80130c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80130f:	7c e1                	jl     8012f2 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801311:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801318:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80131f:	eb 1f                	jmp    801340 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801321:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801324:	8d 50 01             	lea    0x1(%eax),%edx
  801327:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80132a:	89 c2                	mov    %eax,%edx
  80132c:	8b 45 10             	mov    0x10(%ebp),%eax
  80132f:	01 c2                	add    %eax,%edx
  801331:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801334:	8b 45 0c             	mov    0xc(%ebp),%eax
  801337:	01 c8                	add    %ecx,%eax
  801339:	8a 00                	mov    (%eax),%al
  80133b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80133d:	ff 45 f8             	incl   -0x8(%ebp)
  801340:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801343:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801346:	7c d9                	jl     801321 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801348:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80134b:	8b 45 10             	mov    0x10(%ebp),%eax
  80134e:	01 d0                	add    %edx,%eax
  801350:	c6 00 00             	movb   $0x0,(%eax)
}
  801353:	90                   	nop
  801354:	c9                   	leave  
  801355:	c3                   	ret    

00801356 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801356:	55                   	push   %ebp
  801357:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801359:	8b 45 14             	mov    0x14(%ebp),%eax
  80135c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801362:	8b 45 14             	mov    0x14(%ebp),%eax
  801365:	8b 00                	mov    (%eax),%eax
  801367:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80136e:	8b 45 10             	mov    0x10(%ebp),%eax
  801371:	01 d0                	add    %edx,%eax
  801373:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801379:	eb 0c                	jmp    801387 <strsplit+0x31>
			*string++ = 0;
  80137b:	8b 45 08             	mov    0x8(%ebp),%eax
  80137e:	8d 50 01             	lea    0x1(%eax),%edx
  801381:	89 55 08             	mov    %edx,0x8(%ebp)
  801384:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801387:	8b 45 08             	mov    0x8(%ebp),%eax
  80138a:	8a 00                	mov    (%eax),%al
  80138c:	84 c0                	test   %al,%al
  80138e:	74 18                	je     8013a8 <strsplit+0x52>
  801390:	8b 45 08             	mov    0x8(%ebp),%eax
  801393:	8a 00                	mov    (%eax),%al
  801395:	0f be c0             	movsbl %al,%eax
  801398:	50                   	push   %eax
  801399:	ff 75 0c             	pushl  0xc(%ebp)
  80139c:	e8 13 fb ff ff       	call   800eb4 <strchr>
  8013a1:	83 c4 08             	add    $0x8,%esp
  8013a4:	85 c0                	test   %eax,%eax
  8013a6:	75 d3                	jne    80137b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8013a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ab:	8a 00                	mov    (%eax),%al
  8013ad:	84 c0                	test   %al,%al
  8013af:	74 5a                	je     80140b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8013b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8013b4:	8b 00                	mov    (%eax),%eax
  8013b6:	83 f8 0f             	cmp    $0xf,%eax
  8013b9:	75 07                	jne    8013c2 <strsplit+0x6c>
		{
			return 0;
  8013bb:	b8 00 00 00 00       	mov    $0x0,%eax
  8013c0:	eb 66                	jmp    801428 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8013c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8013c5:	8b 00                	mov    (%eax),%eax
  8013c7:	8d 48 01             	lea    0x1(%eax),%ecx
  8013ca:	8b 55 14             	mov    0x14(%ebp),%edx
  8013cd:	89 0a                	mov    %ecx,(%edx)
  8013cf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d9:	01 c2                	add    %eax,%edx
  8013db:	8b 45 08             	mov    0x8(%ebp),%eax
  8013de:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013e0:	eb 03                	jmp    8013e5 <strsplit+0x8f>
			string++;
  8013e2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8013e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e8:	8a 00                	mov    (%eax),%al
  8013ea:	84 c0                	test   %al,%al
  8013ec:	74 8b                	je     801379 <strsplit+0x23>
  8013ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f1:	8a 00                	mov    (%eax),%al
  8013f3:	0f be c0             	movsbl %al,%eax
  8013f6:	50                   	push   %eax
  8013f7:	ff 75 0c             	pushl  0xc(%ebp)
  8013fa:	e8 b5 fa ff ff       	call   800eb4 <strchr>
  8013ff:	83 c4 08             	add    $0x8,%esp
  801402:	85 c0                	test   %eax,%eax
  801404:	74 dc                	je     8013e2 <strsplit+0x8c>
			string++;
	}
  801406:	e9 6e ff ff ff       	jmp    801379 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80140b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80140c:	8b 45 14             	mov    0x14(%ebp),%eax
  80140f:	8b 00                	mov    (%eax),%eax
  801411:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801418:	8b 45 10             	mov    0x10(%ebp),%eax
  80141b:	01 d0                	add    %edx,%eax
  80141d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801423:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801428:	c9                   	leave  
  801429:	c3                   	ret    

0080142a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80142a:	55                   	push   %ebp
  80142b:	89 e5                	mov    %esp,%ebp
  80142d:	57                   	push   %edi
  80142e:	56                   	push   %esi
  80142f:	53                   	push   %ebx
  801430:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801433:	8b 45 08             	mov    0x8(%ebp),%eax
  801436:	8b 55 0c             	mov    0xc(%ebp),%edx
  801439:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80143c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80143f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801442:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801445:	cd 30                	int    $0x30
  801447:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80144a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80144d:	83 c4 10             	add    $0x10,%esp
  801450:	5b                   	pop    %ebx
  801451:	5e                   	pop    %esi
  801452:	5f                   	pop    %edi
  801453:	5d                   	pop    %ebp
  801454:	c3                   	ret    

00801455 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801455:	55                   	push   %ebp
  801456:	89 e5                	mov    %esp,%ebp
  801458:	83 ec 04             	sub    $0x4,%esp
  80145b:	8b 45 10             	mov    0x10(%ebp),%eax
  80145e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801461:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801465:	8b 45 08             	mov    0x8(%ebp),%eax
  801468:	6a 00                	push   $0x0
  80146a:	6a 00                	push   $0x0
  80146c:	52                   	push   %edx
  80146d:	ff 75 0c             	pushl  0xc(%ebp)
  801470:	50                   	push   %eax
  801471:	6a 00                	push   $0x0
  801473:	e8 b2 ff ff ff       	call   80142a <syscall>
  801478:	83 c4 18             	add    $0x18,%esp
}
  80147b:	90                   	nop
  80147c:	c9                   	leave  
  80147d:	c3                   	ret    

0080147e <sys_cgetc>:

int
sys_cgetc(void)
{
  80147e:	55                   	push   %ebp
  80147f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801481:	6a 00                	push   $0x0
  801483:	6a 00                	push   $0x0
  801485:	6a 00                	push   $0x0
  801487:	6a 00                	push   $0x0
  801489:	6a 00                	push   $0x0
  80148b:	6a 01                	push   $0x1
  80148d:	e8 98 ff ff ff       	call   80142a <syscall>
  801492:	83 c4 18             	add    $0x18,%esp
}
  801495:	c9                   	leave  
  801496:	c3                   	ret    

00801497 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801497:	55                   	push   %ebp
  801498:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80149a:	8b 45 08             	mov    0x8(%ebp),%eax
  80149d:	6a 00                	push   $0x0
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 00                	push   $0x0
  8014a3:	6a 00                	push   $0x0
  8014a5:	50                   	push   %eax
  8014a6:	6a 05                	push   $0x5
  8014a8:	e8 7d ff ff ff       	call   80142a <syscall>
  8014ad:	83 c4 18             	add    $0x18,%esp
}
  8014b0:	c9                   	leave  
  8014b1:	c3                   	ret    

008014b2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8014b2:	55                   	push   %ebp
  8014b3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 00                	push   $0x0
  8014b9:	6a 00                	push   $0x0
  8014bb:	6a 00                	push   $0x0
  8014bd:	6a 00                	push   $0x0
  8014bf:	6a 02                	push   $0x2
  8014c1:	e8 64 ff ff ff       	call   80142a <syscall>
  8014c6:	83 c4 18             	add    $0x18,%esp
}
  8014c9:	c9                   	leave  
  8014ca:	c3                   	ret    

008014cb <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8014cb:	55                   	push   %ebp
  8014cc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 03                	push   $0x3
  8014da:	e8 4b ff ff ff       	call   80142a <syscall>
  8014df:	83 c4 18             	add    $0x18,%esp
}
  8014e2:	c9                   	leave  
  8014e3:	c3                   	ret    

008014e4 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8014e4:	55                   	push   %ebp
  8014e5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 00                	push   $0x0
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 00                	push   $0x0
  8014ef:	6a 00                	push   $0x0
  8014f1:	6a 04                	push   $0x4
  8014f3:	e8 32 ff ff ff       	call   80142a <syscall>
  8014f8:	83 c4 18             	add    $0x18,%esp
}
  8014fb:	c9                   	leave  
  8014fc:	c3                   	ret    

008014fd <sys_env_exit>:


void sys_env_exit(void)
{
  8014fd:	55                   	push   %ebp
  8014fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801500:	6a 00                	push   $0x0
  801502:	6a 00                	push   $0x0
  801504:	6a 00                	push   $0x0
  801506:	6a 00                	push   $0x0
  801508:	6a 00                	push   $0x0
  80150a:	6a 06                	push   $0x6
  80150c:	e8 19 ff ff ff       	call   80142a <syscall>
  801511:	83 c4 18             	add    $0x18,%esp
}
  801514:	90                   	nop
  801515:	c9                   	leave  
  801516:	c3                   	ret    

00801517 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801517:	55                   	push   %ebp
  801518:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80151a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80151d:	8b 45 08             	mov    0x8(%ebp),%eax
  801520:	6a 00                	push   $0x0
  801522:	6a 00                	push   $0x0
  801524:	6a 00                	push   $0x0
  801526:	52                   	push   %edx
  801527:	50                   	push   %eax
  801528:	6a 07                	push   $0x7
  80152a:	e8 fb fe ff ff       	call   80142a <syscall>
  80152f:	83 c4 18             	add    $0x18,%esp
}
  801532:	c9                   	leave  
  801533:	c3                   	ret    

00801534 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801534:	55                   	push   %ebp
  801535:	89 e5                	mov    %esp,%ebp
  801537:	56                   	push   %esi
  801538:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801539:	8b 75 18             	mov    0x18(%ebp),%esi
  80153c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80153f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801542:	8b 55 0c             	mov    0xc(%ebp),%edx
  801545:	8b 45 08             	mov    0x8(%ebp),%eax
  801548:	56                   	push   %esi
  801549:	53                   	push   %ebx
  80154a:	51                   	push   %ecx
  80154b:	52                   	push   %edx
  80154c:	50                   	push   %eax
  80154d:	6a 08                	push   $0x8
  80154f:	e8 d6 fe ff ff       	call   80142a <syscall>
  801554:	83 c4 18             	add    $0x18,%esp
}
  801557:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80155a:	5b                   	pop    %ebx
  80155b:	5e                   	pop    %esi
  80155c:	5d                   	pop    %ebp
  80155d:	c3                   	ret    

0080155e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80155e:	55                   	push   %ebp
  80155f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801561:	8b 55 0c             	mov    0xc(%ebp),%edx
  801564:	8b 45 08             	mov    0x8(%ebp),%eax
  801567:	6a 00                	push   $0x0
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	52                   	push   %edx
  80156e:	50                   	push   %eax
  80156f:	6a 09                	push   $0x9
  801571:	e8 b4 fe ff ff       	call   80142a <syscall>
  801576:	83 c4 18             	add    $0x18,%esp
}
  801579:	c9                   	leave  
  80157a:	c3                   	ret    

0080157b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80157b:	55                   	push   %ebp
  80157c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	6a 00                	push   $0x0
  801584:	ff 75 0c             	pushl  0xc(%ebp)
  801587:	ff 75 08             	pushl  0x8(%ebp)
  80158a:	6a 0a                	push   $0xa
  80158c:	e8 99 fe ff ff       	call   80142a <syscall>
  801591:	83 c4 18             	add    $0x18,%esp
}
  801594:	c9                   	leave  
  801595:	c3                   	ret    

00801596 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801596:	55                   	push   %ebp
  801597:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	6a 00                	push   $0x0
  8015a1:	6a 00                	push   $0x0
  8015a3:	6a 0b                	push   $0xb
  8015a5:	e8 80 fe ff ff       	call   80142a <syscall>
  8015aa:	83 c4 18             	add    $0x18,%esp
}
  8015ad:	c9                   	leave  
  8015ae:	c3                   	ret    

008015af <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8015af:	55                   	push   %ebp
  8015b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	6a 00                	push   $0x0
  8015bc:	6a 0c                	push   $0xc
  8015be:	e8 67 fe ff ff       	call   80142a <syscall>
  8015c3:	83 c4 18             	add    $0x18,%esp
}
  8015c6:	c9                   	leave  
  8015c7:	c3                   	ret    

008015c8 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8015c8:	55                   	push   %ebp
  8015c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8015cb:	6a 00                	push   $0x0
  8015cd:	6a 00                	push   $0x0
  8015cf:	6a 00                	push   $0x0
  8015d1:	6a 00                	push   $0x0
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 0d                	push   $0xd
  8015d7:	e8 4e fe ff ff       	call   80142a <syscall>
  8015dc:	83 c4 18             	add    $0x18,%esp
}
  8015df:	c9                   	leave  
  8015e0:	c3                   	ret    

008015e1 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8015e1:	55                   	push   %ebp
  8015e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 00                	push   $0x0
  8015e8:	6a 00                	push   $0x0
  8015ea:	ff 75 0c             	pushl  0xc(%ebp)
  8015ed:	ff 75 08             	pushl  0x8(%ebp)
  8015f0:	6a 11                	push   $0x11
  8015f2:	e8 33 fe ff ff       	call   80142a <syscall>
  8015f7:	83 c4 18             	add    $0x18,%esp
	return;
  8015fa:	90                   	nop
}
  8015fb:	c9                   	leave  
  8015fc:	c3                   	ret    

008015fd <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8015fd:	55                   	push   %ebp
  8015fe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801600:	6a 00                	push   $0x0
  801602:	6a 00                	push   $0x0
  801604:	6a 00                	push   $0x0
  801606:	ff 75 0c             	pushl  0xc(%ebp)
  801609:	ff 75 08             	pushl  0x8(%ebp)
  80160c:	6a 12                	push   $0x12
  80160e:	e8 17 fe ff ff       	call   80142a <syscall>
  801613:	83 c4 18             	add    $0x18,%esp
	return ;
  801616:	90                   	nop
}
  801617:	c9                   	leave  
  801618:	c3                   	ret    

00801619 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801619:	55                   	push   %ebp
  80161a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	6a 00                	push   $0x0
  801622:	6a 00                	push   $0x0
  801624:	6a 00                	push   $0x0
  801626:	6a 0e                	push   $0xe
  801628:	e8 fd fd ff ff       	call   80142a <syscall>
  80162d:	83 c4 18             	add    $0x18,%esp
}
  801630:	c9                   	leave  
  801631:	c3                   	ret    

00801632 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801632:	55                   	push   %ebp
  801633:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	ff 75 08             	pushl  0x8(%ebp)
  801640:	6a 0f                	push   $0xf
  801642:	e8 e3 fd ff ff       	call   80142a <syscall>
  801647:	83 c4 18             	add    $0x18,%esp
}
  80164a:	c9                   	leave  
  80164b:	c3                   	ret    

0080164c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80164c:	55                   	push   %ebp
  80164d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	6a 00                	push   $0x0
  801655:	6a 00                	push   $0x0
  801657:	6a 00                	push   $0x0
  801659:	6a 10                	push   $0x10
  80165b:	e8 ca fd ff ff       	call   80142a <syscall>
  801660:	83 c4 18             	add    $0x18,%esp
}
  801663:	90                   	nop
  801664:	c9                   	leave  
  801665:	c3                   	ret    

00801666 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801666:	55                   	push   %ebp
  801667:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 00                	push   $0x0
  801671:	6a 00                	push   $0x0
  801673:	6a 14                	push   $0x14
  801675:	e8 b0 fd ff ff       	call   80142a <syscall>
  80167a:	83 c4 18             	add    $0x18,%esp
}
  80167d:	90                   	nop
  80167e:	c9                   	leave  
  80167f:	c3                   	ret    

00801680 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801680:	55                   	push   %ebp
  801681:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801683:	6a 00                	push   $0x0
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	6a 00                	push   $0x0
  80168d:	6a 15                	push   $0x15
  80168f:	e8 96 fd ff ff       	call   80142a <syscall>
  801694:	83 c4 18             	add    $0x18,%esp
}
  801697:	90                   	nop
  801698:	c9                   	leave  
  801699:	c3                   	ret    

0080169a <sys_cputc>:


void
sys_cputc(const char c)
{
  80169a:	55                   	push   %ebp
  80169b:	89 e5                	mov    %esp,%ebp
  80169d:	83 ec 04             	sub    $0x4,%esp
  8016a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8016a6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016aa:	6a 00                	push   $0x0
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	6a 00                	push   $0x0
  8016b2:	50                   	push   %eax
  8016b3:	6a 16                	push   $0x16
  8016b5:	e8 70 fd ff ff       	call   80142a <syscall>
  8016ba:	83 c4 18             	add    $0x18,%esp
}
  8016bd:	90                   	nop
  8016be:	c9                   	leave  
  8016bf:	c3                   	ret    

008016c0 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8016c0:	55                   	push   %ebp
  8016c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8016c3:	6a 00                	push   $0x0
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	6a 00                	push   $0x0
  8016cd:	6a 17                	push   $0x17
  8016cf:	e8 56 fd ff ff       	call   80142a <syscall>
  8016d4:	83 c4 18             	add    $0x18,%esp
}
  8016d7:	90                   	nop
  8016d8:	c9                   	leave  
  8016d9:	c3                   	ret    

008016da <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8016da:	55                   	push   %ebp
  8016db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8016dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	6a 00                	push   $0x0
  8016e6:	ff 75 0c             	pushl  0xc(%ebp)
  8016e9:	50                   	push   %eax
  8016ea:	6a 18                	push   $0x18
  8016ec:	e8 39 fd ff ff       	call   80142a <syscall>
  8016f1:	83 c4 18             	add    $0x18,%esp
}
  8016f4:	c9                   	leave  
  8016f5:	c3                   	ret    

008016f6 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8016f6:	55                   	push   %ebp
  8016f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8016f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	6a 00                	push   $0x0
  801705:	52                   	push   %edx
  801706:	50                   	push   %eax
  801707:	6a 1b                	push   $0x1b
  801709:	e8 1c fd ff ff       	call   80142a <syscall>
  80170e:	83 c4 18             	add    $0x18,%esp
}
  801711:	c9                   	leave  
  801712:	c3                   	ret    

00801713 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801713:	55                   	push   %ebp
  801714:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801716:	8b 55 0c             	mov    0xc(%ebp),%edx
  801719:	8b 45 08             	mov    0x8(%ebp),%eax
  80171c:	6a 00                	push   $0x0
  80171e:	6a 00                	push   $0x0
  801720:	6a 00                	push   $0x0
  801722:	52                   	push   %edx
  801723:	50                   	push   %eax
  801724:	6a 19                	push   $0x19
  801726:	e8 ff fc ff ff       	call   80142a <syscall>
  80172b:	83 c4 18             	add    $0x18,%esp
}
  80172e:	90                   	nop
  80172f:	c9                   	leave  
  801730:	c3                   	ret    

00801731 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801731:	55                   	push   %ebp
  801732:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801734:	8b 55 0c             	mov    0xc(%ebp),%edx
  801737:	8b 45 08             	mov    0x8(%ebp),%eax
  80173a:	6a 00                	push   $0x0
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	52                   	push   %edx
  801741:	50                   	push   %eax
  801742:	6a 1a                	push   $0x1a
  801744:	e8 e1 fc ff ff       	call   80142a <syscall>
  801749:	83 c4 18             	add    $0x18,%esp
}
  80174c:	90                   	nop
  80174d:	c9                   	leave  
  80174e:	c3                   	ret    

0080174f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80174f:	55                   	push   %ebp
  801750:	89 e5                	mov    %esp,%ebp
  801752:	83 ec 04             	sub    $0x4,%esp
  801755:	8b 45 10             	mov    0x10(%ebp),%eax
  801758:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80175b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80175e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801762:	8b 45 08             	mov    0x8(%ebp),%eax
  801765:	6a 00                	push   $0x0
  801767:	51                   	push   %ecx
  801768:	52                   	push   %edx
  801769:	ff 75 0c             	pushl  0xc(%ebp)
  80176c:	50                   	push   %eax
  80176d:	6a 1c                	push   $0x1c
  80176f:	e8 b6 fc ff ff       	call   80142a <syscall>
  801774:	83 c4 18             	add    $0x18,%esp
}
  801777:	c9                   	leave  
  801778:	c3                   	ret    

00801779 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801779:	55                   	push   %ebp
  80177a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80177c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80177f:	8b 45 08             	mov    0x8(%ebp),%eax
  801782:	6a 00                	push   $0x0
  801784:	6a 00                	push   $0x0
  801786:	6a 00                	push   $0x0
  801788:	52                   	push   %edx
  801789:	50                   	push   %eax
  80178a:	6a 1d                	push   $0x1d
  80178c:	e8 99 fc ff ff       	call   80142a <syscall>
  801791:	83 c4 18             	add    $0x18,%esp
}
  801794:	c9                   	leave  
  801795:	c3                   	ret    

00801796 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801796:	55                   	push   %ebp
  801797:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801799:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80179c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80179f:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a2:	6a 00                	push   $0x0
  8017a4:	6a 00                	push   $0x0
  8017a6:	51                   	push   %ecx
  8017a7:	52                   	push   %edx
  8017a8:	50                   	push   %eax
  8017a9:	6a 1e                	push   $0x1e
  8017ab:	e8 7a fc ff ff       	call   80142a <syscall>
  8017b0:	83 c4 18             	add    $0x18,%esp
}
  8017b3:	c9                   	leave  
  8017b4:	c3                   	ret    

008017b5 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8017b5:	55                   	push   %ebp
  8017b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8017b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	52                   	push   %edx
  8017c5:	50                   	push   %eax
  8017c6:	6a 1f                	push   $0x1f
  8017c8:	e8 5d fc ff ff       	call   80142a <syscall>
  8017cd:	83 c4 18             	add    $0x18,%esp
}
  8017d0:	c9                   	leave  
  8017d1:	c3                   	ret    

008017d2 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8017d2:	55                   	push   %ebp
  8017d3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	6a 00                	push   $0x0
  8017dd:	6a 00                	push   $0x0
  8017df:	6a 20                	push   $0x20
  8017e1:	e8 44 fc ff ff       	call   80142a <syscall>
  8017e6:	83 c4 18             	add    $0x18,%esp
}
  8017e9:	c9                   	leave  
  8017ea:	c3                   	ret    

008017eb <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8017eb:	55                   	push   %ebp
  8017ec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8017ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f1:	6a 00                	push   $0x0
  8017f3:	ff 75 14             	pushl  0x14(%ebp)
  8017f6:	ff 75 10             	pushl  0x10(%ebp)
  8017f9:	ff 75 0c             	pushl  0xc(%ebp)
  8017fc:	50                   	push   %eax
  8017fd:	6a 21                	push   $0x21
  8017ff:	e8 26 fc ff ff       	call   80142a <syscall>
  801804:	83 c4 18             	add    $0x18,%esp
}
  801807:	c9                   	leave  
  801808:	c3                   	ret    

00801809 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801809:	55                   	push   %ebp
  80180a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80180c:	8b 45 08             	mov    0x8(%ebp),%eax
  80180f:	6a 00                	push   $0x0
  801811:	6a 00                	push   $0x0
  801813:	6a 00                	push   $0x0
  801815:	6a 00                	push   $0x0
  801817:	50                   	push   %eax
  801818:	6a 22                	push   $0x22
  80181a:	e8 0b fc ff ff       	call   80142a <syscall>
  80181f:	83 c4 18             	add    $0x18,%esp
}
  801822:	90                   	nop
  801823:	c9                   	leave  
  801824:	c3                   	ret    

00801825 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801825:	55                   	push   %ebp
  801826:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801828:	8b 45 08             	mov    0x8(%ebp),%eax
  80182b:	6a 00                	push   $0x0
  80182d:	6a 00                	push   $0x0
  80182f:	6a 00                	push   $0x0
  801831:	6a 00                	push   $0x0
  801833:	50                   	push   %eax
  801834:	6a 23                	push   $0x23
  801836:	e8 ef fb ff ff       	call   80142a <syscall>
  80183b:	83 c4 18             	add    $0x18,%esp
}
  80183e:	90                   	nop
  80183f:	c9                   	leave  
  801840:	c3                   	ret    

00801841 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801841:	55                   	push   %ebp
  801842:	89 e5                	mov    %esp,%ebp
  801844:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801847:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80184a:	8d 50 04             	lea    0x4(%eax),%edx
  80184d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	6a 00                	push   $0x0
  801856:	52                   	push   %edx
  801857:	50                   	push   %eax
  801858:	6a 24                	push   $0x24
  80185a:	e8 cb fb ff ff       	call   80142a <syscall>
  80185f:	83 c4 18             	add    $0x18,%esp
	return result;
  801862:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801865:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801868:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80186b:	89 01                	mov    %eax,(%ecx)
  80186d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801870:	8b 45 08             	mov    0x8(%ebp),%eax
  801873:	c9                   	leave  
  801874:	c2 04 00             	ret    $0x4

00801877 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801877:	55                   	push   %ebp
  801878:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80187a:	6a 00                	push   $0x0
  80187c:	6a 00                	push   $0x0
  80187e:	ff 75 10             	pushl  0x10(%ebp)
  801881:	ff 75 0c             	pushl  0xc(%ebp)
  801884:	ff 75 08             	pushl  0x8(%ebp)
  801887:	6a 13                	push   $0x13
  801889:	e8 9c fb ff ff       	call   80142a <syscall>
  80188e:	83 c4 18             	add    $0x18,%esp
	return ;
  801891:	90                   	nop
}
  801892:	c9                   	leave  
  801893:	c3                   	ret    

00801894 <sys_rcr2>:
uint32 sys_rcr2()
{
  801894:	55                   	push   %ebp
  801895:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801897:	6a 00                	push   $0x0
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 25                	push   $0x25
  8018a3:	e8 82 fb ff ff       	call   80142a <syscall>
  8018a8:	83 c4 18             	add    $0x18,%esp
}
  8018ab:	c9                   	leave  
  8018ac:	c3                   	ret    

008018ad <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8018ad:	55                   	push   %ebp
  8018ae:	89 e5                	mov    %esp,%ebp
  8018b0:	83 ec 04             	sub    $0x4,%esp
  8018b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8018b9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	50                   	push   %eax
  8018c6:	6a 26                	push   $0x26
  8018c8:	e8 5d fb ff ff       	call   80142a <syscall>
  8018cd:	83 c4 18             	add    $0x18,%esp
	return ;
  8018d0:	90                   	nop
}
  8018d1:	c9                   	leave  
  8018d2:	c3                   	ret    

008018d3 <rsttst>:
void rsttst()
{
  8018d3:	55                   	push   %ebp
  8018d4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8018d6:	6a 00                	push   $0x0
  8018d8:	6a 00                	push   $0x0
  8018da:	6a 00                	push   $0x0
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 00                	push   $0x0
  8018e0:	6a 28                	push   $0x28
  8018e2:	e8 43 fb ff ff       	call   80142a <syscall>
  8018e7:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ea:	90                   	nop
}
  8018eb:	c9                   	leave  
  8018ec:	c3                   	ret    

008018ed <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8018ed:	55                   	push   %ebp
  8018ee:	89 e5                	mov    %esp,%ebp
  8018f0:	83 ec 04             	sub    $0x4,%esp
  8018f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8018f6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8018f9:	8b 55 18             	mov    0x18(%ebp),%edx
  8018fc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801900:	52                   	push   %edx
  801901:	50                   	push   %eax
  801902:	ff 75 10             	pushl  0x10(%ebp)
  801905:	ff 75 0c             	pushl  0xc(%ebp)
  801908:	ff 75 08             	pushl  0x8(%ebp)
  80190b:	6a 27                	push   $0x27
  80190d:	e8 18 fb ff ff       	call   80142a <syscall>
  801912:	83 c4 18             	add    $0x18,%esp
	return ;
  801915:	90                   	nop
}
  801916:	c9                   	leave  
  801917:	c3                   	ret    

00801918 <chktst>:
void chktst(uint32 n)
{
  801918:	55                   	push   %ebp
  801919:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80191b:	6a 00                	push   $0x0
  80191d:	6a 00                	push   $0x0
  80191f:	6a 00                	push   $0x0
  801921:	6a 00                	push   $0x0
  801923:	ff 75 08             	pushl  0x8(%ebp)
  801926:	6a 29                	push   $0x29
  801928:	e8 fd fa ff ff       	call   80142a <syscall>
  80192d:	83 c4 18             	add    $0x18,%esp
	return ;
  801930:	90                   	nop
}
  801931:	c9                   	leave  
  801932:	c3                   	ret    

00801933 <inctst>:

void inctst()
{
  801933:	55                   	push   %ebp
  801934:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801936:	6a 00                	push   $0x0
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 00                	push   $0x0
  80193e:	6a 00                	push   $0x0
  801940:	6a 2a                	push   $0x2a
  801942:	e8 e3 fa ff ff       	call   80142a <syscall>
  801947:	83 c4 18             	add    $0x18,%esp
	return ;
  80194a:	90                   	nop
}
  80194b:	c9                   	leave  
  80194c:	c3                   	ret    

0080194d <gettst>:
uint32 gettst()
{
  80194d:	55                   	push   %ebp
  80194e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801950:	6a 00                	push   $0x0
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	6a 00                	push   $0x0
  80195a:	6a 2b                	push   $0x2b
  80195c:	e8 c9 fa ff ff       	call   80142a <syscall>
  801961:	83 c4 18             	add    $0x18,%esp
}
  801964:	c9                   	leave  
  801965:	c3                   	ret    

00801966 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801966:	55                   	push   %ebp
  801967:	89 e5                	mov    %esp,%ebp
  801969:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	6a 00                	push   $0x0
  801972:	6a 00                	push   $0x0
  801974:	6a 00                	push   $0x0
  801976:	6a 2c                	push   $0x2c
  801978:	e8 ad fa ff ff       	call   80142a <syscall>
  80197d:	83 c4 18             	add    $0x18,%esp
  801980:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801983:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801987:	75 07                	jne    801990 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801989:	b8 01 00 00 00       	mov    $0x1,%eax
  80198e:	eb 05                	jmp    801995 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801990:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801995:	c9                   	leave  
  801996:	c3                   	ret    

00801997 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801997:	55                   	push   %ebp
  801998:	89 e5                	mov    %esp,%ebp
  80199a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	6a 2c                	push   $0x2c
  8019a9:	e8 7c fa ff ff       	call   80142a <syscall>
  8019ae:	83 c4 18             	add    $0x18,%esp
  8019b1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8019b4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8019b8:	75 07                	jne    8019c1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8019ba:	b8 01 00 00 00       	mov    $0x1,%eax
  8019bf:	eb 05                	jmp    8019c6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8019c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019c6:	c9                   	leave  
  8019c7:	c3                   	ret    

008019c8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8019c8:	55                   	push   %ebp
  8019c9:	89 e5                	mov    %esp,%ebp
  8019cb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019ce:	6a 00                	push   $0x0
  8019d0:	6a 00                	push   $0x0
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	6a 2c                	push   $0x2c
  8019da:	e8 4b fa ff ff       	call   80142a <syscall>
  8019df:	83 c4 18             	add    $0x18,%esp
  8019e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8019e5:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8019e9:	75 07                	jne    8019f2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8019eb:	b8 01 00 00 00       	mov    $0x1,%eax
  8019f0:	eb 05                	jmp    8019f7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8019f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019f7:	c9                   	leave  
  8019f8:	c3                   	ret    

008019f9 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8019f9:	55                   	push   %ebp
  8019fa:	89 e5                	mov    %esp,%ebp
  8019fc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019ff:	6a 00                	push   $0x0
  801a01:	6a 00                	push   $0x0
  801a03:	6a 00                	push   $0x0
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	6a 2c                	push   $0x2c
  801a0b:	e8 1a fa ff ff       	call   80142a <syscall>
  801a10:	83 c4 18             	add    $0x18,%esp
  801a13:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801a16:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801a1a:	75 07                	jne    801a23 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801a1c:	b8 01 00 00 00       	mov    $0x1,%eax
  801a21:	eb 05                	jmp    801a28 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801a23:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a28:	c9                   	leave  
  801a29:	c3                   	ret    

00801a2a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a2a:	55                   	push   %ebp
  801a2b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a2d:	6a 00                	push   $0x0
  801a2f:	6a 00                	push   $0x0
  801a31:	6a 00                	push   $0x0
  801a33:	6a 00                	push   $0x0
  801a35:	ff 75 08             	pushl  0x8(%ebp)
  801a38:	6a 2d                	push   $0x2d
  801a3a:	e8 eb f9 ff ff       	call   80142a <syscall>
  801a3f:	83 c4 18             	add    $0x18,%esp
	return ;
  801a42:	90                   	nop
}
  801a43:	c9                   	leave  
  801a44:	c3                   	ret    

00801a45 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801a45:	55                   	push   %ebp
  801a46:	89 e5                	mov    %esp,%ebp
  801a48:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801a49:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a4c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a4f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a52:	8b 45 08             	mov    0x8(%ebp),%eax
  801a55:	6a 00                	push   $0x0
  801a57:	53                   	push   %ebx
  801a58:	51                   	push   %ecx
  801a59:	52                   	push   %edx
  801a5a:	50                   	push   %eax
  801a5b:	6a 2e                	push   $0x2e
  801a5d:	e8 c8 f9 ff ff       	call   80142a <syscall>
  801a62:	83 c4 18             	add    $0x18,%esp
}
  801a65:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801a68:	c9                   	leave  
  801a69:	c3                   	ret    

00801a6a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801a6a:	55                   	push   %ebp
  801a6b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801a6d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a70:	8b 45 08             	mov    0x8(%ebp),%eax
  801a73:	6a 00                	push   $0x0
  801a75:	6a 00                	push   $0x0
  801a77:	6a 00                	push   $0x0
  801a79:	52                   	push   %edx
  801a7a:	50                   	push   %eax
  801a7b:	6a 2f                	push   $0x2f
  801a7d:	e8 a8 f9 ff ff       	call   80142a <syscall>
  801a82:	83 c4 18             	add    $0x18,%esp
}
  801a85:	c9                   	leave  
  801a86:	c3                   	ret    
  801a87:	90                   	nop

00801a88 <__udivdi3>:
  801a88:	55                   	push   %ebp
  801a89:	57                   	push   %edi
  801a8a:	56                   	push   %esi
  801a8b:	53                   	push   %ebx
  801a8c:	83 ec 1c             	sub    $0x1c,%esp
  801a8f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a93:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a97:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a9b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a9f:	89 ca                	mov    %ecx,%edx
  801aa1:	89 f8                	mov    %edi,%eax
  801aa3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801aa7:	85 f6                	test   %esi,%esi
  801aa9:	75 2d                	jne    801ad8 <__udivdi3+0x50>
  801aab:	39 cf                	cmp    %ecx,%edi
  801aad:	77 65                	ja     801b14 <__udivdi3+0x8c>
  801aaf:	89 fd                	mov    %edi,%ebp
  801ab1:	85 ff                	test   %edi,%edi
  801ab3:	75 0b                	jne    801ac0 <__udivdi3+0x38>
  801ab5:	b8 01 00 00 00       	mov    $0x1,%eax
  801aba:	31 d2                	xor    %edx,%edx
  801abc:	f7 f7                	div    %edi
  801abe:	89 c5                	mov    %eax,%ebp
  801ac0:	31 d2                	xor    %edx,%edx
  801ac2:	89 c8                	mov    %ecx,%eax
  801ac4:	f7 f5                	div    %ebp
  801ac6:	89 c1                	mov    %eax,%ecx
  801ac8:	89 d8                	mov    %ebx,%eax
  801aca:	f7 f5                	div    %ebp
  801acc:	89 cf                	mov    %ecx,%edi
  801ace:	89 fa                	mov    %edi,%edx
  801ad0:	83 c4 1c             	add    $0x1c,%esp
  801ad3:	5b                   	pop    %ebx
  801ad4:	5e                   	pop    %esi
  801ad5:	5f                   	pop    %edi
  801ad6:	5d                   	pop    %ebp
  801ad7:	c3                   	ret    
  801ad8:	39 ce                	cmp    %ecx,%esi
  801ada:	77 28                	ja     801b04 <__udivdi3+0x7c>
  801adc:	0f bd fe             	bsr    %esi,%edi
  801adf:	83 f7 1f             	xor    $0x1f,%edi
  801ae2:	75 40                	jne    801b24 <__udivdi3+0x9c>
  801ae4:	39 ce                	cmp    %ecx,%esi
  801ae6:	72 0a                	jb     801af2 <__udivdi3+0x6a>
  801ae8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801aec:	0f 87 9e 00 00 00    	ja     801b90 <__udivdi3+0x108>
  801af2:	b8 01 00 00 00       	mov    $0x1,%eax
  801af7:	89 fa                	mov    %edi,%edx
  801af9:	83 c4 1c             	add    $0x1c,%esp
  801afc:	5b                   	pop    %ebx
  801afd:	5e                   	pop    %esi
  801afe:	5f                   	pop    %edi
  801aff:	5d                   	pop    %ebp
  801b00:	c3                   	ret    
  801b01:	8d 76 00             	lea    0x0(%esi),%esi
  801b04:	31 ff                	xor    %edi,%edi
  801b06:	31 c0                	xor    %eax,%eax
  801b08:	89 fa                	mov    %edi,%edx
  801b0a:	83 c4 1c             	add    $0x1c,%esp
  801b0d:	5b                   	pop    %ebx
  801b0e:	5e                   	pop    %esi
  801b0f:	5f                   	pop    %edi
  801b10:	5d                   	pop    %ebp
  801b11:	c3                   	ret    
  801b12:	66 90                	xchg   %ax,%ax
  801b14:	89 d8                	mov    %ebx,%eax
  801b16:	f7 f7                	div    %edi
  801b18:	31 ff                	xor    %edi,%edi
  801b1a:	89 fa                	mov    %edi,%edx
  801b1c:	83 c4 1c             	add    $0x1c,%esp
  801b1f:	5b                   	pop    %ebx
  801b20:	5e                   	pop    %esi
  801b21:	5f                   	pop    %edi
  801b22:	5d                   	pop    %ebp
  801b23:	c3                   	ret    
  801b24:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b29:	89 eb                	mov    %ebp,%ebx
  801b2b:	29 fb                	sub    %edi,%ebx
  801b2d:	89 f9                	mov    %edi,%ecx
  801b2f:	d3 e6                	shl    %cl,%esi
  801b31:	89 c5                	mov    %eax,%ebp
  801b33:	88 d9                	mov    %bl,%cl
  801b35:	d3 ed                	shr    %cl,%ebp
  801b37:	89 e9                	mov    %ebp,%ecx
  801b39:	09 f1                	or     %esi,%ecx
  801b3b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b3f:	89 f9                	mov    %edi,%ecx
  801b41:	d3 e0                	shl    %cl,%eax
  801b43:	89 c5                	mov    %eax,%ebp
  801b45:	89 d6                	mov    %edx,%esi
  801b47:	88 d9                	mov    %bl,%cl
  801b49:	d3 ee                	shr    %cl,%esi
  801b4b:	89 f9                	mov    %edi,%ecx
  801b4d:	d3 e2                	shl    %cl,%edx
  801b4f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b53:	88 d9                	mov    %bl,%cl
  801b55:	d3 e8                	shr    %cl,%eax
  801b57:	09 c2                	or     %eax,%edx
  801b59:	89 d0                	mov    %edx,%eax
  801b5b:	89 f2                	mov    %esi,%edx
  801b5d:	f7 74 24 0c          	divl   0xc(%esp)
  801b61:	89 d6                	mov    %edx,%esi
  801b63:	89 c3                	mov    %eax,%ebx
  801b65:	f7 e5                	mul    %ebp
  801b67:	39 d6                	cmp    %edx,%esi
  801b69:	72 19                	jb     801b84 <__udivdi3+0xfc>
  801b6b:	74 0b                	je     801b78 <__udivdi3+0xf0>
  801b6d:	89 d8                	mov    %ebx,%eax
  801b6f:	31 ff                	xor    %edi,%edi
  801b71:	e9 58 ff ff ff       	jmp    801ace <__udivdi3+0x46>
  801b76:	66 90                	xchg   %ax,%ax
  801b78:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b7c:	89 f9                	mov    %edi,%ecx
  801b7e:	d3 e2                	shl    %cl,%edx
  801b80:	39 c2                	cmp    %eax,%edx
  801b82:	73 e9                	jae    801b6d <__udivdi3+0xe5>
  801b84:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b87:	31 ff                	xor    %edi,%edi
  801b89:	e9 40 ff ff ff       	jmp    801ace <__udivdi3+0x46>
  801b8e:	66 90                	xchg   %ax,%ax
  801b90:	31 c0                	xor    %eax,%eax
  801b92:	e9 37 ff ff ff       	jmp    801ace <__udivdi3+0x46>
  801b97:	90                   	nop

00801b98 <__umoddi3>:
  801b98:	55                   	push   %ebp
  801b99:	57                   	push   %edi
  801b9a:	56                   	push   %esi
  801b9b:	53                   	push   %ebx
  801b9c:	83 ec 1c             	sub    $0x1c,%esp
  801b9f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ba3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ba7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801bab:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801baf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801bb3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801bb7:	89 f3                	mov    %esi,%ebx
  801bb9:	89 fa                	mov    %edi,%edx
  801bbb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bbf:	89 34 24             	mov    %esi,(%esp)
  801bc2:	85 c0                	test   %eax,%eax
  801bc4:	75 1a                	jne    801be0 <__umoddi3+0x48>
  801bc6:	39 f7                	cmp    %esi,%edi
  801bc8:	0f 86 a2 00 00 00    	jbe    801c70 <__umoddi3+0xd8>
  801bce:	89 c8                	mov    %ecx,%eax
  801bd0:	89 f2                	mov    %esi,%edx
  801bd2:	f7 f7                	div    %edi
  801bd4:	89 d0                	mov    %edx,%eax
  801bd6:	31 d2                	xor    %edx,%edx
  801bd8:	83 c4 1c             	add    $0x1c,%esp
  801bdb:	5b                   	pop    %ebx
  801bdc:	5e                   	pop    %esi
  801bdd:	5f                   	pop    %edi
  801bde:	5d                   	pop    %ebp
  801bdf:	c3                   	ret    
  801be0:	39 f0                	cmp    %esi,%eax
  801be2:	0f 87 ac 00 00 00    	ja     801c94 <__umoddi3+0xfc>
  801be8:	0f bd e8             	bsr    %eax,%ebp
  801beb:	83 f5 1f             	xor    $0x1f,%ebp
  801bee:	0f 84 ac 00 00 00    	je     801ca0 <__umoddi3+0x108>
  801bf4:	bf 20 00 00 00       	mov    $0x20,%edi
  801bf9:	29 ef                	sub    %ebp,%edi
  801bfb:	89 fe                	mov    %edi,%esi
  801bfd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c01:	89 e9                	mov    %ebp,%ecx
  801c03:	d3 e0                	shl    %cl,%eax
  801c05:	89 d7                	mov    %edx,%edi
  801c07:	89 f1                	mov    %esi,%ecx
  801c09:	d3 ef                	shr    %cl,%edi
  801c0b:	09 c7                	or     %eax,%edi
  801c0d:	89 e9                	mov    %ebp,%ecx
  801c0f:	d3 e2                	shl    %cl,%edx
  801c11:	89 14 24             	mov    %edx,(%esp)
  801c14:	89 d8                	mov    %ebx,%eax
  801c16:	d3 e0                	shl    %cl,%eax
  801c18:	89 c2                	mov    %eax,%edx
  801c1a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c1e:	d3 e0                	shl    %cl,%eax
  801c20:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c24:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c28:	89 f1                	mov    %esi,%ecx
  801c2a:	d3 e8                	shr    %cl,%eax
  801c2c:	09 d0                	or     %edx,%eax
  801c2e:	d3 eb                	shr    %cl,%ebx
  801c30:	89 da                	mov    %ebx,%edx
  801c32:	f7 f7                	div    %edi
  801c34:	89 d3                	mov    %edx,%ebx
  801c36:	f7 24 24             	mull   (%esp)
  801c39:	89 c6                	mov    %eax,%esi
  801c3b:	89 d1                	mov    %edx,%ecx
  801c3d:	39 d3                	cmp    %edx,%ebx
  801c3f:	0f 82 87 00 00 00    	jb     801ccc <__umoddi3+0x134>
  801c45:	0f 84 91 00 00 00    	je     801cdc <__umoddi3+0x144>
  801c4b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c4f:	29 f2                	sub    %esi,%edx
  801c51:	19 cb                	sbb    %ecx,%ebx
  801c53:	89 d8                	mov    %ebx,%eax
  801c55:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c59:	d3 e0                	shl    %cl,%eax
  801c5b:	89 e9                	mov    %ebp,%ecx
  801c5d:	d3 ea                	shr    %cl,%edx
  801c5f:	09 d0                	or     %edx,%eax
  801c61:	89 e9                	mov    %ebp,%ecx
  801c63:	d3 eb                	shr    %cl,%ebx
  801c65:	89 da                	mov    %ebx,%edx
  801c67:	83 c4 1c             	add    $0x1c,%esp
  801c6a:	5b                   	pop    %ebx
  801c6b:	5e                   	pop    %esi
  801c6c:	5f                   	pop    %edi
  801c6d:	5d                   	pop    %ebp
  801c6e:	c3                   	ret    
  801c6f:	90                   	nop
  801c70:	89 fd                	mov    %edi,%ebp
  801c72:	85 ff                	test   %edi,%edi
  801c74:	75 0b                	jne    801c81 <__umoddi3+0xe9>
  801c76:	b8 01 00 00 00       	mov    $0x1,%eax
  801c7b:	31 d2                	xor    %edx,%edx
  801c7d:	f7 f7                	div    %edi
  801c7f:	89 c5                	mov    %eax,%ebp
  801c81:	89 f0                	mov    %esi,%eax
  801c83:	31 d2                	xor    %edx,%edx
  801c85:	f7 f5                	div    %ebp
  801c87:	89 c8                	mov    %ecx,%eax
  801c89:	f7 f5                	div    %ebp
  801c8b:	89 d0                	mov    %edx,%eax
  801c8d:	e9 44 ff ff ff       	jmp    801bd6 <__umoddi3+0x3e>
  801c92:	66 90                	xchg   %ax,%ax
  801c94:	89 c8                	mov    %ecx,%eax
  801c96:	89 f2                	mov    %esi,%edx
  801c98:	83 c4 1c             	add    $0x1c,%esp
  801c9b:	5b                   	pop    %ebx
  801c9c:	5e                   	pop    %esi
  801c9d:	5f                   	pop    %edi
  801c9e:	5d                   	pop    %ebp
  801c9f:	c3                   	ret    
  801ca0:	3b 04 24             	cmp    (%esp),%eax
  801ca3:	72 06                	jb     801cab <__umoddi3+0x113>
  801ca5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ca9:	77 0f                	ja     801cba <__umoddi3+0x122>
  801cab:	89 f2                	mov    %esi,%edx
  801cad:	29 f9                	sub    %edi,%ecx
  801caf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801cb3:	89 14 24             	mov    %edx,(%esp)
  801cb6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801cba:	8b 44 24 04          	mov    0x4(%esp),%eax
  801cbe:	8b 14 24             	mov    (%esp),%edx
  801cc1:	83 c4 1c             	add    $0x1c,%esp
  801cc4:	5b                   	pop    %ebx
  801cc5:	5e                   	pop    %esi
  801cc6:	5f                   	pop    %edi
  801cc7:	5d                   	pop    %ebp
  801cc8:	c3                   	ret    
  801cc9:	8d 76 00             	lea    0x0(%esi),%esi
  801ccc:	2b 04 24             	sub    (%esp),%eax
  801ccf:	19 fa                	sbb    %edi,%edx
  801cd1:	89 d1                	mov    %edx,%ecx
  801cd3:	89 c6                	mov    %eax,%esi
  801cd5:	e9 71 ff ff ff       	jmp    801c4b <__umoddi3+0xb3>
  801cda:	66 90                	xchg   %ax,%ax
  801cdc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ce0:	72 ea                	jb     801ccc <__umoddi3+0x134>
  801ce2:	89 d9                	mov    %ebx,%ecx
  801ce4:	e9 62 ff ff ff       	jmp    801c4b <__umoddi3+0xb3>
