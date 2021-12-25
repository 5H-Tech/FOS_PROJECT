
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
  800031:	e8 9a 07 00 00       	call   8007d0 <libmain>
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
  80004b:	e8 5f 1f 00 00       	call   801faf <sys_disable_interrupt>

		cprintf("\n");
  800050:	83 ec 0c             	sub    $0xc,%esp
  800053:	68 40 26 80 00       	push   $0x802640
  800058:	e8 5a 0b 00 00       	call   800bb7 <cprintf>
  80005d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800060:	83 ec 0c             	sub    $0xc,%esp
  800063:	68 42 26 80 00       	push   $0x802642
  800068:	e8 4a 0b 00 00       	call   800bb7 <cprintf>
  80006d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800070:	83 ec 0c             	sub    $0xc,%esp
  800073:	68 58 26 80 00       	push   $0x802658
  800078:	e8 3a 0b 00 00       	call   800bb7 <cprintf>
  80007d:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800080:	83 ec 0c             	sub    $0xc,%esp
  800083:	68 42 26 80 00       	push   $0x802642
  800088:	e8 2a 0b 00 00       	call   800bb7 <cprintf>
  80008d:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800090:	83 ec 0c             	sub    $0xc,%esp
  800093:	68 40 26 80 00       	push   $0x802640
  800098:	e8 1a 0b 00 00       	call   800bb7 <cprintf>
  80009d:	83 c4 10             	add    $0x10,%esp
		cprintf("Enter the number of elements: ");
  8000a0:	83 ec 0c             	sub    $0xc,%esp
  8000a3:	68 70 26 80 00       	push   $0x802670
  8000a8:	e8 0a 0b 00 00       	call   800bb7 <cprintf>
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
  8000d2:	68 8f 26 80 00       	push   $0x80268f
  8000d7:	e8 db 0a 00 00       	call   800bb7 <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000e2:	c1 e0 02             	shl    $0x2,%eax
  8000e5:	83 ec 0c             	sub    $0xc,%esp
  8000e8:	50                   	push   %eax
  8000e9:	e8 53 18 00 00       	call   801941 <malloc>
  8000ee:	83 c4 10             	add    $0x10,%esp
  8000f1:	89 45 e8             	mov    %eax,-0x18(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000f4:	83 ec 0c             	sub    $0xc,%esp
  8000f7:	68 94 26 80 00       	push   $0x802694
  8000fc:	e8 b6 0a 00 00       	call   800bb7 <cprintf>
  800101:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  800104:	83 ec 0c             	sub    $0xc,%esp
  800107:	68 b6 26 80 00       	push   $0x8026b6
  80010c:	e8 a6 0a 00 00       	call   800bb7 <cprintf>
  800111:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  800114:	83 ec 0c             	sub    $0xc,%esp
  800117:	68 c4 26 80 00       	push   $0x8026c4
  80011c:	e8 96 0a 00 00       	call   800bb7 <cprintf>
  800121:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800124:	83 ec 0c             	sub    $0xc,%esp
  800127:	68 d3 26 80 00       	push   $0x8026d3
  80012c:	e8 86 0a 00 00       	call   800bb7 <cprintf>
  800131:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800134:	83 ec 0c             	sub    $0xc,%esp
  800137:	68 e3 26 80 00       	push   $0x8026e3
  80013c:	e8 76 0a 00 00       	call   800bb7 <cprintf>
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
  800162:	e8 c9 05 00 00       	call   800730 <cputchar>
  800167:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80016a:	83 ec 0c             	sub    $0xc,%esp
  80016d:	6a 0a                	push   $0xa
  80016f:	e8 bc 05 00 00       	call   800730 <cputchar>
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
  800189:	e8 3b 1e 00 00       	call   801fc9 <sys_enable_interrupt>

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
  8001aa:	e8 f4 01 00 00       	call   8003a3 <InitializeAscending>
  8001af:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b2:	eb 37                	jmp    8001eb <_main+0x1b3>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  8001b4:	83 ec 08             	sub    $0x8,%esp
  8001b7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001ba:	ff 75 e8             	pushl  -0x18(%ebp)
  8001bd:	e8 12 02 00 00       	call   8003d4 <InitializeDescending>
  8001c2:	83 c4 10             	add    $0x10,%esp
			break ;
  8001c5:	eb 24                	jmp    8001eb <_main+0x1b3>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001c7:	83 ec 08             	sub    $0x8,%esp
  8001ca:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cd:	ff 75 e8             	pushl  -0x18(%ebp)
  8001d0:	e8 34 02 00 00       	call   800409 <InitializeSemiRandom>
  8001d5:	83 c4 10             	add    $0x10,%esp
			break ;
  8001d8:	eb 11                	jmp    8001eb <_main+0x1b3>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001da:	83 ec 08             	sub    $0x8,%esp
  8001dd:	ff 75 ec             	pushl  -0x14(%ebp)
  8001e0:	ff 75 e8             	pushl  -0x18(%ebp)
  8001e3:	e8 21 02 00 00       	call   800409 <InitializeSemiRandom>
  8001e8:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001eb:	83 ec 04             	sub    $0x4,%esp
  8001ee:	ff 75 ec             	pushl  -0x14(%ebp)
  8001f1:	6a 01                	push   $0x1
  8001f3:	ff 75 e8             	pushl  -0x18(%ebp)
  8001f6:	e8 e0 02 00 00       	call   8004db <MSort>
  8001fb:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001fe:	e8 ac 1d 00 00       	call   801faf <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  800203:	83 ec 0c             	sub    $0xc,%esp
  800206:	68 ec 26 80 00       	push   $0x8026ec
  80020b:	e8 a7 09 00 00       	call   800bb7 <cprintf>
  800210:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  800213:	e8 b1 1d 00 00       	call   801fc9 <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800218:	83 ec 08             	sub    $0x8,%esp
  80021b:	ff 75 ec             	pushl  -0x14(%ebp)
  80021e:	ff 75 e8             	pushl  -0x18(%ebp)
  800221:	e8 d3 00 00 00       	call   8002f9 <CheckSorted>
  800226:	83 c4 10             	add    $0x10,%esp
  800229:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  80022c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800230:	75 14                	jne    800246 <_main+0x20e>
  800232:	83 ec 04             	sub    $0x4,%esp
  800235:	68 20 27 80 00       	push   $0x802720
  80023a:	6a 58                	push   $0x58
  80023c:	68 42 27 80 00       	push   $0x802742
  800241:	e8 cf 06 00 00       	call   800915 <_panic>
		else
		{
			sys_disable_interrupt();
  800246:	e8 64 1d 00 00       	call   801faf <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  80024b:	83 ec 0c             	sub    $0xc,%esp
  80024e:	68 60 27 80 00       	push   $0x802760
  800253:	e8 5f 09 00 00       	call   800bb7 <cprintf>
  800258:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80025b:	83 ec 0c             	sub    $0xc,%esp
  80025e:	68 94 27 80 00       	push   $0x802794
  800263:	e8 4f 09 00 00       	call   800bb7 <cprintf>
  800268:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80026b:	83 ec 0c             	sub    $0xc,%esp
  80026e:	68 c8 27 80 00       	push   $0x8027c8
  800273:	e8 3f 09 00 00       	call   800bb7 <cprintf>
  800278:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80027b:	e8 49 1d 00 00       	call   801fc9 <sys_enable_interrupt>
		}

		//free(Elements) ;

		sys_disable_interrupt();
  800280:	e8 2a 1d 00 00       	call   801faf <sys_disable_interrupt>
		Chose = 0 ;
  800285:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
		while (Chose != 'y' && Chose != 'n')
  800289:	eb 50                	jmp    8002db <_main+0x2a3>
		{
			cprintf("Do you want to repeat (y/n): ") ;
  80028b:	83 ec 0c             	sub    $0xc,%esp
  80028e:	68 fa 27 80 00       	push   $0x8027fa
  800293:	e8 1f 09 00 00       	call   800bb7 <cprintf>
  800298:	83 c4 10             	add    $0x10,%esp
			if (numOfRep == 1)
  80029b:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  80029f:	75 06                	jne    8002a7 <_main+0x26f>
				Chose = 'y' ;
  8002a1:	c6 45 f7 79          	movb   $0x79,-0x9(%ebp)
  8002a5:	eb 0a                	jmp    8002b1 <_main+0x279>
			else if (numOfRep == 2)
  8002a7:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  8002ab:	75 04                	jne    8002b1 <_main+0x279>
				Chose = 'n' ;
  8002ad:	c6 45 f7 6e          	movb   $0x6e,-0x9(%ebp)
			cputchar(Chose);
  8002b1:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8002b5:	83 ec 0c             	sub    $0xc,%esp
  8002b8:	50                   	push   %eax
  8002b9:	e8 72 04 00 00       	call   800730 <cputchar>
  8002be:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8002c1:	83 ec 0c             	sub    $0xc,%esp
  8002c4:	6a 0a                	push   $0xa
  8002c6:	e8 65 04 00 00       	call   800730 <cputchar>
  8002cb:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8002ce:	83 ec 0c             	sub    $0xc,%esp
  8002d1:	6a 0a                	push   $0xa
  8002d3:	e8 58 04 00 00       	call   800730 <cputchar>
  8002d8:	83 c4 10             	add    $0x10,%esp

		//free(Elements) ;

		sys_disable_interrupt();
		Chose = 0 ;
		while (Chose != 'y' && Chose != 'n')
  8002db:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002df:	74 06                	je     8002e7 <_main+0x2af>
  8002e1:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002e5:	75 a4                	jne    80028b <_main+0x253>
				Chose = 'n' ;
			cputchar(Chose);
			cputchar('\n');
			cputchar('\n');
		}
		sys_enable_interrupt();
  8002e7:	e8 dd 1c 00 00       	call   801fc9 <sys_enable_interrupt>

	} while (Chose == 'y');
  8002ec:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002f0:	0f 84 52 fd ff ff    	je     800048 <_main+0x10>
}
  8002f6:	90                   	nop
  8002f7:	c9                   	leave  
  8002f8:	c3                   	ret    

008002f9 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002f9:	55                   	push   %ebp
  8002fa:	89 e5                	mov    %esp,%ebp
  8002fc:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002ff:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800306:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80030d:	eb 33                	jmp    800342 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80030f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800312:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800319:	8b 45 08             	mov    0x8(%ebp),%eax
  80031c:	01 d0                	add    %edx,%eax
  80031e:	8b 10                	mov    (%eax),%edx
  800320:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800323:	40                   	inc    %eax
  800324:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80032b:	8b 45 08             	mov    0x8(%ebp),%eax
  80032e:	01 c8                	add    %ecx,%eax
  800330:	8b 00                	mov    (%eax),%eax
  800332:	39 c2                	cmp    %eax,%edx
  800334:	7e 09                	jle    80033f <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800336:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80033d:	eb 0c                	jmp    80034b <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80033f:	ff 45 f8             	incl   -0x8(%ebp)
  800342:	8b 45 0c             	mov    0xc(%ebp),%eax
  800345:	48                   	dec    %eax
  800346:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800349:	7f c4                	jg     80030f <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  80034b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80034e:	c9                   	leave  
  80034f:	c3                   	ret    

00800350 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800350:	55                   	push   %ebp
  800351:	89 e5                	mov    %esp,%ebp
  800353:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800356:	8b 45 0c             	mov    0xc(%ebp),%eax
  800359:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800360:	8b 45 08             	mov    0x8(%ebp),%eax
  800363:	01 d0                	add    %edx,%eax
  800365:	8b 00                	mov    (%eax),%eax
  800367:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  80036a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80036d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800374:	8b 45 08             	mov    0x8(%ebp),%eax
  800377:	01 c2                	add    %eax,%edx
  800379:	8b 45 10             	mov    0x10(%ebp),%eax
  80037c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800383:	8b 45 08             	mov    0x8(%ebp),%eax
  800386:	01 c8                	add    %ecx,%eax
  800388:	8b 00                	mov    (%eax),%eax
  80038a:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  80038c:	8b 45 10             	mov    0x10(%ebp),%eax
  80038f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800396:	8b 45 08             	mov    0x8(%ebp),%eax
  800399:	01 c2                	add    %eax,%edx
  80039b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80039e:	89 02                	mov    %eax,(%edx)
}
  8003a0:	90                   	nop
  8003a1:	c9                   	leave  
  8003a2:	c3                   	ret    

008003a3 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8003a3:	55                   	push   %ebp
  8003a4:	89 e5                	mov    %esp,%ebp
  8003a6:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003b0:	eb 17                	jmp    8003c9 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  8003b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003b5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bf:	01 c2                	add    %eax,%edx
  8003c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003c4:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003c6:	ff 45 fc             	incl   -0x4(%ebp)
  8003c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003cc:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003cf:	7c e1                	jl     8003b2 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8003d1:	90                   	nop
  8003d2:	c9                   	leave  
  8003d3:	c3                   	ret    

008003d4 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8003d4:	55                   	push   %ebp
  8003d5:	89 e5                	mov    %esp,%ebp
  8003d7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003e1:	eb 1b                	jmp    8003fe <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003e6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f0:	01 c2                	add    %eax,%edx
  8003f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003f5:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003f8:	48                   	dec    %eax
  8003f9:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003fb:	ff 45 fc             	incl   -0x4(%ebp)
  8003fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800401:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800404:	7c dd                	jl     8003e3 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800406:	90                   	nop
  800407:	c9                   	leave  
  800408:	c3                   	ret    

00800409 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800409:	55                   	push   %ebp
  80040a:	89 e5                	mov    %esp,%ebp
  80040c:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80040f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800412:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800417:	f7 e9                	imul   %ecx
  800419:	c1 f9 1f             	sar    $0x1f,%ecx
  80041c:	89 d0                	mov    %edx,%eax
  80041e:	29 c8                	sub    %ecx,%eax
  800420:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800423:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80042a:	eb 1e                	jmp    80044a <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  80042c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80042f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800436:	8b 45 08             	mov    0x8(%ebp),%eax
  800439:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80043c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80043f:	99                   	cltd   
  800440:	f7 7d f8             	idivl  -0x8(%ebp)
  800443:	89 d0                	mov    %edx,%eax
  800445:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800447:	ff 45 fc             	incl   -0x4(%ebp)
  80044a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80044d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800450:	7c da                	jl     80042c <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  800452:	90                   	nop
  800453:	c9                   	leave  
  800454:	c3                   	ret    

00800455 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800455:	55                   	push   %ebp
  800456:	89 e5                	mov    %esp,%ebp
  800458:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  80045b:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800462:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800469:	eb 42                	jmp    8004ad <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  80046b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80046e:	99                   	cltd   
  80046f:	f7 7d f0             	idivl  -0x10(%ebp)
  800472:	89 d0                	mov    %edx,%eax
  800474:	85 c0                	test   %eax,%eax
  800476:	75 10                	jne    800488 <PrintElements+0x33>
			cprintf("\n");
  800478:	83 ec 0c             	sub    $0xc,%esp
  80047b:	68 40 26 80 00       	push   $0x802640
  800480:	e8 32 07 00 00       	call   800bb7 <cprintf>
  800485:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800488:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80048b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800492:	8b 45 08             	mov    0x8(%ebp),%eax
  800495:	01 d0                	add    %edx,%eax
  800497:	8b 00                	mov    (%eax),%eax
  800499:	83 ec 08             	sub    $0x8,%esp
  80049c:	50                   	push   %eax
  80049d:	68 18 28 80 00       	push   $0x802818
  8004a2:	e8 10 07 00 00       	call   800bb7 <cprintf>
  8004a7:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8004aa:	ff 45 f4             	incl   -0xc(%ebp)
  8004ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b0:	48                   	dec    %eax
  8004b1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8004b4:	7f b5                	jg     80046b <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  8004b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004b9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c3:	01 d0                	add    %edx,%eax
  8004c5:	8b 00                	mov    (%eax),%eax
  8004c7:	83 ec 08             	sub    $0x8,%esp
  8004ca:	50                   	push   %eax
  8004cb:	68 8f 26 80 00       	push   $0x80268f
  8004d0:	e8 e2 06 00 00       	call   800bb7 <cprintf>
  8004d5:	83 c4 10             	add    $0x10,%esp

}
  8004d8:	90                   	nop
  8004d9:	c9                   	leave  
  8004da:	c3                   	ret    

008004db <MSort>:


void MSort(int* A, int p, int r)
{
  8004db:	55                   	push   %ebp
  8004dc:	89 e5                	mov    %esp,%ebp
  8004de:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004e4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004e7:	7d 54                	jge    80053d <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ef:	01 d0                	add    %edx,%eax
  8004f1:	89 c2                	mov    %eax,%edx
  8004f3:	c1 ea 1f             	shr    $0x1f,%edx
  8004f6:	01 d0                	add    %edx,%eax
  8004f8:	d1 f8                	sar    %eax
  8004fa:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004fd:	83 ec 04             	sub    $0x4,%esp
  800500:	ff 75 f4             	pushl  -0xc(%ebp)
  800503:	ff 75 0c             	pushl  0xc(%ebp)
  800506:	ff 75 08             	pushl  0x8(%ebp)
  800509:	e8 cd ff ff ff       	call   8004db <MSort>
  80050e:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  800511:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800514:	40                   	inc    %eax
  800515:	83 ec 04             	sub    $0x4,%esp
  800518:	ff 75 10             	pushl  0x10(%ebp)
  80051b:	50                   	push   %eax
  80051c:	ff 75 08             	pushl  0x8(%ebp)
  80051f:	e8 b7 ff ff ff       	call   8004db <MSort>
  800524:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  800527:	ff 75 10             	pushl  0x10(%ebp)
  80052a:	ff 75 f4             	pushl  -0xc(%ebp)
  80052d:	ff 75 0c             	pushl  0xc(%ebp)
  800530:	ff 75 08             	pushl  0x8(%ebp)
  800533:	e8 08 00 00 00       	call   800540 <Merge>
  800538:	83 c4 10             	add    $0x10,%esp
  80053b:	eb 01                	jmp    80053e <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  80053d:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  80053e:	c9                   	leave  
  80053f:	c3                   	ret    

00800540 <Merge>:

void Merge(int* A, int p, int q, int r)
{
  800540:	55                   	push   %ebp
  800541:	89 e5                	mov    %esp,%ebp
  800543:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  800546:	8b 45 10             	mov    0x10(%ebp),%eax
  800549:	2b 45 0c             	sub    0xc(%ebp),%eax
  80054c:	40                   	inc    %eax
  80054d:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  800550:	8b 45 14             	mov    0x14(%ebp),%eax
  800553:	2b 45 10             	sub    0x10(%ebp),%eax
  800556:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800559:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  800560:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  800567:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80056a:	c1 e0 02             	shl    $0x2,%eax
  80056d:	83 ec 0c             	sub    $0xc,%esp
  800570:	50                   	push   %eax
  800571:	e8 cb 13 00 00       	call   801941 <malloc>
  800576:	83 c4 10             	add    $0x10,%esp
  800579:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  80057c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80057f:	c1 e0 02             	shl    $0x2,%eax
  800582:	83 ec 0c             	sub    $0xc,%esp
  800585:	50                   	push   %eax
  800586:	e8 b6 13 00 00       	call   801941 <malloc>
  80058b:	83 c4 10             	add    $0x10,%esp
  80058e:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  800591:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800598:	eb 2f                	jmp    8005c9 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  80059a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80059d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005a4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8005a7:	01 c2                	add    %eax,%edx
  8005a9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8005ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005af:	01 c8                	add    %ecx,%eax
  8005b1:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8005b6:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c0:	01 c8                	add    %ecx,%eax
  8005c2:	8b 00                	mov    (%eax),%eax
  8005c4:	89 02                	mov    %eax,(%edx)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  8005c6:	ff 45 ec             	incl   -0x14(%ebp)
  8005c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005cc:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005cf:	7c c9                	jl     80059a <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005d1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005d8:	eb 2a                	jmp    800604 <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005da:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005e4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005e7:	01 c2                	add    %eax,%edx
  8005e9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005ef:	01 c8                	add    %ecx,%eax
  8005f1:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fb:	01 c8                	add    %ecx,%eax
  8005fd:	8b 00                	mov    (%eax),%eax
  8005ff:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  800601:	ff 45 e8             	incl   -0x18(%ebp)
  800604:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800607:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  80060a:	7c ce                	jl     8005da <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  80060c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80060f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800612:	e9 0a 01 00 00       	jmp    800721 <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  800617:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80061a:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80061d:	0f 8d 95 00 00 00    	jge    8006b8 <Merge+0x178>
  800623:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800626:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800629:	0f 8d 89 00 00 00    	jge    8006b8 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80062f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800632:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800639:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80063c:	01 d0                	add    %edx,%eax
  80063e:	8b 10                	mov    (%eax),%edx
  800640:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800643:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80064a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80064d:	01 c8                	add    %ecx,%eax
  80064f:	8b 00                	mov    (%eax),%eax
  800651:	39 c2                	cmp    %eax,%edx
  800653:	7d 33                	jge    800688 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  800655:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800658:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80065d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800664:	8b 45 08             	mov    0x8(%ebp),%eax
  800667:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80066a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80066d:	8d 50 01             	lea    0x1(%eax),%edx
  800670:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800673:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80067a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80067d:	01 d0                	add    %edx,%eax
  80067f:	8b 00                	mov    (%eax),%eax
  800681:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800683:	e9 96 00 00 00       	jmp    80071e <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800688:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80068b:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800690:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800697:	8b 45 08             	mov    0x8(%ebp),%eax
  80069a:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80069d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006a0:	8d 50 01             	lea    0x1(%eax),%edx
  8006a3:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006a6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ad:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006b0:	01 d0                	add    %edx,%eax
  8006b2:	8b 00                	mov    (%eax),%eax
  8006b4:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8006b6:	eb 66                	jmp    80071e <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  8006b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006bb:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8006be:	7d 30                	jge    8006f0 <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  8006c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006c3:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006c8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d2:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006d8:	8d 50 01             	lea    0x1(%eax),%edx
  8006db:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006de:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006e5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006e8:	01 d0                	add    %edx,%eax
  8006ea:	8b 00                	mov    (%eax),%eax
  8006ec:	89 01                	mov    %eax,(%ecx)
  8006ee:	eb 2e                	jmp    80071e <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006f3:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006f8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800702:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800705:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800708:	8d 50 01             	lea    0x1(%eax),%edx
  80070b:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80070e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800715:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800718:	01 d0                	add    %edx,%eax
  80071a:	8b 00                	mov    (%eax),%eax
  80071c:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  80071e:	ff 45 e4             	incl   -0x1c(%ebp)
  800721:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800724:	3b 45 14             	cmp    0x14(%ebp),%eax
  800727:	0f 8e ea fe ff ff    	jle    800617 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

}
  80072d:	90                   	nop
  80072e:	c9                   	leave  
  80072f:	c3                   	ret    

00800730 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800730:	55                   	push   %ebp
  800731:	89 e5                	mov    %esp,%ebp
  800733:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800736:	8b 45 08             	mov    0x8(%ebp),%eax
  800739:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80073c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800740:	83 ec 0c             	sub    $0xc,%esp
  800743:	50                   	push   %eax
  800744:	e8 9a 18 00 00       	call   801fe3 <sys_cputc>
  800749:	83 c4 10             	add    $0x10,%esp
}
  80074c:	90                   	nop
  80074d:	c9                   	leave  
  80074e:	c3                   	ret    

