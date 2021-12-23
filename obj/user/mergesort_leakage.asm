
obj/user/mergesort_leakage:     file format elf32-i386


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
  800031:	e8 65 07 00 00       	call   80079b <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void Merge(int* A, int p, int q, int r);

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
  800041:	e8 82 20 00 00       	call   8020c8 <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 60 27 80 00       	push   $0x802760
  80004e:	e8 2f 0b 00 00       	call   800b82 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 62 27 80 00       	push   $0x802762
  80005e:	e8 1f 0b 00 00       	call   800b82 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 78 27 80 00       	push   $0x802778
  80006e:	e8 0f 0b 00 00       	call   800b82 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 62 27 80 00       	push   $0x802762
  80007e:	e8 ff 0a 00 00       	call   800b82 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 60 27 80 00       	push   $0x802760
  80008e:	e8 ef 0a 00 00       	call   800b82 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 90 27 80 00       	push   $0x802790
  8000a5:	e8 5a 11 00 00       	call   801204 <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 aa 16 00 00       	call   80176a <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 3d 1a 00 00       	call   801b12 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 b0 27 80 00       	push   $0x8027b0
  8000e3:	e8 9a 0a 00 00       	call   800b82 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 d2 27 80 00       	push   $0x8027d2
  8000f3:	e8 8a 0a 00 00       	call   800b82 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 e0 27 80 00       	push   $0x8027e0
  800103:	e8 7a 0a 00 00       	call   800b82 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 ef 27 80 00       	push   $0x8027ef
  800113:	e8 6a 0a 00 00       	call   800b82 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 ff 27 80 00       	push   $0x8027ff
  800123:	e8 5a 0a 00 00       	call   800b82 <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 13 06 00 00       	call   800743 <getchar>
  800130:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800133:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 bb 05 00 00       	call   8006fb <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 ae 05 00 00       	call   8006fb <cputchar>
  80014d:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800150:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800154:	74 0c                	je     800162 <_main+0x12a>
  800156:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  80015a:	74 06                	je     800162 <_main+0x12a>
  80015c:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800160:	75 b9                	jne    80011b <_main+0xe3>

		//2012: lock the interrupt
		sys_enable_interrupt();
  800162:	e8 7b 1f 00 00       	call   8020e2 <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  800167:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
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
  80017d:	ff 75 f0             	pushl  -0x10(%ebp)
  800180:	ff 75 ec             	pushl  -0x14(%ebp)
  800183:	e8 e6 01 00 00       	call   80036e <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f0             	pushl  -0x10(%ebp)
  800193:	ff 75 ec             	pushl  -0x14(%ebp)
  800196:	e8 04 02 00 00       	call   80039f <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a9:	e8 26 02 00 00       	call   8003d4 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001bc:	e8 13 02 00 00       	call   8003d4 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001c4:	83 ec 04             	sub    $0x4,%esp
  8001c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ca:	6a 01                	push   $0x1
  8001cc:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cf:	e8 d2 02 00 00       	call   8004a6 <MSort>
  8001d4:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001d7:	e8 ec 1e 00 00       	call   8020c8 <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001dc:	83 ec 0c             	sub    $0xc,%esp
  8001df:	68 08 28 80 00       	push   $0x802808
  8001e4:	e8 99 09 00 00       	call   800b82 <cprintf>
  8001e9:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ec:	e8 f1 1e 00 00       	call   8020e2 <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001f1:	83 ec 08             	sub    $0x8,%esp
  8001f4:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001fa:	e8 c5 00 00 00       	call   8002c4 <CheckSorted>
  8001ff:	83 c4 10             	add    $0x10,%esp
  800202:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800205:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800209:	75 14                	jne    80021f <_main+0x1e7>
  80020b:	83 ec 04             	sub    $0x4,%esp
  80020e:	68 3c 28 80 00       	push   $0x80283c
  800213:	6a 4a                	push   $0x4a
  800215:	68 5e 28 80 00       	push   $0x80285e
  80021a:	e8 c1 06 00 00       	call   8008e0 <_panic>
		else
		{
			sys_disable_interrupt();
  80021f:	e8 a4 1e 00 00       	call   8020c8 <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800224:	83 ec 0c             	sub    $0xc,%esp
  800227:	68 78 28 80 00       	push   $0x802878
  80022c:	e8 51 09 00 00       	call   800b82 <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 ac 28 80 00       	push   $0x8028ac
  80023c:	e8 41 09 00 00       	call   800b82 <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	68 e0 28 80 00       	push   $0x8028e0
  80024c:	e8 31 09 00 00       	call   800b82 <cprintf>
  800251:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800254:	e8 89 1e 00 00       	call   8020e2 <sys_enable_interrupt>
		}

		//free(Elements) ;

		sys_disable_interrupt();
  800259:	e8 6a 1e 00 00       	call   8020c8 <sys_disable_interrupt>
			Chose = 0 ;
  80025e:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800262:	eb 42                	jmp    8002a6 <_main+0x26e>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800264:	83 ec 0c             	sub    $0xc,%esp
  800267:	68 12 29 80 00       	push   $0x802912
  80026c:	e8 11 09 00 00       	call   800b82 <cprintf>
  800271:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800274:	e8 ca 04 00 00       	call   800743 <getchar>
  800279:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80027c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800280:	83 ec 0c             	sub    $0xc,%esp
  800283:	50                   	push   %eax
  800284:	e8 72 04 00 00       	call   8006fb <cputchar>
  800289:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80028c:	83 ec 0c             	sub    $0xc,%esp
  80028f:	6a 0a                	push   $0xa
  800291:	e8 65 04 00 00       	call   8006fb <cputchar>
  800296:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800299:	83 ec 0c             	sub    $0xc,%esp
  80029c:	6a 0a                	push   $0xa
  80029e:	e8 58 04 00 00       	call   8006fb <cputchar>
  8002a3:	83 c4 10             	add    $0x10,%esp

		//free(Elements) ;

		sys_disable_interrupt();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002a6:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002aa:	74 06                	je     8002b2 <_main+0x27a>
  8002ac:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002b0:	75 b2                	jne    800264 <_main+0x22c>
				Chose = getchar() ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_enable_interrupt();
  8002b2:	e8 2b 1e 00 00       	call   8020e2 <sys_enable_interrupt>

	} while (Chose == 'y');
  8002b7:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002bb:	0f 84 80 fd ff ff    	je     800041 <_main+0x9>

}
  8002c1:	90                   	nop
  8002c2:	c9                   	leave  
  8002c3:	c3                   	ret    

008002c4 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002c4:	55                   	push   %ebp
  8002c5:	89 e5                	mov    %esp,%ebp
  8002c7:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002ca:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002d1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8002d8:	eb 33                	jmp    80030d <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8002da:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e7:	01 d0                	add    %edx,%eax
  8002e9:	8b 10                	mov    (%eax),%edx
  8002eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002ee:	40                   	inc    %eax
  8002ef:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f9:	01 c8                	add    %ecx,%eax
  8002fb:	8b 00                	mov    (%eax),%eax
  8002fd:	39 c2                	cmp    %eax,%edx
  8002ff:	7e 09                	jle    80030a <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800301:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800308:	eb 0c                	jmp    800316 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80030a:	ff 45 f8             	incl   -0x8(%ebp)
  80030d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800310:	48                   	dec    %eax
  800311:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800314:	7f c4                	jg     8002da <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800316:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800319:	c9                   	leave  
  80031a:	c3                   	ret    

0080031b <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80031b:	55                   	push   %ebp
  80031c:	89 e5                	mov    %esp,%ebp
  80031e:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800321:	8b 45 0c             	mov    0xc(%ebp),%eax
  800324:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80032b:	8b 45 08             	mov    0x8(%ebp),%eax
  80032e:	01 d0                	add    %edx,%eax
  800330:	8b 00                	mov    (%eax),%eax
  800332:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800335:	8b 45 0c             	mov    0xc(%ebp),%eax
  800338:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80033f:	8b 45 08             	mov    0x8(%ebp),%eax
  800342:	01 c2                	add    %eax,%edx
  800344:	8b 45 10             	mov    0x10(%ebp),%eax
  800347:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80034e:	8b 45 08             	mov    0x8(%ebp),%eax
  800351:	01 c8                	add    %ecx,%eax
  800353:	8b 00                	mov    (%eax),%eax
  800355:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800357:	8b 45 10             	mov    0x10(%ebp),%eax
  80035a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800361:	8b 45 08             	mov    0x8(%ebp),%eax
  800364:	01 c2                	add    %eax,%edx
  800366:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800369:	89 02                	mov    %eax,(%edx)
}
  80036b:	90                   	nop
  80036c:	c9                   	leave  
  80036d:	c3                   	ret    

0080036e <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80036e:	55                   	push   %ebp
  80036f:	89 e5                	mov    %esp,%ebp
  800371:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800374:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80037b:	eb 17                	jmp    800394 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80037d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800380:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800387:	8b 45 08             	mov    0x8(%ebp),%eax
  80038a:	01 c2                	add    %eax,%edx
  80038c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80038f:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800391:	ff 45 fc             	incl   -0x4(%ebp)
  800394:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800397:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80039a:	7c e1                	jl     80037d <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80039c:	90                   	nop
  80039d:	c9                   	leave  
  80039e:	c3                   	ret    

0080039f <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  80039f:	55                   	push   %ebp
  8003a0:	89 e5                	mov    %esp,%ebp
  8003a2:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003ac:	eb 1b                	jmp    8003c9 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003b1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bb:	01 c2                	add    %eax,%edx
  8003bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c0:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003c3:	48                   	dec    %eax
  8003c4:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003c6:	ff 45 fc             	incl   -0x4(%ebp)
  8003c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003cc:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003cf:	7c dd                	jl     8003ae <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8003d1:	90                   	nop
  8003d2:	c9                   	leave  
  8003d3:	c3                   	ret    

008003d4 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8003d4:	55                   	push   %ebp
  8003d5:	89 e5                	mov    %esp,%ebp
  8003d7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8003da:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003dd:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8003e2:	f7 e9                	imul   %ecx
  8003e4:	c1 f9 1f             	sar    $0x1f,%ecx
  8003e7:	89 d0                	mov    %edx,%eax
  8003e9:	29 c8                	sub    %ecx,%eax
  8003eb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8003ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003f5:	eb 1e                	jmp    800415 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8003f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003fa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800401:	8b 45 08             	mov    0x8(%ebp),%eax
  800404:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800407:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80040a:	99                   	cltd   
  80040b:	f7 7d f8             	idivl  -0x8(%ebp)
  80040e:	89 d0                	mov    %edx,%eax
  800410:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800412:	ff 45 fc             	incl   -0x4(%ebp)
  800415:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800418:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80041b:	7c da                	jl     8003f7 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80041d:	90                   	nop
  80041e:	c9                   	leave  
  80041f:	c3                   	ret    

00800420 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800420:	55                   	push   %ebp
  800421:	89 e5                	mov    %esp,%ebp
  800423:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800426:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80042d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800434:	eb 42                	jmp    800478 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800436:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800439:	99                   	cltd   
  80043a:	f7 7d f0             	idivl  -0x10(%ebp)
  80043d:	89 d0                	mov    %edx,%eax
  80043f:	85 c0                	test   %eax,%eax
  800441:	75 10                	jne    800453 <PrintElements+0x33>
			cprintf("\n");
  800443:	83 ec 0c             	sub    $0xc,%esp
  800446:	68 60 27 80 00       	push   $0x802760
  80044b:	e8 32 07 00 00       	call   800b82 <cprintf>
  800450:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800453:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800456:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	01 d0                	add    %edx,%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	83 ec 08             	sub    $0x8,%esp
  800467:	50                   	push   %eax
  800468:	68 30 29 80 00       	push   $0x802930
  80046d:	e8 10 07 00 00       	call   800b82 <cprintf>
  800472:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800475:	ff 45 f4             	incl   -0xc(%ebp)
  800478:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047b:	48                   	dec    %eax
  80047c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80047f:	7f b5                	jg     800436 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800481:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800484:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80048b:	8b 45 08             	mov    0x8(%ebp),%eax
  80048e:	01 d0                	add    %edx,%eax
  800490:	8b 00                	mov    (%eax),%eax
  800492:	83 ec 08             	sub    $0x8,%esp
  800495:	50                   	push   %eax
  800496:	68 35 29 80 00       	push   $0x802935
  80049b:	e8 e2 06 00 00       	call   800b82 <cprintf>
  8004a0:	83 c4 10             	add    $0x10,%esp

}
  8004a3:	90                   	nop
  8004a4:	c9                   	leave  
  8004a5:	c3                   	ret    

008004a6 <MSort>:


void MSort(int* A, int p, int r)
{
  8004a6:	55                   	push   %ebp
  8004a7:	89 e5                	mov    %esp,%ebp
  8004a9:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004af:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004b2:	7d 54                	jge    800508 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ba:	01 d0                	add    %edx,%eax
  8004bc:	89 c2                	mov    %eax,%edx
  8004be:	c1 ea 1f             	shr    $0x1f,%edx
  8004c1:	01 d0                	add    %edx,%eax
  8004c3:	d1 f8                	sar    %eax
  8004c5:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004c8:	83 ec 04             	sub    $0x4,%esp
  8004cb:	ff 75 f4             	pushl  -0xc(%ebp)
  8004ce:	ff 75 0c             	pushl  0xc(%ebp)
  8004d1:	ff 75 08             	pushl  0x8(%ebp)
  8004d4:	e8 cd ff ff ff       	call   8004a6 <MSort>
  8004d9:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  8004dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004df:	40                   	inc    %eax
  8004e0:	83 ec 04             	sub    $0x4,%esp
  8004e3:	ff 75 10             	pushl  0x10(%ebp)
  8004e6:	50                   	push   %eax
  8004e7:	ff 75 08             	pushl  0x8(%ebp)
  8004ea:	e8 b7 ff ff ff       	call   8004a6 <MSort>
  8004ef:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  8004f2:	ff 75 10             	pushl  0x10(%ebp)
  8004f5:	ff 75 f4             	pushl  -0xc(%ebp)
  8004f8:	ff 75 0c             	pushl  0xc(%ebp)
  8004fb:	ff 75 08             	pushl  0x8(%ebp)
  8004fe:	e8 08 00 00 00       	call   80050b <Merge>
  800503:	83 c4 10             	add    $0x10,%esp
  800506:	eb 01                	jmp    800509 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800508:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  800509:	c9                   	leave  
  80050a:	c3                   	ret    

0080050b <Merge>:

void Merge(int* A, int p, int q, int r)
{
  80050b:	55                   	push   %ebp
  80050c:	89 e5                	mov    %esp,%ebp
  80050e:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  800511:	8b 45 10             	mov    0x10(%ebp),%eax
  800514:	2b 45 0c             	sub    0xc(%ebp),%eax
  800517:	40                   	inc    %eax
  800518:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  80051b:	8b 45 14             	mov    0x14(%ebp),%eax
  80051e:	2b 45 10             	sub    0x10(%ebp),%eax
  800521:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800524:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  80052b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  800532:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800535:	c1 e0 02             	shl    $0x2,%eax
  800538:	83 ec 0c             	sub    $0xc,%esp
  80053b:	50                   	push   %eax
  80053c:	e8 d1 15 00 00       	call   801b12 <malloc>
  800541:	83 c4 10             	add    $0x10,%esp
  800544:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  800547:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80054a:	c1 e0 02             	shl    $0x2,%eax
  80054d:	83 ec 0c             	sub    $0xc,%esp
  800550:	50                   	push   %eax
  800551:	e8 bc 15 00 00       	call   801b12 <malloc>
  800556:	83 c4 10             	add    $0x10,%esp
  800559:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80055c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800563:	eb 2f                	jmp    800594 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  800565:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800568:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80056f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800572:	01 c2                	add    %eax,%edx
  800574:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800577:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80057a:	01 c8                	add    %ecx,%eax
  80057c:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800581:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800588:	8b 45 08             	mov    0x8(%ebp),%eax
  80058b:	01 c8                	add    %ecx,%eax
  80058d:	8b 00                	mov    (%eax),%eax
  80058f:	89 02                	mov    %eax,(%edx)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  800591:	ff 45 ec             	incl   -0x14(%ebp)
  800594:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800597:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80059a:	7c c9                	jl     800565 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  80059c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005a3:	eb 2a                	jmp    8005cf <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005a8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005af:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005b2:	01 c2                	add    %eax,%edx
  8005b4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005ba:	01 c8                	add    %ecx,%eax
  8005bc:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c6:	01 c8                	add    %ecx,%eax
  8005c8:	8b 00                	mov    (%eax),%eax
  8005ca:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005cc:	ff 45 e8             	incl   -0x18(%ebp)
  8005cf:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005d2:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005d5:	7c ce                	jl     8005a5 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8005d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005dd:	e9 0a 01 00 00       	jmp    8006ec <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  8005e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005e5:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005e8:	0f 8d 95 00 00 00    	jge    800683 <Merge+0x178>
  8005ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005f1:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005f4:	0f 8d 89 00 00 00    	jge    800683 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8005fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005fd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800604:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800607:	01 d0                	add    %edx,%eax
  800609:	8b 10                	mov    (%eax),%edx
  80060b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80060e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800615:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800618:	01 c8                	add    %ecx,%eax
  80061a:	8b 00                	mov    (%eax),%eax
  80061c:	39 c2                	cmp    %eax,%edx
  80061e:	7d 33                	jge    800653 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  800620:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800623:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800628:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80062f:	8b 45 08             	mov    0x8(%ebp),%eax
  800632:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800635:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800638:	8d 50 01             	lea    0x1(%eax),%edx
  80063b:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80063e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800645:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800648:	01 d0                	add    %edx,%eax
  80064a:	8b 00                	mov    (%eax),%eax
  80064c:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80064e:	e9 96 00 00 00       	jmp    8006e9 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800653:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800656:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80065b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800662:	8b 45 08             	mov    0x8(%ebp),%eax
  800665:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800668:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80066b:	8d 50 01             	lea    0x1(%eax),%edx
  80066e:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800671:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800678:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80067b:	01 d0                	add    %edx,%eax
  80067d:	8b 00                	mov    (%eax),%eax
  80067f:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800681:	eb 66                	jmp    8006e9 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800683:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800686:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800689:	7d 30                	jge    8006bb <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  80068b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80068e:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800693:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80069a:	8b 45 08             	mov    0x8(%ebp),%eax
  80069d:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006a3:	8d 50 01             	lea    0x1(%eax),%edx
  8006a6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006a9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006b0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006b3:	01 d0                	add    %edx,%eax
  8006b5:	8b 00                	mov    (%eax),%eax
  8006b7:	89 01                	mov    %eax,(%ecx)
  8006b9:	eb 2e                	jmp    8006e9 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006be:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cd:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d3:	8d 50 01             	lea    0x1(%eax),%edx
  8006d6:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006e0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006e3:	01 d0                	add    %edx,%eax
  8006e5:	8b 00                	mov    (%eax),%eax
  8006e7:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8006e9:	ff 45 e4             	incl   -0x1c(%ebp)
  8006ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006ef:	3b 45 14             	cmp    0x14(%ebp),%eax
  8006f2:	0f 8e ea fe ff ff    	jle    8005e2 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

}
  8006f8:	90                   	nop
  8006f9:	c9                   	leave  
  8006fa:	c3                   	ret    

008006fb <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8006fb:	55                   	push   %ebp
  8006fc:	89 e5                	mov    %esp,%ebp
  8006fe:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800701:	8b 45 08             	mov    0x8(%ebp),%eax
  800704:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800707:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80070b:	83 ec 0c             	sub    $0xc,%esp
  80070e:	50                   	push   %eax
  80070f:	e8 e8 19 00 00       	call   8020fc <sys_cputc>
  800714:	83 c4 10             	add    $0x10,%esp
}
  800717:	90                   	nop
  800718:	c9                   	leave  
  800719:	c3                   	ret    

0080071a <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80071a:	55                   	push   %ebp
  80071b:	89 e5                	mov    %esp,%ebp
  80071d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800720:	e8 a3 19 00 00       	call   8020c8 <sys_disable_interrupt>
	char c = ch;
  800725:	8b 45 08             	mov    0x8(%ebp),%eax
  800728:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80072b:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80072f:	83 ec 0c             	sub    $0xc,%esp
  800732:	50                   	push   %eax
  800733:	e8 c4 19 00 00       	call   8020fc <sys_cputc>
  800738:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80073b:	e8 a2 19 00 00       	call   8020e2 <sys_enable_interrupt>
}
  800740:	90                   	nop
  800741:	c9                   	leave  
  800742:	c3                   	ret    

