
obj/user/quicksort_freeheap:     file format elf32-i386


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
  800031:	e8 b4 05 00 00       	call   8005ea <libmain>
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
  800049:	e8 f9 1d 00 00       	call   801e47 <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 0b 1e 00 00       	call   801e60 <sys_calculate_modified_frames>
  800055:	01 d8                	add    %ebx,%eax
  800057:	89 45 f0             	mov    %eax,-0x10(%ebp)

		Iteration++ ;
  80005a:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

		//	sys_disable_interrupt();

		readline("Enter the number of elements: ", Line);
  80005d:	83 ec 08             	sub    $0x8,%esp
  800060:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800066:	50                   	push   %eax
  800067:	68 a0 25 80 00       	push   $0x8025a0
  80006c:	e8 e2 0f 00 00       	call   801053 <readline>
  800071:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  800074:	83 ec 04             	sub    $0x4,%esp
  800077:	6a 0a                	push   $0xa
  800079:	6a 00                	push   $0x0
  80007b:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800081:	50                   	push   %eax
  800082:	e8 32 15 00 00       	call   8015b9 <strtol>
  800087:	83 c4 10             	add    $0x10,%esp
  80008a:	89 45 ec             	mov    %eax,-0x14(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  80008d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800090:	c1 e0 02             	shl    $0x2,%eax
  800093:	83 ec 0c             	sub    $0xc,%esp
  800096:	50                   	push   %eax
  800097:	e8 c5 18 00 00       	call   801961 <malloc>
  80009c:	83 c4 10             	add    $0x10,%esp
  80009f:	89 45 e8             	mov    %eax,-0x18(%ebp)
		cprintf("Choose the initialization method:\n") ;
  8000a2:	83 ec 0c             	sub    $0xc,%esp
  8000a5:	68 c0 25 80 00       	push   $0x8025c0
  8000aa:	e8 22 09 00 00       	call   8009d1 <cprintf>
  8000af:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000b2:	83 ec 0c             	sub    $0xc,%esp
  8000b5:	68 e3 25 80 00       	push   $0x8025e3
  8000ba:	e8 12 09 00 00       	call   8009d1 <cprintf>
  8000bf:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000c2:	83 ec 0c             	sub    $0xc,%esp
  8000c5:	68 f1 25 80 00       	push   $0x8025f1
  8000ca:	e8 02 09 00 00       	call   8009d1 <cprintf>
  8000cf:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  8000d2:	83 ec 0c             	sub    $0xc,%esp
  8000d5:	68 00 26 80 00       	push   $0x802600
  8000da:	e8 f2 08 00 00       	call   8009d1 <cprintf>
  8000df:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  8000e2:	83 ec 0c             	sub    $0xc,%esp
  8000e5:	68 10 26 80 00       	push   $0x802610
  8000ea:	e8 e2 08 00 00       	call   8009d1 <cprintf>
  8000ef:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  8000f2:	e8 9b 04 00 00       	call   800592 <getchar>
  8000f7:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  8000fa:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  8000fe:	83 ec 0c             	sub    $0xc,%esp
  800101:	50                   	push   %eax
  800102:	e8 43 04 00 00       	call   80054a <cputchar>
  800107:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80010a:	83 ec 0c             	sub    $0xc,%esp
  80010d:	6a 0a                	push   $0xa
  80010f:	e8 36 04 00 00       	call   80054a <cputchar>
  800114:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800117:	80 7d e7 61          	cmpb   $0x61,-0x19(%ebp)
  80011b:	74 0c                	je     800129 <_main+0xf1>
  80011d:	80 7d e7 62          	cmpb   $0x62,-0x19(%ebp)
  800121:	74 06                	je     800129 <_main+0xf1>
  800123:	80 7d e7 63          	cmpb   $0x63,-0x19(%ebp)
  800127:	75 b9                	jne    8000e2 <_main+0xaa>
		//sys_enable_interrupt();
		int  i ;
		switch (Chose)
  800129:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  80012d:	83 f8 62             	cmp    $0x62,%eax
  800130:	74 1d                	je     80014f <_main+0x117>
  800132:	83 f8 63             	cmp    $0x63,%eax
  800135:	74 2b                	je     800162 <_main+0x12a>
  800137:	83 f8 61             	cmp    $0x61,%eax
  80013a:	75 39                	jne    800175 <_main+0x13d>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80013c:	83 ec 08             	sub    $0x8,%esp
  80013f:	ff 75 ec             	pushl  -0x14(%ebp)
  800142:	ff 75 e8             	pushl  -0x18(%ebp)
  800145:	e8 c8 02 00 00       	call   800412 <InitializeAscending>
  80014a:	83 c4 10             	add    $0x10,%esp
			break ;
  80014d:	eb 37                	jmp    800186 <_main+0x14e>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80014f:	83 ec 08             	sub    $0x8,%esp
  800152:	ff 75 ec             	pushl  -0x14(%ebp)
  800155:	ff 75 e8             	pushl  -0x18(%ebp)
  800158:	e8 e6 02 00 00       	call   800443 <InitializeDescending>
  80015d:	83 c4 10             	add    $0x10,%esp
			break ;
  800160:	eb 24                	jmp    800186 <_main+0x14e>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800162:	83 ec 08             	sub    $0x8,%esp
  800165:	ff 75 ec             	pushl  -0x14(%ebp)
  800168:	ff 75 e8             	pushl  -0x18(%ebp)
  80016b:	e8 08 03 00 00       	call   800478 <InitializeSemiRandom>
  800170:	83 c4 10             	add    $0x10,%esp
			break ;
  800173:	eb 11                	jmp    800186 <_main+0x14e>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800175:	83 ec 08             	sub    $0x8,%esp
  800178:	ff 75 ec             	pushl  -0x14(%ebp)
  80017b:	ff 75 e8             	pushl  -0x18(%ebp)
  80017e:	e8 f5 02 00 00       	call   800478 <InitializeSemiRandom>
  800183:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  800186:	83 ec 08             	sub    $0x8,%esp
  800189:	ff 75 ec             	pushl  -0x14(%ebp)
  80018c:	ff 75 e8             	pushl  -0x18(%ebp)
  80018f:	e8 c3 00 00 00       	call   800257 <QuickSort>
  800194:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800197:	83 ec 08             	sub    $0x8,%esp
  80019a:	ff 75 ec             	pushl  -0x14(%ebp)
  80019d:	ff 75 e8             	pushl  -0x18(%ebp)
  8001a0:	e8 c3 01 00 00       	call   800368 <CheckSorted>
  8001a5:	83 c4 10             	add    $0x10,%esp
  8001a8:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001ab:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8001af:	75 14                	jne    8001c5 <_main+0x18d>
  8001b1:	83 ec 04             	sub    $0x4,%esp
  8001b4:	68 1c 26 80 00       	push   $0x80261c
  8001b9:	6a 45                	push   $0x45
  8001bb:	68 3e 26 80 00       	push   $0x80263e
  8001c0:	e8 6a 05 00 00       	call   80072f <_panic>
		else
		{ 
			cprintf("===============================================\n") ;
  8001c5:	83 ec 0c             	sub    $0xc,%esp
  8001c8:	68 58 26 80 00       	push   $0x802658
  8001cd:	e8 ff 07 00 00       	call   8009d1 <cprintf>
  8001d2:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001d5:	83 ec 0c             	sub    $0xc,%esp
  8001d8:	68 8c 26 80 00       	push   $0x80268c
  8001dd:	e8 ef 07 00 00       	call   8009d1 <cprintf>
  8001e2:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  8001e5:	83 ec 0c             	sub    $0xc,%esp
  8001e8:	68 c0 26 80 00       	push   $0x8026c0
  8001ed:	e8 df 07 00 00       	call   8009d1 <cprintf>
  8001f2:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		cprintf("Freeing the Heap...\n\n") ;
  8001f5:	83 ec 0c             	sub    $0xc,%esp
  8001f8:	68 f2 26 80 00       	push   $0x8026f2
  8001fd:	e8 cf 07 00 00       	call   8009d1 <cprintf>
  800202:	83 c4 10             	add    $0x10,%esp

		//freeHeap() ;

		///========================================================================
		//sys_disable_interrupt();
		cprintf("Do you want to repeat (y/n): ") ;
  800205:	83 ec 0c             	sub    $0xc,%esp
  800208:	68 08 27 80 00       	push   $0x802708
  80020d:	e8 bf 07 00 00       	call   8009d1 <cprintf>
  800212:	83 c4 10             	add    $0x10,%esp
		Chose = getchar() ;
  800215:	e8 78 03 00 00       	call   800592 <getchar>
  80021a:	88 45 e7             	mov    %al,-0x19(%ebp)
		cputchar(Chose);
  80021d:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  800221:	83 ec 0c             	sub    $0xc,%esp
  800224:	50                   	push   %eax
  800225:	e8 20 03 00 00       	call   80054a <cputchar>
  80022a:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  80022d:	83 ec 0c             	sub    $0xc,%esp
  800230:	6a 0a                	push   $0xa
  800232:	e8 13 03 00 00       	call   80054a <cputchar>
  800237:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  80023a:	83 ec 0c             	sub    $0xc,%esp
  80023d:	6a 0a                	push   $0xa
  80023f:	e8 06 03 00 00       	call   80054a <cputchar>
  800244:	83 c4 10             	add    $0x10,%esp
		//sys_enable_interrupt();

	} while (Chose == 'y');
  800247:	80 7d e7 79          	cmpb   $0x79,-0x19(%ebp)
  80024b:	0f 84 f8 fd ff ff    	je     800049 <_main+0x11>

}
  800251:	90                   	nop
  800252:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800255:	c9                   	leave  
  800256:	c3                   	ret    

00800257 <QuickSort>:

///Quick sort 
void QuickSort(int *Elements, int NumOfElements)
{
  800257:	55                   	push   %ebp
  800258:	89 e5                	mov    %esp,%ebp
  80025a:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  80025d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800260:	48                   	dec    %eax
  800261:	50                   	push   %eax
  800262:	6a 00                	push   $0x0
  800264:	ff 75 0c             	pushl  0xc(%ebp)
  800267:	ff 75 08             	pushl  0x8(%ebp)
  80026a:	e8 06 00 00 00       	call   800275 <QSort>
  80026f:	83 c4 10             	add    $0x10,%esp
}
  800272:	90                   	nop
  800273:	c9                   	leave  
  800274:	c3                   	ret    

00800275 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800275:	55                   	push   %ebp
  800276:	89 e5                	mov    %esp,%ebp
  800278:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  80027b:	8b 45 10             	mov    0x10(%ebp),%eax
  80027e:	3b 45 14             	cmp    0x14(%ebp),%eax
  800281:	0f 8d de 00 00 00    	jge    800365 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800287:	8b 45 10             	mov    0x10(%ebp),%eax
  80028a:	40                   	inc    %eax
  80028b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80028e:	8b 45 14             	mov    0x14(%ebp),%eax
  800291:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800294:	e9 80 00 00 00       	jmp    800319 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800299:	ff 45 f4             	incl   -0xc(%ebp)
  80029c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80029f:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002a2:	7f 2b                	jg     8002cf <QSort+0x5a>
  8002a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8002a7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8002b1:	01 d0                	add    %edx,%eax
  8002b3:	8b 10                	mov    (%eax),%edx
  8002b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002b8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c2:	01 c8                	add    %ecx,%eax
  8002c4:	8b 00                	mov    (%eax),%eax
  8002c6:	39 c2                	cmp    %eax,%edx
  8002c8:	7d cf                	jge    800299 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002ca:	eb 03                	jmp    8002cf <QSort+0x5a>
  8002cc:	ff 4d f0             	decl   -0x10(%ebp)
  8002cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002d2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002d5:	7e 26                	jle    8002fd <QSort+0x88>
  8002d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8002da:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e4:	01 d0                	add    %edx,%eax
  8002e6:	8b 10                	mov    (%eax),%edx
  8002e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002eb:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f5:	01 c8                	add    %ecx,%eax
  8002f7:	8b 00                	mov    (%eax),%eax
  8002f9:	39 c2                	cmp    %eax,%edx
  8002fb:	7e cf                	jle    8002cc <QSort+0x57>

		if (i <= j)
  8002fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800300:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800303:	7f 14                	jg     800319 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800305:	83 ec 04             	sub    $0x4,%esp
  800308:	ff 75 f0             	pushl  -0x10(%ebp)
  80030b:	ff 75 f4             	pushl  -0xc(%ebp)
  80030e:	ff 75 08             	pushl  0x8(%ebp)
  800311:	e8 a9 00 00 00       	call   8003bf <Swap>
  800316:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800319:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80031c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80031f:	0f 8e 77 ff ff ff    	jle    80029c <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800325:	83 ec 04             	sub    $0x4,%esp
  800328:	ff 75 f0             	pushl  -0x10(%ebp)
  80032b:	ff 75 10             	pushl  0x10(%ebp)
  80032e:	ff 75 08             	pushl  0x8(%ebp)
  800331:	e8 89 00 00 00       	call   8003bf <Swap>
  800336:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800339:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80033c:	48                   	dec    %eax
  80033d:	50                   	push   %eax
  80033e:	ff 75 10             	pushl  0x10(%ebp)
  800341:	ff 75 0c             	pushl  0xc(%ebp)
  800344:	ff 75 08             	pushl  0x8(%ebp)
  800347:	e8 29 ff ff ff       	call   800275 <QSort>
  80034c:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  80034f:	ff 75 14             	pushl  0x14(%ebp)
  800352:	ff 75 f4             	pushl  -0xc(%ebp)
  800355:	ff 75 0c             	pushl  0xc(%ebp)
  800358:	ff 75 08             	pushl  0x8(%ebp)
  80035b:	e8 15 ff ff ff       	call   800275 <QSort>
  800360:	83 c4 10             	add    $0x10,%esp
  800363:	eb 01                	jmp    800366 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800365:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800366:	c9                   	leave  
  800367:	c3                   	ret    

00800368 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800368:	55                   	push   %ebp
  800369:	89 e5                	mov    %esp,%ebp
  80036b:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  80036e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800375:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80037c:	eb 33                	jmp    8003b1 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80037e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800381:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800388:	8b 45 08             	mov    0x8(%ebp),%eax
  80038b:	01 d0                	add    %edx,%eax
  80038d:	8b 10                	mov    (%eax),%edx
  80038f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800392:	40                   	inc    %eax
  800393:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80039a:	8b 45 08             	mov    0x8(%ebp),%eax
  80039d:	01 c8                	add    %ecx,%eax
  80039f:	8b 00                	mov    (%eax),%eax
  8003a1:	39 c2                	cmp    %eax,%edx
  8003a3:	7e 09                	jle    8003ae <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8003ac:	eb 0c                	jmp    8003ba <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003ae:	ff 45 f8             	incl   -0x8(%ebp)
  8003b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003b4:	48                   	dec    %eax
  8003b5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8003b8:	7f c4                	jg     80037e <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003bd:	c9                   	leave  
  8003be:	c3                   	ret    

008003bf <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003bf:	55                   	push   %ebp
  8003c0:	89 e5                	mov    %esp,%ebp
  8003c2:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d2:	01 d0                	add    %edx,%eax
  8003d4:	8b 00                	mov    (%eax),%eax
  8003d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8003d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e6:	01 c2                	add    %eax,%edx
  8003e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8003eb:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f5:	01 c8                	add    %ecx,%eax
  8003f7:	8b 00                	mov    (%eax),%eax
  8003f9:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8003fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8003fe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800405:	8b 45 08             	mov    0x8(%ebp),%eax
  800408:	01 c2                	add    %eax,%edx
  80040a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80040d:	89 02                	mov    %eax,(%edx)
}
  80040f:	90                   	nop
  800410:	c9                   	leave  
  800411:	c3                   	ret    

00800412 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800412:	55                   	push   %ebp
  800413:	89 e5                	mov    %esp,%ebp
  800415:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800418:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80041f:	eb 17                	jmp    800438 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800421:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800424:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80042b:	8b 45 08             	mov    0x8(%ebp),%eax
  80042e:	01 c2                	add    %eax,%edx
  800430:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800433:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800435:	ff 45 fc             	incl   -0x4(%ebp)
  800438:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80043b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80043e:	7c e1                	jl     800421 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800440:	90                   	nop
  800441:	c9                   	leave  
  800442:	c3                   	ret    

00800443 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800443:	55                   	push   %ebp
  800444:	89 e5                	mov    %esp,%ebp
  800446:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800449:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800450:	eb 1b                	jmp    80046d <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800452:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800455:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045c:	8b 45 08             	mov    0x8(%ebp),%eax
  80045f:	01 c2                	add    %eax,%edx
  800461:	8b 45 0c             	mov    0xc(%ebp),%eax
  800464:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800467:	48                   	dec    %eax
  800468:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80046a:	ff 45 fc             	incl   -0x4(%ebp)
  80046d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800470:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800473:	7c dd                	jl     800452 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800475:	90                   	nop
  800476:	c9                   	leave  
  800477:	c3                   	ret    

00800478 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800478:	55                   	push   %ebp
  800479:	89 e5                	mov    %esp,%ebp
  80047b:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80047e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800481:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800486:	f7 e9                	imul   %ecx
  800488:	c1 f9 1f             	sar    $0x1f,%ecx
  80048b:	89 d0                	mov    %edx,%eax
  80048d:	29 c8                	sub    %ecx,%eax
  80048f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800492:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800499:	eb 1e                	jmp    8004b9 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  80049b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80049e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a8:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8004ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ae:	99                   	cltd   
  8004af:	f7 7d f8             	idivl  -0x8(%ebp)
  8004b2:	89 d0                	mov    %edx,%eax
  8004b4:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004b6:	ff 45 fc             	incl   -0x4(%ebp)
  8004b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004bc:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004bf:	7c da                	jl     80049b <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8004c1:	90                   	nop
  8004c2:	c9                   	leave  
  8004c3:	c3                   	ret    

008004c4 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004c4:	55                   	push   %ebp
  8004c5:	89 e5                	mov    %esp,%ebp
  8004c7:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  8004ca:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8004d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004d8:	eb 42                	jmp    80051c <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  8004da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004dd:	99                   	cltd   
  8004de:	f7 7d f0             	idivl  -0x10(%ebp)
  8004e1:	89 d0                	mov    %edx,%eax
  8004e3:	85 c0                	test   %eax,%eax
  8004e5:	75 10                	jne    8004f7 <PrintElements+0x33>
			cprintf("\n");
  8004e7:	83 ec 0c             	sub    $0xc,%esp
  8004ea:	68 26 27 80 00       	push   $0x802726
  8004ef:	e8 dd 04 00 00       	call   8009d1 <cprintf>
  8004f4:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  8004f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004fa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800501:	8b 45 08             	mov    0x8(%ebp),%eax
  800504:	01 d0                	add    %edx,%eax
  800506:	8b 00                	mov    (%eax),%eax
  800508:	83 ec 08             	sub    $0x8,%esp
  80050b:	50                   	push   %eax
  80050c:	68 28 27 80 00       	push   $0x802728
  800511:	e8 bb 04 00 00       	call   8009d1 <cprintf>
  800516:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800519:	ff 45 f4             	incl   -0xc(%ebp)
  80051c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80051f:	48                   	dec    %eax
  800520:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800523:	7f b5                	jg     8004da <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800525:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800528:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80052f:	8b 45 08             	mov    0x8(%ebp),%eax
  800532:	01 d0                	add    %edx,%eax
  800534:	8b 00                	mov    (%eax),%eax
  800536:	83 ec 08             	sub    $0x8,%esp
  800539:	50                   	push   %eax
  80053a:	68 2d 27 80 00       	push   $0x80272d
  80053f:	e8 8d 04 00 00       	call   8009d1 <cprintf>
  800544:	83 c4 10             	add    $0x10,%esp
}
  800547:	90                   	nop
  800548:	c9                   	leave  
  800549:	c3                   	ret    

0080054a <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80054a:	55                   	push   %ebp
  80054b:	89 e5                	mov    %esp,%ebp
  80054d:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800550:	8b 45 08             	mov    0x8(%ebp),%eax
  800553:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800556:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80055a:	83 ec 0c             	sub    $0xc,%esp
  80055d:	50                   	push   %eax
  80055e:	e8 e8 19 00 00       	call   801f4b <sys_cputc>
  800563:	83 c4 10             	add    $0x10,%esp
}
  800566:	90                   	nop
  800567:	c9                   	leave  
  800568:	c3                   	ret    

