
obj/user/quicksort_noleakage:     file format elf32-i386


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
  800031:	e8 0e 06 00 00       	call   800644 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void QuickSort(int *Elements, int NumOfElements);
void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex);
uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	char Line[255] ;
	char Chose ;
	do
	{
		//2012: lock the interrupt
		sys_disable_interrupt();
  800041:	e8 2c 1f 00 00       	call   801f72 <sys_disable_interrupt>
		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 00 26 80 00       	push   $0x802600
  80004e:	e8 d8 09 00 00       	call   800a2b <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 02 26 80 00       	push   $0x802602
  80005e:	e8 c8 09 00 00       	call   800a2b <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!   QUICK SORT    !!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 1b 26 80 00       	push   $0x80261b
  80006e:	e8 b8 09 00 00       	call   800a2b <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 02 26 80 00       	push   $0x802602
  80007e:	e8 a8 09 00 00       	call   800a2b <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 00 26 80 00       	push   $0x802600
  80008e:	e8 98 09 00 00       	call   800a2b <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp

		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 34 26 80 00       	push   $0x802634
  8000a5:	e8 03 10 00 00       	call   8010ad <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 53 15 00 00       	call   801613 <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 e6 18 00 00       	call   8019bb <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 54 26 80 00       	push   $0x802654
  8000e3:	e8 43 09 00 00       	call   800a2b <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 76 26 80 00       	push   $0x802676
  8000f3:	e8 33 09 00 00       	call   800a2b <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 84 26 80 00       	push   $0x802684
  800103:	e8 23 09 00 00       	call   800a2b <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 93 26 80 00       	push   $0x802693
  800113:	e8 13 09 00 00       	call   800a2b <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 a3 26 80 00       	push   $0x8026a3
  800123:	e8 03 09 00 00       	call   800a2b <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 bc 04 00 00       	call   8005ec <getchar>
  800130:	88 45 ef             	mov    %al,-0x11(%ebp)
			cputchar(Chose);
  800133:	0f be 45 ef          	movsbl -0x11(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 64 04 00 00       	call   8005a4 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 57 04 00 00       	call   8005a4 <cputchar>
  80014d:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800150:	80 7d ef 61          	cmpb   $0x61,-0x11(%ebp)
  800154:	74 0c                	je     800162 <_main+0x12a>
  800156:	80 7d ef 62          	cmpb   $0x62,-0x11(%ebp)
  80015a:	74 06                	je     800162 <_main+0x12a>
  80015c:	80 7d ef 63          	cmpb   $0x63,-0x11(%ebp)
  800160:	75 b9                	jne    80011b <_main+0xe3>

		//2012: lock the interrupt
		sys_enable_interrupt();
  800162:	e8 25 1e 00 00       	call   801f8c <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  800167:	0f be 45 ef          	movsbl -0x11(%ebp),%eax
  80016b:	83 f8 62             	cmp    $0x62,%eax
  80016e:	74 1d                	je     80018d <_main+0x155>
  800170:	83 f8 63             	cmp    $0x63,%eax
  800173:	74 2b                	je     8001a0 <_main+0x168>
  800175:	83 f8 61             	cmp    $0x61,%eax
  800178:	75 39                	jne    8001b3 <_main+0x17b>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80017a:	83 ec 08             	sub    $0x8,%esp
  80017d:	ff 75 f4             	pushl  -0xc(%ebp)
  800180:	ff 75 f0             	pushl  -0x10(%ebp)
  800183:	e8 e4 02 00 00       	call   80046c <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f4             	pushl  -0xc(%ebp)
  800193:	ff 75 f0             	pushl  -0x10(%ebp)
  800196:	e8 02 03 00 00       	call   80049d <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f4             	pushl  -0xc(%ebp)
  8001a6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a9:	e8 24 03 00 00       	call   8004d2 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f4             	pushl  -0xc(%ebp)
  8001b9:	ff 75 f0             	pushl  -0x10(%ebp)
  8001bc:	e8 11 03 00 00       	call   8004d2 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001c4:	83 ec 08             	sub    $0x8,%esp
  8001c7:	ff 75 f4             	pushl  -0xc(%ebp)
  8001ca:	ff 75 f0             	pushl  -0x10(%ebp)
  8001cd:	e8 df 00 00 00       	call   8002b1 <QuickSort>
  8001d2:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001d5:	e8 98 1d 00 00       	call   801f72 <sys_disable_interrupt>
			cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001da:	83 ec 0c             	sub    $0xc,%esp
  8001dd:	68 ac 26 80 00       	push   $0x8026ac
  8001e2:	e8 44 08 00 00       	call   800a2b <cprintf>
  8001e7:	83 c4 10             	add    $0x10,%esp
		//		PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ea:	e8 9d 1d 00 00       	call   801f8c <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001ef:	83 ec 08             	sub    $0x8,%esp
  8001f2:	ff 75 f4             	pushl  -0xc(%ebp)
  8001f5:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f8:	e8 c5 01 00 00       	call   8003c2 <CheckSorted>
  8001fd:	83 c4 10             	add    $0x10,%esp
  800200:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800203:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800207:	75 14                	jne    80021d <_main+0x1e5>
  800209:	83 ec 04             	sub    $0x4,%esp
  80020c:	68 e0 26 80 00       	push   $0x8026e0
  800211:	6a 49                	push   $0x49
  800213:	68 02 27 80 00       	push   $0x802702
  800218:	e8 6c 05 00 00       	call   800789 <_panic>
		else
		{
			sys_disable_interrupt();
  80021d:	e8 50 1d 00 00       	call   801f72 <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800222:	83 ec 0c             	sub    $0xc,%esp
  800225:	68 20 27 80 00       	push   $0x802720
  80022a:	e8 fc 07 00 00       	call   800a2b <cprintf>
  80022f:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800232:	83 ec 0c             	sub    $0xc,%esp
  800235:	68 54 27 80 00       	push   $0x802754
  80023a:	e8 ec 07 00 00       	call   800a2b <cprintf>
  80023f:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800242:	83 ec 0c             	sub    $0xc,%esp
  800245:	68 88 27 80 00       	push   $0x802788
  80024a:	e8 dc 07 00 00       	call   800a2b <cprintf>
  80024f:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800252:	e8 35 1d 00 00       	call   801f8c <sys_enable_interrupt>

		}

		free(Elements) ;
  800257:	83 ec 0c             	sub    $0xc,%esp
  80025a:	ff 75 f0             	pushl  -0x10(%ebp)
  80025d:	e8 69 19 00 00       	call   801bcb <free>
  800262:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  800265:	e8 08 1d 00 00       	call   801f72 <sys_disable_interrupt>

		cprintf("Do you want to repeat (y/n): ") ;
  80026a:	83 ec 0c             	sub    $0xc,%esp
  80026d:	68 ba 27 80 00       	push   $0x8027ba
  800272:	e8 b4 07 00 00       	call   800a2b <cprintf>
  800277:	83 c4 10             	add    $0x10,%esp
		Chose = getchar() ;
  80027a:	e8 6d 03 00 00       	call   8005ec <getchar>
  80027f:	88 45 ef             	mov    %al,-0x11(%ebp)
		cputchar(Chose);
  800282:	0f be 45 ef          	movsbl -0x11(%ebp),%eax
  800286:	83 ec 0c             	sub    $0xc,%esp
  800289:	50                   	push   %eax
  80028a:	e8 15 03 00 00       	call   8005a4 <cputchar>
  80028f:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  800292:	83 ec 0c             	sub    $0xc,%esp
  800295:	6a 0a                	push   $0xa
  800297:	e8 08 03 00 00       	call   8005a4 <cputchar>
  80029c:	83 c4 10             	add    $0x10,%esp

		sys_enable_interrupt();
  80029f:	e8 e8 1c 00 00       	call   801f8c <sys_enable_interrupt>

	} while (Chose == 'y');
  8002a4:	80 7d ef 79          	cmpb   $0x79,-0x11(%ebp)
  8002a8:	0f 84 93 fd ff ff    	je     800041 <_main+0x9>

}
  8002ae:	90                   	nop
  8002af:	c9                   	leave  
  8002b0:	c3                   	ret    

008002b1 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8002b1:	55                   	push   %ebp
  8002b2:	89 e5                	mov    %esp,%ebp
  8002b4:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8002b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002ba:	48                   	dec    %eax
  8002bb:	50                   	push   %eax
  8002bc:	6a 00                	push   $0x0
  8002be:	ff 75 0c             	pushl  0xc(%ebp)
  8002c1:	ff 75 08             	pushl  0x8(%ebp)
  8002c4:	e8 06 00 00 00       	call   8002cf <QSort>
  8002c9:	83 c4 10             	add    $0x10,%esp
}
  8002cc:	90                   	nop
  8002cd:	c9                   	leave  
  8002ce:	c3                   	ret    

008002cf <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8002cf:	55                   	push   %ebp
  8002d0:	89 e5                	mov    %esp,%ebp
  8002d2:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8002d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8002d8:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002db:	0f 8d de 00 00 00    	jge    8003bf <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8002e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e4:	40                   	inc    %eax
  8002e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8002eb:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002ee:	e9 80 00 00 00       	jmp    800373 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8002f3:	ff 45 f4             	incl   -0xc(%ebp)
  8002f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002f9:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002fc:	7f 2b                	jg     800329 <QSort+0x5a>
  8002fe:	8b 45 10             	mov    0x10(%ebp),%eax
  800301:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800308:	8b 45 08             	mov    0x8(%ebp),%eax
  80030b:	01 d0                	add    %edx,%eax
  80030d:	8b 10                	mov    (%eax),%edx
  80030f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800312:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800319:	8b 45 08             	mov    0x8(%ebp),%eax
  80031c:	01 c8                	add    %ecx,%eax
  80031e:	8b 00                	mov    (%eax),%eax
  800320:	39 c2                	cmp    %eax,%edx
  800322:	7d cf                	jge    8002f3 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800324:	eb 03                	jmp    800329 <QSort+0x5a>
  800326:	ff 4d f0             	decl   -0x10(%ebp)
  800329:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80032c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80032f:	7e 26                	jle    800357 <QSort+0x88>
  800331:	8b 45 10             	mov    0x10(%ebp),%eax
  800334:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80033b:	8b 45 08             	mov    0x8(%ebp),%eax
  80033e:	01 d0                	add    %edx,%eax
  800340:	8b 10                	mov    (%eax),%edx
  800342:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800345:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80034c:	8b 45 08             	mov    0x8(%ebp),%eax
  80034f:	01 c8                	add    %ecx,%eax
  800351:	8b 00                	mov    (%eax),%eax
  800353:	39 c2                	cmp    %eax,%edx
  800355:	7e cf                	jle    800326 <QSort+0x57>

		if (i <= j)
  800357:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80035a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80035d:	7f 14                	jg     800373 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  80035f:	83 ec 04             	sub    $0x4,%esp
  800362:	ff 75 f0             	pushl  -0x10(%ebp)
  800365:	ff 75 f4             	pushl  -0xc(%ebp)
  800368:	ff 75 08             	pushl  0x8(%ebp)
  80036b:	e8 a9 00 00 00       	call   800419 <Swap>
  800370:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800373:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800376:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800379:	0f 8e 77 ff ff ff    	jle    8002f6 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  80037f:	83 ec 04             	sub    $0x4,%esp
  800382:	ff 75 f0             	pushl  -0x10(%ebp)
  800385:	ff 75 10             	pushl  0x10(%ebp)
  800388:	ff 75 08             	pushl  0x8(%ebp)
  80038b:	e8 89 00 00 00       	call   800419 <Swap>
  800390:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800393:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800396:	48                   	dec    %eax
  800397:	50                   	push   %eax
  800398:	ff 75 10             	pushl  0x10(%ebp)
  80039b:	ff 75 0c             	pushl  0xc(%ebp)
  80039e:	ff 75 08             	pushl  0x8(%ebp)
  8003a1:	e8 29 ff ff ff       	call   8002cf <QSort>
  8003a6:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  8003a9:	ff 75 14             	pushl  0x14(%ebp)
  8003ac:	ff 75 f4             	pushl  -0xc(%ebp)
  8003af:	ff 75 0c             	pushl  0xc(%ebp)
  8003b2:	ff 75 08             	pushl  0x8(%ebp)
  8003b5:	e8 15 ff ff ff       	call   8002cf <QSort>
  8003ba:	83 c4 10             	add    $0x10,%esp
  8003bd:	eb 01                	jmp    8003c0 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8003bf:	90                   	nop
	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);

	//cprintf("qs,after sorting: start = %d, end = %d\n", startIndex, finalIndex);

}
  8003c0:	c9                   	leave  
  8003c1:	c3                   	ret    

008003c2 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8003c2:	55                   	push   %ebp
  8003c3:	89 e5                	mov    %esp,%ebp
  8003c5:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8003c8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003cf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8003d6:	eb 33                	jmp    80040b <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8003d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003db:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e5:	01 d0                	add    %edx,%eax
  8003e7:	8b 10                	mov    (%eax),%edx
  8003e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003ec:	40                   	inc    %eax
  8003ed:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f7:	01 c8                	add    %ecx,%eax
  8003f9:	8b 00                	mov    (%eax),%eax
  8003fb:	39 c2                	cmp    %eax,%edx
  8003fd:	7e 09                	jle    800408 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800406:	eb 0c                	jmp    800414 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800408:	ff 45 f8             	incl   -0x8(%ebp)
  80040b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80040e:	48                   	dec    %eax
  80040f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800412:	7f c4                	jg     8003d8 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800414:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800417:	c9                   	leave  
  800418:	c3                   	ret    

00800419 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800419:	55                   	push   %ebp
  80041a:	89 e5                	mov    %esp,%ebp
  80041c:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  80041f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800422:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800429:	8b 45 08             	mov    0x8(%ebp),%eax
  80042c:	01 d0                	add    %edx,%eax
  80042e:	8b 00                	mov    (%eax),%eax
  800430:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800433:	8b 45 0c             	mov    0xc(%ebp),%eax
  800436:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043d:	8b 45 08             	mov    0x8(%ebp),%eax
  800440:	01 c2                	add    %eax,%edx
  800442:	8b 45 10             	mov    0x10(%ebp),%eax
  800445:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80044c:	8b 45 08             	mov    0x8(%ebp),%eax
  80044f:	01 c8                	add    %ecx,%eax
  800451:	8b 00                	mov    (%eax),%eax
  800453:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800455:	8b 45 10             	mov    0x10(%ebp),%eax
  800458:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045f:	8b 45 08             	mov    0x8(%ebp),%eax
  800462:	01 c2                	add    %eax,%edx
  800464:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800467:	89 02                	mov    %eax,(%edx)
}
  800469:	90                   	nop
  80046a:	c9                   	leave  
  80046b:	c3                   	ret    

0080046c <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80046c:	55                   	push   %ebp
  80046d:	89 e5                	mov    %esp,%ebp
  80046f:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800472:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800479:	eb 17                	jmp    800492 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80047b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80047e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800485:	8b 45 08             	mov    0x8(%ebp),%eax
  800488:	01 c2                	add    %eax,%edx
  80048a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80048d:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80048f:	ff 45 fc             	incl   -0x4(%ebp)
  800492:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800495:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800498:	7c e1                	jl     80047b <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80049a:	90                   	nop
  80049b:	c9                   	leave  
  80049c:	c3                   	ret    

0080049d <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  80049d:	55                   	push   %ebp
  80049e:	89 e5                	mov    %esp,%ebp
  8004a0:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004aa:	eb 1b                	jmp    8004c7 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8004ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004af:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b9:	01 c2                	add    %eax,%edx
  8004bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004be:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8004c1:	48                   	dec    %eax
  8004c2:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004c4:	ff 45 fc             	incl   -0x4(%ebp)
  8004c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ca:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004cd:	7c dd                	jl     8004ac <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8004cf:	90                   	nop
  8004d0:	c9                   	leave  
  8004d1:	c3                   	ret    

008004d2 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8004d2:	55                   	push   %ebp
  8004d3:	89 e5                	mov    %esp,%ebp
  8004d5:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8004d8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004db:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8004e0:	f7 e9                	imul   %ecx
  8004e2:	c1 f9 1f             	sar    $0x1f,%ecx
  8004e5:	89 d0                	mov    %edx,%eax
  8004e7:	29 c8                	sub    %ecx,%eax
  8004e9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004f3:	eb 1e                	jmp    800513 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8004f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004f8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800502:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800505:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800508:	99                   	cltd   
  800509:	f7 7d f8             	idivl  -0x8(%ebp)
  80050c:	89 d0                	mov    %edx,%eax
  80050e:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800510:	ff 45 fc             	incl   -0x4(%ebp)
  800513:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800516:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800519:	7c da                	jl     8004f5 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80051b:	90                   	nop
  80051c:	c9                   	leave  
  80051d:	c3                   	ret    

0080051e <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80051e:	55                   	push   %ebp
  80051f:	89 e5                	mov    %esp,%ebp
  800521:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800524:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80052b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800532:	eb 42                	jmp    800576 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800534:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800537:	99                   	cltd   
  800538:	f7 7d f0             	idivl  -0x10(%ebp)
  80053b:	89 d0                	mov    %edx,%eax
  80053d:	85 c0                	test   %eax,%eax
  80053f:	75 10                	jne    800551 <PrintElements+0x33>
			cprintf("\n");
  800541:	83 ec 0c             	sub    $0xc,%esp
  800544:	68 00 26 80 00       	push   $0x802600
  800549:	e8 dd 04 00 00       	call   800a2b <cprintf>
  80054e:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800551:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800554:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80055b:	8b 45 08             	mov    0x8(%ebp),%eax
  80055e:	01 d0                	add    %edx,%eax
  800560:	8b 00                	mov    (%eax),%eax
  800562:	83 ec 08             	sub    $0x8,%esp
  800565:	50                   	push   %eax
  800566:	68 d8 27 80 00       	push   $0x8027d8
  80056b:	e8 bb 04 00 00       	call   800a2b <cprintf>
  800570:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800573:	ff 45 f4             	incl   -0xc(%ebp)
  800576:	8b 45 0c             	mov    0xc(%ebp),%eax
  800579:	48                   	dec    %eax
  80057a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80057d:	7f b5                	jg     800534 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80057f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800582:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800589:	8b 45 08             	mov    0x8(%ebp),%eax
  80058c:	01 d0                	add    %edx,%eax
  80058e:	8b 00                	mov    (%eax),%eax
  800590:	83 ec 08             	sub    $0x8,%esp
  800593:	50                   	push   %eax
  800594:	68 dd 27 80 00       	push   $0x8027dd
  800599:	e8 8d 04 00 00       	call   800a2b <cprintf>
  80059e:	83 c4 10             	add    $0x10,%esp

}
  8005a1:	90                   	nop
  8005a2:	c9                   	leave  
  8005a3:	c3                   	ret    

008005a4 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8005a4:	55                   	push   %ebp
  8005a5:	89 e5                	mov    %esp,%ebp
  8005a7:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8005aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ad:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005b0:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005b4:	83 ec 0c             	sub    $0xc,%esp
  8005b7:	50                   	push   %eax
  8005b8:	e8 e9 19 00 00       	call   801fa6 <sys_cputc>
  8005bd:	83 c4 10             	add    $0x10,%esp
}
  8005c0:	90                   	nop
  8005c1:	c9                   	leave  
  8005c2:	c3                   	ret    

008005c3 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8005c3:	55                   	push   %ebp
  8005c4:	89 e5                	mov    %esp,%ebp
  8005c6:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005c9:	e8 a4 19 00 00       	call   801f72 <sys_disable_interrupt>
	char c = ch;
  8005ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d1:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005d4:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005d8:	83 ec 0c             	sub    $0xc,%esp
  8005db:	50                   	push   %eax
  8005dc:	e8 c5 19 00 00       	call   801fa6 <sys_cputc>
  8005e1:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8005e4:	e8 a3 19 00 00       	call   801f8c <sys_enable_interrupt>
}
  8005e9:	90                   	nop
  8005ea:	c9                   	leave  
  8005eb:	c3                   	ret    

008005ec <getchar>:

int
getchar(void)
{
  8005ec:	55                   	push   %ebp
  8005ed:	89 e5                	mov    %esp,%ebp
  8005ef:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8005f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005f9:	eb 08                	jmp    800603 <getchar+0x17>
	{
		c = sys_cgetc();
  8005fb:	e8 8a 17 00 00       	call   801d8a <sys_cgetc>
  800600:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800603:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800607:	74 f2                	je     8005fb <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  800609:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80060c:	c9                   	leave  
  80060d:	c3                   	ret    

0080060e <atomic_getchar>:

int
atomic_getchar(void)
{
  80060e:	55                   	push   %ebp
  80060f:	89 e5                	mov    %esp,%ebp
  800611:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800614:	e8 59 19 00 00       	call   801f72 <sys_disable_interrupt>
	int c=0;
  800619:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800620:	eb 08                	jmp    80062a <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800622:	e8 63 17 00 00       	call   801d8a <sys_cgetc>
  800627:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80062a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80062e:	74 f2                	je     800622 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800630:	e8 57 19 00 00       	call   801f8c <sys_enable_interrupt>
	return c;
  800635:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800638:	c9                   	leave  
  800639:	c3                   	ret    

0080063a <iscons>:

int iscons(int fdnum)
{
  80063a:	55                   	push   %ebp
  80063b:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80063d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800642:	5d                   	pop    %ebp
  800643:	c3                   	ret    

00800644 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800644:	55                   	push   %ebp
  800645:	89 e5                	mov    %esp,%ebp
  800647:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80064a:	e8 88 17 00 00       	call   801dd7 <sys_getenvindex>
  80064f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800652:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800655:	89 d0                	mov    %edx,%eax
  800657:	c1 e0 03             	shl    $0x3,%eax
  80065a:	01 d0                	add    %edx,%eax
  80065c:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800663:	01 c8                	add    %ecx,%eax
  800665:	01 c0                	add    %eax,%eax
  800667:	01 d0                	add    %edx,%eax
  800669:	01 c0                	add    %eax,%eax
  80066b:	01 d0                	add    %edx,%eax
  80066d:	89 c2                	mov    %eax,%edx
  80066f:	c1 e2 05             	shl    $0x5,%edx
  800672:	29 c2                	sub    %eax,%edx
  800674:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80067b:	89 c2                	mov    %eax,%edx
  80067d:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800683:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800688:	a1 24 30 80 00       	mov    0x803024,%eax
  80068d:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800693:	84 c0                	test   %al,%al
  800695:	74 0f                	je     8006a6 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800697:	a1 24 30 80 00       	mov    0x803024,%eax
  80069c:	05 40 3c 01 00       	add    $0x13c40,%eax
  8006a1:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8006a6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8006aa:	7e 0a                	jle    8006b6 <libmain+0x72>
		binaryname = argv[0];
  8006ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006af:	8b 00                	mov    (%eax),%eax
  8006b1:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8006b6:	83 ec 08             	sub    $0x8,%esp
  8006b9:	ff 75 0c             	pushl  0xc(%ebp)
  8006bc:	ff 75 08             	pushl  0x8(%ebp)
  8006bf:	e8 74 f9 ff ff       	call   800038 <_main>
  8006c4:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8006c7:	e8 a6 18 00 00       	call   801f72 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8006cc:	83 ec 0c             	sub    $0xc,%esp
  8006cf:	68 fc 27 80 00       	push   $0x8027fc
  8006d4:	e8 52 03 00 00       	call   800a2b <cprintf>
  8006d9:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006dc:	a1 24 30 80 00       	mov    0x803024,%eax
  8006e1:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8006e7:	a1 24 30 80 00       	mov    0x803024,%eax
  8006ec:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8006f2:	83 ec 04             	sub    $0x4,%esp
  8006f5:	52                   	push   %edx
  8006f6:	50                   	push   %eax
  8006f7:	68 24 28 80 00       	push   $0x802824
  8006fc:	e8 2a 03 00 00       	call   800a2b <cprintf>
  800701:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800704:	a1 24 30 80 00       	mov    0x803024,%eax
  800709:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80070f:	a1 24 30 80 00       	mov    0x803024,%eax
  800714:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80071a:	83 ec 04             	sub    $0x4,%esp
  80071d:	52                   	push   %edx
  80071e:	50                   	push   %eax
  80071f:	68 4c 28 80 00       	push   $0x80284c
  800724:	e8 02 03 00 00       	call   800a2b <cprintf>
  800729:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80072c:	a1 24 30 80 00       	mov    0x803024,%eax
  800731:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800737:	83 ec 08             	sub    $0x8,%esp
  80073a:	50                   	push   %eax
  80073b:	68 8d 28 80 00       	push   $0x80288d
  800740:	e8 e6 02 00 00       	call   800a2b <cprintf>
  800745:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800748:	83 ec 0c             	sub    $0xc,%esp
  80074b:	68 fc 27 80 00       	push   $0x8027fc
  800750:	e8 d6 02 00 00       	call   800a2b <cprintf>
  800755:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800758:	e8 2f 18 00 00       	call   801f8c <sys_enable_interrupt>

	// exit gracefully
	exit();
  80075d:	e8 19 00 00 00       	call   80077b <exit>
}
  800762:	90                   	nop
  800763:	c9                   	leave  
  800764:	c3                   	ret    

00800765 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800765:	55                   	push   %ebp
  800766:	89 e5                	mov    %esp,%ebp
  800768:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80076b:	83 ec 0c             	sub    $0xc,%esp
  80076e:	6a 00                	push   $0x0
  800770:	e8 2e 16 00 00       	call   801da3 <sys_env_destroy>
  800775:	83 c4 10             	add    $0x10,%esp
}
  800778:	90                   	nop
  800779:	c9                   	leave  
  80077a:	c3                   	ret    

0080077b <exit>:

void
exit(void)
{
  80077b:	55                   	push   %ebp
  80077c:	89 e5                	mov    %esp,%ebp
  80077e:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800781:	e8 83 16 00 00       	call   801e09 <sys_env_exit>
}
  800786:	90                   	nop
  800787:	c9                   	leave  
  800788:	c3                   	ret    

00800789 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800789:	55                   	push   %ebp
  80078a:	89 e5                	mov    %esp,%ebp
  80078c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80078f:	8d 45 10             	lea    0x10(%ebp),%eax
  800792:	83 c0 04             	add    $0x4,%eax
  800795:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800798:	a1 18 31 80 00       	mov    0x803118,%eax
  80079d:	85 c0                	test   %eax,%eax
  80079f:	74 16                	je     8007b7 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8007a1:	a1 18 31 80 00       	mov    0x803118,%eax
  8007a6:	83 ec 08             	sub    $0x8,%esp
  8007a9:	50                   	push   %eax
  8007aa:	68 a4 28 80 00       	push   $0x8028a4
  8007af:	e8 77 02 00 00       	call   800a2b <cprintf>
  8007b4:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8007b7:	a1 00 30 80 00       	mov    0x803000,%eax
  8007bc:	ff 75 0c             	pushl  0xc(%ebp)
  8007bf:	ff 75 08             	pushl  0x8(%ebp)
  8007c2:	50                   	push   %eax
  8007c3:	68 a9 28 80 00       	push   $0x8028a9
  8007c8:	e8 5e 02 00 00       	call   800a2b <cprintf>
  8007cd:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8007d3:	83 ec 08             	sub    $0x8,%esp
  8007d6:	ff 75 f4             	pushl  -0xc(%ebp)
  8007d9:	50                   	push   %eax
  8007da:	e8 e1 01 00 00       	call   8009c0 <vcprintf>
  8007df:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8007e2:	83 ec 08             	sub    $0x8,%esp
  8007e5:	6a 00                	push   $0x0
  8007e7:	68 c5 28 80 00       	push   $0x8028c5
  8007ec:	e8 cf 01 00 00       	call   8009c0 <vcprintf>
  8007f1:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8007f4:	e8 82 ff ff ff       	call   80077b <exit>

	// should not return here
	while (1) ;
  8007f9:	eb fe                	jmp    8007f9 <_panic+0x70>

008007fb <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007fb:	55                   	push   %ebp
  8007fc:	89 e5                	mov    %esp,%ebp
  8007fe:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800801:	a1 24 30 80 00       	mov    0x803024,%eax
  800806:	8b 50 74             	mov    0x74(%eax),%edx
  800809:	8b 45 0c             	mov    0xc(%ebp),%eax
  80080c:	39 c2                	cmp    %eax,%edx
  80080e:	74 14                	je     800824 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800810:	83 ec 04             	sub    $0x4,%esp
  800813:	68 c8 28 80 00       	push   $0x8028c8
  800818:	6a 26                	push   $0x26
  80081a:	68 14 29 80 00       	push   $0x802914
  80081f:	e8 65 ff ff ff       	call   800789 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800824:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80082b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800832:	e9 b6 00 00 00       	jmp    8008ed <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800837:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80083a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800841:	8b 45 08             	mov    0x8(%ebp),%eax
  800844:	01 d0                	add    %edx,%eax
  800846:	8b 00                	mov    (%eax),%eax
  800848:	85 c0                	test   %eax,%eax
  80084a:	75 08                	jne    800854 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80084c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80084f:	e9 96 00 00 00       	jmp    8008ea <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800854:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80085b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800862:	eb 5d                	jmp    8008c1 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800864:	a1 24 30 80 00       	mov    0x803024,%eax
  800869:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80086f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800872:	c1 e2 04             	shl    $0x4,%edx
  800875:	01 d0                	add    %edx,%eax
  800877:	8a 40 04             	mov    0x4(%eax),%al
  80087a:	84 c0                	test   %al,%al
  80087c:	75 40                	jne    8008be <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80087e:	a1 24 30 80 00       	mov    0x803024,%eax
  800883:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800889:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80088c:	c1 e2 04             	shl    $0x4,%edx
  80088f:	01 d0                	add    %edx,%eax
  800891:	8b 00                	mov    (%eax),%eax
  800893:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800896:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800899:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80089e:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8008a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008a3:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8008aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ad:	01 c8                	add    %ecx,%eax
  8008af:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008b1:	39 c2                	cmp    %eax,%edx
  8008b3:	75 09                	jne    8008be <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8008b5:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8008bc:	eb 12                	jmp    8008d0 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008be:	ff 45 e8             	incl   -0x18(%ebp)
  8008c1:	a1 24 30 80 00       	mov    0x803024,%eax
  8008c6:	8b 50 74             	mov    0x74(%eax),%edx
  8008c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008cc:	39 c2                	cmp    %eax,%edx
  8008ce:	77 94                	ja     800864 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8008d0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8008d4:	75 14                	jne    8008ea <CheckWSWithoutLastIndex+0xef>
			panic(
  8008d6:	83 ec 04             	sub    $0x4,%esp
  8008d9:	68 20 29 80 00       	push   $0x802920
  8008de:	6a 3a                	push   $0x3a
  8008e0:	68 14 29 80 00       	push   $0x802914
  8008e5:	e8 9f fe ff ff       	call   800789 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8008ea:	ff 45 f0             	incl   -0x10(%ebp)
  8008ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008f0:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008f3:	0f 8c 3e ff ff ff    	jl     800837 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008f9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800900:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800907:	eb 20                	jmp    800929 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800909:	a1 24 30 80 00       	mov    0x803024,%eax
  80090e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800914:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800917:	c1 e2 04             	shl    $0x4,%edx
  80091a:	01 d0                	add    %edx,%eax
  80091c:	8a 40 04             	mov    0x4(%eax),%al
  80091f:	3c 01                	cmp    $0x1,%al
  800921:	75 03                	jne    800926 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800923:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800926:	ff 45 e0             	incl   -0x20(%ebp)
  800929:	a1 24 30 80 00       	mov    0x803024,%eax
  80092e:	8b 50 74             	mov    0x74(%eax),%edx
  800931:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800934:	39 c2                	cmp    %eax,%edx
  800936:	77 d1                	ja     800909 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800938:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80093b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80093e:	74 14                	je     800954 <CheckWSWithoutLastIndex+0x159>
		panic(
  800940:	83 ec 04             	sub    $0x4,%esp
  800943:	68 74 29 80 00       	push   $0x802974
  800948:	6a 44                	push   $0x44
  80094a:	68 14 29 80 00       	push   $0x802914
  80094f:	e8 35 fe ff ff       	call   800789 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800954:	90                   	nop
  800955:	c9                   	leave  
  800956:	c3                   	ret    

00800957 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800957:	55                   	push   %ebp
  800958:	89 e5                	mov    %esp,%ebp
  80095a:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80095d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800960:	8b 00                	mov    (%eax),%eax
  800962:	8d 48 01             	lea    0x1(%eax),%ecx
  800965:	8b 55 0c             	mov    0xc(%ebp),%edx
  800968:	89 0a                	mov    %ecx,(%edx)
  80096a:	8b 55 08             	mov    0x8(%ebp),%edx
  80096d:	88 d1                	mov    %dl,%cl
  80096f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800972:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800976:	8b 45 0c             	mov    0xc(%ebp),%eax
  800979:	8b 00                	mov    (%eax),%eax
  80097b:	3d ff 00 00 00       	cmp    $0xff,%eax
  800980:	75 2c                	jne    8009ae <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800982:	a0 28 30 80 00       	mov    0x803028,%al
  800987:	0f b6 c0             	movzbl %al,%eax
  80098a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80098d:	8b 12                	mov    (%edx),%edx
  80098f:	89 d1                	mov    %edx,%ecx
  800991:	8b 55 0c             	mov    0xc(%ebp),%edx
  800994:	83 c2 08             	add    $0x8,%edx
  800997:	83 ec 04             	sub    $0x4,%esp
  80099a:	50                   	push   %eax
  80099b:	51                   	push   %ecx
  80099c:	52                   	push   %edx
  80099d:	e8 bf 13 00 00       	call   801d61 <sys_cputs>
  8009a2:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8009a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8009ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b1:	8b 40 04             	mov    0x4(%eax),%eax
  8009b4:	8d 50 01             	lea    0x1(%eax),%edx
  8009b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ba:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009bd:	90                   	nop
  8009be:	c9                   	leave  
  8009bf:	c3                   	ret    

008009c0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8009c0:	55                   	push   %ebp
  8009c1:	89 e5                	mov    %esp,%ebp
  8009c3:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8009c9:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8009d0:	00 00 00 
	b.cnt = 0;
  8009d3:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8009da:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8009dd:	ff 75 0c             	pushl  0xc(%ebp)
  8009e0:	ff 75 08             	pushl  0x8(%ebp)
  8009e3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009e9:	50                   	push   %eax
  8009ea:	68 57 09 80 00       	push   $0x800957
  8009ef:	e8 11 02 00 00       	call   800c05 <vprintfmt>
  8009f4:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009f7:	a0 28 30 80 00       	mov    0x803028,%al
  8009fc:	0f b6 c0             	movzbl %al,%eax
  8009ff:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a05:	83 ec 04             	sub    $0x4,%esp
  800a08:	50                   	push   %eax
  800a09:	52                   	push   %edx
  800a0a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a10:	83 c0 08             	add    $0x8,%eax
  800a13:	50                   	push   %eax
  800a14:	e8 48 13 00 00       	call   801d61 <sys_cputs>
  800a19:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a1c:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800a23:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a29:	c9                   	leave  
  800a2a:	c3                   	ret    

00800a2b <cprintf>:

int cprintf(const char *fmt, ...) {
  800a2b:	55                   	push   %ebp
  800a2c:	89 e5                	mov    %esp,%ebp
  800a2e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a31:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800a38:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a41:	83 ec 08             	sub    $0x8,%esp
  800a44:	ff 75 f4             	pushl  -0xc(%ebp)
  800a47:	50                   	push   %eax
  800a48:	e8 73 ff ff ff       	call   8009c0 <vcprintf>
  800a4d:	83 c4 10             	add    $0x10,%esp
  800a50:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a53:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a56:	c9                   	leave  
  800a57:	c3                   	ret    

00800a58 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a58:	55                   	push   %ebp
  800a59:	89 e5                	mov    %esp,%ebp
  800a5b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a5e:	e8 0f 15 00 00       	call   801f72 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a63:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a66:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a69:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6c:	83 ec 08             	sub    $0x8,%esp
  800a6f:	ff 75 f4             	pushl  -0xc(%ebp)
  800a72:	50                   	push   %eax
  800a73:	e8 48 ff ff ff       	call   8009c0 <vcprintf>
  800a78:	83 c4 10             	add    $0x10,%esp
  800a7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a7e:	e8 09 15 00 00       	call   801f8c <sys_enable_interrupt>
	return cnt;
  800a83:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a86:	c9                   	leave  
  800a87:	c3                   	ret    

00800a88 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a88:	55                   	push   %ebp
  800a89:	89 e5                	mov    %esp,%ebp
  800a8b:	53                   	push   %ebx
  800a8c:	83 ec 14             	sub    $0x14,%esp
  800a8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800a92:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a95:	8b 45 14             	mov    0x14(%ebp),%eax
  800a98:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a9b:	8b 45 18             	mov    0x18(%ebp),%eax
  800a9e:	ba 00 00 00 00       	mov    $0x0,%edx
  800aa3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800aa6:	77 55                	ja     800afd <printnum+0x75>
  800aa8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800aab:	72 05                	jb     800ab2 <printnum+0x2a>
  800aad:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ab0:	77 4b                	ja     800afd <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800ab2:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800ab5:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800ab8:	8b 45 18             	mov    0x18(%ebp),%eax
  800abb:	ba 00 00 00 00       	mov    $0x0,%edx
  800ac0:	52                   	push   %edx
  800ac1:	50                   	push   %eax
  800ac2:	ff 75 f4             	pushl  -0xc(%ebp)
  800ac5:	ff 75 f0             	pushl  -0x10(%ebp)
  800ac8:	e8 c7 18 00 00       	call   802394 <__udivdi3>
  800acd:	83 c4 10             	add    $0x10,%esp
  800ad0:	83 ec 04             	sub    $0x4,%esp
  800ad3:	ff 75 20             	pushl  0x20(%ebp)
  800ad6:	53                   	push   %ebx
  800ad7:	ff 75 18             	pushl  0x18(%ebp)
  800ada:	52                   	push   %edx
  800adb:	50                   	push   %eax
  800adc:	ff 75 0c             	pushl  0xc(%ebp)
  800adf:	ff 75 08             	pushl  0x8(%ebp)
  800ae2:	e8 a1 ff ff ff       	call   800a88 <printnum>
  800ae7:	83 c4 20             	add    $0x20,%esp
  800aea:	eb 1a                	jmp    800b06 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800aec:	83 ec 08             	sub    $0x8,%esp
  800aef:	ff 75 0c             	pushl  0xc(%ebp)
  800af2:	ff 75 20             	pushl  0x20(%ebp)
  800af5:	8b 45 08             	mov    0x8(%ebp),%eax
  800af8:	ff d0                	call   *%eax
  800afa:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800afd:	ff 4d 1c             	decl   0x1c(%ebp)
  800b00:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b04:	7f e6                	jg     800aec <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b06:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b09:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b11:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b14:	53                   	push   %ebx
  800b15:	51                   	push   %ecx
  800b16:	52                   	push   %edx
  800b17:	50                   	push   %eax
  800b18:	e8 87 19 00 00       	call   8024a4 <__umoddi3>
  800b1d:	83 c4 10             	add    $0x10,%esp
  800b20:	05 d4 2b 80 00       	add    $0x802bd4,%eax
  800b25:	8a 00                	mov    (%eax),%al
  800b27:	0f be c0             	movsbl %al,%eax
  800b2a:	83 ec 08             	sub    $0x8,%esp
  800b2d:	ff 75 0c             	pushl  0xc(%ebp)
  800b30:	50                   	push   %eax
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
  800b34:	ff d0                	call   *%eax
  800b36:	83 c4 10             	add    $0x10,%esp
}
  800b39:	90                   	nop
  800b3a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b3d:	c9                   	leave  
  800b3e:	c3                   	ret    

00800b3f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b3f:	55                   	push   %ebp
  800b40:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b42:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b46:	7e 1c                	jle    800b64 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b48:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4b:	8b 00                	mov    (%eax),%eax
  800b4d:	8d 50 08             	lea    0x8(%eax),%edx
  800b50:	8b 45 08             	mov    0x8(%ebp),%eax
  800b53:	89 10                	mov    %edx,(%eax)
  800b55:	8b 45 08             	mov    0x8(%ebp),%eax
  800b58:	8b 00                	mov    (%eax),%eax
  800b5a:	83 e8 08             	sub    $0x8,%eax
  800b5d:	8b 50 04             	mov    0x4(%eax),%edx
  800b60:	8b 00                	mov    (%eax),%eax
  800b62:	eb 40                	jmp    800ba4 <getuint+0x65>
	else if (lflag)
  800b64:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b68:	74 1e                	je     800b88 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6d:	8b 00                	mov    (%eax),%eax
  800b6f:	8d 50 04             	lea    0x4(%eax),%edx
  800b72:	8b 45 08             	mov    0x8(%ebp),%eax
  800b75:	89 10                	mov    %edx,(%eax)
  800b77:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7a:	8b 00                	mov    (%eax),%eax
  800b7c:	83 e8 04             	sub    $0x4,%eax
  800b7f:	8b 00                	mov    (%eax),%eax
  800b81:	ba 00 00 00 00       	mov    $0x0,%edx
  800b86:	eb 1c                	jmp    800ba4 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b88:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8b:	8b 00                	mov    (%eax),%eax
  800b8d:	8d 50 04             	lea    0x4(%eax),%edx
  800b90:	8b 45 08             	mov    0x8(%ebp),%eax
  800b93:	89 10                	mov    %edx,(%eax)
  800b95:	8b 45 08             	mov    0x8(%ebp),%eax
  800b98:	8b 00                	mov    (%eax),%eax
  800b9a:	83 e8 04             	sub    $0x4,%eax
  800b9d:	8b 00                	mov    (%eax),%eax
  800b9f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800ba4:	5d                   	pop    %ebp
  800ba5:	c3                   	ret    

00800ba6 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800ba6:	55                   	push   %ebp
  800ba7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ba9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bad:	7e 1c                	jle    800bcb <getint+0x25>
		return va_arg(*ap, long long);
  800baf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb2:	8b 00                	mov    (%eax),%eax
  800bb4:	8d 50 08             	lea    0x8(%eax),%edx
  800bb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bba:	89 10                	mov    %edx,(%eax)
  800bbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbf:	8b 00                	mov    (%eax),%eax
  800bc1:	83 e8 08             	sub    $0x8,%eax
  800bc4:	8b 50 04             	mov    0x4(%eax),%edx
  800bc7:	8b 00                	mov    (%eax),%eax
  800bc9:	eb 38                	jmp    800c03 <getint+0x5d>
	else if (lflag)
  800bcb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bcf:	74 1a                	je     800beb <getint+0x45>
		return va_arg(*ap, long);
  800bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd4:	8b 00                	mov    (%eax),%eax
  800bd6:	8d 50 04             	lea    0x4(%eax),%edx
  800bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdc:	89 10                	mov    %edx,(%eax)
  800bde:	8b 45 08             	mov    0x8(%ebp),%eax
  800be1:	8b 00                	mov    (%eax),%eax
  800be3:	83 e8 04             	sub    $0x4,%eax
  800be6:	8b 00                	mov    (%eax),%eax
  800be8:	99                   	cltd   
  800be9:	eb 18                	jmp    800c03 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800beb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bee:	8b 00                	mov    (%eax),%eax
  800bf0:	8d 50 04             	lea    0x4(%eax),%edx
  800bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf6:	89 10                	mov    %edx,(%eax)
  800bf8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfb:	8b 00                	mov    (%eax),%eax
  800bfd:	83 e8 04             	sub    $0x4,%eax
  800c00:	8b 00                	mov    (%eax),%eax
  800c02:	99                   	cltd   
}
  800c03:	5d                   	pop    %ebp
  800c04:	c3                   	ret    

00800c05 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c05:	55                   	push   %ebp
  800c06:	89 e5                	mov    %esp,%ebp
  800c08:	56                   	push   %esi
  800c09:	53                   	push   %ebx
  800c0a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c0d:	eb 17                	jmp    800c26 <vprintfmt+0x21>
			if (ch == '\0')
  800c0f:	85 db                	test   %ebx,%ebx
  800c11:	0f 84 af 03 00 00    	je     800fc6 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c17:	83 ec 08             	sub    $0x8,%esp
  800c1a:	ff 75 0c             	pushl  0xc(%ebp)
  800c1d:	53                   	push   %ebx
  800c1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c21:	ff d0                	call   *%eax
  800c23:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c26:	8b 45 10             	mov    0x10(%ebp),%eax
  800c29:	8d 50 01             	lea    0x1(%eax),%edx
  800c2c:	89 55 10             	mov    %edx,0x10(%ebp)
  800c2f:	8a 00                	mov    (%eax),%al
  800c31:	0f b6 d8             	movzbl %al,%ebx
  800c34:	83 fb 25             	cmp    $0x25,%ebx
  800c37:	75 d6                	jne    800c0f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c39:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c3d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c44:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c4b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c52:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c59:	8b 45 10             	mov    0x10(%ebp),%eax
  800c5c:	8d 50 01             	lea    0x1(%eax),%edx
  800c5f:	89 55 10             	mov    %edx,0x10(%ebp)
  800c62:	8a 00                	mov    (%eax),%al
  800c64:	0f b6 d8             	movzbl %al,%ebx
  800c67:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c6a:	83 f8 55             	cmp    $0x55,%eax
  800c6d:	0f 87 2b 03 00 00    	ja     800f9e <vprintfmt+0x399>
  800c73:	8b 04 85 f8 2b 80 00 	mov    0x802bf8(,%eax,4),%eax
  800c7a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c7c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c80:	eb d7                	jmp    800c59 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c82:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c86:	eb d1                	jmp    800c59 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c88:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c8f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c92:	89 d0                	mov    %edx,%eax
  800c94:	c1 e0 02             	shl    $0x2,%eax
  800c97:	01 d0                	add    %edx,%eax
  800c99:	01 c0                	add    %eax,%eax
  800c9b:	01 d8                	add    %ebx,%eax
  800c9d:	83 e8 30             	sub    $0x30,%eax
  800ca0:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800ca3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca6:	8a 00                	mov    (%eax),%al
  800ca8:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800cab:	83 fb 2f             	cmp    $0x2f,%ebx
  800cae:	7e 3e                	jle    800cee <vprintfmt+0xe9>
  800cb0:	83 fb 39             	cmp    $0x39,%ebx
  800cb3:	7f 39                	jg     800cee <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cb5:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800cb8:	eb d5                	jmp    800c8f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800cba:	8b 45 14             	mov    0x14(%ebp),%eax
  800cbd:	83 c0 04             	add    $0x4,%eax
  800cc0:	89 45 14             	mov    %eax,0x14(%ebp)
  800cc3:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc6:	83 e8 04             	sub    $0x4,%eax
  800cc9:	8b 00                	mov    (%eax),%eax
  800ccb:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800cce:	eb 1f                	jmp    800cef <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800cd0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cd4:	79 83                	jns    800c59 <vprintfmt+0x54>
				width = 0;
  800cd6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800cdd:	e9 77 ff ff ff       	jmp    800c59 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800ce2:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800ce9:	e9 6b ff ff ff       	jmp    800c59 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800cee:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800cef:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cf3:	0f 89 60 ff ff ff    	jns    800c59 <vprintfmt+0x54>
				width = precision, precision = -1;
  800cf9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cfc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800cff:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d06:	e9 4e ff ff ff       	jmp    800c59 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d0b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d0e:	e9 46 ff ff ff       	jmp    800c59 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d13:	8b 45 14             	mov    0x14(%ebp),%eax
  800d16:	83 c0 04             	add    $0x4,%eax
  800d19:	89 45 14             	mov    %eax,0x14(%ebp)
  800d1c:	8b 45 14             	mov    0x14(%ebp),%eax
  800d1f:	83 e8 04             	sub    $0x4,%eax
  800d22:	8b 00                	mov    (%eax),%eax
  800d24:	83 ec 08             	sub    $0x8,%esp
  800d27:	ff 75 0c             	pushl  0xc(%ebp)
  800d2a:	50                   	push   %eax
  800d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2e:	ff d0                	call   *%eax
  800d30:	83 c4 10             	add    $0x10,%esp
			break;
  800d33:	e9 89 02 00 00       	jmp    800fc1 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d38:	8b 45 14             	mov    0x14(%ebp),%eax
  800d3b:	83 c0 04             	add    $0x4,%eax
  800d3e:	89 45 14             	mov    %eax,0x14(%ebp)
  800d41:	8b 45 14             	mov    0x14(%ebp),%eax
  800d44:	83 e8 04             	sub    $0x4,%eax
  800d47:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d49:	85 db                	test   %ebx,%ebx
  800d4b:	79 02                	jns    800d4f <vprintfmt+0x14a>
				err = -err;
  800d4d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d4f:	83 fb 64             	cmp    $0x64,%ebx
  800d52:	7f 0b                	jg     800d5f <vprintfmt+0x15a>
  800d54:	8b 34 9d 40 2a 80 00 	mov    0x802a40(,%ebx,4),%esi
  800d5b:	85 f6                	test   %esi,%esi
  800d5d:	75 19                	jne    800d78 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d5f:	53                   	push   %ebx
  800d60:	68 e5 2b 80 00       	push   $0x802be5
  800d65:	ff 75 0c             	pushl  0xc(%ebp)
  800d68:	ff 75 08             	pushl  0x8(%ebp)
  800d6b:	e8 5e 02 00 00       	call   800fce <printfmt>
  800d70:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d73:	e9 49 02 00 00       	jmp    800fc1 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d78:	56                   	push   %esi
  800d79:	68 ee 2b 80 00       	push   $0x802bee
  800d7e:	ff 75 0c             	pushl  0xc(%ebp)
  800d81:	ff 75 08             	pushl  0x8(%ebp)
  800d84:	e8 45 02 00 00       	call   800fce <printfmt>
  800d89:	83 c4 10             	add    $0x10,%esp
			break;
  800d8c:	e9 30 02 00 00       	jmp    800fc1 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d91:	8b 45 14             	mov    0x14(%ebp),%eax
  800d94:	83 c0 04             	add    $0x4,%eax
  800d97:	89 45 14             	mov    %eax,0x14(%ebp)
  800d9a:	8b 45 14             	mov    0x14(%ebp),%eax
  800d9d:	83 e8 04             	sub    $0x4,%eax
  800da0:	8b 30                	mov    (%eax),%esi
  800da2:	85 f6                	test   %esi,%esi
  800da4:	75 05                	jne    800dab <vprintfmt+0x1a6>
				p = "(null)";
  800da6:	be f1 2b 80 00       	mov    $0x802bf1,%esi
			if (width > 0 && padc != '-')
  800dab:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800daf:	7e 6d                	jle    800e1e <vprintfmt+0x219>
  800db1:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800db5:	74 67                	je     800e1e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800db7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800dba:	83 ec 08             	sub    $0x8,%esp
  800dbd:	50                   	push   %eax
  800dbe:	56                   	push   %esi
  800dbf:	e8 12 05 00 00       	call   8012d6 <strnlen>
  800dc4:	83 c4 10             	add    $0x10,%esp
  800dc7:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800dca:	eb 16                	jmp    800de2 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800dcc:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800dd0:	83 ec 08             	sub    $0x8,%esp
  800dd3:	ff 75 0c             	pushl  0xc(%ebp)
  800dd6:	50                   	push   %eax
  800dd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dda:	ff d0                	call   *%eax
  800ddc:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800ddf:	ff 4d e4             	decl   -0x1c(%ebp)
  800de2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800de6:	7f e4                	jg     800dcc <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800de8:	eb 34                	jmp    800e1e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800dea:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800dee:	74 1c                	je     800e0c <vprintfmt+0x207>
  800df0:	83 fb 1f             	cmp    $0x1f,%ebx
  800df3:	7e 05                	jle    800dfa <vprintfmt+0x1f5>
  800df5:	83 fb 7e             	cmp    $0x7e,%ebx
  800df8:	7e 12                	jle    800e0c <vprintfmt+0x207>
					putch('?', putdat);
  800dfa:	83 ec 08             	sub    $0x8,%esp
  800dfd:	ff 75 0c             	pushl  0xc(%ebp)
  800e00:	6a 3f                	push   $0x3f
  800e02:	8b 45 08             	mov    0x8(%ebp),%eax
  800e05:	ff d0                	call   *%eax
  800e07:	83 c4 10             	add    $0x10,%esp
  800e0a:	eb 0f                	jmp    800e1b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e0c:	83 ec 08             	sub    $0x8,%esp
  800e0f:	ff 75 0c             	pushl  0xc(%ebp)
  800e12:	53                   	push   %ebx
  800e13:	8b 45 08             	mov    0x8(%ebp),%eax
  800e16:	ff d0                	call   *%eax
  800e18:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e1b:	ff 4d e4             	decl   -0x1c(%ebp)
  800e1e:	89 f0                	mov    %esi,%eax
  800e20:	8d 70 01             	lea    0x1(%eax),%esi
  800e23:	8a 00                	mov    (%eax),%al
  800e25:	0f be d8             	movsbl %al,%ebx
  800e28:	85 db                	test   %ebx,%ebx
  800e2a:	74 24                	je     800e50 <vprintfmt+0x24b>
  800e2c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e30:	78 b8                	js     800dea <vprintfmt+0x1e5>
  800e32:	ff 4d e0             	decl   -0x20(%ebp)
  800e35:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e39:	79 af                	jns    800dea <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e3b:	eb 13                	jmp    800e50 <vprintfmt+0x24b>
				putch(' ', putdat);
  800e3d:	83 ec 08             	sub    $0x8,%esp
  800e40:	ff 75 0c             	pushl  0xc(%ebp)
  800e43:	6a 20                	push   $0x20
  800e45:	8b 45 08             	mov    0x8(%ebp),%eax
  800e48:	ff d0                	call   *%eax
  800e4a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e4d:	ff 4d e4             	decl   -0x1c(%ebp)
  800e50:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e54:	7f e7                	jg     800e3d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e56:	e9 66 01 00 00       	jmp    800fc1 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e5b:	83 ec 08             	sub    $0x8,%esp
  800e5e:	ff 75 e8             	pushl  -0x18(%ebp)
  800e61:	8d 45 14             	lea    0x14(%ebp),%eax
  800e64:	50                   	push   %eax
  800e65:	e8 3c fd ff ff       	call   800ba6 <getint>
  800e6a:	83 c4 10             	add    $0x10,%esp
  800e6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e70:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e73:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e76:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e79:	85 d2                	test   %edx,%edx
  800e7b:	79 23                	jns    800ea0 <vprintfmt+0x29b>
				putch('-', putdat);
  800e7d:	83 ec 08             	sub    $0x8,%esp
  800e80:	ff 75 0c             	pushl  0xc(%ebp)
  800e83:	6a 2d                	push   $0x2d
  800e85:	8b 45 08             	mov    0x8(%ebp),%eax
  800e88:	ff d0                	call   *%eax
  800e8a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e90:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e93:	f7 d8                	neg    %eax
  800e95:	83 d2 00             	adc    $0x0,%edx
  800e98:	f7 da                	neg    %edx
  800e9a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e9d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ea0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ea7:	e9 bc 00 00 00       	jmp    800f68 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800eac:	83 ec 08             	sub    $0x8,%esp
  800eaf:	ff 75 e8             	pushl  -0x18(%ebp)
  800eb2:	8d 45 14             	lea    0x14(%ebp),%eax
  800eb5:	50                   	push   %eax
  800eb6:	e8 84 fc ff ff       	call   800b3f <getuint>
  800ebb:	83 c4 10             	add    $0x10,%esp
  800ebe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ec1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ec4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ecb:	e9 98 00 00 00       	jmp    800f68 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800ed0:	83 ec 08             	sub    $0x8,%esp
  800ed3:	ff 75 0c             	pushl  0xc(%ebp)
  800ed6:	6a 58                	push   $0x58
  800ed8:	8b 45 08             	mov    0x8(%ebp),%eax
  800edb:	ff d0                	call   *%eax
  800edd:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ee0:	83 ec 08             	sub    $0x8,%esp
  800ee3:	ff 75 0c             	pushl  0xc(%ebp)
  800ee6:	6a 58                	push   $0x58
  800ee8:	8b 45 08             	mov    0x8(%ebp),%eax
  800eeb:	ff d0                	call   *%eax
  800eed:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ef0:	83 ec 08             	sub    $0x8,%esp
  800ef3:	ff 75 0c             	pushl  0xc(%ebp)
  800ef6:	6a 58                	push   $0x58
  800ef8:	8b 45 08             	mov    0x8(%ebp),%eax
  800efb:	ff d0                	call   *%eax
  800efd:	83 c4 10             	add    $0x10,%esp
			break;
  800f00:	e9 bc 00 00 00       	jmp    800fc1 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f05:	83 ec 08             	sub    $0x8,%esp
  800f08:	ff 75 0c             	pushl  0xc(%ebp)
  800f0b:	6a 30                	push   $0x30
  800f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f10:	ff d0                	call   *%eax
  800f12:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f15:	83 ec 08             	sub    $0x8,%esp
  800f18:	ff 75 0c             	pushl  0xc(%ebp)
  800f1b:	6a 78                	push   $0x78
  800f1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f20:	ff d0                	call   *%eax
  800f22:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f25:	8b 45 14             	mov    0x14(%ebp),%eax
  800f28:	83 c0 04             	add    $0x4,%eax
  800f2b:	89 45 14             	mov    %eax,0x14(%ebp)
  800f2e:	8b 45 14             	mov    0x14(%ebp),%eax
  800f31:	83 e8 04             	sub    $0x4,%eax
  800f34:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f36:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f39:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f40:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f47:	eb 1f                	jmp    800f68 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f49:	83 ec 08             	sub    $0x8,%esp
  800f4c:	ff 75 e8             	pushl  -0x18(%ebp)
  800f4f:	8d 45 14             	lea    0x14(%ebp),%eax
  800f52:	50                   	push   %eax
  800f53:	e8 e7 fb ff ff       	call   800b3f <getuint>
  800f58:	83 c4 10             	add    $0x10,%esp
  800f5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f5e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f61:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f68:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f6f:	83 ec 04             	sub    $0x4,%esp
  800f72:	52                   	push   %edx
  800f73:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f76:	50                   	push   %eax
  800f77:	ff 75 f4             	pushl  -0xc(%ebp)
  800f7a:	ff 75 f0             	pushl  -0x10(%ebp)
  800f7d:	ff 75 0c             	pushl  0xc(%ebp)
  800f80:	ff 75 08             	pushl  0x8(%ebp)
  800f83:	e8 00 fb ff ff       	call   800a88 <printnum>
  800f88:	83 c4 20             	add    $0x20,%esp
			break;
  800f8b:	eb 34                	jmp    800fc1 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f8d:	83 ec 08             	sub    $0x8,%esp
  800f90:	ff 75 0c             	pushl  0xc(%ebp)
  800f93:	53                   	push   %ebx
  800f94:	8b 45 08             	mov    0x8(%ebp),%eax
  800f97:	ff d0                	call   *%eax
  800f99:	83 c4 10             	add    $0x10,%esp
			break;
  800f9c:	eb 23                	jmp    800fc1 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f9e:	83 ec 08             	sub    $0x8,%esp
  800fa1:	ff 75 0c             	pushl  0xc(%ebp)
  800fa4:	6a 25                	push   $0x25
  800fa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa9:	ff d0                	call   *%eax
  800fab:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800fae:	ff 4d 10             	decl   0x10(%ebp)
  800fb1:	eb 03                	jmp    800fb6 <vprintfmt+0x3b1>
  800fb3:	ff 4d 10             	decl   0x10(%ebp)
  800fb6:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb9:	48                   	dec    %eax
  800fba:	8a 00                	mov    (%eax),%al
  800fbc:	3c 25                	cmp    $0x25,%al
  800fbe:	75 f3                	jne    800fb3 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800fc0:	90                   	nop
		}
	}
  800fc1:	e9 47 fc ff ff       	jmp    800c0d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800fc6:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800fc7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800fca:	5b                   	pop    %ebx
  800fcb:	5e                   	pop    %esi
  800fcc:	5d                   	pop    %ebp
  800fcd:	c3                   	ret    

00800fce <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800fce:	55                   	push   %ebp
  800fcf:	89 e5                	mov    %esp,%ebp
  800fd1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800fd4:	8d 45 10             	lea    0x10(%ebp),%eax
  800fd7:	83 c0 04             	add    $0x4,%eax
  800fda:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800fdd:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe0:	ff 75 f4             	pushl  -0xc(%ebp)
  800fe3:	50                   	push   %eax
  800fe4:	ff 75 0c             	pushl  0xc(%ebp)
  800fe7:	ff 75 08             	pushl  0x8(%ebp)
  800fea:	e8 16 fc ff ff       	call   800c05 <vprintfmt>
  800fef:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ff2:	90                   	nop
  800ff3:	c9                   	leave  
  800ff4:	c3                   	ret    

00800ff5 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ff5:	55                   	push   %ebp
  800ff6:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ff8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffb:	8b 40 08             	mov    0x8(%eax),%eax
  800ffe:	8d 50 01             	lea    0x1(%eax),%edx
  801001:	8b 45 0c             	mov    0xc(%ebp),%eax
  801004:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801007:	8b 45 0c             	mov    0xc(%ebp),%eax
  80100a:	8b 10                	mov    (%eax),%edx
  80100c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80100f:	8b 40 04             	mov    0x4(%eax),%eax
  801012:	39 c2                	cmp    %eax,%edx
  801014:	73 12                	jae    801028 <sprintputch+0x33>
		*b->buf++ = ch;
  801016:	8b 45 0c             	mov    0xc(%ebp),%eax
  801019:	8b 00                	mov    (%eax),%eax
  80101b:	8d 48 01             	lea    0x1(%eax),%ecx
  80101e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801021:	89 0a                	mov    %ecx,(%edx)
  801023:	8b 55 08             	mov    0x8(%ebp),%edx
  801026:	88 10                	mov    %dl,(%eax)
}
  801028:	90                   	nop
  801029:	5d                   	pop    %ebp
  80102a:	c3                   	ret    