0080074f <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80074f:	55                   	push   %ebp
  800750:	89 e5                	mov    %esp,%ebp
  800752:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800755:	e8 55 18 00 00       	call   801faf <sys_disable_interrupt>
	char c = ch;
  80075a:	8b 45 08             	mov    0x8(%ebp),%eax
  80075d:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800760:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800764:	83 ec 0c             	sub    $0xc,%esp
  800767:	50                   	push   %eax
  800768:	e8 76 18 00 00       	call   801fe3 <sys_cputc>
  80076d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800770:	e8 54 18 00 00       	call   801fc9 <sys_enable_interrupt>
}
  800775:	90                   	nop
  800776:	c9                   	leave  
  800777:	c3                   	ret    

00800778 <getchar>:

int
getchar(void)
{
  800778:	55                   	push   %ebp
  800779:	89 e5                	mov    %esp,%ebp
  80077b:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  80077e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800785:	eb 08                	jmp    80078f <getchar+0x17>
	{
		c = sys_cgetc();
  800787:	e8 3b 16 00 00       	call   801dc7 <sys_cgetc>
  80078c:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  80078f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800793:	74 f2                	je     800787 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  800795:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800798:	c9                   	leave  
  800799:	c3                   	ret    

0080079a <atomic_getchar>:

int
atomic_getchar(void)
{
  80079a:	55                   	push   %ebp
  80079b:	89 e5                	mov    %esp,%ebp
  80079d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8007a0:	e8 0a 18 00 00       	call   801faf <sys_disable_interrupt>
	int c=0;
  8007a5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8007ac:	eb 08                	jmp    8007b6 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8007ae:	e8 14 16 00 00       	call   801dc7 <sys_cgetc>
  8007b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8007b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8007ba:	74 f2                	je     8007ae <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8007bc:	e8 08 18 00 00       	call   801fc9 <sys_enable_interrupt>
	return c;
  8007c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8007c4:	c9                   	leave  
  8007c5:	c3                   	ret    

008007c6 <iscons>:

int iscons(int fdnum)
{
  8007c6:	55                   	push   %ebp
  8007c7:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007c9:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007ce:	5d                   	pop    %ebp
  8007cf:	c3                   	ret    

008007d0 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8007d0:	55                   	push   %ebp
  8007d1:	89 e5                	mov    %esp,%ebp
  8007d3:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007d6:	e8 39 16 00 00       	call   801e14 <sys_getenvindex>
  8007db:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007de:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007e1:	89 d0                	mov    %edx,%eax
  8007e3:	c1 e0 03             	shl    $0x3,%eax
  8007e6:	01 d0                	add    %edx,%eax
  8007e8:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8007ef:	01 c8                	add    %ecx,%eax
  8007f1:	01 c0                	add    %eax,%eax
  8007f3:	01 d0                	add    %edx,%eax
  8007f5:	01 c0                	add    %eax,%eax
  8007f7:	01 d0                	add    %edx,%eax
  8007f9:	89 c2                	mov    %eax,%edx
  8007fb:	c1 e2 05             	shl    $0x5,%edx
  8007fe:	29 c2                	sub    %eax,%edx
  800800:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800807:	89 c2                	mov    %eax,%edx
  800809:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80080f:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800814:	a1 24 30 80 00       	mov    0x803024,%eax
  800819:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80081f:	84 c0                	test   %al,%al
  800821:	74 0f                	je     800832 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800823:	a1 24 30 80 00       	mov    0x803024,%eax
  800828:	05 40 3c 01 00       	add    $0x13c40,%eax
  80082d:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800832:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800836:	7e 0a                	jle    800842 <libmain+0x72>
		binaryname = argv[0];
  800838:	8b 45 0c             	mov    0xc(%ebp),%eax
  80083b:	8b 00                	mov    (%eax),%eax
  80083d:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800842:	83 ec 08             	sub    $0x8,%esp
  800845:	ff 75 0c             	pushl  0xc(%ebp)
  800848:	ff 75 08             	pushl  0x8(%ebp)
  80084b:	e8 e8 f7 ff ff       	call   800038 <_main>
  800850:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800853:	e8 57 17 00 00       	call   801faf <sys_disable_interrupt>
	cprintf("**************************************\n");
  800858:	83 ec 0c             	sub    $0xc,%esp
  80085b:	68 38 28 80 00       	push   $0x802838
  800860:	e8 52 03 00 00       	call   800bb7 <cprintf>
  800865:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800868:	a1 24 30 80 00       	mov    0x803024,%eax
  80086d:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800873:	a1 24 30 80 00       	mov    0x803024,%eax
  800878:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80087e:	83 ec 04             	sub    $0x4,%esp
  800881:	52                   	push   %edx
  800882:	50                   	push   %eax
  800883:	68 60 28 80 00       	push   $0x802860
  800888:	e8 2a 03 00 00       	call   800bb7 <cprintf>
  80088d:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800890:	a1 24 30 80 00       	mov    0x803024,%eax
  800895:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80089b:	a1 24 30 80 00       	mov    0x803024,%eax
  8008a0:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8008a6:	83 ec 04             	sub    $0x4,%esp
  8008a9:	52                   	push   %edx
  8008aa:	50                   	push   %eax
  8008ab:	68 88 28 80 00       	push   $0x802888
  8008b0:	e8 02 03 00 00       	call   800bb7 <cprintf>
  8008b5:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8008b8:	a1 24 30 80 00       	mov    0x803024,%eax
  8008bd:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8008c3:	83 ec 08             	sub    $0x8,%esp
  8008c6:	50                   	push   %eax
  8008c7:	68 c9 28 80 00       	push   $0x8028c9
  8008cc:	e8 e6 02 00 00       	call   800bb7 <cprintf>
  8008d1:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8008d4:	83 ec 0c             	sub    $0xc,%esp
  8008d7:	68 38 28 80 00       	push   $0x802838
  8008dc:	e8 d6 02 00 00       	call   800bb7 <cprintf>
  8008e1:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8008e4:	e8 e0 16 00 00       	call   801fc9 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8008e9:	e8 19 00 00 00       	call   800907 <exit>
}
  8008ee:	90                   	nop
  8008ef:	c9                   	leave  
  8008f0:	c3                   	ret    

008008f1 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008f1:	55                   	push   %ebp
  8008f2:	89 e5                	mov    %esp,%ebp
  8008f4:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008f7:	83 ec 0c             	sub    $0xc,%esp
  8008fa:	6a 00                	push   $0x0
  8008fc:	e8 df 14 00 00       	call   801de0 <sys_env_destroy>
  800901:	83 c4 10             	add    $0x10,%esp
}
  800904:	90                   	nop
  800905:	c9                   	leave  
  800906:	c3                   	ret    

00800907 <exit>:

void
exit(void)
{
  800907:	55                   	push   %ebp
  800908:	89 e5                	mov    %esp,%ebp
  80090a:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80090d:	e8 34 15 00 00       	call   801e46 <sys_env_exit>
}
  800912:	90                   	nop
  800913:	c9                   	leave  
  800914:	c3                   	ret    

00800915 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800915:	55                   	push   %ebp
  800916:	89 e5                	mov    %esp,%ebp
  800918:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80091b:	8d 45 10             	lea    0x10(%ebp),%eax
  80091e:	83 c0 04             	add    $0x4,%eax
  800921:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800924:	a1 18 31 80 00       	mov    0x803118,%eax
  800929:	85 c0                	test   %eax,%eax
  80092b:	74 16                	je     800943 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80092d:	a1 18 31 80 00       	mov    0x803118,%eax
  800932:	83 ec 08             	sub    $0x8,%esp
  800935:	50                   	push   %eax
  800936:	68 e0 28 80 00       	push   $0x8028e0
  80093b:	e8 77 02 00 00       	call   800bb7 <cprintf>
  800940:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800943:	a1 00 30 80 00       	mov    0x803000,%eax
  800948:	ff 75 0c             	pushl  0xc(%ebp)
  80094b:	ff 75 08             	pushl  0x8(%ebp)
  80094e:	50                   	push   %eax
  80094f:	68 e5 28 80 00       	push   $0x8028e5
  800954:	e8 5e 02 00 00       	call   800bb7 <cprintf>
  800959:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80095c:	8b 45 10             	mov    0x10(%ebp),%eax
  80095f:	83 ec 08             	sub    $0x8,%esp
  800962:	ff 75 f4             	pushl  -0xc(%ebp)
  800965:	50                   	push   %eax
  800966:	e8 e1 01 00 00       	call   800b4c <vcprintf>
  80096b:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80096e:	83 ec 08             	sub    $0x8,%esp
  800971:	6a 00                	push   $0x0
  800973:	68 01 29 80 00       	push   $0x802901
  800978:	e8 cf 01 00 00       	call   800b4c <vcprintf>
  80097d:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800980:	e8 82 ff ff ff       	call   800907 <exit>

	// should not return here
	while (1) ;
  800985:	eb fe                	jmp    800985 <_panic+0x70>

00800987 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800987:	55                   	push   %ebp
  800988:	89 e5                	mov    %esp,%ebp
  80098a:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80098d:	a1 24 30 80 00       	mov    0x803024,%eax
  800992:	8b 50 74             	mov    0x74(%eax),%edx
  800995:	8b 45 0c             	mov    0xc(%ebp),%eax
  800998:	39 c2                	cmp    %eax,%edx
  80099a:	74 14                	je     8009b0 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80099c:	83 ec 04             	sub    $0x4,%esp
  80099f:	68 04 29 80 00       	push   $0x802904
  8009a4:	6a 26                	push   $0x26
  8009a6:	68 50 29 80 00       	push   $0x802950
  8009ab:	e8 65 ff ff ff       	call   800915 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8009b0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8009b7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8009be:	e9 b6 00 00 00       	jmp    800a79 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8009c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009c6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d0:	01 d0                	add    %edx,%eax
  8009d2:	8b 00                	mov    (%eax),%eax
  8009d4:	85 c0                	test   %eax,%eax
  8009d6:	75 08                	jne    8009e0 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8009d8:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8009db:	e9 96 00 00 00       	jmp    800a76 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8009e0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009e7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8009ee:	eb 5d                	jmp    800a4d <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009f0:	a1 24 30 80 00       	mov    0x803024,%eax
  8009f5:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8009fb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009fe:	c1 e2 04             	shl    $0x4,%edx
  800a01:	01 d0                	add    %edx,%eax
  800a03:	8a 40 04             	mov    0x4(%eax),%al
  800a06:	84 c0                	test   %al,%al
  800a08:	75 40                	jne    800a4a <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a0a:	a1 24 30 80 00       	mov    0x803024,%eax
  800a0f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800a15:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a18:	c1 e2 04             	shl    $0x4,%edx
  800a1b:	01 d0                	add    %edx,%eax
  800a1d:	8b 00                	mov    (%eax),%eax
  800a1f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800a22:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a25:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800a2a:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800a2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a2f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a36:	8b 45 08             	mov    0x8(%ebp),%eax
  800a39:	01 c8                	add    %ecx,%eax
  800a3b:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a3d:	39 c2                	cmp    %eax,%edx
  800a3f:	75 09                	jne    800a4a <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800a41:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a48:	eb 12                	jmp    800a5c <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a4a:	ff 45 e8             	incl   -0x18(%ebp)
  800a4d:	a1 24 30 80 00       	mov    0x803024,%eax
  800a52:	8b 50 74             	mov    0x74(%eax),%edx
  800a55:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a58:	39 c2                	cmp    %eax,%edx
  800a5a:	77 94                	ja     8009f0 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a5c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a60:	75 14                	jne    800a76 <CheckWSWithoutLastIndex+0xef>
			panic(
  800a62:	83 ec 04             	sub    $0x4,%esp
  800a65:	68 5c 29 80 00       	push   $0x80295c
  800a6a:	6a 3a                	push   $0x3a
  800a6c:	68 50 29 80 00       	push   $0x802950
  800a71:	e8 9f fe ff ff       	call   800915 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a76:	ff 45 f0             	incl   -0x10(%ebp)
  800a79:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a7c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a7f:	0f 8c 3e ff ff ff    	jl     8009c3 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a85:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a8c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a93:	eb 20                	jmp    800ab5 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a95:	a1 24 30 80 00       	mov    0x803024,%eax
  800a9a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800aa0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800aa3:	c1 e2 04             	shl    $0x4,%edx
  800aa6:	01 d0                	add    %edx,%eax
  800aa8:	8a 40 04             	mov    0x4(%eax),%al
  800aab:	3c 01                	cmp    $0x1,%al
  800aad:	75 03                	jne    800ab2 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800aaf:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ab2:	ff 45 e0             	incl   -0x20(%ebp)
  800ab5:	a1 24 30 80 00       	mov    0x803024,%eax
  800aba:	8b 50 74             	mov    0x74(%eax),%edx
  800abd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ac0:	39 c2                	cmp    %eax,%edx
  800ac2:	77 d1                	ja     800a95 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800ac4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ac7:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800aca:	74 14                	je     800ae0 <CheckWSWithoutLastIndex+0x159>
		panic(
  800acc:	83 ec 04             	sub    $0x4,%esp
  800acf:	68 b0 29 80 00       	push   $0x8029b0
  800ad4:	6a 44                	push   $0x44
  800ad6:	68 50 29 80 00       	push   $0x802950
  800adb:	e8 35 fe ff ff       	call   800915 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800ae0:	90                   	nop
  800ae1:	c9                   	leave  
  800ae2:	c3                   	ret    

00800ae3 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800ae3:	55                   	push   %ebp
  800ae4:	89 e5                	mov    %esp,%ebp
  800ae6:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800ae9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aec:	8b 00                	mov    (%eax),%eax
  800aee:	8d 48 01             	lea    0x1(%eax),%ecx
  800af1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800af4:	89 0a                	mov    %ecx,(%edx)
  800af6:	8b 55 08             	mov    0x8(%ebp),%edx
  800af9:	88 d1                	mov    %dl,%cl
  800afb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800afe:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800b02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b05:	8b 00                	mov    (%eax),%eax
  800b07:	3d ff 00 00 00       	cmp    $0xff,%eax
  800b0c:	75 2c                	jne    800b3a <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800b0e:	a0 28 30 80 00       	mov    0x803028,%al
  800b13:	0f b6 c0             	movzbl %al,%eax
  800b16:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b19:	8b 12                	mov    (%edx),%edx
  800b1b:	89 d1                	mov    %edx,%ecx
  800b1d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b20:	83 c2 08             	add    $0x8,%edx
  800b23:	83 ec 04             	sub    $0x4,%esp
  800b26:	50                   	push   %eax
  800b27:	51                   	push   %ecx
  800b28:	52                   	push   %edx
  800b29:	e8 70 12 00 00       	call   801d9e <sys_cputs>
  800b2e:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800b31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b34:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3d:	8b 40 04             	mov    0x4(%eax),%eax
  800b40:	8d 50 01             	lea    0x1(%eax),%edx
  800b43:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b46:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b49:	90                   	nop
  800b4a:	c9                   	leave  
  800b4b:	c3                   	ret    

00800b4c <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b4c:	55                   	push   %ebp
  800b4d:	89 e5                	mov    %esp,%ebp
  800b4f:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b55:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b5c:	00 00 00 
	b.cnt = 0;
  800b5f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b66:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b69:	ff 75 0c             	pushl  0xc(%ebp)
  800b6c:	ff 75 08             	pushl  0x8(%ebp)
  800b6f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b75:	50                   	push   %eax
  800b76:	68 e3 0a 80 00       	push   $0x800ae3
  800b7b:	e8 11 02 00 00       	call   800d91 <vprintfmt>
  800b80:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b83:	a0 28 30 80 00       	mov    0x803028,%al
  800b88:	0f b6 c0             	movzbl %al,%eax
  800b8b:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b91:	83 ec 04             	sub    $0x4,%esp
  800b94:	50                   	push   %eax
  800b95:	52                   	push   %edx
  800b96:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b9c:	83 c0 08             	add    $0x8,%eax
  800b9f:	50                   	push   %eax
  800ba0:	e8 f9 11 00 00       	call   801d9e <sys_cputs>
  800ba5:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800ba8:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800baf:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800bb5:	c9                   	leave  
  800bb6:	c3                   	ret    

00800bb7 <cprintf>:

int cprintf(const char *fmt, ...) {
  800bb7:	55                   	push   %ebp
  800bb8:	89 e5                	mov    %esp,%ebp
  800bba:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800bbd:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800bc4:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bc7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bca:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcd:	83 ec 08             	sub    $0x8,%esp
  800bd0:	ff 75 f4             	pushl  -0xc(%ebp)
  800bd3:	50                   	push   %eax
  800bd4:	e8 73 ff ff ff       	call   800b4c <vcprintf>
  800bd9:	83 c4 10             	add    $0x10,%esp
  800bdc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800bdf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800be2:	c9                   	leave  
  800be3:	c3                   	ret    

00800be4 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800be4:	55                   	push   %ebp
  800be5:	89 e5                	mov    %esp,%ebp
  800be7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bea:	e8 c0 13 00 00       	call   801faf <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800bef:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bf2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bf5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf8:	83 ec 08             	sub    $0x8,%esp
  800bfb:	ff 75 f4             	pushl  -0xc(%ebp)
  800bfe:	50                   	push   %eax
  800bff:	e8 48 ff ff ff       	call   800b4c <vcprintf>
  800c04:	83 c4 10             	add    $0x10,%esp
  800c07:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800c0a:	e8 ba 13 00 00       	call   801fc9 <sys_enable_interrupt>
	return cnt;
  800c0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c12:	c9                   	leave  
  800c13:	c3                   	ret    

00800c14 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800c14:	55                   	push   %ebp
  800c15:	89 e5                	mov    %esp,%ebp
  800c17:	53                   	push   %ebx
  800c18:	83 ec 14             	sub    $0x14,%esp
  800c1b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c21:	8b 45 14             	mov    0x14(%ebp),%eax
  800c24:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800c27:	8b 45 18             	mov    0x18(%ebp),%eax
  800c2a:	ba 00 00 00 00       	mov    $0x0,%edx
  800c2f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c32:	77 55                	ja     800c89 <printnum+0x75>
  800c34:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c37:	72 05                	jb     800c3e <printnum+0x2a>
  800c39:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c3c:	77 4b                	ja     800c89 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c3e:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c41:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c44:	8b 45 18             	mov    0x18(%ebp),%eax
  800c47:	ba 00 00 00 00       	mov    $0x0,%edx
  800c4c:	52                   	push   %edx
  800c4d:	50                   	push   %eax
  800c4e:	ff 75 f4             	pushl  -0xc(%ebp)
  800c51:	ff 75 f0             	pushl  -0x10(%ebp)
  800c54:	e8 77 17 00 00       	call   8023d0 <__udivdi3>
  800c59:	83 c4 10             	add    $0x10,%esp
  800c5c:	83 ec 04             	sub    $0x4,%esp
  800c5f:	ff 75 20             	pushl  0x20(%ebp)
  800c62:	53                   	push   %ebx
  800c63:	ff 75 18             	pushl  0x18(%ebp)
  800c66:	52                   	push   %edx
  800c67:	50                   	push   %eax
  800c68:	ff 75 0c             	pushl  0xc(%ebp)
  800c6b:	ff 75 08             	pushl  0x8(%ebp)
  800c6e:	e8 a1 ff ff ff       	call   800c14 <printnum>
  800c73:	83 c4 20             	add    $0x20,%esp
  800c76:	eb 1a                	jmp    800c92 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c78:	83 ec 08             	sub    $0x8,%esp
  800c7b:	ff 75 0c             	pushl  0xc(%ebp)
  800c7e:	ff 75 20             	pushl  0x20(%ebp)
  800c81:	8b 45 08             	mov    0x8(%ebp),%eax
  800c84:	ff d0                	call   *%eax
  800c86:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c89:	ff 4d 1c             	decl   0x1c(%ebp)
  800c8c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c90:	7f e6                	jg     800c78 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c92:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c95:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c9d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ca0:	53                   	push   %ebx
  800ca1:	51                   	push   %ecx
  800ca2:	52                   	push   %edx
  800ca3:	50                   	push   %eax
  800ca4:	e8 37 18 00 00       	call   8024e0 <__umoddi3>
  800ca9:	83 c4 10             	add    $0x10,%esp
  800cac:	05 14 2c 80 00       	add    $0x802c14,%eax
  800cb1:	8a 00                	mov    (%eax),%al
  800cb3:	0f be c0             	movsbl %al,%eax
  800cb6:	83 ec 08             	sub    $0x8,%esp
  800cb9:	ff 75 0c             	pushl  0xc(%ebp)
  800cbc:	50                   	push   %eax
  800cbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc0:	ff d0                	call   *%eax
  800cc2:	83 c4 10             	add    $0x10,%esp
}
  800cc5:	90                   	nop
  800cc6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800cc9:	c9                   	leave  
  800cca:	c3                   	ret    

00800ccb <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ccb:	55                   	push   %ebp
  800ccc:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cce:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cd2:	7e 1c                	jle    800cf0 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd7:	8b 00                	mov    (%eax),%eax
  800cd9:	8d 50 08             	lea    0x8(%eax),%edx
  800cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdf:	89 10                	mov    %edx,(%eax)
  800ce1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce4:	8b 00                	mov    (%eax),%eax
  800ce6:	83 e8 08             	sub    $0x8,%eax
  800ce9:	8b 50 04             	mov    0x4(%eax),%edx
  800cec:	8b 00                	mov    (%eax),%eax
  800cee:	eb 40                	jmp    800d30 <getuint+0x65>
	else if (lflag)
  800cf0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cf4:	74 1e                	je     800d14 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf9:	8b 00                	mov    (%eax),%eax
  800cfb:	8d 50 04             	lea    0x4(%eax),%edx
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	89 10                	mov    %edx,(%eax)
  800d03:	8b 45 08             	mov    0x8(%ebp),%eax
  800d06:	8b 00                	mov    (%eax),%eax
  800d08:	83 e8 04             	sub    $0x4,%eax
  800d0b:	8b 00                	mov    (%eax),%eax
  800d0d:	ba 00 00 00 00       	mov    $0x0,%edx
  800d12:	eb 1c                	jmp    800d30 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800d14:	8b 45 08             	mov    0x8(%ebp),%eax
  800d17:	8b 00                	mov    (%eax),%eax
  800d19:	8d 50 04             	lea    0x4(%eax),%edx
  800d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1f:	89 10                	mov    %edx,(%eax)
  800d21:	8b 45 08             	mov    0x8(%ebp),%eax
  800d24:	8b 00                	mov    (%eax),%eax
  800d26:	83 e8 04             	sub    $0x4,%eax
  800d29:	8b 00                	mov    (%eax),%eax
  800d2b:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800d30:	5d                   	pop    %ebp
  800d31:	c3                   	ret    

00800d32 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800d32:	55                   	push   %ebp
  800d33:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d35:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d39:	7e 1c                	jle    800d57 <getint+0x25>
		return va_arg(*ap, long long);
  800d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3e:	8b 00                	mov    (%eax),%eax
  800d40:	8d 50 08             	lea    0x8(%eax),%edx
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	89 10                	mov    %edx,(%eax)
  800d48:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4b:	8b 00                	mov    (%eax),%eax
  800d4d:	83 e8 08             	sub    $0x8,%eax
  800d50:	8b 50 04             	mov    0x4(%eax),%edx
  800d53:	8b 00                	mov    (%eax),%eax
  800d55:	eb 38                	jmp    800d8f <getint+0x5d>
	else if (lflag)
  800d57:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d5b:	74 1a                	je     800d77 <getint+0x45>
		return va_arg(*ap, long);
  800d5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d60:	8b 00                	mov    (%eax),%eax
  800d62:	8d 50 04             	lea    0x4(%eax),%edx
  800d65:	8b 45 08             	mov    0x8(%ebp),%eax
  800d68:	89 10                	mov    %edx,(%eax)
  800d6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6d:	8b 00                	mov    (%eax),%eax
  800d6f:	83 e8 04             	sub    $0x4,%eax
  800d72:	8b 00                	mov    (%eax),%eax
  800d74:	99                   	cltd   
  800d75:	eb 18                	jmp    800d8f <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d77:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7a:	8b 00                	mov    (%eax),%eax
  800d7c:	8d 50 04             	lea    0x4(%eax),%edx
  800d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d82:	89 10                	mov    %edx,(%eax)
  800d84:	8b 45 08             	mov    0x8(%ebp),%eax
  800d87:	8b 00                	mov    (%eax),%eax
  800d89:	83 e8 04             	sub    $0x4,%eax
  800d8c:	8b 00                	mov    (%eax),%eax
  800d8e:	99                   	cltd   
}
  800d8f:	5d                   	pop    %ebp
  800d90:	c3                   	ret    

00800d91 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d91:	55                   	push   %ebp
  800d92:	89 e5                	mov    %esp,%ebp
  800d94:	56                   	push   %esi
  800d95:	53                   	push   %ebx
  800d96:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d99:	eb 17                	jmp    800db2 <vprintfmt+0x21>
			if (ch == '\0')
  800d9b:	85 db                	test   %ebx,%ebx
  800d9d:	0f 84 af 03 00 00    	je     801152 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800da3:	83 ec 08             	sub    $0x8,%esp
  800da6:	ff 75 0c             	pushl  0xc(%ebp)
  800da9:	53                   	push   %ebx
  800daa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dad:	ff d0                	call   *%eax
  800daf:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800db2:	8b 45 10             	mov    0x10(%ebp),%eax
  800db5:	8d 50 01             	lea    0x1(%eax),%edx
  800db8:	89 55 10             	mov    %edx,0x10(%ebp)
  800dbb:	8a 00                	mov    (%eax),%al
  800dbd:	0f b6 d8             	movzbl %al,%ebx
  800dc0:	83 fb 25             	cmp    $0x25,%ebx
  800dc3:	75 d6                	jne    800d9b <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800dc5:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800dc9:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800dd0:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800dd7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800dde:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800de5:	8b 45 10             	mov    0x10(%ebp),%eax
  800de8:	8d 50 01             	lea    0x1(%eax),%edx
  800deb:	89 55 10             	mov    %edx,0x10(%ebp)
  800dee:	8a 00                	mov    (%eax),%al
  800df0:	0f b6 d8             	movzbl %al,%ebx
  800df3:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800df6:	83 f8 55             	cmp    $0x55,%eax
  800df9:	0f 87 2b 03 00 00    	ja     80112a <vprintfmt+0x399>
  800dff:	8b 04 85 38 2c 80 00 	mov    0x802c38(,%eax,4),%eax
  800e06:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800e08:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800e0c:	eb d7                	jmp    800de5 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800e0e:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800e12:	eb d1                	jmp    800de5 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e14:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800e1b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e1e:	89 d0                	mov    %edx,%eax
  800e20:	c1 e0 02             	shl    $0x2,%eax
  800e23:	01 d0                	add    %edx,%eax
  800e25:	01 c0                	add    %eax,%eax
  800e27:	01 d8                	add    %ebx,%eax
  800e29:	83 e8 30             	sub    $0x30,%eax
  800e2c:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800e2f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e32:	8a 00                	mov    (%eax),%al
  800e34:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e37:	83 fb 2f             	cmp    $0x2f,%ebx
  800e3a:	7e 3e                	jle    800e7a <vprintfmt+0xe9>
  800e3c:	83 fb 39             	cmp    $0x39,%ebx
  800e3f:	7f 39                	jg     800e7a <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e41:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e44:	eb d5                	jmp    800e1b <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e46:	8b 45 14             	mov    0x14(%ebp),%eax
  800e49:	83 c0 04             	add    $0x4,%eax
  800e4c:	89 45 14             	mov    %eax,0x14(%ebp)
  800e4f:	8b 45 14             	mov    0x14(%ebp),%eax
  800e52:	83 e8 04             	sub    $0x4,%eax
  800e55:	8b 00                	mov    (%eax),%eax
  800e57:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e5a:	eb 1f                	jmp    800e7b <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e5c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e60:	79 83                	jns    800de5 <vprintfmt+0x54>
				width = 0;
  800e62:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e69:	e9 77 ff ff ff       	jmp    800de5 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e6e:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e75:	e9 6b ff ff ff       	jmp    800de5 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e7a:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e7b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e7f:	0f 89 60 ff ff ff    	jns    800de5 <vprintfmt+0x54>
				width = precision, precision = -1;
  800e85:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e88:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e8b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e92:	e9 4e ff ff ff       	jmp    800de5 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e97:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e9a:	e9 46 ff ff ff       	jmp    800de5 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e9f:	8b 45 14             	mov    0x14(%ebp),%eax
  800ea2:	83 c0 04             	add    $0x4,%eax
  800ea5:	89 45 14             	mov    %eax,0x14(%ebp)
  800ea8:	8b 45 14             	mov    0x14(%ebp),%eax
  800eab:	83 e8 04             	sub    $0x4,%eax
  800eae:	8b 00                	mov    (%eax),%eax
  800eb0:	83 ec 08             	sub    $0x8,%esp
  800eb3:	ff 75 0c             	pushl  0xc(%ebp)
  800eb6:	50                   	push   %eax
  800eb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eba:	ff d0                	call   *%eax
  800ebc:	83 c4 10             	add    $0x10,%esp
			break;
  800ebf:	e9 89 02 00 00       	jmp    80114d <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800ec4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ec7:	83 c0 04             	add    $0x4,%eax
  800eca:	89 45 14             	mov    %eax,0x14(%ebp)
  800ecd:	8b 45 14             	mov    0x14(%ebp),%eax
  800ed0:	83 e8 04             	sub    $0x4,%eax
  800ed3:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ed5:	85 db                	test   %ebx,%ebx
  800ed7:	79 02                	jns    800edb <vprintfmt+0x14a>
				err = -err;
  800ed9:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800edb:	83 fb 64             	cmp    $0x64,%ebx
  800ede:	7f 0b                	jg     800eeb <vprintfmt+0x15a>
  800ee0:	8b 34 9d 80 2a 80 00 	mov    0x802a80(,%ebx,4),%esi
  800ee7:	85 f6                	test   %esi,%esi
  800ee9:	75 19                	jne    800f04 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800eeb:	53                   	push   %ebx
  800eec:	68 25 2c 80 00       	push   $0x802c25
  800ef1:	ff 75 0c             	pushl  0xc(%ebp)
  800ef4:	ff 75 08             	pushl  0x8(%ebp)
  800ef7:	e8 5e 02 00 00       	call   80115a <printfmt>
  800efc:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800eff:	e9 49 02 00 00       	jmp    80114d <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800f04:	56                   	push   %esi
  800f05:	68 2e 2c 80 00       	push   $0x802c2e
  800f0a:	ff 75 0c             	pushl  0xc(%ebp)
  800f0d:	ff 75 08             	pushl  0x8(%ebp)
  800f10:	e8 45 02 00 00       	call   80115a <printfmt>
  800f15:	83 c4 10             	add    $0x10,%esp
			break;
  800f18:	e9 30 02 00 00       	jmp    80114d <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800f1d:	8b 45 14             	mov    0x14(%ebp),%eax
  800f20:	83 c0 04             	add    $0x4,%eax
  800f23:	89 45 14             	mov    %eax,0x14(%ebp)
  800f26:	8b 45 14             	mov    0x14(%ebp),%eax
  800f29:	83 e8 04             	sub    $0x4,%eax
  800f2c:	8b 30                	mov    (%eax),%esi
  800f2e:	85 f6                	test   %esi,%esi
  800f30:	75 05                	jne    800f37 <vprintfmt+0x1a6>
				p = "(null)";
  800f32:	be 31 2c 80 00       	mov    $0x802c31,%esi
			if (width > 0 && padc != '-')
  800f37:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f3b:	7e 6d                	jle    800faa <vprintfmt+0x219>
  800f3d:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f41:	74 67                	je     800faa <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f43:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f46:	83 ec 08             	sub    $0x8,%esp
  800f49:	50                   	push   %eax
  800f4a:	56                   	push   %esi
  800f4b:	e8 0c 03 00 00       	call   80125c <strnlen>
  800f50:	83 c4 10             	add    $0x10,%esp
  800f53:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f56:	eb 16                	jmp    800f6e <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f58:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f5c:	83 ec 08             	sub    $0x8,%esp
  800f5f:	ff 75 0c             	pushl  0xc(%ebp)
  800f62:	50                   	push   %eax
  800f63:	8b 45 08             	mov    0x8(%ebp),%eax
  800f66:	ff d0                	call   *%eax
  800f68:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f6b:	ff 4d e4             	decl   -0x1c(%ebp)
  800f6e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f72:	7f e4                	jg     800f58 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f74:	eb 34                	jmp    800faa <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f76:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f7a:	74 1c                	je     800f98 <vprintfmt+0x207>
  800f7c:	83 fb 1f             	cmp    $0x1f,%ebx
  800f7f:	7e 05                	jle    800f86 <vprintfmt+0x1f5>
  800f81:	83 fb 7e             	cmp    $0x7e,%ebx
  800f84:	7e 12                	jle    800f98 <vprintfmt+0x207>
					putch('?', putdat);
  800f86:	83 ec 08             	sub    $0x8,%esp
  800f89:	ff 75 0c             	pushl  0xc(%ebp)
  800f8c:	6a 3f                	push   $0x3f
  800f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f91:	ff d0                	call   *%eax
  800f93:	83 c4 10             	add    $0x10,%esp
  800f96:	eb 0f                	jmp    800fa7 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f98:	83 ec 08             	sub    $0x8,%esp
  800f9b:	ff 75 0c             	pushl  0xc(%ebp)
  800f9e:	53                   	push   %ebx
  800f9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa2:	ff d0                	call   *%eax
  800fa4:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800fa7:	ff 4d e4             	decl   -0x1c(%ebp)
  800faa:	89 f0                	mov    %esi,%eax
  800fac:	8d 70 01             	lea    0x1(%eax),%esi
  800faf:	8a 00                	mov    (%eax),%al
  800fb1:	0f be d8             	movsbl %al,%ebx
  800fb4:	85 db                	test   %ebx,%ebx
  800fb6:	74 24                	je     800fdc <vprintfmt+0x24b>
  800fb8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800fbc:	78 b8                	js     800f76 <vprintfmt+0x1e5>
  800fbe:	ff 4d e0             	decl   -0x20(%ebp)
  800fc1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800fc5:	79 af                	jns    800f76 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fc7:	eb 13                	jmp    800fdc <vprintfmt+0x24b>
				putch(' ', putdat);
  800fc9:	83 ec 08             	sub    $0x8,%esp
  800fcc:	ff 75 0c             	pushl  0xc(%ebp)
  800fcf:	6a 20                	push   $0x20
  800fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd4:	ff d0                	call   *%eax
  800fd6:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fd9:	ff 4d e4             	decl   -0x1c(%ebp)
  800fdc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fe0:	7f e7                	jg     800fc9 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fe2:	e9 66 01 00 00       	jmp    80114d <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fe7:	83 ec 08             	sub    $0x8,%esp
  800fea:	ff 75 e8             	pushl  -0x18(%ebp)
  800fed:	8d 45 14             	lea    0x14(%ebp),%eax
  800ff0:	50                   	push   %eax
  800ff1:	e8 3c fd ff ff       	call   800d32 <getint>
  800ff6:	83 c4 10             	add    $0x10,%esp
  800ff9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ffc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801002:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801005:	85 d2                	test   %edx,%edx
  801007:	79 23                	jns    80102c <vprintfmt+0x29b>
				putch('-', putdat);
  801009:	83 ec 08             	sub    $0x8,%esp
  80100c:	ff 75 0c             	pushl  0xc(%ebp)
  80100f:	6a 2d                	push   $0x2d
  801011:	8b 45 08             	mov    0x8(%ebp),%eax
  801014:	ff d0                	call   *%eax
  801016:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801019:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80101c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80101f:	f7 d8                	neg    %eax
  801021:	83 d2 00             	adc    $0x0,%edx
  801024:	f7 da                	neg    %edx
  801026:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801029:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80102c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801033:	e9 bc 00 00 00       	jmp    8010f4 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801038:	83 ec 08             	sub    $0x8,%esp
  80103b:	ff 75 e8             	pushl  -0x18(%ebp)
  80103e:	8d 45 14             	lea    0x14(%ebp),%eax
  801041:	50                   	push   %eax
  801042:	e8 84 fc ff ff       	call   800ccb <getuint>
  801047:	83 c4 10             	add    $0x10,%esp
  80104a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80104d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801050:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801057:	e9 98 00 00 00       	jmp    8010f4 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80105c:	83 ec 08             	sub    $0x8,%esp
  80105f:	ff 75 0c             	pushl  0xc(%ebp)
  801062:	6a 58                	push   $0x58
  801064:	8b 45 08             	mov    0x8(%ebp),%eax
  801067:	ff d0                	call   *%eax
  801069:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80106c:	83 ec 08             	sub    $0x8,%esp
  80106f:	ff 75 0c             	pushl  0xc(%ebp)
  801072:	6a 58                	push   $0x58
  801074:	8b 45 08             	mov    0x8(%ebp),%eax
  801077:	ff d0                	call   *%eax
  801079:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80107c:	83 ec 08             	sub    $0x8,%esp
  80107f:	ff 75 0c             	pushl  0xc(%ebp)
  801082:	6a 58                	push   $0x58
  801084:	8b 45 08             	mov    0x8(%ebp),%eax
  801087:	ff d0                	call   *%eax
  801089:	83 c4 10             	add    $0x10,%esp
			break;
  80108c:	e9 bc 00 00 00       	jmp    80114d <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801091:	83 ec 08             	sub    $0x8,%esp
  801094:	ff 75 0c             	pushl  0xc(%ebp)
  801097:	6a 30                	push   $0x30
  801099:	8b 45 08             	mov    0x8(%ebp),%eax
  80109c:	ff d0                	call   *%eax
  80109e:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8010a1:	83 ec 08             	sub    $0x8,%esp
  8010a4:	ff 75 0c             	pushl  0xc(%ebp)
  8010a7:	6a 78                	push   $0x78
  8010a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ac:	ff d0                	call   *%eax
  8010ae:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8010b1:	8b 45 14             	mov    0x14(%ebp),%eax
  8010b4:	83 c0 04             	add    $0x4,%eax
  8010b7:	89 45 14             	mov    %eax,0x14(%ebp)
  8010ba:	8b 45 14             	mov    0x14(%ebp),%eax
  8010bd:	83 e8 04             	sub    $0x4,%eax
  8010c0:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8010c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010c5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8010cc:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8010d3:	eb 1f                	jmp    8010f4 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8010d5:	83 ec 08             	sub    $0x8,%esp
  8010d8:	ff 75 e8             	pushl  -0x18(%ebp)
  8010db:	8d 45 14             	lea    0x14(%ebp),%eax
  8010de:	50                   	push   %eax
  8010df:	e8 e7 fb ff ff       	call   800ccb <getuint>
  8010e4:	83 c4 10             	add    $0x10,%esp
  8010e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010ea:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010ed:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010f4:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010fb:	83 ec 04             	sub    $0x4,%esp
  8010fe:	52                   	push   %edx
  8010ff:	ff 75 e4             	pushl  -0x1c(%ebp)
  801102:	50                   	push   %eax
  801103:	ff 75 f4             	pushl  -0xc(%ebp)
  801106:	ff 75 f0             	pushl  -0x10(%ebp)
  801109:	ff 75 0c             	pushl  0xc(%ebp)
  80110c:	ff 75 08             	pushl  0x8(%ebp)
  80110f:	e8 00 fb ff ff       	call   800c14 <printnum>
  801114:	83 c4 20             	add    $0x20,%esp
			break;
  801117:	eb 34                	jmp    80114d <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801119:	83 ec 08             	sub    $0x8,%esp
  80111c:	ff 75 0c             	pushl  0xc(%ebp)
  80111f:	53                   	push   %ebx
  801120:	8b 45 08             	mov    0x8(%ebp),%eax
  801123:	ff d0                	call   *%eax
  801125:	83 c4 10             	add    $0x10,%esp
			break;
  801128:	eb 23                	jmp    80114d <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80112a:	83 ec 08             	sub    $0x8,%esp
  80112d:	ff 75 0c             	pushl  0xc(%ebp)
  801130:	6a 25                	push   $0x25
  801132:	8b 45 08             	mov    0x8(%ebp),%eax
  801135:	ff d0                	call   *%eax
  801137:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80113a:	ff 4d 10             	decl   0x10(%ebp)
  80113d:	eb 03                	jmp    801142 <vprintfmt+0x3b1>
  80113f:	ff 4d 10             	decl   0x10(%ebp)
  801142:	8b 45 10             	mov    0x10(%ebp),%eax
  801145:	48                   	dec    %eax
  801146:	8a 00                	mov    (%eax),%al
  801148:	3c 25                	cmp    $0x25,%al
  80114a:	75 f3                	jne    80113f <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80114c:	90                   	nop
		}
	}
  80114d:	e9 47 fc ff ff       	jmp    800d99 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801152:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801153:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801156:	5b                   	pop    %ebx
  801157:	5e                   	pop    %esi
  801158:	5d                   	pop    %ebp
  801159:	c3                   	ret    

0080115a <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80115a:	55                   	push   %ebp
  80115b:	89 e5                	mov    %esp,%ebp
  80115d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801160:	8d 45 10             	lea    0x10(%ebp),%eax
  801163:	83 c0 04             	add    $0x4,%eax
  801166:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801169:	8b 45 10             	mov    0x10(%ebp),%eax
  80116c:	ff 75 f4             	pushl  -0xc(%ebp)
  80116f:	50                   	push   %eax
  801170:	ff 75 0c             	pushl  0xc(%ebp)
  801173:	ff 75 08             	pushl  0x8(%ebp)
  801176:	e8 16 fc ff ff       	call   800d91 <vprintfmt>
  80117b:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80117e:	90                   	nop
  80117f:	c9                   	leave  
  801180:	c3                   	ret    

00801181 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801181:	55                   	push   %ebp
  801182:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801184:	8b 45 0c             	mov    0xc(%ebp),%eax
  801187:	8b 40 08             	mov    0x8(%eax),%eax
  80118a:	8d 50 01             	lea    0x1(%eax),%edx
  80118d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801190:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801193:	8b 45 0c             	mov    0xc(%ebp),%eax
  801196:	8b 10                	mov    (%eax),%edx
  801198:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119b:	8b 40 04             	mov    0x4(%eax),%eax
  80119e:	39 c2                	cmp    %eax,%edx
  8011a0:	73 12                	jae    8011b4 <sprintputch+0x33>
		*b->buf++ = ch;
  8011a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a5:	8b 00                	mov    (%eax),%eax
  8011a7:	8d 48 01             	lea    0x1(%eax),%ecx
  8011aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011ad:	89 0a                	mov    %ecx,(%edx)
  8011af:	8b 55 08             	mov    0x8(%ebp),%edx
  8011b2:	88 10                	mov    %dl,(%eax)
}
  8011b4:	90                   	nop
  8011b5:	5d                   	pop    %ebp
  8011b6:	c3                   	ret    

