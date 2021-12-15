
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
  800049:	e8 2e 1d 00 00       	call   801d7c <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 40 1d 00 00       	call   801d95 <sys_calculate_modified_frames>
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
  800067:	68 e0 24 80 00       	push   $0x8024e0
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
  8000a5:	68 00 25 80 00       	push   $0x802500
  8000aa:	e8 30 09 00 00       	call   8009df <cprintf>
  8000af:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000b2:	83 ec 0c             	sub    $0xc,%esp
  8000b5:	68 23 25 80 00       	push   $0x802523
  8000ba:	e8 20 09 00 00       	call   8009df <cprintf>
  8000bf:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000c2:	83 ec 0c             	sub    $0xc,%esp
  8000c5:	68 31 25 80 00       	push   $0x802531
  8000ca:	e8 10 09 00 00       	call   8009df <cprintf>
  8000cf:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\n");
  8000d2:	83 ec 0c             	sub    $0xc,%esp
  8000d5:	68 40 25 80 00       	push   $0x802540
  8000da:	e8 00 09 00 00       	call   8009df <cprintf>
  8000df:	83 c4 10             	add    $0x10,%esp
			do
			{
				cprintf("Select: ") ;
  8000e2:	83 ec 0c             	sub    $0xc,%esp
  8000e5:	68 50 25 80 00       	push   $0x802550
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
  8001b4:	68 5c 25 80 00       	push   $0x80255c
  8001b9:	6a 46                	push   $0x46
  8001bb:	68 7e 25 80 00       	push   $0x80257e
  8001c0:	e8 78 05 00 00       	call   80073d <_panic>
		else
		{ 
				cprintf("\n===============================================\n") ;
  8001c5:	83 ec 0c             	sub    $0xc,%esp
  8001c8:	68 90 25 80 00       	push   $0x802590
  8001cd:	e8 0d 08 00 00       	call   8009df <cprintf>
  8001d2:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001d5:	83 ec 0c             	sub    $0xc,%esp
  8001d8:	68 c4 25 80 00       	push   $0x8025c4
  8001dd:	e8 fd 07 00 00       	call   8009df <cprintf>
  8001e2:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  8001e5:	83 ec 0c             	sub    $0xc,%esp
  8001e8:	68 f8 25 80 00       	push   $0x8025f8
  8001ed:	e8 ed 07 00 00       	call   8009df <cprintf>
  8001f2:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

			cprintf("Freeing the Heap...\n\n") ;
  8001f5:	83 ec 0c             	sub    $0xc,%esp
  8001f8:	68 2a 26 80 00       	push   $0x80262a
  8001fd:	e8 dd 07 00 00       	call   8009df <cprintf>
  800202:	83 c4 10             	add    $0x10,%esp

			free(Elements) ;
  800205:	83 ec 0c             	sub    $0xc,%esp
  800208:	ff 75 e8             	pushl  -0x18(%ebp)
  80020b:	e8 15 19 00 00       	call   801b25 <free>
  800210:	83 c4 10             	add    $0x10,%esp


		///========================================================================
	//sys_disable_interrupt();
			cprintf("Do you want to repeat (y/n): ") ;
  800213:	83 ec 0c             	sub    $0xc,%esp
  800216:	68 40 26 80 00       	push   $0x802640
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
  8004f8:	68 5e 26 80 00       	push   $0x80265e
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
  80051a:	68 60 26 80 00       	push   $0x802660
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
  800548:	68 65 26 80 00       	push   $0x802665
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
  80056c:	e8 0f 19 00 00       	call   801e80 <sys_cputc>
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
  80057d:	e8 ca 18 00 00       	call   801e4c <sys_disable_interrupt>
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
  800590:	e8 eb 18 00 00       	call   801e80 <sys_cputc>
  800595:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800598:	e8 c9 18 00 00       	call   801e66 <sys_enable_interrupt>
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
  8005af:	e8 b0 16 00 00       	call   801c64 <sys_cgetc>
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
  8005c8:	e8 7f 18 00 00       	call   801e4c <sys_disable_interrupt>
	int c=0;
  8005cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005d4:	eb 08                	jmp    8005de <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005d6:	e8 89 16 00 00       	call   801c64 <sys_cgetc>
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
  8005e4:	e8 7d 18 00 00       	call   801e66 <sys_enable_interrupt>
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
  8005fe:	e8 ae 16 00 00       	call   801cb1 <sys_getenvindex>
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
  80067b:	e8 cc 17 00 00       	call   801e4c <sys_disable_interrupt>
	cprintf("**************************************\n");
  800680:	83 ec 0c             	sub    $0xc,%esp
  800683:	68 84 26 80 00       	push   $0x802684
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
  8006ab:	68 ac 26 80 00       	push   $0x8026ac
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
  8006d3:	68 d4 26 80 00       	push   $0x8026d4
  8006d8:	e8 02 03 00 00       	call   8009df <cprintf>
  8006dd:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8006e0:	a1 24 30 80 00       	mov    0x803024,%eax
  8006e5:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8006eb:	83 ec 08             	sub    $0x8,%esp
  8006ee:	50                   	push   %eax
  8006ef:	68 15 27 80 00       	push   $0x802715
  8006f4:	e8 e6 02 00 00       	call   8009df <cprintf>
  8006f9:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8006fc:	83 ec 0c             	sub    $0xc,%esp
  8006ff:	68 84 26 80 00       	push   $0x802684
  800704:	e8 d6 02 00 00       	call   8009df <cprintf>
  800709:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80070c:	e8 55 17 00 00       	call   801e66 <sys_enable_interrupt>

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
  800724:	e8 54 15 00 00       	call   801c7d <sys_env_destroy>
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
  800735:	e8 a9 15 00 00       	call   801ce3 <sys_env_exit>
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
  80075e:	68 2c 27 80 00       	push   $0x80272c
  800763:	e8 77 02 00 00       	call   8009df <cprintf>
  800768:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80076b:	a1 00 30 80 00       	mov    0x803000,%eax
  800770:	ff 75 0c             	pushl  0xc(%ebp)
  800773:	ff 75 08             	pushl  0x8(%ebp)
  800776:	50                   	push   %eax
  800777:	68 31 27 80 00       	push   $0x802731
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
  80079b:	68 4d 27 80 00       	push   $0x80274d
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
  8007c7:	68 50 27 80 00       	push   $0x802750
  8007cc:	6a 26                	push   $0x26
  8007ce:	68 9c 27 80 00       	push   $0x80279c
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
  80088d:	68 a8 27 80 00       	push   $0x8027a8
  800892:	6a 3a                	push   $0x3a
  800894:	68 9c 27 80 00       	push   $0x80279c
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
  8008f7:	68 fc 27 80 00       	push   $0x8027fc
  8008fc:	6a 44                	push   $0x44
  8008fe:	68 9c 27 80 00       	push   $0x80279c
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
  800951:	e8 e5 12 00 00       	call   801c3b <sys_cputs>
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
  8009c8:	e8 6e 12 00 00       	call   801c3b <sys_cputs>
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
  800a12:	e8 35 14 00 00       	call   801e4c <sys_disable_interrupt>
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
  800a32:	e8 2f 14 00 00       	call   801e66 <sys_enable_interrupt>
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
  800a7c:	e8 ef 17 00 00       	call   802270 <__udivdi3>
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
  800acc:	e8 af 18 00 00       	call   802380 <__umoddi3>
  800ad1:	83 c4 10             	add    $0x10,%esp
  800ad4:	05 74 2a 80 00       	add    $0x802a74,%eax
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
  800c27:	8b 04 85 98 2a 80 00 	mov    0x802a98(,%eax,4),%eax
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
  800d08:	8b 34 9d e0 28 80 00 	mov    0x8028e0(,%ebx,4),%esi
  800d0f:	85 f6                	test   %esi,%esi
  800d11:	75 19                	jne    800d2c <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d13:	53                   	push   %ebx
  800d14:	68 85 2a 80 00       	push   $0x802a85
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
  800d2d:	68 8e 2a 80 00       	push   $0x802a8e
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
  800d5a:	be 91 2a 80 00       	mov    $0x802a91,%esi
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
  801073:	68 f0 2b 80 00       	push   $0x802bf0
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
  8010b5:	68 f3 2b 80 00       	push   $0x802bf3
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
  801165:	e8 e2 0c 00 00       	call   801e4c <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  80116a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80116e:	74 13                	je     801183 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801170:	83 ec 08             	sub    $0x8,%esp
  801173:	ff 75 08             	pushl  0x8(%ebp)
  801176:	68 f0 2b 80 00       	push   $0x802bf0
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
  8011b4:	68 f3 2b 80 00       	push   $0x802bf3
  8011b9:	e8 21 f8 ff ff       	call   8009df <cprintf>
  8011be:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8011c1:	e8 a0 0c 00 00       	call   801e66 <sys_enable_interrupt>
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
  801259:	e8 08 0c 00 00       	call   801e66 <sys_enable_interrupt>
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
int changes=0;
int sizeofarray=0;
uint32 addresses[100];
int changed[100];
void* malloc(uint32 size)
{
  80196f:	55                   	push   %ebp
  801970:	89 e5                	mov    %esp,%ebp
  801972:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801975:	8b 45 08             	mov    0x8(%ebp),%eax
  801978:	c1 e8 0c             	shr    $0xc,%eax
  80197b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;
		if(size%PAGE_SIZE!=0)
  80197e:	8b 45 08             	mov    0x8(%ebp),%eax
  801981:	25 ff 0f 00 00       	and    $0xfff,%eax
  801986:	85 c0                	test   %eax,%eax
  801988:	74 03                	je     80198d <malloc+0x1e>
			num++;
  80198a:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  80198d:	a1 04 30 80 00       	mov    0x803004,%eax
  801992:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801997:	75 64                	jne    8019fd <malloc+0x8e>
		{
			sys_allocateMem(USER_HEAP_START,size);
  801999:	83 ec 08             	sub    $0x8,%esp
  80199c:	ff 75 08             	pushl  0x8(%ebp)
  80199f:	68 00 00 00 80       	push   $0x80000000
  8019a4:	e8 3a 04 00 00       	call   801de3 <sys_allocateMem>
  8019a9:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  8019ac:	a1 04 30 80 00       	mov    0x803004,%eax
  8019b1:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  8019b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019b7:	c1 e0 0c             	shl    $0xc,%eax
  8019ba:	89 c2                	mov    %eax,%edx
  8019bc:	a1 04 30 80 00       	mov    0x803004,%eax
  8019c1:	01 d0                	add    %edx,%eax
  8019c3:	a3 04 30 80 00       	mov    %eax,0x803004
			addresses[sizeofarray]=last_addres;
  8019c8:	a1 30 30 80 00       	mov    0x803030,%eax
  8019cd:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8019d3:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  8019da:	a1 30 30 80 00       	mov    0x803030,%eax
  8019df:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  8019e6:	01 00 00 00 
			sizeofarray++;
  8019ea:	a1 30 30 80 00       	mov    0x803030,%eax
  8019ef:	40                   	inc    %eax
  8019f0:	a3 30 30 80 00       	mov    %eax,0x803030
			return (void*)return_addres;
  8019f5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8019f8:	e9 26 01 00 00       	jmp    801b23 <malloc+0x1b4>
		}
		else
		{
			if(changes==0)
  8019fd:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a02:	85 c0                	test   %eax,%eax
  801a04:	75 62                	jne    801a68 <malloc+0xf9>
			{
				sys_allocateMem(last_addres,size);
  801a06:	a1 04 30 80 00       	mov    0x803004,%eax
  801a0b:	83 ec 08             	sub    $0x8,%esp
  801a0e:	ff 75 08             	pushl  0x8(%ebp)
  801a11:	50                   	push   %eax
  801a12:	e8 cc 03 00 00       	call   801de3 <sys_allocateMem>
  801a17:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801a1a:	a1 04 30 80 00       	mov    0x803004,%eax
  801a1f:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801a22:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a25:	c1 e0 0c             	shl    $0xc,%eax
  801a28:	89 c2                	mov    %eax,%edx
  801a2a:	a1 04 30 80 00       	mov    0x803004,%eax
  801a2f:	01 d0                	add    %edx,%eax
  801a31:	a3 04 30 80 00       	mov    %eax,0x803004
				addresses[sizeofarray]=return_addres;
  801a36:	a1 30 30 80 00       	mov    0x803030,%eax
  801a3b:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801a3e:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801a45:	a1 30 30 80 00       	mov    0x803030,%eax
  801a4a:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  801a51:	01 00 00 00 
				sizeofarray++;
  801a55:	a1 30 30 80 00       	mov    0x803030,%eax
  801a5a:	40                   	inc    %eax
  801a5b:	a3 30 30 80 00       	mov    %eax,0x803030
				return (void*)return_addres;
  801a60:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801a63:	e9 bb 00 00 00       	jmp    801b23 <malloc+0x1b4>
			}
			else{
				int count=0;
  801a68:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801a6f:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  801a76:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801a7d:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801a84:	eb 7c                	jmp    801b02 <malloc+0x193>
				{
					uint32 *pg=NULL;
  801a86:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801a8d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801a94:	eb 1a                	jmp    801ab0 <malloc+0x141>
					{
						if(addresses[j]==i)
  801a96:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801a99:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801aa0:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801aa3:	75 08                	jne    801aad <malloc+0x13e>
						{
							index=j;
  801aa5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801aa8:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801aab:	eb 0d                	jmp    801aba <malloc+0x14b>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801aad:	ff 45 dc             	incl   -0x24(%ebp)
  801ab0:	a1 30 30 80 00       	mov    0x803030,%eax
  801ab5:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801ab8:	7c dc                	jl     801a96 <malloc+0x127>
							index=j;
							break;
						}
					}

					if(index==-1)
  801aba:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801abe:	75 05                	jne    801ac5 <malloc+0x156>
					{
						count++;
  801ac0:	ff 45 f0             	incl   -0x10(%ebp)
  801ac3:	eb 36                	jmp    801afb <malloc+0x18c>
					}
					else
					{
						if(changed[index]==0)
  801ac5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801ac8:	8b 04 85 c0 32 80 00 	mov    0x8032c0(,%eax,4),%eax
  801acf:	85 c0                	test   %eax,%eax
  801ad1:	75 05                	jne    801ad8 <malloc+0x169>
						{
							count++;
  801ad3:	ff 45 f0             	incl   -0x10(%ebp)
  801ad6:	eb 23                	jmp    801afb <malloc+0x18c>
						}
						else
						{
							if(count<min&&count>=num)
  801ad8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801adb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801ade:	7d 14                	jge    801af4 <malloc+0x185>
  801ae0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ae3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801ae6:	7c 0c                	jl     801af4 <malloc+0x185>
							{
								min=count;
  801ae8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801aeb:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801aee:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801af1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  801af4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801afb:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801b02:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801b09:	0f 86 77 ff ff ff    	jbe    801a86 <malloc+0x117>

					}

					}

				sys_allocateMem(min_addresss,size);
  801b0f:	83 ec 08             	sub    $0x8,%esp
  801b12:	ff 75 08             	pushl  0x8(%ebp)
  801b15:	ff 75 e4             	pushl  -0x1c(%ebp)
  801b18:	e8 c6 02 00 00       	call   801de3 <sys_allocateMem>
  801b1d:	83 c4 10             	add    $0x10,%esp

				return(void*) min_addresss;
  801b20:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801b23:	c9                   	leave  
  801b24:	c3                   	ret    

00801b25 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801b25:	55                   	push   %ebp
  801b26:	89 e5                	mov    %esp,%ebp
  801b28:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801b2b:	83 ec 04             	sub    $0x4,%esp
  801b2e:	68 04 2c 80 00       	push   $0x802c04
  801b33:	6a 7b                	push   $0x7b
  801b35:	68 27 2c 80 00       	push   $0x802c27
  801b3a:	e8 fe eb ff ff       	call   80073d <_panic>

00801b3f <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801b3f:	55                   	push   %ebp
  801b40:	89 e5                	mov    %esp,%ebp
  801b42:	83 ec 18             	sub    $0x18,%esp
  801b45:	8b 45 10             	mov    0x10(%ebp),%eax
  801b48:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801b4b:	83 ec 04             	sub    $0x4,%esp
  801b4e:	68 34 2c 80 00       	push   $0x802c34
  801b53:	68 88 00 00 00       	push   $0x88
  801b58:	68 27 2c 80 00       	push   $0x802c27
  801b5d:	e8 db eb ff ff       	call   80073d <_panic>

00801b62 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801b62:	55                   	push   %ebp
  801b63:	89 e5                	mov    %esp,%ebp
  801b65:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b68:	83 ec 04             	sub    $0x4,%esp
  801b6b:	68 34 2c 80 00       	push   $0x802c34
  801b70:	68 8e 00 00 00       	push   $0x8e
  801b75:	68 27 2c 80 00       	push   $0x802c27
  801b7a:	e8 be eb ff ff       	call   80073d <_panic>

00801b7f <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801b7f:	55                   	push   %ebp
  801b80:	89 e5                	mov    %esp,%ebp
  801b82:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b85:	83 ec 04             	sub    $0x4,%esp
  801b88:	68 34 2c 80 00       	push   $0x802c34
  801b8d:	68 94 00 00 00       	push   $0x94
  801b92:	68 27 2c 80 00       	push   $0x802c27
  801b97:	e8 a1 eb ff ff       	call   80073d <_panic>

00801b9c <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801b9c:	55                   	push   %ebp
  801b9d:	89 e5                	mov    %esp,%ebp
  801b9f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ba2:	83 ec 04             	sub    $0x4,%esp
  801ba5:	68 34 2c 80 00       	push   $0x802c34
  801baa:	68 99 00 00 00       	push   $0x99
  801baf:	68 27 2c 80 00       	push   $0x802c27
  801bb4:	e8 84 eb ff ff       	call   80073d <_panic>

00801bb9 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801bb9:	55                   	push   %ebp
  801bba:	89 e5                	mov    %esp,%ebp
  801bbc:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bbf:	83 ec 04             	sub    $0x4,%esp
  801bc2:	68 34 2c 80 00       	push   $0x802c34
  801bc7:	68 9f 00 00 00       	push   $0x9f
  801bcc:	68 27 2c 80 00       	push   $0x802c27
  801bd1:	e8 67 eb ff ff       	call   80073d <_panic>

00801bd6 <shrink>:
}
void shrink(uint32 newSize)
{
  801bd6:	55                   	push   %ebp
  801bd7:	89 e5                	mov    %esp,%ebp
  801bd9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bdc:	83 ec 04             	sub    $0x4,%esp
  801bdf:	68 34 2c 80 00       	push   $0x802c34
  801be4:	68 a3 00 00 00       	push   $0xa3
  801be9:	68 27 2c 80 00       	push   $0x802c27
  801bee:	e8 4a eb ff ff       	call   80073d <_panic>

00801bf3 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801bf3:	55                   	push   %ebp
  801bf4:	89 e5                	mov    %esp,%ebp
  801bf6:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bf9:	83 ec 04             	sub    $0x4,%esp
  801bfc:	68 34 2c 80 00       	push   $0x802c34
  801c01:	68 a8 00 00 00       	push   $0xa8
  801c06:	68 27 2c 80 00       	push   $0x802c27
  801c0b:	e8 2d eb ff ff       	call   80073d <_panic>

00801c10 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c10:	55                   	push   %ebp
  801c11:	89 e5                	mov    %esp,%ebp
  801c13:	57                   	push   %edi
  801c14:	56                   	push   %esi
  801c15:	53                   	push   %ebx
  801c16:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c19:	8b 45 08             	mov    0x8(%ebp),%eax
  801c1c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c1f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c22:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c25:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c28:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c2b:	cd 30                	int    $0x30
  801c2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801c30:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c33:	83 c4 10             	add    $0x10,%esp
  801c36:	5b                   	pop    %ebx
  801c37:	5e                   	pop    %esi
  801c38:	5f                   	pop    %edi
  801c39:	5d                   	pop    %ebp
  801c3a:	c3                   	ret    

00801c3b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801c3b:	55                   	push   %ebp
  801c3c:	89 e5                	mov    %esp,%ebp
  801c3e:	83 ec 04             	sub    $0x4,%esp
  801c41:	8b 45 10             	mov    0x10(%ebp),%eax
  801c44:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801c47:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c4b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 00                	push   $0x0
  801c52:	52                   	push   %edx
  801c53:	ff 75 0c             	pushl  0xc(%ebp)
  801c56:	50                   	push   %eax
  801c57:	6a 00                	push   $0x0
  801c59:	e8 b2 ff ff ff       	call   801c10 <syscall>
  801c5e:	83 c4 18             	add    $0x18,%esp
}
  801c61:	90                   	nop
  801c62:	c9                   	leave  
  801c63:	c3                   	ret    

00801c64 <sys_cgetc>:

int
sys_cgetc(void)
{
  801c64:	55                   	push   %ebp
  801c65:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c67:	6a 00                	push   $0x0
  801c69:	6a 00                	push   $0x0
  801c6b:	6a 00                	push   $0x0
  801c6d:	6a 00                	push   $0x0
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 01                	push   $0x1
  801c73:	e8 98 ff ff ff       	call   801c10 <syscall>
  801c78:	83 c4 18             	add    $0x18,%esp
}
  801c7b:	c9                   	leave  
  801c7c:	c3                   	ret    

00801c7d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801c7d:	55                   	push   %ebp
  801c7e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801c80:	8b 45 08             	mov    0x8(%ebp),%eax
  801c83:	6a 00                	push   $0x0
  801c85:	6a 00                	push   $0x0
  801c87:	6a 00                	push   $0x0
  801c89:	6a 00                	push   $0x0
  801c8b:	50                   	push   %eax
  801c8c:	6a 05                	push   $0x5
  801c8e:	e8 7d ff ff ff       	call   801c10 <syscall>
  801c93:	83 c4 18             	add    $0x18,%esp
}
  801c96:	c9                   	leave  
  801c97:	c3                   	ret    

00801c98 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801c98:	55                   	push   %ebp
  801c99:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801c9b:	6a 00                	push   $0x0
  801c9d:	6a 00                	push   $0x0
  801c9f:	6a 00                	push   $0x0
  801ca1:	6a 00                	push   $0x0
  801ca3:	6a 00                	push   $0x0
  801ca5:	6a 02                	push   $0x2
  801ca7:	e8 64 ff ff ff       	call   801c10 <syscall>
  801cac:	83 c4 18             	add    $0x18,%esp
}
  801caf:	c9                   	leave  
  801cb0:	c3                   	ret    

00801cb1 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801cb1:	55                   	push   %ebp
  801cb2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801cb4:	6a 00                	push   $0x0
  801cb6:	6a 00                	push   $0x0
  801cb8:	6a 00                	push   $0x0
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 03                	push   $0x3
  801cc0:	e8 4b ff ff ff       	call   801c10 <syscall>
  801cc5:	83 c4 18             	add    $0x18,%esp
}
  801cc8:	c9                   	leave  
  801cc9:	c3                   	ret    

00801cca <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801cca:	55                   	push   %ebp
  801ccb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801ccd:	6a 00                	push   $0x0
  801ccf:	6a 00                	push   $0x0
  801cd1:	6a 00                	push   $0x0
  801cd3:	6a 00                	push   $0x0
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 04                	push   $0x4
  801cd9:	e8 32 ff ff ff       	call   801c10 <syscall>
  801cde:	83 c4 18             	add    $0x18,%esp
}
  801ce1:	c9                   	leave  
  801ce2:	c3                   	ret    

00801ce3 <sys_env_exit>:


void sys_env_exit(void)
{
  801ce3:	55                   	push   %ebp
  801ce4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801ce6:	6a 00                	push   $0x0
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 00                	push   $0x0
  801cec:	6a 00                	push   $0x0
  801cee:	6a 00                	push   $0x0
  801cf0:	6a 06                	push   $0x6
  801cf2:	e8 19 ff ff ff       	call   801c10 <syscall>
  801cf7:	83 c4 18             	add    $0x18,%esp
}
  801cfa:	90                   	nop
  801cfb:	c9                   	leave  
  801cfc:	c3                   	ret    

00801cfd <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801cfd:	55                   	push   %ebp
  801cfe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d00:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d03:	8b 45 08             	mov    0x8(%ebp),%eax
  801d06:	6a 00                	push   $0x0
  801d08:	6a 00                	push   $0x0
  801d0a:	6a 00                	push   $0x0
  801d0c:	52                   	push   %edx
  801d0d:	50                   	push   %eax
  801d0e:	6a 07                	push   $0x7
  801d10:	e8 fb fe ff ff       	call   801c10 <syscall>
  801d15:	83 c4 18             	add    $0x18,%esp
}
  801d18:	c9                   	leave  
  801d19:	c3                   	ret    

00801d1a <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d1a:	55                   	push   %ebp
  801d1b:	89 e5                	mov    %esp,%ebp
  801d1d:	56                   	push   %esi
  801d1e:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d1f:	8b 75 18             	mov    0x18(%ebp),%esi
  801d22:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d25:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d28:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2e:	56                   	push   %esi
  801d2f:	53                   	push   %ebx
  801d30:	51                   	push   %ecx
  801d31:	52                   	push   %edx
  801d32:	50                   	push   %eax
  801d33:	6a 08                	push   $0x8
  801d35:	e8 d6 fe ff ff       	call   801c10 <syscall>
  801d3a:	83 c4 18             	add    $0x18,%esp
}
  801d3d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d40:	5b                   	pop    %ebx
  801d41:	5e                   	pop    %esi
  801d42:	5d                   	pop    %ebp
  801d43:	c3                   	ret    

