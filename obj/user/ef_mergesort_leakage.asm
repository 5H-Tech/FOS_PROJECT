
obj/user/ef_mergesort_leakage:     file format elf32-i386


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
  800031:	e8 a8 07 00 00       	call   8007de <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void Merge(int* A, int p, int q, int r);

uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 28 01 00 00    	sub    $0x128,%esp
	char Line[255] ;
	char Chose ;
	int numOfRep = 0;
  800041:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	do
	{
		numOfRep++ ;
  800048:	ff 45 f0             	incl   -0x10(%ebp)
		//2012: lock the interrupt
		sys_disable_interrupt();
  80004b:	e8 22 1e 00 00       	call   801e72 <sys_disable_interrupt>

		cprintf("\n");
  800050:	83 ec 0c             	sub    $0xc,%esp
  800053:	68 00 25 80 00       	push   $0x802500
  800058:	e8 68 0b 00 00       	call   800bc5 <cprintf>
  80005d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800060:	83 ec 0c             	sub    $0xc,%esp
  800063:	68 02 25 80 00       	push   $0x802502
  800068:	e8 58 0b 00 00       	call   800bc5 <cprintf>
  80006d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800070:	83 ec 0c             	sub    $0xc,%esp
  800073:	68 18 25 80 00       	push   $0x802518
  800078:	e8 48 0b 00 00       	call   800bc5 <cprintf>
  80007d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800080:	83 ec 0c             	sub    $0xc,%esp
  800083:	68 02 25 80 00       	push   $0x802502
  800088:	e8 38 0b 00 00       	call   800bc5 <cprintf>
  80008d:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800090:	83 ec 0c             	sub    $0xc,%esp
  800093:	68 00 25 80 00       	push   $0x802500
  800098:	e8 28 0b 00 00       	call   800bc5 <cprintf>
  80009d:	83 c4 10             	add    $0x10,%esp
		cprintf("Enter the number of elements: ");
  8000a0:	83 ec 0c             	sub    $0xc,%esp
  8000a3:	68 30 25 80 00       	push   $0x802530
  8000a8:	e8 18 0b 00 00       	call   800bc5 <cprintf>
  8000ad:	83 c4 10             	add    $0x10,%esp

		int NumOfElements ;

		if (numOfRep == 1)
  8000b0:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  8000b4:	75 09                	jne    8000bf <_main+0x87>
			NumOfElements = 32;
  8000b6:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%ebp)
  8000bd:	eb 0d                	jmp    8000cc <_main+0x94>
		else if (numOfRep == 2)
  8000bf:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  8000c3:	75 07                	jne    8000cc <_main+0x94>
			NumOfElements = 32;
  8000c5:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%ebp)

		cprintf("%d\n", NumOfElements) ;
  8000cc:	83 ec 08             	sub    $0x8,%esp
  8000cf:	ff 75 ec             	pushl  -0x14(%ebp)
  8000d2:	68 4f 25 80 00       	push   $0x80254f
  8000d7:	e8 e9 0a 00 00       	call   800bc5 <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000e2:	c1 e0 02             	shl    $0x2,%eax
  8000e5:	83 ec 0c             	sub    $0xc,%esp
  8000e8:	50                   	push   %eax
  8000e9:	e8 61 18 00 00       	call   80194f <malloc>
  8000ee:	83 c4 10             	add    $0x10,%esp
  8000f1:	89 45 e8             	mov    %eax,-0x18(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000f4:	83 ec 0c             	sub    $0xc,%esp
  8000f7:	68 54 25 80 00       	push   $0x802554
  8000fc:	e8 c4 0a 00 00       	call   800bc5 <cprintf>
  800101:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  800104:	83 ec 0c             	sub    $0xc,%esp
  800107:	68 76 25 80 00       	push   $0x802576
  80010c:	e8 b4 0a 00 00       	call   800bc5 <cprintf>
  800111:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  800114:	83 ec 0c             	sub    $0xc,%esp
  800117:	68 84 25 80 00       	push   $0x802584
  80011c:	e8 a4 0a 00 00       	call   800bc5 <cprintf>
  800121:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800124:	83 ec 0c             	sub    $0xc,%esp
  800127:	68 93 25 80 00       	push   $0x802593
  80012c:	e8 94 0a 00 00       	call   800bc5 <cprintf>
  800131:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800134:	83 ec 0c             	sub    $0xc,%esp
  800137:	68 a3 25 80 00       	push   $0x8025a3
  80013c:	e8 84 0a 00 00       	call   800bc5 <cprintf>
  800141:	83 c4 10             	add    $0x10,%esp
			if (numOfRep == 1)
  800144:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  800148:	75 06                	jne    800150 <_main+0x118>
				Chose = 'a' ;
  80014a:	c6 45 f7 61          	movb   $0x61,-0x9(%ebp)
  80014e:	eb 0a                	jmp    80015a <_main+0x122>
			else if (numOfRep == 2)
  800150:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  800154:	75 04                	jne    80015a <_main+0x122>
				Chose = 'c' ;
  800156:	c6 45 f7 63          	movb   $0x63,-0x9(%ebp)
			cputchar(Chose);
  80015a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80015e:	83 ec 0c             	sub    $0xc,%esp
  800161:	50                   	push   %eax
  800162:	e8 d7 05 00 00       	call   80073e <cputchar>
  800167:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80016a:	83 ec 0c             	sub    $0xc,%esp
  80016d:	6a 0a                	push   $0xa
  80016f:	e8 ca 05 00 00       	call   80073e <cputchar>
  800174:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800177:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  80017b:	74 0c                	je     800189 <_main+0x151>
  80017d:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800181:	74 06                	je     800189 <_main+0x151>
  800183:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800187:	75 ab                	jne    800134 <_main+0xfc>

		//2012: lock the interrupt
		sys_enable_interrupt();
  800189:	e8 fe 1c 00 00       	call   801e8c <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  80018e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800192:	83 f8 62             	cmp    $0x62,%eax
  800195:	74 1d                	je     8001b4 <_main+0x17c>
  800197:	83 f8 63             	cmp    $0x63,%eax
  80019a:	74 2b                	je     8001c7 <_main+0x18f>
  80019c:	83 f8 61             	cmp    $0x61,%eax
  80019f:	75 39                	jne    8001da <_main+0x1a2>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  8001a1:	83 ec 08             	sub    $0x8,%esp
  8001a4:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a7:	ff 75 e8             	pushl  -0x18(%ebp)
  8001aa:	e8 02 02 00 00       	call   8003b1 <InitializeAscending>
  8001af:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b2:	eb 37                	jmp    8001eb <_main+0x1b3>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  8001b4:	83 ec 08             	sub    $0x8,%esp
  8001b7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001ba:	ff 75 e8             	pushl  -0x18(%ebp)
  8001bd:	e8 20 02 00 00       	call   8003e2 <InitializeDescending>
  8001c2:	83 c4 10             	add    $0x10,%esp
			break ;
  8001c5:	eb 24                	jmp    8001eb <_main+0x1b3>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001c7:	83 ec 08             	sub    $0x8,%esp
  8001ca:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cd:	ff 75 e8             	pushl  -0x18(%ebp)
  8001d0:	e8 42 02 00 00       	call   800417 <InitializeSemiRandom>
  8001d5:	83 c4 10             	add    $0x10,%esp
			break ;
  8001d8:	eb 11                	jmp    8001eb <_main+0x1b3>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001da:	83 ec 08             	sub    $0x8,%esp
  8001dd:	ff 75 ec             	pushl  -0x14(%ebp)
  8001e0:	ff 75 e8             	pushl  -0x18(%ebp)
  8001e3:	e8 2f 02 00 00       	call   800417 <InitializeSemiRandom>
  8001e8:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001eb:	83 ec 04             	sub    $0x4,%esp
  8001ee:	ff 75 ec             	pushl  -0x14(%ebp)
  8001f1:	6a 01                	push   $0x1
  8001f3:	ff 75 e8             	pushl  -0x18(%ebp)
  8001f6:	e8 ee 02 00 00       	call   8004e9 <MSort>
  8001fb:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001fe:	e8 6f 1c 00 00       	call   801e72 <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  800203:	83 ec 0c             	sub    $0xc,%esp
  800206:	68 ac 25 80 00       	push   $0x8025ac
  80020b:	e8 b5 09 00 00       	call   800bc5 <cprintf>
  800210:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  800213:	e8 74 1c 00 00       	call   801e8c <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800218:	83 ec 08             	sub    $0x8,%esp
  80021b:	ff 75 ec             	pushl  -0x14(%ebp)
  80021e:	ff 75 e8             	pushl  -0x18(%ebp)
  800221:	e8 e1 00 00 00       	call   800307 <CheckSorted>
  800226:	83 c4 10             	add    $0x10,%esp
  800229:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  80022c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800230:	75 14                	jne    800246 <_main+0x20e>
  800232:	83 ec 04             	sub    $0x4,%esp
  800235:	68 e0 25 80 00       	push   $0x8025e0
  80023a:	6a 58                	push   $0x58
  80023c:	68 02 26 80 00       	push   $0x802602
  800241:	e8 dd 06 00 00       	call   800923 <_panic>
		else
		{
			sys_disable_interrupt();
  800246:	e8 27 1c 00 00       	call   801e72 <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  80024b:	83 ec 0c             	sub    $0xc,%esp
  80024e:	68 20 26 80 00       	push   $0x802620
  800253:	e8 6d 09 00 00       	call   800bc5 <cprintf>
  800258:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80025b:	83 ec 0c             	sub    $0xc,%esp
  80025e:	68 54 26 80 00       	push   $0x802654
  800263:	e8 5d 09 00 00       	call   800bc5 <cprintf>
  800268:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80026b:	83 ec 0c             	sub    $0xc,%esp
  80026e:	68 88 26 80 00       	push   $0x802688
  800273:	e8 4d 09 00 00       	call   800bc5 <cprintf>
  800278:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80027b:	e8 0c 1c 00 00       	call   801e8c <sys_enable_interrupt>
		}

		free(Elements) ;
  800280:	83 ec 0c             	sub    $0xc,%esp
  800283:	ff 75 e8             	pushl  -0x18(%ebp)
  800286:	e8 d4 18 00 00       	call   801b5f <free>
  80028b:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  80028e:	e8 df 1b 00 00       	call   801e72 <sys_disable_interrupt>
		Chose = 0 ;
  800293:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
		while (Chose != 'y' && Chose != 'n')
  800297:	eb 50                	jmp    8002e9 <_main+0x2b1>
		{
			cprintf("Do you want to repeat (y/n): ") ;
  800299:	83 ec 0c             	sub    $0xc,%esp
  80029c:	68 ba 26 80 00       	push   $0x8026ba
  8002a1:	e8 1f 09 00 00       	call   800bc5 <cprintf>
  8002a6:	83 c4 10             	add    $0x10,%esp
			if (numOfRep == 1)
  8002a9:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  8002ad:	75 06                	jne    8002b5 <_main+0x27d>
				Chose = 'y' ;
  8002af:	c6 45 f7 79          	movb   $0x79,-0x9(%ebp)
  8002b3:	eb 0a                	jmp    8002bf <_main+0x287>
			else if (numOfRep == 2)
  8002b5:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  8002b9:	75 04                	jne    8002bf <_main+0x287>
				Chose = 'n' ;
  8002bb:	c6 45 f7 6e          	movb   $0x6e,-0x9(%ebp)
			cputchar(Chose);
  8002bf:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8002c3:	83 ec 0c             	sub    $0xc,%esp
  8002c6:	50                   	push   %eax
  8002c7:	e8 72 04 00 00       	call   80073e <cputchar>
  8002cc:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8002cf:	83 ec 0c             	sub    $0xc,%esp
  8002d2:	6a 0a                	push   $0xa
  8002d4:	e8 65 04 00 00       	call   80073e <cputchar>
  8002d9:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8002dc:	83 ec 0c             	sub    $0xc,%esp
  8002df:	6a 0a                	push   $0xa
  8002e1:	e8 58 04 00 00       	call   80073e <cputchar>
  8002e6:	83 c4 10             	add    $0x10,%esp

		free(Elements) ;

		sys_disable_interrupt();
		Chose = 0 ;
		while (Chose != 'y' && Chose != 'n')
  8002e9:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002ed:	74 06                	je     8002f5 <_main+0x2bd>
  8002ef:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002f3:	75 a4                	jne    800299 <_main+0x261>
				Chose = 'n' ;
			cputchar(Chose);
			cputchar('\n');
			cputchar('\n');
		}
		sys_enable_interrupt();
  8002f5:	e8 92 1b 00 00       	call   801e8c <sys_enable_interrupt>

	} while (Chose == 'y');
  8002fa:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002fe:	0f 84 44 fd ff ff    	je     800048 <_main+0x10>
}
  800304:	90                   	nop
  800305:	c9                   	leave  
  800306:	c3                   	ret    

00800307 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800307:	55                   	push   %ebp
  800308:	89 e5                	mov    %esp,%ebp
  80030a:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  80030d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800314:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80031b:	eb 33                	jmp    800350 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80031d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800320:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800327:	8b 45 08             	mov    0x8(%ebp),%eax
  80032a:	01 d0                	add    %edx,%eax
  80032c:	8b 10                	mov    (%eax),%edx
  80032e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800331:	40                   	inc    %eax
  800332:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800339:	8b 45 08             	mov    0x8(%ebp),%eax
  80033c:	01 c8                	add    %ecx,%eax
  80033e:	8b 00                	mov    (%eax),%eax
  800340:	39 c2                	cmp    %eax,%edx
  800342:	7e 09                	jle    80034d <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800344:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80034b:	eb 0c                	jmp    800359 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80034d:	ff 45 f8             	incl   -0x8(%ebp)
  800350:	8b 45 0c             	mov    0xc(%ebp),%eax
  800353:	48                   	dec    %eax
  800354:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800357:	7f c4                	jg     80031d <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800359:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80035c:	c9                   	leave  
  80035d:	c3                   	ret    

0080035e <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80035e:	55                   	push   %ebp
  80035f:	89 e5                	mov    %esp,%ebp
  800361:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800364:	8b 45 0c             	mov    0xc(%ebp),%eax
  800367:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80036e:	8b 45 08             	mov    0x8(%ebp),%eax
  800371:	01 d0                	add    %edx,%eax
  800373:	8b 00                	mov    (%eax),%eax
  800375:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800378:	8b 45 0c             	mov    0xc(%ebp),%eax
  80037b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800382:	8b 45 08             	mov    0x8(%ebp),%eax
  800385:	01 c2                	add    %eax,%edx
  800387:	8b 45 10             	mov    0x10(%ebp),%eax
  80038a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800391:	8b 45 08             	mov    0x8(%ebp),%eax
  800394:	01 c8                	add    %ecx,%eax
  800396:	8b 00                	mov    (%eax),%eax
  800398:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  80039a:	8b 45 10             	mov    0x10(%ebp),%eax
  80039d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a7:	01 c2                	add    %eax,%edx
  8003a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003ac:	89 02                	mov    %eax,(%edx)
}
  8003ae:	90                   	nop
  8003af:	c9                   	leave  
  8003b0:	c3                   	ret    

008003b1 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8003b1:	55                   	push   %ebp
  8003b2:	89 e5                	mov    %esp,%ebp
  8003b4:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003b7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003be:	eb 17                	jmp    8003d7 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  8003c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cd:	01 c2                	add    %eax,%edx
  8003cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003d2:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003d4:	ff 45 fc             	incl   -0x4(%ebp)
  8003d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003da:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003dd:	7c e1                	jl     8003c0 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8003df:	90                   	nop
  8003e0:	c9                   	leave  
  8003e1:	c3                   	ret    

008003e2 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8003e2:	55                   	push   %ebp
  8003e3:	89 e5                	mov    %esp,%ebp
  8003e5:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003e8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003ef:	eb 1b                	jmp    80040c <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003f4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fe:	01 c2                	add    %eax,%edx
  800400:	8b 45 0c             	mov    0xc(%ebp),%eax
  800403:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800406:	48                   	dec    %eax
  800407:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800409:	ff 45 fc             	incl   -0x4(%ebp)
  80040c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80040f:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800412:	7c dd                	jl     8003f1 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800414:	90                   	nop
  800415:	c9                   	leave  
  800416:	c3                   	ret    

00800417 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800417:	55                   	push   %ebp
  800418:	89 e5                	mov    %esp,%ebp
  80041a:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80041d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800420:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800425:	f7 e9                	imul   %ecx
  800427:	c1 f9 1f             	sar    $0x1f,%ecx
  80042a:	89 d0                	mov    %edx,%eax
  80042c:	29 c8                	sub    %ecx,%eax
  80042e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800431:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800438:	eb 1e                	jmp    800458 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  80043a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80043d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800444:	8b 45 08             	mov    0x8(%ebp),%eax
  800447:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80044a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80044d:	99                   	cltd   
  80044e:	f7 7d f8             	idivl  -0x8(%ebp)
  800451:	89 d0                	mov    %edx,%eax
  800453:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800455:	ff 45 fc             	incl   -0x4(%ebp)
  800458:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80045b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80045e:	7c da                	jl     80043a <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  800460:	90                   	nop
  800461:	c9                   	leave  
  800462:	c3                   	ret    

00800463 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800463:	55                   	push   %ebp
  800464:	89 e5                	mov    %esp,%ebp
  800466:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800469:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800470:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800477:	eb 42                	jmp    8004bb <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800479:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80047c:	99                   	cltd   
  80047d:	f7 7d f0             	idivl  -0x10(%ebp)
  800480:	89 d0                	mov    %edx,%eax
  800482:	85 c0                	test   %eax,%eax
  800484:	75 10                	jne    800496 <PrintElements+0x33>
			cprintf("\n");
  800486:	83 ec 0c             	sub    $0xc,%esp
  800489:	68 00 25 80 00       	push   $0x802500
  80048e:	e8 32 07 00 00       	call   800bc5 <cprintf>
  800493:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800496:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800499:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a3:	01 d0                	add    %edx,%eax
  8004a5:	8b 00                	mov    (%eax),%eax
  8004a7:	83 ec 08             	sub    $0x8,%esp
  8004aa:	50                   	push   %eax
  8004ab:	68 d8 26 80 00       	push   $0x8026d8
  8004b0:	e8 10 07 00 00       	call   800bc5 <cprintf>
  8004b5:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8004b8:	ff 45 f4             	incl   -0xc(%ebp)
  8004bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004be:	48                   	dec    %eax
  8004bf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8004c2:	7f b5                	jg     800479 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  8004c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004c7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d1:	01 d0                	add    %edx,%eax
  8004d3:	8b 00                	mov    (%eax),%eax
  8004d5:	83 ec 08             	sub    $0x8,%esp
  8004d8:	50                   	push   %eax
  8004d9:	68 4f 25 80 00       	push   $0x80254f
  8004de:	e8 e2 06 00 00       	call   800bc5 <cprintf>
  8004e3:	83 c4 10             	add    $0x10,%esp

}
  8004e6:	90                   	nop
  8004e7:	c9                   	leave  
  8004e8:	c3                   	ret    

008004e9 <MSort>:


void MSort(int* A, int p, int r)
{
  8004e9:	55                   	push   %ebp
  8004ea:	89 e5                	mov    %esp,%ebp
  8004ec:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004f5:	7d 54                	jge    80054b <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8004fd:	01 d0                	add    %edx,%eax
  8004ff:	89 c2                	mov    %eax,%edx
  800501:	c1 ea 1f             	shr    $0x1f,%edx
  800504:	01 d0                	add    %edx,%eax
  800506:	d1 f8                	sar    %eax
  800508:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  80050b:	83 ec 04             	sub    $0x4,%esp
  80050e:	ff 75 f4             	pushl  -0xc(%ebp)
  800511:	ff 75 0c             	pushl  0xc(%ebp)
  800514:	ff 75 08             	pushl  0x8(%ebp)
  800517:	e8 cd ff ff ff       	call   8004e9 <MSort>
  80051c:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  80051f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800522:	40                   	inc    %eax
  800523:	83 ec 04             	sub    $0x4,%esp
  800526:	ff 75 10             	pushl  0x10(%ebp)
  800529:	50                   	push   %eax
  80052a:	ff 75 08             	pushl  0x8(%ebp)
  80052d:	e8 b7 ff ff ff       	call   8004e9 <MSort>
  800532:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  800535:	ff 75 10             	pushl  0x10(%ebp)
  800538:	ff 75 f4             	pushl  -0xc(%ebp)
  80053b:	ff 75 0c             	pushl  0xc(%ebp)
  80053e:	ff 75 08             	pushl  0x8(%ebp)
  800541:	e8 08 00 00 00       	call   80054e <Merge>
  800546:	83 c4 10             	add    $0x10,%esp
  800549:	eb 01                	jmp    80054c <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  80054b:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  80054c:	c9                   	leave  
  80054d:	c3                   	ret    

0080054e <Merge>:

void Merge(int* A, int p, int q, int r)
{
  80054e:	55                   	push   %ebp
  80054f:	89 e5                	mov    %esp,%ebp
  800551:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  800554:	8b 45 10             	mov    0x10(%ebp),%eax
  800557:	2b 45 0c             	sub    0xc(%ebp),%eax
  80055a:	40                   	inc    %eax
  80055b:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  80055e:	8b 45 14             	mov    0x14(%ebp),%eax
  800561:	2b 45 10             	sub    0x10(%ebp),%eax
  800564:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800567:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  80056e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  800575:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800578:	c1 e0 02             	shl    $0x2,%eax
  80057b:	83 ec 0c             	sub    $0xc,%esp
  80057e:	50                   	push   %eax
  80057f:	e8 cb 13 00 00       	call   80194f <malloc>
  800584:	83 c4 10             	add    $0x10,%esp
  800587:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  80058a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80058d:	c1 e0 02             	shl    $0x2,%eax
  800590:	83 ec 0c             	sub    $0xc,%esp
  800593:	50                   	push   %eax
  800594:	e8 b6 13 00 00       	call   80194f <malloc>
  800599:	83 c4 10             	add    $0x10,%esp
  80059c:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80059f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8005a6:	eb 2f                	jmp    8005d7 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  8005a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005ab:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005b2:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8005b5:	01 c2                	add    %eax,%edx
  8005b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8005ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005bd:	01 c8                	add    %ecx,%eax
  8005bf:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8005c4:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ce:	01 c8                	add    %ecx,%eax
  8005d0:	8b 00                	mov    (%eax),%eax
  8005d2:	89 02                	mov    %eax,(%edx)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  8005d4:	ff 45 ec             	incl   -0x14(%ebp)
  8005d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005da:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005dd:	7c c9                	jl     8005a8 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005df:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005e6:	eb 2a                	jmp    800612 <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005f2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005f5:	01 c2                	add    %eax,%edx
  8005f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005fd:	01 c8                	add    %ecx,%eax
  8005ff:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800606:	8b 45 08             	mov    0x8(%ebp),%eax
  800609:	01 c8                	add    %ecx,%eax
  80060b:	8b 00                	mov    (%eax),%eax
  80060d:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  80060f:	ff 45 e8             	incl   -0x18(%ebp)
  800612:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800615:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800618:	7c ce                	jl     8005e8 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  80061a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80061d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800620:	e9 0a 01 00 00       	jmp    80072f <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  800625:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800628:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80062b:	0f 8d 95 00 00 00    	jge    8006c6 <Merge+0x178>
  800631:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800634:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800637:	0f 8d 89 00 00 00    	jge    8006c6 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80063d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800640:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800647:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80064a:	01 d0                	add    %edx,%eax
  80064c:	8b 10                	mov    (%eax),%edx
  80064e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800651:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800658:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80065b:	01 c8                	add    %ecx,%eax
  80065d:	8b 00                	mov    (%eax),%eax
  80065f:	39 c2                	cmp    %eax,%edx
  800661:	7d 33                	jge    800696 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  800663:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800666:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80066b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800672:	8b 45 08             	mov    0x8(%ebp),%eax
  800675:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800678:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80067b:	8d 50 01             	lea    0x1(%eax),%edx
  80067e:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800681:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800688:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80068b:	01 d0                	add    %edx,%eax
  80068d:	8b 00                	mov    (%eax),%eax
  80068f:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800691:	e9 96 00 00 00       	jmp    80072c <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800696:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800699:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80069e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a8:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006ae:	8d 50 01             	lea    0x1(%eax),%edx
  8006b1:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006b4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006bb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006be:	01 d0                	add    %edx,%eax
  8006c0:	8b 00                	mov    (%eax),%eax
  8006c2:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8006c4:	eb 66                	jmp    80072c <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  8006c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006c9:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8006cc:	7d 30                	jge    8006fe <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  8006ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006d1:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006d6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e0:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006e6:	8d 50 01             	lea    0x1(%eax),%edx
  8006e9:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006f3:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006f6:	01 d0                	add    %edx,%eax
  8006f8:	8b 00                	mov    (%eax),%eax
  8006fa:	89 01                	mov    %eax,(%ecx)
  8006fc:	eb 2e                	jmp    80072c <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800701:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800706:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80070d:	8b 45 08             	mov    0x8(%ebp),%eax
  800710:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800713:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800716:	8d 50 01             	lea    0x1(%eax),%edx
  800719:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80071c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800723:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800726:	01 d0                	add    %edx,%eax
  800728:	8b 00                	mov    (%eax),%eax
  80072a:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  80072c:	ff 45 e4             	incl   -0x1c(%ebp)
  80072f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800732:	3b 45 14             	cmp    0x14(%ebp),%eax
  800735:	0f 8e ea fe ff ff    	jle    800625 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

}
  80073b:	90                   	nop
  80073c:	c9                   	leave  
  80073d:	c3                   	ret    

0080073e <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80073e:	55                   	push   %ebp
  80073f:	89 e5                	mov    %esp,%ebp
  800741:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800744:	8b 45 08             	mov    0x8(%ebp),%eax
  800747:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80074a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80074e:	83 ec 0c             	sub    $0xc,%esp
  800751:	50                   	push   %eax
  800752:	e8 4f 17 00 00       	call   801ea6 <sys_cputc>
  800757:	83 c4 10             	add    $0x10,%esp
}
  80075a:	90                   	nop
  80075b:	c9                   	leave  
  80075c:	c3                   	ret    

0080075d <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80075d:	55                   	push   %ebp
  80075e:	89 e5                	mov    %esp,%ebp
  800760:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800763:	e8 0a 17 00 00       	call   801e72 <sys_disable_interrupt>
	char c = ch;
  800768:	8b 45 08             	mov    0x8(%ebp),%eax
  80076b:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80076e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800772:	83 ec 0c             	sub    $0xc,%esp
  800775:	50                   	push   %eax
  800776:	e8 2b 17 00 00       	call   801ea6 <sys_cputc>
  80077b:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80077e:	e8 09 17 00 00       	call   801e8c <sys_enable_interrupt>
}
  800783:	90                   	nop
  800784:	c9                   	leave  
  800785:	c3                   	ret    

00800786 <getchar>:

int
getchar(void)
{
  800786:	55                   	push   %ebp
  800787:	89 e5                	mov    %esp,%ebp
  800789:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  80078c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800793:	eb 08                	jmp    80079d <getchar+0x17>
	{
		c = sys_cgetc();
  800795:	e8 f0 14 00 00       	call   801c8a <sys_cgetc>
  80079a:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  80079d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8007a1:	74 f2                	je     800795 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8007a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8007a6:	c9                   	leave  
  8007a7:	c3                   	ret    

008007a8 <atomic_getchar>:

int
atomic_getchar(void)
{
  8007a8:	55                   	push   %ebp
  8007a9:	89 e5                	mov    %esp,%ebp
  8007ab:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8007ae:	e8 bf 16 00 00       	call   801e72 <sys_disable_interrupt>
	int c=0;
  8007b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8007ba:	eb 08                	jmp    8007c4 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8007bc:	e8 c9 14 00 00       	call   801c8a <sys_cgetc>
  8007c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8007c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8007c8:	74 f2                	je     8007bc <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8007ca:	e8 bd 16 00 00       	call   801e8c <sys_enable_interrupt>
	return c;
  8007cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8007d2:	c9                   	leave  
  8007d3:	c3                   	ret    

008007d4 <iscons>:

int iscons(int fdnum)
{
  8007d4:	55                   	push   %ebp
  8007d5:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007d7:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007dc:	5d                   	pop    %ebp
  8007dd:	c3                   	ret    

008007de <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8007de:	55                   	push   %ebp
  8007df:	89 e5                	mov    %esp,%ebp
  8007e1:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007e4:	e8 ee 14 00 00       	call   801cd7 <sys_getenvindex>
  8007e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007ec:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007ef:	89 d0                	mov    %edx,%eax
  8007f1:	c1 e0 03             	shl    $0x3,%eax
  8007f4:	01 d0                	add    %edx,%eax
  8007f6:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8007fd:	01 c8                	add    %ecx,%eax
  8007ff:	01 c0                	add    %eax,%eax
  800801:	01 d0                	add    %edx,%eax
  800803:	01 c0                	add    %eax,%eax
  800805:	01 d0                	add    %edx,%eax
  800807:	89 c2                	mov    %eax,%edx
  800809:	c1 e2 05             	shl    $0x5,%edx
  80080c:	29 c2                	sub    %eax,%edx
  80080e:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800815:	89 c2                	mov    %eax,%edx
  800817:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80081d:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800822:	a1 24 30 80 00       	mov    0x803024,%eax
  800827:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80082d:	84 c0                	test   %al,%al
  80082f:	74 0f                	je     800840 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800831:	a1 24 30 80 00       	mov    0x803024,%eax
  800836:	05 40 3c 01 00       	add    $0x13c40,%eax
  80083b:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800840:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800844:	7e 0a                	jle    800850 <libmain+0x72>
		binaryname = argv[0];
  800846:	8b 45 0c             	mov    0xc(%ebp),%eax
  800849:	8b 00                	mov    (%eax),%eax
  80084b:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800850:	83 ec 08             	sub    $0x8,%esp
  800853:	ff 75 0c             	pushl  0xc(%ebp)
  800856:	ff 75 08             	pushl  0x8(%ebp)
  800859:	e8 da f7 ff ff       	call   800038 <_main>
  80085e:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800861:	e8 0c 16 00 00       	call   801e72 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800866:	83 ec 0c             	sub    $0xc,%esp
  800869:	68 f8 26 80 00       	push   $0x8026f8
  80086e:	e8 52 03 00 00       	call   800bc5 <cprintf>
  800873:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800876:	a1 24 30 80 00       	mov    0x803024,%eax
  80087b:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800881:	a1 24 30 80 00       	mov    0x803024,%eax
  800886:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80088c:	83 ec 04             	sub    $0x4,%esp
  80088f:	52                   	push   %edx
  800890:	50                   	push   %eax
  800891:	68 20 27 80 00       	push   $0x802720
  800896:	e8 2a 03 00 00       	call   800bc5 <cprintf>
  80089b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80089e:	a1 24 30 80 00       	mov    0x803024,%eax
  8008a3:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8008a9:	a1 24 30 80 00       	mov    0x803024,%eax
  8008ae:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8008b4:	83 ec 04             	sub    $0x4,%esp
  8008b7:	52                   	push   %edx
  8008b8:	50                   	push   %eax
  8008b9:	68 48 27 80 00       	push   $0x802748
  8008be:	e8 02 03 00 00       	call   800bc5 <cprintf>
  8008c3:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8008c6:	a1 24 30 80 00       	mov    0x803024,%eax
  8008cb:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8008d1:	83 ec 08             	sub    $0x8,%esp
  8008d4:	50                   	push   %eax
  8008d5:	68 89 27 80 00       	push   $0x802789
  8008da:	e8 e6 02 00 00       	call   800bc5 <cprintf>
  8008df:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8008e2:	83 ec 0c             	sub    $0xc,%esp
  8008e5:	68 f8 26 80 00       	push   $0x8026f8
  8008ea:	e8 d6 02 00 00       	call   800bc5 <cprintf>
  8008ef:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8008f2:	e8 95 15 00 00       	call   801e8c <sys_enable_interrupt>

	// exit gracefully
	exit();
  8008f7:	e8 19 00 00 00       	call   800915 <exit>
}
  8008fc:	90                   	nop
  8008fd:	c9                   	leave  
  8008fe:	c3                   	ret    

008008ff <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008ff:	55                   	push   %ebp
  800900:	89 e5                	mov    %esp,%ebp
  800902:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800905:	83 ec 0c             	sub    $0xc,%esp
  800908:	6a 00                	push   $0x0
  80090a:	e8 94 13 00 00       	call   801ca3 <sys_env_destroy>
  80090f:	83 c4 10             	add    $0x10,%esp
}
  800912:	90                   	nop
  800913:	c9                   	leave  
  800914:	c3                   	ret    

00800915 <exit>:

void
exit(void)
{
  800915:	55                   	push   %ebp
  800916:	89 e5                	mov    %esp,%ebp
  800918:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80091b:	e8 e9 13 00 00       	call   801d09 <sys_env_exit>
}
  800920:	90                   	nop
  800921:	c9                   	leave  
  800922:	c3                   	ret    

00800923 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800923:	55                   	push   %ebp
  800924:	89 e5                	mov    %esp,%ebp
  800926:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800929:	8d 45 10             	lea    0x10(%ebp),%eax
  80092c:	83 c0 04             	add    $0x4,%eax
  80092f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800932:	a1 18 31 80 00       	mov    0x803118,%eax
  800937:	85 c0                	test   %eax,%eax
  800939:	74 16                	je     800951 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80093b:	a1 18 31 80 00       	mov    0x803118,%eax
  800940:	83 ec 08             	sub    $0x8,%esp
  800943:	50                   	push   %eax
  800944:	68 a0 27 80 00       	push   $0x8027a0
  800949:	e8 77 02 00 00       	call   800bc5 <cprintf>
  80094e:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800951:	a1 00 30 80 00       	mov    0x803000,%eax
  800956:	ff 75 0c             	pushl  0xc(%ebp)
  800959:	ff 75 08             	pushl  0x8(%ebp)
  80095c:	50                   	push   %eax
  80095d:	68 a5 27 80 00       	push   $0x8027a5
  800962:	e8 5e 02 00 00       	call   800bc5 <cprintf>
  800967:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80096a:	8b 45 10             	mov    0x10(%ebp),%eax
  80096d:	83 ec 08             	sub    $0x8,%esp
  800970:	ff 75 f4             	pushl  -0xc(%ebp)
  800973:	50                   	push   %eax
  800974:	e8 e1 01 00 00       	call   800b5a <vcprintf>
  800979:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80097c:	83 ec 08             	sub    $0x8,%esp
  80097f:	6a 00                	push   $0x0
  800981:	68 c1 27 80 00       	push   $0x8027c1
  800986:	e8 cf 01 00 00       	call   800b5a <vcprintf>
  80098b:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80098e:	e8 82 ff ff ff       	call   800915 <exit>

	// should not return here
	while (1) ;
  800993:	eb fe                	jmp    800993 <_panic+0x70>

00800995 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800995:	55                   	push   %ebp
  800996:	89 e5                	mov    %esp,%ebp
  800998:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80099b:	a1 24 30 80 00       	mov    0x803024,%eax
  8009a0:	8b 50 74             	mov    0x74(%eax),%edx
  8009a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a6:	39 c2                	cmp    %eax,%edx
  8009a8:	74 14                	je     8009be <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8009aa:	83 ec 04             	sub    $0x4,%esp
  8009ad:	68 c4 27 80 00       	push   $0x8027c4
  8009b2:	6a 26                	push   $0x26
  8009b4:	68 10 28 80 00       	push   $0x802810
  8009b9:	e8 65 ff ff ff       	call   800923 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8009be:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8009c5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8009cc:	e9 b6 00 00 00       	jmp    800a87 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8009d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009d4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009db:	8b 45 08             	mov    0x8(%ebp),%eax
  8009de:	01 d0                	add    %edx,%eax
  8009e0:	8b 00                	mov    (%eax),%eax
  8009e2:	85 c0                	test   %eax,%eax
  8009e4:	75 08                	jne    8009ee <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8009e6:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8009e9:	e9 96 00 00 00       	jmp    800a84 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8009ee:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009f5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8009fc:	eb 5d                	jmp    800a5b <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009fe:	a1 24 30 80 00       	mov    0x803024,%eax
  800a03:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800a09:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a0c:	c1 e2 04             	shl    $0x4,%edx
  800a0f:	01 d0                	add    %edx,%eax
  800a11:	8a 40 04             	mov    0x4(%eax),%al
  800a14:	84 c0                	test   %al,%al
  800a16:	75 40                	jne    800a58 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a18:	a1 24 30 80 00       	mov    0x803024,%eax
  800a1d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800a23:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a26:	c1 e2 04             	shl    $0x4,%edx
  800a29:	01 d0                	add    %edx,%eax
  800a2b:	8b 00                	mov    (%eax),%eax
  800a2d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800a30:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a33:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800a38:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800a3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a3d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a44:	8b 45 08             	mov    0x8(%ebp),%eax
  800a47:	01 c8                	add    %ecx,%eax
  800a49:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a4b:	39 c2                	cmp    %eax,%edx
  800a4d:	75 09                	jne    800a58 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800a4f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a56:	eb 12                	jmp    800a6a <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a58:	ff 45 e8             	incl   -0x18(%ebp)
  800a5b:	a1 24 30 80 00       	mov    0x803024,%eax
  800a60:	8b 50 74             	mov    0x74(%eax),%edx
  800a63:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a66:	39 c2                	cmp    %eax,%edx
  800a68:	77 94                	ja     8009fe <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a6a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a6e:	75 14                	jne    800a84 <CheckWSWithoutLastIndex+0xef>
			panic(
  800a70:	83 ec 04             	sub    $0x4,%esp
  800a73:	68 1c 28 80 00       	push   $0x80281c
  800a78:	6a 3a                	push   $0x3a
  800a7a:	68 10 28 80 00       	push   $0x802810
  800a7f:	e8 9f fe ff ff       	call   800923 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a84:	ff 45 f0             	incl   -0x10(%ebp)
  800a87:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a8a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a8d:	0f 8c 3e ff ff ff    	jl     8009d1 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a93:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a9a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800aa1:	eb 20                	jmp    800ac3 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800aa3:	a1 24 30 80 00       	mov    0x803024,%eax
  800aa8:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800aae:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ab1:	c1 e2 04             	shl    $0x4,%edx
  800ab4:	01 d0                	add    %edx,%eax
  800ab6:	8a 40 04             	mov    0x4(%eax),%al
  800ab9:	3c 01                	cmp    $0x1,%al
  800abb:	75 03                	jne    800ac0 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800abd:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ac0:	ff 45 e0             	incl   -0x20(%ebp)
  800ac3:	a1 24 30 80 00       	mov    0x803024,%eax
  800ac8:	8b 50 74             	mov    0x74(%eax),%edx
  800acb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ace:	39 c2                	cmp    %eax,%edx
  800ad0:	77 d1                	ja     800aa3 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800ad2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ad5:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800ad8:	74 14                	je     800aee <CheckWSWithoutLastIndex+0x159>
		panic(
  800ada:	83 ec 04             	sub    $0x4,%esp
  800add:	68 70 28 80 00       	push   $0x802870
  800ae2:	6a 44                	push   $0x44
  800ae4:	68 10 28 80 00       	push   $0x802810
  800ae9:	e8 35 fe ff ff       	call   800923 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800aee:	90                   	nop
  800aef:	c9                   	leave  
  800af0:	c3                   	ret    

00800af1 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800af1:	55                   	push   %ebp
  800af2:	89 e5                	mov    %esp,%ebp
  800af4:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800af7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afa:	8b 00                	mov    (%eax),%eax
  800afc:	8d 48 01             	lea    0x1(%eax),%ecx
  800aff:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b02:	89 0a                	mov    %ecx,(%edx)
  800b04:	8b 55 08             	mov    0x8(%ebp),%edx
  800b07:	88 d1                	mov    %dl,%cl
  800b09:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b0c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800b10:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b13:	8b 00                	mov    (%eax),%eax
  800b15:	3d ff 00 00 00       	cmp    $0xff,%eax
  800b1a:	75 2c                	jne    800b48 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800b1c:	a0 28 30 80 00       	mov    0x803028,%al
  800b21:	0f b6 c0             	movzbl %al,%eax
  800b24:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b27:	8b 12                	mov    (%edx),%edx
  800b29:	89 d1                	mov    %edx,%ecx
  800b2b:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b2e:	83 c2 08             	add    $0x8,%edx
  800b31:	83 ec 04             	sub    $0x4,%esp
  800b34:	50                   	push   %eax
  800b35:	51                   	push   %ecx
  800b36:	52                   	push   %edx
  800b37:	e8 25 11 00 00       	call   801c61 <sys_cputs>
  800b3c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800b3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b42:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b4b:	8b 40 04             	mov    0x4(%eax),%eax
  800b4e:	8d 50 01             	lea    0x1(%eax),%edx
  800b51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b54:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b57:	90                   	nop
  800b58:	c9                   	leave  
  800b59:	c3                   	ret    

00800b5a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b5a:	55                   	push   %ebp
  800b5b:	89 e5                	mov    %esp,%ebp
  800b5d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b63:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b6a:	00 00 00 
	b.cnt = 0;
  800b6d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b74:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b77:	ff 75 0c             	pushl  0xc(%ebp)
  800b7a:	ff 75 08             	pushl  0x8(%ebp)
  800b7d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b83:	50                   	push   %eax
  800b84:	68 f1 0a 80 00       	push   $0x800af1
  800b89:	e8 11 02 00 00       	call   800d9f <vprintfmt>
  800b8e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b91:	a0 28 30 80 00       	mov    0x803028,%al
  800b96:	0f b6 c0             	movzbl %al,%eax
  800b99:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b9f:	83 ec 04             	sub    $0x4,%esp
  800ba2:	50                   	push   %eax
  800ba3:	52                   	push   %edx
  800ba4:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800baa:	83 c0 08             	add    $0x8,%eax
  800bad:	50                   	push   %eax
  800bae:	e8 ae 10 00 00       	call   801c61 <sys_cputs>
  800bb3:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800bb6:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800bbd:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800bc3:	c9                   	leave  
  800bc4:	c3                   	ret    

00800bc5 <cprintf>:

int cprintf(const char *fmt, ...) {
  800bc5:	55                   	push   %ebp
  800bc6:	89 e5                	mov    %esp,%ebp
  800bc8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800bcb:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800bd2:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bd5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdb:	83 ec 08             	sub    $0x8,%esp
  800bde:	ff 75 f4             	pushl  -0xc(%ebp)
  800be1:	50                   	push   %eax
  800be2:	e8 73 ff ff ff       	call   800b5a <vcprintf>
  800be7:	83 c4 10             	add    $0x10,%esp
  800bea:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800bed:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bf0:	c9                   	leave  
  800bf1:	c3                   	ret    

00800bf2 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800bf2:	55                   	push   %ebp
  800bf3:	89 e5                	mov    %esp,%ebp
  800bf5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bf8:	e8 75 12 00 00       	call   801e72 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800bfd:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c00:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c03:	8b 45 08             	mov    0x8(%ebp),%eax
  800c06:	83 ec 08             	sub    $0x8,%esp
  800c09:	ff 75 f4             	pushl  -0xc(%ebp)
  800c0c:	50                   	push   %eax
  800c0d:	e8 48 ff ff ff       	call   800b5a <vcprintf>
  800c12:	83 c4 10             	add    $0x10,%esp
  800c15:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800c18:	e8 6f 12 00 00       	call   801e8c <sys_enable_interrupt>
	return cnt;
  800c1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c20:	c9                   	leave  
  800c21:	c3                   	ret    

00800c22 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800c22:	55                   	push   %ebp
  800c23:	89 e5                	mov    %esp,%ebp
  800c25:	53                   	push   %ebx
  800c26:	83 ec 14             	sub    $0x14,%esp
  800c29:	8b 45 10             	mov    0x10(%ebp),%eax
  800c2c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c2f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c32:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800c35:	8b 45 18             	mov    0x18(%ebp),%eax
  800c38:	ba 00 00 00 00       	mov    $0x0,%edx
  800c3d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c40:	77 55                	ja     800c97 <printnum+0x75>
  800c42:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c45:	72 05                	jb     800c4c <printnum+0x2a>
  800c47:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c4a:	77 4b                	ja     800c97 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c4c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c4f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c52:	8b 45 18             	mov    0x18(%ebp),%eax
  800c55:	ba 00 00 00 00       	mov    $0x0,%edx
  800c5a:	52                   	push   %edx
  800c5b:	50                   	push   %eax
  800c5c:	ff 75 f4             	pushl  -0xc(%ebp)
  800c5f:	ff 75 f0             	pushl  -0x10(%ebp)
  800c62:	e8 2d 16 00 00       	call   802294 <__udivdi3>
  800c67:	83 c4 10             	add    $0x10,%esp
  800c6a:	83 ec 04             	sub    $0x4,%esp
  800c6d:	ff 75 20             	pushl  0x20(%ebp)
  800c70:	53                   	push   %ebx
  800c71:	ff 75 18             	pushl  0x18(%ebp)
  800c74:	52                   	push   %edx
  800c75:	50                   	push   %eax
  800c76:	ff 75 0c             	pushl  0xc(%ebp)
  800c79:	ff 75 08             	pushl  0x8(%ebp)
  800c7c:	e8 a1 ff ff ff       	call   800c22 <printnum>
  800c81:	83 c4 20             	add    $0x20,%esp
  800c84:	eb 1a                	jmp    800ca0 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c86:	83 ec 08             	sub    $0x8,%esp
  800c89:	ff 75 0c             	pushl  0xc(%ebp)
  800c8c:	ff 75 20             	pushl  0x20(%ebp)
  800c8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c92:	ff d0                	call   *%eax
  800c94:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c97:	ff 4d 1c             	decl   0x1c(%ebp)
  800c9a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c9e:	7f e6                	jg     800c86 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800ca0:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800ca3:	bb 00 00 00 00       	mov    $0x0,%ebx
  800ca8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800cae:	53                   	push   %ebx
  800caf:	51                   	push   %ecx
  800cb0:	52                   	push   %edx
  800cb1:	50                   	push   %eax
  800cb2:	e8 ed 16 00 00       	call   8023a4 <__umoddi3>
  800cb7:	83 c4 10             	add    $0x10,%esp
  800cba:	05 d4 2a 80 00       	add    $0x802ad4,%eax
  800cbf:	8a 00                	mov    (%eax),%al
  800cc1:	0f be c0             	movsbl %al,%eax
  800cc4:	83 ec 08             	sub    $0x8,%esp
  800cc7:	ff 75 0c             	pushl  0xc(%ebp)
  800cca:	50                   	push   %eax
  800ccb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cce:	ff d0                	call   *%eax
  800cd0:	83 c4 10             	add    $0x10,%esp
}
  800cd3:	90                   	nop
  800cd4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800cd7:	c9                   	leave  
  800cd8:	c3                   	ret    

00800cd9 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800cd9:	55                   	push   %ebp
  800cda:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cdc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ce0:	7e 1c                	jle    800cfe <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce5:	8b 00                	mov    (%eax),%eax
  800ce7:	8d 50 08             	lea    0x8(%eax),%edx
  800cea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ced:	89 10                	mov    %edx,(%eax)
  800cef:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf2:	8b 00                	mov    (%eax),%eax
  800cf4:	83 e8 08             	sub    $0x8,%eax
  800cf7:	8b 50 04             	mov    0x4(%eax),%edx
  800cfa:	8b 00                	mov    (%eax),%eax
  800cfc:	eb 40                	jmp    800d3e <getuint+0x65>
	else if (lflag)
  800cfe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d02:	74 1e                	je     800d22 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800d04:	8b 45 08             	mov    0x8(%ebp),%eax
  800d07:	8b 00                	mov    (%eax),%eax
  800d09:	8d 50 04             	lea    0x4(%eax),%edx
  800d0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0f:	89 10                	mov    %edx,(%eax)
  800d11:	8b 45 08             	mov    0x8(%ebp),%eax
  800d14:	8b 00                	mov    (%eax),%eax
  800d16:	83 e8 04             	sub    $0x4,%eax
  800d19:	8b 00                	mov    (%eax),%eax
  800d1b:	ba 00 00 00 00       	mov    $0x0,%edx
  800d20:	eb 1c                	jmp    800d3e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800d22:	8b 45 08             	mov    0x8(%ebp),%eax
  800d25:	8b 00                	mov    (%eax),%eax
  800d27:	8d 50 04             	lea    0x4(%eax),%edx
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	89 10                	mov    %edx,(%eax)
  800d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d32:	8b 00                	mov    (%eax),%eax
  800d34:	83 e8 04             	sub    $0x4,%eax
  800d37:	8b 00                	mov    (%eax),%eax
  800d39:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800d3e:	5d                   	pop    %ebp
  800d3f:	c3                   	ret    

00800d40 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800d40:	55                   	push   %ebp
  800d41:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d43:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d47:	7e 1c                	jle    800d65 <getint+0x25>
		return va_arg(*ap, long long);
  800d49:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4c:	8b 00                	mov    (%eax),%eax
  800d4e:	8d 50 08             	lea    0x8(%eax),%edx
  800d51:	8b 45 08             	mov    0x8(%ebp),%eax
  800d54:	89 10                	mov    %edx,(%eax)
  800d56:	8b 45 08             	mov    0x8(%ebp),%eax
  800d59:	8b 00                	mov    (%eax),%eax
  800d5b:	83 e8 08             	sub    $0x8,%eax
  800d5e:	8b 50 04             	mov    0x4(%eax),%edx
  800d61:	8b 00                	mov    (%eax),%eax
  800d63:	eb 38                	jmp    800d9d <getint+0x5d>
	else if (lflag)
  800d65:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d69:	74 1a                	je     800d85 <getint+0x45>
		return va_arg(*ap, long);
  800d6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6e:	8b 00                	mov    (%eax),%eax
  800d70:	8d 50 04             	lea    0x4(%eax),%edx
  800d73:	8b 45 08             	mov    0x8(%ebp),%eax
  800d76:	89 10                	mov    %edx,(%eax)
  800d78:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7b:	8b 00                	mov    (%eax),%eax
  800d7d:	83 e8 04             	sub    $0x4,%eax
  800d80:	8b 00                	mov    (%eax),%eax
  800d82:	99                   	cltd   
  800d83:	eb 18                	jmp    800d9d <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	8b 00                	mov    (%eax),%eax
  800d8a:	8d 50 04             	lea    0x4(%eax),%edx
  800d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d90:	89 10                	mov    %edx,(%eax)
  800d92:	8b 45 08             	mov    0x8(%ebp),%eax
  800d95:	8b 00                	mov    (%eax),%eax
  800d97:	83 e8 04             	sub    $0x4,%eax
  800d9a:	8b 00                	mov    (%eax),%eax
  800d9c:	99                   	cltd   
}
  800d9d:	5d                   	pop    %ebp
  800d9e:	c3                   	ret    

00800d9f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d9f:	55                   	push   %ebp
  800da0:	89 e5                	mov    %esp,%ebp
  800da2:	56                   	push   %esi
  800da3:	53                   	push   %ebx
  800da4:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800da7:	eb 17                	jmp    800dc0 <vprintfmt+0x21>
			if (ch == '\0')
  800da9:	85 db                	test   %ebx,%ebx
  800dab:	0f 84 af 03 00 00    	je     801160 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800db1:	83 ec 08             	sub    $0x8,%esp
  800db4:	ff 75 0c             	pushl  0xc(%ebp)
  800db7:	53                   	push   %ebx
  800db8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbb:	ff d0                	call   *%eax
  800dbd:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800dc0:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc3:	8d 50 01             	lea    0x1(%eax),%edx
  800dc6:	89 55 10             	mov    %edx,0x10(%ebp)
  800dc9:	8a 00                	mov    (%eax),%al
  800dcb:	0f b6 d8             	movzbl %al,%ebx
  800dce:	83 fb 25             	cmp    $0x25,%ebx
  800dd1:	75 d6                	jne    800da9 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800dd3:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800dd7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800dde:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800de5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800dec:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800df3:	8b 45 10             	mov    0x10(%ebp),%eax
  800df6:	8d 50 01             	lea    0x1(%eax),%edx
  800df9:	89 55 10             	mov    %edx,0x10(%ebp)
  800dfc:	8a 00                	mov    (%eax),%al
  800dfe:	0f b6 d8             	movzbl %al,%ebx
  800e01:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800e04:	83 f8 55             	cmp    $0x55,%eax
  800e07:	0f 87 2b 03 00 00    	ja     801138 <vprintfmt+0x399>
  800e0d:	8b 04 85 f8 2a 80 00 	mov    0x802af8(,%eax,4),%eax
  800e14:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800e16:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800e1a:	eb d7                	jmp    800df3 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800e1c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800e20:	eb d1                	jmp    800df3 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e22:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800e29:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e2c:	89 d0                	mov    %edx,%eax
  800e2e:	c1 e0 02             	shl    $0x2,%eax
  800e31:	01 d0                	add    %edx,%eax
  800e33:	01 c0                	add    %eax,%eax
  800e35:	01 d8                	add    %ebx,%eax
  800e37:	83 e8 30             	sub    $0x30,%eax
  800e3a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800e3d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e40:	8a 00                	mov    (%eax),%al
  800e42:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e45:	83 fb 2f             	cmp    $0x2f,%ebx
  800e48:	7e 3e                	jle    800e88 <vprintfmt+0xe9>
  800e4a:	83 fb 39             	cmp    $0x39,%ebx
  800e4d:	7f 39                	jg     800e88 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e4f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e52:	eb d5                	jmp    800e29 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e54:	8b 45 14             	mov    0x14(%ebp),%eax
  800e57:	83 c0 04             	add    $0x4,%eax
  800e5a:	89 45 14             	mov    %eax,0x14(%ebp)
  800e5d:	8b 45 14             	mov    0x14(%ebp),%eax
  800e60:	83 e8 04             	sub    $0x4,%eax
  800e63:	8b 00                	mov    (%eax),%eax
  800e65:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e68:	eb 1f                	jmp    800e89 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e6a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e6e:	79 83                	jns    800df3 <vprintfmt+0x54>
				width = 0;
  800e70:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e77:	e9 77 ff ff ff       	jmp    800df3 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e7c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e83:	e9 6b ff ff ff       	jmp    800df3 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e88:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e89:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e8d:	0f 89 60 ff ff ff    	jns    800df3 <vprintfmt+0x54>
				width = precision, precision = -1;
  800e93:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e96:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e99:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800ea0:	e9 4e ff ff ff       	jmp    800df3 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ea5:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800ea8:	e9 46 ff ff ff       	jmp    800df3 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ead:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb0:	83 c0 04             	add    $0x4,%eax
  800eb3:	89 45 14             	mov    %eax,0x14(%ebp)
  800eb6:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb9:	83 e8 04             	sub    $0x4,%eax
  800ebc:	8b 00                	mov    (%eax),%eax
  800ebe:	83 ec 08             	sub    $0x8,%esp
  800ec1:	ff 75 0c             	pushl  0xc(%ebp)
  800ec4:	50                   	push   %eax
  800ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec8:	ff d0                	call   *%eax
  800eca:	83 c4 10             	add    $0x10,%esp
			break;
  800ecd:	e9 89 02 00 00       	jmp    80115b <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800ed2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ed5:	83 c0 04             	add    $0x4,%eax
  800ed8:	89 45 14             	mov    %eax,0x14(%ebp)
  800edb:	8b 45 14             	mov    0x14(%ebp),%eax
  800ede:	83 e8 04             	sub    $0x4,%eax
  800ee1:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ee3:	85 db                	test   %ebx,%ebx
  800ee5:	79 02                	jns    800ee9 <vprintfmt+0x14a>
				err = -err;
  800ee7:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ee9:	83 fb 64             	cmp    $0x64,%ebx
  800eec:	7f 0b                	jg     800ef9 <vprintfmt+0x15a>
  800eee:	8b 34 9d 40 29 80 00 	mov    0x802940(,%ebx,4),%esi
  800ef5:	85 f6                	test   %esi,%esi
  800ef7:	75 19                	jne    800f12 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ef9:	53                   	push   %ebx
  800efa:	68 e5 2a 80 00       	push   $0x802ae5
  800eff:	ff 75 0c             	pushl  0xc(%ebp)
  800f02:	ff 75 08             	pushl  0x8(%ebp)
  800f05:	e8 5e 02 00 00       	call   801168 <printfmt>
  800f0a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800f0d:	e9 49 02 00 00       	jmp    80115b <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800f12:	56                   	push   %esi
  800f13:	68 ee 2a 80 00       	push   $0x802aee
  800f18:	ff 75 0c             	pushl  0xc(%ebp)
  800f1b:	ff 75 08             	pushl  0x8(%ebp)
  800f1e:	e8 45 02 00 00       	call   801168 <printfmt>
  800f23:	83 c4 10             	add    $0x10,%esp
			break;
  800f26:	e9 30 02 00 00       	jmp    80115b <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800f2b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f2e:	83 c0 04             	add    $0x4,%eax
  800f31:	89 45 14             	mov    %eax,0x14(%ebp)
  800f34:	8b 45 14             	mov    0x14(%ebp),%eax
  800f37:	83 e8 04             	sub    $0x4,%eax
  800f3a:	8b 30                	mov    (%eax),%esi
  800f3c:	85 f6                	test   %esi,%esi
  800f3e:	75 05                	jne    800f45 <vprintfmt+0x1a6>
				p = "(null)";
  800f40:	be f1 2a 80 00       	mov    $0x802af1,%esi
			if (width > 0 && padc != '-')
  800f45:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f49:	7e 6d                	jle    800fb8 <vprintfmt+0x219>
  800f4b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f4f:	74 67                	je     800fb8 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f51:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f54:	83 ec 08             	sub    $0x8,%esp
  800f57:	50                   	push   %eax
  800f58:	56                   	push   %esi
  800f59:	e8 0c 03 00 00       	call   80126a <strnlen>
  800f5e:	83 c4 10             	add    $0x10,%esp
  800f61:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f64:	eb 16                	jmp    800f7c <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f66:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f6a:	83 ec 08             	sub    $0x8,%esp
  800f6d:	ff 75 0c             	pushl  0xc(%ebp)
  800f70:	50                   	push   %eax
  800f71:	8b 45 08             	mov    0x8(%ebp),%eax
  800f74:	ff d0                	call   *%eax
  800f76:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f79:	ff 4d e4             	decl   -0x1c(%ebp)
  800f7c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f80:	7f e4                	jg     800f66 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f82:	eb 34                	jmp    800fb8 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f84:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f88:	74 1c                	je     800fa6 <vprintfmt+0x207>
  800f8a:	83 fb 1f             	cmp    $0x1f,%ebx
  800f8d:	7e 05                	jle    800f94 <vprintfmt+0x1f5>
  800f8f:	83 fb 7e             	cmp    $0x7e,%ebx
  800f92:	7e 12                	jle    800fa6 <vprintfmt+0x207>
					putch('?', putdat);
  800f94:	83 ec 08             	sub    $0x8,%esp
  800f97:	ff 75 0c             	pushl  0xc(%ebp)
  800f9a:	6a 3f                	push   $0x3f
  800f9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9f:	ff d0                	call   *%eax
  800fa1:	83 c4 10             	add    $0x10,%esp
  800fa4:	eb 0f                	jmp    800fb5 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800fa6:	83 ec 08             	sub    $0x8,%esp
  800fa9:	ff 75 0c             	pushl  0xc(%ebp)
  800fac:	53                   	push   %ebx
  800fad:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb0:	ff d0                	call   *%eax
  800fb2:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800fb5:	ff 4d e4             	decl   -0x1c(%ebp)
  800fb8:	89 f0                	mov    %esi,%eax
  800fba:	8d 70 01             	lea    0x1(%eax),%esi
  800fbd:	8a 00                	mov    (%eax),%al
  800fbf:	0f be d8             	movsbl %al,%ebx
  800fc2:	85 db                	test   %ebx,%ebx
  800fc4:	74 24                	je     800fea <vprintfmt+0x24b>
  800fc6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800fca:	78 b8                	js     800f84 <vprintfmt+0x1e5>
  800fcc:	ff 4d e0             	decl   -0x20(%ebp)
  800fcf:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800fd3:	79 af                	jns    800f84 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fd5:	eb 13                	jmp    800fea <vprintfmt+0x24b>
				putch(' ', putdat);
  800fd7:	83 ec 08             	sub    $0x8,%esp
  800fda:	ff 75 0c             	pushl  0xc(%ebp)
  800fdd:	6a 20                	push   $0x20
  800fdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe2:	ff d0                	call   *%eax
  800fe4:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fe7:	ff 4d e4             	decl   -0x1c(%ebp)
  800fea:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fee:	7f e7                	jg     800fd7 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ff0:	e9 66 01 00 00       	jmp    80115b <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ff5:	83 ec 08             	sub    $0x8,%esp
  800ff8:	ff 75 e8             	pushl  -0x18(%ebp)
  800ffb:	8d 45 14             	lea    0x14(%ebp),%eax
  800ffe:	50                   	push   %eax
  800fff:	e8 3c fd ff ff       	call   800d40 <getint>
  801004:	83 c4 10             	add    $0x10,%esp
  801007:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80100a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80100d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801010:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801013:	85 d2                	test   %edx,%edx
  801015:	79 23                	jns    80103a <vprintfmt+0x29b>
				putch('-', putdat);
  801017:	83 ec 08             	sub    $0x8,%esp
  80101a:	ff 75 0c             	pushl  0xc(%ebp)
  80101d:	6a 2d                	push   $0x2d
  80101f:	8b 45 08             	mov    0x8(%ebp),%eax
  801022:	ff d0                	call   *%eax
  801024:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801027:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80102a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80102d:	f7 d8                	neg    %eax
  80102f:	83 d2 00             	adc    $0x0,%edx
  801032:	f7 da                	neg    %edx
  801034:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801037:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80103a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801041:	e9 bc 00 00 00       	jmp    801102 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801046:	83 ec 08             	sub    $0x8,%esp
  801049:	ff 75 e8             	pushl  -0x18(%ebp)
  80104c:	8d 45 14             	lea    0x14(%ebp),%eax
  80104f:	50                   	push   %eax
  801050:	e8 84 fc ff ff       	call   800cd9 <getuint>
  801055:	83 c4 10             	add    $0x10,%esp
  801058:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80105b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80105e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801065:	e9 98 00 00 00       	jmp    801102 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80106a:	83 ec 08             	sub    $0x8,%esp
  80106d:	ff 75 0c             	pushl  0xc(%ebp)
  801070:	6a 58                	push   $0x58
  801072:	8b 45 08             	mov    0x8(%ebp),%eax
  801075:	ff d0                	call   *%eax
  801077:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80107a:	83 ec 08             	sub    $0x8,%esp
  80107d:	ff 75 0c             	pushl  0xc(%ebp)
  801080:	6a 58                	push   $0x58
  801082:	8b 45 08             	mov    0x8(%ebp),%eax
  801085:	ff d0                	call   *%eax
  801087:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80108a:	83 ec 08             	sub    $0x8,%esp
  80108d:	ff 75 0c             	pushl  0xc(%ebp)
  801090:	6a 58                	push   $0x58
  801092:	8b 45 08             	mov    0x8(%ebp),%eax
  801095:	ff d0                	call   *%eax
  801097:	83 c4 10             	add    $0x10,%esp
			break;
  80109a:	e9 bc 00 00 00       	jmp    80115b <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80109f:	83 ec 08             	sub    $0x8,%esp
  8010a2:	ff 75 0c             	pushl  0xc(%ebp)
  8010a5:	6a 30                	push   $0x30
  8010a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010aa:	ff d0                	call   *%eax
  8010ac:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8010af:	83 ec 08             	sub    $0x8,%esp
  8010b2:	ff 75 0c             	pushl  0xc(%ebp)
  8010b5:	6a 78                	push   $0x78
  8010b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ba:	ff d0                	call   *%eax
  8010bc:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8010bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8010c2:	83 c0 04             	add    $0x4,%eax
  8010c5:	89 45 14             	mov    %eax,0x14(%ebp)
  8010c8:	8b 45 14             	mov    0x14(%ebp),%eax
  8010cb:	83 e8 04             	sub    $0x4,%eax
  8010ce:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8010d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010d3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8010da:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8010e1:	eb 1f                	jmp    801102 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8010e3:	83 ec 08             	sub    $0x8,%esp
  8010e6:	ff 75 e8             	pushl  -0x18(%ebp)
  8010e9:	8d 45 14             	lea    0x14(%ebp),%eax
  8010ec:	50                   	push   %eax
  8010ed:	e8 e7 fb ff ff       	call   800cd9 <getuint>
  8010f2:	83 c4 10             	add    $0x10,%esp
  8010f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010f8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010fb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801102:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801106:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801109:	83 ec 04             	sub    $0x4,%esp
  80110c:	52                   	push   %edx
  80110d:	ff 75 e4             	pushl  -0x1c(%ebp)
  801110:	50                   	push   %eax
  801111:	ff 75 f4             	pushl  -0xc(%ebp)
  801114:	ff 75 f0             	pushl  -0x10(%ebp)
  801117:	ff 75 0c             	pushl  0xc(%ebp)
  80111a:	ff 75 08             	pushl  0x8(%ebp)
  80111d:	e8 00 fb ff ff       	call   800c22 <printnum>
  801122:	83 c4 20             	add    $0x20,%esp
			break;
  801125:	eb 34                	jmp    80115b <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801127:	83 ec 08             	sub    $0x8,%esp
  80112a:	ff 75 0c             	pushl  0xc(%ebp)
  80112d:	53                   	push   %ebx
  80112e:	8b 45 08             	mov    0x8(%ebp),%eax
  801131:	ff d0                	call   *%eax
  801133:	83 c4 10             	add    $0x10,%esp
			break;
  801136:	eb 23                	jmp    80115b <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801138:	83 ec 08             	sub    $0x8,%esp
  80113b:	ff 75 0c             	pushl  0xc(%ebp)
  80113e:	6a 25                	push   $0x25
  801140:	8b 45 08             	mov    0x8(%ebp),%eax
  801143:	ff d0                	call   *%eax
  801145:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801148:	ff 4d 10             	decl   0x10(%ebp)
  80114b:	eb 03                	jmp    801150 <vprintfmt+0x3b1>
  80114d:	ff 4d 10             	decl   0x10(%ebp)
  801150:	8b 45 10             	mov    0x10(%ebp),%eax
  801153:	48                   	dec    %eax
  801154:	8a 00                	mov    (%eax),%al
  801156:	3c 25                	cmp    $0x25,%al
  801158:	75 f3                	jne    80114d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80115a:	90                   	nop
		}
	}
  80115b:	e9 47 fc ff ff       	jmp    800da7 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801160:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801161:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801164:	5b                   	pop    %ebx
  801165:	5e                   	pop    %esi
  801166:	5d                   	pop    %ebp
  801167:	c3                   	ret    

00801168 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801168:	55                   	push   %ebp
  801169:	89 e5                	mov    %esp,%ebp
  80116b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80116e:	8d 45 10             	lea    0x10(%ebp),%eax
  801171:	83 c0 04             	add    $0x4,%eax
  801174:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801177:	8b 45 10             	mov    0x10(%ebp),%eax
  80117a:	ff 75 f4             	pushl  -0xc(%ebp)
  80117d:	50                   	push   %eax
  80117e:	ff 75 0c             	pushl  0xc(%ebp)
  801181:	ff 75 08             	pushl  0x8(%ebp)
  801184:	e8 16 fc ff ff       	call   800d9f <vprintfmt>
  801189:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80118c:	90                   	nop
  80118d:	c9                   	leave  
  80118e:	c3                   	ret    

0080118f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80118f:	55                   	push   %ebp
  801190:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801192:	8b 45 0c             	mov    0xc(%ebp),%eax
  801195:	8b 40 08             	mov    0x8(%eax),%eax
  801198:	8d 50 01             	lea    0x1(%eax),%edx
  80119b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8011a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a4:	8b 10                	mov    (%eax),%edx
  8011a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a9:	8b 40 04             	mov    0x4(%eax),%eax
  8011ac:	39 c2                	cmp    %eax,%edx
  8011ae:	73 12                	jae    8011c2 <sprintputch+0x33>
		*b->buf++ = ch;
  8011b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b3:	8b 00                	mov    (%eax),%eax
  8011b5:	8d 48 01             	lea    0x1(%eax),%ecx
  8011b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011bb:	89 0a                	mov    %ecx,(%edx)
  8011bd:	8b 55 08             	mov    0x8(%ebp),%edx
  8011c0:	88 10                	mov    %dl,(%eax)
}
  8011c2:	90                   	nop
  8011c3:	5d                   	pop    %ebp
  8011c4:	c3                   	ret    