00800569 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800569:	55                   	push   %ebp
  80056a:	89 e5                	mov    %esp,%ebp
  80056c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80056f:	e8 a3 19 00 00       	call   801f17 <sys_disable_interrupt>
	char c = ch;
  800574:	8b 45 08             	mov    0x8(%ebp),%eax
  800577:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80057a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80057e:	83 ec 0c             	sub    $0xc,%esp
  800581:	50                   	push   %eax
  800582:	e8 c4 19 00 00       	call   801f4b <sys_cputc>
  800587:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80058a:	e8 a2 19 00 00       	call   801f31 <sys_enable_interrupt>
}
  80058f:	90                   	nop
  800590:	c9                   	leave  
  800591:	c3                   	ret    

00800592 <getchar>:

int
getchar(void)
{
  800592:	55                   	push   %ebp
  800593:	89 e5                	mov    %esp,%ebp
  800595:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800598:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80059f:	eb 08                	jmp    8005a9 <getchar+0x17>
	{
		c = sys_cgetc();
  8005a1:	e8 89 17 00 00       	call   801d2f <sys_cgetc>
  8005a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8005a9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005ad:	74 f2                	je     8005a1 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8005af:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005b2:	c9                   	leave  
  8005b3:	c3                   	ret    

008005b4 <atomic_getchar>:

int
atomic_getchar(void)
{
  8005b4:	55                   	push   %ebp
  8005b5:	89 e5                	mov    %esp,%ebp
  8005b7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005ba:	e8 58 19 00 00       	call   801f17 <sys_disable_interrupt>
	int c=0;
  8005bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005c6:	eb 08                	jmp    8005d0 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005c8:	e8 62 17 00 00       	call   801d2f <sys_cgetc>
  8005cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8005d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005d4:	74 f2                	je     8005c8 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8005d6:	e8 56 19 00 00       	call   801f31 <sys_enable_interrupt>
	return c;
  8005db:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005de:	c9                   	leave  
  8005df:	c3                   	ret    

008005e0 <iscons>:

int iscons(int fdnum)
{
  8005e0:	55                   	push   %ebp
  8005e1:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005e3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8005e8:	5d                   	pop    %ebp
  8005e9:	c3                   	ret    

008005ea <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005ea:	55                   	push   %ebp
  8005eb:	89 e5                	mov    %esp,%ebp
  8005ed:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005f0:	e8 87 17 00 00       	call   801d7c <sys_getenvindex>
  8005f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005fb:	89 d0                	mov    %edx,%eax
  8005fd:	c1 e0 03             	shl    $0x3,%eax
  800600:	01 d0                	add    %edx,%eax
  800602:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800609:	01 c8                	add    %ecx,%eax
  80060b:	01 c0                	add    %eax,%eax
  80060d:	01 d0                	add    %edx,%eax
  80060f:	01 c0                	add    %eax,%eax
  800611:	01 d0                	add    %edx,%eax
  800613:	89 c2                	mov    %eax,%edx
  800615:	c1 e2 05             	shl    $0x5,%edx
  800618:	29 c2                	sub    %eax,%edx
  80061a:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800621:	89 c2                	mov    %eax,%edx
  800623:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800629:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80062e:	a1 24 30 80 00       	mov    0x803024,%eax
  800633:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800639:	84 c0                	test   %al,%al
  80063b:	74 0f                	je     80064c <libmain+0x62>
		binaryname = myEnv->prog_name;
  80063d:	a1 24 30 80 00       	mov    0x803024,%eax
  800642:	05 40 3c 01 00       	add    $0x13c40,%eax
  800647:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80064c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800650:	7e 0a                	jle    80065c <libmain+0x72>
		binaryname = argv[0];
  800652:	8b 45 0c             	mov    0xc(%ebp),%eax
  800655:	8b 00                	mov    (%eax),%eax
  800657:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80065c:	83 ec 08             	sub    $0x8,%esp
  80065f:	ff 75 0c             	pushl  0xc(%ebp)
  800662:	ff 75 08             	pushl  0x8(%ebp)
  800665:	e8 ce f9 ff ff       	call   800038 <_main>
  80066a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80066d:	e8 a5 18 00 00       	call   801f17 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800672:	83 ec 0c             	sub    $0xc,%esp
  800675:	68 4c 27 80 00       	push   $0x80274c
  80067a:	e8 52 03 00 00       	call   8009d1 <cprintf>
  80067f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800682:	a1 24 30 80 00       	mov    0x803024,%eax
  800687:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80068d:	a1 24 30 80 00       	mov    0x803024,%eax
  800692:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800698:	83 ec 04             	sub    $0x4,%esp
  80069b:	52                   	push   %edx
  80069c:	50                   	push   %eax
  80069d:	68 74 27 80 00       	push   $0x802774
  8006a2:	e8 2a 03 00 00       	call   8009d1 <cprintf>
  8006a7:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8006aa:	a1 24 30 80 00       	mov    0x803024,%eax
  8006af:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8006b5:	a1 24 30 80 00       	mov    0x803024,%eax
  8006ba:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8006c0:	83 ec 04             	sub    $0x4,%esp
  8006c3:	52                   	push   %edx
  8006c4:	50                   	push   %eax
  8006c5:	68 9c 27 80 00       	push   $0x80279c
  8006ca:	e8 02 03 00 00       	call   8009d1 <cprintf>
  8006cf:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006d2:	a1 24 30 80 00       	mov    0x803024,%eax
  8006d7:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8006dd:	83 ec 08             	sub    $0x8,%esp
  8006e0:	50                   	push   %eax
  8006e1:	68 dd 27 80 00       	push   $0x8027dd
  8006e6:	e8 e6 02 00 00       	call   8009d1 <cprintf>
  8006eb:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006ee:	83 ec 0c             	sub    $0xc,%esp
  8006f1:	68 4c 27 80 00       	push   $0x80274c
  8006f6:	e8 d6 02 00 00       	call   8009d1 <cprintf>
  8006fb:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006fe:	e8 2e 18 00 00       	call   801f31 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800703:	e8 19 00 00 00       	call   800721 <exit>
}
  800708:	90                   	nop
  800709:	c9                   	leave  
  80070a:	c3                   	ret    

0080070b <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80070b:	55                   	push   %ebp
  80070c:	89 e5                	mov    %esp,%ebp
  80070e:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800711:	83 ec 0c             	sub    $0xc,%esp
  800714:	6a 00                	push   $0x0
  800716:	e8 2d 16 00 00       	call   801d48 <sys_env_destroy>
  80071b:	83 c4 10             	add    $0x10,%esp
}
  80071e:	90                   	nop
  80071f:	c9                   	leave  
  800720:	c3                   	ret    

00800721 <exit>:

void
exit(void)
{
  800721:	55                   	push   %ebp
  800722:	89 e5                	mov    %esp,%ebp
  800724:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800727:	e8 82 16 00 00       	call   801dae <sys_env_exit>
}
  80072c:	90                   	nop
  80072d:	c9                   	leave  
  80072e:	c3                   	ret    

0080072f <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80072f:	55                   	push   %ebp
  800730:	89 e5                	mov    %esp,%ebp
  800732:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800735:	8d 45 10             	lea    0x10(%ebp),%eax
  800738:	83 c0 04             	add    $0x4,%eax
  80073b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80073e:	a1 18 31 80 00       	mov    0x803118,%eax
  800743:	85 c0                	test   %eax,%eax
  800745:	74 16                	je     80075d <_panic+0x2e>
		cprintf("%s: ", argv0);
  800747:	a1 18 31 80 00       	mov    0x803118,%eax
  80074c:	83 ec 08             	sub    $0x8,%esp
  80074f:	50                   	push   %eax
  800750:	68 f4 27 80 00       	push   $0x8027f4
  800755:	e8 77 02 00 00       	call   8009d1 <cprintf>
  80075a:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80075d:	a1 00 30 80 00       	mov    0x803000,%eax
  800762:	ff 75 0c             	pushl  0xc(%ebp)
  800765:	ff 75 08             	pushl  0x8(%ebp)
  800768:	50                   	push   %eax
  800769:	68 f9 27 80 00       	push   $0x8027f9
  80076e:	e8 5e 02 00 00       	call   8009d1 <cprintf>
  800773:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800776:	8b 45 10             	mov    0x10(%ebp),%eax
  800779:	83 ec 08             	sub    $0x8,%esp
  80077c:	ff 75 f4             	pushl  -0xc(%ebp)
  80077f:	50                   	push   %eax
  800780:	e8 e1 01 00 00       	call   800966 <vcprintf>
  800785:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800788:	83 ec 08             	sub    $0x8,%esp
  80078b:	6a 00                	push   $0x0
  80078d:	68 15 28 80 00       	push   $0x802815
  800792:	e8 cf 01 00 00       	call   800966 <vcprintf>
  800797:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80079a:	e8 82 ff ff ff       	call   800721 <exit>

	// should not return here
	while (1) ;
  80079f:	eb fe                	jmp    80079f <_panic+0x70>

008007a1 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007a1:	55                   	push   %ebp
  8007a2:	89 e5                	mov    %esp,%ebp
  8007a4:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007a7:	a1 24 30 80 00       	mov    0x803024,%eax
  8007ac:	8b 50 74             	mov    0x74(%eax),%edx
  8007af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007b2:	39 c2                	cmp    %eax,%edx
  8007b4:	74 14                	je     8007ca <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007b6:	83 ec 04             	sub    $0x4,%esp
  8007b9:	68 18 28 80 00       	push   $0x802818
  8007be:	6a 26                	push   $0x26
  8007c0:	68 64 28 80 00       	push   $0x802864
  8007c5:	e8 65 ff ff ff       	call   80072f <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007d1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007d8:	e9 b6 00 00 00       	jmp    800893 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8007dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ea:	01 d0                	add    %edx,%eax
  8007ec:	8b 00                	mov    (%eax),%eax
  8007ee:	85 c0                	test   %eax,%eax
  8007f0:	75 08                	jne    8007fa <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007f2:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007f5:	e9 96 00 00 00       	jmp    800890 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8007fa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800801:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800808:	eb 5d                	jmp    800867 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80080a:	a1 24 30 80 00       	mov    0x803024,%eax
  80080f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800815:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800818:	c1 e2 04             	shl    $0x4,%edx
  80081b:	01 d0                	add    %edx,%eax
  80081d:	8a 40 04             	mov    0x4(%eax),%al
  800820:	84 c0                	test   %al,%al
  800822:	75 40                	jne    800864 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800824:	a1 24 30 80 00       	mov    0x803024,%eax
  800829:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80082f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800832:	c1 e2 04             	shl    $0x4,%edx
  800835:	01 d0                	add    %edx,%eax
  800837:	8b 00                	mov    (%eax),%eax
  800839:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80083c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80083f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800844:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800846:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800849:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800850:	8b 45 08             	mov    0x8(%ebp),%eax
  800853:	01 c8                	add    %ecx,%eax
  800855:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800857:	39 c2                	cmp    %eax,%edx
  800859:	75 09                	jne    800864 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80085b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800862:	eb 12                	jmp    800876 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800864:	ff 45 e8             	incl   -0x18(%ebp)
  800867:	a1 24 30 80 00       	mov    0x803024,%eax
  80086c:	8b 50 74             	mov    0x74(%eax),%edx
  80086f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800872:	39 c2                	cmp    %eax,%edx
  800874:	77 94                	ja     80080a <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800876:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80087a:	75 14                	jne    800890 <CheckWSWithoutLastIndex+0xef>
			panic(
  80087c:	83 ec 04             	sub    $0x4,%esp
  80087f:	68 70 28 80 00       	push   $0x802870
  800884:	6a 3a                	push   $0x3a
  800886:	68 64 28 80 00       	push   $0x802864
  80088b:	e8 9f fe ff ff       	call   80072f <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800890:	ff 45 f0             	incl   -0x10(%ebp)
  800893:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800896:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800899:	0f 8c 3e ff ff ff    	jl     8007dd <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80089f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008a6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008ad:	eb 20                	jmp    8008cf <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008af:	a1 24 30 80 00       	mov    0x803024,%eax
  8008b4:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8008ba:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008bd:	c1 e2 04             	shl    $0x4,%edx
  8008c0:	01 d0                	add    %edx,%eax
  8008c2:	8a 40 04             	mov    0x4(%eax),%al
  8008c5:	3c 01                	cmp    $0x1,%al
  8008c7:	75 03                	jne    8008cc <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8008c9:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008cc:	ff 45 e0             	incl   -0x20(%ebp)
  8008cf:	a1 24 30 80 00       	mov    0x803024,%eax
  8008d4:	8b 50 74             	mov    0x74(%eax),%edx
  8008d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008da:	39 c2                	cmp    %eax,%edx
  8008dc:	77 d1                	ja     8008af <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008de:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008e1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008e4:	74 14                	je     8008fa <CheckWSWithoutLastIndex+0x159>
		panic(
  8008e6:	83 ec 04             	sub    $0x4,%esp
  8008e9:	68 c4 28 80 00       	push   $0x8028c4
  8008ee:	6a 44                	push   $0x44
  8008f0:	68 64 28 80 00       	push   $0x802864
  8008f5:	e8 35 fe ff ff       	call   80072f <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008fa:	90                   	nop
  8008fb:	c9                   	leave  
  8008fc:	c3                   	ret    

008008fd <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008fd:	55                   	push   %ebp
  8008fe:	89 e5                	mov    %esp,%ebp
  800900:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800903:	8b 45 0c             	mov    0xc(%ebp),%eax
  800906:	8b 00                	mov    (%eax),%eax
  800908:	8d 48 01             	lea    0x1(%eax),%ecx
  80090b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80090e:	89 0a                	mov    %ecx,(%edx)
  800910:	8b 55 08             	mov    0x8(%ebp),%edx
  800913:	88 d1                	mov    %dl,%cl
  800915:	8b 55 0c             	mov    0xc(%ebp),%edx
  800918:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80091c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80091f:	8b 00                	mov    (%eax),%eax
  800921:	3d ff 00 00 00       	cmp    $0xff,%eax
  800926:	75 2c                	jne    800954 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800928:	a0 28 30 80 00       	mov    0x803028,%al
  80092d:	0f b6 c0             	movzbl %al,%eax
  800930:	8b 55 0c             	mov    0xc(%ebp),%edx
  800933:	8b 12                	mov    (%edx),%edx
  800935:	89 d1                	mov    %edx,%ecx
  800937:	8b 55 0c             	mov    0xc(%ebp),%edx
  80093a:	83 c2 08             	add    $0x8,%edx
  80093d:	83 ec 04             	sub    $0x4,%esp
  800940:	50                   	push   %eax
  800941:	51                   	push   %ecx
  800942:	52                   	push   %edx
  800943:	e8 be 13 00 00       	call   801d06 <sys_cputs>
  800948:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80094b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80094e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800954:	8b 45 0c             	mov    0xc(%ebp),%eax
  800957:	8b 40 04             	mov    0x4(%eax),%eax
  80095a:	8d 50 01             	lea    0x1(%eax),%edx
  80095d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800960:	89 50 04             	mov    %edx,0x4(%eax)
}
  800963:	90                   	nop
  800964:	c9                   	leave  
  800965:	c3                   	ret    

00800966 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800966:	55                   	push   %ebp
  800967:	89 e5                	mov    %esp,%ebp
  800969:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80096f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800976:	00 00 00 
	b.cnt = 0;
  800979:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800980:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800983:	ff 75 0c             	pushl  0xc(%ebp)
  800986:	ff 75 08             	pushl  0x8(%ebp)
  800989:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80098f:	50                   	push   %eax
  800990:	68 fd 08 80 00       	push   $0x8008fd
  800995:	e8 11 02 00 00       	call   800bab <vprintfmt>
  80099a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80099d:	a0 28 30 80 00       	mov    0x803028,%al
  8009a2:	0f b6 c0             	movzbl %al,%eax
  8009a5:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009ab:	83 ec 04             	sub    $0x4,%esp
  8009ae:	50                   	push   %eax
  8009af:	52                   	push   %edx
  8009b0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009b6:	83 c0 08             	add    $0x8,%eax
  8009b9:	50                   	push   %eax
  8009ba:	e8 47 13 00 00       	call   801d06 <sys_cputs>
  8009bf:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009c2:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  8009c9:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009cf:	c9                   	leave  
  8009d0:	c3                   	ret    

008009d1 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009d1:	55                   	push   %ebp
  8009d2:	89 e5                	mov    %esp,%ebp
  8009d4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009d7:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  8009de:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e7:	83 ec 08             	sub    $0x8,%esp
  8009ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ed:	50                   	push   %eax
  8009ee:	e8 73 ff ff ff       	call   800966 <vcprintf>
  8009f3:	83 c4 10             	add    $0x10,%esp
  8009f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009fc:	c9                   	leave  
  8009fd:	c3                   	ret    

008009fe <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009fe:	55                   	push   %ebp
  8009ff:	89 e5                	mov    %esp,%ebp
  800a01:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a04:	e8 0e 15 00 00       	call   801f17 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a09:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a12:	83 ec 08             	sub    $0x8,%esp
  800a15:	ff 75 f4             	pushl  -0xc(%ebp)
  800a18:	50                   	push   %eax
  800a19:	e8 48 ff ff ff       	call   800966 <vcprintf>
  800a1e:	83 c4 10             	add    $0x10,%esp
  800a21:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a24:	e8 08 15 00 00       	call   801f31 <sys_enable_interrupt>
	return cnt;
  800a29:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a2c:	c9                   	leave  
  800a2d:	c3                   	ret    

00800a2e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a2e:	55                   	push   %ebp
  800a2f:	89 e5                	mov    %esp,%ebp
  800a31:	53                   	push   %ebx
  800a32:	83 ec 14             	sub    $0x14,%esp
  800a35:	8b 45 10             	mov    0x10(%ebp),%eax
  800a38:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a3b:	8b 45 14             	mov    0x14(%ebp),%eax
  800a3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a41:	8b 45 18             	mov    0x18(%ebp),%eax
  800a44:	ba 00 00 00 00       	mov    $0x0,%edx
  800a49:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a4c:	77 55                	ja     800aa3 <printnum+0x75>
  800a4e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a51:	72 05                	jb     800a58 <printnum+0x2a>
  800a53:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a56:	77 4b                	ja     800aa3 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a58:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a5b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a5e:	8b 45 18             	mov    0x18(%ebp),%eax
  800a61:	ba 00 00 00 00       	mov    $0x0,%edx
  800a66:	52                   	push   %edx
  800a67:	50                   	push   %eax
  800a68:	ff 75 f4             	pushl  -0xc(%ebp)
  800a6b:	ff 75 f0             	pushl  -0x10(%ebp)
  800a6e:	e8 c5 18 00 00       	call   802338 <__udivdi3>
  800a73:	83 c4 10             	add    $0x10,%esp
  800a76:	83 ec 04             	sub    $0x4,%esp
  800a79:	ff 75 20             	pushl  0x20(%ebp)
  800a7c:	53                   	push   %ebx
  800a7d:	ff 75 18             	pushl  0x18(%ebp)
  800a80:	52                   	push   %edx
  800a81:	50                   	push   %eax
  800a82:	ff 75 0c             	pushl  0xc(%ebp)
  800a85:	ff 75 08             	pushl  0x8(%ebp)
  800a88:	e8 a1 ff ff ff       	call   800a2e <printnum>
  800a8d:	83 c4 20             	add    $0x20,%esp
  800a90:	eb 1a                	jmp    800aac <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a92:	83 ec 08             	sub    $0x8,%esp
  800a95:	ff 75 0c             	pushl  0xc(%ebp)
  800a98:	ff 75 20             	pushl  0x20(%ebp)
  800a9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9e:	ff d0                	call   *%eax
  800aa0:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800aa3:	ff 4d 1c             	decl   0x1c(%ebp)
  800aa6:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800aaa:	7f e6                	jg     800a92 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800aac:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800aaf:	bb 00 00 00 00       	mov    $0x0,%ebx
  800ab4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ab7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800aba:	53                   	push   %ebx
  800abb:	51                   	push   %ecx
  800abc:	52                   	push   %edx
  800abd:	50                   	push   %eax
  800abe:	e8 85 19 00 00       	call   802448 <__umoddi3>
  800ac3:	83 c4 10             	add    $0x10,%esp
  800ac6:	05 34 2b 80 00       	add    $0x802b34,%eax
  800acb:	8a 00                	mov    (%eax),%al
  800acd:	0f be c0             	movsbl %al,%eax
  800ad0:	83 ec 08             	sub    $0x8,%esp
  800ad3:	ff 75 0c             	pushl  0xc(%ebp)
  800ad6:	50                   	push   %eax
  800ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ada:	ff d0                	call   *%eax
  800adc:	83 c4 10             	add    $0x10,%esp
}
  800adf:	90                   	nop
  800ae0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ae3:	c9                   	leave  
  800ae4:	c3                   	ret    

00800ae5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ae5:	55                   	push   %ebp
  800ae6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ae8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800aec:	7e 1c                	jle    800b0a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800aee:	8b 45 08             	mov    0x8(%ebp),%eax
  800af1:	8b 00                	mov    (%eax),%eax
  800af3:	8d 50 08             	lea    0x8(%eax),%edx
  800af6:	8b 45 08             	mov    0x8(%ebp),%eax
  800af9:	89 10                	mov    %edx,(%eax)
  800afb:	8b 45 08             	mov    0x8(%ebp),%eax
  800afe:	8b 00                	mov    (%eax),%eax
  800b00:	83 e8 08             	sub    $0x8,%eax
  800b03:	8b 50 04             	mov    0x4(%eax),%edx
  800b06:	8b 00                	mov    (%eax),%eax
  800b08:	eb 40                	jmp    800b4a <getuint+0x65>
	else if (lflag)
  800b0a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b0e:	74 1e                	je     800b2e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b10:	8b 45 08             	mov    0x8(%ebp),%eax
  800b13:	8b 00                	mov    (%eax),%eax
  800b15:	8d 50 04             	lea    0x4(%eax),%edx
  800b18:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1b:	89 10                	mov    %edx,(%eax)
  800b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b20:	8b 00                	mov    (%eax),%eax
  800b22:	83 e8 04             	sub    $0x4,%eax
  800b25:	8b 00                	mov    (%eax),%eax
  800b27:	ba 00 00 00 00       	mov    $0x0,%edx
  800b2c:	eb 1c                	jmp    800b4a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b31:	8b 00                	mov    (%eax),%eax
  800b33:	8d 50 04             	lea    0x4(%eax),%edx
  800b36:	8b 45 08             	mov    0x8(%ebp),%eax
  800b39:	89 10                	mov    %edx,(%eax)
  800b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3e:	8b 00                	mov    (%eax),%eax
  800b40:	83 e8 04             	sub    $0x4,%eax
  800b43:	8b 00                	mov    (%eax),%eax
  800b45:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b4a:	5d                   	pop    %ebp
  800b4b:	c3                   	ret    

00800b4c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b4c:	55                   	push   %ebp
  800b4d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b4f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b53:	7e 1c                	jle    800b71 <getint+0x25>
		return va_arg(*ap, long long);
  800b55:	8b 45 08             	mov    0x8(%ebp),%eax
  800b58:	8b 00                	mov    (%eax),%eax
  800b5a:	8d 50 08             	lea    0x8(%eax),%edx
  800b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b60:	89 10                	mov    %edx,(%eax)
  800b62:	8b 45 08             	mov    0x8(%ebp),%eax
  800b65:	8b 00                	mov    (%eax),%eax
  800b67:	83 e8 08             	sub    $0x8,%eax
  800b6a:	8b 50 04             	mov    0x4(%eax),%edx
  800b6d:	8b 00                	mov    (%eax),%eax
  800b6f:	eb 38                	jmp    800ba9 <getint+0x5d>
	else if (lflag)
  800b71:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b75:	74 1a                	je     800b91 <getint+0x45>
		return va_arg(*ap, long);
  800b77:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7a:	8b 00                	mov    (%eax),%eax
  800b7c:	8d 50 04             	lea    0x4(%eax),%edx
  800b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b82:	89 10                	mov    %edx,(%eax)
  800b84:	8b 45 08             	mov    0x8(%ebp),%eax
  800b87:	8b 00                	mov    (%eax),%eax
  800b89:	83 e8 04             	sub    $0x4,%eax
  800b8c:	8b 00                	mov    (%eax),%eax
  800b8e:	99                   	cltd   
  800b8f:	eb 18                	jmp    800ba9 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b91:	8b 45 08             	mov    0x8(%ebp),%eax
  800b94:	8b 00                	mov    (%eax),%eax
  800b96:	8d 50 04             	lea    0x4(%eax),%edx
  800b99:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9c:	89 10                	mov    %edx,(%eax)
  800b9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba1:	8b 00                	mov    (%eax),%eax
  800ba3:	83 e8 04             	sub    $0x4,%eax
  800ba6:	8b 00                	mov    (%eax),%eax
  800ba8:	99                   	cltd   
}
  800ba9:	5d                   	pop    %ebp
  800baa:	c3                   	ret    

00800bab <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bab:	55                   	push   %ebp
  800bac:	89 e5                	mov    %esp,%ebp
  800bae:	56                   	push   %esi
  800baf:	53                   	push   %ebx
  800bb0:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bb3:	eb 17                	jmp    800bcc <vprintfmt+0x21>
			if (ch == '\0')
  800bb5:	85 db                	test   %ebx,%ebx
  800bb7:	0f 84 af 03 00 00    	je     800f6c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bbd:	83 ec 08             	sub    $0x8,%esp
  800bc0:	ff 75 0c             	pushl  0xc(%ebp)
  800bc3:	53                   	push   %ebx
  800bc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc7:	ff d0                	call   *%eax
  800bc9:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bcc:	8b 45 10             	mov    0x10(%ebp),%eax
  800bcf:	8d 50 01             	lea    0x1(%eax),%edx
  800bd2:	89 55 10             	mov    %edx,0x10(%ebp)
  800bd5:	8a 00                	mov    (%eax),%al
  800bd7:	0f b6 d8             	movzbl %al,%ebx
  800bda:	83 fb 25             	cmp    $0x25,%ebx
  800bdd:	75 d6                	jne    800bb5 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bdf:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800be3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bea:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bf1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bf8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bff:	8b 45 10             	mov    0x10(%ebp),%eax
  800c02:	8d 50 01             	lea    0x1(%eax),%edx
  800c05:	89 55 10             	mov    %edx,0x10(%ebp)
  800c08:	8a 00                	mov    (%eax),%al
  800c0a:	0f b6 d8             	movzbl %al,%ebx
  800c0d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c10:	83 f8 55             	cmp    $0x55,%eax
  800c13:	0f 87 2b 03 00 00    	ja     800f44 <vprintfmt+0x399>
  800c19:	8b 04 85 58 2b 80 00 	mov    0x802b58(,%eax,4),%eax
  800c20:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c22:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c26:	eb d7                	jmp    800bff <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c28:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c2c:	eb d1                	jmp    800bff <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c2e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c35:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c38:	89 d0                	mov    %edx,%eax
  800c3a:	c1 e0 02             	shl    $0x2,%eax
  800c3d:	01 d0                	add    %edx,%eax
  800c3f:	01 c0                	add    %eax,%eax
  800c41:	01 d8                	add    %ebx,%eax
  800c43:	83 e8 30             	sub    $0x30,%eax
  800c46:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c49:	8b 45 10             	mov    0x10(%ebp),%eax
  800c4c:	8a 00                	mov    (%eax),%al
  800c4e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c51:	83 fb 2f             	cmp    $0x2f,%ebx
  800c54:	7e 3e                	jle    800c94 <vprintfmt+0xe9>
  800c56:	83 fb 39             	cmp    $0x39,%ebx
  800c59:	7f 39                	jg     800c94 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c5b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c5e:	eb d5                	jmp    800c35 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c60:	8b 45 14             	mov    0x14(%ebp),%eax
  800c63:	83 c0 04             	add    $0x4,%eax
  800c66:	89 45 14             	mov    %eax,0x14(%ebp)
  800c69:	8b 45 14             	mov    0x14(%ebp),%eax
  800c6c:	83 e8 04             	sub    $0x4,%eax
  800c6f:	8b 00                	mov    (%eax),%eax
  800c71:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c74:	eb 1f                	jmp    800c95 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c76:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c7a:	79 83                	jns    800bff <vprintfmt+0x54>
				width = 0;
  800c7c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c83:	e9 77 ff ff ff       	jmp    800bff <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c88:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c8f:	e9 6b ff ff ff       	jmp    800bff <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c94:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c95:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c99:	0f 89 60 ff ff ff    	jns    800bff <vprintfmt+0x54>
				width = precision, precision = -1;
  800c9f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ca2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800ca5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800cac:	e9 4e ff ff ff       	jmp    800bff <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800cb1:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800cb4:	e9 46 ff ff ff       	jmp    800bff <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cb9:	8b 45 14             	mov    0x14(%ebp),%eax
  800cbc:	83 c0 04             	add    $0x4,%eax
  800cbf:	89 45 14             	mov    %eax,0x14(%ebp)
  800cc2:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc5:	83 e8 04             	sub    $0x4,%eax
  800cc8:	8b 00                	mov    (%eax),%eax
  800cca:	83 ec 08             	sub    $0x8,%esp
  800ccd:	ff 75 0c             	pushl  0xc(%ebp)
  800cd0:	50                   	push   %eax
  800cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd4:	ff d0                	call   *%eax
  800cd6:	83 c4 10             	add    $0x10,%esp
			break;
  800cd9:	e9 89 02 00 00       	jmp    800f67 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cde:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce1:	83 c0 04             	add    $0x4,%eax
  800ce4:	89 45 14             	mov    %eax,0x14(%ebp)
  800ce7:	8b 45 14             	mov    0x14(%ebp),%eax
  800cea:	83 e8 04             	sub    $0x4,%eax
  800ced:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cef:	85 db                	test   %ebx,%ebx
  800cf1:	79 02                	jns    800cf5 <vprintfmt+0x14a>
				err = -err;
  800cf3:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cf5:	83 fb 64             	cmp    $0x64,%ebx
  800cf8:	7f 0b                	jg     800d05 <vprintfmt+0x15a>
  800cfa:	8b 34 9d a0 29 80 00 	mov    0x8029a0(,%ebx,4),%esi
  800d01:	85 f6                	test   %esi,%esi
  800d03:	75 19                	jne    800d1e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d05:	53                   	push   %ebx
  800d06:	68 45 2b 80 00       	push   $0x802b45
  800d0b:	ff 75 0c             	pushl  0xc(%ebp)
  800d0e:	ff 75 08             	pushl  0x8(%ebp)
  800d11:	e8 5e 02 00 00       	call   800f74 <printfmt>
  800d16:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d19:	e9 49 02 00 00       	jmp    800f67 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d1e:	56                   	push   %esi
  800d1f:	68 4e 2b 80 00       	push   $0x802b4e
  800d24:	ff 75 0c             	pushl  0xc(%ebp)
  800d27:	ff 75 08             	pushl  0x8(%ebp)
  800d2a:	e8 45 02 00 00       	call   800f74 <printfmt>
  800d2f:	83 c4 10             	add    $0x10,%esp
			break;
  800d32:	e9 30 02 00 00       	jmp    800f67 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d37:	8b 45 14             	mov    0x14(%ebp),%eax
  800d3a:	83 c0 04             	add    $0x4,%eax
  800d3d:	89 45 14             	mov    %eax,0x14(%ebp)
  800d40:	8b 45 14             	mov    0x14(%ebp),%eax
  800d43:	83 e8 04             	sub    $0x4,%eax
  800d46:	8b 30                	mov    (%eax),%esi
  800d48:	85 f6                	test   %esi,%esi
  800d4a:	75 05                	jne    800d51 <vprintfmt+0x1a6>
				p = "(null)";
  800d4c:	be 51 2b 80 00       	mov    $0x802b51,%esi
			if (width > 0 && padc != '-')
  800d51:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d55:	7e 6d                	jle    800dc4 <vprintfmt+0x219>
  800d57:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d5b:	74 67                	je     800dc4 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d5d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d60:	83 ec 08             	sub    $0x8,%esp
  800d63:	50                   	push   %eax
  800d64:	56                   	push   %esi
  800d65:	e8 12 05 00 00       	call   80127c <strnlen>
  800d6a:	83 c4 10             	add    $0x10,%esp
  800d6d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d70:	eb 16                	jmp    800d88 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d72:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d76:	83 ec 08             	sub    $0x8,%esp
  800d79:	ff 75 0c             	pushl  0xc(%ebp)
  800d7c:	50                   	push   %eax
  800d7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d80:	ff d0                	call   *%eax
  800d82:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d85:	ff 4d e4             	decl   -0x1c(%ebp)
  800d88:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d8c:	7f e4                	jg     800d72 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d8e:	eb 34                	jmp    800dc4 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d90:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d94:	74 1c                	je     800db2 <vprintfmt+0x207>
  800d96:	83 fb 1f             	cmp    $0x1f,%ebx
  800d99:	7e 05                	jle    800da0 <vprintfmt+0x1f5>
  800d9b:	83 fb 7e             	cmp    $0x7e,%ebx
  800d9e:	7e 12                	jle    800db2 <vprintfmt+0x207>
					putch('?', putdat);
  800da0:	83 ec 08             	sub    $0x8,%esp
  800da3:	ff 75 0c             	pushl  0xc(%ebp)
  800da6:	6a 3f                	push   $0x3f
  800da8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dab:	ff d0                	call   *%eax
  800dad:	83 c4 10             	add    $0x10,%esp
  800db0:	eb 0f                	jmp    800dc1 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800db2:	83 ec 08             	sub    $0x8,%esp
  800db5:	ff 75 0c             	pushl  0xc(%ebp)
  800db8:	53                   	push   %ebx
  800db9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbc:	ff d0                	call   *%eax
  800dbe:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dc1:	ff 4d e4             	decl   -0x1c(%ebp)
  800dc4:	89 f0                	mov    %esi,%eax
  800dc6:	8d 70 01             	lea    0x1(%eax),%esi
  800dc9:	8a 00                	mov    (%eax),%al
  800dcb:	0f be d8             	movsbl %al,%ebx
  800dce:	85 db                	test   %ebx,%ebx
  800dd0:	74 24                	je     800df6 <vprintfmt+0x24b>
  800dd2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dd6:	78 b8                	js     800d90 <vprintfmt+0x1e5>
  800dd8:	ff 4d e0             	decl   -0x20(%ebp)
  800ddb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ddf:	79 af                	jns    800d90 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800de1:	eb 13                	jmp    800df6 <vprintfmt+0x24b>
				putch(' ', putdat);
  800de3:	83 ec 08             	sub    $0x8,%esp
  800de6:	ff 75 0c             	pushl  0xc(%ebp)
  800de9:	6a 20                	push   $0x20
  800deb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dee:	ff d0                	call   *%eax
  800df0:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800df3:	ff 4d e4             	decl   -0x1c(%ebp)
  800df6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dfa:	7f e7                	jg     800de3 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800dfc:	e9 66 01 00 00       	jmp    800f67 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e01:	83 ec 08             	sub    $0x8,%esp
  800e04:	ff 75 e8             	pushl  -0x18(%ebp)
  800e07:	8d 45 14             	lea    0x14(%ebp),%eax
  800e0a:	50                   	push   %eax
  800e0b:	e8 3c fd ff ff       	call   800b4c <getint>
  800e10:	83 c4 10             	add    $0x10,%esp
  800e13:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e16:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e19:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e1c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e1f:	85 d2                	test   %edx,%edx
  800e21:	79 23                	jns    800e46 <vprintfmt+0x29b>
				putch('-', putdat);
  800e23:	83 ec 08             	sub    $0x8,%esp
  800e26:	ff 75 0c             	pushl  0xc(%ebp)
  800e29:	6a 2d                	push   $0x2d
  800e2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2e:	ff d0                	call   *%eax
  800e30:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e33:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e36:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e39:	f7 d8                	neg    %eax
  800e3b:	83 d2 00             	adc    $0x0,%edx
  800e3e:	f7 da                	neg    %edx
  800e40:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e43:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e46:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e4d:	e9 bc 00 00 00       	jmp    800f0e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e52:	83 ec 08             	sub    $0x8,%esp
  800e55:	ff 75 e8             	pushl  -0x18(%ebp)
  800e58:	8d 45 14             	lea    0x14(%ebp),%eax
  800e5b:	50                   	push   %eax
  800e5c:	e8 84 fc ff ff       	call   800ae5 <getuint>
  800e61:	83 c4 10             	add    $0x10,%esp
  800e64:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e67:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e6a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e71:	e9 98 00 00 00       	jmp    800f0e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e76:	83 ec 08             	sub    $0x8,%esp
  800e79:	ff 75 0c             	pushl  0xc(%ebp)
  800e7c:	6a 58                	push   $0x58
  800e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e81:	ff d0                	call   *%eax
  800e83:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e86:	83 ec 08             	sub    $0x8,%esp
  800e89:	ff 75 0c             	pushl  0xc(%ebp)
  800e8c:	6a 58                	push   $0x58
  800e8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e91:	ff d0                	call   *%eax
  800e93:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e96:	83 ec 08             	sub    $0x8,%esp
  800e99:	ff 75 0c             	pushl  0xc(%ebp)
  800e9c:	6a 58                	push   $0x58
  800e9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea1:	ff d0                	call   *%eax
  800ea3:	83 c4 10             	add    $0x10,%esp
			break;
  800ea6:	e9 bc 00 00 00       	jmp    800f67 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800eab:	83 ec 08             	sub    $0x8,%esp
  800eae:	ff 75 0c             	pushl  0xc(%ebp)
  800eb1:	6a 30                	push   $0x30
  800eb3:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb6:	ff d0                	call   *%eax
  800eb8:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ebb:	83 ec 08             	sub    $0x8,%esp
  800ebe:	ff 75 0c             	pushl  0xc(%ebp)
  800ec1:	6a 78                	push   $0x78
  800ec3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec6:	ff d0                	call   *%eax
  800ec8:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ecb:	8b 45 14             	mov    0x14(%ebp),%eax
  800ece:	83 c0 04             	add    $0x4,%eax
  800ed1:	89 45 14             	mov    %eax,0x14(%ebp)
  800ed4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ed7:	83 e8 04             	sub    $0x4,%eax
  800eda:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800edc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800edf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ee6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800eed:	eb 1f                	jmp    800f0e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800eef:	83 ec 08             	sub    $0x8,%esp
  800ef2:	ff 75 e8             	pushl  -0x18(%ebp)
  800ef5:	8d 45 14             	lea    0x14(%ebp),%eax
  800ef8:	50                   	push   %eax
  800ef9:	e8 e7 fb ff ff       	call   800ae5 <getuint>
  800efe:	83 c4 10             	add    $0x10,%esp
  800f01:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f04:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f07:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f0e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f12:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f15:	83 ec 04             	sub    $0x4,%esp
  800f18:	52                   	push   %edx
  800f19:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f1c:	50                   	push   %eax
  800f1d:	ff 75 f4             	pushl  -0xc(%ebp)
  800f20:	ff 75 f0             	pushl  -0x10(%ebp)
  800f23:	ff 75 0c             	pushl  0xc(%ebp)
  800f26:	ff 75 08             	pushl  0x8(%ebp)
  800f29:	e8 00 fb ff ff       	call   800a2e <printnum>
  800f2e:	83 c4 20             	add    $0x20,%esp
			break;
  800f31:	eb 34                	jmp    800f67 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f33:	83 ec 08             	sub    $0x8,%esp
  800f36:	ff 75 0c             	pushl  0xc(%ebp)
  800f39:	53                   	push   %ebx
  800f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3d:	ff d0                	call   *%eax
  800f3f:	83 c4 10             	add    $0x10,%esp
			break;
  800f42:	eb 23                	jmp    800f67 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f44:	83 ec 08             	sub    $0x8,%esp
  800f47:	ff 75 0c             	pushl  0xc(%ebp)
  800f4a:	6a 25                	push   $0x25
  800f4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4f:	ff d0                	call   *%eax
  800f51:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f54:	ff 4d 10             	decl   0x10(%ebp)
  800f57:	eb 03                	jmp    800f5c <vprintfmt+0x3b1>
  800f59:	ff 4d 10             	decl   0x10(%ebp)
  800f5c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f5f:	48                   	dec    %eax
  800f60:	8a 00                	mov    (%eax),%al
  800f62:	3c 25                	cmp    $0x25,%al
  800f64:	75 f3                	jne    800f59 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f66:	90                   	nop
		}
	}
  800f67:	e9 47 fc ff ff       	jmp    800bb3 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f6c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f6d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f70:	5b                   	pop    %ebx
  800f71:	5e                   	pop    %esi
  800f72:	5d                   	pop    %ebp
  800f73:	c3                   	ret    