008011b7 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8011b7:	55                   	push   %ebp
  8011b8:	89 e5                	mov    %esp,%ebp
  8011ba:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8011bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8011c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cc:	01 d0                	add    %edx,%eax
  8011ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011d8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011dc:	74 06                	je     8011e4 <vsnprintf+0x2d>
  8011de:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011e2:	7f 07                	jg     8011eb <vsnprintf+0x34>
		return -E_INVAL;
  8011e4:	b8 03 00 00 00       	mov    $0x3,%eax
  8011e9:	eb 20                	jmp    80120b <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011eb:	ff 75 14             	pushl  0x14(%ebp)
  8011ee:	ff 75 10             	pushl  0x10(%ebp)
  8011f1:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011f4:	50                   	push   %eax
  8011f5:	68 81 11 80 00       	push   $0x801181
  8011fa:	e8 92 fb ff ff       	call   800d91 <vprintfmt>
  8011ff:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801202:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801205:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801208:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80120b:	c9                   	leave  
  80120c:	c3                   	ret    

0080120d <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80120d:	55                   	push   %ebp
  80120e:	89 e5                	mov    %esp,%ebp
  801210:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801213:	8d 45 10             	lea    0x10(%ebp),%eax
  801216:	83 c0 04             	add    $0x4,%eax
  801219:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80121c:	8b 45 10             	mov    0x10(%ebp),%eax
  80121f:	ff 75 f4             	pushl  -0xc(%ebp)
  801222:	50                   	push   %eax
  801223:	ff 75 0c             	pushl  0xc(%ebp)
  801226:	ff 75 08             	pushl  0x8(%ebp)
  801229:	e8 89 ff ff ff       	call   8011b7 <vsnprintf>
  80122e:	83 c4 10             	add    $0x10,%esp
  801231:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801234:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801237:	c9                   	leave  
  801238:	c3                   	ret    