008011c5 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8011c5:	55                   	push   %ebp
  8011c6:	89 e5                	mov    %esp,%ebp
  8011c8:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8011cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ce:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8011d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011da:	01 d0                	add    %edx,%eax
  8011dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011e6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011ea:	74 06                	je     8011f2 <vsnprintf+0x2d>
  8011ec:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011f0:	7f 07                	jg     8011f9 <vsnprintf+0x34>
		return -E_INVAL;
  8011f2:	b8 03 00 00 00       	mov    $0x3,%eax
  8011f7:	eb 20                	jmp    801219 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011f9:	ff 75 14             	pushl  0x14(%ebp)
  8011fc:	ff 75 10             	pushl  0x10(%ebp)
  8011ff:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801202:	50                   	push   %eax
  801203:	68 8f 11 80 00       	push   $0x80118f
  801208:	e8 92 fb ff ff       	call   800d9f <vprintfmt>
  80120d:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801210:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801213:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801216:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801219:	c9                   	leave  
  80121a:	c3                   	ret    

0080121b <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80121b:	55                   	push   %ebp
  80121c:	89 e5                	mov    %esp,%ebp
  80121e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801221:	8d 45 10             	lea    0x10(%ebp),%eax
  801224:	83 c0 04             	add    $0x4,%eax
  801227:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80122a:	8b 45 10             	mov    0x10(%ebp),%eax
  80122d:	ff 75 f4             	pushl  -0xc(%ebp)
  801230:	50                   	push   %eax
  801231:	ff 75 0c             	pushl  0xc(%ebp)
  801234:	ff 75 08             	pushl  0x8(%ebp)
  801237:	e8 89 ff ff ff       	call   8011c5 <vsnprintf>
  80123c:	83 c4 10             	add    $0x10,%esp
  80123f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801242:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801245:	c9                   	leave  
  801246:	c3                   	ret    

00801247 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801247:	55                   	push   %ebp
  801248:	89 e5                	mov    %esp,%ebp
  80124a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80124d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801254:	eb 06                	jmp    80125c <strlen+0x15>
		n++;
  801256:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801259:	ff 45 08             	incl   0x8(%ebp)
  80125c:	8b 45 08             	mov    0x8(%ebp),%eax
  80125f:	8a 00                	mov    (%eax),%al
  801261:	84 c0                	test   %al,%al
  801263:	75 f1                	jne    801256 <strlen+0xf>
		n++;
	return n;
  801265:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801268:	c9                   	leave  
  801269:	c3                   	ret    

0080126a <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80126a:	55                   	push   %ebp
  80126b:	89 e5                	mov    %esp,%ebp
  80126d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801270:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801277:	eb 09                	jmp    801282 <strnlen+0x18>
		n++;
  801279:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80127c:	ff 45 08             	incl   0x8(%ebp)
  80127f:	ff 4d 0c             	decl   0xc(%ebp)
  801282:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801286:	74 09                	je     801291 <strnlen+0x27>
  801288:	8b 45 08             	mov    0x8(%ebp),%eax
  80128b:	8a 00                	mov    (%eax),%al
  80128d:	84 c0                	test   %al,%al
  80128f:	75 e8                	jne    801279 <strnlen+0xf>
		n++;
	return n;
  801291:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801294:	c9                   	leave  
  801295:	c3                   	ret    

00801296 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801296:	55                   	push   %ebp
  801297:	89 e5                	mov    %esp,%ebp
  801299:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80129c:	8b 45 08             	mov    0x8(%ebp),%eax
  80129f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8012a2:	90                   	nop
  8012a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a6:	8d 50 01             	lea    0x1(%eax),%edx
  8012a9:	89 55 08             	mov    %edx,0x8(%ebp)
  8012ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012af:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012b2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012b5:	8a 12                	mov    (%edx),%dl
  8012b7:	88 10                	mov    %dl,(%eax)
  8012b9:	8a 00                	mov    (%eax),%al
  8012bb:	84 c0                	test   %al,%al
  8012bd:	75 e4                	jne    8012a3 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8012bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012c2:	c9                   	leave  
  8012c3:	c3                   	ret    

008012c4 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8012c4:	55                   	push   %ebp
  8012c5:	89 e5                	mov    %esp,%ebp
  8012c7:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012d7:	eb 1f                	jmp    8012f8 <strncpy+0x34>
		*dst++ = *src;
  8012d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dc:	8d 50 01             	lea    0x1(%eax),%edx
  8012df:	89 55 08             	mov    %edx,0x8(%ebp)
  8012e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e5:	8a 12                	mov    (%edx),%dl
  8012e7:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ec:	8a 00                	mov    (%eax),%al
  8012ee:	84 c0                	test   %al,%al
  8012f0:	74 03                	je     8012f5 <strncpy+0x31>
			src++;
  8012f2:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012f5:	ff 45 fc             	incl   -0x4(%ebp)
  8012f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012fb:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012fe:	72 d9                	jb     8012d9 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801300:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801303:	c9                   	leave  
  801304:	c3                   	ret    

00801305 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801305:	55                   	push   %ebp
  801306:	89 e5                	mov    %esp,%ebp
  801308:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80130b:	8b 45 08             	mov    0x8(%ebp),%eax
  80130e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801311:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801315:	74 30                	je     801347 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801317:	eb 16                	jmp    80132f <strlcpy+0x2a>
			*dst++ = *src++;
  801319:	8b 45 08             	mov    0x8(%ebp),%eax
  80131c:	8d 50 01             	lea    0x1(%eax),%edx
  80131f:	89 55 08             	mov    %edx,0x8(%ebp)
  801322:	8b 55 0c             	mov    0xc(%ebp),%edx
  801325:	8d 4a 01             	lea    0x1(%edx),%ecx
  801328:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80132b:	8a 12                	mov    (%edx),%dl
  80132d:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80132f:	ff 4d 10             	decl   0x10(%ebp)
  801332:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801336:	74 09                	je     801341 <strlcpy+0x3c>
  801338:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133b:	8a 00                	mov    (%eax),%al
  80133d:	84 c0                	test   %al,%al
  80133f:	75 d8                	jne    801319 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
  801344:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801347:	8b 55 08             	mov    0x8(%ebp),%edx
  80134a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80134d:	29 c2                	sub    %eax,%edx
  80134f:	89 d0                	mov    %edx,%eax
}
  801351:	c9                   	leave  
  801352:	c3                   	ret    

00801353 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801353:	55                   	push   %ebp
  801354:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801356:	eb 06                	jmp    80135e <strcmp+0xb>
		p++, q++;
  801358:	ff 45 08             	incl   0x8(%ebp)
  80135b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80135e:	8b 45 08             	mov    0x8(%ebp),%eax
  801361:	8a 00                	mov    (%eax),%al
  801363:	84 c0                	test   %al,%al
  801365:	74 0e                	je     801375 <strcmp+0x22>
  801367:	8b 45 08             	mov    0x8(%ebp),%eax
  80136a:	8a 10                	mov    (%eax),%dl
  80136c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80136f:	8a 00                	mov    (%eax),%al
  801371:	38 c2                	cmp    %al,%dl
  801373:	74 e3                	je     801358 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801375:	8b 45 08             	mov    0x8(%ebp),%eax
  801378:	8a 00                	mov    (%eax),%al
  80137a:	0f b6 d0             	movzbl %al,%edx
  80137d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801380:	8a 00                	mov    (%eax),%al
  801382:	0f b6 c0             	movzbl %al,%eax
  801385:	29 c2                	sub    %eax,%edx
  801387:	89 d0                	mov    %edx,%eax
}
  801389:	5d                   	pop    %ebp
  80138a:	c3                   	ret    

0080138b <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80138b:	55                   	push   %ebp
  80138c:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80138e:	eb 09                	jmp    801399 <strncmp+0xe>
		n--, p++, q++;
  801390:	ff 4d 10             	decl   0x10(%ebp)
  801393:	ff 45 08             	incl   0x8(%ebp)
  801396:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801399:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80139d:	74 17                	je     8013b6 <strncmp+0x2b>
  80139f:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a2:	8a 00                	mov    (%eax),%al
  8013a4:	84 c0                	test   %al,%al
  8013a6:	74 0e                	je     8013b6 <strncmp+0x2b>
  8013a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ab:	8a 10                	mov    (%eax),%dl
  8013ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b0:	8a 00                	mov    (%eax),%al
  8013b2:	38 c2                	cmp    %al,%dl
  8013b4:	74 da                	je     801390 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013b6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013ba:	75 07                	jne    8013c3 <strncmp+0x38>
		return 0;
  8013bc:	b8 00 00 00 00       	mov    $0x0,%eax
  8013c1:	eb 14                	jmp    8013d7 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8013c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c6:	8a 00                	mov    (%eax),%al
  8013c8:	0f b6 d0             	movzbl %al,%edx
  8013cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ce:	8a 00                	mov    (%eax),%al
  8013d0:	0f b6 c0             	movzbl %al,%eax
  8013d3:	29 c2                	sub    %eax,%edx
  8013d5:	89 d0                	mov    %edx,%eax
}
  8013d7:	5d                   	pop    %ebp
  8013d8:	c3                   	ret    

008013d9 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013d9:	55                   	push   %ebp
  8013da:	89 e5                	mov    %esp,%ebp
  8013dc:	83 ec 04             	sub    $0x4,%esp
  8013df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013e5:	eb 12                	jmp    8013f9 <strchr+0x20>
		if (*s == c)
  8013e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ea:	8a 00                	mov    (%eax),%al
  8013ec:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013ef:	75 05                	jne    8013f6 <strchr+0x1d>
			return (char *) s;
  8013f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f4:	eb 11                	jmp    801407 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013f6:	ff 45 08             	incl   0x8(%ebp)
  8013f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fc:	8a 00                	mov    (%eax),%al
  8013fe:	84 c0                	test   %al,%al
  801400:	75 e5                	jne    8013e7 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801402:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801407:	c9                   	leave  
  801408:	c3                   	ret    

00801409 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801409:	55                   	push   %ebp
  80140a:	89 e5                	mov    %esp,%ebp
  80140c:	83 ec 04             	sub    $0x4,%esp
  80140f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801412:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801415:	eb 0d                	jmp    801424 <strfind+0x1b>
		if (*s == c)
  801417:	8b 45 08             	mov    0x8(%ebp),%eax
  80141a:	8a 00                	mov    (%eax),%al
  80141c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80141f:	74 0e                	je     80142f <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801421:	ff 45 08             	incl   0x8(%ebp)
  801424:	8b 45 08             	mov    0x8(%ebp),%eax
  801427:	8a 00                	mov    (%eax),%al
  801429:	84 c0                	test   %al,%al
  80142b:	75 ea                	jne    801417 <strfind+0xe>
  80142d:	eb 01                	jmp    801430 <strfind+0x27>
		if (*s == c)
			break;
  80142f:	90                   	nop
	return (char *) s;
  801430:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801433:	c9                   	leave  
  801434:	c3                   	ret    