00800f74 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f74:	55                   	push   %ebp
  800f75:	89 e5                	mov    %esp,%ebp
  800f77:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f7a:	8d 45 10             	lea    0x10(%ebp),%eax
  800f7d:	83 c0 04             	add    $0x4,%eax
  800f80:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f83:	8b 45 10             	mov    0x10(%ebp),%eax
  800f86:	ff 75 f4             	pushl  -0xc(%ebp)
  800f89:	50                   	push   %eax
  800f8a:	ff 75 0c             	pushl  0xc(%ebp)
  800f8d:	ff 75 08             	pushl  0x8(%ebp)
  800f90:	e8 16 fc ff ff       	call   800bab <vprintfmt>
  800f95:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f98:	90                   	nop
  800f99:	c9                   	leave  
  800f9a:	c3                   	ret    

00800f9b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f9b:	55                   	push   %ebp
  800f9c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa1:	8b 40 08             	mov    0x8(%eax),%eax
  800fa4:	8d 50 01             	lea    0x1(%eax),%edx
  800fa7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800faa:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800fad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb0:	8b 10                	mov    (%eax),%edx
  800fb2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb5:	8b 40 04             	mov    0x4(%eax),%eax
  800fb8:	39 c2                	cmp    %eax,%edx
  800fba:	73 12                	jae    800fce <sprintputch+0x33>
		*b->buf++ = ch;
  800fbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbf:	8b 00                	mov    (%eax),%eax
  800fc1:	8d 48 01             	lea    0x1(%eax),%ecx
  800fc4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fc7:	89 0a                	mov    %ecx,(%edx)
  800fc9:	8b 55 08             	mov    0x8(%ebp),%edx
  800fcc:	88 10                	mov    %dl,(%eax)
}
  800fce:	90                   	nop
  800fcf:	5d                   	pop    %ebp
  800fd0:	c3                   	ret    

