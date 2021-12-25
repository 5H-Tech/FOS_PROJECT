
obj/user/quicksort:     file format elf32-i386


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
  800031:	e8 c2 05 00 00       	call   8005f8 <libmain>
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
  800049:	e8 bf 1e 00 00       	call   801f0d <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 d1 1e 00 00       	call   801f26 <sys_calculate_modified_frames>
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
  800067:	68 80 26 80 00       	push   $0x802680
  80006c:	e8 f0 0f 00 00       	call   801061 <readline>
  800071:	83 c4 10             	add    $0x10,%esp
			int NumOfElements = strtol(Line, NULL, 10) ;
  800074:	83 ec 04             	sub    $0x4,%esp
  800077:	6a 0a                	push   $0xa
  800079:	6a 00                	push   $0x0
  80007b:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800081:	50                   	push   %eax
  800082:	e8 40 15 00 00       	call   8015c7 <strtol>
  800087:	83 c4 10             	add    $0x10,%esp
  80008a:	89 45 ec             	mov    %eax,-0x14(%ebp)
			int *Elements = malloc(sizeof(int) * NumOfElements) ;
  80008d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800090:	c1 e0 02             	shl    $0x2,%eax
  800093:	83 ec 0c             	sub    $0xc,%esp
  800096:	50                   	push   %eax
  800097:	e8 d3 18 00 00       	call   80196f <malloc>
  80009c:	83 c4 10             	add    $0x10,%esp
  80009f:	89 45 e8             	mov    %eax,-0x18(%ebp)
			cprintf("Choose the initialization method:\n") ;
  8000a2:	83 ec 0c             	sub    $0xc,%esp
  8000a5:	68 a0 26 80 00       	push   $0x8026a0
  8000aa:	e8 30 09 00 00       	call   8009df <cprintf>
  8000af:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000b2:	83 ec 0c             	sub    $0xc,%esp
  8000b5:	68 c3 26 80 00       	push   $0x8026c3
  8000ba:	e8 20 09 00 00       	call   8009df <cprintf>
  8000bf:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000c2:	83 ec 0c             	sub    $0xc,%esp
  8000c5:	68 d1 26 80 00       	push   $0x8026d1
  8000ca:	e8 10 09 00 00       	call   8009df <cprintf>
  8000cf:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\n");
  8000d2:	83 ec 0c             	sub    $0xc,%esp
  8000d5:	68 e0 26 80 00       	push   $0x8026e0
  8000da:	e8 00 09 00 00       	call   8009df <cprintf>
  8000df:	83 c4 10             	add    $0x10,%esp
			do
			{
				cprintf("Select: ") ;
  8000e2:	83 ec 0c             	sub    $0xc,%esp
  8000e5:	68 f0 26 80 00       	push   $0x8026f0
  8000ea:	e8 f0 08 00 00       	call   8009df <cprintf>
  8000ef:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  8000f2:	e8 a9 04 00 00       	call   8005a0 <getchar>
  8000f7:	88 45 e7             	mov    %al,-0x19(%ebp)
				cputchar(Chose);
  8000fa:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  8000fe:	83 ec 0c             	sub    $0xc,%esp
  800101:	50                   	push   %eax
  800102:	e8 51 04 00 00       	call   800558 <cputchar>
  800107:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80010a:	83 ec 0c             	sub    $0xc,%esp
  80010d:	6a 0a                	push   $0xa
  80010f:	e8 44 04 00 00       	call   800558 <cputchar>
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
  800145:	e8 d6 02 00 00       	call   800420 <InitializeAscending>
  80014a:	83 c4 10             	add    $0x10,%esp
			break ;
  80014d:	eb 37                	jmp    800186 <_main+0x14e>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80014f:	83 ec 08             	sub    $0x8,%esp
  800152:	ff 75 ec             	pushl  -0x14(%ebp)
  800155:	ff 75 e8             	pushl  -0x18(%ebp)
  800158:	e8 f4 02 00 00       	call   800451 <InitializeDescending>
  80015d:	83 c4 10             	add    $0x10,%esp
			break ;
  800160:	eb 24                	jmp    800186 <_main+0x14e>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800162:	83 ec 08             	sub    $0x8,%esp
  800165:	ff 75 ec             	pushl  -0x14(%ebp)
  800168:	ff 75 e8             	pushl  -0x18(%ebp)
  80016b:	e8 16 03 00 00       	call   800486 <InitializeSemiRandom>
  800170:	83 c4 10             	add    $0x10,%esp
			break ;
  800173:	eb 11                	jmp    800186 <_main+0x14e>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800175:	83 ec 08             	sub    $0x8,%esp
  800178:	ff 75 ec             	pushl  -0x14(%ebp)
  80017b:	ff 75 e8             	pushl  -0x18(%ebp)
  80017e:	e8 03 03 00 00       	call   800486 <InitializeSemiRandom>
  800183:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  800186:	83 ec 08             	sub    $0x8,%esp
  800189:	ff 75 ec             	pushl  -0x14(%ebp)
  80018c:	ff 75 e8             	pushl  -0x18(%ebp)
  80018f:	e8 d1 00 00 00       	call   800265 <QuickSort>
  800194:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800197:	83 ec 08             	sub    $0x8,%esp
  80019a:	ff 75 ec             	pushl  -0x14(%ebp)
  80019d:	ff 75 e8             	pushl  -0x18(%ebp)
  8001a0:	e8 d1 01 00 00       	call   800376 <CheckSorted>
  8001a5:	83 c4 10             	add    $0x10,%esp
  8001a8:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001ab:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8001af:	75 14                	jne    8001c5 <_main+0x18d>
  8001b1:	83 ec 04             	sub    $0x4,%esp
  8001b4:	68 fc 26 80 00       	push   $0x8026fc
  8001b9:	6a 46                	push   $0x46
  8001bb:	68 1e 27 80 00       	push   $0x80271e
  8001c0:	e8 78 05 00 00       	call   80073d <_panic>
		else
		{ 
				cprintf("\n===============================================\n") ;
  8001c5:	83 ec 0c             	sub    $0xc,%esp
  8001c8:	68 30 27 80 00       	push   $0x802730
  8001cd:	e8 0d 08 00 00       	call   8009df <cprintf>
  8001d2:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001d5:	83 ec 0c             	sub    $0xc,%esp
  8001d8:	68 64 27 80 00       	push   $0x802764
  8001dd:	e8 fd 07 00 00       	call   8009df <cprintf>
  8001e2:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  8001e5:	83 ec 0c             	sub    $0xc,%esp
  8001e8:	68 98 27 80 00       	push   $0x802798
  8001ed:	e8 ed 07 00 00       	call   8009df <cprintf>
  8001f2:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

			cprintf("Freeing the Heap...\n\n") ;
  8001f5:	83 ec 0c             	sub    $0xc,%esp
  8001f8:	68 ca 27 80 00       	push   $0x8027ca
  8001fd:	e8 dd 07 00 00       	call   8009df <cprintf>
  800202:	83 c4 10             	add    $0x10,%esp

			free(Elements) ;
  800205:	83 ec 0c             	sub    $0xc,%esp
  800208:	ff 75 e8             	pushl  -0x18(%ebp)
  80020b:	e8 27 1a 00 00       	call   801c37 <free>
  800210:	83 c4 10             	add    $0x10,%esp


		///========================================================================
	//sys_disable_interrupt();
			cprintf("Do you want to repeat (y/n): ") ;
  800213:	83 ec 0c             	sub    $0xc,%esp
  800216:	68 e0 27 80 00       	push   $0x8027e0
  80021b:	e8 bf 07 00 00       	call   8009df <cprintf>
  800220:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800223:	e8 78 03 00 00       	call   8005a0 <getchar>
  800228:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  80022b:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  80022f:	83 ec 0c             	sub    $0xc,%esp
  800232:	50                   	push   %eax
  800233:	e8 20 03 00 00       	call   800558 <cputchar>
  800238:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80023b:	83 ec 0c             	sub    $0xc,%esp
  80023e:	6a 0a                	push   $0xa
  800240:	e8 13 03 00 00       	call   800558 <cputchar>
  800245:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800248:	83 ec 0c             	sub    $0xc,%esp
  80024b:	6a 0a                	push   $0xa
  80024d:	e8 06 03 00 00       	call   800558 <cputchar>
  800252:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();

	} while (Chose == 'y');
  800255:	80 7d e7 79          	cmpb   $0x79,-0x19(%ebp)
  800259:	0f 84 ea fd ff ff    	je     800049 <_main+0x11>

}
  80025f:	90                   	nop
  800260:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800263:	c9                   	leave  
  800264:	c3                   	ret    

00800265 <QuickSort>:

///Quick sort 
void QuickSort(int *Elements, int NumOfElements)
{
  800265:	55                   	push   %ebp
  800266:	89 e5                	mov    %esp,%ebp
  800268:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  80026b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80026e:	48                   	dec    %eax
  80026f:	50                   	push   %eax
  800270:	6a 00                	push   $0x0
  800272:	ff 75 0c             	pushl  0xc(%ebp)
  800275:	ff 75 08             	pushl  0x8(%ebp)
  800278:	e8 06 00 00 00       	call   800283 <QSort>
  80027d:	83 c4 10             	add    $0x10,%esp
}
  800280:	90                   	nop
  800281:	c9                   	leave  
  800282:	c3                   	ret    

00800283 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800283:	55                   	push   %ebp
  800284:	89 e5                	mov    %esp,%ebp
  800286:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  800289:	8b 45 10             	mov    0x10(%ebp),%eax
  80028c:	3b 45 14             	cmp    0x14(%ebp),%eax
  80028f:	0f 8d de 00 00 00    	jge    800373 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800295:	8b 45 10             	mov    0x10(%ebp),%eax
  800298:	40                   	inc    %eax
  800299:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80029c:	8b 45 14             	mov    0x14(%ebp),%eax
  80029f:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002a2:	e9 80 00 00 00       	jmp    800327 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8002a7:	ff 45 f4             	incl   -0xc(%ebp)
  8002aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002ad:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002b0:	7f 2b                	jg     8002dd <QSort+0x5a>
  8002b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8002b5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8002bf:	01 d0                	add    %edx,%eax
  8002c1:	8b 10                	mov    (%eax),%edx
  8002c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002c6:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d0:	01 c8                	add    %ecx,%eax
  8002d2:	8b 00                	mov    (%eax),%eax
  8002d4:	39 c2                	cmp    %eax,%edx
  8002d6:	7d cf                	jge    8002a7 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002d8:	eb 03                	jmp    8002dd <QSort+0x5a>
  8002da:	ff 4d f0             	decl   -0x10(%ebp)
  8002dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002e0:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002e3:	7e 26                	jle    80030b <QSort+0x88>
  8002e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f2:	01 d0                	add    %edx,%eax
  8002f4:	8b 10                	mov    (%eax),%edx
  8002f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002f9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800300:	8b 45 08             	mov    0x8(%ebp),%eax
  800303:	01 c8                	add    %ecx,%eax
  800305:	8b 00                	mov    (%eax),%eax
  800307:	39 c2                	cmp    %eax,%edx
  800309:	7e cf                	jle    8002da <QSort+0x57>

		if (i <= j)
  80030b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80030e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800311:	7f 14                	jg     800327 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800313:	83 ec 04             	sub    $0x4,%esp
  800316:	ff 75 f0             	pushl  -0x10(%ebp)
  800319:	ff 75 f4             	pushl  -0xc(%ebp)
  80031c:	ff 75 08             	pushl  0x8(%ebp)
  80031f:	e8 a9 00 00 00       	call   8003cd <Swap>
  800324:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800327:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80032a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80032d:	0f 8e 77 ff ff ff    	jle    8002aa <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800333:	83 ec 04             	sub    $0x4,%esp
  800336:	ff 75 f0             	pushl  -0x10(%ebp)
  800339:	ff 75 10             	pushl  0x10(%ebp)
  80033c:	ff 75 08             	pushl  0x8(%ebp)
  80033f:	e8 89 00 00 00       	call   8003cd <Swap>
  800344:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800347:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80034a:	48                   	dec    %eax
  80034b:	50                   	push   %eax
  80034c:	ff 75 10             	pushl  0x10(%ebp)
  80034f:	ff 75 0c             	pushl  0xc(%ebp)
  800352:	ff 75 08             	pushl  0x8(%ebp)
  800355:	e8 29 ff ff ff       	call   800283 <QSort>
  80035a:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  80035d:	ff 75 14             	pushl  0x14(%ebp)
  800360:	ff 75 f4             	pushl  -0xc(%ebp)
  800363:	ff 75 0c             	pushl  0xc(%ebp)
  800366:	ff 75 08             	pushl  0x8(%ebp)
  800369:	e8 15 ff ff ff       	call   800283 <QSort>
  80036e:	83 c4 10             	add    $0x10,%esp
  800371:	eb 01                	jmp    800374 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800373:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800374:	c9                   	leave  
  800375:	c3                   	ret    

00800376 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800376:	55                   	push   %ebp
  800377:	89 e5                	mov    %esp,%ebp
  800379:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  80037c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800383:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80038a:	eb 33                	jmp    8003bf <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80038c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80038f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800396:	8b 45 08             	mov    0x8(%ebp),%eax
  800399:	01 d0                	add    %edx,%eax
  80039b:	8b 10                	mov    (%eax),%edx
  80039d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003a0:	40                   	inc    %eax
  8003a1:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ab:	01 c8                	add    %ecx,%eax
  8003ad:	8b 00                	mov    (%eax),%eax
  8003af:	39 c2                	cmp    %eax,%edx
  8003b1:	7e 09                	jle    8003bc <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8003ba:	eb 0c                	jmp    8003c8 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003bc:	ff 45 f8             	incl   -0x8(%ebp)
  8003bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c2:	48                   	dec    %eax
  8003c3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8003c6:	7f c4                	jg     80038c <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003cb:	c9                   	leave  
  8003cc:	c3                   	ret    

008003cd <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003cd:	55                   	push   %ebp
  8003ce:	89 e5                	mov    %esp,%ebp
  8003d0:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003d6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e0:	01 d0                	add    %edx,%eax
  8003e2:	8b 00                	mov    (%eax),%eax
  8003e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8003e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f4:	01 c2                	add    %eax,%edx
  8003f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8003f9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800400:	8b 45 08             	mov    0x8(%ebp),%eax
  800403:	01 c8                	add    %ecx,%eax
  800405:	8b 00                	mov    (%eax),%eax
  800407:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800409:	8b 45 10             	mov    0x10(%ebp),%eax
  80040c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800413:	8b 45 08             	mov    0x8(%ebp),%eax
  800416:	01 c2                	add    %eax,%edx
  800418:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80041b:	89 02                	mov    %eax,(%edx)
}
  80041d:	90                   	nop
  80041e:	c9                   	leave  
  80041f:	c3                   	ret    

00800420 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800420:	55                   	push   %ebp
  800421:	89 e5                	mov    %esp,%ebp
  800423:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800426:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80042d:	eb 17                	jmp    800446 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80042f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800432:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800439:	8b 45 08             	mov    0x8(%ebp),%eax
  80043c:	01 c2                	add    %eax,%edx
  80043e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800441:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800443:	ff 45 fc             	incl   -0x4(%ebp)
  800446:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800449:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80044c:	7c e1                	jl     80042f <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80044e:	90                   	nop
  80044f:	c9                   	leave  
  800450:	c3                   	ret    

00800451 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800451:	55                   	push   %ebp
  800452:	89 e5                	mov    %esp,%ebp
  800454:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800457:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80045e:	eb 1b                	jmp    80047b <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800460:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800463:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046a:	8b 45 08             	mov    0x8(%ebp),%eax
  80046d:	01 c2                	add    %eax,%edx
  80046f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800472:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800475:	48                   	dec    %eax
  800476:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800478:	ff 45 fc             	incl   -0x4(%ebp)
  80047b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80047e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800481:	7c dd                	jl     800460 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800483:	90                   	nop
  800484:	c9                   	leave  
  800485:	c3                   	ret    

00800486 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800486:	55                   	push   %ebp
  800487:	89 e5                	mov    %esp,%ebp
  800489:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80048c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80048f:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800494:	f7 e9                	imul   %ecx
  800496:	c1 f9 1f             	sar    $0x1f,%ecx
  800499:	89 d0                	mov    %edx,%eax
  80049b:	29 c8                	sub    %ecx,%eax
  80049d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004a7:	eb 1e                	jmp    8004c7 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8004a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ac:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b6:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8004b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004bc:	99                   	cltd   
  8004bd:	f7 7d f8             	idivl  -0x8(%ebp)
  8004c0:	89 d0                	mov    %edx,%eax
  8004c2:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004c4:	ff 45 fc             	incl   -0x4(%ebp)
  8004c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ca:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004cd:	7c da                	jl     8004a9 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8004cf:	90                   	nop
  8004d0:	c9                   	leave  
  8004d1:	c3                   	ret    

008004d2 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004d2:	55                   	push   %ebp
  8004d3:	89 e5                	mov    %esp,%ebp
  8004d5:	83 ec 18             	sub    $0x18,%esp
		int i ;
		int NumsPerLine = 20 ;
  8004d8:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
		for (i = 0 ; i < NumOfElements-1 ; i++)
  8004df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004e6:	eb 42                	jmp    80052a <PrintElements+0x58>
		{
			if (i%NumsPerLine == 0)
  8004e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004eb:	99                   	cltd   
  8004ec:	f7 7d f0             	idivl  -0x10(%ebp)
  8004ef:	89 d0                	mov    %edx,%eax
  8004f1:	85 c0                	test   %eax,%eax
  8004f3:	75 10                	jne    800505 <PrintElements+0x33>
				cprintf("\n");
  8004f5:	83 ec 0c             	sub    $0xc,%esp
  8004f8:	68 fe 27 80 00       	push   $0x8027fe
  8004fd:	e8 dd 04 00 00       	call   8009df <cprintf>
  800502:	83 c4 10             	add    $0x10,%esp
			cprintf("%d, ",Elements[i]);
  800505:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800508:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80050f:	8b 45 08             	mov    0x8(%ebp),%eax
  800512:	01 d0                	add    %edx,%eax
  800514:	8b 00                	mov    (%eax),%eax
  800516:	83 ec 08             	sub    $0x8,%esp
  800519:	50                   	push   %eax
  80051a:	68 00 28 80 00       	push   $0x802800
  80051f:	e8 bb 04 00 00       	call   8009df <cprintf>
  800524:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
		int i ;
		int NumsPerLine = 20 ;
		for (i = 0 ; i < NumOfElements-1 ; i++)
  800527:	ff 45 f4             	incl   -0xc(%ebp)
  80052a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80052d:	48                   	dec    %eax
  80052e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800531:	7f b5                	jg     8004e8 <PrintElements+0x16>
		{
			if (i%NumsPerLine == 0)
				cprintf("\n");
			cprintf("%d, ",Elements[i]);
		}
		cprintf("%d\n",Elements[i]);
  800533:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800536:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80053d:	8b 45 08             	mov    0x8(%ebp),%eax
  800540:	01 d0                	add    %edx,%eax
  800542:	8b 00                	mov    (%eax),%eax
  800544:	83 ec 08             	sub    $0x8,%esp
  800547:	50                   	push   %eax
  800548:	68 05 28 80 00       	push   $0x802805
  80054d:	e8 8d 04 00 00       	call   8009df <cprintf>
  800552:	83 c4 10             	add    $0x10,%esp
}
  800555:	90                   	nop
  800556:	c9                   	leave  
  800557:	c3                   	ret    

00800558 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800558:	55                   	push   %ebp
  800559:	89 e5                	mov    %esp,%ebp
  80055b:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80055e:	8b 45 08             	mov    0x8(%ebp),%eax
  800561:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800564:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800568:	83 ec 0c             	sub    $0xc,%esp
  80056b:	50                   	push   %eax
  80056c:	e8 a0 1a 00 00       	call   802011 <sys_cputc>
  800571:	83 c4 10             	add    $0x10,%esp
}
  800574:	90                   	nop
  800575:	c9                   	leave  
  800576:	c3                   	ret    

00800577 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800577:	55                   	push   %ebp
  800578:	89 e5                	mov    %esp,%ebp
  80057a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80057d:	e8 5b 1a 00 00       	call   801fdd <sys_disable_interrupt>
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
  800590:	e8 7c 1a 00 00       	call   802011 <sys_cputc>
  800595:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800598:	e8 5a 1a 00 00       	call   801ff7 <sys_enable_interrupt>
}
  80059d:	90                   	nop
  80059e:	c9                   	leave  
  80059f:	c3                   	ret    

008005a0 <getchar>:

int
getchar(void)
{
  8005a0:	55                   	push   %ebp
  8005a1:	89 e5                	mov    %esp,%ebp
  8005a3:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8005a6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005ad:	eb 08                	jmp    8005b7 <getchar+0x17>
	{
		c = sys_cgetc();
  8005af:	e8 41 18 00 00       	call   801df5 <sys_cgetc>
  8005b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8005b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005bb:	74 f2                	je     8005af <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8005bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005c0:	c9                   	leave  
  8005c1:	c3                   	ret    

008005c2 <atomic_getchar>:

int
atomic_getchar(void)
{
  8005c2:	55                   	push   %ebp
  8005c3:	89 e5                	mov    %esp,%ebp
  8005c5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005c8:	e8 10 1a 00 00       	call   801fdd <sys_disable_interrupt>
	int c=0;
  8005cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005d4:	eb 08                	jmp    8005de <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005d6:	e8 1a 18 00 00       	call   801df5 <sys_cgetc>
  8005db:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8005de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005e2:	74 f2                	je     8005d6 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8005e4:	e8 0e 1a 00 00       	call   801ff7 <sys_enable_interrupt>
	return c;
  8005e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005ec:	c9                   	leave  
  8005ed:	c3                   	ret    

008005ee <iscons>:

int iscons(int fdnum)
{
  8005ee:	55                   	push   %ebp
  8005ef:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005f1:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8005f6:	5d                   	pop    %ebp
  8005f7:	c3                   	ret    

008005f8 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005f8:	55                   	push   %ebp
  8005f9:	89 e5                	mov    %esp,%ebp
  8005fb:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005fe:	e8 3f 18 00 00       	call   801e42 <sys_getenvindex>
  800603:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800606:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800609:	89 d0                	mov    %edx,%eax
  80060b:	c1 e0 03             	shl    $0x3,%eax
  80060e:	01 d0                	add    %edx,%eax
  800610:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800617:	01 c8                	add    %ecx,%eax
  800619:	01 c0                	add    %eax,%eax
  80061b:	01 d0                	add    %edx,%eax
  80061d:	01 c0                	add    %eax,%eax
  80061f:	01 d0                	add    %edx,%eax
  800621:	89 c2                	mov    %eax,%edx
  800623:	c1 e2 05             	shl    $0x5,%edx
  800626:	29 c2                	sub    %eax,%edx
  800628:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80062f:	89 c2                	mov    %eax,%edx
  800631:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800637:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80063c:	a1 24 30 80 00       	mov    0x803024,%eax
  800641:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800647:	84 c0                	test   %al,%al
  800649:	74 0f                	je     80065a <libmain+0x62>
		binaryname = myEnv->prog_name;
  80064b:	a1 24 30 80 00       	mov    0x803024,%eax
  800650:	05 40 3c 01 00       	add    $0x13c40,%eax
  800655:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80065a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80065e:	7e 0a                	jle    80066a <libmain+0x72>
		binaryname = argv[0];
  800660:	8b 45 0c             	mov    0xc(%ebp),%eax
  800663:	8b 00                	mov    (%eax),%eax
  800665:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80066a:	83 ec 08             	sub    $0x8,%esp
  80066d:	ff 75 0c             	pushl  0xc(%ebp)
  800670:	ff 75 08             	pushl  0x8(%ebp)
  800673:	e8 c0 f9 ff ff       	call   800038 <_main>
  800678:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80067b:	e8 5d 19 00 00       	call   801fdd <sys_disable_interrupt>
	cprintf("**************************************\n");
  800680:	83 ec 0c             	sub    $0xc,%esp
  800683:	68 24 28 80 00       	push   $0x802824
  800688:	e8 52 03 00 00       	call   8009df <cprintf>
  80068d:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800690:	a1 24 30 80 00       	mov    0x803024,%eax
  800695:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80069b:	a1 24 30 80 00       	mov    0x803024,%eax
  8006a0:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8006a6:	83 ec 04             	sub    $0x4,%esp
  8006a9:	52                   	push   %edx
  8006aa:	50                   	push   %eax
  8006ab:	68 4c 28 80 00       	push   $0x80284c
  8006b0:	e8 2a 03 00 00       	call   8009df <cprintf>
  8006b5:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8006b8:	a1 24 30 80 00       	mov    0x803024,%eax
  8006bd:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8006c3:	a1 24 30 80 00       	mov    0x803024,%eax
  8006c8:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8006ce:	83 ec 04             	sub    $0x4,%esp
  8006d1:	52                   	push   %edx
  8006d2:	50                   	push   %eax
  8006d3:	68 74 28 80 00       	push   $0x802874
  8006d8:	e8 02 03 00 00       	call   8009df <cprintf>
  8006dd:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006e0:	a1 24 30 80 00       	mov    0x803024,%eax
  8006e5:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8006eb:	83 ec 08             	sub    $0x8,%esp
  8006ee:	50                   	push   %eax
  8006ef:	68 b5 28 80 00       	push   $0x8028b5
  8006f4:	e8 e6 02 00 00       	call   8009df <cprintf>
  8006f9:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006fc:	83 ec 0c             	sub    $0xc,%esp
  8006ff:	68 24 28 80 00       	push   $0x802824
  800704:	e8 d6 02 00 00       	call   8009df <cprintf>
  800709:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80070c:	e8 e6 18 00 00       	call   801ff7 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800711:	e8 19 00 00 00       	call   80072f <exit>
}
  800716:	90                   	nop
  800717:	c9                   	leave  
  800718:	c3                   	ret    

00800719 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800719:	55                   	push   %ebp
  80071a:	89 e5                	mov    %esp,%ebp
  80071c:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80071f:	83 ec 0c             	sub    $0xc,%esp
  800722:	6a 00                	push   $0x0
  800724:	e8 e5 16 00 00       	call   801e0e <sys_env_destroy>
  800729:	83 c4 10             	add    $0x10,%esp
}
  80072c:	90                   	nop
  80072d:	c9                   	leave  
  80072e:	c3                   	ret    

0080072f <exit>:

void
exit(void)
{
  80072f:	55                   	push   %ebp
  800730:	89 e5                	mov    %esp,%ebp
  800732:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800735:	e8 3a 17 00 00       	call   801e74 <sys_env_exit>
}
  80073a:	90                   	nop
  80073b:	c9                   	leave  
  80073c:	c3                   	ret    

0080073d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80073d:	55                   	push   %ebp
  80073e:	89 e5                	mov    %esp,%ebp
  800740:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800743:	8d 45 10             	lea    0x10(%ebp),%eax
  800746:	83 c0 04             	add    $0x4,%eax
  800749:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80074c:	a1 18 31 80 00       	mov    0x803118,%eax
  800751:	85 c0                	test   %eax,%eax
  800753:	74 16                	je     80076b <_panic+0x2e>
		cprintf("%s: ", argv0);
  800755:	a1 18 31 80 00       	mov    0x803118,%eax
  80075a:	83 ec 08             	sub    $0x8,%esp
  80075d:	50                   	push   %eax
  80075e:	68 cc 28 80 00       	push   $0x8028cc
  800763:	e8 77 02 00 00       	call   8009df <cprintf>
  800768:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80076b:	a1 00 30 80 00       	mov    0x803000,%eax
  800770:	ff 75 0c             	pushl  0xc(%ebp)
  800773:	ff 75 08             	pushl  0x8(%ebp)
  800776:	50                   	push   %eax
  800777:	68 d1 28 80 00       	push   $0x8028d1
  80077c:	e8 5e 02 00 00       	call   8009df <cprintf>
  800781:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800784:	8b 45 10             	mov    0x10(%ebp),%eax
  800787:	83 ec 08             	sub    $0x8,%esp
  80078a:	ff 75 f4             	pushl  -0xc(%ebp)
  80078d:	50                   	push   %eax
  80078e:	e8 e1 01 00 00       	call   800974 <vcprintf>
  800793:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800796:	83 ec 08             	sub    $0x8,%esp
  800799:	6a 00                	push   $0x0
  80079b:	68 ed 28 80 00       	push   $0x8028ed
  8007a0:	e8 cf 01 00 00       	call   800974 <vcprintf>
  8007a5:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8007a8:	e8 82 ff ff ff       	call   80072f <exit>

	// should not return here
	while (1) ;
  8007ad:	eb fe                	jmp    8007ad <_panic+0x70>

008007af <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007af:	55                   	push   %ebp
  8007b0:	89 e5                	mov    %esp,%ebp
  8007b2:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007b5:	a1 24 30 80 00       	mov    0x803024,%eax
  8007ba:	8b 50 74             	mov    0x74(%eax),%edx
  8007bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007c0:	39 c2                	cmp    %eax,%edx
  8007c2:	74 14                	je     8007d8 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007c4:	83 ec 04             	sub    $0x4,%esp
  8007c7:	68 f0 28 80 00       	push   $0x8028f0
  8007cc:	6a 26                	push   $0x26
  8007ce:	68 3c 29 80 00       	push   $0x80293c
  8007d3:	e8 65 ff ff ff       	call   80073d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007df:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007e6:	e9 b6 00 00 00       	jmp    8008a1 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8007eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007ee:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f8:	01 d0                	add    %edx,%eax
  8007fa:	8b 00                	mov    (%eax),%eax
  8007fc:	85 c0                	test   %eax,%eax
  8007fe:	75 08                	jne    800808 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800800:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800803:	e9 96 00 00 00       	jmp    80089e <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800808:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80080f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800816:	eb 5d                	jmp    800875 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800818:	a1 24 30 80 00       	mov    0x803024,%eax
  80081d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800823:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800826:	c1 e2 04             	shl    $0x4,%edx
  800829:	01 d0                	add    %edx,%eax
  80082b:	8a 40 04             	mov    0x4(%eax),%al
  80082e:	84 c0                	test   %al,%al
  800830:	75 40                	jne    800872 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800832:	a1 24 30 80 00       	mov    0x803024,%eax
  800837:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80083d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800840:	c1 e2 04             	shl    $0x4,%edx
  800843:	01 d0                	add    %edx,%eax
  800845:	8b 00                	mov    (%eax),%eax
  800847:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80084a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80084d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800852:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800854:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800857:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80085e:	8b 45 08             	mov    0x8(%ebp),%eax
  800861:	01 c8                	add    %ecx,%eax
  800863:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800865:	39 c2                	cmp    %eax,%edx
  800867:	75 09                	jne    800872 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800869:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800870:	eb 12                	jmp    800884 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800872:	ff 45 e8             	incl   -0x18(%ebp)
  800875:	a1 24 30 80 00       	mov    0x803024,%eax
  80087a:	8b 50 74             	mov    0x74(%eax),%edx
  80087d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800880:	39 c2                	cmp    %eax,%edx
  800882:	77 94                	ja     800818 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800884:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800888:	75 14                	jne    80089e <CheckWSWithoutLastIndex+0xef>
			panic(
  80088a:	83 ec 04             	sub    $0x4,%esp
  80088d:	68 48 29 80 00       	push   $0x802948
  800892:	6a 3a                	push   $0x3a
  800894:	68 3c 29 80 00       	push   $0x80293c
  800899:	e8 9f fe ff ff       	call   80073d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80089e:	ff 45 f0             	incl   -0x10(%ebp)
  8008a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008a4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008a7:	0f 8c 3e ff ff ff    	jl     8007eb <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008ad:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008b4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008bb:	eb 20                	jmp    8008dd <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008bd:	a1 24 30 80 00       	mov    0x803024,%eax
  8008c2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8008c8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008cb:	c1 e2 04             	shl    $0x4,%edx
  8008ce:	01 d0                	add    %edx,%eax
  8008d0:	8a 40 04             	mov    0x4(%eax),%al
  8008d3:	3c 01                	cmp    $0x1,%al
  8008d5:	75 03                	jne    8008da <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8008d7:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008da:	ff 45 e0             	incl   -0x20(%ebp)
  8008dd:	a1 24 30 80 00       	mov    0x803024,%eax
  8008e2:	8b 50 74             	mov    0x74(%eax),%edx
  8008e5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008e8:	39 c2                	cmp    %eax,%edx
  8008ea:	77 d1                	ja     8008bd <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008ef:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008f2:	74 14                	je     800908 <CheckWSWithoutLastIndex+0x159>
		panic(
  8008f4:	83 ec 04             	sub    $0x4,%esp
  8008f7:	68 9c 29 80 00       	push   $0x80299c
  8008fc:	6a 44                	push   $0x44
  8008fe:	68 3c 29 80 00       	push   $0x80293c
  800903:	e8 35 fe ff ff       	call   80073d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800908:	90                   	nop
  800909:	c9                   	leave  
  80090a:	c3                   	ret    

0080090b <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80090b:	55                   	push   %ebp
  80090c:	89 e5                	mov    %esp,%ebp
  80090e:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800911:	8b 45 0c             	mov    0xc(%ebp),%eax
  800914:	8b 00                	mov    (%eax),%eax
  800916:	8d 48 01             	lea    0x1(%eax),%ecx
  800919:	8b 55 0c             	mov    0xc(%ebp),%edx
  80091c:	89 0a                	mov    %ecx,(%edx)
  80091e:	8b 55 08             	mov    0x8(%ebp),%edx
  800921:	88 d1                	mov    %dl,%cl
  800923:	8b 55 0c             	mov    0xc(%ebp),%edx
  800926:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80092a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80092d:	8b 00                	mov    (%eax),%eax
  80092f:	3d ff 00 00 00       	cmp    $0xff,%eax
  800934:	75 2c                	jne    800962 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800936:	a0 28 30 80 00       	mov    0x803028,%al
  80093b:	0f b6 c0             	movzbl %al,%eax
  80093e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800941:	8b 12                	mov    (%edx),%edx
  800943:	89 d1                	mov    %edx,%ecx
  800945:	8b 55 0c             	mov    0xc(%ebp),%edx
  800948:	83 c2 08             	add    $0x8,%edx
  80094b:	83 ec 04             	sub    $0x4,%esp
  80094e:	50                   	push   %eax
  80094f:	51                   	push   %ecx
  800950:	52                   	push   %edx
  800951:	e8 76 14 00 00       	call   801dcc <sys_cputs>
  800956:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800959:	8b 45 0c             	mov    0xc(%ebp),%eax
  80095c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800962:	8b 45 0c             	mov    0xc(%ebp),%eax
  800965:	8b 40 04             	mov    0x4(%eax),%eax
  800968:	8d 50 01             	lea    0x1(%eax),%edx
  80096b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80096e:	89 50 04             	mov    %edx,0x4(%eax)
}
  800971:	90                   	nop
  800972:	c9                   	leave  
  800973:	c3                   	ret    

00800974 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800974:	55                   	push   %ebp
  800975:	89 e5                	mov    %esp,%ebp
  800977:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80097d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800984:	00 00 00 
	b.cnt = 0;
  800987:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80098e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800991:	ff 75 0c             	pushl  0xc(%ebp)
  800994:	ff 75 08             	pushl  0x8(%ebp)
  800997:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80099d:	50                   	push   %eax
  80099e:	68 0b 09 80 00       	push   $0x80090b
  8009a3:	e8 11 02 00 00       	call   800bb9 <vprintfmt>
  8009a8:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009ab:	a0 28 30 80 00       	mov    0x803028,%al
  8009b0:	0f b6 c0             	movzbl %al,%eax
  8009b3:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009b9:	83 ec 04             	sub    $0x4,%esp
  8009bc:	50                   	push   %eax
  8009bd:	52                   	push   %edx
  8009be:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009c4:	83 c0 08             	add    $0x8,%eax
  8009c7:	50                   	push   %eax
  8009c8:	e8 ff 13 00 00       	call   801dcc <sys_cputs>
  8009cd:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009d0:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  8009d7:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009dd:	c9                   	leave  
  8009de:	c3                   	ret    

008009df <cprintf>:

int cprintf(const char *fmt, ...) {
  8009df:	55                   	push   %ebp
  8009e0:	89 e5                	mov    %esp,%ebp
  8009e2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009e5:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  8009ec:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f5:	83 ec 08             	sub    $0x8,%esp
  8009f8:	ff 75 f4             	pushl  -0xc(%ebp)
  8009fb:	50                   	push   %eax
  8009fc:	e8 73 ff ff ff       	call   800974 <vcprintf>
  800a01:	83 c4 10             	add    $0x10,%esp
  800a04:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a07:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a0a:	c9                   	leave  
  800a0b:	c3                   	ret    

00800a0c <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a0c:	55                   	push   %ebp
  800a0d:	89 e5                	mov    %esp,%ebp
  800a0f:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a12:	e8 c6 15 00 00       	call   801fdd <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a17:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a20:	83 ec 08             	sub    $0x8,%esp
  800a23:	ff 75 f4             	pushl  -0xc(%ebp)
  800a26:	50                   	push   %eax
  800a27:	e8 48 ff ff ff       	call   800974 <vcprintf>
  800a2c:	83 c4 10             	add    $0x10,%esp
  800a2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a32:	e8 c0 15 00 00       	call   801ff7 <sys_enable_interrupt>
	return cnt;
  800a37:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a3a:	c9                   	leave  
  800a3b:	c3                   	ret    

00800a3c <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a3c:	55                   	push   %ebp
  800a3d:	89 e5                	mov    %esp,%ebp
  800a3f:	53                   	push   %ebx
  800a40:	83 ec 14             	sub    $0x14,%esp
  800a43:	8b 45 10             	mov    0x10(%ebp),%eax
  800a46:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a49:	8b 45 14             	mov    0x14(%ebp),%eax
  800a4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a4f:	8b 45 18             	mov    0x18(%ebp),%eax
  800a52:	ba 00 00 00 00       	mov    $0x0,%edx
  800a57:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a5a:	77 55                	ja     800ab1 <printnum+0x75>
  800a5c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a5f:	72 05                	jb     800a66 <printnum+0x2a>
  800a61:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a64:	77 4b                	ja     800ab1 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a66:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a69:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a6c:	8b 45 18             	mov    0x18(%ebp),%eax
  800a6f:	ba 00 00 00 00       	mov    $0x0,%edx
  800a74:	52                   	push   %edx
  800a75:	50                   	push   %eax
  800a76:	ff 75 f4             	pushl  -0xc(%ebp)
  800a79:	ff 75 f0             	pushl  -0x10(%ebp)
  800a7c:	e8 7f 19 00 00       	call   802400 <__udivdi3>
  800a81:	83 c4 10             	add    $0x10,%esp
  800a84:	83 ec 04             	sub    $0x4,%esp
  800a87:	ff 75 20             	pushl  0x20(%ebp)
  800a8a:	53                   	push   %ebx
  800a8b:	ff 75 18             	pushl  0x18(%ebp)
  800a8e:	52                   	push   %edx
  800a8f:	50                   	push   %eax
  800a90:	ff 75 0c             	pushl  0xc(%ebp)
  800a93:	ff 75 08             	pushl  0x8(%ebp)
  800a96:	e8 a1 ff ff ff       	call   800a3c <printnum>
  800a9b:	83 c4 20             	add    $0x20,%esp
  800a9e:	eb 1a                	jmp    800aba <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800aa0:	83 ec 08             	sub    $0x8,%esp
  800aa3:	ff 75 0c             	pushl  0xc(%ebp)
  800aa6:	ff 75 20             	pushl  0x20(%ebp)
  800aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aac:	ff d0                	call   *%eax
  800aae:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800ab1:	ff 4d 1c             	decl   0x1c(%ebp)
  800ab4:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800ab8:	7f e6                	jg     800aa0 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800aba:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800abd:	bb 00 00 00 00       	mov    $0x0,%ebx
  800ac2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ac5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ac8:	53                   	push   %ebx
  800ac9:	51                   	push   %ecx
  800aca:	52                   	push   %edx
  800acb:	50                   	push   %eax
  800acc:	e8 3f 1a 00 00       	call   802510 <__umoddi3>
  800ad1:	83 c4 10             	add    $0x10,%esp
  800ad4:	05 14 2c 80 00       	add    $0x802c14,%eax
  800ad9:	8a 00                	mov    (%eax),%al
  800adb:	0f be c0             	movsbl %al,%eax
  800ade:	83 ec 08             	sub    $0x8,%esp
  800ae1:	ff 75 0c             	pushl  0xc(%ebp)
  800ae4:	50                   	push   %eax
  800ae5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae8:	ff d0                	call   *%eax
  800aea:	83 c4 10             	add    $0x10,%esp
}
  800aed:	90                   	nop
  800aee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800af1:	c9                   	leave  
  800af2:	c3                   	ret    

00800af3 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800af3:	55                   	push   %ebp
  800af4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800af6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800afa:	7e 1c                	jle    800b18 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800afc:	8b 45 08             	mov    0x8(%ebp),%eax
  800aff:	8b 00                	mov    (%eax),%eax
  800b01:	8d 50 08             	lea    0x8(%eax),%edx
  800b04:	8b 45 08             	mov    0x8(%ebp),%eax
  800b07:	89 10                	mov    %edx,(%eax)
  800b09:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0c:	8b 00                	mov    (%eax),%eax
  800b0e:	83 e8 08             	sub    $0x8,%eax
  800b11:	8b 50 04             	mov    0x4(%eax),%edx
  800b14:	8b 00                	mov    (%eax),%eax
  800b16:	eb 40                	jmp    800b58 <getuint+0x65>
	else if (lflag)
  800b18:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b1c:	74 1e                	je     800b3c <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b21:	8b 00                	mov    (%eax),%eax
  800b23:	8d 50 04             	lea    0x4(%eax),%edx
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
  800b29:	89 10                	mov    %edx,(%eax)
  800b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2e:	8b 00                	mov    (%eax),%eax
  800b30:	83 e8 04             	sub    $0x4,%eax
  800b33:	8b 00                	mov    (%eax),%eax
  800b35:	ba 00 00 00 00       	mov    $0x0,%edx
  800b3a:	eb 1c                	jmp    800b58 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3f:	8b 00                	mov    (%eax),%eax
  800b41:	8d 50 04             	lea    0x4(%eax),%edx
  800b44:	8b 45 08             	mov    0x8(%ebp),%eax
  800b47:	89 10                	mov    %edx,(%eax)
  800b49:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4c:	8b 00                	mov    (%eax),%eax
  800b4e:	83 e8 04             	sub    $0x4,%eax
  800b51:	8b 00                	mov    (%eax),%eax
  800b53:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b58:	5d                   	pop    %ebp
  800b59:	c3                   	ret    

00800b5a <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b5a:	55                   	push   %ebp
  800b5b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b5d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b61:	7e 1c                	jle    800b7f <getint+0x25>
		return va_arg(*ap, long long);
  800b63:	8b 45 08             	mov    0x8(%ebp),%eax
  800b66:	8b 00                	mov    (%eax),%eax
  800b68:	8d 50 08             	lea    0x8(%eax),%edx
  800b6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6e:	89 10                	mov    %edx,(%eax)
  800b70:	8b 45 08             	mov    0x8(%ebp),%eax
  800b73:	8b 00                	mov    (%eax),%eax
  800b75:	83 e8 08             	sub    $0x8,%eax
  800b78:	8b 50 04             	mov    0x4(%eax),%edx
  800b7b:	8b 00                	mov    (%eax),%eax
  800b7d:	eb 38                	jmp    800bb7 <getint+0x5d>
	else if (lflag)
  800b7f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b83:	74 1a                	je     800b9f <getint+0x45>
		return va_arg(*ap, long);
  800b85:	8b 45 08             	mov    0x8(%ebp),%eax
  800b88:	8b 00                	mov    (%eax),%eax
  800b8a:	8d 50 04             	lea    0x4(%eax),%edx
  800b8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b90:	89 10                	mov    %edx,(%eax)
  800b92:	8b 45 08             	mov    0x8(%ebp),%eax
  800b95:	8b 00                	mov    (%eax),%eax
  800b97:	83 e8 04             	sub    $0x4,%eax
  800b9a:	8b 00                	mov    (%eax),%eax
  800b9c:	99                   	cltd   
  800b9d:	eb 18                	jmp    800bb7 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba2:	8b 00                	mov    (%eax),%eax
  800ba4:	8d 50 04             	lea    0x4(%eax),%edx
  800ba7:	8b 45 08             	mov    0x8(%ebp),%eax
  800baa:	89 10                	mov    %edx,(%eax)
  800bac:	8b 45 08             	mov    0x8(%ebp),%eax
  800baf:	8b 00                	mov    (%eax),%eax
  800bb1:	83 e8 04             	sub    $0x4,%eax
  800bb4:	8b 00                	mov    (%eax),%eax
  800bb6:	99                   	cltd   
}
  800bb7:	5d                   	pop    %ebp
  800bb8:	c3                   	ret    

00800bb9 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bb9:	55                   	push   %ebp
  800bba:	89 e5                	mov    %esp,%ebp
  800bbc:	56                   	push   %esi
  800bbd:	53                   	push   %ebx
  800bbe:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bc1:	eb 17                	jmp    800bda <vprintfmt+0x21>
			if (ch == '\0')
  800bc3:	85 db                	test   %ebx,%ebx
  800bc5:	0f 84 af 03 00 00    	je     800f7a <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bcb:	83 ec 08             	sub    $0x8,%esp
  800bce:	ff 75 0c             	pushl  0xc(%ebp)
  800bd1:	53                   	push   %ebx
  800bd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd5:	ff d0                	call   *%eax
  800bd7:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bda:	8b 45 10             	mov    0x10(%ebp),%eax
  800bdd:	8d 50 01             	lea    0x1(%eax),%edx
  800be0:	89 55 10             	mov    %edx,0x10(%ebp)
  800be3:	8a 00                	mov    (%eax),%al
  800be5:	0f b6 d8             	movzbl %al,%ebx
  800be8:	83 fb 25             	cmp    $0x25,%ebx
  800beb:	75 d6                	jne    800bc3 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bed:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bf1:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bf8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bff:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c06:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c0d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c10:	8d 50 01             	lea    0x1(%eax),%edx
  800c13:	89 55 10             	mov    %edx,0x10(%ebp)
  800c16:	8a 00                	mov    (%eax),%al
  800c18:	0f b6 d8             	movzbl %al,%ebx
  800c1b:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c1e:	83 f8 55             	cmp    $0x55,%eax
  800c21:	0f 87 2b 03 00 00    	ja     800f52 <vprintfmt+0x399>
  800c27:	8b 04 85 38 2c 80 00 	mov    0x802c38(,%eax,4),%eax
  800c2e:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c30:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c34:	eb d7                	jmp    800c0d <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c36:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c3a:	eb d1                	jmp    800c0d <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c3c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c43:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c46:	89 d0                	mov    %edx,%eax
  800c48:	c1 e0 02             	shl    $0x2,%eax
  800c4b:	01 d0                	add    %edx,%eax
  800c4d:	01 c0                	add    %eax,%eax
  800c4f:	01 d8                	add    %ebx,%eax
  800c51:	83 e8 30             	sub    $0x30,%eax
  800c54:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c57:	8b 45 10             	mov    0x10(%ebp),%eax
  800c5a:	8a 00                	mov    (%eax),%al
  800c5c:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c5f:	83 fb 2f             	cmp    $0x2f,%ebx
  800c62:	7e 3e                	jle    800ca2 <vprintfmt+0xe9>
  800c64:	83 fb 39             	cmp    $0x39,%ebx
  800c67:	7f 39                	jg     800ca2 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c69:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c6c:	eb d5                	jmp    800c43 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c6e:	8b 45 14             	mov    0x14(%ebp),%eax
  800c71:	83 c0 04             	add    $0x4,%eax
  800c74:	89 45 14             	mov    %eax,0x14(%ebp)
  800c77:	8b 45 14             	mov    0x14(%ebp),%eax
  800c7a:	83 e8 04             	sub    $0x4,%eax
  800c7d:	8b 00                	mov    (%eax),%eax
  800c7f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c82:	eb 1f                	jmp    800ca3 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c84:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c88:	79 83                	jns    800c0d <vprintfmt+0x54>
				width = 0;
  800c8a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c91:	e9 77 ff ff ff       	jmp    800c0d <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c96:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c9d:	e9 6b ff ff ff       	jmp    800c0d <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800ca2:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800ca3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ca7:	0f 89 60 ff ff ff    	jns    800c0d <vprintfmt+0x54>
				width = precision, precision = -1;
  800cad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cb0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800cb3:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800cba:	e9 4e ff ff ff       	jmp    800c0d <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800cbf:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800cc2:	e9 46 ff ff ff       	jmp    800c0d <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cc7:	8b 45 14             	mov    0x14(%ebp),%eax
  800cca:	83 c0 04             	add    $0x4,%eax
  800ccd:	89 45 14             	mov    %eax,0x14(%ebp)
  800cd0:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd3:	83 e8 04             	sub    $0x4,%eax
  800cd6:	8b 00                	mov    (%eax),%eax
  800cd8:	83 ec 08             	sub    $0x8,%esp
  800cdb:	ff 75 0c             	pushl  0xc(%ebp)
  800cde:	50                   	push   %eax
  800cdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce2:	ff d0                	call   *%eax
  800ce4:	83 c4 10             	add    $0x10,%esp
			break;
  800ce7:	e9 89 02 00 00       	jmp    800f75 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cec:	8b 45 14             	mov    0x14(%ebp),%eax
  800cef:	83 c0 04             	add    $0x4,%eax
  800cf2:	89 45 14             	mov    %eax,0x14(%ebp)
  800cf5:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf8:	83 e8 04             	sub    $0x4,%eax
  800cfb:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cfd:	85 db                	test   %ebx,%ebx
  800cff:	79 02                	jns    800d03 <vprintfmt+0x14a>
				err = -err;
  800d01:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d03:	83 fb 64             	cmp    $0x64,%ebx
  800d06:	7f 0b                	jg     800d13 <vprintfmt+0x15a>
  800d08:	8b 34 9d 80 2a 80 00 	mov    0x802a80(,%ebx,4),%esi
  800d0f:	85 f6                	test   %esi,%esi
  800d11:	75 19                	jne    800d2c <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d13:	53                   	push   %ebx
  800d14:	68 25 2c 80 00       	push   $0x802c25
  800d19:	ff 75 0c             	pushl  0xc(%ebp)
  800d1c:	ff 75 08             	pushl  0x8(%ebp)
  800d1f:	e8 5e 02 00 00       	call   800f82 <printfmt>
  800d24:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d27:	e9 49 02 00 00       	jmp    800f75 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d2c:	56                   	push   %esi
  800d2d:	68 2e 2c 80 00       	push   $0x802c2e
  800d32:	ff 75 0c             	pushl  0xc(%ebp)
  800d35:	ff 75 08             	pushl  0x8(%ebp)
  800d38:	e8 45 02 00 00       	call   800f82 <printfmt>
  800d3d:	83 c4 10             	add    $0x10,%esp
			break;
  800d40:	e9 30 02 00 00       	jmp    800f75 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d45:	8b 45 14             	mov    0x14(%ebp),%eax
  800d48:	83 c0 04             	add    $0x4,%eax
  800d4b:	89 45 14             	mov    %eax,0x14(%ebp)
  800d4e:	8b 45 14             	mov    0x14(%ebp),%eax
  800d51:	83 e8 04             	sub    $0x4,%eax
  800d54:	8b 30                	mov    (%eax),%esi
  800d56:	85 f6                	test   %esi,%esi
  800d58:	75 05                	jne    800d5f <vprintfmt+0x1a6>
				p = "(null)";
  800d5a:	be 31 2c 80 00       	mov    $0x802c31,%esi
			if (width > 0 && padc != '-')
  800d5f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d63:	7e 6d                	jle    800dd2 <vprintfmt+0x219>
  800d65:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d69:	74 67                	je     800dd2 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d6b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d6e:	83 ec 08             	sub    $0x8,%esp
  800d71:	50                   	push   %eax
  800d72:	56                   	push   %esi
  800d73:	e8 12 05 00 00       	call   80128a <strnlen>
  800d78:	83 c4 10             	add    $0x10,%esp
  800d7b:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d7e:	eb 16                	jmp    800d96 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d80:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d84:	83 ec 08             	sub    $0x8,%esp
  800d87:	ff 75 0c             	pushl  0xc(%ebp)
  800d8a:	50                   	push   %eax
  800d8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8e:	ff d0                	call   *%eax
  800d90:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d93:	ff 4d e4             	decl   -0x1c(%ebp)
  800d96:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d9a:	7f e4                	jg     800d80 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d9c:	eb 34                	jmp    800dd2 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d9e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800da2:	74 1c                	je     800dc0 <vprintfmt+0x207>
  800da4:	83 fb 1f             	cmp    $0x1f,%ebx
  800da7:	7e 05                	jle    800dae <vprintfmt+0x1f5>
  800da9:	83 fb 7e             	cmp    $0x7e,%ebx
  800dac:	7e 12                	jle    800dc0 <vprintfmt+0x207>
					putch('?', putdat);
  800dae:	83 ec 08             	sub    $0x8,%esp
  800db1:	ff 75 0c             	pushl  0xc(%ebp)
  800db4:	6a 3f                	push   $0x3f
  800db6:	8b 45 08             	mov    0x8(%ebp),%eax
  800db9:	ff d0                	call   *%eax
  800dbb:	83 c4 10             	add    $0x10,%esp
  800dbe:	eb 0f                	jmp    800dcf <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800dc0:	83 ec 08             	sub    $0x8,%esp
  800dc3:	ff 75 0c             	pushl  0xc(%ebp)
  800dc6:	53                   	push   %ebx
  800dc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dca:	ff d0                	call   *%eax
  800dcc:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dcf:	ff 4d e4             	decl   -0x1c(%ebp)
  800dd2:	89 f0                	mov    %esi,%eax
  800dd4:	8d 70 01             	lea    0x1(%eax),%esi
  800dd7:	8a 00                	mov    (%eax),%al
  800dd9:	0f be d8             	movsbl %al,%ebx
  800ddc:	85 db                	test   %ebx,%ebx
  800dde:	74 24                	je     800e04 <vprintfmt+0x24b>
  800de0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800de4:	78 b8                	js     800d9e <vprintfmt+0x1e5>
  800de6:	ff 4d e0             	decl   -0x20(%ebp)
  800de9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ded:	79 af                	jns    800d9e <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800def:	eb 13                	jmp    800e04 <vprintfmt+0x24b>
				putch(' ', putdat);
  800df1:	83 ec 08             	sub    $0x8,%esp
  800df4:	ff 75 0c             	pushl  0xc(%ebp)
  800df7:	6a 20                	push   $0x20
  800df9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfc:	ff d0                	call   *%eax
  800dfe:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e01:	ff 4d e4             	decl   -0x1c(%ebp)
  800e04:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e08:	7f e7                	jg     800df1 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e0a:	e9 66 01 00 00       	jmp    800f75 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e0f:	83 ec 08             	sub    $0x8,%esp
  800e12:	ff 75 e8             	pushl  -0x18(%ebp)
  800e15:	8d 45 14             	lea    0x14(%ebp),%eax
  800e18:	50                   	push   %eax
  800e19:	e8 3c fd ff ff       	call   800b5a <getint>
  800e1e:	83 c4 10             	add    $0x10,%esp
  800e21:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e24:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e27:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e2a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e2d:	85 d2                	test   %edx,%edx
  800e2f:	79 23                	jns    800e54 <vprintfmt+0x29b>
				putch('-', putdat);
  800e31:	83 ec 08             	sub    $0x8,%esp
  800e34:	ff 75 0c             	pushl  0xc(%ebp)
  800e37:	6a 2d                	push   $0x2d
  800e39:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3c:	ff d0                	call   *%eax
  800e3e:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e41:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e44:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e47:	f7 d8                	neg    %eax
  800e49:	83 d2 00             	adc    $0x0,%edx
  800e4c:	f7 da                	neg    %edx
  800e4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e51:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e54:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e5b:	e9 bc 00 00 00       	jmp    800f1c <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e60:	83 ec 08             	sub    $0x8,%esp
  800e63:	ff 75 e8             	pushl  -0x18(%ebp)
  800e66:	8d 45 14             	lea    0x14(%ebp),%eax
  800e69:	50                   	push   %eax
  800e6a:	e8 84 fc ff ff       	call   800af3 <getuint>
  800e6f:	83 c4 10             	add    $0x10,%esp
  800e72:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e75:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e78:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e7f:	e9 98 00 00 00       	jmp    800f1c <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e84:	83 ec 08             	sub    $0x8,%esp
  800e87:	ff 75 0c             	pushl  0xc(%ebp)
  800e8a:	6a 58                	push   $0x58
  800e8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8f:	ff d0                	call   *%eax
  800e91:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e94:	83 ec 08             	sub    $0x8,%esp
  800e97:	ff 75 0c             	pushl  0xc(%ebp)
  800e9a:	6a 58                	push   $0x58
  800e9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9f:	ff d0                	call   *%eax
  800ea1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ea4:	83 ec 08             	sub    $0x8,%esp
  800ea7:	ff 75 0c             	pushl  0xc(%ebp)
  800eaa:	6a 58                	push   $0x58
  800eac:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaf:	ff d0                	call   *%eax
  800eb1:	83 c4 10             	add    $0x10,%esp
			break;
  800eb4:	e9 bc 00 00 00       	jmp    800f75 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800eb9:	83 ec 08             	sub    $0x8,%esp
  800ebc:	ff 75 0c             	pushl  0xc(%ebp)
  800ebf:	6a 30                	push   $0x30
  800ec1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec4:	ff d0                	call   *%eax
  800ec6:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ec9:	83 ec 08             	sub    $0x8,%esp
  800ecc:	ff 75 0c             	pushl  0xc(%ebp)
  800ecf:	6a 78                	push   $0x78
  800ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed4:	ff d0                	call   *%eax
  800ed6:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ed9:	8b 45 14             	mov    0x14(%ebp),%eax
  800edc:	83 c0 04             	add    $0x4,%eax
  800edf:	89 45 14             	mov    %eax,0x14(%ebp)
  800ee2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ee5:	83 e8 04             	sub    $0x4,%eax
  800ee8:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800eea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ef4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800efb:	eb 1f                	jmp    800f1c <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800efd:	83 ec 08             	sub    $0x8,%esp
  800f00:	ff 75 e8             	pushl  -0x18(%ebp)
  800f03:	8d 45 14             	lea    0x14(%ebp),%eax
  800f06:	50                   	push   %eax
  800f07:	e8 e7 fb ff ff       	call   800af3 <getuint>
  800f0c:	83 c4 10             	add    $0x10,%esp
  800f0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f12:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f15:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f1c:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f20:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f23:	83 ec 04             	sub    $0x4,%esp
  800f26:	52                   	push   %edx
  800f27:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f2a:	50                   	push   %eax
  800f2b:	ff 75 f4             	pushl  -0xc(%ebp)
  800f2e:	ff 75 f0             	pushl  -0x10(%ebp)
  800f31:	ff 75 0c             	pushl  0xc(%ebp)
  800f34:	ff 75 08             	pushl  0x8(%ebp)
  800f37:	e8 00 fb ff ff       	call   800a3c <printnum>
  800f3c:	83 c4 20             	add    $0x20,%esp
			break;
  800f3f:	eb 34                	jmp    800f75 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f41:	83 ec 08             	sub    $0x8,%esp
  800f44:	ff 75 0c             	pushl  0xc(%ebp)
  800f47:	53                   	push   %ebx
  800f48:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4b:	ff d0                	call   *%eax
  800f4d:	83 c4 10             	add    $0x10,%esp
			break;
  800f50:	eb 23                	jmp    800f75 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f52:	83 ec 08             	sub    $0x8,%esp
  800f55:	ff 75 0c             	pushl  0xc(%ebp)
  800f58:	6a 25                	push   $0x25
  800f5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5d:	ff d0                	call   *%eax
  800f5f:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f62:	ff 4d 10             	decl   0x10(%ebp)
  800f65:	eb 03                	jmp    800f6a <vprintfmt+0x3b1>
  800f67:	ff 4d 10             	decl   0x10(%ebp)
  800f6a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6d:	48                   	dec    %eax
  800f6e:	8a 00                	mov    (%eax),%al
  800f70:	3c 25                	cmp    $0x25,%al
  800f72:	75 f3                	jne    800f67 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f74:	90                   	nop
		}
	}
  800f75:	e9 47 fc ff ff       	jmp    800bc1 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f7a:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f7b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f7e:	5b                   	pop    %ebx
  800f7f:	5e                   	pop    %esi
  800f80:	5d                   	pop    %ebp
  800f81:	c3                   	ret    