0080102b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80102b:	55                   	push   %ebp
  80102c:	89 e5                	mov    %esp,%ebp
  80102e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801031:	8b 45 08             	mov    0x8(%ebp),%eax
  801034:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801037:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80103d:	8b 45 08             	mov    0x8(%ebp),%eax
  801040:	01 d0                	add    %edx,%eax
  801042:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801045:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80104c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801050:	74 06                	je     801058 <vsnprintf+0x2d>
  801052:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801056:	7f 07                	jg     80105f <vsnprintf+0x34>
		return -E_INVAL;
  801058:	b8 03 00 00 00       	mov    $0x3,%eax
  80105d:	eb 20                	jmp    80107f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80105f:	ff 75 14             	pushl  0x14(%ebp)
  801062:	ff 75 10             	pushl  0x10(%ebp)
  801065:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801068:	50                   	push   %eax
  801069:	68 f5 0f 80 00       	push   $0x800ff5
  80106e:	e8 92 fb ff ff       	call   800c05 <vprintfmt>
  801073:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801076:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801079:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80107c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80107f:	c9                   	leave  
  801080:	c3                   	ret    

00801081 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801081:	55                   	push   %ebp
  801082:	89 e5                	mov    %esp,%ebp
  801084:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801087:	8d 45 10             	lea    0x10(%ebp),%eax
  80108a:	83 c0 04             	add    $0x4,%eax
  80108d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801090:	8b 45 10             	mov    0x10(%ebp),%eax
  801093:	ff 75 f4             	pushl  -0xc(%ebp)
  801096:	50                   	push   %eax
  801097:	ff 75 0c             	pushl  0xc(%ebp)
  80109a:	ff 75 08             	pushl  0x8(%ebp)
  80109d:	e8 89 ff ff ff       	call   80102b <vsnprintf>
  8010a2:	83 c4 10             	add    $0x10,%esp
  8010a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8010a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010ab:	c9                   	leave  
  8010ac:	c3                   	ret    