00800fd1 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fd1:	55                   	push   %ebp
  800fd2:	89 e5                	mov    %esp,%ebp
  800fd4:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fda:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fdd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe6:	01 d0                	add    %edx,%eax
  800fe8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800feb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800ff2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ff6:	74 06                	je     800ffe <vsnprintf+0x2d>
  800ff8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ffc:	7f 07                	jg     801005 <vsnprintf+0x34>
		return -E_INVAL;
  800ffe:	b8 03 00 00 00       	mov    $0x3,%eax
  801003:	eb 20                	jmp    801025 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801005:	ff 75 14             	pushl  0x14(%ebp)
  801008:	ff 75 10             	pushl  0x10(%ebp)
  80100b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80100e:	50                   	push   %eax
  80100f:	68 9b 0f 80 00       	push   $0x800f9b
  801014:	e8 92 fb ff ff       	call   800bab <vprintfmt>
  801019:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80101c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80101f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801022:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801025:	c9                   	leave  
  801026:	c3                   	ret    

00801027 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801027:	55                   	push   %ebp
  801028:	89 e5                	mov    %esp,%ebp
  80102a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80102d:	8d 45 10             	lea    0x10(%ebp),%eax
  801030:	83 c0 04             	add    $0x4,%eax
  801033:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801036:	8b 45 10             	mov    0x10(%ebp),%eax
  801039:	ff 75 f4             	pushl  -0xc(%ebp)
  80103c:	50                   	push   %eax
  80103d:	ff 75 0c             	pushl  0xc(%ebp)
  801040:	ff 75 08             	pushl  0x8(%ebp)
  801043:	e8 89 ff ff ff       	call   800fd1 <vsnprintf>
  801048:	83 c4 10             	add    $0x10,%esp
  80104b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80104e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801051:	c9                   	leave  
  801052:	c3                   	ret    

00801053 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801053:	55                   	push   %ebp
  801054:	89 e5                	mov    %esp,%ebp
  801056:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801059:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80105d:	74 13                	je     801072 <readline+0x1f>
		cprintf("%s", prompt);
  80105f:	83 ec 08             	sub    $0x8,%esp
  801062:	ff 75 08             	pushl  0x8(%ebp)
  801065:	68 b0 2c 80 00       	push   $0x802cb0
  80106a:	e8 62 f9 ff ff       	call   8009d1 <cprintf>
  80106f:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801072:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801079:	83 ec 0c             	sub    $0xc,%esp
  80107c:	6a 00                	push   $0x0
  80107e:	e8 5d f5 ff ff       	call   8005e0 <iscons>
  801083:	83 c4 10             	add    $0x10,%esp
  801086:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801089:	e8 04 f5 ff ff       	call   800592 <getchar>
  80108e:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801091:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801095:	79 22                	jns    8010b9 <readline+0x66>
			if (c != -E_EOF)
  801097:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80109b:	0f 84 ad 00 00 00    	je     80114e <readline+0xfb>
				cprintf("read error: %e\n", c);
  8010a1:	83 ec 08             	sub    $0x8,%esp
  8010a4:	ff 75 ec             	pushl  -0x14(%ebp)
  8010a7:	68 b3 2c 80 00       	push   $0x802cb3
  8010ac:	e8 20 f9 ff ff       	call   8009d1 <cprintf>
  8010b1:	83 c4 10             	add    $0x10,%esp
			return;
  8010b4:	e9 95 00 00 00       	jmp    80114e <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8010b9:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8010bd:	7e 34                	jle    8010f3 <readline+0xa0>
  8010bf:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8010c6:	7f 2b                	jg     8010f3 <readline+0xa0>
			if (echoing)
  8010c8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010cc:	74 0e                	je     8010dc <readline+0x89>
				cputchar(c);
  8010ce:	83 ec 0c             	sub    $0xc,%esp
  8010d1:	ff 75 ec             	pushl  -0x14(%ebp)
  8010d4:	e8 71 f4 ff ff       	call   80054a <cputchar>
  8010d9:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8010dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010df:	8d 50 01             	lea    0x1(%eax),%edx
  8010e2:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8010e5:	89 c2                	mov    %eax,%edx
  8010e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ea:	01 d0                	add    %edx,%eax
  8010ec:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010ef:	88 10                	mov    %dl,(%eax)
  8010f1:	eb 56                	jmp    801149 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8010f3:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8010f7:	75 1f                	jne    801118 <readline+0xc5>
  8010f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8010fd:	7e 19                	jle    801118 <readline+0xc5>
			if (echoing)
  8010ff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801103:	74 0e                	je     801113 <readline+0xc0>
				cputchar(c);
  801105:	83 ec 0c             	sub    $0xc,%esp
  801108:	ff 75 ec             	pushl  -0x14(%ebp)
  80110b:	e8 3a f4 ff ff       	call   80054a <cputchar>
  801110:	83 c4 10             	add    $0x10,%esp

			i--;
  801113:	ff 4d f4             	decl   -0xc(%ebp)
  801116:	eb 31                	jmp    801149 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  801118:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80111c:	74 0a                	je     801128 <readline+0xd5>
  80111e:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801122:	0f 85 61 ff ff ff    	jne    801089 <readline+0x36>
			if (echoing)
  801128:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80112c:	74 0e                	je     80113c <readline+0xe9>
				cputchar(c);
  80112e:	83 ec 0c             	sub    $0xc,%esp
  801131:	ff 75 ec             	pushl  -0x14(%ebp)
  801134:	e8 11 f4 ff ff       	call   80054a <cputchar>
  801139:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80113c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80113f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801142:	01 d0                	add    %edx,%eax
  801144:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801147:	eb 06                	jmp    80114f <readline+0xfc>
		}
	}
  801149:	e9 3b ff ff ff       	jmp    801089 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  80114e:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  80114f:	c9                   	leave  
  801150:	c3                   	ret    

00801151 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801151:	55                   	push   %ebp
  801152:	89 e5                	mov    %esp,%ebp
  801154:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801157:	e8 bb 0d 00 00       	call   801f17 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  80115c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801160:	74 13                	je     801175 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801162:	83 ec 08             	sub    $0x8,%esp
  801165:	ff 75 08             	pushl  0x8(%ebp)
  801168:	68 b0 2c 80 00       	push   $0x802cb0
  80116d:	e8 5f f8 ff ff       	call   8009d1 <cprintf>
  801172:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801175:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80117c:	83 ec 0c             	sub    $0xc,%esp
  80117f:	6a 00                	push   $0x0
  801181:	e8 5a f4 ff ff       	call   8005e0 <iscons>
  801186:	83 c4 10             	add    $0x10,%esp
  801189:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80118c:	e8 01 f4 ff ff       	call   800592 <getchar>
  801191:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801194:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801198:	79 23                	jns    8011bd <atomic_readline+0x6c>
			if (c != -E_EOF)
  80119a:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80119e:	74 13                	je     8011b3 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8011a0:	83 ec 08             	sub    $0x8,%esp
  8011a3:	ff 75 ec             	pushl  -0x14(%ebp)
  8011a6:	68 b3 2c 80 00       	push   $0x802cb3
  8011ab:	e8 21 f8 ff ff       	call   8009d1 <cprintf>
  8011b0:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8011b3:	e8 79 0d 00 00       	call   801f31 <sys_enable_interrupt>
			return;
  8011b8:	e9 9a 00 00 00       	jmp    801257 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8011bd:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011c1:	7e 34                	jle    8011f7 <atomic_readline+0xa6>
  8011c3:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011ca:	7f 2b                	jg     8011f7 <atomic_readline+0xa6>
			if (echoing)
  8011cc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011d0:	74 0e                	je     8011e0 <atomic_readline+0x8f>
				cputchar(c);
  8011d2:	83 ec 0c             	sub    $0xc,%esp
  8011d5:	ff 75 ec             	pushl  -0x14(%ebp)
  8011d8:	e8 6d f3 ff ff       	call   80054a <cputchar>
  8011dd:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011e3:	8d 50 01             	lea    0x1(%eax),%edx
  8011e6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011e9:	89 c2                	mov    %eax,%edx
  8011eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ee:	01 d0                	add    %edx,%eax
  8011f0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011f3:	88 10                	mov    %dl,(%eax)
  8011f5:	eb 5b                	jmp    801252 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8011f7:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011fb:	75 1f                	jne    80121c <atomic_readline+0xcb>
  8011fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801201:	7e 19                	jle    80121c <atomic_readline+0xcb>
			if (echoing)
  801203:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801207:	74 0e                	je     801217 <atomic_readline+0xc6>
				cputchar(c);
  801209:	83 ec 0c             	sub    $0xc,%esp
  80120c:	ff 75 ec             	pushl  -0x14(%ebp)
  80120f:	e8 36 f3 ff ff       	call   80054a <cputchar>
  801214:	83 c4 10             	add    $0x10,%esp
			i--;
  801217:	ff 4d f4             	decl   -0xc(%ebp)
  80121a:	eb 36                	jmp    801252 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  80121c:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801220:	74 0a                	je     80122c <atomic_readline+0xdb>
  801222:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801226:	0f 85 60 ff ff ff    	jne    80118c <atomic_readline+0x3b>
			if (echoing)
  80122c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801230:	74 0e                	je     801240 <atomic_readline+0xef>
				cputchar(c);
  801232:	83 ec 0c             	sub    $0xc,%esp
  801235:	ff 75 ec             	pushl  -0x14(%ebp)
  801238:	e8 0d f3 ff ff       	call   80054a <cputchar>
  80123d:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801240:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801243:	8b 45 0c             	mov    0xc(%ebp),%eax
  801246:	01 d0                	add    %edx,%eax
  801248:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80124b:	e8 e1 0c 00 00       	call   801f31 <sys_enable_interrupt>
			return;
  801250:	eb 05                	jmp    801257 <atomic_readline+0x106>
		}
	}
  801252:	e9 35 ff ff ff       	jmp    80118c <atomic_readline+0x3b>
}
  801257:	c9                   	leave  
  801258:	c3                   	ret    

00801259 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801259:	55                   	push   %ebp
  80125a:	89 e5                	mov    %esp,%ebp
  80125c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80125f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801266:	eb 06                	jmp    80126e <strlen+0x15>
		n++;
  801268:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80126b:	ff 45 08             	incl   0x8(%ebp)
  80126e:	8b 45 08             	mov    0x8(%ebp),%eax
  801271:	8a 00                	mov    (%eax),%al
  801273:	84 c0                	test   %al,%al
  801275:	75 f1                	jne    801268 <strlen+0xf>
		n++;
	return n;
  801277:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80127a:	c9                   	leave  
  80127b:	c3                   	ret    

0080127c <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80127c:	55                   	push   %ebp
  80127d:	89 e5                	mov    %esp,%ebp
  80127f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801282:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801289:	eb 09                	jmp    801294 <strnlen+0x18>
		n++;
  80128b:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80128e:	ff 45 08             	incl   0x8(%ebp)
  801291:	ff 4d 0c             	decl   0xc(%ebp)
  801294:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801298:	74 09                	je     8012a3 <strnlen+0x27>
  80129a:	8b 45 08             	mov    0x8(%ebp),%eax
  80129d:	8a 00                	mov    (%eax),%al
  80129f:	84 c0                	test   %al,%al
  8012a1:	75 e8                	jne    80128b <strnlen+0xf>
		n++;
	return n;
  8012a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012a6:	c9                   	leave  
  8012a7:	c3                   	ret    

008012a8 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8012a8:	55                   	push   %ebp
  8012a9:	89 e5                	mov    %esp,%ebp
  8012ab:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8012ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8012b4:	90                   	nop
  8012b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b8:	8d 50 01             	lea    0x1(%eax),%edx
  8012bb:	89 55 08             	mov    %edx,0x8(%ebp)
  8012be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012c1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012c4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012c7:	8a 12                	mov    (%edx),%dl
  8012c9:	88 10                	mov    %dl,(%eax)
  8012cb:	8a 00                	mov    (%eax),%al
  8012cd:	84 c0                	test   %al,%al
  8012cf:	75 e4                	jne    8012b5 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8012d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012d4:	c9                   	leave  
  8012d5:	c3                   	ret    

008012d6 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8012d6:	55                   	push   %ebp
  8012d7:	89 e5                	mov    %esp,%ebp
  8012d9:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012df:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012e2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012e9:	eb 1f                	jmp    80130a <strncpy+0x34>
		*dst++ = *src;
  8012eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ee:	8d 50 01             	lea    0x1(%eax),%edx
  8012f1:	89 55 08             	mov    %edx,0x8(%ebp)
  8012f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f7:	8a 12                	mov    (%edx),%dl
  8012f9:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012fe:	8a 00                	mov    (%eax),%al
  801300:	84 c0                	test   %al,%al
  801302:	74 03                	je     801307 <strncpy+0x31>
			src++;
  801304:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801307:	ff 45 fc             	incl   -0x4(%ebp)
  80130a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80130d:	3b 45 10             	cmp    0x10(%ebp),%eax
  801310:	72 d9                	jb     8012eb <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801312:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801315:	c9                   	leave  
  801316:	c3                   	ret    

00801317 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801317:	55                   	push   %ebp
  801318:	89 e5                	mov    %esp,%ebp
  80131a:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80131d:	8b 45 08             	mov    0x8(%ebp),%eax
  801320:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801323:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801327:	74 30                	je     801359 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801329:	eb 16                	jmp    801341 <strlcpy+0x2a>
			*dst++ = *src++;
  80132b:	8b 45 08             	mov    0x8(%ebp),%eax
  80132e:	8d 50 01             	lea    0x1(%eax),%edx
  801331:	89 55 08             	mov    %edx,0x8(%ebp)
  801334:	8b 55 0c             	mov    0xc(%ebp),%edx
  801337:	8d 4a 01             	lea    0x1(%edx),%ecx
  80133a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80133d:	8a 12                	mov    (%edx),%dl
  80133f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801341:	ff 4d 10             	decl   0x10(%ebp)
  801344:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801348:	74 09                	je     801353 <strlcpy+0x3c>
  80134a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80134d:	8a 00                	mov    (%eax),%al
  80134f:	84 c0                	test   %al,%al
  801351:	75 d8                	jne    80132b <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801353:	8b 45 08             	mov    0x8(%ebp),%eax
  801356:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801359:	8b 55 08             	mov    0x8(%ebp),%edx
  80135c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80135f:	29 c2                	sub    %eax,%edx
  801361:	89 d0                	mov    %edx,%eax
}
  801363:	c9                   	leave  
  801364:	c3                   	ret    

00801365 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801365:	55                   	push   %ebp
  801366:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801368:	eb 06                	jmp    801370 <strcmp+0xb>
		p++, q++;
  80136a:	ff 45 08             	incl   0x8(%ebp)
  80136d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801370:	8b 45 08             	mov    0x8(%ebp),%eax
  801373:	8a 00                	mov    (%eax),%al
  801375:	84 c0                	test   %al,%al
  801377:	74 0e                	je     801387 <strcmp+0x22>
  801379:	8b 45 08             	mov    0x8(%ebp),%eax
  80137c:	8a 10                	mov    (%eax),%dl
  80137e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801381:	8a 00                	mov    (%eax),%al
  801383:	38 c2                	cmp    %al,%dl
  801385:	74 e3                	je     80136a <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801387:	8b 45 08             	mov    0x8(%ebp),%eax
  80138a:	8a 00                	mov    (%eax),%al
  80138c:	0f b6 d0             	movzbl %al,%edx
  80138f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801392:	8a 00                	mov    (%eax),%al
  801394:	0f b6 c0             	movzbl %al,%eax
  801397:	29 c2                	sub    %eax,%edx
  801399:	89 d0                	mov    %edx,%eax
}
  80139b:	5d                   	pop    %ebp
  80139c:	c3                   	ret    

0080139d <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80139d:	55                   	push   %ebp
  80139e:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8013a0:	eb 09                	jmp    8013ab <strncmp+0xe>
		n--, p++, q++;
  8013a2:	ff 4d 10             	decl   0x10(%ebp)
  8013a5:	ff 45 08             	incl   0x8(%ebp)
  8013a8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8013ab:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013af:	74 17                	je     8013c8 <strncmp+0x2b>
  8013b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b4:	8a 00                	mov    (%eax),%al
  8013b6:	84 c0                	test   %al,%al
  8013b8:	74 0e                	je     8013c8 <strncmp+0x2b>
  8013ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bd:	8a 10                	mov    (%eax),%dl
  8013bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c2:	8a 00                	mov    (%eax),%al
  8013c4:	38 c2                	cmp    %al,%dl
  8013c6:	74 da                	je     8013a2 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013c8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013cc:	75 07                	jne    8013d5 <strncmp+0x38>
		return 0;
  8013ce:	b8 00 00 00 00       	mov    $0x0,%eax
  8013d3:	eb 14                	jmp    8013e9 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8013d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d8:	8a 00                	mov    (%eax),%al
  8013da:	0f b6 d0             	movzbl %al,%edx
  8013dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e0:	8a 00                	mov    (%eax),%al
  8013e2:	0f b6 c0             	movzbl %al,%eax
  8013e5:	29 c2                	sub    %eax,%edx
  8013e7:	89 d0                	mov    %edx,%eax
}
  8013e9:	5d                   	pop    %ebp
  8013ea:	c3                   	ret    

008013eb <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013eb:	55                   	push   %ebp
  8013ec:	89 e5                	mov    %esp,%ebp
  8013ee:	83 ec 04             	sub    $0x4,%esp
  8013f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013f7:	eb 12                	jmp    80140b <strchr+0x20>
		if (*s == c)
  8013f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fc:	8a 00                	mov    (%eax),%al
  8013fe:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801401:	75 05                	jne    801408 <strchr+0x1d>
			return (char *) s;
  801403:	8b 45 08             	mov    0x8(%ebp),%eax
  801406:	eb 11                	jmp    801419 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801408:	ff 45 08             	incl   0x8(%ebp)
  80140b:	8b 45 08             	mov    0x8(%ebp),%eax
  80140e:	8a 00                	mov    (%eax),%al
  801410:	84 c0                	test   %al,%al
  801412:	75 e5                	jne    8013f9 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801414:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801419:	c9                   	leave  
  80141a:	c3                   	ret    