00801d44 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801d44:	55                   	push   %ebp
  801d45:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801d47:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d4a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4d:	6a 00                	push   $0x0
  801d4f:	6a 00                	push   $0x0
  801d51:	6a 00                	push   $0x0
  801d53:	52                   	push   %edx
  801d54:	50                   	push   %eax
  801d55:	6a 09                	push   $0x9
  801d57:	e8 b4 fe ff ff       	call   801c10 <syscall>
  801d5c:	83 c4 18             	add    $0x18,%esp
}
  801d5f:	c9                   	leave  
  801d60:	c3                   	ret    

00801d61 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d61:	55                   	push   %ebp
  801d62:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d64:	6a 00                	push   $0x0
  801d66:	6a 00                	push   $0x0
  801d68:	6a 00                	push   $0x0
  801d6a:	ff 75 0c             	pushl  0xc(%ebp)
  801d6d:	ff 75 08             	pushl  0x8(%ebp)
  801d70:	6a 0a                	push   $0xa
  801d72:	e8 99 fe ff ff       	call   801c10 <syscall>
  801d77:	83 c4 18             	add    $0x18,%esp
}
  801d7a:	c9                   	leave  
  801d7b:	c3                   	ret    

00801d7c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d7c:	55                   	push   %ebp
  801d7d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	6a 00                	push   $0x0
  801d87:	6a 00                	push   $0x0
  801d89:	6a 0b                	push   $0xb
  801d8b:	e8 80 fe ff ff       	call   801c10 <syscall>
  801d90:	83 c4 18             	add    $0x18,%esp
}
  801d93:	c9                   	leave  
  801d94:	c3                   	ret    

