
obj/user/quicksort3:     file format elf32-i386


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
  800031:	e8 c9 05 00 00       	call   8005ff <libmain>
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
	//int InitFreeFrames = sys_calculate_free_frames() ;
	char Line[255] ;
	char Chose ;
	int Iteration = 0 ;
  800042:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800049:	e8 c6 1e 00 00       	call   801f14 <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 d8 1e 00 00       	call   801f2d <sys_calculate_modified_frames>
  800055:	01 d8                	add    %ebx,%eax
  800057:	89 45 f0             	mov    %eax,-0x10(%ebp)

		Iteration++ ;
  80005a:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

	sys_disable_interrupt();
  80005d:	e8 82 1f 00 00       	call   801fe4 <sys_disable_interrupt>
		readline("Enter the number of elements: ", Line);
  800062:	83 ec 08             	sub    $0x8,%esp
  800065:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  80006b:	50                   	push   %eax
  80006c:	68 80 26 80 00       	push   $0x802680
  800071:	e8 f2 0f 00 00       	call   801068 <readline>
  800076:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  800079:	83 ec 04             	sub    $0x4,%esp
  80007c:	6a 0a                	push   $0xa
  80007e:	6a 00                	push   $0x0
  800080:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800086:	50                   	push   %eax
  800087:	e8 42 15 00 00       	call   8015ce <strtol>
  80008c:	83 c4 10             	add    $0x10,%esp
  80008f:	89 45 ec             	mov    %eax,-0x14(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  800092:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800095:	c1 e0 02             	shl    $0x2,%eax
  800098:	83 ec 0c             	sub    $0xc,%esp
  80009b:	50                   	push   %eax
  80009c:	e8 d5 18 00 00       	call   801976 <malloc>
  8000a1:	83 c4 10             	add    $0x10,%esp
  8000a4:	89 45 e8             	mov    %eax,-0x18(%ebp)
		Elements[NumOfElements] = 10 ;
  8000a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000b4:	01 d0                	add    %edx,%eax
  8000b6:	c7 00 0a 00 00 00    	movl   $0xa,(%eax)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000bc:	83 ec 0c             	sub    $0xc,%esp
  8000bf:	68 a0 26 80 00       	push   $0x8026a0
  8000c4:	e8 1d 09 00 00       	call   8009e6 <cprintf>
  8000c9:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	68 c3 26 80 00       	push   $0x8026c3
  8000d4:	e8 0d 09 00 00       	call   8009e6 <cprintf>
  8000d9:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000dc:	83 ec 0c             	sub    $0xc,%esp
  8000df:	68 d1 26 80 00       	push   $0x8026d1
  8000e4:	e8 fd 08 00 00       	call   8009e6 <cprintf>
  8000e9:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\nSelect: ") ;
  8000ec:	83 ec 0c             	sub    $0xc,%esp
  8000ef:	68 e0 26 80 00       	push   $0x8026e0
  8000f4:	e8 ed 08 00 00       	call   8009e6 <cprintf>
  8000f9:	83 c4 10             	add    $0x10,%esp
		Chose = getchar() ;
  8000fc:	e8 a6 04 00 00       	call   8005a7 <getchar>
  800101:	88 45 e7             	mov    %al,-0x19(%ebp)
		cputchar(Chose);
  800104:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  800108:	83 ec 0c             	sub    $0xc,%esp
  80010b:	50                   	push   %eax
  80010c:	e8 4e 04 00 00       	call   80055f <cputchar>
  800111:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  800114:	83 ec 0c             	sub    $0xc,%esp
  800117:	6a 0a                	push   $0xa
  800119:	e8 41 04 00 00       	call   80055f <cputchar>
  80011e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800121:	e8 d8 1e 00 00       	call   801ffe <sys_enable_interrupt>
		int  i ;
		switch (Chose)
  800126:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  80012a:	83 f8 62             	cmp    $0x62,%eax
  80012d:	74 1d                	je     80014c <_main+0x114>
  80012f:	83 f8 63             	cmp    $0x63,%eax
  800132:	74 2b                	je     80015f <_main+0x127>
  800134:	83 f8 61             	cmp    $0x61,%eax
  800137:	75 39                	jne    800172 <_main+0x13a>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800139:	83 ec 08             	sub    $0x8,%esp
  80013c:	ff 75 ec             	pushl  -0x14(%ebp)
  80013f:	ff 75 e8             	pushl  -0x18(%ebp)
  800142:	e8 e0 02 00 00       	call   800427 <InitializeAscending>
  800147:	83 c4 10             	add    $0x10,%esp
			break ;
  80014a:	eb 37                	jmp    800183 <_main+0x14b>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80014c:	83 ec 08             	sub    $0x8,%esp
  80014f:	ff 75 ec             	pushl  -0x14(%ebp)
  800152:	ff 75 e8             	pushl  -0x18(%ebp)
  800155:	e8 fe 02 00 00       	call   800458 <InitializeDescending>
  80015a:	83 c4 10             	add    $0x10,%esp
			break ;
  80015d:	eb 24                	jmp    800183 <_main+0x14b>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  80015f:	83 ec 08             	sub    $0x8,%esp
  800162:	ff 75 ec             	pushl  -0x14(%ebp)
  800165:	ff 75 e8             	pushl  -0x18(%ebp)
  800168:	e8 20 03 00 00       	call   80048d <InitializeSemiRandom>
  80016d:	83 c4 10             	add    $0x10,%esp
			break ;
  800170:	eb 11                	jmp    800183 <_main+0x14b>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800172:	83 ec 08             	sub    $0x8,%esp
  800175:	ff 75 ec             	pushl  -0x14(%ebp)
  800178:	ff 75 e8             	pushl  -0x18(%ebp)
  80017b:	e8 0d 03 00 00       	call   80048d <InitializeSemiRandom>
  800180:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  800183:	83 ec 08             	sub    $0x8,%esp
  800186:	ff 75 ec             	pushl  -0x14(%ebp)
  800189:	ff 75 e8             	pushl  -0x18(%ebp)
  80018c:	e8 db 00 00 00       	call   80026c <QuickSort>
  800191:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800194:	83 ec 08             	sub    $0x8,%esp
  800197:	ff 75 ec             	pushl  -0x14(%ebp)
  80019a:	ff 75 e8             	pushl  -0x18(%ebp)
  80019d:	e8 db 01 00 00       	call   80037d <CheckSorted>
  8001a2:	83 c4 10             	add    $0x10,%esp
  8001a5:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001a8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8001ac:	75 14                	jne    8001c2 <_main+0x18a>
  8001ae:	83 ec 04             	sub    $0x4,%esp
  8001b1:	68 f8 26 80 00       	push   $0x8026f8
  8001b6:	6a 42                	push   $0x42
  8001b8:	68 1a 27 80 00       	push   $0x80271a
  8001bd:	e8 82 05 00 00       	call   800744 <_panic>
		else
		{ 
			cprintf("\n===============================================\n") ;
  8001c2:	83 ec 0c             	sub    $0xc,%esp
  8001c5:	68 2c 27 80 00       	push   $0x80272c
  8001ca:	e8 17 08 00 00       	call   8009e6 <cprintf>
  8001cf:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001d2:	83 ec 0c             	sub    $0xc,%esp
  8001d5:	68 60 27 80 00       	push   $0x802760
  8001da:	e8 07 08 00 00       	call   8009e6 <cprintf>
  8001df:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  8001e2:	83 ec 0c             	sub    $0xc,%esp
  8001e5:	68 94 27 80 00       	push   $0x802794
  8001ea:	e8 f7 07 00 00       	call   8009e6 <cprintf>
  8001ef:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		cprintf("Freeing the Heap...\n\n") ;
  8001f2:	83 ec 0c             	sub    $0xc,%esp
  8001f5:	68 c6 27 80 00       	push   $0x8027c6
  8001fa:	e8 e7 07 00 00       	call   8009e6 <cprintf>
  8001ff:	83 c4 10             	add    $0x10,%esp
		free(Elements) ;
  800202:	83 ec 0c             	sub    $0xc,%esp
  800205:	ff 75 e8             	pushl  -0x18(%ebp)
  800208:	e8 31 1a 00 00       	call   801c3e <free>
  80020d:	83 c4 10             	add    $0x10,%esp


		///========================================================================
	sys_disable_interrupt();
  800210:	e8 cf 1d 00 00       	call   801fe4 <sys_disable_interrupt>
		cprintf("Do you want to repeat (y/n): ") ;
  800215:	83 ec 0c             	sub    $0xc,%esp
  800218:	68 dc 27 80 00       	push   $0x8027dc
  80021d:	e8 c4 07 00 00       	call   8009e6 <cprintf>
  800222:	83 c4 10             	add    $0x10,%esp

		Chose = getchar() ;
  800225:	e8 7d 03 00 00       	call   8005a7 <getchar>
  80022a:	88 45 e7             	mov    %al,-0x19(%ebp)
		cputchar(Chose);
  80022d:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  800231:	83 ec 0c             	sub    $0xc,%esp
  800234:	50                   	push   %eax
  800235:	e8 25 03 00 00       	call   80055f <cputchar>
  80023a:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  80023d:	83 ec 0c             	sub    $0xc,%esp
  800240:	6a 0a                	push   $0xa
  800242:	e8 18 03 00 00       	call   80055f <cputchar>
  800247:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  80024a:	83 ec 0c             	sub    $0xc,%esp
  80024d:	6a 0a                	push   $0xa
  80024f:	e8 0b 03 00 00       	call   80055f <cputchar>
  800254:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800257:	e8 a2 1d 00 00       	call   801ffe <sys_enable_interrupt>

	} while (Chose == 'y');
  80025c:	80 7d e7 79          	cmpb   $0x79,-0x19(%ebp)
  800260:	0f 84 e3 fd ff ff    	je     800049 <_main+0x11>

}
  800266:	90                   	nop
  800267:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80026a:	c9                   	leave  
  80026b:	c3                   	ret    

0080026c <QuickSort>:

///Quick sort 
void QuickSort(int *Elements, int NumOfElements)
{
  80026c:	55                   	push   %ebp
  80026d:	89 e5                	mov    %esp,%ebp
  80026f:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  800272:	8b 45 0c             	mov    0xc(%ebp),%eax
  800275:	48                   	dec    %eax
  800276:	50                   	push   %eax
  800277:	6a 00                	push   $0x0
  800279:	ff 75 0c             	pushl  0xc(%ebp)
  80027c:	ff 75 08             	pushl  0x8(%ebp)
  80027f:	e8 06 00 00 00       	call   80028a <QSort>
  800284:	83 c4 10             	add    $0x10,%esp
}
  800287:	90                   	nop
  800288:	c9                   	leave  
  800289:	c3                   	ret    

0080028a <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  80028a:	55                   	push   %ebp
  80028b:	89 e5                	mov    %esp,%ebp
  80028d:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  800290:	8b 45 10             	mov    0x10(%ebp),%eax
  800293:	3b 45 14             	cmp    0x14(%ebp),%eax
  800296:	0f 8d de 00 00 00    	jge    80037a <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  80029c:	8b 45 10             	mov    0x10(%ebp),%eax
  80029f:	40                   	inc    %eax
  8002a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8002a6:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002a9:	e9 80 00 00 00       	jmp    80032e <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8002ae:	ff 45 f4             	incl   -0xc(%ebp)
  8002b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002b4:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002b7:	7f 2b                	jg     8002e4 <QSort+0x5a>
  8002b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8002bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c6:	01 d0                	add    %edx,%eax
  8002c8:	8b 10                	mov    (%eax),%edx
  8002ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002cd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d7:	01 c8                	add    %ecx,%eax
  8002d9:	8b 00                	mov    (%eax),%eax
  8002db:	39 c2                	cmp    %eax,%edx
  8002dd:	7d cf                	jge    8002ae <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002df:	eb 03                	jmp    8002e4 <QSort+0x5a>
  8002e1:	ff 4d f0             	decl   -0x10(%ebp)
  8002e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002e7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002ea:	7e 26                	jle    800312 <QSort+0x88>
  8002ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8002ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f9:	01 d0                	add    %edx,%eax
  8002fb:	8b 10                	mov    (%eax),%edx
  8002fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800300:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800307:	8b 45 08             	mov    0x8(%ebp),%eax
  80030a:	01 c8                	add    %ecx,%eax
  80030c:	8b 00                	mov    (%eax),%eax
  80030e:	39 c2                	cmp    %eax,%edx
  800310:	7e cf                	jle    8002e1 <QSort+0x57>

		if (i <= j)
  800312:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800315:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800318:	7f 14                	jg     80032e <QSort+0xa4>
		{
			Swap(Elements, i, j);
  80031a:	83 ec 04             	sub    $0x4,%esp
  80031d:	ff 75 f0             	pushl  -0x10(%ebp)
  800320:	ff 75 f4             	pushl  -0xc(%ebp)
  800323:	ff 75 08             	pushl  0x8(%ebp)
  800326:	e8 a9 00 00 00       	call   8003d4 <Swap>
  80032b:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  80032e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800331:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800334:	0f 8e 77 ff ff ff    	jle    8002b1 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  80033a:	83 ec 04             	sub    $0x4,%esp
  80033d:	ff 75 f0             	pushl  -0x10(%ebp)
  800340:	ff 75 10             	pushl  0x10(%ebp)
  800343:	ff 75 08             	pushl  0x8(%ebp)
  800346:	e8 89 00 00 00       	call   8003d4 <Swap>
  80034b:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  80034e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800351:	48                   	dec    %eax
  800352:	50                   	push   %eax
  800353:	ff 75 10             	pushl  0x10(%ebp)
  800356:	ff 75 0c             	pushl  0xc(%ebp)
  800359:	ff 75 08             	pushl  0x8(%ebp)
  80035c:	e8 29 ff ff ff       	call   80028a <QSort>
  800361:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800364:	ff 75 14             	pushl  0x14(%ebp)
  800367:	ff 75 f4             	pushl  -0xc(%ebp)
  80036a:	ff 75 0c             	pushl  0xc(%ebp)
  80036d:	ff 75 08             	pushl  0x8(%ebp)
  800370:	e8 15 ff ff ff       	call   80028a <QSort>
  800375:	83 c4 10             	add    $0x10,%esp
  800378:	eb 01                	jmp    80037b <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  80037a:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  80037b:	c9                   	leave  
  80037c:	c3                   	ret    

0080037d <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  80037d:	55                   	push   %ebp
  80037e:	89 e5                	mov    %esp,%ebp
  800380:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  800383:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80038a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800391:	eb 33                	jmp    8003c6 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  800393:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800396:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80039d:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a0:	01 d0                	add    %edx,%eax
  8003a2:	8b 10                	mov    (%eax),%edx
  8003a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003a7:	40                   	inc    %eax
  8003a8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003af:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b2:	01 c8                	add    %ecx,%eax
  8003b4:	8b 00                	mov    (%eax),%eax
  8003b6:	39 c2                	cmp    %eax,%edx
  8003b8:	7e 09                	jle    8003c3 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8003c1:	eb 0c                	jmp    8003cf <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003c3:	ff 45 f8             	incl   -0x8(%ebp)
  8003c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c9:	48                   	dec    %eax
  8003ca:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8003cd:	7f c4                	jg     800393 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003d2:	c9                   	leave  
  8003d3:	c3                   	ret    

008003d4 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003d4:	55                   	push   %ebp
  8003d5:	89 e5                	mov    %esp,%ebp
  8003d7:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e7:	01 d0                	add    %edx,%eax
  8003e9:	8b 00                	mov    (%eax),%eax
  8003eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8003ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003f1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fb:	01 c2                	add    %eax,%edx
  8003fd:	8b 45 10             	mov    0x10(%ebp),%eax
  800400:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800407:	8b 45 08             	mov    0x8(%ebp),%eax
  80040a:	01 c8                	add    %ecx,%eax
  80040c:	8b 00                	mov    (%eax),%eax
  80040e:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800410:	8b 45 10             	mov    0x10(%ebp),%eax
  800413:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80041a:	8b 45 08             	mov    0x8(%ebp),%eax
  80041d:	01 c2                	add    %eax,%edx
  80041f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800422:	89 02                	mov    %eax,(%edx)
}
  800424:	90                   	nop
  800425:	c9                   	leave  
  800426:	c3                   	ret    

00800427 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800427:	55                   	push   %ebp
  800428:	89 e5                	mov    %esp,%ebp
  80042a:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80042d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800434:	eb 17                	jmp    80044d <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800436:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800439:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800440:	8b 45 08             	mov    0x8(%ebp),%eax
  800443:	01 c2                	add    %eax,%edx
  800445:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800448:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80044a:	ff 45 fc             	incl   -0x4(%ebp)
  80044d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800450:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800453:	7c e1                	jl     800436 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800455:	90                   	nop
  800456:	c9                   	leave  
  800457:	c3                   	ret    

00800458 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800458:	55                   	push   %ebp
  800459:	89 e5                	mov    %esp,%ebp
  80045b:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80045e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800465:	eb 1b                	jmp    800482 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800467:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80046a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800471:	8b 45 08             	mov    0x8(%ebp),%eax
  800474:	01 c2                	add    %eax,%edx
  800476:	8b 45 0c             	mov    0xc(%ebp),%eax
  800479:	2b 45 fc             	sub    -0x4(%ebp),%eax
  80047c:	48                   	dec    %eax
  80047d:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80047f:	ff 45 fc             	incl   -0x4(%ebp)
  800482:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800485:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800488:	7c dd                	jl     800467 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  80048a:	90                   	nop
  80048b:	c9                   	leave  
  80048c:	c3                   	ret    

0080048d <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  80048d:	55                   	push   %ebp
  80048e:	89 e5                	mov    %esp,%ebp
  800490:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  800493:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800496:	b8 56 55 55 55       	mov    $0x55555556,%eax
  80049b:	f7 e9                	imul   %ecx
  80049d:	c1 f9 1f             	sar    $0x1f,%ecx
  8004a0:	89 d0                	mov    %edx,%eax
  8004a2:	29 c8                	sub    %ecx,%eax
  8004a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004a7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004ae:	eb 1e                	jmp    8004ce <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8004b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004b3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8004bd:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8004c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004c3:	99                   	cltd   
  8004c4:	f7 7d f8             	idivl  -0x8(%ebp)
  8004c7:	89 d0                	mov    %edx,%eax
  8004c9:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004cb:	ff 45 fc             	incl   -0x4(%ebp)
  8004ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004d1:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004d4:	7c da                	jl     8004b0 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8004d6:	90                   	nop
  8004d7:	c9                   	leave  
  8004d8:	c3                   	ret    

008004d9 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004d9:	55                   	push   %ebp
  8004da:	89 e5                	mov    %esp,%ebp
  8004dc:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  8004df:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8004e6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004ed:	eb 42                	jmp    800531 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  8004ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004f2:	99                   	cltd   
  8004f3:	f7 7d f0             	idivl  -0x10(%ebp)
  8004f6:	89 d0                	mov    %edx,%eax
  8004f8:	85 c0                	test   %eax,%eax
  8004fa:	75 10                	jne    80050c <PrintElements+0x33>
			cprintf("\n");
  8004fc:	83 ec 0c             	sub    $0xc,%esp
  8004ff:	68 fa 27 80 00       	push   $0x8027fa
  800504:	e8 dd 04 00 00       	call   8009e6 <cprintf>
  800509:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  80050c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80050f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800516:	8b 45 08             	mov    0x8(%ebp),%eax
  800519:	01 d0                	add    %edx,%eax
  80051b:	8b 00                	mov    (%eax),%eax
  80051d:	83 ec 08             	sub    $0x8,%esp
  800520:	50                   	push   %eax
  800521:	68 fc 27 80 00       	push   $0x8027fc
  800526:	e8 bb 04 00 00       	call   8009e6 <cprintf>
  80052b:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80052e:	ff 45 f4             	incl   -0xc(%ebp)
  800531:	8b 45 0c             	mov    0xc(%ebp),%eax
  800534:	48                   	dec    %eax
  800535:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800538:	7f b5                	jg     8004ef <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80053a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80053d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800544:	8b 45 08             	mov    0x8(%ebp),%eax
  800547:	01 d0                	add    %edx,%eax
  800549:	8b 00                	mov    (%eax),%eax
  80054b:	83 ec 08             	sub    $0x8,%esp
  80054e:	50                   	push   %eax
  80054f:	68 01 28 80 00       	push   $0x802801
  800554:	e8 8d 04 00 00       	call   8009e6 <cprintf>
  800559:	83 c4 10             	add    $0x10,%esp

}
  80055c:	90                   	nop
  80055d:	c9                   	leave  
  80055e:	c3                   	ret    