00801435 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801435:	55                   	push   %ebp
  801436:	89 e5                	mov    %esp,%ebp
  801438:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80143b:	8b 45 08             	mov    0x8(%ebp),%eax
  80143e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801441:	8b 45 10             	mov    0x10(%ebp),%eax
  801444:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801447:	eb 0e                	jmp    801457 <memset+0x22>
		*p++ = c;
  801449:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80144c:	8d 50 01             	lea    0x1(%eax),%edx
  80144f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801452:	8b 55 0c             	mov    0xc(%ebp),%edx
  801455:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801457:	ff 4d f8             	decl   -0x8(%ebp)
  80145a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80145e:	79 e9                	jns    801449 <memset+0x14>
		*p++ = c;

	return v;
  801460:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801463:	c9                   	leave  
  801464:	c3                   	ret    

00801465 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801465:	55                   	push   %ebp
  801466:	89 e5                	mov    %esp,%ebp
  801468:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80146b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801471:	8b 45 08             	mov    0x8(%ebp),%eax
  801474:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801477:	eb 16                	jmp    80148f <memcpy+0x2a>
		*d++ = *s++;
  801479:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80147c:	8d 50 01             	lea    0x1(%eax),%edx
  80147f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801482:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801485:	8d 4a 01             	lea    0x1(%edx),%ecx
  801488:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80148b:	8a 12                	mov    (%edx),%dl
  80148d:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80148f:	8b 45 10             	mov    0x10(%ebp),%eax
  801492:	8d 50 ff             	lea    -0x1(%eax),%edx
  801495:	89 55 10             	mov    %edx,0x10(%ebp)
  801498:	85 c0                	test   %eax,%eax
  80149a:	75 dd                	jne    801479 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80149c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80149f:	c9                   	leave  
  8014a0:	c3                   	ret    

008014a1 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014a1:	55                   	push   %ebp
  8014a2:	89 e5                	mov    %esp,%ebp
  8014a4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014b6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014b9:	73 50                	jae    80150b <memmove+0x6a>
  8014bb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014be:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c1:	01 d0                	add    %edx,%eax
  8014c3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014c6:	76 43                	jbe    80150b <memmove+0x6a>
		s += n;
  8014c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8014cb:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d1:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014d4:	eb 10                	jmp    8014e6 <memmove+0x45>
			*--d = *--s;
  8014d6:	ff 4d f8             	decl   -0x8(%ebp)
  8014d9:	ff 4d fc             	decl   -0x4(%ebp)
  8014dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014df:	8a 10                	mov    (%eax),%dl
  8014e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014e4:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014ec:	89 55 10             	mov    %edx,0x10(%ebp)
  8014ef:	85 c0                	test   %eax,%eax
  8014f1:	75 e3                	jne    8014d6 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014f3:	eb 23                	jmp    801518 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014f8:	8d 50 01             	lea    0x1(%eax),%edx
  8014fb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014fe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801501:	8d 4a 01             	lea    0x1(%edx),%ecx
  801504:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801507:	8a 12                	mov    (%edx),%dl
  801509:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80150b:	8b 45 10             	mov    0x10(%ebp),%eax
  80150e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801511:	89 55 10             	mov    %edx,0x10(%ebp)
  801514:	85 c0                	test   %eax,%eax
  801516:	75 dd                	jne    8014f5 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801518:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80151b:	c9                   	leave  
  80151c:	c3                   	ret    

0080151d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80151d:	55                   	push   %ebp
  80151e:	89 e5                	mov    %esp,%ebp
  801520:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801523:	8b 45 08             	mov    0x8(%ebp),%eax
  801526:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801529:	8b 45 0c             	mov    0xc(%ebp),%eax
  80152c:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80152f:	eb 2a                	jmp    80155b <memcmp+0x3e>
		if (*s1 != *s2)
  801531:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801534:	8a 10                	mov    (%eax),%dl
  801536:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801539:	8a 00                	mov    (%eax),%al
  80153b:	38 c2                	cmp    %al,%dl
  80153d:	74 16                	je     801555 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80153f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801542:	8a 00                	mov    (%eax),%al
  801544:	0f b6 d0             	movzbl %al,%edx
  801547:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80154a:	8a 00                	mov    (%eax),%al
  80154c:	0f b6 c0             	movzbl %al,%eax
  80154f:	29 c2                	sub    %eax,%edx
  801551:	89 d0                	mov    %edx,%eax
  801553:	eb 18                	jmp    80156d <memcmp+0x50>
		s1++, s2++;
  801555:	ff 45 fc             	incl   -0x4(%ebp)
  801558:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80155b:	8b 45 10             	mov    0x10(%ebp),%eax
  80155e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801561:	89 55 10             	mov    %edx,0x10(%ebp)
  801564:	85 c0                	test   %eax,%eax
  801566:	75 c9                	jne    801531 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801568:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80156d:	c9                   	leave  
  80156e:	c3                   	ret    

0080156f <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80156f:	55                   	push   %ebp
  801570:	89 e5                	mov    %esp,%ebp
  801572:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801575:	8b 55 08             	mov    0x8(%ebp),%edx
  801578:	8b 45 10             	mov    0x10(%ebp),%eax
  80157b:	01 d0                	add    %edx,%eax
  80157d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801580:	eb 15                	jmp    801597 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801582:	8b 45 08             	mov    0x8(%ebp),%eax
  801585:	8a 00                	mov    (%eax),%al
  801587:	0f b6 d0             	movzbl %al,%edx
  80158a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158d:	0f b6 c0             	movzbl %al,%eax
  801590:	39 c2                	cmp    %eax,%edx
  801592:	74 0d                	je     8015a1 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801594:	ff 45 08             	incl   0x8(%ebp)
  801597:	8b 45 08             	mov    0x8(%ebp),%eax
  80159a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80159d:	72 e3                	jb     801582 <memfind+0x13>
  80159f:	eb 01                	jmp    8015a2 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015a1:	90                   	nop
	return (void *) s;
  8015a2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015a5:	c9                   	leave  
  8015a6:	c3                   	ret    

008015a7 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015a7:	55                   	push   %ebp
  8015a8:	89 e5                	mov    %esp,%ebp
  8015aa:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015b4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015bb:	eb 03                	jmp    8015c0 <strtol+0x19>
		s++;
  8015bd:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c3:	8a 00                	mov    (%eax),%al
  8015c5:	3c 20                	cmp    $0x20,%al
  8015c7:	74 f4                	je     8015bd <strtol+0x16>
  8015c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cc:	8a 00                	mov    (%eax),%al
  8015ce:	3c 09                	cmp    $0x9,%al
  8015d0:	74 eb                	je     8015bd <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d5:	8a 00                	mov    (%eax),%al
  8015d7:	3c 2b                	cmp    $0x2b,%al
  8015d9:	75 05                	jne    8015e0 <strtol+0x39>
		s++;
  8015db:	ff 45 08             	incl   0x8(%ebp)
  8015de:	eb 13                	jmp    8015f3 <strtol+0x4c>
	else if (*s == '-')
  8015e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e3:	8a 00                	mov    (%eax),%al
  8015e5:	3c 2d                	cmp    $0x2d,%al
  8015e7:	75 0a                	jne    8015f3 <strtol+0x4c>
		s++, neg = 1;
  8015e9:	ff 45 08             	incl   0x8(%ebp)
  8015ec:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015f3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015f7:	74 06                	je     8015ff <strtol+0x58>
  8015f9:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8015fd:	75 20                	jne    80161f <strtol+0x78>
  8015ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801602:	8a 00                	mov    (%eax),%al
  801604:	3c 30                	cmp    $0x30,%al
  801606:	75 17                	jne    80161f <strtol+0x78>
  801608:	8b 45 08             	mov    0x8(%ebp),%eax
  80160b:	40                   	inc    %eax
  80160c:	8a 00                	mov    (%eax),%al
  80160e:	3c 78                	cmp    $0x78,%al
  801610:	75 0d                	jne    80161f <strtol+0x78>
		s += 2, base = 16;
  801612:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801616:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80161d:	eb 28                	jmp    801647 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80161f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801623:	75 15                	jne    80163a <strtol+0x93>
  801625:	8b 45 08             	mov    0x8(%ebp),%eax
  801628:	8a 00                	mov    (%eax),%al
  80162a:	3c 30                	cmp    $0x30,%al
  80162c:	75 0c                	jne    80163a <strtol+0x93>
		s++, base = 8;
  80162e:	ff 45 08             	incl   0x8(%ebp)
  801631:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801638:	eb 0d                	jmp    801647 <strtol+0xa0>
	else if (base == 0)
  80163a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80163e:	75 07                	jne    801647 <strtol+0xa0>
		base = 10;
  801640:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801647:	8b 45 08             	mov    0x8(%ebp),%eax
  80164a:	8a 00                	mov    (%eax),%al
  80164c:	3c 2f                	cmp    $0x2f,%al
  80164e:	7e 19                	jle    801669 <strtol+0xc2>
  801650:	8b 45 08             	mov    0x8(%ebp),%eax
  801653:	8a 00                	mov    (%eax),%al
  801655:	3c 39                	cmp    $0x39,%al
  801657:	7f 10                	jg     801669 <strtol+0xc2>
			dig = *s - '0';
  801659:	8b 45 08             	mov    0x8(%ebp),%eax
  80165c:	8a 00                	mov    (%eax),%al
  80165e:	0f be c0             	movsbl %al,%eax
  801661:	83 e8 30             	sub    $0x30,%eax
  801664:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801667:	eb 42                	jmp    8016ab <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801669:	8b 45 08             	mov    0x8(%ebp),%eax
  80166c:	8a 00                	mov    (%eax),%al
  80166e:	3c 60                	cmp    $0x60,%al
  801670:	7e 19                	jle    80168b <strtol+0xe4>
  801672:	8b 45 08             	mov    0x8(%ebp),%eax
  801675:	8a 00                	mov    (%eax),%al
  801677:	3c 7a                	cmp    $0x7a,%al
  801679:	7f 10                	jg     80168b <strtol+0xe4>
			dig = *s - 'a' + 10;
  80167b:	8b 45 08             	mov    0x8(%ebp),%eax
  80167e:	8a 00                	mov    (%eax),%al
  801680:	0f be c0             	movsbl %al,%eax
  801683:	83 e8 57             	sub    $0x57,%eax
  801686:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801689:	eb 20                	jmp    8016ab <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80168b:	8b 45 08             	mov    0x8(%ebp),%eax
  80168e:	8a 00                	mov    (%eax),%al
  801690:	3c 40                	cmp    $0x40,%al
  801692:	7e 39                	jle    8016cd <strtol+0x126>
  801694:	8b 45 08             	mov    0x8(%ebp),%eax
  801697:	8a 00                	mov    (%eax),%al
  801699:	3c 5a                	cmp    $0x5a,%al
  80169b:	7f 30                	jg     8016cd <strtol+0x126>
			dig = *s - 'A' + 10;
  80169d:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a0:	8a 00                	mov    (%eax),%al
  8016a2:	0f be c0             	movsbl %al,%eax
  8016a5:	83 e8 37             	sub    $0x37,%eax
  8016a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016ae:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016b1:	7d 19                	jge    8016cc <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016b3:	ff 45 08             	incl   0x8(%ebp)
  8016b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016b9:	0f af 45 10          	imul   0x10(%ebp),%eax
  8016bd:	89 c2                	mov    %eax,%edx
  8016bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016c2:	01 d0                	add    %edx,%eax
  8016c4:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016c7:	e9 7b ff ff ff       	jmp    801647 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016cc:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016cd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016d1:	74 08                	je     8016db <strtol+0x134>
		*endptr = (char *) s;
  8016d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016d6:	8b 55 08             	mov    0x8(%ebp),%edx
  8016d9:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016db:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016df:	74 07                	je     8016e8 <strtol+0x141>
  8016e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016e4:	f7 d8                	neg    %eax
  8016e6:	eb 03                	jmp    8016eb <strtol+0x144>
  8016e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016eb:	c9                   	leave  
  8016ec:	c3                   	ret    

008016ed <ltostr>:

void
ltostr(long value, char *str)
{
  8016ed:	55                   	push   %ebp
  8016ee:	89 e5                	mov    %esp,%ebp
  8016f0:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8016fa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801701:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801705:	79 13                	jns    80171a <ltostr+0x2d>
	{
		neg = 1;
  801707:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80170e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801711:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801714:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801717:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80171a:	8b 45 08             	mov    0x8(%ebp),%eax
  80171d:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801722:	99                   	cltd   
  801723:	f7 f9                	idiv   %ecx
  801725:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801728:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80172b:	8d 50 01             	lea    0x1(%eax),%edx
  80172e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801731:	89 c2                	mov    %eax,%edx
  801733:	8b 45 0c             	mov    0xc(%ebp),%eax
  801736:	01 d0                	add    %edx,%eax
  801738:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80173b:	83 c2 30             	add    $0x30,%edx
  80173e:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801740:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801743:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801748:	f7 e9                	imul   %ecx
  80174a:	c1 fa 02             	sar    $0x2,%edx
  80174d:	89 c8                	mov    %ecx,%eax
  80174f:	c1 f8 1f             	sar    $0x1f,%eax
  801752:	29 c2                	sub    %eax,%edx
  801754:	89 d0                	mov    %edx,%eax
  801756:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801759:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80175c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801761:	f7 e9                	imul   %ecx
  801763:	c1 fa 02             	sar    $0x2,%edx
  801766:	89 c8                	mov    %ecx,%eax
  801768:	c1 f8 1f             	sar    $0x1f,%eax
  80176b:	29 c2                	sub    %eax,%edx
  80176d:	89 d0                	mov    %edx,%eax
  80176f:	c1 e0 02             	shl    $0x2,%eax
  801772:	01 d0                	add    %edx,%eax
  801774:	01 c0                	add    %eax,%eax
  801776:	29 c1                	sub    %eax,%ecx
  801778:	89 ca                	mov    %ecx,%edx
  80177a:	85 d2                	test   %edx,%edx
  80177c:	75 9c                	jne    80171a <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80177e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801785:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801788:	48                   	dec    %eax
  801789:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80178c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801790:	74 3d                	je     8017cf <ltostr+0xe2>
		start = 1 ;
  801792:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801799:	eb 34                	jmp    8017cf <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80179b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80179e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a1:	01 d0                	add    %edx,%eax
  8017a3:	8a 00                	mov    (%eax),%al
  8017a5:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017a8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ae:	01 c2                	add    %eax,%edx
  8017b0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b6:	01 c8                	add    %ecx,%eax
  8017b8:	8a 00                	mov    (%eax),%al
  8017ba:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017bc:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c2:	01 c2                	add    %eax,%edx
  8017c4:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017c7:	88 02                	mov    %al,(%edx)
		start++ ;
  8017c9:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017cc:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017d2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017d5:	7c c4                	jl     80179b <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017d7:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017dd:	01 d0                	add    %edx,%eax
  8017df:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017e2:	90                   	nop
  8017e3:	c9                   	leave  
  8017e4:	c3                   	ret    

008017e5 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017e5:	55                   	push   %ebp
  8017e6:	89 e5                	mov    %esp,%ebp
  8017e8:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017eb:	ff 75 08             	pushl  0x8(%ebp)
  8017ee:	e8 54 fa ff ff       	call   801247 <strlen>
  8017f3:	83 c4 04             	add    $0x4,%esp
  8017f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8017f9:	ff 75 0c             	pushl  0xc(%ebp)
  8017fc:	e8 46 fa ff ff       	call   801247 <strlen>
  801801:	83 c4 04             	add    $0x4,%esp
  801804:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801807:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80180e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801815:	eb 17                	jmp    80182e <strcconcat+0x49>
		final[s] = str1[s] ;
  801817:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80181a:	8b 45 10             	mov    0x10(%ebp),%eax
  80181d:	01 c2                	add    %eax,%edx
  80181f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801822:	8b 45 08             	mov    0x8(%ebp),%eax
  801825:	01 c8                	add    %ecx,%eax
  801827:	8a 00                	mov    (%eax),%al
  801829:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80182b:	ff 45 fc             	incl   -0x4(%ebp)
  80182e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801831:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801834:	7c e1                	jl     801817 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801836:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80183d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801844:	eb 1f                	jmp    801865 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801846:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801849:	8d 50 01             	lea    0x1(%eax),%edx
  80184c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80184f:	89 c2                	mov    %eax,%edx
  801851:	8b 45 10             	mov    0x10(%ebp),%eax
  801854:	01 c2                	add    %eax,%edx
  801856:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801859:	8b 45 0c             	mov    0xc(%ebp),%eax
  80185c:	01 c8                	add    %ecx,%eax
  80185e:	8a 00                	mov    (%eax),%al
  801860:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801862:	ff 45 f8             	incl   -0x8(%ebp)
  801865:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801868:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80186b:	7c d9                	jl     801846 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80186d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801870:	8b 45 10             	mov    0x10(%ebp),%eax
  801873:	01 d0                	add    %edx,%eax
  801875:	c6 00 00             	movb   $0x0,(%eax)
}
  801878:	90                   	nop
  801879:	c9                   	leave  
  80187a:	c3                   	ret    

0080187b <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80187b:	55                   	push   %ebp
  80187c:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80187e:	8b 45 14             	mov    0x14(%ebp),%eax
  801881:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801887:	8b 45 14             	mov    0x14(%ebp),%eax
  80188a:	8b 00                	mov    (%eax),%eax
  80188c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801893:	8b 45 10             	mov    0x10(%ebp),%eax
  801896:	01 d0                	add    %edx,%eax
  801898:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80189e:	eb 0c                	jmp    8018ac <strsplit+0x31>
			*string++ = 0;
  8018a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a3:	8d 50 01             	lea    0x1(%eax),%edx
  8018a6:	89 55 08             	mov    %edx,0x8(%ebp)
  8018a9:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8018af:	8a 00                	mov    (%eax),%al
  8018b1:	84 c0                	test   %al,%al
  8018b3:	74 18                	je     8018cd <strsplit+0x52>
  8018b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b8:	8a 00                	mov    (%eax),%al
  8018ba:	0f be c0             	movsbl %al,%eax
  8018bd:	50                   	push   %eax
  8018be:	ff 75 0c             	pushl  0xc(%ebp)
  8018c1:	e8 13 fb ff ff       	call   8013d9 <strchr>
  8018c6:	83 c4 08             	add    $0x8,%esp
  8018c9:	85 c0                	test   %eax,%eax
  8018cb:	75 d3                	jne    8018a0 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8018cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d0:	8a 00                	mov    (%eax),%al
  8018d2:	84 c0                	test   %al,%al
  8018d4:	74 5a                	je     801930 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8018d6:	8b 45 14             	mov    0x14(%ebp),%eax
  8018d9:	8b 00                	mov    (%eax),%eax
  8018db:	83 f8 0f             	cmp    $0xf,%eax
  8018de:	75 07                	jne    8018e7 <strsplit+0x6c>
		{
			return 0;
  8018e0:	b8 00 00 00 00       	mov    $0x0,%eax
  8018e5:	eb 66                	jmp    80194d <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8018ea:	8b 00                	mov    (%eax),%eax
  8018ec:	8d 48 01             	lea    0x1(%eax),%ecx
  8018ef:	8b 55 14             	mov    0x14(%ebp),%edx
  8018f2:	89 0a                	mov    %ecx,(%edx)
  8018f4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8018fe:	01 c2                	add    %eax,%edx
  801900:	8b 45 08             	mov    0x8(%ebp),%eax
  801903:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801905:	eb 03                	jmp    80190a <strsplit+0x8f>
			string++;
  801907:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80190a:	8b 45 08             	mov    0x8(%ebp),%eax
  80190d:	8a 00                	mov    (%eax),%al
  80190f:	84 c0                	test   %al,%al
  801911:	74 8b                	je     80189e <strsplit+0x23>
  801913:	8b 45 08             	mov    0x8(%ebp),%eax
  801916:	8a 00                	mov    (%eax),%al
  801918:	0f be c0             	movsbl %al,%eax
  80191b:	50                   	push   %eax
  80191c:	ff 75 0c             	pushl  0xc(%ebp)
  80191f:	e8 b5 fa ff ff       	call   8013d9 <strchr>
  801924:	83 c4 08             	add    $0x8,%esp
  801927:	85 c0                	test   %eax,%eax
  801929:	74 dc                	je     801907 <strsplit+0x8c>
			string++;
	}
  80192b:	e9 6e ff ff ff       	jmp    80189e <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801930:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801931:	8b 45 14             	mov    0x14(%ebp),%eax
  801934:	8b 00                	mov    (%eax),%eax
  801936:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80193d:	8b 45 10             	mov    0x10(%ebp),%eax
  801940:	01 d0                	add    %edx,%eax
  801942:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801948:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80194d:	c9                   	leave  
  80194e:	c3                   	ret    

0080194f <malloc>:
int sizeofarray=0;
uint32 addresses[1000];
int changed[1000];
int numOfPages[1000];
void* malloc(uint32 size)
{
  80194f:	55                   	push   %ebp
  801950:	89 e5                	mov    %esp,%ebp
  801952:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801955:	8b 45 08             	mov    0x8(%ebp),%eax
  801958:	c1 e8 0c             	shr    $0xc,%eax
  80195b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  80195e:	8b 45 08             	mov    0x8(%ebp),%eax
  801961:	25 ff 0f 00 00       	and    $0xfff,%eax
  801966:	85 c0                	test   %eax,%eax
  801968:	74 03                	je     80196d <malloc+0x1e>
			num++;
  80196a:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  80196d:	a1 04 30 80 00       	mov    0x803004,%eax
  801972:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801977:	75 73                	jne    8019ec <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  801979:	83 ec 08             	sub    $0x8,%esp
  80197c:	ff 75 08             	pushl  0x8(%ebp)
  80197f:	68 00 00 00 80       	push   $0x80000000
  801984:	e8 80 04 00 00       	call   801e09 <sys_allocateMem>
  801989:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  80198c:	a1 04 30 80 00       	mov    0x803004,%eax
  801991:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  801994:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801997:	c1 e0 0c             	shl    $0xc,%eax
  80199a:	89 c2                	mov    %eax,%edx
  80199c:	a1 04 30 80 00       	mov    0x803004,%eax
  8019a1:	01 d0                	add    %edx,%eax
  8019a3:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  8019a8:	a1 30 30 80 00       	mov    0x803030,%eax
  8019ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8019b0:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
			addresses[sizeofarray]=last_addres;
  8019b7:	a1 30 30 80 00       	mov    0x803030,%eax
  8019bc:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8019c2:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  8019c9:	a1 30 30 80 00       	mov    0x803030,%eax
  8019ce:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  8019d5:	01 00 00 00 
			sizeofarray++;
  8019d9:	a1 30 30 80 00       	mov    0x803030,%eax
  8019de:	40                   	inc    %eax
  8019df:	a3 30 30 80 00       	mov    %eax,0x803030
			return (void*)return_addres;
  8019e4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8019e7:	e9 71 01 00 00       	jmp    801b5d <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  8019ec:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019f1:	85 c0                	test   %eax,%eax
  8019f3:	75 71                	jne    801a66 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  8019f5:	a1 04 30 80 00       	mov    0x803004,%eax
  8019fa:	83 ec 08             	sub    $0x8,%esp
  8019fd:	ff 75 08             	pushl  0x8(%ebp)
  801a00:	50                   	push   %eax
  801a01:	e8 03 04 00 00       	call   801e09 <sys_allocateMem>
  801a06:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801a09:	a1 04 30 80 00       	mov    0x803004,%eax
  801a0e:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801a11:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a14:	c1 e0 0c             	shl    $0xc,%eax
  801a17:	89 c2                	mov    %eax,%edx
  801a19:	a1 04 30 80 00       	mov    0x803004,%eax
  801a1e:	01 d0                	add    %edx,%eax
  801a20:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  801a25:	a1 30 30 80 00       	mov    0x803030,%eax
  801a2a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a2d:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=return_addres;
  801a34:	a1 30 30 80 00       	mov    0x803030,%eax
  801a39:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801a3c:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801a43:	a1 30 30 80 00       	mov    0x803030,%eax
  801a48:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801a4f:	01 00 00 00 
				sizeofarray++;
  801a53:	a1 30 30 80 00       	mov    0x803030,%eax
  801a58:	40                   	inc    %eax
  801a59:	a3 30 30 80 00       	mov    %eax,0x803030
				return (void*)return_addres;
  801a5e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801a61:	e9 f7 00 00 00       	jmp    801b5d <malloc+0x20e>
			}
			else{
				int count=0;
  801a66:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801a6d:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  801a74:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801a7b:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801a82:	eb 7c                	jmp    801b00 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  801a84:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801a8b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801a92:	eb 1a                	jmp    801aae <malloc+0x15f>
					{
						if(addresses[j]==i)
  801a94:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801a97:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801a9e:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801aa1:	75 08                	jne    801aab <malloc+0x15c>
						{
							index=j;
  801aa3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801aa6:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801aa9:	eb 0d                	jmp    801ab8 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801aab:	ff 45 dc             	incl   -0x24(%ebp)
  801aae:	a1 30 30 80 00       	mov    0x803030,%eax
  801ab3:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801ab6:	7c dc                	jl     801a94 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  801ab8:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801abc:	75 05                	jne    801ac3 <malloc+0x174>
					{
						count++;
  801abe:	ff 45 f0             	incl   -0x10(%ebp)
  801ac1:	eb 36                	jmp    801af9 <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  801ac3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801ac6:	8b 04 85 c0 40 80 00 	mov    0x8040c0(,%eax,4),%eax
  801acd:	85 c0                	test   %eax,%eax
  801acf:	75 05                	jne    801ad6 <malloc+0x187>
						{
							count++;
  801ad1:	ff 45 f0             	incl   -0x10(%ebp)
  801ad4:	eb 23                	jmp    801af9 <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  801ad6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ad9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801adc:	7d 14                	jge    801af2 <malloc+0x1a3>
  801ade:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ae1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801ae4:	7c 0c                	jl     801af2 <malloc+0x1a3>
							{
								min=count;
  801ae6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ae9:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801aec:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801aef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  801af2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801af9:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801b00:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801b07:	0f 86 77 ff ff ff    	jbe    801a84 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  801b0d:	83 ec 08             	sub    $0x8,%esp
  801b10:	ff 75 08             	pushl  0x8(%ebp)
  801b13:	ff 75 e4             	pushl  -0x1c(%ebp)
  801b16:	e8 ee 02 00 00       	call   801e09 <sys_allocateMem>
  801b1b:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  801b1e:	a1 30 30 80 00       	mov    0x803030,%eax
  801b23:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b26:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801b2d:	a1 30 30 80 00       	mov    0x803030,%eax
  801b32:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801b38:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801b3f:	a1 30 30 80 00       	mov    0x803030,%eax
  801b44:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801b4b:	01 00 00 00 
				sizeofarray++;
  801b4f:	a1 30 30 80 00       	mov    0x803030,%eax
  801b54:	40                   	inc    %eax
  801b55:	a3 30 30 80 00       	mov    %eax,0x803030
				return(void*) min_addresss;
  801b5a:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801b5d:	c9                   	leave  
  801b5e:	c3                   	ret    

00801b5f <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801b5f:	55                   	push   %ebp
  801b60:	89 e5                	mov    %esp,%ebp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details
}
  801b62:	90                   	nop
  801b63:	5d                   	pop    %ebp
  801b64:	c3                   	ret    

00801b65 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801b65:	55                   	push   %ebp
  801b66:	89 e5                	mov    %esp,%ebp
  801b68:	83 ec 18             	sub    $0x18,%esp
  801b6b:	8b 45 10             	mov    0x10(%ebp),%eax
  801b6e:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801b71:	83 ec 04             	sub    $0x4,%esp
  801b74:	68 50 2c 80 00       	push   $0x802c50
  801b79:	68 8d 00 00 00       	push   $0x8d
  801b7e:	68 73 2c 80 00       	push   $0x802c73
  801b83:	e8 9b ed ff ff       	call   800923 <_panic>

00801b88 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801b88:	55                   	push   %ebp
  801b89:	89 e5                	mov    %esp,%ebp
  801b8b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b8e:	83 ec 04             	sub    $0x4,%esp
  801b91:	68 50 2c 80 00       	push   $0x802c50
  801b96:	68 93 00 00 00       	push   $0x93
  801b9b:	68 73 2c 80 00       	push   $0x802c73
  801ba0:	e8 7e ed ff ff       	call   800923 <_panic>

00801ba5 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801ba5:	55                   	push   %ebp
  801ba6:	89 e5                	mov    %esp,%ebp
  801ba8:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bab:	83 ec 04             	sub    $0x4,%esp
  801bae:	68 50 2c 80 00       	push   $0x802c50
  801bb3:	68 99 00 00 00       	push   $0x99
  801bb8:	68 73 2c 80 00       	push   $0x802c73
  801bbd:	e8 61 ed ff ff       	call   800923 <_panic>

00801bc2 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801bc2:	55                   	push   %ebp
  801bc3:	89 e5                	mov    %esp,%ebp
  801bc5:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bc8:	83 ec 04             	sub    $0x4,%esp
  801bcb:	68 50 2c 80 00       	push   $0x802c50
  801bd0:	68 9e 00 00 00       	push   $0x9e
  801bd5:	68 73 2c 80 00       	push   $0x802c73
  801bda:	e8 44 ed ff ff       	call   800923 <_panic>

00801bdf <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801bdf:	55                   	push   %ebp
  801be0:	89 e5                	mov    %esp,%ebp
  801be2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801be5:	83 ec 04             	sub    $0x4,%esp
  801be8:	68 50 2c 80 00       	push   $0x802c50
  801bed:	68 a4 00 00 00       	push   $0xa4
  801bf2:	68 73 2c 80 00       	push   $0x802c73
  801bf7:	e8 27 ed ff ff       	call   800923 <_panic>

00801bfc <shrink>:
}
void shrink(uint32 newSize)
{
  801bfc:	55                   	push   %ebp
  801bfd:	89 e5                	mov    %esp,%ebp
  801bff:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c02:	83 ec 04             	sub    $0x4,%esp
  801c05:	68 50 2c 80 00       	push   $0x802c50
  801c0a:	68 a8 00 00 00       	push   $0xa8
  801c0f:	68 73 2c 80 00       	push   $0x802c73
  801c14:	e8 0a ed ff ff       	call   800923 <_panic>

00801c19 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801c19:	55                   	push   %ebp
  801c1a:	89 e5                	mov    %esp,%ebp
  801c1c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c1f:	83 ec 04             	sub    $0x4,%esp
  801c22:	68 50 2c 80 00       	push   $0x802c50
  801c27:	68 ad 00 00 00       	push   $0xad
  801c2c:	68 73 2c 80 00       	push   $0x802c73
  801c31:	e8 ed ec ff ff       	call   800923 <_panic>

00801c36 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c36:	55                   	push   %ebp
  801c37:	89 e5                	mov    %esp,%ebp
  801c39:	57                   	push   %edi
  801c3a:	56                   	push   %esi
  801c3b:	53                   	push   %ebx
  801c3c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c42:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c45:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c48:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c4b:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c4e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c51:	cd 30                	int    $0x30
  801c53:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801c56:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c59:	83 c4 10             	add    $0x10,%esp
  801c5c:	5b                   	pop    %ebx
  801c5d:	5e                   	pop    %esi
  801c5e:	5f                   	pop    %edi
  801c5f:	5d                   	pop    %ebp
  801c60:	c3                   	ret    

00801c61 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801c61:	55                   	push   %ebp
  801c62:	89 e5                	mov    %esp,%ebp
  801c64:	83 ec 04             	sub    $0x4,%esp
  801c67:	8b 45 10             	mov    0x10(%ebp),%eax
  801c6a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801c6d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c71:	8b 45 08             	mov    0x8(%ebp),%eax
  801c74:	6a 00                	push   $0x0
  801c76:	6a 00                	push   $0x0
  801c78:	52                   	push   %edx
  801c79:	ff 75 0c             	pushl  0xc(%ebp)
  801c7c:	50                   	push   %eax
  801c7d:	6a 00                	push   $0x0
  801c7f:	e8 b2 ff ff ff       	call   801c36 <syscall>
  801c84:	83 c4 18             	add    $0x18,%esp
}
  801c87:	90                   	nop
  801c88:	c9                   	leave  
  801c89:	c3                   	ret    

00801c8a <sys_cgetc>:

int
sys_cgetc(void)
{
  801c8a:	55                   	push   %ebp
  801c8b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 00                	push   $0x0
  801c93:	6a 00                	push   $0x0
  801c95:	6a 00                	push   $0x0
  801c97:	6a 01                	push   $0x1
  801c99:	e8 98 ff ff ff       	call   801c36 <syscall>
  801c9e:	83 c4 18             	add    $0x18,%esp
}
  801ca1:	c9                   	leave  
  801ca2:	c3                   	ret    

00801ca3 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801ca3:	55                   	push   %ebp
  801ca4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca9:	6a 00                	push   $0x0
  801cab:	6a 00                	push   $0x0
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	50                   	push   %eax
  801cb2:	6a 05                	push   $0x5
  801cb4:	e8 7d ff ff ff       	call   801c36 <syscall>
  801cb9:	83 c4 18             	add    $0x18,%esp
}
  801cbc:	c9                   	leave  
  801cbd:	c3                   	ret    

00801cbe <sys_getenvid>:

int32 sys_getenvid(void)
{
  801cbe:	55                   	push   %ebp
  801cbf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801cc1:	6a 00                	push   $0x0
  801cc3:	6a 00                	push   $0x0
  801cc5:	6a 00                	push   $0x0
  801cc7:	6a 00                	push   $0x0
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 02                	push   $0x2
  801ccd:	e8 64 ff ff ff       	call   801c36 <syscall>
  801cd2:	83 c4 18             	add    $0x18,%esp
}
  801cd5:	c9                   	leave  
  801cd6:	c3                   	ret    

00801cd7 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801cd7:	55                   	push   %ebp
  801cd8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801cda:	6a 00                	push   $0x0
  801cdc:	6a 00                	push   $0x0
  801cde:	6a 00                	push   $0x0
  801ce0:	6a 00                	push   $0x0
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 03                	push   $0x3
  801ce6:	e8 4b ff ff ff       	call   801c36 <syscall>
  801ceb:	83 c4 18             	add    $0x18,%esp
}
  801cee:	c9                   	leave  
  801cef:	c3                   	ret    

00801cf0 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801cf0:	55                   	push   %ebp
  801cf1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801cf3:	6a 00                	push   $0x0
  801cf5:	6a 00                	push   $0x0
  801cf7:	6a 00                	push   $0x0
  801cf9:	6a 00                	push   $0x0
  801cfb:	6a 00                	push   $0x0
  801cfd:	6a 04                	push   $0x4
  801cff:	e8 32 ff ff ff       	call   801c36 <syscall>
  801d04:	83 c4 18             	add    $0x18,%esp
}
  801d07:	c9                   	leave  
  801d08:	c3                   	ret    

00801d09 <sys_env_exit>:


void sys_env_exit(void)
{
  801d09:	55                   	push   %ebp
  801d0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801d0c:	6a 00                	push   $0x0
  801d0e:	6a 00                	push   $0x0
  801d10:	6a 00                	push   $0x0
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	6a 06                	push   $0x6
  801d18:	e8 19 ff ff ff       	call   801c36 <syscall>
  801d1d:	83 c4 18             	add    $0x18,%esp
}
  801d20:	90                   	nop
  801d21:	c9                   	leave  
  801d22:	c3                   	ret    

00801d23 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801d23:	55                   	push   %ebp
  801d24:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d26:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d29:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 00                	push   $0x0
  801d32:	52                   	push   %edx
  801d33:	50                   	push   %eax
  801d34:	6a 07                	push   $0x7
  801d36:	e8 fb fe ff ff       	call   801c36 <syscall>
  801d3b:	83 c4 18             	add    $0x18,%esp
}
  801d3e:	c9                   	leave  
  801d3f:	c3                   	ret    

00801d40 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d40:	55                   	push   %ebp
  801d41:	89 e5                	mov    %esp,%ebp
  801d43:	56                   	push   %esi
  801d44:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d45:	8b 75 18             	mov    0x18(%ebp),%esi
  801d48:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d4b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d4e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d51:	8b 45 08             	mov    0x8(%ebp),%eax
  801d54:	56                   	push   %esi
  801d55:	53                   	push   %ebx
  801d56:	51                   	push   %ecx
  801d57:	52                   	push   %edx
  801d58:	50                   	push   %eax
  801d59:	6a 08                	push   $0x8
  801d5b:	e8 d6 fe ff ff       	call   801c36 <syscall>
  801d60:	83 c4 18             	add    $0x18,%esp
}
  801d63:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d66:	5b                   	pop    %ebx
  801d67:	5e                   	pop    %esi
  801d68:	5d                   	pop    %ebp
  801d69:	c3                   	ret    

00801d6a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801d6a:	55                   	push   %ebp
  801d6b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801d6d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d70:	8b 45 08             	mov    0x8(%ebp),%eax
  801d73:	6a 00                	push   $0x0
  801d75:	6a 00                	push   $0x0
  801d77:	6a 00                	push   $0x0
  801d79:	52                   	push   %edx
  801d7a:	50                   	push   %eax
  801d7b:	6a 09                	push   $0x9
  801d7d:	e8 b4 fe ff ff       	call   801c36 <syscall>
  801d82:	83 c4 18             	add    $0x18,%esp
}
  801d85:	c9                   	leave  
  801d86:	c3                   	ret    

00801d87 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d87:	55                   	push   %ebp
  801d88:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d8a:	6a 00                	push   $0x0
  801d8c:	6a 00                	push   $0x0
  801d8e:	6a 00                	push   $0x0
  801d90:	ff 75 0c             	pushl  0xc(%ebp)
  801d93:	ff 75 08             	pushl  0x8(%ebp)
  801d96:	6a 0a                	push   $0xa
  801d98:	e8 99 fe ff ff       	call   801c36 <syscall>
  801d9d:	83 c4 18             	add    $0x18,%esp
}
  801da0:	c9                   	leave  
  801da1:	c3                   	ret    

00801da2 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801da2:	55                   	push   %ebp
  801da3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801da5:	6a 00                	push   $0x0
  801da7:	6a 00                	push   $0x0
  801da9:	6a 00                	push   $0x0
  801dab:	6a 00                	push   $0x0
  801dad:	6a 00                	push   $0x0
  801daf:	6a 0b                	push   $0xb
  801db1:	e8 80 fe ff ff       	call   801c36 <syscall>
  801db6:	83 c4 18             	add    $0x18,%esp
}
  801db9:	c9                   	leave  
  801dba:	c3                   	ret    

00801dbb <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801dbb:	55                   	push   %ebp
  801dbc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 00                	push   $0x0
  801dc4:	6a 00                	push   $0x0
  801dc6:	6a 00                	push   $0x0
  801dc8:	6a 0c                	push   $0xc
  801dca:	e8 67 fe ff ff       	call   801c36 <syscall>
  801dcf:	83 c4 18             	add    $0x18,%esp
}
  801dd2:	c9                   	leave  
  801dd3:	c3                   	ret    