00801d95 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801d95:	55                   	push   %ebp
  801d96:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	6a 0c                	push   $0xc
  801da4:	e8 67 fe ff ff       	call   801c10 <syscall>
  801da9:	83 c4 18             	add    $0x18,%esp
}
  801dac:	c9                   	leave  
  801dad:	c3                   	ret    

00801dae <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801dae:	55                   	push   %ebp
  801daf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801db1:	6a 00                	push   $0x0
  801db3:	6a 00                	push   $0x0
  801db5:	6a 00                	push   $0x0
  801db7:	6a 00                	push   $0x0
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 0d                	push   $0xd
  801dbd:	e8 4e fe ff ff       	call   801c10 <syscall>
  801dc2:	83 c4 18             	add    $0x18,%esp
}
  801dc5:	c9                   	leave  
  801dc6:	c3                   	ret    

00801dc7 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801dc7:	55                   	push   %ebp
  801dc8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 00                	push   $0x0
  801dce:	6a 00                	push   $0x0
  801dd0:	ff 75 0c             	pushl  0xc(%ebp)
  801dd3:	ff 75 08             	pushl  0x8(%ebp)
  801dd6:	6a 11                	push   $0x11
  801dd8:	e8 33 fe ff ff       	call   801c10 <syscall>
  801ddd:	83 c4 18             	add    $0x18,%esp
	return;
  801de0:	90                   	nop
}
  801de1:	c9                   	leave  
  801de2:	c3                   	ret    