008010ad <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8010ad:	55                   	push   %ebp
  8010ae:	89 e5                	mov    %esp,%ebp
  8010b0:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8010b3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010b7:	74 13                	je     8010cc <readline+0x1f>
		cprintf("%s", prompt);
  8010b9:	83 ec 08             	sub    $0x8,%esp
  8010bc:	ff 75 08             	pushl  0x8(%ebp)
  8010bf:	68 50 2d 80 00       	push   $0x802d50
  8010c4:	e8 62 f9 ff ff       	call   800a2b <cprintf>
  8010c9:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8010cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8010d3:	83 ec 0c             	sub    $0xc,%esp
  8010d6:	6a 00                	push   $0x0
  8010d8:	e8 5d f5 ff ff       	call   80063a <iscons>
  8010dd:	83 c4 10             	add    $0x10,%esp
  8010e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8010e3:	e8 04 f5 ff ff       	call   8005ec <getchar>
  8010e8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8010eb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8010ef:	79 22                	jns    801113 <readline+0x66>
			if (c != -E_EOF)
  8010f1:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8010f5:	0f 84 ad 00 00 00    	je     8011a8 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8010fb:	83 ec 08             	sub    $0x8,%esp
  8010fe:	ff 75 ec             	pushl  -0x14(%ebp)
  801101:	68 53 2d 80 00       	push   $0x802d53
  801106:	e8 20 f9 ff ff       	call   800a2b <cprintf>
  80110b:	83 c4 10             	add    $0x10,%esp
			return;
  80110e:	e9 95 00 00 00       	jmp    8011a8 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801113:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801117:	7e 34                	jle    80114d <readline+0xa0>
  801119:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801120:	7f 2b                	jg     80114d <readline+0xa0>
			if (echoing)
  801122:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801126:	74 0e                	je     801136 <readline+0x89>
				cputchar(c);
  801128:	83 ec 0c             	sub    $0xc,%esp
  80112b:	ff 75 ec             	pushl  -0x14(%ebp)
  80112e:	e8 71 f4 ff ff       	call   8005a4 <cputchar>
  801133:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801136:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801139:	8d 50 01             	lea    0x1(%eax),%edx
  80113c:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80113f:	89 c2                	mov    %eax,%edx
  801141:	8b 45 0c             	mov    0xc(%ebp),%eax
  801144:	01 d0                	add    %edx,%eax
  801146:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801149:	88 10                	mov    %dl,(%eax)
  80114b:	eb 56                	jmp    8011a3 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  80114d:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801151:	75 1f                	jne    801172 <readline+0xc5>
  801153:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801157:	7e 19                	jle    801172 <readline+0xc5>
			if (echoing)
  801159:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80115d:	74 0e                	je     80116d <readline+0xc0>
				cputchar(c);
  80115f:	83 ec 0c             	sub    $0xc,%esp
  801162:	ff 75 ec             	pushl  -0x14(%ebp)
  801165:	e8 3a f4 ff ff       	call   8005a4 <cputchar>
  80116a:	83 c4 10             	add    $0x10,%esp

			i--;
  80116d:	ff 4d f4             	decl   -0xc(%ebp)
  801170:	eb 31                	jmp    8011a3 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  801172:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801176:	74 0a                	je     801182 <readline+0xd5>
  801178:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80117c:	0f 85 61 ff ff ff    	jne    8010e3 <readline+0x36>
			if (echoing)
  801182:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801186:	74 0e                	je     801196 <readline+0xe9>
				cputchar(c);
  801188:	83 ec 0c             	sub    $0xc,%esp
  80118b:	ff 75 ec             	pushl  -0x14(%ebp)
  80118e:	e8 11 f4 ff ff       	call   8005a4 <cputchar>
  801193:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801196:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801199:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119c:	01 d0                	add    %edx,%eax
  80119e:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8011a1:	eb 06                	jmp    8011a9 <readline+0xfc>
		}
	}
  8011a3:	e9 3b ff ff ff       	jmp    8010e3 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8011a8:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8011a9:	c9                   	leave  
  8011aa:	c3                   	ret    

008011ab <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8011ab:	55                   	push   %ebp
  8011ac:	89 e5                	mov    %esp,%ebp
  8011ae:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8011b1:	e8 bc 0d 00 00       	call   801f72 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8011b6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011ba:	74 13                	je     8011cf <atomic_readline+0x24>
		cprintf("%s", prompt);
  8011bc:	83 ec 08             	sub    $0x8,%esp
  8011bf:	ff 75 08             	pushl  0x8(%ebp)
  8011c2:	68 50 2d 80 00       	push   $0x802d50
  8011c7:	e8 5f f8 ff ff       	call   800a2b <cprintf>
  8011cc:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8011cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8011d6:	83 ec 0c             	sub    $0xc,%esp
  8011d9:	6a 00                	push   $0x0
  8011db:	e8 5a f4 ff ff       	call   80063a <iscons>
  8011e0:	83 c4 10             	add    $0x10,%esp
  8011e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8011e6:	e8 01 f4 ff ff       	call   8005ec <getchar>
  8011eb:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8011ee:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8011f2:	79 23                	jns    801217 <atomic_readline+0x6c>
			if (c != -E_EOF)
  8011f4:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8011f8:	74 13                	je     80120d <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8011fa:	83 ec 08             	sub    $0x8,%esp
  8011fd:	ff 75 ec             	pushl  -0x14(%ebp)
  801200:	68 53 2d 80 00       	push   $0x802d53
  801205:	e8 21 f8 ff ff       	call   800a2b <cprintf>
  80120a:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80120d:	e8 7a 0d 00 00       	call   801f8c <sys_enable_interrupt>
			return;
  801212:	e9 9a 00 00 00       	jmp    8012b1 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801217:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80121b:	7e 34                	jle    801251 <atomic_readline+0xa6>
  80121d:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801224:	7f 2b                	jg     801251 <atomic_readline+0xa6>
			if (echoing)
  801226:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80122a:	74 0e                	je     80123a <atomic_readline+0x8f>
				cputchar(c);
  80122c:	83 ec 0c             	sub    $0xc,%esp
  80122f:	ff 75 ec             	pushl  -0x14(%ebp)
  801232:	e8 6d f3 ff ff       	call   8005a4 <cputchar>
  801237:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80123a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80123d:	8d 50 01             	lea    0x1(%eax),%edx
  801240:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801243:	89 c2                	mov    %eax,%edx
  801245:	8b 45 0c             	mov    0xc(%ebp),%eax
  801248:	01 d0                	add    %edx,%eax
  80124a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80124d:	88 10                	mov    %dl,(%eax)
  80124f:	eb 5b                	jmp    8012ac <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  801251:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801255:	75 1f                	jne    801276 <atomic_readline+0xcb>
  801257:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80125b:	7e 19                	jle    801276 <atomic_readline+0xcb>
			if (echoing)
  80125d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801261:	74 0e                	je     801271 <atomic_readline+0xc6>
				cputchar(c);
  801263:	83 ec 0c             	sub    $0xc,%esp
  801266:	ff 75 ec             	pushl  -0x14(%ebp)
  801269:	e8 36 f3 ff ff       	call   8005a4 <cputchar>
  80126e:	83 c4 10             	add    $0x10,%esp
			i--;
  801271:	ff 4d f4             	decl   -0xc(%ebp)
  801274:	eb 36                	jmp    8012ac <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801276:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80127a:	74 0a                	je     801286 <atomic_readline+0xdb>
  80127c:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801280:	0f 85 60 ff ff ff    	jne    8011e6 <atomic_readline+0x3b>
			if (echoing)
  801286:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80128a:	74 0e                	je     80129a <atomic_readline+0xef>
				cputchar(c);
  80128c:	83 ec 0c             	sub    $0xc,%esp
  80128f:	ff 75 ec             	pushl  -0x14(%ebp)
  801292:	e8 0d f3 ff ff       	call   8005a4 <cputchar>
  801297:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  80129a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80129d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a0:	01 d0                	add    %edx,%eax
  8012a2:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8012a5:	e8 e2 0c 00 00       	call   801f8c <sys_enable_interrupt>
			return;
  8012aa:	eb 05                	jmp    8012b1 <atomic_readline+0x106>
		}
	}
  8012ac:	e9 35 ff ff ff       	jmp    8011e6 <atomic_readline+0x3b>
}
  8012b1:	c9                   	leave  
  8012b2:	c3                   	ret    

008012b3 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8012b3:	55                   	push   %ebp
  8012b4:	89 e5                	mov    %esp,%ebp
  8012b6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8012b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012c0:	eb 06                	jmp    8012c8 <strlen+0x15>
		n++;
  8012c2:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8012c5:	ff 45 08             	incl   0x8(%ebp)
  8012c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cb:	8a 00                	mov    (%eax),%al
  8012cd:	84 c0                	test   %al,%al
  8012cf:	75 f1                	jne    8012c2 <strlen+0xf>
		n++;
	return n;
  8012d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012d4:	c9                   	leave  
  8012d5:	c3                   	ret    

008012d6 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8012d6:	55                   	push   %ebp
  8012d7:	89 e5                	mov    %esp,%ebp
  8012d9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012e3:	eb 09                	jmp    8012ee <strnlen+0x18>
		n++;
  8012e5:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012e8:	ff 45 08             	incl   0x8(%ebp)
  8012eb:	ff 4d 0c             	decl   0xc(%ebp)
  8012ee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012f2:	74 09                	je     8012fd <strnlen+0x27>
  8012f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f7:	8a 00                	mov    (%eax),%al
  8012f9:	84 c0                	test   %al,%al
  8012fb:	75 e8                	jne    8012e5 <strnlen+0xf>
		n++;
	return n;
  8012fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801300:	c9                   	leave  
  801301:	c3                   	ret    

00801302 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801302:	55                   	push   %ebp
  801303:	89 e5                	mov    %esp,%ebp
  801305:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801308:	8b 45 08             	mov    0x8(%ebp),%eax
  80130b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80130e:	90                   	nop
  80130f:	8b 45 08             	mov    0x8(%ebp),%eax
  801312:	8d 50 01             	lea    0x1(%eax),%edx
  801315:	89 55 08             	mov    %edx,0x8(%ebp)
  801318:	8b 55 0c             	mov    0xc(%ebp),%edx
  80131b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80131e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801321:	8a 12                	mov    (%edx),%dl
  801323:	88 10                	mov    %dl,(%eax)
  801325:	8a 00                	mov    (%eax),%al
  801327:	84 c0                	test   %al,%al
  801329:	75 e4                	jne    80130f <strcpy+0xd>
		/* do nothing */;
	return ret;
  80132b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80132e:	c9                   	leave  
  80132f:	c3                   	ret    

00801330 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801330:	55                   	push   %ebp
  801331:	89 e5                	mov    %esp,%ebp
  801333:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801336:	8b 45 08             	mov    0x8(%ebp),%eax
  801339:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80133c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801343:	eb 1f                	jmp    801364 <strncpy+0x34>
		*dst++ = *src;
  801345:	8b 45 08             	mov    0x8(%ebp),%eax
  801348:	8d 50 01             	lea    0x1(%eax),%edx
  80134b:	89 55 08             	mov    %edx,0x8(%ebp)
  80134e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801351:	8a 12                	mov    (%edx),%dl
  801353:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801355:	8b 45 0c             	mov    0xc(%ebp),%eax
  801358:	8a 00                	mov    (%eax),%al
  80135a:	84 c0                	test   %al,%al
  80135c:	74 03                	je     801361 <strncpy+0x31>
			src++;
  80135e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801361:	ff 45 fc             	incl   -0x4(%ebp)
  801364:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801367:	3b 45 10             	cmp    0x10(%ebp),%eax
  80136a:	72 d9                	jb     801345 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80136c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80136f:	c9                   	leave  
  801370:	c3                   	ret    

00801371 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801371:	55                   	push   %ebp
  801372:	89 e5                	mov    %esp,%ebp
  801374:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801377:	8b 45 08             	mov    0x8(%ebp),%eax
  80137a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80137d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801381:	74 30                	je     8013b3 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801383:	eb 16                	jmp    80139b <strlcpy+0x2a>
			*dst++ = *src++;
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	8d 50 01             	lea    0x1(%eax),%edx
  80138b:	89 55 08             	mov    %edx,0x8(%ebp)
  80138e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801391:	8d 4a 01             	lea    0x1(%edx),%ecx
  801394:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801397:	8a 12                	mov    (%edx),%dl
  801399:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80139b:	ff 4d 10             	decl   0x10(%ebp)
  80139e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013a2:	74 09                	je     8013ad <strlcpy+0x3c>
  8013a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a7:	8a 00                	mov    (%eax),%al
  8013a9:	84 c0                	test   %al,%al
  8013ab:	75 d8                	jne    801385 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8013ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b0:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8013b3:	8b 55 08             	mov    0x8(%ebp),%edx
  8013b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013b9:	29 c2                	sub    %eax,%edx
  8013bb:	89 d0                	mov    %edx,%eax
}
  8013bd:	c9                   	leave  
  8013be:	c3                   	ret    

008013bf <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8013bf:	55                   	push   %ebp
  8013c0:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8013c2:	eb 06                	jmp    8013ca <strcmp+0xb>
		p++, q++;
  8013c4:	ff 45 08             	incl   0x8(%ebp)
  8013c7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	8a 00                	mov    (%eax),%al
  8013cf:	84 c0                	test   %al,%al
  8013d1:	74 0e                	je     8013e1 <strcmp+0x22>
  8013d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d6:	8a 10                	mov    (%eax),%dl
  8013d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013db:	8a 00                	mov    (%eax),%al
  8013dd:	38 c2                	cmp    %al,%dl
  8013df:	74 e3                	je     8013c4 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8013e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e4:	8a 00                	mov    (%eax),%al
  8013e6:	0f b6 d0             	movzbl %al,%edx
  8013e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ec:	8a 00                	mov    (%eax),%al
  8013ee:	0f b6 c0             	movzbl %al,%eax
  8013f1:	29 c2                	sub    %eax,%edx
  8013f3:	89 d0                	mov    %edx,%eax
}
  8013f5:	5d                   	pop    %ebp
  8013f6:	c3                   	ret    

008013f7 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8013f7:	55                   	push   %ebp
  8013f8:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8013fa:	eb 09                	jmp    801405 <strncmp+0xe>
		n--, p++, q++;
  8013fc:	ff 4d 10             	decl   0x10(%ebp)
  8013ff:	ff 45 08             	incl   0x8(%ebp)
  801402:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801405:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801409:	74 17                	je     801422 <strncmp+0x2b>
  80140b:	8b 45 08             	mov    0x8(%ebp),%eax
  80140e:	8a 00                	mov    (%eax),%al
  801410:	84 c0                	test   %al,%al
  801412:	74 0e                	je     801422 <strncmp+0x2b>
  801414:	8b 45 08             	mov    0x8(%ebp),%eax
  801417:	8a 10                	mov    (%eax),%dl
  801419:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141c:	8a 00                	mov    (%eax),%al
  80141e:	38 c2                	cmp    %al,%dl
  801420:	74 da                	je     8013fc <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801422:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801426:	75 07                	jne    80142f <strncmp+0x38>
		return 0;
  801428:	b8 00 00 00 00       	mov    $0x0,%eax
  80142d:	eb 14                	jmp    801443 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80142f:	8b 45 08             	mov    0x8(%ebp),%eax
  801432:	8a 00                	mov    (%eax),%al
  801434:	0f b6 d0             	movzbl %al,%edx
  801437:	8b 45 0c             	mov    0xc(%ebp),%eax
  80143a:	8a 00                	mov    (%eax),%al
  80143c:	0f b6 c0             	movzbl %al,%eax
  80143f:	29 c2                	sub    %eax,%edx
  801441:	89 d0                	mov    %edx,%eax
}
  801443:	5d                   	pop    %ebp
  801444:	c3                   	ret    

00801445 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801445:	55                   	push   %ebp
  801446:	89 e5                	mov    %esp,%ebp
  801448:	83 ec 04             	sub    $0x4,%esp
  80144b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80144e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801451:	eb 12                	jmp    801465 <strchr+0x20>
		if (*s == c)
  801453:	8b 45 08             	mov    0x8(%ebp),%eax
  801456:	8a 00                	mov    (%eax),%al
  801458:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80145b:	75 05                	jne    801462 <strchr+0x1d>
			return (char *) s;
  80145d:	8b 45 08             	mov    0x8(%ebp),%eax
  801460:	eb 11                	jmp    801473 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801462:	ff 45 08             	incl   0x8(%ebp)
  801465:	8b 45 08             	mov    0x8(%ebp),%eax
  801468:	8a 00                	mov    (%eax),%al
  80146a:	84 c0                	test   %al,%al
  80146c:	75 e5                	jne    801453 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80146e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801473:	c9                   	leave  
  801474:	c3                   	ret    