00800743 <getchar>:

int
getchar(void)
{
  800743:	55                   	push   %ebp
  800744:	89 e5                	mov    %esp,%ebp
  800746:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800749:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800750:	eb 08                	jmp    80075a <getchar+0x17>
	{
		c = sys_cgetc();
  800752:	e8 89 17 00 00       	call   801ee0 <sys_cgetc>
  800757:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  80075a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80075e:	74 f2                	je     800752 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  800760:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800763:	c9                   	leave  
  800764:	c3                   	ret    

00800765 <atomic_getchar>:

int
atomic_getchar(void)
{
  800765:	55                   	push   %ebp
  800766:	89 e5                	mov    %esp,%ebp
  800768:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80076b:	e8 58 19 00 00       	call   8020c8 <sys_disable_interrupt>
	int c=0;
  800770:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800777:	eb 08                	jmp    800781 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800779:	e8 62 17 00 00       	call   801ee0 <sys_cgetc>
  80077e:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  800781:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800785:	74 f2                	je     800779 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800787:	e8 56 19 00 00       	call   8020e2 <sys_enable_interrupt>
	return c;
  80078c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80078f:	c9                   	leave  
  800790:	c3                   	ret    

00800791 <iscons>:

int iscons(int fdnum)
{
  800791:	55                   	push   %ebp
  800792:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800794:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800799:	5d                   	pop    %ebp
  80079a:	c3                   	ret    

0080079b <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80079b:	55                   	push   %ebp
  80079c:	89 e5                	mov    %esp,%ebp
  80079e:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007a1:	e8 87 17 00 00       	call   801f2d <sys_getenvindex>
  8007a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007ac:	89 d0                	mov    %edx,%eax
  8007ae:	c1 e0 03             	shl    $0x3,%eax
  8007b1:	01 d0                	add    %edx,%eax
  8007b3:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8007ba:	01 c8                	add    %ecx,%eax
  8007bc:	01 c0                	add    %eax,%eax
  8007be:	01 d0                	add    %edx,%eax
  8007c0:	01 c0                	add    %eax,%eax
  8007c2:	01 d0                	add    %edx,%eax
  8007c4:	89 c2                	mov    %eax,%edx
  8007c6:	c1 e2 05             	shl    $0x5,%edx
  8007c9:	29 c2                	sub    %eax,%edx
  8007cb:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8007d2:	89 c2                	mov    %eax,%edx
  8007d4:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8007da:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007df:	a1 24 30 80 00       	mov    0x803024,%eax
  8007e4:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8007ea:	84 c0                	test   %al,%al
  8007ec:	74 0f                	je     8007fd <libmain+0x62>
		binaryname = myEnv->prog_name;
  8007ee:	a1 24 30 80 00       	mov    0x803024,%eax
  8007f3:	05 40 3c 01 00       	add    $0x13c40,%eax
  8007f8:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8007fd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800801:	7e 0a                	jle    80080d <libmain+0x72>
		binaryname = argv[0];
  800803:	8b 45 0c             	mov    0xc(%ebp),%eax
  800806:	8b 00                	mov    (%eax),%eax
  800808:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80080d:	83 ec 08             	sub    $0x8,%esp
  800810:	ff 75 0c             	pushl  0xc(%ebp)
  800813:	ff 75 08             	pushl  0x8(%ebp)
  800816:	e8 1d f8 ff ff       	call   800038 <_main>
  80081b:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80081e:	e8 a5 18 00 00       	call   8020c8 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800823:	83 ec 0c             	sub    $0xc,%esp
  800826:	68 54 29 80 00       	push   $0x802954
  80082b:	e8 52 03 00 00       	call   800b82 <cprintf>
  800830:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800833:	a1 24 30 80 00       	mov    0x803024,%eax
  800838:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80083e:	a1 24 30 80 00       	mov    0x803024,%eax
  800843:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800849:	83 ec 04             	sub    $0x4,%esp
  80084c:	52                   	push   %edx
  80084d:	50                   	push   %eax
  80084e:	68 7c 29 80 00       	push   $0x80297c
  800853:	e8 2a 03 00 00       	call   800b82 <cprintf>
  800858:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80085b:	a1 24 30 80 00       	mov    0x803024,%eax
  800860:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800866:	a1 24 30 80 00       	mov    0x803024,%eax
  80086b:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800871:	83 ec 04             	sub    $0x4,%esp
  800874:	52                   	push   %edx
  800875:	50                   	push   %eax
  800876:	68 a4 29 80 00       	push   $0x8029a4
  80087b:	e8 02 03 00 00       	call   800b82 <cprintf>
  800880:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800883:	a1 24 30 80 00       	mov    0x803024,%eax
  800888:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80088e:	83 ec 08             	sub    $0x8,%esp
  800891:	50                   	push   %eax
  800892:	68 e5 29 80 00       	push   $0x8029e5
  800897:	e8 e6 02 00 00       	call   800b82 <cprintf>
  80089c:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80089f:	83 ec 0c             	sub    $0xc,%esp
  8008a2:	68 54 29 80 00       	push   $0x802954
  8008a7:	e8 d6 02 00 00       	call   800b82 <cprintf>
  8008ac:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8008af:	e8 2e 18 00 00       	call   8020e2 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8008b4:	e8 19 00 00 00       	call   8008d2 <exit>
}
  8008b9:	90                   	nop
  8008ba:	c9                   	leave  
  8008bb:	c3                   	ret    

008008bc <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008bc:	55                   	push   %ebp
  8008bd:	89 e5                	mov    %esp,%ebp
  8008bf:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008c2:	83 ec 0c             	sub    $0xc,%esp
  8008c5:	6a 00                	push   $0x0
  8008c7:	e8 2d 16 00 00       	call   801ef9 <sys_env_destroy>
  8008cc:	83 c4 10             	add    $0x10,%esp
}
  8008cf:	90                   	nop
  8008d0:	c9                   	leave  
  8008d1:	c3                   	ret    

008008d2 <exit>:

void
exit(void)
{
  8008d2:	55                   	push   %ebp
  8008d3:	89 e5                	mov    %esp,%ebp
  8008d5:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008d8:	e8 82 16 00 00       	call   801f5f <sys_env_exit>
}
  8008dd:	90                   	nop
  8008de:	c9                   	leave  
  8008df:	c3                   	ret    

008008e0 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008e0:	55                   	push   %ebp
  8008e1:	89 e5                	mov    %esp,%ebp
  8008e3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8008e6:	8d 45 10             	lea    0x10(%ebp),%eax
  8008e9:	83 c0 04             	add    $0x4,%eax
  8008ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8008ef:	a1 18 31 80 00       	mov    0x803118,%eax
  8008f4:	85 c0                	test   %eax,%eax
  8008f6:	74 16                	je     80090e <_panic+0x2e>
		cprintf("%s: ", argv0);
  8008f8:	a1 18 31 80 00       	mov    0x803118,%eax
  8008fd:	83 ec 08             	sub    $0x8,%esp
  800900:	50                   	push   %eax
  800901:	68 fc 29 80 00       	push   $0x8029fc
  800906:	e8 77 02 00 00       	call   800b82 <cprintf>
  80090b:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80090e:	a1 00 30 80 00       	mov    0x803000,%eax
  800913:	ff 75 0c             	pushl  0xc(%ebp)
  800916:	ff 75 08             	pushl  0x8(%ebp)
  800919:	50                   	push   %eax
  80091a:	68 01 2a 80 00       	push   $0x802a01
  80091f:	e8 5e 02 00 00       	call   800b82 <cprintf>
  800924:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800927:	8b 45 10             	mov    0x10(%ebp),%eax
  80092a:	83 ec 08             	sub    $0x8,%esp
  80092d:	ff 75 f4             	pushl  -0xc(%ebp)
  800930:	50                   	push   %eax
  800931:	e8 e1 01 00 00       	call   800b17 <vcprintf>
  800936:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800939:	83 ec 08             	sub    $0x8,%esp
  80093c:	6a 00                	push   $0x0
  80093e:	68 1d 2a 80 00       	push   $0x802a1d
  800943:	e8 cf 01 00 00       	call   800b17 <vcprintf>
  800948:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80094b:	e8 82 ff ff ff       	call   8008d2 <exit>

	// should not return here
	while (1) ;
  800950:	eb fe                	jmp    800950 <_panic+0x70>

00800952 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800952:	55                   	push   %ebp
  800953:	89 e5                	mov    %esp,%ebp
  800955:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800958:	a1 24 30 80 00       	mov    0x803024,%eax
  80095d:	8b 50 74             	mov    0x74(%eax),%edx
  800960:	8b 45 0c             	mov    0xc(%ebp),%eax
  800963:	39 c2                	cmp    %eax,%edx
  800965:	74 14                	je     80097b <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800967:	83 ec 04             	sub    $0x4,%esp
  80096a:	68 20 2a 80 00       	push   $0x802a20
  80096f:	6a 26                	push   $0x26
  800971:	68 6c 2a 80 00       	push   $0x802a6c
  800976:	e8 65 ff ff ff       	call   8008e0 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80097b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800982:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800989:	e9 b6 00 00 00       	jmp    800a44 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80098e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800991:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800998:	8b 45 08             	mov    0x8(%ebp),%eax
  80099b:	01 d0                	add    %edx,%eax
  80099d:	8b 00                	mov    (%eax),%eax
  80099f:	85 c0                	test   %eax,%eax
  8009a1:	75 08                	jne    8009ab <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8009a3:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8009a6:	e9 96 00 00 00       	jmp    800a41 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8009ab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009b2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8009b9:	eb 5d                	jmp    800a18 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009bb:	a1 24 30 80 00       	mov    0x803024,%eax
  8009c0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8009c6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009c9:	c1 e2 04             	shl    $0x4,%edx
  8009cc:	01 d0                	add    %edx,%eax
  8009ce:	8a 40 04             	mov    0x4(%eax),%al
  8009d1:	84 c0                	test   %al,%al
  8009d3:	75 40                	jne    800a15 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009d5:	a1 24 30 80 00       	mov    0x803024,%eax
  8009da:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8009e0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009e3:	c1 e2 04             	shl    $0x4,%edx
  8009e6:	01 d0                	add    %edx,%eax
  8009e8:	8b 00                	mov    (%eax),%eax
  8009ea:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8009ed:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009f0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009f5:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8009f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009fa:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a01:	8b 45 08             	mov    0x8(%ebp),%eax
  800a04:	01 c8                	add    %ecx,%eax
  800a06:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a08:	39 c2                	cmp    %eax,%edx
  800a0a:	75 09                	jne    800a15 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800a0c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a13:	eb 12                	jmp    800a27 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a15:	ff 45 e8             	incl   -0x18(%ebp)
  800a18:	a1 24 30 80 00       	mov    0x803024,%eax
  800a1d:	8b 50 74             	mov    0x74(%eax),%edx
  800a20:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a23:	39 c2                	cmp    %eax,%edx
  800a25:	77 94                	ja     8009bb <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a27:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a2b:	75 14                	jne    800a41 <CheckWSWithoutLastIndex+0xef>
			panic(
  800a2d:	83 ec 04             	sub    $0x4,%esp
  800a30:	68 78 2a 80 00       	push   $0x802a78
  800a35:	6a 3a                	push   $0x3a
  800a37:	68 6c 2a 80 00       	push   $0x802a6c
  800a3c:	e8 9f fe ff ff       	call   8008e0 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a41:	ff 45 f0             	incl   -0x10(%ebp)
  800a44:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a47:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a4a:	0f 8c 3e ff ff ff    	jl     80098e <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a50:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a57:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a5e:	eb 20                	jmp    800a80 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a60:	a1 24 30 80 00       	mov    0x803024,%eax
  800a65:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800a6b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a6e:	c1 e2 04             	shl    $0x4,%edx
  800a71:	01 d0                	add    %edx,%eax
  800a73:	8a 40 04             	mov    0x4(%eax),%al
  800a76:	3c 01                	cmp    $0x1,%al
  800a78:	75 03                	jne    800a7d <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800a7a:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a7d:	ff 45 e0             	incl   -0x20(%ebp)
  800a80:	a1 24 30 80 00       	mov    0x803024,%eax
  800a85:	8b 50 74             	mov    0x74(%eax),%edx
  800a88:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a8b:	39 c2                	cmp    %eax,%edx
  800a8d:	77 d1                	ja     800a60 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a92:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a95:	74 14                	je     800aab <CheckWSWithoutLastIndex+0x159>
		panic(
  800a97:	83 ec 04             	sub    $0x4,%esp
  800a9a:	68 cc 2a 80 00       	push   $0x802acc
  800a9f:	6a 44                	push   $0x44
  800aa1:	68 6c 2a 80 00       	push   $0x802a6c
  800aa6:	e8 35 fe ff ff       	call   8008e0 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800aab:	90                   	nop
  800aac:	c9                   	leave  
  800aad:	c3                   	ret    

00800aae <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800aae:	55                   	push   %ebp
  800aaf:	89 e5                	mov    %esp,%ebp
  800ab1:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800ab4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab7:	8b 00                	mov    (%eax),%eax
  800ab9:	8d 48 01             	lea    0x1(%eax),%ecx
  800abc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800abf:	89 0a                	mov    %ecx,(%edx)
  800ac1:	8b 55 08             	mov    0x8(%ebp),%edx
  800ac4:	88 d1                	mov    %dl,%cl
  800ac6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ac9:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800acd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad0:	8b 00                	mov    (%eax),%eax
  800ad2:	3d ff 00 00 00       	cmp    $0xff,%eax
  800ad7:	75 2c                	jne    800b05 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800ad9:	a0 28 30 80 00       	mov    0x803028,%al
  800ade:	0f b6 c0             	movzbl %al,%eax
  800ae1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae4:	8b 12                	mov    (%edx),%edx
  800ae6:	89 d1                	mov    %edx,%ecx
  800ae8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800aeb:	83 c2 08             	add    $0x8,%edx
  800aee:	83 ec 04             	sub    $0x4,%esp
  800af1:	50                   	push   %eax
  800af2:	51                   	push   %ecx
  800af3:	52                   	push   %edx
  800af4:	e8 be 13 00 00       	call   801eb7 <sys_cputs>
  800af9:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800afc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aff:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b08:	8b 40 04             	mov    0x4(%eax),%eax
  800b0b:	8d 50 01             	lea    0x1(%eax),%edx
  800b0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b11:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b14:	90                   	nop
  800b15:	c9                   	leave  
  800b16:	c3                   	ret    

00800b17 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b17:	55                   	push   %ebp
  800b18:	89 e5                	mov    %esp,%ebp
  800b1a:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b20:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b27:	00 00 00 
	b.cnt = 0;
  800b2a:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b31:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b34:	ff 75 0c             	pushl  0xc(%ebp)
  800b37:	ff 75 08             	pushl  0x8(%ebp)
  800b3a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b40:	50                   	push   %eax
  800b41:	68 ae 0a 80 00       	push   $0x800aae
  800b46:	e8 11 02 00 00       	call   800d5c <vprintfmt>
  800b4b:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b4e:	a0 28 30 80 00       	mov    0x803028,%al
  800b53:	0f b6 c0             	movzbl %al,%eax
  800b56:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b5c:	83 ec 04             	sub    $0x4,%esp
  800b5f:	50                   	push   %eax
  800b60:	52                   	push   %edx
  800b61:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b67:	83 c0 08             	add    $0x8,%eax
  800b6a:	50                   	push   %eax
  800b6b:	e8 47 13 00 00       	call   801eb7 <sys_cputs>
  800b70:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b73:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b7a:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b80:	c9                   	leave  
  800b81:	c3                   	ret    

00800b82 <cprintf>:

int cprintf(const char *fmt, ...) {
  800b82:	55                   	push   %ebp
  800b83:	89 e5                	mov    %esp,%ebp
  800b85:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b88:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800b8f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b92:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b95:	8b 45 08             	mov    0x8(%ebp),%eax
  800b98:	83 ec 08             	sub    $0x8,%esp
  800b9b:	ff 75 f4             	pushl  -0xc(%ebp)
  800b9e:	50                   	push   %eax
  800b9f:	e8 73 ff ff ff       	call   800b17 <vcprintf>
  800ba4:	83 c4 10             	add    $0x10,%esp
  800ba7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800baa:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bad:	c9                   	leave  
  800bae:	c3                   	ret    

00800baf <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800baf:	55                   	push   %ebp
  800bb0:	89 e5                	mov    %esp,%ebp
  800bb2:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bb5:	e8 0e 15 00 00       	call   8020c8 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800bba:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bbd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc3:	83 ec 08             	sub    $0x8,%esp
  800bc6:	ff 75 f4             	pushl  -0xc(%ebp)
  800bc9:	50                   	push   %eax
  800bca:	e8 48 ff ff ff       	call   800b17 <vcprintf>
  800bcf:	83 c4 10             	add    $0x10,%esp
  800bd2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800bd5:	e8 08 15 00 00       	call   8020e2 <sys_enable_interrupt>
	return cnt;
  800bda:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bdd:	c9                   	leave  
  800bde:	c3                   	ret    

00800bdf <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bdf:	55                   	push   %ebp
  800be0:	89 e5                	mov    %esp,%ebp
  800be2:	53                   	push   %ebx
  800be3:	83 ec 14             	sub    $0x14,%esp
  800be6:	8b 45 10             	mov    0x10(%ebp),%eax
  800be9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bec:	8b 45 14             	mov    0x14(%ebp),%eax
  800bef:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800bf2:	8b 45 18             	mov    0x18(%ebp),%eax
  800bf5:	ba 00 00 00 00       	mov    $0x0,%edx
  800bfa:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bfd:	77 55                	ja     800c54 <printnum+0x75>
  800bff:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c02:	72 05                	jb     800c09 <printnum+0x2a>
  800c04:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c07:	77 4b                	ja     800c54 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c09:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c0c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c0f:	8b 45 18             	mov    0x18(%ebp),%eax
  800c12:	ba 00 00 00 00       	mov    $0x0,%edx
  800c17:	52                   	push   %edx
  800c18:	50                   	push   %eax
  800c19:	ff 75 f4             	pushl  -0xc(%ebp)
  800c1c:	ff 75 f0             	pushl  -0x10(%ebp)
  800c1f:	e8 c8 18 00 00       	call   8024ec <__udivdi3>
  800c24:	83 c4 10             	add    $0x10,%esp
  800c27:	83 ec 04             	sub    $0x4,%esp
  800c2a:	ff 75 20             	pushl  0x20(%ebp)
  800c2d:	53                   	push   %ebx
  800c2e:	ff 75 18             	pushl  0x18(%ebp)
  800c31:	52                   	push   %edx
  800c32:	50                   	push   %eax
  800c33:	ff 75 0c             	pushl  0xc(%ebp)
  800c36:	ff 75 08             	pushl  0x8(%ebp)
  800c39:	e8 a1 ff ff ff       	call   800bdf <printnum>
  800c3e:	83 c4 20             	add    $0x20,%esp
  800c41:	eb 1a                	jmp    800c5d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c43:	83 ec 08             	sub    $0x8,%esp
  800c46:	ff 75 0c             	pushl  0xc(%ebp)
  800c49:	ff 75 20             	pushl  0x20(%ebp)
  800c4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4f:	ff d0                	call   *%eax
  800c51:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c54:	ff 4d 1c             	decl   0x1c(%ebp)
  800c57:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c5b:	7f e6                	jg     800c43 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c5d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c60:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c65:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c68:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c6b:	53                   	push   %ebx
  800c6c:	51                   	push   %ecx
  800c6d:	52                   	push   %edx
  800c6e:	50                   	push   %eax
  800c6f:	e8 88 19 00 00       	call   8025fc <__umoddi3>
  800c74:	83 c4 10             	add    $0x10,%esp
  800c77:	05 34 2d 80 00       	add    $0x802d34,%eax
  800c7c:	8a 00                	mov    (%eax),%al
  800c7e:	0f be c0             	movsbl %al,%eax
  800c81:	83 ec 08             	sub    $0x8,%esp
  800c84:	ff 75 0c             	pushl  0xc(%ebp)
  800c87:	50                   	push   %eax
  800c88:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8b:	ff d0                	call   *%eax
  800c8d:	83 c4 10             	add    $0x10,%esp
}
  800c90:	90                   	nop
  800c91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c94:	c9                   	leave  
  800c95:	c3                   	ret    

00800c96 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c96:	55                   	push   %ebp
  800c97:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c99:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c9d:	7e 1c                	jle    800cbb <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca2:	8b 00                	mov    (%eax),%eax
  800ca4:	8d 50 08             	lea    0x8(%eax),%edx
  800ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  800caa:	89 10                	mov    %edx,(%eax)
  800cac:	8b 45 08             	mov    0x8(%ebp),%eax
  800caf:	8b 00                	mov    (%eax),%eax
  800cb1:	83 e8 08             	sub    $0x8,%eax
  800cb4:	8b 50 04             	mov    0x4(%eax),%edx
  800cb7:	8b 00                	mov    (%eax),%eax
  800cb9:	eb 40                	jmp    800cfb <getuint+0x65>
	else if (lflag)
  800cbb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cbf:	74 1e                	je     800cdf <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc4:	8b 00                	mov    (%eax),%eax
  800cc6:	8d 50 04             	lea    0x4(%eax),%edx
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	89 10                	mov    %edx,(%eax)
  800cce:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd1:	8b 00                	mov    (%eax),%eax
  800cd3:	83 e8 04             	sub    $0x4,%eax
  800cd6:	8b 00                	mov    (%eax),%eax
  800cd8:	ba 00 00 00 00       	mov    $0x0,%edx
  800cdd:	eb 1c                	jmp    800cfb <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800cdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce2:	8b 00                	mov    (%eax),%eax
  800ce4:	8d 50 04             	lea    0x4(%eax),%edx
  800ce7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cea:	89 10                	mov    %edx,(%eax)
  800cec:	8b 45 08             	mov    0x8(%ebp),%eax
  800cef:	8b 00                	mov    (%eax),%eax
  800cf1:	83 e8 04             	sub    $0x4,%eax
  800cf4:	8b 00                	mov    (%eax),%eax
  800cf6:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800cfb:	5d                   	pop    %ebp
  800cfc:	c3                   	ret    

00800cfd <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800cfd:	55                   	push   %ebp
  800cfe:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d00:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d04:	7e 1c                	jle    800d22 <getint+0x25>
		return va_arg(*ap, long long);
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
  800d09:	8b 00                	mov    (%eax),%eax
  800d0b:	8d 50 08             	lea    0x8(%eax),%edx
  800d0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d11:	89 10                	mov    %edx,(%eax)
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
  800d16:	8b 00                	mov    (%eax),%eax
  800d18:	83 e8 08             	sub    $0x8,%eax
  800d1b:	8b 50 04             	mov    0x4(%eax),%edx
  800d1e:	8b 00                	mov    (%eax),%eax
  800d20:	eb 38                	jmp    800d5a <getint+0x5d>
	else if (lflag)
  800d22:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d26:	74 1a                	je     800d42 <getint+0x45>
		return va_arg(*ap, long);
  800d28:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2b:	8b 00                	mov    (%eax),%eax
  800d2d:	8d 50 04             	lea    0x4(%eax),%edx
  800d30:	8b 45 08             	mov    0x8(%ebp),%eax
  800d33:	89 10                	mov    %edx,(%eax)
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	8b 00                	mov    (%eax),%eax
  800d3a:	83 e8 04             	sub    $0x4,%eax
  800d3d:	8b 00                	mov    (%eax),%eax
  800d3f:	99                   	cltd   
  800d40:	eb 18                	jmp    800d5a <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d42:	8b 45 08             	mov    0x8(%ebp),%eax
  800d45:	8b 00                	mov    (%eax),%eax
  800d47:	8d 50 04             	lea    0x4(%eax),%edx
  800d4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4d:	89 10                	mov    %edx,(%eax)
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	8b 00                	mov    (%eax),%eax
  800d54:	83 e8 04             	sub    $0x4,%eax
  800d57:	8b 00                	mov    (%eax),%eax
  800d59:	99                   	cltd   
}
  800d5a:	5d                   	pop    %ebp
  800d5b:	c3                   	ret    

00800d5c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d5c:	55                   	push   %ebp
  800d5d:	89 e5                	mov    %esp,%ebp
  800d5f:	56                   	push   %esi
  800d60:	53                   	push   %ebx
  800d61:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d64:	eb 17                	jmp    800d7d <vprintfmt+0x21>
			if (ch == '\0')
  800d66:	85 db                	test   %ebx,%ebx
  800d68:	0f 84 af 03 00 00    	je     80111d <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d6e:	83 ec 08             	sub    $0x8,%esp
  800d71:	ff 75 0c             	pushl  0xc(%ebp)
  800d74:	53                   	push   %ebx
  800d75:	8b 45 08             	mov    0x8(%ebp),%eax
  800d78:	ff d0                	call   *%eax
  800d7a:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d7d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d80:	8d 50 01             	lea    0x1(%eax),%edx
  800d83:	89 55 10             	mov    %edx,0x10(%ebp)
  800d86:	8a 00                	mov    (%eax),%al
  800d88:	0f b6 d8             	movzbl %al,%ebx
  800d8b:	83 fb 25             	cmp    $0x25,%ebx
  800d8e:	75 d6                	jne    800d66 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d90:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d94:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d9b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800da2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800da9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800db0:	8b 45 10             	mov    0x10(%ebp),%eax
  800db3:	8d 50 01             	lea    0x1(%eax),%edx
  800db6:	89 55 10             	mov    %edx,0x10(%ebp)
  800db9:	8a 00                	mov    (%eax),%al
  800dbb:	0f b6 d8             	movzbl %al,%ebx
  800dbe:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800dc1:	83 f8 55             	cmp    $0x55,%eax
  800dc4:	0f 87 2b 03 00 00    	ja     8010f5 <vprintfmt+0x399>
  800dca:	8b 04 85 58 2d 80 00 	mov    0x802d58(,%eax,4),%eax
  800dd1:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800dd3:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800dd7:	eb d7                	jmp    800db0 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800dd9:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800ddd:	eb d1                	jmp    800db0 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ddf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800de6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800de9:	89 d0                	mov    %edx,%eax
  800deb:	c1 e0 02             	shl    $0x2,%eax
  800dee:	01 d0                	add    %edx,%eax
  800df0:	01 c0                	add    %eax,%eax
  800df2:	01 d8                	add    %ebx,%eax
  800df4:	83 e8 30             	sub    $0x30,%eax
  800df7:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800dfa:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfd:	8a 00                	mov    (%eax),%al
  800dff:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e02:	83 fb 2f             	cmp    $0x2f,%ebx
  800e05:	7e 3e                	jle    800e45 <vprintfmt+0xe9>
  800e07:	83 fb 39             	cmp    $0x39,%ebx
  800e0a:	7f 39                	jg     800e45 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e0c:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e0f:	eb d5                	jmp    800de6 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e11:	8b 45 14             	mov    0x14(%ebp),%eax
  800e14:	83 c0 04             	add    $0x4,%eax
  800e17:	89 45 14             	mov    %eax,0x14(%ebp)
  800e1a:	8b 45 14             	mov    0x14(%ebp),%eax
  800e1d:	83 e8 04             	sub    $0x4,%eax
  800e20:	8b 00                	mov    (%eax),%eax
  800e22:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e25:	eb 1f                	jmp    800e46 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e27:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e2b:	79 83                	jns    800db0 <vprintfmt+0x54>
				width = 0;
  800e2d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e34:	e9 77 ff ff ff       	jmp    800db0 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e39:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e40:	e9 6b ff ff ff       	jmp    800db0 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e45:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e46:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e4a:	0f 89 60 ff ff ff    	jns    800db0 <vprintfmt+0x54>
				width = precision, precision = -1;
  800e50:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e53:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e56:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e5d:	e9 4e ff ff ff       	jmp    800db0 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e62:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e65:	e9 46 ff ff ff       	jmp    800db0 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e6a:	8b 45 14             	mov    0x14(%ebp),%eax
  800e6d:	83 c0 04             	add    $0x4,%eax
  800e70:	89 45 14             	mov    %eax,0x14(%ebp)
  800e73:	8b 45 14             	mov    0x14(%ebp),%eax
  800e76:	83 e8 04             	sub    $0x4,%eax
  800e79:	8b 00                	mov    (%eax),%eax
  800e7b:	83 ec 08             	sub    $0x8,%esp
  800e7e:	ff 75 0c             	pushl  0xc(%ebp)
  800e81:	50                   	push   %eax
  800e82:	8b 45 08             	mov    0x8(%ebp),%eax
  800e85:	ff d0                	call   *%eax
  800e87:	83 c4 10             	add    $0x10,%esp
			break;
  800e8a:	e9 89 02 00 00       	jmp    801118 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800e92:	83 c0 04             	add    $0x4,%eax
  800e95:	89 45 14             	mov    %eax,0x14(%ebp)
  800e98:	8b 45 14             	mov    0x14(%ebp),%eax
  800e9b:	83 e8 04             	sub    $0x4,%eax
  800e9e:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ea0:	85 db                	test   %ebx,%ebx
  800ea2:	79 02                	jns    800ea6 <vprintfmt+0x14a>
				err = -err;
  800ea4:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800ea6:	83 fb 64             	cmp    $0x64,%ebx
  800ea9:	7f 0b                	jg     800eb6 <vprintfmt+0x15a>
  800eab:	8b 34 9d a0 2b 80 00 	mov    0x802ba0(,%ebx,4),%esi
  800eb2:	85 f6                	test   %esi,%esi
  800eb4:	75 19                	jne    800ecf <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800eb6:	53                   	push   %ebx
  800eb7:	68 45 2d 80 00       	push   $0x802d45
  800ebc:	ff 75 0c             	pushl  0xc(%ebp)
  800ebf:	ff 75 08             	pushl  0x8(%ebp)
  800ec2:	e8 5e 02 00 00       	call   801125 <printfmt>
  800ec7:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800eca:	e9 49 02 00 00       	jmp    801118 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ecf:	56                   	push   %esi
  800ed0:	68 4e 2d 80 00       	push   $0x802d4e
  800ed5:	ff 75 0c             	pushl  0xc(%ebp)
  800ed8:	ff 75 08             	pushl  0x8(%ebp)
  800edb:	e8 45 02 00 00       	call   801125 <printfmt>
  800ee0:	83 c4 10             	add    $0x10,%esp
			break;
  800ee3:	e9 30 02 00 00       	jmp    801118 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ee8:	8b 45 14             	mov    0x14(%ebp),%eax
  800eeb:	83 c0 04             	add    $0x4,%eax
  800eee:	89 45 14             	mov    %eax,0x14(%ebp)
  800ef1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ef4:	83 e8 04             	sub    $0x4,%eax
  800ef7:	8b 30                	mov    (%eax),%esi
  800ef9:	85 f6                	test   %esi,%esi
  800efb:	75 05                	jne    800f02 <vprintfmt+0x1a6>
				p = "(null)";
  800efd:	be 51 2d 80 00       	mov    $0x802d51,%esi
			if (width > 0 && padc != '-')
  800f02:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f06:	7e 6d                	jle    800f75 <vprintfmt+0x219>
  800f08:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f0c:	74 67                	je     800f75 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f0e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f11:	83 ec 08             	sub    $0x8,%esp
  800f14:	50                   	push   %eax
  800f15:	56                   	push   %esi
  800f16:	e8 12 05 00 00       	call   80142d <strnlen>
  800f1b:	83 c4 10             	add    $0x10,%esp
  800f1e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f21:	eb 16                	jmp    800f39 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f23:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f27:	83 ec 08             	sub    $0x8,%esp
  800f2a:	ff 75 0c             	pushl  0xc(%ebp)
  800f2d:	50                   	push   %eax
  800f2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f31:	ff d0                	call   *%eax
  800f33:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f36:	ff 4d e4             	decl   -0x1c(%ebp)
  800f39:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f3d:	7f e4                	jg     800f23 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f3f:	eb 34                	jmp    800f75 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f41:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f45:	74 1c                	je     800f63 <vprintfmt+0x207>
  800f47:	83 fb 1f             	cmp    $0x1f,%ebx
  800f4a:	7e 05                	jle    800f51 <vprintfmt+0x1f5>
  800f4c:	83 fb 7e             	cmp    $0x7e,%ebx
  800f4f:	7e 12                	jle    800f63 <vprintfmt+0x207>
					putch('?', putdat);
  800f51:	83 ec 08             	sub    $0x8,%esp
  800f54:	ff 75 0c             	pushl  0xc(%ebp)
  800f57:	6a 3f                	push   $0x3f
  800f59:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5c:	ff d0                	call   *%eax
  800f5e:	83 c4 10             	add    $0x10,%esp
  800f61:	eb 0f                	jmp    800f72 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f63:	83 ec 08             	sub    $0x8,%esp
  800f66:	ff 75 0c             	pushl  0xc(%ebp)
  800f69:	53                   	push   %ebx
  800f6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6d:	ff d0                	call   *%eax
  800f6f:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f72:	ff 4d e4             	decl   -0x1c(%ebp)
  800f75:	89 f0                	mov    %esi,%eax
  800f77:	8d 70 01             	lea    0x1(%eax),%esi
  800f7a:	8a 00                	mov    (%eax),%al
  800f7c:	0f be d8             	movsbl %al,%ebx
  800f7f:	85 db                	test   %ebx,%ebx
  800f81:	74 24                	je     800fa7 <vprintfmt+0x24b>
  800f83:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f87:	78 b8                	js     800f41 <vprintfmt+0x1e5>
  800f89:	ff 4d e0             	decl   -0x20(%ebp)
  800f8c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f90:	79 af                	jns    800f41 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f92:	eb 13                	jmp    800fa7 <vprintfmt+0x24b>
				putch(' ', putdat);
  800f94:	83 ec 08             	sub    $0x8,%esp
  800f97:	ff 75 0c             	pushl  0xc(%ebp)
  800f9a:	6a 20                	push   $0x20
  800f9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9f:	ff d0                	call   *%eax
  800fa1:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fa4:	ff 4d e4             	decl   -0x1c(%ebp)
  800fa7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fab:	7f e7                	jg     800f94 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fad:	e9 66 01 00 00       	jmp    801118 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fb2:	83 ec 08             	sub    $0x8,%esp
  800fb5:	ff 75 e8             	pushl  -0x18(%ebp)
  800fb8:	8d 45 14             	lea    0x14(%ebp),%eax
  800fbb:	50                   	push   %eax
  800fbc:	e8 3c fd ff ff       	call   800cfd <getint>
  800fc1:	83 c4 10             	add    $0x10,%esp
  800fc4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fc7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fcd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fd0:	85 d2                	test   %edx,%edx
  800fd2:	79 23                	jns    800ff7 <vprintfmt+0x29b>
				putch('-', putdat);
  800fd4:	83 ec 08             	sub    $0x8,%esp
  800fd7:	ff 75 0c             	pushl  0xc(%ebp)
  800fda:	6a 2d                	push   $0x2d
  800fdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdf:	ff d0                	call   *%eax
  800fe1:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fe4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fe7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fea:	f7 d8                	neg    %eax
  800fec:	83 d2 00             	adc    $0x0,%edx
  800fef:	f7 da                	neg    %edx
  800ff1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ff4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ff7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ffe:	e9 bc 00 00 00       	jmp    8010bf <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801003:	83 ec 08             	sub    $0x8,%esp
  801006:	ff 75 e8             	pushl  -0x18(%ebp)
  801009:	8d 45 14             	lea    0x14(%ebp),%eax
  80100c:	50                   	push   %eax
  80100d:	e8 84 fc ff ff       	call   800c96 <getuint>
  801012:	83 c4 10             	add    $0x10,%esp
  801015:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801018:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80101b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801022:	e9 98 00 00 00       	jmp    8010bf <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801027:	83 ec 08             	sub    $0x8,%esp
  80102a:	ff 75 0c             	pushl  0xc(%ebp)
  80102d:	6a 58                	push   $0x58
  80102f:	8b 45 08             	mov    0x8(%ebp),%eax
  801032:	ff d0                	call   *%eax
  801034:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801037:	83 ec 08             	sub    $0x8,%esp
  80103a:	ff 75 0c             	pushl  0xc(%ebp)
  80103d:	6a 58                	push   $0x58
  80103f:	8b 45 08             	mov    0x8(%ebp),%eax
  801042:	ff d0                	call   *%eax
  801044:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801047:	83 ec 08             	sub    $0x8,%esp
  80104a:	ff 75 0c             	pushl  0xc(%ebp)
  80104d:	6a 58                	push   $0x58
  80104f:	8b 45 08             	mov    0x8(%ebp),%eax
  801052:	ff d0                	call   *%eax
  801054:	83 c4 10             	add    $0x10,%esp
			break;
  801057:	e9 bc 00 00 00       	jmp    801118 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80105c:	83 ec 08             	sub    $0x8,%esp
  80105f:	ff 75 0c             	pushl  0xc(%ebp)
  801062:	6a 30                	push   $0x30
  801064:	8b 45 08             	mov    0x8(%ebp),%eax
  801067:	ff d0                	call   *%eax
  801069:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80106c:	83 ec 08             	sub    $0x8,%esp
  80106f:	ff 75 0c             	pushl  0xc(%ebp)
  801072:	6a 78                	push   $0x78
  801074:	8b 45 08             	mov    0x8(%ebp),%eax
  801077:	ff d0                	call   *%eax
  801079:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80107c:	8b 45 14             	mov    0x14(%ebp),%eax
  80107f:	83 c0 04             	add    $0x4,%eax
  801082:	89 45 14             	mov    %eax,0x14(%ebp)
  801085:	8b 45 14             	mov    0x14(%ebp),%eax
  801088:	83 e8 04             	sub    $0x4,%eax
  80108b:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80108d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801090:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801097:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80109e:	eb 1f                	jmp    8010bf <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8010a0:	83 ec 08             	sub    $0x8,%esp
  8010a3:	ff 75 e8             	pushl  -0x18(%ebp)
  8010a6:	8d 45 14             	lea    0x14(%ebp),%eax
  8010a9:	50                   	push   %eax
  8010aa:	e8 e7 fb ff ff       	call   800c96 <getuint>
  8010af:	83 c4 10             	add    $0x10,%esp
  8010b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010b5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010b8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010bf:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010c6:	83 ec 04             	sub    $0x4,%esp
  8010c9:	52                   	push   %edx
  8010ca:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010cd:	50                   	push   %eax
  8010ce:	ff 75 f4             	pushl  -0xc(%ebp)
  8010d1:	ff 75 f0             	pushl  -0x10(%ebp)
  8010d4:	ff 75 0c             	pushl  0xc(%ebp)
  8010d7:	ff 75 08             	pushl  0x8(%ebp)
  8010da:	e8 00 fb ff ff       	call   800bdf <printnum>
  8010df:	83 c4 20             	add    $0x20,%esp
			break;
  8010e2:	eb 34                	jmp    801118 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010e4:	83 ec 08             	sub    $0x8,%esp
  8010e7:	ff 75 0c             	pushl  0xc(%ebp)
  8010ea:	53                   	push   %ebx
  8010eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ee:	ff d0                	call   *%eax
  8010f0:	83 c4 10             	add    $0x10,%esp
			break;
  8010f3:	eb 23                	jmp    801118 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8010f5:	83 ec 08             	sub    $0x8,%esp
  8010f8:	ff 75 0c             	pushl  0xc(%ebp)
  8010fb:	6a 25                	push   $0x25
  8010fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801100:	ff d0                	call   *%eax
  801102:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801105:	ff 4d 10             	decl   0x10(%ebp)
  801108:	eb 03                	jmp    80110d <vprintfmt+0x3b1>
  80110a:	ff 4d 10             	decl   0x10(%ebp)
  80110d:	8b 45 10             	mov    0x10(%ebp),%eax
  801110:	48                   	dec    %eax
  801111:	8a 00                	mov    (%eax),%al
  801113:	3c 25                	cmp    $0x25,%al
  801115:	75 f3                	jne    80110a <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801117:	90                   	nop
		}
	}
  801118:	e9 47 fc ff ff       	jmp    800d64 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80111d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80111e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801121:	5b                   	pop    %ebx
  801122:	5e                   	pop    %esi
  801123:	5d                   	pop    %ebp
  801124:	c3                   	ret    

00801125 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801125:	55                   	push   %ebp
  801126:	89 e5                	mov    %esp,%ebp
  801128:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80112b:	8d 45 10             	lea    0x10(%ebp),%eax
  80112e:	83 c0 04             	add    $0x4,%eax
  801131:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801134:	8b 45 10             	mov    0x10(%ebp),%eax
  801137:	ff 75 f4             	pushl  -0xc(%ebp)
  80113a:	50                   	push   %eax
  80113b:	ff 75 0c             	pushl  0xc(%ebp)
  80113e:	ff 75 08             	pushl  0x8(%ebp)
  801141:	e8 16 fc ff ff       	call   800d5c <vprintfmt>
  801146:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801149:	90                   	nop
  80114a:	c9                   	leave  
  80114b:	c3                   	ret    

0080114c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80114c:	55                   	push   %ebp
  80114d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80114f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801152:	8b 40 08             	mov    0x8(%eax),%eax
  801155:	8d 50 01             	lea    0x1(%eax),%edx
  801158:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80115e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801161:	8b 10                	mov    (%eax),%edx
  801163:	8b 45 0c             	mov    0xc(%ebp),%eax
  801166:	8b 40 04             	mov    0x4(%eax),%eax
  801169:	39 c2                	cmp    %eax,%edx
  80116b:	73 12                	jae    80117f <sprintputch+0x33>
		*b->buf++ = ch;
  80116d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801170:	8b 00                	mov    (%eax),%eax
  801172:	8d 48 01             	lea    0x1(%eax),%ecx
  801175:	8b 55 0c             	mov    0xc(%ebp),%edx
  801178:	89 0a                	mov    %ecx,(%edx)
  80117a:	8b 55 08             	mov    0x8(%ebp),%edx
  80117d:	88 10                	mov    %dl,(%eax)
}
  80117f:	90                   	nop
  801180:	5d                   	pop    %ebp
  801181:	c3                   	ret    