0080141b <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80141b:	55                   	push   %ebp
  80141c:	89 e5                	mov    %esp,%ebp
  80141e:	83 ec 04             	sub    $0x4,%esp
  801421:	8b 45 0c             	mov    0xc(%ebp),%eax
  801424:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801427:	eb 0d                	jmp    801436 <strfind+0x1b>
		if (*s == c)
  801429:	8b 45 08             	mov    0x8(%ebp),%eax
  80142c:	8a 00                	mov    (%eax),%al
  80142e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801431:	74 0e                	je     801441 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801433:	ff 45 08             	incl   0x8(%ebp)
  801436:	8b 45 08             	mov    0x8(%ebp),%eax
  801439:	8a 00                	mov    (%eax),%al
  80143b:	84 c0                	test   %al,%al
  80143d:	75 ea                	jne    801429 <strfind+0xe>
  80143f:	eb 01                	jmp    801442 <strfind+0x27>
		if (*s == c)
			break;
  801441:	90                   	nop
	return (char *) s;
  801442:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801445:	c9                   	leave  
  801446:	c3                   	ret    

00801447 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801447:	55                   	push   %ebp
  801448:	89 e5                	mov    %esp,%ebp
  80144a:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80144d:	8b 45 08             	mov    0x8(%ebp),%eax
  801450:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801453:	8b 45 10             	mov    0x10(%ebp),%eax
  801456:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801459:	eb 0e                	jmp    801469 <memset+0x22>
		*p++ = c;
  80145b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80145e:	8d 50 01             	lea    0x1(%eax),%edx
  801461:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801464:	8b 55 0c             	mov    0xc(%ebp),%edx
  801467:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801469:	ff 4d f8             	decl   -0x8(%ebp)
  80146c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801470:	79 e9                	jns    80145b <memset+0x14>
		*p++ = c;

	return v;
  801472:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801475:	c9                   	leave  
  801476:	c3                   	ret    

00801477 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801477:	55                   	push   %ebp
  801478:	89 e5                	mov    %esp,%ebp
  80147a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80147d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801480:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801483:	8b 45 08             	mov    0x8(%ebp),%eax
  801486:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801489:	eb 16                	jmp    8014a1 <memcpy+0x2a>
		*d++ = *s++;
  80148b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80148e:	8d 50 01             	lea    0x1(%eax),%edx
  801491:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801494:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801497:	8d 4a 01             	lea    0x1(%edx),%ecx
  80149a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80149d:	8a 12                	mov    (%edx),%dl
  80149f:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8014a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8014a4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014a7:	89 55 10             	mov    %edx,0x10(%ebp)
  8014aa:	85 c0                	test   %eax,%eax
  8014ac:	75 dd                	jne    80148b <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8014ae:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014b1:	c9                   	leave  
  8014b2:	c3                   	ret    

008014b3 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014b3:	55                   	push   %ebp
  8014b4:	89 e5                	mov    %esp,%ebp
  8014b6:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014c8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014cb:	73 50                	jae    80151d <memmove+0x6a>
  8014cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d3:	01 d0                	add    %edx,%eax
  8014d5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014d8:	76 43                	jbe    80151d <memmove+0x6a>
		s += n;
  8014da:	8b 45 10             	mov    0x10(%ebp),%eax
  8014dd:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e3:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014e6:	eb 10                	jmp    8014f8 <memmove+0x45>
			*--d = *--s;
  8014e8:	ff 4d f8             	decl   -0x8(%ebp)
  8014eb:	ff 4d fc             	decl   -0x4(%ebp)
  8014ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014f1:	8a 10                	mov    (%eax),%dl
  8014f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014f6:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8014fb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014fe:	89 55 10             	mov    %edx,0x10(%ebp)
  801501:	85 c0                	test   %eax,%eax
  801503:	75 e3                	jne    8014e8 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801505:	eb 23                	jmp    80152a <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801507:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80150a:	8d 50 01             	lea    0x1(%eax),%edx
  80150d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801510:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801513:	8d 4a 01             	lea    0x1(%edx),%ecx
  801516:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801519:	8a 12                	mov    (%edx),%dl
  80151b:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80151d:	8b 45 10             	mov    0x10(%ebp),%eax
  801520:	8d 50 ff             	lea    -0x1(%eax),%edx
  801523:	89 55 10             	mov    %edx,0x10(%ebp)
  801526:	85 c0                	test   %eax,%eax
  801528:	75 dd                	jne    801507 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80152a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80152d:	c9                   	leave  
  80152e:	c3                   	ret    

0080152f <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80152f:	55                   	push   %ebp
  801530:	89 e5                	mov    %esp,%ebp
  801532:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801535:	8b 45 08             	mov    0x8(%ebp),%eax
  801538:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80153b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80153e:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801541:	eb 2a                	jmp    80156d <memcmp+0x3e>
		if (*s1 != *s2)
  801543:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801546:	8a 10                	mov    (%eax),%dl
  801548:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80154b:	8a 00                	mov    (%eax),%al
  80154d:	38 c2                	cmp    %al,%dl
  80154f:	74 16                	je     801567 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801551:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801554:	8a 00                	mov    (%eax),%al
  801556:	0f b6 d0             	movzbl %al,%edx
  801559:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80155c:	8a 00                	mov    (%eax),%al
  80155e:	0f b6 c0             	movzbl %al,%eax
  801561:	29 c2                	sub    %eax,%edx
  801563:	89 d0                	mov    %edx,%eax
  801565:	eb 18                	jmp    80157f <memcmp+0x50>
		s1++, s2++;
  801567:	ff 45 fc             	incl   -0x4(%ebp)
  80156a:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80156d:	8b 45 10             	mov    0x10(%ebp),%eax
  801570:	8d 50 ff             	lea    -0x1(%eax),%edx
  801573:	89 55 10             	mov    %edx,0x10(%ebp)
  801576:	85 c0                	test   %eax,%eax
  801578:	75 c9                	jne    801543 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80157a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80157f:	c9                   	leave  
  801580:	c3                   	ret    

00801581 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801581:	55                   	push   %ebp
  801582:	89 e5                	mov    %esp,%ebp
  801584:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801587:	8b 55 08             	mov    0x8(%ebp),%edx
  80158a:	8b 45 10             	mov    0x10(%ebp),%eax
  80158d:	01 d0                	add    %edx,%eax
  80158f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801592:	eb 15                	jmp    8015a9 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801594:	8b 45 08             	mov    0x8(%ebp),%eax
  801597:	8a 00                	mov    (%eax),%al
  801599:	0f b6 d0             	movzbl %al,%edx
  80159c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159f:	0f b6 c0             	movzbl %al,%eax
  8015a2:	39 c2                	cmp    %eax,%edx
  8015a4:	74 0d                	je     8015b3 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8015a6:	ff 45 08             	incl   0x8(%ebp)
  8015a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ac:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015af:	72 e3                	jb     801594 <memfind+0x13>
  8015b1:	eb 01                	jmp    8015b4 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015b3:	90                   	nop
	return (void *) s;
  8015b4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015b7:	c9                   	leave  
  8015b8:	c3                   	ret    

008015b9 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015b9:	55                   	push   %ebp
  8015ba:	89 e5                	mov    %esp,%ebp
  8015bc:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015bf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015c6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015cd:	eb 03                	jmp    8015d2 <strtol+0x19>
		s++;
  8015cf:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d5:	8a 00                	mov    (%eax),%al
  8015d7:	3c 20                	cmp    $0x20,%al
  8015d9:	74 f4                	je     8015cf <strtol+0x16>
  8015db:	8b 45 08             	mov    0x8(%ebp),%eax
  8015de:	8a 00                	mov    (%eax),%al
  8015e0:	3c 09                	cmp    $0x9,%al
  8015e2:	74 eb                	je     8015cf <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e7:	8a 00                	mov    (%eax),%al
  8015e9:	3c 2b                	cmp    $0x2b,%al
  8015eb:	75 05                	jne    8015f2 <strtol+0x39>
		s++;
  8015ed:	ff 45 08             	incl   0x8(%ebp)
  8015f0:	eb 13                	jmp    801605 <strtol+0x4c>
	else if (*s == '-')
  8015f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f5:	8a 00                	mov    (%eax),%al
  8015f7:	3c 2d                	cmp    $0x2d,%al
  8015f9:	75 0a                	jne    801605 <strtol+0x4c>
		s++, neg = 1;
  8015fb:	ff 45 08             	incl   0x8(%ebp)
  8015fe:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801605:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801609:	74 06                	je     801611 <strtol+0x58>
  80160b:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80160f:	75 20                	jne    801631 <strtol+0x78>
  801611:	8b 45 08             	mov    0x8(%ebp),%eax
  801614:	8a 00                	mov    (%eax),%al
  801616:	3c 30                	cmp    $0x30,%al
  801618:	75 17                	jne    801631 <strtol+0x78>
  80161a:	8b 45 08             	mov    0x8(%ebp),%eax
  80161d:	40                   	inc    %eax
  80161e:	8a 00                	mov    (%eax),%al
  801620:	3c 78                	cmp    $0x78,%al
  801622:	75 0d                	jne    801631 <strtol+0x78>
		s += 2, base = 16;
  801624:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801628:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80162f:	eb 28                	jmp    801659 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801631:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801635:	75 15                	jne    80164c <strtol+0x93>
  801637:	8b 45 08             	mov    0x8(%ebp),%eax
  80163a:	8a 00                	mov    (%eax),%al
  80163c:	3c 30                	cmp    $0x30,%al
  80163e:	75 0c                	jne    80164c <strtol+0x93>
		s++, base = 8;
  801640:	ff 45 08             	incl   0x8(%ebp)
  801643:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80164a:	eb 0d                	jmp    801659 <strtol+0xa0>
	else if (base == 0)
  80164c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801650:	75 07                	jne    801659 <strtol+0xa0>
		base = 10;
  801652:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801659:	8b 45 08             	mov    0x8(%ebp),%eax
  80165c:	8a 00                	mov    (%eax),%al
  80165e:	3c 2f                	cmp    $0x2f,%al
  801660:	7e 19                	jle    80167b <strtol+0xc2>
  801662:	8b 45 08             	mov    0x8(%ebp),%eax
  801665:	8a 00                	mov    (%eax),%al
  801667:	3c 39                	cmp    $0x39,%al
  801669:	7f 10                	jg     80167b <strtol+0xc2>
			dig = *s - '0';
  80166b:	8b 45 08             	mov    0x8(%ebp),%eax
  80166e:	8a 00                	mov    (%eax),%al
  801670:	0f be c0             	movsbl %al,%eax
  801673:	83 e8 30             	sub    $0x30,%eax
  801676:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801679:	eb 42                	jmp    8016bd <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80167b:	8b 45 08             	mov    0x8(%ebp),%eax
  80167e:	8a 00                	mov    (%eax),%al
  801680:	3c 60                	cmp    $0x60,%al
  801682:	7e 19                	jle    80169d <strtol+0xe4>
  801684:	8b 45 08             	mov    0x8(%ebp),%eax
  801687:	8a 00                	mov    (%eax),%al
  801689:	3c 7a                	cmp    $0x7a,%al
  80168b:	7f 10                	jg     80169d <strtol+0xe4>
			dig = *s - 'a' + 10;
  80168d:	8b 45 08             	mov    0x8(%ebp),%eax
  801690:	8a 00                	mov    (%eax),%al
  801692:	0f be c0             	movsbl %al,%eax
  801695:	83 e8 57             	sub    $0x57,%eax
  801698:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80169b:	eb 20                	jmp    8016bd <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80169d:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a0:	8a 00                	mov    (%eax),%al
  8016a2:	3c 40                	cmp    $0x40,%al
  8016a4:	7e 39                	jle    8016df <strtol+0x126>
  8016a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a9:	8a 00                	mov    (%eax),%al
  8016ab:	3c 5a                	cmp    $0x5a,%al
  8016ad:	7f 30                	jg     8016df <strtol+0x126>
			dig = *s - 'A' + 10;
  8016af:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b2:	8a 00                	mov    (%eax),%al
  8016b4:	0f be c0             	movsbl %al,%eax
  8016b7:	83 e8 37             	sub    $0x37,%eax
  8016ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016c0:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016c3:	7d 19                	jge    8016de <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016c5:	ff 45 08             	incl   0x8(%ebp)
  8016c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016cb:	0f af 45 10          	imul   0x10(%ebp),%eax
  8016cf:	89 c2                	mov    %eax,%edx
  8016d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016d4:	01 d0                	add    %edx,%eax
  8016d6:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016d9:	e9 7b ff ff ff       	jmp    801659 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016de:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016df:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016e3:	74 08                	je     8016ed <strtol+0x134>
		*endptr = (char *) s;
  8016e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e8:	8b 55 08             	mov    0x8(%ebp),%edx
  8016eb:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016ed:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016f1:	74 07                	je     8016fa <strtol+0x141>
  8016f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016f6:	f7 d8                	neg    %eax
  8016f8:	eb 03                	jmp    8016fd <strtol+0x144>
  8016fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016fd:	c9                   	leave  
  8016fe:	c3                   	ret    

008016ff <ltostr>:

void
ltostr(long value, char *str)
{
  8016ff:	55                   	push   %ebp
  801700:	89 e5                	mov    %esp,%ebp
  801702:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801705:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80170c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801713:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801717:	79 13                	jns    80172c <ltostr+0x2d>
	{
		neg = 1;
  801719:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801720:	8b 45 0c             	mov    0xc(%ebp),%eax
  801723:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801726:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801729:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80172c:	8b 45 08             	mov    0x8(%ebp),%eax
  80172f:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801734:	99                   	cltd   
  801735:	f7 f9                	idiv   %ecx
  801737:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80173a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80173d:	8d 50 01             	lea    0x1(%eax),%edx
  801740:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801743:	89 c2                	mov    %eax,%edx
  801745:	8b 45 0c             	mov    0xc(%ebp),%eax
  801748:	01 d0                	add    %edx,%eax
  80174a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80174d:	83 c2 30             	add    $0x30,%edx
  801750:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801752:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801755:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80175a:	f7 e9                	imul   %ecx
  80175c:	c1 fa 02             	sar    $0x2,%edx
  80175f:	89 c8                	mov    %ecx,%eax
  801761:	c1 f8 1f             	sar    $0x1f,%eax
  801764:	29 c2                	sub    %eax,%edx
  801766:	89 d0                	mov    %edx,%eax
  801768:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80176b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80176e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801773:	f7 e9                	imul   %ecx
  801775:	c1 fa 02             	sar    $0x2,%edx
  801778:	89 c8                	mov    %ecx,%eax
  80177a:	c1 f8 1f             	sar    $0x1f,%eax
  80177d:	29 c2                	sub    %eax,%edx
  80177f:	89 d0                	mov    %edx,%eax
  801781:	c1 e0 02             	shl    $0x2,%eax
  801784:	01 d0                	add    %edx,%eax
  801786:	01 c0                	add    %eax,%eax
  801788:	29 c1                	sub    %eax,%ecx
  80178a:	89 ca                	mov    %ecx,%edx
  80178c:	85 d2                	test   %edx,%edx
  80178e:	75 9c                	jne    80172c <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801790:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801797:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80179a:	48                   	dec    %eax
  80179b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80179e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017a2:	74 3d                	je     8017e1 <ltostr+0xe2>
		start = 1 ;
  8017a4:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017ab:	eb 34                	jmp    8017e1 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8017ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b3:	01 d0                	add    %edx,%eax
  8017b5:	8a 00                	mov    (%eax),%al
  8017b7:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c0:	01 c2                	add    %eax,%edx
  8017c2:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c8:	01 c8                	add    %ecx,%eax
  8017ca:	8a 00                	mov    (%eax),%al
  8017cc:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017ce:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d4:	01 c2                	add    %eax,%edx
  8017d6:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017d9:	88 02                	mov    %al,(%edx)
		start++ ;
  8017db:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017de:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017e4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017e7:	7c c4                	jl     8017ad <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017e9:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ef:	01 d0                	add    %edx,%eax
  8017f1:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017f4:	90                   	nop
  8017f5:	c9                   	leave  
  8017f6:	c3                   	ret    

008017f7 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017f7:	55                   	push   %ebp
  8017f8:	89 e5                	mov    %esp,%ebp
  8017fa:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017fd:	ff 75 08             	pushl  0x8(%ebp)
  801800:	e8 54 fa ff ff       	call   801259 <strlen>
  801805:	83 c4 04             	add    $0x4,%esp
  801808:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80180b:	ff 75 0c             	pushl  0xc(%ebp)
  80180e:	e8 46 fa ff ff       	call   801259 <strlen>
  801813:	83 c4 04             	add    $0x4,%esp
  801816:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801819:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801820:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801827:	eb 17                	jmp    801840 <strcconcat+0x49>
		final[s] = str1[s] ;
  801829:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80182c:	8b 45 10             	mov    0x10(%ebp),%eax
  80182f:	01 c2                	add    %eax,%edx
  801831:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801834:	8b 45 08             	mov    0x8(%ebp),%eax
  801837:	01 c8                	add    %ecx,%eax
  801839:	8a 00                	mov    (%eax),%al
  80183b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80183d:	ff 45 fc             	incl   -0x4(%ebp)
  801840:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801843:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801846:	7c e1                	jl     801829 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801848:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80184f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801856:	eb 1f                	jmp    801877 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801858:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80185b:	8d 50 01             	lea    0x1(%eax),%edx
  80185e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801861:	89 c2                	mov    %eax,%edx
  801863:	8b 45 10             	mov    0x10(%ebp),%eax
  801866:	01 c2                	add    %eax,%edx
  801868:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80186b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80186e:	01 c8                	add    %ecx,%eax
  801870:	8a 00                	mov    (%eax),%al
  801872:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801874:	ff 45 f8             	incl   -0x8(%ebp)
  801877:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80187a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80187d:	7c d9                	jl     801858 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80187f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801882:	8b 45 10             	mov    0x10(%ebp),%eax
  801885:	01 d0                	add    %edx,%eax
  801887:	c6 00 00             	movb   $0x0,(%eax)
}
  80188a:	90                   	nop
  80188b:	c9                   	leave  
  80188c:	c3                   	ret    

0080188d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80188d:	55                   	push   %ebp
  80188e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801890:	8b 45 14             	mov    0x14(%ebp),%eax
  801893:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801899:	8b 45 14             	mov    0x14(%ebp),%eax
  80189c:	8b 00                	mov    (%eax),%eax
  80189e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8018a8:	01 d0                	add    %edx,%eax
  8018aa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018b0:	eb 0c                	jmp    8018be <strsplit+0x31>
			*string++ = 0;
  8018b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b5:	8d 50 01             	lea    0x1(%eax),%edx
  8018b8:	89 55 08             	mov    %edx,0x8(%ebp)
  8018bb:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018be:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c1:	8a 00                	mov    (%eax),%al
  8018c3:	84 c0                	test   %al,%al
  8018c5:	74 18                	je     8018df <strsplit+0x52>
  8018c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ca:	8a 00                	mov    (%eax),%al
  8018cc:	0f be c0             	movsbl %al,%eax
  8018cf:	50                   	push   %eax
  8018d0:	ff 75 0c             	pushl  0xc(%ebp)
  8018d3:	e8 13 fb ff ff       	call   8013eb <strchr>
  8018d8:	83 c4 08             	add    $0x8,%esp
  8018db:	85 c0                	test   %eax,%eax
  8018dd:	75 d3                	jne    8018b2 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8018df:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e2:	8a 00                	mov    (%eax),%al
  8018e4:	84 c0                	test   %al,%al
  8018e6:	74 5a                	je     801942 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8018e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8018eb:	8b 00                	mov    (%eax),%eax
  8018ed:	83 f8 0f             	cmp    $0xf,%eax
  8018f0:	75 07                	jne    8018f9 <strsplit+0x6c>
		{
			return 0;
  8018f2:	b8 00 00 00 00       	mov    $0x0,%eax
  8018f7:	eb 66                	jmp    80195f <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8018fc:	8b 00                	mov    (%eax),%eax
  8018fe:	8d 48 01             	lea    0x1(%eax),%ecx
  801901:	8b 55 14             	mov    0x14(%ebp),%edx
  801904:	89 0a                	mov    %ecx,(%edx)
  801906:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80190d:	8b 45 10             	mov    0x10(%ebp),%eax
  801910:	01 c2                	add    %eax,%edx
  801912:	8b 45 08             	mov    0x8(%ebp),%eax
  801915:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801917:	eb 03                	jmp    80191c <strsplit+0x8f>
			string++;
  801919:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80191c:	8b 45 08             	mov    0x8(%ebp),%eax
  80191f:	8a 00                	mov    (%eax),%al
  801921:	84 c0                	test   %al,%al
  801923:	74 8b                	je     8018b0 <strsplit+0x23>
  801925:	8b 45 08             	mov    0x8(%ebp),%eax
  801928:	8a 00                	mov    (%eax),%al
  80192a:	0f be c0             	movsbl %al,%eax
  80192d:	50                   	push   %eax
  80192e:	ff 75 0c             	pushl  0xc(%ebp)
  801931:	e8 b5 fa ff ff       	call   8013eb <strchr>
  801936:	83 c4 08             	add    $0x8,%esp
  801939:	85 c0                	test   %eax,%eax
  80193b:	74 dc                	je     801919 <strsplit+0x8c>
			string++;
	}
  80193d:	e9 6e ff ff ff       	jmp    8018b0 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801942:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801943:	8b 45 14             	mov    0x14(%ebp),%eax
  801946:	8b 00                	mov    (%eax),%eax
  801948:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80194f:	8b 45 10             	mov    0x10(%ebp),%eax
  801952:	01 d0                	add    %edx,%eax
  801954:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80195a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80195f:	c9                   	leave  
  801960:	c3                   	ret    

00801961 <malloc>:
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
  801961:	55                   	push   %ebp
  801962:	89 e5                	mov    %esp,%ebp
  801964:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801967:	8b 45 08             	mov    0x8(%ebp),%eax
  80196a:	c1 e8 0c             	shr    $0xc,%eax
  80196d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  801970:	8b 45 08             	mov    0x8(%ebp),%eax
  801973:	25 ff 0f 00 00       	and    $0xfff,%eax
  801978:	85 c0                	test   %eax,%eax
  80197a:	74 03                	je     80197f <malloc+0x1e>
			num++;
  80197c:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  80197f:	a1 04 30 80 00       	mov    0x803004,%eax
  801984:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801989:	75 73                	jne    8019fe <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  80198b:	83 ec 08             	sub    $0x8,%esp
  80198e:	ff 75 08             	pushl  0x8(%ebp)
  801991:	68 00 00 00 80       	push   $0x80000000
  801996:	e8 13 05 00 00       	call   801eae <sys_allocateMem>
  80199b:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  80199e:	a1 04 30 80 00       	mov    0x803004,%eax
  8019a3:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  8019a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019a9:	c1 e0 0c             	shl    $0xc,%eax
  8019ac:	89 c2                	mov    %eax,%edx
  8019ae:	a1 04 30 80 00       	mov    0x803004,%eax
  8019b3:	01 d0                	add    %edx,%eax
  8019b5:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  8019ba:	a1 30 30 80 00       	mov    0x803030,%eax
  8019bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8019c2:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			addresses[sizeofarray]=last_addres;
  8019c9:	a1 30 30 80 00       	mov    0x803030,%eax
  8019ce:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8019d4:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  8019db:	a1 30 30 80 00       	mov    0x803030,%eax
  8019e0:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  8019e7:	01 00 00 00 
			sizeofarray++;
  8019eb:	a1 30 30 80 00       	mov    0x803030,%eax
  8019f0:	40                   	inc    %eax
  8019f1:	a3 30 30 80 00       	mov    %eax,0x803030
			return (void*)return_addres;
  8019f6:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8019f9:	e9 71 01 00 00       	jmp    801b6f <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  8019fe:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a03:	85 c0                	test   %eax,%eax
  801a05:	75 71                	jne    801a78 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  801a07:	a1 04 30 80 00       	mov    0x803004,%eax
  801a0c:	83 ec 08             	sub    $0x8,%esp
  801a0f:	ff 75 08             	pushl  0x8(%ebp)
  801a12:	50                   	push   %eax
  801a13:	e8 96 04 00 00       	call   801eae <sys_allocateMem>
  801a18:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801a1b:	a1 04 30 80 00       	mov    0x803004,%eax
  801a20:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801a23:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a26:	c1 e0 0c             	shl    $0xc,%eax
  801a29:	89 c2                	mov    %eax,%edx
  801a2b:	a1 04 30 80 00       	mov    0x803004,%eax
  801a30:	01 d0                	add    %edx,%eax
  801a32:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  801a37:	a1 30 30 80 00       	mov    0x803030,%eax
  801a3c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a3f:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=return_addres;
  801a46:	a1 30 30 80 00       	mov    0x803030,%eax
  801a4b:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801a4e:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801a55:	a1 30 30 80 00       	mov    0x803030,%eax
  801a5a:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801a61:	01 00 00 00 
				sizeofarray++;
  801a65:	a1 30 30 80 00       	mov    0x803030,%eax
  801a6a:	40                   	inc    %eax
  801a6b:	a3 30 30 80 00       	mov    %eax,0x803030
				return (void*)return_addres;
  801a70:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801a73:	e9 f7 00 00 00       	jmp    801b6f <malloc+0x20e>
			}
			else{
				int count=0;
  801a78:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801a7f:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  801a86:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801a8d:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801a94:	eb 7c                	jmp    801b12 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  801a96:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801a9d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801aa4:	eb 1a                	jmp    801ac0 <malloc+0x15f>
					{
						if(addresses[j]==i)
  801aa6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801aa9:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801ab0:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801ab3:	75 08                	jne    801abd <malloc+0x15c>
						{
							index=j;
  801ab5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801ab8:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801abb:	eb 0d                	jmp    801aca <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801abd:	ff 45 dc             	incl   -0x24(%ebp)
  801ac0:	a1 30 30 80 00       	mov    0x803030,%eax
  801ac5:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801ac8:	7c dc                	jl     801aa6 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  801aca:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801ace:	75 05                	jne    801ad5 <malloc+0x174>
					{
						count++;
  801ad0:	ff 45 f0             	incl   -0x10(%ebp)
  801ad3:	eb 36                	jmp    801b0b <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  801ad5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801ad8:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801adf:	85 c0                	test   %eax,%eax
  801ae1:	75 05                	jne    801ae8 <malloc+0x187>
						{
							count++;
  801ae3:	ff 45 f0             	incl   -0x10(%ebp)
  801ae6:	eb 23                	jmp    801b0b <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  801ae8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801aeb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801aee:	7d 14                	jge    801b04 <malloc+0x1a3>
  801af0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801af3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801af6:	7c 0c                	jl     801b04 <malloc+0x1a3>
							{
								min=count;
  801af8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801afb:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801afe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b01:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  801b04:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801b0b:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801b12:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801b19:	0f 86 77 ff ff ff    	jbe    801a96 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  801b1f:	83 ec 08             	sub    $0x8,%esp
  801b22:	ff 75 08             	pushl  0x8(%ebp)
  801b25:	ff 75 e4             	pushl  -0x1c(%ebp)
  801b28:	e8 81 03 00 00       	call   801eae <sys_allocateMem>
  801b2d:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  801b30:	a1 30 30 80 00       	mov    0x803030,%eax
  801b35:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b38:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801b3f:	a1 30 30 80 00       	mov    0x803030,%eax
  801b44:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801b4a:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801b51:	a1 30 30 80 00       	mov    0x803030,%eax
  801b56:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801b5d:	01 00 00 00 
				sizeofarray++;
  801b61:	a1 30 30 80 00       	mov    0x803030,%eax
  801b66:	40                   	inc    %eax
  801b67:	a3 30 30 80 00       	mov    %eax,0x803030
				return(void*) min_addresss;
  801b6c:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801b6f:	c9                   	leave  
  801b70:	c3                   	ret    

00801b71 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801b71:	55                   	push   %ebp
  801b72:	89 e5                	mov    %esp,%ebp
  801b74:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  801b77:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    uint32 size;
    int is_found=0;
  801b7d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  801b84:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801b8b:	eb 30                	jmp    801bbd <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  801b8d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b90:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801b97:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801b9a:	75 1e                	jne    801bba <free+0x49>
  801b9c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b9f:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801ba6:	83 f8 01             	cmp    $0x1,%eax
  801ba9:	75 0f                	jne    801bba <free+0x49>
    		is_found=1;
  801bab:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  801bb2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801bb5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  801bb8:	eb 0d                	jmp    801bc7 <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    uint32 size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  801bba:	ff 45 ec             	incl   -0x14(%ebp)
  801bbd:	a1 30 30 80 00       	mov    0x803030,%eax
  801bc2:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801bc5:	7c c6                	jl     801b8d <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  801bc7:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801bcb:	75 3a                	jne    801c07 <free+0x96>
    	size=numOfPages[index]*PAGE_SIZE;
  801bcd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bd0:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801bd7:	c1 e0 0c             	shl    $0xc,%eax
  801bda:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  801bdd:	83 ec 08             	sub    $0x8,%esp
  801be0:	ff 75 e4             	pushl  -0x1c(%ebp)
  801be3:	ff 75 e8             	pushl  -0x18(%ebp)
  801be6:	e8 a7 02 00 00       	call   801e92 <sys_freeMem>
  801beb:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  801bee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801bf1:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  801bf8:	00 00 00 00 
    	changes++;
  801bfc:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801c01:	40                   	inc    %eax
  801c02:	a3 2c 30 80 00       	mov    %eax,0x80302c
    }


	//refer to the project presentation and documentation for details
}
  801c07:	90                   	nop
  801c08:	c9                   	leave  
  801c09:	c3                   	ret    

00801c0a <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801c0a:	55                   	push   %ebp
  801c0b:	89 e5                	mov    %esp,%ebp
  801c0d:	83 ec 18             	sub    $0x18,%esp
  801c10:	8b 45 10             	mov    0x10(%ebp),%eax
  801c13:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801c16:	83 ec 04             	sub    $0x4,%esp
  801c19:	68 c4 2c 80 00       	push   $0x802cc4
  801c1e:	68 9f 00 00 00       	push   $0x9f
  801c23:	68 e7 2c 80 00       	push   $0x802ce7
  801c28:	e8 02 eb ff ff       	call   80072f <_panic>

00801c2d <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801c2d:	55                   	push   %ebp
  801c2e:	89 e5                	mov    %esp,%ebp
  801c30:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c33:	83 ec 04             	sub    $0x4,%esp
  801c36:	68 c4 2c 80 00       	push   $0x802cc4
  801c3b:	68 a5 00 00 00       	push   $0xa5
  801c40:	68 e7 2c 80 00       	push   $0x802ce7
  801c45:	e8 e5 ea ff ff       	call   80072f <_panic>

00801c4a <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801c4a:	55                   	push   %ebp
  801c4b:	89 e5                	mov    %esp,%ebp
  801c4d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c50:	83 ec 04             	sub    $0x4,%esp
  801c53:	68 c4 2c 80 00       	push   $0x802cc4
  801c58:	68 ab 00 00 00       	push   $0xab
  801c5d:	68 e7 2c 80 00       	push   $0x802ce7
  801c62:	e8 c8 ea ff ff       	call   80072f <_panic>

00801c67 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801c67:	55                   	push   %ebp
  801c68:	89 e5                	mov    %esp,%ebp
  801c6a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c6d:	83 ec 04             	sub    $0x4,%esp
  801c70:	68 c4 2c 80 00       	push   $0x802cc4
  801c75:	68 b0 00 00 00       	push   $0xb0
  801c7a:	68 e7 2c 80 00       	push   $0x802ce7
  801c7f:	e8 ab ea ff ff       	call   80072f <_panic>

00801c84 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801c84:	55                   	push   %ebp
  801c85:	89 e5                	mov    %esp,%ebp
  801c87:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c8a:	83 ec 04             	sub    $0x4,%esp
  801c8d:	68 c4 2c 80 00       	push   $0x802cc4
  801c92:	68 b6 00 00 00       	push   $0xb6
  801c97:	68 e7 2c 80 00       	push   $0x802ce7
  801c9c:	e8 8e ea ff ff       	call   80072f <_panic>

00801ca1 <shrink>:
}
void shrink(uint32 newSize)
{
  801ca1:	55                   	push   %ebp
  801ca2:	89 e5                	mov    %esp,%ebp
  801ca4:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ca7:	83 ec 04             	sub    $0x4,%esp
  801caa:	68 c4 2c 80 00       	push   $0x802cc4
  801caf:	68 ba 00 00 00       	push   $0xba
  801cb4:	68 e7 2c 80 00       	push   $0x802ce7
  801cb9:	e8 71 ea ff ff       	call   80072f <_panic>

00801cbe <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801cbe:	55                   	push   %ebp
  801cbf:	89 e5                	mov    %esp,%ebp
  801cc1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801cc4:	83 ec 04             	sub    $0x4,%esp
  801cc7:	68 c4 2c 80 00       	push   $0x802cc4
  801ccc:	68 bf 00 00 00       	push   $0xbf
  801cd1:	68 e7 2c 80 00       	push   $0x802ce7
  801cd6:	e8 54 ea ff ff       	call   80072f <_panic>

00801cdb <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801cdb:	55                   	push   %ebp
  801cdc:	89 e5                	mov    %esp,%ebp
  801cde:	57                   	push   %edi
  801cdf:	56                   	push   %esi
  801ce0:	53                   	push   %ebx
  801ce1:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801ce4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cea:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ced:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cf0:	8b 7d 18             	mov    0x18(%ebp),%edi
  801cf3:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801cf6:	cd 30                	int    $0x30
  801cf8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801cfb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801cfe:	83 c4 10             	add    $0x10,%esp
  801d01:	5b                   	pop    %ebx
  801d02:	5e                   	pop    %esi
  801d03:	5f                   	pop    %edi
  801d04:	5d                   	pop    %ebp
  801d05:	c3                   	ret    

00801d06 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801d06:	55                   	push   %ebp
  801d07:	89 e5                	mov    %esp,%ebp
  801d09:	83 ec 04             	sub    $0x4,%esp
  801d0c:	8b 45 10             	mov    0x10(%ebp),%eax
  801d0f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801d12:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d16:	8b 45 08             	mov    0x8(%ebp),%eax
  801d19:	6a 00                	push   $0x0
  801d1b:	6a 00                	push   $0x0
  801d1d:	52                   	push   %edx
  801d1e:	ff 75 0c             	pushl  0xc(%ebp)
  801d21:	50                   	push   %eax
  801d22:	6a 00                	push   $0x0
  801d24:	e8 b2 ff ff ff       	call   801cdb <syscall>
  801d29:	83 c4 18             	add    $0x18,%esp
}
  801d2c:	90                   	nop
  801d2d:	c9                   	leave  
  801d2e:	c3                   	ret    

00801d2f <sys_cgetc>:

int
sys_cgetc(void)
{
  801d2f:	55                   	push   %ebp
  801d30:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801d32:	6a 00                	push   $0x0
  801d34:	6a 00                	push   $0x0
  801d36:	6a 00                	push   $0x0
  801d38:	6a 00                	push   $0x0
  801d3a:	6a 00                	push   $0x0
  801d3c:	6a 01                	push   $0x1
  801d3e:	e8 98 ff ff ff       	call   801cdb <syscall>
  801d43:	83 c4 18             	add    $0x18,%esp
}
  801d46:	c9                   	leave  
  801d47:	c3                   	ret    

00801d48 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801d48:	55                   	push   %ebp
  801d49:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801d4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4e:	6a 00                	push   $0x0
  801d50:	6a 00                	push   $0x0
  801d52:	6a 00                	push   $0x0
  801d54:	6a 00                	push   $0x0
  801d56:	50                   	push   %eax
  801d57:	6a 05                	push   $0x5
  801d59:	e8 7d ff ff ff       	call   801cdb <syscall>
  801d5e:	83 c4 18             	add    $0x18,%esp
}
  801d61:	c9                   	leave  
  801d62:	c3                   	ret    

00801d63 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801d63:	55                   	push   %ebp
  801d64:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801d66:	6a 00                	push   $0x0
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 00                	push   $0x0
  801d6c:	6a 00                	push   $0x0
  801d6e:	6a 00                	push   $0x0
  801d70:	6a 02                	push   $0x2
  801d72:	e8 64 ff ff ff       	call   801cdb <syscall>
  801d77:	83 c4 18             	add    $0x18,%esp
}
  801d7a:	c9                   	leave  
  801d7b:	c3                   	ret    

00801d7c <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801d7c:	55                   	push   %ebp
  801d7d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	6a 00                	push   $0x0
  801d87:	6a 00                	push   $0x0
  801d89:	6a 03                	push   $0x3
  801d8b:	e8 4b ff ff ff       	call   801cdb <syscall>
  801d90:	83 c4 18             	add    $0x18,%esp
}
  801d93:	c9                   	leave  
  801d94:	c3                   	ret    

00801d95 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801d95:	55                   	push   %ebp
  801d96:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	6a 04                	push   $0x4
  801da4:	e8 32 ff ff ff       	call   801cdb <syscall>
  801da9:	83 c4 18             	add    $0x18,%esp
}
  801dac:	c9                   	leave  
  801dad:	c3                   	ret    

00801dae <sys_env_exit>:


void sys_env_exit(void)
{
  801dae:	55                   	push   %ebp
  801daf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801db1:	6a 00                	push   $0x0
  801db3:	6a 00                	push   $0x0
  801db5:	6a 00                	push   $0x0
  801db7:	6a 00                	push   $0x0
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 06                	push   $0x6
  801dbd:	e8 19 ff ff ff       	call   801cdb <syscall>
  801dc2:	83 c4 18             	add    $0x18,%esp
}
  801dc5:	90                   	nop
  801dc6:	c9                   	leave  
  801dc7:	c3                   	ret    

00801dc8 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801dc8:	55                   	push   %ebp
  801dc9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801dcb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dce:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd1:	6a 00                	push   $0x0
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 00                	push   $0x0
  801dd7:	52                   	push   %edx
  801dd8:	50                   	push   %eax
  801dd9:	6a 07                	push   $0x7
  801ddb:	e8 fb fe ff ff       	call   801cdb <syscall>
  801de0:	83 c4 18             	add    $0x18,%esp
}
  801de3:	c9                   	leave  
  801de4:	c3                   	ret    

00801de5 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801de5:	55                   	push   %ebp
  801de6:	89 e5                	mov    %esp,%ebp
  801de8:	56                   	push   %esi
  801de9:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801dea:	8b 75 18             	mov    0x18(%ebp),%esi
  801ded:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801df0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801df3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801df6:	8b 45 08             	mov    0x8(%ebp),%eax
  801df9:	56                   	push   %esi
  801dfa:	53                   	push   %ebx
  801dfb:	51                   	push   %ecx
  801dfc:	52                   	push   %edx
  801dfd:	50                   	push   %eax
  801dfe:	6a 08                	push   $0x8
  801e00:	e8 d6 fe ff ff       	call   801cdb <syscall>
  801e05:	83 c4 18             	add    $0x18,%esp
}
  801e08:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801e0b:	5b                   	pop    %ebx
  801e0c:	5e                   	pop    %esi
  801e0d:	5d                   	pop    %ebp
  801e0e:	c3                   	ret    

00801e0f <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801e0f:	55                   	push   %ebp
  801e10:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801e12:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e15:	8b 45 08             	mov    0x8(%ebp),%eax
  801e18:	6a 00                	push   $0x0
  801e1a:	6a 00                	push   $0x0
  801e1c:	6a 00                	push   $0x0
  801e1e:	52                   	push   %edx
  801e1f:	50                   	push   %eax
  801e20:	6a 09                	push   $0x9
  801e22:	e8 b4 fe ff ff       	call   801cdb <syscall>
  801e27:	83 c4 18             	add    $0x18,%esp
}
  801e2a:	c9                   	leave  
  801e2b:	c3                   	ret    

00801e2c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801e2c:	55                   	push   %ebp
  801e2d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801e2f:	6a 00                	push   $0x0
  801e31:	6a 00                	push   $0x0
  801e33:	6a 00                	push   $0x0
  801e35:	ff 75 0c             	pushl  0xc(%ebp)
  801e38:	ff 75 08             	pushl  0x8(%ebp)
  801e3b:	6a 0a                	push   $0xa
  801e3d:	e8 99 fe ff ff       	call   801cdb <syscall>
  801e42:	83 c4 18             	add    $0x18,%esp
}
  801e45:	c9                   	leave  
  801e46:	c3                   	ret    