00801239 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801239:	55                   	push   %ebp
  80123a:	89 e5                	mov    %esp,%ebp
  80123c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80123f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801246:	eb 06                	jmp    80124e <strlen+0x15>
		n++;
  801248:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80124b:	ff 45 08             	incl   0x8(%ebp)
  80124e:	8b 45 08             	mov    0x8(%ebp),%eax
  801251:	8a 00                	mov    (%eax),%al
  801253:	84 c0                	test   %al,%al
  801255:	75 f1                	jne    801248 <strlen+0xf>
		n++;
	return n;
  801257:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80125a:	c9                   	leave  
  80125b:	c3                   	ret    

0080125c <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80125c:	55                   	push   %ebp
  80125d:	89 e5                	mov    %esp,%ebp
  80125f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801262:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801269:	eb 09                	jmp    801274 <strnlen+0x18>
		n++;
  80126b:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80126e:	ff 45 08             	incl   0x8(%ebp)
  801271:	ff 4d 0c             	decl   0xc(%ebp)
  801274:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801278:	74 09                	je     801283 <strnlen+0x27>
  80127a:	8b 45 08             	mov    0x8(%ebp),%eax
  80127d:	8a 00                	mov    (%eax),%al
  80127f:	84 c0                	test   %al,%al
  801281:	75 e8                	jne    80126b <strnlen+0xf>
		n++;
	return n;
  801283:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801286:	c9                   	leave  
  801287:	c3                   	ret    

00801288 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801288:	55                   	push   %ebp
  801289:	89 e5                	mov    %esp,%ebp
  80128b:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80128e:	8b 45 08             	mov    0x8(%ebp),%eax
  801291:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801294:	90                   	nop
  801295:	8b 45 08             	mov    0x8(%ebp),%eax
  801298:	8d 50 01             	lea    0x1(%eax),%edx
  80129b:	89 55 08             	mov    %edx,0x8(%ebp)
  80129e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012a1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012a4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012a7:	8a 12                	mov    (%edx),%dl
  8012a9:	88 10                	mov    %dl,(%eax)
  8012ab:	8a 00                	mov    (%eax),%al
  8012ad:	84 c0                	test   %al,%al
  8012af:	75 e4                	jne    801295 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8012b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012b4:	c9                   	leave  
  8012b5:	c3                   	ret    

008012b6 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8012b6:	55                   	push   %ebp
  8012b7:	89 e5                	mov    %esp,%ebp
  8012b9:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012c9:	eb 1f                	jmp    8012ea <strncpy+0x34>
		*dst++ = *src;
  8012cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ce:	8d 50 01             	lea    0x1(%eax),%edx
  8012d1:	89 55 08             	mov    %edx,0x8(%ebp)
  8012d4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012d7:	8a 12                	mov    (%edx),%dl
  8012d9:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012de:	8a 00                	mov    (%eax),%al
  8012e0:	84 c0                	test   %al,%al
  8012e2:	74 03                	je     8012e7 <strncpy+0x31>
			src++;
  8012e4:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012e7:	ff 45 fc             	incl   -0x4(%ebp)
  8012ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ed:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012f0:	72 d9                	jb     8012cb <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8012f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012f5:	c9                   	leave  
  8012f6:	c3                   	ret    

008012f7 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8012f7:	55                   	push   %ebp
  8012f8:	89 e5                	mov    %esp,%ebp
  8012fa:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8012fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801300:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801303:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801307:	74 30                	je     801339 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801309:	eb 16                	jmp    801321 <strlcpy+0x2a>
			*dst++ = *src++;
  80130b:	8b 45 08             	mov    0x8(%ebp),%eax
  80130e:	8d 50 01             	lea    0x1(%eax),%edx
  801311:	89 55 08             	mov    %edx,0x8(%ebp)
  801314:	8b 55 0c             	mov    0xc(%ebp),%edx
  801317:	8d 4a 01             	lea    0x1(%edx),%ecx
  80131a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80131d:	8a 12                	mov    (%edx),%dl
  80131f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801321:	ff 4d 10             	decl   0x10(%ebp)
  801324:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801328:	74 09                	je     801333 <strlcpy+0x3c>
  80132a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80132d:	8a 00                	mov    (%eax),%al
  80132f:	84 c0                	test   %al,%al
  801331:	75 d8                	jne    80130b <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801333:	8b 45 08             	mov    0x8(%ebp),%eax
  801336:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801339:	8b 55 08             	mov    0x8(%ebp),%edx
  80133c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80133f:	29 c2                	sub    %eax,%edx
  801341:	89 d0                	mov    %edx,%eax
}
  801343:	c9                   	leave  
  801344:	c3                   	ret    

00801345 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801345:	55                   	push   %ebp
  801346:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801348:	eb 06                	jmp    801350 <strcmp+0xb>
		p++, q++;
  80134a:	ff 45 08             	incl   0x8(%ebp)
  80134d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801350:	8b 45 08             	mov    0x8(%ebp),%eax
  801353:	8a 00                	mov    (%eax),%al
  801355:	84 c0                	test   %al,%al
  801357:	74 0e                	je     801367 <strcmp+0x22>
  801359:	8b 45 08             	mov    0x8(%ebp),%eax
  80135c:	8a 10                	mov    (%eax),%dl
  80135e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801361:	8a 00                	mov    (%eax),%al
  801363:	38 c2                	cmp    %al,%dl
  801365:	74 e3                	je     80134a <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801367:	8b 45 08             	mov    0x8(%ebp),%eax
  80136a:	8a 00                	mov    (%eax),%al
  80136c:	0f b6 d0             	movzbl %al,%edx
  80136f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801372:	8a 00                	mov    (%eax),%al
  801374:	0f b6 c0             	movzbl %al,%eax
  801377:	29 c2                	sub    %eax,%edx
  801379:	89 d0                	mov    %edx,%eax
}
  80137b:	5d                   	pop    %ebp
  80137c:	c3                   	ret    

0080137d <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80137d:	55                   	push   %ebp
  80137e:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801380:	eb 09                	jmp    80138b <strncmp+0xe>
		n--, p++, q++;
  801382:	ff 4d 10             	decl   0x10(%ebp)
  801385:	ff 45 08             	incl   0x8(%ebp)
  801388:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80138b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80138f:	74 17                	je     8013a8 <strncmp+0x2b>
  801391:	8b 45 08             	mov    0x8(%ebp),%eax
  801394:	8a 00                	mov    (%eax),%al
  801396:	84 c0                	test   %al,%al
  801398:	74 0e                	je     8013a8 <strncmp+0x2b>
  80139a:	8b 45 08             	mov    0x8(%ebp),%eax
  80139d:	8a 10                	mov    (%eax),%dl
  80139f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a2:	8a 00                	mov    (%eax),%al
  8013a4:	38 c2                	cmp    %al,%dl
  8013a6:	74 da                	je     801382 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013a8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013ac:	75 07                	jne    8013b5 <strncmp+0x38>
		return 0;
  8013ae:	b8 00 00 00 00       	mov    $0x0,%eax
  8013b3:	eb 14                	jmp    8013c9 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8013b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b8:	8a 00                	mov    (%eax),%al
  8013ba:	0f b6 d0             	movzbl %al,%edx
  8013bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c0:	8a 00                	mov    (%eax),%al
  8013c2:	0f b6 c0             	movzbl %al,%eax
  8013c5:	29 c2                	sub    %eax,%edx
  8013c7:	89 d0                	mov    %edx,%eax
}
  8013c9:	5d                   	pop    %ebp
  8013ca:	c3                   	ret    

008013cb <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013cb:	55                   	push   %ebp
  8013cc:	89 e5                	mov    %esp,%ebp
  8013ce:	83 ec 04             	sub    $0x4,%esp
  8013d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013d7:	eb 12                	jmp    8013eb <strchr+0x20>
		if (*s == c)
  8013d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013dc:	8a 00                	mov    (%eax),%al
  8013de:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013e1:	75 05                	jne    8013e8 <strchr+0x1d>
			return (char *) s;
  8013e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e6:	eb 11                	jmp    8013f9 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013e8:	ff 45 08             	incl   0x8(%ebp)
  8013eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ee:	8a 00                	mov    (%eax),%al
  8013f0:	84 c0                	test   %al,%al
  8013f2:	75 e5                	jne    8013d9 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8013f4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8013f9:	c9                   	leave  
  8013fa:	c3                   	ret    

008013fb <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8013fb:	55                   	push   %ebp
  8013fc:	89 e5                	mov    %esp,%ebp
  8013fe:	83 ec 04             	sub    $0x4,%esp
  801401:	8b 45 0c             	mov    0xc(%ebp),%eax
  801404:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801407:	eb 0d                	jmp    801416 <strfind+0x1b>
		if (*s == c)
  801409:	8b 45 08             	mov    0x8(%ebp),%eax
  80140c:	8a 00                	mov    (%eax),%al
  80140e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801411:	74 0e                	je     801421 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801413:	ff 45 08             	incl   0x8(%ebp)
  801416:	8b 45 08             	mov    0x8(%ebp),%eax
  801419:	8a 00                	mov    (%eax),%al
  80141b:	84 c0                	test   %al,%al
  80141d:	75 ea                	jne    801409 <strfind+0xe>
  80141f:	eb 01                	jmp    801422 <strfind+0x27>
		if (*s == c)
			break;
  801421:	90                   	nop
	return (char *) s;
  801422:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801425:	c9                   	leave  
  801426:	c3                   	ret    

00801427 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801427:	55                   	push   %ebp
  801428:	89 e5                	mov    %esp,%ebp
  80142a:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80142d:	8b 45 08             	mov    0x8(%ebp),%eax
  801430:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801433:	8b 45 10             	mov    0x10(%ebp),%eax
  801436:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801439:	eb 0e                	jmp    801449 <memset+0x22>
		*p++ = c;
  80143b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80143e:	8d 50 01             	lea    0x1(%eax),%edx
  801441:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801444:	8b 55 0c             	mov    0xc(%ebp),%edx
  801447:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801449:	ff 4d f8             	decl   -0x8(%ebp)
  80144c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801450:	79 e9                	jns    80143b <memset+0x14>
		*p++ = c;

	return v;
  801452:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801455:	c9                   	leave  
  801456:	c3                   	ret    

00801457 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801457:	55                   	push   %ebp
  801458:	89 e5                	mov    %esp,%ebp
  80145a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80145d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801460:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801463:	8b 45 08             	mov    0x8(%ebp),%eax
  801466:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801469:	eb 16                	jmp    801481 <memcpy+0x2a>
		*d++ = *s++;
  80146b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80146e:	8d 50 01             	lea    0x1(%eax),%edx
  801471:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801474:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801477:	8d 4a 01             	lea    0x1(%edx),%ecx
  80147a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80147d:	8a 12                	mov    (%edx),%dl
  80147f:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801481:	8b 45 10             	mov    0x10(%ebp),%eax
  801484:	8d 50 ff             	lea    -0x1(%eax),%edx
  801487:	89 55 10             	mov    %edx,0x10(%ebp)
  80148a:	85 c0                	test   %eax,%eax
  80148c:	75 dd                	jne    80146b <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80148e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801491:	c9                   	leave  
  801492:	c3                   	ret    