00801182 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801182:	55                   	push   %ebp
  801183:	89 e5                	mov    %esp,%ebp
  801185:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801188:	8b 45 08             	mov    0x8(%ebp),%eax
  80118b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80118e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801191:	8d 50 ff             	lea    -0x1(%eax),%edx
  801194:	8b 45 08             	mov    0x8(%ebp),%eax
  801197:	01 d0                	add    %edx,%eax
  801199:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80119c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011a3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011a7:	74 06                	je     8011af <vsnprintf+0x2d>
  8011a9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011ad:	7f 07                	jg     8011b6 <vsnprintf+0x34>
		return -E_INVAL;
  8011af:	b8 03 00 00 00       	mov    $0x3,%eax
  8011b4:	eb 20                	jmp    8011d6 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011b6:	ff 75 14             	pushl  0x14(%ebp)
  8011b9:	ff 75 10             	pushl  0x10(%ebp)
  8011bc:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011bf:	50                   	push   %eax
  8011c0:	68 4c 11 80 00       	push   $0x80114c
  8011c5:	e8 92 fb ff ff       	call   800d5c <vprintfmt>
  8011ca:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011d0:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011d6:	c9                   	leave  
  8011d7:	c3                   	ret    

008011d8 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011d8:	55                   	push   %ebp
  8011d9:	89 e5                	mov    %esp,%ebp
  8011db:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011de:	8d 45 10             	lea    0x10(%ebp),%eax
  8011e1:	83 c0 04             	add    $0x4,%eax
  8011e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8011ed:	50                   	push   %eax
  8011ee:	ff 75 0c             	pushl  0xc(%ebp)
  8011f1:	ff 75 08             	pushl  0x8(%ebp)
  8011f4:	e8 89 ff ff ff       	call   801182 <vsnprintf>
  8011f9:	83 c4 10             	add    $0x10,%esp
  8011fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8011ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801202:	c9                   	leave  
  801203:	c3                   	ret    