00801dd4 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801dd4:	55                   	push   %ebp
  801dd5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801dd7:	6a 00                	push   $0x0
  801dd9:	6a 00                	push   $0x0
  801ddb:	6a 00                	push   $0x0
  801ddd:	6a 00                	push   $0x0
  801ddf:	6a 00                	push   $0x0
  801de1:	6a 0d                	push   $0xd
  801de3:	e8 4e fe ff ff       	call   801c36 <syscall>
  801de8:	83 c4 18             	add    $0x18,%esp
}
  801deb:	c9                   	leave  
  801dec:	c3                   	ret    

00801ded <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801ded:	55                   	push   %ebp
  801dee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801df0:	6a 00                	push   $0x0
  801df2:	6a 00                	push   $0x0
  801df4:	6a 00                	push   $0x0
  801df6:	ff 75 0c             	pushl  0xc(%ebp)
  801df9:	ff 75 08             	pushl  0x8(%ebp)
  801dfc:	6a 11                	push   $0x11
  801dfe:	e8 33 fe ff ff       	call   801c36 <syscall>
  801e03:	83 c4 18             	add    $0x18,%esp
	return;
  801e06:	90                   	nop
}
  801e07:	c9                   	leave  
  801e08:	c3                   	ret    

00801e09 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801e09:	55                   	push   %ebp
  801e0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801e0c:	6a 00                	push   $0x0
  801e0e:	6a 00                	push   $0x0
  801e10:	6a 00                	push   $0x0
  801e12:	ff 75 0c             	pushl  0xc(%ebp)
  801e15:	ff 75 08             	pushl  0x8(%ebp)
  801e18:	6a 12                	push   $0x12
  801e1a:	e8 17 fe ff ff       	call   801c36 <syscall>
  801e1f:	83 c4 18             	add    $0x18,%esp
	return ;
  801e22:	90                   	nop
}
  801e23:	c9                   	leave  
  801e24:	c3                   	ret    

00801e25 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e25:	55                   	push   %ebp
  801e26:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e28:	6a 00                	push   $0x0
  801e2a:	6a 00                	push   $0x0
  801e2c:	6a 00                	push   $0x0
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	6a 0e                	push   $0xe
  801e34:	e8 fd fd ff ff       	call   801c36 <syscall>
  801e39:	83 c4 18             	add    $0x18,%esp
}
  801e3c:	c9                   	leave  
  801e3d:	c3                   	ret    

00801e3e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e3e:	55                   	push   %ebp
  801e3f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e41:	6a 00                	push   $0x0
  801e43:	6a 00                	push   $0x0
  801e45:	6a 00                	push   $0x0
  801e47:	6a 00                	push   $0x0
  801e49:	ff 75 08             	pushl  0x8(%ebp)
  801e4c:	6a 0f                	push   $0xf
  801e4e:	e8 e3 fd ff ff       	call   801c36 <syscall>
  801e53:	83 c4 18             	add    $0x18,%esp
}
  801e56:	c9                   	leave  
  801e57:	c3                   	ret    

00801e58 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e58:	55                   	push   %ebp
  801e59:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 00                	push   $0x0
  801e5f:	6a 00                	push   $0x0
  801e61:	6a 00                	push   $0x0
  801e63:	6a 00                	push   $0x0
  801e65:	6a 10                	push   $0x10
  801e67:	e8 ca fd ff ff       	call   801c36 <syscall>
  801e6c:	83 c4 18             	add    $0x18,%esp
}
  801e6f:	90                   	nop
  801e70:	c9                   	leave  
  801e71:	c3                   	ret    

00801e72 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801e72:	55                   	push   %ebp
  801e73:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801e75:	6a 00                	push   $0x0
  801e77:	6a 00                	push   $0x0
  801e79:	6a 00                	push   $0x0
  801e7b:	6a 00                	push   $0x0
  801e7d:	6a 00                	push   $0x0
  801e7f:	6a 14                	push   $0x14
  801e81:	e8 b0 fd ff ff       	call   801c36 <syscall>
  801e86:	83 c4 18             	add    $0x18,%esp
}
  801e89:	90                   	nop
  801e8a:	c9                   	leave  
  801e8b:	c3                   	ret    

00801e8c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e8c:	55                   	push   %ebp
  801e8d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e8f:	6a 00                	push   $0x0
  801e91:	6a 00                	push   $0x0
  801e93:	6a 00                	push   $0x0
  801e95:	6a 00                	push   $0x0
  801e97:	6a 00                	push   $0x0
  801e99:	6a 15                	push   $0x15
  801e9b:	e8 96 fd ff ff       	call   801c36 <syscall>
  801ea0:	83 c4 18             	add    $0x18,%esp
}
  801ea3:	90                   	nop
  801ea4:	c9                   	leave  
  801ea5:	c3                   	ret    

00801ea6 <sys_cputc>:


void
sys_cputc(const char c)
{
  801ea6:	55                   	push   %ebp
  801ea7:	89 e5                	mov    %esp,%ebp
  801ea9:	83 ec 04             	sub    $0x4,%esp
  801eac:	8b 45 08             	mov    0x8(%ebp),%eax
  801eaf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801eb2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801eb6:	6a 00                	push   $0x0
  801eb8:	6a 00                	push   $0x0
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 00                	push   $0x0
  801ebe:	50                   	push   %eax
  801ebf:	6a 16                	push   $0x16
  801ec1:	e8 70 fd ff ff       	call   801c36 <syscall>
  801ec6:	83 c4 18             	add    $0x18,%esp
}
  801ec9:	90                   	nop
  801eca:	c9                   	leave  
  801ecb:	c3                   	ret    

00801ecc <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801ecc:	55                   	push   %ebp
  801ecd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ecf:	6a 00                	push   $0x0
  801ed1:	6a 00                	push   $0x0
  801ed3:	6a 00                	push   $0x0
  801ed5:	6a 00                	push   $0x0
  801ed7:	6a 00                	push   $0x0
  801ed9:	6a 17                	push   $0x17
  801edb:	e8 56 fd ff ff       	call   801c36 <syscall>
  801ee0:	83 c4 18             	add    $0x18,%esp
}
  801ee3:	90                   	nop
  801ee4:	c9                   	leave  
  801ee5:	c3                   	ret    

00801ee6 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801ee6:	55                   	push   %ebp
  801ee7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ee9:	8b 45 08             	mov    0x8(%ebp),%eax
  801eec:	6a 00                	push   $0x0
  801eee:	6a 00                	push   $0x0
  801ef0:	6a 00                	push   $0x0
  801ef2:	ff 75 0c             	pushl  0xc(%ebp)
  801ef5:	50                   	push   %eax
  801ef6:	6a 18                	push   $0x18
  801ef8:	e8 39 fd ff ff       	call   801c36 <syscall>
  801efd:	83 c4 18             	add    $0x18,%esp
}
  801f00:	c9                   	leave  
  801f01:	c3                   	ret    

00801f02 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801f02:	55                   	push   %ebp
  801f03:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f05:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f08:	8b 45 08             	mov    0x8(%ebp),%eax
  801f0b:	6a 00                	push   $0x0
  801f0d:	6a 00                	push   $0x0
  801f0f:	6a 00                	push   $0x0
  801f11:	52                   	push   %edx
  801f12:	50                   	push   %eax
  801f13:	6a 1b                	push   $0x1b
  801f15:	e8 1c fd ff ff       	call   801c36 <syscall>
  801f1a:	83 c4 18             	add    $0x18,%esp
}
  801f1d:	c9                   	leave  
  801f1e:	c3                   	ret    

00801f1f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f1f:	55                   	push   %ebp
  801f20:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f22:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f25:	8b 45 08             	mov    0x8(%ebp),%eax
  801f28:	6a 00                	push   $0x0
  801f2a:	6a 00                	push   $0x0
  801f2c:	6a 00                	push   $0x0
  801f2e:	52                   	push   %edx
  801f2f:	50                   	push   %eax
  801f30:	6a 19                	push   $0x19
  801f32:	e8 ff fc ff ff       	call   801c36 <syscall>
  801f37:	83 c4 18             	add    $0x18,%esp
}
  801f3a:	90                   	nop
  801f3b:	c9                   	leave  
  801f3c:	c3                   	ret    

00801f3d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f3d:	55                   	push   %ebp
  801f3e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f40:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f43:	8b 45 08             	mov    0x8(%ebp),%eax
  801f46:	6a 00                	push   $0x0
  801f48:	6a 00                	push   $0x0
  801f4a:	6a 00                	push   $0x0
  801f4c:	52                   	push   %edx
  801f4d:	50                   	push   %eax
  801f4e:	6a 1a                	push   $0x1a
  801f50:	e8 e1 fc ff ff       	call   801c36 <syscall>
  801f55:	83 c4 18             	add    $0x18,%esp
}
  801f58:	90                   	nop
  801f59:	c9                   	leave  
  801f5a:	c3                   	ret    

00801f5b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801f5b:	55                   	push   %ebp
  801f5c:	89 e5                	mov    %esp,%ebp
  801f5e:	83 ec 04             	sub    $0x4,%esp
  801f61:	8b 45 10             	mov    0x10(%ebp),%eax
  801f64:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801f67:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f6a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f71:	6a 00                	push   $0x0
  801f73:	51                   	push   %ecx
  801f74:	52                   	push   %edx
  801f75:	ff 75 0c             	pushl  0xc(%ebp)
  801f78:	50                   	push   %eax
  801f79:	6a 1c                	push   $0x1c
  801f7b:	e8 b6 fc ff ff       	call   801c36 <syscall>
  801f80:	83 c4 18             	add    $0x18,%esp
}
  801f83:	c9                   	leave  
  801f84:	c3                   	ret    

00801f85 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801f85:	55                   	push   %ebp
  801f86:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801f88:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8e:	6a 00                	push   $0x0
  801f90:	6a 00                	push   $0x0
  801f92:	6a 00                	push   $0x0
  801f94:	52                   	push   %edx
  801f95:	50                   	push   %eax
  801f96:	6a 1d                	push   $0x1d
  801f98:	e8 99 fc ff ff       	call   801c36 <syscall>
  801f9d:	83 c4 18             	add    $0x18,%esp
}
  801fa0:	c9                   	leave  
  801fa1:	c3                   	ret    

00801fa2 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801fa2:	55                   	push   %ebp
  801fa3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801fa5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801fa8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fab:	8b 45 08             	mov    0x8(%ebp),%eax
  801fae:	6a 00                	push   $0x0
  801fb0:	6a 00                	push   $0x0
  801fb2:	51                   	push   %ecx
  801fb3:	52                   	push   %edx
  801fb4:	50                   	push   %eax
  801fb5:	6a 1e                	push   $0x1e
  801fb7:	e8 7a fc ff ff       	call   801c36 <syscall>
  801fbc:	83 c4 18             	add    $0x18,%esp
}
  801fbf:	c9                   	leave  
  801fc0:	c3                   	ret    

00801fc1 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801fc1:	55                   	push   %ebp
  801fc2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801fc4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  801fca:	6a 00                	push   $0x0
  801fcc:	6a 00                	push   $0x0
  801fce:	6a 00                	push   $0x0
  801fd0:	52                   	push   %edx
  801fd1:	50                   	push   %eax
  801fd2:	6a 1f                	push   $0x1f
  801fd4:	e8 5d fc ff ff       	call   801c36 <syscall>
  801fd9:	83 c4 18             	add    $0x18,%esp
}
  801fdc:	c9                   	leave  
  801fdd:	c3                   	ret    

00801fde <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801fde:	55                   	push   %ebp
  801fdf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801fe1:	6a 00                	push   $0x0
  801fe3:	6a 00                	push   $0x0
  801fe5:	6a 00                	push   $0x0
  801fe7:	6a 00                	push   $0x0
  801fe9:	6a 00                	push   $0x0
  801feb:	6a 20                	push   $0x20
  801fed:	e8 44 fc ff ff       	call   801c36 <syscall>
  801ff2:	83 c4 18             	add    $0x18,%esp
}
  801ff5:	c9                   	leave  
  801ff6:	c3                   	ret    

00801ff7 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801ff7:	55                   	push   %ebp
  801ff8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801ffa:	8b 45 08             	mov    0x8(%ebp),%eax
  801ffd:	6a 00                	push   $0x0
  801fff:	ff 75 14             	pushl  0x14(%ebp)
  802002:	ff 75 10             	pushl  0x10(%ebp)
  802005:	ff 75 0c             	pushl  0xc(%ebp)
  802008:	50                   	push   %eax
  802009:	6a 21                	push   $0x21
  80200b:	e8 26 fc ff ff       	call   801c36 <syscall>
  802010:	83 c4 18             	add    $0x18,%esp
}
  802013:	c9                   	leave  
  802014:	c3                   	ret    

00802015 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802015:	55                   	push   %ebp
  802016:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802018:	8b 45 08             	mov    0x8(%ebp),%eax
  80201b:	6a 00                	push   $0x0
  80201d:	6a 00                	push   $0x0
  80201f:	6a 00                	push   $0x0
  802021:	6a 00                	push   $0x0
  802023:	50                   	push   %eax
  802024:	6a 22                	push   $0x22
  802026:	e8 0b fc ff ff       	call   801c36 <syscall>
  80202b:	83 c4 18             	add    $0x18,%esp
}
  80202e:	90                   	nop
  80202f:	c9                   	leave  
  802030:	c3                   	ret    

00802031 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802031:	55                   	push   %ebp
  802032:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802034:	8b 45 08             	mov    0x8(%ebp),%eax
  802037:	6a 00                	push   $0x0
  802039:	6a 00                	push   $0x0
  80203b:	6a 00                	push   $0x0
  80203d:	6a 00                	push   $0x0
  80203f:	50                   	push   %eax
  802040:	6a 23                	push   $0x23
  802042:	e8 ef fb ff ff       	call   801c36 <syscall>
  802047:	83 c4 18             	add    $0x18,%esp
}
  80204a:	90                   	nop
  80204b:	c9                   	leave  
  80204c:	c3                   	ret    

0080204d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80204d:	55                   	push   %ebp
  80204e:	89 e5                	mov    %esp,%ebp
  802050:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802053:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802056:	8d 50 04             	lea    0x4(%eax),%edx
  802059:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80205c:	6a 00                	push   $0x0
  80205e:	6a 00                	push   $0x0
  802060:	6a 00                	push   $0x0
  802062:	52                   	push   %edx
  802063:	50                   	push   %eax
  802064:	6a 24                	push   $0x24
  802066:	e8 cb fb ff ff       	call   801c36 <syscall>
  80206b:	83 c4 18             	add    $0x18,%esp
	return result;
  80206e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802071:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802074:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802077:	89 01                	mov    %eax,(%ecx)
  802079:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80207c:	8b 45 08             	mov    0x8(%ebp),%eax
  80207f:	c9                   	leave  
  802080:	c2 04 00             	ret    $0x4

00802083 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802083:	55                   	push   %ebp
  802084:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802086:	6a 00                	push   $0x0
  802088:	6a 00                	push   $0x0
  80208a:	ff 75 10             	pushl  0x10(%ebp)
  80208d:	ff 75 0c             	pushl  0xc(%ebp)
  802090:	ff 75 08             	pushl  0x8(%ebp)
  802093:	6a 13                	push   $0x13
  802095:	e8 9c fb ff ff       	call   801c36 <syscall>
  80209a:	83 c4 18             	add    $0x18,%esp
	return ;
  80209d:	90                   	nop
}
  80209e:	c9                   	leave  
  80209f:	c3                   	ret    

008020a0 <sys_rcr2>:
uint32 sys_rcr2()
{
  8020a0:	55                   	push   %ebp
  8020a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8020a3:	6a 00                	push   $0x0
  8020a5:	6a 00                	push   $0x0
  8020a7:	6a 00                	push   $0x0
  8020a9:	6a 00                	push   $0x0
  8020ab:	6a 00                	push   $0x0
  8020ad:	6a 25                	push   $0x25
  8020af:	e8 82 fb ff ff       	call   801c36 <syscall>
  8020b4:	83 c4 18             	add    $0x18,%esp
}
  8020b7:	c9                   	leave  
  8020b8:	c3                   	ret    

008020b9 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8020b9:	55                   	push   %ebp
  8020ba:	89 e5                	mov    %esp,%ebp
  8020bc:	83 ec 04             	sub    $0x4,%esp
  8020bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8020c5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8020c9:	6a 00                	push   $0x0
  8020cb:	6a 00                	push   $0x0
  8020cd:	6a 00                	push   $0x0
  8020cf:	6a 00                	push   $0x0
  8020d1:	50                   	push   %eax
  8020d2:	6a 26                	push   $0x26
  8020d4:	e8 5d fb ff ff       	call   801c36 <syscall>
  8020d9:	83 c4 18             	add    $0x18,%esp
	return ;
  8020dc:	90                   	nop
}
  8020dd:	c9                   	leave  
  8020de:	c3                   	ret    

008020df <rsttst>:
void rsttst()
{
  8020df:	55                   	push   %ebp
  8020e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8020e2:	6a 00                	push   $0x0
  8020e4:	6a 00                	push   $0x0
  8020e6:	6a 00                	push   $0x0
  8020e8:	6a 00                	push   $0x0
  8020ea:	6a 00                	push   $0x0
  8020ec:	6a 28                	push   $0x28
  8020ee:	e8 43 fb ff ff       	call   801c36 <syscall>
  8020f3:	83 c4 18             	add    $0x18,%esp
	return ;
  8020f6:	90                   	nop
}
  8020f7:	c9                   	leave  
  8020f8:	c3                   	ret    

008020f9 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8020f9:	55                   	push   %ebp
  8020fa:	89 e5                	mov    %esp,%ebp
  8020fc:	83 ec 04             	sub    $0x4,%esp
  8020ff:	8b 45 14             	mov    0x14(%ebp),%eax
  802102:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802105:	8b 55 18             	mov    0x18(%ebp),%edx
  802108:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80210c:	52                   	push   %edx
  80210d:	50                   	push   %eax
  80210e:	ff 75 10             	pushl  0x10(%ebp)
  802111:	ff 75 0c             	pushl  0xc(%ebp)
  802114:	ff 75 08             	pushl  0x8(%ebp)
  802117:	6a 27                	push   $0x27
  802119:	e8 18 fb ff ff       	call   801c36 <syscall>
  80211e:	83 c4 18             	add    $0x18,%esp
	return ;
  802121:	90                   	nop
}
  802122:	c9                   	leave  
  802123:	c3                   	ret    

00802124 <chktst>:
void chktst(uint32 n)
{
  802124:	55                   	push   %ebp
  802125:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802127:	6a 00                	push   $0x0
  802129:	6a 00                	push   $0x0
  80212b:	6a 00                	push   $0x0
  80212d:	6a 00                	push   $0x0
  80212f:	ff 75 08             	pushl  0x8(%ebp)
  802132:	6a 29                	push   $0x29
  802134:	e8 fd fa ff ff       	call   801c36 <syscall>
  802139:	83 c4 18             	add    $0x18,%esp
	return ;
  80213c:	90                   	nop
}
  80213d:	c9                   	leave  
  80213e:	c3                   	ret    

0080213f <inctst>:

void inctst()
{
  80213f:	55                   	push   %ebp
  802140:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802142:	6a 00                	push   $0x0
  802144:	6a 00                	push   $0x0
  802146:	6a 00                	push   $0x0
  802148:	6a 00                	push   $0x0
  80214a:	6a 00                	push   $0x0
  80214c:	6a 2a                	push   $0x2a
  80214e:	e8 e3 fa ff ff       	call   801c36 <syscall>
  802153:	83 c4 18             	add    $0x18,%esp
	return ;
  802156:	90                   	nop
}
  802157:	c9                   	leave  
  802158:	c3                   	ret    