00801493 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801493:	55                   	push   %ebp
  801494:	89 e5                	mov    %esp,%ebp
  801496:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801499:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80149f:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014a8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014ab:	73 50                	jae    8014fd <memmove+0x6a>
  8014ad:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b3:	01 d0                	add    %edx,%eax
  8014b5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014b8:	76 43                	jbe    8014fd <memmove+0x6a>
		s += n;
  8014ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8014bd:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014c0:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c3:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014c6:	eb 10                	jmp    8014d8 <memmove+0x45>
			*--d = *--s;
  8014c8:	ff 4d f8             	decl   -0x8(%ebp)
  8014cb:	ff 4d fc             	decl   -0x4(%ebp)
  8014ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014d1:	8a 10                	mov    (%eax),%dl
  8014d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014d6:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8014db:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014de:	89 55 10             	mov    %edx,0x10(%ebp)
  8014e1:	85 c0                	test   %eax,%eax
  8014e3:	75 e3                	jne    8014c8 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014e5:	eb 23                	jmp    80150a <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ea:	8d 50 01             	lea    0x1(%eax),%edx
  8014ed:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014f0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014f3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014f6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014f9:	8a 12                	mov    (%edx),%dl
  8014fb:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8014fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801500:	8d 50 ff             	lea    -0x1(%eax),%edx
  801503:	89 55 10             	mov    %edx,0x10(%ebp)
  801506:	85 c0                	test   %eax,%eax
  801508:	75 dd                	jne    8014e7 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80150a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80150d:	c9                   	leave  
  80150e:	c3                   	ret    

0080150f <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80150f:	55                   	push   %ebp
  801510:	89 e5                	mov    %esp,%ebp
  801512:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801515:	8b 45 08             	mov    0x8(%ebp),%eax
  801518:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80151b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80151e:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801521:	eb 2a                	jmp    80154d <memcmp+0x3e>
		if (*s1 != *s2)
  801523:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801526:	8a 10                	mov    (%eax),%dl
  801528:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80152b:	8a 00                	mov    (%eax),%al
  80152d:	38 c2                	cmp    %al,%dl
  80152f:	74 16                	je     801547 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801531:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801534:	8a 00                	mov    (%eax),%al
  801536:	0f b6 d0             	movzbl %al,%edx
  801539:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80153c:	8a 00                	mov    (%eax),%al
  80153e:	0f b6 c0             	movzbl %al,%eax
  801541:	29 c2                	sub    %eax,%edx
  801543:	89 d0                	mov    %edx,%eax
  801545:	eb 18                	jmp    80155f <memcmp+0x50>
		s1++, s2++;
  801547:	ff 45 fc             	incl   -0x4(%ebp)
  80154a:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80154d:	8b 45 10             	mov    0x10(%ebp),%eax
  801550:	8d 50 ff             	lea    -0x1(%eax),%edx
  801553:	89 55 10             	mov    %edx,0x10(%ebp)
  801556:	85 c0                	test   %eax,%eax
  801558:	75 c9                	jne    801523 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80155a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80155f:	c9                   	leave  
  801560:	c3                   	ret    

00801561 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801561:	55                   	push   %ebp
  801562:	89 e5                	mov    %esp,%ebp
  801564:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801567:	8b 55 08             	mov    0x8(%ebp),%edx
  80156a:	8b 45 10             	mov    0x10(%ebp),%eax
  80156d:	01 d0                	add    %edx,%eax
  80156f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801572:	eb 15                	jmp    801589 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801574:	8b 45 08             	mov    0x8(%ebp),%eax
  801577:	8a 00                	mov    (%eax),%al
  801579:	0f b6 d0             	movzbl %al,%edx
  80157c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80157f:	0f b6 c0             	movzbl %al,%eax
  801582:	39 c2                	cmp    %eax,%edx
  801584:	74 0d                	je     801593 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801586:	ff 45 08             	incl   0x8(%ebp)
  801589:	8b 45 08             	mov    0x8(%ebp),%eax
  80158c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80158f:	72 e3                	jb     801574 <memfind+0x13>
  801591:	eb 01                	jmp    801594 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801593:	90                   	nop
	return (void *) s;
  801594:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801597:	c9                   	leave  
  801598:	c3                   	ret    

00801599 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801599:	55                   	push   %ebp
  80159a:	89 e5                	mov    %esp,%ebp
  80159c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80159f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015a6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015ad:	eb 03                	jmp    8015b2 <strtol+0x19>
		s++;
  8015af:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b5:	8a 00                	mov    (%eax),%al
  8015b7:	3c 20                	cmp    $0x20,%al
  8015b9:	74 f4                	je     8015af <strtol+0x16>
  8015bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015be:	8a 00                	mov    (%eax),%al
  8015c0:	3c 09                	cmp    $0x9,%al
  8015c2:	74 eb                	je     8015af <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c7:	8a 00                	mov    (%eax),%al
  8015c9:	3c 2b                	cmp    $0x2b,%al
  8015cb:	75 05                	jne    8015d2 <strtol+0x39>
		s++;
  8015cd:	ff 45 08             	incl   0x8(%ebp)
  8015d0:	eb 13                	jmp    8015e5 <strtol+0x4c>
	else if (*s == '-')
  8015d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d5:	8a 00                	mov    (%eax),%al
  8015d7:	3c 2d                	cmp    $0x2d,%al
  8015d9:	75 0a                	jne    8015e5 <strtol+0x4c>
		s++, neg = 1;
  8015db:	ff 45 08             	incl   0x8(%ebp)
  8015de:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015e5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015e9:	74 06                	je     8015f1 <strtol+0x58>
  8015eb:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8015ef:	75 20                	jne    801611 <strtol+0x78>
  8015f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f4:	8a 00                	mov    (%eax),%al
  8015f6:	3c 30                	cmp    $0x30,%al
  8015f8:	75 17                	jne    801611 <strtol+0x78>
  8015fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fd:	40                   	inc    %eax
  8015fe:	8a 00                	mov    (%eax),%al
  801600:	3c 78                	cmp    $0x78,%al
  801602:	75 0d                	jne    801611 <strtol+0x78>
		s += 2, base = 16;
  801604:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801608:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80160f:	eb 28                	jmp    801639 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801611:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801615:	75 15                	jne    80162c <strtol+0x93>
  801617:	8b 45 08             	mov    0x8(%ebp),%eax
  80161a:	8a 00                	mov    (%eax),%al
  80161c:	3c 30                	cmp    $0x30,%al
  80161e:	75 0c                	jne    80162c <strtol+0x93>
		s++, base = 8;
  801620:	ff 45 08             	incl   0x8(%ebp)
  801623:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80162a:	eb 0d                	jmp    801639 <strtol+0xa0>
	else if (base == 0)
  80162c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801630:	75 07                	jne    801639 <strtol+0xa0>
		base = 10;
  801632:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801639:	8b 45 08             	mov    0x8(%ebp),%eax
  80163c:	8a 00                	mov    (%eax),%al
  80163e:	3c 2f                	cmp    $0x2f,%al
  801640:	7e 19                	jle    80165b <strtol+0xc2>
  801642:	8b 45 08             	mov    0x8(%ebp),%eax
  801645:	8a 00                	mov    (%eax),%al
  801647:	3c 39                	cmp    $0x39,%al
  801649:	7f 10                	jg     80165b <strtol+0xc2>
			dig = *s - '0';
  80164b:	8b 45 08             	mov    0x8(%ebp),%eax
  80164e:	8a 00                	mov    (%eax),%al
  801650:	0f be c0             	movsbl %al,%eax
  801653:	83 e8 30             	sub    $0x30,%eax
  801656:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801659:	eb 42                	jmp    80169d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80165b:	8b 45 08             	mov    0x8(%ebp),%eax
  80165e:	8a 00                	mov    (%eax),%al
  801660:	3c 60                	cmp    $0x60,%al
  801662:	7e 19                	jle    80167d <strtol+0xe4>
  801664:	8b 45 08             	mov    0x8(%ebp),%eax
  801667:	8a 00                	mov    (%eax),%al
  801669:	3c 7a                	cmp    $0x7a,%al
  80166b:	7f 10                	jg     80167d <strtol+0xe4>
			dig = *s - 'a' + 10;
  80166d:	8b 45 08             	mov    0x8(%ebp),%eax
  801670:	8a 00                	mov    (%eax),%al
  801672:	0f be c0             	movsbl %al,%eax
  801675:	83 e8 57             	sub    $0x57,%eax
  801678:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80167b:	eb 20                	jmp    80169d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80167d:	8b 45 08             	mov    0x8(%ebp),%eax
  801680:	8a 00                	mov    (%eax),%al
  801682:	3c 40                	cmp    $0x40,%al
  801684:	7e 39                	jle    8016bf <strtol+0x126>
  801686:	8b 45 08             	mov    0x8(%ebp),%eax
  801689:	8a 00                	mov    (%eax),%al
  80168b:	3c 5a                	cmp    $0x5a,%al
  80168d:	7f 30                	jg     8016bf <strtol+0x126>
			dig = *s - 'A' + 10;
  80168f:	8b 45 08             	mov    0x8(%ebp),%eax
  801692:	8a 00                	mov    (%eax),%al
  801694:	0f be c0             	movsbl %al,%eax
  801697:	83 e8 37             	sub    $0x37,%eax
  80169a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80169d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016a0:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016a3:	7d 19                	jge    8016be <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016a5:	ff 45 08             	incl   0x8(%ebp)
  8016a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ab:	0f af 45 10          	imul   0x10(%ebp),%eax
  8016af:	89 c2                	mov    %eax,%edx
  8016b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016b4:	01 d0                	add    %edx,%eax
  8016b6:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016b9:	e9 7b ff ff ff       	jmp    801639 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016be:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016bf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016c3:	74 08                	je     8016cd <strtol+0x134>
		*endptr = (char *) s;
  8016c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016c8:	8b 55 08             	mov    0x8(%ebp),%edx
  8016cb:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016cd:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016d1:	74 07                	je     8016da <strtol+0x141>
  8016d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016d6:	f7 d8                	neg    %eax
  8016d8:	eb 03                	jmp    8016dd <strtol+0x144>
  8016da:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016dd:	c9                   	leave  
  8016de:	c3                   	ret    

008016df <ltostr>:

void
ltostr(long value, char *str)
{
  8016df:	55                   	push   %ebp
  8016e0:	89 e5                	mov    %esp,%ebp
  8016e2:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8016ec:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8016f3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8016f7:	79 13                	jns    80170c <ltostr+0x2d>
	{
		neg = 1;
  8016f9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801700:	8b 45 0c             	mov    0xc(%ebp),%eax
  801703:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801706:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801709:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80170c:	8b 45 08             	mov    0x8(%ebp),%eax
  80170f:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801714:	99                   	cltd   
  801715:	f7 f9                	idiv   %ecx
  801717:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80171a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80171d:	8d 50 01             	lea    0x1(%eax),%edx
  801720:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801723:	89 c2                	mov    %eax,%edx
  801725:	8b 45 0c             	mov    0xc(%ebp),%eax
  801728:	01 d0                	add    %edx,%eax
  80172a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80172d:	83 c2 30             	add    $0x30,%edx
  801730:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801732:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801735:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80173a:	f7 e9                	imul   %ecx
  80173c:	c1 fa 02             	sar    $0x2,%edx
  80173f:	89 c8                	mov    %ecx,%eax
  801741:	c1 f8 1f             	sar    $0x1f,%eax
  801744:	29 c2                	sub    %eax,%edx
  801746:	89 d0                	mov    %edx,%eax
  801748:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80174b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80174e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801753:	f7 e9                	imul   %ecx
  801755:	c1 fa 02             	sar    $0x2,%edx
  801758:	89 c8                	mov    %ecx,%eax
  80175a:	c1 f8 1f             	sar    $0x1f,%eax
  80175d:	29 c2                	sub    %eax,%edx
  80175f:	89 d0                	mov    %edx,%eax
  801761:	c1 e0 02             	shl    $0x2,%eax
  801764:	01 d0                	add    %edx,%eax
  801766:	01 c0                	add    %eax,%eax
  801768:	29 c1                	sub    %eax,%ecx
  80176a:	89 ca                	mov    %ecx,%edx
  80176c:	85 d2                	test   %edx,%edx
  80176e:	75 9c                	jne    80170c <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801770:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801777:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80177a:	48                   	dec    %eax
  80177b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80177e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801782:	74 3d                	je     8017c1 <ltostr+0xe2>
		start = 1 ;
  801784:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80178b:	eb 34                	jmp    8017c1 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80178d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801790:	8b 45 0c             	mov    0xc(%ebp),%eax
  801793:	01 d0                	add    %edx,%eax
  801795:	8a 00                	mov    (%eax),%al
  801797:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80179a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80179d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a0:	01 c2                	add    %eax,%edx
  8017a2:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a8:	01 c8                	add    %ecx,%eax
  8017aa:	8a 00                	mov    (%eax),%al
  8017ac:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017ae:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b4:	01 c2                	add    %eax,%edx
  8017b6:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017b9:	88 02                	mov    %al,(%edx)
		start++ ;
  8017bb:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017be:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017c4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017c7:	7c c4                	jl     80178d <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017c9:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017cf:	01 d0                	add    %edx,%eax
  8017d1:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017d4:	90                   	nop
  8017d5:	c9                   	leave  
  8017d6:	c3                   	ret    

008017d7 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017d7:	55                   	push   %ebp
  8017d8:	89 e5                	mov    %esp,%ebp
  8017da:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017dd:	ff 75 08             	pushl  0x8(%ebp)
  8017e0:	e8 54 fa ff ff       	call   801239 <strlen>
  8017e5:	83 c4 04             	add    $0x4,%esp
  8017e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8017eb:	ff 75 0c             	pushl  0xc(%ebp)
  8017ee:	e8 46 fa ff ff       	call   801239 <strlen>
  8017f3:	83 c4 04             	add    $0x4,%esp
  8017f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8017f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801800:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801807:	eb 17                	jmp    801820 <strcconcat+0x49>
		final[s] = str1[s] ;
  801809:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80180c:	8b 45 10             	mov    0x10(%ebp),%eax
  80180f:	01 c2                	add    %eax,%edx
  801811:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801814:	8b 45 08             	mov    0x8(%ebp),%eax
  801817:	01 c8                	add    %ecx,%eax
  801819:	8a 00                	mov    (%eax),%al
  80181b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80181d:	ff 45 fc             	incl   -0x4(%ebp)
  801820:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801823:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801826:	7c e1                	jl     801809 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801828:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80182f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801836:	eb 1f                	jmp    801857 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801838:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80183b:	8d 50 01             	lea    0x1(%eax),%edx
  80183e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801841:	89 c2                	mov    %eax,%edx
  801843:	8b 45 10             	mov    0x10(%ebp),%eax
  801846:	01 c2                	add    %eax,%edx
  801848:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80184b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80184e:	01 c8                	add    %ecx,%eax
  801850:	8a 00                	mov    (%eax),%al
  801852:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801854:	ff 45 f8             	incl   -0x8(%ebp)
  801857:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80185a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80185d:	7c d9                	jl     801838 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80185f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801862:	8b 45 10             	mov    0x10(%ebp),%eax
  801865:	01 d0                	add    %edx,%eax
  801867:	c6 00 00             	movb   $0x0,(%eax)
}
  80186a:	90                   	nop
  80186b:	c9                   	leave  
  80186c:	c3                   	ret    

0080186d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80186d:	55                   	push   %ebp
  80186e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801870:	8b 45 14             	mov    0x14(%ebp),%eax
  801873:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801879:	8b 45 14             	mov    0x14(%ebp),%eax
  80187c:	8b 00                	mov    (%eax),%eax
  80187e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801885:	8b 45 10             	mov    0x10(%ebp),%eax
  801888:	01 d0                	add    %edx,%eax
  80188a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801890:	eb 0c                	jmp    80189e <strsplit+0x31>
			*string++ = 0;
  801892:	8b 45 08             	mov    0x8(%ebp),%eax
  801895:	8d 50 01             	lea    0x1(%eax),%edx
  801898:	89 55 08             	mov    %edx,0x8(%ebp)
  80189b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80189e:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a1:	8a 00                	mov    (%eax),%al
  8018a3:	84 c0                	test   %al,%al
  8018a5:	74 18                	je     8018bf <strsplit+0x52>
  8018a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018aa:	8a 00                	mov    (%eax),%al
  8018ac:	0f be c0             	movsbl %al,%eax
  8018af:	50                   	push   %eax
  8018b0:	ff 75 0c             	pushl  0xc(%ebp)
  8018b3:	e8 13 fb ff ff       	call   8013cb <strchr>
  8018b8:	83 c4 08             	add    $0x8,%esp
  8018bb:	85 c0                	test   %eax,%eax
  8018bd:	75 d3                	jne    801892 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8018bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c2:	8a 00                	mov    (%eax),%al
  8018c4:	84 c0                	test   %al,%al
  8018c6:	74 5a                	je     801922 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8018c8:	8b 45 14             	mov    0x14(%ebp),%eax
  8018cb:	8b 00                	mov    (%eax),%eax
  8018cd:	83 f8 0f             	cmp    $0xf,%eax
  8018d0:	75 07                	jne    8018d9 <strsplit+0x6c>
		{
			return 0;
  8018d2:	b8 00 00 00 00       	mov    $0x0,%eax
  8018d7:	eb 66                	jmp    80193f <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8018dc:	8b 00                	mov    (%eax),%eax
  8018de:	8d 48 01             	lea    0x1(%eax),%ecx
  8018e1:	8b 55 14             	mov    0x14(%ebp),%edx
  8018e4:	89 0a                	mov    %ecx,(%edx)
  8018e6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018ed:	8b 45 10             	mov    0x10(%ebp),%eax
  8018f0:	01 c2                	add    %eax,%edx
  8018f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f5:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018f7:	eb 03                	jmp    8018fc <strsplit+0x8f>
			string++;
  8018f9:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8018fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ff:	8a 00                	mov    (%eax),%al
  801901:	84 c0                	test   %al,%al
  801903:	74 8b                	je     801890 <strsplit+0x23>
  801905:	8b 45 08             	mov    0x8(%ebp),%eax
  801908:	8a 00                	mov    (%eax),%al
  80190a:	0f be c0             	movsbl %al,%eax
  80190d:	50                   	push   %eax
  80190e:	ff 75 0c             	pushl  0xc(%ebp)
  801911:	e8 b5 fa ff ff       	call   8013cb <strchr>
  801916:	83 c4 08             	add    $0x8,%esp
  801919:	85 c0                	test   %eax,%eax
  80191b:	74 dc                	je     8018f9 <strsplit+0x8c>
			string++;
	}
  80191d:	e9 6e ff ff ff       	jmp    801890 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801922:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801923:	8b 45 14             	mov    0x14(%ebp),%eax
  801926:	8b 00                	mov    (%eax),%eax
  801928:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80192f:	8b 45 10             	mov    0x10(%ebp),%eax
  801932:	01 d0                	add    %edx,%eax
  801934:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80193a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80193f:	c9                   	leave  
  801940:	c3                   	ret    

00801941 <malloc>:
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  801941:	55                   	push   %ebp
  801942:	89 e5                	mov    %esp,%ebp
  801944:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  801947:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  80194e:	76 0a                	jbe    80195a <malloc+0x19>
		return NULL;
  801950:	b8 00 00 00 00       	mov    $0x0,%eax
  801955:	e9 ad 02 00 00       	jmp    801c07 <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  80195a:	8b 45 08             	mov    0x8(%ebp),%eax
  80195d:	c1 e8 0c             	shr    $0xc,%eax
  801960:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  801963:	8b 45 08             	mov    0x8(%ebp),%eax
  801966:	25 ff 0f 00 00       	and    $0xfff,%eax
  80196b:	85 c0                	test   %eax,%eax
  80196d:	74 03                	je     801972 <malloc+0x31>
		num++;
  80196f:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  801972:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801977:	85 c0                	test   %eax,%eax
  801979:	75 71                	jne    8019ec <malloc+0xab>
		sys_allocateMem(last_addres, size);
  80197b:	a1 04 30 80 00       	mov    0x803004,%eax
  801980:	83 ec 08             	sub    $0x8,%esp
  801983:	ff 75 08             	pushl  0x8(%ebp)
  801986:	50                   	push   %eax
  801987:	e8 ba 05 00 00       	call   801f46 <sys_allocateMem>
  80198c:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  80198f:	a1 04 30 80 00       	mov    0x803004,%eax
  801994:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  801997:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80199a:	c1 e0 0c             	shl    $0xc,%eax
  80199d:	89 c2                	mov    %eax,%edx
  80199f:	a1 04 30 80 00       	mov    0x803004,%eax
  8019a4:	01 d0                	add    %edx,%eax
  8019a6:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  8019ab:	a1 30 30 80 00       	mov    0x803030,%eax
  8019b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8019b3:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  8019ba:	a1 30 30 80 00       	mov    0x803030,%eax
  8019bf:	8b 55 c8             	mov    -0x38(%ebp),%edx
  8019c2:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
		changed[sizeofarray] = 1;
  8019c9:	a1 30 30 80 00       	mov    0x803030,%eax
  8019ce:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  8019d5:	01 00 00 00 
		sizeofarray++;
  8019d9:	a1 30 30 80 00       	mov    0x803030,%eax
  8019de:	40                   	inc    %eax
  8019df:	a3 30 30 80 00       	mov    %eax,0x803030
		return (void*) return_addres;
  8019e4:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8019e7:	e9 1b 02 00 00       	jmp    801c07 <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  8019ec:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  8019f3:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  8019fa:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  801a01:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  801a08:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  801a0f:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801a16:	eb 72                	jmp    801a8a <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  801a18:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a1b:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801a22:	85 c0                	test   %eax,%eax
  801a24:	75 12                	jne    801a38 <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  801a26:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a29:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801a30:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  801a33:	ff 45 dc             	incl   -0x24(%ebp)
  801a36:	eb 4f                	jmp    801a87 <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  801a38:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a3b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801a3e:	7d 39                	jge    801a79 <malloc+0x138>
  801a40:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a43:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a46:	7c 31                	jl     801a79 <malloc+0x138>
					{
						min=count;
  801a48:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a4b:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  801a4e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a51:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801a58:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a5b:	c1 e2 0c             	shl    $0xc,%edx
  801a5e:	29 d0                	sub    %edx,%eax
  801a60:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  801a63:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a66:	2b 45 dc             	sub    -0x24(%ebp),%eax
  801a69:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  801a6c:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  801a73:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a76:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  801a79:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  801a80:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  801a87:	ff 45 d4             	incl   -0x2c(%ebp)
  801a8a:	a1 30 30 80 00       	mov    0x803030,%eax
  801a8f:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  801a92:	7c 84                	jl     801a18 <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  801a94:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  801a98:	0f 85 e3 00 00 00    	jne    801b81 <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  801a9e:	83 ec 08             	sub    $0x8,%esp
  801aa1:	ff 75 08             	pushl  0x8(%ebp)
  801aa4:	ff 75 e0             	pushl  -0x20(%ebp)
  801aa7:	e8 9a 04 00 00       	call   801f46 <sys_allocateMem>
  801aac:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  801aaf:	a1 30 30 80 00       	mov    0x803030,%eax
  801ab4:	40                   	inc    %eax
  801ab5:	a3 30 30 80 00       	mov    %eax,0x803030
				for(int i=sizeofarray-1;i>index;i--)
  801aba:	a1 30 30 80 00       	mov    0x803030,%eax
  801abf:	48                   	dec    %eax
  801ac0:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801ac3:	eb 42                	jmp    801b07 <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  801ac5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ac8:	48                   	dec    %eax
  801ac9:	8b 14 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%edx
  801ad0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ad3:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  801ada:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801add:	48                   	dec    %eax
  801ade:	8b 14 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%edx
  801ae5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ae8:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					changed[i]=changed[i-1];
  801aef:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801af2:	48                   	dec    %eax
  801af3:	8b 14 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%edx
  801afa:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801afd:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  801b04:	ff 4d d0             	decl   -0x30(%ebp)
  801b07:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b0a:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801b0d:	7f b6                	jg     801ac5 <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  801b0f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b12:	40                   	inc    %eax
  801b13:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  801b16:	8b 55 08             	mov    0x8(%ebp),%edx
  801b19:	01 ca                	add    %ecx,%edx
  801b1b:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  801b22:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b25:	8d 50 01             	lea    0x1(%eax),%edx
  801b28:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b2b:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801b32:	2b 45 f4             	sub    -0xc(%ebp),%eax
  801b35:	89 04 95 a0 80 92 00 	mov    %eax,0x9280a0(,%edx,4)
				changed[index+1]=0;
  801b3c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b3f:	40                   	inc    %eax
  801b40:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801b47:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  801b4b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b4e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b51:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  801b58:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b5b:	89 45 cc             	mov    %eax,-0x34(%ebp)
  801b5e:	eb 11                	jmp    801b71 <malloc+0x230>
				{
					changed[index] = 1;
  801b60:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b63:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801b6a:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  801b6e:	ff 45 cc             	incl   -0x34(%ebp)
  801b71:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801b74:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801b77:	7c e7                	jl     801b60 <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  801b79:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b7c:	e9 86 00 00 00       	jmp    801c07 <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  801b81:	a1 04 30 80 00       	mov    0x803004,%eax
  801b86:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801b8b:	29 c2                	sub    %eax,%edx
  801b8d:	89 d0                	mov    %edx,%eax
  801b8f:	3b 45 08             	cmp    0x8(%ebp),%eax
  801b92:	73 07                	jae    801b9b <malloc+0x25a>
						return NULL;
  801b94:	b8 00 00 00 00       	mov    $0x0,%eax
  801b99:	eb 6c                	jmp    801c07 <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801b9b:	a1 04 30 80 00       	mov    0x803004,%eax
  801ba0:	83 ec 08             	sub    $0x8,%esp
  801ba3:	ff 75 08             	pushl  0x8(%ebp)
  801ba6:	50                   	push   %eax
  801ba7:	e8 9a 03 00 00       	call   801f46 <sys_allocateMem>
  801bac:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801baf:	a1 04 30 80 00       	mov    0x803004,%eax
  801bb4:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  801bb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bba:	c1 e0 0c             	shl    $0xc,%eax
  801bbd:	89 c2                	mov    %eax,%edx
  801bbf:	a1 04 30 80 00       	mov    0x803004,%eax
  801bc4:	01 d0                	add    %edx,%eax
  801bc6:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  801bcb:	a1 30 30 80 00       	mov    0x803030,%eax
  801bd0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801bd3:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  801bda:	a1 30 30 80 00       	mov    0x803030,%eax
  801bdf:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801be2:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					changed[sizeofarray] = 1;
  801be9:	a1 30 30 80 00       	mov    0x803030,%eax
  801bee:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801bf5:	01 00 00 00 
					sizeofarray++;
  801bf9:	a1 30 30 80 00       	mov    0x803030,%eax
  801bfe:	40                   	inc    %eax
  801bff:	a3 30 30 80 00       	mov    %eax,0x803030
					return (void*) return_addres;
  801c04:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  801c07:	c9                   	leave  
  801c08:	c3                   	ret    

00801c09 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801c09:	55                   	push   %ebp
  801c0a:	89 e5                	mov    %esp,%ebp
  801c0c:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801c0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c12:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  801c15:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801c1c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801c23:	eb 30                	jmp    801c55 <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801c25:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c28:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801c2f:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801c32:	75 1e                	jne    801c52 <free+0x49>
  801c34:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c37:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801c3e:	83 f8 01             	cmp    $0x1,%eax
  801c41:	75 0f                	jne    801c52 <free+0x49>
			is_found = 1;
  801c43:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801c4a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801c50:	eb 0d                	jmp    801c5f <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801c52:	ff 45 ec             	incl   -0x14(%ebp)
  801c55:	a1 30 30 80 00       	mov    0x803030,%eax
  801c5a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801c5d:	7c c6                	jl     801c25 <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801c5f:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801c63:	75 3a                	jne    801c9f <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  801c65:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c68:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801c6f:	c1 e0 0c             	shl    $0xc,%eax
  801c72:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  801c75:	83 ec 08             	sub    $0x8,%esp
  801c78:	ff 75 e4             	pushl  -0x1c(%ebp)
  801c7b:	ff 75 e8             	pushl  -0x18(%ebp)
  801c7e:	e8 a7 02 00 00       	call   801f2a <sys_freeMem>
  801c83:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801c86:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c89:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801c90:	00 00 00 00 
		changes++;
  801c94:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801c99:	40                   	inc    %eax
  801c9a:	a3 2c 30 80 00       	mov    %eax,0x80302c
	}
	//refer to the project presentation and documentation for details
}
  801c9f:	90                   	nop
  801ca0:	c9                   	leave  
  801ca1:	c3                   	ret    

00801ca2 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801ca2:	55                   	push   %ebp
  801ca3:	89 e5                	mov    %esp,%ebp
  801ca5:	83 ec 18             	sub    $0x18,%esp
  801ca8:	8b 45 10             	mov    0x10(%ebp),%eax
  801cab:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801cae:	83 ec 04             	sub    $0x4,%esp
  801cb1:	68 90 2d 80 00       	push   $0x802d90
  801cb6:	68 b6 00 00 00       	push   $0xb6
  801cbb:	68 b3 2d 80 00       	push   $0x802db3
  801cc0:	e8 50 ec ff ff       	call   800915 <_panic>

00801cc5 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801cc5:	55                   	push   %ebp
  801cc6:	89 e5                	mov    %esp,%ebp
  801cc8:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ccb:	83 ec 04             	sub    $0x4,%esp
  801cce:	68 90 2d 80 00       	push   $0x802d90
  801cd3:	68 bb 00 00 00       	push   $0xbb
  801cd8:	68 b3 2d 80 00       	push   $0x802db3
  801cdd:	e8 33 ec ff ff       	call   800915 <_panic>

00801ce2 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801ce2:	55                   	push   %ebp
  801ce3:	89 e5                	mov    %esp,%ebp
  801ce5:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ce8:	83 ec 04             	sub    $0x4,%esp
  801ceb:	68 90 2d 80 00       	push   $0x802d90
  801cf0:	68 c0 00 00 00       	push   $0xc0
  801cf5:	68 b3 2d 80 00       	push   $0x802db3
  801cfa:	e8 16 ec ff ff       	call   800915 <_panic>

00801cff <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  801cff:	55                   	push   %ebp
  801d00:	89 e5                	mov    %esp,%ebp
  801d02:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d05:	83 ec 04             	sub    $0x4,%esp
  801d08:	68 90 2d 80 00       	push   $0x802d90
  801d0d:	68 c4 00 00 00       	push   $0xc4
  801d12:	68 b3 2d 80 00       	push   $0x802db3
  801d17:	e8 f9 eb ff ff       	call   800915 <_panic>

00801d1c <expand>:
	return 0;
}