00801475 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801475:	55                   	push   %ebp
  801476:	89 e5                	mov    %esp,%ebp
  801478:	83 ec 04             	sub    $0x4,%esp
  80147b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801481:	eb 0d                	jmp    801490 <strfind+0x1b>
		if (*s == c)
  801483:	8b 45 08             	mov    0x8(%ebp),%eax
  801486:	8a 00                	mov    (%eax),%al
  801488:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80148b:	74 0e                	je     80149b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80148d:	ff 45 08             	incl   0x8(%ebp)
  801490:	8b 45 08             	mov    0x8(%ebp),%eax
  801493:	8a 00                	mov    (%eax),%al
  801495:	84 c0                	test   %al,%al
  801497:	75 ea                	jne    801483 <strfind+0xe>
  801499:	eb 01                	jmp    80149c <strfind+0x27>
		if (*s == c)
			break;
  80149b:	90                   	nop
	return (char *) s;
  80149c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80149f:	c9                   	leave  
  8014a0:	c3                   	ret    

008014a1 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8014a1:	55                   	push   %ebp
  8014a2:	89 e5                	mov    %esp,%ebp
  8014a4:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8014a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8014ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8014b3:	eb 0e                	jmp    8014c3 <memset+0x22>
		*p++ = c;
  8014b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014b8:	8d 50 01             	lea    0x1(%eax),%edx
  8014bb:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014c1:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8014c3:	ff 4d f8             	decl   -0x8(%ebp)
  8014c6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8014ca:	79 e9                	jns    8014b5 <memset+0x14>
		*p++ = c;

	return v;
  8014cc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014cf:	c9                   	leave  
  8014d0:	c3                   	ret    

008014d1 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8014d1:	55                   	push   %ebp
  8014d2:	89 e5                	mov    %esp,%ebp
  8014d4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014da:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8014e3:	eb 16                	jmp    8014fb <memcpy+0x2a>
		*d++ = *s++;
  8014e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014e8:	8d 50 01             	lea    0x1(%eax),%edx
  8014eb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014f1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014f4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014f7:	8a 12                	mov    (%edx),%dl
  8014f9:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8014fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8014fe:	8d 50 ff             	lea    -0x1(%eax),%edx
  801501:	89 55 10             	mov    %edx,0x10(%ebp)
  801504:	85 c0                	test   %eax,%eax
  801506:	75 dd                	jne    8014e5 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801508:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80150b:	c9                   	leave  
  80150c:	c3                   	ret    

0080150d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80150d:	55                   	push   %ebp
  80150e:	89 e5                	mov    %esp,%ebp
  801510:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801513:	8b 45 0c             	mov    0xc(%ebp),%eax
  801516:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801519:	8b 45 08             	mov    0x8(%ebp),%eax
  80151c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80151f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801522:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801525:	73 50                	jae    801577 <memmove+0x6a>
  801527:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80152a:	8b 45 10             	mov    0x10(%ebp),%eax
  80152d:	01 d0                	add    %edx,%eax
  80152f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801532:	76 43                	jbe    801577 <memmove+0x6a>
		s += n;
  801534:	8b 45 10             	mov    0x10(%ebp),%eax
  801537:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80153a:	8b 45 10             	mov    0x10(%ebp),%eax
  80153d:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801540:	eb 10                	jmp    801552 <memmove+0x45>
			*--d = *--s;
  801542:	ff 4d f8             	decl   -0x8(%ebp)
  801545:	ff 4d fc             	decl   -0x4(%ebp)
  801548:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80154b:	8a 10                	mov    (%eax),%dl
  80154d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801550:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801552:	8b 45 10             	mov    0x10(%ebp),%eax
  801555:	8d 50 ff             	lea    -0x1(%eax),%edx
  801558:	89 55 10             	mov    %edx,0x10(%ebp)
  80155b:	85 c0                	test   %eax,%eax
  80155d:	75 e3                	jne    801542 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80155f:	eb 23                	jmp    801584 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801561:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801564:	8d 50 01             	lea    0x1(%eax),%edx
  801567:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80156a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80156d:	8d 4a 01             	lea    0x1(%edx),%ecx
  801570:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801573:	8a 12                	mov    (%edx),%dl
  801575:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801577:	8b 45 10             	mov    0x10(%ebp),%eax
  80157a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80157d:	89 55 10             	mov    %edx,0x10(%ebp)
  801580:	85 c0                	test   %eax,%eax
  801582:	75 dd                	jne    801561 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801584:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801587:	c9                   	leave  
  801588:	c3                   	ret    

00801589 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801589:	55                   	push   %ebp
  80158a:	89 e5                	mov    %esp,%ebp
  80158c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80158f:	8b 45 08             	mov    0x8(%ebp),%eax
  801592:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801595:	8b 45 0c             	mov    0xc(%ebp),%eax
  801598:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80159b:	eb 2a                	jmp    8015c7 <memcmp+0x3e>
		if (*s1 != *s2)
  80159d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015a0:	8a 10                	mov    (%eax),%dl
  8015a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015a5:	8a 00                	mov    (%eax),%al
  8015a7:	38 c2                	cmp    %al,%dl
  8015a9:	74 16                	je     8015c1 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8015ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ae:	8a 00                	mov    (%eax),%al
  8015b0:	0f b6 d0             	movzbl %al,%edx
  8015b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015b6:	8a 00                	mov    (%eax),%al
  8015b8:	0f b6 c0             	movzbl %al,%eax
  8015bb:	29 c2                	sub    %eax,%edx
  8015bd:	89 d0                	mov    %edx,%eax
  8015bf:	eb 18                	jmp    8015d9 <memcmp+0x50>
		s1++, s2++;
  8015c1:	ff 45 fc             	incl   -0x4(%ebp)
  8015c4:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ca:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015cd:	89 55 10             	mov    %edx,0x10(%ebp)
  8015d0:	85 c0                	test   %eax,%eax
  8015d2:	75 c9                	jne    80159d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8015d4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d9:	c9                   	leave  
  8015da:	c3                   	ret    

008015db <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8015db:	55                   	push   %ebp
  8015dc:	89 e5                	mov    %esp,%ebp
  8015de:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8015e1:	8b 55 08             	mov    0x8(%ebp),%edx
  8015e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015e7:	01 d0                	add    %edx,%eax
  8015e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8015ec:	eb 15                	jmp    801603 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8015ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f1:	8a 00                	mov    (%eax),%al
  8015f3:	0f b6 d0             	movzbl %al,%edx
  8015f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015f9:	0f b6 c0             	movzbl %al,%eax
  8015fc:	39 c2                	cmp    %eax,%edx
  8015fe:	74 0d                	je     80160d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801600:	ff 45 08             	incl   0x8(%ebp)
  801603:	8b 45 08             	mov    0x8(%ebp),%eax
  801606:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801609:	72 e3                	jb     8015ee <memfind+0x13>
  80160b:	eb 01                	jmp    80160e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80160d:	90                   	nop
	return (void *) s;
  80160e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801611:	c9                   	leave  
  801612:	c3                   	ret    

00801613 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801613:	55                   	push   %ebp
  801614:	89 e5                	mov    %esp,%ebp
  801616:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801619:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801620:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801627:	eb 03                	jmp    80162c <strtol+0x19>
		s++;
  801629:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80162c:	8b 45 08             	mov    0x8(%ebp),%eax
  80162f:	8a 00                	mov    (%eax),%al
  801631:	3c 20                	cmp    $0x20,%al
  801633:	74 f4                	je     801629 <strtol+0x16>
  801635:	8b 45 08             	mov    0x8(%ebp),%eax
  801638:	8a 00                	mov    (%eax),%al
  80163a:	3c 09                	cmp    $0x9,%al
  80163c:	74 eb                	je     801629 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80163e:	8b 45 08             	mov    0x8(%ebp),%eax
  801641:	8a 00                	mov    (%eax),%al
  801643:	3c 2b                	cmp    $0x2b,%al
  801645:	75 05                	jne    80164c <strtol+0x39>
		s++;
  801647:	ff 45 08             	incl   0x8(%ebp)
  80164a:	eb 13                	jmp    80165f <strtol+0x4c>
	else if (*s == '-')
  80164c:	8b 45 08             	mov    0x8(%ebp),%eax
  80164f:	8a 00                	mov    (%eax),%al
  801651:	3c 2d                	cmp    $0x2d,%al
  801653:	75 0a                	jne    80165f <strtol+0x4c>
		s++, neg = 1;
  801655:	ff 45 08             	incl   0x8(%ebp)
  801658:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80165f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801663:	74 06                	je     80166b <strtol+0x58>
  801665:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801669:	75 20                	jne    80168b <strtol+0x78>
  80166b:	8b 45 08             	mov    0x8(%ebp),%eax
  80166e:	8a 00                	mov    (%eax),%al
  801670:	3c 30                	cmp    $0x30,%al
  801672:	75 17                	jne    80168b <strtol+0x78>
  801674:	8b 45 08             	mov    0x8(%ebp),%eax
  801677:	40                   	inc    %eax
  801678:	8a 00                	mov    (%eax),%al
  80167a:	3c 78                	cmp    $0x78,%al
  80167c:	75 0d                	jne    80168b <strtol+0x78>
		s += 2, base = 16;
  80167e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801682:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801689:	eb 28                	jmp    8016b3 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80168b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80168f:	75 15                	jne    8016a6 <strtol+0x93>
  801691:	8b 45 08             	mov    0x8(%ebp),%eax
  801694:	8a 00                	mov    (%eax),%al
  801696:	3c 30                	cmp    $0x30,%al
  801698:	75 0c                	jne    8016a6 <strtol+0x93>
		s++, base = 8;
  80169a:	ff 45 08             	incl   0x8(%ebp)
  80169d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8016a4:	eb 0d                	jmp    8016b3 <strtol+0xa0>
	else if (base == 0)
  8016a6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016aa:	75 07                	jne    8016b3 <strtol+0xa0>
		base = 10;
  8016ac:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8016b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b6:	8a 00                	mov    (%eax),%al
  8016b8:	3c 2f                	cmp    $0x2f,%al
  8016ba:	7e 19                	jle    8016d5 <strtol+0xc2>
  8016bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bf:	8a 00                	mov    (%eax),%al
  8016c1:	3c 39                	cmp    $0x39,%al
  8016c3:	7f 10                	jg     8016d5 <strtol+0xc2>
			dig = *s - '0';
  8016c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c8:	8a 00                	mov    (%eax),%al
  8016ca:	0f be c0             	movsbl %al,%eax
  8016cd:	83 e8 30             	sub    $0x30,%eax
  8016d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016d3:	eb 42                	jmp    801717 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8016d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d8:	8a 00                	mov    (%eax),%al
  8016da:	3c 60                	cmp    $0x60,%al
  8016dc:	7e 19                	jle    8016f7 <strtol+0xe4>
  8016de:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e1:	8a 00                	mov    (%eax),%al
  8016e3:	3c 7a                	cmp    $0x7a,%al
  8016e5:	7f 10                	jg     8016f7 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8016e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ea:	8a 00                	mov    (%eax),%al
  8016ec:	0f be c0             	movsbl %al,%eax
  8016ef:	83 e8 57             	sub    $0x57,%eax
  8016f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016f5:	eb 20                	jmp    801717 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fa:	8a 00                	mov    (%eax),%al
  8016fc:	3c 40                	cmp    $0x40,%al
  8016fe:	7e 39                	jle    801739 <strtol+0x126>
  801700:	8b 45 08             	mov    0x8(%ebp),%eax
  801703:	8a 00                	mov    (%eax),%al
  801705:	3c 5a                	cmp    $0x5a,%al
  801707:	7f 30                	jg     801739 <strtol+0x126>
			dig = *s - 'A' + 10;
  801709:	8b 45 08             	mov    0x8(%ebp),%eax
  80170c:	8a 00                	mov    (%eax),%al
  80170e:	0f be c0             	movsbl %al,%eax
  801711:	83 e8 37             	sub    $0x37,%eax
  801714:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801717:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80171a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80171d:	7d 19                	jge    801738 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80171f:	ff 45 08             	incl   0x8(%ebp)
  801722:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801725:	0f af 45 10          	imul   0x10(%ebp),%eax
  801729:	89 c2                	mov    %eax,%edx
  80172b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80172e:	01 d0                	add    %edx,%eax
  801730:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801733:	e9 7b ff ff ff       	jmp    8016b3 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801738:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801739:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80173d:	74 08                	je     801747 <strtol+0x134>
		*endptr = (char *) s;
  80173f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801742:	8b 55 08             	mov    0x8(%ebp),%edx
  801745:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801747:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80174b:	74 07                	je     801754 <strtol+0x141>
  80174d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801750:	f7 d8                	neg    %eax
  801752:	eb 03                	jmp    801757 <strtol+0x144>
  801754:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801757:	c9                   	leave  
  801758:	c3                   	ret    

00801759 <ltostr>:

void
ltostr(long value, char *str)
{
  801759:	55                   	push   %ebp
  80175a:	89 e5                	mov    %esp,%ebp
  80175c:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80175f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801766:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80176d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801771:	79 13                	jns    801786 <ltostr+0x2d>
	{
		neg = 1;
  801773:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80177a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80177d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801780:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801783:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801786:	8b 45 08             	mov    0x8(%ebp),%eax
  801789:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80178e:	99                   	cltd   
  80178f:	f7 f9                	idiv   %ecx
  801791:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801794:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801797:	8d 50 01             	lea    0x1(%eax),%edx
  80179a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80179d:	89 c2                	mov    %eax,%edx
  80179f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a2:	01 d0                	add    %edx,%eax
  8017a4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8017a7:	83 c2 30             	add    $0x30,%edx
  8017aa:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8017ac:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017af:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017b4:	f7 e9                	imul   %ecx
  8017b6:	c1 fa 02             	sar    $0x2,%edx
  8017b9:	89 c8                	mov    %ecx,%eax
  8017bb:	c1 f8 1f             	sar    $0x1f,%eax
  8017be:	29 c2                	sub    %eax,%edx
  8017c0:	89 d0                	mov    %edx,%eax
  8017c2:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8017c5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017c8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017cd:	f7 e9                	imul   %ecx
  8017cf:	c1 fa 02             	sar    $0x2,%edx
  8017d2:	89 c8                	mov    %ecx,%eax
  8017d4:	c1 f8 1f             	sar    $0x1f,%eax
  8017d7:	29 c2                	sub    %eax,%edx
  8017d9:	89 d0                	mov    %edx,%eax
  8017db:	c1 e0 02             	shl    $0x2,%eax
  8017de:	01 d0                	add    %edx,%eax
  8017e0:	01 c0                	add    %eax,%eax
  8017e2:	29 c1                	sub    %eax,%ecx
  8017e4:	89 ca                	mov    %ecx,%edx
  8017e6:	85 d2                	test   %edx,%edx
  8017e8:	75 9c                	jne    801786 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8017ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017f4:	48                   	dec    %eax
  8017f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017f8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017fc:	74 3d                	je     80183b <ltostr+0xe2>
		start = 1 ;
  8017fe:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801805:	eb 34                	jmp    80183b <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801807:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80180a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80180d:	01 d0                	add    %edx,%eax
  80180f:	8a 00                	mov    (%eax),%al
  801811:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801814:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801817:	8b 45 0c             	mov    0xc(%ebp),%eax
  80181a:	01 c2                	add    %eax,%edx
  80181c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80181f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801822:	01 c8                	add    %ecx,%eax
  801824:	8a 00                	mov    (%eax),%al
  801826:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801828:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80182b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80182e:	01 c2                	add    %eax,%edx
  801830:	8a 45 eb             	mov    -0x15(%ebp),%al
  801833:	88 02                	mov    %al,(%edx)
		start++ ;
  801835:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801838:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80183b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80183e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801841:	7c c4                	jl     801807 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801843:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801846:	8b 45 0c             	mov    0xc(%ebp),%eax
  801849:	01 d0                	add    %edx,%eax
  80184b:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80184e:	90                   	nop
  80184f:	c9                   	leave  
  801850:	c3                   	ret    

00801851 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801851:	55                   	push   %ebp
  801852:	89 e5                	mov    %esp,%ebp
  801854:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801857:	ff 75 08             	pushl  0x8(%ebp)
  80185a:	e8 54 fa ff ff       	call   8012b3 <strlen>
  80185f:	83 c4 04             	add    $0x4,%esp
  801862:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801865:	ff 75 0c             	pushl  0xc(%ebp)
  801868:	e8 46 fa ff ff       	call   8012b3 <strlen>
  80186d:	83 c4 04             	add    $0x4,%esp
  801870:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801873:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80187a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801881:	eb 17                	jmp    80189a <strcconcat+0x49>
		final[s] = str1[s] ;
  801883:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801886:	8b 45 10             	mov    0x10(%ebp),%eax
  801889:	01 c2                	add    %eax,%edx
  80188b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80188e:	8b 45 08             	mov    0x8(%ebp),%eax
  801891:	01 c8                	add    %ecx,%eax
  801893:	8a 00                	mov    (%eax),%al
  801895:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801897:	ff 45 fc             	incl   -0x4(%ebp)
  80189a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80189d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018a0:	7c e1                	jl     801883 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8018a2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8018a9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8018b0:	eb 1f                	jmp    8018d1 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8018b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018b5:	8d 50 01             	lea    0x1(%eax),%edx
  8018b8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018bb:	89 c2                	mov    %eax,%edx
  8018bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8018c0:	01 c2                	add    %eax,%edx
  8018c2:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018c8:	01 c8                	add    %ecx,%eax
  8018ca:	8a 00                	mov    (%eax),%al
  8018cc:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8018ce:	ff 45 f8             	incl   -0x8(%ebp)
  8018d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018d4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018d7:	7c d9                	jl     8018b2 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8018d9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8018df:	01 d0                	add    %edx,%eax
  8018e1:	c6 00 00             	movb   $0x0,(%eax)
}
  8018e4:	90                   	nop
  8018e5:	c9                   	leave  
  8018e6:	c3                   	ret    

008018e7 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8018e7:	55                   	push   %ebp
  8018e8:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8018ea:	8b 45 14             	mov    0x14(%ebp),%eax
  8018ed:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8018f6:	8b 00                	mov    (%eax),%eax
  8018f8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018ff:	8b 45 10             	mov    0x10(%ebp),%eax
  801902:	01 d0                	add    %edx,%eax
  801904:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80190a:	eb 0c                	jmp    801918 <strsplit+0x31>
			*string++ = 0;
  80190c:	8b 45 08             	mov    0x8(%ebp),%eax
  80190f:	8d 50 01             	lea    0x1(%eax),%edx
  801912:	89 55 08             	mov    %edx,0x8(%ebp)
  801915:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801918:	8b 45 08             	mov    0x8(%ebp),%eax
  80191b:	8a 00                	mov    (%eax),%al
  80191d:	84 c0                	test   %al,%al
  80191f:	74 18                	je     801939 <strsplit+0x52>
  801921:	8b 45 08             	mov    0x8(%ebp),%eax
  801924:	8a 00                	mov    (%eax),%al
  801926:	0f be c0             	movsbl %al,%eax
  801929:	50                   	push   %eax
  80192a:	ff 75 0c             	pushl  0xc(%ebp)
  80192d:	e8 13 fb ff ff       	call   801445 <strchr>
  801932:	83 c4 08             	add    $0x8,%esp
  801935:	85 c0                	test   %eax,%eax
  801937:	75 d3                	jne    80190c <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801939:	8b 45 08             	mov    0x8(%ebp),%eax
  80193c:	8a 00                	mov    (%eax),%al
  80193e:	84 c0                	test   %al,%al
  801940:	74 5a                	je     80199c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801942:	8b 45 14             	mov    0x14(%ebp),%eax
  801945:	8b 00                	mov    (%eax),%eax
  801947:	83 f8 0f             	cmp    $0xf,%eax
  80194a:	75 07                	jne    801953 <strsplit+0x6c>
		{
			return 0;
  80194c:	b8 00 00 00 00       	mov    $0x0,%eax
  801951:	eb 66                	jmp    8019b9 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801953:	8b 45 14             	mov    0x14(%ebp),%eax
  801956:	8b 00                	mov    (%eax),%eax
  801958:	8d 48 01             	lea    0x1(%eax),%ecx
  80195b:	8b 55 14             	mov    0x14(%ebp),%edx
  80195e:	89 0a                	mov    %ecx,(%edx)
  801960:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801967:	8b 45 10             	mov    0x10(%ebp),%eax
  80196a:	01 c2                	add    %eax,%edx
  80196c:	8b 45 08             	mov    0x8(%ebp),%eax
  80196f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801971:	eb 03                	jmp    801976 <strsplit+0x8f>
			string++;
  801973:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801976:	8b 45 08             	mov    0x8(%ebp),%eax
  801979:	8a 00                	mov    (%eax),%al
  80197b:	84 c0                	test   %al,%al
  80197d:	74 8b                	je     80190a <strsplit+0x23>
  80197f:	8b 45 08             	mov    0x8(%ebp),%eax
  801982:	8a 00                	mov    (%eax),%al
  801984:	0f be c0             	movsbl %al,%eax
  801987:	50                   	push   %eax
  801988:	ff 75 0c             	pushl  0xc(%ebp)
  80198b:	e8 b5 fa ff ff       	call   801445 <strchr>
  801990:	83 c4 08             	add    $0x8,%esp
  801993:	85 c0                	test   %eax,%eax
  801995:	74 dc                	je     801973 <strsplit+0x8c>
			string++;
	}
  801997:	e9 6e ff ff ff       	jmp    80190a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80199c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80199d:	8b 45 14             	mov    0x14(%ebp),%eax
  8019a0:	8b 00                	mov    (%eax),%eax
  8019a2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ac:	01 d0                	add    %edx,%eax
  8019ae:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8019b4:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019b9:	c9                   	leave  
  8019ba:	c3                   	ret    

008019bb <malloc>:
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
  8019bb:	55                   	push   %ebp
  8019bc:	89 e5                	mov    %esp,%ebp
  8019be:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  8019c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c4:	c1 e8 0c             	shr    $0xc,%eax
  8019c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  8019ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8019cd:	25 ff 0f 00 00       	and    $0xfff,%eax
  8019d2:	85 c0                	test   %eax,%eax
  8019d4:	74 03                	je     8019d9 <malloc+0x1e>
			num++;
  8019d6:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  8019d9:	a1 04 30 80 00       	mov    0x803004,%eax
  8019de:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8019e3:	75 73                	jne    801a58 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  8019e5:	83 ec 08             	sub    $0x8,%esp
  8019e8:	ff 75 08             	pushl  0x8(%ebp)
  8019eb:	68 00 00 00 80       	push   $0x80000000
  8019f0:	e8 14 05 00 00       	call   801f09 <sys_allocateMem>
  8019f5:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  8019f8:	a1 04 30 80 00       	mov    0x803004,%eax
  8019fd:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  801a00:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a03:	c1 e0 0c             	shl    $0xc,%eax
  801a06:	89 c2                	mov    %eax,%edx
  801a08:	a1 04 30 80 00       	mov    0x803004,%eax
  801a0d:	01 d0                	add    %edx,%eax
  801a0f:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  801a14:	a1 30 30 80 00       	mov    0x803030,%eax
  801a19:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a1c:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			addresses[sizeofarray]=last_addres;
  801a23:	a1 30 30 80 00       	mov    0x803030,%eax
  801a28:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801a2e:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  801a35:	a1 30 30 80 00       	mov    0x803030,%eax
  801a3a:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801a41:	01 00 00 00 
			sizeofarray++;
  801a45:	a1 30 30 80 00       	mov    0x803030,%eax
  801a4a:	40                   	inc    %eax
  801a4b:	a3 30 30 80 00       	mov    %eax,0x803030
			return (void*)return_addres;
  801a50:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801a53:	e9 71 01 00 00       	jmp    801bc9 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  801a58:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a5d:	85 c0                	test   %eax,%eax
  801a5f:	75 71                	jne    801ad2 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  801a61:	a1 04 30 80 00       	mov    0x803004,%eax
  801a66:	83 ec 08             	sub    $0x8,%esp
  801a69:	ff 75 08             	pushl  0x8(%ebp)
  801a6c:	50                   	push   %eax
  801a6d:	e8 97 04 00 00       	call   801f09 <sys_allocateMem>
  801a72:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801a75:	a1 04 30 80 00       	mov    0x803004,%eax
  801a7a:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801a7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a80:	c1 e0 0c             	shl    $0xc,%eax
  801a83:	89 c2                	mov    %eax,%edx
  801a85:	a1 04 30 80 00       	mov    0x803004,%eax
  801a8a:	01 d0                	add    %edx,%eax
  801a8c:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  801a91:	a1 30 30 80 00       	mov    0x803030,%eax
  801a96:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a99:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=return_addres;
  801aa0:	a1 30 30 80 00       	mov    0x803030,%eax
  801aa5:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801aa8:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801aaf:	a1 30 30 80 00       	mov    0x803030,%eax
  801ab4:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801abb:	01 00 00 00 
				sizeofarray++;
  801abf:	a1 30 30 80 00       	mov    0x803030,%eax
  801ac4:	40                   	inc    %eax
  801ac5:	a3 30 30 80 00       	mov    %eax,0x803030
				return (void*)return_addres;
  801aca:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801acd:	e9 f7 00 00 00       	jmp    801bc9 <malloc+0x20e>
			}
			else{
				int count=0;
  801ad2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801ad9:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  801ae0:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801ae7:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801aee:	eb 7c                	jmp    801b6c <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  801af0:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801af7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801afe:	eb 1a                	jmp    801b1a <malloc+0x15f>
					{
						if(addresses[j]==i)
  801b00:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801b03:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801b0a:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801b0d:	75 08                	jne    801b17 <malloc+0x15c>
						{
							index=j;
  801b0f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801b12:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801b15:	eb 0d                	jmp    801b24 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801b17:	ff 45 dc             	incl   -0x24(%ebp)
  801b1a:	a1 30 30 80 00       	mov    0x803030,%eax
  801b1f:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801b22:	7c dc                	jl     801b00 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  801b24:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801b28:	75 05                	jne    801b2f <malloc+0x174>
					{
						count++;
  801b2a:	ff 45 f0             	incl   -0x10(%ebp)
  801b2d:	eb 36                	jmp    801b65 <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  801b2f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801b32:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801b39:	85 c0                	test   %eax,%eax
  801b3b:	75 05                	jne    801b42 <malloc+0x187>
						{
							count++;
  801b3d:	ff 45 f0             	incl   -0x10(%ebp)
  801b40:	eb 23                	jmp    801b65 <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  801b42:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b45:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801b48:	7d 14                	jge    801b5e <malloc+0x1a3>
  801b4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b4d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801b50:	7c 0c                	jl     801b5e <malloc+0x1a3>
							{
								min=count;
  801b52:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b55:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801b58:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b5b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  801b5e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801b65:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801b6c:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801b73:	0f 86 77 ff ff ff    	jbe    801af0 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  801b79:	83 ec 08             	sub    $0x8,%esp
  801b7c:	ff 75 08             	pushl  0x8(%ebp)
  801b7f:	ff 75 e4             	pushl  -0x1c(%ebp)
  801b82:	e8 82 03 00 00       	call   801f09 <sys_allocateMem>
  801b87:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  801b8a:	a1 30 30 80 00       	mov    0x803030,%eax
  801b8f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b92:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801b99:	a1 30 30 80 00       	mov    0x803030,%eax
  801b9e:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801ba4:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801bab:	a1 30 30 80 00       	mov    0x803030,%eax
  801bb0:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801bb7:	01 00 00 00 
				sizeofarray++;
  801bbb:	a1 30 30 80 00       	mov    0x803030,%eax
  801bc0:	40                   	inc    %eax
  801bc1:	a3 30 30 80 00       	mov    %eax,0x803030
				return(void*) min_addresss;
  801bc6:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801bc9:	c9                   	leave  
  801bca:	c3                   	ret    

00801bcb <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801bcb:	55                   	push   %ebp
  801bcc:	89 e5                	mov    %esp,%ebp
  801bce:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  801bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd4:	89 45 e8             	mov    %eax,-0x18(%ebp)
    int size;
    int is_found=0;
  801bd7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  801bde:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801be5:	eb 30                	jmp    801c17 <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  801be7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801bea:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801bf1:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801bf4:	75 1e                	jne    801c14 <free+0x49>
  801bf6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801bf9:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801c00:	83 f8 01             	cmp    $0x1,%eax
  801c03:	75 0f                	jne    801c14 <free+0x49>
    		is_found=1;
  801c05:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  801c0c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  801c12:	eb 0d                	jmp    801c21 <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    int size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  801c14:	ff 45 ec             	incl   -0x14(%ebp)
  801c17:	a1 30 30 80 00       	mov    0x803030,%eax
  801c1c:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801c1f:	7c c6                	jl     801be7 <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  801c21:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801c25:	75 3b                	jne    801c62 <free+0x97>
    	size=numOfPages[index]*PAGE_SIZE;
  801c27:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c2a:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801c31:	c1 e0 0c             	shl    $0xc,%eax
  801c34:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  801c37:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801c3a:	83 ec 08             	sub    $0x8,%esp
  801c3d:	50                   	push   %eax
  801c3e:	ff 75 e8             	pushl  -0x18(%ebp)
  801c41:	e8 a7 02 00 00       	call   801eed <sys_freeMem>
  801c46:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  801c49:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c4c:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  801c53:	00 00 00 00 
    	changes++;
  801c57:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801c5c:	40                   	inc    %eax
  801c5d:	a3 2c 30 80 00       	mov    %eax,0x80302c
    }


	//refer to the project presentation and documentation for details
}
  801c62:	90                   	nop
  801c63:	c9                   	leave  
  801c64:	c3                   	ret    

00801c65 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801c65:	55                   	push   %ebp
  801c66:	89 e5                	mov    %esp,%ebp
  801c68:	83 ec 18             	sub    $0x18,%esp
  801c6b:	8b 45 10             	mov    0x10(%ebp),%eax
  801c6e:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801c71:	83 ec 04             	sub    $0x4,%esp
  801c74:	68 64 2d 80 00       	push   $0x802d64
  801c79:	68 9f 00 00 00       	push   $0x9f
  801c7e:	68 87 2d 80 00       	push   $0x802d87
  801c83:	e8 01 eb ff ff       	call   800789 <_panic>

00801c88 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801c88:	55                   	push   %ebp
  801c89:	89 e5                	mov    %esp,%ebp
  801c8b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c8e:	83 ec 04             	sub    $0x4,%esp
  801c91:	68 64 2d 80 00       	push   $0x802d64
  801c96:	68 a5 00 00 00       	push   $0xa5
  801c9b:	68 87 2d 80 00       	push   $0x802d87
  801ca0:	e8 e4 ea ff ff       	call   800789 <_panic>

00801ca5 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801ca5:	55                   	push   %ebp
  801ca6:	89 e5                	mov    %esp,%ebp
  801ca8:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801cab:	83 ec 04             	sub    $0x4,%esp
  801cae:	68 64 2d 80 00       	push   $0x802d64
  801cb3:	68 ab 00 00 00       	push   $0xab
  801cb8:	68 87 2d 80 00       	push   $0x802d87
  801cbd:	e8 c7 ea ff ff       	call   800789 <_panic>

00801cc2 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801cc2:	55                   	push   %ebp
  801cc3:	89 e5                	mov    %esp,%ebp
  801cc5:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801cc8:	83 ec 04             	sub    $0x4,%esp
  801ccb:	68 64 2d 80 00       	push   $0x802d64
  801cd0:	68 b0 00 00 00       	push   $0xb0
  801cd5:	68 87 2d 80 00       	push   $0x802d87
  801cda:	e8 aa ea ff ff       	call   800789 <_panic>

00801cdf <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801cdf:	55                   	push   %ebp
  801ce0:	89 e5                	mov    %esp,%ebp
  801ce2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ce5:	83 ec 04             	sub    $0x4,%esp
  801ce8:	68 64 2d 80 00       	push   $0x802d64
  801ced:	68 b6 00 00 00       	push   $0xb6
  801cf2:	68 87 2d 80 00       	push   $0x802d87
  801cf7:	e8 8d ea ff ff       	call   800789 <_panic>

00801cfc <shrink>:
}
void shrink(uint32 newSize)
{
  801cfc:	55                   	push   %ebp
  801cfd:	89 e5                	mov    %esp,%ebp
  801cff:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d02:	83 ec 04             	sub    $0x4,%esp
  801d05:	68 64 2d 80 00       	push   $0x802d64
  801d0a:	68 ba 00 00 00       	push   $0xba
  801d0f:	68 87 2d 80 00       	push   $0x802d87
  801d14:	e8 70 ea ff ff       	call   800789 <_panic>

00801d19 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801d19:	55                   	push   %ebp
  801d1a:	89 e5                	mov    %esp,%ebp
  801d1c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d1f:	83 ec 04             	sub    $0x4,%esp
  801d22:	68 64 2d 80 00       	push   $0x802d64
  801d27:	68 bf 00 00 00       	push   $0xbf
  801d2c:	68 87 2d 80 00       	push   $0x802d87
  801d31:	e8 53 ea ff ff       	call   800789 <_panic>

00801d36 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801d36:	55                   	push   %ebp
  801d37:	89 e5                	mov    %esp,%ebp
  801d39:	57                   	push   %edi
  801d3a:	56                   	push   %esi
  801d3b:	53                   	push   %ebx
  801d3c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d42:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d45:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d48:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d4b:	8b 7d 18             	mov    0x18(%ebp),%edi
  801d4e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801d51:	cd 30                	int    $0x30
  801d53:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801d56:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801d59:	83 c4 10             	add    $0x10,%esp
  801d5c:	5b                   	pop    %ebx
  801d5d:	5e                   	pop    %esi
  801d5e:	5f                   	pop    %edi
  801d5f:	5d                   	pop    %ebp
  801d60:	c3                   	ret    

00801d61 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801d61:	55                   	push   %ebp
  801d62:	89 e5                	mov    %esp,%ebp
  801d64:	83 ec 04             	sub    $0x4,%esp
  801d67:	8b 45 10             	mov    0x10(%ebp),%eax
  801d6a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801d6d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d71:	8b 45 08             	mov    0x8(%ebp),%eax
  801d74:	6a 00                	push   $0x0
  801d76:	6a 00                	push   $0x0
  801d78:	52                   	push   %edx
  801d79:	ff 75 0c             	pushl  0xc(%ebp)
  801d7c:	50                   	push   %eax
  801d7d:	6a 00                	push   $0x0
  801d7f:	e8 b2 ff ff ff       	call   801d36 <syscall>
  801d84:	83 c4 18             	add    $0x18,%esp
}
  801d87:	90                   	nop
  801d88:	c9                   	leave  
  801d89:	c3                   	ret    

00801d8a <sys_cgetc>:

int
sys_cgetc(void)
{
  801d8a:	55                   	push   %ebp
  801d8b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801d8d:	6a 00                	push   $0x0
  801d8f:	6a 00                	push   $0x0
  801d91:	6a 00                	push   $0x0
  801d93:	6a 00                	push   $0x0
  801d95:	6a 00                	push   $0x0
  801d97:	6a 01                	push   $0x1
  801d99:	e8 98 ff ff ff       	call   801d36 <syscall>
  801d9e:	83 c4 18             	add    $0x18,%esp
}
  801da1:	c9                   	leave  
  801da2:	c3                   	ret    

00801da3 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801da3:	55                   	push   %ebp
  801da4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801da6:	8b 45 08             	mov    0x8(%ebp),%eax
  801da9:	6a 00                	push   $0x0
  801dab:	6a 00                	push   $0x0
  801dad:	6a 00                	push   $0x0
  801daf:	6a 00                	push   $0x0
  801db1:	50                   	push   %eax
  801db2:	6a 05                	push   $0x5
  801db4:	e8 7d ff ff ff       	call   801d36 <syscall>
  801db9:	83 c4 18             	add    $0x18,%esp
}
  801dbc:	c9                   	leave  
  801dbd:	c3                   	ret    

00801dbe <sys_getenvid>:

int32 sys_getenvid(void)
{
  801dbe:	55                   	push   %ebp
  801dbf:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801dc1:	6a 00                	push   $0x0
  801dc3:	6a 00                	push   $0x0
  801dc5:	6a 00                	push   $0x0
  801dc7:	6a 00                	push   $0x0
  801dc9:	6a 00                	push   $0x0
  801dcb:	6a 02                	push   $0x2
  801dcd:	e8 64 ff ff ff       	call   801d36 <syscall>
  801dd2:	83 c4 18             	add    $0x18,%esp
}
  801dd5:	c9                   	leave  
  801dd6:	c3                   	ret    

00801dd7 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801dd7:	55                   	push   %ebp
  801dd8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 00                	push   $0x0
  801dde:	6a 00                	push   $0x0
  801de0:	6a 00                	push   $0x0
  801de2:	6a 00                	push   $0x0
  801de4:	6a 03                	push   $0x3
  801de6:	e8 4b ff ff ff       	call   801d36 <syscall>
  801deb:	83 c4 18             	add    $0x18,%esp
}
  801dee:	c9                   	leave  
  801def:	c3                   	ret    

00801df0 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801df0:	55                   	push   %ebp
  801df1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	6a 04                	push   $0x4
  801dff:	e8 32 ff ff ff       	call   801d36 <syscall>
  801e04:	83 c4 18             	add    $0x18,%esp
}
  801e07:	c9                   	leave  
  801e08:	c3                   	ret    

00801e09 <sys_env_exit>:


void sys_env_exit(void)
{
  801e09:	55                   	push   %ebp
  801e0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801e0c:	6a 00                	push   $0x0
  801e0e:	6a 00                	push   $0x0
  801e10:	6a 00                	push   $0x0
  801e12:	6a 00                	push   $0x0
  801e14:	6a 00                	push   $0x0
  801e16:	6a 06                	push   $0x6
  801e18:	e8 19 ff ff ff       	call   801d36 <syscall>
  801e1d:	83 c4 18             	add    $0x18,%esp
}
  801e20:	90                   	nop
  801e21:	c9                   	leave  
  801e22:	c3                   	ret    

00801e23 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801e23:	55                   	push   %ebp
  801e24:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801e26:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e29:	8b 45 08             	mov    0x8(%ebp),%eax
  801e2c:	6a 00                	push   $0x0
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	52                   	push   %edx
  801e33:	50                   	push   %eax
  801e34:	6a 07                	push   $0x7
  801e36:	e8 fb fe ff ff       	call   801d36 <syscall>
  801e3b:	83 c4 18             	add    $0x18,%esp
}
  801e3e:	c9                   	leave  
  801e3f:	c3                   	ret    

00801e40 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801e40:	55                   	push   %ebp
  801e41:	89 e5                	mov    %esp,%ebp
  801e43:	56                   	push   %esi
  801e44:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801e45:	8b 75 18             	mov    0x18(%ebp),%esi
  801e48:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e4b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e4e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e51:	8b 45 08             	mov    0x8(%ebp),%eax
  801e54:	56                   	push   %esi
  801e55:	53                   	push   %ebx
  801e56:	51                   	push   %ecx
  801e57:	52                   	push   %edx
  801e58:	50                   	push   %eax
  801e59:	6a 08                	push   $0x8
  801e5b:	e8 d6 fe ff ff       	call   801d36 <syscall>
  801e60:	83 c4 18             	add    $0x18,%esp
}
  801e63:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801e66:	5b                   	pop    %ebx
  801e67:	5e                   	pop    %esi
  801e68:	5d                   	pop    %ebp
  801e69:	c3                   	ret    

00801e6a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801e6a:	55                   	push   %ebp
  801e6b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801e6d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e70:	8b 45 08             	mov    0x8(%ebp),%eax
  801e73:	6a 00                	push   $0x0
  801e75:	6a 00                	push   $0x0
  801e77:	6a 00                	push   $0x0
  801e79:	52                   	push   %edx
  801e7a:	50                   	push   %eax
  801e7b:	6a 09                	push   $0x9
  801e7d:	e8 b4 fe ff ff       	call   801d36 <syscall>
  801e82:	83 c4 18             	add    $0x18,%esp
}
  801e85:	c9                   	leave  
  801e86:	c3                   	ret    

00801e87 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801e87:	55                   	push   %ebp
  801e88:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801e8a:	6a 00                	push   $0x0
  801e8c:	6a 00                	push   $0x0
  801e8e:	6a 00                	push   $0x0
  801e90:	ff 75 0c             	pushl  0xc(%ebp)
  801e93:	ff 75 08             	pushl  0x8(%ebp)
  801e96:	6a 0a                	push   $0xa
  801e98:	e8 99 fe ff ff       	call   801d36 <syscall>
  801e9d:	83 c4 18             	add    $0x18,%esp
}
  801ea0:	c9                   	leave  
  801ea1:	c3                   	ret    