00800f82 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f82:	55                   	push   %ebp
  800f83:	89 e5                	mov    %esp,%ebp
  800f85:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f88:	8d 45 10             	lea    0x10(%ebp),%eax
  800f8b:	83 c0 04             	add    $0x4,%eax
  800f8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f91:	8b 45 10             	mov    0x10(%ebp),%eax
  800f94:	ff 75 f4             	pushl  -0xc(%ebp)
  800f97:	50                   	push   %eax
  800f98:	ff 75 0c             	pushl  0xc(%ebp)
  800f9b:	ff 75 08             	pushl  0x8(%ebp)
  800f9e:	e8 16 fc ff ff       	call   800bb9 <vprintfmt>
  800fa3:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800fa6:	90                   	nop
  800fa7:	c9                   	leave  
  800fa8:	c3                   	ret    

00800fa9 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800fa9:	55                   	push   %ebp
  800faa:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fac:	8b 45 0c             	mov    0xc(%ebp),%eax
  800faf:	8b 40 08             	mov    0x8(%eax),%eax
  800fb2:	8d 50 01             	lea    0x1(%eax),%edx
  800fb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb8:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800fbb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbe:	8b 10                	mov    (%eax),%edx
  800fc0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc3:	8b 40 04             	mov    0x4(%eax),%eax
  800fc6:	39 c2                	cmp    %eax,%edx
  800fc8:	73 12                	jae    800fdc <sprintputch+0x33>
		*b->buf++ = ch;
  800fca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fcd:	8b 00                	mov    (%eax),%eax
  800fcf:	8d 48 01             	lea    0x1(%eax),%ecx
  800fd2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fd5:	89 0a                	mov    %ecx,(%edx)
  800fd7:	8b 55 08             	mov    0x8(%ebp),%edx
  800fda:	88 10                	mov    %dl,(%eax)
}
  800fdc:	90                   	nop
  800fdd:	5d                   	pop    %ebp
  800fde:	c3                   	ret    