void expand(uint32 newSize) {
  801d1c:	55                   	push   %ebp
  801d1d:	89 e5                	mov    %esp,%ebp
  801d1f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d22:	83 ec 04             	sub    $0x4,%esp
  801d25:	68 90 2d 80 00       	push   $0x802d90
  801d2a:	68 c9 00 00 00       	push   $0xc9
  801d2f:	68 b3 2d 80 00       	push   $0x802db3
  801d34:	e8 dc eb ff ff       	call   800915 <_panic>

00801d39 <shrink>:
}
void shrink(uint32 newSize) {
  801d39:	55                   	push   %ebp
  801d3a:	89 e5                	mov    %esp,%ebp
  801d3c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d3f:	83 ec 04             	sub    $0x4,%esp
  801d42:	68 90 2d 80 00       	push   $0x802d90
  801d47:	68 cc 00 00 00       	push   $0xcc
  801d4c:	68 b3 2d 80 00       	push   $0x802db3
  801d51:	e8 bf eb ff ff       	call   800915 <_panic>

00801d56 <freeHeap>:
}

void freeHeap(void* virtual_address) {
  801d56:	55                   	push   %ebp
  801d57:	89 e5                	mov    %esp,%ebp
  801d59:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d5c:	83 ec 04             	sub    $0x4,%esp
  801d5f:	68 90 2d 80 00       	push   $0x802d90
  801d64:	68 d0 00 00 00       	push   $0xd0
  801d69:	68 b3 2d 80 00       	push   $0x802db3
  801d6e:	e8 a2 eb ff ff       	call   800915 <_panic>

00801d73 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801d73:	55                   	push   %ebp
  801d74:	89 e5                	mov    %esp,%ebp
  801d76:	57                   	push   %edi
  801d77:	56                   	push   %esi
  801d78:	53                   	push   %ebx
  801d79:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801d7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d7f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d82:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d85:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d88:	8b 7d 18             	mov    0x18(%ebp),%edi
  801d8b:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801d8e:	cd 30                	int    $0x30
  801d90:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801d93:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801d96:	83 c4 10             	add    $0x10,%esp
  801d99:	5b                   	pop    %ebx
  801d9a:	5e                   	pop    %esi
  801d9b:	5f                   	pop    %edi
  801d9c:	5d                   	pop    %ebp
  801d9d:	c3                   	ret    

00801d9e <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801d9e:	55                   	push   %ebp
  801d9f:	89 e5                	mov    %esp,%ebp
  801da1:	83 ec 04             	sub    $0x4,%esp
  801da4:	8b 45 10             	mov    0x10(%ebp),%eax
  801da7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801daa:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801dae:	8b 45 08             	mov    0x8(%ebp),%eax
  801db1:	6a 00                	push   $0x0
  801db3:	6a 00                	push   $0x0
  801db5:	52                   	push   %edx
  801db6:	ff 75 0c             	pushl  0xc(%ebp)
  801db9:	50                   	push   %eax
  801dba:	6a 00                	push   $0x0
  801dbc:	e8 b2 ff ff ff       	call   801d73 <syscall>
  801dc1:	83 c4 18             	add    $0x18,%esp
}
  801dc4:	90                   	nop
  801dc5:	c9                   	leave  
  801dc6:	c3                   	ret    

00801dc7 <sys_cgetc>:

int
sys_cgetc(void)
{
  801dc7:	55                   	push   %ebp
  801dc8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 00                	push   $0x0
  801dce:	6a 00                	push   $0x0
  801dd0:	6a 00                	push   $0x0
  801dd2:	6a 00                	push   $0x0
  801dd4:	6a 01                	push   $0x1
  801dd6:	e8 98 ff ff ff       	call   801d73 <syscall>
  801ddb:	83 c4 18             	add    $0x18,%esp
}
  801dde:	c9                   	leave  
  801ddf:	c3                   	ret    

00801de0 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801de0:	55                   	push   %ebp
  801de1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801de3:	8b 45 08             	mov    0x8(%ebp),%eax
  801de6:	6a 00                	push   $0x0
  801de8:	6a 00                	push   $0x0
  801dea:	6a 00                	push   $0x0
  801dec:	6a 00                	push   $0x0
  801dee:	50                   	push   %eax
  801def:	6a 05                	push   $0x5
  801df1:	e8 7d ff ff ff       	call   801d73 <syscall>
  801df6:	83 c4 18             	add    $0x18,%esp
}
  801df9:	c9                   	leave  
  801dfa:	c3                   	ret    

00801dfb <sys_getenvid>:

int32 sys_getenvid(void)
{
  801dfb:	55                   	push   %ebp
  801dfc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801dfe:	6a 00                	push   $0x0
  801e00:	6a 00                	push   $0x0
  801e02:	6a 00                	push   $0x0
  801e04:	6a 00                	push   $0x0
  801e06:	6a 00                	push   $0x0
  801e08:	6a 02                	push   $0x2
  801e0a:	e8 64 ff ff ff       	call   801d73 <syscall>
  801e0f:	83 c4 18             	add    $0x18,%esp
}
  801e12:	c9                   	leave  
  801e13:	c3                   	ret    

00801e14 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801e14:	55                   	push   %ebp
  801e15:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801e17:	6a 00                	push   $0x0
  801e19:	6a 00                	push   $0x0
  801e1b:	6a 00                	push   $0x0
  801e1d:	6a 00                	push   $0x0
  801e1f:	6a 00                	push   $0x0
  801e21:	6a 03                	push   $0x3
  801e23:	e8 4b ff ff ff       	call   801d73 <syscall>
  801e28:	83 c4 18             	add    $0x18,%esp
}
  801e2b:	c9                   	leave  
  801e2c:	c3                   	ret    

00801e2d <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801e2d:	55                   	push   %ebp
  801e2e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	6a 00                	push   $0x0
  801e38:	6a 00                	push   $0x0
  801e3a:	6a 04                	push   $0x4
  801e3c:	e8 32 ff ff ff       	call   801d73 <syscall>
  801e41:	83 c4 18             	add    $0x18,%esp
}
  801e44:	c9                   	leave  
  801e45:	c3                   	ret    

00801e46 <sys_env_exit>:


void sys_env_exit(void)
{
  801e46:	55                   	push   %ebp
  801e47:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801e49:	6a 00                	push   $0x0
  801e4b:	6a 00                	push   $0x0
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 00                	push   $0x0
  801e53:	6a 06                	push   $0x6
  801e55:	e8 19 ff ff ff       	call   801d73 <syscall>
  801e5a:	83 c4 18             	add    $0x18,%esp
}
  801e5d:	90                   	nop
  801e5e:	c9                   	leave  
  801e5f:	c3                   	ret    

00801e60 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801e60:	55                   	push   %ebp
  801e61:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801e63:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e66:	8b 45 08             	mov    0x8(%ebp),%eax
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 00                	push   $0x0
  801e6d:	6a 00                	push   $0x0
  801e6f:	52                   	push   %edx
  801e70:	50                   	push   %eax
  801e71:	6a 07                	push   $0x7
  801e73:	e8 fb fe ff ff       	call   801d73 <syscall>
  801e78:	83 c4 18             	add    $0x18,%esp
}
  801e7b:	c9                   	leave  
  801e7c:	c3                   	ret    

00801e7d <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801e7d:	55                   	push   %ebp
  801e7e:	89 e5                	mov    %esp,%ebp
  801e80:	56                   	push   %esi
  801e81:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801e82:	8b 75 18             	mov    0x18(%ebp),%esi
  801e85:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e88:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e91:	56                   	push   %esi
  801e92:	53                   	push   %ebx
  801e93:	51                   	push   %ecx
  801e94:	52                   	push   %edx
  801e95:	50                   	push   %eax
  801e96:	6a 08                	push   $0x8
  801e98:	e8 d6 fe ff ff       	call   801d73 <syscall>
  801e9d:	83 c4 18             	add    $0x18,%esp
}
  801ea0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801ea3:	5b                   	pop    %ebx
  801ea4:	5e                   	pop    %esi
  801ea5:	5d                   	pop    %ebp
  801ea6:	c3                   	ret    

00801ea7 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801ea7:	55                   	push   %ebp
  801ea8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801eaa:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ead:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb0:	6a 00                	push   $0x0
  801eb2:	6a 00                	push   $0x0
  801eb4:	6a 00                	push   $0x0
  801eb6:	52                   	push   %edx
  801eb7:	50                   	push   %eax
  801eb8:	6a 09                	push   $0x9
  801eba:	e8 b4 fe ff ff       	call   801d73 <syscall>
  801ebf:	83 c4 18             	add    $0x18,%esp
}
  801ec2:	c9                   	leave  
  801ec3:	c3                   	ret    

00801ec4 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801ec4:	55                   	push   %ebp
  801ec5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801ec7:	6a 00                	push   $0x0
  801ec9:	6a 00                	push   $0x0
  801ecb:	6a 00                	push   $0x0
  801ecd:	ff 75 0c             	pushl  0xc(%ebp)
  801ed0:	ff 75 08             	pushl  0x8(%ebp)
  801ed3:	6a 0a                	push   $0xa
  801ed5:	e8 99 fe ff ff       	call   801d73 <syscall>
  801eda:	83 c4 18             	add    $0x18,%esp
}
  801edd:	c9                   	leave  
  801ede:	c3                   	ret    

00801edf <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801edf:	55                   	push   %ebp
  801ee0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801ee2:	6a 00                	push   $0x0
  801ee4:	6a 00                	push   $0x0
  801ee6:	6a 00                	push   $0x0
  801ee8:	6a 00                	push   $0x0
  801eea:	6a 00                	push   $0x0
  801eec:	6a 0b                	push   $0xb
  801eee:	e8 80 fe ff ff       	call   801d73 <syscall>
  801ef3:	83 c4 18             	add    $0x18,%esp
}
  801ef6:	c9                   	leave  
  801ef7:	c3                   	ret    