00801de3 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801de3:	55                   	push   %ebp
  801de4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801de6:	6a 00                	push   $0x0
  801de8:	6a 00                	push   $0x0
  801dea:	6a 00                	push   $0x0
  801dec:	ff 75 0c             	pushl  0xc(%ebp)
  801def:	ff 75 08             	pushl  0x8(%ebp)
  801df2:	6a 12                	push   $0x12
  801df4:	e8 17 fe ff ff       	call   801c10 <syscall>
  801df9:	83 c4 18             	add    $0x18,%esp
	return ;
  801dfc:	90                   	nop
}
  801dfd:	c9                   	leave  
  801dfe:	c3                   	ret    

00801dff <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801dff:	55                   	push   %ebp
  801e00:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e02:	6a 00                	push   $0x0
  801e04:	6a 00                	push   $0x0
  801e06:	6a 00                	push   $0x0
  801e08:	6a 00                	push   $0x0
  801e0a:	6a 00                	push   $0x0
  801e0c:	6a 0e                	push   $0xe
  801e0e:	e8 fd fd ff ff       	call   801c10 <syscall>
  801e13:	83 c4 18             	add    $0x18,%esp
}
  801e16:	c9                   	leave  
  801e17:	c3                   	ret    

00801e18 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e18:	55                   	push   %ebp
  801e19:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e1b:	6a 00                	push   $0x0
  801e1d:	6a 00                	push   $0x0
  801e1f:	6a 00                	push   $0x0
  801e21:	6a 00                	push   $0x0
  801e23:	ff 75 08             	pushl  0x8(%ebp)
  801e26:	6a 0f                	push   $0xf
  801e28:	e8 e3 fd ff ff       	call   801c10 <syscall>
  801e2d:	83 c4 18             	add    $0x18,%esp
}
  801e30:	c9                   	leave  
  801e31:	c3                   	ret    

00801e32 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e32:	55                   	push   %ebp
  801e33:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e35:	6a 00                	push   $0x0
  801e37:	6a 00                	push   $0x0
  801e39:	6a 00                	push   $0x0
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 10                	push   $0x10
  801e41:	e8 ca fd ff ff       	call   801c10 <syscall>
  801e46:	83 c4 18             	add    $0x18,%esp
}
  801e49:	90                   	nop
  801e4a:	c9                   	leave  
  801e4b:	c3                   	ret    

00801e4c <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801e4c:	55                   	push   %ebp
  801e4d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 00                	push   $0x0
  801e53:	6a 00                	push   $0x0
  801e55:	6a 00                	push   $0x0
  801e57:	6a 00                	push   $0x0
  801e59:	6a 14                	push   $0x14
  801e5b:	e8 b0 fd ff ff       	call   801c10 <syscall>
  801e60:	83 c4 18             	add    $0x18,%esp
}
  801e63:	90                   	nop
  801e64:	c9                   	leave  
  801e65:	c3                   	ret    

00801e66 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e66:	55                   	push   %ebp
  801e67:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e69:	6a 00                	push   $0x0
  801e6b:	6a 00                	push   $0x0
  801e6d:	6a 00                	push   $0x0
  801e6f:	6a 00                	push   $0x0
  801e71:	6a 00                	push   $0x0
  801e73:	6a 15                	push   $0x15
  801e75:	e8 96 fd ff ff       	call   801c10 <syscall>
  801e7a:	83 c4 18             	add    $0x18,%esp
}
  801e7d:	90                   	nop
  801e7e:	c9                   	leave  
  801e7f:	c3                   	ret    

00801e80 <sys_cputc>:


void
sys_cputc(const char c)
{
  801e80:	55                   	push   %ebp
  801e81:	89 e5                	mov    %esp,%ebp
  801e83:	83 ec 04             	sub    $0x4,%esp
  801e86:	8b 45 08             	mov    0x8(%ebp),%eax
  801e89:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e8c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e90:	6a 00                	push   $0x0
  801e92:	6a 00                	push   $0x0
  801e94:	6a 00                	push   $0x0
  801e96:	6a 00                	push   $0x0
  801e98:	50                   	push   %eax
  801e99:	6a 16                	push   $0x16
  801e9b:	e8 70 fd ff ff       	call   801c10 <syscall>
  801ea0:	83 c4 18             	add    $0x18,%esp
}
  801ea3:	90                   	nop
  801ea4:	c9                   	leave  
  801ea5:	c3                   	ret    

00801ea6 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801ea6:	55                   	push   %ebp
  801ea7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ea9:	6a 00                	push   $0x0
  801eab:	6a 00                	push   $0x0
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 00                	push   $0x0
  801eb1:	6a 00                	push   $0x0
  801eb3:	6a 17                	push   $0x17
  801eb5:	e8 56 fd ff ff       	call   801c10 <syscall>
  801eba:	83 c4 18             	add    $0x18,%esp
}
  801ebd:	90                   	nop
  801ebe:	c9                   	leave  
  801ebf:	c3                   	ret    