00801ea2 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801ea2:	55                   	push   %ebp
  801ea3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801ea5:	6a 00                	push   $0x0
  801ea7:	6a 00                	push   $0x0
  801ea9:	6a 00                	push   $0x0
  801eab:	6a 00                	push   $0x0
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 0b                	push   $0xb
  801eb1:	e8 80 fe ff ff       	call   801d36 <syscall>
  801eb6:	83 c4 18             	add    $0x18,%esp
}
  801eb9:	c9                   	leave  
  801eba:	c3                   	ret    

00801ebb <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801ebb:	55                   	push   %ebp
  801ebc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 00                	push   $0x0
  801ec4:	6a 00                	push   $0x0
  801ec6:	6a 00                	push   $0x0
  801ec8:	6a 0c                	push   $0xc
  801eca:	e8 67 fe ff ff       	call   801d36 <syscall>
  801ecf:	83 c4 18             	add    $0x18,%esp
}
  801ed2:	c9                   	leave  
  801ed3:	c3                   	ret    

00801ed4 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801ed4:	55                   	push   %ebp
  801ed5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801ed7:	6a 00                	push   $0x0
  801ed9:	6a 00                	push   $0x0
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 0d                	push   $0xd
  801ee3:	e8 4e fe ff ff       	call   801d36 <syscall>
  801ee8:	83 c4 18             	add    $0x18,%esp
}
  801eeb:	c9                   	leave  
  801eec:	c3                   	ret    

00801eed <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801eed:	55                   	push   %ebp
  801eee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801ef0:	6a 00                	push   $0x0
  801ef2:	6a 00                	push   $0x0
  801ef4:	6a 00                	push   $0x0
  801ef6:	ff 75 0c             	pushl  0xc(%ebp)
  801ef9:	ff 75 08             	pushl  0x8(%ebp)
  801efc:	6a 11                	push   $0x11
  801efe:	e8 33 fe ff ff       	call   801d36 <syscall>
  801f03:	83 c4 18             	add    $0x18,%esp
	return;
  801f06:	90                   	nop
}
  801f07:	c9                   	leave  
  801f08:	c3                   	ret    

00801f09 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801f09:	55                   	push   %ebp
  801f0a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801f0c:	6a 00                	push   $0x0
  801f0e:	6a 00                	push   $0x0
  801f10:	6a 00                	push   $0x0
  801f12:	ff 75 0c             	pushl  0xc(%ebp)
  801f15:	ff 75 08             	pushl  0x8(%ebp)
  801f18:	6a 12                	push   $0x12
  801f1a:	e8 17 fe ff ff       	call   801d36 <syscall>
  801f1f:	83 c4 18             	add    $0x18,%esp
	return ;
  801f22:	90                   	nop
}
  801f23:	c9                   	leave  
  801f24:	c3                   	ret    

00801f25 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801f25:	55                   	push   %ebp
  801f26:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801f28:	6a 00                	push   $0x0
  801f2a:	6a 00                	push   $0x0
  801f2c:	6a 00                	push   $0x0
  801f2e:	6a 00                	push   $0x0
  801f30:	6a 00                	push   $0x0
  801f32:	6a 0e                	push   $0xe
  801f34:	e8 fd fd ff ff       	call   801d36 <syscall>
  801f39:	83 c4 18             	add    $0x18,%esp
}
  801f3c:	c9                   	leave  
  801f3d:	c3                   	ret    

00801f3e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801f3e:	55                   	push   %ebp
  801f3f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801f41:	6a 00                	push   $0x0
  801f43:	6a 00                	push   $0x0
  801f45:	6a 00                	push   $0x0
  801f47:	6a 00                	push   $0x0
  801f49:	ff 75 08             	pushl  0x8(%ebp)
  801f4c:	6a 0f                	push   $0xf
  801f4e:	e8 e3 fd ff ff       	call   801d36 <syscall>
  801f53:	83 c4 18             	add    $0x18,%esp
}
  801f56:	c9                   	leave  
  801f57:	c3                   	ret    

00801f58 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801f58:	55                   	push   %ebp
  801f59:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801f5b:	6a 00                	push   $0x0
  801f5d:	6a 00                	push   $0x0
  801f5f:	6a 00                	push   $0x0
  801f61:	6a 00                	push   $0x0
  801f63:	6a 00                	push   $0x0
  801f65:	6a 10                	push   $0x10
  801f67:	e8 ca fd ff ff       	call   801d36 <syscall>
  801f6c:	83 c4 18             	add    $0x18,%esp
}
  801f6f:	90                   	nop
  801f70:	c9                   	leave  
  801f71:	c3                   	ret    

00801f72 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801f72:	55                   	push   %ebp
  801f73:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801f75:	6a 00                	push   $0x0
  801f77:	6a 00                	push   $0x0
  801f79:	6a 00                	push   $0x0
  801f7b:	6a 00                	push   $0x0
  801f7d:	6a 00                	push   $0x0
  801f7f:	6a 14                	push   $0x14
  801f81:	e8 b0 fd ff ff       	call   801d36 <syscall>
  801f86:	83 c4 18             	add    $0x18,%esp
}
  801f89:	90                   	nop
  801f8a:	c9                   	leave  
  801f8b:	c3                   	ret    

00801f8c <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801f8c:	55                   	push   %ebp
  801f8d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801f8f:	6a 00                	push   $0x0
  801f91:	6a 00                	push   $0x0
  801f93:	6a 00                	push   $0x0
  801f95:	6a 00                	push   $0x0
  801f97:	6a 00                	push   $0x0
  801f99:	6a 15                	push   $0x15
  801f9b:	e8 96 fd ff ff       	call   801d36 <syscall>
  801fa0:	83 c4 18             	add    $0x18,%esp
}
  801fa3:	90                   	nop
  801fa4:	c9                   	leave  
  801fa5:	c3                   	ret    

00801fa6 <sys_cputc>:


void
sys_cputc(const char c)
{
  801fa6:	55                   	push   %ebp
  801fa7:	89 e5                	mov    %esp,%ebp
  801fa9:	83 ec 04             	sub    $0x4,%esp
  801fac:	8b 45 08             	mov    0x8(%ebp),%eax
  801faf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801fb2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801fb6:	6a 00                	push   $0x0
  801fb8:	6a 00                	push   $0x0
  801fba:	6a 00                	push   $0x0
  801fbc:	6a 00                	push   $0x0
  801fbe:	50                   	push   %eax
  801fbf:	6a 16                	push   $0x16
  801fc1:	e8 70 fd ff ff       	call   801d36 <syscall>
  801fc6:	83 c4 18             	add    $0x18,%esp
}
  801fc9:	90                   	nop
  801fca:	c9                   	leave  
  801fcb:	c3                   	ret    

00801fcc <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801fcc:	55                   	push   %ebp
  801fcd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 00                	push   $0x0
  801fd3:	6a 00                	push   $0x0
  801fd5:	6a 00                	push   $0x0
  801fd7:	6a 00                	push   $0x0
  801fd9:	6a 17                	push   $0x17
  801fdb:	e8 56 fd ff ff       	call   801d36 <syscall>
  801fe0:	83 c4 18             	add    $0x18,%esp
}
  801fe3:	90                   	nop
  801fe4:	c9                   	leave  
  801fe5:	c3                   	ret    

00801fe6 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801fe6:	55                   	push   %ebp
  801fe7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801fe9:	8b 45 08             	mov    0x8(%ebp),%eax
  801fec:	6a 00                	push   $0x0
  801fee:	6a 00                	push   $0x0
  801ff0:	6a 00                	push   $0x0
  801ff2:	ff 75 0c             	pushl  0xc(%ebp)
  801ff5:	50                   	push   %eax
  801ff6:	6a 18                	push   $0x18
  801ff8:	e8 39 fd ff ff       	call   801d36 <syscall>
  801ffd:	83 c4 18             	add    $0x18,%esp
}
  802000:	c9                   	leave  
  802001:	c3                   	ret    

00802002 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802002:	55                   	push   %ebp
  802003:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802005:	8b 55 0c             	mov    0xc(%ebp),%edx
  802008:	8b 45 08             	mov    0x8(%ebp),%eax
  80200b:	6a 00                	push   $0x0
  80200d:	6a 00                	push   $0x0
  80200f:	6a 00                	push   $0x0
  802011:	52                   	push   %edx
  802012:	50                   	push   %eax
  802013:	6a 1b                	push   $0x1b
  802015:	e8 1c fd ff ff       	call   801d36 <syscall>
  80201a:	83 c4 18             	add    $0x18,%esp
}
  80201d:	c9                   	leave  
  80201e:	c3                   	ret    

0080201f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80201f:	55                   	push   %ebp
  802020:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802022:	8b 55 0c             	mov    0xc(%ebp),%edx
  802025:	8b 45 08             	mov    0x8(%ebp),%eax
  802028:	6a 00                	push   $0x0
  80202a:	6a 00                	push   $0x0
  80202c:	6a 00                	push   $0x0
  80202e:	52                   	push   %edx
  80202f:	50                   	push   %eax
  802030:	6a 19                	push   $0x19
  802032:	e8 ff fc ff ff       	call   801d36 <syscall>
  802037:	83 c4 18             	add    $0x18,%esp
}
  80203a:	90                   	nop
  80203b:	c9                   	leave  
  80203c:	c3                   	ret    

0080203d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80203d:	55                   	push   %ebp
  80203e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802040:	8b 55 0c             	mov    0xc(%ebp),%edx
  802043:	8b 45 08             	mov    0x8(%ebp),%eax
  802046:	6a 00                	push   $0x0
  802048:	6a 00                	push   $0x0
  80204a:	6a 00                	push   $0x0
  80204c:	52                   	push   %edx
  80204d:	50                   	push   %eax
  80204e:	6a 1a                	push   $0x1a
  802050:	e8 e1 fc ff ff       	call   801d36 <syscall>
  802055:	83 c4 18             	add    $0x18,%esp
}
  802058:	90                   	nop
  802059:	c9                   	leave  
  80205a:	c3                   	ret    

0080205b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80205b:	55                   	push   %ebp
  80205c:	89 e5                	mov    %esp,%ebp
  80205e:	83 ec 04             	sub    $0x4,%esp
  802061:	8b 45 10             	mov    0x10(%ebp),%eax
  802064:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802067:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80206a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80206e:	8b 45 08             	mov    0x8(%ebp),%eax
  802071:	6a 00                	push   $0x0
  802073:	51                   	push   %ecx
  802074:	52                   	push   %edx
  802075:	ff 75 0c             	pushl  0xc(%ebp)
  802078:	50                   	push   %eax
  802079:	6a 1c                	push   $0x1c
  80207b:	e8 b6 fc ff ff       	call   801d36 <syscall>
  802080:	83 c4 18             	add    $0x18,%esp
}
  802083:	c9                   	leave  
  802084:	c3                   	ret    

00802085 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802085:	55                   	push   %ebp
  802086:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802088:	8b 55 0c             	mov    0xc(%ebp),%edx
  80208b:	8b 45 08             	mov    0x8(%ebp),%eax
  80208e:	6a 00                	push   $0x0
  802090:	6a 00                	push   $0x0
  802092:	6a 00                	push   $0x0
  802094:	52                   	push   %edx
  802095:	50                   	push   %eax
  802096:	6a 1d                	push   $0x1d
  802098:	e8 99 fc ff ff       	call   801d36 <syscall>
  80209d:	83 c4 18             	add    $0x18,%esp
}
  8020a0:	c9                   	leave  
  8020a1:	c3                   	ret    

008020a2 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8020a2:	55                   	push   %ebp
  8020a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8020a5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ae:	6a 00                	push   $0x0
  8020b0:	6a 00                	push   $0x0
  8020b2:	51                   	push   %ecx
  8020b3:	52                   	push   %edx
  8020b4:	50                   	push   %eax
  8020b5:	6a 1e                	push   $0x1e
  8020b7:	e8 7a fc ff ff       	call   801d36 <syscall>
  8020bc:	83 c4 18             	add    $0x18,%esp
}
  8020bf:	c9                   	leave  
  8020c0:	c3                   	ret    

008020c1 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8020c1:	55                   	push   %ebp
  8020c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8020c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ca:	6a 00                	push   $0x0
  8020cc:	6a 00                	push   $0x0
  8020ce:	6a 00                	push   $0x0
  8020d0:	52                   	push   %edx
  8020d1:	50                   	push   %eax
  8020d2:	6a 1f                	push   $0x1f
  8020d4:	e8 5d fc ff ff       	call   801d36 <syscall>
  8020d9:	83 c4 18             	add    $0x18,%esp
}
  8020dc:	c9                   	leave  
  8020dd:	c3                   	ret    

008020de <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8020de:	55                   	push   %ebp
  8020df:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8020e1:	6a 00                	push   $0x0
  8020e3:	6a 00                	push   $0x0
  8020e5:	6a 00                	push   $0x0
  8020e7:	6a 00                	push   $0x0
  8020e9:	6a 00                	push   $0x0
  8020eb:	6a 20                	push   $0x20
  8020ed:	e8 44 fc ff ff       	call   801d36 <syscall>
  8020f2:	83 c4 18             	add    $0x18,%esp
}
  8020f5:	c9                   	leave  
  8020f6:	c3                   	ret    

008020f7 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8020f7:	55                   	push   %ebp
  8020f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8020fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8020fd:	6a 00                	push   $0x0
  8020ff:	ff 75 14             	pushl  0x14(%ebp)
  802102:	ff 75 10             	pushl  0x10(%ebp)
  802105:	ff 75 0c             	pushl  0xc(%ebp)
  802108:	50                   	push   %eax
  802109:	6a 21                	push   $0x21
  80210b:	e8 26 fc ff ff       	call   801d36 <syscall>
  802110:	83 c4 18             	add    $0x18,%esp
}
  802113:	c9                   	leave  
  802114:	c3                   	ret    

00802115 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802115:	55                   	push   %ebp
  802116:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802118:	8b 45 08             	mov    0x8(%ebp),%eax
  80211b:	6a 00                	push   $0x0
  80211d:	6a 00                	push   $0x0
  80211f:	6a 00                	push   $0x0
  802121:	6a 00                	push   $0x0
  802123:	50                   	push   %eax
  802124:	6a 22                	push   $0x22
  802126:	e8 0b fc ff ff       	call   801d36 <syscall>
  80212b:	83 c4 18             	add    $0x18,%esp
}
  80212e:	90                   	nop
  80212f:	c9                   	leave  
  802130:	c3                   	ret    

00802131 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802131:	55                   	push   %ebp
  802132:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802134:	8b 45 08             	mov    0x8(%ebp),%eax
  802137:	6a 00                	push   $0x0
  802139:	6a 00                	push   $0x0
  80213b:	6a 00                	push   $0x0
  80213d:	6a 00                	push   $0x0
  80213f:	50                   	push   %eax
  802140:	6a 23                	push   $0x23
  802142:	e8 ef fb ff ff       	call   801d36 <syscall>
  802147:	83 c4 18             	add    $0x18,%esp
}
  80214a:	90                   	nop
  80214b:	c9                   	leave  
  80214c:	c3                   	ret    

0080214d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80214d:	55                   	push   %ebp
  80214e:	89 e5                	mov    %esp,%ebp
  802150:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802153:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802156:	8d 50 04             	lea    0x4(%eax),%edx
  802159:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80215c:	6a 00                	push   $0x0
  80215e:	6a 00                	push   $0x0
  802160:	6a 00                	push   $0x0
  802162:	52                   	push   %edx
  802163:	50                   	push   %eax
  802164:	6a 24                	push   $0x24
  802166:	e8 cb fb ff ff       	call   801d36 <syscall>
  80216b:	83 c4 18             	add    $0x18,%esp
	return result;
  80216e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802171:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802174:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802177:	89 01                	mov    %eax,(%ecx)
  802179:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80217c:	8b 45 08             	mov    0x8(%ebp),%eax
  80217f:	c9                   	leave  
  802180:	c2 04 00             	ret    $0x4

00802183 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802183:	55                   	push   %ebp
  802184:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802186:	6a 00                	push   $0x0
  802188:	6a 00                	push   $0x0
  80218a:	ff 75 10             	pushl  0x10(%ebp)
  80218d:	ff 75 0c             	pushl  0xc(%ebp)
  802190:	ff 75 08             	pushl  0x8(%ebp)
  802193:	6a 13                	push   $0x13
  802195:	e8 9c fb ff ff       	call   801d36 <syscall>
  80219a:	83 c4 18             	add    $0x18,%esp
	return ;
  80219d:	90                   	nop
}
  80219e:	c9                   	leave  
  80219f:	c3                   	ret    

008021a0 <sys_rcr2>:
uint32 sys_rcr2()
{
  8021a0:	55                   	push   %ebp
  8021a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8021a3:	6a 00                	push   $0x0
  8021a5:	6a 00                	push   $0x0
  8021a7:	6a 00                	push   $0x0
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	6a 25                	push   $0x25
  8021af:	e8 82 fb ff ff       	call   801d36 <syscall>
  8021b4:	83 c4 18             	add    $0x18,%esp
}
  8021b7:	c9                   	leave  
  8021b8:	c3                   	ret    

008021b9 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8021b9:	55                   	push   %ebp
  8021ba:	89 e5                	mov    %esp,%ebp
  8021bc:	83 ec 04             	sub    $0x4,%esp
  8021bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8021c5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8021c9:	6a 00                	push   $0x0
  8021cb:	6a 00                	push   $0x0
  8021cd:	6a 00                	push   $0x0
  8021cf:	6a 00                	push   $0x0
  8021d1:	50                   	push   %eax
  8021d2:	6a 26                	push   $0x26
  8021d4:	e8 5d fb ff ff       	call   801d36 <syscall>
  8021d9:	83 c4 18             	add    $0x18,%esp
	return ;
  8021dc:	90                   	nop
}
  8021dd:	c9                   	leave  
  8021de:	c3                   	ret    

008021df <rsttst>:
void rsttst()
{
  8021df:	55                   	push   %ebp
  8021e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8021e2:	6a 00                	push   $0x0
  8021e4:	6a 00                	push   $0x0
  8021e6:	6a 00                	push   $0x0
  8021e8:	6a 00                	push   $0x0
  8021ea:	6a 00                	push   $0x0
  8021ec:	6a 28                	push   $0x28
  8021ee:	e8 43 fb ff ff       	call   801d36 <syscall>
  8021f3:	83 c4 18             	add    $0x18,%esp
	return ;
  8021f6:	90                   	nop
}
  8021f7:	c9                   	leave  
  8021f8:	c3                   	ret    

008021f9 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8021f9:	55                   	push   %ebp
  8021fa:	89 e5                	mov    %esp,%ebp
  8021fc:	83 ec 04             	sub    $0x4,%esp
  8021ff:	8b 45 14             	mov    0x14(%ebp),%eax
  802202:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802205:	8b 55 18             	mov    0x18(%ebp),%edx
  802208:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80220c:	52                   	push   %edx
  80220d:	50                   	push   %eax
  80220e:	ff 75 10             	pushl  0x10(%ebp)
  802211:	ff 75 0c             	pushl  0xc(%ebp)
  802214:	ff 75 08             	pushl  0x8(%ebp)
  802217:	6a 27                	push   $0x27
  802219:	e8 18 fb ff ff       	call   801d36 <syscall>
  80221e:	83 c4 18             	add    $0x18,%esp
	return ;
  802221:	90                   	nop
}
  802222:	c9                   	leave  
  802223:	c3                   	ret    

00802224 <chktst>:
void chktst(uint32 n)
{
  802224:	55                   	push   %ebp
  802225:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802227:	6a 00                	push   $0x0
  802229:	6a 00                	push   $0x0
  80222b:	6a 00                	push   $0x0
  80222d:	6a 00                	push   $0x0
  80222f:	ff 75 08             	pushl  0x8(%ebp)
  802232:	6a 29                	push   $0x29
  802234:	e8 fd fa ff ff       	call   801d36 <syscall>
  802239:	83 c4 18             	add    $0x18,%esp
	return ;
  80223c:	90                   	nop
}
  80223d:	c9                   	leave  
  80223e:	c3                   	ret    

0080223f <inctst>:

void inctst()
{
  80223f:	55                   	push   %ebp
  802240:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802242:	6a 00                	push   $0x0
  802244:	6a 00                	push   $0x0
  802246:	6a 00                	push   $0x0
  802248:	6a 00                	push   $0x0
  80224a:	6a 00                	push   $0x0
  80224c:	6a 2a                	push   $0x2a
  80224e:	e8 e3 fa ff ff       	call   801d36 <syscall>
  802253:	83 c4 18             	add    $0x18,%esp
	return ;
  802256:	90                   	nop
}
  802257:	c9                   	leave  
  802258:	c3                   	ret    