00801e47 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801e47:	55                   	push   %ebp
  801e48:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801e4a:	6a 00                	push   $0x0
  801e4c:	6a 00                	push   $0x0
  801e4e:	6a 00                	push   $0x0
  801e50:	6a 00                	push   $0x0
  801e52:	6a 00                	push   $0x0
  801e54:	6a 0b                	push   $0xb
  801e56:	e8 80 fe ff ff       	call   801cdb <syscall>
  801e5b:	83 c4 18             	add    $0x18,%esp
}
  801e5e:	c9                   	leave  
  801e5f:	c3                   	ret    

00801e60 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801e60:	55                   	push   %ebp
  801e61:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801e63:	6a 00                	push   $0x0
  801e65:	6a 00                	push   $0x0
  801e67:	6a 00                	push   $0x0
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 00                	push   $0x0
  801e6d:	6a 0c                	push   $0xc
  801e6f:	e8 67 fe ff ff       	call   801cdb <syscall>
  801e74:	83 c4 18             	add    $0x18,%esp
}
  801e77:	c9                   	leave  
  801e78:	c3                   	ret    

00801e79 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801e79:	55                   	push   %ebp
  801e7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801e7c:	6a 00                	push   $0x0
  801e7e:	6a 00                	push   $0x0
  801e80:	6a 00                	push   $0x0
  801e82:	6a 00                	push   $0x0
  801e84:	6a 00                	push   $0x0
  801e86:	6a 0d                	push   $0xd
  801e88:	e8 4e fe ff ff       	call   801cdb <syscall>
  801e8d:	83 c4 18             	add    $0x18,%esp
}
  801e90:	c9                   	leave  
  801e91:	c3                   	ret    

00801e92 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801e92:	55                   	push   %ebp
  801e93:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801e95:	6a 00                	push   $0x0
  801e97:	6a 00                	push   $0x0
  801e99:	6a 00                	push   $0x0
  801e9b:	ff 75 0c             	pushl  0xc(%ebp)
  801e9e:	ff 75 08             	pushl  0x8(%ebp)
  801ea1:	6a 11                	push   $0x11
  801ea3:	e8 33 fe ff ff       	call   801cdb <syscall>
  801ea8:	83 c4 18             	add    $0x18,%esp
	return;
  801eab:	90                   	nop
}
  801eac:	c9                   	leave  
  801ead:	c3                   	ret    

00801eae <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801eae:	55                   	push   %ebp
  801eaf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801eb1:	6a 00                	push   $0x0
  801eb3:	6a 00                	push   $0x0
  801eb5:	6a 00                	push   $0x0
  801eb7:	ff 75 0c             	pushl  0xc(%ebp)
  801eba:	ff 75 08             	pushl  0x8(%ebp)
  801ebd:	6a 12                	push   $0x12
  801ebf:	e8 17 fe ff ff       	call   801cdb <syscall>
  801ec4:	83 c4 18             	add    $0x18,%esp
	return ;
  801ec7:	90                   	nop
}
  801ec8:	c9                   	leave  
  801ec9:	c3                   	ret    

00801eca <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801eca:	55                   	push   %ebp
  801ecb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801ecd:	6a 00                	push   $0x0
  801ecf:	6a 00                	push   $0x0
  801ed1:	6a 00                	push   $0x0
  801ed3:	6a 00                	push   $0x0
  801ed5:	6a 00                	push   $0x0
  801ed7:	6a 0e                	push   $0xe
  801ed9:	e8 fd fd ff ff       	call   801cdb <syscall>
  801ede:	83 c4 18             	add    $0x18,%esp
}
  801ee1:	c9                   	leave  
  801ee2:	c3                   	ret    

00801ee3 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801ee3:	55                   	push   %ebp
  801ee4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801ee6:	6a 00                	push   $0x0
  801ee8:	6a 00                	push   $0x0
  801eea:	6a 00                	push   $0x0
  801eec:	6a 00                	push   $0x0
  801eee:	ff 75 08             	pushl  0x8(%ebp)
  801ef1:	6a 0f                	push   $0xf
  801ef3:	e8 e3 fd ff ff       	call   801cdb <syscall>
  801ef8:	83 c4 18             	add    $0x18,%esp
}
  801efb:	c9                   	leave  
  801efc:	c3                   	ret    

00801efd <sys_scarce_memory>:

void sys_scarce_memory()
{
  801efd:	55                   	push   %ebp
  801efe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801f00:	6a 00                	push   $0x0
  801f02:	6a 00                	push   $0x0
  801f04:	6a 00                	push   $0x0
  801f06:	6a 00                	push   $0x0
  801f08:	6a 00                	push   $0x0
  801f0a:	6a 10                	push   $0x10
  801f0c:	e8 ca fd ff ff       	call   801cdb <syscall>
  801f11:	83 c4 18             	add    $0x18,%esp
}
  801f14:	90                   	nop
  801f15:	c9                   	leave  
  801f16:	c3                   	ret    

00801f17 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801f17:	55                   	push   %ebp
  801f18:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 00                	push   $0x0
  801f1e:	6a 00                	push   $0x0
  801f20:	6a 00                	push   $0x0
  801f22:	6a 00                	push   $0x0
  801f24:	6a 14                	push   $0x14
  801f26:	e8 b0 fd ff ff       	call   801cdb <syscall>
  801f2b:	83 c4 18             	add    $0x18,%esp
}
  801f2e:	90                   	nop
  801f2f:	c9                   	leave  
  801f30:	c3                   	ret    

00801f31 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801f31:	55                   	push   %ebp
  801f32:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 00                	push   $0x0
  801f3c:	6a 00                	push   $0x0
  801f3e:	6a 15                	push   $0x15
  801f40:	e8 96 fd ff ff       	call   801cdb <syscall>
  801f45:	83 c4 18             	add    $0x18,%esp
}
  801f48:	90                   	nop
  801f49:	c9                   	leave  
  801f4a:	c3                   	ret    

00801f4b <sys_cputc>:


void
sys_cputc(const char c)
{
  801f4b:	55                   	push   %ebp
  801f4c:	89 e5                	mov    %esp,%ebp
  801f4e:	83 ec 04             	sub    $0x4,%esp
  801f51:	8b 45 08             	mov    0x8(%ebp),%eax
  801f54:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801f57:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f5b:	6a 00                	push   $0x0
  801f5d:	6a 00                	push   $0x0
  801f5f:	6a 00                	push   $0x0
  801f61:	6a 00                	push   $0x0
  801f63:	50                   	push   %eax
  801f64:	6a 16                	push   $0x16
  801f66:	e8 70 fd ff ff       	call   801cdb <syscall>
  801f6b:	83 c4 18             	add    $0x18,%esp
}
  801f6e:	90                   	nop
  801f6f:	c9                   	leave  
  801f70:	c3                   	ret    

00801f71 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801f71:	55                   	push   %ebp
  801f72:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801f74:	6a 00                	push   $0x0
  801f76:	6a 00                	push   $0x0
  801f78:	6a 00                	push   $0x0
  801f7a:	6a 00                	push   $0x0
  801f7c:	6a 00                	push   $0x0
  801f7e:	6a 17                	push   $0x17
  801f80:	e8 56 fd ff ff       	call   801cdb <syscall>
  801f85:	83 c4 18             	add    $0x18,%esp
}
  801f88:	90                   	nop
  801f89:	c9                   	leave  
  801f8a:	c3                   	ret    

00801f8b <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801f8b:	55                   	push   %ebp
  801f8c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f91:	6a 00                	push   $0x0
  801f93:	6a 00                	push   $0x0
  801f95:	6a 00                	push   $0x0
  801f97:	ff 75 0c             	pushl  0xc(%ebp)
  801f9a:	50                   	push   %eax
  801f9b:	6a 18                	push   $0x18
  801f9d:	e8 39 fd ff ff       	call   801cdb <syscall>
  801fa2:	83 c4 18             	add    $0x18,%esp
}
  801fa5:	c9                   	leave  
  801fa6:	c3                   	ret    

00801fa7 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801fa7:	55                   	push   %ebp
  801fa8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801faa:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fad:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb0:	6a 00                	push   $0x0
  801fb2:	6a 00                	push   $0x0
  801fb4:	6a 00                	push   $0x0
  801fb6:	52                   	push   %edx
  801fb7:	50                   	push   %eax
  801fb8:	6a 1b                	push   $0x1b
  801fba:	e8 1c fd ff ff       	call   801cdb <syscall>
  801fbf:	83 c4 18             	add    $0x18,%esp
}
  801fc2:	c9                   	leave  
  801fc3:	c3                   	ret    

00801fc4 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801fc4:	55                   	push   %ebp
  801fc5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801fc7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fca:	8b 45 08             	mov    0x8(%ebp),%eax
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 00                	push   $0x0
  801fd3:	52                   	push   %edx
  801fd4:	50                   	push   %eax
  801fd5:	6a 19                	push   $0x19
  801fd7:	e8 ff fc ff ff       	call   801cdb <syscall>
  801fdc:	83 c4 18             	add    $0x18,%esp
}
  801fdf:	90                   	nop
  801fe0:	c9                   	leave  
  801fe1:	c3                   	ret    

00801fe2 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801fe2:	55                   	push   %ebp
  801fe3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801fe5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fe8:	8b 45 08             	mov    0x8(%ebp),%eax
  801feb:	6a 00                	push   $0x0
  801fed:	6a 00                	push   $0x0
  801fef:	6a 00                	push   $0x0
  801ff1:	52                   	push   %edx
  801ff2:	50                   	push   %eax
  801ff3:	6a 1a                	push   $0x1a
  801ff5:	e8 e1 fc ff ff       	call   801cdb <syscall>
  801ffa:	83 c4 18             	add    $0x18,%esp
}
  801ffd:	90                   	nop
  801ffe:	c9                   	leave  
  801fff:	c3                   	ret    

00802000 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802000:	55                   	push   %ebp
  802001:	89 e5                	mov    %esp,%ebp
  802003:	83 ec 04             	sub    $0x4,%esp
  802006:	8b 45 10             	mov    0x10(%ebp),%eax
  802009:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80200c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80200f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802013:	8b 45 08             	mov    0x8(%ebp),%eax
  802016:	6a 00                	push   $0x0
  802018:	51                   	push   %ecx
  802019:	52                   	push   %edx
  80201a:	ff 75 0c             	pushl  0xc(%ebp)
  80201d:	50                   	push   %eax
  80201e:	6a 1c                	push   $0x1c
  802020:	e8 b6 fc ff ff       	call   801cdb <syscall>
  802025:	83 c4 18             	add    $0x18,%esp
}
  802028:	c9                   	leave  
  802029:	c3                   	ret    

0080202a <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80202a:	55                   	push   %ebp
  80202b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80202d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802030:	8b 45 08             	mov    0x8(%ebp),%eax
  802033:	6a 00                	push   $0x0
  802035:	6a 00                	push   $0x0
  802037:	6a 00                	push   $0x0
  802039:	52                   	push   %edx
  80203a:	50                   	push   %eax
  80203b:	6a 1d                	push   $0x1d
  80203d:	e8 99 fc ff ff       	call   801cdb <syscall>
  802042:	83 c4 18             	add    $0x18,%esp
}
  802045:	c9                   	leave  
  802046:	c3                   	ret    

00802047 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802047:	55                   	push   %ebp
  802048:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80204a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80204d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802050:	8b 45 08             	mov    0x8(%ebp),%eax
  802053:	6a 00                	push   $0x0
  802055:	6a 00                	push   $0x0
  802057:	51                   	push   %ecx
  802058:	52                   	push   %edx
  802059:	50                   	push   %eax
  80205a:	6a 1e                	push   $0x1e
  80205c:	e8 7a fc ff ff       	call   801cdb <syscall>
  802061:	83 c4 18             	add    $0x18,%esp
}
  802064:	c9                   	leave  
  802065:	c3                   	ret    

00802066 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802066:	55                   	push   %ebp
  802067:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802069:	8b 55 0c             	mov    0xc(%ebp),%edx
  80206c:	8b 45 08             	mov    0x8(%ebp),%eax
  80206f:	6a 00                	push   $0x0
  802071:	6a 00                	push   $0x0
  802073:	6a 00                	push   $0x0
  802075:	52                   	push   %edx
  802076:	50                   	push   %eax
  802077:	6a 1f                	push   $0x1f
  802079:	e8 5d fc ff ff       	call   801cdb <syscall>
  80207e:	83 c4 18             	add    $0x18,%esp
}
  802081:	c9                   	leave  
  802082:	c3                   	ret    

00802083 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802083:	55                   	push   %ebp
  802084:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802086:	6a 00                	push   $0x0
  802088:	6a 00                	push   $0x0
  80208a:	6a 00                	push   $0x0
  80208c:	6a 00                	push   $0x0
  80208e:	6a 00                	push   $0x0
  802090:	6a 20                	push   $0x20
  802092:	e8 44 fc ff ff       	call   801cdb <syscall>
  802097:	83 c4 18             	add    $0x18,%esp
}
  80209a:	c9                   	leave  
  80209b:	c3                   	ret    

0080209c <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80209c:	55                   	push   %ebp
  80209d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80209f:	8b 45 08             	mov    0x8(%ebp),%eax
  8020a2:	6a 00                	push   $0x0
  8020a4:	ff 75 14             	pushl  0x14(%ebp)
  8020a7:	ff 75 10             	pushl  0x10(%ebp)
  8020aa:	ff 75 0c             	pushl  0xc(%ebp)
  8020ad:	50                   	push   %eax
  8020ae:	6a 21                	push   $0x21
  8020b0:	e8 26 fc ff ff       	call   801cdb <syscall>
  8020b5:	83 c4 18             	add    $0x18,%esp
}
  8020b8:	c9                   	leave  
  8020b9:	c3                   	ret    

008020ba <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8020ba:	55                   	push   %ebp
  8020bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8020bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c0:	6a 00                	push   $0x0
  8020c2:	6a 00                	push   $0x0
  8020c4:	6a 00                	push   $0x0
  8020c6:	6a 00                	push   $0x0
  8020c8:	50                   	push   %eax
  8020c9:	6a 22                	push   $0x22
  8020cb:	e8 0b fc ff ff       	call   801cdb <syscall>
  8020d0:	83 c4 18             	add    $0x18,%esp
}
  8020d3:	90                   	nop
  8020d4:	c9                   	leave  
  8020d5:	c3                   	ret    

008020d6 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8020d6:	55                   	push   %ebp
  8020d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8020d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8020dc:	6a 00                	push   $0x0
  8020de:	6a 00                	push   $0x0
  8020e0:	6a 00                	push   $0x0
  8020e2:	6a 00                	push   $0x0
  8020e4:	50                   	push   %eax
  8020e5:	6a 23                	push   $0x23
  8020e7:	e8 ef fb ff ff       	call   801cdb <syscall>
  8020ec:	83 c4 18             	add    $0x18,%esp
}
  8020ef:	90                   	nop
  8020f0:	c9                   	leave  
  8020f1:	c3                   	ret    

008020f2 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8020f2:	55                   	push   %ebp
  8020f3:	89 e5                	mov    %esp,%ebp
  8020f5:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8020f8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8020fb:	8d 50 04             	lea    0x4(%eax),%edx
  8020fe:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802101:	6a 00                	push   $0x0
  802103:	6a 00                	push   $0x0
  802105:	6a 00                	push   $0x0
  802107:	52                   	push   %edx
  802108:	50                   	push   %eax
  802109:	6a 24                	push   $0x24
  80210b:	e8 cb fb ff ff       	call   801cdb <syscall>
  802110:	83 c4 18             	add    $0x18,%esp
	return result;
  802113:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802116:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802119:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80211c:	89 01                	mov    %eax,(%ecx)
  80211e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802121:	8b 45 08             	mov    0x8(%ebp),%eax
  802124:	c9                   	leave  
  802125:	c2 04 00             	ret    $0x4

00802128 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802128:	55                   	push   %ebp
  802129:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80212b:	6a 00                	push   $0x0
  80212d:	6a 00                	push   $0x0
  80212f:	ff 75 10             	pushl  0x10(%ebp)
  802132:	ff 75 0c             	pushl  0xc(%ebp)
  802135:	ff 75 08             	pushl  0x8(%ebp)
  802138:	6a 13                	push   $0x13
  80213a:	e8 9c fb ff ff       	call   801cdb <syscall>
  80213f:	83 c4 18             	add    $0x18,%esp
	return ;
  802142:	90                   	nop
}
  802143:	c9                   	leave  
  802144:	c3                   	ret    

00802145 <sys_rcr2>:
uint32 sys_rcr2()
{
  802145:	55                   	push   %ebp
  802146:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802148:	6a 00                	push   $0x0
  80214a:	6a 00                	push   $0x0
  80214c:	6a 00                	push   $0x0
  80214e:	6a 00                	push   $0x0
  802150:	6a 00                	push   $0x0
  802152:	6a 25                	push   $0x25
  802154:	e8 82 fb ff ff       	call   801cdb <syscall>
  802159:	83 c4 18             	add    $0x18,%esp
}
  80215c:	c9                   	leave  
  80215d:	c3                   	ret    

0080215e <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80215e:	55                   	push   %ebp
  80215f:	89 e5                	mov    %esp,%ebp
  802161:	83 ec 04             	sub    $0x4,%esp
  802164:	8b 45 08             	mov    0x8(%ebp),%eax
  802167:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80216a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80216e:	6a 00                	push   $0x0
  802170:	6a 00                	push   $0x0
  802172:	6a 00                	push   $0x0
  802174:	6a 00                	push   $0x0
  802176:	50                   	push   %eax
  802177:	6a 26                	push   $0x26
  802179:	e8 5d fb ff ff       	call   801cdb <syscall>
  80217e:	83 c4 18             	add    $0x18,%esp
	return ;
  802181:	90                   	nop
}
  802182:	c9                   	leave  
  802183:	c3                   	ret    

00802184 <rsttst>:
void rsttst()
{
  802184:	55                   	push   %ebp
  802185:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802187:	6a 00                	push   $0x0
  802189:	6a 00                	push   $0x0
  80218b:	6a 00                	push   $0x0
  80218d:	6a 00                	push   $0x0
  80218f:	6a 00                	push   $0x0
  802191:	6a 28                	push   $0x28
  802193:	e8 43 fb ff ff       	call   801cdb <syscall>
  802198:	83 c4 18             	add    $0x18,%esp
	return ;
  80219b:	90                   	nop
}
  80219c:	c9                   	leave  
  80219d:	c3                   	ret    

0080219e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80219e:	55                   	push   %ebp
  80219f:	89 e5                	mov    %esp,%ebp
  8021a1:	83 ec 04             	sub    $0x4,%esp
  8021a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8021a7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8021aa:	8b 55 18             	mov    0x18(%ebp),%edx
  8021ad:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8021b1:	52                   	push   %edx
  8021b2:	50                   	push   %eax
  8021b3:	ff 75 10             	pushl  0x10(%ebp)
  8021b6:	ff 75 0c             	pushl  0xc(%ebp)
  8021b9:	ff 75 08             	pushl  0x8(%ebp)
  8021bc:	6a 27                	push   $0x27
  8021be:	e8 18 fb ff ff       	call   801cdb <syscall>
  8021c3:	83 c4 18             	add    $0x18,%esp
	return ;
  8021c6:	90                   	nop
}
  8021c7:	c9                   	leave  
  8021c8:	c3                   	ret    

008021c9 <chktst>:
void chktst(uint32 n)
{
  8021c9:	55                   	push   %ebp
  8021ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8021cc:	6a 00                	push   $0x0
  8021ce:	6a 00                	push   $0x0
  8021d0:	6a 00                	push   $0x0
  8021d2:	6a 00                	push   $0x0
  8021d4:	ff 75 08             	pushl  0x8(%ebp)
  8021d7:	6a 29                	push   $0x29
  8021d9:	e8 fd fa ff ff       	call   801cdb <syscall>
  8021de:	83 c4 18             	add    $0x18,%esp
	return ;
  8021e1:	90                   	nop
}
  8021e2:	c9                   	leave  
  8021e3:	c3                   	ret    

008021e4 <inctst>:

void inctst()
{
  8021e4:	55                   	push   %ebp
  8021e5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8021e7:	6a 00                	push   $0x0
  8021e9:	6a 00                	push   $0x0
  8021eb:	6a 00                	push   $0x0
  8021ed:	6a 00                	push   $0x0
  8021ef:	6a 00                	push   $0x0
  8021f1:	6a 2a                	push   $0x2a
  8021f3:	e8 e3 fa ff ff       	call   801cdb <syscall>
  8021f8:	83 c4 18             	add    $0x18,%esp
	return ;
  8021fb:	90                   	nop
}
  8021fc:	c9                   	leave  
  8021fd:	c3                   	ret    

008021fe <gettst>:
uint32 gettst()
{
  8021fe:	55                   	push   %ebp
  8021ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802201:	6a 00                	push   $0x0
  802203:	6a 00                	push   $0x0
  802205:	6a 00                	push   $0x0
  802207:	6a 00                	push   $0x0
  802209:	6a 00                	push   $0x0
  80220b:	6a 2b                	push   $0x2b
  80220d:	e8 c9 fa ff ff       	call   801cdb <syscall>
  802212:	83 c4 18             	add    $0x18,%esp
}
  802215:	c9                   	leave  
  802216:	c3                   	ret    

00802217 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802217:	55                   	push   %ebp
  802218:	89 e5                	mov    %esp,%ebp
  80221a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80221d:	6a 00                	push   $0x0
  80221f:	6a 00                	push   $0x0
  802221:	6a 00                	push   $0x0
  802223:	6a 00                	push   $0x0
  802225:	6a 00                	push   $0x0
  802227:	6a 2c                	push   $0x2c
  802229:	e8 ad fa ff ff       	call   801cdb <syscall>
  80222e:	83 c4 18             	add    $0x18,%esp
  802231:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802234:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802238:	75 07                	jne    802241 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80223a:	b8 01 00 00 00       	mov    $0x1,%eax
  80223f:	eb 05                	jmp    802246 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802241:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802246:	c9                   	leave  
  802247:	c3                   	ret    

00802248 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802248:	55                   	push   %ebp
  802249:	89 e5                	mov    %esp,%ebp
  80224b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80224e:	6a 00                	push   $0x0
  802250:	6a 00                	push   $0x0
  802252:	6a 00                	push   $0x0
  802254:	6a 00                	push   $0x0
  802256:	6a 00                	push   $0x0
  802258:	6a 2c                	push   $0x2c
  80225a:	e8 7c fa ff ff       	call   801cdb <syscall>
  80225f:	83 c4 18             	add    $0x18,%esp
  802262:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802265:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802269:	75 07                	jne    802272 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80226b:	b8 01 00 00 00       	mov    $0x1,%eax
  802270:	eb 05                	jmp    802277 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802272:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802277:	c9                   	leave  
  802278:	c3                   	ret    

00802279 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802279:	55                   	push   %ebp
  80227a:	89 e5                	mov    %esp,%ebp
  80227c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80227f:	6a 00                	push   $0x0
  802281:	6a 00                	push   $0x0
  802283:	6a 00                	push   $0x0
  802285:	6a 00                	push   $0x0
  802287:	6a 00                	push   $0x0
  802289:	6a 2c                	push   $0x2c
  80228b:	e8 4b fa ff ff       	call   801cdb <syscall>
  802290:	83 c4 18             	add    $0x18,%esp
  802293:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802296:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80229a:	75 07                	jne    8022a3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80229c:	b8 01 00 00 00       	mov    $0x1,%eax
  8022a1:	eb 05                	jmp    8022a8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8022a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022a8:	c9                   	leave  
  8022a9:	c3                   	ret    

008022aa <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8022aa:	55                   	push   %ebp
  8022ab:	89 e5                	mov    %esp,%ebp
  8022ad:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022b0:	6a 00                	push   $0x0
  8022b2:	6a 00                	push   $0x0
  8022b4:	6a 00                	push   $0x0
  8022b6:	6a 00                	push   $0x0
  8022b8:	6a 00                	push   $0x0
  8022ba:	6a 2c                	push   $0x2c
  8022bc:	e8 1a fa ff ff       	call   801cdb <syscall>
  8022c1:	83 c4 18             	add    $0x18,%esp
  8022c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8022c7:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8022cb:	75 07                	jne    8022d4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8022cd:	b8 01 00 00 00       	mov    $0x1,%eax
  8022d2:	eb 05                	jmp    8022d9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8022d4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022d9:	c9                   	leave  
  8022da:	c3                   	ret    

008022db <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8022db:	55                   	push   %ebp
  8022dc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8022de:	6a 00                	push   $0x0
  8022e0:	6a 00                	push   $0x0
  8022e2:	6a 00                	push   $0x0
  8022e4:	6a 00                	push   $0x0
  8022e6:	ff 75 08             	pushl  0x8(%ebp)
  8022e9:	6a 2d                	push   $0x2d
  8022eb:	e8 eb f9 ff ff       	call   801cdb <syscall>
  8022f0:	83 c4 18             	add    $0x18,%esp
	return ;
  8022f3:	90                   	nop
}
  8022f4:	c9                   	leave  
  8022f5:	c3                   	ret    

008022f6 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8022f6:	55                   	push   %ebp
  8022f7:	89 e5                	mov    %esp,%ebp
  8022f9:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8022fa:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8022fd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802300:	8b 55 0c             	mov    0xc(%ebp),%edx
  802303:	8b 45 08             	mov    0x8(%ebp),%eax
  802306:	6a 00                	push   $0x0
  802308:	53                   	push   %ebx
  802309:	51                   	push   %ecx
  80230a:	52                   	push   %edx
  80230b:	50                   	push   %eax
  80230c:	6a 2e                	push   $0x2e
  80230e:	e8 c8 f9 ff ff       	call   801cdb <syscall>
  802313:	83 c4 18             	add    $0x18,%esp
}
  802316:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802319:	c9                   	leave  
  80231a:	c3                   	ret    

0080231b <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80231b:	55                   	push   %ebp
  80231c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80231e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802321:	8b 45 08             	mov    0x8(%ebp),%eax
  802324:	6a 00                	push   $0x0
  802326:	6a 00                	push   $0x0
  802328:	6a 00                	push   $0x0
  80232a:	52                   	push   %edx
  80232b:	50                   	push   %eax
  80232c:	6a 2f                	push   $0x2f
  80232e:	e8 a8 f9 ff ff       	call   801cdb <syscall>
  802333:	83 c4 18             	add    $0x18,%esp
}
  802336:	c9                   	leave  
  802337:	c3                   	ret    

00802338 <__udivdi3>:
  802338:	55                   	push   %ebp
  802339:	57                   	push   %edi
  80233a:	56                   	push   %esi
  80233b:	53                   	push   %ebx
  80233c:	83 ec 1c             	sub    $0x1c,%esp
  80233f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802343:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802347:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80234b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80234f:	89 ca                	mov    %ecx,%edx
  802351:	89 f8                	mov    %edi,%eax
  802353:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802357:	85 f6                	test   %esi,%esi
  802359:	75 2d                	jne    802388 <__udivdi3+0x50>
  80235b:	39 cf                	cmp    %ecx,%edi
  80235d:	77 65                	ja     8023c4 <__udivdi3+0x8c>
  80235f:	89 fd                	mov    %edi,%ebp
  802361:	85 ff                	test   %edi,%edi
  802363:	75 0b                	jne    802370 <__udivdi3+0x38>
  802365:	b8 01 00 00 00       	mov    $0x1,%eax
  80236a:	31 d2                	xor    %edx,%edx
  80236c:	f7 f7                	div    %edi
  80236e:	89 c5                	mov    %eax,%ebp
  802370:	31 d2                	xor    %edx,%edx
  802372:	89 c8                	mov    %ecx,%eax
  802374:	f7 f5                	div    %ebp
  802376:	89 c1                	mov    %eax,%ecx
  802378:	89 d8                	mov    %ebx,%eax
  80237a:	f7 f5                	div    %ebp
  80237c:	89 cf                	mov    %ecx,%edi
  80237e:	89 fa                	mov    %edi,%edx
  802380:	83 c4 1c             	add    $0x1c,%esp
  802383:	5b                   	pop    %ebx
  802384:	5e                   	pop    %esi
  802385:	5f                   	pop    %edi
  802386:	5d                   	pop    %ebp
  802387:	c3                   	ret    
  802388:	39 ce                	cmp    %ecx,%esi
  80238a:	77 28                	ja     8023b4 <__udivdi3+0x7c>
  80238c:	0f bd fe             	bsr    %esi,%edi
  80238f:	83 f7 1f             	xor    $0x1f,%edi
  802392:	75 40                	jne    8023d4 <__udivdi3+0x9c>
  802394:	39 ce                	cmp    %ecx,%esi
  802396:	72 0a                	jb     8023a2 <__udivdi3+0x6a>
  802398:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80239c:	0f 87 9e 00 00 00    	ja     802440 <__udivdi3+0x108>
  8023a2:	b8 01 00 00 00       	mov    $0x1,%eax
  8023a7:	89 fa                	mov    %edi,%edx
  8023a9:	83 c4 1c             	add    $0x1c,%esp
  8023ac:	5b                   	pop    %ebx
  8023ad:	5e                   	pop    %esi
  8023ae:	5f                   	pop    %edi
  8023af:	5d                   	pop    %ebp
  8023b0:	c3                   	ret    
  8023b1:	8d 76 00             	lea    0x0(%esi),%esi
  8023b4:	31 ff                	xor    %edi,%edi
  8023b6:	31 c0                	xor    %eax,%eax
  8023b8:	89 fa                	mov    %edi,%edx
  8023ba:	83 c4 1c             	add    $0x1c,%esp
  8023bd:	5b                   	pop    %ebx
  8023be:	5e                   	pop    %esi
  8023bf:	5f                   	pop    %edi
  8023c0:	5d                   	pop    %ebp
  8023c1:	c3                   	ret    
  8023c2:	66 90                	xchg   %ax,%ax
  8023c4:	89 d8                	mov    %ebx,%eax
  8023c6:	f7 f7                	div    %edi
  8023c8:	31 ff                	xor    %edi,%edi
  8023ca:	89 fa                	mov    %edi,%edx
  8023cc:	83 c4 1c             	add    $0x1c,%esp
  8023cf:	5b                   	pop    %ebx
  8023d0:	5e                   	pop    %esi
  8023d1:	5f                   	pop    %edi
  8023d2:	5d                   	pop    %ebp
  8023d3:	c3                   	ret    
  8023d4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8023d9:	89 eb                	mov    %ebp,%ebx
  8023db:	29 fb                	sub    %edi,%ebx
  8023dd:	89 f9                	mov    %edi,%ecx
  8023df:	d3 e6                	shl    %cl,%esi
  8023e1:	89 c5                	mov    %eax,%ebp
  8023e3:	88 d9                	mov    %bl,%cl
  8023e5:	d3 ed                	shr    %cl,%ebp
  8023e7:	89 e9                	mov    %ebp,%ecx
  8023e9:	09 f1                	or     %esi,%ecx
  8023eb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8023ef:	89 f9                	mov    %edi,%ecx
  8023f1:	d3 e0                	shl    %cl,%eax
  8023f3:	89 c5                	mov    %eax,%ebp
  8023f5:	89 d6                	mov    %edx,%esi
  8023f7:	88 d9                	mov    %bl,%cl
  8023f9:	d3 ee                	shr    %cl,%esi
  8023fb:	89 f9                	mov    %edi,%ecx
  8023fd:	d3 e2                	shl    %cl,%edx
  8023ff:	8b 44 24 08          	mov    0x8(%esp),%eax
  802403:	88 d9                	mov    %bl,%cl
  802405:	d3 e8                	shr    %cl,%eax
  802407:	09 c2                	or     %eax,%edx
  802409:	89 d0                	mov    %edx,%eax
  80240b:	89 f2                	mov    %esi,%edx
  80240d:	f7 74 24 0c          	divl   0xc(%esp)
  802411:	89 d6                	mov    %edx,%esi
  802413:	89 c3                	mov    %eax,%ebx
  802415:	f7 e5                	mul    %ebp
  802417:	39 d6                	cmp    %edx,%esi
  802419:	72 19                	jb     802434 <__udivdi3+0xfc>
  80241b:	74 0b                	je     802428 <__udivdi3+0xf0>
  80241d:	89 d8                	mov    %ebx,%eax
  80241f:	31 ff                	xor    %edi,%edi
  802421:	e9 58 ff ff ff       	jmp    80237e <__udivdi3+0x46>
  802426:	66 90                	xchg   %ax,%ax
  802428:	8b 54 24 08          	mov    0x8(%esp),%edx
  80242c:	89 f9                	mov    %edi,%ecx
  80242e:	d3 e2                	shl    %cl,%edx
  802430:	39 c2                	cmp    %eax,%edx
  802432:	73 e9                	jae    80241d <__udivdi3+0xe5>
  802434:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802437:	31 ff                	xor    %edi,%edi
  802439:	e9 40 ff ff ff       	jmp    80237e <__udivdi3+0x46>
  80243e:	66 90                	xchg   %ax,%ax
  802440:	31 c0                	xor    %eax,%eax
  802442:	e9 37 ff ff ff       	jmp    80237e <__udivdi3+0x46>
  802447:	90                   	nop

00802448 <__umoddi3>:
  802448:	55                   	push   %ebp
  802449:	57                   	push   %edi
  80244a:	56                   	push   %esi
  80244b:	53                   	push   %ebx
  80244c:	83 ec 1c             	sub    $0x1c,%esp
  80244f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802453:	8b 74 24 34          	mov    0x34(%esp),%esi
  802457:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80245b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80245f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802463:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802467:	89 f3                	mov    %esi,%ebx
  802469:	89 fa                	mov    %edi,%edx
  80246b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80246f:	89 34 24             	mov    %esi,(%esp)
  802472:	85 c0                	test   %eax,%eax
  802474:	75 1a                	jne    802490 <__umoddi3+0x48>
  802476:	39 f7                	cmp    %esi,%edi
  802478:	0f 86 a2 00 00 00    	jbe    802520 <__umoddi3+0xd8>
  80247e:	89 c8                	mov    %ecx,%eax
  802480:	89 f2                	mov    %esi,%edx
  802482:	f7 f7                	div    %edi
  802484:	89 d0                	mov    %edx,%eax
  802486:	31 d2                	xor    %edx,%edx
  802488:	83 c4 1c             	add    $0x1c,%esp
  80248b:	5b                   	pop    %ebx
  80248c:	5e                   	pop    %esi
  80248d:	5f                   	pop    %edi
  80248e:	5d                   	pop    %ebp
  80248f:	c3                   	ret    
  802490:	39 f0                	cmp    %esi,%eax
  802492:	0f 87 ac 00 00 00    	ja     802544 <__umoddi3+0xfc>
  802498:	0f bd e8             	bsr    %eax,%ebp
  80249b:	83 f5 1f             	xor    $0x1f,%ebp
  80249e:	0f 84 ac 00 00 00    	je     802550 <__umoddi3+0x108>
  8024a4:	bf 20 00 00 00       	mov    $0x20,%edi
  8024a9:	29 ef                	sub    %ebp,%edi
  8024ab:	89 fe                	mov    %edi,%esi
  8024ad:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8024b1:	89 e9                	mov    %ebp,%ecx
  8024b3:	d3 e0                	shl    %cl,%eax
  8024b5:	89 d7                	mov    %edx,%edi
  8024b7:	89 f1                	mov    %esi,%ecx
  8024b9:	d3 ef                	shr    %cl,%edi
  8024bb:	09 c7                	or     %eax,%edi
  8024bd:	89 e9                	mov    %ebp,%ecx
  8024bf:	d3 e2                	shl    %cl,%edx
  8024c1:	89 14 24             	mov    %edx,(%esp)
  8024c4:	89 d8                	mov    %ebx,%eax
  8024c6:	d3 e0                	shl    %cl,%eax
  8024c8:	89 c2                	mov    %eax,%edx
  8024ca:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024ce:	d3 e0                	shl    %cl,%eax
  8024d0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8024d4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024d8:	89 f1                	mov    %esi,%ecx
  8024da:	d3 e8                	shr    %cl,%eax
  8024dc:	09 d0                	or     %edx,%eax
  8024de:	d3 eb                	shr    %cl,%ebx
  8024e0:	89 da                	mov    %ebx,%edx
  8024e2:	f7 f7                	div    %edi
  8024e4:	89 d3                	mov    %edx,%ebx
  8024e6:	f7 24 24             	mull   (%esp)
  8024e9:	89 c6                	mov    %eax,%esi
  8024eb:	89 d1                	mov    %edx,%ecx
  8024ed:	39 d3                	cmp    %edx,%ebx
  8024ef:	0f 82 87 00 00 00    	jb     80257c <__umoddi3+0x134>
  8024f5:	0f 84 91 00 00 00    	je     80258c <__umoddi3+0x144>
  8024fb:	8b 54 24 04          	mov    0x4(%esp),%edx
  8024ff:	29 f2                	sub    %esi,%edx
  802501:	19 cb                	sbb    %ecx,%ebx
  802503:	89 d8                	mov    %ebx,%eax
  802505:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802509:	d3 e0                	shl    %cl,%eax
  80250b:	89 e9                	mov    %ebp,%ecx
  80250d:	d3 ea                	shr    %cl,%edx
  80250f:	09 d0                	or     %edx,%eax
  802511:	89 e9                	mov    %ebp,%ecx
  802513:	d3 eb                	shr    %cl,%ebx
  802515:	89 da                	mov    %ebx,%edx
  802517:	83 c4 1c             	add    $0x1c,%esp
  80251a:	5b                   	pop    %ebx
  80251b:	5e                   	pop    %esi
  80251c:	5f                   	pop    %edi
  80251d:	5d                   	pop    %ebp
  80251e:	c3                   	ret    
  80251f:	90                   	nop
  802520:	89 fd                	mov    %edi,%ebp
  802522:	85 ff                	test   %edi,%edi
  802524:	75 0b                	jne    802531 <__umoddi3+0xe9>
  802526:	b8 01 00 00 00       	mov    $0x1,%eax
  80252b:	31 d2                	xor    %edx,%edx
  80252d:	f7 f7                	div    %edi
  80252f:	89 c5                	mov    %eax,%ebp
  802531:	89 f0                	mov    %esi,%eax
  802533:	31 d2                	xor    %edx,%edx
  802535:	f7 f5                	div    %ebp
  802537:	89 c8                	mov    %ecx,%eax
  802539:	f7 f5                	div    %ebp
  80253b:	89 d0                	mov    %edx,%eax
  80253d:	e9 44 ff ff ff       	jmp    802486 <__umoddi3+0x3e>
  802542:	66 90                	xchg   %ax,%ax
  802544:	89 c8                	mov    %ecx,%eax
  802546:	89 f2                	mov    %esi,%edx
  802548:	83 c4 1c             	add    $0x1c,%esp
  80254b:	5b                   	pop    %ebx
  80254c:	5e                   	pop    %esi
  80254d:	5f                   	pop    %edi
  80254e:	5d                   	pop    %ebp
  80254f:	c3                   	ret    
  802550:	3b 04 24             	cmp    (%esp),%eax
  802553:	72 06                	jb     80255b <__umoddi3+0x113>
  802555:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802559:	77 0f                	ja     80256a <__umoddi3+0x122>
  80255b:	89 f2                	mov    %esi,%edx
  80255d:	29 f9                	sub    %edi,%ecx
  80255f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802563:	89 14 24             	mov    %edx,(%esp)
  802566:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80256a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80256e:	8b 14 24             	mov    (%esp),%edx
  802571:	83 c4 1c             	add    $0x1c,%esp
  802574:	5b                   	pop    %ebx
  802575:	5e                   	pop    %esi
  802576:	5f                   	pop    %edi
  802577:	5d                   	pop    %ebp
  802578:	c3                   	ret    
  802579:	8d 76 00             	lea    0x0(%esi),%esi
  80257c:	2b 04 24             	sub    (%esp),%eax
  80257f:	19 fa                	sbb    %edi,%edx
  802581:	89 d1                	mov    %edx,%ecx
  802583:	89 c6                	mov    %eax,%esi
  802585:	e9 71 ff ff ff       	jmp    8024fb <__umoddi3+0xb3>
  80258a:	66 90                	xchg   %ax,%ax
  80258c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802590:	72 ea                	jb     80257c <__umoddi3+0x134>
  802592:	89 d9                	mov    %ebx,%ecx
  802594:	e9 62 ff ff ff       	jmp    8024fb <__umoddi3+0xb3>