00801ec0 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801ec0:	55                   	push   %ebp
  801ec1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ec3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec6:	6a 00                	push   $0x0
  801ec8:	6a 00                	push   $0x0
  801eca:	6a 00                	push   $0x0
  801ecc:	ff 75 0c             	pushl  0xc(%ebp)
  801ecf:	50                   	push   %eax
  801ed0:	6a 18                	push   $0x18
  801ed2:	e8 39 fd ff ff       	call   801c10 <syscall>
  801ed7:	83 c4 18             	add    $0x18,%esp
}
  801eda:	c9                   	leave  
  801edb:	c3                   	ret    

00801edc <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801edc:	55                   	push   %ebp
  801edd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801edf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee5:	6a 00                	push   $0x0
  801ee7:	6a 00                	push   $0x0
  801ee9:	6a 00                	push   $0x0
  801eeb:	52                   	push   %edx
  801eec:	50                   	push   %eax
  801eed:	6a 1b                	push   $0x1b
  801eef:	e8 1c fd ff ff       	call   801c10 <syscall>
  801ef4:	83 c4 18             	add    $0x18,%esp
}
  801ef7:	c9                   	leave  
  801ef8:	c3                   	ret    

00801ef9 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ef9:	55                   	push   %ebp
  801efa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801efc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eff:	8b 45 08             	mov    0x8(%ebp),%eax
  801f02:	6a 00                	push   $0x0
  801f04:	6a 00                	push   $0x0
  801f06:	6a 00                	push   $0x0
  801f08:	52                   	push   %edx
  801f09:	50                   	push   %eax
  801f0a:	6a 19                	push   $0x19
  801f0c:	e8 ff fc ff ff       	call   801c10 <syscall>
  801f11:	83 c4 18             	add    $0x18,%esp
}
  801f14:	90                   	nop
  801f15:	c9                   	leave  
  801f16:	c3                   	ret    

00801f17 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f17:	55                   	push   %ebp
  801f18:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f1a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f20:	6a 00                	push   $0x0
  801f22:	6a 00                	push   $0x0
  801f24:	6a 00                	push   $0x0
  801f26:	52                   	push   %edx
  801f27:	50                   	push   %eax
  801f28:	6a 1a                	push   $0x1a
  801f2a:	e8 e1 fc ff ff       	call   801c10 <syscall>
  801f2f:	83 c4 18             	add    $0x18,%esp
}
  801f32:	90                   	nop
  801f33:	c9                   	leave  
  801f34:	c3                   	ret    

00801f35 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801f35:	55                   	push   %ebp
  801f36:	89 e5                	mov    %esp,%ebp
  801f38:	83 ec 04             	sub    $0x4,%esp
  801f3b:	8b 45 10             	mov    0x10(%ebp),%eax
  801f3e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801f41:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f44:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f48:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4b:	6a 00                	push   $0x0
  801f4d:	51                   	push   %ecx
  801f4e:	52                   	push   %edx
  801f4f:	ff 75 0c             	pushl  0xc(%ebp)
  801f52:	50                   	push   %eax
  801f53:	6a 1c                	push   $0x1c
  801f55:	e8 b6 fc ff ff       	call   801c10 <syscall>
  801f5a:	83 c4 18             	add    $0x18,%esp
}
  801f5d:	c9                   	leave  
  801f5e:	c3                   	ret    

00801f5f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801f5f:	55                   	push   %ebp
  801f60:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801f62:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f65:	8b 45 08             	mov    0x8(%ebp),%eax
  801f68:	6a 00                	push   $0x0
  801f6a:	6a 00                	push   $0x0
  801f6c:	6a 00                	push   $0x0
  801f6e:	52                   	push   %edx
  801f6f:	50                   	push   %eax
  801f70:	6a 1d                	push   $0x1d
  801f72:	e8 99 fc ff ff       	call   801c10 <syscall>
  801f77:	83 c4 18             	add    $0x18,%esp
}
  801f7a:	c9                   	leave  
  801f7b:	c3                   	ret    

00801f7c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801f7c:	55                   	push   %ebp
  801f7d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801f7f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f82:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f85:	8b 45 08             	mov    0x8(%ebp),%eax
  801f88:	6a 00                	push   $0x0
  801f8a:	6a 00                	push   $0x0
  801f8c:	51                   	push   %ecx
  801f8d:	52                   	push   %edx
  801f8e:	50                   	push   %eax
  801f8f:	6a 1e                	push   $0x1e
  801f91:	e8 7a fc ff ff       	call   801c10 <syscall>
  801f96:	83 c4 18             	add    $0x18,%esp
}
  801f99:	c9                   	leave  
  801f9a:	c3                   	ret    

00801f9b <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801f9b:	55                   	push   %ebp
  801f9c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801f9e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fa1:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa4:	6a 00                	push   $0x0
  801fa6:	6a 00                	push   $0x0
  801fa8:	6a 00                	push   $0x0
  801faa:	52                   	push   %edx
  801fab:	50                   	push   %eax
  801fac:	6a 1f                	push   $0x1f
  801fae:	e8 5d fc ff ff       	call   801c10 <syscall>
  801fb3:	83 c4 18             	add    $0x18,%esp
}
  801fb6:	c9                   	leave  
  801fb7:	c3                   	ret    

00801fb8 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801fb8:	55                   	push   %ebp
  801fb9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	6a 00                	push   $0x0
  801fc3:	6a 00                	push   $0x0
  801fc5:	6a 20                	push   $0x20
  801fc7:	e8 44 fc ff ff       	call   801c10 <syscall>
  801fcc:	83 c4 18             	add    $0x18,%esp
}
  801fcf:	c9                   	leave  
  801fd0:	c3                   	ret    

00801fd1 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801fd1:	55                   	push   %ebp
  801fd2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801fd4:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd7:	6a 00                	push   $0x0
  801fd9:	ff 75 14             	pushl  0x14(%ebp)
  801fdc:	ff 75 10             	pushl  0x10(%ebp)
  801fdf:	ff 75 0c             	pushl  0xc(%ebp)
  801fe2:	50                   	push   %eax
  801fe3:	6a 21                	push   $0x21
  801fe5:	e8 26 fc ff ff       	call   801c10 <syscall>
  801fea:	83 c4 18             	add    $0x18,%esp
}
  801fed:	c9                   	leave  
  801fee:	c3                   	ret    

00801fef <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801fef:	55                   	push   %ebp
  801ff0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ff2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff5:	6a 00                	push   $0x0
  801ff7:	6a 00                	push   $0x0
  801ff9:	6a 00                	push   $0x0
  801ffb:	6a 00                	push   $0x0
  801ffd:	50                   	push   %eax
  801ffe:	6a 22                	push   $0x22
  802000:	e8 0b fc ff ff       	call   801c10 <syscall>
  802005:	83 c4 18             	add    $0x18,%esp
}
  802008:	90                   	nop
  802009:	c9                   	leave  
  80200a:	c3                   	ret    

0080200b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80200b:	55                   	push   %ebp
  80200c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80200e:	8b 45 08             	mov    0x8(%ebp),%eax
  802011:	6a 00                	push   $0x0
  802013:	6a 00                	push   $0x0
  802015:	6a 00                	push   $0x0
  802017:	6a 00                	push   $0x0
  802019:	50                   	push   %eax
  80201a:	6a 23                	push   $0x23
  80201c:	e8 ef fb ff ff       	call   801c10 <syscall>
  802021:	83 c4 18             	add    $0x18,%esp
}
  802024:	90                   	nop
  802025:	c9                   	leave  
  802026:	c3                   	ret    

00802027 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802027:	55                   	push   %ebp
  802028:	89 e5                	mov    %esp,%ebp
  80202a:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80202d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802030:	8d 50 04             	lea    0x4(%eax),%edx
  802033:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802036:	6a 00                	push   $0x0
  802038:	6a 00                	push   $0x0
  80203a:	6a 00                	push   $0x0
  80203c:	52                   	push   %edx
  80203d:	50                   	push   %eax
  80203e:	6a 24                	push   $0x24
  802040:	e8 cb fb ff ff       	call   801c10 <syscall>
  802045:	83 c4 18             	add    $0x18,%esp
	return result;
  802048:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80204b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80204e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802051:	89 01                	mov    %eax,(%ecx)
  802053:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802056:	8b 45 08             	mov    0x8(%ebp),%eax
  802059:	c9                   	leave  
  80205a:	c2 04 00             	ret    $0x4