00800fdf <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fdf:	55                   	push   %ebp
  800fe0:	89 e5                	mov    %esp,%ebp
  800fe2:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fe5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800feb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fee:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ff1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff4:	01 d0                	add    %edx,%eax
  800ff6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ff9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801000:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801004:	74 06                	je     80100c <vsnprintf+0x2d>
  801006:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80100a:	7f 07                	jg     801013 <vsnprintf+0x34>
		return -E_INVAL;
  80100c:	b8 03 00 00 00       	mov    $0x3,%eax
  801011:	eb 20                	jmp    801033 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801013:	ff 75 14             	pushl  0x14(%ebp)
  801016:	ff 75 10             	pushl  0x10(%ebp)
  801019:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80101c:	50                   	push   %eax
  80101d:	68 a9 0f 80 00       	push   $0x800fa9
  801022:	e8 92 fb ff ff       	call   800bb9 <vprintfmt>
  801027:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80102a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80102d:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801030:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801033:	c9                   	leave  
  801034:	c3                   	ret    

00801035 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801035:	55                   	push   %ebp
  801036:	89 e5                	mov    %esp,%ebp
  801038:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80103b:	8d 45 10             	lea    0x10(%ebp),%eax
  80103e:	83 c0 04             	add    $0x4,%eax
  801041:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801044:	8b 45 10             	mov    0x10(%ebp),%eax
  801047:	ff 75 f4             	pushl  -0xc(%ebp)
  80104a:	50                   	push   %eax
  80104b:	ff 75 0c             	pushl  0xc(%ebp)
  80104e:	ff 75 08             	pushl  0x8(%ebp)
  801051:	e8 89 ff ff ff       	call   800fdf <vsnprintf>
  801056:	83 c4 10             	add    $0x10,%esp
  801059:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80105c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80105f:	c9                   	leave  
  801060:	c3                   	ret    

00801061 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801061:	55                   	push   %ebp
  801062:	89 e5                	mov    %esp,%ebp
  801064:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801067:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80106b:	74 13                	je     801080 <readline+0x1f>
		cprintf("%s", prompt);
  80106d:	83 ec 08             	sub    $0x8,%esp
  801070:	ff 75 08             	pushl  0x8(%ebp)
  801073:	68 90 2d 80 00       	push   $0x802d90
  801078:	e8 62 f9 ff ff       	call   8009df <cprintf>
  80107d:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801080:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801087:	83 ec 0c             	sub    $0xc,%esp
  80108a:	6a 00                	push   $0x0
  80108c:	e8 5d f5 ff ff       	call   8005ee <iscons>
  801091:	83 c4 10             	add    $0x10,%esp
  801094:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801097:	e8 04 f5 ff ff       	call   8005a0 <getchar>
  80109c:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80109f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8010a3:	79 22                	jns    8010c7 <readline+0x66>
			if (c != -E_EOF)
  8010a5:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8010a9:	0f 84 ad 00 00 00    	je     80115c <readline+0xfb>
				cprintf("read error: %e\n", c);
  8010af:	83 ec 08             	sub    $0x8,%esp
  8010b2:	ff 75 ec             	pushl  -0x14(%ebp)
  8010b5:	68 93 2d 80 00       	push   $0x802d93
  8010ba:	e8 20 f9 ff ff       	call   8009df <cprintf>
  8010bf:	83 c4 10             	add    $0x10,%esp
			return;
  8010c2:	e9 95 00 00 00       	jmp    80115c <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8010c7:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8010cb:	7e 34                	jle    801101 <readline+0xa0>
  8010cd:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8010d4:	7f 2b                	jg     801101 <readline+0xa0>
			if (echoing)
  8010d6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010da:	74 0e                	je     8010ea <readline+0x89>
				cputchar(c);
  8010dc:	83 ec 0c             	sub    $0xc,%esp
  8010df:	ff 75 ec             	pushl  -0x14(%ebp)
  8010e2:	e8 71 f4 ff ff       	call   800558 <cputchar>
  8010e7:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8010ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010ed:	8d 50 01             	lea    0x1(%eax),%edx
  8010f0:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8010f3:	89 c2                	mov    %eax,%edx
  8010f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f8:	01 d0                	add    %edx,%eax
  8010fa:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010fd:	88 10                	mov    %dl,(%eax)
  8010ff:	eb 56                	jmp    801157 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  801101:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801105:	75 1f                	jne    801126 <readline+0xc5>
  801107:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80110b:	7e 19                	jle    801126 <readline+0xc5>
			if (echoing)
  80110d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801111:	74 0e                	je     801121 <readline+0xc0>
				cputchar(c);
  801113:	83 ec 0c             	sub    $0xc,%esp
  801116:	ff 75 ec             	pushl  -0x14(%ebp)
  801119:	e8 3a f4 ff ff       	call   800558 <cputchar>
  80111e:	83 c4 10             	add    $0x10,%esp

			i--;
  801121:	ff 4d f4             	decl   -0xc(%ebp)
  801124:	eb 31                	jmp    801157 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  801126:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80112a:	74 0a                	je     801136 <readline+0xd5>
  80112c:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801130:	0f 85 61 ff ff ff    	jne    801097 <readline+0x36>
			if (echoing)
  801136:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80113a:	74 0e                	je     80114a <readline+0xe9>
				cputchar(c);
  80113c:	83 ec 0c             	sub    $0xc,%esp
  80113f:	ff 75 ec             	pushl  -0x14(%ebp)
  801142:	e8 11 f4 ff ff       	call   800558 <cputchar>
  801147:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80114a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80114d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801150:	01 d0                	add    %edx,%eax
  801152:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801155:	eb 06                	jmp    80115d <readline+0xfc>
		}
	}
  801157:	e9 3b ff ff ff       	jmp    801097 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  80115c:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  80115d:	c9                   	leave  
  80115e:	c3                   	ret    

0080115f <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  80115f:	55                   	push   %ebp
  801160:	89 e5                	mov    %esp,%ebp
  801162:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801165:	e8 73 0e 00 00       	call   801fdd <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  80116a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80116e:	74 13                	je     801183 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801170:	83 ec 08             	sub    $0x8,%esp
  801173:	ff 75 08             	pushl  0x8(%ebp)
  801176:	68 90 2d 80 00       	push   $0x802d90
  80117b:	e8 5f f8 ff ff       	call   8009df <cprintf>
  801180:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801183:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80118a:	83 ec 0c             	sub    $0xc,%esp
  80118d:	6a 00                	push   $0x0
  80118f:	e8 5a f4 ff ff       	call   8005ee <iscons>
  801194:	83 c4 10             	add    $0x10,%esp
  801197:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80119a:	e8 01 f4 ff ff       	call   8005a0 <getchar>
  80119f:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8011a2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8011a6:	79 23                	jns    8011cb <atomic_readline+0x6c>
			if (c != -E_EOF)
  8011a8:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8011ac:	74 13                	je     8011c1 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8011ae:	83 ec 08             	sub    $0x8,%esp
  8011b1:	ff 75 ec             	pushl  -0x14(%ebp)
  8011b4:	68 93 2d 80 00       	push   $0x802d93
  8011b9:	e8 21 f8 ff ff       	call   8009df <cprintf>
  8011be:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8011c1:	e8 31 0e 00 00       	call   801ff7 <sys_enable_interrupt>
			return;
  8011c6:	e9 9a 00 00 00       	jmp    801265 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8011cb:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011cf:	7e 34                	jle    801205 <atomic_readline+0xa6>
  8011d1:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011d8:	7f 2b                	jg     801205 <atomic_readline+0xa6>
			if (echoing)
  8011da:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011de:	74 0e                	je     8011ee <atomic_readline+0x8f>
				cputchar(c);
  8011e0:	83 ec 0c             	sub    $0xc,%esp
  8011e3:	ff 75 ec             	pushl  -0x14(%ebp)
  8011e6:	e8 6d f3 ff ff       	call   800558 <cputchar>
  8011eb:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011f1:	8d 50 01             	lea    0x1(%eax),%edx
  8011f4:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011f7:	89 c2                	mov    %eax,%edx
  8011f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011fc:	01 d0                	add    %edx,%eax
  8011fe:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801201:	88 10                	mov    %dl,(%eax)
  801203:	eb 5b                	jmp    801260 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  801205:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801209:	75 1f                	jne    80122a <atomic_readline+0xcb>
  80120b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80120f:	7e 19                	jle    80122a <atomic_readline+0xcb>
			if (echoing)
  801211:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801215:	74 0e                	je     801225 <atomic_readline+0xc6>
				cputchar(c);
  801217:	83 ec 0c             	sub    $0xc,%esp
  80121a:	ff 75 ec             	pushl  -0x14(%ebp)
  80121d:	e8 36 f3 ff ff       	call   800558 <cputchar>
  801222:	83 c4 10             	add    $0x10,%esp
			i--;
  801225:	ff 4d f4             	decl   -0xc(%ebp)
  801228:	eb 36                	jmp    801260 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  80122a:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80122e:	74 0a                	je     80123a <atomic_readline+0xdb>
  801230:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801234:	0f 85 60 ff ff ff    	jne    80119a <atomic_readline+0x3b>
			if (echoing)
  80123a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80123e:	74 0e                	je     80124e <atomic_readline+0xef>
				cputchar(c);
  801240:	83 ec 0c             	sub    $0xc,%esp
  801243:	ff 75 ec             	pushl  -0x14(%ebp)
  801246:	e8 0d f3 ff ff       	call   800558 <cputchar>
  80124b:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  80124e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801251:	8b 45 0c             	mov    0xc(%ebp),%eax
  801254:	01 d0                	add    %edx,%eax
  801256:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801259:	e8 99 0d 00 00       	call   801ff7 <sys_enable_interrupt>
			return;
  80125e:	eb 05                	jmp    801265 <atomic_readline+0x106>
		}
	}
  801260:	e9 35 ff ff ff       	jmp    80119a <atomic_readline+0x3b>
}
  801265:	c9                   	leave  
  801266:	c3                   	ret    

00801267 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801267:	55                   	push   %ebp
  801268:	89 e5                	mov    %esp,%ebp
  80126a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80126d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801274:	eb 06                	jmp    80127c <strlen+0x15>
		n++;
  801276:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801279:	ff 45 08             	incl   0x8(%ebp)
  80127c:	8b 45 08             	mov    0x8(%ebp),%eax
  80127f:	8a 00                	mov    (%eax),%al
  801281:	84 c0                	test   %al,%al
  801283:	75 f1                	jne    801276 <strlen+0xf>
		n++;
	return n;
  801285:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801288:	c9                   	leave  
  801289:	c3                   	ret    

0080128a <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80128a:	55                   	push   %ebp
  80128b:	89 e5                	mov    %esp,%ebp
  80128d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801290:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801297:	eb 09                	jmp    8012a2 <strnlen+0x18>
		n++;
  801299:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80129c:	ff 45 08             	incl   0x8(%ebp)
  80129f:	ff 4d 0c             	decl   0xc(%ebp)
  8012a2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012a6:	74 09                	je     8012b1 <strnlen+0x27>
  8012a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ab:	8a 00                	mov    (%eax),%al
  8012ad:	84 c0                	test   %al,%al
  8012af:	75 e8                	jne    801299 <strnlen+0xf>
		n++;
	return n;
  8012b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012b4:	c9                   	leave  
  8012b5:	c3                   	ret    

008012b6 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8012b6:	55                   	push   %ebp
  8012b7:	89 e5                	mov    %esp,%ebp
  8012b9:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8012bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8012c2:	90                   	nop
  8012c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c6:	8d 50 01             	lea    0x1(%eax),%edx
  8012c9:	89 55 08             	mov    %edx,0x8(%ebp)
  8012cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012cf:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012d2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012d5:	8a 12                	mov    (%edx),%dl
  8012d7:	88 10                	mov    %dl,(%eax)
  8012d9:	8a 00                	mov    (%eax),%al
  8012db:	84 c0                	test   %al,%al
  8012dd:	75 e4                	jne    8012c3 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8012df:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012e2:	c9                   	leave  
  8012e3:	c3                   	ret    

008012e4 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8012e4:	55                   	push   %ebp
  8012e5:	89 e5                	mov    %esp,%ebp
  8012e7:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ed:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012f7:	eb 1f                	jmp    801318 <strncpy+0x34>
		*dst++ = *src;
  8012f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fc:	8d 50 01             	lea    0x1(%eax),%edx
  8012ff:	89 55 08             	mov    %edx,0x8(%ebp)
  801302:	8b 55 0c             	mov    0xc(%ebp),%edx
  801305:	8a 12                	mov    (%edx),%dl
  801307:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801309:	8b 45 0c             	mov    0xc(%ebp),%eax
  80130c:	8a 00                	mov    (%eax),%al
  80130e:	84 c0                	test   %al,%al
  801310:	74 03                	je     801315 <strncpy+0x31>
			src++;
  801312:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801315:	ff 45 fc             	incl   -0x4(%ebp)
  801318:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80131b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80131e:	72 d9                	jb     8012f9 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801320:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801323:	c9                   	leave  
  801324:	c3                   	ret    

00801325 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801325:	55                   	push   %ebp
  801326:	89 e5                	mov    %esp,%ebp
  801328:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80132b:	8b 45 08             	mov    0x8(%ebp),%eax
  80132e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801331:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801335:	74 30                	je     801367 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801337:	eb 16                	jmp    80134f <strlcpy+0x2a>
			*dst++ = *src++;
  801339:	8b 45 08             	mov    0x8(%ebp),%eax
  80133c:	8d 50 01             	lea    0x1(%eax),%edx
  80133f:	89 55 08             	mov    %edx,0x8(%ebp)
  801342:	8b 55 0c             	mov    0xc(%ebp),%edx
  801345:	8d 4a 01             	lea    0x1(%edx),%ecx
  801348:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80134b:	8a 12                	mov    (%edx),%dl
  80134d:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80134f:	ff 4d 10             	decl   0x10(%ebp)
  801352:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801356:	74 09                	je     801361 <strlcpy+0x3c>
  801358:	8b 45 0c             	mov    0xc(%ebp),%eax
  80135b:	8a 00                	mov    (%eax),%al
  80135d:	84 c0                	test   %al,%al
  80135f:	75 d8                	jne    801339 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801361:	8b 45 08             	mov    0x8(%ebp),%eax
  801364:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801367:	8b 55 08             	mov    0x8(%ebp),%edx
  80136a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80136d:	29 c2                	sub    %eax,%edx
  80136f:	89 d0                	mov    %edx,%eax
}
  801371:	c9                   	leave  
  801372:	c3                   	ret    

00801373 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801373:	55                   	push   %ebp
  801374:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801376:	eb 06                	jmp    80137e <strcmp+0xb>
		p++, q++;
  801378:	ff 45 08             	incl   0x8(%ebp)
  80137b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80137e:	8b 45 08             	mov    0x8(%ebp),%eax
  801381:	8a 00                	mov    (%eax),%al
  801383:	84 c0                	test   %al,%al
  801385:	74 0e                	je     801395 <strcmp+0x22>
  801387:	8b 45 08             	mov    0x8(%ebp),%eax
  80138a:	8a 10                	mov    (%eax),%dl
  80138c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138f:	8a 00                	mov    (%eax),%al
  801391:	38 c2                	cmp    %al,%dl
  801393:	74 e3                	je     801378 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801395:	8b 45 08             	mov    0x8(%ebp),%eax
  801398:	8a 00                	mov    (%eax),%al
  80139a:	0f b6 d0             	movzbl %al,%edx
  80139d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a0:	8a 00                	mov    (%eax),%al
  8013a2:	0f b6 c0             	movzbl %al,%eax
  8013a5:	29 c2                	sub    %eax,%edx
  8013a7:	89 d0                	mov    %edx,%eax
}
  8013a9:	5d                   	pop    %ebp
  8013aa:	c3                   	ret    

008013ab <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8013ab:	55                   	push   %ebp
  8013ac:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8013ae:	eb 09                	jmp    8013b9 <strncmp+0xe>
		n--, p++, q++;
  8013b0:	ff 4d 10             	decl   0x10(%ebp)
  8013b3:	ff 45 08             	incl   0x8(%ebp)
  8013b6:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8013b9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013bd:	74 17                	je     8013d6 <strncmp+0x2b>
  8013bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c2:	8a 00                	mov    (%eax),%al
  8013c4:	84 c0                	test   %al,%al
  8013c6:	74 0e                	je     8013d6 <strncmp+0x2b>
  8013c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cb:	8a 10                	mov    (%eax),%dl
  8013cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d0:	8a 00                	mov    (%eax),%al
  8013d2:	38 c2                	cmp    %al,%dl
  8013d4:	74 da                	je     8013b0 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013d6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013da:	75 07                	jne    8013e3 <strncmp+0x38>
		return 0;
  8013dc:	b8 00 00 00 00       	mov    $0x0,%eax
  8013e1:	eb 14                	jmp    8013f7 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8013e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e6:	8a 00                	mov    (%eax),%al
  8013e8:	0f b6 d0             	movzbl %al,%edx
  8013eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ee:	8a 00                	mov    (%eax),%al
  8013f0:	0f b6 c0             	movzbl %al,%eax
  8013f3:	29 c2                	sub    %eax,%edx
  8013f5:	89 d0                	mov    %edx,%eax
}
  8013f7:	5d                   	pop    %ebp
  8013f8:	c3                   	ret    

008013f9 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013f9:	55                   	push   %ebp
  8013fa:	89 e5                	mov    %esp,%ebp
  8013fc:	83 ec 04             	sub    $0x4,%esp
  8013ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801402:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801405:	eb 12                	jmp    801419 <strchr+0x20>
		if (*s == c)
  801407:	8b 45 08             	mov    0x8(%ebp),%eax
  80140a:	8a 00                	mov    (%eax),%al
  80140c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80140f:	75 05                	jne    801416 <strchr+0x1d>
			return (char *) s;
  801411:	8b 45 08             	mov    0x8(%ebp),%eax
  801414:	eb 11                	jmp    801427 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801416:	ff 45 08             	incl   0x8(%ebp)
  801419:	8b 45 08             	mov    0x8(%ebp),%eax
  80141c:	8a 00                	mov    (%eax),%al
  80141e:	84 c0                	test   %al,%al
  801420:	75 e5                	jne    801407 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801422:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801427:	c9                   	leave  
  801428:	c3                   	ret    

00801429 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801429:	55                   	push   %ebp
  80142a:	89 e5                	mov    %esp,%ebp
  80142c:	83 ec 04             	sub    $0x4,%esp
  80142f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801432:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801435:	eb 0d                	jmp    801444 <strfind+0x1b>
		if (*s == c)
  801437:	8b 45 08             	mov    0x8(%ebp),%eax
  80143a:	8a 00                	mov    (%eax),%al
  80143c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80143f:	74 0e                	je     80144f <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801441:	ff 45 08             	incl   0x8(%ebp)
  801444:	8b 45 08             	mov    0x8(%ebp),%eax
  801447:	8a 00                	mov    (%eax),%al
  801449:	84 c0                	test   %al,%al
  80144b:	75 ea                	jne    801437 <strfind+0xe>
  80144d:	eb 01                	jmp    801450 <strfind+0x27>
		if (*s == c)
			break;
  80144f:	90                   	nop
	return (char *) s;
  801450:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801453:	c9                   	leave  
  801454:	c3                   	ret    

00801455 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801455:	55                   	push   %ebp
  801456:	89 e5                	mov    %esp,%ebp
  801458:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80145b:	8b 45 08             	mov    0x8(%ebp),%eax
  80145e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801461:	8b 45 10             	mov    0x10(%ebp),%eax
  801464:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801467:	eb 0e                	jmp    801477 <memset+0x22>
		*p++ = c;
  801469:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80146c:	8d 50 01             	lea    0x1(%eax),%edx
  80146f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801472:	8b 55 0c             	mov    0xc(%ebp),%edx
  801475:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801477:	ff 4d f8             	decl   -0x8(%ebp)
  80147a:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80147e:	79 e9                	jns    801469 <memset+0x14>
		*p++ = c;

	return v;
  801480:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801483:	c9                   	leave  
  801484:	c3                   	ret    