00802159 <gettst>:
uint32 gettst()
{
  802159:	55                   	push   %ebp
  80215a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80215c:	6a 00                	push   $0x0
  80215e:	6a 00                	push   $0x0
  802160:	6a 00                	push   $0x0
  802162:	6a 00                	push   $0x0
  802164:	6a 00                	push   $0x0
  802166:	6a 2b                	push   $0x2b
  802168:	e8 c9 fa ff ff       	call   801c36 <syscall>
  80216d:	83 c4 18             	add    $0x18,%esp
}
  802170:	c9                   	leave  
  802171:	c3                   	ret    

00802172 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802172:	55                   	push   %ebp
  802173:	89 e5                	mov    %esp,%ebp
  802175:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802178:	6a 00                	push   $0x0
  80217a:	6a 00                	push   $0x0
  80217c:	6a 00                	push   $0x0
  80217e:	6a 00                	push   $0x0
  802180:	6a 00                	push   $0x0
  802182:	6a 2c                	push   $0x2c
  802184:	e8 ad fa ff ff       	call   801c36 <syscall>
  802189:	83 c4 18             	add    $0x18,%esp
  80218c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80218f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802193:	75 07                	jne    80219c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802195:	b8 01 00 00 00       	mov    $0x1,%eax
  80219a:	eb 05                	jmp    8021a1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80219c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021a1:	c9                   	leave  
  8021a2:	c3                   	ret    

008021a3 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8021a3:	55                   	push   %ebp
  8021a4:	89 e5                	mov    %esp,%ebp
  8021a6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	6a 00                	push   $0x0
  8021af:	6a 00                	push   $0x0
  8021b1:	6a 00                	push   $0x0
  8021b3:	6a 2c                	push   $0x2c
  8021b5:	e8 7c fa ff ff       	call   801c36 <syscall>
  8021ba:	83 c4 18             	add    $0x18,%esp
  8021bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8021c0:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8021c4:	75 07                	jne    8021cd <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8021c6:	b8 01 00 00 00       	mov    $0x1,%eax
  8021cb:	eb 05                	jmp    8021d2 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8021cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021d2:	c9                   	leave  
  8021d3:	c3                   	ret    

008021d4 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8021d4:	55                   	push   %ebp
  8021d5:	89 e5                	mov    %esp,%ebp
  8021d7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021da:	6a 00                	push   $0x0
  8021dc:	6a 00                	push   $0x0
  8021de:	6a 00                	push   $0x0
  8021e0:	6a 00                	push   $0x0
  8021e2:	6a 00                	push   $0x0
  8021e4:	6a 2c                	push   $0x2c
  8021e6:	e8 4b fa ff ff       	call   801c36 <syscall>
  8021eb:	83 c4 18             	add    $0x18,%esp
  8021ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8021f1:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8021f5:	75 07                	jne    8021fe <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8021f7:	b8 01 00 00 00       	mov    $0x1,%eax
  8021fc:	eb 05                	jmp    802203 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8021fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802203:	c9                   	leave  
  802204:	c3                   	ret    

00802205 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802205:	55                   	push   %ebp
  802206:	89 e5                	mov    %esp,%ebp
  802208:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80220b:	6a 00                	push   $0x0
  80220d:	6a 00                	push   $0x0
  80220f:	6a 00                	push   $0x0
  802211:	6a 00                	push   $0x0
  802213:	6a 00                	push   $0x0
  802215:	6a 2c                	push   $0x2c
  802217:	e8 1a fa ff ff       	call   801c36 <syscall>
  80221c:	83 c4 18             	add    $0x18,%esp
  80221f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802222:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802226:	75 07                	jne    80222f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802228:	b8 01 00 00 00       	mov    $0x1,%eax
  80222d:	eb 05                	jmp    802234 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80222f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802234:	c9                   	leave  
  802235:	c3                   	ret    

00802236 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802236:	55                   	push   %ebp
  802237:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802239:	6a 00                	push   $0x0
  80223b:	6a 00                	push   $0x0
  80223d:	6a 00                	push   $0x0
  80223f:	6a 00                	push   $0x0
  802241:	ff 75 08             	pushl  0x8(%ebp)
  802244:	6a 2d                	push   $0x2d
  802246:	e8 eb f9 ff ff       	call   801c36 <syscall>
  80224b:	83 c4 18             	add    $0x18,%esp
	return ;
  80224e:	90                   	nop
}
  80224f:	c9                   	leave  
  802250:	c3                   	ret    

00802251 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802251:	55                   	push   %ebp
  802252:	89 e5                	mov    %esp,%ebp
  802254:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802255:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802258:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80225b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80225e:	8b 45 08             	mov    0x8(%ebp),%eax
  802261:	6a 00                	push   $0x0
  802263:	53                   	push   %ebx
  802264:	51                   	push   %ecx
  802265:	52                   	push   %edx
  802266:	50                   	push   %eax
  802267:	6a 2e                	push   $0x2e
  802269:	e8 c8 f9 ff ff       	call   801c36 <syscall>
  80226e:	83 c4 18             	add    $0x18,%esp
}
  802271:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802274:	c9                   	leave  
  802275:	c3                   	ret    

00802276 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802276:	55                   	push   %ebp
  802277:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802279:	8b 55 0c             	mov    0xc(%ebp),%edx
  80227c:	8b 45 08             	mov    0x8(%ebp),%eax
  80227f:	6a 00                	push   $0x0
  802281:	6a 00                	push   $0x0
  802283:	6a 00                	push   $0x0
  802285:	52                   	push   %edx
  802286:	50                   	push   %eax
  802287:	6a 2f                	push   $0x2f
  802289:	e8 a8 f9 ff ff       	call   801c36 <syscall>
  80228e:	83 c4 18             	add    $0x18,%esp
}
  802291:	c9                   	leave  
  802292:	c3                   	ret    
  802293:	90                   	nop

00802294 <__udivdi3>:
  802294:	55                   	push   %ebp
  802295:	57                   	push   %edi
  802296:	56                   	push   %esi
  802297:	53                   	push   %ebx
  802298:	83 ec 1c             	sub    $0x1c,%esp
  80229b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80229f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8022a3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022a7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8022ab:	89 ca                	mov    %ecx,%edx
  8022ad:	89 f8                	mov    %edi,%eax
  8022af:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8022b3:	85 f6                	test   %esi,%esi
  8022b5:	75 2d                	jne    8022e4 <__udivdi3+0x50>
  8022b7:	39 cf                	cmp    %ecx,%edi
  8022b9:	77 65                	ja     802320 <__udivdi3+0x8c>
  8022bb:	89 fd                	mov    %edi,%ebp
  8022bd:	85 ff                	test   %edi,%edi
  8022bf:	75 0b                	jne    8022cc <__udivdi3+0x38>
  8022c1:	b8 01 00 00 00       	mov    $0x1,%eax
  8022c6:	31 d2                	xor    %edx,%edx
  8022c8:	f7 f7                	div    %edi
  8022ca:	89 c5                	mov    %eax,%ebp
  8022cc:	31 d2                	xor    %edx,%edx
  8022ce:	89 c8                	mov    %ecx,%eax
  8022d0:	f7 f5                	div    %ebp
  8022d2:	89 c1                	mov    %eax,%ecx
  8022d4:	89 d8                	mov    %ebx,%eax
  8022d6:	f7 f5                	div    %ebp
  8022d8:	89 cf                	mov    %ecx,%edi
  8022da:	89 fa                	mov    %edi,%edx
  8022dc:	83 c4 1c             	add    $0x1c,%esp
  8022df:	5b                   	pop    %ebx
  8022e0:	5e                   	pop    %esi
  8022e1:	5f                   	pop    %edi
  8022e2:	5d                   	pop    %ebp
  8022e3:	c3                   	ret    
  8022e4:	39 ce                	cmp    %ecx,%esi
  8022e6:	77 28                	ja     802310 <__udivdi3+0x7c>
  8022e8:	0f bd fe             	bsr    %esi,%edi
  8022eb:	83 f7 1f             	xor    $0x1f,%edi
  8022ee:	75 40                	jne    802330 <__udivdi3+0x9c>
  8022f0:	39 ce                	cmp    %ecx,%esi
  8022f2:	72 0a                	jb     8022fe <__udivdi3+0x6a>
  8022f4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8022f8:	0f 87 9e 00 00 00    	ja     80239c <__udivdi3+0x108>
  8022fe:	b8 01 00 00 00       	mov    $0x1,%eax
  802303:	89 fa                	mov    %edi,%edx
  802305:	83 c4 1c             	add    $0x1c,%esp
  802308:	5b                   	pop    %ebx
  802309:	5e                   	pop    %esi
  80230a:	5f                   	pop    %edi
  80230b:	5d                   	pop    %ebp
  80230c:	c3                   	ret    
  80230d:	8d 76 00             	lea    0x0(%esi),%esi
  802310:	31 ff                	xor    %edi,%edi
  802312:	31 c0                	xor    %eax,%eax
  802314:	89 fa                	mov    %edi,%edx
  802316:	83 c4 1c             	add    $0x1c,%esp
  802319:	5b                   	pop    %ebx
  80231a:	5e                   	pop    %esi
  80231b:	5f                   	pop    %edi
  80231c:	5d                   	pop    %ebp
  80231d:	c3                   	ret    
  80231e:	66 90                	xchg   %ax,%ax
  802320:	89 d8                	mov    %ebx,%eax
  802322:	f7 f7                	div    %edi
  802324:	31 ff                	xor    %edi,%edi
  802326:	89 fa                	mov    %edi,%edx
  802328:	83 c4 1c             	add    $0x1c,%esp
  80232b:	5b                   	pop    %ebx
  80232c:	5e                   	pop    %esi
  80232d:	5f                   	pop    %edi
  80232e:	5d                   	pop    %ebp
  80232f:	c3                   	ret    
  802330:	bd 20 00 00 00       	mov    $0x20,%ebp
  802335:	89 eb                	mov    %ebp,%ebx
  802337:	29 fb                	sub    %edi,%ebx
  802339:	89 f9                	mov    %edi,%ecx
  80233b:	d3 e6                	shl    %cl,%esi
  80233d:	89 c5                	mov    %eax,%ebp
  80233f:	88 d9                	mov    %bl,%cl
  802341:	d3 ed                	shr    %cl,%ebp
  802343:	89 e9                	mov    %ebp,%ecx
  802345:	09 f1                	or     %esi,%ecx
  802347:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80234b:	89 f9                	mov    %edi,%ecx
  80234d:	d3 e0                	shl    %cl,%eax
  80234f:	89 c5                	mov    %eax,%ebp
  802351:	89 d6                	mov    %edx,%esi
  802353:	88 d9                	mov    %bl,%cl
  802355:	d3 ee                	shr    %cl,%esi
  802357:	89 f9                	mov    %edi,%ecx
  802359:	d3 e2                	shl    %cl,%edx
  80235b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80235f:	88 d9                	mov    %bl,%cl
  802361:	d3 e8                	shr    %cl,%eax
  802363:	09 c2                	or     %eax,%edx
  802365:	89 d0                	mov    %edx,%eax
  802367:	89 f2                	mov    %esi,%edx
  802369:	f7 74 24 0c          	divl   0xc(%esp)
  80236d:	89 d6                	mov    %edx,%esi
  80236f:	89 c3                	mov    %eax,%ebx
  802371:	f7 e5                	mul    %ebp
  802373:	39 d6                	cmp    %edx,%esi
  802375:	72 19                	jb     802390 <__udivdi3+0xfc>
  802377:	74 0b                	je     802384 <__udivdi3+0xf0>
  802379:	89 d8                	mov    %ebx,%eax
  80237b:	31 ff                	xor    %edi,%edi
  80237d:	e9 58 ff ff ff       	jmp    8022da <__udivdi3+0x46>
  802382:	66 90                	xchg   %ax,%ax
  802384:	8b 54 24 08          	mov    0x8(%esp),%edx
  802388:	89 f9                	mov    %edi,%ecx
  80238a:	d3 e2                	shl    %cl,%edx
  80238c:	39 c2                	cmp    %eax,%edx
  80238e:	73 e9                	jae    802379 <__udivdi3+0xe5>
  802390:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802393:	31 ff                	xor    %edi,%edi
  802395:	e9 40 ff ff ff       	jmp    8022da <__udivdi3+0x46>
  80239a:	66 90                	xchg   %ax,%ax
  80239c:	31 c0                	xor    %eax,%eax
  80239e:	e9 37 ff ff ff       	jmp    8022da <__udivdi3+0x46>
  8023a3:	90                   	nop

008023a4 <__umoddi3>:
  8023a4:	55                   	push   %ebp
  8023a5:	57                   	push   %edi
  8023a6:	56                   	push   %esi
  8023a7:	53                   	push   %ebx
  8023a8:	83 ec 1c             	sub    $0x1c,%esp
  8023ab:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8023af:	8b 74 24 34          	mov    0x34(%esp),%esi
  8023b3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023b7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8023bb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8023bf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8023c3:	89 f3                	mov    %esi,%ebx
  8023c5:	89 fa                	mov    %edi,%edx
  8023c7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023cb:	89 34 24             	mov    %esi,(%esp)
  8023ce:	85 c0                	test   %eax,%eax
  8023d0:	75 1a                	jne    8023ec <__umoddi3+0x48>
  8023d2:	39 f7                	cmp    %esi,%edi
  8023d4:	0f 86 a2 00 00 00    	jbe    80247c <__umoddi3+0xd8>
  8023da:	89 c8                	mov    %ecx,%eax
  8023dc:	89 f2                	mov    %esi,%edx
  8023de:	f7 f7                	div    %edi
  8023e0:	89 d0                	mov    %edx,%eax
  8023e2:	31 d2                	xor    %edx,%edx
  8023e4:	83 c4 1c             	add    $0x1c,%esp
  8023e7:	5b                   	pop    %ebx
  8023e8:	5e                   	pop    %esi
  8023e9:	5f                   	pop    %edi
  8023ea:	5d                   	pop    %ebp
  8023eb:	c3                   	ret    
  8023ec:	39 f0                	cmp    %esi,%eax
  8023ee:	0f 87 ac 00 00 00    	ja     8024a0 <__umoddi3+0xfc>
  8023f4:	0f bd e8             	bsr    %eax,%ebp
  8023f7:	83 f5 1f             	xor    $0x1f,%ebp
  8023fa:	0f 84 ac 00 00 00    	je     8024ac <__umoddi3+0x108>
  802400:	bf 20 00 00 00       	mov    $0x20,%edi
  802405:	29 ef                	sub    %ebp,%edi
  802407:	89 fe                	mov    %edi,%esi
  802409:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80240d:	89 e9                	mov    %ebp,%ecx
  80240f:	d3 e0                	shl    %cl,%eax
  802411:	89 d7                	mov    %edx,%edi
  802413:	89 f1                	mov    %esi,%ecx
  802415:	d3 ef                	shr    %cl,%edi
  802417:	09 c7                	or     %eax,%edi
  802419:	89 e9                	mov    %ebp,%ecx
  80241b:	d3 e2                	shl    %cl,%edx
  80241d:	89 14 24             	mov    %edx,(%esp)
  802420:	89 d8                	mov    %ebx,%eax
  802422:	d3 e0                	shl    %cl,%eax
  802424:	89 c2                	mov    %eax,%edx
  802426:	8b 44 24 08          	mov    0x8(%esp),%eax
  80242a:	d3 e0                	shl    %cl,%eax
  80242c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802430:	8b 44 24 08          	mov    0x8(%esp),%eax
  802434:	89 f1                	mov    %esi,%ecx
  802436:	d3 e8                	shr    %cl,%eax
  802438:	09 d0                	or     %edx,%eax
  80243a:	d3 eb                	shr    %cl,%ebx
  80243c:	89 da                	mov    %ebx,%edx
  80243e:	f7 f7                	div    %edi
  802440:	89 d3                	mov    %edx,%ebx
  802442:	f7 24 24             	mull   (%esp)
  802445:	89 c6                	mov    %eax,%esi
  802447:	89 d1                	mov    %edx,%ecx
  802449:	39 d3                	cmp    %edx,%ebx
  80244b:	0f 82 87 00 00 00    	jb     8024d8 <__umoddi3+0x134>
  802451:	0f 84 91 00 00 00    	je     8024e8 <__umoddi3+0x144>
  802457:	8b 54 24 04          	mov    0x4(%esp),%edx
  80245b:	29 f2                	sub    %esi,%edx
  80245d:	19 cb                	sbb    %ecx,%ebx
  80245f:	89 d8                	mov    %ebx,%eax
  802461:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802465:	d3 e0                	shl    %cl,%eax
  802467:	89 e9                	mov    %ebp,%ecx
  802469:	d3 ea                	shr    %cl,%edx
  80246b:	09 d0                	or     %edx,%eax
  80246d:	89 e9                	mov    %ebp,%ecx
  80246f:	d3 eb                	shr    %cl,%ebx
  802471:	89 da                	mov    %ebx,%edx
  802473:	83 c4 1c             	add    $0x1c,%esp
  802476:	5b                   	pop    %ebx
  802477:	5e                   	pop    %esi
  802478:	5f                   	pop    %edi
  802479:	5d                   	pop    %ebp
  80247a:	c3                   	ret    
  80247b:	90                   	nop
  80247c:	89 fd                	mov    %edi,%ebp
  80247e:	85 ff                	test   %edi,%edi
  802480:	75 0b                	jne    80248d <__umoddi3+0xe9>
  802482:	b8 01 00 00 00       	mov    $0x1,%eax
  802487:	31 d2                	xor    %edx,%edx
  802489:	f7 f7                	div    %edi
  80248b:	89 c5                	mov    %eax,%ebp
  80248d:	89 f0                	mov    %esi,%eax
  80248f:	31 d2                	xor    %edx,%edx
  802491:	f7 f5                	div    %ebp
  802493:	89 c8                	mov    %ecx,%eax
  802495:	f7 f5                	div    %ebp
  802497:	89 d0                	mov    %edx,%eax
  802499:	e9 44 ff ff ff       	jmp    8023e2 <__umoddi3+0x3e>
  80249e:	66 90                	xchg   %ax,%ax
  8024a0:	89 c8                	mov    %ecx,%eax
  8024a2:	89 f2                	mov    %esi,%edx
  8024a4:	83 c4 1c             	add    $0x1c,%esp
  8024a7:	5b                   	pop    %ebx
  8024a8:	5e                   	pop    %esi
  8024a9:	5f                   	pop    %edi
  8024aa:	5d                   	pop    %ebp
  8024ab:	c3                   	ret    
  8024ac:	3b 04 24             	cmp    (%esp),%eax
  8024af:	72 06                	jb     8024b7 <__umoddi3+0x113>
  8024b1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8024b5:	77 0f                	ja     8024c6 <__umoddi3+0x122>
  8024b7:	89 f2                	mov    %esi,%edx
  8024b9:	29 f9                	sub    %edi,%ecx
  8024bb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8024bf:	89 14 24             	mov    %edx,(%esp)
  8024c2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024c6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8024ca:	8b 14 24             	mov    (%esp),%edx
  8024cd:	83 c4 1c             	add    $0x1c,%esp
  8024d0:	5b                   	pop    %ebx
  8024d1:	5e                   	pop    %esi
  8024d2:	5f                   	pop    %edi
  8024d3:	5d                   	pop    %ebp
  8024d4:	c3                   	ret    
  8024d5:	8d 76 00             	lea    0x0(%esi),%esi
  8024d8:	2b 04 24             	sub    (%esp),%eax
  8024db:	19 fa                	sbb    %edi,%edx
  8024dd:	89 d1                	mov    %edx,%ecx
  8024df:	89 c6                	mov    %eax,%esi
  8024e1:	e9 71 ff ff ff       	jmp    802457 <__umoddi3+0xb3>
  8024e6:	66 90                	xchg   %ax,%ax
  8024e8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8024ec:	72 ea                	jb     8024d8 <__umoddi3+0x134>
  8024ee:	89 d9                	mov    %ebx,%ecx
  8024f0:	e9 62 ff ff ff       	jmp    802457 <__umoddi3+0xb3>