0080055f <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80055f:	55                   	push   %ebp
  800560:	89 e5                	mov    %esp,%ebp
  800562:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800565:	8b 45 08             	mov    0x8(%ebp),%eax
  800568:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80056b:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80056f:	83 ec 0c             	sub    $0xc,%esp
  800572:	50                   	push   %eax
  800573:	e8 a0 1a 00 00       	call   802018 <sys_cputc>
  800578:	83 c4 10             	add    $0x10,%esp
}
  80057b:	90                   	nop
  80057c:	c9                   	leave  
  80057d:	c3                   	ret    

0080057e <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80057e:	55                   	push   %ebp
  80057f:	89 e5                	mov    %esp,%ebp
  800581:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800584:	e8 5b 1a 00 00       	call   801fe4 <sys_disable_interrupt>
	char c = ch;
  800589:	8b 45 08             	mov    0x8(%ebp),%eax
  80058c:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80058f:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800593:	83 ec 0c             	sub    $0xc,%esp
  800596:	50                   	push   %eax
  800597:	e8 7c 1a 00 00       	call   802018 <sys_cputc>
  80059c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80059f:	e8 5a 1a 00 00       	call   801ffe <sys_enable_interrupt>
}
  8005a4:	90                   	nop
  8005a5:	c9                   	leave  
  8005a6:	c3                   	ret    

008005a7 <getchar>:

int
getchar(void)
{
  8005a7:	55                   	push   %ebp
  8005a8:	89 e5                	mov    %esp,%ebp
  8005aa:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8005ad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005b4:	eb 08                	jmp    8005be <getchar+0x17>
	{
		c = sys_cgetc();
  8005b6:	e8 41 18 00 00       	call   801dfc <sys_cgetc>
  8005bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8005be:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005c2:	74 f2                	je     8005b6 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8005c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005c7:	c9                   	leave  
  8005c8:	c3                   	ret    

008005c9 <atomic_getchar>:

int
atomic_getchar(void)
{
  8005c9:	55                   	push   %ebp
  8005ca:	89 e5                	mov    %esp,%ebp
  8005cc:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005cf:	e8 10 1a 00 00       	call   801fe4 <sys_disable_interrupt>
	int c=0;
  8005d4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005db:	eb 08                	jmp    8005e5 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005dd:	e8 1a 18 00 00       	call   801dfc <sys_cgetc>
  8005e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8005e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005e9:	74 f2                	je     8005dd <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8005eb:	e8 0e 1a 00 00       	call   801ffe <sys_enable_interrupt>
	return c;
  8005f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005f3:	c9                   	leave  
  8005f4:	c3                   	ret    

008005f5 <iscons>:

int iscons(int fdnum)
{
  8005f5:	55                   	push   %ebp
  8005f6:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005f8:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8005fd:	5d                   	pop    %ebp
  8005fe:	c3                   	ret    

008005ff <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005ff:	55                   	push   %ebp
  800600:	89 e5                	mov    %esp,%ebp
  800602:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800605:	e8 3f 18 00 00       	call   801e49 <sys_getenvindex>
  80060a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80060d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800610:	89 d0                	mov    %edx,%eax
  800612:	c1 e0 03             	shl    $0x3,%eax
  800615:	01 d0                	add    %edx,%eax
  800617:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80061e:	01 c8                	add    %ecx,%eax
  800620:	01 c0                	add    %eax,%eax
  800622:	01 d0                	add    %edx,%eax
  800624:	01 c0                	add    %eax,%eax
  800626:	01 d0                	add    %edx,%eax
  800628:	89 c2                	mov    %eax,%edx
  80062a:	c1 e2 05             	shl    $0x5,%edx
  80062d:	29 c2                	sub    %eax,%edx
  80062f:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800636:	89 c2                	mov    %eax,%edx
  800638:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80063e:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800643:	a1 24 30 80 00       	mov    0x803024,%eax
  800648:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80064e:	84 c0                	test   %al,%al
  800650:	74 0f                	je     800661 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800652:	a1 24 30 80 00       	mov    0x803024,%eax
  800657:	05 40 3c 01 00       	add    $0x13c40,%eax
  80065c:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800661:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800665:	7e 0a                	jle    800671 <libmain+0x72>
		binaryname = argv[0];
  800667:	8b 45 0c             	mov    0xc(%ebp),%eax
  80066a:	8b 00                	mov    (%eax),%eax
  80066c:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800671:	83 ec 08             	sub    $0x8,%esp
  800674:	ff 75 0c             	pushl  0xc(%ebp)
  800677:	ff 75 08             	pushl  0x8(%ebp)
  80067a:	e8 b9 f9 ff ff       	call   800038 <_main>
  80067f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800682:	e8 5d 19 00 00       	call   801fe4 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800687:	83 ec 0c             	sub    $0xc,%esp
  80068a:	68 20 28 80 00       	push   $0x802820
  80068f:	e8 52 03 00 00       	call   8009e6 <cprintf>
  800694:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800697:	a1 24 30 80 00       	mov    0x803024,%eax
  80069c:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8006a2:	a1 24 30 80 00       	mov    0x803024,%eax
  8006a7:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8006ad:	83 ec 04             	sub    $0x4,%esp
  8006b0:	52                   	push   %edx
  8006b1:	50                   	push   %eax
  8006b2:	68 48 28 80 00       	push   $0x802848
  8006b7:	e8 2a 03 00 00       	call   8009e6 <cprintf>
  8006bc:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8006bf:	a1 24 30 80 00       	mov    0x803024,%eax
  8006c4:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8006ca:	a1 24 30 80 00       	mov    0x803024,%eax
  8006cf:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8006d5:	83 ec 04             	sub    $0x4,%esp
  8006d8:	52                   	push   %edx
  8006d9:	50                   	push   %eax
  8006da:	68 70 28 80 00       	push   $0x802870
  8006df:	e8 02 03 00 00       	call   8009e6 <cprintf>
  8006e4:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006e7:	a1 24 30 80 00       	mov    0x803024,%eax
  8006ec:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8006f2:	83 ec 08             	sub    $0x8,%esp
  8006f5:	50                   	push   %eax
  8006f6:	68 b1 28 80 00       	push   $0x8028b1
  8006fb:	e8 e6 02 00 00       	call   8009e6 <cprintf>
  800700:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800703:	83 ec 0c             	sub    $0xc,%esp
  800706:	68 20 28 80 00       	push   $0x802820
  80070b:	e8 d6 02 00 00       	call   8009e6 <cprintf>
  800710:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800713:	e8 e6 18 00 00       	call   801ffe <sys_enable_interrupt>

	// exit gracefully
	exit();
  800718:	e8 19 00 00 00       	call   800736 <exit>
}
  80071d:	90                   	nop
  80071e:	c9                   	leave  
  80071f:	c3                   	ret    

00800720 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800720:	55                   	push   %ebp
  800721:	89 e5                	mov    %esp,%ebp
  800723:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800726:	83 ec 0c             	sub    $0xc,%esp
  800729:	6a 00                	push   $0x0
  80072b:	e8 e5 16 00 00       	call   801e15 <sys_env_destroy>
  800730:	83 c4 10             	add    $0x10,%esp
}
  800733:	90                   	nop
  800734:	c9                   	leave  
  800735:	c3                   	ret    

00800736 <exit>:

void
exit(void)
{
  800736:	55                   	push   %ebp
  800737:	89 e5                	mov    %esp,%ebp
  800739:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80073c:	e8 3a 17 00 00       	call   801e7b <sys_env_exit>
}
  800741:	90                   	nop
  800742:	c9                   	leave  
  800743:	c3                   	ret    

00800744 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800744:	55                   	push   %ebp
  800745:	89 e5                	mov    %esp,%ebp
  800747:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80074a:	8d 45 10             	lea    0x10(%ebp),%eax
  80074d:	83 c0 04             	add    $0x4,%eax
  800750:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800753:	a1 18 31 80 00       	mov    0x803118,%eax
  800758:	85 c0                	test   %eax,%eax
  80075a:	74 16                	je     800772 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80075c:	a1 18 31 80 00       	mov    0x803118,%eax
  800761:	83 ec 08             	sub    $0x8,%esp
  800764:	50                   	push   %eax
  800765:	68 c8 28 80 00       	push   $0x8028c8
  80076a:	e8 77 02 00 00       	call   8009e6 <cprintf>
  80076f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800772:	a1 00 30 80 00       	mov    0x803000,%eax
  800777:	ff 75 0c             	pushl  0xc(%ebp)
  80077a:	ff 75 08             	pushl  0x8(%ebp)
  80077d:	50                   	push   %eax
  80077e:	68 cd 28 80 00       	push   $0x8028cd
  800783:	e8 5e 02 00 00       	call   8009e6 <cprintf>
  800788:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80078b:	8b 45 10             	mov    0x10(%ebp),%eax
  80078e:	83 ec 08             	sub    $0x8,%esp
  800791:	ff 75 f4             	pushl  -0xc(%ebp)
  800794:	50                   	push   %eax
  800795:	e8 e1 01 00 00       	call   80097b <vcprintf>
  80079a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80079d:	83 ec 08             	sub    $0x8,%esp
  8007a0:	6a 00                	push   $0x0
  8007a2:	68 e9 28 80 00       	push   $0x8028e9
  8007a7:	e8 cf 01 00 00       	call   80097b <vcprintf>
  8007ac:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8007af:	e8 82 ff ff ff       	call   800736 <exit>

	// should not return here
	while (1) ;
  8007b4:	eb fe                	jmp    8007b4 <_panic+0x70>

008007b6 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007b6:	55                   	push   %ebp
  8007b7:	89 e5                	mov    %esp,%ebp
  8007b9:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007bc:	a1 24 30 80 00       	mov    0x803024,%eax
  8007c1:	8b 50 74             	mov    0x74(%eax),%edx
  8007c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007c7:	39 c2                	cmp    %eax,%edx
  8007c9:	74 14                	je     8007df <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007cb:	83 ec 04             	sub    $0x4,%esp
  8007ce:	68 ec 28 80 00       	push   $0x8028ec
  8007d3:	6a 26                	push   $0x26
  8007d5:	68 38 29 80 00       	push   $0x802938
  8007da:	e8 65 ff ff ff       	call   800744 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007e6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007ed:	e9 b6 00 00 00       	jmp    8008a8 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8007f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007f5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ff:	01 d0                	add    %edx,%eax
  800801:	8b 00                	mov    (%eax),%eax
  800803:	85 c0                	test   %eax,%eax
  800805:	75 08                	jne    80080f <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800807:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80080a:	e9 96 00 00 00       	jmp    8008a5 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80080f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800816:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80081d:	eb 5d                	jmp    80087c <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80081f:	a1 24 30 80 00       	mov    0x803024,%eax
  800824:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80082a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80082d:	c1 e2 04             	shl    $0x4,%edx
  800830:	01 d0                	add    %edx,%eax
  800832:	8a 40 04             	mov    0x4(%eax),%al
  800835:	84 c0                	test   %al,%al
  800837:	75 40                	jne    800879 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800839:	a1 24 30 80 00       	mov    0x803024,%eax
  80083e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800844:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800847:	c1 e2 04             	shl    $0x4,%edx
  80084a:	01 d0                	add    %edx,%eax
  80084c:	8b 00                	mov    (%eax),%eax
  80084e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800851:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800854:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800859:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80085b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80085e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800865:	8b 45 08             	mov    0x8(%ebp),%eax
  800868:	01 c8                	add    %ecx,%eax
  80086a:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80086c:	39 c2                	cmp    %eax,%edx
  80086e:	75 09                	jne    800879 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800870:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800877:	eb 12                	jmp    80088b <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800879:	ff 45 e8             	incl   -0x18(%ebp)
  80087c:	a1 24 30 80 00       	mov    0x803024,%eax
  800881:	8b 50 74             	mov    0x74(%eax),%edx
  800884:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800887:	39 c2                	cmp    %eax,%edx
  800889:	77 94                	ja     80081f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80088b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80088f:	75 14                	jne    8008a5 <CheckWSWithoutLastIndex+0xef>
			panic(
  800891:	83 ec 04             	sub    $0x4,%esp
  800894:	68 44 29 80 00       	push   $0x802944
  800899:	6a 3a                	push   $0x3a
  80089b:	68 38 29 80 00       	push   $0x802938
  8008a0:	e8 9f fe ff ff       	call   800744 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8008a5:	ff 45 f0             	incl   -0x10(%ebp)
  8008a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008ab:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008ae:	0f 8c 3e ff ff ff    	jl     8007f2 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008b4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008bb:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008c2:	eb 20                	jmp    8008e4 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008c4:	a1 24 30 80 00       	mov    0x803024,%eax
  8008c9:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8008cf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008d2:	c1 e2 04             	shl    $0x4,%edx
  8008d5:	01 d0                	add    %edx,%eax
  8008d7:	8a 40 04             	mov    0x4(%eax),%al
  8008da:	3c 01                	cmp    $0x1,%al
  8008dc:	75 03                	jne    8008e1 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8008de:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008e1:	ff 45 e0             	incl   -0x20(%ebp)
  8008e4:	a1 24 30 80 00       	mov    0x803024,%eax
  8008e9:	8b 50 74             	mov    0x74(%eax),%edx
  8008ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008ef:	39 c2                	cmp    %eax,%edx
  8008f1:	77 d1                	ja     8008c4 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008f6:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008f9:	74 14                	je     80090f <CheckWSWithoutLastIndex+0x159>
		panic(
  8008fb:	83 ec 04             	sub    $0x4,%esp
  8008fe:	68 98 29 80 00       	push   $0x802998
  800903:	6a 44                	push   $0x44
  800905:	68 38 29 80 00       	push   $0x802938
  80090a:	e8 35 fe ff ff       	call   800744 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80090f:	90                   	nop
  800910:	c9                   	leave  
  800911:	c3                   	ret    

00800912 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800912:	55                   	push   %ebp
  800913:	89 e5                	mov    %esp,%ebp
  800915:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800918:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091b:	8b 00                	mov    (%eax),%eax
  80091d:	8d 48 01             	lea    0x1(%eax),%ecx
  800920:	8b 55 0c             	mov    0xc(%ebp),%edx
  800923:	89 0a                	mov    %ecx,(%edx)
  800925:	8b 55 08             	mov    0x8(%ebp),%edx
  800928:	88 d1                	mov    %dl,%cl
  80092a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80092d:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800931:	8b 45 0c             	mov    0xc(%ebp),%eax
  800934:	8b 00                	mov    (%eax),%eax
  800936:	3d ff 00 00 00       	cmp    $0xff,%eax
  80093b:	75 2c                	jne    800969 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80093d:	a0 28 30 80 00       	mov    0x803028,%al
  800942:	0f b6 c0             	movzbl %al,%eax
  800945:	8b 55 0c             	mov    0xc(%ebp),%edx
  800948:	8b 12                	mov    (%edx),%edx
  80094a:	89 d1                	mov    %edx,%ecx
  80094c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80094f:	83 c2 08             	add    $0x8,%edx
  800952:	83 ec 04             	sub    $0x4,%esp
  800955:	50                   	push   %eax
  800956:	51                   	push   %ecx
  800957:	52                   	push   %edx
  800958:	e8 76 14 00 00       	call   801dd3 <sys_cputs>
  80095d:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800960:	8b 45 0c             	mov    0xc(%ebp),%eax
  800963:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800969:	8b 45 0c             	mov    0xc(%ebp),%eax
  80096c:	8b 40 04             	mov    0x4(%eax),%eax
  80096f:	8d 50 01             	lea    0x1(%eax),%edx
  800972:	8b 45 0c             	mov    0xc(%ebp),%eax
  800975:	89 50 04             	mov    %edx,0x4(%eax)
}
  800978:	90                   	nop
  800979:	c9                   	leave  
  80097a:	c3                   	ret    

0080097b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80097b:	55                   	push   %ebp
  80097c:	89 e5                	mov    %esp,%ebp
  80097e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800984:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80098b:	00 00 00 
	b.cnt = 0;
  80098e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800995:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800998:	ff 75 0c             	pushl  0xc(%ebp)
  80099b:	ff 75 08             	pushl  0x8(%ebp)
  80099e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009a4:	50                   	push   %eax
  8009a5:	68 12 09 80 00       	push   $0x800912
  8009aa:	e8 11 02 00 00       	call   800bc0 <vprintfmt>
  8009af:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009b2:	a0 28 30 80 00       	mov    0x803028,%al
  8009b7:	0f b6 c0             	movzbl %al,%eax
  8009ba:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009c0:	83 ec 04             	sub    $0x4,%esp
  8009c3:	50                   	push   %eax
  8009c4:	52                   	push   %edx
  8009c5:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009cb:	83 c0 08             	add    $0x8,%eax
  8009ce:	50                   	push   %eax
  8009cf:	e8 ff 13 00 00       	call   801dd3 <sys_cputs>
  8009d4:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009d7:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  8009de:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009e4:	c9                   	leave  
  8009e5:	c3                   	ret    

008009e6 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009e6:	55                   	push   %ebp
  8009e7:	89 e5                	mov    %esp,%ebp
  8009e9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009ec:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  8009f3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fc:	83 ec 08             	sub    $0x8,%esp
  8009ff:	ff 75 f4             	pushl  -0xc(%ebp)
  800a02:	50                   	push   %eax
  800a03:	e8 73 ff ff ff       	call   80097b <vcprintf>
  800a08:	83 c4 10             	add    $0x10,%esp
  800a0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a11:	c9                   	leave  
  800a12:	c3                   	ret    

00800a13 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a13:	55                   	push   %ebp
  800a14:	89 e5                	mov    %esp,%ebp
  800a16:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a19:	e8 c6 15 00 00       	call   801fe4 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a1e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a21:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a24:	8b 45 08             	mov    0x8(%ebp),%eax
  800a27:	83 ec 08             	sub    $0x8,%esp
  800a2a:	ff 75 f4             	pushl  -0xc(%ebp)
  800a2d:	50                   	push   %eax
  800a2e:	e8 48 ff ff ff       	call   80097b <vcprintf>
  800a33:	83 c4 10             	add    $0x10,%esp
  800a36:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a39:	e8 c0 15 00 00       	call   801ffe <sys_enable_interrupt>
	return cnt;
  800a3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a41:	c9                   	leave  
  800a42:	c3                   	ret    

00800a43 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a43:	55                   	push   %ebp
  800a44:	89 e5                	mov    %esp,%ebp
  800a46:	53                   	push   %ebx
  800a47:	83 ec 14             	sub    $0x14,%esp
  800a4a:	8b 45 10             	mov    0x10(%ebp),%eax
  800a4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a50:	8b 45 14             	mov    0x14(%ebp),%eax
  800a53:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a56:	8b 45 18             	mov    0x18(%ebp),%eax
  800a59:	ba 00 00 00 00       	mov    $0x0,%edx
  800a5e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a61:	77 55                	ja     800ab8 <printnum+0x75>
  800a63:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a66:	72 05                	jb     800a6d <printnum+0x2a>
  800a68:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a6b:	77 4b                	ja     800ab8 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a6d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a70:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a73:	8b 45 18             	mov    0x18(%ebp),%eax
  800a76:	ba 00 00 00 00       	mov    $0x0,%edx
  800a7b:	52                   	push   %edx
  800a7c:	50                   	push   %eax
  800a7d:	ff 75 f4             	pushl  -0xc(%ebp)
  800a80:	ff 75 f0             	pushl  -0x10(%ebp)
  800a83:	e8 80 19 00 00       	call   802408 <__udivdi3>
  800a88:	83 c4 10             	add    $0x10,%esp
  800a8b:	83 ec 04             	sub    $0x4,%esp
  800a8e:	ff 75 20             	pushl  0x20(%ebp)
  800a91:	53                   	push   %ebx
  800a92:	ff 75 18             	pushl  0x18(%ebp)
  800a95:	52                   	push   %edx
  800a96:	50                   	push   %eax
  800a97:	ff 75 0c             	pushl  0xc(%ebp)
  800a9a:	ff 75 08             	pushl  0x8(%ebp)
  800a9d:	e8 a1 ff ff ff       	call   800a43 <printnum>
  800aa2:	83 c4 20             	add    $0x20,%esp
  800aa5:	eb 1a                	jmp    800ac1 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800aa7:	83 ec 08             	sub    $0x8,%esp
  800aaa:	ff 75 0c             	pushl  0xc(%ebp)
  800aad:	ff 75 20             	pushl  0x20(%ebp)
  800ab0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab3:	ff d0                	call   *%eax
  800ab5:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800ab8:	ff 4d 1c             	decl   0x1c(%ebp)
  800abb:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800abf:	7f e6                	jg     800aa7 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800ac1:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800ac4:	bb 00 00 00 00       	mov    $0x0,%ebx
  800ac9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800acc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800acf:	53                   	push   %ebx
  800ad0:	51                   	push   %ecx
  800ad1:	52                   	push   %edx
  800ad2:	50                   	push   %eax
  800ad3:	e8 40 1a 00 00       	call   802518 <__umoddi3>
  800ad8:	83 c4 10             	add    $0x10,%esp
  800adb:	05 14 2c 80 00       	add    $0x802c14,%eax
  800ae0:	8a 00                	mov    (%eax),%al
  800ae2:	0f be c0             	movsbl %al,%eax
  800ae5:	83 ec 08             	sub    $0x8,%esp
  800ae8:	ff 75 0c             	pushl  0xc(%ebp)
  800aeb:	50                   	push   %eax
  800aec:	8b 45 08             	mov    0x8(%ebp),%eax
  800aef:	ff d0                	call   *%eax
  800af1:	83 c4 10             	add    $0x10,%esp
}
  800af4:	90                   	nop
  800af5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800af8:	c9                   	leave  
  800af9:	c3                   	ret    

00800afa <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800afa:	55                   	push   %ebp
  800afb:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800afd:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b01:	7e 1c                	jle    800b1f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b03:	8b 45 08             	mov    0x8(%ebp),%eax
  800b06:	8b 00                	mov    (%eax),%eax
  800b08:	8d 50 08             	lea    0x8(%eax),%edx
  800b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0e:	89 10                	mov    %edx,(%eax)
  800b10:	8b 45 08             	mov    0x8(%ebp),%eax
  800b13:	8b 00                	mov    (%eax),%eax
  800b15:	83 e8 08             	sub    $0x8,%eax
  800b18:	8b 50 04             	mov    0x4(%eax),%edx
  800b1b:	8b 00                	mov    (%eax),%eax
  800b1d:	eb 40                	jmp    800b5f <getuint+0x65>
	else if (lflag)
  800b1f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b23:	74 1e                	je     800b43 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b25:	8b 45 08             	mov    0x8(%ebp),%eax
  800b28:	8b 00                	mov    (%eax),%eax
  800b2a:	8d 50 04             	lea    0x4(%eax),%edx
  800b2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b30:	89 10                	mov    %edx,(%eax)
  800b32:	8b 45 08             	mov    0x8(%ebp),%eax
  800b35:	8b 00                	mov    (%eax),%eax
  800b37:	83 e8 04             	sub    $0x4,%eax
  800b3a:	8b 00                	mov    (%eax),%eax
  800b3c:	ba 00 00 00 00       	mov    $0x0,%edx
  800b41:	eb 1c                	jmp    800b5f <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b43:	8b 45 08             	mov    0x8(%ebp),%eax
  800b46:	8b 00                	mov    (%eax),%eax
  800b48:	8d 50 04             	lea    0x4(%eax),%edx
  800b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4e:	89 10                	mov    %edx,(%eax)
  800b50:	8b 45 08             	mov    0x8(%ebp),%eax
  800b53:	8b 00                	mov    (%eax),%eax
  800b55:	83 e8 04             	sub    $0x4,%eax
  800b58:	8b 00                	mov    (%eax),%eax
  800b5a:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b5f:	5d                   	pop    %ebp
  800b60:	c3                   	ret    

00800b61 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b61:	55                   	push   %ebp
  800b62:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b64:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b68:	7e 1c                	jle    800b86 <getint+0x25>
		return va_arg(*ap, long long);
  800b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6d:	8b 00                	mov    (%eax),%eax
  800b6f:	8d 50 08             	lea    0x8(%eax),%edx
  800b72:	8b 45 08             	mov    0x8(%ebp),%eax
  800b75:	89 10                	mov    %edx,(%eax)
  800b77:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7a:	8b 00                	mov    (%eax),%eax
  800b7c:	83 e8 08             	sub    $0x8,%eax
  800b7f:	8b 50 04             	mov    0x4(%eax),%edx
  800b82:	8b 00                	mov    (%eax),%eax
  800b84:	eb 38                	jmp    800bbe <getint+0x5d>
	else if (lflag)
  800b86:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b8a:	74 1a                	je     800ba6 <getint+0x45>
		return va_arg(*ap, long);
  800b8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8f:	8b 00                	mov    (%eax),%eax
  800b91:	8d 50 04             	lea    0x4(%eax),%edx
  800b94:	8b 45 08             	mov    0x8(%ebp),%eax
  800b97:	89 10                	mov    %edx,(%eax)
  800b99:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9c:	8b 00                	mov    (%eax),%eax
  800b9e:	83 e8 04             	sub    $0x4,%eax
  800ba1:	8b 00                	mov    (%eax),%eax
  800ba3:	99                   	cltd   
  800ba4:	eb 18                	jmp    800bbe <getint+0x5d>
	else
		return va_arg(*ap, int);
  800ba6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba9:	8b 00                	mov    (%eax),%eax
  800bab:	8d 50 04             	lea    0x4(%eax),%edx
  800bae:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb1:	89 10                	mov    %edx,(%eax)
  800bb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb6:	8b 00                	mov    (%eax),%eax
  800bb8:	83 e8 04             	sub    $0x4,%eax
  800bbb:	8b 00                	mov    (%eax),%eax
  800bbd:	99                   	cltd   
}
  800bbe:	5d                   	pop    %ebp
  800bbf:	c3                   	ret    

00800bc0 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bc0:	55                   	push   %ebp
  800bc1:	89 e5                	mov    %esp,%ebp
  800bc3:	56                   	push   %esi
  800bc4:	53                   	push   %ebx
  800bc5:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bc8:	eb 17                	jmp    800be1 <vprintfmt+0x21>
			if (ch == '\0')
  800bca:	85 db                	test   %ebx,%ebx
  800bcc:	0f 84 af 03 00 00    	je     800f81 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bd2:	83 ec 08             	sub    $0x8,%esp
  800bd5:	ff 75 0c             	pushl  0xc(%ebp)
  800bd8:	53                   	push   %ebx
  800bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdc:	ff d0                	call   *%eax
  800bde:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800be1:	8b 45 10             	mov    0x10(%ebp),%eax
  800be4:	8d 50 01             	lea    0x1(%eax),%edx
  800be7:	89 55 10             	mov    %edx,0x10(%ebp)
  800bea:	8a 00                	mov    (%eax),%al
  800bec:	0f b6 d8             	movzbl %al,%ebx
  800bef:	83 fb 25             	cmp    $0x25,%ebx
  800bf2:	75 d6                	jne    800bca <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bf4:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bf8:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bff:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c06:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c0d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c14:	8b 45 10             	mov    0x10(%ebp),%eax
  800c17:	8d 50 01             	lea    0x1(%eax),%edx
  800c1a:	89 55 10             	mov    %edx,0x10(%ebp)
  800c1d:	8a 00                	mov    (%eax),%al
  800c1f:	0f b6 d8             	movzbl %al,%ebx
  800c22:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c25:	83 f8 55             	cmp    $0x55,%eax
  800c28:	0f 87 2b 03 00 00    	ja     800f59 <vprintfmt+0x399>
  800c2e:	8b 04 85 38 2c 80 00 	mov    0x802c38(,%eax,4),%eax
  800c35:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c37:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c3b:	eb d7                	jmp    800c14 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c3d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c41:	eb d1                	jmp    800c14 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c43:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c4a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c4d:	89 d0                	mov    %edx,%eax
  800c4f:	c1 e0 02             	shl    $0x2,%eax
  800c52:	01 d0                	add    %edx,%eax
  800c54:	01 c0                	add    %eax,%eax
  800c56:	01 d8                	add    %ebx,%eax
  800c58:	83 e8 30             	sub    $0x30,%eax
  800c5b:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c5e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c61:	8a 00                	mov    (%eax),%al
  800c63:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c66:	83 fb 2f             	cmp    $0x2f,%ebx
  800c69:	7e 3e                	jle    800ca9 <vprintfmt+0xe9>
  800c6b:	83 fb 39             	cmp    $0x39,%ebx
  800c6e:	7f 39                	jg     800ca9 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c70:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c73:	eb d5                	jmp    800c4a <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c75:	8b 45 14             	mov    0x14(%ebp),%eax
  800c78:	83 c0 04             	add    $0x4,%eax
  800c7b:	89 45 14             	mov    %eax,0x14(%ebp)
  800c7e:	8b 45 14             	mov    0x14(%ebp),%eax
  800c81:	83 e8 04             	sub    $0x4,%eax
  800c84:	8b 00                	mov    (%eax),%eax
  800c86:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c89:	eb 1f                	jmp    800caa <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c8b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c8f:	79 83                	jns    800c14 <vprintfmt+0x54>
				width = 0;
  800c91:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c98:	e9 77 ff ff ff       	jmp    800c14 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c9d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800ca4:	e9 6b ff ff ff       	jmp    800c14 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800ca9:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800caa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cae:	0f 89 60 ff ff ff    	jns    800c14 <vprintfmt+0x54>
				width = precision, precision = -1;
  800cb4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cb7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800cba:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800cc1:	e9 4e ff ff ff       	jmp    800c14 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800cc6:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800cc9:	e9 46 ff ff ff       	jmp    800c14 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cce:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd1:	83 c0 04             	add    $0x4,%eax
  800cd4:	89 45 14             	mov    %eax,0x14(%ebp)
  800cd7:	8b 45 14             	mov    0x14(%ebp),%eax
  800cda:	83 e8 04             	sub    $0x4,%eax
  800cdd:	8b 00                	mov    (%eax),%eax
  800cdf:	83 ec 08             	sub    $0x8,%esp
  800ce2:	ff 75 0c             	pushl  0xc(%ebp)
  800ce5:	50                   	push   %eax
  800ce6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce9:	ff d0                	call   *%eax
  800ceb:	83 c4 10             	add    $0x10,%esp
			break;
  800cee:	e9 89 02 00 00       	jmp    800f7c <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cf3:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf6:	83 c0 04             	add    $0x4,%eax
  800cf9:	89 45 14             	mov    %eax,0x14(%ebp)
  800cfc:	8b 45 14             	mov    0x14(%ebp),%eax
  800cff:	83 e8 04             	sub    $0x4,%eax
  800d02:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d04:	85 db                	test   %ebx,%ebx
  800d06:	79 02                	jns    800d0a <vprintfmt+0x14a>
				err = -err;
  800d08:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d0a:	83 fb 64             	cmp    $0x64,%ebx
  800d0d:	7f 0b                	jg     800d1a <vprintfmt+0x15a>
  800d0f:	8b 34 9d 80 2a 80 00 	mov    0x802a80(,%ebx,4),%esi
  800d16:	85 f6                	test   %esi,%esi
  800d18:	75 19                	jne    800d33 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d1a:	53                   	push   %ebx
  800d1b:	68 25 2c 80 00       	push   $0x802c25
  800d20:	ff 75 0c             	pushl  0xc(%ebp)
  800d23:	ff 75 08             	pushl  0x8(%ebp)
  800d26:	e8 5e 02 00 00       	call   800f89 <printfmt>
  800d2b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d2e:	e9 49 02 00 00       	jmp    800f7c <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d33:	56                   	push   %esi
  800d34:	68 2e 2c 80 00       	push   $0x802c2e
  800d39:	ff 75 0c             	pushl  0xc(%ebp)
  800d3c:	ff 75 08             	pushl  0x8(%ebp)
  800d3f:	e8 45 02 00 00       	call   800f89 <printfmt>
  800d44:	83 c4 10             	add    $0x10,%esp
			break;
  800d47:	e9 30 02 00 00       	jmp    800f7c <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d4c:	8b 45 14             	mov    0x14(%ebp),%eax
  800d4f:	83 c0 04             	add    $0x4,%eax
  800d52:	89 45 14             	mov    %eax,0x14(%ebp)
  800d55:	8b 45 14             	mov    0x14(%ebp),%eax
  800d58:	83 e8 04             	sub    $0x4,%eax
  800d5b:	8b 30                	mov    (%eax),%esi
  800d5d:	85 f6                	test   %esi,%esi
  800d5f:	75 05                	jne    800d66 <vprintfmt+0x1a6>
				p = "(null)";
  800d61:	be 31 2c 80 00       	mov    $0x802c31,%esi
			if (width > 0 && padc != '-')
  800d66:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d6a:	7e 6d                	jle    800dd9 <vprintfmt+0x219>
  800d6c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d70:	74 67                	je     800dd9 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d72:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d75:	83 ec 08             	sub    $0x8,%esp
  800d78:	50                   	push   %eax
  800d79:	56                   	push   %esi
  800d7a:	e8 12 05 00 00       	call   801291 <strnlen>
  800d7f:	83 c4 10             	add    $0x10,%esp
  800d82:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d85:	eb 16                	jmp    800d9d <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d87:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d8b:	83 ec 08             	sub    $0x8,%esp
  800d8e:	ff 75 0c             	pushl  0xc(%ebp)
  800d91:	50                   	push   %eax
  800d92:	8b 45 08             	mov    0x8(%ebp),%eax
  800d95:	ff d0                	call   *%eax
  800d97:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d9a:	ff 4d e4             	decl   -0x1c(%ebp)
  800d9d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800da1:	7f e4                	jg     800d87 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800da3:	eb 34                	jmp    800dd9 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800da5:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800da9:	74 1c                	je     800dc7 <vprintfmt+0x207>
  800dab:	83 fb 1f             	cmp    $0x1f,%ebx
  800dae:	7e 05                	jle    800db5 <vprintfmt+0x1f5>
  800db0:	83 fb 7e             	cmp    $0x7e,%ebx
  800db3:	7e 12                	jle    800dc7 <vprintfmt+0x207>
					putch('?', putdat);
  800db5:	83 ec 08             	sub    $0x8,%esp
  800db8:	ff 75 0c             	pushl  0xc(%ebp)
  800dbb:	6a 3f                	push   $0x3f
  800dbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc0:	ff d0                	call   *%eax
  800dc2:	83 c4 10             	add    $0x10,%esp
  800dc5:	eb 0f                	jmp    800dd6 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800dc7:	83 ec 08             	sub    $0x8,%esp
  800dca:	ff 75 0c             	pushl  0xc(%ebp)
  800dcd:	53                   	push   %ebx
  800dce:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd1:	ff d0                	call   *%eax
  800dd3:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dd6:	ff 4d e4             	decl   -0x1c(%ebp)
  800dd9:	89 f0                	mov    %esi,%eax
  800ddb:	8d 70 01             	lea    0x1(%eax),%esi
  800dde:	8a 00                	mov    (%eax),%al
  800de0:	0f be d8             	movsbl %al,%ebx
  800de3:	85 db                	test   %ebx,%ebx
  800de5:	74 24                	je     800e0b <vprintfmt+0x24b>
  800de7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800deb:	78 b8                	js     800da5 <vprintfmt+0x1e5>
  800ded:	ff 4d e0             	decl   -0x20(%ebp)
  800df0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800df4:	79 af                	jns    800da5 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800df6:	eb 13                	jmp    800e0b <vprintfmt+0x24b>
				putch(' ', putdat);
  800df8:	83 ec 08             	sub    $0x8,%esp
  800dfb:	ff 75 0c             	pushl  0xc(%ebp)
  800dfe:	6a 20                	push   $0x20
  800e00:	8b 45 08             	mov    0x8(%ebp),%eax
  800e03:	ff d0                	call   *%eax
  800e05:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e08:	ff 4d e4             	decl   -0x1c(%ebp)
  800e0b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e0f:	7f e7                	jg     800df8 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e11:	e9 66 01 00 00       	jmp    800f7c <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e16:	83 ec 08             	sub    $0x8,%esp
  800e19:	ff 75 e8             	pushl  -0x18(%ebp)
  800e1c:	8d 45 14             	lea    0x14(%ebp),%eax
  800e1f:	50                   	push   %eax
  800e20:	e8 3c fd ff ff       	call   800b61 <getint>
  800e25:	83 c4 10             	add    $0x10,%esp
  800e28:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e2b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e31:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e34:	85 d2                	test   %edx,%edx
  800e36:	79 23                	jns    800e5b <vprintfmt+0x29b>
				putch('-', putdat);
  800e38:	83 ec 08             	sub    $0x8,%esp
  800e3b:	ff 75 0c             	pushl  0xc(%ebp)
  800e3e:	6a 2d                	push   $0x2d
  800e40:	8b 45 08             	mov    0x8(%ebp),%eax
  800e43:	ff d0                	call   *%eax
  800e45:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e48:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e4b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e4e:	f7 d8                	neg    %eax
  800e50:	83 d2 00             	adc    $0x0,%edx
  800e53:	f7 da                	neg    %edx
  800e55:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e58:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e5b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e62:	e9 bc 00 00 00       	jmp    800f23 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e67:	83 ec 08             	sub    $0x8,%esp
  800e6a:	ff 75 e8             	pushl  -0x18(%ebp)
  800e6d:	8d 45 14             	lea    0x14(%ebp),%eax
  800e70:	50                   	push   %eax
  800e71:	e8 84 fc ff ff       	call   800afa <getuint>
  800e76:	83 c4 10             	add    $0x10,%esp
  800e79:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e7c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e7f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e86:	e9 98 00 00 00       	jmp    800f23 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e8b:	83 ec 08             	sub    $0x8,%esp
  800e8e:	ff 75 0c             	pushl  0xc(%ebp)
  800e91:	6a 58                	push   $0x58
  800e93:	8b 45 08             	mov    0x8(%ebp),%eax
  800e96:	ff d0                	call   *%eax
  800e98:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e9b:	83 ec 08             	sub    $0x8,%esp
  800e9e:	ff 75 0c             	pushl  0xc(%ebp)
  800ea1:	6a 58                	push   $0x58
  800ea3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea6:	ff d0                	call   *%eax
  800ea8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800eab:	83 ec 08             	sub    $0x8,%esp
  800eae:	ff 75 0c             	pushl  0xc(%ebp)
  800eb1:	6a 58                	push   $0x58
  800eb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb6:	ff d0                	call   *%eax
  800eb8:	83 c4 10             	add    $0x10,%esp
			break;
  800ebb:	e9 bc 00 00 00       	jmp    800f7c <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ec0:	83 ec 08             	sub    $0x8,%esp
  800ec3:	ff 75 0c             	pushl  0xc(%ebp)
  800ec6:	6a 30                	push   $0x30
  800ec8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecb:	ff d0                	call   *%eax
  800ecd:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ed0:	83 ec 08             	sub    $0x8,%esp
  800ed3:	ff 75 0c             	pushl  0xc(%ebp)
  800ed6:	6a 78                	push   $0x78
  800ed8:	8b 45 08             	mov    0x8(%ebp),%eax
  800edb:	ff d0                	call   *%eax
  800edd:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ee0:	8b 45 14             	mov    0x14(%ebp),%eax
  800ee3:	83 c0 04             	add    $0x4,%eax
  800ee6:	89 45 14             	mov    %eax,0x14(%ebp)
  800ee9:	8b 45 14             	mov    0x14(%ebp),%eax
  800eec:	83 e8 04             	sub    $0x4,%eax
  800eef:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ef1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ef4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800efb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f02:	eb 1f                	jmp    800f23 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f04:	83 ec 08             	sub    $0x8,%esp
  800f07:	ff 75 e8             	pushl  -0x18(%ebp)
  800f0a:	8d 45 14             	lea    0x14(%ebp),%eax
  800f0d:	50                   	push   %eax
  800f0e:	e8 e7 fb ff ff       	call   800afa <getuint>
  800f13:	83 c4 10             	add    $0x10,%esp
  800f16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f19:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f1c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f23:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f27:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f2a:	83 ec 04             	sub    $0x4,%esp
  800f2d:	52                   	push   %edx
  800f2e:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f31:	50                   	push   %eax
  800f32:	ff 75 f4             	pushl  -0xc(%ebp)
  800f35:	ff 75 f0             	pushl  -0x10(%ebp)
  800f38:	ff 75 0c             	pushl  0xc(%ebp)
  800f3b:	ff 75 08             	pushl  0x8(%ebp)
  800f3e:	e8 00 fb ff ff       	call   800a43 <printnum>
  800f43:	83 c4 20             	add    $0x20,%esp
			break;
  800f46:	eb 34                	jmp    800f7c <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f48:	83 ec 08             	sub    $0x8,%esp
  800f4b:	ff 75 0c             	pushl  0xc(%ebp)
  800f4e:	53                   	push   %ebx
  800f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f52:	ff d0                	call   *%eax
  800f54:	83 c4 10             	add    $0x10,%esp
			break;
  800f57:	eb 23                	jmp    800f7c <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f59:	83 ec 08             	sub    $0x8,%esp
  800f5c:	ff 75 0c             	pushl  0xc(%ebp)
  800f5f:	6a 25                	push   $0x25
  800f61:	8b 45 08             	mov    0x8(%ebp),%eax
  800f64:	ff d0                	call   *%eax
  800f66:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f69:	ff 4d 10             	decl   0x10(%ebp)
  800f6c:	eb 03                	jmp    800f71 <vprintfmt+0x3b1>
  800f6e:	ff 4d 10             	decl   0x10(%ebp)
  800f71:	8b 45 10             	mov    0x10(%ebp),%eax
  800f74:	48                   	dec    %eax
  800f75:	8a 00                	mov    (%eax),%al
  800f77:	3c 25                	cmp    $0x25,%al
  800f79:	75 f3                	jne    800f6e <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f7b:	90                   	nop
		}
	}
  800f7c:	e9 47 fc ff ff       	jmp    800bc8 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f81:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f82:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f85:	5b                   	pop    %ebx
  800f86:	5e                   	pop    %esi
  800f87:	5d                   	pop    %ebp
  800f88:	c3                   	ret    

