
obj/user/quicksort_interrupt:     file format elf32-i386


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
  800031:	e8 e6 05 00 00       	call   80061c <libmain>
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
  80003b:	53                   	push   %ebx
  80003c:	81 ec 24 01 00 00    	sub    $0x124,%esp
	char Chose ;
	char Line[255] ;
	int Iteration = 0 ;
  800042:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800049:	e8 e3 1e 00 00       	call   801f31 <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 f5 1e 00 00       	call   801f4a <sys_calculate_modified_frames>
  800055:	01 d8                	add    %ebx,%eax
  800057:	89 45 f0             	mov    %eax,-0x10(%ebp)

		Iteration++ ;
  80005a:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();

		sys_disable_interrupt();
  80005d:	e8 9f 1f 00 00       	call   802001 <sys_disable_interrupt>
			readline("Enter the number of elements: ", Line);
  800062:	83 ec 08             	sub    $0x8,%esp
  800065:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  80006b:	50                   	push   %eax
  80006c:	68 a0 26 80 00       	push   $0x8026a0
  800071:	e8 0f 10 00 00       	call   801085 <readline>
  800076:	83 c4 10             	add    $0x10,%esp
			int NumOfElements = strtol(Line, NULL, 10) ;
  800079:	83 ec 04             	sub    $0x4,%esp
  80007c:	6a 0a                	push   $0xa
  80007e:	6a 00                	push   $0x0
  800080:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800086:	50                   	push   %eax
  800087:	e8 5f 15 00 00       	call   8015eb <strtol>
  80008c:	83 c4 10             	add    $0x10,%esp
  80008f:	89 45 ec             	mov    %eax,-0x14(%ebp)
			int *Elements = malloc(sizeof(int) * NumOfElements) ;
  800092:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800095:	c1 e0 02             	shl    $0x2,%eax
  800098:	83 ec 0c             	sub    $0xc,%esp
  80009b:	50                   	push   %eax
  80009c:	e8 f2 18 00 00       	call   801993 <malloc>
  8000a1:	83 c4 10             	add    $0x10,%esp
  8000a4:	89 45 e8             	mov    %eax,-0x18(%ebp)
			cprintf("Choose the initialization method:\n") ;
  8000a7:	83 ec 0c             	sub    $0xc,%esp
  8000aa:	68 c0 26 80 00       	push   $0x8026c0
  8000af:	e8 4f 09 00 00       	call   800a03 <cprintf>
  8000b4:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000b7:	83 ec 0c             	sub    $0xc,%esp
  8000ba:	68 e3 26 80 00       	push   $0x8026e3
  8000bf:	e8 3f 09 00 00       	call   800a03 <cprintf>
  8000c4:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000c7:	83 ec 0c             	sub    $0xc,%esp
  8000ca:	68 f1 26 80 00       	push   $0x8026f1
  8000cf:	e8 2f 09 00 00       	call   800a03 <cprintf>
  8000d4:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\n");
  8000d7:	83 ec 0c             	sub    $0xc,%esp
  8000da:	68 00 27 80 00       	push   $0x802700
  8000df:	e8 1f 09 00 00       	call   800a03 <cprintf>
  8000e4:	83 c4 10             	add    $0x10,%esp
					do
					{
						cprintf("Select: ") ;
  8000e7:	83 ec 0c             	sub    $0xc,%esp
  8000ea:	68 10 27 80 00       	push   $0x802710
  8000ef:	e8 0f 09 00 00       	call   800a03 <cprintf>
  8000f4:	83 c4 10             	add    $0x10,%esp
						Chose = getchar() ;
  8000f7:	e8 c8 04 00 00       	call   8005c4 <getchar>
  8000fc:	88 45 e7             	mov    %al,-0x19(%ebp)
						cputchar(Chose);
  8000ff:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  800103:	83 ec 0c             	sub    $0xc,%esp
  800106:	50                   	push   %eax
  800107:	e8 70 04 00 00       	call   80057c <cputchar>
  80010c:	83 c4 10             	add    $0x10,%esp
						cputchar('\n');
  80010f:	83 ec 0c             	sub    $0xc,%esp
  800112:	6a 0a                	push   $0xa
  800114:	e8 63 04 00 00       	call   80057c <cputchar>
  800119:	83 c4 10             	add    $0x10,%esp
					} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  80011c:	80 7d e7 61          	cmpb   $0x61,-0x19(%ebp)
  800120:	74 0c                	je     80012e <_main+0xf6>
  800122:	80 7d e7 62          	cmpb   $0x62,-0x19(%ebp)
  800126:	74 06                	je     80012e <_main+0xf6>
  800128:	80 7d e7 63          	cmpb   $0x63,-0x19(%ebp)
  80012c:	75 b9                	jne    8000e7 <_main+0xaf>
							sys_enable_interrupt();
  80012e:	e8 e8 1e 00 00       	call   80201b <sys_enable_interrupt>
		//sys_enable_interrupt();
		int  i ;
		switch (Chose)
  800133:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  800137:	83 f8 62             	cmp    $0x62,%eax
  80013a:	74 1d                	je     800159 <_main+0x121>
  80013c:	83 f8 63             	cmp    $0x63,%eax
  80013f:	74 2b                	je     80016c <_main+0x134>
  800141:	83 f8 61             	cmp    $0x61,%eax
  800144:	75 39                	jne    80017f <_main+0x147>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800146:	83 ec 08             	sub    $0x8,%esp
  800149:	ff 75 ec             	pushl  -0x14(%ebp)
  80014c:	ff 75 e8             	pushl  -0x18(%ebp)
  80014f:	e8 e6 02 00 00       	call   80043a <InitializeAscending>
  800154:	83 c4 10             	add    $0x10,%esp
			break ;
  800157:	eb 37                	jmp    800190 <_main+0x158>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  800159:	83 ec 08             	sub    $0x8,%esp
  80015c:	ff 75 ec             	pushl  -0x14(%ebp)
  80015f:	ff 75 e8             	pushl  -0x18(%ebp)
  800162:	e8 04 03 00 00       	call   80046b <InitializeDescending>
  800167:	83 c4 10             	add    $0x10,%esp
			break ;
  80016a:	eb 24                	jmp    800190 <_main+0x158>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  80016c:	83 ec 08             	sub    $0x8,%esp
  80016f:	ff 75 ec             	pushl  -0x14(%ebp)
  800172:	ff 75 e8             	pushl  -0x18(%ebp)
  800175:	e8 26 03 00 00       	call   8004a0 <InitializeSemiRandom>
  80017a:	83 c4 10             	add    $0x10,%esp
			break ;
  80017d:	eb 11                	jmp    800190 <_main+0x158>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  80017f:	83 ec 08             	sub    $0x8,%esp
  800182:	ff 75 ec             	pushl  -0x14(%ebp)
  800185:	ff 75 e8             	pushl  -0x18(%ebp)
  800188:	e8 13 03 00 00       	call   8004a0 <InitializeSemiRandom>
  80018d:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  800190:	83 ec 08             	sub    $0x8,%esp
  800193:	ff 75 ec             	pushl  -0x14(%ebp)
  800196:	ff 75 e8             	pushl  -0x18(%ebp)
  800199:	e8 e1 00 00 00       	call   80027f <QuickSort>
  80019e:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001a1:	83 ec 08             	sub    $0x8,%esp
  8001a4:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a7:	ff 75 e8             	pushl  -0x18(%ebp)
  8001aa:	e8 e1 01 00 00       	call   800390 <CheckSorted>
  8001af:	83 c4 10             	add    $0x10,%esp
  8001b2:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001b5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8001b9:	75 14                	jne    8001cf <_main+0x197>
  8001bb:	83 ec 04             	sub    $0x4,%esp
  8001be:	68 1c 27 80 00       	push   $0x80271c
  8001c3:	6a 46                	push   $0x46
  8001c5:	68 3e 27 80 00       	push   $0x80273e
  8001ca:	e8 92 05 00 00       	call   800761 <_panic>
		else
		{ 
			sys_disable_interrupt();
  8001cf:	e8 2d 1e 00 00       	call   802001 <sys_disable_interrupt>
				cprintf("\n===============================================\n") ;
  8001d4:	83 ec 0c             	sub    $0xc,%esp
  8001d7:	68 5c 27 80 00       	push   $0x80275c
  8001dc:	e8 22 08 00 00       	call   800a03 <cprintf>
  8001e1:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001e4:	83 ec 0c             	sub    $0xc,%esp
  8001e7:	68 90 27 80 00       	push   $0x802790
  8001ec:	e8 12 08 00 00       	call   800a03 <cprintf>
  8001f1:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  8001f4:	83 ec 0c             	sub    $0xc,%esp
  8001f7:	68 c4 27 80 00       	push   $0x8027c4
  8001fc:	e8 02 08 00 00       	call   800a03 <cprintf>
  800201:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800204:	e8 12 1e 00 00       	call   80201b <sys_enable_interrupt>
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		sys_disable_interrupt();
  800209:	e8 f3 1d 00 00       	call   802001 <sys_disable_interrupt>
			cprintf("Freeing the Heap...\n\n") ;
  80020e:	83 ec 0c             	sub    $0xc,%esp
  800211:	68 f6 27 80 00       	push   $0x8027f6
  800216:	e8 e8 07 00 00       	call   800a03 <cprintf>
  80021b:	83 c4 10             	add    $0x10,%esp
		sys_enable_interrupt();
  80021e:	e8 f8 1d 00 00       	call   80201b <sys_enable_interrupt>

		//freeHeap() ;

		///========================================================================
	//sys_disable_interrupt();
		sys_disable_interrupt();
  800223:	e8 d9 1d 00 00       	call   802001 <sys_disable_interrupt>
			cprintf("Do you want to repeat (y/n): ") ;
  800228:	83 ec 0c             	sub    $0xc,%esp
  80022b:	68 0c 28 80 00       	push   $0x80280c
  800230:	e8 ce 07 00 00       	call   800a03 <cprintf>
  800235:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800238:	e8 87 03 00 00       	call   8005c4 <getchar>
  80023d:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  800240:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	50                   	push   %eax
  800248:	e8 2f 03 00 00       	call   80057c <cputchar>
  80024d:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800250:	83 ec 0c             	sub    $0xc,%esp
  800253:	6a 0a                	push   $0xa
  800255:	e8 22 03 00 00       	call   80057c <cputchar>
  80025a:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80025d:	83 ec 0c             	sub    $0xc,%esp
  800260:	6a 0a                	push   $0xa
  800262:	e8 15 03 00 00       	call   80057c <cputchar>
  800267:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();
		sys_enable_interrupt();
  80026a:	e8 ac 1d 00 00       	call   80201b <sys_enable_interrupt>

	} while (Chose == 'y');
  80026f:	80 7d e7 79          	cmpb   $0x79,-0x19(%ebp)
  800273:	0f 84 d0 fd ff ff    	je     800049 <_main+0x11>

}
  800279:	90                   	nop
  80027a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80027d:	c9                   	leave  
  80027e:	c3                   	ret    

0080027f <QuickSort>:

///Quick sort 
void QuickSort(int *Elements, int NumOfElements)
{
  80027f:	55                   	push   %ebp
  800280:	89 e5                	mov    %esp,%ebp
  800282:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  800285:	8b 45 0c             	mov    0xc(%ebp),%eax
  800288:	48                   	dec    %eax
  800289:	50                   	push   %eax
  80028a:	6a 00                	push   $0x0
  80028c:	ff 75 0c             	pushl  0xc(%ebp)
  80028f:	ff 75 08             	pushl  0x8(%ebp)
  800292:	e8 06 00 00 00       	call   80029d <QSort>
  800297:	83 c4 10             	add    $0x10,%esp
}
  80029a:	90                   	nop
  80029b:	c9                   	leave  
  80029c:	c3                   	ret    

0080029d <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  80029d:	55                   	push   %ebp
  80029e:	89 e5                	mov    %esp,%ebp
  8002a0:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8002a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8002a6:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002a9:	0f 8d de 00 00 00    	jge    80038d <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8002af:	8b 45 10             	mov    0x10(%ebp),%eax
  8002b2:	40                   	inc    %eax
  8002b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8002b9:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002bc:	e9 80 00 00 00       	jmp    800341 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8002c1:	ff 45 f4             	incl   -0xc(%ebp)
  8002c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002c7:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002ca:	7f 2b                	jg     8002f7 <QSort+0x5a>
  8002cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8002cf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d9:	01 d0                	add    %edx,%eax
  8002db:	8b 10                	mov    (%eax),%edx
  8002dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002e0:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8002ea:	01 c8                	add    %ecx,%eax
  8002ec:	8b 00                	mov    (%eax),%eax
  8002ee:	39 c2                	cmp    %eax,%edx
  8002f0:	7d cf                	jge    8002c1 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002f2:	eb 03                	jmp    8002f7 <QSort+0x5a>
  8002f4:	ff 4d f0             	decl   -0x10(%ebp)
  8002f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002fa:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002fd:	7e 26                	jle    800325 <QSort+0x88>
  8002ff:	8b 45 10             	mov    0x10(%ebp),%eax
  800302:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800309:	8b 45 08             	mov    0x8(%ebp),%eax
  80030c:	01 d0                	add    %edx,%eax
  80030e:	8b 10                	mov    (%eax),%edx
  800310:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800313:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80031a:	8b 45 08             	mov    0x8(%ebp),%eax
  80031d:	01 c8                	add    %ecx,%eax
  80031f:	8b 00                	mov    (%eax),%eax
  800321:	39 c2                	cmp    %eax,%edx
  800323:	7e cf                	jle    8002f4 <QSort+0x57>

		if (i <= j)
  800325:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800328:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80032b:	7f 14                	jg     800341 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  80032d:	83 ec 04             	sub    $0x4,%esp
  800330:	ff 75 f0             	pushl  -0x10(%ebp)
  800333:	ff 75 f4             	pushl  -0xc(%ebp)
  800336:	ff 75 08             	pushl  0x8(%ebp)
  800339:	e8 a9 00 00 00       	call   8003e7 <Swap>
  80033e:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800341:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800344:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800347:	0f 8e 77 ff ff ff    	jle    8002c4 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  80034d:	83 ec 04             	sub    $0x4,%esp
  800350:	ff 75 f0             	pushl  -0x10(%ebp)
  800353:	ff 75 10             	pushl  0x10(%ebp)
  800356:	ff 75 08             	pushl  0x8(%ebp)
  800359:	e8 89 00 00 00       	call   8003e7 <Swap>
  80035e:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800361:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800364:	48                   	dec    %eax
  800365:	50                   	push   %eax
  800366:	ff 75 10             	pushl  0x10(%ebp)
  800369:	ff 75 0c             	pushl  0xc(%ebp)
  80036c:	ff 75 08             	pushl  0x8(%ebp)
  80036f:	e8 29 ff ff ff       	call   80029d <QSort>
  800374:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800377:	ff 75 14             	pushl  0x14(%ebp)
  80037a:	ff 75 f4             	pushl  -0xc(%ebp)
  80037d:	ff 75 0c             	pushl  0xc(%ebp)
  800380:	ff 75 08             	pushl  0x8(%ebp)
  800383:	e8 15 ff ff ff       	call   80029d <QSort>
  800388:	83 c4 10             	add    $0x10,%esp
  80038b:	eb 01                	jmp    80038e <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  80038d:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  80038e:	c9                   	leave  
  80038f:	c3                   	ret    

00800390 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800390:	55                   	push   %ebp
  800391:	89 e5                	mov    %esp,%ebp
  800393:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  800396:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80039d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8003a4:	eb 33                	jmp    8003d9 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8003a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003a9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b3:	01 d0                	add    %edx,%eax
  8003b5:	8b 10                	mov    (%eax),%edx
  8003b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003ba:	40                   	inc    %eax
  8003bb:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c5:	01 c8                	add    %ecx,%eax
  8003c7:	8b 00                	mov    (%eax),%eax
  8003c9:	39 c2                	cmp    %eax,%edx
  8003cb:	7e 09                	jle    8003d6 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8003d4:	eb 0c                	jmp    8003e2 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003d6:	ff 45 f8             	incl   -0x8(%ebp)
  8003d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003dc:	48                   	dec    %eax
  8003dd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8003e0:	7f c4                	jg     8003a6 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003e5:	c9                   	leave  
  8003e6:	c3                   	ret    

008003e7 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003e7:	55                   	push   %ebp
  8003e8:	89 e5                	mov    %esp,%ebp
  8003ea:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003f0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fa:	01 d0                	add    %edx,%eax
  8003fc:	8b 00                	mov    (%eax),%eax
  8003fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800401:	8b 45 0c             	mov    0xc(%ebp),%eax
  800404:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80040b:	8b 45 08             	mov    0x8(%ebp),%eax
  80040e:	01 c2                	add    %eax,%edx
  800410:	8b 45 10             	mov    0x10(%ebp),%eax
  800413:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80041a:	8b 45 08             	mov    0x8(%ebp),%eax
  80041d:	01 c8                	add    %ecx,%eax
  80041f:	8b 00                	mov    (%eax),%eax
  800421:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800423:	8b 45 10             	mov    0x10(%ebp),%eax
  800426:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80042d:	8b 45 08             	mov    0x8(%ebp),%eax
  800430:	01 c2                	add    %eax,%edx
  800432:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800435:	89 02                	mov    %eax,(%edx)
}
  800437:	90                   	nop
  800438:	c9                   	leave  
  800439:	c3                   	ret    

0080043a <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80043a:	55                   	push   %ebp
  80043b:	89 e5                	mov    %esp,%ebp
  80043d:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800440:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800447:	eb 17                	jmp    800460 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800449:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80044c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800453:	8b 45 08             	mov    0x8(%ebp),%eax
  800456:	01 c2                	add    %eax,%edx
  800458:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80045b:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80045d:	ff 45 fc             	incl   -0x4(%ebp)
  800460:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800463:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800466:	7c e1                	jl     800449 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800468:	90                   	nop
  800469:	c9                   	leave  
  80046a:	c3                   	ret    

0080046b <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  80046b:	55                   	push   %ebp
  80046c:	89 e5                	mov    %esp,%ebp
  80046e:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800471:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800478:	eb 1b                	jmp    800495 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  80047a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80047d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800484:	8b 45 08             	mov    0x8(%ebp),%eax
  800487:	01 c2                	add    %eax,%edx
  800489:	8b 45 0c             	mov    0xc(%ebp),%eax
  80048c:	2b 45 fc             	sub    -0x4(%ebp),%eax
  80048f:	48                   	dec    %eax
  800490:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800492:	ff 45 fc             	incl   -0x4(%ebp)
  800495:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800498:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80049b:	7c dd                	jl     80047a <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  80049d:	90                   	nop
  80049e:	c9                   	leave  
  80049f:	c3                   	ret    

008004a0 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8004a0:	55                   	push   %ebp
  8004a1:	89 e5                	mov    %esp,%ebp
  8004a3:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8004a6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004a9:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8004ae:	f7 e9                	imul   %ecx
  8004b0:	c1 f9 1f             	sar    $0x1f,%ecx
  8004b3:	89 d0                	mov    %edx,%eax
  8004b5:	29 c8                	sub    %ecx,%eax
  8004b7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004c1:	eb 1e                	jmp    8004e1 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8004c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004c6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d0:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8004d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004d6:	99                   	cltd   
  8004d7:	f7 7d f8             	idivl  -0x8(%ebp)
  8004da:	89 d0                	mov    %edx,%eax
  8004dc:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004de:	ff 45 fc             	incl   -0x4(%ebp)
  8004e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004e4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004e7:	7c da                	jl     8004c3 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8004e9:	90                   	nop
  8004ea:	c9                   	leave  
  8004eb:	c3                   	ret    