0080205d <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80205d:	55                   	push   %ebp
  80205e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802060:	6a 00                	push   $0x0
  802062:	6a 00                	push   $0x0
  802064:	ff 75 10             	pushl  0x10(%ebp)
  802067:	ff 75 0c             	pushl  0xc(%ebp)
  80206a:	ff 75 08             	pushl  0x8(%ebp)
  80206d:	6a 13                	push   $0x13
  80206f:	e8 9c fb ff ff       	call   801c10 <syscall>
  802074:	83 c4 18             	add    $0x18,%esp
	return ;
  802077:	90                   	nop
}
  802078:	c9                   	leave  
  802079:	c3                   	ret    

0080207a <sys_rcr2>:
uint32 sys_rcr2()
{
  80207a:	55                   	push   %ebp
  80207b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80207d:	6a 00                	push   $0x0
  80207f:	6a 00                	push   $0x0
  802081:	6a 00                	push   $0x0
  802083:	6a 00                	push   $0x0
  802085:	6a 00                	push   $0x0
  802087:	6a 25                	push   $0x25
  802089:	e8 82 fb ff ff       	call   801c10 <syscall>
  80208e:	83 c4 18             	add    $0x18,%esp
}
  802091:	c9                   	leave  
  802092:	c3                   	ret    

00802093 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802093:	55                   	push   %ebp
  802094:	89 e5                	mov    %esp,%ebp
  802096:	83 ec 04             	sub    $0x4,%esp
  802099:	8b 45 08             	mov    0x8(%ebp),%eax
  80209c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80209f:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8020a3:	6a 00                	push   $0x0
  8020a5:	6a 00                	push   $0x0
  8020a7:	6a 00                	push   $0x0
  8020a9:	6a 00                	push   $0x0
  8020ab:	50                   	push   %eax
  8020ac:	6a 26                	push   $0x26
  8020ae:	e8 5d fb ff ff       	call   801c10 <syscall>
  8020b3:	83 c4 18             	add    $0x18,%esp
	return ;
  8020b6:	90                   	nop
}
  8020b7:	c9                   	leave  
  8020b8:	c3                   	ret    

008020b9 <rsttst>:
void rsttst()
{
  8020b9:	55                   	push   %ebp
  8020ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8020bc:	6a 00                	push   $0x0
  8020be:	6a 00                	push   $0x0
  8020c0:	6a 00                	push   $0x0
  8020c2:	6a 00                	push   $0x0
  8020c4:	6a 00                	push   $0x0
  8020c6:	6a 28                	push   $0x28
  8020c8:	e8 43 fb ff ff       	call   801c10 <syscall>
  8020cd:	83 c4 18             	add    $0x18,%esp
	return ;
  8020d0:	90                   	nop
}
  8020d1:	c9                   	leave  
  8020d2:	c3                   	ret    

008020d3 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8020d3:	55                   	push   %ebp
  8020d4:	89 e5                	mov    %esp,%ebp
  8020d6:	83 ec 04             	sub    $0x4,%esp
  8020d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8020dc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8020df:	8b 55 18             	mov    0x18(%ebp),%edx
  8020e2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8020e6:	52                   	push   %edx
  8020e7:	50                   	push   %eax
  8020e8:	ff 75 10             	pushl  0x10(%ebp)
  8020eb:	ff 75 0c             	pushl  0xc(%ebp)
  8020ee:	ff 75 08             	pushl  0x8(%ebp)
  8020f1:	6a 27                	push   $0x27
  8020f3:	e8 18 fb ff ff       	call   801c10 <syscall>
  8020f8:	83 c4 18             	add    $0x18,%esp
	return ;
  8020fb:	90                   	nop
}
  8020fc:	c9                   	leave  
  8020fd:	c3                   	ret    

008020fe <chktst>:
void chktst(uint32 n)
{
  8020fe:	55                   	push   %ebp
  8020ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802101:	6a 00                	push   $0x0
  802103:	6a 00                	push   $0x0
  802105:	6a 00                	push   $0x0
  802107:	6a 00                	push   $0x0
  802109:	ff 75 08             	pushl  0x8(%ebp)
  80210c:	6a 29                	push   $0x29
  80210e:	e8 fd fa ff ff       	call   801c10 <syscall>
  802113:	83 c4 18             	add    $0x18,%esp
	return ;
  802116:	90                   	nop
}
  802117:	c9                   	leave  
  802118:	c3                   	ret    

00802119 <inctst>:

void inctst()
{
  802119:	55                   	push   %ebp
  80211a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80211c:	6a 00                	push   $0x0
  80211e:	6a 00                	push   $0x0
  802120:	6a 00                	push   $0x0
  802122:	6a 00                	push   $0x0
  802124:	6a 00                	push   $0x0
  802126:	6a 2a                	push   $0x2a
  802128:	e8 e3 fa ff ff       	call   801c10 <syscall>
  80212d:	83 c4 18             	add    $0x18,%esp
	return ;
  802130:	90                   	nop
}
  802131:	c9                   	leave  
  802132:	c3                   	ret    

00802133 <gettst>:
uint32 gettst()
{
  802133:	55                   	push   %ebp
  802134:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802136:	6a 00                	push   $0x0
  802138:	6a 00                	push   $0x0
  80213a:	6a 00                	push   $0x0
  80213c:	6a 00                	push   $0x0
  80213e:	6a 00                	push   $0x0
  802140:	6a 2b                	push   $0x2b
  802142:	e8 c9 fa ff ff       	call   801c10 <syscall>
  802147:	83 c4 18             	add    $0x18,%esp
}
  80214a:	c9                   	leave  
  80214b:	c3                   	ret    

0080214c <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80214c:	55                   	push   %ebp
  80214d:	89 e5                	mov    %esp,%ebp
  80214f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802152:	6a 00                	push   $0x0
  802154:	6a 00                	push   $0x0
  802156:	6a 00                	push   $0x0
  802158:	6a 00                	push   $0x0
  80215a:	6a 00                	push   $0x0
  80215c:	6a 2c                	push   $0x2c
  80215e:	e8 ad fa ff ff       	call   801c10 <syscall>
  802163:	83 c4 18             	add    $0x18,%esp
  802166:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802169:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80216d:	75 07                	jne    802176 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80216f:	b8 01 00 00 00       	mov    $0x1,%eax
  802174:	eb 05                	jmp    80217b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802176:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80217b:	c9                   	leave  
  80217c:	c3                   	ret    

0080217d <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80217d:	55                   	push   %ebp
  80217e:	89 e5                	mov    %esp,%ebp
  802180:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802183:	6a 00                	push   $0x0
  802185:	6a 00                	push   $0x0
  802187:	6a 00                	push   $0x0
  802189:	6a 00                	push   $0x0
  80218b:	6a 00                	push   $0x0
  80218d:	6a 2c                	push   $0x2c
  80218f:	e8 7c fa ff ff       	call   801c10 <syscall>
  802194:	83 c4 18             	add    $0x18,%esp
  802197:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80219a:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80219e:	75 07                	jne    8021a7 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8021a0:	b8 01 00 00 00       	mov    $0x1,%eax
  8021a5:	eb 05                	jmp    8021ac <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8021a7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021ac:	c9                   	leave  
  8021ad:	c3                   	ret    

008021ae <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8021ae:	55                   	push   %ebp
  8021af:	89 e5                	mov    %esp,%ebp
  8021b1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021b4:	6a 00                	push   $0x0
  8021b6:	6a 00                	push   $0x0
  8021b8:	6a 00                	push   $0x0
  8021ba:	6a 00                	push   $0x0
  8021bc:	6a 00                	push   $0x0
  8021be:	6a 2c                	push   $0x2c
  8021c0:	e8 4b fa ff ff       	call   801c10 <syscall>
  8021c5:	83 c4 18             	add    $0x18,%esp
  8021c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8021cb:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8021cf:	75 07                	jne    8021d8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8021d1:	b8 01 00 00 00       	mov    $0x1,%eax
  8021d6:	eb 05                	jmp    8021dd <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8021d8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021dd:	c9                   	leave  
  8021de:	c3                   	ret    

008021df <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8021df:	55                   	push   %ebp
  8021e0:	89 e5                	mov    %esp,%ebp
  8021e2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021e5:	6a 00                	push   $0x0
  8021e7:	6a 00                	push   $0x0
  8021e9:	6a 00                	push   $0x0
  8021eb:	6a 00                	push   $0x0
  8021ed:	6a 00                	push   $0x0
  8021ef:	6a 2c                	push   $0x2c
  8021f1:	e8 1a fa ff ff       	call   801c10 <syscall>
  8021f6:	83 c4 18             	add    $0x18,%esp
  8021f9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8021fc:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802200:	75 07                	jne    802209 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802202:	b8 01 00 00 00       	mov    $0x1,%eax
  802207:	eb 05                	jmp    80220e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802209:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80220e:	c9                   	leave  
  80220f:	c3                   	ret    