00801204 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801204:	55                   	push   %ebp
  801205:	89 e5                	mov    %esp,%ebp
  801207:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80120a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80120e:	74 13                	je     801223 <readline+0x1f>
		cprintf("%s", prompt);
  801210:	83 ec 08             	sub    $0x8,%esp
  801213:	ff 75 08             	pushl  0x8(%ebp)
  801216:	68 b0 2e 80 00       	push   $0x802eb0
  80121b:	e8 62 f9 ff ff       	call   800b82 <cprintf>
  801220:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801223:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80122a:	83 ec 0c             	sub    $0xc,%esp
  80122d:	6a 00                	push   $0x0
  80122f:	e8 5d f5 ff ff       	call   800791 <iscons>
  801234:	83 c4 10             	add    $0x10,%esp
  801237:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80123a:	e8 04 f5 ff ff       	call   800743 <getchar>
  80123f:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801242:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801246:	79 22                	jns    80126a <readline+0x66>
			if (c != -E_EOF)
  801248:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80124c:	0f 84 ad 00 00 00    	je     8012ff <readline+0xfb>
				cprintf("read error: %e\n", c);
  801252:	83 ec 08             	sub    $0x8,%esp
  801255:	ff 75 ec             	pushl  -0x14(%ebp)
  801258:	68 b3 2e 80 00       	push   $0x802eb3
  80125d:	e8 20 f9 ff ff       	call   800b82 <cprintf>
  801262:	83 c4 10             	add    $0x10,%esp
			return;
  801265:	e9 95 00 00 00       	jmp    8012ff <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80126a:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80126e:	7e 34                	jle    8012a4 <readline+0xa0>
  801270:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801277:	7f 2b                	jg     8012a4 <readline+0xa0>
			if (echoing)
  801279:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80127d:	74 0e                	je     80128d <readline+0x89>
				cputchar(c);
  80127f:	83 ec 0c             	sub    $0xc,%esp
  801282:	ff 75 ec             	pushl  -0x14(%ebp)
  801285:	e8 71 f4 ff ff       	call   8006fb <cputchar>
  80128a:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80128d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801290:	8d 50 01             	lea    0x1(%eax),%edx
  801293:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801296:	89 c2                	mov    %eax,%edx
  801298:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129b:	01 d0                	add    %edx,%eax
  80129d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012a0:	88 10                	mov    %dl,(%eax)
  8012a2:	eb 56                	jmp    8012fa <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8012a4:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012a8:	75 1f                	jne    8012c9 <readline+0xc5>
  8012aa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012ae:	7e 19                	jle    8012c9 <readline+0xc5>
			if (echoing)
  8012b0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012b4:	74 0e                	je     8012c4 <readline+0xc0>
				cputchar(c);
  8012b6:	83 ec 0c             	sub    $0xc,%esp
  8012b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8012bc:	e8 3a f4 ff ff       	call   8006fb <cputchar>
  8012c1:	83 c4 10             	add    $0x10,%esp

			i--;
  8012c4:	ff 4d f4             	decl   -0xc(%ebp)
  8012c7:	eb 31                	jmp    8012fa <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8012c9:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012cd:	74 0a                	je     8012d9 <readline+0xd5>
  8012cf:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012d3:	0f 85 61 ff ff ff    	jne    80123a <readline+0x36>
			if (echoing)
  8012d9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012dd:	74 0e                	je     8012ed <readline+0xe9>
				cputchar(c);
  8012df:	83 ec 0c             	sub    $0xc,%esp
  8012e2:	ff 75 ec             	pushl  -0x14(%ebp)
  8012e5:	e8 11 f4 ff ff       	call   8006fb <cputchar>
  8012ea:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8012ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f3:	01 d0                	add    %edx,%eax
  8012f5:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8012f8:	eb 06                	jmp    801300 <readline+0xfc>
		}
	}
  8012fa:	e9 3b ff ff ff       	jmp    80123a <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8012ff:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801300:	c9                   	leave  
  801301:	c3                   	ret    

00801302 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801302:	55                   	push   %ebp
  801303:	89 e5                	mov    %esp,%ebp
  801305:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801308:	e8 bb 0d 00 00       	call   8020c8 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  80130d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801311:	74 13                	je     801326 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801313:	83 ec 08             	sub    $0x8,%esp
  801316:	ff 75 08             	pushl  0x8(%ebp)
  801319:	68 b0 2e 80 00       	push   $0x802eb0
  80131e:	e8 5f f8 ff ff       	call   800b82 <cprintf>
  801323:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801326:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80132d:	83 ec 0c             	sub    $0xc,%esp
  801330:	6a 00                	push   $0x0
  801332:	e8 5a f4 ff ff       	call   800791 <iscons>
  801337:	83 c4 10             	add    $0x10,%esp
  80133a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80133d:	e8 01 f4 ff ff       	call   800743 <getchar>
  801342:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801345:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801349:	79 23                	jns    80136e <atomic_readline+0x6c>
			if (c != -E_EOF)
  80134b:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80134f:	74 13                	je     801364 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801351:	83 ec 08             	sub    $0x8,%esp
  801354:	ff 75 ec             	pushl  -0x14(%ebp)
  801357:	68 b3 2e 80 00       	push   $0x802eb3
  80135c:	e8 21 f8 ff ff       	call   800b82 <cprintf>
  801361:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801364:	e8 79 0d 00 00       	call   8020e2 <sys_enable_interrupt>
			return;
  801369:	e9 9a 00 00 00       	jmp    801408 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80136e:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801372:	7e 34                	jle    8013a8 <atomic_readline+0xa6>
  801374:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80137b:	7f 2b                	jg     8013a8 <atomic_readline+0xa6>
			if (echoing)
  80137d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801381:	74 0e                	je     801391 <atomic_readline+0x8f>
				cputchar(c);
  801383:	83 ec 0c             	sub    $0xc,%esp
  801386:	ff 75 ec             	pushl  -0x14(%ebp)
  801389:	e8 6d f3 ff ff       	call   8006fb <cputchar>
  80138e:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801391:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801394:	8d 50 01             	lea    0x1(%eax),%edx
  801397:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80139a:	89 c2                	mov    %eax,%edx
  80139c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80139f:	01 d0                	add    %edx,%eax
  8013a1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013a4:	88 10                	mov    %dl,(%eax)
  8013a6:	eb 5b                	jmp    801403 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8013a8:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8013ac:	75 1f                	jne    8013cd <atomic_readline+0xcb>
  8013ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8013b2:	7e 19                	jle    8013cd <atomic_readline+0xcb>
			if (echoing)
  8013b4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013b8:	74 0e                	je     8013c8 <atomic_readline+0xc6>
				cputchar(c);
  8013ba:	83 ec 0c             	sub    $0xc,%esp
  8013bd:	ff 75 ec             	pushl  -0x14(%ebp)
  8013c0:	e8 36 f3 ff ff       	call   8006fb <cputchar>
  8013c5:	83 c4 10             	add    $0x10,%esp
			i--;
  8013c8:	ff 4d f4             	decl   -0xc(%ebp)
  8013cb:	eb 36                	jmp    801403 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8013cd:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8013d1:	74 0a                	je     8013dd <atomic_readline+0xdb>
  8013d3:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8013d7:	0f 85 60 ff ff ff    	jne    80133d <atomic_readline+0x3b>
			if (echoing)
  8013dd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013e1:	74 0e                	je     8013f1 <atomic_readline+0xef>
				cputchar(c);
  8013e3:	83 ec 0c             	sub    $0xc,%esp
  8013e6:	ff 75 ec             	pushl  -0x14(%ebp)
  8013e9:	e8 0d f3 ff ff       	call   8006fb <cputchar>
  8013ee:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8013f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f7:	01 d0                	add    %edx,%eax
  8013f9:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8013fc:	e8 e1 0c 00 00       	call   8020e2 <sys_enable_interrupt>
			return;
  801401:	eb 05                	jmp    801408 <atomic_readline+0x106>
		}
	}
  801403:	e9 35 ff ff ff       	jmp    80133d <atomic_readline+0x3b>
}
  801408:	c9                   	leave  
  801409:	c3                   	ret    

0080140a <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80140a:	55                   	push   %ebp
  80140b:	89 e5                	mov    %esp,%ebp
  80140d:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801410:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801417:	eb 06                	jmp    80141f <strlen+0x15>
		n++;
  801419:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80141c:	ff 45 08             	incl   0x8(%ebp)
  80141f:	8b 45 08             	mov    0x8(%ebp),%eax
  801422:	8a 00                	mov    (%eax),%al
  801424:	84 c0                	test   %al,%al
  801426:	75 f1                	jne    801419 <strlen+0xf>
		n++;
	return n;
  801428:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80142b:	c9                   	leave  
  80142c:	c3                   	ret    

0080142d <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80142d:	55                   	push   %ebp
  80142e:	89 e5                	mov    %esp,%ebp
  801430:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801433:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80143a:	eb 09                	jmp    801445 <strnlen+0x18>
		n++;
  80143c:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80143f:	ff 45 08             	incl   0x8(%ebp)
  801442:	ff 4d 0c             	decl   0xc(%ebp)
  801445:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801449:	74 09                	je     801454 <strnlen+0x27>
  80144b:	8b 45 08             	mov    0x8(%ebp),%eax
  80144e:	8a 00                	mov    (%eax),%al
  801450:	84 c0                	test   %al,%al
  801452:	75 e8                	jne    80143c <strnlen+0xf>
		n++;
	return n;
  801454:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801457:	c9                   	leave  
  801458:	c3                   	ret    

00801459 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801459:	55                   	push   %ebp
  80145a:	89 e5                	mov    %esp,%ebp
  80145c:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80145f:	8b 45 08             	mov    0x8(%ebp),%eax
  801462:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801465:	90                   	nop
  801466:	8b 45 08             	mov    0x8(%ebp),%eax
  801469:	8d 50 01             	lea    0x1(%eax),%edx
  80146c:	89 55 08             	mov    %edx,0x8(%ebp)
  80146f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801472:	8d 4a 01             	lea    0x1(%edx),%ecx
  801475:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801478:	8a 12                	mov    (%edx),%dl
  80147a:	88 10                	mov    %dl,(%eax)
  80147c:	8a 00                	mov    (%eax),%al
  80147e:	84 c0                	test   %al,%al
  801480:	75 e4                	jne    801466 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801482:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801485:	c9                   	leave  
  801486:	c3                   	ret    

00801487 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801487:	55                   	push   %ebp
  801488:	89 e5                	mov    %esp,%ebp
  80148a:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80148d:	8b 45 08             	mov    0x8(%ebp),%eax
  801490:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801493:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80149a:	eb 1f                	jmp    8014bb <strncpy+0x34>
		*dst++ = *src;
  80149c:	8b 45 08             	mov    0x8(%ebp),%eax
  80149f:	8d 50 01             	lea    0x1(%eax),%edx
  8014a2:	89 55 08             	mov    %edx,0x8(%ebp)
  8014a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014a8:	8a 12                	mov    (%edx),%dl
  8014aa:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8014ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014af:	8a 00                	mov    (%eax),%al
  8014b1:	84 c0                	test   %al,%al
  8014b3:	74 03                	je     8014b8 <strncpy+0x31>
			src++;
  8014b5:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014b8:	ff 45 fc             	incl   -0x4(%ebp)
  8014bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014be:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014c1:	72 d9                	jb     80149c <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014c6:	c9                   	leave  
  8014c7:	c3                   	ret    

008014c8 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
  8014cb:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8014d4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014d8:	74 30                	je     80150a <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8014da:	eb 16                	jmp    8014f2 <strlcpy+0x2a>
			*dst++ = *src++;
  8014dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014df:	8d 50 01             	lea    0x1(%eax),%edx
  8014e2:	89 55 08             	mov    %edx,0x8(%ebp)
  8014e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014e8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014eb:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8014ee:	8a 12                	mov    (%edx),%dl
  8014f0:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8014f2:	ff 4d 10             	decl   0x10(%ebp)
  8014f5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014f9:	74 09                	je     801504 <strlcpy+0x3c>
  8014fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014fe:	8a 00                	mov    (%eax),%al
  801500:	84 c0                	test   %al,%al
  801502:	75 d8                	jne    8014dc <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801504:	8b 45 08             	mov    0x8(%ebp),%eax
  801507:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80150a:	8b 55 08             	mov    0x8(%ebp),%edx
  80150d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801510:	29 c2                	sub    %eax,%edx
  801512:	89 d0                	mov    %edx,%eax
}
  801514:	c9                   	leave  
  801515:	c3                   	ret    

00801516 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801516:	55                   	push   %ebp
  801517:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801519:	eb 06                	jmp    801521 <strcmp+0xb>
		p++, q++;
  80151b:	ff 45 08             	incl   0x8(%ebp)
  80151e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801521:	8b 45 08             	mov    0x8(%ebp),%eax
  801524:	8a 00                	mov    (%eax),%al
  801526:	84 c0                	test   %al,%al
  801528:	74 0e                	je     801538 <strcmp+0x22>
  80152a:	8b 45 08             	mov    0x8(%ebp),%eax
  80152d:	8a 10                	mov    (%eax),%dl
  80152f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801532:	8a 00                	mov    (%eax),%al
  801534:	38 c2                	cmp    %al,%dl
  801536:	74 e3                	je     80151b <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801538:	8b 45 08             	mov    0x8(%ebp),%eax
  80153b:	8a 00                	mov    (%eax),%al
  80153d:	0f b6 d0             	movzbl %al,%edx
  801540:	8b 45 0c             	mov    0xc(%ebp),%eax
  801543:	8a 00                	mov    (%eax),%al
  801545:	0f b6 c0             	movzbl %al,%eax
  801548:	29 c2                	sub    %eax,%edx
  80154a:	89 d0                	mov    %edx,%eax
}
  80154c:	5d                   	pop    %ebp
  80154d:	c3                   	ret    

0080154e <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80154e:	55                   	push   %ebp
  80154f:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801551:	eb 09                	jmp    80155c <strncmp+0xe>
		n--, p++, q++;
  801553:	ff 4d 10             	decl   0x10(%ebp)
  801556:	ff 45 08             	incl   0x8(%ebp)
  801559:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80155c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801560:	74 17                	je     801579 <strncmp+0x2b>
  801562:	8b 45 08             	mov    0x8(%ebp),%eax
  801565:	8a 00                	mov    (%eax),%al
  801567:	84 c0                	test   %al,%al
  801569:	74 0e                	je     801579 <strncmp+0x2b>
  80156b:	8b 45 08             	mov    0x8(%ebp),%eax
  80156e:	8a 10                	mov    (%eax),%dl
  801570:	8b 45 0c             	mov    0xc(%ebp),%eax
  801573:	8a 00                	mov    (%eax),%al
  801575:	38 c2                	cmp    %al,%dl
  801577:	74 da                	je     801553 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801579:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80157d:	75 07                	jne    801586 <strncmp+0x38>
		return 0;
  80157f:	b8 00 00 00 00       	mov    $0x0,%eax
  801584:	eb 14                	jmp    80159a <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801586:	8b 45 08             	mov    0x8(%ebp),%eax
  801589:	8a 00                	mov    (%eax),%al
  80158b:	0f b6 d0             	movzbl %al,%edx
  80158e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801591:	8a 00                	mov    (%eax),%al
  801593:	0f b6 c0             	movzbl %al,%eax
  801596:	29 c2                	sub    %eax,%edx
  801598:	89 d0                	mov    %edx,%eax
}
  80159a:	5d                   	pop    %ebp
  80159b:	c3                   	ret    

0080159c <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80159c:	55                   	push   %ebp
  80159d:	89 e5                	mov    %esp,%ebp
  80159f:	83 ec 04             	sub    $0x4,%esp
  8015a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015a8:	eb 12                	jmp    8015bc <strchr+0x20>
		if (*s == c)
  8015aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ad:	8a 00                	mov    (%eax),%al
  8015af:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015b2:	75 05                	jne    8015b9 <strchr+0x1d>
			return (char *) s;
  8015b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b7:	eb 11                	jmp    8015ca <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015b9:	ff 45 08             	incl   0x8(%ebp)
  8015bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bf:	8a 00                	mov    (%eax),%al
  8015c1:	84 c0                	test   %al,%al
  8015c3:	75 e5                	jne    8015aa <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015c5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015ca:	c9                   	leave  
  8015cb:	c3                   	ret    

008015cc <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015cc:	55                   	push   %ebp
  8015cd:	89 e5                	mov    %esp,%ebp
  8015cf:	83 ec 04             	sub    $0x4,%esp
  8015d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d5:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015d8:	eb 0d                	jmp    8015e7 <strfind+0x1b>
		if (*s == c)
  8015da:	8b 45 08             	mov    0x8(%ebp),%eax
  8015dd:	8a 00                	mov    (%eax),%al
  8015df:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015e2:	74 0e                	je     8015f2 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8015e4:	ff 45 08             	incl   0x8(%ebp)
  8015e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ea:	8a 00                	mov    (%eax),%al
  8015ec:	84 c0                	test   %al,%al
  8015ee:	75 ea                	jne    8015da <strfind+0xe>
  8015f0:	eb 01                	jmp    8015f3 <strfind+0x27>
		if (*s == c)
			break;
  8015f2:	90                   	nop
	return (char *) s;
  8015f3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015f6:	c9                   	leave  
  8015f7:	c3                   	ret    