008004ec <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004ec:	55                   	push   %ebp
  8004ed:	89 e5                	mov    %esp,%ebp
  8004ef:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8004f2:	e8 0a 1b 00 00       	call   802001 <sys_disable_interrupt>
		int i ;
		int NumsPerLine = 20 ;
  8004f7:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
		for (i = 0 ; i < NumOfElements-1 ; i++)
  8004fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800505:	eb 42                	jmp    800549 <PrintElements+0x5d>
		{
			if (i%NumsPerLine == 0)
  800507:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80050a:	99                   	cltd   
  80050b:	f7 7d f0             	idivl  -0x10(%ebp)
  80050e:	89 d0                	mov    %edx,%eax
  800510:	85 c0                	test   %eax,%eax
  800512:	75 10                	jne    800524 <PrintElements+0x38>
				cprintf("\n");
  800514:	83 ec 0c             	sub    $0xc,%esp
  800517:	68 2a 28 80 00       	push   $0x80282a
  80051c:	e8 e2 04 00 00       	call   800a03 <cprintf>
  800521:	83 c4 10             	add    $0x10,%esp
			cprintf("%d, ",Elements[i]);
  800524:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800527:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80052e:	8b 45 08             	mov    0x8(%ebp),%eax
  800531:	01 d0                	add    %edx,%eax
  800533:	8b 00                	mov    (%eax),%eax
  800535:	83 ec 08             	sub    $0x8,%esp
  800538:	50                   	push   %eax
  800539:	68 2c 28 80 00       	push   $0x80282c
  80053e:	e8 c0 04 00 00       	call   800a03 <cprintf>
  800543:	83 c4 10             	add    $0x10,%esp
void PrintElements(int *Elements, int NumOfElements)
{
	sys_disable_interrupt();
		int i ;
		int NumsPerLine = 20 ;
		for (i = 0 ; i < NumOfElements-1 ; i++)
  800546:	ff 45 f4             	incl   -0xc(%ebp)
  800549:	8b 45 0c             	mov    0xc(%ebp),%eax
  80054c:	48                   	dec    %eax
  80054d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800550:	7f b5                	jg     800507 <PrintElements+0x1b>
		{
			if (i%NumsPerLine == 0)
				cprintf("\n");
			cprintf("%d, ",Elements[i]);
		}
		cprintf("%d\n",Elements[i]);
  800552:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800555:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80055c:	8b 45 08             	mov    0x8(%ebp),%eax
  80055f:	01 d0                	add    %edx,%eax
  800561:	8b 00                	mov    (%eax),%eax
  800563:	83 ec 08             	sub    $0x8,%esp
  800566:	50                   	push   %eax
  800567:	68 31 28 80 00       	push   $0x802831
  80056c:	e8 92 04 00 00       	call   800a03 <cprintf>
  800571:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800574:	e8 a2 1a 00 00       	call   80201b <sys_enable_interrupt>
}
  800579:	90                   	nop
  80057a:	c9                   	leave  
  80057b:	c3                   	ret    

0080057c <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80057c:	55                   	push   %ebp
  80057d:	89 e5                	mov    %esp,%ebp
  80057f:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800582:	8b 45 08             	mov    0x8(%ebp),%eax
  800585:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800588:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80058c:	83 ec 0c             	sub    $0xc,%esp
  80058f:	50                   	push   %eax
  800590:	e8 a0 1a 00 00       	call   802035 <sys_cputc>
  800595:	83 c4 10             	add    $0x10,%esp
}
  800598:	90                   	nop
  800599:	c9                   	leave  
  80059a:	c3                   	ret    

0080059b <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80059b:	55                   	push   %ebp
  80059c:	89 e5                	mov    %esp,%ebp
  80059e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005a1:	e8 5b 1a 00 00       	call   802001 <sys_disable_interrupt>
	char c = ch;
  8005a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a9:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005ac:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005b0:	83 ec 0c             	sub    $0xc,%esp
  8005b3:	50                   	push   %eax
  8005b4:	e8 7c 1a 00 00       	call   802035 <sys_cputc>
  8005b9:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8005bc:	e8 5a 1a 00 00       	call   80201b <sys_enable_interrupt>
}
  8005c1:	90                   	nop
  8005c2:	c9                   	leave  
  8005c3:	c3                   	ret    

008005c4 <getchar>:

int
getchar(void)
{
  8005c4:	55                   	push   %ebp
  8005c5:	89 e5                	mov    %esp,%ebp
  8005c7:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8005ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005d1:	eb 08                	jmp    8005db <getchar+0x17>
	{
		c = sys_cgetc();
  8005d3:	e8 41 18 00 00       	call   801e19 <sys_cgetc>
  8005d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8005db:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005df:	74 f2                	je     8005d3 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8005e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005e4:	c9                   	leave  
  8005e5:	c3                   	ret    

008005e6 <atomic_getchar>:

int
atomic_getchar(void)
{
  8005e6:	55                   	push   %ebp
  8005e7:	89 e5                	mov    %esp,%ebp
  8005e9:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005ec:	e8 10 1a 00 00       	call   802001 <sys_disable_interrupt>
	int c=0;
  8005f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005f8:	eb 08                	jmp    800602 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005fa:	e8 1a 18 00 00       	call   801e19 <sys_cgetc>
  8005ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  800602:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800606:	74 f2                	je     8005fa <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800608:	e8 0e 1a 00 00       	call   80201b <sys_enable_interrupt>
	return c;
  80060d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800610:	c9                   	leave  
  800611:	c3                   	ret    

00800612 <iscons>:

int iscons(int fdnum)
{
  800612:	55                   	push   %ebp
  800613:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800615:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80061a:	5d                   	pop    %ebp
  80061b:	c3                   	ret    

0080061c <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80061c:	55                   	push   %ebp
  80061d:	89 e5                	mov    %esp,%ebp
  80061f:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800622:	e8 3f 18 00 00       	call   801e66 <sys_getenvindex>
  800627:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80062a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80062d:	89 d0                	mov    %edx,%eax
  80062f:	c1 e0 03             	shl    $0x3,%eax
  800632:	01 d0                	add    %edx,%eax
  800634:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80063b:	01 c8                	add    %ecx,%eax
  80063d:	01 c0                	add    %eax,%eax
  80063f:	01 d0                	add    %edx,%eax
  800641:	01 c0                	add    %eax,%eax
  800643:	01 d0                	add    %edx,%eax
  800645:	89 c2                	mov    %eax,%edx
  800647:	c1 e2 05             	shl    $0x5,%edx
  80064a:	29 c2                	sub    %eax,%edx
  80064c:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800653:	89 c2                	mov    %eax,%edx
  800655:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80065b:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800660:	a1 24 30 80 00       	mov    0x803024,%eax
  800665:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80066b:	84 c0                	test   %al,%al
  80066d:	74 0f                	je     80067e <libmain+0x62>
		binaryname = myEnv->prog_name;
  80066f:	a1 24 30 80 00       	mov    0x803024,%eax
  800674:	05 40 3c 01 00       	add    $0x13c40,%eax
  800679:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80067e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800682:	7e 0a                	jle    80068e <libmain+0x72>
		binaryname = argv[0];
  800684:	8b 45 0c             	mov    0xc(%ebp),%eax
  800687:	8b 00                	mov    (%eax),%eax
  800689:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80068e:	83 ec 08             	sub    $0x8,%esp
  800691:	ff 75 0c             	pushl  0xc(%ebp)
  800694:	ff 75 08             	pushl  0x8(%ebp)
  800697:	e8 9c f9 ff ff       	call   800038 <_main>
  80069c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80069f:	e8 5d 19 00 00       	call   802001 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8006a4:	83 ec 0c             	sub    $0xc,%esp
  8006a7:	68 50 28 80 00       	push   $0x802850
  8006ac:	e8 52 03 00 00       	call   800a03 <cprintf>
  8006b1:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006b4:	a1 24 30 80 00       	mov    0x803024,%eax
  8006b9:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8006bf:	a1 24 30 80 00       	mov    0x803024,%eax
  8006c4:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8006ca:	83 ec 04             	sub    $0x4,%esp
  8006cd:	52                   	push   %edx
  8006ce:	50                   	push   %eax
  8006cf:	68 78 28 80 00       	push   $0x802878
  8006d4:	e8 2a 03 00 00       	call   800a03 <cprintf>
  8006d9:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8006dc:	a1 24 30 80 00       	mov    0x803024,%eax
  8006e1:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8006e7:	a1 24 30 80 00       	mov    0x803024,%eax
  8006ec:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8006f2:	83 ec 04             	sub    $0x4,%esp
  8006f5:	52                   	push   %edx
  8006f6:	50                   	push   %eax
  8006f7:	68 a0 28 80 00       	push   $0x8028a0
  8006fc:	e8 02 03 00 00       	call   800a03 <cprintf>
  800701:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800704:	a1 24 30 80 00       	mov    0x803024,%eax
  800709:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80070f:	83 ec 08             	sub    $0x8,%esp
  800712:	50                   	push   %eax
  800713:	68 e1 28 80 00       	push   $0x8028e1
  800718:	e8 e6 02 00 00       	call   800a03 <cprintf>
  80071d:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800720:	83 ec 0c             	sub    $0xc,%esp
  800723:	68 50 28 80 00       	push   $0x802850
  800728:	e8 d6 02 00 00       	call   800a03 <cprintf>
  80072d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800730:	e8 e6 18 00 00       	call   80201b <sys_enable_interrupt>

	// exit gracefully
	exit();
  800735:	e8 19 00 00 00       	call   800753 <exit>
}
  80073a:	90                   	nop
  80073b:	c9                   	leave  
  80073c:	c3                   	ret    

0080073d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80073d:	55                   	push   %ebp
  80073e:	89 e5                	mov    %esp,%ebp
  800740:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800743:	83 ec 0c             	sub    $0xc,%esp
  800746:	6a 00                	push   $0x0
  800748:	e8 e5 16 00 00       	call   801e32 <sys_env_destroy>
  80074d:	83 c4 10             	add    $0x10,%esp
}
  800750:	90                   	nop
  800751:	c9                   	leave  
  800752:	c3                   	ret    

00800753 <exit>:

void
exit(void)
{
  800753:	55                   	push   %ebp
  800754:	89 e5                	mov    %esp,%ebp
  800756:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800759:	e8 3a 17 00 00       	call   801e98 <sys_env_exit>
}
  80075e:	90                   	nop
  80075f:	c9                   	leave  
  800760:	c3                   	ret    

00800761 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800761:	55                   	push   %ebp
  800762:	89 e5                	mov    %esp,%ebp
  800764:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800767:	8d 45 10             	lea    0x10(%ebp),%eax
  80076a:	83 c0 04             	add    $0x4,%eax
  80076d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800770:	a1 18 31 80 00       	mov    0x803118,%eax
  800775:	85 c0                	test   %eax,%eax
  800777:	74 16                	je     80078f <_panic+0x2e>
		cprintf("%s: ", argv0);
  800779:	a1 18 31 80 00       	mov    0x803118,%eax
  80077e:	83 ec 08             	sub    $0x8,%esp
  800781:	50                   	push   %eax
  800782:	68 f8 28 80 00       	push   $0x8028f8
  800787:	e8 77 02 00 00       	call   800a03 <cprintf>
  80078c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80078f:	a1 00 30 80 00       	mov    0x803000,%eax
  800794:	ff 75 0c             	pushl  0xc(%ebp)
  800797:	ff 75 08             	pushl  0x8(%ebp)
  80079a:	50                   	push   %eax
  80079b:	68 fd 28 80 00       	push   $0x8028fd
  8007a0:	e8 5e 02 00 00       	call   800a03 <cprintf>
  8007a5:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8007ab:	83 ec 08             	sub    $0x8,%esp
  8007ae:	ff 75 f4             	pushl  -0xc(%ebp)
  8007b1:	50                   	push   %eax
  8007b2:	e8 e1 01 00 00       	call   800998 <vcprintf>
  8007b7:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8007ba:	83 ec 08             	sub    $0x8,%esp
  8007bd:	6a 00                	push   $0x0
  8007bf:	68 19 29 80 00       	push   $0x802919
  8007c4:	e8 cf 01 00 00       	call   800998 <vcprintf>
  8007c9:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8007cc:	e8 82 ff ff ff       	call   800753 <exit>

	// should not return here
	while (1) ;
  8007d1:	eb fe                	jmp    8007d1 <_panic+0x70>

008007d3 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007d3:	55                   	push   %ebp
  8007d4:	89 e5                	mov    %esp,%ebp
  8007d6:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007d9:	a1 24 30 80 00       	mov    0x803024,%eax
  8007de:	8b 50 74             	mov    0x74(%eax),%edx
  8007e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007e4:	39 c2                	cmp    %eax,%edx
  8007e6:	74 14                	je     8007fc <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007e8:	83 ec 04             	sub    $0x4,%esp
  8007eb:	68 1c 29 80 00       	push   $0x80291c
  8007f0:	6a 26                	push   $0x26
  8007f2:	68 68 29 80 00       	push   $0x802968
  8007f7:	e8 65 ff ff ff       	call   800761 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007fc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800803:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80080a:	e9 b6 00 00 00       	jmp    8008c5 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80080f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800812:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800819:	8b 45 08             	mov    0x8(%ebp),%eax
  80081c:	01 d0                	add    %edx,%eax
  80081e:	8b 00                	mov    (%eax),%eax
  800820:	85 c0                	test   %eax,%eax
  800822:	75 08                	jne    80082c <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800824:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800827:	e9 96 00 00 00       	jmp    8008c2 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80082c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800833:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80083a:	eb 5d                	jmp    800899 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80083c:	a1 24 30 80 00       	mov    0x803024,%eax
  800841:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800847:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80084a:	c1 e2 04             	shl    $0x4,%edx
  80084d:	01 d0                	add    %edx,%eax
  80084f:	8a 40 04             	mov    0x4(%eax),%al
  800852:	84 c0                	test   %al,%al
  800854:	75 40                	jne    800896 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800856:	a1 24 30 80 00       	mov    0x803024,%eax
  80085b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800861:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800864:	c1 e2 04             	shl    $0x4,%edx
  800867:	01 d0                	add    %edx,%eax
  800869:	8b 00                	mov    (%eax),%eax
  80086b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80086e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800871:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800876:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800878:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80087b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800882:	8b 45 08             	mov    0x8(%ebp),%eax
  800885:	01 c8                	add    %ecx,%eax
  800887:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800889:	39 c2                	cmp    %eax,%edx
  80088b:	75 09                	jne    800896 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80088d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800894:	eb 12                	jmp    8008a8 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800896:	ff 45 e8             	incl   -0x18(%ebp)
  800899:	a1 24 30 80 00       	mov    0x803024,%eax
  80089e:	8b 50 74             	mov    0x74(%eax),%edx
  8008a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008a4:	39 c2                	cmp    %eax,%edx
  8008a6:	77 94                	ja     80083c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8008a8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8008ac:	75 14                	jne    8008c2 <CheckWSWithoutLastIndex+0xef>
			panic(
  8008ae:	83 ec 04             	sub    $0x4,%esp
  8008b1:	68 74 29 80 00       	push   $0x802974
  8008b6:	6a 3a                	push   $0x3a
  8008b8:	68 68 29 80 00       	push   $0x802968
  8008bd:	e8 9f fe ff ff       	call   800761 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8008c2:	ff 45 f0             	incl   -0x10(%ebp)
  8008c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008c8:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008cb:	0f 8c 3e ff ff ff    	jl     80080f <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008d1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008d8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008df:	eb 20                	jmp    800901 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008e1:	a1 24 30 80 00       	mov    0x803024,%eax
  8008e6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8008ec:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008ef:	c1 e2 04             	shl    $0x4,%edx
  8008f2:	01 d0                	add    %edx,%eax
  8008f4:	8a 40 04             	mov    0x4(%eax),%al
  8008f7:	3c 01                	cmp    $0x1,%al
  8008f9:	75 03                	jne    8008fe <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8008fb:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008fe:	ff 45 e0             	incl   -0x20(%ebp)
  800901:	a1 24 30 80 00       	mov    0x803024,%eax
  800906:	8b 50 74             	mov    0x74(%eax),%edx
  800909:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80090c:	39 c2                	cmp    %eax,%edx
  80090e:	77 d1                	ja     8008e1 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800910:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800913:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800916:	74 14                	je     80092c <CheckWSWithoutLastIndex+0x159>
		panic(
  800918:	83 ec 04             	sub    $0x4,%esp
  80091b:	68 c8 29 80 00       	push   $0x8029c8
  800920:	6a 44                	push   $0x44
  800922:	68 68 29 80 00       	push   $0x802968
  800927:	e8 35 fe ff ff       	call   800761 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80092c:	90                   	nop
  80092d:	c9                   	leave  
  80092e:	c3                   	ret    

0080092f <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80092f:	55                   	push   %ebp
  800930:	89 e5                	mov    %esp,%ebp
  800932:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800935:	8b 45 0c             	mov    0xc(%ebp),%eax
  800938:	8b 00                	mov    (%eax),%eax
  80093a:	8d 48 01             	lea    0x1(%eax),%ecx
  80093d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800940:	89 0a                	mov    %ecx,(%edx)
  800942:	8b 55 08             	mov    0x8(%ebp),%edx
  800945:	88 d1                	mov    %dl,%cl
  800947:	8b 55 0c             	mov    0xc(%ebp),%edx
  80094a:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80094e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800951:	8b 00                	mov    (%eax),%eax
  800953:	3d ff 00 00 00       	cmp    $0xff,%eax
  800958:	75 2c                	jne    800986 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80095a:	a0 28 30 80 00       	mov    0x803028,%al
  80095f:	0f b6 c0             	movzbl %al,%eax
  800962:	8b 55 0c             	mov    0xc(%ebp),%edx
  800965:	8b 12                	mov    (%edx),%edx
  800967:	89 d1                	mov    %edx,%ecx
  800969:	8b 55 0c             	mov    0xc(%ebp),%edx
  80096c:	83 c2 08             	add    $0x8,%edx
  80096f:	83 ec 04             	sub    $0x4,%esp
  800972:	50                   	push   %eax
  800973:	51                   	push   %ecx
  800974:	52                   	push   %edx
  800975:	e8 76 14 00 00       	call   801df0 <sys_cputs>
  80097a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80097d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800980:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800986:	8b 45 0c             	mov    0xc(%ebp),%eax
  800989:	8b 40 04             	mov    0x4(%eax),%eax
  80098c:	8d 50 01             	lea    0x1(%eax),%edx
  80098f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800992:	89 50 04             	mov    %edx,0x4(%eax)
}
  800995:	90                   	nop
  800996:	c9                   	leave  
  800997:	c3                   	ret    

00800998 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800998:	55                   	push   %ebp
  800999:	89 e5                	mov    %esp,%ebp
  80099b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8009a1:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8009a8:	00 00 00 
	b.cnt = 0;
  8009ab:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8009b2:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8009b5:	ff 75 0c             	pushl  0xc(%ebp)
  8009b8:	ff 75 08             	pushl  0x8(%ebp)
  8009bb:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009c1:	50                   	push   %eax
  8009c2:	68 2f 09 80 00       	push   $0x80092f
  8009c7:	e8 11 02 00 00       	call   800bdd <vprintfmt>
  8009cc:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009cf:	a0 28 30 80 00       	mov    0x803028,%al
  8009d4:	0f b6 c0             	movzbl %al,%eax
  8009d7:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009dd:	83 ec 04             	sub    $0x4,%esp
  8009e0:	50                   	push   %eax
  8009e1:	52                   	push   %edx
  8009e2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009e8:	83 c0 08             	add    $0x8,%eax
  8009eb:	50                   	push   %eax
  8009ec:	e8 ff 13 00 00       	call   801df0 <sys_cputs>
  8009f1:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009f4:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  8009fb:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a01:	c9                   	leave  
  800a02:	c3                   	ret    

00800a03 <cprintf>:

int cprintf(const char *fmt, ...) {
  800a03:	55                   	push   %ebp
  800a04:	89 e5                	mov    %esp,%ebp
  800a06:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a09:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800a10:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a13:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a16:	8b 45 08             	mov    0x8(%ebp),%eax
  800a19:	83 ec 08             	sub    $0x8,%esp
  800a1c:	ff 75 f4             	pushl  -0xc(%ebp)
  800a1f:	50                   	push   %eax
  800a20:	e8 73 ff ff ff       	call   800998 <vcprintf>
  800a25:	83 c4 10             	add    $0x10,%esp
  800a28:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a2e:	c9                   	leave  
  800a2f:	c3                   	ret    

00800a30 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a30:	55                   	push   %ebp
  800a31:	89 e5                	mov    %esp,%ebp
  800a33:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a36:	e8 c6 15 00 00       	call   802001 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a3b:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a41:	8b 45 08             	mov    0x8(%ebp),%eax
  800a44:	83 ec 08             	sub    $0x8,%esp
  800a47:	ff 75 f4             	pushl  -0xc(%ebp)
  800a4a:	50                   	push   %eax
  800a4b:	e8 48 ff ff ff       	call   800998 <vcprintf>
  800a50:	83 c4 10             	add    $0x10,%esp
  800a53:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a56:	e8 c0 15 00 00       	call   80201b <sys_enable_interrupt>
	return cnt;
  800a5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a5e:	c9                   	leave  
  800a5f:	c3                   	ret    

00800a60 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a60:	55                   	push   %ebp
  800a61:	89 e5                	mov    %esp,%ebp
  800a63:	53                   	push   %ebx
  800a64:	83 ec 14             	sub    $0x14,%esp
  800a67:	8b 45 10             	mov    0x10(%ebp),%eax
  800a6a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a6d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a70:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a73:	8b 45 18             	mov    0x18(%ebp),%eax
  800a76:	ba 00 00 00 00       	mov    $0x0,%edx
  800a7b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a7e:	77 55                	ja     800ad5 <printnum+0x75>
  800a80:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a83:	72 05                	jb     800a8a <printnum+0x2a>
  800a85:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a88:	77 4b                	ja     800ad5 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a8a:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a8d:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a90:	8b 45 18             	mov    0x18(%ebp),%eax
  800a93:	ba 00 00 00 00       	mov    $0x0,%edx
  800a98:	52                   	push   %edx
  800a99:	50                   	push   %eax
  800a9a:	ff 75 f4             	pushl  -0xc(%ebp)
  800a9d:	ff 75 f0             	pushl  -0x10(%ebp)
  800aa0:	e8 7f 19 00 00       	call   802424 <__udivdi3>
  800aa5:	83 c4 10             	add    $0x10,%esp
  800aa8:	83 ec 04             	sub    $0x4,%esp
  800aab:	ff 75 20             	pushl  0x20(%ebp)
  800aae:	53                   	push   %ebx
  800aaf:	ff 75 18             	pushl  0x18(%ebp)
  800ab2:	52                   	push   %edx
  800ab3:	50                   	push   %eax
  800ab4:	ff 75 0c             	pushl  0xc(%ebp)
  800ab7:	ff 75 08             	pushl  0x8(%ebp)
  800aba:	e8 a1 ff ff ff       	call   800a60 <printnum>
  800abf:	83 c4 20             	add    $0x20,%esp
  800ac2:	eb 1a                	jmp    800ade <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800ac4:	83 ec 08             	sub    $0x8,%esp
  800ac7:	ff 75 0c             	pushl  0xc(%ebp)
  800aca:	ff 75 20             	pushl  0x20(%ebp)
  800acd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad0:	ff d0                	call   *%eax
  800ad2:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800ad5:	ff 4d 1c             	decl   0x1c(%ebp)
  800ad8:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800adc:	7f e6                	jg     800ac4 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800ade:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800ae1:	bb 00 00 00 00       	mov    $0x0,%ebx
  800ae6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ae9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800aec:	53                   	push   %ebx
  800aed:	51                   	push   %ecx
  800aee:	52                   	push   %edx
  800aef:	50                   	push   %eax
  800af0:	e8 3f 1a 00 00       	call   802534 <__umoddi3>
  800af5:	83 c4 10             	add    $0x10,%esp
  800af8:	05 34 2c 80 00       	add    $0x802c34,%eax
  800afd:	8a 00                	mov    (%eax),%al
  800aff:	0f be c0             	movsbl %al,%eax
  800b02:	83 ec 08             	sub    $0x8,%esp
  800b05:	ff 75 0c             	pushl  0xc(%ebp)
  800b08:	50                   	push   %eax
  800b09:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0c:	ff d0                	call   *%eax
  800b0e:	83 c4 10             	add    $0x10,%esp
}
  800b11:	90                   	nop
  800b12:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b15:	c9                   	leave  
  800b16:	c3                   	ret    

00800b17 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b17:	55                   	push   %ebp
  800b18:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b1a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b1e:	7e 1c                	jle    800b3c <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b20:	8b 45 08             	mov    0x8(%ebp),%eax
  800b23:	8b 00                	mov    (%eax),%eax
  800b25:	8d 50 08             	lea    0x8(%eax),%edx
  800b28:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2b:	89 10                	mov    %edx,(%eax)
  800b2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b30:	8b 00                	mov    (%eax),%eax
  800b32:	83 e8 08             	sub    $0x8,%eax
  800b35:	8b 50 04             	mov    0x4(%eax),%edx
  800b38:	8b 00                	mov    (%eax),%eax
  800b3a:	eb 40                	jmp    800b7c <getuint+0x65>
	else if (lflag)
  800b3c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b40:	74 1e                	je     800b60 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b42:	8b 45 08             	mov    0x8(%ebp),%eax
  800b45:	8b 00                	mov    (%eax),%eax
  800b47:	8d 50 04             	lea    0x4(%eax),%edx
  800b4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4d:	89 10                	mov    %edx,(%eax)
  800b4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b52:	8b 00                	mov    (%eax),%eax
  800b54:	83 e8 04             	sub    $0x4,%eax
  800b57:	8b 00                	mov    (%eax),%eax
  800b59:	ba 00 00 00 00       	mov    $0x0,%edx
  800b5e:	eb 1c                	jmp    800b7c <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b60:	8b 45 08             	mov    0x8(%ebp),%eax
  800b63:	8b 00                	mov    (%eax),%eax
  800b65:	8d 50 04             	lea    0x4(%eax),%edx
  800b68:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6b:	89 10                	mov    %edx,(%eax)
  800b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b70:	8b 00                	mov    (%eax),%eax
  800b72:	83 e8 04             	sub    $0x4,%eax
  800b75:	8b 00                	mov    (%eax),%eax
  800b77:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b7c:	5d                   	pop    %ebp
  800b7d:	c3                   	ret    

00800b7e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b7e:	55                   	push   %ebp
  800b7f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b81:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b85:	7e 1c                	jle    800ba3 <getint+0x25>
		return va_arg(*ap, long long);
  800b87:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8a:	8b 00                	mov    (%eax),%eax
  800b8c:	8d 50 08             	lea    0x8(%eax),%edx
  800b8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b92:	89 10                	mov    %edx,(%eax)
  800b94:	8b 45 08             	mov    0x8(%ebp),%eax
  800b97:	8b 00                	mov    (%eax),%eax
  800b99:	83 e8 08             	sub    $0x8,%eax
  800b9c:	8b 50 04             	mov    0x4(%eax),%edx
  800b9f:	8b 00                	mov    (%eax),%eax
  800ba1:	eb 38                	jmp    800bdb <getint+0x5d>
	else if (lflag)
  800ba3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ba7:	74 1a                	je     800bc3 <getint+0x45>
		return va_arg(*ap, long);
  800ba9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bac:	8b 00                	mov    (%eax),%eax
  800bae:	8d 50 04             	lea    0x4(%eax),%edx
  800bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb4:	89 10                	mov    %edx,(%eax)
  800bb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb9:	8b 00                	mov    (%eax),%eax
  800bbb:	83 e8 04             	sub    $0x4,%eax
  800bbe:	8b 00                	mov    (%eax),%eax
  800bc0:	99                   	cltd   
  800bc1:	eb 18                	jmp    800bdb <getint+0x5d>
	else
		return va_arg(*ap, int);
  800bc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc6:	8b 00                	mov    (%eax),%eax
  800bc8:	8d 50 04             	lea    0x4(%eax),%edx
  800bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bce:	89 10                	mov    %edx,(%eax)
  800bd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd3:	8b 00                	mov    (%eax),%eax
  800bd5:	83 e8 04             	sub    $0x4,%eax
  800bd8:	8b 00                	mov    (%eax),%eax
  800bda:	99                   	cltd   
}
  800bdb:	5d                   	pop    %ebp
  800bdc:	c3                   	ret    

00800bdd <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bdd:	55                   	push   %ebp
  800bde:	89 e5                	mov    %esp,%ebp
  800be0:	56                   	push   %esi
  800be1:	53                   	push   %ebx
  800be2:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800be5:	eb 17                	jmp    800bfe <vprintfmt+0x21>
			if (ch == '\0')
  800be7:	85 db                	test   %ebx,%ebx
  800be9:	0f 84 af 03 00 00    	je     800f9e <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bef:	83 ec 08             	sub    $0x8,%esp
  800bf2:	ff 75 0c             	pushl  0xc(%ebp)
  800bf5:	53                   	push   %ebx
  800bf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf9:	ff d0                	call   *%eax
  800bfb:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bfe:	8b 45 10             	mov    0x10(%ebp),%eax
  800c01:	8d 50 01             	lea    0x1(%eax),%edx
  800c04:	89 55 10             	mov    %edx,0x10(%ebp)
  800c07:	8a 00                	mov    (%eax),%al
  800c09:	0f b6 d8             	movzbl %al,%ebx
  800c0c:	83 fb 25             	cmp    $0x25,%ebx
  800c0f:	75 d6                	jne    800be7 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c11:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c15:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c1c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c23:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c2a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c31:	8b 45 10             	mov    0x10(%ebp),%eax
  800c34:	8d 50 01             	lea    0x1(%eax),%edx
  800c37:	89 55 10             	mov    %edx,0x10(%ebp)
  800c3a:	8a 00                	mov    (%eax),%al
  800c3c:	0f b6 d8             	movzbl %al,%ebx
  800c3f:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c42:	83 f8 55             	cmp    $0x55,%eax
  800c45:	0f 87 2b 03 00 00    	ja     800f76 <vprintfmt+0x399>
  800c4b:	8b 04 85 58 2c 80 00 	mov    0x802c58(,%eax,4),%eax
  800c52:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c54:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c58:	eb d7                	jmp    800c31 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c5a:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c5e:	eb d1                	jmp    800c31 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c60:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c67:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c6a:	89 d0                	mov    %edx,%eax
  800c6c:	c1 e0 02             	shl    $0x2,%eax
  800c6f:	01 d0                	add    %edx,%eax
  800c71:	01 c0                	add    %eax,%eax
  800c73:	01 d8                	add    %ebx,%eax
  800c75:	83 e8 30             	sub    $0x30,%eax
  800c78:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c7b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c7e:	8a 00                	mov    (%eax),%al
  800c80:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c83:	83 fb 2f             	cmp    $0x2f,%ebx
  800c86:	7e 3e                	jle    800cc6 <vprintfmt+0xe9>
  800c88:	83 fb 39             	cmp    $0x39,%ebx
  800c8b:	7f 39                	jg     800cc6 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c8d:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c90:	eb d5                	jmp    800c67 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c92:	8b 45 14             	mov    0x14(%ebp),%eax
  800c95:	83 c0 04             	add    $0x4,%eax
  800c98:	89 45 14             	mov    %eax,0x14(%ebp)
  800c9b:	8b 45 14             	mov    0x14(%ebp),%eax
  800c9e:	83 e8 04             	sub    $0x4,%eax
  800ca1:	8b 00                	mov    (%eax),%eax
  800ca3:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800ca6:	eb 1f                	jmp    800cc7 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800ca8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cac:	79 83                	jns    800c31 <vprintfmt+0x54>
				width = 0;
  800cae:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800cb5:	e9 77 ff ff ff       	jmp    800c31 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800cba:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800cc1:	e9 6b ff ff ff       	jmp    800c31 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800cc6:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800cc7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ccb:	0f 89 60 ff ff ff    	jns    800c31 <vprintfmt+0x54>
				width = precision, precision = -1;
  800cd1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cd4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800cd7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800cde:	e9 4e ff ff ff       	jmp    800c31 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ce3:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800ce6:	e9 46 ff ff ff       	jmp    800c31 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ceb:	8b 45 14             	mov    0x14(%ebp),%eax
  800cee:	83 c0 04             	add    $0x4,%eax
  800cf1:	89 45 14             	mov    %eax,0x14(%ebp)
  800cf4:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf7:	83 e8 04             	sub    $0x4,%eax
  800cfa:	8b 00                	mov    (%eax),%eax
  800cfc:	83 ec 08             	sub    $0x8,%esp
  800cff:	ff 75 0c             	pushl  0xc(%ebp)
  800d02:	50                   	push   %eax
  800d03:	8b 45 08             	mov    0x8(%ebp),%eax
  800d06:	ff d0                	call   *%eax
  800d08:	83 c4 10             	add    $0x10,%esp
			break;
  800d0b:	e9 89 02 00 00       	jmp    800f99 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d10:	8b 45 14             	mov    0x14(%ebp),%eax
  800d13:	83 c0 04             	add    $0x4,%eax
  800d16:	89 45 14             	mov    %eax,0x14(%ebp)
  800d19:	8b 45 14             	mov    0x14(%ebp),%eax
  800d1c:	83 e8 04             	sub    $0x4,%eax
  800d1f:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d21:	85 db                	test   %ebx,%ebx
  800d23:	79 02                	jns    800d27 <vprintfmt+0x14a>
				err = -err;
  800d25:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d27:	83 fb 64             	cmp    $0x64,%ebx
  800d2a:	7f 0b                	jg     800d37 <vprintfmt+0x15a>
  800d2c:	8b 34 9d a0 2a 80 00 	mov    0x802aa0(,%ebx,4),%esi
  800d33:	85 f6                	test   %esi,%esi
  800d35:	75 19                	jne    800d50 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d37:	53                   	push   %ebx
  800d38:	68 45 2c 80 00       	push   $0x802c45
  800d3d:	ff 75 0c             	pushl  0xc(%ebp)
  800d40:	ff 75 08             	pushl  0x8(%ebp)
  800d43:	e8 5e 02 00 00       	call   800fa6 <printfmt>
  800d48:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d4b:	e9 49 02 00 00       	jmp    800f99 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d50:	56                   	push   %esi
  800d51:	68 4e 2c 80 00       	push   $0x802c4e
  800d56:	ff 75 0c             	pushl  0xc(%ebp)
  800d59:	ff 75 08             	pushl  0x8(%ebp)
  800d5c:	e8 45 02 00 00       	call   800fa6 <printfmt>
  800d61:	83 c4 10             	add    $0x10,%esp
			break;
  800d64:	e9 30 02 00 00       	jmp    800f99 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d69:	8b 45 14             	mov    0x14(%ebp),%eax
  800d6c:	83 c0 04             	add    $0x4,%eax
  800d6f:	89 45 14             	mov    %eax,0x14(%ebp)
  800d72:	8b 45 14             	mov    0x14(%ebp),%eax
  800d75:	83 e8 04             	sub    $0x4,%eax
  800d78:	8b 30                	mov    (%eax),%esi
  800d7a:	85 f6                	test   %esi,%esi
  800d7c:	75 05                	jne    800d83 <vprintfmt+0x1a6>
				p = "(null)";
  800d7e:	be 51 2c 80 00       	mov    $0x802c51,%esi
			if (width > 0 && padc != '-')
  800d83:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d87:	7e 6d                	jle    800df6 <vprintfmt+0x219>
  800d89:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d8d:	74 67                	je     800df6 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d8f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d92:	83 ec 08             	sub    $0x8,%esp
  800d95:	50                   	push   %eax
  800d96:	56                   	push   %esi
  800d97:	e8 12 05 00 00       	call   8012ae <strnlen>
  800d9c:	83 c4 10             	add    $0x10,%esp
  800d9f:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800da2:	eb 16                	jmp    800dba <vprintfmt+0x1dd>
					putch(padc, putdat);
  800da4:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800da8:	83 ec 08             	sub    $0x8,%esp
  800dab:	ff 75 0c             	pushl  0xc(%ebp)
  800dae:	50                   	push   %eax
  800daf:	8b 45 08             	mov    0x8(%ebp),%eax
  800db2:	ff d0                	call   *%eax
  800db4:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800db7:	ff 4d e4             	decl   -0x1c(%ebp)
  800dba:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dbe:	7f e4                	jg     800da4 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dc0:	eb 34                	jmp    800df6 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800dc2:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800dc6:	74 1c                	je     800de4 <vprintfmt+0x207>
  800dc8:	83 fb 1f             	cmp    $0x1f,%ebx
  800dcb:	7e 05                	jle    800dd2 <vprintfmt+0x1f5>
  800dcd:	83 fb 7e             	cmp    $0x7e,%ebx
  800dd0:	7e 12                	jle    800de4 <vprintfmt+0x207>
					putch('?', putdat);
  800dd2:	83 ec 08             	sub    $0x8,%esp
  800dd5:	ff 75 0c             	pushl  0xc(%ebp)
  800dd8:	6a 3f                	push   $0x3f
  800dda:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddd:	ff d0                	call   *%eax
  800ddf:	83 c4 10             	add    $0x10,%esp
  800de2:	eb 0f                	jmp    800df3 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800de4:	83 ec 08             	sub    $0x8,%esp
  800de7:	ff 75 0c             	pushl  0xc(%ebp)
  800dea:	53                   	push   %ebx
  800deb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dee:	ff d0                	call   *%eax
  800df0:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800df3:	ff 4d e4             	decl   -0x1c(%ebp)
  800df6:	89 f0                	mov    %esi,%eax
  800df8:	8d 70 01             	lea    0x1(%eax),%esi
  800dfb:	8a 00                	mov    (%eax),%al
  800dfd:	0f be d8             	movsbl %al,%ebx
  800e00:	85 db                	test   %ebx,%ebx
  800e02:	74 24                	je     800e28 <vprintfmt+0x24b>
  800e04:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e08:	78 b8                	js     800dc2 <vprintfmt+0x1e5>
  800e0a:	ff 4d e0             	decl   -0x20(%ebp)
  800e0d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e11:	79 af                	jns    800dc2 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e13:	eb 13                	jmp    800e28 <vprintfmt+0x24b>
				putch(' ', putdat);
  800e15:	83 ec 08             	sub    $0x8,%esp
  800e18:	ff 75 0c             	pushl  0xc(%ebp)
  800e1b:	6a 20                	push   $0x20
  800e1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e20:	ff d0                	call   *%eax
  800e22:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e25:	ff 4d e4             	decl   -0x1c(%ebp)
  800e28:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e2c:	7f e7                	jg     800e15 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e2e:	e9 66 01 00 00       	jmp    800f99 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e33:	83 ec 08             	sub    $0x8,%esp
  800e36:	ff 75 e8             	pushl  -0x18(%ebp)
  800e39:	8d 45 14             	lea    0x14(%ebp),%eax
  800e3c:	50                   	push   %eax
  800e3d:	e8 3c fd ff ff       	call   800b7e <getint>
  800e42:	83 c4 10             	add    $0x10,%esp
  800e45:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e48:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e4b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e4e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e51:	85 d2                	test   %edx,%edx
  800e53:	79 23                	jns    800e78 <vprintfmt+0x29b>
				putch('-', putdat);
  800e55:	83 ec 08             	sub    $0x8,%esp
  800e58:	ff 75 0c             	pushl  0xc(%ebp)
  800e5b:	6a 2d                	push   $0x2d
  800e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e60:	ff d0                	call   *%eax
  800e62:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e65:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e68:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e6b:	f7 d8                	neg    %eax
  800e6d:	83 d2 00             	adc    $0x0,%edx
  800e70:	f7 da                	neg    %edx
  800e72:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e75:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e78:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e7f:	e9 bc 00 00 00       	jmp    800f40 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e84:	83 ec 08             	sub    $0x8,%esp
  800e87:	ff 75 e8             	pushl  -0x18(%ebp)
  800e8a:	8d 45 14             	lea    0x14(%ebp),%eax
  800e8d:	50                   	push   %eax
  800e8e:	e8 84 fc ff ff       	call   800b17 <getuint>
  800e93:	83 c4 10             	add    $0x10,%esp
  800e96:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e99:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e9c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ea3:	e9 98 00 00 00       	jmp    800f40 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800ea8:	83 ec 08             	sub    $0x8,%esp
  800eab:	ff 75 0c             	pushl  0xc(%ebp)
  800eae:	6a 58                	push   $0x58
  800eb0:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb3:	ff d0                	call   *%eax
  800eb5:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800eb8:	83 ec 08             	sub    $0x8,%esp
  800ebb:	ff 75 0c             	pushl  0xc(%ebp)
  800ebe:	6a 58                	push   $0x58
  800ec0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec3:	ff d0                	call   *%eax
  800ec5:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ec8:	83 ec 08             	sub    $0x8,%esp
  800ecb:	ff 75 0c             	pushl  0xc(%ebp)
  800ece:	6a 58                	push   $0x58
  800ed0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed3:	ff d0                	call   *%eax
  800ed5:	83 c4 10             	add    $0x10,%esp
			break;
  800ed8:	e9 bc 00 00 00       	jmp    800f99 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800edd:	83 ec 08             	sub    $0x8,%esp
  800ee0:	ff 75 0c             	pushl  0xc(%ebp)
  800ee3:	6a 30                	push   $0x30
  800ee5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee8:	ff d0                	call   *%eax
  800eea:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800eed:	83 ec 08             	sub    $0x8,%esp
  800ef0:	ff 75 0c             	pushl  0xc(%ebp)
  800ef3:	6a 78                	push   $0x78
  800ef5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef8:	ff d0                	call   *%eax
  800efa:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800efd:	8b 45 14             	mov    0x14(%ebp),%eax
  800f00:	83 c0 04             	add    $0x4,%eax
  800f03:	89 45 14             	mov    %eax,0x14(%ebp)
  800f06:	8b 45 14             	mov    0x14(%ebp),%eax
  800f09:	83 e8 04             	sub    $0x4,%eax
  800f0c:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f11:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f18:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f1f:	eb 1f                	jmp    800f40 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f21:	83 ec 08             	sub    $0x8,%esp
  800f24:	ff 75 e8             	pushl  -0x18(%ebp)
  800f27:	8d 45 14             	lea    0x14(%ebp),%eax
  800f2a:	50                   	push   %eax
  800f2b:	e8 e7 fb ff ff       	call   800b17 <getuint>
  800f30:	83 c4 10             	add    $0x10,%esp
  800f33:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f36:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f39:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f40:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f44:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f47:	83 ec 04             	sub    $0x4,%esp
  800f4a:	52                   	push   %edx
  800f4b:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f4e:	50                   	push   %eax
  800f4f:	ff 75 f4             	pushl  -0xc(%ebp)
  800f52:	ff 75 f0             	pushl  -0x10(%ebp)
  800f55:	ff 75 0c             	pushl  0xc(%ebp)
  800f58:	ff 75 08             	pushl  0x8(%ebp)
  800f5b:	e8 00 fb ff ff       	call   800a60 <printnum>
  800f60:	83 c4 20             	add    $0x20,%esp
			break;
  800f63:	eb 34                	jmp    800f99 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f65:	83 ec 08             	sub    $0x8,%esp
  800f68:	ff 75 0c             	pushl  0xc(%ebp)
  800f6b:	53                   	push   %ebx
  800f6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6f:	ff d0                	call   *%eax
  800f71:	83 c4 10             	add    $0x10,%esp
			break;
  800f74:	eb 23                	jmp    800f99 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f76:	83 ec 08             	sub    $0x8,%esp
  800f79:	ff 75 0c             	pushl  0xc(%ebp)
  800f7c:	6a 25                	push   $0x25
  800f7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f81:	ff d0                	call   *%eax
  800f83:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f86:	ff 4d 10             	decl   0x10(%ebp)
  800f89:	eb 03                	jmp    800f8e <vprintfmt+0x3b1>
  800f8b:	ff 4d 10             	decl   0x10(%ebp)
  800f8e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f91:	48                   	dec    %eax
  800f92:	8a 00                	mov    (%eax),%al
  800f94:	3c 25                	cmp    $0x25,%al
  800f96:	75 f3                	jne    800f8b <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f98:	90                   	nop
		}
	}
  800f99:	e9 47 fc ff ff       	jmp    800be5 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f9e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f9f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800fa2:	5b                   	pop    %ebx
  800fa3:	5e                   	pop    %esi
  800fa4:	5d                   	pop    %ebp
  800fa5:	c3                   	ret    