00800f89 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f89:	55                   	push   %ebp
  800f8a:	89 e5                	mov    %esp,%ebp
  800f8c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f8f:	8d 45 10             	lea    0x10(%ebp),%eax
  800f92:	83 c0 04             	add    $0x4,%eax
  800f95:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f98:	8b 45 10             	mov    0x10(%ebp),%eax
  800f9b:	ff 75 f4             	pushl  -0xc(%ebp)
  800f9e:	50                   	push   %eax
  800f9f:	ff 75 0c             	pushl  0xc(%ebp)
  800fa2:	ff 75 08             	pushl  0x8(%ebp)
  800fa5:	e8 16 fc ff ff       	call   800bc0 <vprintfmt>
  800faa:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800fad:	90                   	nop
  800fae:	c9                   	leave  
  800faf:	c3                   	ret    

00800fb0 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800fb0:	55                   	push   %ebp
  800fb1:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fb3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb6:	8b 40 08             	mov    0x8(%eax),%eax
  800fb9:	8d 50 01             	lea    0x1(%eax),%edx
  800fbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbf:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800fc2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc5:	8b 10                	mov    (%eax),%edx
  800fc7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fca:	8b 40 04             	mov    0x4(%eax),%eax
  800fcd:	39 c2                	cmp    %eax,%edx
  800fcf:	73 12                	jae    800fe3 <sprintputch+0x33>
		*b->buf++ = ch;
  800fd1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd4:	8b 00                	mov    (%eax),%eax
  800fd6:	8d 48 01             	lea    0x1(%eax),%ecx
  800fd9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fdc:	89 0a                	mov    %ecx,(%edx)
  800fde:	8b 55 08             	mov    0x8(%ebp),%edx
  800fe1:	88 10                	mov    %dl,(%eax)
}
  800fe3:	90                   	nop
  800fe4:	5d                   	pop    %ebp
  800fe5:	c3                   	ret    

00800fe6 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fe6:	55                   	push   %ebp
  800fe7:	89 e5                	mov    %esp,%ebp
  800fe9:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fec:	8b 45 08             	mov    0x8(%ebp),%eax
  800fef:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800ff2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ff8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffb:	01 d0                	add    %edx,%eax
  800ffd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801000:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801007:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80100b:	74 06                	je     801013 <vsnprintf+0x2d>
  80100d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801011:	7f 07                	jg     80101a <vsnprintf+0x34>
		return -E_INVAL;
  801013:	b8 03 00 00 00       	mov    $0x3,%eax
  801018:	eb 20                	jmp    80103a <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80101a:	ff 75 14             	pushl  0x14(%ebp)
  80101d:	ff 75 10             	pushl  0x10(%ebp)
  801020:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801023:	50                   	push   %eax
  801024:	68 b0 0f 80 00       	push   $0x800fb0
  801029:	e8 92 fb ff ff       	call   800bc0 <vprintfmt>
  80102e:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801031:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801034:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801037:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80103a:	c9                   	leave  
  80103b:	c3                   	ret    

0080103c <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80103c:	55                   	push   %ebp
  80103d:	89 e5                	mov    %esp,%ebp
  80103f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801042:	8d 45 10             	lea    0x10(%ebp),%eax
  801045:	83 c0 04             	add    $0x4,%eax
  801048:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80104b:	8b 45 10             	mov    0x10(%ebp),%eax
  80104e:	ff 75 f4             	pushl  -0xc(%ebp)
  801051:	50                   	push   %eax
  801052:	ff 75 0c             	pushl  0xc(%ebp)
  801055:	ff 75 08             	pushl  0x8(%ebp)
  801058:	e8 89 ff ff ff       	call   800fe6 <vsnprintf>
  80105d:	83 c4 10             	add    $0x10,%esp
  801060:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801063:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801066:	c9                   	leave  
  801067:	c3                   	ret    

00801068 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801068:	55                   	push   %ebp
  801069:	89 e5                	mov    %esp,%ebp
  80106b:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80106e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801072:	74 13                	je     801087 <readline+0x1f>
		cprintf("%s", prompt);
  801074:	83 ec 08             	sub    $0x8,%esp
  801077:	ff 75 08             	pushl  0x8(%ebp)
  80107a:	68 90 2d 80 00       	push   $0x802d90
  80107f:	e8 62 f9 ff ff       	call   8009e6 <cprintf>
  801084:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801087:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80108e:	83 ec 0c             	sub    $0xc,%esp
  801091:	6a 00                	push   $0x0
  801093:	e8 5d f5 ff ff       	call   8005f5 <iscons>
  801098:	83 c4 10             	add    $0x10,%esp
  80109b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80109e:	e8 04 f5 ff ff       	call   8005a7 <getchar>
  8010a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8010a6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8010aa:	79 22                	jns    8010ce <readline+0x66>
			if (c != -E_EOF)
  8010ac:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8010b0:	0f 84 ad 00 00 00    	je     801163 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8010b6:	83 ec 08             	sub    $0x8,%esp
  8010b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8010bc:	68 93 2d 80 00       	push   $0x802d93
  8010c1:	e8 20 f9 ff ff       	call   8009e6 <cprintf>
  8010c6:	83 c4 10             	add    $0x10,%esp
			return;
  8010c9:	e9 95 00 00 00       	jmp    801163 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8010ce:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8010d2:	7e 34                	jle    801108 <readline+0xa0>
  8010d4:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8010db:	7f 2b                	jg     801108 <readline+0xa0>
			if (echoing)
  8010dd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010e1:	74 0e                	je     8010f1 <readline+0x89>
				cputchar(c);
  8010e3:	83 ec 0c             	sub    $0xc,%esp
  8010e6:	ff 75 ec             	pushl  -0x14(%ebp)
  8010e9:	e8 71 f4 ff ff       	call   80055f <cputchar>
  8010ee:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8010f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010f4:	8d 50 01             	lea    0x1(%eax),%edx
  8010f7:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8010fa:	89 c2                	mov    %eax,%edx
  8010fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ff:	01 d0                	add    %edx,%eax
  801101:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801104:	88 10                	mov    %dl,(%eax)
  801106:	eb 56                	jmp    80115e <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  801108:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80110c:	75 1f                	jne    80112d <readline+0xc5>
  80110e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801112:	7e 19                	jle    80112d <readline+0xc5>
			if (echoing)
  801114:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801118:	74 0e                	je     801128 <readline+0xc0>
				cputchar(c);
  80111a:	83 ec 0c             	sub    $0xc,%esp
  80111d:	ff 75 ec             	pushl  -0x14(%ebp)
  801120:	e8 3a f4 ff ff       	call   80055f <cputchar>
  801125:	83 c4 10             	add    $0x10,%esp

			i--;
  801128:	ff 4d f4             	decl   -0xc(%ebp)
  80112b:	eb 31                	jmp    80115e <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  80112d:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801131:	74 0a                	je     80113d <readline+0xd5>
  801133:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801137:	0f 85 61 ff ff ff    	jne    80109e <readline+0x36>
			if (echoing)
  80113d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801141:	74 0e                	je     801151 <readline+0xe9>
				cputchar(c);
  801143:	83 ec 0c             	sub    $0xc,%esp
  801146:	ff 75 ec             	pushl  -0x14(%ebp)
  801149:	e8 11 f4 ff ff       	call   80055f <cputchar>
  80114e:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801151:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801154:	8b 45 0c             	mov    0xc(%ebp),%eax
  801157:	01 d0                	add    %edx,%eax
  801159:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80115c:	eb 06                	jmp    801164 <readline+0xfc>
		}
	}
  80115e:	e9 3b ff ff ff       	jmp    80109e <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801163:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801164:	c9                   	leave  
  801165:	c3                   	ret    

00801166 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801166:	55                   	push   %ebp
  801167:	89 e5                	mov    %esp,%ebp
  801169:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80116c:	e8 73 0e 00 00       	call   801fe4 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801171:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801175:	74 13                	je     80118a <atomic_readline+0x24>
		cprintf("%s", prompt);
  801177:	83 ec 08             	sub    $0x8,%esp
  80117a:	ff 75 08             	pushl  0x8(%ebp)
  80117d:	68 90 2d 80 00       	push   $0x802d90
  801182:	e8 5f f8 ff ff       	call   8009e6 <cprintf>
  801187:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80118a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801191:	83 ec 0c             	sub    $0xc,%esp
  801194:	6a 00                	push   $0x0
  801196:	e8 5a f4 ff ff       	call   8005f5 <iscons>
  80119b:	83 c4 10             	add    $0x10,%esp
  80119e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8011a1:	e8 01 f4 ff ff       	call   8005a7 <getchar>
  8011a6:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8011a9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8011ad:	79 23                	jns    8011d2 <atomic_readline+0x6c>
			if (c != -E_EOF)
  8011af:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8011b3:	74 13                	je     8011c8 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8011b5:	83 ec 08             	sub    $0x8,%esp
  8011b8:	ff 75 ec             	pushl  -0x14(%ebp)
  8011bb:	68 93 2d 80 00       	push   $0x802d93
  8011c0:	e8 21 f8 ff ff       	call   8009e6 <cprintf>
  8011c5:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8011c8:	e8 31 0e 00 00       	call   801ffe <sys_enable_interrupt>
			return;
  8011cd:	e9 9a 00 00 00       	jmp    80126c <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8011d2:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011d6:	7e 34                	jle    80120c <atomic_readline+0xa6>
  8011d8:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011df:	7f 2b                	jg     80120c <atomic_readline+0xa6>
			if (echoing)
  8011e1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011e5:	74 0e                	je     8011f5 <atomic_readline+0x8f>
				cputchar(c);
  8011e7:	83 ec 0c             	sub    $0xc,%esp
  8011ea:	ff 75 ec             	pushl  -0x14(%ebp)
  8011ed:	e8 6d f3 ff ff       	call   80055f <cputchar>
  8011f2:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011f8:	8d 50 01             	lea    0x1(%eax),%edx
  8011fb:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011fe:	89 c2                	mov    %eax,%edx
  801200:	8b 45 0c             	mov    0xc(%ebp),%eax
  801203:	01 d0                	add    %edx,%eax
  801205:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801208:	88 10                	mov    %dl,(%eax)
  80120a:	eb 5b                	jmp    801267 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  80120c:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801210:	75 1f                	jne    801231 <atomic_readline+0xcb>
  801212:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801216:	7e 19                	jle    801231 <atomic_readline+0xcb>
			if (echoing)
  801218:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80121c:	74 0e                	je     80122c <atomic_readline+0xc6>
				cputchar(c);
  80121e:	83 ec 0c             	sub    $0xc,%esp
  801221:	ff 75 ec             	pushl  -0x14(%ebp)
  801224:	e8 36 f3 ff ff       	call   80055f <cputchar>
  801229:	83 c4 10             	add    $0x10,%esp
			i--;
  80122c:	ff 4d f4             	decl   -0xc(%ebp)
  80122f:	eb 36                	jmp    801267 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801231:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801235:	74 0a                	je     801241 <atomic_readline+0xdb>
  801237:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80123b:	0f 85 60 ff ff ff    	jne    8011a1 <atomic_readline+0x3b>
			if (echoing)
  801241:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801245:	74 0e                	je     801255 <atomic_readline+0xef>
				cputchar(c);
  801247:	83 ec 0c             	sub    $0xc,%esp
  80124a:	ff 75 ec             	pushl  -0x14(%ebp)
  80124d:	e8 0d f3 ff ff       	call   80055f <cputchar>
  801252:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801255:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801258:	8b 45 0c             	mov    0xc(%ebp),%eax
  80125b:	01 d0                	add    %edx,%eax
  80125d:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801260:	e8 99 0d 00 00       	call   801ffe <sys_enable_interrupt>
			return;
  801265:	eb 05                	jmp    80126c <atomic_readline+0x106>
		}
	}
  801267:	e9 35 ff ff ff       	jmp    8011a1 <atomic_readline+0x3b>
}
  80126c:	c9                   	leave  
  80126d:	c3                   	ret    

0080126e <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80126e:	55                   	push   %ebp
  80126f:	89 e5                	mov    %esp,%ebp
  801271:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801274:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80127b:	eb 06                	jmp    801283 <strlen+0x15>
		n++;
  80127d:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801280:	ff 45 08             	incl   0x8(%ebp)
  801283:	8b 45 08             	mov    0x8(%ebp),%eax
  801286:	8a 00                	mov    (%eax),%al
  801288:	84 c0                	test   %al,%al
  80128a:	75 f1                	jne    80127d <strlen+0xf>
		n++;
	return n;
  80128c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80128f:	c9                   	leave  
  801290:	c3                   	ret    

00801291 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801291:	55                   	push   %ebp
  801292:	89 e5                	mov    %esp,%ebp
  801294:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801297:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80129e:	eb 09                	jmp    8012a9 <strnlen+0x18>
		n++;
  8012a0:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012a3:	ff 45 08             	incl   0x8(%ebp)
  8012a6:	ff 4d 0c             	decl   0xc(%ebp)
  8012a9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012ad:	74 09                	je     8012b8 <strnlen+0x27>
  8012af:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b2:	8a 00                	mov    (%eax),%al
  8012b4:	84 c0                	test   %al,%al
  8012b6:	75 e8                	jne    8012a0 <strnlen+0xf>
		n++;
	return n;
  8012b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012bb:	c9                   	leave  
  8012bc:	c3                   	ret    

008012bd <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8012bd:	55                   	push   %ebp
  8012be:	89 e5                	mov    %esp,%ebp
  8012c0:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8012c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8012c9:	90                   	nop
  8012ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8012cd:	8d 50 01             	lea    0x1(%eax),%edx
  8012d0:	89 55 08             	mov    %edx,0x8(%ebp)
  8012d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012d6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012d9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012dc:	8a 12                	mov    (%edx),%dl
  8012de:	88 10                	mov    %dl,(%eax)
  8012e0:	8a 00                	mov    (%eax),%al
  8012e2:	84 c0                	test   %al,%al
  8012e4:	75 e4                	jne    8012ca <strcpy+0xd>
		/* do nothing */;
	return ret;
  8012e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012e9:	c9                   	leave  
  8012ea:	c3                   	ret    

008012eb <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8012eb:	55                   	push   %ebp
  8012ec:	89 e5                	mov    %esp,%ebp
  8012ee:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012fe:	eb 1f                	jmp    80131f <strncpy+0x34>
		*dst++ = *src;
  801300:	8b 45 08             	mov    0x8(%ebp),%eax
  801303:	8d 50 01             	lea    0x1(%eax),%edx
  801306:	89 55 08             	mov    %edx,0x8(%ebp)
  801309:	8b 55 0c             	mov    0xc(%ebp),%edx
  80130c:	8a 12                	mov    (%edx),%dl
  80130e:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801310:	8b 45 0c             	mov    0xc(%ebp),%eax
  801313:	8a 00                	mov    (%eax),%al
  801315:	84 c0                	test   %al,%al
  801317:	74 03                	je     80131c <strncpy+0x31>
			src++;
  801319:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80131c:	ff 45 fc             	incl   -0x4(%ebp)
  80131f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801322:	3b 45 10             	cmp    0x10(%ebp),%eax
  801325:	72 d9                	jb     801300 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801327:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80132a:	c9                   	leave  
  80132b:	c3                   	ret    

0080132c <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80132c:	55                   	push   %ebp
  80132d:	89 e5                	mov    %esp,%ebp
  80132f:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801332:	8b 45 08             	mov    0x8(%ebp),%eax
  801335:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801338:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80133c:	74 30                	je     80136e <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80133e:	eb 16                	jmp    801356 <strlcpy+0x2a>
			*dst++ = *src++;
  801340:	8b 45 08             	mov    0x8(%ebp),%eax
  801343:	8d 50 01             	lea    0x1(%eax),%edx
  801346:	89 55 08             	mov    %edx,0x8(%ebp)
  801349:	8b 55 0c             	mov    0xc(%ebp),%edx
  80134c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80134f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801352:	8a 12                	mov    (%edx),%dl
  801354:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801356:	ff 4d 10             	decl   0x10(%ebp)
  801359:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80135d:	74 09                	je     801368 <strlcpy+0x3c>
  80135f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801362:	8a 00                	mov    (%eax),%al
  801364:	84 c0                	test   %al,%al
  801366:	75 d8                	jne    801340 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801368:	8b 45 08             	mov    0x8(%ebp),%eax
  80136b:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80136e:	8b 55 08             	mov    0x8(%ebp),%edx
  801371:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801374:	29 c2                	sub    %eax,%edx
  801376:	89 d0                	mov    %edx,%eax
}
  801378:	c9                   	leave  
  801379:	c3                   	ret    

0080137a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80137a:	55                   	push   %ebp
  80137b:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80137d:	eb 06                	jmp    801385 <strcmp+0xb>
		p++, q++;
  80137f:	ff 45 08             	incl   0x8(%ebp)
  801382:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	8a 00                	mov    (%eax),%al
  80138a:	84 c0                	test   %al,%al
  80138c:	74 0e                	je     80139c <strcmp+0x22>
  80138e:	8b 45 08             	mov    0x8(%ebp),%eax
  801391:	8a 10                	mov    (%eax),%dl
  801393:	8b 45 0c             	mov    0xc(%ebp),%eax
  801396:	8a 00                	mov    (%eax),%al
  801398:	38 c2                	cmp    %al,%dl
  80139a:	74 e3                	je     80137f <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80139c:	8b 45 08             	mov    0x8(%ebp),%eax
  80139f:	8a 00                	mov    (%eax),%al
  8013a1:	0f b6 d0             	movzbl %al,%edx
  8013a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a7:	8a 00                	mov    (%eax),%al
  8013a9:	0f b6 c0             	movzbl %al,%eax
  8013ac:	29 c2                	sub    %eax,%edx
  8013ae:	89 d0                	mov    %edx,%eax
}
  8013b0:	5d                   	pop    %ebp
  8013b1:	c3                   	ret    

008013b2 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8013b2:	55                   	push   %ebp
  8013b3:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8013b5:	eb 09                	jmp    8013c0 <strncmp+0xe>
		n--, p++, q++;
  8013b7:	ff 4d 10             	decl   0x10(%ebp)
  8013ba:	ff 45 08             	incl   0x8(%ebp)
  8013bd:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8013c0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013c4:	74 17                	je     8013dd <strncmp+0x2b>
  8013c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c9:	8a 00                	mov    (%eax),%al
  8013cb:	84 c0                	test   %al,%al
  8013cd:	74 0e                	je     8013dd <strncmp+0x2b>
  8013cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d2:	8a 10                	mov    (%eax),%dl
  8013d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d7:	8a 00                	mov    (%eax),%al
  8013d9:	38 c2                	cmp    %al,%dl
  8013db:	74 da                	je     8013b7 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013e1:	75 07                	jne    8013ea <strncmp+0x38>
		return 0;
  8013e3:	b8 00 00 00 00       	mov    $0x0,%eax
  8013e8:	eb 14                	jmp    8013fe <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8013ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ed:	8a 00                	mov    (%eax),%al
  8013ef:	0f b6 d0             	movzbl %al,%edx
  8013f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f5:	8a 00                	mov    (%eax),%al
  8013f7:	0f b6 c0             	movzbl %al,%eax
  8013fa:	29 c2                	sub    %eax,%edx
  8013fc:	89 d0                	mov    %edx,%eax
}
  8013fe:	5d                   	pop    %ebp
  8013ff:	c3                   	ret    