00801485 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801485:	55                   	push   %ebp
  801486:	89 e5                	mov    %esp,%ebp
  801488:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80148b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801491:	8b 45 08             	mov    0x8(%ebp),%eax
  801494:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801497:	eb 16                	jmp    8014af <memcpy+0x2a>
		*d++ = *s++;
  801499:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80149c:	8d 50 01             	lea    0x1(%eax),%edx
  80149f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014a2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014a5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014a8:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014ab:	8a 12                	mov    (%edx),%dl
  8014ad:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8014af:	8b 45 10             	mov    0x10(%ebp),%eax
  8014b2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014b5:	89 55 10             	mov    %edx,0x10(%ebp)
  8014b8:	85 c0                	test   %eax,%eax
  8014ba:	75 dd                	jne    801499 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8014bc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014bf:	c9                   	leave  
  8014c0:	c3                   	ret    

008014c1 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014c1:	55                   	push   %ebp
  8014c2:	89 e5                	mov    %esp,%ebp
  8014c4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ca:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014d6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014d9:	73 50                	jae    80152b <memmove+0x6a>
  8014db:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014de:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e1:	01 d0                	add    %edx,%eax
  8014e3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014e6:	76 43                	jbe    80152b <memmove+0x6a>
		s += n;
  8014e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8014eb:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f1:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014f4:	eb 10                	jmp    801506 <memmove+0x45>
			*--d = *--s;
  8014f6:	ff 4d f8             	decl   -0x8(%ebp)
  8014f9:	ff 4d fc             	decl   -0x4(%ebp)
  8014fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014ff:	8a 10                	mov    (%eax),%dl
  801501:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801504:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801506:	8b 45 10             	mov    0x10(%ebp),%eax
  801509:	8d 50 ff             	lea    -0x1(%eax),%edx
  80150c:	89 55 10             	mov    %edx,0x10(%ebp)
  80150f:	85 c0                	test   %eax,%eax
  801511:	75 e3                	jne    8014f6 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801513:	eb 23                	jmp    801538 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801515:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801518:	8d 50 01             	lea    0x1(%eax),%edx
  80151b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80151e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801521:	8d 4a 01             	lea    0x1(%edx),%ecx
  801524:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801527:	8a 12                	mov    (%edx),%dl
  801529:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80152b:	8b 45 10             	mov    0x10(%ebp),%eax
  80152e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801531:	89 55 10             	mov    %edx,0x10(%ebp)
  801534:	85 c0                	test   %eax,%eax
  801536:	75 dd                	jne    801515 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801538:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80153b:	c9                   	leave  
  80153c:	c3                   	ret    

0080153d <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80153d:	55                   	push   %ebp
  80153e:	89 e5                	mov    %esp,%ebp
  801540:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801543:	8b 45 08             	mov    0x8(%ebp),%eax
  801546:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801549:	8b 45 0c             	mov    0xc(%ebp),%eax
  80154c:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80154f:	eb 2a                	jmp    80157b <memcmp+0x3e>
		if (*s1 != *s2)
  801551:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801554:	8a 10                	mov    (%eax),%dl
  801556:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801559:	8a 00                	mov    (%eax),%al
  80155b:	38 c2                	cmp    %al,%dl
  80155d:	74 16                	je     801575 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80155f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801562:	8a 00                	mov    (%eax),%al
  801564:	0f b6 d0             	movzbl %al,%edx
  801567:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80156a:	8a 00                	mov    (%eax),%al
  80156c:	0f b6 c0             	movzbl %al,%eax
  80156f:	29 c2                	sub    %eax,%edx
  801571:	89 d0                	mov    %edx,%eax
  801573:	eb 18                	jmp    80158d <memcmp+0x50>
		s1++, s2++;
  801575:	ff 45 fc             	incl   -0x4(%ebp)
  801578:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80157b:	8b 45 10             	mov    0x10(%ebp),%eax
  80157e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801581:	89 55 10             	mov    %edx,0x10(%ebp)
  801584:	85 c0                	test   %eax,%eax
  801586:	75 c9                	jne    801551 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801588:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80158d:	c9                   	leave  
  80158e:	c3                   	ret    

0080158f <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80158f:	55                   	push   %ebp
  801590:	89 e5                	mov    %esp,%ebp
  801592:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801595:	8b 55 08             	mov    0x8(%ebp),%edx
  801598:	8b 45 10             	mov    0x10(%ebp),%eax
  80159b:	01 d0                	add    %edx,%eax
  80159d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8015a0:	eb 15                	jmp    8015b7 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8015a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a5:	8a 00                	mov    (%eax),%al
  8015a7:	0f b6 d0             	movzbl %al,%edx
  8015aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ad:	0f b6 c0             	movzbl %al,%eax
  8015b0:	39 c2                	cmp    %eax,%edx
  8015b2:	74 0d                	je     8015c1 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8015b4:	ff 45 08             	incl   0x8(%ebp)
  8015b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ba:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015bd:	72 e3                	jb     8015a2 <memfind+0x13>
  8015bf:	eb 01                	jmp    8015c2 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015c1:	90                   	nop
	return (void *) s;
  8015c2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015c5:	c9                   	leave  
  8015c6:	c3                   	ret    

008015c7 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015c7:	55                   	push   %ebp
  8015c8:	89 e5                	mov    %esp,%ebp
  8015ca:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015cd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015d4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015db:	eb 03                	jmp    8015e0 <strtol+0x19>
		s++;
  8015dd:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e3:	8a 00                	mov    (%eax),%al
  8015e5:	3c 20                	cmp    $0x20,%al
  8015e7:	74 f4                	je     8015dd <strtol+0x16>
  8015e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ec:	8a 00                	mov    (%eax),%al
  8015ee:	3c 09                	cmp    $0x9,%al
  8015f0:	74 eb                	je     8015dd <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f5:	8a 00                	mov    (%eax),%al
  8015f7:	3c 2b                	cmp    $0x2b,%al
  8015f9:	75 05                	jne    801600 <strtol+0x39>
		s++;
  8015fb:	ff 45 08             	incl   0x8(%ebp)
  8015fe:	eb 13                	jmp    801613 <strtol+0x4c>
	else if (*s == '-')
  801600:	8b 45 08             	mov    0x8(%ebp),%eax
  801603:	8a 00                	mov    (%eax),%al
  801605:	3c 2d                	cmp    $0x2d,%al
  801607:	75 0a                	jne    801613 <strtol+0x4c>
		s++, neg = 1;
  801609:	ff 45 08             	incl   0x8(%ebp)
  80160c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801613:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801617:	74 06                	je     80161f <strtol+0x58>
  801619:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80161d:	75 20                	jne    80163f <strtol+0x78>
  80161f:	8b 45 08             	mov    0x8(%ebp),%eax
  801622:	8a 00                	mov    (%eax),%al
  801624:	3c 30                	cmp    $0x30,%al
  801626:	75 17                	jne    80163f <strtol+0x78>
  801628:	8b 45 08             	mov    0x8(%ebp),%eax
  80162b:	40                   	inc    %eax
  80162c:	8a 00                	mov    (%eax),%al
  80162e:	3c 78                	cmp    $0x78,%al
  801630:	75 0d                	jne    80163f <strtol+0x78>
		s += 2, base = 16;
  801632:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801636:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80163d:	eb 28                	jmp    801667 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80163f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801643:	75 15                	jne    80165a <strtol+0x93>
  801645:	8b 45 08             	mov    0x8(%ebp),%eax
  801648:	8a 00                	mov    (%eax),%al
  80164a:	3c 30                	cmp    $0x30,%al
  80164c:	75 0c                	jne    80165a <strtol+0x93>
		s++, base = 8;
  80164e:	ff 45 08             	incl   0x8(%ebp)
  801651:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801658:	eb 0d                	jmp    801667 <strtol+0xa0>
	else if (base == 0)
  80165a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80165e:	75 07                	jne    801667 <strtol+0xa0>
		base = 10;
  801660:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801667:	8b 45 08             	mov    0x8(%ebp),%eax
  80166a:	8a 00                	mov    (%eax),%al
  80166c:	3c 2f                	cmp    $0x2f,%al
  80166e:	7e 19                	jle    801689 <strtol+0xc2>
  801670:	8b 45 08             	mov    0x8(%ebp),%eax
  801673:	8a 00                	mov    (%eax),%al
  801675:	3c 39                	cmp    $0x39,%al
  801677:	7f 10                	jg     801689 <strtol+0xc2>
			dig = *s - '0';
  801679:	8b 45 08             	mov    0x8(%ebp),%eax
  80167c:	8a 00                	mov    (%eax),%al
  80167e:	0f be c0             	movsbl %al,%eax
  801681:	83 e8 30             	sub    $0x30,%eax
  801684:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801687:	eb 42                	jmp    8016cb <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801689:	8b 45 08             	mov    0x8(%ebp),%eax
  80168c:	8a 00                	mov    (%eax),%al
  80168e:	3c 60                	cmp    $0x60,%al
  801690:	7e 19                	jle    8016ab <strtol+0xe4>
  801692:	8b 45 08             	mov    0x8(%ebp),%eax
  801695:	8a 00                	mov    (%eax),%al
  801697:	3c 7a                	cmp    $0x7a,%al
  801699:	7f 10                	jg     8016ab <strtol+0xe4>
			dig = *s - 'a' + 10;
  80169b:	8b 45 08             	mov    0x8(%ebp),%eax
  80169e:	8a 00                	mov    (%eax),%al
  8016a0:	0f be c0             	movsbl %al,%eax
  8016a3:	83 e8 57             	sub    $0x57,%eax
  8016a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016a9:	eb 20                	jmp    8016cb <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ae:	8a 00                	mov    (%eax),%al
  8016b0:	3c 40                	cmp    $0x40,%al
  8016b2:	7e 39                	jle    8016ed <strtol+0x126>
  8016b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b7:	8a 00                	mov    (%eax),%al
  8016b9:	3c 5a                	cmp    $0x5a,%al
  8016bb:	7f 30                	jg     8016ed <strtol+0x126>
			dig = *s - 'A' + 10;
  8016bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c0:	8a 00                	mov    (%eax),%al
  8016c2:	0f be c0             	movsbl %al,%eax
  8016c5:	83 e8 37             	sub    $0x37,%eax
  8016c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016ce:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016d1:	7d 19                	jge    8016ec <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016d3:	ff 45 08             	incl   0x8(%ebp)
  8016d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016d9:	0f af 45 10          	imul   0x10(%ebp),%eax
  8016dd:	89 c2                	mov    %eax,%edx
  8016df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016e2:	01 d0                	add    %edx,%eax
  8016e4:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016e7:	e9 7b ff ff ff       	jmp    801667 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016ec:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016ed:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016f1:	74 08                	je     8016fb <strtol+0x134>
		*endptr = (char *) s;
  8016f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016f6:	8b 55 08             	mov    0x8(%ebp),%edx
  8016f9:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016fb:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016ff:	74 07                	je     801708 <strtol+0x141>
  801701:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801704:	f7 d8                	neg    %eax
  801706:	eb 03                	jmp    80170b <strtol+0x144>
  801708:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80170b:	c9                   	leave  
  80170c:	c3                   	ret    

0080170d <ltostr>:

void
ltostr(long value, char *str)
{
  80170d:	55                   	push   %ebp
  80170e:	89 e5                	mov    %esp,%ebp
  801710:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801713:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80171a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801721:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801725:	79 13                	jns    80173a <ltostr+0x2d>
	{
		neg = 1;
  801727:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80172e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801731:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801734:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801737:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80173a:	8b 45 08             	mov    0x8(%ebp),%eax
  80173d:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801742:	99                   	cltd   
  801743:	f7 f9                	idiv   %ecx
  801745:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801748:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80174b:	8d 50 01             	lea    0x1(%eax),%edx
  80174e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801751:	89 c2                	mov    %eax,%edx
  801753:	8b 45 0c             	mov    0xc(%ebp),%eax
  801756:	01 d0                	add    %edx,%eax
  801758:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80175b:	83 c2 30             	add    $0x30,%edx
  80175e:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801760:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801763:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801768:	f7 e9                	imul   %ecx
  80176a:	c1 fa 02             	sar    $0x2,%edx
  80176d:	89 c8                	mov    %ecx,%eax
  80176f:	c1 f8 1f             	sar    $0x1f,%eax
  801772:	29 c2                	sub    %eax,%edx
  801774:	89 d0                	mov    %edx,%eax
  801776:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801779:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80177c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801781:	f7 e9                	imul   %ecx
  801783:	c1 fa 02             	sar    $0x2,%edx
  801786:	89 c8                	mov    %ecx,%eax
  801788:	c1 f8 1f             	sar    $0x1f,%eax
  80178b:	29 c2                	sub    %eax,%edx
  80178d:	89 d0                	mov    %edx,%eax
  80178f:	c1 e0 02             	shl    $0x2,%eax
  801792:	01 d0                	add    %edx,%eax
  801794:	01 c0                	add    %eax,%eax
  801796:	29 c1                	sub    %eax,%ecx
  801798:	89 ca                	mov    %ecx,%edx
  80179a:	85 d2                	test   %edx,%edx
  80179c:	75 9c                	jne    80173a <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80179e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017a8:	48                   	dec    %eax
  8017a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017ac:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017b0:	74 3d                	je     8017ef <ltostr+0xe2>
		start = 1 ;
  8017b2:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017b9:	eb 34                	jmp    8017ef <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8017bb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c1:	01 d0                	add    %edx,%eax
  8017c3:	8a 00                	mov    (%eax),%al
  8017c5:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017c8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ce:	01 c2                	add    %eax,%edx
  8017d0:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d6:	01 c8                	add    %ecx,%eax
  8017d8:	8a 00                	mov    (%eax),%al
  8017da:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017dc:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e2:	01 c2                	add    %eax,%edx
  8017e4:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017e7:	88 02                	mov    %al,(%edx)
		start++ ;
  8017e9:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017ec:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017f2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017f5:	7c c4                	jl     8017bb <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017f7:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017fd:	01 d0                	add    %edx,%eax
  8017ff:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801802:	90                   	nop
  801803:	c9                   	leave  
  801804:	c3                   	ret    

00801805 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801805:	55                   	push   %ebp
  801806:	89 e5                	mov    %esp,%ebp
  801808:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80180b:	ff 75 08             	pushl  0x8(%ebp)
  80180e:	e8 54 fa ff ff       	call   801267 <strlen>
  801813:	83 c4 04             	add    $0x4,%esp
  801816:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801819:	ff 75 0c             	pushl  0xc(%ebp)
  80181c:	e8 46 fa ff ff       	call   801267 <strlen>
  801821:	83 c4 04             	add    $0x4,%esp
  801824:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801827:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80182e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801835:	eb 17                	jmp    80184e <strcconcat+0x49>
		final[s] = str1[s] ;
  801837:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80183a:	8b 45 10             	mov    0x10(%ebp),%eax
  80183d:	01 c2                	add    %eax,%edx
  80183f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801842:	8b 45 08             	mov    0x8(%ebp),%eax
  801845:	01 c8                	add    %ecx,%eax
  801847:	8a 00                	mov    (%eax),%al
  801849:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80184b:	ff 45 fc             	incl   -0x4(%ebp)
  80184e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801851:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801854:	7c e1                	jl     801837 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801856:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80185d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801864:	eb 1f                	jmp    801885 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801866:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801869:	8d 50 01             	lea    0x1(%eax),%edx
  80186c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80186f:	89 c2                	mov    %eax,%edx
  801871:	8b 45 10             	mov    0x10(%ebp),%eax
  801874:	01 c2                	add    %eax,%edx
  801876:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801879:	8b 45 0c             	mov    0xc(%ebp),%eax
  80187c:	01 c8                	add    %ecx,%eax
  80187e:	8a 00                	mov    (%eax),%al
  801880:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801882:	ff 45 f8             	incl   -0x8(%ebp)
  801885:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801888:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80188b:	7c d9                	jl     801866 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80188d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801890:	8b 45 10             	mov    0x10(%ebp),%eax
  801893:	01 d0                	add    %edx,%eax
  801895:	c6 00 00             	movb   $0x0,(%eax)
}
  801898:	90                   	nop
  801899:	c9                   	leave  
  80189a:	c3                   	ret    

0080189b <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80189b:	55                   	push   %ebp
  80189c:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80189e:	8b 45 14             	mov    0x14(%ebp),%eax
  8018a1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018a7:	8b 45 14             	mov    0x14(%ebp),%eax
  8018aa:	8b 00                	mov    (%eax),%eax
  8018ac:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b6:	01 d0                	add    %edx,%eax
  8018b8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018be:	eb 0c                	jmp    8018cc <strsplit+0x31>
			*string++ = 0;
  8018c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c3:	8d 50 01             	lea    0x1(%eax),%edx
  8018c6:	89 55 08             	mov    %edx,0x8(%ebp)
  8018c9:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cf:	8a 00                	mov    (%eax),%al
  8018d1:	84 c0                	test   %al,%al
  8018d3:	74 18                	je     8018ed <strsplit+0x52>
  8018d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d8:	8a 00                	mov    (%eax),%al
  8018da:	0f be c0             	movsbl %al,%eax
  8018dd:	50                   	push   %eax
  8018de:	ff 75 0c             	pushl  0xc(%ebp)
  8018e1:	e8 13 fb ff ff       	call   8013f9 <strchr>
  8018e6:	83 c4 08             	add    $0x8,%esp
  8018e9:	85 c0                	test   %eax,%eax
  8018eb:	75 d3                	jne    8018c0 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8018ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f0:	8a 00                	mov    (%eax),%al
  8018f2:	84 c0                	test   %al,%al
  8018f4:	74 5a                	je     801950 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8018f6:	8b 45 14             	mov    0x14(%ebp),%eax
  8018f9:	8b 00                	mov    (%eax),%eax
  8018fb:	83 f8 0f             	cmp    $0xf,%eax
  8018fe:	75 07                	jne    801907 <strsplit+0x6c>
		{
			return 0;
  801900:	b8 00 00 00 00       	mov    $0x0,%eax
  801905:	eb 66                	jmp    80196d <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801907:	8b 45 14             	mov    0x14(%ebp),%eax
  80190a:	8b 00                	mov    (%eax),%eax
  80190c:	8d 48 01             	lea    0x1(%eax),%ecx
  80190f:	8b 55 14             	mov    0x14(%ebp),%edx
  801912:	89 0a                	mov    %ecx,(%edx)
  801914:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80191b:	8b 45 10             	mov    0x10(%ebp),%eax
  80191e:	01 c2                	add    %eax,%edx
  801920:	8b 45 08             	mov    0x8(%ebp),%eax
  801923:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801925:	eb 03                	jmp    80192a <strsplit+0x8f>
			string++;
  801927:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80192a:	8b 45 08             	mov    0x8(%ebp),%eax
  80192d:	8a 00                	mov    (%eax),%al
  80192f:	84 c0                	test   %al,%al
  801931:	74 8b                	je     8018be <strsplit+0x23>
  801933:	8b 45 08             	mov    0x8(%ebp),%eax
  801936:	8a 00                	mov    (%eax),%al
  801938:	0f be c0             	movsbl %al,%eax
  80193b:	50                   	push   %eax
  80193c:	ff 75 0c             	pushl  0xc(%ebp)
  80193f:	e8 b5 fa ff ff       	call   8013f9 <strchr>
  801944:	83 c4 08             	add    $0x8,%esp
  801947:	85 c0                	test   %eax,%eax
  801949:	74 dc                	je     801927 <strsplit+0x8c>
			string++;
	}
  80194b:	e9 6e ff ff ff       	jmp    8018be <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801950:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801951:	8b 45 14             	mov    0x14(%ebp),%eax
  801954:	8b 00                	mov    (%eax),%eax
  801956:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80195d:	8b 45 10             	mov    0x10(%ebp),%eax
  801960:	01 d0                	add    %edx,%eax
  801962:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801968:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80196d:	c9                   	leave  
  80196e:	c3                   	ret    

0080196f <malloc>:
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  80196f:	55                   	push   %ebp
  801970:	89 e5                	mov    %esp,%ebp
  801972:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  801975:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  80197c:	76 0a                	jbe    801988 <malloc+0x19>
		return NULL;
  80197e:	b8 00 00 00 00       	mov    $0x0,%eax
  801983:	e9 ad 02 00 00       	jmp    801c35 <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  801988:	8b 45 08             	mov    0x8(%ebp),%eax
  80198b:	c1 e8 0c             	shr    $0xc,%eax
  80198e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  801991:	8b 45 08             	mov    0x8(%ebp),%eax
  801994:	25 ff 0f 00 00       	and    $0xfff,%eax
  801999:	85 c0                	test   %eax,%eax
  80199b:	74 03                	je     8019a0 <malloc+0x31>
		num++;
  80199d:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  8019a0:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8019a5:	85 c0                	test   %eax,%eax
  8019a7:	75 71                	jne    801a1a <malloc+0xab>
		sys_allocateMem(last_addres, size);
  8019a9:	a1 04 30 80 00       	mov    0x803004,%eax
  8019ae:	83 ec 08             	sub    $0x8,%esp
  8019b1:	ff 75 08             	pushl  0x8(%ebp)
  8019b4:	50                   	push   %eax
  8019b5:	e8 ba 05 00 00       	call   801f74 <sys_allocateMem>
  8019ba:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  8019bd:	a1 04 30 80 00       	mov    0x803004,%eax
  8019c2:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  8019c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019c8:	c1 e0 0c             	shl    $0xc,%eax
  8019cb:	89 c2                	mov    %eax,%edx
  8019cd:	a1 04 30 80 00       	mov    0x803004,%eax
  8019d2:	01 d0                	add    %edx,%eax
  8019d4:	a3 04 30 80 00       	mov    %eax,0x803004
		numOfPages[sizeofarray] = num;
  8019d9:	a1 30 30 80 00       	mov    0x803030,%eax
  8019de:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8019e1:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  8019e8:	a1 30 30 80 00       	mov    0x803030,%eax
  8019ed:	8b 55 c8             	mov    -0x38(%ebp),%edx
  8019f0:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
		changed[sizeofarray] = 1;
  8019f7:	a1 30 30 80 00       	mov    0x803030,%eax
  8019fc:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801a03:	01 00 00 00 
		sizeofarray++;
  801a07:	a1 30 30 80 00       	mov    0x803030,%eax
  801a0c:	40                   	inc    %eax
  801a0d:	a3 30 30 80 00       	mov    %eax,0x803030
		return (void*) return_addres;
  801a12:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801a15:	e9 1b 02 00 00       	jmp    801c35 <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  801a1a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  801a21:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  801a28:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  801a2f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  801a36:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  801a3d:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801a44:	eb 72                	jmp    801ab8 <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  801a46:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a49:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801a50:	85 c0                	test   %eax,%eax
  801a52:	75 12                	jne    801a66 <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  801a54:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a57:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801a5e:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  801a61:	ff 45 dc             	incl   -0x24(%ebp)
  801a64:	eb 4f                	jmp    801ab5 <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  801a66:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a69:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801a6c:	7d 39                	jge    801aa7 <malloc+0x138>
  801a6e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a71:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a74:	7c 31                	jl     801aa7 <malloc+0x138>
					{
						min=count;
  801a76:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801a79:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  801a7c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a7f:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801a86:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a89:	c1 e2 0c             	shl    $0xc,%edx
  801a8c:	29 d0                	sub    %edx,%eax
  801a8e:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  801a91:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801a94:	2b 45 dc             	sub    -0x24(%ebp),%eax
  801a97:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  801a9a:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  801aa1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801aa4:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  801aa7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  801aae:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  801ab5:	ff 45 d4             	incl   -0x2c(%ebp)
  801ab8:	a1 30 30 80 00       	mov    0x803030,%eax
  801abd:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  801ac0:	7c 84                	jl     801a46 <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  801ac2:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  801ac6:	0f 85 e3 00 00 00    	jne    801baf <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  801acc:	83 ec 08             	sub    $0x8,%esp
  801acf:	ff 75 08             	pushl  0x8(%ebp)
  801ad2:	ff 75 e0             	pushl  -0x20(%ebp)
  801ad5:	e8 9a 04 00 00       	call   801f74 <sys_allocateMem>
  801ada:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  801add:	a1 30 30 80 00       	mov    0x803030,%eax
  801ae2:	40                   	inc    %eax
  801ae3:	a3 30 30 80 00       	mov    %eax,0x803030
				for(int i=sizeofarray-1;i>index;i--)
  801ae8:	a1 30 30 80 00       	mov    0x803030,%eax
  801aed:	48                   	dec    %eax
  801aee:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801af1:	eb 42                	jmp    801b35 <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  801af3:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801af6:	48                   	dec    %eax
  801af7:	8b 14 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%edx
  801afe:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b01:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  801b08:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b0b:	48                   	dec    %eax
  801b0c:	8b 14 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%edx
  801b13:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b16:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					changed[i]=changed[i-1];
  801b1d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b20:	48                   	dec    %eax
  801b21:	8b 14 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%edx
  801b28:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b2b:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  801b32:	ff 4d d0             	decl   -0x30(%ebp)
  801b35:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801b38:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801b3b:	7f b6                	jg     801af3 <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  801b3d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b40:	40                   	inc    %eax
  801b41:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  801b44:	8b 55 08             	mov    0x8(%ebp),%edx
  801b47:	01 ca                	add    %ecx,%edx
  801b49:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  801b50:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b53:	8d 50 01             	lea    0x1(%eax),%edx
  801b56:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b59:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801b60:	2b 45 f4             	sub    -0xc(%ebp),%eax
  801b63:	89 04 95 a0 80 92 00 	mov    %eax,0x9280a0(,%edx,4)
				changed[index+1]=0;
  801b6a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b6d:	40                   	inc    %eax
  801b6e:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801b75:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  801b79:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b7c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b7f:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  801b86:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b89:	89 45 cc             	mov    %eax,-0x34(%ebp)
  801b8c:	eb 11                	jmp    801b9f <malloc+0x230>
				{
					changed[index] = 1;
  801b8e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801b91:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801b98:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  801b9c:	ff 45 cc             	incl   -0x34(%ebp)
  801b9f:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801ba2:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801ba5:	7c e7                	jl     801b8e <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  801ba7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801baa:	e9 86 00 00 00       	jmp    801c35 <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  801baf:	a1 04 30 80 00       	mov    0x803004,%eax
  801bb4:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801bb9:	29 c2                	sub    %eax,%edx
  801bbb:	89 d0                	mov    %edx,%eax
  801bbd:	3b 45 08             	cmp    0x8(%ebp),%eax
  801bc0:	73 07                	jae    801bc9 <malloc+0x25a>
						return NULL;
  801bc2:	b8 00 00 00 00       	mov    $0x0,%eax
  801bc7:	eb 6c                	jmp    801c35 <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801bc9:	a1 04 30 80 00       	mov    0x803004,%eax
  801bce:	83 ec 08             	sub    $0x8,%esp
  801bd1:	ff 75 08             	pushl  0x8(%ebp)
  801bd4:	50                   	push   %eax
  801bd5:	e8 9a 03 00 00       	call   801f74 <sys_allocateMem>
  801bda:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801bdd:	a1 04 30 80 00       	mov    0x803004,%eax
  801be2:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  801be5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801be8:	c1 e0 0c             	shl    $0xc,%eax
  801beb:	89 c2                	mov    %eax,%edx
  801bed:	a1 04 30 80 00       	mov    0x803004,%eax
  801bf2:	01 d0                	add    %edx,%eax
  801bf4:	a3 04 30 80 00       	mov    %eax,0x803004
					numOfPages[sizeofarray] = num;
  801bf9:	a1 30 30 80 00       	mov    0x803030,%eax
  801bfe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c01:	89 14 85 a0 80 92 00 	mov    %edx,0x9280a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  801c08:	a1 30 30 80 00       	mov    0x803030,%eax
  801c0d:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801c10:	89 14 85 a0 4b 86 00 	mov    %edx,0x864ba0(,%eax,4)
					changed[sizeofarray] = 1;
  801c17:	a1 30 30 80 00       	mov    0x803030,%eax
  801c1c:	c7 04 85 20 66 8c 00 	movl   $0x1,0x8c6620(,%eax,4)
  801c23:	01 00 00 00 
					sizeofarray++;
  801c27:	a1 30 30 80 00       	mov    0x803030,%eax
  801c2c:	40                   	inc    %eax
  801c2d:	a3 30 30 80 00       	mov    %eax,0x803030
					return (void*) return_addres;
  801c32:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  801c35:	c9                   	leave  
  801c36:	c3                   	ret    

00801c37 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801c37:	55                   	push   %ebp
  801c38:	89 e5                	mov    %esp,%ebp
  801c3a:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801c3d:	8b 45 08             	mov    0x8(%ebp),%eax
  801c40:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  801c43:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801c4a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801c51:	eb 30                	jmp    801c83 <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801c53:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c56:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801c5d:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801c60:	75 1e                	jne    801c80 <free+0x49>
  801c62:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c65:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801c6c:	83 f8 01             	cmp    $0x1,%eax
  801c6f:	75 0f                	jne    801c80 <free+0x49>
			is_found = 1;
  801c71:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801c78:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801c7e:	eb 0d                	jmp    801c8d <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801c80:	ff 45 ec             	incl   -0x14(%ebp)
  801c83:	a1 30 30 80 00       	mov    0x803030,%eax
  801c88:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801c8b:	7c c6                	jl     801c53 <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801c8d:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801c91:	75 3a                	jne    801ccd <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  801c93:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c96:	8b 04 85 a0 80 92 00 	mov    0x9280a0(,%eax,4),%eax
  801c9d:	c1 e0 0c             	shl    $0xc,%eax
  801ca0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  801ca3:	83 ec 08             	sub    $0x8,%esp
  801ca6:	ff 75 e4             	pushl  -0x1c(%ebp)
  801ca9:	ff 75 e8             	pushl  -0x18(%ebp)
  801cac:	e8 a7 02 00 00       	call   801f58 <sys_freeMem>
  801cb1:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801cb4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cb7:	c7 04 85 20 66 8c 00 	movl   $0x0,0x8c6620(,%eax,4)
  801cbe:	00 00 00 00 
		changes++;
  801cc2:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801cc7:	40                   	inc    %eax
  801cc8:	a3 2c 30 80 00       	mov    %eax,0x80302c
	}
	//refer to the project presentation and documentation for details
}
  801ccd:	90                   	nop
  801cce:	c9                   	leave  
  801ccf:	c3                   	ret    

00801cd0 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801cd0:	55                   	push   %ebp
  801cd1:	89 e5                	mov    %esp,%ebp
  801cd3:	83 ec 18             	sub    $0x18,%esp
  801cd6:	8b 45 10             	mov    0x10(%ebp),%eax
  801cd9:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801cdc:	83 ec 04             	sub    $0x4,%esp
  801cdf:	68 a4 2d 80 00       	push   $0x802da4
  801ce4:	68 b6 00 00 00       	push   $0xb6
  801ce9:	68 c7 2d 80 00       	push   $0x802dc7
  801cee:	e8 4a ea ff ff       	call   80073d <_panic>

00801cf3 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801cf3:	55                   	push   %ebp
  801cf4:	89 e5                	mov    %esp,%ebp
  801cf6:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801cf9:	83 ec 04             	sub    $0x4,%esp
  801cfc:	68 a4 2d 80 00       	push   $0x802da4
  801d01:	68 bb 00 00 00       	push   $0xbb
  801d06:	68 c7 2d 80 00       	push   $0x802dc7
  801d0b:	e8 2d ea ff ff       	call   80073d <_panic>

00801d10 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801d10:	55                   	push   %ebp
  801d11:	89 e5                	mov    %esp,%ebp
  801d13:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d16:	83 ec 04             	sub    $0x4,%esp
  801d19:	68 a4 2d 80 00       	push   $0x802da4
  801d1e:	68 c0 00 00 00       	push   $0xc0
  801d23:	68 c7 2d 80 00       	push   $0x802dc7
  801d28:	e8 10 ea ff ff       	call   80073d <_panic>

00801d2d <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  801d2d:	55                   	push   %ebp
  801d2e:	89 e5                	mov    %esp,%ebp
  801d30:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d33:	83 ec 04             	sub    $0x4,%esp
  801d36:	68 a4 2d 80 00       	push   $0x802da4
  801d3b:	68 c4 00 00 00       	push   $0xc4
  801d40:	68 c7 2d 80 00       	push   $0x802dc7
  801d45:	e8 f3 e9 ff ff       	call   80073d <_panic>

00801d4a <expand>:
	return 0;
}

void expand(uint32 newSize) {
  801d4a:	55                   	push   %ebp
  801d4b:	89 e5                	mov    %esp,%ebp
  801d4d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d50:	83 ec 04             	sub    $0x4,%esp
  801d53:	68 a4 2d 80 00       	push   $0x802da4
  801d58:	68 c9 00 00 00       	push   $0xc9
  801d5d:	68 c7 2d 80 00       	push   $0x802dc7
  801d62:	e8 d6 e9 ff ff       	call   80073d <_panic>

00801d67 <shrink>:
}
void shrink(uint32 newSize) {
  801d67:	55                   	push   %ebp
  801d68:	89 e5                	mov    %esp,%ebp
  801d6a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d6d:	83 ec 04             	sub    $0x4,%esp
  801d70:	68 a4 2d 80 00       	push   $0x802da4
  801d75:	68 cc 00 00 00       	push   $0xcc
  801d7a:	68 c7 2d 80 00       	push   $0x802dc7
  801d7f:	e8 b9 e9 ff ff       	call   80073d <_panic>

00801d84 <freeHeap>:
}

void freeHeap(void* virtual_address) {
  801d84:	55                   	push   %ebp
  801d85:	89 e5                	mov    %esp,%ebp
  801d87:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d8a:	83 ec 04             	sub    $0x4,%esp
  801d8d:	68 a4 2d 80 00       	push   $0x802da4
  801d92:	68 d0 00 00 00       	push   $0xd0
  801d97:	68 c7 2d 80 00       	push   $0x802dc7
  801d9c:	e8 9c e9 ff ff       	call   80073d <_panic>

00801da1 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801da1:	55                   	push   %ebp
  801da2:	89 e5                	mov    %esp,%ebp
  801da4:	57                   	push   %edi
  801da5:	56                   	push   %esi
  801da6:	53                   	push   %ebx
  801da7:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801daa:	8b 45 08             	mov    0x8(%ebp),%eax
  801dad:	8b 55 0c             	mov    0xc(%ebp),%edx
  801db0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801db3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801db6:	8b 7d 18             	mov    0x18(%ebp),%edi
  801db9:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801dbc:	cd 30                	int    $0x30
  801dbe:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801dc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801dc4:	83 c4 10             	add    $0x10,%esp
  801dc7:	5b                   	pop    %ebx
  801dc8:	5e                   	pop    %esi
  801dc9:	5f                   	pop    %edi
  801dca:	5d                   	pop    %ebp
  801dcb:	c3                   	ret    

00801dcc <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801dcc:	55                   	push   %ebp
  801dcd:	89 e5                	mov    %esp,%ebp
  801dcf:	83 ec 04             	sub    $0x4,%esp
  801dd2:	8b 45 10             	mov    0x10(%ebp),%eax
  801dd5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801dd8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ddc:	8b 45 08             	mov    0x8(%ebp),%eax
  801ddf:	6a 00                	push   $0x0
  801de1:	6a 00                	push   $0x0
  801de3:	52                   	push   %edx
  801de4:	ff 75 0c             	pushl  0xc(%ebp)
  801de7:	50                   	push   %eax
  801de8:	6a 00                	push   $0x0
  801dea:	e8 b2 ff ff ff       	call   801da1 <syscall>
  801def:	83 c4 18             	add    $0x18,%esp
}
  801df2:	90                   	nop
  801df3:	c9                   	leave  
  801df4:	c3                   	ret    

00801df5 <sys_cgetc>:

int
sys_cgetc(void)
{
  801df5:	55                   	push   %ebp
  801df6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801df8:	6a 00                	push   $0x0
  801dfa:	6a 00                	push   $0x0
  801dfc:	6a 00                	push   $0x0
  801dfe:	6a 00                	push   $0x0
  801e00:	6a 00                	push   $0x0
  801e02:	6a 01                	push   $0x1
  801e04:	e8 98 ff ff ff       	call   801da1 <syscall>
  801e09:	83 c4 18             	add    $0x18,%esp
}
  801e0c:	c9                   	leave  
  801e0d:	c3                   	ret    

00801e0e <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801e0e:	55                   	push   %ebp
  801e0f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801e11:	8b 45 08             	mov    0x8(%ebp),%eax
  801e14:	6a 00                	push   $0x0
  801e16:	6a 00                	push   $0x0
  801e18:	6a 00                	push   $0x0
  801e1a:	6a 00                	push   $0x0
  801e1c:	50                   	push   %eax
  801e1d:	6a 05                	push   $0x5
  801e1f:	e8 7d ff ff ff       	call   801da1 <syscall>
  801e24:	83 c4 18             	add    $0x18,%esp
}
  801e27:	c9                   	leave  
  801e28:	c3                   	ret    

00801e29 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801e29:	55                   	push   %ebp
  801e2a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801e2c:	6a 00                	push   $0x0
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	6a 02                	push   $0x2
  801e38:	e8 64 ff ff ff       	call   801da1 <syscall>
  801e3d:	83 c4 18             	add    $0x18,%esp
}
  801e40:	c9                   	leave  
  801e41:	c3                   	ret    

00801e42 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801e42:	55                   	push   %ebp
  801e43:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801e45:	6a 00                	push   $0x0
  801e47:	6a 00                	push   $0x0
  801e49:	6a 00                	push   $0x0
  801e4b:	6a 00                	push   $0x0
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 03                	push   $0x3
  801e51:	e8 4b ff ff ff       	call   801da1 <syscall>
  801e56:	83 c4 18             	add    $0x18,%esp
}
  801e59:	c9                   	leave  
  801e5a:	c3                   	ret    

00801e5b <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801e5b:	55                   	push   %ebp
  801e5c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801e5e:	6a 00                	push   $0x0
  801e60:	6a 00                	push   $0x0
  801e62:	6a 00                	push   $0x0
  801e64:	6a 00                	push   $0x0
  801e66:	6a 00                	push   $0x0
  801e68:	6a 04                	push   $0x4
  801e6a:	e8 32 ff ff ff       	call   801da1 <syscall>
  801e6f:	83 c4 18             	add    $0x18,%esp
}
  801e72:	c9                   	leave  
  801e73:	c3                   	ret    

00801e74 <sys_env_exit>:


void sys_env_exit(void)
{
  801e74:	55                   	push   %ebp
  801e75:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801e77:	6a 00                	push   $0x0
  801e79:	6a 00                	push   $0x0
  801e7b:	6a 00                	push   $0x0
  801e7d:	6a 00                	push   $0x0
  801e7f:	6a 00                	push   $0x0
  801e81:	6a 06                	push   $0x6
  801e83:	e8 19 ff ff ff       	call   801da1 <syscall>
  801e88:	83 c4 18             	add    $0x18,%esp
}
  801e8b:	90                   	nop
  801e8c:	c9                   	leave  
  801e8d:	c3                   	ret    

00801e8e <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801e8e:	55                   	push   %ebp
  801e8f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801e91:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e94:	8b 45 08             	mov    0x8(%ebp),%eax
  801e97:	6a 00                	push   $0x0
  801e99:	6a 00                	push   $0x0
  801e9b:	6a 00                	push   $0x0
  801e9d:	52                   	push   %edx
  801e9e:	50                   	push   %eax
  801e9f:	6a 07                	push   $0x7
  801ea1:	e8 fb fe ff ff       	call   801da1 <syscall>
  801ea6:	83 c4 18             	add    $0x18,%esp
}
  801ea9:	c9                   	leave  
  801eaa:	c3                   	ret    

00801eab <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801eab:	55                   	push   %ebp
  801eac:	89 e5                	mov    %esp,%ebp
  801eae:	56                   	push   %esi
  801eaf:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801eb0:	8b 75 18             	mov    0x18(%ebp),%esi
  801eb3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801eb6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801eb9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ebc:	8b 45 08             	mov    0x8(%ebp),%eax
  801ebf:	56                   	push   %esi
  801ec0:	53                   	push   %ebx
  801ec1:	51                   	push   %ecx
  801ec2:	52                   	push   %edx
  801ec3:	50                   	push   %eax
  801ec4:	6a 08                	push   $0x8
  801ec6:	e8 d6 fe ff ff       	call   801da1 <syscall>
  801ecb:	83 c4 18             	add    $0x18,%esp
}
  801ece:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801ed1:	5b                   	pop    %ebx
  801ed2:	5e                   	pop    %esi
  801ed3:	5d                   	pop    %ebp
  801ed4:	c3                   	ret    

00801ed5 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801ed5:	55                   	push   %ebp
  801ed6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801ed8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801edb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ede:	6a 00                	push   $0x0
  801ee0:	6a 00                	push   $0x0
  801ee2:	6a 00                	push   $0x0
  801ee4:	52                   	push   %edx
  801ee5:	50                   	push   %eax
  801ee6:	6a 09                	push   $0x9
  801ee8:	e8 b4 fe ff ff       	call   801da1 <syscall>
  801eed:	83 c4 18             	add    $0x18,%esp
}
  801ef0:	c9                   	leave  
  801ef1:	c3                   	ret    