00800fa6 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800fa6:	55                   	push   %ebp
  800fa7:	89 e5                	mov    %esp,%ebp
  800fa9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800fac:	8d 45 10             	lea    0x10(%ebp),%eax
  800faf:	83 c0 04             	add    $0x4,%eax
  800fb2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800fb5:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb8:	ff 75 f4             	pushl  -0xc(%ebp)
  800fbb:	50                   	push   %eax
  800fbc:	ff 75 0c             	pushl  0xc(%ebp)
  800fbf:	ff 75 08             	pushl  0x8(%ebp)
  800fc2:	e8 16 fc ff ff       	call   800bdd <vprintfmt>
  800fc7:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800fca:	90                   	nop
  800fcb:	c9                   	leave  
  800fcc:	c3                   	ret    

00800fcd <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800fcd:	55                   	push   %ebp
  800fce:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fd0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd3:	8b 40 08             	mov    0x8(%eax),%eax
  800fd6:	8d 50 01             	lea    0x1(%eax),%edx
  800fd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fdc:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800fdf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe2:	8b 10                	mov    (%eax),%edx
  800fe4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe7:	8b 40 04             	mov    0x4(%eax),%eax
  800fea:	39 c2                	cmp    %eax,%edx
  800fec:	73 12                	jae    801000 <sprintputch+0x33>
		*b->buf++ = ch;
  800fee:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff1:	8b 00                	mov    (%eax),%eax
  800ff3:	8d 48 01             	lea    0x1(%eax),%ecx
  800ff6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ff9:	89 0a                	mov    %ecx,(%edx)
  800ffb:	8b 55 08             	mov    0x8(%ebp),%edx
  800ffe:	88 10                	mov    %dl,(%eax)
}
  801000:	90                   	nop
  801001:	5d                   	pop    %ebp
  801002:	c3                   	ret    

00801003 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801003:	55                   	push   %ebp
  801004:	89 e5                	mov    %esp,%ebp
  801006:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801009:	8b 45 08             	mov    0x8(%ebp),%eax
  80100c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80100f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801012:	8d 50 ff             	lea    -0x1(%eax),%edx
  801015:	8b 45 08             	mov    0x8(%ebp),%eax
  801018:	01 d0                	add    %edx,%eax
  80101a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80101d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801024:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801028:	74 06                	je     801030 <vsnprintf+0x2d>
  80102a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80102e:	7f 07                	jg     801037 <vsnprintf+0x34>
		return -E_INVAL;
  801030:	b8 03 00 00 00       	mov    $0x3,%eax
  801035:	eb 20                	jmp    801057 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801037:	ff 75 14             	pushl  0x14(%ebp)
  80103a:	ff 75 10             	pushl  0x10(%ebp)
  80103d:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801040:	50                   	push   %eax
  801041:	68 cd 0f 80 00       	push   $0x800fcd
  801046:	e8 92 fb ff ff       	call   800bdd <vprintfmt>
  80104b:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80104e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801051:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801054:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801057:	c9                   	leave  
  801058:	c3                   	ret    

00801059 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801059:	55                   	push   %ebp
  80105a:	89 e5                	mov    %esp,%ebp
  80105c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80105f:	8d 45 10             	lea    0x10(%ebp),%eax
  801062:	83 c0 04             	add    $0x4,%eax
  801065:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801068:	8b 45 10             	mov    0x10(%ebp),%eax
  80106b:	ff 75 f4             	pushl  -0xc(%ebp)
  80106e:	50                   	push   %eax
  80106f:	ff 75 0c             	pushl  0xc(%ebp)
  801072:	ff 75 08             	pushl  0x8(%ebp)
  801075:	e8 89 ff ff ff       	call   801003 <vsnprintf>
  80107a:	83 c4 10             	add    $0x10,%esp
  80107d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801080:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801083:	c9                   	leave  
  801084:	c3                   	ret    

00801085 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801085:	55                   	push   %ebp
  801086:	89 e5                	mov    %esp,%ebp
  801088:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80108b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80108f:	74 13                	je     8010a4 <readline+0x1f>
		cprintf("%s", prompt);
  801091:	83 ec 08             	sub    $0x8,%esp
  801094:	ff 75 08             	pushl  0x8(%ebp)
  801097:	68 b0 2d 80 00       	push   $0x802db0
  80109c:	e8 62 f9 ff ff       	call   800a03 <cprintf>
  8010a1:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8010a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8010ab:	83 ec 0c             	sub    $0xc,%esp
  8010ae:	6a 00                	push   $0x0
  8010b0:	e8 5d f5 ff ff       	call   800612 <iscons>
  8010b5:	83 c4 10             	add    $0x10,%esp
  8010b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8010bb:	e8 04 f5 ff ff       	call   8005c4 <getchar>
  8010c0:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8010c3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8010c7:	79 22                	jns    8010eb <readline+0x66>
			if (c != -E_EOF)
  8010c9:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8010cd:	0f 84 ad 00 00 00    	je     801180 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8010d3:	83 ec 08             	sub    $0x8,%esp
  8010d6:	ff 75 ec             	pushl  -0x14(%ebp)
  8010d9:	68 b3 2d 80 00       	push   $0x802db3
  8010de:	e8 20 f9 ff ff       	call   800a03 <cprintf>
  8010e3:	83 c4 10             	add    $0x10,%esp
			return;
  8010e6:	e9 95 00 00 00       	jmp    801180 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8010eb:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8010ef:	7e 34                	jle    801125 <readline+0xa0>
  8010f1:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8010f8:	7f 2b                	jg     801125 <readline+0xa0>
			if (echoing)
  8010fa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010fe:	74 0e                	je     80110e <readline+0x89>
				cputchar(c);
  801100:	83 ec 0c             	sub    $0xc,%esp
  801103:	ff 75 ec             	pushl  -0x14(%ebp)
  801106:	e8 71 f4 ff ff       	call   80057c <cputchar>
  80110b:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80110e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801111:	8d 50 01             	lea    0x1(%eax),%edx
  801114:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801117:	89 c2                	mov    %eax,%edx
  801119:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111c:	01 d0                	add    %edx,%eax
  80111e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801121:	88 10                	mov    %dl,(%eax)
  801123:	eb 56                	jmp    80117b <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  801125:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801129:	75 1f                	jne    80114a <readline+0xc5>
  80112b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80112f:	7e 19                	jle    80114a <readline+0xc5>
			if (echoing)
  801131:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801135:	74 0e                	je     801145 <readline+0xc0>
				cputchar(c);
  801137:	83 ec 0c             	sub    $0xc,%esp
  80113a:	ff 75 ec             	pushl  -0x14(%ebp)
  80113d:	e8 3a f4 ff ff       	call   80057c <cputchar>
  801142:	83 c4 10             	add    $0x10,%esp

			i--;
  801145:	ff 4d f4             	decl   -0xc(%ebp)
  801148:	eb 31                	jmp    80117b <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  80114a:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80114e:	74 0a                	je     80115a <readline+0xd5>
  801150:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801154:	0f 85 61 ff ff ff    	jne    8010bb <readline+0x36>
			if (echoing)
  80115a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80115e:	74 0e                	je     80116e <readline+0xe9>
				cputchar(c);
  801160:	83 ec 0c             	sub    $0xc,%esp
  801163:	ff 75 ec             	pushl  -0x14(%ebp)
  801166:	e8 11 f4 ff ff       	call   80057c <cputchar>
  80116b:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80116e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801171:	8b 45 0c             	mov    0xc(%ebp),%eax
  801174:	01 d0                	add    %edx,%eax
  801176:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801179:	eb 06                	jmp    801181 <readline+0xfc>
		}
	}
  80117b:	e9 3b ff ff ff       	jmp    8010bb <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801180:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801181:	c9                   	leave  
  801182:	c3                   	ret    

00801183 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801183:	55                   	push   %ebp
  801184:	89 e5                	mov    %esp,%ebp
  801186:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801189:	e8 73 0e 00 00       	call   802001 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  80118e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801192:	74 13                	je     8011a7 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801194:	83 ec 08             	sub    $0x8,%esp
  801197:	ff 75 08             	pushl  0x8(%ebp)
  80119a:	68 b0 2d 80 00       	push   $0x802db0
  80119f:	e8 5f f8 ff ff       	call   800a03 <cprintf>
  8011a4:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8011a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8011ae:	83 ec 0c             	sub    $0xc,%esp
  8011b1:	6a 00                	push   $0x0
  8011b3:	e8 5a f4 ff ff       	call   800612 <iscons>
  8011b8:	83 c4 10             	add    $0x10,%esp
  8011bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8011be:	e8 01 f4 ff ff       	call   8005c4 <getchar>
  8011c3:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8011c6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8011ca:	79 23                	jns    8011ef <atomic_readline+0x6c>
			if (c != -E_EOF)
  8011cc:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8011d0:	74 13                	je     8011e5 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8011d2:	83 ec 08             	sub    $0x8,%esp
  8011d5:	ff 75 ec             	pushl  -0x14(%ebp)
  8011d8:	68 b3 2d 80 00       	push   $0x802db3
  8011dd:	e8 21 f8 ff ff       	call   800a03 <cprintf>
  8011e2:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8011e5:	e8 31 0e 00 00       	call   80201b <sys_enable_interrupt>
			return;
  8011ea:	e9 9a 00 00 00       	jmp    801289 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8011ef:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011f3:	7e 34                	jle    801229 <atomic_readline+0xa6>
  8011f5:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011fc:	7f 2b                	jg     801229 <atomic_readline+0xa6>
			if (echoing)
  8011fe:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801202:	74 0e                	je     801212 <atomic_readline+0x8f>
				cputchar(c);
  801204:	83 ec 0c             	sub    $0xc,%esp
  801207:	ff 75 ec             	pushl  -0x14(%ebp)
  80120a:	e8 6d f3 ff ff       	call   80057c <cputchar>
  80120f:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801212:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801215:	8d 50 01             	lea    0x1(%eax),%edx
  801218:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80121b:	89 c2                	mov    %eax,%edx
  80121d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801220:	01 d0                	add    %edx,%eax
  801222:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801225:	88 10                	mov    %dl,(%eax)
  801227:	eb 5b                	jmp    801284 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  801229:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80122d:	75 1f                	jne    80124e <atomic_readline+0xcb>
  80122f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801233:	7e 19                	jle    80124e <atomic_readline+0xcb>
			if (echoing)
  801235:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801239:	74 0e                	je     801249 <atomic_readline+0xc6>
				cputchar(c);
  80123b:	83 ec 0c             	sub    $0xc,%esp
  80123e:	ff 75 ec             	pushl  -0x14(%ebp)
  801241:	e8 36 f3 ff ff       	call   80057c <cputchar>
  801246:	83 c4 10             	add    $0x10,%esp
			i--;
  801249:	ff 4d f4             	decl   -0xc(%ebp)
  80124c:	eb 36                	jmp    801284 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  80124e:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801252:	74 0a                	je     80125e <atomic_readline+0xdb>
  801254:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801258:	0f 85 60 ff ff ff    	jne    8011be <atomic_readline+0x3b>
			if (echoing)
  80125e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801262:	74 0e                	je     801272 <atomic_readline+0xef>
				cputchar(c);
  801264:	83 ec 0c             	sub    $0xc,%esp
  801267:	ff 75 ec             	pushl  -0x14(%ebp)
  80126a:	e8 0d f3 ff ff       	call   80057c <cputchar>
  80126f:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801272:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801275:	8b 45 0c             	mov    0xc(%ebp),%eax
  801278:	01 d0                	add    %edx,%eax
  80127a:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80127d:	e8 99 0d 00 00       	call   80201b <sys_enable_interrupt>
			return;
  801282:	eb 05                	jmp    801289 <atomic_readline+0x106>
		}
	}
  801284:	e9 35 ff ff ff       	jmp    8011be <atomic_readline+0x3b>
}
  801289:	c9                   	leave  
  80128a:	c3                   	ret    

0080128b <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80128b:	55                   	push   %ebp
  80128c:	89 e5                	mov    %esp,%ebp
  80128e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801291:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801298:	eb 06                	jmp    8012a0 <strlen+0x15>
		n++;
  80129a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80129d:	ff 45 08             	incl   0x8(%ebp)
  8012a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a3:	8a 00                	mov    (%eax),%al
  8012a5:	84 c0                	test   %al,%al
  8012a7:	75 f1                	jne    80129a <strlen+0xf>
		n++;
	return n;
  8012a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012ac:	c9                   	leave  
  8012ad:	c3                   	ret    

008012ae <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8012ae:	55                   	push   %ebp
  8012af:	89 e5                	mov    %esp,%ebp
  8012b1:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012bb:	eb 09                	jmp    8012c6 <strnlen+0x18>
		n++;
  8012bd:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012c0:	ff 45 08             	incl   0x8(%ebp)
  8012c3:	ff 4d 0c             	decl   0xc(%ebp)
  8012c6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012ca:	74 09                	je     8012d5 <strnlen+0x27>
  8012cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cf:	8a 00                	mov    (%eax),%al
  8012d1:	84 c0                	test   %al,%al
  8012d3:	75 e8                	jne    8012bd <strnlen+0xf>
		n++;
	return n;
  8012d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012d8:	c9                   	leave  
  8012d9:	c3                   	ret    

008012da <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8012da:	55                   	push   %ebp
  8012db:	89 e5                	mov    %esp,%ebp
  8012dd:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8012e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8012e6:	90                   	nop
  8012e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ea:	8d 50 01             	lea    0x1(%eax),%edx
  8012ed:	89 55 08             	mov    %edx,0x8(%ebp)
  8012f0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012f6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012f9:	8a 12                	mov    (%edx),%dl
  8012fb:	88 10                	mov    %dl,(%eax)
  8012fd:	8a 00                	mov    (%eax),%al
  8012ff:	84 c0                	test   %al,%al
  801301:	75 e4                	jne    8012e7 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801303:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801306:	c9                   	leave  
  801307:	c3                   	ret    

00801308 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801308:	55                   	push   %ebp
  801309:	89 e5                	mov    %esp,%ebp
  80130b:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80130e:	8b 45 08             	mov    0x8(%ebp),%eax
  801311:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801314:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80131b:	eb 1f                	jmp    80133c <strncpy+0x34>
		*dst++ = *src;
  80131d:	8b 45 08             	mov    0x8(%ebp),%eax
  801320:	8d 50 01             	lea    0x1(%eax),%edx
  801323:	89 55 08             	mov    %edx,0x8(%ebp)
  801326:	8b 55 0c             	mov    0xc(%ebp),%edx
  801329:	8a 12                	mov    (%edx),%dl
  80132b:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80132d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801330:	8a 00                	mov    (%eax),%al
  801332:	84 c0                	test   %al,%al
  801334:	74 03                	je     801339 <strncpy+0x31>
			src++;
  801336:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801339:	ff 45 fc             	incl   -0x4(%ebp)
  80133c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80133f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801342:	72 d9                	jb     80131d <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801344:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801347:	c9                   	leave  
  801348:	c3                   	ret    

00801349 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801349:	55                   	push   %ebp
  80134a:	89 e5                	mov    %esp,%ebp
  80134c:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80134f:	8b 45 08             	mov    0x8(%ebp),%eax
  801352:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801355:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801359:	74 30                	je     80138b <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80135b:	eb 16                	jmp    801373 <strlcpy+0x2a>
			*dst++ = *src++;
  80135d:	8b 45 08             	mov    0x8(%ebp),%eax
  801360:	8d 50 01             	lea    0x1(%eax),%edx
  801363:	89 55 08             	mov    %edx,0x8(%ebp)
  801366:	8b 55 0c             	mov    0xc(%ebp),%edx
  801369:	8d 4a 01             	lea    0x1(%edx),%ecx
  80136c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80136f:	8a 12                	mov    (%edx),%dl
  801371:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801373:	ff 4d 10             	decl   0x10(%ebp)
  801376:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80137a:	74 09                	je     801385 <strlcpy+0x3c>
  80137c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137f:	8a 00                	mov    (%eax),%al
  801381:	84 c0                	test   %al,%al
  801383:	75 d8                	jne    80135d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80138b:	8b 55 08             	mov    0x8(%ebp),%edx
  80138e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801391:	29 c2                	sub    %eax,%edx
  801393:	89 d0                	mov    %edx,%eax
}
  801395:	c9                   	leave  
  801396:	c3                   	ret    

00801397 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801397:	55                   	push   %ebp
  801398:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80139a:	eb 06                	jmp    8013a2 <strcmp+0xb>
		p++, q++;
  80139c:	ff 45 08             	incl   0x8(%ebp)
  80139f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8013a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a5:	8a 00                	mov    (%eax),%al
  8013a7:	84 c0                	test   %al,%al
  8013a9:	74 0e                	je     8013b9 <strcmp+0x22>
  8013ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ae:	8a 10                	mov    (%eax),%dl
  8013b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b3:	8a 00                	mov    (%eax),%al
  8013b5:	38 c2                	cmp    %al,%dl
  8013b7:	74 e3                	je     80139c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8013b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bc:	8a 00                	mov    (%eax),%al
  8013be:	0f b6 d0             	movzbl %al,%edx
  8013c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c4:	8a 00                	mov    (%eax),%al
  8013c6:	0f b6 c0             	movzbl %al,%eax
  8013c9:	29 c2                	sub    %eax,%edx
  8013cb:	89 d0                	mov    %edx,%eax
}
  8013cd:	5d                   	pop    %ebp
  8013ce:	c3                   	ret    

008013cf <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8013cf:	55                   	push   %ebp
  8013d0:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8013d2:	eb 09                	jmp    8013dd <strncmp+0xe>
		n--, p++, q++;
  8013d4:	ff 4d 10             	decl   0x10(%ebp)
  8013d7:	ff 45 08             	incl   0x8(%ebp)
  8013da:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8013dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013e1:	74 17                	je     8013fa <strncmp+0x2b>
  8013e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e6:	8a 00                	mov    (%eax),%al
  8013e8:	84 c0                	test   %al,%al
  8013ea:	74 0e                	je     8013fa <strncmp+0x2b>
  8013ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ef:	8a 10                	mov    (%eax),%dl
  8013f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f4:	8a 00                	mov    (%eax),%al
  8013f6:	38 c2                	cmp    %al,%dl
  8013f8:	74 da                	je     8013d4 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013fa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013fe:	75 07                	jne    801407 <strncmp+0x38>
		return 0;
  801400:	b8 00 00 00 00       	mov    $0x0,%eax
  801405:	eb 14                	jmp    80141b <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801407:	8b 45 08             	mov    0x8(%ebp),%eax
  80140a:	8a 00                	mov    (%eax),%al
  80140c:	0f b6 d0             	movzbl %al,%edx
  80140f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801412:	8a 00                	mov    (%eax),%al
  801414:	0f b6 c0             	movzbl %al,%eax
  801417:	29 c2                	sub    %eax,%edx
  801419:	89 d0                	mov    %edx,%eax
}
  80141b:	5d                   	pop    %ebp
  80141c:	c3                   	ret    

0080141d <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80141d:	55                   	push   %ebp
  80141e:	89 e5                	mov    %esp,%ebp
  801420:	83 ec 04             	sub    $0x4,%esp
  801423:	8b 45 0c             	mov    0xc(%ebp),%eax
  801426:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801429:	eb 12                	jmp    80143d <strchr+0x20>
		if (*s == c)
  80142b:	8b 45 08             	mov    0x8(%ebp),%eax
  80142e:	8a 00                	mov    (%eax),%al
  801430:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801433:	75 05                	jne    80143a <strchr+0x1d>
			return (char *) s;
  801435:	8b 45 08             	mov    0x8(%ebp),%eax
  801438:	eb 11                	jmp    80144b <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80143a:	ff 45 08             	incl   0x8(%ebp)
  80143d:	8b 45 08             	mov    0x8(%ebp),%eax
  801440:	8a 00                	mov    (%eax),%al
  801442:	84 c0                	test   %al,%al
  801444:	75 e5                	jne    80142b <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801446:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80144b:	c9                   	leave  
  80144c:	c3                   	ret    