00801ef8 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801ef8:	55                   	push   %ebp
  801ef9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801efb:	6a 00                	push   $0x0
  801efd:	6a 00                	push   $0x0
  801eff:	6a 00                	push   $0x0
  801f01:	6a 00                	push   $0x0
  801f03:	6a 00                	push   $0x0
  801f05:	6a 0c                	push   $0xc
  801f07:	e8 67 fe ff ff       	call   801d73 <syscall>
  801f0c:	83 c4 18             	add    $0x18,%esp
}
  801f0f:	c9                   	leave  
  801f10:	c3                   	ret    

00801f11 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801f11:	55                   	push   %ebp
  801f12:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801f14:	6a 00                	push   $0x0
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 0d                	push   $0xd
  801f20:	e8 4e fe ff ff       	call   801d73 <syscall>
  801f25:	83 c4 18             	add    $0x18,%esp
}
  801f28:	c9                   	leave  
  801f29:	c3                   	ret    

00801f2a <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801f2a:	55                   	push   %ebp
  801f2b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801f2d:	6a 00                	push   $0x0
  801f2f:	6a 00                	push   $0x0
  801f31:	6a 00                	push   $0x0
  801f33:	ff 75 0c             	pushl  0xc(%ebp)
  801f36:	ff 75 08             	pushl  0x8(%ebp)
  801f39:	6a 11                	push   $0x11
  801f3b:	e8 33 fe ff ff       	call   801d73 <syscall>
  801f40:	83 c4 18             	add    $0x18,%esp
	return;
  801f43:	90                   	nop
}
  801f44:	c9                   	leave  
  801f45:	c3                   	ret    

00801f46 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801f46:	55                   	push   %ebp
  801f47:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801f49:	6a 00                	push   $0x0
  801f4b:	6a 00                	push   $0x0
  801f4d:	6a 00                	push   $0x0
  801f4f:	ff 75 0c             	pushl  0xc(%ebp)
  801f52:	ff 75 08             	pushl  0x8(%ebp)
  801f55:	6a 12                	push   $0x12
  801f57:	e8 17 fe ff ff       	call   801d73 <syscall>
  801f5c:	83 c4 18             	add    $0x18,%esp
	return ;
  801f5f:	90                   	nop
}
  801f60:	c9                   	leave  
  801f61:	c3                   	ret    

00801f62 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801f62:	55                   	push   %ebp
  801f63:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801f65:	6a 00                	push   $0x0
  801f67:	6a 00                	push   $0x0
  801f69:	6a 00                	push   $0x0
  801f6b:	6a 00                	push   $0x0
  801f6d:	6a 00                	push   $0x0
  801f6f:	6a 0e                	push   $0xe
  801f71:	e8 fd fd ff ff       	call   801d73 <syscall>
  801f76:	83 c4 18             	add    $0x18,%esp
}
  801f79:	c9                   	leave  
  801f7a:	c3                   	ret    

00801f7b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801f7b:	55                   	push   %ebp
  801f7c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801f7e:	6a 00                	push   $0x0
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	6a 00                	push   $0x0
  801f86:	ff 75 08             	pushl  0x8(%ebp)
  801f89:	6a 0f                	push   $0xf
  801f8b:	e8 e3 fd ff ff       	call   801d73 <syscall>
  801f90:	83 c4 18             	add    $0x18,%esp
}
  801f93:	c9                   	leave  
  801f94:	c3                   	ret    

00801f95 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801f95:	55                   	push   %ebp
  801f96:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 00                	push   $0x0
  801f9c:	6a 00                	push   $0x0
  801f9e:	6a 00                	push   $0x0
  801fa0:	6a 00                	push   $0x0
  801fa2:	6a 10                	push   $0x10
  801fa4:	e8 ca fd ff ff       	call   801d73 <syscall>
  801fa9:	83 c4 18             	add    $0x18,%esp
}
  801fac:	90                   	nop
  801fad:	c9                   	leave  
  801fae:	c3                   	ret    

00801faf <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801faf:	55                   	push   %ebp
  801fb0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801fb2:	6a 00                	push   $0x0
  801fb4:	6a 00                	push   $0x0
  801fb6:	6a 00                	push   $0x0
  801fb8:	6a 00                	push   $0x0
  801fba:	6a 00                	push   $0x0
  801fbc:	6a 14                	push   $0x14
  801fbe:	e8 b0 fd ff ff       	call   801d73 <syscall>
  801fc3:	83 c4 18             	add    $0x18,%esp
}
  801fc6:	90                   	nop
  801fc7:	c9                   	leave  
  801fc8:	c3                   	ret    

00801fc9 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801fc9:	55                   	push   %ebp
  801fca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801fcc:	6a 00                	push   $0x0
  801fce:	6a 00                	push   $0x0
  801fd0:	6a 00                	push   $0x0
  801fd2:	6a 00                	push   $0x0
  801fd4:	6a 00                	push   $0x0
  801fd6:	6a 15                	push   $0x15
  801fd8:	e8 96 fd ff ff       	call   801d73 <syscall>
  801fdd:	83 c4 18             	add    $0x18,%esp
}
  801fe0:	90                   	nop
  801fe1:	c9                   	leave  
  801fe2:	c3                   	ret    

00801fe3 <sys_cputc>:


void
sys_cputc(const char c)
{
  801fe3:	55                   	push   %ebp
  801fe4:	89 e5                	mov    %esp,%ebp
  801fe6:	83 ec 04             	sub    $0x4,%esp
  801fe9:	8b 45 08             	mov    0x8(%ebp),%eax
  801fec:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801fef:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ff3:	6a 00                	push   $0x0
  801ff5:	6a 00                	push   $0x0
  801ff7:	6a 00                	push   $0x0
  801ff9:	6a 00                	push   $0x0
  801ffb:	50                   	push   %eax
  801ffc:	6a 16                	push   $0x16
  801ffe:	e8 70 fd ff ff       	call   801d73 <syscall>
  802003:	83 c4 18             	add    $0x18,%esp
}
  802006:	90                   	nop
  802007:	c9                   	leave  
  802008:	c3                   	ret    

00802009 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802009:	55                   	push   %ebp
  80200a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80200c:	6a 00                	push   $0x0
  80200e:	6a 00                	push   $0x0
  802010:	6a 00                	push   $0x0
  802012:	6a 00                	push   $0x0
  802014:	6a 00                	push   $0x0
  802016:	6a 17                	push   $0x17
  802018:	e8 56 fd ff ff       	call   801d73 <syscall>
  80201d:	83 c4 18             	add    $0x18,%esp
}
  802020:	90                   	nop
  802021:	c9                   	leave  
  802022:	c3                   	ret    

00802023 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802023:	55                   	push   %ebp
  802024:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802026:	8b 45 08             	mov    0x8(%ebp),%eax
  802029:	6a 00                	push   $0x0
  80202b:	6a 00                	push   $0x0
  80202d:	6a 00                	push   $0x0
  80202f:	ff 75 0c             	pushl  0xc(%ebp)
  802032:	50                   	push   %eax
  802033:	6a 18                	push   $0x18
  802035:	e8 39 fd ff ff       	call   801d73 <syscall>
  80203a:	83 c4 18             	add    $0x18,%esp
}
  80203d:	c9                   	leave  
  80203e:	c3                   	ret    

0080203f <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80203f:	55                   	push   %ebp
  802040:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802042:	8b 55 0c             	mov    0xc(%ebp),%edx
  802045:	8b 45 08             	mov    0x8(%ebp),%eax
  802048:	6a 00                	push   $0x0
  80204a:	6a 00                	push   $0x0
  80204c:	6a 00                	push   $0x0
  80204e:	52                   	push   %edx
  80204f:	50                   	push   %eax
  802050:	6a 1b                	push   $0x1b
  802052:	e8 1c fd ff ff       	call   801d73 <syscall>
  802057:	83 c4 18             	add    $0x18,%esp
}
  80205a:	c9                   	leave  
  80205b:	c3                   	ret    

0080205c <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80205c:	55                   	push   %ebp
  80205d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80205f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802062:	8b 45 08             	mov    0x8(%ebp),%eax
  802065:	6a 00                	push   $0x0
  802067:	6a 00                	push   $0x0
  802069:	6a 00                	push   $0x0
  80206b:	52                   	push   %edx
  80206c:	50                   	push   %eax
  80206d:	6a 19                	push   $0x19
  80206f:	e8 ff fc ff ff       	call   801d73 <syscall>
  802074:	83 c4 18             	add    $0x18,%esp
}
  802077:	90                   	nop
  802078:	c9                   	leave  
  802079:	c3                   	ret    

0080207a <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80207a:	55                   	push   %ebp
  80207b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80207d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802080:	8b 45 08             	mov    0x8(%ebp),%eax
  802083:	6a 00                	push   $0x0
  802085:	6a 00                	push   $0x0
  802087:	6a 00                	push   $0x0
  802089:	52                   	push   %edx
  80208a:	50                   	push   %eax
  80208b:	6a 1a                	push   $0x1a
  80208d:	e8 e1 fc ff ff       	call   801d73 <syscall>
  802092:	83 c4 18             	add    $0x18,%esp
}
  802095:	90                   	nop
  802096:	c9                   	leave  
  802097:	c3                   	ret    

00802098 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802098:	55                   	push   %ebp
  802099:	89 e5                	mov    %esp,%ebp
  80209b:	83 ec 04             	sub    $0x4,%esp
  80209e:	8b 45 10             	mov    0x10(%ebp),%eax
  8020a1:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8020a4:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8020a7:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8020ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ae:	6a 00                	push   $0x0
  8020b0:	51                   	push   %ecx
  8020b1:	52                   	push   %edx
  8020b2:	ff 75 0c             	pushl  0xc(%ebp)
  8020b5:	50                   	push   %eax
  8020b6:	6a 1c                	push   $0x1c
  8020b8:	e8 b6 fc ff ff       	call   801d73 <syscall>
  8020bd:	83 c4 18             	add    $0x18,%esp
}
  8020c0:	c9                   	leave  
  8020c1:	c3                   	ret    

008020c2 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8020c2:	55                   	push   %ebp
  8020c3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8020c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8020cb:	6a 00                	push   $0x0
  8020cd:	6a 00                	push   $0x0
  8020cf:	6a 00                	push   $0x0
  8020d1:	52                   	push   %edx
  8020d2:	50                   	push   %eax
  8020d3:	6a 1d                	push   $0x1d
  8020d5:	e8 99 fc ff ff       	call   801d73 <syscall>
  8020da:	83 c4 18             	add    $0x18,%esp
}
  8020dd:	c9                   	leave  
  8020de:	c3                   	ret    

008020df <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8020df:	55                   	push   %ebp
  8020e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8020e2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8020eb:	6a 00                	push   $0x0
  8020ed:	6a 00                	push   $0x0
  8020ef:	51                   	push   %ecx
  8020f0:	52                   	push   %edx
  8020f1:	50                   	push   %eax
  8020f2:	6a 1e                	push   $0x1e
  8020f4:	e8 7a fc ff ff       	call   801d73 <syscall>
  8020f9:	83 c4 18             	add    $0x18,%esp
}
  8020fc:	c9                   	leave  
  8020fd:	c3                   	ret    

008020fe <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8020fe:	55                   	push   %ebp
  8020ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802101:	8b 55 0c             	mov    0xc(%ebp),%edx
  802104:	8b 45 08             	mov    0x8(%ebp),%eax
  802107:	6a 00                	push   $0x0
  802109:	6a 00                	push   $0x0
  80210b:	6a 00                	push   $0x0
  80210d:	52                   	push   %edx
  80210e:	50                   	push   %eax
  80210f:	6a 1f                	push   $0x1f
  802111:	e8 5d fc ff ff       	call   801d73 <syscall>
  802116:	83 c4 18             	add    $0x18,%esp
}
  802119:	c9                   	leave  
  80211a:	c3                   	ret    

0080211b <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80211b:	55                   	push   %ebp
  80211c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80211e:	6a 00                	push   $0x0
  802120:	6a 00                	push   $0x0
  802122:	6a 00                	push   $0x0
  802124:	6a 00                	push   $0x0
  802126:	6a 00                	push   $0x0
  802128:	6a 20                	push   $0x20
  80212a:	e8 44 fc ff ff       	call   801d73 <syscall>
  80212f:	83 c4 18             	add    $0x18,%esp
}
  802132:	c9                   	leave  
  802133:	c3                   	ret    

00802134 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802134:	55                   	push   %ebp
  802135:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802137:	8b 45 08             	mov    0x8(%ebp),%eax
  80213a:	6a 00                	push   $0x0
  80213c:	ff 75 14             	pushl  0x14(%ebp)
  80213f:	ff 75 10             	pushl  0x10(%ebp)
  802142:	ff 75 0c             	pushl  0xc(%ebp)
  802145:	50                   	push   %eax
  802146:	6a 21                	push   $0x21
  802148:	e8 26 fc ff ff       	call   801d73 <syscall>
  80214d:	83 c4 18             	add    $0x18,%esp
}
  802150:	c9                   	leave  
  802151:	c3                   	ret    

00802152 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802152:	55                   	push   %ebp
  802153:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802155:	8b 45 08             	mov    0x8(%ebp),%eax
  802158:	6a 00                	push   $0x0
  80215a:	6a 00                	push   $0x0
  80215c:	6a 00                	push   $0x0
  80215e:	6a 00                	push   $0x0
  802160:	50                   	push   %eax
  802161:	6a 22                	push   $0x22
  802163:	e8 0b fc ff ff       	call   801d73 <syscall>
  802168:	83 c4 18             	add    $0x18,%esp
}
  80216b:	90                   	nop
  80216c:	c9                   	leave  
  80216d:	c3                   	ret    

0080216e <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80216e:	55                   	push   %ebp
  80216f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802171:	8b 45 08             	mov    0x8(%ebp),%eax
  802174:	6a 00                	push   $0x0
  802176:	6a 00                	push   $0x0
  802178:	6a 00                	push   $0x0
  80217a:	6a 00                	push   $0x0
  80217c:	50                   	push   %eax
  80217d:	6a 23                	push   $0x23
  80217f:	e8 ef fb ff ff       	call   801d73 <syscall>
  802184:	83 c4 18             	add    $0x18,%esp
}
  802187:	90                   	nop
  802188:	c9                   	leave  
  802189:	c3                   	ret    

0080218a <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80218a:	55                   	push   %ebp
  80218b:	89 e5                	mov    %esp,%ebp
  80218d:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802190:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802193:	8d 50 04             	lea    0x4(%eax),%edx
  802196:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802199:	6a 00                	push   $0x0
  80219b:	6a 00                	push   $0x0
  80219d:	6a 00                	push   $0x0
  80219f:	52                   	push   %edx
  8021a0:	50                   	push   %eax
  8021a1:	6a 24                	push   $0x24
  8021a3:	e8 cb fb ff ff       	call   801d73 <syscall>
  8021a8:	83 c4 18             	add    $0x18,%esp
	return result;
  8021ab:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8021ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021b1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8021b4:	89 01                	mov    %eax,(%ecx)
  8021b6:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8021b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8021bc:	c9                   	leave  
  8021bd:	c2 04 00             	ret    $0x4

008021c0 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8021c0:	55                   	push   %ebp
  8021c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8021c3:	6a 00                	push   $0x0
  8021c5:	6a 00                	push   $0x0
  8021c7:	ff 75 10             	pushl  0x10(%ebp)
  8021ca:	ff 75 0c             	pushl  0xc(%ebp)
  8021cd:	ff 75 08             	pushl  0x8(%ebp)
  8021d0:	6a 13                	push   $0x13
  8021d2:	e8 9c fb ff ff       	call   801d73 <syscall>
  8021d7:	83 c4 18             	add    $0x18,%esp
	return ;
  8021da:	90                   	nop
}
  8021db:	c9                   	leave  
  8021dc:	c3                   	ret    

008021dd <sys_rcr2>:
uint32 sys_rcr2()
{
  8021dd:	55                   	push   %ebp
  8021de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8021e0:	6a 00                	push   $0x0
  8021e2:	6a 00                	push   $0x0
  8021e4:	6a 00                	push   $0x0
  8021e6:	6a 00                	push   $0x0
  8021e8:	6a 00                	push   $0x0
  8021ea:	6a 25                	push   $0x25
  8021ec:	e8 82 fb ff ff       	call   801d73 <syscall>
  8021f1:	83 c4 18             	add    $0x18,%esp
}
  8021f4:	c9                   	leave  
  8021f5:	c3                   	ret    

008021f6 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8021f6:	55                   	push   %ebp
  8021f7:	89 e5                	mov    %esp,%ebp
  8021f9:	83 ec 04             	sub    $0x4,%esp
  8021fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ff:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802202:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802206:	6a 00                	push   $0x0
  802208:	6a 00                	push   $0x0
  80220a:	6a 00                	push   $0x0
  80220c:	6a 00                	push   $0x0
  80220e:	50                   	push   %eax
  80220f:	6a 26                	push   $0x26
  802211:	e8 5d fb ff ff       	call   801d73 <syscall>
  802216:	83 c4 18             	add    $0x18,%esp
	return ;
  802219:	90                   	nop
}
  80221a:	c9                   	leave  
  80221b:	c3                   	ret    

0080221c <rsttst>:
void rsttst()
{
  80221c:	55                   	push   %ebp
  80221d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80221f:	6a 00                	push   $0x0
  802221:	6a 00                	push   $0x0
  802223:	6a 00                	push   $0x0
  802225:	6a 00                	push   $0x0
  802227:	6a 00                	push   $0x0
  802229:	6a 28                	push   $0x28
  80222b:	e8 43 fb ff ff       	call   801d73 <syscall>
  802230:	83 c4 18             	add    $0x18,%esp
	return ;
  802233:	90                   	nop
}
  802234:	c9                   	leave  
  802235:	c3                   	ret    

00802236 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802236:	55                   	push   %ebp
  802237:	89 e5                	mov    %esp,%ebp
  802239:	83 ec 04             	sub    $0x4,%esp
  80223c:	8b 45 14             	mov    0x14(%ebp),%eax
  80223f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802242:	8b 55 18             	mov    0x18(%ebp),%edx
  802245:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802249:	52                   	push   %edx
  80224a:	50                   	push   %eax
  80224b:	ff 75 10             	pushl  0x10(%ebp)
  80224e:	ff 75 0c             	pushl  0xc(%ebp)
  802251:	ff 75 08             	pushl  0x8(%ebp)
  802254:	6a 27                	push   $0x27
  802256:	e8 18 fb ff ff       	call   801d73 <syscall>
  80225b:	83 c4 18             	add    $0x18,%esp
	return ;
  80225e:	90                   	nop
}
  80225f:	c9                   	leave  
  802260:	c3                   	ret    

00802261 <chktst>:
void chktst(uint32 n)
{
  802261:	55                   	push   %ebp
  802262:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802264:	6a 00                	push   $0x0
  802266:	6a 00                	push   $0x0
  802268:	6a 00                	push   $0x0
  80226a:	6a 00                	push   $0x0
  80226c:	ff 75 08             	pushl  0x8(%ebp)
  80226f:	6a 29                	push   $0x29
  802271:	e8 fd fa ff ff       	call   801d73 <syscall>
  802276:	83 c4 18             	add    $0x18,%esp
	return ;
  802279:	90                   	nop
}
  80227a:	c9                   	leave  
  80227b:	c3                   	ret    

0080227c <inctst>:

void inctst()
{
  80227c:	55                   	push   %ebp
  80227d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80227f:	6a 00                	push   $0x0
  802281:	6a 00                	push   $0x0
  802283:	6a 00                	push   $0x0
  802285:	6a 00                	push   $0x0
  802287:	6a 00                	push   $0x0
  802289:	6a 2a                	push   $0x2a
  80228b:	e8 e3 fa ff ff       	call   801d73 <syscall>
  802290:	83 c4 18             	add    $0x18,%esp
	return ;
  802293:	90                   	nop
}
  802294:	c9                   	leave  
  802295:	c3                   	ret    