00801ef2 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801ef2:	55                   	push   %ebp
  801ef3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801ef5:	6a 00                	push   $0x0
  801ef7:	6a 00                	push   $0x0
  801ef9:	6a 00                	push   $0x0
  801efb:	ff 75 0c             	pushl  0xc(%ebp)
  801efe:	ff 75 08             	pushl  0x8(%ebp)
  801f01:	6a 0a                	push   $0xa
  801f03:	e8 99 fe ff ff       	call   801da1 <syscall>
  801f08:	83 c4 18             	add    $0x18,%esp
}
  801f0b:	c9                   	leave  
  801f0c:	c3                   	ret    

00801f0d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801f0d:	55                   	push   %ebp
  801f0e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801f10:	6a 00                	push   $0x0
  801f12:	6a 00                	push   $0x0
  801f14:	6a 00                	push   $0x0
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 0b                	push   $0xb
  801f1c:	e8 80 fe ff ff       	call   801da1 <syscall>
  801f21:	83 c4 18             	add    $0x18,%esp
}
  801f24:	c9                   	leave  
  801f25:	c3                   	ret    

00801f26 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801f26:	55                   	push   %ebp
  801f27:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801f29:	6a 00                	push   $0x0
  801f2b:	6a 00                	push   $0x0
  801f2d:	6a 00                	push   $0x0
  801f2f:	6a 00                	push   $0x0
  801f31:	6a 00                	push   $0x0
  801f33:	6a 0c                	push   $0xc
  801f35:	e8 67 fe ff ff       	call   801da1 <syscall>
  801f3a:	83 c4 18             	add    $0x18,%esp
}
  801f3d:	c9                   	leave  
  801f3e:	c3                   	ret    

00801f3f <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801f3f:	55                   	push   %ebp
  801f40:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801f42:	6a 00                	push   $0x0
  801f44:	6a 00                	push   $0x0
  801f46:	6a 00                	push   $0x0
  801f48:	6a 00                	push   $0x0
  801f4a:	6a 00                	push   $0x0
  801f4c:	6a 0d                	push   $0xd
  801f4e:	e8 4e fe ff ff       	call   801da1 <syscall>
  801f53:	83 c4 18             	add    $0x18,%esp
}
  801f56:	c9                   	leave  
  801f57:	c3                   	ret    

00801f58 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801f58:	55                   	push   %ebp
  801f59:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801f5b:	6a 00                	push   $0x0
  801f5d:	6a 00                	push   $0x0
  801f5f:	6a 00                	push   $0x0
  801f61:	ff 75 0c             	pushl  0xc(%ebp)
  801f64:	ff 75 08             	pushl  0x8(%ebp)
  801f67:	6a 11                	push   $0x11
  801f69:	e8 33 fe ff ff       	call   801da1 <syscall>
  801f6e:	83 c4 18             	add    $0x18,%esp
	return;
  801f71:	90                   	nop
}
  801f72:	c9                   	leave  
  801f73:	c3                   	ret    

00801f74 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801f74:	55                   	push   %ebp
  801f75:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801f77:	6a 00                	push   $0x0
  801f79:	6a 00                	push   $0x0
  801f7b:	6a 00                	push   $0x0
  801f7d:	ff 75 0c             	pushl  0xc(%ebp)
  801f80:	ff 75 08             	pushl  0x8(%ebp)
  801f83:	6a 12                	push   $0x12
  801f85:	e8 17 fe ff ff       	call   801da1 <syscall>
  801f8a:	83 c4 18             	add    $0x18,%esp
	return ;
  801f8d:	90                   	nop
}
  801f8e:	c9                   	leave  
  801f8f:	c3                   	ret    

00801f90 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801f90:	55                   	push   %ebp
  801f91:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801f93:	6a 00                	push   $0x0
  801f95:	6a 00                	push   $0x0
  801f97:	6a 00                	push   $0x0
  801f99:	6a 00                	push   $0x0
  801f9b:	6a 00                	push   $0x0
  801f9d:	6a 0e                	push   $0xe
  801f9f:	e8 fd fd ff ff       	call   801da1 <syscall>
  801fa4:	83 c4 18             	add    $0x18,%esp
}
  801fa7:	c9                   	leave  
  801fa8:	c3                   	ret    

00801fa9 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801fa9:	55                   	push   %ebp
  801faa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	6a 00                	push   $0x0
  801fb2:	6a 00                	push   $0x0
  801fb4:	ff 75 08             	pushl  0x8(%ebp)
  801fb7:	6a 0f                	push   $0xf
  801fb9:	e8 e3 fd ff ff       	call   801da1 <syscall>
  801fbe:	83 c4 18             	add    $0x18,%esp
}
  801fc1:	c9                   	leave  
  801fc2:	c3                   	ret    

00801fc3 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801fc3:	55                   	push   %ebp
  801fc4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801fc6:	6a 00                	push   $0x0
  801fc8:	6a 00                	push   $0x0
  801fca:	6a 00                	push   $0x0
  801fcc:	6a 00                	push   $0x0
  801fce:	6a 00                	push   $0x0
  801fd0:	6a 10                	push   $0x10
  801fd2:	e8 ca fd ff ff       	call   801da1 <syscall>
  801fd7:	83 c4 18             	add    $0x18,%esp
}
  801fda:	90                   	nop
  801fdb:	c9                   	leave  
  801fdc:	c3                   	ret    

00801fdd <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801fdd:	55                   	push   %ebp
  801fde:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801fe0:	6a 00                	push   $0x0
  801fe2:	6a 00                	push   $0x0
  801fe4:	6a 00                	push   $0x0
  801fe6:	6a 00                	push   $0x0
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 14                	push   $0x14
  801fec:	e8 b0 fd ff ff       	call   801da1 <syscall>
  801ff1:	83 c4 18             	add    $0x18,%esp
}
  801ff4:	90                   	nop
  801ff5:	c9                   	leave  
  801ff6:	c3                   	ret    

00801ff7 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801ff7:	55                   	push   %ebp
  801ff8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801ffa:	6a 00                	push   $0x0
  801ffc:	6a 00                	push   $0x0
  801ffe:	6a 00                	push   $0x0
  802000:	6a 00                	push   $0x0
  802002:	6a 00                	push   $0x0
  802004:	6a 15                	push   $0x15
  802006:	e8 96 fd ff ff       	call   801da1 <syscall>
  80200b:	83 c4 18             	add    $0x18,%esp
}
  80200e:	90                   	nop
  80200f:	c9                   	leave  
  802010:	c3                   	ret    

00802011 <sys_cputc>:


void
sys_cputc(const char c)
{
  802011:	55                   	push   %ebp
  802012:	89 e5                	mov    %esp,%ebp
  802014:	83 ec 04             	sub    $0x4,%esp
  802017:	8b 45 08             	mov    0x8(%ebp),%eax
  80201a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80201d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802021:	6a 00                	push   $0x0
  802023:	6a 00                	push   $0x0
  802025:	6a 00                	push   $0x0
  802027:	6a 00                	push   $0x0
  802029:	50                   	push   %eax
  80202a:	6a 16                	push   $0x16
  80202c:	e8 70 fd ff ff       	call   801da1 <syscall>
  802031:	83 c4 18             	add    $0x18,%esp
}
  802034:	90                   	nop
  802035:	c9                   	leave  
  802036:	c3                   	ret    

00802037 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802037:	55                   	push   %ebp
  802038:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80203a:	6a 00                	push   $0x0
  80203c:	6a 00                	push   $0x0
  80203e:	6a 00                	push   $0x0
  802040:	6a 00                	push   $0x0
  802042:	6a 00                	push   $0x0
  802044:	6a 17                	push   $0x17
  802046:	e8 56 fd ff ff       	call   801da1 <syscall>
  80204b:	83 c4 18             	add    $0x18,%esp
}
  80204e:	90                   	nop
  80204f:	c9                   	leave  
  802050:	c3                   	ret    

00802051 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802051:	55                   	push   %ebp
  802052:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802054:	8b 45 08             	mov    0x8(%ebp),%eax
  802057:	6a 00                	push   $0x0
  802059:	6a 00                	push   $0x0
  80205b:	6a 00                	push   $0x0
  80205d:	ff 75 0c             	pushl  0xc(%ebp)
  802060:	50                   	push   %eax
  802061:	6a 18                	push   $0x18
  802063:	e8 39 fd ff ff       	call   801da1 <syscall>
  802068:	83 c4 18             	add    $0x18,%esp
}
  80206b:	c9                   	leave  
  80206c:	c3                   	ret    

0080206d <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80206d:	55                   	push   %ebp
  80206e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802070:	8b 55 0c             	mov    0xc(%ebp),%edx
  802073:	8b 45 08             	mov    0x8(%ebp),%eax
  802076:	6a 00                	push   $0x0
  802078:	6a 00                	push   $0x0
  80207a:	6a 00                	push   $0x0
  80207c:	52                   	push   %edx
  80207d:	50                   	push   %eax
  80207e:	6a 1b                	push   $0x1b
  802080:	e8 1c fd ff ff       	call   801da1 <syscall>
  802085:	83 c4 18             	add    $0x18,%esp
}
  802088:	c9                   	leave  
  802089:	c3                   	ret    

0080208a <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80208a:	55                   	push   %ebp
  80208b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80208d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802090:	8b 45 08             	mov    0x8(%ebp),%eax
  802093:	6a 00                	push   $0x0
  802095:	6a 00                	push   $0x0
  802097:	6a 00                	push   $0x0
  802099:	52                   	push   %edx
  80209a:	50                   	push   %eax
  80209b:	6a 19                	push   $0x19
  80209d:	e8 ff fc ff ff       	call   801da1 <syscall>
  8020a2:	83 c4 18             	add    $0x18,%esp
}
  8020a5:	90                   	nop
  8020a6:	c9                   	leave  
  8020a7:	c3                   	ret    

008020a8 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8020a8:	55                   	push   %ebp
  8020a9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b1:	6a 00                	push   $0x0
  8020b3:	6a 00                	push   $0x0
  8020b5:	6a 00                	push   $0x0
  8020b7:	52                   	push   %edx
  8020b8:	50                   	push   %eax
  8020b9:	6a 1a                	push   $0x1a
  8020bb:	e8 e1 fc ff ff       	call   801da1 <syscall>
  8020c0:	83 c4 18             	add    $0x18,%esp
}
  8020c3:	90                   	nop
  8020c4:	c9                   	leave  
  8020c5:	c3                   	ret    

008020c6 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8020c6:	55                   	push   %ebp
  8020c7:	89 e5                	mov    %esp,%ebp
  8020c9:	83 ec 04             	sub    $0x4,%esp
  8020cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8020cf:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8020d2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8020d5:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8020d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8020dc:	6a 00                	push   $0x0
  8020de:	51                   	push   %ecx
  8020df:	52                   	push   %edx
  8020e0:	ff 75 0c             	pushl  0xc(%ebp)
  8020e3:	50                   	push   %eax
  8020e4:	6a 1c                	push   $0x1c
  8020e6:	e8 b6 fc ff ff       	call   801da1 <syscall>
  8020eb:	83 c4 18             	add    $0x18,%esp
}
  8020ee:	c9                   	leave  
  8020ef:	c3                   	ret    

008020f0 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8020f0:	55                   	push   %ebp
  8020f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8020f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f9:	6a 00                	push   $0x0
  8020fb:	6a 00                	push   $0x0
  8020fd:	6a 00                	push   $0x0
  8020ff:	52                   	push   %edx
  802100:	50                   	push   %eax
  802101:	6a 1d                	push   $0x1d
  802103:	e8 99 fc ff ff       	call   801da1 <syscall>
  802108:	83 c4 18             	add    $0x18,%esp
}
  80210b:	c9                   	leave  
  80210c:	c3                   	ret    

0080210d <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80210d:	55                   	push   %ebp
  80210e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802110:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802113:	8b 55 0c             	mov    0xc(%ebp),%edx
  802116:	8b 45 08             	mov    0x8(%ebp),%eax
  802119:	6a 00                	push   $0x0
  80211b:	6a 00                	push   $0x0
  80211d:	51                   	push   %ecx
  80211e:	52                   	push   %edx
  80211f:	50                   	push   %eax
  802120:	6a 1e                	push   $0x1e
  802122:	e8 7a fc ff ff       	call   801da1 <syscall>
  802127:	83 c4 18             	add    $0x18,%esp
}
  80212a:	c9                   	leave  
  80212b:	c3                   	ret    

0080212c <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80212c:	55                   	push   %ebp
  80212d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80212f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802132:	8b 45 08             	mov    0x8(%ebp),%eax
  802135:	6a 00                	push   $0x0
  802137:	6a 00                	push   $0x0
  802139:	6a 00                	push   $0x0
  80213b:	52                   	push   %edx
  80213c:	50                   	push   %eax
  80213d:	6a 1f                	push   $0x1f
  80213f:	e8 5d fc ff ff       	call   801da1 <syscall>
  802144:	83 c4 18             	add    $0x18,%esp
}
  802147:	c9                   	leave  
  802148:	c3                   	ret    

00802149 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802149:	55                   	push   %ebp
  80214a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80214c:	6a 00                	push   $0x0
  80214e:	6a 00                	push   $0x0
  802150:	6a 00                	push   $0x0
  802152:	6a 00                	push   $0x0
  802154:	6a 00                	push   $0x0
  802156:	6a 20                	push   $0x20
  802158:	e8 44 fc ff ff       	call   801da1 <syscall>
  80215d:	83 c4 18             	add    $0x18,%esp
}
  802160:	c9                   	leave  
  802161:	c3                   	ret    

00802162 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802162:	55                   	push   %ebp
  802163:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802165:	8b 45 08             	mov    0x8(%ebp),%eax
  802168:	6a 00                	push   $0x0
  80216a:	ff 75 14             	pushl  0x14(%ebp)
  80216d:	ff 75 10             	pushl  0x10(%ebp)
  802170:	ff 75 0c             	pushl  0xc(%ebp)
  802173:	50                   	push   %eax
  802174:	6a 21                	push   $0x21
  802176:	e8 26 fc ff ff       	call   801da1 <syscall>
  80217b:	83 c4 18             	add    $0x18,%esp
}
  80217e:	c9                   	leave  
  80217f:	c3                   	ret    

00802180 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802180:	55                   	push   %ebp
  802181:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802183:	8b 45 08             	mov    0x8(%ebp),%eax
  802186:	6a 00                	push   $0x0
  802188:	6a 00                	push   $0x0
  80218a:	6a 00                	push   $0x0
  80218c:	6a 00                	push   $0x0
  80218e:	50                   	push   %eax
  80218f:	6a 22                	push   $0x22
  802191:	e8 0b fc ff ff       	call   801da1 <syscall>
  802196:	83 c4 18             	add    $0x18,%esp
}
  802199:	90                   	nop
  80219a:	c9                   	leave  
  80219b:	c3                   	ret    

0080219c <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80219c:	55                   	push   %ebp
  80219d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80219f:	8b 45 08             	mov    0x8(%ebp),%eax
  8021a2:	6a 00                	push   $0x0
  8021a4:	6a 00                	push   $0x0
  8021a6:	6a 00                	push   $0x0
  8021a8:	6a 00                	push   $0x0
  8021aa:	50                   	push   %eax
  8021ab:	6a 23                	push   $0x23
  8021ad:	e8 ef fb ff ff       	call   801da1 <syscall>
  8021b2:	83 c4 18             	add    $0x18,%esp
}
  8021b5:	90                   	nop
  8021b6:	c9                   	leave  
  8021b7:	c3                   	ret    

008021b8 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8021b8:	55                   	push   %ebp
  8021b9:	89 e5                	mov    %esp,%ebp
  8021bb:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8021be:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8021c1:	8d 50 04             	lea    0x4(%eax),%edx
  8021c4:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8021c7:	6a 00                	push   $0x0
  8021c9:	6a 00                	push   $0x0
  8021cb:	6a 00                	push   $0x0
  8021cd:	52                   	push   %edx
  8021ce:	50                   	push   %eax
  8021cf:	6a 24                	push   $0x24
  8021d1:	e8 cb fb ff ff       	call   801da1 <syscall>
  8021d6:	83 c4 18             	add    $0x18,%esp
	return result;
  8021d9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8021dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8021df:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8021e2:	89 01                	mov    %eax,(%ecx)
  8021e4:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8021e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ea:	c9                   	leave  
  8021eb:	c2 04 00             	ret    $0x4

008021ee <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8021ee:	55                   	push   %ebp
  8021ef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8021f1:	6a 00                	push   $0x0
  8021f3:	6a 00                	push   $0x0
  8021f5:	ff 75 10             	pushl  0x10(%ebp)
  8021f8:	ff 75 0c             	pushl  0xc(%ebp)
  8021fb:	ff 75 08             	pushl  0x8(%ebp)
  8021fe:	6a 13                	push   $0x13
  802200:	e8 9c fb ff ff       	call   801da1 <syscall>
  802205:	83 c4 18             	add    $0x18,%esp
	return ;
  802208:	90                   	nop
}
  802209:	c9                   	leave  
  80220a:	c3                   	ret    

0080220b <sys_rcr2>:
uint32 sys_rcr2()
{
  80220b:	55                   	push   %ebp
  80220c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80220e:	6a 00                	push   $0x0
  802210:	6a 00                	push   $0x0
  802212:	6a 00                	push   $0x0
  802214:	6a 00                	push   $0x0
  802216:	6a 00                	push   $0x0
  802218:	6a 25                	push   $0x25
  80221a:	e8 82 fb ff ff       	call   801da1 <syscall>
  80221f:	83 c4 18             	add    $0x18,%esp
}
  802222:	c9                   	leave  
  802223:	c3                   	ret    

00802224 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802224:	55                   	push   %ebp
  802225:	89 e5                	mov    %esp,%ebp
  802227:	83 ec 04             	sub    $0x4,%esp
  80222a:	8b 45 08             	mov    0x8(%ebp),%eax
  80222d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802230:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802234:	6a 00                	push   $0x0
  802236:	6a 00                	push   $0x0
  802238:	6a 00                	push   $0x0
  80223a:	6a 00                	push   $0x0
  80223c:	50                   	push   %eax
  80223d:	6a 26                	push   $0x26
  80223f:	e8 5d fb ff ff       	call   801da1 <syscall>
  802244:	83 c4 18             	add    $0x18,%esp
	return ;
  802247:	90                   	nop
}
  802248:	c9                   	leave  
  802249:	c3                   	ret    

0080224a <rsttst>:
void rsttst()
{
  80224a:	55                   	push   %ebp
  80224b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80224d:	6a 00                	push   $0x0
  80224f:	6a 00                	push   $0x0
  802251:	6a 00                	push   $0x0
  802253:	6a 00                	push   $0x0
  802255:	6a 00                	push   $0x0
  802257:	6a 28                	push   $0x28
  802259:	e8 43 fb ff ff       	call   801da1 <syscall>
  80225e:	83 c4 18             	add    $0x18,%esp
	return ;
  802261:	90                   	nop
}
  802262:	c9                   	leave  
  802263:	c3                   	ret    

00802264 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802264:	55                   	push   %ebp
  802265:	89 e5                	mov    %esp,%ebp
  802267:	83 ec 04             	sub    $0x4,%esp
  80226a:	8b 45 14             	mov    0x14(%ebp),%eax
  80226d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802270:	8b 55 18             	mov    0x18(%ebp),%edx
  802273:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802277:	52                   	push   %edx
  802278:	50                   	push   %eax
  802279:	ff 75 10             	pushl  0x10(%ebp)
  80227c:	ff 75 0c             	pushl  0xc(%ebp)
  80227f:	ff 75 08             	pushl  0x8(%ebp)
  802282:	6a 27                	push   $0x27
  802284:	e8 18 fb ff ff       	call   801da1 <syscall>
  802289:	83 c4 18             	add    $0x18,%esp
	return ;
  80228c:	90                   	nop
}
  80228d:	c9                   	leave  
  80228e:	c3                   	ret    

0080228f <chktst>:
void chktst(uint32 n)
{
  80228f:	55                   	push   %ebp
  802290:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802292:	6a 00                	push   $0x0
  802294:	6a 00                	push   $0x0
  802296:	6a 00                	push   $0x0
  802298:	6a 00                	push   $0x0
  80229a:	ff 75 08             	pushl  0x8(%ebp)
  80229d:	6a 29                	push   $0x29
  80229f:	e8 fd fa ff ff       	call   801da1 <syscall>
  8022a4:	83 c4 18             	add    $0x18,%esp
	return ;
  8022a7:	90                   	nop
}
  8022a8:	c9                   	leave  
  8022a9:	c3                   	ret    