0080144d <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80144d:	55                   	push   %ebp
  80144e:	89 e5                	mov    %esp,%ebp
  801450:	83 ec 04             	sub    $0x4,%esp
  801453:	8b 45 0c             	mov    0xc(%ebp),%eax
  801456:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801459:	eb 0d                	jmp    801468 <strfind+0x1b>
		if (*s == c)
  80145b:	8b 45 08             	mov    0x8(%ebp),%eax
  80145e:	8a 00                	mov    (%eax),%al
  801460:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801463:	74 0e                	je     801473 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801465:	ff 45 08             	incl   0x8(%ebp)
  801468:	8b 45 08             	mov    0x8(%ebp),%eax
  80146b:	8a 00                	mov    (%eax),%al
  80146d:	84 c0                	test   %al,%al
  80146f:	75 ea                	jne    80145b <strfind+0xe>
  801471:	eb 01                	jmp    801474 <strfind+0x27>
		if (*s == c)
			break;
  801473:	90                   	nop
	return (char *) s;
  801474:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801477:	c9                   	leave  
  801478:	c3                   	ret    

00801479 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801479:	55                   	push   %ebp
  80147a:	89 e5                	mov    %esp,%ebp
  80147c:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80147f:	8b 45 08             	mov    0x8(%ebp),%eax
  801482:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801485:	8b 45 10             	mov    0x10(%ebp),%eax
  801488:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80148b:	eb 0e                	jmp    80149b <memset+0x22>
		*p++ = c;
  80148d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801490:	8d 50 01             	lea    0x1(%eax),%edx
  801493:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801496:	8b 55 0c             	mov    0xc(%ebp),%edx
  801499:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80149b:	ff 4d f8             	decl   -0x8(%ebp)
  80149e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8014a2:	79 e9                	jns    80148d <memset+0x14>
		*p++ = c;

	return v;
  8014a4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014a7:	c9                   	leave  
  8014a8:	c3                   	ret    

008014a9 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8014a9:	55                   	push   %ebp
  8014aa:	89 e5                	mov    %esp,%ebp
  8014ac:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8014bb:	eb 16                	jmp    8014d3 <memcpy+0x2a>
		*d++ = *s++;
  8014bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014c0:	8d 50 01             	lea    0x1(%eax),%edx
  8014c3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014c6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014c9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014cc:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014cf:	8a 12                	mov    (%edx),%dl
  8014d1:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8014d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014d9:	89 55 10             	mov    %edx,0x10(%ebp)
  8014dc:	85 c0                	test   %eax,%eax
  8014de:	75 dd                	jne    8014bd <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8014e0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014e3:	c9                   	leave  
  8014e4:	c3                   	ret    

008014e5 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014e5:	55                   	push   %ebp
  8014e6:	89 e5                	mov    %esp,%ebp
  8014e8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014fa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014fd:	73 50                	jae    80154f <memmove+0x6a>
  8014ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801502:	8b 45 10             	mov    0x10(%ebp),%eax
  801505:	01 d0                	add    %edx,%eax
  801507:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80150a:	76 43                	jbe    80154f <memmove+0x6a>
		s += n;
  80150c:	8b 45 10             	mov    0x10(%ebp),%eax
  80150f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801512:	8b 45 10             	mov    0x10(%ebp),%eax
  801515:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801518:	eb 10                	jmp    80152a <memmove+0x45>
			*--d = *--s;
  80151a:	ff 4d f8             	decl   -0x8(%ebp)
  80151d:	ff 4d fc             	decl   -0x4(%ebp)
  801520:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801523:	8a 10                	mov    (%eax),%dl
  801525:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801528:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80152a:	8b 45 10             	mov    0x10(%ebp),%eax
  80152d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801530:	89 55 10             	mov    %edx,0x10(%ebp)
  801533:	85 c0                	test   %eax,%eax
  801535:	75 e3                	jne    80151a <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801537:	eb 23                	jmp    80155c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801539:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80153c:	8d 50 01             	lea    0x1(%eax),%edx
  80153f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801542:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801545:	8d 4a 01             	lea    0x1(%edx),%ecx
  801548:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80154b:	8a 12                	mov    (%edx),%dl
  80154d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80154f:	8b 45 10             	mov    0x10(%ebp),%eax
  801552:	8d 50 ff             	lea    -0x1(%eax),%edx
  801555:	89 55 10             	mov    %edx,0x10(%ebp)
  801558:	85 c0                	test   %eax,%eax
  80155a:	75 dd                	jne    801539 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80155c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80155f:	c9                   	leave  
  801560:	c3                   	ret    

00801561 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801561:	55                   	push   %ebp
  801562:	89 e5                	mov    %esp,%ebp
  801564:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801567:	8b 45 08             	mov    0x8(%ebp),%eax
  80156a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80156d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801570:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801573:	eb 2a                	jmp    80159f <memcmp+0x3e>
		if (*s1 != *s2)
  801575:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801578:	8a 10                	mov    (%eax),%dl
  80157a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80157d:	8a 00                	mov    (%eax),%al
  80157f:	38 c2                	cmp    %al,%dl
  801581:	74 16                	je     801599 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801583:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801586:	8a 00                	mov    (%eax),%al
  801588:	0f b6 d0             	movzbl %al,%edx
  80158b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80158e:	8a 00                	mov    (%eax),%al
  801590:	0f b6 c0             	movzbl %al,%eax
  801593:	29 c2                	sub    %eax,%edx
  801595:	89 d0                	mov    %edx,%eax
  801597:	eb 18                	jmp    8015b1 <memcmp+0x50>
		s1++, s2++;
  801599:	ff 45 fc             	incl   -0x4(%ebp)
  80159c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80159f:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015a5:	89 55 10             	mov    %edx,0x10(%ebp)
  8015a8:	85 c0                	test   %eax,%eax
  8015aa:	75 c9                	jne    801575 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8015ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015b1:	c9                   	leave  
  8015b2:	c3                   	ret    

008015b3 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8015b3:	55                   	push   %ebp
  8015b4:	89 e5                	mov    %esp,%ebp
  8015b6:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8015b9:	8b 55 08             	mov    0x8(%ebp),%edx
  8015bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8015bf:	01 d0                	add    %edx,%eax
  8015c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8015c4:	eb 15                	jmp    8015db <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8015c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c9:	8a 00                	mov    (%eax),%al
  8015cb:	0f b6 d0             	movzbl %al,%edx
  8015ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d1:	0f b6 c0             	movzbl %al,%eax
  8015d4:	39 c2                	cmp    %eax,%edx
  8015d6:	74 0d                	je     8015e5 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8015d8:	ff 45 08             	incl   0x8(%ebp)
  8015db:	8b 45 08             	mov    0x8(%ebp),%eax
  8015de:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015e1:	72 e3                	jb     8015c6 <memfind+0x13>
  8015e3:	eb 01                	jmp    8015e6 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015e5:	90                   	nop
	return (void *) s;
  8015e6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015e9:	c9                   	leave  
  8015ea:	c3                   	ret    

008015eb <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015eb:	55                   	push   %ebp
  8015ec:	89 e5                	mov    %esp,%ebp
  8015ee:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015f1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015f8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015ff:	eb 03                	jmp    801604 <strtol+0x19>
		s++;
  801601:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801604:	8b 45 08             	mov    0x8(%ebp),%eax
  801607:	8a 00                	mov    (%eax),%al
  801609:	3c 20                	cmp    $0x20,%al
  80160b:	74 f4                	je     801601 <strtol+0x16>
  80160d:	8b 45 08             	mov    0x8(%ebp),%eax
  801610:	8a 00                	mov    (%eax),%al
  801612:	3c 09                	cmp    $0x9,%al
  801614:	74 eb                	je     801601 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801616:	8b 45 08             	mov    0x8(%ebp),%eax
  801619:	8a 00                	mov    (%eax),%al
  80161b:	3c 2b                	cmp    $0x2b,%al
  80161d:	75 05                	jne    801624 <strtol+0x39>
		s++;
  80161f:	ff 45 08             	incl   0x8(%ebp)
  801622:	eb 13                	jmp    801637 <strtol+0x4c>
	else if (*s == '-')
  801624:	8b 45 08             	mov    0x8(%ebp),%eax
  801627:	8a 00                	mov    (%eax),%al
  801629:	3c 2d                	cmp    $0x2d,%al
  80162b:	75 0a                	jne    801637 <strtol+0x4c>
		s++, neg = 1;
  80162d:	ff 45 08             	incl   0x8(%ebp)
  801630:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801637:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80163b:	74 06                	je     801643 <strtol+0x58>
  80163d:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801641:	75 20                	jne    801663 <strtol+0x78>
  801643:	8b 45 08             	mov    0x8(%ebp),%eax
  801646:	8a 00                	mov    (%eax),%al
  801648:	3c 30                	cmp    $0x30,%al
  80164a:	75 17                	jne    801663 <strtol+0x78>
  80164c:	8b 45 08             	mov    0x8(%ebp),%eax
  80164f:	40                   	inc    %eax
  801650:	8a 00                	mov    (%eax),%al
  801652:	3c 78                	cmp    $0x78,%al
  801654:	75 0d                	jne    801663 <strtol+0x78>
		s += 2, base = 16;
  801656:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80165a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801661:	eb 28                	jmp    80168b <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801663:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801667:	75 15                	jne    80167e <strtol+0x93>
  801669:	8b 45 08             	mov    0x8(%ebp),%eax
  80166c:	8a 00                	mov    (%eax),%al
  80166e:	3c 30                	cmp    $0x30,%al
  801670:	75 0c                	jne    80167e <strtol+0x93>
		s++, base = 8;
  801672:	ff 45 08             	incl   0x8(%ebp)
  801675:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80167c:	eb 0d                	jmp    80168b <strtol+0xa0>
	else if (base == 0)
  80167e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801682:	75 07                	jne    80168b <strtol+0xa0>
		base = 10;
  801684:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80168b:	8b 45 08             	mov    0x8(%ebp),%eax
  80168e:	8a 00                	mov    (%eax),%al
  801690:	3c 2f                	cmp    $0x2f,%al
  801692:	7e 19                	jle    8016ad <strtol+0xc2>
  801694:	8b 45 08             	mov    0x8(%ebp),%eax
  801697:	8a 00                	mov    (%eax),%al
  801699:	3c 39                	cmp    $0x39,%al
  80169b:	7f 10                	jg     8016ad <strtol+0xc2>
			dig = *s - '0';
  80169d:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a0:	8a 00                	mov    (%eax),%al
  8016a2:	0f be c0             	movsbl %al,%eax
  8016a5:	83 e8 30             	sub    $0x30,%eax
  8016a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016ab:	eb 42                	jmp    8016ef <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8016ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b0:	8a 00                	mov    (%eax),%al
  8016b2:	3c 60                	cmp    $0x60,%al
  8016b4:	7e 19                	jle    8016cf <strtol+0xe4>
  8016b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b9:	8a 00                	mov    (%eax),%al
  8016bb:	3c 7a                	cmp    $0x7a,%al
  8016bd:	7f 10                	jg     8016cf <strtol+0xe4>
			dig = *s - 'a' + 10;
  8016bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c2:	8a 00                	mov    (%eax),%al
  8016c4:	0f be c0             	movsbl %al,%eax
  8016c7:	83 e8 57             	sub    $0x57,%eax
  8016ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016cd:	eb 20                	jmp    8016ef <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d2:	8a 00                	mov    (%eax),%al
  8016d4:	3c 40                	cmp    $0x40,%al
  8016d6:	7e 39                	jle    801711 <strtol+0x126>
  8016d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016db:	8a 00                	mov    (%eax),%al
  8016dd:	3c 5a                	cmp    $0x5a,%al
  8016df:	7f 30                	jg     801711 <strtol+0x126>
			dig = *s - 'A' + 10;
  8016e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e4:	8a 00                	mov    (%eax),%al
  8016e6:	0f be c0             	movsbl %al,%eax
  8016e9:	83 e8 37             	sub    $0x37,%eax
  8016ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016f2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016f5:	7d 19                	jge    801710 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016f7:	ff 45 08             	incl   0x8(%ebp)
  8016fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016fd:	0f af 45 10          	imul   0x10(%ebp),%eax
  801701:	89 c2                	mov    %eax,%edx
  801703:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801706:	01 d0                	add    %edx,%eax
  801708:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80170b:	e9 7b ff ff ff       	jmp    80168b <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801710:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801711:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801715:	74 08                	je     80171f <strtol+0x134>
		*endptr = (char *) s;
  801717:	8b 45 0c             	mov    0xc(%ebp),%eax
  80171a:	8b 55 08             	mov    0x8(%ebp),%edx
  80171d:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80171f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801723:	74 07                	je     80172c <strtol+0x141>
  801725:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801728:	f7 d8                	neg    %eax
  80172a:	eb 03                	jmp    80172f <strtol+0x144>
  80172c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80172f:	c9                   	leave  
  801730:	c3                   	ret    

00801731 <ltostr>:

void
ltostr(long value, char *str)
{
  801731:	55                   	push   %ebp
  801732:	89 e5                	mov    %esp,%ebp
  801734:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801737:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80173e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801745:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801749:	79 13                	jns    80175e <ltostr+0x2d>
	{
		neg = 1;
  80174b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801752:	8b 45 0c             	mov    0xc(%ebp),%eax
  801755:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801758:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80175b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80175e:	8b 45 08             	mov    0x8(%ebp),%eax
  801761:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801766:	99                   	cltd   
  801767:	f7 f9                	idiv   %ecx
  801769:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80176c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80176f:	8d 50 01             	lea    0x1(%eax),%edx
  801772:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801775:	89 c2                	mov    %eax,%edx
  801777:	8b 45 0c             	mov    0xc(%ebp),%eax
  80177a:	01 d0                	add    %edx,%eax
  80177c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80177f:	83 c2 30             	add    $0x30,%edx
  801782:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801784:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801787:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80178c:	f7 e9                	imul   %ecx
  80178e:	c1 fa 02             	sar    $0x2,%edx
  801791:	89 c8                	mov    %ecx,%eax
  801793:	c1 f8 1f             	sar    $0x1f,%eax
  801796:	29 c2                	sub    %eax,%edx
  801798:	89 d0                	mov    %edx,%eax
  80179a:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80179d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017a0:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017a5:	f7 e9                	imul   %ecx
  8017a7:	c1 fa 02             	sar    $0x2,%edx
  8017aa:	89 c8                	mov    %ecx,%eax
  8017ac:	c1 f8 1f             	sar    $0x1f,%eax
  8017af:	29 c2                	sub    %eax,%edx
  8017b1:	89 d0                	mov    %edx,%eax
  8017b3:	c1 e0 02             	shl    $0x2,%eax
  8017b6:	01 d0                	add    %edx,%eax
  8017b8:	01 c0                	add    %eax,%eax
  8017ba:	29 c1                	sub    %eax,%ecx
  8017bc:	89 ca                	mov    %ecx,%edx
  8017be:	85 d2                	test   %edx,%edx
  8017c0:	75 9c                	jne    80175e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8017c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017cc:	48                   	dec    %eax
  8017cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017d0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017d4:	74 3d                	je     801813 <ltostr+0xe2>
		start = 1 ;
  8017d6:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017dd:	eb 34                	jmp    801813 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8017df:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e5:	01 d0                	add    %edx,%eax
  8017e7:	8a 00                	mov    (%eax),%al
  8017e9:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017ec:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017f2:	01 c2                	add    %eax,%edx
  8017f4:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017fa:	01 c8                	add    %ecx,%eax
  8017fc:	8a 00                	mov    (%eax),%al
  8017fe:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801800:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801803:	8b 45 0c             	mov    0xc(%ebp),%eax
  801806:	01 c2                	add    %eax,%edx
  801808:	8a 45 eb             	mov    -0x15(%ebp),%al
  80180b:	88 02                	mov    %al,(%edx)
		start++ ;
  80180d:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801810:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801813:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801816:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801819:	7c c4                	jl     8017df <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80181b:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80181e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801821:	01 d0                	add    %edx,%eax
  801823:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801826:	90                   	nop
  801827:	c9                   	leave  
  801828:	c3                   	ret    

00801829 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801829:	55                   	push   %ebp
  80182a:	89 e5                	mov    %esp,%ebp
  80182c:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80182f:	ff 75 08             	pushl  0x8(%ebp)
  801832:	e8 54 fa ff ff       	call   80128b <strlen>
  801837:	83 c4 04             	add    $0x4,%esp
  80183a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80183d:	ff 75 0c             	pushl  0xc(%ebp)
  801840:	e8 46 fa ff ff       	call   80128b <strlen>
  801845:	83 c4 04             	add    $0x4,%esp
  801848:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80184b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801852:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801859:	eb 17                	jmp    801872 <strcconcat+0x49>
		final[s] = str1[s] ;
  80185b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80185e:	8b 45 10             	mov    0x10(%ebp),%eax
  801861:	01 c2                	add    %eax,%edx
  801863:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801866:	8b 45 08             	mov    0x8(%ebp),%eax
  801869:	01 c8                	add    %ecx,%eax
  80186b:	8a 00                	mov    (%eax),%al
  80186d:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80186f:	ff 45 fc             	incl   -0x4(%ebp)
  801872:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801875:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801878:	7c e1                	jl     80185b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80187a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801881:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801888:	eb 1f                	jmp    8018a9 <strcconcat+0x80>
		final[s++] = str2[i] ;
  80188a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80188d:	8d 50 01             	lea    0x1(%eax),%edx
  801890:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801893:	89 c2                	mov    %eax,%edx
  801895:	8b 45 10             	mov    0x10(%ebp),%eax
  801898:	01 c2                	add    %eax,%edx
  80189a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80189d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a0:	01 c8                	add    %ecx,%eax
  8018a2:	8a 00                	mov    (%eax),%al
  8018a4:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8018a6:	ff 45 f8             	incl   -0x8(%ebp)
  8018a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ac:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018af:	7c d9                	jl     80188a <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8018b1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b7:	01 d0                	add    %edx,%eax
  8018b9:	c6 00 00             	movb   $0x0,(%eax)
}
  8018bc:	90                   	nop
  8018bd:	c9                   	leave  
  8018be:	c3                   	ret    

008018bf <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8018bf:	55                   	push   %ebp
  8018c0:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8018c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8018c5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018cb:	8b 45 14             	mov    0x14(%ebp),%eax
  8018ce:	8b 00                	mov    (%eax),%eax
  8018d0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8018da:	01 d0                	add    %edx,%eax
  8018dc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018e2:	eb 0c                	jmp    8018f0 <strsplit+0x31>
			*string++ = 0;
  8018e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e7:	8d 50 01             	lea    0x1(%eax),%edx
  8018ea:	89 55 08             	mov    %edx,0x8(%ebp)
  8018ed:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f3:	8a 00                	mov    (%eax),%al
  8018f5:	84 c0                	test   %al,%al
  8018f7:	74 18                	je     801911 <strsplit+0x52>
  8018f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fc:	8a 00                	mov    (%eax),%al
  8018fe:	0f be c0             	movsbl %al,%eax
  801901:	50                   	push   %eax
  801902:	ff 75 0c             	pushl  0xc(%ebp)
  801905:	e8 13 fb ff ff       	call   80141d <strchr>
  80190a:	83 c4 08             	add    $0x8,%esp
  80190d:	85 c0                	test   %eax,%eax
  80190f:	75 d3                	jne    8018e4 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801911:	8b 45 08             	mov    0x8(%ebp),%eax
  801914:	8a 00                	mov    (%eax),%al
  801916:	84 c0                	test   %al,%al
  801918:	74 5a                	je     801974 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80191a:	8b 45 14             	mov    0x14(%ebp),%eax
  80191d:	8b 00                	mov    (%eax),%eax
  80191f:	83 f8 0f             	cmp    $0xf,%eax
  801922:	75 07                	jne    80192b <strsplit+0x6c>
		{
			return 0;
  801924:	b8 00 00 00 00       	mov    $0x0,%eax
  801929:	eb 66                	jmp    801991 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80192b:	8b 45 14             	mov    0x14(%ebp),%eax
  80192e:	8b 00                	mov    (%eax),%eax
  801930:	8d 48 01             	lea    0x1(%eax),%ecx
  801933:	8b 55 14             	mov    0x14(%ebp),%edx
  801936:	89 0a                	mov    %ecx,(%edx)
  801938:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80193f:	8b 45 10             	mov    0x10(%ebp),%eax
  801942:	01 c2                	add    %eax,%edx
  801944:	8b 45 08             	mov    0x8(%ebp),%eax
  801947:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801949:	eb 03                	jmp    80194e <strsplit+0x8f>
			string++;
  80194b:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80194e:	8b 45 08             	mov    0x8(%ebp),%eax
  801951:	8a 00                	mov    (%eax),%al
  801953:	84 c0                	test   %al,%al
  801955:	74 8b                	je     8018e2 <strsplit+0x23>
  801957:	8b 45 08             	mov    0x8(%ebp),%eax
  80195a:	8a 00                	mov    (%eax),%al
  80195c:	0f be c0             	movsbl %al,%eax
  80195f:	50                   	push   %eax
  801960:	ff 75 0c             	pushl  0xc(%ebp)
  801963:	e8 b5 fa ff ff       	call   80141d <strchr>
  801968:	83 c4 08             	add    $0x8,%esp
  80196b:	85 c0                	test   %eax,%eax
  80196d:	74 dc                	je     80194b <strsplit+0x8c>
			string++;
	}
  80196f:	e9 6e ff ff ff       	jmp    8018e2 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801974:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801975:	8b 45 14             	mov    0x14(%ebp),%eax
  801978:	8b 00                	mov    (%eax),%eax
  80197a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801981:	8b 45 10             	mov    0x10(%ebp),%eax
  801984:	01 d0                	add    %edx,%eax
  801986:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80198c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801991:	c9                   	leave  
  801992:	c3                   	ret    

00801993 <malloc>:
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  801993:	55                   	push   %ebp
  801994:	89 e5                	mov    %esp,%ebp
  801996:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  801999:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  8019a0:	76 0a                	jbe    8019ac <malloc+0x19>
		return NULL;
  8019a2:	b8 00 00 00 00       	mov    $0x0,%eax
  8019a7:	e9 ad 02 00 00       	jmp    801c59 <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  8019ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8019af:	c1 e8 0c             	shr    $0xc,%eax
  8019b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  8019b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b8:	25 ff 0f 00 00       	and    $0xfff,%eax
  8019bd:	85 c0                	test   %eax,%eax
  8019bf:	74 03                	je     8019c4 <malloc+0x31>
		num++;
  8019c1:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  8019c4:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019c9:	85 c0                	test   %eax,%eax
  8019cb:	75 71                	jne    801a3e <malloc+0xab>
		sys_allocateMem(last_addres, size);
  8019cd:	a1 04 30 80 00       	mov    0x803004,%eax
  8019d2:	83 ec 08             	sub    $0x8,%esp
  8019d5:	ff 75 08             	pushl  0x8(%ebp)
  8019d8:	50                   	push   %eax
  8019d9:	e8 ba 05 00 00       	call   801f98 <sys_allocateMem>
  8019de:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  8019e1:	a1 04 30 80 00       	mov    0x803004,%eax
  8019e6:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  8019e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019ec:	c1 e0 0c             	shl    $0xc,%eax
  8019ef:	89 c2                	mov    %eax,%edx
  8019f1:	a1 04 30 80 00       	mov    0x803004,%eax
  8019f6:	01 d0                	add    %edx,%eax
  8019f8:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  8019fd:	a1 30 30 80 00       	mov    0x803030,%eax
  801a02:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a05:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801a0c:	a1 30 30 80 00       	mov    0x803030,%eax
  801a11:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801a14:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
		changed[sizeofarray] = 1;
  801a1b:	a1 30 30 80 00       	mov    0x803030,%eax
  801a20:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801a27:	01 00 00 00 
		sizeofarray++;
  801a2b:	a1 30 30 80 00       	mov    0x803030,%eax
  801a30:	40                   	inc    %eax
  801a31:	a3 30 30 80 00       	mov    %eax,0x803030
		return (void*) return_addres;
  801a36:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801a39:	e9 1b 02 00 00       	jmp    801c59 <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  801a3e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  801a45:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  801a4c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  801a53:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  801a5a:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  801a61:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801a68:	eb 72                	jmp    801adc <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  801a6a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a6d:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801a74:	85 c0                	test   %eax,%eax
  801a76:	75 12                	jne    801a8a <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  801a78:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a7b:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801a82:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  801a85:	ff 45 dc             	incl   -0x24(%ebp)
  801a88:	eb 4f                	jmp    801ad9 <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  801a8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a8d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801a90:	7d 39                	jge    801acb <malloc+0x138>
  801a92:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a95:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a98:	7c 31                	jl     801acb <malloc+0x138>
					{
						min=count;
  801a9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a9d:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  801aa0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801aa3:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801aaa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801aad:	c1 e2 0c             	shl    $0xc,%edx
  801ab0:	29 d0                	sub    %edx,%eax
  801ab2:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  801ab5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801ab8:	2b 45 dc             	sub    -0x24(%ebp),%eax
  801abb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  801abe:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  801ac5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801ac8:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  801acb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  801ad2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  801ad9:	ff 45 d4             	incl   -0x2c(%ebp)
  801adc:	a1 30 30 80 00       	mov    0x803030,%eax
  801ae1:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  801ae4:	7c 84                	jl     801a6a <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  801ae6:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  801aea:	0f 85 e3 00 00 00    	jne    801bd3 <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  801af0:	83 ec 08             	sub    $0x8,%esp
  801af3:	ff 75 08             	pushl  0x8(%ebp)
  801af6:	ff 75 e0             	pushl  -0x20(%ebp)
  801af9:	e8 9a 04 00 00       	call   801f98 <sys_allocateMem>
  801afe:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  801b01:	a1 30 30 80 00       	mov    0x803030,%eax
  801b06:	40                   	inc    %eax
  801b07:	a3 30 30 80 00       	mov    %eax,0x803030
				for(int i=sizeofarray-1;i>index;i--)
  801b0c:	a1 30 30 80 00       	mov    0x803030,%eax
  801b11:	48                   	dec    %eax
  801b12:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801b15:	eb 42                	jmp    801b59 <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  801b17:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b1a:	48                   	dec    %eax
  801b1b:	8b 14 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%edx
  801b22:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b25:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  801b2c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b2f:	48                   	dec    %eax
  801b30:	8b 14 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%edx
  801b37:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b3a:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					changed[i]=changed[i-1];
  801b41:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b44:	48                   	dec    %eax
  801b45:	8b 14 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%edx
  801b4c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b4f:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  801b56:	ff 4d d0             	decl   -0x30(%ebp)
  801b59:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b5c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801b5f:	7f b6                	jg     801b17 <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  801b61:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b64:	40                   	inc    %eax
  801b65:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  801b68:	8b 55 08             	mov    0x8(%ebp),%edx
  801b6b:	01 ca                	add    %ecx,%edx
  801b6d:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  801b74:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b77:	8d 50 01             	lea    0x1(%eax),%edx
  801b7a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b7d:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801b84:	2b 45 f4             	sub    -0xc(%ebp),%eax
  801b87:	89 04 95 a0 80 92 00 	mov    %eax,0x9280a0(,%edx,4)
				changed[index+1]=0;
  801b8e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b91:	40                   	inc    %eax
  801b92:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801b99:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  801b9d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ba0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801ba3:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  801baa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801bad:	89 45 cc             	mov    %eax,-0x34(%ebp)
  801bb0:	eb 11                	jmp    801bc3 <malloc+0x230>
				{
					changed[index] = 1;
  801bb2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801bb5:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801bbc:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  801bc0:	ff 45 cc             	incl   -0x34(%ebp)
  801bc3:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801bc6:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801bc9:	7c e7                	jl     801bb2 <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  801bcb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801bce:	e9 86 00 00 00       	jmp    801c59 <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  801bd3:	a1 04 30 80 00       	mov    0x803004,%eax
  801bd8:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801bdd:	29 c2                	sub    %eax,%edx
  801bdf:	89 d0                	mov    %edx,%eax
  801be1:	3b 45 08             	cmp    0x8(%ebp),%eax
  801be4:	73 07                	jae    801bed <malloc+0x25a>
						return NULL;
  801be6:	b8 00 00 00 00       	mov    $0x0,%eax
  801beb:	eb 6c                	jmp    801c59 <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801bed:	a1 04 30 80 00       	mov    0x803004,%eax
  801bf2:	83 ec 08             	sub    $0x8,%esp
  801bf5:	ff 75 08             	pushl  0x8(%ebp)
  801bf8:	50                   	push   %eax
  801bf9:	e8 9a 03 00 00       	call   801f98 <sys_allocateMem>
  801bfe:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801c01:	a1 04 30 80 00       	mov    0x803004,%eax
  801c06:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  801c09:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c0c:	c1 e0 0c             	shl    $0xc,%eax
  801c0f:	89 c2                	mov    %eax,%edx
  801c11:	a1 04 30 80 00       	mov    0x803004,%eax
  801c16:	01 d0                	add    %edx,%eax
  801c18:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  801c1d:	a1 30 30 80 00       	mov    0x803030,%eax
  801c22:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c25:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  801c2c:	a1 30 30 80 00       	mov    0x803030,%eax
  801c31:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801c34:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					changed[sizeofarray] = 1;
  801c3b:	a1 30 30 80 00       	mov    0x803030,%eax
  801c40:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801c47:	01 00 00 00 
					sizeofarray++;
  801c4b:	a1 30 30 80 00       	mov    0x803030,%eax
  801c50:	40                   	inc    %eax
  801c51:	a3 30 30 80 00       	mov    %eax,0x803030
					return (void*) return_addres;
  801c56:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  801c59:	c9                   	leave  
  801c5a:	c3                   	ret    

00801c5b <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801c5b:	55                   	push   %ebp
  801c5c:	89 e5                	mov    %esp,%ebp
  801c5e:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801c61:	8b 45 08             	mov    0x8(%ebp),%eax
  801c64:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  801c67:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801c6e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801c75:	eb 30                	jmp    801ca7 <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801c77:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c7a:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801c81:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801c84:	75 1e                	jne    801ca4 <free+0x49>
  801c86:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c89:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801c90:	83 f8 01             	cmp    $0x1,%eax
  801c93:	75 0f                	jne    801ca4 <free+0x49>
			is_found = 1;
  801c95:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801c9c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801ca2:	eb 0d                	jmp    801cb1 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801ca4:	ff 45 ec             	incl   -0x14(%ebp)
  801ca7:	a1 30 30 80 00       	mov    0x803030,%eax
  801cac:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801caf:	7c c6                	jl     801c77 <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801cb1:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801cb5:	75 3a                	jne    801cf1 <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  801cb7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cba:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801cc1:	c1 e0 0c             	shl    $0xc,%eax
  801cc4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  801cc7:	83 ec 08             	sub    $0x8,%esp
  801cca:	ff 75 e4             	pushl  -0x1c(%ebp)
  801ccd:	ff 75 e8             	pushl  -0x18(%ebp)
  801cd0:	e8 a7 02 00 00       	call   801f7c <sys_freeMem>
  801cd5:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801cd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cdb:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801ce2:	00 00 00 00 
		changes++;
  801ce6:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801ceb:	40                   	inc    %eax
  801cec:	a3 2c 30 80 00       	mov    %eax,0x80302c
	}
	//refer to the project presentation and documentation for details
}
  801cf1:	90                   	nop
  801cf2:	c9                   	leave  
  801cf3:	c3                   	ret    

00801cf4 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801cf4:	55                   	push   %ebp
  801cf5:	89 e5                	mov    %esp,%ebp
  801cf7:	83 ec 18             	sub    $0x18,%esp
  801cfa:	8b 45 10             	mov    0x10(%ebp),%eax
  801cfd:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801d00:	83 ec 04             	sub    $0x4,%esp
  801d03:	68 c4 2d 80 00       	push   $0x802dc4
  801d08:	68 b6 00 00 00       	push   $0xb6
  801d0d:	68 e7 2d 80 00       	push   $0x802de7
  801d12:	e8 4a ea ff ff       	call   800761 <_panic>

00801d17 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801d17:	55                   	push   %ebp
  801d18:	89 e5                	mov    %esp,%ebp
  801d1a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d1d:	83 ec 04             	sub    $0x4,%esp
  801d20:	68 c4 2d 80 00       	push   $0x802dc4
  801d25:	68 bb 00 00 00       	push   $0xbb
  801d2a:	68 e7 2d 80 00       	push   $0x802de7
  801d2f:	e8 2d ea ff ff       	call   800761 <_panic>

00801d34 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801d34:	55                   	push   %ebp
  801d35:	89 e5                	mov    %esp,%ebp
  801d37:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d3a:	83 ec 04             	sub    $0x4,%esp
  801d3d:	68 c4 2d 80 00       	push   $0x802dc4
  801d42:	68 c0 00 00 00       	push   $0xc0
  801d47:	68 e7 2d 80 00       	push   $0x802de7
  801d4c:	e8 10 ea ff ff       	call   800761 <_panic>

00801d51 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  801d51:	55                   	push   %ebp
  801d52:	89 e5                	mov    %esp,%ebp
  801d54:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d57:	83 ec 04             	sub    $0x4,%esp
  801d5a:	68 c4 2d 80 00       	push   $0x802dc4
  801d5f:	68 c4 00 00 00       	push   $0xc4
  801d64:	68 e7 2d 80 00       	push   $0x802de7
  801d69:	e8 f3 e9 ff ff       	call   800761 <_panic>

00801d6e <expand>:
	return 0;
}

void expand(uint32 newSize) {
  801d6e:	55                   	push   %ebp
  801d6f:	89 e5                	mov    %esp,%ebp
  801d71:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d74:	83 ec 04             	sub    $0x4,%esp
  801d77:	68 c4 2d 80 00       	push   $0x802dc4
  801d7c:	68 c9 00 00 00       	push   $0xc9
  801d81:	68 e7 2d 80 00       	push   $0x802de7
  801d86:	e8 d6 e9 ff ff       	call   800761 <_panic>

00801d8b <shrink>:
}
void shrink(uint32 newSize) {
  801d8b:	55                   	push   %ebp
  801d8c:	89 e5                	mov    %esp,%ebp
  801d8e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d91:	83 ec 04             	sub    $0x4,%esp
  801d94:	68 c4 2d 80 00       	push   $0x802dc4
  801d99:	68 cc 00 00 00       	push   $0xcc
  801d9e:	68 e7 2d 80 00       	push   $0x802de7
  801da3:	e8 b9 e9 ff ff       	call   800761 <_panic>

00801da8 <freeHeap>:
}

void freeHeap(void* virtual_address) {
  801da8:	55                   	push   %ebp
  801da9:	89 e5                	mov    %esp,%ebp
  801dab:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801dae:	83 ec 04             	sub    $0x4,%esp
  801db1:	68 c4 2d 80 00       	push   $0x802dc4
  801db6:	68 d0 00 00 00       	push   $0xd0
  801dbb:	68 e7 2d 80 00       	push   $0x802de7
  801dc0:	e8 9c e9 ff ff       	call   800761 <_panic>

00801dc5 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801dc5:	55                   	push   %ebp
  801dc6:	89 e5                	mov    %esp,%ebp
  801dc8:	57                   	push   %edi
  801dc9:	56                   	push   %esi
  801dca:	53                   	push   %ebx
  801dcb:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801dce:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dd4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801dd7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801dda:	8b 7d 18             	mov    0x18(%ebp),%edi
  801ddd:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801de0:	cd 30                	int    $0x30
  801de2:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801de5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801de8:	83 c4 10             	add    $0x10,%esp
  801deb:	5b                   	pop    %ebx
  801dec:	5e                   	pop    %esi
  801ded:	5f                   	pop    %edi
  801dee:	5d                   	pop    %ebp
  801def:	c3                   	ret    

00801df0 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801df0:	55                   	push   %ebp
  801df1:	89 e5                	mov    %esp,%ebp
  801df3:	83 ec 04             	sub    $0x4,%esp
  801df6:	8b 45 10             	mov    0x10(%ebp),%eax
  801df9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801dfc:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e00:	8b 45 08             	mov    0x8(%ebp),%eax
  801e03:	6a 00                	push   $0x0
  801e05:	6a 00                	push   $0x0
  801e07:	52                   	push   %edx
  801e08:	ff 75 0c             	pushl  0xc(%ebp)
  801e0b:	50                   	push   %eax
  801e0c:	6a 00                	push   $0x0
  801e0e:	e8 b2 ff ff ff       	call   801dc5 <syscall>
  801e13:	83 c4 18             	add    $0x18,%esp
}
  801e16:	90                   	nop
  801e17:	c9                   	leave  
  801e18:	c3                   	ret    

00801e19 <sys_cgetc>:

int
sys_cgetc(void)
{
  801e19:	55                   	push   %ebp
  801e1a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801e1c:	6a 00                	push   $0x0
  801e1e:	6a 00                	push   $0x0
  801e20:	6a 00                	push   $0x0
  801e22:	6a 00                	push   $0x0
  801e24:	6a 00                	push   $0x0
  801e26:	6a 01                	push   $0x1
  801e28:	e8 98 ff ff ff       	call   801dc5 <syscall>
  801e2d:	83 c4 18             	add    $0x18,%esp
}
  801e30:	c9                   	leave  
  801e31:	c3                   	ret    

00801e32 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801e32:	55                   	push   %ebp
  801e33:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801e35:	8b 45 08             	mov    0x8(%ebp),%eax
  801e38:	6a 00                	push   $0x0
  801e3a:	6a 00                	push   $0x0
  801e3c:	6a 00                	push   $0x0
  801e3e:	6a 00                	push   $0x0
  801e40:	50                   	push   %eax
  801e41:	6a 05                	push   $0x5
  801e43:	e8 7d ff ff ff       	call   801dc5 <syscall>
  801e48:	83 c4 18             	add    $0x18,%esp
}
  801e4b:	c9                   	leave  
  801e4c:	c3                   	ret    

00801e4d <sys_getenvid>:

int32 sys_getenvid(void)
{
  801e4d:	55                   	push   %ebp
  801e4e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801e50:	6a 00                	push   $0x0
  801e52:	6a 00                	push   $0x0
  801e54:	6a 00                	push   $0x0
  801e56:	6a 00                	push   $0x0
  801e58:	6a 00                	push   $0x0
  801e5a:	6a 02                	push   $0x2
  801e5c:	e8 64 ff ff ff       	call   801dc5 <syscall>
  801e61:	83 c4 18             	add    $0x18,%esp
}
  801e64:	c9                   	leave  
  801e65:	c3                   	ret    

00801e66 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801e66:	55                   	push   %ebp
  801e67:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 00                	push   $0x0
  801e6d:	6a 00                	push   $0x0
  801e6f:	6a 00                	push   $0x0
  801e71:	6a 00                	push   $0x0
  801e73:	6a 03                	push   $0x3
  801e75:	e8 4b ff ff ff       	call   801dc5 <syscall>
  801e7a:	83 c4 18             	add    $0x18,%esp
}
  801e7d:	c9                   	leave  
  801e7e:	c3                   	ret    

00801e7f <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801e7f:	55                   	push   %ebp
  801e80:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801e82:	6a 00                	push   $0x0
  801e84:	6a 00                	push   $0x0
  801e86:	6a 00                	push   $0x0
  801e88:	6a 00                	push   $0x0
  801e8a:	6a 00                	push   $0x0
  801e8c:	6a 04                	push   $0x4
  801e8e:	e8 32 ff ff ff       	call   801dc5 <syscall>
  801e93:	83 c4 18             	add    $0x18,%esp
}
  801e96:	c9                   	leave  
  801e97:	c3                   	ret    

00801e98 <sys_env_exit>:


void sys_env_exit(void)
{
  801e98:	55                   	push   %ebp
  801e99:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801e9b:	6a 00                	push   $0x0
  801e9d:	6a 00                	push   $0x0
  801e9f:	6a 00                	push   $0x0
  801ea1:	6a 00                	push   $0x0
  801ea3:	6a 00                	push   $0x0
  801ea5:	6a 06                	push   $0x6
  801ea7:	e8 19 ff ff ff       	call   801dc5 <syscall>
  801eac:	83 c4 18             	add    $0x18,%esp
}
  801eaf:	90                   	nop
  801eb0:	c9                   	leave  
  801eb1:	c3                   	ret    

00801eb2 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801eb2:	55                   	push   %ebp
  801eb3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801eb5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eb8:	8b 45 08             	mov    0x8(%ebp),%eax
  801ebb:	6a 00                	push   $0x0
  801ebd:	6a 00                	push   $0x0
  801ebf:	6a 00                	push   $0x0
  801ec1:	52                   	push   %edx
  801ec2:	50                   	push   %eax
  801ec3:	6a 07                	push   $0x7
  801ec5:	e8 fb fe ff ff       	call   801dc5 <syscall>
  801eca:	83 c4 18             	add    $0x18,%esp
}
  801ecd:	c9                   	leave  
  801ece:	c3                   	ret    

00801ecf <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801ecf:	55                   	push   %ebp
  801ed0:	89 e5                	mov    %esp,%ebp
  801ed2:	56                   	push   %esi
  801ed3:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801ed4:	8b 75 18             	mov    0x18(%ebp),%esi
  801ed7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801eda:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801edd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ee0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee3:	56                   	push   %esi
  801ee4:	53                   	push   %ebx
  801ee5:	51                   	push   %ecx
  801ee6:	52                   	push   %edx
  801ee7:	50                   	push   %eax
  801ee8:	6a 08                	push   $0x8
  801eea:	e8 d6 fe ff ff       	call   801dc5 <syscall>
  801eef:	83 c4 18             	add    $0x18,%esp
}
  801ef2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801ef5:	5b                   	pop    %ebx
  801ef6:	5e                   	pop    %esi
  801ef7:	5d                   	pop    %ebp
  801ef8:	c3                   	ret    