008015f8 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8015f8:	55                   	push   %ebp
  8015f9:	89 e5                	mov    %esp,%ebp
  8015fb:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8015fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801601:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801604:	8b 45 10             	mov    0x10(%ebp),%eax
  801607:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80160a:	eb 0e                	jmp    80161a <memset+0x22>
		*p++ = c;
  80160c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80160f:	8d 50 01             	lea    0x1(%eax),%edx
  801612:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801615:	8b 55 0c             	mov    0xc(%ebp),%edx
  801618:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80161a:	ff 4d f8             	decl   -0x8(%ebp)
  80161d:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801621:	79 e9                	jns    80160c <memset+0x14>
		*p++ = c;

	return v;
  801623:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801626:	c9                   	leave  
  801627:	c3                   	ret    

00801628 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801628:	55                   	push   %ebp
  801629:	89 e5                	mov    %esp,%ebp
  80162b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80162e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801631:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801634:	8b 45 08             	mov    0x8(%ebp),%eax
  801637:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80163a:	eb 16                	jmp    801652 <memcpy+0x2a>
		*d++ = *s++;
  80163c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80163f:	8d 50 01             	lea    0x1(%eax),%edx
  801642:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801645:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801648:	8d 4a 01             	lea    0x1(%edx),%ecx
  80164b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80164e:	8a 12                	mov    (%edx),%dl
  801650:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801652:	8b 45 10             	mov    0x10(%ebp),%eax
  801655:	8d 50 ff             	lea    -0x1(%eax),%edx
  801658:	89 55 10             	mov    %edx,0x10(%ebp)
  80165b:	85 c0                	test   %eax,%eax
  80165d:	75 dd                	jne    80163c <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801662:	c9                   	leave  
  801663:	c3                   	ret    

00801664 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801664:	55                   	push   %ebp
  801665:	89 e5                	mov    %esp,%ebp
  801667:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80166a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80166d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801670:	8b 45 08             	mov    0x8(%ebp),%eax
  801673:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801676:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801679:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80167c:	73 50                	jae    8016ce <memmove+0x6a>
  80167e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801681:	8b 45 10             	mov    0x10(%ebp),%eax
  801684:	01 d0                	add    %edx,%eax
  801686:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801689:	76 43                	jbe    8016ce <memmove+0x6a>
		s += n;
  80168b:	8b 45 10             	mov    0x10(%ebp),%eax
  80168e:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801691:	8b 45 10             	mov    0x10(%ebp),%eax
  801694:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801697:	eb 10                	jmp    8016a9 <memmove+0x45>
			*--d = *--s;
  801699:	ff 4d f8             	decl   -0x8(%ebp)
  80169c:	ff 4d fc             	decl   -0x4(%ebp)
  80169f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016a2:	8a 10                	mov    (%eax),%dl
  8016a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016a7:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8016a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ac:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016af:	89 55 10             	mov    %edx,0x10(%ebp)
  8016b2:	85 c0                	test   %eax,%eax
  8016b4:	75 e3                	jne    801699 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016b6:	eb 23                	jmp    8016db <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016bb:	8d 50 01             	lea    0x1(%eax),%edx
  8016be:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016c4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016c7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016ca:	8a 12                	mov    (%edx),%dl
  8016cc:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8016d1:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016d4:	89 55 10             	mov    %edx,0x10(%ebp)
  8016d7:	85 c0                	test   %eax,%eax
  8016d9:	75 dd                	jne    8016b8 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016db:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016de:	c9                   	leave  
  8016df:	c3                   	ret    

008016e0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8016e0:	55                   	push   %ebp
  8016e1:	89 e5                	mov    %esp,%ebp
  8016e3:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8016e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8016ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016ef:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8016f2:	eb 2a                	jmp    80171e <memcmp+0x3e>
		if (*s1 != *s2)
  8016f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016f7:	8a 10                	mov    (%eax),%dl
  8016f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016fc:	8a 00                	mov    (%eax),%al
  8016fe:	38 c2                	cmp    %al,%dl
  801700:	74 16                	je     801718 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801702:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801705:	8a 00                	mov    (%eax),%al
  801707:	0f b6 d0             	movzbl %al,%edx
  80170a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80170d:	8a 00                	mov    (%eax),%al
  80170f:	0f b6 c0             	movzbl %al,%eax
  801712:	29 c2                	sub    %eax,%edx
  801714:	89 d0                	mov    %edx,%eax
  801716:	eb 18                	jmp    801730 <memcmp+0x50>
		s1++, s2++;
  801718:	ff 45 fc             	incl   -0x4(%ebp)
  80171b:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80171e:	8b 45 10             	mov    0x10(%ebp),%eax
  801721:	8d 50 ff             	lea    -0x1(%eax),%edx
  801724:	89 55 10             	mov    %edx,0x10(%ebp)
  801727:	85 c0                	test   %eax,%eax
  801729:	75 c9                	jne    8016f4 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80172b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801730:	c9                   	leave  
  801731:	c3                   	ret    

00801732 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801732:	55                   	push   %ebp
  801733:	89 e5                	mov    %esp,%ebp
  801735:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801738:	8b 55 08             	mov    0x8(%ebp),%edx
  80173b:	8b 45 10             	mov    0x10(%ebp),%eax
  80173e:	01 d0                	add    %edx,%eax
  801740:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801743:	eb 15                	jmp    80175a <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801745:	8b 45 08             	mov    0x8(%ebp),%eax
  801748:	8a 00                	mov    (%eax),%al
  80174a:	0f b6 d0             	movzbl %al,%edx
  80174d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801750:	0f b6 c0             	movzbl %al,%eax
  801753:	39 c2                	cmp    %eax,%edx
  801755:	74 0d                	je     801764 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801757:	ff 45 08             	incl   0x8(%ebp)
  80175a:	8b 45 08             	mov    0x8(%ebp),%eax
  80175d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801760:	72 e3                	jb     801745 <memfind+0x13>
  801762:	eb 01                	jmp    801765 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801764:	90                   	nop
	return (void *) s;
  801765:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801768:	c9                   	leave  
  801769:	c3                   	ret    

0080176a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80176a:	55                   	push   %ebp
  80176b:	89 e5                	mov    %esp,%ebp
  80176d:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801770:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801777:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80177e:	eb 03                	jmp    801783 <strtol+0x19>
		s++;
  801780:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801783:	8b 45 08             	mov    0x8(%ebp),%eax
  801786:	8a 00                	mov    (%eax),%al
  801788:	3c 20                	cmp    $0x20,%al
  80178a:	74 f4                	je     801780 <strtol+0x16>
  80178c:	8b 45 08             	mov    0x8(%ebp),%eax
  80178f:	8a 00                	mov    (%eax),%al
  801791:	3c 09                	cmp    $0x9,%al
  801793:	74 eb                	je     801780 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801795:	8b 45 08             	mov    0x8(%ebp),%eax
  801798:	8a 00                	mov    (%eax),%al
  80179a:	3c 2b                	cmp    $0x2b,%al
  80179c:	75 05                	jne    8017a3 <strtol+0x39>
		s++;
  80179e:	ff 45 08             	incl   0x8(%ebp)
  8017a1:	eb 13                	jmp    8017b6 <strtol+0x4c>
	else if (*s == '-')
  8017a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a6:	8a 00                	mov    (%eax),%al
  8017a8:	3c 2d                	cmp    $0x2d,%al
  8017aa:	75 0a                	jne    8017b6 <strtol+0x4c>
		s++, neg = 1;
  8017ac:	ff 45 08             	incl   0x8(%ebp)
  8017af:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017b6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017ba:	74 06                	je     8017c2 <strtol+0x58>
  8017bc:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017c0:	75 20                	jne    8017e2 <strtol+0x78>
  8017c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c5:	8a 00                	mov    (%eax),%al
  8017c7:	3c 30                	cmp    $0x30,%al
  8017c9:	75 17                	jne    8017e2 <strtol+0x78>
  8017cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ce:	40                   	inc    %eax
  8017cf:	8a 00                	mov    (%eax),%al
  8017d1:	3c 78                	cmp    $0x78,%al
  8017d3:	75 0d                	jne    8017e2 <strtol+0x78>
		s += 2, base = 16;
  8017d5:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017d9:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8017e0:	eb 28                	jmp    80180a <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8017e2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017e6:	75 15                	jne    8017fd <strtol+0x93>
  8017e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017eb:	8a 00                	mov    (%eax),%al
  8017ed:	3c 30                	cmp    $0x30,%al
  8017ef:	75 0c                	jne    8017fd <strtol+0x93>
		s++, base = 8;
  8017f1:	ff 45 08             	incl   0x8(%ebp)
  8017f4:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8017fb:	eb 0d                	jmp    80180a <strtol+0xa0>
	else if (base == 0)
  8017fd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801801:	75 07                	jne    80180a <strtol+0xa0>
		base = 10;
  801803:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80180a:	8b 45 08             	mov    0x8(%ebp),%eax
  80180d:	8a 00                	mov    (%eax),%al
  80180f:	3c 2f                	cmp    $0x2f,%al
  801811:	7e 19                	jle    80182c <strtol+0xc2>
  801813:	8b 45 08             	mov    0x8(%ebp),%eax
  801816:	8a 00                	mov    (%eax),%al
  801818:	3c 39                	cmp    $0x39,%al
  80181a:	7f 10                	jg     80182c <strtol+0xc2>
			dig = *s - '0';
  80181c:	8b 45 08             	mov    0x8(%ebp),%eax
  80181f:	8a 00                	mov    (%eax),%al
  801821:	0f be c0             	movsbl %al,%eax
  801824:	83 e8 30             	sub    $0x30,%eax
  801827:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80182a:	eb 42                	jmp    80186e <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80182c:	8b 45 08             	mov    0x8(%ebp),%eax
  80182f:	8a 00                	mov    (%eax),%al
  801831:	3c 60                	cmp    $0x60,%al
  801833:	7e 19                	jle    80184e <strtol+0xe4>
  801835:	8b 45 08             	mov    0x8(%ebp),%eax
  801838:	8a 00                	mov    (%eax),%al
  80183a:	3c 7a                	cmp    $0x7a,%al
  80183c:	7f 10                	jg     80184e <strtol+0xe4>
			dig = *s - 'a' + 10;
  80183e:	8b 45 08             	mov    0x8(%ebp),%eax
  801841:	8a 00                	mov    (%eax),%al
  801843:	0f be c0             	movsbl %al,%eax
  801846:	83 e8 57             	sub    $0x57,%eax
  801849:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80184c:	eb 20                	jmp    80186e <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80184e:	8b 45 08             	mov    0x8(%ebp),%eax
  801851:	8a 00                	mov    (%eax),%al
  801853:	3c 40                	cmp    $0x40,%al
  801855:	7e 39                	jle    801890 <strtol+0x126>
  801857:	8b 45 08             	mov    0x8(%ebp),%eax
  80185a:	8a 00                	mov    (%eax),%al
  80185c:	3c 5a                	cmp    $0x5a,%al
  80185e:	7f 30                	jg     801890 <strtol+0x126>
			dig = *s - 'A' + 10;
  801860:	8b 45 08             	mov    0x8(%ebp),%eax
  801863:	8a 00                	mov    (%eax),%al
  801865:	0f be c0             	movsbl %al,%eax
  801868:	83 e8 37             	sub    $0x37,%eax
  80186b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80186e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801871:	3b 45 10             	cmp    0x10(%ebp),%eax
  801874:	7d 19                	jge    80188f <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801876:	ff 45 08             	incl   0x8(%ebp)
  801879:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80187c:	0f af 45 10          	imul   0x10(%ebp),%eax
  801880:	89 c2                	mov    %eax,%edx
  801882:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801885:	01 d0                	add    %edx,%eax
  801887:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80188a:	e9 7b ff ff ff       	jmp    80180a <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80188f:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801890:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801894:	74 08                	je     80189e <strtol+0x134>
		*endptr = (char *) s;
  801896:	8b 45 0c             	mov    0xc(%ebp),%eax
  801899:	8b 55 08             	mov    0x8(%ebp),%edx
  80189c:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80189e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018a2:	74 07                	je     8018ab <strtol+0x141>
  8018a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018a7:	f7 d8                	neg    %eax
  8018a9:	eb 03                	jmp    8018ae <strtol+0x144>
  8018ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018ae:	c9                   	leave  
  8018af:	c3                   	ret    

008018b0 <ltostr>:

void
ltostr(long value, char *str)
{
  8018b0:	55                   	push   %ebp
  8018b1:	89 e5                	mov    %esp,%ebp
  8018b3:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018bd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018c4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018c8:	79 13                	jns    8018dd <ltostr+0x2d>
	{
		neg = 1;
  8018ca:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d4:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018d7:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018da:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8018e5:	99                   	cltd   
  8018e6:	f7 f9                	idiv   %ecx
  8018e8:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8018eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ee:	8d 50 01             	lea    0x1(%eax),%edx
  8018f1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018f4:	89 c2                	mov    %eax,%edx
  8018f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018f9:	01 d0                	add    %edx,%eax
  8018fb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018fe:	83 c2 30             	add    $0x30,%edx
  801901:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801903:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801906:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80190b:	f7 e9                	imul   %ecx
  80190d:	c1 fa 02             	sar    $0x2,%edx
  801910:	89 c8                	mov    %ecx,%eax
  801912:	c1 f8 1f             	sar    $0x1f,%eax
  801915:	29 c2                	sub    %eax,%edx
  801917:	89 d0                	mov    %edx,%eax
  801919:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80191c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80191f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801924:	f7 e9                	imul   %ecx
  801926:	c1 fa 02             	sar    $0x2,%edx
  801929:	89 c8                	mov    %ecx,%eax
  80192b:	c1 f8 1f             	sar    $0x1f,%eax
  80192e:	29 c2                	sub    %eax,%edx
  801930:	89 d0                	mov    %edx,%eax
  801932:	c1 e0 02             	shl    $0x2,%eax
  801935:	01 d0                	add    %edx,%eax
  801937:	01 c0                	add    %eax,%eax
  801939:	29 c1                	sub    %eax,%ecx
  80193b:	89 ca                	mov    %ecx,%edx
  80193d:	85 d2                	test   %edx,%edx
  80193f:	75 9c                	jne    8018dd <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801941:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801948:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80194b:	48                   	dec    %eax
  80194c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80194f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801953:	74 3d                	je     801992 <ltostr+0xe2>
		start = 1 ;
  801955:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80195c:	eb 34                	jmp    801992 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80195e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801961:	8b 45 0c             	mov    0xc(%ebp),%eax
  801964:	01 d0                	add    %edx,%eax
  801966:	8a 00                	mov    (%eax),%al
  801968:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80196b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80196e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801971:	01 c2                	add    %eax,%edx
  801973:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801976:	8b 45 0c             	mov    0xc(%ebp),%eax
  801979:	01 c8                	add    %ecx,%eax
  80197b:	8a 00                	mov    (%eax),%al
  80197d:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80197f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801982:	8b 45 0c             	mov    0xc(%ebp),%eax
  801985:	01 c2                	add    %eax,%edx
  801987:	8a 45 eb             	mov    -0x15(%ebp),%al
  80198a:	88 02                	mov    %al,(%edx)
		start++ ;
  80198c:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80198f:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801992:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801995:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801998:	7c c4                	jl     80195e <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80199a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80199d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019a0:	01 d0                	add    %edx,%eax
  8019a2:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8019a5:	90                   	nop
  8019a6:	c9                   	leave  
  8019a7:	c3                   	ret    

008019a8 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8019a8:	55                   	push   %ebp
  8019a9:	89 e5                	mov    %esp,%ebp
  8019ab:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8019ae:	ff 75 08             	pushl  0x8(%ebp)
  8019b1:	e8 54 fa ff ff       	call   80140a <strlen>
  8019b6:	83 c4 04             	add    $0x4,%esp
  8019b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019bc:	ff 75 0c             	pushl  0xc(%ebp)
  8019bf:	e8 46 fa ff ff       	call   80140a <strlen>
  8019c4:	83 c4 04             	add    $0x4,%esp
  8019c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019ca:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019d8:	eb 17                	jmp    8019f1 <strcconcat+0x49>
		final[s] = str1[s] ;
  8019da:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8019e0:	01 c2                	add    %eax,%edx
  8019e2:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e8:	01 c8                	add    %ecx,%eax
  8019ea:	8a 00                	mov    (%eax),%al
  8019ec:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8019ee:	ff 45 fc             	incl   -0x4(%ebp)
  8019f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019f4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8019f7:	7c e1                	jl     8019da <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8019f9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801a00:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801a07:	eb 1f                	jmp    801a28 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a09:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a0c:	8d 50 01             	lea    0x1(%eax),%edx
  801a0f:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a12:	89 c2                	mov    %eax,%edx
  801a14:	8b 45 10             	mov    0x10(%ebp),%eax
  801a17:	01 c2                	add    %eax,%edx
  801a19:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a1f:	01 c8                	add    %ecx,%eax
  801a21:	8a 00                	mov    (%eax),%al
  801a23:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a25:	ff 45 f8             	incl   -0x8(%ebp)
  801a28:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a2b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a2e:	7c d9                	jl     801a09 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a30:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a33:	8b 45 10             	mov    0x10(%ebp),%eax
  801a36:	01 d0                	add    %edx,%eax
  801a38:	c6 00 00             	movb   $0x0,(%eax)
}
  801a3b:	90                   	nop
  801a3c:	c9                   	leave  
  801a3d:	c3                   	ret    

00801a3e <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a3e:	55                   	push   %ebp
  801a3f:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a41:	8b 45 14             	mov    0x14(%ebp),%eax
  801a44:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a4a:	8b 45 14             	mov    0x14(%ebp),%eax
  801a4d:	8b 00                	mov    (%eax),%eax
  801a4f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a56:	8b 45 10             	mov    0x10(%ebp),%eax
  801a59:	01 d0                	add    %edx,%eax
  801a5b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a61:	eb 0c                	jmp    801a6f <strsplit+0x31>
			*string++ = 0;
  801a63:	8b 45 08             	mov    0x8(%ebp),%eax
  801a66:	8d 50 01             	lea    0x1(%eax),%edx
  801a69:	89 55 08             	mov    %edx,0x8(%ebp)
  801a6c:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a72:	8a 00                	mov    (%eax),%al
  801a74:	84 c0                	test   %al,%al
  801a76:	74 18                	je     801a90 <strsplit+0x52>
  801a78:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7b:	8a 00                	mov    (%eax),%al
  801a7d:	0f be c0             	movsbl %al,%eax
  801a80:	50                   	push   %eax
  801a81:	ff 75 0c             	pushl  0xc(%ebp)
  801a84:	e8 13 fb ff ff       	call   80159c <strchr>
  801a89:	83 c4 08             	add    $0x8,%esp
  801a8c:	85 c0                	test   %eax,%eax
  801a8e:	75 d3                	jne    801a63 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801a90:	8b 45 08             	mov    0x8(%ebp),%eax
  801a93:	8a 00                	mov    (%eax),%al
  801a95:	84 c0                	test   %al,%al
  801a97:	74 5a                	je     801af3 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801a99:	8b 45 14             	mov    0x14(%ebp),%eax
  801a9c:	8b 00                	mov    (%eax),%eax
  801a9e:	83 f8 0f             	cmp    $0xf,%eax
  801aa1:	75 07                	jne    801aaa <strsplit+0x6c>
		{
			return 0;
  801aa3:	b8 00 00 00 00       	mov    $0x0,%eax
  801aa8:	eb 66                	jmp    801b10 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801aaa:	8b 45 14             	mov    0x14(%ebp),%eax
  801aad:	8b 00                	mov    (%eax),%eax
  801aaf:	8d 48 01             	lea    0x1(%eax),%ecx
  801ab2:	8b 55 14             	mov    0x14(%ebp),%edx
  801ab5:	89 0a                	mov    %ecx,(%edx)
  801ab7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801abe:	8b 45 10             	mov    0x10(%ebp),%eax
  801ac1:	01 c2                	add    %eax,%edx
  801ac3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac6:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ac8:	eb 03                	jmp    801acd <strsplit+0x8f>
			string++;
  801aca:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801acd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad0:	8a 00                	mov    (%eax),%al
  801ad2:	84 c0                	test   %al,%al
  801ad4:	74 8b                	je     801a61 <strsplit+0x23>
  801ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad9:	8a 00                	mov    (%eax),%al
  801adb:	0f be c0             	movsbl %al,%eax
  801ade:	50                   	push   %eax
  801adf:	ff 75 0c             	pushl  0xc(%ebp)
  801ae2:	e8 b5 fa ff ff       	call   80159c <strchr>
  801ae7:	83 c4 08             	add    $0x8,%esp
  801aea:	85 c0                	test   %eax,%eax
  801aec:	74 dc                	je     801aca <strsplit+0x8c>
			string++;
	}
  801aee:	e9 6e ff ff ff       	jmp    801a61 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801af3:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801af4:	8b 45 14             	mov    0x14(%ebp),%eax
  801af7:	8b 00                	mov    (%eax),%eax
  801af9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b00:	8b 45 10             	mov    0x10(%ebp),%eax
  801b03:	01 d0                	add    %edx,%eax
  801b05:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b0b:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b10:	c9                   	leave  
  801b11:	c3                   	ret    

00801b12 <malloc>:
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
  801b12:	55                   	push   %ebp
  801b13:	89 e5                	mov    %esp,%ebp
  801b15:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801b18:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1b:	c1 e8 0c             	shr    $0xc,%eax
  801b1e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  801b21:	8b 45 08             	mov    0x8(%ebp),%eax
  801b24:	25 ff 0f 00 00       	and    $0xfff,%eax
  801b29:	85 c0                	test   %eax,%eax
  801b2b:	74 03                	je     801b30 <malloc+0x1e>
			num++;
  801b2d:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  801b30:	a1 04 30 80 00       	mov    0x803004,%eax
  801b35:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801b3a:	75 73                	jne    801baf <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  801b3c:	83 ec 08             	sub    $0x8,%esp
  801b3f:	ff 75 08             	pushl  0x8(%ebp)
  801b42:	68 00 00 00 80       	push   $0x80000000
  801b47:	e8 13 05 00 00       	call   80205f <sys_allocateMem>
  801b4c:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  801b4f:	a1 04 30 80 00       	mov    0x803004,%eax
  801b54:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  801b57:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b5a:	c1 e0 0c             	shl    $0xc,%eax
  801b5d:	89 c2                	mov    %eax,%edx
  801b5f:	a1 04 30 80 00       	mov    0x803004,%eax
  801b64:	01 d0                	add    %edx,%eax
  801b66:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  801b6b:	a1 30 30 80 00       	mov    0x803030,%eax
  801b70:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b73:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
			addresses[sizeofarray]=last_addres;
  801b7a:	a1 30 30 80 00       	mov    0x803030,%eax
  801b7f:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801b85:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  801b8c:	a1 30 30 80 00       	mov    0x803030,%eax
  801b91:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801b98:	01 00 00 00 
			sizeofarray++;
  801b9c:	a1 30 30 80 00       	mov    0x803030,%eax
  801ba1:	40                   	inc    %eax
  801ba2:	a3 30 30 80 00       	mov    %eax,0x803030
			return (void*)return_addres;
  801ba7:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801baa:	e9 71 01 00 00       	jmp    801d20 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  801baf:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801bb4:	85 c0                	test   %eax,%eax
  801bb6:	75 71                	jne    801c29 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  801bb8:	a1 04 30 80 00       	mov    0x803004,%eax
  801bbd:	83 ec 08             	sub    $0x8,%esp
  801bc0:	ff 75 08             	pushl  0x8(%ebp)
  801bc3:	50                   	push   %eax
  801bc4:	e8 96 04 00 00       	call   80205f <sys_allocateMem>
  801bc9:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801bcc:	a1 04 30 80 00       	mov    0x803004,%eax
  801bd1:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801bd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bd7:	c1 e0 0c             	shl    $0xc,%eax
  801bda:	89 c2                	mov    %eax,%edx
  801bdc:	a1 04 30 80 00       	mov    0x803004,%eax
  801be1:	01 d0                	add    %edx,%eax
  801be3:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  801be8:	a1 30 30 80 00       	mov    0x803030,%eax
  801bed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801bf0:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=return_addres;
  801bf7:	a1 30 30 80 00       	mov    0x803030,%eax
  801bfc:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801bff:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801c06:	a1 30 30 80 00       	mov    0x803030,%eax
  801c0b:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801c12:	01 00 00 00 
				sizeofarray++;
  801c16:	a1 30 30 80 00       	mov    0x803030,%eax
  801c1b:	40                   	inc    %eax
  801c1c:	a3 30 30 80 00       	mov    %eax,0x803030
				return (void*)return_addres;
  801c21:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801c24:	e9 f7 00 00 00       	jmp    801d20 <malloc+0x20e>
			}
			else{
				int count=0;
  801c29:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801c30:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  801c37:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801c3e:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801c45:	eb 7c                	jmp    801cc3 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  801c47:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801c4e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801c55:	eb 1a                	jmp    801c71 <malloc+0x15f>
					{
						if(addresses[j]==i)
  801c57:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801c5a:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801c61:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801c64:	75 08                	jne    801c6e <malloc+0x15c>
						{
							index=j;
  801c66:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801c69:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801c6c:	eb 0d                	jmp    801c7b <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801c6e:	ff 45 dc             	incl   -0x24(%ebp)
  801c71:	a1 30 30 80 00       	mov    0x803030,%eax
  801c76:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801c79:	7c dc                	jl     801c57 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  801c7b:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801c7f:	75 05                	jne    801c86 <malloc+0x174>
					{
						count++;
  801c81:	ff 45 f0             	incl   -0x10(%ebp)
  801c84:	eb 36                	jmp    801cbc <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  801c86:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c89:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801c90:	85 c0                	test   %eax,%eax
  801c92:	75 05                	jne    801c99 <malloc+0x187>
						{
							count++;
  801c94:	ff 45 f0             	incl   -0x10(%ebp)
  801c97:	eb 23                	jmp    801cbc <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  801c99:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c9c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801c9f:	7d 14                	jge    801cb5 <malloc+0x1a3>
  801ca1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ca4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801ca7:	7c 0c                	jl     801cb5 <malloc+0x1a3>
							{
								min=count;
  801ca9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cac:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801caf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801cb2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  801cb5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801cbc:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801cc3:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801cca:	0f 86 77 ff ff ff    	jbe    801c47 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  801cd0:	83 ec 08             	sub    $0x8,%esp
  801cd3:	ff 75 08             	pushl  0x8(%ebp)
  801cd6:	ff 75 e4             	pushl  -0x1c(%ebp)
  801cd9:	e8 81 03 00 00       	call   80205f <sys_allocateMem>
  801cde:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  801ce1:	a1 30 30 80 00       	mov    0x803030,%eax
  801ce6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801ce9:	89 14 85 20 66 8c 00 	mov    %edx,0x8c6620(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801cf0:	a1 30 30 80 00       	mov    0x803030,%eax
  801cf5:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801cfb:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801d02:	a1 30 30 80 00       	mov    0x803030,%eax
  801d07:	c7 04 85 a0 4b 86 00 	movl   $0x1,0x864ba0(,%eax,4)
  801d0e:	01 00 00 00 
				sizeofarray++;
  801d12:	a1 30 30 80 00       	mov    0x803030,%eax
  801d17:	40                   	inc    %eax
  801d18:	a3 30 30 80 00       	mov    %eax,0x803030
				return(void*) min_addresss;
  801d1d:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801d20:	c9                   	leave  
  801d21:	c3                   	ret    

00801d22 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801d22:	55                   	push   %ebp
  801d23:	89 e5                	mov    %esp,%ebp
  801d25:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  801d28:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    uint32 size;
    int is_found=0;
  801d2e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  801d35:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801d3c:	eb 30                	jmp    801d6e <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  801d3e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d41:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801d48:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801d4b:	75 1e                	jne    801d6b <free+0x49>
  801d4d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d50:	8b 04 85 a0 4b 86 00 	mov    0x864ba0(,%eax,4),%eax
  801d57:	83 f8 01             	cmp    $0x1,%eax
  801d5a:	75 0f                	jne    801d6b <free+0x49>
    		is_found=1;
  801d5c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  801d63:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d66:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  801d69:	eb 0d                	jmp    801d78 <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    uint32 size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  801d6b:	ff 45 ec             	incl   -0x14(%ebp)
  801d6e:	a1 30 30 80 00       	mov    0x803030,%eax
  801d73:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801d76:	7c c6                	jl     801d3e <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  801d78:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801d7c:	75 3a                	jne    801db8 <free+0x96>
    	size=numOfPages[index]*PAGE_SIZE;
  801d7e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d81:	8b 04 85 20 66 8c 00 	mov    0x8c6620(,%eax,4),%eax
  801d88:	c1 e0 0c             	shl    $0xc,%eax
  801d8b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  801d8e:	83 ec 08             	sub    $0x8,%esp
  801d91:	ff 75 e4             	pushl  -0x1c(%ebp)
  801d94:	ff 75 e8             	pushl  -0x18(%ebp)
  801d97:	e8 a7 02 00 00       	call   802043 <sys_freeMem>
  801d9c:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  801d9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801da2:	c7 04 85 a0 4b 86 00 	movl   $0x0,0x864ba0(,%eax,4)
  801da9:	00 00 00 00 
    	changes++;
  801dad:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801db2:	40                   	inc    %eax
  801db3:	a3 2c 30 80 00       	mov    %eax,0x80302c
    }


	//refer to the project presentation and documentation for details
}
  801db8:	90                   	nop
  801db9:	c9                   	leave  
  801dba:	c3                   	ret    

00801dbb <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801dbb:	55                   	push   %ebp
  801dbc:	89 e5                	mov    %esp,%ebp
  801dbe:	83 ec 18             	sub    $0x18,%esp
  801dc1:	8b 45 10             	mov    0x10(%ebp),%eax
  801dc4:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801dc7:	83 ec 04             	sub    $0x4,%esp
  801dca:	68 c4 2e 80 00       	push   $0x802ec4
  801dcf:	68 9f 00 00 00       	push   $0x9f
  801dd4:	68 e7 2e 80 00       	push   $0x802ee7
  801dd9:	e8 02 eb ff ff       	call   8008e0 <_panic>

00801dde <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801dde:	55                   	push   %ebp
  801ddf:	89 e5                	mov    %esp,%ebp
  801de1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801de4:	83 ec 04             	sub    $0x4,%esp
  801de7:	68 c4 2e 80 00       	push   $0x802ec4
  801dec:	68 a5 00 00 00       	push   $0xa5
  801df1:	68 e7 2e 80 00       	push   $0x802ee7
  801df6:	e8 e5 ea ff ff       	call   8008e0 <_panic>

00801dfb <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801dfb:	55                   	push   %ebp
  801dfc:	89 e5                	mov    %esp,%ebp
  801dfe:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e01:	83 ec 04             	sub    $0x4,%esp
  801e04:	68 c4 2e 80 00       	push   $0x802ec4
  801e09:	68 ab 00 00 00       	push   $0xab
  801e0e:	68 e7 2e 80 00       	push   $0x802ee7
  801e13:	e8 c8 ea ff ff       	call   8008e0 <_panic>

00801e18 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801e18:	55                   	push   %ebp
  801e19:	89 e5                	mov    %esp,%ebp
  801e1b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e1e:	83 ec 04             	sub    $0x4,%esp
  801e21:	68 c4 2e 80 00       	push   $0x802ec4
  801e26:	68 b0 00 00 00       	push   $0xb0
  801e2b:	68 e7 2e 80 00       	push   $0x802ee7
  801e30:	e8 ab ea ff ff       	call   8008e0 <_panic>

00801e35 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801e35:	55                   	push   %ebp
  801e36:	89 e5                	mov    %esp,%ebp
  801e38:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e3b:	83 ec 04             	sub    $0x4,%esp
  801e3e:	68 c4 2e 80 00       	push   $0x802ec4
  801e43:	68 b6 00 00 00       	push   $0xb6
  801e48:	68 e7 2e 80 00       	push   $0x802ee7
  801e4d:	e8 8e ea ff ff       	call   8008e0 <_panic>

00801e52 <shrink>:
}
void shrink(uint32 newSize)
{
  801e52:	55                   	push   %ebp
  801e53:	89 e5                	mov    %esp,%ebp
  801e55:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e58:	83 ec 04             	sub    $0x4,%esp
  801e5b:	68 c4 2e 80 00       	push   $0x802ec4
  801e60:	68 ba 00 00 00       	push   $0xba
  801e65:	68 e7 2e 80 00       	push   $0x802ee7
  801e6a:	e8 71 ea ff ff       	call   8008e0 <_panic>

00801e6f <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801e6f:	55                   	push   %ebp
  801e70:	89 e5                	mov    %esp,%ebp
  801e72:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801e75:	83 ec 04             	sub    $0x4,%esp
  801e78:	68 c4 2e 80 00       	push   $0x802ec4
  801e7d:	68 bf 00 00 00       	push   $0xbf
  801e82:	68 e7 2e 80 00       	push   $0x802ee7
  801e87:	e8 54 ea ff ff       	call   8008e0 <_panic>

00801e8c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801e8c:	55                   	push   %ebp
  801e8d:	89 e5                	mov    %esp,%ebp
  801e8f:	57                   	push   %edi
  801e90:	56                   	push   %esi
  801e91:	53                   	push   %ebx
  801e92:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801e95:	8b 45 08             	mov    0x8(%ebp),%eax
  801e98:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e9b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e9e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ea1:	8b 7d 18             	mov    0x18(%ebp),%edi
  801ea4:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801ea7:	cd 30                	int    $0x30
  801ea9:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801eac:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801eaf:	83 c4 10             	add    $0x10,%esp
  801eb2:	5b                   	pop    %ebx
  801eb3:	5e                   	pop    %esi
  801eb4:	5f                   	pop    %edi
  801eb5:	5d                   	pop    %ebp
  801eb6:	c3                   	ret    

00801eb7 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801eb7:	55                   	push   %ebp
  801eb8:	89 e5                	mov    %esp,%ebp
  801eba:	83 ec 04             	sub    $0x4,%esp
  801ebd:	8b 45 10             	mov    0x10(%ebp),%eax
  801ec0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801ec3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ec7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eca:	6a 00                	push   $0x0
  801ecc:	6a 00                	push   $0x0
  801ece:	52                   	push   %edx
  801ecf:	ff 75 0c             	pushl  0xc(%ebp)
  801ed2:	50                   	push   %eax
  801ed3:	6a 00                	push   $0x0
  801ed5:	e8 b2 ff ff ff       	call   801e8c <syscall>
  801eda:	83 c4 18             	add    $0x18,%esp
}
  801edd:	90                   	nop
  801ede:	c9                   	leave  
  801edf:	c3                   	ret    

00801ee0 <sys_cgetc>:

int
sys_cgetc(void)
{
  801ee0:	55                   	push   %ebp
  801ee1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801ee3:	6a 00                	push   $0x0
  801ee5:	6a 00                	push   $0x0
  801ee7:	6a 00                	push   $0x0
  801ee9:	6a 00                	push   $0x0
  801eeb:	6a 00                	push   $0x0
  801eed:	6a 01                	push   $0x1
  801eef:	e8 98 ff ff ff       	call   801e8c <syscall>
  801ef4:	83 c4 18             	add    $0x18,%esp
}
  801ef7:	c9                   	leave  
  801ef8:	c3                   	ret    

00801ef9 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801ef9:	55                   	push   %ebp
  801efa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801efc:	8b 45 08             	mov    0x8(%ebp),%eax
  801eff:	6a 00                	push   $0x0
  801f01:	6a 00                	push   $0x0
  801f03:	6a 00                	push   $0x0
  801f05:	6a 00                	push   $0x0
  801f07:	50                   	push   %eax
  801f08:	6a 05                	push   $0x5
  801f0a:	e8 7d ff ff ff       	call   801e8c <syscall>
  801f0f:	83 c4 18             	add    $0x18,%esp
}
  801f12:	c9                   	leave  
  801f13:	c3                   	ret    

00801f14 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801f14:	55                   	push   %ebp
  801f15:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801f17:	6a 00                	push   $0x0
  801f19:	6a 00                	push   $0x0
  801f1b:	6a 00                	push   $0x0
  801f1d:	6a 00                	push   $0x0
  801f1f:	6a 00                	push   $0x0
  801f21:	6a 02                	push   $0x2
  801f23:	e8 64 ff ff ff       	call   801e8c <syscall>
  801f28:	83 c4 18             	add    $0x18,%esp
}
  801f2b:	c9                   	leave  
  801f2c:	c3                   	ret    

00801f2d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801f2d:	55                   	push   %ebp
  801f2e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 03                	push   $0x3
  801f3c:	e8 4b ff ff ff       	call   801e8c <syscall>
  801f41:	83 c4 18             	add    $0x18,%esp
}
  801f44:	c9                   	leave  
  801f45:	c3                   	ret    

00801f46 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801f46:	55                   	push   %ebp
  801f47:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801f49:	6a 00                	push   $0x0
  801f4b:	6a 00                	push   $0x0
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 00                	push   $0x0
  801f51:	6a 00                	push   $0x0
  801f53:	6a 04                	push   $0x4
  801f55:	e8 32 ff ff ff       	call   801e8c <syscall>
  801f5a:	83 c4 18             	add    $0x18,%esp
}
  801f5d:	c9                   	leave  
  801f5e:	c3                   	ret    

00801f5f <sys_env_exit>:


void sys_env_exit(void)
{
  801f5f:	55                   	push   %ebp
  801f60:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801f62:	6a 00                	push   $0x0
  801f64:	6a 00                	push   $0x0
  801f66:	6a 00                	push   $0x0
  801f68:	6a 00                	push   $0x0
  801f6a:	6a 00                	push   $0x0
  801f6c:	6a 06                	push   $0x6
  801f6e:	e8 19 ff ff ff       	call   801e8c <syscall>
  801f73:	83 c4 18             	add    $0x18,%esp
}
  801f76:	90                   	nop
  801f77:	c9                   	leave  
  801f78:	c3                   	ret    

00801f79 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801f79:	55                   	push   %ebp
  801f7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801f7c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f82:	6a 00                	push   $0x0
  801f84:	6a 00                	push   $0x0
  801f86:	6a 00                	push   $0x0
  801f88:	52                   	push   %edx
  801f89:	50                   	push   %eax
  801f8a:	6a 07                	push   $0x7
  801f8c:	e8 fb fe ff ff       	call   801e8c <syscall>
  801f91:	83 c4 18             	add    $0x18,%esp
}
  801f94:	c9                   	leave  
  801f95:	c3                   	ret    

00801f96 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801f96:	55                   	push   %ebp
  801f97:	89 e5                	mov    %esp,%ebp
  801f99:	56                   	push   %esi
  801f9a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801f9b:	8b 75 18             	mov    0x18(%ebp),%esi
  801f9e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801fa1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801fa4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  801faa:	56                   	push   %esi
  801fab:	53                   	push   %ebx
  801fac:	51                   	push   %ecx
  801fad:	52                   	push   %edx
  801fae:	50                   	push   %eax
  801faf:	6a 08                	push   $0x8
  801fb1:	e8 d6 fe ff ff       	call   801e8c <syscall>
  801fb6:	83 c4 18             	add    $0x18,%esp
}
  801fb9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801fbc:	5b                   	pop    %ebx
  801fbd:	5e                   	pop    %esi
  801fbe:	5d                   	pop    %ebp
  801fbf:	c3                   	ret    

00801fc0 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801fc0:	55                   	push   %ebp
  801fc1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801fc3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fc6:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc9:	6a 00                	push   $0x0
  801fcb:	6a 00                	push   $0x0
  801fcd:	6a 00                	push   $0x0
  801fcf:	52                   	push   %edx
  801fd0:	50                   	push   %eax
  801fd1:	6a 09                	push   $0x9
  801fd3:	e8 b4 fe ff ff       	call   801e8c <syscall>
  801fd8:	83 c4 18             	add    $0x18,%esp
}
  801fdb:	c9                   	leave  
  801fdc:	c3                   	ret    

00801fdd <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801fdd:	55                   	push   %ebp
  801fde:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801fe0:	6a 00                	push   $0x0
  801fe2:	6a 00                	push   $0x0
  801fe4:	6a 00                	push   $0x0
  801fe6:	ff 75 0c             	pushl  0xc(%ebp)
  801fe9:	ff 75 08             	pushl  0x8(%ebp)
  801fec:	6a 0a                	push   $0xa
  801fee:	e8 99 fe ff ff       	call   801e8c <syscall>
  801ff3:	83 c4 18             	add    $0x18,%esp
}
  801ff6:	c9                   	leave  
  801ff7:	c3                   	ret    