00801400 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801400:	55                   	push   %ebp
  801401:	89 e5                	mov    %esp,%ebp
  801403:	83 ec 04             	sub    $0x4,%esp
  801406:	8b 45 0c             	mov    0xc(%ebp),%eax
  801409:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80140c:	eb 12                	jmp    801420 <strchr+0x20>
		if (*s == c)
  80140e:	8b 45 08             	mov    0x8(%ebp),%eax
  801411:	8a 00                	mov    (%eax),%al
  801413:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801416:	75 05                	jne    80141d <strchr+0x1d>
			return (char *) s;
  801418:	8b 45 08             	mov    0x8(%ebp),%eax
  80141b:	eb 11                	jmp    80142e <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80141d:	ff 45 08             	incl   0x8(%ebp)
  801420:	8b 45 08             	mov    0x8(%ebp),%eax
  801423:	8a 00                	mov    (%eax),%al
  801425:	84 c0                	test   %al,%al
  801427:	75 e5                	jne    80140e <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801429:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
  801433:	83 ec 04             	sub    $0x4,%esp
  801436:	8b 45 0c             	mov    0xc(%ebp),%eax
  801439:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80143c:	eb 0d                	jmp    80144b <strfind+0x1b>
		if (*s == c)
  80143e:	8b 45 08             	mov    0x8(%ebp),%eax
  801441:	8a 00                	mov    (%eax),%al
  801443:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801446:	74 0e                	je     801456 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801448:	ff 45 08             	incl   0x8(%ebp)
  80144b:	8b 45 08             	mov    0x8(%ebp),%eax
  80144e:	8a 00                	mov    (%eax),%al
  801450:	84 c0                	test   %al,%al
  801452:	75 ea                	jne    80143e <strfind+0xe>
  801454:	eb 01                	jmp    801457 <strfind+0x27>
		if (*s == c)
			break;
  801456:	90                   	nop
	return (char *) s;
  801457:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80145a:	c9                   	leave  
  80145b:	c3                   	ret    

0080145c <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80145c:	55                   	push   %ebp
  80145d:	89 e5                	mov    %esp,%ebp
  80145f:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801462:	8b 45 08             	mov    0x8(%ebp),%eax
  801465:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801468:	8b 45 10             	mov    0x10(%ebp),%eax
  80146b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80146e:	eb 0e                	jmp    80147e <memset+0x22>
		*p++ = c;
  801470:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801473:	8d 50 01             	lea    0x1(%eax),%edx
  801476:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801479:	8b 55 0c             	mov    0xc(%ebp),%edx
  80147c:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80147e:	ff 4d f8             	decl   -0x8(%ebp)
  801481:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801485:	79 e9                	jns    801470 <memset+0x14>
		*p++ = c;

	return v;
  801487:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80148a:	c9                   	leave  
  80148b:	c3                   	ret    

0080148c <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80148c:	55                   	push   %ebp
  80148d:	89 e5                	mov    %esp,%ebp
  80148f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801492:	8b 45 0c             	mov    0xc(%ebp),%eax
  801495:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801498:	8b 45 08             	mov    0x8(%ebp),%eax
  80149b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80149e:	eb 16                	jmp    8014b6 <memcpy+0x2a>
		*d++ = *s++;
  8014a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014a3:	8d 50 01             	lea    0x1(%eax),%edx
  8014a6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014a9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014ac:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014af:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014b2:	8a 12                	mov    (%edx),%dl
  8014b4:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8014b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014bc:	89 55 10             	mov    %edx,0x10(%ebp)
  8014bf:	85 c0                	test   %eax,%eax
  8014c1:	75 dd                	jne    8014a0 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8014c3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014c6:	c9                   	leave  
  8014c7:	c3                   	ret    

008014c8 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
  8014cb:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014da:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014dd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014e0:	73 50                	jae    801532 <memmove+0x6a>
  8014e2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e8:	01 d0                	add    %edx,%eax
  8014ea:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014ed:	76 43                	jbe    801532 <memmove+0x6a>
		s += n;
  8014ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f2:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014f5:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f8:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014fb:	eb 10                	jmp    80150d <memmove+0x45>
			*--d = *--s;
  8014fd:	ff 4d f8             	decl   -0x8(%ebp)
  801500:	ff 4d fc             	decl   -0x4(%ebp)
  801503:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801506:	8a 10                	mov    (%eax),%dl
  801508:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80150b:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80150d:	8b 45 10             	mov    0x10(%ebp),%eax
  801510:	8d 50 ff             	lea    -0x1(%eax),%edx
  801513:	89 55 10             	mov    %edx,0x10(%ebp)
  801516:	85 c0                	test   %eax,%eax
  801518:	75 e3                	jne    8014fd <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80151a:	eb 23                	jmp    80153f <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80151c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80151f:	8d 50 01             	lea    0x1(%eax),%edx
  801522:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801525:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801528:	8d 4a 01             	lea    0x1(%edx),%ecx
  80152b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80152e:	8a 12                	mov    (%edx),%dl
  801530:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801532:	8b 45 10             	mov    0x10(%ebp),%eax
  801535:	8d 50 ff             	lea    -0x1(%eax),%edx
  801538:	89 55 10             	mov    %edx,0x10(%ebp)
  80153b:	85 c0                	test   %eax,%eax
  80153d:	75 dd                	jne    80151c <memmove+0x54>
			*d++ = *s++;

	return dst;
  80153f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801542:	c9                   	leave  
  801543:	c3                   	ret    

00801544 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801544:	55                   	push   %ebp
  801545:	89 e5                	mov    %esp,%ebp
  801547:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80154a:	8b 45 08             	mov    0x8(%ebp),%eax
  80154d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801550:	8b 45 0c             	mov    0xc(%ebp),%eax
  801553:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801556:	eb 2a                	jmp    801582 <memcmp+0x3e>
		if (*s1 != *s2)
  801558:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80155b:	8a 10                	mov    (%eax),%dl
  80155d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801560:	8a 00                	mov    (%eax),%al
  801562:	38 c2                	cmp    %al,%dl
  801564:	74 16                	je     80157c <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801566:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801569:	8a 00                	mov    (%eax),%al
  80156b:	0f b6 d0             	movzbl %al,%edx
  80156e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801571:	8a 00                	mov    (%eax),%al
  801573:	0f b6 c0             	movzbl %al,%eax
  801576:	29 c2                	sub    %eax,%edx
  801578:	89 d0                	mov    %edx,%eax
  80157a:	eb 18                	jmp    801594 <memcmp+0x50>
		s1++, s2++;
  80157c:	ff 45 fc             	incl   -0x4(%ebp)
  80157f:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801582:	8b 45 10             	mov    0x10(%ebp),%eax
  801585:	8d 50 ff             	lea    -0x1(%eax),%edx
  801588:	89 55 10             	mov    %edx,0x10(%ebp)
  80158b:	85 c0                	test   %eax,%eax
  80158d:	75 c9                	jne    801558 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80158f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801594:	c9                   	leave  
  801595:	c3                   	ret    

00801596 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801596:	55                   	push   %ebp
  801597:	89 e5                	mov    %esp,%ebp
  801599:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80159c:	8b 55 08             	mov    0x8(%ebp),%edx
  80159f:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a2:	01 d0                	add    %edx,%eax
  8015a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8015a7:	eb 15                	jmp    8015be <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8015a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ac:	8a 00                	mov    (%eax),%al
  8015ae:	0f b6 d0             	movzbl %al,%edx
  8015b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b4:	0f b6 c0             	movzbl %al,%eax
  8015b7:	39 c2                	cmp    %eax,%edx
  8015b9:	74 0d                	je     8015c8 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8015bb:	ff 45 08             	incl   0x8(%ebp)
  8015be:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015c4:	72 e3                	jb     8015a9 <memfind+0x13>
  8015c6:	eb 01                	jmp    8015c9 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015c8:	90                   	nop
	return (void *) s;
  8015c9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015cc:	c9                   	leave  
  8015cd:	c3                   	ret    

008015ce <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015ce:	55                   	push   %ebp
  8015cf:	89 e5                	mov    %esp,%ebp
  8015d1:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015d4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015db:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015e2:	eb 03                	jmp    8015e7 <strtol+0x19>
		s++;
  8015e4:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ea:	8a 00                	mov    (%eax),%al
  8015ec:	3c 20                	cmp    $0x20,%al
  8015ee:	74 f4                	je     8015e4 <strtol+0x16>
  8015f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f3:	8a 00                	mov    (%eax),%al
  8015f5:	3c 09                	cmp    $0x9,%al
  8015f7:	74 eb                	je     8015e4 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fc:	8a 00                	mov    (%eax),%al
  8015fe:	3c 2b                	cmp    $0x2b,%al
  801600:	75 05                	jne    801607 <strtol+0x39>
		s++;
  801602:	ff 45 08             	incl   0x8(%ebp)
  801605:	eb 13                	jmp    80161a <strtol+0x4c>
	else if (*s == '-')
  801607:	8b 45 08             	mov    0x8(%ebp),%eax
  80160a:	8a 00                	mov    (%eax),%al
  80160c:	3c 2d                	cmp    $0x2d,%al
  80160e:	75 0a                	jne    80161a <strtol+0x4c>
		s++, neg = 1;
  801610:	ff 45 08             	incl   0x8(%ebp)
  801613:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80161a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80161e:	74 06                	je     801626 <strtol+0x58>
  801620:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801624:	75 20                	jne    801646 <strtol+0x78>
  801626:	8b 45 08             	mov    0x8(%ebp),%eax
  801629:	8a 00                	mov    (%eax),%al
  80162b:	3c 30                	cmp    $0x30,%al
  80162d:	75 17                	jne    801646 <strtol+0x78>
  80162f:	8b 45 08             	mov    0x8(%ebp),%eax
  801632:	40                   	inc    %eax
  801633:	8a 00                	mov    (%eax),%al
  801635:	3c 78                	cmp    $0x78,%al
  801637:	75 0d                	jne    801646 <strtol+0x78>
		s += 2, base = 16;
  801639:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80163d:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801644:	eb 28                	jmp    80166e <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801646:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80164a:	75 15                	jne    801661 <strtol+0x93>
  80164c:	8b 45 08             	mov    0x8(%ebp),%eax
  80164f:	8a 00                	mov    (%eax),%al
  801651:	3c 30                	cmp    $0x30,%al
  801653:	75 0c                	jne    801661 <strtol+0x93>
		s++, base = 8;
  801655:	ff 45 08             	incl   0x8(%ebp)
  801658:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80165f:	eb 0d                	jmp    80166e <strtol+0xa0>
	else if (base == 0)
  801661:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801665:	75 07                	jne    80166e <strtol+0xa0>
		base = 10;
  801667:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80166e:	8b 45 08             	mov    0x8(%ebp),%eax
  801671:	8a 00                	mov    (%eax),%al
  801673:	3c 2f                	cmp    $0x2f,%al
  801675:	7e 19                	jle    801690 <strtol+0xc2>
  801677:	8b 45 08             	mov    0x8(%ebp),%eax
  80167a:	8a 00                	mov    (%eax),%al
  80167c:	3c 39                	cmp    $0x39,%al
  80167e:	7f 10                	jg     801690 <strtol+0xc2>
			dig = *s - '0';
  801680:	8b 45 08             	mov    0x8(%ebp),%eax
  801683:	8a 00                	mov    (%eax),%al
  801685:	0f be c0             	movsbl %al,%eax
  801688:	83 e8 30             	sub    $0x30,%eax
  80168b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80168e:	eb 42                	jmp    8016d2 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801690:	8b 45 08             	mov    0x8(%ebp),%eax
  801693:	8a 00                	mov    (%eax),%al
  801695:	3c 60                	cmp    $0x60,%al
  801697:	7e 19                	jle    8016b2 <strtol+0xe4>
  801699:	8b 45 08             	mov    0x8(%ebp),%eax
  80169c:	8a 00                	mov    (%eax),%al
  80169e:	3c 7a                	cmp    $0x7a,%al
  8016a0:	7f 10                	jg     8016b2 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8016a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a5:	8a 00                	mov    (%eax),%al
  8016a7:	0f be c0             	movsbl %al,%eax
  8016aa:	83 e8 57             	sub    $0x57,%eax
  8016ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016b0:	eb 20                	jmp    8016d2 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b5:	8a 00                	mov    (%eax),%al
  8016b7:	3c 40                	cmp    $0x40,%al
  8016b9:	7e 39                	jle    8016f4 <strtol+0x126>
  8016bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016be:	8a 00                	mov    (%eax),%al
  8016c0:	3c 5a                	cmp    $0x5a,%al
  8016c2:	7f 30                	jg     8016f4 <strtol+0x126>
			dig = *s - 'A' + 10;
  8016c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c7:	8a 00                	mov    (%eax),%al
  8016c9:	0f be c0             	movsbl %al,%eax
  8016cc:	83 e8 37             	sub    $0x37,%eax
  8016cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016d5:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016d8:	7d 19                	jge    8016f3 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016da:	ff 45 08             	incl   0x8(%ebp)
  8016dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016e0:	0f af 45 10          	imul   0x10(%ebp),%eax
  8016e4:	89 c2                	mov    %eax,%edx
  8016e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016e9:	01 d0                	add    %edx,%eax
  8016eb:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016ee:	e9 7b ff ff ff       	jmp    80166e <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016f3:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016f4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016f8:	74 08                	je     801702 <strtol+0x134>
		*endptr = (char *) s;
  8016fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016fd:	8b 55 08             	mov    0x8(%ebp),%edx
  801700:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801702:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801706:	74 07                	je     80170f <strtol+0x141>
  801708:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80170b:	f7 d8                	neg    %eax
  80170d:	eb 03                	jmp    801712 <strtol+0x144>
  80170f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801712:	c9                   	leave  
  801713:	c3                   	ret    

00801714 <ltostr>:

void
ltostr(long value, char *str)
{
  801714:	55                   	push   %ebp
  801715:	89 e5                	mov    %esp,%ebp
  801717:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80171a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801721:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801728:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80172c:	79 13                	jns    801741 <ltostr+0x2d>
	{
		neg = 1;
  80172e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801735:	8b 45 0c             	mov    0xc(%ebp),%eax
  801738:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80173b:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80173e:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801741:	8b 45 08             	mov    0x8(%ebp),%eax
  801744:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801749:	99                   	cltd   
  80174a:	f7 f9                	idiv   %ecx
  80174c:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80174f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801752:	8d 50 01             	lea    0x1(%eax),%edx
  801755:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801758:	89 c2                	mov    %eax,%edx
  80175a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80175d:	01 d0                	add    %edx,%eax
  80175f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801762:	83 c2 30             	add    $0x30,%edx
  801765:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801767:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80176a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80176f:	f7 e9                	imul   %ecx
  801771:	c1 fa 02             	sar    $0x2,%edx
  801774:	89 c8                	mov    %ecx,%eax
  801776:	c1 f8 1f             	sar    $0x1f,%eax
  801779:	29 c2                	sub    %eax,%edx
  80177b:	89 d0                	mov    %edx,%eax
  80177d:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801780:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801783:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801788:	f7 e9                	imul   %ecx
  80178a:	c1 fa 02             	sar    $0x2,%edx
  80178d:	89 c8                	mov    %ecx,%eax
  80178f:	c1 f8 1f             	sar    $0x1f,%eax
  801792:	29 c2                	sub    %eax,%edx
  801794:	89 d0                	mov    %edx,%eax
  801796:	c1 e0 02             	shl    $0x2,%eax
  801799:	01 d0                	add    %edx,%eax
  80179b:	01 c0                	add    %eax,%eax
  80179d:	29 c1                	sub    %eax,%ecx
  80179f:	89 ca                	mov    %ecx,%edx
  8017a1:	85 d2                	test   %edx,%edx
  8017a3:	75 9c                	jne    801741 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8017a5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017af:	48                   	dec    %eax
  8017b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017b3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017b7:	74 3d                	je     8017f6 <ltostr+0xe2>
		start = 1 ;
  8017b9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017c0:	eb 34                	jmp    8017f6 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8017c2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c8:	01 d0                	add    %edx,%eax
  8017ca:	8a 00                	mov    (%eax),%al
  8017cc:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d5:	01 c2                	add    %eax,%edx
  8017d7:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017dd:	01 c8                	add    %ecx,%eax
  8017df:	8a 00                	mov    (%eax),%al
  8017e1:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017e3:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e9:	01 c2                	add    %eax,%edx
  8017eb:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017ee:	88 02                	mov    %al,(%edx)
		start++ ;
  8017f0:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017f3:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017f9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017fc:	7c c4                	jl     8017c2 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017fe:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801801:	8b 45 0c             	mov    0xc(%ebp),%eax
  801804:	01 d0                	add    %edx,%eax
  801806:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801809:	90                   	nop
  80180a:	c9                   	leave  
  80180b:	c3                   	ret    

0080180c <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80180c:	55                   	push   %ebp
  80180d:	89 e5                	mov    %esp,%ebp
  80180f:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801812:	ff 75 08             	pushl  0x8(%ebp)
  801815:	e8 54 fa ff ff       	call   80126e <strlen>
  80181a:	83 c4 04             	add    $0x4,%esp
  80181d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801820:	ff 75 0c             	pushl  0xc(%ebp)
  801823:	e8 46 fa ff ff       	call   80126e <strlen>
  801828:	83 c4 04             	add    $0x4,%esp
  80182b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80182e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801835:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80183c:	eb 17                	jmp    801855 <strcconcat+0x49>
		final[s] = str1[s] ;
  80183e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801841:	8b 45 10             	mov    0x10(%ebp),%eax
  801844:	01 c2                	add    %eax,%edx
  801846:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801849:	8b 45 08             	mov    0x8(%ebp),%eax
  80184c:	01 c8                	add    %ecx,%eax
  80184e:	8a 00                	mov    (%eax),%al
  801850:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801852:	ff 45 fc             	incl   -0x4(%ebp)
  801855:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801858:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80185b:	7c e1                	jl     80183e <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80185d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801864:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80186b:	eb 1f                	jmp    80188c <strcconcat+0x80>
		final[s++] = str2[i] ;
  80186d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801870:	8d 50 01             	lea    0x1(%eax),%edx
  801873:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801876:	89 c2                	mov    %eax,%edx
  801878:	8b 45 10             	mov    0x10(%ebp),%eax
  80187b:	01 c2                	add    %eax,%edx
  80187d:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801880:	8b 45 0c             	mov    0xc(%ebp),%eax
  801883:	01 c8                	add    %ecx,%eax
  801885:	8a 00                	mov    (%eax),%al
  801887:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801889:	ff 45 f8             	incl   -0x8(%ebp)
  80188c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80188f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801892:	7c d9                	jl     80186d <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801894:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801897:	8b 45 10             	mov    0x10(%ebp),%eax
  80189a:	01 d0                	add    %edx,%eax
  80189c:	c6 00 00             	movb   $0x0,(%eax)
}
  80189f:	90                   	nop
  8018a0:	c9                   	leave  
  8018a1:	c3                   	ret    

008018a2 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8018a2:	55                   	push   %ebp
  8018a3:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8018a5:	8b 45 14             	mov    0x14(%ebp),%eax
  8018a8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8018b1:	8b 00                	mov    (%eax),%eax
  8018b3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8018bd:	01 d0                	add    %edx,%eax
  8018bf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018c5:	eb 0c                	jmp    8018d3 <strsplit+0x31>
			*string++ = 0;
  8018c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ca:	8d 50 01             	lea    0x1(%eax),%edx
  8018cd:	89 55 08             	mov    %edx,0x8(%ebp)
  8018d0:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d6:	8a 00                	mov    (%eax),%al
  8018d8:	84 c0                	test   %al,%al
  8018da:	74 18                	je     8018f4 <strsplit+0x52>
  8018dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018df:	8a 00                	mov    (%eax),%al
  8018e1:	0f be c0             	movsbl %al,%eax
  8018e4:	50                   	push   %eax
  8018e5:	ff 75 0c             	pushl  0xc(%ebp)
  8018e8:	e8 13 fb ff ff       	call   801400 <strchr>
  8018ed:	83 c4 08             	add    $0x8,%esp
  8018f0:	85 c0                	test   %eax,%eax
  8018f2:	75 d3                	jne    8018c7 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8018f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f7:	8a 00                	mov    (%eax),%al
  8018f9:	84 c0                	test   %al,%al
  8018fb:	74 5a                	je     801957 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8018fd:	8b 45 14             	mov    0x14(%ebp),%eax
  801900:	8b 00                	mov    (%eax),%eax
  801902:	83 f8 0f             	cmp    $0xf,%eax
  801905:	75 07                	jne    80190e <strsplit+0x6c>
		{
			return 0;
  801907:	b8 00 00 00 00       	mov    $0x0,%eax
  80190c:	eb 66                	jmp    801974 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80190e:	8b 45 14             	mov    0x14(%ebp),%eax
  801911:	8b 00                	mov    (%eax),%eax
  801913:	8d 48 01             	lea    0x1(%eax),%ecx
  801916:	8b 55 14             	mov    0x14(%ebp),%edx
  801919:	89 0a                	mov    %ecx,(%edx)
  80191b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801922:	8b 45 10             	mov    0x10(%ebp),%eax
  801925:	01 c2                	add    %eax,%edx
  801927:	8b 45 08             	mov    0x8(%ebp),%eax
  80192a:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80192c:	eb 03                	jmp    801931 <strsplit+0x8f>
			string++;
  80192e:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801931:	8b 45 08             	mov    0x8(%ebp),%eax
  801934:	8a 00                	mov    (%eax),%al
  801936:	84 c0                	test   %al,%al
  801938:	74 8b                	je     8018c5 <strsplit+0x23>
  80193a:	8b 45 08             	mov    0x8(%ebp),%eax
  80193d:	8a 00                	mov    (%eax),%al
  80193f:	0f be c0             	movsbl %al,%eax
  801942:	50                   	push   %eax
  801943:	ff 75 0c             	pushl  0xc(%ebp)
  801946:	e8 b5 fa ff ff       	call   801400 <strchr>
  80194b:	83 c4 08             	add    $0x8,%esp
  80194e:	85 c0                	test   %eax,%eax
  801950:	74 dc                	je     80192e <strsplit+0x8c>
			string++;
	}
  801952:	e9 6e ff ff ff       	jmp    8018c5 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801957:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801958:	8b 45 14             	mov    0x14(%ebp),%eax
  80195b:	8b 00                	mov    (%eax),%eax
  80195d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801964:	8b 45 10             	mov    0x10(%ebp),%eax
  801967:	01 d0                	add    %edx,%eax
  801969:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80196f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801974:	c9                   	leave  
  801975:	c3                   	ret    

00801976 <malloc>:
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  801976:	55                   	push   %ebp
  801977:	89 e5                	mov    %esp,%ebp
  801979:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  80197c:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  801983:	76 0a                	jbe    80198f <malloc+0x19>
		return NULL;
  801985:	b8 00 00 00 00       	mov    $0x0,%eax
  80198a:	e9 ad 02 00 00       	jmp    801c3c <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  80198f:	8b 45 08             	mov    0x8(%ebp),%eax
  801992:	c1 e8 0c             	shr    $0xc,%eax
  801995:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  801998:	8b 45 08             	mov    0x8(%ebp),%eax
  80199b:	25 ff 0f 00 00       	and    $0xfff,%eax
  8019a0:	85 c0                	test   %eax,%eax
  8019a2:	74 03                	je     8019a7 <malloc+0x31>
		num++;
  8019a4:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  8019a7:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019ac:	85 c0                	test   %eax,%eax
  8019ae:	75 71                	jne    801a21 <malloc+0xab>
		sys_allocateMem(last_addres, size);
  8019b0:	a1 04 30 80 00       	mov    0x803004,%eax
  8019b5:	83 ec 08             	sub    $0x8,%esp
  8019b8:	ff 75 08             	pushl  0x8(%ebp)
  8019bb:	50                   	push   %eax
  8019bc:	e8 ba 05 00 00       	call   801f7b <sys_allocateMem>
  8019c1:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  8019c4:	a1 04 30 80 00       	mov    0x803004,%eax
  8019c9:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  8019cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019cf:	c1 e0 0c             	shl    $0xc,%eax
  8019d2:	89 c2                	mov    %eax,%edx
  8019d4:	a1 04 30 80 00       	mov    0x803004,%eax
  8019d9:	01 d0                	add    %edx,%eax
  8019db:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  8019e0:	a1 30 30 80 00       	mov    0x803030,%eax
  8019e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8019e8:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  8019ef:	a1 30 30 80 00       	mov    0x803030,%eax
  8019f4:	8b 55 c8             	mov    -0x38(%ebp),%edx
  8019f7:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
		changed[sizeofarray] = 1;
  8019fe:	a1 30 30 80 00       	mov    0x803030,%eax
  801a03:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801a0a:	01 00 00 00 
		sizeofarray++;
  801a0e:	a1 30 30 80 00       	mov    0x803030,%eax
  801a13:	40                   	inc    %eax
  801a14:	a3 30 30 80 00       	mov    %eax,0x803030
		return (void*) return_addres;
  801a19:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801a1c:	e9 1b 02 00 00       	jmp    801c3c <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  801a21:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  801a28:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  801a2f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  801a36:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  801a3d:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  801a44:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801a4b:	eb 72                	jmp    801abf <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  801a4d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a50:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801a57:	85 c0                	test   %eax,%eax
  801a59:	75 12                	jne    801a6d <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  801a5b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a5e:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801a65:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  801a68:	ff 45 dc             	incl   -0x24(%ebp)
  801a6b:	eb 4f                	jmp    801abc <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  801a6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a70:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801a73:	7d 39                	jge    801aae <malloc+0x138>
  801a75:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a78:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a7b:	7c 31                	jl     801aae <malloc+0x138>
					{
						min=count;
  801a7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a80:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  801a83:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a86:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801a8d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a90:	c1 e2 0c             	shl    $0xc,%edx
  801a93:	29 d0                	sub    %edx,%eax
  801a95:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  801a98:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a9b:	2b 45 dc             	sub    -0x24(%ebp),%eax
  801a9e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  801aa1:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  801aa8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801aab:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  801aae:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  801ab5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  801abc:	ff 45 d4             	incl   -0x2c(%ebp)
  801abf:	a1 30 30 80 00       	mov    0x803030,%eax
  801ac4:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  801ac7:	7c 84                	jl     801a4d <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  801ac9:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  801acd:	0f 85 e3 00 00 00    	jne    801bb6 <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  801ad3:	83 ec 08             	sub    $0x8,%esp
  801ad6:	ff 75 08             	pushl  0x8(%ebp)
  801ad9:	ff 75 e0             	pushl  -0x20(%ebp)
  801adc:	e8 9a 04 00 00       	call   801f7b <sys_allocateMem>
  801ae1:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  801ae4:	a1 30 30 80 00       	mov    0x803030,%eax
  801ae9:	40                   	inc    %eax
  801aea:	a3 30 30 80 00       	mov    %eax,0x803030
				for(int i=sizeofarray-1;i>index;i--)
  801aef:	a1 30 30 80 00       	mov    0x803030,%eax
  801af4:	48                   	dec    %eax
  801af5:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801af8:	eb 42                	jmp    801b3c <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  801afa:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801afd:	48                   	dec    %eax
  801afe:	8b 14 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%edx
  801b05:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b08:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  801b0f:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b12:	48                   	dec    %eax
  801b13:	8b 14 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%edx
  801b1a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b1d:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					changed[i]=changed[i-1];
  801b24:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b27:	48                   	dec    %eax
  801b28:	8b 14 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%edx
  801b2f:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b32:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  801b39:	ff 4d d0             	decl   -0x30(%ebp)
  801b3c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b3f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801b42:	7f b6                	jg     801afa <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  801b44:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b47:	40                   	inc    %eax
  801b48:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  801b4b:	8b 55 08             	mov    0x8(%ebp),%edx
  801b4e:	01 ca                	add    %ecx,%edx
  801b50:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  801b57:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b5a:	8d 50 01             	lea    0x1(%eax),%edx
  801b5d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b60:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801b67:	2b 45 f4             	sub    -0xc(%ebp),%eax
  801b6a:	89 04 95 a0 80 92 00 	mov    %eax,0x9280a0(,%edx,4)
				changed[index+1]=0;
  801b71:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b74:	40                   	inc    %eax
  801b75:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801b7c:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  801b80:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b83:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b86:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  801b8d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b90:	89 45 cc             	mov    %eax,-0x34(%ebp)
  801b93:	eb 11                	jmp    801ba6 <malloc+0x230>
				{
					changed[index] = 1;
  801b95:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b98:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801b9f:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  801ba3:	ff 45 cc             	incl   -0x34(%ebp)
  801ba6:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801ba9:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801bac:	7c e7                	jl     801b95 <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  801bae:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801bb1:	e9 86 00 00 00       	jmp    801c3c <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  801bb6:	a1 04 30 80 00       	mov    0x803004,%eax
  801bbb:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801bc0:	29 c2                	sub    %eax,%edx
  801bc2:	89 d0                	mov    %edx,%eax
  801bc4:	3b 45 08             	cmp    0x8(%ebp),%eax
  801bc7:	73 07                	jae    801bd0 <malloc+0x25a>
						return NULL;
  801bc9:	b8 00 00 00 00       	mov    $0x0,%eax
  801bce:	eb 6c                	jmp    801c3c <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801bd0:	a1 04 30 80 00       	mov    0x803004,%eax
  801bd5:	83 ec 08             	sub    $0x8,%esp
  801bd8:	ff 75 08             	pushl  0x8(%ebp)
  801bdb:	50                   	push   %eax
  801bdc:	e8 9a 03 00 00       	call   801f7b <sys_allocateMem>
  801be1:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801be4:	a1 04 30 80 00       	mov    0x803004,%eax
  801be9:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  801bec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bef:	c1 e0 0c             	shl    $0xc,%eax
  801bf2:	89 c2                	mov    %eax,%edx
  801bf4:	a1 04 30 80 00       	mov    0x803004,%eax
  801bf9:	01 d0                	add    %edx,%eax
  801bfb:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  801c00:	a1 30 30 80 00       	mov    0x803030,%eax
  801c05:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c08:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  801c0f:	a1 30 30 80 00       	mov    0x803030,%eax
  801c14:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801c17:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					changed[sizeofarray] = 1;
  801c1e:	a1 30 30 80 00       	mov    0x803030,%eax
  801c23:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801c2a:	01 00 00 00 
					sizeofarray++;
  801c2e:	a1 30 30 80 00       	mov    0x803030,%eax
  801c33:	40                   	inc    %eax
  801c34:	a3 30 30 80 00       	mov    %eax,0x803030
					return (void*) return_addres;
  801c39:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  801c3c:	c9                   	leave  
  801c3d:	c3                   	ret    

00801c3e <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801c3e:	55                   	push   %ebp
  801c3f:	89 e5                	mov    %esp,%ebp
  801c41:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801c44:	8b 45 08             	mov    0x8(%ebp),%eax
  801c47:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  801c4a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801c51:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801c58:	eb 30                	jmp    801c8a <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801c5a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c5d:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801c64:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801c67:	75 1e                	jne    801c87 <free+0x49>
  801c69:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c6c:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801c73:	83 f8 01             	cmp    $0x1,%eax
  801c76:	75 0f                	jne    801c87 <free+0x49>
			is_found = 1;
  801c78:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801c7f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c82:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801c85:	eb 0d                	jmp    801c94 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801c87:	ff 45 ec             	incl   -0x14(%ebp)
  801c8a:	a1 30 30 80 00       	mov    0x803030,%eax
  801c8f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801c92:	7c c6                	jl     801c5a <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801c94:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801c98:	75 3a                	jne    801cd4 <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  801c9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c9d:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801ca4:	c1 e0 0c             	shl    $0xc,%eax
  801ca7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  801caa:	83 ec 08             	sub    $0x8,%esp
  801cad:	ff 75 e4             	pushl  -0x1c(%ebp)
  801cb0:	ff 75 e8             	pushl  -0x18(%ebp)
  801cb3:	e8 a7 02 00 00       	call   801f5f <sys_freeMem>
  801cb8:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801cbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cbe:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801cc5:	00 00 00 00 
		changes++;
  801cc9:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801cce:	40                   	inc    %eax
  801ccf:	a3 2c 30 80 00       	mov    %eax,0x80302c
	}
	//refer to the project presentation and documentation for details
}
  801cd4:	90                   	nop
  801cd5:	c9                   	leave  
  801cd6:	c3                   	ret    

00801cd7 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801cd7:	55                   	push   %ebp
  801cd8:	89 e5                	mov    %esp,%ebp
  801cda:	83 ec 18             	sub    $0x18,%esp
  801cdd:	8b 45 10             	mov    0x10(%ebp),%eax
  801ce0:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801ce3:	83 ec 04             	sub    $0x4,%esp
  801ce6:	68 a4 2d 80 00       	push   $0x802da4
  801ceb:	68 b6 00 00 00       	push   $0xb6
  801cf0:	68 c7 2d 80 00       	push   $0x802dc7
  801cf5:	e8 4a ea ff ff       	call   800744 <_panic>

00801cfa <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801cfa:	55                   	push   %ebp
  801cfb:	89 e5                	mov    %esp,%ebp
  801cfd:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d00:	83 ec 04             	sub    $0x4,%esp
  801d03:	68 a4 2d 80 00       	push   $0x802da4
  801d08:	68 bb 00 00 00       	push   $0xbb
  801d0d:	68 c7 2d 80 00       	push   $0x802dc7
  801d12:	e8 2d ea ff ff       	call   800744 <_panic>

00801d17 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801d17:	55                   	push   %ebp
  801d18:	89 e5                	mov    %esp,%ebp
  801d1a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d1d:	83 ec 04             	sub    $0x4,%esp
  801d20:	68 a4 2d 80 00       	push   $0x802da4
  801d25:	68 c0 00 00 00       	push   $0xc0
  801d2a:	68 c7 2d 80 00       	push   $0x802dc7
  801d2f:	e8 10 ea ff ff       	call   800744 <_panic>

00801d34 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  801d34:	55                   	push   %ebp
  801d35:	89 e5                	mov    %esp,%ebp
  801d37:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d3a:	83 ec 04             	sub    $0x4,%esp
  801d3d:	68 a4 2d 80 00       	push   $0x802da4
  801d42:	68 c4 00 00 00       	push   $0xc4
  801d47:	68 c7 2d 80 00       	push   $0x802dc7
  801d4c:	e8 f3 e9 ff ff       	call   800744 <_panic>

00801d51 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  801d51:	55                   	push   %ebp
  801d52:	89 e5                	mov    %esp,%ebp
  801d54:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d57:	83 ec 04             	sub    $0x4,%esp
  801d5a:	68 a4 2d 80 00       	push   $0x802da4
  801d5f:	68 c9 00 00 00       	push   $0xc9
  801d64:	68 c7 2d 80 00       	push   $0x802dc7
  801d69:	e8 d6 e9 ff ff       	call   800744 <_panic>

00801d6e <shrink>:
}
void shrink(uint32 newSize) {
  801d6e:	55                   	push   %ebp
  801d6f:	89 e5                	mov    %esp,%ebp
  801d71:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d74:	83 ec 04             	sub    $0x4,%esp
  801d77:	68 a4 2d 80 00       	push   $0x802da4
  801d7c:	68 cc 00 00 00       	push   $0xcc
  801d81:	68 c7 2d 80 00       	push   $0x802dc7
  801d86:	e8 b9 e9 ff ff       	call   800744 <_panic>

00801d8b <freeHeap>:
}

void freeHeap(void* virtual_address) {
  801d8b:	55                   	push   %ebp
  801d8c:	89 e5                	mov    %esp,%ebp
  801d8e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d91:	83 ec 04             	sub    $0x4,%esp
  801d94:	68 a4 2d 80 00       	push   $0x802da4
  801d99:	68 d0 00 00 00       	push   $0xd0
  801d9e:	68 c7 2d 80 00       	push   $0x802dc7
  801da3:	e8 9c e9 ff ff       	call   800744 <_panic>

00801da8 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801da8:	55                   	push   %ebp
  801da9:	89 e5                	mov    %esp,%ebp
  801dab:	57                   	push   %edi
  801dac:	56                   	push   %esi
  801dad:	53                   	push   %ebx
  801dae:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801db1:	8b 45 08             	mov    0x8(%ebp),%eax
  801db4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801db7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801dba:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801dbd:	8b 7d 18             	mov    0x18(%ebp),%edi
  801dc0:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801dc3:	cd 30                	int    $0x30
  801dc5:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801dc8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801dcb:	83 c4 10             	add    $0x10,%esp
  801dce:	5b                   	pop    %ebx
  801dcf:	5e                   	pop    %esi
  801dd0:	5f                   	pop    %edi
  801dd1:	5d                   	pop    %ebp
  801dd2:	c3                   	ret    

00801dd3 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801dd3:	55                   	push   %ebp
  801dd4:	89 e5                	mov    %esp,%ebp
  801dd6:	83 ec 04             	sub    $0x4,%esp
  801dd9:	8b 45 10             	mov    0x10(%ebp),%eax
  801ddc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801ddf:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801de3:	8b 45 08             	mov    0x8(%ebp),%eax
  801de6:	6a 00                	push   $0x0
  801de8:	6a 00                	push   $0x0
  801dea:	52                   	push   %edx
  801deb:	ff 75 0c             	pushl  0xc(%ebp)
  801dee:	50                   	push   %eax
  801def:	6a 00                	push   $0x0
  801df1:	e8 b2 ff ff ff       	call   801da8 <syscall>
  801df6:	83 c4 18             	add    $0x18,%esp
}
  801df9:	90                   	nop
  801dfa:	c9                   	leave  
  801dfb:	c3                   	ret    

00801dfc <sys_cgetc>:

int
sys_cgetc(void)
{
  801dfc:	55                   	push   %ebp
  801dfd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801dff:	6a 00                	push   $0x0
  801e01:	6a 00                	push   $0x0
  801e03:	6a 00                	push   $0x0
  801e05:	6a 00                	push   $0x0
  801e07:	6a 00                	push   $0x0
  801e09:	6a 01                	push   $0x1
  801e0b:	e8 98 ff ff ff       	call   801da8 <syscall>
  801e10:	83 c4 18             	add    $0x18,%esp
}
  801e13:	c9                   	leave  
  801e14:	c3                   	ret    

00801e15 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801e15:	55                   	push   %ebp
  801e16:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801e18:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1b:	6a 00                	push   $0x0
  801e1d:	6a 00                	push   $0x0
  801e1f:	6a 00                	push   $0x0
  801e21:	6a 00                	push   $0x0
  801e23:	50                   	push   %eax
  801e24:	6a 05                	push   $0x5
  801e26:	e8 7d ff ff ff       	call   801da8 <syscall>
  801e2b:	83 c4 18             	add    $0x18,%esp
}
  801e2e:	c9                   	leave  
  801e2f:	c3                   	ret    

00801e30 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801e30:	55                   	push   %ebp
  801e31:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801e33:	6a 00                	push   $0x0
  801e35:	6a 00                	push   $0x0
  801e37:	6a 00                	push   $0x0
  801e39:	6a 00                	push   $0x0
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 02                	push   $0x2
  801e3f:	e8 64 ff ff ff       	call   801da8 <syscall>
  801e44:	83 c4 18             	add    $0x18,%esp
}
  801e47:	c9                   	leave  
  801e48:	c3                   	ret    

00801e49 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801e49:	55                   	push   %ebp
  801e4a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801e4c:	6a 00                	push   $0x0
  801e4e:	6a 00                	push   $0x0
  801e50:	6a 00                	push   $0x0
  801e52:	6a 00                	push   $0x0
  801e54:	6a 00                	push   $0x0
  801e56:	6a 03                	push   $0x3
  801e58:	e8 4b ff ff ff       	call   801da8 <syscall>
  801e5d:	83 c4 18             	add    $0x18,%esp
}
  801e60:	c9                   	leave  
  801e61:	c3                   	ret    

00801e62 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801e62:	55                   	push   %ebp
  801e63:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801e65:	6a 00                	push   $0x0
  801e67:	6a 00                	push   $0x0
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 00                	push   $0x0
  801e6d:	6a 00                	push   $0x0
  801e6f:	6a 04                	push   $0x4
  801e71:	e8 32 ff ff ff       	call   801da8 <syscall>
  801e76:	83 c4 18             	add    $0x18,%esp
}
  801e79:	c9                   	leave  
  801e7a:	c3                   	ret    

00801e7b <sys_env_exit>:


void sys_env_exit(void)
{
  801e7b:	55                   	push   %ebp
  801e7c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801e7e:	6a 00                	push   $0x0
  801e80:	6a 00                	push   $0x0
  801e82:	6a 00                	push   $0x0
  801e84:	6a 00                	push   $0x0
  801e86:	6a 00                	push   $0x0
  801e88:	6a 06                	push   $0x6
  801e8a:	e8 19 ff ff ff       	call   801da8 <syscall>
  801e8f:	83 c4 18             	add    $0x18,%esp
}
  801e92:	90                   	nop
  801e93:	c9                   	leave  
  801e94:	c3                   	ret    

00801e95 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801e95:	55                   	push   %ebp
  801e96:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801e98:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e9b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e9e:	6a 00                	push   $0x0
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 00                	push   $0x0
  801ea4:	52                   	push   %edx
  801ea5:	50                   	push   %eax
  801ea6:	6a 07                	push   $0x7
  801ea8:	e8 fb fe ff ff       	call   801da8 <syscall>
  801ead:	83 c4 18             	add    $0x18,%esp
}
  801eb0:	c9                   	leave  
  801eb1:	c3                   	ret    

00801eb2 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801eb2:	55                   	push   %ebp
  801eb3:	89 e5                	mov    %esp,%ebp
  801eb5:	56                   	push   %esi
  801eb6:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801eb7:	8b 75 18             	mov    0x18(%ebp),%esi
  801eba:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ebd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ec0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ec3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec6:	56                   	push   %esi
  801ec7:	53                   	push   %ebx
  801ec8:	51                   	push   %ecx
  801ec9:	52                   	push   %edx
  801eca:	50                   	push   %eax
  801ecb:	6a 08                	push   $0x8
  801ecd:	e8 d6 fe ff ff       	call   801da8 <syscall>
  801ed2:	83 c4 18             	add    $0x18,%esp
}
  801ed5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801ed8:	5b                   	pop    %ebx
  801ed9:	5e                   	pop    %esi
  801eda:	5d                   	pop    %ebp
  801edb:	c3                   	ret    