008022aa <inctst>:

void inctst()
{
  8022aa:	55                   	push   %ebp
  8022ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8022ad:	6a 00                	push   $0x0
  8022af:	6a 00                	push   $0x0
  8022b1:	6a 00                	push   $0x0
  8022b3:	6a 00                	push   $0x0
  8022b5:	6a 00                	push   $0x0
  8022b7:	6a 2a                	push   $0x2a
  8022b9:	e8 e3 fa ff ff       	call   801da1 <syscall>
  8022be:	83 c4 18             	add    $0x18,%esp
	return ;
  8022c1:	90                   	nop
}
  8022c2:	c9                   	leave  
  8022c3:	c3                   	ret    

008022c4 <gettst>:
uint32 gettst()
{
  8022c4:	55                   	push   %ebp
  8022c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8022c7:	6a 00                	push   $0x0
  8022c9:	6a 00                	push   $0x0
  8022cb:	6a 00                	push   $0x0
  8022cd:	6a 00                	push   $0x0
  8022cf:	6a 00                	push   $0x0
  8022d1:	6a 2b                	push   $0x2b
  8022d3:	e8 c9 fa ff ff       	call   801da1 <syscall>
  8022d8:	83 c4 18             	add    $0x18,%esp
}
  8022db:	c9                   	leave  
  8022dc:	c3                   	ret    

008022dd <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8022dd:	55                   	push   %ebp
  8022de:	89 e5                	mov    %esp,%ebp
  8022e0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022e3:	6a 00                	push   $0x0
  8022e5:	6a 00                	push   $0x0
  8022e7:	6a 00                	push   $0x0
  8022e9:	6a 00                	push   $0x0
  8022eb:	6a 00                	push   $0x0
  8022ed:	6a 2c                	push   $0x2c
  8022ef:	e8 ad fa ff ff       	call   801da1 <syscall>
  8022f4:	83 c4 18             	add    $0x18,%esp
  8022f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8022fa:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8022fe:	75 07                	jne    802307 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802300:	b8 01 00 00 00       	mov    $0x1,%eax
  802305:	eb 05                	jmp    80230c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802307:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80230c:	c9                   	leave  
  80230d:	c3                   	ret    

0080230e <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80230e:	55                   	push   %ebp
  80230f:	89 e5                	mov    %esp,%ebp
  802311:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802314:	6a 00                	push   $0x0
  802316:	6a 00                	push   $0x0
  802318:	6a 00                	push   $0x0
  80231a:	6a 00                	push   $0x0
  80231c:	6a 00                	push   $0x0
  80231e:	6a 2c                	push   $0x2c
  802320:	e8 7c fa ff ff       	call   801da1 <syscall>
  802325:	83 c4 18             	add    $0x18,%esp
  802328:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80232b:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80232f:	75 07                	jne    802338 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802331:	b8 01 00 00 00       	mov    $0x1,%eax
  802336:	eb 05                	jmp    80233d <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802338:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80233d:	c9                   	leave  
  80233e:	c3                   	ret    

0080233f <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80233f:	55                   	push   %ebp
  802340:	89 e5                	mov    %esp,%ebp
  802342:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802345:	6a 00                	push   $0x0
  802347:	6a 00                	push   $0x0
  802349:	6a 00                	push   $0x0
  80234b:	6a 00                	push   $0x0
  80234d:	6a 00                	push   $0x0
  80234f:	6a 2c                	push   $0x2c
  802351:	e8 4b fa ff ff       	call   801da1 <syscall>
  802356:	83 c4 18             	add    $0x18,%esp
  802359:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80235c:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802360:	75 07                	jne    802369 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802362:	b8 01 00 00 00       	mov    $0x1,%eax
  802367:	eb 05                	jmp    80236e <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802369:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80236e:	c9                   	leave  
  80236f:	c3                   	ret    

00802370 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802370:	55                   	push   %ebp
  802371:	89 e5                	mov    %esp,%ebp
  802373:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802376:	6a 00                	push   $0x0
  802378:	6a 00                	push   $0x0
  80237a:	6a 00                	push   $0x0
  80237c:	6a 00                	push   $0x0
  80237e:	6a 00                	push   $0x0
  802380:	6a 2c                	push   $0x2c
  802382:	e8 1a fa ff ff       	call   801da1 <syscall>
  802387:	83 c4 18             	add    $0x18,%esp
  80238a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80238d:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802391:	75 07                	jne    80239a <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802393:	b8 01 00 00 00       	mov    $0x1,%eax
  802398:	eb 05                	jmp    80239f <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80239a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80239f:	c9                   	leave  
  8023a0:	c3                   	ret    

008023a1 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8023a1:	55                   	push   %ebp
  8023a2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8023a4:	6a 00                	push   $0x0
  8023a6:	6a 00                	push   $0x0
  8023a8:	6a 00                	push   $0x0
  8023aa:	6a 00                	push   $0x0
  8023ac:	ff 75 08             	pushl  0x8(%ebp)
  8023af:	6a 2d                	push   $0x2d
  8023b1:	e8 eb f9 ff ff       	call   801da1 <syscall>
  8023b6:	83 c4 18             	add    $0x18,%esp
	return ;
  8023b9:	90                   	nop
}
  8023ba:	c9                   	leave  
  8023bb:	c3                   	ret    

008023bc <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8023bc:	55                   	push   %ebp
  8023bd:	89 e5                	mov    %esp,%ebp
  8023bf:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8023c0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8023c3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8023c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8023cc:	6a 00                	push   $0x0
  8023ce:	53                   	push   %ebx
  8023cf:	51                   	push   %ecx
  8023d0:	52                   	push   %edx
  8023d1:	50                   	push   %eax
  8023d2:	6a 2e                	push   $0x2e
  8023d4:	e8 c8 f9 ff ff       	call   801da1 <syscall>
  8023d9:	83 c4 18             	add    $0x18,%esp
}
  8023dc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8023df:	c9                   	leave  
  8023e0:	c3                   	ret    

008023e1 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8023e1:	55                   	push   %ebp
  8023e2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8023e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ea:	6a 00                	push   $0x0
  8023ec:	6a 00                	push   $0x0
  8023ee:	6a 00                	push   $0x0
  8023f0:	52                   	push   %edx
  8023f1:	50                   	push   %eax
  8023f2:	6a 2f                	push   $0x2f
  8023f4:	e8 a8 f9 ff ff       	call   801da1 <syscall>
  8023f9:	83 c4 18             	add    $0x18,%esp
}
  8023fc:	c9                   	leave  
  8023fd:	c3                   	ret    
  8023fe:	66 90                	xchg   %ax,%ax

00802400 <__udivdi3>:
  802400:	55                   	push   %ebp
  802401:	57                   	push   %edi
  802402:	56                   	push   %esi
  802403:	53                   	push   %ebx
  802404:	83 ec 1c             	sub    $0x1c,%esp
  802407:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80240b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80240f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802413:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802417:	89 ca                	mov    %ecx,%edx
  802419:	89 f8                	mov    %edi,%eax
  80241b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80241f:	85 f6                	test   %esi,%esi
  802421:	75 2d                	jne    802450 <__udivdi3+0x50>
  802423:	39 cf                	cmp    %ecx,%edi
  802425:	77 65                	ja     80248c <__udivdi3+0x8c>
  802427:	89 fd                	mov    %edi,%ebp
  802429:	85 ff                	test   %edi,%edi
  80242b:	75 0b                	jne    802438 <__udivdi3+0x38>
  80242d:	b8 01 00 00 00       	mov    $0x1,%eax
  802432:	31 d2                	xor    %edx,%edx
  802434:	f7 f7                	div    %edi
  802436:	89 c5                	mov    %eax,%ebp
  802438:	31 d2                	xor    %edx,%edx
  80243a:	89 c8                	mov    %ecx,%eax
  80243c:	f7 f5                	div    %ebp
  80243e:	89 c1                	mov    %eax,%ecx
  802440:	89 d8                	mov    %ebx,%eax
  802442:	f7 f5                	div    %ebp
  802444:	89 cf                	mov    %ecx,%edi
  802446:	89 fa                	mov    %edi,%edx
  802448:	83 c4 1c             	add    $0x1c,%esp
  80244b:	5b                   	pop    %ebx
  80244c:	5e                   	pop    %esi
  80244d:	5f                   	pop    %edi
  80244e:	5d                   	pop    %ebp
  80244f:	c3                   	ret    
  802450:	39 ce                	cmp    %ecx,%esi
  802452:	77 28                	ja     80247c <__udivdi3+0x7c>
  802454:	0f bd fe             	bsr    %esi,%edi
  802457:	83 f7 1f             	xor    $0x1f,%edi
  80245a:	75 40                	jne    80249c <__udivdi3+0x9c>
  80245c:	39 ce                	cmp    %ecx,%esi
  80245e:	72 0a                	jb     80246a <__udivdi3+0x6a>
  802460:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802464:	0f 87 9e 00 00 00    	ja     802508 <__udivdi3+0x108>
  80246a:	b8 01 00 00 00       	mov    $0x1,%eax
  80246f:	89 fa                	mov    %edi,%edx
  802471:	83 c4 1c             	add    $0x1c,%esp
  802474:	5b                   	pop    %ebx
  802475:	5e                   	pop    %esi
  802476:	5f                   	pop    %edi
  802477:	5d                   	pop    %ebp
  802478:	c3                   	ret    
  802479:	8d 76 00             	lea    0x0(%esi),%esi
  80247c:	31 ff                	xor    %edi,%edi
  80247e:	31 c0                	xor    %eax,%eax
  802480:	89 fa                	mov    %edi,%edx
  802482:	83 c4 1c             	add    $0x1c,%esp
  802485:	5b                   	pop    %ebx
  802486:	5e                   	pop    %esi
  802487:	5f                   	pop    %edi
  802488:	5d                   	pop    %ebp
  802489:	c3                   	ret    
  80248a:	66 90                	xchg   %ax,%ax
  80248c:	89 d8                	mov    %ebx,%eax
  80248e:	f7 f7                	div    %edi
  802490:	31 ff                	xor    %edi,%edi
  802492:	89 fa                	mov    %edi,%edx
  802494:	83 c4 1c             	add    $0x1c,%esp
  802497:	5b                   	pop    %ebx
  802498:	5e                   	pop    %esi
  802499:	5f                   	pop    %edi
  80249a:	5d                   	pop    %ebp
  80249b:	c3                   	ret    
  80249c:	bd 20 00 00 00       	mov    $0x20,%ebp
  8024a1:	89 eb                	mov    %ebp,%ebx
  8024a3:	29 fb                	sub    %edi,%ebx
  8024a5:	89 f9                	mov    %edi,%ecx
  8024a7:	d3 e6                	shl    %cl,%esi
  8024a9:	89 c5                	mov    %eax,%ebp
  8024ab:	88 d9                	mov    %bl,%cl
  8024ad:	d3 ed                	shr    %cl,%ebp
  8024af:	89 e9                	mov    %ebp,%ecx
  8024b1:	09 f1                	or     %esi,%ecx
  8024b3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8024b7:	89 f9                	mov    %edi,%ecx
  8024b9:	d3 e0                	shl    %cl,%eax
  8024bb:	89 c5                	mov    %eax,%ebp
  8024bd:	89 d6                	mov    %edx,%esi
  8024bf:	88 d9                	mov    %bl,%cl
  8024c1:	d3 ee                	shr    %cl,%esi
  8024c3:	89 f9                	mov    %edi,%ecx
  8024c5:	d3 e2                	shl    %cl,%edx
  8024c7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024cb:	88 d9                	mov    %bl,%cl
  8024cd:	d3 e8                	shr    %cl,%eax
  8024cf:	09 c2                	or     %eax,%edx
  8024d1:	89 d0                	mov    %edx,%eax
  8024d3:	89 f2                	mov    %esi,%edx
  8024d5:	f7 74 24 0c          	divl   0xc(%esp)
  8024d9:	89 d6                	mov    %edx,%esi
  8024db:	89 c3                	mov    %eax,%ebx
  8024dd:	f7 e5                	mul    %ebp
  8024df:	39 d6                	cmp    %edx,%esi
  8024e1:	72 19                	jb     8024fc <__udivdi3+0xfc>
  8024e3:	74 0b                	je     8024f0 <__udivdi3+0xf0>
  8024e5:	89 d8                	mov    %ebx,%eax
  8024e7:	31 ff                	xor    %edi,%edi
  8024e9:	e9 58 ff ff ff       	jmp    802446 <__udivdi3+0x46>
  8024ee:	66 90                	xchg   %ax,%ax
  8024f0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8024f4:	89 f9                	mov    %edi,%ecx
  8024f6:	d3 e2                	shl    %cl,%edx
  8024f8:	39 c2                	cmp    %eax,%edx
  8024fa:	73 e9                	jae    8024e5 <__udivdi3+0xe5>
  8024fc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8024ff:	31 ff                	xor    %edi,%edi
  802501:	e9 40 ff ff ff       	jmp    802446 <__udivdi3+0x46>
  802506:	66 90                	xchg   %ax,%ax
  802508:	31 c0                	xor    %eax,%eax
  80250a:	e9 37 ff ff ff       	jmp    802446 <__udivdi3+0x46>
  80250f:	90                   	nop

00802510 <__umoddi3>:
  802510:	55                   	push   %ebp
  802511:	57                   	push   %edi
  802512:	56                   	push   %esi
  802513:	53                   	push   %ebx
  802514:	83 ec 1c             	sub    $0x1c,%esp
  802517:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80251b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80251f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802523:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802527:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80252b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80252f:	89 f3                	mov    %esi,%ebx
  802531:	89 fa                	mov    %edi,%edx
  802533:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802537:	89 34 24             	mov    %esi,(%esp)
  80253a:	85 c0                	test   %eax,%eax
  80253c:	75 1a                	jne    802558 <__umoddi3+0x48>
  80253e:	39 f7                	cmp    %esi,%edi
  802540:	0f 86 a2 00 00 00    	jbe    8025e8 <__umoddi3+0xd8>
  802546:	89 c8                	mov    %ecx,%eax
  802548:	89 f2                	mov    %esi,%edx
  80254a:	f7 f7                	div    %edi
  80254c:	89 d0                	mov    %edx,%eax
  80254e:	31 d2                	xor    %edx,%edx
  802550:	83 c4 1c             	add    $0x1c,%esp
  802553:	5b                   	pop    %ebx
  802554:	5e                   	pop    %esi
  802555:	5f                   	pop    %edi
  802556:	5d                   	pop    %ebp
  802557:	c3                   	ret    
  802558:	39 f0                	cmp    %esi,%eax
  80255a:	0f 87 ac 00 00 00    	ja     80260c <__umoddi3+0xfc>
  802560:	0f bd e8             	bsr    %eax,%ebp
  802563:	83 f5 1f             	xor    $0x1f,%ebp
  802566:	0f 84 ac 00 00 00    	je     802618 <__umoddi3+0x108>
  80256c:	bf 20 00 00 00       	mov    $0x20,%edi
  802571:	29 ef                	sub    %ebp,%edi
  802573:	89 fe                	mov    %edi,%esi
  802575:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802579:	89 e9                	mov    %ebp,%ecx
  80257b:	d3 e0                	shl    %cl,%eax
  80257d:	89 d7                	mov    %edx,%edi
  80257f:	89 f1                	mov    %esi,%ecx
  802581:	d3 ef                	shr    %cl,%edi
  802583:	09 c7                	or     %eax,%edi
  802585:	89 e9                	mov    %ebp,%ecx
  802587:	d3 e2                	shl    %cl,%edx
  802589:	89 14 24             	mov    %edx,(%esp)
  80258c:	89 d8                	mov    %ebx,%eax
  80258e:	d3 e0                	shl    %cl,%eax
  802590:	89 c2                	mov    %eax,%edx
  802592:	8b 44 24 08          	mov    0x8(%esp),%eax
  802596:	d3 e0                	shl    %cl,%eax
  802598:	89 44 24 04          	mov    %eax,0x4(%esp)
  80259c:	8b 44 24 08          	mov    0x8(%esp),%eax
  8025a0:	89 f1                	mov    %esi,%ecx
  8025a2:	d3 e8                	shr    %cl,%eax
  8025a4:	09 d0                	or     %edx,%eax
  8025a6:	d3 eb                	shr    %cl,%ebx
  8025a8:	89 da                	mov    %ebx,%edx
  8025aa:	f7 f7                	div    %edi
  8025ac:	89 d3                	mov    %edx,%ebx
  8025ae:	f7 24 24             	mull   (%esp)
  8025b1:	89 c6                	mov    %eax,%esi
  8025b3:	89 d1                	mov    %edx,%ecx
  8025b5:	39 d3                	cmp    %edx,%ebx
  8025b7:	0f 82 87 00 00 00    	jb     802644 <__umoddi3+0x134>
  8025bd:	0f 84 91 00 00 00    	je     802654 <__umoddi3+0x144>
  8025c3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8025c7:	29 f2                	sub    %esi,%edx
  8025c9:	19 cb                	sbb    %ecx,%ebx
  8025cb:	89 d8                	mov    %ebx,%eax
  8025cd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8025d1:	d3 e0                	shl    %cl,%eax
  8025d3:	89 e9                	mov    %ebp,%ecx
  8025d5:	d3 ea                	shr    %cl,%edx
  8025d7:	09 d0                	or     %edx,%eax
  8025d9:	89 e9                	mov    %ebp,%ecx
  8025db:	d3 eb                	shr    %cl,%ebx
  8025dd:	89 da                	mov    %ebx,%edx
  8025df:	83 c4 1c             	add    $0x1c,%esp
  8025e2:	5b                   	pop    %ebx
  8025e3:	5e                   	pop    %esi
  8025e4:	5f                   	pop    %edi
  8025e5:	5d                   	pop    %ebp
  8025e6:	c3                   	ret    
  8025e7:	90                   	nop
  8025e8:	89 fd                	mov    %edi,%ebp
  8025ea:	85 ff                	test   %edi,%edi
  8025ec:	75 0b                	jne    8025f9 <__umoddi3+0xe9>
  8025ee:	b8 01 00 00 00       	mov    $0x1,%eax
  8025f3:	31 d2                	xor    %edx,%edx
  8025f5:	f7 f7                	div    %edi
  8025f7:	89 c5                	mov    %eax,%ebp
  8025f9:	89 f0                	mov    %esi,%eax
  8025fb:	31 d2                	xor    %edx,%edx
  8025fd:	f7 f5                	div    %ebp
  8025ff:	89 c8                	mov    %ecx,%eax
  802601:	f7 f5                	div    %ebp
  802603:	89 d0                	mov    %edx,%eax
  802605:	e9 44 ff ff ff       	jmp    80254e <__umoddi3+0x3e>
  80260a:	66 90                	xchg   %ax,%ax
  80260c:	89 c8                	mov    %ecx,%eax
  80260e:	89 f2                	mov    %esi,%edx
  802610:	83 c4 1c             	add    $0x1c,%esp
  802613:	5b                   	pop    %ebx
  802614:	5e                   	pop    %esi
  802615:	5f                   	pop    %edi
  802616:	5d                   	pop    %ebp
  802617:	c3                   	ret    
  802618:	3b 04 24             	cmp    (%esp),%eax
  80261b:	72 06                	jb     802623 <__umoddi3+0x113>
  80261d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802621:	77 0f                	ja     802632 <__umoddi3+0x122>
  802623:	89 f2                	mov    %esi,%edx
  802625:	29 f9                	sub    %edi,%ecx
  802627:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80262b:	89 14 24             	mov    %edx,(%esp)
  80262e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802632:	8b 44 24 04          	mov    0x4(%esp),%eax
  802636:	8b 14 24             	mov    (%esp),%edx
  802639:	83 c4 1c             	add    $0x1c,%esp
  80263c:	5b                   	pop    %ebx
  80263d:	5e                   	pop    %esi
  80263e:	5f                   	pop    %edi
  80263f:	5d                   	pop    %ebp
  802640:	c3                   	ret    
  802641:	8d 76 00             	lea    0x0(%esi),%esi
  802644:	2b 04 24             	sub    (%esp),%eax
  802647:	19 fa                	sbb    %edi,%edx
  802649:	89 d1                	mov    %edx,%ecx
  80264b:	89 c6                	mov    %eax,%esi
  80264d:	e9 71 ff ff ff       	jmp    8025c3 <__umoddi3+0xb3>
  802652:	66 90                	xchg   %ax,%ax
  802654:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802658:	72 ea                	jb     802644 <__umoddi3+0x134>
  80265a:	89 d9                	mov    %ebx,%ecx
  80265c:	e9 62 ff ff ff       	jmp    8025c3 <__umoddi3+0xb3>