00802296 <gettst>:
uint32 gettst()
{
  802296:	55                   	push   %ebp
  802297:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802299:	6a 00                	push   $0x0
  80229b:	6a 00                	push   $0x0
  80229d:	6a 00                	push   $0x0
  80229f:	6a 00                	push   $0x0
  8022a1:	6a 00                	push   $0x0
  8022a3:	6a 2b                	push   $0x2b
  8022a5:	e8 c9 fa ff ff       	call   801d73 <syscall>
  8022aa:	83 c4 18             	add    $0x18,%esp
}
  8022ad:	c9                   	leave  
  8022ae:	c3                   	ret    

008022af <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8022af:	55                   	push   %ebp
  8022b0:	89 e5                	mov    %esp,%ebp
  8022b2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022b5:	6a 00                	push   $0x0
  8022b7:	6a 00                	push   $0x0
  8022b9:	6a 00                	push   $0x0
  8022bb:	6a 00                	push   $0x0
  8022bd:	6a 00                	push   $0x0
  8022bf:	6a 2c                	push   $0x2c
  8022c1:	e8 ad fa ff ff       	call   801d73 <syscall>
  8022c6:	83 c4 18             	add    $0x18,%esp
  8022c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8022cc:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8022d0:	75 07                	jne    8022d9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8022d2:	b8 01 00 00 00       	mov    $0x1,%eax
  8022d7:	eb 05                	jmp    8022de <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8022d9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022de:	c9                   	leave  
  8022df:	c3                   	ret    

008022e0 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8022e0:	55                   	push   %ebp
  8022e1:	89 e5                	mov    %esp,%ebp
  8022e3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022e6:	6a 00                	push   $0x0
  8022e8:	6a 00                	push   $0x0
  8022ea:	6a 00                	push   $0x0
  8022ec:	6a 00                	push   $0x0
  8022ee:	6a 00                	push   $0x0
  8022f0:	6a 2c                	push   $0x2c
  8022f2:	e8 7c fa ff ff       	call   801d73 <syscall>
  8022f7:	83 c4 18             	add    $0x18,%esp
  8022fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8022fd:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802301:	75 07                	jne    80230a <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802303:	b8 01 00 00 00       	mov    $0x1,%eax
  802308:	eb 05                	jmp    80230f <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80230a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80230f:	c9                   	leave  
  802310:	c3                   	ret    

00802311 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802311:	55                   	push   %ebp
  802312:	89 e5                	mov    %esp,%ebp
  802314:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802317:	6a 00                	push   $0x0
  802319:	6a 00                	push   $0x0
  80231b:	6a 00                	push   $0x0
  80231d:	6a 00                	push   $0x0
  80231f:	6a 00                	push   $0x0
  802321:	6a 2c                	push   $0x2c
  802323:	e8 4b fa ff ff       	call   801d73 <syscall>
  802328:	83 c4 18             	add    $0x18,%esp
  80232b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80232e:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802332:	75 07                	jne    80233b <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802334:	b8 01 00 00 00       	mov    $0x1,%eax
  802339:	eb 05                	jmp    802340 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80233b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802340:	c9                   	leave  
  802341:	c3                   	ret    

00802342 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802342:	55                   	push   %ebp
  802343:	89 e5                	mov    %esp,%ebp
  802345:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802348:	6a 00                	push   $0x0
  80234a:	6a 00                	push   $0x0
  80234c:	6a 00                	push   $0x0
  80234e:	6a 00                	push   $0x0
  802350:	6a 00                	push   $0x0
  802352:	6a 2c                	push   $0x2c
  802354:	e8 1a fa ff ff       	call   801d73 <syscall>
  802359:	83 c4 18             	add    $0x18,%esp
  80235c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80235f:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802363:	75 07                	jne    80236c <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802365:	b8 01 00 00 00       	mov    $0x1,%eax
  80236a:	eb 05                	jmp    802371 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80236c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802371:	c9                   	leave  
  802372:	c3                   	ret    

00802373 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802373:	55                   	push   %ebp
  802374:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802376:	6a 00                	push   $0x0
  802378:	6a 00                	push   $0x0
  80237a:	6a 00                	push   $0x0
  80237c:	6a 00                	push   $0x0
  80237e:	ff 75 08             	pushl  0x8(%ebp)
  802381:	6a 2d                	push   $0x2d
  802383:	e8 eb f9 ff ff       	call   801d73 <syscall>
  802388:	83 c4 18             	add    $0x18,%esp
	return ;
  80238b:	90                   	nop
}
  80238c:	c9                   	leave  
  80238d:	c3                   	ret    

0080238e <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80238e:	55                   	push   %ebp
  80238f:	89 e5                	mov    %esp,%ebp
  802391:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802392:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802395:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802398:	8b 55 0c             	mov    0xc(%ebp),%edx
  80239b:	8b 45 08             	mov    0x8(%ebp),%eax
  80239e:	6a 00                	push   $0x0
  8023a0:	53                   	push   %ebx
  8023a1:	51                   	push   %ecx
  8023a2:	52                   	push   %edx
  8023a3:	50                   	push   %eax
  8023a4:	6a 2e                	push   $0x2e
  8023a6:	e8 c8 f9 ff ff       	call   801d73 <syscall>
  8023ab:	83 c4 18             	add    $0x18,%esp
}
  8023ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8023b1:	c9                   	leave  
  8023b2:	c3                   	ret    

008023b3 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8023b3:	55                   	push   %ebp
  8023b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8023b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8023bc:	6a 00                	push   $0x0
  8023be:	6a 00                	push   $0x0
  8023c0:	6a 00                	push   $0x0
  8023c2:	52                   	push   %edx
  8023c3:	50                   	push   %eax
  8023c4:	6a 2f                	push   $0x2f
  8023c6:	e8 a8 f9 ff ff       	call   801d73 <syscall>
  8023cb:	83 c4 18             	add    $0x18,%esp
}
  8023ce:	c9                   	leave  
  8023cf:	c3                   	ret    

008023d0 <__udivdi3>:
  8023d0:	55                   	push   %ebp
  8023d1:	57                   	push   %edi
  8023d2:	56                   	push   %esi
  8023d3:	53                   	push   %ebx
  8023d4:	83 ec 1c             	sub    $0x1c,%esp
  8023d7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8023db:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8023df:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023e3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8023e7:	89 ca                	mov    %ecx,%edx
  8023e9:	89 f8                	mov    %edi,%eax
  8023eb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8023ef:	85 f6                	test   %esi,%esi
  8023f1:	75 2d                	jne    802420 <__udivdi3+0x50>
  8023f3:	39 cf                	cmp    %ecx,%edi
  8023f5:	77 65                	ja     80245c <__udivdi3+0x8c>
  8023f7:	89 fd                	mov    %edi,%ebp
  8023f9:	85 ff                	test   %edi,%edi
  8023fb:	75 0b                	jne    802408 <__udivdi3+0x38>
  8023fd:	b8 01 00 00 00       	mov    $0x1,%eax
  802402:	31 d2                	xor    %edx,%edx
  802404:	f7 f7                	div    %edi
  802406:	89 c5                	mov    %eax,%ebp
  802408:	31 d2                	xor    %edx,%edx
  80240a:	89 c8                	mov    %ecx,%eax
  80240c:	f7 f5                	div    %ebp
  80240e:	89 c1                	mov    %eax,%ecx
  802410:	89 d8                	mov    %ebx,%eax
  802412:	f7 f5                	div    %ebp
  802414:	89 cf                	mov    %ecx,%edi
  802416:	89 fa                	mov    %edi,%edx
  802418:	83 c4 1c             	add    $0x1c,%esp
  80241b:	5b                   	pop    %ebx
  80241c:	5e                   	pop    %esi
  80241d:	5f                   	pop    %edi
  80241e:	5d                   	pop    %ebp
  80241f:	c3                   	ret    
  802420:	39 ce                	cmp    %ecx,%esi
  802422:	77 28                	ja     80244c <__udivdi3+0x7c>
  802424:	0f bd fe             	bsr    %esi,%edi
  802427:	83 f7 1f             	xor    $0x1f,%edi
  80242a:	75 40                	jne    80246c <__udivdi3+0x9c>
  80242c:	39 ce                	cmp    %ecx,%esi
  80242e:	72 0a                	jb     80243a <__udivdi3+0x6a>
  802430:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802434:	0f 87 9e 00 00 00    	ja     8024d8 <__udivdi3+0x108>
  80243a:	b8 01 00 00 00       	mov    $0x1,%eax
  80243f:	89 fa                	mov    %edi,%edx
  802441:	83 c4 1c             	add    $0x1c,%esp
  802444:	5b                   	pop    %ebx
  802445:	5e                   	pop    %esi
  802446:	5f                   	pop    %edi
  802447:	5d                   	pop    %ebp
  802448:	c3                   	ret    
  802449:	8d 76 00             	lea    0x0(%esi),%esi
  80244c:	31 ff                	xor    %edi,%edi
  80244e:	31 c0                	xor    %eax,%eax
  802450:	89 fa                	mov    %edi,%edx
  802452:	83 c4 1c             	add    $0x1c,%esp
  802455:	5b                   	pop    %ebx
  802456:	5e                   	pop    %esi
  802457:	5f                   	pop    %edi
  802458:	5d                   	pop    %ebp
  802459:	c3                   	ret    
  80245a:	66 90                	xchg   %ax,%ax
  80245c:	89 d8                	mov    %ebx,%eax
  80245e:	f7 f7                	div    %edi
  802460:	31 ff                	xor    %edi,%edi
  802462:	89 fa                	mov    %edi,%edx
  802464:	83 c4 1c             	add    $0x1c,%esp
  802467:	5b                   	pop    %ebx
  802468:	5e                   	pop    %esi
  802469:	5f                   	pop    %edi
  80246a:	5d                   	pop    %ebp
  80246b:	c3                   	ret    
  80246c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802471:	89 eb                	mov    %ebp,%ebx
  802473:	29 fb                	sub    %edi,%ebx
  802475:	89 f9                	mov    %edi,%ecx
  802477:	d3 e6                	shl    %cl,%esi
  802479:	89 c5                	mov    %eax,%ebp
  80247b:	88 d9                	mov    %bl,%cl
  80247d:	d3 ed                	shr    %cl,%ebp
  80247f:	89 e9                	mov    %ebp,%ecx
  802481:	09 f1                	or     %esi,%ecx
  802483:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802487:	89 f9                	mov    %edi,%ecx
  802489:	d3 e0                	shl    %cl,%eax
  80248b:	89 c5                	mov    %eax,%ebp
  80248d:	89 d6                	mov    %edx,%esi
  80248f:	88 d9                	mov    %bl,%cl
  802491:	d3 ee                	shr    %cl,%esi
  802493:	89 f9                	mov    %edi,%ecx
  802495:	d3 e2                	shl    %cl,%edx
  802497:	8b 44 24 08          	mov    0x8(%esp),%eax
  80249b:	88 d9                	mov    %bl,%cl
  80249d:	d3 e8                	shr    %cl,%eax
  80249f:	09 c2                	or     %eax,%edx
  8024a1:	89 d0                	mov    %edx,%eax
  8024a3:	89 f2                	mov    %esi,%edx
  8024a5:	f7 74 24 0c          	divl   0xc(%esp)
  8024a9:	89 d6                	mov    %edx,%esi
  8024ab:	89 c3                	mov    %eax,%ebx
  8024ad:	f7 e5                	mul    %ebp
  8024af:	39 d6                	cmp    %edx,%esi
  8024b1:	72 19                	jb     8024cc <__udivdi3+0xfc>
  8024b3:	74 0b                	je     8024c0 <__udivdi3+0xf0>
  8024b5:	89 d8                	mov    %ebx,%eax
  8024b7:	31 ff                	xor    %edi,%edi
  8024b9:	e9 58 ff ff ff       	jmp    802416 <__udivdi3+0x46>
  8024be:	66 90                	xchg   %ax,%ax
  8024c0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8024c4:	89 f9                	mov    %edi,%ecx
  8024c6:	d3 e2                	shl    %cl,%edx
  8024c8:	39 c2                	cmp    %eax,%edx
  8024ca:	73 e9                	jae    8024b5 <__udivdi3+0xe5>
  8024cc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8024cf:	31 ff                	xor    %edi,%edi
  8024d1:	e9 40 ff ff ff       	jmp    802416 <__udivdi3+0x46>
  8024d6:	66 90                	xchg   %ax,%ax
  8024d8:	31 c0                	xor    %eax,%eax
  8024da:	e9 37 ff ff ff       	jmp    802416 <__udivdi3+0x46>
  8024df:	90                   	nop

008024e0 <__umoddi3>:
  8024e0:	55                   	push   %ebp
  8024e1:	57                   	push   %edi
  8024e2:	56                   	push   %esi
  8024e3:	53                   	push   %ebx
  8024e4:	83 ec 1c             	sub    $0x1c,%esp
  8024e7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8024eb:	8b 74 24 34          	mov    0x34(%esp),%esi
  8024ef:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8024f3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8024f7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8024fb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8024ff:	89 f3                	mov    %esi,%ebx
  802501:	89 fa                	mov    %edi,%edx
  802503:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802507:	89 34 24             	mov    %esi,(%esp)
  80250a:	85 c0                	test   %eax,%eax
  80250c:	75 1a                	jne    802528 <__umoddi3+0x48>
  80250e:	39 f7                	cmp    %esi,%edi
  802510:	0f 86 a2 00 00 00    	jbe    8025b8 <__umoddi3+0xd8>
  802516:	89 c8                	mov    %ecx,%eax
  802518:	89 f2                	mov    %esi,%edx
  80251a:	f7 f7                	div    %edi
  80251c:	89 d0                	mov    %edx,%eax
  80251e:	31 d2                	xor    %edx,%edx
  802520:	83 c4 1c             	add    $0x1c,%esp
  802523:	5b                   	pop    %ebx
  802524:	5e                   	pop    %esi
  802525:	5f                   	pop    %edi
  802526:	5d                   	pop    %ebp
  802527:	c3                   	ret    
  802528:	39 f0                	cmp    %esi,%eax
  80252a:	0f 87 ac 00 00 00    	ja     8025dc <__umoddi3+0xfc>
  802530:	0f bd e8             	bsr    %eax,%ebp
  802533:	83 f5 1f             	xor    $0x1f,%ebp
  802536:	0f 84 ac 00 00 00    	je     8025e8 <__umoddi3+0x108>
  80253c:	bf 20 00 00 00       	mov    $0x20,%edi
  802541:	29 ef                	sub    %ebp,%edi
  802543:	89 fe                	mov    %edi,%esi
  802545:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802549:	89 e9                	mov    %ebp,%ecx
  80254b:	d3 e0                	shl    %cl,%eax
  80254d:	89 d7                	mov    %edx,%edi
  80254f:	89 f1                	mov    %esi,%ecx
  802551:	d3 ef                	shr    %cl,%edi
  802553:	09 c7                	or     %eax,%edi
  802555:	89 e9                	mov    %ebp,%ecx
  802557:	d3 e2                	shl    %cl,%edx
  802559:	89 14 24             	mov    %edx,(%esp)
  80255c:	89 d8                	mov    %ebx,%eax
  80255e:	d3 e0                	shl    %cl,%eax
  802560:	89 c2                	mov    %eax,%edx
  802562:	8b 44 24 08          	mov    0x8(%esp),%eax
  802566:	d3 e0                	shl    %cl,%eax
  802568:	89 44 24 04          	mov    %eax,0x4(%esp)
  80256c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802570:	89 f1                	mov    %esi,%ecx
  802572:	d3 e8                	shr    %cl,%eax
  802574:	09 d0                	or     %edx,%eax
  802576:	d3 eb                	shr    %cl,%ebx
  802578:	89 da                	mov    %ebx,%edx
  80257a:	f7 f7                	div    %edi
  80257c:	89 d3                	mov    %edx,%ebx
  80257e:	f7 24 24             	mull   (%esp)
  802581:	89 c6                	mov    %eax,%esi
  802583:	89 d1                	mov    %edx,%ecx
  802585:	39 d3                	cmp    %edx,%ebx
  802587:	0f 82 87 00 00 00    	jb     802614 <__umoddi3+0x134>
  80258d:	0f 84 91 00 00 00    	je     802624 <__umoddi3+0x144>
  802593:	8b 54 24 04          	mov    0x4(%esp),%edx
  802597:	29 f2                	sub    %esi,%edx
  802599:	19 cb                	sbb    %ecx,%ebx
  80259b:	89 d8                	mov    %ebx,%eax
  80259d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8025a1:	d3 e0                	shl    %cl,%eax
  8025a3:	89 e9                	mov    %ebp,%ecx
  8025a5:	d3 ea                	shr    %cl,%edx
  8025a7:	09 d0                	or     %edx,%eax
  8025a9:	89 e9                	mov    %ebp,%ecx
  8025ab:	d3 eb                	shr    %cl,%ebx
  8025ad:	89 da                	mov    %ebx,%edx
  8025af:	83 c4 1c             	add    $0x1c,%esp
  8025b2:	5b                   	pop    %ebx
  8025b3:	5e                   	pop    %esi
  8025b4:	5f                   	pop    %edi
  8025b5:	5d                   	pop    %ebp
  8025b6:	c3                   	ret    
  8025b7:	90                   	nop
  8025b8:	89 fd                	mov    %edi,%ebp
  8025ba:	85 ff                	test   %edi,%edi
  8025bc:	75 0b                	jne    8025c9 <__umoddi3+0xe9>
  8025be:	b8 01 00 00 00       	mov    $0x1,%eax
  8025c3:	31 d2                	xor    %edx,%edx
  8025c5:	f7 f7                	div    %edi
  8025c7:	89 c5                	mov    %eax,%ebp
  8025c9:	89 f0                	mov    %esi,%eax
  8025cb:	31 d2                	xor    %edx,%edx
  8025cd:	f7 f5                	div    %ebp
  8025cf:	89 c8                	mov    %ecx,%eax
  8025d1:	f7 f5                	div    %ebp
  8025d3:	89 d0                	mov    %edx,%eax
  8025d5:	e9 44 ff ff ff       	jmp    80251e <__umoddi3+0x3e>
  8025da:	66 90                	xchg   %ax,%ax
  8025dc:	89 c8                	mov    %ecx,%eax
  8025de:	89 f2                	mov    %esi,%edx
  8025e0:	83 c4 1c             	add    $0x1c,%esp
  8025e3:	5b                   	pop    %ebx
  8025e4:	5e                   	pop    %esi
  8025e5:	5f                   	pop    %edi
  8025e6:	5d                   	pop    %ebp
  8025e7:	c3                   	ret    
  8025e8:	3b 04 24             	cmp    (%esp),%eax
  8025eb:	72 06                	jb     8025f3 <__umoddi3+0x113>
  8025ed:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8025f1:	77 0f                	ja     802602 <__umoddi3+0x122>
  8025f3:	89 f2                	mov    %esi,%edx
  8025f5:	29 f9                	sub    %edi,%ecx
  8025f7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8025fb:	89 14 24             	mov    %edx,(%esp)
  8025fe:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802602:	8b 44 24 04          	mov    0x4(%esp),%eax
  802606:	8b 14 24             	mov    (%esp),%edx
  802609:	83 c4 1c             	add    $0x1c,%esp
  80260c:	5b                   	pop    %ebx
  80260d:	5e                   	pop    %esi
  80260e:	5f                   	pop    %edi
  80260f:	5d                   	pop    %ebp
  802610:	c3                   	ret    
  802611:	8d 76 00             	lea    0x0(%esi),%esi
  802614:	2b 04 24             	sub    (%esp),%eax
  802617:	19 fa                	sbb    %edi,%edx
  802619:	89 d1                	mov    %edx,%ecx
  80261b:	89 c6                	mov    %eax,%esi
  80261d:	e9 71 ff ff ff       	jmp    802593 <__umoddi3+0xb3>
  802622:	66 90                	xchg   %ax,%ax
  802624:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802628:	72 ea                	jb     802614 <__umoddi3+0x134>
  80262a:	89 d9                	mov    %ebx,%ecx
  80262c:	e9 62 ff ff ff       	jmp    802593 <__umoddi3+0xb3>