00801edc <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801edc:	55                   	push   %ebp
  801edd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801edf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee5:	6a 00                	push   $0x0
  801ee7:	6a 00                	push   $0x0
  801ee9:	6a 00                	push   $0x0
  801eeb:	52                   	push   %edx
  801eec:	50                   	push   %eax
  801eed:	6a 09                	push   $0x9
  801eef:	e8 b4 fe ff ff       	call   801da8 <syscall>
  801ef4:	83 c4 18             	add    $0x18,%esp
}
  801ef7:	c9                   	leave  
  801ef8:	c3                   	ret    

00801ef9 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801ef9:	55                   	push   %ebp
  801efa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801efc:	6a 00                	push   $0x0
  801efe:	6a 00                	push   $0x0
  801f00:	6a 00                	push   $0x0
  801f02:	ff 75 0c             	pushl  0xc(%ebp)
  801f05:	ff 75 08             	pushl  0x8(%ebp)
  801f08:	6a 0a                	push   $0xa
  801f0a:	e8 99 fe ff ff       	call   801da8 <syscall>
  801f0f:	83 c4 18             	add    $0x18,%esp
}
  801f12:	c9                   	leave  
  801f13:	c3                   	ret    

00801f14 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801f14:	55                   	push   %ebp
  801f15:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801f17:	6a 00                	push   $0x0
  801f19:	6a 00                	push   $0x0
  801f1b:	6a 00                	push   $0x0
  801f1d:	6a 00                	push   $0x0
  801f1f:	6a 00                	push   $0x0
  801f21:	6a 0b                	push   $0xb
  801f23:	e8 80 fe ff ff       	call   801da8 <syscall>
  801f28:	83 c4 18             	add    $0x18,%esp
}
  801f2b:	c9                   	leave  
  801f2c:	c3                   	ret    

00801f2d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801f2d:	55                   	push   %ebp
  801f2e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 0c                	push   $0xc
  801f3c:	e8 67 fe ff ff       	call   801da8 <syscall>
  801f41:	83 c4 18             	add    $0x18,%esp
}
  801f44:	c9                   	leave  
  801f45:	c3                   	ret    

00801f46 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801f46:	55                   	push   %ebp
  801f47:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801f49:	6a 00                	push   $0x0
  801f4b:	6a 00                	push   $0x0
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 00                	push   $0x0
  801f51:	6a 00                	push   $0x0
  801f53:	6a 0d                	push   $0xd
  801f55:	e8 4e fe ff ff       	call   801da8 <syscall>
  801f5a:	83 c4 18             	add    $0x18,%esp
}
  801f5d:	c9                   	leave  
  801f5e:	c3                   	ret    

00801f5f <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801f5f:	55                   	push   %ebp
  801f60:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801f62:	6a 00                	push   $0x0
  801f64:	6a 00                	push   $0x0
  801f66:	6a 00                	push   $0x0
  801f68:	ff 75 0c             	pushl  0xc(%ebp)
  801f6b:	ff 75 08             	pushl  0x8(%ebp)
  801f6e:	6a 11                	push   $0x11
  801f70:	e8 33 fe ff ff       	call   801da8 <syscall>
  801f75:	83 c4 18             	add    $0x18,%esp
	return;
  801f78:	90                   	nop
}
  801f79:	c9                   	leave  
  801f7a:	c3                   	ret    

00801f7b <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801f7b:	55                   	push   %ebp
  801f7c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801f7e:	6a 00                	push   $0x0
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	ff 75 0c             	pushl  0xc(%ebp)
  801f87:	ff 75 08             	pushl  0x8(%ebp)
  801f8a:	6a 12                	push   $0x12
  801f8c:	e8 17 fe ff ff       	call   801da8 <syscall>
  801f91:	83 c4 18             	add    $0x18,%esp
	return ;
  801f94:	90                   	nop
}
  801f95:	c9                   	leave  
  801f96:	c3                   	ret    

00801f97 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801f97:	55                   	push   %ebp
  801f98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801f9a:	6a 00                	push   $0x0
  801f9c:	6a 00                	push   $0x0
  801f9e:	6a 00                	push   $0x0
  801fa0:	6a 00                	push   $0x0
  801fa2:	6a 00                	push   $0x0
  801fa4:	6a 0e                	push   $0xe
  801fa6:	e8 fd fd ff ff       	call   801da8 <syscall>
  801fab:	83 c4 18             	add    $0x18,%esp
}
  801fae:	c9                   	leave  
  801faf:	c3                   	ret    

00801fb0 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801fb0:	55                   	push   %ebp
  801fb1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801fb3:	6a 00                	push   $0x0
  801fb5:	6a 00                	push   $0x0
  801fb7:	6a 00                	push   $0x0
  801fb9:	6a 00                	push   $0x0
  801fbb:	ff 75 08             	pushl  0x8(%ebp)
  801fbe:	6a 0f                	push   $0xf
  801fc0:	e8 e3 fd ff ff       	call   801da8 <syscall>
  801fc5:	83 c4 18             	add    $0x18,%esp
}
  801fc8:	c9                   	leave  
  801fc9:	c3                   	ret    

00801fca <sys_scarce_memory>:

void sys_scarce_memory()
{
  801fca:	55                   	push   %ebp
  801fcb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 00                	push   $0x0
  801fd3:	6a 00                	push   $0x0
  801fd5:	6a 00                	push   $0x0
  801fd7:	6a 10                	push   $0x10
  801fd9:	e8 ca fd ff ff       	call   801da8 <syscall>
  801fde:	83 c4 18             	add    $0x18,%esp
}
  801fe1:	90                   	nop
  801fe2:	c9                   	leave  
  801fe3:	c3                   	ret    

00801fe4 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801fe4:	55                   	push   %ebp
  801fe5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801fe7:	6a 00                	push   $0x0
  801fe9:	6a 00                	push   $0x0
  801feb:	6a 00                	push   $0x0
  801fed:	6a 00                	push   $0x0
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 14                	push   $0x14
  801ff3:	e8 b0 fd ff ff       	call   801da8 <syscall>
  801ff8:	83 c4 18             	add    $0x18,%esp
}
  801ffb:	90                   	nop
  801ffc:	c9                   	leave  
  801ffd:	c3                   	ret    

00801ffe <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801ffe:	55                   	push   %ebp
  801fff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802001:	6a 00                	push   $0x0
  802003:	6a 00                	push   $0x0
  802005:	6a 00                	push   $0x0
  802007:	6a 00                	push   $0x0
  802009:	6a 00                	push   $0x0
  80200b:	6a 15                	push   $0x15
  80200d:	e8 96 fd ff ff       	call   801da8 <syscall>
  802012:	83 c4 18             	add    $0x18,%esp
}
  802015:	90                   	nop
  802016:	c9                   	leave  
  802017:	c3                   	ret    

00802018 <sys_cputc>:


void
sys_cputc(const char c)
{
  802018:	55                   	push   %ebp
  802019:	89 e5                	mov    %esp,%ebp
  80201b:	83 ec 04             	sub    $0x4,%esp
  80201e:	8b 45 08             	mov    0x8(%ebp),%eax
  802021:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802024:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802028:	6a 00                	push   $0x0
  80202a:	6a 00                	push   $0x0
  80202c:	6a 00                	push   $0x0
  80202e:	6a 00                	push   $0x0
  802030:	50                   	push   %eax
  802031:	6a 16                	push   $0x16
  802033:	e8 70 fd ff ff       	call   801da8 <syscall>
  802038:	83 c4 18             	add    $0x18,%esp
}
  80203b:	90                   	nop
  80203c:	c9                   	leave  
  80203d:	c3                   	ret    

0080203e <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80203e:	55                   	push   %ebp
  80203f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802041:	6a 00                	push   $0x0
  802043:	6a 00                	push   $0x0
  802045:	6a 00                	push   $0x0
  802047:	6a 00                	push   $0x0
  802049:	6a 00                	push   $0x0
  80204b:	6a 17                	push   $0x17
  80204d:	e8 56 fd ff ff       	call   801da8 <syscall>
  802052:	83 c4 18             	add    $0x18,%esp
}
  802055:	90                   	nop
  802056:	c9                   	leave  
  802057:	c3                   	ret    

00802058 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802058:	55                   	push   %ebp
  802059:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80205b:	8b 45 08             	mov    0x8(%ebp),%eax
  80205e:	6a 00                	push   $0x0
  802060:	6a 00                	push   $0x0
  802062:	6a 00                	push   $0x0
  802064:	ff 75 0c             	pushl  0xc(%ebp)
  802067:	50                   	push   %eax
  802068:	6a 18                	push   $0x18
  80206a:	e8 39 fd ff ff       	call   801da8 <syscall>
  80206f:	83 c4 18             	add    $0x18,%esp
}
  802072:	c9                   	leave  
  802073:	c3                   	ret    

00802074 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802074:	55                   	push   %ebp
  802075:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802077:	8b 55 0c             	mov    0xc(%ebp),%edx
  80207a:	8b 45 08             	mov    0x8(%ebp),%eax
  80207d:	6a 00                	push   $0x0
  80207f:	6a 00                	push   $0x0
  802081:	6a 00                	push   $0x0
  802083:	52                   	push   %edx
  802084:	50                   	push   %eax
  802085:	6a 1b                	push   $0x1b
  802087:	e8 1c fd ff ff       	call   801da8 <syscall>
  80208c:	83 c4 18             	add    $0x18,%esp
}
  80208f:	c9                   	leave  
  802090:	c3                   	ret    

00802091 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802091:	55                   	push   %ebp
  802092:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802094:	8b 55 0c             	mov    0xc(%ebp),%edx
  802097:	8b 45 08             	mov    0x8(%ebp),%eax
  80209a:	6a 00                	push   $0x0
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	52                   	push   %edx
  8020a1:	50                   	push   %eax
  8020a2:	6a 19                	push   $0x19
  8020a4:	e8 ff fc ff ff       	call   801da8 <syscall>
  8020a9:	83 c4 18             	add    $0x18,%esp
}
  8020ac:	90                   	nop
  8020ad:	c9                   	leave  
  8020ae:	c3                   	ret    

008020af <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8020af:	55                   	push   %ebp
  8020b0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b8:	6a 00                	push   $0x0
  8020ba:	6a 00                	push   $0x0
  8020bc:	6a 00                	push   $0x0
  8020be:	52                   	push   %edx
  8020bf:	50                   	push   %eax
  8020c0:	6a 1a                	push   $0x1a
  8020c2:	e8 e1 fc ff ff       	call   801da8 <syscall>
  8020c7:	83 c4 18             	add    $0x18,%esp
}
  8020ca:	90                   	nop
  8020cb:	c9                   	leave  
  8020cc:	c3                   	ret    

008020cd <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8020cd:	55                   	push   %ebp
  8020ce:	89 e5                	mov    %esp,%ebp
  8020d0:	83 ec 04             	sub    $0x4,%esp
  8020d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8020d6:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8020d9:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8020dc:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8020e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8020e3:	6a 00                	push   $0x0
  8020e5:	51                   	push   %ecx
  8020e6:	52                   	push   %edx
  8020e7:	ff 75 0c             	pushl  0xc(%ebp)
  8020ea:	50                   	push   %eax
  8020eb:	6a 1c                	push   $0x1c
  8020ed:	e8 b6 fc ff ff       	call   801da8 <syscall>
  8020f2:	83 c4 18             	add    $0x18,%esp
}
  8020f5:	c9                   	leave  
  8020f6:	c3                   	ret    

008020f7 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8020f7:	55                   	push   %ebp
  8020f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8020fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020fd:	8b 45 08             	mov    0x8(%ebp),%eax
  802100:	6a 00                	push   $0x0
  802102:	6a 00                	push   $0x0
  802104:	6a 00                	push   $0x0
  802106:	52                   	push   %edx
  802107:	50                   	push   %eax
  802108:	6a 1d                	push   $0x1d
  80210a:	e8 99 fc ff ff       	call   801da8 <syscall>
  80210f:	83 c4 18             	add    $0x18,%esp
}
  802112:	c9                   	leave  
  802113:	c3                   	ret    

00802114 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802114:	55                   	push   %ebp
  802115:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802117:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80211a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80211d:	8b 45 08             	mov    0x8(%ebp),%eax
  802120:	6a 00                	push   $0x0
  802122:	6a 00                	push   $0x0
  802124:	51                   	push   %ecx
  802125:	52                   	push   %edx
  802126:	50                   	push   %eax
  802127:	6a 1e                	push   $0x1e
  802129:	e8 7a fc ff ff       	call   801da8 <syscall>
  80212e:	83 c4 18             	add    $0x18,%esp
}
  802131:	c9                   	leave  
  802132:	c3                   	ret    

00802133 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802133:	55                   	push   %ebp
  802134:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802136:	8b 55 0c             	mov    0xc(%ebp),%edx
  802139:	8b 45 08             	mov    0x8(%ebp),%eax
  80213c:	6a 00                	push   $0x0
  80213e:	6a 00                	push   $0x0
  802140:	6a 00                	push   $0x0
  802142:	52                   	push   %edx
  802143:	50                   	push   %eax
  802144:	6a 1f                	push   $0x1f
  802146:	e8 5d fc ff ff       	call   801da8 <syscall>
  80214b:	83 c4 18             	add    $0x18,%esp
}
  80214e:	c9                   	leave  
  80214f:	c3                   	ret    

00802150 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802150:	55                   	push   %ebp
  802151:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802153:	6a 00                	push   $0x0
  802155:	6a 00                	push   $0x0
  802157:	6a 00                	push   $0x0
  802159:	6a 00                	push   $0x0
  80215b:	6a 00                	push   $0x0
  80215d:	6a 20                	push   $0x20
  80215f:	e8 44 fc ff ff       	call   801da8 <syscall>
  802164:	83 c4 18             	add    $0x18,%esp
}
  802167:	c9                   	leave  
  802168:	c3                   	ret    

00802169 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802169:	55                   	push   %ebp
  80216a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80216c:	8b 45 08             	mov    0x8(%ebp),%eax
  80216f:	6a 00                	push   $0x0
  802171:	ff 75 14             	pushl  0x14(%ebp)
  802174:	ff 75 10             	pushl  0x10(%ebp)
  802177:	ff 75 0c             	pushl  0xc(%ebp)
  80217a:	50                   	push   %eax
  80217b:	6a 21                	push   $0x21
  80217d:	e8 26 fc ff ff       	call   801da8 <syscall>
  802182:	83 c4 18             	add    $0x18,%esp
}
  802185:	c9                   	leave  
  802186:	c3                   	ret    

00802187 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802187:	55                   	push   %ebp
  802188:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80218a:	8b 45 08             	mov    0x8(%ebp),%eax
  80218d:	6a 00                	push   $0x0
  80218f:	6a 00                	push   $0x0
  802191:	6a 00                	push   $0x0
  802193:	6a 00                	push   $0x0
  802195:	50                   	push   %eax
  802196:	6a 22                	push   $0x22
  802198:	e8 0b fc ff ff       	call   801da8 <syscall>
  80219d:	83 c4 18             	add    $0x18,%esp
}
  8021a0:	90                   	nop
  8021a1:	c9                   	leave  
  8021a2:	c3                   	ret    

008021a3 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8021a3:	55                   	push   %ebp
  8021a4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8021a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	6a 00                	push   $0x0
  8021af:	6a 00                	push   $0x0
  8021b1:	50                   	push   %eax
  8021b2:	6a 23                	push   $0x23
  8021b4:	e8 ef fb ff ff       	call   801da8 <syscall>
  8021b9:	83 c4 18             	add    $0x18,%esp
}
  8021bc:	90                   	nop
  8021bd:	c9                   	leave  
  8021be:	c3                   	ret    

008021bf <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8021bf:	55                   	push   %ebp
  8021c0:	89 e5                	mov    %esp,%ebp
  8021c2:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8021c5:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8021c8:	8d 50 04             	lea    0x4(%eax),%edx
  8021cb:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8021ce:	6a 00                	push   $0x0
  8021d0:	6a 00                	push   $0x0
  8021d2:	6a 00                	push   $0x0
  8021d4:	52                   	push   %edx
  8021d5:	50                   	push   %eax
  8021d6:	6a 24                	push   $0x24
  8021d8:	e8 cb fb ff ff       	call   801da8 <syscall>
  8021dd:	83 c4 18             	add    $0x18,%esp
	return result;
  8021e0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8021e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021e6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8021e9:	89 01                	mov    %eax,(%ecx)
  8021eb:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8021ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8021f1:	c9                   	leave  
  8021f2:	c2 04 00             	ret    $0x4

008021f5 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8021f5:	55                   	push   %ebp
  8021f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8021f8:	6a 00                	push   $0x0
  8021fa:	6a 00                	push   $0x0
  8021fc:	ff 75 10             	pushl  0x10(%ebp)
  8021ff:	ff 75 0c             	pushl  0xc(%ebp)
  802202:	ff 75 08             	pushl  0x8(%ebp)
  802205:	6a 13                	push   $0x13
  802207:	e8 9c fb ff ff       	call   801da8 <syscall>
  80220c:	83 c4 18             	add    $0x18,%esp
	return ;
  80220f:	90                   	nop
}
  802210:	c9                   	leave  
  802211:	c3                   	ret    

00802212 <sys_rcr2>:
uint32 sys_rcr2()
{
  802212:	55                   	push   %ebp
  802213:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802215:	6a 00                	push   $0x0
  802217:	6a 00                	push   $0x0
  802219:	6a 00                	push   $0x0
  80221b:	6a 00                	push   $0x0
  80221d:	6a 00                	push   $0x0
  80221f:	6a 25                	push   $0x25
  802221:	e8 82 fb ff ff       	call   801da8 <syscall>
  802226:	83 c4 18             	add    $0x18,%esp
}
  802229:	c9                   	leave  
  80222a:	c3                   	ret    

0080222b <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80222b:	55                   	push   %ebp
  80222c:	89 e5                	mov    %esp,%ebp
  80222e:	83 ec 04             	sub    $0x4,%esp
  802231:	8b 45 08             	mov    0x8(%ebp),%eax
  802234:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802237:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80223b:	6a 00                	push   $0x0
  80223d:	6a 00                	push   $0x0
  80223f:	6a 00                	push   $0x0
  802241:	6a 00                	push   $0x0
  802243:	50                   	push   %eax
  802244:	6a 26                	push   $0x26
  802246:	e8 5d fb ff ff       	call   801da8 <syscall>
  80224b:	83 c4 18             	add    $0x18,%esp
	return ;
  80224e:	90                   	nop
}
  80224f:	c9                   	leave  
  802250:	c3                   	ret    

00802251 <rsttst>:
void rsttst()
{
  802251:	55                   	push   %ebp
  802252:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802254:	6a 00                	push   $0x0
  802256:	6a 00                	push   $0x0
  802258:	6a 00                	push   $0x0
  80225a:	6a 00                	push   $0x0
  80225c:	6a 00                	push   $0x0
  80225e:	6a 28                	push   $0x28
  802260:	e8 43 fb ff ff       	call   801da8 <syscall>
  802265:	83 c4 18             	add    $0x18,%esp
	return ;
  802268:	90                   	nop
}
  802269:	c9                   	leave  
  80226a:	c3                   	ret    

0080226b <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80226b:	55                   	push   %ebp
  80226c:	89 e5                	mov    %esp,%ebp
  80226e:	83 ec 04             	sub    $0x4,%esp
  802271:	8b 45 14             	mov    0x14(%ebp),%eax
  802274:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802277:	8b 55 18             	mov    0x18(%ebp),%edx
  80227a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80227e:	52                   	push   %edx
  80227f:	50                   	push   %eax
  802280:	ff 75 10             	pushl  0x10(%ebp)
  802283:	ff 75 0c             	pushl  0xc(%ebp)
  802286:	ff 75 08             	pushl  0x8(%ebp)
  802289:	6a 27                	push   $0x27
  80228b:	e8 18 fb ff ff       	call   801da8 <syscall>
  802290:	83 c4 18             	add    $0x18,%esp
	return ;
  802293:	90                   	nop
}
  802294:	c9                   	leave  
  802295:	c3                   	ret    