00802210 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802210:	55                   	push   %ebp
  802211:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802213:	6a 00                	push   $0x0
  802215:	6a 00                	push   $0x0
  802217:	6a 00                	push   $0x0
  802219:	6a 00                	push   $0x0
  80221b:	ff 75 08             	pushl  0x8(%ebp)
  80221e:	6a 2d                	push   $0x2d
  802220:	e8 eb f9 ff ff       	call   801c10 <syscall>
  802225:	83 c4 18             	add    $0x18,%esp
	return ;
  802228:	90                   	nop
}
  802229:	c9                   	leave  
  80222a:	c3                   	ret    

0080222b <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80222b:	55                   	push   %ebp
  80222c:	89 e5                	mov    %esp,%ebp
  80222e:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80222f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802232:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802235:	8b 55 0c             	mov    0xc(%ebp),%edx
  802238:	8b 45 08             	mov    0x8(%ebp),%eax
  80223b:	6a 00                	push   $0x0
  80223d:	53                   	push   %ebx
  80223e:	51                   	push   %ecx
  80223f:	52                   	push   %edx
  802240:	50                   	push   %eax
  802241:	6a 2e                	push   $0x2e
  802243:	e8 c8 f9 ff ff       	call   801c10 <syscall>
  802248:	83 c4 18             	add    $0x18,%esp
}
  80224b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80224e:	c9                   	leave  
  80224f:	c3                   	ret    

00802250 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802250:	55                   	push   %ebp
  802251:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802253:	8b 55 0c             	mov    0xc(%ebp),%edx
  802256:	8b 45 08             	mov    0x8(%ebp),%eax
  802259:	6a 00                	push   $0x0
  80225b:	6a 00                	push   $0x0
  80225d:	6a 00                	push   $0x0
  80225f:	52                   	push   %edx
  802260:	50                   	push   %eax
  802261:	6a 2f                	push   $0x2f
  802263:	e8 a8 f9 ff ff       	call   801c10 <syscall>
  802268:	83 c4 18             	add    $0x18,%esp
}
  80226b:	c9                   	leave  
  80226c:	c3                   	ret    
  80226d:	66 90                	xchg   %ax,%ax
  80226f:	90                   	nop

00802270 <__udivdi3>:
  802270:	55                   	push   %ebp
  802271:	57                   	push   %edi
  802272:	56                   	push   %esi
  802273:	53                   	push   %ebx
  802274:	83 ec 1c             	sub    $0x1c,%esp
  802277:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80227b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80227f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802283:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802287:	89 ca                	mov    %ecx,%edx
  802289:	89 f8                	mov    %edi,%eax
  80228b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80228f:	85 f6                	test   %esi,%esi
  802291:	75 2d                	jne    8022c0 <__udivdi3+0x50>
  802293:	39 cf                	cmp    %ecx,%edi
  802295:	77 65                	ja     8022fc <__udivdi3+0x8c>
  802297:	89 fd                	mov    %edi,%ebp
  802299:	85 ff                	test   %edi,%edi
  80229b:	75 0b                	jne    8022a8 <__udivdi3+0x38>
  80229d:	b8 01 00 00 00       	mov    $0x1,%eax
  8022a2:	31 d2                	xor    %edx,%edx
  8022a4:	f7 f7                	div    %edi
  8022a6:	89 c5                	mov    %eax,%ebp
  8022a8:	31 d2                	xor    %edx,%edx
  8022aa:	89 c8                	mov    %ecx,%eax
  8022ac:	f7 f5                	div    %ebp
  8022ae:	89 c1                	mov    %eax,%ecx
  8022b0:	89 d8                	mov    %ebx,%eax
  8022b2:	f7 f5                	div    %ebp
  8022b4:	89 cf                	mov    %ecx,%edi
  8022b6:	89 fa                	mov    %edi,%edx
  8022b8:	83 c4 1c             	add    $0x1c,%esp
  8022bb:	5b                   	pop    %ebx
  8022bc:	5e                   	pop    %esi
  8022bd:	5f                   	pop    %edi
  8022be:	5d                   	pop    %ebp
  8022bf:	c3                   	ret    
  8022c0:	39 ce                	cmp    %ecx,%esi
  8022c2:	77 28                	ja     8022ec <__udivdi3+0x7c>
  8022c4:	0f bd fe             	bsr    %esi,%edi
  8022c7:	83 f7 1f             	xor    $0x1f,%edi
  8022ca:	75 40                	jne    80230c <__udivdi3+0x9c>
  8022cc:	39 ce                	cmp    %ecx,%esi
  8022ce:	72 0a                	jb     8022da <__udivdi3+0x6a>
  8022d0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8022d4:	0f 87 9e 00 00 00    	ja     802378 <__udivdi3+0x108>
  8022da:	b8 01 00 00 00       	mov    $0x1,%eax
  8022df:	89 fa                	mov    %edi,%edx
  8022e1:	83 c4 1c             	add    $0x1c,%esp
  8022e4:	5b                   	pop    %ebx
  8022e5:	5e                   	pop    %esi
  8022e6:	5f                   	pop    %edi
  8022e7:	5d                   	pop    %ebp
  8022e8:	c3                   	ret    
  8022e9:	8d 76 00             	lea    0x0(%esi),%esi
  8022ec:	31 ff                	xor    %edi,%edi
  8022ee:	31 c0                	xor    %eax,%eax
  8022f0:	89 fa                	mov    %edi,%edx
  8022f2:	83 c4 1c             	add    $0x1c,%esp
  8022f5:	5b                   	pop    %ebx
  8022f6:	5e                   	pop    %esi
  8022f7:	5f                   	pop    %edi
  8022f8:	5d                   	pop    %ebp
  8022f9:	c3                   	ret    
  8022fa:	66 90                	xchg   %ax,%ax
  8022fc:	89 d8                	mov    %ebx,%eax
  8022fe:	f7 f7                	div    %edi
  802300:	31 ff                	xor    %edi,%edi
  802302:	89 fa                	mov    %edi,%edx
  802304:	83 c4 1c             	add    $0x1c,%esp
  802307:	5b                   	pop    %ebx
  802308:	5e                   	pop    %esi
  802309:	5f                   	pop    %edi
  80230a:	5d                   	pop    %ebp
  80230b:	c3                   	ret    
  80230c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802311:	89 eb                	mov    %ebp,%ebx
  802313:	29 fb                	sub    %edi,%ebx
  802315:	89 f9                	mov    %edi,%ecx
  802317:	d3 e6                	shl    %cl,%esi
  802319:	89 c5                	mov    %eax,%ebp
  80231b:	88 d9                	mov    %bl,%cl
  80231d:	d3 ed                	shr    %cl,%ebp
  80231f:	89 e9                	mov    %ebp,%ecx
  802321:	09 f1                	or     %esi,%ecx
  802323:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802327:	89 f9                	mov    %edi,%ecx
  802329:	d3 e0                	shl    %cl,%eax
  80232b:	89 c5                	mov    %eax,%ebp
  80232d:	89 d6                	mov    %edx,%esi
  80232f:	88 d9                	mov    %bl,%cl
  802331:	d3 ee                	shr    %cl,%esi
  802333:	89 f9                	mov    %edi,%ecx
  802335:	d3 e2                	shl    %cl,%edx
  802337:	8b 44 24 08          	mov    0x8(%esp),%eax
  80233b:	88 d9                	mov    %bl,%cl
  80233d:	d3 e8                	shr    %cl,%eax
  80233f:	09 c2                	or     %eax,%edx
  802341:	89 d0                	mov    %edx,%eax
  802343:	89 f2                	mov    %esi,%edx
  802345:	f7 74 24 0c          	divl   0xc(%esp)
  802349:	89 d6                	mov    %edx,%esi
  80234b:	89 c3                	mov    %eax,%ebx
  80234d:	f7 e5                	mul    %ebp
  80234f:	39 d6                	cmp    %edx,%esi
  802351:	72 19                	jb     80236c <__udivdi3+0xfc>
  802353:	74 0b                	je     802360 <__udivdi3+0xf0>
  802355:	89 d8                	mov    %ebx,%eax
  802357:	31 ff                	xor    %edi,%edi
  802359:	e9 58 ff ff ff       	jmp    8022b6 <__udivdi3+0x46>
  80235e:	66 90                	xchg   %ax,%ax
  802360:	8b 54 24 08          	mov    0x8(%esp),%edx
  802364:	89 f9                	mov    %edi,%ecx
  802366:	d3 e2                	shl    %cl,%edx
  802368:	39 c2                	cmp    %eax,%edx
  80236a:	73 e9                	jae    802355 <__udivdi3+0xe5>
  80236c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80236f:	31 ff                	xor    %edi,%edi
  802371:	e9 40 ff ff ff       	jmp    8022b6 <__udivdi3+0x46>
  802376:	66 90                	xchg   %ax,%ax
  802378:	31 c0                	xor    %eax,%eax
  80237a:	e9 37 ff ff ff       	jmp    8022b6 <__udivdi3+0x46>
  80237f:	90                   	nop