00802259 <gettst>:
uint32 gettst()
{
  802259:	55                   	push   %ebp
  80225a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80225c:	6a 00                	push   $0x0
  80225e:	6a 00                	push   $0x0
  802260:	6a 00                	push   $0x0
  802262:	6a 00                	push   $0x0
  802264:	6a 00                	push   $0x0
  802266:	6a 2b                	push   $0x2b
  802268:	e8 c9 fa ff ff       	call   801d36 <syscall>
  80226d:	83 c4 18             	add    $0x18,%esp
}
  802270:	c9                   	leave  
  802271:	c3                   	ret    

00802272 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802272:	55                   	push   %ebp
  802273:	89 e5                	mov    %esp,%ebp
  802275:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802278:	6a 00                	push   $0x0
  80227a:	6a 00                	push   $0x0
  80227c:	6a 00                	push   $0x0
  80227e:	6a 00                	push   $0x0
  802280:	6a 00                	push   $0x0
  802282:	6a 2c                	push   $0x2c
  802284:	e8 ad fa ff ff       	call   801d36 <syscall>
  802289:	83 c4 18             	add    $0x18,%esp
  80228c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80228f:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802293:	75 07                	jne    80229c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802295:	b8 01 00 00 00       	mov    $0x1,%eax
  80229a:	eb 05                	jmp    8022a1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80229c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022a1:	c9                   	leave  
  8022a2:	c3                   	ret    

008022a3 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8022a3:	55                   	push   %ebp
  8022a4:	89 e5                	mov    %esp,%ebp
  8022a6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022a9:	6a 00                	push   $0x0
  8022ab:	6a 00                	push   $0x0
  8022ad:	6a 00                	push   $0x0
  8022af:	6a 00                	push   $0x0
  8022b1:	6a 00                	push   $0x0
  8022b3:	6a 2c                	push   $0x2c
  8022b5:	e8 7c fa ff ff       	call   801d36 <syscall>
  8022ba:	83 c4 18             	add    $0x18,%esp
  8022bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8022c0:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8022c4:	75 07                	jne    8022cd <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8022c6:	b8 01 00 00 00       	mov    $0x1,%eax
  8022cb:	eb 05                	jmp    8022d2 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8022cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022d2:	c9                   	leave  
  8022d3:	c3                   	ret    

008022d4 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8022d4:	55                   	push   %ebp
  8022d5:	89 e5                	mov    %esp,%ebp
  8022d7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022da:	6a 00                	push   $0x0
  8022dc:	6a 00                	push   $0x0
  8022de:	6a 00                	push   $0x0
  8022e0:	6a 00                	push   $0x0
  8022e2:	6a 00                	push   $0x0
  8022e4:	6a 2c                	push   $0x2c
  8022e6:	e8 4b fa ff ff       	call   801d36 <syscall>
  8022eb:	83 c4 18             	add    $0x18,%esp
  8022ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8022f1:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8022f5:	75 07                	jne    8022fe <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8022f7:	b8 01 00 00 00       	mov    $0x1,%eax
  8022fc:	eb 05                	jmp    802303 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8022fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802303:	c9                   	leave  
  802304:	c3                   	ret    

00802305 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802305:	55                   	push   %ebp
  802306:	89 e5                	mov    %esp,%ebp
  802308:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80230b:	6a 00                	push   $0x0
  80230d:	6a 00                	push   $0x0
  80230f:	6a 00                	push   $0x0
  802311:	6a 00                	push   $0x0
  802313:	6a 00                	push   $0x0
  802315:	6a 2c                	push   $0x2c
  802317:	e8 1a fa ff ff       	call   801d36 <syscall>
  80231c:	83 c4 18             	add    $0x18,%esp
  80231f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802322:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802326:	75 07                	jne    80232f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802328:	b8 01 00 00 00       	mov    $0x1,%eax
  80232d:	eb 05                	jmp    802334 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80232f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802334:	c9                   	leave  
  802335:	c3                   	ret    

00802336 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802336:	55                   	push   %ebp
  802337:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802339:	6a 00                	push   $0x0
  80233b:	6a 00                	push   $0x0
  80233d:	6a 00                	push   $0x0
  80233f:	6a 00                	push   $0x0
  802341:	ff 75 08             	pushl  0x8(%ebp)
  802344:	6a 2d                	push   $0x2d
  802346:	e8 eb f9 ff ff       	call   801d36 <syscall>
  80234b:	83 c4 18             	add    $0x18,%esp
	return ;
  80234e:	90                   	nop
}
  80234f:	c9                   	leave  
  802350:	c3                   	ret    

00802351 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802351:	55                   	push   %ebp
  802352:	89 e5                	mov    %esp,%ebp
  802354:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802355:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802358:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80235b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80235e:	8b 45 08             	mov    0x8(%ebp),%eax
  802361:	6a 00                	push   $0x0
  802363:	53                   	push   %ebx
  802364:	51                   	push   %ecx
  802365:	52                   	push   %edx
  802366:	50                   	push   %eax
  802367:	6a 2e                	push   $0x2e
  802369:	e8 c8 f9 ff ff       	call   801d36 <syscall>
  80236e:	83 c4 18             	add    $0x18,%esp
}
  802371:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802374:	c9                   	leave  
  802375:	c3                   	ret    

00802376 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802376:	55                   	push   %ebp
  802377:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802379:	8b 55 0c             	mov    0xc(%ebp),%edx
  80237c:	8b 45 08             	mov    0x8(%ebp),%eax
  80237f:	6a 00                	push   $0x0
  802381:	6a 00                	push   $0x0
  802383:	6a 00                	push   $0x0
  802385:	52                   	push   %edx
  802386:	50                   	push   %eax
  802387:	6a 2f                	push   $0x2f
  802389:	e8 a8 f9 ff ff       	call   801d36 <syscall>
  80238e:	83 c4 18             	add    $0x18,%esp
}
  802391:	c9                   	leave  
  802392:	c3                   	ret    
  802393:	90                   	nop

00802394 <__udivdi3>:
  802394:	55                   	push   %ebp
  802395:	57                   	push   %edi
  802396:	56                   	push   %esi
  802397:	53                   	push   %ebx
  802398:	83 ec 1c             	sub    $0x1c,%esp
  80239b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80239f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8023a3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023a7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8023ab:	89 ca                	mov    %ecx,%edx
  8023ad:	89 f8                	mov    %edi,%eax
  8023af:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8023b3:	85 f6                	test   %esi,%esi
  8023b5:	75 2d                	jne    8023e4 <__udivdi3+0x50>
  8023b7:	39 cf                	cmp    %ecx,%edi
  8023b9:	77 65                	ja     802420 <__udivdi3+0x8c>
  8023bb:	89 fd                	mov    %edi,%ebp
  8023bd:	85 ff                	test   %edi,%edi
  8023bf:	75 0b                	jne    8023cc <__udivdi3+0x38>
  8023c1:	b8 01 00 00 00       	mov    $0x1,%eax
  8023c6:	31 d2                	xor    %edx,%edx
  8023c8:	f7 f7                	div    %edi
  8023ca:	89 c5                	mov    %eax,%ebp
  8023cc:	31 d2                	xor    %edx,%edx
  8023ce:	89 c8                	mov    %ecx,%eax
  8023d0:	f7 f5                	div    %ebp
  8023d2:	89 c1                	mov    %eax,%ecx
  8023d4:	89 d8                	mov    %ebx,%eax
  8023d6:	f7 f5                	div    %ebp
  8023d8:	89 cf                	mov    %ecx,%edi
  8023da:	89 fa                	mov    %edi,%edx
  8023dc:	83 c4 1c             	add    $0x1c,%esp
  8023df:	5b                   	pop    %ebx
  8023e0:	5e                   	pop    %esi
  8023e1:	5f                   	pop    %edi
  8023e2:	5d                   	pop    %ebp
  8023e3:	c3                   	ret    
  8023e4:	39 ce                	cmp    %ecx,%esi
  8023e6:	77 28                	ja     802410 <__udivdi3+0x7c>
  8023e8:	0f bd fe             	bsr    %esi,%edi
  8023eb:	83 f7 1f             	xor    $0x1f,%edi
  8023ee:	75 40                	jne    802430 <__udivdi3+0x9c>
  8023f0:	39 ce                	cmp    %ecx,%esi
  8023f2:	72 0a                	jb     8023fe <__udivdi3+0x6a>
  8023f4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8023f8:	0f 87 9e 00 00 00    	ja     80249c <__udivdi3+0x108>
  8023fe:	b8 01 00 00 00       	mov    $0x1,%eax
  802403:	89 fa                	mov    %edi,%edx
  802405:	83 c4 1c             	add    $0x1c,%esp
  802408:	5b                   	pop    %ebx
  802409:	5e                   	pop    %esi
  80240a:	5f                   	pop    %edi
  80240b:	5d                   	pop    %ebp
  80240c:	c3                   	ret    
  80240d:	8d 76 00             	lea    0x0(%esi),%esi
  802410:	31 ff                	xor    %edi,%edi
  802412:	31 c0                	xor    %eax,%eax
  802414:	89 fa                	mov    %edi,%edx
  802416:	83 c4 1c             	add    $0x1c,%esp
  802419:	5b                   	pop    %ebx
  80241a:	5e                   	pop    %esi
  80241b:	5f                   	pop    %edi
  80241c:	5d                   	pop    %ebp
  80241d:	c3                   	ret    
  80241e:	66 90                	xchg   %ax,%ax
  802420:	89 d8                	mov    %ebx,%eax
  802422:	f7 f7                	div    %edi
  802424:	31 ff                	xor    %edi,%edi
  802426:	89 fa                	mov    %edi,%edx
  802428:	83 c4 1c             	add    $0x1c,%esp
  80242b:	5b                   	pop    %ebx
  80242c:	5e                   	pop    %esi
  80242d:	5f                   	pop    %edi
  80242e:	5d                   	pop    %ebp
  80242f:	c3                   	ret    
  802430:	bd 20 00 00 00       	mov    $0x20,%ebp
  802435:	89 eb                	mov    %ebp,%ebx
  802437:	29 fb                	sub    %edi,%ebx
  802439:	89 f9                	mov    %edi,%ecx
  80243b:	d3 e6                	shl    %cl,%esi
  80243d:	89 c5                	mov    %eax,%ebp
  80243f:	88 d9                	mov    %bl,%cl
  802441:	d3 ed                	shr    %cl,%ebp
  802443:	89 e9                	mov    %ebp,%ecx
  802445:	09 f1                	or     %esi,%ecx
  802447:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80244b:	89 f9                	mov    %edi,%ecx
  80244d:	d3 e0                	shl    %cl,%eax
  80244f:	89 c5                	mov    %eax,%ebp
  802451:	89 d6                	mov    %edx,%esi
  802453:	88 d9                	mov    %bl,%cl
  802455:	d3 ee                	shr    %cl,%esi
  802457:	89 f9                	mov    %edi,%ecx
  802459:	d3 e2                	shl    %cl,%edx
  80245b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80245f:	88 d9                	mov    %bl,%cl
  802461:	d3 e8                	shr    %cl,%eax
  802463:	09 c2                	or     %eax,%edx
  802465:	89 d0                	mov    %edx,%eax
  802467:	89 f2                	mov    %esi,%edx
  802469:	f7 74 24 0c          	divl   0xc(%esp)
  80246d:	89 d6                	mov    %edx,%esi
  80246f:	89 c3                	mov    %eax,%ebx
  802471:	f7 e5                	mul    %ebp
  802473:	39 d6                	cmp    %edx,%esi
  802475:	72 19                	jb     802490 <__udivdi3+0xfc>
  802477:	74 0b                	je     802484 <__udivdi3+0xf0>
  802479:	89 d8                	mov    %ebx,%eax
  80247b:	31 ff                	xor    %edi,%edi
  80247d:	e9 58 ff ff ff       	jmp    8023da <__udivdi3+0x46>
  802482:	66 90                	xchg   %ax,%ax
  802484:	8b 54 24 08          	mov    0x8(%esp),%edx
  802488:	89 f9                	mov    %edi,%ecx
  80248a:	d3 e2                	shl    %cl,%edx
  80248c:	39 c2                	cmp    %eax,%edx
  80248e:	73 e9                	jae    802479 <__udivdi3+0xe5>
  802490:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802493:	31 ff                	xor    %edi,%edi
  802495:	e9 40 ff ff ff       	jmp    8023da <__udivdi3+0x46>
  80249a:	66 90                	xchg   %ax,%ax
  80249c:	31 c0                	xor    %eax,%eax
  80249e:	e9 37 ff ff ff       	jmp    8023da <__udivdi3+0x46>
  8024a3:	90                   	nop

008024a4 <__umoddi3>:
  8024a4:	55                   	push   %ebp
  8024a5:	57                   	push   %edi
  8024a6:	56                   	push   %esi
  8024a7:	53                   	push   %ebx
  8024a8:	83 ec 1c             	sub    $0x1c,%esp
  8024ab:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8024af:	8b 74 24 34          	mov    0x34(%esp),%esi
  8024b3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8024b7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8024bb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8024bf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8024c3:	89 f3                	mov    %esi,%ebx
  8024c5:	89 fa                	mov    %edi,%edx
  8024c7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024cb:	89 34 24             	mov    %esi,(%esp)
  8024ce:	85 c0                	test   %eax,%eax
  8024d0:	75 1a                	jne    8024ec <__umoddi3+0x48>
  8024d2:	39 f7                	cmp    %esi,%edi
  8024d4:	0f 86 a2 00 00 00    	jbe    80257c <__umoddi3+0xd8>
  8024da:	89 c8                	mov    %ecx,%eax
  8024dc:	89 f2                	mov    %esi,%edx
  8024de:	f7 f7                	div    %edi
  8024e0:	89 d0                	mov    %edx,%eax
  8024e2:	31 d2                	xor    %edx,%edx
  8024e4:	83 c4 1c             	add    $0x1c,%esp
  8024e7:	5b                   	pop    %ebx
  8024e8:	5e                   	pop    %esi
  8024e9:	5f                   	pop    %edi
  8024ea:	5d                   	pop    %ebp
  8024eb:	c3                   	ret    
  8024ec:	39 f0                	cmp    %esi,%eax
  8024ee:	0f 87 ac 00 00 00    	ja     8025a0 <__umoddi3+0xfc>
  8024f4:	0f bd e8             	bsr    %eax,%ebp
  8024f7:	83 f5 1f             	xor    $0x1f,%ebp
  8024fa:	0f 84 ac 00 00 00    	je     8025ac <__umoddi3+0x108>
  802500:	bf 20 00 00 00       	mov    $0x20,%edi
  802505:	29 ef                	sub    %ebp,%edi
  802507:	89 fe                	mov    %edi,%esi
  802509:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80250d:	89 e9                	mov    %ebp,%ecx
  80250f:	d3 e0                	shl    %cl,%eax
  802511:	89 d7                	mov    %edx,%edi
  802513:	89 f1                	mov    %esi,%ecx
  802515:	d3 ef                	shr    %cl,%edi
  802517:	09 c7                	or     %eax,%edi
  802519:	89 e9                	mov    %ebp,%ecx
  80251b:	d3 e2                	shl    %cl,%edx
  80251d:	89 14 24             	mov    %edx,(%esp)
  802520:	89 d8                	mov    %ebx,%eax
  802522:	d3 e0                	shl    %cl,%eax
  802524:	89 c2                	mov    %eax,%edx
  802526:	8b 44 24 08          	mov    0x8(%esp),%eax
  80252a:	d3 e0                	shl    %cl,%eax
  80252c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802530:	8b 44 24 08          	mov    0x8(%esp),%eax
  802534:	89 f1                	mov    %esi,%ecx
  802536:	d3 e8                	shr    %cl,%eax
  802538:	09 d0                	or     %edx,%eax
  80253a:	d3 eb                	shr    %cl,%ebx
  80253c:	89 da                	mov    %ebx,%edx
  80253e:	f7 f7                	div    %edi
  802540:	89 d3                	mov    %edx,%ebx
  802542:	f7 24 24             	mull   (%esp)
  802545:	89 c6                	mov    %eax,%esi
  802547:	89 d1                	mov    %edx,%ecx
  802549:	39 d3                	cmp    %edx,%ebx
  80254b:	0f 82 87 00 00 00    	jb     8025d8 <__umoddi3+0x134>
  802551:	0f 84 91 00 00 00    	je     8025e8 <__umoddi3+0x144>
  802557:	8b 54 24 04          	mov    0x4(%esp),%edx
  80255b:	29 f2                	sub    %esi,%edx
  80255d:	19 cb                	sbb    %ecx,%ebx
  80255f:	89 d8                	mov    %ebx,%eax
  802561:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802565:	d3 e0                	shl    %cl,%eax
  802567:	89 e9                	mov    %ebp,%ecx
  802569:	d3 ea                	shr    %cl,%edx
  80256b:	09 d0                	or     %edx,%eax
  80256d:	89 e9                	mov    %ebp,%ecx
  80256f:	d3 eb                	shr    %cl,%ebx
  802571:	89 da                	mov    %ebx,%edx
  802573:	83 c4 1c             	add    $0x1c,%esp
  802576:	5b                   	pop    %ebx
  802577:	5e                   	pop    %esi
  802578:	5f                   	pop    %edi
  802579:	5d                   	pop    %ebp
  80257a:	c3                   	ret    
  80257b:	90                   	nop
  80257c:	89 fd                	mov    %edi,%ebp
  80257e:	85 ff                	test   %edi,%edi
  802580:	75 0b                	jne    80258d <__umoddi3+0xe9>
  802582:	b8 01 00 00 00       	mov    $0x1,%eax
  802587:	31 d2                	xor    %edx,%edx
  802589:	f7 f7                	div    %edi
  80258b:	89 c5                	mov    %eax,%ebp
  80258d:	89 f0                	mov    %esi,%eax
  80258f:	31 d2                	xor    %edx,%edx
  802591:	f7 f5                	div    %ebp
  802593:	89 c8                	mov    %ecx,%eax
  802595:	f7 f5                	div    %ebp
  802597:	89 d0                	mov    %edx,%eax
  802599:	e9 44 ff ff ff       	jmp    8024e2 <__umoddi3+0x3e>
  80259e:	66 90                	xchg   %ax,%ax
  8025a0:	89 c8                	mov    %ecx,%eax
  8025a2:	89 f2                	mov    %esi,%edx
  8025a4:	83 c4 1c             	add    $0x1c,%esp
  8025a7:	5b                   	pop    %ebx
  8025a8:	5e                   	pop    %esi
  8025a9:	5f                   	pop    %edi
  8025aa:	5d                   	pop    %ebp
  8025ab:	c3                   	ret    
  8025ac:	3b 04 24             	cmp    (%esp),%eax
  8025af:	72 06                	jb     8025b7 <__umoddi3+0x113>
  8025b1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8025b5:	77 0f                	ja     8025c6 <__umoddi3+0x122>
  8025b7:	89 f2                	mov    %esi,%edx
  8025b9:	29 f9                	sub    %edi,%ecx
  8025bb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8025bf:	89 14 24             	mov    %edx,(%esp)
  8025c2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8025c6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8025ca:	8b 14 24             	mov    (%esp),%edx
  8025cd:	83 c4 1c             	add    $0x1c,%esp
  8025d0:	5b                   	pop    %ebx
  8025d1:	5e                   	pop    %esi
  8025d2:	5f                   	pop    %edi
  8025d3:	5d                   	pop    %ebp
  8025d4:	c3                   	ret    
  8025d5:	8d 76 00             	lea    0x0(%esi),%esi
  8025d8:	2b 04 24             	sub    (%esp),%eax
  8025db:	19 fa                	sbb    %edi,%edx
  8025dd:	89 d1                	mov    %edx,%ecx
  8025df:	89 c6                	mov    %eax,%esi
  8025e1:	e9 71 ff ff ff       	jmp    802557 <__umoddi3+0xb3>
  8025e6:	66 90                	xchg   %ax,%ax
  8025e8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8025ec:	72 ea                	jb     8025d8 <__umoddi3+0x134>
  8025ee:	89 d9                	mov    %ebx,%ecx
  8025f0:	e9 62 ff ff ff       	jmp    802557 <__umoddi3+0xb3>