00801ff8 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801ff8:	55                   	push   %ebp
  801ff9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 00                	push   $0x0
  801fff:	6a 00                	push   $0x0
  802001:	6a 00                	push   $0x0
  802003:	6a 00                	push   $0x0
  802005:	6a 0b                	push   $0xb
  802007:	e8 80 fe ff ff       	call   801e8c <syscall>
  80200c:	83 c4 18             	add    $0x18,%esp
}
  80200f:	c9                   	leave  
  802010:	c3                   	ret    

00802011 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802011:	55                   	push   %ebp
  802012:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802014:	6a 00                	push   $0x0
  802016:	6a 00                	push   $0x0
  802018:	6a 00                	push   $0x0
  80201a:	6a 00                	push   $0x0
  80201c:	6a 00                	push   $0x0
  80201e:	6a 0c                	push   $0xc
  802020:	e8 67 fe ff ff       	call   801e8c <syscall>
  802025:	83 c4 18             	add    $0x18,%esp
}
  802028:	c9                   	leave  
  802029:	c3                   	ret    

0080202a <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80202a:	55                   	push   %ebp
  80202b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80202d:	6a 00                	push   $0x0
  80202f:	6a 00                	push   $0x0
  802031:	6a 00                	push   $0x0
  802033:	6a 00                	push   $0x0
  802035:	6a 00                	push   $0x0
  802037:	6a 0d                	push   $0xd
  802039:	e8 4e fe ff ff       	call   801e8c <syscall>
  80203e:	83 c4 18             	add    $0x18,%esp
}
  802041:	c9                   	leave  
  802042:	c3                   	ret    

00802043 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802043:	55                   	push   %ebp
  802044:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802046:	6a 00                	push   $0x0
  802048:	6a 00                	push   $0x0
  80204a:	6a 00                	push   $0x0
  80204c:	ff 75 0c             	pushl  0xc(%ebp)
  80204f:	ff 75 08             	pushl  0x8(%ebp)
  802052:	6a 11                	push   $0x11
  802054:	e8 33 fe ff ff       	call   801e8c <syscall>
  802059:	83 c4 18             	add    $0x18,%esp
	return;
  80205c:	90                   	nop
}
  80205d:	c9                   	leave  
  80205e:	c3                   	ret    

0080205f <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80205f:	55                   	push   %ebp
  802060:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802062:	6a 00                	push   $0x0
  802064:	6a 00                	push   $0x0
  802066:	6a 00                	push   $0x0
  802068:	ff 75 0c             	pushl  0xc(%ebp)
  80206b:	ff 75 08             	pushl  0x8(%ebp)
  80206e:	6a 12                	push   $0x12
  802070:	e8 17 fe ff ff       	call   801e8c <syscall>
  802075:	83 c4 18             	add    $0x18,%esp
	return ;
  802078:	90                   	nop
}
  802079:	c9                   	leave  
  80207a:	c3                   	ret    

0080207b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80207b:	55                   	push   %ebp
  80207c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80207e:	6a 00                	push   $0x0
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	6a 00                	push   $0x0
  802088:	6a 0e                	push   $0xe
  80208a:	e8 fd fd ff ff       	call   801e8c <syscall>
  80208f:	83 c4 18             	add    $0x18,%esp
}
  802092:	c9                   	leave  
  802093:	c3                   	ret    

00802094 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802094:	55                   	push   %ebp
  802095:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802097:	6a 00                	push   $0x0
  802099:	6a 00                	push   $0x0
  80209b:	6a 00                	push   $0x0
  80209d:	6a 00                	push   $0x0
  80209f:	ff 75 08             	pushl  0x8(%ebp)
  8020a2:	6a 0f                	push   $0xf
  8020a4:	e8 e3 fd ff ff       	call   801e8c <syscall>
  8020a9:	83 c4 18             	add    $0x18,%esp
}
  8020ac:	c9                   	leave  
  8020ad:	c3                   	ret    

008020ae <sys_scarce_memory>:

void sys_scarce_memory()
{
  8020ae:	55                   	push   %ebp
  8020af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8020b1:	6a 00                	push   $0x0
  8020b3:	6a 00                	push   $0x0
  8020b5:	6a 00                	push   $0x0
  8020b7:	6a 00                	push   $0x0
  8020b9:	6a 00                	push   $0x0
  8020bb:	6a 10                	push   $0x10
  8020bd:	e8 ca fd ff ff       	call   801e8c <syscall>
  8020c2:	83 c4 18             	add    $0x18,%esp
}
  8020c5:	90                   	nop
  8020c6:	c9                   	leave  
  8020c7:	c3                   	ret    

008020c8 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8020c8:	55                   	push   %ebp
  8020c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8020cb:	6a 00                	push   $0x0
  8020cd:	6a 00                	push   $0x0
  8020cf:	6a 00                	push   $0x0
  8020d1:	6a 00                	push   $0x0
  8020d3:	6a 00                	push   $0x0
  8020d5:	6a 14                	push   $0x14
  8020d7:	e8 b0 fd ff ff       	call   801e8c <syscall>
  8020dc:	83 c4 18             	add    $0x18,%esp
}
  8020df:	90                   	nop
  8020e0:	c9                   	leave  
  8020e1:	c3                   	ret    

008020e2 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8020e2:	55                   	push   %ebp
  8020e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8020e5:	6a 00                	push   $0x0
  8020e7:	6a 00                	push   $0x0
  8020e9:	6a 00                	push   $0x0
  8020eb:	6a 00                	push   $0x0
  8020ed:	6a 00                	push   $0x0
  8020ef:	6a 15                	push   $0x15
  8020f1:	e8 96 fd ff ff       	call   801e8c <syscall>
  8020f6:	83 c4 18             	add    $0x18,%esp
}
  8020f9:	90                   	nop
  8020fa:	c9                   	leave  
  8020fb:	c3                   	ret    

008020fc <sys_cputc>:


void
sys_cputc(const char c)
{
  8020fc:	55                   	push   %ebp
  8020fd:	89 e5                	mov    %esp,%ebp
  8020ff:	83 ec 04             	sub    $0x4,%esp
  802102:	8b 45 08             	mov    0x8(%ebp),%eax
  802105:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802108:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80210c:	6a 00                	push   $0x0
  80210e:	6a 00                	push   $0x0
  802110:	6a 00                	push   $0x0
  802112:	6a 00                	push   $0x0
  802114:	50                   	push   %eax
  802115:	6a 16                	push   $0x16
  802117:	e8 70 fd ff ff       	call   801e8c <syscall>
  80211c:	83 c4 18             	add    $0x18,%esp
}
  80211f:	90                   	nop
  802120:	c9                   	leave  
  802121:	c3                   	ret    

00802122 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802122:	55                   	push   %ebp
  802123:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802125:	6a 00                	push   $0x0
  802127:	6a 00                	push   $0x0
  802129:	6a 00                	push   $0x0
  80212b:	6a 00                	push   $0x0
  80212d:	6a 00                	push   $0x0
  80212f:	6a 17                	push   $0x17
  802131:	e8 56 fd ff ff       	call   801e8c <syscall>
  802136:	83 c4 18             	add    $0x18,%esp
}
  802139:	90                   	nop
  80213a:	c9                   	leave  
  80213b:	c3                   	ret    

0080213c <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80213c:	55                   	push   %ebp
  80213d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80213f:	8b 45 08             	mov    0x8(%ebp),%eax
  802142:	6a 00                	push   $0x0
  802144:	6a 00                	push   $0x0
  802146:	6a 00                	push   $0x0
  802148:	ff 75 0c             	pushl  0xc(%ebp)
  80214b:	50                   	push   %eax
  80214c:	6a 18                	push   $0x18
  80214e:	e8 39 fd ff ff       	call   801e8c <syscall>
  802153:	83 c4 18             	add    $0x18,%esp
}
  802156:	c9                   	leave  
  802157:	c3                   	ret    

00802158 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802158:	55                   	push   %ebp
  802159:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80215b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80215e:	8b 45 08             	mov    0x8(%ebp),%eax
  802161:	6a 00                	push   $0x0
  802163:	6a 00                	push   $0x0
  802165:	6a 00                	push   $0x0
  802167:	52                   	push   %edx
  802168:	50                   	push   %eax
  802169:	6a 1b                	push   $0x1b
  80216b:	e8 1c fd ff ff       	call   801e8c <syscall>
  802170:	83 c4 18             	add    $0x18,%esp
}
  802173:	c9                   	leave  
  802174:	c3                   	ret    

00802175 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802175:	55                   	push   %ebp
  802176:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802178:	8b 55 0c             	mov    0xc(%ebp),%edx
  80217b:	8b 45 08             	mov    0x8(%ebp),%eax
  80217e:	6a 00                	push   $0x0
  802180:	6a 00                	push   $0x0
  802182:	6a 00                	push   $0x0
  802184:	52                   	push   %edx
  802185:	50                   	push   %eax
  802186:	6a 19                	push   $0x19
  802188:	e8 ff fc ff ff       	call   801e8c <syscall>
  80218d:	83 c4 18             	add    $0x18,%esp
}
  802190:	90                   	nop
  802191:	c9                   	leave  
  802192:	c3                   	ret    

00802193 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802193:	55                   	push   %ebp
  802194:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802196:	8b 55 0c             	mov    0xc(%ebp),%edx
  802199:	8b 45 08             	mov    0x8(%ebp),%eax
  80219c:	6a 00                	push   $0x0
  80219e:	6a 00                	push   $0x0
  8021a0:	6a 00                	push   $0x0
  8021a2:	52                   	push   %edx
  8021a3:	50                   	push   %eax
  8021a4:	6a 1a                	push   $0x1a
  8021a6:	e8 e1 fc ff ff       	call   801e8c <syscall>
  8021ab:	83 c4 18             	add    $0x18,%esp
}
  8021ae:	90                   	nop
  8021af:	c9                   	leave  
  8021b0:	c3                   	ret    

008021b1 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8021b1:	55                   	push   %ebp
  8021b2:	89 e5                	mov    %esp,%ebp
  8021b4:	83 ec 04             	sub    $0x4,%esp
  8021b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8021ba:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8021bd:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8021c0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8021c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c7:	6a 00                	push   $0x0
  8021c9:	51                   	push   %ecx
  8021ca:	52                   	push   %edx
  8021cb:	ff 75 0c             	pushl  0xc(%ebp)
  8021ce:	50                   	push   %eax
  8021cf:	6a 1c                	push   $0x1c
  8021d1:	e8 b6 fc ff ff       	call   801e8c <syscall>
  8021d6:	83 c4 18             	add    $0x18,%esp
}
  8021d9:	c9                   	leave  
  8021da:	c3                   	ret    

008021db <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8021db:	55                   	push   %ebp
  8021dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8021de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8021e4:	6a 00                	push   $0x0
  8021e6:	6a 00                	push   $0x0
  8021e8:	6a 00                	push   $0x0
  8021ea:	52                   	push   %edx
  8021eb:	50                   	push   %eax
  8021ec:	6a 1d                	push   $0x1d
  8021ee:	e8 99 fc ff ff       	call   801e8c <syscall>
  8021f3:	83 c4 18             	add    $0x18,%esp
}
  8021f6:	c9                   	leave  
  8021f7:	c3                   	ret    

008021f8 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8021f8:	55                   	push   %ebp
  8021f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8021fb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8021fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  802201:	8b 45 08             	mov    0x8(%ebp),%eax
  802204:	6a 00                	push   $0x0
  802206:	6a 00                	push   $0x0
  802208:	51                   	push   %ecx
  802209:	52                   	push   %edx
  80220a:	50                   	push   %eax
  80220b:	6a 1e                	push   $0x1e
  80220d:	e8 7a fc ff ff       	call   801e8c <syscall>
  802212:	83 c4 18             	add    $0x18,%esp
}
  802215:	c9                   	leave  
  802216:	c3                   	ret    

00802217 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802217:	55                   	push   %ebp
  802218:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80221a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80221d:	8b 45 08             	mov    0x8(%ebp),%eax
  802220:	6a 00                	push   $0x0
  802222:	6a 00                	push   $0x0
  802224:	6a 00                	push   $0x0
  802226:	52                   	push   %edx
  802227:	50                   	push   %eax
  802228:	6a 1f                	push   $0x1f
  80222a:	e8 5d fc ff ff       	call   801e8c <syscall>
  80222f:	83 c4 18             	add    $0x18,%esp
}
  802232:	c9                   	leave  
  802233:	c3                   	ret    

00802234 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802234:	55                   	push   %ebp
  802235:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802237:	6a 00                	push   $0x0
  802239:	6a 00                	push   $0x0
  80223b:	6a 00                	push   $0x0
  80223d:	6a 00                	push   $0x0
  80223f:	6a 00                	push   $0x0
  802241:	6a 20                	push   $0x20
  802243:	e8 44 fc ff ff       	call   801e8c <syscall>
  802248:	83 c4 18             	add    $0x18,%esp
}
  80224b:	c9                   	leave  
  80224c:	c3                   	ret    

0080224d <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80224d:	55                   	push   %ebp
  80224e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802250:	8b 45 08             	mov    0x8(%ebp),%eax
  802253:	6a 00                	push   $0x0
  802255:	ff 75 14             	pushl  0x14(%ebp)
  802258:	ff 75 10             	pushl  0x10(%ebp)
  80225b:	ff 75 0c             	pushl  0xc(%ebp)
  80225e:	50                   	push   %eax
  80225f:	6a 21                	push   $0x21
  802261:	e8 26 fc ff ff       	call   801e8c <syscall>
  802266:	83 c4 18             	add    $0x18,%esp
}
  802269:	c9                   	leave  
  80226a:	c3                   	ret    

0080226b <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80226b:	55                   	push   %ebp
  80226c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80226e:	8b 45 08             	mov    0x8(%ebp),%eax
  802271:	6a 00                	push   $0x0
  802273:	6a 00                	push   $0x0
  802275:	6a 00                	push   $0x0
  802277:	6a 00                	push   $0x0
  802279:	50                   	push   %eax
  80227a:	6a 22                	push   $0x22
  80227c:	e8 0b fc ff ff       	call   801e8c <syscall>
  802281:	83 c4 18             	add    $0x18,%esp
}
  802284:	90                   	nop
  802285:	c9                   	leave  
  802286:	c3                   	ret    

00802287 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802287:	55                   	push   %ebp
  802288:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80228a:	8b 45 08             	mov    0x8(%ebp),%eax
  80228d:	6a 00                	push   $0x0
  80228f:	6a 00                	push   $0x0
  802291:	6a 00                	push   $0x0
  802293:	6a 00                	push   $0x0
  802295:	50                   	push   %eax
  802296:	6a 23                	push   $0x23
  802298:	e8 ef fb ff ff       	call   801e8c <syscall>
  80229d:	83 c4 18             	add    $0x18,%esp
}
  8022a0:	90                   	nop
  8022a1:	c9                   	leave  
  8022a2:	c3                   	ret    

008022a3 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8022a3:	55                   	push   %ebp
  8022a4:	89 e5                	mov    %esp,%ebp
  8022a6:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8022a9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8022ac:	8d 50 04             	lea    0x4(%eax),%edx
  8022af:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8022b2:	6a 00                	push   $0x0
  8022b4:	6a 00                	push   $0x0
  8022b6:	6a 00                	push   $0x0
  8022b8:	52                   	push   %edx
  8022b9:	50                   	push   %eax
  8022ba:	6a 24                	push   $0x24
  8022bc:	e8 cb fb ff ff       	call   801e8c <syscall>
  8022c1:	83 c4 18             	add    $0x18,%esp
	return result;
  8022c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8022c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8022ca:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8022cd:	89 01                	mov    %eax,(%ecx)
  8022cf:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8022d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8022d5:	c9                   	leave  
  8022d6:	c2 04 00             	ret    $0x4

008022d9 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8022d9:	55                   	push   %ebp
  8022da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8022dc:	6a 00                	push   $0x0
  8022de:	6a 00                	push   $0x0
  8022e0:	ff 75 10             	pushl  0x10(%ebp)
  8022e3:	ff 75 0c             	pushl  0xc(%ebp)
  8022e6:	ff 75 08             	pushl  0x8(%ebp)
  8022e9:	6a 13                	push   $0x13
  8022eb:	e8 9c fb ff ff       	call   801e8c <syscall>
  8022f0:	83 c4 18             	add    $0x18,%esp
	return ;
  8022f3:	90                   	nop
}
  8022f4:	c9                   	leave  
  8022f5:	c3                   	ret    

008022f6 <sys_rcr2>:
uint32 sys_rcr2()
{
  8022f6:	55                   	push   %ebp
  8022f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8022f9:	6a 00                	push   $0x0
  8022fb:	6a 00                	push   $0x0
  8022fd:	6a 00                	push   $0x0
  8022ff:	6a 00                	push   $0x0
  802301:	6a 00                	push   $0x0
  802303:	6a 25                	push   $0x25
  802305:	e8 82 fb ff ff       	call   801e8c <syscall>
  80230a:	83 c4 18             	add    $0x18,%esp
}
  80230d:	c9                   	leave  
  80230e:	c3                   	ret    

0080230f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80230f:	55                   	push   %ebp
  802310:	89 e5                	mov    %esp,%ebp
  802312:	83 ec 04             	sub    $0x4,%esp
  802315:	8b 45 08             	mov    0x8(%ebp),%eax
  802318:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80231b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80231f:	6a 00                	push   $0x0
  802321:	6a 00                	push   $0x0
  802323:	6a 00                	push   $0x0
  802325:	6a 00                	push   $0x0
  802327:	50                   	push   %eax
  802328:	6a 26                	push   $0x26
  80232a:	e8 5d fb ff ff       	call   801e8c <syscall>
  80232f:	83 c4 18             	add    $0x18,%esp
	return ;
  802332:	90                   	nop
}
  802333:	c9                   	leave  
  802334:	c3                   	ret    

00802335 <rsttst>:
void rsttst()
{
  802335:	55                   	push   %ebp
  802336:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802338:	6a 00                	push   $0x0
  80233a:	6a 00                	push   $0x0
  80233c:	6a 00                	push   $0x0
  80233e:	6a 00                	push   $0x0
  802340:	6a 00                	push   $0x0
  802342:	6a 28                	push   $0x28
  802344:	e8 43 fb ff ff       	call   801e8c <syscall>
  802349:	83 c4 18             	add    $0x18,%esp
	return ;
  80234c:	90                   	nop
}
  80234d:	c9                   	leave  
  80234e:	c3                   	ret    

0080234f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80234f:	55                   	push   %ebp
  802350:	89 e5                	mov    %esp,%ebp
  802352:	83 ec 04             	sub    $0x4,%esp
  802355:	8b 45 14             	mov    0x14(%ebp),%eax
  802358:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80235b:	8b 55 18             	mov    0x18(%ebp),%edx
  80235e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802362:	52                   	push   %edx
  802363:	50                   	push   %eax
  802364:	ff 75 10             	pushl  0x10(%ebp)
  802367:	ff 75 0c             	pushl  0xc(%ebp)
  80236a:	ff 75 08             	pushl  0x8(%ebp)
  80236d:	6a 27                	push   $0x27
  80236f:	e8 18 fb ff ff       	call   801e8c <syscall>
  802374:	83 c4 18             	add    $0x18,%esp
	return ;
  802377:	90                   	nop
}
  802378:	c9                   	leave  
  802379:	c3                   	ret    

0080237a <chktst>:
void chktst(uint32 n)
{
  80237a:	55                   	push   %ebp
  80237b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80237d:	6a 00                	push   $0x0
  80237f:	6a 00                	push   $0x0
  802381:	6a 00                	push   $0x0
  802383:	6a 00                	push   $0x0
  802385:	ff 75 08             	pushl  0x8(%ebp)
  802388:	6a 29                	push   $0x29
  80238a:	e8 fd fa ff ff       	call   801e8c <syscall>
  80238f:	83 c4 18             	add    $0x18,%esp
	return ;
  802392:	90                   	nop
}
  802393:	c9                   	leave  
  802394:	c3                   	ret    

00802395 <inctst>:

void inctst()
{
  802395:	55                   	push   %ebp
  802396:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802398:	6a 00                	push   $0x0
  80239a:	6a 00                	push   $0x0
  80239c:	6a 00                	push   $0x0
  80239e:	6a 00                	push   $0x0
  8023a0:	6a 00                	push   $0x0
  8023a2:	6a 2a                	push   $0x2a
  8023a4:	e8 e3 fa ff ff       	call   801e8c <syscall>
  8023a9:	83 c4 18             	add    $0x18,%esp
	return ;
  8023ac:	90                   	nop
}
  8023ad:	c9                   	leave  
  8023ae:	c3                   	ret    

008023af <gettst>:
uint32 gettst()
{
  8023af:	55                   	push   %ebp
  8023b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8023b2:	6a 00                	push   $0x0
  8023b4:	6a 00                	push   $0x0
  8023b6:	6a 00                	push   $0x0
  8023b8:	6a 00                	push   $0x0
  8023ba:	6a 00                	push   $0x0
  8023bc:	6a 2b                	push   $0x2b
  8023be:	e8 c9 fa ff ff       	call   801e8c <syscall>
  8023c3:	83 c4 18             	add    $0x18,%esp
}
  8023c6:	c9                   	leave  
  8023c7:	c3                   	ret    

008023c8 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8023c8:	55                   	push   %ebp
  8023c9:	89 e5                	mov    %esp,%ebp
  8023cb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023ce:	6a 00                	push   $0x0
  8023d0:	6a 00                	push   $0x0
  8023d2:	6a 00                	push   $0x0
  8023d4:	6a 00                	push   $0x0
  8023d6:	6a 00                	push   $0x0
  8023d8:	6a 2c                	push   $0x2c
  8023da:	e8 ad fa ff ff       	call   801e8c <syscall>
  8023df:	83 c4 18             	add    $0x18,%esp
  8023e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8023e5:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8023e9:	75 07                	jne    8023f2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8023eb:	b8 01 00 00 00       	mov    $0x1,%eax
  8023f0:	eb 05                	jmp    8023f7 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8023f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023f7:	c9                   	leave  
  8023f8:	c3                   	ret    

008023f9 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8023f9:	55                   	push   %ebp
  8023fa:	89 e5                	mov    %esp,%ebp
  8023fc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023ff:	6a 00                	push   $0x0
  802401:	6a 00                	push   $0x0
  802403:	6a 00                	push   $0x0
  802405:	6a 00                	push   $0x0
  802407:	6a 00                	push   $0x0
  802409:	6a 2c                	push   $0x2c
  80240b:	e8 7c fa ff ff       	call   801e8c <syscall>
  802410:	83 c4 18             	add    $0x18,%esp
  802413:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802416:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80241a:	75 07                	jne    802423 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80241c:	b8 01 00 00 00       	mov    $0x1,%eax
  802421:	eb 05                	jmp    802428 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802423:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802428:	c9                   	leave  
  802429:	c3                   	ret    

0080242a <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80242a:	55                   	push   %ebp
  80242b:	89 e5                	mov    %esp,%ebp
  80242d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802430:	6a 00                	push   $0x0
  802432:	6a 00                	push   $0x0
  802434:	6a 00                	push   $0x0
  802436:	6a 00                	push   $0x0
  802438:	6a 00                	push   $0x0
  80243a:	6a 2c                	push   $0x2c
  80243c:	e8 4b fa ff ff       	call   801e8c <syscall>
  802441:	83 c4 18             	add    $0x18,%esp
  802444:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802447:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80244b:	75 07                	jne    802454 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80244d:	b8 01 00 00 00       	mov    $0x1,%eax
  802452:	eb 05                	jmp    802459 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802454:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802459:	c9                   	leave  
  80245a:	c3                   	ret    

0080245b <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80245b:	55                   	push   %ebp
  80245c:	89 e5                	mov    %esp,%ebp
  80245e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802461:	6a 00                	push   $0x0
  802463:	6a 00                	push   $0x0
  802465:	6a 00                	push   $0x0
  802467:	6a 00                	push   $0x0
  802469:	6a 00                	push   $0x0
  80246b:	6a 2c                	push   $0x2c
  80246d:	e8 1a fa ff ff       	call   801e8c <syscall>
  802472:	83 c4 18             	add    $0x18,%esp
  802475:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802478:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80247c:	75 07                	jne    802485 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80247e:	b8 01 00 00 00       	mov    $0x1,%eax
  802483:	eb 05                	jmp    80248a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802485:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80248a:	c9                   	leave  
  80248b:	c3                   	ret    

0080248c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80248c:	55                   	push   %ebp
  80248d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80248f:	6a 00                	push   $0x0
  802491:	6a 00                	push   $0x0
  802493:	6a 00                	push   $0x0
  802495:	6a 00                	push   $0x0
  802497:	ff 75 08             	pushl  0x8(%ebp)
  80249a:	6a 2d                	push   $0x2d
  80249c:	e8 eb f9 ff ff       	call   801e8c <syscall>
  8024a1:	83 c4 18             	add    $0x18,%esp
	return ;
  8024a4:	90                   	nop
}
  8024a5:	c9                   	leave  
  8024a6:	c3                   	ret    

008024a7 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8024a7:	55                   	push   %ebp
  8024a8:	89 e5                	mov    %esp,%ebp
  8024aa:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8024ab:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8024ae:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8024b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8024b7:	6a 00                	push   $0x0
  8024b9:	53                   	push   %ebx
  8024ba:	51                   	push   %ecx
  8024bb:	52                   	push   %edx
  8024bc:	50                   	push   %eax
  8024bd:	6a 2e                	push   $0x2e
  8024bf:	e8 c8 f9 ff ff       	call   801e8c <syscall>
  8024c4:	83 c4 18             	add    $0x18,%esp
}
  8024c7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8024ca:	c9                   	leave  
  8024cb:	c3                   	ret    

008024cc <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8024cc:	55                   	push   %ebp
  8024cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8024cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8024d5:	6a 00                	push   $0x0
  8024d7:	6a 00                	push   $0x0
  8024d9:	6a 00                	push   $0x0
  8024db:	52                   	push   %edx
  8024dc:	50                   	push   %eax
  8024dd:	6a 2f                	push   $0x2f
  8024df:	e8 a8 f9 ff ff       	call   801e8c <syscall>
  8024e4:	83 c4 18             	add    $0x18,%esp
}
  8024e7:	c9                   	leave  
  8024e8:	c3                   	ret    
  8024e9:	66 90                	xchg   %ax,%ax
  8024eb:	90                   	nop

008024ec <__udivdi3>:
  8024ec:	55                   	push   %ebp
  8024ed:	57                   	push   %edi
  8024ee:	56                   	push   %esi
  8024ef:	53                   	push   %ebx
  8024f0:	83 ec 1c             	sub    $0x1c,%esp
  8024f3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8024f7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8024fb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8024ff:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802503:	89 ca                	mov    %ecx,%edx
  802505:	89 f8                	mov    %edi,%eax
  802507:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80250b:	85 f6                	test   %esi,%esi
  80250d:	75 2d                	jne    80253c <__udivdi3+0x50>
  80250f:	39 cf                	cmp    %ecx,%edi
  802511:	77 65                	ja     802578 <__udivdi3+0x8c>
  802513:	89 fd                	mov    %edi,%ebp
  802515:	85 ff                	test   %edi,%edi
  802517:	75 0b                	jne    802524 <__udivdi3+0x38>
  802519:	b8 01 00 00 00       	mov    $0x1,%eax
  80251e:	31 d2                	xor    %edx,%edx
  802520:	f7 f7                	div    %edi
  802522:	89 c5                	mov    %eax,%ebp
  802524:	31 d2                	xor    %edx,%edx
  802526:	89 c8                	mov    %ecx,%eax
  802528:	f7 f5                	div    %ebp
  80252a:	89 c1                	mov    %eax,%ecx
  80252c:	89 d8                	mov    %ebx,%eax
  80252e:	f7 f5                	div    %ebp
  802530:	89 cf                	mov    %ecx,%edi
  802532:	89 fa                	mov    %edi,%edx
  802534:	83 c4 1c             	add    $0x1c,%esp
  802537:	5b                   	pop    %ebx
  802538:	5e                   	pop    %esi
  802539:	5f                   	pop    %edi
  80253a:	5d                   	pop    %ebp
  80253b:	c3                   	ret    
  80253c:	39 ce                	cmp    %ecx,%esi
  80253e:	77 28                	ja     802568 <__udivdi3+0x7c>
  802540:	0f bd fe             	bsr    %esi,%edi
  802543:	83 f7 1f             	xor    $0x1f,%edi
  802546:	75 40                	jne    802588 <__udivdi3+0x9c>
  802548:	39 ce                	cmp    %ecx,%esi
  80254a:	72 0a                	jb     802556 <__udivdi3+0x6a>
  80254c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802550:	0f 87 9e 00 00 00    	ja     8025f4 <__udivdi3+0x108>
  802556:	b8 01 00 00 00       	mov    $0x1,%eax
  80255b:	89 fa                	mov    %edi,%edx
  80255d:	83 c4 1c             	add    $0x1c,%esp
  802560:	5b                   	pop    %ebx
  802561:	5e                   	pop    %esi
  802562:	5f                   	pop    %edi
  802563:	5d                   	pop    %ebp
  802564:	c3                   	ret    
  802565:	8d 76 00             	lea    0x0(%esi),%esi
  802568:	31 ff                	xor    %edi,%edi
  80256a:	31 c0                	xor    %eax,%eax
  80256c:	89 fa                	mov    %edi,%edx
  80256e:	83 c4 1c             	add    $0x1c,%esp
  802571:	5b                   	pop    %ebx
  802572:	5e                   	pop    %esi
  802573:	5f                   	pop    %edi
  802574:	5d                   	pop    %ebp
  802575:	c3                   	ret    
  802576:	66 90                	xchg   %ax,%ax
  802578:	89 d8                	mov    %ebx,%eax
  80257a:	f7 f7                	div    %edi
  80257c:	31 ff                	xor    %edi,%edi
  80257e:	89 fa                	mov    %edi,%edx
  802580:	83 c4 1c             	add    $0x1c,%esp
  802583:	5b                   	pop    %ebx
  802584:	5e                   	pop    %esi
  802585:	5f                   	pop    %edi
  802586:	5d                   	pop    %ebp
  802587:	c3                   	ret    
  802588:	bd 20 00 00 00       	mov    $0x20,%ebp
  80258d:	89 eb                	mov    %ebp,%ebx
  80258f:	29 fb                	sub    %edi,%ebx
  802591:	89 f9                	mov    %edi,%ecx
  802593:	d3 e6                	shl    %cl,%esi
  802595:	89 c5                	mov    %eax,%ebp
  802597:	88 d9                	mov    %bl,%cl
  802599:	d3 ed                	shr    %cl,%ebp
  80259b:	89 e9                	mov    %ebp,%ecx
  80259d:	09 f1                	or     %esi,%ecx
  80259f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8025a3:	89 f9                	mov    %edi,%ecx
  8025a5:	d3 e0                	shl    %cl,%eax
  8025a7:	89 c5                	mov    %eax,%ebp
  8025a9:	89 d6                	mov    %edx,%esi
  8025ab:	88 d9                	mov    %bl,%cl
  8025ad:	d3 ee                	shr    %cl,%esi
  8025af:	89 f9                	mov    %edi,%ecx
  8025b1:	d3 e2                	shl    %cl,%edx
  8025b3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8025b7:	88 d9                	mov    %bl,%cl
  8025b9:	d3 e8                	shr    %cl,%eax
  8025bb:	09 c2                	or     %eax,%edx
  8025bd:	89 d0                	mov    %edx,%eax
  8025bf:	89 f2                	mov    %esi,%edx
  8025c1:	f7 74 24 0c          	divl   0xc(%esp)
  8025c5:	89 d6                	mov    %edx,%esi
  8025c7:	89 c3                	mov    %eax,%ebx
  8025c9:	f7 e5                	mul    %ebp
  8025cb:	39 d6                	cmp    %edx,%esi
  8025cd:	72 19                	jb     8025e8 <__udivdi3+0xfc>
  8025cf:	74 0b                	je     8025dc <__udivdi3+0xf0>
  8025d1:	89 d8                	mov    %ebx,%eax
  8025d3:	31 ff                	xor    %edi,%edi
  8025d5:	e9 58 ff ff ff       	jmp    802532 <__udivdi3+0x46>
  8025da:	66 90                	xchg   %ax,%ax
  8025dc:	8b 54 24 08          	mov    0x8(%esp),%edx
  8025e0:	89 f9                	mov    %edi,%ecx
  8025e2:	d3 e2                	shl    %cl,%edx
  8025e4:	39 c2                	cmp    %eax,%edx
  8025e6:	73 e9                	jae    8025d1 <__udivdi3+0xe5>
  8025e8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8025eb:	31 ff                	xor    %edi,%edi
  8025ed:	e9 40 ff ff ff       	jmp    802532 <__udivdi3+0x46>
  8025f2:	66 90                	xchg   %ax,%ax
  8025f4:	31 c0                	xor    %eax,%eax
  8025f6:	e9 37 ff ff ff       	jmp    802532 <__udivdi3+0x46>
  8025fb:	90                   	nop

008025fc <__umoddi3>:
  8025fc:	55                   	push   %ebp
  8025fd:	57                   	push   %edi
  8025fe:	56                   	push   %esi
  8025ff:	53                   	push   %ebx
  802600:	83 ec 1c             	sub    $0x1c,%esp
  802603:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802607:	8b 74 24 34          	mov    0x34(%esp),%esi
  80260b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80260f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802613:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802617:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80261b:	89 f3                	mov    %esi,%ebx
  80261d:	89 fa                	mov    %edi,%edx
  80261f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802623:	89 34 24             	mov    %esi,(%esp)
  802626:	85 c0                	test   %eax,%eax
  802628:	75 1a                	jne    802644 <__umoddi3+0x48>
  80262a:	39 f7                	cmp    %esi,%edi
  80262c:	0f 86 a2 00 00 00    	jbe    8026d4 <__umoddi3+0xd8>
  802632:	89 c8                	mov    %ecx,%eax
  802634:	89 f2                	mov    %esi,%edx
  802636:	f7 f7                	div    %edi
  802638:	89 d0                	mov    %edx,%eax
  80263a:	31 d2                	xor    %edx,%edx
  80263c:	83 c4 1c             	add    $0x1c,%esp
  80263f:	5b                   	pop    %ebx
  802640:	5e                   	pop    %esi
  802641:	5f                   	pop    %edi
  802642:	5d                   	pop    %ebp
  802643:	c3                   	ret    
  802644:	39 f0                	cmp    %esi,%eax
  802646:	0f 87 ac 00 00 00    	ja     8026f8 <__umoddi3+0xfc>
  80264c:	0f bd e8             	bsr    %eax,%ebp
  80264f:	83 f5 1f             	xor    $0x1f,%ebp
  802652:	0f 84 ac 00 00 00    	je     802704 <__umoddi3+0x108>
  802658:	bf 20 00 00 00       	mov    $0x20,%edi
  80265d:	29 ef                	sub    %ebp,%edi
  80265f:	89 fe                	mov    %edi,%esi
  802661:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802665:	89 e9                	mov    %ebp,%ecx
  802667:	d3 e0                	shl    %cl,%eax
  802669:	89 d7                	mov    %edx,%edi
  80266b:	89 f1                	mov    %esi,%ecx
  80266d:	d3 ef                	shr    %cl,%edi
  80266f:	09 c7                	or     %eax,%edi
  802671:	89 e9                	mov    %ebp,%ecx
  802673:	d3 e2                	shl    %cl,%edx
  802675:	89 14 24             	mov    %edx,(%esp)
  802678:	89 d8                	mov    %ebx,%eax
  80267a:	d3 e0                	shl    %cl,%eax
  80267c:	89 c2                	mov    %eax,%edx
  80267e:	8b 44 24 08          	mov    0x8(%esp),%eax
  802682:	d3 e0                	shl    %cl,%eax
  802684:	89 44 24 04          	mov    %eax,0x4(%esp)
  802688:	8b 44 24 08          	mov    0x8(%esp),%eax
  80268c:	89 f1                	mov    %esi,%ecx
  80268e:	d3 e8                	shr    %cl,%eax
  802690:	09 d0                	or     %edx,%eax
  802692:	d3 eb                	shr    %cl,%ebx
  802694:	89 da                	mov    %ebx,%edx
  802696:	f7 f7                	div    %edi
  802698:	89 d3                	mov    %edx,%ebx
  80269a:	f7 24 24             	mull   (%esp)
  80269d:	89 c6                	mov    %eax,%esi
  80269f:	89 d1                	mov    %edx,%ecx
  8026a1:	39 d3                	cmp    %edx,%ebx
  8026a3:	0f 82 87 00 00 00    	jb     802730 <__umoddi3+0x134>
  8026a9:	0f 84 91 00 00 00    	je     802740 <__umoddi3+0x144>
  8026af:	8b 54 24 04          	mov    0x4(%esp),%edx
  8026b3:	29 f2                	sub    %esi,%edx
  8026b5:	19 cb                	sbb    %ecx,%ebx
  8026b7:	89 d8                	mov    %ebx,%eax
  8026b9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8026bd:	d3 e0                	shl    %cl,%eax
  8026bf:	89 e9                	mov    %ebp,%ecx
  8026c1:	d3 ea                	shr    %cl,%edx
  8026c3:	09 d0                	or     %edx,%eax
  8026c5:	89 e9                	mov    %ebp,%ecx
  8026c7:	d3 eb                	shr    %cl,%ebx
  8026c9:	89 da                	mov    %ebx,%edx
  8026cb:	83 c4 1c             	add    $0x1c,%esp
  8026ce:	5b                   	pop    %ebx
  8026cf:	5e                   	pop    %esi
  8026d0:	5f                   	pop    %edi
  8026d1:	5d                   	pop    %ebp
  8026d2:	c3                   	ret    
  8026d3:	90                   	nop
  8026d4:	89 fd                	mov    %edi,%ebp
  8026d6:	85 ff                	test   %edi,%edi
  8026d8:	75 0b                	jne    8026e5 <__umoddi3+0xe9>
  8026da:	b8 01 00 00 00       	mov    $0x1,%eax
  8026df:	31 d2                	xor    %edx,%edx
  8026e1:	f7 f7                	div    %edi
  8026e3:	89 c5                	mov    %eax,%ebp
  8026e5:	89 f0                	mov    %esi,%eax
  8026e7:	31 d2                	xor    %edx,%edx
  8026e9:	f7 f5                	div    %ebp
  8026eb:	89 c8                	mov    %ecx,%eax
  8026ed:	f7 f5                	div    %ebp
  8026ef:	89 d0                	mov    %edx,%eax
  8026f1:	e9 44 ff ff ff       	jmp    80263a <__umoddi3+0x3e>
  8026f6:	66 90                	xchg   %ax,%ax
  8026f8:	89 c8                	mov    %ecx,%eax
  8026fa:	89 f2                	mov    %esi,%edx
  8026fc:	83 c4 1c             	add    $0x1c,%esp
  8026ff:	5b                   	pop    %ebx
  802700:	5e                   	pop    %esi
  802701:	5f                   	pop    %edi
  802702:	5d                   	pop    %ebp
  802703:	c3                   	ret    
  802704:	3b 04 24             	cmp    (%esp),%eax
  802707:	72 06                	jb     80270f <__umoddi3+0x113>
  802709:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80270d:	77 0f                	ja     80271e <__umoddi3+0x122>
  80270f:	89 f2                	mov    %esi,%edx
  802711:	29 f9                	sub    %edi,%ecx
  802713:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802717:	89 14 24             	mov    %edx,(%esp)
  80271a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80271e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802722:	8b 14 24             	mov    (%esp),%edx
  802725:	83 c4 1c             	add    $0x1c,%esp
  802728:	5b                   	pop    %ebx
  802729:	5e                   	pop    %esi
  80272a:	5f                   	pop    %edi
  80272b:	5d                   	pop    %ebp
  80272c:	c3                   	ret    
  80272d:	8d 76 00             	lea    0x0(%esi),%esi
  802730:	2b 04 24             	sub    (%esp),%eax
  802733:	19 fa                	sbb    %edi,%edx
  802735:	89 d1                	mov    %edx,%ecx
  802737:	89 c6                	mov    %eax,%esi
  802739:	e9 71 ff ff ff       	jmp    8026af <__umoddi3+0xb3>
  80273e:	66 90                	xchg   %ax,%ax
  802740:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802744:	72 ea                	jb     802730 <__umoddi3+0x134>
  802746:	89 d9                	mov    %ebx,%ecx
  802748:	e9 62 ff ff ff       	jmp    8026af <__umoddi3+0xb3>