00802296 <chktst>:
void chktst(uint32 n)
{
  802296:	55                   	push   %ebp
  802297:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802299:	6a 00                	push   $0x0
  80229b:	6a 00                	push   $0x0
  80229d:	6a 00                	push   $0x0
  80229f:	6a 00                	push   $0x0
  8022a1:	ff 75 08             	pushl  0x8(%ebp)
  8022a4:	6a 29                	push   $0x29
  8022a6:	e8 fd fa ff ff       	call   801da8 <syscall>
  8022ab:	83 c4 18             	add    $0x18,%esp
	return ;
  8022ae:	90                   	nop
}
  8022af:	c9                   	leave  
  8022b0:	c3                   	ret    

008022b1 <inctst>:

void inctst()
{
  8022b1:	55                   	push   %ebp
  8022b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8022b4:	6a 00                	push   $0x0
  8022b6:	6a 00                	push   $0x0
  8022b8:	6a 00                	push   $0x0
  8022ba:	6a 00                	push   $0x0
  8022bc:	6a 00                	push   $0x0
  8022be:	6a 2a                	push   $0x2a
  8022c0:	e8 e3 fa ff ff       	call   801da8 <syscall>
  8022c5:	83 c4 18             	add    $0x18,%esp
	return ;
  8022c8:	90                   	nop
}
  8022c9:	c9                   	leave  
  8022ca:	c3                   	ret    

008022cb <gettst>:
uint32 gettst()
{
  8022cb:	55                   	push   %ebp
  8022cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8022ce:	6a 00                	push   $0x0
  8022d0:	6a 00                	push   $0x0
  8022d2:	6a 00                	push   $0x0
  8022d4:	6a 00                	push   $0x0
  8022d6:	6a 00                	push   $0x0
  8022d8:	6a 2b                	push   $0x2b
  8022da:	e8 c9 fa ff ff       	call   801da8 <syscall>
  8022df:	83 c4 18             	add    $0x18,%esp
}
  8022e2:	c9                   	leave  
  8022e3:	c3                   	ret    

008022e4 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8022e4:	55                   	push   %ebp
  8022e5:	89 e5                	mov    %esp,%ebp
  8022e7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022ea:	6a 00                	push   $0x0
  8022ec:	6a 00                	push   $0x0
  8022ee:	6a 00                	push   $0x0
  8022f0:	6a 00                	push   $0x0
  8022f2:	6a 00                	push   $0x0
  8022f4:	6a 2c                	push   $0x2c
  8022f6:	e8 ad fa ff ff       	call   801da8 <syscall>
  8022fb:	83 c4 18             	add    $0x18,%esp
  8022fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802301:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802305:	75 07                	jne    80230e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802307:	b8 01 00 00 00       	mov    $0x1,%eax
  80230c:	eb 05                	jmp    802313 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80230e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802313:	c9                   	leave  
  802314:	c3                   	ret    

00802315 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802315:	55                   	push   %ebp
  802316:	89 e5                	mov    %esp,%ebp
  802318:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80231b:	6a 00                	push   $0x0
  80231d:	6a 00                	push   $0x0
  80231f:	6a 00                	push   $0x0
  802321:	6a 00                	push   $0x0
  802323:	6a 00                	push   $0x0
  802325:	6a 2c                	push   $0x2c
  802327:	e8 7c fa ff ff       	call   801da8 <syscall>
  80232c:	83 c4 18             	add    $0x18,%esp
  80232f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802332:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802336:	75 07                	jne    80233f <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802338:	b8 01 00 00 00       	mov    $0x1,%eax
  80233d:	eb 05                	jmp    802344 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80233f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802344:	c9                   	leave  
  802345:	c3                   	ret    

00802346 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802346:	55                   	push   %ebp
  802347:	89 e5                	mov    %esp,%ebp
  802349:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80234c:	6a 00                	push   $0x0
  80234e:	6a 00                	push   $0x0
  802350:	6a 00                	push   $0x0
  802352:	6a 00                	push   $0x0
  802354:	6a 00                	push   $0x0
  802356:	6a 2c                	push   $0x2c
  802358:	e8 4b fa ff ff       	call   801da8 <syscall>
  80235d:	83 c4 18             	add    $0x18,%esp
  802360:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802363:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802367:	75 07                	jne    802370 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802369:	b8 01 00 00 00       	mov    $0x1,%eax
  80236e:	eb 05                	jmp    802375 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802370:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802375:	c9                   	leave  
  802376:	c3                   	ret    

00802377 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802377:	55                   	push   %ebp
  802378:	89 e5                	mov    %esp,%ebp
  80237a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80237d:	6a 00                	push   $0x0
  80237f:	6a 00                	push   $0x0
  802381:	6a 00                	push   $0x0
  802383:	6a 00                	push   $0x0
  802385:	6a 00                	push   $0x0
  802387:	6a 2c                	push   $0x2c
  802389:	e8 1a fa ff ff       	call   801da8 <syscall>
  80238e:	83 c4 18             	add    $0x18,%esp
  802391:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802394:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802398:	75 07                	jne    8023a1 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80239a:	b8 01 00 00 00       	mov    $0x1,%eax
  80239f:	eb 05                	jmp    8023a6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8023a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023a6:	c9                   	leave  
  8023a7:	c3                   	ret    

008023a8 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8023a8:	55                   	push   %ebp
  8023a9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8023ab:	6a 00                	push   $0x0
  8023ad:	6a 00                	push   $0x0
  8023af:	6a 00                	push   $0x0
  8023b1:	6a 00                	push   $0x0
  8023b3:	ff 75 08             	pushl  0x8(%ebp)
  8023b6:	6a 2d                	push   $0x2d
  8023b8:	e8 eb f9 ff ff       	call   801da8 <syscall>
  8023bd:	83 c4 18             	add    $0x18,%esp
	return ;
  8023c0:	90                   	nop
}
  8023c1:	c9                   	leave  
  8023c2:	c3                   	ret    

008023c3 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8023c3:	55                   	push   %ebp
  8023c4:	89 e5                	mov    %esp,%ebp
  8023c6:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8023c7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8023ca:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8023cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8023d3:	6a 00                	push   $0x0
  8023d5:	53                   	push   %ebx
  8023d6:	51                   	push   %ecx
  8023d7:	52                   	push   %edx
  8023d8:	50                   	push   %eax
  8023d9:	6a 2e                	push   $0x2e
  8023db:	e8 c8 f9 ff ff       	call   801da8 <syscall>
  8023e0:	83 c4 18             	add    $0x18,%esp
}
  8023e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8023e6:	c9                   	leave  
  8023e7:	c3                   	ret    

008023e8 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8023e8:	55                   	push   %ebp
  8023e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8023eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8023f1:	6a 00                	push   $0x0
  8023f3:	6a 00                	push   $0x0
  8023f5:	6a 00                	push   $0x0
  8023f7:	52                   	push   %edx
  8023f8:	50                   	push   %eax
  8023f9:	6a 2f                	push   $0x2f
  8023fb:	e8 a8 f9 ff ff       	call   801da8 <syscall>
  802400:	83 c4 18             	add    $0x18,%esp
}
  802403:	c9                   	leave  
  802404:	c3                   	ret    
  802405:	66 90                	xchg   %ax,%ax
  802407:	90                   	nop

00802408 <__udivdi3>:
  802408:	55                   	push   %ebp
  802409:	57                   	push   %edi
  80240a:	56                   	push   %esi
  80240b:	53                   	push   %ebx
  80240c:	83 ec 1c             	sub    $0x1c,%esp
  80240f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802413:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802417:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80241b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80241f:	89 ca                	mov    %ecx,%edx
  802421:	89 f8                	mov    %edi,%eax
  802423:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802427:	85 f6                	test   %esi,%esi
  802429:	75 2d                	jne    802458 <__udivdi3+0x50>
  80242b:	39 cf                	cmp    %ecx,%edi
  80242d:	77 65                	ja     802494 <__udivdi3+0x8c>
  80242f:	89 fd                	mov    %edi,%ebp
  802431:	85 ff                	test   %edi,%edi
  802433:	75 0b                	jne    802440 <__udivdi3+0x38>
  802435:	b8 01 00 00 00       	mov    $0x1,%eax
  80243a:	31 d2                	xor    %edx,%edx
  80243c:	f7 f7                	div    %edi
  80243e:	89 c5                	mov    %eax,%ebp
  802440:	31 d2                	xor    %edx,%edx
  802442:	89 c8                	mov    %ecx,%eax
  802444:	f7 f5                	div    %ebp
  802446:	89 c1                	mov    %eax,%ecx
  802448:	89 d8                	mov    %ebx,%eax
  80244a:	f7 f5                	div    %ebp
  80244c:	89 cf                	mov    %ecx,%edi
  80244e:	89 fa                	mov    %edi,%edx
  802450:	83 c4 1c             	add    $0x1c,%esp
  802453:	5b                   	pop    %ebx
  802454:	5e                   	pop    %esi
  802455:	5f                   	pop    %edi
  802456:	5d                   	pop    %ebp
  802457:	c3                   	ret    
  802458:	39 ce                	cmp    %ecx,%esi
  80245a:	77 28                	ja     802484 <__udivdi3+0x7c>
  80245c:	0f bd fe             	bsr    %esi,%edi
  80245f:	83 f7 1f             	xor    $0x1f,%edi
  802462:	75 40                	jne    8024a4 <__udivdi3+0x9c>
  802464:	39 ce                	cmp    %ecx,%esi
  802466:	72 0a                	jb     802472 <__udivdi3+0x6a>
  802468:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80246c:	0f 87 9e 00 00 00    	ja     802510 <__udivdi3+0x108>
  802472:	b8 01 00 00 00       	mov    $0x1,%eax
  802477:	89 fa                	mov    %edi,%edx
  802479:	83 c4 1c             	add    $0x1c,%esp
  80247c:	5b                   	pop    %ebx
  80247d:	5e                   	pop    %esi
  80247e:	5f                   	pop    %edi
  80247f:	5d                   	pop    %ebp
  802480:	c3                   	ret    
  802481:	8d 76 00             	lea    0x0(%esi),%esi
  802484:	31 ff                	xor    %edi,%edi
  802486:	31 c0                	xor    %eax,%eax
  802488:	89 fa                	mov    %edi,%edx
  80248a:	83 c4 1c             	add    $0x1c,%esp
  80248d:	5b                   	pop    %ebx
  80248e:	5e                   	pop    %esi
  80248f:	5f                   	pop    %edi
  802490:	5d                   	pop    %ebp
  802491:	c3                   	ret    
  802492:	66 90                	xchg   %ax,%ax
  802494:	89 d8                	mov    %ebx,%eax
  802496:	f7 f7                	div    %edi
  802498:	31 ff                	xor    %edi,%edi
  80249a:	89 fa                	mov    %edi,%edx
  80249c:	83 c4 1c             	add    $0x1c,%esp
  80249f:	5b                   	pop    %ebx
  8024a0:	5e                   	pop    %esi
  8024a1:	5f                   	pop    %edi
  8024a2:	5d                   	pop    %ebp
  8024a3:	c3                   	ret    
  8024a4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8024a9:	89 eb                	mov    %ebp,%ebx
  8024ab:	29 fb                	sub    %edi,%ebx
  8024ad:	89 f9                	mov    %edi,%ecx
  8024af:	d3 e6                	shl    %cl,%esi
  8024b1:	89 c5                	mov    %eax,%ebp
  8024b3:	88 d9                	mov    %bl,%cl
  8024b5:	d3 ed                	shr    %cl,%ebp
  8024b7:	89 e9                	mov    %ebp,%ecx
  8024b9:	09 f1                	or     %esi,%ecx
  8024bb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8024bf:	89 f9                	mov    %edi,%ecx
  8024c1:	d3 e0                	shl    %cl,%eax
  8024c3:	89 c5                	mov    %eax,%ebp
  8024c5:	89 d6                	mov    %edx,%esi
  8024c7:	88 d9                	mov    %bl,%cl
  8024c9:	d3 ee                	shr    %cl,%esi
  8024cb:	89 f9                	mov    %edi,%ecx
  8024cd:	d3 e2                	shl    %cl,%edx
  8024cf:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024d3:	88 d9                	mov    %bl,%cl
  8024d5:	d3 e8                	shr    %cl,%eax
  8024d7:	09 c2                	or     %eax,%edx
  8024d9:	89 d0                	mov    %edx,%eax
  8024db:	89 f2                	mov    %esi,%edx
  8024dd:	f7 74 24 0c          	divl   0xc(%esp)
  8024e1:	89 d6                	mov    %edx,%esi
  8024e3:	89 c3                	mov    %eax,%ebx
  8024e5:	f7 e5                	mul    %ebp
  8024e7:	39 d6                	cmp    %edx,%esi
  8024e9:	72 19                	jb     802504 <__udivdi3+0xfc>
  8024eb:	74 0b                	je     8024f8 <__udivdi3+0xf0>
  8024ed:	89 d8                	mov    %ebx,%eax
  8024ef:	31 ff                	xor    %edi,%edi
  8024f1:	e9 58 ff ff ff       	jmp    80244e <__udivdi3+0x46>
  8024f6:	66 90                	xchg   %ax,%ax
  8024f8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8024fc:	89 f9                	mov    %edi,%ecx
  8024fe:	d3 e2                	shl    %cl,%edx
  802500:	39 c2                	cmp    %eax,%edx
  802502:	73 e9                	jae    8024ed <__udivdi3+0xe5>
  802504:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802507:	31 ff                	xor    %edi,%edi
  802509:	e9 40 ff ff ff       	jmp    80244e <__udivdi3+0x46>
  80250e:	66 90                	xchg   %ax,%ax
  802510:	31 c0                	xor    %eax,%eax
  802512:	e9 37 ff ff ff       	jmp    80244e <__udivdi3+0x46>
  802517:	90                   	nop

00802518 <__umoddi3>:
  802518:	55                   	push   %ebp
  802519:	57                   	push   %edi
  80251a:	56                   	push   %esi
  80251b:	53                   	push   %ebx
  80251c:	83 ec 1c             	sub    $0x1c,%esp
  80251f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802523:	8b 74 24 34          	mov    0x34(%esp),%esi
  802527:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80252b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80252f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802533:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802537:	89 f3                	mov    %esi,%ebx
  802539:	89 fa                	mov    %edi,%edx
  80253b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80253f:	89 34 24             	mov    %esi,(%esp)
  802542:	85 c0                	test   %eax,%eax
  802544:	75 1a                	jne    802560 <__umoddi3+0x48>
  802546:	39 f7                	cmp    %esi,%edi
  802548:	0f 86 a2 00 00 00    	jbe    8025f0 <__umoddi3+0xd8>
  80254e:	89 c8                	mov    %ecx,%eax
  802550:	89 f2                	mov    %esi,%edx
  802552:	f7 f7                	div    %edi
  802554:	89 d0                	mov    %edx,%eax
  802556:	31 d2                	xor    %edx,%edx
  802558:	83 c4 1c             	add    $0x1c,%esp
  80255b:	5b                   	pop    %ebx
  80255c:	5e                   	pop    %esi
  80255d:	5f                   	pop    %edi
  80255e:	5d                   	pop    %ebp
  80255f:	c3                   	ret    
  802560:	39 f0                	cmp    %esi,%eax
  802562:	0f 87 ac 00 00 00    	ja     802614 <__umoddi3+0xfc>
  802568:	0f bd e8             	bsr    %eax,%ebp
  80256b:	83 f5 1f             	xor    $0x1f,%ebp
  80256e:	0f 84 ac 00 00 00    	je     802620 <__umoddi3+0x108>
  802574:	bf 20 00 00 00       	mov    $0x20,%edi
  802579:	29 ef                	sub    %ebp,%edi
  80257b:	89 fe                	mov    %edi,%esi
  80257d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802581:	89 e9                	mov    %ebp,%ecx
  802583:	d3 e0                	shl    %cl,%eax
  802585:	89 d7                	mov    %edx,%edi
  802587:	89 f1                	mov    %esi,%ecx
  802589:	d3 ef                	shr    %cl,%edi
  80258b:	09 c7                	or     %eax,%edi
  80258d:	89 e9                	mov    %ebp,%ecx
  80258f:	d3 e2                	shl    %cl,%edx
  802591:	89 14 24             	mov    %edx,(%esp)
  802594:	89 d8                	mov    %ebx,%eax
  802596:	d3 e0                	shl    %cl,%eax
  802598:	89 c2                	mov    %eax,%edx
  80259a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80259e:	d3 e0                	shl    %cl,%eax
  8025a0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8025a4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8025a8:	89 f1                	mov    %esi,%ecx
  8025aa:	d3 e8                	shr    %cl,%eax
  8025ac:	09 d0                	or     %edx,%eax
  8025ae:	d3 eb                	shr    %cl,%ebx
  8025b0:	89 da                	mov    %ebx,%edx
  8025b2:	f7 f7                	div    %edi
  8025b4:	89 d3                	mov    %edx,%ebx
  8025b6:	f7 24 24             	mull   (%esp)
  8025b9:	89 c6                	mov    %eax,%esi
  8025bb:	89 d1                	mov    %edx,%ecx
  8025bd:	39 d3                	cmp    %edx,%ebx
  8025bf:	0f 82 87 00 00 00    	jb     80264c <__umoddi3+0x134>
  8025c5:	0f 84 91 00 00 00    	je     80265c <__umoddi3+0x144>
  8025cb:	8b 54 24 04          	mov    0x4(%esp),%edx
  8025cf:	29 f2                	sub    %esi,%edx
  8025d1:	19 cb                	sbb    %ecx,%ebx
  8025d3:	89 d8                	mov    %ebx,%eax
  8025d5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8025d9:	d3 e0                	shl    %cl,%eax
  8025db:	89 e9                	mov    %ebp,%ecx
  8025dd:	d3 ea                	shr    %cl,%edx
  8025df:	09 d0                	or     %edx,%eax
  8025e1:	89 e9                	mov    %ebp,%ecx
  8025e3:	d3 eb                	shr    %cl,%ebx
  8025e5:	89 da                	mov    %ebx,%edx
  8025e7:	83 c4 1c             	add    $0x1c,%esp
  8025ea:	5b                   	pop    %ebx
  8025eb:	5e                   	pop    %esi
  8025ec:	5f                   	pop    %edi
  8025ed:	5d                   	pop    %ebp
  8025ee:	c3                   	ret    
  8025ef:	90                   	nop
  8025f0:	89 fd                	mov    %edi,%ebp
  8025f2:	85 ff                	test   %edi,%edi
  8025f4:	75 0b                	jne    802601 <__umoddi3+0xe9>
  8025f6:	b8 01 00 00 00       	mov    $0x1,%eax
  8025fb:	31 d2                	xor    %edx,%edx
  8025fd:	f7 f7                	div    %edi
  8025ff:	89 c5                	mov    %eax,%ebp
  802601:	89 f0                	mov    %esi,%eax
  802603:	31 d2                	xor    %edx,%edx
  802605:	f7 f5                	div    %ebp
  802607:	89 c8                	mov    %ecx,%eax
  802609:	f7 f5                	div    %ebp
  80260b:	89 d0                	mov    %edx,%eax
  80260d:	e9 44 ff ff ff       	jmp    802556 <__umoddi3+0x3e>
  802612:	66 90                	xchg   %ax,%ax
  802614:	89 c8                	mov    %ecx,%eax
  802616:	89 f2                	mov    %esi,%edx
  802618:	83 c4 1c             	add    $0x1c,%esp
  80261b:	5b                   	pop    %ebx
  80261c:	5e                   	pop    %esi
  80261d:	5f                   	pop    %edi
  80261e:	5d                   	pop    %ebp
  80261f:	c3                   	ret    
  802620:	3b 04 24             	cmp    (%esp),%eax
  802623:	72 06                	jb     80262b <__umoddi3+0x113>
  802625:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802629:	77 0f                	ja     80263a <__umoddi3+0x122>
  80262b:	89 f2                	mov    %esi,%edx
  80262d:	29 f9                	sub    %edi,%ecx
  80262f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802633:	89 14 24             	mov    %edx,(%esp)
  802636:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80263a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80263e:	8b 14 24             	mov    (%esp),%edx
  802641:	83 c4 1c             	add    $0x1c,%esp
  802644:	5b                   	pop    %ebx
  802645:	5e                   	pop    %esi
  802646:	5f                   	pop    %edi
  802647:	5d                   	pop    %ebp
  802648:	c3                   	ret    
  802649:	8d 76 00             	lea    0x0(%esi),%esi
  80264c:	2b 04 24             	sub    (%esp),%eax
  80264f:	19 fa                	sbb    %edi,%edx
  802651:	89 d1                	mov    %edx,%ecx
  802653:	89 c6                	mov    %eax,%esi
  802655:	e9 71 ff ff ff       	jmp    8025cb <__umoddi3+0xb3>
  80265a:	66 90                	xchg   %ax,%ax
  80265c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802660:	72 ea                	jb     80264c <__umoddi3+0x134>
  802662:	89 d9                	mov    %ebx,%ecx
  802664:	e9 62 ff ff ff       	jmp    8025cb <__umoddi3+0xb3>