00801ef9 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801ef9:	55                   	push   %ebp
  801efa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801efc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eff:	8b 45 08             	mov    0x8(%ebp),%eax
  801f02:	6a 00                	push   $0x0
  801f04:	6a 00                	push   $0x0
  801f06:	6a 00                	push   $0x0
  801f08:	52                   	push   %edx
  801f09:	50                   	push   %eax
  801f0a:	6a 09                	push   $0x9
  801f0c:	e8 b4 fe ff ff       	call   801dc5 <syscall>
  801f11:	83 c4 18             	add    $0x18,%esp
}
  801f14:	c9                   	leave  
  801f15:	c3                   	ret    

00801f16 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801f16:	55                   	push   %ebp
  801f17:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801f19:	6a 00                	push   $0x0
  801f1b:	6a 00                	push   $0x0
  801f1d:	6a 00                	push   $0x0
  801f1f:	ff 75 0c             	pushl  0xc(%ebp)
  801f22:	ff 75 08             	pushl  0x8(%ebp)
  801f25:	6a 0a                	push   $0xa
  801f27:	e8 99 fe ff ff       	call   801dc5 <syscall>
  801f2c:	83 c4 18             	add    $0x18,%esp
}
  801f2f:	c9                   	leave  
  801f30:	c3                   	ret    

00801f31 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801f31:	55                   	push   %ebp
  801f32:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 00                	push   $0x0
  801f3c:	6a 00                	push   $0x0
  801f3e:	6a 0b                	push   $0xb
  801f40:	e8 80 fe ff ff       	call   801dc5 <syscall>
  801f45:	83 c4 18             	add    $0x18,%esp
}
  801f48:	c9                   	leave  
  801f49:	c3                   	ret    

00801f4a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801f4a:	55                   	push   %ebp
  801f4b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 00                	push   $0x0
  801f51:	6a 00                	push   $0x0
  801f53:	6a 00                	push   $0x0
  801f55:	6a 00                	push   $0x0
  801f57:	6a 0c                	push   $0xc
  801f59:	e8 67 fe ff ff       	call   801dc5 <syscall>
  801f5e:	83 c4 18             	add    $0x18,%esp
}
  801f61:	c9                   	leave  
  801f62:	c3                   	ret    

00801f63 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801f63:	55                   	push   %ebp
  801f64:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801f66:	6a 00                	push   $0x0
  801f68:	6a 00                	push   $0x0
  801f6a:	6a 00                	push   $0x0
  801f6c:	6a 00                	push   $0x0
  801f6e:	6a 00                	push   $0x0
  801f70:	6a 0d                	push   $0xd
  801f72:	e8 4e fe ff ff       	call   801dc5 <syscall>
  801f77:	83 c4 18             	add    $0x18,%esp
}
  801f7a:	c9                   	leave  
  801f7b:	c3                   	ret    

00801f7c <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801f7c:	55                   	push   %ebp
  801f7d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801f7f:	6a 00                	push   $0x0
  801f81:	6a 00                	push   $0x0
  801f83:	6a 00                	push   $0x0
  801f85:	ff 75 0c             	pushl  0xc(%ebp)
  801f88:	ff 75 08             	pushl  0x8(%ebp)
  801f8b:	6a 11                	push   $0x11
  801f8d:	e8 33 fe ff ff       	call   801dc5 <syscall>
  801f92:	83 c4 18             	add    $0x18,%esp
	return;
  801f95:	90                   	nop
}
  801f96:	c9                   	leave  
  801f97:	c3                   	ret    

00801f98 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801f98:	55                   	push   %ebp
  801f99:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801f9b:	6a 00                	push   $0x0
  801f9d:	6a 00                	push   $0x0
  801f9f:	6a 00                	push   $0x0
  801fa1:	ff 75 0c             	pushl  0xc(%ebp)
  801fa4:	ff 75 08             	pushl  0x8(%ebp)
  801fa7:	6a 12                	push   $0x12
  801fa9:	e8 17 fe ff ff       	call   801dc5 <syscall>
  801fae:	83 c4 18             	add    $0x18,%esp
	return ;
  801fb1:	90                   	nop
}
  801fb2:	c9                   	leave  
  801fb3:	c3                   	ret    

00801fb4 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801fb4:	55                   	push   %ebp
  801fb5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801fb7:	6a 00                	push   $0x0
  801fb9:	6a 00                	push   $0x0
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	6a 0e                	push   $0xe
  801fc3:	e8 fd fd ff ff       	call   801dc5 <syscall>
  801fc8:	83 c4 18             	add    $0x18,%esp
}
  801fcb:	c9                   	leave  
  801fcc:	c3                   	ret    

00801fcd <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801fcd:	55                   	push   %ebp
  801fce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801fd0:	6a 00                	push   $0x0
  801fd2:	6a 00                	push   $0x0
  801fd4:	6a 00                	push   $0x0
  801fd6:	6a 00                	push   $0x0
  801fd8:	ff 75 08             	pushl  0x8(%ebp)
  801fdb:	6a 0f                	push   $0xf
  801fdd:	e8 e3 fd ff ff       	call   801dc5 <syscall>
  801fe2:	83 c4 18             	add    $0x18,%esp
}
  801fe5:	c9                   	leave  
  801fe6:	c3                   	ret    

00801fe7 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801fe7:	55                   	push   %ebp
  801fe8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801fea:	6a 00                	push   $0x0
  801fec:	6a 00                	push   $0x0
  801fee:	6a 00                	push   $0x0
  801ff0:	6a 00                	push   $0x0
  801ff2:	6a 00                	push   $0x0
  801ff4:	6a 10                	push   $0x10
  801ff6:	e8 ca fd ff ff       	call   801dc5 <syscall>
  801ffb:	83 c4 18             	add    $0x18,%esp
}
  801ffe:	90                   	nop
  801fff:	c9                   	leave  
  802000:	c3                   	ret    

00802001 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802001:	55                   	push   %ebp
  802002:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802004:	6a 00                	push   $0x0
  802006:	6a 00                	push   $0x0
  802008:	6a 00                	push   $0x0
  80200a:	6a 00                	push   $0x0
  80200c:	6a 00                	push   $0x0
  80200e:	6a 14                	push   $0x14
  802010:	e8 b0 fd ff ff       	call   801dc5 <syscall>
  802015:	83 c4 18             	add    $0x18,%esp
}
  802018:	90                   	nop
  802019:	c9                   	leave  
  80201a:	c3                   	ret    

0080201b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80201b:	55                   	push   %ebp
  80201c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80201e:	6a 00                	push   $0x0
  802020:	6a 00                	push   $0x0
  802022:	6a 00                	push   $0x0
  802024:	6a 00                	push   $0x0
  802026:	6a 00                	push   $0x0
  802028:	6a 15                	push   $0x15
  80202a:	e8 96 fd ff ff       	call   801dc5 <syscall>
  80202f:	83 c4 18             	add    $0x18,%esp
}
  802032:	90                   	nop
  802033:	c9                   	leave  
  802034:	c3                   	ret    

00802035 <sys_cputc>:


void
sys_cputc(const char c)
{
  802035:	55                   	push   %ebp
  802036:	89 e5                	mov    %esp,%ebp
  802038:	83 ec 04             	sub    $0x4,%esp
  80203b:	8b 45 08             	mov    0x8(%ebp),%eax
  80203e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802041:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802045:	6a 00                	push   $0x0
  802047:	6a 00                	push   $0x0
  802049:	6a 00                	push   $0x0
  80204b:	6a 00                	push   $0x0
  80204d:	50                   	push   %eax
  80204e:	6a 16                	push   $0x16
  802050:	e8 70 fd ff ff       	call   801dc5 <syscall>
  802055:	83 c4 18             	add    $0x18,%esp
}
  802058:	90                   	nop
  802059:	c9                   	leave  
  80205a:	c3                   	ret    

0080205b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80205b:	55                   	push   %ebp
  80205c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80205e:	6a 00                	push   $0x0
  802060:	6a 00                	push   $0x0
  802062:	6a 00                	push   $0x0
  802064:	6a 00                	push   $0x0
  802066:	6a 00                	push   $0x0
  802068:	6a 17                	push   $0x17
  80206a:	e8 56 fd ff ff       	call   801dc5 <syscall>
  80206f:	83 c4 18             	add    $0x18,%esp
}
  802072:	90                   	nop
  802073:	c9                   	leave  
  802074:	c3                   	ret    

00802075 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802075:	55                   	push   %ebp
  802076:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802078:	8b 45 08             	mov    0x8(%ebp),%eax
  80207b:	6a 00                	push   $0x0
  80207d:	6a 00                	push   $0x0
  80207f:	6a 00                	push   $0x0
  802081:	ff 75 0c             	pushl  0xc(%ebp)
  802084:	50                   	push   %eax
  802085:	6a 18                	push   $0x18
  802087:	e8 39 fd ff ff       	call   801dc5 <syscall>
  80208c:	83 c4 18             	add    $0x18,%esp
}
  80208f:	c9                   	leave  
  802090:	c3                   	ret    

00802091 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802091:	55                   	push   %ebp
  802092:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802094:	8b 55 0c             	mov    0xc(%ebp),%edx
  802097:	8b 45 08             	mov    0x8(%ebp),%eax
  80209a:	6a 00                	push   $0x0
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	52                   	push   %edx
  8020a1:	50                   	push   %eax
  8020a2:	6a 1b                	push   $0x1b
  8020a4:	e8 1c fd ff ff       	call   801dc5 <syscall>
  8020a9:	83 c4 18             	add    $0x18,%esp
}
  8020ac:	c9                   	leave  
  8020ad:	c3                   	ret    

008020ae <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8020ae:	55                   	push   %ebp
  8020af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b7:	6a 00                	push   $0x0
  8020b9:	6a 00                	push   $0x0
  8020bb:	6a 00                	push   $0x0
  8020bd:	52                   	push   %edx
  8020be:	50                   	push   %eax
  8020bf:	6a 19                	push   $0x19
  8020c1:	e8 ff fc ff ff       	call   801dc5 <syscall>
  8020c6:	83 c4 18             	add    $0x18,%esp
}
  8020c9:	90                   	nop
  8020ca:	c9                   	leave  
  8020cb:	c3                   	ret    

008020cc <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8020cc:	55                   	push   %ebp
  8020cd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8020d5:	6a 00                	push   $0x0
  8020d7:	6a 00                	push   $0x0
  8020d9:	6a 00                	push   $0x0
  8020db:	52                   	push   %edx
  8020dc:	50                   	push   %eax
  8020dd:	6a 1a                	push   $0x1a
  8020df:	e8 e1 fc ff ff       	call   801dc5 <syscall>
  8020e4:	83 c4 18             	add    $0x18,%esp
}
  8020e7:	90                   	nop
  8020e8:	c9                   	leave  
  8020e9:	c3                   	ret    

008020ea <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8020ea:	55                   	push   %ebp
  8020eb:	89 e5                	mov    %esp,%ebp
  8020ed:	83 ec 04             	sub    $0x4,%esp
  8020f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8020f3:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8020f6:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8020f9:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8020fd:	8b 45 08             	mov    0x8(%ebp),%eax
  802100:	6a 00                	push   $0x0
  802102:	51                   	push   %ecx
  802103:	52                   	push   %edx
  802104:	ff 75 0c             	pushl  0xc(%ebp)
  802107:	50                   	push   %eax
  802108:	6a 1c                	push   $0x1c
  80210a:	e8 b6 fc ff ff       	call   801dc5 <syscall>
  80210f:	83 c4 18             	add    $0x18,%esp
}
  802112:	c9                   	leave  
  802113:	c3                   	ret    

00802114 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802114:	55                   	push   %ebp
  802115:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802117:	8b 55 0c             	mov    0xc(%ebp),%edx
  80211a:	8b 45 08             	mov    0x8(%ebp),%eax
  80211d:	6a 00                	push   $0x0
  80211f:	6a 00                	push   $0x0
  802121:	6a 00                	push   $0x0
  802123:	52                   	push   %edx
  802124:	50                   	push   %eax
  802125:	6a 1d                	push   $0x1d
  802127:	e8 99 fc ff ff       	call   801dc5 <syscall>
  80212c:	83 c4 18             	add    $0x18,%esp
}
  80212f:	c9                   	leave  
  802130:	c3                   	ret    

00802131 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802131:	55                   	push   %ebp
  802132:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802134:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802137:	8b 55 0c             	mov    0xc(%ebp),%edx
  80213a:	8b 45 08             	mov    0x8(%ebp),%eax
  80213d:	6a 00                	push   $0x0
  80213f:	6a 00                	push   $0x0
  802141:	51                   	push   %ecx
  802142:	52                   	push   %edx
  802143:	50                   	push   %eax
  802144:	6a 1e                	push   $0x1e
  802146:	e8 7a fc ff ff       	call   801dc5 <syscall>
  80214b:	83 c4 18             	add    $0x18,%esp
}
  80214e:	c9                   	leave  
  80214f:	c3                   	ret    

00802150 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802150:	55                   	push   %ebp
  802151:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802153:	8b 55 0c             	mov    0xc(%ebp),%edx
  802156:	8b 45 08             	mov    0x8(%ebp),%eax
  802159:	6a 00                	push   $0x0
  80215b:	6a 00                	push   $0x0
  80215d:	6a 00                	push   $0x0
  80215f:	52                   	push   %edx
  802160:	50                   	push   %eax
  802161:	6a 1f                	push   $0x1f
  802163:	e8 5d fc ff ff       	call   801dc5 <syscall>
  802168:	83 c4 18             	add    $0x18,%esp
}
  80216b:	c9                   	leave  
  80216c:	c3                   	ret    

0080216d <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80216d:	55                   	push   %ebp
  80216e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802170:	6a 00                	push   $0x0
  802172:	6a 00                	push   $0x0
  802174:	6a 00                	push   $0x0
  802176:	6a 00                	push   $0x0
  802178:	6a 00                	push   $0x0
  80217a:	6a 20                	push   $0x20
  80217c:	e8 44 fc ff ff       	call   801dc5 <syscall>
  802181:	83 c4 18             	add    $0x18,%esp
}
  802184:	c9                   	leave  
  802185:	c3                   	ret    

00802186 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802186:	55                   	push   %ebp
  802187:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802189:	8b 45 08             	mov    0x8(%ebp),%eax
  80218c:	6a 00                	push   $0x0
  80218e:	ff 75 14             	pushl  0x14(%ebp)
  802191:	ff 75 10             	pushl  0x10(%ebp)
  802194:	ff 75 0c             	pushl  0xc(%ebp)
  802197:	50                   	push   %eax
  802198:	6a 21                	push   $0x21
  80219a:	e8 26 fc ff ff       	call   801dc5 <syscall>
  80219f:	83 c4 18             	add    $0x18,%esp
}
  8021a2:	c9                   	leave  
  8021a3:	c3                   	ret    

008021a4 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8021a4:	55                   	push   %ebp
  8021a5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8021a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8021aa:	6a 00                	push   $0x0
  8021ac:	6a 00                	push   $0x0
  8021ae:	6a 00                	push   $0x0
  8021b0:	6a 00                	push   $0x0
  8021b2:	50                   	push   %eax
  8021b3:	6a 22                	push   $0x22
  8021b5:	e8 0b fc ff ff       	call   801dc5 <syscall>
  8021ba:	83 c4 18             	add    $0x18,%esp
}
  8021bd:	90                   	nop
  8021be:	c9                   	leave  
  8021bf:	c3                   	ret    

008021c0 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8021c0:	55                   	push   %ebp
  8021c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8021c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c6:	6a 00                	push   $0x0
  8021c8:	6a 00                	push   $0x0
  8021ca:	6a 00                	push   $0x0
  8021cc:	6a 00                	push   $0x0
  8021ce:	50                   	push   %eax
  8021cf:	6a 23                	push   $0x23
  8021d1:	e8 ef fb ff ff       	call   801dc5 <syscall>
  8021d6:	83 c4 18             	add    $0x18,%esp
}
  8021d9:	90                   	nop
  8021da:	c9                   	leave  
  8021db:	c3                   	ret    

008021dc <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8021dc:	55                   	push   %ebp
  8021dd:	89 e5                	mov    %esp,%ebp
  8021df:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8021e2:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8021e5:	8d 50 04             	lea    0x4(%eax),%edx
  8021e8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8021eb:	6a 00                	push   $0x0
  8021ed:	6a 00                	push   $0x0
  8021ef:	6a 00                	push   $0x0
  8021f1:	52                   	push   %edx
  8021f2:	50                   	push   %eax
  8021f3:	6a 24                	push   $0x24
  8021f5:	e8 cb fb ff ff       	call   801dc5 <syscall>
  8021fa:	83 c4 18             	add    $0x18,%esp
	return result;
  8021fd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802200:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802203:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802206:	89 01                	mov    %eax,(%ecx)
  802208:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80220b:	8b 45 08             	mov    0x8(%ebp),%eax
  80220e:	c9                   	leave  
  80220f:	c2 04 00             	ret    $0x4

00802212 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802212:	55                   	push   %ebp
  802213:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802215:	6a 00                	push   $0x0
  802217:	6a 00                	push   $0x0
  802219:	ff 75 10             	pushl  0x10(%ebp)
  80221c:	ff 75 0c             	pushl  0xc(%ebp)
  80221f:	ff 75 08             	pushl  0x8(%ebp)
  802222:	6a 13                	push   $0x13
  802224:	e8 9c fb ff ff       	call   801dc5 <syscall>
  802229:	83 c4 18             	add    $0x18,%esp
	return ;
  80222c:	90                   	nop
}
  80222d:	c9                   	leave  
  80222e:	c3                   	ret    

0080222f <sys_rcr2>:
uint32 sys_rcr2()
{
  80222f:	55                   	push   %ebp
  802230:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802232:	6a 00                	push   $0x0
  802234:	6a 00                	push   $0x0
  802236:	6a 00                	push   $0x0
  802238:	6a 00                	push   $0x0
  80223a:	6a 00                	push   $0x0
  80223c:	6a 25                	push   $0x25
  80223e:	e8 82 fb ff ff       	call   801dc5 <syscall>
  802243:	83 c4 18             	add    $0x18,%esp
}
  802246:	c9                   	leave  
  802247:	c3                   	ret    

00802248 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802248:	55                   	push   %ebp
  802249:	89 e5                	mov    %esp,%ebp
  80224b:	83 ec 04             	sub    $0x4,%esp
  80224e:	8b 45 08             	mov    0x8(%ebp),%eax
  802251:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802254:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802258:	6a 00                	push   $0x0
  80225a:	6a 00                	push   $0x0
  80225c:	6a 00                	push   $0x0
  80225e:	6a 00                	push   $0x0
  802260:	50                   	push   %eax
  802261:	6a 26                	push   $0x26
  802263:	e8 5d fb ff ff       	call   801dc5 <syscall>
  802268:	83 c4 18             	add    $0x18,%esp
	return ;
  80226b:	90                   	nop
}
  80226c:	c9                   	leave  
  80226d:	c3                   	ret    

0080226e <rsttst>:
void rsttst()
{
  80226e:	55                   	push   %ebp
  80226f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802271:	6a 00                	push   $0x0
  802273:	6a 00                	push   $0x0
  802275:	6a 00                	push   $0x0
  802277:	6a 00                	push   $0x0
  802279:	6a 00                	push   $0x0
  80227b:	6a 28                	push   $0x28
  80227d:	e8 43 fb ff ff       	call   801dc5 <syscall>
  802282:	83 c4 18             	add    $0x18,%esp
	return ;
  802285:	90                   	nop
}
  802286:	c9                   	leave  
  802287:	c3                   	ret    

00802288 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802288:	55                   	push   %ebp
  802289:	89 e5                	mov    %esp,%ebp
  80228b:	83 ec 04             	sub    $0x4,%esp
  80228e:	8b 45 14             	mov    0x14(%ebp),%eax
  802291:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802294:	8b 55 18             	mov    0x18(%ebp),%edx
  802297:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80229b:	52                   	push   %edx
  80229c:	50                   	push   %eax
  80229d:	ff 75 10             	pushl  0x10(%ebp)
  8022a0:	ff 75 0c             	pushl  0xc(%ebp)
  8022a3:	ff 75 08             	pushl  0x8(%ebp)
  8022a6:	6a 27                	push   $0x27
  8022a8:	e8 18 fb ff ff       	call   801dc5 <syscall>
  8022ad:	83 c4 18             	add    $0x18,%esp
	return ;
  8022b0:	90                   	nop
}
  8022b1:	c9                   	leave  
  8022b2:	c3                   	ret    