00802380 <__umoddi3>:
  802380:	55                   	push   %ebp
  802381:	57                   	push   %edi
  802382:	56                   	push   %esi
  802383:	53                   	push   %ebx
  802384:	83 ec 1c             	sub    $0x1c,%esp
  802387:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80238b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80238f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802393:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802397:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80239b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80239f:	89 f3                	mov    %esi,%ebx
  8023a1:	89 fa                	mov    %edi,%edx
  8023a3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023a7:	89 34 24             	mov    %esi,(%esp)
  8023aa:	85 c0                	test   %eax,%eax
  8023ac:	75 1a                	jne    8023c8 <__umoddi3+0x48>
  8023ae:	39 f7                	cmp    %esi,%edi
  8023b0:	0f 86 a2 00 00 00    	jbe    802458 <__umoddi3+0xd8>
  8023b6:	89 c8                	mov    %ecx,%eax
  8023b8:	89 f2                	mov    %esi,%edx
  8023ba:	f7 f7                	div    %edi
  8023bc:	89 d0                	mov    %edx,%eax
  8023be:	31 d2                	xor    %edx,%edx
  8023c0:	83 c4 1c             	add    $0x1c,%esp
  8023c3:	5b                   	pop    %ebx
  8023c4:	5e                   	pop    %esi
  8023c5:	5f                   	pop    %edi
  8023c6:	5d                   	pop    %ebp
  8023c7:	c3                   	ret    
  8023c8:	39 f0                	cmp    %esi,%eax
  8023ca:	0f 87 ac 00 00 00    	ja     80247c <__umoddi3+0xfc>
  8023d0:	0f bd e8             	bsr    %eax,%ebp
  8023d3:	83 f5 1f             	xor    $0x1f,%ebp
  8023d6:	0f 84 ac 00 00 00    	je     802488 <__umoddi3+0x108>
  8023dc:	bf 20 00 00 00       	mov    $0x20,%edi
  8023e1:	29 ef                	sub    %ebp,%edi
  8023e3:	89 fe                	mov    %edi,%esi
  8023e5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8023e9:	89 e9                	mov    %ebp,%ecx
  8023eb:	d3 e0                	shl    %cl,%eax
  8023ed:	89 d7                	mov    %edx,%edi
  8023ef:	89 f1                	mov    %esi,%ecx
  8023f1:	d3 ef                	shr    %cl,%edi
  8023f3:	09 c7                	or     %eax,%edi
  8023f5:	89 e9                	mov    %ebp,%ecx
  8023f7:	d3 e2                	shl    %cl,%edx
  8023f9:	89 14 24             	mov    %edx,(%esp)
  8023fc:	89 d8                	mov    %ebx,%eax
  8023fe:	d3 e0                	shl    %cl,%eax
  802400:	89 c2                	mov    %eax,%edx
  802402:	8b 44 24 08          	mov    0x8(%esp),%eax
  802406:	d3 e0                	shl    %cl,%eax
  802408:	89 44 24 04          	mov    %eax,0x4(%esp)
  80240c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802410:	89 f1                	mov    %esi,%ecx
  802412:	d3 e8                	shr    %cl,%eax
  802414:	09 d0                	or     %edx,%eax
  802416:	d3 eb                	shr    %cl,%ebx
  802418:	89 da                	mov    %ebx,%edx
  80241a:	f7 f7                	div    %edi
  80241c:	89 d3                	mov    %edx,%ebx
  80241e:	f7 24 24             	mull   (%esp)
  802421:	89 c6                	mov    %eax,%esi
  802423:	89 d1                	mov    %edx,%ecx
  802425:	39 d3                	cmp    %edx,%ebx
  802427:	0f 82 87 00 00 00    	jb     8024b4 <__umoddi3+0x134>
  80242d:	0f 84 91 00 00 00    	je     8024c4 <__umoddi3+0x144>
  802433:	8b 54 24 04          	mov    0x4(%esp),%edx
  802437:	29 f2                	sub    %esi,%edx
  802439:	19 cb                	sbb    %ecx,%ebx
  80243b:	89 d8                	mov    %ebx,%eax
  80243d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802441:	d3 e0                	shl    %cl,%eax
  802443:	89 e9                	mov    %ebp,%ecx
  802445:	d3 ea                	shr    %cl,%edx
  802447:	09 d0                	or     %edx,%eax
  802449:	89 e9                	mov    %ebp,%ecx
  80244b:	d3 eb                	shr    %cl,%ebx
  80244d:	89 da                	mov    %ebx,%edx
  80244f:	83 c4 1c             	add    $0x1c,%esp
  802452:	5b                   	pop    %ebx
  802453:	5e                   	pop    %esi
  802454:	5f                   	pop    %edi
  802455:	5d                   	pop    %ebp
  802456:	c3                   	ret    
  802457:	90                   	nop
  802458:	89 fd                	mov    %edi,%ebp
  80245a:	85 ff                	test   %edi,%edi
  80245c:	75 0b                	jne    802469 <__umoddi3+0xe9>
  80245e:	b8 01 00 00 00       	mov    $0x1,%eax
  802463:	31 d2                	xor    %edx,%edx
  802465:	f7 f7                	div    %edi
  802467:	89 c5                	mov    %eax,%ebp
  802469:	89 f0                	mov    %esi,%eax
  80246b:	31 d2                	xor    %edx,%edx
  80246d:	f7 f5                	div    %ebp
  80246f:	89 c8                	mov    %ecx,%eax
  802471:	f7 f5                	div    %ebp
  802473:	89 d0                	mov    %edx,%eax
  802475:	e9 44 ff ff ff       	jmp    8023be <__umoddi3+0x3e>
  80247a:	66 90                	xchg   %ax,%ax
  80247c:	89 c8                	mov    %ecx,%eax
  80247e:	89 f2                	mov    %esi,%edx
  802480:	83 c4 1c             	add    $0x1c,%esp
  802483:	5b                   	pop    %ebx
  802484:	5e                   	pop    %esi
  802485:	5f                   	pop    %edi
  802486:	5d                   	pop    %ebp
  802487:	c3                   	ret    
  802488:	3b 04 24             	cmp    (%esp),%eax
  80248b:	72 06                	jb     802493 <__umoddi3+0x113>
  80248d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802491:	77 0f                	ja     8024a2 <__umoddi3+0x122>
  802493:	89 f2                	mov    %esi,%edx
  802495:	29 f9                	sub    %edi,%ecx
  802497:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80249b:	89 14 24             	mov    %edx,(%esp)
  80249e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024a2:	8b 44 24 04          	mov    0x4(%esp),%eax
  8024a6:	8b 14 24             	mov    (%esp),%edx
  8024a9:	83 c4 1c             	add    $0x1c,%esp
  8024ac:	5b                   	pop    %ebx
  8024ad:	5e                   	pop    %esi
  8024ae:	5f                   	pop    %edi
  8024af:	5d                   	pop    %ebp
  8024b0:	c3                   	ret    
  8024b1:	8d 76 00             	lea    0x0(%esi),%esi
  8024b4:	2b 04 24             	sub    (%esp),%eax
  8024b7:	19 fa                	sbb    %edi,%edx
  8024b9:	89 d1                	mov    %edx,%ecx
  8024bb:	89 c6                	mov    %eax,%esi
  8024bd:	e9 71 ff ff ff       	jmp    802433 <__umoddi3+0xb3>
  8024c2:	66 90                	xchg   %ax,%ax
  8024c4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8024c8:	72 ea                	jb     8024b4 <__umoddi3+0x134>
  8024ca:	89 d9                	mov    %ebx,%ecx
  8024cc:	e9 62 ff ff ff       	jmp    802433 <__umoddi3+0xb3>