008022b3 <chktst>:
void chktst(uint32 n)
{
  8022b3:	55                   	push   %ebp
  8022b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8022b6:	6a 00                	push   $0x0
  8022b8:	6a 00                	push   $0x0
  8022ba:	6a 00                	push   $0x0
  8022bc:	6a 00                	push   $0x0
  8022be:	ff 75 08             	pushl  0x8(%ebp)
  8022c1:	6a 29                	push   $0x29
  8022c3:	e8 fd fa ff ff       	call   801dc5 <syscall>
  8022c8:	83 c4 18             	add    $0x18,%esp
	return ;
  8022cb:	90                   	nop
}
  8022cc:	c9                   	leave  
  8022cd:	c3                   	ret    

008022ce <inctst>:

void inctst()
{
  8022ce:	55                   	push   %ebp
  8022cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8022d1:	6a 00                	push   $0x0
  8022d3:	6a 00                	push   $0x0
  8022d5:	6a 00                	push   $0x0
  8022d7:	6a 00                	push   $0x0
  8022d9:	6a 00                	push   $0x0
  8022db:	6a 2a                	push   $0x2a
  8022dd:	e8 e3 fa ff ff       	call   801dc5 <syscall>
  8022e2:	83 c4 18             	add    $0x18,%esp
	return ;
  8022e5:	90                   	nop
}
  8022e6:	c9                   	leave  
  8022e7:	c3                   	ret    

008022e8 <gettst>:
uint32 gettst()
{
  8022e8:	55                   	push   %ebp
  8022e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8022eb:	6a 00                	push   $0x0
  8022ed:	6a 00                	push   $0x0
  8022ef:	6a 00                	push   $0x0
  8022f1:	6a 00                	push   $0x0
  8022f3:	6a 00                	push   $0x0
  8022f5:	6a 2b                	push   $0x2b
  8022f7:	e8 c9 fa ff ff       	call   801dc5 <syscall>
  8022fc:	83 c4 18             	add    $0x18,%esp
}
  8022ff:	c9                   	leave  
  802300:	c3                   	ret    

00802301 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802301:	55                   	push   %ebp
  802302:	89 e5                	mov    %esp,%ebp
  802304:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802307:	6a 00                	push   $0x0
  802309:	6a 00                	push   $0x0
  80230b:	6a 00                	push   $0x0
  80230d:	6a 00                	push   $0x0
  80230f:	6a 00                	push   $0x0
  802311:	6a 2c                	push   $0x2c
  802313:	e8 ad fa ff ff       	call   801dc5 <syscall>
  802318:	83 c4 18             	add    $0x18,%esp
  80231b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80231e:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802322:	75 07                	jne    80232b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802324:	b8 01 00 00 00       	mov    $0x1,%eax
  802329:	eb 05                	jmp    802330 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80232b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802330:	c9                   	leave  
  802331:	c3                   	ret    

00802332 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802332:	55                   	push   %ebp
  802333:	89 e5                	mov    %esp,%ebp
  802335:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802338:	6a 00                	push   $0x0
  80233a:	6a 00                	push   $0x0
  80233c:	6a 00                	push   $0x0
  80233e:	6a 00                	push   $0x0
  802340:	6a 00                	push   $0x0
  802342:	6a 2c                	push   $0x2c
  802344:	e8 7c fa ff ff       	call   801dc5 <syscall>
  802349:	83 c4 18             	add    $0x18,%esp
  80234c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80234f:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802353:	75 07                	jne    80235c <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802355:	b8 01 00 00 00       	mov    $0x1,%eax
  80235a:	eb 05                	jmp    802361 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80235c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802361:	c9                   	leave  
  802362:	c3                   	ret    

00802363 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802363:	55                   	push   %ebp
  802364:	89 e5                	mov    %esp,%ebp
  802366:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802369:	6a 00                	push   $0x0
  80236b:	6a 00                	push   $0x0
  80236d:	6a 00                	push   $0x0
  80236f:	6a 00                	push   $0x0
  802371:	6a 00                	push   $0x0
  802373:	6a 2c                	push   $0x2c
  802375:	e8 4b fa ff ff       	call   801dc5 <syscall>
  80237a:	83 c4 18             	add    $0x18,%esp
  80237d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802380:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802384:	75 07                	jne    80238d <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802386:	b8 01 00 00 00       	mov    $0x1,%eax
  80238b:	eb 05                	jmp    802392 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80238d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802392:	c9                   	leave  
  802393:	c3                   	ret    

00802394 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802394:	55                   	push   %ebp
  802395:	89 e5                	mov    %esp,%ebp
  802397:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80239a:	6a 00                	push   $0x0
  80239c:	6a 00                	push   $0x0
  80239e:	6a 00                	push   $0x0
  8023a0:	6a 00                	push   $0x0
  8023a2:	6a 00                	push   $0x0
  8023a4:	6a 2c                	push   $0x2c
  8023a6:	e8 1a fa ff ff       	call   801dc5 <syscall>
  8023ab:	83 c4 18             	add    $0x18,%esp
  8023ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8023b1:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8023b5:	75 07                	jne    8023be <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8023b7:	b8 01 00 00 00       	mov    $0x1,%eax
  8023bc:	eb 05                	jmp    8023c3 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8023be:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023c3:	c9                   	leave  
  8023c4:	c3                   	ret    

008023c5 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8023c5:	55                   	push   %ebp
  8023c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8023c8:	6a 00                	push   $0x0
  8023ca:	6a 00                	push   $0x0
  8023cc:	6a 00                	push   $0x0
  8023ce:	6a 00                	push   $0x0
  8023d0:	ff 75 08             	pushl  0x8(%ebp)
  8023d3:	6a 2d                	push   $0x2d
  8023d5:	e8 eb f9 ff ff       	call   801dc5 <syscall>
  8023da:	83 c4 18             	add    $0x18,%esp
	return ;
  8023dd:	90                   	nop
}
  8023de:	c9                   	leave  
  8023df:	c3                   	ret    

008023e0 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8023e0:	55                   	push   %ebp
  8023e1:	89 e5                	mov    %esp,%ebp
  8023e3:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8023e4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8023e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8023ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8023f0:	6a 00                	push   $0x0
  8023f2:	53                   	push   %ebx
  8023f3:	51                   	push   %ecx
  8023f4:	52                   	push   %edx
  8023f5:	50                   	push   %eax
  8023f6:	6a 2e                	push   $0x2e
  8023f8:	e8 c8 f9 ff ff       	call   801dc5 <syscall>
  8023fd:	83 c4 18             	add    $0x18,%esp
}
  802400:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802403:	c9                   	leave  
  802404:	c3                   	ret    

00802405 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802405:	55                   	push   %ebp
  802406:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802408:	8b 55 0c             	mov    0xc(%ebp),%edx
  80240b:	8b 45 08             	mov    0x8(%ebp),%eax
  80240e:	6a 00                	push   $0x0
  802410:	6a 00                	push   $0x0
  802412:	6a 00                	push   $0x0
  802414:	52                   	push   %edx
  802415:	50                   	push   %eax
  802416:	6a 2f                	push   $0x2f
  802418:	e8 a8 f9 ff ff       	call   801dc5 <syscall>
  80241d:	83 c4 18             	add    $0x18,%esp
}
  802420:	c9                   	leave  
  802421:	c3                   	ret    
  802422:	66 90                	xchg   %ax,%ax

00802424 <__udivdi3>:
  802424:	55                   	push   %ebp
  802425:	57                   	push   %edi
  802426:	56                   	push   %esi
  802427:	53                   	push   %ebx
  802428:	83 ec 1c             	sub    $0x1c,%esp
  80242b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80242f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802433:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802437:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80243b:	89 ca                	mov    %ecx,%edx
  80243d:	89 f8                	mov    %edi,%eax
  80243f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802443:	85 f6                	test   %esi,%esi
  802445:	75 2d                	jne    802474 <__udivdi3+0x50>
  802447:	39 cf                	cmp    %ecx,%edi
  802449:	77 65                	ja     8024b0 <__udivdi3+0x8c>
  80244b:	89 fd                	mov    %edi,%ebp
  80244d:	85 ff                	test   %edi,%edi
  80244f:	75 0b                	jne    80245c <__udivdi3+0x38>
  802451:	b8 01 00 00 00       	mov    $0x1,%eax
  802456:	31 d2                	xor    %edx,%edx
  802458:	f7 f7                	div    %edi
  80245a:	89 c5                	mov    %eax,%ebp
  80245c:	31 d2                	xor    %edx,%edx
  80245e:	89 c8                	mov    %ecx,%eax
  802460:	f7 f5                	div    %ebp
  802462:	89 c1                	mov    %eax,%ecx
  802464:	89 d8                	mov    %ebx,%eax
  802466:	f7 f5                	div    %ebp
  802468:	89 cf                	mov    %ecx,%edi
  80246a:	89 fa                	mov    %edi,%edx
  80246c:	83 c4 1c             	add    $0x1c,%esp
  80246f:	5b                   	pop    %ebx
  802470:	5e                   	pop    %esi
  802471:	5f                   	pop    %edi
  802472:	5d                   	pop    %ebp
  802473:	c3                   	ret    
  802474:	39 ce                	cmp    %ecx,%esi
  802476:	77 28                	ja     8024a0 <__udivdi3+0x7c>
  802478:	0f bd fe             	bsr    %esi,%edi
  80247b:	83 f7 1f             	xor    $0x1f,%edi
  80247e:	75 40                	jne    8024c0 <__udivdi3+0x9c>
  802480:	39 ce                	cmp    %ecx,%esi
  802482:	72 0a                	jb     80248e <__udivdi3+0x6a>
  802484:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802488:	0f 87 9e 00 00 00    	ja     80252c <__udivdi3+0x108>
  80248e:	b8 01 00 00 00       	mov    $0x1,%eax
  802493:	89 fa                	mov    %edi,%edx
  802495:	83 c4 1c             	add    $0x1c,%esp
  802498:	5b                   	pop    %ebx
  802499:	5e                   	pop    %esi
  80249a:	5f                   	pop    %edi
  80249b:	5d                   	pop    %ebp
  80249c:	c3                   	ret    
  80249d:	8d 76 00             	lea    0x0(%esi),%esi
  8024a0:	31 ff                	xor    %edi,%edi
  8024a2:	31 c0                	xor    %eax,%eax
  8024a4:	89 fa                	mov    %edi,%edx
  8024a6:	83 c4 1c             	add    $0x1c,%esp
  8024a9:	5b                   	pop    %ebx
  8024aa:	5e                   	pop    %esi
  8024ab:	5f                   	pop    %edi
  8024ac:	5d                   	pop    %ebp
  8024ad:	c3                   	ret    
  8024ae:	66 90                	xchg   %ax,%ax
  8024b0:	89 d8                	mov    %ebx,%eax
  8024b2:	f7 f7                	div    %edi
  8024b4:	31 ff                	xor    %edi,%edi
  8024b6:	89 fa                	mov    %edi,%edx
  8024b8:	83 c4 1c             	add    $0x1c,%esp
  8024bb:	5b                   	pop    %ebx
  8024bc:	5e                   	pop    %esi
  8024bd:	5f                   	pop    %edi
  8024be:	5d                   	pop    %ebp
  8024bf:	c3                   	ret    
  8024c0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8024c5:	89 eb                	mov    %ebp,%ebx
  8024c7:	29 fb                	sub    %edi,%ebx
  8024c9:	89 f9                	mov    %edi,%ecx
  8024cb:	d3 e6                	shl    %cl,%esi
  8024cd:	89 c5                	mov    %eax,%ebp
  8024cf:	88 d9                	mov    %bl,%cl
  8024d1:	d3 ed                	shr    %cl,%ebp
  8024d3:	89 e9                	mov    %ebp,%ecx
  8024d5:	09 f1                	or     %esi,%ecx
  8024d7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8024db:	89 f9                	mov    %edi,%ecx
  8024dd:	d3 e0                	shl    %cl,%eax
  8024df:	89 c5                	mov    %eax,%ebp
  8024e1:	89 d6                	mov    %edx,%esi
  8024e3:	88 d9                	mov    %bl,%cl
  8024e5:	d3 ee                	shr    %cl,%esi
  8024e7:	89 f9                	mov    %edi,%ecx
  8024e9:	d3 e2                	shl    %cl,%edx
  8024eb:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024ef:	88 d9                	mov    %bl,%cl
  8024f1:	d3 e8                	shr    %cl,%eax
  8024f3:	09 c2                	or     %eax,%edx
  8024f5:	89 d0                	mov    %edx,%eax
  8024f7:	89 f2                	mov    %esi,%edx
  8024f9:	f7 74 24 0c          	divl   0xc(%esp)
  8024fd:	89 d6                	mov    %edx,%esi
  8024ff:	89 c3                	mov    %eax,%ebx
  802501:	f7 e5                	mul    %ebp
  802503:	39 d6                	cmp    %edx,%esi
  802505:	72 19                	jb     802520 <__udivdi3+0xfc>
  802507:	74 0b                	je     802514 <__udivdi3+0xf0>
  802509:	89 d8                	mov    %ebx,%eax
  80250b:	31 ff                	xor    %edi,%edi
  80250d:	e9 58 ff ff ff       	jmp    80246a <__udivdi3+0x46>
  802512:	66 90                	xchg   %ax,%ax
  802514:	8b 54 24 08          	mov    0x8(%esp),%edx
  802518:	89 f9                	mov    %edi,%ecx
  80251a:	d3 e2                	shl    %cl,%edx
  80251c:	39 c2                	cmp    %eax,%edx
  80251e:	73 e9                	jae    802509 <__udivdi3+0xe5>
  802520:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802523:	31 ff                	xor    %edi,%edi
  802525:	e9 40 ff ff ff       	jmp    80246a <__udivdi3+0x46>
  80252a:	66 90                	xchg   %ax,%ax
  80252c:	31 c0                	xor    %eax,%eax
  80252e:	e9 37 ff ff ff       	jmp    80246a <__udivdi3+0x46>
  802533:	90                   	nop

00802534 <__umoddi3>:
  802534:	55                   	push   %ebp
  802535:	57                   	push   %edi
  802536:	56                   	push   %esi
  802537:	53                   	push   %ebx
  802538:	83 ec 1c             	sub    $0x1c,%esp
  80253b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80253f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802543:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802547:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80254b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80254f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802553:	89 f3                	mov    %esi,%ebx
  802555:	89 fa                	mov    %edi,%edx
  802557:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80255b:	89 34 24             	mov    %esi,(%esp)
  80255e:	85 c0                	test   %eax,%eax
  802560:	75 1a                	jne    80257c <__umoddi3+0x48>
  802562:	39 f7                	cmp    %esi,%edi
  802564:	0f 86 a2 00 00 00    	jbe    80260c <__umoddi3+0xd8>
  80256a:	89 c8                	mov    %ecx,%eax
  80256c:	89 f2                	mov    %esi,%edx
  80256e:	f7 f7                	div    %edi
  802570:	89 d0                	mov    %edx,%eax
  802572:	31 d2                	xor    %edx,%edx
  802574:	83 c4 1c             	add    $0x1c,%esp
  802577:	5b                   	pop    %ebx
  802578:	5e                   	pop    %esi
  802579:	5f                   	pop    %edi
  80257a:	5d                   	pop    %ebp
  80257b:	c3                   	ret    
  80257c:	39 f0                	cmp    %esi,%eax
  80257e:	0f 87 ac 00 00 00    	ja     802630 <__umoddi3+0xfc>
  802584:	0f bd e8             	bsr    %eax,%ebp
  802587:	83 f5 1f             	xor    $0x1f,%ebp
  80258a:	0f 84 ac 00 00 00    	je     80263c <__umoddi3+0x108>
  802590:	bf 20 00 00 00       	mov    $0x20,%edi
  802595:	29 ef                	sub    %ebp,%edi
  802597:	89 fe                	mov    %edi,%esi
  802599:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80259d:	89 e9                	mov    %ebp,%ecx
  80259f:	d3 e0                	shl    %cl,%eax
  8025a1:	89 d7                	mov    %edx,%edi
  8025a3:	89 f1                	mov    %esi,%ecx
  8025a5:	d3 ef                	shr    %cl,%edi
  8025a7:	09 c7                	or     %eax,%edi
  8025a9:	89 e9                	mov    %ebp,%ecx
  8025ab:	d3 e2                	shl    %cl,%edx
  8025ad:	89 14 24             	mov    %edx,(%esp)
  8025b0:	89 d8                	mov    %ebx,%eax
  8025b2:	d3 e0                	shl    %cl,%eax
  8025b4:	89 c2                	mov    %eax,%edx
  8025b6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8025ba:	d3 e0                	shl    %cl,%eax
  8025bc:	89 44 24 04          	mov    %eax,0x4(%esp)
  8025c0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8025c4:	89 f1                	mov    %esi,%ecx
  8025c6:	d3 e8                	shr    %cl,%eax
  8025c8:	09 d0                	or     %edx,%eax
  8025ca:	d3 eb                	shr    %cl,%ebx
  8025cc:	89 da                	mov    %ebx,%edx
  8025ce:	f7 f7                	div    %edi
  8025d0:	89 d3                	mov    %edx,%ebx
  8025d2:	f7 24 24             	mull   (%esp)
  8025d5:	89 c6                	mov    %eax,%esi
  8025d7:	89 d1                	mov    %edx,%ecx
  8025d9:	39 d3                	cmp    %edx,%ebx
  8025db:	0f 82 87 00 00 00    	jb     802668 <__umoddi3+0x134>
  8025e1:	0f 84 91 00 00 00    	je     802678 <__umoddi3+0x144>
  8025e7:	8b 54 24 04          	mov    0x4(%esp),%edx
  8025eb:	29 f2                	sub    %esi,%edx
  8025ed:	19 cb                	sbb    %ecx,%ebx
  8025ef:	89 d8                	mov    %ebx,%eax
  8025f1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8025f5:	d3 e0                	shl    %cl,%eax
  8025f7:	89 e9                	mov    %ebp,%ecx
  8025f9:	d3 ea                	shr    %cl,%edx
  8025fb:	09 d0                	or     %edx,%eax
  8025fd:	89 e9                	mov    %ebp,%ecx
  8025ff:	d3 eb                	shr    %cl,%ebx
  802601:	89 da                	mov    %ebx,%edx
  802603:	83 c4 1c             	add    $0x1c,%esp
  802606:	5b                   	pop    %ebx
  802607:	5e                   	pop    %esi
  802608:	5f                   	pop    %edi
  802609:	5d                   	pop    %ebp
  80260a:	c3                   	ret    
  80260b:	90                   	nop
  80260c:	89 fd                	mov    %edi,%ebp
  80260e:	85 ff                	test   %edi,%edi
  802610:	75 0b                	jne    80261d <__umoddi3+0xe9>
  802612:	b8 01 00 00 00       	mov    $0x1,%eax
  802617:	31 d2                	xor    %edx,%edx
  802619:	f7 f7                	div    %edi
  80261b:	89 c5                	mov    %eax,%ebp
  80261d:	89 f0                	mov    %esi,%eax
  80261f:	31 d2                	xor    %edx,%edx
  802621:	f7 f5                	div    %ebp
  802623:	89 c8                	mov    %ecx,%eax
  802625:	f7 f5                	div    %ebp
  802627:	89 d0                	mov    %edx,%eax
  802629:	e9 44 ff ff ff       	jmp    802572 <__umoddi3+0x3e>
  80262e:	66 90                	xchg   %ax,%ax
  802630:	89 c8                	mov    %ecx,%eax
  802632:	89 f2                	mov    %esi,%edx
  802634:	83 c4 1c             	add    $0x1c,%esp
  802637:	5b                   	pop    %ebx
  802638:	5e                   	pop    %esi
  802639:	5f                   	pop    %edi
  80263a:	5d                   	pop    %ebp
  80263b:	c3                   	ret    
  80263c:	3b 04 24             	cmp    (%esp),%eax
  80263f:	72 06                	jb     802647 <__umoddi3+0x113>
  802641:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802645:	77 0f                	ja     802656 <__umoddi3+0x122>
  802647:	89 f2                	mov    %esi,%edx
  802649:	29 f9                	sub    %edi,%ecx
  80264b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80264f:	89 14 24             	mov    %edx,(%esp)
  802652:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802656:	8b 44 24 04          	mov    0x4(%esp),%eax
  80265a:	8b 14 24             	mov    (%esp),%edx
  80265d:	83 c4 1c             	add    $0x1c,%esp
  802660:	5b                   	pop    %ebx
  802661:	5e                   	pop    %esi
  802662:	5f                   	pop    %edi
  802663:	5d                   	pop    %ebp
  802664:	c3                   	ret    
  802665:	8d 76 00             	lea    0x0(%esi),%esi
  802668:	2b 04 24             	sub    (%esp),%eax
  80266b:	19 fa                	sbb    %edi,%edx
  80266d:	89 d1                	mov    %edx,%ecx
  80266f:	89 c6                	mov    %eax,%esi
  802671:	e9 71 ff ff ff       	jmp    8025e7 <__umoddi3+0xb3>
  802676:	66 90                	xchg   %ax,%ax
  802678:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80267c:	72 ea                	jb     802668 <__umoddi3+0x134>
  80267e:	89 d9                	mov    %ebx,%ecx
  802680:	e9 62 ff ff ff       	jmp    8025e7 <__umoddi3+0xb3>
